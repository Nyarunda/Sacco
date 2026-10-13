
Codeunit 50064 "Banking Activities"
{

    trigger OnRun()
    begin
    end;

    var
        GLAccount: Record "G/L Account";
        Savings: Record "Savings Accounts";
        BankingUser: Record "Banking User Setup";
        SaccoSetup: Record "Sacco Setup";
        SaccoActivities: Codeunit "Sacco Activities";
        MemberActivities: Codeunit "Member Activities";
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
        SharingAmt: Decimal;
        SharingDuty: Decimal;
        SharingChargeAcctType: Enum "Gen. Journal Account Type";
        SharingChargeAcct: Code[20];
        Members: Record Members;
        MobileNo: Code[20];
        Msg: Text;
        Source: Enum "SMS Source Enum";
        Employer: Record Customer;
        AccNo: Code[20];
        Jtemplate: Code[10];
        JBatch: Code[10];
        Loans: Record Loans;
        ProductSetup: Record "Product Setup";
        CalwideApprovals: Codeunit "Calwide Approvals";
        DocumentType: Enum "Custom Document Type";
        TChannel: Enum "Transaction Channel";
        VarVariant: Variant;

    local procedure "*********Cashier Transactions********"()
    begin
    end;


    procedure InitPost(TellerTransaction: Record "Teller Transaction") Success: Boolean
    var
        BankingUser: Record "Banking User Setup";
        Jtemplate: Code[30];
        JBatch: Code[30];
        UserSetup: Record "User Setup";
        DBranch: Code[20];
        DActivity: Code[20];
        Tillno: Code[20];
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
        Text0004: label 'The transaction has already been posted.';
        Text0005: label 'Cannot post a Transaction being processed by %1';
        Text0006: label 'Please specify the Account No';
        Text0007: label 'Please specify an amount greater than zero.';
        Text0008: label 'Please select the transaction type.';
        CmemberNo: Code[20];
        Text0009: label 'Ensure the Cashier Member No is set up in Banking User Setup';
        Text0010: label 'You are not authorised to transact your own account';
        Text0011: label 'Ensure the Cashier Shortage Account is set up in Banking User Setup';
        Text0012: label 'Ensure the Cashier Excess Account iis set up in Banking User Setup';
        Excess: Code[20];
        Shortage: Code[20];
        TellerLines: Record "Teller Lines";
        Text0013: label 'The Transaction date must be today, please reset to proceed';
        BankLed: Record "Bank Account Ledger Entry";
    begin

        Success := false;

        if (TellerTransaction.Type = TellerTransaction.Type::"Cheque Deposit") or (TellerTransaction.Type = TellerTransaction.Type::"Cheque Withdrawal") or (TellerTransaction.Type = TellerTransaction.Type::"Inhouse Cheque Transfer") then begin
            TellerTransaction.TestField("Cheque Date");
            TellerTransaction.TestField("Cheque No");
            TellerTransaction.TestField("Drawer Name");
            TellerTransaction.TestField("Cheque Type");
            if (TellerTransaction.Type = TellerTransaction.Type::"Inhouse Cheque Transfer") then
                TellerTransaction.TestField("Source Account No.");

        end;

        if TellerTransaction.Posted = true then
            Error(Text0004);


        BankLed.Reset;
        BankLed.SetRange("Document No.", TellerTransaction."Transaction No.");
        if BankLed.Find('-') then begin
            Error('Transaction No. %1 has already been used by %2 on %3.', TellerTransaction."Transaction No.", TellerTransaction.Cashier, TellerTransaction."Transaction Date");
            TellerTransaction.Posted := true;
            TellerTransaction.Modify;
            Message('Marked as Posted');
            exit;
        end;

        //if Confirm('Are you sure you want to process this ' + Format(Type) + 'transaction ?',false) then exit;



        BankingUser.Get(UserId);
        BankingUser.TestField("Cashier Journal Template");
        BankingUser.TestField("Cashier Journal Batch");

        Jtemplate := BankingUser."Cashier Journal Template";
        JBatch := BankingUser."Cashier Journal Batch";
        Tillno := BankingUser."Default  Bank";


        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            DBranch := UserSetup."Global Dimension 2 Code";
            DActivity := UserSetup."Global Dimension 1 Code";
        end;


        if TellerTransaction."Mobile Transaction" then begin
            //PostMobileCashDepWith(TellerTransaction,Jtemplate,JBatch,"Till Code",DBranch,DActivity,"Transaction Date");
            exit;
        end;


        if TellerTransaction."Transaction Date" <> Today then
            Error(Text0013);


        if TellerTransaction.Mpesa then
            Tillno := TellerTransaction."Till Code";

        CmemberNo := BankingUser."Member No.";
        Excess := BankingUser."Excess Account";
        Shortage := BankingUser."Shortage Account";

        if Jtemplate = '' then begin
            Error(Text0001);
        end;

        if JBatch = '' then begin
            Error(Text0002);
        end;

        if Tillno = '' then begin
            Error(Text0003);
        end;

        if CmemberNo = '' then begin
            Error(Text0009);
        end;

        /*
            IF Shortage='' THEN
              BEGIN
                ERROR(Text0011);
              END;

            IF Excess='' THEN
              BEGIN
                ERROR(Text0012);
              END;
              */


        CheckTillCurrency(Tillno, TellerTransaction."Currency Code");
        SaccoSetup.Get;

        if not SaccoSetup."Teller Can Self-Transact" then begin
            if CmemberNo = TellerTransaction."Member No." then begin
                TellerTransaction."Attempted Self Transaction" := true;
                TellerTransaction.Modify;
                Commit;
                Error(Text0010);
                exit;
            end;
        end;


        if TellerTransaction.Cashier <> UserId then
            Error(Text0005, TellerTransaction.Cashier);

        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UpperCase(UserId));
        if UserSetup.Find('-') then begin
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            DBranch := UserSetup."Global Dimension 2 Code";
            DActivity := UserSetup."Global Dimension 1 Code";
        end;

        if TellerTransaction."Account Type" <> TellerTransaction."account type"::"G/L Account" then
            if TellerTransaction."Account No." = '' then
                Error(Text0006);

        if TellerTransaction.Amount <= 0 then
            Error(Text0007);

        if not TellerTransaction.Mpesa then
            if TellerTransaction."Transaction Type" = '' then
                Error(Text0008);

        TellerTransaction.CalcFields("Allocated Amount");


        if TellerTransaction.Mpesa then begin
            if (TellerTransaction."Mpesa/Agent Transaction" = TellerTransaction."mpesa/agent transaction"::Deposit) or (TellerTransaction."Mpesa/Agent Transaction" = TellerTransaction."mpesa/agent transaction"::Withdrawal) then begin
                PostMPESADepWith(TellerTransaction, Jtemplate, JBatch, Tillno, DBranch, DActivity);
                exit;
            end;
        end;


        if TellerTransaction.Type = TellerTransaction.Type::"Credit Cheque" then begin

            TellerTransaction.TestField("Cheque No");
            TellerTransaction.TestField("Cheque Date");
            TellerTransaction.TestField("Member No.");
            TellerTransaction.TestField("Cheque Type");

            if TellerTransaction.Amount <> TellerTransaction."Allocated Amount" then
                Error('Allocated amount must be equall to the transaction amount.');

            PostChequeDep(TellerTransaction, Jtemplate, JBatch, DBranch, DActivity);
        end;


        if TellerTransaction.Type = TellerTransaction.Type::"Credit Receipt" then begin
            TellerTransaction.TestField("Member No.");

            if TellerTransaction.Amount <> TellerTransaction."Allocated Amount" then
                Error('Allocated amount must be equall to the transaction amount.');

            TellerLines.Reset;
            TellerLines.SetRange("Transaction No.", TellerTransaction."Transaction No.");
            if TellerLines.Find('-') then begin
                repeat
                    TellerLines.Testfield("Account No.");
                // TellerLines.Testfield(Type);
                until TellerLines.Next() = 0;
            end;
        end;


        if TellerTransaction.Type = TellerTransaction.Type::"Cheque Deposit" then begin
            TellerTransaction.TestField("Cheque Type");
            TellerTransaction.TestField("Cheque No");
            TellerTransaction.TestField("Cheque Date");

            PostChequeDep(TellerTransaction, Jtemplate, JBatch, DBranch, DActivity);

            exit;
        end;

        if TellerTransaction.Type = TellerTransaction.Type::"Inhouse Cheque Transfer" then begin
            TellerTransaction.TestField("Cheque Type");
            TellerTransaction.TestField("Cheque No");
            TellerTransaction.TestField("Cheque Date");
            TellerTransaction.TestField("Source Account No.");


            if Savings.Get(TellerTransaction."Source Account No.") then begin
                if Savings.Status = Savings.Status::Dormant then
                    Error('You cannot withdraw from a dormant account');
            end;

            PostChequeTransfer(TellerTransaction, Jtemplate, JBatch, DBranch, DActivity);

            exit;
        end;


        if TellerTransaction.Type = TellerTransaction.Type::"Income Transactions" then begin

            PostIncomeTransactions(TellerTransaction, Jtemplate, JBatch, Tillno, DBranch, DActivity);

            exit;
        end;


        if (TellerTransaction.Type = TellerTransaction.Type::"Bankers Cheque") then begin

            TellerTransaction.TestField("Bankers Cheque No");
            TellerTransaction.TestField(Payee);
            TellerTransaction.TestField(Status, TellerTransaction.Status::Approved);

            PostBankersCheq(TellerTransaction, Jtemplate, JBatch, DBranch, DActivity, BankingUser);
            exit;
        end;


        if TellerTransaction.Type = TellerTransaction.Type::RTGS then begin
            PostRTGS(TellerTransaction, Jtemplate, JBatch, DBranch, DActivity, BankingUser);
            exit;
        end;


        if TellerTransaction.Type = TellerTransaction.Type::"Bankers Cheque GL" then begin

            TellerTransaction.TestField("Bankers Cheque No");
            TellerTransaction.TestField(Payee);
            PostBankersCheqGL(TellerTransaction, Jtemplate, JBatch, DBranch, DActivity, BankingUser);
            exit;
        end;


        //prevent withdrawal from dormant
        if TellerTransaction.Type = TellerTransaction.Type::"Cash Withdrawal" then begin
            if Savings.Get(TellerTransaction."Account No.") then begin
                if Savings.Status = Savings.Status::Dormant then
                    Error('You cannot withdraw from a dormant account');
            end;
        end;
        //prevent withdrawal from dormant


        if (TellerTransaction.Type = TellerTransaction.Type::"Cash Deposit") or
        (TellerTransaction.Type = TellerTransaction.Type::"Cash Withdrawal") or
        (TellerTransaction.Type = TellerTransaction.Type::"Credit Receipt") or
        (TellerTransaction.Type = TellerTransaction.Type::"Cash Deposit Customer") then begin
            PostCashDepWith(TellerTransaction, Jtemplate, JBatch, Tillno, DBranch, DActivity, BankingUser);
            exit;
        end;


        if (TellerTransaction.Type = TellerTransaction.Type::"Cheque Withdrawal") then begin
            PostChequeWith(TellerTransaction, Jtemplate, JBatch, Tillno, DBranch, DActivity);
            exit;
        end;


        if (TellerTransaction.Type = TellerTransaction.Type::Lien) then begin
            PostLien(TellerTransaction);
            exit;
        end;

    end;

    local procedure PostCashDepWith(CashierTrans: Record "Teller Transaction"; JTemplate: Code[20]; JBatch: Code[20]; TillNo: Code[20]; DBranch: Code[20]; DActivity: Code[20]; BankingUser: Record "Banking User Setup")
    var

        ChargesLines: Record "Transaction Charges Lines";
        GenSetup: Record "Sacco Setup";
        Amt: Decimal;
        StaggeredLines: Record "Staggered Lines.";
        ChargeAmount: Decimal;
        BankAccount: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        LineNo: Integer;
        TCharges: Decimal;
        Text0001: label 'This account has been blocked from receiving payments.';
        Text0002: label 'You need to add more money from the treasury since your balance has gone below the teller replenishing level.';
        Text0003: label 'You do not have enough money to carry out this transaction.';
        Text0004: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0005: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0006: label 'You cannot withdraw more than your allowed limit of %1 unless authorised.';
        Text0007: label 'You cannot withdraw more than the available balance unless authorised.';
        Text0008: label 'You cannot deposit more than your allowed limit of %1 unless authorised.';
        VarVariant: Variant;
        Text0009: label 'You have done a ';
        Text0010: label ' transaction of KES ';
        Text0011: label ' on ';
        Text0012: label ' at ';
        Text0014: label 'The limit for cashier ';
        Text0015: label ' of till ';
        Text0016: label ' has gone below the replenishing levels of ';
        Text0017: label ' has gone above the replenishing levels of ';
        Text0018: label 'Transaction Aborted';
        Employer: Record Customer;
        Text0019: label 'You cannot withdraw more than the Book balance unless authorised.\ Book Bal: %1\Below Limit Charge %2\Transaction Charge %3';
        Text0020: label 'Withdrawal Below Book Balance.\ Book Bal: %1\Below Limit Charge %2\Transaction Charge %3';
        TransAmt: Decimal;
        Cust: Record Members;
        Customer: Record Customer;
        MemberSMS: Record "Member SMS";
        SkipSMS: Boolean;
        SMScharges: Record "SMS Charges";
        TotalSms: Decimal;
        SmsExcise: decimal;
        SLedger: Record "Savings Ledger Entry";
    begin

        if CashierTrans.Type = CashierTrans.Type::"Cash Deposit Customer" then
            Customer.Get(CashierTrans."Account No.")
        else
            Savings.Get(CashierTrans."Account No.");

        if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then begin

            if Savings.Blocked = Savings.Blocked::Payment then
                Error(Text0001);

            ProductSetup.get(Savings."Product Type");

            if CashierTrans.Status <> CashierTrans.Status::Approved then
                if CashierTrans."Available Balance" < CashierTrans.Amount then
                    Error('You cannot withdraw below the Available Balance');

        end;

        if CashierTrans."Issueing Bank Account" <> '' then
            TillNo := CashierTrans."Issueing Bank Account";

        BankAccount.Reset;
        BankAccount.SetRange(BankAccount."No.", TillNo);
        if BankAccount.Find('-') then begin
            BankAccount.CalcFields(BankAccount.Balance);

            CurrentTellerAmount := BankAccount.Balance;


            if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then begin
                if CurrentTellerAmount - CashierTrans.Amount < 0 then
                    Error('This transaction Will lead to Overdrawal of Teller Till');

                if CurrentTellerAmount - CashierTrans.Amount <= BankingUser."Min. Balance" then
                    Message(Text0002 + '\Minimum Balance: %1\Current Teller Balance: %2\Transaction Amount: %3', BankingUser."Min. Balance", CurrentTellerAmount, CashierTrans.Amount);


                if CurrentTellerAmount - CashierTrans.Amount >= BankingUser."Max. Cashier Withholding" then
                    Message(Text0004 + '\Cashier Withholding: %1\Current Teller Balance: %2\Transaction Amount: %3', BankingUser."Max. Cashier Withholding", CurrentTellerAmount, CashierTrans.Amount);


            end
            else begin
                if CurrentTellerAmount + CashierTrans.Amount >= BankingUser."Max. Cashier Withholding" then begin
                    Message(Text0005);
                    if Confirm('Do you want to proceed with this transaction?', false) = false then
                        exit;
                end;
            end;


            if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then begin
                if CashierTrans.Status <> CashierTrans.Status::Approved then begin
                    if CashierTrans.Amount > BankingUser."Max. Withdrawal Limit" then begin
                        Message(Text0006, BankingUser."Max. Withdrawal Limit");


                        if Confirm('Do you want to send this transaction for approval?', false) = true then begin

                            VarVariant := CashierTrans;
                            CalwideApprovals.CreateCustomTracker(VarVariant, CashierTrans."Transaction No.", CashierTrans.Amount, Documenttype::"Teller Transaction", CashierTrans."Global Dimension 1 Code", CashierTrans."Global Dimension 2 Code", 0);
                            Commit;
                            Error('Pending Authorization');

                            //VarVariant := CashierTrans;
                            //IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                            //  CustomApprovals.OnSendDocForApproval(VarVariant);
                        end;
                        exit;
                    end;
                end;
            end;


            if (CashierTrans.Type = CashierTrans.Type::"Cash Deposit") or (CashierTrans.Type = CashierTrans.Type::"Cash Deposit Customer") or (CashierTrans.Type = CashierTrans.Type::"Cheque Withdrawal") then begin

                if CashierTrans.Amount > BankingUser."Max. Deposit Limit" then begin
                    if CashierTrans.Status <> CashierTrans.Status::Approved then begin
                        Message(Text0008, BankingUser."Max. Deposit Limit");

                        if Confirm('Do you want to send this transaction for approval?', false) = true then begin

                            VarVariant := CashierTrans;
                            CalwideApprovals.CreateCustomTracker(VarVariant, CashierTrans."Transaction No.", CashierTrans.Amount, Documenttype::"Teller Transaction", CashierTrans."Global Dimension 1 Code", CashierTrans."Global Dimension 2 Code", 0);
                            Commit;
                            Error('Pending Authorization');

                        end;
                        exit;
                    end;
                end;
            end;
        end;

        SaccoActivities.JournalInit(JTemplate, JBatch);

        TChannel := TChannel::"Cash Withdrawal";
        if (CashierTrans.Type = CashierTrans.Type::"Cash Deposit") or (CashierTrans.Type = CashierTrans.Type::"Cash Deposit Customer") then begin
            TransAmt := -CashierTrans.Amount;
            TChannel := TChannel::"Cash Deposit"
        end else
            TransAmt := CashierTrans.Amount;

        AcctType := AcctType::Savings;
        if CashierTrans.Type = CashierTrans.Type::"Cash Deposit Customer" then
            AcctType := AcctType::Customer;

        if CashierTrans.Type <> CashierTrans.Type::"Credit Receipt" then begin

            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                CashierTrans."Transaction No.",
                CashierTrans."Transaction Date",
                Accttype,
                CashierTrans."Account No.",
                CopyStr(Format(CashierTrans.Type) + '-' + CashierTrans.Remarks, 1, 50),
                Balaccttype::"Bank Account",
                TillNo,
                TransAmt,
                CopyStr(CashierTrans."ID No", 1, 20),
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true,
                TChannel,
                CashierTrans."Dimension Set ID"
                );
        end;


        //if Type = Type::"Cash Withdrawal" then begin

        //MemberActivities.GetGeneralCumulativeChargeAmount("Transaction Type", Amount, ChargeAmt, ChargeAmt, ChargeAcctType, ChargeAcct);



        //MemberActivities.GetGeneral_SharingChargeAmount("Transaction Type", Amount, ChargeAmt, ChargeAmt, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);

        if Members.Get(Savings."Member No.") then;
        if Employer.Get(Members."Employer Code") then begin
            if Employer."Dont Charge Transactions" then
                ChargeAmt := 0;
        end;


        if not Savings."Exempt Charges" then begin
            ChargesLines.Reset;
            ChargesLines.SetRange("Transaction Type", CashierTrans."Transaction Type");
            if ChargesLines.Find('-') then begin
                repeat

                    ChargeAmount := 0;

                    if ChargesLines."Charge Type" = ChargesLines."charge type"::"% of Amount" = true then
                        ChargeAmount := (CashierTrans.Amount * ChargesLines."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := ChargesLines."Charge Amount";

                    if ChargesLines."Charge Type" = ChargesLines."charge type"::Staggered then begin

                        ChargesLines.TestField("Staggered Charge Code");

                        StaggeredLines.Reset;
                        StaggeredLines.SetRange(Code, ChargesLines."Staggered Charge Code");
                        if StaggeredLines.Find('-') then begin
                            repeat
                                if (CashierTrans.Amount >= StaggeredLines."Lower Limit") then begin
                                    if StaggeredLines."Use Percentage" = true then begin
                                        ChargeAmount := CashierTrans.Amount * StaggeredLines.Percentage * 0.01;
                                    end
                                    else begin
                                        ChargeAmount := StaggeredLines."Charge Amount";
                                    end;
                                end;
                            until StaggeredLines.Next = 0;
                        end;
                    end;



                    if ChargesLines."Minimum Amount" > 0 then
                        if ChargeAmount < ChargesLines."Minimum Amount" then
                            ChargeAmount := ChargesLines."Minimum Amount";

                    if ChargesLines."Maximum Amount" > 0 then
                        if ChargeAmount > ChargesLines."Maximum Amount" then
                            ChargeAmount := ChargesLines."Maximum Amount";


                    GenSetup.Get();
                    ChargeDuty := 0;

                    if ChargesLines."Charge Excise Duty" then
                        ChargeDuty := (ChargeAmount * GenSetup."Excise Duty (%)" * 0.01);

                    ChargeAcct := ChargesLines."Charge Account";
                    ChargeAcctType := ChargesLines."Charge Account Type";


                    if ChargeAmount > 0 then
                        ChargesLines.TestField("Charge Account");

                    if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then begin
                        if ProductSetup."Withdrawal Frequency Count" > 0 then begin
                            SLedger.Reset();
                            SLedger.SetRange("Account No.", CashierTrans."Account No.");
                            SLedger.SetFilter("Debit Amount (LCY)", '>0');
                            SLedger.SetFilter(Description, '<>%1&<>%2', 'Excise Duty on Cash Withdrawal Charge', 'Penalty on Cash Withdrawal');
                            if SLedger.FindFirst() then begin
                                Message('Ct %1', SLedger.Count);
                                if SLedger.Count() + 1 <= ProductSetup."Withdrawal Frequency Count" then begin
                                    ChargeAmount := 0;
                                    SharingAmt := 0;
                                    ChargeDuty := 0;
                                end;
                            end else begin
                                ChargeAmount := 0;
                                SharingAmt := 0;
                                ChargeDuty := 0;
                            end;
                        end;
                    end;

                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        CashierTrans."Transaction No.",
                        CashierTrans."Transaction Date",
                        Accttype::Savings,
                        CashierTrans."Account No.",
                        ChargesLines.Description,
                        ChargeAcctType,
                        ChargeAcct,
                        ChargeAmount,
                        CopyStr(CashierTrans."ID No", 1, 20),
                        '',
                        Transtype::" ",
                        DActivity,
                        DBranch,
                        true,
                        TChannel,
                    CashierTrans."Dimension Set ID"
                        );

                    SaccoSetup.Get;

                    if ChargeDuty > 0 then begin

                        SaccoActivities.JournalInsert(
                            JTemplate,
                            JBatch,
                            CashierTrans."Transaction No.",
                            CashierTrans."Transaction Date",
                            Accttype::Savings,
                            CashierTrans."Account No.",
                            CopyStr('Excise Duty on ' + Format(CashierTrans.Type) + ' Charge', 1, 50),
                            Balaccttype::"G/L Account",
                            SaccoSetup."Excise Duty GL",
                            ChargeDuty,
                            CopyStr(CashierTrans."ID No", 1, 20),
                            '',
                            Transtype::" ",
                            DActivity,
                            DBranch,
                            true,
                            TChannel,
                            CashierTrans."Dimension Set ID"
                            );
                    end;




                until ChargesLines.Next() = 0;
            end;
        end;



        if CashierTrans.Type = CashierTrans.Type::"Credit Receipt" then begin
            PostCredit(CashierTrans, JTemplate, JBatch, TillNo, DBranch, DActivity, CashierTrans."Transaction Date", false);
        end;

        CashierTrans.Posted := true;
        CashierTrans."Date Posted" := Today;
        CashierTrans."Time Posted" := Time;
        CashierTrans."Posted By" := UserId;
        CashierTrans.Modify;

        SaccoActivities.JournalPost(JTemplate, JBatch);

        MobileNo := Members."Mobile Phone No.";

        SkipSMS := false;

        //xxxxxx

        if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then begin
            Msg := 'Dear ' + MemberActivities.FirstName(Members.Name) + ', You have withdrawn KES ' + Format(CashierTrans.Amount) + ' from ' + DBranch + ' Teller on ' + Format(Today) + ' ' + Format(Time);

            MemberSMS.Reset;
            MemberSMS.SetRange("Member No", Members."No.");
            MemberSMS.SetRange(Source, Source::"Teller Cash Withdrawal");
            if not MemberSMS.FindFirst then
                MemberActivities.SendSms(Source::"Teller Cash Withdrawal", MobileNo, Msg, CashierTrans."Transaction No.", CashierTrans."Account No.", false, false);

            SMScharges.reset;
            SMScharges.setrange(source, SMScharges.source::"Teller Cash Withdrawal");
            if SMScharges.findfirst then begin

                TotalSms := SMSCharges."Charge Amount";
                SmsExcise := Round(SaccoSetup."Excise Duty (%)" * TotalSms * 0.01, 0.1, '<');
                TotalSms += SmsExcise;
                SaccoSetup.Get();

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype::Savings,
                    CashierTrans."Account No.",
                    CopyStr('Sms Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    SMSCHarges."Charge G/L Account",
                    TotalSms - SmsExcise,
                    CashierTrans."Bankers Cheque No",
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Bankers Cheque Withdrawal",
                    CashierTrans."Dimension Set ID"
                    );

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype::"G/L Account",
                    SaccoSetup."Excise Duty GL",
                    CopyStr('Excise Duty on Sms Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -SmsExcise,
                    CashierTrans."Bankers Cheque No",
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Bankers Cheque Withdrawal",
                    CashierTrans."Dimension Set ID"
                );

            end;
        end
        else begin
            Msg := 'Dear ' + MemberActivities.FirstName(Members.Name) + ', KES ' + Format(CashierTrans.Amount) + ' has been deposited into your Account at ' + DBranch + ' Teller on ' + Format(Today) + ' ' + Format(Time);

            MemberSMS.Reset;
            MemberSMS.SetRange("Member No", Members."No.");
            MemberSMS.SetRange(Source, Source::"Teller Cash Deposit");
            if not MemberSMS.FindFirst then
                if CashierTrans."Send SMS" then
                    MemberActivities.SendSms(Source::"Teller Cash Deposit", MobileNo, Msg, CashierTrans."Transaction No.", CashierTrans."Account No.", false, false);

            SMScharges.reset;
            SMScharges.setrange(source, SMScharges.source::"Teller Cash Deposit");
            if SMScharges.findfirst then begin
                SaccoSetup.Get();
                TotalSms := SMSCharges."Charge Amount";
                SmsExcise := Round(SaccoSetup."Excise Duty (%)" * TotalSms * 0.01, 0.1, '<');
                TotalSms += SmsExcise;

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype::Savings,
                    CashierTrans."Account No.",
                    CopyStr('Sms Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    SMSCHarges."Charge G/L Account",
                    TotalSms - SmsExcise,
                    CashierTrans."Bankers Cheque No",
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::Teller,
                    CashierTrans."Dimension Set ID"
                    );

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype::"G/L Account",
                    SaccoSetup."Excise Duty GL",
                    CopyStr('Excise Duty on Sms Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -SmsExcise,
                    CashierTrans."Bankers Cheque No",
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::Teller,
                    CashierTrans."Dimension Set ID"
                );

            end;
        end;
    end;

    local procedure PostChequeDep(CashierTrans: Record "Teller Transaction"; JTemplate: Code[20]; JBatch: Code[20]; DBranch: Code[20]; DActivity: Code[20])
    var
        BankAccount: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        ChBank: Code[20];
        Trans: Record "Teller Transaction";
        Customer: Record Customer;
        Duty: Decimal;
        Text0009: label 'You have done a ';
        Text0010: label ' transaction of KES ';
        Text0011: label ' on ';
        Text0012: label ' at ';
    begin

        SaccoSetup.Get;


        if CashierTrans."Account Type" = CashierTrans."account type"::Customer then begin
            Accttype := Accttype::Customer;
            Customer.Get(CashierTrans."Account No.");
        end else begin
            Accttype := Accttype::Savings;
            Savings.Get(CashierTrans."Account No.");
        end;

        ChBank := CashierTrans."Issueing Bank Account";//"Bank Account";

        SaccoActivities.JournalInit(JTemplate, JBatch);

        if (CashierTrans."Account Type" = CashierTrans."account type"::Account) or (CashierTrans."Account Type" = CashierTrans."account type"::Customer) then begin


            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                CashierTrans."Transaction No.",
                CashierTrans."Transaction Date",
                Accttype,
                CashierTrans."Account No.",
                CopyStr(CashierTrans."Transaction Description" + '-' + CashierTrans.Remarks + '-' + CashierTrans."Cheque No", 1, 50),
                Balaccttype::"G/L Account",
                '',
                -CashierTrans.Amount,
                CashierTrans."Cheque No",
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true,
                TChannel::"Cheque Deposit",
                CashierTrans."Dimension Set ID"
                );


            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                CashierTrans."Transaction No.",
                CashierTrans."Transaction Date",
                Accttype::"Bank Account",
                ChBank,
                CopyStr(CashierTrans."Account Name" + '-' + CashierTrans.Remarks + '-' + CashierTrans."Cheque No", 1, 50),
                Balaccttype::"G/L Account",
                '',
                CashierTrans.Amount,
                CashierTrans."Cheque No",
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true,
                TChannel::"Cheque Deposit",
                CashierTrans."Dimension Set ID"
                );


            if CashierTrans."Account Type" = CashierTrans."account type"::"G/L Account" then begin
                PostIncomeLines(CashierTrans, JTemplate, JBatch, ChBank, DBranch, DActivity, CashierTrans."Transaction Date");
            end;


            MemberActivities.GetGeneral_SharingChargeAmount(CashierTrans."Transaction Type", CashierTrans.Amount, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);

            if CashierTrans."Account Type" <> CashierTrans."account type"::Customer then
                Members.Get(Savings."Member No.");
            if Employer.Get(Members."Employer Code") then begin
                if Employer."Dont Charge Transactions" then
                    ChargeAmt := 0;
            end;

            if ChargeAmt > 0 then begin

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype,
                    CashierTrans."Account No.",
                    CopyStr(Format(CashierTrans.Type) + ' Charge', 1, 50),
                    ChargeAcctType,
                    ChargeAcct,
                    ChargeAmt,
                    CopyStr(CashierTrans."ID No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Cheque Deposit",
                    CashierTrans."Dimension Set ID"
                    );

                if ChargeDuty > 0 then begin

                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        CashierTrans."Transaction No.",
                        CashierTrans."Transaction Date",
                        Accttype::Savings,
                        CashierTrans."Account No.",
                        CopyStr('Excise Duty on ' + Format(CashierTrans.Type) + ' Charge', 1, 50),
                        Balaccttype::"G/L Account",
                        SaccoSetup."Excise Duty GL",
                        ChargeDuty,
                        CopyStr(CashierTrans."ID No", 1, 20),
                        '',
                        Transtype::" ",
                        DActivity,
                        DBranch,
                        true,
                        TChannel::"Cheque Deposit",
                        CashierTrans."Dimension Set ID"
                        );
                end;
            end;


            CashierTrans.Posted := true;
            CashierTrans."Date Posted" := Today;
            CashierTrans."Time Posted" := Time;
            CashierTrans."Posted By" := UserId;
            CashierTrans."Cheque Location" := CashierTrans."cheque location"::"Chief Cashier 1";

            if CashierTrans."Cheque Category" = CashierTrans."cheque category"::"MBS Sacco Cheque" then begin
                CashierTrans."Chief Cashier Select" := true;
                CashierTrans."Cheque Location" := CashierTrans."cheque location"::Accountant;
                CashierTrans."Cheques Issued" := CashierTrans."cheques issued"::Yes;
                CashierTrans."Cheques Received" := CashierTrans."cheques received"::Yes;
            end;

            if CashierTrans."Account Type" = CashierTrans."Account Type"::Customer then begin
                CashierTrans."Cheque Status" := CashierTrans."cheque status"::Honoured;
                CashierTrans."Date Cleared" := Today;
                CashierTrans."Cleared By" := UserId;
            end;

            CashierTrans.Modify;
            SaccoActivities.JournalPost(JTemplate, JBatch);


            Msg := 'Dear ' + MemberActivities.FirstName(Members.Name) + ', A Cheque of KES ' + Format(CashierTrans.Amount) + ' has been deposited into your Account at ' + DBranch + ' Teller on ' + Format(Today) + ' ' + Format(Time);
            MemberActivities.SendSms(Source::"Teller Cheque Deposit", MobileNo, Msg, CashierTrans."Transaction No.", CashierTrans."Account No.", false, false)

        end;
    end;

    local procedure PostRTGS(CashierTrans: Record "Teller Transaction"; JTemplate: Code[20]; JBatch: Code[20]; DBranch: Code[20]; DActivity: Code[20]; BankingUser: Record "Banking User Setup")
    var
        Text0001: label 'This account has been blocked from receiving payments.';
        ChBank: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        Text0002: label 'You cannot issue a Bankers cheque more than the available balance';
        BRegister: Record "Bankers Cheque Register";
        BankAccount: Record "Bank Account";
        Text0009: label 'You have done a ';
        Text0010: label ' transaction of KES ';
        Text0011: label ' on ';
        Text0012: label ' at ';
    begin

        if BankingUser.Get(UserId) then begin

            BankingUser.TestField(BankingUser."Default RTGS Bank");
            ChBank := BankingUser."Default RTGS Bank";
        end;

        if CashierTrans."Account Type" = CashierTrans."account type"::Account then begin
            Savings.Get(CashierTrans."Account No.");
            if Savings.Blocked = Savings.Blocked::Payment then
                Error(Text0001);



            if CashierTrans.Type = CashierTrans.Type::"Bankers Cheque" then begin
                if CashierTrans."Available Balance" < CashierTrans.Amount then begin
                    Error(Text0002);
                end;
            end;


            SaccoActivities.JournalInit(JTemplate, JBatch);

            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                CashierTrans."Transaction No.",
                CashierTrans."Transaction Date",
                Accttype::Savings,
                CashierTrans."Account No.",
                CopyStr(CashierTrans.Remarks + ': ' + CashierTrans."Transaction Description" + '-' + CashierTrans."Account Name", 1, 50),
                Balaccttype::"G/L Account",
                '',
                CashierTrans.Amount,
                CashierTrans."Bankers Cheque No",
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true,
                TChannel::Teller,
                CashierTrans."Dimension Set ID"
                );


            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                CashierTrans."Transaction No.",
                CashierTrans."Transaction Date",
                Accttype::"Bank Account",
                ChBank,
                CopyStr(CashierTrans.Remarks + ': ' + CashierTrans."Account Name" + '-' + CashierTrans."Cheque No", 1, 50),
                Balaccttype::"G/L Account",
                '',
                -CashierTrans.Amount,
                CashierTrans."Bankers Cheque No",
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true,
                TChannel::Teller,
                CashierTrans."Dimension Set ID"
                );




            MemberActivities.GetGeneral_SharingChargeAmount(CashierTrans."Transaction Type", CashierTrans.Amount, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);

            Members.Get(Savings."Member No.");
            if Employer.Get(Members."Employer Code") then begin
                if Employer."Dont Charge Transactions" then
                    ChargeAmt := 0;
            end;

            if ChargeAmt > 0 then begin

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype::Savings,
                    CashierTrans."Account No.",
                    CopyStr(Format(CashierTrans.Type) + ' Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    ChargeAmt,
                    CopyStr(CashierTrans."ID No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::Teller,
                    CashierTrans."Dimension Set ID"
                    );


                SaccoSetup.Get;
                if ChargeDuty > 0 then begin

                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        CashierTrans."Transaction No.",
                        CashierTrans."Transaction Date",
                        Accttype::Savings,
                        CashierTrans."Account No.",
                        CopyStr('Excise Duty on ' + Format(CashierTrans.Type) + ' Charge', 1, 50),
                        Balaccttype::"G/L Account",
                        SaccoSetup."Excise Duty GL",
                        ChargeDuty,
                        CopyStr(CashierTrans."ID No", 1, 20),
                        '',
                        Transtype::" ",
                        DActivity,
                        DBranch,
                        true,
                        TChannel::Teller,
                        CashierTrans."Dimension Set ID"
                        );
                end;


                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    ChargeAcctType,
                    ChargeAcct,
                    CopyStr(Format(CashierTrans.Type) + ' Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -(ChargeAmt - SharingAmt),
                    CopyStr(CashierTrans."ID No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::Teller,
                        CashierTrans."Dimension Set ID"
                    );

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    SharingChargeAcctType,
                    SharingChargeAcct,
                    CopyStr(Format(CashierTrans.Type) + ' Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -(SharingAmt),
                    CopyStr(CashierTrans."ID No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::Teller,
                    CashierTrans."Dimension Set ID"
                    );

            end;



            CashierTrans.Posted := true;
            CashierTrans."Date Posted" := Today;
            CashierTrans."Time Posted" := Time;
            CashierTrans."Posted By" := UserId;
            CashierTrans.Modify;



            SaccoActivities.JournalPost(JTemplate, JBatch);

            Msg := 'Dear ' + MemberActivities.FirstName(Members.Name) + ', A RTGS of KES ' + Format(CashierTrans.Amount) + ' has been processed from your Account at ' + DBranch + ' Teller on ' + Format(Today) + ' ' + Format(Time);
            MemberActivities.SendSms(Source::"Teller Cheque Transfer", MobileNo, Msg, CashierTrans."Transaction No.", CashierTrans."Account No.", false, false)


        end
        else
            if CashierTrans."Account Type" = CashierTrans."account type"::"Non-Member" then begin

                //Bankers Cheque
                //njenga
                if BankingUser.Get(UserId) then begin
                    BankingUser.TestField(BankingUser."Cust. Service Cheque Account");
                    ChBank := BankingUser."Cust. Service Cheque Account";
                end;


                CheckBankersNo(CashierTrans."Bankers Cheque No", CashierTrans."Global Dimension 2 Code", CashierTrans.Amount);




                SaccoActivities.JournalPost(JTemplate, JBatch);

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype::"Bank Account",
                    CashierTrans."Account No.",
                    CopyStr(CashierTrans."Transaction Description" + '-' + CashierTrans.Payee, 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    CashierTrans.Amount,
                    CashierTrans."Bankers Cheque No",
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Cheque Deposit",
                    CashierTrans."Dimension Set ID"
                    );





                MemberActivities.GetGeneral_SharingChargeAmount(CashierTrans."Transaction Type", CashierTrans.Amount, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);

                Members.Get(Savings."Member No.");
                if Employer.Get(Members."Employer Code") then begin
                    if Employer."Dont Charge Transactions" then
                        ChargeAmt := 0;
                end;

                if ChargeAmt > 0 then begin

                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        CashierTrans."Transaction No.",
                        CashierTrans."Transaction Date",
                        ChargeAcctType,
                        ChargeAcct,
                        CopyStr(Format(CashierTrans.Type) + ' Charge', 1, 50),
                        Balaccttype::"G/L Account",
                        '',
                        -(ChargeAmt - SharingAmt),
                        CopyStr(CashierTrans."ID No", 1, 20),
                        '',
                        Transtype::" ",
                        DActivity,
                        DBranch,
                        true,
                        TChannel::"Cheque Deposit",
                    CashierTrans."Dimension Set ID"
                        );

                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        CashierTrans."Transaction No.",
                        CashierTrans."Transaction Date",
                        SharingChargeAcctType,
                        SharingChargeAcct,
                        CopyStr(Format(CashierTrans.Type) + ' Charge', 1, 50),
                        Balaccttype::"G/L Account",
                        '',
                        -(SharingAmt),
                        CopyStr(CashierTrans."ID No", 1, 20),
                        '',
                        Transtype::" ",
                        DActivity,
                        DBranch,
                        true,
                        TChannel::"Cheque Deposit",
                        CashierTrans."Dimension Set ID"
                        );

                end;



                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype::"Bank Account",
                    ChBank,
                    CopyStr(CashierTrans.Payee + '-' + CashierTrans."Cheque No", 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -(CashierTrans.Amount - (ChargeAmt + ChargeDuty)),
                    CashierTrans."Bankers Cheque No",
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Cheque Deposit",
                    CashierTrans."Dimension Set ID"
                    );


                CashierTrans.Posted := true;
                CashierTrans."Date Posted" := Today;
                CashierTrans."Time Posted" := Time;
                CashierTrans."Posted By" := UserId;
                CashierTrans.Modify;

                BRegister.Reset;
                BRegister.SetRange(BRegister."Cheque No.", CashierTrans."Bankers Cheque No");
                BRegister.SetRange("Bankers Cheque Type", CashierTrans."Bankers Cheque Type");
                if BRegister.Find('-') then begin
                    BRegister.Status := BRegister.Status::Approved;
                    BRegister.Modify;
                end;

                SaccoActivities.JournalPost(JTemplate, JBatch);


                //Cashier Transactions
            end;
    end;

    local procedure PostBankersCheq(CashierTrans: Record "Teller Transaction"; JTemplate: Code[20]; JBatch: Code[20]; DBranch: Code[20]; DActivity: Code[20]; BankingUser: Record "Banking User Setup")
    var
        Text0001: label 'This account has been blocked from receiving payments.';
        ChBank: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        Text0002: label 'You cannot issue a Bankers cheque more than the available balance';
        BRegister: Record "Bankers Cheque Register";
        BankAccount: Record "Bank Account";
        Text0009: label 'You have done a ';
        Text0010: label ' transaction of KES ';
        Text0011: label ' on ';
        Text0012: label ' at ';
        Text0006: label 'You cannot withdraw more than your allowed limit of %1 unless authorised.';
        SMSCHarges: Record "SMS charges";
        TotalSms: Decimal;
        SmsExcise: Decimal;
    begin

        if BankingUser.Get(UserId) then begin

            if CashierTrans."Bankers Cheque Type" = CashierTrans."bankers cheque type"::"Co-op Bankers Cheque" then begin
                BankingUser.TestField(BankingUser."Bankers Cheque Account");
                ChBank := BankingUser."Bankers Cheque Account";
            end;
            if CashierTrans."Bankers Cheque Type" = CashierTrans."bankers cheque type"::"Customer Service Cheques" then begin
                BankingUser.TestField(BankingUser."Cust. Service Cheque Account");
                ChBank := BankingUser."Cust. Service Cheque Account";
            end;

        end;

        if CashierTrans."Account Type" = CashierTrans."account type"::Account then begin
            Savings.Get(CashierTrans."Account No.");
            if Savings.Blocked = Savings.Blocked::Payment then
                Error(Text0001);



            if CashierTrans.Type = CashierTrans.Type::"Bankers Cheque" then begin
                if CashierTrans."Available Balance" < CashierTrans.Amount then begin
                    Error(Text0002);
                end;


                if CashierTrans.Status <> CashierTrans.Status::Approved then begin
                    if CashierTrans.Amount > BankingUser."Max. Withdrawal Limit" then begin
                        Message(Text0006, BankingUser."Max. Withdrawal Limit");

                        if Confirm('Do you want to send this transaction for approval?', false) = true then begin
                            VarVariant := CashierTrans;

                            CalwideApprovals.CreateCustomTracker(VarVariant, CashierTrans."Transaction No.", CashierTrans.Amount, Documenttype::"Teller Transaction", CashierTrans."Global Dimension 1 Code", CashierTrans."Global Dimension 2 Code", 0);
                            Commit;
                            Error('Pending Authorization');

                        end;
                        exit;
                    end;
                end;
            end;

            CheckBankersNo(CashierTrans."Bankers Cheque No", CashierTrans."Global Dimension 2 Code", CashierTrans.Amount);

            SaccoActivities.JournalInit(JTemplate, JBatch);

            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                CashierTrans."Transaction No.",
                CashierTrans."Transaction Date",
                Accttype::Savings,
                CashierTrans."Account No.",
                CopyStr(CashierTrans."Bankers Cheque No" + ': ' + CashierTrans."Transaction Description" + '-' + CashierTrans.Payee, 1, 50),
                Balaccttype::"G/L Account",
                '',
                CashierTrans.Amount,
                CashierTrans."Bankers Cheque No",
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true,
                TChannel::"Bankers Cheque Withdrawal",
                CashierTrans."Dimension Set ID"
                );


            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                CashierTrans."Transaction No.",
                CashierTrans."Transaction Date",
                Accttype::"Bank Account",
                ChBank,
                CopyStr(CashierTrans."Bankers Cheque No" + ': ' + CashierTrans.Payee + '-' + CashierTrans."Cheque No", 1, 50),
                Balaccttype::"G/L Account",
                '',
                -CashierTrans.Amount,
                CashierTrans."Bankers Cheque No",
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true,
                TChannel::"Bankers Cheque Withdrawal",
                CashierTrans."Dimension Set ID"
                );

            MemberActivities.GetGeneral_SharingChargeAmountBankers(CashierTrans."Transaction Type", CashierTrans.Amount, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);

            Members.Get(Savings."Member No.");
            if Employer.Get(Members."Employer Code") then begin
                if Employer."Dont Charge Transactions" then
                    ChargeAmt := 0;
            end;
            SMScharges.reset;
            SMScharges.setrange(source, SMScharges.source::"Bankers Cheque");
            if SMScharges.findfirst then begin

                TotalSms := SMSCharges."Charge Amount";
                SmsExcise := Round(SaccoSetup."Excise Duty (%)" * TotalSms * 0.01, 0.1, '<');
                TotalSms += SmsExcise;
                ChargeAmt -= TotalSms;
            end;

            //ChargeAmt -= ChargeDuty; ///

            if ChargeAmt > 0 then begin

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype::Savings,
                    CashierTrans."Account No.",
                    CopyStr(CashierTrans."Bankers Cheque No" + ': ' + Format(CashierTrans.Type) + ' Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    ChargeAmt,
                    CopyStr(CashierTrans."ID No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Bankers Cheque Withdrawal",
                    CashierTrans."Dimension Set ID"
                    );


                SaccoSetup.Get;
                if ChargeDuty > 0 then begin

                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        CashierTrans."Transaction No.",
                        CashierTrans."Transaction Date",
                        Accttype::Savings,
                        CashierTrans."Account No.",
                        CopyStr(CashierTrans."Bankers Cheque No" + ': ' + 'Excise Duty on ' + Format(CashierTrans.Type) + ' member withdrawal', 1, 50),
                        Balaccttype::"G/L Account",
                        SaccoSetup."Excise Duty GL",
                        ChargeDuty,
                        CopyStr(CashierTrans."ID No", 1, 20),
                        '',
                        Transtype::" ",
                        DActivity,
                        DBranch,
                        true,
                        TChannel::"Bankers Cheque Withdrawal",
                        CashierTrans."Dimension Set ID"
                        );
                end;


                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    ChargeAcctType,
                    ChargeAcct,
                    CopyStr(CashierTrans."Bankers Cheque No" + ': ' + Format(CashierTrans.Type) + ' Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -(ChargeAmt),
                    CopyStr(CashierTrans."ID No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Bankers Cheque Withdrawal",
                        CashierTrans."Dimension Set ID"
                    );

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                     Accttype::Savings,
                     CashierTrans."Account No.",
                    CopyStr(CashierTrans."Bankers Cheque No" + ': ' + 'Bankers cheque settlement Co-Op', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    SharingAmt,
                    CopyStr(CashierTrans."ID No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Bankers Cheque Withdrawal",
                    CashierTrans."Dimension Set ID"
                    );

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    SharingChargeAcctType,
                    SharingChargeAcct,
                    CopyStr(CashierTrans."Bankers Cheque No" + ': ' + 'Bankers cheque settlement Co-Op', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -(SharingAmt - SharingDuty),
                    CopyStr(CashierTrans."ID No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Bankers Cheque Withdrawal",
                    CashierTrans."Dimension Set ID"
                    );

                if SharingDuty > 0 then
                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        CashierTrans."Transaction No.",
                        CashierTrans."Transaction Date",
                        SharingChargeAcctType,
                        SharingChargeAcct,
                        CopyStr(CashierTrans."Bankers Cheque No" + ': ' + 'Bankers cheque settlement Co-Op', 1, 50),
                        Balaccttype::"G/L Account",
                        '',
                        -(SharingDuty),
                        CopyStr(CashierTrans."ID No", 1, 20),
                        '',
                        Transtype::" ",
                        DActivity,
                        DBranch,
                        true,
                        TChannel::"Bankers Cheque Withdrawal",
                        CashierTrans."Dimension Set ID"
                        );

            end;



            CashierTrans.Posted := true;
            CashierTrans."Date Posted" := Today;
            CashierTrans."Time Posted" := Time;
            CashierTrans."Posted By" := UserId;
            CashierTrans.Modify;


            BRegister.Reset;
            BRegister.SetRange(BRegister."Cheque No.", CashierTrans."Bankers Cheque No");
            BRegister.SetRange("Bankers Cheque Type", CashierTrans."Bankers Cheque Type");
            if BRegister.Find('-') then begin
                BRegister.Status := BRegister.Status::Approved;
                BRegister.Modify;
            end;


            Msg := 'Dear ' + MemberActivities.FirstName(Members.Name) + ', A Bankers Cheque of KES ' + Format(CashierTrans.Amount) + ' has been processed from your Account at ' + DBranch + ' Teller on ' + Format(Today) + ' ' + Format(Time);
            MemberActivities.SendSms(Source::"Teller Cheque Deposit", MobileNo, Msg, CashierTrans."Transaction No.", CashierTrans."Account No.", false, false);

            SMScharges.reset;
            SMScharges.setrange(source, SMScharges.source::"Bankers Cheque");
            if SMScharges.findfirst then begin
                TotalSms := 0;
                SmsExcise := 0;

                TotalSms := SMSCharges."Charge Amount";
                SmsExcise := Round(SaccoSetup."Excise Duty (%)" * TotalSms * 0.01, 0.1, '<');
                TotalSms += SmsExcise;

                SaccoSetup.Get();
                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype::Savings,
                    CashierTrans."Account No.",
                    CopyStr('Sms Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    SMSCHarges."Charge G/L Account",
                    TotalSms - SmsExcise,
                    CashierTrans."Bankers Cheque No",
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Bankers Cheque Withdrawal",
                    CashierTrans."Dimension Set ID"
                    );

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype::Savings,
                    CashierTrans."Account No.",
                    CopyStr('Excise Duty on Sms Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    SaccoSetup."Excise Duty GL",
                    SmsExcise,
                    CashierTrans."Bankers Cheque No",
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Bankers Cheque Withdrawal",
                    CashierTrans."Dimension Set ID"
                );

            end;

            SaccoActivities.JournalPost(JTemplate, JBatch);
        end
        else
            if CashierTrans."Account Type" = CashierTrans."account type"::"Non-Member" then begin

                //Bankers Cheque
                //njenga
                if BankingUser.Get(UserId) then begin
                    BankingUser.TestField(BankingUser."Cust. Service Cheque Account");
                    ChBank := BankingUser."Cust. Service Cheque Account";
                end;


                CheckBankersNo(CashierTrans."Bankers Cheque No", CashierTrans."Global Dimension 2 Code", CashierTrans.Amount);




                SaccoActivities.JournalPost(JTemplate, JBatch);

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype::"Bank Account",
                    CashierTrans."Account No.",
                    CopyStr(CashierTrans."Bankers Cheque No" + ' : ' + CashierTrans."Transaction Description" + '-' + CashierTrans.Payee, 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    CashierTrans.Amount,
                    CashierTrans."Bankers Cheque No",
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Bankers Cheque Withdrawal",
                    CashierTrans."Dimension Set ID"
                    );





                MemberActivities.GetGeneral_SharingChargeAmount(CashierTrans."Transaction Type", CashierTrans.Amount, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);

                Members.Get(Savings."Member No.");
                if Employer.Get(Members."Employer Code") then begin
                    if Employer."Dont Charge Transactions" then
                        ChargeAmt := 0;
                end;

                if ChargeAmt > 0 then begin

                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        CashierTrans."Transaction No.",
                        CashierTrans."Transaction Date",
                        ChargeAcctType,
                        ChargeAcct,
                        CopyStr(CashierTrans."Bankers Cheque No" + ': ' + Format(CashierTrans.Type) + ' Charge', 1, 50),
                        Balaccttype::"G/L Account",
                        '',
                        -(ChargeAmt - SharingAmt),
                        CopyStr(CashierTrans."ID No", 1, 20),
                        '',
                        Transtype::" ",
                        DActivity,
                        DBranch,
                        true,
                        TChannel::"Bankers Cheque Withdrawal",
                    CashierTrans."Dimension Set ID"
                        );

                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        CashierTrans."Transaction No.",
                        CashierTrans."Transaction Date",
                        SharingChargeAcctType,
                        SharingChargeAcct,
                        CopyStr(CashierTrans."Bankers Cheque No" + ' Bankers cheque settlement Co-Op', 1, 50),
                        Balaccttype::"G/L Account",
                        '',
                        -(SharingAmt - SharingDuty),
                        CopyStr(CashierTrans."ID No", 1, 20),
                        '',
                        Transtype::" ",
                        DActivity,
                        DBranch,
                        true,
                        TChannel::"Bankers Cheque Withdrawal",
                        CashierTrans."Dimension Set ID"
                        );

                    if SharingDuty > 0 then
                        SaccoActivities.JournalInsert(
                            JTemplate,
                            JBatch,
                            CashierTrans."Transaction No.",
                            CashierTrans."Transaction Date",
                            SharingChargeAcctType,
                            SharingChargeAcct,
                            CopyStr(CashierTrans."Bankers Cheque No" + ' Bankers cheque settlement Co-Op', 1, 50),
                            Balaccttype::"G/L Account",
                            '',
                            -(SharingDuty),
                            CopyStr(CashierTrans."ID No", 1, 20),
                            '',
                            Transtype::" ",
                            DActivity,
                            DBranch,
                            true,
                            TChannel::"Bankers Cheque Withdrawal",
                            CashierTrans."Dimension Set ID"
                            );

                end;



                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype::"Bank Account",
                    ChBank,
                    CopyStr(CashierTrans.Payee + '-' + CashierTrans."Cheque No", 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -(CashierTrans.Amount - (ChargeAmt + ChargeDuty)),
                    CashierTrans."Bankers Cheque No",
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Bankers Cheque Withdrawal",
                    CashierTrans."Dimension Set ID"
                    );


                CashierTrans.Posted := true;
                CashierTrans."Date Posted" := Today;
                CashierTrans."Time Posted" := Time;
                CashierTrans."Posted By" := UserId;
                CashierTrans.Modify;

                BRegister.Reset;
                BRegister.SetRange(BRegister."Cheque No.", CashierTrans."Bankers Cheque No");
                BRegister.SetRange("Bankers Cheque Type", CashierTrans."Bankers Cheque Type");
                if BRegister.Find('-') then begin
                    BRegister.Status := BRegister.Status::Approved;
                    BRegister.Modify;
                end;

                SaccoActivities.JournalPost(JTemplate, JBatch);


                //Cashier Transactions
            end;
    end;

    local procedure PostBankersCheqGL(CashierTrans: Record "Teller Transaction"; JTemplate: Code[20]; JBatch: Code[20]; DBranch: Code[20]; DActivity: Code[20]; BankingUser: Record "Banking User Setup")
    var
        Text0001: label 'This account has been blocked from receiving payments.';
        ChBank: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        Text0002: label 'You cannot issue a Bankers cheque more than the available balance';
        BRegister: Record "Bankers Cheque Register";
        BankAccount: Record "Bank Account";
        Text0009: label 'You have done a ';
        Text0010: label ' transaction of KES ';
        Text0011: label ' on ';
        Text0012: label ' at ';
    begin

        if BankingUser.Get(UserId) then begin

            if CashierTrans."Bankers Cheque Type" = CashierTrans."bankers cheque type"::"Co-op Bankers Cheque" then begin
                BankingUser.TestField(BankingUser."Bankers Cheque Account");
                ChBank := BankingUser."Bankers Cheque Account";
            end;
            if CashierTrans."Bankers Cheque Type" = CashierTrans."bankers cheque type"::"Customer Service Cheques" then begin
                BankingUser.TestField(BankingUser."Cust. Service Cheque Account");
                ChBank := BankingUser."Cust. Service Cheque Account";
            end;

        end;

        if CashierTrans."Account Type" = CashierTrans."account type"::"G/L Account" then begin

            GLAccount.Get(CashierTrans."Account No.");


            if CashierTrans.Type = CashierTrans.Type::"Bankers Cheque" then begin
                //if "Available Balance" < Amount then begin
                //  Error(Text0002);
                //end;
            end;

            CheckBankersNo(CashierTrans."Bankers Cheque No", CashierTrans."Global Dimension 2 Code", CashierTrans.Amount);

            SaccoActivities.JournalInit(JTemplate, JBatch);

            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                CashierTrans."Transaction No.",
                CashierTrans."Transaction Date",
                Accttype::"G/L Account",
                CashierTrans."Account No.",
                CopyStr(CashierTrans."Bankers Cheque No" + ': ' + CashierTrans."Transaction Description" + '-' + CashierTrans.Payee, 1, 50),
                Balaccttype::"G/L Account",
                '',
                CashierTrans.Amount,
                CashierTrans."Bankers Cheque No",
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true,
                TChannel::"Cheque Deposit",
                    CashierTrans."Dimension Set ID"
                );


            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                CashierTrans."Transaction No.",
                CashierTrans."Transaction Date",
                Accttype::"Bank Account",
                ChBank,
                CopyStr(CashierTrans."Bankers Cheque No" + ': ' + CashierTrans.Payee + '-' + CashierTrans."Cheque No", 1, 50),
                Balaccttype::"G/L Account",
                '',
                -CashierTrans.Amount,
                CashierTrans."Bankers Cheque No",
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true,
                TChannel::"Cheque Deposit",
                    CashierTrans."Dimension Set ID"
                );





            /*
            MemberActivities.GetGeneral_SharingChargeAmount("Transaction Type", Amount, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);

            Members.Get(Savings."Member No.");
            if Employer.Get(Members."Employer Code") then begin
                if Employer."Dont Charge Transactions" then
                    ChargeAmt := 0;
            end;

            if ChargeAmt > 0 then begin

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    "Transaction No.",
                    "Transaction Date",
                    Accttype::Savings,
                    "Account No.",
                    CopyStr(Format(Type) + ' Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    ChargeAmt,
                    CopyStr("ID No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true
                    );


                SaccoSetup.Get;
                if ChargeDuty > 0 then begin

                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        "Transaction No.",
                        "Transaction Date",
                        Accttype::Savings,
                        "Account No.",
                        CopyStr('Excise Duty on ' + Format(Type) + ' Charge', 1, 50),
                        Balaccttype::"G/L Account",
                        SaccoSetup."Excise Duty GL",
                        ChargeDuty,
                        CopyStr("ID No", 1, 20),
                        '',
                        Transtype::" ",
                        DActivity,
                        DBranch,
                        true
                        );
                end;


                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    "Transaction No.",
                    "Transaction Date",
                    ChargeAcctType,
                    ChargeAcct,
                    CopyStr(Format(Type) + ' Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -(ChargeAmt - SharingAmt),
                    CopyStr("ID No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true
                    );

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    "Transaction No.",
                    "Transaction Date",
                    SharingChargeAcctType,
                    SharingChargeAcct,
                    CopyStr(Format(Type) + ' Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -(SharingAmt),
                    CopyStr("ID No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true
                    );

            end;
            */



            CashierTrans.Posted := true;
            CashierTrans."Date Posted" := Today;
            CashierTrans."Time Posted" := Time;
            CashierTrans."Posted By" := UserId;
            CashierTrans.Modify;


            BRegister.Reset;
            BRegister.SetRange(BRegister."Cheque No.", CashierTrans."Bankers Cheque No");
            BRegister.SetRange("Bankers Cheque Type", CashierTrans."Bankers Cheque Type");
            if BRegister.Find('-') then begin
                BRegister.Status := BRegister.Status::Approved;
                BRegister.Modify;
            end;

            SaccoActivities.JournalPost(JTemplate, JBatch);

            //Msg := 'Dear ' + MemberActivities.FirstName(Members.Name) + ', A Bankers Cheque of KES ' + Format(Amount) + ' has been processed from your Account at ' + DBranch + ' Teller on ' + Format(Today) + ' ' + Format(Time);
            //MemberActivities.SendSms(Source::"Teller Cheque Deposit", MobileNo, Msg, "Transaction No.", "Account No.", false, false)


        end
        else
            if CashierTrans."Account Type" = CashierTrans."account type"::"Non-Member" then begin

                //Bankers Cheque
                //njenga
                if BankingUser.Get(UserId) then begin
                    BankingUser.TestField(BankingUser."Cust. Service Cheque Account");
                    ChBank := BankingUser."Cust. Service Cheque Account";
                end;


                CheckBankersNo(CashierTrans."Bankers Cheque No", CashierTrans."Global Dimension 2 Code", CashierTrans.Amount);




                SaccoActivities.JournalPost(JTemplate, JBatch);

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype::"Bank Account",
                    CashierTrans."Account No.",
                    CopyStr(CashierTrans."Transaction Description" + '-' + CashierTrans.Payee, 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    CashierTrans.Amount,
                    CashierTrans."Bankers Cheque No",
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Cheque Deposit",
                    CashierTrans."Dimension Set ID"

                    );





                MemberActivities.GetGeneral_SharingChargeAmount(CashierTrans."Transaction Type", CashierTrans.Amount, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);

                Members.Get(Savings."Member No.");
                if Employer.Get(Members."Employer Code") then begin
                    if Employer."Dont Charge Transactions" then
                        ChargeAmt := 0;
                end;

                if ChargeAmt > 0 then begin

                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        CashierTrans."Transaction No.",
                        CashierTrans."Transaction Date",
                        ChargeAcctType,
                        ChargeAcct,
                        CopyStr(Format(CashierTrans.Type) + ' Charge', 1, 50),
                        Balaccttype::"G/L Account",
                        '',
                        -(ChargeAmt - SharingAmt),
                        CopyStr(CashierTrans."ID No", 1, 20),
                        '',
                        Transtype::" ",
                        DActivity,
                        DBranch,
                        true,
                        TChannel::"Cheque Deposit",
                    CashierTrans."Dimension Set ID"
                        );

                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        CashierTrans."Transaction No.",
                        CashierTrans."Transaction Date",
                        SharingChargeAcctType,
                        SharingChargeAcct,
                        CopyStr(Format(CashierTrans.Type) + ' Charge', 1, 50),
                        Balaccttype::"G/L Account",
                        '',
                        -(SharingAmt),
                        CopyStr(CashierTrans."ID No", 1, 20),
                        '',
                        Transtype::" ",
                        DActivity,
                        DBranch,
                        true,
                        TChannel::"Cheque Deposit",
                    CashierTrans."Dimension Set ID"
                        );

                end;



                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    CashierTrans."Transaction Date",
                    Accttype::"Bank Account",
                    ChBank,
                    CopyStr(CashierTrans.Payee + '-' + CashierTrans."Cheque No", 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -(CashierTrans.Amount - (ChargeAmt + ChargeDuty)),
                    CashierTrans."Bankers Cheque No",
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Cheque Deposit",
                    CashierTrans."Dimension Set ID"
                    );


                CashierTrans.Posted := true;
                CashierTrans."Date Posted" := Today;
                CashierTrans."Time Posted" := Time;
                CashierTrans."Posted By" := UserId;
                CashierTrans.Modify;

                BRegister.Reset;
                BRegister.SetRange(BRegister."Cheque No.", CashierTrans."Bankers Cheque No");
                BRegister.SetRange("Bankers Cheque Type", CashierTrans."Bankers Cheque Type");
                if BRegister.Find('-') then begin
                    BRegister.Status := BRegister.Status::Approved;
                    BRegister.Modify;
                end;

                SaccoActivities.JournalPost(JTemplate, JBatch);


                //Cashier Transactions
            end;
    end;

    local procedure PostCredit(CashierTrans: Record "Teller Transaction"; JTemplate: Code[20]; JBatch: Code[20]; TillNo: Code[20]; DBranch: Code[20]; DActivity: Code[20]; PDate: Date; CreditCheque: Boolean)
    var
        TellerLines: Record "Teller Lines";
        AppraisalAmt: Decimal;
        RunBal: Decimal;
        LoanRep: Decimal;
        Loans: Record Loans;
        Members: Record Members;
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        GracePeriod: DateFormula;
        ArrearsDate: Date;
        j: integer;
        ExpectedBal: Decimal;
        CurrentBal: Decimal;
        SaccoActivities: Codeunit "Sacco Activities";
    begin

        if CreditCheque then begin
            AcctType := Accttype::Savings;
            AccNo := CashierTrans."Account No.";
        end
        else begin
            AcctType := Accttype::"Bank Account";
            AccNo := TillNo;
        end;

        SaccoActivities.JournalInsert(
            JTemplate,
            JBatch,
            CashierTrans."Transaction No.",
            PDate,
            AcctType,
            AccNo,
            CopyStr(Format(CashierTrans.Type) + ' - ' + CashierTrans."Account Name" + '-' + CashierTrans."Cheque No", 1, 50),
            Balaccttype::"G/L Account",
            '',
            CashierTrans.Amount,
            CashierTrans."Cheque No",
            '',
            Transtype::" ",
            DActivity,
            DBranch,
            true,
            TChannel::"Credit Receipt",
            CashierTrans."Dimension Set ID"
            );

        TellerLines.Reset;
        TellerLines.SetRange("Transaction No.", CashierTrans."Transaction No.");
        if TellerLines.Find('-') then begin
            repeat

                RunBal := TellerLines.Amount;

                if TellerLines.Type = TellerLines.Type::Credit then begin


                    Loans.Reset();
                    Loans.SetRange("Loan No.", TellerLines."Loan No.");
                    Loans.SetFilter("Total Outstanding Balance", '>0');
                    if Loans.FindFirst() then begin
                        Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest", Loans."Outstanding Penalty", Loans."Outstanding Appraisal");
                        DefAmount := 0;
                        ExpectedBal := 0;
                        CurrentBal := 0;
                        LoanRep := 0;

                        if Members.get(Loans."Member No.") then begin
                            /*
                            if Members.Blocked <> Members.Blocked::" " then begin
                                Members.Blocked := Members.Blocked::" ";
                                Members.Modify();
                            end;
                            */
                        end;
                        if Loans."Outstanding Appraisal" < 0 then
                            Loans."Outstanding Appraisal" := 0;

                        if Loans."Outstanding Interest" < 0 then
                            Loans."Outstanding Interest" := 0;
                        if Loans."Outstanding Penalty" < 0 then
                            Loans."Outstanding Penalty" := 0;



                        if Loans."Outstanding Penalty" > RunBal then
                            Loans."Outstanding Penalty" := RunBal;

                        if (Loans."Outstanding Penalty" > 0) then begin


                            SaccoActivities.JournalInsert(
                                JTemplate,
                                JBatch,
                                CashierTrans."Transaction No.",
                                PDate,
                                Accttype::Credit,
                                TellerLines."Account No.",
                                CopyStr('Receipt Penalty: ' + CashierTrans."Transaction No.", 1, 50),
                                Balaccttype::"G/L Account",
                                '',
                                -Loans."Outstanding Penalty",
                                CashierTrans."Cheque No",
                                Loans."Loan No.",
                                Transtype::"Penalty Paid",
                                DActivity,
                                DBranch,
                                true,
                                TChannel::"Credit Receipt",
                                CashierTrans."Dimension Set ID"
                                );

                            RunBal -= Loans."Outstanding Penalty";
                        end;


                        /*if Loans."Outstanding Appraisal" > RunBal then
                            Loans."Outstanding Appraisal" := RunBal;
                        if Loans."Outstanding Appraisal" > 0 then begin


                            SaccoActivities.JournalInsert(
                                JTemplate,
                                JBatch,
                                "Transaction No.",
                                PDate,
                                Accttype::Credit,
                                TellerLines."Account No.",
                                CopyStr('Receipt Appraisal: ' + "Transaction No.", 1, 50),
                                Balaccttype::"G/L Account",
                                '',
                                -Loans."Outstanding Appraisal",
                                "Cheque No",
                                Loans."Loan No.",
                                Transtype::"Appraisal Paid",
                                DActivity,
                                DBranch,
                                true,
                                TChannel::"Credit Receipt",
                                "Dimension Set ID"
                                );

                            RunBal -= Loans."Outstanding Appraisal";
                        end;
                        */


                        if (Loans."Outstanding Interest" > 0) then begin //Current interest

                            Loans."Outstanding Interest" -= SaccoActivities.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Interest Paid");
                            if Loans."Outstanding Interest" > RunBal then
                                Loans."Outstanding Interest" := RunBal;

                            SaccoActivities.JournalInsert(
                                JTemplate,
                                JBatch,
                                CashierTrans."Transaction No.",
                                PDate,
                                Accttype::Credit,
                                TellerLines."Account No.",
                                CopyStr('Receipt interest paid:  ' + CashierTrans."Transaction No.", 1, 50),
                                Balaccttype::"G/L Account",
                                '',
                                -Loans."Outstanding Interest",
                                CashierTrans."Cheque No",
                                Loans."Loan No.",
                                Transtype::"Interest Paid",
                                DActivity,
                                DBranch,
                                true,
                                TChannel::"Credit Receipt",
                                CashierTrans."Dimension Set ID"
                                );

                            RunBal -= Loans."Outstanding Interest";
                        end;


                        if (Loans."Outstanding Principal" > 0) then begin //Currrent principle

                            Loans."Outstanding Principal" -= SaccoActivities.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Principal Repayment");

                            LoanRep := RunBal;
                            if LoanRep > Loans."Outstanding Principal" then
                                LoanRep := Loans."Outstanding Principal";


                            SaccoActivities.JournalInsert(
                                JTemplate,
                                JBatch,
                                CashierTrans."Transaction No.",
                                PDate,
                                Accttype::Credit,
                                TellerLines."Account No.",
                                CopyStr('Receipt Principal Repayment: ' + CashierTrans."Transaction No.", 1, 50),
                                Balaccttype::"G/L Account",
                                '',
                                -LoanRep,
                                CashierTrans."Cheque No",
                                Loans."Loan No.",
                                Transtype::"Principal Repayment",
                                DActivity,
                                DBranch,
                                true,
                                TChannel::"Credit Receipt",
                                CashierTrans."Dimension Set ID"
                                );

                            RunBal -= LoanRep;
                        end;

                        if RunBal <= 0 then RunBal := 0;

                        if RunBal > 0 then begin

                            SaccoActivities.JournalInsert(
                                JTemplate,
                                JBatch,
                                CashierTrans."Transaction No.",
                                PDate,
                                Accttype::Savings,
                                CashierTrans."Account No.",
                                CopyStr('Excess Receipt ' + CashierTrans."Transaction No.", 1, 50),
                                Balaccttype::"G/L Account",
                                '',
                                -RunBal,
                                CashierTrans."Cheque No",
                                '',
                                Transtype::" ",
                                DActivity,
                                DBranch,
                                true,
                                TChannel::"Credit Receipt",
                                CashierTrans."Dimension Set ID"
                                );
                        end;

                    end;
                end

                else
                    if TellerLines.Type = TellerLines.Type::Savings then begin
                        SaccoActivities.JournalInsert(
                            JTemplate,
                            JBatch,
                            CashierTrans."Transaction No.",
                            PDate,
                            Accttype::Savings,
                            TellerLines."Account No.",
                            CopyStr('Receipt ' + CashierTrans."Transaction No.", 1, 50),
                            Balaccttype::"G/L Account",
                            '',
                            -TellerLines.Amount,
                            CashierTrans."Cheque No",
                            '',
                            Transtype::" ",
                            DActivity,
                            DBranch,
                            true,
                            TChannel::"Credit Receipt",
                                CashierTrans."Dimension Set ID"
                            );

                    end
                    else begin


                        SaccoActivities.JournalInsert(
                            JTemplate,
                            JBatch,
                            CashierTrans."Transaction No.",
                            PDate,
                            Accttype::"G/L Account",
                            TellerLines."Account No.",
                            CopyStr('Receipt ' + CashierTrans."Transaction No.", 1, 50),
                            Balaccttype::"G/L Account",
                            '',
                            -TellerLines.Amount,
                            CashierTrans."Cheque No",
                            '',
                            Transtype::" ",
                            DActivity,
                            DBranch,
                            true,
                            TChannel::"Credit Receipt",
                                CashierTrans."Dimension Set ID"
                            );


                    end;
            until TellerLines.Next = 0;
        end;
    end;

    procedure ClearCheques_Stage2()
    var
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
    begin
        /*
        BankingUser.GET(USERID);
        SaccoSetup.GET;
        
        IF NOT BankingUser."Chief Accountant" THEN
          ERROR('You Must be Setup as a Chief Accountant to Process the selected cheque(s)');
        
        
        Jtemplate:=BankingUser."Cashier Journal Template";JBatch:=BankingUser."Cashier Journal Batch";
        BankingUser.TESTFIELD("Cheque Clearance Account");
        
        IF Jtemplate='' THEN
          BEGIN
            ERROR(Text0001);
          END;
        
        IF JBatch='' THEN
          BEGIN
            ERROR(Text0002);
          END;
        
        
        //MESSAGE('T1');
        Transactions.RESET;
        Transactions.SETRANGE(Posted,TRUE);
        Transactions.SETRANGE(Transactions.Select,TRUE);
        Transactions.SETRANGE("Selected By",USERID);
        Transactions.SETRANGE(Transactions."Cheque Status",Transactions."Cheque Status"::Pending);
        Transactions.SETRANGE("Cheque Location",Transactions."Cheque Location"::Accountant);
        Transactions.SETRANGE("Cheques Issued",Transactions."Cheques Issued"::Yes);
        Transactions.SETRANGE("Cheques Received",Transactions."Cheques Received"::Yes);
        IF Transactions.FIND('-') THEN BEGIN
            REPEAT
              //MESSAGE('T2');
                IF (Transactions.Type=Transactions.Type::"Cheque Deposit") OR (Transactions.Type=Transactions.Type::"Credit Cheque")  THEN BEGIN
                    //MESSAGE('T3');
                    IF Transactions.Posted THEN BEGIN
                      //MESSAGE('T4');
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",Jtemplate);
                        GenJournalLine.SETRANGE("Journal Batch Name",JBatch);
                        GenJournalLine.DELETEALL;
        
                        IF Transactions."Account Name"='' THEN BEGIN
                            TellerLines.RESET;
                            TellerLines.SETRANGE("Transaction No",Transactions.No);
                            IF TellerLines.FIND('-') THEN
                                Transactions."Account Name" := TellerLines.Description;
                        END;
                        IF Transactions."Account Name"='' THEN
                          Transactions."Account Name":=Transactions.Remarks;
        
        
                        SaccoSetup.GET;
        
                        ChBank:=BankingUser."Cheque Clearance Account";
        
                        LineNo:=LineNo+10000;
        
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name":=Jtemplate;
                        GenJournalLine."Journal Batch Name":=JBatch;
                        GenJournalLine."External Document No.":=Transactions."Cheque No";
                        GenJournalLine."Document No.":=Transactions.No;
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                        GenJournalLine."Account No.":=SaccoSetup."Cheque Clearance GL";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=TODAY;
                        IF Transactions."Cheque Clearing Date"<>0D THEN
                        GenJournalLine."Posting Date":=Transactions."Cheque Clearing Date";
                        GenJournalLine.Description:=PADSTR(Transactions."Transaction Description" +'-'+ Transactions.Remarks,50) ;
                        GenJournalLine."Currency Code":=Transactions."Currency Code";
                        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=-Transactions.Amount;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=Transactions."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code":=Transactions."Global Dimension 2 Code";
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                        IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.INSERT;
        
        
                        LineNo:=LineNo+10000;
        
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name":=Jtemplate;
                        GenJournalLine."Journal Batch Name":=JBatch;
                        GenJournalLine."External Document No.":=Transactions."Cheque No";
                        GenJournalLine."Document No.":=Transactions.No;
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."Account Type"::"Bank Account";
                        GenJournalLine."Account No.":=ChBank;
                        IF Transactions."Cheque Clearing Bank"<>'' THEN
                        GenJournalLine."Account No.":=Transactions."Cheque Clearing Bank";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=TODAY;
                        IF Transactions."Cheque Clearing Date"<>0D THEN
                        GenJournalLine."Posting Date":=Transactions."Cheque Clearing Date";
                        GenJournalLine.Description:=Transactions."Account Name";
                        GenJournalLine."Currency Code":=Transactions."Currency Code";
                        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=Transactions.Amount;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=Transactions."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code":=Transactions."Global Dimension 2 Code";
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                        IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.INSERT;
        
        
        
        
        {
        //Charges
        TCharges:=0;
        
        TransactionCharges.RESET;
        TransactionCharges.SETRANGE(TransactionCharges."Transaction Type",Transactions."Transaction Type");
        IF TransactionCharges.FIND('-') THEN BEGIN
        REPEAT
        LineNo:=LineNo+10000;
        
        ChargeAmount:=0;
        IF TransactionCharges."Charge Type"=TransactionCharges."Charge Type"::"% of Amount" = TRUE THEN
        ChargeAmount:=(Transactions.Amount*TransactionCharges."Percentage of Amount")*0.01
        ELSE ChargeAmount:=TransactionCharges."Charge Amount";
        
        IF TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered THEN BEGIN
        
        TransactionCharges.TESTFIELD(TransactionCharges."Staggered Charge Code");
        
        TariffDetails.RESET;
        TariffDetails.SETRANGE(TariffDetails.Code,TransactionCharges."Staggered Charge Code");
        IF TariffDetails.FIND('-') THEN BEGIN
        REPEAT
        IF (Transactions.Amount >= TariffDetails."Lower Limit") AND (Transactions.Amount <= TariffDetails."Upper Limit") THEN BEGIN
        IF TariffDetails."Use Percentage"=TRUE THEN BEGIN
          ChargeAmount:=Transactions.Amount*TariffDetails.Percentage*0.01;
        END ELSE BEGIN
        ChargeAmount := TariffDetails."Charge Amount";
        END;
        END;
        UNTIL TariffDetails.NEXT =0;
        END;
        END;
        
        
        
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name":=Jtemplate;
        GenJournalLine."Journal Batch Name":=JBatch;
        GenJournalLine."Document No.":=Transactions.No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Savings;
        GenJournalLine."Account No.":=Transactions."Account No.";
        GenJournalLine."External Document No.":=Transactions."ID No";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":=Transactions."Transaction Date";
        GenJournalLine.Description:=TransactionCharges.Description;
        GenJournalLine."Currency Code":=Transactions."Currency Code";
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=ChargeAmount;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=TransactionCharges."G/L Account";
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=Transactions."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code":=Transactions."Global Dimension 2 Code";
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount<>0 THEN
        GenJournalLine.INSERT;
        
        
        //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN
        
        IF TransactionCharges."Transaction Charge Category"<>TransactionCharges."Transaction Charge Category"::"Stamp Duty" THEN BEGIN
        
        //Excise Duty
        
        LineNo:=LineNo+10000;
        
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name":=Jtemplate;
        GenJournalLine."Journal Batch Name":=JBatch;
        GenJournalLine."Document No.":=Transactions.No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Savings;
        GenJournalLine."Account No.":=Transactions."Account No.";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":=Transactions."Transaction Date";
        GenJournalLine.Description:='Excise Duty';
        GenJournalLine."Currency Code":=Transactions."Currency Code";
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=(ChargeAmount*SaccoSetup."Excise Duty (%)")*0.01;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=SaccoSetup."Excise Duty G/L";
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=Transactions."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code":=Transactions."Global Dimension 2 Code";
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount<>0 THEN
        GenJournalLine.INSERT;
        
        TChargeAmount:=TChargeAmount+ChargeAmount;
        END;
        UNTIL TransactionCharges.NEXT = 0;
        END;
        
        }
        
        //Recover Discounting
        IF Transactions."Discounted Amount" > 0 THEN BEGIN
        
            Loans.RESET;
            Loans.SETRANGE(Loans.Remarks,Transactions.No);
            Loans.SETRANGE(Loans."Member No.",Transactions."Member No.");
            Loans.SETRANGE(Loans.Posted,TRUE);
            IF Loans.FIND('-') THEN BEGIN
            REPEAT
        
            Loans.CALCFIELDS(Loans."Outstanding Balance");
        
            LineNo:=LineNo+10000;
        
            GenJournalLine.INIT;
            GenJournalLine."Journal Template Name":=Jtemplate;
            GenJournalLine."Journal Batch Name":=JBatch;
            GenJournalLine."Line No.":=LineNo;
            GenJournalLine."Document No.":=Transactions.No;
            GenJournalLine."External Document No.":=Loans."Loan No.";
            GenJournalLine."Posting Date":=TODAY;
            IF Transactions."Cheque Clearing Date"<>0D THEN
            GenJournalLine."Posting Date":=Transactions."Cheque Clearing Date";
            GenJournalLine."Account Type":=GenJournalLine."Account Type"::Credit;
            GenJournalLine."Account No.":=Loans."Loan Account";
            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
            GenJournalLine.Description:='Discounting Loan Recovery';
            GenJournalLine.Amount:=-Loans."Outstanding Balance";
            GenJournalLine.VALIDATE(GenJournalLine.Amount);
            GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Repayment;
            GenJournalLine."Loan No":=Loans."Loan No.";
            GenJournalLine."Shortcut Dimension 1 Code":=Transactions."Global Dimension 1 Code";
            GenJournalLine."Shortcut Dimension 2 Code":=Transactions."Global Dimension 2 Code";
            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
            IF GenJournalLine.Amount<>0 THEN
            GenJournalLine.INSERT;
        
        
        
            LineNo:=LineNo+10000;
        
            GenJournalLine.INIT;
            GenJournalLine."Journal Template Name":=Jtemplate;
            GenJournalLine."Journal Batch Name":=JBatch;
            GenJournalLine."Line No.":=LineNo;
            GenJournalLine."Document No.":=Transactions.No;
            GenJournalLine."External Document No.":=Loans."Loan No.";
            GenJournalLine."Posting Date":=TODAY;
            IF Transactions."Cheque Clearing Date"<>0D THEN
            GenJournalLine."Posting Date":=Transactions."Cheque Clearing Date";
            GenJournalLine."Account Type":=GenJournalLine."Bal. Account Type"::Savings;
            GenJournalLine."Account No.":=Transactions."Account No.";
            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
            GenJournalLine.Description:='Discounting Loan Recovery';
            GenJournalLine.Amount:=(Loans."Outstanding Balance");
            GenJournalLine.VALIDATE(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code":=Transactions."Global Dimension 1 Code";
            GenJournalLine."Shortcut Dimension 2 Code":=Transactions."Global Dimension 2 Code";
            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
            IF GenJournalLine.Amount<>0 THEN
            GenJournalLine.INSERT;
        
        
            UNTIL Loans.NEXT = 0;
        
            END ELSE
            ERROR('Discounting loan for %1 not found.',Transactions.No);
            END;
        
        //Recover Discounting
        
        
        
        //Post New
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name",Jtemplate);
        GenJournalLine.SETRANGE("Journal Batch Name",JBatch);
        IF GenJournalLine.FIND('-') THEN BEGIN
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post New",GenJournalLine);
        END;
        //Post New
        
        //Transactions."Cheque Status":=Transactions."Cheque Status"::Honoured;
        Transactions."Cheque Location":=Transactions."Cheque Location"::"Awaiting Clearance";
        Transactions."Chief Cashier Select":=FALSE;
        Transactions."Selected By":='';
        Transactions.MODIFY;
        
        END;
        END;
        UNTIL Transactions.NEXT=0;
        END;
        */

    end;


    procedure ProcessCheque(CashierTransactions: Record "Teller Transaction")
    var
        Transactions: Record "Teller Transaction";
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Loans: Record Loans;
        DBranch: Code[10];
        DActivity: Code[10];
        PDate: Date;
    begin
        BankingUser.Get(UserId);
        SaccoSetup.Get;
        BankingUser.TestField("Cashier Journal Template");
        BankingUser.TestField("Cashier Journal Batch");

        Jtemplate := BankingUser."Cashier Journal Template";
        JBatch := BankingUser."Cashier Journal Batch";

        Transactions.Reset;
        Transactions.SetRange(Posted, true);
        Transactions.SetRange(Transactions.Select, true);
        Transactions.SetRange("Selected By", UserId);
        Transactions.SetFilter("Expected Maturity Date", '>%1', Today);
        Transactions.SetFilter(Transactions."Cheque Status", '%1', Transactions."cheque status"::Pending);
        if Transactions.Find('-') then
            Error('Selected Transacion No. %1 has not matured yet', Transactions."Transaction No.");

        PDate := Today;

        Transactions.Reset;
        Transactions.SetRange(Posted, true);
        Transactions.SetRange(Transactions.Select, true);
        Transactions.SetRange("Selected By", UserId);
        Transactions.SetFilter("Expected Maturity Date", '<=%1', Today);
        Transactions.SetFilter(Transactions."Cheque Status", '%1', Transactions."cheque status"::Pending);
        if Transactions.Find('-') then begin
            repeat

                if (Transactions.Type = Transactions.Type::"Cheque Deposit") or (Transactions.Type = Transactions.Type::"Credit Cheque") then begin
                    if Transactions."Expected Maturity Date" <= Today then begin

                        //PDate := Transactions."Transaction Date"; //changed on 31.03.2025

                        SaccoActivities.JournalInit(Jtemplate, JBatch);
                        //Recover Discounting

                        Savings.Get(Transactions."Account No.");
                        DActivity := Savings."Global Dimension 1 Code";
                        DBranch := Savings."Global Dimension 2 Code";

                        if Transactions.Type = Transactions.Type::"Credit Cheque" then begin
                            PostCredit(Transactions, Jtemplate, JBatch, '', DBranch, DActivity, PDate, true);
                        end;

                        if Transactions."Discounted Amount" > 0 then begin

                            Loans.Reset;
                            Loans.SetRange("Cheque Discounting No.", Transactions."Transaction No.");
                            Loans.SetRange(Loans."Member No.", Transactions."Member No.");
                            Loans.SetRange(Loans.Posted, true);
                            if Loans.Find('-') then begin
                                repeat

                                    Loans.CalcFields(Loans."Outstanding Principal");


                                    SaccoActivities.JournalInsert(
                                        Jtemplate,
                                        JBatch,
                                        Transactions."Transaction No.",
                                        PDate,
                                        Accttype::Credit,
                                        Loans."Loan Account",
                                        CopyStr(CashierTransactions."Cheque No" + ' Discounting Loan Recovery:' + Transactions."Transaction No.", 1, 50),
                                        Balaccttype::"G/L Account",
                                        '',
                                        -Loans."Outstanding Principal",
                                        CashierTransactions."Cheque No",
                                        Loans."Loan No.",
                                        Transtype::"Principal Repayment",
                                        DActivity,
                                        DBranch,
                                        true,
                                        TChannel::"Credit Cheque",
                                        CashierTransactions."Dimension Set ID"
                                        );


                                    SaccoActivities.JournalInsert(
                                        Jtemplate,
                                        JBatch,
                                        Transactions."Transaction No.",
                                        PDate,
                                        Accttype::Savings,
                                        Transactions."Account No.",
                                        CopyStr(CashierTransactions."Cheque No" + ' Discounting Loan Recovery:' + Transactions."Transaction No.", 1, 50),
                                        Balaccttype::"G/L Account",
                                        '',
                                        Loans."Outstanding Principal",
                                        CashierTransactions."Cheque No",
                                        Loans."Loan No.",
                                        Transtype::"Principal Repayment",
                                        DActivity,
                                        DBranch,
                                        true,
                                        TChannel::"Credit Cheque",
                                        CashierTransactions."Dimension Set ID"
                                        );


                                until Loans.Next = 0;

                            end
                            else
                                Error('Discounting loan for %1 not found.', Transactions."Transaction No.");
                        end;

                        //Recover Discounting


                        SaccoActivities.JournalPost(Jtemplate, JBatch);


                        Transactions."Cheque Status" := Transactions."cheque status"::Honoured;
                        Transactions."Date Cleared" := Today;
                        Transactions."Cleared By" := UserId;
                        Transactions.Modify;

                    end;
                end;
            until Transactions.Next = 0;
        end;
    end;


    procedure StopCheque(CashierTrans: Record "Teller Transaction")
    var
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        ChequeType: Record "Cheque Types";
        TCharges: Decimal;
        CHBank: Code[20];
        ChequeReturnCodes: Record "Cheque Return Codes";
        TellerLines: Record "Teller Lines";
        TrasactionCharges: Record "Transaction Charges";// where(Type = const("Bounced Cheque")
        DBranch: Code[20];
        DActivity: Code[20];
    begin

        BankingUser.Get(UserId);
        SaccoSetup.Get;

        BankingUser.TestField("Cashier Journal Template");
        BankingUser.TestField("Cashier Journal Batch");

        Jtemplate := BankingUser."Cashier Journal Template";
        JBatch := BankingUser."Cashier Journal Batch";


        BankingUser.TestField("Cheque Clearance Account");
        CHBank := CashierTrans."Issueing Bank Account";  //BankingUser."Cheque Clearance Account";


        if (CashierTrans.Type = CashierTrans.Type::"Cheque Deposit") or (CashierTrans.Type = CashierTrans.Type::"Credit Receipt") then
            Error('Only applicable to cheques');

        if (CashierTrans."Cheque Status" <> CashierTrans."cheque status"::Pending) and ((CashierTrans."Cheque Status" <> CashierTrans."cheque status"::Matured)) then
            Error('Cheque already processed.');

        if not Confirm('Are you sure you want to stop the Cheque? reversal charges will apply', true) then
            exit;


        SaccoActivities.JournalInit(Jtemplate, JBatch);


        if CashierTrans."Account Type" = CashierTrans."account type"::Account then begin

            Savings.Get(CashierTrans."Account No.");
            Savings."Test Blocked" := Savings."test blocked"::" ";
            if Savings.Blocked <> Savings.Blocked::" " then begin
                Savings."Test Blocked" := Savings.Blocked;
                Savings.Blocked := Savings.Blocked::" ";
                Savings.Modify;
            end;


            //Reverse Entry
            SaccoActivities.JournalInsert(
                Jtemplate,
                JBatch,
                CashierTrans."Transaction No.",
                Today,
                Accttype::Savings,
                CashierTrans."Account No.",
                CopyStr('Unpaid Cheque Reversal:' + CashierTrans."Transaction No.", 1, 50),
                Balaccttype::"G/L Account",
                '',
                CashierTrans.Amount,
                CashierTrans."Cheque No",
                '',
                Transtype::" ",
                CashierTrans."Global Dimension 1 Code",
                CashierTrans."Global Dimension 2 Code",
                true,
                TChannel::"Stop Cheque",
                CashierTrans."Dimension Set ID"
                );



            if CashierTrans."Account Type" = CashierTrans."account type"::"G/L Account" then begin


                TellerLines.Reset;
                TellerLines.SetRange(TellerLines."Transaction No.", CashierTrans."Transaction No.");
                TellerLines.SetRange(Type, TellerLines.Type::"G/L Account");
                if TellerLines.Find('-') then begin
                    repeat

                        SaccoActivities.JournalInsert(
                            Jtemplate,
                            JBatch,
                            CashierTrans."Transaction No.",
                            Today,
                            Accttype::"G/L Account",
                            TellerLines."Account No.",
                            CopyStr('Unpaid Cheque Reversal:' + CashierTrans."Transaction No.", 1, 50),
                            Balaccttype::"G/L Account",
                            '',
                            TellerLines.Amount,
                            CashierTrans."Cheque No",
                            '',
                            Transtype::" ",
                            CashierTrans."Global Dimension 1 Code",
                            CashierTrans."Global Dimension 2 Code",
                            true,
                            TChannel::"Stop Cheque",
                            CashierTrans."Dimension Set ID"
                            );

                    until TellerLines.Next = 0;
                end;

            end;



            SaccoActivities.JournalInsert(
                Jtemplate,
                JBatch,
                CashierTrans."Transaction No.",
                Today,
                Accttype::"Bank Account",
                CHBank,
                CopyStr('Bounced Payout Cheque:' + CashierTrans."Transaction No.", 1, 50),
                Balaccttype::"G/L Account",
                '',
                -CashierTrans.Amount,
                CashierTrans."Cheque No",
                '',
                Transtype::" ",
                CashierTrans."Global Dimension 1 Code",
                CashierTrans."Global Dimension 2 Code",
                true,
                TChannel::"Stop Cheque",
                CashierTrans."Dimension Set ID"
                );


            //Charges
            TCharges := 0;

            TrasactionCharges.Reset();
            TrasactionCharges.SetRange(Type, TrasactionCharges.Type::"Bounced Cheque");
            if TrasactionCharges.FindFirst() then
                CashierTrans."Bouncing Charge" := TrasactionCharges.Code;

            CashierTrans.TestField("Bouncing Charge");
            //ChequeReturnCodes.Get("Bouncing Charge");
            //if "Account Type" = "account type"::Account then
            //  ChequeReturnCodes.TestField("Charge Code");

            MemberActivities.GetGeneral_SharingChargeAmount(CashierTrans."Bouncing Charge", CashierTrans.Amount, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);
            //MemberActivities.GetGeneral_SharingChargeAmount(ChequeReturnCodes."Charge Code", Amount, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);

            DActivity := CashierTrans."Global Dimension 1 Code";
            DBranch := CashierTrans."Global Dimension 2 Code";

            if ChargeAmt > 0 then begin

                SaccoActivities.JournalInsert(
                    Jtemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    Today,
                    Accttype::Savings,
                    CashierTrans."Account No.",
                    CopyStr(Format(CashierTrans.Type) + ' Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    ChargeAmt,
                    CopyStr(CashierTrans."ID No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Stop Cheque",
                CashierTrans."Dimension Set ID"
                    );


                if ChargeDuty > 0 then begin

                    SaccoActivities.JournalInsert(
                        Jtemplate,
                        JBatch,
                        CashierTrans."Transaction No.",
                        TODAY,
                        Accttype::Savings,
                        CashierTrans."Account No.",
                        CopyStr('Excise Duty on ' + Format(CashierTrans.Type) + ' Charge', 1, 50),
                        Balaccttype::"G/L Account",
                        SaccoSetup."Excise Duty GL",
                        ChargeDuty,
                        CopyStr(CashierTrans."ID No", 1, 20),
                        '',
                        Transtype::" ",
                        DActivity,
                        DBranch,
                        true,
                        TChannel::"Stop Cheque",
                        CashierTrans."Dimension Set ID"
                        );
                end;


                SaccoActivities.JournalInsert(
                    Jtemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    TODAY,
                    ChargeAcctType,
                    ChargeAcct,
                    CopyStr(Format(CashierTrans.Type) + ' Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -(ChargeAmt - SharingAmt),
                    CopyStr(CashierTrans."ID No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Stop Cheque",
                    CashierTrans."Dimension Set ID"
                    );

                SaccoActivities.JournalInsert(
                    Jtemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    TODAY,
                    SharingChargeAcctType,
                    SharingChargeAcct,
                    CopyStr(Format(CashierTrans.Type) + ' Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -(SharingAmt),
                    CopyStr(CashierTrans."ID No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Stop Cheque",
                    CashierTrans."Dimension Set ID"
                    );

            end;



            SaccoActivities.JournalPost(Jtemplate, JBatch);

            if CashierTrans."Account Type" = CashierTrans."account type"::Account then begin

                Savings.Get(CashierTrans."Account No.");

                if Savings."Test Blocked" <> Savings."test blocked"::" " then begin
                    Savings.Blocked := Savings."Test Blocked";
                    Savings."Test Blocked" := Savings."test blocked"::" ";
                    Savings.Modify;
                end;
            end;
            CashierTrans."Cheque Status" := CashierTrans."cheque status"::Bounced;
            CashierTrans."Date Cleared" := Today;
            CashierTrans."Cleared By" := UserId;
            CashierTrans.Modify;

        end;
    end;


    procedure CheckTillCurrency(BankAcc: Code[20]; CurrCode: Code[20])
    var
        BankAcct: Record "Bank Account";
    begin
        BankAcct.Reset;
        BankAcct.SetRange(BankAcct."No.", BankAcc);
        if BankAcct.Find('-') then begin
            if BankAcct."Currency Code" <> CurrCode then begin
                if BankAcct."Currency Code" = '' then
                    Error('This bank [%1:- %2] can only transact in LOCAL Currency', BankAcct."No.", BankAcct.Name)
                else
                    Error('This bank [%1:- %2] can only transact in %3', BankAcct."No.", BankAcct.Name, BankAcct."Currency Code");
            end;
        end;
    end;

    local procedure CheckBankersNo(ChequeNo: Code[20]; GlobalDim2: Code[20]; TAmount: Decimal)
    var
        Bregister: Record "Bankers Cheque Register";
    begin
        Bregister.Reset;
        Bregister.SetRange(Bregister.Status, Bregister.Status::Pending);
        Bregister.SetRange(Bregister."Global Dimension 2 Code", GlobalDim2);
        Bregister.SetRange(Bregister."Cheque No.", ChequeNo);
        if Bregister.Find('-') = false then
            Error('Bankers cheque no has already been used');

        Bregister.Reset;
        Bregister.SetRange(Bregister.Status, Bregister.Status::Pending);
        Bregister.SetRange(Bregister."Global Dimension 2 Code", GlobalDim2);
        Bregister.SetRange(Bregister."Cheque No.", ChequeNo);
        if Bregister.Find('-') then begin
            if Bregister."Leaf Limit Amount" < TAmount then
                Error('Bankers cheque amount cannot be more than the leaf limit of %1', Bregister."Leaf Limit Amount");
        end;
    end;


    procedure PostShareTrading(Transfers: Record "Share Transfer")
    var
        Text0001: label 'Ensure the Transfer Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0003: label 'A transfer of ';
        Text0004: label 'The transaction has already been posted.';
        Source: Record "Share Transfer Lines";
        Destination: Record "Destination Account Transfers";
        GenJournalLine: Record "Gen. Journal Line";
        MobNo: Code[20];
        Text0005: label ' has been effected on your account at ';
        RunBal: Decimal;
        Interest: Decimal;
        Lrepay: Decimal;
        DBranch: Code[20];
        DActivity: Code[20];
        SaccoSetup: Record "Sacco Setup";
        SActivities: Codeunit "Sacco Activities";
        SourceAcc: Record "Savings Accounts";
        DestAcc: Record "Savings Accounts";
    begin

        if Transfers.Posted then
            Error(Text0004);

        //BankingUser.Get(UserId);
        SaccoSetup.Get();

        SaccoActivities.GetGeneralJournalTemplate(Jtemplate, JBatch);

        Transfers.CalcFields("Total Credits", "Total Debits");

        Transfers.TestField(Remarks);

        // if "Total Debits" <> "Total Credits" then
        //     Error('Debits must be equal to credits, please cheque your schedule');

        if Confirm('Are you sure you want to transfer schedule?', false) then begin

            SaccoActivities.JournalInit(Jtemplate, JBatch);

            Source.Reset;
            Source.SetRange(Source."No.", Transfers.No);
            if Source.Find('-') then begin
                repeat
                    SourceAcc.Get(Source."Source Account No.");
                    DestAcc.Get(Source."Destination Account No.");
                    SaccoActivities.JournalInsert(
                        Jtemplate,
                        JBatch,
                        Transfers.No,
                        Transfers."Transaction Date",
                        Source."Source Account Type",
                        Source."Source Account No.",
                        CopyStr(Transfers.Remarks + ' From -' + SourceAcc."Member No." + ' to ' + DestAcc."Member No.", 1, 50),
                        Balaccttype::"G/L Account",
                        '',
                        (Source."Source Amount"),
                        Source."External Document No.",
                        Source."Source Loan No.",
                        Source."Source Transaction Type",
                        Transfers."Global Dimension 1 Code",
                        Transfers."Global Dimension 2 Code",
                        true,
                        TChannel::"Share Transfer",
                        Transfers."Dimension Set ID"
                        );

                    SaccoActivities.JournalInsert(
                    Jtemplate,
                    JBatch,
                    Transfers.No,
                    Transfers."Transaction Date",
                    Source."Destination Account Type",
                    Source."Destination Account No.",
                    CopyStr(Transfers.Remarks + ' From -' + SourceAcc."Member No." + ' to ' + DestAcc."Member No.", 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    (Source."Source Amount") * -1,
                    Source."External Document No.",
                    '',
                    Source."Source Transaction Type",
                    Transfers."Global Dimension 1 Code",
                    Transfers."Global Dimension 2 Code",
                    true,
                    TChannel::"Share Transfer",
                    Transfers."Dimension Set ID"
                    );
                until Source.Next = 0;
            end;

            Transfers.CalcFields(Amount);

            MemberActivities.GetGeneral_SharingChargeAmount(Transfers."Transaction Type", Transfers.Amount, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);
            //MemberActivities.GetGeneral_SharingChargeAmount(ChequeReturnCodes."Charge Code", Amount, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);

            Savings.Reset();
            Savings.SetRange("No.", Transfers."Charge Account");
            Savings.SetFilter("Balance (LCY)", '<%1', ChargeAmt + ChargeDuty);
            Savings.SetAutoCalcFields("Balance (LCY)");
            if Savings.FindFirst() then
                Error(StrSubstNo('The charge account balance is %1 expected %2', Savings."Balance (LCY)", ChargeAmt + ChargeDuty));

            DActivity := Transfers."Global Dimension 1 Code";
            DBranch := Transfers."Global Dimension 2 Code";

            if ChargeAmt > 0 then begin

                SaccoActivities.JournalInsert(
                    Jtemplate,
                    JBatch,
                    Transfers.No,
                    Today,
                    Accttype::Savings,
                    Transfers."Charge Account",
                    CopyStr(Transfers.Remarks + ' From -' + SourceAcc."Member No." + ' to ' + DestAcc."Member No." + ' Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    ChargeAcct,
                    ChargeAmt,
                    CopyStr(Transfers."Member No", 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::" ",
                    Transfers."Dimension Set ID"
                    );

                if ChargeDuty > 0 then
                    SaccoActivities.JournalInsert(
                   Jtemplate,
                   JBatch,
                   Transfers.No,
                   Today,
                   Accttype::Savings,
                   Transfers."Charge Account",
                   CopyStr(Transfers.Remarks + ' From -' + SourceAcc."Member No." + ' to ' + DestAcc."Member No." + ' Excise duty Charge', 1, 50),
                   Balaccttype::"G/L Account",
                   SaccoSetup."Excise Duty GL",
                   ChargeDuty,
                   CopyStr(Transfers."Member No", 1, 20),
                   '',
                   Transtype::" ",
                   DActivity,
                   DBranch,
                   true,
                   TChannel::" ",
                   Transfers."Dimension Set ID"
                   );
            end;
            Transfers.Posted := true;
            Transfers.Modify;

            SaccoActivities.JournalPost(Jtemplate, JBatch);

        end;
    end;

    procedure PostTransfers(Transfers: Record "Account Transfers")
    var
        Text0001: label 'Ensure the Transfer Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0003: label 'A transfer of ';
        Text0004: label 'The transaction has already been posted.';
        Source: Record "Source Account Transfer";
        Destination: Record "Destination Account Transfers";
        GenJournalLine: Record "Gen. Journal Line";
        MobNo: Code[20];
        Text0005: label ' has been effected on your account at ';
        RunBal: Decimal;
        Interest: Decimal;
        Lrepay: Decimal;
        "Excise Duty": Decimal;
        SActivities: Codeunit "Sacco Activities";
    begin

        if Transfers.Posted then
            Error(Text0004);

        //BankingUser.Get(UserId);

        SaccoActivities.GetGeneralJournalTemplate(Jtemplate, JBatch);

        Transfers.CalcFields("Total Credits", "Total Debits");

        Transfers.TestField(Remarks);

        if Transfers."Total Debits" <> Transfers."Total Credits" then
            Error('Debits must be equal to credits, please cheque your schedule');

        if Confirm('Are you sure you want to transfer schedule?', false) then begin

            SaccoActivities.JournalInit(Jtemplate, JBatch);


            Source.Reset;
            Source.SetRange(Source."No.", Transfers.No);
            if Source.Findset() then begin
                // Source.Validate("Source Account No.");
                //     Source.Validate("Source Amount");

                if Source.Description <> '' then
                    Transfers.Remarks := Source.Description;

                repeat



                    SaccoActivities.JournalInsert(
                        Jtemplate,
                        JBatch,
                        Transfers.No,
                        Transfers."Transaction Date",
                        Source."Source Account Type",
                        Source."Source Account No.",
                        CopyStr(Transfers.Remarks, 1, 50),
                        Balaccttype::"G/L Account",
                        '',
                        (Source."Source Amount"),
                        Source."External Document No.",
                        Source."Source Loan No.",
                        Source."Source Transaction Type",
                        Transfers."Global Dimension 1 Code",
                        Transfers."Global Dimension 2 Code",
                        true,
                        TChannel::"Account Transfer",
                        Transfers."Dimension Set ID"
                        );
                until Source.Next = 0;
            end;

            Destination.Reset;
            Destination.SetRange(Destination."No.", Transfers.No);
            if Destination.Findset() then begin

                repeat
                    if Destination.Description <> '' then
                        Transfers.Remarks := Destination.Description;

                    SaccoActivities.JournalInsert(
                        Jtemplate,
                        JBatch,
                        Transfers.No,
                        Transfers."Transaction Date",
                        Destination."Destination Account Type",
                        Destination."Destination Account No.",
                        CopyStr(Transfers.Remarks, 1, 50),
                        Balaccttype::"G/L Account",
                        '',
                        -(Destination."Destination Amount"),
                        Destination."External Document No.",
                        Destination."Destination Loan No.",
                        Destination."Destination Transaction Type",
                        Transfers."Global Dimension 1 Code",
                        Transfers."Global Dimension 2 Code",
                        true,
                        TChannel::"Account Transfer",
                        Transfers."Dimension Set ID"
                        );

                // if Destination."PloughBack Amount" > 0 then begin

                //     MemberActivities.GetGeneralCumulativeChargeAmount('P-BACK', Destination."Destination Amount", Destination."PloughBack Amount", "Excise Duty", ChargeAcctType, ChargeAcct);

                //     SaccoActivities.JournalInsert(
                //     Jtemplate,
                //     JBatch,
                //     Transfers.No,
                //     Transfers."Transaction Date",
                //     Destination."Destination Account Type",
                //     Destination."Destination Account No.",
                //     CopyStr(Transfers.Remarks + ' PloughBack', 1, 50),
                //     Balaccttype::"G/L Account",
                //     '',
                //     -(Destination."PloughBack Amount"),
                //     Destination."External Document No.",
                //     Destination."Destination Loan No.",
                //     Destination."Destination Transaction Type",
                //     Transfers."Global Dimension 1 Code",
                //     Transfers."Global Dimension 2 Code",
                //     true,
                //     TChannel::"Account Transfer",
                //     Transfers."Dimension Set ID"
                //     );


                //     SaccoActivities.JournalInsert(
                //     Jtemplate,
                //     JBatch,
                //     Transfers.No,
                //     Transfers."Transaction Date",
                //     Destination."Destination Account Type"::"G/L Account",
                //     ChargeAcct,
                //     CopyStr(Transfers.Remarks + ' PloughBack', 1, 50),
                //     Balaccttype::"G/L Account",
                //     '',
                //     Destination."PloughBack Amount",
                //     Destination."External Document No.",
                //     Destination."Destination Loan No.",
                //     Destination."Destination Transaction Type",
                //     Transfers."Global Dimension 1 Code",
                //     Transfers."Global Dimension 2 Code",
                //     true,
                //     TChannel::"Account Transfer",
                //     Transfers."Dimension Set ID"
                //     );
                // end;

                until Destination.Next = 0;
            end;

            Transfers.Posted := true;
            Transfers.Modify;

            SaccoActivities.JournalPost(Jtemplate, JBatch);

        end;
    end;


    procedure ChequeDiscounting(CashierTrans: Record "Teller Transaction")
    var
        Text0001: label 'Ensure the Cheque Discounting Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cheque Discounting Batch is set up in Banking User Setup';
        DiscComm: Decimal;
    begin

        SaccoSetup.Get;

        BankingUser.Get(UserId);
        BankingUser.TestField("Cashier Journal Template");
        BankingUser.TestField("Cashier Journal Batch");

        Jtemplate := BankingUser."Cashier Journal Template";
        JBatch := BankingUser."Cashier Journal Batch";


        if CashierTrans.Type <> CashierTrans.Type::"Cheque Deposit" then
            Error('You can only discount cheques.');

        if CashierTrans."Cheque Status" <> CashierTrans."cheque status"::Pending then
            Error('Cheque already processed.');

        if CashierTrans."Discounting Amount" < 1 then
            Error('Please enter the amount you want to discount.');


        if not Confirm('Are you sure you want to discount this cheque?', true) then
            exit;

        SaccoActivities.JournalInit(Jtemplate, JBatch);

        Loans.Reset;
        Loans.SetRange(Loans."Cheque Discounting No.", CashierTrans."Transaction No.");
        Loans.SetRange(Loans."Member No.", CashierTrans."Member No.");
        Loans.SetRange(Loans.Posted, false);
        if Loans.Find('-') then
            Loans.DeleteAll;



        ProductSetup.Reset;
        ProductSetup.SetRange(ProductSetup."Nature of Loan Type", ProductSetup."nature of loan type"::"Cheque Discounting");
        ProductSetup.SetRange(ProductSetup."Product Class", ProductSetup."product class"::Credit);
        if ProductSetup.Find('-') then begin
            Loans.Init;
            Loans."Loan No." := '';
            Loans."Member No." := CashierTrans."Member No.";
            Loans."Disbursement Account No" := CashierTrans."Account No.";
            Loans."Application Date" := Today;
            Loans."Annual Interest %" := ProductSetup."Interest Rate (Min.)";
            Loans.Installments := 1;
            Loans."Requested Amount" := CashierTrans."Discounting Amount";
            Loans."Approved Amount" := CashierTrans."Discounting Amount";
            Loans."Loan Principle Repayment" := Loans."Approved Amount" / Loans.Installments;
            Loans."Loan Interest Repayment" := ROUND(Loans."Approved Amount" * Loans."Annual Interest %" / 1200);
            Loans.Repayment := Loans."Loan Principle Repayment" + Loans."Loan Interest Repayment";
            Loans.Status := Loans.Status::Approved;
            Loans."Disbursement Date" := Today;
            Loans."Repayment Start Date" := Today;
            Loans."Cheque Discounting No." := CashierTrans."Transaction No.";
            Loans.Insert(true);
            SaccoActivities.GenerateRepaymentSchedule(Loans);


            Loans.Reset;
            Loans.SetRange(Loans."Cheque Discounting No.", CashierTrans."Transaction No.");
            Loans.SetRange(Loans."Member No.", CashierTrans."Member No.");
            Loans.SetRange(Loans.Posted, false);
            if Loans.Find('-') then begin

                SaccoActivities.JournalInsert(
                    Jtemplate,
                    JBatch,
                    Loans."Loan No.",
                    Today,
                    Accttype::Credit,
                    Loans."Loan Account",
                    CopyStr('Cheque Discounting - Principal Amount', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    CashierTrans."Discounting Amount",
                    CashierTrans."Transaction No.",
                    Loans."Loan No.",
                    Transtype::"Loan Disbursement",
                    CashierTrans."Global Dimension 1 Code",
                    CashierTrans."Global Dimension 2 Code",
                    true,
                    TChannel::"Cheque Discounting",
                    CashierTrans."Dimension Set ID"
                    );


                SaccoActivities.JournalInsert(
                    Jtemplate,
                    JBatch,
                    Loans."Loan No.",
                    Today,
                    Accttype::Savings,
                    CashierTrans."Account No.",
                    CopyStr('Cheque Discounting - Principal Amount', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -CashierTrans."Discounting Amount",
                    CashierTrans."Transaction No.",
                    Loans."Loan No.",
                    Transtype::" ",
                    CashierTrans."Global Dimension 1 Code",
                    CashierTrans."Global Dimension 2 Code",
                    true,
                    TChannel::"Cheque Discounting",
                    CashierTrans."Dimension Set ID"
                    );

                Loans.Posted := true;
                Loans.Modify;



                //Discounting Commision
                DiscComm := ROUND(CashierTrans."Discounting Amount" * (Loans."Annual Interest %" / 1200), 0.01, '>');


                SaccoActivities.JournalInsert(
                    Jtemplate,
                    JBatch,
                    Loans."Loan No.",
                    Today,
                    Accttype::Savings,
                    CashierTrans."Account No.",
                    CopyStr('Cheque Discounting Commission', 1, 50),
                    Balaccttype::"G/L Account",
                    ProductSetup."Loan Interest Income [G/L]",
                    DiscComm,
                    CashierTrans."Transaction No.",
                    Loans."Loan No.",
                    Transtype::" ",
                    CashierTrans."Global Dimension 1 Code",
                    CashierTrans."Global Dimension 2 Code",
                    true,
                    TChannel::"Cheque Discounting",
                    CashierTrans."Dimension Set ID"
                    );

                CashierTrans."Discounted Amount" := CashierTrans."Discounted Amount" + CashierTrans."Discounting Amount";
                CashierTrans."Discounting Amount" := 0;
                CashierTrans.Modify;

                SaccoActivities.JournalPost(Jtemplate, JBatch);

            end;
        end;
    end;

    local procedure PostLien(CashierTrans: Record "Teller Transaction")
    var
        Text0001: label 'This account has been blocked from receiving payments.';
        Text0002: label 'You need to add more money from the treasury since your balance has gone below the teller replenishing level.';
        Text0003: label 'You do not have enough money to carry out this transaction.';
        Text0004: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0005: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0006: label 'You cannot withdraw more than your allowed limit of %1 unless authorised.';
        Text0007: label 'You cannot withdraw more than the available balance unless authorised.';
        Text0008: label 'You cannot deposit more than your allowed limit of %1 unless authorised.';
    begin

        if Confirm('Are you sure you want to place lien on this account? ', false) then begin

            CashierTrans.Posted := true;
            CashierTrans."Date Posted" := Today;
            CashierTrans."Time Posted" := Time;
            CashierTrans."Posted By" := UserId;
            CashierTrans.Modify;

            Message('Lien placed successfully');
        end;
    end;


    procedure ClearLien()
    var
        Transactions: Record "Teller Transaction";
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
    begin

        Transactions.Reset;
        Transactions.SetRange(Transactions."Cheque Status", Transactions."cheque status"::Pending);
        Transactions.SetRange(Transactions.Type, Transactions.Type::Lien);
        Transactions.SetFilter("Expected Maturity Date", '<=%1', Today);
        if Transactions.Find('-') then begin
            repeat

                Transactions."Cheque Status" := Transactions."cheque status"::Honoured;
                Transactions."Date Cleared" := Today;
                Transactions."Cleared By" := UserId;
                Transactions.Modify;

            until Transactions.Next = 0;
        end;
    end;

    procedure PostBankChequeCharges(BankCheque: Record "Cheque Book Application")
    var
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0003: label 'Your account has insufficient funds to cater for cheque book charges ';
        DBranch: Code[20];
        DActivity: Code[20];
        AvailBal: Decimal;
    begin

        BankingUser.Get(UserId);
        SaccoSetup.Get;

        BankingUser.Get(UserId);
        BankingUser.TestField("Cashier Journal Template");
        BankingUser.TestField("Cashier Journal Batch");

        Jtemplate := BankingUser."Cashier Journal Template";
        JBatch := BankingUser."Cashier Journal Batch";

        DActivity := BankingUser."Shortcut Dimension 1 Code";
        DBranch := BankingUser."Shortcut Dimension 2 Code";



        if Savings.Get(BankCheque."Account No.") then begin
            SaccoActivities.JournalInit(Jtemplate, JBatch);

            AddChargesLines(BankCheque."Transaction Type", Jtemplate, JBatch, 0, DBranch, DActivity, Today, BankCheque."No.", false, BankCheque."Account No.", 'Cheque Book Application Charge', true, BankCheque."No.");


            BankCheque."Cheque Book charges Posted" := true;
            BankCheque.Modify;

            SaccoActivities.JournalPost(Jtemplate, JBatch);

            Message('Charges posted successfully');
        end;
    end;

    local procedure PostMPESADepWith(TellerTransaction: Record "Teller Transaction"; JTemplate: Code[20]; JBatch: Code[20]; TillNo: Code[20]; DBranch: Code[20]; DActivity: Code[20])
    var
        BankAccount: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        Text0001: label 'This account has been blocked from receiving payments.';
        Text0002: label 'You need to add more money from the treasury since your balance has gone below the MPESA replenishing level.';
        Text0003: label 'You do not have enough money to carry out this transaction.';
        Text0004: label 'You need to transfer money back to the treasury since your balance has gone above the MPESA maximum withholding.';
        Text0005: label 'You need to transfer money back to the treasury since your balance has gone above the MPESA maximum withholding.';
        Text0006: label 'You cannot withdraw more than your allowed limit of %1 unless authorised.';
        Text0007: label 'You cannot withdraw more than the available balance unless authorised.';
        Text0008: label 'You cannot deposit more than your allowed limit of %1 unless authorised.';
        Text0009: label 'You have done a transaction of KSHS. ';
        Text0010: label ' of type ';
        Text0011: label ' on ';
        Text0012: label ' on your account ';
        Text0013: label ' at ';
        Text0014: label 'The limit for cashier ';
        Text0015: label ' of till ';
        Text0016: label ' has gone below the replenishing levels of ';
        Text0017: label ' has gone above the replenishing levels of ';
        Text0018: label 'Transaction Aborted';
        Cust: Record Customer;
        Amt: Decimal;
    begin

        SaccoSetup.Get;

        if TellerTransaction."Mpesa/Agent Transaction" = TellerTransaction."mpesa/agent transaction"::" " then
            Error('Mpesa/Agent Transaction MUST have  value');


        BankingUser.Get(UserId);

        if TellerTransaction."Agent Transaction" = TellerTransaction."agent transaction"::MPESA then
            if TellerTransaction.Amount > BankingUser."MPESA Transaction Limit" then
                Error('MPESA transaction Limit MUST NOT exceed %1', BankingUser."MPESA Transaction Limit");

        if TellerTransaction."Agent Transaction" = TellerTransaction."agent transaction"::"Super Agent" then
            if TellerTransaction.Amount > BankingUser."Super Agent Transaction Limit" then
                Error('Super Agent transaction Limit MUST NOT exceed %1', BankingUser."Super Agent Transaction Limit");

        BankAccount.Reset;
        BankAccount.SetRange(BankAccount."No.", TillNo);
        if BankAccount.Find('-') then begin
            BankAccount.CalcFields(BankAccount.Balance);

            CurrentTellerAmount := BankAccount.Balance;


            if TellerTransaction."Mpesa/Agent Transaction" = TellerTransaction."mpesa/agent transaction"::Withdrawal then begin
                if CurrentTellerAmount - TellerTransaction.Amount < 0 then
                    Error('This transaction Will lead to Overdrawal of MPESA Till');


                if CurrentTellerAmount - TellerTransaction.Amount <= BankingUser."Min. Balance" then begin
                    Message(Text0002);
                end;


                if CurrentTellerAmount - TellerTransaction.Amount >= BankingUser."Max. MPESA Withholding" then
                    Message(Text0004);
            end
            else begin

                if CurrentTellerAmount + TellerTransaction.Amount >= BankingUser."Max. MPESA Withholding" then begin
                    Message(Text0005);
                    if Confirm('Do you want to proceed with this transaction?', false) = false then
                        exit;
                end;
            end;


            if TellerTransaction."Mpesa/Agent Transaction" = TellerTransaction."mpesa/agent transaction"::Withdrawal then begin
                if TellerTransaction.Status <> TellerTransaction.Status::Approved then begin
                    if TellerTransaction.Amount > BankingUser."MPESA Transaction Limit" then begin
                        Message(Text0006, BankingUser."MPESA Transaction Limit");


                        if Confirm('Do you want to send this transaction for approval?', false) = true then begin

                            VarVariant := TellerTransaction;
                            CalwideApprovals.CreateCustomTracker(VarVariant, TellerTransaction."Transaction No.", TellerTransaction.Amount, Documenttype::"Teller Transaction", TellerTransaction."Global Dimension 1 Code", TellerTransaction."Global Dimension 2 Code", 0);

                            Commit;
                            Error('Pending Authorization');
                            //VarVariant := CashierTrans;
                            //IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                            //  CustomApprovals.OnSendDocForApproval(VarVariant);
                        end;
                        exit;
                    end;
                end;
            end
            else begin

                Cust.Get(TellerTransaction."Account No.");
                Cust.CalcFields("Balance (LCY)");
                if Cust."Balance (LCY)" - TellerTransaction.Amount < (Cust."Credit Limit (LCY)" * -1) then
                    Error('This transaction will lead to over crediting Mpesa Customer Account');

                if TellerTransaction.Amount > BankingUser."MPESA Transaction Limit" then begin
                    if TellerTransaction.Status <> TellerTransaction.Status::Approved then begin
                        Message(Text0008, BankingUser."MPESA Transaction Limit");

                        if Confirm('Do you want to send this transaction for approval?', false) = true then begin


                            VarVariant := TellerTransaction;
                            CalwideApprovals.CreateCustomTracker(VarVariant, TellerTransaction."Transaction No.", TellerTransaction.Amount, Documenttype::"Teller Transaction", TellerTransaction."Global Dimension 1 Code", TellerTransaction."Global Dimension 2 Code", 0);

                            Commit;
                            Error('Pending Authorization');
                            //VarVariant := CashierTrans;
                            //IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                            //  CustomApprovals.OnSendDocForApproval(VarVariant);
                        end;
                        exit;
                    end;
                end;

            end;
        end;


        SaccoActivities.JournalInit(JTemplate, JBatch);


        if (TellerTransaction."Mpesa/Agent Transaction" = TellerTransaction."mpesa/agent transaction"::Deposit) then
            Amt := -TellerTransaction.Amount
        else
            Amt := TellerTransaction.Amount;

        SaccoActivities.JournalInsert(
            JTemplate,
            JBatch,
            TellerTransaction."Transaction No.",
            Today,
            Accttype::Customer,
            TellerTransaction."Account No.",
            CopyStr(Format(TellerTransaction."Mpesa/Agent Transaction") + '-' + TellerTransaction.Remarks, 1, 50),
            Balaccttype::"Bank Account",
            TillNo,
            Amt,
            CopyStr(TellerTransaction.Remarks, 1, 20),
            '',
            Transtype::" ",
            DActivity,
            DBranch,
            true,
            TChannel::"Teller Mpesa",
            TellerTransaction."Dimension Set ID"
            );

        TellerTransaction.Posted := true;
        TellerTransaction."Date Posted" := Today;
        TellerTransaction."Time Posted" := Time;
        TellerTransaction."Posted By" := UserId;
        TellerTransaction.Modify;

        SaccoActivities.JournalPost(JTemplate, JBatch);
    end;

    local procedure PostChequeTransfer(CashierTrans: Record "Teller Transaction"; JTemplate: Code[20]; JBatch: Code[20]; DBranch: Code[20]; DActivity: Code[20])
    var
        BankAccount: Record "Bank Account";
        Text0009: label 'You have done an ';
        Text0010: label ' transaction of KES ';
        Text0011: label ' on ';
        Text0012: label ' at ';
        Text0013: label 'An ';
        Text0014: label ' transaction ';
        Text0015: label ' has been done on your Account on ';
        ChBank: Code[20];
    begin

        ChBank := CashierTrans."Bank Account";

        SaccoActivities.JournalInit(JTemplate, JBatch);


        SaccoActivities.JournalInsert(
            JTemplate,
            JBatch,
            CashierTrans."Transaction No.",
            CashierTrans."Transaction Date",
            Accttype::Savings,
            CashierTrans."Account No.",
            CopyStr(CashierTrans."Transaction Description" + '-' + CashierTrans.Remarks, 1, 50),
            Balaccttype::"G/L Account",
            '',
            -CashierTrans.Amount,
            CashierTrans."Cheque No",
            '',
            Transtype::" ",
            DActivity,
            DBranch,
            true,
            TChannel::"Cheque Deposit",
            CashierTrans."Dimension Set ID"
            );


        SaccoActivities.JournalInsert(
            JTemplate,
            JBatch,
            CashierTrans."Transaction No.",
            CashierTrans."Transaction Date",
            Accttype::Savings,
            CashierTrans."Source Account No.",
            CopyStr(CashierTrans."Account Name", 1, 50),
            Balaccttype::"G/L Account",
            '',
            CashierTrans.Amount,
            CashierTrans."Cheque No",
            '',
            Transtype::" ",
            DActivity,
            DBranch,
            true,
            TChannel::"Cheque Deposit",
            CashierTrans."Dimension Set ID"
            );


        AddChargesLines(CashierTrans."Transaction Type", JTemplate, JBatch, CashierTrans.Amount, DBranch, DActivity, Today, CashierTrans."Transaction No.", true, CashierTrans."Account No.", 'Cheque Transfer Charges', false, CashierTrans."Cheque No");

        CashierTrans.Posted := true;
        CashierTrans."Date Posted" := Today;
        CashierTrans."Time Posted" := Time;
        CashierTrans."Posted By" := UserId;
        CashierTrans."Cheque Location" := CashierTrans."cheque location"::"Chief Cashier 1";
        CashierTrans.Modify;

        SaccoActivities.JournalPost(JTemplate, JBatch);


        if Savings.Get(CashierTrans."Account No.") then begin

            if Members.Get(Savings."Member No.") then
                MobileNo := Members."Mobile Phone No.";

            MemberActivities.SendSms(Source::"Teller Cheque Transfer", MobileNo, Text0009 + Format(CashierTrans.Type) + Text0010 + Format(CashierTrans.Amount) + Text0011 +
                    Format(Today) + ' ' + Format(Time) + Text0012 + COMPANYNAME, CashierTrans."Account No.", CashierTrans."Account No.", true, false)

        end;


        if Savings.Get(CashierTrans."Source Account No.") then begin

            if Members.Get(Savings."Member No.") then
                MobileNo := Members."Mobile Phone No.";

            MemberActivities.SendSms(Source::"Teller Cheque Transfer", MobileNo, Text0013 + Format(CashierTrans.Type) + Text0010 + Format(CashierTrans.Amount) + Text0015 +
                       Format(Today) + ' ' + Format(Time) + Text0012 + COMPANYNAME, CashierTrans."Source Account No.", CashierTrans."Source Account No.", true, false);
        end;
    end;

    local procedure PostIncomeTransactions(CashierTrans: Record "Teller Transaction"; JTemplate: Code[20]; JBatch: Code[20]; TillNo: Code[20]; DBranch: Code[20]; DActivity: Code[20])
    var
        BankAccount: Record "Bank Account";
        Text0001: label 'This account has been blocked from receiving payments.';
        Text0002: label 'You need to add more money from the treasury since your balance has gone below the teller replenishing level.';
        Text0003: label 'You do not have enough money to carry out this transaction.';
        Text0004: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0005: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0006: label 'You cannot withdraw more than your allowed limit of %1 unless authorised.';
        Text0007: label 'You cannot withdraw more than the available balance unless authorised.';
        Text0008: label 'You cannot deposit more than your allowed limit of %1 unless authorised.';
        Text0009: label 'You have done a transaction of KSHS. ';
        Text0010: label ' of type ';
        Text0011: label ' on ';
        Text0012: label ' on your account ';
        Text0013: label ' at ';
        Text0014: label 'The limit for cashier ';
        Text0015: label ' of till ';
        Text0016: label ' has gone below the replenishing levels of ';
        Text0017: label ' has gone above the replenishing levels of ';
        Text0018: label 'Transaction Aborted';
        CurrentTellerAmount: Decimal;
    begin

        SaccoSetup.Get;
        BankingUser.Get(UserId);


        if CashierTrans."Account Type" = CashierTrans."account type"::"G/L Account" then begin

            BankAccount.Reset;
            BankAccount.SetRange(BankAccount."No.", TillNo);
            if BankAccount.Find('-') then begin
                BankAccount.CalcFields(BankAccount.Balance);
                CurrentTellerAmount := BankAccount.Balance;

                if CurrentTellerAmount + CashierTrans.Amount >= BankingUser."Max. Cashier Withholding" then begin
                    Message(Text0005);
                    if Confirm('Do you want to proceed with this transaction?', false) = false then
                        exit;
                end;
            end;

            if CashierTrans.Amount > BankingUser."Max. Deposit Limit" then begin
                Message(Text0008, BankingUser."Max. Deposit Limit");

                if Confirm('Do you want to send this transaction for approval?', false) = true then begin
                    //VarVariant := CashierTrans;
                    //IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                    //CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
                exit;
            end;
        end;

        SaccoActivities.JournalInit(JTemplate, JBatch);

        PostIncomeLines(CashierTrans, JTemplate, JBatch, TillNo, DBranch, DActivity, CashierTrans."Transaction Date");

        CashierTrans.Posted := true;
        CashierTrans."Date Posted" := Today;
        CashierTrans."Time Posted" := Time;
        CashierTrans."Posted By" := UserId;
        CashierTrans.Modify;
        SaccoActivities.JournalPost(JTemplate, JBatch);
    end;

    local procedure PostChequeWith(CashierTrans: Record "Teller Transaction"; JTemplate: Code[20]; JBatch: Code[20]; TillNo: Code[20]; DBranch: Code[20]; DActivity: Code[20])
    var
        BankAccount: Record "Bank Account";
        Text0001: label 'This account has been blocked from receiving payments.';
        Text0002: label 'You need to add more money from the treasury since your balance has gone below the teller replenishing level.';
        Text0003: label 'You do not have enough money to carry out this transaction.';
        Text0004: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0005: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0006: label 'You cannot withdraw more than your allowed limit of %1 unless authorised.';
        Text0007: label 'You cannot withdraw more than the available balance unless authorised.';
        Text0008: label 'You cannot deposit more than your allowed limit of %1 unless authorised.';
        VarVariant: Variant;
        Text0009: label 'You have done a transaction of KSHS. ';
        Text0010: label ' of type ';
        Text0011: label ' on ';
        Text0012: label ' on your account ';
        Text0013: label ' at ';
        Text0014: label 'The limit for cashier ';
        Text0015: label ' of till ';
        Text0016: label ' has gone below the replenishing levels of ';
        Text0017: label ' has gone above the replenishing levels of ';
        Text0018: label 'Transaction Aborted';
        CurrentTellerAmount: Decimal;
        SMScharges: Record "SMS Charges";
        TotalSms: Decimal;
        SmsExcise: Decimal;
    begin

        SaccoSetup.Get;

        CashierTrans.TestField("Cheque No");
        if CashierTrans.Type = CashierTrans.Type::"Cheque Withdrawal" then begin
            if Savings.Get(CashierTrans."Account No.") then begin
                if Savings.Blocked = Savings.Blocked::Payment then
                    Error(Text0001);
            end;

            if CashierTrans."Available Balance" < CashierTrans.Amount then begin
                Error('You cannot withdraw more than the Available Balance');
            end;

        end;


        BankingUser.Get(UserId);

        BankAccount.Reset;
        BankAccount.SetRange(BankAccount."No.", TillNo);
        if BankAccount.Find('-') then begin
            BankAccount.CalcFields(BankAccount.Balance);

            CurrentTellerAmount := BankAccount.Balance;

            if CashierTrans.Type = CashierTrans.Type::"Cheque Withdrawal" then
                if CurrentTellerAmount - CashierTrans.Amount < 0 then
                    Error('This transaction Will lead to Overdrawal of Teller Till');


            if CurrentTellerAmount - CashierTrans.Amount <= BankingUser."Min. Balance" then begin
                Message(Text0002);
            end;

            if CashierTrans.Type = CashierTrans.Type::"Cheque Withdrawal" then begin

                if (CurrentTellerAmount - CashierTrans.Amount) < BankingUser."Min. Balance" then
                    Message(Text0003 + '\Minimum Balance: %1\Current Teller Balance: %2\Transaction Amount: %3', BankingUser."Min. Balance", CurrentTellerAmount, CashierTrans.Amount);

            end;

            if CashierTrans.Type = CashierTrans.Type::"Cheque Withdrawal" then begin
                if CurrentTellerAmount - CashierTrans.Amount >= BankingUser."Max. Cashier Withholding" then
                    Message(Text0004);
            end;


            if CashierTrans.Type = CashierTrans.Type::"Cheque Withdrawal" then begin
                if CashierTrans.Status <> CashierTrans.Status::Approved then begin
                    if CashierTrans.Amount > BankingUser."Max. Withdrawal Limit" then begin
                        Message(Text0006, BankingUser."Max. Withdrawal Limit");


                        // if Confirm('Do you want to send this transaction for approval?', false) = true then begin
                        //     VarVariant := CashierTrans;

                        //     CalwideApprovals.CreateCustomTracker(VarVariant, CashierTrans."Transaction No.", CashierTrans.Amount, Documenttype::"Teller Transaction", CashierTrans."Global Dimension 1 Code", CashierTrans."Global Dimension 2 Code", 0);
                        //     Commit;
                        //     Error('Pending Authorization');

                        // end;
                        // exit;
                    end;
                end;
            end;
        end;

        SaccoActivities.JournalInit(JTemplate, JBatch);

        SaccoActivities.JournalInsert(
            JTemplate,
            JBatch,
            CashierTrans."Transaction No.",
            CashierTrans."Transaction Date",
            Accttype::Savings,
            CashierTrans."Account No.",
            CopyStr(Format(CashierTrans.Type) + '-' + CashierTrans."Cheque No" + ' - ' + CashierTrans.Remarks, 1, 50),
            Balaccttype::"Bank Account",
            TillNo,
            CashierTrans.Amount,
            CashierTrans."Cheque No",
            '',
            Transtype::" ",
            DActivity,
            DBranch,
            true,
            TChannel::"Cheque Withdrawal",
            CashierTrans."Dimension Set ID"
            );


        AddChargesLines(CashierTrans."Transaction Type", JTemplate, JBatch, CashierTrans.Amount, DBranch, DActivity, CashierTrans."Transaction Date", CashierTrans."Transaction No.", true, CashierTrans."Account No.", 'Cheque Withdrawal Charges', false, CashierTrans."Cheque No");

        CashierTrans.Posted := true;
        CashierTrans."Date Posted" := Today;
        CashierTrans."Time Posted" := Time;
        CashierTrans."Posted By" := UserId;
        CashierTrans.Modify;

        SaccoActivities.JournalPost(JTemplate, JBatch);

        Members.Get(CashierTrans."Member No.");
        MobileNo := Members."Mobile Phone No.";
        Msg := 'Dear ' + MemberActivities.FirstName(Members.Name) + ', A Cheque WIthdrawal of KES ' + Format(CashierTrans.Amount) + ' from ' + DBranch + ' Teller has been processed on ' + Format(Today) + ' ' + Format(Time);
        MemberActivities.SendSms(Source::"Teller Cash Withdrawal", MobileNo, Msg, CashierTrans."Transaction No.", CashierTrans."Account No.", false, false);

        SMScharges.reset;
        SMScharges.setrange(source, SMScharges.source::"Cheque Withdrawal");
        if SMScharges.findfirst then begin

            TotalSms := SMSCharges."Charge Amount";
            SmsExcise := Round(SaccoSetup."Excise Duty (%)" * TotalSms * 0.01, 0.1, '<');
            TotalSms += SmsExcise;

            SaccoSetup.Get();

            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                CashierTrans."Transaction No.",
                CashierTrans."Transaction Date",
                Accttype::Savings,
                CashierTrans."Account No.",
                CopyStr('Sms Charge', 1, 50),
                Balaccttype::"G/L Account",
                SMSCHarges."Charge G/L Account",
                TotalSms - SmsExcise,
                CashierTrans."Bankers Cheque No",
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true,
                TChannel::"Bankers Cheque Withdrawal",
                CashierTrans."Dimension Set ID"
                );

            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                CashierTrans."Transaction No.",
                CashierTrans."Transaction Date",
                Accttype::"G/L Account",
                SaccoSetup."Excise Duty GL",
                CopyStr('Excise Duty on Sms Charge', 1, 50),
                Balaccttype::"G/L Account",
                '',
                -SmsExcise,
                CashierTrans."Bankers Cheque No",
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true,
                TChannel::"Bankers Cheque Withdrawal",
                CashierTrans."Dimension Set ID"
            );

        end;
    end;

    local procedure PostIncomeLines(CashierTrans: Record "Teller Transaction"; JTemplate: Code[20]; JBatch: Code[20]; TillNo: Code[20]; DBranch: Code[20]; DActivity: Code[20]; PDate: Date)
    var
        TellerLines: Record "Teller Lines";
        RunBal: Decimal;
        LoanRep: Decimal;
        Desc: Text;
    begin

        AcctType := Accttype::"Bank Account";
        AccNo := TillNo;
        Desc := CashierTrans.Remarks;

        if CashierTrans."Cheque Category" = CashierTrans."cheque category"::"MBS Sacco Cheque" then begin
            BankingUser.Get(UserId);
            BankingUser.TestField("MBS Cheque GL Account");
            AcctType := Accttype::"G/L Account";
            AccNo := BankingUser."MBS Cheque GL Account";
            Desc := CashierTrans.Remarks;
        end;


        SaccoActivities.JournalInsert(
            JTemplate,
            JBatch,
            CashierTrans."Transaction No.",
            PDate,
            AcctType,
            AccNo,
            CopyStr(Desc, 1, 50),
            Balaccttype::"G/L Account",
            CashierTrans."Account No.",
            CashierTrans.Amount,
            CashierTrans."Cheque No",
            '',
            Transtype::" ",
            DActivity,
            DBranch,
            true,
            TChannel::"Cheque Withdrawal",
            CashierTrans."Dimension Set ID"
            );


        TellerLines.Reset;
        TellerLines.SetRange(TellerLines."Transaction No.", CashierTrans."Transaction No.");
        TellerLines.SetRange(Type, TellerLines.Type::"G/L Account");
        if TellerLines.Find('-') then begin
            repeat

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    CashierTrans."Transaction No.",
                    PDate,
                    Accttype::"G/L Account",
                    TellerLines."Account No.",
                    CopyStr('Income Receipt ' + TellerLines.Description, 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -TellerLines.Amount,
                    CashierTrans."Cheque No",
                    '',
                    TellerLines."Transaction Type",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::"Cheque Withdrawal",
                    CashierTrans."Dimension Set ID"
                    );

            until TellerLines.Next = 0;
        end;
    end;


    procedure AddChargesLines(ChargeCode: Code[20]; JTemplate: Code[20]; JBatch: Code[20]; Value: Decimal; DBranch: Code[20]; DActivity: Code[20]; PDate: Date; DocNo: Code[20]; SkipEmployerCode: Boolean; SavingsNo: Code[20]; Desc: Text; CheckAvailableBalance: Boolean; ExtDoc: Code[20])
    var
        TellerLines: Record "Teller Lines";
        AppraisalAmt: Decimal;
        RunBal: Decimal;
        LoanRep: Decimal;
        Loans: Record Loans;
        Members: Record Members;
        Savings: Record "Savings Accounts";
        AvailBal: Decimal;
    begin

        MemberActivities.GetGeneral_SharingChargeAmount(ChargeCode, Value, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);


        if SkipEmployerCode then begin
            Savings.Get(SavingsNo);
            Members.Get(Savings."Member No.");
            if Employer.Get(Members."Employer Code") then begin
                if Employer."Dont Charge Transactions" then
                    ChargeAmt := 0;
            end;
        end;


        if ChargeAmt > 0 then begin

            if CheckAvailableBalance then begin
                AvailBal := MemberActivities.GetAccountBalance(SavingsNo);
                if AvailBal < (ChargeAmt + ChargeDuty) then
                    Error('This will lead to overdrawal of Account No. %1', SavingsNo);
            end;

            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                DocNo,
                PDate,
                Accttype::Savings,
                SavingsNo,
                CopyStr(Desc, 1, 50),
                Balaccttype::"G/L Account",
                '',
                ChargeAmt,
                CopyStr(ExtDoc, 1, 20),
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true,
                TChannel::Teller,
                0
                );


            if ChargeDuty > 0 then begin

                SaccoActivities.JournalInsert(
                    JTemplate,
                    JBatch,
                    DocNo,
                    PDate,
                    Accttype::Savings,
                    SavingsNo,
                    CopyStr('Excise Duty on ' + Desc, 1, 50),
                    Balaccttype::"G/L Account",
                    SaccoSetup."Excise Duty GL",
                    ChargeDuty,
                    CopyStr(ExtDoc, 1, 20),
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true,
                    TChannel::Teller,
                    0
                    );
            end;


            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                DocNo,
                PDate,
                ChargeAcctType,
                ChargeAcct,
                CopyStr(Desc, 1, 50),
                Balaccttype::"G/L Account",
                '',
                -(ChargeAmt - SharingAmt),
                CopyStr(ExtDoc, 1, 20),
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true,
                TChannel::Teller,
                0
                );

            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                DocNo,
                PDate,
                SharingChargeAcctType,
                SharingChargeAcct,
                CopyStr(Desc, 1, 50),
                Balaccttype::"G/L Account",
                '',
                -(SharingAmt),
                CopyStr(ExtDoc, 1, 20),
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true,
                TChannel::Teller,
                0
                );

        end;
    end;

    local procedure "************FDR****************"()
    begin
    end;


    procedure CalculateFixedInterest(var FDAccount: Record "Fixed Deposit Accounts"; SelectPeriod: Date; ProductSetup: Record "Product Setup")
    var
        IntBufferNo: Integer;
        Amount: array[10] of Decimal;
        Templates: Record "User Setup";
        JTemplate: Code[20];
        JBatch: Code[20];
        PeriodText: Text;
        InterestAccount: array[4] of Code[20];
        Description: Text;
        GlobalDim1: Code[10];
        GlobalDim2: Code[10];
        Source: Code[10];
        SourceName: Text;
        MemberNo: Code[10];
        ExcludeInterestPayment: Boolean;
        MemberCollectionAc: Code[20];
        PlacementAc: Code[20];
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        RecordExists: Boolean;
        Bal: Decimal;
        IntAmt: Decimal;
        days: Integer;
        WTax: Decimal;
        IntDay: Integer;
        MonthEnd: Integer;
        RunDate: Integer;
        SavingsInterestLines: Record "Savings Interest Buffer";
        Continue: Boolean;
        FDTypes: Record "FD Types";
        IntRate: Decimal;
        NoOfDays: Integer;
    begin
        SavingsInterestLines.Reset;
        SavingsInterestLines.SetRange("Account No.", FDAccount."No.");
        SavingsInterestLines.SetRange("Interest Date", CalcDate('-CM', SelectPeriod), CalcDate('CM', SelectPeriod));
        SavingsInterestLines.SetRange(Accrued, false);
        SavingsInterestLines.SetRange(Posted, false);
        if SavingsInterestLines.FindFirst then
            SavingsInterestLines.DeleteAll;

        SaccoSetup.Get;

        if (FDAccount."FD Start Date" < SelectPeriod) and (FDAccount."FD Maturity Date" > FDAccount."FD Start Date") then begin
            repeat
                FDAccount.TestField("FD Start Date");
                IntDay := Date2dmy(FDAccount."FD Start Date", 1);
                MonthEnd := Date2dmy(CalcDate('CM', SelectPeriod), 1);
                if IntDay > MonthEnd then
                    IntDay := MonthEnd;
                RunDate := Date2dmy(SelectPeriod, 1);


                Continue := false;
                if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate & Post Every End Month" then begin
                    if SelectPeriod = CalcDate('CM', SelectPeriod) then
                        Continue := true;
                end
                else
                    if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate and Post On Anniversary" then begin
                        if IntDay = RunDate then
                            Continue := true;
                    end
                    else
                        if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate and Post On Maturity" then begin
                            if FDAccount."FD Maturity Date" <= SelectPeriod then
                                Continue := true;
                        end
                        else
                            if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate Every End Month and Post on Maturity" then begin
                                if SelectPeriod = CalcDate('CM', SelectPeriod) then
                                    Continue := true;
                            end
                            else
                                if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate On Anniversary and Post on Maturity" then begin
                                    if IntDay = RunDate then
                                        Continue := true;
                                end;

                //Message('IntRate1 %1', IntRate);


                if Continue then begin
                    GlobalDim1 := '';
                    GlobalDim1 := FDAccount."Global Dimension 1 Code";
                    GlobalDim2 := '';
                    GlobalDim2 := FDAccount."Global Dimension 2 Code";

                    FDAccount.CalcFields("Fixed Account Balance");
                    Bal := FDAccount."Fixed Account Balance";

                    //Message('IntRate2 %1\Bal: %2\FDAmt: %3', IntRate, bal, FDAccount."FD Amount");

                    if (round(Bal, 1, '>') >= round(FDAccount."FD Amount", 1, '>')) and (Bal > 0) then begin
                        FDTypes.Get(FDAccount."FD Type");
                        FDTypes.TestField(Months);


                        IntRate := FDAccount."FD Annual Interest %";
                        if FDAccount."Negotiated Interest %" > 0 then
                            IntRate := FDAccount."Negotiated Interest %";

                        IntAmt := CalcDailyInterest(Bal, IntRate, WorkDate());

                        if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate and Post On Maturity" then
                            IntAmt := CalcMaturityInterest(Bal, IntRate, FDAccount."FD Start Date", FDAccount."FD Maturity Date");


                        ProductSetup.TestField("Interest Payable Account");
                        ProductSetup.TestField("Withholding Tax Account");
                        ProductSetup.TestField("Interest Expense Account");
                        ProductSetup.TestField("WithHolding Tax");

                        WTax := 0;
                        if not FDAccount."Exempt W/Tax" then
                            WTax := Round((ProductSetup."WithHolding Tax" / 100) * IntAmt, 0.01, '=');

                        IntBufferNo := IntBufferNo + 1;

                        RecordExists := false;
                        SavingsInterestLines.Reset;
                        SavingsInterestLines.SetRange("Account No.", FDAccount."No.");
                        IF (SaccoSetup."FD Interest Accrual" = SaccoSetup."FD Interest Accrual"::"Calculate and Post On Maturity") then
                            SavingsInterestLines.SetRange("Interest Date", CalcDate('-CM', FDAccount."FD Maturity Date"), CalcDate('CM', FDAccount."FD Maturity Date"))
                        else
                            SavingsInterestLines.SetRange("Interest Date", CalcDate('-CM', SelectPeriod), CalcDate('CM', SelectPeriod));
                        //SavingsInterestLines.SetRange(Accrued, true);
                        if SavingsInterestLines.Find('-') then
                            RecordExists := true;

                        //Message('RecordExists: %1', RecordExists);

                        if not RecordExists then begin

                            Description := 'Interest on matured fixed deposit :- ' + Format(SelectPeriod, 0, '<Month Text> <Closing><Day>, <Year4>');

                            SavingsInterestLines.Init;
                            SavingsInterestLines."Account No." := FDAccount."No.";
                            SavingsInterestLines."Product Type" := ProductSetup."Product ID";
                            SavingsInterestLines."Qualifying Amount" := Bal;
                            SavingsInterestLines."Member No." := FDAccount."Member No.";
                            SavingsInterestLines."Interest Date" := SelectPeriod;
                            IF (SaccoSetup."FD Interest Accrual" = SaccoSetup."FD Interest Accrual"::"Calculate and Post On Maturity") then begin
                                Description := 'Interest on matured fixed deposit :- ' + Format(FDAccount."FD Maturity Date", 0, '<Month Text> <Closing><Day>, <Year4>');
                                SavingsInterestLines."Interest Date" := FDAccount."FD Maturity Date";
                                SavingsInterestLines."Interest Date" := FDAccount."FD Maturity Date";
                            end;

                            SavingsInterestLines.Description := Description;
                            SavingsInterestLines."Interest Rate" := IntRate;
                            SavingsInterestLines."Interest Amount" := IntAmt;
                            SavingsInterestLines."Witholding Tax" := WTax;
                            SavingsInterestLines."Payable Account" := ProductSetup."Interest Payable Account";
                            SavingsInterestLines."Withholding Tax Account" := ProductSetup."Withholding Tax Account";
                            SavingsInterestLines."Expense Account" := ProductSetup."Interest Expense Account";
                            SavingsInterestLines."User ID" := UserId;
                            SavingsInterestLines.Validate("Global Dimension 2 Code", GlobalDim2);
                            SavingsInterestLines.Validate("Global Dimension 1 Code", GlobalDim1);
                            if SavingsInterestLines."Interest Amount" <> 0 then
                                SavingsInterestLines.Insert;

                        end;
                    end;
                end;
            until FDAccount.Next = 0;
        end;
    end;

    procedure CalcDailyInterest(Bal: Decimal; AnnualRate: Decimal; ForDate: Date): Decimal
    var
        DaysInMonth: Integer;
        DaysInYear: Integer;
        Year: Integer;
    begin
        // Days in the given month
        DaysInMonth := Date2DMY(CalcDate('<CM>', ForDate), 1);

        // Leap year check
        Year := Date2DMY(ForDate, 3);
        if ((Year mod 4 = 0) and (Year mod 100 <> 0)) or (Year mod 400 = 0) then
            DaysInYear := 366
        else
            DaysInYear := 365;

        exit(ROUND((AnnualRate / 100 / DaysInYear) * DaysInMonth * Bal, 0.01, '<'));
    end;

    procedure CalcMaturityInterest(Bal: Decimal; AnnualRate: Decimal; StartDate: Date; MaturityDate: Date): Decimal
    var
        TotalDays: Integer;
        DaysInYear: Integer;
        Year: Integer;
    begin
        TotalDays := MaturityDate - StartDate;

        Year := Date2DMY(StartDate, 3);
        if ((Year mod 4 = 0) and (Year mod 100 <> 0)) or (Year mod 400 = 0) then
            DaysInYear := 366
        else
            DaysInYear := 365;

        exit(ROUND((AnnualRate / 100 / DaysInYear) * TotalDays * Bal, 0.01, '<'));
    end;

    procedure CalculateBankFixedInterest(var FDAccount: Record "Fixed Deposit Accounts"; SelectPeriod: Date)
    var
        IntBufferNo: Integer;
        Amount: array[10] of Decimal;
        Templates: Record "User Setup";
        JTemplate: Code[20];
        JBatch: Code[20];
        PeriodText: Text;
        InterestAccount: array[4] of Code[20];
        Description: Text;
        GlobalDim1: Code[10];
        GlobalDim2: Code[10];
        Source: Code[10];
        SourceName: Text;
        MemberNo: Code[10];
        ExcludeInterestPayment: Boolean;
        MemberCollectionAc: Code[20];
        PlacementAc: Code[20];
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        RecordExists: Boolean;
        Bal: Decimal;
        IntAmt: Decimal;
        days: Integer;
        WTax: Decimal;
        IntDay: Integer;
        MonthEnd: Integer;
        RunDate: Integer;
        SavingsInterestLines: Record "Savings Interest Buffer";
        Continue: Boolean;
        FDTypes: Record "FD Types";
        IntRate: Decimal;
    begin
        SavingsInterestLines.Reset;
        SavingsInterestLines.SetRange("Account No.", FDAccount."No.");
        SavingsInterestLines.SetRange("Interest Date", CalcDate('-CM', SelectPeriod), CalcDate('CM', SelectPeriod));
        SavingsInterestLines.SetRange(Accrued, false);
        SavingsInterestLines.SetRange(Posted, false);
        if SavingsInterestLines.FindFirst then
            SavingsInterestLines.DeleteAll;

        SaccoSetup.Get;

        if (FDAccount."FD Start Date" < SelectPeriod) and (FDAccount."FD Maturity Date" > FDAccount."FD Start Date") then begin
            repeat
                FDAccount.TestField("FD Start Date");
                IntDay := Date2dmy(FDAccount."FD Start Date", 1);
                MonthEnd := Date2dmy(CalcDate('CM', SelectPeriod), 1);
                if IntDay > MonthEnd then
                    IntDay := MonthEnd;
                RunDate := Date2dmy(SelectPeriod, 1);


                Continue := false;
                if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate & Post Every End Month" then begin
                    if SelectPeriod = CalcDate('CM', SelectPeriod) then
                        Continue := true;
                end
                else
                    if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate and Post On Anniversary" then begin
                        if IntDay = RunDate then
                            Continue := true;
                    end
                    else
                        if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate and Post On Maturity" then begin
                            if FDAccount."FD Maturity Date" <= SelectPeriod then
                                Continue := true;
                        end
                        else
                            if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate Every End Month and Post on Maturity" then begin
                                if SelectPeriod = CalcDate('CM', SelectPeriod) then
                                    Continue := true;
                            end
                            else
                                if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate On Anniversary and Post on Maturity" then begin
                                    if IntDay = RunDate then
                                        Continue := true;
                                end;

                //Message('IntRate1 %1', IntRate);


                if Continue then begin
                    GlobalDim1 := '';
                    GlobalDim1 := FDAccount."Global Dimension 1 Code";
                    GlobalDim2 := '';
                    GlobalDim2 := FDAccount."Global Dimension 2 Code";

                    FDAccount.CalcFields("Fixed Account Balance");
                    Bal := FDAccount."Fixed Account Balance";

                    //Message('IntRate2 %1\Bal: %2\FDAmt: %3', IntRate, bal, FDAccount."FD Amount");

                    if (round(Bal, 1, '>') >= round(FDAccount."FD Amount", 1, '>')) and (Bal > 0) then begin
                        FDTypes.Get(FDAccount."FD Type");
                        FDTypes.TestField(Months);
                        Bal := FDAccount."FD Amount";

                        IntRate := FDAccount."FD Annual Interest %";
                        if FDAccount."Negotiated Interest %" > 0 then
                            IntRate := FDAccount."Negotiated Interest %";

                        //Message('IntRate %1', IntRate);
                        IntAmt := ROUND((IntRate / 1200) * Bal, 0.01, '<');

                        if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate and Post On Maturity" then
                            IntAmt := IntAmt * FDTypes.Months;


                        ProductSetup.TestField("Interest Payable Account");
                        ProductSetup.TestField("Withholding Tax Account");
                        ProductSetup.TestField("Interest Expense Account");
                        ProductSetup.TestField("WithHolding Tax");

                        WTax := 0;
                        if not FDAccount."Exempt W/Tax" then
                            WTax := (ProductSetup."WithHolding Tax" / 100) * IntAmt;

                        IntBufferNo := IntBufferNo + 1;

                        RecordExists := false;
                        SavingsInterestLines.Reset;
                        SavingsInterestLines.SetRange("Account No.", FDAccount."No.");
                        IF (SaccoSetup."FD Interest Accrual" = SaccoSetup."FD Interest Accrual"::"Calculate and Post On Maturity") then
                            SavingsInterestLines.SetRange("Interest Date", CalcDate('-CM', FDAccount."FD Maturity Date"), CalcDate('CM', FDAccount."FD Maturity Date"))
                        else
                            SavingsInterestLines.SetRange("Interest Date", CalcDate('-CM', SelectPeriod), CalcDate('CM', SelectPeriod));
                        //SavingsInterestLines.SetRange(Accrued, true);
                        if SavingsInterestLines.Find('-') then
                            RecordExists := true;

                        //Message('RecordExists: %1', RecordExists);

                        if not RecordExists then begin

                            Description := 'Accrued Interest :- ' + Format(SelectPeriod, 0, '<Month Text> <Closing><Day>, <Year4>');

                            SavingsInterestLines.Init;
                            SavingsInterestLines."Account No." := FDAccount."No.";
                            SavingsInterestLines."Product Type" := ProductSetup."Product ID";
                            SavingsInterestLines."Qualifying Amount" := Bal;
                            SavingsInterestLines."Member No." := FDAccount."Member No.";
                            SavingsInterestLines."Interest Date" := SelectPeriod;
                            IF (SaccoSetup."FD Interest Accrual" = SaccoSetup."FD Interest Accrual"::"Calculate and Post On Maturity") then begin
                                Description := 'Accrued Interest :- ' + Format(FDAccount."FD Maturity Date", 0, '<Month Text> <Closing><Day>, <Year4>');
                                SavingsInterestLines."Interest Date" := FDAccount."FD Maturity Date";
                                SavingsInterestLines."Interest Date" := FDAccount."FD Maturity Date";
                            end;

                            SavingsInterestLines.Description := Description;
                            SavingsInterestLines."Interest Rate" := IntRate;
                            SavingsInterestLines."Interest Amount" := IntAmt;
                            SavingsInterestLines."Witholding Tax" := WTax;
                            SavingsInterestLines."Payable Account" := ProductSetup."Interest Payable Account";
                            SavingsInterestLines."Withholding Tax Account" := ProductSetup."Withholding Tax Account";
                            SavingsInterestLines."Expense Account" := ProductSetup."Interest Expense Account";
                            SavingsInterestLines."User ID" := UserId;
                            SavingsInterestLines.Validate("Global Dimension 2 Code", GlobalDim2);
                            SavingsInterestLines.Validate("Global Dimension 1 Code", GlobalDim1);
                            if SavingsInterestLines."Interest Amount" <> 0 then
                                SavingsInterestLines.Insert;

                        end;
                    end;
                end;
            until FDAccount.Next = 0;
        end;
    end;


    procedure ProcessPlacement(Acct: Code[20]; SelectPeriod: Date; ProductSetup: Record "Product Setup")
    var
        SavingsInterestLines: Record "Savings Interest Buffer";
        FDAccount: Record "Fixed Deposit Accounts";
        IntBufferNo: Integer;
        Amount: array[10] of Decimal;
        JTemplate: Code[20];
        JBatch: Code[20];
        LineN: Integer;
        PeriodText: Text;
        InterestAccount: array[4] of Code[20];
        Description: Text;
        GlobalDim1: Code[10];
        GlobalDim2: Code[10];
        Source: Code[10];
        SourceName: Text;
        MemberNo: Code[10];
        ExcludeInterestPayment: Boolean;
        MemberCollectionAc: Code[20];
        PlacementAc: Code[20];
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        RecordExists: Boolean;
        Bal: Decimal;
        IntAmt: Decimal;
        days: Integer;
        WTax: Decimal;
        IntDay: Integer;
        MonthEnd: Integer;
        RunDate: Integer;
        Gross: Decimal;
        Net: Decimal;
        BUser: Record "User Setup";
        AccNo: Code[20];
        Desc: Text[100];
        TransferInterest: Boolean;
        SendCertificateEmail: Boolean;
        CertificateFDNo: Code[20];
        j: Integer;
        Continue: Boolean;
        DimID: Integer;
        FDEmail: Report "Email FD Certificate";
    begin


        BUser.Get(UserId);
        BUser.TestField("Payment Journal Template");
        BUser.TestField("Payment Journal Batch");
        BUser.TestField("Dimension Set ID");
        SaccoSetup.Get();

        DimID := BUser."Dimension Set ID";

        JTemplate := BUser."Payment Journal Template";
        JBatch := BUser."Payment Journal Batch";

        FDAccount.Reset;
        FDAccount.SetFilter("No.", Acct);
        //FDAccount.SetRange("Date Filter", 0D, SelectPeriod);
        FDAccount.SetFilter("Fixed Account Balance", '>0');
        FDAccount.SetFilter("FD Start Date", '<%1', SelectPeriod);
        FDAccount.SetFilter("FD Maturity Date", '<>%1', 0D);
        if FDAccount.Find('-') then begin
            repeat


                SendCertificateEmail := false;
                CertificateFDNo := '';
                FDAccount.TestField("FD Start Date");
                IntDay := Date2dmy(FDAccount."FD Start Date", 1);

                if FDAccount."Global Dimension 2 Code" = '' then
                    FDAccount."Global Dimension 2 Code" := BUser."Global Dimension 2 Code";

                GlobalDim1 := FDAccount."Global Dimension 1 Code";
                GlobalDim2 := FDAccount."Global Dimension 2 Code";

                MonthEnd := Date2dmy(CalcDate('CM', SelectPeriod), 1);
                if IntDay > MonthEnd then
                    IntDay := MonthEnd;

                RunDate := Date2dmy(SelectPeriod, 1);



                Continue := false;
                if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate & Post Every End Month" then begin
                    if SelectPeriod = CalcDate('CM', SelectPeriod) then
                        Continue := true;
                end
                else
                    if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate and Post On Anniversary" then begin
                        if IntDay = RunDate then
                            Continue := true;
                    end
                    else
                        if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate and Post On Maturity" then begin
                            if FDAccount."FD Maturity Date" <= SelectPeriod then
                                Continue := true;
                        end
                        else
                            if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate Every End Month and Post on Maturity" then begin
                                if SelectPeriod = CalcDate('CM', SelectPeriod) then
                                    Continue := true;
                            end
                            else
                                if SaccoSetup."FD Interest Accrual" = SaccoSetup."fd interest accrual"::"Calculate On Anniversary and Post on Maturity" then begin
                                    if IntDay = RunDate then
                                        Continue := true;
                                end;




                if Continue then begin

                    Gross := 0;
                    WTax := 0;
                    Net := 0;
                    FDAccount.CalcFields("Fixed Account Balance");
                    Bal := FDAccount."Fixed Account Balance";

                    FDAccount.CalcFields("Fixed Account Balance");
                    Bal := FDAccount."Fixed Account Balance";

                    //if (Bal < FDAccount."FD Amount") and (Bal > 0) then
                    //  Error('Insufficient FD Balance');

                    Bal := FDAccount."FD Amount";

                    SavingsInterestLines.Reset;
                    SavingsInterestLines.SetRange("Account No.", FDAccount."No.");
                    SavingsInterestLines.SetRange(Accrued, false);
                    SavingsInterestLines.SetRange(Posted, false);
                    if SavingsInterestLines.FindFirst then begin

                        SavingsInterestLines.CalcSums("Interest Amount");
                        SavingsInterestLines.CalcSums("Witholding Tax");
                        Gross := SavingsInterestLines."Interest Amount";
                        WTax := SavingsInterestLines."Witholding Tax";
                        Net := Gross - WTax;

                        if Net > 0 then begin
                            SaccoActivities.JournalInit(JTemplate, JBatch);

                            AccNo := ProductSetup."Interest Expense Account";
                            Desc := CopyStr('Interest on matured fixed deposit: ' + FDAccount."No.", 1, 100);
                            SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::"G/L Account", AccNo, Desc,
                                Accttype::"G/L Account", '', Gross, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);

                            AccNo := ProductSetup."Interest Payable Account";
                            Desc := CopyStr('Interest on matured fixed deposit: ' + FDAccount."No.", 1, 100);
                            SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::"G/L Account", AccNo, Desc,
                                Accttype::"G/L Account", '', -Gross, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);

                            SavingsInterestLines.ModifyAll(Accrued, true);
                            SavingsInterestLines.ModifyAll("Accrued By", UserId);
                            SaccoActivities.JournalPost(JTemplate, JBatch);

                        end;
                    end;


                    TransferInterest := false;

                    if FDAccount."FD Maturity Date" <= SelectPeriod then
                        TransferInterest := true;

                    if FDAccount."Payment Frequency" <> FDAccount."payment frequency"::"On Maturity" then begin
                        if FDAccount."Payment Frequency" = FDAccount."payment frequency"::Monthly then
                            TransferInterest := true;
                        if FDAccount."Payment Frequency" = FDAccount."payment frequency"::Quarterly then begin
                            j := 1;
                            while j <= 12 do begin
                                if CalcDate(Format(j) + 'Q', FDAccount."FD Start Date") <= SelectPeriod then
                                    TransferInterest := true;
                                j += 1;
                            end;

                        end;

                        if FDAccount."Payment Frequency" = FDAccount."payment frequency"::"Tri-Annually" then begin
                            j := 4;
                            while j <= 36 do begin
                                if CalcDate(Format(j) + 'M', FDAccount."FD Start Date") <= SelectPeriod then
                                    TransferInterest := true;
                                j += 4;
                            end;

                        end;


                        if FDAccount."Payment Frequency" = FDAccount."payment frequency"::"Semi-Annually" then begin
                            j := 6;
                            while j <= 36 do begin
                                if CalcDate(Format(j) + 'M', FDAccount."FD Start Date") <= SelectPeriod then
                                    TransferInterest := true;
                                j += 6;
                            end;
                        end;


                        if FDAccount."Payment Frequency" = FDAccount."payment frequency"::Annually then begin
                            j := 12;
                            while j <= 36 do begin
                                if CalcDate(Format(j) + 'M', FDAccount."FD Start Date") <= SelectPeriod then
                                    TransferInterest := true;
                                j += 12;
                            end;
                        end;

                    end;


                    if TransferInterest then begin

                        SavingsInterestLines.Reset;
                        SavingsInterestLines.SetRange("Account No.", FDAccount."No.");
                        SavingsInterestLines.SetRange(Accrued, true);
                        SavingsInterestLines.SetRange(Posted, false);
                        if SavingsInterestLines.FindFirst then begin

                            SavingsInterestLines.CalcSums("Interest Amount");
                            SavingsInterestLines.CalcSums("Witholding Tax");
                            Gross := SavingsInterestLines."Interest Amount";
                            WTax := Round(SavingsInterestLines."Witholding Tax", 0.01, '=');
                            Net := Gross - WTax;

                            if Net > 0 then begin

                                SaccoActivities.JournalInit(JTemplate, JBatch);

                                AccNo := ProductSetup."Interest Payable Account";
                                Desc := CopyStr('Interest on matured fixed deposit: ' + Format(SelectPeriod), 1, 100);
                                SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::"G/L Account", AccNo, Desc,
                                    Accttype::"G/L Account", '', Gross, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);

                                Desc := CopyStr('Interest on matured fixed deposit: ' + Format(SelectPeriod), 1, 100);
                                SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::Savings, FDAccount."Fixed Account No.", Desc,
                                    Accttype::"G/L Account", '', -Net, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);

                                if WTax > 0 then begin
                                    Desc := CopyStr('Withholding Tax on Interest Earned: ' + FDAccount."No." + ' :' + Format(SelectPeriod), 1, 100);
                                    SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::"G/L Account", ProductSetup."Withholding Tax Account", Desc,
                                        Accttype::"G/L Account", '', -WTax, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);
                                end;

                                if FDAccount."FD Maturity Instructions" <> FDAccount."fd maturity instructions"::"Renew Both Principal & Interest" then begin

                                    AccNo := FDAccount."Savings Account";
                                    Desc := CopyStr('Interest on matured fixed deposit Transfer from A/C: ' + FDAccount."No.", 1, 100);
                                    if FDAccount."FD Maturity Instructions" = FDAccount."fd maturity instructions"::"Transfer Interest & Renew Principal" then begin
                                        SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::Savings, AccNo, Desc,
                                                                                    Accttype::"G/L Account", '', -Net, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);

                                        AccNo := FDAccount."Fixed Account No.";
                                        Desc := CopyStr('Interest on matured fixed deposit Transfer to A/C: ' + FDAccount."Savings Account", 1, 100);
                                        SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::Savings, AccNo, Desc,
                                            Accttype::"G/L Account", '', Net, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);
                                    end else begin

                                        SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::Savings, AccNo, Desc,
                                            Accttype::"G/L Account", '', -Net, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);

                                        AccNo := FDAccount."Fixed Account No.";
                                        Desc := CopyStr('Interest on matured fixed deposit Transfer to A/C: ' + FDAccount."Savings Account", 1, 100);
                                        SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::Savings, AccNo, Desc,
                                            Accttype::"G/L Account", '', Net, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);
                                    end;


                                end;


                                if (FDAccount."FD Maturity Instructions" = FDAccount."fd maturity instructions"::"Transfer all to Bank")
                                   and (FDAccount."FD Maturity Date" <= SelectPeriod) then begin
                                    AccNo := FDAccount."Savings Account";
                                    Desc := CopyStr('Principal Transfer from A/C: ' + FDAccount."No.", 1, 100);
                                    SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::Savings, AccNo, Desc,
                                        Accttype::"G/L Account", '', -Bal, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);

                                    AccNo := FDAccount."Fixed Account No.";
                                    Desc := CopyStr('Principal Transfer to A/C: ' + FDAccount."Savings Account", 1, 100);
                                    SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::Savings, AccNo, Desc,
                                        Accttype::"G/L Account", '', Bal, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);

                                end;

                                if (FDAccount."FD Maturity Instructions" = FDAccount."fd maturity instructions"::"Transfer all to Savings")
                                    and (FDAccount."FD Maturity Date" <= SelectPeriod) then begin

                                    AccNo := FDAccount."Savings Account";
                                    Desc := CopyStr('Principal Transfer from A/C: ' + FDAccount."No.", 1, 100);
                                    SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::Savings, AccNo, Desc,
                                        Accttype::"G/L Account", '', -Bal, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);

                                    AccNo := FDAccount."Fixed Account No.";
                                    Desc := CopyStr('Principal Transfer to A/C: ' + FDAccount."Savings Account", 1, 100);
                                    SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::Savings, AccNo, Desc,
                                        Accttype::"G/L Account", '', Bal, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);

                                end;


                                if FDAccount."FD Maturity Date" <= SelectPeriod then begin
                                    if (FDAccount."FD Maturity Instructions" = FDAccount."fd maturity instructions"::"Transfer all to Savings") or
                                       (FDAccount."FD Maturity Instructions" = FDAccount."fd maturity instructions"::"Transfer all to Bank") then begin
                                        //FDAccount."FD Maturity Date" := 0D;
                                        FDAccount."FD Status" := FDAccount."fd status"::Closed;
                                        FDAccount.Modify;
                                    end
                                    else begin
                                        FDAccount.Validate("FD Start Date", FDAccount."FD Maturity Date");
                                        if FDAccount."FD Maturity Instructions" = FDAccount."fd maturity instructions"::"Renew Both Principal & Interest" then
                                            FDAccount."FD Amount" += Net;
                                        FDAccount.Validate("FD Amount");
                                        FDAccount.Modify;

                                        SendCertificateEmail := true;
                                        CertificateFDNo := FDAccount."No.";
                                    end;
                                end;

                                SavingsInterestLines.ModifyAll(Posted, true);
                                SavingsInterestLines.ModifyAll("Posted By", UserId);
                                SaccoActivities.JournalPost(JTemplate, JBatch);
                                if SendCertificateEmail then
                                    TrySendFDCertificateEmail(CertificateFDNo);

                            end;
                        end;
                    end;

                end;

            until FDAccount.Next = 0;
        end;
    end;

    [TryFunction]
    local procedure TrySendFDCertificateEmail(FDNo: Code[20])
    var
        FixedDepositAccount: Record "Fixed Deposit Accounts";
    begin
        if FDNo = '' then
            exit;

        FixedDepositAccount.Reset();
        FixedDepositAccount.SetRange("No.", FDNo);
        if FixedDepositAccount.FindFirst() then
            Report.Run(Report::"Email FD Certificate", false, false, FixedDepositAccount);
    end;


    procedure BreakPlacement(SelectPeriod: Date; PlacementAcct: Code[20]; ProductSetup: Record "Product Setup")
    var
        SavingsInterestLines: Record "Savings Interest Buffer";
        FDAccount: Record "Fixed Deposit Accounts";
        IntBufferNo: Integer;
        Amount: array[10] of Decimal;
        JTemplate: Code[20];
        JBatch: Code[20];
        LineN: Integer;
        PeriodText: Text;
        InterestAccount: array[4] of Code[20];
        Description: Text;
        GlobalDim1: Code[10];
        GlobalDim2: Code[10];
        Source: Code[10];
        SourceName: Text;
        MemberNo: Code[10];
        ExcludeInterestPayment: Boolean;
        MemberCollectionAc: Code[20];
        PlacementAc: Code[20];
        RecordExists: Boolean;
        Bal: Decimal;
        IntAmt: Decimal;
        days: Integer;
        WTax: Decimal;
        IntDay: Integer;
        MonthEnd: Integer;
        RunDate: Integer;
        Gross: Decimal;
        Net: Decimal;
        BUser: Record "User Setup";
        AccNo: Code[20];
        Desc: Text[50];
        TransferInterest: Boolean;
        j: Integer;
        LastIntDate: Date;
        DimID: Integer;
    begin


        BUser.Get(UserId);
        BUser.TestField("Payment Journal Template");
        BUser.TestField("Payment Journal Batch");
        BUser.TestField("Dimension Set ID");

        DimID := BUser."Dimension Set ID";

        JTemplate := BUser."Payment Journal Template";
        JBatch := BUser."Payment Journal Batch";



        SavingsInterestLines.Reset;
        SavingsInterestLines.SetRange("Interest Date", 0D, SelectPeriod);
        SavingsInterestLines.SetRange("Account No.", PlacementAcct);
        SavingsInterestLines.SetRange(Accrued, false);
        SavingsInterestLines.SetRange(Posted, false);
        if SavingsInterestLines.FindFirst then
            SavingsInterestLines.DeleteAll;

        LastIntDate := 0D;

        SavingsInterestLines.Reset;
        SavingsInterestLines.SetRange("Account No.", PlacementAcct);
        if SavingsInterestLines.FindLast then
            LastIntDate := SavingsInterestLines."Interest Date";

        FDAccount.Reset;
        FDAccount.SetRange("No.", PlacementAcct);
        FDAccount.SetRange("Date Filter", 0D, SelectPeriod);
        FDAccount.SetFilter("Fixed Account Balance", '>0');
        FDAccount.SetFilter("FD Maturity Date", '>=%1', SelectPeriod);
        if FDAccount.Find('-') then begin
            repeat



                FDAccount.TestField("FD Status", FDAccount."fd status"::Forfeited);
                FDAccount.TestField("FD Start Date");

                if LastIntDate < FDAccount."FD Start Date" then
                    LastIntDate := FDAccount."FD Start Date";


                IntDay := SelectPeriod - LastIntDate;


                //MESSAGE('IntDay %1 \SelectPeriod %2 \LastIntDate %3',IntDay , SelectPeriod , LastIntDate);
                if IntDay < 0 then
                    IntDay := 0;

                if IntDay > 30 then
                    IntDay := 30;

                /*IF (IntDay > 0) THEN */
                begin

                    GlobalDim1 := '';
                    GlobalDim1 := FDAccount."Global Dimension 1 Code";
                    GlobalDim2 := '';
                    GlobalDim2 := FDAccount."Global Dimension 2 Code";

                    FDAccount.CalcFields("Fixed Account Balance");
                    Bal := FDAccount."Fixed Account Balance";
                    if Bal > 0 then begin

                        if FDAccount."FD Annual Interest %" = 0 then
                            FDAccount.TestField("Negotiated Interest %");


                        if FDAccount."FD Annual Interest %" = 0 then
                            IntAmt := ROUND((FDAccount."Negotiated Interest %" / 1200) * Bal * (IntDay / 30), 0.01, '<')
                        else
                            IntAmt := ROUND((FDAccount."FD Annual Interest %" / 1200) * Bal * (IntDay / 30), 0.01, '<');


                        IntAmt := 0;
                        ProductSetup.TestField("Interest Payable Account");
                        ProductSetup.TestField("Withholding Tax Account");
                        ProductSetup.TestField("Interest Expense Account");
                        ProductSetup.TestField("WithHolding Tax");

                        WTax := 0;
                        if not FDAccount."Exempt W/Tax" then
                            WTax := (ProductSetup."WithHolding Tax" / 100) * IntAmt;

                        IntBufferNo := IntBufferNo + 1;



                        if not Confirm('Premature Interest of KES ' + Format(IntAmt) + ' for ' + Format(IntDay) + ' day(s) will be posted. Do you want to continue?') then
                            Error('Aborted');


                        //IF NOT RecordExists THEN BEGIN
                        Description := 'Accrued Interest :- ' + Format(SelectPeriod, 0, '<Month Text> <Closing><Day>, <Year4>');
                        SavingsInterestLines.Init;
                        SavingsInterestLines."Account No." := FDAccount."No.";
                        SavingsInterestLines."Product Type" := ProductSetup."Product ID";
                        SavingsInterestLines."Qualifying Amount" := Bal;
                        SavingsInterestLines."Member No." := FDAccount."Member No.";
                        SavingsInterestLines."Interest Date" := SelectPeriod;
                        SavingsInterestLines.Description := Description;
                        SavingsInterestLines."Interest Rate" := FDAccount."Negotiated Interest %";
                        SavingsInterestLines."Interest Amount" := IntAmt;
                        SavingsInterestLines."Witholding Tax" := WTax;
                        SavingsInterestLines."Payable Account" := ProductSetup."Interest Payable Account";
                        SavingsInterestLines."Withholding Tax Account" := ProductSetup."Withholding Tax Account";
                        SavingsInterestLines."Expense Account" := ProductSetup."Interest Expense Account";
                        SavingsInterestLines."User ID" := UserId;
                        SavingsInterestLines.Validate("Global Dimension 2 Code", GlobalDim2);
                        SavingsInterestLines.Validate("Global Dimension 1 Code", GlobalDim1);
                        if SavingsInterestLines."Interest Amount" <> 0 then
                            SavingsInterestLines.Insert;

                        //END;
                    end;
                end;
            until FDAccount.Next = 0;
        end;



        FDAccount.Reset;
        FDAccount.SetRange("No.", PlacementAcct);
        FDAccount.SetRange("Date Filter", 0D, SelectPeriod);
        FDAccount.SetFilter("FD Maturity Date", '>=%1', SelectPeriod);
        if FDAccount.Find('-') then begin
            repeat
                FDAccount.TestField("FD Start Date");
                IntDay := Date2dmy(FDAccount."FD Start Date", 1);
                GlobalDim1 := FDAccount."Global Dimension 1 Code";
                GlobalDim2 := FDAccount."Global Dimension 2 Code";

                begin
                    GlobalDim1 := '';
                    GlobalDim1 := FDAccount."Global Dimension 1 Code";
                    GlobalDim2 := '';
                    GlobalDim2 := FDAccount."Global Dimension 2 Code";


                    Gross := 0;
                    WTax := 0;
                    Net := 0;
                    FDAccount.CalcFields("Fixed Account Balance");

                    Bal := FDAccount."FD Amount";
                    if Bal > FDAccount."Fixed Account Balance" then
                        Error('Insufficient Balance in Fixed Deposit Account');


                    /*
                    SavingsInterestLines.Reset;
                    SavingsInterestLines.SetRange("Account No.", FDAccount."No.");
                    SavingsInterestLines.SetRange(Accrued, false);
                    SavingsInterestLines.SetRange(Posted, false);
                    if SavingsInterestLines.FindFirst then begin

                        SavingsInterestLines.CalcSums("Interest Amount");
                        SavingsInterestLines.CalcSums("Witholding Tax");
                        Gross := SavingsInterestLines."Interest Amount";
                        WTax := SavingsInterestLines."Witholding Tax";
                        Net := Gross - WTax;

                        if Net > 0 then begin
                            SaccoActivities.JournalInit(JTemplate, JBatch);

                            AccNo := ProductSetup."Interest Expense Account";
                            Desc := 'Interest Accrual: ' + FDAccount."No.";
                            SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::"G/L Account", AccNo, Desc,
                                Accttype::"G/L Account", '', Gross, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true);

                            AccNo := ProductSetup."Interest Payable Account";
                            Desc := 'Interest Accrual: ' + FDAccount."No.";
                            SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::"G/L Account", AccNo, Desc,
                                Accttype::"G/L Account", '', -Gross, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true);

                            SavingsInterestLines.ModifyAll(Accrued, true);
                            SavingsInterestLines.ModifyAll("Accrued By", UserId);
                            SaccoActivities.JournalPost(JTemplate, JBatch);

                        end;
                    end;
                    */



                    if Bal > 0 then begin


                        SaccoActivities.JournalInit(JTemplate, JBatch);
                        /*
        
                        SavingsInterestLines.RESET;
                        SavingsInterestLines.SETRANGE("Account No.",FDAccount."No.");
                        SavingsInterestLines.SETRANGE(Accrued,TRUE);
                        SavingsInterestLines.SETRANGE(Posted,FALSE);
                        IF SavingsInterestLines.FINDFIRST THEN BEGIN
        
                            SavingsInterestLines.CALCSUMS("Interest Amount");
                            SavingsInterestLines.CALCSUMS("Witholding Tax");
                            Gross := SavingsInterestLines."Interest Amount";
                            WTax := SavingsInterestLines."Witholding Tax";
                            Net := Gross-WTax;
        
        
                            IF Net > 0 THEN BEGIN
        
        
        
                                AccNo := ProductSetup."Interest Payable Account";
                                Desc := 'Interest Earned: '+FORMAT(SelectPeriod);
                                SaccoActivities.JournalInsert(JTemplate,JBatch,FDAccount."No.",SelectPeriod,AcctType::Savings,FDAccount."No.",Desc,
                                    AcctType::"G/L Account",AccNo,-Gross,FDAccount."No.",'',0,GlobalDim1,GlobalDim2,TRUE);
        
        
                                AccNo := ProductSetup."Withholding Tax Account";
                                Desc := 'Withholding Tax on Interest Earned: '+FORMAT(SelectPeriod);
                                SaccoActivities.JournalInsert(JTemplate,JBatch,FDAccount."No.",SelectPeriod,AcctType::Savings,FDAccount."No.",Desc,
                                    AcctType::"G/L Account",AccNo,WTax,FDAccount."No.",'',0,GlobalDim1,GlobalDim2,TRUE);
        
        
                                AccNo := FDAccount."Savings Account";
                                Desc := 'Interest Transfer from A/C: '+FDAccount."No.";
                                SaccoActivities.JournalInsert(JTemplate,JBatch,FDAccount."No.",SelectPeriod,AcctType::Savings,AccNo,Desc,
                                    AcctType::"G/L Account",'',-Net,FDAccount."No.",'',0,GlobalDim1,GlobalDim2,TRUE);
        
        
                                AccNo := FDAccount."No.";
                                Desc := 'Interest Transfer to A/C: '+FDAccount."Savings Account";
                                SaccoActivities.JournalInsert(JTemplate,JBatch,FDAccount."No.",SelectPeriod,AcctType::Savings,AccNo,Desc,
                                    AcctType::"G/L Account",'',Net,FDAccount."No.",'',0,GlobalDim1,GlobalDim2,TRUE);
        
        
                                FDAccount."FD Maturity Date" := 0D;
        
                                SavingsInterestLines.MODIFYALL(Posted,TRUE);
                                SavingsInterestLines.MODIFYALL("Posted By",USERID);
        
        
                            END;
        
        
                        END;
                        */

                        AccNo := FDAccount."Savings Account";
                        Desc := CopyStr('Forefeit Principal Transfer from A/C: ' + FDAccount."No.", 1, 100);
                        SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::Savings, AccNo, Desc,
                            Accttype::"G/L Account", '', -Bal, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);

                        AccNo := FDAccount."Fixed Account No.";
                        Desc := CopyStr('Forefeit Principal Transfer to A/C: ' + FDAccount."Savings Account", 1, 100);
                        SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::Savings, AccNo, Desc,
                            Accttype::"G/L Account", '', Bal, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);


                        FDAccount."FD Status" := FDAccount."fd status"::Closed;
                        FDAccount.Modify;
                        SaccoActivities.JournalPost(JTemplate, JBatch);
                    end;
                end;

            until FDAccount.Next = 0;
        end;

    end;

    procedure BreakBankPlacement(SelectPeriod: Date; PlacementAcct: Code[20])
    var
        SavingsInterestLines: Record "Savings Interest Buffer";
        FDAccountBank: Record "Bank Fixed Deposit Account";
        IntBufferNo: Integer;
        Amount: array[10] of Decimal;
        JTemplate: Code[20];
        JBatch: Code[20];
        LineN: Integer;
        PeriodText: Text;
        InterestAccount: array[4] of Code[20];
        Description: Text;
        GlobalDim1: Code[10];
        GlobalDim2: Code[10];
        Source: Code[10];
        SourceName: Text;
        MemberNo: Code[10];
        ExcludeInterestPayment: Boolean;
        MemberCollectionAc: Code[20];
        PlacementAc: Code[20];
        RecordExists: Boolean;
        Bal: Decimal;
        IntAmt: Decimal;
        days: Integer;
        WTax: Decimal;
        IntDay: Integer;
        MonthEnd: Integer;
        RunDate: Integer;
        Gross: Decimal;
        Net: Decimal;
        BUser: Record "User Setup";
        AccNo: Code[20];
        Desc: Text[50];
        TransferInterest: Boolean;
        j: Integer;
        LastIntDate: Date;
        DimID: Integer;
    begin


        BUser.Get(UserId);
        BUser.TestField("Payment Journal Template");
        BUser.TestField("Payment Journal Batch");
        BUser.TestField("Dimension Set ID");

        DimID := BUser."Dimension Set ID";

        JTemplate := BUser."Payment Journal Template";
        JBatch := BUser."Payment Journal Batch";



        SavingsInterestLines.Reset;
        SavingsInterestLines.SetRange("Interest Date", 0D, SelectPeriod);
        SavingsInterestLines.SetRange("Account No.", PlacementAcct);
        SavingsInterestLines.SetRange(Accrued, false);
        SavingsInterestLines.SetRange(Posted, false);
        if SavingsInterestLines.FindFirst then
            SavingsInterestLines.DeleteAll;

        LastIntDate := 0D;

        SavingsInterestLines.Reset;
        SavingsInterestLines.SetRange("Account No.", PlacementAcct);
        if SavingsInterestLines.FindLast then
            LastIntDate := SavingsInterestLines."Interest Date";

        FDAccountBank.Reset;
        FDAccountBank.SetRange("No.", PlacementAcct);
        FDAccountBank.SetRange("Date Filter", 0D, SelectPeriod);
        FDAccountBank.SetFilter("Fixed Account Balance", '>0');
        FDAccountBank.SetFilter("FD Maturity Date", '>=%1', SelectPeriod);
        if FDAccountBank.Find('-') then begin
            repeat



                FDAccountBank.TestField("FD Status", FDAccountBank."fd status"::Active);
                FDAccountBank.TestField("FD Start Date");

                if LastIntDate < FDAccountBank."FD Start Date" then
                    LastIntDate := FDAccountBank."FD Start Date";


                IntDay := SelectPeriod - LastIntDate;


                //MESSAGE('IntDay %1 \SelectPeriod %2 \LastIntDate %3',IntDay , SelectPeriod , LastIntDate);
                if IntDay < 0 then
                    IntDay := 0;

                if IntDay > 30 then
                    IntDay := 30;

                /*IF (IntDay > 0) THEN */
                begin

                    GlobalDim1 := '';
                    GlobalDim1 := FDAccountBank."Global Dimension 1 Code";
                    GlobalDim2 := '';
                    GlobalDim2 := FDAccountBank."Global Dimension 2 Code";

                    FDAccountBank.CalcFields("Fixed Account Balance");
                    Bal := FDAccountBank."Fixed Account Balance";
                    if Bal > 0 then begin

                        if FDAccountBank."FD Annual Interest %" = 0 then
                            FDAccountBank.TestField("Negotiated Interest %");


                        if FDAccountBank."FD Annual Interest %" = 0 then
                            IntAmt := ROUND((FDAccountBank."Negotiated Interest %" / 1200) * Bal * (IntDay / 30), 0.01, '<')
                        else
                            IntAmt := ROUND((FDAccountBank."FD Annual Interest %" / 1200) * Bal * (IntDay / 30), 0.01, '<');


                        IntAmt := 0;
                        ProductSetup.TestField("Interest Payable Account");
                        ProductSetup.TestField("Withholding Tax Account");
                        ProductSetup.TestField("Interest Expense Account");
                        ProductSetup.TestField("WithHolding Tax");

                        WTax := 0;
                        if not FDAccountBank."Exempt W/Tax" then
                            WTax := (ProductSetup."WithHolding Tax" / 100) * IntAmt;

                        IntBufferNo := IntBufferNo + 1;



                        if not Confirm('Premature Interest of KES ' + Format(IntAmt) + ' for ' + Format(IntDay) + ' day(s) will be posted. Do you want to continue?') then
                            Error('Aborted');


                        //IF NOT RecordExists THEN BEGIN
                        Description := 'Accrued Interest :- ' + Format(SelectPeriod, 0, '<Month Text> <Closing><Day>, <Year4>');
                        SavingsInterestLines.Init;
                        SavingsInterestLines."Account No." := FDAccountBank."Fixed Account No.";
                        SavingsInterestLines."Product Type" := ProductSetup."Product ID";
                        SavingsInterestLines."Qualifying Amount" := Bal;
                        //SavingsInterestLines."Member No." := FDAccountBank."Member No.";
                        SavingsInterestLines."Interest Date" := SelectPeriod;
                        SavingsInterestLines.Description := Description;
                        SavingsInterestLines."Interest Rate" := FDAccountBank."Negotiated Interest %";
                        SavingsInterestLines."Interest Amount" := IntAmt;
                        SavingsInterestLines."Witholding Tax" := WTax;
                        SavingsInterestLines."Payable Account" := ProductSetup."Interest Payable Account";
                        SavingsInterestLines."Withholding Tax Account" := ProductSetup."Withholding Tax Account";
                        SavingsInterestLines."Expense Account" := ProductSetup."Interest Expense Account";
                        SavingsInterestLines."User ID" := UserId;
                        SavingsInterestLines.Validate("Global Dimension 2 Code", GlobalDim2);
                        SavingsInterestLines.Validate("Global Dimension 1 Code", GlobalDim1);
                        if SavingsInterestLines."Interest Amount" <> 0 then
                            SavingsInterestLines.Insert;

                        //END;
                    end;
                end;
            until FDAccountBank.Next = 0;
        end;



        FDAccountBank.Reset;
        FDAccountBank.SetRange("No.", PlacementAcct);
        FDAccountBank.SetRange("Date Filter", 0D, SelectPeriod);
        FDAccountBank.SetFilter("FD Maturity Date", '>=%1', SelectPeriod);
        if FDAccountBank.Find('-') then begin
            repeat
                FDAccountBank.TestField("FD Start Date");
                IntDay := Date2dmy(FDAccountBank."FD Start Date", 1);
                GlobalDim1 := FDAccountBank."Global Dimension 1 Code";
                GlobalDim2 := FDAccountBank."Global Dimension 2 Code";

                begin
                    GlobalDim1 := '';
                    GlobalDim1 := FDAccountBank."Global Dimension 1 Code";
                    GlobalDim2 := '';
                    GlobalDim2 := FDAccountBank."Global Dimension 2 Code";


                    Gross := 0;
                    WTax := 0;
                    Net := 0;
                    FDAccountBank.CalcFields("Fixed Account Balance");

                    Bal := FDAccountBank."FD Amount";
                    if Bal > FDAccountBank."Fixed Account Balance" then
                        Error('Insufficient Balance in Fixed Deposit Account');


                    /*
                    SavingsInterestLines.Reset;
                    SavingsInterestLines.SetRange("Account No.", FDAccount."No.");
                    SavingsInterestLines.SetRange(Accrued, false);
                    SavingsInterestLines.SetRange(Posted, false);
                    if SavingsInterestLines.FindFirst then begin

                        SavingsInterestLines.CalcSums("Interest Amount");
                        SavingsInterestLines.CalcSums("Witholding Tax");
                        Gross := SavingsInterestLines."Interest Amount";
                        WTax := SavingsInterestLines."Witholding Tax";
                        Net := Gross - WTax;

                        if Net > 0 then begin
                            SaccoActivities.JournalInit(JTemplate, JBatch);

                            AccNo := ProductSetup."Interest Expense Account";
                            Desc := 'Interest Accrual: ' + FDAccount."No.";
                            SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::"G/L Account", AccNo, Desc,
                                Accttype::"G/L Account", '', Gross, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true);

                            AccNo := ProductSetup."Interest Payable Account";
                            Desc := 'Interest Accrual: ' + FDAccount."No.";
                            SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccount."No.", SelectPeriod, Accttype::"G/L Account", AccNo, Desc,
                                Accttype::"G/L Account", '', -Gross, FDAccount."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true);

                            SavingsInterestLines.ModifyAll(Accrued, true);
                            SavingsInterestLines.ModifyAll("Accrued By", UserId);
                            SaccoActivities.JournalPost(JTemplate, JBatch);

                        end;
                    end;
                    */



                    if Bal > 0 then begin


                        SaccoActivities.JournalInit(JTemplate, JBatch);
                        /*
        
                        SavingsInterestLines.RESET;
                        SavingsInterestLines.SETRANGE("Account No.",FDAccount."No.");
                        SavingsInterestLines.SETRANGE(Accrued,TRUE);
                        SavingsInterestLines.SETRANGE(Posted,FALSE);
                        IF SavingsInterestLines.FINDFIRST THEN BEGIN
        
                            SavingsInterestLines.CALCSUMS("Interest Amount");
                            SavingsInterestLines.CALCSUMS("Witholding Tax");
                            Gross := SavingsInterestLines."Interest Amount";
                            WTax := SavingsInterestLines."Witholding Tax";
                            Net := Gross-WTax;
        
        
                            IF Net > 0 THEN BEGIN
        
        
        
                                AccNo := ProductSetup."Interest Payable Account";
                                Desc := 'Interest Earned: '+FORMAT(SelectPeriod);
                                SaccoActivities.JournalInsert(JTemplate,JBatch,FDAccount."No.",SelectPeriod,AcctType::Savings,FDAccount."No.",Desc,
                                    AcctType::"G/L Account",AccNo,-Gross,FDAccount."No.",'',0,GlobalDim1,GlobalDim2,TRUE);
        
        
                                AccNo := ProductSetup."Withholding Tax Account";
                                Desc := 'Withholding Tax on Interest Earned: '+FORMAT(SelectPeriod);
                                SaccoActivities.JournalInsert(JTemplate,JBatch,FDAccount."No.",SelectPeriod,AcctType::Savings,FDAccount."No.",Desc,
                                    AcctType::"G/L Account",AccNo,WTax,FDAccount."No.",'',0,GlobalDim1,GlobalDim2,TRUE);
        
        
                                AccNo := FDAccount."Savings Account";
                                Desc := 'Interest Transfer from A/C: '+FDAccount."No.";
                                SaccoActivities.JournalInsert(JTemplate,JBatch,FDAccount."No.",SelectPeriod,AcctType::Savings,AccNo,Desc,
                                    AcctType::"G/L Account",'',-Net,FDAccount."No.",'',0,GlobalDim1,GlobalDim2,TRUE);
        
        
                                AccNo := FDAccount."No.";
                                Desc := 'Interest Transfer to A/C: '+FDAccount."Savings Account";
                                SaccoActivities.JournalInsert(JTemplate,JBatch,FDAccount."No.",SelectPeriod,AcctType::Savings,AccNo,Desc,
                                    AcctType::"G/L Account",'',Net,FDAccount."No.",'',0,GlobalDim1,GlobalDim2,TRUE);
        
        
                                FDAccount."FD Maturity Date" := 0D;
        
                                SavingsInterestLines.MODIFYALL(Posted,TRUE);
                                SavingsInterestLines.MODIFYALL("Posted By",USERID);
        
        
                            END;
        
        
                        END;
                        */

                        AccNo := FDAccountBank."Savings Account";
                        Desc := CopyStr('Forefeit Principal Transfer from A/C: ' + FDAccountBank."No.", 1, 50);
                        SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccountBank."No.", SelectPeriod, Accttype::Savings, AccNo, Desc,
                            Accttype::"G/L Account", '', -Bal, FDAccountBank."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);

                        AccNo := FDAccountBank."Fixed Account No.";
                        Desc := CopyStr('Forefeit Principal Transfer to A/C: ' + FDAccountBank."Savings Account", 1, 50);
                        SaccoActivities.JournalInsert(JTemplate, JBatch, FDAccountBank."No.", SelectPeriod, Accttype::Savings, AccNo, Desc,
                            Accttype::"G/L Account", '', Bal, FDAccountBank."No.", '', TransType::" ", GlobalDim1, GlobalDim2, true, TChannel::"Fixed Deposit", DimID);


                        FDAccountBank."FD Status" := FDAccountBank."fd status"::Closed;
                        FDAccountBank.Modify;
                        SaccoActivities.JournalPost(JTemplate, JBatch);
                    end;
                end;

            until FDAccountBank.Next = 0;
        end;

    end;



    procedure RecoverDefaulterLoans(DocNo: Code[20]; PDate: Date; LoanNo: Code[20]; MemberNo: Code[20])
    var
        MemberAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        AvailBal: Decimal;
        RunBal: Decimal;
        Member: Record Members;
        MainAccount: Code[20];
        ProductSetup: Record "Product Setup";
        LoanSecurity: Record "Loan Security";
        DedAmt: Decimal;
        Desc: Text;
        TotalBalance: Decimal;
        DefLoanNo: Code[20];
        j: Integer;
        InterestAllocation: Decimal;
        PenaltyAllocation: Decimal;
        PrincipalAllocation: Decimal;
    begin


        MainAccount := '';
        AvailBal := 0;

        MemberAccounts.Reset();
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
        MemberAccounts.SetRange("Member No.", MemberNo);
        if MemberAccounts.FindFirst() then begin
            MemberAccounts.calcfields("Balance (LCY)");
            MainAccount := MemberAccounts."No.";
            AvailBal := MemberAccounts."Balance (LCY)";
        end;

        ProductSetup.Reset();
        ProductSetup.SetRange("Skip Defaulter Recovery", false);
        if ProductSetup.FindFirst() then begin

            MemberAccounts.Reset();
            MemberAccounts.setfilter("No.", '<>%1', MainAccount);
            MemberAccounts.SetRange("Member No.", MemberNo);
            MemberAccounts.SetRange("Product Type", ProductSetup."Product ID");
            MemberAccounts.SetFilter("Balance (LCY)", '>0');
            if MemberAccounts.FindFirst() then begin
                repeat

                    MemberAccounts.calcfields("Balance (LCY)");
                    AvailBal += MemberAccounts."Balance (LCY)";
                    DedAmt := MemberAccounts."Balance (LCY)";


                    Desc := 'Defaulter Savings Transfer';
                    InsertDefaulterLine(DocNo, PDate, AcctType::Savings, MemberAccounts."No.", Desc, DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::" ");
                    InsertDefaulterLine(DocNo, PDate, AcctType::Savings, MainAccount, Desc, DedAmt * -1, Loans."Loan No.", Loans."Loan No.", TransType::" ");


                until MemberAccounts.Next() = 0;
            end;
        end;

        LoanSecurity.Reset();
        LoanSecurity.SetRange("Member No", MemberNo);
        LoanSecurity.SetFilter("Outstanding Principal", '>0');
        if LoanSecurity.FindFirst() then begin
            repeat
                Loans.Reset();
                Loans.SetRange("Member No.", MemberNo);
                Loans.SetRange("Self Guaranteed", false);
                Loans.SetRange("Loan No.", LoanSecurity."Loan No.");
                Loans.SetFilter("Outstanding Principal", '>0');
                if Loans.FindFirst() then begin
                    Loans."Self Guaranteed" := true;
                    Loans.Modify();
                end;
            until LoanSecurity.Next() = 0;
        end;

        if AvailBal > 0 then begin
            Loans.Reset();
            if LoanNo <> '' then
                Loans.SetRange("Loan No.", LoanNo);
            Loans.SetRange("Member No.", MemberNo);
            Loans.SetRange("Self Guaranteed", true);
            Loans.SetFilter("Outstanding Principal", '>0');
            if Loans.FindFirst() then begin
                repeat
                    Loans.CalcFields("Outstanding Interest", "Outstanding Penalty");
                    Loans.CalcFields("Outstanding Principal");
                    if Loans."Outstanding Interest" < 0 then
                        Loans."Outstanding Interest" := 0;
                    if Loans."Outstanding Penalty" < 0 then
                        Loans."Outstanding Penalty" := 0;

                    if AvailBal > 0 then begin
                        DedAmt := Loans."Outstanding Interest";
                        if DedAmt > AvailBal then
                            DedAmt := AvailBal;

                        if DedAmt > 0 then begin

                            Desc := 'Defaulter Interest Offset: ' + Loans."Loan Product Type Name";
                            InsertDefaulterLine(DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid");
                            InsertDefaulterLine(DocNo, PDate, AcctType::Savings, MainAccount, Desc, DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::" ");

                            AvailBal -= DedAmt;
                            DedAmt := 0;
                        end;

                    end;

                    if AvailBal > 0 then begin
                        DedAmt := Loans."Outstanding Penalty";
                        if DedAmt > AvailBal then
                            DedAmt := AvailBal;

                        if DedAmt > 0 then begin

                            Desc := 'Defaulter Penalty Offset: ' + Loans."Loan Product Type Name";
                            InsertDefaulterLine(DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Penalty Paid");
                            InsertDefaulterLine(DocNo, PDate, AcctType::Savings, MainAccount, Desc, DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::" ");

                            AvailBal -= DedAmt;
                            DedAmt := 0;
                        end;

                    end;


                    if AvailBal > 0 then begin
                        DedAmt := Loans."Outstanding Principal";
                        if DedAmt > AvailBal then
                            DedAmt := AvailBal;

                        if DedAmt > 0 then begin

                            Desc := 'Defaulter Principal Offset: ' + Loans."Loan Product Type Name";
                            InsertDefaulterLine(DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Principal Repayment");
                            InsertDefaulterLine(DocNo, PDate, AcctType::Savings, MainAccount, Desc, DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::" ");

                            AvailBal -= DedAmt;
                            DedAmt := 0;
                        end;

                    end;
                until Loans.Next() = 0;
            end;
        end;


        if AvailBal > 0 then begin
            Loans.Reset();
            if LoanNo <> '' then
                Loans.SetRange("Loan No.", LoanNo);
            Loans.SetRange("Member No.", MemberNo);
            Loans.SetRange("Self Guaranteed", false);
            Loans.SetFilter("Outstanding Principal", '>0');
            if Loans.FindFirst() then begin
                repeat
                    Loans.CalcFields("Outstanding Interest", "Outstanding Penalty");
                    Loans.CalcFields("Outstanding Principal");
                    if Loans."Outstanding Interest" < 0 then
                        Loans."Outstanding Interest" := 0;
                    if Loans."Outstanding Penalty" < 0 then
                        Loans."Outstanding Penalty" := 0;

                    if AvailBal > 0 then begin
                        DedAmt := Loans."Outstanding Interest";
                        if DedAmt > AvailBal then
                            DedAmt := AvailBal;

                        if DedAmt > 0 then begin

                            Desc := 'Defaulter SG Interest Offset: ' + Loans."Loan Product Type Name";
                            InsertDefaulterLine(DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid");
                            InsertDefaulterLine(DocNo, PDate, AcctType::Savings, MainAccount, Desc, DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::" ");

                            AvailBal -= DedAmt;
                            DedAmt := 0;
                        end;

                    end;

                    if AvailBal > 0 then begin
                        DedAmt := Loans."Outstanding Penalty";
                        if DedAmt > AvailBal then
                            DedAmt := AvailBal;

                        if DedAmt > 0 then begin

                            Desc := 'Defaulter SG Penalty Offset: ' + Loans."Loan Product Type Name";
                            InsertDefaulterLine(DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Penalty Paid");
                            InsertDefaulterLine(DocNo, PDate, AcctType::Savings, MainAccount, Desc, DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::" ");

                            AvailBal -= DedAmt;
                            DedAmt := 0;
                        end;

                    end;


                    if AvailBal > 0 then begin
                        DedAmt := Loans."Outstanding Principal";
                        if DedAmt > AvailBal then
                            DedAmt := AvailBal;

                        if DedAmt > 0 then begin

                            Desc := 'Defaulter SG Principal Offset: ' + Loans."Loan Product Type Name";
                            InsertDefaulterLine(DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Principal Repayment");
                            InsertDefaulterLine(DocNo, PDate, AcctType::Savings, MainAccount, Desc, DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::" ");

                            AvailBal -= DedAmt;
                            DedAmt := 0;
                        end;

                    end;
                until Loans.Next() = 0;
            end;
        end;


        if AvailBal > 0 then begin
            Loans.Reset();
            if LoanNo <> '' then
                Loans.SetRange("Loan No.", LoanNo);
            Loans.SetRange("Member No.", MemberNo);
            Loans.SetRange("Self Guaranteed", false);
            Loans.SetFilter("Outstanding Interest", '>0');
            if Loans.FindFirst() then begin
                repeat
                    Loans.CalcFields("Outstanding Interest");
                    if Loans."Outstanding Interest" < 0 then
                        Loans."Outstanding Interest" := 0;

                    if AvailBal > 0 then begin
                        DedAmt := Loans."Outstanding Interest";
                        if DedAmt > AvailBal then
                            DedAmt := AvailBal;

                        if DedAmt > 0 then begin

                            Desc := 'Defaulter Interest Offset: ' + Loans."Loan Product Type Name";
                            InsertDefaulterLine(DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid");
                            InsertDefaulterLine(DocNo, PDate, AcctType::Savings, MainAccount, Desc, DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::" ");

                            AvailBal -= DedAmt;
                            DedAmt := 0;
                        end;

                    end;


                until Loans.Next() = 0;
            end;
        end;


        if AvailBal > 0 then begin
            Loans.Reset();
            if LoanNo <> '' then
                Loans.SetRange("Loan No.", LoanNo);
            Loans.SetRange("Member No.", MemberNo);
            Loans.SetRange("Self Guaranteed", false);
            Loans.SetFilter("Outstanding Penalty", '>0');
            if Loans.FindFirst() then begin
                repeat
                    Loans.CalcFields("Outstanding Penalty");
                    if Loans."Outstanding Penalty" < 0 then
                        Loans."Outstanding Penalty" := 0;

                    if AvailBal > 0 then begin
                        DedAmt := Loans."Outstanding Penalty";
                        if DedAmt > AvailBal then
                            DedAmt := AvailBal;

                        if DedAmt > 0 then begin

                            Desc := 'Defaulter Penalty Offset: ' + Loans."Loan Product Type Name";
                            InsertDefaulterLine(DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Penalty Paid");
                            InsertDefaulterLine(DocNo, PDate, AcctType::Savings, MainAccount, Desc, DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::" ");

                            AvailBal -= DedAmt;
                            DedAmt := 0;
                        end;

                    end;

                until Loans.Next() = 0;
            end;
        end;


        if AvailBal > 0 then begin
            Loans.Reset();
            if LoanNo <> '' then
                Loans.SetRange("Loan No.", LoanNo);
            Loans.SetRange("Member No.", MemberNo);
            Loans.SetRange("Self Guaranteed", false);
            Loans.SetFilter("Outstanding Principal", '>0');
            if Loans.FindFirst() then begin
                repeat
                    Loans.CalcFields("Outstanding Principal");
                    if Loans."Outstanding Principal" < 0 then
                        Loans."Outstanding Principal" := 0;

                    if AvailBal > 0 then begin
                        DedAmt := Loans."Outstanding Principal";
                        if DedAmt > AvailBal then
                            DedAmt := AvailBal;

                        if DedAmt > 0 then begin

                            Desc := 'Defaulter Principal Offset: ' + Loans."Loan Product Type Name";
                            InsertDefaulterLine(DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Principal Repayment");
                            InsertDefaulterLine(DocNo, PDate, AcctType::Savings, MainAccount, Desc, DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::" ");

                            AvailBal -= DedAmt;
                            DedAmt := 0;
                        end;

                    end;

                until Loans.Next() = 0;
            end;
        end;

        if AvailBal <= 0 then begin

            Loans.Reset();
            if LoanNo <> '' then
                Loans.SetRange("Loan No.", LoanNo);
            Loans.SetRange("Member No.", MemberNo);
            Loans.SetFilter("Outstanding Principal", '>0');
            if Loans.FindFirst() then begin
                repeat
                    Loans.CalcFields("Outstanding Principal");
                    Loans.CalcFields("Outstanding Penalty");
                    Loans.CalcFields("Outstanding Interest");


                    Loans."Outstanding Interest" -= GetDefLoanCredits(DocNo, AcctType::Credit, Loans."Loan Account", Loans."Loan No.", TransType::"Interest Paid");
                    Loans."Outstanding Penalty" -= GetDefLoanCredits(DocNo, AcctType::Credit, Loans."Loan Account", Loans."Loan No.", TransType::"Penalty Paid");
                    Loans."Outstanding Principal" -= GetDefLoanCredits(DocNo, AcctType::Credit, Loans."Loan Account", Loans."Loan No.", TransType::"Principal Repayment");


                    if Loans."Outstanding Penalty" < 0 then
                        Loans."Outstanding Penalty" := 0;
                    if Loans."Outstanding Interest" < 0 then
                        Loans."Outstanding Interest" := 0;
                    if Loans."Outstanding Principal" < 0 then
                        Loans."Outstanding Principal" := 0;


                    TotalBalance := Loans."Outstanding Interest" + Loans."Outstanding Penalty" + Loans."Outstanding Principal";
                    Loans.CalcFields("Total Guaranteed");

                    LoanSecurity.Reset();
                    LoanSecurity.SetRange("Loan No.", loans."Loan No.");
                    LoanSecurity.SetRange(Substituted, false);
                    if LoanSecurity.FindFirst() then begin
                        j := 0;
                        repeat
                            j += 1;
                            InterestAllocation := 0;
                            PenaltyAllocation := 0;
                            PrincipalAllocation := 0;

                            if (Loans."Total Guaranteed") > 0 then begin
                                InterestAllocation := ROUND(LoanSecurity."Amount Guaranteed" / (Loans."Total Guaranteed") * Loans."Outstanding Interest", 0.01, '>');
                                PenaltyAllocation := ROUND(LoanSecurity."Amount Guaranteed" / (Loans."Total Guaranteed") * Loans."Outstanding Penalty", 0.01, '>');
                                PrincipalAllocation := ROUND(LoanSecurity."Amount Guaranteed" / (Loans."Total Guaranteed") * Loans."Outstanding Principal", 0.01, '>');
                            end;



                            DefLoanNo := LoanSecurity."Def. Loan No.";

                            if DefLoanNo = '' then
                                DefLoanNo := Loans."Loan No." + '/' + Format(j);



                            Desc := 'Guarantor Interest Transfer: ' + Loans."Loan Product Type Name";
                            InsertDefaulterLine(DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, -InterestAllocation, DefLoanNo, Loans."Loan No.", TransType::"Interest Paid");
                            Desc := 'Guarantor Penalty Transfer: ' + Loans."Loan Product Type Name";
                            InsertDefaulterLine(DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, -PenaltyAllocation, DefLoanNo, Loans."Loan No.", TransType::"Penalty Paid");
                            Desc := 'Guarantor Principal Transfer: ' + Loans."Loan Product Type Name";
                            InsertDefaulterLine(DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, -PrincipalAllocation, DefLoanNo, Loans."Loan No.", TransType::"Principal Repayment");



                            Desc := 'Defaulter Loan Transfer: ' + Loans."Loan Product Type Name";
                            LoanSecurity."Def. Loan No." := DefLoanNo;
                            LoanSecurity.Modify();


                            InsertDefaulterLine(DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, PrincipalAllocation + InterestAllocation + PrincipalAllocation, Loans."Loan No.", DefLoanNo, TransType::"Loan Disbursement");



                            InsertDefaulterLine(DocNo, PDate, AcctType::Savings, MainAccount, Desc, DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::" ");


                        until LoanSecurity.Next() = 0;
                    end;

                    if AvailBal > 0 then begin
                        DedAmt := Loans."Outstanding Principal";
                        if DedAmt > AvailBal then
                            DedAmt := AvailBal;

                        if DedAmt > 0 then begin

                            Desc := 'Defaulter Principal Offset: ' + Loans."Loan Product Type Name";
                            InsertDefaulterLine(DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Penalty Paid");
                            InsertDefaulterLine(DocNo, PDate, AcctType::Savings, MainAccount, Desc, DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::" ");

                            AvailBal -= DedAmt;
                            DedAmt := 0;
                        end;

                    end;

                until Loans.Next() = 0;
            end;
        end;

        MESSAGE('Loan recovery Lines Generated.');


    end;

    procedure InsertDefaulterLine(DocNo: Code[20]; PDate: Date; AcctType: Enum "Gen. Journal Account Type"; AcctNo: Code[20]; Desc: Text[150]; Amt: Decimal; ExtDocNo: Code[20]; Loan: Code[20]; TransType: Enum "Transaction Type Enum")
    var
        DLines: Record "Defaulter Recovery Buffer";
        LNo: Integer;
    begin

        LNo := 0;
        DLines.Reset();
        if DLines.FindLast() then
            LNo := DLines."Entry No.";

        LNo += 1;

        DLines.Init();
        DLines."Entry No." := LNo;
        DLines."Posting Date" := PDate;
        DLines."Document No." := DocNo;
        DLines."Account Type" := AcctType;
        DLines."Account No." := AccNo;
        DLines.Description := Desc;
        //DLines."Member No." := MNo;
        DLines.Amount := Amt;
        DLines."Credit Amount" := 0;
        DLines."Debit Amount" := 0;
        DLines."Transaction Type" := TransType;
        DLines."Loan No" := Loan;
        DLines."External Document No." := ExtDocNo;
        DLines.Insert();





    end;


    procedure GetDefLoanCredits(DocNo: Code[20]; AcctType: Enum "Gen. Journal Account Type"; AccNo: Code[20]; LoanNo: Code[20]; TransType: Enum "Transaction Type Enum"): Decimal
    var
        GenJournalLine: Record "Defaulter Recovery Buffer";
        JDebits: Decimal;
        JCredits: Decimal;
    begin
        JCredits := 0;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Document No.", DocNo);
        GenJournalLine.SetRange("Account Type", AcctType);
        GenJournalLine.SetRange("Account No.", AccNo);
        GenJournalLine.SetRange("Transaction Type", TransType);
        GenJournalLine.SetRange("Loan No", LoanNo);
        GenJournalLine.SetFilter(Amount, '<0');
        if GenJournalLine.Find('-') then begin
            repeat
                JCredits += GenJournalLine.Amount * -1;
            until GenJournalLine.Next = 0;
        end;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Document No.", DocNo);
        GenJournalLine.SetRange("Bal. Account Type", AcctType);
        GenJournalLine.SetRange("Bal. Account No.", AccNo);
        GenJournalLine.SetRange("Transaction Type", TransType);
        GenJournalLine.SetRange("Loan No", LoanNo);
        GenJournalLine.SetFilter(Amount, '>0');
        if GenJournalLine.Find('-') then begin
            repeat
                JCredits += GenJournalLine.Amount;
            until GenJournalLine.Next = 0;
        end;

        exit(JCredits);
    end;


    procedure CollectATM(ATMApplications: Record "ATM Linking Applications")
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        SavingsAccounts: Record "Savings Accounts";
        JTemp: Code[20];
        JBatch: Code[20];
        ErrDocNotApproved: label 'This document has not been approved.';
        ErrLink: label 'Kindly Charge the ATM Fee.';
        ErrAlreadyCollected: label 'The ATM Card has already been collected.';
        CONFIRMIssue: label 'Are you sure you want to issue Card?';
        MSGOperationSuc: label 'Operation effected successfully.';
    begin

        if ATMApplications.Status <> ATMApplications.Status::Approved then Error(ErrDocNotApproved);
        if ATMApplications."ATM Charges Applied" <> true then Error(ErrLink);
        if ATMApplications.Collected = true then
            Error(ErrAlreadyCollected);

        if Confirm(CONFIRMIssue, false) = true then begin

            ATMApplications.Collected := true;
            ATMApplications."Card Issued" := true;
            ATMApplications."Date Collected" := Today;
            ATMApplications."Card Issued By" := UserId;
            ATMApplications."Card Status" := ATMApplications."card status"::Active;
            ATMApplications."Date Activated" := Today;
            ATMApplications.Modify;

            SavingsAccounts.Reset;
            SavingsAccounts.SetRange(SavingsAccounts."No.", ATMApplications."Account No");



            if SavingsAccounts.Find('-') then begin
                //To allow overwriting of the existing card
                // IF SavingsAccounts."ATM No."<>'' THEN BEGIN
                //  ERROR('Please De-link the existing card first');
                // END;
                //MESSAGE(FORMAT(SavingsAccounts."No."));
                SavingsAccounts."ATM No." := ATMApplications."Card No";
                SavingsAccounts.Modify;
            end;

            Message(MSGOperationSuc);
        end;
    end;


    procedure LinkATMPIN(ATMApplications: Record "ATM Linking Applications")
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        SavingsAccounts: Record "Savings Accounts";
        JTemp: Code[20];
        JBatch: Code[20];
        ErrPosted: label 'This document has not been approved.';
        ErrChargeATM: label 'Kindly Charge the ATM Fee.';
        ConfrmATMLink: label 'Are you sure you want to Link This ATM Card?';
        ErrATMLinked: label 'This ATM card is already linked.';
        MSGATMCardLinked: label 'ATM Card Successfully linked.';
        ErrOperationCancelled: label 'Operation cancelled';
        Txt004: label 'Your account has been linked to Sacco Link ATM.';
        ATMLinkingStatistics: Record "ATM Linking  Statistics";
        Sourcetype: Enum "SMS Source Enum";
    begin
        if ATMApplications.Status <> ATMApplications.Status::Approved then Error(ErrPosted);
        // IF "ATM Charges Applied"<>TRUE THEN ERROR(ErrChargeATM);
        // IF CONFIRM(ConfrmATMLink,TRUE)=TRUE THEN BEGIN
        //IF ("ATM Linked"=TRUE) AND ("ATM Delinked"=FALSE) THEN ERROR(ErrATMLinked);
        ATMApplications.TestField("Card No");
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange(SavingsAccounts."No.", ATMApplications."Account No");
        if SavingsAccounts.Find('-') then begin
            SavingsAccounts."ATM No." := ATMApplications."Card No";
            ATMApplications."Linked Date" := Today;
            ATMApplications."Linked By" := UserId;
            ATMApplications."ATM Delinked Date" := Today;
            ATMApplications."Card Status" := ATMApplications."card status"::Active;
            ATMApplications."ATM Linked" := true;
            ATMApplications."ATM Delinked" := false;
            ATMApplications.Modify;
            SavingsAccounts.Modify;
            ATMLinkingStatistics.Init;
            ATMLinkingStatistics."Account No." := SavingsAccounts."No.";
            ATMLinkingStatistics."Activity Date" := Today;
            ATMLinkingStatistics."ATM Application No." := ATMApplications."ATM Application No.";
            ATMLinkingStatistics."Linking Type" := ATMLinkingStatistics."linking type"::Linking;
            ATMLinkingStatistics."User ID" := UserId;
            ATMLinkingStatistics."Activity Time" := Time;
            ATMLinkingStatistics.Insert(true);
            //send sms

            MemberActivities.SendSms(Sourcetype::"ATM Collection", SavingsAccounts."Mobile Phone No.", Txt004, ATMApplications."No.", SavingsAccounts."No.", true, false);

        end;
        // MESSAGE(MSGATMCardLinked);
        // END ELSE
        // ERROR(ErrOperationCancelled);
    end;


    procedure LinkATM(ATMApplications: Record "ATM Linking Applications")
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        SavingsAccounts: Record "Savings Accounts";
        JTemp: Code[20];
        JBatch: Code[20];
        ErrPosted: label 'This document has not been approved.';
        ErrChargeATM: label 'Kindly Charge the ATM Fee.';
        ConfrmATMLink: label 'Are you sure you want to Link This ATM Card?';
        ErrATMLinked: label 'This ATM card is already linked.';
        MSGATMCardLinked: label 'ATM Card Successfully linked.';
        ErrOperationCancelled: label 'Operation cancelled';
        Txt004: label 'Your account has been linked to Sacco Link ATM.';
        ATMLinkingStatistics: Record "ATM Linking  Statistics";
        Sourcetype: Enum "SMS Source Enum";
    begin
        if ATMApplications.Status <> ATMApplications.Status::Approved then Error(ErrPosted);
        if ATMApplications."ATM Charges Applied" <> true then Error(ErrChargeATM);
        if Confirm(ConfrmATMLink, true) = true then begin
            if (ATMApplications."ATM Linked" = true) and (ATMApplications."ATM Delinked" = false) then Error(ErrATMLinked);
            ATMApplications.TestField("Card No");
            SavingsAccounts.Reset;
            SavingsAccounts.SetRange(SavingsAccounts."No.", ATMApplications."Account No");
            if SavingsAccounts.Find('-') then begin

                if SavingsAccounts."ATM No." <> '' then begin
                    Error('Please De-link the existing card first');
                end;




                SavingsAccounts."ATM No." := ATMApplications."Card No";
                ATMApplications."Linked Date" := Today;
                ATMApplications."Linked By" := UserId;
                ATMApplications."ATM Delinked Date" := Today;
                ATMApplications."Card Status" := ATMApplications."card status"::Active;
                ATMApplications."ATM Linked" := true;
                ATMApplications."ATM Delinked" := false;
                ATMApplications.Modify;
                SavingsAccounts.Modify;
                ATMLinkingStatistics.Init;
                ATMLinkingStatistics."Account No." := SavingsAccounts."No.";
                ATMLinkingStatistics."Activity Date" := Today;
                ATMLinkingStatistics."ATM Application No." := ATMApplications."ATM Application No.";
                ATMLinkingStatistics."Linking Type" := ATMLinkingStatistics."linking type"::Linking;
                ATMLinkingStatistics."User ID" := UserId;
                ATMLinkingStatistics."Activity Time" := Time;
                ATMLinkingStatistics.Insert(true);
                //send sms
                MemberActivities.SendSms(Sourcetype::"ATM Collection", SavingsAccounts."Mobile Phone No.", Txt004, ATMApplications."No.", SavingsAccounts."No.", true, false);

            end;

            Message(MSGATMCardLinked);
        end else
            Error(ErrOperationCancelled);
    end;


    procedure DeLinkATM(ATMApplications: Record "ATM Linking Applications")
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        SavingsAccounts: Record "Savings Accounts";
        JTemp: Code[20];
        JBatch: Code[20];
        ConfrmATMLink: label 'Are you sure you want to delink This ATM Card?';
        ErrATMLinked: label 'This ATM card is already dellinked.';
        MSGATMCardLinked: label 'ATM Card Successfully delinked.';
        ErrOperationCancelled: label 'Operation cancelled';
        Txt004: label 'Your Account has been Delinked from ATM. In case of any query contact your branch.';
        Sourcetype: Enum "SMS Source Enum";
        ATMLinkingStatistics: Record "ATM Linking  Statistics";
    begin
        if ATMApplications.Status <> ATMApplications.Status::Approved then Error('Document Not Approved');
        if Confirm(ConfrmATMLink, true) = true then begin
            if ATMApplications."ATM Delinked" = true then Error(ErrATMLinked);
            ATMApplications.TestField("Card No");
            SavingsAccounts.Reset;
            SavingsAccounts.SetRange(SavingsAccounts."No.", ATMApplications."Account No");
            if SavingsAccounts.Find('-') then begin
                SavingsAccounts."ATM No." := '';
                ATMApplications."ATM Delinked Date" := Today;
                ATMApplications."Delinked By" := UserId;
                ATMApplications."ATM Delinked" := true;
                ATMApplications."ATM Linked" := false;
                ATMApplications."Card Status" := ATMApplications."card status"::Frozen;
                ATMApplications.Modify;
                SavingsAccounts.Modify;
                ATMLinkingStatistics.Init;
                ATMLinkingStatistics."Account No." := SavingsAccounts."No.";
                ATMLinkingStatistics."Activity Date" := Today;
                ATMLinkingStatistics."ATM Application No." := ATMApplications."ATM Application No.";
                ATMLinkingStatistics."Linking Type" := ATMLinkingStatistics."linking type"::Delinking;
                ATMLinkingStatistics."User ID" := UserId;
                ATMLinkingStatistics."Activity Time" := Time;
                ATMLinkingStatistics."Reason for change" := '';
                ATMLinkingStatistics.Insert(true);
                //send sms
                MemberActivities.SendSms(Sourcetype::"ATM Collection", SavingsAccounts."Mobile Phone No.", Txt004, ATMApplications."No.", SavingsAccounts."No.", true, false);

            end;

            Message(MSGATMCardLinked);
        end else
            Error(ErrOperationCancelled);
    end;


    procedure PostATMApplicationCharges(ATMApplications: Record "ATM Applications")
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        SavingsAccounts: Record "Savings Accounts";
        TChargeAmount: Decimal;
        TCharges: Decimal;
        GenSetup: Record "Sacco Setup";
        JTemp: Code[20];
        JBatch: Code[20];
        MSGPosted: label 'Posted Successfuly';
        ATMCharge: label 'Atm Card Charges';
        ATMCardTypes: Record "ATM Card Types";
        MemberActivities: Codeunit "Member Activities";
        SavingsAcc: Record "Savings Accounts";
        Txt004: label 'Your ATM Card application has been received and is being processed.';
        CashierTransactions: Record "Teller Transaction";
        //SharingDuty: Decimal;
        TotalCharge: Decimal;
        TotalDuty: Decimal;
        TotalSms: Decimal;
        SmsExcise: Decimal;
        SMScharges: Record "SMS Charges";
        SaccoActivities: Codeunit "Sacco Activities";
        Sourcetype: Enum "SMS Source Enum";
    begin
        //if ATMApplications."No." <> 'ATM_0001' then
        //  if ATMApplications."ATM Charges Applied" = true then
        //    exit;

        SaccoActivities.GetGeneralJournalTemplate(JTemp, JBatch);


        GenJournalLine.Reset;
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemp);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        GenSetup.Get;
        ATMCardTypes.Reset; //ez
        ATMCardTypes.SetRange(ATMCardTypes.Code, ATMApplications."Card Type");
        if ATMCardTypes.Find('-') then begin



            TChargeAmount := 0;


            ChargeAmt := 0;
            ChargeDuty := 0;
            ChargeAcctType := Chargeaccttype::"G/L Account";
            ChargeAcct := '';
            SharingChargeAcct := '';
            SharingChargeAcctType := Sharingchargeaccttype::"G/L Account";
            SharingDuty := 0;
            SharingAmt := 0;
            if ATMApplications."Request Type" = ATMApplications."request type"::New then
                MemberActivities.GetGeneral_SharingChargeAmount(ATMCardTypes."Replacement Charge Code", 0, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);
            if ATMApplications."Request Type" = ATMApplications."request type"::Replacement then
                MemberActivities.GetGeneral_SharingChargeAmount(ATMCardTypes."Replacement Charge Code", 0, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);



            TotalCharge := ChargeAmt + SharingAmt + SharingDuty;
            TotalDuty := ChargeDuty + SharingDuty;
            TChargeAmount := TotalCharge + TotalDuty;


            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := JTemp;
            GenJournalLine."Journal Batch Name" := JBatch;
            GenJournalLine."Document No." := ATMApplications."No.";

            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
            GenJournalLine."Account No." := ATMApplications."Account No";
            GenJournalLine."External Document No." := ATMApplications."No.";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'ATM Application Charge';
            GenJournalLine.Amount := TotalCharge;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Bal. Account No." := '';
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := ATMApplications."Shortcut Dimension 1 Code";
            GenJournalLine."Shortcut Dimension 2 Code" := ATMApplications."Shortcut Dimension 2 Code";
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;




            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := JTemp;
            GenJournalLine."Journal Batch Name" := JBatch;
            GenJournalLine."Document No." := ATMApplications."No.";

            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
            GenJournalLine."Account No." := ATMApplications."Account No";
            GenJournalLine."External Document No." := ATMApplications."No.";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'Excise Duty';
            GenJournalLine.Amount := TotalDuty;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Bal. Account No." := GenSetup."Excise Duty GL";
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := ATMApplications."Shortcut Dimension 1 Code";
            GenJournalLine."Shortcut Dimension 2 Code" := ATMApplications."Shortcut Dimension 2 Code";
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //MESSAGE('Acc %1\ Amount %2\ Bal, Acc %3',GenJournalLine."Account No.",GenJournalLine.Amount,GenJournalLine."Bal. Account No.");


            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := JTemp;
            GenJournalLine."Journal Batch Name" := JBatch;
            GenJournalLine."Document No." := ATMApplications."No.";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
            GenJournalLine."Account No." := ChargeAcct;
            GenJournalLine."External Document No." := ATMApplications."No.";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'ATM Application Charges';
            GenJournalLine.Amount := (ChargeAmt) * -1;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := ATMApplications."Shortcut Dimension 1 Code";
            GenJournalLine."Shortcut Dimension 2 Code" := ATMApplications."Shortcut Dimension 2 Code";
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //MESSAGE('Acc %1\ Amount %2\ Bal, Acc %3',GenJournalLine."Account No.",GenJournalLine.Amount,GenJournalLine."Bal. Account No.");

            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := JTemp;
            GenJournalLine."Journal Batch Name" := JBatch;
            GenJournalLine."Document No." := ATMApplications."No.";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := SharingChargeAcctType;
            GenJournalLine."Account No." := SharingChargeAcct;
            GenJournalLine."External Document No." := ATMApplications."No.";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'ATM Application Charge';
            GenJournalLine.Amount := (SharingAmt + SharingDuty) * -1;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := ATMApplications."Shortcut Dimension 1 Code";
            GenJournalLine."Shortcut Dimension 2 Code" := ATMApplications."Shortcut Dimension 2 Code";
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //MESSAGE('Acc %1\ Amount %2\ Bal, Acc %3',GenJournalLine."Account No.",GenJournalLine.Amount,GenJournalLine."Bal. Account No.");
            SMScharges.reset;
            SMScharges.setrange(source, SMScharges.source::"ATM Collection");
            if SMScharges.findfirst then begin

                TotalSms := SMSCharges."Charge Amount";
                SmsExcise := Round(SaccoSetup."Excise Duty (%)" * TotalSms * 0.01, 0.1, '<');
                TotalSms += SmsExcise;
                SaccoSetup.Get();
                SaccoActivities.JournalInsert(
                   JTemp,
                   JBatch,
                   ATMApplications."No.",
                   Today,
                   Accttype::Savings,
                   ATMApplications."Account No",
                   CopyStr('Sms Charge', 1, 50),
                   Balaccttype::"G/L Account",
                   '',
                   TotalSms,
                   '',
                   '',
                   Transtype::" ",
                   ATMApplications."Shortcut Dimension 1 Code",
                   ATMApplications."Shortcut Dimension 2 Code",
                   true,
                   TChannel::"Bankers Cheque Withdrawal",
                   0
                );

                SaccoActivities.JournalInsert(
                    JTemp,
                    JBatch,
                    ATMApplications."No.",
                    Today,
                    Accttype::"G/L Account",
                    SMSCHarges."Charge G/L Account",
                    CopyStr('Sms Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    TotalSms - SmsExcise,
                   '',
                    '',
                    Transtype::" ",
                   ATMApplications."Shortcut Dimension 1 Code",
                    ATMApplications."Shortcut Dimension 2 Code",
                    true,
                    TChannel::"Bankers Cheque Withdrawal",
                    0
                    );

                SaccoActivities.JournalInsert(
                    JTemp,
                    JBatch,
                    ATMApplications."No.",
                    Today,
                    Accttype::"G/L Account",
                    SaccoSetup."Excise Duty GL",
                    CopyStr('Excise Duty on Sms Charge', 1, 50),
                    Balaccttype::"G/L Account",
                    '',
                    -SmsExcise,
                    '',
                    '',
                    Transtype::" ",
                    ATMApplications."Shortcut Dimension 1 Code",
                    ATMApplications."Shortcut Dimension 2 Code",
                    true,
                    TChannel::"Bankers Cheque Withdrawal",
                   0
                );

            end;


            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JTemp);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.Find('-') then begin

                //send sms
                if SavingsAcc.Get(ATMApplications."Account No") then begin
                    MemberActivities.SendSms(Sourcetype::"ATM Collection", SavingsAcc."Mobile Phone No.", Txt004, ATMApplications."No.", SavingsAccounts."No.", true, false);
                end;

                ATMApplications."ATM Charges Applied" := true;
                ATMApplications."ATM Charged Date" := Today;
                ATMApplications.Modify;
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

                CashierTransactions.Reset;
                CashierTransactions.SetRange(CashierTransactions."Account No.", ATMApplications."Account No");
                CashierTransactions.SetRange(Remarks, 'ATM Application Charges');
                if CashierTransactions.Find('-') then begin
                    repeat
                        //ERROR('here');
                        CashierTransactions."Cheque Status" := CashierTransactions."cheque status"::Honoured;
                        CashierTransactions.Modify;
                    until CashierTransactions.Next = 0;

                    Message(MSGPosted);
                end;
            end;
            //Post New



        end;

    end;

    procedure PostMBankingApplicationCharges(MBankinApplications: Record "MBanking Applications") //ez
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        SavingsAccounts: Record "Savings Accounts";
        TChargeAmount: Decimal;
        TCharges: Decimal;
        ChargeAmount: Decimal;
        GenSetup: Record "Sacco Setup";
        JTemp: Code[20];
        JBatch: Code[20];
        MSGPosted: label 'Posted Successfuly';
        ATMCharge: label 'Atm Card Charges';
        ATMCardTypes: Record "ATM Card Types";
        MemberActivities: Codeunit "Member Activities";
        SavingsAcc: Record "Savings Accounts";
        Txt004: label 'Your MBanking application request has been processed.';
        CashierTransactions: Record "Teller Transaction";
        SharingAmount: Decimal;
        SharingDuty: Decimal;
        TotalCharge: Decimal;
        TotalDuty: Decimal;
        SaccoActivities: Codeunit "Sacco Activities";
        Sourcetype: Enum "SMS Source Enum";
        UserSet: Record "User Setup";
        SaccoSetup: Record "Sacco Setup";
    begin
        //if ATMApplications."No." <> 'ATM_0001' then
        //  if ATMApplications."ATM Charges Applied" = true then
        //    exit;

        UserSet.Get(UserId);
        SaccoSetup.Get();
        SaccoSetup.testfield("MBanking Application Charge");
        SaccoActivities.GetGeneralJournalTemplate(JTemp, JBatch);


        GenJournalLine.Reset;
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemp);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        GenSetup.Get;
        ChargeAmount := 0;


        ChargeAmount := 0;
        TChargeAmount := 0;


        ChargeAmt := 0;
        ChargeDuty := 0;
        ChargeAcctType := Chargeaccttype::"G/L Account";
        ChargeAcct := '';
        SharingAmt := 0;
        SharingChargeAcct := '';
        SharingChargeAcctType := Sharingchargeaccttype::"G/L Account";
        SharingDuty := 0;
        //if ATMApplications."Request Type" = ATMApplications."request type"::New then
        //   MemberActivities.GetGeneralChargeAmount(ATMCardTypes."Application Charge Code", 0, ChargeAmount, ChargeDuty, ChargeAcctType, ChargeAcct);
        //if ATMApplications."Request Type" = ATMApplications."request type"::Replacement then
        MemberActivities.GetGeneralChargeAmount(SaccoSetup."MBanking Application Charge", 0, ChargeAmount, ChargeDuty, ChargeAcctType, ChargeAcct);



        TotalCharge := ChargeAmount;
        TotalDuty := ChargeDuty;// + SharingDuty;
        SharingAmount := 0;


        TChargeAmount := TotalCharge + TotalDuty;


        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := JTemp;
        GenJournalLine."Journal Batch Name" := JBatch;
        GenJournalLine."Document No." := MBankinApplications.No;

        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
        GenJournalLine."Account No." := MBankinApplications."Account No";
        GenJournalLine."External Document No." := MBankinApplications.No;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'MBanking Application Charge';
        GenJournalLine.Amount := TotalCharge;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No." := '';
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := UserSet."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code" := UserSet."Global Dimension 2 Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;




        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := JTemp;
        GenJournalLine."Journal Batch Name" := JBatch;
        GenJournalLine."Document No." := MBankinApplications.No;

        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
        GenJournalLine."Account No." := MBankinApplications."Account No";
        GenJournalLine."External Document No." := MBankinApplications.No;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'Excise Duty on MBanking Application Charge';
        GenJournalLine.Amount := TotalDuty;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No." := GenSetup."Excise Duty GL";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := UserSet."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code" := UserSet."Global Dimension 2 Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        //MESSAGE('Acc %1\ Amount %2\ Bal, Acc %3',GenJournalLine."Account No.",GenJournalLine.Amount,GenJournalLine."Bal. Account No.");


        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := JTemp;
        GenJournalLine."Journal Batch Name" := JBatch;
        GenJournalLine."Document No." := MBankinApplications.No;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
        GenJournalLine."Account No." := ChargeAcct;
        GenJournalLine."External Document No." := MBankinApplications.No;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'MBanking Application Charges';
        GenJournalLine.Amount := (ChargeAmount) * -1;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := UserSet."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code" := UserSet."Global Dimension 2 Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        //MESSAGE('Acc %1\ Amount %2\ Bal, Acc %3',GenJournalLine."Account No.",GenJournalLine.Amount,GenJournalLine."Bal. Account No.");

        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := JTemp;
        GenJournalLine."Journal Batch Name" := JBatch;
        GenJournalLine."Document No." := MBankinApplications.No;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := SharingChargeAcctType;
        GenJournalLine."Account No." := SharingChargeAcct;
        GenJournalLine."External Document No." := MBankinApplications.No;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'MBanking Application Charge';
        GenJournalLine.Amount := (SharingAmount + SharingDuty) * -1;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := UserSet."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code" := UserSet."Global Dimension 2 Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        //MESSAGE('Acc %1\ Amount %2\ Bal, Acc %3',GenJournalLine."Account No.",GenJournalLine.Amount,GenJournalLine."Bal. Account No.");






        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", JTemp);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.Find('-') then begin

            //send sms
            if SavingsAcc.Get(MBankinApplications."Account No") then begin
                MemberActivities.SendSms(Sourcetype::MBanking, SavingsAcc."Mobile Phone No.", Txt004, MBankinApplications.No, SavingsAccounts."No.", true, false);
            end;

            //MBankinApplications.Changed := MBankinApplications.Charged::Yes;
            //MBankinApplications."Date Changed" := Today;
            //MBankinApplications."Time Changed" := Time;

            //MBankinApplications.Modify;
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

            /* CashierTransactions.Reset;
            CashierTransactions.SetRange(CashierTransactions."Account No.", MBankinApplications."Account No");
            CashierTransactions.SetRange(Remarks, 'MBanking Application Charges');
            if CashierTransactions.Find('-') then begin
                repeat
                    //ERROR('here');
                    CashierTransactions."Cheque Status" := CashierTransactions."cheque status"::Honoured;
                    CashierTransactions.Modify;
                until CashierTransactions.Next = 0;

                Message(MSGPosted);
            end; */
        end;
        //Post New



    end;




    procedure InsertTellerLines(CashierTrans: Record "Teller Transaction"; var Runbal: Decimal)
    var
        TLine: Record "Teller Lines";
        ProdSetup: Record "Product Setup";
        Savings: Record "Savings Accounts";
        FosaAccount: Record "Savings Accounts";
        DateFilter: text[30];
        DedAmt: Decimal;
        i: integer;
        Paid: boolean;
        ExpAmt: Decimal;
        AmtPaid: Decimal;
        AvailAmt: Decimal;
        j: integer;
        InterestArrears: Decimal;
        PrincipalArrears: Decimal;
        PrincipalArrearsCurMonth: Decimal;
        PrincipleDue: Decimal;
        PrincipleDuePerSchedule: Decimal;
        InterestDue: Decimal;
        PenaltyDue: Decimal;
        MonthlyBalance: Decimal;
        DefAmt: Decimal;
        DimSetID: Integer;
        ExpectedBal: Decimal;
        CurrentBal: Decimal;
        CurrMonthRepayment: Decimal;
        DaysInArrear: integer;
        ArrearsDate: Date;
        LSchedule: Record "Loan Repayment Schedule";
        Members: Record Members;
        Narration: text;
        OpenBal: Decimal;
        MinimumContrib: Decimal;
        Instructions: Record "Dividend Instructions";
        TellerLine: Record "Teller Lines";
    begin

        TLine.Reset();
        TLine.SetRange("Transaction No.", CashierTrans."Transaction No.");
        if TLine.FindFirst() then
            TLine.DeleteAll();

        Loans.Reset();
        Loans.setcurrentkey("Recovery Priority");
        Loans.SetRange("Member No.", CashierTrans."Member No.");
        Loans.SetRange("Mobile Loan", false);
        Loans.SetFilter("Total Outstanding Balance", '>0');
        Loans.SetAutoCalcFields("Outstanding Penalty", "Outstanding Interest", "Outstanding Principal");
        if Loans.FindFirst() then begin
            repeat
                DedAmt := 0;
                PenaltyDue := 0;
                InterestDue := 0;
                PrincipleDue := 0;
                DedAmt := 0;
                CurrMonthRepayment := 0;

                if Loans."Outstanding Penalty" < 0 then
                    Loans."Outstanding Penalty" := 0;
                PenaltyDue := Loans."Outstanding Penalty";

                if PenaltyDue > Runbal then
                    PenaltyDue := Runbal;

                DedAmt += PenaltyDue;
                RunBal -= PenaltyDue;

                if Runbal <= 0 then
                    Runbal := 0;

                if Loans."Outstanding Interest" < 0 then
                    Loans."Outstanding Interest" := 0;

                InterestDue := Loans."Outstanding Interest";

                if InterestDue > Runbal then
                    InterestDue := Runbal;

                DedAmt += InterestDue;
                RunBal -= InterestDue;

                if Runbal <= 0 then
                    Runbal := 0;

                if Loans."Outstanding Principal" > 0 then begin
                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised then begin
                        Loans.CalcFields(Loans."Outstanding Interest");
                        if Loans."Outstanding Interest" < 0 then
                            Loans."Outstanding Interest" := 0;

                        DedAmt := Loans.Repayment - Loans."Outstanding Interest";

                        LSchedule.reset;
                        LSchedule.SetRange("Loan No.", Loans."Loan No.");
                        LSchedule.SetFilter("Repayment Date", '..%1', CalcDate('CM', CashierTrans."Transaction Date"));
                        if LSchedule.FindLast() then begin
                            if DedAmt < LSchedule."Monthly Principal" then
                                DedAmt := LSchedule."Monthly Principal";
                        end;
                    end
                    else
                        DedAmt := Loans."Loan Principle Repayment";

                    /*LSchedule.reset;
                    LSchedule.SetRange("Loan No.", Loans."Loan No.");
                    LSchedule.SetFilter("Repayment Date", '..%1', CalcDate('CM', "Transaction Date"));
                    if LSchedule.FindLast() then begin
                        CurrMonthRepayment := (Loans."Outstanding Principal") - LSchedule."Loan Balance";
                        if CurrMonthRepayment < 0 then
                            CurrMonthRepayment := 0;
                    end;*/

                    if DedAmt > CurrMonthRepayment then
                        DedAmt := CurrMonthRepayment;

                end
                else
                    DedAmt := 0;

                PrincipleDue := DedAmt;

                if PrincipleDue > Runbal then
                    PrincipleDue := Runbal;

                RunBal -= PrincipleDue;

                if Runbal <= 0 then
                    Runbal := 0;

                TLine.Init();
                TLine."Transaction No." := CashierTrans."Transaction No.";
                TLine.Type := TLine.Type::Credit;
                TLine.Validate("Member No.", CashierTrans."Member No.");
                TLine.validate("Account No.", Loans."Loan Account");
                TLine.validate("Loan No.", Loans."Loan No.");
                TLine."Principal Due" := PrincipleDue;
                TLine."Interest Due" := InterestDue;
                TLine.Validate("Product Type", Loans."Loan Product Type");
                TLine.Validate("Outstanding Principal", Loans."Outstanding Principal");
                TLine.Validate("Outstanding Interest", Loans."Outstanding Interest");
                TLine.Validate(Amount, TLine."Principal Due" + TLine."Interest Due");
                TLine."Interest Calculation Method" := format(Loans."Interest Calculation Method");
                TLine.Insert();

            until Loans.Next() = 0;
        end; //End loans

        ProdSetup.Reset();
        ProdSetup.setcurrentkey("Recovery Priority");
        ProdSetup.SetRange("Product Class", ProdSetup."Product Class"::Savings);
        ProdSetup.SetRange(Status, ProdSetup.Status::Active);
        if ProdSetup.FindFirst() then begin
            repeat
                DedAmt := 0;
                if ProdSetup."Mandatory Contribution" > 0 then
                    DedAmt := ProdSetup."Mandatory Contribution";

                Savings.Reset();
                Savings.SetRange("Member No.", CashierTrans."Member No.");
                Savings.SetRange("Product Type", ProdSetup."Product ID");
                Savings.SetFilter("Product Category", '<>%1', Savings."Product Category"::" ");
                if Savings.FindFirst() then begin
                    repeat
                        DimSetID := CashierTrans."Dimension Set ID";
                        if DimSetID = 0 then
                            DimSetID := Savings."Dimension Set ID";

                        if RunBal > 0 then begin

                            if Savings."Monthly Contribution" > DedAmt then
                                DedAmt := Savings."Monthly Contribution";

                            if DedAmt > 0 then begin
                                //00115385
                                OpenBal := 0;
                                if SaccoSetup."Go Live Date" >= calcdate('-CM', CashierTrans."Transaction Date") then begin

                                    if SaccoSetup."Go Live Date" <= calcdate('CM', CashierTrans."Transaction Date") then begin

                                        FosaAccount.Reset();
                                        FosaAccount.SetRange("No.", Savings."No.");
                                        FosaAccount.Setfilter("Date Filter", '%1', SaccoSetup."Go Live Date");
                                        if FosaAccount.FindFirst() then begin
                                            FosaAccount.CalcFields("Balance (LCY)");
                                            OpenBal := FosaAccount."Balance (LCY)";
                                        end;
                                    end
                                end;

                                FosaAccount.Reset();
                                FosaAccount.SetRange("No.", Savings."No.");
                                FosaAccount.SetRange("Date Filter", calcdate('-CM', CashierTrans."Transaction Date"), CalcDate('CM', CashierTrans."Transaction Date"));
                                if FosaAccount.FindFirst() then begin
                                    FosaAccount.CalcFields("Balance (LCY)");
                                    MonthlyBalance := FosaAccount."Balance (LCY)" - OpenBal;

                                    DedAmt := DedAmt - MonthlyBalance;
                                    if DedAmt < 0 then
                                        DedAmt := 0;
                                end;

                                if ProdSetup."Maximum Balance" > 0 then begin


                                    FosaAccount.Reset();
                                    FosaAccount.SetRange("No.", Savings."No.");
                                    if FosaAccount.FindFirst() then begin
                                        FosaAccount.CalcFields("Balance (LCY)");
                                        if DedAmt + FosaAccount."Balance (LCY)" > ProdSetup."Maximum Balance" then begin
                                            DedAmt := ProdSetup."Maximum Balance" - FosaAccount."Balance (LCY)";

                                        end;

                                        if DedAmt < 0 then
                                            DedAmt := 0;
                                    end;
                                end;

                                if Savings."Product Category" = Savings."Product Category"::"Registration Fee" then begin
                                    ProdSetup.TestField("Registration Start Date");
                                    if Members."Registration Date" = 0D then
                                        DedAmt := 0
                                    else begin

                                        if Members."Registration Date" <= ProdSetup."Registration Start Date" then begin
                                            FosaAccount.Reset();
                                            FosaAccount.SetRange("No.", Savings."No.");
                                            if FosaAccount.FindFirst() then begin
                                                FosaAccount.CalcFields("Balance (LCY)");
                                                // if FosaAccount."Balance (LCY)" > 0 then
                                                DedAmt := 0;
                                            end;
                                        end;
                                    end;

                                end;




                            end;


                            if DedAmt > RunBal then
                                DedAmt := RunBal;

                            if DedAmt > 0 then begin
                                //insert here
                                TLine.Init();
                                TLine.Type := TLine.Type::Savings;
                                TLine."Transaction No." := CashierTrans."Transaction No.";
                                TLine.Validate("Member No.", CashierTrans."Member No.");
                                TLine."Global Dimension 1 Code" := 'FOSA';
                                TLine.validate("Account No.", Savings."No.");
                                Tline.validate("Product Type", Savings."Product Type");
                                TLine.Validate(Amount, DedAmt);
                                TLine.Insert();

                                Runbal -= DedAmt;
                            end;

                        end;
                    until Savings.Next = 0;
                end;

            until ProdSetup.next = 0;
        end;


        if RunBal > 0 then begin

            //Recover Member Instructions
            Instructions.Reset();
            Instructions.SetCurrentKey(Priority);
            Instructions.SetRange("Process Type", Instructions."Process Type"::"Excess-Receipt");
            Instructions.SetRange("Member No.", CashierTrans."Member No.");
            Instructions.SetFilter("Loan No.", '<>%1', '');
            if (Instructions.FindFirst()) then begin

                repeat

                    Narration := 'Member Instruction';
                    Loans.Reset();
                    Loans.SetRange(Loans."Loan No.", Instructions."Loan No.");
                    if Loans.FindFirst() then begin
                        AvailAmt := Instructions.Amount;
                        If AvailAmt = 0 then
                            AvailAmt := RunBal;

                        if AvailAmt > RunBal then
                            AvailAmt := RunBal;

                        Loans.CalcFields("Outstanding Principal", "Outstanding Penalty", "Outstanding Interest");

                        // Loans."Outstanding Penalty" -= GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Penalty Paid");
                        // Loans."Outstanding Interest" -= GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"INterest Paid");
                        //Loans."Outstanding Principal" -= GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Principal Repayment");



                    end;

                until Instructions.Next() = 0;
            end;



            if RunBal > 0 then begin

                Instructions.Reset();
                Instructions.SetCurrentKey(Priority);
                Instructions.SetRange("Process Type", Instructions."Process Type"::"Excess-Receipt");
                Instructions.SetRange("Member No.", CashierTrans."Member No.");
                Instructions.SetFilter("Loan No.", '=%1', '');
                Instructions.SetFilter("Account No.", '<>%1', '');
                //Instructions.SetFilter(Amount, '>0');
                if (Instructions.FindFirst()) then begin

                    repeat

                        if RunBal > 0 then begin


                            Savings.Reset();
                            Savings.SetRange("No.", Instructions."Account No.");
                            if Savings.FindFirst() then begin

                                AvailAmt := Instructions.Amount;
                                If AvailAmt = 0 then
                                    AvailAmt := RunBal;

                                if AvailAmt > RunBal then
                                    AvailAmt := RunBal;

                                DedAmt := AvailAmt;
                                if DedAmt > 0 then begin

                                    //Insert Here
                                end;
                            end;

                        end;
                    until Instructions.Next() = 0;
                end;
            end;
        end;

        if runBal > 0 then begin
            //Narration := 'Additional: ' + Desc;
            TLine.Reset();
            if TLine.FindFirst() then
                i := TLine."Entry No.";

            Savings.Reset();
            Savings.SetRange("Member No.", CashierTrans."Member No.");
            Savings.SetRange(Savings."Product Category", Savings."Product Category"::"Deposit Contribution");
            if (Savings.FindFirst()) then begin
                //Insert here
                TLine.Init();
                TLine.Type := TLine.Type::Savings;
                TLine."Transaction No." := CashierTrans."Transaction No.";
                TLine.Validate("Member No.", CashierTrans."Member No.");
                TLine."Global Dimension 1 Code" := 'FOSA';
                TLine.validate("Account No.", Savings."No.");
                Tline.validate("Product Type", Savings."Product Type");
                TLine.Validate(Amount, Runbal);
                TLine.Insert();
            end;
        end;
        //error('TEST');

    end;

}
