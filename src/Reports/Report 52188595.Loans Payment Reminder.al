
Report 50258 "Loans Payment Reminder"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true), "Repay Mode" = filter(<> "Check Off" | <> Salary));
            //"Mobile Loan" = const(true));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                msg1: Label 'Dear %1, Your %2 repayment of Ksh %3 is DUE on %4. TO PAY DIAL *882# OR *645# GO TO OPTION 3 (LOANS) THEN OPTION 2 (LOAN REPAYMENT) AND FOLLOW PROMPTS.';
                msg2: Label 'Dear %1, Your %2 repayment of Ksh %3 is OVERDUE. Make IMMEDIATE PAYMENTS to avoid CRB listing. TO PAY DIAL *882# OR *645# GO TO OPTION 3 (LOANS) THEN OPTION 2 (LOAN REPYMENT) AND FOLLOW PROMPTS.';
                DefaulterNotifications: Codeunit "Custom Notifications";
            begin
                if Loans.Posted = false then CurrReport.Skip;
                Loans.CalcFields("Outstanding Principal");

                if Loans."Outstanding Principal" > 0 then begin
                    //FOR NO REPAYMENT DONE FOR THE MONTH
                    LRS.Reset;
                    LRS.SetRange(LRS."Loan No.", Loans."Loan No.");
                    LRS.SetRange(LRS."Repayment Date", CalcDate('1D', Today));
                    if LRS.Find('-') then begin
                        LLE.Reset;
                        LLE.SetRange(LLE."Loan No.", Loans."Loan No.");
                        LLE.SetFilter(LLE."Transaction Type", '=%1|=%2', LLE."transaction type"::"Principal Repayment", LLE."transaction type"::"Interest Paid");
                        LLE.SetRange(LLE."Posting Date", CalcDate('-CM', Today), Today);
                        if not LLE.Find('-') then begin
                            NameString := '';
                            NameString := Loans."Member Name";
                            String1 := '';
                            String2 := '';
                            String1 := Token(NameString, ' ');
                            String2 := Token(NameString, ' ');

                            Member.Reset;
                            Member.SetRange(Member."No.", Loans."Member No.");
                            if Member.Find('-') then begin
                                if Member."Mobile Phone No." <> '' then begin
                                    Msg := STRSUBSTNO(msg1, String1, Loans."Loan Product Type Name", FORMAT(Loans.Repayment), Format(LRS."Repayment Date"));
                                    MemberActivities.SendSms(Smssource::"Loan Bill Due", Member."Mobile Phone No.", Msg, Member."No.", Loans."Loan No.", false, false);
                                end;
                            end;
                        end;
                    end;
                    //END NO REPAYMENT

                    //FOR 3 DAYS NOTICE ON PENALTY
                    LRS.Reset;
                    LRS.SetRange(LRS."Loan No.", Loans."Loan No.");
                    LRS.SetRange(LRS."Repayment Date", CalcDate('-7D', Today));
                    if LRS.Find('-') then begin
                        LLE.Reset;
                        LLE.SetRange(LLE."Loan No.", Loans."Loan No.");
                        LLE.SetFilter(LLE."Transaction Type", '=%1|=%2', LLE."transaction type"::"Principal Repayment", LLE."transaction type"::"Interest Paid");
                        LLE.SetRange(LLE."Posting Date", CalcDate('-CM', LRS."Repayment Date"), Today);
                        if not LLE.Find('-') then begin
                            NameString := '';
                            NameString := Loans."Member Name";
                            String1 := '';
                            String2 := '';
                            String1 := Token(NameString, ' ');
                            String2 := Token(NameString, ' ');

                            Member.Reset;
                            Member.SetRange(Member."No.", Loans."Member No.");
                            if Member.Find('-') then begin
                                if Member."Mobile Phone No." <> '' then begin
                                    //
                                    Msg := STRSUBSTNO(msg2, String1, Loans."Loan Product Type Name", FORMAT(GetDefaultedAmount(Loans."Loan No.")));
                                    MemberActivities.SendSms(Smssource::"Loan defaulted", Member."Mobile Phone No.", Msg, Member."No.", Loans."Loan No.", false, false);
                                end;
                                AddSMSChargeFee(Member."No.");
                            end;
                        end;


                        //Add sms charges function


                    end;
                    //END PENALTY





                end;

                //DefaulterNotifications.GenerateDefaulterNotices();
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        //MESSAGE('%1',CALCDATE('CM-1D',TODAY));
    end;

    var
        SLE: Record "Savings Ledger Entry";
        MemberActivities: Codeunit "Member Activities";
        Msg: Text;
        Member: Record Members;
        SMSSource: Enum "SMS Source Enum";
        NameString: Text;
        String1: Text;
        String2: Text;
        LRS: Record "Loan Repayment Schedule";
        LLE: Record "Credit Ledger Entry";


    procedure Token(var TString: Text; Sepa: Text) Token: Text
    var
        Pos: Integer;
    begin
        Pos := StrPos(TString, Sepa);

        if Pos > 0 then begin
            Token := CopyStr(TString, 1, Pos - 1);
            if Pos + 1 <= StrLen(TString) then
                TString := CopyStr(TString, Pos + 1)
            else
                TString := '';
        end else begin
            Token := TString;
            TString := '';
        end;
    end;

    procedure GetDefaultedAmount(LoanNo: code[20]) Amt: decimal;
    var
        LoanDefaulter: Record "SACCO Categorization";
    begin
        LoanDefaulter.RESET;
        LoanDefaulter.SETRANGE("Loan No.", LoanNo);
        LoanDefaulter.SETFILTER("Principal Arrears", '>0');
        IF LoanDefaulter.FIND('-') THEN
            exit(LoanDefaulter."Principal Arrears");
    end;

    procedure AddSMSChargeFee(MembrNo: Code[50])
    var
        DefaulterSMSCharge: Decimal;
        ChargeAcc: Code[50];
        SMSCharges: Record "Sms Charges";
        SAcc: Record "Savings Accounts";
        DebitAcc: code[60];
        SActv: Codeunit "Sacco Activities";
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        SMSSource: Enum "SMS Source Enum";
        JTemplate: Code[10];
        JBatch: Code[10];
        UserSetup: record "User Setup";
        DActivity2: Code[20];
        DBranch2: Code[20];
        DocNo: Text;
        MA: Codeunit "Member Activities";
        RunBal: Decimal;
        TChannel: Enum "Transaction Channel";

    begin
        DefaulterSMSCharge := 0;
        SMSCharges.Reset;
        SMSCharges.SetRange(Source, SMSCharges.Source::"Loan defaulted");
        if SMSCharges.FindFirst then begin
            DefaulterSMSCharge := SMSCharges."Charge Amount";


            //Get Member Fosa Acc to Debit SMS amount
            SAcc.Reset();
            SAcc.SetRange("Member No.", MembrNo);
            SAcc.SetRange("Product Category", SAcc."Product Category"::"Ordinary Savings");
            if SAcc.FindFirst() then DebitAcc := SAcc."No.";
            RunBal := MA.GetAccountBalance(DebitAcc);
            if RunBal < DefaulterSMSCharge then exit;


            UserSetup.Get(UserId);
            UserSetup.TestField("CashRec Journal Template");
            UserSetup.TestField("CashRec Journal Batch");

            DActivity2 := UserSetup."Global Dimension 1 Code";
            DBranch2 := UserSetup."Global Dimension 2 Code";
            Jtemplate := UserSetup."CashRec Journal Template";
            JBatch := UserSetup."CashRec Journal Batch";
            DocNo := StrSubstNo(MembrNo + '-' + Format(Today));

            SActv.JournalInit(JTemplate, JBatch);
            SActv.JournalInsert(

                JTemplate,
                JBatch,
                DocNo,
                Today,
                AcctType::Savings,
                DebitAcc,
                'Defaulter SMS Charge',
                Balaccttype::"G/L Account",
                SMScharges."Charge G/L Account",
                SMScharges."Charge Amount",
                '',
                '',
                TransType::" ",
                DActivity2,
                DBranch2,
                true,
                TChannel::" ",
                0
            );


        end;




    end;


}

