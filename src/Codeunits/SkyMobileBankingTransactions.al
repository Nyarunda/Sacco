codeunit 50137 "Sky M-Banking Transactions"
{
    procedure LogAccountBalanceEnquiry(
        APIRequestID: Text;
        OriginatorID: Text[20];
        IdentifierType: Text;
        Identifier: Text;
        SavingsAccountNumber: Text;
        var theMember: Record Members
    )
    var
        SkyTrans: Record "Sky M-Banking Transactions";
    begin
        // Log the transaction
        SkyTrans.Init;

        SkyTrans."API Request ID" := APIRequestID;
        SkyTrans."Originator ID" := OriginatorID;

        SkyTrans."Transaction ID" := OriginatorID;

        SkyTrans."Identifier Type" := IdentifierType;
        SkyTrans."Identifier" := Identifier;
        SkyTrans."Savings Account" := GetMemberUnallocatedAcc(theMember);
        SkyTrans."Beneficiary Account" := SavingsAccountNumber;


        SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Account Balance Enquiry";
        SkyTrans."Transaction Date Time" := CurrentDateTime;
        SkyTrans."Transaction Date" := Today;
        SkyTrans."Transaction Time" := Time;
        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::CONFIRMED;
        SkyTrans.Posted := false;
        // SkyTrans.Reversed := false;

        SkyTrans.Insert(true);

        //PostCharges
        PostBalanceEquiryTransaction(SkyTrans."Originator ID");
    end;

    procedure PostSkyLoanApplicationCharge(LoanNo: Code[50]; JTemplate: Code[50]; JBatch: Code[50]; SessionID: Text[50]): Boolean
    var
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        ChargesAcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Enum "SMS Source Enum";
        ExtDoc: Code[20];
        Dim1: Code[20];
        Dim2: Code[20];
        LoanProduct: Record "Product Setup";
        SMSAccount: Code[10];
        SMSCharge: Decimal;
        SystCreated: Boolean;
        SkyMobileSetup: Record "Sky Mobile Setup.";
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement";
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        UpfrontInterest: Decimal;
        SafcomFee: Decimal;
        DividendFee: Decimal;
        Amt: Decimal;
        DimID: Integer;
        i: integer;
        msg: Text;
        Desc: Text;
        LBalance: Decimal;
        PrincipalPortion: Decimal;
        Interest: Decimal;
        TotalTopUp: Decimal;
        Members: Record Members;
        FosaAccount: Record "Savings Accounts";
        MobileLoan: Record "Sky Mobile Loans";
        Loans: Record "Portal Loans";
        LoanTopup: Record Loans;
        NewTopUp: Record "Loan Top Up";
        SaccoSetup: Record "Sacco Setup";
        MLimit: Record "Mobile Loan Limit";
        SaccoTrans: Codeunit "Sacco Activities";
        userSetup: Record "User Setup";
        LoanType: Record "Product Setup";
        NonMemberAccount: Code[20];
        NonMemberChargesAccount: Code[20];
    begin
        SaccoSetup.Get();
        MobileLoan.Reset();
        MobileLoan.SetRange("Entry No", SessionID);
        if MobileLoan.FindFirst() then begin

            Loans.RESET;
            Loans.SETRANGE("Application No.", LoanNo);
            //Loans.SETRANGE("Loan Product Type", MobileLoan."Loan Product Type");
            IF Loans.FINDFIRST THEN BEGIN

                LoanProduct.Get(Loans."Loan Product Type");


                DocNo := Loans."Application No.";
                PDate := TODAY;
                userSetup.Get(UserId);

                if Members.Get(Loans."Member No.") then begin
                    if Dim2 = '' then
                        Dim2 := Members."Global Dimension 2 Code";
                    if Dim2 = '' then
                        Dim2 := userSetup."Global Dimension 2 Code";
                end;

                DimID := userSetup."Dimension Set ID";

                FosaAccount.Get(Loans."Account No");

                AccNo := FosaAccount."No.";
                ExtDoc := '';
                LoanNo := Loans."Application No.";
                TransType := TransType::" ";
                SystCreated := TRUE;

                // Get Excise duty G/L
                ExciseDutyGL := GetExciseDutyGL();
                ExciseDutyRate := GetExciseRate();
                ExciseDuty := 0;

                SaccoAccount := '';
                NonMemberChargesAccount := '';
                SaccoFee := 0;
                NonMemberAccount := '';
                VendorAccount := '';
                VendorCommission := 0;
                SMSAccount := '';
                SMSCharge := 0;

                SkyMobileSetup.Reset;
                SkyMobileSetup.SetRange("Transaction Type", SkyMobileSetup."Transaction Type"::"Loan Disbursement");
                if SkyMobileSetup.FindFirst then begin

                    SMSAccount := SkyMobileSetup."SMS Account";
                    SMSCharge := SkyMobileSetup."SMS Charge";
                    SaccoAccount := SkyMobileSetup."Sacco Fee Account";
                    SaccoFee := SkyMobileSetup."Sacco Fee";
                    VendorAccount := SkyMobileSetup."Vendor Commission Account";
                    VendorCommission := SkyMobileSetup."Vendor Commission";
                    NonMemberAccount := SkyMobileSetup."Non-Member Debit Account";

                    if SkyMobileSetup."Sacco Staggered Fee" then
                        MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Sacco Staggered Charge", MobileLoan.Amount, SaccoFee, ChargeDuty, ChargeAcctType, ChargeAcct);

                    if SkyMobileSetup."Vendor Staggered Fee" then
                        MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Vendor Staggered Charge", MobileLoan.Amount, VendorCommission, ChargeDuty, ChargeAcctType, ChargeAcct);

                    if SkyMobileSetup."Safcom Staggered Fee" then
                        MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Safcom Staggered Charge", MobileLoan.Amount, SafcomFee, ChargeDuty, ChargeAcctType, ChargeAcct);


                    TotalCharge := SaccoFee + VendorCommission + SafcomFee + DividendFee + SMSCharge;
                    ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
                end
                else begin
                    Error('Setup Missing for %1', SkyMobileSetup."Transaction Type");
                end;

                NonMemberChargesAccount := AccNo;
                ChargesAcctType := AcctType::Savings;
                if NonMemberAccount <> '' then begin
                    ChargesAcctType := AcctType::"G/L Account";
                    NonMemberChargesAccount := NonMemberAccount;
                end;


                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, ChargesAcctType, NonMemberChargesAccount, COPYSTR('Sky Mobile Charge', 1, 100), BalAccType::"G/L Account",
                              '', VendorCommission, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, ChargesAcctType, NonMemberChargesAccount, COPYSTR('SMS Charge', 1, 100), BalAccType::"G/L Account",
                    SMSAccount, SMSCharge, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                AccNo := VendorAccount;
                LoanNo := '';
                TransType := TransType::" ";

                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Vendor, AccNo, COPYSTR(LoanProduct."Description" + 'Sky Loan Application Commission', 1, 100), BalAccType::"G/L Account",
                              '', -VendorCommission, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);


                //MobileLoan.Remarks := 'Successful. Pending Disbursement';
                MobileLoan."Approved Amount" := Loans."Approved Amount";

                if LoanProduct."Is Mobile" then
                    MobileLoan.Status := MobileLoan.Status::Successful
                else
                    MobileLoan.Status := MobileLoan.Status::"Pending Guarantors";
                MobileLoan.Posted := TRUE;
                MobileLoan."Date Posted" := CURRENTDATETIME;//TODAY;
                MobileLoan.Modify();

                SaccoTrans.JournalPost(JTemplate, JBatch);

                //xx
                Msg := 'Dear ' + Loans."Account Name" + ', Your ' + LoanProduct.Description + ' of KES ' + FORMAT(Loans."Requested Amount") + ' has been received and is pending disbursement.';
                SendSMS.SendSms(SMSSource::SkyMobile, FosaAccount."Transactional Mobile No", msg, FORMAT(MobileLoan."Entry No"), '', TRUE, 0, FALSE);

            end;
        end;
    end;

    procedure PostLoan(LoanNo: Code[50]; JTemplate: Code[50]; JBatch: Code[50]; SessionID: Text[50]): Boolean
    var
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        ChargesAcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Enum "SMS Source Enum";
        ExtDoc: Code[20];
        Dim1: Code[20];
        Dim2: Code[20];
        LoanProduct: Record "Product Setup";
        SMSAccount: Code[10];
        SMSCharge: Decimal;
        SystCreated: Boolean;
        SkyMobileSetup: Record "Sky Mobile Setup.";
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement";
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        UpfrontInterest: Decimal;
        SafcomFee: Decimal;
        DividendFee: Decimal;
        Amt: Decimal;
        DimID: Integer;
        i: integer;
        msg: Text;
        Desc: Text;
        LBalance: Decimal;
        PrincipalPortion: Decimal;
        Interest: Decimal;
        TotalTopUp: Decimal;
        Members: Record Members;
        FosaAccount: Record "Savings Accounts";
        MobileLoan: Record "Sky Mobile Loans";
        Loans: Record Loans;
        LoanTopup: Record Loans;
        NewTopUp: Record "Loan Top Up";
        SaccoSetup: Record "Sacco Setup";
        MLimit: Record "Mobile Loan Limit";
        SaccoTrans: Codeunit "Sacco Activities";
        userSetup: Record "User Setup";
        NonMemberAccount: Code[20];
        NonMemberChargesAccount: Code[20];
    begin
        SaccoSetup.Get();
        MobileLoan.Reset();
        MobileLoan.SetRange("Entry No", SessionID);
        if MobileLoan.FindFirst() then begin

            Loans.RESET;
            Loans.SETRANGE("Loan No.", LoanNo);
            Loans.SETRANGE("Loan Product Type", MobileLoan."Loan Product Type");
            IF Loans.FINDFIRST THEN BEGIN
                Loans.CalcFields("Outstanding Principal");
                UpfrontInterest := 0;
                PrincipalPortion := 0;

                LoanProduct.Get(Loans."Loan Product Type");
                LBalance := MobileLoan.Amount;
                IF (LoanProduct."Interest Recovered Upfront") or (LoanProduct."Interest Due on Disbursement" = LoanProduct."Interest Due on Disbursement"::"Full Interest") THEN begin
                    UpfrontInterest := 0;
                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Straight Line" then begin
                        UpfrontInterest := (LBalance * LoanProduct."Interest Rate (Max.)") / 100;
                    end else begin

                        for i := 1 to Loans.Installments do begin
                            Interest := 0;
                            Interest := (LBalance * LoanProduct."Interest Rate (Max.)") / 100;
                            UpfrontInterest += Interest;
                            PrincipalPortion := LBalance / (Loans.Installments - i + 1); // Optional: dynamic reduction
                            LBalance -= PrincipalPortion;
                        end;

                    end;

                    UpfrontInterest := SaccoTrans.SmartRound(UpfrontInterest);
                end;

                DocNo := Loans."Loan No.";
                PDate := TODAY;
                userSetup.Get(UserId);

                if Members.Get(Loans."Member No.") then begin
                    if Dim2 = '' then
                        Dim2 := Members."Global Dimension 2 Code";
                    if Dim2 = '' then
                        Dim2 := userSetup."Global Dimension 2 Code";
                end;

                DimID := Loans."Dimension Set ID";
                Dim1 := Loans."Global Dimension 1 Code";
                Dim2 := Loans."Booking Branch";

                FosaAccount.Get(Loans."Disbursement Account No");

                AccNo := FosaAccount."No.";
                ExtDoc := '';
                LoanNo := Loans."Loan No.";
                TransType := TransType::" ";
                SystCreated := TRUE;

                // Get Excise duty G/L
                ExciseDutyGL := GetExciseDutyGL();
                ExciseDutyRate := GetExciseRate();
                ExciseDuty := 0;

                SaccoAccount := '';
                NonMemberChargesAccount := '';
                SaccoFee := 0;
                NonMemberAccount := '';
                VendorAccount := '';
                VendorCommission := 0;
                SMSAccount := '';
                SMSCharge := 0;

                SkyMobileSetup.Reset;
                SkyMobileSetup.SetRange("Transaction Type", SkyMobileSetup."Transaction Type"::"Loan Disbursement");
                if SkyMobileSetup.FindFirst then begin

                    SMSAccount := SkyMobileSetup."SMS Account";
                    SMSCharge := SkyMobileSetup."SMS Charge";
                    SaccoAccount := SkyMobileSetup."Sacco Fee Account";
                    SaccoFee := SkyMobileSetup."Sacco Fee";
                    VendorAccount := SkyMobileSetup."Vendor Commission Account";
                    VendorCommission := SkyMobileSetup."Vendor Commission";
                    NonMemberAccount := SkyMobileSetup."Non-Member Debit Account";

                    if SkyMobileSetup."Sacco Staggered Fee" then
                        MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Sacco Staggered Charge", MobileLoan.Amount, SaccoFee, ChargeDuty, ChargeAcctType, ChargeAcct);

                    /* if SkyMobileSetup."Vendor Staggered Fee" then
                        MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Vendor Staggered Charge", MobileLoan.Amount, VendorCommission, ChargeDuty, ChargeAcctType, ChargeAcct);
                    */

                    if SkyMobileSetup."Safcom Staggered Fee" then
                        MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Safcom Staggered Charge", MobileLoan.Amount, SafcomFee, ChargeDuty, ChargeAcctType, ChargeAcct);


                    TotalCharge := SaccoFee + VendorCommission + SafcomFee + DividendFee + SMSCharge;
                    ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
                end
                else begin
                    Error('Setup Missing for %1', SkyMobileSetup."Transaction Type");
                end;

                NonMemberChargesAccount := AccNo;
                ChargesAcctType := AcctType::Savings;
                if NonMemberAccount <> '' then begin
                    ChargesAcctType := AcctType::"G/L Account";
                    NonMemberChargesAccount := NonMemberAccount;
                end;


                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, AccNo, COPYSTR(LoanProduct."Description" + ' Disbursement', 1, 100), BalAccType::"G/L Account",
                              '', -MobileLoan.Amount, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);


                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, ChargesAcctType, NonMemberChargesAccount, COPYSTR('Sky Mobile Charge', 1, 100), BalAccType::"G/L Account",
                              '', VendorCommission, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, ChargesAcctType, NonMemberChargesAccount, COPYSTR('SMS Charge', 1, 100), BalAccType::"G/L Account",
                    SMSAccount, SMSCharge, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);


                IF (LoanProduct."Interest Recovered Upfront") THEN
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, AccNo, COPYSTR(LoanProduct."Description" + ' Interest', 1, 100), BalAccType::"G/L Account",
                                  '', UpfrontInterest, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                AccNo := Loans."Loan Account";
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Credit, AccNo, COPYSTR(LoanProduct."Description" + ' Disbursement', 1, 100), BalAccType::"G/L Account",
                              '', MobileLoan.Amount, ExtDoc, LoanNo, TransType::"Loan Disbursement", Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                IF (LoanProduct."Interest Recovered Upfront") or (LoanProduct."Interest Due on Disbursement" = LoanProduct."Interest Due on Disbursement"::"Full Interest") THEN BEGIN
                    //Loans."Loan Interest Repayment" := ROUND(LoanProduct."Interest Rate" / 1200 * Loans."Approved Amount");
                    LoanProduct.TESTFIELD(LoanProduct."Loan Interest Income [G/L]");
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Credit, AccNo, COPYSTR(LoanProduct."Description" + ' Interest Due', 1, 100), BalAccType::"G/L Account",
                                  LoanProduct."Loan Interest Income [G/L]", UpfrontInterest, ExtDoc, LoanNo, TransType::"Interest Due", Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                END;

                IF (LoanProduct."Interest Recovered Upfront") then begin
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Credit, AccNo, COPYSTR(LoanProduct."Description" + ' Interest Paid', 1, 100), BalAccType::"G/L Account",
                              '', -UpfrontInterest, ExtDoc, LoanNo, TransType::"Interest Paid", Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                    Loans."Loan Interest Repayment" := 0;
                    Loans.Repayment := Loans."Loan Principle Repayment";

                end;



                AccNo := VendorAccount;
                LoanNo := '';
                TransType := TransType::" ";

                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Vendor, AccNo, COPYSTR(LoanProduct."Description" + ' Disbursement Commission', 1, 100), BalAccType::"G/L Account",
                              '', -VendorCommission, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);


                LoanTopup.Reset();
                LoanTopup.SetRange("Member No.", Loans."Member No.");
                LoanTopup.SetRange("Loan Product Type", Loans."Loan Product Type");
                LoanTopup.SetFilter("Total Outstanding Balance", '>0');
                LoanTopup.SetAutoCalcFields("Outstanding Principal", "Outstanding Interest");
                if LoanTopup.FindFirst() then begin

                    NewTopUp.Init();
                    NewTopUp.Type := NewTopUp.Type::"Top Up";
                    NewTopUp.Validate("Loan No.", Loans."Loan No.");
                    NewTopUp."Loan Type" := LoanTopup."Loan Product Type";
                    NewTopUp.Validate("Member No.", LoanTopup."Member No.");
                    NewTopUp.Validate("Loan Top Up", LoanTopup."Loan No.");
                    NewTopUp.Insert();

                    AccNo := LoanTopup."Loan Account";
                    LoanNo := LoanTopup."Loan No.";

                    if LoanTopup."Outstanding Interest" > 0 then begin
                        TotalTopUp += LoanTopup."Outstanding Interest";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Credit, AccNo, COPYSTR(LoanTopup."Loan Product Type Name" + ' Interest Paid', 1, 100), BalAccType::"G/L Account",
                        '', -LoanTopup."Outstanding Interest", ExtDoc, LoanNo, TransType::"Interest Paid", Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                    end;

                    if LoanTopup."Outstanding Principal" > 0 then begin
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Credit, AccNo, COPYSTR(LoanTopup."Loan Product Type Name" + ' Principal Repayment', 1, 100), BalAccType::"G/L Account",
                        '', -LoanTopup."Outstanding Principal", ExtDoc, LoanNo, TransType::"Principal Repayment", Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        TotalTopUp += LoanTopup."Outstanding Principal";
                    end;

                    AccNo := FosaAccount."No.";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, AccNo, COPYSTR(LoanTopup."Loan Product Type Name" + ' Topup', 1, 100), BalAccType::"G/L Account",
                              '', TotalTopUp, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);



                    NewTopUp.Reset();
                    NewTopUp.SetRange("Loan Top Up", LoanTopup."Loan No.");
                    if NewTopUp.FindFirst() then begin

                        if LoanProduct."Loan Type" = LoanProduct."Loan Type"::Airlift then begin

                            NewTopUp.Commision := NewTopUp."Total Top Up" * 0.05;
                            NewTopUp."Commision Excise" := NewTopUp.Commision * 0.2;
                            NewTopUp.Modify();
                            Commit();

                            Desc := 'Commission on Loan Top Up';
                            AccNo := FosaAccount."No.";
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, AccNo, COPYSTR(Desc, 1, 100), BalAccType::"G/L Account",
                                NewTopUp."Commission GL", NewTopUp.Commision, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                            Desc := 'Excise duty on Commission on Loan Top Up';
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, AccNo, COPYSTR(Desc, 1, 100), BalAccType::"G/L Account",
                                SaccoSetup."Excise Duty GL", NewTopUp."Commision Excise", ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                        end;

                    end;

                end;

                MobileLoan.Remarks := 'Successful';
                MobileLoan."Approved Amount" := Loans."Approved Amount";
                MobileLoan.Status := MobileLoan.Status::Successful;
                MobileLoan.Posted := TRUE;
                MobileLoan."Date Posted" := CURRENTDATETIME;//TODAY;
                MobileLoan.Modify();


                Loans.Posted := TRUE;
                Loans.Modify();


                SaccoTrans.JournalPost(JTemplate, JBatch);

                Loans.GET(Loans."Loan No.");
                Loans.CALCFIELDS("Outstanding Principal", "Outstanding Interest");
                //xx
                Msg := 'Dear ' + Loans."Member Name" + ', Your ' + LoanProduct.Description + ' of KES ' + FORMAT(Loans."Outstanding Principal") + ' has been credited to your Fosa Savings Acc.';
                SendSMS.SendSms(SMSSource::SkyMobile, FosaAccount."Transactional Mobile No", msg, FORMAT(MobileLoan."Entry No"), '', TRUE, 0, FALSE);

                COMMIT;

                SaccoTrans.GenerateRepaymentSchedule(Loans);

                if IsIncludedLoanType(LoanProduct) then
                    ResetLoanLimit(FosaAccount."No.", Loans);

            end;
        end;
    end;

    procedure IsIncludedLoanType(LoanType: Record "Product Setup"): Boolean
    begin
        exit(
            (LoanType."Loan Type" <> LoanType."Loan Type"::Airlift) and
            (LoanType."Loan Type" <> LoanType."Loan Type"::"Wanandege Advance Short Term")
        );
    end;

    local procedure ResetLoanLimit(Acc: Code[20]; Loan: Record Loans)
    var
        MLimit: Record "Mobile Loan Limit";
    begin
        MLimit.Reset();
        MLimit.SetRange("Account No.", Acc);
        MLimit.SetRange("Loan Type", Loan."Loan Product Type");
        if MLimit.FindFirst() then begin
            MLimit.Amount := 0;
            MLimit.Modify();
        end;
    end;

    procedure LogAccountMiniStatement(
        APIRequestID: Text;
        IdentifierType: Text;
        Identifier: Text;
        SavingsAccountNumber: Text;
        var theMember: Record Members
    )
    var
        SkyTrans: Record "Sky M-Banking Transactions";
    begin
        // Log the transaction
        SkyTrans.Init;

        SkyTrans."API Request ID" := APIRequestID;
        SkyTrans."Originator ID" := APIRequestID;

        SkyTrans."Transaction ID" := APIRequestID;

        SkyTrans."Identifier Type" := IdentifierType;
        SkyTrans."Identifier" := Identifier;
        SkyTrans."Savings Account" := GetMemberUnallocatedAcc(theMember);
        SkyTrans."Beneficiary Account" := SavingsAccountNumber;


        SkyTrans."Transaction Type" := "Sky M-Banking Trans Types"::"Account Mini-Statement";
        SkyTrans."Transaction Date Time" := CurrentDateTime;
        SkyTrans."Transaction Date" := Today;
        SkyTrans."Transaction Time" := Time;
        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::CONFIRMED;
        SkyTrans.Posted := false;
        // SkyTrans.Reversed := false;

        SkyTrans.Insert(true);
    end;

    procedure LogAccountFullStatement(
        APIRequestID: Text;
        IdentifierType: Text;
        Identifier: Text;
        SavingsAccountNumber: Text;
        var theMember: Record Members
    )
    var
        SkyTrans: Record "Sky M-Banking Transactions";
    begin
        // Log the transaction
        SkyTrans.Init;

        SkyTrans."API Request ID" := APIRequestID;
        SkyTrans."Originator ID" := APIRequestID;

        SkyTrans."Transaction ID" := CreateGuid();

        SkyTrans."Identifier Type" := IdentifierType;
        SkyTrans."Identifier" := Identifier;
        SkyTrans."Savings Account" := GetMemberUnallocatedAcc(theMember);
        SkyTrans."Beneficiary Account" := SavingsAccountNumber;


        SkyTrans."Transaction Type" := "Sky M-Banking Trans Types"::"Account Full-Statement";
        SkyTrans."Transaction Date Time" := CurrentDateTime;
        SkyTrans."Transaction Date" := Today;
        SkyTrans."Transaction Time" := Time;
        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::CONFIRMED;
        SkyTrans.Posted := false;
        // SkyTrans.Reversed := false;

        SkyTrans.Insert(true);
    end;

    procedure LogWithdrawalRequest(
        var SkyTrans: Record "Sky M-Banking Transactions";
        Payload: JsonObject;
        APIRequestID: JsonToken
    )
    var
        originator_id: JsonToken;
        pesa_type: JsonToken;
        action: JsonToken;
        command: JsonToken;
        // sensitivity: JsonToken;
        // charge: JsonToken;
        // identifier_type: JsonToken;
        // identifier: JsonToken;

        // Initiator
        transaction_initiator_details_identifier_type: JsonToken;
        transaction_initiator_details_identifier: JsonToken;
        transaction_initiator_details_account: JsonToken;
        transaction_initiator_details_name: JsonToken;
        transaction_initiator_details_reference: JsonToken;
        transaction_initiator_details_other_details: JsonToken;
        // Source
        transaction_source_details_identifier_type: JsonToken;
        transaction_source_details_identifier: JsonToken;
        transaction_source_details_account: JsonToken;
        transaction_source_details_name: JsonToken;
        transaction_source_details_reference: JsonToken;
        transaction_source_details_other_details: JsonToken;
        // Sender
        transaction_sender_details_identifier_type: JsonToken;
        transaction_sender_details_identifier: JsonToken;
        transaction_sender_details_account: JsonToken;
        transaction_sender_details_name: JsonToken;
        transaction_sender_details_reference: JsonToken;
        transaction_sender_details_other_details: JsonToken;
        // Receiver
        transaction_receiver_details_identifier_type: JsonToken;
        transaction_receiver_details_identifier: JsonToken;
        transaction_receiver_details_account: JsonToken;
        transaction_receiver_details_name: JsonToken;
        transaction_receiver_details_reference: JsonToken;
        transaction_receiver_details_other_details: JsonToken;
        // Beneficiary
        transaction_beneficiary_details_identifier_type: JsonToken;
        transaction_beneficiary_details_identifier: JsonToken;
        transaction_beneficiary_details_account: JsonToken;
        transaction_beneficiary_details_name: JsonToken;
        transaction_beneficiary_details_reference: JsonToken;
        transaction_beneficiary_details_other_details: JsonToken;

        amount: JsonToken;
        transaction_description: JsonToken;
        category: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        source_application: JsonToken;
        transaction_date_time: JsonToken;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('pesa_type', pesa_type);
        Payload.Get('action', action);
        Payload.Get('command', command);
        // Payload.Get('sensitivity', sensitivity);
        // Payload.Get('charge', charge);
        // Payload.Get('identifier_type', identifier_type);
        // Payload.Get('identifier', identifier);

        Payload.SelectToken('$.transaction_initiator_details.identifier_type', transaction_initiator_details_identifier_type);
        Payload.SelectToken('$.transaction_initiator_details.identifier', transaction_initiator_details_identifier);
        Payload.SelectToken('$.transaction_initiator_details.account', transaction_initiator_details_account);
        Payload.SelectToken('$.transaction_initiator_details.name', transaction_initiator_details_name);
        Payload.SelectToken('$.transaction_initiator_details.reference', transaction_initiator_details_reference);
        Payload.SelectToken('$.transaction_initiator_details.other_details', transaction_initiator_details_other_details);

        Payload.SelectToken('$.transaction_source_details.identifier_type', transaction_source_details_identifier_type);
        Payload.SelectToken('$.transaction_source_details.identifier', transaction_source_details_identifier);
        Payload.SelectToken('$.transaction_source_details.account', transaction_source_details_account);
        Payload.SelectToken('$.transaction_source_details.name', transaction_source_details_name);
        Payload.SelectToken('$.transaction_source_details.reference', transaction_source_details_reference);
        Payload.SelectToken('$.transaction_source_details.other_details', transaction_source_details_other_details);

        Payload.SelectToken('$.transaction_sender_details.identifier_type', transaction_sender_details_identifier_type);
        Payload.SelectToken('$.transaction_sender_details.identifier', transaction_sender_details_identifier);
        Payload.SelectToken('$.transaction_sender_details.account', transaction_sender_details_account);
        Payload.SelectToken('$.transaction_sender_details.name', transaction_sender_details_name);
        Payload.SelectToken('$.transaction_sender_details.reference', transaction_sender_details_reference);
        Payload.SelectToken('$.transaction_sender_details.other_details', transaction_sender_details_other_details);

        Payload.SelectToken('$.transaction_receiver_details.identifier_type', transaction_receiver_details_identifier_type);
        Payload.SelectToken('$.transaction_receiver_details.identifier', transaction_receiver_details_identifier);
        Payload.SelectToken('$.transaction_receiver_details.account', transaction_receiver_details_account);
        Payload.SelectToken('$.transaction_receiver_details.name', transaction_receiver_details_name);
        Payload.SelectToken('$.transaction_receiver_details.reference', transaction_receiver_details_reference);
        Payload.SelectToken('$.transaction_receiver_details.other_details', transaction_receiver_details_other_details);

        Payload.SelectToken('$.transaction_beneficiary_details.identifier_type', transaction_beneficiary_details_identifier_type);
        Payload.SelectToken('$.transaction_beneficiary_details.identifier', transaction_beneficiary_details_identifier);
        Payload.SelectToken('$.transaction_beneficiary_details.account', transaction_beneficiary_details_account);
        Payload.SelectToken('$.transaction_beneficiary_details.name', transaction_beneficiary_details_name);
        Payload.SelectToken('$.transaction_beneficiary_details.reference', transaction_beneficiary_details_reference);
        Payload.SelectToken('$.transaction_beneficiary_details.other_details', transaction_beneficiary_details_other_details);

        Payload.Get('amount', amount);
        Payload.Get('transaction_description', transaction_description);
        Payload.Get('category', category);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('source_application', source_application);
        Payload.Get('transaction_date_time', transaction_date_time);

        SkyTrans.Init;

        SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::" ";
        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::" ";

        SkyTrans."API Request ID" := APIRequestID.AsValue.AsText;

        SkyTrans."Originator ID" := originator_id.AsValue.AsText;
        SkyTrans."Transaction ID" := originator_id.AsValue.AsText;
        SkyTrans."PESA Type" := pesa_type.AsValue.AsText;
        SkyTrans.Action := action.AsValue.AsText;
        SkyTrans.Command := command.AsValue.AsText;
        // MpesaDepositTrans.Sensitivity := sensitivity.AsValue.AsText;
        // MpesaDepositTrans.Charge := charge.AsValue.AsDecimal;
        // MpesaDepositTrans."Identifier Type" := identifier_type.AsValue.AsText;
        // MpesaDepositTrans.Identifier := identifier.AsValue.AsText;

        SkyTrans."Initiator Identifier Type" := transaction_initiator_details_identifier_type.AsValue.AsText;
        SkyTrans."Initiator Identifier" := transaction_initiator_details_identifier.AsValue.AsText;
        SkyTrans."Initiator Account" := transaction_initiator_details_account.AsValue.AsText;
        SkyTrans."Initiator Name" := transaction_initiator_details_name.AsValue.AsText;
        SkyTrans."Initiator Reference" := transaction_initiator_details_reference.AsValue.AsText;
        SkyTrans."Initiator Other Details" := transaction_initiator_details_other_details.AsValue.AsText;

        SkyTrans."Source Identifier Type" := transaction_source_details_identifier_type.AsValue.AsText;
        SkyTrans."Source Identifier" := transaction_source_details_identifier.AsValue.AsText;
        SkyTrans."Source Account" := transaction_source_details_account.AsValue.AsText;
        SkyTrans."Source Name" := transaction_source_details_name.AsValue.AsText;
        SkyTrans."Source Reference" := transaction_source_details_reference.AsValue.AsText;
        SkyTrans."Source Other Details" := transaction_source_details_other_details.AsValue.AsText;

        SkyTrans."Sender Identifier Type" := transaction_sender_details_identifier_type.AsValue.AsText;
        SkyTrans."Sender Identifier" := transaction_sender_details_identifier.AsValue.AsText;
        SkyTrans."Sender Account" := transaction_sender_details_account.AsValue.AsText;
        SkyTrans."Sender Name" := transaction_sender_details_name.AsValue.AsText;
        SkyTrans."Sender Reference" := transaction_sender_details_reference.AsValue.AsText;
        SkyTrans."Sender Other Details" := transaction_sender_details_other_details.AsValue.AsText;

        SkyTrans."Receiver Identifier Type" := transaction_receiver_details_identifier_type.AsValue.AsText;
        SkyTrans."Receiver Identifier" := transaction_receiver_details_identifier.AsValue.AsText;
        SkyTrans."Receiver Account" := transaction_receiver_details_account.AsValue.AsText;
        SkyTrans."Receiver Name" := transaction_receiver_details_name.AsValue.AsText;
        SkyTrans."Receiver Reference" := transaction_receiver_details_reference.AsValue.AsText;
        SkyTrans."Receiver Other Details" := transaction_receiver_details_other_details.AsValue.AsText;

        SkyTrans."Beneficiary Identifier Type" := transaction_beneficiary_details_identifier_type.AsValue.AsText;
        SkyTrans."Beneficiary Identifier" := transaction_beneficiary_details_identifier.AsValue.AsText;
        SkyTrans."Beneficiary Account" := transaction_beneficiary_details_account.AsValue.AsText;
        SkyTrans."Beneficiary Name" := transaction_beneficiary_details_name.AsValue.AsText;
        SkyTrans."Beneficiary Reference" := transaction_beneficiary_details_reference.AsValue.AsText;
        SkyTrans."Beneficiary Other Details" := transaction_beneficiary_details_other_details.AsValue.AsText;

        SkyTrans."Transaction Amount" := amount.AsValue.AsDecimal;
        SkyTrans."Transaction Description" := transaction_description.AsValue.AsText;
        SkyTrans."Transaction Category" := category.AsValue.AsText;
        SkyTrans."Transaction Source Reference" := source_reference.AsValue.AsText;
        SkyTrans."Request Application" := request_application.AsValue.AsText;
        SkyTrans."Source Application" := source_application.AsValue.AsText;

        Evaluate(SkyTrans."Transaction Date Time", transaction_date_time.AsValue.AsText);
        SkyTrans."Transaction Date" := DT2Date(SkyTrans."Transaction Date Time");
        SkyTrans."Transaction Time" := DT2Time(SkyTrans."Transaction Date Time");

        SkyTrans.Posted := false;
        SkyTrans."Needs Change" := true;
        SkyTrans.Remarks := 'Pending Confirmation';


        // SkyTrans.Reversed := false;

        case SkyTrans."Transaction Category" of
            'MPESA_WITHDRAWAL':
                SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Mpesa Withdrawal";
            'BILL_PAYMENT':
                SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Utility Payment";
            'TILL_PAYMENT':
                SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Utility Payment";
            'BANK_TRANSFER':
                SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Bank Transfer";
            'EXTERNAL_BANK_TRANSFER':
                SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"External Bank Transfer";
            'AIRTIME_PURCHASE':
                SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::Airtime;
            'MPESA_C2B_DEPOSIT':
                SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Mpesa Deposit";
        end;




        SkyTrans."Savings Account" := SkyTrans."Source Account";
        SkyTrans.insert;

    end;

    procedure ProcessWithdrawalResult(
        Payload: JsonObject;
        APIRequestID: JsonToken;
        var WithdrawalTrans: Record "Sky M-Banking Transactions"
    )
    var
        originator_id: JsonToken;
        transaction_status: JsonToken; // CONFIRMED, REVERSE_CONFIRMED
        transaction_status_description: JsonToken;

        // Beneficiary details update
        transaction_beneficiary_details_identifier_type: JsonToken;
        transaction_beneficiary_details_identifier: JsonToken;
        transaction_beneficiary_details_name: JsonToken;
        transaction_beneficiary_details_other_details: JsonToken;

        beneficiary_reference: JsonToken;
        transaction_date_time: JsonToken;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('transaction_status', transaction_status);
        Payload.Get('transaction_status_description', transaction_status_description);

        Payload.SelectToken('$.transaction_beneficiary_details.identifier_type', transaction_beneficiary_details_identifier_type);
        Payload.SelectToken('$.transaction_beneficiary_details.identifier', transaction_beneficiary_details_identifier);
        Payload.SelectToken('$.transaction_beneficiary_details.name', transaction_beneficiary_details_name);
        Payload.SelectToken('$.transaction_beneficiary_details.other_details', transaction_beneficiary_details_other_details);

        Payload.Get('beneficiary_reference', beneficiary_reference);
        Payload.Get('transaction_date_time', transaction_date_time);

        if transaction_status.AsValue.AsText = 'CONFIRMED' then begin
            // Log details
            WithdrawalTrans."Beneficiary Identifier Type" := transaction_beneficiary_details_identifier_type.AsValue.AsText;
            WithdrawalTrans."Beneficiary Identifier" := transaction_beneficiary_details_identifier.AsValue.AsText;
            WithdrawalTrans."Beneficiary Name" := transaction_beneficiary_details_name.AsValue.AsText;
            WithdrawalTrans."Beneficiary Other details" := transaction_beneficiary_details_other_details.AsValue.AsText;
            WithdrawalTrans."Beneficiary Reference" := beneficiary_reference.AsValue.AsText;
            WithdrawalTrans."Transaction ID" := beneficiary_reference.AsValue.AsText;
            WithdrawalTrans."Needs Change" := false;
            WithdrawalTrans.Remarks := '';

            Evaluate(WithdrawalTrans."Transaction Date Time", transaction_date_time.AsValue.AsText);

            // Mark for posting
            WithdrawalTrans."Transaction Status" := WithdrawalTrans."Transaction Status"::CONFIRMED;
            WithdrawalTrans.Modify(true);
        end;

        if transaction_status.AsValue.AsText = 'REVERSE_CONFIRMED' then begin
            Evaluate(WithdrawalTrans."Transaction Date Time", transaction_date_time.AsValue.AsText);

            WithdrawalTrans."Needs Change" := false;
            WithdrawalTrans.Remarks := '';
            // Mark for posting - reversal
            WithdrawalTrans."Transaction Status" := WithdrawalTrans."Transaction Status"::REVERSE_CONFIRMED;
            WithdrawalTrans.Modify(true);
        end;
    end;

    procedure LogIFTAccountToAccount(
        var SkyTrans: Record "Sky M-Banking Transactions";
        Payload: JsonObject;
        APIRequestID: JsonToken
    )
    var
        originator_id: JsonToken;

        identifier_type: JsonToken;
        identifier: JsonToken;
        source_account: JsonToken;

        destination_account: JsonToken;
        amount: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        source_application: JsonToken;
        transaction_description: JsonToken;
        transaction_date_time: JsonToken;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('source_account', source_account);
        Payload.Get('destination_account', destination_account);
        Payload.Get('amount', amount);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('source_application', source_application);
        Payload.Get('transaction_description', transaction_description);
        Payload.Get('transaction_date_time', transaction_date_time);

        SkyTrans.Init;

        SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Account Transfer";

        SkyTrans."API Request ID" := APIRequestID.AsValue.AsText;
        SkyTrans."Transaction ID" := originator_id.AsValue.AsText;

        SkyTrans."Originator ID" := originator_id.AsValue.AsText;
        SkyTrans."Identifier Type" := identifier_type.AsValue.AsText;
        SkyTrans.Identifier := identifier.AsValue.AsText;

        SkyTrans."Savings Account" := source_account.AsValue.AsText;
        SkyTrans."Source Account" := source_account.AsValue.AsText;
        SkyTrans."Destination Account" := destination_account.AsValue.AsText;


        SkyTrans."Transaction Amount" := amount.AsValue.AsDecimal;
        SkyTrans."Transaction Description" := transaction_description.AsValue.AsText;
        SkyTrans."Transaction Source Reference" := source_reference.AsValue.AsText;
        SkyTrans."Source Reference" := source_reference.AsValue.AsText;
        SkyTrans."Request Application" := request_application.AsValue.AsText;
        SkyTrans."Source Application" := source_application.AsValue.AsText;

        Evaluate(SkyTrans."Transaction Date Time", transaction_date_time.AsValue.AsText);
        SkyTrans."Transaction Date" := DT2Date(SkyTrans."Transaction Date Time");
        SkyTrans."Transaction Time" := DT2Time(SkyTrans."Transaction Date Time");

        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::CONFIRMED;
        SkyTrans.Posted := false;
        // SkyTrans.Reversed := false;
    end;

    procedure DividenceAdvanceQualification(MemberNo: Code[30]; Productyp: Code[20]) QualifiedAmount: Decimal
    var
        myInt: Integer;
        DividenceAd: Record "Dividends Progression";
        ProductSet: Record "Product Setup";
    begin
        QualifiedAmount := 0;
        if ProductSet.Get(Productyp) then begin
            // DividenceAd.Reset();
            // DividenceAd.SetRange("Member No", MemberNo);
            // if DividenceAd.find('-') then begin
            //     QualifiedAmount := ProductSet."FosaLoan Multiplier" * DividenceAd."Net Dividends";
            //     exit(QualifiedAmount);
            // end else
            //     exit(QualifiedAmount);
            exit(QualifiedAmount);
        end;

    end;

    procedure LogIFTLoanRepayment(
        var SkyTrans: Record "Sky M-Banking Transactions";
        Payload: JsonObject;
        APIRequestID: JsonToken
    )
    var
        originator_id: JsonToken;

        identifier_type: JsonToken;
        identifier: JsonToken;
        source_account: JsonToken;

        destination_account: JsonToken;
        amount: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        source_application: JsonToken;
        transaction_description: JsonToken;
        transaction_date_time: JsonToken;

        theLoan: Record Loans;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('source_account', source_account);
        Payload.Get('destination_account', destination_account);
        Payload.Get('amount', amount);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('source_application', source_application);
        Payload.Get('transaction_description', transaction_description);
        Payload.Get('transaction_date_time', transaction_date_time);

        SkyTrans.Init;

        SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Pay Loan From Account";

        SkyTrans."API Request ID" := APIRequestID.AsValue.AsText;
        SkyTrans."Transaction ID" := originator_id.AsValue.AsText;

        SkyTrans."Originator ID" := originator_id.AsValue.AsText;
        SkyTrans."Identifier Type" := identifier_type.AsValue.AsText;
        SkyTrans.Identifier := identifier.AsValue.AsText;

        SkyTrans."Savings Account" := source_account.AsValue.AsText;
        SkyTrans."Source Account" := source_account.AsValue.AsText;
        SkyTrans."Destination Account" := destination_account.AsValue.AsText;
        SkyTrans."Loan No." := destination_account.AsValue.AsText;

        theLoan.Reset;
        theLoan.SetRange("Loan No.", SkyTrans."Loan No.");
        if theLoan.FindFirst then begin
            SkyTrans."Loan Account" := theLoan."Loan Account";
        end else begin
            SkyTrans."Loan Account" := '';
        end;

        SkyTrans."Transaction Amount" := amount.AsValue.AsDecimal;
        SkyTrans."Transaction Description" := transaction_description.AsValue.AsText;
        SkyTrans."Transaction Source Reference" := source_reference.AsValue.AsText;
        SkyTrans."Request Application" := request_application.AsValue.AsText;
        SkyTrans."Source Application" := source_application.AsValue.AsText;

        Evaluate(SkyTrans."Transaction Date Time", transaction_date_time.AsValue.AsText);
        SkyTrans."Transaction Date" := DT2Date(SkyTrans."Transaction Date Time");
        SkyTrans."Transaction Time" := DT2Time(SkyTrans."Transaction Date Time");

        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::CONFIRMED;
        SkyTrans.Posted := false;
        // SkyTrans.Reversed := false;
    end;

    procedure LogDepositRequest(var MpesaDepositTrans: Record "Sky M-Banking Transactions"; Payload: JsonObject; APIRequestID: JsonToken; IsLoanRepayment: Boolean)
    var
        originator_id: JsonToken;
        pesa_type: JsonToken;
        action: JsonToken;
        command: JsonToken;
        sensitivity: JsonToken;
        charge: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        // Initiator
        transaction_initiator_details_identifier_type: JsonToken;
        transaction_initiator_details_identifier: JsonToken;
        transaction_initiator_details_account: JsonToken;
        transaction_initiator_details_name: JsonToken;
        transaction_initiator_details_reference: JsonToken;
        transaction_initiator_details_other_details: JsonToken;
        // Source
        transaction_source_details_identifier_type: JsonToken;
        transaction_source_details_identifier: JsonToken;
        transaction_source_details_account: JsonToken;
        transaction_source_details_name: JsonToken;
        transaction_source_details_reference: JsonToken;
        transaction_source_details_other_details: JsonToken;
        // Sender
        transaction_sender_details_identifier_type: JsonToken;
        transaction_sender_details_identifier: JsonToken;
        transaction_sender_details_account: JsonToken;
        transaction_sender_details_name: JsonToken;
        transaction_sender_details_reference: JsonToken;
        transaction_sender_details_other_details: JsonToken;
        // Receiver
        transaction_receiver_details_identifier_type: JsonToken;
        transaction_receiver_details_identifier: JsonToken;
        transaction_receiver_details_account: JsonToken;
        transaction_receiver_details_name: JsonToken;
        transaction_receiver_details_reference: JsonToken;
        transaction_receiver_details_other_details: JsonToken;
        // Beneficiary
        transaction_beneficiary_details_identifier_type: JsonToken;
        transaction_beneficiary_details_identifier: JsonToken;
        transaction_beneficiary_details_account: JsonToken;
        transaction_beneficiary_details_name: JsonToken;
        transaction_beneficiary_details_reference: JsonToken;
        transaction_beneficiary_details_other_details: JsonToken;

        amount: JsonToken;
        transaction_description: JsonToken;
        category: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        source_application: JsonToken;
        transaction_date_time: JsonToken;
        posting_date_time: JsonToken;

        BeneficiaryLoanAccount: Record Loans;
        TheBeneficiary: Record Members;
        TheBeneficiaryIdentifierNo: Text;
        BeneficiarySavingsAccount: Record "Savings Accounts";
        BeneficiaryLoans: Record Loans;

        MobileDepositkeywordSetup: Record "Loan Paybill Keywords";
        ExitKeywordSearch: Text;
        SearchAccount: Text;
        UWSPostingDateTime: DateTime;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('pesa_type', pesa_type);
        Payload.Get('action', action);
        Payload.Get('command', command);
        Payload.Get('sensitivity', sensitivity);
        Payload.Get('charge', charge);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);

        Payload.SelectToken('$.transaction_initiator_details.identifier_type', transaction_initiator_details_identifier_type);
        Payload.SelectToken('$.transaction_initiator_details.identifier', transaction_initiator_details_identifier);
        Payload.SelectToken('$.transaction_initiator_details.account', transaction_initiator_details_account);
        Payload.SelectToken('$.transaction_initiator_details.name', transaction_initiator_details_name);
        Payload.SelectToken('$.transaction_initiator_details.reference', transaction_initiator_details_reference);
        Payload.SelectToken('$.transaction_initiator_details.other_details', transaction_initiator_details_other_details);

        Payload.SelectToken('$.transaction_source_details.identifier_type', transaction_source_details_identifier_type);
        Payload.SelectToken('$.transaction_source_details.identifier', transaction_source_details_identifier);
        Payload.SelectToken('$.transaction_source_details.account', transaction_source_details_account);
        Payload.SelectToken('$.transaction_source_details.name', transaction_source_details_name);
        Payload.SelectToken('$.transaction_source_details.reference', transaction_source_details_reference);
        Payload.SelectToken('$.transaction_source_details.other_details', transaction_source_details_other_details);

        Payload.SelectToken('$.transaction_sender_details.identifier_type', transaction_sender_details_identifier_type);
        Payload.SelectToken('$.transaction_sender_details.identifier', transaction_sender_details_identifier);
        Payload.SelectToken('$.transaction_sender_details.account', transaction_sender_details_account);
        Payload.SelectToken('$.transaction_sender_details.name', transaction_sender_details_name);
        Payload.SelectToken('$.transaction_sender_details.reference', transaction_sender_details_reference);
        Payload.SelectToken('$.transaction_sender_details.other_details', transaction_sender_details_other_details);

        Payload.SelectToken('$.transaction_receiver_details.identifier_type', transaction_receiver_details_identifier_type);
        Payload.SelectToken('$.transaction_receiver_details.identifier', transaction_receiver_details_identifier);
        Payload.SelectToken('$.transaction_receiver_details.account', transaction_receiver_details_account);
        Payload.SelectToken('$.transaction_receiver_details.name', transaction_receiver_details_name);
        Payload.SelectToken('$.transaction_receiver_details.reference', transaction_receiver_details_reference);
        Payload.SelectToken('$.transaction_receiver_details.other_details', transaction_receiver_details_other_details);

        Payload.SelectToken('$.transaction_beneficiary_details.identifier_type', transaction_beneficiary_details_identifier_type);
        Payload.SelectToken('$.transaction_beneficiary_details.identifier', transaction_beneficiary_details_identifier);
        Payload.SelectToken('$.transaction_beneficiary_details.account', transaction_beneficiary_details_account);
        Payload.SelectToken('$.transaction_beneficiary_details.name', transaction_beneficiary_details_name);
        Payload.SelectToken('$.transaction_beneficiary_details.reference', transaction_beneficiary_details_reference);
        Payload.SelectToken('$.transaction_beneficiary_details.other_details', transaction_beneficiary_details_other_details);

        Payload.Get('amount', amount);
        Payload.Get('transaction_description', transaction_description);
        Payload.Get('category', category);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('source_application', source_application);
        Payload.Get('transaction_date_time', transaction_date_time);

        MpesaDepositTrans.Init;

        MpesaDepositTrans."API Request ID" := APIRequestID.AsValue.AsText;

        MpesaDepositTrans."Originator ID" := originator_id.AsValue.AsText;
        MpesaDepositTrans."Transaction ID" := originator_id.AsValue.AsText;
        MpesaDepositTrans."PESA Type" := pesa_type.AsValue.AsText;
        MpesaDepositTrans.Action := action.AsValue.AsText;
        MpesaDepositTrans.Command := command.AsValue.AsText;
        MpesaDepositTrans.Sensitivity := sensitivity.AsValue.AsText;
        MpesaDepositTrans.Charge := charge.AsValue.AsDecimal;
        MpesaDepositTrans."Identifier Type" := identifier_type.AsValue.AsText;
        MpesaDepositTrans.Identifier := identifier.AsValue.AsText;

        MpesaDepositTrans."Initiator Identifier Type" := transaction_initiator_details_identifier_type.AsValue.AsText;
        MpesaDepositTrans."Initiator Identifier" := transaction_initiator_details_identifier.AsValue.AsText;
        MpesaDepositTrans."Initiator Account" := transaction_initiator_details_account.AsValue.AsText;
        MpesaDepositTrans."Initiator Name" := transaction_initiator_details_name.AsValue.AsText;
        MpesaDepositTrans."Initiator Reference" := transaction_initiator_details_reference.AsValue.AsText;
        MpesaDepositTrans."Initiator Other Details" := transaction_initiator_details_other_details.AsValue.AsText;

        MpesaDepositTrans."Source Identifier Type" := transaction_source_details_identifier_type.AsValue.AsText;
        MpesaDepositTrans."Source Identifier" := transaction_source_details_identifier.AsValue.AsText;
        MpesaDepositTrans."Source Account" := transaction_source_details_account.AsValue.AsText;
        MpesaDepositTrans."Source Name" := transaction_source_details_name.AsValue.AsText;
        MpesaDepositTrans."Source Reference" := transaction_source_details_reference.AsValue.AsText;
        MpesaDepositTrans."Source Other Details" := transaction_source_details_other_details.AsValue.AsText;

        MpesaDepositTrans."Sender Identifier Type" := transaction_sender_details_identifier_type.AsValue.AsText;
        MpesaDepositTrans."Sender Identifier" := transaction_sender_details_identifier.AsValue.AsText;
        MpesaDepositTrans."Sender Account" := transaction_sender_details_account.AsValue.AsText;
        MpesaDepositTrans."Sender Name" := transaction_sender_details_name.AsValue.AsText;
        MpesaDepositTrans."Sender Reference" := transaction_sender_details_reference.AsValue.AsText;
        MpesaDepositTrans."Sender Other Details" := transaction_sender_details_other_details.AsValue.AsText;

        MpesaDepositTrans."Receiver Identifier Type" := transaction_receiver_details_identifier_type.AsValue.AsText;
        MpesaDepositTrans."Receiver Identifier" := transaction_receiver_details_identifier.AsValue.AsText;
        MpesaDepositTrans."Receiver Account" := transaction_receiver_details_account.AsValue.AsText;
        MpesaDepositTrans."Receiver Name" := transaction_receiver_details_name.AsValue.AsText;
        MpesaDepositTrans."Receiver Reference" := transaction_receiver_details_reference.AsValue.AsText;
        MpesaDepositTrans."Receiver Other Details" := transaction_receiver_details_other_details.AsValue.AsText;

        MpesaDepositTrans."Beneficiary Identifier Type" := transaction_beneficiary_details_identifier_type.AsValue.AsText;
        MpesaDepositTrans."Beneficiary Identifier" := transaction_beneficiary_details_identifier.AsValue.AsText;
        MpesaDepositTrans."Beneficiary Account" := transaction_beneficiary_details_account.AsValue.AsText;
        MpesaDepositTrans."Beneficiary Name" := transaction_beneficiary_details_name.AsValue.AsText;
        MpesaDepositTrans."Beneficiary Reference" := transaction_beneficiary_details_reference.AsValue.AsText;
        MpesaDepositTrans."Beneficiary Other Details" := transaction_beneficiary_details_other_details.AsValue.AsText;

        MpesaDepositTrans."Transaction Amount" := amount.AsValue.AsDecimal;
        MpesaDepositTrans."Transaction Description" := transaction_description.AsValue.AsText;
        MpesaDepositTrans."Transaction Category" := category.AsValue.AsText;
        MpesaDepositTrans."Transaction Source Reference" := source_reference.AsValue.AsText;
        MpesaDepositTrans."Request Application" := request_application.AsValue.AsText;
        MpesaDepositTrans."Source Application" := source_application.AsValue.AsText;

        Evaluate(MpesaDepositTrans."Transaction Date Time", transaction_date_time.AsValue.AsText);
        MpesaDepositTrans."Transaction Date" := DT2Date(MpesaDepositTrans."Transaction Date Time");
        MpesaDepositTrans."Transaction Time" := DT2Time(MpesaDepositTrans."Transaction Date Time");
        if Payload.Get('posting_date', posting_date_time) then
            if Evaluate(UWSPostingDateTime, posting_date_time.AsValue().AsText()) then begin
                MpesaDepositTrans."UWS Posting Date" := DT2Date(UWSPostingDateTime);
                MpesaDepositTrans."UWS Posting Time" := DT2Time(UWSPostingDateTime);
            end;

        if IsLoanRepayment then begin
            // Loan Info
            BeneficiaryLoanAccount.Reset;
            BeneficiaryLoanAccount.SetRange("Loan No.", CopyStr(transaction_receiver_details_account.AsValue.AsText, 1, 20));

            BeneficiaryLoanAccount.SetLoadFields(
                "Loan No.",
                "Loan Account"
            );

            if BeneficiaryLoanAccount.FindFirst then begin
                MpesaDepositTrans."Loan No." := BeneficiaryLoanAccount."Loan No.";
                MpesaDepositTrans."Loan Account" := BeneficiaryLoanAccount."Loan Account";
                MpesaDepositTrans."Savings Account" := legacy.GetUnallocatedAccount(BeneficiaryLoanAccount."Member No.");
            end;

            MpesaDepositTrans."Transaction Type" := MpesaDepositTrans."Transaction Type"::"Loan Repayment";
        end else begin
            MpesaDepositTrans."Savings Account" := MpesaDepositTrans."Receiver Account";
            MpesaDepositTrans."Transaction Type" := MpesaDepositTrans."Transaction Type"::"Mpesa Deposit";

            BeneficiarySavingsAccount.Reset;
            BeneficiarySavingsAccount.SetRange("No.", CopyStr(MpesaDepositTrans."Savings Account", 1, 20));
            BeneficiarySavingsAccount.SetLoadFields("No.");
            if not BeneficiarySavingsAccount.FindFirst then begin
                // Search using old account no
                BeneficiarySavingsAccount.Reset;
                BeneficiarySavingsAccount.SetRange("Old Account No.", CopyStr(MpesaDepositTrans."Savings Account", 1, 20));
                BeneficiarySavingsAccount.SetLoadFields("No.");
                if BeneficiarySavingsAccount.FindFirst then begin
                    // Search using old account no
                    MpesaDepositTrans."Savings Account" := BeneficiarySavingsAccount."No.";
                end else begin
                    // Check deposit keywords
                    MobileDepositkeywordSetup.Reset;
                    if MobileDepositkeywordSetup.FindSet() then begin
                        ExitKeywordSearch := '';

                        repeat begin
                            SearchAccount := MpesaDepositTrans."Beneficiary Account".ToUpper();
                            // E.g 12345ADV
                            if MobileDepositkeywordSetup."Member Identifier Position" = MobileDepositkeywordSetup."Member Identifier Position"::Prefix then begin
                                if SearchAccount.EndsWith(MobileDepositkeywordSetup.Keyword) then begin
                                    ExitKeywordSearch := MobileDepositkeywordSetup.Keyword;
                                end;
                            end;

                            // E.g ADV12345
                            if MobileDepositkeywordSetup."Member Identifier Position" = MobileDepositkeywordSetup."Member Identifier Position"::Suffix then begin
                                if SearchAccount.StartsWith(MobileDepositkeywordSetup.Keyword) then begin
                                    ExitKeywordSearch := MobileDepositkeywordSetup.Keyword;
                                end;
                            end;
                        end until (ExitKeywordSearch <> '') or (MobileDepositkeywordSetup.Next() = 0);
                    end;

                    if ExitKeywordSearch <> '' then begin
                        MobileDepositkeywordSetup.Reset;
                        MobileDepositkeywordSetup.Get(ExitKeywordSearch);
                        // 
                        TheBeneficiaryIdentifierNo := SearchAccount.Replace(MobileDepositkeywordSetup.Keyword, '');

                        TheBeneficiary.Reset;
                        TheBeneficiary.SetRange("ID No.", TheBeneficiaryIdentifierNo);
                        TheBeneficiary.SetLoadFields("No.");
                        if TheBeneficiary.FindFirst then begin
                            if MobileDepositkeywordSetup."Product Class" = MobileDepositkeywordSetup."Product Class"::Credit then begin

                                BeneficiaryLoans.Reset;
                                BeneficiaryLoans.SetRange("Member No.", TheBeneficiary."No.");
                                BeneficiaryLoans.SetRange("Loan Product Type", MobileDepositkeywordSetup."Product Code");
                                BeneficiaryLoans.SetFilter("Total Outstanding Balance", '>0');
                                BeneficiaryLoans.SetLoadFields("Loan No.", "Loan Account");

                                if BeneficiaryLoans.FindFirst() then begin
                                    MpesaDepositTrans."Transaction Type" := MpesaDepositTrans."Transaction Type"::"Loan Repayment";
                                    MpesaDepositTrans."Loan No." := BeneficiaryLoans."Loan No.";
                                    MpesaDepositTrans."Loan Account" := BeneficiaryLoans."Loan Account";
                                    MpesaDepositTrans."Savings Account" := legacy.GetUnallocatedAccount(BeneficiaryLoans."Member No.");
                                end;
                            end;

                            if MobileDepositkeywordSetup."Product Class" = MobileDepositkeywordSetup."Product Class"::Savings then begin
                                MpesaDepositTrans."Transaction Type" := MpesaDepositTrans."Transaction Type"::"Mpesa Deposit";

                                BeneficiarySavingsAccount.Reset;
                                BeneficiarySavingsAccount.SetRange("Member No.", TheBeneficiary."No.");
                                BeneficiarySavingsAccount.SetRange("Product Type", MobileDepositkeywordSetup."Product Code");
                                BeneficiarySavingsAccount.SetLoadFields("No.");
                                if BeneficiarySavingsAccount.FindFirst then begin
                                    MpesaDepositTrans."Savings Account" := BeneficiarySavingsAccount."No.";
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        MpesaDepositTrans."Transaction Status" := MpesaDepositTrans."Transaction Status"::CONFIRMED;
        MpesaDepositTrans.Posted := false;
    end;

    procedure LogLoanBalanceEnquiry(
        APIRequestID: Text;
        IdentifierType: Text;
        Identifier: Text;
        LoanNumber: Text;
        theMember: Record Members
    )
    var
        SkyTrans: Record "Sky M-Banking Transactions";


        theLoan: Record Loans;
    begin
        // Log the transaction
        SkyTrans.Init;

        SkyTrans."API Request ID" := APIRequestID;
        SkyTrans."Originator ID" := APIRequestID;

        //SkyTrans."Transaction ID" := CreateGuid();
        SkyTrans."Transaction ID" := APIRequestID;

        SkyTrans."Identifier Type" := IdentifierType;
        SkyTrans."Identifier" := Identifier;


        theLoan.Reset;
        theLoan.SetRange("Loan No.", LoanNumber);
        theLoan.SetLoadFields("Loan No.", "Loan Account", "Member No.");

        if theLoan.FindFirst then begin
            SkyTrans."Loan No." := theLoan."Loan No.";
            SkyTrans."Loan Account" := theLoan."Loan Account";
        end;
        theMember.Get(theLoan."Member No.");

        SkyTrans."Savings Account" := GetMemberUnallocatedAcc(theMember);

        SkyTrans."Transaction Type" := "Sky M-Banking Trans Types"::"Loan Balance Enquiry";
        SkyTrans."Transaction Date Time" := CurrentDateTime;
        SkyTrans."Transaction Date" := Today;
        SkyTrans."Transaction Time" := Time;
        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::CONFIRMED;
        SkyTrans.Posted := false;
        // SkyTrans.Reversed := false;

        SkyTrans.Insert(true);
    end;

    procedure LogLoanMiniStatement(
        APIRequestID: Text;
        IdentifierType: Text;
        Identifier: Text;
        LoanNumber: Text;
        theMember: Record Members
    )
    var
        SkyTrans: Record "Sky M-Banking Transactions";


        theLoan: Record Loans;
    begin
        // Log the transaction
        SkyTrans.Init;

        SkyTrans."API Request ID" := APIRequestID;
        SkyTrans."Originator ID" := APIRequestID;

        SkyTrans."Transaction ID" := CreateGuid();

        SkyTrans."Identifier Type" := IdentifierType;
        SkyTrans."Identifier" := Identifier;

        SkyTrans."Savings Account" := GetMemberUnallocatedAcc(theMember);

        theLoan.Reset;
        theLoan.SetRange("Loan No.", LoanNumber);

        if theLoan.FindFirst then begin
            SkyTrans."Loan No." := theLoan."Loan No.";
            SkyTrans."Loan Account" := theLoan."Loan Account";
        end;


        SkyTrans."Transaction Type" := "Sky M-Banking Trans Types"::"Loan Mini-Statement";
        SkyTrans."Transaction Date Time" := CurrentDateTime;
        SkyTrans."Transaction Date" := Today;
        SkyTrans."Transaction Time" := Time;
        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::CONFIRMED;
        SkyTrans.Posted := false;
        // SkyTrans.Reversed := false;

        SkyTrans.Insert(true);
    end;

    procedure LogLoanFullStatement(
        APIRequestID: Text;
        IdentifierType: Text;
        Identifier: Text;
        LoanNumber: Text;
        theMember: Record Members
    )
    var
        SkyTrans: Record "Sky M-Banking Transactions";


        theLoan: Record Loans;
    begin
        // Log the transaction
        SkyTrans.Init;

        SkyTrans."API Request ID" := APIRequestID;
        SkyTrans."Originator ID" := APIRequestID;

        SkyTrans."Transaction ID" := CreateGuid();

        SkyTrans."Identifier Type" := IdentifierType;
        SkyTrans."Identifier" := Identifier;

        SkyTrans."Savings Account" := GetMemberUnallocatedAcc(theMember);

        theLoan.Reset;
        theLoan.SetRange("Loan No.", LoanNumber);

        theLoan.SetLoadFields("Loan No.", "Loan Account");

        if theLoan.FindFirst then begin
            SkyTrans."Loan No." := theLoan."Loan No.";
            SkyTrans."Loan Account" := theLoan."Loan Account";
        end;

        SkyTrans."Transaction Type" := "Sky M-Banking Trans Types"::"Loan Full-Statement";
        SkyTrans."Transaction Date Time" := CurrentDateTime;
        SkyTrans."Transaction Date" := Today;
        SkyTrans."Transaction Time" := Time;
        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::CONFIRMED;
        SkyTrans.Posted := false;
        // SkyTrans.Reversed := false;

        SkyTrans.Insert(true);
    end;


    procedure ProcessLoanRepayment(var SkyTransactionBuffer: Record "Sky M-Banking Transactions"): Boolean
    var
        Loans: record Loans;
        ProductFactory: record "Product Setup";
        CreditAccounts: record "Credit Accounts";
    begin
        // Get loan account
        if (SkyTransactionBuffer."Loan Account" = '') or not (CreditAccounts.get(SkyTransactionBuffer."Loan Account")) then begin
            SkyTransactionBuffer."Try Posting Count" := SkyTransactionBuffer."Try Posting Count" + 1;
            SkyTransactionBuffer."Needs Change" := true;
            SkyTransactionBuffer."Needs Change Reason" := 'Loan account not found';
            SkyTransactionBuffer.Modify(true);
            exit(false);
        end;
        // get the loan
        Loans.Reset;
        Loans.SetRange("Loan No.", SkyTransactionBuffer."Loan No.");
        // Loans.SetLoadFields("Daily Interest", "Loan Product Type");
        // Loans.SetAutoCalcFields("Daily Interest");
        if Loans.FindFirst then begin
            // Post Loan Interests
            // Loans.CALCFIELDS("Daily Interest");
            //if Loans."Daily Interest" > 0 then begin
            if (not productFactory.GET(Loans."Loan Product Type")) then begin
                SkyTransactionBuffer."Try Posting Count" := SkyTransactionBuffer."Try Posting Count" + 1;
                SkyTransactionBuffer."Needs Change" := true;
                SkyTransactionBuffer."Needs Change Reason" := 'Loan product not found / loan interest account not set';
                SkyTransactionBuffer.Modify(true);
                exit(false);
            end;

            //end;
            exit(true);
        end else begin
            SkyTransactionBuffer."Try Posting Count" := SkyTransactionBuffer."Try Posting Count" + 1;
            SkyTransactionBuffer."Needs Change" := true;
            SkyTransactionBuffer."Needs Change Reason" := 'Loan not found';
            SkyTransactionBuffer.Modify(true);
            exit(false);
        end;
    end;
    // Get Member primary fosa acc
    procedure GetMemberFosaAcc(Member: record Members): text
    var
        SavingsAccounts: record "Savings Accounts";
        FosaProduct: Record "Product Setup";
    begin
        FosaProduct.Reset;
        FosaProduct.SetRange("Product Category", FosaProduct."Product Category"::"Ordinary Savings");
        FosaProduct.SetLoadFields("Product ID");
        if not FosaProduct.FindFirst then begin
            exit('');
        end;

        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", Member."No.");
        //SavingsAccounts.SETRANGE("Product Type", FosaProduct."Product ID");
        SavingsAccounts.SetFilter("Transactional Mobile No", '<>%1', '');
        SavingsAccounts.SetLoadFields("No.");
        if SavingsAccounts.FINDFIRST then
            exit(SavingsAccounts."No.")
        else
            exit('');
    end;

    procedure GetMemberUnallocatedAcc(Member: record Members): text
    var
        SavingsAccounts: record "Savings Accounts";
        FosaProduct: Record "Product Setup";
    begin
        FosaProduct.Reset;
        FosaProduct.SetRange("Product Category", FosaProduct."Product Category"::"Unallocated Fund");
        FosaProduct.SetLoadFields("Product ID");
        if not FosaProduct.FindFirst then begin
            exit('');
        end;

        SavingsAccounts.RESET;
        SavingsAccounts.SetRange("Member No.", Member."No.");
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Unallocated Fund");
        SavingsAccounts.SetLoadFields("No.");
        if SavingsAccounts.FINDFIRST then
            exit(SavingsAccounts."No.")
        else
            exit('');
    end;
    // Get Member primary bosa acc
    procedure GetMemberDepositsAcc(Member: record Members): text
    var
        SavingsAccounts: record "Savings Accounts";
        FosaProduct: Record "Product Setup";
    begin
        FosaProduct.Reset;
        FosaProduct.SetRange("Product Category", FosaProduct."Product Category"::"Deposit Contribution");
        FosaProduct.SetLoadFields("Product ID");
        if not FosaProduct.FindFirst then begin
            exit('');
        end;

        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", Member."No.");
        SavingsAccounts.SETRANGE("Product Type", FosaProduct."Product ID");

        SavingsAccounts.SetLoadFields("No.");
        if SavingsAccounts.FINDFIRST then
            exit(SavingsAccounts."No.")
        else
            exit('');
    end;

    // Get Member primary biashara acc
    procedure GetMemberBiasharaAcc(Member: record Members): text
    var
        SavingsAccounts: record "Savings Accounts";
        FosaProduct: Record "Product Setup";
    begin
        FosaProduct.Reset;
        // FosaProduct.SetRange("Product Category", FosaProduct."Product Category"::"Biashara Account");
        FosaProduct.SetRange("Product ID", '011');
        // FosaProduct.SetRange("Auto Open Account", true);

        FosaProduct.SetLoadFields("Product ID");
        if not FosaProduct.FindFirst then begin
            exit('');
        end;

        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", Member."No.");
        SavingsAccounts.SETRANGE("Product Type", FosaProduct."Product ID");

        SavingsAccounts.SetLoadFields("No.");
        if SavingsAccounts.FINDFIRST then
            exit(SavingsAccounts."No.")
        else
            exit('');
    end;
    //

    // Get Member business loans deposit acc
    procedure GetMemberBusinessDepositsAcc(Member: record Members): text
    var
        SavingsAccounts: record "Savings Accounts";
        FosaProduct: Record "Product Setup";
    begin
        FosaProduct.Reset;
        FosaProduct.SetRange("Product Category", FosaProduct."Product Category"::"Business");
        FosaProduct.SetLoadFields("Product ID");
        if not FosaProduct.FindFirst then begin
            exit('');
        end;

        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", Member."No.");
        SavingsAccounts.SETRANGE("Product Type", FosaProduct."Product ID");

        SavingsAccounts.SetLoadFields("No.");
        if SavingsAccounts.FINDFIRST then
            exit(SavingsAccounts."No.")
        else
            exit('');
    end;



    // Mobile loan limit 
    procedure GetLoansQualifyAmount(MemberNo: Code[20]; ProductID: Code[10]) QualifiedAmount: Decimal
    var
        Members: Record Members;
        PFac: Record "Product Setup";
        ProdFac: Record "Product Setup";
        amtQualified: Decimal;
        saccoAccount: Record "Savings Accounts";
        STOAmount: Decimal;
        SalAvg: Decimal;
        LoanRec: Decimal;
        SalaryAmount: Decimal;
        GenSetUp: Record "Sacco SetUp";
        LoanApp: Record Loans;
        OrdinaryAccounts: Record "Savings Accounts";
        SalaryLines: Record "Salary Lines";
        SalaryHeader: Record "Salary Header";
        Loans: Record Loans;
        MobileLoanBuffer: record "Sky Mobile Loans";
        TotalExisting: decimal;
        MinDateProduct: Date;
        MinDateMember: Date;
        Remark: Text[200];
        MLoanLimit: Record "Mobile Loan Limit";
        SkyIntergration: Codeunit "Sky Mobile Banking Integration";
    begin
        TotalExisting := 0;
        QualifiedAmount := 0;

        if not GenSetUp.GET then begin
            QualifiedAmount := 0;
            EXIT(QualifiedAmount);
        end;
        if not ProdFac.GET(ProductID) then begin
            QualifiedAmount := 0;
            EXIT(QualifiedAmount);
        end;

        // Check mobile loan buffer for unposted loans application
        MobileLoanBuffer.Reset;
        MobileLoanBuffer.SetRange("Member No.", MemberNo);
        MobileLoanBuffer.SetRange(Posted, false);
        MobileLoanBuffer.SetLoadFields("Entry No");
        if MobileLoanBuffer.FindFirst then begin
            QualifiedAmount := 0;
            exit(QualifiedAmount);
        end;

        ProdFac.get(ProductID);


        if ProdFac."Loan Type" = ProdFac."Loan Type"::Mavuno then begin
            SkyIntergration.GetDividendLoanQualifiedAmount(legacy.GetDepositAccounts(MemberNo), ProdFac."Product ID", QualifiedAmount, Remark);
            exit(QualifiedAmount);
        end else begin

            saccoAccount.Reset();
            saccoAccount.SetRange("Member No.", MemberNo);
            saccoAccount.SetRange("Product Category", saccoAccount."Product Category"::"Ordinary Savings");
            saccoAccount.SetFilter("Transactional Mobile No", '<>%1', '');
            if saccoAccount.FindFirst() then begin

                MLoanLimit.Reset();
                MLoanLimit.SetRange("Account No.", saccoAccount."No.");
                MLoanLimit.SetRange("Loan Type", ProductID);
                if MLoanLimit.FindFirst() then begin
                    QualifiedAmount := MLoanLimit.Amount;
                    exit(QualifiedAmount)
                end;
            end;
        end;


        // Check unposted loans with outstanding balance
        LoanApp.RESET;
        LoanApp.SETRANGE("Member No.", MemberNo);
        LoanApp.SETRANGE(Posted, false);
        LoanApp.SETRANGE("Loan Product Type", ProductID);
        LoanApp.SETFILTER("Outstanding Principal", '>0');
        LoanApp.SetLoadFields("Loan No.", Posted);

        if LoanApp.FindFirst then begin
            LoanApp.Posted := true;
            LoanApp.Modify;

            QualifiedAmount := 0;
            EXIT(QualifiedAmount);
        end;

        amtQualified := 0;
        STOAmount := 0;
        SalAvg := 0;
        LoanRec := 0;
        SalaryAmount := 0;
        exit(amtQualified);
    end;

    procedure ComputeSTODeductions(AccountNo: Code[20]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjStandingOrders: Record "Standing Order Header";
    begin
        //GET STOS
        AmountToDeduct := 0;
        ObjStandingOrders.RESET;
        ObjStandingOrders.SETCURRENTKEY(Code, "Source Account No.");
        ObjStandingOrders.SETRANGE("Source Account No.", AccountNo);
        ObjStandingOrders.SETRANGE(Status, ObjStandingOrders.Status::Approved);
        //ObjStandingOrders.SETRANGE("Income Type",'');
        ObjStandingOrders.SetLoadFields(Amount);
        IF ObjStandingOrders.FINDSET THEN BEGIN
            REPEAT
                AmountToDeduct += ObjStandingOrders.Amount;
            UNTIL ObjStandingOrders.NEXT = 0;
        END;
        EXIT(AmountToDeduct);
    end;

    procedure SalaryQualification(AccountNo: Code[20]): Decimal
    var
        SalAvg: Decimal;
        MonthI: Decimal;
        MonthII: Decimal;
        MonthIII: Decimal;
        SalStart: Date;
        SalStartII: Date;
        SalStartIII: Date;
        SalBufferI: Record "Salary Lines";
        SalBufferII: Record "Salary Lines";
        SalBuffer: Record "Salary Lines";
        SalBufferIII: Record "Salary Lines";
    begin
        SalAvg := 0;
        MonthI := 0;
        MonthII := 0;
        MonthIII := 0;
        SalStart := 0D;
        SalStartII := 0D;
        SalStartIII := 0D;

        SalBuffer.RESET;
        SalBuffer.SETCURRENTKEY(SalBuffer.Date);
        SalBuffer.SETRANGE(SalBuffer."Account No.", AccountNo);
        SalBuffer.SETRANGE("Posting Date", (CALCDATE('-3M', CALCDATE('-CM', TODAY))), TODAY);
        SalBuffer.SETFILTER(Amount, '>0');
        SalBuffer.SETRANGE(Posted, TRUE);
        IF SalBuffer.FIND('-') THEN BEGIN
            SalStart := SalBuffer."Posting Date";
        END;
        IF SalStart = 0D THEN SalStart := CALCDATE('1M', TODAY);
        SalStart := CALCDATE('-CM', SalStart);
        SalStartII := CALCDATE('1M', SalStart);
        SalStartIII := CALCDATE('2M', SalStart);
        MonthI := 0;
        SalBufferI.RESET;
        SalBufferI.SETRANGE(SalBufferI."Account No.", AccountNo);
        SalBufferI.SETRANGE("Posting Date", SalStart, CALCDATE('CM', SalStart));
        SalBufferI.SETFILTER(Amount, '>0');
        SalBufferI.SETRANGE(Posted, TRUE);
        SalBufferI.CALCSUMS(Amount);
        MonthI := SalBufferI.Amount;
        // MESSAGE(FORMAT(MonthI);

        MonthII := 0;
        SalBufferII.RESET;
        SalBufferII.SETRANGE(SalBufferII."Account No.", AccountNo);
        SalBufferII.SETRANGE("Posting Date", SalStartII, CALCDATE('CM', SalStartII));
        SalBufferII.SETFILTER(Amount, '>0');
        SalBufferII.SETRANGE(Posted, TRUE);
        SalBufferII.CALCSUMS(Amount);
        MonthII := SalBufferII.Amount;
        MonthIII := 0;
        SalBufferIII.RESET;
        SalBufferIII.SETRANGE(SalBufferIII."Account No.", AccountNo);
        SalBufferIII.SETRANGE("Posting Date", SalStartIII, CALCDATE('CM', SalStartIII));
        SalBufferIII.SETFILTER(Amount, '>0');
        SalBufferIII.SETRANGE(Posted, TRUE);
        SalBufferIII.CALCSUMS(Amount);
        MonthIII := SalBufferIII.Amount;
        // MESSAGE('%1 and %2 and %3',MonthI,MonthII,MonthIII);
        IF (MonthI > MonthII) AND (MonthII > 0) THEN
            MonthI := MonthII;

        IF (MonthI > MonthIII) AND (MonthIII > 0) THEN
            MonthI := MonthIII;
        IF (MonthI <= 0) then
            MonthI := 0;

        EXIT(MonthI);
    end;

    // Create Mobile Loan account and buffer
    procedure BufferLoanApplication(
        MemberNo: Code[50];
        LoanProductID: Code[50];
        RequestedAmount: Decimal;
        SourceReference: Text;
        SourceApplication: Text;
        var LoanSerial: Text;
        MobileLoanPurpose: Text;
        Installements: Text[5];
        BankNameTxt: Text;
        AccountNumberTxt: Text;
        BranchTxt: Text;
        BeneficiaryMobileNumberTxt: Text;
        HasMyDeposits: Boolean;
        HasGuaranteedByOtherMembers: boolean;
        HasHolidaySavings: Boolean
    ): Boolean
    var
        MobileLoanBuffer: record "Sky Mobile Loans";
        LoanProduct: Record "Product Setup";
        TheMember: record Members;
        msg: Text;
        EntryNo: Integer;
        SavAcc: record "savings accounts";
        BankAccounts: record "HR Employee Bank Accounts";
        BUser: Record "User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
    begin
        //LoanSerial := '';
        // check for duplicate Applications

        // MobileLoanBuffer.RESET;
        // MobileLoanBuffer.SETRANGE("Member No.", MemberNo);
        // MobileLoanBuffer.SETRANGE(Deactivated, FALSE);
        // MobileLoanBuffer.SETRANGE("Loan Product Type", LoanProductType);
        // MobileLoanBuffer.SetRange(Status, MobileLoanBuffer.Status::Pending);
        // if MobileLoanBuffer.FIND('-') then begin
        //     exit(MobileLoanBuffer."Loan No.");
        // end;

        TheMember.Get(MemberNo);

        SavAcc.Reset;
        SavAcc.SetRange("Member No.", MemberNo);
        SavAcc.SetFilter("Transactional Mobile No", '<>%1', '');
        SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Ordinary Savings");
        SavAcc.FindFirst;

        LoanProduct.Get(LoanProductID);

        MobileLoanBuffer.Init;
        MobileLoanBuffer."Entry No" := CreateGuid();
        MobileLoanBuffer."Member No." := MemberNo;
        MobileLoanBuffer."Account No" := SavAcc."No.";
        MobileLoanBuffer."Loan Product Type" := LoanProductID;
        MobileLoanBuffer.Installments := Installements;
        MobileLoanBuffer."Requested Amount" := RequestedAmount;
        MobileLoanBuffer.Amount := RequestedAmount;
        MobileLoanBuffer."Approved Amount" := RequestedAmount;
        MobileLoanBuffer."Session ID" := SourceReference;
        MobileLoanBuffer."Source Application" := SourceApplication;
        MobileLoanBuffer.Status := MobileLoanBuffer.Status::Approved;
        MobileLoanBuffer.Posted := false;
        MobileLoanBuffer."Time Entered" := Time;
        MobileLoanBuffer."Date Entered" := Today;
        MobileLoanBuffer."Loan No." := '';
        MobileLoanBuffer."Loan Purpose" := MobileLoanPurpose;
        MobileLoanBuffer."Account Name" := TheMember.Name;
        MobileLoanBuffer."Use My Deposits" := HasMyDeposits;
        MobileLoanBuffer."Guaranteed By Other Members" := HasGuaranteedByOtherMembers;
        MobileLoanBuffer."Use Holiday Savings" := HasHolidaySavings;
        //MobileLoanBuffer."Employer Code" := TheMember."Employer Code";

        // LoanProduct.SetRange("Product ID", LoanProductID);
        // MobileLoanBuffer."Needs Guarantors" := LoanProduct."Mobile Loan Req. Guar.";
        // if MobileLoanBuffer."Needs Guarantors" then begin
        //     LoanProduct.TestField("Mobile Min. Guarantors");
        //     MobileLoanBuffer.Status := MobileLoanBuffer.Status::"Pending Guarantors";
        //     MobileLoanBuffer."Expected Guarantors" := GetNumberOfGuarantors(LoanProduct."Product ID", RequestedAmount);
        // end;

        if MobileLoanBuffer.Insert(true) then begin
            // if LoanProduct."Mobile Loan Req. Guar." then begin

            //     msg := 'Dear member, To add guarantors to your ' + MobileLoanBuffer."Loan Name" + ' request of KES ' + Format(MobileLoanBuffer.Amount) + ', Please dial *882# or use our Mobile App.' +
            //           'Login > Loans > Add / Remove Guarantors. ' +
            //           'REF: ' + MobileLoanBuffer."Loan No.";
            //     SendSMS.SendSms(SMSSource::SkyMobile, TheMember."Phone No.", msg, Format(MobileLoanBuffer."Loan No."), '', true, 220, false, 'CBS', MobileLoanBuffer."Loan No.", 'CBS');

            //     msg := 'Minimum required guarantors is ' + Format(MobileLoanBuffer."Expected Guarantors") + '. In the event their total deposits won''t be sufficient, you''ll'
            //     + ' be required to add one or more.REF: ' + MobileLoanBuffer."Loan No.";
            //     SendSMS.SendSms(SMSSource::SkyMobile, TheMember."Phone No.", msg, Format(MobileLoanBuffer."Loan No."), '', true, 220, false, 'CBS', MobileLoanBuffer."Loan No.", 'CBS');

            // end;
            if LoanProduct."Is Mobile" then begin
                CreateLoanRecord(MobileLoanBuffer, LoanProductID);

                PostSkyLoanApplicationCharge(MobileLoanBuffer."Loan No.", JTemplate, JBatch, MobileLoanBuffer."Entry No");

            end else begin
                CreateLoanPortalRecord(MobileLoanBuffer, LoanProductID);

                MobileLoanBuffer.Status := MobileLoanBuffer.Status::"Pending Guarantors";

                MobileLoanBuffer.Modify();

                if not BUser.Get(UserId()) then
                    if not BUser.Get('SKYPORTAL') then
                        Error('No User Setup found for %1. Please configure User Setup.', UserId());

                BUser.TESTFIELD("CashRec Journal Batch");
                BUser.TESTFIELD("CashRec Journal Template");

                JTemplate := BUser."CashRec Journal Template";
                JBatch := BUser."CashRec Journal Batch";


                BankAccounts.Init();
                BankAccounts."Loan No." := MobileLoanBuffer."Loan No.";
                BankAccounts."Bank Name" := BankNameTxt;
                BankAccounts."Disbursement Account No." := AccountNumberTxt;
                BankAccounts."Branch Name" := BranchTxt;
                if BankNameTxt <> '' then
                    BankAccounts."Mode of Disbursement" := BankAccounts."Mode of Disbursement"::Cheque
                else
                    BankAccounts."Mode of Disbursement" := BankAccounts."Mode of Disbursement"::"Mobile Money";
                //BankAccounts."Disbursement Account No." := BeneficiaryMobileNumberTxt;
                BankAccounts.Insert(true);

                PostSkyLoanApplicationCharge(MobileLoanBuffer."Loan No.", JTemplate, JBatch, MobileLoanBuffer."Entry No");
            end;

            LoanSerial := Format(MobileLoanBuffer."Loan No.");
            //if CreateLoanRecord(MobileLoanBuffer, LoanProductID) then
            exit(true)
            //else
            //exit(false);
        end else
            exit(false);
    end;
    // Create applied loan record
    procedure CreateLoanRecord(var MobileLoanBuffer: Record "Sky Mobile Loans"; LoanProdID: code[50]): Boolean
    var
        Loans: Record Loans;
        ProductFactory: Record "Product Setup";
        CreditAccounts: record "Credit Accounts";
        NoSeries: record "No. Series";
        LoanNo: Code[50];
        Members: Record Members;
        UserSetUp: Record "User Setup";
        InstallmentFrequency: Text;
        InstallmentPeriod: DateFormula;
        Installements: Integer;
        BUser: Record "User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        MLimit: Record "Mobile Loan Limit";
    begin
        //InstallmentPeriod := '';
        InstallmentFrequency := '';
        ProductFactory.get(LoanProdID);
        Members.get(MobileLoanBuffer."Member No.");
        UserSetUp.get(UserId);

        Loans.Init();
        Loans."Loan No." := '';
        if ProductFactory."Is Mobile" then 
            Loans."Mobile Loan" := true;
        Loans.validate("Member No.", MobileLoanBuffer."Member No.");
        Loans."Member Name" := Members.Name;
        Loans."Interest Calculation Method" := ProductFactory."Interest Calculation Method";
        Loans.Validate("Loan Product Type", LoanProdID);
        //if MobileLoanBuffer.Installments <> '' then
        Evaluate(Installements, MobileLoanBuffer.Installments);
        //else
        //    Installements := ProductFactory."Default Installments";
        Loans.Installments := Installements;
        Loans."Loan Product Type Name" := ProductFactory."Description";
        Loans."Purpose of Loan" := MobileLoanBuffer."Loan Purpose";
        Loans."Annual Interest %" := ProductFactory."Interest Rate (Min.)";
        Loans."Application Date" := Today;
        Loans."Disbursement Date" := Today;
        Loans."Approved Amount" := MobileLoanBuffer.Amount;
        Loans."Staff No" := Members."Payroll/Staff No.";
        Loans."Requested Amount" := MobileLoanBuffer.Amount;
        Loans."Approved Amount" := MobileLoanBuffer.Amount;
        Loans."Disbursement Account No" := MobileLoanBuffer."Account No";
        Loans.Status := Loans.Status::Approved;
        Loans."Captured By" := UpperCase(UserId);
        Loans."Global Dimension 1 Code" := Members."Global Dimension 1 Code";
        Loans."Booking Branch" := Members."Global Dimension 2 Code";
        //Loans."Employer Code" := MobileLoanBuffer."Employer Code";
        Loans."ID No." := Members."ID No.";

        Loans.Validate("Disbursement Date");
        Loans.Validate("Approved Amount");

        if Loans.Insert(true) then begin
            MobileLoanBuffer."Loan No." := Loans."Loan No.";
            //MobileLoanBuffer."Interest Recoverd Upfront" := ProductFactory."Interest Recovered Upfront";
            if (ProductFactory."Mobile Min. Guarantors" > 0) or (ProductFactory."Appraise Deposits") then begin
                MobileLoanBuffer."Needs Guarantors" := true;
                MobileLoanBuffer.Status := MobileLoanBuffer.Status::"Pending Guarantors";
                MobileLoanBuffer."Expected Guarantors" := ProductFactory."Mobile Min. Guarantors";
            end else begin
                MobileLoanBuffer.Status := MobileLoanBuffer.Status::Approved;
            end;

            MobileLoanBuffer.Modify(true);

            if not BUser.Get(UserId()) then
                if not BUser.Get('SKYPORTAL') then
                    Error('No User Setup found for %1. Please configure User Setup.', UserId());

            BUser.TESTFIELD("CashRec Journal Batch");
            BUser.TESTFIELD("CashRec Journal Template");

            JTemplate := BUser."CashRec Journal Template";
            JBatch := BUser."CashRec Journal Batch";

            if MobileLoanBuffer."Needs Guarantors" then begin
                Loans.Status := Loans.Status::"Pending Guarantors";
                Loans.Modify();
            end else
                PostLoan(Loans."Loan No.", JTemplate, JBatch, MobileLoanBuffer."Entry No");


            exit(true);
        end else begin
            exit(false);
        end;
    end;


    procedure CreateLoanPortalRecord(var MobileLoanBuffer: Record "Sky Mobile Loans"; LoanProdID: code[50]): Boolean
    var
        Portal: Record "Portal Loans";
        ProductFactory: Record "Product Setup";
        Members: Record Members;
        Installements: Integer;
        MLimit: Record "Mobile Loan Limit";
        msg: Text;
        MemberActivities: Codeunit "Member Activities";
        Sky: Codeunit "Sky MBanking";

        LoanSecurity: Record "Loan Security";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Committed: Decimal;
        Available: Decimal;
        FreeShares: Decimal;

        MemberAccounts: Record "Savings Accounts";
    begin
        ProductFactory.get(LoanProdID);
        Members.get(MobileLoanBuffer."Member No.");

        Portal.Init();
        Portal.Validate("Member No.", MobileLoanBuffer."Member No.");
        Evaluate(Installements, MobileLoanBuffer.Installments);

        Portal."Loan Period" := Installements;
        Portal."Needs Guarantors" := true;
        Portal.Status := Portal.Status::"Pending Guarantor Action";

        Portal.validate("Account No", MobileLoanBuffer."Account No");
        Portal.Validate("Loan Product Type", MobileLoanBuffer."Loan Product Type");
        Portal.Date := CurrentDateTime;
        Portal."Requested Amount" := MobileLoanBuffer.Amount;
        Portal."Requested Amount" := MobileLoanBuffer.Amount;
        Portal."Requested Amount" := MobileLoanBuffer.Amount;
        Portal."Approved Amount" := MobileLoanBuffer.Amount;
        Portal."Source Application" := MobileLoanBuffer."Source Application";
        Portal."Session ID" := MobileLoanBuffer."Session ID";
        Portal."Loan Purpose" := MobileLoanBuffer."Loan Purpose";
        Portal."Guaranteed By Other Members" := MobileLoanBuffer."Guaranteed By Other Members";
        Portal."Use My Deposits" := MobileLoanBuffer."Use My Deposits";
        Portal."Use Holiday Savings" := MobileLoanBuffer."Use Holiday Savings";

        if Portal.Insert(true) then begin

            msg :=
            'Dear ' + Sky.FirstName(Members.Name) + ', your loan application has been received successfully. ' +
            ProductFactory.Description + ' of KES ' + Format(MobileLoanBuffer.Amount) + '. ' +
            'Please proceed to add your loan guarantors/security on the Mobile Banking platform. ' +
            'Ref: ' + Format(Portal."Application No.") +
            ' Date: ' + Format(Today);

            msg := CopyStr(msg, 1, 250);

            MemberActivities.SendSms(
                SMSSource::SkyMobile,
                Members."Mobile Phone No.",
                msg,
                Format(Portal."Application No."),
                '',
                true,
                false
            );

            MobileLoanBuffer."Loan No." := Portal."Application No.";

            MobileLoanBuffer."Loan No." := Portal."Application No.";
            if (ProductFactory."Mobile Min. Guarantors" > 0) or (ProductFactory."Appraise Security") then begin
                MobileLoanBuffer."Needs Guarantors" := true;
                MobileLoanBuffer.Status := MobileLoanBuffer.Status::"Pending Guarantors";
                MobileLoanBuffer."Expected Guarantors" := ProductFactory."Mobile Min. Guarantors";
            end;

            FreeShares := 0;
            MemberAccounts.Reset();
            MemberAccounts.SetRange("Member No.", Members."No.");
            MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Deposit Contribution");
            if MemberAccounts.FindFirst() then begin

                LoanSecurity.CalculateAvailableShares(MemberAccounts, DepAmt, GuaranteedInApplication, Committed, Available, true);
                FreeShares := Available;

                if FreeShares >= Portal."Requested Amount" then begin
                    MobileLoanBuffer."Needs Guarantors" := false;
                    MobileLoanBuffer.Status := MobileLoanBuffer.Status::Appraisal;
                    MobileLoanBuffer."Expected Guarantors" := 0;
                end;

            end;

            exit(true);
        end else begin
            exit(false);
        end;
    end;

    /*

                MobileLoan.Reset;
                MobileLoan.SetRange("Entry No", EntryNo);
                MobileLoan.SetRange(Status, MobileLoan.Status::Pending);
                MobileLoan.SetRange(Posted, false);
                if MobileLoan.FindFirst then begin
                    Priority := 201;
                    LoanProduct.Get(MobileLoan."Loan Product Type");
                    if LoanProduct."USSD Product Name" = '' then
                        LoanProduct."USSD Product Name" := LoanProduct.Description;

                    SavAcc.Reset;
                    SavAcc.SetRange("No.", MobileLoan."Account No");
                    if SavAcc.FindFirst then begin
                        if Customer.get(SavAcc."Member No.") then begin
                            if Customer.Blocked <> Customer.Blocked::" " then begin

                                Customer.Blocked := Customer.BLocked::" ";
                                Customer.Modify;
                            end;


                            if MobileLoan."Loan Period" > LoanProduct."Default Installments" then begin

                                Remark := 'Maximum Installments for this loan is ' + Format(LoanProduct."Default Installments");

                                msg := 'Dear ' + Sky.FirstName(SavAcc.name) + ', Your ' + LoanProduct."USSD Product Name" + ' request of KES ' + Format(MobileLoan.Amount) + 'has failed. ' + Remark;
                                MobileLoan.Remarks := Remark;
                                MobileLoan.Status := MobileLoan.Status::Failed;
                                MobileLoan.Posted := true;
                                MobileLoan."Date Posted" := CurrentDatetime;
                                MobileLoan.Remark := msg;
                                Sky.SendSms(Source::SkyMobile, MobileLoan."Telephone No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                                MobileLoan.Modify;
                                Continue := false;
                            end;
                        end;

                        MemberNo := SavAcc."Member No.";
                        Continue := true;
                        ClearOldest := false;
                        RunningAmount := 0;
                        Members.Get(MemberNo);
                        Remark := '';
                        QualAmt := 0;
                        LoanProduct.Get(MobileLoan."Loan Product Type");


                        if LoanProduct."Product ID" = 'L15' then
                            GetDividendLoanQualifiedAmount(SavAcc."No.", LoanProduct."Product ID", QualAmt, Remark)
                        else
                            GetLoanQualifiedAmount(SavAcc."No.", LoanProduct."Product ID", QualAmt, Remark);

                        if Remark <> '' then begin
                            msg := 'Dear ' + Sky.FirstName(SavAcc.name) + ', Your ' + LoanProduct."USSD Product Name" + ' request of KES ' + Format(MobileLoan.Amount) + 'has failed. ' + Remark;
                            MobileLoan.Remarks := Remark;
                            MobileLoan.Status := MobileLoan.Status::Failed;
                            MobileLoan.Posted := true;
                            MobileLoan."Date Posted" := CurrentDatetime;
                            MobileLoan.Remark := msg;
                            Sky.SendSms(Source::SkyMobile, MobileLoan."Telephone No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                            MobileLoan.Modify;
                            Continue := false;
                        end;



                        if Continue then begin
                            if MobileLoan."Requested Amount" > QualAmt then begin
                                msg := 'Your ' + LoanProduct."USSD Product Name" + ' request has failed, You only qualify for KES ' + Format(QualAmt);
                                MobileLoan.Remarks := 'Member Qualifies for KES ' + Format(QualAmt) + ' only';
                                MobileLoan.Status := MobileLoan.Status::Failed;
                                MobileLoan.Posted := true;
                                MobileLoan."Date Posted" := CurrentDatetime;
                                MobileLoan.Remark := msg;
                                Sky.SendSms(Source::SkyMobile, MobileLoan."Telephone No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                                MobileLoan.Modify;
                                Continue := false;
                            end;
                        end;

                        if (Continue) then begin //ez changes for new product
                            Loans.Reset;
                            Loans.SetRange("Member No.", SavAcc."Member No.");
                            Loans.SetRange("Loan Product Type", MobileLoan."Loan Product Type");
                            Loans.SetFilter("Total Outstanding Balance", '>0');
                            Loans.SetAutoCalcFields("Total Outstanding Balance");
                            if Loans.FindFirst() then begin
                                if Loans."Total Outstanding Balance" > MobileLoan."Requested Amount" then begin
                                    msg := 'Your ' + LoanProduct."USSD Product Name" + ' request has failed, You have an outstanding bal KES ' + Format(Loans."Total Outstanding Balance");
                                    MobileLoan.Remarks := 'Member has exisiting loan of KES ' + Format(Loans."Total Outstanding Balance") + ' only';
                                    MobileLoan.Status := MobileLoan.Status::Failed;
                                    MobileLoan.Posted := true;
                                    MobileLoan."Date Posted" := CurrentDatetime;
                                    MobileLoan.Remark := msg;
                                    Sky.SendSms(Source::SkyMobile, MobileLoan."Telephone No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                                    MobileLoan.Modify;
                                    Continue := false;
                                end;
                            end;
                        end;


                        MaxLoan := QualAmt;

                        begin
                            if Continue then begin
                                if SavAcc.Status <> SavAcc.Status::Active then begin

                                    msg := 'Your ' + LoanProduct."USSD Product Name" + ' request has failed, Your FOSA account is not Active.';
                                    MobileLoan.Remarks := 'FOSA Account is not Active';
                                    MobileLoan.Status := MobileLoan.Status::Failed;
                                    MobileLoan.Posted := true;
                                    MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                                    MobileLoan.Remark := msg;
                                    Sky.SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                                    MobileLoan.Modify;
                                    Continue := false;
                                end;
                            end;
                        end;

                        if Continue then begin
                            if MobileLoan."Requested Amount" > MaxLoan then begin
                                msg := 'Your ' + LoanProduct."USSD Product Name" + ' request has failed, You do not qualify for this product';
                                MobileLoan.Remarks := 'Member eligibility is ' + Format(MaxLoan);
                                MobileLoan.Status := MobileLoan.Status::Failed;
                                MobileLoan.Posted := true;
                                MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                                MobileLoan.Remark := msg;
                                Sky.SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                                MobileLoan.Modify;
                                Continue := false;
                                //message(FORMAT(mAXLOAN));
                            end;
                        end;


                        if Continue then begin

                            JTemplate := 'GENERAL';
                            JBatch := 'SKYWORLD';

                            GenJournalBatch.Reset;
                            GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                            GenJournalBatch.SetRange(Name, JBatch);
                            if not GenJournalBatch.FindFirst then begin
                                GenJournalBatch.Init;
                                GenJournalBatch."Journal Template Name" := JTemplate;
                                GenJournalBatch.Name := JBatch;
                                GenJournalBatch.Description := 'Sky World Batch';
                                GenJournalBatch.Insert;
                            end;


                            SaccoTrans.JournalInit(JTemplate, JBatch);



                            // Get Excise duty G/L
                            ExciseDutyGL := GetExciseDutyGL();
                            ExciseDutyRate := GetExciseRate();
                            ExciseDuty := 0;

                            SaccoAccount := '';
                            SaccoFee := 0;
                            VendorAccount := '';
                            VendorCommission := 0;

                            SMSAccount := '';
                            SMSCharge := 0;


                            if MobileLoan.Channel = MobileLoan.Channel::"Sky World" then begin

                                CoopSetup.RESET;
                                CoopSetup.SETRANGE("Transaction Type", CoopSetup."Transaction Type"::"Loan Disbursement");
                                IF CoopSetup.FINDFIRST THEN BEGIN

                                    SMSAccount := CoopSetup."SMS Account";
                                    SMSCharge := CoopSetup."SMS Charge";


                                    SaccoAccount := CoopSetup."Sacco Fee Account";
                                    SaccoFee := CoopSetup."Sacco Fee";

                                    VendorAccount := CoopSetup."Vendor Commission Account";
                                    VendorCommission := CoopSetup."Vendor Commission";
                                    VendorBalAcc := CoopSetup."Non-Member Debit Account";

                                    TotalCharge := SaccoFee + VendorCommission + SMSCharge;
                                    ExciseDuty := 0;//ROUND((SaccoFee)*ExciseDutyRate/100);
                                END
                                ELSE BEGIN
                                    ERROR('Setup Missing for %1', CoopSetup."Transaction Type"::"Loan Disbursement");
                                END;
                            end;





                            Member.Get(SavAcc."Member No.");

                            if MobileLoan.Period = 0 then
                                MobileLoan.Period := 1;
                            Loans.Init;
                            Loans."Mobile Loan" := true;
                            Loans."Loan No." := '';
                            Loans.Source := LoanProduct."Loan Source";
                            Loans."Application Date" := Today;
                            Loans."Loan Product Type" := LoanProduct."Product ID";
                            Loans."Loan Product Type Name" := LoanProduct.Description;
                            if Loans.Source = Loans.Source::FOSA then
                                Loans."Member No." := SavAcc."No."
                            else
                                Loans."Member No." := SavAcc."Member No.";
                            Loans.Validate("Disbursement Account No", SavAcc."No.");
                            Loans."Member Name" := Member.Name;
                            Loans."Requested Amount" := MobileLoan."Requested Amount";
                            Loans."Approved Amount" := MobileLoan."Requested Amount";
                            Loans.Status := Loans."status"::Approved;
                            Loans."Member No." := Member."No.";
                            if MobileLoan."Loan Period" = 0 then
                                MobileLoan."Loan Period" := 1;
                            Loans.Installments := MobileLoan."Loan Period";
                            Loans."Repayment Frequency" := LoanProduct."Repayment Frequency";
                            Loans."Annual Interest %" := LoanProduct."Interest Rate (Max.)";
                            if MobileLoan."Loan Purpose" <> '' then begin
                                Loans."Sub-Sector Level 2 Code" := MobileLoan."Loan Purpose";
                            end;



                            Loans."Interest Calculation Method" := LoanProduct."Interest Calculation Method";

                            Loans."Mode of Disbursement" := Loans."mode of disbursement"::"Transfer to FOSA";
                            Loans."Global Dimension 1 Code" := 'FOSA';



                            if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised then begin
                                Loans.TestField(Loans.Installments);
                                Loans.Repayment := ROUND((Loans."Annual Interest %" / 12 / 100) / (1 - Power((1 + (Loans."Annual Interest %" / 12 / 100)), -Loans.Installments)) * Loans."Approved Amount");
                                Loans."Loan Interest Repayment" := Loans."Approved Amount" / 100 * Loans."Annual Interest %";
                                Loans."Loan Principle Repayment" := Loans.Repayment - Loans."Loan Interest Repayment";
                            end;

                            if (Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Straight Line") then begin
                                //POLICETESTFIELD(Interest);
                                Loans.TestField(Installments);
                                Loans."Loan Principle Repayment" := ROUND(Loans."Approved Amount" / Loans.Installments, 0.05, '>');//LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');

                                Loans."Loan Interest Repayment" := (Loans."Annual Interest %" / 12 / 100) * LoanAmount;
                                Loans.Repayment := Loans."Loan Principle Repayment" + Loans."Loan Interest Repayment";
                            end;


                            if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin
                                Loans.TestField("Annual Interest %");
                                Loans.TestField(Installments);
                                Loans."Loan Principle Repayment" := ROUND(Loans."Approved Amount" / Loans.Installments, 0.05, '>');//LoanAmount/RepayPeriod;
                                Loans."Loan Interest Repayment" := (Loans."Annual Interest %" / 12 / 100) * Loans."Approved Amount";
                                Loans.Repayment := Loans."Loan Principle Repayment" + Loans."Loan Interest Repayment";
                                Loans.Repayment := Loans."Loan Principle Repayment" + Loans."Loan Interest Repayment";
                                Loans."Adjusted Repayment" := Loans."Loan Principle Repayment" + Loans."Loan Interest Repayment";
                            end;



                            Loans."Repay Mode" := SalType;
                            if SalType = Saltype::" " then
                                Loans."Repay Mode" := LoanProduct."Repay Mode";

                            if MobileLoan."Repay Mode" = 'Cash' then
                                Loans."Repay Mode" := Loans."Repay Mode"::Business;
                            if MobileLoan."Repay Mode" = 'Salary' then
                                Loans."Repay Mode" := Loans."Repay Mode"::Salary;
                            if MobileLoan."Repay Mode" = 'Checkoff' then
                                Loans."Repay Mode" := Loans."Repay Mode"::"Check Off";
                            if MobileLoan."Repay Mode" = 'Standing Order' then
                                Loans."Repay Mode" := Loans."Repay Mode"::"Internal Standing Order";


                            Loans."Staff No" := Members."Payroll/Staff No.";//SavAcc."Staff No" ;
                            Loans."Global Dimension 1 Code" := Members."Global Dimension 1 Code";
                            Loans."Booking Branch" := Members."Global Dimension 2 Code";
                            Loans."Employer Code" := Members."Employer Code";
                            Loans."ID NO." := Members."ID No.";

                            Loans.Posted := false;
                            Loans."Disbursement Date" := Today;
                            Loans."Repayment Start Date" := CalcDate('CM', Loans."Disbursement Date");
                            Loans."Completion Date" := CalcDate(Format(Loans.Installments) + 'M', Loans."Disbursement Date");

                            //Loans.GetTSCcodes;
                            Loans.Insert(true);
                            LoanNo := Loans."Loan No.";
                            MobileLoan."Loan No." := LoanNo;




                            RunningAmount := 0;
                            Loans.Reset;
                            Loans.SetRange("Loan No.", LoanNo);
                            Loans.SetRange("Loan Product Type", MobileLoan."Loan Product Type");
                            if Loans.FindFirst then begin
                                //UpfrontInterest := Loans."Loan Interest Repayment";
                                DocNo := Loans."Loan No.";
                                PDate := Today;

                                Dim1 := Loans."Global Dimension 1 Code";
                                Dim2 := Loans."Booking Branch";

                                AccNo := Loans."Disbursement Account No";
                                AccNo := Loans."Disbursement Account No";
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                TransType := Transtype::"Loan Disbursement";
                                SystCreated := true;

                                RunningAmount := Loans."Approved Amount";
                                SaccoTrans.JournalInit(JTemplate, JBatch);

                                GenSetup.Get;
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Member No.", CopyStr(LoanProduct.Description + ' Disbursement', 1, 100), Balacctype::"G/L Account",
                                              '', Loans."Approved Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Loans."Member Name");
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(LoanProduct.Description + ' Disbursement', 1, 100), Balacctype::"G/L Account",
                                              '', -Loans."Approved Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Loans."Member Name");

                                ExciseDuty := ROUND(((GenSetup."Excise Duty (%)" / 100) * SaccoFee), 1, '>');
                                ExciseDutyGL := GenSetup."Excise Duty GL";

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(LoanProduct.Description + ' Fee', 1, 100), Balacctype::"G/L Account",
                                              '', VendorCommission + SaccoFee + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Loans."Member Name");

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty ' + LoanProduct.Description, 1, 100), Balacctype::"G/L Account",
                                              '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Loans."Member Name");


                                //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"G/L Account",LoanProduct."Loan Interest Account",COPYSTR(LoanProduct.Description+' Commission',1,100),BalAccType::"G/L Account",
                                //            '',-UpfrontInterest,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,Loans."Member Name");
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SaccoAccount, CopyStr(LoanProduct.Description + ' Fee', 1, 100), Balacctype::"G/L Account",
                                              '', -SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Loans."Member Name");



                                AccNo := VendorAccount;
                                ExtDoc := Loans."Disbursement Account No";
                                LoanNo := '';
                                TransType := Transtype::" ";

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, AccNo, CopyStr(LoanProduct.Description + ' Disbursement Commission', 1, 100), Balacctype::"G/L Account",
                                              '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Loans."Member Name");

                                //RunningAmount -=  (Loans."Loan Interest Repayment"*MobileLoan.Period)+ TotalCharge+LoanProduct."CRB Product Type";
                                if MobileLoan."Loan Product Type" <> 'L15' then
                                    ClearOldest := true;

                                TotalTopUp := 0;
                                SelfPresent := false;
                                IF ClearOldest THEN BEGIN
                                    OldLoans.Reset;
                                    OldLoans.SetRange("Member No.", Loans."Member No.");
                                    if MobileLoan."Loan Product Type" = 'SELF GUA' then begin
                                        OldLoans.SetRange("Member No.", Loans."Member No.");
                                        OldLoans.SetRange(Posted, true);
                                        OldLoans.SetFilter(Source, '%1|%2', Loans.Source::BOSA, OldLoans.Source::FOSA);
                                        OldLoans.SetFilter("Outstanding Principal", '>0');

                                    end
                                    else begin
                                        OldLoans.SetRange("Member No.", Loans."Member No.");
                                        OldLoans.SetRange(Posted, true);
                                        OldLoans.SetRange("Loan Product Type", MobileLoan."Loan Product Type");
                                        OldLoans.SetFilter("Outstanding Principal", '>0');
                                    end;


                                    if OldLoans.FindFirst then begin
                                        repeat
                                            if OldLoans."Loan Product Type" = 'SELF GUA' then
                                                SelfPresent := true;

                                            AccNo := OldLoans."Disbursement Account No";
                                            ExtDoc := '';
                                            LoanNo := OldLoans."Loan No.";

                                            SystCreated := true;
                                            PostInterestDue := false;
                                            InterestGL := '';

                                            OldLoans.CalcFields("Outstanding Interest", "Outstanding Principal");
                                            if OldLoans."Outstanding Interest" <= 0 then
                                                OldLoans."Outstanding Interest" := GetLoanInterest(OldLoans, OldLoans."Outstanding Principal", PostInterestDue, InterestGL);

                                            if OldLoans."Outstanding Interest" < 0 then
                                                OldLoans."Outstanding Interest" := 0;

                                            TotalOutstanding := OldLoans."Outstanding Principal" + OldLoans."Outstanding Interest";
                                            TotalTopUp += TotalOutstanding;
                                            if PostInterestDue then begin
                                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, OldLoans."Member No.", CopyStr(LoanProduct.Description + ' Interest top up', 1, 100), Balacctype::"G/L Account",
                                                          '', OldLoans."Outstanding Interest", ExtDoc, LoanNo, Transtype::"Interest Due", Dim1, Dim2, SystCreated, Loans."Member Name");


                                            end;
                                            //Interest top up clearance
                                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, OldLoans."Member No.", CopyStr(LoanProduct.Description + ' Interest top up', 1, 100), Balacctype::"G/L Account",
                                                          '', -OldLoans."Outstanding Interest", ExtDoc, LoanNo, Transtype::"Interest Paid", Dim1, Dim2, SystCreated, Loans."Member Name");

                                            //Principle top up clearance
                                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, OldLoans."Member No.", CopyStr(LoanProduct.Description + ' Principle top up', 1, 100), Balacctype::"G/L Account",
                                                          '', -OldLoans."Outstanding Principal", ExtDoc, LoanNo, Transtype::"Principal Repayment", Dim1, Dim2, SystCreated, Loans."Member Name");


                                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(LoanProduct.Description + ' Top Up', 1, 100), Balacctype::"G/L Account",
                                                      '', TotalOutstanding, ExtDoc, LoanNo, Transtype::" ", Dim1, Dim2, SystCreated, Loans."Member Name");

                                        until OldLoans.Next = 0;


                                    end;
                                END;



                                IntDue := ROUND((Loans."Approved Amount" - TotalTopUp) * (Loans."Annual Interest %" / 1200), 1, '>');





                                if LoanProduct."Charge Upfront Interest" then
                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Member No.", CopyStr(LoanProduct.Description + ' Interest Due', 1, 100), Balacctype::"G/L Account",
                                              LoanProduct."Loan Interest Receivable [G/L]", IntDue, ExtDoc, Loans."Loan No.", Transtype::"Interest Due", Dim1, Dim2, SystCreated, Loans."Member Name");



                                if LoanProduct."Interest Recovered Upfront" then begin


                                    if not LoanProduct."Charge Upfront Interest" then
                                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Member No.", CopyStr(LoanProduct.Description + ' Interest Due', 1, 100), Balacctype::"G/L Account",
                                              LoanProduct."Loan Interest Receivable [G/L]", IntDue, ExtDoc, Loans."Loan No.", Transtype::"Interest Due", Dim1, Dim2, SystCreated, Loans."Member Name");

                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Member No.", CopyStr(LoanProduct.Description + ' Interest Paid', 1, 100), Balacctype::"G/L Account",
                                              '', -IntDue, ExtDoc, Loans."Loan No.", Transtype::"Interest Paid", Dim1, Dim2, SystCreated, Loans."Member Name");
                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, Loans."Disbursement Account No", CopyStr(LoanProduct.Description + ' Interest Paid', 1, 100), Balacctype::"G/L Account",
                                              '', IntDue, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Loans."Member Name");

                                end;

                                PCharges.Reset;
                                PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
                                if PCharges.Find('-') then begin
                                    repeat
                                        PCharges.TestField(PCharges."Account No.");



                                        PChAmt := 0;
                                        GL := '';
                                        EDuty := 0;
                                        MemberActivities.GetLoanChargeAmount(Loans."Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", Loans."Approved Amount", PChAmt, EDuty, GL);
                                        ProcessingFee := PChAmt;


                                        if ProcessingFee > 0 then begin
                                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, Loans."Disbursement Account No", CopyStr(PCharges.Description, 1, 100), Balacctype::"G/L Account",
                                                 GL, ProcessingFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Loans."Member Name");

                                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, Loans."Disbursement Account No", CopyStr('Excise Duty', 1, 100), Balacctype::"G/L Account",
                                                 ExciseDutyGL, EDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Loans."Member Name");
                                        end;
                                    until PCharges.Next = 0;
                                end;





                                MobileLoan.Remarks := 'Successful';
                                MobileLoan."Approved Amount" := Loans."Approved Amount";
                                MobileLoan.Status := MobileLoan.Status::Successful;
                                MobileLoan.Posted := true;
                                MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                                MobileLoan.Remark := msg;
                                MobileLoan.Modify;


                                Loans.Posted := true;
                                Loans.Modify;


                                if LoanProduct."USSD Product Name" = '' then
                                    LoanProduct."USSD Product Name" := LoanProduct.Description;

                                //Error('TEST');


                                SaccoTrans.PostJournal(JTemplate, JBatch);

                                Loans.CalcFields("Outstanding Principal");

                                msg := 'Dear ' + FirstName(Loans."Member no.") +
                                ', your ' + LoanProduct."USSD Product Name" + ' of KES ' + Format(MobileLoan."Requested Amount")
                                + ' has been approved and disbursed to your FOSA account.'; // + ddMMyyyy(Loans."Repayment Start Date");

                                SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);


                            end;
                        end;
                    end;
                end;

            end;
    */


    //
    // get All prerequisites for loan application
    //1. general setup and excise duty
    procedure CheckGenSetupAndExciseDuty(): Boolean
    var
        GenSetUp: Record "Sacco Setup";
    begin
        if not GenSetUp.get then
            exit(false)
        else begin
            if GenSetUp."Excise Duty GL" = '' then
                exit(false)
            else
                exit(true);
        end;
    end;


    procedure AddRemoveMobileLoanGuarantor(LoanNo: Text; MobileNo: Code[20]; "Action": Code[20]) ResponseObject: JsonObject
    var
        SkyMobileLoans: Record "Sky Mobile Loans";
        TheGuarantor: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        LoanType: Record "Product Setup";
        MobileLoanGuarantors: Record "Mobile Loan Guarantors";
        RemGuar: Integer;
        SavAcc: Record "Savings Accounts";
        msg: Text;
        Loans: Record Loans;
        LoanG: Record "Loan Security";
        DepAc: Code[20];
        successText: Text;

        Datum: JsonObject;
    begin

        MobileNo := GetGuarantorMobileNo(MobileNo);

        if StrLen(MobileNo) <> 13 then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Invalid phone No.');
            ResponseObject.Add('response_payload', Datum);
            exit;
        end;


        TheGuarantor.Reset;
        TheGuarantor.SetFilter("Phone No.", '*' + MobileNo);
        if TheGuarantor.FindFirst then begin
            /*
            IF Members."Member Status"<>Members."Member Status"::Active THEN BEGIN
                Return := 'ERROR::::1.'+Members.Name+' is not qualified to Guarantee';
                EXIT;
            END;
        
        
            Loans.RESET;
            Loans.SETRANGE("Member No.",Members."No.");
            Loans.SETFILTER("Outstanding Balance",'>0');
            Loans.SETFILTER("Loans Category-SASRA",'<>%1&<>%2',Loans."Loans Category-SASRA"::Perfoming,Loans."Loans Category-SASRA"::Watch);
            IF Loans.FINDFIRST THEN BEGIN
                Return := 'ERROR::::2.'+Members.Name+' is not qualified to Guarantee';
                EXIT;
            END;
        
        
            LoanG.RESET;
            LoanG.SETRANGE("Member No",Members."No.");
            LoanG.SETFILTER("Outstanding Balance",'>0');
            LoanG.SETRANGE("Self Guarantee",FALSE);
            IF LoanG.FINDFIRST THEN BEGIN
                IF LoanG.COUNT > 20  THEN BEGIN
                    Return := 'ERROR::::3.'+Members.Name+' is not qualified to Guarantee';
                    EXIT;
                END;
            END;
        
        
        
            LoanG.RESET;
            LoanG.SETRANGE("Member No",Members."No.");
            LoanG.SETFILTER("Outstanding Balance",'>0');
            LoanG.SETRANGE("Self Guarantee",TRUE);
            IF LoanG.FINDFIRST THEN BEGIN
                Return := 'ERROR::::4.'+Members.Name+' is not qualified to Guarantee';
                EXIT;
            END;
            */


        end
        else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member NOT found');
            ResponseObject.Add('response_payload', Datum);
            exit;
        end;

        SkyMobileLoans.SetRange("Loan No.", LoanNo);

        if SkyMobileLoans.FindFirst then begin
            LoanType.Get(SkyMobileLoans."Loan Product Type");
            HMember.Get(SkyMobileLoans."Member No.");

            if Action = 'DISCARD' then begin
                msg := 'Dear member, Your ' + LoanType."USSD Product Name" + ' request has been cancelled.';
                SkyMobileLoans.Remarks := 'Loan Discarded';
                SkyMobileLoans.Status := SkyMobileLoans.Status::Failed;
                SkyMobileLoans.Posted := true;
                SkyMobileLoans."Date Posted" := CurrentDatetime;//TODAY;
                //SkyMobileLoans."Message Text" := msg;
                SendSMS.SendSms(SMSSource::SkyMobile, SkyMobileLoans."Telephone No", msg, Format(SkyMobileLoans."Entry No"), '', true, 220, false);
                SkyMobileLoans.Modify;

                ResponseObject.Add('request_status', 'SUCCESS');
                Datum.Add('message', 'Request is successful');
                ResponseObject.Add('response_payload', Datum);
                exit;

                exit;
            end;
            if SkyMobileLoans."Member No." = TheGuarantor."No." then begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'You are not allowed to guarantee your own loan');
                ResponseObject.Add('response_payload', Datum);
                exit;
            end;



            successText := 'Your Request to add ' + TheGuarantor.Name + ' has been received successfully';

            MobileLoanGuarantors.Reset;
            MobileLoanGuarantors.SetRange("Loan Entry No.", SkyMobileLoans."Entry No");
            MobileLoanGuarantors.SetRange("Guarantor Member No.", TheGuarantor."No.");
            if MobileLoanGuarantors.FindFirst then begin
                if Action = 'REMOVE' then begin
                    MobileLoanGuarantors.Delete;

                    ResponseObject.Add('request_status', 'SUCCESS');
                    Datum.Add('message', 'Your Request to Remove ' + TheGuarantor.Name + ' has been received successfully');
                    ResponseObject.Add('response_payload', Datum);

                    msg := 'Dear member, You have removed ' + MobileLoanGuarantors."Guarantor Name" +
                        ' from your guarantorship request on ' + SkyMobileLoans."Loan Name" + ' loan amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today) + ' ' + Format(Time) +
                        'REF: ' + Format(SkyMobileLoans."Loan No.");
                    SendSMS.SendSms(SMSSource::SkyMobile, HMember."Phone No.", msg, Format(HMember."No."), '', true, 220, false);


                    msg := 'Dear ' + Format(MobileLoanGuarantors."Guarantor Name") + ',' + HMember.Name +
                    ' has cancelled your guarantorship request on ' + SkyMobileLoans."Loan Name" + ' loan amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today) + ' ' + Format(Time) +
                    ' Please Accept/Decline By dialing *882#. REF: ' + Format(SkyMobileLoans."Loan No.");
                    SendSMS.SendSms(SMSSource::SkyMobile, MobileLoanGuarantors."Guarantor Mobile No.", msg, Format(HMember."No."), '', true, 220, false);


                end
                else
                    if Action = 'ADD' then begin
                        MobileLoanGuarantors."Loan Entry No." := SkyMobileLoans."Entry No";
                        MobileLoanGuarantors."Guarantor Mobile No." := MobileNo;
                        MobileLoanGuarantors."Guarantor Dep. A/C" := DepAc;
                        MobileLoanGuarantors.Validate("Guarantor Member No.", TheGuarantor."No.");
                        MobileLoanGuarantors."Loan Product" := SkyMobileLoans."Loan Product Type";
                        MobileLoanGuarantors."Loan Product Name" := '';
                        MobileLoanGuarantors."Guarantor Name" := TheGuarantor.Name;
                        MobileLoanGuarantors."Date Created" := CurrentDatetime;
                        MobileLoanGuarantors.Modify;

                        if MobileLoanGuarantors."Guarantor Accepted" = MobileLoanGuarantors."guarantor accepted"::Pending then begin
                            ResponseObject.Add('request_status', 'SUCCESS');
                            Datum.Add('message', successText);
                            ResponseObject.Add('response_payload', Datum);
                        end;
                        if MobileLoanGuarantors."Guarantor Accepted" = MobileLoanGuarantors."guarantor accepted"::No then begin
                            MobileLoanGuarantors."Guarantor Accepted" := MobileLoanGuarantors."guarantor accepted"::Pending;
                            MobileLoanGuarantors.Modify;
                            ResponseObject.Add('request_status', 'SUCCESS');
                            Datum.Add('message', successText);
                            ResponseObject.Add('response_payload', Datum);
                        end;
                        if MobileLoanGuarantors."Guarantor Accepted" = MobileLoanGuarantors."guarantor accepted"::Yes then begin
                            ResponseObject.Add('request_status', 'SUCCESS');
                            Datum.Add('message', successText);
                            ResponseObject.Add('response_payload', Datum);
                        end;



                        msg := 'Dear member, You have Requested ' + MobileLoanGuarantors."Guarantor Name" +
                            ' to be your Guarantor on ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today) + ' ' + Format(Time) +
                            ' Please notify them to Accept By dialing *882#. REF: ' + Format(SkyMobileLoans."Loan No.");
                        SendSMS.SendSms(SMSSource::SkyMobile, HMember."Phone No.", msg, SkyMobileLoans."Loan No.", '', true, 220, false);



                        msg := 'Dear member, ' + SkyMobileLoans."Account Name" +
                        ' is Requesting your Guarantorship on ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today) + ' ' + Format(Time) +
                        ' Please Accept by dialing *882#, Select Loans Option. REF: ' + Format(SkyMobileLoans."Entry No");
                        SendSMS.SendSms(SMSSource::SkyMobile, MobileLoanGuarantors."Guarantor Mobile No.", msg, SkyMobileLoans."Loan No.", '', true, 220, false);
                    end;
            end
            else begin
                MobileLoanGuarantors.Init;
                MobileLoanGuarantors."Loan Entry No." := SkyMobileLoans."Entry No";
                MobileLoanGuarantors."Guarantor Mobile No." := MobileNo;
                MobileLoanGuarantors.Validate("Guarantor Member No.", HMember."No.");
                MobileLoanGuarantors."Loan Product" := SkyMobileLoans."Loan Product Type";
                MobileLoanGuarantors."Loan Product Name" := '';
                MobileLoanGuarantors."Guarantor Name" := HMember.Name;
                MobileLoanGuarantors."Date Created" := CurrentDatetime;
                MobileLoanGuarantors.Insert;

                ResponseObject.Add('request_status', 'SUCCESS');
                Datum.Add('message', successText);
                ResponseObject.Add('response_payload', Datum);


                msg := 'Dear member, You have Requested ' + MobileLoanGuarantors."Guarantor Name" +
                    ' to be your Guarantor on ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today) + ' ' + Format(Time) +
                    ' Please notify them to Accept By dialing *882#. REF: ' + Format(SkyMobileLoans."Loan No.");
                SendSMS.SendSms(SMSSource::SkyMobile, HMember."Phone No.", msg, Format(SkyMobileLoans."Loan No."), '', true, 220, false);


                msg := 'Dear ' + Format(MobileLoanGuarantors."Guarantor Name") + ',' + HMember.Name +
                ' is Requesting your Guarantorship on ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today) + ' ' + Format(Time) +
                ' Please Accept/Decline By dialing *882#. REF: ' + Format(SkyMobileLoans."Loan No.");

                SendSMS.SendSms(SMSSource::SkyMobile, MobileLoanGuarantors."Guarantor Mobile No.", msg, Format(SkyMobileLoans."Loan No."), '', true, 220, false);

            end;
        end;

    end;

    local procedure GetGuarantorMobileNo(MobileNo: Code[20]): Text
    begin

        if StrLen(MobileNo) = 10 then begin
            if CopyStr(MobileNo, 1, 1) = '0' then
                MobileNo := '+254' + CopyStr(MobileNo, 2, 9);
        end
        else
            if StrLen(MobileNo) = 12 then begin
                if CopyStr(MobileNo, 1, 3) = '254' then
                    MobileNo := '+' + MobileNo;
            end
            else
                if StrLen(MobileNo) = 13 then begin
                    if CopyStr(MobileNo, 1, 4) = '+254' then
                        MobileNo := MobileNo;
                end;

        exit(MobileNo);
    end;

    procedure InsufficientAccountBalance(
        requestAmount: Decimal;
        theSavingsAccount: Record "Savings Accounts";
        theTransactionCategory: Text;
        var SearchMember: record Members
    ): Boolean
    var
        theCharges: List of [Decimal];
        totalCost: Decimal;
        MAct: Codeunit "Member Activities";
    begin


        if requestAmount > MAct.GetAccountBalance(theSavingsAccount."No.") then
            exit(true);

        exit(false);
    end;



    procedure PostWithdrawals(DocNo: Code[20])
    var
        SkyTrans: Record "Sky M-Banking Transactions";
        MBSEloanLogs: Record "Mbanking Eloan Logs";
    begin


        SkyTrans.Reset;
        if DocNo <> '' then
            SkyTrans.SetRange("Originator ID", DocNo);
        SkyTrans.SetRange(Posted, false);
        SkyTrans.SetRange("Needs Change", false);
        SkyTrans.SetRange("Transaction Type", SkyTrans."transaction type"::"Mpesa Withdrawal");
        if SkyTrans.FindFirst then begin
            PostWithdrawalTransaction(SkyTrans."Originator ID");
        end;


        SkyTrans.Reset;
        if DocNo <> '' then
            SkyTrans.SetRange("Originator ID", DocNo);
        SkyTrans.SetRange(Posted, false);
        SkyTrans.SetRange("Needs Change", false);
        SkyTrans.SetFilter("Transaction Type", '%1|%2|%3', SkyTrans."transaction type"::"Bank Transfer", SkyTrans."transaction type"::Airtime, SkyTrans."transaction type"::"Utility Payment");
        if SkyTrans.FindFirst then begin
            PostWithdrawalTransaction(SkyTrans."originator ID");
        end;


    end;

    procedure PostMpesaDeposits(DocNo: Code[20])
    var
        SkyTrans: Record "Sky M-Banking Transactions";
    begin
        SkyTrans.Reset;
        if DocNo <> '' then
            SkyTrans.SetRange("Originator ID", DocNo);
        SkyTrans.SetRange(Posted, false);
        SkyTrans.SetRange("Needs Change", false);
        SkyTrans.Setfilter("Transaction Type", '%1|%2', SkyTrans."transaction type"::"Loan Repayment", SkyTrans."transaction type"::"Mpesa Deposit");
        if SkyTrans.FindFirst then begin
            PostMpesaDepositsTransaction(SkyTrans."Originator ID");
        end;
    end;

    procedure PostWithdrawalTransaction(DocumentNo: Code[20]) Response: Boolean
    var

        MAccNo: Code[20];
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
        IntAmt: Decimal;
        PrAmt: Decimal;
        RepayAmt: Decimal;
        SafcomCharges: Record "Safcom Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        msg: Text;
        PrePaymentGL: Code[20];
        NewLoanBal: Decimal;
        LoanType: Record "Product Setup";
        LT: Text;
        AccountToCharge: Code[20];
        ChargeDebitAcctType: Enum "Gen. Journal Account Type";
        ChargeDebitAcctNo: Code[20];
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
        DaysInArrear: integer;
        ArrearsDate: Date;
        DividendFee: Decimal;
        DivChargeAcc: Code[20];
        GracePeriod: DateFormula;
        Charges: Record "Transaction Charges Lines";
    begin


        PrincipalArrears := 0;
        InterestArrears := 0;
        DividendFee := 0;


        Response := false;
        SkyTrans.Reset;
        //SkyTrans.SETFILTER("Transaction Type",'%1',SkyTrans."Transaction Type"::"Loan Repayment");
        //SkyTrans.SetFilter("Transaction Type", '<>%1&<>%2', SkyTrans."transaction type"::"Mini-Statement", SkyTrans."transaction type"::"Balance Enquiry");
        SkyTrans.SetRange("Transaction ID", DocumentNo);
        SkyTrans.SetRange(Posted, false);
        SkyTrans.SetRange("Needs Change", false);

        GenSetup.Get;

        if SkyTrans.FindFirst then begin

            if SkyTrans."Transaction Status" = SkyTrans."Transaction Status"::REVERSE_CONFIRMED then begin


                //MARK BUFFER AS POSTED
                MobileWithdrawalsBuffer.Reset;
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Trace ID", SkyTrans."Originator ID");
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Source, MobileWithdrawalsBuffer.Source::"M-PESA");
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Account No", SkyTrans."Savings Account");
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Transaction Amount", SkyTrans."Transaction Amount");
                if MobileWithdrawalsBuffer.Find('-') then begin

                    MobileWithdrawalsBuffer.Posted := true;
                    MobileWithdrawalsBuffer.Reversed := true;
                    MobileWithdrawalsBuffer."Reversed By" := UserId;
                    MobileWithdrawalsBuffer."Date Reversed" := Today;
                    MobileWithdrawalsBuffer.Modify;

                    SkyTrans.Posted := true;
                    SkyTrans.Remarks := 'REVERSED';
                    SkyTrans."Needs Change" := false;
                    SkyTrans."Posted By" := UserId;
                    SkyTrans."Posting Date" := Today;
                    SkyTrans.Modify;
                    Response := true;
                    EXIT;
                end;

            end;


            if SkyTrans."Transaction Description" = '' then
                SkyTrans."Transaction Description" := Format(SkyTrans."Transaction Type");
            if SkyTrans."Transaction Description" = '[string]' then
                SkyTrans."Transaction Description" := Format(SkyTrans."Transaction Type");




            GenSetup.Get;

            if StrLen(SkyTrans."Transaction ID") > 20 then
                DocNo := CopyStr(SkyTrans."Originator ID", 1, 20)
            else
                DocNo := SkyTrans."Transaction ID";

            PDate := SkyTrans."Transaction Date";
            if SkyTrans."UWS Posting Date" <> 0D then
                PDate := SkyTrans."UWS Posting Date";

            PDate := Today;

            AccNo := CopyStr(SkyTrans."Source Account", 1, MaxStrLen(AccNo));


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
            Clear(SkyMobileSetup);


            if SkyTrans."Transaction Type" = SkyTrans."Transaction Type"::" " then begin

                case SkyTrans."Transaction Category" of
                    'MPESA_WITHDRAWAL':
                        SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Mpesa Withdrawal";
                    'BILL_PAYMENT':
                        SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Utility Payment";
                    'TILL_PAYMENT':
                        SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Utility Payment";
                    'BANK_TRANSFER':
                        SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Bank Transfer";
                    'EXTERNAL_BANK_TRANSFER':
                        SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"External Bank Transfer";
                    'AIRTIME_PURCHASE':
                        SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::Airtime;
                    'MPESA_C2B_DEPOSIT':
                        SkyTrans."Transaction Type" := SkyTrans."Transaction Type"::"Mpesa Deposit";
                end;

            end;

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
                    VendorCommission += (ChargeAmt + ChargeDuty);
                end;

                if SkyMobileSetup."Safcom Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Safcom Staggered Charge", SkyTrans."Transaction Amount", SafcomFee, ChargeDuty, ChargeAcctType, ChargeAcct);

                if (SkyTrans."Transaction Type" = SkyTrans."Transaction Type"::"Mpesa Withdrawal") and (SkyMobileSetup."Total Charges" > 0) then begin
                    SaccoFee := SkyMobileSetup."Total Charges" - VendorCommission - SafcomFee - SMSCharge;
                end;

                TotalCharge := SaccoFee + VendorCommission + SafcomFee + DividendFee + SMSCharge;

                ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);

                if (SkyTrans."Transaction Type" = SkyTrans."Transaction Type"::"Mpesa Withdrawal") and (SkyMobileSetup."Total Charges" > 0) then begin
                    SaccoFee -= ExciseDuty;
                end;
            end
            else begin
                if SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Pay Loan From Account" then
                    Error('Setup Missing for %1', SkyTrans."Transaction Type");
            end;

            //ERROR('SafcomFee %1\SaccoFee %2',SafcomFee,SaccoFee);

            if (SavAcc.Get(CopyStr(SkyTrans."Source Account", 1, MaxStrLen(SavAcc."No.")))) then begin

                SavAcc.CalcFields("Member Category");
                if SavAcc."Member Category" = SavAcc."Member Category"::"Staff Members" then
                    SkyMobileSetup.TestField("Staff G/L Account Charges");


                MemberName := SavAcc."Name";
                TransAmt := SkyTrans."Transaction Amount";
                AccountToCharge := '';
                MobileNo := '';

                DimID := 0;

                if Members."Member Status" = Members."Member Status"::Deceased then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a deceased account.';
                    SkyTrans.Modify;
                    exit;
                end;

                if SavAcc.Status <> SavAcc.Status::Active then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a non active account.';
                    SkyTrans.Modify;
                    exit;
                end;

                if SavAcc.Status = SavAcc.Status::Deceased then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a deceased account.';
                    SkyTrans.Modify;
                    exit;
                end;

                if SavAcc.Status = SavAcc.Status::Withdrawn then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a Withdrawn account.';
                    SkyTrans.Modify;
                    exit;
                end;

                if Members."Member Status" = Members."Member Status"::Withdrawn then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a withdrawn account.';
                    SkyTrans.Modify;
                    exit;
                end;

                if SavAcc.Blocked = SavAcc.Blocked::All then begin
                    //SkyTrans.Posted := true;

                    SkyTrans."Needs Change" := true;
                    SkyTrans.Remarks := 'You cannot transact on a blocked [All] account.';
                    SkyTrans.Modify;
                    exit;
                end;

                AccountToCharge := SavAcc."No.";
                MobileNo := SavAcc."Transactional Mobile No";



                if not BUser.Get(UserId()) then
                    if not BUser.Get('SKYPORTAL') then
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
                    GenJournalBatch.Description := 'SKY MBanking Batch';
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

                BankAccount := SkyMobileSetup."Bank Account";

                SystCreated := true;




                SaccoTrans.JournalInit(JTemplate, JBatch);
                //if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Mpesa Withdrawal") then
                //    SkyTrans."Transaction Description" := Format(SkyTrans."transaction type"::"Mpesa Withdrawal");


                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(SkyTrans."Transaction Description", 1, 100), Balacctype::"Bank Account",
                          BankAccount, TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                if TotalCharge > 0 then begin
                    if (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Mpesa Deposit") and (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Mpesa Deposit")
                        and (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Loan Repayment")
                       /* and (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Bank Transfer") and
                       (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"External Bank Transfer") */
                       then begin

                        if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Mpesa Withdrawal") then
                            AccountToCharge := AccNo;

                        if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Bank Transfer") or (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"External Bank Transfer") then
                            AccountToCharge := AccNo;
                        GetSkyChargeDebitAccount(SkyMobileSetup, AccountToCharge, ChargeDebitAcctType, ChargeDebitAcctNo);
                        /* if SavAcc."Member Category" = SavAcc."Member Category"::"Staff Members" then
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SkyMobileSetup."Staff G/L Account Charges", CopyStr(SkyTrans."Transaction Description" + ' Charges', 1, 100), Balacctype::"G/L Account",
                                         '', VendorCommission + DividendFee + SaccoFee + SafcomFee + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID)
                        else */
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, ChargeDebitAcctType, ChargeDebitAcctNo, CopyStr(SkyTrans."Transaction Description" + ' Charges', 1, 100), Balacctype::"G/L Account",
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

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, ChargeDebitAcctType, ChargeDebitAcctNo, CopyStr('SMS Charge - ', 1, 100), Balacctype::"G/L Account",
                                      SMSAccount, SMSCharge, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,Accttype::Savings,AccountToCharge,COPYSTR('Excise Duty ',1,100),BalAccType::"G/L Account",
                        //            ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty ' + SkyTrans."Transaction Description", 1, 100), Balacctype::"G/L Account",
                                      '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                    end;



                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, VendorAccount, CopyStr('Fee on ' + SkyTrans."Transaction Description", 1, 100), Balacctype::"G/L Account",
                                  '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                end;

                SkyTrans.Posted := true;

                SkyTrans."Needs Change" := false;
                SkyTrans."Posted By" := UserId;
                SkyTrans."Posting Date" := Today;
                SkyTrans.Modify;
                Response := true;



                //MARK BUFFER AS POSTED
                MobileWithdrawalsBuffer.Reset;
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Trace ID", SkyTrans."Originator ID");
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Source, MobileWithdrawalsBuffer.Source::"M-PESA");
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Account No", SkyTrans."Savings Account");
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Transaction Amount", SkyTrans."Transaction Amount");
                if MobileWithdrawalsBuffer.Find('-') then begin

                    MobileWithdrawalsBuffer.Posted := true;
                    MobileWithdrawalsBuffer."Posting Date" := Today;
                    MobileWithdrawalsBuffer.Modify;
                end;

                SaccoTrans.JournalPost(JTemplate, JBatch);


                msg := 'Dear ' + SavAcc.Name + NewLine +
                      Format(SkyTrans."Transaction Type") + ' of KES ' + Format(SkyTrans."Transaction Amount") + ' done on ' + Format(ddMMyyyy(SkyTrans."Transaction Date")) + '  has been processed successfully.' + NewLine +
                      'REF: ' + SkyTrans."Originator ID";


                if MobileNo = '' then
                    MobileNo := SavAcc."Mobile Phone No.";

                /*  if (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Mini-Statement") and (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Balance Enquiry") then
                     if (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Mobile App Login") then
                         SendSmsWithID(Source::SkyMobile, MobileNo, msg, Format(SkyTrans."Originator ID"), '', true, 0, false, 'CBS', '', 'CBS'); */
                SendSMS.SendSms(SMSSource::SkyMobile, MobileNo, msg, SkyTrans."Transaction ID", SavAcc."No.", true, 20, false);

            end
            else begin

                SkyTrans."Needs Change" := true;

                SkyTrans.Remarks := 'Unknown Transaction type';
                SkyTrans.Modify;
            end;
        end;

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
        PSetup: Record "Product Setup";
        LoanType: Record "Product Setup";
        LT: Text;
        AccountToCharge: Code[20];
        ChargeDebitAcctType: Enum "Gen. Journal Account Type";
        ChargeDebitAcctNo: Code[20];
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
        MpesaActivities: Codeunit "Mpesa Activities";
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

            if Loans.get(CopyStr(SkyTrans."Savings Account", 1, 20)) then begin
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
                exit;
            end;

            DocNo := CopyStr(SkyTrans."Transaction ID", 1, 20);

            PDate := SkyTrans."Transaction Date";
            if SkyTrans."UWS Posting Date" <> 0D then
                PDate := SkyTrans."UWS Posting Date";

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
                            end else begin
                                ClearLastError();
                                if (not TryResolveSavingsAccountByKeyword(SkyTrans, SavAcc, AccNo, Distribute)) or (AccNo = '') then begin
                                    SkyTrans."Needs Change" := true;
                                    SkyTrans.Posted := false;
                                    if GetLastErrorText() <> '' then
                                        SkyTrans.Remarks := CopyStr(GetLastErrorText(), 1, MaxStrLen(SkyTrans.Remarks))
                                    else
                                        SkyTrans.Remarks := CopyStr(StrSubstNo('No keyword/product mapping found for account %1.', SkyTrans."Savings Account"), 1, MaxStrLen(SkyTrans.Remarks));
                                    SkyTrans.Modify();
                                    exit;
                                end;
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
                    exit;
                end;

                if Members."Member Status" = Members."Member Status"::Withdrawn then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a withdrawn account.';
                    SkyTrans.Modify;
                    exit;
                end;

                if SavAcc.Status = SavAcc.Status::Deceased then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a deceased account.';
                    SkyTrans.Modify;
                    exit;
                end;

                if SavAcc.Status = SavAcc.Status::Withdrawn then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a Withdrawn account.';
                    SkyTrans.Modify;
                    exit;
                end;

                if SkyTrans."Loan No." <> '' then begin

                    if Members.Blocked = Members.Blocked::All then begin
                        //SkyTrans.Posted := true;

                        SkyTrans."Needs Change" := true;
                        SkyTrans.Remarks := 'You cannot transact on a blocked [All] account.';
                        SkyTrans.Modify;
                        exit;
                    end;
                end;

                if SavAcc.Blocked = SavAcc.Blocked::All then begin
                    //SkyTrans.Posted := true;

                    SkyTrans."Needs Change" := true;
                    SkyTrans.Remarks := 'You cannot transact on a blocked [All] account.';
                    SkyTrans.Modify;
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
                        GetSkyChargeDebitAccount(SkyMobileSetup, AccountToCharge, ChargeDebitAcctType, ChargeDebitAcctNo);

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, ChargeDebitAcctType, ChargeDebitAcctNo, CopyStr('Mobile Charges', 1, 100), Balacctype::"G/L Account",
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
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, ChargeDebitAcctType, ChargeDebitAcctNo, CopyStr('SMS Charge - ', 1, 100), Balacctype::"G/L Account",
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

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::vendor, VendorAccount, CopyStr('Mobile Charge', 1, 100), Balacctype::"G/L Account",
                                  '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);


                end;


                if SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Mpesa Deposit" then begin
                    if Distribute then begin

                        AccBal := MActivities.GetAccountBalance(SavAcc."No.");
                        if AccBal > 0 then
                            AccBal := 0;
                        RunBal := AccBal + SkyTrans."Transaction Amount";
                        if SkyMobileSetup."Non-Member Debit Account" = '' then
                            RunBal -= TotalCharge + ExciseDuty;

                        //message('RunBal %1', RunBal);
                        if RunBal > 0 then
                            SaccoTrans.GenerateMemberRepaymentJournals(JTemplate, JBatch, docNo, ExtDoc, pdate, CopyStr(SkyTrans."Transaction Description", 1, 100), pdate, RunBal, Members."No.", LoanNo, SavAcc."No.", BalAccType::Savings, 0, TChannel::Mobile, true);
                    end;
                end;

                if SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Loan Repayment" then begin

                    AccBal := MActivities.GetAccountBalance(SavAcc."No.");
                    if AccBal > 0 then
                        AccBal := 0;

                    RunBal := AccBal + SkyTrans."Transaction Amount";
                    if SkyMobileSetup."Non-Member Debit Account" = '' then
                        RunBal -= TotalCharge + ExciseDuty;

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
                            ' on ' + Format(ddMMyyyy(PDate)) +
                            '. Your Loan No. ' + Loans."Loan No." + ' (' + LT + ') has been updated. Thank you for your continued support. - ' + CompanyName;
                        EmailBody := 'We confirm receipt of KES ' + Format(SkyTrans."Transaction Amount") +
                            ' on ' + Format(ddMMyyyy(PDate)) +
                            '. Your Loan No. ' + Loans."Loan No." + ' (' + LT + ') has been updated. Thank you for your continued support. - ' + CompanyName;
                    end;
                end

                else begin
                    if SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Mpesa Deposit" then begin
                        Depositor := ExtractMobileNumber(SkyTrans."Transaction Description");//CopyStr(SkyTrans."Transaction Description", 24, StrLen(SkyTrans."Transaction Description"));

                        msg := 'Dear ' + MemberActivities.FirstName(SavAcc.Name) +
                            ', we confirm receipt of KES ' + Format(SkyTrans."Transaction Amount") +
                            ' on ' + Format(ddMMyyyy(PDate)) +
                            '. Your account has been updated. Thank you for your continued support. - ' + CompanyName;
                        EmailBody := 'We confirm receipt of KES ' + Format(SkyTrans."Transaction Amount") +
                            ' on ' + Format(ddMMyyyy(PDate)) +
                            '. Your account has been updated. Thank you for your continued support. - ' + CompanyName;
                    end
                    else begin
                        msg := 'Dear ' + MemberActivities.FirstName(SavAcc.Name) +
                            ', we confirm receipt of KES ' + Format(SkyTrans."Transaction Amount") +
                            ' on ' + Format(ddMMyyyy(PDate)) +
                            '. Your ' + Format(SkyTrans."Transaction Type") + ' has been updated. Thank you for your continued support. - ' + CompanyName;
                        EmailBody := 'We confirm receipt of KES ' + Format(SkyTrans."Transaction Amount") +
                            ' on ' + Format(ddMMyyyy(PDate)) +
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

                if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Mpesa Deposit") or (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Loan Repayment") then
                    SendSMS.SendSms(SMSSource::MBanking, MobileNo, msg, SkyTrans."Transaction ID", '', false, 220, false)
                else
                    SendSMS.SendSms(SMSSource::SkyMobile, MobileNo, msg, SkyTrans."Transaction ID", '', false, 220, false);

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
                        end
                    end
                    else begin
                        SkyTrans."Needs Change" := true;

                        SkyTrans.Remarks := 'Account/Loan No. Not Found';
                        SkyTrans.Modify;
                    end;

                end
                else begin
                    SkyTrans."Needs Change" := true;

                    SkyTrans.Remarks := 'Unknown Transaction type';
                    SkyTrans.Modify;
                end;
            end;
        end;

    end;


    procedure ExtractMobileNumber(MessageText: Text): Text
    var
        StartPos: Integer;
    begin
        StartPos := StrPos(MessageText, 'From ');
        if StartPos > 0 then
            exit(CopyStr(MessageText, StartPos + 5, StrLen(MessageText) - StartPos));
    end;


    procedure PostBalanceEquiryTransaction(DocumentNo: Code[20]) Response: Boolean
    var

        MAccNo: Code[20];
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
        IntAmt: Decimal;
        PrAmt: Decimal;
        RepayAmt: Decimal;
        SafcomCharges: Record "Safcom Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        msg: Text;
        PrePaymentGL: Code[20];
        NewLoanBal: Decimal;
        LoanType: Record "Product Setup";
        LT: Text;
        AccountToCharge: Code[20];
        ChargeDebitAcctType: Enum "Gen. Journal Account Type";
        ChargeDebitAcctNo: Code[20];
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
        DaysInArrear: integer;
        ArrearsDate: Date;
        DividendFee: Decimal;
        DivChargeAcc: Code[20];
        GracePeriod: DateFormula;
        Charges: Record "Transaction Charges Lines";
    begin


        PrincipalArrears := 0;
        InterestArrears := 0;
        DividendFee := 0;


        Response := false;
        SkyTrans.Reset;
        SkyTrans.SetRange("Transaction ID", DocumentNo);
        SkyTrans.SetRange(Posted, false);
        SkyTrans.SetRange("Needs Change", false);
        SkyTrans.SetFilter("Transaction Type", '%1|%2', SkyTrans."transaction type"::"Loan Balance Enquiry", SkyTrans."transaction type"::"Account Balance Enquiry");
        if SkyTrans.FindFirst then begin


            GenSetup.Get;
            if SkyTrans."Transaction Description" = '' then
                SkyTrans."Transaction Description" := Format(SkyTrans."Transaction Type");
            if SkyTrans."Transaction Description" = '[string]' then
                SkyTrans."Transaction Description" := Format(SkyTrans."Transaction Type");

            if Loans.get(SkyTrans."Savings Account") then begin
                SkyTrans."Savings Account" := legacy.GetOrdinaryAccount(Loans."Member No.");
                SkyTrans."Loan No." := Loans."Loan No.";
                SkyTrans."Loan Account" := Loans."Loan Account";
                SkyTrans.Modify();
            end;

            DocNo := SkyTrans."Transaction ID";

            PDate := SkyTrans."Transaction Date";

            PDate := Today;

            AccNo := SkyTrans."Savings Account";



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
                if SkyMobileSetup."Vendor Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Vendor Staggered Charge", SkyTrans."Transaction Amount", VendorCommission, ChargeDuty, ChargeAcctType, ChargeAcct);

                if SkyMobileSetup."Safcom Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Safcom Staggered Charge", SkyTrans."Transaction Amount", SafcomFee, ChargeDuty, ChargeAcctType, ChargeAcct);


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
                    exit;
                end;

                if SavAcc.Status <> SavAcc.Status::Active then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a non active account.';
                    SkyTrans.Modify;
                    exit;
                end;
                if SavAcc.Status = SavAcc.Status::Deceased then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a deceased account.';
                    SkyTrans.Modify;
                    exit;
                end;

                if SavAcc.Status = SavAcc.Status::Withdrawn then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a Withdrawn account.';
                    SkyTrans.Modify;
                    exit;
                end;

                if Members."Member Status" = Members."Member Status"::Withdrawn then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;

                    SkyTrans.Remarks := 'You cannot transact on a withdrawn account.';
                    SkyTrans.Modify;
                    exit;
                end;

                if SkyTrans."Loan No." <> '' then begin

                    if Members.Blocked = Members.Blocked::All then begin
                        //SkyTrans.Posted := true;

                        SkyTrans."Needs Change" := true;
                        SkyTrans.Remarks := 'You cannot transact on a blocked [All] account.';
                        SkyTrans.Modify;
                        exit;
                    end;
                end;
                if SavAcc.Blocked = SavAcc.Blocked::All then begin
                    //SkyTrans.Posted := true;

                    SkyTrans."Needs Change" := true;
                    SkyTrans.Remarks := 'You cannot transact on a blocked [All] account.';
                    SkyTrans.Modify;
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
                    exit;
                end;


                if not BUser.Get(UserId()) then
                    if not BUser.Get('SKYPORTAL') then
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
                    GenJournalBatch.Description := 'SKY MBanking Batch';
                    GenJournalBatch.Insert;
                end;

                LoanNo := '';
                TransType := Transtype::" ";
                Dim1 := SavAcc."Global Dimension 1 Code";
                Dim2 := SavAcc."Global Dimension 2 Code";

                DimID := SavAcc."Dimension Set ID";

                BankAccount := SkyMobileSetup."Bank Account";

                SystCreated := true;




                SaccoTrans.JournalInit(JTemplate, JBatch);

                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(SkyTrans."Transaction Description", 1, 100), Balacctype::"Bank Account",
                      BankAccount, TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);





                if TotalCharge > 0 then begin
                    if (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Mpesa Deposit") and (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Mpesa Deposit")
                        and (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Loan Repayment")
                       and (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Bank Transfer") then begin

                        if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Mpesa Withdrawal") then
                            AccountToCharge := AccNo;

                        if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Bank Transfer") or (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"External Bank Transfer") then
                            AccountToCharge := SkyTrans."Sender Account";
                        GetSkyChargeDebitAccount(SkyMobileSetup, AccountToCharge, ChargeDebitAcctType, ChargeDebitAcctNo);

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, ChargeDebitAcctType, ChargeDebitAcctNo, CopyStr(SkyTrans."Transaction Description" + ' Charges', 1, 100), Balacctype::"G/L Account",
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
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, ChargeDebitAcctType, ChargeDebitAcctNo, CopyStr('SMS Charge - ', 1, 100), Balacctype::"G/L Account",
                                      SMSAccount, SMSCharge, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,Accttype::Savings,AccountToCharge,COPYSTR('Excise Duty ',1,100),BalAccType::"G/L Account",
                        //            ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty ', 1, 100), Balacctype::"G/L Account",
                                      '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                    end
                    else begin

                        //SkyMobileSetup.TestField("Non-Member Debit Account");
                        /*  DepDesc := 'C2B Mpesa Deposit';
                         if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Bank Deposit") then
                             DepDesc := 'C2B Bank Deposit';
                         if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Bank Agent Deposit") then
                             DepDesc := 'C2B Bank Agent Deposit'; */

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, VendorAccount, CopyStr(DepDesc, 1, 100), Balacctype::"G/L Account",
                              '', VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                        if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Bank Transfer") or (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"External Bank Transfer") then begin
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", SafcomAcc, CopyStr('Corporate Charge', 1, 100), Balacctype::"Bank Account",
                                        SafcomAcc, SafcomFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                        end;

                    end;


                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::vendor, VendorAccount, CopyStr('Fee on ' + SkyTrans."Transaction Description", 1, 100), Balacctype::"G/L Account",
                                  '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);


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
                        Loans.CalcFields("Outstanding Principal");
                        LT := Loans."Loan Product Type Name";
                        if LoanType.Get(Loans."Loan Product Type") then
                            LT := LoanType."Description";

                        NewLoanBal := Loans."Outstanding Principal";
                        msg := 'Dear ' + SavAcc.Name + NewLine +
                            Format(SkyTrans."Transaction Type") + ' of KES ' + Format(SkyTrans."Transaction Amount") + ' done on ' + Format(ddMMyyyy(SkyTrans."Transaction Date")) + ' has been processed successfully.' + NewLine +
                            ' New ' + LT + ' Balance is ' + Format(NewLoanBal) + NewLine +
                            'REF: ' + SkyTrans."Originator ID";
                    end;
                end
                else begin
                    if SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Mpesa Deposit" then begin
                        Depositor := CopyStr(SkyTrans."Transaction Description", 24, StrLen(SkyTrans."Transaction Description"));
                        //MemberName
                        msg := 'Dear ' + SavAcc.Name + NewLine +
                        'KES ' + Format(SkyTrans."Transaction Amount") + ' has been deposited to your to your ' + SavAcc."Product Name" + ': ' + SkyTrans."Sender Account" +
                                  ' on ' + Format(ddMMyyyy(SkyTrans."Transaction Date")) + NewLine +
                                  'REF: ' + SkyTrans."Originator ID";
                    end
                    else begin
                        msg := 'Dear ' + SavAcc.Name + NewLine +
                              Format(SkyTrans."Transaction Type") + ' of KES ' + Format(SkyTrans."Transaction Amount") + ' done on ' + Format(ddMMyyyy(SkyTrans."Transaction Date")) + '  has been processed successfully.' + NewLine +
                              'REF: ' + SkyTrans."Originator ID";
                    end;
                end;


                if MobileNo = '' then
                    MobileNo := SavAcc."Mobile Phone No.";

                /*if (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Mini-Statement") and (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Balance Enquiry") then
                    if (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Mobile App Login") then
                        SendSmsWithID(Source::SkyMobile, MobileNo, msg, Format(SkyTrans."Originator ID"), '', true, 0, false, 'CBS', '', 'CBS');*/

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
                        end
                    end
                    else begin
                        SkyTrans."Needs Change" := true;

                        SkyTrans.Remarks := 'Account/Loan No. Not Found';
                        SkyTrans.Modify;
                    end;

                end
                else begin
                    SkyTrans."Needs Change" := true;

                    SkyTrans.Remarks := 'Unknown Transaction type';
                    SkyTrans.Modify;
                end;
            end;
        end;

    end;

    procedure PostAccountTransferTransaction(DocumentNo: Code[20]) Response: Boolean
    var

        MAccNo: Code[20];
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
        IntAmt: Decimal;
        PrAmt: Decimal;
        RepayAmt: Decimal;
        SafcomCharges: Record "Safcom Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        msg: Text;
        PrePaymentGL: Code[20];
        NewLoanBal: Decimal;
        LoanType: Record "Product Setup";
        LT: Text;
        AccountToCharge: Code[20];
        ChargeDebitAcctType: Enum "Gen. Journal Account Type";
        ChargeDebitAcctNo: Code[20];
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
        DaysInArrear: integer;
        ArrearsDate: Date;
        DividendFee: Decimal;
        DivChargeAcc: Code[20];
        GracePeriod: DateFormula;
        Charges: Record "Transaction Charges Lines";
        Destination: Record "Savings Accounts";
    begin


        PrincipalArrears := 0;
        InterestArrears := 0;
        DividendFee := 0;


        Response := false;
        SkyTrans.Reset;
        //SkyTrans.SETFILTER("Transaction Type",'%1',SkyTrans."Transaction Type"::"Loan Repayment");
        //SkyTrans.SetFilter("Transaction Type", '<>%1&<>%2', SkyTrans."transaction type"::"Mini-Statement", SkyTrans."transaction type"::"Balance Enquiry");
        SkyTrans.SetRange("Transaction ID", DocumentNo);
        SkyTrans.SetRange(Posted, false);
        SkyTrans.SetRange("Needs Change", false);
        if SkyTrans.FindFirst then begin
            GenSetup.Get;
            if SkyTrans."Transaction Description" = '' then
                SkyTrans."Transaction Description" := Format(SkyTrans."Transaction Type");
            if SkyTrans."Transaction Description" = '[string]' then
                SkyTrans."Transaction Description" := Format(SkyTrans."Transaction Type");


            DocNo := SkyTrans."Transaction ID";

            PDate := SkyTrans."Transaction Date";

            PDate := Today;

            AccNo := CopyStr(SkyTrans."Source Account", 1, MaxStrLen(AccNo));

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


                if SkyMobileSetup."Sacco Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Sacco Staggered Charge", SkyTrans."Transaction Amount", SaccoFee, ChargeDuty, ChargeAcctType, ChargeAcct);

                if SkyMobileSetup."Vendor Staggered Fee" then begin
                    MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Vendor Staggered Charge", SkyTrans."Transaction Amount", VendorCommission, ChargeDuty, ChargeAcctType, ChargeAcct);
                    VendorCommission += ChargeDuty;
                end;

                if SkyMobileSetup."Safcom Staggered Fee" then begin
                    MActivities.GetGeneralChargeAmountOnly(SkyMobileSetup."Safcom Staggered Charge", SkyTrans."Transaction Amount", SafcomFee, ChargeDuty, ChargeAcctType, ChargeAcct);
                    SafcomFee += ChargeDuty;
                end;


                TotalCharge := SaccoFee + VendorCommission + SafcomFee + DividendFee + SMSCharge;
                ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
            end
            else begin
                Error('Setup Missing for %1', SkyTrans."Transaction Type");
            end;

            //ERROR('SafcomFee %1\SaccoFee %2',SafcomFee,SaccoFee);

            if (SavAcc.Get(CopyStr(SkyTrans."Source Account", 1, MaxStrLen(SavAcc."No.")))) then begin

                MemberName := SavAcc."Name";
                TransAmt := SkyTrans."Transaction Amount";
                AccountToCharge := '';
                MobileNo := '';

                DimID := 0;



                AccBal := MActivities.GetAccountBalance(SavAcc."No.");

                if AccBal < (SkyTrans."Transaction Amount" + (TotalCharge + ExciseDuty)) then begin

                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;
                    SkyTrans.Remarks := 'Insufficient Account Balance';
                    SkyTrans.Modify;
                    exit;
                end;

                if Members."Member Status" = Members."Member Status"::Deceased then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;
                    SkyTrans.Remarks := 'You cannot transact on a deceased member.';
                    SkyTrans.Modify;
                    exit;
                end;

                if SavAcc.Status = SavAcc.Status::Deceased then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;
                    SkyTrans.Remarks := 'You cannot transact on a deceased account.';
                    SkyTrans.Modify;
                    exit;
                end;

                if SavAcc.Status = SavAcc.Status::Withdrawn then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;
                    SkyTrans.Remarks := 'You cannot transact on a Withdrawn account.';
                    SkyTrans.Modify;
                    exit;
                end;

                if Members."Member Status" = Members."Member Status"::Withdrawn then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Posted := false;
                    SkyTrans.Remarks := 'You cannot transact on a withdrawn account.';
                    SkyTrans.Modify;
                    exit;
                end;

                if SavAcc.Blocked = SavAcc.Blocked::All then begin
                    SkyTrans."Needs Change" := true;
                    SkyTrans.Remarks := 'You cannot transact on a blocked [All] account.';
                    SkyTrans.Modify;
                    exit;
                end;

                AccountToCharge := SavAcc."No.";
                MobileNo := SavAcc."Transactional Mobile No";
                if MobileNo = '' then
                    MobileNo := SavAcc."Mobile Phone No.";



                if TransAmt <= 0 then begin

                    SkyTrans."Needs Change" := true;
                    SkyTrans.Remarks := 'Invalid Amount';
                    SkyTrans.Modify;
                    exit;
                end;

                if not BUser.Get(UserId()) then
                    if not BUser.Get('SKYPORTAL') then
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
                    GenJournalBatch.Description := 'SKY MBanking Batch';
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
                SystCreated := true;


                SaccoTrans.JournalInit(JTemplate, JBatch);


                if (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Account Transfer") or
                    (SkyTrans."Transaction Type" = SkyTrans."transaction type"::"Pay Loan From Account") then begin

                    AccNo := CopyStr(SkyTrans."Source Account", 1, MaxStrLen(AccNo));

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(Format(SkyTrans."Transaction Description"), 1, 10100), Balacctype::"G/L Account",
                          '', TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                    if Loans.Get(SkyTrans."Destination Account") then begin
                        RunBal := TransAmt;

                        Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty");

                        RepayAmt := Loans."Outstanding Penalty" - SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Penalty Paid");
                        if RepayAmt > 0 then begin
                            if RepayAmt > RunBal then
                                RepayAmt := RunBal;

                            ExtDoc := '';
                            LoanNo := Loans."Loan No.";
                            TransType := Transtype::"Penalty Paid";
                            SystCreated := true;

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(SkyTrans."Transaction Description", 1, 100), Balacctype::"G/L Account",
                                          '', -RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                            RunBal -= RepayAmt;
                        end;

                        RepayAmt := Loans."Outstanding Insurance" - SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Insurance Paid");

                        if RepayAmt > 0 then begin
                            if RepayAmt > RunBal then
                                RepayAmt := RunBal;

                            ExtDoc := '';
                            LoanNo := Loans."Loan No.";
                            TransType := Transtype::"Penalty Paid";
                            SystCreated := true;

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(SkyTrans."Transaction Description", 1, 100), Balacctype::"G/L Account",
                                          '', -RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                            RunBal -= RepayAmt;
                        end;

                        RepayAmt := Loans."Outstanding Insurance" - SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Insurance Paid");

                        if RepayAmt > 0 then begin
                            if RepayAmt > RunBal then
                                RepayAmt := RunBal;

                            ExtDoc := '';
                            LoanNo := Loans."Loan No.";
                            TransType := Transtype::"Insurance Paid";
                            SystCreated := true;

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(SkyTrans."Transaction Description", 1, 100), Balacctype::"G/L Account",
                                          '', -RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                            RunBal -= RepayAmt;
                        end;

                        RepayAmt := Loans."Outstanding Interest" - SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Interest Paid");
                        if RepayAmt > 0 then begin
                            if RepayAmt > RunBal then
                                RepayAmt := RunBal;

                            ExtDoc := '';
                            LoanNo := Loans."Loan No.";
                            TransType := Transtype::"Interest Paid";
                            SystCreated := true;

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(SkyTrans."Transaction Description", 1, 100), Balacctype::"G/L Account",
                                          '', -RepayAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                            RunBal -= RepayAmt;
                        end;

                        if Loans."Outstanding Principal" > 0 then begin
                            PrAmt := Loans."Outstanding Principal";
                            if PrAmt > RunBal then
                                PrAmt := RunBal;

                            ExtDoc := '';
                            LoanNo := Loans."Loan No.";
                            SystCreated := true;
                            TransType := Transtype::"Principal Repayment";

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(SkyTrans."Transaction Description", 1, 100), Balacctype::"G/L Account",
                                          '', -PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                            RunBal -= PrAmt;
                        end;

                        if RunBal > 0 then begin
                            AccNo := CopyStr(SkyTrans."Source Account", 1, MaxStrLen(AccNo));
                            //    procedure GenerateMemberRepaymentJournals(Jtemplate: Code[20]; JBatch: Code[20]; DocNo: Code[20]; ExtDocNo: Code[20]; PDate: Date; Desc: Text[50]; DocDate: Date; RunBal: Decimal; MemberNo: Code[20]; LoanNo: Code[20]; BalAccountNo: Code[20]; BalAcctType: Enum "Gen. Journal Account Type"; "Dimension Set ID": Integer; TChannel: Enum "Transaction Channel"; ProcessInstruction: Boolean)
                            SaccoTrans.GenerateMemberRepaymentJournals(JTemplate, JBatch, DocNo, ExtDoc, PDate, SkyTrans."Transaction Description", PDate, RunBal, SavAcc."Member No.", Loans."Loan No.", AccNo, BalAccType::Savings, DimID, TChannel, true);
                        end;

                    end
                    else begin

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, CopyStr(SkyTrans."Destination Account", 1, MaxStrLen(AccNo)), CopyStr(Format(SkyTrans."Transaction Description") + ' on ' + format(SkyTrans."Transaction Date"), 1, 100), Balacctype::"G/L Account",
                                      '', -TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                    end;



                    if TotalCharge > 0 then begin


                        GetSkyChargeDebitAccount(SkyMobileSetup, AccountToCharge, ChargeDebitAcctType, ChargeDebitAcctNo);

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, ChargeDebitAcctType, ChargeDebitAcctNo, CopyStr(SkyTrans."Transaction Description" + ' Charges', 1, 100), Balacctype::"G/L Account",
                                      '', VendorCommission + SaccoFee + SafcomFee + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SaccoAccount, CopyStr(SkyTrans."Transaction Description" + ' Charges', 1, 100), Balacctype::"G/L Account",
                                      '', -SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, ChargeDebitAcctType, ChargeDebitAcctNo, CopyStr('SMS Charge - ', 1, 100), Balacctype::"G/L Account",
                                      SMSAccount, SMSCharge, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,Accttype::Savings,AccountToCharge,COPYSTR('Excise Duty ',1,100),BalAccType::"G/L Account",
                        //            ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty ', 1, 100), Balacctype::"G/L Account",
                                      '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);



                        ExtDoc := AccNo;

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, VendorAccount, CopyStr('Fee on ' + SkyTrans."Transaction Description", 1, 100), Balacctype::"G/L Account",
                                      '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);


                    end;

                    SkyTrans.Posted := true;
                    SkyTrans."Needs Change" := false;
                    SkyTrans."Posted By" := UserId;
                    SkyTrans."Posting Date" := Today;
                    SkyTrans.Modify;
                    Response := true;


                    SaccoTrans.JournalPost(JTemplate, JBatch);

                    msg :=
                           'Dear ' + SavAcc.Name + ',' + NewLine + 'Your Funds Transfer request of KES ' + Format(SkyTrans."Transaction Amount") +
                           ' from A/C ' + SkyTrans."Source Account" +
                           ' to A/C ' + SkyTrans."Destination Account" + ' on ' + Format(ddMMyyyy(SkyTrans."Transaction Date")) +
                           ' has been completed successfully.' + NewLine + 'Ref: ' + SkyTrans."Originator ID";

                    if MobileNo = '' then
                        MobileNo := SavAcc."Mobile Phone No.";


                    SendSMS.SendSms(SMSSource::SkyMobile, MobileNo, msg, DocNo, '', TRUE, 0, FALSE);

                    if Destination.Get(SkyTrans."Destination Account") then begin
                        if Destination."Member No." <> SavAcc."Member No." then begin
                            Members.Get(Destination."Member No.");
                            MobileNo := Members."Mobile Phone No.";
                            if MobileNo = '' then
                                MobileNo := Destination."Mobile Phone No.";

                            msg := 'Dear ' + Destination.Name + ',' + NewLine + 'Your account has been credited with KES ' + Format(SkyTrans."Transaction Amount") +
                               ' from ' + SavAcc.Name + ' on ' + Format(ddMMyyyy(Today)) + '.' + NewLine + 'Ref: ' + SkyTrans."Originator ID";

                            SendSMS.SendSms(SMSSource::SkyMobile, MobileNo, msg, DocNo, '', TRUE, 0, FALSE);
                        end;
                    end;
                    /*if (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Mini-Statement") and (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Balance Enquiry") then
                        if (SkyTrans."Transaction Type" <> SkyTrans."transaction type"::"Mobile App Login") then
                            SendSmsWithID(Source::SkyMobile, MobileNo, msg, Format(SkyTrans."Originator ID"), '', true, 0, false, 'CBS', '', 'CBS');*/

                end;
            end;
        end;

    end;

    procedure VariationLog(MemberNo: Code[20]; Acc: Code[20]; RepayAmt: Decimal; Type: Option LOAN,SAVINGS)
    var
        LChanges: Record "Loan Changes";
        MChanges: Record "Member Changes";
    begin
        case Type of

            Type::LOAN:
                begin
                    LChanges.Init();
                    LChanges.validate("Member No.", MemberNo);
                    LChanges."Type of Change" := LChanges."Type of Change"::"Loan Rescheduling";
                    LChanges.validate("Loan No.", Acc);
                    LChanges.Remarks := 'MBanking Loan Change';
                    LChanges."Adjusted Repayment" := RepayAmt;
                    LChanges.Insert(true);
                end;

            Type::SAVINGS:
                begin
                    MChanges.Init();
                    MChanges.Validate("Member No.", MemberNo);
                    MChanges."Change Type" := MChanges."Change Type"::"Account Details";
                    MChanges.Validate("Account No.", Acc);
                    MChanges."New Monthly Contribution" := RepayAmt;
                    MChanges."Reason For Change" := 'MBanking Savings adjustment';
                    MChanges.Insert(true);
                end;

        end;
    end;


    procedure CallServiceFunction(i: Text[30])
    var
        TestDate: Date;
        SkyTransactions: Record "Sky M-Banking Transactions";
        MobileLoan: Record "Sky Mobile Loans";
        RandNo: Integer;
        Loans: Record Loans;
        SavAcc: Record "Savings Accounts";
        SpotCash: Codeunit "SpotCash Mbanking";
        j: Integer;
        MZawadi: Codeunit MZawadi;
        GenSetup: Record "Sacco Setup";
        MobileLoanBuffer: record "Sky Mobile Loans";
        LoanProduct: Record "Product Setup";
        Stop: Boolean;
        Response: Text;
    begin
        //i:=10000;
        RandNo := Random(6);
        Response := 'SUCCESS';
        case i of
            'WITHDRAWAL':
                begin

                    //Mpesa Deposit
                    SkyTransactions.Reset();
                    if RandNo MOD 2 = 0 then
                        SkyTransactions.Ascending(false)
                    else
                        SkyTransactions.Ascending(false);
                    SkyTransactions.SetRange(Posted, false);
                    SkyTransactions.SetRange("Needs Change", false);
                    SkyTransactions.SetFilter("Originator ID", '<>%1', '');
                    SkyTransactions.SetFilter("Transaction Type", '%1|%2|%3', SkyTransactions."Transaction Type"::"Mpesa Withdrawal", SkyTransactions."Transaction Type"::"Bank Transfer", SkyTransactions."Transaction Type"::"Utility Payment");
                    if SkyTransactions.Find('-') then begin
                        repeat
                            PostWithdrawalTransaction(SkyTransactions."originator ID");
                        until SkyTransactions.Next = 0;
                    end;
                    Commit;
                end;
            'DEPOSIT', 'MPESA_DEPOSITS':
                begin
                    //Mpesa Deposit
                    SkyTransactions.Reset();
                    if RandNo MOD 2 = 0 then
                        SkyTransactions.Ascending(false)
                    else
                        SkyTransactions.Ascending(false);
                    SkyTransactions.SetRange(Posted, false);
                    SkyTransactions.SetRange("Needs Change", false);
                    SkyTransactions.SetFilter("Originator ID", '<>%1', '');
                    SkyTransactions.SetRange("Transaction Type", SkyTransactions."Transaction Type"::"Mpesa Deposit");
                    if SkyTransactions.Find('-') then begin
                        repeat
                            PostMpesaDepositsTransaction(SkyTransactions."Originator ID");
                        until SkyTransactions.Next = 0;
                    end;
                    Commit;
                end;
            'LOAN_REPAYMENT':
                begin

                end;
            'MOBILE_LOAN_DISBURSEMENT':
                begin
                    MobileLoanBuffer.Reset();
                    MobileLoanBuffer.SetRange(Status, MobileLoanBuffer.Status::Approved);
                    MobileLoanBuffer.SetRange(Posted, false);
                    if MobileLoanBuffer.FindSet() then
                        repeat
                            CreateLoanRecord(MobileLoanBuffer, MobileLoanBuffer."Loan Product Type");
                        until MobileLoanBuffer.Next() = 0;

                end;
            'INTERNAL':
                begin
                    //To be removed
                    SkyTransactions.Reset();
                    if RandNo MOD 2 = 0 then
                        SkyTransactions.Ascending(false)
                    else
                        SkyTransactions.Ascending(false);
                    SkyTransactions.SetRange(Posted, false);
                    SkyTransactions.SetRange("Needs Change", false);
                    SkyTransactions.SetFilter("Originator ID", '<>%1', '');
                    SkyTransactions.SetFilter("Transaction Type", '%1|%2', SkyTransactions."Transaction Type"::"Account Balance Enquiry", SkyTransactions."Transaction Type"::"Loan Balance Enquiry");
                    if SkyTransactions.Find('-') then begin
                        repeat
                            PostBalanceEquiryTransaction(SkyTransactions."Originator ID");
                        until SkyTransactions.Next = 0;
                    end;

                end;
        end


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

    procedure ddMMyyyy(Date: Date) NewDate: Text
    var
        d: Text;
        m: Text;
        y: Text;
    begin
        NewDate := '';


        if Date <> 0D then begin

            d := Format(Date2dmy(Date, 1));
            m := Format(Date2dmy(Date, 2));
            y := Format(Date2dmy(Date, 3));

            if StrLen(d) = 1 then
                d := '0' + d;

            if StrLen(m) = 1 then
                m := '0' + m;

            NewDate := d + '/' + m + '/' + y;

        end;
    end;

    local procedure GetSkyChargeDebitAccount(SkyMobileSetup: Record "Sky Mobile Setup."; DefaultSavingsAccountNo: Code[20]; var ChargeDebitAcctType: Enum "Gen. Journal Account Type"; var ChargeDebitAcctNo: Code[20])
    begin
        if SkyMobileSetup."Non-Member Debit Account" <> '' then begin
            ChargeDebitAcctType := ChargeDebitAcctType::"G/L Account";
            ChargeDebitAcctNo := SkyMobileSetup."Non-Member Debit Account";
        end else begin
            ChargeDebitAcctType := ChargeDebitAcctType::Savings;
            ChargeDebitAcctNo := DefaultSavingsAccountNo;
        end;
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

    [TryFunction]
    local procedure TryResolveSavingsAccountByKeyword(var SkyTrans: Record "Sky M-Banking Transactions"; var SavAcc: Record "Savings Accounts"; var AccNo: Code[20]; var Distribute: Boolean)
    var
        MpesaActivities: Codeunit "Mpesa Activities";
    begin
        if not MpesaActivities.ResolveSavingsAccountByKeyword(SkyTrans, SavAcc, AccNo, Distribute) then
            Error('No keyword/product mapping found for account %1.', SkyTrans."Savings Account");
    end;


    var

        ExciseDutyGL: Code[20];
        ExciseDutyRate: Decimal;
        ExciseDuty: Decimal;
        Value: Decimal;
        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
        Acc: Text[20];
        TChannel: Enum "Transaction Channel";
        HMember: Record Members;
        MActivities: Codeunit "Member Activities";
        SMSSource: enum "SMS Source Enum";
        SendSMS: Codeunit "Sky MBanking";

        legacy: Codeunit Legacy;
}
