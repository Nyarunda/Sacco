report 50543 "Generate Monthly Advice_"
{
    ApplicationArea = All;
    Caption = 'Generate Monthly Advice';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(MonthlyAdviceHeader; "Monthly Advice Header")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(No; "No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }
            column(StartDate; "Start Date")
            {
            }
            column(EndDate; "End Date")
            {
            }
            column(Description; Description)
            {
            }
            trigger onpredataItem()
            var
                myInt: Integer;
            begin

            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                StartDate := "Start Date";
                EndDate := "End Date";
                MonthlyCheckoffAdvice("No.", "Employer Code")
            end;



            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }


    var
        Employer: Record Customer;
        StartDate: Date;
        EndDate: Date;
        Memb: Record Members;
        Loans: Record Loans;
        MemberActivities: Codeunit "Member Activities";
        SaccoActivities: Codeunit "Sacco Activities";
        AsAt: Date;
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        RSchedule: Record "Loan Repayment Schedule";
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;

    /// <summary>
    /// MonthlyCheckoffAdvice.
    /// </summary>
    /// <param name="HeaderNo">Code[20].</param>
    /// <param name="EmpCode">Code[20].</param>
    procedure MonthlyCheckoffAdvice(HeaderNo: Code[20]; EmpCode: Code[20])
    var
        Loans: Record Loans;
        LRec: Record Loans;
        LSchedule: Record "Loan Repayment Schedule";
        Employer: Record Customer;
        iEntryNo: Integer;
        SavingsAccounts: Record "Savings Accounts";
        Memb: Record Members;
        InterestAmount: Decimal;
        Mdays: Integer;
        CheckoffLoan: Boolean;
        CheckoffAdvice: Record "Monthly Advice";
        MHeader: Record "Monthly Advice Header";
        PSetup: Record "Product Setup";
        SaccoSetup: Record "Sacco Setup";
        VLedger: Record "Savings Ledger Entry";
        j: Integer;
        Amt: Decimal;
        EmployerFroup: Record "Employer Group";
        GracePeriod: DateFormula;
    begin

        if (Employer.Get(EmpCode)) or (EmpCode = '') then begin
            if EmpCode <> '' then
                if Employer."Advice Method" = Employer."advice method"::" " then
                    Error('Kindly Specify Employer Advice Type');


            //Delete Records
            CheckoffAdvice.Reset;
            CheckoffAdvice.SetRange("Advice Header No.", HeaderNo);
            if CheckoffAdvice.Find('-') then begin
                CheckoffAdvice.DeleteAll;
            end;

            EmployerFroup.Reset();
            EmployerFroup.SetRange("Advice No.", HeaderNo);
            if EmployerFroup.FindSet() then
                repeat
                    CheckoffAdvice.Reset;
                    CheckoffAdvice.SetRange("Employer Code", EmployerFroup."Employer Code");
                    CheckoffAdvice.SetRange("Advice Header No.", HeaderNo);
                    if CheckoffAdvice.Find('-') then begin
                        CheckoffAdvice.DeleteAll;
                    end;
                until EmployerFroup.Next() = 0;

            AsAt := StartDate - 1;
            MHeader.get(HeaderNo);

            EmployerFroup.Reset();
            EmployerFroup.SetRange("Advice No.", HeaderNo);
            EmployerFroup.SetFilter("Employer Code", '<>%1', '');
            if EmployerFroup.FindSet() then begin
                repeat
                    If (MHeader."Advice Type" = MHeader."Advice Type"::"Full Advice") or (MHeader."Advice Type" = MHeader."Advice Type"::Loans) or (MHeader."Advice Type" = MHeader."Advice Type"::"New Loans") then begin

                        Loans.Reset;
                        Loans.SetRange("Employer Code", EmployerFroup."Employer Code");
                        if MHeader."Advice Type" = MHeader."Advice Type"::"New Loans" then
                            Loans.SetRange("Disbursement Date", StartDate, EndDate)
                        else
                            Loans.SetFilter("Disbursement Date", '..%1', EndDate);
                        Loans.SetFilter(Loans."Total Outstanding Balance", '>0');
                        Loans.SetRange("Repay Mode", Loans."Repay Mode"::"Check Off");
                        if Loans.Find('-') then begin
                            dWindow.Open('Generating Advice:                  #1#########\'
                                                + 'Total Loans:              #2#########\'
                                                + 'Counter:                    #3#########\'
                                                + 'Progress:                   @4@@@@@@@@@\'
                                                + 'Press Esc to abort');


                            NoOfRecords := Loans.Count;
                            repeat
                                dWindow.Update(2, NoOfRecords);
                                dWindow.Update(1, Loans."Member Name");
                                CurrentRecordNo += 1;
                                dWindow.Update(3, CurrentRecordNo);
                                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                                Psetup.Get(Loans."Loan Product Type");


                                Memb.Get(Loans."Member No.");
                                if (Memb."Member Status" <> Memb."Member Status"::Closed) and (Memb."Member Status" <> Memb."Member Status"::Deceased) then begin

                                    CheckoffLoan := false;
                                    Loans.CalcFields("Schedule Interest", "Schedule Principal");
                                    Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Appraisal", "Total Outstanding Balance");

                                    ExpectedAmt := 0;
                                    AmtPaid := 0;
                                    DefAmount := 0;
                                    DaysInArrear := 0;
                                    ArrearsDate := 0D;

                                    //SaccoActivities.GetDefaultedAmount(Loans."Loan No.", CalcDate('-CM', EndDate), ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePeriod);

                                    CheckoffAdvice.Init;
                                    //CheckoffAdvice."No." := iEntryNo;
                                    CheckoffAdvice."Advice Header No." := HeaderNo;
                                    CheckoffAdvice."Account No." := Loans."Member No.";
                                    CheckoffAdvice."Product Type" := Loans."Loan Product Type";
                                    CheckoffAdvice."Product Name" := Loans."Loan Product Type Name";
                                    CheckoffAdvice.Validate("Product Type");
                                    CheckoffAdvice."Loan No." := Loans."Loan No.";
                                    CheckoffAdvice."ID No." := Memb."ID No.";
                                    CheckoffAdvice."Member No." := Loans."Member No.";
                                    CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                    CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                    CheckoffAdvice.Name := Memb.Name;
                                    CheckoffAdvice."Principal Arrears" := 0;
                                    CheckoffAdvice."Sort Order" := CheckoffAdvice."Member No." + '-01';
                                    CheckoffAdvice."Schedule Balance" := Loans."Schedule Interest" + Loans."Schedule Principal";
                                    CheckoffAdvice."Principal Arrears" := DefAmount;

                                    //Loans.TestField(Repayment);
                                    if Loans."Outstanding Appraisal" > 0 then
                                        CheckoffAdvice.Appraisal := Loans."Outstanding Appraisal";

                                    if Loans."Outstanding Penalty" > 0 then
                                        CheckoffAdvice.Penalty := Loans."Outstanding Penalty";

                                    if Loans."Mobile Loan" then begin
                                        LSchedule.Reset();
                                        LSchedule.SetRange("Loan No.", Loans."Loan No.");
                                        if LSchedule.FindFirst() then begin
                                            LSchedule.CalcSums("Monthly Principal", "Monthly Interest");
                                            CheckoffAdvice.Principal := LSchedule."Monthly Principal" / Loans.Installments;
                                            CheckoffAdvice.Interest := LSchedule."Monthly Interest" / Loans.Installments;
                                        end;
                                    end else begin


                                        CheckoffAdvice.Principal := Loans."Loan Principle Repayment";
                                        CheckoffAdvice.Interest := Loans."Loan Interest Repayment";

                                    end;

                                    CheckoffAdvice.Principal := SaccoActivities.SmartRound(CheckoffAdvice.Principal);
                                    CheckoffAdvice.Interest := SaccoActivities.SmartRound(CheckoffAdvice.Interest);

                                    /* if CheckoffAdvice.Interest > Loans."Outstanding Interest" then
                                        CheckoffAdvice.Interest := SaccoActivities.SmartRound(Loans."Outstanding Interest");

                                    if CheckoffAdvice.Principal > Loans."Outstanding Principal" then
                                        CheckoffAdvice.Principal := SaccoActivities.SmartRound(Loans."Outstanding Principal"); */


                                    CheckoffAdvice.Amount := SaccoActivities.SmartRound(CheckoffAdvice.Principal + CheckoffAdvice.Interest);

                                    if CheckoffAdvice.Amount > Loans."Total Outstanding Balance" then
                                        CheckoffAdvice.Amount := Loans."Total Outstanding Balance";

                                    if Loans."Adjusted Repayment" > 0 then begin
                                        CheckoffAdvice.Amount := Loans."Adjusted Repayment";
                                        CheckoffAdvice.Principal := CheckoffAdvice.Amount - CheckoffAdvice.Interest;
                                    end;

                                    if CheckoffAdvice."Advice Type" = CheckoffAdvice."Advice Type"::"New Loans" then
                                        CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"New Loans";
                                    CheckoffAdvice."Loan Period" := Loans.Installments;

                                    CheckoffAdvice."Amount On" := CheckoffAdvice.Amount;
                                    CheckoffAdvice."Amount Off" := 0;

                                    CheckoffAdvice."Advice Date" := EndDate;
                                    CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                    CheckoffAdvice."Loan Balance" := CheckoffAdvice."Schedule Balance"; //Loans."Total Outstanding Balance";

                                    if Employer."Advice Method" = Employer."advice method"::Everything then
                                        CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                                    else
                                        if Employer."Advice Method" = Employer."advice method"::Changes then
                                            CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;

                                    case PSetup."Loan Source" of
                                        Psetup."Loan Source"::BOSA:
                                            begin
                                                CheckoffAdvice."Advice Source" := CheckoffAdvice."Advice Source"::"Wanandege Bosa Loans";
                                                CheckoffAdvice.Description := 'BOSA Consolidation';
                                            end;
                                        Psetup."Loan Source"::FOSA:
                                            begin
                                                CheckoffAdvice."Advice Source" := CheckoffAdvice."Advice Source"::"Wanandege Fosa Loans";
                                                CheckoffAdvice.Description := 'FOSA Consolidation';
                                            end;
                                    end;

                                    if MHeader."Loan Source" <> MHeader."Loan Source"::" " then begin

                                        PSetup.Get(Loans."Loan Product Type");
                                        if MHeader."Loan Source" = MHeader."Loan Source"::BOSA then
                                            If PSetup."Loan Source" <> PSetup."Loan Source"::BOSA then
                                                CheckoffAdvice.Amount := 0;
                                        if MHeader."Loan Source" = MHeader."Loan Source"::FOSA then
                                            If PSetup."Loan Source" <> PSetup."Loan Source"::FOSA then
                                                CheckoffAdvice.Amount := 0;
                                        if MHeader."Loan Source" = MHeader."Loan Source"::MICRO then
                                            If PSetup."Loan Source" <> PSetup."Loan Source"::MICRO then
                                                CheckoffAdvice.Amount := 0;
                                    end;

                                    if CheckoffAdvice.Amount > 0 then begin

                                        CheckoffAdvice.Insert;

                                    end;

                                end;

                            until Loans.Next = 0;

                            dWindow.Close();

                        end;

                    end;

                    If (MHeader."Advice Type" = MHeader."Advice Type"::"Full Advice") or (MHeader."Advice Type" = MHeader."Advice Type"::Savings) then begin

                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange("Employer Code", EmployerFroup."Employer Code");
                        SavingsAccounts.SetFilter("Product Category", '<>%1&<>%2&<>%3&<>%4&<>%5',
                            SavingsAccounts."product category"::"Share Capital",
                            SavingsAccounts."product category"::"Registration Fee",
                            SavingsAccounts."product category"::"Unallocated Fund",
                            SavingsAccounts."product category"::"Fixed Deposit",
                            SavingsAccounts."product category"::"Dividend Account"
                        );
                        SavingsAccounts.SetRange("Repay Mode", SavingsAccounts."Repay Mode"::"Check Off");
                        SavingsAccounts.SetFilter("Monthly Contribution", '>0');
                        if SavingsAccounts.Find('-') then begin
                            dWindow.Open('Generating Advice:                  #1#########\'
                                                + 'Total Members:              #2#########\'
                                                + 'Counter:                    #3#########\'
                                                + 'Progress:                   @4@@@@@@@@@\'
                                                + 'Press Esc to abort');

                            NoOfRecords := SavingsAccounts.Count;
                            repeat
                                dWindow.Update(2, NoOfRecords);
                                dWindow.Update(1, SavingsAccounts."Name");
                                CurrentRecordNo += 1;
                                dWindow.Update(3, CurrentRecordNo);
                                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                                Memb.Get(SavingsAccounts."Member No.");
                                if (Memb."Member Status" <> Memb."Member Status"::Closed) and (Memb."Member Status" <> Memb."Member Status"::Deceased) then begin

                                    SavingsAccounts.CalcFields("Balance (LCY)");
                                    PSetup.Get(SavingsAccounts."Product Type");

                                    iEntryNo := 0;
                                    CheckoffAdvice.Reset;
                                    if CheckoffAdvice.Find('+') then
                                        iEntryNo := CheckoffAdvice."No.";

                                    iEntryNo += 1;

                                    Amt := 0;
                                    Amt := SavingsAccounts."Monthly Contribution";
                                    //if Amt = 0 then
                                    //    Amt := GetDepositContribution(SavingsAccounts."No.", Memb."Member Class");//SavingsAccounts."Monthly Contribution";

                                    CheckoffAdvice.Init;
                                    //CheckoffAdvice."No." := iEntryNo;
                                    CheckoffAdvice."Advice Header No." := HeaderNo;
                                    CheckoffAdvice."Account No." := SavingsAccounts."No.";
                                    CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
                                    CheckoffAdvice.Validate("Product Type");
                                    CheckoffAdvice."Product Name" := SavingsAccounts."Product Name";
                                    CheckoffAdvice."Loan No." := '';
                                    CheckoffAdvice."ID No." := Memb."ID No.";
                                    CheckoffAdvice."Member No." := Memb."No.";
                                    CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                    CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                    CheckoffAdvice.Name := Memb.Name;
                                    CheckoffAdvice."Advice Source" := CheckoffAdvice."Advice Source"::"Wanandege Deposit Savings";
                                    CheckoffAdvice.Description := 'BOSA Consolidation';

                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Balance Adjustments") then
                                        CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Savings Balance Adjustments";
                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Adjustments") then
                                        CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Savings Adjustments";
                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"New Savings") then
                                        CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"New Savings";

                                    CheckoffAdvice."Advice Date" := EndDate;
                                    CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                    CheckoffAdvice."Amount Off" := SavingsAccounts."Old Amount";
                                    CheckoffAdvice."Amount On" := Amt; //SavingsAccounts."Monthly Contribution";
                                    CheckoffAdvice.Amount := Amt; //SavingsAccounts."Monthly Contribution";
                                    CheckoffAdvice."Change Balance" := SavingsAccounts."Change Balance";
                                    CheckoffAdvice."Current Balance" := SavingsAccounts."Current Balance";
                                    CheckoffAdvice."Cummulative Contribution" := SavingsAccounts."Cummulative Contribution";


                                    if Employer."Advice Method" = Employer."advice method"::Everything then
                                        CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                                    else
                                        if Employer."Advice Method" = Employer."advice method"::Changes then
                                            CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;

                                    if (MHeader."Advice Type" = MHeader."Advice Type"::"Full Advice") or (MHeader."Advice Type" = MHeader."Advice Type"::Savings) then begin
                                        CheckoffAdvice.Insert;
                                    end
                                    else begin


                                        If (MHeader."Advice Type" = MHeader."Advice Type"::"New Savings") then begin
                                            if CheckoffAdvice."Amount Off" = 0 then begin
                                                if CheckoffAdvice.Amount > 0 then
                                                    CheckoffAdvice.Insert;
                                            end;
                                        end;


                                        If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Adjustments") then begin
                                            if CheckoffAdvice."Amount Off" > 0 then begin
                                                if CheckoffAdvice.Amount > 0 then
                                                    CheckoffAdvice.Insert;
                                            end;
                                        end;

                                        If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Balance Adjustments") then begin
                                            if CheckoffAdvice."Change Balance" <> 0 then begin
                                                CheckoffAdvice.Insert;
                                            end;
                                        end;

                                    end;


                                end;

                            until SavingsAccounts.Next = 0;

                            dWindow.Close();
                        end;

                    end;
                until EmployerFroup.Next() = 0;
            end else begin
                If (MHeader."Advice Type" = MHeader."Advice Type"::"Full Advice") or (MHeader."Advice Type" = MHeader."Advice Type"::Loans) or (MHeader."Advice Type" = MHeader."Advice Type"::"New Loans") then begin

                    Loans.Reset;
                    if EmpCode <> '' then
                        Loans.SetRange("Employer Code", EmpCode);
                    if MHeader."Advice Type" = MHeader."Advice Type"::"New Loans" then
                        Loans.SetRange("Disbursement Date", StartDate, EndDate)
                    else
                        Loans.SetFilter("Disbursement Date", '..%1', EndDate);
                    Loans.SetFilter(Loans."Total Outstanding Balance", '>0');
                    Loans.SetRange("Repay Mode", Loans."Repay Mode"::"Check Off");
                    if Loans.Find('-') then begin
                        dWindow.Open('Generating Advice:                  #1#########\'
                                            + 'Total Loans:              #2#########\'
                                            + 'Counter:                    #3#########\'
                                            + 'Progress:                   @4@@@@@@@@@\'
                                            + 'Press Esc to abort');


                        NoOfRecords := Loans.Count;
                        repeat
                            dWindow.Update(2, NoOfRecords);
                            dWindow.Update(1, Loans."Member Name");
                            CurrentRecordNo += 1;
                            dWindow.Update(3, CurrentRecordNo);
                            dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                            Psetup.Get(Loans."Loan Product Type");

                            Memb.Get(Loans."Member No.");
                            if (Memb."Member Status" <> Memb."Member Status"::Closed) and (Memb."Member Status" <> Memb."Member Status"::Deceased) then begin

                                CheckoffLoan := false;
                                Loans.CalcFields("Schedule Interest", "Schedule Principal");
                                Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Appraisal", "Total Outstanding Balance");

                                ExpectedAmt := 0;
                                AmtPaid := 0;
                                DefAmount := 0;
                                DaysInArrear := 0;
                                ArrearsDate := 0D;

                                //SaccoActivities.GetDefaultedAmount(Loans."Loan No.", CalcDate('-CM-1D', EndDate), ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePeriod);

                                CheckoffAdvice.Init;
                                //CheckoffAdvice."No." := iEntryNo;
                                CheckoffAdvice."Advice Header No." := HeaderNo;
                                CheckoffAdvice."Account No." := Loans."Member No.";
                                CheckoffAdvice."Product Type" := Loans."Loan Product Type";
                                CheckoffAdvice."Product Name" := Loans."Loan Product Type Name";
                                CheckoffAdvice.Validate("Product Type");
                                CheckoffAdvice."Loan No." := Loans."Loan No.";
                                CheckoffAdvice."ID No." := Memb."ID No.";
                                CheckoffAdvice."Member No." := Loans."Member No.";
                                CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                CheckoffAdvice.Name := Memb.Name;
                                CheckoffAdvice."Principal Arrears" := 0;
                                CheckoffAdvice."Sort Order" := CheckoffAdvice."Member No." + '-01';
                                CheckoffAdvice."Schedule Balance" := Loans."Schedule Interest" + Loans."Schedule Principal";
                                //CheckoffAdvice."Principal Arrears" := DefAmount;

                                //Loans.TestField(Repayment);
                                if Loans."Outstanding Appraisal" > 0 then
                                    CheckoffAdvice.Appraisal := Loans."Outstanding Appraisal";

                                if Loans."Outstanding Penalty" > 0 then
                                    CheckoffAdvice.Penalty := Loans."Outstanding Penalty";

                                //CheckoffAdvice."Interest Arrears" := Loans."Outstanding Interest";
                                //CheckoffAdvice."Principal Arrears" := DefAmount; //Loans."Principal Arrears";


                                CheckoffAdvice.Principal := Loans."Loan Principle Repayment";
                                CheckoffAdvice.Interest := Loans."Loan Interest Repayment";

                                /* if CheckoffAdvice.Interest > Loans."Outstanding Interest" then
                                    CheckoffAdvice.Interest := Loans."Outstanding Interest";
 */
                                //CheckoffAdvice.Principal := Round(Loans."Loan Principle Repayment", 1, '>');

                                /* if CheckoffAdvice.Principal > Loans."Outstanding Principal" then
                                    CheckoffAdvice.Principal := Loans."Outstanding Principal"; */

                                CheckoffAdvice.Amount := CheckoffAdvice.Principal + CheckoffAdvice.Interest;

                                if CheckoffAdvice.Amount > Loans."Total Outstanding Balance" then
                                    CheckoffAdvice.Amount := Loans."Total Outstanding Balance";

                                if Loans."Adjusted Repayment" > 0 then begin
                                    CheckoffAdvice.Amount := Loans."Adjusted Repayment";
                                    CheckoffAdvice.Principal := CheckoffAdvice.Amount - CheckoffAdvice.Interest;
                                end;


                                CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"New Loans";
                                CheckoffAdvice."Loan Period" := Loans.Installments;

                                CheckoffAdvice."Amount On" := CheckoffAdvice.Amount;
                                CheckoffAdvice."Amount Off" := 0;

                                CheckoffAdvice."Advice Date" := EndDate;
                                CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                CheckoffAdvice."Loan Balance" := CheckoffAdvice."Schedule Balance";// Loans."Total Outstanding Balance";
                                PSetup.Get(Loans."Loan Product Type");
                                case PSetup."Loan Source" of
                                    Psetup."Loan Source"::BOSA:
                                        begin
                                            CheckoffAdvice."Advice Source" := CheckoffAdvice."Advice Source"::"Wanandege Bosa Loans";
                                            CheckoffAdvice.Description := 'BOSA Consolidation';
                                        end;
                                    Psetup."Loan Source"::FOSA:
                                        begin
                                            CheckoffAdvice."Advice Source" := CheckoffAdvice."Advice Source"::"Wanandege Fosa Loans";
                                            CheckoffAdvice.Description := 'FOSA Consolidation';
                                        end;
                                end;


                                if Employer."Advice Method" = Employer."advice method"::Everything then
                                    CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                                else
                                    if Employer."Advice Method" = Employer."advice method"::Changes then
                                        CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;


                                if MHeader."Loan Source" <> MHeader."Loan Source"::" " then begin

                                    PSetup.Get(Loans."Loan Product Type");
                                    if MHeader."Loan Source" = MHeader."Loan Source"::BOSA then
                                        If PSetup."Loan Source" <> PSetup."Loan Source"::BOSA then
                                            CheckoffAdvice.Amount := 0;
                                    if MHeader."Loan Source" = MHeader."Loan Source"::FOSA then
                                        If PSetup."Loan Source" <> PSetup."Loan Source"::FOSA then
                                            CheckoffAdvice.Amount := 0;
                                    if MHeader."Loan Source" = MHeader."Loan Source"::MICRO then
                                        If PSetup."Loan Source" <> PSetup."Loan Source"::MICRO then
                                            CheckoffAdvice.Amount := 0;
                                end;



                                if CheckoffAdvice.Amount > 0 then begin

                                    CheckoffAdvice.Insert;

                                end;

                            end;

                        until Loans.Next = 0;

                        dWindow.Close();

                    end;

                end;

                If (MHeader."Advice Type" = MHeader."Advice Type"::"Full Advice") or (MHeader."Advice Type" = MHeader."Advice Type"::Savings) then begin

                    SavingsAccounts.Reset;
                    if EmpCode <> '' then
                        SavingsAccounts.SetRange("Employer Code", EmpCode);
                    SavingsAccounts.SetFilter("Product Category", '<>%1&<>%2&<>%3&<>%4&<>%5',
                              SavingsAccounts."product category"::"Share Capital",
                              SavingsAccounts."product category"::"Registration Fee",
                              SavingsAccounts."product category"::"Unallocated Fund",
                              SavingsAccounts."product category"::"Fixed Deposit",
                              SavingsAccounts."product category"::"Dividend Account"
                          );
                    SavingsAccounts.SetRange("Repay Mode", SavingsAccounts."Repay Mode"::"Check Off");
                    SavingsAccounts.SetFilter("Monthly Contribution", '>0');
                    if SavingsAccounts.Find('-') then begin
                        dWindow.Open('Generating Advice:                  #1#########\'
                                            + 'Total Members:              #2#########\'
                                            + 'Counter:                    #3#########\'
                                            + 'Progress:                   @4@@@@@@@@@\'
                                            + 'Press Esc to abort');

                        NoOfRecords := SavingsAccounts.Count;
                        repeat
                            dWindow.Update(2, NoOfRecords);
                            dWindow.Update(1, SavingsAccounts."Name");
                            CurrentRecordNo += 1;
                            dWindow.Update(3, CurrentRecordNo);
                            dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                            Memb.Get(SavingsAccounts."Member No.");
                            if (Memb."Member Status" <> Memb."Member Status"::Closed) and (Memb."Member Status" <> Memb."Member Status"::Deceased) then begin

                                SavingsAccounts.CalcFields("Balance (LCY)");
                                PSetup.Get(SavingsAccounts."Product Type");

                                iEntryNo := 0;
                                CheckoffAdvice.Reset;
                                if CheckoffAdvice.Find('+') then
                                    iEntryNo := CheckoffAdvice."No.";

                                iEntryNo += 1;

                                Amt := 0;
                                Amt := SavingsAccounts."Monthly Contribution";
                                //if Amt = 0 then
                                //   Amt := GetDepositContribution(SavingsAccounts."No.", Memb."Member Class");//PSetup."Mandatory Contribution";                                

                                CheckoffAdvice.Init;
                                //CheckoffAdvice."No." := iEntryNo;
                                CheckoffAdvice."Advice Header No." := HeaderNo;
                                CheckoffAdvice."Account No." := SavingsAccounts."No.";
                                CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
                                CheckoffAdvice.Validate("Product Type");
                                CheckoffAdvice."Product Name" := SavingsAccounts."Product Name";
                                CheckoffAdvice."Loan No." := '';
                                CheckoffAdvice."ID No." := Memb."ID No.";
                                CheckoffAdvice."Member No." := Memb."No.";
                                CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                CheckoffAdvice.Name := Memb.Name;
                                CheckoffAdvice."Advice Source" := CheckoffAdvice."Advice Source"::"Wanandege Deposit Savings";
                                CheckoffAdvice.Description := 'Deposit Consolidation';

                                If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Balance Adjustments") then
                                    CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Savings Balance Adjustments";
                                If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Adjustments") then
                                    CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Savings Adjustments";
                                If (MHeader."Advice Type" = MHeader."Advice Type"::"New Savings") then
                                    CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"New Savings";

                                CheckoffAdvice."Advice Date" := EndDate;
                                CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                CheckoffAdvice."Amount Off" := SavingsAccounts."Old Amount";
                                CheckoffAdvice."Amount On" := Amt; //SavingsAccounts."Monthly Contribution";
                                CheckoffAdvice.Amount := Amt; //SavingsAccounts."Monthly Contribution";
                                CheckoffAdvice."Change Balance" := SavingsAccounts."Change Balance";
                                CheckoffAdvice."Current Balance" := SavingsAccounts."Current Balance";
                                CheckoffAdvice."Cummulative Contribution" := SavingsAccounts."Cummulative Contribution";

                                if Employer."Advice Method" = Employer."advice method"::Everything then
                                    CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                                else
                                    if Employer."Advice Method" = Employer."advice method"::Changes then
                                        CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;

                                if (MHeader."Advice Type" = MHeader."Advice Type"::"Full Advice") then begin
                                    CheckoffAdvice.Insert;
                                end
                                else begin


                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"New Savings") then begin
                                        if CheckoffAdvice."Amount Off" = 0 then begin
                                            if CheckoffAdvice.Amount > 0 then
                                                CheckoffAdvice.Insert;
                                        end;
                                    end;


                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Adjustments") then begin
                                        if CheckoffAdvice."Amount Off" > 0 then begin
                                            if CheckoffAdvice.Amount > 0 then
                                                CheckoffAdvice.Insert;
                                        end;
                                    end;

                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Balance Adjustments") then begin
                                        if CheckoffAdvice."Change Balance" <> 0 then begin
                                            CheckoffAdvice.Insert;
                                        end;
                                    end;

                                end;


                            end;

                        until SavingsAccounts.Next = 0;

                        dWindow.Close();
                    end;

                end;
            end;
        end;
    end;



    procedure GetDepositContribution(AccNo: Code[20]; Class: Text[20]) DepAmt: Decimal;
    var
        Advice: Record "Monthly Checkoff Lines";
        Savings: Record "Savings Accounts";
        ChkHeader: Record "Monthly Checkoff Header";
        Classes: Record "Member Class";
    begin
        DepAmt := 0;
        if Classes.Get(Class) then;
        Savings.Get(AccNo);
        case Savings."Product Category" of

            Savings."Product Category"::"Deposit Contribution":
                DepAmt := Classes."Default Share Deposits";
            Savings."Product Category"::"Share Capital":
                DepAmt := Classes."Default Share Capital";

        end;

        exit(DepAmt);

    end;
}
