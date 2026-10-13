Codeunit 50067 "Sky MBanking"
{



    trigger OnRun()
    var
        Pin: Text;
        PayBillAccNo: Code[20];
        AccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Share Capital","Deposit Contribution","Deposit Contribution Micro","Retirement Saving Fund","Registration Fee","Insurance Contribution","FOSA SHARES";
        MobileLoans: Record "Sky Mobile Loans";
        SavAcc: Record "Savings Accounts";
        OutPut: Boolean;
        LNo: Code[20];
        "Key": Code[10];
        EDate: DateTime;
        SDate: DateTime;
        TIme: Time;
    begin
        Pin := '34a4db24ab016f8cc8524ff566f0e8dbf6db4008041c9cf0d66c3ed8b76101ac790d7944b983ad27252bdf39417a9954270722dee4af2da73cc3791034578156';

        // Message(GetLoanAccessSetup('254727148630'));
        //AccNo := '0101-001-04601';
        //MESSAGE(format(GetAbilityToRepay(AccNo)));
        //MESSAGE(GetLoansToTopUp('254721222455',1,30000));   //*fget***
        //MESSAGE(ApplyLoan(CREATEGUID,'M-LOAN1','254722414270','M-LOAN',20000,'',3));
        //CallServiceFunction(1);
        //MESSAGE(GetSavingsAccountList('254728595808', 'ALL'));         //
        //MESSAGE(FORMAT(GenerateNewPIN('254706405989')));
        //MESSAGE(FORMAT(ReverseWithdrawalRequest('E82FE6AC-4269-47C3-8081-88E6F0A4CB84')));
        //MESSAGE(FORMAT(CheckIfServiceIsEnabledForUser('254720423063', 'B2B')));
        //fAccountBalanceEnquiryMESSAGE(AccountBalanceEnquiryMobileApp(CREATEGUID,'MAPPTEST001','254720423063',PIN,'0103-001-00807'));
        //
        // MESSAGE('%1',GetAccountBalance('0102-001-02102'));
        ///22145678GetLoanQualifiedAmount(AccountNo : Code[20];LoanProductType : Code[20]) : Decimal
        //    Message(Format(GetLoanQualifiedAmount('0102-06349','L43')));
        // Message(GetLoanLimit('254791011957', 'L43'));
        //GetAccountFromKeyWord('22145678VIJANA',AccNo,LoanAccount,DepositAccount,IDNo,MNo,BosaTransType);
        //Message('AccNo %1\LoanAccount %2\DepositAccount %3\IDNo %4\MNo %5\BosaTransType %6',AccNo,LoanAccount,DepositAccount,IDNo,MNo,BosaTransType);
        //MESSAGE(AccountBalanceEnquiry(CREATEGUID,'TEST0004','254706405989','1234','FOSA'));
        //message(InsertMpesaTransaction(Createguid,'TEST0030','Paybill','Test Paybilee Transactions','22218653SC',1600,'254721856129',Pin,'','',''));
        //Message(InsertMpesaTransaction('{E312FB3A-05AA-4261-B308-8D50EECDB7E2}','TEST0003','Mpesa Withdrawal','cash Withdrawal','0101-001-00807',500,'254720423063','1234'));
        //GetUnsentSMS//MESSAGE(InsertMpesaTransaction(CREATEGUID,'TEST0013','Loan Repayment','cash deposit','LOANLB007976',3000,'254720423063','1234'));
        //MESSAGE(AccountTransfer(createguid,'TEST0010','254720423063','LB008769','Loan Payment from Account',2000,'1234',true));
        //MESSAGE(AccountTransfer(CREATEGUID,'TEST0021','254720423063','0103-001-00807','ACCOUNT',300,Pin,FALSE,false,'0101-001-00807'));
        //MESSAGE(GetLoanLimit('254721222455','M-LOAN'));
        //MESSAGE('%1',MobileLoanLimit('+254720423063','SA'));
        //GetMaximumSalaryAdvance(TelephoneNo : Text[30];LoanType : Text) LoanAmount : Decimal
        //MESSAGE(ApplyLoan(CREATEGUID,'TEST00109','254718079106','M-LOAN',50000,Pin,5));
        //ProcessMobileLoan('{F03B9655-1CEE-4954-BA02-DBB74C0ED3C7}');
        //ApplyLoan(EntryCode : GUID;TransactionID : Code[20];Phone : Code[20];LoanType : Code[20];LoanAmount : Decimal;PIN : Text) Response : Text
        //AccountTransfer(EntryCode : GUID;TransactionID : Code[20];MobileNo : Code[20];ToAccount : Code[20];Destination : Text;TransAmount : Decimal;PIN : Code[10];PayLoan : Boolean) Response : Text
        // MESSAGE(GetMobileLoanList('254723135089'));
        // MESSAGE(GetLoanLimit('254702875797', 'L43'));
        //MESSAGE(GetMobileLoanList('254722620844'));
        //MESSAGE(GetMobileLoanList('254721856129'));
        //MESSAGE(PostMpesaTransaction('TEST0030'));
        //ReCheckLoanTransaction;
        //MESSAGE(GetLoanPeriods('254722620844','M-LOAN',1));//0722414270
        //MESSAGE(GetLoanPeriods('254722414270','DIVIDEND',0));
        //MESSAGE(GetMemberLoanListMobileApp('254721222455'));
        //MESSAGE(GetMemberLoanList('254721222455'));
        //AddLoanDue;
        //AccountMiniStatementMobileApp(CREATEGUID,'MINI1',5,20210101D,TODAY,StatementAccount : Code[20];MobileNo : Code[20];Pin : Text) Response : Text +254790433990
        //MESSAGE('Finished');
        //MESSAGE(COPYSTR('344977SD',1,1));

        //MESSAGE(GetLoanPeriods('254721856129','M-LOAN',0));


        //MESSAGE(GetLoansToTopUp('254718079106',3,50000));   //*f***
        //MESSAGE(FORMAT(GetLoansToTopUpLocal('+254718079106',3,12000)));

        //MESSAGE(GetSavingsAccountList('254721206769','LOAN_ACCOUNT'));
        //TransferMbankingUsers;
        //OutPut := EmployerRestriction('254722620844','Bank Transfer Request');
        //MESSAGE(FORMAT(OutPut));

        //MESSAGE(AccountBalanceEnquiry(CREATEGUID,'TEST0009','254726563563','1234','FOSA'));
        //MESSAGE(AccountBalanceEnquiry(CREATEGUID,'TEST0010','254721206769','1234','FOSA'));
        //MESSAGE(AccountBalanceEnquiry(CREATEGUID,'TEST0011','254728152774','1234','FOSA'));


        //GetAccountFromKeyWord(MpesaTrans."Member Account",MAccNo,LoanAccount,DepositAccount,IDNo,MNo,BosaTransType,Key,LNo);

        //GetAccountFromKeyWord('24411818MFS',AccNo,LoanAccount,DepositAccount,IDNo,MNo,BosaTransType,Key,LNo);
        //MESSAGE('AccNo %1\LoanAccount %2\DepositAccount %3\IDNo %4\MNo %5\BosaTransType %6\Key %7\LNo %8',AccNo,LoanAccount,DepositAccount,IDNo,MNo,BosaTransType,Key,LNo);

        //MESSAGE(AccountMiniStatement(CREATEGUID,'MT0002',5,'D000023','254726563563','123'));
        //Message('Text1'+NewLine+'Text2');

        //Message(GetATMCards('254728152774'));

        /*
        Loans.RESET;
        Loans.SETRANGE(Loans.Posted,TRUE);
        Loans.SETRANGE(Loans."Loan Product Type",'INUABIZ');
        Loans.SETFILTER("Outstanding Principal",'>0');
        IF Loans.FINDFIRST() THEN BEGIN
            REPEAT
                UpdateMAnalysis(Loans);
            UNTIL Loans.NEXT =0;
        
        END;
        */
        //MESSAGE(GetMemberBalances('254721206769','ACCOUNTS'));
        //MESSAGE(GetMemberBalances('254726563563','ACCOUNTS'));

        //Message(AccountMiniStatementMobileAppB64(20210101D,today,'68260200445301'));
        //MESSAGE(AccountBalanceEnquiry(format(123456),'TEST0001','254721206769','1234','BOSA'));
        //MESSAGE(AccountBalanceEnquiry(format(123459),'TEST0001','254726563563','1234','BOSA'));


        EDate := CurrentDatetime;
        SDate := EDate + 3600000;//((1000*60)*60);
        SDate := CreateDatetime(Today - 1, Dt2Time(SDate));

        //MESSAGE('%1\%2',SDate,EDate);

        //MESSAGE(GetMemberLoanList('254721206769'));
        //MESSAGE(LoanMiniStatement('123125','TR0001',5,'LN00175806','254726563563','1234'));
        //MESSAGE(LoanMiniStatement('123126','TR0001',5,'LN00183676','254728152774','1234'));

        //Message(GetSavingsAccountList('254701365086', 'LOAN_ACCOUNT'));

        //PostMpesaTransaction('QKU8YVUEQS');

        //'+254726563563|+254721206769|+254728152774'
        //SendSms('START_PIN','254726563563','Test SMS','','',FALSE,Priority,FALSE);
        //SendSms('START_PIN','254721206769','Test SMS','','',FALSE,Priority,FALSE);
        //SendSms('START_PIN','254728152774','Test SMS','','',FALSE,Priority,FALSE);


        //GenerateStartPins;
        //SendStartPins;

        //CallServiceFunction(1);
        //PostPendingCharges;
        //RecoverDefaultedLoans();
        //RecoverDefaultedMobileLoans('');

        // Message(GetAdvancedMobileLoanList('254720838251', 'FOOSA', ''));

        //Pin := copystr(format(createguid), 1, 20);


        //InsertMpesaTransaction(Pin, Pin, 'Till Purchase Request', 'Till Purchase Request', '0102-14805', 20000, '254720838251', pin, 'RequestApplication', 'RequestCorrelationID', 'SourceApplication');
        //InsertMpesaTransaction(Pin, Pin, 'Till Purchase', 'Till Purchase', '0102-14805', 20000, '254720838251', pin, 'RequestApplication', 'RequestCorrelationID', 'SourceApplication');
        //PostMpesaTransaction(Pin);
        //CallServiceFunction(4);
        Message('Done');
    end;

    var
        MActivities: codeunit "Member activities";
        Channel: Enum "Transaction Channel";
        Image: Codeunit Image;

        RespCode: Text[10];
        Legacy: COdeunit Legacy;
        ChargeCode: Code[20];
        Value: Decimal;
        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
        Loans: Record Loans;
        ExciseDutyGL: Code[20];
        ExciseDutyRate: Decimal;
        ExciseDuty: Decimal;
        CoopSetup: Record "Sky Mobile Setup.";
        SpotSetup: Record "SpotCash Setup";
        //SaccoTrans: Codeunit "Sky Transactions";
        SaccoTrans: Codeunit "Sacco Activities";
        Source: Enum "SMS Source Enum";
        Account: Record "Savings Accounts";
        Auth: Record "Sky USSD Auth";
        Priority: Integer;
        SMSCharge: Decimal;
        SMSAccount: Code[20];
        GenJournalBatch: Record "Gen. Journal Batch";
        LGCount: Integer;
        CheckDate: Date;
        RemInst: Integer;
        LoaneeDepAcc: Code[20];
        STOFound: Boolean;
        Members: Record Members;
        CreditLimit: Decimal;
        TestDate: Date;
        AccName: Text;
        LastPaymentDate: Date;
        D: Integer;
        Duration: Integer;
        AmountD: Decimal;
        Days: Integer;
        MLoanFailed: Boolean;
        GenSetup: Record "Sacco Setup";
        KeyWord: Record "Loan Paybill Keywords";
        CMember: Record Members;
        LoanType: Record "Product Setup";
        vendor: Record "Savings Accounts";
        BosaEntry: Option "None","Loan Repayment","Share Capital","Deposit Contribution","Deposit Contribution Micro","Retirement Saving Fund","Registration Fee","Insurance Contribution","FOSA SHARES","RSF MICRO","Fosa Shares Micro";
        k: Integer;
        MonthlySal: Decimal;
        CompName: label 'Ports Sacco Ltd';
        PostInterestDue: Boolean;
        InterestGL: Code[20];
        AccountPrefix: label '68260';
        AccountSuffix: label '01';
        ShareTradeMinimum: label '20';
        ShareTradeMaximum: label '30';
        MinimumShareCapital: label '10000';
        ShortCode: label '*882#';
        MbankingName: label 'MPORT';
        MinShareToBuy: label '25';
        TransactionsBuffer: Record "Transactions Buffer";
        LoanStage: Option " ","Stage 1","Stage 2","Stage 3";


    procedure GetMemberDetails(payloadText: Text) Response: Text
    var

        Members: Record Members;
        PayloadToken: jsontoken;
        PayloadObj: JsonObject;
        payloadjsonresponse: JsonObject;
        responseObject: JsonObject;
        error_responseObj: JsonObject;
        Identifier_type: text;
        identifier: text;
        Savacc: record "Savings Accounts";
        SavNo: text;
        PhoneNo: text;

    begin
        If payloadText <> '' then begin
            if PayloadToken.ReadFrom(payloadText) then begin
                if PayloadToken.IsObject() then begin
                    PayloadObj := PayloadToken.AsObject();
                    if GetTextValue(PayloadObj, 'identifier_type', Identifier_type) and
                       GetTextValue(PayloadObj, 'identifier', identifier) then begin


                        Members.Reset();
                        if identifier_type = 'CUSTOMER_NO' then
                            Members.SetRange("No.", identifier);
                        if identifier_type = 'NATIONAL_ID' then
                            Members.SetRange("ID No.", identifier);
                        if identifier_type = 'MSISDN' then begin
                            SAVACC.RESET();
                            SAVACC.SETRANGE("Transactional Mobile No", identifier);
                            IF SAVACC.FINDFIRST THEN
                                Members.SetRange("No.", SAVACC."Member No.");

                        end;
                        IF Members.findfirst then begin
                            PhoneNo := '';

                            savacc.reset;
                            savacc.setrange("Member No.", Members."No.");
                            savacc.setrange("product category", savacc."product category"::"Ordinary Savings");
                            savacc.SetFilter("Transactional Mobile No", '<>%1', '');
                            if savacc.findfirst then begin
                                savno := savacc."No.";
                                phoneNo := savacc."Transactional Mobile No";
                            end;

                            payloadjsonresponse.Add('customer_type', 'INDIVIDUAL');
                            payloadjsonresponse.Add('identifier_type', identifier_type);
                            payloadjsonresponse.Add('identifier', identifier);
                            payloadjsonresponse.Add('primary_identity_type', 'NATIONAL_ID');
                            payloadjsonresponse.Add('primary_identity_no', Members."ID No.");
                            payloadjsonresponse.Add('title', Members."salutation code");
                            payloadjsonresponse.Add('full_name', Members.Name);
                            payloadjsonresponse.Add('gender', format(Members.gender));
                            payloadjsonresponse.Add('date_of_birth', Format(Members."Date of Birth", 0, '<Day,2>/<Month,2>/<Year4>'));
                            payloadjsonresponse.Add('primary_email_address', Members."E-Mail");
                            payloadjsonresponse.Add('primary_mobile_number', PhoneNo);
                            payloadjsonresponse.Add('status', Format(Members."Member Status"));
                            payloadjsonresponse.Add('registration_date', Members."Registration Date");
                            payloadjsonresponse.Add('tax_authority', '');
                            payloadjsonresponse.Add('tax_authority_pin_number', '');
                            payloadjsonresponse.Add('branch_code', Members."global dimension 2 code");
                            payloadjsonresponse.Add('branch', Members."Global dimension 2 code");


                            payloadjsonresponse.Add('main_saving_account_no', savno);

                            //CreateActual response
                            responseObject.add('request_status', 'SUCCESS');
                            responseObject.add('response_payload', payloadjsonresponse);

                            responseObject.writeTo(response);

                        end
                        else begin
                            error_responseObj.add('error_message', 'Member Not Found');
                            responseObject.add('request_status', 'ERROR');
                            responseObject.add('response_payload', error_responseObj);
                            responseObject.writeTo(response);

                        end;
                    end
                    else begin
                        error_responseObj.add('error_message', 'Invalid Identifier Type');
                        responseObject.add('request_status', 'ERROR');
                        responseObject.add('response_payload', error_responseObj);
                        responseObject.writeTo(response);

                    end;
                end
                else begin
                    error_responseObj.add('error_message', 'Unable to Read Payload');
                    responseObject.add('request_status', 'ERROR');
                    responseObject.add('response_payload', error_responseObj);
                    responseObject.writeTo(response);

                end;
            end
            else begin
                error_responseObj.add('error_message', 'Unable to Read Payload');
                responseObject.add('request_status', 'ERROR');
                responseObject.add('response_payload', error_responseObj);
                responseObject.writeTo(response);

            end;

        end
        else begin
            error_responseObj.add('error_message', 'Unable to Read Payload');
            responseObject.add('request_status', 'ERROR');
            responseObject.add('response_payload', error_responseObj);
            responseObject.writeTo(response);

        end;
    end;

    local procedure GetTextValue(var obj: JsonObject; Keys: text; var Value: text): Boolean
    var
        tok: jsontoken;
    begin
        if obj.Get(Keys, tok) and tok.IsValue() then begin
            Value := tok.AsValue().AsText();
            exit(true);

        end;
        exit(false);
    end;

    procedure GetExciseRate() rate: Integer
    var
        GenSetup: Record "Sacco Setup";
    begin


        GenSetup.Get;
        //GenSetup.TestField(GenSetup."Excise Duty (%)");
        rate := GenSetup."Excise Duty (%)";
    end;


    procedure GetExciseDutyGL() account: Text[20]
    var
        GenSetup: Record "Sacco Setup";
    begin

        GenSetup.Get;
        if GenSetup."Excise Duty (%)" > 0 then
            GenSetup.TestField(GenSetup."Excise Duty GL");
        account := GenSetup."Excise Duty GL";
    end;


    procedure GetSavingsAccountTypes() Response: Text
    var
        PFact: Record "Product Setup";
    begin

        Response := '';

        PFact.Reset;
        PFact.SetFilter("Mobile Transaction", '<>%1', PFact."mobile transaction"::" ");
        if PFact.FindFirst then begin
            Response := '<SavingsProducts>';
            repeat
                if PFact."USSD Product Name" = '' then
                    PFact."USSD Product Name" := PFact.Description;
                Response += '<Product>';
                Response += '<ProductID>' + PFact."Product ID" + '</ProductID>';
                Response += '<ProductName>' + PFact."USSD Product Name" + '</ProductName>';
                Response += '</Product>';
            until PFact.Next = 0;
            Response += '</SavingsProducts>';
        end;
    end;


    procedure GetSingleAccount(PhoneNo: Text[30]; AccountType: Code[20]) Response: Text
    var
        SavAcc: Record "Savings Accounts";
        PFact: Record "Product Setup";
        XMLDOMMgt: Codeunit "XML DOM Management";
        AccName: Text;
    begin

        PhoneNo := '+' + PhoneNo;

        Response := '';


        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        SavAcc.SetRange("Product Type", AccountType);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin
            Response := ' <SavAcc>';
            repeat

                AccName := 'Un-Defined';
                if PFact.Get(SavAcc."Product Type") then begin

                    if PFact."USSD Product Name" = '' then
                        PFact."USSD Product Name" := PFact.Description;

                    AccName := PFact."USSD Product Name";
                    if AccName = '' then
                        AccName := PFact.Description;
                end;

                Response += '<Account>';
                Response += '<AccNo>' + SavAcc."No." + '</AccNo>';
                Response += '<AccName>' + AccName + '</AccName>';
                Response += '</Account>';
            until SavAcc.Next = 0;
            Response += '</SavAcc>';
        end;


        //Response:='';
    end;


    procedure GetAccountList(PhoneNo: Text[30]) Response: Text
    var
        SavAcc: Record "Savings Accounts";
        PFact: Record "Product Setup";
        Found: Boolean;
    begin

        PhoneNo := '+' + PhoneNo;
        Response := '';
        Found := false;

        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin
            Response := '<Accounts>';
            repeat
                PFact.Get(SavAcc."Product Type");
                if PFact."Mobile Transaction" <> PFact."mobile transaction"::" " then begin
                    Found := true;

                    AccName := 'Un-Defined';
                    if PFact.Get(SavAcc."Product Type") then begin
                        if PFact."USSD Product Name" = '' then
                            PFact."USSD Product Name" := PFact.Description;

                        AccName := PFact."USSD Product Name";
                        if AccName = '' then
                            AccName := PFact.Description;
                    end;


                    Response += '<Account>';
                    Response += '<AccNo>' + SavAcc."No." + '</AccNo>';
                    Response += '<AccName>' + AccName + '</AccName>';
                    Response += '</Account>';
                end;

            until SavAcc.Next = 0;
            Response += '</Accounts>';

        end;

        if not Found then
            Response := '';
    end;


    procedure GetSavingsAccountList(PhoneNo: Text[30]; Category: Text) Response: Text
    var
        SavAcc: Record "Savings Accounts";
        ProdFact: Record "Product Setup";
        Found: Boolean;
        MemberNo: Code[20];
        FuuzaTest: Record "Fuuza Testing Accounts";
        IDNo: Code[20];
        Members: Record Members;
        AccBal: Decimal;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomFee: Decimal;
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        Legacy: Codeunit Legacy;
    begin

        PhoneNo := '+' + PhoneNo;
        Response := '';
        Found := false;



        /*
        Members.Reset();
        Members.SetFilter("Member Category", '%1|%2|%3', Members."Member Category"::"Board Members", Members."Member Category"::"Staff Members", Members."Member Category"::Delegates);
        if Members.findfirst then begin
            repeat
                FuuzaTest.init;
                FuuzaTest."Phone No." := Members."Mobile Phone No.";
                FuuzaTest.Product := FuuzaTest.Product::Fuuza;
                FuuzaTest.Status := FuuzaTest.Status::Allowed;
                if FuuzaTest.insert then;
            until Members.next = 0;
        end;
        */





        IDNo := '';
        MemberNo := '';
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        if SavAcc.FindFirst then begin
            SavAcc.CalcFields("ID No.");
            MemberNo := SavAcc."Member No.";
            IDNo := SavAcc."ID No.";

        end;



        IF MemberNo = '' THEN
            EXIT;
        //if IDNo = '' then
        //  exit;

        if not Members.Get(MemberNo) then
            MemberNo := IDNo;

        if Category = 'ALL' then begin


            ProdFact.Reset;
            ProdFact.SetCurrentkey("Sorting Order");
            ProdFact.SetFilter("Mobile Transaction", '<>%1', ProdFact."mobile transaction"::" ");
            if ProdFact.FindFirst then begin
                Response := '<Accounts>';
                repeat
                    //MESSAGE(Category);
                    SavAcc.Reset;
                    SavAcc.SetRange("Member No.", MemberNo);
                    SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
                    SavAcc.SetFilter("Product Type", '%1', ProdFact."Product ID");
                    if SavAcc.Find('-') then begin
                        Repeat
                            Found := true;

                            if ProdFact."USSD Product Name" = '' then
                                ProdFact."USSD Product Name" := ProdFact.Description;

                            AccName := ProdFact."USSD Product Name";
                            if AccName = '' then
                                AccName := ProdFact.Description;

                            Response += '<Account>';
                            Response += '<AccNo>' + SavAcc."No." + '</AccNo>';
                            Response += '<AccName>' + SavAcc."Product Name" + '</AccName>';
                            Response += '</Account>';
                        until SavAcc.next = 0;
                    end;
                until ProdFact.Next = 0;



                Response += '</Accounts>';
            end;

        end
        else
            if Category = 'STATEMENT' then begin



                SavAcc.Reset;
                SavAcc.SetRange("Member No.", MemberNo);
                if SavAcc.Find('-') then begin
                    Response := '<Accounts>';


                    repeat
                        Found := true;

                        Response += '<Account>';
                        Response += '<AccNo>' + SavAcc."No." + '</AccNo>';
                        Response += '<AccName>' + SavAcc."Product Name" + '</AccName>';
                        Response += '</Account>';
                    until SavAcc.Next = 0;
                    Response += '</Accounts>';

                end;

            end
            else
                if Category = 'LOAN_ACCOUNT' then begin




                    ProdFact.Reset;
                    ProdFact.SetCurrentkey("Sorting Order");
                    ProdFact.SETFILTER("Mobile Transaction", '%1', ProdFact."Mobile Transaction"::"Deposits & Withdrawals");
                    //ProdFact.SetRange("Available on Mobile", true);
                    if ProdFact.FindFirst then begin
                        Response := '<Accounts>';
                        repeat
                            //MESSAGE(Category);
                            SavAcc.Reset;
                            SavAcc.SetRange("Member No.", MemberNo);
                            SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
                            SavAcc.SetFilter("Product Type", '%1', ProdFact."Product ID");
                            if SavAcc.Find('-') then begin
                                Found := true;

                                if ProdFact."USSD Product Name" = '' then
                                    ProdFact."USSD Product Name" := ProdFact.Description;

                                AccName := ProdFact."USSD Product Name";
                                if AccName = '' then
                                    AccName := ProdFact.Description;

                                Response += '<Account>';
                                Response += '<AccNo>' + SavAcc."No." + '</AccNo>';
                                Response += '<AccName>' + SavAcc."Product Name" + '</AccName>';
                                Response += '</Account>';

                            end;
                        until ProdFact.Next = 0;
                        Response += '</Accounts>';
                    end;
                    /*
                    //MESSAGE(Category);
                    Members.RESET;
                    Members.SETRANGE("ID No.",IDNo);
                    Members.SETFILTER(Status,'<>%1',SavAcc.Status::Deceased);
                    IF Members.FIND('-') THEN BEGIN
                        Response:='<Accounts>';
                        REPEAT
                            Found:=TRUE;
                            Response+='<Account>';
                                Response+='<AccNo>'+Members."FOSA Account"+'</AccNo>';
                                Response+='<AccName>'+Members."FOSA Account"+'</AccName>';
                            Response+='</Account>';
                        UNTIL Members.NEXT=0;
                        Response+='</Accounts>';
                    END;
                    */
                end
                else
                    if Category = 'SHARE_CAPITAL' then begin

                        //MESSAGE(Category);
                        Members.Reset;
                        Members.SetRange("No.", MemberNo);
                        Members.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
                        if Members.Find('-') then begin
                            Response := '<Accounts>';
                            repeat
                                Found := true;
                                Response += '<Account>';
                                Response += '<AccNo>' + Legacy.GetShareCapitalAccount(Members."No.") + '</AccNo>';
                                Response += '<AccName>' + Members."No." + '</AccName>';
                                Response += '</Account>';
                            until Members.Next = 0;
                            Response += '</Accounts>';
                        end;

                    end
                    else
                        if Category = 'BOSA' then begin


                            ProdFact.Reset;
                            ProdFact.SetCurrentkey("Sorting Order");
                            ProdFact.SETFILTER("Global Dimension 1 Code", 'BOSA');
                            //ProdFact.SetRange("Available on Mobile", true);
                            if ProdFact.FindFirst then begin
                                Response := '<Accounts>';
                                repeat
                                    //MESSAGE(Category);
                                    SavAcc.Reset;
                                    SavAcc.SetRange("Member No.", MemberNo);
                                    SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
                                    SavAcc.SetFilter("Product Type", '%1', ProdFact."Product ID");
                                    if SavAcc.Find('-') then begin
                                        Found := true;

                                        if ProdFact."USSD Product Name" = '' then
                                            ProdFact."USSD Product Name" := ProdFact.Description;

                                        AccName := ProdFact."USSD Product Name";
                                        if AccName = '' then
                                            AccName := ProdFact.Description;

                                        Response += '<Account>';
                                        Response += '<AccNo>' + SavAcc."No." + '</AccNo>';
                                        Response += '<AccName>' + SavAcc."Product Name" + '</AccName>';
                                        Response += '</Account>';

                                    end;
                                until ProdFact.Next = 0;
                                Response += '</Accounts>';
                            end;



                        end
                        else begin

                            ProdFact.Reset;
                            ProdFact.SetCurrentkey("Sorting Order");
                            if (Category = 'WITHDRAWABLE') or (Category = 'TRANSFERRABLE') or (Category = 'TRANSFERRABLE_TO_BANK') then
                                ProdFact.SetFilter("Mobile Transaction", '%1', ProdFact."mobile transaction"::"Deposits & Withdrawals")
                            else begin
                                if (Category = 'OVER_WITHDRAWABLE') then begin
                                    ProdFact.SetFilter("Mobile Transaction", '%1', ProdFact."mobile transaction"::"Deposits & Withdrawals");
                                    ProdFact.setrange("Allow Fuuza", true);

                                    FuuzaTest.reset;
                                    FuuzaTest.setrange("Phone No.", PhoneNo);
                                    FuuzaTest.SetRange(Product, FuuzaTest.Product::Fuuza);
                                    FuuzaTest.SetRange(Status, FuuzaTest.Status::Allowed);
                                    if not FuuzaTest.findfirst then
                                        ProdFact.setrange("Product ID", 'FUUZANOTFOUND');

                                end
                                else
                                    if (Category = 'FOSA') then begin
                                        ProdFact.SetFilter("Mobile Transaction", '<>%1', ProdFact."mobile transaction"::" ");
                                    end
                                    else begin
                                        //ProdFact.SetFilter("Mobile Transaction", 'Un-Defined');
                                        ProdFact.SetFilter("Mobile Transaction", '%1', ProdFact."mobile transaction"::"Deposits & Withdrawals");
                                    end;
                            end;
                            if ProdFact.FindFirst then begin
                                Response := '<Accounts>';

                                repeat


                                    //MESSAGE(Category);
                                    SavAcc.Reset;
                                    SavAcc.SetRange("Member No.", MemberNo);
                                    SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
                                    SavAcc.SetFilter("Product Type", '%1', ProdFact."Product ID");
                                    /*
                                    if (Category = 'TRANSFERRABLE_TO_BANK') then
                                        SavAcc.SetRange("Allow Bank Transfer", true);
                                    if (Category = 'WITHDRAWABLE') or (Category = 'TRANSFERRABLE') then
                                        SavAcc.SetRange("Mbanking Registered", true);
                                        */

                                    if SavAcc.Find('-') then begin
                                        Found := true;
                                        SavAcc.CalcFields("Balance (LCY)");
                                        AccBal := SavAcc."Balance (LCY)";

                                        if (Category = 'OVER_WITHDRAWABLE') or (Category = 'WITHDRAWABLE') or (Category = 'TRANSFERRABLE') or (Category = 'TRANSFERRABLE_TO_BANK') then begin

                                            AccBal := GetAccountBalance(SavAcc."No.");

                                            CoopSetup.Reset;
                                            if (Category = 'TRANSFERRABLE_TO_BANK') then
                                                //CoopSetup.SetRange("Transaction Type", CoopSetup."transaction type"::"Bank Transfer")
                                                //else
                                                //CoopSetup.SetRange("Transaction Type", CoopSetup."transaction type"::"Mpesa Withdrawal");
                                                if CoopSetup.FindFirst then begin

                                                    SMSCharge := CoopSetup."SMS Charge";

                                                    /*
                                                    SafcomCharges.RESET;
                                                    SafcomCharges.SETFILTER(Charge,'>0');
                                                    SafcomCharges.SETFILTER(Minimum,'<=%1',AccBal);
                                                    SafcomCharges.SETFILTER(Maximum,'>=%1',AccBal);
                                                    IF SafcomCharges.FINDFIRST THEN BEGIN
                                                        SafcomFee:=SafcomCharges.Charge;
                                                    END;
                                                    */


                                                    SafcomFee := 0;
                                                    if CoopSetup."Safcom Staggered Fee" then
                                                        SafcomFee := GetStaggeredSaccoFee(CoopSetup."Safcom Staggered Charge", AccBal);

                                                    SaccoFee := CoopSetup."Sacco Fee";
                                                    if CoopSetup."Sacco Staggered Fee" then
                                                        SaccoFee := GetStaggeredSaccoFee(CoopSetup."Sacco Staggered Charge", AccBal);

                                                    VendorCommission := CoopSetup."Vendor Commission";
                                                    if CoopSetup."Vendor Staggered Fee" then
                                                        VendorCommission := GetStaggeredSaccoFee(CoopSetup."Vendor Staggered Charge", AccBal);

                                                    TotalCharge := SaccoFee + VendorCommission + SafcomFee + SMSCharge;
                                                    ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);


                                                    AccBal -= (TotalCharge + ExciseDuty);
                                                end;

                                        end;

                                        if ProdFact."USSD Product Name" = '' then
                                            ProdFact."USSD Product Name" := ProdFact.Description;

                                        AccName := ProdFact."USSD Product Name";
                                        if AccName = '' then
                                            AccName := ProdFact.Description;

                                        if (Category = 'OVER_WITHDRAWABLE') then begin
                                            if GetFuuzaLimit(SavAcc."No.", Today) > 0 then begin


                                                if AccBal < 0 then
                                                    Accbal := 0;

                                                Response += '<Account>';
                                                Response += '<AccNo>' + SavAcc."No." + '</AccNo>';
                                                Response += '<AccName>' + SavAcc."Product Name" + ': KES ' + Format(AccBal) + '. Fuuza Limit (KES ' + format(GetFuuzaLimit(SavAcc."No.", Today)) + ')</AccName>';
                                                Response += '</Account>';

                                            end;
                                        end
                                        else begin

                                            Response += '<Account>';
                                            Response += '<AccNo>' + SavAcc."No." + '</AccNo>';
                                            Response += '<AccName>' + SavAcc."Product Name" + ': KES ' + Format(AccBal) + '</AccName>';
                                            Response += '</Account>';

                                        end;
                                    end;
                                until ProdFact.Next = 0;
                                Response += '</Accounts>';
                            end;
                        end;




        if not Found then
            Response := '';

    end;


    procedure InsertMpesaTransaction(EntryCode: Code[100]; TransactionID: Code[20]; Transaction: Text; Description: Text; AccountNo: Text; Amount: Decimal; PhoneNo: Code[20]; PIN: Text; RequestApplication: Text; RequestCorrelationID: Text; SourceApplication: Text) Response: Text[1024]
    var
        JTemplate: Code[10];
        JBatch: Code[10];
        PhoneConvert: Code[20];

        TransType: Enum "Transaction Type Enum";
        DocNo: Code[20];
        MActivities: Codeunit "Member Activities";
        PDate: Date;
        PSetup: Record "Product setup";
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        BalAccNo: Code[20];

        RefName: Text;
        SActivities: codeunit "Sacco Activities";
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer","Till Purchase";
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        MpesaTrans: Record "Sky Transactions.";
        Continue: Boolean;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        AccBal: Decimal;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        TransactionDate: DateTime;
        MemberID: Code[200];
        PrePaymentGL: Code[20];
        Loans: Record Loans;
        LoanNo: Code[20];
        MemberNo: Code[20];
        Type: Option Daily,Weekly,Monthly;
        Limit: Decimal;
        msg: Text;
        DepositEntry: Boolean;
        ShareEntry: Boolean;
        PayBillAccNo: Code[20];
        AccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Share Capital","Deposit Contribution","Deposit Contribution Micro","Retirement Saving Fund","Registration Fee","Insurance Contribution","FOSA SHARES","RSF MICRO","Fosa Shares Micro";
        ValidateAccount: Code[100];
        MpesaAccount: Code[50];
        Membno: Code[20];
        Members: Record Members;
        AccName: Text;
        Pos: Integer;
        TransLimit: Decimal;
    begin


        /*
        SavAcc.reset;
        SavAcc.setrange("Member No.", '18109');
        SavAcc.setrange("Product Category", SavAcc."product category"::Business);
        if not SavAcc.findfirst then begin

            Members.get('18109');
            PSetup.reset;
            PSetup.setrange("Product Category", PSetup."product category"::Business);
            if PSetup.FindFirst() then begin
                MActivities.CreateSavingsAccount(PSetup, Members, 0, True, PSetup."Repay Mode");
            end;
        end;



        SavAcc.reset;
        SavAcc.setrange("Member No.", '14805');
        SavAcc.setrange("Product Category", SavAcc."product category"::Business);
        if not SavAcc.findfirst then begin

            Members.get('14805');
            PSetup.reset;
            PSetup.setrange("Product Category", PSetup."product category"::Business);
            if PSetup.FindFirst() then begin
                MActivities.CreateSavingsAccount(PSetup, Members, 0, True, PSetup."Repay Mode");
            end;
        end;
        */


        //IF PhoneNo = '' THEN
        //  ERROR('Parameter PhoneNo Must have a value');

        PhoneNo := '+' + PhoneNo;

        MpesaAccount := '';
        if Transaction = 'Paybill' then
            MpesaAccount := AccountNo;



        if StrLen(TransactionID) > 20 then
            TransactionID := CopyStr(TransactionID, 1, 20);

        if StrLen(Description) > 50 then
            Description := CopyStr(Description, 1, 50);

        //IF (TransactionType = TransactionType::Paybill) OR (TransactionType = TransactionType::"Mpesa Withdrawal") OR (TransactionType = TransactionType::"Utility Payment") THEN BEGIN

        MpesaTrans.Reset;
        MpesaTrans.SetRange("Transaction ID", TransactionID);
        if MpesaTrans.FindFirst then begin
            Response := '<Response>';
            Response += '<Status>TRANSACTION_EXISTS</Status>';
            Response += '<StatusDescription>Transaction Already Exists</StatusDescription>';
            Response += '<Reference>' + Format(TransactionID) + '</Reference>';
            Response += '</Response>';
            exit;
        end;

        //END;


        AccName := '';
        RefName := '';
        Pos := 0;
        Pos := StrPos(AccountNo, '#');
        if Pos > 1 then begin
            AccName := CopyStr(AccountNo, Pos + 1, StrLen(AccountNo));
            AccountNo := CopyStr(AccountNo, 1, Pos - 1);
            RefName := AccName;
        end;

        if AccountNo = '' then begin
            SavAcc.Reset;
            SavAcc.SetRange("Transactional Mobile No", PhoneNo);
            if SavAcc.FindFirst then begin
                AccountNo := SavAcc."No.";
                MemberNo := SavAcc."Member No.";
            end;
        end;

        ValidateAccount := DelChr(AccountNo, '=', '12345678910');


        DepositEntry := false;
        ShareEntry := false;
        if StrLen(ValidateAccount) = 1 then begin
            if CopyStr(AccountNo, 1, 1) = 'D' then
                DepositEntry := true;
            if CopyStr(AccountNo, 1, 1) = 'S' then
                ShareEntry := true;
        end;

        BosaEntry := Bosaentry::None;

        /*
        if StrLen(ValidateAccount) = 1 then begin
            if CopyStr(AccountNo, 1, 1) = 'D' then
                BosaEntry := Bosaentry::"Deposit Contribution";
            if CopyStr(AccountNo, 1, 1) = 'R' then
                BosaEntry := Bosaentry::"Retirement Saving Fund";
            if CopyStr(AccountNo, 1, 1) = 'F' then
                BosaEntry := Bosaentry::"FOSA SHARES";

            if CopyStr(AccountNo, 1, 1) = 'I' then
                BosaEntry := Bosaentry::"Insurance Contribution";


            Members.Reset;
            Members.SetRange("No.", CopyStr(AccountNo, 2, StrLen(AccountNo)));
            Members.SetRange("Customer Type", Members."customer type"::MicroFinance);
            if Members.FindFirst then begin
                BosaEntry := Bosaentry::None;
                if CopyStr(AccountNo, 1, 1) = 'D' then
                    BosaEntry := Bosaentry::"Deposit Contribution Micro";
                if CopyStr(AccountNo, 1, 1) = 'R' then
                    BosaEntry := Bosaentry::"RSF MICRO";
                if CopyStr(AccountNo, 1, 1) = 'F' then
                    BosaEntry := Bosaentry::"Fosa Shares Micro";

            end;
        end;
        */
        //ERROR(FORMAT(BosaEntry));


        if (BosaEntry <> Bosaentry::None) then begin

            SavAcc.Reset;
            SavAcc.SetRange("Transactional Mobile No", PhoneNo);
            if SavAcc.FindFirst then begin
                SavAcc.CalcFields("ID No.");
                MemberNo := SavAcc."Member No.";
                KeyWord.Reset;
                KeyWord.SetRange("Destination Type", BosaEntry);
                if KeyWord.FindFirst then begin
                    AccountNo := MemberNo + KeyWord.Keyword;
                    if SavAcc."ID No." <> '' then
                        AccountNo := SavAcc."ID No." + KeyWord.Keyword;
                end;
            end;

        end;


        TransactionDate := CurrentDatetime;

        Response := 'ERROR';

        if StrLen(AccountNo) > 6 then
            if CopyStr(AccountNo, 1, 4) = 'LOAN' then begin
                Transaction := 'Loan Repayment';
                Description := 'Loan Repayment';
            end;


        if Transaction = 'Balance Enquiry' then
            TransactionType := Transactiontype::"Balance Enquiry";

        if Transaction = 'Loan Repayment' then
            TransactionType := Transactiontype::"Loan Repayment";

        if Transaction = 'Mini-Statement' then
            TransactionType := Transactiontype::"Mini-Statement";

        if Transaction = 'Till Purchase' then
            TransactionType := Transactiontype::"Till Purchase";

        if Transaction = 'Mpesa Deposit' then
            TransactionType := Transactiontype::"Mpesa Deposit";

        if Transaction = 'Bank Deposit' then
            TransactionType := Transactiontype::"Bank Deposit";

        if Transaction = 'Bank Agent Deposit' then
            TransactionType := Transactiontype::"Bank Agent Deposit";

        if Transaction = 'Mpesa Withdrawal' then
            TransactionType := Transactiontype::"Mpesa Withdrawal";

        if Transaction = 'Airtime Request' then
            TransactionType := Transactiontype::Airtime;

        if Transaction = 'Airtime Purchase' then
            TransactionType := Transactiontype::Airtime;



        if Transaction = 'Utility Request' then
            TransactionType := Transactiontype::"Utility Payment";

        if Transaction = 'Utility Payment' then
            TransactionType := Transactiontype::"Utility Payment";

        if Transaction = 'Withdrawal Request' then
            TransactionType := Transactiontype::"Mpesa Withdrawal";

        if Transaction = 'Paybill' then
            TransactionType := Transactiontype::Paybill;

        if Transaction = 'Till Purchase Request' then
            TransactionType := Transactiontype::"Till Purchase";


        if Transaction = 'Bank Transfer' then
            TransactionType := Transactiontype::"Bank Transfer";


        if Transaction = 'Bank Transfer Request' then
            TransactionType := Transactiontype::"Bank Transfer";

        // Get Excise duty G/L
        ExciseDutyGL := GetExciseDutyGL();
        ExciseDutyRate := GetExciseRate();
        ExciseDuty := 0;


        if (Transaction = 'Till Purchase') or (Transaction = 'Mpesa Withdrawal') or (Transaction = 'Utility Payment') or (Transaction = 'Bank Transfer') or (Transaction = 'Airtime Purchase') then begin


            MobileWithdrawalsBuffer.Reset;
            MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Reference No", Format(EntryCode));
            MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Source, MobileWithdrawalsBuffer.Source::"M-PESA");
            if MobileWithdrawalsBuffer.Find('-') then begin
                AccountNo := MobileWithdrawalsBuffer."Account No";
                Amount := MobileWithdrawalsBuffer.Amount;
                if Description = '' then
                    Description := MobileWithdrawalsBuffer.Description;
            end;
        end;

        if TransactionType = Transactiontype::"Loan Repayment" then begin
            LoanNo := CopyStr(AccountNo, 5, StrLen(AccountNo) - 3);

            if Loans.Get(LoanNo) then begin
                SavAcc.Reset;
                SavAcc.SetRange("Member No.", Loans."Member No.");
                SavAcc.SetFilter("Transactional Mobile No", '<>%1', '');
                if SavAcc.FindFirst then begin
                    AccountNo := SavAcc."No.";
                    LoanNo := Loans."Loan No.";
                end
                else begin
                    SavAcc.Reset;
                    SavAcc.SetRange("No.", Loans."Disbursement Account No");
                    if SavAcc.FindFirst then begin
                        AccountNo := SavAcc."No.";
                        LoanNo := Loans."Loan No.";
                    end

                end;
            end;
        end;


        SafcomFee := 0;
        SaccoFee := 0;
        VendorCommission := 0;
        PrePaymentGL := '';
        SMSAccount := '';
        SMSCharge := 0;

        CoopSetup.Reset;
        //CoopSetup.SetRange("Transaction Type", TransactionType);
        if CoopSetup.FindFirst then begin


            if (Transaction = 'Till Purchase Request') or (Transaction = 'Withdrawal Request') or (Transaction = 'Utility Request') or (Transaction = 'Bank Transfer Request') or (Transaction = 'Airtime Request') then begin
                SavAcc.Get(AccountNo);
                TransLimit := SavAcc."Bank Transfer Trans. Limit";
                if TransLimit <= 0 then
                    TransLimit := CoopSetup."Transaction Limit";

                if TransLimit > 0 then begin
                    if Amount > TransLimit then begin
                        Response := '<Response>';
                        Response += '<Status>TRANSACTION_LIMIT_EXCEEDED</Status>';
                        Response += '<StatusDescription>Transaction Amount Exceeds the Set Limit</StatusDescription>';
                        Response += '<Reference>' + Format(EntryCode) + '</Reference>';
                        Response += '</Response>';
                        exit;
                    end;
                end;


                TransLimit := SavAcc."Bank Transfer Daily Limit";
                if TransLimit <= 0 then
                    TransLimit := CoopSetup."Daily Limit";

                if TransLimit > 0 then begin
                    Limit := CoopSetup."Daily Limit" - GetAmountTransacted(Transaction, AccountNo, Dt2Date(TransactionDate), Type::Daily);

                    if Limit < 0 then
                        Limit := 0;

                    if Limit < Amount then begin
                        if SavAcc.Get(AccountNo) then begin
                            Priority := 205;
                            msg := 'Dear ' + FirstName(SavAcc.name) + ', your withdrawal request could not be processed because the amount exceeds the set daily limit. You can only withdraw up to KES ' + Format(Limit) + ' today.';
                            SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, AccountNo, '', true, Priority, false);
                        end;
                        Response := 'DAILY_LIMIT_EXCEEDED';
                        exit;
                    end;
                end;
                if CoopSetup."Weekly Limit" > 0 then begin
                    Limit := CoopSetup."Weekly Limit" - GetAmountTransacted(Transaction, AccountNo, Dt2Date(TransactionDate), Type::Weekly);

                    if Limit < 0 then
                        Limit := 0;

                    if Limit < Amount then begin
                        if SavAcc.Get(AccountNo) then begin
                            Priority := 205;
                            msg := 'Dear ' + FirstName(SavAcc.name) + ', your withdrawal request could not be processed because the amount exceeds the set weekly limit. You can only withdraw up to KES ' + Format(Limit) + ' today.';
                            SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, AccountNo, '', true, Priority, false);
                        end;
                        Response := 'DAILY_LIMIT_EXCEEDED';
                        exit;
                    end;

                end;
                if CoopSetup."Monthly Limit" > 0 then begin
                    Limit := CoopSetup."Monthly Limit" - GetAmountTransacted(Transaction, AccountNo, Dt2Date(TransactionDate), Type::Monthly);

                    if Limit < 0 then
                        Limit := 0;

                    if Limit < Amount then begin
                        if SavAcc.Get(AccountNo) then begin
                            Priority := 205;
                            msg := 'Dear ' + FirstName(SavAcc.name) + ', your withdrawal request could not be processed because the amount exceeds the set monthly limit. You can only withdraw up to KES ' + Format(Limit) + ' today.';
                            SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, AccountNo, '', true, Priority, false);
                        end;
                        Response := 'DAILY_LIMIT_EXCEEDED';
                        exit;
                    end;
                end;

            end;

            SMSAccount := CoopSetup."SMS Account";
            SMSCharge := CoopSetup."SMS Charge";

            /*
             IF TransactionType = TransactionType::"Mpesa Withdrawal" THEN BEGIN
                 SafcomCharges.RESET;
                 SafcomCharges.SETFILTER(Charge,'>0');
                 SafcomCharges.SETFILTER(Minimum,'<=%1',Amount);
                 SafcomCharges.SETFILTER(Maximum,'>=%1',Amount);
                 IF SafcomCharges.FINDFIRST THEN BEGIN
                     SafcomFee:=SafcomCharges.Charge;
                 END;
             END;
             */

            SafcomFee := 0;
            if CoopSetup."Safcom Staggered Fee" then
                SafcomFee := GetStaggeredSaccoFee(CoopSetup."Safcom Staggered Charge", Amount);


            PrePaymentGL := CoopSetup."Pre-Payment Account";

            SafcomFee := 0;
            IF (MpesaTrans."Transaction Type" = MpesaTrans."Transaction Type"::"Mpesa Withdrawal") THEN BEGIN
                SafcomCharges.RESET;
                SafcomCharges.SETFILTER(Charge, '>0');
                SafcomCharges.SETFILTER(Minimum, '<=%1', Amount);
                SafcomCharges.SETFILTER(Maximum, '>=%1', Amount);
                IF SafcomCharges.FINDFIRST THEN BEGIN
                    SafcomFee := SafcomCharges.Charge;
                END;
            END;
            IF (MpesaTrans."Transaction Type" = MpesaTrans."Transaction Type"::"Till Purchase") THEN BEGIN
                SafcomCharges.RESET;
                SafcomCharges.SETFILTER(Charge, '>0');
                SafcomCharges.SETFILTER(Minimum, '<=%1', Amount);
                SafcomCharges.SETFILTER(Maximum, '>=%1', Amount);
                IF SafcomCharges.FINDFIRST THEN BEGIN
                    SafcomFee := SafcomCharges.Charge;
                END;
            END;

            SaccoFee := CoopSetup."Sacco Fee";
            if CoopSetup."Sacco Staggered Fee" then
                MActivities.GetGeneralChargeAmountOnly(CoopSetup."Sacco Staggered Charge", Amount, SaccoFee, ChargeDuty, ChargeAcctType, ChargeAcct);

            VendorCommission := CoopSetup."Vendor Commission";
            if CoopSetup."Vendor Staggered Fee" then
                MActivities.GetGeneralChargeAmountOnly(CoopSetup."Vendor Staggered Charge", Amount, VendorCommission, ChargeDuty, ChargeAcctType, ChargeAcct);




            TotalCharge := SaccoFee + VendorCommission + SafcomFee + SMSCharge;
            ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);

        end
        else begin
            //ERROR('Setup Missing for %1', Transaction);
        end;


        MemberID := '';


        if (Transaction = 'Withdrawal Request') or (Transaction = 'Utility Request') or (Transaction = 'Bank Transfer Request') or (Transaction = 'Airtime Request') then begin

            if not CorrectPin(PhoneNo, PIN) then begin
                Response := 'INCORRECT_PIN';
                exit;
            end;

        end;




        if (TransactionType = Transactiontype::Paybill) or ((TransactionType = Transactiontype::"Loan Repayment")) then begin

            SavAcc.Reset;
            SavAcc.SetRange("ID No.", AccountNo);
            SavAcc.SetFilter("Transactional Mobile No", '<>%1', '');
            if SavAcc.FindFirst then begin
                SavAcc.CalcFields("ID No.");
                MemberID := SavAcc."ID No.";
                AccountNo := SavAcc."No.";
            end
            else begin

                SavAcc.Reset;
                SavAcc.SetRange("No.", AccountNo);
                if SavAcc.FindFirst then begin
                    SavAcc.CalcFields("ID No.");
                    MemberID := SavAcc."ID No.";
                    AccountNo := SavAcc."No.";
                end
                else begin

                    if StrLen(AccountPrefix + AccountNo + AccountSuffix) > 20 then begin

                        MpesaTrans.Init;
                        MpesaTrans."Entry No." := EntryCode;
                        MpesaTrans."Transaction ID" := TransactionID;
                        MpesaTrans."Session ID" := TransactionID;
                        MpesaTrans."Transaction Type" := TransactionType;
                        MpesaTrans."Transaction Name" := Transaction;
                        MpesaTrans.Description := CopyStr(Description, 1, 50);
                        ;
                        MpesaTrans."Transaction Date" := Dt2Date(TransactionDate);
                        MpesaTrans."Transaction Time" := Dt2Time(TransactionDate);
                        MpesaTrans."Member Account" := AccountNo;
                        MpesaTrans.Amount := Amount;
                        MpesaTrans."Account Name" := CopyStr(AccName, 1, 250);
                        MpesaTrans."Mpesa Account" := MpesaAccount;
                        MpesaTrans."Loan No." := LoanNo;
                        MpesaTrans."Mobile No." := PhoneNo;
                        MpesaTrans."Vendor Commission" := VendorCommission;
                        MpesaTrans."Sacco Fee" := SaccoFee;
                        MpesaTrans."Paybill Member ID" := MemberID;
                        MpesaTrans."Reference Name" := RefName;
                        MpesaTrans.Insert;

                        Response := '<Response>';
                        Response += '<Status>SUCCESS</Status>';
                        Response += '<StatusDescription>Success</StatusDescription>';
                        Response += '<Reference>' + Format(EntryCode) + '</Reference>';
                        Response += '</Response>';
                        //PostMpesaTransaction(TransactionID);
                        exit;

                    end
                    else begin

                        SavAcc.Reset;
                        SavAcc.SetRange("No.", AccountPrefix + AccountNo + AccountSuffix);
                        if SavAcc.FindFirst then begin
                            SavAcc.CalcFields("ID No.");
                            MemberID := SavAcc."ID No.";
                            AccountNo := SavAcc."No.";
                        end
                        else begin




                            PhoneConvert := '+254' + CopyStr(AccountNo, 2, strlen(AccountNo));
                            SavAcc.Reset;
                            SavAcc.SetRange("Mobile Phone No.", PhoneConvert);
                            SavAcc.setRange("Product Category", SavAcc."Product Category"::Business);
                            if SavAcc.FindFirst then begin
                                SavAcc.CalcFields("ID No.");
                                MemberID := SavAcc."ID No.";
                                AccountNo := SavAcc."No.";
                            end
                            else begin


                                MpesaTrans.Init;
                                MpesaTrans."Entry No." := EntryCode;
                                MpesaTrans."Transaction ID" := TransactionID;
                                MpesaTrans."Session ID" := TransactionID;
                                MpesaTrans."Transaction Type" := TransactionType;
                                MpesaTrans."Transaction Name" := Transaction;
                                MpesaTrans.Description := CopyStr(Description, 1, 50);
                                MpesaTrans."Transaction Date" := Dt2Date(TransactionDate);
                                MpesaTrans."Transaction Time" := Dt2Time(TransactionDate);
                                MpesaTrans."Member Account" := AccountNo;
                                MpesaTrans.Amount := Amount;
                                MpesaTrans."Account Name" := CopyStr(AccName, 1, 250);
                                MpesaTrans."Mpesa Account" := MpesaAccount;
                                MpesaTrans."Loan No." := LoanNo;
                                MpesaTrans."Mobile No." := PhoneNo;
                                MpesaTrans."Vendor Commission" := VendorCommission;
                                MpesaTrans."Sacco Fee" := SaccoFee;
                                MpesaTrans."Paybill Member ID" := MemberID;
                                MpesaTrans."Reference Name" := RefName;
                                MpesaTrans.Insert;

                                Response := '<Response>';
                                Response += '<Status>SUCCESS</Status>';
                                Response += '<StatusDescription>Success</StatusDescription>';
                                Response += '<Reference>' + Format(EntryCode) + '</Reference>';
                                Response += '</Response>';
                                //PostMpesaTransaction(TransactionID);
                                exit;

                            end;
                        end;
                    end;
                end;

            end;
        end;

        if (SavAcc.Get(AccountNo)) or (DepositEntry) or (ShareEntry) or (BosaEntry <> Bosaentry::None) then begin

            if (Transaction = 'Till Purchase Request') or (Transaction = 'Withdrawal Request') or (Transaction = 'Utility Request') or (Transaction = 'Bank Transfer Request') or (Transaction = 'Airtime Request') then begin


                if (SavAcc.Status <> SavAcc.Status::Active) or (SavAcc.Blocked = SavAcc.Blocked::Payment) or (SavAcc.Blocked = SavAcc.Blocked::All) then begin
                    Response := 'ACCOUNT_NOT_ACTIVE';
                    exit;
                end;
                if Amount < 0 then
                    Amount := 0;

                AccBal := GetAccountBalance(SavAcc."No.") + GetFuuzaBalance(SavAcc."No.");
                AccBal -= SActivities.GetTotalArrears(SavAcc."Member No.");
                if (AccBal >= Amount + TotalCharge + ExciseDuty) then begin

                    MobileWithdrawalsBuffer.Init;
                    MobileWithdrawalsBuffer."Reference No" := Format(EntryCode);
                    MobileWithdrawalsBuffer."Trace ID" := TransactionID;
                    MobileWithdrawalsBuffer."Posting Date" := Dt2Date(TransactionDate);

                    MobileWithdrawalsBuffer."Account No" := AccountNo;
                    MobileWithdrawalsBuffer.Description := CopyStr(Description, 1, 50);
                    MobileWithdrawalsBuffer."Unit ID" := 'M-PESA';
                    MobileWithdrawalsBuffer."Transaction Type" := Transaction;
                    MobileWithdrawalsBuffer."Transaction Date" := Dt2Date(TransactionDate);
                    MobileWithdrawalsBuffer.Source := MobileWithdrawalsBuffer.Source::"M-PESA";


                    AccBal := GetAccountBalance(SavAcc."No.");
                    if (AccBal < (Amount + TotalCharge + ExciseDuty)) then begin
                        MobileWithdrawalsBuffer."Fuuza Amount" := (Amount + TotalCharge + ExciseDuty) - AccBal;
                    end;

                    MobileWithdrawalsBuffer.Amount := Amount;

                    //message('AccBal %1', AccBal);
                    // error('AccBal %1\> %2\MobileWithdrawalsBuffer.Fuuza %3', AccBal, Amount + TotalCharge + ExciseDuty, MobileWithdrawalsBuffer."Fuuza Amount");

                    MobileWithdrawalsBuffer.Insert;


                    Response := 'SUCCESS%&:' + SavAcc.Name;
                    Commit;
                    if MobileWithdrawalsBuffer."Fuuza Amount" > 0 then begin
                        if SavAcc."Virtual Account No." = '' then begin
                            Members.get(SavAcc."Member no.");
                            PSetup.reset;
                            PSetup.setrange("Product Category", PSetup."product category"::"Virtual Account");
                            if PSetup.FindFirst() then begin
                                SavAcc."Virtual Account No." := MActivities.CreateVirtualFuuzaAccount(SavAcc."no.", Members);
                                SavAcc.modify;
                            end;
                        end;

                        SavAcc.testfield("Virtual Account No.");

                        JTemplate := 'GENERAL';
                        JBatch := 'MBANKING';
                        DocNo := TransactionID;
                        PDate := today;

                        CalcFuuzaInterestOnDisbursement(SavAcc."Virtual Account No.", PDate, MobileWithdrawalsBuffer."Fuuza Amount");

                        SActivities.InterAccountTransfer(
                            JTemplate,
                            JBatch,
                            DocNo,
                            PDate,
                            Accttype::Savings,
                            SavAcc."Virtual Account No.",
                            CopyStr('Fuuza Disb.: ' + Description, 1, 50),
                            Accttype::Savings,
                            SavAcc."No.",
                            MobileWithdrawalsBuffer."Fuuza Amount",
                            entrycode,
                            '',
                            TransType,
                            savAcc."Global Dimension 1 Code",
                            savAcc."Global Dimension 2 Code",
                            true);

                    end;

                    TransactionsBuffer.Init;
                    TransactionsBuffer."Transaction ID" := Format(EntryCode);
                    TransactionsBuffer.Guid := CreateGuid;
                    TransactionsBuffer.Date := TransactionDate;
                    TransactionsBuffer.Amount := Amount;
                    TransactionsBuffer."Account No." := AccountNo;
                    TransactionsBuffer.Insert;


                end
                else begin
                    Response := 'INSUFFICIENT_BAL';
                end;
            end
            else begin

                MpesaTrans.Init;
                MpesaTrans."Entry No." := EntryCode;
                MpesaTrans."Transaction ID" := TransactionID;
                MpesaTrans."Session ID" := TransactionID;
                MpesaTrans."Transaction Type" := TransactionType;
                MpesaTrans."Transaction Name" := Transaction;
                MpesaTrans.Description := CopyStr(Description, 1, 50);
                ;
                MpesaTrans."Transaction Date" := Dt2Date(TransactionDate);
                MpesaTrans."Transaction Time" := Dt2Time(TransactionDate);
                MpesaTrans."Member Account" := AccountNo;
                MpesaTrans."Account Name" := CopyStr(AccName, 1, 250);
                MpesaTrans.Amount := Amount;
                MpesaTrans."Mpesa Account" := MpesaAccount;
                MpesaTrans."Loan No." := LoanNo;
                MpesaTrans."Mobile No." := PhoneNo;
                MpesaTrans."Vendor Commission" := VendorCommission;
                MpesaTrans."Sacco Fee" := SaccoFee;
                MpesaTrans."Paybill Member ID" := MemberID;
                MpesaTrans."Reference Name" := RefName;

                MpesaTrans.Insert;

                Response := 'SUCCESS';

                Response := '<Response>';
                Response += '<Status>SUCCESS</Status>';
                Response += '<StatusDescription>Success</StatusDescription>';
                Response += '<Reference>' + Format(EntryCode) + '</Reference>';
                Response += '</Response>';

                //sMpesaTransaction(TransactionID);
            end;

        end
        else
            Error('Account Not Found');

    end;


    procedure PostMpesaTransaction(DocumentNo: Code[20]) Response: Text
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        MpesaTrans: Record "Sky Transactions.";
        TransAmt: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        RunBal: Decimal;
        AccBal: Decimal;
        Loans: Record Loans;
        IntAmt: Decimal;
        PrAmt: Decimal;
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
        BillAcc: Record "Savings Accounts";
        IntRate: Decimal;
        MemberName: Text;
        Depositor: Text;
        GenSetup: Record "Sacco Setup";
        Members: Record Members;
        AccMNo: Code[20];
        BosaTrans: Boolean;
        DepDesc: Text;
        PayBillAccNo: Code[20];
        MAccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Share Capital","Deposit Contribution","Deposit Contribution Micro","Retirement Saving Fund","Registration Fee","Insurance Contribution","FOSA SHARES";
        "Key": Code[20];
        LNo: Code[20];
        MemberPhoneNo: Code[20];
        Vend: Record "Savings Accounts";
        PrAcc: Record "Savings Accounts";
        PrMno: Code[20];
        DepBal: Decimal;
        TransType: Enum "Transaction Type Enum";
        AcctName: Text;
        SafComDepChargesGL: Code[20];
        MName: Text;
        AccountTypes: Record "Product Setup";
        ChargeSacco: Boolean;
        Source: Enum "SMS Source Enum";
        Found: Boolean;
        SaccoActivity: Codeunit "Sacco Activities";
        BLedger: Record "Bank Account Ledger Entry";
    begin

        MpesaTrans.Reset;
        if DocumentNo <> '' then
            MpesaTrans.SetRange("Transaction ID", DocumentNo);
        //MpesaTrans.SETRANGE("Transaction ID", 'QL274UGT9T');
        MpesaTrans.SetRange(Posted, false);
        MpesaTrans.SetRange("Needs Change", false);
        if MpesaTrans.FindFirst then begin
            GenSetup.Get;


            // Get Excise duty G/L
            ExciseDutyGL := GetExciseDutyGL();
            ExciseDutyRate := GetExciseRate();
            ExciseDuty := 0;

            BLedger.Reset;
            BLedger.SetRange("Document No.", MpesaTrans."Transaction ID");
            if DocumentNo <> 'SSPDSP21AIR42942' then
                if BLedger.FindFirst then begin
                    MpesaTrans."Needs Change" := false;
                    MpesaTrans.Posted := true;
                    //MpesaTrans.Failed := false;
                    MpesaTrans."Needs Change" := false;
                    MpesaTrans.Remarks := 'Already Posted';
                    MpesaTrans.Modify;
                    exit;
                end;

            //Message('AccNo %1\LoanAccount %2\DepositAccount %3\IDNo %4\MNo %5\BosaTransType %6',AccNo,LoanAccount,DepositAccount,IDNo,MNo,BosaTransType);


            SaccoAccount := '';
            SaccoFee := 0;
            VendorAccount := '';
            VendorCommission := 0;
            SafcomAcc := '';
            SafcomFee := 0;
            PrePaymentGL := '';
            SMSAccount := '';
            SMSCharge := 0;
            ChargeSacco := false;

            CoopSetup.Reset;
            //CoopSetup.SetRange("Transaction Type", MpesaTrans."Transaction Type");
            if CoopSetup.FindFirst then begin

                SMSAccount := CoopSetup."SMS Account";
                SMSCharge := CoopSetup."SMS Charge";
                SafComDepChargesGL := CoopSetup."Safaricom Dep Charges GL";

                if MpesaTrans.MobileApp then
                    SMSCharge := 0;




                SafcomFee := 0;
                if CoopSetup."Safcom Staggered Fee" then
                    SafcomFee := GetStaggeredSaccoFee(CoopSetup."Safcom Staggered Charge", MpesaTrans.Amount);

                PrePaymentGL := CoopSetup."Pre-Payment Account";
                SafcomAcc := CoopSetup."Safaricom Account";
                SaccoAccount := CoopSetup."Sacco Fee Account";
                SaccoFee := CoopSetup."Sacco Fee";
                if CoopSetup."Sacco Staggered Fee" then
                    SaccoFee := GetStaggeredSaccoFee(CoopSetup."Sacco Staggered Charge", MpesaTrans.Amount);

                VendorAccount := CoopSetup."Vendor Commission Account";
                VendorCommission := CoopSetup."Vendor Commission";

                if CoopSetup."Vendor Staggered Fee" then
                    VendorCommission := GetStaggeredSaccoFee(CoopSetup."Vendor Staggered Charge", MpesaTrans.Amount);



                if MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Mpesa Withdrawal" then begin
                    if (SavAcc.Get(MpesaTrans."Member Account")) then begin
                        if AccountTypes.Get(SavAcc."Product Type") then begin
                            if AccountTypes."Exempt Mbanking C/W Fee" then begin
                                AccountTypes.TestField("Mbanking Expense GL");
                                SafcomFee := 0;
                                ChargeSacco := true;
                            end;
                        end;
                    end;
                end;
                //xxx


                SafcomFee := 0;
                IF MpesaTrans."Transaction Type" = MpesaTrans."Transaction Type"::"Mpesa Withdrawal" THEN BEGIN
                    SafcomCharges.RESET;
                    SafcomCharges.SETFILTER(Charge, '>0');
                    SafcomCharges.SETFILTER(Minimum, '<=%1', MpesaTrans.Amount);
                    SafcomCharges.SETFILTER(Maximum, '>=%1', MpesaTrans.Amount);
                    IF SafcomCharges.FINDFIRST THEN BEGIN
                        SafcomFee := SafcomCharges.Charge;
                    END;
                END;

                SafcomFee := 0;
                IF MpesaTrans."Transaction Type" = MpesaTrans."Transaction Type"::"Mpesa Withdrawal" THEN BEGIN
                    SafcomCharges.RESET;
                    SafcomCharges.SETFILTER(Charge, '>0');
                    SafcomCharges.SETFILTER(Minimum, '<=%1', MpesaTrans.Amount);
                    SafcomCharges.SETFILTER(Maximum, '>=%1', MpesaTrans.Amount);
                    IF SafcomCharges.FINDFIRST THEN BEGIN
                        SafcomFee := SafcomCharges.Charge;
                    END;
                END;

                SaccoFee := CoopSetup."Sacco Fee";
                if CoopSetup."Sacco Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(CoopSetup."Sacco Staggered Charge", MpesaTrans.Amount, SaccoFee, ChargeDuty, ChargeAcctType, ChargeAcct);

                VendorCommission := CoopSetup."Vendor Commission";
                if CoopSetup."Vendor Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(CoopSetup."Vendor Staggered Charge", MpesaTrans.Amount, VendorCommission, ChargeDuty, ChargeAcctType, ChargeAcct);


                if MpesaTrans.SkipCharge then begin
                    SaccoFee := 0;
                    vendorcommission := 0;
                    safcomfee := 0;

                end;


                TotalCharge := SaccoFee + VendorCommission + SafcomFee + SMSCharge;
                ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
            end
            else begin
                //if MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Pay Loan From Account" then
                //ERROR('Setup Missing for %1', MpesaTrans."Transaction Type");
            end;


            //Error('VendorCommission %1',VendorCommission);

            MAccNo := '';
            LoanAccount := false;
            DepositAccount := false;
            IDNo := '';
            MNo := '';
            Key := '';
            LNo := '';
            MemberPhoneNo := '';


            if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill then begin

                Members.Reset();
                Members.SetRange("Id No.", MpesaTrans."Member Account");
                if Members.FindFirst() then begin
                    MpesaTrans."Member Account" := Members."no.";
                    MpesaTrans.modify;
                end
                else begin

                    if not Members.get(MpesaTrans."Member Account") then begin

                        Loans.Reset();
                        Loans.SetRange("Loan Account", MpesaTrans."Member Account");
                        Loans.setfilter("Outstanding Principal", '>0');
                        if Loans.FindFirst() then begin
                            SavAcc.Reset;
                            SavAcc.SetRange("Member No.", Loans."Member No.");
                            SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Ordinary Savings");
                            if SavAcc.FindFirst then begin
                                MpesaTrans.Description := 'Loan Repayment ' + MpesaTrans."Member Account";
                                MpesaTrans."Member Account" := SavAcc."No.";
                                MpesaTrans."Loan No." := Loans."Loan No.";
                                MpesaTrans."Transaction Type" := MpesaTrans."transaction type"::"Loan Repayment";
                                MpesaTrans.Modify;
                            end;
                        end
                        else
                            if not SavAcc.Get(MpesaTrans."Member Account") then begin

                                MpesaTrans."Bosa Transaction" := MpesaTrans."bosa transaction"::None;

                                GetAccountFromKeyWord(MpesaTrans."Member Account", MAccNo, LoanAccount, DepositAccount, IDNo, MNo, BosaTransType, Key, LNo);

                                if MAccNo <> '' then begin
                                    MpesaTrans."Bosa Transaction" := BosaTransType;
                                    MpesaTrans."Member Account" := MAccNo;
                                    MpesaTrans."Paybill Member ID" := IDNo;
                                    MpesaTrans.Keyword := Key;
                                    MpesaTrans."Member No." := MNo;
                                    MpesaTrans."Loan No." := LNo;
                                    if LoanAccount then begin
                                        if MpesaTrans."Loan No." <> '' then
                                            MpesaTrans."Transaction Type" := MpesaTrans."transaction type"::"Loan Repayment";


                                        if Loans.Get(LNo) then begin
                                            if Members.Get(Loans."Member No.") then begin
                                                if Members.Blocked <> Members.Blocked::" " then begin
                                                    MpesaTrans.Remarks := 'Bosa Account Blocked';
                                                    MpesaTrans."Needs Change" := true;
                                                    MpesaTrans.Modify;
                                                    exit;
                                                end;

                                            end;

                                        end;
                                        if Members.Get(MNo) then begin
                                            if Members.Blocked <> Members.Blocked::" " then begin
                                                MpesaTrans.Remarks := 'Bosa Account Blocked';
                                                MpesaTrans."Needs Change" := true;
                                                MpesaTrans.Modify;
                                                exit;
                                            end;

                                        end;
                                        // if SavAcc.Get(MpesaTrans."Member Account") then begin
                                        //     if SavAcc.Blocked <> SavAcc.Blocked::" " then begin
                                        //         MpesaTrans.Remarks := 'Fosa Account Blocked';

                                        //         MpesaTrans."Needs Change" := true;
                                        //         MpesaTrans.Modify;
                                        //         exit;
                                        //     end;
                                        // end;


                                    end;
                                    // else begin
                                    //     if SavAcc.Get(MpesaTrans."Member Account") then begin

                                    //         if SavAcc.Blocked <> SavAcc.Blocked::" " then begin
                                    //             MpesaTrans.Remarks := 'Fosa Account Blocked';

                                    //             MpesaTrans."Needs Change" := true;
                                    //             MpesaTrans.Modify;
                                    //             exit;
                                    //         end;
                                    //     end;

                                    // end;


                                end;


                            end;


                    end;

                end;

            end;
            //message('%1',MpesaTrans."Transaction Type");


            MemberPhoneNo := '';
            if (SavAcc.Get(MpesaTrans."Member Account")) or ((Members.Get(MpesaTrans."Member Account") and (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill))) then begin
                if (SavAcc.Get(MpesaTrans."Member Account")) then begin
                    MemberName := SavAcc.Name;
                    MNo := SavAcc."Member No.";
                    BosaTrans := false;
                    MemberPhoneNo := SavAcc."Transactional Mobile No";
                    if MemberPhoneNo = '' then
                        MemberPhoneNo := SavAcc."Phone No.";

                    if MNo = '' then begin
                        //SavAcc.TESTFIELD("ID No.");
                        if SavAcc."ID No." <> '' then begin
                            Members.Reset;
                            Members.SetRange("ID No.", SavAcc."ID No.");
                            if Members.FindFirst then
                                MNo := Members."No.";
                        end;
                    end;
                    if MNo <> '' then begin
                        if Members.Get(MNo) then begin

                            if MemberPhoneNo = '' then
                                MemberPhoneNo := Members."Phone No.";
                        end
                    end;
                end;


                if ((Members.Get(MpesaTrans."Member Account") and (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill))) then begin
                    SavAcc.get(Legacy.GetOrdinaryAccount(Members."No."));
                end;


                TransAmt := MpesaTrans.Amount;
                AccountToCharge := '';
                if BillAcc.Get(MpesaTrans."Member Account") then begin
                    AccountToCharge := BillAcc."No.";
                end
                else begin
                    BillAcc.Reset;
                    BillAcc.SetRange("Member No.", MNo);
                    BillAcc.SetFilter("Transactional Mobile No", '<>%1', '');
                    if BillAcc.FindFirst then
                        AccountToCharge := BillAcc."No.";
                end;
                if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Loan Repayment") or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill) or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Deposit") or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Deposit") or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Agent Deposit") or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Pay Loan From Account")

                    then
                    TransAmt := TransAmt * -1;

                if BosaTrans then begin
                    if Members.Blocked <> Members.Blocked::" " then begin
                        MpesaTrans.Remarks := 'Bosa Account Blocked';
                        MpesaTrans."Needs Change" := true;
                        MpesaTrans.Modify;
                        exit;
                    end;

                end
                else begin
                    if SavAcc.Blocked <> SavAcc.Blocked::" " then begin
                        if (MpesaTrans."Transaction Type" <> MpesaTrans."Transaction Type"::Paybill) and (MpesaTrans."Transaction Type" <> MpesaTrans."Transaction Type"::"Loan Repayment") then begin

                            MpesaTrans.Remarks := 'Fosa Account Blocked';

                            MpesaTrans."Needs Change" := true;
                            MpesaTrans.Modify;
                            exit;
                        end
                        else begin
                            SavAcc."Test Blocked" := SavAcc.Blocked;
                            SavAcc.Blocked := SavAcc.Blocked::" ";
                            SavAcc.Modify();
                        end;
                    end;
                end;

                //BUser.GET(USERID);

                //BUser.TESTFIELD("Cashier Journal Template");
                //BUser.TESTFIELD("Cashier Journal Batch");

                JTemplate := 'GENERAL';
                JBatch := 'MBANKING';

                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                GenJournalBatch.SetRange(Name, JBatch);
                if not GenJournalBatch.FindFirst then begin
                    GenJournalBatch.Init;
                    GenJournalBatch."Journal Template Name" := JTemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.Description := 'Mbanking Batch';
                    GenJournalBatch.Insert;
                end;

                DocNo := MpesaTrans."Transaction ID";
                PDate := MpesaTrans."Transaction Date";

                //if PDate < CalcDate('-CM', Today) then
                PDate := Today;

                AccNo := MpesaTrans."Member Account";
                ExtDoc := MpesaTrans."Account Name";
                LoanNo := '';
                TransType := Transtype::" ";
                Dim1 := SavAcc."Global Dimension 1 Code";
                Dim2 := SavAcc."Global Dimension 2 Code";
                SystCreated := true;
                //dd
                SaccoTrans.JournalInit(JTemplate, JBatch);
                DepBal := 0;

                if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Airtime then begin

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(MpesaTrans.Description, 1, 50), Balacctype::"G/L Account",
                                  '', TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());


                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, VendorAccount, CopyStr(MpesaTrans.Description, 1, 50), Balacctype::"G/L Account",
                                  '', -TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                end
                else begin
                    AcctType := Accttype::Savings;

                    // error('AcctType %1\AccNo %2',AcctType,AccNo);

                    if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill) then begin

                        /*
                        IF PrAcc.GET(MpesaTrans."Member Account") THEN BEGIN
                            IF PrAcc."Product Type" = 'ORDINARY' THEN BEGIN
                                PrMno := PrAcc."Member No.";
                                IF PrMno <> '' THEN BEGIN
                                    PrAcc.RESET;
                                    PrAcc.SETRANGE("Member No.",PrMno);
                                    PrAcc.SETRANGE(Defaulter,TRUE);
                                    IF PrAcc.FINDFIRST THEN BEGIN
                                        MpesaTrans."Priority Account" := PrAcc."No.";
                                        AccNo := PrAcc."No.";
                                    END;
                                END;
                            END;
                        END;
                        */


                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Balacctype::"Bank Account", CoopSetup."Bank Account", CopyStr(MpesaTrans.Description, 1, 50), Balacctype::"G/L Account",
                                      '', TransAmt * -1, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());


                        if Members.get(MpesaTrans."Member Account") then begin
                            SaccoActivity.GenerateMemberRepaymentJournals(JTemplate, JBatch, docNo, ExtDoc, pdate, MpesaTrans.Description, pdate, TransAmt * -1, Members."No.", LoanNo, '', BalAccType::"g/l account", 0, channel::Mobile, true);

                        end
                        else begin

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType, AccNo, CopyStr(MpesaTrans."Reference Name" + ': ' + MpesaTrans.Description, 1, 50), Balacctype::"G/L Account",
                                          '', TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                        end;
                    end
                    else begin
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType, AccNo, CopyStr(MpesaTrans.Description, 1, 50), Balacctype::"Bank Account",
                                      CoopSetup."Bank Account", TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                    end;

                end;
                //error('t');

                if TotalCharge > 0 then begin
                    BalAccNo := '';

                    if (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::Paybill) and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Mpesa Deposit")
                        and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Loan Repayment") and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Bank Deposit")
                       and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Bank Agent Deposit") then begin

                        if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Withdrawal") then
                            AccountToCharge := AccNo;


                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", SafcomAcc, CopyStr('Safaricom Charge', 1, 50), Balacctype::"G/L Account",
                                      '', -SafcomFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SaccoAccount, CopyStr(Format(MpesaTrans."Transaction Type") + ': Mbanking Charge', 1, 50), Balacctype::"G/L Account",
                                      '', -SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"G/L Account",SMSAccount,COPYSTR('Notification Charge - ',1,50),BalAccType::"G/L Account",
                        //            '',SMSCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MpesaTrans."Member Name");

                        /*
                  SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccountToCharge,COPYSTR('Mbanking Charge',1,50),BalAccType::"G/L Account",
                                '',VendorCommission,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MpesaTrans."Member Name");
                  SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccountToCharge,COPYSTR('Corporate Charge',1,50),BalAccType::"Bank Account",
                                SafcomAcc,SafcomFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MpesaTrans."Member Name");
                  SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccountToCharge,COPYSTR('Transaction Charge',1,50),BalAccType::"G/L Account",
                                SaccoAccount,SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MpesaTrans."Member Name");
                  SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccountToCharge,COPYSTR('Notification Charge - ',1,50),BalAccType::"G/L Account",
                                SMSAccount,SMSCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MpesaTrans."Member Name");
                         */

                        if ChargeSacco then begin
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", AccountTypes."Mbanking Expense GL", CopyStr(Format('Mbanking Charge'), 1, 50), Balacctype::"G/L Account",
                                      '', TotalCharge + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                        end
                        else begin
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccountToCharge, CopyStr(Format('Mbanking Charge'), 1, 50), Balacctype::"G/L Account",
                                      '', TotalCharge + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                        end;
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty - ' + Format(MpesaTrans."Transaction Type"), 1, 50), Balacctype::"G/L Account",
                                      '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());



                    end
                    else begin

                        CoopSetup.TestField("Non-Member Debit Account");
                        BalAccNo := CoopSetup."Non-Member Debit Account";

                        DepDesc := 'C2B Mpesa Deposit';
                        if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Deposit") then
                            DepDesc := 'C2B Bank Deposit';
                        if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Agent Deposit") then
                            DepDesc := 'C2B Bank Agent Deposit';


                        /*
                        IF NOT BosaTrans THEN
                            AcctType := AcctType::Vendor
                        ELSE BEGIN
                            AcctType := Accttype::Credit;
                            AccountToCharge := AccNo;
                        END;

                        IF (MpesaTrans."Transaction Type" <> MpesaTrans."Transaction Type"::Paybill) THEN

                        SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType,AccountToCharge,'Mbanking Charge',BalAccType::"G/L Account",
                              '',VendorCommission,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MpesaTrans."Member Name");


                        IF (MpesaTrans."Transaction Type" = MpesaTrans."Transaction Type"::"Bank Agent Deposit")  THEN BEGIN
                          SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccountToCharge,DepDesc,BalAccType::"Bank Account",
                                      SafcomAcc,SafcomFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MpesaTrans."Member Name");

                        END;
                        */


                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SafComDepChargesGL, CopyStr('Safaricom Deposit Charge', 1, 50), Balacctype::"G/L Account",
                                      BalAccNo, -SafcomFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());


                    end;


                    AccNo := VendorAccount;
                    ExtDoc := MpesaTrans."Member Account";
                    LoanNo := '';
                    TransType := Transtype::" ";

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, AccNo, CopyStr('Fee on ' + MpesaTrans.Description, 1, 50), Balacctype::"G/L Account",
                                  BalAccNo, -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());


                end;


                if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Loan Repayment" then begin

                    AccBal := GetAccountBalance(SavAcc."No.");
                    RunBal := AccBal + MpesaTrans.Amount - (TotalCharge + ExciseDuty);

                    if RunBal > 0 then begin
                        if RunBal >= MpesaTrans.Amount then
                            RunBal := MpesaTrans.Amount;

                        Loans.Reset;
                        Loans.SetRange("Loan No.", MpesaTrans."Loan No.");
                        Loans.SetRange("Member No.", SavAcc."Member No.");
                        if Loans.FindFirst then begin

                            Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
                            PostInterestDue := false;
                            InterestGL := '';
                            IntAmt := Loans."Outstanding Interest";

                            if IntAmt > 0 then begin

                                if IntAmt > RunBal then
                                    IntAmt := RunBal;

                                AccNo := MpesaTrans."Member Account";
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                TransType := Transtype::"Interest Paid";
                                SystCreated := true;

                                MpesaTrans."Interest Paid" := IntAmt;
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr('Mpesa Interest Paid', 1, 50), Balacctype::"G/L Account",
                                              '', IntAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                                AccNo := Loans."Loan Account";

                                if Members.Get(AccNo) then begin
                                    if Members.Blocked <> Members.Blocked::" " then begin
                                        MpesaTrans.Remarks := 'Bosa Account Blocked: ' + AccNo;
                                        MpesaTrans."Needs Change" := true;
                                        MpesaTrans.Modify;
                                        exit;
                                    end;

                                end;

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr('Mpesa Interest Paid', 1, 50), Balacctype::"G/L Account",
                                              '', -IntAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                                if PostInterestDue then begin
                                    //TransType := Transtype::"Interest Due";
                                    //SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr('Mpesa Interest Due', 1, 50), Balacctype::"G/L Account",
                                    //        InterestGL, IntAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                                end;


                                RunBal -= IntAmt;

                            end;


                            if Loans."Outstanding Principal" > 0 then begin
                                PrAmt := Loans."Outstanding Principal";
                                if PrAmt > RunBal then
                                    PrAmt := RunBal;

                                AccNo := MpesaTrans."Member Account";
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                TransType := Transtype::"Principal Repayment";
                                SystCreated := true;

                                MpesaTrans."Principal Paid" := PrAmt;

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(MpesaTrans.Description, 1, 50), Balacctype::"G/L Account",
                                              '', PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                                AccNo := Loans."Loan Account";

                                if Members.Get(AccNo) then begin
                                    if Members.Blocked <> Members.Blocked::" " then begin
                                        MpesaTrans.Remarks := 'Bosa Account Blocked: ' + AccNo;
                                        MpesaTrans."Needs Change" := true;
                                        MpesaTrans.Modify;
                                        exit;
                                    end;

                                end;

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(MpesaTrans.Description, 1, 50), Balacctype::"G/L Account",
                                              '', -PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                                RunBal -= PrAmt;

                            end;
                        end;
                    end;
                end;



                //MARK BUFFER AS POSTED
                MobileWithdrawalsBuffer.Reset;
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Reference No", MpesaTrans."Entry No.");
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Source, MobileWithdrawalsBuffer.Source::"M-PESA");
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Account No", MpesaTrans."Member Account");
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Amount, MpesaTrans.Amount);
                if MobileWithdrawalsBuffer.Find('-') then begin

                    MobileWithdrawalsBuffer.Posted := true;
                    MobileWithdrawalsBuffer."Posting Date" := Today;
                    MobileWithdrawalsBuffer.Modify;

                    TransactionsBuffer.Reset;
                    TransactionsBuffer.SetRange(TransactionsBuffer."Transaction ID", MpesaTrans."Entry No.");
                    TransactionsBuffer.SetRange(TransactionsBuffer."Account No.", MpesaTrans."Member Account");
                    TransactionsBuffer.SetRange(TransactionsBuffer.Amount, MpesaTrans.Amount);
                    if TransactionsBuffer.Find('-') then begin
                        TransactionsBuffer.Posted := true;
                        TransactionsBuffer.Modify;
                    end;
                end;


                MpesaTrans.Posted := true;
                MpesaTrans."Posted By" := UserId;
                MpesaTrans."Date Posted" := Today;
                MpesaTrans."Send SMS" := true;
                MpesaTrans.Modify;


                Priority := 201;
                SaccoTrans.JournalPost(JTemplate, JBatch);



                if (MpesaTrans."Transaction Type" = MpesaTrans."Transaction Type"::Paybill) and (MpesaTrans."Transaction Type" = MpesaTrans."Transaction Type"::"Loan Repayment") then begin

                    if SavAcc."Test Blocked" <> SavAcc."Test Blocked"::" " then begin
                        SavAcc.Blocked := SavAcc."Test Blocked";
                        SavAcc."Test Blocked" := SavAcc."Test Blocked"::" ";
                        SavAcc.Modify();
                    end;
                end;

                if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Withdrawal" then
                    Priority := 200;
                if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Utility Payment" then
                    Priority := 200;


                if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Loan Repayment" then begin
                    if Loans.Get(LoanNo) then begin
                        Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
                        LT := Loans."Loan Product Type Name";

                        if LoanType.Get(Loans."Loan Product Type") then begin
                            if LoanType."USSD Product Name" = '' then
                                LoanType."USSD Product Name" := LoanType.Description;

                            LT := LoanType."USSD Product Name";
                        end;

                        NewLoanBal := Loans."Outstanding Principal" + Loans."Outstanding Interest";
                        msg := Format(MpesaTrans."Transaction Type") + ' of KES ' + Format(MpesaTrans.Amount) + ' has been processed successfully. Interest Paid is ' + Format(MpesaTrans."Interest Paid") +
                        ', Principal Paid is ' + Format(MpesaTrans."Principal Paid") + ', New ' + LT + ' Balance is ' + Format(NewLoanBal);
                    end;
                end
                else begin
                    if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill then begin
                        Depositor := CopyStr(MpesaTrans.Description, 24, StrLen(MpesaTrans.Description));
                        //MemberName-Aziz

                        AcctName := 'Account';
                        MName := '';
                        if PrAcc.Get(MpesaTrans."Member Account") then begin
                            PrAcc.CalcFields("Balance (LCY)");
                            DepBal := PrAcc."Balance (LCY)";
                            MName := PrAcc.Name;
                        end;




                        if MemberPhoneNo = MpesaTrans."Mobile No." then begin

                            msg := 'Dear ' + FirstName(PrAcc.name) + ', You have deposited KES ' + Format(MpesaTrans.Amount) +
                                   ' to your ' + AcctName + ' ' + MpesaTrans."Member Account" + NewLine + 'MPESA REF: ' + MpesaTrans."Transaction ID";

                        end
                        else begin
                            msg := 'You have deposited KES ' + Format(MpesaTrans.Amount) +
                                   ' to ' + MName + ' - ' + MpesaTrans."Member Account" + '. ' + NewLine + 'MPESA REF: ' + MpesaTrans."Transaction ID";
                            SendSms(Source::SkyMobile, MpesaTrans."Mobile No.", msg, Format(MpesaTrans."Transaction ID"), '', false, Priority, false);

                            msg := 'Dear ' + FirstName(PrAcc.name) + ', ' + Depositor + ' has deposited KES ' + Format(MpesaTrans.Amount) +
                                   ' to your ' + AcctName + ' ' + MpesaTrans."Member Account" + NewLine + 'MPESA REF: ' + MpesaTrans."Transaction ID";
                        end;

                        if DepBal > 0 then begin
                            //msg := msg+' New  Balance is KES '+FORMAT(DepBal);
                        end



                    end
                    else
                        if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Withdrawal" then begin
                            PrAcc.get(mpesatrans."member account");

                            msg := 'Dear ' + FirstName(pracc.name) + ', ' + MpesaTrans.Description + ' of KES ' + Format(MpesaTrans.Amount) +
                                      ' done on ' + ddMMyyyy(MpesaTrans."Transaction Date") + ' has been processed successfully. ' + NewLine + 'MPESA REF: ' + MpesaTrans."Transaction ID";
                        end
                        else
                            if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Utility Payment" then begin
                                PrAcc.get(mpesatrans."member account");

                                msg := 'Dear ' + FirstName(pracc.name) + ', ' + MpesaTrans.Description + ' of KES ' + Format(MpesaTrans.Amount) + ' purchased on ' + Format(MpesaTrans."Transaction Date") +
                                          ' done on ' + ddMMyyyy(MpesaTrans."Transaction Date") + ' has been processed successfully. ' + NewLine + 'REF: ' + MpesaTrans."Transaction ID";
                                ;
                            end

                            else begin
                                msg := Format(MpesaTrans."Transaction Type") + ' of KES ' + Format(MpesaTrans.Amount) +
                                ' done on ' + ddMMyyyy(MpesaTrans."Transaction Date") + ' has been processed successfully.' + NewLine + 'REF: ' + MpesaTrans."Transaction ID";
                                ;
                            end;
                end;
                if MemberPhoneNo = '' then
                    MemberPhoneNo := SavAcc."Transactional Mobile No";

                //Error('MemberPhoneNo %1',MemberPhoneNo);
                Source := Source::SkyMobile;


                if (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Mini-Statement") and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Balance Enquiry") then
                    if (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Mobile App Login") then begin
                        SendSms(Source, MemberPhoneNo, msg, Format(MpesaTrans."Transaction ID"), '', true, Priority, false);
                        MpesaTrans."SMS Sent" := true;
                        MpesaTrans.Modify;
                    end;

            end
            else begin

                if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill then begin



                    SavAcc.Reset;
                    SavAcc.SetRange("ID No.", MpesaTrans."Member Account");
                    SavAcc.SetFilter("Transactional Mobile No", '<>%1', '');
                    if SavAcc.FindFirst then begin
                        SavAcc.CalcFields("ID No.");
                        MpesaTrans."Member Account" := SavAcc."No.";
                        MpesaTrans."Paybill Member ID" := SavAcc."ID No.";
                        MpesaTrans.Modify;

                    end
                    else begin

                        Found := false;
                        if Loans.Get(MpesaTrans."Member Account") then begin
                            SavAcc.Reset;
                            SavAcc.SetRange("Member No.", Loans."Member No.");
                            SavAcc.SetFilter("Transactional Mobile No", '<>%1', '');
                            if SavAcc.FindFirst then begin
                                MpesaTrans.Description := 'Loan Repayment ' + MpesaTrans."Member Account";
                                MpesaTrans."Member Account" := SavAcc."No.";
                                MpesaTrans."Loan No." := Loans."Loan No.";
                                MpesaTrans."Transaction Type" := MpesaTrans."transaction type"::"Loan Repayment";
                                MpesaTrans."Needs Change" := false;
                                MpesaTrans.Modify;
                                Found := true;
                            end;
                        end
                        else begin
                            if StrLen(AccountPrefix + MpesaTrans."Member Account" + AccountSuffix) <= 20 then begin
                                if SavAcc.Get(AccountPrefix + MpesaTrans."Member Account" + AccountSuffix) then begin
                                    MpesaTrans."Member Account" := SavAcc."No.";
                                    MpesaTrans."Needs Change" := false;
                                    MpesaTrans.Modify;
                                    Found := true;

                                end;
                            end;
                        end;

                        if not Found then begin
                            MpesaTrans."Needs Change" := true;
                            MpesaTrans.Remarks := '1. Savings Account Not Found';
                            MpesaTrans.Modify;
                            msg := 'The account number (' + MpesaTrans."Member Account" + ') that you entered is NOT Correct. Please dial *882*67# to correct your transaction of Ksh ' + Format(MpesaTrans.Amount) +
                                   ' with Ref ' + MpesaTrans."Transaction ID";
                            SendSms(Source::SkyMobile, MpesaTrans."Mobile No.", msg, Format(MpesaTrans."Transaction ID"), '', true, Priority, false);
                        end;
                    end;
                end
                else begin
                    MpesaTrans."Needs Change" := true;
                    MpesaTrans.Remarks := 'Transaction Type Invalid';
                    MpesaTrans.Modify;
                end;
            end;
        end;

    end;


    procedure GetAccountBalance(Account: Text[30]) AccountBal: Decimal
    var
        MemberActivities: Codeunit "Member Activities";
        SavingsAcc: Record "Savings Accounts";
        SaccoCategory: Record "SACCO Categorization";
        TArrears: Decimal;
    begin


        AccountBal := MemberActivities.GetAccountBalance(Account);
        exit(AccountBal);
    end;


    procedure AccountMiniStatement(EntryCode: Text; TransactionID: Code[20]; MaxNumberRows: Integer; StatementAccount: Code[20]; MobileNo: Code[20]; Pin: Text) Response: Text
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        PhoneNo: Code[20];
        AccBal: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        MobileTrans: Record "Sky Transactions.";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        SLedger: Record "Savings Ledger Entry";
        LedgerCount: Integer;
        CurrRecord: Integer;
        DFilter: Text;
        DebitCreditFlag: Code[10];
        FirstEntry: Boolean;
        ProdFact: Record "Product Setup";
        TransactionDate: DateTime;
        Msg, Stmt : Text;
        AccountToCharge: Code[20];
        MemberNo: Code[20];
        MLedger: Record "Credit Ledger Entry";
    begin

        TransactionDate := CurrentDatetime;
        MobileNo := '+' + MobileNo;

        Response := 'ERROR';

        if not CorrectPin(MobileNo, Pin) then begin
            Response := 'INCORRECT_PIN';
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

        MemberNo := '';
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", MobileNo);
        if SavAcc.FindFirst then
            MemberNo := SavAcc."Member No.";


        if SavAcc.Blocked <> SavAcc.Blocked::" " then
            exit;

        AccountToCharge := '';


        BosaEntry := Bosaentry::None;

        //SavAcc.GET(StatementAccount);


        SavAcc.Reset;
        SavAcc.SetRange("Member No.", MemberNo);
        SavAcc.SetFilter("Transactional Mobile No", '<>%1', '');
        if SavAcc.FindFirst then
            AccountToCharge := SavAcc."No.";

        SMSAccount := '';
        SMSCharge := 0;

        CoopSetup.Reset;
        //CoopSetup.SetRange("Transaction Type", CoopSetup."transaction type"::"Account Mini-Statement");
        if CoopSetup.FindFirst then begin

            SMSAccount := CoopSetup."SMS Account";
            SMSCharge := CoopSetup."SMS Charge";


            SaccoAccount := CoopSetup."Sacco Fee Account";
            SaccoFee := CoopSetup."Sacco Fee";

            VendorAccount := CoopSetup."Vendor Commission Account";
            VendorCommission := CoopSetup."Vendor Commission";



            TotalCharge := SaccoFee + VendorCommission + SMSCharge;
            ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
        end
        else begin
            //ERROR('Setup Missing for %1', CoopSetup."Transaction Type");
        end;


        //PhoneNo:='+'+MobileNo;

        SavAcc.Reset;
        SavAcc.SetRange("No.", AccountToCharge);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin

            ProdFact.Get(SavAcc."Product Type");

            if (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::"Deposits Only") or
                (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::" ") then begin
                Error('The Account to Charge is not a Withdrawable Account');
            end;



            AccBal := GetAccountBalance(SavAcc."No.");
            if AccBal >= TotalCharge + ExciseDuty then begin

                //BUser.GET(USERID);

                //BUser.TESTFIELD("Cashier Journal Template");
                //BUser.TESTFIELD("Cashier Journal Batch");

                JTemplate := 'GENERAL';
                JBatch := 'MBANKING';

                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                GenJournalBatch.SetRange(Name, JBatch);
                if not GenJournalBatch.FindFirst then begin
                    GenJournalBatch.Init;
                    GenJournalBatch."Journal Template Name" := JTemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.Description := 'Mbanking Batch';
                    GenJournalBatch.Insert;
                end;


                MobileTrans.Init;
                MobileTrans."Entry No." := EntryCode;
                MobileTrans."Transaction ID" := TransactionID;
                MobileTrans."Session ID" := TransactionID;
                MobileTrans."Transaction Date" := Dt2Date(TransactionDate);
                MobileTrans."Transaction Time" := Dt2Time(TransactionDate);
                MobileTrans."Member Account" := SavAcc."No.";
                MobileTrans."Statement Max Rows" := MaxNumberRows;
                MobileTrans."Bosa Transaction" := BosaEntry;
                //MobileTrans."Statement Start Date":=StartDate;
                //MobileTrans."Statement End Date":=EndDate;
                MobileTrans."Account to Check" := StatementAccount;
                MobileTrans."Transaction Type" := MobileTrans."transaction type"::"Mini-Statement";
                MobileTrans.Description := Format(MobileTrans."Transaction Type");
                MobileTrans.Insert;


                MobileTrans.Reset;
                MobileTrans.SetRange("Transaction ID", TransactionID);
                MobileTrans.SetRange(Posted, false);
                if MobileTrans.FindFirst then begin

                    DocNo := MobileTrans."Transaction ID";
                    PDate := MobileTrans."Transaction Date";
                    AccNo := MobileTrans."Member Account";
                    ExtDoc := '';
                    LoanNo := '';
                    TransType := Transtype::" ";
                    Dim1 := SavAcc."Global Dimension 1 Code";
                    Dim2 := SavAcc."Global Dimension 2 Code";
                    SystCreated := true;

                    SaccoTrans.JournalInit(JTemplate, JBatch);


                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(MobileTrans.Description, 1, 50), Balacctype::"G/L Account",
                                  '', VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccountToCharge, CopyStr('Mbanking Charge', 1, 50), Balacctype::"G/L Account",
                                  SMSAccount, SMSCharge, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr('Sacco Fee ', 1, 50), Balacctype::"G/L Account",
                                  '', SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr('Excise Duty ', 1, 50), Balacctype::"G/L Account",
                                  ExciseDutyGL, ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());


                    AccNo := VendorAccount;
                    ExtDoc := MobileTrans."Member Account";
                    LoanNo := '';
                    TransType := Transtype::" ";

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, AccNo, CopyStr(MobileTrans.Description + ' Commission', 1, 50), Balacctype::"G/L Account",
                                  '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                    AccNo := SaccoAccount;
                    ExtDoc := MobileTrans."Member Account";
                    LoanNo := '';
                    TransType := Transtype::" ";

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", AccNo, CopyStr(MobileTrans.Description + ' Fee', 1, 50), Balacctype::"G/L Account",
                                  '', -SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());


                    MobileTrans.Posted := true;
                    MobileTrans."Posted By" := UserId;
                    MobileTrans."Date Posted" := Today;
                    MobileTrans.Modify;

                    SaccoTrans.JournalPost(JTemplate, JBatch);

                end
                else begin
                    Error('Transaction Not Found');
                end;


            end
            else begin
                Response := 'INSUFFICIENT_BAL';
            end;



            if Response = 'ERROR' then begin
                MobileTrans.Reset;
                MobileTrans.SetRange("Transaction ID", TransactionID);
                MobileTrans.SetRange(Posted, true);
                if MobileTrans.FindFirst then begin
                    //error(StatementAccount);
                    if BosaEntry = Bosaentry::None then begin
                        SLedger.Reset;
                        SLedger.SetCurrentkey("Posting Date");
                        SLedger.Ascending(false);
                        SLedger.SetRange("Account No.", StatementAccount);
                        SLedger.SetRange(Reversed, false);
                        if SLedger.FindFirst then begin
                            AccBal := 0;
                            Msg := 'MiniStatement: ' + StatementAccount;
                            repeat
                                LedgerCount += 1;
                                SLedger.CalcFields("Amount (LCY)");
                                Stmt := NewLine + Format(SLedger."Posting Date") + '; ' + SLedger.Description + '; ' + Format(SLedger."Amount (LCY)" * -1);
                                if StrLen(Msg + Stmt) < 250 then begin
                                    Msg += Stmt;
                                end;

                            until (SLedger.Next = 0) or (SLedger.Count = MaxNumberRows);

                            Priority := 203;
                            SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", Msg, StatementAccount, '', true, Priority, false);

                            Response := 'SUCCESS';
                        end;
                    end;
                end;
            end;
        end
        else begin
            Response := 'INVALID_ACCOUNT';
        end;
    end;


    procedure PinReset() CurrentUSSDPIN: Text
    var
        SkyworldUSSDAuth: Record "Sky USSD Auth";
        NewPin: Text;
        NewIntPin: Integer;
        SavAcc: Record "Savings Accounts";
        Msg: Text;
    begin


        SkyworldUSSDAuth.Reset;
        SkyworldUSSDAuth.SetRange(SkyworldUSSDAuth."Reset PIN", true);
        if SkyworldUSSDAuth.FindFirst then begin
            Priority := 200;
            repeat
                NewPin := RandomPIN;
                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Transactional Mobile No", SkyworldUSSDAuth."Mobile No.");
                if SavAcc.FindFirst then begin
                    Msg := 'Dear ' + SavAcc.Name + ', your ' + MbankingName + ' PIN is ' + NewPin + '. Dial ' + ShortCode + ' to access this service.';
                    SendSms(Source::PIN, SkyworldUSSDAuth."Mobile No.", Msg, SavAcc."No.", '', true, Priority, false);

                    SkyworldUSSDAuth."PIN No." := NewPin;
                    SkyworldUSSDAuth."Pin Sent" := true;
                    SkyworldUSSDAuth."Reset PIN" := false;
                    SkyworldUSSDAuth."Initial PIN Sent" := false;
                    SkyworldUSSDAuth."PIN Encrypted" := false;
                    SkyworldUSSDAuth."Force PIN" := true;
                    SkyworldUSSDAuth.Modify;
                end;
            until SkyworldUSSDAuth.Next = 0;
        end;
    end;


    procedure RandomPIN(): Text
    var
        NewPin: Text;
        NewIntPin: Integer;
    begin


        NewPin := '';
        NewIntPin := Random(9);
        NewPin += Format(NewIntPin);
        NewIntPin := Random(9);
        NewPin += Format(NewIntPin);
        NewIntPin := Random(9);
        NewPin += Format(NewIntPin);
        NewIntPin := Random(9);
        NewPin += Format(NewIntPin);


        exit(NewPin);
    end;


    procedure SendSms(Source: Enum "SMS Source Enum"; Telephone: Text[200];
                                  Textsms: Text;
                                  Reference: Text[40];
                                  AccNo: Text[30];
                                  Chargeable: Boolean;
                                  Priority: Integer;
                                  ChargeMember: Boolean) Inserted: Boolean
    var
        EntryNo: Integer;
        SkySMS: Record "Sky SMS Messages";
        Category: Code[100];
        SMSLength: Integer;
        SMSLoop: Integer;
        CurrSMS: Text;
        NewSMS: Text;
        GeneralLedgerSetup: Record "General Ledger Setup";
        Date: Date;
        Time: Time;
        SchedDateTime: DateTime;
    begin

        if not (Source in [Source::SkyMobile, Source::PORTAL]) then begin
            MActivities.SendSms(Source, Telephone, Textsms, Reference, AccNo, Chargeable, false);
            exit;
        end;

        EntryNo := EntryNo + 1;


        if StrLen(Telephone) = 13 then begin
            Telephone := CopyStr(Telephone, 2, 12);
        end;

        if StrLen(Telephone) = 10 then begin
            if CopyStr(Telephone, 1, 1) = '0' then
                Telephone := '254' + CopyStr(Telephone, 2, 9);
        end;

        if StrLen(Telephone) = 9 then begin
            if CopyStr(Telephone, 1, 1) = '7' then
                Telephone := '254' + Telephone
        end;



        Category := Format(Source);
        Priority := GetSMSPriority(Category);
        if Priority = 0 then
            Priority := 250;




        Date := Dmy2date(9, 12, 2021);
        Time := 191500T;


        GeneralLedgerSetup.Get;
        /*if GeneralLedgerSetup."SMS Sender ID" = 0 then
            GeneralLedgerSetup."SMS Sender ID" := 199;
        if GeneralLedgerSetup."SMS Sender Name" = '' then
            GeneralLedgerSetup."SMS Sender Name" := 'MOMBASAPORT';
        */
        //GeneralLedgerSetup.Modify();

        GeneralLedgerSetup.TestField("SMS Sender ID");
        GeneralLedgerSetup.TestField("SMS Sender Name");

        Inserted := false;

        if StrLen(Telephone) = 12 then begin
            SkySMS.Init;
            SkySMS.originator_id := CreateGuid;
            SkySMS.msg_id := 0;
            SkySMS.msg_product_id := GeneralLedgerSetup."SMS Sender ID";
            SkySMS.msg_provider_code := '0';
            SkySMS.msg_charge := '';
            SkySMS.msg_status_code := 10;
            SkySMS.msg_status_description := 'New MSG';
            SkySMS.msg_status_date := CurrentDatetime;
            SkySMS.sender := GeneralLedgerSetup."SMS Sender Name";
            SkySMS.receiver := Telephone;
            SkySMS.msg := Textsms;
            SkySMS.msg_type := 'MT';
            SkySMS.msg_source_reference := '';
            SkySMS.msg_destination_reference := '';
            SkySMS.msg_xml_data := '<OTHER_DETAILS/>';
            SkySMS.msg_category := Category;
            SkySMS.msg_priority := Priority;
            SkySMS.msg_send_count := 0;
            if Category = 'START_PIN' then begin
                SchedDateTime := CreateDatetime(Date, Time);
                SkySMS.schedule_msg := 'YES';
                SkySMS.date_scheduled := SchedDateTime;
            end
            else begin
                SkySMS.schedule_msg := 'NO';
                SkySMS.date_scheduled := CurrentDatetime;
            end;

            SkySMS.msg_send_integrity_hash := '';
            //SkySMS.msg_response_date:=CURRENTDATETIME;
            //SkySMS.msg_response_xml_data:='';
            //SkySMS.msg_response_integrity_hash:='';
            SkySMS.transaction_date := CurrentDatetime;
            SkySMS.date_created := CurrentDatetime;
            SkySMS."SMS Date" := Today;
            if Chargeable then
                SkySMS."Account To Charge" := AccNo;

            SkySMS.transaction_id := 0;
            SkySMS.server_id := 0;
            SkySMS.msg_charge_applied := '';
            SkySMS.msg_format := 'TEXT';
            SkySMS.msg_command := 'BulkSMS';
            SkySMS.msg_sensitivity := 'NORMAL';
            SkySMS.msg_response_description := '';
            SkySMS.msg_result_description := '';
            SkySMS.msg_result_xml_data := '';
            SkySMS.msg_result_date := CurrentDatetime;
            SkySMS.msg_result_integrity_hash := '';
            SkySMS.msg_result_submit_count := 0;
            SkySMS.msg_result_submit_status := 'PENDING';
            SkySMS.msg_result_submit_description := '';
            SkySMS.msg_result_submit_date := CurrentDatetime;
            SkySMS.sender_type := 'SENDER_ID';
            SkySMS.receiver_type := 'MSISDN';
            if Category = 'MPESA_DEPOSIT' then begin
                SkySMS.msg_mode := 'EXPRESS';
            end
            else begin
                SkySMS.msg_mode := 'SAF';
            end;
            if Source = Source::PIN then begin
                SkySMS.msg_general_flag := 'NOT_MASKED';
            end;
            SkySMS."Charge Member" := ChargeMember;

            SkySMS.Insert;
            Inserted := true;
        end;
    end;


    procedure GenerateNewPin(MobileNo: Code[20]) PinSent: Boolean
    var
        SkyworldUSSDAuth: Record "Sky USSD Auth";
        NewPin: Text;
        NewIntPin: Integer;
        SavAcc: Record "Savings Accounts";
        Msg: Text;
    begin
        MobileNo := '+' + MobileNo;

        PinSent := false;
        SkyworldUSSDAuth.Reset;
        SkyworldUSSDAuth.SetRange("Mobile No.", MobileNo);
        if SkyworldUSSDAuth.FindFirst then begin
            Priority := 200;
            NewPin := RandomPIN;
            SavAcc.Reset;
            SavAcc.SetRange("Transactional Mobile No", SkyworldUSSDAuth."Mobile No.");
            if SavAcc.FindFirst then begin
                //Msg := 'Dear ' + SavAcc.Name + ' your account no ' + SkyworldUSSDAuth."Account No." + 'has been registered for Mbanking. Your ' + MbankingName + ' PIN is ' + NewPin + '. Dial ' + ShortCode + ' to access this service.';
                //SendSms(Source::PIN, SkyworldUSSDAuth."Mobile No.", Msg, SavAcc."No.", '', true, Priority, false);

                SkyworldUSSDAuth."PIN No." := NewPin;
                SkyworldUSSDAuth."Pin Sent" := true;
                SkyworldUSSDAuth."Reset PIN" := false;
                SkyworldUSSDAuth."PIN Encrypted" := false;
                SkyworldUSSDAuth."Initial PIN Sent" := true;
                SkyworldUSSDAuth."Force PIN" := true;
                SkyworldUSSDAuth.Modify;
                PinSent := true;
            end;

        end;
    end;


    procedure GetAmountTransacted(Transaction: Text; AccountNo: Code[20]; Date: Date; Type: Option Daily,Weekly,Monthly) Amt: Decimal
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Bank Transfer";
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        MpesaTrans: Record "Sky USSD Auth";
        Continue: Boolean;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        AccBal: Decimal;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        TransactionDate: DateTime;
        MemberID: Code[20];
        PrePaymentGLend: Code[20];
        Loans: Record Loans;
        LoanNo: Code[20];
        MemberNo: Code[20];
        SDate: DateTime;
        EDate: DateTime;
    begin
        Amt := 0;

        if (Transaction = 'Till Purchase Request') or (Transaction = 'Withdrawal Request') or (Transaction = 'Utility Request') or (Transaction = 'Bank Transfer Request') then begin


            MobileWithdrawalsBuffer.RESET;
            MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer.Reversed, FALSE);
            MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Account No", AccountNo);
            MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer.Source, MobileWithdrawalsBuffer.Source::"M-PESA");
            MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Transaction Type", Transaction);
            IF Type = Type::Daily THEN
                MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Transaction Date", Date);
            IF Type = Type::Weekly THEN
                MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Transaction Date", CALCDATE('-CW', Date), CALCDATE('CW', Date));
            IF Type = Type::Monthly THEN
                MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Transaction Date", CALCDATE('-CM', Date), CALCDATE('CM', Date));
            IF MobileWithdrawalsBuffer.FIND('-') THEN BEGIN
                MobileWithdrawalsBuffer.CALCSUMS(Amount);
                Amt := MobileWithdrawalsBuffer.Amount;
            END;

            //SDate := Currentdatetime+3600000;
            // EDate := CurrentDatetime;
            // SDate := EDate + ((1000 * 60) * 60);

            // if Type = Type::Daily then
            //     SDate := CreateDatetime(CalcDate('-1D', Today), Dt2Time(SDate));
            // if Type = Type::Weekly then
            //     SDate := CreateDatetime(CalcDate('-1W', Today), Dt2Time(SDate));
            // if Type = Type::Monthly then
            //     SDate := CreateDatetime(CalcDate('-1M', Today), Dt2Time(SDate));

            // TransactionsBuffer.Reset;
            // TransactionsBuffer.SetRange(Reversed, false);
            // TransactionsBuffer.SetRange(TransactionsBuffer."Account No.", AccountNo);
            // TransactionsBuffer.SetRange(Date, SDate, EDate);
            // if TransactionsBuffer.Find('-') then begin
            //     TransactionsBuffer.CalcSums(Amount);
            //     Amt := TransactionsBuffer.Amount;
            // end;



        end;

    end;


    procedure CorrectPin(MobileNo: Code[30]; PIN: Text) Response: Boolean
    var
        SkyAuth: Record "Sky USSD Auth";
    begin


        Response := false;

        SkyAuth.Reset;
        SkyAuth.SetRange(SkyAuth."Mobile No.", MobileNo);
        if SkyAuth.FindFirst then begin
            if SkyAuth."PIN No." = PIN then
                Response := true
            else
                Response := false;
        end;
    end;


    procedure GetAllLoansList() Response: Text
    var
        MobileNo: Code[20];
        Loans: Record Loans;
        LoanProduct: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        MemberNo: Code[20];
        MaxLoan: Decimal;
    begin
        Response := '';
        LoanProduct.Reset;
        if LoanProduct.Find('-') then begin
            Response := '<Loans>';
            repeat

                if LoanProduct."USSD Product Name" = '' then
                    LoanProduct."USSD Product Name" := LoanProduct.Description;

                Response += '<Product>';
                Response += '<Code>' + LoanProduct."Product ID" + '</Code>';
                Response += '<ProductType>' + LoanProduct."USSD Product Name" + '</ProductType>';
                Response += '</Product>';

            until LoanProduct.Next = 0;
            Response += '</Loans>';

        end;
    end;


    procedure GetAdvancedMobileLoanList(Phone: Code[20]; Category: Code[20]; AccNo: Code[20]) Response: Text
    var
        SalType: Option " ",Checkoff,"Standing Order",Salary,Milk,Tea,Coffee,Dividend,Cash,Pension,Dependant,Others,"BOM income";
        QualAmt: Decimal;
        Remark: Text;
        MobileNo: Code[20];
        Loans: Record Loans;
        LoanProduct: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        MemberNo: Code[20];
        MaxLoan: Decimal;
        Cust: Record Members;
        Member: Record Members;
        FilterLoan: Boolean;
        TotalApplied: Decimal;
        MinLoan: Decimal;
        Msg: Text;
        SkipLoan: Boolean;


        "FOSA Loans": Decimal;
        "Net Salary": Decimal;
        ShareDeposits: decimal;
        "BOSA Loan balance": Decimal;
        "Maximum Credit": Decimal;
        "Maximum Fosa Credit": Decimal;
    begin


        MobileNo := '+' + Phone;
        Message('ss');

        Response := '';
        SavAcc.Reset;
        //SavAcc.SetRange("No.", AccNo);
        SavAcc.SETRANGE("Transactional Mobile No", MobileNo);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin

            MemberNo := SavAcc."Member No.";
            Members.Get(MemberNo);



            "FOSA Loans" := 0;
            ShareDeposits := 0;
            "BOSA Loan balance" := 0;
            "Net Salary" := 0;


            GetNonMobileLoanValues(SavAcc, "FOSA Loans", "Net Salary", ShareDeposits, "BOSA Loan balance", Members.Pensioner);




            LoanProduct.Reset;
            //LoanProduct.SETRANGE("Product ID",'136');
            LoanProduct.SetCurrentkey("Sorting Order");
            LoanProduct.SetRange("Available on Mobile", true);

            if Category = 'FOSA' then
                LoanProduct.SetRange("Loan Source", LoanProduct."Loan Source"::FOSA)
            else
                if Category = 'BOSA' then
                    LoanProduct.SetRange("Loan Source", LoanProduct."Loan Source"::BOSA);

            if LoanProduct.Find('-') then begin
                Response := '<Loans>';
                repeat
                    MaxLoan := 0;
                    MinLoan := LoanProduct."Minimum Loan Amount";


                    Msg := '';
                    Remark := '';
                    QualAmt := 0;


                    if LoanProduct."Back Office Available Online" then begin
                        "Maximum Credit" := 0;
                        "Maximum Fosa Credit" := 0;

                        GetNonMobileLoanLimits("FOSA Loans", "Net Salary", ShareDeposits, "BOSA Loan balance", LoanProduct."Deposit Multiplier", LoanProduct."Default Installments", LoanProduct."Appraisal % on Amount", LoanProduct."Interest Rate (Max.)", "Maximum Credit", "Maximum Fosa Credit");

                        if LoanProduct."Loan Source" = LoanProduct."Loan Source"::FOSA then
                            QualAmt := "Maximum Fosa Credit"
                        else
                            if LoanProduct."Loan Source" = LoanProduct."Loan Source"::BOSA then
                                QualAmt := "Maximum Credit";

                    end
                    else begin

                        if LoanProduct."Product ID" = 'L30' then
                            GetLoanQualifiedAmount(SavAcc."No.", LoanProduct."Product ID", QualAmt, Remark, RespCode);

                        if LoanProduct."Product ID" = 'L24' then
                            GetLoanQualifiedAmount(SavAcc."No.", LoanProduct."Product ID", QualAmt, Remark, RespCode);

                        if LoanProduct."Product ID" = 'L27' then
                            GetLoanQualifiedAmount(SavAcc."No.", LoanProduct."Product ID", QualAmt, Remark, RespCode);

                        if LoanProduct."Product ID" = 'L43' then
                            GetDividendLoanQualifiedAmount(SavAcc."No.", LoanProduct."Product ID", QualAmt, Remark);

                    end;

                    /*
                 if LoanProduct."Product ID" = 'OKOA ADV' then
                     GetOkoaLoanQualification(SavAcc."No.", LoanProduct."Product ID", QualAmt, Remark, SalType);
                 if LoanProduct."Product ID" = 'INUABIZ' then
                     GetInuaBiasharaLoanQualification(SavAcc."No.", LoanProduct."Product ID", QualAmt, Remark, LoanStage);
                 if LoanProduct."Product ID" = 'SELF GUA' then
                     GetSelfGuaranteedLoanQualification(SavAcc."No.", LoanProduct."Product ID", QualAmt, Remark);
                     */

                    Msg := Remark;
                    MaxLoan := QualAmt;


                    if MaxLoan = 0 then
                        MinLoan := 0;

                    Cust.Get(MemberNo);
                    //MinLoan += GetLoanProductBalance(MemberNo, LoanProduct."Product ID");

                    if MaxLoan > LoanProduct."Maximum Loan Amount" then
                        MaxLoan := LoanProduct."Maximum Loan Amount";

                    if LoanProduct."USSD Product Name" = '' then
                        LoanProduct."USSD Product Name" := LoanProduct.Description;


                    if MaxLoan = 0 then
                        if Msg = '' then
                            Msg := 'You do not Qualify for this Product.';
                    if MinLoan = 0 then
                        if Msg = '' then
                            Msg := 'You do not Qualify for this Product.';


                    SkipLoan := false;
                    if LoanProduct."Restrict to Member Code" <> '' then
                        if LoanProduct."Restrict to Member Code" <> MemberNo then
                            SkipLoan := true;


                    if LoanProduct."Available To Member" <> '' then
                        if LoanProduct."Available To Member" <> MemberNo then
                            SkipLoan := true;


                    if (not SkipLoan) and ((LoanProduct."Restrict to Emp. Code" = '') or (LoanProduct."Restrict to Emp. Code" = Cust."Employer Code")) then begin
                        Response += '<Product>';
                        Response += '<Code>' + LoanProduct."Product ID" + '</Code>';
                        Response += '<Type>' + LoanProduct."USSD Product Name" + '</Type>';

                        if MaxLoan > 0 then
                            Response += '<UserCanApply>' + 'TRUE' + '</UserCanApply>'
                        else begin
                            // IF Msg = ChannelThroughFosa THEN
                            Response += '<UserCanApply>' + 'FALSE' + '</UserCanApply>'
                            //  ELSE
                            //   Response += '<UserCanApply>'+'TRUE'+'</UserCanApply>'

                        end;


                        Response += '<Message>' + Msg + '</Message>';

                        if LoanProduct."Loan Source" = LoanProduct."Loan Source"::BOSA then
                            Response += '<Source>' + 'BOSA' + '</Source>'
                        else
                            if LoanProduct."Loan Source" = LoanProduct."Loan Source"::FOSA then
                                Response += '<Source>' + 'FOSA' + '</Source>';

                        /*
                        LoanProductstoBridge.RESET;
                        LoanProductstoBridge.SETRANGE("Product Code",LoanProduct."Product ID");
                        IF LoanProductstoBridge.FINDFIRST THEN BEGIN
                            REPEAT

                                Response += '<LoansToTopUp>';
                                    Response += '<PID>'+LoanProductstoBridge."Product To Bridge"+'</PID>';
                                    Response += '<PName>'+LoanProductstoBridge."Product Name"+'</PName>';
                                Response += '</LoansToTopUp>';
                            UNTIL LoanProductstoBridge.NEXT=0;
                        END;

                        IF TopUp>0 THEN BEGIN

                            Response += '<TopUp>'+FORMAT(TopUp)+'</TopUp>';
                            Response += '<NetAfterTopUp>'+FORMAT(QualifiedAmt)+'</NetAfterTopUp>';
                        END;
                        */


                        if LoanProduct."Mobile Loan Req. Guar." then
                            Response += '<RequiresGuarantors>' + 'TRUE' + '</RequiresGuarantors>'
                        else
                            Response += '<RequiresGuarantors>' + 'FALSE' + '</RequiresGuarantors>';


                        if LoanProduct."Requires Purpose" then
                            Response += '<RequiresPurpose>' + 'TRUE' + '</RequiresPurpose>'
                        else
                            Response += '<RequiresPurpose>' + 'FALSE' + '</RequiresPurpose>';


                        if LoanProduct."Requires Recoery Mode" then
                            Response += '<RequiresRecoveryMode>' + 'TRUE' + '</RequiresRecoveryMode>'
                        else
                            Response += '<RequiresRecoveryMode>' + 'FALSE' + '</RequiresRecoveryMode>';

                        if LoanProduct."Mobile Loan Req. Guar." then
                            Response += '<RequiresGuarantors>' + 'TRUE' + '</RequiresGuarantors>'
                        else
                            Response += '<RequiresGuarantors>' + 'FALSE' + '</RequiresGuarantors>';

                        if LoanProduct."Mobile Installments Type" = LoanProduct."mobile installments type"::None then
                            Response += '<InstallmentsType>' + 'NONE' + '</InstallmentsType>'
                        else
                            if LoanProduct."Mobile Installments Type" = LoanProduct."mobile installments type"::Input then
                                Response += '<InstallmentsType>' + 'INPUT' + '</InstallmentsType>'
                            else
                                Response += '<InstallmentsType>' + 'PRESET' + '</InstallmentsType>';



                        if LoanProduct."Mobile Installments Type" = LoanProduct."mobile installments type"::None then begin
                            Response += '<InputInstallments>';
                            Response += '<Minimum>' + Format(1) + '</Minimum>';
                            Response += '<Maximum>' + Format(LoanProduct."Default Installments") + '</Maximum>';
                            Response += '</InputInstallments>';
                        end;

                        if LoanProduct."Mobile Installments Type" = LoanProduct."mobile installments type"::Input then begin
                            Response += '<InputInstallments>';
                            Response += '<Minimum>' + Format(1) + '</Minimum>';
                            Response += '<Maximum>' + Format(LoanProduct."Default Installments") + '</Maximum>';
                            Response += '</InputInstallments>';
                        end;

                        /*
                        IF LoanProduct."Mobile Installments Type" = LoanProduct."Mobile Installments Type"::Preset THEN BEGIN

                              MobileLoanInstallments.RESET;
                              MobileLoanInstallments.SETRANGE(Product,LoanProduct."Product ID");
                              IF MobileLoanInstallments.FINDFIRST THEN BEGIN
                                  Response += '<PresetInstallments>';
                                  REPEAT

                                      Response += '<Installment Id="'+FORMAT(MobileLoanInstallments.Installments)+'" Label="'+MobileLoanInstallments.Caption+'">';

                                          Response += '<Qualification>';
                                              Response += '<Minimum>'+FORMAT(MinLoan)+'</Minimum>';
                                              IF LoanProduct."Loan Source" = LoanProduct."Loan Source"::"BOSA" THEN
                                                  Response += '<Maximum>'+FORMAT(MaxLoan)+'</Maximum>'
                                              ELSE
                                                  Response += '<Maximum>'+FORMAT(MaxLoan)+'</Maximum>';
                                          Response += '</Qualification>';

                                      Response += '</Installment>';

                                  UNTIL MobileLoanInstallments.NEXT=0;
                                  Response += '</PresetInstallments>';
                              END;

                        END;
                        */
                        Response += '<NumberOfGuarantors>';
                        Response += '<Minimum>' + Format(LoanProduct."Mobile Min. Guarantors") + '</Minimum>';
                        Response += '<Maximum>' + Format(LoanProduct."Mobile Max. Guarantors") + '</Maximum>';
                        Response += '</NumberOfGuarantors>';


                        Response += '<DefaultQualification>';
                        Response += '<Minimum>' + Format(MinLoan) + '</Minimum>';
                        Response += '<Maximum>' + Format(MaxLoan) + '</Maximum>';
                        Response += '</DefaultQualification>';

                        if LoanProduct."Requires TnC" then
                            Response += '<RequiresTnC>' + 'TRUE' + '</RequiresTnC>'
                        else
                            Response += '<RequiresTnC>' + 'FALSE' + '</RequiresTnC>';

                        if LoanProduct."Shows Mobile Qualification" then
                            Response += '<ShowsQualification>' + 'TRUE' + '</ShowsQualification>'
                        else
                            Response += '<ShowsQualification>' + 'FALSE' + '</ShowsQualification>';

                        if LoanProduct."Requires Payslip PIN" then
                            Response += '<RequiresPayslipPIN>' + 'TRUE' + '</RequiresPayslipPIN>'
                        else
                            Response += '<RequiresPayslipPIN>' + 'FALSE' + '</RequiresPayslipPIN>';



                        Response += '</Product>';
                    end;

                until LoanProduct.Next = 0;
                Response += '</Loans>';

            end;

        end;

    end;



    procedure GetLoanPeriods(PhoneNo: Text[30]; LoanCode: Code[20]; Duration: Integer) Response: Text
    var
        SavAcc: Record "Savings Accounts";
        PFact: Record "Product Setup";
        AccName: Text;
        Ability: Decimal;
        MaxLoan: array[3] of Decimal;
        IncLevel: Decimal;
        LoanProduct: Record "Product Setup";
        LBalC: Decimal;
        Loans: Record Loans;
        TotalApplied: Decimal;
        Members: Record Members;
    begin


        PhoneNo := '+' + PhoneNo;

        //if LoanCode = 'M-LOAN' then begin
        Response := '';
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        if SavAcc.FindFirst then begin
            Response := ' <Periods>';

            repeat


                Members.Get(SavAcc."Member No.");
                Ability := GetAbilityToRepay(SavAcc."No.", loancode);//MobileLoanQualification(MobileLoan."Entry Code");

                MaxLoan[1] := Ability * 1;
                MaxLoan[2] := Ability * 3;
                MaxLoan[3] := Ability * 6;
                //Members.CalcFields("Current Shares");


                /*
                IncLevel := DepositInconsistencyLevel(Members."No.");
                MaxLoan[1] -= (MaxLoan[1]*IncLevel/100);
                MaxLoan[2] -= (MaxLoan[2]*IncLevel/100);
                MaxLoan[3] -= (MaxLoan[3]*IncLevel/100);
                */




                LoanProduct.Get(LoanCode);



                if MaxLoan[1] < 0 then
                    MaxLoan[1] := 0;
                if MaxLoan[2] < 0 then
                    MaxLoan[2] := 0;
                if MaxLoan[3] < 0 then
                    MaxLoan[3] := 0;


                if Duration = 1 then
                    exit(Format(MaxLoan[1]));
                if Duration = 3 then
                    exit(Format(MaxLoan[2]));
                if Duration = 5 then
                    exit(Format(MaxLoan[3]));


                if SavAcc."Salary Processing" then begin
                    Response += '<Period>';
                    Response += '<No>' + '1' + '</No>';
                    Response += '<Name>' + '1 Month (Upto KES ' + Format(MaxLoan[1]) + ')</Name>';
                    //Response+='0</Period>';
                    Response += '</Period>';
                    Response += '<Period>';
                    Response += '<No>' + '3' + '</No>';
                    Response += '<Name>' + '3 Months (Upto KES ' + Format(MaxLoan[2]) + ')</Name>';
                    Response += '</Period>';

                    Response += '<Period>';
                    Response += '<No>' + '5' + '</No>';
                    Response += '<Name>' + '5 Months (Upto KES ' + Format(MaxLoan[3]) + ')</Name>';
                    Response += '</Period>';

                end
                else begin

                    Response += '<Period>';
                    Response += '<No>' + '1' + '</No>';
                    Response += '<Name>' + '1 Month (Upto KES ' + Format(MaxLoan[1]) + ')</Name>';
                    Response += '</Period>';

                    Response += '<Period>';
                    Response += '<No>' + '3' + '</No>';
                    Response += '<Name>' + '3 Months (Upto KES ' + Format(MaxLoan[2]) + ')</Name>';
                    Response += '</Period>';



                end;
            until SavAcc.Next = 0;

            Response += '</Periods>';
        end;

        //end;
        //IF LoanCode = 'DIVIDEND' THEN BEGIN
        //    LoanProduct.GET('DIVIDEND');
        //    Response:='';
        //    SavAcc.RESET;
        //    SavAcc.SETRANGE("Transactional Mobile No",PhoneNo);
        //    SavAcc.SETRANGE("Account Type",'ORDINARY');
        //    IF SavAcc.FINDFIRST THEN BEGIN
        //            Members.GET(SavAcc."Member No.");
        //            Loans.RESET;
        //            Loans.SETRANGE(Loans."BOSA No",SavAcc."Member No.");
        //            Loans.SETRANGE(Loans."Loan Product Type",'DIVIDEND');
        //            Loans.SETRANGE(Posted,TRUE);
        //            Loans.SETFILTER(Loans."Issued Date",'>%1',LoanProduct."Div Advance Start Date");
        //            IF Loans.FINDFIRST THEN BEGIN
        //               REPEAT
        //                  TotalApplied += Loans."Approved Amount";
        //               UNTIL Loans.NEXT = 0;
        //            END;
        //            MaxLoan[1] :=  Members."Dividend Amount" - TotalApplied;
        //            IF Duration = 1 THEN
        //              EXIT(FORMAT(MaxLoan[1]));

        //            Response+='<Periods>';
        //                Response+='<Period>';
        //                    Response+='<No>'+'1'+'</No>';
        //                    Response+='<Name>'+'Dividend Advance (Upto KES '+FORMAT(MaxLoan[1])+')</Name>';
        //                Response+='</Period>';
        //            Response+='</Periods>';
        //    END;

        //END;
        //here

    end;




    procedure GetMaxSharesToTrade("Action": Code[10]; AccountNo: Code[100]; Price: Decimal) Response: Text
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Bank Transfer",Airtime,"Bank Deposit","Bank Agent Deposit";
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        MpesaTrans: Record "Sky Transactions.";
        Continue: Boolean;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        AccBal: Decimal;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        TransactionDate: DateTime;
        MemberID: Code[20];
        PrePaymentGL: Code[20];
        Loans: Record Loans;
        LoanNo: Code[20];
        MemberNo: Code[20];
        Type: Option Daily,Weekly,Monthly;
        Limit: Decimal;
        msg: Text;
        DepositEntry: Boolean;
        ShareEntry: Boolean;
        PayBillAccNo: Code[20];
        AccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Shares Capital","Deposit Contribution","Benevolent Funds";
        ValidateAccount: Code[100];
        TotalShares: Decimal;
        Available: Decimal;
        //ShareTransactionsBuffer: Record UnknownRecord39004359;
        NewApplicationNo: Integer;
        //Charges: Record UnknownRecord39004265;
        Duty: Decimal;
        ChargeAmount: Decimal;
        Buffered: Decimal;
        ParValue: Decimal;
        TotalAmount: Decimal;
        NoOfShares: Integer;
    begin

        GenSetup.Get;
        Buffered := 0;
        ParValue := 20;
        NoOfShares := 0;
        /*


        if Action = 'SELL' then begin
            if Members.Get(AccountNo) then begin

                Charges.Reset;
                Charges.SetRange(Charges."Charge Type", Charges."charge type"::"OTC Sell");
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then
                        ChargeAmount := TotalShares * Charges."Percentage of Amount" * 0.01
                    else
                        ChargeAmount := Charges."Charge Amount";
                end;

                Duty := ChargeAmount * (GenSetup."Excise Duty (%)" / 100);
                TotalCharge := ChargeAmount + Duty;


                Members.CalcFields("Shares Retained");


                ShareTransactionsBuffer.Reset;
                ShareTransactionsBuffer.SetRange("Member No", AccountNo);
                ShareTransactionsBuffer.SetRange(Type, ShareTransactionsBuffer.Type::Sell);
                ShareTransactionsBuffer.SetRange(Cancel, false);
                ShareTransactionsBuffer.SetRange(Transfered, false);
                if ShareTransactionsBuffer.FindFirst then begin
                    ShareTransactionsBuffer.CalcSums(ShareTransactionsBuffer."Amount (Par Value)");
                    Buffered := ShareTransactionsBuffer."Amount (Par Value)";
                end;
                Available := (Members."Shares Retained" - GenSetup."Min. Share Capital" - Buffered);
                NoOfShares := ROUND(Available / ParValue, 1, '<');
            end;
        end;

        if Action = 'BUY' then begin

            if SavAcc.Get(AccountNo) then begin


                Available := GetAccountBalance(SavAcc."No.");
                Charges.Reset;
                Charges.SetRange(Charges."Charge Type", Charges."charge type"::"OTC Buy");
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then
                        Available := Available * (100 - (Charges."Percentage of Amount" + 0.3)) * 0.01
                    else
                        Available := Available - (Charges."Charge Amount" + (Charges."Charge Amount" * (GenSetup."Excise Duty (%)" / 100)));
                end;

                Duty := ChargeAmount * (GenSetup."Excise Duty (%)" / 100);
                TotalCharge := ChargeAmount + Duty;


                ShareTransactionsBuffer.Reset;
                ShareTransactionsBuffer.SetRange("Member No", AccountNo);
                ShareTransactionsBuffer.SetRange(Type, ShareTransactionsBuffer.Type::Buy);
                ShareTransactionsBuffer.SetRange(Cancel, false);
                ShareTransactionsBuffer.SetRange(Transfered, false);
                if ShareTransactionsBuffer.FindFirst then begin
                    ShareTransactionsBuffer.CalcSums(ShareTransactionsBuffer."Total price");
                    Buffered := ShareTransactionsBuffer."Total price";
                end;


                Available := Available
                - Buffered;
                NoOfShares := ROUND(Available / Price, 1, '<');
            end;
        end;

        if NoOfShares < 0 then
            NoOfShares := 0;


        Response := Format(MinShareToBuy) + ':::' + Format(NoOfShares)
        */
    end;




    procedure TradeShares("Action": Code[10]; AccountNo: Code[100]; Price: Decimal; Shares: Integer; PIN: Text; PhoneNo: Text) Response: Text[1024]
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Bank Transfer",Airtime,"Bank Deposit","Bank Agent Deposit";
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        MpesaTrans: Record "Sky Transactions.";
        Continue: Boolean;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        AccBal: Decimal;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        TransactionDate: DateTime;
        MemberID: Code[20];
        PrePaymentGL: Code[20];
        Loans: Record Loans;
        LoanNo: Code[20];
        MemberNo: Code[20];
        Type: Option Daily,Weekly,Monthly;
        Limit: Decimal;
        msg: Text;
        DepositEntry: Boolean;
        ShareEntry: Boolean;
        PayBillAccNo: Code[20];
        AccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Shares Capital","Deposit Contribution","Benevolent Funds";
        ValidateAccount: Code[100];
        TotalShares: Decimal;
        Available: Decimal;
        //ShareTransactionsBuffer: Record UnknownRecord39004359;
        NewApplicationNo: Integer;
        //Charges: Record UnknownRecord39004265;
        Duty: Decimal;
        ChargeAmount: Decimal;
        Buffered: Decimal;
        ParValue: Decimal;
        TotalAmount: Decimal;
    begin
        /*
        if PhoneNo = '' then
            Error('Parameter PhoneNo Must have a value');

        GenSetup.Get;
        Buffered := 0;
        ParValue := 20;

        TotalShares := ParValue * Shares;
        TotalAmount := Price * Shares;

        if Action = 'SELL' then begin
            if Members.Get(AccountNo) then begin



                Charges.Reset;
                Charges.SetRange(Charges."Charge Type", Charges."charge type"::"OTC Sell");
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then
                        ChargeAmount := TotalShares * Charges."Percentage of Amount" * 0.01
                    else
                        ChargeAmount := Charges."Charge Amount";
                end;

                Duty := ChargeAmount * (GenSetup."Excise Duty (%)" / 100);
                TotalCharge := ChargeAmount + Duty;


                Members.CalcFields("Shares Retained");


                ShareTransactionsBuffer.Reset;
                ShareTransactionsBuffer.SetRange("Member No", AccountNo);
                ShareTransactionsBuffer.SetRange(Type, ShareTransactionsBuffer.Type::Sell);
                ShareTransactionsBuffer.SetRange(Cancel, false);
                ShareTransactionsBuffer.SetRange(Transfered, false);
                if ShareTransactionsBuffer.FindFirst then begin
                    ShareTransactionsBuffer.CalcSums(ShareTransactionsBuffer."Amount (Par Value)");
                    Buffered := ShareTransactionsBuffer."Amount (Par Value)";
                end;
                Available := (Members."Shares Retained" - GenSetup."Min. Share Capital" - Buffered);

                if TotalShares <= Available then begin


                    ShareTransactionsBuffer.Reset;
                    if ShareTransactionsBuffer.FindLast then
                        NewApplicationNo := ShareTransactionsBuffer."Entry No" + 1
                    else
                        NewApplicationNo := 1;

                    ShareTransactionsBuffer.Reset;
                    ShareTransactionsBuffer."Entry No" := NewApplicationNo;
                    ShareTransactionsBuffer."Member No" := AccountNo;
                    ShareTransactionsBuffer.Validate(ShareTransactionsBuffer."Member No");
                    ShareTransactionsBuffer.Type := ShareTransactionsBuffer.Type::Sell;
                    ShareTransactionsBuffer."No Of Shares" := Shares;
                    ShareTransactionsBuffer.Validate(ShareTransactionsBuffer."No Of Shares");
                    ShareTransactionsBuffer."Date Requested" := Today;
                    ShareTransactionsBuffer."Transacting Account" := Members."FOSA Account";
                    ShareTransactionsBuffer."Quoted price" := Price;
                    ShareTransactionsBuffer.Validate(ShareTransactionsBuffer."Quoted price");
                    ShareTransactionsBuffer."Buy or Sale option" := ShareTransactionsBuffer."buy or sale option"::Partial;
                    ShareTransactionsBuffer.Cancel := false;
                    ShareTransactionsBuffer."Cancelled By" := '';

                    if ShareTransactionsBuffer.Insert(true) then begin

                        //send sms to seller
                        msg := 'Dear member, Your intention to sell ' + Format(Shares) + ' shares at ' + Format(Price) +
                        ' has been placed successfully. You will be notified once transaction is complete' + NewLine + '. REF ' + Format(NewApplicationNo);
                        SendSms('MBANKING', Members."Phone No.", msg, Members."FOSA Account", '', false, Priority, false, UserId);
                        Response := 'SUCCESS:::Success';

                    end;
                end
                else begin
                    Response := 'ERROR:::You have insufficient Share Capital';
                end;
            end
            else begin
                Response := 'ERROR:::Member No not Found';
            end;
        end;



        if Action = 'BUY' then begin

            if SavAcc.Get(AccountNo) then begin

                Charges.Reset;
                Charges.SetRange(Charges."Charge Type", Charges."charge type"::"OTC Buy");
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then
                        ChargeAmount := TotalAmount * Charges."Percentage of Amount" * 0.01
                    else
                        ChargeAmount := Charges."Charge Amount";
                end;

                Duty := ChargeAmount * (GenSetup."Excise Duty (%)" / 100);
                TotalCharge := ChargeAmount + Duty;


                ShareTransactionsBuffer.Reset;
                ShareTransactionsBuffer.SetRange("Member No", AccountNo);
                ShareTransactionsBuffer.SetRange(Type, ShareTransactionsBuffer.Type::Buy);
                ShareTransactionsBuffer.SetRange(Cancel, false);
                ShareTransactionsBuffer.SetRange(Transfered, false);
                if ShareTransactionsBuffer.FindFirst then begin
                    ShareTransactionsBuffer.CalcSums(ShareTransactionsBuffer."Total price");
                    Buffered := ShareTransactionsBuffer."Total price";
                end;


                Available := GetAccountBalance(SavAcc."No.") - TotalCharge - Buffered;

                //Error('TotalAmount %1\ Available %2',TotalAmount ,Available);
                if TotalAmount <= Available then begin


                    ShareTransactionsBuffer.Reset;
                    if ShareTransactionsBuffer.FindLast then
                        NewApplicationNo := ShareTransactionsBuffer."Entry No" + 1
                    else
                        NewApplicationNo := 1;

                    ShareTransactionsBuffer.Reset;
                    ShareTransactionsBuffer."Entry No" := NewApplicationNo;
                    ShareTransactionsBuffer."Member No" := SavAcc."Member No.";
                    ShareTransactionsBuffer.Validate(ShareTransactionsBuffer."Member No");
                    ShareTransactionsBuffer.Type := ShareTransactionsBuffer.Type::Buy;
                    ShareTransactionsBuffer."No Of Shares" := Shares;
                    ShareTransactionsBuffer.Validate(ShareTransactionsBuffer."No Of Shares");
                    ShareTransactionsBuffer."Date Requested" := Today;
                    ShareTransactionsBuffer."Transacting Account" := AccountNo;
                    ShareTransactionsBuffer."Quoted price" := Price;
                    ShareTransactionsBuffer.Validate(ShareTransactionsBuffer."Quoted price");
                    ShareTransactionsBuffer."Buy or Sale option" := ShareTransactionsBuffer."buy or sale option"::Partial;
                    ShareTransactionsBuffer.Cancel := false;
                    ShareTransactionsBuffer."Cancelled By" := '';
                    if ShareTransactionsBuffer.Insert(true) then begin
                        Commit;
                        //send sms to seller
                        msg := 'Dear member, Your intention to purchase ' + Format(Shares) + ' shares at ' + Format(Price) +
                        ' has been placed successfully. You will be notified once transaction is complete. REF ' + Format(NewApplicationNo);
                        SendSms('MBANKING', SavAcc."Phone No.", msg, Members."FOSA Account", '', false, Priority, false, UserId);
                        Response := 'SUCCESS:::Success';
                    end;


                end
                else begin
                    Response := 'ERROR:::You have insufficient Balance';
                end;
            end
            else begin
                Response := 'ERROR:::Member No not Found';
            end;
        end;
        */
    end;



    procedure GetMobileLoanList(Phone: Code[20]) Response: Text
    var
        SalType: Option " ",Checkoff,"Standing Order",Salary,Milk,Tea,Coffee,Dividend,Cash,Pension,Dependant,Others,"BOM income";
        QualAmt: Decimal;
        Remark: Text;
        MobileNo: Code[20];
        Loans: Record Loans;
        LoanProduct: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        MemberNo: Code[20];
        MaxLoan: Decimal;
        Cust: Record Members;
        Member: Record Members;
        FilterLoan: Boolean;
        TotalApplied: Decimal;
    begin

        MobileNo := '+' + Phone;
        FilterLoan := false;

        Response := '';
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", MobileNo);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin

            MemberNo := SavAcc."Member No.";
            Member.Get(MemberNo);

            //IF (Member."Member Type" <> Member."Member Type"::Staff) AND  (Member."Member Type" <> Member."Member Type"::Board) THEN
            // FilterLoan := TRUE;

            Message(Format(FilterLoan));

            LoanProduct.Reset;
            LoanProduct.SetRange("Available on Mobile", true);
            if LoanProduct.Find('-') then begin
                Response := '<Loans>';
                repeat


                    if LoanProduct."USSD Product Name" = '' then
                        LoanProduct."USSD Product Name" := LoanProduct.Description;

                    //MaxLoan:=GetLoanQualifiedAmount(SavAcc."No.",LoanProduct."Product ID");
                    Remark := '';
                    QualAmt := 0;

                    MaxLoan := QualAmt;
                    Cust.Get(MemberNo);
                    if (LoanProduct."Restrict to Emp. Code" = '') or (LoanProduct."Restrict to Emp. Code" = Cust."Employer Code") then begin
                        Response += '<Product>';
                        Response += '<Code>' + LoanProduct."Product ID" + '</Code>';
                        Response += '<ProductType>' + LoanProduct.Description + '</ProductType>';
                        if LoanProduct."Member To Capture Period" then
                            Response += '<RequiresDuration>TRUE</RequiresDuration>'
                        else
                            Response += '<RequiresDuration>FALSE</RequiresDuration>';

                        Response += '<MaxAmount>' + Format(MaxLoan) + '</MaxAmount>';
                        Response += '</Product>';
                    end;

                until LoanProduct.Next = 0;
                Response += '</Loans>';

            end;

        end;
    end;


    procedure ApplyLoan(EntryCode: Code[50]; TransactionID: Code[20]; Phone: Code[20]; LoanType: Code[20]; LoanAmount: Decimal; PIN: Text; LoanPeriod: Integer; LoanPurpose: Code[10]; Password: Text; RecoveryMode: Text; AccountNo: Code[20]) Response: Text
    var
        MobileNo: Code[20];
        Loans: Record Loans;
        LoanProduct: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        MemberNo: Code[20];
        MaxLoan: Decimal;
        LoanAccountNo: Code[20];
        MobileLoans: Record "Sky Mobile Loans";
        Members: Record Members;
        TotalOutstandingBal: Decimal;
        msg: Text;
        Stop: Boolean;
    begin
        MobileNo := '+' + Phone;
        Response := 'ERROR';
        if not CorrectPin(MobileNo, PIN) then begin
            Response := 'INCORRECT_PIN';
            exit;
        end;

        SavAcc.Reset;
        if AccountNo <> '' then
            SavAcc.SetRange("No.", AccountNo);
        SavAcc.setrange("Transactional Mobile No", MobileNo);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin

            MemberNo := SavAcc."Member No.";

            Members.Get(MemberNo);

            /*
       IF Members."Member Type" <> Members."Member Type"::Staff THEN
           IF Members."Member Type" <> Members."Member Type"::Board THEN BEGIN
               Response:='LOAN_PRODUCT_DISABLED';
               EXIT;
           END;
           */

            LoanProduct.Reset;
            LoanProduct.SetRange("Product ID", LoanType);
            LoanProduct.SetRange("Available on Mobile", true);
            if LoanProduct.Find('-') then begin
                MobileLoans.Reset;
                MobileLoans.SetRange("Account No", SavAcc."No.");
                MobileLoans.SetRange(Status, MobileLoans.Status::Pending);
                MobileLoans.SetRange("Loan Product Type", LoanProduct."Product ID");
                if MobileLoans.FindFirst then begin
                    Response := 'LOAN_APPLICATION_EXISTS';
                end
                else begin

                    /*
                    MobileLoans.INIT;
                    MobileLoans."Entry No":=0;
                    MobileLoans."Disbursement Account No":=SavAcc."No.";
                    MobileLoans.Date:=CURRENTDATETIME;
                    MobileLoans."Requested Amount":=LoanAmount;
                    MobileLoans.Status:=MobileLoans.Status::Pending;
                    MobileLoans."Loan Product Type":=LoanProduct."Product ID";
                    MobileLoans.Amount:=LoanAmount;
                    MobileLoans."Entry Code" := EntryCode;
                    MobileLoans."Session ID":=TransactionID;
                    MobileLoans."Date Entered":=TODAY;
                    MobileLoans."Time Entered":=TIME;
                    MobileLoans."Telephone No":=SavAcc."Transactional Mobile No";
                    MobileLoans.Period:=LoanPeriod;
                    MobileLoans.Name:=SavAcc.Name;
                    MobileLoans."Staff No" := SavAcc."Staff No";
                    MobileLoans."Member No." := SavAcc."Member No.";
                    MobileLoans."Member No" := SavAcc."Member No.";
        
        
                    MobileLoans.INSERT;
                    */

                    if LoanProduct."Product ID" = 'L05' then
                        LoanPurpose := '8310';
                    if LoanProduct."Product ID" = 'L07' then
                        LoanPurpose := '8310';

                    if LoanProduct."USSD Product Name" = '' then
                        LoanProduct."USSD Product Name" := LoanProduct.Description;



                    MobileLoans.Init;
                    MobileLoans."Entry No" := CreateGuid;
                    MobileLoans.DocumentNo := TransactionID;
                    MobileLoans.Channel := MobileLoans.Channel::"Sky World";
                    MobileLoans."Account No" := SavAcc."No.";
                    MobileLoans."Account Name" := SavAcc.Name;
                    MobileLoans.Name := SavAcc.Name;
                    MobileLoans."Member No" := SavAcc."Member No.";
                    MobileLoans."Member No." := SavAcc."Member No.";
                    MobileLoans.Date := CurrentDatetime;
                    MobileLoans."Requested Amount" := LoanAmount;
                    MobileLoans.Status := MobileLoans.Status::Pending;
                    MobileLoans."Loan Product Type" := LoanProduct."Product ID";
                    if LoanProduct."Back Office Available Online" then
                        MobileLoans."Mobile Loan" := MobileLoans."Mobile Loan"::No;

                    MobileLoans."Loan Name" := LoanProduct."USSD Product Name";
                    if MobileLoans."Loan Name" = '' then
                        MobileLoans."Loan Name" := LoanProduct.Description;
                    MobileLoans.Amount := LoanAmount;
                    if LoanPeriod = 0 then
                        LoanPeriod := LoanProduct."Default Installments";
                    MobileLoans."Entry Code" := EntryCode;
                    MobileLoans."Session ID" := TransactionID;
                    MobileLoans."Date Entered" := Today;
                    MobileLoans."Time Entered" := Time;
                    MobileLoans."Telephone No" := MobileNo;
                    MobileLoans."Loan Period" := LoanPeriod;
                    //MobileLoans.Password := Password;
                    MobileLoans."Loan Purpose" := LoanPurpose;
                    MobileLoans."Repay Mode" := RecoveryMode;
                    //MobileLoans."Salary Loan" := LoanProduct."Salary Loans";
                    /*
                    IF LoanProduct."Loan Source" = LoanProduct."Loan Source"::B THEN
                        MobileLoans.Source := 'BOSA';
                    IF LoanProduct."Loan Source" = LoanProduct."Loan Source"::F THEN
                        MobileLoans.Source := 'FOSA';
                    */


                    MobileLoans."Needs Guarantors" := LoanProduct."Mobile Loan Req. Guar.";
                    if MobileLoans."Needs Guarantors" then begin
                        LoanProduct.TestField("Minimum Guarantors");
                        MobileLoans.Status := MobileLoans.Status::"Pending Guarantors";
                        MobileLoans."Expected Guarantors" := LoanProduct."Minimum Guarantors";
                    end;

                    //MobileLoans."Micro Loan" := LoanProduct."Micro Loan";

                    /*
                    MicroLoanPurpose.RESET;
                    MicroLoanPurpose.SETRANGE("Loan Type",LoanProduct."Product ID");
                    MicroLoanPurpose.SETRANGE("Mobile Based",TRUE);
                    IF MicroLoanPurpose.FINDFIRST THEN BEGIN
                        IF Members.GET(MemberNo) THEN BEGIN
                            IF MicroLoanPurpose."Guarantors Mandatory For" = MicroLoanPurpose."Guarantors Mandatory For"::"Non-Members" THEN
                                IF (Members."Non-Member") AND (NOT Members."Group Account") THEN
                                    MobileLoans."Needs Guarantors" := TRUE;
        
                            IF MicroLoanPurpose."Guarantors Mandatory For" = MicroLoanPurpose."Guarantors Mandatory For"::Groups THEN
                                IF Members."Group Account" THEN
                                    MobileLoans."Needs Guarantors" := TRUE;
        
                            IF MicroLoanPurpose."Guarantors Mandatory For" = MicroLoanPurpose."Guarantors Mandatory For"::"Members & Non-Members" THEN
                                IF NOT Members."Group Account" THEN
                                    MobileLoans."Needs Guarantors" := TRUE;
                            IF MicroLoanPurpose."Guarantors Mandatory For" = MicroLoanPurpose."Guarantors Mandatory For"::Members THEN
                                IF (NOT Members."Non-Member") AND (NOT Members."Group Account") THEN
                                    MobileLoans."Needs Guarantors" := TRUE;
        
                            IF MobileLoans."Needs Guarantors" THEN
                                MobileLoans.Status := MobileLoans.Status::"Pending Guarantors";
        
                        END;
                    END;
                    */



                    if MobileLoans."Loan Product Type" = 'DIVIDEND' then begin

                    end;

                    MobileLoans.Insert;
                    if LoanProduct."Mobile Loan Req. Guar." then begin

                        msg := 'Dear ' + FirstName(SavAcc.name) + ', ' +
                              NewLine + 'To add guarantors to your ' + MobileLoans."Loan Name" + ' request of KES ' + Format(MobileLoans.Amount) + ', Please dial ' + ShortCode + ' or use our Mobile App.' +
                              NewLine + 'Login > Loans > Add / Remove Guarantors. ' +
                              NewLine + 'REF: ' + MobileLoans."Entry Code";
                        SendSms(Source::SkyMobile, Phone, msg, Format(MobileLoans."Entry Code"), '', true, Priority, false);
                    end;


                    Response := 'SUCCESS';

                    ProcessMobileLoan(MobileLoans."Entry No", Stop);
                end;
            end
            else begin
                Error('Loan product not found');
            end;
        end
        else begin
            Error('Member account not found');
        end;

    end;


    procedure FirstName(Text: Text[100]) FName: Text[100]
    var
        Pos: Integer;
    begin
        Pos := StrPos(Text, ' ');

        if Pos > 0 then begin
            FName := CopyStr(Text, 1, Pos - 1);
        end else begin
            FName := Text;
        end;
    end;

    procedure PostMobileLoans()
    var
        myInt: Integer;
        SkyLoans: Record "Sky Mobile Loans";
        Stop: Boolean;
    begin
        SkyLoans.reset();
        SkyLoans.SetRange(Posted, False);
        SkyLoans.SetRange(Status, SkyLoans.Status::Pending);
        if SkyLoans.FindSet() then
            repeat
                ProcessMobileLoan(SkyLoans."Entry No", Stop);
            until SkyLoans.Next() = 0;
    end;

    procedure ProcessMobileLoan(EntryNo: Guid; var Stop: boolean)
    var
        SActivities: codeunit "Sacco Activities";
        SalType: Enum "Repay Mode Enum";
        MobileNo: Code[20];
        RepAmt: Decimal;
        Loans: Record Loans;
        LoanProduct: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        FosaAcc: Record "Savings Accounts";
        MemberNo: Code[20];
        MaxLoan: Decimal;
        LoanAccountNo: Code[20];
        LoanType: Code[20];
        LoanAmount: Decimal;
        MobileLoan: Record "Sky Mobile Loans";
        Continue: Boolean;
        msg: Text;
        Product: Record "Product Setup";
        nDays: Integer;
        SavingsAccounts: Record "Savings Accounts";
        ShareCap: Decimal;
        Members: Record Members;
        LoanNo: Code[20];
        JTemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        TransactionType: Enum "Transaction Type Enum";
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        UpfrontInterest: Decimal;
        PCharges: Record "Loan Product Charges.";
        Amt: Decimal;
        Custdet: Record "Credit Ledger Entry";
        Member: Record Members;
        CustR: Record Customer;
        DepAvg: Decimal;
        Ability: Decimal;
        IncLevel: Decimal;
        VendorBalAcc: Code[20];
        LBalC: Decimal;
        LInt: Decimal;
        ClearOldest: Boolean;
        OldLoans: Record Loans;
        TotalOutstanding: Decimal;
        RunningAmount: Decimal;
        LoanInterest: Decimal;
        SameLoan: Record Loans;
        TotalApplied: Decimal;
        TopUpResponse: Text;
        CanTopAp: Boolean;
        ExciseDuty: Decimal;
        ExciseDutyGL: Code[30];
        QualAmt: Decimal;
        Remark: Text;
        TotalTopUp: Decimal;
        IntDue: Decimal;
        ProcessingFee: Decimal;
        InsuranceAmount: Decimal;
        Charges: Record "Charges.";
        TopComm: Decimal;
        SelfPresent: Boolean;
        ChargedValue: Decimal;
        Customer: Record Members;
        PChAmt: Decimal;
        GL: Code[20];
        EDuty: Decimal;
        MemberActivities: Codeunit "Member Activities";
        SaccoActivities: Codeunit "Sacco Activities";
        ActLoans: Record Loans;
        TotArrears: Decimal;
        BankAccountComm: Code[20];
        SaccoSetup: Record "Sacco Setup";
        LoanSecurity: Record "Loan Security";
    begin

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

                    if Customer."Block Mobile Loan" then begin

                        Remark := 'You have been blocked from accessing this loan. Kindly Contact the SACCO';
                        msg := 'Dear ' + FirstName(SavAcc.name) + ', Your ' + LoanProduct."USSD Product Name" + ' request of KES ' + Format(MobileLoan.Amount) + 'has failed. ' + Remark;
                        MobileLoan.Remarks := Remark;
                        MobileLoan.Status := MobileLoan.Status::Failed;
                        MobileLoan.Posted := true;
                        MobileLoan."Date Posted" := CurrentDatetime;
                        MobileLoan.Remark := msg;
                        SendSms(Source::SkyMobile, MobileLoan."Telephone No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                        MobileLoan.Modify;
                        Continue := false;
                        Stop := true;
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



                if CheckLoanBlackList(SavAcc."ID No.") then begin
                    Remark := 'You do not Qualify for this loan. Kindly Contact the SACCO';
                    msg := 'Dear ' + FirstName(SavAcc.name) + ', Your ' + LoanProduct."USSD Product Name" + ' request of KES ' + Format(MobileLoan.Amount) + 'has failed. ' + Remark;
                    MobileLoan.Remarks := Remark;
                    MobileLoan.Status := MobileLoan.Status::Failed;
                    MobileLoan.Posted := true;
                    MobileLoan."Date Posted" := CurrentDatetime;
                    MobileLoan.Remark := msg;
                    SendSms(Source::SkyMobile, MobileLoan."Telephone No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                    MobileLoan.Modify;
                    Continue := false;
                    Stop := true;
                end;



                if LoanProduct."Product ID" = 'L43' then
                    GetDividendLoanQualifiedAmount(SavAcc."No.", LoanProduct."Product ID", QualAmt, Remark)
                else
                    GetLoanQualifiedAmount(SavAcc."No.", LoanProduct."Product ID", QualAmt, Remark, RespCode);

                if Remark <> '' then begin
                    msg := 'Dear ' + FirstName(SavAcc.name) + ', Your ' + LoanProduct."USSD Product Name" + ' request of KES ' + Format(MobileLoan.Amount) + 'has failed. ' + Remark;
                    MobileLoan.Remarks := Remark;
                    MobileLoan.Status := MobileLoan.Status::Failed;
                    MobileLoan.Posted := true;
                    MobileLoan."Date Posted" := CurrentDatetime;
                    MobileLoan.Remark := msg;
                    SendSms(Source::SkyMobile, MobileLoan."Telephone No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                    MobileLoan.Modify;
                    Continue := false;
                    Stop := true;
                end;



                if Continue then begin
                    if MobileLoan."Requested Amount" > QualAmt then begin
                        msg := 'Your ' + LoanProduct."USSD Product Name" + ' request has failed, You only qualify for KES ' + Format(QualAmt);
                        MobileLoan.Remarks := 'Member Qualifies for KES ' + Format(QualAmt) + ' only';
                        MobileLoan.Status := MobileLoan.Status::Failed;
                        MobileLoan.Posted := true;
                        MobileLoan."Date Posted" := CurrentDatetime;
                        MobileLoan.Remark := msg;
                        SendSms(Source::SkyMobile, MobileLoan."Telephone No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                        MobileLoan.Modify;
                        Continue := false;
                        Stop := true;
                    end;
                end;

                if Continue then begin
                    if LoanProduct."Product ID" <> 'L43' then
                        IF (Members."Member Status" <> Members."Member Status"::" ") and (Members."Member Status" <> Members."Member Status"::Active) THEN BEGIN

                            msg := 'You Member Account is not active';
                            MobileLoan.Remarks := 'You Member Account is not active';
                            MobileLoan.Status := MobileLoan.Status::Failed;
                            MobileLoan.Posted := true;
                            MobileLoan."Date Posted" := CurrentDatetime;
                            MobileLoan.Remark := msg;
                            SendSms(Source::SkyMobile, MobileLoan."Telephone No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                            MobileLoan.Modify;
                            Continue := false;
                            Stop := true;
                        end;
                end;

                /*
                if Continue then begin
                    if BenefitConfirmed(LoanProduct."Product ID", MobileLoan."Requested Amount", MobileLoan."Account No", QualAmt) <> 'SUCCESS' then begin
                        msg := 'Your ' + LoanProduct."USSD Product Name" + ' request has failed, Insufficient Amount to Top Up Existing Loan.';
                        MobileLoan.Remarks := 'Insufficient Amount to Top Up Existing Loan';
                        MobileLoan.Status := MobileLoan.Status::Failed;
                        MobileLoan.Posted := true;
                        MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                        MobileLoan.Remark := msg;
                        SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                        MobileLoan.Modify;
                        Continue := false;
                    end;
                end;
                */


                /*
                if Continue then begin

                    CanTopAp := GetLoansToTopUp(MobileLoan."Account No", MobileLoan."Loan Product Type", QualAmt);    //here
                    if CanTopAp = false then begin
                        msg := 'Your ' + LoanProduct."USSD Product Name" + ' request has failed, Insufficient Amount to Top Up Existing Loan.';
                        MobileLoan.Remarks := 'Insufficient Amount to Top Up Existing Loan';
                        MobileLoan.Status := MobileLoan.Status::Failed;
                        MobileLoan.Posted := true;
                        MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                        MobileLoan.Remark := msg;
                        SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                        MobileLoan.Modify;
                        Continue := false;
                    end;
                end;
                */

                MaxLoan := QualAmt;

                begin
                    if Continue then begin
                        /*
                        if (Members."Member Status" <> Members."Member Status"::Active) and (Members."Member Status" <> Members."Member Status"::" ") then begin
                            msg := 'Your ' + LoanProduct."USSD Product Name" + ' request has failed, Your BOSA Account is not Active.';
                            MobileLoan.Remarks := 'BOSA Account is not Active';
                            MobileLoan.Status := MobileLoan.Status::Failed;
                            MobileLoan.Posted := true;
                            MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                            MobileLoan.Remark := msg;
                            SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                            MobileLoan.Modify;
                            Continue := false;
                        end;
                        */
                    end;



                    if Continue then begin
                        if SavAcc.Status <> SavAcc.Status::Active then begin

                            msg := 'Your ' + LoanProduct."USSD Product Name" + ' request has failed, Your FOSA account is not Active.';
                            MobileLoan.Remarks := 'FOSA Account is not Active';
                            MobileLoan.Status := MobileLoan.Status::Failed;
                            MobileLoan.Posted := true;
                            MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                            MobileLoan.Remark := msg;
                            SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                            MobileLoan.Modify;
                            Continue := false;
                            Stop := true;
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
                        SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                        MobileLoan.Modify;
                        Continue := false;
                        Stop := true;
                        //message(FORMAT(mAXLOAN));
                    end;
                end;


                if Continue then begin

                    JTemplate := 'GENERAL';
                    JBatch := 'MBANKING';

                    GenJournalBatch.Reset;
                    GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                    GenJournalBatch.SetRange(Name, JBatch);
                    if not GenJournalBatch.FindFirst then begin
                        GenJournalBatch.Init;
                        GenJournalBatch."Journal Template Name" := JTemplate;
                        GenJournalBatch.Name := JBatch;
                        GenJournalBatch.Description := 'Mbanking Batch';
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
                        ////CoopSetup.SetRange("Transaction Type", CoopSetup."Transaction Type"::"Loan Disbursement");
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
                            ////ERROR('Setup Missing for %1', CoopSetup."Transaction Type"::"Loan Disbursement");
                            Stop := true;
                        END;
                    end;


                    if MobileLoan.Channel = MobileLoan.Channel::SpotCash then begin

                        SpotSetup.RESET;
                        SpotSetup.SETRANGE("Transaction Type", SpotSetup."Transaction Type"::"Loan Disbursement");
                        IF SpotSetup.FINDFIRST THEN BEGIN

                            SMSAccount := SpotSetup."SMS Account";
                            SMSCharge := SpotSetup."SMS Charge";


                            SaccoAccount := SpotSetup."Sacco Fee Account";
                            SaccoFee := SpotSetup."Sacco Fee";

                            VendorAccount := SpotSetup."Bank Account";
                            VendorCommission := SpotSetup."Vendor Commission";
                            VendorBalAcc := SpotSetup."Non-Member Debit Account";

                            TotalCharge := SaccoFee + VendorCommission + SMSCharge;
                            ExciseDuty := 0;//ROUND((SaccoFee)*ExciseDutyRate/100);
                        END
                        ELSE BEGIN
                            //ERROR('Setup Missing for %1', CoopSetup."Transaction Type"::"Loan Disbursement");
                            Stop := true;
                        END;
                    end;




                    Member.Get(SavAcc."Member No.");

                    if MobileLoan.Period = 0 then
                        MobileLoan.Period := 1;

                    Loans.Init;
                    Loans."Loan No." := '';
                    Loans.Source := LoanProduct."Loan Source";
                    Loans."Application Date" := Today;
                    Loans."Loan Product Type" := LoanProduct."Product ID";
                    Loans."Loan Product Type Name" := LoanProduct.Description;
                    Loans.Validate("Member No.", Member."No.");
                    Loans."Disbursement Account No" := SavAcc."No.";
                    Loans."Member Name" := Member.Name;
                    Loans."Requested Amount" := MobileLoan."Requested Amount";
                    Loans."Approved Amount" := MobileLoan."Requested Amount";
                    Loans.Status := Loans."status"::Approved;
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



                    Loans."Repay Mode" := LoanProduct."Repay Mode";



                    Loans."Staff No" := Members."Payroll/Staff No.";//SavAcc."Staff No" ;
                    Loans."Global Dimension 1 Code" := Members."Global Dimension 1 Code";
                    Loans."Booking Branch" := Members."Global Dimension 2 Code";
                    Loans."Employer Code" := Members."Employer Code";
                    Loans."ID NO." := Members."ID No.";

                    Loans.Posted := false;
                    Loans."Disbursement Date" := Today;
                    Loans."Repayment Start Date" := CalcDate('1M', Loans."Disbursement Date");

                    Loans."Completion Date" := CalcDate(Format(Loans.Installments) + 'M', Loans."Disbursement Date");



                    FosaAcc.get(Loans."Disbursement Account No");
                    if FosaAcc."Salary Processing" then
                        Loans."Repay Mode" := Loans."Repay Mode"::Cash;

                    //Loans.GetTSCcodes;
                    Loans.Insert(true);
                    LoanNo := Loans."Loan No.";
                    MobileLoan."Loan No." := LoanNo;

                    SActivities.GenerateRepaymentSchedule(Loans);
                    RepAmt := Loans.Repayment;

                    RunningAmount := 0;
                    Loans.Reset;
                    Loans.SetRange("Loan No.", LoanNo);
                    Loans.SetRange("Loan Product Type", MobileLoan."Loan Product Type");
                    if Loans.FindFirst then begin

                        Loans."Loan Account" := SActivities.CreateCreditAccount(Loans);
                        //UpfrontInterest := Loans."Loan Interest Repayment";
                        DocNo := MobileLoan.DocumentNo; //Loans."Loan No.";
                        PDate := Today;

                        Dim1 := Loans."Global Dimension 1 Code";
                        Dim2 := Loans."Booking Branch";

                        AccNo := Loans."Disbursement Account No";
                        AccNo := Loans."Disbursement Account No";
                        ExtDoc := Loans."Loan No.";
                        LoanNo := Loans."Loan No.";
                        TransType := Transtype::"Loan Disbursement";
                        SystCreated := true;

                        RunningAmount := Loans."Approved Amount";
                        SaccoTrans.JournalInit(JTemplate, JBatch);

                        GenSetup.Get;
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(LoanProduct.Description + ' Disbursement', 1, 50), Balacctype::"G/L Account",
                                      '', Loans."Approved Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(LoanProduct.Description + ' Disbursement', 1, 50), Balacctype::"G/L Account",
                                      '', -Loans."Approved Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                        ExciseDuty := ROUND(((GenSetup."Excise Duty (%)" / 100) * SaccoFee), 1, '>');
                        ExciseDutyGL := GenSetup."Excise Duty GL";

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(LoanProduct.Description + ' Fee', 1, 50), Balacctype::"G/L Account",
                                      '', VendorCommission + SaccoFee + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty ' + LoanProduct.Description, 1, 50), Balacctype::"G/L Account",
                                      '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());


                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"G/L Account",LoanProduct."Loan Interest Account",COPYSTR(LoanProduct.Description+' Commission',1,50),BalAccType::"G/L Account",
                        //            '',-UpfrontInterest,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,Loans."Member Name");
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SaccoAccount, CopyStr(LoanProduct.Description + ' Fee', 1, 50), Balacctype::"G/L Account",
                                      '', -SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());



                        AccNo := VendorAccount;
                        ExtDoc := Loans."Disbursement Account No";
                        LoanNo := '';
                        TransType := Transtype::" ";
                        if MobileLoan.Channel = MobileLoan.Channel::SpotCash then begin
                            AcctType := Accttype::"Bank Account";
                        end else begin
                            AcctType := Accttype::Vendor;
                        end;
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype, VendorAccount, CopyStr(LoanProduct.Description + ' Disbursement Commission', 1, 50), Balacctype::"G/L Account",
                                      '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                        //RunningAmount -=  (Loans."Loan Interest Repayment"*MobileLoan.Period)+ TotalCharge+LoanProduct."CRB Product Type";
                        if MobileLoan."Loan Product Type" <> 'L43' then
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


                            /*if OldLoans.FindFirst then begin //to be uncommented later when needed
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
                                        ExtDoc := OldLoans."Loan No.";
                                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, OldLoans."Loan Account", CopyStr(LoanProduct.Description + ' Interest top up', 1, 50), Balacctype::"G/L Account",
                                                  '', OldLoans."Outstanding Interest", ExtDoc, LoanNo, Transtype::"Interest Due", Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                                        ExtDoc := '';

                                    end;
                                    //Interest top up clearance
                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, OldLoans."Loan Account", CopyStr(LoanProduct.Description + ' Interest top up', 1, 50), Balacctype::"G/L Account",
                                                  '', -OldLoans."Outstanding Interest", ExtDoc, LoanNo, Transtype::"Interest Paid", Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                                    //Principle top up clearance
                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, OldLoans."Loan Account", CopyStr(LoanProduct.Description + ' Principle top up', 1, 50), Balacctype::"G/L Account",
                                                  '', -OldLoans."Outstanding Principal", ExtDoc, LoanNo, Transtype::"Principal Repayment", Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());


                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(LoanProduct.Description + ' Top Up', 1, 50), Balacctype::"G/L Account",
                                              '', TotalOutstanding, ExtDoc, LoanNo, Transtype::" ", Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                                until OldLoans.Next = 0;


                            end; */
                        end;

                        IntDue := ROUND((Loans."Approved Amount" - TotalTopUp) * (Loans."Annual Interest %" / 1200), 1, '>');
                        ExtDoc := OldLoans."Loan No.";
                        if LoanProduct."Charge Upfront Interest" then
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(LoanProduct.Description + ' Interest Due', 1, 50), Balacctype::"G/L Account",
                                      LoanProduct."Loan Interest Income [G/L]", IntDue, ExtDoc, Loans."Loan No.", Transtype::"Interest Due", Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());



                        if LoanProduct."Interest Recovered Upfront" then begin


                            if not LoanProduct."Charge Upfront Interest" then
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(LoanProduct.Description + ' Interest Due', 1, 50), Balacctype::"G/L Account",
                                      LoanProduct."Loan Interest Income [G/L]", IntDue, ExtDoc, Loans."Loan No.", Transtype::"Interest Due", Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                            ExtDoc := '';
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(LoanProduct.Description + ' Interest Paid', 1, 50), Balacctype::"G/L Account",
                                      '', -IntDue, ExtDoc, Loans."Loan No.", Transtype::"Interest Paid", Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, Loans."Disbursement Account No", CopyStr(LoanProduct.Description + ' Interest Paid', 1, 50), Balacctype::"G/L Account",
                                      '', IntDue, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                        end;

                        PCharges.Reset;
                        PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                        PCharges.SetFilter(PCharges."Charge Type", '%1|%2', PCharges."charge type"::General, PCharges."charge type"::Insurance);
                        if PCharges.Find('-') then begin
                            repeat
                                PCharges.TestField(PCharges."Account No.");

                                PChAmt := 0;
                                GL := '';
                                EDuty := 0;
                                MemberActivities.GetLoanChargeAmount(Loans."Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", Loans."Approved Amount", PChAmt, EDuty, GL);
                                ProcessingFee := PChAmt;


                                if ProcessingFee > 0 then begin
                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, Loans."Disbursement Account No", CopyStr(PCharges.Description, 1, 50), Balacctype::"G/L Account",
                                         GL, ProcessingFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, Loans."Disbursement Account No", CopyStr('Excise Duty', 1, 50), Balacctype::"G/L Account",
                                         ExciseDutyGL, EDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                                end;
                            until PCharges.Next = 0;
                        end;




                        Stop := false;
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


                        SaccoTrans.JournalPost(JTemplate, JBatch);
                        //clear Arrears
                        /*ActLoans.RESET;
                        ActLoans.SETRANGE("Member No.", Loans."Member No.");
                        ActLoans.SETFILTER("Loan Product Type", '<>%1&<>%2&<>%3', 'L43', 'L27', 'L29');
                        ActLoans.SETFILTER("Outstanding Principal", '>0');
                        IF ActLoans.FINDFIRST THEN BEGIN
                            repeat
                            //SaccoActivities.RecoverDefaultedLoanFromSavingsAccounts(ActLoans."Loan No.", ActLoans."Loan Product Type", True, false, ActLoans."Dimension Set ID");
                            until ActLoans.next = 0;
                        end;
                        */
                        RepAmt := Loans.Repayment;
                        Loans.CalcFields("Total Outstanding Balance");
                        if Loans.Installments = 1 then
                            RepAmt := Loans."Total Outstanding Balance";

                        if LoanProduct."Product ID" = 'L43' then
                            msg := 'Dear ' + FirstName(Loans."Member Name") +
                           ', your ' + LoanProduct."USSD Product Name" + ' of KES ' + Format(MobileLoan."Requested Amount")
                           + ' has been credited to your FOSA savings Account.'
                        else
                            msg := 'Dear ' + FirstName(Loans."Member Name") +
                            ', your ' + LoanProduct."USSD Product Name" + ' of KES ' + Format(MobileLoan."Requested Amount")
                            + ' has been credited to your FOSA savings Account. Expected repayment is Kshs ' + Format(RepAmt) + ' due on ' + ddMMyyyy(Loans."Repayment start Date")
                            + '. To repay Dial *470# and follow prompts.'; // + ddMMyyyy(Loans."Repayment Start Date");


                        SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);

                        //Insert Guarantorship
                        if LoanProduct."Guarantorship Option" = LoanProduct."Guarantorship Option"::"Self Guarantee" then begin
                            SavingsAccounts.reset;
                            SavingsAccounts.Setrange("Member no.", Loans."Member No.");
                            SavingsAccounts.Setrange("Product Category", SavingsAccounts."Product Category"::"Deposit Contribution");
                            if SavingsAccounts.FindFirst() then begin
                                LoanSecurity.InIt();
                                LoanSecurity."Loan No." := Loans."Loan No.";
                                LoanSecurity."Guarantor Type" := LoanSecurity."Guarantor Type"::Guarantor;
                                LoanSecurity.Validate("Account No.", SavingsAccounts."No.");
                                LoanSecurity."Amount Guaranteed" := Loans."Approved Amount";
                                LoanSecurity."Available Guarantorship" := Loans."Approved Amount";
                                LoanSecurity.Insert();
                            end

                        end;
                    end;
                end;
            end;
        end;

    end;



    procedure SendSms(Source: Code[200]; Telephone: Text[200]; Textsms: Text; Reference: Text[30]; AccNo: Text[30]; Chargeable: Boolean; Priority: Integer; ChargeMember: Boolean; EnteredBy: Code[50]) Inserted: Boolean
    var
        EntryNo: Integer;
        SkySMS: Record "Sky SMS";
        Category: Code[100];
        SMSLength: Integer;
        SMSLoop: Integer;
        CurrSMS: Text;
        NewSMS: Text;
        GeneralLedgerSetup: Record "General Ledger Setup";
        Date: Date;
        Time: Time;
        SchedDateTime: DateTime;
    begin
        Inserted := false;

        EntryNo := EntryNo + 1;


        if StrLen(Telephone) = 13 then begin
            Telephone := CopyStr(Telephone, 2, 12);
        end;

        if StrLen(Telephone) = 10 then begin
            if CopyStr(Telephone, 1, 1) = '0' then
                Telephone := '254' + CopyStr(Telephone, 2, 9);
        end;

        if StrLen(Telephone) = 9 then begin
            if CopyStr(Telephone, 1, 1) = '7' then
                Telephone := '254' + Telephone
        end;



        Category := Format(Source);
        Priority := GetSMSPriority(Category);
        if Priority = 0 then
            Priority := 250;




        Date := Dmy2date(9, 12, 2021);
        Time := 191500T;


        GeneralLedgerSetup.Get;

        GeneralLedgerSetup.TestField("SMS Sender ID");
        GeneralLedgerSetup.TestField("SMS Sender Name");

        Inserted := false;

        if StrLen(Telephone) = 12 then begin
            SkySMS.Init;
            SkySMS.originator_id := CreateGuid;
            SkySMS.msg_id := 0;
            SkySMS.msg_product_id := GeneralLedgerSetup."SMS Sender ID";
            SkySMS.msg_provider_code := '0';
            SkySMS.msg_charge := '';
            SkySMS.msg_status_code := 10;
            SkySMS.msg_status_description := 'New MSG';
            SkySMS.msg_status_date := CurrentDatetime;
            SkySMS.sender := GeneralLedgerSetup."SMS Sender Name";
            SkySMS.receiver := Telephone;
            SkySMS.msg := Textsms;
            SkySMS.msg_type := 'MT';
            SkySMS.msg_source_reference := '';
            SkySMS.msg_destination_reference := '';
            SkySMS.msg_xml_data := '<OTHER_DETAILS/>';
            SkySMS.msg_category := Category;
            SkySMS.msg_priority := Priority;
            SkySMS.msg_send_count := 0;
            SkySMS."Entered By" := EnteredBy;
            if Category = 'START_PIN' then begin
                SchedDateTime := CreateDatetime(Date, Time);
                SkySMS.schedule_msg := 'YES';
                SkySMS.date_scheduled := SchedDateTime;
            end
            else begin
                SkySMS.schedule_msg := 'NO';
                SkySMS.date_scheduled := CurrentDatetime;
            end;

            SkySMS.msg_send_integrity_hash := '';
            //SkySMS.msg_response_date:=CURRENTDATETIME;
            //SkySMS.msg_response_xml_data:='';
            //SkySMS.msg_response_integrity_hash:='';
            SkySMS.transaction_date := CurrentDatetime;
            SkySMS.date_created := CurrentDatetime;
            SkySMS."SMS Date" := Today;
            if Chargeable then
                SkySMS."Account To Charge" := AccNo;

            SkySMS.transaction_id := 0;
            SkySMS.server_id := 0;
            SkySMS.msg_charge_applied := '';
            SkySMS.msg_format := 'TEXT';
            SkySMS.msg_command := 'BulkSMS';
            SkySMS.msg_sensitivity := 'NORMAL';
            SkySMS.msg_response_description := '';
            SkySMS.msg_result_description := '';
            SkySMS.msg_result_xml_data := '';
            SkySMS.msg_result_date := CurrentDatetime;
            SkySMS.msg_result_integrity_hash := '';
            SkySMS.msg_result_submit_count := 0;
            SkySMS.msg_result_submit_status := 'PENDING';
            SkySMS.msg_result_submit_description := '';
            SkySMS.msg_result_submit_date := CurrentDatetime;
            SkySMS.sender_type := 'SENDER_ID';
            SkySMS.receiver_type := 'MSISDN';
            if Category = 'MPESA_DEPOSIT' then begin
                SkySMS.msg_mode := 'EXPRESS';
            end
            else begin
                SkySMS.msg_mode := 'SAF';
            end;
            if Source = 'MOBILE_PIN' then begin
                SkySMS.msg_general_flag := 'NOT_MASKED';
            end;
            SkySMS."Charge Member" := ChargeMember;

            if SkySMS.Insert then
                Inserted := true;
        end;
    end;


    procedure GetLoanGuarantors(TransactionID: Code[20]; LoanNo: Code[20]) Response: Text
    var
        MobileNo: Code[20];
        Loans: Record Loans;
        LoanProduct: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        MemberNo: Code[20];
        MaxLoan: Decimal;
        LoanGuarantors: Record "Loan Security";
        Members: Record Members;
    begin

        Response := '';

        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNo);
        if Loans.FindFirst then begin
            Loans.CalcFields("Outstanding Principal");
            CheckDate := Today;
            RemInst := 0;
            while CheckDate < Loans."Completion Date" do begin
                RemInst += 1;
                CheckDate := CalcDate('1M', CheckDate);
            end;

            LoanGuarantors.Reset;
            LoanGuarantors.SetRange("Loan No.", Loans."Loan No.");
            LoanGuarantors.SetRange(Substituted, false);
            if LoanGuarantors.Find('-') then begin
                Response := '<Loan>';
                LGCount := LoanGuarantors.Count;
                if (LGCount = 0) then
                    LGCount := 1;
                repeat

                    Response += '<Security>';
                    Response += '<LoanNo>' + Loans."Loan No." + '</LoanNo>';
                    Response += '<Type>Guarantor</Type>';
                    Response += '<RemainingInstallment>' + Format(RemInst) + ' Month(s)</RemainingInstallment>';
                    Response += '<Name>' + LoanGuarantors.Name + '</Name>';
                    MobileNo := '';
                    if Members.Get(LoanGuarantors."Member No") then begin
                        MobileNo := Members."Phone No.";
                    end;
                    Response += '<MobileNo>' + MobileNo + '</MobileNo>';
                    Response += '<AmountGuaranteed>' + Format(ROUND(Loans."Approved Amount" / LGCount)) + '</AmountGuaranteed>';
                    Response += '<CurrentCommitment>' + Format(ROUND(Loans."Outstanding Principal" / LGCount)) + '</CurrentCommitment>';

                    Response += '</Security>';

                until LoanGuarantors.Next = 0;
                Response += '</Loan>';
            end;
        end
        else begin
            Response := '<Response>';
            Response += '<Status>LOAN_NOT_FOUND</Status>';
            Response += '<StatusDescription>Member Loan not found</StatusDescription>';
            Response += '<Reference>' + TransactionID + '</Reference>';
            Response += '</Response>';
        end;
    end;


    procedure GetLoansGuaranteed(TransactionID: Code[20]; Phone: Code[20]) Response: Text
    var
        MobileNo: Code[20];
        Loans: Record Loans;
        LoanProduct: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        MemberNo: Code[20];
        MaxLoan: Decimal;
        LoanGuarantors: Record "Loan Security";
        Members: Record Members;
        DefAmt: Decimal;
    begin
        MobileNo := '+' + Phone;

        Response := '';

        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", MobileNo);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin
            MemberNo := SavAcc."Member No.";

            LoanGuarantors.Reset;
            LoanGuarantors.SetRange("Member No", MemberNo);
            LoanGuarantors.SetFilter("Outstanding Principal", '>0');
            if LoanGuarantors.Find('-') then begin
                Response := '<Security>';
                CheckDate := Today;
                RemInst := 0;
                /*WHILE CheckDate < Loans."Completion Date" DO BEGIN
                    RemInst+=1;
                    CheckDate:=CALCDATE('1M',CheckDate);
                END;*/
                LGCount := LoanGuarantors.Count;
                if (LGCount = 0) then
                    LGCount := 1;
                repeat
                    if Loans.Get(LoanGuarantors."Loan No.") then begin

                        Loans.CalcFields("Outstanding Principal");
                        if Loans."Outstanding Principal" > 0 then begin
                            LoanProduct.Get(Loans."Loan Product Type");
                            DefAmt := 0;
                            if LoanProduct."USSD Product Name" = '' then
                                LoanProduct."USSD Product Name" := LoanProduct.Description;

                            Response += '<Loan>';
                            Response += '<Loanee>' + Loans."Member Name" + '</Loanee>';
                            Response += '<LoanNo>' + Loans."Loan No." + '</LoanNo>';
                            Response += '<LoanType>' + LoanProduct."USSD Product Name" + '</LoanType>';
                            //Response += '<RemainingInstallment>'+FORMAT(Loans."Completion Date")+'</RemainingInstallment>';
                            MobileNo := '';
                            if Members.Get(LoanGuarantors."Member No") then begin
                                MobileNo := Members."Phone No.";
                            end;
                            Response += '<MobileNo>' + MobileNo + '</MobileNo>';
                            Response += '<GuarantorType>' + 'Guarantor' + '</GuarantorType>';
                            Response += '<IssuedDate>' + Format(Loans."Disbursement Date") + '</IssuedDate>';
                            Response += '<EndDate>' + Format(Loans."Completion Date") + '</EndDate>';
                            Loans.CalcFields("Loans Category-SACCO", "Outstanding Principal");
                            if (Loans."Loans Category-SACCO" = Loans."Loans Category-SACCO"::Perfoming) or
                                (Loans."Loans Category-SACCO" = Loans."Loans Category-SACCO"::Watch) then
                                Response += '<Status>Performing</Status>'
                            else
                                Response += '<Status>Defaulter</Status>';
                            Response += '<LoanAmount>' + Format(Loans."Approved Amount") + '</LoanAmount>';
                            Response += '<Installments>' + Format(Loans.Installments) + '</Installments>';
                            Response += '<LoanBalance>' + Format(Loans."Outstanding Principal") + '</LoanBalance>';
                            Response += '<DefaultedAmount>' + Format(Loans."Outstanding Principal") + '</DefaultedAmount>';

                            Response += '<AmountGuaranteed>' + Format(ROUND(Loans."Approved Amount" / LGCount)) + '</AmountGuaranteed>';
                            Response += '<CurrentCommitment>' + Format(ROUND(Loans."Outstanding Principal" / LGCount)) + '</CurrentCommitment>';

                            Response += '</Loan>';
                        end;
                    end;

                until LoanGuarantors.Next = 0;
                Response += '</Security>';

            end;

        end
        else begin
            Response := '<Response>';
            Response += '<Status>ACC_NOT_FOUND</Status>';
            Response += '<StatusDescription>Member Account not found</StatusDescription>';
            Response += '<Reference>' + TransactionID + '</Reference>';
            Response += '</Response>';
        end;

    end;


    procedure GetMemberLoanList(Phone: Code[20]) Response: Text
    var
        MobileNo: Code[20];
        Loans: Record Loans;
        LoanProduct: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        MemberNo: Code[20];
        MaxLoan: Decimal;
        Found: Boolean;
        LoanBal: Decimal;
        IDNo: Code[20];
    begin

        MobileNo := '+' + Phone;


        Response := '';
        Found := false;

        /*
        SavAcc.RESET;
        SavAcc.SETRANGE("Transactional Mobile No",MobileNo);
        SavAcc.SETFILTER(Status,'<>%1',SavAcc.Status::Deceased);
        IF SavAcc.FINDFIRST THEN BEGIN
        
            MemberNo := SavAcc."Member No.";
            IDNo := SavAcc."ID No.";
            LoanProduct.RESET;
            IF LoanProduct.FIND('-') THEN BEGIN
                Response:='<Loans>';
                REPEAT
                    IF LoanProduct."USSD Product Name" = '' THEN
                      LoanProduct."USSD Product Name" := LoanProduct.Description;
        
                    Members.RESET;
                    Members.SETRANGE("ID No.",IDNo);
                    Members.SETFILTER("Customer Type",'%1|%2',Members."Customer Type"::Member,Members."Customer Type"::MicroFinance);
                    IF Members.FIND('-') THEN BEGIN
                        REPEAT
                            MemberNo := Members."No.";
                            Loans.RESET;
                            Loans.SETRANGE("Member No.",MemberNo);
                            Loans.SETRANGE("Loan Product Type",LoanProduct."Product ID");
                            Loans.SETFILTER("Outstanding Principal",'>0');
                            IF Loans.FINDFIRST THEN BEGIN
                                Found:=TRUE;
                                REPEAT
                                    Loans.CALCFIELDS("Outstanding Principal","Outstanding Interest");
                                    IF Loans."Outstanding Interest" <= 0 THEN
                                        Loans."Outstanding Interest" := GetClearingLoanInterest(Loans);
        
                                    LoanBal := Loans."Outstanding Principal"+Loans."Outstanding Interest";
                                    Response += '<Product>';
                                      Response += '<LoanNo>'+Loans."Loan No."+'</LoanNo>';
                                      Response += '<ProductType>'+LoanProduct."USSD Product Name"+' - Loan Bal: '+FORMAT(FORMAT(LoanBal))+'</ProductType>';
                                      //Response += '<LoanBalance>'+FORMAT(LoanBal)+'</LoanBalance>';
                                    Response += '</Product>';
                                UNTIL Loans.NEXT=0;
                            END;
        
                        UNTIL Members.NEXT=0;
                    END;
        
                UNTIL LoanProduct.NEXT=0;
                Response+='</Loans>';
        
            END;
        
        END;
        */


        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", MobileNo);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin

            SavAcc.CalcFields("ID No.");
            MemberNo := SavAcc."Member No.";
            IDNo := SavAcc."ID No.";

            Response := '<Loans>';

            Members.Reset;
            Members.SetRange("ID No.", IDNo);
            if Members.Find('-') then begin
                repeat
                    MemberNo := Members."No.";
                    Loans.Reset;
                    Loans.SetRange("Member No.", MemberNo);
                    Loans.SetFilter("Outstanding Principal", '>0');
                    if Loans.FindFirst then begin
                        Found := true;
                        repeat
                            LoanProduct.Get(Loans."Loan Product Type");
                            Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
                            if LoanProduct."USSD Product Name" = '' then
                                LoanProduct."USSD Product Name" := LoanProduct.Description;


                            if Loans."Outstanding Interest" < 0 then
                                Loans."Outstanding Interest" := 0;

                            LoanBal := Loans."Outstanding Principal" + Loans."Outstanding Interest";
                            Response += '<Product>';
                            Response += '<LoanNo>' + Loans."Loan No." + '</LoanNo>';
                            Response += '<ProductType>' + LoanProduct.Description + ' - KES ' + Format(Format(LoanBal)) + '</ProductType>';
                            //Response += '<LoanBalance>'+FORMAT(LoanBal)+'</LoanBalance>';
                            Response += '</Product>';
                        until Loans.Next = 0;
                    end;

                until Members.Next = 0;
            end;

            Response += '</Loans>';

        end;


        if not Found then
            Response := '';

    end;


    procedure GetAccountTransferRecipient(Criteria: Code[20]; Source: Text; var BosaTransType: Option "None","Loan Repayment","Share Capital","Deposit Contribution","Deposit Contribution Micro","Retirement Saving Fund","Registration Fee","Insurance Contribution","FOSA SHARES") Response: Text
    var
        SavAcc: Record "Savings Accounts";
        PFact: Record "Product Setup";


        XMLDOMMgt: Codeunit "XML DOM Management";



        RecMemberNo: Code[20];
        LongCode: Code[20];
        AccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        MobileLoans: Record "Sky Mobile Loans";
        OutPut: Boolean;
        LNo: Code[20];
        "Key": Code[10];
        Members: Record Members;
        Loans: Record Loans;
        Pos: Integer;
    begin

        Response := '';


        if Source = 'Mobile' then begin

            if StrLen(Criteria) = 10 then
                if CopyStr(Criteria, 1, 1) = '0' then
                    Criteria := CopyStr(Criteria, 2, 9);

            SavAcc.Reset;
            SavAcc.SetFilter("Transactional Mobile No", '*' + Criteria);
            SavAcc.SetFilter(Blocked, '<>%1', SavAcc.Blocked::All);
            if SavAcc.FindFirst then begin
                Response := SavAcc."No.";
            end
            else begin

                SavAcc.Reset;
                SavAcc.SetFilter("Phone No.", '*%1', '*' + Criteria);
                SavAcc.SetFilter(Blocked, '<>%1', SavAcc.Blocked::All);
                SavAcc.SetRange("Product Type", 'SAVINGS');
                if SavAcc.FindFirst then begin
                    Response := SavAcc."No.";
                end;
            end
        end
        else
            if Source = 'ID' then begin
                SavAcc.Reset;
                SavAcc.SetRange("ID No.", Criteria);
                SavAcc.SetFilter(Blocked, '<>%1', SavAcc.Blocked::All);
                SavAcc.SetFilter("Product Type", 'SAVINGS|GSAVINGS');
                if SavAcc.FindFirst then begin
                    Response := SavAcc."No.";
                end
            end
            else
                if Source = 'ACCOUNT' then begin
                    Pos := StrPos(Criteria, '#');
                    if Pos > 1 then begin
                        Criteria := CopyStr(Criteria, 1, Pos - 1);
                    end;

                    SavAcc.Reset;
                    SavAcc.SetRange("No.", Criteria);
                    if SavAcc.FindFirst then begin
                        Response := SavAcc."No.";
                    end
                    else begin

                        LongCode := AccountPrefix + Criteria + AccountSuffix;
                        SavAcc.Reset;
                        SavAcc.SetRange("No.", LongCode);
                        if SavAcc.FindFirst then begin
                            Response := SavAcc."No.";
                        end
                        else begin
                            AccNo := '';
                            GetAccountFromKeyWord(Criteria, AccNo, LoanAccount, DepositAccount, IDNo, MNo, BosaTransType, Key, LNo);
                            if LoanAccount then begin
                                Members.Get(MNo);
                                Loans.Get(LNo);
                                AccNo := LNo;

                            end
                            else
                                if DepositAccount then begin
                                    Members.Get(MNo);
                                    AccNo := MNo;
                                end;

                        end;


                    end;

                end
        //Response:='';
    end;


    procedure GetCurrentUSSDPIN("MobileNo.": Code[30]) CurrentUSSDPIN: Text
    var
        SkyworldUSSDAuth: Record "Sky USSD Auth";
    begin
        "MobileNo." := '+' + "MobileNo.";

        CurrentUSSDPIN := '';

        SkyworldUSSDAuth.Reset;
        SkyworldUSSDAuth.SetRange(SkyworldUSSDAuth."Mobile No.", "MobileNo.");
        if SkyworldUSSDAuth.FindFirst then begin
            CurrentUSSDPIN := SkyworldUSSDAuth."PIN No.";
        end;
    end;


    procedure UpdateCurrentUSSDPIN("MobileNo.": Code[30]; "NewPINNo.": Text) USSDPINUpdated: Boolean
    var
        SkyworldUSSDAuth: Record "Sky USSD Auth";
    begin
        "MobileNo." := '+' + "MobileNo.";
        USSDPINUpdated := false;

        SkyworldUSSDAuth.Reset;
        SkyworldUSSDAuth.SetRange(SkyworldUSSDAuth."Mobile No.", "MobileNo.");
        if SkyworldUSSDAuth.FindFirst then begin
            SkyworldUSSDAuth."PIN No." := "NewPINNo.";
            SkyworldUSSDAuth."Force PIN" := false;
            SkyworldUSSDAuth."Initial PIN Sent" := false;
            SkyworldUSSDAuth."Reset PIN" := false;
            SkyworldUSSDAuth.Modify;
            USSDPINUpdated := true;
        end;
    end;


    procedure CheckKYCByAccountNo(PhoneNo: Text[30]; AccountNo: Code[20]) KYCValid: Boolean
    var
        SavAcc: Record "Savings Accounts";
    begin
        PhoneNo := '+' + PhoneNo;

        KYCValid := false;

        SavAcc.Reset;
        SavAcc.SetRange("No.", AccountNo);
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        SavAcc.SetRange(Blocked, SavAcc.Blocked::" ");
        if SavAcc.FindFirst then begin
            KYCValid := true;
        end
    end;


    procedure GetMemberYOB(PhoneNo: Text[30]) Name: Text
    var
        SavAcc: Record "Savings Accounts";
        SkyworldUSSDAuth: Record "Sky USSD Auth";
        Members: Record Members;
    begin
        PhoneNo := '+' + PhoneNo;

        Name := '';
        SavAcc.Reset;
        SavAcc.SetRange(SavAcc."Transactional Mobile No", PhoneNo);
        if SavAcc.FindFirst then begin
            Members.Reset;
            Members.SetRange(Members."No.", SavAcc."Member No.");
            if Members.FindFirst then begin
                Name := Format(Members."Date of Birth", 0, 9);
            end;
        end;
    end;


    procedure GetMemberName(PhoneNo: Text[30]) Name: Text
    var
        SavAcc: Record "Savings Accounts";
        SkyworldUSSDAuth: Record "Sky USSD Auth";
    begin
        PhoneNo := '+' + PhoneNo;

        Name := '';
        SavAcc.Reset;
        SavAcc.SetRange(SavAcc."Transactional Mobile No", PhoneNo);
        if SavAcc.FindFirst then begin
            Name := SavAcc.Name;
        end;
    end;


    procedure ActiveMobileMember(PhoneNo: Text[30]) AccNo: Text
    var
        SavAcc: Record "Savings Accounts";
        SkyworldUSSDAuth: Record "Sky USSD Auth";
    begin
        PhoneNo := '+' + PhoneNo;

        AccNo := '';
        SkyworldUSSDAuth.Reset;
        SkyworldUSSDAuth.SetRange(SkyworldUSSDAuth."Mobile No.", PhoneNo);
        SkyworldUSSDAuth.SetRange("User Status", SkyworldUSSDAuth."user status"::Active);
        if SkyworldUSSDAuth.FindFirst then begin
            AccNo := SkyworldUSSDAuth."Account No.";
        end;
    end;


    procedure CheckKYCByNationalIDNo("PhoneNo.": Text[30]; "NationalIDNo.": Code[20]; CurrentPIN: Text) KYCValid: Boolean
    var
        SkyworldUSSDAuth: Record "Sky USSD Auth";
        SavAcc: Record "Savings Accounts";
    begin
        "PhoneNo." := '+' + "PhoneNo.";

        KYCValid := false;

        SavAcc.Reset;
        SavAcc.SetRange(SavAcc."ID No.", "NationalIDNo.");
        SavAcc.SetRange("Transactional Mobile No", "PhoneNo.");
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        SavAcc.SetRange(SavAcc.Blocked, SavAcc.Blocked::" ");
        if SavAcc.FindFirst then begin
            SkyworldUSSDAuth.Reset;
            SkyworldUSSDAuth.SetRange(SkyworldUSSDAuth."Mobile No.", "PhoneNo.");
            SkyworldUSSDAuth.SetRange(SkyworldUSSDAuth."PIN No.", CurrentPIN);
            if SkyworldUSSDAuth.FindFirst then
                KYCValid := true;
        end
    end;


    procedure CheckForcePin(Phone: Text) ForcePin: Boolean
    var
        PinAuth: Record "Sky USSD Auth";
    begin
        Phone := '+' + Phone;
        ForcePin := false;

        PinAuth.Reset;
        PinAuth.SetRange(PinAuth."Mobile No.", Phone);
        PinAuth.SetRange(PinAuth."Force PIN", true);
        PinAuth.SetRange(PinAuth."Reset PIN", false);
        if PinAuth.FindFirst then begin
            ForcePin := true;
        end;
    end;


    procedure GetUnsetPin() Phone: Text
    var
        PinAuth: Record "Sky USSD Auth";
    begin
        Phone := '';

        PinAuth.Reset;
        PinAuth.SetRange(PinAuth."Reset PIN", true);
        PinAuth.SetRange(PinAuth."Force PIN", false);
        if PinAuth.FindFirst then begin
            Phone := PinAuth."Mobile No.";
            exit(Phone);

        end;
    end;


    procedure GetForcePin() Phone: Text
    var
        PinAuth: Record "Sky USSD Auth";
    begin
        Phone := '';

        PinAuth.Reset;
        PinAuth.SetRange(PinAuth."Reset PIN", true);
        PinAuth.SetRange(PinAuth."Force PIN", true);
        if PinAuth.FindFirst then begin
            Phone := PinAuth."Mobile No.";
            exit(Phone);
        end;
    end;


    procedure SetNewPin(PhoneNo: Text; OldPin: Text; NewPin: Text) Response: Text
    var
        SkyworldUSSDAuth: Record "Sky USSD Auth";
    begin
        PhoneNo := '+' + PhoneNo;

        Response := 'ERROR';

        SkyworldUSSDAuth.Reset;
        SkyworldUSSDAuth.SetRange("Mobile No.", PhoneNo);
        if SkyworldUSSDAuth.FindFirst then begin
            if SkyworldUSSDAuth."PIN No." = OldPin then begin
                if NewPin = '' then begin
                    Response := 'INVALID_NEW_PIN';
                end
                else begin
                    SkyworldUSSDAuth."PIN No." := NewPin;
                    SkyworldUSSDAuth.Modify;
                    Commit;
                    Response := 'SUCCESS';
                end;
            end
            else begin
                Response := 'INCORRECT_PIN';
            end;
        end
        else begin
            Response := 'INVALID_ACCOUNT';
        end;
    end;


    procedure SetForcePin(PhoneNo: Text; PIN: Text) Response: Boolean
    var
        SkyworldUSSDAuth: Record "Sky USSD Auth";
    begin
        PhoneNo := '+' + PhoneNo;

        Response := false;

        SkyworldUSSDAuth.Reset;
        SkyworldUSSDAuth.SetRange(SkyworldUSSDAuth."Mobile No.", PhoneNo);
        if SkyworldUSSDAuth.FindFirst then begin
            SkyworldUSSDAuth."PIN No." := PIN;
            SkyworldUSSDAuth."Reset PIN" := false;
            SkyworldUSSDAuth."Force PIN" := true;
            if SkyworldUSSDAuth.Modify then
                Response := true;
        end;
    end;


    procedure GetPinStatus(PhoneNo: Text) Response: Boolean
    var
        SkyworldUSSDAuth: Record "Sky USSD Auth";
    begin
        PhoneNo := '+' + PhoneNo;

        Response := false;

        SkyworldUSSDAuth.Reset;
        SkyworldUSSDAuth.SetRange(SkyworldUSSDAuth."Mobile No.", PhoneNo);
        if SkyworldUSSDAuth.FindFirst then begin
            Response := SkyworldUSSDAuth."Reset PIN";
        end;
    end;


    procedure ResendCurrentPin() Pin: Text
    var
        SkyworldUSSDAuth: Record "Sky USSD Auth";
    begin

        Pin := '';

        SkyworldUSSDAuth.Reset;
        SkyworldUSSDAuth.SetRange(SkyworldUSSDAuth."Pin Sent", false);
        SkyworldUSSDAuth.SetFilter(SkyworldUSSDAuth."PIN No.", '<>%1', '');
        if SkyworldUSSDAuth.FindFirst then begin
            Pin := SkyworldUSSDAuth."Mobile No." + ':::' + SkyworldUSSDAuth."PIN No.";
            SkyworldUSSDAuth."Pin Sent" := true;
            SkyworldUSSDAuth.Modify;
        end;
    end;


    procedure AccountBalanceEnquiry(EntryCode: Text; TransactionID: Code[20]; PhoneNo: Code[20]; PIN: Text; AccType: Text) Response: Text[1024]
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        AccBal: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        MobileTrans: Record "Sky Transactions.";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        SLedger: Record "Savings Ledger Entry";
        LedgerCount: Integer;
        CurrRecord: Integer;
        DFilter: Text;
        DebitCreditFlag: Code[10];
        FirstEntry: Boolean;
        ProdFact: Record "Product Setup";
        AccountBookBalance: Decimal;
        AccountAvailableBalance: Decimal;
        AccountToCharge: Code[20];
        Found: Boolean;
        MemberNo: Code[20];
        TransactionDate: DateTime;
        Loans: Record Loans;
        LoanType: Text;
        BalStmt: Text;
        msg: Text;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomFee: Decimal;
        BalEnqCharge: Decimal;
        Members: Record Members;
        UseID: Boolean;
        LProduct: Record "Product Setup";
        IDNo: Code[20];
        i: Integer;
        Cust: Record Members;
    begin

        TransactionDate := CurrentDatetime;

        Response := 'ERROR';
        Found := false;


        PhoneNo := '+' + PhoneNo;

        if not CorrectPin(PhoneNo, PIN) then begin
            Response := 'INCORRECT_PIN';
            exit;
        end;


        AccountToCharge := '';
        MemberNo := '';
        IDNo := '';

        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        if SavAcc.FindFirst then begin
            SavAcc.CalcFields("ID No.");
            AccountToCharge := SavAcc."No.";
            MemberNo := SavAcc."Member No.";
            IDNo := SavAcc."ID No.";
            if SavAcc.Blocked <> SavAcc.Blocked::" " then
                exit;
        end;


        if (MemberNo = '') and (IDNo = '') then
            exit('Member No. Missing');

        if AccountToCharge = '' then
            exit('Account to charge missing');


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



        CoopSetup.Reset;
        //CoopSetup.SetRange("Transaction Type", CoopSetup."transaction type"::"Balance Enquiry");
        if CoopSetup.FindFirst then begin

            SMSAccount := CoopSetup."SMS Account";
            SMSCharge := CoopSetup."SMS Charge";


            SaccoAccount := CoopSetup."Sacco Fee Account";
            SaccoFee := CoopSetup."Sacco Fee";
            VendorAccount := CoopSetup."Vendor Commission Account";
            VendorCommission := CoopSetup."Vendor Commission";



            //error('1: %1',ExciseDutyRate);
            TotalCharge := SaccoFee + VendorCommission + SMSCharge;
            ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);


        end
        else begin
            //ERROR('Setup Missing for %1', CoopSetup."Transaction Type");
        end;



        if SavAcc.Get(AccountToCharge) then begin

            ProdFact.Get(SavAcc."Product Type");

            if (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::"Deposits Only") or
                (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::" ") then begin
                Error('The Account to Charge is not a Withdrawable Account');

            end;

            BalEnqCharge := 0;
            AccBal := GetAccountBalance(SavAcc."No.");
            SavAcc.CalcFields("Balance (LCY)");

            AccBal := SavAcc."Balance (LCY)";
            if (AccBal - (TotalCharge + ExciseDuty)) < 500 then
                AccBal := 0;

            if AccBal >= TotalCharge + ExciseDuty then begin
                BalEnqCharge := TotalCharge + ExciseDuty;
                //BUser.GET(USERID);

                //BUser.TESTFIELD("Cashier Journal Template");
                //BUser.TESTFIELD("Cashier Journal Batch");

                JTemplate := 'GENERAL';
                JBatch := 'MBANKING';

                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                GenJournalBatch.SetRange(Name, JBatch);
                if not GenJournalBatch.FindFirst then begin
                    GenJournalBatch.Init;
                    GenJournalBatch."Journal Template Name" := JTemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.Description := 'Mbanking Batch';
                    GenJournalBatch.Insert;
                end;


                MobileTrans.Init;
                MobileTrans."Entry No." := EntryCode;
                MobileTrans."Transaction ID" := TransactionID;
                MobileTrans."Session ID" := TransactionID;
                MobileTrans."Transaction Date" := Dt2Date(TransactionDate);
                MobileTrans."Transaction Time" := Dt2Time(TransactionDate);
                MobileTrans."Member Account" := SavAcc."No.";
                MobileTrans."Transaction Type" := MobileTrans."transaction type"::"Balance Enquiry";
                MobileTrans.Description := AccType + ' ' + Format(MobileTrans."Transaction Type");
                MobileTrans.Insert;


                MobileTrans.Reset;
                MobileTrans.SetRange("Transaction ID", TransactionID);
                MobileTrans.SetRange(Posted, false);
                if MobileTrans.FindFirst then begin

                    DocNo := MobileTrans."Transaction ID";
                    PDate := MobileTrans."Transaction Date";
                    AccNo := MobileTrans."Member Account";
                    ExtDoc := '';
                    LoanNo := '';
                    TransType := Transtype::" ";
                    Dim1 := SavAcc."Global Dimension 1 Code";
                    Dim2 := SavAcc."Global Dimension 2 Code";
                    SystCreated := true;

                    SaccoTrans.JournalInit(JTemplate, JBatch);

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(MobileTrans.Description, 1, 50), Balacctype::"G/L Account",
                                  '', VendorCommission + SaccoFee + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                    //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR(MobileTrans.Description,1,50),BalAccType::"G/L Account",
                    //            '',SaccoFee+ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccountToCharge, CopyStr('SMS Charges ', 1, 50), Balacctype::"G/L Account",
                                  SMSAccount, SMSCharge, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                    //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR('Excise Duty',1,50),BalAccType::"G/L Account",
                    //            ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty ' + Format(MobileTrans."Transaction Type"), 1, 50), Balacctype::"G/L Account",
                                  '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());


                    AccNo := VendorAccount;
                    ExtDoc := MobileTrans."Member Account";
                    LoanNo := '';
                    TransType := Transtype::" ";

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, AccNo, CopyStr(MobileTrans.Description + ' Commission', 1, 50), Balacctype::"G/L Account",
                                  '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                    AccNo := SaccoAccount;
                    ExtDoc := MobileTrans."Member Account";
                    LoanNo := '';
                    TransType := Transtype::" ";

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", AccNo, CopyStr(MobileTrans.Description + ' Fee', 1, 50), Balacctype::"G/L Account",
                                  '', -SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());


                    MobileTrans.Posted := true;
                    MobileTrans."Posted By" := UserId;
                    MobileTrans."Date Posted" := Today;
                    MobileTrans.Modify;

                    SaccoTrans.JournalPost(JTemplate, JBatch);

                end;

            end
            else begin
                Response := 'INSUFFICIENT_BAL';
            end;
        end
        else begin
            Response := 'INVALID_ACCOUNT';
        end;


        if (Response = 'ERROR') then begin

            if (AccType <> 'LOAN') then begin


                if (AccType <> 'LOAN') then begin
                    UseID := false;

                    if Members.Get(MemberNo) then
                        IDNo := Members."ID No.";



                    //if IDNo = '' then
                    //  Error('ID No. not found');

                    SavAcc.Reset;
                    //SavAcc.SetFilter(Balance, '>0');
                    SavAcc.SetRange("Member No.", MemberNo);
                    SavAcc.SetFilter("Product Category", '<>%1', SavAcc."Product Category"::"Registration Fee");
                    if SavAcc.Find('-') then begin
                        msg := 'Account Balances: ';
                        i := 0;
                        repeat
                            i += 1;
                            // message('1');
                            ProdFact.Get(SavAcc."Product Type");
                            SavAcc.CalcFields("Balance (LCY)");



                            AccountBookBalance := SavAcc."Balance (LCY)";
                            AccountAvailableBalance := GetAccountBalance(SavAcc."No.");


                            //if SavAcc."Mbanking Registered" then begin

                            SMSCharge := 0;

                            CoopSetup.Reset;
                            //CoopSetup.SetRange("Transaction Type", CoopSetup."transaction type"::"Mpesa Withdrawal");
                            if CoopSetup.FindFirst then begin

                                SMSCharge := CoopSetup."SMS Charge";

                                /*
                                SafcomCharges.RESET;
                                SafcomCharges.SETFILTER(Charge,'>0');
                                SafcomCharges.SETFILTER(Minimum,'<=%1',AccountAvailableBalance);
                                SafcomCharges.SETFILTER(Maximum,'>=%1',AccountAvailableBalance);
                                IF SafcomCharges.FINDFIRST THEN BEGIN
                                    SafcomFee:=SafcomCharges.Charge;
                                END;
                                */

                                SafcomFee := 0;
                                if CoopSetup."Safcom Staggered Fee" then
                                    SafcomFee := GetStaggeredSaccoFee(CoopSetup."Safcom Staggered Charge", AccountAvailableBalance);

                                SaccoFee := CoopSetup."Sacco Fee";
                                if CoopSetup."Sacco Staggered Fee" then
                                    SaccoFee := GetStaggeredSaccoFee(CoopSetup."Sacco Staggered Charge", AccountAvailableBalance);

                                VendorCommission := CoopSetup."Vendor Commission";
                                TotalCharge := SaccoFee + VendorCommission + SafcomFee + SMSCharge;
                                ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);


                                if (AccountAvailableBalance - (TotalCharge + ExciseDuty)) < 0 then
                                    AccountAvailableBalance := 0
                                else begin

                                    AccountAvailableBalance -= (TotalCharge + ExciseDuty);
                                end;
                            end;
                            //end;

                            if ProdFact."USSD Product Name" = '' then
                                ProdFact."USSD Product Name" := ProdFact.Description;


                            BalStmt := NewLine + format(i) + '. ' + SavAcc."No." + ' : ' + Newline + '  Book Bal: ' + FORMAT(AccountBookBalance) + Newline + '  Avail Bal: ' + FORMAT(AccountAvailableBalance);
                            // BalStmt := NewLine + Format(i) + '. ' + ProdFact."USSD Product Name" + ' : KES ' + Format(AccountBookBalance);
                            msg += BalStmt;

                        until SavAcc.Next = 0;

                        Response := 'SUCCESS';
                        Priority := 200;
                        SendSms(Source::SkyMobile, PhoneNo, msg, 'ACC_BAL', '', true, Priority, false);

                    end;
                end;
            end
            else
                if AccType = 'LOAN' then begin
                    msg := '';
                    i := 0;
                    Loans.Reset;
                    Loans.SetRange("Member No.", MemberNo);
                    Loans.SetFilter("Outstanding Principal", '>0');
                    if Loans.Find('-') then begin
                        msg := 'Loan Balances: ';

                        repeat
                            i += 1;
                            LoanType := Loans."Loan Product Type";

                            LProduct.Get(Loans."Loan Product Type");

                            Loans.CalcFields("Total Outstanding Balance");
                            if LProduct."USSD Product Name" = '' then
                                LProduct."USSD Product Name" := LProduct.Description;


                            BalStmt := NewLine + Format(i) + '. ' + LProduct."USSD Product Name" + ' : ' + Format(Loans."Total Outstanding Balance") + ', ';
                            msg += BalStmt;


                        until Loans.Next = 0;
                    end;

                    if msg <> '' then begin

                        Response := 'SUCCESS';
                        Priority := 200;
                        SendSms(Source::SkyMobile, PhoneNo, msg, 'LOAN_BAL', '', true, Priority, false);


                    end;
                end;
        end;
    end;


    procedure GetAccounts(PhoneNo: Code[20]; Source: Text) Response: Text[1024]
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        AccBal: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        MobileTrans: Record "Sky Transactions.";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        SLedger: Record "Savings Ledger Entry";
        LedgerCount: Integer;
        CurrRecord: Integer;
        DFilter: Text;
        DebitCreditFlag: Code[10];
        FirstEntry: Boolean;
        ProdFact: Record "Product Setup";
        AccountBookBalance: Decimal;
        AccountAvailableBalance: Decimal;
        AccountToCharge: Code[20];
        Found: Boolean;
        MemberNo: Code[20];
        TransactionDate: DateTime;
        Loans: Record Loans;
        LoanType: Text;
    begin
        PhoneNo := '+' + PhoneNo;
        Response := '';
        Found := false;

        MemberNo := '';
        AccountToCharge := '';
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        if SavAcc.FindFirst then begin
            MemberNo := SavAcc."Member No.";
            AccountToCharge := SavAcc."No.";
        end;

        if MemberNo = '' then
            exit('Member No. Missing');


        if (Source = 'FOSA') or (Source = 'BOSA') or (Source = 'ALL') then begin

            SavAcc.Reset;
            SavAcc.SetRange("Member No.", MemberNo);
            /*
            IF Source = 'FOSA' THEN
            SavAcc.SETFILTER("Product Category",'<>%1&<>%2&<>%3&<>%4&<>%5',SavAcc."Product Category"::"Benevolent Fund",
                      SavAcc."Product Category"::"Deposit Contribution",SavAcc."Product Category"::"Share Capital",
                      SavAcc."Product Category"::"Registration Fees",SavAcc."Product Category"::"Shares Drive");
            IF Source = 'BOSA' THEN
            SavAcc.SETFILTER("Product Category",'%1|%2|%3',SavAcc."Product Category"::"Deposit Contribution",SavAcc."Product Category"::"Share Capital"
                      ,SavAcc."Product Category"::"Shares Drive");
            */
            if SavAcc.Find('-') then begin

                Response := '<Accounts>';
                repeat
                    ProdFact.Get(SavAcc."Product Type");
                    SavAcc.CalcFields("Balance (LCY)");

                    if ProdFact."Mobile Transaction" <> ProdFact."mobile transaction"::" " then begin
                        Found := true;
                        Response += '<Account>';
                        Response += '<ProductID>' + ProdFact."Product ID" + '</ProductID>';
                        Response += '<ProductName>' + ProdFact."USSD Product Name" + '</ProductName>';
                        Response += '<AccountNo>' + SavAcc."No." + '</AccountNo>';
                        Response += '</Account>';
                    end;

                until SavAcc.Next = 0;
                Response += '</Accounts>';

            end;

        end
        else
            if Source = 'LOAN' then begin

                Loans.Reset;
                Loans.SetRange("Member No.", MemberNo);
                Loans.SetFilter("Outstanding Principal", '>0');
                if Loans.Find('-') then begin
                    Response := '<Accounts>';
                    repeat
                        LoanType := Loans."Loan Product Type";

                        if ProdFact.Get(Loans."Loan Product Type") then begin
                            if ProdFact."USSD Product Name" = '' then
                                ProdFact."USSD Product Name" := ProdFact.Description;
                            LoanType := ProdFact."USSD Product Name";
                        end;


                        Response += '<Account>';
                        Response += '<ProductID>' + ProdFact."Product ID" + '</ProductID>';
                        Response += '<ProductName>' + LoanType + '</ProductName>';
                        Response += '<AccountNo>' + Loans."Loan No." + '</AccountNo>';
                        Response += '</Account>';

                    until Loans.Next = 0;
                    Response += '</Accounts>';

                end;
            end;


        if not Found then
            Response := '';

    end;


    procedure ReverseWithdrawalRequest(EntryCode: Text): Boolean
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        MpesaTrans: Record "Sky Transactions.";
        TransAmt: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        RunBal: Decimal;
        AccBal: Decimal;
        Loans: Record Loans;
        IntAmt: Decimal;
        PrAmt: Decimal;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        Msg: Text;
    begin
        MobileWithdrawalsBuffer.Reset;
        MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Reference No", EntryCode);
        MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Source, MobileWithdrawalsBuffer.Source::"M-PESA");
        //MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Account No",SavAcc."No.");
        //MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer.Amount,Amount);
        MobileWithdrawalsBuffer.SetRange(Posted, false);
        MobileWithdrawalsBuffer.SetRange(Reversed, false);
        if MobileWithdrawalsBuffer.Find('-') then begin
            MobileWithdrawalsBuffer.Posted := true;
            MobileWithdrawalsBuffer."Posting Date" := Today;
            MobileWithdrawalsBuffer.Reversed := true;
            //MobileWithdrawalsBuffer."Date Reversed":=TODAY;
            //MobileWithdrawalsBuffer."Reversed By":=USERID;
            MobileWithdrawalsBuffer.Modify;


            if SavAcc.Get(MobileWithdrawalsBuffer."Account No") then begin

                Msg := 'Dear ' + FirstName(SavAcc.name) + ', Your withdrawal of KES ' + Format(MobileWithdrawalsBuffer.Amount) + ' has been reversed';
                SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", Msg, SavAcc."No.", '', true, Priority, false);

            end;

            exit(true);
        end
        else begin
            MobileWithdrawalsBuffer.Reset;
            MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Reference No", EntryCode);
            MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Source, MobileWithdrawalsBuffer.Source::"M-PESA");
            //MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Account No",SavAcc."No.");
            //MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer.Amount,Amount);
            MobileWithdrawalsBuffer.SetRange(Posted, true);
            MobileWithdrawalsBuffer.SetRange(Reversed, true);
            if MobileWithdrawalsBuffer.Find('-') then begin



                if SavAcc.Get(MobileWithdrawalsBuffer."Account No") then begin

                    Msg := 'Dear ' + FirstName(SavAcc.name) + ', Your withdrawal of KES ' + Format(MobileWithdrawalsBuffer.Amount) + ' has been reversed';
                    SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", Msg, SavAcc."No.", '', true, Priority, false);

                end;
                exit(true);
            end
        end;





        MobileWithdrawalsBuffer.Reset;
        MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Trace ID", EntryCode);
        MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Source, MobileWithdrawalsBuffer.Source::"M-PESA");
        //MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Account No",SavAcc."No.");
        //MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer.Amount,Amount);
        MobileWithdrawalsBuffer.SetRange(Posted, false);
        MobileWithdrawalsBuffer.SetRange(Reversed, false);
        if MobileWithdrawalsBuffer.Find('-') then begin
            MobileWithdrawalsBuffer.Posted := true;
            MobileWithdrawalsBuffer."Posting Date" := Today;
            MobileWithdrawalsBuffer.Reversed := true;
            //MobileWithdrawalsBuffer."Date Reversed":=TODAY;
            //MobileWithdrawalsBuffer."Reversed By":=USERID;
            MobileWithdrawalsBuffer.Modify;


            if SavAcc.Get(MobileWithdrawalsBuffer."Account No") then begin

                Msg := 'Dear ' + FirstName(SavAcc.name) + ', Your withdrawal of KES ' + Format(MobileWithdrawalsBuffer.Amount) + ' has been reversed';
                SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", Msg, SavAcc."No.", '', true, Priority, false);

            end;

            exit(true);
        end
        else begin
            MobileWithdrawalsBuffer.Reset;
            MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Trace ID", EntryCode);
            MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Source, MobileWithdrawalsBuffer.Source::"M-PESA");
            //MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Account No",SavAcc."No.");
            //MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer.Amount,Amount);
            MobileWithdrawalsBuffer.SetRange(Posted, true);
            MobileWithdrawalsBuffer.SetRange(Reversed, true);
            if MobileWithdrawalsBuffer.Find('-') then begin



                if SavAcc.Get(MobileWithdrawalsBuffer."Account No") then begin

                    Msg := 'Dear ' + FirstName(SavAcc.name) + ', Your withdrawal of KES ' + Format(MobileWithdrawalsBuffer.Amount) + ' has been reversed';
                    SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", Msg, SavAcc."No.", '', true, Priority, false);

                end;
                exit(true);
            end
        end;


        exit(false);
    end;


    procedure GetLoanLimit(PhoneNo: Code[20]; LoanProductType: Code[20]) Response: Text
    var
        SavAcc: Record "Savings Accounts";
        PFact: Record "Product Setup";
        XMLDOMMgt: Codeunit "XML DOM Management";
        MaxLoan: Decimal;
        msg: Text;
        AccountNo: Code[20];
        QualAmt: Decimal;
        Remark: Text;
        SalType: Option " ",Checkoff,"Standing Order",Salary,Milk,Tea,Coffee,Dividend,Cash,Pension,Dependant,Others,"BOM income";
    begin

        PhoneNo := '+' + PhoneNo;

        Response := 'ERROR';
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin
            //MESSAGE(SavAcc.Name);
            PFact.Get(LoanProductType);
            if PFact."USSD Product Name" = '' then
                PFact."USSD Product Name" := PFact.Description;

            AccountNo := SavAcc."No.";
            QualAmt := 0;
            Remark := '';


            if LoanProductType = 'L30' then
                GetLoanQualifiedAmount(AccountNo, LoanProductType, QualAmt, Remark, RespCode);

            if LoanProductType = 'L24' then
                GetLoanQualifiedAmount(AccountNo, LoanProductType, QualAmt, Remark, RespCode);

            if LoanProductType = 'L27' then
                GetLoanQualifiedAmount(AccountNo, LoanProductType, QualAmt, Remark, RespCode);

            if LoanProductType = 'L43' then
                GetDividendLoanQualifiedAmount(AccountNo, LoanProductType, QualAmt, Remark);

            msg := 'Dear ' + SavAcc.Name + ', your Loan Limit for ' + PFact."USSD Product Name" + ' is KES ' + Format(QualAmt) + '. ' + Remark;
            SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, LoanProductType, '', true, Priority, false);

            Response := 'SUCCESS';

        end;
    end;


    procedure IMSIConfirm(PhoneNo: Text[30]; IMSI: Text): Boolean
    var
        SavAcc: Record "Savings Accounts";
        SkyworldUSSDAuth: Record "Sky USSD Auth";
        msg: Text;
    begin
        PhoneNo := '+' + PhoneNo;

        //IMSI
        if IMSI <> '' then begin
            SkyworldUSSDAuth.Reset;
            SkyworldUSSDAuth.SetRange(SkyworldUSSDAuth."Mobile No.", PhoneNo);
            if SkyworldUSSDAuth.FindFirst then begin
                if SkyworldUSSDAuth.IMSI = '' then begin
                    SkyworldUSSDAuth.IMSI := IMSI;
                    SkyworldUSSDAuth.Modify;
                    exit(true);
                end
                else begin
                    if SkyworldUSSDAuth.IMSI = IMSI then
                        exit(true);
                end;
            end;
        end;

        msg := 'Dear Member, please note that you have changed your sim card. Please visit one of our branches or contact us for assistance';

        Priority := 201;
        SendSms(Source::SkyMobile, PhoneNo, msg, 'IMSI', '', true, Priority, false);

        exit(false);
    end;


    procedure UpdateIMSI(PhoneNo: Text[30]; IMSI: Text): Boolean
    var
        SavAcc: Record "Savings Accounts";
        SkyworldUSSDAuth: Record "Sky USSD Auth";
        msg: Text;
    begin
        PhoneNo := '+' + PhoneNo;

        //IMSI
        SkyworldUSSDAuth.Reset;
        SkyworldUSSDAuth.SetRange(SkyworldUSSDAuth."Mobile No.", PhoneNo);
        if SkyworldUSSDAuth.FindFirst then begin
            SkyworldUSSDAuth.IMSI := IMSI;
            SkyworldUSSDAuth.Modify;
            exit(true);
        end;

        exit(false);
    end;


    procedure TestLogin(MobileNo: Code[30]) Response: Text
    var
        SkyAuth: Record "Sky USSD Auth";
    begin
        MobileNo := '+' + MobileNo;

        SkyAuth.Reset;
        SkyAuth.SetRange(SkyAuth."Mobile No.", MobileNo);
        if SkyAuth.FindFirst then begin

            Response := '<Login>';

            Response += '<MobileNo>' + SkyAuth."Mobile No." + '</MobileNo>';
            Response += '<AccountNo>' + SkyAuth."Account No." + '</AccountNo>';
            Response += '<PIN>' + SkyAuth."PIN No." + '</PIN>';
            Response += '<ResetPin>' + Format(SkyAuth."Reset PIN") + '</ResetPin>';
            Response += '<Status>' + Format(SkyAuth."User Status") + '</Status>';
            Response += '<ForcePin>' + Format(SkyAuth."Force PIN") + '</ForcePin>';
            Response += '<IMSI>' + SkyAuth.IMSI + '</IMSI>';
            Response += '<IMEI>' + SkyAuth.IMEI + '</IMEI>';

            Response += '</Login>';

        end;
    end;


    procedure UpdateAuthAttempts(MobileNo: Code[30]; Type: Text; "Count": Integer; Tag: Text; "Action": Text; Validity: DateTime; ClearValidity: Boolean) Response: Text
    var
        SavAcc: Record "Savings Accounts";
        SkyAuth: Record "Sky USSD Auth";
    begin
        MobileNo := '+' + MobileNo;

        Response := 'ERROR';

        SkyAuth.Reset;
        SkyAuth.SetRange(SkyAuth."Mobile No.", MobileNo);
        if SkyAuth.FindFirst then begin
            if (Type = 'LOGIN') then begin
                SkyAuth."Login Attempts Action" := Action;
                SkyAuth."Login Attempts Count" := Count;
                SkyAuth."Login Attempts Tag" := Tag;
                if (ClearValidity) then begin
                    Clear(SkyAuth."Login Attempts Action Expiry");
                end
                else begin
                    SkyAuth."Login Attempts Action Expiry" := Validity;
                end;
                SkyAuth.Modify;
                Response := 'SUCCESS';
            end;
            if (Type = 'OTP') then begin
                SkyAuth."OTP Attempts Action" := Action;
                SkyAuth."OTP Attempts Count" := Count;
                SkyAuth."OTP Attempts Tag" := Tag;
                if (ClearValidity) then begin
                    Clear(SkyAuth."OTP Attempts Action Expiry");
                end
                else begin
                    SkyAuth."OTP Attempts Action Expiry" := Validity;
                end;
                SkyAuth.Modify;
                Response := 'SUCCESS';
            end;
        end
        else begin
            Response := 'NOT_FOUND';
        end;
    end;


    procedure GetUserLoginAttemptExpiry(MobileNo: Code[30]; Type: Text) Response: DateTime
    var
        SavAcc: Record "Savings Accounts";
        SkyAuth: Record "Sky USSD Auth";
    begin
        MobileNo := '+' + MobileNo;

        Response := CurrentDatetime;

        SkyAuth.Reset;
        SkyAuth.SetRange(SkyAuth."Mobile No.", MobileNo);
        if SkyAuth.FindFirst then begin
            if (Type = 'LOGIN') then begin
                Response := SkyAuth."Login Attempts Action Expiry";
            end;
            if (Type = 'OTP') then begin
                Response := SkyAuth."OTP Attempts Action Expiry";
            end;
        end;
    end;


    procedure GetUserLoginAttemptAction(MobileNo: Code[30]; Type: Text) Response: Code[10]
    var
        SavAcc: Record "Savings Accounts";
        SkyAuth: Record "Sky USSD Auth";
    begin
        MobileNo := '+' + MobileNo;

        Response := '';

        SkyAuth.Reset;
        SkyAuth.SetRange(SkyAuth."Mobile No.", MobileNo);
        if SkyAuth.FindFirst then begin
            if (Type = 'LOGIN') then begin
                if (SkyAuth."Login Attempts Action" = 'SUSPEND') then begin
                    if (SkyAuth."Login Attempts Action Expiry" > CurrentDatetime) then begin
                        Response := 'SUSPENDED'
                    end;
                end;
            end;
            if (Type = 'OTP') then begin
                if (SkyAuth."OTP Attempts Action" = 'SUSPEND') then begin
                    if (SkyAuth."OTP Attempts Action Expiry" > CurrentDatetime) then begin
                        Response := 'SUSPENDED'
                    end;
                end;
            end;
        end;
    end;


    procedure GetUserLoginAttemptCount(MobileNo: Code[30]; Type: Text) Response: Integer
    var
        SavAcc: Record "Savings Accounts";
        SkyAuth: Record "Sky USSD Auth";
    begin
        MobileNo := '+' + MobileNo;

        Response := 0;

        SkyAuth.Reset;
        SkyAuth.SetRange(SkyAuth."Mobile No.", MobileNo);
        if SkyAuth.FindFirst then begin
            if (Type = 'LOGIN') then begin
                Response := SkyAuth."Login Attempts Count";
            end;
            if (Type = 'OTP') then begin
                Response := SkyAuth."OTP Attempts Count";
            end;
        end
        else begin
            Response := 0;
        end;
    end;


    procedure UserCheck(MobileNo: Code[30]; IMSI_IMEI: Code[50]; USSD: Boolean; SessionID: Code[20]) Response: Text
    var
        SavAcc: Record "Savings Accounts";
        SkyAuth: Record "Sky USSD Auth";
    begin
        MobileNo := '+' + MobileNo;

        Response := 'ERROR';

        SkyAuth.Reset;
        SkyAuth.SetRange(SkyAuth."Mobile No.", MobileNo);
        if SkyAuth.FindFirst then begin
            if (SkyAuth."User Status" = SkyAuth."user status"::Inactive) or (SkyAuth."User Status" = SkyAuth."user status"::" ") then
                Response := 'BLOCKED'
            else begin
                if USSD then begin
                    if (IMSI_IMEI = '') then begin
                        Response := 'ACTIVE';
                        //Response := 'INVALID_IMSI';
                        //EXIT;
                    end;
                    if (SkyAuth.IMSI = '') or (SkyAuth.IMSI = IMSI_IMEI) then begin
                        Response := 'ACTIVE';
                    end
                    else begin
                        //Response := 'INVALID_IMSI';
                        Response := 'ACTIVE';
                    end;
                end
                else begin
                    if (IMSI_IMEI = '') then begin
                        Response := 'INVALID_IMEI';
                        exit;
                    end;
                    if not SkyAuth."Mobile App Activated" then begin
                        Response := 'MOBILEAPP_INACTIVE';
                        exit;
                    end;

                    if (SkyAuth.IMEI = IMSI_IMEI) then begin
                        Response := 'ACTIVE';
                    end
                    else begin
                        Response := 'INVALID_IMEI';
                    end;
                end;

                if (SkyAuth."Login Attempts Action" = 'SUSPEND') then begin
                    if (SkyAuth."Login Attempts Action Expiry" > CurrentDatetime) then begin
                        Response := 'SUSPENDED'
                    end;
                end;
            end;


            SavAcc.Reset;
            SavAcc.SetRange("No.", SkyAuth."Account No.");
            if SavAcc.FindFirst then
                if SavAcc.Blocked <> SavAcc.Blocked::" " then
                    Response := 'BLOCKED';

            SavAcc.Reset;
            SavAcc.SetRange("No.", SkyAuth."Account No.");
            SavAcc.SetRange(Status, SavAcc.Status::Deceased);
            if SavAcc.FindFirst then
                Response := 'DECEASED';


            SavAcc.Reset;
            SavAcc.SetRange("No.", SkyAuth."Account No.");
            if SavAcc.FindFirst then begin
                if CheckBlackList(SavAcc."No.", SavAcc."No.", SavAcc."ID No.") then
                    Response := 'BLOCKED';
            end;



        end
        else begin
            Response := 'NOT_FOUND';
        end;

        if not USSD then begin
            if Response = 'ACTIVE' then begin
                Response := MobileAppLogin(SessionID, MobileNo);
            end;
        end;
    end;


    procedure CheckIfServiceIsEnabledForUser(AccNo: Code[30]; Service: Text) Response: Boolean
    var
        Vendor: Record "Savings Accounts";
    begin
        Response := false;

        Vendor.Reset;
        Vendor.SetRange("No.", AccNo);
        if Vendor.FindFirst then begin
            if (Service = 'WD_TO_OTHER') and (Vendor."Allow Withdrawal To Others") then begin
                exit(true);
            end;
            if (Service = 'B2B') and (Vendor."Allow Bank Transfer") then begin
                exit(true);
            end;

        end
        else begin
            Response := false;
        end;
    end;


    procedure ActionServiceForUser("Action": Code[50]; AccNo: Code[30]; Service: Text) Response: Boolean
    var
        Vendor: Record "Savings Accounts";
    begin
        Response := false;

        Vendor.Reset;
        Vendor.SetRange("No.", AccNo);
        if Vendor.FindFirst then begin
            if (Service = 'WD_TO_OTHER') then begin
                if (Action = 'DISABLE') then begin
                    Vendor."Allow Withdrawal To Others" := false;
                    Vendor.Modify;
                end;
                if (Action = 'ENABLE') then begin
                    Vendor."Allow Withdrawal To Others" := true;
                    Vendor.Modify;
                end;

                exit(true);
            end;
            if (Service = 'B2B') then begin
                if (Action = 'DISABLE') then begin
                    Vendor."Allow Bank Transfer" := false;
                    Vendor.Modify;
                end;
                if (Action = 'ENABLE') then begin
                    Vendor."Allow Bank Transfer" := true;
                    Vendor.Modify;
                end;

                exit(true);
            end;

        end
        else begin
            Response := false;
        end;
    end;


    procedure MAPPSetIMEI(MobileNo: Code[30]; IMEI: Text) Response: Text
    var
        SkyAuth: Record "Sky USSD Auth";
    begin
        MobileNo := '+' + MobileNo;

        Response := 'ERROR';

        SkyAuth.Reset;
        SkyAuth.SetRange(SkyAuth."Mobile No.", MobileNo);

        if SkyAuth.FindFirst then begin
            if not (IMEI = '') then begin
                SkyAuth.IMEI := IMEI;
                SkyAuth."Mobile App Activated" := true;
                SkyAuth.Modify;
                Response := 'SUCCESS';
            end;

        end
        else begin
            Response := 'NOT_FOUND';
        end;
    end;


    procedure USSDLogin(MobileNo: Code[30]; PIN: Text; IMSI_IMEI: Text; USSD: Boolean; SessionID: Code[20]) Response: Text
    var
        SkyAuth: Record "Sky USSD Auth";
        SavAcc: Record "Savings Accounts";
        Name: Text;
        AttemptsCount: Integer;
    begin
        MobileNo := '+' + MobileNo;

        Response := 'ERROR';
        Name := ' ';

        SkyAuth.Reset;
        SkyAuth.SetRange(SkyAuth."Mobile No.", MobileNo);
        if SkyAuth.FindFirst then begin
            SavAcc.Reset;
            SavAcc.SetRange(SavAcc."No.", SkyAuth."Account No.");
            if (SavAcc.FindFirst) then begin
                Name := SavAcc.Name;
            end;

            if ((SkyAuth."Login Attempts Action" = 'SUSPEND') or (SkyAuth."OTP Attempts Action" = 'SUSPEND')) then begin
                if ((SkyAuth."Login Attempts Action" = 'SUSPEND') and (SkyAuth."OTP Attempts Action" <> 'SUSPEND')) then begin
                    if (SkyAuth."Login Attempts Action Expiry" > CurrentDatetime) then begin
                        Response := 'SUSPENDED' + ':::' + Name + ':::' + Format(SkyAuth."Login Attempts Action Expiry") + ':::' + Format(SkyAuth."Login Attempts Count");
                        exit(Response);
                    end;
                end;
                if ((SkyAuth."Login Attempts Action" <> 'SUSPEND') and (SkyAuth."OTP Attempts Action" = 'SUSPEND')) then begin
                    if (SkyAuth."OTP Attempts Action Expiry" > CurrentDatetime) then begin
                        Response := 'SUSPENDED' + ':::' + Name + ':::' + Format(SkyAuth."OTP Attempts Action Expiry") + ':::' + Format(SkyAuth."OTP Attempts Count");
                        exit(Response);
                    end;
                end;
                if ((SkyAuth."Login Attempts Action" = 'SUSPEND') and (SkyAuth."OTP Attempts Action" = 'SUSPEND')) then begin
                    if (SkyAuth."Login Attempts Action Expiry" > SkyAuth."OTP Attempts Action Expiry") then begin
                        if (SkyAuth."Login Attempts Action Expiry" > CurrentDatetime) then begin
                            Response := 'SUSPENDED' + ':::' + Name + ':::' + Format(SkyAuth."Login Attempts Action Expiry") + ':::' + Format(SkyAuth."Login Attempts Count");
                            exit(Response);
                        end;
                    end
                    else begin
                        if (SkyAuth."OTP Attempts Action Expiry" > CurrentDatetime) then begin
                            Response := 'SUSPENDED' + ':::' + Name + ':::' + Format(SkyAuth."OTP Attempts Action Expiry") + ':::' + Format(SkyAuth."OTP Attempts Count");
                            exit(Response);
                        end;
                    end;
                end;
            end;


            //ELSE BEGIN

            if USSD then begin
                if (SkyAuth."PIN No." = PIN) and ((SkyAuth.IMSI = '') or (SkyAuth.IMSI = IMSI_IMEI)) then begin
                    Response := 'SUCCESS';
                    if (SkyAuth.IMSI = '') then begin
                        SkyAuth.IMSI := IMSI_IMEI;
                        SkyAuth.Modify;
                    end;
                end
                else begin
                    if (SkyAuth."PIN No." <> PIN) then begin
                        Response := 'INCORRECT_PIN';
                    end;
                end;
            end
            else begin
                if (SkyAuth."User Status" = SkyAuth."user status"::Inactive) or (SkyAuth."User Status" = SkyAuth."user status"::" ") then begin
                    Response := 'BLOCKED';
                    exit;
                end;

                if (SkyAuth."PIN No." = PIN) then begin
                    Response := 'SUCCESS';
                    if (SkyAuth."Mobile App KYC Login Enabled") then begin
                        if not (SkyAuth."Mobile App Activated" = true) then begin
                            Response := 'MOBILEAPP_INACTIVE';
                        end
                        else
                            if not (SkyAuth.IMEI = IMSI_IMEI) then begin
                                Response := 'INVALID_IMEI_WITH_KYC';
                            end;
                    end
                    else begin
                        if not (SkyAuth."Mobile App Activated" = true) then begin
                            Response := 'MOBILEAPP_INACTIVE';
                        end
                        else
                            if not (SkyAuth.IMEI = IMSI_IMEI) then begin
                                Response := 'INVALID_IMEI';
                            end;
                    end;
                end
                else
                    if (IMSI_IMEI = '') then begin
                        Response := 'INVALID_IMEI';
                    end
                    else begin
                        if not SkyAuth."Mobile App Activated" then
                            Response := 'MOBILEAPP_INACTIVE'
                        else
                            Response := 'INCORRECT_PIN';

                    end;
                if (SkyAuth."PIN No." <> PIN) then begin
                    Response := 'INCORRECT_PIN';
                end;
            end;
        end
        else begin
            Response := 'NOT_FOUND';
        end;

        if not USSD then begin
            if Response = 'SUCCESS' then begin
                MobileAppLogin(SessionID, MobileNo);
            end;
        end;

        if (Response = 'SUCCESS') then begin
            SkyAuth."Login Attempts Action" := 'ACTIVE';
            SkyAuth."Login Attempts Tag" := '';
            Clear(SkyAuth."Login Attempts Action Expiry");
            SkyAuth."Login Attempts Count" := 0;
            SkyAuth.Modify;
            if USSD and (SkyAuth."Force PIN") then begin
                Response := 'SET_PIN';
            end;
        end;

        if (Response = 'INCORRECT_PIN') then begin
            SkyAuth."Login Attempts Count" := SkyAuth."Login Attempts Count" + 1;
            SkyAuth.Modify;
            AttemptsCount := SkyAuth."Login Attempts Count";
            Response := Response + ':::' + Format(AttemptsCount) + ':::' + Name;
        end;
    end;


    procedure ValidateIDNumber(MobileNo: Code[30]; IDNo: Code[50]) Response: Code[50]
    var
        SkyAuth: Record "Sky USSD Auth";
        SavAcc: Record "Savings Accounts";
        NewIMEI_IMSI: Code[20];
    begin
        MobileNo := '+' + MobileNo;

        Response := 'ERROR';

        SavAcc.Reset;
        SavAcc.SetRange("ID No.", IDNo);
        SavAcc.SetRange("Transactional Mobile No", MobileNo);
        if SavAcc.FindFirst then begin
            Response := 'SUCCESS';
        end
        else begin
            Response := 'INVALID_ACCOUNT';
        end;
    end;


    procedure ValidateKYCdetails(MobileNo: Code[30]; IDNo: Code[50]; NewPIN: Text; OTCPIN: Text; IMEI_IMSI: Text; USSD: Boolean) Response: Text
    var
        SkyAuth: Record "Sky USSD Auth";
        SavAcc: Record "Savings Accounts";
        NewIMEI_IMSI: Code[20];
    begin
        MobileNo := '+' + MobileNo;

        Response := 'ERROR';

        SavAcc.Reset;
        SavAcc.SetRange("ID No.", IDNo);
        SavAcc.SetRange("Transactional Mobile No", MobileNo);
        if SavAcc.FindFirst then begin

            SkyAuth.Reset;
            SkyAuth.SetRange("Mobile No.", MobileNo);
            if SkyAuth.FindFirst then begin
                if SkyAuth."PIN No." <> OTCPIN then
                    Response := 'INCORRECT_PIN'
                else begin

                    if NewPIN = '' then
                        Response := 'INVALID_NEW_PIN'
                    else begin
                        SkyAuth."PIN No." := NewPIN;
                        SkyAuth."Force PIN" := false;

                        if USSD then begin
                            if SkyAuth.IMSI = '' then
                                SkyAuth.IMSI := IMEI_IMSI;
                        end
                        else begin
                            if SkyAuth.IMEI = '' then
                                SkyAuth.IMEI := IMEI_IMSI;
                        end;
                        SkyAuth.Modify;
                        Response := 'SUCCESS';
                    end;
                end;
            end
            else begin
                Response := 'INVALID_ACCOUNT';
            end;

        end
        else begin
            Response := 'INVALID_ACCOUNT';
        end;
    end;


    procedure LoanMiniStatement(EntryCode: Text; TransactionID: Code[20]; MaxNumberRows: Integer; LoanType: Text; MobileNo: Text; Pin: Text) Response: Text
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        PhoneNo: Code[20];
        AccBal: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        MobileTrans: Record "Sky Transactions.";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        LedgerCount: Integer;
        CurrRecord: Integer;
        DFilter: Text;
        DebitCreditFlag: Code[10];
        FirstEntry: Boolean;
        ProdFact: Record "Product Setup";
        TransactionDate: DateTime;
        Msg: Text;
        Stmt: Text;
        StatementAccount: Code[20];
        AccountToCharge: Code[20];
        MemberNo: Code[20];
        Loans: Record Loans;
        CLedger: Record "Credit Ledger Entry";
    begin

        TransactionDate := CurrentDatetime;
        MobileNo := '+' + MobileNo;

        Response := 'ERROR';

        if not CorrectPin(MobileNo, Pin) then begin
            Response := 'INCORRECT_PIN';
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

        MemberNo := '';
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", MobileNo);
        if SavAcc.FindFirst then
            MemberNo := SavAcc."Member No.";

        if SavAcc.Blocked <> SavAcc.Blocked::" " then
            exit;

        StatementAccount := '';
        AccountToCharge := '';

        Loans.Reset;
        Loans.SetRange("Loan No.", LoanType);
        if Loans.FindFirst then
            StatementAccount := Loans."Loan No.";


        //error('MemberNo %1',MemberNo);

        SavAcc.Reset;
        SavAcc.SetRange("Member No.", MemberNo);
        SavAcc.SetFilter("Transactional Mobile No", '<>%1', '');
        if SavAcc.FindFirst then
            AccountToCharge := SavAcc."No.";

        SMSAccount := '';
        SMSCharge := 0;

        CoopSetup.Reset;
        //CoopSetup.SetRange("Transaction Type", CoopSetup."transaction type"::"Mini-Statement");
        if CoopSetup.FindFirst then begin

            SMSAccount := CoopSetup."SMS Account";
            SMSCharge := CoopSetup."SMS Charge";


            SaccoAccount := CoopSetup."Sacco Fee Account";
            SaccoFee := CoopSetup."Sacco Fee";
            VendorAccount := CoopSetup."Vendor Commission Account";
            VendorCommission := CoopSetup."Vendor Commission";

            TotalCharge := SaccoFee + VendorCommission + SMSCharge;
            ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
        end
        else begin
            //ERROR('Setup Missing for %1', CoopSetup."Transaction Type");
        end;


        //PhoneNo:='+'+MobileNo;
        //error('AccountToCharge %1',AccountToCharge);

        SavAcc.Reset;
        SavAcc.SetRange("No.", AccountToCharge);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin


            ProdFact.Get(SavAcc."Product Type");

            if (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::"Deposits Only") or
                (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::" ") then begin
                Error('The Account to Charge is not a Withdrawable Account');
            end;



            AccBal := GetAccountBalance(SavAcc."No.");
            //Message(' AccBal %1\ TotalCharge+ExciseDuty %2\ no: %3', AccBal , TotalCharge+ExciseDuty,SavAcc."No.");
            if AccBal >= TotalCharge + ExciseDuty then begin

                //BUser.GET(USERID);

                //BUser.TESTFIELD("Cashier Journal Template");
                //BUser.TESTFIELD("Cashier Journal Batch");

                JTemplate := 'GENERAL';
                JBatch := 'MBANKING';

                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                GenJournalBatch.SetRange(Name, JBatch);
                if not GenJournalBatch.FindFirst then begin
                    GenJournalBatch.Init;
                    GenJournalBatch."Journal Template Name" := JTemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.Description := 'Mbanking Batch';
                    GenJournalBatch.Insert;
                end;

                MobileTrans.Init;
                MobileTrans."Entry No." := EntryCode;
                MobileTrans."Transaction ID" := TransactionID;
                MobileTrans."Session ID" := TransactionID;
                MobileTrans."Transaction Date" := Dt2Date(TransactionDate);
                MobileTrans."Transaction Time" := Dt2Time(TransactionDate);
                MobileTrans."Member Account" := SavAcc."No.";
                MobileTrans."Statement Max Rows" := MaxNumberRows;
                //MobileTrans."Statement Start Date":=StartDate;
                //MobileTrans."Statement End Date":=EndDate;
                MobileTrans."Account to Check" := StatementAccount;
                MobileTrans."Transaction Type" := MobileTrans."transaction type"::"Mini-Statement";
                MobileTrans.Description := Format(MobileTrans."Transaction Type");
                MobileTrans.Insert;


                MobileTrans.Reset;
                MobileTrans.SetRange("Transaction ID", TransactionID);
                MobileTrans.SetRange(Posted, false);
                if MobileTrans.FindFirst then begin

                    DocNo := MobileTrans."Transaction ID";
                    PDate := MobileTrans."Transaction Date";
                    AccNo := MobileTrans."Member Account";
                    ExtDoc := '';
                    LoanNo := '';
                    TransType := Transtype::" ";
                    Dim1 := SavAcc."Global Dimension 1 Code";
                    Dim2 := SavAcc."Global Dimension 2 Code";
                    SystCreated := true;

                    SaccoTrans.JournalInit(JTemplate, JBatch);


                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(MobileTrans.Description, 1, 50), Balacctype::"G/L Account",
                                  '', VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(MobileTrans.Description, 1, 50), Balacctype::"G/L Account",
                                  '', SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccountToCharge, CopyStr('SMS Charges', 1, 50), Balacctype::"G/L Account",
                                  SMSAccount, SMSCharge, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr('Excise Duty ' + Format(MobileTrans."Transaction Type"), 1, 50), Balacctype::"G/L Account",
                                  ExciseDutyGL, ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());


                    AccNo := VendorAccount;
                    ExtDoc := MobileTrans."Member Account";
                    LoanNo := '';
                    TransType := Transtype::" ";

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, AccNo, CopyStr(MobileTrans.Description + ' Commission', 1, 50), Balacctype::"G/L Account",
                                  '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                    AccNo := SaccoAccount;
                    ExtDoc := MobileTrans."Member Account";
                    LoanNo := '';
                    TransType := Transtype::" ";

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", AccNo, CopyStr(MobileTrans.Description + ' Fee', 1, 50), Balacctype::"G/L Account",
                                  '', -SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());


                    MobileTrans.Posted := true;
                    MobileTrans."Posted By" := UserId;
                    MobileTrans."Date Posted" := Today;
                    MobileTrans.Modify;

                    SaccoTrans.JournalPost(JTemplate, JBatch);

                end
                else begin
                    Error('Transaction Not Found');
                end;

            end
            else begin
                Response := 'INSUFFICIENT_BAL';
            end;

            //error('StatementAccount: %1',StatementAccount);
            if Response = 'ERROR' then begin

                MobileTrans.Reset;
                MobileTrans.SetRange("Transaction ID", TransactionID);
                MobileTrans.SetRange(Posted, true);
                if MobileTrans.FindFirst then begin
                    Loans.Get(StatementAccount);

                    CLedger.Reset;
                    CLedger.SetCurrentkey("Entry No.");
                    CLedger.Ascending(false);
                    CLedger.SetRange("Loan No.", Loans."Loan No.");
                    CLedger.SetRange("Account No.", Loans."Member No.");
                    CLedger.SetRange(Reversed, false);
                    if CLedger.FindFirst then begin
                        AccBal := 0;
                        Msg := 'Loan MiniStatement ' + Loans."Loan No.";
                        repeat
                            LedgerCount += 1;
                            Stmt := NewLine + Format(CLedger."Posting Date") + '; ' + Format(CLedger."Transaction Type") + '; ' + Format(CLedger."Amount (LCY)");
                            if StrLen(Msg + Stmt) < 250 then begin
                                Msg += Stmt;
                            end;

                        until (CLedger.Next = 0) or (CLedger.Count = MaxNumberRows);

                        Priority := 203;
                        SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", Msg, StatementAccount, '', true, Priority, false);

                        Response := 'SUCCESS';
                    end;
                end;
            end;
        end
        else begin
            Response := 'INVALID_ACCOUNT';
        end;
    end;


    procedure GetAccountTransferRecipientXML(Criteria: Code[20]; Source: Text) Response: Text
    var
        SavAcc: Record "Savings Accounts";
        PFact: Record "Product Setup";


        XMLDOMMgt: Codeunit "XML DOM Management";



        LongCode: Code[20];
        AccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Share Capital","Deposit Contribution","Deposit Contribution Micro","Retirement Saving Fund","Registration Fee","Insurance Contribution","FOSA SHARES";
        MobileLoans: Record "Sky Mobile Loans";
        OutPut: Boolean;
        LNo: Code[20];
        "Key": Code[10];
        Members: Record Members;
        Loans: Record Loans;
        Pos: Integer;
    begin

        Response := '';


        if Source = 'Mobile' then begin

            if StrLen(Criteria) = 10 then
                if CopyStr(Criteria, 1, 1) = '0' then
                    Criteria := CopyStr(Criteria, 2, 9);

            SavAcc.Reset;
            SavAcc.SetFilter("Transactional Mobile No", '*' + Criteria);
            SavAcc.SetFilter(Blocked, '<>%1', SavAcc.Blocked::All);
            if SavAcc.FindFirst then begin
                Response := SavAcc."No.";
                Response := '<Account>';
                Response += '<AccountNo>' + SavAcc."No." + '</AccountNo>';
                Response += '<Name>' + SavAcc.Name + '</Name>';
                Response += '</Account>';

            end
            else begin

                SavAcc.Reset;
                SavAcc.SetFilter("Phone No.", '*%1', '*' + Criteria);
                SavAcc.SetFilter(Blocked, '<>%1', SavAcc.Blocked::All);
                if SavAcc.FindFirst then begin
                    Response := SavAcc."No.";
                    Response := '<Account>';
                    Response += '<AccountNo>' + SavAcc."No." + '</AccountNo>';
                    Response += '<Name>' + SavAcc.Name + '</Name>';
                    Response += '</Account>';

                end;
            end
        end
        else
            if Source = 'ID' then begin
                SavAcc.Reset;
                SavAcc.SetRange("ID No.", Criteria);
                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Ordinary Savings");
                SavAcc.SetFilter(Blocked, '<>%1', SavAcc.Blocked::All);
                if SavAcc.FindFirst then begin
                    Response := SavAcc."No.";
                    Response := '<Account>';
                    Response += '<AccountNo>' + SavAcc."No." + '</AccountNo>';
                    Response += '<Name>' + SavAcc.Name + '</Name>';
                    Response += '</Account>';

                end
            end
            else
                if Source = 'ACCOUNT' then begin
                    Pos := StrPos(Criteria, '#');
                    if Pos > 1 then begin
                        Criteria := CopyStr(Criteria, 1, Pos - 1);
                    end;

                    SavAcc.Reset;
                    SavAcc.SetRange("No.", Criteria);
                    if SavAcc.FindFirst then begin
                        Response := SavAcc."No.";
                        Response := '<Account>';
                        Response += '<AccountNo>' + SavAcc."No." + '</AccountNo>';
                        Response += '<Name>' + SavAcc.Name + '</Name>';
                        Response += '<MobileNumber>' + SavAcc."Transactional Mobile No" + '</MobileNumber>';
                        Response += '</Account>';
                    end
                    else begin
                        LongCode := AccountPrefix + Criteria + AccountSuffix;
                        //Error('LongCode %1',LongCode);

                        SavAcc.Reset;
                        SavAcc.SetRange("No.", LongCode);
                        if SavAcc.FindFirst then begin
                            Response := SavAcc."No.";
                            Response := '<Account>';
                            Response += '<AccountNo>' + SavAcc."No." + '</AccountNo>';
                            Response += '<Name>' + SavAcc.Name + '</Name>';
                            Response += '<MobileNumber>' + SavAcc."Transactional Mobile No" + '</MobileNumber>';
                            Response += '</Account>';
                        end
                        else begin
                            AccNo := '';

                            GetAccountFromKeyWord(Criteria, AccNo, LoanAccount, DepositAccount, IDNo, MNo, BosaTransType, Key, LNo);
                            if LoanAccount then begin
                                Members.Get(MNo);
                                Loans.Get(LNo);
                                Response := '<Account>';
                                Response += '<AccountNo>' + MNo + '[' + Format(Loans."Loan Product Type Name") + ']</AccountNo>';
                                Response += '<Name>' + Members.Name + '</Name>';
                                Response += '<MobileNumber>' + Members."Phone No." + '</MobileNumber>';
                                Response += '</Account>';

                            end
                            else
                                if DepositAccount then begin
                                    Members.Get(MNo);
                                    Response := '<Account>';
                                    Response += '<AccountNo>' + MNo + '[' + Format(BosaTransType) + ']</AccountNo>';
                                    Response += '<Name>' + Members.Name + '</Name>';
                                    Response += '<MobileNumber>' + Members."Phone No." + '</MobileNumber>';
                                    Response += '</Account>';

                                end;

                        end;
                    end;
                end
        //Response:='';
    end;


    procedure AccountBalanceEnquiryMobileApp(EntryCode: Text; TransactionID: Code[20]; PhoneNo: Code[20]; PIN: Text; AccountToCheck: Code[20]) Response: Text[1024]
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        AccBal: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        MobileTrans: Record "Sky Transactions.";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        SLedger: Record "Savings Ledger Entry";
        LedgerCount: Integer;
        CurrRecord: Integer;
        DFilter: Text;
        DebitCreditFlag: Code[10];
        FirstEntry: Boolean;
        ProdFact: Record "Product Setup";
        AccountBookBalance: Decimal;
        AccountAvailableBalance: Decimal;
        AccountToCharge: Code[20];
        Found: Boolean;
        MemberNo: Code[20];
        TransactionDate: DateTime;
        Loans: Record Loans;
        LoanType: Text;
        BalStmt: Text;
        msg: Text;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomFee: Decimal;
        BalEnqCharge: Decimal;
        ProductName: Text;
        BosaEntry: Boolean;
        BosaProduct: Option "None","Loan Repayment","Share Capital","Deposit Contribution","Deposit Contribution Micro","Retirement Saving Fund","Registration Fee","Insurance Contribution","FOSA SHARES","RSF MICRO","Fosa Shares Micro";
        BosaNo: Code[20];
        IDNo: Code[20];
    begin
        TransactionDate := CurrentDatetime;

        Response := '';
        Found := false;


        PhoneNo := '+' + PhoneNo;

        if not CorrectPin(PhoneNo, PIN) then begin

            Response := '<Response>';
            Response += '<Status>INCORRECT_PIN</Status>';
            Response += '<StatusDescription>Incorrect PIN</StatusDescription>';
            Response += '<Reference>' + TransactionID + '</Reference>';
            Response += '</Response>';

            exit;
        end;


        AccountToCharge := '';
        MemberNo := '';

        IDNo := '';
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        if SavAcc.FindFirst then begin
            SavAcc.CalcFields("ID No.");
            AccountToCharge := SavAcc."No.";
            MemberNo := SavAcc."Member No.";
            IDNo := SavAcc."ID No.";
            if SavAcc.Blocked <> SavAcc.Blocked::" " then
                exit;
        end;

        //xx
        if SavAcc.Get(AccountToCheck) then
            BosaEntry := false
        else begin
            BosaProduct := Bosaproduct::None;


        end;


        if (MemberNo = '') and (IDNo = '') then
            Error('Member No. Missing');

        if AccountToCharge = '' then
            Error('Account to charge missing');


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

        CoopSetup.Reset;
        //CoopSetup.SetRange("Transaction Type", CoopSetup."transaction type"::"Balance Enquiry");
        if CoopSetup.FindFirst then begin

            SMSAccount := CoopSetup."SMS Account";
            SMSCharge := CoopSetup."SMS Charge";


            SaccoAccount := CoopSetup."Sacco Fee Account";
            SaccoFee := CoopSetup."Sacco Fee";
            VendorAccount := CoopSetup."Vendor Commission Account";
            VendorCommission := CoopSetup."Vendor Commission";

            TotalCharge := SaccoFee + VendorCommission + SMSCharge;
            ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
            ExciseDuty := 0;
        end
        else begin
            //ERROR('Setup Missing for %1', CoopSetup."Transaction Type");
        end;



        if SavAcc.Get(AccountToCharge) then begin

            ProdFact.Get(SavAcc."Product Type");

            if (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::"Deposits Only") or
                (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::" ") then begin
                Error('The Account to Charge is not a Withdrawable Account');

            end;
            BalEnqCharge := 0;
            AccBal := GetAccountBalance(SavAcc."No.");
            if AccBal >= TotalCharge + ExciseDuty then begin
                BalEnqCharge := TotalCharge + ExciseDuty;
                //BUser.GET(USERID);

                //BUser.TESTFIELD("Cashier Journal Template");
                //BUser.TESTFIELD("Cashier Journal Batch");

                JTemplate := 'GENERAL';
                JBatch := 'MBANKING';

                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                GenJournalBatch.SetRange(Name, JBatch);
                if not GenJournalBatch.FindFirst then begin
                    GenJournalBatch.Init;
                    GenJournalBatch."Journal Template Name" := JTemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.Description := 'Mbanking Batch';
                    GenJournalBatch.Insert;
                end;


                MobileTrans.Init;
                MobileTrans."Entry No." := EntryCode;
                MobileTrans."Transaction ID" := TransactionID;
                MobileTrans."Session ID" := TransactionID;
                MobileTrans."Transaction Date" := Dt2Date(TransactionDate);
                MobileTrans."Transaction Time" := Dt2Time(TransactionDate);
                MobileTrans."Member Account" := SavAcc."No.";
                MobileTrans.MobileApp := true;
                MobileTrans."Transaction Type" := MobileTrans."transaction type"::"Balance Enquiry";
                MobileTrans.Description := Format(MobileTrans."Transaction Type");
                MobileTrans.Posted := true;
                MobileTrans.Insert;
                Commit;

                /*
                MobileTrans.RESET;
                MobileTrans.SETRANGE("Transaction ID",TransactionID);
                MobileTrans.SETRANGE(Posted,FALSE);
                IF MobileTrans.FINDFIRST THEN BEGIN
        
                    DocNo := MobileTrans."Transaction ID";
                    PDate := MobileTrans."Transaction Date";
                    AccNo := MobileTrans."Member Account";
                    ExtDoc := '';
                    LoanNo := '';
                    TransType := TransType::" ";
                    Dim1 := SavAcc."Global Dimension 1 Code";
                    Dim2 := SavAcc."Global Dimension 2 Code";
                    SystCreated := TRUE;
        
                    SaccoTrans.JournalInit(JTemplate,JBatch);
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR(MobileTrans.Description,1,50),BalAccType::"G/L Account",
                                  '',VendorCommission,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR(MobileTrans.Description,1,50),BalAccType::"G/L Account",
                                  '',SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccountToCharge,COPYSTR('SMS Charges ',1,50),BalAccType::"G/L Account",
                                  SMSAccount,SMSCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR('Excise Duty',1,50),BalAccType::"G/L Account",
                                  ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
        
                    AccNo := VendorAccount;
                    ExtDoc := MobileTrans."Member Account";
                    LoanNo := '';
                    TransType := TransType::" ";
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR(MobileTrans.Description+' Commission',1,50),BalAccType::"G/L Account",
                                  '',-VendorCommission,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
                    AccNo := SaccoAccount;
                    ExtDoc := MobileTrans."Member Account";
                    LoanNo := '';
                    TransType := TransType::" ";
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"G/L Account",AccNo,COPYSTR(MobileTrans.Description+' Fee',1,50),BalAccType::"G/L Account",
                                  '',-SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
        
                    MobileTrans.Posted:=TRUE;
                    MobileTrans."Posted By":=USERID;
                    MobileTrans."Date Posted":=TODAY;
                    MobileTrans.MODIFY;
        
                    SaccoTrans.JournalPost(JTemplate,JBatch);
        
                END;
                */
            end
            else begin
                Response := 'INSUFFICIENT_BAL';

                Response := '<Response>';
                Response += '<Status>INSUFFICIENT_BAL</Status>';
                Response += '<StatusDescription>Insufficient Balance</StatusDescription>';
                Response += '<Reference>' + TransactionID + '</Reference>';
                Response += '</Response>';

            end;
        end
        else begin
            Response := '<Response>';
            Response += '<Status>INVALID_ACCOUNT</Status>';
            Response += '<StatusDescription>Invalid Account</StatusDescription>';
            Response += '<Reference>' + TransactionID + '</Reference>';
            Response += '</Response>';
        end;


        if (Response = '') then begin

            BalEnqCharge := 0;
            SavAcc.Reset;
            //SavAcc.SETRANGE("Member No.",MemberNo);
            SavAcc.SetRange("No.", AccountToCheck);
            if (SavAcc.Find('-')) then begin
                Response := '<Balances>';
                repeat


                    ProdFact.Get(SavAcc."Product Type");

                    if ProdFact."Mobile Transaction" <> ProdFact."mobile transaction"::" " then begin
                        SavAcc.CalcFields("Balance (LCY)");

                        AccountBookBalance := SavAcc."Balance (LCY)";
                        AccountAvailableBalance := GetAccountBalance(SavAcc."No.");


                        if SavAcc."Mbanking Registered" then begin

                            SMSCharge := 0;

                            CoopSetup.Reset;
                            //CoopSetup.SetRange("Transaction Type", CoopSetup."transaction type"::"Mpesa Withdrawal");
                            if CoopSetup.FindFirst then begin

                                SMSCharge := CoopSetup."SMS Charge";
                                /*
                                SafcomCharges.RESET;
                                SafcomCharges.SETFILTER(Charge,'>0');
                                SafcomCharges.SETFILTER(Minimum,'<=%1',AccountAvailableBalance);
                                SafcomCharges.SETFILTER(Maximum,'>=%1',AccountAvailableBalance);
                                IF SafcomCharges.FINDFIRST THEN BEGIN
                                    SafcomFee:=SafcomCharges.Charge;
                                END;
                                */

                                SafcomFee := 0;
                                if CoopSetup."Safcom Staggered Fee" then
                                    SafcomFee := GetStaggeredSaccoFee(CoopSetup."Safcom Staggered Charge", AccountAvailableBalance);

                                SaccoFee := CoopSetup."Sacco Fee";
                                if CoopSetup."Sacco Staggered Fee" then
                                    SaccoFee := GetStaggeredSaccoFee(CoopSetup."Sacco Staggered Charge", AccountAvailableBalance);

                                VendorCommission := CoopSetup."Vendor Commission";
                                TotalCharge := SaccoFee + VendorCommission + SafcomFee + SMSCharge;
                                ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);

                                AccountBookBalance -= BalEnqCharge;
                                AccountAvailableBalance -= (BalEnqCharge + TotalCharge + ExciseDuty);
                            end;
                        end;



                        ProductName := ProdFact."USSD Product Name";
                        if ProductName = '' then
                            ProductName := ProdFact.Description;

                        Response += '<Account>';
                        Response += '<Product>' + ProductName + '</Product>';
                        //Response+='<Product>Account Balance</Product>';
                        Response += '<Date>' + Format(MobileTrans."Transaction Date") + '</Date>';
                        Response += '<BookBalance>' + Format(AccountBookBalance) + '</BookBalance>';
                        Response += '<AvailableBalance>' + Format(AccountAvailableBalance) + '</AvailableBalance>';
                        Response += '</Account>';



                    end;
                until SavAcc.Next = 0;
                Response += '</Balances>';
            end;
        end;

    end;


    procedure GetMemberLoanListMobileApp(Phone: Code[20]) Response: Text
    var
        MobileNo: Code[20];
        Loans: Record Loans;
        LoanProduct: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        MemberNo: Code[20];
        MaxLoan: Decimal;
        Found: Boolean;
    begin

        MobileNo := '+' + Phone;


        Response := '';
        Found := false;

        /*
        SavAcc.RESET;
        SavAcc.SETRANGE("Transactional Mobile No",MobileNo);
        SavAcc.SETFILTER(Status,'<>%1',SavAcc.Status::Deceased);
        IF SavAcc.FINDFIRST THEN BEGIN
        
            MemberNo := SavAcc."Member No.";
        
            LoanProduct.RESET;
            //LoanProduct.SETRANGE("Product Class Type",LoanProduct."Product Class Type"::Loan);
            IF LoanProduct.FIND('-') THEN BEGIN
                Response:='<Loans>';
                REPEAT
                    IF LoanProduct."USSD Product Name" = '' THEN
                    LoanProduct."USSD Product Name" := LoanProduct.Description;
        
                    //MaxLoan:=LoanProduct."Maximum Loan Amount";
        
        
                    Members.RESET;
                    Members.SETRANGE("ID No.",SavAcc."ID No.");
                    Members.SETFILTER("Customer Type",'%1|%2',Members."Customer Type"::Member,Members."Customer Type"::MicroFinance);
                    IF Members.FIND('-') THEN BEGIN
                        REPEAT
                            MemberNo := Members."No.";
                            Loans.RESET;
                            Loans.SETRANGE("Member No.",MemberNo);
                            Loans.SETRANGE("Loan Product Type",LoanProduct."Product ID");
                            Loans.SETFILTER("Outstanding Principal",'>0');
                            IF Loans.FINDFIRST THEN BEGIN
                                Found:=TRUE;
                                REPEAT
                                    Loans.CALCFIELDS("Outstanding Principal","Outstanding Interest");
                                    IF Loans."Outstanding Interest" <= 0 THEN
                                        Loans."Outstanding Interest" :=GetClearingLoanInterest(Loans);
        
                                    IF Loans."Outstanding Interest" < 0 THEN
                                    Loans."Outstanding Interest" := 0;
        
                                    Response += '<Product>';
                                      Response += '<LoanNo>'+Loans."Loan No."+'</LoanNo>';
                                      Response += '<ProductType>'+LoanProduct."USSD Product Name"+'</ProductType>';
                                      Response += '<LoanBalance>'+FORMAT(Loans."Outstanding Principal"+Loans."Outstanding Interest")+'</LoanBalance>';
        
                                    Response += '</Product>';
                                UNTIL Loans.NEXT=0;
                            END;
        
                        UNTIL Members.NEXT=0;
                    END;
        
                UNTIL LoanProduct.NEXT=0;
                Response+='</Loans>';
        
            END;
        
        END;
        */

        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", MobileNo);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin

            MemberNo := SavAcc."Member No.";

            Response := '<Loans>';

            Members.Reset;
            Members.SetRange("No.", SavAcc."Member No.");
            if Members.Find('-') then begin
                repeat
                    MemberNo := Members."No.";
                    Loans.Reset;
                    Loans.SetRange("Member No.", MemberNo);
                    Loans.SetFilter("Outstanding Principal", '>0');
                    if Loans.FindFirst then begin
                        Found := true;
                        repeat
                            Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
                            LoanProduct.Get(Loans."Loan Product Type");
                            if Loans."Outstanding Interest" <= 0 then
                                Loans."Outstanding Interest" := GetClearingLoanInterest(Loans);

                            if Loans."Outstanding Interest" < 0 then
                                Loans."Outstanding Interest" := 0;

                            if LoanProduct."USSD Product Name" = '' then
                                LoanProduct."USSD Product Name" := LoanProduct.Description;

                            Response += '<Product>';
                            Response += '<LoanNo>' + Loans."Loan No." + '</LoanNo>';
                            Response += '<ProductType>' + LoanProduct.Description + '</ProductType>';
                            Response += '<LoanBalance>' + Format(Loans."Outstanding Principal" + Loans."Outstanding Interest") + '</LoanBalance>';

                            Response += '</Product>';

                        until Loans.Next = 0;
                    end;

                until Members.Next = 0;
            end;

            Response += '</Loans>';

        end;



        if not Found then
            Response := '';

    end;


    procedure AccountMiniStatementMobileApp(EntryCode: Text; TransactionID: Code[20]; MaxNumberRows: Integer; StartDate: Date; EndDate: Date; StatementAccount: Code[20]; MobileNo: Code[20]; Pin: Text) Response: Text
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        PhoneNo: Code[20];
        AccBal: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        MobileTrans: Record "Sky Transactions.";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        SLedger: Record "Savings Ledger Entry";
        LedgerCount: Integer;
        CurrRecord: Integer;
        DFilter: Text;
        DebitCreditFlag: Code[10];
        FirstEntry: Boolean;
        ProdFact: Record "Product Setup";
        TransactionDate: DateTime;
        Msg: Text;
        Stmt: Text;
        AccountToCharge: Code[20];
        MemberNo: Code[20];
        RCount: Integer;
        MemLedger: Record "Credit Ledger Entry";
        ReturnFosa: Boolean;
        Members: Record Members;
    begin
        ReturnFosa := true;
        TransactionDate := CurrentDatetime;
        MobileNo := '+' + MobileNo;

        Response := '';

        if not CorrectPin(MobileNo, Pin) then begin
            Response := 'INCORRECT_PIN';
            Response := '<Response>';
            Response += '<Status>INCORRECT_PIN</Status>';
            Response += '<StatusDescription>Incorrect PIN</StatusDescription>';
            Response += '<Reference>' + TransactionID + '</Reference>';
            Response += '</Response>';
            exit;
        end;

        Members.Reset;
        Members.SetRange("No.", StatementAccount);
        if Members.FindFirst then begin
            Response := 'SUCCESS';
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

        MemberNo := '';
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", MobileNo);
        if SavAcc.FindFirst then
            MemberNo := SavAcc."Member No.";

        if SavAcc.Blocked <> SavAcc.Blocked::" " then
            exit;

        AccountToCharge := '';



        SavAcc.Reset;
        SavAcc.SetRange("Member No.", MemberNo);
        SavAcc.SetFilter("Transactional Mobile No", '<>%1', '');
        if SavAcc.FindFirst then
            AccountToCharge := SavAcc."No.";

        SMSAccount := '';
        SMSCharge := 0;

        CoopSetup.Reset;
        //CoopSetup.SetRange("Transaction Type", CoopSetup."transaction type"::"Mini-Statement");
        if CoopSetup.FindFirst then begin

            SMSAccount := CoopSetup."SMS Account";
            SMSCharge := CoopSetup."SMS Charge";

            SaccoAccount := CoopSetup."Sacco Fee Account";
            SaccoFee := CoopSetup."Sacco Fee";
            VendorAccount := CoopSetup."Vendor Commission Account";
            VendorCommission := CoopSetup."Vendor Commission";

            TotalCharge := SaccoFee + VendorCommission + SMSCharge;
            ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
        end
        else begin
            //ERROR('Setup Missing for %1', CoopSetup."Transaction Type");
        end;


        //PhoneNo:='+'+MobileNo;

        SavAcc.Reset;
        SavAcc.SetRange("No.", AccountToCharge);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin


            ProdFact.Get(SavAcc."Product Type");

            if (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::"Deposits Only") or
                (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::" ") then begin
                Error('The Account to Charge is not a Withdrawable Account');
            end;



            AccBal := GetAccountBalance(SavAcc."No.");
            if AccBal >= TotalCharge + ExciseDuty then begin

                //BUser.GET(USERID);

                //BUser.TESTFIELD("Cashier Journal Template");
                //BUser.TESTFIELD("Cashier Journal Batch");

                JTemplate := 'GENERAL';
                JBatch := 'MBANKING';

                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                GenJournalBatch.SetRange(Name, JBatch);
                if not GenJournalBatch.FindFirst then begin
                    GenJournalBatch.Init;
                    GenJournalBatch."Journal Template Name" := JTemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.Description := 'Mbanking Batch';
                    GenJournalBatch.Insert;
                end;


                MobileTrans.Init;
                MobileTrans."Entry No." := EntryCode;
                MobileTrans."Transaction ID" := TransactionID;
                MobileTrans."Session ID" := TransactionID;
                MobileTrans."Transaction Date" := Dt2Date(TransactionDate);
                MobileTrans."Transaction Time" := Dt2Time(TransactionDate);
                MobileTrans."Member Account" := SavAcc."No.";
                MobileTrans."Statement Max Rows" := MaxNumberRows;
                MobileTrans."Statement Start Date" := StartDate;
                MobileTrans."Statement End Date" := EndDate;
                MobileTrans.MobileApp := true;
                MobileTrans."Account to Check" := StatementAccount;
                MobileTrans."Transaction Type" := MobileTrans."transaction type"::"Mini-Statement";
                MobileTrans.Description := Format(MobileTrans."Transaction Type");
                MobileTrans.Posted := true;
                MobileTrans.Insert;
                Commit;


                /*
                MobileTrans.RESET;
                MobileTrans.SETRANGE("Transaction ID",TransactionID);
                MobileTrans.SETRANGE(Posted,FALSE);
                IF MobileTrans.FINDFIRST THEN BEGIN
        
                    DocNo := MobileTrans."Transaction ID";
                    PDate := MobileTrans."Transaction Date";
                    AccNo := MobileTrans."Member Account";
                    ExtDoc := '';
                    LoanNo := '';
                    TransType := TransType::" ";
                    Dim1 := SavAcc."Global Dimension 1 Code";
                    Dim2 := SavAcc."Global Dimension 2 Code";
                    SystCreated := TRUE;
        
        
                    SaccoTrans.JournalInit(JTemplate,JBatch);
        
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR(MobileTrans.Description,1,50),BalAccType::"G/L Account",
                                  '',VendorCommission,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccountToCharge,COPYSTR('Mbanking Charge',1,50),BalAccType::"G/L Account",
                                  SMSAccount,SMSCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR('Sacco Fee ',1,50),BalAccType::"G/L Account",
                                  '',SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR('Excise Duty ',1,50),BalAccType::"G/L Account",
                                  ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
        
                    AccNo := VendorAccount;
                    ExtDoc := MobileTrans."Member Account";
                    LoanNo := '';
                    TransType := TransType::" ";
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR(MobileTrans.Description+' Commission',1,50),BalAccType::"G/L Account",
                                  '',-VendorCommission,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
                    AccNo := SaccoAccount;
                    ExtDoc := MobileTrans."Member Account";
                    LoanNo := '';
                    TransType := TransType::" ";
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"G/L Account",AccNo,COPYSTR(MobileTrans.Description+' Fee',1,50),BalAccType::"G/L Account",
                                  '',-SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
        
                    MobileTrans.Posted:=TRUE;
                    MobileTrans."Posted By":=USERID;
                    MobileTrans."Date Posted":=TODAY;
                    MobileTrans.MODIFY;
        
                    SaccoTrans.JournalPost(JTemplate,JBatch);
        
                END
                ELSE BEGIN
                    ERROR('Transaction Not Found');
                END;
                */
            end
            else begin
                Response := 'INSUFFICIENT_BAL';

                Response := '<Response>';
                Response += '<Status>INSUFFICIENT_BAL</Status>';
                Response += '<StatusDescription>Insufficient Balance</StatusDescription>';
                Response += '<Reference>' + TransactionID + '</Reference>';
                Response += '</Response>';
                exit;
            end;


            if Response = '' then begin
                if ReturnFosa then begin
                    MobileTrans.Reset;
                    MobileTrans.SetRange("Transaction ID", TransactionID);
                    MobileTrans.SetRange(Posted, true);
                    if MobileTrans.FindFirst then begin
                        SLedger.Reset;
                        SLedger.SetCurrentkey("Entry No.");
                        SLedger.Ascending(true);
                        SLedger.SetRange("Account No.", StatementAccount);
                        SLedger.SetRange("Posting Date", StartDate, EndDate);
                        SLedger.SetRange(Reversed, false);
                        if SLedger.FindFirst then begin
                            RCount := 0;
                            AccBal := 0;
                            SavAcc.Reset;
                            SavAcc.SetRange("No.", StatementAccount);
                            SavAcc.SetRange("Date Filter", 0D, CalcDate('-1D', StartDate));
                            if SavAcc.FindFirst then begin
                                SavAcc.CalcFields("Balance (LCY)");
                                AccBal := SavAcc."Balance (LCY)";
                            end;
                            Message('OpenBal %1', AccBal);
                            Response := '<Response>';
                            repeat
                                RCount += 1;
                                SLedger.CalcFields(Amount);
                                LedgerCount += 1;
                                AccBal += (SLedger.Amount * -1);
                                Response += '<Transaction>';
                                Response += '<Date>' + Format(SLedger."Posting Date") + '</Date>';
                                Response += '<Desc>' + SLedger.Description + '</Desc>';
                                Response += '<Amount>' + Format(SLedger.Amount * -1) + '</Amount>';
                                Response += '<Reference>' + Format(SLedger."Entry No.") + '</Reference>';
                                Response += '<RunningBalance>' + Format(AccBal) + '</RunningBalance>';
                                Response += '</Transaction>';


                            until (SLedger.Next = 0) or (RCount = MaxNumberRows);

                            Response += '</Response>';
                        end;
                    end;
                end;
            end;
        end
        else begin

            Response := '<Response>';
            Response += '<Status>INVALID_ACCOUNT</Status>';
            Response += '<StatusDescription>Invalid Account</StatusDescription>';
            Response += '<Reference>' + TransactionID + '</Reference>';
            Response += '</Response>';
        end;

    end;


    procedure GetLoanLimitMobileApp(PhoneNo: Code[20]; LoanProductType: Code[20]) Response: Text
    var
        SalType: Option " ",Checkoff,"Standing Order",Salary,Milk,Tea,Coffee,Dividend,Cash,Pension,Dependant,Others,"BOM income";
        SavAcc: Record "Savings Accounts";
        PFact: Record "Product Setup";


        XMLDOMMgt: Codeunit "XML DOM Management";



        MaxLoan: Decimal;
        msg: Text;
        AccountNo: Code[20];
        QualAmt: Decimal;
        Remark: Text;
    begin

        PhoneNo := '+' + PhoneNo;

        Response := 'ERROR';
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin
            Message(SavAcc.Name);
            //MaxLoan := GetLoanQualifiedAmount(SavAcc."No.", LoanProductType);

            PFact.Get(LoanProductType);

            AccountNo := SavAcc."No.";
            QualAmt := 0;
            Remark := '';

            // if PFact."Product ID" = 'SELF GUA' then
            //GetSelfGuaranteedLoanQualification(AccountNo, LoanProductType, QualAmt, Remark);


            msg := 'Dear ' + SavAcc.Name + ', your Loan Limit for ' + PFact."USSD Product Name" + ' is KES ' + Format(MaxLoan) + '. ' + Remark;
            //SendSms(Source::SkyMobile,SavAcc."Transactional Mobile No",msg,LoanProductType,SavAcc."No.",FALSE,Priority);
            Response := msg;

        end;
    end;


    procedure LoanMiniStatementMobileApp(EntryCode: Text; TransactionID: Code[20]; MaxNumberRows: Integer; SDate: Date; EDate: Date; LoanType: Code[20]; MobileNo: Code[20]; Pin: Text) Response: Text
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        PhoneNo: Code[20];
        AccBal: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        MobileTrans: Record "Sky Transactions.";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        CLedger: Record "Credit Ledger Entry";
        LedgerCount: Integer;
        CurrRecord: Integer;
        DFilter: Text;
        DebitCreditFlag: Code[10];
        FirstEntry: Boolean;
        ProdFact: Record "Product Setup";
        TransactionDate: DateTime;
        Msg: Text;
        Stmt: Text;
        StatementAccount: Code[20];
        AccountToCharge: Code[20];
        MemberNo: Code[20];
        Loans: Record Loans;
    begin

        TransactionDate := CurrentDatetime;
        MobileNo := '+' + MobileNo;

        Response := '';

        if not CorrectPin(MobileNo, Pin) then begin
            Response := 'INCORRECT_PIN';
            Response := '<Response>';
            Response += '<Status>INCORRECT_PIN</Status>';
            Response += '<StatusDescription>Incorrect PIN</StatusDescription>';
            Response += '<Reference>' + TransactionID + '</Reference>';
            Response += '</Response>';
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

        MemberNo := '';
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", MobileNo);
        if SavAcc.FindFirst then
            MemberNo := SavAcc."Member No.";


        if SavAcc.Blocked <> SavAcc.Blocked::" " then
            exit;

        StatementAccount := '';
        AccountToCharge := '';

        Loans.Reset;
        Loans.SetRange("Loan Product Type", LoanType);
        if Loans.FindFirst then
            StatementAccount := Loans."Loan No.";

        SavAcc.Reset;
        SavAcc.SetRange("Member No.", MemberNo);
        SavAcc.SetFilter("Transactional Mobile No", '<>%1', '');
        if SavAcc.FindFirst then
            AccountToCharge := SavAcc."No.";

        SMSAccount := '';
        SMSCharge := 0;

        CoopSetup.Reset;
        //CoopSetup.SetRange("Transaction Type", CoopSetup."transaction type"::"Mini-Statement");
        if CoopSetup.FindFirst then begin

            SMSAccount := CoopSetup."SMS Account";
            SMSCharge := CoopSetup."SMS Charge";


            SaccoAccount := CoopSetup."Sacco Fee Account";
            SaccoFee := CoopSetup."Sacco Fee";
            VendorAccount := CoopSetup."Vendor Commission Account";
            VendorCommission := CoopSetup."Vendor Commission";

            TotalCharge := SaccoFee + VendorCommission + SMSCharge;
            ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
        end
        else begin
            //ERROR('Setup Missing for %1', CoopSetup."Transaction Type");
        end;


        //PhoneNo:='+'+MobileNo;

        SavAcc.Reset;
        SavAcc.SetRange("No.", AccountToCharge);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin


            ProdFact.Get(SavAcc."Product Type");

            if (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::"Deposits Only") or
                (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::" ") then begin
                Error('The Account to Charge is not a Withdrawable Account');
            end;



            AccBal := GetAccountBalance(SavAcc."No.");
            if AccBal >= TotalCharge + ExciseDuty then begin

                //BUser.GET(USERID);

                //BUser.TESTFIELD("Cashier Journal Template");
                //BUser.TESTFIELD("Cashier Journal Batch");

                JTemplate := 'GENERAL';
                JBatch := 'MBANKING';

                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                GenJournalBatch.SetRange(Name, JBatch);
                if not GenJournalBatch.FindFirst then begin
                    GenJournalBatch.Init;
                    GenJournalBatch."Journal Template Name" := JTemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.Description := 'Mbanking Batch';
                    GenJournalBatch.Insert;
                end;

                MobileTrans.Init;
                MobileTrans."Entry No." := EntryCode;
                MobileTrans."Transaction ID" := TransactionID;
                MobileTrans."Session ID" := TransactionID;
                MobileTrans."Transaction Date" := Dt2Date(TransactionDate);
                MobileTrans."Transaction Time" := Dt2Time(TransactionDate);
                MobileTrans."Member Account" := SavAcc."No.";
                MobileTrans."Statement Max Rows" := MaxNumberRows;
                //MobileTrans."Statement Start Date":=StartDate;
                //MobileTrans."Statement End Date":=EndDate;
                MobileTrans."Account to Check" := StatementAccount;
                MobileTrans.MobileApp := true;
                MobileTrans."Transaction Type" := MobileTrans."transaction type"::"Mini-Statement";
                MobileTrans.Description := Format(MobileTrans."Transaction Type");
                MobileTrans.Insert;

                /*
                MobileTrans.RESET;
                MobileTrans.SETRANGE("Transaction ID",TransactionID);
                MobileTrans.SETRANGE(Posted,FALSE);
                IF MobileTrans.FINDFIRST THEN BEGIN
        
                    DocNo := MobileTrans."Transaction ID";
                    PDate := MobileTrans."Transaction Date";
                    AccNo := MobileTrans."Member Account";
                    ExtDoc := '';
                    LoanNo := '';
                    TransType := TransType::" ";
                    Dim1 := SavAcc."Global Dimension 1 Code";
                    Dim2 := SavAcc."Global Dimension 2 Code";
                    SystCreated := TRUE;
        
                    SaccoTrans.JournalInit(JTemplate,JBatch);
        
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR(MobileTrans.Description,1,50),BalAccType::"G/L Account",
                                  '',VendorCommission,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR(MobileTrans.Description,1,50),BalAccType::"G/L Account",
                                  '',SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccountToCharge,COPYSTR('SMS Charges',1,50),BalAccType::"G/L Account",
                                  SMSAccount,SMSCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR('Excise Duty',1,50),BalAccType::"G/L Account",
                                  ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
        
                    AccNo := VendorAccount;
                    ExtDoc := MobileTrans."Member Account";
                    LoanNo := '';
                    TransType := TransType::" ";
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR(MobileTrans.Description+' Commission',1,50),BalAccType::"G/L Account",
                                  '',-VendorCommission,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
                    AccNo := SaccoAccount;
                    ExtDoc := MobileTrans."Member Account";
                    LoanNo := '';
                    TransType := TransType::" ";
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"G/L Account",AccNo,COPYSTR(MobileTrans.Description+' Fee',1,50),BalAccType::"G/L Account",
                                  '',-SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
        
                    MobileTrans.Posted:=TRUE;
                    MobileTrans."Posted By":=USERID;
                    MobileTrans."Date Posted":=TODAY;
                    MobileTrans.MODIFY;
        
                    SaccoTrans.JournalPost(JTemplate,JBatch);
        
                END
                ELSE BEGIN
                    ERROR('Transaction Not Found');
                END;
                */
            end
            else begin
                Response := 'INSUFFICIENT_BAL';

                Response := '<Response>';
                Response += '<Status>INSUFFICIENT_BAL</Status>';
                Response += '<StatusDescription>Insufficient Balance</StatusDescription>';
                Response += '<Reference>' + TransactionID + '</Reference>';
                Response += '</Response>';
                exit;

            end;


            if Response = '' then begin
                MobileTrans.Reset;
                MobileTrans.SetRange("Transaction ID", TransactionID);
                MobileTrans.SetRange(Posted, true);
                if MobileTrans.FindFirst then begin
                    Loans.Get(StatementAccount);

                    CLedger.Reset;
                    CLedger.SetCurrentkey("Entry No.");
                    CLedger.Ascending(false);
                    CLedger.SetRange("Loan No.", Loans."Loan No.");
                    CLedger.SetRange("Account No.", Loans."Member No.");
                    CLedger.SetRange("Posting Date", SDate, EDate);
                    CLedger.SetRange(Reversed, false);
                    if CLedger.FindFirst then begin
                        AccBal := 0;
                        Loans.Reset;
                        Loans.SetRange("Loan No.", StatementAccount);
                        Loans.SetRange("Date filter", 0D, CalcDate('-1D', SDate));
                        if Loans.FindFirst then begin
                            Loans.CalcFields("Outstanding Principal");
                            AccBal := Loans."Outstanding Principal";
                        end;

                        Response := '<Response>';

                        repeat
                            LedgerCount += 1;
                            if (CLedger."Transaction Type" = CLedger."transaction type"::"Loan Disbursement") or (CLedger."Transaction Type" = CLedger."transaction type"::"Principal Repayment") then
                                AccBal += (CLedger.Amount);

                            Response += '<Transaction>';
                            Response += '<Date>' + Format(CLedger."Posting Date") + '</Date>';
                            Response += '<Desc>' + CLedger.Description + '</Desc>';
                            Response += '<Amount>' + Format(CLedger.Amount) + '</Amount>';
                            Response += '<Reference>' + Format(CLedger."Entry No.") + '</Reference>';
                            Response += '<RunningBalance>' + Format(AccBal) + '</RunningBalance>';
                            Response += '</Transaction>';

                        until (CLedger.Next = 0) or (CLedger.Count = MaxNumberRows);
                        Response += '</Response>';

                        Priority := 203;
                    end;
                end;
            end;
        end
        else begin
            Response := 'INVALID_ACCOUNT';

            Response := '<Response>';
            Response += '<Status>INVALID_ACCOUNT</Status>';
            Response += '<StatusDescription>Invalid Account</StatusDescription>';
            Response += '<Reference>' + TransactionID + '</Reference>';
            Response += '</Response>';

        end;

    end;




    procedure PostSMSAlertCharges()
    var
        Blocked: Option " ",All,Credit,Debit;
        SMSALERTS: Record "Sky SMS Messages";
        saccoAccount: Record "Savings Accounts";
        Bal: Decimal;
        Docno: Code[20];
        Charges: Record "Charges.";
        TotalCharges: Decimal;
        SMSAlertsAccount: Code[20];
        JTemplate: Code[10];
        JBatch: Code[10];
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        ExtDoc: Code[20];
        SystCreated: Boolean;
        RCount: Integer;
        GenSetup: Record "Sacco Setup";
        SaccoIncomeAcc: Code[20];
    begin


        /*
     SMSALERTS.RESET;
     SMSALERTS.SETRANGE(Posted,TRUE);
     SMSALERTS.SETRANGE(Finalized,FALSE);
     SMSALERTS.SETFILTER("Account To Charge",'<>%1','');
     SMSALERTS.SETFILTER(msg_status_code,'102');
     IF SMSALERTS.FIND('-') THEN BEGIN
         SMSALERTS.MODIFYALL(Finalized,TRUE);
     END;


     // Get SMS G/L and Charge Amount
     Charges.RESET;
     Charges.SETRANGE(Charges."Transaction Type",'SMS CHARGES');
     IF Charges.FIND('-') THEN BEGIN
         Charges.TESTFIELD(Charges."G/L Account");
         TotalCharges:=Charges."Charge Amount";
     END;
     SMSALERTS.RESET;
     SMSALERTS.SETCURRENTKEY(date_created);
     SMSALERTS.SETRANGE(Finalized,FALSE);
     SMSALERTS.SETFILTER(msg_status_code,'102');
     SMSALERTS.SETRANGE("Split Charge",TRUE);
     SMSALERTS.SETFILTER("Balance (LCY)",'>=%1',TotalCharges);
     IF SMSALERTS.FIND('+') THEN BEGIN
         RCount := 0;
         GenSetup.GET;
         //REPEAT
         RCount+=1;



             Docno :=FORMAT(SMSALERTS.msg_id);
             SaccoIncomeAcc := '';

             // Get SMS G/L and Charge Amount
             Charges.RESET;
             Charges.SETRANGE(Charges."Transaction Type",'SMS CHARGES');
             IF Charges.FIND('-') THEN BEGIN
                 Charges.TESTFIELD(Charges."G/L Account");
                 TotalCharges:=Charges."Charge Amount";
             END;

             GenSetup.TESTFIELD("Sacco SMS Expense GL");
             GenSetup.TESTFIELD("Mobile Vendor Account");
             SaccoIncomeAcc := GenSetup."Sacco SMS Income GL";

             IF NOT SMSALERTS."Charge Member" THEN BEGIN

                 SMSAlertsAccount := GenSetup."Sacco SMS Expense GL";
                 JTemplate:='GENERAL';
                 JBatch:='MBANKING';
                 ExtDoc := '';

                 SaccoTrans.JournalInit(JTemplate,JBatch);
                 SystCreated:=TRUE;

                 SaccoTrans.JournalInsert(JTemplate,JBatch,Docno,TODAY,AcctType::Vendor,GenSetup."Mobile Vendor Account",COPYSTR('SMS Alert - '+FORMAT(SMSALERTS.msg_id),1,50),BalAccType::"G/L Account",
                       SMSAlertsAccount,-TotalCharges,ExtDoc,'',TransType,saccoAccount."Global Dimension 1 Code",saccoAccount."Global Dimension 2 Code",SystCreated,saccoAccount.Name);

                 SMSALERTS.Posted:=TRUE;
                 SMSALERTS.Finalized := TRUE;
                 SMSALERTS.MODIFY;

                 SaccoTrans.JournalPost(JTemplate,JBatch);

             END
             ELSE BEGIN

                 SMSAlertsAccount := GenSetup."Mobile Vendor Account";
                 saccoAccount.RESET;
                 saccoAccount.SETRANGE(saccoAccount."No.",SMSALERTS."Account To Charge");
                 IF saccoAccount.FIND('-') THEN BEGIN

                     Bal := GetAccountBalance(saccoAccount."No.");

                     IF Bal >= TotalCharges THEN BEGIN

                         Blocked:=Blocked::" ";
                         IF saccoAccount.Blocked<>saccoAccount.Blocked::" " THEN BEGIN
                             Blocked:=saccoAccount.Blocked;
                             saccoAccount.Blocked:=saccoAccount.Blocked::" ";
                             saccoAccount.MODIFY;
                         END;


                         JTemplate:='GENERAL';
                         JBatch:='MBANKING';
                         ExtDoc := '';

                         SaccoTrans.JournalInit(JTemplate,JBatch);
                         SystCreated:=TRUE;


                         SaccoTrans.JournalInsert(JTemplate,JBatch,Docno,TODAY,AcctType::Vendor,saccoAccount."No.",COPYSTR('SMS Alert',1,50),BalAccType::"G/L Account",
                               '',TotalCharges,ExtDoc,'',TransType,saccoAccount."Global Dimension 1 Code",saccoAccount."Global Dimension 2 Code",SystCreated,saccoAccount.Name);
                         IF NOT SMSALERTS."Split Charge" THEN BEGIN

                             SaccoTrans.JournalInsert(JTemplate,JBatch,Docno,TODAY,AcctType::Vendor,GenSetup."Mobile Vendor Account",COPYSTR('SMS Alert',1,50),BalAccType::"G/L Account",
                                   '',-TotalCharges,ExtDoc,'',TransType,saccoAccount."Global Dimension 1 Code",saccoAccount."Global Dimension 2 Code",SystCreated,saccoAccount.Name);
                         END
                         ELSE BEGIN
                           GenSetup.TESTFIELD("Vendor SMS Split Amount");
                           GenSetup.TESTFIELD("Sacco SMS Income GL");
                             SaccoTrans.JournalInsert(JTemplate,JBatch,Docno,TODAY,AcctType::Vendor,GenSetup."Mobile Vendor Account",COPYSTR('SMS Alert',1,50),BalAccType::"G/L Account",
                                   '',-(GenSetup."Vendor SMS Split Amount"),ExtDoc,'',TransType,saccoAccount."Global Dimension 1 Code",saccoAccount."Global Dimension 2 Code",SystCreated,saccoAccount.Name);

                             SaccoTrans.JournalInsert(JTemplate,JBatch,Docno,TODAY,AcctType::"G/L Account",GenSetup."Sacco SMS Income GL",COPYSTR('SMS Alert',1,50),BalAccType::"G/L Account",
                                   '',-(TotalCharges-GenSetup."Vendor SMS Split Amount"),ExtDoc,'',TransType,saccoAccount."Global Dimension 1 Code",saccoAccount."Global Dimension 2 Code",SystCreated,saccoAccount.Name);

                         END;

                         SMSALERTS.Posted:=TRUE;
                         SMSALERTS.Finalized := TRUE;
                         SMSALERTS.MODIFY;

                         SaccoTrans.JournalPost(JTemplate,JBatch);



                         IF Blocked<>saccoAccount.Blocked THEN BEGIN
                             saccoAccount.Blocked:=Blocked;
                             saccoAccount.MODIFY;
                         END;
                     END;

                 END
                 ELSE BEGIN
                         SMSALERTS.Posted:=TRUE;
                         SMSALERTS.Finalized := TRUE;
                         SMSALERTS.MODIFY;
                 END;
             END;

         //UNTIL (SMSALERTS.NEXT =0) OR (RCount>=10);
     END;
     */

    end;


    procedure CallServiceFunction(i: Integer)
    var
        TestDate: Date;
        SkyTransactions: Record "Sky Transactions.";
        MobileLoan: Record "Sky Mobile Loans";
        RandNo: Integer;
        Loans: Record Loans;
        SavAcc: Record "Savings Accounts";
        SpotCash: Codeunit "SpotCash Mbanking";
        j: Integer;
        MZawadi: Codeunit MZawadi;
        GenSetup: Record "Sacco Setup";
        Stop: Boolean;
    begin
        //i:=10000;
        RandNo := Random(9);


        if not GenSetup."Pause Defaulter Offset" then RecoverDefaultedLoans;

        case i of
            1:
                begin

                    SkyTransactions.Reset;
                    if RandNo MOD 2 = 0 then
                        SkyTransactions.Ascending(false)
                    else
                        SkyTransactions.Ascending(false);
                    SkyTransactions.SetRange(Posted, false);
                    SkyTransactions.SetRange("Needs Change", true);
                    if SkyTransactions.Find('-') then begin
                        repeat

                            if SkyTransactions."Transaction Type" = SkyTransactions."transaction type"::"Loan Repayment" then begin

                                if SkyTransactions."Loan No." <> '' then begin

                                    if Loans.Get(SkyTransactions."Loan No.") then begin
                                        SavAcc.Reset;
                                        SavAcc.SetRange("Member No.", Loans."Member No.");
                                        SavAcc.SetFilter("Transactional Mobile No", '<>%1', '');
                                        if SavAcc.FindFirst then begin
                                            SkyTransactions.Description := 'Loan Repayment ' + SkyTransactions."Member Account";
                                            SkyTransactions."Member Account" := SavAcc."No.";
                                            SkyTransactions."Loan No." := Loans."Loan No.";
                                            SkyTransactions."Transaction Type" := SkyTransactions."transaction type"::"Loan Repayment";
                                            SkyTransactions."Needs Change" := false;
                                            SkyTransactions.Modify;
                                        end;
                                    end;
                                end;
                            end;
                            if SkyTransactions."Transaction Type" = SkyTransactions."transaction type"::Paybill then begin

                                if Loans.Get(SkyTransactions."Member Account") then begin
                                    SavAcc.Reset;
                                    SavAcc.SetRange("Member No.", Loans."Member No.");
                                    SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Ordinary Savings");
                                    if SavAcc.FindFirst then begin
                                        SkyTransactions.Description := 'Loan Repayment ' + SkyTransactions."Member Account";
                                        SkyTransactions."Member Account" := SavAcc."No.";
                                        SkyTransactions."Loan No." := Loans."Loan No.";
                                        SkyTransactions."Transaction Type" := SkyTransactions."transaction type"::"Loan Repayment";
                                        SkyTransactions."Needs Change" := false;
                                        SkyTransactions.Modify;
                                    end;
                                end
                                else begin
                                    if SkyTransactions."Member Account" <> '' then begin

                                        Loans.Reset();
                                        Loans.SetRange("Loan Account", SkyTransactions."Member Account");
                                        Loans.setfilter("Outstanding Principal", '>0');
                                        if Loans.FindFirst() then begin
                                            SavAcc.Reset;
                                            SavAcc.SetRange("Member No.", Loans."Member No.");
                                            SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Ordinary Savings");
                                            if SavAcc.FindFirst then begin
                                                SkyTransactions.Description := 'Loan Repayment ' + SkyTransactions."Member Account";
                                                SkyTransactions."Member Account" := SavAcc."No.";
                                                SkyTransactions."Loan No." := Loans."Loan No.";
                                                SkyTransactions."Transaction Type" := SkyTransactions."transaction type"::"Loan Repayment";
                                                SkyTransactions."Needs Change" := false;
                                                SkyTransactions.Modify;
                                            end;
                                        end;
                                    end
                                end;
                            end;


                        until SkyTransactions.Next = 0;
                    end;




                    SkyTransactions.Reset;
                    SkyTransactions.SetRange(Posted, false);
                    SkyTransactions.SetRange("Needs Change", true);
                    SkyTransactions.setfilter("Loan No.", '<>%1', '');
                    SkyTransactions.SetRange("Transaction Type", SkyTransactions."transaction type"::"Loan Repayment");
                    if SkyTransactions.Find('-') then begin
                        repeat

                            if SkyTransactions."Transaction Type" = SkyTransactions."transaction type"::"Loan Repayment" then begin

                                if SkyTransactions."Loan No." <> '' then begin

                                    if Loans.Get(SkyTransactions."Loan No.") then begin
                                        SavAcc.Reset;
                                        SavAcc.SetRange("Member No.", Loans."Member No.");
                                        SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Ordinary Savings");
                                        if SavAcc.FindFirst then begin
                                            SkyTransactions.Description := 'Loan Repayment ' + SkyTransactions."Member Account";
                                            SkyTransactions."Member Account" := SavAcc."No.";
                                            SkyTransactions."Loan No." := Loans."Loan No.";
                                            SkyTransactions."Transaction Type" := SkyTransactions."transaction type"::"Loan Repayment";
                                            SkyTransactions."Needs Change" := false;
                                            SkyTransactions.Modify;
                                        end;
                                    end;
                                end;
                            end;
                        until SkyTransactions.next = 0;
                    end;


                    SkyTransactions.Reset;
                    if RandNo MOD 2 = 0 then
                        SkyTransactions.Ascending(false)
                    else
                        SkyTransactions.Ascending(false);
                    SkyTransactions.SetRange(Posted, false);
                    SkyTransactions.SetRange("Needs Change", false);
                    SkyTransactions.SetFilter("Transaction ID", '<>%1', '');
                    if SkyTransactions.Find('-') then begin
                        repeat
                            PostMpesaTransaction(SkyTransactions."Transaction ID");
                        until SkyTransactions.Next = 0;
                    end;
                    Commit;
                    //GetUnsentSMS;
                end;
            2:
                begin

                    MobileLoan.Reset;
                    if RandNo MOD 2 = 0 then
                        MobileLoan.Ascending(false)
                    else
                        MobileLoan.Ascending(false);

                    //MobileLoan.SETRANGE("Entry No",1);
                    MobileLoan.SetRange(Status, MobileLoan.Status::Pending);
                    MobileLoan.SetRange(Posted, false);
                    MobileLoan.SetRange(Deactivated, false);
                    MobileLoan.SetRange("Mobile Loan", MobileLoan."Mobile Loan"::Yes);
                    if MobileLoan.Find('-') then begin
                        repeat
                            ProcessMobileLoan(MobileLoan."Entry No", Stop);
                        until MobileLoan.Next = 0;
                    end;
                    Commit;

                    //GetUnsentSMS;
                    //SendMbankingSMS;

                end;
            3:
                begin
                    GetUnsentSMS;
                    SendMbankingSMS;
                    //Mzawadi.RewardReferal();
                end;
            4:
                begin
                    //CODEUNIT.RUN(39005495);
                    //ClearFuuza();
                    //PostFuuzaInterest(Today, '');
                    //CalcFuuzaInterest('', Today);
                end;


        end;


        //for j := 1 to 100 do
        //  UpdateFosaAccounts;
        //ClearMbankingSuspension;
        //UpdateLoanAccounts;

        //RecoverDefaultedLoans;
        //PostPendingCharges;
        SpotCash.ClearTransactions;
        SpotCash.PostTransactions;

    end;



    procedure UpdateLoanAccounts()
    var
        SkyTransactions: Record "Sky Transactions.";
        MobileLoan: Record "Sky Mobile Loans";
        RandNo: Integer;
        Loans: Record Loans;
        SavAcc: Record "Savings Accounts";
        j: integer;
    begin
        //i:=10000;
        RandNo := Random(9);



        Loans.Reset();
        Loans.SetRange("Loan Product Type", 'L43');
        Loans.SetFilter("Repay Mode", '<>%1', Loans."Repay Mode"::Dividends);
        if Loans.FindFirst() then begin
            repeat
                Loans."Repay Mode" := Loans."Repay Mode"::Dividends;
                Loans.Modify();
            until (Loans.next = 0);
        end;


        j := 0;
        Loans.Reset();
        Loans.SetRange("Loan Account", '');
        if Loans.FindFirst() then begin
            repeat
                j += 1;
                Loans."Loan Account" := Loans."Loan Product Type" + '-' + Loans."Member No.";
                Loans.Modify();
                Commit();

            until (Loans.next = 0) or (j > 400);
        end;

        j := 0;
        Loans.Reset();
        Loans.Setfilter("Loan Account", '*_*');
        if Loans.FindFirst() then begin
            repeat
                j += 1;
                Loans."Loan Account" := Loans."Loan Product Type" + '-' + Loans."Member No.";
                Loans.Modify();
                Commit();

            until (Loans.next = 0) or (j > 400);
        end;



        SkyTransactions.Reset;
        if RandNo MOD 2 = 0 then
            SkyTransactions.Ascending(false)
        else
            SkyTransactions.Ascending(false);
        SkyTransactions.SetRange(Posted, false);
        SkyTransactions.SetRange("Needs Change", true);
        if SkyTransactions.Find('-') then begin
            repeat

                if SkyTransactions."Transaction Type" = SkyTransactions."transaction type"::"Loan Repayment" then begin

                    if SkyTransactions."Loan No." <> '' then begin

                        if Loans.Get(SkyTransactions."Loan No.") then begin
                            SavAcc.Reset;
                            SavAcc.SetRange("Member No.", Loans."Member No.");
                            SavAcc.SetFilter("Product Category", '%1|%2', SavAcc."Product Category"::"Ordinary Savings", SavAcc."Product Category"::Business);
                            if SavAcc.FindFirst then begin
                                SkyTransactions.Description := 'Loan Repayment ' + SkyTransactions."Member Account";
                                SkyTransactions."Member Account" := SavAcc."No.";
                                SkyTransactions."Loan No." := Loans."Loan No.";
                                SkyTransactions."Transaction Type" := SkyTransactions."transaction type"::"Loan Repayment";
                                SkyTransactions."Needs Change" := false;
                                SkyTransactions.Modify;
                            end;
                        end;
                    end;
                end;
                if SkyTransactions."Transaction Type" = SkyTransactions."transaction type"::Paybill then begin

                    if Loans.Get(SkyTransactions."Member Account") then begin
                        SavAcc.Reset;
                        SavAcc.SetRange("Member No.", Loans."Member No.");
                        SavAcc.SetFilter("Product Category", '%1|%2', SavAcc."Product Category"::"Ordinary Savings", SavAcc."Product Category"::Business);
                        if SavAcc.FindFirst then begin
                            SkyTransactions.Description := 'Loan Repayment ' + SkyTransactions."Member Account";
                            SkyTransactions."Member Account" := SavAcc."No.";
                            SkyTransactions."Loan No." := Loans."Loan No.";
                            SkyTransactions."Transaction Type" := SkyTransactions."transaction type"::"Loan Repayment";
                            SkyTransactions."Needs Change" := false;
                            SkyTransactions.Modify;
                        end;
                    end
                    else begin
                        if SkyTransactions."Member Account" <> '' then begin

                            Loans.Reset();
                            Loans.SetRange("Loan Account", SkyTransactions."Member Account");
                            Loans.setfilter("Outstanding Principal", '>0');
                            if Loans.FindFirst() then begin
                                SavAcc.Reset;
                                SavAcc.SetRange("Member No.", Loans."Member No.");
                                SavAcc.SetFilter("Product Category", '%1|%2', SavAcc."Product Category"::"Ordinary Savings", SavAcc."Product Category"::Business);
                                if SavAcc.FindFirst then begin
                                    SkyTransactions.Description := 'Loan Repayment ' + SkyTransactions."Member Account";
                                    SkyTransactions."Member Account" := SavAcc."No.";
                                    SkyTransactions."Loan No." := Loans."Loan No.";
                                    SkyTransactions."Transaction Type" := SkyTransactions."transaction type"::"Loan Repayment";
                                    SkyTransactions."Needs Change" := false;
                                    SkyTransactions.Modify;
                                end;
                            end;
                        end
                    end;
                end;


            until SkyTransactions.Next = 0;
        end;




        SkyTransactions.Reset;
        SkyTransactions.SetRange(Posted, false);
        SkyTransactions.SetRange("Needs Change", true);
        SkyTransactions.setfilter("Loan No.", '<>%1', '');
        SkyTransactions.SetRange("Transaction Type", SkyTransactions."transaction type"::"Loan Repayment");
        if SkyTransactions.Find('-') then begin
            repeat

                if SkyTransactions."Transaction Type" = SkyTransactions."transaction type"::"Loan Repayment" then begin

                    if SkyTransactions."Loan No." <> '' then begin

                        if Loans.Get(SkyTransactions."Loan No.") then begin
                            SavAcc.Reset;
                            SavAcc.SetRange("Member No.", Loans."Member No.");
                            SavAcc.SetFilter("Product Category", '%1|%2', SavAcc."Product Category"::"Ordinary Savings", SavAcc."Product Category"::Business);
                            if SavAcc.FindFirst then begin
                                SkyTransactions.Description := 'Loan Repayment ' + SkyTransactions."Member Account";
                                SkyTransactions."Member Account" := SavAcc."No.";
                                SkyTransactions."Loan No." := Loans."Loan No.";
                                SkyTransactions."Transaction Type" := SkyTransactions."transaction type"::"Loan Repayment";
                                SkyTransactions."Needs Change" := false;
                                SkyTransactions.Modify;
                            end;
                        end;
                    end;
                end;
            until SkyTransactions.next = 0;
        end;



    end;


    procedure PortalPinReset(MobileNo: Code[30]) Response: Text
    var
        SkyAuth: Record "Sky USSD Auth";
        SavAcc: Record "Savings Accounts";
    begin
        MobileNo := '+' + MobileNo;

        Response := 'ERROR';

        SkyAuth.Reset;
        SkyAuth.SetRange(SkyAuth."Mobile No.", MobileNo);
        if SkyAuth.FindFirst then begin

            SavAcc.Reset;
            SavAcc.SetRange("Transactional Mobile No", MobileNo);
            SavAcc.SetRange(Blocked, SavAcc.Blocked::" ");
            if not SavAcc.FindFirst then begin
                Response := 'BLOCKED';
                exit;
            end;

            SavAcc.Reset;
            SavAcc.SetRange("Transactional Mobile No", MobileNo);
            SavAcc.SetRange(Status, SavAcc.Status::Deceased);
            if SavAcc.FindFirst then begin
                Response := 'DECEASED';
                exit;
            end;

            if (SkyAuth."User Status" = SkyAuth."user status"::Inactive) or (SkyAuth."User Status" = SkyAuth."user status"::" ") then
                Response := 'BLOCKED'
            else begin

                SkyAuth."Reset PIN" := true;
                SkyAuth.Modify;
                Commit;
                PinReset;
                Response := 'SUCCESS'
            end;


        end
        else begin
            Response := 'NOT_FOUND';
        end;
    end;


    procedure DeactivateMobileApp(MobileNo: Code[30]) Response: Text
    var
        SkyAuth: Record "Sky USSD Auth";
        SavAcc: Record "Savings Accounts";
    begin
        MobileNo := '+' + MobileNo;

        Response := 'ERROR';

        SkyAuth.Reset;
        SkyAuth.SetRange(SkyAuth."Mobile No.", MobileNo);
        if SkyAuth.FindFirst then begin

            SkyAuth.IMEI := '';
            SkyAuth."Mobile App Activated" := false;
            SkyAuth.Modify;
            Response := 'SUCCESS';

        end
        else begin
            Response := 'NOT_FOUND';
        end;
    end;


    procedure CheckBlackList(PhoneNo: Code[20]; AcctNo: Code[20]; IDNo: Text): Boolean
    var
        BPhoneNos: Record "Sky Black-Listed Phone Nos";
        BAccountNos: Record "Sky Black-Listed Account Nos";
        BNames: Record "Sky Black-Listed ID Nos";
    begin

        if PhoneNo <> '' then begin
            if BPhoneNos.Get(PhoneNo) then
                if BPhoneNos."Black-Listed" then
                    exit(true);
        end;



        if AcctNo <> '' then begin
            if BAccountNos.Get(AcctNo) then
                if BAccountNos."Black-Listed" then
                    exit(true);
        end;



        if IDNo <> '' then begin
            if BNames.Get(IDNo) then
                if BNames."Black-Listed" then
                    exit(true);
        end;

        exit(false);
    end;


    procedure CheckLinkHealth() Response: Text
    begin
        Response := 'OK';
    end;


    procedure MobileAppLogin(TransactionID: Code[20]; MobileNo: Code[20]) Response: Text
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        PhoneNo: Code[20];
        AccBal: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        MobileTrans: Record "Sky Transactions.";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        SLedger: Record "Savings Ledger Entry";
        LedgerCount: Integer;
        CurrRecord: Integer;
        DFilter: Text;
        DebitCreditFlag: Code[10];
        FirstEntry: Boolean;
        ProdFact: Record "Product Setup";
        TransactionDate: DateTime;
        Msg: Text;
        Stmt: Text;
        AccountToCharge: Code[20];
        MemberNo: Code[20];
        EntryCode: Guid;
    begin

        EntryCode := Format(CreateGuid);
        TransactionDate := CurrentDatetime;

        Response := 'ERROR';


        // Get Excise duty G/L
        ExciseDutyGL := GetExciseDutyGL();
        ExciseDutyRate := GetExciseRate();
        ExciseDuty := 0;

        SaccoAccount := '';
        SaccoFee := 0;
        VendorAccount := '';
        VendorCommission := 0;

        MemberNo := '';

        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", MobileNo);
        if SavAcc.FindFirst then
            MemberNo := SavAcc."Member No.";

        //MESSAGE(MemberNo);
        if SavAcc.Blocked <> SavAcc.Blocked::" " then
            exit;

        AccountToCharge := '';

        SavAcc.Reset;
        SavAcc.SetRange("Member No.", MemberNo);
        SavAcc.SetFilter("Transactional Mobile No", '<>%1', '');
        if SavAcc.FindFirst then
            AccountToCharge := SavAcc."No.";
        //MESSAGE(AccountToCharge);
        SMSAccount := '';
        SMSCharge := 0;

        CoopSetup.Reset;
        //CoopSetup.SetRange("Transaction Type", CoopSetup."transaction type"::"Mobile App Login");
        if CoopSetup.FindFirst then begin

            SMSAccount := CoopSetup."SMS Account";
            SMSCharge := CoopSetup."SMS Charge";


            SaccoAccount := CoopSetup."Sacco Fee Account";
            SaccoFee := CoopSetup."Sacco Fee";
            VendorAccount := CoopSetup."Vendor Commission Account";
            VendorCommission := CoopSetup."Vendor Commission";

            TotalCharge := SaccoFee + VendorCommission + SMSCharge;
            ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
        end
        else begin
            //ERROR('Setup Missing for %1', CoopSetup."Transaction Type");
        end;


        //PhoneNo:='+'+MobileNo;

        SavAcc.Reset;
        SavAcc.SetRange("No.", AccountToCharge);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin


            ProdFact.Get(SavAcc."Product Type");

            if (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::"Deposits Only") or
                (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::" ") then begin
                Error('The Account to Charge is not a Withdrawable Account');
            end;



            AccBal := GetAccountBalance(SavAcc."No.");
            if AccBal >= TotalCharge + ExciseDuty then begin

                //BUser.GET(USERID);

                //BUser.TESTFIELD("Cashier Journal Template");
                //BUser.TESTFIELD("Cashier Journal Batch");

                JTemplate := 'GENERAL';
                JBatch := 'MBANKING';

                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                GenJournalBatch.SetRange(Name, JBatch);
                if not GenJournalBatch.FindFirst then begin
                    GenJournalBatch.Init;
                    GenJournalBatch."Journal Template Name" := JTemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.Description := 'Mbanking Batch';
                    GenJournalBatch.Insert;
                end;


                MobileTrans.Init;
                MobileTrans."Entry No." := TransactionID;
                MobileTrans."Transaction ID" := 'L_' + TransactionID;
                MobileTrans."Session ID" := TransactionID;
                MobileTrans."Transaction Date" := Dt2Date(TransactionDate);
                MobileTrans."Transaction Time" := Dt2Time(TransactionDate);
                MobileTrans."Member Account" := SavAcc."No.";
                //MobileTrans."Statement Max Rows":=MaxNumberRows;
                //MobileTrans."Statement Start Date":=StartDate;
                //MobileTrans."Statement End Date":=EndDate;
                //MobileTrans."Account to Check":=StatementAccount;
                MobileTrans."Transaction Type" := MobileTrans."transaction type"::"Mobile App Login";
                MobileTrans.Description := Format(MobileTrans."Transaction Type");
                MobileTrans.Insert;
                Response := 'ACTIVE';
                /*
                MobileTrans.RESET;
                MobileTrans.SETRANGE("Transaction ID",TransactionID);
                MobileTrans.SETRANGE(Posted,FALSE);
                IF MobileTrans.FINDFIRST THEN BEGIN
        
                    DocNo := MobileTrans."Transaction ID";
                    PDate := MobileTrans."Transaction Date";
                    AccNo := MobileTrans."Member Account";
                    ExtDoc := '';
                    LoanNo := '';
                    TransType := TransType::" ";
                    Dim1 := SavAcc."Global Dimension 1 Code";
                    Dim2 := SavAcc."Global Dimension 2 Code";
                    SystCreated := TRUE;
        
                    SaccoTrans.JournalInit(JTemplate,JBatch);
        
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR(MobileTrans.Description,1,50),BalAccType::"G/L Account",
                                  '',VendorCommission,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccountToCharge,COPYSTR('SMS Charges',1,50),BalAccType::"G/L Account",
                                  SMSAccount,SMSCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR('Sacco Fee ',1,50),BalAccType::"G/L Account",
                                  '',SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR('Excise Duty ',1,50),BalAccType::"G/L Account",
                                  ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
        
                    AccNo := VendorAccount;
                    ExtDoc := MobileTrans."Member Account";
                    LoanNo := '';
                    TransType := TransType::" ";
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccNo,COPYSTR(MobileTrans.Description+' Commission',1,50),BalAccType::"G/L Account",
                                  '',-VendorCommission,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
                    AccNo := SaccoAccount;
                    ExtDoc := MobileTrans."Member Account";
                    LoanNo := '';
                    TransType := TransType::" ";
        
                    SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"G/L Account",AccNo,COPYSTR(MobileTrans.Description+' Fee',1,50),BalAccType::"G/L Account",
                                  '',-SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MobileTrans."Member Name");
        
        
                    MobileTrans.Posted:=TRUE;
                    MobileTrans."Posted By":=USERID;
                    MobileTrans."Date Posted":=TODAY;
                    MobileTrans.MODIFY;
        
                    SaccoTrans.JournalPost(JTemplate,JBatch);
        
                END
                ELSE BEGIN
                    ERROR('Transaction Not Found');
                END;
                */

            end
            else begin
                Response := 'INSUFFICIENT_BAL';
            end;

        end
        else begin
            Response := 'INVALID_ACCOUNT';
        end;

    end;


    procedure MobileLoanLimit_OLD(PhoneNo: Code[20]; LoanProductType: Code[20]) Limit: Decimal
    var
        vendor: Record "Savings Accounts";
        memberno: Code[20];
        MinimumSalary: Decimal;
        NetSalary1: Decimal;
        NetSalary2: Decimal;
        NetSalary3: Decimal;
        NoOfMonths: Integer;
        Vdet: Record "Savings Ledger Entry";
        salCount: Integer;
        averageSal: Decimal;
        amountQualified: Decimal;
        ExistingLoanAmount: Decimal;
        Custdet: Record "Credit Ledger Entry";
        SalFound: Boolean;
        Continue: Boolean;
        Loans: Record Loans;
        Member: Record Members;
    begin


        memberno := '';
        Limit := 0;

        if (LoanProductType <> 'WN') and (LoanProductType <> 'SA') then
            exit;

        vendor.Reset;
        vendor.SetRange(vendor."Transactional Mobile No", PhoneNo);
        if vendor.Find('-') then begin

            memberno := vendor."Member No.";

            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Check if salary passes through FOSA ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            if (vendor."Salary Processing" = false) then begin
                Message('Salary not passing through FOSA');
                Limit := 0;
                exit;

            end;
            vendor.CalcFields(vendor."Balance (LCY)", vendor."ATM Balance");

            if GetAccountBalance(vendor."No.") < 0 then begin
                Message('Account is overdrawn');
                Limit := 0;
                exit;
            end;


            MinimumSalary := 0;
            NetSalary1 := 0;
            NetSalary2 := 0;
            NetSalary3 := 0;
            NoOfMonths := 1;

            Vdet.Reset;
            Vdet.SetRange(Vdet.Description, 'Salary');
            Vdet.SetRange(Vdet."Account No.", vendor."No.");
            Vdet.SetFilter("Posting Date", '>%1', CalcDate('-105D', Today));
            Vdet.Ascending(false);
            if Vdet.Find('-') then
                repeat
                    salCount += 1;
                    MinimumSalary += ROUND(Vdet.Amount * -1, 1);  //3 Months salary
                until (Vdet.Next = 0) or (salCount = 3);

            if (salCount < 3) then begin
                Message('Salary not passed through FOSA for 3 months');
                Limit := 0;
                exit;
            end;

            averageSal := ROUND((MinimumSalary / 3), 1);

            amountQualified := 0;
            /*
            IF LoanProductType = 'WN' THEN BEGIN
                MsaccoLoanPars.RESET;
                MsaccoLoanPars.SETRANGE("Parameter Code", 'SALARY');
                IF MsaccoLoanPars.FIND('-') THEN BEGIN
                    REPEAT
                        IF (averageSal > MsaccoLoanPars."Minimum Amount") AND (averageSal < MsaccoLoanPars."Maximum Amount") THEN BEGIN
                            amountQualified := MsaccoLoanPars."Qualified Amount";
                            Continue := TRUE;
                        END;
                    UNTIL (MsaccoLoanPars.NEXT = 0) OR (Continue = TRUE);
                END;
            END;
             */
            if LoanProductType = 'SA' then begin
                amountQualified := averageSal;
            end;
            //MESSAGE('Amount qualified '+FORMAT(amountQualified));


            ExistingLoanAmount := 0;

            Loans.Reset;
            Loans.SetRange(Loans."Member No.", vendor."No.");
            Loans.SetRange(Loans."Loan Product Type", LoanProductType);
            Loans.SetRange(Loans.Posted, true);
            if Loans.Find('-') then begin
                repeat

                    Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest");
                    if LoanProductType = 'SA' then begin
                        if ((Date2dmy(Today, 1) >= 19) and (Date2dmy(Today, 1) <= 26)) then
                            ExistingLoanAmount := ExistingLoanAmount + (Loans."Outstanding Principal") + (Loans."Outstanding Interest");

                    end
                    else
                        if LoanProductType = 'WN' then begin

                            if ((Loans."Outstanding Principal") + (Loans."Outstanding Interest") > 0) then begin
                                ExistingLoanAmount := ExistingLoanAmount + (Loans."Outstanding Principal") + (Loans."Outstanding Interest");
                            end;
                        end;

                until Loans.Next = 0;
            end;

            if ExistingLoanAmount > 0 then begin
                Message('Member has an Active Loan');
                Limit := 0;
                exit;
            end;

            if memberno <> '' then begin

                Member.Reset;
                Member.SetRange(Member."No.", memberno);
                if Member.Find('-') then begin
                    if (Member."Mobile Loan Defaulter") then begin
                        Message('Member is a Defaulter');
                        Limit := 0;
                        exit;
                    end
                end
                else begin
                    Message('BOSA No. not linked to FOSA Account');
                    Limit := 0;
                    exit;
                end;

                Loans.Reset;
                Loans.SetRange(Loans.Posted, true);
                Loans.SetRange(Loans."Member No.", memberno);
                if Loans.FindFirst() then begin
                    repeat
                        Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest", Loans."Last Pay Date");
                        if (Loans."Outstanding Principal" > 0) then begin
                            Custdet.Reset;
                            Custdet.SetRange(Custdet."Account No.", Loans."Member No.");
                            Custdet.SetRange(Custdet."Loan No.", Loans."Loan No.");
                            //Custdet.SETRANGE(Custdet."Transaction Type",Custdet."Transaction Type"::Repayment);
                            if Custdet.FindLast then begin
                                LastPaymentDate := Custdet."Posting Date";
                                Duration := Today - LastPaymentDate;
                                AmountD := Loans.Repayment;
                                if (Loans."Outstanding Principal" < Loans.Repayment) then
                                    AmountD := Loans."Outstanding Principal";

                                if (Duration > 30) then begin
                                    Message('Member is a Defaulter. Loan No ' + Loans."Loan No." + ' :Days=' + Format(Duration));
                                    exit;
                                end;
                            end;
                        end;
                    until Loans.Next = 0;

                end;
            end;


            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Check if last month salary passed through FOSA~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

            Days := 0;
            SalFound := false;
            Vdet.Reset;
            Vdet.SetRange(Vdet.Description, 'Salary');
            Vdet.SetRange(Vdet."Account No.", vendor."No.");
            Vdet.SetFilter("Posting Date", '>%1', CalcDate('-105D', Today));
            if Vdet.Find('+') then begin
                // Message('%1',DetailedVdet."Posting Date");
                Days := Today - Vdet."Posting Date";
                SalFound := true;
            end
            else begin

                Message('Salary does not pass through FOSA');
                Limit := 0;
                exit;
            end;

            if not SalFound then begin

                Message('Salary does not pass through FOSA');
                Limit := 0;
                exit;
            end;


            if (Days >= 35) then begin
                Message('Last salary passed though FOSA ' + Format(Days) + ' days ago');
                Limit := 0;
                exit;
            end;
        end;



        Limit := amountQualified;

        Message('Loan Limit: %1', Limit);

    end;


    procedure MobileLoanQualification(ENo: Integer) Limit: Decimal
    var
        vendor: Record "Savings Accounts";
        memberno: Code[20];
        MinimumSalary: Decimal;
        NetSalary1: Decimal;
        NetSalary2: Decimal;
        NetSalary3: Decimal;
        NoOfMonths: Integer;
        Vdet: Record "Savings Ledger Entry";
        salCount: Integer;
        averageSal: Decimal;
        amountQualified: Decimal;
        ExistingLoanAmount: Decimal;
        Custdet: Record "Credit Ledger Entry";
        SalFound: Boolean;
        Continue: Boolean;
        Loans: Record Loans;
        Member: Record Members;
        Product: Record "Product Setup";
        msg: Text;
        AcctNo: Code[20];
        LoanProductType: Code[20];
        MobileLoan: Record "Sky Mobile Loans";
        CustRec: Record Customer;
        MRepay: Decimal;
        SOrders: Record "Standing Order Header";
        LoanRepSch: Record "Loan Repayment Schedule";
        deductions: Decimal;
        TotLoanBal: Decimal;
        MaxCurrLoan: Decimal;
    begin


        MobileLoan.Get(ENo);

        memberno := '';
        Limit := 0;

        MLoanFailed := true;
        AcctNo := MobileLoan."Account No";
        LoanProductType := MobileLoan."Loan Product Type";

        Product.Get(LoanProductType);

        if Product."USSD Product Name" = '' then
            Product."USSD Product Name" := Product.Description;

        if (LoanProductType <> 'WN') and (LoanProductType <> 'SA') then
            exit;

        vendor.Reset;
        vendor.SetRange(vendor."No.", AcctNo);
        if vendor.Find('-') then begin
            Priority := 205;
            memberno := vendor."Member No.";


            if MobileLoan."Requested Amount" < 100 then begin

                msg := 'Your ' + Product."USSD Product Name" + ' Loan request has failed, The minimum amount allowed for ADVANCE is KES 100';
                MobileLoan.Remarks := 'The minimum amount allowed for ADVANCE is KES 100';
                MobileLoan.Status := MobileLoan.Status::Failed;
                MobileLoan.Posted := true;
                MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                MobileLoan.Remark := msg;
                SendSms(Source::SkyMobile, vendor."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                MobileLoan.Modify;
                Limit := 0;
                exit;

            end;


            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Check if salary passes through FOSA ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            if (vendor."Salary Processing" = false) then begin
                msg := 'Your ' + Product."USSD Product Name" + ' Loan request has failed, Your Salary does not pass through FOSA';
                MobileLoan.Remarks := 'Salary not passing through FOSA';
                MobileLoan.Status := MobileLoan.Status::Failed;
                MobileLoan.Posted := true;
                MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                MobileLoan.Remark := msg;
                SendSms(Source::SkyMobile, vendor."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                MobileLoan.Modify;
                Limit := 0;
                exit;

            end;

            /*
   //~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Check if salary passes through FOSA ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   IF(vendor."Paypoint Changed") THEN BEGIN
       msg:='Your '+Product."USSD Product Name"+' Loan request has failed, You have changed your Salary Paypoint';
       MobileLoan.Remarks:='Salary Paypoint Changed';
       MobileLoan.Status:=MobileLoan.Status::Failed;
       MobileLoan.Posted:=TRUE;
       MobileLoan."Date Posted":=CURRENTDATETIME;//TODAY;
       MobileLoan.Message:=msg;
       SendSms(Source::SkyMobile,vendor."Transactional Mobile No",msg,FORMAT(MobileLoan."Entry Code"),'',TRUE,Priority,FALSE);
       MobileLoan.MODIFY;
       Limit := 0;
       EXIT;

   END;

             */















            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Check if salary passes through FOSA ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            if (vendor."Salary Processing" = false) then begin
                msg := 'Your ' + Product."USSD Product Name" + ' Loan request has failed, Your Salary does not pass through FOSA';
                MobileLoan.Remarks := 'Salary not passing through FOSA';
                MobileLoan.Status := MobileLoan.Status::Failed;
                MobileLoan.Posted := true;
                MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                MobileLoan.Remark := msg;
                SendSms(Source::SkyMobile, vendor."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                MobileLoan.Modify;
                Limit := 0;
                exit;

            end;

            if GetAccountBalance(vendor."No.") < 0 then begin
                msg := 'Your ' + Product."USSD Product Name" + ' Loan request has failed, Your FOSA Account is overdrawn';
                MobileLoan.Remarks := 'Account is overdrawn';
                MobileLoan.Status := MobileLoan.Status::Failed;
                MobileLoan.Posted := true;
                MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                MobileLoan.Remark := msg;
                SendSms(Source::SkyMobile, vendor."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                MobileLoan.Modify;


                Limit := 0;
                exit;
            end;


            MinimumSalary := 0;
            NetSalary1 := 0;
            NetSalary2 := 0;
            NetSalary3 := 0;
            NoOfMonths := 1;

            Vdet.Reset;
            Vdet.SetRange(Vdet.Description, 'Salary');
            Vdet.SetRange(Vdet."Account No.", vendor."No.");
            Vdet.SetFilter("Posting Date", '>%1', CalcDate('-105D', Today));
            Vdet.SetRange(Reversed, false);
            Vdet.Ascending(false);
            if Vdet.Find('-') then
                repeat
                    salCount += 1;
                    MinimumSalary += ROUND(Vdet.Amount * -1, 1);  //3 Months salary
                until (Vdet.Next = 0) or (salCount = 3);

            if (salCount < 3) then begin
                msg := 'Your ' + Product."USSD Product Name" + ' Loan request has failed, Your Salary must have passed through FOSA Account for 3 Months';
                MobileLoan.Remarks := 'Salary Not Passed through FOSA for 3 months';
                MobileLoan.Status := MobileLoan.Status::Failed;
                MobileLoan.Posted := true;
                MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                MobileLoan.Remark := msg;
                SendSms(Source::SkyMobile, vendor."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                MobileLoan.Modify;


                Limit := 0;
                exit;
            end;

            averageSal := ROUND((MinimumSalary / 3), 1);

            amountQualified := 0;
            if LoanProductType = 'WN' then begin
                /*
                MsaccoLoanPars.RESET;
                MsaccoLoanPars.SETRANGE("Parameter Code", 'SALARY');
                IF MsaccoLoanPars.FIND('-') THEN BEGIN
                    REPEAT
                        IF (averageSal > MsaccoLoanPars."Minimum Amount") AND (averageSal < MsaccoLoanPars."Maximum Amount") THEN BEGIN
                            amountQualified := MsaccoLoanPars."Qualified Amount";
                            Continue := TRUE;
                        END;
                    UNTIL (MsaccoLoanPars.NEXT = 0) OR (Continue = TRUE);
                END;
                */
            end;
            //MESSAGE('Amount qualified '+FORMAT(amountQualified));





            deductions := 0;
            if LoanProductType = 'SA' then begin
                amountQualified := averageSal;


                /*
                Loans.RESET;
                Loans.SETRANGE(Loans."Member No.",vendor."No.");
                Loans.SETRANGE(Loans."Loan Product Type",LoanProductType);
                Loans.SETRANGE(Loans.Posted,TRUE);
                IF Loans.FIND('-') THEN BEGIN
                    REPEAT
                       Loans.CALCFIELDS(Loans."Outstanding Principal",Loans."Outstanding Interest");
                       amountQualified -= ((Loans."Outstanding Principal") + (Loans."Outstanding Interest"));
                    UNTIL Loans.NEXT=0;
                END;
                */



                Loans.Reset;
                Loans.SetRange(Loans."Member No.", vendor."No.");
                Loans.SetRange(Loans.Source, Loans.Source::FOSA);
                Loans.SetFilter(Loans."Loan Product Type", '<>%1', 'DV');
                Loans.SetRange(Loans.Posted, true);
                Loans.SetFilter(Loans."Repay Mode", '<>%1', Loans."Repay Mode"::Dividends);
                if Loans.Find('-') then begin
                    repeat


                        Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest");
                        if ((Loans."Outstanding Principal" + Loans."Outstanding Interest") > 0) then begin
                            MRepay := Loans.Repayment;
                            LoanRepSch.Reset;
                            LoanRepSch.SetRange(LoanRepSch."Loan No.", Loans."Loan No.");
                            LoanRepSch.SetFilter(LoanRepSch."Monthly Principal", '>0');
                            if LoanRepSch.Find('-') then
                                MRepay := LoanRepSch."Monthly Repayment";

                            if MRepay > (Loans."Outstanding Principal" + Loans."Outstanding Interest") then
                                MRepay := (Loans."Outstanding Principal" + Loans."Outstanding Interest");

                            deductions += MRepay;

                        end;
                    until Loans.Next = 0
                end;
                /*
    SOrders.RESET;
    SOrders.SETRANGE(SOrders."Source Account No.",vendor."No.");
    SOrders.SETRANGE(SOrders.Status,SOrders.Status::Approved);
    SOrders.SETFILTER(SOrders.Amount, '>%1',0);
    IF SOrders.FIND('-') THEN BEGIN
        REPEAT
            deductions += SOrders.Amount;
        UNTIL SOrders.NEXT=0;
    END;
                 */
                Message('Deductions (Loans+STO) ' + Format(deductions));
            end;
            amountQualified -= deductions;
            amountQualified := ROUND(amountQualified, 1, '<');

            if amountQualified < 0 then
                amountQualified := 0;

            ExistingLoanAmount := 0;

            Loans.Reset;
            Loans.SetRange(Loans."Member No.", vendor."No.");
            Loans.SetRange(Loans."Loan Product Type", LoanProductType);
            Loans.SetRange(Loans.Posted, true);
            Loans.SetFilter(Loans."Repay Mode", '<>%1', Loans."Repay Mode"::Dividends);
            if Loans.Find('-') then begin
                repeat
                    Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest");
                    if LoanProductType = 'SA' then begin
                        if ((Date2dmy(Today, 1) >= 19) and (Date2dmy(Today, 1) <= 26)) then
                            ExistingLoanAmount := ExistingLoanAmount + (Loans."Outstanding Principal") + (Loans."Outstanding Interest");

                    end
                    else
                        if LoanProductType = 'WN' then begin

                            if ((Loans."Outstanding Principal") + (Loans."Outstanding Interest") > 0) then begin
                                ExistingLoanAmount := ExistingLoanAmount + (Loans."Outstanding Principal") + (Loans."Outstanding Interest");
                            end;
                        end;

                until Loans.Next = 0;
            end;

            //message('ExistingLoanAmount: %1',ExistingLoanAmount);
            if ExistingLoanAmount > 0 then begin
                msg := 'Your ' + Product."USSD Product Name" + ' Loan request has failed, You have an Active ' + Product."USSD Product Name" + ' Loan';
                MobileLoan.Remarks := 'Member has an Active ' + Product."USSD Product Name" + '';
                MobileLoan.Status := MobileLoan.Status::Failed;
                MobileLoan.Posted := true;
                MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                MobileLoan.Remark := msg;
                SendSms(Source::SkyMobile, vendor."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                MobileLoan.Modify;


                Limit := 0;
                exit;
            end;

            if memberno <> '' then begin

                Member.Reset;
                Member.SetRange(Member."No.", memberno);
                if Member.Find('-') then begin
                    if (Member."Mobile Loan Defaulter") then begin
                        msg := 'Your ' + Product."USSD Product Name" + ' Loan request has failed, you are a defaulter';
                        MobileLoan.Remarks := 'Member is a defaulter';
                        MobileLoan.Status := MobileLoan.Status::Failed;
                        MobileLoan.Posted := true;
                        MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                        MobileLoan.Remark := msg;
                        SendSms(Source::SkyMobile, vendor."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                        MobileLoan.Modify;


                        Limit := 0;
                        exit;
                    end
                end
                else begin
                    msg := 'Your ' + Product."USSD Product Name" + ' Loan request has failed, Your BOSA No. has not been linked to your FOSA Account';
                    MobileLoan.Remarks := 'BOSA No. not linked to FOSA Account';
                    MobileLoan.Status := MobileLoan.Status::Failed;
                    MobileLoan.Posted := true;
                    MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                    MobileLoan.Remark := msg;
                    SendSms(Source::SkyMobile, vendor."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                    MobileLoan.Modify;


                    Limit := 0;
                    exit;
                end;

                Loans.Reset;
                Loans.SetRange(Loans.Posted, true);
                Loans.SetRange(Loans."Member No.", memberno);
                if Loans.FindFirst() then begin
                    repeat
                        Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest", Loans."Last Pay Date");
                        if (Loans."Outstanding Principal" > 0) then begin
                            Custdet.Reset;
                            Custdet.SetRange(Custdet."Account No.", Loans."Member No.");
                            Custdet.SetRange(Custdet."Loan No.", Loans."Loan No.");
                            //Custdet.SETRANGE(Custdet."Transaction Type",Custdet."Transaction Type"::Repayment);
                            if Custdet.FindLast then begin
                                LastPaymentDate := Custdet."Posting Date";
                                Duration := Today - LastPaymentDate;
                                AmountD := Loans.Repayment;
                                if (Loans."Outstanding Principal" < Loans.Repayment) then
                                    AmountD := Loans."Outstanding Principal";

                                if (Duration > 30) then begin
                                    Product.Get(Loans."Loan Product Type");

                                    msg := 'Your ' + Product."USSD Product Name" + ' Loan request has failed, You have defaulted ' + Product.Description;
                                    MobileLoan.Remarks := 'Member is a Defaulter. Loan No ' + Loans."Loan No." + ' :Days=' + Format(Duration);
                                    MobileLoan.Status := MobileLoan.Status::Failed;
                                    MobileLoan.Posted := true;
                                    MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                                    MobileLoan.Remark := msg;
                                    SendSms(Source::SkyMobile, vendor."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                                    MobileLoan.Modify;


                                    exit;
                                end;
                            end;
                        end;
                    until Loans.Next = 0;

                end;

                /*
                TotLoanBal := 0;
                Loans.RESET;
                Loans.SETRANGE(Loans.Posted,TRUE);
                Loans.SETRANGE(Loans."Loan Status",Loans."Loan Status"::Issued);
                Loans.SETRANGE(Loans."Member No.",memberno);
                Loans.SETFILTER("Outstanding Principal",'>0');
        
                IF Loans.FINDFIRST() THEN BEGIN
                    REPEAT
                        Loans.CALCFIELDS(Loans."Outstanding Principal",Loans."Outstanding Interest",Loans."Last Pay Date");
                        IF (Loans."Outstanding Principal">0) THEN BEGIN
                            TotLoanBal += Loans."Outstanding Principal";
        
                        END;
                    UNTIL Loans.NEXT =0;
        
                END;
        
        
                IF TotLoanBal > 0 THEN BEGIN
                    CMember.GET(memberno);
                    CMember.CALCFIELDS("Current Shares");
                    MaxCurrLoan := (CMember."Current Shares"*4)-TotLoanBal;
                    IF MaxCurrLoan < 0 THEN
                       MaxCurrLoan :=0;
        
                    IF amountQualified > MaxCurrLoan THEN
                       amountQualified := MaxCurrLoan;
                END;
                */
            end;

            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Check if last month salary passed through FOSA~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

            Days := 0;
            SalFound := false;
            Vdet.Reset;
            Vdet.SetRange(Vdet.Description, 'Salary');
            Vdet.SetRange(Vdet."Account No.", vendor."No.");
            Vdet.SetFilter("Posting Date", '>%1', CalcDate('-105D', Today));
            if Vdet.Find('+') then begin
                Days := Today - Vdet."Posting Date";
                SalFound := true;
            end
            else begin
                msg := 'Your ' + Product."USSD Product Name" + ' Loan request has failed, Your Salary does not pass through FOSA';
                MobileLoan.Remarks := 'Salary not passing through FOSA';
                MobileLoan.Status := MobileLoan.Status::Failed;
                MobileLoan.Posted := true;
                MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                MobileLoan.Remark := msg;
                SendSms(Source::SkyMobile, vendor."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                MobileLoan.Modify;

                Message('Salary does not pass through FOSA');
                Limit := 0;
                exit;
            end;

            if not SalFound then begin
                msg := 'Your ' + Product."USSD Product Name" + ' Loan request has failed, Your Salary does not pass through FOSA';
                MobileLoan.Remarks := 'Salary not passing through FOSA';
                MobileLoan.Status := MobileLoan.Status::Failed;
                MobileLoan.Posted := true;
                MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                MobileLoan.Remark := msg;
                SendSms(Source::SkyMobile, vendor."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                MobileLoan.Modify;

                Message('Salary does not pass through FOSA');
                Limit := 0;
                exit;
            end;


            if (Days >= 35) then begin
                msg := 'Your ' + Product."USSD Product Name" + ' Loan request has failed, Your Salary passed through FOSA ' + Format(Days) + ' days ago';
                MobileLoan.Remarks := 'Last salary passed though FOSA ' + Format(Days) + ' days ago';
                MobileLoan.Status := MobileLoan.Status::Failed;
                MobileLoan.Posted := true;
                MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                MobileLoan.Remark := msg;
                SendSms(Source::SkyMobile, vendor."Transactional Mobile No", msg, Format(MobileLoan."Entry Code"), '', true, Priority, false);
                MobileLoan.Modify;

                Message('Last salary passed though FOSA ' + Format(Days) + ' days ago');
                Limit := 0;
                exit;
            end;
        end;


        MLoanFailed := false;
        Limit := amountQualified;

    end;


    procedure GetUnhashedPINs() Response: Text
    var
        SavAcc: Record "Savings Accounts";
        SkyAuth: Record "Sky USSD Auth";
    begin
        Response := 'ERROR';

        SkyAuth.Reset;
        SkyAuth.SetRange(SkyAuth."PIN Encrypted", false);
        if SkyAuth.FindFirst then begin
            Response := '<ACCOUNTS>';
            repeat
                Response += '<ACCOUNT ACCOUNT_NUMBER="' + SkyAuth."Account No." + '" PHONE_NUMBER="' + SkyAuth."Mobile No." + '" PIN="' + SkyAuth."PIN No." + '"/>'
            until SkyAuth.Next = 0;
            Response += '</ACCOUNTS>';
        end
        else begin
            Response := '<ACCOUNTS/>';
        end;
    end;


    procedure SetHashedPIN("Account Number": Text; "Phone Number": Text; "PIN Number": Text) Response: Text
    var
        SkyAuth: Record "Sky USSD Auth";
        SavAcc: Record "Savings Accounts";
        MobileNo: Text;
    begin
        Response := 'ERROR';
        MobileNo := "Phone Number";
        SkyAuth.Reset;
        //SkyAuth.SETRANGE(SkyAuth."PIN Encrypted",FALSE);
        SkyAuth.SetRange(SkyAuth."Account No.", "Account Number");
        //SkyAuth.SETRANGE(SkyAuth."Mobile No.",MobileNo);
        if SkyAuth.Find('-') then begin
            SkyAuth."PIN No." := "PIN Number";
            SkyAuth."PIN Encrypted" := true;
            SkyAuth.Modify;
            Response := 'SUCCESS';
        end
        else begin
            Response := 'NOT_FOUND';
        end;
    end;


    procedure AddMobileLoanGuarantor(LoanEntryNo: Integer; MobileNo: Code[20]) Return: Text
    var
        SkyMobileLoans: Record "Sky Mobile Loans";
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        LoanType: Record "Product Setup";
        LoanCat: Record "Product Setup";
    begin

        /*
        Return := 'ERROR';
        
        MobileNo := GetGuarantorMobileNo(MobileNo);
        
        IF STRLEN(MobileNo) <> 9 THEN BEGIN
            Return := 'INVALID PHONE NO';
            EXIT;
        END;
        
        
        Members.RESET;
        Members.SETFILTER("Phone No.",'*'+MobileNo);
        IF NOT Members.FINDFIRST THEN BEGIN
          Return := 'MEMBER NOT FOUND';
          EXIT;
        END;
        
        
        
        IF SkyMobileLoans.GET(LoanEntryNo) THEN BEGIN
            LoanType.GET(SkyMobileLoans."Loan Product Type");
            LoanCat.GET(LoanType."Product ID",SkyMobileLoans."Micro Loan Category");
        
            MobileLoanGuarantors.RESET;
            MobileLoanGuarantors.SETRANGE("Loan Entry No.",LoanEntryNo);
            MobileLoanGuarantors.SETRANGE("Guarantor Mobile No.",MobileNo);
            IF MobileLoanGuarantors.FINDFIRST THEN BEGIN
                MobileLoanGuarantors."Loan Entry No." := LoanEntryNo;
                MobileLoanGuarantors."Guarantor Mobile No." := MobileNo;
                MobileLoanGuarantors."Appraisal Deposit Products" := LoanCat."Appraisal Account";
                MobileLoanGuarantors.VALIDATE("Guarantor Member No.",Members."No.");
                MobileLoanGuarantors."Loan Product" := SkyMobileLoans."Loan Product Type";
                MobileLoanGuarantors."Loan Product Name" := '';
                MobileLoanGuarantors."Guarantor Name" := Members.Name;
                MobileLoanGuarantors.MODIFY;
        
                IF MobileLoanGuarantors."Guarantor Accepted" = MobileLoanGuarantors."Guarantor Accepted"::Pending THEN
                    Return := 'SUCCESS';
                IF MobileLoanGuarantors."Guarantor Accepted" = MobileLoanGuarantors."Guarantor Accepted"::No THEN BEGIN
                    MobileLoanGuarantors."Guarantor Accepted" := MobileLoanGuarantors."Guarantor Accepted"::Pending;
                    MobileLoanGuarantors.MODIFY;
                    Return := 'SUCCESS';
                END;
                IF MobileLoanGuarantors."Guarantor Accepted" = MobileLoanGuarantors."Guarantor Accepted"::Yes THEN BEGIN
                    Return := 'SUCCESS';
                END;
            END
            ELSE BEGIN
                MobileLoanGuarantors.INIT;
                MobileLoanGuarantors."Loan Entry No." := LoanEntryNo;
                MobileLoanGuarantors."Guarantor Mobile No." := MobileNo;
                MobileLoanGuarantors."Appraisal Deposit Products" := LoanCat."Appraisal Account";
                MobileLoanGuarantors.VALIDATE("Guarantor Member No.",Members."No.");
                MobileLoanGuarantors."Loan Product" := SkyMobileLoans."Loan Product Type";
                MobileLoanGuarantors."Loan Product Name" := '';
                MobileLoanGuarantors."Guarantor Name" := Members.Name;
                MobileLoanGuarantors.INSERT;
                Return := 'SUCCESS';
            END;
        END;
         */

    end;


    procedure UpdateGuarantorResponse(LoanEntryNo: Integer; MobileNo: Code[20]; Accepted: Boolean) Return: Text
    var
        SkyMobileLoans: Record "Sky Mobile Loans";
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        LoanType: Record "Product Setup";
        LoanCat: Record "Product Setup";
        RemGuar: Integer;
        TotalGuaranteed: Decimal;
    begin
        /*
        IF COPYSTR(MobileNo,1,1) <> '+' THEN
          MobileNo := '+'+MobileNo;
        
        SkyMobileLoans.GET(LoanEntryNo);
        
        
        MobileLoanGuarantors.RESET;
        MobileLoanGuarantors.SETRANGE("Loan Entry No.",LoanEntryNo);
        MobileLoanGuarantors.SETRANGE("Guarantor Mobile No.",MobileNo);
        IF MobileLoanGuarantors.FINDFIRST THEN BEGIN
            IF Accepted THEN
                MobileLoanGuarantors."Guarantor Accepted" := MobileLoanGuarantors."Guarantor Accepted"::Yes
            ELSE
                MobileLoanGuarantors."Guarantor Accepted" := MobileLoanGuarantors."Guarantor Accepted"::No;
        
            MobileLoanGuarantors.MODIFY;
        END
        ELSE
            ERROR('Guarantor Not Found');
        
        */

    end;


    procedure GetLoanToConfirmGuarantoship(PhoneNo: Code[20]) Response: Text
    var
        SkyMobileLoans: Record "Sky Mobile Loans";
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        LoanType: Record "Product Setup";
        LoanCat: Record "Product Setup";
        RemGuar: Integer;
        ProductName: Text;
        LoanFound: Boolean;
    begin
        /*
        Response := 'NULL';
        
        PhoneNo := GetGuarantorMobileNo(PhoneNo);
        
        LoanFound := FALSE;
        
        MobileLoanGuarantors.RESET;
        MobileLoanGuarantors.SETRANGE("Guarantor Mobile No.",PhoneNo);
        MobileLoanGuarantors.SETRANGE("Guarantor Accepted",MobileLoanGuarantors."Guarantor Accepted"::Pending);
        IF MobileLoanGuarantors.FINDFIRST THEN BEGIN
            Response := '<Loans>';
            REPEAT
                SkyMobileLoans.RESET;
                SkyMobileLoans.SETRANGE("Entry No",MobileLoanGuarantors."Loan Entry No.");
                SkyMobileLoans.SETRANGE(Status,SkyMobileLoans.Status::"Pending Guarantors");
                IF SkyMobileLoans.FINDFIRST THEN BEGIN
                    LoanFound := TRUE;
                    LoanType.GET(SkyMobileLoans."Loan Product Type");
                    ProductName := LoanType."USSD Product Name";
                    IF ProductName = '' THEN
                      ProductName := LoanType.Description;
        
                    SavingsAccounts.GET(SkyMobileLoans."Disbursement Account No");
                    Response += '<Loan>';
                    Response += '<LoaneeName>'+SavingsAccounts.Name+'</LoaneeName>';
                    Response += '<EntryNo>'+FORMAT(SkyMobileLoans."Entry No")+'</EntryNo>';
                    Response += '<LoaneePhoneNo>'+SavingsAccounts."Transactional Mobile No"+'</LoaneePhoneNo>';
                    Response += '<ProductName>'+ProductName+'</ProductName>';
                    Response += '<RequestedAmount>'+FORMAT(SkyMobileLoans."Requested Amount")+'</RequestedAmount>';
                    Response += '<LoanStatus>'+FORMAT(SkyMobileLoans.Status)+'</LoanStatus>';
                    Response += '</Loan>';
                END;
            UNTIL MobileLoanGuarantors.NEXT=0;
            Response += '</Loans>';
        END;
        
        IF NOT LoanFound THEN
          Response := 'NULL';
        
        */

    end;


    procedure EmployerRestriction(PhoneNo: Code[20]; Transaction: Text) Restricted: Boolean
    var
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Bank Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Till Purchase";
        SavAcc: Record "Savings Accounts";
        Members: Record Members;
    begin
        Restricted := true;
        PhoneNo := '+' + PhoneNo;


        if Transaction = 'Balance Enquiry' then
            TransactionType := Transactiontype::"Balance Enquiry";

        if Transaction = 'Loan Repayment' then
            TransactionType := Transactiontype::"Loan Repayment";

        if Transaction = 'Mini-Statement' then
            TransactionType := Transactiontype::"Mini-Statement";

        if Transaction = 'Mpesa Deposit' then
            TransactionType := Transactiontype::"Mpesa Deposit";

        if Transaction = 'Bank Deposit' then
            TransactionType := Transactiontype::"Bank Deposit";

        if Transaction = 'Bank Agent Deposit' then
            TransactionType := Transactiontype::"Bank Agent Deposit";

        if Transaction = 'Mpesa Withdrawal' then
            TransactionType := Transactiontype::"Mpesa Withdrawal";


        if Transaction = 'Utility Request' then
            TransactionType := Transactiontype::"Utility Payment";

        if Transaction = 'Utility Payment' then
            TransactionType := Transactiontype::"Utility Payment";

        if Transaction = 'Withdrawal Request' then
            TransactionType := Transactiontype::"Mpesa Withdrawal";

        if Transaction = 'Paybill' then
            TransactionType := Transactiontype::Paybill;


        if Transaction = 'Bank Transfer' then
            TransactionType := Transactiontype::"Bank Transfer";


        //MESSAGE('HERE');

        //CoopSetup.RESET;
        //CoopSetup.SETRANGE("Transaction Type",TransactionType);
        //IF CoopSetup.FINDFIRST THEN BEGIN
        //    SavAcc.RESET;
        //    SavAcc.SETRANGE("Transactional Mobile No",PhoneNo);
        //    IF SavAcc.FINDFIRST THEN BEGIN
        //        IF CoopSetup."Restrict to Employer" = '' THEN
        //            Restricted := FALSE
        //        ELSE BEGIN
        //            IF SavAcc."Company Code" = CoopSetup."Restrict to Employer" THEN
        //                Restricted := FALSE;
        //        END;
        //    END;
        //END;

        //IF Transaction = 'Loan Application' THEN BEGIN
        //    SavAcc.RESET;
        //    SavAcc.SETRANGE("Transactional Mobile No",PhoneNo);
        //    IF SavAcc.FINDFIRST THEN BEGIN
        //        Members.RESET;
        //        Members.SETRANGE("No.", SavAcc."Member No.");
        //        IF Members.FINDFIRST THEN BEGIN
        //          IF Members."Member Type" = Members."Member Type"::Staff THEN BEGIN
        //              Restricted := TRUE;
        //          END;
        //          IF Members."Member Type" = Members."Member Type"::Board THEN BEGIN
        //              Restricted := TRUE;
        //          END;

        //        END;
        //    END;

        //END;
    end;


    procedure MobileLoanLimit(TelephoneNo: Text[30]; LoanType: Text) LoanAmount: Decimal
    var
        loanbalancewn: Decimal;
        MRepay: Decimal;
        LoanProduct: Record "Product Setup";
        LType: Code[20];
        CurrLoan: Decimal;
        Vendor: Record "Savings Accounts";
        salCount: Integer;
        i: Integer;
        MinimumSalary: Decimal;
        deductions: Decimal;
        Vdet: Record "Savings Ledger Entry";
        averageSal: Decimal;
        Loans: Record Loans;
        LoanRepSch: Record "Loan Repayment Schedule";
        SOrders: Record "Standing Order Header";
        amountQualified: Decimal;
        Continue: Boolean;
    begin

        //TelephoneNo:='+'+TelephoneNo ;
        LoanAmount := 0;

        Vendor.Reset;
        Vendor.SetRange(Vendor."Transactional Mobile No", TelephoneNo);
        if Vendor.Find('-') then begin


            salCount := 0;
            i := 0;
            MinimumSalary := 0;
            deductions := 0;

            if (Vendor."Salary Processing" = false) then begin
                exit(LoanAmount);
            end
            else begin


                Vdet.Reset;
                Vdet.SetRange(Vdet.Description, 'Salary');
                Vdet.SetRange(Vdet."Account No.", Vendor."No.");
                Vdet.SetFilter("Posting Date", '>%1', CalcDate('-105D', Today));
                Vdet.SetRange(Reversed, false);
                Vdet.Ascending(false);
                if Vdet.Find('-') then begin
                    Message('%1', Vdet.Count);
                    repeat
                        salCount += 1;
                        MinimumSalary += ROUND(Vdet.Amount * -1, 1);  //3 Months salary
                        Message('%1\%2', Vdet."Posting Date", Vdet.Amount * -1);
                    until (Vdet.Next = 0) or (salCount = 3);
                end;

                averageSal := ROUND((MinimumSalary / 3), 1);
                Message('Avg Salary %1', averageSal);

                salCount := 0;
                CurrLoan := 0;

                if LoanType = 'SA' then begin
                    LType := 'SA';


                    Loans.Reset;
                    Loans.SetRange(Loans."Member No.", Vendor."No.");
                    Loans.SetFilter(Loans."Loan Product Type", '%1', LType);
                    Loans.SetFilter(Loans."Outstanding Principal", '>0');
                    Loans.SetFilter(Loans."Repay Mode", '<>%1', Loans."Repay Mode"::Dividends);
                    if Loans.Find('-') then begin
                        repeat
                            Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest");
                            CurrLoan += Loans."Outstanding Principal";
                        until Loans.Next = 0
                    end;
                    Message('Active Salary Advance %1', CurrLoan);

                    Loans.Reset;
                    Loans.SetRange(Loans."Member No.", Vendor."No.");
                    Loans.SetRange(Loans.Source, Loans.Source::FOSA);
                    Loans.SetFilter(Loans."Loan Product Type", '<>%1', 'DV');
                    Loans.SetRange(Loans.Posted, true);
                    Loans.SetFilter(Loans."Repay Mode", '<>%1', Loans."Repay Mode"::Dividends);
                    if Loans.Find('-') then begin
                        repeat


                            Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest");
                            if ((Loans."Outstanding Principal" + Loans."Outstanding Interest") > 0) then begin
                                MRepay := Loans.Repayment;
                                LoanRepSch.Reset;
                                LoanRepSch.SetRange(LoanRepSch."Loan No.", Loans."Loan No.");
                                LoanRepSch.SetFilter(LoanRepSch."Monthly Principal", '>0');
                                if LoanRepSch.Find('-') then
                                    MRepay := LoanRepSch."Monthly Repayment";

                                if MRepay > (Loans."Outstanding Principal" + Loans."Outstanding Interest") then
                                    MRepay := (Loans."Outstanding Principal" + Loans."Outstanding Interest");

                                deductions += MRepay;

                            end;
                        until Loans.Next = 0
                    end;

                    /*
                                SOrders.RESET;
                                SOrders.SETRANGE(SOrders."Source Account No.",Vendor."No.");
                                SOrders.SETRANGE(SOrders.Status,SOrders.Status::Approved);
                                SOrders.SETFILTER(SOrders.Amount, '>%1',0);
                                IF SOrders.FIND('-') THEN BEGIN
                                    REPEAT
                                        deductions += SOrders.Amount;
                                    UNTIL SOrders.NEXT=0;
                                END;
                     */
                    Message('Deductions (Loans+STO) ' + Format(deductions));

                    amountQualified := averageSal - deductions;

                    if amountQualified > 100 then
                        LoanAmount := ROUND(amountQualified, 1, '<');

                    //MESSAGE('LoanAmount %1\CurrLoan %2',LoanAmount,CurrLoan);

                    if LoanProduct.Get(LType) then begin
                        if LoanProduct."Maximum Loan Amount" > 0 then
                            if LoanAmount + CurrLoan > LoanProduct."Maximum Loan Amount" then
                                LoanAmount := LoanProduct."Maximum Loan Amount" - CurrLoan;

                    end;
                    if LoanAmount < 0 then
                        LoanAmount := 0;

                    Message('Amount Qualified: %1', LoanAmount);

                    exit(LoanAmount);

                end;

                if LoanType = 'WN' then begin
                    LType := 'WN';
                    /*
                    MsaccoLoanPars.RESET;
                    MsaccoLoanPars.SETRANGE("Parameter Code", 'SALARY');
                    IF MsaccoLoanPars.FIND('-') THEN BEGIN
                        REPEAT
                            IF (averageSal > MsaccoLoanPars."Minimum Amount") AND (averageSal < MsaccoLoanPars."Maximum Amount") THEN BEGIN
                                Continue := TRUE;
                                LoanAmount := MsaccoLoanPars."Qualified Amount";
                                MESSAGE('Amount qualified '+FORMAT(amountQualified));
                            END;
                        UNTIL (MsaccoLoanPars.NEXT = 0) OR (Continue = TRUE);
                    END
                    ELSE
                    LoanAmount := 0;
                    */
                end;

                Message('Loan Amount ' + Format(LoanAmount));

            end;//Salary Processing a/c
        end
        else begin
            LoanAmount := 0;
        end

    end;


    procedure GetAccountFromKeyWord(PayBillAccNo: Code[20]; var AccNo: Code[20]; var LoanAccount: Boolean; var DepositAccount: Boolean; var IDNo: Code[20]; var MNo: Code[20]; var BosaTransType: Option "None","Loan Repayment","Share Capital","Deposit Contribution","Deposit Contribution Micro","Retirement Saving Fund","Registration Fee","Insurance Contribution","FOSA SHARES","RSF MICRO","Fosa Shares Micro"; var "Key": Code[20]; var LoanNo: Code[20])
    var
        Found: Boolean;
        KeyWordLength: Integer;
        AccountLength: Integer;
        TestKey: Code[50];
        st: Integer;
        Vend: Record "Savings Accounts";
    begin

        AccNo := '';
        LoanAccount := false;
        DepositAccount := false;
        Found := false;
        IDNo := '';
        MNo := '';
        Key := '';
        LoanNo := '';

        BosaTransType := Bosatranstype::None;


        Loans.Reset;
        Loans.SetRange("Loan Account", PayBillAccNo);
        Loans.SetFilter("Outstanding Principal", '>0');
        if Loans.FindFirst then begin
            AccNo := Loans."Loan No.";
            if AccNo = '' then begin

                Vend.Reset;
                Vend.SetRange("Member No.", Loans."Member No.");
                Vend.SetRange("Product Category", Vend."Product Category"::"Ordinary Savings");
                if Vend.FindFirst then begin
                    AccNo := vend."No.";
                end;
            end;
            LoanAccount := true;
            LoanNo := Loans."Loan No.";
        end
        else begin



            AccountLength := StrLen(PayBillAccNo);
            KeyWord.Reset;
            if KeyWord.FindFirst then begin
                repeat
                    KeyWordLength := StrLen(KeyWord.Keyword);

                    st := AccountLength - KeyWordLength;
                    if st > 0 then begin
                        TestKey := CopyStr(PayBillAccNo, st + 1, KeyWordLength);
                        if TestKey = KeyWord.Keyword then begin
                            IDNo := CopyStr(PayBillAccNo, 1, st);
                            BosaTransType := KeyWord."Destination Type";
                            MNo := '';

                            //message('T1: %1',IDNo);
                            Members.Reset;
                            Members.SetRange("ID No.", IDNo);
                            if Members.FindFirst then begin
                                MNo := Members."No.";
                            end
                            else begin
                                //message('T1: %1',IDNo);
                                Members.Reset;
                                Members.SetRange("No.", IDNo);
                                if Members.FindFirst then begin
                                    MNo := Members."No.";
                                end;
                            end;
                            //message('T1: %1',IDNo);

                            if MNo <> '' then begin
                                Members.Reset;
                                Members.SetRange("No.", MNo);
                                if Members.FindFirst then begin


                                    //Message('T: 2: '+MNo);
                                    Key := KeyWord.Keyword;
                                    Found := true;

                                    Loans.Reset;
                                    Loans.SetRange("Member No.", MNo);
                                    Loans.SetRange("Loan Product Type", KeyWord."Product Code");
                                    Loans.SetFilter("Outstanding Principal", '>0');
                                    if Loans.FindFirst then begin
                                        AccNo := Loans."Loan No.";
                                        LoanAccount := true;
                                        LoanNo := Loans."Loan No.";
                                    end
                                    else begin

                                        Vend.Reset;
                                        Vend.SetRange("Member No.", MNo);
                                        Vend.SetRange("Product Type", KeyWord."Product Code");
                                        if Vend.FindFirst then begin
                                            AccNo := Vend."No.";
                                            LoanAccount := false;
                                            LoanNo := '';
                                        end
                                    end;

                                end;

                            end;
                        end;
                    end;

                until (KeyWord.Next = 0) or (Found);
            end;

        end;
    end;

    local procedure GetUnsentSMS()
    var
        smses: Record "SMS Messages";
        SDate: Date;
    begin
        /*
       smses.RESET;
       smses.SETRANGE(smses."Sent To Server",smses."Sent To Server"::No);
       smses.SETFILTER(smses."Telephone No",'%1','');
       IF smses.FINDFIRST THEN BEGIN
           smses.MODIFYALL("Sent To Server",smses."Sent To Server"::Failed);
       END;

       smses.RESET;
       smses.SETRANGE(smses."Sent To Server",smses."Sent To Server"::No);
       smses.SETFILTER(smses."SMS Message",'%1','');
       IF smses.FINDFIRST THEN BEGIN
           smses.MODIFYALL("Sent To Server",smses."Sent To Server"::Failed);
       END;


       SDate:=DMY2DATE(8,12,2021);
       smses.RESET;
       smses.SETRANGE(smses."Sent To Server",smses."Sent To Server"::No);
       //smses.SETFILTER(smses."Telephone No",'<>%1','');
       smses.SETFILTER(smses."SMS Message",'<>%1','');
       smses.SETRANGE("Date Entered",SDate,TODAY);
       IF smses.FINDFIRST THEN BEGIN
           //ERROR('%1',smses.COUNT);
           REPEAT
               Priority := 205;
               SendSms(smses.Source,smses."Telephone No",smses."SMS Message",smses."Account No",'',FALSE,Priority,FALSE);

               smses."Sent To Server" := smses."Sent To Server"::Redirected;
               smses.MODIFY;
           UNTIL smses.NEXT = 0;
       END
          */

    end;



    procedure TESTAccountBalanceEnquiry(EntryCode: Guid; TransactionID: Code[20]; PhoneNo: Code[20]; PIN: Text; AccType: Text) Response: Text[1024]
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        AccBal: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        MobileTrans: Record "Sky Transactions.";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        SLedger: Record "Savings Ledger Entry";
        LedgerCount: Integer;
        CurrRecord: Integer;
        DFilter: Text;
        DebitCreditFlag: Code[10];
        FirstEntry: Boolean;
        ProdFact: Record "Product Setup";
        AccountBookBalance: Decimal;
        AccountAvailableBalance: Decimal;
        AccountToCharge: Code[20];
        Found: Boolean;
        MemberNo: Code[20];
        TransactionDate: DateTime;
        Loans: Record Loans;
        LoanType: Text;
        BalStmt: Text;
        msg: Text;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomFee: Decimal;
        BalEnqCharge: Decimal;
        Members: Record Members;
        UseID: Boolean;
        LProduct: Record "Product Setup";
        IDNo: Code[20];
    begin

        TransactionDate := CurrentDatetime;

        Response := 'ERROR';
        Found := false;


        PhoneNo := '+' + PhoneNo;

        if not CorrectPin(PhoneNo, PIN) then begin
            Response := 'INCORRECT_PIN';
            exit;
        end;


        AccountToCharge := '';
        MemberNo := '';
        IDNo := '';

        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        if SavAcc.FindFirst then begin

            SavAcc.CalcFields("ID No.");
            AccountToCharge := SavAcc."No.";
            MemberNo := SavAcc."Member No.";
            IDNo := SavAcc."ID No.";
            Message('MemberNo %1\IDNo %2\SavAcc.Name %3', MemberNo, IDNo, SavAcc.Name);
            if SavAcc.Blocked <> SavAcc.Blocked::" " then
                exit;
        end;


        if (MemberNo = '') and (IDNo = '') then
            exit('Member No. Missing');

        if AccountToCharge = '' then
            exit('Account to charge missing');


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

        CoopSetup.Reset;
        //CoopSetup.SetRange("Transaction Type", CoopSetup."transaction type"::"Balance Enquiry");
        if CoopSetup.FindFirst then begin

            SMSAccount := CoopSetup."SMS Account";
            SMSCharge := CoopSetup."SMS Charge";


            SaccoAccount := CoopSetup."Sacco Fee Account";
            SaccoFee := CoopSetup."Sacco Fee";
            VendorAccount := CoopSetup."Vendor Commission Account";
            VendorCommission := CoopSetup."Vendor Commission";

            TotalCharge := SaccoFee + VendorCommission + SMSCharge;
            ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
            ExciseDuty := 0;
        end
        else begin
            //ERROR('Setup Missing for %1', CoopSetup."Transaction Type");
        end;



        if SavAcc.Get(AccountToCharge) then begin

            ProdFact.Get(SavAcc."Product Type");

            if (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::"Deposits Only") or
                (ProdFact."Mobile Transaction" = ProdFact."mobile transaction"::" ") then begin
                Error('The Account to Charge is not a Withdrawable Account');

            end;

            BalEnqCharge := 0;
            AccBal := GetAccountBalance(SavAcc."No.");
            SavAcc.CalcFields("Balance (LCY)");

            AccBal := SavAcc."Balance (LCY)";
            if (AccBal - (TotalCharge + ExciseDuty)) < 500 then
                AccBal := 0;

            if AccBal >= TotalCharge + ExciseDuty then begin
                BalEnqCharge := TotalCharge + ExciseDuty;
                //BUser.GET(USERID);

            end
            else begin
                Response := 'INSUFFICIENT_BAL';
            end;
        end
        else begin
            Response := 'INVALID_ACCOUNT';
        end;


        if (Response = 'ERROR') then begin

            if (AccType = 'FOSA') or (AccType = 'BOSA') then begin


                begin
                    UseID := false;

                    if Members.Get(MemberNo) then;



                    if IDNo = '' then
                        Error('ID No. not found');
                    /*
         SavAcc.RESET;
         SavAcc.SETRANGE("Member No.",MemberNo);
         SavAcc.SETFILTER("Transactional Mobile No",'<>%1','');
         IF SavAcc.FIND('-') THEN
         IDNo := SavAcc."ID No.";
         */


                    SavAcc.Reset;
                    if IDNo = '' then
                        SavAcc.SetRange("Member No.", MemberNo)
                    else begin
                        SavAcc.SetRange("ID No.", IDNo);
                    end;

                    if SavAcc.Find('-') then begin
                        msg := 'Account Balances: ';
                        repeat
                            ProdFact.Get(SavAcc."Product Type");
                            SavAcc.CalcFields("Balance (LCY)");



                            AccountBookBalance := SavAcc."Balance (LCY)";
                            AccountAvailableBalance := GetAccountBalance(SavAcc."No.");


                            if SavAcc."Mbanking Registered" then begin

                                SMSCharge := 0;

                                CoopSetup.Reset;
                                //CoopSetup.SetRange("Transaction Type", CoopSetup."transaction type"::"Mpesa Withdrawal");
                                if CoopSetup.FindFirst then begin

                                    SMSCharge := CoopSetup."SMS Charge";

                                    SafcomCharges.Reset;
                                    SafcomCharges.SetFilter(Charge, '>0');
                                    SafcomCharges.SetFilter(Minimum, '<=%1', AccountAvailableBalance);
                                    SafcomCharges.SetFilter(Maximum, '>=%1', AccountAvailableBalance);
                                    if SafcomCharges.FindFirst then begin
                                        SafcomFee := SafcomCharges.Charge;

                                    end;

                                    SafcomFee := 0;
                                    if CoopSetup."Safcom Staggered Fee" then
                                        SafcomFee := GetStaggeredSaccoFee(CoopSetup."Safcom Staggered Charge", AccountAvailableBalance);


                                    SaccoFee := CoopSetup."Sacco Fee";
                                    if CoopSetup."Sacco Staggered Fee" then
                                        SaccoFee := GetStaggeredSaccoFee(CoopSetup."Sacco Staggered Charge", AccountAvailableBalance);

                                    VendorCommission := CoopSetup."Vendor Commission";
                                    TotalCharge := SaccoFee + VendorCommission + SafcomFee + SMSCharge;
                                    ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);

                                    AccountBookBalance -= BalEnqCharge;
                                    AccountAvailableBalance -= (BalEnqCharge + TotalCharge + ExciseDuty);
                                end;
                            end;

                            if ProdFact."USSD Product Name" = '' then
                                ProdFact."USSD Product Name" := ProdFact.Description;


                            BalStmt := ProdFact."USSD Product Name" + ' : ' + Format(AccountAvailableBalance) + ', ';
                            msg += BalStmt;

                        until SavAcc.Next = 0;

                        Error(msg);

                    end;
                end;
            end
            else
                if AccType = 'LOAN' then begin

                    Loans.Reset;
                    Loans.SetRange("Member No.", MemberNo);
                    Loans.SetFilter("Outstanding Principal", '>0');
                    if Loans.Find('-') then begin
                        msg := 'Loan Balances: ';
                        repeat
                            LoanType := Loans."Loan Product Type";

                            LProduct.Get(Loans."Loan Product Type");

                            Loans.CalcFields("Outstanding Principal");
                            if LProduct."USSD Product Name" = '' then
                                LProduct."USSD Product Name" := LProduct.Description;


                            BalStmt := LProduct."USSD Product Name" + ' : ' + Format(Loans."Outstanding Principal" + GetClearingLoanInterest(Loans)) + ', ';
                            msg += BalStmt;


                        until Loans.Next = 0;

                        Response := 'SUCCESS';
                        Priority := 200;
                        SendSms(Source::SkyMobile, PhoneNo, msg, 'LOAN_BAL', '', true, Priority, false);

                    end;
                end;
        end;

    end;


    procedure GetSalary(AcctNo: Code[20]; Date: Date) NetSal: Decimal
    var
        vendor: Record "Savings Accounts";
        memberno: Code[20];
        MinimumSalary: Decimal;
        NetSalary1: Decimal;
        NetSalary2: Decimal;
        NetSalary3: Decimal;
        NoOfMonths: Integer;
        Vdet: Record "Savings Ledger Entry";
        salCount: Integer;
        averageSal: Decimal;
        amountQualified: Decimal;
        ExistingLoanAmount: Decimal;
        Custdet: Record "Credit Ledger Entry";
        SalFound: Boolean;
        Continue: Boolean;
        Loans: Record Loans;
        Member: Record Members;
        Product: Record "Product Setup";
        msg: Text;
        LoanProductType: Code[20];
        MobileLoan: Record "Sky Mobile Loans";
        CustRec: Record Customer;
        MRepay: Decimal;
        SOrders: Record "Standing Order Header";
        LoanRepSch: Record "Loan Repayment Schedule";
        deductions: Decimal;
        TotLoanBal: Decimal;
        MaxCurrLoan: Decimal;
    begin

        NetSal := 0;
        vendor.Reset;
        vendor.SetRange(vendor."No.", AcctNo);
        if vendor.Find('-') then begin

            Vdet.Reset;
            Vdet.SetRange(Vdet.Description, 'Salary');
            Vdet.SetRange(Vdet."Account No.", vendor."No.");
            Vdet.SetFilter("Posting Date", '%1..%2', CalcDate('-CM', Date), CalcDate('CM', Date));
            Vdet.SetRange(Reversed, false);
            Vdet.Ascending(false);
            if Vdet.Find('-') then begin
                salCount += 1;
                NetSal := Vdet.Amount * -1;
            end;
        end;
    end;

    local procedure "====================="()
    begin
    end;



    procedure IsSalaryProcessedWithFOSA(telephoneNo: Text; var comments: Text[1024]) IsFOSAProcessed: Boolean
    var
        vendorRec: Record "Savings Accounts";
    begin
        telephoneNo := StrSubstNo('+%1', telephoneNo);

        vendorRec.Reset;
        vendorRec.SetRange(vendorRec."Transactional Mobile No", telephoneNo);
        if vendorRec.Find('-') then
            IsFOSAProcessed := vendorRec."Salary Processing"
        else begin
            comments := StrSubstNo('Unable to retrieve record for: %1', telephoneNo);
            IsFOSAProcessed := false;
        end;
    end;

    local procedure GetMemberEmployerCode(var vendorRecord: Record "Savings Accounts"; var comments: Text[1024]) EmployerCode: Text[10]
    var
        tblMembers: Record Members;
    begin
        tblMembers.Reset;
        tblMembers.SetRange(tblMembers."No.", vendorRecord."Member No.");
        if tblMembers.Find('-') then
            EmployerCode := tblMembers."Employer Code"
        else begin
            comments := StrSubstNo('No record found for BOSA Account No: %1', vendor."Member No.");
            EmployerCode := '';
        end;
    end;

    local procedure GetMembershipDuration(var memberRecord: Record Members) numDays: Integer
    begin
        numDays := Today - memberRecord."Registration Date";
    end;


    procedure GetMLOANMinimumSavings(telephoneNo: Text) MinimumSavings: Decimal
    var
        vendorRec: Record "Savings Accounts";
        erpMessage: Text[1024];
        employerCode: Text[10];
    begin
        telephoneNo := StrSubstNo('+%1', telephoneNo);
        erpMessage := '';
        employerCode := '';

        vendorRec.Reset;
        vendorRec.SetRange(vendorRec."Transactional Mobile No", telephoneNo);
        if vendorRec.Find('-') then begin
            employerCode := GetMemberEmployerCode(vendorRec, erpMessage);
            if erpMessage <> '' then Error(erpMessage);
            case employerCode of
                'K':
                    MinimumSavings := 500;
                else
                    MinimumSavings := 2000;
            end;
        end else
            Error('Record not found for %1', telephoneNo);
    end;


    procedure GetMLOANMaximumRepaymentPeriod(telephoneNo: Text[50]) MaxMonths: Integer
    var
        vendorRecord: Record "Savings Accounts";
        erpMessage: Text[1024];
    begin
        telephoneNo := StrSubstNo('+%1', telephoneNo);

        vendorRecord.Reset;
        vendorRecord.SetRange(vendorRecord."Transactional Mobile No", telephoneNo);
        if vendorRecord.Find('-') then begin
            if vendorRecord."Salary Processing" = true then
                MaxMonths := 5
            else
                MaxMonths := 3;
        end else begin
            Error('Unable to retrieve record for: %1', telephoneNo);
        end;
    end;

    local procedure IsStaffMember(bosaAccountNo: Text[50]; var staffNo: Text[50]) IsStaff: Boolean
    var
        tblMember: Record Members;
    begin
        if bosaAccountNo = '' then Error('Fn IsStaffMember has received empty parameter for: bosaAccountNo');

        tblMember.Reset;
        tblMember.SetRange(tblMember."No.", bosaAccountNo);
        tblMember.SetRange(tblMember."Member Category", tblMember."Member Category"::"Staff Members");
        if tblMember.Find('-') then begin
            IsStaff := true;
            staffNo := tblMember."Payroll/Staff No.";
        end else
            IsStaff := false;
    end;


    local procedure GetSMSPriority(Category: Text) Priority: Integer
    begin
        Priority := 225;


        IF (Category = 'ATM_COLLECTION') THEN
            Priority := 211
        ELSE
            IF (Category = 'B2B_WITHDRAWAL') THEN
                Priority := 211
            ELSE
                IF (Category = 'CASH_WITHDRAWAL_CONFIRM') THEN
                    Priority := 211
                ELSE
                    IF (Category = 'DEPOSIT_CONFIRMATION') THEN
                        Priority := 220
                    ELSE
                        IF (Category = 'FIXED_DEPOSIT_MATURITY') THEN
                            Priority := 240
                        ELSE
                            IF (Category = 'LOAN_APPLICATION') THEN
                                Priority := 230
                            ELSE
                                IF (Category = 'REMINDER') THEN
                                    Priority := 240
                                ELSE
                                    IF (Category = 'LOAN_DEFAULTED') THEN
                                        Priority := 240
                                    ELSE
                                        IF (Category = 'LOAN_GUARANTORS') THEN
                                            Priority := 240
                                        ELSE
                                            IF (Category = 'LOAN_POSTED') THEN
                                                Priority := 240
                                            ELSE
                                                IF (Category = 'LOW_FLOAT_ALERT') THEN
                                                    Priority := 203
                                                ELSE
                                                    IF (Category = 'LOW_FLOAT_INFO') THEN
                                                        Priority := 202
                                                    ELSE
                                                        IF (Category = 'LOW_FLOAT_MIN') THEN
                                                            Priority := 200
                                                        ELSE
                                                            IF (Category = 'LOW_FLOAT_WARNING') THEN
                                                                Priority := 204
                                                            ELSE
                                                                IF (Category = 'MAPP_ACTIVATION') THEN
                                                                    Priority := 200
                                                                ELSE
                                                                    IF (Category = 'MAPP_DEACTIVATION') THEN
                                                                        Priority := 205
                                                                    ELSE
                                                                        IF (Category = 'MBANKING') THEN
                                                                            Priority := 215
                                                                        ELSE
                                                                            IF (Category = 'MEMBER_CHANGES') THEN
                                                                                Priority := 240
                                                                            ELSE
                                                                                IF (Category = 'MOBILE_PIN') THEN
                                                                                    Priority := 208
                                                                                ELSE
                                                                                    IF (Category = 'NEW_ACCOUNT') THEN
                                                                                        Priority := 230
                                                                                    ELSE
                                                                                        IF (Category = 'NEW_MEMBER') THEN
                                                                                            Priority := 230
                                                                                        ELSE
                                                                                            IF (Category = 'ONE_TIME_PASSWORD') THEN
                                                                                                Priority := 200
                                                                                            ELSE
                                                                                                IF (Category = 'SALARY_PROCESSING') THEN
                                                                                                    Priority := 245
                                                                                                ELSE
                                                                                                    IF (Category = 'WITHDRAWAL') THEN
                                                                                                        Priority := 214
                                                                                                    ELSE
                                                                                                        IF (Category = 'LOAN_ACCOUNT_APPROVAL') THEN
                                                                                                            Priority := 245
                                                                                                        ELSE
                                                                                                            IF (Category = 'LOAN_APPRAISAL') THEN
                                                                                                                Priority := 230
                                                                                                            ELSE
                                                                                                                IF (Category = 'LOAN_REJECTED') THEN
                                                                                                                    Priority := 225
                                                                                                                ELSE
                                                                                                                    IF (Category = 'TELLER_CASH_DEPOSIT') THEN
                                                                                                                        Priority := 215
                                                                                                                    ELSE
                                                                                                                        IF (Category = 'TELLER_CAS') THEN
                                                                                                                            Priority := 225
    end;



    procedure GetStandingOrderAmount(AccNo: Code[20]) TotalAmt: Decimal
    var
        StandingOrders: Record "Standing Order Header";
    begin

        TotalAmt := 0;

        StandingOrders.Reset;
        StandingOrders.SetRange(StandingOrders."Source Account No.", AccNo);
        StandingOrders.SetRange(Status, StandingOrders.Status::Approved);
        if StandingOrders.Find('-') then begin
            StandingOrders.CalcSums(Amount);
            TotalAmt := Abs(StandingOrders.Amount);
        end;
    end;


    local procedure GetStaggeredSaccoFee(ChargeID: Code[20]; Amt: Decimal) ChgAmt: Decimal
    var
        CoopSetup: Record "Sky Mobile Setup.";
        SkyStaggeredCharges: Record "Sky Staggered Charges";
    begin

        ChgAmt := 0;
        SkyStaggeredCharges.Reset;
        SkyStaggeredCharges.SetRange("No.", ChargeID);
        SkyStaggeredCharges.SetFilter(SkyStaggeredCharges.Minimum, '<=%1', Amt);
        SkyStaggeredCharges.SetFilter(SkyStaggeredCharges.Maximum, '>=%1', Amt);
        if SkyStaggeredCharges.FindFirst then begin
            ChgAmt := SkyStaggeredCharges.Charge;
        end;
    end;


    procedure ReCheckLoanTransaction() Response: Text[1024]
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Bank Transfer",Airtime,"Bank Deposit","Bank Agent Deposit";
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        MpesaTrans: Record "Sky Transactions.";
        Continue: Boolean;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        AccBal: Decimal;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        TransactionDate: DateTime;
        MemberID: Code[20];
        PrePaymentGL: Code[20];
        Loans: Record Loans;
        LoanNo: Code[20];
        MemberNo: Code[20];
        Type: Option Daily,Weekly,Monthly;
        Limit: Decimal;
        msg: Text;
        DepositEntry: Boolean;
        ShareEntry: Boolean;
        PayBillAccNo: Code[20];
        AccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Shares Capital","Deposit Contribution","Benevolent Funds";
    begin


        MpesaTrans.Reset;
        //MpesaTrans.SETRANGE("Transaction ID",'PD35EHCHZ5');
        MpesaTrans.SetRange(Posted, false);
        MpesaTrans.SetRange("Needs Change", true);
        if MpesaTrans.FindFirst then begin
            repeat

                if StrLen(MpesaTrans."Member Account") > 6 then
                    if CopyStr(MpesaTrans."Member Account", 1, 4) = 'LOAN' then begin
                        MpesaTrans.Description := 'Loan Repayment';
                        MpesaTrans."Transaction Type" := MpesaTrans."transaction type"::"Loan Repayment";

                        LoanNo := CopyStr(MpesaTrans."Member Account", 5, StrLen(MpesaTrans."Member Account") - 3);
                        if Loans.Get(LoanNo) then begin
                            SavAcc.Reset;
                            SavAcc.SetRange("Member No.", Loans."Member No.");
                            SavAcc.SetFilter("Transactional Mobile No", '<>%1', '');

                            if SavAcc.FindFirst then begin
                                MpesaTrans."Member Account" := SavAcc."No.";
                                MpesaTrans."Loan No." := Loans."Loan No.";
                                MpesaTrans."Needs Change" := false;
                                MpesaTrans.Modify;
                                // error('Test');
                            end;
                        end;
                    end;
            until MpesaTrans.Next = 0;
        end;
    end;

    procedure ShowOnMenu(Transaction: Text; PhoneNo: Code[20]) Show: Boolean
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Bank Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Till Purchase";
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        MpesaTrans: Record "Sky Transactions.";
        Continue: Boolean;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        AccBal: Decimal;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        TransactionDate: DateTime;
        MemberID: Code[20];
        PrePaymentGL: Code[20];
        Loans: Record Loans;
        LoanNo: Code[20];
        MemberNo: Code[20];
        Type: Option Daily,Weekly,Monthly;
        Limit: Decimal;
        msg: Text;
        DepositEntry: Boolean;
        ShareEntry: Boolean;
        PayBillAccNo: Code[20];
        AccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Shares Capital","Deposit Contribution","Benevolent Funds";
    begin
        PhoneNo := '+' + PhoneNo;


        if Transaction = 'Balance Enquiry' then
            TransactionType := Transactiontype::"Balance Enquiry";

        if Transaction = 'Loan Repayment' then
            TransactionType := Transactiontype::"Loan Repayment";

        if Transaction = 'Mini-Statement' then
            TransactionType := Transactiontype::"Mini-Statement";

        if Transaction = 'Mpesa Deposit' then
            TransactionType := Transactiontype::"Mpesa Deposit";

        if Transaction = 'Bank Deposit' then
            TransactionType := Transactiontype::"Bank Deposit";

        if Transaction = 'Bank Agent Deposit' then
            TransactionType := Transactiontype::"Bank Agent Deposit";

        if Transaction = 'Mpesa Withdrawal' then
            TransactionType := Transactiontype::"Mpesa Withdrawal";

        if Transaction = 'Airtime Request' then
            TransactionType := Transactiontype::Airtime;

        if Transaction = 'Airtime Purchase' then
            TransactionType := Transactiontype::Airtime;

        if Transaction = 'Utility Request' then
            TransactionType := Transactiontype::"Utility Payment";

        if Transaction = 'Utility Payment' then
            TransactionType := Transactiontype::"Utility Payment";

        if Transaction = 'Withdrawal Request' then
            TransactionType := Transactiontype::"Mpesa Withdrawal";

        if Transaction = 'Paybill' then
            TransactionType := Transactiontype::Paybill;


        if Transaction = 'Bank Transfer' then
            TransactionType := Transactiontype::"Bank Transfer";


        if Transaction = 'Bank Transfer Request' then
            TransactionType := Transactiontype::"Bank Transfer";


        Show := false;
        CoopSetup.Reset;
        //CoopSetup.SetRange("Transaction Type", TransactionType);
        if CoopSetup.FindFirst then begin
            if (CoopSetup."Restrict to Staff") or (CoopSetup."Restrict to Board") then begin
                SavAcc.Reset;
                SavAcc.SetRange("Transactional Mobile No", PhoneNo);
                if SavAcc.FindFirst then begin
                    Members.Get(SavAcc."Member No.");
                    if (CoopSetup."Restrict to Staff") then
                        if Members."Member Category" = Members."member Category"::"Staff Members" then
                            Show := true;
                    if (CoopSetup."Restrict to Board") then
                        if Members."Member Category" = Members."member Category"::"Board Members" then
                            Show := true;
                end;
            end
            else
                Show := true;

        end;
    end;


    procedure GetSameLoanBalance(AccNo: Code[20]; LoanCode: Code[20]; var RepAmt: Decimal) Bal: Decimal
    begin
        RepAmt := 0;
        Bal := 0;
        Loans.Reset;
        Loans.SetRange(Loans."Disbursement Account No", AccNo);
        Loans.SetRange(Loans."Loan Product Type", LoanCode);
        Loans.SetFilter("Outstanding Principal", '>0');
        //Loans.SETFILTER("Loan Product Type",'<>MI&<>M-LOAN&<>MA&<>MA2&<>MA3&<>MA4');
        if Loans.Find('-') then begin
            repeat
                Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest");
                Bal += (Loans."Outstanding Principal" + Loans."Outstanding Interest");
                RepAmt += Loans.Repayment;
            until Loans.Next = 0;
        end;
    end;


    procedure ChargePinReset(Account: Code[20])
    var
        MLedger: Record "Credit Ledger Entry";
        IntDue: Decimal;
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        MpesaTrans: Record "Sky Transactions.";
        TransAmt: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Transaction Type Enum";
        BalAccType: Enum "Transaction Type Enum";
        TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","School Fee","Idd Fitr";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        RunBal: Decimal;
        AccBal: Decimal;
        Loans: Record Loans;
        IntAmt: Decimal;
        PrAmt: Decimal;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        msg: Text;
        PrePaymentGL: Code[20];
        NewLoanBal: Decimal;
        LoanType: Record "Product Setup";
        LT: Text;
        AccountToCharge: Code[20];
        BillAcc: Record "Savings Accounts";
        IntRate: Decimal;
        MemberName: Text;
        Depositor: Text;
        GenSetup: Record "Sacco Setup";
        Members: Record Members;
        AccMNo: Code[20];
        BosaTrans: Boolean;
        DepDesc: Text;
        PayBillAccNo: Code[20];
        MAccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Shares Capital","Deposit Contribution","Benevolent Funds";
        "Key": Code[20];
        LNo: Code[20];
        MemberPhoneNo: Code[20];
        Vend: Record "Savings Accounts";
        Excise: Decimal;
    begin


        /*
        SavAcc.RESET;
        SavAcc.SETRANGE("No.",Account);
        IF SavAcc.FINDFIRST THEN BEGIN
            JTemplate:='GENERAL';
            JBatch:='MBANKING';
            SaccoTrans.JournalInit(JTemplate,JBatch);
            GenSetup.GET;
                 Excise  := ROUND((GenSetup."Agency Control Account"*(GenSetup."Excise Duty (%)"/100)),1,'>');
        
                SaccoTrans.JournalInsert(JTemplate,JBatch,'PIN-RESET',TODAY,AcctType::Vendor,SavAcc."No.",'Mobile Pin Reset Fee',BalAccType::"G/L Account",
                              GenSetup."Dividend Processing Percentage",GenSetup."Agency Control Account",'','',TransType::" ",Dim1,Dim2,TRUE,SavAcc.Name);
        
                SaccoTrans.JournalInsert(JTemplate,JBatch,'PIN-RESET',TODAY,AcctType::Vendor,SavAcc."No.",'Excise Duty-PIN Reset',BalAccType::"G/L Account",
                              GenSetup."Excise Duty G/L",Excise,'','',TransType::" ",Dim1,Dim2,TRUE,SavAcc.Name);
        
        
            SaccoTrans.JournalPost(JTemplate,JBatch);
        
        END;
        */

    end;


    procedure GetLoansToTopUp(AccNo: Code[30]; LoanProductType: Code[20]; QualAmt: Decimal) Continue: Boolean
    var
        Vendor: Record "Savings Accounts";
        MemberNo: Code[30];
        TotalLoansBalance: Decimal;
        TotalChg: Decimal;
        SkyMobileSetup: Record "Sky Mobile Setup.";
        LeastTakeHome: Decimal;
        LoanProductTypes: Record "Product Setup";
        NetTakeHome: Decimal;
        Interest: Decimal;
        OutstandingLoansCount: Integer;
        OutLnInst: Integer;
        Cantopup: Text;
        Msg: Text;
    begin
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", AccNo);
        if Vendor.FindFirst then begin
            Continue := false;
            MemberNo := Vendor."Member No.";
            LoanProductTypes.Get(LoanProductType);

            TotalLoansBalance := 0;
            Loans.Reset;
            Loans.SetRange("Member No.", MemberNo);
            Loans.SetRange("Loan Product Type", LoanProductType);
            Loans.SetFilter("Outstanding Principal", '>0');
            if Loans.FindFirst then begin
                repeat
                    Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
                    TotalLoansBalance += Loans."Outstanding Principal";
                until Loans.Next = 0;
            end;


            NetTakeHome := QualAmt - TotalLoansBalance;
            //if NetTakeHome > LoanProductTypes."Min Benefit On Top Up" then
            //  Continue := true;


            if TotalLoansBalance <= 0 then
                Continue := true;

        end;
    end;


    procedure GetLoanLimitAmountOnly(PhoneNo: Code[20]; LoanProductType: Code[20]; Duration: Integer) Response: Decimal
    var
        SavAcc: Record "Savings Accounts";
        PFact: Record "Product Setup";


        XMLDOMMgt: Codeunit "XML DOM Management";



        MaxLoan: Decimal;
        msg: Text;
    begin

        PhoneNo := '+' + PhoneNo;

        Response := 0;
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if SavAcc.FindFirst then begin
            //MESSAGE(SavAcc.Name);
            PFact.Get(LoanProductType);
            if PFact."USSD Product Name" = '' then
                PFact."USSD Product Name" := PFact.Description;

            MaxLoan := MobileLoanLimit(PhoneNo, LoanProductType);

            MaxLoan := MaxLoan * Duration;


            Response := MaxLoan;

        end;
    end;

    local procedure GetMemberFirstName(MemberName: Text) FirstName: Text
    var
        StrgPos: Integer;
    begin
        StrgPos := StrPos(MemberName, ' ');
        FirstName := CopyStr(MemberName, 1, StrgPos - 1);
    end;

    local procedure GetLoansToTopUpLocal(AccNo: Code[30]; LoanProductType: Code[20]; QualAmt: Decimal) Response: Boolean
    var
        Vendor: Record "Savings Accounts";
        MemberNo: Code[30];
        TotalLoansBalance: Decimal;
        TotalChg: Decimal;
        SkyMobileSetup: Record "Sky Mobile Setup.";
        LeastTakeHome: Decimal;
        LoanProductTypes: Record "Product Setup";
        NetTakeHome: Decimal;
        Interest: Decimal;
        OutstandingLoansCount: Integer;
        OutLnInst: Integer;
        Continue: Boolean;
        Cantopup: Text;
        Msg: Text;
    begin
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", AccNo);
        if Vendor.FindFirst then begin
            Continue := false;
            MemberNo := Vendor."Member No.";
            LoanProductTypes.Get(LoanProductType);

            TotalLoansBalance := 0;
            Loans.Reset;
            Loans.SetRange("Member No.", MemberNo);
            Loans.SetRange("Loan Product Type", LoanProductType);
            Loans.SetFilter("Outstanding Principal", '>0');
            if Loans.FindFirst then begin
                repeat
                    Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
                    TotalLoansBalance += Loans."Outstanding Principal";
                until Loans.Next = 0;
            end;


            NetTakeHome := QualAmt - TotalLoansBalance;
            //if NetTakeHome > LoanProductTypes."Minimum Loan Amount" then
            //  Continue := true;


            if TotalLoansBalance <= 0 then
                Continue := true;

        end;
    end;

    local procedure TransferMbankingUsers()
    var
        Vendor: Record "Savings Accounts";
        PhoneNO: Code[20];
        Fosa: Record "Savings Accounts";
    begin

        Vendor.Reset;
        Vendor.SetFilter("Transactional Mobile No", '<>%1', '');
        if Vendor.FindFirst then begin
            Vendor.ModifyAll("Mbanking Registered", true);
        end;
        Commit;

        Vendor.Reset;
        Vendor.SetRange("Mbanking Registered", true);
        Vendor.SetFilter("Transactional Mobile No", '<>%1', '');
        if Vendor.FindFirst then begin
            repeat
                PhoneNO := Vendor."Transactional Mobile No";
                Fosa.Reset;
                Fosa.SetRange("Transactional Mobile No", PhoneNO);
                Fosa.SetFilter("No.", '<>%1', Vendor."No.");
                if Fosa.FindFirst then begin
                    Fosa.ModifyAll("Transactional Mobile No", '');
                end;
            until Vendor.Next = 0;
        end;
    end;

    local procedure NewLine() NewLine: Text
    var
        Cr: Char;
        Lf: Char;
    begin

        Cr := 13;
        Lf := 10;

        NewLine := Format(Cr, 0, '<CHAR>') + Format(Lf, 0, '<CHAR>');
    end;

    local procedure GetLoanInterest(Loans: Record Loans; Amount: Decimal; var PostInterestDue: Boolean; var InterestGL: Code[20]) Interest: Decimal
    var
        LTYPE: Record "Product Setup";
    begin
        // ERROR(loanno);
        Interest := 0;
        PostInterestDue := false;
        InterestGL := '';

        Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest");

        if Loans."Outstanding Principal" > 0 then begin

            Interest := Loans."Outstanding Interest";


            if Loans."Loan Product Type" = 'SAL ADV' then begin

                if Loans.Installments <= 12 then
                    Interest := ROUND(Amount * Loans."Annual Interest %" / (Loans."Annual Interest %" + 100), 0.01, '>')
                else
                    Interest := ROUND(Amount * 21.75 / (121.75), 0.01, '>');

            end;

            if Loans."Loan Product Type" = 'FOSA LOAN' then
                Interest := ROUND(Amount * 36 / 136, 0.01, '>');

            if Loans."Loan Product Type" = 'OKOA ADV' then
                Interest := ROUND(Amount * 10 / (Loans."Annual Interest %" - 10), 0.01, '>');


            if Loans.Source = Loans.Source::MICRO then begin
                Interest := ROUND(((Amount) * Loans."Annual Interest %") / (100 + Loans."Annual Interest %"));

                if (Loans."Loan Product Type" = 'WEF') then begin
                    Loans.CalcFields("Outstanding Principal");
                    Interest := ROUND(Loans."Outstanding Principal" * 0.08 / 12);
                end
                else begin
                    PostInterestDue := true;
                    if LTYPE.Get(Loans."Loan Product Type") then
                        InterestGL := LTYPE."Loan Interest Income [G/L]";


                    /*
        
                    //Accruing Interest for Micro Loans
                    ////Interest due to income
                    GenJournalLine.INIT;
                    LineNo:=LineNo+10000;
        
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='MSACCOLN';
                    GenJournalLine."Document No.":=Documentno;
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Group Code":='';//Transact."Group Code";
                    GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Due";
                    GenJournalLine."Product Type":=GenJournalLine."Product Type"::Member;
                    GenJournalLine."Account No.":=Loans."Member No.";;
                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date":=TODAY;
                    GenJournalLine.Description:='Interest Due';
                    GenJournalLine.Amount:=(Interest);
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    GenJournalLine."Loan No":=Loans."Loan No.";
                    GenJournalLine."Shortcut Dimension 1 Code":='MICRO';
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine."Shortcut Dimension 2 Code":=Loans."Branch Code";
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    //GenJournalLine."Bal. Account No.":=LoanType."Receivable Interest Account";
                    GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                    IF LTYPE.GET(Loans."Loan Product Type") THEN
                    GenJournalLine."Bal. Account No.":=LTYPE."Receivable Interest Account";
                    GenJournalLine.VALIDATE(GenJournalLine."Loan No");
                    IF GenJournalLine.Amount<>0 THEN
                    GenJournalLine.INSERT;
                    */
                    //
                end;
                //End of Interest Accrual
            end;
        end;

    end;


    procedure SendMbankingSMS() Response: Text
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        MpesaTrans: Record "Sky Transactions.";
        TransAmt: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Transaction Type Enum";
        BalAccType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        RunBal: Decimal;
        AccBal: Decimal;
        Loans: Record Loans;
        IntAmt: Decimal;
        PrAmt: Decimal;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        msg: Text;
        PrePaymentGL: Code[20];
        NewLoanBal: Decimal;
        LoanType: Record "Product Setup";
        LT: Text;
        AccountToCharge: Code[20];
        BillAcc: Record "Savings Accounts";
        IntRate: Decimal;
        MemberName: Text;
        Depositor: Text;
        GenSetup: Record "Sacco Setup";
        Members: Record Members;
        AccMNo: Code[20];
        BosaTrans: Boolean;
        DepDesc: Text;
        PayBillAccNo: Code[20];
        MAccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Share Capital","Deposit Contribution","Deposit Contribution Micro","Retirement Saving Fund","Registration Fee","Insurance Contribution","FOSA SHARES";
        "Key": Code[20];
        LNo: Code[20];
        MemberPhoneNo: Code[20];
        Vend: Record "Savings Accounts";
        PrAcc: Record "Savings Accounts";
        PrMno: Code[20];
        DepBal: Decimal;
        TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee","Premium Shares","Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","School Fee","Idd Fitr",RSF,InsuranceFund,"FOSA SHARES";
        AcctName: Text;
    begin

        MpesaTrans.Reset;
        //MpesaTrans.SETRANGE("Transaction ID",DocumentNo);
        MpesaTrans.SetRange("SMS Sent", false);
        MpesaTrans.SetRange("Send SMS", true);
        MpesaTrans.SetRange(Posted, true);
        if MpesaTrans.FindFirst then begin
            repeat
                if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Loan Repayment" then begin
                    if Loans.Get(MpesaTrans."Loan No.") then begin
                        Loans.CalcFields("Outstanding Principal");
                        LT := Loans."Loan Product Type Name";

                        if LoanType.Get(Loans."Loan Product Type") then begin
                            if LoanType."USSD Product Name" = '' then
                                LoanType."USSD Product Name" := LoanType.Description;

                            LT := LoanType."USSD Product Name";
                        end;

                        NewLoanBal := Loans."Outstanding Principal";
                        msg := Format(MpesaTrans."Transaction Type") + ' of KES ' + Format(MpesaTrans.Amount) + ' has been processed successfully. Interest Paid is ' + Format(MpesaTrans."Interest Paid") +
                        ', Principal Paid is ' + Format(MpesaTrans."Principal Paid") + ', New ' + LT + ' Balance is ' + Format(NewLoanBal);
                    end;
                end
                else begin
                    if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill then begin
                        Depositor := CopyStr(MpesaTrans.Description, 24, StrLen(MpesaTrans.Description));
                        //MemberName-Aziz

                        AcctName := 'Account';
                        if PrAcc.Get(MpesaTrans."Member Account") then begin
                            PrAcc.CalcFields("Balance (LCY)");
                            DepBal := PrAcc."Balance (LCY)";
                        end;

                        //ERROR('MemberPhoneNo %1\ MpesaTrans."Mobile No." %2',MemberPhoneNo , MpesaTrans."Mobile No.");

                        if MemberPhoneNo = MpesaTrans."Mobile No." then begin
                            msg := 'Dear ' + FirstName(PrAcc.name) + ', You have deposited KES ' + Format(MpesaTrans.Amount) +
                                   ' to your ' + CompName + ' ' + AcctName + ' ' + MpesaTrans."Member Account" + '. ';
                        end
                        else begin
                            msg := 'Dear ' + FirstName(pracc.name) + ', ' + Depositor + ' has deposited KES ' + Format(MpesaTrans.Amount) +
                                   ' to your ' + CompName + ' ' + AcctName + ' ' + MpesaTrans."Member Account" + '. ';

                        end;
                        if DepBal > 0 then begin
                            msg := msg + ' New Balance is KES ' + Format(DepBal);
                        end

                    end
                    else
                        if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Withdrawal" then begin
                            PrAcc.get(mpesatrans."member account");

                            msg := 'Dear ' + FirstName(pracc.name) + ', ' + MpesaTrans.Description + ' of KES ' + Format(MpesaTrans.Amount) +
                                      ' has been processed successfully. ';
                        end
                        else
                            if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Utility Payment" then begin
                                PrAcc.get(mpesatrans."member account");
                                msg := 'Dear ' + FirstName(pracc.name) + ', ' + MpesaTrans.Description + ' of KES ' + Format(MpesaTrans.Amount) + ' purchased on ' + Format(MpesaTrans."Transaction Date") +
                                          ' has been processed successfully. ';
                            end

                            else begin
                                msg := Format(MpesaTrans."Transaction Type") + ' of KES ' + Format(MpesaTrans.Amount) + ' has been processed successfully.';
                            end;
                end;
                if MemberPhoneNo = '' then
                    MemberPhoneNo := SavAcc."Transactional Mobile No";

                //ERROR('MemberPhoneNo %1\%2',MemberPhoneNo,msg);

                if (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Mini-Statement") and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Balance Enquiry") then
                    if (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Mobile App Login") then begin
                        SendSms(Source::SkyMobile, MemberPhoneNo, msg, Format(MpesaTrans."Transaction ID"), '', true, Priority, false);
                        MpesaTrans."SMS Sent" := true;
                        MpesaTrans.Modify;
                    end;


            until MpesaTrans.Next = 0;
        end;
    end;


    procedure TransactionRestriction(PhoneNo: Code[20]; Transaction: Text) Restricted: Boolean
    var
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Bank Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Till Purchase";
        SavAcc: Record "Savings Accounts";
        Members: Record Members;
    begin
        Restricted := true;
        PhoneNo := '+' + PhoneNo;


        if Transaction = 'Balance Enquiry' then
            TransactionType := Transactiontype::"Balance Enquiry";

        if Transaction = 'Loan Repayment' then
            TransactionType := Transactiontype::"Loan Repayment";

        if Transaction = 'Mini-Statement' then
            TransactionType := Transactiontype::"Mini-Statement";

        if Transaction = 'Mpesa Deposit' then
            TransactionType := Transactiontype::"Mpesa Deposit";

        if Transaction = 'Bank Deposit' then
            TransactionType := Transactiontype::"Bank Deposit";

        if Transaction = 'Bank Agent Deposit' then
            TransactionType := Transactiontype::"Bank Agent Deposit";

        if Transaction = 'Mpesa Withdrawal' then
            TransactionType := Transactiontype::"Mpesa Withdrawal";


        if Transaction = 'Utility Request' then
            TransactionType := Transactiontype::"Utility Payment";

        if Transaction = 'Utility Payment' then
            TransactionType := Transactiontype::"Utility Payment";

        if Transaction = 'Withdrawal Request' then
            TransactionType := Transactiontype::"Mpesa Withdrawal";

        if Transaction = 'Paybill' then
            TransactionType := Transactiontype::Paybill;


        if Transaction = 'Bank Transfer Request' then begin
            TransactionType := Transactiontype::"Bank Transfer";
            SavAcc.Reset;
            SavAcc.SetRange("Transactional Mobile No", PhoneNo);
            SavAcc.SetRange("Allow Bank Transfer", true);
            if SavAcc.FindFirst then begin
                Restricted := true

            end
            else begin
                Restricted := false;
            end;
        end;


        //MESSAGE('HERE');

        //CoopSetup.RESET;
        //CoopSetup.SETRANGE("Transaction Type",TransactionType);
        //IF CoopSetup.FINDFIRST THEN BEGIN
        //    SavAcc.RESET;
        //    SavAcc.SETRANGE("Transactional Mobile No",PhoneNo);
        //    IF SavAcc.FINDFIRST THEN BEGIN
        //        IF CoopSetup."Restrict to Employer" = '' THEN
        //            Restricted := FALSE
        //        ELSE BEGIN
        //            IF SavAcc."Company Code" = CoopSetup."Restrict to Employer" THEN
        //                Restricted := FALSE;
        //        END;
        //    END;
        //END;

        //IF Transaction = 'Loan Application' THEN BEGIN
        //    SavAcc.RESET;
        //    SavAcc.SETRANGE("Transactional Mobile No",PhoneNo);
        //    IF SavAcc.FINDFIRST THEN BEGIN
        //        Members.RESET;
        //        Members.SETRANGE("No.", SavAcc."Member No.");
        //        IF Members.FINDFIRST THEN BEGIN
        //          IF Members."Member Type" = Members."Member Type"::Staff THEN BEGIN
        //              Restricted := TRUE;
        //          END;
        //          IF Members."Member Type" = Members."Member Type"::Board THEN BEGIN
        //              Restricted := TRUE;
        //          END;

        //        END;
        //    END;

        //END;
    end;


    procedure GetATMCards(PhoneNo: Text[30]; "Action": Text) Response: Text
    var
        SavAcc: Record "Savings Accounts";
        PFact: Record "Product Setup";


        XMLDOMMgt: Codeunit "XML DOM Management";



        AccName: Text;
        Masked: Code[20];
        AtmLen: Integer;
        AtmNo: Code[30];
    begin

        PhoneNo := '+' + PhoneNo;  //1234 5678 1234 5678

        Response := '';
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if Action = 'ENABLED' then
            SavAcc.SetFilter("ATM No.", '<>%1', '')
        else
            if Action = 'DISABLED' then
                SavAcc.SetFilter("Old ATM No", '<>%1', '')
            else
                Error('Invalid Action');

        if SavAcc.FindFirst then begin
            Response := ' <ATM_CARDS>';
            repeat
                AtmNo := SavAcc."ATM No.";
                if Action = 'ENABLED' then
                    AtmNo := (SavAcc."ATM No.")
                else
                    if Action = 'DISABLED' then
                        AtmNo := (SavAcc."Old ATM No");

                AtmLen := StrLen(AtmNo);
                Masked := CopyStr(AtmNo, AtmLen - 3, 4);
                Masked := '************' + Masked;
                Response += '<CARD>';
                Response += '<ID>' + AtmNo + '</ID>';
                Response += '<NAME>' + SavAcc."No." + ' [' + Masked + ']</NAME>';
                Response += '<ACCOUNT>' + SavAcc."No." + '</ACCOUNT>';
                Response += '</CARD>';
            until SavAcc.Next = 0;
            Response += '</ATM_CARDS>';
        end;
    end;


    procedure ActionATMCard("Action": Text; ATMCardNumber: Text; PhoneNo: Text[30]; PIN: Text; AccountNo: Text) Response: Text
    var
        SavAcc: Record "Savings Accounts";
        PFact: Record "Product Setup";


        XMLDOMMgt: Codeunit "XML DOM Management";



        AccName: Text;
        Masked: Code[20];
        AtmLen: Integer;
        IDNo: Code[20];
    begin




        PhoneNo := '+' + PhoneNo;  //1234 5678 1234 5678
        Response := 'ERROR';

        if not CorrectPin(PhoneNo, PIN) then begin
            Response := 'INCORRECT_PIN';
            exit;
        end;


        SavAcc.Reset;
        SavAcc.SetRange("No.", AccountNo);
        if Action = 'ENABLE' then
            SavAcc.SetFilter("Old ATM No", '%1', ATMCardNumber)
        else
            if Action = 'DISABLE' then
                SavAcc.SetFilter("ATM No.", '%1', ATMCardNumber)
            else
                Error('Invalid Action');

        if SavAcc.FindFirst then begin
            if (Action = 'DISABLE') and (SavAcc."ATM No." <> '') then begin
                SavAcc."Old ATM No" := SavAcc."ATM No.";
                SavAcc."ATM No." := '';
                SavAcc.Modify;
                Response := 'SUCCESS';
            end;
            if (Action = 'ENABLE') and (SavAcc."ATM No." = '') and (SavAcc."Old ATM No" <> '') then begin
                SavAcc."ATM No." := SavAcc."Old ATM No";
                SavAcc."Old ATM No" := '';
                Response := 'SUCCESS';
            end;

        end;
    end;


    procedure GetBankTransferAccountsToAction(PhoneNo: Text[30]; "Action": Text) Response: Text
    var
        SavAcc: Record "Savings Accounts";
        PFact: Record "Product Setup";


        XMLDOMMgt: Codeunit "XML DOM Management";



        AccName: Text;
        Masked: Code[20];
        AtmLen: Integer;
        AtmNo: Code[30];
    begin

        PhoneNo := '+' + PhoneNo;  //1234 5678 1234 5678

        Response := '';
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
        if Action = 'ENABLED' then
            SavAcc.SetRange("Allow Bank Transfer", true)
        else
            if Action = 'DISABLED' then
                SavAcc.SetRange("Allow Bank Transfer", false)
            else
                Error('Invalid Action');

        if SavAcc.FindFirst then begin
            Response := ' <BANKTRANSFER>';
            repeat
                Response += '<ACCOUNT>';
                Response += '<ID>' + SavAcc."No." + '</ID>';
                Response += '<ACC_NO>' + SavAcc."No." + '</ACC_NO>';
                Response += '</ACCOUNT>';
            until SavAcc.Next = 0;
            Response += '</BANKTRANSFER>';
        end;
    end;


    procedure ActionBankTransfer("Action": Text; AccountNo: Text[30]; PIN: Text; PhoneNo: Text) Response: Text
    var
        SavAcc: Record "Savings Accounts";
        PFact: Record "Product Setup";


        XMLDOMMgt: Codeunit "XML DOM Management";



        AccName: Text;
        Masked: Code[20];
        AtmLen: Integer;
        msg: Text;
    begin
        PhoneNo := '+' + PhoneNo;
        Response := 'ERROR';

        if not CorrectPin(PhoneNo, PIN) then begin
            Response := 'INCORRECT_PIN';
            exit;
        end;


        SavAcc.Reset;
        SavAcc.SetRange("No.", AccountNo);
        if SavAcc.FindFirst then begin
            if (Action = 'DISABLE') then begin
                SavAcc."Allow Bank Transfer" := false;
                SavAcc.Modify;
                Response := 'SUCCESS';
            end;
            if (Action = 'ENABLE') then begin
                SavAcc."Allow Bank Transfer" := true;
                SavAcc.Modify;
                Response := 'SUCCESS';

            end;

            msg := 'Dear ' + FirstName(SavAcc.name) + ', your request to ' + Action + ' Bank Transfer on Account No. ' + AccountNo + ' has been processed successfuly';
            SendSms(Source::SkyMobile, SavAcc."Phone No.", msg, AccountNo, '', false, Priority, false);


        end;
    end;


    procedure GetNeedsChange(PhoneNo: Code[20]) Response: Text
    var
        SkyTransactions: Record "Sky Transactions.";
        MobileLoan: Record "Sky Mobile Loans";
        RandNo: Integer;
        Loans: Record Loans;
        SavAcc: Record "Savings Accounts";
    begin
        Response := '';
        PhoneNo := '+' + PhoneNo;

        SkyTransactions.Reset;
        SkyTransactions.SetRange("Transaction Type", SkyTransactions."transaction type"::Paybill);
        SkyTransactions.SetRange(Posted, false);
        SkyTransactions.SetRange("Needs Change", true);
        SkyTransactions.SetRange("Mobile No.", PhoneNo);
        if SkyTransactions.Find('-') then begin
            Response := '<Transactions>';
            repeat
                Response += '<Transaction>';
                Response += '<Id>' + SkyTransactions."Transaction ID" + '</Id>';
                Response += '<Label>' + 'A/C: ' + SkyTransactions."Member Account" + ', Ksh ' + Format(SkyTransactions.Amount) + ', Date: ' + ddMMyyyy(SkyTransactions."Transaction Date") + '</Label>';
                Response += '<Amount>' + Format(SkyTransactions.Amount) + '</Amount>';
                Response += '</Transaction>';
            until SkyTransactions.Next = 0;
            Response += '</Transactions>';
        end;
    end;




    procedure CorrectNeedsChange(PhoneNo: Code[20]; TransactionId: Code[20]; CorrectAccountNo: Code[20]; Narration: Text) Response: Text
    var
        SkyTransactions: Record "Sky Transactions.";
        MobileLoan: Record "Sky Mobile Loans";
        RandNo: Integer;
        Loans: Record Loans;
        SavAcc: Record "Savings Accounts";
    begin
        Response := 'ERROR';
        PhoneNo := '+' + PhoneNo;

        if CorrectAccountNo = '' then
            exit;

        SkyTransactions.Reset;
        SkyTransactions.SetRange("Transaction Type", SkyTransactions."transaction type"::Paybill);
        SkyTransactions.SetRange(Posted, false);
        SkyTransactions.SetRange("Needs Change", true);
        SkyTransactions.SetRange("Mobile No.", PhoneNo);
        SkyTransactions.SetRange("Transaction ID", TransactionId);
        if SkyTransactions.Find('-') then begin
            SkyTransactions."Member Account" := CorrectAccountNo;
            SkyTransactions."Needs Change" := false;
            if Narration <> '' then begin
                SkyTransactions."Account Name" := Narration;
            end;
            SkyTransactions.Modify;
            Response := 'SUCCESS';
        end;
    end;


    /*
    procedure TradeShares("Action": Code[10]; AccountNo: Code[100]; Price: Decimal; Shares: Integer; PIN: Text; PhoneNo: Text) Response: Text[1024]
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Bank Transfer",Airtime,"Bank Deposit","Bank Agent Deposit";
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        MpesaTrans: Record "Sky Transactions.";
        Continue: Boolean;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        AccBal: Decimal;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        TransactionDate: DateTime;
        MemberID: Code[20];
        PrePaymentGL: Code[20];
        Loans: Record Loans;
        LoanNo: Code[20];
        MemberNo: Code[20];
        Type: Option Daily,Weekly,Monthly;
        Limit: Decimal;
        msg: Text;
        DepositEntry: Boolean;
        ShareEntry: Boolean;
        PayBillAccNo: Code[20];
        AccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Shares Capital","Deposit Contribution","Benevolent Funds";
        ValidateAccount: Code[100];
        TotalShares: Decimal;
        Available: Decimal;
        //ShareTransactionsBuffer: Record UnknownRecord39004359;
        NewApplicationNo: Integer;
        Charges: Record "Charges.";
        Duty: Decimal;
        ChargeAmount: Decimal;
        Buffered: Decimal;
        ParValue: Decimal;
        TotalAmount: Decimal;
    begin
        if PhoneNo = '' then
            Error('Parameter PhoneNo Must have a value');

        GenSetup.Get;
        Buffered := 0;
        ParValue := 20;

        TotalShares := ParValue * Shares;
        TotalAmount := Price * Shares;

        if Action = 'SELL' then begin
            if Members.Get(AccountNo) then begin



                Charges.Reset;
                Charges.SetRange(Charges."Charge Type", Charges."charge type"::"17");
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then
                        ChargeAmount := TotalShares * Charges."Percentage of Amount" * 0.01
                    else
                        ChargeAmount := Charges."Charge Amount";
                end;

                Duty := ChargeAmount * (GenSetup."Excise Duty (%)" / 100);
                TotalCharge := ChargeAmount + Duty;


                Members.CalcFields("Shares Retained");


                ShareTransactionsBuffer.Reset;
                ShareTransactionsBuffer.SetRange("Member No", AccountNo);
                ShareTransactionsBuffer.SetRange(Type, ShareTransactionsBuffer.Type::"1");
                ShareTransactionsBuffer.SetRange(Cancel, false);
                ShareTransactionsBuffer.SetRange(Transfered, false);
                if ShareTransactionsBuffer.FindFirst then begin
                    ShareTransactionsBuffer.CalcSums(ShareTransactionsBuffer."Amount (Par Value)");
                    Buffered := ShareTransactionsBuffer."Amount (Par Value)";
                end;
                Available := (Members."Shares Retained" - GenSetup."Min. Share Capital" - Buffered);

                if TotalShares <= Available then begin


                    ShareTransactionsBuffer.Reset;
                    if ShareTransactionsBuffer.FindLast then
                        NewApplicationNo := ShareTransactionsBuffer."Entry No" + 1
                    else
                        NewApplicationNo := 1;

                    ShareTransactionsBuffer.Reset;
                    ShareTransactionsBuffer."Entry No" := NewApplicationNo;
                    ShareTransactionsBuffer."Member No" := AccountNo;
                    ShareTransactionsBuffer.Validate(ShareTransactionsBuffer."Member No");
                    ShareTransactionsBuffer.Type := ShareTransactionsBuffer.Type::"1";
                    ShareTransactionsBuffer."No Of Shares" := Shares;
                    ShareTransactionsBuffer.Validate(ShareTransactionsBuffer."No Of Shares");
                    ShareTransactionsBuffer."Date Requested" := Today;
                    ShareTransactionsBuffer."Transacting Account" := Members."FOSA Account";
                    ShareTransactionsBuffer."Quoted price" := Price;
                    ShareTransactionsBuffer.Validate(ShareTransactionsBuffer."Quoted price");
                    ShareTransactionsBuffer."Buy or Sale option" := ShareTransactionsBuffer."buy or sale option"::"0";
                    ShareTransactionsBuffer.Cancel := false;
                    ShareTransactionsBuffer."Cancelled By" := '';

                    if ShareTransactionsBuffer.Insert(true) then begin

                        //send sms to seller
                        msg := 'Dear member, Your intention to sell ' + Format(Shares) + ' shares at ' + Format(Price) +
                        ' has been placed successfully. You will be notified once transaction is complete' + NewLine + '. REF ' + Format(NewApplicationNo);
                        SendSms(Source::SkyMobile, Members."Phone No.", msg, Members."FOSA Account", '', false, Priority, false);
                        Response := 'SUCCESS:::Success';

                    end;
                end
                else begin
                    Response := 'ERROR:::You have insufficient Share Capital';
                end;
            end
            else begin
                Response := 'ERROR:::Member No not Found';
            end;
        end;



        if Action = 'BUY' then begin

            if SavAcc.Get(AccountNo) then begin

                Charges.Reset;
                Charges.SetRange(Charges."Charge Type", Charges."charge type"::"16");
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then
                        ChargeAmount := TotalAmount * Charges."Percentage of Amount" * 0.01
                    else
                        ChargeAmount := Charges."Charge Amount";
                end;

                Duty := ChargeAmount * (GenSetup."Excise Duty (%)" / 100);
                TotalCharge := ChargeAmount + Duty;


                ShareTransactionsBuffer.Reset;
                ShareTransactionsBuffer.SetRange("Member No", AccountNo);
                ShareTransactionsBuffer.SetRange(Type, ShareTransactionsBuffer.Type::"0");
                ShareTransactionsBuffer.SetRange(Cancel, false);
                ShareTransactionsBuffer.SetRange(Transfered, false);
                if ShareTransactionsBuffer.FindFirst then begin
                    ShareTransactionsBuffer.CalcSums(ShareTransactionsBuffer."Total price");
                    Buffered := ShareTransactionsBuffer."Total price";
                end;


                Available := GetAccountBalance(SavAcc."No.") - TotalCharge - Buffered;

                //Error('TotalAmount %1\ Available %2',TotalAmount ,Available);
                if TotalAmount <= Available then begin


                    ShareTransactionsBuffer.Reset;
                    if ShareTransactionsBuffer.FindLast then
                        NewApplicationNo := ShareTransactionsBuffer."Entry No" + 1
                    else
                        NewApplicationNo := 1;

                    ShareTransactionsBuffer.Reset;
                    ShareTransactionsBuffer."Entry No" := NewApplicationNo;
                    ShareTransactionsBuffer."Member No" := SavAcc."Member No.";
                    ShareTransactionsBuffer.Validate(ShareTransactionsBuffer."Member No");
                    ShareTransactionsBuffer.Type := ShareTransactionsBuffer.Type::"0";
                    ShareTransactionsBuffer."No Of Shares" := Shares;
                    ShareTransactionsBuffer.Validate(ShareTransactionsBuffer."No Of Shares");
                    ShareTransactionsBuffer."Date Requested" := Today;
                    ShareTransactionsBuffer."Transacting Account" := AccountNo;
                    ShareTransactionsBuffer."Quoted price" := Price;
                    ShareTransactionsBuffer.Validate(ShareTransactionsBuffer."Quoted price");
                    ShareTransactionsBuffer."Buy or Sale option" := ShareTransactionsBuffer."buy or sale option"::"0";
                    ShareTransactionsBuffer.Cancel := false;
                    ShareTransactionsBuffer."Cancelled By" := '';
                    if ShareTransactionsBuffer.Insert(true) then begin
                        Commit;
                        //send sms to seller
                        msg := 'Dear member, Your intention to purchase ' + Format(Shares) + ' shares at ' + Format(Price) +
                        ' has been placed successfully. You will be notified once transaction is complete. REF ' + Format(NewApplicationNo);
                        SendSms(Source::SkyMobile, SavAcc."Phone No.", msg, Members."FOSA Account", '', false, Priority, false);
                        Response := 'SUCCESS:::Success';
                    end;


                end
                else begin
                    Response := 'ERROR:::You have insufficient Balance';
                end;
            end
            else begin
                Response := 'ERROR:::Member No not Found';
            end;
        end;
    end;
    */


    procedure ShareTradingLimits() Response: Text
    var
        SavAcc: Record "Savings Accounts";
        PFact: Record "Product Setup";


        XMLDOMMgt: Codeunit "XML DOM Management";



        AccName: Text;
        Masked: Code[20];
        AtmLen: Integer;
        AtmNo: Code[30];
    begin
        Response += Format(ShareTradeMinimum) + ':::' + Format(ShareTradeMaximum);
    end;

    /*
    procedure GetMaxSharesToTrade("Action": Code[10]; AccountNo: Code[100]; Price: Decimal) Response: Text
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Bank Transfer",Airtime,"Bank Deposit","Bank Agent Deposit";
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        MpesaTrans: Record "Sky Transactions.";
        Continue: Boolean;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        AccBal: Decimal;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        TransactionDate: DateTime;
        MemberID: Code[20];
        PrePaymentGL: Code[20];
        Loans: Record Loans;
        LoanNo: Code[20];
        MemberNo: Code[20];
        Type: Option Daily,Weekly,Monthly;
        Limit: Decimal;
        msg: Text;
        DepositEntry: Boolean;
        ShareEntry: Boolean;
        PayBillAccNo: Code[20];
        AccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Shares Capital","Deposit Contribution","Benevolent Funds";
        ValidateAccount: Code[100];
        TotalShares: Decimal;
        Available: Decimal;
        //ShareTransactionsBuffer: Record UnknownRecord39004359;
        NewApplicationNo: Integer;
        //Charges: Record UnknownRecord39004265;
        Duty: Decimal;
        ChargeAmount: Decimal;
        Buffered: Decimal;
        ParValue: Decimal;
        TotalAmount: Decimal;
        NoOfShares: Integer;
    begin

        GenSetup.Get;
        Buffered := 0;
        ParValue := 20;
        NoOfShares := 0;


        if Action = 'SELL' then begin
            if Members.Get(AccountNo) then begin

                Charges.Reset;
                Charges.SetRange(Charges."Charge Type", Charges."charge type"::"17");
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then
                        ChargeAmount := TotalShares * Charges."Percentage of Amount" * 0.01
                    else
                        ChargeAmount := Charges."Charge Amount";
                end;

                Duty := ChargeAmount * (GenSetup."Excise Duty (%)" / 100);
                TotalCharge := ChargeAmount + Duty;


                Members.CalcFields("Shares Retained");


                ShareTransactionsBuffer.Reset;
                ShareTransactionsBuffer.SetRange("Member No", AccountNo);
                ShareTransactionsBuffer.SetRange(Type, ShareTransactionsBuffer.Type::"1");
                ShareTransactionsBuffer.SetRange(Cancel, false);
                ShareTransactionsBuffer.SetRange(Transfered, false);
                if ShareTransactionsBuffer.FindFirst then begin
                    ShareTransactionsBuffer.CalcSums(ShareTransactionsBuffer."Amount (Par Value)");
                    Buffered := ShareTransactionsBuffer."Amount (Par Value)";
                end;
                Available := (Members."Shares Retained" - GenSetup."Min. Share Capital" - Buffered);
                NoOfShares := ROUND(Available / ParValue, 1, '<');
            end;
        end;

        if Action = 'BUY' then begin

            if SavAcc.Get(AccountNo) then begin


                Available := GetAccountBalance(SavAcc."No.");
                Charges.Reset;
                Charges.SetRange(Charges."Charge Type", Charges."charge type"::"16");
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then
                        Available := Available * (100 - (Charges."Percentage of Amount" + 0.3)) * 0.01
                    else
                        Available := Available - (Charges."Charge Amount" + (Charges."Charge Amount" * (GenSetup."Excise Duty (%)" / 100)));
                end;

                Duty := ChargeAmount * (GenSetup."Excise Duty (%)" / 100);
                TotalCharge := ChargeAmount + Duty;


                ShareTransactionsBuffer.Reset;
                ShareTransactionsBuffer.SetRange("Member No", AccountNo);
                ShareTransactionsBuffer.SetRange(Type, ShareTransactionsBuffer.Type::"0");
                ShareTransactionsBuffer.SetRange(Cancel, false);
                ShareTransactionsBuffer.SetRange(Transfered, false);
                if ShareTransactionsBuffer.FindFirst then begin
                    ShareTransactionsBuffer.CalcSums(ShareTransactionsBuffer."Total price");
                    Buffered := ShareTransactionsBuffer."Total price";
                end;


                Available := Available
                - Buffered;
                NoOfShares := ROUND(Available / Price, 1, '<');
            end;
        end;

        if NoOfShares < 0 then
            NoOfShares := 0;


        Response := Format(MinShareToBuy) + ':::' + Format(NoOfShares)
    end;
    */


    procedure GetLoanAccessSetup(PhoneNo: Code[20]) Response: Text
    var
        MCommission: Decimal;
        MInterest: Decimal;
        MComm: Integer;
        MInt: Decimal;
        LAccount: Code[50];
        SaccoMemberNo: Code[20];
        ContinueMB: Boolean;
        Members: Record Members;
        interestGL: Code[10];
        LoansOld: Record Loans;
        TotalClearedAmount: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        LoanProcessingGL: Code[20];
        vendorMboostaCommission: Decimal;
        vendorMboostaCommissionGL: Code[20];
        Loans: Record Loans;
        OutstandingAmount: Decimal;
        StartDate: array[3] of Date;
        EndDate: array[3] of Date;
        CurrSal: array[3] of Decimal;
        k: Integer;
        SmallestSal: Decimal;
        Salary: array[3] of Decimal;
        SalDates: array[3] of Date;
        SalaryThroughFosa: Boolean;
        BlaklistStartDate: Date;
        Limit: Decimal;
        LoanedBefore: Boolean;
        LastDate: Date;
        j: Integer;
        MobileLoanGuarantors: Record "Mobile Loan Guarantors";
    begin
        PhoneNo := '+' + PhoneNo;
        Response := '';

        SavingsAccounts.Reset;
        SavingsAccounts.SetRange(SavingsAccounts."Transactional Mobile No", PhoneNo);
        if SavingsAccounts.Find('-') then begin

            Members.Get(SavingsAccounts."Member No.");

            if (Members."Employer Code" = '9901') or (Members."Employer Code" = '9902') then begin
                Response += '<LoansSetup>';
                Response += '<CanAccessLoans>' + 'FALSE' + '</CanAccessLoans>';
                Response += '<AccessMessage>' + 'Sorry, kindly visit your nearest branch or contact us to access loan services' + '</AccessMessage>';

                MobileLoanGuarantors.Reset;
                MobileLoanGuarantors.SetFilter("Guarantor Accepted", '%1', MobileLoanGuarantors."guarantor accepted"::Pending);
                MobileLoanGuarantors.SetRange("Guarantor Member No.", Members."No.");
                MobileLoanGuarantors.SetRange("Loan Status", MobileLoanGuarantors."loan status"::"Pending Guarantors");
                if MobileLoanGuarantors.FindFirst then
                    Response += '<HasPendingGuarantorship>' + 'TRUE' + '</HasPendingGuarantorship>'
                else
                    Response += '<HasPendingGuarantorship>' + 'FALSE' + '</HasPendingGuarantorship>';

                Response += '</LoansSetup>';
            end
            else begin

                Response += '<LoansSetup>';
                Response += '<CanAccessLoans>' + 'TRUE' + '</CanAccessLoans>';
                Response += '<AccessMessage>' + 'Success' + '</AccessMessage>';

                MobileLoanGuarantors.Reset;
                MobileLoanGuarantors.SetFilter("Guarantor Accepted", '%1', MobileLoanGuarantors."guarantor accepted"::Pending);
                MobileLoanGuarantors.SetRange("Guarantor Member No.", Members."No.");
                MobileLoanGuarantors.SetRange("Loan Status", MobileLoanGuarantors."loan status"::"Pending Guarantors");
                if MobileLoanGuarantors.FindFirst then
                    Response += '<HasPendingGuarantorship>' + 'TRUE' + '</HasPendingGuarantorship>'
                else
                    Response += '<HasPendingGuarantorship>' + 'FALSE' + '</HasPendingGuarantorship>';

                Response += '</LoansSetup>';
            end;
        end;
    end;


    procedure GetLoanBalance(LoanNo: Code[20]) Bal: Text
    var
        MobileNo: Code[20];
        Loans: Record Loans;
        MemberNo: Code[20];
        MaxLoan: Decimal;
        Found: Boolean;
        arrears: Decimal;
        balance: Decimal;
    begin

        Bal := '';

        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNo);
        if Loans.FindFirst then begin

            Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
            if Loans."Outstanding Interest" <= 0 then
                Loans."Outstanding Interest" := GetClearingLoanInterest(Loans);

            if Loans."Outstanding Interest" <= 0 then
                Loans."Outstanding Interest" := 0;

            balance := (Loans."Outstanding Principal" + Loans."Outstanding Interest");

            Bal := 'Total Bal: KES ' + Format(balance);
        end;
    end;


    procedure AddRemoveMobileLoanGuarantor(LoanEntryNo: Guid; MobileNo: Code[20]; "Action": Code[20]) Return: Text
    var
        SkyMobileLoans: Record "Sky Mobile Loans";
        Members: Record Members;
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
        HMember: Record Members;
    begin

        Return := 'ERROR';

        MobileNo := GetGuarantorMobileNo(MobileNo);

        if StrLen(MobileNo) <> 13 then begin
            Return := 'ERROR::::Invalid Phone No.';
            exit;
        end;


        Members.Reset;
        Members.SetFilter("Mobile Phone No.", '*' + MobileNo);
        if Members.FindFirst then begin
            /*
            IF Members."Member Status"<>Members."Member Status"::Active THEN BEGIN
                Return := 'ERROR::::1.'+Members.Name+' is not qualified to Guarantee';
                EXIT;
            END;
        
        
            Loans.RESET;
            Loans.SETRANGE("Member No.",Members."No.");
            Loans.SETFILTER("Outstanding Principal",'>0');
            Loans.SETFILTER("Current Loans Category-SASRA",'<>%1&<>%2',Loans."Current Loans Category-SASRA"::Perfoming,Loans."Current Loans Category-SASRA"::Watch);
            IF Loans.FINDFIRST THEN BEGIN
                Return := 'ERROR::::2.'+Members.Name+' is not qualified to Guarantee';
                EXIT;
            END;
        
        
            LoanG.RESET;
            LoanG.SETRANGE("Member No",Members."No.");
            LoanG.SETFILTER("Outstanding Principal",'>0');
            LoanG.SETRANGE("Self Guarantee",FALSE);
            IF LoanG.FINDFIRST THEN BEGIN
                IF LoanG.COUNT > 20  THEN BEGIN
                    Return := 'ERROR::::3.'+Members.Name+' is not qualified to Guarantee';
                    EXIT;
                END;
            END;
        
        
        
            LoanG.RESET;
            LoanG.SETRANGE("Member No",Members."No.");
            LoanG.SETFILTER("Outstanding Principal",'>0');
            LoanG.SETRANGE("Self Guarantee",TRUE);
            IF LoanG.FINDFIRST THEN BEGIN
                Return := 'ERROR::::4.'+Members.Name+' is not qualified to Guarantee';
                EXIT;
            END;
            */


        end
        else begin
            Return := 'ERROR::::Members Not Found';
            exit;
        end;



        if SkyMobileLoans.Get(LoanEntryNo) then begin
            LoanType.Get(SkyMobileLoans."Loan Product Type");

            if Action = 'DISCARD' then begin


                msg := 'Dear ' + FirstName(SkyMobileLoans."Account Name") + ', Your ' + LoanType."USSD Product Name" + ' request has been cancelled.';
                SkyMobileLoans.Remarks := 'Loan Discarded';
                SkyMobileLoans.Status := SkyMobileLoans.Status::Failed;
                SkyMobileLoans.Posted := true;
                SkyMobileLoans."Date Posted" := CurrentDatetime;//TODAY;
                SkyMobileLoans.Remark := msg;
                SendSms(Source::SkyMobile, SkyMobileLoans."Telephone No", msg, Format(SkyMobileLoans."Entry No"), '', true, Priority, false);
                SkyMobileLoans.Modify;
                Return := 'SUCCESS::::' + successText;
                exit;
            end;
            if SkyMobileLoans."Member No." = Members."No." then begin
                Return := 'ERROR::::You are not allowed to guarantee your own loan';
                exit;
            end;

            DepAc := '';


            successText := 'Your Request to add ' + Members.Name + ' has been received successfully';

            MobileLoanGuarantors.Reset;
            MobileLoanGuarantors.SetRange("Loan Entry No.", LoanEntryNo);
            MobileLoanGuarantors.SetRange("Guarantor Member No.", Members."No.");
            if MobileLoanGuarantors.FindFirst then begin
                if Action = 'REMOVE' then begin
                    MobileLoanGuarantors.Delete;
                    Return := 'SUCCESS::::' + 'Your Request to Remove ' + Members.Name + ' has been received successfully';


                    if SavAcc.Get(SkyMobileLoans."Account No") then begin
                        Priority := 211;
                        msg := 'Dear ' + Format(SkyMobileLoans."Account Name") + NewLine + 'You have removed ' + MobileLoanGuarantors."Guarantor Name" +
                        ' from your guarantorship request on ' + SkyMobileLoans."Loan Name" + ' loan amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today, 0, '<Day,2>/<Month,2>/<Year4>') + ' ' + Format(Time) +
                        NewLine + 'REF: ' + Format(SkyMobileLoans."Entry No");
                        SendSms(Source::SkyMobile, SavAcc."Phone No.", msg, SavAcc."No.", '', true, Priority, false);



                        Priority := 211;
                        msg := 'Dear ' + Format(MobileLoanGuarantors."Guarantor Name") + NewLine + SkyMobileLoans."Account Name" +
                        ' has cancelled your guarantorship request on ' + SkyMobileLoans."Loan Name" + ' loan amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today, 0, '<Day,2>/<Month,2>/<Year4>') + ' ' + Format(Time) +
                        ' Please Accept/Decline By dialing ' + ShortCode + '.' + NewLine + 'REF: ' + Format(SkyMobileLoans."Entry No");
                        SendSms(Source::SkyMobile, MobileLoanGuarantors."Guarantor Mobile No.", msg, SavAcc."No.", '', true, Priority, false);

                    end;


                end
                else
                    if Action = 'ADD' then begin
                        MobileLoanGuarantors."Loan Entry No." := LoanEntryNo;
                        MobileLoanGuarantors."Guarantor Mobile No." := MobileNo;
                        MobileLoanGuarantors."Guarantor Dep. A/C" := DepAc;
                        MobileLoanGuarantors.Validate("Guarantor Member No.", Members."No.");
                        MobileLoanGuarantors."Loan Product" := SkyMobileLoans."Loan Product Type";
                        MobileLoanGuarantors."Loan Product Name" := '';
                        MobileLoanGuarantors."Guarantor Name" := Members.Name;
                        MobileLoanGuarantors."Date Created" := CurrentDatetime;
                        MobileLoanGuarantors.Modify;

                        if MobileLoanGuarantors."Guarantor Accepted" = MobileLoanGuarantors."guarantor accepted"::Pending then
                            Return := 'SUCCESS::::' + successText;
                        if MobileLoanGuarantors."Guarantor Accepted" = MobileLoanGuarantors."guarantor accepted"::No then begin
                            MobileLoanGuarantors."Guarantor Accepted" := MobileLoanGuarantors."guarantor accepted"::Pending;
                            MobileLoanGuarantors.Modify;
                            Return := 'SUCCESS::::' + successText;
                        end;
                        if MobileLoanGuarantors."Guarantor Accepted" = MobileLoanGuarantors."guarantor accepted"::Yes then begin
                            Return := 'SUCCESS::::' + successText;
                        end;


                        if SavAcc.Get(SkyMobileLoans."Account No") then begin
                            Priority := 211;
                            msg := 'Dear ' + Format(SkyMobileLoans."Account Name") + NewLine + 'You have Requested ' + MobileLoanGuarantors."Guarantor Name" +
                            ' to be your Guarantor on ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today, 0, '<Day,2>/<Month,2>/<Year4>') + ' ' + Format(Time) +
                            ' Please notify them to Accept By dialing ' + ShortCode + '.' + NewLine + 'REF: ' + Format(SkyMobileLoans."Entry No");
                            SendSms(Source::SkyMobile, SavAcc."Phone No.", msg, SavAcc."No.", '', true, Priority, false);



                            Priority := 211;
                            msg := 'Dear ' + Format(MobileLoanGuarantors."Guarantor Name") + NewLine + ', ' + SkyMobileLoans."Account Name" +
                            ' is Requesting your Guarantorship on ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today, 0, '<Day,2>/<Month,2>/<Year4>') + ' ' + Format(Time) +
                            ' Please Accept by dialing ' + ShortCode + ', Select Loans Option.' + NewLine + 'REF: ' + Format(SkyMobileLoans."Entry No");
                            SendSms(Source::SkyMobile, MobileLoanGuarantors."Guarantor Mobile No.", msg, SavAcc."No.", '', true, Priority, false);

                        end;


                    end;
            end
            else begin
                MobileLoanGuarantors.Init;
                MobileLoanGuarantors."Loan Entry No." := LoanEntryNo;
                MobileLoanGuarantors."Guarantor Mobile No." := MobileNo;
                MobileLoanGuarantors.Validate("Guarantor Member No.", Members."No.");
                MobileLoanGuarantors."Loan Product" := SkyMobileLoans."Loan Product Type";
                MobileLoanGuarantors."Loan Product Name" := '';
                MobileLoanGuarantors."Guarantor Name" := Members.Name;
                MobileLoanGuarantors."Date Created" := CurrentDatetime;
                MobileLoanGuarantors.Insert;
                Return := 'SUCCESS::::' + successText;


                if SavAcc.Get(SkyMobileLoans."Account No") then begin
                    Priority := 211;
                    msg := 'Dear ' + Format(SkyMobileLoans."Account Name") + NewLine + 'You have Requested ' + MobileLoanGuarantors."Guarantor Name" +
                    ' to be your Guarantor on ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today, 0, '<Day,2>/<Month,2>/<Year4>') + ' ' + Format(Time) +
                    ' Please notify them to Accept By dialing ' + ShortCode + '.' + NewLine + 'REF: ' + Format(SkyMobileLoans."Entry No");
                    SendSms(Source::SkyMobile, SavAcc."Phone No.", msg, SavAcc."No.", '', true, Priority, false);



                    Priority := 211;
                    msg := 'Dear ' + Format(MobileLoanGuarantors."Guarantor Name") + NewLine + SkyMobileLoans."Account Name" +
                    ' is Requesting your Guarantorship on ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today, 0, '<Day,2>/<Month,2>/<Year4>') + ' ' + Format(Time) +
                    ' Please Accept/Decline By dialing ' + ShortCode + '.' + NewLine + 'REF: ' + Format(SkyMobileLoans."Entry No");
                    SendSms(Source::SkyMobile, MobileLoanGuarantors."Guarantor Mobile No.", msg, SavAcc."No.", '', true, Priority, false);

                end;

            end;
        end;

    end;


    procedure GetRemainingGuarantorCount(LoanEntryNo: Guid): Integer
    var
        SkyMobileLoans: Record "Sky Mobile Loans";
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        LoanType: Record "Product Setup";
        MobileLoanGuarantors: Record "Mobile Loan Guarantors";
        RemGuar: Integer;
    begin

        SkyMobileLoans.Get(LoanEntryNo);

        LoanType.Get(SkyMobileLoans."Loan Product Type");
        RemGuar := SkyMobileLoans."Expected Guarantors";

        MobileLoanGuarantors.Reset;
        MobileLoanGuarantors.SetRange("Loan Entry No.", LoanEntryNo);
        MobileLoanGuarantors.SetRange("Guarantor Accepted", MobileLoanGuarantors."guarantor accepted"::Yes);
        //MobileLoanGuarantors.SETRANGE(Status,MobileLoanGuarantors.Status::Approved);
        if MobileLoanGuarantors.FindFirst then begin
            RemGuar -= MobileLoanGuarantors.Count;
            if RemGuar < 0 then
                RemGuar := 0;
        end;
    end;


    procedure MobileGuarantorsAccepted(LoanEntryNo: Guid): Boolean
    var
        SkyMobileLoans: Record "Sky Mobile Loans";
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        LoanType: Record "Product Setup";
        MobileLoanGuarantors: Record "Mobile Loan Guarantors";
        RemGuar: Integer;
        TotalGuaranteed: Decimal;
        LoaneeDeposits: Decimal;
        MNo: Code[20];
        GCount: Integer;
    begin

        SkyMobileLoans.Get(LoanEntryNo);

        LoanType.Get(SkyMobileLoans."Loan Product Type");
        GCount := SkyMobileLoans."Expected Guarantors";
        TotalGuaranteed := 0;

        MobileLoanGuarantors.Reset;
        MobileLoanGuarantors.SetRange("Loan Entry No.", LoanEntryNo);
        MobileLoanGuarantors.SetRange("Guarantor Accepted", MobileLoanGuarantors."guarantor accepted"::Yes);
        if MobileLoanGuarantors.FindFirst then begin
            MobileLoanGuarantors.CalcSums("Amount Guaranteed");
            TotalGuaranteed := MobileLoanGuarantors."Amount Guaranteed";
        end;

        LoaneeDepAcc := '';
        LoaneeDeposits := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", SkyMobileLoans."Account No");
        if SavingsAccounts.FindFirst then begin
            MNo := SavingsAccounts."Member No.";
            LoaneeDepAcc := MNo;
        end;

        if LoaneeDepAcc <> '' then
            LoaneeDeposits := GetAccountBalance(LoaneeDepAcc);


        //ERROR('%1\%2\%3',SkyMobileLoans."Requested Amount",TotalGuaranteed,LoaneeDeposits);

        if SkyMobileLoans."Requested Amount" > (TotalGuaranteed + LoaneeDeposits) then
            exit(false)
        else begin

            MobileLoanGuarantors.Reset;
            MobileLoanGuarantors.SetRange("Loan Entry No.", LoanEntryNo);
            MobileLoanGuarantors.SetRange("Guarantor Accepted", MobileLoanGuarantors."guarantor accepted"::Yes);
            if MobileLoanGuarantors.FindFirst then begin
                MobileLoanGuarantors.ModifyAll(Status, MobileLoanGuarantors.Status::Approved);
            end;

            exit(true);
        end;
    end;


    procedure UpdateAmountGuaranteed(LoanEntryNo: Guid)
    var
        SkyMobileLoans: Record "Sky Mobile Loans";
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        LoanType: Record "Product Setup";
        MobileLoanGuarantors: Record "Mobile Loan Guarantors";
        RemGuar: Integer;
        TotalGuaranteed: Decimal;
        LoaneeDeposits: Decimal;
        MNo: Code[20];
    begin

        SkyMobileLoans.Get(LoanEntryNo);

        if SkyMobileLoans."Expected Guarantors" > 0 then begin
            MobileLoanGuarantors.Reset;
            MobileLoanGuarantors.SetRange("Loan Entry No.", LoanEntryNo);
            MobileLoanGuarantors.SetRange("Guarantor Accepted", MobileLoanGuarantors."guarantor accepted"::Yes);
            //MobileLoanGuarantors.SETRANGE(Status,MobileLoanGuarantors.Status::Approved);
            if MobileLoanGuarantors.FindFirst then begin
                repeat
                    MobileLoanGuarantors.Validate("Guarantor Member No.");
                    MobileLoanGuarantors."Amount Guaranteed" := ROUND(SkyMobileLoans."Requested Amount" / SkyMobileLoans."Expected Guarantors", 0.01, '>');
                    MobileLoanGuarantors.Modify;
                until MobileLoanGuarantors.Next = 0;
            end;
        end;
    end;


    procedure ActionLoanGuarantorship(MobileNo: Code[20]; LoanEntryNo: Guid; PIN: Text; "Action": Code[20]) Response: Text
    var
        SkyMobileLoans: Record "Sky Mobile Loans";
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        LoanType: Record "Product Setup";
        MobileLoanGuarantors: Record "Mobile Loan Guarantors";
        RemGuar: Integer;
        TotalGuaranteed: Decimal;
        LoaneeDeposits: Decimal;
        MNo: Code[20];
        SavAcc: Record "Savings Accounts";
        msg: Text;
        GMNo: Code[20];
        Stop: Boolean;
    begin
        Response := 'ERROR';


        if CopyStr(MobileNo, 1, 1) <> '+' then
            MobileNo := '+' + MobileNo;

        if not CorrectPin(MobileNo, PIN) then begin
            Response := 'INCORRECT_PIN';
            exit;
        end;

        GMNo := '';

        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", MobileNo);
        if SavAcc.FindFirst then
            GMNo := SavAcc."Member No.";

        SkyMobileLoans.Get(LoanEntryNo);


        MobileLoanGuarantors.Reset;
        MobileLoanGuarantors.SetRange("Loan Entry No.", LoanEntryNo);
        MobileLoanGuarantors.SetRange("Guarantor Member No.", GMNo);
        if MobileLoanGuarantors.FindFirst then begin
            if Action = 'ACCEPT' then begin
                MobileLoanGuarantors."Guarantor Accepted" := MobileLoanGuarantors."guarantor accepted"::Yes;

                if SavAcc.Get(SkyMobileLoans."Account No") then begin

                    Priority := 211;
                    msg := 'Dear ' + Format(SkyMobileLoans."Account Name") + ', ' + MobileLoanGuarantors."Guarantor Name" +
                    ' has accepted your Guarantorship on ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today, 0, '<Day,2>/<Month,2>/<Year4>') + ' ' + Format(Time) +
                    ' Your Loan will be Processed Shortly.' + NewLine + 'REF: ' + Format(SkyMobileLoans."Entry No");
                    SendSms(Source::SkyMobile, SavAcc."Phone No.", msg, SavAcc."No.", '', true, Priority, false);

                    Priority := 211;
                    msg := 'Dear ' + Format(MobileLoanGuarantors."Guarantor Name") + ', You have successfully accepted to Guarantee ' + SkyMobileLoans."Account Name" +
                    ' ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today, 0, '<Day,2>/<Month,2>/<Year4>') + ' ' + Format(Time) + '.' + NewLine + 'REF: ' + Format(SkyMobileLoans."Entry No");
                    SendSms(Source::SkyMobile, MobileLoanGuarantors."Guarantor Mobile No.", msg, SavAcc."No.", '', true, Priority, false);

                    Response := 'SUCCESS';
                end;
            end
            else
                if Action = 'REJECT' then begin
                    MobileLoanGuarantors."Guarantor Accepted" := MobileLoanGuarantors."guarantor accepted"::No;

                    Priority := 211;
                    msg := 'Dear ' + Format(SkyMobileLoans."Account Name") + ', ' + MobileLoanGuarantors."Guarantor Name" +
                    ' has rejected your Guarantorship on ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today, 0, '<Day,2>/<Month,2>/<Year4>') + ' ' + Format(Time) +
                    ' Kindly add a new guarantor.' + NewLine + 'REF: ' + Format(SkyMobileLoans."Entry No");
                    SendSms(Source::SkyMobile, SavAcc."Phone No.", msg, SavAcc."No.", '', true, Priority, false);

                    Priority := 211;
                    msg := 'Dear ' + Format(MobileLoanGuarantors."Guarantor Name") + ', You have rejected to Guarantee ' + SkyMobileLoans."Account Name" +
                    ' ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today, 0, '<Day,2>/<Month,2>/<Year4>') + ' ' + Format(Time) + '.' + NewLine + 'REF: ' + Format(SkyMobileLoans."Entry No");
                    SendSms(Source::SkyMobile, MobileLoanGuarantors."Guarantor Mobile No.", msg, SavAcc."No.", '', true, Priority, false);
                    Response := 'SUCCESS';
                end;
            MobileLoanGuarantors.Modify;
        end
        else
            Error('Guarantor Not Found');

        Commit;
        ProcessMobileLoan(LoanEntryNo, stop);
    end;


    procedure GetMaximumMobileLoanLimit(): Decimal
    var
        GenSetup: Record "Sacco Setup";
    begin


        GenSetup.Get;
        //EXIT(GenSetup."Maximum Mobile Loan Limit");
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


    procedure GetLoanPendingGuarantor(PhoneNo: Code[20]) Response: Text
    var
        SkyMobileLoans: Record "Sky Mobile Loans";
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        LoanType: Record "Product Setup";
        MobileLoanGuarantors: Record "Mobile Loan Guarantors";
        RemGuar: Integer;
        SavAcc: Record "Savings Accounts";
        msg: Text;
        Loans: Record Loans;
        LoanG: Record "Loan Security";
        ProductName: Text;
    begin

        PhoneNo := '+' + PhoneNo;
        Response := 'NULL';

        SkyMobileLoans.Reset;
        SkyMobileLoans.SetRange("Telephone No", PhoneNo);
        SkyMobileLoans.SetRange(Status, SkyMobileLoans.Status::"Pending Guarantors");
        if SkyMobileLoans.FindFirst then begin

            LoanType.Get(SkyMobileLoans."Loan Product Type");
            ProductName := LoanType."USSD Product Name";
            if ProductName = '' then
                ProductName := LoanType.Description;

            Response := '<Loan>';
            Response += '<EntryNo>' + Format(SkyMobileLoans."Entry No") + '</EntryNo>';
            Response += '<ProductName>' + ProductName + '</ProductName>';
            Response += '<RequestedAmount>' + Format(SkyMobileLoans."Requested Amount") + '</RequestedAmount>';
            Response += '<LoanStatus>' + Format(SkyMobileLoans.Status) + '</LoanStatus>';
            Response += '<Guarantors>';
            MobileLoanGuarantors.Reset;
            MobileLoanGuarantors.SetRange("Loan Entry No.", SkyMobileLoans."Entry No");
            if MobileLoanGuarantors.FindFirst then begin
                repeat
                    Response += '<GuarantorDetail>';
                    Response += '<GuarantorName>' + Format(MobileLoanGuarantors."Guarantor Name") + '</GuarantorName>';
                    Response += '<MemberNo>' + MobileLoanGuarantors."Guarantor Member No." + '</MemberNo>';
                    Response += '<PhoneNo>' + MobileLoanGuarantors."Guarantor Mobile No." + '</PhoneNo>';
                    Response += '<LoanStatus>' + Format(MobileLoanGuarantors.Status) + '</LoanStatus>';
                    Response += '</GuarantorDetail>';
                until MobileLoanGuarantors.Next = 0;

            end;
            Response += '</Guarantors>';
            Response += '</Loan>';
        end;
    end;


    procedure GetMemberAlerts(PhoneNo: Code[20]) Response: Text
    var
        SkyAlerts: Record "Sky Alerts";
        MobileLoan: Record "Sky Mobile Loans";
        RandNo: Integer;
        Loans: Record Loans;
        SavAcc: Record "Savings Accounts";
    begin
        Response := '';
        PhoneNo := '+' + PhoneNo;



        SkyAlerts.Reset;
        SkyAlerts.SetRange(Status, SkyAlerts.Status::Visible);
        if SkyAlerts.Find('-') then begin
            Response := '<News>';
            repeat
                Response += '<Article>';
                Response += '<Type>' + Format(SkyAlerts.Type) + '</Type>';
                Response += '<Title>' + SkyAlerts.Title + '</Title>';
                Response += '<Body>' + SkyAlerts.Body + '</Body>';
                Response += '</Article>';
            until SkyAlerts.Next = 0;
            Response += '</News>';
        end;
    end;


    procedure BenefitConfirmed(LoanType: Code[20]; Amount: Decimal; AccountNo: Code[20]; QualAmt: Decimal) Response: Text
    var
        Loans: Record Loans;
        loanBal: Decimal;
        Vendor: Record "Savings Accounts";
        LoanProductTypes: Record "Product Setup";
    begin
        Response := 'SUCCESS';
    end;

    procedure GetMemberBalances(PhoneNo: Text[30]; AccountType: Text) Response: Text
    var
        SavAcc: Record "Savings Accounts";
        ProdFact: Record "Product Setup";
        Found: Boolean;
        MemberNo: Code[20];
        IDNo: Code[20];
        Members: Record Members;
        AccBal: Decimal;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomFee: Decimal;
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        Loans: Record Loans;
    begin

        PhoneNo := '+' + PhoneNo;
        Response := '';
        Found := false;



        IDNo := '';
        MemberNo := '';
        SavAcc.Reset;
        SavAcc.SetRange("Transactional Mobile No", PhoneNo);
        if SavAcc.FindFirst then begin
            SavAcc.CalcFields("ID No.");
            MemberNo := SavAcc."Member No.";
            IDNo := SavAcc."ID No.";
        end;



        //IF MemberNo='' THEN
        //  EXIT;
        if IDNo = '' then
            exit;

        if not Members.Get(MemberNo) then
            MemberNo := IDNo;



        Response := '<ACCOUNTS_AND_CATEGORIES>';
        Response += '<CATEGORIES>';
        Response += '<CATEGORY LABEL="ALL" NAME="ALL"/>';
        Response += '<CATEGORY LABEL="FOSA" NAME="FOSA"/>';
        Response += '<CATEGORY LABEL="BOSA" NAME="BOSA"/>';
        Response += '<CATEGORY LABEL="MICRO" NAME="MICRO"/>';
        Response += '</CATEGORIES>';

        if AccountType = 'ACCOUNTS' then begin
            Response += '<ACCOUNTS>';

            SavAcc.Reset;
            SavAcc.SetRange("ID No.", IDNo);
            if SavAcc.Find('-') then begin
                repeat

                    AccBal := GetAccountBalance(SavAcc."No.");
                    Response += '<ACCOUNT NAME="' + SavAcc."Product Type" + '" BALANCE="' + Format(AccBal) + '" NUMBER="' + SavAcc."No." + '" CATEGORIES="FOSA|ALL"/>';
                until SavAcc.Next = 0;
            end;

            Response += '</ACCOUNTS>';
        end;


        if AccountType = 'LOANS' then begin

            Response += '<ACCOUNTS>';

            Members.Reset;
            Members.SetRange("ID No.", IDNo);
            if Members.Find('-') then begin
                repeat

                    Loans.Reset;
                    Loans.SetRange("Member No.", Members."No.");
                    Loans.SetFilter("Outstanding Principal", '>0');
                    if Loans.Find('-') then begin
                        repeat
                            Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
                            if Loans."Outstanding Interest" <= 0 then
                                Loans."Outstanding Interest" := GetClearingLoanInterest(Loans);

                            AccBal := Loans."Outstanding Principal" + Loans."Outstanding Interest";
                            Response += '<ACCOUNT NAME="' + Loans."Loan Product Type Name" + '" BALANCE="' + Format(AccBal) + '" NUMBER="' + Loans."Loan No." + '" CATEGORIES="' + Format(Loans.Source) + '|ALL"/>';
                        until Loans.Next = 0;
                    end;
                until Members.Next = 0;
            end;

            Response += '</ACCOUNTS>';
        end;

        Response += '</ACCOUNTS_AND_CATEGORIES>';
    end;


    procedure AccountMiniStatementMobileAppB64(StartDate: Date; EndDate: Date; StatementAccount: Code[20]) Response: Text
    var
        NumberOfDays: Integer;
        FileName: Text;
        GeneralSetUp: Record "Sacco Setup";
        DirectoryPath: Text;
        SkyFileManagement: Codeunit "File Management";
        SkyTempBlob: Record CustomTempBlob;
        Base64File: Text;
        TransactionDate: DateTime;
        SLedger: Record "Savings Ledger Entry";
        Vendor: Record "Savings Accounts";
        Members: Record Members;
    begin
        GeneralSetUp.Get;
        DirectoryPath := GeneralSetUp."Statement Path B64";
        //MESSAGE(DirectoryPath);
        NumberOfDays := EndDate - StartDate;
        TransactionDate := CurrentDatetime;
        //MobileNo:='+'+MobileNo;
        /*
        SLedger.RESET;
        SLedger.SETRANGE("Account No.",StatementAccount);
        SLedger.SETRANGE("Posting Date",StartDate,EndDate);
        IF SLedger.FINDFIRST THEN BEGIN
          FileName := DirectoryPath+'\'+SLedger."Account No."+'-stmt.pdf';
          //FileName := DirectoryPath+'\'+'sample.pdf';
          //Report.SaveAsPdf(39004353,FileName,SLedger);
          SkyFileManagement.BLOBImportFromServerFile(SkyTempBlob,FileName);
          Base64File := FORMAT(SkyTempBlob.ToBase64String);
        END;
        */

        Vendor.Reset;
        Vendor.SetRange("No.", StatementAccount);
        Vendor.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
        if Vendor.FindFirst then begin
            FileName := DirectoryPath + '\' + StatementAccount + '-stmt.pdf';
            //FileName := DirectoryPath+'\'+'sample.pdf';
            ////Report.SaveAsPdf(Report::"Savings Statement", FileName, Vendor);


            Base64File := Format(SkyTempBlob.ToBase64String);

        end
        else begin


            Members.Reset;
            Members.SetRange("No.", StatementAccount);
            Members.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
            if Members.FindFirst then begin
                FileName := DirectoryPath + '\' + StatementAccount + '-stmt.pdf';
                //FileName := DirectoryPath+'\'+'sample.pdf';
                //Report.SaveAsPdf(Report::"Detailed Member Statement", FileName, Members);
                //SkyTempBlob.BLOBImportFromServerFile(SkyTempBlob, FileName);
                Base64File := Format(SkyTempBlob.ToBase64String);
            end

        end;

        Response := Base64File;
        //ERASE(FileName);

    end;


    procedure GetRecoveryModes() Response: Text
    begin

        Response := '';
        Response += '<RecoveryModes>';

        Response += '<Mode>';
        Response += '<Code>' + 'Cash' + '</Code>';
        Response += '<Name>' + 'Cash' + '</Name>';
        Response += '</Mode>';

        Response += '<Mode>';
        Response += '<Code>' + 'Salary' + '</Code>';
        Response += '<Name>' + 'Salary' + '</Name>';
        Response += '</Mode>';

        Response += '<Mode>';
        Response += '<Code>' + 'Checkoff' + '</Code>';
        Response += '<Name>' + 'Checkoff' + '</Name>';
        Response += '</Mode>';

        Response += '<Mode>';
        Response += '<Code>' + 'Standing Order' + '</Code>';
        Response += '<Name>' + 'Standing Order' + '</Name>';
        Response += '</Mode>';

        Response += '</RecoveryModes>';
    end;


    procedure GetLoanPurpose() Response: Text
    begin
        Response := '';


        Response := '<LoanApplicationPurposes>';
        Response += '<Purpose Id="1150" Title="Agriculture"/>';
        Response += '<Purpose Id="2120" Title="Trade"/>';
        Response += '<Purpose Id="3120" Title="Manufacturing and Services Industries"/>';
        Response += '<Purpose Id="4120" Title="Education"/>';
        Response += '<Purpose Id="5110" Title="Human Health"/>';
        Response += '<Purpose Id="6230" Title="Land and Housing"/>';
        Response += '<Purpose Id="7210" Title="Finance Investment and Insurance"/>';
        Response += '<Purpose Id="8210" Title="Consumption and Social activities"/>';
        Response += '</LoanApplicationPurposes>';
    end;



    local procedure GetClearingLoanInterest(Loans: Record Loans) Interest: Decimal
    var
        LTYPE: Record "Product Setup";
    begin
        // ERROR(loanno);
        Interest := 0;
        PostInterestDue := false;
        InterestGL := '';

        Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest");

        if Loans."Outstanding Principal" > 0 then begin

            Interest := Loans."Outstanding Interest";


        end;

        if Loans.Source = Loans.Source::MICRO then begin

            Interest := (Loans."Outstanding Principal" * (Loans."Annual Interest %" / 100));
        end;

        if Interest < 0 then
            Interest := 0;
    end;

    procedure ddMMyyyy(Date: Date) NewDate: Text
    var
        d: Text;
        m: Text;
        y: Text;
    begin

        d := Format(Date2dmy(Date, 1));
        m := Format(Date2dmy(Date, 2));
        y := Format(Date2dmy(Date, 3));

        if StrLen(d) = 1 then
            d := '0' + d;

        if StrLen(m) = 1 then
            m := '0' + m;

        NewDate := d + '/' + m + '/' + y;
    end;


    procedure CheckLoanBlackList(IDNo: Text): Boolean
    var
        BIDNos: Record "Sky Mobile Loan Black-List";
    begin

        if IDNo <> '' then begin
            if BIDNos.Get(IDNo) then
                if BIDNos."Black-Listed" then
                    exit(true);
        end;

        exit(false);
    end;

    local procedure MobileLoanReminder()
    var
        Loans: Record Loans;
        ProductFactory: Record "Product Setup";
        LBal: Decimal;
        SavAcc: Record "Savings Accounts";
        msg: Text;
        AmtPaid: Decimal;
        Variance: Decimal;
        GeneralSetUp: Record "Sacco Setup";
        RepDate: Date;
        d: Integer;
        m: Integer;
        y: Integer;
    begin
        GeneralSetUp.Get;

        if Time < GeneralSetUp."SMS Time" then
            exit;

        Loans.Reset;
        Loans.SetRange("Send SMS Reminder", true);
        Loans.SetRange("Mobile Loan", true);
        Loans.SetRange("Repay Mode", Loans."Repay Mode"::Cash);
        Loans.SetFilter("Date Filter", '..%1', CalcDate('CM', Today));
        Loans.SetFilter("Outstanding Principal", '>0');
        Loans.SetFilter("Disbursement Date", '<%1', CalcDate('-20D', Today));
        Loans.SetFilter("Last Mobile Loan Rem. Date", '<%1', Today);
        Loans.SetFilter("Mobile Loan Reminder", '%1|%2|%3',
                        Loans."mobile loan reminder"::" ",
                        Loans."mobile loan reminder"::"1",
                        Loans."mobile loan reminder"::"2");
        if Loans.FindFirst then begin
            repeat

                if ProductFactory.Get(Loans."Loan Product Type") then begin
                    if ProductFactory."Available on Mobile" then begin
                        Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Schedule Principal");

                        if Loans."Outstanding Interest" < 0 then
                            Loans."Outstanding Interest" := 0;

                        LBal := Loans."Outstanding Principal";
                        AmtPaid := Loans."Approved Amount" - LBal;
                        if AmtPaid < 0 then
                            AmtPaid := 0;

                        Variance := Loans."Schedule Principal" - AmtPaid;
                        if Loans."Completion Date" <= Today then
                            Variance := Loans."Approved Amount" - AmtPaid;

                        Variance += Loans."Outstanding Interest";



                        if Variance < 0 then
                            Variance := 0;

                        Priority := 241;
                        Loans."Last Mobile Loan Rem. Date" := Today;


                        if (SavAcc.Get(Loans."Disbursement Account No")) and (Variance > 0) then begin
                            if Loans."Mobile Loan Reminder" = Loans."mobile loan reminder"::" " then begin
                                if CalcDate('-5D', Loans."Repayment Start Date") <= Today then begin
                                    msg := 'Dear ' + FirstName(SavAcc.name) + ',' + NewLine + 'Your ' + ProductFactory.Description + 'of Kshs ' + Format(Loans."total outstanding Balance")
                                            + ' is due on ' + ddMMyyyy(Loans."Repayment Start Date") + '. Expected repayment is Kshs ' + Format(Variance)
                                            + '. To repay dial Dial *470# and follow prompts.';

                                    SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, Loans."Loan No.", SavAcc."No.", false, Priority, false);
                                    Loans."Mobile Loan Reminder" := Loans."mobile loan reminder"::"1";
                                    Loans.Modify;
                                    Commit;
                                end;
                            end
                            else
                                if Loans."Mobile Loan Reminder" = Loans."mobile loan reminder"::"1" then begin
                                    if Date2DMY(loans."Repayment Start Date", 1) = Date2DMY(today, 1) then begin

                                        msg := 'Dear ' + FirstName(SavAcc.name) + ',' + NewLine + 'Your ' + ProductFactory.Description + 'of Kshs ' + Format(Loans."total outstanding Balance")
                                                + ' is due Today. Expected repayment is Kshs ' + Format(Variance)
                                                + '. Expected repayment is Kshs ' + Format(Variance)
                                                + '. To repay dial Dial *470# and follow prompts.';

                                        SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, Loans."Loan No.", SavAcc."No.", false, Priority, false);
                                        Loans."Mobile Loan Reminder" := Loans."mobile loan reminder"::"2";
                                        Loans.Modify;
                                        Commit;
                                    end;
                                end
                                else
                                    if Loans."Mobile Loan Reminder" = Loans."mobile loan reminder"::"2" then begin


                                        d := Date2DMY(loans."Repayment Start Date", 1);
                                        if d > Date2DMY(CalcDate('CM', today), 1) then
                                            d := Date2DMY(CalcDate('CM', today), 1);

                                        m := Date2DMY(today, 2);
                                        y := Date2DMY(today, 3);
                                        RepDate := DMY2Date(d, m, y);
                                        if (Loans."Last Defaulter SMS Date" = 0D) then begin
                                            if calcdate('5D', RepDate) <= Today then begin

                                                msg := 'Dear ' + FirstName(SavAcc.name) + ',' + NewLine + 'Your ' + ProductFactory.Description + 'of Kshs ' + Format(Loans."total outstanding Balance")
                                                        + 'is DEFAULTED. Make immediate payments to repay and grow your limit. To repay dial Dial *470# and follow prompts.';


                                                SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, Loans."Loan No.", SavAcc."No.", false, Priority, false);
                                                Loans."Mobile Loan Reminder" := Loans."mobile loan reminder"::"2";
                                                Loans."Last Defaulter SMS Date" := today;
                                                Loans.Modify;
                                                Commit;
                                            end;
                                        end
                                        else begin

                                            if (Loans."Last Defaulter SMS Date" <= CalcDate('-10D', Today)) then begin

                                                msg := 'Dear ' + FirstName(SavAcc.name) + ',' + NewLine + 'Your ' + ProductFactory.Description + 'of Kshs ' + Format(Loans."total outstanding Balance")
                                                        + 'is DEFAULTED. Make immediate payments to repay and grow your limit. To repay dial Dial *470# and follow prompts.';


                                                SendSms(Source::SkyMobile, SavAcc."Transactional Mobile No", msg, Loans."Loan No.", SavAcc."No.", false, Priority, false);
                                                Loans."Mobile Loan Reminder" := Loans."mobile loan reminder"::"2";
                                                Loans."Last Defaulter SMS Date" := today;
                                                Loans.Modify;
                                                Commit;
                                            end;
                                        end;

                                    end;
                        end;
                    end;
                end;
                Loans."Last Mobile Loan Rem. Date" := Today;
                Loans.Modify;
            until Loans.Next = 0;
        end;
    end;



    local procedure OverdueLoanReminder()
    var
        Loans: Record Loans;
        ProductFactory: Record "Product Setup";
        LBal: Decimal;
        SavAcc: Record "Savings Accounts";
        msg: Text;
        AmtPaid: Decimal;
        Variance: Decimal;
        GeneralSetUp: Record "Sacco Setup";
        RepDate: Date;
    begin
        GeneralSetUp.Get;

        if Time < GeneralSetUp."SMS Time" then
            exit;

        Loans.Reset;
        //Loans.SetFilter("As At", '%1', Today);
        Loans.SetFilter("Outstanding Principal", '>0');
        //Loans.SetFilter("Total Arrears", '%1', CalcDate('-10D', Today));
        //Loans.SetFilter("Last Overdue SMS Date", '<%1', calcdate('-1M+CM', Today));
        Loans.SetFilter("Mobile Loan Reminder", '%1|%2|%3',
                        Loans."mobile loan reminder"::" ",
                        Loans."mobile loan reminder"::"1",
                        Loans."mobile loan reminder"::"2");
        if Loans.FindFirst then begin
            repeat

                if ProductFactory.Get(Loans."Loan Product Type") then begin
                    if ProductFactory."Available on Mobile" then begin
                        Loans.CalcFields("Outstanding Principal", "Outstanding Interest");

                        if Loans."Outstanding Interest" < 0 then
                            Loans."Outstanding Interest" := 0;

                        LBal := Loans."Outstanding Principal";
                        AmtPaid := Loans."Approved Amount" - LBal;
                        if AmtPaid < 0 then
                            AmtPaid := 0;

                        Variance := Loans."Loan Principle Repayment" - AmtPaid;
                        if Loans."Completion Date" <= Today then
                            Variance := Loans."Approved Amount" - AmtPaid;

                        Variance += Loans."Outstanding Interest";

                        if Variance < 0 then
                            Variance := 0;

                        Priority := 241;
                        Loans."Last Mobile Loan Rem. Date" := Today;


                        if SavAcc.Get(Loans."Disbursement Account No") then begin
                            if Loans."Mobile Loan Reminder" = Loans."mobile loan reminder"::" " then begin
                                if CalcDate('-1D', Loans."Repayment Start Date") <= Today then begin
                                    msg := 'Dear ' + FirstName(SavAcc.name) + ',' + NewLine + 'Your ' + ProductFactory.Description + ' expected repayment of Kshs ' +
                                    Format(Variance) + ' is due on ' + ddMMyyyy(Loans."Repayment Start Date") + '. To pay, Dial ' + ShortCode + ' or go to our mobile app';
                                    SendSms(Source::SkyMobile, SavAcc."Phone No.", msg, Loans."Loan No.", SavAcc."No.", false, Priority, false);
                                    Loans."Mobile Loan Reminder" := Loans."mobile loan reminder"::"1";
                                    Loans.Modify;
                                    Commit;
                                end;
                            end
                            else
                                if Loans."Mobile Loan Reminder" = Loans."mobile loan reminder"::"1" then begin
                                    if CalcDate('-1D', Loans."Completion Date") <= Today then begin
                                        msg := 'Dear ' + FirstName(SavAcc.name) + ',' + NewLine + 'Your ' + ProductFactory.Description + ' expected repayment of Kshs ' +
                                        Format(Variance) + ' is due on ' + ddMMyyyy(Loans."Completion Date") + '. To pay, Dial ' + ShortCode + ' or go to our mobile app';

                                        SendSms(Source::SkyMobile, SavAcc."Phone No.", msg, Loans."Loan No.", SavAcc."No.", false, Priority, false);
                                        Loans."Mobile Loan Reminder" := Loans."mobile loan reminder"::"2";
                                        Loans.Modify;
                                        Commit;
                                    end;
                                end
                                else
                                    if Loans."Mobile Loan Reminder" = Loans."mobile loan reminder"::"2" then begin
                                        if Loans."Completion Date" <= Today then begin
                                            msg := 'Dear ' + FirstName(SavAcc.name) + ',' + NewLine + 'Your ' + ProductFactory.Description + ' expected repayment of Kshs ' +
                                            Format(Variance) + ' was due on ' + ddMMyyyy(Loans."Completion Date") + '. To pay, Dial ' + ShortCode + ' or go to our mobile app';

                                            SendSms(Source::SkyMobile, SavAcc."Phone No.", msg, Loans."Loan No.", SavAcc."No.", false, Priority, false);
                                            Loans."Mobile Loan Reminder" := Loans."mobile loan reminder"::"2";
                                            Loans.Modify;
                                            Commit;
                                        end;
                                    end;
                        end;
                    end;
                end;
                Loans."Last Mobile Loan Rem. Date" := Today;
                Loans.Modify;
            until Loans.Next = 0;
        end;
    end;

    procedure GenerateStartPins()
    var
        SkyworldUSSDAuth: Record "Sky USSD Auth";
        NewPin: Text;
        NewIntPin: Integer;
        SavAcc: Record "Savings Accounts";
        Msg: Text;
        SkyMbankingNos: Record "Mbanking Nos Send Pin";
        MPESAApplication: record "MBanking Applications";
        OldApplications: record "MPESA Applications";

    begin


        /*
        OldApplications.Reset();
        OldApplications.SetRange(Status, OldApplications.Status::Approved);
        if OldApplications.FindFirst() then begin
            repeat
                if MPESAApplication.Get(OldApplications.No) then begin
                    MPESAApplication.Status := MPESAApplication.Status::Approved;
                    MPESAApplication.modify;
                end;
            until OldApplications.next = 0;
        end;
        */

        MPESAApplication.Reset;
        MPESAApplication.SetRange(MPESAApplication.Status, MPESAApplication.Status::Approved);
        MPESAApplication.SetFilter(MPESAApplication."Mpesa Mobile No", '<>%1', '');
        if MPESAApplication.FindFirst then begin
            repeat
                if StrLen(MPESAApplication."Customer ID No") <= 20 then begin
                    Vendor.Reset;
                    Vendor.SetRange("ID No.", MPESAApplication."Customer ID No");
                    Vendor.SetFilter("Transactional Mobile No", MPESAApplication."Mpesa Mobile No");
                    if Vendor.FindFirst then begin
                        repeat
                            SkyMbankingNos.Reset();
                            SkyMbankingNos.SetRange("Mobile No.", MPESAApplication."MPESA Mobile No");
                            if SkyMbankingNos.FindFirst() then begin

                                vendor.calcfields("ID No.");
                                SkyMbankingNos."Mobile No." := MPESAApplication."MPESA Mobile No";
                                SkyMbankingNos."Account No." := vendor."No.";
                                SkyMbankingNos."ID No." := vendor."ID No.";
                                SkyMbankingNos.Modify();
                            end
                            else begin

                                vendor.calcfields("ID No.");

                                SkyMbankingNos.init;
                                SkyMbankingNos."Mobile No." := MPESAApplication."MPESA Mobile No";
                                SkyMbankingNos."Account No." := vendor."No.";
                                SkyMbankingNos."ID No." := vendor."ID No.";
                                SkyMbankingNos.Insert();
                            end;

                        until Vendor.Next = 0;
                    end;
                end;
            until MPESAApplication.Next = 0;
        end;

        SkyMbankingNos.Reset;
        //SkyMbankingNos.SETRANGE("Account No.",'1214473');
        //SkyMbankingNos.SETFILTER("Mobile No.",'254726563563|254721206769|254728152774');
        SkyMbankingNos.SetRange("Pin Sent", false);
        if SkyMbankingNos.FindFirst then begin
            repeat

                SavAcc.Reset;
                SavAcc.SetRange("No.", SkyMbankingNos."Account No.");
                SavAcc.SetRange("Transactional Mobile No", SkyMbankingNos."Mobile No.");
                SavAcc.SetFilter("ID No.", '<>%1', '');
                if SavAcc.FindFirst then begin

                    //MESSAGE('1');
                    SkyworldUSSDAuth.Reset;
                    SkyworldUSSDAuth.SetRange("Mobile No.", SavAcc."Transactional Mobile No");
                    if not SkyworldUSSDAuth.FindFirst then begin
                        //MESSAGE('2');
                        Priority := 211;
                        NewPin := RandomPIN;
                        Msg := 'Dear ' + FirstName(SavAcc.Name) + ', welcome to ' + CompanyName + ' new mobile banking service ' + MbankingName + '. Your Start pin is ' + NewPin +
                        '. Dial ' + ShortCode + ' to activate this service. For Enquiries call 0111173000';


                        //SendSms(Source::PIN,SkyworldUSSDAuth."Mobile No.",Msg,SavAcc."No.",'',TRUE,Priority,FALSE);

                        SkyworldUSSDAuth.Init;
                        SkyworldUSSDAuth."Mobile No." := SavAcc."Transactional Mobile No";
                        SkyworldUSSDAuth."Account No." := SavAcc."No.";
                        SkyworldUSSDAuth."PIN No." := NewPin;
                        SkyworldUSSDAuth."User Status" := SkyworldUSSDAuth."user status"::Active;
                        SkyworldUSSDAuth."Force PIN" := true;
                        SkyworldUSSDAuth.Insert;


                        SkyMbankingNos.SMS := Msg;
                        SkyMbankingNos."Pin Sent" := true;
                        SkyMbankingNos.Modify;
                    end;
                end;
            until SkyMbankingNos.Next = 0;
        end;
    end;


    procedure RemoveCASH()
    var
        SkyworldUSSDAuth: Record "Sky USSD Auth";
        NewPin: Text;
        NewIntPin: Integer;
        SavAcc: Record "Savings Accounts";
        Msg: Text;
        SkyMbankingNos: Record "Mbanking Nos Send Pin";
    begin

        SkyMbankingNos.Reset;
        //SkyMbankingNos.SETRANGE("Account No.",'1214473');
        //SkyMbankingNos.SETFILTER("Mobile No.",'254726563563|254721206769|254728152774');
        SkyMbankingNos.SetRange("Pin Sent", true);
        SkyMbankingNos.SetRange("SMS Sent", false);
        SkyMbankingNos.SetFilter(SMS, '<>%1', '');
        if SkyMbankingNos.FindFirst then begin
            repeat
                SkyMbankingNos.SMS := DelChr(SkyMbankingNos.SMS, '=', 'CASH');
                SkyMbankingNos.Modify();
            until SkyMbankingNos.Next = 0;
        end;
    end;

    procedure SendStartPins()
    var
        SkyworldUSSDAuth: Record "Sky USSD Auth";
        NewPin: Text;
        NewIntPin: Integer;
        SavAcc: Record "Savings Accounts";
        Msg: Text;
        SkyMbankingNos: Record "Mbanking Nos Send Pin";
    begin

        SkyMbankingNos.Reset;
        //SkyMbankingNos.SETRANGE("Account No.",'1214473');
        //SkyMbankingNos.SETFILTER("Mobile No.",'254726563563|254721206769|254728152774');
        SkyMbankingNos.SetRange("Pin Sent", true);
        SkyMbankingNos.SetRange("SMS Sent", false);
        SkyMbankingNos.SetFilter(SMS, '<>%1', '');
        if SkyMbankingNos.FindFirst then begin
            repeat

                SavAcc.Reset;
                SavAcc.SetRange("No.", SkyMbankingNos."Account No.");
                SavAcc.SetRange("Transactional Mobile No", SkyMbankingNos."Mobile No.");
                SavAcc.SetFilter("ID No.", '<>%1', '');
                if SavAcc.FindFirst then begin
                    SkyworldUSSDAuth.Reset;
                    SkyworldUSSDAuth.SetRange("Mobile No.", SavAcc."Transactional Mobile No");
                    if SkyworldUSSDAuth.FindFirst then begin
                        SkyworldUSSDAuth."Login Attempts Count" := 0;
                        SkyworldUSSDAuth."Login Attempts Tag" := '';
                        SkyworldUSSDAuth."Login Attempts Action" := '';
                        SkyworldUSSDAuth."Login Attempts Action Expiry" := 0DT;
                        SkyworldUSSDAuth.Modify;
                        SendSms(Source::PIN, SkyworldUSSDAuth."Mobile No.", SkyMbankingNos.SMS, SavAcc."No.", '', false, Priority, false);
                        SkyMbankingNos."SMS Sent" := true;
                        SkyMbankingNos.Modify;
                    end;
                end;
            until SkyMbankingNos.Next = 0;
        end;
    end;



    procedure ClearMbankingSuspension()
    var
        SkyworldUSSDAuth: Record "Sky USSD Auth";
        NewPin: Text;
        NewIntPin: Integer;
        SavAcc: Record "Savings Accounts";
        Msg: Text;
    begin


        SkyworldUSSDAuth.Reset;
        SkyworldUSSDAuth.SetFilter(Entries, '>1');
        if SkyworldUSSDAuth.FindFirst then begin
            repeat
                SavAcc.Reset();
                SavAcc.SetRange("No.", SkyworldUSSDAuth."Account No.");
                SavAcc.SetRange("Transactional Mobile No", SkyworldUSSDAuth."Mobile No.");
                if not SavAcc.FindFirst() then begin
                    SkyworldUSSDAuth.delete;
                end;
            until SkyworldUSSDAuth.next() = 0;
        end;

        SkyworldUSSDAuth.Reset;
        SkyworldUSSDAuth.SetRange("Clear M-Banking Suspension", true);
        if SkyworldUSSDAuth.FindFirst then begin
            repeat
                /*
                    SkyworldUSSDAuth."Login Attempts Count" := 0;
                    SkyworldUSSDAuth."Login Attempts Tag" := '';
                    SkyworldUSSDAuth."Login Attempts Action" := '';
                    SkyworldUSSDAuth."Login Attempts Action Expiry" := 0DT;
                    SkyworldUSSDAuth."OTP Attempts Action Expiry" := 0DT;
                    SkyworldUSSDAuth."Clear M-Banking Suspension" := false;
                    */



                SkyworldUSSDAuth."Login Attempts Action" := 'NONE';
                SkyworldUSSDAuth."Login Attempts Tag" := '';
                Clear(SkyworldUSSDAuth."Login Attempts Action Expiry");
                SkyworldUSSDAuth."Login Attempts Count" := 0;
                SkyworldUSSDAuth."OTP Attempts Action" := 'NONE';
                SkyworldUSSDAuth."OTP Attempts Tag" := '';
                Clear(SkyworldUSSDAuth."OTP Attempts Action Expiry");
                SkyworldUSSDAuth."OTP Attempts Count" := 0;
                SkyworldUSSDAuth."Clear M-Banking Suspension" := false;
                SkyworldUSSDAuth.Modify;

                if SavAcc.get(SkyworldUSSDAuth."Account No.") then begin
                    Msg := 'Dear ' + FirstName(SavAcc.Name) + ', your mbanking account has been activated. Dial *882# to access your account';
                    SendSms(Source::PIN, SkyworldUSSDAuth."Mobile No.", Msg, SavAcc."No.", '', false, Priority, false);
                end
            until SkyworldUSSDAuth.next = 0;
        end;

    end;

    procedure GetAbilityToRepay(AccountNo: Code[20]; LoanProduct: Code[20]) Ability: Decimal
    var
        CheckOffDeposits: Decimal;
        NonCheckOffDeposits: Decimal;
        AvgCheckOffDeposits: Decimal;
        AvgNonCheckOffDeposits: Decimal;
        TotalSalary: Decimal;
        SalAvg: Decimal;
        TotalNonSalary: Decimal;
        NonSalAvg: Decimal;
        SalaryLoans: Decimal;
        STO: Decimal;
        ChqAmt: Decimal;
        MpesaAmt: Decimal;
        Account: Record "Savings Accounts";
        SmallestSal: Decimal;
        RepAmt: Decimal;
        PSetup: Record "Product setup";
    begin

        Ability := 0;

        TotalSalary := 0;
        SalAvg := 0;
        TotalNonSalary := 0;
        NonSalAvg := 0;
        SalaryLoans := 0;
        STO := 0;
        ChqAmt := 0;
        MpesaAmt := 0;
        SmallestSal := 0;


        Account.Get(AccountNo);
        PSetup.get(LoanProduct);

        if Account."Salary Processing" then begin

            LeastSalary(Account."No.", 3, TotalSalary, SalAvg, SmallestSal);

            SalaryLoans := (GetSalaryLoanRepayment(Account."No."));

            if NonSalAvg > SalAvg then
                NonSalAvg := SalAvg;


            STO := GetStandingOrderAmount(Account."No.");

            GetFosaNonSalaryRemittance(Account."No.", 3, TotalNonSalary, NonSalAvg, ChqAmt, MpesaAmt);

            Ability := (SmallestSal - SalaryLoans - STO);

            Ability := Ability * (PSetup."Appraisal % on Amount" / 100);

        end
        else begin

            GetBosaDeposits(Account."No.", 3, CheckOffDeposits, NonCheckOffDeposits, AvgCheckOffDeposits, AvgNonCheckOffDeposits);
            Ability := ROUND((AvgCheckOffDeposits) + (1 / 8 * AvgNonCheckOffDeposits));

            if CheckOffDeposits <= 0 then
                Ability := (1 * AvgNonCheckOffDeposits);

        end;


        RepAmt := 0;
        GetSameLoanBalance(Account."No.", LoanProduct, RepAmt);
        Ability -= RepAmt;


        //MESSAGE('%1',Ability);

        if Ability < 0 then
            Ability := 0;


        Ability := ROUND(Ability, 1, '<')
    end;


    procedure SalaryAverage(AccountNo: Code[20]; MonthsToCheck: Integer; var TotalSalary: Decimal; var Avg: Decimal; var SmallestSal: Decimal)
    var
        Account: Record "Savings Accounts";
        OldAccount: Record "SACCO Account";
        MLedger: Record "Savings Ledger Entry";
        SDate: Date;
        EDate: Date;
        TestDate: Date;
        MonthCount: Integer;
        CurrentMonthPresent: Boolean;
        EndLoop: Boolean;
        Cust: Record Members;
        StaffMember: Boolean;
        StaffNo: Code[20];
        VLedger: Record "Savings Ledger Entry";
        DetailedVLedger: Record "Savings Ledger Entry";
        SalProcessBuffer: Record "Salary Lines";
        OldSalary: Record "Salary Processing Buffer";
        HeaderOldSalary: Record "Salary Processing Header";
        Sal1: Decimal;
        Sal2: Decimal;
        Sal3: Decimal;
        Avg1: Decimal;
        Avg2: Decimal;
        Avg3: Decimal;
    begin
        Avg := 0;
        SmallestSal := 0;

        if MonthsToCheck <= 0 then
            Error('Months to Check Parameter is Mandatory');

        MonthsToCheck -= 1;
        if MonthsToCheck <= 0 then
            MonthsToCheck := 1;


        Account.Reset;
        Account.SetRange("No.", AccountNo);
        if Account.FindFirst then begin


            Account.calcfields("Member Category");

            SalProcessBuffer.Reset;
            SalProcessBuffer.SetCurrentKey("Posting Date");
            SalProcessBuffer.SetRange(SalProcessBuffer."Account No.", Account."No.");
            SalProcessBuffer.SetRange(SalProcessBuffer.Posted, true);
            SalProcessBuffer.SetFilter("Income Type", '%1|%2|%3', SalProcessBuffer."income type"::Salary, SalProcessBuffer."income type"::"Staff Salary", SalProcessBuffer."income type"::Pension);
            if SalProcessBuffer.FindLast() then
                EDate := SalProcessBuffer."Posting Date";


            // Message('EDate %1 Months %2', edate,MonthsToCheck);

            if Edate < CalcDate('-1M+CM', Today) then
                EDate := CalcDate('-1M+CM', Today);



            EDate := CalcDate('CM', EDate);

            SDate := CalcDate('-' + Format(MonthsToCheck) + 'M-CM', EDate);
            TestDate := EDate;

            // MESSAGE('%1\%2',SDate,EDate);

            CurrentMonthPresent := false;
            EndLoop := false;
            TotalSalary := 0;
            MonthCount := 0;
            StaffMember := false;
            StaffNo := '';

            if Staff(Account."Member No.", StaffNo) then
                StaffMember := true;

            if staffMember then begin
                if Account."Old Account No." = '' then begin
                    OldAccount.Reset();
                    OldAccount.SetRange("Member No.", Account."Member No.");
                    OldAccount.SetRange("Product Type", '0101');
                    if OldAccount.FindFirst() then begin
                        Account."Old Account No." := OldAccount."No.";
                        Account.Modify();
                    end
                    else begin

                        OldAccount.Reset();
                        OldAccount.SetRange("Member No.", Account."Member No.");
                        OldAccount.SetRange("Product Type", '0102');
                        if OldAccount.FindFirst() then begin
                            Account."Old Account No." := OldAccount."No.";
                            Account.Modify();
                        end;
                    end;
                end;
            end;

            k := 0;
            while (TestDate >= SDate) do begin
                MonthCount += 1;
                k += 1;
                MonthlySal := 0;

                /*
                SalProcessBuffer.Reset;
                SalProcessBuffer.SetRange(SalProcessBuffer."Account No.", Account."No.");
                SalProcessBuffer.SetRange(SalProcessBuffer.Posted, true);
                SalProcessBuffer.SetFilter("Income Type", '%1|%2', SalProcessBuffer."income type"::Salary, SalProcessBuffer."income type"::"Staff Salary");
                SalProcessBuffer.SetFilter(SalProcessBuffer.Date, '%1..%2', CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                SalProcessBuffer.Ascending(false);
                if SalProcessBuffer.Find('-') then begin
                    repeat
                        TotalSalary += ROUND(SalProcessBuffer.Amount, 1);
                        MonthlySal += ROUND(SalProcessBuffer.Amount, 1);

                        if MonthCount = 1 then
                            CurrentMonthPresent := true;

                    until SalProcessBuffer.Next = 0;
                end
                else begin

                    HeaderOldSalary.Reset();
                    HeaderOldSalary.SetRange("Posting date", CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                    HeaderOldSalary.SetRange(Posted, true);
                    if HeaderOldSalary.findfirst then begin
                        OldSalary.Reset;
                        OldSalary.SetRange(OldSalary."Salary Header No.", HeaderOldSalary.no);
                        if StaffMember then
                            OldSalary.SetRange(OldSalary."Account No.", Account."Old Account No.")
                        else
                            OldSalary.SetRange(OldSalary."Account No.", Account."No.");

                        OldSalary.SetRange(OldSalary.Processed, true);
                        OldSalary.Ascending(false);
                        if OldSalary.Find('-') then begin
                            repeat
                                Message('%1\%2', OldSalary.Amount, TestDate);
                                TotalSalary += ROUND(OldSalary.Amount, 1);
                                MonthlySal += ROUND(OldSalary.Amount, 1);

                                if MonthCount = 1 then
                                    CurrentMonthPresent := true;

                            until OldSalary.Next = 0;
                        end
                    end
                    else begin

                        OldSalary.Reset;
                        OldSalary.SetRange("Posting date", CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                        if StaffMember then
                            OldSalary.SetRange(OldSalary."Account No.", Account."Old Account No.")
                        else
                            OldSalary.SetRange(OldSalary."Account No.", Account."No.");

                        OldSalary.SetRange(OldSalary.Processed, true);
                        OldSalary.Ascending(false);
                        if OldSalary.Find('-') then begin
                            repeat
                                Message('%1\%2', OldSalary.Amount, TestDate);
                                TotalSalary += ROUND(OldSalary.Amount, 1);
                                MonthlySal += ROUND(OldSalary.Amount, 1);

                                if MonthCount = 1 then
                                    CurrentMonthPresent := true;

                            until OldSalary.Next = 0;
                        end
                    end;


                end;
                */




                SalProcessBuffer.Reset;
                SalProcessBuffer.SetRange("Salary Header No.", 'SALO_5361');
                SalProcessBuffer.SetRange(SalProcessBuffer.Posted, false);
                if SalProcessBuffer.FindFirst() then begin
                    SalProcessBuffer.modifyall(Posted, true)
                end;

                SalProcessBuffer.Reset;
                SalProcessBuffer.SetRange("Salary Header No.", 'SALO_5361');
                SalProcessBuffer.SetRange(SalProcessBuffer."Posting Date", 0D);
                if SalProcessBuffer.FindFirst() then begin
                    SalProcessBuffer.modifyall("Posting Date", DT2Date(SalProcessBuffer.SystemCreatedAt))
                end;





                SalProcessBuffer.Reset;
                SalProcessBuffer.SetRange(SalProcessBuffer."Account No.", Account."No.");
                SalProcessBuffer.SetFilter(SalProcessBuffer.Period, '%1|%2', SalProcessBuffer.period::"End Month", SalProcessBuffer.period::"After Month");
                SalProcessBuffer.SetRange(SalProcessBuffer.Posted, true);
                SalProcessBuffer.SetFilter("Income Type", '%1|%2|%3', SalProcessBuffer."income type"::Salary, SalProcessBuffer."income type"::Pension, SalProcessBuffer."income type"::"Staff Salary");
                SalProcessBuffer.SetFilter(SalProcessBuffer."Posting Date", '%1..%2', CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                // SalProcessBuffer.setfilter(Period, '%1', SalProcessBuffer.Period::"End Month");
                SalProcessBuffer.Ascending(false);
                if SalProcessBuffer.Find('-') then begin
                    TotalSalary += ROUND(SalProcessBuffer.Amount, 1);
                    MonthlySal += ROUND(SalProcessBuffer.Amount, 1);
                    Message('Date: %1\Sal: %2', SalProcessBuffer."Posting Date", MonthlySal);
                    if MonthCount = 1 then
                        CurrentMonthPresent := true;
                end;

                if k = 1 then
                    Sal3 := MonthlySal;

                if k = 2 then
                    Sal2 := MonthlySal;

                if k = 3 then
                    Sal1 := MonthlySal;





                //MESSAGE('SmallestSal %1\ MonthlySal %2\ TestDate %3\ TotalSalary %4', SmallestSal, MonthlySal, TestDate, TotalSalary);

                if CurrentMonthPresent then
                    if MonthCount = MonthsToCheck then
                        EndLoop := true;

                TestDate := CalcDate('-1M', TestDate);

            end;
        end;

        Avg := 0;
        Account.Reset;
        Account.SetRange("No.", AccountNo);
        if Account.FindFirst then begin
            if MonthCount > 0 then
                Avg := ROUND(TotalSalary / 3);

            if Avg = 0 then
                Avg := ROUND((Sal1 + Sal2 + Sal3) / 3);

            IF AccountNo = '0102-14655' THEN
                MESSAGE('Avg1 %1\Avg2 %2\Avg3 %3\\%4', Avg1, Avg2, Avg3, Avg);
        end;
    end;

    procedure LeastSalary(AccountNo: Code[20]; MonthsToCheck: Integer; var TotalSalary: Decimal; var Avg: Decimal; var SmallestSal: Decimal)
    var
        Account: Record "Savings Accounts";
        OldAccount: Record "SACCO Account";
        MLedger: Record "Savings Ledger Entry";
        SDate: Date;
        EDate: Date;
        TestDate: Date;
        MonthCount: Integer;
        CurrentMonthPresent: Boolean;
        EndLoop: Boolean;
        Cust: Record Members;
        StaffMember: Boolean;
        StaffNo: Code[20];
        VLedger: Record "Savings Ledger Entry";
        DetailedVLedger: Record "Savings Ledger Entry";
        SalProcessBuffer: Record "Salary Lines";
        OldSalary: Record "Salary Processing Buffer";
        HeaderOldSalary: Record "Salary Processing Header";
        Sal1: Decimal;
        Sal2: Decimal;
        Sal3: Decimal;
        Avg1: Decimal;
        Avg2: Decimal;
        Avg3: Decimal;
    begin
        Avg := 0;
        SmallestSal := 0;

        if MonthsToCheck <= 0 then
            Error('Months to Check Parameter is Mandatory');

        MonthsToCheck -= 1;
        if MonthsToCheck <= 0 then
            MonthsToCheck := 1;


        Account.Reset;
        Account.SetRange("No.", AccountNo);
        if Account.FindFirst then begin


            Account.calcfields("Member Category");

            SalProcessBuffer.Reset;
            SalProcessBuffer.SetCurrentKey("Posting Date");
            SalProcessBuffer.SetRange(SalProcessBuffer."Account No.", Account."No.");
            SalProcessBuffer.SetRange(SalProcessBuffer.Posted, true);
            SalProcessBuffer.SetFilter("Income Type", '%1|%2', SalProcessBuffer."income type"::Salary, SalProcessBuffer."income type"::"Staff Salary");
            if SalProcessBuffer.FindLast() then
                EDate := SalProcessBuffer."Posting Date";


            //Message('EDate %1', edate);

            if Edate < CalcDate('-1M+CM', Today) then
                EDate := CalcDate('-1M+CM', Today);



            EDate := CalcDate('CM', EDate);

            SDate := CalcDate('-' + Format(MonthsToCheck) + 'M-CM', EDate);
            TestDate := EDate;

            //MESSAGE('%1\%2',SDate,EDate);

            CurrentMonthPresent := false;
            EndLoop := false;
            TotalSalary := 0;
            MonthCount := 0;
            StaffMember := false;
            StaffNo := '';

            if Staff(Account."Member No.", StaffNo) then
                StaffMember := true;

            if staffMember then begin
                if Account."Old Account No." = '' then begin
                    OldAccount.Reset();
                    OldAccount.SetRange("Member No.", Account."Member No.");
                    OldAccount.SetRange("Product Type", '0101');
                    if OldAccount.FindFirst() then begin
                        Account."Old Account No." := OldAccount."No.";
                        Account.Modify();
                    end
                    else begin

                        OldAccount.Reset();
                        OldAccount.SetRange("Member No.", Account."Member No.");
                        OldAccount.SetRange("Product Type", '0102');
                        if OldAccount.FindFirst() then begin
                            Account."Old Account No." := OldAccount."No.";
                            Account.Modify();
                        end;
                    end;
                end;
            end;

            k := 0;
            while (TestDate >= SDate) do begin
                MonthCount += 1;
                k += 1;
                MonthlySal := 0;

                /*
                SalProcessBuffer.Reset;
                SalProcessBuffer.SetRange(SalProcessBuffer."Account No.", Account."No.");
                SalProcessBuffer.SetRange(SalProcessBuffer.Posted, true);
                SalProcessBuffer.SetFilter("Income Type", '%1|%2', SalProcessBuffer."income type"::Salary, SalProcessBuffer."income type"::"Staff Salary");
                SalProcessBuffer.SetFilter(SalProcessBuffer.Date, '%1..%2', CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                SalProcessBuffer.Ascending(false);
                if SalProcessBuffer.Find('-') then begin
                    repeat
                        TotalSalary += ROUND(SalProcessBuffer.Amount, 1);
                        MonthlySal += ROUND(SalProcessBuffer.Amount, 1);

                        if MonthCount = 1 then
                            CurrentMonthPresent := true;

                    until SalProcessBuffer.Next = 0;
                end
                else begin

                    HeaderOldSalary.Reset();
                    HeaderOldSalary.SetRange("Posting date", CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                    HeaderOldSalary.SetRange(Posted, true);
                    if HeaderOldSalary.findfirst then begin
                        OldSalary.Reset;
                        OldSalary.SetRange(OldSalary."Salary Header No.", HeaderOldSalary.no);
                        if StaffMember then
                            OldSalary.SetRange(OldSalary."Account No.", Account."Old Account No.")
                        else
                            OldSalary.SetRange(OldSalary."Account No.", Account."No.");

                        OldSalary.SetRange(OldSalary.Processed, true);
                        OldSalary.Ascending(false);
                        if OldSalary.Find('-') then begin
                            repeat
                                Message('%1\%2', OldSalary.Amount, TestDate);
                                TotalSalary += ROUND(OldSalary.Amount, 1);
                                MonthlySal += ROUND(OldSalary.Amount, 1);

                                if MonthCount = 1 then
                                    CurrentMonthPresent := true;

                            until OldSalary.Next = 0;
                        end
                    end
                    else begin

                        OldSalary.Reset;
                        OldSalary.SetRange("Posting date", CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                        if StaffMember then
                            OldSalary.SetRange(OldSalary."Account No.", Account."Old Account No.")
                        else
                            OldSalary.SetRange(OldSalary."Account No.", Account."No.");

                        OldSalary.SetRange(OldSalary.Processed, true);
                        OldSalary.Ascending(false);
                        if OldSalary.Find('-') then begin
                            repeat
                                Message('%1\%2', OldSalary.Amount, TestDate);
                                TotalSalary += ROUND(OldSalary.Amount, 1);
                                MonthlySal += ROUND(OldSalary.Amount, 1);

                                if MonthCount = 1 then
                                    CurrentMonthPresent := true;

                            until OldSalary.Next = 0;
                        end
                    end;


                end;
                */





                SalProcessBuffer.Reset;
                SalProcessBuffer.SetRange(SalProcessBuffer."Account No.", Account."No.");
                SalProcessBuffer.SetRange(SalProcessBuffer.Posted, true);
                SalProcessBuffer.SetFilter("Income Type", '%1|%2', SalProcessBuffer."income type"::Salary, SalProcessBuffer."income type"::"Staff Salary");
                SalProcessBuffer.SetFilter(SalProcessBuffer."Posting Date", '%1..%2', CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                SalProcessBuffer.Ascending(false);
                if SalProcessBuffer.Find('-') then begin
                    TotalSalary += ROUND(SalProcessBuffer.Amount, 1);
                    MonthlySal += ROUND(SalProcessBuffer.Amount, 1);

                    if MonthCount = 1 then
                        CurrentMonthPresent := true;
                end;


                /*
                OldSalary.Reset;
                OldSalary.SetRange("Posting date", CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                if StaffMember then
                    OldSalary.SetRange(OldSalary."Account No.", Account."Old Account No.")
                else
                    OldSalary.SetRange(OldSalary."Account No.", Account."No.");

                OldSalary.SetRange(OldSalary.Processed, true);
                OldSalary.Ascending(false);
                if OldSalary.Find('-') then begin
                    repeat
                        //Message('%1\%2', OldSalary.Amount, TestDate);
                        TotalSalary += ROUND(OldSalary.Amount, 1);
                        MonthlySal += ROUND(OldSalary.Amount, 1);

                        if MonthCount = 1 then
                            CurrentMonthPresent := true;

                    until OldSalary.Next = 0;
                end;
                */

                if k = 1 then
                    Sal3 := MonthlySal;

                if k = 2 then
                    Sal2 := MonthlySal;

                if k = 3 then
                    Sal1 := MonthlySal;




                if (k = 1) and (MonthlySal > 0) then
                    SmallestSal := MonthlySal
                else
                    if SmallestSal = 0 then
                        SmallestSal := MonthlySal;

                if (SmallestSal > MonthlySal) and (MonthlySal > 0) then
                    SmallestSal := MonthlySal;
                //0102-001-00154

                //MESSAGE('SmallestSal %1\ MonthlySal %2\ TestDate %3\ TotalSalary %4', SmallestSal, MonthlySal, TestDate, TotalSalary);

                if CurrentMonthPresent then
                    if MonthCount = MonthsToCheck then
                        EndLoop := true;

                TestDate := CalcDate('-1M', TestDate);

            end;
        end;

        Account.Reset;
        Account.SetRange("No.", AccountNo);
        if Account.FindFirst then begin
            if MonthCount > 0 then
                Avg := ROUND(TotalSalary / MonthCount);

            //IF AccountNo = '0101-001-03425' THEN
            //MESSAGE('Sal1 %1\Sal2 %2\Sal3 %3',Sal1,Sal2,Sal3);

            if (Sal1 = 0) or (Sal2 = 0) or (Sal3 = 0) then begin

                //if (Sal1=0) AND ( (Sal2>0) OR (Sal3>0) )then
                // SmallestSal := aVG;

                if (Sal1 > 0) and ((Sal2 = 0) and (Sal3 = 0)) then begin
                    SmallestSal := 0;
                    Avg := 0;
                end
                else
                    SmallestSal := Avg;

            end
            else begin
                Avg1 := (Sal1 + Sal2) / 2;
                Avg2 := (Sal1 + Sal3) / 2;
                Avg3 := (Sal2 + Sal3) / 2;

                Avg := ROUND((Avg1 + Avg2 + Avg3) / 3);

                //IF AccountNo = '0101-001-03425' THEN
                //MESSAGE('Avg1 %1\Avg2 %2\Avg3 %3\\%4',Avg1,Avg2,Avg3,Avg);

            end;
        end;
    end;

    procedure GetSalaryLoanRepayment(AccNo: Code[20]) RepAmt: Decimal
    var
        Loans: Record Loans;
        Vend: Record "Savings Accounts";
    begin
        RepAmt := 0;

        Vend.get(AccNo);


        Members.Reset;
        Members.SetRange("No.", Vend."Member No.");
        Members.SetRange("Member Category", Members."Member Category"::"Staff Members");
        if not Members.FindFirst then begin


            Loans.Reset;
            Loans.SetRange(Loans."Member No.", Vend."Member No.");
            Loans.SetRange(Loans."Repay Mode", Loans."Repay Mode"::Salary);
            Loans.SetRange(Loans.Posted, true);
            Loans.SetRange(Loans."Mobile Loan", false);
            Loans.SetFilter("Outstanding Principal", '>0');
            if Loans.Find('-') then begin
                repeat
                    RepAmt += Loans.Repayment;
                until Loans.Next = 0;
            end;

        end;
    end;



    procedure GetFosaNonSalaryRemittance(AccountNo: Code[20]; MonthsToCheck: Integer; var TotalRemittance: Decimal; var Avg: Decimal; var ChequeAmt: Decimal; var MpesaAmt: Decimal)
    var
        Account: Record "Savings Accounts";
        MLedger: Record "Savings Ledger Entry";
        SDate: Date;
        EDate: Date;
        TestDate: Date;
        MonthCount: Integer;
        CurrentMonthPresent: Boolean;
        EndLoop: Boolean;
        Cust: Record Members;
        StaffMember: Boolean;
        StaffNo: Code[20];
        VLedger: Record "Savings Ledger Entry";
        DetailedVLedger: Record "Savings Ledger Entry";
        SalProcessBuffer: Record "Salary Lines";
        SalHeader: Record "Salary Header";
        Transactions: Record "Teller Transaction";
        SkyTransactions: Record "Sky Transactions.";
        MPESATransactions: Record "Spotcash Transactions";


        OldTransactions: Record "Transactions- CBS";
        OldSpotCash: Record "Mbanking Transactions";

    begin
        Avg := 0;

        if MonthsToCheck <= 0 then
            Error('Months to Check Parameter is Mandatory');


        MonthsToCheck -= 1;
        if MonthsToCheck <= 0 then
            MonthsToCheck := 1;


        Account.Reset;
        Account.SetRange("No.", AccountNo);
        if Account.FindFirst then begin
            EDate := CalcDate('-1M+CM', Today);
            SDate := CalcDate('-' + Format(MonthsToCheck) + 'M-CM', EDate);
            TestDate := EDate;

            CurrentMonthPresent := false;
            EndLoop := false;
            TotalRemittance := 0;
            MonthCount := 0;


            if Staff(AccountNo, StaffNo) then
                StaffMember := true;


            while (TestDate >= SDate) do begin
                MonthCount += 1;


                /*
                OldTransactions.Reset;
                OldTransactions.SetRange(OldTransactions."Account No", AccountNo);
                OldTransactions.SetRange("Transaction Date", CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                OldTransactions.SetRange(Posted, true);
                OldTransactions.SetFilter(Type, 'Cheque Deposit|Cash Deposit');
                if OldTransactions.FindFirst then begin
                    repeat
                        ChequeAmt += OldTransactions.Amount;
                    until OldTransactions.Next = 0;
                end;
                */


                Transactions.Reset;
                Transactions.SetRange(Transactions."Account No.", AccountNo);
                Transactions.SetRange("Transaction Date", CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                Transactions.SetRange(Posted, true);
                Transactions.SetFilter(Type, 'Cheque Deposit|Cash Deposit');
                if Transactions.FindFirst then begin
                    repeat
                        ChequeAmt += Transactions.Amount;
                    until Transactions.Next = 0;
                end;


                SkyTransactions.Reset;
                SkyTransactions.SetRange("Member Account", AccountNo);
                SkyTransactions.SetRange("Transaction Type", SkyTransactions."transaction type"::Paybill);
                SkyTransactions.SetRange(Posted, true);
                SkyTransactions.SetRange("Date Posted", CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                SkyTransactions.SetFilter("Loan No.", '');
                if SkyTransactions.FindFirst then begin
                    repeat
                        MpesaAmt += SkyTransactions.Amount;
                    until SkyTransactions.Next = 0;
                end;


                /*
                OldSpotCash.Reset;
                OldSpotCash.SetRange(account_number, AccountNo);
                OldSpotCash.SetRange("Transaction Type", OldSpotCash."Transaction Type"::Paybill);
                OldSpotCash.SetRange(Posted, true);
                OldSpotCash.SetRange("Date Posted", CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                if OldSpotCash.FindFirst then begin
                    repeat
                        MpesaAmt += MPESATransactions.Amount * -1;
                    until MPESATransactions.Next = 0;
                end;
                */

                MPESATransactions.Reset;
                MPESATransactions.SetRange(account_number, AccountNo);
                MPESATransactions.SetRange("Transaction Type", MPESATransactions."Transaction Type"::Paybill);
                MPESATransactions.SetRange(Posted, true);
                MPESATransactions.SetRange("Date Posted", CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                if MPESATransactions.FindFirst then begin
                    repeat
                        MpesaAmt += MPESATransactions.Amount * -1;
                    until MPESATransactions.Next = 0;
                end;

                //message('%1\%2\%3',Transactions.getfilter("Transaction Date"),ChequeAmt,MpesaAmt);
                if CurrentMonthPresent then
                    if MonthCount = MonthsToCheck then
                        EndLoop := true;

                TestDate := CalcDate('-1M', TestDate);
            end;
        end;

        TotalRemittance := ChequeAmt + MpesaAmt;

        if MonthCount > 0 then
            Avg := ROUND(TotalRemittance / MonthCount);
    end;



    procedure GetBosaDeposits(AccountNo: Code[20]; MonthsToCheck: Integer; var CheckOffDeposits: Decimal; var NonCheckOffDeposits: Decimal; var AvgCheckOffDeposits: Decimal; var AvgNonCheckOffDeposits: Decimal) Avg: Decimal
    var
        Account: Record "Savings Accounts";
        SavAccount: Record "Savings Accounts";
        MLedger: Record "Savings Ledger Entry";
        SDate: Date;
        EDate: Date;
        TestDate: Date;
        MonthCount: Integer;
        CurrentMonthPresent: Boolean;
        EndLoop: Boolean;
        TotalDeposits: Decimal;
        Cust: Record Members;
        VLedger: Record "Savings Ledger Entry";
        DetailedVLedger: Record "Savings Ledger Entry";
        SalProcessBuffer: Record "Salary Lines";
        CheckOffHeader: Record "Monthly Checkoff Header";
        CheckOffBuffer: Record "Monthly Checkoff Lines";
        MonthlyCheckOff: Decimal;
        MonthlyDeposts: Decimal;
        Members: Record Members;
        MonthlyNonCheckOff: Decimal;
        Legacy: Codeunit Legacy;



        //OldRedHeader: Record "Receipts Processing Header";
        //OldRecBuffer: Record "Receipts Processing Lines";

        CheckOffLines: Record "Monthly checkoff Lines";
        Depo1: Decimal;
        Depo2: Decimal;
        Depo3: Decimal;
        Deposits1: Decimal;
        Deposits2: Decimal;
        Deposits3: Decimal;
        Average12: Decimal;
        Average23: Decimal;
        StartDate: Date;
        EndDate: Date;
        MCount: Integer;
        NonCheck1: Decimal;
        NonCheck2: Decimal;
        NonCheck3: Decimal;
        NonCheck12: Decimal;
        NonCheck23: Decimal;
        DepHelp: Record "Avg Deposits Helper";
        Counter: Integer;
    begin
        DepHelp.Reset;
        DepHelp.DeleteAll;
        Avg := 0;





        if MonthsToCheck <= 0 then
            Error('Months to Check Parameter is Mandatory');

        MonthsToCheck -= 1;
        if MonthsToCheck <= 0 then
            MonthsToCheck := 1;

        Account.Reset;
        Account.SetRange("No.", AccountNo);
        if Account.FindFirst then begin
            //if company code = q and c then

            EDate := Today;


            SDate := CalcDate('-' + Format(MonthsToCheck) + 'M-CM', EDate);
            TestDate := EDate;

            //MESSAGE('End date:  %1 ******* Start Date:  %2',EDate,SDate);
            CurrentMonthPresent := false;
            EndLoop := false;
            TotalDeposits := 0;
            MonthCount := 0;
            CheckOffDeposits := 0;
            NonCheckOffDeposits := 0;
            AvgCheckOffDeposits := 0;
            AvgNonCheckOffDeposits := 0;
            Depo1 := 0;
            Depo2 := 0;
            Depo3 := 0;
            Deposits1 := 0;
            Deposits2 := 0;
            Deposits3 := 0;


            //MESSAGE('1');
            if Cust.Get(Account."Member No.") then begin
                //MESSAGE('2');
                while (TestDate >= SDate) do begin
                    MonthCount += 1;
                    //MESSAGE('3');
                    if Cust."Employer Code" <> '' then begin
                        //MESSAGE('4');


                        MonthlyCheckOff := 0;
                        MonthlyNonCheckOff := 0;

                        //CheckOffHeader.Reset;
                        //CheckOffHeader.SetRange(CheckOffHeader."Account Type", CheckOffHeader."account type"::Customer);
                        //CheckOffHeader.SetRange(CheckOffHeader."Account No.", Cust."Employer Code");
                        //CheckOffHeader.SetRange(Posted, true);
                        //CheckOffHeader.SetFilter("Posting Date", '%1..%2', CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                        //if CheckOffHeader.Find('-') then begin
                        //  repeat

                        CheckOffLines.Reset;
                        CheckOffLines.SetRange(CheckOffLines."Member No.", Cust."No.");
                        CheckOffLines.SetRange(Posted, true);
                        //CheckOffLines.SetRange(CheckOffLines."Checkoff Header", CheckOffHeader."No.");
                        CheckOffLines.SetFilter("Posting Date", '%1..%2', CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                        CheckOffLines.SetRange(CheckOffLines."Product Category", CheckOffLines."Product Category"::"Deposit Contribution");
                        if CheckOffLines.Find('+') then begin
                            repeat
                                checkofflines.calcfields("Posting Date");

                                //Message('C; %1\%2', CheckOffLines."posting date", CheckOffLines.Amount);
                                if MonthCount = 1 then
                                    Depo1 := CheckOffLines.Amount;
                                if MonthCount = 2 then
                                    Depo2 := CheckOffLines.Amount;
                                if MonthCount = 3 then
                                    Depo3 := CheckOffLines.Amount;

                            until CheckOffLines.Next = 0;
                        end;

                        //until CheckOffHeader.Next = 0;
                        //end;



                        if MonthCount = 1 then
                            Deposits1 := Depo1;
                        if MonthCount = 2 then
                            Deposits2 := Depo2;
                        if MonthCount = 3 then
                            Deposits3 := Depo3;

                        //MESSAGE('TestDate %3\MonthlyCheckOff %1\CheckOffDeposits %2\ Shares %4',MonthlyCheckOff,CheckOffDeposits,TestDate,Members."Current Shares");

                        //MESSAGE(': %1\MonthlyNonCheckOff: %2\Members."Current Shares": %3\MonthlyCheckOff: %4\ CheckOffDeposits %5',
                        //CheckOffHeader.GETFILTER("Check Of Date"),MonthlyNonCheckOff,Members."Current Shares",MonthlyCheckOff,CheckOffDeposits);


                    end;
                    if CurrentMonthPresent then
                        if MonthCount = MonthsToCheck then
                            EndLoop := true;

                    TestDate := CalcDate('-1M', TestDate);

                end;

                CheckOffDeposits := Depo1 + Depo2 + Depo3;


                //Message('Depo1 %1\Depo2 %2\Depo3 %3', Depo1, Depo2, Depo3);

                StartDate := CalcDate('-CM', SDate);

                EndDate := CalcDate('CM', EDate);
                //MESSAGE(FORMAT(StartDate)+'   '+FORMAT(EndDate));
                MCount := 0;
                while (EndDate >= StartDate) do begin
                    MCount += 1;
                    SavAccount.Reset;
                    SavAccount.SetRange("Member No.", Cust."No.");
                    SavAccount.SetRange("Product Category", SavAccount."Product Category"::"Deposit Contribution");
                    SavAccount.SetFilter("Date Filter", '%1..%2', CalcDate('-CM', EndDate), EndDate);
                    if SavAccount.FindFirst then begin
                        SavAccount.CalcFields("Net Change (LCY)");

                        //Message('NC; %1\%2', EndDate, SavAccount."Net Change (LCY)");

                        if MCount = 1 then
                            NonCheck1 := SavAccount."Net Change (LCY)" - Deposits1;
                        if MCount = 2 then
                            NonCheck2 := SavAccount."Net Change (LCY)" - Deposits2;
                        if MCount = 3 then
                            NonCheck3 := SavAccount."Net Change (LCY)" - Deposits3;

                        //MESSAGE(FORMAT(StartDate));
                        //MESSAGE(FORMAT(NonCheck1)+'   '+FORMAT(NonCheck2));
                        //Members."Current Shares"-CheckOffDeposits;
                        //MESSAGE(' %1\MonthlyNonCheckOff: %2\Members."Current Shares": %3\MonthlyCheckOff: %4\ CheckOffDeposits %5',
                        //Members.GETFILTER("Date Filter"),NonCheckOfffDeposits,Members."Current Shares",MonthlyCheckOff,CheckOffDeposits);

                    end;

                    EndDate := CalcDate('-1M', EndDate);
                end;
                NonCheckOffDeposits := NonCheck1 + NonCheck2 + NonCheck3;

                //Message('NonCheck1 %1\NonCheck2 %2\NonCheck4 %3', NonCheck1, NonCheck2, NonCheck3);

            end;
        end;


        if MonthCount > 0 then
            AvgCheckOffDeposits := ROUND(CheckOffDeposits / MonthCount);

        if MonthCount > 0 then
            AvgNonCheckOffDeposits := ROUND(NonCheckOffDeposits / MonthCount);

        Counter := 1;
        repeat
            DepHelp.Init;
            DepHelp."No." := Counter;
            if Counter = 1 then begin
                DepHelp."Checkoff Deposits" := Deposits1;
                DepHelp."Non Checkoff Deposits" := NonCheck1;
            end else
                if Counter = 2 then begin
                    DepHelp."Checkoff Deposits" := Deposits2;
                    DepHelp."Non Checkoff Deposits" := NonCheck2;
                end else
                    if Counter = 3 then begin
                        DepHelp."Checkoff Deposits" := Deposits3;
                        DepHelp."Non Checkoff Deposits" := NonCheck3;
                    end;
            DepHelp.Insert;
            Counter += 1;
        until Counter = 4;

        Counter := 1;
        DepHelp.Reset;
        DepHelp.SetCurrentkey(DepHelp."Checkoff Deposits");
        if DepHelp.FindFirst then begin
            repeat
                Average23 += DepHelp."Checkoff Deposits";
                DepHelp.Next(1);
                Counter += 1;
            until Counter = 3;
        end;

        Counter := 1;
        DepHelp.Reset;
        DepHelp.SetCurrentkey(DepHelp."Non Checkoff Deposits");
        if DepHelp.FindFirst then begin
            repeat
                NonCheck23 += DepHelp."Non Checkoff Deposits";
                DepHelp.Next(1);
                Counter += 1;
            until Counter = 3;
        end;


        //Average12 := ROUND((Deposits1+Deposits2)/2);
        //Average23 := ROUND((Deposits2+Deposits3)/2);
        //NonCheck12  := NonCheck1+NonCheck2;
        //NonCheck23 := NonCheck2 + NonCheck3;

        if MonthCount > 0 then
            AvgCheckOffDeposits := ROUND(Average23 / 2);

        if MonthCount > 0 then
            AvgNonCheckOffDeposits := ROUND(NonCheck23 / 2);



        //MESSAGE(FORMAT(AvgNonCheckOffDeposits));
        //***
    end;


    procedure GetBosaCheckOffDeposits(AccountNo: Code[20]; MonthsToCheck: Integer) Avg: Decimal
    var
        Account: Record "Savings Accounts";
        MLedger: Record "Savings Ledger Entry";
        SDate: Date;
        EDate: Date;
        TestDate: Date;
        MonthCount: Integer;
        CurrentMonthPresent: Boolean;
        EndLoop: Boolean;
        TotalDeposits: Decimal;
        Cust: Record Members;
        VLedger: Record "Savings Ledger Entry";
        DetailedVLedger: Record "Savings Ledger Entry";
        SalProcessBuffer: Record "Salary Lines";
        CheckOffHeader: Record "Monthly Checkoff Header";
        CheckOffBuffer: Record "Monthly Checkoff Lines";
    begin
        Avg := 0;

        if MonthsToCheck <= 0 then
            Error('Months to Check Parameter is Mandatory');

        MonthsToCheck -= 1;
        if MonthsToCheck <= 0 then
            MonthsToCheck := 1;


        Account.Reset;
        Account.SetRange("No.", AccountNo);
        if Account.FindFirst then begin
            if Date2dmy(Today, 1) <= 10 then
                EDate := CalcDate('-2M+CM', Today)
            else
                EDate := CalcDate('-1M+CM', Today);

            SDate := CalcDate('-' + Format(MonthsToCheck) + 'M-CM', EDate);
            TestDate := EDate;

            CurrentMonthPresent := false;
            EndLoop := false;
            TotalDeposits := 0;
            MonthCount := 0;


            while (TestDate >= SDate) do begin
                MonthCount += 1;

                if Cust.Get(Account."Member No.") then begin
                    if Cust."Employer Code" <> '' then begin




                        CheckOffHeader.Reset;
                        CheckOffHeader.SetRange(CheckOffHeader."Account Type", CheckOffHeader."account type"::Customer);
                        CheckOffHeader.SetRange(CheckOffHeader."Account No.", Cust."Employer Code");
                        CheckOffHeader.SetRange(Posted, true);
                        CheckOffHeader.SetFilter(Amount, '>%1', 0);
                        CheckOffHeader.SetFilter("Posting Date", '%1..%2', CalcDate('-CM', TestDate), CalcDate('CM', TestDate));
                        if CheckOffHeader.Find('-') then begin
                            repeat
                                CheckOffBuffer.Reset;
                                CheckOffBuffer.SetRange(CheckOffBuffer."CheckOff Header", CheckOffHeader."No.");
                                CheckOffBuffer.SetRange(CheckOffBuffer."Member No.", Cust."No.");
                                CheckOffBuffer.SetFilter(CheckOffBuffer.Amount, '>%1', 0);
                                if CheckOffBuffer.Find('-') then begin
                                    repeat
                                        TotalDeposits += ROUND(CheckOffBuffer.Amount, 1);
                                    until CheckOffBuffer.Next = 0;
                                end;
                            until CheckOffHeader.Next = 0;
                        end;



                    end;
                end;


                if CurrentMonthPresent then
                    if MonthCount = MonthsToCheck then
                        EndLoop := true;

                TestDate := CalcDate('-1M', TestDate);
            end;
        end;

        if MonthCount > 0 then
            Avg := ROUND(TotalDeposits / MonthCount);
    end;



    procedure Staff(MemberNo: Code[20]; var StaffNo: Code[20]) StaffMember: Boolean
    var
        SDate: Date;
        EDate: Date;
        TestDate: Date;
        Members: Record Members;
    begin
        StaffMember := false;
        StaffNo := '';

        Members.Reset;
        Members.SetRange("No.", MemberNo);
        Members.SetRange("Member Category", Members."Member Category"::"Staff Members");
        if Members.FindFirst then begin
            StaffMember := true;
            StaffNo := Members."Payroll/Staff No.";
        end;
    end;



    Procedure GetLoanQualifiedAmount(AccountNo: Code[20]; LoanProductType: Code[20]; VAR QualAmt: Decimal; VAR Remark: Text; Var ResCode: Text[10])
    var
        saccoAccount: Record "Savings Accounts";
        MemberAccount: Record "Savings Accounts";
        GeneralSetUp: record "Sacco Setup";
        Legacy: Codeunit Legacy;
        SActivities: Codeunit "SAcco Activities";
        MActivities: Codeunit "Member Activities";
        PSetup: Record "Product Setup";
        ProdSetup: Record "Product Setup";
        Loans: Record Loans;
        nDays: integer;
        CustMember: Record Members;

        SalStart: date;
        sCount: integer;
        ExistingLoans: decimal;
        Salary1: decimal;
        Salary2: decimal;
        Salary3: decimal;
        SalAvg: Decimal;
        ELoan: Record "Mbanking Eloan Logs";
        SalEnd: date;

        SalBuffer: Record "Salary Lines";
        DepAmt: Decimal;
        NetSal: Decimal;
        STO: Decimal;
        RepAmt: decimal;
        MaxLoanAmount: decimal;
        TotalSalary: decimal;
        SmallestSal: Decimal;
        OldAccount: Record "Sacco Account";
        TArrears: Decimal;
        DepositPercentage: Decimal;
        DividendProgression: Record "Dividends Progression";
        TotalLoans: Decimal;
        DF: DateFormula;
        LSecurity: Record "Loan Security";
    begin
        Remark := '';
        QualAmt := 0;
        ExistingLoans := 0;

        saccoAccount.RESET;
        saccoAccount.SETRANGE("No.", AccountNo);
        IF saccoAccount.FIND('-') THEN begin


            IF LoanType.GET(LoanProductType) THEN begin
                Members.GET(saccoAccount."Member No.");

                if (Members."Block Mobile Loan") and (LoanProductType <> 'L43') then begin
                    Remark := 'You have been blocked from accessing this loan. Kindly Contact the SACCO';
                    QualAmt := 0;
                    Exit;
                end;

                if CheckLoanBlackList(Members."ID No.") then begin
                    Remark := 'You do not Qualify for this loan. Kindly Contact the SACCO';
                    QualAmt := 0;
                    Exit;
                end;

                PSetup.Reset();
                PSetup.SetRange("Product Category", PSetup."Product Category"::"Share Capital");
                if PSetup.FindFirst() then begin
                    IF MActivities.GetAccountBalance(Legacy.GetShareCapitalAccount(Members."No.")) < PSetup."Appraisal Min. Shares" then begin
                        QualAmt := 0;
                        Remark := StrSubstNo('You have insufficient share capital %1', Psetup."Appraisal Min. Shares");
                        EXIT;
                    end;
                end;

                PSetup.Reset();
                PSetup.SetRange("Product Category", PSetup."Product Category"::"Deposit Contribution");
                if PSetup.FindFirst() then begin
                    IF MActivities.GetAccountBalance(Legacy.GetShareCapitalAccount(Members."No.")) < PSetup."Appraisal Min. Deposits" then begin
                        QualAmt := 0;
                        Remark := StrSubstNo('You have insufficient Deposits %1', PSetup."Appraisal Min. Deposits");
                        EXIT;
                    end;
                end;


                MemberAccount.Reset();
                MemberAccount.SetRange("Member No.", Members."No.");
                MemberAccount.SetRange("Product Category", PSetup."Product Category"::"Deposit Contribution");
                MemberAccount.SetRange(Status, MemberAccount.Status::Dormant);
                if MemberAccount.FindFirst() then begin
                    if LoanProductType <> 'L43' then begin
                        QualAmt := 0;
                        Remark := 'Your account is DORMANT. Activate your deposits account to enjoy our M-Loan services. Dial *470# and follow prompts.';
                        EXIT;
                    end;
                end;


                if not LoanType."Allow Multiple Running Loans" then begin

                    TotalLoans := 0;

                    Loans.RESET;
                    Loans.SETRANGE("Member No.", saccoAccount."Member No.");
                    Loans.SETRANGE("Loan Product Type", LoanProductType);
                    Loans.SETFILTER("Outstanding Principal", '>0');
                    IF Loans.FINDFIRST THEN
                        repeat
                            Loans.CALCFIELDS("Total Outstanding Balance");
                            TotalLoans := TotalLoans + Loans."Total Outstanding Balance";
                        until Loans.Next() = 0;

                    if TotalLoans > 0 then begin
                        QualAmt := 0;
                        ResCode := '53';
                        Remark := 'You have an active ' + FORMAT(Loans."Loan Product Type name") + 'of KES ' + FORMAT(TotalLoans);
                        EXIT;
                    end;
                end else begin
                    Loans.RESET;
                    Loans.SETRANGE("Member No.", saccoAccount."Member No.");
                    Loans.SETRANGE("Loan Product Type", LoanProductType);
                    Loans.SETFILTER("Outstanding Principal", '>0');
                    IF Loans.FINDFIRST THEN begin
                        //if LoanType."Maximum No. of Loans" > 0 then begin
                        if Loans.Count >= LoanType."Maximum No. of Loans" then begin
                            QualAmt := 0;
                            ResCode := '53';
                            Remark := 'You have execeeded your maximum current running number of loans ' + FORMAT(LoanType."Maximum No. of Loans");
                            EXIT;
                        end;
                    end;
                end;
            end;

            //check how long member has been active
            if LoanType."Loan Application Period" <> DF then begin

                IF (Members."Registration Date" = 0D) THEN BEGIN
                    QualAmt := 0;
                    Remark := 'You Membership Period is less than 3 Months';
                    EXIT;
                END
                ELSE BEGIN
                    nDays := TODAY - Members."Registration Date";
                    IF CalcDate(LoanType."Loan Application Period", Members."Registration Date") > Today THEN BEGIN
                        QualAmt := 0;
                        Remark := 'You Membership Period is less than ' + format(LoanType."Loan Application Period");
                        EXIT;
                    END;
                END;
            end;

            saccoAccount.CalcFields("Total Loan Arrears");
            if (saccoAccount."Total Loan Arrears" > 100) and (LoanProductType <> 'L43') then begin
                QualAmt := 0;
                Remark := 'You have a total arrears Kshs ' + format(saccoAccount."Total Loan Arrears") + '.  Dial *470# and follow prompts to pay and try again';
                EXIT;
            end;

            Loans.RESET;
            Loans.SETRANGE("Member No.", saccoAccount."Member No.");
            Loans.SETFILTER("Loans Category-SACCO", '<>%1', Loans."Loans Category-SACCO"::Perfoming);
            Loans.SETFILTER("Outstanding Principal", '>0');
            IF Loans.FINDFIRST THEN begin
                repeat

                    Loans.calcfields("Total Arrears");
                    TArrears += Loans."Total Arrears";// - Loans.Repayment;

                until Loans.Next() = 0;

                if (TArrears > 1) and (LoanProductType <> 'L43') then begin
                    QualAmt := 0;

                    Remark := 'You have a total arrears Kshs ' + format(TArrears) + '.  Dial *470# and follow prompts to pay and try again';
                    EXIT;
                end;
            end;

            if LoanProductType <> 'L43' then begin

                Loans.RESET;
                Loans.SETRANGE("Member No.", saccoAccount."Member No.");
                Loans.SETRANGE("Loan Product Type", LoanProductType);
                Loans.SETFILTER("Outstanding Principal", '>0');
                IF (Loans.FINDFIRST()) then begin
                    if not LoanType."Allow Multiple Running Loans" THEN BEGIN
                        Loans.CALCFIELDS("Total Outstanding Balance");
                        QualAmt := 0;
                        Remark := 'You have an active ' + FORMAT(Loans."Loan Product Type name") + ' of KES ' + FORMAT(Loans."Total Outstanding Balance");
                        EXIT;
                    end;
                END;

            end;


            IF (Members."Member Status" <> Members."Member Status"::" ") and (Members."Member Status" <> Members."Member Status"::Active) THEN BEGIN
                QualAmt := 0;
                Remark := 'You Member Account is not active';
                EXIT;
            END;




            //check how long member has been active
            IF (Members."Registration Date" = 0D) THEN BEGIN
                QualAmt := 0;
                Remark := 'You Membership Period is less than 3 Months';
                EXIT;
            END
            ELSE BEGIN
                nDays := TODAY - Members."Registration Date";
                IF nDays < 90 THEN BEGIN
                    QualAmt := 0;
                    Remark := 'You Membership Period is less than 3 Months';
                    EXIT;
                END;
            END;

            Loans.RESET;
            Loans.SETRANGE("Member No.", saccoAccount."Member No.");
            Loans.SETFILTER("Loans Category-SACCO", '<>%1', Loans."Loans Category-SACCO"::Perfoming);
            Loans.SETFILTER("Loan Product Type", '<>%1&<>%2&<>%3', 'L43', 'L27', 'L29');
            Loans.SETFILTER("Outstanding Principal", '>0');
            IF (Loans.FINDFIRST) and (LoanProductType <> 'L43') THEN BEGIN
                loans.calcfields("Total Arrears");
                TArrears := Loans."Total Arrears" - Loans.Repayment;
                if Loans."Repay Mode" = loans."Repay Mode"::"Check Off" then
                    if TArrears > 1 then begin
                        QualAmt := 0;

                        Remark := 'You have defaulted ' + FORMAT(Loans."Loan Product Type") + ' with arrears Kshs ' + format(Loans."Total Arrears") + '.  Dial *470# and follow prompts to pay and try again';
                        EXIT;
                    end else begin
                        if Loans."Repay Mode" <> Loans."Repay Mode"::"Check Off" then begin
                            QualAmt := 0;
                            Remark := 'You have defaulted ' + FORMAT(Loans."Loan Product Type") + ' with arrears Kshs ' + format(Loans."Total Arrears") + '.  Dial *470# and follow prompts to pay and try again';
                            EXIT;
                        end;
                    end;
            END;



            if LoanProductType <> 'L43' then begin

                MaxLoanAmount := LoanType."Maximum Loan Amount";
                DepositPercentage := 0;


                //% on deposits
                MemberAccount.Reset();
                MemberAccount.SetRange("Member No.", Members."No.");
                MemberAccount.SetRange("Product Category", PSetup."Product Category"::"Deposit Contribution");
                MemberAccount.SetRange(Status, MemberAccount.Status::Active);
                if MemberAccount.FindFirst() then begin
                    ProdSetup.Get(LoanProductType);
                    //DepositPercentage := ProdSetup."Deposit %" * GetMobileLoansGuaranteedFreeShares(MemberAccount, LoanProductType) * 0.01;
                    DepositPercentage := GetMobileLoansGuaranteedFreeShares(MemberAccount, LoanProductType);

                    if DepositPercentage < 0 then
                        DepositPercentage := 0;

                end;

                QualAmt := Round(DepositPercentage, 1, '=');

                IF QualAmt > MaxLoanAmount THEN
                    QualAmt := MaxLoanAmount;

                /*if LoanType."Allow Multiple Running Loans" then begin

                    Loans.RESET;
                    Loans.SETRANGE("Member No.", saccoAccount."Member No.");
                    Loans.SETRANGE("Loan Product Type", LoanProductType);
                    Loans.SETFILTER("Total Outstanding Balance", '>0');
                    Loans.SetAutoCalcFields("Outstanding Principal", "Outstanding Penalty");
                    IF Loans.findset() then
                        repeat
                            ExistingLoans += Loans."Outstanding Principal";
                        until Loans.Next() = 0;

                    QualAmt -= ExistingLoans;
                end;*/

                IF (LoanType."Minimum Loan Amount" > QualAmt) THEN BEGIN
                    QualAmt := 0;
                    Remark := 'The amount qualified is less than the minimum loan amount';
                    EXIT;
                END;

            end;
        end;
    end;

    procedure GetMobileLoansGuaranteedFreeShares(MemberAccounts: Record "Savings Accounts"; LoanProduct: Code[20]) FreeShares: decimal;
    var
        LoanSecurity: Record "Loan Security";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Committed: Decimal;
        Available: Decimal;
    begin
        FreeShares := 0;

        // LoanSecurity.CalculateMobileLoansAvailableShares(MemberAccounts, DepAmt, GuaranteedInApplication, Committed, Available, true, LoanProduct);
        FreeShares := Available;
    end;

    procedure GetSelfGuaranteeFreeShares(MemberAccounts: Record "Savings Accounts") FreeShares: decimal;
    var
        LoanSecurity: Record "Loan Security";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Committed: Decimal;
        Available: Decimal;
    begin
        FreeShares := 0;

        LoanSecurity.CalculateAvailableShares(MemberAccounts, DepAmt, GuaranteedInApplication, Committed, Available, true);
        FreeShares := Available;
    end;

    Procedure GetDividendLoanQualifiedAmount(AccountNo: Code[20]; LoanProductType: Code[20]; VAR QualAmt: Decimal; VAR Remark: Text)
    var
        saccoAccount: Record "Savings Accounts";
        Acc: Record "Savings Accounts";
        GeneralSetUp: record "Sacco Setup";
        Legacy: Codeunit Legacy;
        SActivities: Codeunit "SAcco Activities";
        MActivities: Codeunit "Member Activities";
        PSetup: Record "Product Setup";
        Loans: Record Loans;
        nDays: integer;

        SalStart: date;
        sCount: integer;

        Salary1: decimal;
        Salary2: decimal;
        Salary3: decimal;
        SalAvg: Decimal;

        SalEnd: date;

        SalBuffer: Record "Salary Lines";
        NetSal: Decimal;
        STO: Decimal;
        RepAmt: decimal;
        MaxLoanAmount: decimal;
        TotalSalary: decimal;
        SmallestSal: Decimal;
        OldAccount: Record "Sacco Account";
        LBal: Decimal;
        DividendAdvance: Record "M-Dividend Progression";
        DividendAdvanceDefaulter: Record "Dividend Advance - Defaulter";
        MDividend: Record "M-Dividend Progression";
        DividendProgression: record "Dividends Progression";
        SaccoSetup: Record "Sacco Setup";
        DivYear: Text;
        StartDate: date;
        DividendAcc: Record "Savings Accounts";
        MemberActivities: Codeunit "Member Activities";
        Diff: Decimal;
        DivAcc: code[30];
        Unqualified: Record "Unqualified For Dividend Adv";
        BalDate: Date;
        TotArrears: Decimal;
        TArrears: Decimal;
        SaccoActivities: Codeunit "Sacco Activities";
        InterestArrears: Decimal;
        PrincipalArrears: Decimal;
        MonthlyBalance: Decimal;
        DimSetID: Integer;
        ExpectedBal: Decimal;
        CurrentBal: Decimal;
        DaysInArrear: integer;
        PDate: Date;
        ArrearsDate: Date;
    begin


        Remark := '';
        QualAmt := 0;
        PrincipalArrears := 0;
        PDate := Today();

        saccoAccount.RESET;
        saccoAccount.SETRANGE("No.", AccountNo);
        IF saccoAccount.FIND('-') THEN BEGIN


            // Transfer Dividend Progression to the Mobile Dividend Progression
            SaccoSetup.Get();
            StartDate := Calcdate('-1Y+1D', SaccoSetup."Dividend Year Date");
            DivAcc := Legacy.GetDepositAccounts(saccoAccount."Member No.");
            QualAmt := 0;

            PSetup.Reset();
            PSetup.SetRange("Product Category", PSetup."Product Category"::"Deposit Contribution");
            if PSetup.FindFirst() then begin

                DividendProgression.Reset();
                DividendProgression.setrange("Product Type", PSetup."Product ID");
                DividendProgression.setrange("Account No", DivAcc);
                //DividendProgression.SetFilter("Start Date", '>=%1', CalcDate('-1D', StartDate));
                DividendProgression.SetFilter("Start Date", '%1..%2', CalcDate('-1M', StartDate), DMY2Date(31, 08, 2024));
                DividendProgression.SetFilter("End Date", '<=%1', SaccoSetup."Dividend Year Date");
                if DividendProgression.FindFirst() then begin
                    repeat
                        QualAmt += DividendProgression."Net Dividends";
                    until DividendProgression.next = 0;
                end;
            end;

            IF LoanType.GET(LoanProductType) THEN BEGIN

                Members.GET(saccoAccount."Member No.");


                LBal := 0;
                Loans.RESET;
                Loans.SETRANGE("Member No.", saccoAccount."Member No.");
                Loans.SETRANGE("Loan Product Type", LoanProductType);
                Loans.SETFILTER("Total Outstanding Balance", '>0');
                IF Loans.FINDFIRST THEN BEGIN
                    repeat
                        Loans.CALCFIELDS("Outstanding Principal");
                        LBal += Loans."Outstanding Principal";
                    until Loans.next = 0;
                END;


                IF (Members."Member Status" = Members."Member Status"::Deceased) or
                (Members."Member Status" = Members."Member Status"::Withdrawn) or
                (Members."Member Status" = Members."Member Status"::"Withdrawal Application")
                THEN BEGIN
                    QualAmt := 0;
                    Remark := 'You BOSA Account is not active';
                    EXIT;
                END;

                //check how long member has been active
                IF (Members."Registration Date" = 0D) THEN BEGIN
                    QualAmt := 0;
                    Remark := 'You Membership Period is less than 12 Months';
                    EXIT;
                END;

                /*IF (Members."Block Mobile Loan" = true) THEN BEGIN
                    QualAmt := 0;
                    Remark := 'You have been blocked from accessing this loan. Kindly Contact the SACCO';
                    EXIT;
                END;
                */

                nDays := TODAY - Members."Registration Date";
                IF nDays < 90 THEN BEGIN
                    QualAmt := 0;
                    Remark := 'You Membership Period is less than 3 Months';
                    EXIT;
                END;

                Loans.RESET;
                Loans.SETRANGE("Member No.", saccoAccount."Member No.");
                //Loans.SETFILTER("Loans Category-SACCO", '<>%1', Loans."Loans Category-SACCO"::Perfoming);
                Loans.SETFILTER("Loan Product Type", '<>%1&<>%2&<>%3&<>%4', 'L43', 'L24', 'L27', 'L30');
                Loans.SETFILTER("Outstanding Principal", '>0');
                /*IF Loans.FINDFIRST THEN
                    repeat
                        loans.calcfields("Total Arrears");
                        ArrearsDate := 0D;
                        SaccoActivities.GetDefaultedAmount(Loans."Loan No.", CalcDate('-1M+CM', PDate), ExpectedBal, CurrentBal, PrincipalArrears, DaysInArrear, ArrearsDate, true);

                        TArrears := PrincipalArrears;

                        if Loans."Repay Mode" = loans."Repay Mode"::"Check Off" then
                            if TArrears > 1 then begin
                                QualAmt := 0;
                                Remark := 'You have defaulted ' + FORMAT(Loans."Loan Product Type") + ' with arrears Kshs ' + format(Loans."Total Arrears") + '.  Dial *470# and follow prompts to pay and try again';
                                EXIT;
                            end else begin
                                if Loans."Repay Mode" <> Loans."Repay Mode"::"Check Off" then begin
                                    QualAmt := 0;
                                    Remark := 'You have defaulted ' + FORMAT(Loans."Loan Product Type") + ' with arrears Kshs ' + format(Loans."Total Arrears") + '.  Dial *470# and follow prompts to pay and try again';
                                    EXIT;
                                end;
                            end;
                    until Loans.Next() = 0;
                    */

                Acc.Reset();
                Acc.SetRange("Member No.", Members."No.");
                Acc.SetRange("Product Category", PSetup."Product Category"::"Deposit Contribution");
                Acc.SetRange(Status, Acc.Status::Dormant);
                /*if Acc.FindFirst() then begin

                    QualAmt := 0;
                    Remark := 'Your account is DORMANT. Activate your deposits account to enjoy our M-Loan services. Dial *470# and follow prompts.';
                    EXIT;

                end;*/

                // Message('QualAmt %1 \LBal %2', QualAmt, LBal);
                QualAmt := Round(QualAmt - LBal, 1, '<');

                MaxLoanAmount := LoanType."Maximum Loan Amount";

                IF QualAmt > MaxLoanAmount THEN
                    QualAmt := MaxLoanAmount;


                if QualAmt < 0 then
                    QualAmt := 0;

            END;
        END;


    end;

    procedure PostPendingCharges() Response: Text
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        MpesaTrans: Record "Sky Transactions.";
        SLEdger: Record "Savings Ledger Entry";
        TransAmt: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        RunBal: Decimal;
        AccBal: Decimal;
        Loans: Record Loans;
        IntAmt: Decimal;
        PrAmt: Decimal;
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
        BillAcc: Record "Savings Accounts";
        IntRate: Decimal;
        MemberName: Text;
        Depositor: Text;
        GenSetup: Record "Sacco Setup";
        Members: Record Members;
        AccMNo: Code[20];
        BosaTrans: Boolean;
        DepDesc: Text;
        PayBillAccNo: Code[20];
        MAccNo: Code[20];
        LoanAccount: Boolean;
        DepositAccount: Boolean;
        IDNo: Code[20];
        MNo: Code[20];
        BosaTransType: Option "None","Loan Repayment","Share Capital","Deposit Contribution","Deposit Contribution Micro","Retirement Saving Fund","Registration Fee","Insurance Contribution","FOSA SHARES";
        "Key": Code[20];
        LNo: Code[20];
        MemberPhoneNo: Code[20];
        Vend: Record "Savings Accounts";
        PrAcc: Record "Savings Accounts";
        PrMno: Code[20];
        DepBal: Decimal;
        TransType: Enum "Transaction Type Enum";
        AcctName: Text;
        SafComDepChargesGL: Code[20];
        MName: Text;
        AccountTypes: Record "Product Setup";
        ChargeSacco: Boolean;
        Source: Enum "SMS Source Enum";
        Found: Boolean;
    begin

        MpesaTrans.Reset;
        MpesaTrans.SetRange("Transaction Type", MpesaTrans."Transaction Type"::"Mpesa Withdrawal");
        MpesaTrans.SETRANGE("Transaction ID", 'QL285YO43S');
        MpesaTrans.SetRange(Posted, true);
        MpesaTrans.SetRange(Updated, false);
        if MpesaTrans.FindFirst then begin
            GenSetup.Get;


            // Get Excise duty G/L
            ExciseDutyGL := GetExciseDutyGL();
            ExciseDutyRate := GetExciseRate();
            ExciseDuty := 0;

            //Message('AccNo %1\LoanAccount %2\DepositAccount %3\IDNo %4\MNo %5\BosaTransType %6',AccNo,LoanAccount,DepositAccount,IDNo,MNo,BosaTransType);


            SaccoAccount := '';
            SaccoFee := 0;
            VendorAccount := '';
            VendorCommission := 0;
            SafcomAcc := '';
            SafcomFee := 0;
            PrePaymentGL := '';
            SMSAccount := '';
            SMSCharge := 0;
            ChargeSacco := false;

            CoopSetup.Reset;
            //CoopSetup.SetRange("Transaction Type", MpesaTrans."Transaction Type");
            if CoopSetup.FindFirst then begin

                SMSAccount := CoopSetup."SMS Account";
                SMSCharge := CoopSetup."SMS Charge";
                SafComDepChargesGL := CoopSetup."Safaricom Dep Charges GL";

                if MpesaTrans.MobileApp then
                    SMSCharge := 0;


                SafcomFee := 0;
                if CoopSetup."Safcom Staggered Fee" then
                    SafcomFee := GetStaggeredSaccoFee(CoopSetup."Safcom Staggered Charge", MpesaTrans.Amount);

                PrePaymentGL := CoopSetup."Pre-Payment Account";
                SafcomAcc := CoopSetup."Safaricom Account";
                SaccoAccount := CoopSetup."Sacco Fee Account";
                SaccoFee := CoopSetup."Sacco Fee";
                if CoopSetup."Sacco Staggered Fee" then
                    SaccoFee := GetStaggeredSaccoFee(CoopSetup."Sacco Staggered Charge", MpesaTrans.Amount);

                VendorAccount := CoopSetup."Vendor Commission Account";
                VendorCommission := CoopSetup."Vendor Commission";

                if CoopSetup."Vendor Staggered Fee" then
                    VendorCommission := GetStaggeredSaccoFee(CoopSetup."Vendor Staggered Charge", MpesaTrans.Amount);



                if MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Mpesa Withdrawal" then begin
                    if (SavAcc.Get(MpesaTrans."Member Account")) then begin
                        if AccountTypes.Get(SavAcc."Product Type") then begin
                            if AccountTypes."Exempt Mbanking C/W Fee" then begin
                                AccountTypes.TestField("Mbanking Expense GL");
                                SafcomFee := 0;
                                ChargeSacco := true;
                            end;
                        end;
                    end;
                end;
                //xxx

                SafcomFee := 0;
                IF MpesaTrans."Transaction Type" = MpesaTrans."Transaction Type"::"Mpesa Withdrawal" THEN BEGIN
                    SafcomCharges.RESET;
                    SafcomCharges.SETFILTER(Charge, '>0');
                    SafcomCharges.SETFILTER(Minimum, '<=%1', MpesaTrans.Amount);
                    SafcomCharges.SETFILTER(Maximum, '>=%1', MpesaTrans.Amount);
                    IF SafcomCharges.FINDFIRST THEN BEGIN
                        SafcomFee := SafcomCharges.Charge;
                    END;
                END;


                SaccoFee := CoopSetup."Sacco Fee";
                if CoopSetup."Sacco Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(CoopSetup."Sacco Staggered Charge", MpesaTrans.Amount, SaccoFee, ChargeDuty, ChargeAcctType, ChargeAcct);

                VendorCommission := 0;

                Message('SaccoFee %1\safcomFee %2', SaccoFee, safcomFee);


                SLEdger.Reset();
                SLEdger.SetRange("Document No.", MpesaTrans."Transaction ID");
                SLEdger.SetRange("Account No.", MpesaTrans."Member Account");
                SLEdger.SetRange(Amount, SaccoFee);
                if SLEdger.findfirst then
                    SaccoFee := 0;

                SLEdger.Reset();
                SLEdger.SetRange("Document No.", MpesaTrans."Transaction ID");
                SLEdger.SetRange("Account No.", MpesaTrans."Member Account");
                SLEdger.SetRange(Amount, SafcomFee);
                if SLEdger.findfirst then
                    SafcomFee := 0;


                Message('* \SaccoFee %1\safcomFee %2', SaccoFee, safcomFee);
                TotalCharge := SaccoFee + VendorCommission + SafcomFee + SMSCharge;
                ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
            end
            else begin
                //if MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Pay Loan From Account" then
                //ERROR('Setup Missing for %1', MpesaTrans."Transaction Type");
            end;



            MAccNo := '';
            LoanAccount := false;
            DepositAccount := false;
            IDNo := '';
            MNo := '';
            Key := '';
            LNo := '';
            MemberPhoneNo := '';




            MemberPhoneNo := '';
            if (SavAcc.Get(MpesaTrans."Member Account")) or ((Members.Get(MpesaTrans."Member Account")) and (MpesaTrans."Bosa Transaction" <> MpesaTrans."bosa transaction"::None)) then begin
                if (SavAcc.Get(MpesaTrans."Member Account")) then begin
                    MemberName := SavAcc.Name;
                    MNo := SavAcc."Member No.";
                    BosaTrans := false;
                    MemberPhoneNo := SavAcc."Transactional Mobile No";
                    if MemberPhoneNo = '' then
                        MemberPhoneNo := SavAcc."Phone No.";

                    if MNo = '' then begin
                        //SavAcc.TESTFIELD("ID No.");
                        if SavAcc."ID No." <> '' then begin
                            Members.Reset;
                            Members.SetRange("ID No.", SavAcc."ID No.");
                            if Members.FindFirst then
                                MNo := Members."No.";
                        end;
                    end;
                    if MNo <> '' then begin
                        if Members.Get(MNo) then begin

                            if MemberPhoneNo = '' then
                                MemberPhoneNo := Members."Phone No.";
                        end
                    end;
                end;

                TransAmt := MpesaTrans.Amount;
                AccountToCharge := '';
                if BillAcc.Get(MpesaTrans."Member Account") then begin
                    AccountToCharge := BillAcc."No.";
                end
                else begin
                    BillAcc.Reset;
                    BillAcc.SetRange("Member No.", MNo);
                    BillAcc.SetFilter("Transactional Mobile No", '<>%1', '');
                    if BillAcc.FindFirst then
                        AccountToCharge := BillAcc."No.";
                end;
                if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Loan Repayment") or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill) or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Deposit") or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Deposit") or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Agent Deposit") or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Pay Loan From Account")

                    then
                    TransAmt := TransAmt * -1;

                if BosaTrans then begin
                    if Members.Blocked <> Members.Blocked::" " then begin
                        MpesaTrans.Remarks := 'Bosa Account Blocked';
                        MpesaTrans."Needs Change" := true;
                        MpesaTrans.Modify;
                        exit;
                    end;

                end;
                // else begin
                //     if SavAcc.Blocked <> SavAcc.Blocked::" " then begin
                //         MpesaTrans.Remarks := 'Fosa Account Blocked';

                //         MpesaTrans."Needs Change" := true;
                //         MpesaTrans.Modify;
                //         exit;
                //     end;
                // end;

                //BUser.GET(USERID);

                //BUser.TESTFIELD("Cashier Journal Template");
                //BUser.TESTFIELD("Cashier Journal Batch");

                JTemplate := 'GENERAL';
                JBatch := 'MBANKING';

                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                GenJournalBatch.SetRange(Name, JBatch);
                if not GenJournalBatch.FindFirst then begin
                    GenJournalBatch.Init;
                    GenJournalBatch."Journal Template Name" := JTemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.Description := 'Mbanking Batch';
                    GenJournalBatch.Insert;
                end;

                DocNo := MpesaTrans."Transaction ID";
                PDate := MpesaTrans."Transaction Date";

                AccNo := MpesaTrans."Member Account";
                ExtDoc := MpesaTrans."Account Name";
                LoanNo := '';
                TransType := Transtype::" ";
                Dim1 := SavAcc."Global Dimension 1 Code";
                Dim2 := SavAcc."Global Dimension 2 Code";
                SystCreated := true;
                //dd
                SaccoTrans.JournalInit(JTemplate, JBatch);
                DepBal := 0;
                AcctType := Accttype::Savings;

                if TotalCharge > 0 then begin
                    BalAccNo := '';

                    if (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::Paybill) and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Mpesa Deposit")
                        and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Loan Repayment") and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Bank Deposit")
                       and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Bank Agent Deposit") then begin

                        if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Withdrawal") then
                            AccountToCharge := AccNo;


                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", SafcomAcc, CopyStr('Safaricom Charge', 1, 50), Balacctype::"G/L Account",
                                      '', -SafcomFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SaccoAccount, CopyStr(Format(MpesaTrans."Transaction Type") + ': Mbanking Charge', 1, 50), Balacctype::"G/L Account",
                                      '', -SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"G/L Account",SMSAccount,COPYSTR('Notification Charge - ',1,50),BalAccType::"G/L Account",
                        //            '',SMSCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MpesaTrans."Member Name");

                        /*
                  SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccountToCharge,COPYSTR('Mbanking Charge',1,50),BalAccType::"G/L Account",
                                '',VendorCommission,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MpesaTrans."Member Name");
                  SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccountToCharge,COPYSTR('Corporate Charge',1,50),BalAccType::"Bank Account",
                                SafcomAcc,SafcomFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MpesaTrans."Member Name");
                  SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccountToCharge,COPYSTR('Transaction Charge',1,50),BalAccType::"G/L Account",
                                SaccoAccount,SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MpesaTrans."Member Name");
                  SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccountToCharge,COPYSTR('Notification Charge - ',1,50),BalAccType::"G/L Account",
                                SMSAccount,SMSCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MpesaTrans."Member Name");
                         */

                        if ChargeSacco then begin
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", AccountTypes."Mbanking Expense GL", CopyStr(Format('Mbanking Charge'), 1, 50), Balacctype::"G/L Account",
                                      '', TotalCharge + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                        end
                        else begin
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccountToCharge, CopyStr(Format('Mbanking Charge'), 1, 50), Balacctype::"G/L Account",
                                      '', TotalCharge + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());
                        end;
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty - ' + Format(MpesaTrans."Transaction Type"), 1, 50), Balacctype::"G/L Account",
                                      '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());



                    end
                    else begin

                        CoopSetup.TestField("Non-Member Debit Account");
                        BalAccNo := CoopSetup."Non-Member Debit Account";

                        DepDesc := 'C2B Mpesa Deposit';
                        if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Deposit") then
                            DepDesc := 'C2B Bank Deposit';
                        if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Agent Deposit") then
                            DepDesc := 'C2B Bank Agent Deposit';


                        /*
                        IF NOT BosaTrans THEN
                            AcctType := AcctType::Vendor
                        ELSE BEGIN
                            AcctType := Accttype::Credit;
                            AccountToCharge := AccNo;
                        END;

                        IF (MpesaTrans."Transaction Type" <> MpesaTrans."Transaction Type"::Paybill) THEN

                        SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType,AccountToCharge,'Mbanking Charge',BalAccType::"G/L Account",
                              '',VendorCommission,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MpesaTrans."Member Name");


                        IF (MpesaTrans."Transaction Type" = MpesaTrans."Transaction Type"::"Bank Agent Deposit")  THEN BEGIN
                          SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Vendor,AccountToCharge,DepDesc,BalAccType::"Bank Account",
                                      SafcomAcc,SafcomFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,MpesaTrans."Member Name");

                        END;
                        */


                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SafComDepChargesGL, CopyStr('Safaricom Deposit Charge', 1, 50), Balacctype::"G/L Account",
                                      BalAccNo, -SafcomFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());


                    end;


                    AccNo := VendorAccount;
                    ExtDoc := MpesaTrans."Member Account";
                    LoanNo := '';
                    TransType := Transtype::" ";

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, AccNo, CopyStr('Fee on ' + MpesaTrans.Description, 1, 50), Balacctype::"G/L Account",
                                  BalAccNo, -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());


                end;


                MpesaTrans.Updated := true;
                //MpesaTrans."Posted By" := UserId;
                //MpesaTrans."Date Posted" := Today;
                //MpesaTrans."Send SMS" := true;
                MpesaTrans.Modify;

                //Error('VendorCommission %1', VendorCommission);

                Priority := 201;
                SaccoTrans.JournalPost(JTemplate, JBatch);

            end;
        end;

    end;


    procedure RollOver(CheckDate: Date)
    var
        Loans: Record Loans;
        Logs: Record "Rollover Logs";
        PSetup: Record "Product Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        IntDue: decimal;
        i: Integer;
        Skip: Boolean;
        SystCreated: Boolean;
        SaccoSetup: Record "Sacco Setup";
        TransactionType: Enum "Transaction Type Enum";
    begin
        SaccoSetup.Get();

        Loans.Reset();
        Loans.SetRange("Mobile Loan", true);
        Loans.SetRange("Loan Product Type", 'L30');
        Loans.SetFilter("Outstanding Principal", '>0');
        Loans.SetFilter("Rollover Count", '<3');
        Loans.SetFilter("Completion Date", '<%1', CheckDate);
        Loans.SetAutoCalcFields("Outstanding Principal");
        if Loans.FindSet() then
            repeat

                Skip := false;

                Members.Reset();
                Members.setrange("No.", Loans."Member No.");
                Members.Setrange("Member Status", Members."Member Status"::Deceased);
                if Members.findfirst() then
                    Skip := true;

                if (CalcDate(SaccoSetup."Rollover Allowance Period", Loans."Completion Date") = CheckDate) and (Skip = false) then begin

                    Logs.Reset();
                    Logs.SetRange("Loan no.", Loans."Loan No.");
                    Logs.SetFilter("Date Processed", '%1', CheckDate);
                    if not Logs.findfirst() then begin



                        Logs.Reset();
                        if Logs.FindLast() then
                            i := Logs."Entry No." + 1;

                        Loans."Completion Date" := CalcDate('+1M', Loans."Completion Date");
                        Loans.Installments += 1;

                        JTemplate := 'GENERAL';
                        JBatch := 'ROLLOVER';

                        GenJournalBatch.Reset;
                        GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                        GenJournalBatch.SetRange(Name, JBatch);
                        if not GenJournalBatch.FindFirst then begin
                            GenJournalBatch.Init;
                            GenJournalBatch."Journal Template Name" := JTemplate;
                            GenJournalBatch.Name := JBatch;
                            GenJournalBatch.Description := 'Mbanking Batch';
                            GenJournalBatch.Insert;
                        end;

                        DocNo := 'R-FEE ' + Loans."Loan No.";
                        PDate := today;

                        PSetup.Get(Loans."Loan Product Type");
                        PSetup.TestField("Rollover Fee %");

                        IntDue := 0;
                        IntDue := Loans."Outstanding Principal" * PSetup."Rollover Fee %" * 0.01;

                        SaccoTrans.JournalInit(JTemplate, JBatch);

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr('Rollover Fee', 1, 50), Balacctype::"G/L Account",
                                       PSetup."Loan Interest Income [G/L]", IntDue, ExtDoc, Loans."Loan No.", Transtype::"Interest Due", Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                        SaccoTrans.JournalPost(JTemplate, JBatch);

                        Loans.Modify();
                        Commit();

                        Logs.init();
                        Logs."Loan no." := Loans."Loan No.";
                        Logs."Entry No." := i;
                        Logs."Date Processed" := today;
                        Logs.Insert();

                        SaccoTrans.GenerateMobileRepaymentSchedule(Loans);
                    end;
                end;
            until Loans.Next() = 0;
    end;



    procedure RollOver2(CheckDate: Date; LoanNo: Code[20])
    var
        Loans: Record Loans;
        Loans2: Record Loans;
        Logs: Record "Rollover Logs";
        PSetup: Record "Product Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
        ExtDoc: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        IntDue: decimal;
        i: Integer;
        D: Integer;
        M: Integer;
        Y: Integer;
        IntDueDate: Date;
        LSchedule: Record "Loan Repayment Schedule";
        SystCreated: Boolean;
        SaccoSetup: Record "Sacco Setup";
        TransactionType: Enum "Transaction Type Enum";
    begin
        SaccoSetup.Get();

        Loans.Reset();
        Loans.SetRange("Mobile Loan", true);
        Loans.SetRange("Loan No.", LoanNo);
        Loans.SetRange("Loan Product Type", 'L30');
        Loans.SetFilter("Outstanding Principal", '>0');
        Loans.SetFilter("Rollover Count", '<%1', 3);
        //Loans.SetFilter("Completion Date", '<%1', CheckDate);
        Loans.SetAutoCalcFields("Outstanding Principal");
        if Loans.FindSet() then begin
            //repeat
            LSchedule.reset();
            LSchedule.setrange("Loan No.", Loans."Loan No.");
            if LSchedule.findlast() then begin

                IntDueDate := 0D;
                IntDueDate := SaccoTrans.GetLoanRePaymentDate(Loans, CheckDate);
                IntDueDate := CalcDate('3D', IntDueDate);

                D := 0;
                M := 0;
                Y := 0;
                //if CalcDate(SaccoSetup."Rollover Allowance Period", Loans."Completion Date") = CheckDate then begin

                Loans2.Reset;
                Loans2.SetRange("Loan No.", Loans."Loan No.");
                Loans2.SetRange("Date Filter", CalcDate('-CM', IntDueDate), CalcDate('CM', IntDueDate));
                Loans2.SetFilter("Outstanding Principal", '>0');
                if Loans2.FindSet() then begin
                    Loans2.CalcFields("Interest Due");
                end else begin
                    Loans2.Reset;
                    Loans2.SetRange("Loan No.", Loans."Loan No.");
                    Loans2.SetRange("Date Filter", CalcDate('-CM', CheckDate), CalcDate('CM', CheckDate));
                    Loans2.SetFilter("Outstanding Principal", '>0');
                    if Loans2.FindSet() then
                        Loans2.CalcFields("Interest Due");
                end;

                Logs.Reset();
                Logs.SetRange("Loan no.", Loans."Loan No.");
                Logs.SetFilter("Date Processed", '%1', IntDueDate);
                if not Logs.findfirst() then begin

                    Logs.Reset();
                    if Logs.FindLast() then
                        i := Logs."Entry No." + 1;

                    Loans."Completion Date" := CalcDate('+1M', Loans."Completion Date");
                    Loans.Installments += 1;

                    JTemplate := 'GENERAL';
                    JBatch := 'ROLLOVER';

                    GenJournalBatch.Reset;
                    GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                    GenJournalBatch.SetRange(Name, JBatch);
                    if not GenJournalBatch.FindFirst then begin
                        GenJournalBatch.Init;
                        GenJournalBatch."Journal Template Name" := JTemplate;
                        GenJournalBatch.Name := JBatch;
                        GenJournalBatch.Description := 'Mbanking Batch';
                        GenJournalBatch.Insert;
                    end;

                    DocNo := 'R-FEE ' + Loans."Loan No.";
                    PDate := IntDueDate;

                    PSetup.Get(Loans."Loan Product Type");
                    PSetup.TestField("Rollover Fee %");

                    IntDue := 0;
                    IntDue := (Loans."Outstanding Principal" * PSetup."Rollover Fee %" * 0.01) - Loans2."Interest Due";

                    Members.Reset();
                    Members.setrange("No.", Loans."Member No.");
                    Members.Setrange("Member Status", Members."Member Status"::Deceased);
                    if Members.findfirst() then
                        IntDue := 0;

                    SaccoTrans.JournalInit(JTemplate, JBatch);

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr('Rollover Fee', 1, 50), Balacctype::"G/L Account",
                                   PSetup."Loan Interest Income [G/L]", IntDue, ExtDoc, Loans."Loan No.", Transtype::"Interest Due", Dim1, Dim2, SystCreated, Channel::Mobile, GetUserDimensionSet());

                    SaccoTrans.JournalPost(JTemplate, JBatch);

                    Loans.Modify();
                    Commit();

                    Logs.init();
                    Logs."Loan no." := Loans."Loan No.";
                    Logs."Entry No." := i;
                    Logs."Date Processed" := CheckDate;
                    Logs.Insert();

                    SaccoTrans.GenerateMobileRepaymentSchedule(Loans);
                end;
            end;
        end;
        //until Loans.Next() = 0;
    end;


    procedure RecoverDefaultedInstantLoans(HeaderNo: Code[20]; pdate: date)
    var
        Sasra: Record "Sasra Categorization";
        Sacco: Record "Salary Lines";
        Loans: Record Loans;
        SActivities: Codeunit "Sacco Activities";
        SDate: datetime;
        EDate: datetime;
        Legacy: Codeunit Legacy;
        PSetup: Record "Product Setup";
        SalaryLines: Record "Salary Lines";

    begin

        /*
        Loans.reset;
        Loans.SetRange("Ledger Exists", false);
        Loans.SetRange(Posted, true);
        if Loans.findset(true) then begin
            repeat
                Loans.Posted := false;
                Loans.Modify();
            until Loans.next = 0;
        end;
        */

        Sacco.Reset();
        Sacco.SetRange("Salary Header No.", HeaderNo);
        if Sacco.FindFirst() then begin
            repeat
                Loans.Reset();
                Loans.SetRange("Member No.", Sacco."Member No.");
                Loans.SetRange("Loan Product Type", 'L09');
                Loans.SetFilter("Date Filter", '..%1', PDate);
                Loans.SetFilter("Outstanding Principal", '>0');
                if Loans.FindFirst() then begin
                    if Loans."Disbursement Account No" = '' then
                        Loans."Disbursement Account No" := Legacy.GetOrdinaryAccount(Loans."Member No.");


                    SActivities.RecoverDefaultedInstantLoanFromSavingsAccounts(Loans."Loan No.", Loans."Loan Product Type", true, false, Loans."Dimension Set ID");

                end;
            until Sacco.Next() = 0;
        end;
    end;


    procedure RecoverDefaultedLoans()
    var
        Sasra: Record "Sasra Categorization";
        Sacco: Record "SACCO Categorization";
        Loans: Record Loans;
        SActivities: Codeunit "Sacco Activities";
        SDate: datetime;
        EDate: datetime;
        Legacy: Codeunit Legacy;
        PSetup: Record "Product Setup";

    begin

        /*
        Loans.reset;
        Loans.SetRange("Ledger Exists", false);
        Loans.SetRange(Posted, true);
        if Loans.findset(true) then begin
            repeat
                Loans.Posted := false;
                Loans.Modify();
            until Loans.next = 0;
        end;
        */

        Sacco.Reset();
        Sacco.SetCurrentKey("Issued Date");
        //Sacco.SetRange("Loan No.", 'A03269');
        //Sacco.SetFilter("Next Run Date", '<%1', CurrentDateTime);
        Sacco.SetFilter("Total Arrears", '>0');
        Sacco.SetRange("Mobile Loan", true);
        //Sacco.SetFilter(Balance, '>1000');
        if Sacco.FindFirst() then begin
            repeat

                Loans.Get(Sacco."Loan No.");
                if Loans."Disbursement Account No" = '' then begin
                    Loans."Disbursement Account No" := Legacy.GetOrdinaryAccount(Loans."Member No.");
                    if Loans."Repay Mode" <> Loans."Repay Mode"::Salary then begin
                        PSetup.get(Loans."Loan Product Type");
                        if PSetup."Global Dimension 1 Code" = 'FOSA' THEN begin
                            //Loans."Repay Mode" := Loans."Repay Mode"::Salary;
                            Loans.Modify();
                        end;
                    end;
                end;

                SActivities.RecoverDefaultedInstantLoanFromSavingsAccounts(Sacco."Loan No.", Sacco."Loan Product Type", true, false, Loans."Dimension Set ID");
            //Sacco."Next Run Date" := CurrentDateTime + 4000000;
            //Sacco.Modify();
            until Sacco.Next() = 0;
        end;
    end;

    procedure RecoverDefaultedMobileLoans(LoanNo: Code[20]);
    var
        Sasra: Record "Sasra Categorization";
        Sacco: Record "SACCO Categorization";
        Loans: Record Loans;
        SActivities: Codeunit "Sacco Activities";
        SDate: datetime;
        EDate: datetime;
        Legacy: Codeunit Legacy;
        PSetup: Record "Product Setup";
        SaccoSetup: Record "Sacco Setup";

    begin

        /*
        Loans.reset;
        Loans.SetRange("Ledger Exists", false);
        Loans.SetRange(Posted, true);
        if Loans.findset(true) then begin
            repeat
                Loans.Posted := false;
                Loans.Modify();
            until Loans.next = 0;
        end;
        */
        //LoanNo := 'BCLN001111';
        SaccoSetup.get();

        if (SaccoSetup."Mobile Loan Next RunDate" <> 0DT) and (SaccoSetup."Mobile Loan Next RunDate" < CurrentDateTime) then begin

            SaccoSetup."Mobile Loan Next RunDate" := CurrentDateTime + 86400000;
            SaccoSetup.Modify();



            Sacco.Reset();
            Sacco.SetCurrentKey("Issued Date");
            if LoanNo <> '' then
                Sacco.SetRange("Loan No.", LoanNo);
            //Sacco.SetFilter("Next Run Date", '<%1', CurrentDateTime);
            Sacco.SetFilter("Loan Product Type", '%1|%2|%3', 'L27', 'L30', 'L24');
            Sacco.SetFilter("Total Arrears", '>0');
            //Sacco.SetRange("Mobile Loan", true);
            //Sacco.SetFilter(Balance, '>1000');
            if Sacco.FindFirst() then begin
                repeat

                    Loans.Reset();
                    Loans.SetCurrentKey("Repayment Start Date");
                    Loans.SetRange("Loan No.", Sacco."Loan No.");
                    if Loans.FindFirst() then begin
                        Report.RUN(Report::"SACCO Loan Categorization", false, false, Loans);
                        Commit();
                    end;

                    Loans.Get(Sacco."Loan No.");
                    if Loans."Disbursement Account No" = '' then begin
                        Loans."Disbursement Account No" := Legacy.GetOrdinaryAccount(Loans."Member No.");
                        if Loans."Repay Mode" <> Loans."Repay Mode"::Salary then begin
                            PSetup.get(Loans."Loan Product Type");
                            if PSetup."Global Dimension 1 Code" = 'FOSA' THEN begin
                                //Loans."Repay Mode" := Loans."Repay Mode"::Salary;
                                Loans.Modify();
                            end;
                        end;
                    end;

                    SActivities.RecoverDefaultedMobileLoanFromDeposits(Loans."Loan No.", Sacco."Loan Product Type", true, false, Loans."Dimension Set ID");
                //Sacco."Next Run Date" := CurrentDateTime + 4000000;
                //Sacco.Modify();
                until Sacco.Next() = 0;
            end;
        end
    end;

    procedure UpdateFosaAccounts()
    var
        Fosa: Record "Savings Accounts";
        PSetup: Record "Product Setup";
        UPdated: Boolean;
    begin

        Fosa.Reset();
        Fosa.SetRange("Product Type", '0105|0104');
        if Fosa.FindFirst() then begin
            //     repeat
            Report.Run(Report::"Savings List Register", false, false, Fosa);
            /*
                            UPdated := false;

                            if CopyStr(Fosa."No.", 1, 4) = '0101' then
                                if PSetup.get(Fosa."Product Type") then begin

                                    if PSetup."Product Category" = PSetup."Product Category"::"Ordinary Savings" then begin
                                        if PSetup."Product ID" = '0101' then begin
                                            //if "Member No." = '14805' then begin
                                            if Fosa.Rename('0102-' + Fosa."Member No.") then;
                                            UPdated := true;
                                            //end;
                                        end;

                                    end;
                                end;
                                */

            // until (Fosa.Next() = 0) or (UPdated);
        end;

    end;

    procedure GetPictureBase64(MNo: Code[20]) PicBase64: Text
    var
        MemberImages: Record "Member Images";
        TempBlob: Record CustomTempBlob temporary;
    begin

        PicBase64 := '';
        //EXIT;
        MemberImages.Reset;
        MemberImages.SetRange("Member No.", MNo);
        if MemberImages.FindFirst then begin
            MemberImages.CalcFields(Picture);
            if MemberImages.Picture.Hasvalue then begin
                TempBlob.Init;
                TempBlob.Blob := MemberImages.Picture;
                PicBase64 := Format(TempBlob.ToBase64String);
            end;
        end;
    end;

    procedure GetNonMobileLoanLimits("FOSA Loans": decimal; "Net Salary": decimal; "Share Deposits": Decimal; "BOSA Loan balance": Decimal; Multiplier: integer; Period: integer; NetSalMultiplier: decimal; IntRate: decimal; var "Maximum Credit": Decimal; var "Maximum Fosa Credit": Decimal)

    var
        "BOSA Loans": Decimal;
        TotalSalary: Decimal;
        SalAvg: Decimal;
        SmallestSal: decimal;
        MAct: Codeunit "Member Activities";
        "Deposit Multiplier": Decimal;
        ProductSetup: Record "Product Setup";
        Legacy: Codeunit Legacy;
        RepAmt: Decimal;
        PVA: Decimal;


        "FOSA Loan balance": Decimal;


    begin

        if Multiplier = 0 then
            Multiplier := 5;


        "Net Salary" := SalAvg;
        if NetSalMultiplier = 0 then
            NetSalMultiplier := 60;



        "Net Salary" := round(NetSalMultiplier / 100 * "Net Salary");
        "Net Salary" := "Net Salary" - "FOSA Loans";

        if IntRate > 0 then
            If Period > 0 then
                PVA := ((1 - Power((1 + (IntRate / 1200)), -Period)) / (IntRate / 1200));

        "Deposit Multiplier" := "Share Deposits" * Multiplier;
        "Maximum Credit" := "Deposit Multiplier" - "BOSA Loan balance";
        "Maximum FOSA Credit" := ("Net Salary" - "FOSA Loans") * PVA;

    end;

    procedure GetNonMobileLoanValues(SavAcc: Record "Savings Accounts"; var "FOSA Loans": decimal; var "Net Salary": Decimal; var ShareDeposits: decimal; var "BOSA Loan balance": Decimal; Pensioner: Boolean)
    var
        RepAmt: Decimal;


        ProductSetup: Record "Product Setup";
        MNo: Code[20];
        TotalSalary: Decimal;


        SmallestSal: decimal;
        pva: decimal;

        "Share Deposits": Decimal;
        MAct: Codeunit "Member Activities";
        Legacy: Codeunit Legacy;
        "Deposit Multiplier": Decimal;

        "FOSA Loan balance": Decimal;
        "Maximum Credit": Decimal;
        "Maximum Fosa Credit": Decimal;
        SalAvg: Decimal;
        "BOSA Loans": decimal;
    begin


        Mno := savacc."Member No.";
        "FOSA Loans" := 0;
        "BOSA Loans" := 0;

        Loans.Reset();
        Loans.SetRange("Member No.", MNo);
        Loans.SetAutoCalcFields("Total Outstanding Balance");
        if Loans.Findset() then begin
            repeat
                if Loans."Total Outstanding Balance" > 0 then begin


                    Loans.CalcFields("Total Outstanding Balance");
                    RepAmt := Loans.Repayment;
                    if RepAmt > Loans."Total Outstanding Balance" then
                        RepAmt := Loans."Total Outstanding Balance";

                    if ProductSetup.Get(Loans."Loan Product Type") then begin
                        if ProductSetup."Repay Mode" <> ProductSetup."Repay Mode"::Dividends then begin

                            if Pensioner then begin
                                "FOSA Loans" += RepAmt;
                            end
                            else begin

                                if ProductSetup."Loan Source" = ProductSetup."Loan Source"::BOSA then
                                    "BOSA Loans" += RepAmt;
                                if ProductSetup."Loan Source" = ProductSetup."Loan Source"::fOSA then
                                    "FOSA Loans" += RepAmt;
                            end;
                        end;

                    end;
                end;

            until Loans.Next() = 0;
        end;

        SalAvg := 0;
        if SavAcc.salaried then
            SalaryAverage(SavAcc."no.", 3, TotalSalary, SalAvg, SmallestSal);


        "Net Salary" := SalAvg;


        ShareDeposits := MAct.GetAccountBalance(Legacy.GetDepositAccounts("MNo"));
        "BOSA Loan balance" := Legacy.GetTotalBosaLoanPrincipalBalance("MNo");

    end;

    procedure GenerateMobileLoanInterest(LoanNo: Code[20]; BillDate: Date; PDate: Date)
    var
        Loans: Record Loans;
    begin
        Loans.Reset();
        if LoanNo <> '' then
            Loans.SetRange("Loan No.", LoanNo);
        Loans.SetRange("Mobile Loan", true);
        Loans.SetFilter("Outstanding Principal", '>0');
        if Loans.FindSet(false) then begin
            repeat
                if BillDate = 0D then BillDate := Today;
                if PDate = 0D then PDate := Today;

                SaccoTrans.BillInterest(Loans, BillDate, PDate);

            until Loans.Next() = 0;
        end;
    end;

    procedure GetFuuzaBalance(AcctNo: Code[20]): Decimal
    var
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Setup";
        Bal: Decimal;
        Members: Record Members;
        Emp: Record Customer;
    begin

        Bal := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", AcctNo);
        if SavingsAccounts.Find('-') then begin

            SavingsAccounts.CalcFields("Approved Fuuza", "Virtual Approved Fuuza");
            if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Virtual Account" then
                Bal := SavingsAccounts."Approved Fuuza"
            else
                Bal := SavingsAccounts."Virtual Approved Fuuza";

        end;
        exit(Bal);

    end;


    procedure GetFuuzaLimit(AcctNo: Code[20]; AsAt: Date): Decimal
    var
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Setup";
        Limit: Decimal;
        Fuuza: Record Fuliza;
        Members: Record Members;
        Emp: Record Customer;
        VLedger: Record "Savings Ledger Entry";
        Bal: Decimal;
    begin


        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", AcctNo);
        SavingsAccounts.SetRange("Allow Fuuza", true);
        SavingsAccounts.SetFilter("Virtual Account No.", '%1', '');
        if SavingsAccounts.Find('-') then begin
            Members.get(SavingsAccounts."Member no.");
            SavingsAccounts."Virtual Account No." := MActivities.CreateVirtualFuuzaAccount(SavingsAccounts."no.", Members);
            SavingsAccounts.modify;
        end;


        Fuuza.reset;
        if Fuuza.FindFirst() then begin
            repeat
                if SavingsAccounts.get(Fuuza."Account No.") then begin
                    if SavingsAccounts."Product Category" <> SavingsAccounts."Product Category"::"Virtual Account" then
                        Fuuza.delete;
                end;
            until Fuuza.next = 0;
        end;

        Fuuza.reset;
        Fuuza.setrange("Account No.", AcctNo);
        Fuuza.SetFilter("Expiry Date", '<%1', AsAt);
        if Fuuza.FindFirst() then
            Fuuza.modifyall(Expired, true);

        Limit := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", AcctNo);
        SavingsAccounts.SetRange("Allow Fuuza", true);
        SavingsAccounts.SetFilter("Virtual Account No.", '<>%1', '');
        if SavingsAccounts.Find('-') then begin

            Fuuza.reset;
            Fuuza.setrange("Account No.", SavingsAccounts."Virtual Account No.");
            Fuuza.SetFilter("Expiry Date", '<%1', AsAt);
            if Fuuza.FindFirst() then
                Fuuza.modifyall(Expired, true);


            SavingsAccounts.calcfields("Balance (LCY)", "Virtual Balance (LCY)", "Virtual Approved Fuuza");

            if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Ordinary Savings" then begin
                limit := 500;
            end
            else begin

                VLedger.Reset();
                VLedger.SetRange("Account No.", AcctNo);
                //VLedger.setrange("Posting Date", CalcDate('-1M-CM', AsAt), CalcDate('-1M+CM', AsAt));
                VLedger.setrange("Posting Date", CalcDate('-30D', AsAt), AsAt);
                VLedger.SetRange(Reversed, false);
                VLedger.SetFilter(Amount, '<0');
                if VLedger.FindFirst() then begin
                    VLedger.CalcSums(Amount);
                    VLedger.Amount := VLedger.amount * -1;
                    If VLedger.count > 0 then begin
                        Limit := Round(vledger.Amount / 30);
                        Limit := Round(Limit * VLedger.count / 100, 1, '>');
                    end;


                end;

            end;

            // Message('L1 %1', Limit);
            Bal := GetAccountBalance((SavingsAccounts."No."));
            //Bal += SavingsAccounts."Virtual Balance (LCY)";

            if Bal < 0 then
                Limit -= abs(Bal);

            if LImit < 100 then
                limit := 0;


            //Message('L2 %1', Limit);
            if Limit > 0 then begin
                if SavingsAccounts."Virtual Approved Fuuza" = 0 then begin

                    Fuuza.init;
                    Fuuza."No." := '';
                    Fuuza.validate("Account No.", SavingsAccounts."Virtual Account No.");
                    Evaluate(Fuuza.Duration, '1M');
                    Fuuza.validate("Effective/Start Date", calcdate('-CM', AsAt));
                    Fuuza."Requested Amount" := Limit;
                    Fuuza."Approved Amount" := Limit;
                    Fuuza.Status := Fuuza.status::Approved;
                    Fuuza.posted := true;
                    Fuuza.insert(true);
                end

            end;

        end;
        exit(Limit);

    end;


    procedure CalcFuuzaInterest(AcctNo: Code[20]; IntDate: Date)
    var
        AvailBal: decimal;

        JTemplate: Code[10];
        JBatch: Code[10];

        TransType: Enum "Transaction Type Enum";
        DocNo: Code[20];
        MActivities: Codeunit "Member Activities";
        PDate: Date;
        PSetup: Record "Product setup";
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        BalAccNo: Code[20];
        SActivity: Codeunit "Sacco Activities";
        TrAmt: Decimal;
        Fuuza: Record Fuliza;
        CheckDate: Date;
        Int: Decimal;
        TotalInt: Decimal;
        Account: Record "Savings Accounts";
        FosaAccount: Record "Savings Accounts";
        Bal: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        ProdFact: Record "Product Setup";
        //SLedger: Record UnknownRecord39004287;
        InterestBuffer: Record "Fuuza Interest Buffer";
        Members: Record Members;
        TDays: Integer;
        SYear: Date;
        EYear: Date;
        SkipEntry: Boolean;
    begin


        TotalInt := 0;
        SkipEntry := false;

        GenSetup.Get;

        Account.Reset;
        if AcctNo <> '' then
            Account.SetRange("No.", AcctNo);
        Account.SetRange("Product Category", Account."Product Category"::"Virtual Account");
        Account.SetFilter("Date Filter", '..%1', IntDate);
        Account.SetFilter("Net Change (LCY)", '<0');
        if Account.FindFirst then begin
            repeat
                FosaAccount.Reset();
                FosaAccount.SetRange("Member No.", Account."Member No.");
                FosaAccount.SetFilter("Date Filter", '..%1', IntDate);
                FosaAccount.SetRange("Product Category", FosaAccount."Product Category"::"Ordinary Savings");
                FosaAccount.SetFilter("Net Change (LCY)", '>0');
                if FosaAccount.FindFirst() then begin
                    FosaAccount.CalcFields("Net Change (LCY)");
                    Account.CalcFields("Net Change (LCY)");
                    TrAmt := Account."Net Change (LCY)" * -1;
                    AvailBal := MActivities.GetAccountBalanceWithoutFuuza(FosaAccount."No.");
                    if (TrAmt > 0) and (AvailBal > 0) then begin
                        if TrAmt > AvailBal then
                            TrAmt := AvailBal;
                        if TrAmt > 0 then begin
                            JTemplate := 'GENERAL';
                            JBatch := 'MBANKING';
                            DocNo := Account."No.";
                            PDate := IntDate;

                            SActivity.InterAccountTransfer(
                                JTemplate,
                                JBatch,
                                DocNo,
                                PDate,
                                Accttype::Savings,
                                FosaAccount."No.",
                                CopyStr('Fuuza Repayment: ', 1, 50),
                                Accttype::Savings,
                                Account."No.",
                                TrAmt,
                                '',
                                '',
                                TransType,
                                FosaAccount."Global Dimension 1 Code",
                                FosaAccount."Global Dimension 2 Code",
                                true);

                        end;
                    end;
                end;
            until Account.next = 0;
        end;
        //Message('Inside');
        Account.Reset;
        if AcctNo <> '' then
            Account.SetRange("No.", AcctNo);
        Account.SetRange("Product Category", Account."Product Category"::"Virtual Account");
        Account.SetFilter("Date Filter", '..%1', IntDate);
        Account.SetFilter("Net Change (LCY)", '<0');
        if Account.FindFirst then begin
            repeat


                DActivity := Account."Global Dimension 1 Code";
                DBranch := Account."Global Dimension 2 Code";
                Int := 0;

                Account.CalcFields("Net Change (LCY)");

                FosaAccount.reset;
                FosaAccount.SetRange("Virtual Account No.", Account."No.");
                if FosaAccount.FindFirst() then begin
                    ProdFact.Get(FosaAccount."Product Type");
                    //ProdFact.TESTFIELD("Over Draft Interest %");
                    Bal := Account."Net Change (LCY)" * -1;
                    Int := ROUND(ProdFact."Fuuza Daily Interest %" / 100 * Bal, 0.01, '>');
                end;
                //Message('Bal %1\Int %2', Bal, Int);

                InterestBuffer.Reset;
                InterestBuffer.SetRange("Account No", Account."No.");
                InterestBuffer.SetRange("Interest Date", IntDate);
                if InterestBuffer.FindFirst then
                    Int := 0;




                if Int > 0 then begin

                    InterestBuffer.Init;
                    InterestBuffer."Account No" := Account."No.";
                    InterestBuffer.Name := Account.Name;
                    InterestBuffer."Account Type" := InterestBuffer."account type"::Savings;
                    InterestBuffer."Bal. Account Type" := InterestBuffer."bal. account type"::"G/L Account";
                    InterestBuffer."Payable Account" := Account."No.";
                    InterestBuffer."Expense Account" := ProdFact."Over Draft Interest Account";
                    InterestBuffer.Blocked := Account.Blocked;
                    InterestBuffer.Description := 'Fuuza Interest';
                    InterestBuffer."Interest Date" := IntDate;
                    InterestBuffer."Interest Rate" := ProdFact."Over Draft Interest %";
                    InterestBuffer."Interest Amount" := Int;
                    InterestBuffer."Account Balance" := Bal * -1;
                    InterestBuffer."Product Setup Code" := Account."Product Type";
                    if Members.Get(Account."Member No.") then begin
                        InterestBuffer."Shortcut Dimension 1 Code" := Account."Global Dimension 1 Code";//SavingsAccounts."Global Dimension 1 Code";
                        InterestBuffer."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";//SavingsAccounts."Global Dimension 2 Code";
                    end;
                    InterestBuffer."User ID" := UserId;
                    if InterestBuffer."Interest Amount" > 0 then begin
                        InterestBuffer.Insert(true);
                        //  MESSAGE('Int %1',TotalInt);
                    end;

                end;

            until Account.next = 0;
        end;
    end;

    procedure CalcFuuzaInterestOnDisbursement(AcctNo: Code[20]; IntDate: Date; Amt: Decimal)
    var
        AvailBal: decimal;

        JTemplate: Code[10];
        JBatch: Code[10];

        TransType: Enum "Transaction Type Enum";
        DocNo: Code[20];
        MActivities: Codeunit "Member Activities";
        PDate: Date;
        PSetup: Record "Product setup";
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        BalAccNo: Code[20];
        SActivity: Codeunit "Sacco Activities";
        TrAmt: Decimal;
        Fuuza: Record Fuliza;
        CheckDate: Date;
        Int: Decimal;
        TotalInt: Decimal;
        Account: Record "Savings Accounts";
        FosaAccount: Record "Savings Accounts";
        Bal: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        ProdFact: Record "Product Setup";
        //SLedger: Record UnknownRecord39004287;
        InterestBuffer: Record "Fuuza Interest Buffer";
        Members: Record Members;
        TDays: Integer;
        SYear: Date;
        EYear: Date;
        SkipEntry: Boolean;
    begin


        TotalInt := 0;
        SkipEntry := false;

        GenSetup.Get;


        Account.Reset;
        Account.SetRange("No.", AcctNo);
        Account.SetRange("Product Category", Account."Product Category"::"Virtual Account");
        if Account.FindFirst then begin
            repeat


                DActivity := Account."Global Dimension 1 Code";
                DBranch := Account."Global Dimension 2 Code";
                Int := 0;


                FosaAccount.reset;
                FosaAccount.SetRange("Virtual Account No.", Account."No.");
                if FosaAccount.FindFirst() then begin
                    ProdFact.Get(FosaAccount."Product Type");
                    //ProdFact.TESTFIELD("Over Draft Interest %");
                    Int := ROUND(ProdFact."Fuuza Daily Interest %" / 100 * Amt, 0.01, '>');
                end;

                if Int > 0 then begin
                    InterestBuffer.Reset;
                    InterestBuffer.SetRange("Account No", Account."No.");
                    InterestBuffer.SetRange("Interest Date", IntDate);
                    if InterestBuffer.FindFirst then begin

                        InterestBuffer."Interest Amount" := Int;
                        InterestBuffer."Account Balance" := Amt * -1;
                        InterestBuffer.Modify;
                    end
                    else begin




                        InterestBuffer.Init;
                        InterestBuffer."Account No" := Account."No.";
                        InterestBuffer.Name := Account.Name;
                        InterestBuffer."Account Type" := InterestBuffer."account type"::Savings;
                        InterestBuffer."Bal. Account Type" := InterestBuffer."bal. account type"::"G/L Account";
                        InterestBuffer."Payable Account" := Account."No.";
                        InterestBuffer."Expense Account" := ProdFact."Over Draft Interest Account";
                        InterestBuffer.Blocked := Account.Blocked;
                        InterestBuffer.Description := 'Fuuza Interest';
                        InterestBuffer."Interest Date" := IntDate;
                        InterestBuffer."Interest Rate" := ProdFact."Over Draft Interest %";
                        InterestBuffer."Interest Amount" += Int;
                        InterestBuffer."Account Balance" += Amt * -1;
                        InterestBuffer."Product Setup Code" := Account."Product Type";
                        if Members.Get(Account."Member No.") then begin
                            InterestBuffer."Shortcut Dimension 1 Code" := Account."Global Dimension 1 Code";//SavingsAccounts."Global Dimension 1 Code";
                            InterestBuffer."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";//SavingsAccounts."Global Dimension 2 Code";
                        end;
                        InterestBuffer."User ID" := UserId;
                        if InterestBuffer."Interest Amount" <> 0 then begin
                            InterestBuffer.Insert(true);
                            //  MESSAGE('Int %1',TotalInt);
                        end;

                    end;
                end;


            until Account.next = 0;
        end;
    end;

    local procedure ClearFuuza()
    var


        Fuuza: Record Fuliza;
    begin

        Fuuza.Reset;
        Fuuza.SetRange(Fuuza.Expired, false);
        Fuuza.setfilter("Expiry Date", '<=%1', Today);
        if Fuuza.Find('-') then begin
            repeat
                if Fuuza."Expiry Date" <= Today then begin
                    Fuuza.Expired := true;
                    Fuuza.Modify;
                end;
            until Fuuza.next = 0;
        end;
    end;


    procedure PostFuuzaInterest(TransDate: Date; AccNo: Code[20])
    var
        InterestBuffer: Record "Fuuza Interest Buffer";
        InterestBuffer2: Record "Fuuza Interest Buffer";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        SavingsACC: Record "Savings Accounts";
        FromDateS: Text[100];
        SLedger: Record "Savings Ledger Entry";
        ToDateS: Text[100];
        PDate: Date;
        DateFilter: Text[100];
        ProductFactory: Record "Product Setup";
        ProductFactoryCode: Code[20];
        InterestRate: Decimal;
        PayableAccount: Code[20];
        IncomeAccount: Code[20];
        BankingUserTemplate: Record "User Setup";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        PageEditable: Boolean;
        Members: Record Members;
        ErrNotApproved: label 'This document has not been approved';
        ErrNoEntries: label 'This Document has no Lines to post';
        MSGEntriesGenerated: label 'Entries Generated Successfully';
        MSGConfirmation: label 'Confirm interest Generation for period starting %1 and Ending %2';
        ErrPosted: label 'This document has already been posted';
        LastDate: Date;
        Dim1: Code[10];
        Dim2: Code[10];
        ODInt: Decimal;
        dWindow: Dialog;

        NoOfRecords: integer;
        CurrentRecordNo: integer;
    begin

        //IF NOT CONFIRM('Do you want to post the journal lines?') = TRUE THEN EXIT;
        PDate := calcdate('-1D', Transdate);

        if PDate <> CalcDate('CM', PDate) then
            exit;

        JTemp := 'GENERAL';
        JBatch := 'MBANKING';

        SavingsACC.Reset;
        if AccNo <> '' then
            SavingsACC.SetRange("No.", AccNo);
        SavingsACC.SetFilter("Virtual Account Interest", '>0');
        if SavingsACC.Find('-') then begin
            dWindow.Open('Finding Interest Accounts:     #1#########\'
                        + 'Total Account:                 #2#########\'
                        + 'Counter:                       #3#########\'
                        + 'Progress:                      @4@@@@@@@@@\'
                        + 'Press Esc to abort');


            NoOfRecords := SavingsACC.Count;
            CurrentRecordNo := 0;
            dWindow.Update(2, NoOfRecords);
            repeat
                dWindow.Update(1, SavingsACC.Name);
                CurrentRecordNo += 1;




                SavingsACC.CalcFields("Virtual Account Interest");
                ODInt := 0;
                InterestBuffer.Reset;
                InterestBuffer.SetRange("Account No", SavingsACC."Virtual Account No.");
                InterestBuffer.SetRange(Posted, false);
                InterestBuffer.SetRange("Interest Date", 0D, CalcDate('CM', PDate));
                if InterestBuffer.FindFirst then begin

                    InterestBuffer.CalcSums("Interest Amount");
                    ODInt := InterestBuffer."Interest Amount";
                    IncomeAccount := InterestBuffer."Expense Account";
                    Dim1 := InterestBuffer."Shortcut Dimension 1 Code";
                    Dim2 := InterestBuffer."Shortcut Dimension 2 Code";
                end;



                if ODInt > 0 then begin

                    LastDate := 0D;
                    IncomeAccount := '';
                    Dim1 := '';
                    Dim2 := '';
                    InterestBuffer.Reset;
                    InterestBuffer.SetRange("Account No", SavingsACC."Virtual Account No.");
                    InterestBuffer.SetRange(Posted, false);
                    InterestBuffer.SetRange("Interest Date", 0D, CalcDate('CM', PDate));
                    if InterestBuffer.FindLast then begin
                        LastDate := InterestBuffer."Interest Date";
                        Dim1 := InterestBuffer."Shortcut Dimension 1 Code";
                        Dim2 := InterestBuffer."Shortcut Dimension 2 Code";
                    end;



                    //IF LastDate < CALCDATE('-CM',TODAY) THEN BEGIN
                    if ODInt > 0 then begin

                        SavingsACC."Test Blocked" := SavingsACC."Test Blocked"::" ";
                        if SavingsACC.Blocked <> SavingsACC.Blocked::" " then begin
                            SavingsACC."Test Blocked" := SavingsACC.Blocked;
                            SavingsACC.Blocked := SavingsACC.Blocked::" ";
                            SavingsACC.Modify;
                        end;


                        //if IncomeAccount = '' then begin
                        ProductFactory.Get(SavingsACC."Product Type");
                        ProductFactory.TestField("Over Draft Interest Account");
                        IncomeAccount := ProductFactory."Over Draft Interest Account";
                        //end;
                        //PDate := LastDate;



                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", JTemp);
                        GenJournalLine.SetRange("Journal Batch Name", JBatch);
                        if GenJournalLine.Find('-') then
                            GenJournalLine.DeleteAll;

                        SLedger.reset;
                        SLedger.setrange("Account No.", SavingsACC."Virtual Account No.");
                        SLedger.setrange("Document No.", 'FUUZA INT.');
                        SLedger.setrange("Posting Date", PDAte);
                        SLedger.setrange(Reversed, False);
                        if not SLedger.findfirst then begin


                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := JTemp;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := SavingsACC."Virtual Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := 'FUUZA INT.';
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine.Description := 'Fuuza Interest - ' + Format(LastDate);
                            GenJournalLine.Amount := ODInt;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := IncomeAccount;
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := Dim1;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := Dim2;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then begin

                                GenJournalLine.Insert;

                                InterestBuffer.Reset;
                                InterestBuffer.SetRange("Account No", SavingsACC."Virtual Account No.");
                                InterestBuffer.SetRange("Interest Date", 0D, CalcDate('CM', PDate));
                                InterestBuffer.SetRange(Posted, false);
                                if InterestBuffer.FindFirst then begin
                                    InterestBuffer.ModifyAll(Posted, true);
                                end;


                                SaccoTrans.JournalPost(JTemp, JBatch);


                            end;
                        end;
                        if SavingsACC."Test Blocked" <> SavingsACC."Test Blocked"::" " then begin
                            SavingsACC.Blocked := SavingsACC."Test Blocked";
                            SavingsACC."Test Blocked" := SavingsACC."Test Blocked"::" ";
                            SavingsACC.Modify;
                        end;
                    end;
                end;


                dWindow.Update(3, CurrentRecordNo);
                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

            until SavingsACC.Next = 0;
            dWindow.Close;
            //MESSAGE('Posted Successfully');

        end;
    end;

    procedure GetUserDimensionSet(): Integer
    var
        DimID: Integer;
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(userid);
        UserSetup.testfield("Dimension Set ID");
        DimID := UserSetup."Dimension Set ID";

        Exit(DimID);
    end;


    procedure SchedulerSms()
    var
        Dispatch: Codeunit SMSDispatcher;
        SkySms: Record "Sky Sms Messages";
    begin
        SkySms.Reset();
        SkySms.SetCurrentKey(date_created);
        SkySms.SetRange(Posted, false);
        if SkySms.FindSet() then begin
            repeat
                Dispatch.SendSMS(SkySms.transaction_id);
            until SkySms.Next() = 0;
        end;
    end;
}

