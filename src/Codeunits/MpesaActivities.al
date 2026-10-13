codeunit 50003 "Mpesa Activities"
{
    trigger OnRun()
    begin


    end;

    var

        SendSMS: Codeunit "Sky MBanking";
        SMSSource: enum "SMS Source Enum";
        Sky: codeunit "Sky M-Banking Transactions";
        MActivities: Codeunit "Member Activities";
        TChannel: Enum "Transaction Channel";
        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
        ExciseDutyGL: Code[20];
        ExciseDutyRate: Decimal;
        ExciseDuty: Decimal;
        PSetup: Record "Product Setup";
        Title: Label 'title';
        Message: Label 'message';
        Status: Label 'status';
        Data: Label 'data';
        Response: Text;
        ResponseStatus: Text;
        JsonHeader: JsonArray;
        ResponseTitle: Text;
        ResponseMessage: Text;

    // ################################################################################################
    // MAIN FUNCTIONS
    // ################################################################################################
    procedure ProcessRequest(Request: Text) Response: Text;
    var
        RequestJson: JsonObject;
        OutputJson: JsonObject;
        RequestDataJson: JsonObject;
        RequestAction: Text;
        SessionId: Text;
        SessionValid: Boolean;
        Id: Text;
    begin

        if not RequestJson.ReadFrom(Request) then
            Error('Invalid Json Input');

        //SessionId := SelectJsonToken(RequestJson, '$.request.session_id').AsValue.AsText;
        //Id := SelectJsonToken(RequestJson, '$.request.session_id').AsValue.AsText;
        RequestAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;
        RequestDataJson := SelectJsonToken(RequestJson, '$.payload').AsObject();
        ValidateRequestHash(RequestJson);
        SessionValid := true;

        /*if not (RequestAction in ['member-login']) then begin
            SessionValid := ValidateUserSession(RequestJson);
        end;*/

        if SessionValid then begin
            case RequestAction of
                'get-member-accounts':
                    begin
                        OutputJson := GetMemberAccounts(RequestDataJson);
                    end;
                'paybill-transaction':
                    begin
                        OutputJson := PaybillTransaction(RequestDataJson);
                    end;
            end;
        end
        else begin
            SetResponseStatus(OutputJson, 'error', '401 Unauthorized', 'Your request could not be processed');
        end;

        Response := WrapResponse(RequestJson, OutputJson);
    end;


    // ################################################################################################
    // REQUEST PROCESSING PROCEDURES 
    // ################################################################################################


    //MEMBER ACCOUNTS
    local procedure GetMemberAccounts(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        JsonProfile: JsonObject;
        MemberNo: Text;
        MobileNo: Text;
        Members: Record Customer;
        Accounts: Record Vendor;
        SavAccounts: Record Vendor;
        Loans: Record Loans;
        Legacy: Codeunit Legacy;
        JsonMember: JsonObject;
        JsonMemberArray: JsonArray;
        SActivity: Codeunit "Sacco Activities";
        PortalChangeRequest: Record "Portal Change Request";
        PeriodicActivities: Codeunit "Member Activities";
        PortalUploads: Record "Portal Uploads";
        //PortalChats: Record "Portal Chats";
        JsonFile: JsonObject;
        JsonFileArray: JsonArray;
        NextofKin: Record "Next of Kin.";
        JsonAccount: JsonObject;
        JsonAccountArray: JsonArray;
        Nominee: Record Nominee;
    begin
        MemberNo := SelectJsonToken(RequestJson, '$.member_no').AsValue.AsText;
        MobileNo := SelectJsonToken(RequestJson, '$.mobile_no').AsValue.AsText;

        if MemberNo <> '' then begin
            Accounts.Reset();
            Accounts.SetRange("Member No.", MemberNo);
            Accounts.SetRange("Transactional Mobile No", MobileNo);
            if Accounts.FindFirst() then begin

                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                Clear(JsonAccountArray);
                SavAccounts.Reset;
                SavAccounts.SetRange("Member No.", Accounts."Member No.");
                SavAccounts.Setfilter("Product Category", '%1|%2', SavAccounts."Product Category"::"Share Capital", SavAccounts."Product Category"::"Deposit Contribution");
                if SavAccounts.FindFirst then begin
                    repeat

                        Clear(JsonAccount);
                        JsonAccount.Add('account_no', SavAccounts."No.");
                        JsonAccount.Add('description', SavAccounts."Product Name");
                        JsonAccount.Add('book_balance', SActivity.GetAccountBalance(SavAccounts."No."));
                        JsonAccount.Add('available_balance', PeriodicActivities.GetAccountBalance(SavAccounts."No."));
                        JsonAccountArray.Add(JsonAccount);
                    until SavAccounts.Next = 0;
                end;
                DataJson.Add('bosa_accounts', JsonAccountArray);

                Clear(JsonAccountArray);
                SavAccounts.Reset;
                SavAccounts.SetRange("Member No.", Accounts."Member No.");
                SavAccounts.Setfilter("Product Category", '%1|%2', SavAccounts."Product Category"::"Ordinary Savings", SavAccounts."Product Category"::"Holiday Savings");
                if SavAccounts.FindFirst then begin
                    repeat

                        Clear(JsonAccount);
                        JsonAccount.Add('account_no', SavAccounts."No.");
                        JsonAccount.Add('description', SavAccounts."Product Name");
                        JsonAccount.Add('book_balance', SActivity.GetAccountBalance(SavAccounts."No."));
                        JsonAccount.Add('available_balance', PeriodicActivities.GetAccountBalance(SavAccounts."No."));
                        JsonAccountArray.Add(JsonAccount);
                    until SavAccounts.Next = 0;
                end;
                DataJson.Add('fosa_accounts', JsonAccountArray);


                Clear(JsonAccountArray);
                SavAccounts.Reset;
                SavAccounts.SetRange("Member No.", Accounts."Member No.");
                SavAccounts.Setfilter("Product Category", '%1', SavAccounts."Product Category"::"Ordinary Savings");
                if SavAccounts.FindFirst then begin
                    repeat

                        Clear(JsonAccount);
                        JsonAccount.Add('account_no', SavAccounts."No.");
                        JsonAccount.Add('description', SavAccounts."Product Name");
                        JsonAccount.Add('book_balance', SActivity.GetAccountBalance(SavAccounts."No."));
                        JsonAccount.Add('available_balance', PeriodicActivities.GetAccountBalance(SavAccounts."No."));
                        JsonAccountArray.Add(JsonAccount);
                    until SavAccounts.Next = 0;
                end;
                DataJson.Add('withdrawable_accounts', JsonAccountArray);


                Clear(JsonAccountArray);
                SavAccounts.Reset;
                SavAccounts.SetRange("Member No.", Accounts."Member No.");
                SavAccounts.Setfilter("Product Category", '%1', SavAccounts."Product Category"::"Ordinary Savings");
                if SavAccounts.FindFirst then begin
                    repeat

                        Clear(JsonAccount);
                        JsonAccount.Add('account_no', SavAccounts."No.");
                        JsonAccount.Add('description', SavAccounts."Product Name");
                        JsonAccount.Add('book_balance', SActivity.GetAccountBalance(SavAccounts."No."));
                        JsonAccount.Add('available_balance', PeriodicActivities.GetAccountBalance(SavAccounts."No."));
                        JsonAccountArray.Add(JsonAccount);
                    until SavAccounts.Next = 0;
                end;
                DataJson.Add('source_accounts', JsonAccountArray);



                Clear(JsonAccountArray);
                SavAccounts.Reset;
                SavAccounts.SetRange("Member No.", Accounts."Member No.");
                SavAccounts.Setfilter("Product Category", '<>%1', SavAccounts."Product Category"::"Registration Fee");
                if SavAccounts.FindFirst then begin
                    repeat

                        Clear(JsonAccount);
                        JsonAccount.Add('account_no', SavAccounts."No.");
                        JsonAccount.Add('description', SavAccounts."Product Name");
                        JsonAccount.Add('book_balance', SActivity.GetAccountBalance(SavAccounts."No."));
                        JsonAccount.Add('available_balance', PeriodicActivities.GetAccountBalance(SavAccounts."No."));
                        JsonAccountArray.Add(JsonAccount);
                    until SavAccounts.Next = 0;
                end;
                DataJson.Add('destination_accounts', JsonAccountArray);




                Clear(JsonAccountArray);
                Loans.Reset;
                Loans.SetRange("Member No.", Accounts."Member No.");
                Loans.Setfilter("Total Outstanding Balance", '>0');
                if Loans.FindFirst then begin
                    repeat
                        Loans.CalcFields("Total Outstanding Balance");

                        Clear(JsonAccount);
                        JsonAccount.Add('account_no', Loans."Loan No.");
                        JsonAccount.Add('description', Loans."Loan Product Type Name");
                        JsonAccount.Add('out_balance', Loans."Total Outstanding Balance");
                        JsonAccount.Add('period', Loans.Installments);
                        JsonAccount.Add('rate', Loans."Annual Interest %");
                        JsonAccount.Add('out_balance', Loans.Repayment);
                        JsonAccountArray.Add(JsonAccount);
                    until Loans.Next = 0;
                end;
                DataJson.Add('loan_accounts', JsonAccountArray);

            end
            else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Member does not exist');

            ResponseJson.Add(Data, DataJson);
        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Invalid Identifier');
    end;








    procedure GetExciseRate() rate: Integer
    var
        GenSetup: Record "Sacco Setup";
    begin


        GenSetup.Get;
        GenSetup.TestField(GenSetup."Excise Duty (%)");
        rate := GenSetup."Excise Duty (%)";
    end;

    local procedure GetExciseDutyGL() account: Text[20]
    var
        GenSetup: Record "Sacco Setup";
    begin

        GenSetup.Reset;
        GenSetup.Get;
        if GenSetup."Excise Duty (%)" > 0 then
            GenSetup.TestField("Excise Duty GL");
        account := GenSetup."Excise Duty GL";
    end;



    local procedure PaybillTransaction(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        //--//--LocalJsonTextWriter: dotnet JsonTextWriter;

        SAC: Codeunit "Sacco Activities";
        Subject: Label 'OTP';
        Salutation: Text;
        Body: Text;
        Msg: Text;
        Source: Enum "SMS Source Enum";

        LocalStringWriter: Text;
        SkyMbanking: Codeunit "Sky MBanking";
        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        Indent: Boolean;
        "Action": Code[50];
        JsObject_1: JsonObject;
        JsObject_2: JsonObject;
        Members: Record Customer;
        mno: Text;
        idno: Text;
        email: Text;
        DenyAccess: Boolean;
        DataJson: JsonObject;
        //CommitteeMember: Record "Board Committee Members";
        MpesaTrans: Record "Sky M-Banking Transactions";
        UserName: Text;
        Password: Text;
        AccessKey: Text;
        transaction_type: Text;
        trans_id: Text;
        trans_time: Text;
        trans_amount: Decimal;
        business_short_code: Text;
        bill_ref_number: Text;
        invoice_number: Text;
        org_account_balance: Decimal;
        third_party_trans_id: Text;
        msisdn: Text;
        first_name: Text;
        middle_name: Text;
        last_name: Text;
        TransDate: DateTime;
    begin


        Indent := true;



        transaction_type := SelectJsonToken(RequestJson, '$.transaction_type').AsValue.AsText;
        trans_id := SelectJsonToken(RequestJson, '$.trans_id').AsValue.AsText;
        trans_time := SelectJsonToken(RequestJson, '$.trans_time').AsValue.AsText;
        trans_amount := SelectJsonToken(RequestJson, '$.trans_amount').AsValue.AsDecimal();
        business_short_code := SelectJsonToken(RequestJson, '$.business_short_code').AsValue.AsText;
        bill_ref_number := SelectJsonToken(RequestJson, '$.bill_ref_number').AsValue.AsText;
        invoice_number := SelectJsonToken(RequestJson, '$.invoice_number').AsValue.AsText;
        org_account_balance := SelectJsonToken(RequestJson, '$.org_account_balance').AsValue.AsDecimal();
        third_party_trans_id := SelectJsonToken(RequestJson, '$.third_party_trans_id').AsValue.AsText;
        msisdn := SelectJsonToken(RequestJson, '$.msisdn').AsValue.AsText;
        first_name := SelectJsonToken(RequestJson, '$.first_name').AsValue.AsText;
        middle_name := SelectJsonToken(RequestJson, '$.middle_name').AsValue.AsText;
        last_name := SelectJsonToken(RequestJson, '$.last_name').AsValue.AsText;

        evaluate(TransDate, trans_time);

        MpesaTrans.Reset();
        MpesaTrans.SetRange("Transaction ID", trans_id);
        if MpesaTrans.findfirst then begin
            SetResponseStatus(ResponseJson, 'success', 'Success', 'Transaction Already Exists');
            MpesaTrans.Modify;//Modify if a field other than Transaction ID Has changed.//Munyao
        end
        else begin

            MpesaTrans.Init;

            MpesaTrans."API Request ID" := trans_id;

            MpesaTrans."Originator ID" := trans_id;
            MpesaTrans."Transaction ID" := trans_id;
            MpesaTrans."PESA Type" := 'DEP';
            MpesaTrans.Action := 'DEP';
            MpesaTrans.Command := 'DEP';

            MpesaTrans."Sender Identifier Type" := 'Member';
            MpesaTrans."Sender Identifier" := bill_ref_number;
            MpesaTrans."Sender Account" := bill_ref_number;
            MpesaTrans."Sender Name" := first_name;
            MpesaTrans."Sender Reference" := trans_id;
            MpesaTrans."Sender Other Details" := first_name;

            MpesaTrans."Receiver Identifier Type" := 'Member';
            MpesaTrans."Receiver Identifier" := bill_ref_number;
            MpesaTrans."Receiver Account" := bill_ref_number;
            MpesaTrans."Receiver Name" := '';
            MpesaTrans."Receiver Reference" := trans_id;
            MpesaTrans."Receiver Other Details" := first_name;

            MpesaTrans."Beneficiary Identifier Type" := 'Member';
            MpesaTrans."Beneficiary Identifier" := bill_ref_number;
            MpesaTrans."Beneficiary Account" := bill_ref_number;
            MpesaTrans."Beneficiary Name" := '';
            MpesaTrans."Beneficiary Reference" := trans_id;
            MpesaTrans."Beneficiary Other Details" := first_name;

            MpesaTrans."Transaction Amount" := trans_amount;
            MpesaTrans."Transaction Description" := 'Paybill Received From ' + first_name;
            MpesaTrans."Transaction Source Reference" := trans_id;
            MpesaTrans."Request Application" := trans_id;
            MpesaTrans."Source Application" := trans_id;
            MpesaTrans."Transaction Status" := MpesaTrans."Transaction Status"::CONFIRMED;
            MpesaTrans.Posted := false;

            MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::"Mpesa Deposit";
            MpesaTrans."Transaction ID" := trans_id;
            MpesaTrans."Entry No." := trans_id;
            MpesaTrans."Transaction Date" := DT2Date(TransDate);
            MpesaTrans."Transaction Time" := DT2Time(TransDate);

            MpesaTrans."Paybill No." := business_short_code;
            MpesaTrans."Savings Account" := bill_ref_number;
            MpesaTrans."Paybill Balance" := org_account_balance;

            MpesaTrans.insert;
            commit;
            Commit();
            PostMpesaDepositsTransaction(bill_ref_number);

            SetResponseStatus(ResponseJson, 'success', 'Success', 'Transaction Received');
        end;

        ResponseJson.Add(Data, DataJson);

    end;




    procedure PostMpesaDepositsTransaction(DocumentNo: Code[20]) Response: Boolean
    var

        MAccNo: Code[20];
        Legacy: Codeunit Legacy;
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Share Capital","Deposit Contribution","Deposit Contribution Micro","Retirement Saving Fund","Registration Fee","Insurance Contribution","FOSA SHARES";
        "Key": Code[20];
        LNo: Code[20];
        MemberPhoneNo: Code[20];
        SaccoFee: Decimal;
        Members: Record Members;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        DepositAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        SkyTrans: Record "Sky M-Banking Transactions";
        TransAmt: Decimal;
        BUser: Record "User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Enum "SMS Source Enum";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[20];
        Dim2: Code[20];
        SystCreated: Boolean;
        RunBal: Decimal;
        AccBal: Decimal;
        Loans: Record Loans;
        RepayAmt: Decimal;
        PrAmt: Decimal;
        SafcomCharges: Record "Safcom Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        msg: Text;
        EmailSubject: Text;
        EmailBody: Text;
        PrePaymentGL: Code[20];
        NewLoanBal: Decimal;
        LoanType: Record "Product Setup";
        LT: Text;
        AccountToCharge: Code[20];
        IntRate: Decimal;
        MemberName: Text;
        Depositor: Text;
        GenSetup: Record "Sacco Setup";
        DepDesc: Text;
        MobileNo: Code[20];
        BLedger: Record "Bank Account Ledger Entry";
        SMSAccount: Text;
        SMSCharge: Decimal;
        SkyMobileSetup: Record "Sky Mobile Setup.";
        SacAcc: Code[20];
        BillAcc: Record "Savings Accounts";
        GenJournalBatch: Record "Gen. Journal Batch";
        SaccoTrans: Codeunit "Sacco Activities";
        wDEntry: Boolean;
        TAccount: Record "Savings Accounts";
        DimID: Integer;
        BankAccount: Code[20];
        InterestArrears: Decimal;
        Desc: Text[50];
        PrincipalArrears: Decimal;
        ExpectedBal: Decimal;
        CurrentBal: Decimal;
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: integer;
        ArrearsDate: Date;
        ArrearsAsAt: Date;
        DividendFee: Decimal;
        DivChargeAcc: Code[20];
        GracePeriod: DateFormula;
        MemberActivities: codeunit "Member Activities";
        Charges: Record "Transaction Charges Lines";
        Distribute: Boolean;
        Savings: Record "Savings Accounts";
        FosaAccount: Record "Savings Accounts";
        LSchedule: record "Loan Repayment Schedule";
        RegistrationFeeAccount: Code[20];
        ShareCapitalAccount: Code[20];
        DepositContributionAccount: Code[20];
        RegistrationFeeRequired: Decimal;
        RegistrationFeeAmount: Decimal;
        ExciseDutyAmount: Decimal;
        ShareCapitalRequired: Decimal;
        ShareCapitalAmount: Decimal;
        ExpBal: Decimal;
        DepositContributionAmount: Decimal;
        RemainingAllocationAmount: Decimal;
    begin

        Distribute := false;
        PrincipalArrears := 0;
        InterestArrears := 0;
        DividendFee := 0;
        PDate := 0D;
        Clear(SavAcc);

        Response := false;
        SkyTrans.Reset;
        if DocumentNo <> '' then
            SkyTrans.SetRange("Transaction ID", DocumentNo);
        SkyTrans.SetRange(Posted, false);
        SkyTrans.SetRange("Needs Change", false);
        SkyTrans.Setfilter("Transaction Type", '%1|%2', SkyTrans."transaction type"::"Loan Repayment", SkyTrans."transaction type"::"Mpesa Deposit");
        if SkyTrans.FindFirst then begin


            GenSetup.Get;
            if SkyTrans."Transaction Description" = '' then
                SkyTrans."Transaction Description" := Format(SkyTrans."Transaction Type");
            if SkyTrans."Transaction Description" = '[string]' then
                SkyTrans."Transaction Description" := Format(SkyTrans."Transaction Type");

            if Loans.get(SkyTrans."Savings Account") then begin
                SkyTrans."Savings Account" := legacy.GetUnallocatedAccount(Loans."Member No.");
                SkyTrans."Loan No." := Loans."Loan No.";
                SkyTrans."Loan Account" := Loans."Loan Account";
                SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Loan Repayment";
                SkyTrans.Modify();
            end;

            if StrLen(SkyTrans."Transaction ID") > 20 then begin
                SkyTrans."Needs Change" := true;
                SkyTrans.Posted := false;
                SkyTrans.Remarks := CopyStr(
                    StrSubstNo('Transaction ID %1 exceeds 20 characters and cannot be posted automatically.', SkyTrans."Transaction ID"),
                    1,
                    MaxStrLen(SkyTrans.Remarks));
                SkyTrans.Modify();
                RaiseMpesaNeedsChangeEvent(SkyTrans);
                exit;
            end;

            if StrLen(SkyTrans."Savings Account") > 20 then begin
                SkyTrans."Needs Change" := true;
                SkyTrans.Posted := false;
                SkyTrans.Remarks := CopyStr(
                    StrSubstNo('Savings Account %1 exceeds 20 characters and cannot be posted automatically.', SkyTrans."Savings Account"),
                    1,
                    MaxStrLen(SkyTrans.Remarks));
                SkyTrans.Modify();
                RaiseMpesaNeedsChangeEvent(SkyTrans);
                exit;
            end;

            DocNo := CopyStr(SkyTrans."Transaction ID", 1, 20);

            PDate := SkyTrans."Transaction Date";

            AccNo := CopyStr(SkyTrans."Savings Account", 1, 20);

            if Not SavAcc.Get(AccNo) then begin

                SavAcc.Reset();
                SavAcc.SetRange("ID No.", SkyTrans."Savings Account");
                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Unallocated Fund");
                if SavAcc.FindFirst() then begin
                    AccNo := SavAcc."No.";
                    SkyTrans."Savings Account" := AccNo;
                    Distribute := true;
                end
                else begin

                    SavAcc.Reset();
                    SavAcc.SetRange("Member No.", SkyTrans."Savings Account");
                    SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Unallocated Fund");
                    if SavAcc.FindFirst() then begin
                        AccNo := SavAcc."No.";
                        SkyTrans."Savings Account" := AccNo;
                        Distribute := true;
                    end
                    else begin

                        SavAcc.Reset();
                        SavAcc.SetRange("Old Member No.", SkyTrans."Savings Account");
                        SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Unallocated Fund");
                        if SavAcc.FindFirst() then begin
                            AccNo := SavAcc."No.";
                            SkyTrans."Savings Account" := AccNo;
                            Distribute := true;
                        end else begin

                            SavAcc.Reset();
                            SavAcc.SetRange("Old Account No.", SkyTrans."Savings Account");
                            if SavAcc.FindFirst() then begin
                                AccNo := SavAcc."No.";
                            end else
                                if not ResolveSavingsAccountByKeyword(SkyTrans, SavAcc, AccNo, Distribute) then begin
                                    SkyTrans."Needs Change" := true;
                                    SkyTrans.Posted := false;
                                    SkyTrans.Remarks := CopyStr(StrSubstNo('No keyword/product mapping found for account %1.', SkyTrans."Savings Account"), 1, MaxStrLen(SkyTrans.Remarks));
                                    SkyTrans.Modify();
                                    RaiseMpesaNeedsChangeEvent(SkyTrans);
                                    exit;
                                end;
                        end;
                    end;
                end;

            end;


            BLedger.Reset;
            BLedger.SetRange("Document No.", DocNo);
            if BLedger.FindFirst then begin
                SkyTrans."Needs Change" := false;
                SkyTrans.Posted := true;

                SkyTrans."Needs Change" := false;
                SkyTrans.Remarks := 'Already Posted';
                SkyTrans.Modify;
                exit;
            end;



            BLedger.Reset;
            BLedger.SetRange("Document No.", DocNo);
            if BLedger.FindFirst then begin
                SkyTrans."Needs Change" := false;
                SkyTrans.Posted := true;

                SkyTrans."Needs Change" := false;
                SkyTrans.Remarks := 'Already Posted';
                SkyTrans.Modify;
                exit;
            end;


            // Get Excise duty G/L
            ExciseDutyGL := GetExciseDutyGL();
            ExciseDutyRate := GetExciseRate();
            ExciseDuty := 0;

            SaccoAccount := '';
            SaccoFee := 0;
            VendorAccount := '';
            VendorCommission := 0;
            SafcomAcc := '';
            SafcomFee := 0;
            PrePaymentGL := '';
            SMSAccount := '';
            SMSCharge := 0;
            BankAccount := '';
            clear(SkyMobileSetup);


            SkyMobileSetup.Reset;
            SkyMobileSetup.SetRange("Transaction Type", SkyTrans."Transaction Type");
            if SkyMobileSetup.FindFirst then begin

                SMSAccount := SkyMobileSetup."SMS Account";
                SMSCharge := SkyMobileSetup."SMS Charge";
                PrePaymentGL := SkyMobileSetup."Pre-Payment Account";
                SafcomAcc := SkyMobileSetup."Safaricom Account";
                SaccoAccount := SkyMobileSetup."Sacco Fee Account";
                SaccoFee := SkyMobileSetup."Sacco Fee";


                VendorAccount := SkyMobileSetup."Vendor Commission Account";
                VendorCommission := SkyMobileSetup."Vendor Commission";


                SaccoFee := SkyMobileSetup."Sacco Fee";
                if SkyMobileSetup."Sacco Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Sacco Staggered Charge", SkyTrans."Transaction Amount", SaccoFee, ChargeDuty, ChargeAcctType, ChargeAcct);

                VendorCommission := SkyMobileSetup."Vendor Commission";
                if SkyMobileSetup."Vendor Staggered Fee" then begin
                    MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Vendor Staggered Charge", SkyTrans."Transaction Amount", VendorCommission, ChargeDuty, ChargeAcctType, ChargeAcct);
                    VendorCommission += (ChargeDuty);
                end;

                if SkyMobileSetup."Safcom Staggered Fee" then begin
                    MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Safcom Staggered Charge", SkyTrans."Transaction Amount", SafcomFee, ChargeDuty, ChargeAcctType, ChargeAcct);
                    SafcomFee += ChargeDuty;
                end;
                VendorCommission := 0;
                SafcomFee := 0;
                SaccoFee := 0;


                TotalCharge := SaccoFee + VendorCommission + SafcomFee + DividendFee + SMSCharge;
                ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
            end
            else begin
                if SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Pay Loan From Account" then
                    Error('Setup Missing for %1', SkyTrans."Transaction Type");
            end;


            //ERROR('SafcomFee %1\SaccoFee %2',SafcomFee,SaccoFee);

            if (SavAcc.Get(AccNo)) then begin

                MemberName := SavAcc."Name";
                TransAmt := SkyTrans."Transaction Amount";
                AccountToCharge := '';
                MobileNo := '';

                DimID := 0;
                Members.get(SavAcc."Member No.");

                if Members."Member Status" = Members."Member Status"::Deceased then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a deceased member.';
                    SkyTrans.Modify;
                    RaiseMpesaNeedsChangeEvent(SkyTrans);
                    exit;
                end;

                if Members."Member Status" = Members."Member Status"::Withdrawn then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a withdrawn account.';
                    SkyTrans.Modify;
                    RaiseMpesaNeedsChangeEvent(SkyTrans);
                    exit;
                end;

                if SavAcc.Status = SavAcc.Status::Deceased then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a deceased account.';
                    SkyTrans.Modify;
                    RaiseMpesaNeedsChangeEvent(SkyTrans);
                    exit;
                end;

                if SavAcc.Status = SavAcc.Status::Withdrawn then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a Withdrawn account.';
                    SkyTrans.Modify;
                    RaiseMpesaNeedsChangeEvent(SkyTrans);
                    exit;
                end;

                if SkyTrans."Loan No." <> '' then begin

                    if Members.Blocked = Members.Blocked::All then begin
                        //SkyTrans.Posted := true;

                        SkyTrans."Needs Change" := true;
                        SkyTrans.Remarks := 'You cannot transact on a blocked [All] account.';
                        SkyTrans.Modify;
                        RaiseMpesaNeedsChangeEvent(SkyTrans);
                        exit;
                    end;
                end;

                if SavAcc.Blocked = SavAcc.Blocked::All then begin
                    //SkyTrans.Posted := true;

                    SkyTrans."Needs Change" := true;
                    SkyTrans.Remarks := 'You cannot transact on a blocked [All] account.';
                    SkyTrans.Modify;
                    RaiseMpesaNeedsChangeEvent(SkyTrans);
                    exit;
                end;

                AccountToCharge := SavAcc."No.";
                BillAcc.Reset;
                BillAcc.SetRange("Member No.", SavAcc."Member No.");
                BillAcc.SETRANGE("Product Category", BillAcc."Product Category"::"Ordinary Savings");
                if BillAcc.FindFirst then begin
                    MobileNo := BillAcc."Transactional Mobile No";
                end;

                TransAmt := TransAmt * -1;


                if (SavAcc.Blocked = SavAcc.Blocked::All) then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Remarks := 'Account Blocked';
                    SkyTrans.Modify;
                    RaiseMpesaNeedsChangeEvent(SkyTrans);
                    exit;
                end;


                if not BUser.Get(UserId()) then
                    Error('No User Setup found for %1. Please configure User Setup.', UserId());

                BUser.TESTFIELD("CashRec Journal Batch");
                BUser.TESTFIELD("CashRec Journal Template");

                JTemplate := BUser."CashRec Journal Template";
                JBatch := BUser."CashRec Journal Batch";

                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                GenJournalBatch.SetRange(Name, JBatch);
                if not GenJournalBatch.FindFirst then begin
                    GenJournalBatch.Init;
                    GenJournalBatch."Journal Template Name" := JTemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.Description := 'MBanking Batch';
                    GenJournalBatch.Insert;
                end;

                LoanNo := '';
                TransType := Transtype::" ";
                Dim1 := SavAcc."Global Dimension 1 Code";
                Dim2 := SavAcc."Global Dimension 2 Code";
                if Members.Get(SavAcc."Member No.") then begin
                    if Dim2 = '' then
                        Dim2 := Members."Global Dimension 2 Code";
                    if Dim2 = '' then
                        Dim2 := BUser."Global Dimension 2 Code";
                end;

                DimID := SavAcc."Dimension Set ID";
                SkyMobileSetup.TestField("Bank Account");
                BankAccount := SkyMobileSetup."Bank Account";

                SystCreated := true;


                TChannel := TChannel::Paybill;

                SaccoTrans.JournalInit(JTemplate, JBatch);

                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", BankAccount, CopyStr(SavAcc."Member No." + ' ' + SavAcc.Name + ' ' + SkyTrans."Transaction Description", 1, 100), Balacctype::"G/L Account",
                      '', -1 * TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                if SavAcc."Product Category" = SavAcc."Product Category"::"Unallocated Fund" then
                    Desc := CopyStr(SkyTrans."Transaction Description", 1, MaxStrLen(Desc))
                else
                    Desc := CopyStr(Format(SavAcc."Product Category"), 1, MaxStrLen(Desc));

                if SavAcc."Product Category" = SavAcc."Product Category"::"Registration Fee" then begin
                    RemainingAllocationAmount := Abs(TransAmt);

                    PSetup.Reset();
                    PSetup.SetRange("Product Category", PSetup."Product Category"::"Registration Fee");
                    if not PSetup.FindFirst() then begin
                        SkyTrans."Needs Change" := true;
                        SkyTrans.Posted := false;
                        SkyTrans.Remarks := CopyStr('Registration Fee product setup is missing.', 1, MaxStrLen(SkyTrans.Remarks));
                        SkyTrans.Modify();
                        exit;
                    end;

                    RegistrationFeeAccount := Legacy.GetRegFeeAccount(SavAcc."Member No.");
                    if RegistrationFeeAccount = '' then
                        RegistrationFeeAccount := AccNo;

                    RegistrationFeeRequired := PSetup."Minimum Contribution" - MemberActivities.GetAccountBalance(RegistrationFeeAccount) - SaccoTrans.GetJournalCredits(JTemplate, JBatch, Accttype::Savings, RegistrationFeeAccount);
                    if RegistrationFeeRequired < 0 then
                        RegistrationFeeRequired := 0;

                    RegistrationFeeAmount := RegistrationFeeRequired;
                    if RegistrationFeeAmount > RemainingAllocationAmount then
                        RegistrationFeeAmount := RemainingAllocationAmount;

                    if RegistrationFeeAmount > 0 then begin
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, RegistrationFeeAccount, CopyStr('Registration Fee', 1, 100), Balacctype::"G/L Account",
                              '', -RegistrationFeeAmount, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);
                        RemainingAllocationAmount -= RegistrationFeeAmount;

                        if GenSetup."Excise Duty (%)" > 0 then begin
                            GenSetup.TestField("Excise Duty GL");
                            ExciseDutyAmount := Round(RegistrationFeeAmount * GenSetup."Excise Duty (%)" / 100, 0.01, '=');
                            if ExciseDutyAmount > RemainingAllocationAmount then
                                ExciseDutyAmount := RemainingAllocationAmount;

                            if ExciseDutyAmount > 0 then begin
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", GenSetup."Excise Duty GL", CopyStr('Excise Duty on Registration Fee ' + SavAcc.Name + SavAcc."Member No.", 1, 100), Balacctype::"G/L Account",
                                      '', -ExciseDutyAmount, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);
                                RemainingAllocationAmount -= ExciseDutyAmount;
                            end;
                        end;
                    end;

                    ShareCapitalRequired := GenSetup."Minimum Share Capital";
                    if ShareCapitalRequired = 0 then
                        ShareCapitalRequired := GenSetup."Maximum Share Capital Amount";

                    if (ShareCapitalRequired > 0) and (RemainingAllocationAmount > 0) then begin
                        ShareCapitalAccount := Legacy.GetShareCapitalAccount(SavAcc."Member No.");
                        if ShareCapitalAccount = '' then begin
                            SkyTrans."Needs Change" := true;
                            SkyTrans.Posted := false;
                            SkyTrans.Remarks := CopyStr('Share Capital account is missing.', 1, MaxStrLen(SkyTrans.Remarks));
                            SkyTrans.Modify();
                            exit;
                        end;

                        ShareCapitalAmount := ShareCapitalRequired - MemberActivities.GetAccountBalance(ShareCapitalAccount) - SaccoTrans.GetJournalCredits(JTemplate, JBatch, Accttype::Savings, ShareCapitalAccount);
                        if ShareCapitalAmount < 0 then
                            ShareCapitalAmount := 0;
                        if ShareCapitalAmount > RemainingAllocationAmount then
                            ShareCapitalAmount := RemainingAllocationAmount;

                        if ShareCapitalAmount > 0 then begin
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, ShareCapitalAccount, CopyStr('Share Capital', 1, 100), Balacctype::"G/L Account",
                                  '', -ShareCapitalAmount, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);
                            RemainingAllocationAmount -= ShareCapitalAmount;
                        end;
                    end;

                    if RemainingAllocationAmount > 0 then begin
                        DepositContributionAccount := Legacy.GetDepositAccounts(SavAcc."Member No.");
                        if DepositContributionAccount = '' then begin
                            SkyTrans."Needs Change" := true;
                            SkyTrans.Posted := false;
                            SkyTrans.Remarks := CopyStr('Deposit Contribution account is missing.', 1, MaxStrLen(SkyTrans.Remarks));
                            SkyTrans.Modify();
                            exit;
                        end;

                        DepositContributionAmount := RemainingAllocationAmount;
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, DepositContributionAccount, CopyStr('Deposit Contribution', 1, 100), Balacctype::"G/L Account",
                              '', -DepositContributionAmount, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);
                    end;
                end else
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                          '', (TransAmt), ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                if TotalCharge > 0 then begin
                    if /*( SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Mpesa Deposit") */
                       /* and (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Mpesa Deposit") */
                       /* and (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Loan Repayment") 
                      and*/ (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Bank Transfer") then begin

                        if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Mpesa Withdrawal") then
                            AccountToCharge := AccNo;

                        if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Bank Transfer") or (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"External Bank Transfer") then
                            AccountToCharge := CopyStr(SkyTrans."Sender Account", 1, 20);

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccountToCharge, CopyStr(SkyTrans."Transaction Description" + ' Charges', 1, 100), Balacctype::"G/L Account",
                                      '', VendorCommission + DividendFee + SaccoFee + SafcomFee + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AccountToCharge,COPYSTR('Corporate Charge',1,100),BalAccType::"Bank Account",
                        //            SafcomAcc,SafcomFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", DivChargeAcc, CopyStr('Advance Dividend Interest Charge', 1, 100), Balacctype::"G/L Account",
                                      '', -DividendFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", SafcomAcc, CopyStr('Corporate Charge', 1, 100), Balacctype::"Bank Account",
                                      '', -SafcomFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AccountToCharge,COPYSTR('Transaction Charge',1,100),BalAccType::"G/L Account",
                        //            SaccoAccount,SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SaccoAccount, CopyStr(SkyTrans."Transaction Description" + ' Charges', 1, 100), Balacctype::"G/L Account",
                                      '', -SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccountToCharge, CopyStr('SMS Charge - ', 1, 100), Balacctype::"G/L Account",
                                      SMSAccount, SMSCharge, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,Accttype::Savings,AccountToCharge,COPYSTR('Excise Duty ',1,100),BalAccType::"G/L Account",
                        //            ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty ', 1, 100), Balacctype::"G/L Account",
                                      '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                    end
                    else begin

                        //SkyMobileSetup.TestField("Non-Member Debit Account"); //ez
                        /*  DepDesc := 'C2B Mpesa Deposit';
                         if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Bank Deposit") then
                             DepDesc := 'C2B Bank Deposit';
                         if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Bank Agent Deposit") then
                             DepDesc := 'C2B Bank Agent Deposit'; */

                        /*  SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, SkyMobileSetup."Non-Member Debit Account", CopyStr(DepDesc, 1, 100), Balacctype::"G/L Account",
                               '', VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID); */

                        if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Bank Transfer") or (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"External Bank Transfer") then begin
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", SafcomAcc /*SkyMobileSetup."Non-Member Debit Account"*/, CopyStr('Corporate Charge', 1, 100), Balacctype::"Bank Account",
                                        SafcomAcc, SafcomFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                        end;

                    end;

                    /*SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr('Fee on ' + SkyTrans."Transaction Description", 1, 100), Balacctype::"G/L Account",
                                          '', VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID); */

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::vendor, VendorAccount, CopyStr('Fee on ' + SkyTrans."Transaction Description", 1, 100), Balacctype::"G/L Account",
                                  '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);


                end;

                if SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Mpesa Deposit" then begin
                    if Distribute then begin

                        AccBal := MActivities.GetAccountBalance(SavAcc."No.");
                        if AccBal > 0 then
                            AccBal := 0;
                        RunBal := AccBal + SkyTrans."Transaction Amount" - (TotalCharge + ExciseDuty);

                        SaccoTrans.GenerateMemberRepaymentJournals(JTemplate, JBatch, docNo, ExtDoc, pdate, SkyTrans."Transaction Description", pdate, RunBal, Members."No.", LoanNo, SavAcc."No.", BalAccType::Savings, 0, TChannel::Mobile, true);
                    end;
                end;

                if SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Loan Repayment" then begin

                    AccBal := MActivities.GetAccountBalance(SavAcc."No.");
                    if AccBal > 0 then
                        AccBal := 0;

                    RunBal := AccBal + SkyTrans."Transaction Amount" - (TotalCharge + ExciseDuty);

                    if RunBal > 0 then begin

                        if RunBal > SkyTrans."Transaction Amount" then
                            RunBal := SkyTrans."Transaction Amount";

                        //Arrears section
                        Loans.Reset;
                        Loans.SetRange("Loan No.", SkyTrans."Loan No.");
                        Loans.SetRange("Member No.", SavAcc."Member No.");
                        if Loans.FindFirst then begin
                            ExpBal := 0;
                            LoanType.Get(Loans."Loan Product Type");

                            Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty");
                            ArrearsAsAt := CalcDate('<-CM>', PDate) - 1;

                            RepayAmt := Loans."Outstanding Penalty" - SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Penalty Paid");

                            if RepayAmt > 0 then begin

                                Desc := LoanType."USSD Product Name" + ': Penalty Repayment';

                                if RepayAmt > RunBal then
                                    RepayAmt := RunBal;

                                AccNo := CopyStr(SkyTrans."Savings Account", 1, 20);
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                TransType := Transtype::" ";
                                SystCreated := true;

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                TransType := Transtype::"Penalty Paid";
                                AccNo := Loans."Loan Account";
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', -RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                                RunBal -= RepayAmt;

                            end;

                            RepayAmt := SaccoTrans.GetInsuranceArrears(Loans."Loan No.", ArrearsAsAt) - SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Insurance Paid");
                            if RepayAmt > Loans."Outstanding Insurance" then
                                RepayAmt := Loans."Outstanding Insurance";

                            if RepayAmt > 0 then begin

                                Desc := LoanType."USSD Product Name" + ': Insurance Repayment';

                                if RepayAmt > RunBal then
                                    RepayAmt := RunBal;

                                AccNo := CopyStr(SkyTrans."Savings Account", 1, 20);
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                TransType := Transtype::" ";
                                SystCreated := true;

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                TransType := Transtype::"Insurance Paid";
                                AccNo := Loans."Loan Account";
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', -RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                                RunBal -= RepayAmt;

                            end;

                            RepayAmt := SaccoTrans.GetInterestArrears(Loans."Loan No.", ArrearsAsAt) - SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Interest Paid");
                            if RepayAmt > Loans."Outstanding Interest" then
                                RepayAmt := Loans."Outstanding Interest";

                            if RepayAmt > 0 then begin

                                Desc := LoanType."USSD Product Name" + ': Interest Repayment';

                                if RepayAmt > RunBal then
                                    RepayAmt := RunBal;

                                AccNo := CopyStr(SkyTrans."Savings Account", 1, 20);
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                TransType := Transtype::" ";
                                SystCreated := true;

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                TransType := Transtype::"Interest Paid";
                                AccNo := Loans."Loan Account";
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', -RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                                RunBal -= RepayAmt;

                            end;

                            if Loans."Outstanding Principal" > 0 then begin

                                Desc := LoanType."USSD Product Name" + ': Principal Repayment';

                                SaccoTrans.GetDefaultedAmount(Loans."Loan No.", Today, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, GracePeriod);
                                PrAmt := DefAmount - SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Principal Repayment");
                                if PrAmt < 0 then
                                    PrAmt := 0;

                                if PrAmt > Loans."Outstanding Principal" then
                                    PrAmt := Loans."Outstanding Principal";

                                if PrAmt > RunBal then
                                    PrAmt := RunBal;

                                AccNo := SkyTrans."Savings Account";
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                SystCreated := true;

                                TransType := Transtype::" ";

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                TransType := Transtype::"Principal Repayment";

                                AccNo := Loans."Loan Account";
                                //message('PrAmt %1',PrAmt);
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', -PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                                RunBal -= PrAmt;

                            end;
                        end;

                        if RunBal > 0 then begin
                            Savings.Reset();
                            Savings.SetRange("Member No.", SavAcc."Member No.");
                            Savings.SetRange("Product Category", Savings."Product Category"::"Deposit Contribution");
                            if Savings.FindFirst() then begin

                                RepayAmt := Savings."Monthly Contribution"; //SaccoTrans.GetMonthlyDepositAmount(Savings."Member No.", LoanNo);

                                FosaAccount.Reset();
                                FosaAccount.SetRange("No.", Savings."No.");
                                FosaAccount.SetRange("Date Filter", CalcDate('-CM', PDate), CalcDate('CM', PDate));
                                FosaAccount.SetAutoCalcFields("Balance (LCY)");
                                FosaAccount.SetLoadFields("Balance (LCY)");
                                if FosaAccount.FindFirst() then begin
                                    if FosaAccount."Balance (LCY)" > 0 then
                                        RepayAmt := RepayAmt - FosaAccount."Balance (LCY)";
                                end;

                                AccNo := SavAcc."No.";

                                if RepayAmt < 0 then
                                    RepayAmt := 0;

                                if RepayAmt > RunBal then
                                    RepayAmt := RunBal;

                                RunBal -= RepayAmt;

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(Format(Savings."Product Category"), 1, 100), Balacctype::"G/L Account",
                                        '', RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, Savings."No.", CopyStr(Format(Savings."Product Category"), 1, 100), Balacctype::"G/L Account",
                                          '', -RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                            end;
                        end;

                        Loans.Reset;
                        Loans.SetRange("Loan No.", SkyTrans."Loan No.");
                        Loans.SetRange("Member No.", SavAcc."Member No.");
                        if Loans.FindFirst then begin
                            ExpBal := 0;
                            LoanType.Get(Loans."Loan Product Type");

                            Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty");

                            RepayAmt := Loans."Outstanding Penalty" - SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Penalty Paid");

                            if RepayAmt > 0 then begin

                                Desc := LoanType."USSD Product Name" + ': Penalty Repayment';

                                if RepayAmt > RunBal then
                                    RepayAmt := RunBal;

                                AccNo := CopyStr(SkyTrans."Savings Account", 1, 20);
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                TransType := Transtype::" ";
                                SystCreated := true;

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                TransType := Transtype::"Penalty Paid";
                                AccNo := Loans."Loan Account";
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', -RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                                RunBal -= RepayAmt;

                            end;

                            RepayAmt := Loans."Outstanding Insurance" - SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Insurance Paid");

                            if RepayAmt > 0 then begin

                                Desc := LoanType."USSD Product Name" + ': Insurance Repayment';

                                if RepayAmt > RunBal then
                                    RepayAmt := RunBal;

                                AccNo := CopyStr(SkyTrans."Savings Account", 1, 20);
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                TransType := Transtype::" ";
                                SystCreated := true;

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                TransType := Transtype::"Insurance Paid";
                                AccNo := Loans."Loan Account";
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', -RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                                RunBal -= RepayAmt;

                            end;

                            RepayAmt := Loans."Outstanding Interest" - SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Interest Paid");

                            if RepayAmt > 0 then begin

                                Desc := LoanType."USSD Product Name" + ': Interest Repayment';

                                if RepayAmt > RunBal then
                                    RepayAmt := RunBal;

                                AccNo := CopyStr(SkyTrans."Savings Account", 1, 20);
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                TransType := Transtype::" ";
                                SystCreated := true;

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                TransType := Transtype::"Interest Paid";
                                AccNo := Loans."Loan Account";
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', -RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                                RunBal -= RepayAmt;

                            end;

                            if Loans."Outstanding Principal" > 0 then begin

                                Desc := LoanType."USSD Product Name" + ': Loan Repayment';

                                LSchedule.Reset();
                                LSchedule.SetRange("Loan No.", Loans."Loan No.");
                                LSchedule.SetFilter("Repayment Date", '%1..%2', CalcDate('<-CM>', PDate), CalcDate('<CM>', PDate));
                                if LSchedule.FindFirst() then begin
                                    ExpBal := LSchedule."Loan Balance";
                                    PrAmt := Loans."Outstanding Principal" - ExpBal;
                                    if PrAmt < 0 then
                                        PrAmt := 0;
                                end else
                                    PrAmt := Loans."Loan Principle Repayment";

                                if PrAmt > Loans."Outstanding Principal" then
                                    PrAmt := Loans."Outstanding Principal";

                                if PrAmt > RunBal then
                                    PrAmt := RunBal;

                                AccNo := SkyTrans."Savings Account";
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                SystCreated := true;

                                TransType := Transtype::" ";

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                TransType := Transtype::"Principal Repayment";

                                AccNo := Loans."Loan Account";
                                //message('PrAmt %1',PrAmt);
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                              '', -PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                                RunBal -= PrAmt;

                            end;

                            if RunBal > 0 then begin

                                Loans.Reset;
                                Loans.SetRange("Loan No.", SkyTrans."Loan No.");
                                Loans.SetRange("Member No.", SavAcc."Member No.");
                                if Loans.FindFirst then begin

                                    Loans.CalcFields("Outstanding Principal");
                                    if Loans."Outstanding Principal" > 0 then begin

                                        Desc := LoanType."USSD Product Name" + ': Loan Repayment';

                                        PrAmt := Loans."Outstanding Principal" - SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Principal Repayment");

                                        if PrAmt > RunBal then
                                            PrAmt := RunBal;

                                        AccNo := SkyTrans."Savings Account";
                                        ExtDoc := '';
                                        LoanNo := Loans."Loan No.";
                                        SystCreated := true;

                                        TransType := Transtype::" ";

                                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                                      '', PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                        TransType := Transtype::"Principal Repayment";

                                        AccNo := Loans."Loan Account";
                                        //message('PrAmt %1',PrAmt);
                                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                                      '', -PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                                        RunBal -= PrAmt;

                                    end;
                                end;

                                if RunBal > 0 then begin
                                    AccNo := SkyTrans."Savings Account";
                                    SaccoTrans.GenerateMemberRepaymentJournals(JTemplate, JBatch, DocNo, ExtDoc, PDate, SkyTrans."Transaction Description", PDate, RunBal, SavAcc."Member No.", Loans."Loan No.", AccNo, BalAccType::Savings, DimID, TChannel, true);
                                end

                            end;
                        end;

                    end;
                end;


                SkyTrans.Posted := true;

                SkyTrans."Needs Change" := false;
                SkyTrans."Posted By" := UserId;
                SkyTrans."Posting Date" := Today;
                SkyTrans.Modify;
                Response := true;


                SaccoTrans.JournalPost(JTemplate, JBatch);

                if SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Loan Repayment" then begin
                    if Loans.Get(LoanNo) then begin
                        LT := Loans."Loan Product Type Name";
                        if LoanType.Get(Loans."Loan Product Type") then
                            LT := LoanType."Description";

                        msg := 'Dear ' + MemberActivities.FirstName(SavAcc.Name) +
                            ', we confirm receipt of KES ' + Format(SkyTrans."Transaction Amount") +
                            ' on ' + Format(Sky.ddMMyyyy(PDate)) +
                            '. Your Loan No. ' + Loans."Loan No." + ' (' + LT + ') has been updated. Thank you for your continued support. - ' + CompanyName;
                        EmailBody := 'We confirm receipt of KES ' + Format(SkyTrans."Transaction Amount") +
                            ' on ' + Format(Sky.ddMMyyyy(PDate)) +
                            '. Your Loan No. ' + Loans."Loan No." + ' (' + LT + ') has been updated. Thank you for your continued support. - ' + CompanyName;
                    end;
                end

                else begin
                    if SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Mpesa Deposit" then begin
                        Depositor := Sky.ExtractMobileNumber(SkyTrans."Transaction Description");//CopyStr(SkyTrans."Transaction Description", 24, StrLen(SkyTrans."Transaction Description"));

                        msg := 'Dear ' + MemberActivities.FirstName(SavAcc.Name) +
                            ', we confirm receipt of KES ' + Format(SkyTrans."Transaction Amount") +
                            ' on ' + Format(Sky.ddMMyyyy(PDate)) +
                            '. Your account has been updated. Thank you for your continued support. - ' + CompanyName;
                        EmailBody := 'We confirm receipt of KES ' + Format(SkyTrans."Transaction Amount") +
                            ' on ' + Format(Sky.ddMMyyyy(PDate)) +
                            '. Your account has been updated. Thank you for your continued support. - ' + CompanyName;
                    end
                    else begin
                        msg := 'Dear ' + MemberActivities.FirstName(SavAcc.Name) +
                            ', we confirm receipt of KES ' + Format(SkyTrans."Transaction Amount") +
                            ' on ' + Format(Sky.ddMMyyyy(PDate)) +
                            '. Your ' + Format(SkyTrans."Transaction Type") + ' has been updated. Thank you for your continued support. - ' + CompanyName;
                        EmailBody := 'We confirm receipt of KES ' + Format(SkyTrans."Transaction Amount") +
                            ' on ' + Format(Sky.ddMMyyyy(PDate)) +
                            '. Your ' + Format(SkyTrans."Transaction Type") + ' has been updated. Thank you for your continued support. - ' + CompanyName;
                    end;
                end;


                if MobileNo = '' then
                    MobileNo := SavAcc."Mobile Phone No.";
                if Members.Get(SavAcc."Member No.") then begin
                    EmailSubject := StrSubstNo('Mpesa Receipt Confirmation - %1', SkyTrans."Transaction ID");

                    if (MobileNo = '') and (Members."Mobile Phone No." <> '') then
                        MobileNo := Members."Mobile Phone No.";

                    if (EmailBody <> '') and SaccoTrans.ValidEmailAddress(Members."E-Mail") then
                        SaccoTrans.SendFinanceEmail(
                            Members."E-Mail", '', '', EmailSubject,
                            'Dear ' + MemberActivities.FirstName(Members.Name) + ',', EmailBody);
                end;

                SendSMS.SendSms(SMSSource::MBanking, MobileNo, msg, SkyTrans."Transaction ID", '', false, 220, false);

            end
            else begin

                if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Mpesa Deposit") or
                  (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Bank Transfer")
                  or (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"External Bank Transfer") then begin

                    if Loans.Get(SkyTrans."Sender Account") then begin
                        SavAcc.Reset;
                        SavAcc.SetRange("Member No.", Loans."Member No.");
                        SavAcc.SETRANGE("Product Category", SavAcc."Product Category"::"Ordinary Savings");
                        if SavAcc.FindFirst then begin
                            SkyTrans."Transaction Description" := 'Loan Repayment ' + SkyTrans."Sender Account";
                            SkyTrans."Sender Account" := SavAcc."No.";
                            SkyTrans."Loan No." := Loans."Loan No.";
                            SkyTrans."Transaction Type" := SkyTrans."transaction type"::"Loan Repayment";
                            SkyTrans."Needs Change" := false;
                            SkyTrans.Modify;
                        end
                        else begin
                            SkyTrans."Needs Change" := true;

                            SkyTrans.Remarks := 'Clearing Account Not Found';
                            SkyTrans.Modify;
                            RaiseMpesaNeedsChangeEvent(SkyTrans);
                        end
                    end
                    else begin
                        SkyTrans."Needs Change" := true;

                        SkyTrans.Remarks := 'Account/Loan No. Not Found';
                        SkyTrans.Modify;
                        RaiseMpesaNeedsChangeEvent(SkyTrans);
                    end;

                end
                else begin
                    SkyTrans."Needs Change" := true;

                    SkyTrans.Remarks := 'Unknown Transaction type';
                    SkyTrans.Modify;
                    RaiseMpesaNeedsChangeEvent(SkyTrans);
                end;
            end;
        end;

    end;


    procedure ResolveSavingsAccountByKeyword(var SkyTrans: Record "Sky M-Banking Transactions"; var SavAcc: Record "Savings Accounts"; var AccNo: Code[20]; var Distribute: Boolean): Boolean
    var
        ProductSetup: Record "Product Setup";
        ProductCode: Code[20];
        AccountReference: Text;
    begin
        AccountReference := SkyTrans."Savings Account";
        ProductCode := GetProductFromTransactionAccount(AccountReference);

        if ProductCode = '' then begin
            AccountReference := SkyTrans."Sender Account";
            ProductCode := GetProductFromTransactionAccount(AccountReference);
        end;

        if ProductCode = '' then begin
            AccountReference := SkyTrans."Transaction Description";
            ProductCode := GetProductFromTransactionAccount(AccountReference);
        end;

        if ProductCode = '' then
            exit(false);

        if not ProductSetup.Get(ProductCode) then begin
            SkyTrans.Remarks := CopyStr(StrSubstNo('Keyword mapped to missing product %1.', ProductCode), 1, MaxStrLen(SkyTrans.Remarks));
            exit(false);
        end;

        case ProductSetup."Product Class" of
            ProductSetup."Product Class"::Savings:
                begin
                    if not ResolveMappedSavingsAccount(AccountReference, ProductCode, SavAcc) then
                        exit(false);

                    AccNo := SavAcc."No.";
                    SkyTrans."Savings Account" := AccNo;
                    Distribute := ProductSetup."Product Category" = ProductSetup."Product Category"::"Unallocated Fund";
                    SkyTrans."Needs Change" := false;
                    SkyTrans.Remarks := CopyStr(StrSubstNo('Resolved by keyword mapping %1 to savings account %2.', ProductCode, AccNo), 1, MaxStrLen(SkyTrans.Remarks));
                    SkyTrans.Modify();
                    exit(true);
                end;
            ProductSetup."Product Class"::Credit:
                begin
                    if not ResolveMappedLoanAccount(AccountReference, ProductCode, SkyTrans, SavAcc) then
                        exit(false);

                    AccNo := SavAcc."No.";
                    Distribute := false;
                    SkyTrans."Needs Change" := false;
                    SkyTrans.Modify();
                    exit(true);
                end;
        end;

        exit(false);
    end;

    local procedure ResolveMappedSavingsAccount(AccountReference: Text; ProductCode: Code[20]; var SavAcc: Record "Savings Accounts"): Boolean
    var
        CleanAccountReference: Code[50];
    begin
        CleanAccountReference := GetAccountReferenceWithoutKeyword(AccountReference);

        if SavAcc.Get(CopyStr(CleanAccountReference, 1, MaxStrLen(SavAcc."No."))) then
            if SavAcc."Product Type" = ProductCode then
                exit(true);

        SavAcc.Reset();
        SavAcc.SetRange("ID No.", CleanAccountReference);
        SavAcc.SetRange("Product Type", ProductCode);
        if SavAcc.FindFirst() then
            exit(true);

        SavAcc.Reset();
        SavAcc.SetRange("Member No.", CleanAccountReference);
        SavAcc.SetRange("Product Type", ProductCode);
        if SavAcc.FindFirst() then
            exit(true);

        SavAcc.Reset();
        SavAcc.SetRange("Old Member No.", CleanAccountReference);
        SavAcc.SetRange("Product Type", ProductCode);
        if SavAcc.FindFirst() then
            exit(true);

        exit(false);
    end;

    local procedure ResolveMappedLoanAccount(AccountReference: Text; ProductCode: Code[20]; var SkyTrans: Record "Sky M-Banking Transactions"; var SavAcc: Record "Savings Accounts"): Boolean
    var
        Loan: Record Loans;
        Member: Record Members;
        CleanAccountReference: Code[50];
    begin
        CleanAccountReference := GetAccountReferenceWithoutKeyword(AccountReference);

        if Loan.Get(CopyStr(CleanAccountReference, 1, MaxStrLen(Loan."Loan No."))) then begin
            if (Loan."Loan Product Type" <> ProductCode) and (ProductCode <> '') then
                exit(false);
            exit(SetLoanRepaymentAccount(SkyTrans, SavAcc, Loan));
        end;

        Loan.Reset();
        Loan.SetRange("Member No.", CleanAccountReference);
        Loan.SetRange("Loan Product Type", ProductCode);
        Loan.SetFilter("Total Outstanding Balance", '>0');
        if Loan.FindFirst() then
            exit(SetLoanRepaymentAccount(SkyTrans, SavAcc, Loan));

        Loan.Reset();
        Loan.SetRange("Old Member No.", CleanAccountReference);
        Loan.SetRange("Loan Product Type", ProductCode);
        Loan.SetFilter("Total Outstanding Balance", '>0');
        if Loan.FindFirst() then
            exit(SetLoanRepaymentAccount(SkyTrans, SavAcc, Loan));

        Member.Reset();
        Member.SetRange("Old Member No.", CleanAccountReference);
        if Member.FindFirst() then begin
            Loan.Reset();
            Loan.SetRange("Member No.", Member."No.");
            Loan.SetRange("Loan Product Type", ProductCode);
            Loan.SetFilter("Total Outstanding Balance", '>0');
            if Loan.FindFirst() then
                exit(SetLoanRepaymentAccount(SkyTrans, SavAcc, Loan));
        end;

        exit(false);
    end;

    local procedure SetLoanRepaymentAccount(var SkyTrans: Record "Sky M-Banking Transactions"; var SavAcc: Record "Savings Accounts"; Loan: Record Loans): Boolean
    begin
        SavAcc.Reset();
        SavAcc.SetRange("Member No.", Loan."Member No.");
        SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Unallocated Fund");
        if not SavAcc.FindFirst() then
            exit(false);

        //SkyTrans."Transaction Description" := CopyStr('Loan Repayment ' + Loan."Loan No.", 1, MaxStrLen(SkyTrans."Transaction Description"));
        SkyTrans."Loan No." := Loan."Loan No.";
        SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Loan Repayment";
        SkyTrans.Remarks := CopyStr(StrSubstNo(SkyTrans."Savings Account" + ' Resolved by keyword mapping to loan %1.', Loan."Loan No."), 1, MaxStrLen(SkyTrans.Remarks));
        SkyTrans."Sender Account" := SavAcc."No.";
        SkyTrans."Savings Account" := SavAcc."No.";
        exit(true);
    end;

    local procedure GetProductFromTransactionAccount(TransactionAccount: Text): Code[20]
    var
        KeywordSetup: Record "Transaction Keyword Setup";
        NormalizedAccount: Text;
    begin
        NormalizedAccount := UpperCase(TransactionAccount);

        KeywordSetup.Reset();
        KeywordSetup.SetCurrentKey(Priority);
        KeywordSetup.SetRange(Active, true);
        if KeywordSetup.FindSet() then
            repeat
                case KeywordSetup."Keyword Type" of
                    KeywordSetup."Keyword Type"::"After #":
                        if GetTextAfterHash(NormalizedAccount) = UpperCase(KeywordSetup."Keyword Code") then
                            exit(KeywordSetup."Product Code");
                    KeywordSetup."Keyword Type"::Prefix:
                        if CopyStr(NormalizedAccount, 1, StrLen(KeywordSetup."Keyword Code")) = UpperCase(KeywordSetup."Keyword Code") then
                            exit(KeywordSetup."Product Code");
                    KeywordSetup."Keyword Type"::Contains:
                        if StrPos(NormalizedAccount, UpperCase(KeywordSetup."Keyword Code")) > 0 then
                            exit(KeywordSetup."Product Code");
                    KeywordSetup."Keyword Type"::Exact:
                        if NormalizedAccount = UpperCase(KeywordSetup."Keyword Code") then
                            exit(KeywordSetup."Product Code");
                end;
            until KeywordSetup.Next() = 0;

        exit('');
    end;

    local procedure GetTextAfterHash(AccountNo: Text): Code[20]
    var
        HashPos: Integer;
        ValueAfterHash: Text;
    begin
        HashPos := StrPos(AccountNo, '#');
        if HashPos = 0 then
            exit('');

        ValueAfterHash := CopyStr(AccountNo, HashPos + 1);
        exit(CopyStr(UpperCase(ValueAfterHash), 1, 20));
    end;

    local procedure GetAccountReferenceWithoutKeyword(AccountReference: Text): Code[50]
    var
        HashPos: Integer;
    begin
        AccountReference := DelChr(AccountReference, '=', ' ');
        HashPos := StrPos(AccountReference, '#');
        if HashPos > 0 then
            AccountReference := CopyStr(AccountReference, 1, HashPos - 1);

        AccountReference := RemoveTrailingAccountReferenceSeparators(AccountReference);

        exit(CopyStr(UpperCase(AccountReference), 1, 50));
    end;

    local procedure RemoveTrailingAccountReferenceSeparators(AccountReference: Text): Text
    var
        LastChar: Text[1];
    begin
        AccountReference := DelChr(AccountReference, '>', ' ');

        while StrLen(AccountReference) > 0 do begin
            LastChar := CopyStr(AccountReference, StrLen(AccountReference), 1);
            if not (LastChar in ['-', '/', '\', '#', ':', ';', ',']) then
                exit(AccountReference);

            AccountReference := DelStr(AccountReference, StrLen(AccountReference), 1);
            AccountReference := DelChr(AccountReference, '>', ' ');
        end;

        exit(AccountReference);
    end;




    // ################################################################################################
    // RESPONSE GENERATION PROCEDURE
    // ################################################################################################
    local procedure WrapResponse(RequestJson: JsonObject; ResponseJson: JsonObject) Wrapped: Text;
    var
        ResponseInnerJson: JsonObject;
        WrappedJson: JsonObject;
        PayloadJson: JsonObject;

        RequestAction: Text;
        RequestId: Text;
        ResponsePayload: Text;
        ResponseHash: Text;
        UserName: Text;
        SessionId: Text;
        Timestamp: Text;
    begin
        //RequestId := SelectJsonToken(RequestJson, '$.request.id').AsValue.AsText;
        RequestAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;
        //UserName := SelectJsonToken(RequestJson, '$.request.user').AsValue.AsText;
        //SessionId := SelectJsonToken(RequestJson, '$.request.session_id').AsValue.AsText;
        //Timestamp := SelectJsonToken(RequestJson, '$.request.timestamp').AsValue.AsText;



        ResponseJson.Remove(Status);

        PayloadJson.WriteTo(ResponsePayload);
        ResponseHash := Sha256Hash(ResponsePayload);

        //ResponseInnerJson.Add('id', RequestId);
        ResponseInnerJson.Add('action', RequestAction);
        ResponseInnerJson.Add('status', ResponseStatus);
        ResponseInnerJson.Add('status_message', ResponseMessage);
        //ResponseInnerJson.Add('hash', ResponseHash);
        ResponseInnerJson.Add('timestamp', CurrentDateTime);
        ResponseInnerJson.Add('payload', ResponseJson);

        WrappedJson.Add('response', ResponseInnerJson);
        WrappedJson.WriteTo(Wrapped);
    end;

    // SUPPORTING PROCEDURES
    // ------------------------------------------------------------------------------------------------

    local procedure SetResponseStatus(var ResponseJson: JsonObject; TheStatus: Text; TheTitle: Text; TheMessage: Text)
    begin
        ResponseStatus := TheStatus;
        ResponseTitle := TheTitle;
        ResponseMessage := TheMessage;

        //ResponseJson.Add(Status, TheStatus);
        //ResponseJson.Add(Title, TheTitle);
        //ResponseJson.Add(Message, TheMessage);
    end;

    local procedure ValidateUserSession(RequestJson: JsonObject) Response: Boolean
    var
        UserName: Text;
        SessionId: Text;
        Employee: Record Employee;
    begin
        //UserName := SelectJsonToken(RequestJson, '$.request.user').AsValue.AsText;
        //SessionId := SelectJsonToken(RequestJson, '$.request.session_id').AsValue.AsText;

        Response := true;
    end;

    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;

    local procedure SelectJsonToken(JsonObject: JsonObject; Path: text) JsonToken: JsonToken;
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('Could not find a token with path %1', Path);
    end;

    local procedure ValidateRequestHash(RequestJson: JsonObject)
    var
        PayLoadJson: JsonObject;
        PayLoad: Text;
        HashFromPayload: Text;
        HashedPayload: Text;
    begin
        exit;
        HashFromPayload := SelectJsonToken(RequestJson, '$.request.hash').AsValue.AsText;
        PayLoadJson := SelectJsonToken(RequestJson, '$.request.payload').AsObject;
        PayLoadJson.WriteTo(PayLoad);
        HashedPayload := Sha256Hash(PayLoad);

        if HashedPayload <> HashFromPayload then
            Error('Payload hash mismatch');
    end;

    local procedure Sha256Hash(ClearText: Text): Text
    var
        CryptographyManagement: codeunit "Cryptography Management";
        HashAlgorithmType: option MD5,SHA1,SHA256,SHA384,SHA512;
    begin
        exit(Text.LowerCase(CryptographyManagement.GenerateHash(ClearText, HashAlgorithmType::SHA256)));
    end;


    local procedure NewLine(): Text
    var
        cr: Char;
        lf: Char;
    begin
        cr := 10;
        lf := 13;
        exit(Format(cr));
    end;

    local procedure RaiseMpesaNeedsChangeEvent(SkyTrans: Record "Sky M-Banking Transactions")
    var
        PowerEvents: Codeunit "UW Power Automate Bus. Events";
    begin
        PowerEvents.RaiseMpesaTransactionNeedsChange(
            CopyStr(SkyTrans."Transaction ID", 1, 20),
            Format(SkyTrans."Transaction Type"),
            CopyStr(SkyTrans."Receiver Account", 1, 30),
            CopyStr(SkyTrans."Savings Account", 1, 30),
            SkyTrans."Transaction Amount",
            CopyStr(SkyTrans.Remarks, 1, 250));
    end;
}
