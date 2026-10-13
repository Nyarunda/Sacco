report 50578 "Send Loan SMSs"
{
    DefaultLayout = RDLC;
    Caption = 'Loan Reminder SMS';
    RDLCLayout = './src/Layouts/Send Loan SMSs.rdlc';

    dataset
    {
        dataitem("Loans Register"; Loans)
        {
            CalcFields = "Outstanding Principal";
            DataItemTableView = where(Posted = filter(true));
            RequestFilterFields = "Loan No.", "Member No.";
            column(ClientCode_LoansRegister; "Loans Register"."Member No.") { }
            column(ClientName_LoansRegister; "Loans Register"."member Name") { }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount") { }
            column(MobilePhoneNo; MobilePhoneNo) { }
            column(SMSMessage; SMSMessage) { }
            column(LoanNo_LoansRegister; "Loans Register"."Loan No.") { }
            column(Pname; Pname) { }
            column(Totalinsurance; Totalinsurance) { }
            column(TotalOutInt; TotalOutInt) { }
            column(arrears; arrears) { }
            column(TotalRepayment; TotalRepayment) { }
            column(ArrearsRepayment; ArrearsRepayment) { }

            trigger OnPreDataItem()
            begin
                NextInstallment := 0;
            end;

            trigger OnAfterGetRecord()
            var
                LoanSetup: Record "Product Setup";
                RSchedule: Record "Loan Repayment Schedule";
                RepayEndDate: Date;
                CurrMonthText: Text;
            begin
                MobilePhoneNo := '';
                EmailSMS := '';
                NextInstallment := 0;
                DateOfPenalty := CalcDate('<14D>', CalcDate('<-CM>', Today));
                LoanIsExpired := false;
                arrears := 0;
                Totalinsurance := 0;
                TotalOutInt := 0;
                TotalRepayment := 0;
                ArrearsRepayment := 0;
                NewPenaltyOutstanding := 0;
                CurrMonthExpected := 0;

                if IsExcludedMember("Loans Register"."Member No.") then
                    CurrReport.Skip();
                if "Loans Register"."Member No." = ' ' then
                    CurrReport.Skip();

                "Loans Register".CalcFields("Outstanding Principal", "Outstanding Interest");

                if "Loans Register"."Outstanding Principal" + "Loans Register"."Outstanding Interest" <= 0 then
                    CurrReport.Skip();

                if LoanSetup.Get("Loans Register"."Loan Product Type") then
                    Pname := LoanSetup.Description;

                if MembersReg.Get("Loans Register"."Member No.") then
                    MobilePhoneNo := MembersReg."Mobile Phone No.";

                // Find repayment window from schedule
                RepayStartDate := 0D;
                Schedule.Reset();
                Schedule.SetRange("Loan No.", "Loans Register"."Loan No.");
                Schedule.SetFilter("Monthly Repayment", '>%1', 0);
                if Schedule.FindFirst() then
                    RepayStartDate := Schedule."Repayment Date";

                RepayEndDate := 0D;
                RSchedule.Reset();
                RSchedule.SetRange("Loan No.", "Loans Register"."Loan No.");
                if RSchedule.FindLast() then
                    RepayEndDate := RSchedule."Repayment Date";

                if RepayStartDate > AsAt then
                    CurrReport.Skip();

                CurrMonthEndDate := CalcDate('<CM>', AsAt);
                StartDateMonth := CalcDate('<-CM>', CurrMonthEndDate);
                CurrmonthStartDate := StartDateMonth;

                CalculateLoanDatasetAmounts();

                // Two days before month end: send payment reminder
                if AsAt = CalcDate('<-2D>', CurrMonthEndDate) then begin
                    ProcessEndOfMonthReminder();
                end else
                    if Date2DMY(AsAt, 1) = 10 then // On the 10th: send arrears notification for previous month
                        ProcessTenthOfMonthArrears(RepayEndDate);

                if ArrearsRepayment < 0 then
                    ArrearsRepayment := 0;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(SendSms; SendSms) { ApplicationArea = all; }
                field(AsAt; AsAt) { ApplicationArea = all; }
            }
        }
    }

    var
        MembersReg: Record Members;
        SMSMessages: Record "SMS Messages";
        Rshedule: Record "Loan Repayment Schedule";
        Schedule: Record "Loan Repayment Schedule";
        Ledger: Record "Credit Ledger Entry";
        MActivities: Codeunit "Member Activities";
        AsAt: Date;
        CurrMonthEndDate: Date;
        StartDateMonth: Date;
        CurrmonthStartDate: Date;
        RepayStartDate: Date;
        DateOfPenalty: Date;
        NextInstallment: Integer;
        NextInstallmenttxt: Text;
        EndMonthDay: Integer;
        EndMonth_Month: Integer;
        EndMonth_Year: Integer;
        EndMonth_Monthtxt: Text;
        arrears: Decimal;
        TotalRepayment: Decimal;
        ArrearsRepayment: Decimal;
        CurrMonthExpected: Decimal;
        TotalOutInt: Decimal;
        Totalinsurance: Decimal;
        NewPenaltyOutstanding: Decimal;
        MobilePhoneNo: Code[40];
        SMSMessage: Text;
        EmailSMS: Text;
        Pname: Text;
        SendSms: Boolean;
        LoanIsExpired: Boolean;
        Source: Enum "SMS Source Enum";

    trigger OnPreReport()
    begin
        if AsAt = 0D then
            AsAt := Today;
    end;

    local procedure CalculateLoanDatasetAmounts()
    var
        SActivities: Codeunit "Sacco Activities";
        LoansReg: Record Loans;
        RepaymentSchedule: Record "Loan Repayment Schedule";
        ExpectedBal: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        GracePeriod: DateFormula;
        InterestPaid: Decimal;
        InsurancePaid: Decimal;
        PenaltyPaid: Decimal;
    begin
        SActivities.GetDefaultedAmount("Loans Register"."Loan No.", AsAt, ExpectedBal, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, GracePeriod);

        ArrearsRepayment := MaxDec(DefAmount, 0);

        LoansReg.Reset();
        LoansReg.SetRange("Loan No.", "Loans Register"."Loan No.");
        LoansReg.SetFilter("Date Filter", '..%1', AsAt);
        if LoansReg.FindFirst() then begin
            LoansReg.CalcFields("Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty");
            TotalOutInt := LoansReg."Outstanding Interest";
            Totalinsurance := LoansReg."Outstanding Insurance";
            NewPenaltyOutstanding := LoansReg."Outstanding Penalty";
        end;

        InterestPaid := SumLedgerEntries("Loans Register"."Loan No.", Ledger."Transaction Type"::"Interest Paid", StartDateMonth, AsAt);
        InsurancePaid := SumLedgerEntries("Loans Register"."Loan No.", Ledger."Transaction Type"::"Insurance Paid", StartDateMonth, AsAt);
        PenaltyPaid := SumLedgerEntries("Loans Register"."Loan No.", Ledger."Transaction Type"::"Penalty Paid", StartDateMonth, AsAt);

        TotalOutInt := MaxDec(TotalOutInt - InterestPaid, 0);
        Totalinsurance := MaxDec(Totalinsurance - InsurancePaid, 0);
        NewPenaltyOutstanding := MaxDec(NewPenaltyOutstanding - PenaltyPaid, 0);

        RepaymentSchedule.Reset();
        RepaymentSchedule.SetRange("Loan No.", "Loans Register"."Loan No.");
        RepaymentSchedule.SetRange("Repayment Date", StartDateMonth, CurrMonthEndDate);
        if RepaymentSchedule.FindSet() then
            repeat
                TotalRepayment += RepaymentSchedule."Monthly Principal" +
                    RepaymentSchedule."Monthly Interest" +
                    RepaymentSchedule."Insurance Contribution" +
                    RepaymentSchedule."Deposit Amount";
            until RepaymentSchedule.Next() = 0;

        if TotalRepayment <= 0 then
            TotalRepayment := FnMonthlyRepayment("Loans Register"."Loan No.");

        arrears := ArrearsRepayment + TotalOutInt + Totalinsurance + NewPenaltyOutstanding + GetMonthlyDepositAmount("Loans Register"."Loan No.");

        arrears := Round(MaxDec(arrears, 0), 0.05);
    end;


    local procedure ProcessEndOfMonthReminder()
    var
        MemberReg: Record Members;
    begin
        CurrMonthExpected := 0;
        CalcCurrMonthExpected();
        CalcCurrMonthPayment();  // result checked inline below via CurrMonthPayment local

        if (CurrMonthExpected <= 0) and ("Loans Register"."Outstanding Principal" <= 0) then
            CurrReport.Skip();
        if (CurrMonthExpected <= 0) and ("Loans Register"."Outstanding Principal" > 0) then
            CurrMonthExpected := "Loans Register"."Outstanding Principal";

        CalcCurrMonthPayment();
        if CurrMonthExpected <= 0 then
            CurrReport.Skip();

        LoadMemberName();
        SMSMessage :=
            'Dear ' + MActivities.GetMemberFirstName(MembersReg.Name) +
            ' This is a polite reminder to pay your ' + Pname +
            ' Instalment for the month of ' + MonthText(Date2DMY(CurrMonthEndDate, 2)) +
            ' ' + Format(Date2DMY(CurrMonthEndDate, 3)) +
            '. KINDLY IGNORE IF YOU HAVE PAID.';

        MemberReg.Reset();
        MemberReg.SetRange("No.", "Loans Register"."Member No.");
        MemberReg.SetFilter("Mobile Phone No.", '<>%1', '');
        if MemberReg.Find('-') then
            if SendSms then
                MActivities.SendSms(Source::"Loan Reminder", MemberReg."Mobile Phone No.", SMSMessage, "Loans Register"."Member No.", "Loans Register"."Loan No.", false, false);
    end;

    local procedure ProcessTenthOfMonthArrears(RepayEndDate: Date)
    var
        PrevMonthEnd: Date;
        SActivities: Codeunit "Sacco Activities";
        ExpectedBal: Decimal;
        DefAmount: Decimal;
        AmtPaid: Decimal;
        DaysInArrear: Integer;
        GracePeriod: DateFormula;
    begin
        PrevMonthEnd := CalcDate('<CM>', CalcDate('<-1M>', CalcDate('<CM>', AsAt)));
        CurrMonthEndDate := PrevMonthEnd;
        StartDateMonth := CalcDate('<-1M>', PrevMonthEnd);
        CurrmonthStartDate := CalcDate('<1D>', PrevMonthEnd);

        EndMonthDay := Date2DMY(PrevMonthEnd, 1);
        EndMonth_Month := Date2DMY(PrevMonthEnd, 2);
        EndMonth_Year := Date2DMY(PrevMonthEnd, 3);
        EndMonth_Monthtxt := MonthShortText(EndMonth_Month);

        NextInstallment := EndMonth_Month + 1;
        if NextInstallment > 12 then NextInstallment := 1;
        NextInstallmenttxt := MonthText(NextInstallment);

        if RepayStartDate > AsAt then
            CurrReport.Skip();

        // Calculate principal arrears
        SActivities.GetDefaultedAmount("Loans Register"."Loan No.", AsAt, ExpectedBal, AmtPaid, DefAmount, DaysInArrear, RepayEndDate, true, GracePeriod);

        arrears := DefAmount;

        if arrears < 0 then arrears := 0;

        ArrearsRepayment := arrears;

        // Add outstanding charges (interest, insurance, penalty)
        CalcOutstandingChargesOnTenth();

        arrears := Round(arrears, 0.05);

        if arrears < 100 then  // minimum arrears threshold
            CurrReport.Skip();

        // Skip if arrears are less than half the monthly principal — not worth notifying
        if arrears < FnMonthlyRepayment("Loans Register"."Loan No.") then
            CurrReport.Skip();

        LoadMemberName();
        BuildAndSendTenthNotification(PrevMonthEnd);
    end;

    local procedure CalcOutstandingChargesOnTenth()
    var
        LoansReg: Record Loans;
        ToalIntPaidCurrMonth: Decimal;
        TotalInsurancePaidCurrMonth: Decimal;
        TotalPenaltyPaidCurrMonth: Decimal;
        CurrMonthEnd: Date;
    begin
        CurrMonthEnd := CalcDate('<CM>', AsAt);

        LoansReg.Reset();
        LoansReg.SetRange("Loan No.", "Loans Register"."Loan No.");
        LoansReg.SetFilter("Date Filter", '..%1', CurrMonthEndDate);
        if LoansReg.Find('-') then
            LoansReg.CalcFields("Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty");

        TotalOutInt := LoansReg."Outstanding Interest";
        Totalinsurance := LoansReg."Outstanding Insurance";
        NewPenaltyOutstanding := LoansReg."Outstanding Penalty";

        ToalIntPaidCurrMonth := SumLedgerEntries("Loans Register"."Loan No.", Ledger."Transaction Type"::"Interest Paid", CurrmonthStartDate, CurrMonthEnd);
        TotalInsurancePaidCurrMonth := SumLedgerEntries("Loans Register"."Loan No.", Ledger."Transaction Type"::"Insurance Paid", CurrmonthStartDate, CurrMonthEnd);
        TotalPenaltyPaidCurrMonth := SumLedgerEntries("Loans Register"."Loan No.", Ledger."Transaction Type"::"Penalty Paid", CurrmonthStartDate, CurrMonthEnd);

        TotalOutInt := MaxDec(TotalOutInt - ToalIntPaidCurrMonth, 0);
        Totalinsurance := MaxDec(Totalinsurance - TotalInsurancePaidCurrMonth, 0);
        NewPenaltyOutstanding := MaxDec(NewPenaltyOutstanding - TotalPenaltyPaidCurrMonth, 0);

        // Accumulate unpaid charges into arrears
        if TotalOutInt > 0 then arrears += TotalOutInt;
        if Totalinsurance > 0 then arrears += Totalinsurance;
        if NewPenaltyOutstanding > 0 then arrears += NewPenaltyOutstanding;  // was a bug: previously added TotalPenaltyPaidCurrMonth here

        // Add savings contribution due this month
        arrears += GetMonthlyDepositAmount("Loans Register"."Loan No.");
    end;

    local procedure SumLedgerEntries(LoanNo: Code[20]; TransType: Enum "Transaction Type Enum"; FromDate: Date; ToDate: Date): Decimal
    var
        LedgerEntry: Record "Credit Ledger Entry";
        Total: Decimal;
    begin
        LedgerEntry.Reset();
        LedgerEntry.SetRange("Loan No.", LoanNo);
        LedgerEntry.SetRange("Transaction Type", TransType);
        LedgerEntry.SetRange(Reversed, false);
        LedgerEntry.SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
        if LedgerEntry.Find('-') then
            repeat
                Total += LedgerEntry."Amount (LCY)" * -1;
            until LedgerEntry.Next() = 0;
        exit(Total);
    end;

    local procedure CalcCurrMonthExpected()
    begin
        Rshedule.Reset();
        Rshedule.SetRange("Loan No.", "Loans Register"."Loan No.");
        Rshedule.SetFilter("Repayment Date", '%1..%2', StartDateMonth, CurrMonthEndDate);
        if Rshedule.Find('-') then
            repeat
                CurrMonthExpected += Rshedule."Monthly Principal" + Rshedule."Insurance Contribution" + Rshedule."Deposit Amount";
            until Rshedule.Next() = 0;

        // No schedule rows means the loan schedule has ended
        if CurrMonthExpected = 0 then
            LoanIsExpired := not Rshedule.FindFirst();

        CurrMonthExpected += FnGetLoadedInterest("Loans Register"."Loan No.", StartDateMonth, CurrMonthEndDate);
        CurrMonthExpected += FnGetLoadedPenalty("Loans Register"."Loan No.", StartDateMonth, CurrMonthEndDate);
    end;

    local procedure CalcCurrMonthPayment()
    var
        CurrMonthPayment: Decimal;
    begin
        Ledger.Reset();
        Ledger.SetRange("Loan No.", "Loans Register"."Loan No.");
        Ledger.SetRange("Transaction Type", Ledger."Transaction Type"::"Principal Repayment");
        Ledger.SetFilter("Posting Date", '%1..%2', StartDateMonth, CurrMonthEndDate);
        Ledger.SetFilter(Amount, '<%1', 0);
        if Ledger.Find('-') then
            repeat
                CurrMonthPayment += Ledger.Amount * -1;
            until Ledger.Next() = 0;

        // Skip if member has already paid something this month
        if CurrMonthPayment > 0 then
            CurrReport.Skip();
    end;

    local procedure BuildAndSendTenthNotification(PrevMonthEnd: Date)
    var
        MemberFirstName: Text;
        NextInstDueDate: Date;
        MemberReg: Record Members;
    begin
        MemberFirstName := MActivities.GetMemberFirstName(MembersReg.Name);
        NextInstDueDate := CalcDate('<CM>', CalcDate('<1M>', PrevMonthEnd));

        if ("Loans Register"."Outstanding Principal" <= 0) or LoanIsExpired then begin
            if LoanIsExpired then
                arrears := FnGetTotalArrearsOnExpiredLoans("Loans Register"."Loan No.", "Loans Register"."Member No.");

            SMSMessage := CopyStr(
                'Dear ' + MemberFirstName + ',Your ' + "Loans Register"."Loan Product Type" +
                ' loan is overdue by Ksh.' + Format(arrears) +
                ' as of ' + Format(EndMonthDay) + ' ' + EndMonth_Monthtxt + ' ' + Format(EndMonth_Year) + '.' +
                ' If payment is not received by ' + Format(DateOfPenalty) +
                ',a penalty of 5% of your principle loan installment will be incurred.', 1, 250);

            EmailSMS :=
                '<p>Dear ' + MemberFirstName + ',<b></b></p>' +
                '<p>Your ' + "Loans Register"."Loan Product Type Name" +
                ' loan is overdue by Ksh.' + Format(arrears) +
                ' as of ' + Format(EndMonthDay) + ' ' + EndMonth_Monthtxt + ' ' + Format(EndMonth_Year) + '.</p>' +
                '<p>If payment is not received by ' + Format(DateOfPenalty) +
                ',a penalty of 5% of your principle loan installment will be incurred.</p>';
        end else begin
            if ArrearsRepayment <= 0 then CurrReport.Skip();

            SMSMessage := CopyStr(
                'Dear ' + MemberFirstName + ',Your ' + "Loans Register"."Loan Product Type" +
                ' loan is overdue by Ksh.' + Format(arrears) +
                ' as of ' + Format(EndMonthDay) + ' ' + EndMonth_Monthtxt + ' ' + Format(EndMonth_Year) + '.' +
                ' If payment is not received by ' + Format(DateOfPenalty) +
                ',a penalty of 5% of your principle loan installment will be incurred.' +
                'Your ' + NextInstallmenttxt + ' installment of Ksh. ' +
                Format(Round(CurrMonthExpected, 0.01, '>')) + ' is due by ' + Format(NextInstDueDate) + '.', 1, 250);

            EmailSMS :=
                '<p>Dear ' + MemberFirstName + ',<b></b></p>' +
                '<p>Your ' + "Loans Register"."Loan Product Type" +
                ' loan is overdue by Ksh.' + Format(arrears) +
                ' as of ' + Format(EndMonthDay) + ' ' + EndMonth_Monthtxt + ' ' + Format(EndMonth_Year) + '.</p>' +
                '<p>If payment is not received by ' + Format(DateOfPenalty) +
                ',a penalty of 5% of your principle loan installment will be incurred.</p>' +
                '<p>Your ' + NextInstallmenttxt + ' installment of Ksh. ' +
                Format(Round(CurrMonthExpected, 0.01, '>')) + ' is due by ' + Format(NextInstDueDate) + '.</p>';
        end;

        if arrears <= 0 then exit;

        if not SendSms then exit;

        MemberReg.Reset();
        MemberReg.SetRange("No.", "Loans Register"."Member No.");
        if MemberReg.Find('-') then
            if not MemberReg."Exempt Send SMS" then
                MActivities.SendSms(Source::"Loan Reminder", MemberReg."Mobile Phone No.", SMSMessage, "Loans Register"."Member No.", "Loans Register"."Loan No.", false, false);
    end;

    local procedure FnMonthlyRepayment(LoanNo: Code[50]): Decimal
    var
        LoansReg: Record Loans;
        RepaymentSch: Record "Loan Repayment Schedule";
    begin
        LoansReg.SetRange("Loan No.", LoanNo);
        if not LoansReg.Find('-') then exit(0);
        LoansReg.CalcFields("Outstanding Principal");
        if LoansReg."Outstanding Principal" <= 0 then exit(0);

        RepaymentSch.SetRange("Loan No.", LoanNo);
        RepaymentSch.SetFilter("Monthly Repayment", '>%1', 0);
        if RepaymentSch.Find('-') then
            exit(RepaymentSch."Monthly Principal" / 2);

        exit(0);
    end;

    local procedure FnGetLoadedInterest(LoanNo: Code[50]; FromDate: Date; ToDate: Date): Decimal
    var
        LoansTable: Record Loans;
    begin
        LoansTable.SetRange("Loan No.", LoanNo);
        if not LoansTable.Find('-') then exit(0);
        LoansTable.SetFilter("Date filter", '%1..%2', FromDate, ToDate);
        LoansTable.CalcFields("Interest Due");
        exit(LoansTable."Interest Due");
    end;

    local procedure FnGetLoadedPenalty(LoanNo: Code[50]; FromDate: Date; ToDate: Date): Decimal
    var
        LoansTable: Record Loans;
    begin
        LoansTable.SetRange("Loan No.", LoanNo);
        if not LoansTable.Find('-') then exit(0);
        LoansTable.SetFilter("Date filter", '%1..%2', FromDate, ToDate);
        LoansTable.CalcFields("Outstanding Penalty");
        exit(LoansTable."Outstanding Penalty");
    end;

    local procedure FnGetTotalArrearsOnExpiredLoans(LoanNo: Code[50]; MemberNo: Code[50]): Decimal
    var
        LoansT: Record Loans;
    begin
        LoansT.SetRange("Loan No.", LoanNo);
        if not LoansT.Find('-') then exit(0);
        LoansT.CalcFields("Total Outstanding Balance");
        exit(LoansT."Total Outstanding Balance");
    end;

    local procedure GetMonthlyDepositAmount(LoanNo: Code[50]): Decimal
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        LoanRepaymentSchedule.SetRange("Loan No.", LoanNo);
        LoanRepaymentSchedule.SetFilter("Monthly Repayment", '>%1', 0);
        if LoanRepaymentSchedule.FindFirst() then
            exit(LoanRepaymentSchedule."Deposit Amount");
        exit(0);
    end;

    local procedure LoadMemberName()
    begin
        MembersReg.Reset();
        MembersReg.SetRange("No.", "Loans Register"."Member No.");
        MembersReg.Find('-');
        // MActivities.GetMemberFirstName is used downstream for display; this ensures MembersReg.Name is fresh
    end;

    local procedure IsExcludedMember(MemberNo: Code[20]): Boolean
    var
        Members: Record Members;
    begin
        if Members.Get(MemberNo) then
            exit(Members."Exempt Send SMS");
    end;

    local procedure MonthText(MonthNo: Integer): Text
    begin
        case MonthNo of
            1:
                exit('January');
            2:
                exit('February');
            3:
                exit('March');
            4:
                exit('April');
            5:
                exit('May');
            6:
                exit('June');
            7:
                exit('July');
            8:
                exit('August');
            9:
                exit('September');
            10:
                exit('October');
            11:
                exit('November');
            12:
                exit('December');
        end;
    end;

    local procedure MonthShortText(MonthNo: Integer): Text
    begin
        case MonthNo of
            1:
                exit('Jan');
            2:
                exit('Feb');
            3:
                exit('Mar');
            4:
                exit('Apr');
            5:
                exit('May');
            6:
                exit('Jun');
            7:
                exit('Jul');
            8:
                exit('Aug');
            9:
                exit('Sept');
            10:
                exit('Oct');
            11:
                exit('Nov');
            12:
                exit('Dec');
        end;
    end;

    local procedure MaxDec(Value: Decimal; MinValue: Decimal): Decimal
    begin
        if Value < MinValue then exit(MinValue);
        exit(Value);
    end;
}
