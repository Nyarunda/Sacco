Codeunit 50118 "Sky Agency Banking"
{
    // // //


    trigger OnRun()
    var
        Pin: Text;
        Members: Record Members;
        SkySMSMessages: Record "Sky SMS Messages";
    begin
        Pin := '3a402c5ed7941c9344a95aff3dc715c964eded95263679959cf8302f170e5e4b';

        //MESSAGE(GetAgentReport('Agent Report',TRUE,'228738',Pin,20210929D,20210929D));
        /*MESSAGE(RegisterVirtualMember('Register Virtual Member',TRUE,'Msangi Manyatta','34497789','254707889421',20190101D,'T0001','T0001',
        '17092021','228738','101 MPK','EMPLOYED','SKYWORLD','NAIROBI',TODAY));*/
        //MESSAGE(GetTransactionLimits('Transactions','WITHDRAWAL'));
        //MESSAGE(ChangeAgentPassword('Change Password',TRUE,'231738','1f0dc549c053c68ffe58cf9e3f8a8ccc4ec47a502a204de9627a2cd29ced9237','1234'));
        //MESSAGE(RegisterVirtualMember('Register Member','Cyprian Msangi','34497789','+254723631593',20020101D,'Ambrose','MEM001','',TRUE));
        //MESSAGE(UpdateVirtualMemberRegistration('Update Virtual Member Registration','MEM001','Path','MEM001','WHY ASK',TRUE));
        ///MESSAGE(AgentLogin('Agent Login',TRUE,'231738','1234','IMEI','SERIAL','DeviceMake','DeviceModel','DeviceProcessorID','SoftwareID','AppVersionCode','AppEnvironment'));
        //PerformAgentTransaction('Agent Transfer',TRUE,'AGENT USERNAME','1234','AGENT DEBIT','DEBIT TYPE','CREDIT ACC','TRANS ID','AMOUNT',
        //'AMOUNT 2',3,'DESCRIPTION','DATE TEXT',TRUE,'IMEI','SERIAL');
        //MESSAGE(AgentTransactions('TR001','TR001',20210101D,TODAY,'3a402c5ed7941c9344a95aff3dc715c964eded95263679959cf8302f170e5e4b','228738','CASH_WITHDRAWAL'));
        //MESSAGE(PerformAgentTransaction('Agent Transfer',TRUE,'231738',Pin,'5120187587000','WITH','5050175187000','TR000103',5000,'Ksh 5000',3,'util to Float','21/09/2021',TRUE,'867250030108685','PP35271908001366'));
        //MESSAGE(AgentMinistatement('TR00W','TR001',3,20210101D,20210101D,'5120187587000','0707889422','3a402c5ed7941c9344a95aff3dc715c964eded95263679959cf8302f170e5e4b','228738'));
        //MESSAGE(FORMAT(PostAgentTransaction('TR0002','VENDOR')));
        //MESSAGE(GetUserLoginAttemptExpiry('Agent Login',TRUE,'228738','ATTEMPTS'));
        //MESSAGE(GetAgentData('Get Agent Data',TRUE,'228738',Pin));

        //MESSAGE(GetAgentAccounts('Get Agent Accounts', TRUE, 'MC0000035', '1234', 'ALL_ACCOUNTS'));

        //MESSAGE(GetCustomerSearchOptions('Get Search Options',TRUE,'231738',Pin));

        //MESSAGE(GetCustomerSearchResult('Search result',TRUE,'252262','',
        //'MEMBER_NUMBER','0135834','WITHDRAWABLE'));

        //MESSAGE(GetCustomerSearchResult('Serch result', TRUE, 'MC0000035', Pin, 'MEMBER_NUMBER', '00005', 'LOANS'));//0079041

        /*--------CASH_WITHDRAWAL TEST--------------*/

        /*MESSAGE(PerformTransaction('Perfom Trans',TRUE,'228738',Pin,'5120187587000','5050123278000','FOSA Savings Account','',
        '','Catherine','0123278','19558','254722368794','CASH_WITHDRAWAL','Withdrawal','TEST00104',50000,'Ksh 50000',
        3,'Money Withdrawal','09/21/2021',TRUE,'IMEI000001','SERIAL0000001'));*/

        /*--------CASH_WITHDRAWAL TEST--------------*/
        /*MESSAGE(PerformTransaction('Perfom Trans',TRUE,'AGNT0001','1234','607AGNT0001','1110015852','RICHARD OKELLO OBONYO','',
        'Deposit Contr','RICHARD OKELLO OBONYO','0015852','7495149','+25472271a7436','CASH_WITHDRAWAL','Cash Withdrawal','TEST00025',132,'Ksh 132',
        4,'Cash Withdrawal','27/7/2021',TRUE,'IMEI000001','SERIAL0000001'));*/

        /*--------CASH_DEPOSIT TEST--------------*/
        /*MESSAGE(PerformTransaction('Perfom Trans',TRUE,'406416','1234','5120209436000','030008652','Murage Maina Murage','loanNumber',
        'CustomerLnNam','Murage Maina Murage','0008652','6420928','+254722451627','CASH_DEPOSIT','Deposit','TEST00002',220,'220',
        3,'Cash Deposit','08/31/2021',TRUE,'IMEI000001','SERIAL0000001'));
        MESSAGE('Done');*/

        /*--------ACCOUNT_BALANCE TEST--------------*/
        /*MESSAGE(PerformTransaction('Perfom Trans',TRUE,'AGNT0001','1234','607AGNT0001','1110015852','RICHARD OKELLO OBONYO','',
        'Deposit Contr','RICHARD OKELLO OBONYO','0015852','7495149','+254722717436','ACCOUNT_BALANCE','Account Balance','TEST00003',0,'0',
        3,'Account Balance','23/7/2021',TRUE,'IMEI000001','SERIAL0000001'));
        MESSAGE('Done');*/

        /*--------LOAN REPAYMENT TEST--------------*/
        /*MESSAGE(PerformTransaction('Perfom Trans',TRUE,'228738','1234','5120209436000','5050063382000','Bett','LN00010162',
        'Jisaidie top Loan','Bett','0063382','0165184','+254714241111','LOAN_PAYMENT','Loan Repayment','TEST00030',5000,'5000',
        3,'Loan Repayment','08/13/2021',TRUE,'IMEI000001','SERIAL0000001'));
        MESSAGE('Done');*/

        /*--------ACCOUNT_STATEMENT TEST--------------*/
        /*MESSAGE(PerformTransaction('Perfom Trans',TRUE,'AGNT0001','1234','607AGNT0001','1110015852','RICHARD OKELLO OBONYO','',
        'Deposit Contr','RICHARD OKELLO OBONYO','0015852','7495149','+254722717436','ACCOUNT_STATEMENT','Account Statement','TEST00014',0,'0',
        4,'Account Statement','23/7/2021',TRUE,'IMEI000001','SERIAL0000001'));
        MESSAGE('Done');*/

        /*-----------------------PERFORM TRANSACTION FUNCTION PARAMETERS-----------------------------------------*/
        /*PerformTransaction(Action : Code[50];Indent : Boolean;AgentUsername : Text;AgentPassword : Text;AgentAccountNumber : Text;
        CustomerAccountNumber : Text;CustomerAccountName : Text;CustomerLoanNumber : Text;CustomerLoanName : Text;CustomerName : Text;
        CustomerMemberNumber : Text;CustomerNationalIDNumber : Text;CustomerMobileNumber : Text;TransactionType : Code[50];
        TransactionName : Text;TransactionSessionID : Text;TransactionAmount : Decimal;TransactionAmountStylized : Text;
        TransactionStatementCount : Integer;TransactionNarration : Text;TransactionDate : Text;
        TransactionPrintReceipt : Boolean;DeviceIMEI : Text;DeviceSerialNumber : Text) Response : Text*/

        /*------------------POST AGENCY-TRANSACTION TEST(Withdrawal)--------------------*/
        //MESSAGE(FORMAT(PostMpesaTransaction('TEST00001')));

        /*------------------POST AGENCY-TRANSACTION TEST(Account statement)--------------------*/
        //MESSAGE(FORMAT(PostMpesaTransaction('A3LLA11')));

        /*------------------POST AGENCY-TRANSACTION TEST(Account Account Balance)--------------------*/
        //MESSAGE(FORMAT(PostMpesaTransaction('TEST00010')));

        /*------------------POST AGENCY-TRANSACTION TEST(Cash Deposit)------------r--------*/
        //MESSAGE(FORMAT(PostMpesaTransaction('TEST00002')));

        /*------------------POST AGENCY-TRANSACTION TEST(Loan Payment)--------------------*/
        //MESSAGE(PostMpesaTransaction('TEST00002'));
        /*GetCustomerSearchResult(Action : Code[50];Indent : Boolean;AgentUsername : Text;AgentPassword : Text;
        CustomerSearchOption : Code[50];CustomerSearchData : Text;Accounttype : Text) Response : Text*/

        //TestFunction();
        //MESSAGE(FORMAT(GetLessAccountBal('5050123278000')));

        Message('DONE');

    end;

    var
        AgentTariffDetails: Record "Agent Tariff Details";
        AgentTariffHeader: Record "Agent Tarriff Header";
        JSonString: Text;
        JObject: JsonObject;
        JsObject_1: JsonObject;
        JsObject_2: JsonObject;
        JsObject_3: JsonObject;
        JsObject_4: JsonObject;
        JsObject_5: JsonObject;
        JsObject_6: JsonObject;
        JsonResult: JsonObject;
        JSON_Array: JsonArray;
        JsArray2: JsonArray;
        JsArray3: JsonArray;
        JsArray4: JsonArray;
        JsArray5: JsonArray;
        ArrayString1: Text;
        JToken: JsonToken;
        TempJObject: JsonObject;

        ArrayString: Text;
        GlobalNULL: Variant;
        TChannel: Enum "Transaction Channel";


    procedure AgentLogin("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text; DeviceIMEI: Text; DeviceSerialNumber: Text; DeviceMake: Text; DeviceModel: Text; DeviceProcessorID: Text; SoftwareID: Text; AppVersionCode: Text; AppEnvironment: Text) Response: Text
    var
        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        SkyAuth: Record "Sky Agency Auth";
        AttemptsCount: Integer;
        Checker: Boolean;
    begin




        /*-------------------------------------------------------------------------------------*/
        /*
        Possible Response Statuses:
        ---------------------------
        SUCCESS
        ERROR
        FAILED
        INCORRECT_PIN
        SUSPENDED
        BLOCKED
        ---------------------------
        */
        Status := 'FAILED';
        ResponseTitle := 'Login Failed';
        ResponseMessage := 'Agent Login Failed';
        Checker := false;
        /*---------------------------------------------LOGIN CODE-------------------------------------*/
        SkyAuth.Reset;
        SkyAuth.SetRange(Username, AgentUsername);
        //AZIZSkyAuth.SetRange(Password, AgentPassword);
        if SkyAuth.FindFirst then begin
            Status := 'FAILED';
            ResponseTitle := 'Login Failed';
            ResponseMessage := 'Agent Login Failed';
            Checker := true;


            DeviceIMEI := SkyAuth."Device IMEI";
            DeviceSerialNumber := SkyAuth."Device Serial Number";
            DeviceProcessorID := SkyAuth."Processor ID";
            SoftwareID := SkyAuth."Software ID";


            SkyAuth."Login Attempts Action" := '';
            SkyAuth."OTP Attempts Action" := '';

            if ((SkyAuth."Login Attempts Action" = 'SUSPEND') or (SkyAuth."OTP Attempts Action" = 'SUSPEND')) then begin
                if Checker then begin
                    if ((SkyAuth."Login Attempts Action" = 'SUSPEND') and (SkyAuth."OTP Attempts Action" <> 'SUSPEND')) then begin
                        if (SkyAuth."Login Attempts Action Expiry" > CurrentDatetime) then begin
                            Status := 'SUSPENDED';
                            ResponseTitle := 'Agent Suspended';
                            ResponseMessage := 'Agent is Suspended';
                            Checker := false;
                        end;
                    end;
                end;

                if Checker then begin
                    if ((SkyAuth."Login Attempts Action" <> 'SUSPEND') and (SkyAuth."OTP Attempts Action" = 'SUSPEND')) then begin
                        if (SkyAuth."OTP Attempts Action Expiry" > CurrentDatetime) then begin
                            Status := 'SUSPENDED';
                            ResponseTitle := 'Agent Suspended';
                            ResponseMessage := 'Agent is Suspended';
                            Checker := false;
                        end;
                    end;
                end;

                if ((SkyAuth."Login Attempts Action" = 'SUSPEND') and (SkyAuth."OTP Attempts Action" = 'SUSPEND')) then begin
                    if (SkyAuth."Login Attempts Action Expiry" > SkyAuth."OTP Attempts Action Expiry") then begin
                        if Checker then begin
                            if (SkyAuth."Login Attempts Action Expiry" > CurrentDatetime) then begin
                                Status := 'FAILED';
                                ResponseTitle := 'Agent Suspended';
                                ResponseMessage := 'Agent is Suspended';
                                Checker := false;
                            end;
                        end;
                    end
                    else begin
                        if Checker then begin
                            if (SkyAuth."OTP Attempts Action Expiry" > CurrentDatetime) then begin
                                Status := 'SUSPENDED';
                                ResponseTitle := 'Agent Suspended';
                                ResponseMessage := 'Agent is Suspended';
                                Checker := false;
                            end;
                        end;
                    end;
                end;
            end;



            if Checker then begin
                if (SkyAuth.Status = SkyAuth.Status::Inactive) or (SkyAuth.Status = SkyAuth.Status::" ") then begin
                    Status := 'BLOCKED';
                    ResponseTitle := 'Agent Blocked';
                    ResponseMessage := 'Agent is Blocked';
                    Checker := false;
                end;
            end;

            if Checker then begin
                //AZIZif (SkyAuth.Password = AgentPassword) then 
                begin
                    Status := 'SUCCESS';
                    ResponseTitle := 'Login Success';
                    ResponseMessage := 'Agent Login Success';
                    Checker := true;
                    if (SkyAuth."Software Activated" = false) then begin
                        Status := 'SOFTWARE_INACTIVE';
                        ResponseTitle := 'Login Failed Software Not Activated';
                        ResponseMessage := 'Software Is Not Activated';
                        Checker := false;
                    end;
                    if (SkyAuth."Device IMEI" <> DeviceIMEI) then begin
                        Status := 'INVALID_IMEI';
                        ResponseTitle := 'Invalid Device IMEI';
                        ResponseMessage := 'Invalid  Device IMEI';
                        Checker := false;
                    end;
                    if (SkyAuth."Device Serial Number" <> DeviceSerialNumber) then begin
                        Status := 'INVALID_SERIAL_NUMBER';
                        ResponseTitle := 'Filed Invalid Serial Number';
                        ResponseMessage := 'Invalid Serial Number';
                        Checker := false;
                    end;
                    /*IF (SkyAuth."Software ID"<> SoftwareID)  THEN BEGIN
                        Status := 'INVALID_SOFTWARE_ID';
                        ResponseTitle:= 'Invalid Software ID';
                        ResponseMessage:= 'Invalid Sofware ID';
                        Checker := FALSE;
                    END;*/
                    /*IF (SkyAuth."Processor ID"<> DeviceProcessorID)  THEN BEGIN
                        Status := 'INVALID_PROCESSOR_ID';
                        ResponseTitle:= 'Invalid Device Pocessor ID';
                        ResponseMessage:= 'Invalid Device Processor ID';
                        Checker := FALSE;
                    END;*/
                end;
            end;
        end
        else begin
            if SkyAuth.Get(AgentUsername) then begin
                Status := 'INCORRECT_PASSWORD';
                ResponseTitle := 'Wrong Username or Password';
                ResponseMessage := 'Wrong Username or Password';
                Checker := false;
            end else begin
                Status := 'INCORRECT_PASSWORD';
                ResponseTitle := 'Wrong Username or Password';
                ResponseMessage := 'Wrong Username or Password';
                Checker := false;
            end;
        end;


        if Checker then begin
            SkyAuth."Login Attempts Action" := 'NONE';
            SkyAuth."Login Attempts Tag" := '';
            Clear(SkyAuth."Login Attempts Action Expiry");
            SkyAuth."Login Attempts Count" := 0;
            SkyAuth.Modify;
        end;

        if (ResponseTitle = 'INCORRECT_PIN') then begin
            if SkyAuth.Get(AgentUsername) then begin
                SkyAuth."Login Attempts Count" := SkyAuth."Login Attempts Count" + 1;
                SkyAuth.Modify;
                AttemptsCount := SkyAuth."Login Attempts Count";
            end;
        end;
        /*---------------------------------------------LOGIN CODE-------------------------------------*/





        JsObject_1.Add('title', ResponseTitle);
        JsObject_1.Add('message', ResponseMessage);

        JsObject_2.Add('action', 'AGENT_LOGIN');
        JsObject_2.Add('status', Status);
        JsObject_2.Add('payload', JsObject_1);

        JsonResult.Add('response', JsObject_2);

        JsonResult.WriteTo(Response);





        /*-------------------------------------------------------------------------------------*/

    end;


    procedure ChangeAgentPassword("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentOldPassword: Text; AgentNewPassword: Text) Response: Text
    var



        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        SkyAgencyAuth: Record "Sky Agency Auth";
        AgentApplications: Record "Agent Applications";
    begin




        /*-------------------------------------------------------------------------------------*/
        Status := 'SUCCESS';
        /*
        Possible Response Statuses:
        ---------------------------
        SUCCESS
        ERROR
        FAILED
        NOT_FOUND
        ---------------------------
        */
        ResponseTitle := 'Change Password';
        ResponseMessage := 'Password changed Failed';
        /*-------------------------------------------------------------------------------------*/

        if AgentApplications.Get(AgentUsername) then begin
            ResponseMessage := 'Agent Found';
            Status := 'SUCCESS';
        end else begin
            ResponseMessage := 'Agent not found';
            Status := 'FAILED';
        end;



        if Status = 'SUCCESS' then begin
            SkyAgencyAuth.Reset;
            SkyAgencyAuth.SetRange("Agent Code", AgentUsername);
            SkyAgencyAuth.SetRange(Password, AgentOldPassword);
            if SkyAgencyAuth.FindFirst then begin
                SkyAgencyAuth.Password := AgentNewPassword;
                SkyAgencyAuth.Modify;
                ResponseMessage := 'Password changed Successfully';
                Status := 'SUCCESS';
            end else begin
                ResponseMessage := 'Password changed Failed';
                Status := 'FAILED';
            end;
        end;






        JsObject_1.Add('title', ResponseTitle);
        JsObject_1.Add('message', ResponseMessage);

        JsObject_2.Add('action', 'CHANGE_AGENT_PASSWORD');
        JsObject_2.Add('status', Status);
        JsObject_2.Add('payload', JsObject_1);

        JsonResult.Add('response', JsObject_2);

        JsonResult.WriteTo(Response);










        /*-------------------------------------------------------------------------------------*/


    end;


    procedure GetAgentData("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text) Response: Text
    var



        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        Iterator: Integer;
        AgentApplication: Record "Agent Applications";
        AgentCode: Code[30];
        SkyAgencies: Record "Sky Agency Companies";
        AgencyCode: Code[30];
        SavingsAccounts: Record "Savings Accounts";
        MemberNo: Code[30];
        TotalBalances: Decimal;
        CurrencyCode: Code[30];
        SkyAgencyAuth: Record "Sky Agency Auth";
        SkyAgentsTransactions: Record "Sky Agents Transactions";
        TotalDeposits: Decimal;
        TotalWithdrawals: Decimal;
        CommisionsToday: Decimal;
        CommisionsThisMonth: Decimal;
        Vendor: Record "Savings Accounts";
        VendorLedgerEntry: Record "Savings Ledger Entry";
        VendorCommisions: Decimal;
        VendorCommsMonth: Decimal;
        DetailedVendor: Record "Savings Ledger Entry";
        JSAgency: JsonObject;
        JSAccounts: JsonObject;
        JSData: JsonObject;
        JsStatisticsArray: JsonArray;
    begin




        /*-------------------------------------------------------------------------------------*/
        Status := 'SUCCESS';
        /*
        Possible Response Statuses:
        ---------------------------
        SUCCESS
        ERROR
        FAILED
        NOT_FOUND
        ---------------------------
        */
        ResponseTitle := 'Agent Data';
        ResponseMessage := 'Agent Data Fetched Successfully';
        /*-------------------------------------------------------------------------------------*/
        //AgentCode := '';
        MemberNo := '';



        if AgentApplication.Get(AgentUsername) then begin
            Status := 'SUCCESS';
        end else begin
            Status := 'NOT_FOUND';
            ResponseMessage := 'Agent Not found';
        end;

        if Status = 'SUCCESS' then begin
            if AgentApplication.Get(AgentUsername) then begin

                //LocalJsonTextWriter.WritePropertyName('data');
                JsObject_1.Add('name', AgentApplication."Name of the Proposed Agent");
                JsObject_1.Add('location', AgentApplication."Place of Business");
                JsObject_1.Add('id', AgentApplication."Agent Code");
                JSAgency.Add('agency', JsObject_1);

                //                
                Clear(JsObject_1);
                JsObject_1.Add('name', AgentApplication."Name");
                JsObject_1.Add('username', AgentUsername);
                JsObject_1.Add('role', Format(AgentApplication.Role));
                JsObject_1.Add('mobile_number', AgentApplication."Mobile No");
                JSAgency.Add('user', JsObject_1);


            end else begin
                ResponseMessage := 'Agent not found';
                Status := 'FAILED';
            end;
        end;

        if Status = 'SUCCESS' then begin
            SavingsAccounts.Reset;
            SavingsAccounts.SetCurrentkey("Product Type");
            SavingsAccounts.SetAscending("Product Type", true);
            SavingsAccounts.SetRange("ID No.", AgentApplication."Customer ID No");
            SavingsAccounts.SetFilter("Product Category", '%1|%2', SavingsAccounts."Product Category"::"Agent Commission", SavingsAccounts."Product Category"::"Agent Float");
            if SavingsAccounts.FindFirst then begin
                repeat
                    SavingsAccounts.CalcFields("Balance (LCY)");

                    Clear(JsObject_2);
                    JsObject_2.Add('book_balance', Format(SavingsAccounts."Balance (LCY)"));
                    JsObject_2.Add('available_balance', Format(GetAccountBalance(SavingsAccounts."No.")));


                    Clear(JsObject_3);
                    JsObject_3.Add('code', 'KES');
                    JsObject_3.Add('symbol', 'KES');


                    Clear(JsObject_1);
                    JsObject_1.Add('name', SavingsAccounts."Product Name");
                    JsObject_1.Add('number', SavingsAccounts."No.");
                    JsObject_1.Add('balances', JsObject_2);
                    JsObject_1.Add('currency', JsObject_3);

                    JsArray2.Add(JsObject_1);
                until SavingsAccounts.Next = 0;

                //JSAccounts.Add('accounts', JsArray2);
                JSAgency.Add('accounts', JsArray2);

            end else begin
                ResponseMessage := 'Agent accounts not found';
            end;
        end;

        if Status = 'SUCCESS' then begin


            SavingsAccounts.Reset;
            SavingsAccounts.SetRange("No.", AgentApplication.Account);
            SavingsAccounts.SetRange("Product Type", '512');
            //SavingsAccounts.SETFILTER("Date Filter",FORMAT(CALCDATE('-CM',TODAY))+'..'+FORMAT(CALCDATE('CM',TODAY)));
            if SavingsAccounts.FindFirst then begin
                SavingsAccounts.CalcFields("Balance (LCY)");

                Clear(JsObject_1);
                JsObject_1.Add('title', 'Float Wallet Balance');
                JsObject_1.Add('value', Format(SavingsAccounts."Balance (LCY)"));
                JsObject_1.Add('type', 'CURRENCY');
                JsStatisticsArray.Add(JsObject_1);
            end;

            SkyAgentsTransactions.Reset;
            SkyAgentsTransactions.SetRange("Agent Code", AgentApplication."Agent Code");
            SkyAgentsTransactions.SetRange(Posted, true);
            SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::Deposit);
            SkyAgentsTransactions.SetRange("Transaction Date", Today);
            if SkyAgentsTransactions.FindFirst then begin
                SkyAgentsTransactions.CalcSums(Amount);
                TotalDeposits := SkyAgentsTransactions.Amount;

                Clear(JsObject_1);
                JsObject_1.Add('title', 'Total deposits Today');
                JsObject_1.Add('value', Format(TotalDeposits));
                JsObject_1.Add('type', 'CURRENCY');
                JsStatisticsArray.Add(JsObject_1);

            end;

            SkyAgentsTransactions.Reset;
            SkyAgentsTransactions.SetRange("Agent Code", AgentApplication."Agent Code");
            SkyAgentsTransactions.SetRange(Posted, true);
            SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::Withdrawal);
            SkyAgentsTransactions.SetRange("Transaction Date", Today);
            if SkyAgentsTransactions.FindFirst then begin
                SkyAgentsTransactions.CalcSums(Amount);


                Clear(JsObject_1);
                JsObject_1.Add('title', 'Total Withdrawals Today');
                JsObject_1.Add('value', Format(SkyAgentsTransactions.Amount));
                JsObject_1.Add('type', 'CURRENCY');
                JsStatisticsArray.Add(JsObject_1);

            end;

            VendorCommisions := 0;
            Vendor.Reset;
            Vendor.SetRange("No.", AgentApplication."Comm Account");
            if Vendor.FindFirst then begin
                DetailedVendor.Reset;
                DetailedVendor.SetRange("Account No.", Vendor."No.");
                DetailedVendor.SetRange("Posting Date", Today);
                if DetailedVendor.FindFirst then begin
                    repeat
                        VendorCommisions += DetailedVendor.Amount;
                    until DetailedVendor.Next = 0;
                end;

                Clear(JsObject_1);
                JsObject_1.Add('title', 'Total Commissions Today');
                JsObject_1.Add('value', Format(VendorCommisions));
                JsObject_1.Add('type', 'CURRENCY');
                JsStatisticsArray.Add(JsObject_1);
            end;


            VendorCommsMonth := 0;
            Vendor.Reset;
            Vendor.SetRange("No.", AgentApplication."Comm Account");
            if Vendor.FindFirst then begin
                DetailedVendor.Reset;
                DetailedVendor.SetRange("Account No.", Vendor."No.");
                DetailedVendor.SetRange("Posting Date", CalcDate('-CM', Today), CalcDate('+CM', Today));
                if DetailedVendor.FindFirst then begin
                    repeat
                        VendorCommsMonth += DetailedVendor.Amount;
                    until DetailedVendor.Next = 0;
                end;

                Clear(JsObject_1);
                JsObject_1.Add('title', 'Total Commissions this Month');
                JsObject_1.Add('value', Format(VendorCommsMonth));
                JsObject_1.Add('type', 'CURRENCY');
                JsStatisticsArray.Add(JsObject_1);

            end;
            JSAgency.Add('statistics', JsStatisticsArray);

        end;


        JsObject_4.Add('title', ResponseTitle);
        JsObject_4.Add('message', ResponseMessage);
        JsObject_4.Add('data', JSAgency);

        JsObject_2.Add('action', 'GET_AGENT_DETAILS');
        JsObject_2.Add('status', Status);
        JsObject_2.Add('payload', JsObject_4);

        JsonResult.Add('response', JsObject_2);

        JsonResult.WriteTo(Response);

        /*-------------------------------------------------------------------------------------*/


    end;


    procedure GetAgentAccounts("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text; AccountType: Code[50]) Response: Text
    var



        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        Iterator: Integer;
        SkyAgencyAuth: Record "Sky Agency Auth";
        AgentCode: Code[30];
        SavingsAccounts: Record "Savings Accounts";
        AgentApplication: Record "Agent Applications";
        ProductFactory: Record "Product Setup";
        Vendor: Record "Savings Accounts";
        JSAccounts: JsonObject;
        JSTransferArray: JsonArray;
        JStransaction_limitsArray: JsonArray;
    begin
        /*
        Possible Account Types:
        ---------------------------
        WITHDRAWABLE - Available during customer cash withdrawal
        DEPOSITABLE - Available during customer cash deposit
        ALL - Allagent accounts plus FOSA & BOSA
        TRANSFERRABLE_FROM - Available during agent float top up
        TRANSFERRABLE_TO - Available during agent float top up
        ---------------------------
        */




        /*-------------------------------------------------------------------------------------*/
        Status := 'SUCCESS';
        /*
        Possible Response Statuses:
        ---------------------------
        SUCCESS
        ERROR
        FAILED
        NOT_FOUND
        ---------------------------
        */
        ResponseTitle := 'Agent Accounts';
        ResponseMessage := 'Agent Accounts Fetched Successfully';
        /*-------------------------------------------------------------------------------------*/

        if AgentApplication.Get(AgentUsername) then begin
            ResponseMessage := 'Agent Found';
            Status := 'SUCCESS';
            //AgentCode := SkyAgencyAuth."Agent Code";
        end else begin
            ResponseMessage := 'Agent not found';
            Status := 'FAILED';
        end;



        //LocalJsonTextWriter.WritePropertyName('data');

        if Status = 'SUCCESS' then begin
            AgentApplication.Get(AgentUsername);
            ProductFactory.Reset;
            ProductFactory.SetFilter("Product Category", '%1|%2', ProductFactory."product category"::"Agent Float", ProductFactory."product category"::"Agent Commission");
            if ProductFactory.FindFirst then begin
                repeat

                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("Product Type", ProductFactory."Product ID");
                    SavingsAccounts.SetFilter("ID No.", AgentApplication."Customer ID No");
                    if SavingsAccounts.FindFirst then begin
                        repeat
                            SavingsAccounts.CalcFields("Balance (LCY)");


                            Clear(JsObject_2);
                            JsObject_2.Add('book_balance', Format(SavingsAccounts."Balance (LCY)"));
                            JsObject_2.Add('available_balance', Format(GetAccountBalance(SavingsAccounts."No.")));


                            Clear(JsObject_3);
                            JsObject_3.Add('code', 'KES');
                            JsObject_3.Add('symbol', 'KES');


                            Clear(JsObject_1);
                            JsObject_1.Add('name', SavingsAccounts."Product Name");
                            JsObject_1.Add('number', SavingsAccounts."No.");
                            JsObject_1.Add('balances', JsObject_2);
                            JsObject_1.Add('currency', JsObject_3);

                            JsArray2.Add(JsObject_1);
                        until SavingsAccounts.Next = 0;

                    end;

                until ProductFactory.Next = 0;

                JSAccounts.Add('accounts', JsArray2);
            end;


        end;

        /*---------------------------AGENT FOSA ACCOUNT---------------*/

        AgentApplication.Get(AgentUsername);
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("ID No.", AgentApplication."Customer ID No");
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Ordinary Savings");
        if SavingsAccounts.FindFirst then begin
            SavingsAccounts.CalcFields("Balance (LCY)");


            Clear(JsObject_2);
            JsObject_2.Add('book_balance', Format(SavingsAccounts."Balance (LCY)"));
            JsObject_2.Add('available_balance', Format(GetAccountBalance(SavingsAccounts."No.")));


            Clear(JsObject_3);
            JsObject_3.Add('code', 'KES');
            JsObject_3.Add('symbol', 'KES');


            Clear(JsObject_1);
            JsObject_1.Add('name', SavingsAccounts."Product Name");
            JsObject_1.Add('allowed_transactions', 'WITHDRAWABLE|DEPOSITABLE');
            JsObject_1.Add('number', SavingsAccounts."No.");
            JsObject_1.Add('balances', JsObject_2);
            JsObject_1.Add('currency', JsObject_3);


            JSTransferArray.Add(JsObject_1);




        end;
        /*---------------------------AGENT COMMISION ACCOUNT---------------*/

        /*---------------------------AGENT FLOAT ACCOUNT---------------*/
        AgentApplication.Get(AgentUsername);
        SavingsAccounts.Get(AgentApplication.Account);
        SavingsAccounts.CalcFields("Balance (LCY)");

        Clear(JsObject_2);
        JsObject_2.Add('book_balance', Format(SavingsAccounts."Balance (LCY)"));
        JsObject_2.Add('available_balance', Format(GetAccountBalance(SavingsAccounts."No.")));

        Clear(JsObject_3);
        JsObject_3.Add('code', 'KES');
        JsObject_3.Add('symbol', 'KES');

        Clear(JsObject_1);
        JsObject_1.Add('name', ProductFactory.Description);
        JsObject_1.Add('allowed_transactions', 'WITHDRAWABLE|DEPOSITABLE');
        JsObject_1.Add('number', AgentApplication.Account);
        JsObject_1.Add('balances', JsObject_2);
        JsObject_1.Add('currency', JsObject_3);
        JSTransferArray.Add(JsObject_1);
        /*---------------------------AGENT FLOAT ACCOUNT---------------*/

        /*---------------------------AGENT COMMISION ACCOUNT---------------*/
        AgentApplication.Get(AgentUsername);
        Vendor.Get(AgentApplication."Comm Account");
        Vendor.CalcFields("Balance (LCY)");



        Clear(JsObject_2);
        JsObject_2.Add('book_balance', Format(SavingsAccounts."Balance (LCY)"));
        JsObject_2.Add('available_balance', Format(GetAccountBalance(SavingsAccounts."No.")));


        Clear(JsObject_3);
        JsObject_3.Add('code', 'KES');
        JsObject_3.Add('symbol', 'KES');



        if AgentApplication."Withdrawal Limit Amount" = 0 then
            AgentApplication."Withdrawal Limit Amount" := 10000;

        Clear(JsObject_1);
        JsObject_1.Add('minimum_amount', AgentApplication."Withdrawal Limit Amount");
        JsObject_1.Add('maximum_amount', AgentApplication."Withdrawal Limit Amount");
        JStransaction_limitsArray.Add(JsObject_1);






        Clear(JsObject_1);
        JsObject_1.Add('name', 'Commission Account');
        JsObject_1.Add('allowed_transactions', 'WITHDRAWABLE');
        JsObject_1.Add('number', AgentApplication."Comm Account");
        JsObject_1.Add('balances', JsObject_2);
        JsObject_1.Add('currency', JsObject_3);
        JSTransferArray.Add(JsObject_1);

        JSAccounts.Add('transfer', JSTransferArray);
        JSAccounts.Add('transaction_limits', JStransaction_limitsArray);


        JsObject_4.Add('title', ResponseTitle);
        JsObject_4.Add('message', ResponseMessage);
        JsObject_4.Add('data', JSAccounts);

        JsObject_5.Add('action', 'GET_AGENT_ACCOUNTS');
        JsObject_5.Add('status', Status);
        JsObject_5.Add('payload', JsObject_4);

        JsonResult.Add('response', JsObject_5);

        JsonResult.WriteTo(Response);

    end;


    procedure GetCustomerSearchOptions("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text) Response: Text
    var

        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        Iterator: Integer;
        SkyAgencyAuth: Record "Sky Agency Auth";
        AgentCode: Code[30];
        SkySearchOptions: Record "Sky Search Options";
        AgentApplications: Record "Agent Applications";
    begin




        /*-------------------------------------------------------------------------------------*/
        Status := 'SUCCESS';
        /*
        Possible Response Statuses:
        ---------------------------
        SUCCESS
        ERROR
        FAILED
        NOT_FOUND
        ---------------------------
        */
        ResponseTitle := 'Customer Search Options';
        ResponseMessage := 'Customer Search Options Fetched Successfully';
        /*-------------------------------------------------------------------------------------*/

        if AgentApplications.Get(AgentUsername) then begin
            ResponseMessage := 'Agent Found';
            Status := 'SUCCESS';
        end else begin
            ResponseMessage := 'Agent not found';
            Status := 'FAILED';
        end;


        if Status = 'SUCCESS' then begin
            SkySearchOptions.Reset;
            if SkySearchOptions.FindFirst then begin
                repeat

                    Clear(JsObject_1);
                    JsObject_1.Add('id', SkySearchOptions.ID);
                    JsObject_1.Add('caption', SkySearchOptions.Caption);
                    JsArray2.Add(JsObject_1);
                until SkySearchOptions.Next = 0;
                JsObject_2.Add('options', JsArray2);

            end else begin
                ResponseMessage := 'Search Options not found';
            end;
        end;

        JsObject_4.Add('title', ResponseTitle);
        JsObject_4.Add('message', ResponseMessage);
        JsObject_4.Add('data', JsObject_2);

        JsObject_5.Add('action', 'CUSTOMER_SEARCH_OPTIONS');
        JsObject_5.Add('status', Status);
        JsObject_5.Add('payload', JsObject_4);

        JsonResult.Add('response', JsObject_5);

        JsonResult.WriteTo(Response);

        /*-------------------------------------------------------------------------------------*/


    end;


    procedure GetCustomerSearchResult("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text; CustomerSearchOption: Code[50]; CustomerSearchData: Text; Accounttype: Text) Response: Text
    var



        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        Iterator: Integer;
        SkyAgencyAuth: Record "Sky Agency Auth";
        AgentCode: Code[30];
        SkySearchOptions: Record "Sky Search Options";
        Members: Record Members;
        AgentApplication: Record "Agent Applications";
        SavingsAccounts: Record "Savings Accounts";
        MemberNo: Code[30];
        ProductFactory: Record "Product Setup";
        Loans: Record Loans;
        OutstandingBalance: Decimal;
        OutstandingInterest: Decimal;
        CountSavings: Integer;
        FoundLoan: Boolean;
        JsAccountsArray: JsonArray;
    begin
        /*
        
        Possible Account Types:
        ---------------------------
        WITHDRAWABLE - Available during customer cash withdrawal
        DEPOSITABLE - Available during customer cash deposit
        // // ALL - Allagent accounts plus FOSA & BOSA
        TRANSFERRABLE_FROM - Available during agent float top up
        TRANSFERRABLE_TO - Available during agent float top up
        ---------------------------
        */




        /*-------------------------------------------------------------------------------------*/
        Status := 'SUCCESS';
        /*
        Possible Response Statuses:
        ---------------------------
        SUCCESS
        ERROR
        FAILED
        NOT_FOUND
        ---------------------------
        */


        ResponseTitle := 'Search Customer Data';
        ResponseMessage := 'Customer Data Searched Successfully';
        /*-------------------------------------------------------------------------------------*/


        if AgentApplication.Get(AgentUsername) then begin
            ResponseMessage := 'Agent Found';
            Status := 'SUCCESS';
            AgentCode := AgentApplication."Agent Code";
        end else begin
            ResponseMessage := 'Incorrect Username or Password';
            Status := 'FAILED';
        end;

        if Status = 'SUCCESS' then begin
            Members.Reset;
            if CustomerSearchOption = 'MOBILE_NUMBER' then
                Members.SetRange("Mobile Phone No.", '+' + CustomerSearchData)
            else
                if (CustomerSearchOption = 'NATIONAL_ID_NUMBER') or (CustomerSearchOption = 'SERVICE_NUMBER') then
                    Members.SetRange("ID No.", CustomerSearchData)// 99428
                else
                    if CustomerSearchOption = 'PASSPORT_NUMBER' then
                        Members.SetRange("Passport", CustomerSearchData)
                    else
                        if CustomerSearchOption = 'MEMBER_NUMBER' then
                            Members.SetRange("No.", CustomerSearchData);//0204111
            if Members.FindFirst then begin


                //


                //LocalJsonTextWriter.WritePropertyName('data');

                MemberNo := Members."No.";

                //LocalJsonTextWriter.WritePropertyName('customer');




                Clear(JsObject_1);
                JsObject_1.Add('title', 'Name');
                JsObject_1.Add('value', Members.Name);
                JsObject_1.Add('mask', false);
                JsObject_1.Add('mask_regex', '');
                JsArray2.Add(JsObject_1);

                Clear(JsObject_1);
                JsObject_1.Add('title', 'Mobile Number');
                JsObject_1.Add('value', Members."Mobile Phone No.");
                JsObject_1.Add('mask', true);
                JsObject_1.Add('mask_regex', '<![CDATA[(?<!^.?).(?!.?$)]]>');
                JsArray2.Add(JsObject_1);

                Clear(JsObject_1);
                JsObject_1.Add('title', 'Member Number');
                JsObject_1.Add('value', Members."No.");
                JsObject_1.Add('mask', true);
                JsObject_1.Add('mask_regex', '<![CDATA[(?<!^.?).(?!.?$)]]>');
                JsArray2.Add(JsObject_1);

                Clear(JsObject_1);
                JsObject_1.Add('title', 'National ID Number');
                JsObject_1.Add('value', Members."ID No.");
                JsObject_1.Add('mask', true);
                JsObject_1.Add('mask_regex', '<![CDATA[(?<!^.?).(?!.?$)]]>');
                JsArray2.Add(JsObject_1);



                Clear(JsObject_2);
                JsObject_2.Add('name', Members.Name);
                JsObject_2.Add('mobile_number', Members."Mobile Phone No.");
                JsObject_2.Add('id_number', Members."ID No.");
                JsObject_2.Add('member_number', Members."No.");

                JsObject_2.Add('display', JsArray2);





                Clear(JsAccountsArray);
                CountSavings := 0;
                ProductFactory.Reset;
                if Accounttype = 'CASH_DEPOSIT' then
                    ProductFactory.SetFilter("Allowed Transaction", '%1|%2', ProductFactory."allowed transaction"::"Deposits Only", ProductFactory."allowed transaction"::"Deposits & Withdrawals")
                else
                    if Accounttype = 'WITHDRAWABLE' then
                        ProductFactory.SetRange("Allowed Transaction", ProductFactory."allowed transaction"::"Deposits & Withdrawals")
                    else
                        if Accounttype = 'ALL_ACCOUNTS' then
                            ProductFactory.SetFilter("Allowed Transaction", '%1|%2', ProductFactory."allowed transaction"::"Deposits Only", ProductFactory."allowed transaction"::"Deposits & Withdrawals")
                        else
                            if Accounttype = 'ACCOUNT_BALANCE' then
                                ProductFactory.SetFilter("Product Category", '<>%1', ProductFactory."Product Category"::"Registration Fee")
                            else
                                if Accounttype = 'LOAN' then
                                    ProductFactory.SetRange("Product ID", 'XXXXXX');
                if ProductFactory.FindFirst then begin
                    repeat
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange("Member No.", Members."No.");
                        SavingsAccounts.SetRange("Product Type", ProductFactory."Product ID");
                        if (Accounttype = 'CASH_DEPOSIT') or (Accounttype = 'ALL_ACCOUNTS') or (Accounttype = 'WITHDRAWABLE') then
                            SavingsAccounts.SetFilter(Status, '%1', SavingsAccounts.Status::Active);
                        if SavingsAccounts.FindFirst then begin
                            repeat
                                CountSavings += 1;
                                SavingsAccounts.CalcFields("Balance (LCY)");



                                Clear(JsObject_1);
                                JsObject_1.Add('book_balance', SavingsAccounts."Balance (LCY)");
                                JsObject_1.Add('available_balance', GetAccountBalance(SavingsAccounts."No."));


                                Clear(JsObject_3);
                                JsObject_3.Add('code', 'KES');
                                JsObject_3.Add('symbol', 'KES');


                                Clear(JsObject_4);
                                JsObject_4.Add('name', SavingsAccounts."Product Name");
                                JsObject_4.Add('allowed_transactions', 'WITHDRAWABLE');
                                JsObject_4.Add('number', SavingsAccounts."No.");
                                JsObject_4.Add('balances', JsObject_1);
                                JsObject_4.Add('currency', JsObject_3);

                                JsAccountsArray.Add(JsObject_4);


                            until SavingsAccounts.Next = 0;
                        end;
                    until ProductFactory.Next = 0;
                end;

                JsObject_2.Add('accounts', JsAccountsArray);

                if (Accounttype <> 'LOAN') and (CountSavings = 0) then begin
                    Status := 'FAILED';
                    ResponseMessage := 'You do not have have any active account';
                end;
                //LocalJsonTextWriter.WritePropertyName('loans');
                //LocalJsonTextWriter.WriteStartArray;
                Clear(JsAccountsArray);
                FoundLoan := false;
                ProductFactory.Reset;
                if Accounttype = 'LOAN' then
                    ProductFactory.SetRange("Product Class", ProductFactory."product class"::Credit);
                if ProductFactory.FindFirst then begin
                    repeat
                        Loans.Reset;
                        Loans.SetRange("Member No.", Members."No.");
                        Loans.SetRange("Loan Product Type", ProductFactory."Product ID");
                        Loans.SetFilter("Outstanding Principal", '>%1', 0);
                        if Loans.FindFirst then begin
                            repeat
                                FoundLoan := true;
                                Loans.CalcFields("Outstanding Interest", "Outstanding Principal", "Total Arrears");
                                OutstandingBalance := Loans."Outstanding Principal";
                                OutstandingInterest := Loans."Outstanding Interest";
                                if OutstandingBalance < 0 then OutstandingBalance := 0;
                                if OutstandingInterest < 0 then OutstandingInterest := 0;



                                if (Loans."Outstanding Principal" + Loans."Outstanding Interest") > 0 then begin


                                    Clear(JsObject_1);
                                    JsObject_1.Add('outstanding_balance', OutstandingBalance);
                                    JsObject_1.Add('outstanding_interest', OutstandingInterest);
                                    JsObject_1.Add('arrears', Loans."Total Arrears");

                                    Clear(JsObject_3);
                                    JsObject_3.Add('code', 'KES');
                                    JsObject_3.Add('symbol', 'KES');


                                    Clear(JsObject_4);
                                    JsObject_4.Add('name', Loans."Loan Product Type Name");
                                    JsObject_4.Add('number', Loans."Loan No.");
                                    JsObject_4.Add('balances', JsObject_1);
                                    JsObject_4.Add('currency', JsObject_3);

                                    JsAccountsArray.Add(JsObject_4);


                                end;
                            until Loans.Next = 0;


                        end;
                    until ProductFactory.Next = 0;
                    JsObject_2.Add('loans', JsAccountsArray);

                    if (FoundLoan = false) and (Accounttype = 'LOAN') then begin
                        Status := 'FAILED';
                        ResponseMessage := 'You do not have have any active loan.';
                    end;
                end;
                //
            end else begin
                if Status = 'SUCCESS' then begin
                    Status := 'FAILED';
                    ResponseMessage := 'The system could not find a customer with the information you provided. Please check and try again.';
                end;
            end;
        end;


        Clear(JsObject_4);
        Clear(JsObject_1);
        JsObject_1.Add('customer', JsObject_2);

        JsObject_4.Add('title', ResponseTitle);
        JsObject_4.Add('message', ResponseMessage);
        JsObject_4.Add('data', JsObject_1);

        JsObject_5.Add('action', 'SEARCH_CUSTOMER_DATA');
        JsObject_5.Add('status', Status);
        JsObject_5.Add('payload', JsObject_4);

        JsonResult.Add('response', JsObject_5);

        JsonResult.WriteTo(Response);





        /*-------------------------------------------------------------------------------------*/


    end;


    procedure PerformTransaction("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text; AgentAccountNumber: Text; CustomerAccountNumber: Text; CustomerAccountName: Text; CustomerLoanNumber: Text; CustomerLoanName: Text; CustomerName: Text; CustomerMemberNumber: Text; CustomerNationalIDNumber: Text; CustomerMobileNumber: Text; TransactionType: Code[50]; TransactionName: Text; TransactionSessionID: Text; TransactionAmount: Decimal; TransactionAmountStylized: Text; TransactionStatementCount: Integer; TransactionNarration: Text; TransactionDate: Text; TransactionPrintReceipt: Boolean; DeviceIMEI: Text; DeviceSerialNumber: Text) Response: Text
    var



        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        PrintData: Text;
        DisplayData: Text;
        SMSData: Text;
        hr: label '<hr/>';
        br: label '<br/>';
        logo: label '<logo/>';
        cdata_open: label '<![CDATA[';
        cdata_close: label ']]>';
        TransactionAccountText: Text;
        TransactionText: Text;
        StatementText: Text;
        Iterator: Integer;
        LineBreak: Text;
        SkyAgencyAuth: Record "Sky Agency Auth";
        SavingsAccounts: Record "Savings Accounts";
        SkyAgentsTransactions: Record "Sky Agents Transactions";
        SafcomFee: Decimal;
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        PrePaymentGL: Code[30];
        SMSAccount: Code[30];
        SMSCharge: Decimal;
        Type: Option Daily,Weekly,Monthly;
        Limit: Decimal;
        TotalCharge: Decimal;
        ExciseDuty: Decimal;
        ExciseDutyRate: Decimal;
        ExciseDutyGL: Code[30];
        TransType: Option ,CASH_WITHDRAWAL,CASH_DEPOSIT,ACCOUNT_BALANCE,ACCOUNT_STATEMENT,LOAN_REPAYMENT;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        AgentAplication: Record "Agent Applications";
        Members: Record Members;
        MemberNumber: Code[30];
        Loans: Record Loans;
        SkyAgencyCompanies: Record "Sky Agency Companies";
        SkyAgencyDevices: Record "Sky Agency Devices";
        CompanyInformation: Record "Company Information";
        AgentAccNumber: Code[30];
        AgentCommisionAccNumber: Code[30];
        AgentComm: Decimal;
        SaccoAcc: Code[30];
        VendorCommAcc: Code[30];
        AgentCode: Code[30];
        AgentSavAcc: Record "Savings Accounts";
        PostingDateFormated: Text;
        CharacterCount: Integer;
        SavAcc: Record "Savings Accounts";
        OutstandingBal: Decimal;
        OutstandingInt: Decimal;
        Arrears: Decimal;
        CustomerSav: Record "Savings Accounts";
        TotalLoanBalance: Decimal;
        AgentSMS: Text;
        SendAgentSMS: Boolean;
        SendCustomerSMS: Boolean;
    begin




        /*-------------------------------------------------------------------------------------*/
        Status := 'SUCCESS';
        /*
        Possible Response Statuses:
        ---------------------------
        SUCCESS
        ERROR
        FAILED
        INCORRECT_PIN
        SUSPENDED
        BLOCKED
        ---------------------------
        Possible Transaction Types:
        CASH_WITHDRAWAL
        CASH_DEPOSIT
        ACCOUNT_BALANCE
        ACCOUNT_STATEMENT
        LOAN_PAYMENT
        */
        LineBreak := 'xx';
        LineBreak[1] := 13;
        LineBreak[2] := 10;

        ResponseTitle := 'Agent Transaction';
        ResponseMessage := 'Dear user, an error occured while processing your request, kindly try again later.';
        AgentSMS := '';
        SendAgentSMS := false;
        SendCustomerSMS := true;
        /*-------------------------------------------------------------------------------------*/

        //Member number

        if SavingsAccounts.Get(CustomerAccountNumber) then
            MemberNumber := SavingsAccounts."Member No.";
        if Loans.Get(CustomerLoanNumber) then
            MemberNumber := Loans."Member No.";

        if AgentAplication.Get(AgentUsername) then begin
            ResponseMessage := 'Agent Found';
            Status := 'SUCCESS';
            AgentAccNumber := AgentAplication.Account;
            AgentCommisionAccNumber := AgentAplication."Comm Account";
            AgentCode := AgentAplication."Agent Code";
        end else begin
            ResponseMessage := 'Incorrect Username or Password';
            Status := 'FAILED';
        end;


        if CustomerMemberNumber = '' then begin
            ResponseMessage := 'You are not a member of the sacco';
            Status := 'FAILED';
        end;

        if SavingsAccounts.Get(AgentAccountNumber) then begin
            if SavingsAccounts."Member No." = CustomerMemberNumber then begin
                ResponseMessage := 'You cannot do a self transaction';
                Status := 'FAILED';
            end;
        end;



        if Status = 'SUCCESS' then begin
            SkyAgentsTransactions.Reset;
            SkyAgentsTransactions.SetRange("Transaction ID", TransactionSessionID);
            if SkyAgentsTransactions.FindFirst then begin
                ResponseMessage := 'Transaction Already Exists';
                Status := 'FAILED';
            end;
        end;
        AgentAplication.Get(AgentUsername);

        if Status = 'SUCCESS' then begin
            AgentSavAcc.Get(AgentAccNumber);
            AgentSavAcc.CalcFields("Balance (LCY)");

            if (TransactionType = 'LOAN_PAYMENT') or (TransactionType = 'CASH_DEPOSIT') then begin
                if TransactionAmount > (AgentSavAcc."Balance (LCY)" - 500) then begin
                    ResponseMessage := 'Agent balance KES: ' + Format(AgentSavAcc."Balance (LCY)" - 500) + ' is less than the transaction amount KES ' + Format(TransactionAmount);
                    Status := 'FAILED';
                end;
            end;
        end;
        /*----------------------------------------START: COOP CHECK UP -------------------------------------------------------*/
        SafcomFee := 0;
        SaccoFee := 0;
        VendorCommission := 0;
        PrePaymentGL := '';
        SMSAccount := '';
        SMSCharge := 0;


        AgentTariffHeader.Reset;
        if TransactionType = 'CASH_WITHDRAWAL' then
            AgentTariffHeader.SetRange(Code, 'WITHDRAWAL')
        else
            if TransactionType = 'CASH_DEPOSIT' then
                AgentTariffHeader.SetRange(Code, 'DEPOSIT')
            else
                if TransactionType = 'ACCOUNT_BALANCE' then
                    AgentTariffHeader.SetRange(Code, 'BALANCE ENQ')
                else
                    if TransactionType = 'ACCOUNT_STATEMENT' then
                        AgentTariffHeader.SetRange(Code, 'MINISTATEMENT')
                    else
                        if TransactionType = 'LOAN_PAYMENT' then
                            AgentTariffHeader.SetRange(Code, 'LN_REPAYMENT')
                        else
                            if TransactionType = 'LOAN_BALANCE' then
                                AgentTariffHeader.SetRange(Code, 'LOAN_BALANCE');
        if AgentTariffHeader.FindFirst then begin
            if TransactionType = 'CASH_WITHDRAWAL' then begin

                if CustomerSav.Get(CustomerAccountNumber) then begin
                    CustomerSav.CalcFields("Balance (LCY)");
                    if Status = 'SUCCESS' then begin
                        if CustomerSav."Balance (LCY)" - (GetLessAccountBal(CustomerAccountNumber) + 1000) < 1000 then begin
                            ResponseMessage := 'Your account balance is less than KES 1000';
                            Status := 'FAILED';
                        end;
                    end;
                    if Status = 'SUCCESS' then begin
                        if TransactionAmount > (CustomerSav."Balance (LCY)" - 1000) then begin
                            ResponseMessage := 'Insufficient Balance';
                            Status := 'FAILED';
                        end;
                    end;
                end;
                if AgentTariffHeader."Transaction Limit" > 0 then begin
                    if Status = 'SUCCESS' then begin
                        if TransactionAmount > AgentTariffHeader."Transaction Limit" then begin
                            ResponseMessage := 'Transaction Amount Exceeds the Limit of KES ' + Format(AgentTariffHeader."Transaction Limit");
                            Status := 'FAILED';
                        end;
                    end;
                end;
                if Status = 'SUCCESS' then begin
                    if AgentTariffHeader."Daily Limit" > 0 then begin
                        Limit := AgentTariffHeader."Daily Limit" - GetAmountTransacted('WITHDRAWAL', CustomerAccountNumber, Dt2Date(CurrentDatetime), Type::Daily);
                        if Limit < 0 then
                            Limit := 0;
                        if Limit < TransactionAmount then begin
                            if SavingsAccounts.Get(CustomerAccountNumber) then begin
                                //Priority := 211;
                                ResponseMessage := 'Transaction Amount has Exceeded the Daily of KES ' + Format(AgentTariffHeader."Daily Limit");
                                Status := 'FAILED';
                            end;
                        end;
                    end;
                end;
                if Status = 'SUCCESS' then begin
                    if AgentTariffHeader."Weekly Limit" > 0 then begin
                        Limit := AgentTariffHeader."Weekly Limit" - GetAmountTransacted('WITHDRAWAL', CustomerAccountNumber, Dt2Date(CurrentDatetime), Type::Weekly);
                        if Limit < 0 then
                            Limit := 0;
                        if Limit < TransactionAmount then begin
                            if SavingsAccounts.Get(CustomerAccountNumber) then begin
                                //Priority := 211;
                                ResponseMessage := 'Transaction Amount has Exceeded the Weekly Limit of KES ' + Format(AgentTariffHeader."Weekly Limit");
                                Status := 'FAILED';
                            end;
                        end;
                    end;
                end;
                if Status = 'SUCCESS' then begin
                    if AgentTariffHeader."Monthly Limit" > 0 then begin
                        Limit := AgentTariffHeader."Monthly Limit" - GetAmountTransacted('WITHDRAWAL', CustomerAccountNumber, Dt2Date(CurrentDatetime), Type::Monthly);
                        if Limit < 0 then
                            Limit := 0;
                        if Limit < TransactionAmount then begin
                            if SavingsAccounts.Get(CustomerAccountNumber) then begin
                                //Priority := 211;
                                ResponseMessage := 'Transaction Amount has Exceeded the Monthly Limit of KES ' + Format(AgentTariffHeader."Monthly Limit");
                                Status := 'FAILED';
                            end;
                        end;
                    end;
                end;
            end;

            if Status = 'SUCCESS' then begin
                AgentTariffDetails.Reset;
                AgentTariffDetails.SetRange(Code, AgentTariffHeader.Code);
                if AgentTariffDetails.FindFirst then begin
                    if TransactionType = 'CASH_WITHDRAWAL' then begin
                        if TransactionAmount < AgentTariffDetails."Lower Limit" then begin
                            ResponseMessage := 'You cannot withdraw less than KES ' + Format(AgentTariffDetails."Lower Limit");
                            Status := 'FAILED';
                        end;
                    end;
                    SaccoFee := AgentTariffDetails."Sacco Comm";
                    AgentComm := AgentTariffDetails."Agent Comm";
                    VendorCommission := AgentTariffDetails."Vendor Comm";
                end;
            end;
            //If Tiered
            if Status = 'SUCCESS' then begin
                if AgentTariffHeader.Tiered then begin
                    AgentTariffDetails.Reset;
                    AgentTariffDetails.SetRange(Code, AgentTariffHeader.Code);
                    AgentTariffDetails.SetFilter("Lower Limit", '<=%1', TransactionAmount);
                    AgentTariffDetails.SetFilter("Upper Limit", '>=%1', TransactionAmount);
                    if AgentTariffDetails.FindFirst then begin
                        SaccoFee := AgentTariffDetails."Sacco Comm";
                        AgentComm := AgentTariffDetails."Agent Comm";
                        VendorCommission := AgentTariffDetails."Vendor Comm";
                    end;
                end;
            end;

            SaccoAcc := AgentTariffHeader."Sacco Comm Acc";
            AgentCommisionAccNumber := AgentAplication."Comm Account";
            VendorCommAcc := AgentTariffHeader."Vendor Comm Acc";



            TotalCharge := SaccoFee + VendorCommission + AgentComm;
            ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
        end
        else begin
            //ResponseMessage := 'Set up Missing';
            //Status := 'FAILED';
        end;
        /*----------------------------------------END: COOP CHECK UP -------------------------------------------------------*/




        TransactionAccountText := '';
        TransactionAccountText += 'A/C: ' + CustomerAccountName + br;
        TransactionAccountText += 'A/C No.: ' + MaskFuction(CustomerAccountNumber) + br;

        TransactionText := '';
        StatementText := '';

        SMSData := '';
        SMSData += 'Dear Member,' + LineBreak;

        ExciseDutyGL := GetExciseDutyGL();
        ExciseDutyRate := GetExciseRate();
        ExciseDuty := 0;

        if TransactionType = 'CASH_WITHDRAWAL' then begin
            TransactionText += hr + br;
            TransactionText += 'Amount: KES ' + Format(TransactionAmount) + br;
            TransactionText += 'Charge: KES ' + Format(TotalCharge + ExciseDuty) + br;
            TransactionText += 'Reference: ' + TransactionSessionID + br;
            if TransactionNarration <> '' then begin
                TransactionText += 'Narration: ' + TransactionNarration + br;
            end;
            TransactionText += 'Date: ' + TransactionDate + br;
            TransactionText += hr + br;

            if Status = 'SUCCESS' then begin
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("No.", CustomerAccountNumber);
                if SavingsAccounts.FindFirst then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    if (SavingsAccounts.Status <> SavingsAccounts.Status::Active) or (SavingsAccounts.Blocked = SavingsAccounts.Blocked::All)
                    or (SavingsAccounts.Blocked = SavingsAccounts.Blocked::All) then begin
                        ResponseMessage := 'Account is either blocked or inactive';
                        Status := 'FAILED';
                    end else begin
                        if TransactionAmount <= SavingsAccounts."Balance (LCY)" then begin
                            //Insert into agency transactions
                            SkyAgentsTransactions.Init;
                            SkyAgentsTransactions."Entry No." := CreateGuid;
                            SkyAgentsTransactions."Transaction ID" := TransactionSessionID;
                            SkyAgentsTransactions."Session ID" := TransactionSessionID;
                            SkyAgentsTransactions."Agent Code" := AgentCode;
                            SkyAgentsTransactions."Transaction Type" := SkyAgentsTransactions."transaction type"::Withdrawal;
                            SkyAgentsTransactions."Transaction Name" := TransactionName;
                            SkyAgentsTransactions.Description := CopyStr(TransactionNarration, 1, 50);
                            SkyAgentsTransactions."Transaction Date" := Dt2Date(CurrentDatetime);
                            SkyAgentsTransactions."Transaction Time" := Dt2Time(CurrentDatetime);
                            SkyAgentsTransactions."Member Account" := CustomerAccountNumber;
                            SkyAgentsTransactions."Agent Commision Account" := AgentCommisionAccNumber;
                            SkyAgentsTransactions."Member No" := MemberNumber;
                            SkyAgentsTransactions.Amount := TransactionAmount;
                            SkyAgentsTransactions."Agent Account Number" := AgentAccNumber;
                            SkyAgentsTransactions."Loan No." := '';
                            SkyAgentsTransactions."Mobile No." := CustomerMobileNumber;
                            SkyAgentsTransactions."Vendor Commission" := VendorCommission;
                            SkyAgentsTransactions."Sacco Fee" := SaccoFee;
                            SkyAgentsTransactions."Paybill Member ID" := '';
                            SkyAgentsTransactions.Insert;

                            ResponseMessage := 'Transaction Successful';
                            Status := 'SUCCESS';
                            SMSData += 'your cash withdrawal of KES ' + Format(TransactionAmount) + ' at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has been processed successfully.';
                            SMSData += LineBreak + 'Kindly collect KES ' + Format(TransactionAmount) + ' from the agent.';

                            AgentSMS := 'Dear Agent,' + LineBreak + 'Kindly give KES ' + Format(TransactionAmount) + ' to ' + CustomerName;
                            AgentSMS += LineBreak + 'Txn: ' + TransactionName;
                            AgentSMS += LineBreak + 'Date: ' + TransactionDate;
                            AgentSMS += LineBreak + 'Ref: ' + TransactionSessionID;
                            SendAgentSMS := true;

                        end else begin
                            ResponseMessage := 'Insufficient balance';
                            Status := 'FAILED';
                        end;
                    end;
                end;
            end else begin
                SMSData += 'your cash withdrawal of KES ' + Format(TransactionAmount) + ' from your ' + CustomerAccountName + ' at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has Failed.';

                AgentSMS := 'Dear Agent,' + LineBreak + 'The ' + TransactionName + ' transaction of KES ' + Format(TransactionAmount) + ' for ' + CustomerName + ' has failed.';
                AgentSMS += LineBreak + 'Date: ' + TransactionDate;
                AgentSMS += LineBreak + 'Ref: ' + TransactionSessionID;
                SendAgentSMS := true;
            end;

        end
        else
            if TransactionType = 'CASH_DEPOSIT' then begin
                TransactionText += hr + br;
                TransactionText += 'Amount: KES ' + Format(TransactionAmount) + br;
                //TransactionText += 'Charge: KES '+FORMAT(TotalCharge+ExciseDuty)+br;
                TransactionText += 'Reference: ' + TransactionSessionID + br;
                if TransactionNarration <> '' then begin
                    TransactionText += 'Narration: ' + TransactionNarration + br;
                end;
                TransactionText += 'Date: ' + TransactionDate + br;
                TransactionText += hr + br;

                /*------------------------------------------START: Deposit transaction--------------------------------------*/
                if Status = 'SUCCESS' then begin
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("No.", CustomerAccountNumber);
                    if SavingsAccounts.FindFirst then begin
                        SavingsAccounts.CalcFields("Balance (LCY)");
                        if ((SavingsAccounts.Status <> SavingsAccounts.Status::Active)) or (SavingsAccounts.Blocked = SavingsAccounts.Blocked::All)
                        or (SavingsAccounts.Blocked = SavingsAccounts.Blocked::All) then begin
                            ResponseMessage := 'Account is either blocked or inactive';
                            Status := 'FAILED';
                        end else begin
                            //Insert into agency transactions
                            SkyAgentsTransactions.Init;
                            SkyAgentsTransactions."Entry No." := CreateGuid;
                            SkyAgentsTransactions."Transaction ID" := TransactionSessionID;
                            SkyAgentsTransactions."Session ID" := TransactionSessionID;
                            SkyAgentsTransactions."Agent Code" := AgentCode;
                            SkyAgentsTransactions."Transaction Type" := SkyAgentsTransactions."transaction type"::Deposit;
                            SkyAgentsTransactions."Transaction Name" := TransactionName;
                            SkyAgentsTransactions.Description := CopyStr(TransactionNarration, 1, 50);
                            ;
                            SkyAgentsTransactions."Transaction Date" := Dt2Date(CurrentDatetime);
                            SkyAgentsTransactions."Transaction Time" := Dt2Time(CurrentDatetime);
                            SkyAgentsTransactions."Member Account" := CustomerAccountNumber;
                            SkyAgentsTransactions.Amount := TransactionAmount;
                            SkyAgentsTransactions."Agent Account Number" := AgentAccNumber;
                            SkyAgentsTransactions."Agent Commision Account" := AgentCommisionAccNumber;
                            SkyAgentsTransactions."Loan No." := '';
                            SkyAgentsTransactions."Mobile No." := CustomerMobileNumber;
                            SkyAgentsTransactions."Member No" := MemberNumber;
                            SkyAgentsTransactions."Vendor Commission" := VendorCommission;
                            SkyAgentsTransactions."Sacco Fee" := SaccoFee;
                            SkyAgentsTransactions."Paybill Member ID" := '';
                            SkyAgentsTransactions.Insert;

                            ResponseMessage := 'Transaction Successful';
                            Status := 'SUCCESS';
                            SMSData += 'your cash deposit of KES ' + Format(TransactionAmount) + ' to your ' + CustomerAccountName + ' at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has been processed successfully.';
                            SMSData += LineBreak + 'Kindly give KES ' + Format(TransactionAmount) + ' to the agent.';

                            AgentSMS := 'Dear Agent,' + LineBreak + 'Kindly collect KES ' + Format(TransactionAmount) + ' from ' + CustomerName;
                            AgentSMS += LineBreak + 'Txn: ' + TransactionName;
                            AgentSMS += LineBreak + 'Date: ' + TransactionDate;
                            AgentSMS += LineBreak + 'Ref: ' + TransactionSessionID;
                            SendAgentSMS := true;
                        end;
                    end;
                end else begin
                    SMSData += 'your cash deposit of KES ' + Format(TransactionAmount) + ' from your ' + CustomerAccountName + ' at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has Failed.';

                    AgentSMS := 'Dear Agent,' + LineBreak + 'The ' + TransactionName + ' transaction of KES ' + Format(TransactionAmount) + ' for ' + CustomerName + ' has failed.';
                    AgentSMS += LineBreak + 'Date: ' + TransactionDate;
                    AgentSMS += LineBreak + 'Ref: ' + TransactionSessionID;
                    SendAgentSMS := true;
                end;
                /*------------------------------------------END:   Deposit transaction------------------------------------- */
            end
            else
                if TransactionType = 'LOAN_PAYMENT' then begin
                    TransactionAccountText := '';
                    TransactionAccountText += 'Loan: ' + CustomerLoanName + br;
                    TransactionAccountText += 'Loan No.: ' + MaskFuction(CustomerLoanNumber) + br;

                    TransactionText += hr + br;
                    TransactionText += 'Amount: KES ' + Format(TransactionAmount) + br;
                    //TransactionText += 'Charge: KES '+FORMAT(TotalCharge+ExciseDuty)+br;
                    TransactionText += 'Reference: ' + TransactionSessionID + br;
                    if TransactionNarration <> '' then begin
                        TransactionText += 'Narration: ' + TransactionNarration + br;
                    end;
                    TransactionText += 'Date: ' + TransactionDate + br;
                    TransactionText += hr + br;

                    /*------------------------------------------START: Loan Repayment--------------------------------------*/
                    if Status = 'SUCCESS' then begin
                        //Insert into agency transactions
                        SkyAgentsTransactions.Init;
                        SkyAgentsTransactions."Entry No." := CreateGuid;
                        SkyAgentsTransactions."Transaction ID" := TransactionSessionID;
                        SkyAgentsTransactions."Session ID" := TransactionSessionID;
                        SkyAgentsTransactions."Agent Code" := AgentCode;
                        SkyAgentsTransactions."Transaction Type" := SkyAgentsTransactions."transaction type"::LoanRepayment;
                        SkyAgentsTransactions."Transaction Name" := TransactionName;
                        SkyAgentsTransactions.Description := CopyStr(TransactionNarration, 1, 50);
                        ;
                        SkyAgentsTransactions."Transaction Date" := Dt2Date(CurrentDatetime);
                        SkyAgentsTransactions."Transaction Time" := Dt2Time(CurrentDatetime);
                        SkyAgentsTransactions."Member Account" := CustomerAccountNumber;
                        SkyAgentsTransactions."Member No" := MemberNumber;
                        SkyAgentsTransactions.Amount := TransactionAmount;
                        SkyAgentsTransactions."Agent Account Number" := AgentAccNumber;
                        SkyAgentsTransactions."Agent Commision Account" := AgentCommisionAccNumber;
                        SkyAgentsTransactions."Loan No." := CustomerLoanNumber;
                        SkyAgentsTransactions."Mobile No." := CustomerMobileNumber;
                        SkyAgentsTransactions."Vendor Commission" := VendorCommission;
                        SkyAgentsTransactions."Sacco Fee" := SaccoFee;
                        SkyAgentsTransactions."Paybill Member ID" := '';
                        SkyAgentsTransactions.Insert;

                        ResponseMessage := 'Transaction Successful';
                        Status := 'SUCCESS';
                        SMSData += 'your loan payment of KES ' + Format(TransactionAmount) + ' at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has been processed successfully.';
                        SMSData += LineBreak + 'Kindly give KES ' + Format(TransactionAmount) + ' to the agent.';

                        AgentSMS := 'Dear Agent,' + LineBreak + 'Kindly collect KES ' + Format(TransactionAmount) + ' from ' + CustomerName;
                        AgentSMS += LineBreak + 'Transaction: ' + TransactionName;
                        AgentSMS += LineBreak + 'Date: ' + TransactionDate;
                        AgentSMS += LineBreak + 'Ref: ' + TransactionSessionID;
                        SendAgentSMS := true;
                    end else begin
                        SMSData += 'your ' + TransactionName + ' transaction of ' + TransactionAmountStylized + ' at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has Failed.';

                        AgentSMS := 'Dear Agent,' + LineBreak + 'The ' + TransactionName + ' transaction of KES ' + Format(TransactionAmount) + ' for ' + CustomerName + ' has failed.';
                        AgentSMS += LineBreak + 'Date: ' + TransactionDate;
                        AgentSMS += LineBreak + 'Ref: ' + TransactionSessionID;
                        SendAgentSMS := true;
                    end;
                    /*------------------------------------------END:   Loan Repaymnet------------------------------------- */
                end
                else
                    if TransactionType = 'ACCOUNT_BALANCE' then begin
                        SavingsAccounts.Get(CustomerAccountNumber);
                        SavingsAccounts.CalcFields("Balance (LCY)");
                        TransactionText += hr + br;
                        TransactionText += 'Balance: KES ' + Format(SavingsAccounts."Balance (LCY)" - (GetLessAccountBal(CustomerAccountNumber))) + br;
                        TransactionText += 'Charge: KES ' + Format(TotalCharge + ExciseDuty) + br;
                        TransactionText += 'Reference: ' + TransactionSessionID + br;
                        if TransactionNarration <> '' then begin
                            TransactionText += 'Narration: ' + TransactionNarration + br;
                        end;
                        TransactionText += 'Date: ' + TransactionDate + br;
                        TransactionText += hr + br;
                        /*------------------------------------------START: Account Balance--------------------------------------*/

                        if Status = 'SUCCESS' then begin
                            //Insert into agency transactions
                            SkyAgentsTransactions.Init;
                            SkyAgentsTransactions."Entry No." := CreateGuid;
                            SkyAgentsTransactions."Transaction ID" := TransactionSessionID;
                            SkyAgentsTransactions."Session ID" := TransactionSessionID;
                            SkyAgentsTransactions."Agent Code" := AgentCode;
                            SkyAgentsTransactions."Transaction Type" := SkyAgentsTransactions."transaction type"::Balance;
                            SkyAgentsTransactions."Transaction Name" := TransactionName;
                            SkyAgentsTransactions.Description := CopyStr(TransactionNarration, 1, 50);
                            ;
                            SkyAgentsTransactions."Transaction Date" := Dt2Date(CurrentDatetime);
                            SkyAgentsTransactions."Transaction Time" := Dt2Time(CurrentDatetime);
                            SkyAgentsTransactions."Member Account" := CustomerAccountNumber;
                            SkyAgentsTransactions."Member No" := MemberNumber;
                            SkyAgentsTransactions.Amount := TransactionAmount;
                            SkyAgentsTransactions."Agent Account Number" := AgentAccNumber;
                            SkyAgentsTransactions."Agent Commision Account" := AgentCommisionAccNumber;
                            SkyAgentsTransactions."Loan No." := CustomerLoanNumber;
                            SkyAgentsTransactions."Mobile No." := CustomerMobileNumber;
                            SkyAgentsTransactions."Vendor Commission" := VendorCommission;
                            SkyAgentsTransactions."Sacco Fee" := SaccoFee;
                            SkyAgentsTransactions."Paybill Member ID" := '';
                            SkyAgentsTransactions.Insert;

                            ResponseMessage := 'Transaction Successful';
                            Status := 'SUCCESS';
                            SMSData += 'your account balance enquiry at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has been processed successfully.';
                            SMSData += LineBreak + 'Your account balance is KES ' + Format(SavingsAccounts."Balance (LCY)");
                        end else begin
                            SMSData += 'your account balance enquiry at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has been has Failed.';
                        end;
                        /*------------------------------------------END:   Account Balance------------------------------------- */
                    end
                    else
                        if TransactionType = 'LOAN_BALANCE' then begin
                            TransactionAccountText := '';
                            TransactionAccountText += 'Loan: ' + CustomerLoanName + br;
                            TransactionAccountText += 'Loan No.: ' + MaskFuction(CustomerLoanNumber) + br;

                            OutstandingBal := 0;
                            OutstandingInt := 0;
                            Arrears := 0;
                            GetLoanBalance2(CustomerLoanNumber, OutstandingBal, OutstandingInt, Arrears);
                            TransactionText += hr + br;
                            TransactionText += 'Outstanding Bal: KES ' + Format(OutstandingBal) + br;
                            TransactionText += 'Outstanding Int: KES ' + Format(OutstandingInt) + br;
                            TransactionText += 'Arrears' + Format(Arrears) + br;
                            TransactionText += 'Charge: KES ' + Format(TotalCharge + ExciseDuty) + br;
                            TransactionText += 'Reference: ' + TransactionSessionID + br;
                            if TransactionNarration <> '' then begin
                                TransactionText += 'Narration: ' + TransactionNarration + br;
                            end;
                            TransactionText += 'Date: ' + TransactionDate + br;
                            TransactionText += hr + br;
                            /*------------------------------------------START: Account Balance--------------------------------------*/
                            TotalLoanBalance := OutstandingBal + OutstandingInt + Arrears;
                            if Status = 'SUCCESS' then begin
                                //Insert into agency transactions
                                SkyAgentsTransactions.Init;
                                SkyAgentsTransactions."Entry No." := CreateGuid;
                                SkyAgentsTransactions."Transaction ID" := TransactionSessionID;
                                SkyAgentsTransactions."Session ID" := TransactionSessionID;
                                SkyAgentsTransactions."Agent Code" := AgentCode;
                                SkyAgentsTransactions."Transaction Type" := SkyAgentsTransactions."transaction type"::Balance;
                                SkyAgentsTransactions."Transaction Name" := TransactionName;
                                SkyAgentsTransactions.Description := CopyStr(TransactionNarration, 1, 50);
                                ;
                                SkyAgentsTransactions."Transaction Date" := Dt2Date(CurrentDatetime);
                                SkyAgentsTransactions."Transaction Time" := Dt2Time(CurrentDatetime);
                                SkyAgentsTransactions."Member Account" := CustomerAccountNumber;
                                SkyAgentsTransactions."Member No" := MemberNumber;
                                SkyAgentsTransactions.Amount := TransactionAmount;
                                SkyAgentsTransactions."Agent Account Number" := AgentAccNumber;
                                SkyAgentsTransactions."Agent Commision Account" := AgentCommisionAccNumber;
                                SkyAgentsTransactions."Loan No." := CustomerLoanNumber;
                                SkyAgentsTransactions."Mobile No." := CustomerMobileNumber;
                                SkyAgentsTransactions."Vendor Commission" := VendorCommission;
                                SkyAgentsTransactions."Sacco Fee" := SaccoFee;
                                SkyAgentsTransactions."Paybill Member ID" := '';
                                SkyAgentsTransactions.Insert;

                                ResponseMessage := 'Transaction Successful';
                                Status := 'SUCCESS';
                                SMSData += 'your loan balance enquiry at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has been processed successfully.';
                                SMSData += LineBreak + 'Your loan balance is KES ' + Format(TotalLoanBalance);
                            end else begin
                                SMSData += 'your loan balance enquiry at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has Failed.';
                            end;
                            /*------------------------------------------END:   Loan Balance------------------------------------- */
                        end
                        else
                            if TransactionType = 'ACCOUNT_STATEMENT' then begin
                                TransactionText += hr + br;
                                TransactionText += 'Charge: KES ' + Format(TotalCharge + ExciseDuty) + br;
                                TransactionText += 'Reference: ' + TransactionSessionID + br;
                                if TransactionNarration <> '' then begin
                                    TransactionText += 'Narration: ' + TransactionNarration + br;
                                end;
                                TransactionText += 'Date: ' + TransactionDate + br;
                                //Account Balance
                                SavingsAccounts.Get(CustomerAccountNumber);
                                SavingsAccounts.CalcFields("Balance (LCY)");
                                Iterator := 0;
                                if Status = 'SUCCESS' then begin
                                    SMSData += 'your account statement enquiry at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has been processed successfully.';
                                    SavingsLedgerEntry.Reset;
                                    SavingsLedgerEntry.SetCurrentkey("Posting Date");
                                    SavingsLedgerEntry.SetRange("Account No.", CustomerAccountNumber);
                                    if SavingsLedgerEntry.FindLast then begin
                                        StatementText += hr + br;

                                        repeat//***

                                            PostingDateFormated := FormatDate(SavingsLedgerEntry."Posting Date");
                                            StatementText += PostingDateFormated + ' ' + Format(SavingsLedgerEntry."Creation Time") + ', ';
                                            StatementText += SavingsLedgerEntry.Description + ', ';
                                            StatementText += 'KES ' + Format(SavingsLedgerEntry.Amount) + ';' + br;

                                            if Iterator = 1 then
                                                SMSData += '[';

                                            SMSData += Format(SavingsLedgerEntry."Posting Date") + ' ' + Format(SavingsLedgerEntry."Creation Time") + ';';
                                            SMSData += SavingsLedgerEntry.Description + ';';
                                            SMSData += 'KES ' + Format(SavingsLedgerEntry.Amount) + ';';
                                            SMSData += 'Bal: KES ' + Format(SavingsAccounts."Balance (LCY)");

                                            if Iterator = TransactionStatementCount then begin
                                                SMSData += ']';
                                            end
                                            else begin
                                                SMSData += '],';
                                            end;
                                            Iterator += 1;
                                            SavingsLedgerEntry.Next(-1);
                                        until Iterator = TransactionStatementCount;
                                        StatementText += hr + br;
                                    end;
                                end;
                                /*-----------------------------START: Register the transaction--------------------------------------*/
                                if Status = 'SUCCESS' then begin
                                    //Insert into agency transactions
                                    SkyAgentsTransactions.Init;
                                    SkyAgentsTransactions."Entry No." := CreateGuid;
                                    SkyAgentsTransactions."Transaction ID" := TransactionSessionID;
                                    SkyAgentsTransactions."Session ID" := TransactionSessionID;
                                    SkyAgentsTransactions."Agent Code" := AgentCode;
                                    SkyAgentsTransactions."Transaction Type" := SkyAgentsTransactions."transaction type"::Ministatment;
                                    SkyAgentsTransactions."Transaction Name" := TransactionName;
                                    SkyAgentsTransactions.Description := CopyStr(TransactionNarration, 1, 50);
                                    ;
                                    SkyAgentsTransactions."Transaction Date" := Dt2Date(CurrentDatetime);
                                    SkyAgentsTransactions."Transaction Time" := Dt2Time(CurrentDatetime);
                                    SkyAgentsTransactions."Member Account" := CustomerAccountNumber;
                                    SkyAgentsTransactions."Member No" := MemberNumber;
                                    SkyAgentsTransactions.Amount := TransactionAmount;
                                    SkyAgentsTransactions."Agent Account Number" := AgentAccNumber;
                                    SkyAgentsTransactions."Agent Commision Account" := AgentCommisionAccNumber;
                                    SkyAgentsTransactions."Loan No." := CustomerLoanNumber;
                                    SkyAgentsTransactions."Mobile No." := CustomerMobileNumber;
                                    SkyAgentsTransactions."Vendor Commission" := VendorCommission;
                                    SkyAgentsTransactions."Sacco Fee" := SaccoFee;
                                    SkyAgentsTransactions."Paybill Member ID" := '';
                                    SkyAgentsTransactions.Insert;

                                    ResponseMessage := 'Transaction Successful';
                                    Status := 'SUCCESS';
                                end;
                                /*-----------------------------END:   Register the transaction--------------------------------------*/
                            end;
        AgentAplication.Get(AgentUsername);
        CompanyInformation.Get;
        if Status = 'SUCCESS' then begin
            PostMpesaTransaction(TransactionSessionID);

            //if not PostMpesaTransaction(TransactionSessionID) then begin
            //  Status := 'FAILED';
            //ResponseMessage := 'Error during posting';
            //end;
        end;
        if Status = 'SUCCESS' then begin
            if TransactionNarration <> '' then
                //SMSData += ' Narration: '+TransactionNarration;
                SMSData += LineBreak + 'Date: ' + TransactionDate;
            SMSData += LineBreak + 'Ref: ' + TransactionSessionID;
            //SMSData += ' Thnnk you for banking with us';

            PrintData := '';
            PrintData += cdata_open + logo + br;
            PrintData += CompanyInformation.Name + br;
            PrintData += hr + br;
            PrintData += 'Center: ' + CompanyInformation."Phone No." + br;
            PrintData += 'Center: ' + CompanyInformation."E-Mail" + br;
            PrintData += hr + br;
            PrintData += 'Title: ' + TransactionName + br;
            PrintData += hr + br;
            PrintData += 'Agency: ' + AgentAplication."Name of the Proposed Agent" + br;
            PrintData += 'Location: ' + AgentAplication."Place of Business" + br;
            PrintData += 'Agent ID: ' + AgentAplication."Agent Code" + br;
            PrintData += 'Operator: ' + AgentAplication.Name + br;
            PrintData += hr + br;
            PrintData += 'Customer' + br;
            PrintData += 'Name: ' + CustomerName + br;
            PrintData += 'Phone Number: ' + CopyStr(CustomerMobileNumber, 1, 5) + '*****' + CopyStr(CustomerMobileNumber, 11, 3) + br;
            PrintData += TransactionAccountText;
            PrintData += TransactionText;
            PrintData += StatementText;
            PrintData += 'Footer: Thank you for banking with us' + br;
            PrintData += 'Barcode: ' + TransactionSessionID + cdata_close;
        end;
        DisplayData := PrintData;

        Clear(JsObject_1);
        JsObject_1.Add('print', PrintData);
        JsObject_1.Add('display', DisplayData);
        JsObject_1.Add('sms', SMSData);
        JsObject_1.Add('agent_sms', AgentSMS);
        JsObject_1.Add('send_customer_sms', SendCustomerSMS);
        JsObject_1.Add('send_agent_sms', SendAgentSMS);



        Clear(JsObject_4);

        JsObject_4.Add('title', ResponseTitle);
        JsObject_4.Add('message', ResponseMessage);
        JsObject_4.Add('data', JsObject_1);

        JsObject_5.Add('action', 'AGENT_TRANSACTION');
        JsObject_5.Add('status', Status);
        JsObject_5.Add('payload', JsObject_4);

        JsonResult.Add('response', JsObject_5);

        JsonResult.WriteTo(Response);


        /*-------------------------------------------------------------------------------------*/


    end;


    procedure GetAmountTransacted(Transaction: Text; AccountNo: Code[20]; Date: Date; Type: Option Daily,Weekly,Monthly) Amt: Decimal
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Bank Transfer";
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SkyAgentTrans: Record "Sky Agents Transactions";
        Continue: Boolean;
        AccBal: Decimal;
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        TransactionDate: DateTime;
        MemberID: Code[20];
        PrePaymentGL: Code[20];
        Loans: Record Loans;
        LoanNo: Code[20];
        MemberNo: Code[20];
    begin
        Amt := 0;

        if Transaction = 'WITHDRAWAL' then begin
            SkyAgentTrans.Reset;
            SkyAgentTrans.SetRange(SkyAgentTrans.Reversed, false);
            SkyAgentTrans.SetRange(SkyAgentTrans."Member Account", AccountNo);
            SkyAgentTrans.SetRange("Transaction Type", SkyAgentTrans."Transaction Type"::Withdrawal);
            if Type = Type::Daily then
                SkyAgentTrans.SetRange(SkyAgentTrans."Transaction Date", Date);
            if Type = Type::Weekly then
                SkyAgentTrans.SetRange(SkyAgentTrans."Transaction Date", CalcDate('-CW', Date), CalcDate('CW', Date));
            if Type = Type::Monthly then
                SkyAgentTrans.SetRange(SkyAgentTrans."Transaction Date", CalcDate('-CM', Date), CalcDate('CM', Date));
            if SkyAgentTrans.Find('-') then begin
                SkyAgentTrans.CalcSums(Amount);
                Amt := SkyAgentTrans.Amount;
            end;
        end;
    end;




    procedure GetExciseRate() rate: Integer
    var
        GenSetup: Record "Sacco Setup";
    begin
        GenSetup.Get;
        GenSetup.TestField(GenSetup."Excise Duty (%)");
        rate := GenSetup."Excise Duty (%)";
    end;


    procedure GetExciseDutyGL() account: Text[20]
    var
        GenSetup: Record "Sacco Setup";
    begin
        GenSetup.Reset;
        GenSetup.Get;
        GenSetup.TestField(GenSetup."Excise Duty GL");
    end;


    procedure PostMpesaTransaction(SessionID: Code[30]) Response: Boolean
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        SkyAgentsTransactions: Record "Sky Agents Transactions";
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
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
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
        DepDesc: Text;
        MobileNo: Code[20];
        ExciseDutyGL: Code[30];
        ExciseDutyRate: Decimal;
        ExciseDuty: Decimal;
        SMSAccount: Code[30];
        SMSCharge: Decimal;
        AgentTariffHeader: Record "Agent Tarriff Header";
        GenJournalBatch: Record "Gen. Journal Batch";
        SaccoTrans: Codeunit "Sacco Activities";
        Priority: Integer;
        AgentCommision: Decimal;
        AgentAccount: Code[30];
        Source: Enum "SMS Source Enum";
        AgentTariffDetails: Record "Agent Tariff Details";
        SaccoComm: Decimal;
        SaccoCommAcc: Code[30];
        AgentCommAcc: Code[30];
        ProductFactory: Record "Product Setup";
        Bills: Decimal;
        AgentCode: Code[30];
        Desc: Text;
        DescLoanNo: Text;
        SkyMbanking: Codeunit "Sky MBanking";
        TotalCustomerCharge: Decimal;
        DimID: Integer;
    begin
        Response := true;
        SkyAgentsTransactions.Reset;
        SkyAgentsTransactions.SetRange("Session ID", SessionID);
        SkyAgentsTransactions.SetRange(Posted, false);
        SkyAgentsTransactions.SetRange("Needs Change", false);
        if SkyAgentsTransactions.FindFirst then begin
            repeat
                GenSetup.Get;
                AgentCode := SkyAgentsTransactions."Agent Code";

                // Get Excise duty G/L
                ExciseDutyGL := GetExciseDutyGL();
                ExciseDutyRate := GetExciseRate();
                ExciseDuty := 0;
                Desc := SkyAgentsTransactions."Transaction Name";
                DescLoanNo := SkyAgentsTransactions."Loan No.";

                SaccoAccount := '';
                SaccoFee := 0;
                VendorAccount := '';
                VendorCommission := 0;
                SafcomAcc := '';
                SafcomFee := 0;
                PrePaymentGL := '';
                SMSAccount := '';
                SMSCharge := 0;

                AgentTariffHeader.Reset;
                if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Withdrawal then
                    AgentTariffHeader.SetRange(Code, 'WITHDRAWAL')
                else
                    if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Deposit then
                        AgentTariffHeader.SetRange(Code, 'DEPOSIT')
                    else
                        if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Balance then
                            AgentTariffHeader.SetRange(Code, 'BALANCE ENQ')
                        else
                            if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Ministatment then
                                AgentTariffHeader.SetRange(Code, 'MINISTATEMENT')
                            else
                                if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::LoanRepayment then
                                    AgentTariffHeader.SetRange(Code, 'LN_REPAYMENT');
                if AgentTariffHeader.FindFirst then begin

                    TChannel := TChannel::Agency;

                    AgentTariffDetails.Reset;
                    AgentTariffDetails.SetRange(Code, AgentTariffHeader.Code);
                    if AgentTariffDetails.FindFirst then begin
                        SaccoComm := AgentTariffDetails."Sacco Comm";
                        AgentCommision := AgentTariffDetails."Agent Comm";
                        VendorCommission := AgentTariffDetails."Vendor Comm";
                    end;
                    //If Tiered
                    if AgentTariffHeader.Tiered then begin
                        AgentTariffDetails.Reset;
                        AgentTariffDetails.SetRange(Code, AgentTariffHeader.Code);
                        AgentTariffDetails.SetFilter("Lower Limit", '<=%1', SkyAgentsTransactions.Amount);
                        AgentTariffDetails.SetFilter("Upper Limit", '>=%1', SkyAgentsTransactions.Amount);
                        if AgentTariffDetails.FindFirst then begin
                            SaccoComm := AgentTariffDetails."Sacco Comm";
                            AgentCommision := AgentTariffDetails."Agent Comm";
                            VendorCommission := AgentTariffDetails."Vendor Comm";
                        end;
                    end;

                    SaccoCommAcc := AgentTariffHeader."Sacco Comm Acc";
                    AgentCommAcc := SkyAgentsTransactions."Agent Commision Account";
                    VendorAccount := AgentTariffHeader."Vendor Comm Acc";


                    TotalCharge := SaccoComm + AgentCommision + VendorCommission;
                    ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
                end
                else begin
                    Response := false;
                    //ERROR('Setup Missing for %1',SkyAgentsTransactions."Transaction Type");
                end;

                //ERROR('SafcomFee %1\SaccoFee %2',SafcomFee,SaccoFee);
                if SavAcc.Get(SkyAgentsTransactions."Member Account") then begin

                    DimID := SavAcc."Dimension Set ID";
                    MemberName := SavAcc."No.";
                    TransAmt := SkyAgentsTransactions.Amount;
                    AccountToCharge := SkyAgentsTransactions."Member Account";


                    if TransAmt >= 0 then begin
                        if SavAcc.Blocked = SavAcc.Blocked::All then begin
                            SkyAgentsTransactions."Needs Change" := true;
                            SkyAgentsTransactions.Modify;
                            Response := false;
                        end;
                    end;

                    if TransAmt < 0 then begin
                        if (SavAcc.Blocked <> SavAcc.Blocked::" ") then begin
                            SkyAgentsTransactions."Needs Change" := true;
                            SkyAgentsTransactions.Modify;
                            Response := false;
                        end;
                    end;

                    if (SavAcc.Blocked = SavAcc.Blocked::All) then begin
                        SkyAgentsTransactions."Needs Change" := true;
                        SkyAgentsTransactions.Modify;
                        Response := false;
                    end;

                    //BUser.GET(USERID);

                    //BUser.TESTFIELD("Cashier Journal Template");
                    //BUser.TESTFIELD("Cashier Journal Batch");

                    JTemplate := 'GENERAL';
                    JBatch := 'DEFAULT';

                    GenJournalBatch.Reset;
                    GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                    GenJournalBatch.SetRange(Name, JBatch);
                    if not GenJournalBatch.FindFirst then begin
                        GenJournalBatch.Init;
                        GenJournalBatch."Journal Template Name" := JTemplate;
                        GenJournalBatch.Name := JBatch;
                        GenJournalBatch.Description := 'Sky World Batch';
                        GenJournalBatch.Init;
                    end;

                    DocNo := SkyAgentsTransactions."Transaction ID";
                    PDate := SkyAgentsTransactions."Transaction Date";

                    SavAcc.Reset;
                    SavAcc.SetRange("Member No.", SkyAgentsTransactions."Member No");
                    SavAcc.SetRange("Product Type", '505');
                    if SavAcc.FindFirst then begin
                        AccNo := SavAcc."No.";
                    end;


                    ExtDoc := '';
                    LoanNo := '';
                    TransType := Transtype::" ";
                    Dim1 := SavAcc."Global Dimension 1 Code";
                    Dim2 := SavAcc."Global Dimension 2 Code";
                    SystCreated := true;
                    //MESSAGE(AgentCommAcc);
                    SaccoTrans.JournalInit(JTemplate, JBatch);

                    if Response then begin
                        if (SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Withdrawal) then begin
                            //Debit member account
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, SkyAgentsTransactions."Member Account",
                            CopyStr(Desc + '- Agent ID' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account", '', TransAmt, ExtDoc, LoanNo, TransType,
                            Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                            //Credit agent account
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, SkyAgentsTransactions."Agent Account Number",
                            CopyStr(Desc + '- Agent ID' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account", '', -TransAmt, ExtDoc, LoanNo, TransType,
                            Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                        end else
                            if (SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Deposit) then begin
                                //Credit member account
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, SkyAgentsTransactions."Member Account",
                                CopyStr(Desc + '- Agent ID' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account", '', -TransAmt, ExtDoc, LoanNo, TransType,
                                Dim1, Dim2, SystCreated, TChannel, DimID);
                                //Debit agent account
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, SkyAgentsTransactions."Agent Account Number",
                                CopyStr(Desc + '- Agent ID' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account", '', TransAmt, ExtDoc, LoanNo, TransType,
                                Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                //Advice shares
                                SavAcc.Get(SkyAgentsTransactions."Member Account");
                                if SavAcc."Product Type" = '02' then begin
                                    //LoansProcess.AdviceShares(SavAcc, Abs(TransAmt), SavAcc."Monthly Contribution");
                                end;
                            end;


                        if TotalCharge > 0 then begin
                            TotalCustomerCharge := AgentCommision + VendorCommission + SaccoComm + ExciseDuty;
                            AccountToCharge := AccNo;

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccountToCharge, CopyStr(Desc + ' Charges- Agent ID: ' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account",
                                          '', TotalCustomerCharge, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);//Debit
                                                                                                                                             //Agent Commision Credit
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, AgentCommAcc, CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo + ' Agent Comm', 1, 50), Balacctype::"G/L Account",
                            '', -AgentCommision, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);//Credit

                            //Vendor (sky) Commision Credit
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, VendorAccount, CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo + ' Vendor Comm', 1, 50), Balacctype::"G/L Account",
                            '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);//Credit

                            //Sacco commision credit
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SaccoCommAcc, CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo + ' Sacco Comm', 1, 50), Balacctype::"G/L Account",
                                          '', -SaccoComm, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                            //Excise Duty credit
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty ' + Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account",
                                          '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                        end;


                        if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::LoanRepayment then begin

                            AccBal := GetAccountBalance(SavAcc."No.");
                            RunBal := AccBal + SkyAgentsTransactions.Amount - (TotalCharge + ExciseDuty);

                            if RunBal > 0 then begin
                                RunBal := SkyAgentsTransactions.Amount;
                                Loans.Reset;
                                Loans.SetRange("Loan No.", SkyAgentsTransactions."Loan No.");
                                Loans.SetRange("Member No.", SavAcc."Member No.");
                                if Loans.FindFirst then begin

                                    Loans.CalcFields("Outstanding Principal", "Outstanding Interest");

                                    IntAmt := Loans."Outstanding Interest";

                                    if Loans."Mobile Loan" then
                                        IntAmt := 0;

                                    if IntAmt > 0 then begin

                                        if IntAmt > RunBal then
                                            IntAmt := RunBal;

                                        AccNo := SkyAgentsTransactions."Member Account";
                                        AgentAccount := SkyAgentsTransactions."Agent Account Number";
                                        ExtDoc := '';
                                        LoanNo := Loans."Loan No.";
                                        TransType := Transtype::"Interest Paid";
                                        SystCreated := true;

                                        SkyAgentsTransactions."Interest Paid" := IntAmt;
                                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AgentAccount, CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account",
                                                      '', IntAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                        AccNo := Loans."Loan Account";
                                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account",
                                                      '', -IntAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                                        RunBal -= IntAmt;

                                    end;

                                    //                      IF Loans."Non-Salaried" THEN
                                    //                      IF Loans."Outstanding Penalty" > 0 THEN BEGIN
                                    //                          IntAmt := Loans."Outstanding Penalty" ;
                                    //                          IF IntAmt > RunBal THEN
                                    //                              IntAmt := RunBal;
                                    //
                                    //                          AccNo := SkyAgentsTransactions."Member Account";
                                    //                          AgentAccount := SkyAgentsTransactions."Agent Account Number";
                                    //                          ExtDoc := '';
                                    //                          LoanNo := Loans."Loan No.";
                                    //                          TransType := TransType::"Penalty Paid";
                                    //                          SystCreated := TRUE;
                                    //
                                    //                          //SkyAgentsTransactions."Interest Paid" := IntAmt;
                                    //                          SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AgentAccount,COPYSTR(SkyAgentsTransactions.Description,1,50),BalAccType::"G/L Account",
                                    //                                        '',IntAmt,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,SkyAgentsTransactions."Client Name");
                                    //
                                    //                          AccNo := Loans."Loan Account";
                                    //                          SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Credit,AccNo,COPYSTR(SkyAgentsTransactions.Description,1,50),BalAccType::"G/L Account",
                                    //                                        '',-IntAmt,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,SkyAgentsTransactions."Client Name");
                                    //
                                    //
                                    //                          RunBal -= IntAmt;
                                    //
                                    //                      END;

                                    if Loans."Outstanding Principal" > 0 then begin
                                        PrAmt := Loans."Outstanding Principal";
                                        if PrAmt > RunBal then
                                            PrAmt := RunBal;


                                        ProductFactory.Get(Loans."Loan Product Type");
                                        AccNo := SkyAgentsTransactions."Member Account";
                                        AgentAccount := SkyAgentsTransactions."Agent Account Number";
                                        ExtDoc := '';
                                        LoanNo := Loans."Loan No.";
                                        TransType := Transtype::"Principal Repayment";
                                        SystCreated := true;

                                        SkyAgentsTransactions."Principal Paid" := PrAmt;

                                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AgentAccount, CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account",
                                                      '', PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                        AccNo := Loans."Loan Account";
                                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account",
                                                      '', -PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                                        RunBal -= PrAmt;

                                        //Advide loan
                                        //SkyMbanking.AdviceLoan(Loans."Loan No.", false);

                                    end;
                                end;
                            end;
                        end;




                        //MARK BUFFER AS POSTED


                        //***msa
                        SkyAgentsTransactions.Posted := true;
                        SkyAgentsTransactions."Posted By" := UserId;
                        SkyAgentsTransactions."Date Posted" := Today;
                        SkyAgentsTransactions."Time Posted" := Time;
                        SkyAgentsTransactions.Modify;


                        Priority := 211;

                        SaccoTrans.JournalPost(JTemplate, JBatch);
                        if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Withdrawal then
                            Priority := 211;


                        if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::LoanRepayment then begin
                            if Loans.Get(LoanNo) then begin
                                Loans.CalcFields("Outstanding Principal");
                                LT := Loans."Loan Product Type Name";
                                if LoanType.Get(Loans."Loan Product Type") then
                                    LT := LoanType."USSD Product Name";

                                NewLoanBal := Loans."Outstanding Principal";
                                msg := Format(SkyAgentsTransactions."Transaction Type") + ' of KES ' + Format(SkyAgentsTransactions.Amount) + ' has been processed successfully. Interest Paid is ' + Format(SkyAgentsTransactions."Interest Paid") +
                                ', Principal Paid is ' + Format(SkyAgentsTransactions."Principal Paid") + ', New ' + LT + ' Balance is ' + Format(NewLoanBal);
                            end;
                        end;


                        MobileNo := SavAcc."Transactional Mobile No";
                        if MobileNo = '' then
                            MobileNo := SavAcc."Mobile Phone No.";

                        if (SkyAgentsTransactions."Transaction Type" <> SkyAgentsTransactions."transaction type"::Ministatment) and (SkyAgentsTransactions."Transaction Type" <> SkyAgentsTransactions."transaction type"::Balance) then
                            SkyMbanking.SendSms(Source::"Sky Agency", MobileNo, msg, Format(SkyAgentsTransactions."Transaction ID"), '', false, Priority, false);
                    end;//ending response true
                end
                else begin
                    Response := false;
                    if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Deposit then begin
                        SavAcc.Reset;
                        SavAcc.SetRange("ID No.", SkyAgentsTransactions."Member Account");
                        SavAcc.SetRange("Product Type", '500');
                        if SavAcc.FindFirst then begin
                            SkyAgentsTransactions."Member Account" := SavAcc."No.";
                            SkyAgentsTransactions."Paybill Member ID" := SavAcc."ID No.";
                            SkyAgentsTransactions.Modify;

                        end
                        else begin
                            SkyAgentsTransactions."Needs Change" := true;
                            SkyAgentsTransactions.Modify;
                        end;
                    end
                    else begin
                        SkyAgentsTransactions."Needs Change" := true;
                        SkyAgentsTransactions.Modify;
                    end;
                end;
            until SkyAgentsTransactions.Next = 0;
        end;
    end;


    procedure GetAccountBalance(Account: Text[30]) AccountBal: Decimal
    var
        savAccList: Record "Savings Accounts";
        MActivities: Codeunit "Member Activities";
        AccountTypes: Record "Product Setup";
        MNo: Code[20];
    begin

        AccountBal := MActivities.GetAccountBalance(Account);
        exit(AccountBal);
    end;

    procedure UpdateAuthAttempts("Action": Code[30]; Indent: Boolean; Username: Code[30]; Type: Text; "Count": Integer; Tag: Text; "Auth Action": Text; Validity: DateTime; ClearValidity: Boolean) Response: Text
    var
        SkyAgencyAuth: Record "Sky Agency Auth";
        SavAcc: Record "Savings Accounts";



        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
    begin
        /*
        Possible Auth Types:
        ---------------------------
        LOGIN
        OTP
        ---------------------------
        */

        /*-------------------------------------------------------------------------------------*/
        Status := 'SUCCESS';
        /*
        Possible Response Statuses:
        ---------------------------
        SUCCESS
        ERROR
        NOT_FOUND
        ---------------------------
        */
        ResponseTitle := 'Update Authentication Attempts';
        ResponseMessage := 'Update Authentication Attempts';
        /*-------------------------------------------------------------------------------------*/


        Status := 'ERROR';

        SkyAgencyAuth.Reset;
        SkyAgencyAuth.SetRange(SkyAgencyAuth.Username, Username);
        if SkyAgencyAuth.FindFirst then begin
            if (Type = 'LOGIN') then begin
                SkyAgencyAuth."Login Attempts Action" := "Auth Action";
                SkyAgencyAuth."Login Attempts Count" := Count;
                SkyAgencyAuth."Login Attempts Tag" := Tag;
                if (ClearValidity) then begin
                    Clear(SkyAgencyAuth."Login Attempts Action Expiry");
                end
                else begin
                    SkyAgencyAuth."Login Attempts Action Expiry" := Validity;
                end;
                SkyAgencyAuth.Modify;
                Status := 'SUCCESS';
            end;
            if (Type = 'OTP') then begin
                SkyAgencyAuth."OTP Attempts Action" := "Auth Action";
                SkyAgencyAuth."OTP Attempts Count" := Count;
                SkyAgencyAuth."OTP Attempts Tag" := Tag;
                if (ClearValidity) then begin
                    Clear(SkyAgencyAuth."OTP Attempts Action Expiry");
                end
                else begin
                    SkyAgencyAuth."OTP Attempts Action Expiry" := Validity;
                end;
                SkyAgencyAuth.Modify;
                Status := 'SUCCESS';
            end;
        end
        else begin
            Status := 'NOT_FOUND';
        end;

        /*-------------------------------------------------------------------------------------*/


    end;


    procedure GetUserLoginAttemptExpiry("Action": Code[30]; Indent: Boolean; Username: Code[30]; Type: Text) Response: Text
    var
        SkyAgencyAuth: Record "Sky Agency Auth";
        CurrentTime: DateTime;



        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        ExpiryDate: DateTime;
    begin
        /*
        Possible Auth Types:
        ---------------------------
        LOGIN
        OTP
        ---------------------------
        */




        /*-------------------------------------------------------------------------------------*/
        Status := 'SUCCESS';
        /*
        Possible Response Statuses:
        ---------------------------
        SUCCESS
        ERROR
        NOT_FOUND
        ---------------------------
        */
        ResponseTitle := 'Update Authentication Attempts';
        ResponseMessage := 'Update Authentication Attempts';
        /*-------------------------------------------------------------------------------------*/


        Status := 'ERROR';

        ExpiryDate := CurrentDatetime;

        SkyAgencyAuth.Reset;
        SkyAgencyAuth.SetRange(SkyAgencyAuth.Username, Username);
        if SkyAgencyAuth.FindFirst then begin
            if (Type = 'LOGIN') then begin
                ExpiryDate := SkyAgencyAuth."Login Attempts Action Expiry";
            end;
            if (Type = 'OTP') then begin
                ExpiryDate := SkyAgencyAuth."OTP Attempts Action Expiry";
            end;
        end;


        Clear(JsObject_1);
        JsObject_1.Add('expiry_date', ExpiryDate);
        JsonResult.Add('data', JsObject_1);

        /*-------------------------------------------------------------------------------------*/


    end;


    procedure GetUserLoginAttemptAction("Action": Code[30]; Indent: Boolean; Username: Code[30]; Type: Text) Response: Code[10]
    var
        SkyAgencyAuth: Record "Sky Agency Auth";



        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
    begin
        Response := '';

        SkyAgencyAuth.Reset;
        SkyAgencyAuth.SetRange(SkyAgencyAuth.Username, Username);
        if SkyAgencyAuth.FindFirst then begin
            if (Type = 'LOGIN') then begin
                if (SkyAgencyAuth."Login Attempts Action" = 'SUSPEND') then begin
                    if (SkyAgencyAuth."Login Attempts Action Expiry" > CurrentDatetime) then begin
                        Response := 'SUSPENDED'
                    end;
                end;
            end;
            if (Type = 'OTP') then begin
                if (SkyAgencyAuth."OTP Attempts Action" = 'SUSPEND') then begin
                    if (SkyAgencyAuth."OTP Attempts Action Expiry" > CurrentDatetime) then begin
                        Response := 'SUSPENDED'
                    end;
                end;
            end;
        end;
    end;


    procedure GetUserLoginAttemptCount("Action": Code[30]; Indent: Boolean; Username: Code[30]; Type: Text) Response: Integer
    var
        SkyAgencyAuth: Record "Sky Agency Auth";



        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
    begin
        Response := 0;
        SkyAgencyAuth.Reset;
        SkyAgencyAuth.SetRange(SkyAgencyAuth.Username, Username);
        if SkyAgencyAuth.FindFirst then begin
            if (Type = 'LOGIN') then begin
                Response := SkyAgencyAuth."Login Attempts Count";
            end;
            if (Type = 'OTP') then begin
                Response := SkyAgencyAuth."OTP Attempts Count";
            end;
        end
        else begin
            Response := 0;
        end;
    end;


    procedure TestFunction()
    var
        AgentTariffHeader: Record "Agent Tarriff Header";
    begin
        AgentTariffHeader.Reset;
        AgentTariffHeader.SetRange("Transaction Type", AgentTariffHeader."transaction type"::Withdrawal);
        if AgentTariffHeader.FindFirst then begin
            repeat
                Message('I was here');
            until AgentTariffHeader.Next = 0;
        end;
    end;


    procedure GetUnhashedPINs() Response: Text
    var
        SkyAuth: Record "Sky Agency Auth";
    begin
        Response := 'ERROR';

        SkyAuth.Reset;
        SkyAuth.SetRange(SkyAuth."PIN Encrypted", false);
        if SkyAuth.FindFirst then begin
            Response := '<ACCOUNTS>';
            repeat
                Response += '<ACCOUNT USERNAME="' + SkyAuth.Username + '" AGENT_CODE="' + SkyAuth."Agent Code" + '" PASSWORD="' + SkyAuth.Password + '"/>'
            until SkyAuth.Next = 0;
            Response += '</ACCOUNTS>';
        end
        else begin
            Response := '<ACCOUNTS/>';
        end;
    end;


    procedure SetHashedPIN(Username: Text; AgentCode: Text; Password: Text) Response: Text
    var
        SkyAuth: Record "Sky Agency Auth";
        MobileNo: Text;
    begin
        Response := 'ERROR';
        SkyAuth.Reset;
        SkyAuth.SetRange(SkyAuth."PIN Encrypted", false);
        SkyAuth.SetRange(SkyAuth.Username, Username);
        SkyAuth.SetRange(SkyAuth."Agent Code", AgentCode);
        if SkyAuth.Find('-') then begin
            SkyAuth.Password := Password;
            SkyAuth."PIN Encrypted" := true;
            SkyAuth.Modify;
            Response := 'SUCCESS';
        end
        else begin
            Response := 'NOT_FOUND';
        end;
    end;


    procedure RegisterVirtualMember("Action": Text; Indent: Boolean; Name: Text; "National ID Number": Text; "Mobile Number": Text; "Date of Birth": Date; "Entry Number": Text; SessionID: Text; DateFormatted: Text; AgentCode: Code[30]; "Postall Address": Text; "Employment Status": Text; Employer: Text; Region: Text; "Transaction Date": Date) Response: Text
    var

        SavAcc: Record "Savings Accounts";
        MobileNo: Text;
        VirtualMemberRegBuffer: Record "Virtual Member Reg Buffer";
        RefereeMobileNo: Text;
        SMS: Text;
        SMSToDestination: Text;
        Source: Enum "SMS Source Enum";
        Sky: Codeunit "Sky MBanking";




        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        PrintText: Text;
        CompanyInformation: Record "Company Information";
        AgentAplication: Record "Agent Applications";
    begin





        /*-------------------------------------------------------------------------------------*/
        Status := 'ERROR';
        /*
        Possible Response Statuses:
        ---------------------------
        SUCCESS
        MEMBER_EXISTS
        ENTRY_EXISTS
        ERROR
        ---------------------------
        */
        AgentAplication.Get(AgentCode);
        ResponseTitle := 'ERROR';
        ResponseMessage := 'Member registration has failed';
        /*-------------------------------------------------------------------------------------*/



        Status := 'ERROR';
        ResponseTitle := 'ERROR';
        MobileNo := '+' + "Mobile Number";
        RefereeMobileNo := AgentAplication."Mobile No";
        VirtualMemberRegBuffer.Reset;
        VirtualMemberRegBuffer.SetRange(VirtualMemberRegBuffer."Mobile Number", MobileNo);
        VirtualMemberRegBuffer.SetRange(VirtualMemberRegBuffer."Entry Number", "Entry Number");
        if not VirtualMemberRegBuffer.Find('-') then begin
            SavAcc.Reset;
            SavAcc.SetRange(SavAcc."Mobile Phone No.", MobileNo);
            if not VirtualMemberRegBuffer.Find('-') then begin
                VirtualMemberRegBuffer.Reset;
                VirtualMemberRegBuffer."Entry Number" := "Entry Number";
                VirtualMemberRegBuffer."Date Created" := CurrentDatetime;
                VirtualMemberRegBuffer.Name := Name;
                VirtualMemberRegBuffer."Mobile Number" := MobileNo;
                VirtualMemberRegBuffer."National ID Number" := "National ID Number";
                VirtualMemberRegBuffer."Date of Birth" := "Date of Birth";
                VirtualMemberRegBuffer."Employment Status" := "Employment Status";
                VirtualMemberRegBuffer.Employer := Employer;
                VirtualMemberRegBuffer.Region := Region;
                VirtualMemberRegBuffer."Transaction Date" := Today;
                VirtualMemberRegBuffer."Agent Code" := AgentCode;
                VirtualMemberRegBuffer."Postal Address" := "Postall Address";

                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Mobile Phone No.", RefereeMobileNo);
                if SavAcc.Find('-') then begin
                    VirtualMemberRegBuffer."Referee Name" := SavAcc.Name;
                    VirtualMemberRegBuffer."Referee Member Number" := SavAcc."Member No.";
                    SMS := 'Dear ' + SavAcc.Name + ', the member registration details you submitted have been received. Entry No.: ' + "Entry Number";
                    Sky.SendSms(Source::"Sky Agency", SavAcc."Mobile Phone No.", SMS, "Entry Number", '', false, 211, false);

                    SMSToDestination := 'Dear ' + Name + ', ' + SavAcc.Name + ' has submitted your details for SACCO membership. Entry No.: ' + "Entry Number";
                    Sky.SendSms(Source::"Sky Agency", "Mobile Number", SMSToDestination, "Entry Number", '', false, 211, false);
                end
                else begin
                    VirtualMemberRegBuffer."Referee Name" := '';
                    VirtualMemberRegBuffer."Referee Member Number" := '';
                    SMSToDestination := 'Dear ' + Name + ', self registration details you submitted have been received. Entry No.: ' + "Entry Number";
                    Sky.SendSms(Source::"Sky Agency", "Mobile Number", SMSToDestination, "Entry Number", '', false, 211, false);
                end;

                VirtualMemberRegBuffer.Insert;
                ResponseTitle := 'SUCCESS';
                Status := 'SUCCESS';
                ResponseMessage := 'Member has been registered succesfully';

                CompanyInformation.Get;
                AgentAplication.Get(AgentCode);

                PrintText := '';
                PrintText += '<logo/>';
                PrintText += '<br/>' + CompanyInformation.Name;
                PrintText += '<br/>';
                PrintText += '<hr/>';
                PrintText += '<br/>Center: ' + CompanyInformation."Phone No.";
                PrintText += '<br/>Center: ' + CompanyInformation."E-Mail";
                PrintText += '<br/>';
                PrintText += '<hr/>';
                PrintText += '<br/>Title: Member Registration';
                PrintText += '<br/>';
                PrintText += '<hr/>';
                PrintText += '<br/>Agency: ' + AgentAplication."Name of the Proposed Agent";
                PrintText += '<br/>Location: ' + AgentAplication."Place of Business";
                PrintText += '<br/>Agent ID: ' + AgentAplication."Agent Code";
                PrintText += '<br/>Operator: ' + AgentAplication.Name;
                PrintText += '<br/>';
                PrintText += '<hr/>';
                PrintText += '<br/>Customer';
                PrintText += '<br/>Name: ' + Name;
                PrintText += '<br/>Phone Number: ' + "Mobile Number";
                PrintText += '<br/>ID Number: ' + "National ID Number";
                PrintText += '<br/>Date Of Birth: ' + Format("Date of Birth");
                PrintText += '<br/>Referee: ' + AgentCode;
                PrintText += '<br/>Employment Status: ' + "Employment Status";
                PrintText += '<br/>Region: ' + Region;
                PrintText += '<br/>Postal Address: ' + "Postall Address";
                PrintText += '<br/>';
                PrintText += '<hr/>';
                PrintText += '<br/>Reference: ' + "Entry Number";
                PrintText += '<br/>Date: ' + DateFormatted;
                PrintText += '<br/>';
                PrintText += '<hr/>';
                PrintText += '<br/>Footer: Thank you for banking with us';
                PrintText += '<br/>Barcode: ' + "Entry Number";
            end
            else begin
                Status := 'MEMBER_EXISTS';
                ResponseTitle := 'MEMBER_EXISTS';
                ResponseMessage := 'Member Exists';
            end;
        end
        else begin
            Status := 'ENTRY_EXISTS';
            ResponseTitle := 'ENTRY_EXISTS';
            ResponseMessage := 'Entry exists';
        end;


        Clear(JsObject_4);
        Clear(JsObject_1);

        JsObject_1.Add('print', PrintText);



        JsObject_4.Add('title', ResponseTitle);
        JsObject_4.Add('message', ResponseMessage);
        JsObject_4.Add('data', JsObject_1);

        JsObject_5.Add('action', 'VIRTUAL_REGISTRATION');
        JsObject_5.Add('status', Status);
        JsObject_5.Add('payload', JsObject_4);

        JsonResult.Add('response', JsObject_5);

        JsonResult.WriteTo(Response);






        /*-------------------------------------------------------------------------------------*/


    end;


    procedure UpdateVirtualMemberRegistration("Action": Text; "Image Entry Number": Text; "Image Path": Text; "Registration Entry Number": Text; "Image Type": Text; Indent: Boolean) Response: Text
    var
        VirtualMemberRegImages: Record "Virtual Member Reg Images";
        MobileNo: Text;
        VirtualMemberRegBuffer: Record "Virtual Member Reg Buffer";
        RefereeMobileNo: Text;



        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
    begin





        /*-------------------------------------------------------------------------------------*/
        Status := 'ERROR';
        /*
        Possible Response Statuses:
        ---------------------------
        SUCCESS
        MEMBER_EXISTS
        ENTRY_EXISTS
        ERROR
        ---------------------------
        */
        ResponseTitle := 'ERROR';
        ResponseMessage := 'Member registration has failed';
        /*-------------------------------------------------------------------------------------*/


        Status := 'ERROR';
        ResponseTitle := 'ERROR';

        Response := 'ERROR';
        VirtualMemberRegBuffer.Reset;
        VirtualMemberRegBuffer.SetRange(VirtualMemberRegBuffer."Entry Number", "Registration Entry Number");
        if VirtualMemberRegBuffer.Find('-') then begin
            VirtualMemberRegImages.Reset;
            VirtualMemberRegImages."Image Entry Number" := "Image Entry Number";
            VirtualMemberRegImages."Image Path" := "Image Path";
            VirtualMemberRegImages.Type := "Image Type";

            VirtualMemberRegImages."Registration Entry Number" := "Registration Entry Number";
            VirtualMemberRegImages.Modify;
            ResponseTitle := 'SUCCESS';
            Response := 'SUCCESS';
            ResponseMessage := 'Update was a success';
            Status := 'SUCCESS';
        end
        else begin
            Response := 'ENTRY_DOES_NOT_EXIST';
            ResponseTitle := 'ENTRY_DOES_NOT_EXIST';
            ResponseMessage := 'The entry does not exist';
            Status := 'ENTRY_DOES_NOT_EXIST';
        end;








        /*-------------------------------------------------------------------------------------*/


    end;


    procedure GetVirtualMemberRegistrationImagesPath() Response: Text
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        // GeneralLedgerSetup.GET;
        // GeneralLedgerSetup.TESTFIELD("Virtual Members Images Path");
        // Response := GeneralLedgerSetup."Virtual Members Images Path";
    end;


    procedure PerformAgentTransaction("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text; AgentDebitNumber: Text; DebitAccountType: Text; AgentCreditNumber: Text; TransactionSessionID: Text; TransactionAmount: Decimal; TransactionAmountStylized: Text; TransactionStatementCount: Integer; TransactionNarration: Text; TransactionDate: Text; TransactionPrintReceipt: Boolean; DeviceIMEI: Text; DeviceSerialNumber: Text) Response: Text
    var



        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        PrintData: Text;
        DisplayData: Text;
        SMSData: Text;
        hr: label '<hr/>';
        br: label '<br/>';
        logo: label '<logo/>';
        cdata_open: label '<![CDATA[';
        cdata_close: label ']]>';
        TransactionAccountText: Text;
        TransactionText: Text;
        StatementText: Text;
        Iterator: Integer;
        LineBreak: Text;
        SkyAgencyAuth: Record "Sky Agency Auth";
        SavingsAccounts: Record "Savings Accounts";
        SkyAgentsTransactions: Record "Sky Agents Transactions";
        AgentTariffHeader: Record "Agent Tarriff Header";
        SafcomFee: Decimal;
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        PrePaymentGL: Code[30];
        SMSAccount: Code[30];
        AmountTransacted: Decimal;
        Type: Option Daily,Weekly,Monthly;
        Limit: Decimal;
        TotalCharge: Decimal;
        ExciseDuty: Decimal;
        ExciseDutyRate: Decimal;
        ExciseDutyGL: Code[30];
        TransType: Option ,CASH_WITHDRAWAL,CASH_DEPOSIT,ACCOUNT_BALANCE,ACCOUNT_STATEMENT,LOAN_REPAYMENT;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        AgentAplication: Record "Agent Applications";
        Members: Record Members;
        MemberNumber: Code[30];
        Vendor: Record "Savings Accounts";
        SkyAgencyCompanies: Record "Sky Agency Companies";
        SkyAgencyDevices: Record "Sky Agency Devices";
        CompanyInformation: Record "Company Information";
        AgentCode: Code[30];
        AgentCommisionAccNumber: Code[30];
        AgentTariffDetails: Record "Agent Tariff Details";
        AgentComm: Decimal;
        SaccoAcc: Code[30];
        VendorCommAcc: Code[30];
        RequiresApproval: Boolean;
        SkyAgentTransfer: Record "Sky Agent Transfer";
        AgentName: Text;
        AgentMemberNumber: Text;
    begin




        /*-------------------------------------------------------------------------------------*/
        Status := 'SUCCESS';
        RequiresApproval := false;
        /*
        Possible Response Statuses:
        ---------------------------
        SUCCESS
        ERROR
        FAILED
        LIMIT_EXEEDED
        BLOCKED
        ---------------------------
        Possible Transaction Types:
        CASH_WITHDRAWAL
        CASH_DEPOSIT
        ACCOUNT_BALANCE
        ACCOUNT_STATEMENT
        LOAN_PAYMENT
        */


        ResponseTitle := 'Agent Transaction';
        ResponseMessage := 'Dear user, an error occured while processing your request, kindly try again later.';
        /*-------------------------------------------------------------------------------------*/

        //Member number



        if AgentAplication.Get(AgentUsername) then begin
            ResponseMessage := 'Transaction Succesful';
            Status := 'SUCCESS';
            AgentName := AgentAplication."Name of the Proposed Agent";
            SavingsAccounts.Get(AgentAplication.Account);
            AgentMemberNumber := SavingsAccounts."Member No.";
            AgentCode := AgentAplication."Agent Code";
        end else begin
            ResponseMessage := 'Incorrect Username or Password';
            Status := 'FAILED';
        end;

        DebitAccountType := 'VENDOR';
        if SavingsAccounts.Get(AgentDebitNumber) then begin
            DebitAccountType := 'SAVINGS';
        end;

        //If agents want to move money from untility to FOSA then a manual posting is required
        if SavingsAccounts.Get(AgentDebitNumber) then begin
            if SavingsAccounts."Product Type" = '512' then begin
                RequiresApproval := true;
            end;
        end;

        if AgentTariffHeader.Get('TRANSFER') then begin
            SkyAgentsTransactions.Reset;
            SkyAgentsTransactions.SetRange("Transaction ID", TransactionSessionID);
            if SkyAgentsTransactions.FindFirst then begin
                ResponseMessage := 'Transaction exists.';
                Status := 'FAILED';
            end;
            if RequiresApproval then begin
                SkyAgentTransfer.Reset;
                SkyAgentTransfer.SetRange("Transaction ID", TransactionSessionID);
                if SkyAgentTransfer.FindFirst then begin
                    ResponseMessage := 'Transaction exists.';
                    Status := 'FAILED';
                end;
            end;
        end;

        if DebitAccountType = 'VENDOR' then begin
            Vendor.Get(AgentDebitNumber);
            if Status = 'SUCCESS' then begin
                if (Vendor.Blocked = Vendor.Blocked::All) or (Vendor.Blocked = Vendor.Blocked::Payment) then begin
                    ResponseMessage := 'Your account account is blocked Acc No: ' + Vendor."No.";
                    Status := 'BLOCKED';
                end;
            end;
            Vendor.CalcFields("Balance (LCY)");
            if Status = 'SUCCESS' then begin
                if TransactionAmount > Vendor."Balance (LCY)" then begin
                    ResponseMessage := 'Insufficient Balance';
                    Status := 'FAILED';
                end;
            end;
        end else begin
            SavingsAccounts.Get(AgentDebitNumber);
            if Status = 'SUCCESS' then begin
                if (SavingsAccounts.Status <> SavingsAccounts.Status::Active) or (SavingsAccounts.Blocked = SavingsAccounts.Blocked::All) then begin
                    ResponseMessage := 'Your account account is blocked Acc No: ' + SavingsAccounts."No.";
                    Status := 'BLOCKED';
                end;
            end;
            SavingsAccounts.CalcFields("Balance (LCY)");
            if Status = 'SUCCESS' then begin
                if TransactionAmount > SavingsAccounts."Balance (LCY)" then begin
                    ResponseMessage := 'Insufficient Balance';
                    Status := 'FAILED';
                end;
            end;
        end;
        SavingsAccounts.Get(AgentCreditNumber);
        if Status = 'SUCCESS' then begin
            if (SavingsAccounts.Status <> SavingsAccounts.Status::Active) or (SavingsAccounts.Blocked = SavingsAccounts.Blocked::All) then begin
                ResponseMessage := 'Your account account is blocked Acc No: ' + SavingsAccounts."No.";
                Status := 'BLOCKED';
            end;
        end;

        if Status = 'SUCCESS' then begin
            if RequiresApproval then begin
                SkyAgentTransfer.Init;
                SkyAgentTransfer."Entry No." := CreateGuid;
                SkyAgentTransfer."Agent Code" := AgentUsername;
                SkyAgentTransfer."Transaction ID" := TransactionSessionID;
                SkyAgentTransfer."Session ID" := TransactionSessionID;
                SkyAgentTransfer."Transaction Type" := SkyAgentsTransactions."transaction type"::InternalAgentTransfer;
                SkyAgentTransfer.Description := CopyStr(TransactionNarration, 1, 50);
                SkyAgentTransfer."Transaction Date" := Dt2Date(CurrentDatetime);
                SkyAgentTransfer."Transaction Time" := Dt2Time(CurrentDatetime);
                SkyAgentTransfer."Agent From Account" := AgentDebitNumber;
                SkyAgentTransfer."Agent To Account" := AgentCreditNumber;
                SkyAgentTransfer."Member No" := AgentMemberNumber;
                SkyAgentTransfer.Amount := TransactionAmount;
                SkyAgentTransfer."Agent Name" := AgentName;
                SkyAgentTransfer."Debit Account Type" := DebitAccountType;
                SkyAgentTransfer."Loan No." := '';
                SkyAgentTransfer.Insert;
                PostAgentTransaction(TransactionSessionID);
            end else begin
                //Insert into agency transactions
                SkyAgentsTransactions.Init;
                SkyAgentsTransactions."Entry No." := CreateGuid;
                SkyAgentsTransactions."Agent Code" := AgentUsername;
                SkyAgentsTransactions."Transaction ID" := TransactionSessionID;
                SkyAgentsTransactions."Session ID" := TransactionSessionID;
                SkyAgentsTransactions."Transaction Type" := SkyAgentsTransactions."transaction type"::InternalAgentTransfer;
                SkyAgentsTransactions.Description := CopyStr(TransactionNarration, 1, 50);
                SkyAgentsTransactions."Transaction Date" := Dt2Date(CurrentDatetime);
                SkyAgentsTransactions."Transaction Time" := Dt2Time(CurrentDatetime);
                SkyAgentsTransactions."Agent From Account" := AgentDebitNumber;
                SkyAgentsTransactions."Agent To Account" := AgentCreditNumber;
                SkyAgentsTransactions."Member No" := MemberNumber;
                SkyAgentsTransactions.Amount := TransactionAmount;
                SkyAgentsTransactions."Debit Account Type" := DebitAccountType;
                SkyAgentsTransactions."Loan No." := '';
                SkyAgentsTransactions.Insert;

                //post transaction
                PostAgentTransaction(TransactionSessionID)
            end;
        end;
        if (RequiresApproval) and (Status = 'SUCCESS') then
            ResponseMessage := 'Your request to transfer float was received successfully. Please contact your account Manager to finalise the transaction';










        /*-------------------------------------------------------------------------------------*/


    end;


    procedure PostAgentTransaction(TrandsactionID: Code[30]): Boolean
    var
        SkyAgentsTransactions: Record "Sky Agents Transactions";
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
        Dim1: Code[20];
        Dim2: Code[20];
        SystCreated: Boolean;
        GenSetup: Record "Sacco Setup";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        SaccoTrans: Codeunit "Sacco Activities";
        SavAcc: Record "Savings Accounts";
        TransAmt: Decimal;
        LoanNo: Code[30];
        SkyAgentTransfer: Record "Sky Agent Transfer";
        DimID: Integer;
    begin
        JTemplate := 'GENERAL';
        JBatch := 'DEFAULT';
        SaccoTrans.JournalInit(JBatch, JTemplate);

        SkyAgentsTransactions.Reset;
        SkyAgentsTransactions.SetRange("Transaction ID", TrandsactionID);
        SkyAgentsTransactions.SetRange(Posted, false);
        if SkyAgentsTransactions.FindFirst then begin
            DocNo := SkyAgentsTransactions."Transaction ID";
            PDate := SkyAgentsTransactions."Transaction Date";

            SavAcc.Get(SkyAgentsTransactions."Agent To Account");
            ExtDoc := '';
            TransType := Transtype::" ";
            Dim1 := SavAcc."Global Dimension 1 Code";
            Dim2 := SavAcc."Global Dimension 2 Code";
            DimID := SavAcc."Dimension Set ID";

            SystCreated := true;
            TransAmt := SkyAgentsTransactions.Amount;
            LoanNo := '';
            TChannel := TChannel::Agency;

            //Debit member account
            AcctType := Accttype::Savings;
            if SkyAgentsTransactions."Debit Account Type" = 'VENDOR' then AcctType := Accttype::Savings;
            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType, SkyAgentsTransactions."Agent From Account",
            CopyStr(SkyAgentsTransactions.Description, 1, 50), Balacctype::"G/L Account", '', TransAmt, ExtDoc, LoanNo, TransType,
            Dim1, Dim2, SystCreated, TChannel, DimID);


            //Credit agent account
            AcctType := Accttype::Savings;
            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType, SkyAgentsTransactions."Agent To Account",
            CopyStr(SkyAgentsTransactions.Description, 1, 50), Balacctype::"G/L Account", '', -TransAmt, ExtDoc, LoanNo, TransType,
            Dim1, Dim2, SystCreated, TChannel, DimID);


            SaccoTrans.JournalPost(JTemplate, JBatch);
            SkyAgentsTransactions.Posted := true;

            SkyAgentsTransactions."Posted By" := UserId;
            SkyAgentsTransactions."Date Posted" := Today;
            SkyAgentsTransactions."Time Posted" := Time;
            SkyAgentsTransactions.Modify;
            exit(true);
        end else begin
            SkyAgentTransfer.Reset;
            SkyAgentTransfer.SetRange("Transaction ID", TrandsactionID);
            SkyAgentTransfer.SetRange(Posted, false);
            if SkyAgentTransfer.FindFirst then begin
                DocNo := SkyAgentTransfer."Transaction ID";
                PDate := SkyAgentTransfer."Transaction Date";

                SavAcc.Get(SkyAgentTransfer."Agent To Account");
                ExtDoc := '';
                TransType := Transtype::" ";
                Dim1 := SavAcc."Global Dimension 1 Code";
                Dim2 := SavAcc."Global Dimension 2 Code";
                SystCreated := true;
                TransAmt := SkyAgentTransfer.Amount;
                LoanNo := '';

                //Debit member account
                AcctType := Accttype::Savings;
                if SkyAgentTransfer."Debit Account Type" = 'VENDOR' then AcctType := Accttype::Vendor;
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType, SkyAgentTransfer."Agent From Account",
                CopyStr(SkyAgentTransfer.Description, 1, 50), Balacctype::"G/L Account", '', TransAmt, ExtDoc, LoanNo, TransType,
                Dim1, Dim2, SystCreated, TChannel::" ", DimID);


                //Credit agent account
                AcctType := Accttype::Savings;
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType, SkyAgentTransfer."Agent To Account",
                CopyStr(SkyAgentTransfer.Description, 1, 50), Balacctype::"G/L Account", '', -TransAmt, ExtDoc, LoanNo, TransType,
                Dim1, Dim2, SystCreated, TChannel, DimID);


                SaccoTrans.JournalPost(JTemplate, JBatch);
                SkyAgentTransfer.Posted := true;

                SkyAgentTransfer."Posted By" := UserId;
                SkyAgentTransfer."Date Posted" := Today;
                SkyAgentTransfer."Time Posted" := Time;
                SkyAgentTransfer.Modify;
                exit(true);
            end else
                exit(false);
        end;
    end;


    procedure AgentMinistatement(EntryCode: Code[30]; TransactionID: Code[20]; StartDate: Date; EndDate: Date; StatementAccount: Code[20]; Pin: Text; AgentUsername: Text) Response: Text
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        PhoneNo: Code[20];
        AccBal: Decimal;
        VendorRec: Record "Savings Accounts";
        JTemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit;
        BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit;
        TransType: Option " ",Loan,Repayment,"Interest Due","Interest Paid",Bills,Appraisal;
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
        FileName: Text;
        Stmt: Text;
        AccountToCharge: Code[20];
        MemberNo: Code[20];
        RCount: Integer;
        SkyAgencyAuth: Record "Sky Agency Auth";
        Status: Boolean;
        Vendor: Record "Savings Accounts";
        VendorLedgerEntry: Record "Savings Ledger Entry";
        SavingsAccounts: Record "Savings Accounts";
        TempFile: File;
    begin

        TransactionDate := CurrentDatetime;


        Response := '';
        Status := true;

        if not SkyAgencyAuth.Get(AgentUsername) then begin
            Response := 'INCORRECT_USERNAME';
            Response := '<Response>';
            Response += '<Status>AGENT_NOT_FOUND</Status>';
            Response += '<StatusDescription>Agent Not found</StatusDescription>';
            Response += '<Reference>' + TransactionID + '</Reference>';
            Response += '</Response>';
            Status := false;
        end;

        if Status then begin
            SkyAgencyAuth.Reset;
            SkyAgencyAuth.SetRange(Username, AgentUsername);
            SkyAgencyAuth.SetRange(Password, Pin);
            if not SkyAgencyAuth.FindFirst then begin
                Response := 'INCORRECT_PIN';
                Response := '<Response>';
                Response += '<Status>INCORRECT_PIN</Status>';
                Response += '<StatusDescription>Incorrect PIN</StatusDescription>';
                Response += '<Reference>' + TransactionID + '</Reference>';
                Response += '</Response>';
                Status := false;
            end;
        end;

        Response += '<Response>';
        if Status then begin
            if SavAcc.Get(StatementAccount) then begin
                SLedger.Reset;
                SLedger.SetRange("Account No.", SavAcc."No.");
                SLedger.SetFilter("Posting Date", '>=%1', StartDate);
                SLedger.SetFilter("Posting Date", '<=%1', EndDate);
                if SLedger.FindFirst then begin
                    //REPORT.RUN(52185948,FALSE,FALSE,SLedger);
                    FileName := 'O:\agent\' + TransactionID + '.pdf';
                    //////Report.SaveAsPdf(52185439, FileName, SLedger);
                    repeat
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange("No.", SLedger."Account No.");
                        SavingsAccounts.SetFilter("Date Filter", '..' + Format(EndDate));
                        if SavingsAccounts.FindFirst then begin
                            SavingsAccounts.CalcFields("Balance (LCY)");
                            AccBal := SavingsAccounts."Balance (LCY)";
                        end;
                        Response += '<Transaction>';
                        Response += '<Date>' + Format(SLedger."Posting Date") + '</Date>';
                        Response += '<Desc>' + SLedger.Description + '</Desc>';
                        Response += '<Amount>' + Format(SLedger.Amount * -1) + '</Amount>';
                        Response += '<Reference>' + Format(SLedger."Entry No.") + '</Reference>';
                        Response += '<RunningBalance>' + Format(AccBal) + '</RunningBalance>';
                        Response += '</Transaction>';

                    until SLedger.Next = 0;
                end;
            end else
                if Vendor.Get(StatementAccount) then begin
                    VendorLedgerEntry.Reset;
                    VendorLedgerEntry.SetRange("Account No.", Vendor."No.");
                    VendorLedgerEntry.SetFilter("Posting Date", '>=%1', StartDate);
                    VendorLedgerEntry.SetFilter("Posting Date", '<=%1', EndDate);
                    if VendorLedgerEntry.FindFirst then begin
                        repeat
                            VendorRec.Reset;
                            VendorRec.SetRange("No.", StatementAccount);
                            VendorRec.SetFilter("Date Filter", '..' + Format(EndDate));
                            if VendorRec.FindFirst then begin
                                VendorRec.CalcFields("Balance (LCY)");
                                AccBal := VendorRec."Balance (LCY)"
                            end;
                            Response += '<Transaction>';
                            Response += '<Date>' + Format(VendorLedgerEntry."Posting Date") + '</Date>';
                            Response += '<Desc>' + VendorLedgerEntry.Description + '</Desc>';
                            Response += '<Amount>' + Format(VendorLedgerEntry.Amount * -1) + '</Amount>';
                            Response += '<Reference>' + Format(VendorLedgerEntry."Entry No.") + '</Reference>';
                            Response += '<RunningBalance>' + Format(AccBal) + '</RunningBalance>';
                            Response += '</Transaction>';
                        until VendorLedgerEntry.Next = 0;
                    end;
                end else begin
                    Response := '<Response>';
                    Response += '<Status>INVALID_ACCOUNT</Status>';
                    Response += '<StatusDescription>Invalid Account</StatusDescription>';
                    Response += '<Reference>' + TransactionID + '</Reference>';
                end;
        end;
        Response += '</Response>';
    end;


    procedure AgentTransactions(EntryCode: Code[30]; TransactionID: Code[20]; StartDate: Date; EndDate: Date; Pin: Text; AgentUsername: Text; TransactionType: Text) Response: Text
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        PhoneNo: Code[20];
        AccBal: Decimal;
        VendorRec: Record "Savings Accounts";
        JTemplate: Code[10];
        JBatch: Code[10];
        SkyAgentsTransactions: Record "Sky Agents Transactions";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit;
        BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit;
        AccNo: Code[20];
        BalAccNo: Code[20];
        TransType: Option "None",Registration,Withdrawal,Deposit,LoanRepayment,Transfer,Sharedeposit,Schoolfeespayment,Balance,Ministatment,Paybill," Memberactivation",MemberRegistration,InternalAgentTransfer;
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
        FileName: Text;
        Stmt: Text;
        AccountToCharge: Code[20];
        MemberNo: Code[20];
        RCount: Integer;
        SkyAgencyAuth: Record "Sky Agency Auth";
        Status: Boolean;
        Vendor: Record "Savings Accounts";
        VendorLedgerEntry: Record "Savings Ledger Entry";
        SavingsAccounts: Record "Savings Accounts";
        TempFile: File;
    begin

        TransactionDate := CurrentDatetime;


        Response := '';
        Status := true;

        if not SkyAgencyAuth.Get(AgentUsername) then begin
            Response := 'INCORRECT_USERNAME';
            Response := '<Response>';
            Response += '<Status>AGENT_NOT_FOUND</Status>';
            Response += '<StatusDescription>Agent Not found</StatusDescription>';
            Response += '<Reference>' + TransactionID + '</Reference>';
            Response += '</Response>';
            Status := false;
        end;


        if Status then begin
            SkyAgencyAuth.Reset;
            SkyAgencyAuth.SetRange(Username, AgentUsername);
            SkyAgencyAuth.SetRange(Password, Pin);
            if not SkyAgencyAuth.FindFirst then begin
                Response := 'INCORRECT_PIN';
                Response := '<Response>';
                Response += '<Status>INCORRECT_PIN</Status>';
                Response += '<StatusDescription>Incorrect PIN</StatusDescription>';
                Response += '<Reference>' + TransactionID + '</Reference>';
                Response += '</Response>';
                Status := false;
            end;
        end;

        Response += '<Response>';
        if Status then begin
            if TransactionType = 'CASH_WITHDRAWAL' then
                TransType := Transtype::Withdrawal
            else
                if TransactionType = 'CASH_DEPOSIT' then
                    TransType := Transtype::Deposit
                else
                    if TransactionType = 'ACCOUNT_BALANCE' then
                        TransType := Transtype::Balance
                    else
                        if TransactionType = 'ACCOUNT_STATEMENT' then
                            TransType := Transtype::Ministatment
                        else
                            if TransactionType = 'LOAN_PAYMENT' then
                                TransType := Transtype::LoanRepayment;

            SkyAgentsTransactions.Reset;
            SkyAgentsTransactions.SetRange("Transaction Type", TransType);
            SkyAgentsTransactions.SetRange(Posted, true);
            SkyAgentsTransactions.SetRange("Date Posted", StartDate, EndDate);
            if SkyAgentsTransactions.FindFirst then begin
                repeat

                    Response += '<Transaction>';
                    Response += '<Date>' + Format(SkyAgentsTransactions."Date Posted") + '</Date>';
                    Response += '<Desc>' + SkyAgentsTransactions.Description + '</Desc>';
                    Response += '<Amount>' + Format(SkyAgentsTransactions.Amount) + '</Amount>';
                    Response += '<Reference>' + Format(SkyAgentsTransactions."Entry No.") + '</Reference>';
                    Response += '</Transaction>';

                until SkyAgentsTransactions.Next = 0;
            end else begin
                Response += '<Status>NO_TRANSACTIONS_FOUND</Status>';
                Response += '<StatusDescription>No transactions found/StatusDescription>';
                Response += '<Reference>' + TransactionID + '</Reference>';

            end;
        end;
        Response += '</Response>';
    end;

    local procedure FormatDate(Date: Date) DateText: Text
    var
        Day: Integer;
        Month: Integer;
        Year: Integer;
        FormatedDate: Text;
        MonthText: Text;
    begin
        Month := Date2dmy(Date, 2);
        if Month = 1 then
            MonthText := 'Jan' else
            if Month = 2 then
                MonthText := 'Feb' else
                if Month = 3 then
                    MonthText := 'Mar' else
                    if Month = 4 then
                        MonthText := 'Apr'
                    else
                        if Month = 5 then
                            MonthText := 'May' else
                            if Month = 6 then
                                MonthText := 'Jun' else
                                if Month = 7 then
                                    MonthText := 'Jul' else
                                    if Month = 8 then
                                        MonthText := 'Aug'
                                    else
                                        if Month = 9 then
                                            MonthText := 'Sep' else
                                            if Month = 10 then
                                                MonthText := 'Oct' else
                                                if Month = 11 then
                                                    MonthText := 'Nov'
                                                else
                                                    if Month = 12 then MonthText := 'Dec';
        FormatedDate := Format(Date2dmy(Date, 1)) + ' ' + MonthText + ' ' + Format(Date2dmy(Date, 3));
        exit(FormatedDate);
    end;

    local procedure MaskFuction(Text: Text): Text
    var
        StringLength: Decimal;
        LoopTimes: Decimal;
        MaskedString: Text;
        Masks: Text;
        SubtractFigure: Decimal;
        DecimalPart: Decimal;
        IntegerPart: Decimal;
        IntegerDevided: Decimal;
    begin
        StringLength := StrLen(Text);
        SubtractFigure := 0.5 * StringLength;
        DecimalPart := (SubtractFigure MOD 1);
        IntegerPart := (SubtractFigure DIV 1);
        IntegerDevided := ((IntegerPart / 2) DIV 1);

        LoopTimes := StringLength - IntegerPart;
        LoopTimes += 1;
        MaskedString := CopyStr(Text, 1, (IntegerDevided));
        Masks := '';
        repeat
            Masks += '*';
            LoopTimes -= 1;
        until LoopTimes = 0;
        MaskedString := MaskedString + Masks + CopyStr(Text, StringLength - ((IntegerDevided) - 1), (IntegerDevided));
        exit(MaskedString);
    end;

    local procedure GetLoanBalance(LoanNo: Code[20]) Arreas: Decimal
    var
        MobileNo: Code[20];
        Loans: Record Loans;
        LoanProduct: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        MemberNo: Code[20];
        MaxLoan: Decimal;
        Found: Boolean;
        arrears: Decimal;
        balance: Decimal;
    begin
        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNo);
        if Loans.FindFirst then begin

            Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Total Arrears");
            if Loans."Outstanding Interest" < 0 then
                Loans."Outstanding Interest" := 0;

            Arreas := (Loans."Total Arrears");
            balance := (Loans."Outstanding Principal" + Loans."Outstanding Interest");
        end;
    end;

    local procedure GetLoanBalance2(LoanNo: Code[20]; var OutstandingBal: Decimal; var OutstandingInt: Decimal; var Arrears: Decimal)
    var
        MobileNo: Code[20];
        Loans: Record Loans;
        LoanProduct: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        MemberNo: Code[20];
        MaxLoan: Decimal;
        Found: Boolean;
        balance: Decimal;
    begin
        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNo);
        if Loans.FindFirst then begin

            Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Total Arrears");
            if Loans."Outstanding Interest" < 0 then
                Loans."Outstanding Interest" := 0;

            Arrears := (Loans."Total Arrears");
            OutstandingBal := Loans."Outstanding Principal";
            OutstandingInt := Loans."Outstanding Interest";
        end;
    end;


    procedure GetTransactionLimits("Action": Text; TransactionType: Text) Response: Text
    var
        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        Iterator: Integer;
        SkyAgencyAuth: Record "Sky Agency Auth";
        AgentCode: Code[30];
        SkySearchOptions: Record "Sky Search Options";
        AgentApplications: Record "Agent Applications";
        AgentTariffHeader: Record "Agent Tarriff Header";
        AgentTariffDetails: Record "Agent Tariff Details";
        MinAmount: Decimal;
        MaxAmount: Decimal;
        JSAccounts: JsonObject;
    begin



        /*-------------------------------------------------------------------------------------*/
        Status := 'SUCCESS';
        /*
        Possible Response Statuses:
        ---------------------------
        SUCCESS
        ERROR
        FAILED
        NOT_FOUND
        ---------------------------
        */
        ResponseTitle := 'Transaction Limits';
        ResponseMessage := 'Transaction Limits Fetched Successfully';
        /*-------------------------------------------------------------------------------------*/


        //LocalJsonTextWriter.WritePropertyName('data');



        if AgentTariffHeader.Get(TransactionType) then begin
            AgentTariffDetails.Reset;
            AgentTariffDetails.SetRange(Code, AgentTariffHeader.Code);
            if AgentTariffDetails.FindFirst then begin
                MinAmount := AgentTariffDetails."Lower Limit";
            end;
            AgentTariffDetails.Reset;
            AgentTariffDetails.SetRange(Code, AgentTariffHeader.Code);
            if AgentTariffDetails.FindLast then begin
                MaxAmount := AgentTariffDetails."Upper Limit";
            end;


            Clear(JsObject_1);
            JsObject_1.Add('minimum_amount', Format(MinAmount));
            JsObject_1.Add('maximum_amount', Format(MaxAmount));
            JsArray2.Add(JsObject_1);

        end else begin
            Status := 'FAILED';
            ResponseTitle := 'Transaction Limits';
            ResponseMessage := 'Transaction does not exist';
        end;

        //JsonResult.Add('transaction_limits', JsArray2);



        JSAccounts.Add('transaction_limits', JsArray2);


        JsObject_4.Add('title', ResponseTitle);
        JsObject_4.Add('message', ResponseMessage);
        JsObject_4.Add('data', JSAccounts);

        JsObject_5.Add('action', 'GET_AGENT_ACCOUNTS');
        JsObject_5.Add('status', Status);
        JsObject_5.Add('payload', JsObject_4);

        JsonResult.Add('response', JsObject_5);

        JsonResult.WriteTo(Response);




        /*-------------------------------------------------------------------------------------*/

    end;


    procedure GetAgentReport("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text; FromDate: Date; ToDate: Date) Response: Text
    var



        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        Iterator: Integer;
        SkyAgencyAuth: Record "Sky Agency Auth";
        AgentCode: Code[30];
        SavingsAccounts: Record "Savings Accounts";
        AgentApplication: Record "Agent Applications";
        ProductFactory: Record "Product Setup";
        Vendor: Record "Savings Accounts";
        SkyAgentsTransactions: Record "Sky Agents Transactions";
        TotalWithdrawals: Decimal;
        WithdrawalCount: Integer;
        TotalDeposits: Decimal;
        DepositsCount: Integer;
        LoanRepayments: Decimal;
        VendorLedgerEntry: Record "Savings Ledger Entry";
        CommOnAccBal: Decimal;
        CommOnLoanBal: Decimal;
        CommOnStatement: Decimal;
        TransactionType: Text;
        VenCommBal: Decimal;
        FloatBal: Decimal;
        TotalCredits: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        TotalDebits: Decimal;
        FileName: Text;
        TempBlob: Record CustomTempBlob;
        FileManagement: Codeunit "File Management";
        VariableBlobAT: Text;
        VariableBlobCW: Text;
        VariableBlobCD: Text;
        VariableBlobLR: Text;
        VariableBlobAB: Text;
        VariableBlobLB: Text;
        VariableBlobAS: Text;
        TotalDebitsAndCredits: Decimal;
        AgentAccountNo: Code[30];
    begin
        /*
        Possible Account Types:
        ---------------------------
        WITHDRAWABLE - Available during customer cash withdrawal
        DEPOSITABLE - Available during customer cash deposit
        ALL - Allagent accounts plus FOSA & BOSA
        TRANSFERRABLE_FROM - Available during agent float top up
        TRANSFERRABLE_TO - Available during agent float top up
        ---------------------------
        */




        /*-------------------------------------------------------------------------------------*/
        Status := 'SUCCESS';
        /*
        Possible Response Statuses:
        ---------------------------
        SUCCESS
        ERROR
        FAILED
        NOT_FOUND
        ---------------------------
        */
        ResponseTitle := 'Agent Report';
        ResponseMessage := 'Agent Report Fetched Successfully';
        /*-------------------------------------------------------------------------------------*/

        if AgentApplication.Get(AgentUsername) then begin
            ResponseMessage := 'Agent Found';
            Status := 'SUCCESS';
            //AgentCode := SkyAgencyAuth."Agent Code";
        end else begin
            ResponseMessage := 'Agent not found';
            Status := 'FAILED';
        end;



        //LocalJsonTextWriter.WritePropertyName('data');

        if Status = 'SUCCESS' then begin
            /*START: GENERATE REPORT*/
            SkyAgentsTransactions.Reset;
            SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
            SkyAgentsTransactions.SetRange(Posted, true);
            SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
            if SkyAgentsTransactions.FindFirst then begin
                FileName := 'C:\pdf\' + SkyAgentsTransactions."Agent Code" + 'AT.pdf';
                //////Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SkyAgentsTransactions);
                ////TempBlob.BLOBImportFromServerFile(TempBlob, FileName);
                VariableBlobAT := Format(TempBlob.ToBase64String);
            end;
            /*END  : GENERATE REPORT*/

            Clear(JsObject_1);
            JsObject_1.Add('id', 'ALL_TRANSACTIONS');
            JsObject_1.Add('title', 'All Transactions');
            JsObject_1.Add('caption', 'AT');
            JsObject_1.Add('pdf', VariableBlobAT);
            JsArray2.Add(JsObject_1);


            /*START: GENERATE REPORT*/
            SkyAgentsTransactions.Reset;
            SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
            SkyAgentsTransactions.SetRange(Posted, true);
            SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::Withdrawal);
            SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
            if SkyAgentsTransactions.FindFirst then begin
                FileName := 'C:\pdf\' + SkyAgentsTransactions."Agent Code" + 'CW.pdf';
                ////Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SkyAgentsTransactions);
                //TempBlob.BLOBImportFromServerFile(TempBlob, FileName);
                VariableBlobCW := Format(TempBlob.ToBase64String);
            end;
            /*END  : GENERATE REPORT*/

            Clear(JsObject_1);
            JsObject_1.Add('id', 'CASH_WITHDRAWAL');
            JsObject_1.Add('title', 'Cash Withdrawal');
            JsObject_1.Add('caption', 'CW');
            JsObject_1.Add('pdf', VariableBlobCW);
            JsArray2.Add(JsObject_1);


            /*START: GENERATE REPORT*/
            SkyAgentsTransactions.Reset;
            SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
            SkyAgentsTransactions.SetRange(Posted, true);
            SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::Deposit);
            SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
            if SkyAgentsTransactions.FindFirst then begin
                FileName := 'C:\pdf\' + SkyAgentsTransactions."Agent Code" + 'CD.pdf';
                ////Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SkyAgentsTransactions);
                //TempBlob.BLOBImportFromServerFile(TempBlob, FileName);
                VariableBlobCD := Format(TempBlob.ToBase64String);
            end;
            /*END  : GENERATE REPORT*/


            Clear(JsObject_1);
            JsObject_1.Add('id', 'CASH_DEPOSIT');
            JsObject_1.Add('title', 'Cash Deposit');
            JsObject_1.Add('caption', 'CD');
            JsObject_1.Add('pdf', VariableBlobCD);
            JsArray2.Add(JsObject_1);


            /*START: GENERATE REPORT*/
            SkyAgentsTransactions.Reset;
            SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
            SkyAgentsTransactions.SetRange(Posted, true);
            SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::LoanRepayment);
            SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
            if SkyAgentsTransactions.FindFirst then begin
                FileName := 'C:\pdf\' + SkyAgentsTransactions."Agent Code" + 'LR.pdf';
                ////Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SkyAgentsTransactions);
                //TempBlob.BLOBImportFromServerFile(TempBlob, FileName);
                VariableBlobLR := Format(TempBlob.ToBase64String);
            end;
            /*END  : GENERATE REPORT*/

            Clear(JsObject_1);
            JsObject_1.Add('id', 'LOAN_REPAYMENT');
            JsObject_1.Add('title', 'Loan Repayment');
            JsObject_1.Add('caption', 'LR');
            JsObject_1.Add('pdf', VariableBlobLR);
            JsArray2.Add(JsObject_1);


            /*START: GENERATE REPORT*/
            SkyAgentsTransactions.Reset;
            SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
            SkyAgentsTransactions.SetRange(Posted, true);
            SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::Balance);
            SkyAgentsTransactions.SetRange("Transaction Name", 'Account Balance Enquiry');
            SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
            if SkyAgentsTransactions.FindFirst then begin
                FileName := 'C:\pdf\' + SkyAgentsTransactions."Agent Code" + 'AB.pdf';
                ////Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SkyAgentsTransactions);
                //TempBlob.BLOBImportFromServerFile(TempBlob, FileName);
                VariableBlobAB := Format(TempBlob.ToBase64String);
            end;
            /*END  : GENERATE REPORT*/


            Clear(JsObject_1);
            JsObject_1.Add('id', 'ACCOUNT_BALANCE');
            JsObject_1.Add('title', 'Account Balance');
            JsObject_1.Add('caption', 'LR');
            JsObject_1.Add('pdf', VariableBlobAB);
            JsArray2.Add(JsObject_1);


            /*START: GENERATE REPORT*/
            SkyAgentsTransactions.Reset;
            SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
            SkyAgentsTransactions.SetRange(Posted, true);
            SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::Balance);
            SkyAgentsTransactions.SetRange("Transaction Name", 'Loan Balance Enquiry');
            SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
            if SkyAgentsTransactions.FindFirst then begin
                FileName := 'C:\pdf\' + SkyAgentsTransactions."Agent Code" + 'LB.pdf';
                ////Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SkyAgentsTransactions);
                //TempBlob.BLOBImportFromServerFile(TempBlob, FileName);
                VariableBlobLB := Format(TempBlob.ToBase64String);
            end;
            /*END  : GENERATE REPORT*/

            Clear(JsObject_1);
            JsObject_1.Add('id', 'LOAN_BALANCE');
            JsObject_1.Add('title', 'Loan Balance');
            JsObject_1.Add('caption', 'LR');
            JsObject_1.Add('pdf', VariableBlobLB);
            JsArray2.Add(JsObject_1);


            /*START: GENERATE REPORT*/
            SkyAgentsTransactions.Reset;
            SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
            SkyAgentsTransactions.SetRange(Posted, true);
            SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::Ministatment);
            SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
            if SkyAgentsTransactions.FindFirst then begin
                FileName := 'C:\pdf\' + SkyAgentsTransactions."Agent Code" + 'AS.pdf';
                ////Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SkyAgentsTransactions);
                //TempBlob.BLOBImportFromServerFile(TempBlob, FileName);
                VariableBlobAT := Format(TempBlob.ToBase64String);
            end;
            /*END  : GENERATE REPORT*/

            Clear(JsObject_1);
            JsObject_1.Add('id', 'ACCOUNT_STATEMENT');
            JsObject_1.Add('title', 'Account Statement');
            JsObject_1.Add('caption', 'AS');
            JsObject_1.Add('pdf', VariableBlobAS);
            JsArray2.Add(JsObject_1);
        end;
        JsObject_3.Add('tabs', JsArray2);


        if Status = 'SUCCESS' then begin

            SkyAgentsTransactions.Reset;
            SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
            SkyAgentsTransactions.SetRange(Posted, true);
            SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
            //SkyAgentsTransactions.SETFILTER("Date Posted",'<=%1',ToDate);
            if SkyAgentsTransactions.FindFirst then begin
                repeat
                    AgentAccountNo := SkyAgentsTransactions."Agent Account Number";
                    if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Withdrawal then begin
                        TotalWithdrawals += SkyAgentsTransactions.Amount;
                        WithdrawalCount += 1;
                    end else
                        if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Deposit then begin
                            TotalDeposits += SkyAgentsTransactions.Amount;
                            DepositsCount += 1;
                        end else
                            if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::LoanRepayment then begin
                                LoanRepayments += SkyAgentsTransactions.Amount;
                                //DepositsCount += 1;
                            end else
                                if (SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Balance) and (SkyAgentsTransactions."Transaction Name" = 'Account Balance Enquiry') then begin
                                    VendorLedgerEntry.Reset;
                                    VendorLedgerEntry.SetRange("Account No.", SkyAgentsTransactions."Agent Commision Account");
                                    VendorLedgerEntry.SetRange("Document No.", SkyAgentsTransactions."Transaction ID");
                                    if VendorLedgerEntry.FindFirst then begin
                                        VendorLedgerEntry.CalcFields(Amount);
                                        CommOnAccBal += VendorLedgerEntry.Amount;
                                    end;
                                end else
                                    if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Ministatment then begin
                                        VendorLedgerEntry.Reset;
                                        VendorLedgerEntry.SetRange("Account No.", SkyAgentsTransactions."Agent Commision Account");
                                        VendorLedgerEntry.SetRange("Document No.", SkyAgentsTransactions."Transaction ID");
                                        if VendorLedgerEntry.FindFirst then begin
                                            VendorLedgerEntry.CalcFields(Amount);
                                            CommOnStatement += VendorLedgerEntry.Amount;
                                        end;
                                    end else
                                        if (SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Balance) and (SkyAgentsTransactions."Transaction Name" = 'Loan Balance Enquiry') then begin
                                            VendorLedgerEntry.Reset;
                                            VendorLedgerEntry.SetRange("Account No.", SkyAgentsTransactions."Agent Commision Account");
                                            VendorLedgerEntry.SetRange("Document No.", SkyAgentsTransactions."Transaction ID");
                                            if VendorLedgerEntry.FindFirst then begin
                                                VendorLedgerEntry.CalcFields(Amount);
                                                CommOnLoanBal += VendorLedgerEntry.Amount;
                                            end;
                                        end;
                until SkyAgentsTransactions.Next = 0;
            end;
            SavingsLedgerEntry.Reset;
            SavingsLedgerEntry.SetRange("Account No.", AgentAccountNo);
            SavingsLedgerEntry.SetRange("Posting Date", FromDate, ToDate);
            if SavingsLedgerEntry.FindFirst then begin

                SavingsLedgerEntry.CalcSums("Credit Amount (LCY)", "Debit Amount (LCY)", "Amount (LCY)");
                TotalCredits += SavingsLedgerEntry."Credit Amount (LCY)";
                TotalDebits += SavingsLedgerEntry."Debit Amount (LCY)";
                TotalDebitsAndCredits := SavingsLedgerEntry."Amount (LCY)";

            end;


            Clear(JsArray2);
            Clear(JsObject_1);
            JsObject_1.Add('tabs', 'ALL_TRANSACTIONS');
            JsObject_1.Add('title', 'Total Credits');
            JsObject_1.Add('value', Abs(TotalCredits));
            JsObject_1.Add('type', 'currency');
            JsArray2.Add(JsObject_1);



            Clear(JsObject_1);
            JsObject_1.Add('tabs', 'CASH_WITHDRAWAL');
            JsObject_1.Add('title', 'Total Amount Withdrawn');
            JsObject_1.Add('value', Abs(TotalWithdrawals));
            JsObject_1.Add('type', 'currency');
            JsArray2.Add(JsObject_1);





            Clear(JsObject_1);
            JsObject_1.Add('tabs', 'CASH_WITHDRAWAL');
            JsObject_1.Add('title', 'Count of Withdrawals');
            JsObject_1.Add('value', WithdrawalCount);
            JsObject_1.Add('type', 'number');
            JsArray2.Add(JsObject_1);





            Clear(JsObject_1);
            JsObject_1.Add('tabs', 'CASH_DEPOSIT');
            JsObject_1.Add('title', 'Total Amount Deposited');
            JsObject_1.Add('value', TotalDeposits);
            JsObject_1.Add('type', 'currency');
            JsArray2.Add(JsObject_1);





            Clear(JsObject_1);
            JsObject_1.Add('tabs', 'LOAN_REPAYMENT');
            JsObject_1.Add('title', 'Total Loans Repaid');
            JsObject_1.Add('value', LoanRepayments);
            JsObject_1.Add('type', 'currency');
            JsArray2.Add(JsObject_1);






            Clear(JsObject_1);
            JsObject_1.Add('tabs', 'ACCOUNT_BALANCE');
            JsObject_1.Add('title', 'Total Commission Earned');
            JsObject_1.Add('value', Abs(CommOnAccBal));
            JsObject_1.Add('type', 'currency');
            JsArray2.Add(JsObject_1);








            Clear(JsObject_1);
            JsObject_1.Add('tabs', 'LOAN_BALANCE');
            JsObject_1.Add('title', 'Total Commission Earned');
            JsObject_1.Add('value', Abs(CommOnLoanBal));
            JsObject_1.Add('type', 'currency');
            JsArray2.Add(JsObject_1);


            Clear(JsObject_1);
            JsObject_1.Add('tabs', 'ACCOUNT_STATEMENT');
            JsObject_1.Add('title', 'Total Commission Earned');
            JsObject_1.Add('value', Abs(CommOnStatement));
            JsObject_1.Add('type', 'currency');
            JsArray2.Add(JsObject_1);


        end;
        JsObject_3.Add('statistics', JsArray2);


        SkyAgentsTransactions.Reset;
        SkyAgentsTransactions.SetCurrentkey("Date Posted", "Time Posted");
        SkyAgentsTransactions.SetAscending("Date Posted", false);
        SkyAgentsTransactions.SetAscending("Time Posted", false);
        SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
        SkyAgentsTransactions.SetRange(Posted, true);
        SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
        //SkyAgentsTransactions.SETFILTER("Date Posted",'<=%1',ToDate);
        if SkyAgentsTransactions.FindFirst then begin
            repeat
                if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Withdrawal then
                    TransactionType := 'CASH_WITHDRAWAL'
                else
                    if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Deposit then
                        TransactionType := 'CASH_DEPOSIT'
                    else
                        if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::LoanRepayment then
                            TransactionType := 'LOAN_REPAYMENT'
                        else
                            if (SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Balance) and (SkyAgentsTransactions."Transaction Name" = 'Account Balance Enquiry') then
                                TransactionType := 'ACCOUNT_BALANCE'
                            else
                                if (SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Balance) and (SkyAgentsTransactions."Transaction Name" = 'Loan Balance Enquiry') then
                                    TransactionType := 'LOAN_BALANCE'
                                else
                                    if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Ministatment then
                                        TransactionType := 'ACCOUNT_STATEMENT';


                Clear(JsObject_1);

                JsObject_1.Add('id', SkyAgentsTransactions."Transaction ID");
                JsObject_1.Add('type', TransactionType);
                JsObject_1.Add('date', FormatDate(SkyAgentsTransactions."Date Posted") + ' ' + Format(SkyAgentsTransactions."Time Posted"));
                JsObject_1.Add('description', SkyAgentsTransactions.Description);
                JsObject_1.Add('amount', SkyAgentsTransactions.Amount);
                JsObject_1.Add('currency', 'KES');



                Clear(JsArray4);
                Clear(JsObject_2);
                JsObject_2.Add('title', 'Customer');
                JsObject_2.Add('value', FormatName(SkyAgentsTransactions."Member No"));
                JsObject_2.Add('type', 'text');
                JsArray4.Add(JsObject_2);

                Clear(JsObject_2);
                JsObject_2.Add('title', 'Mobile Number');
                JsObject_2.Add('value', SkyAgentsTransactions."Mobile No.");
                JsObject_2.Add('type', 'text');
                JsArray4.Add(JsObject_2);

                VendorLedgerEntry.Reset;
                VendorLedgerEntry.SetRange("Account No.", SkyAgentsTransactions."Agent Commision Account");
                VendorLedgerEntry.SetFilter("Posting Date", '<=%1', SkyAgentsTransactions."Date Posted");
                if VendorLedgerEntry.FindFirst then begin
                    VenCommBal := 0;
                    repeat
                        VendorLedgerEntry.CalcFields(Amount);
                        //ERROR(FORMAT(VendorLedgerEntry.Amount));
                        VenCommBal += VendorLedgerEntry.Amount;
                    until VendorLedgerEntry.Next = 0;
                end;

                Clear(JsObject_2);
                JsObject_2.Add('title', 'Reference');
                JsObject_2.Add('value', SkyAgentsTransactions."Transaction ID");
                JsObject_2.Add('type', 'text');
                JsArray4.Add(JsObject_2);

                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("No.", SkyAgentsTransactions."Agent Account Number");
                SavingsAccounts.SetFilter("Date Filter", '..' + Format(SkyAgentsTransactions."Date Posted"));
                if SavingsAccounts.FindFirst then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    FloatBal := SavingsAccounts."Balance (LCY)";
                end;



                Clear(JsObject_2);
                JsObject_2.Add('title', 'Float Balance');
                JsObject_2.Add('value', FloatBal);
                JsObject_2.Add('type', 'currency');
                JsArray4.Add(JsObject_2);

            until SkyAgentsTransactions.Next = 0;
            JsObject_1.Add('display', JsArray4);

        end;

        JsonResult.Add('transactions', JsObject_1);


        Clear(JsObject_2);
        JsObject_2.Add('summary_total_amount', Format(Abs(TotalCredits) + Abs(TotalDebits)));
        JsObject_2.Add('transaction_total_amount', Format(Abs(TotalWithdrawals) + Abs(TotalDeposits) + Abs(LoanRepayments)));
        JsObject_2.Add('type', 'currency');

        Clear(JsObject_3);
        JsObject_3.Add('title', 'Total Credits');
        JsObject_3.Add('value', TotalCredits);
        JsObject_3.Add('color', '#109d58');
        JsArray3.Add(JsObject_3);


        Clear(JsObject_3);
        JsObject_3.Add('title', 'Total Debits');
        JsObject_3.Add('value', TotalDebits);
        JsObject_3.Add('color', '#dd4b39');
        JsArray3.Add(JsObject_3);
        JsObject_2.Add('summary_totals', JsArray3);


        Clear(JsArray3);
        Clear(JsObject_3);
        JsObject_3.Add('title', 'Total Withdrawals');
        JsObject_3.Add('value', TotalWithdrawals);
        JsObject_3.Add('color', '#651FFF');
        JsArray3.Add(JsObject_3);

        Clear(JsObject_3);
        JsObject_3.Add('title', 'Total Loan Repayments');
        JsObject_3.Add('value', LoanRepayments);
        JsObject_3.Add('color', '#FF6F00');
        JsArray3.Add(JsObject_3);
        JsObject_2.Add('transaction_totals', JsArray3)
        /*-------------------------------------------------------------------------------------*/




    end;


    procedure FormatName(MemberNo: Code[30]) MemberName: Text
    var
        Members: Record Members;
        NameWithoutSalutation: Text;
        Firstname: Text;
        SecondName: Text;
        ThirdName: Text;
    begin
        if Members.Get(MemberNo) then begin
            MemberName := Members."First Name" + ' ' + Members."Middle Name";

            if Members."First Name" = '' then
                MemberName := Members."Middle Name" + ' ' + Members.Surname

            else
                if Members."Middle Name" = '' then
                    MemberName := Members."First Name" + ' ' + Members.Surname

                else
                    if Members.Surname = '' then
                        MemberName := Members."First Name" + ' ' + Members."Middle Name"

                    else
                        if (Members."First Name" = '') and (Members."Middle Name" = '') then
                            MemberName := Members.Surname

                        else
                            if (Members."First Name" = '') and (Members.Surname = '') then
                                MemberName := Members."Middle Name"

                            else
                                if (Members."Middle Name" = '') and (Members.Surname = '') then
                                    MemberName := Members."First Name";
        end;
    end;

    local procedure GetLessAccountBal(AccountNo: Code[30]) Less: Decimal
    var
        ATMTransactions: Record "Coop ATM Transaction";
        MinimumBal: Decimal;
    begin
        MinimumBal := 1000;
        ATMTransactions.Reset;
        ATMTransactions.SetRange("Member Account", AccountNo);
        ATMTransactions.SetRange(Posted, false);
        ATMTransactions.SetRange(Reversed, false);
        if ATMTransactions.FindFirst then begin
            ATMTransactions.CalcSums(Amount);
            Less := ATMTransactions.Amount + MinimumBal;
        end;
    end;


}

