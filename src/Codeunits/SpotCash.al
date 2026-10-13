Codeunit 50115 "SpotCash Mbanking"
{
    trigger OnRun()
    var
        mobilePhoneNo: Text;
        responseCode: Text;
        responseMessage: Text;
        errorMessage: Text;
        LoanCode: Text;
        MemberNo: Code[10];
        Loans: Record Loans;
        ReQID: Text;
        transaction_type: Text;
        amount: Decimal;
        amount_str: text;
        empty_str: text;
        charge_str: text;
        Vendor: Record "Savings Accounts";
        FName: text;
        LName: Text;
        Location: Text;
        Genders: Text;
        IntroducerPhone: Text;
    begin

        //Sendsms.SendSms(Source::"Status Order",'0721431565',NewSMS,'0721431565','0721431565',FALSE);

        mobilePhoneNo := '+254704743396';
        errorMessage := '';
        LoanCode := 'L27';
        requestid := 'MANUAL0201';
        IntroducerPhone := '+254715545321';
        Acc := '00120800112631';
        transaction_type := '706';
        amount_str := '25000';
        charge_str := '0.0';
        //PostTransactions;
        SpotCash(requestid, mobilePhoneNo, transaction_type, amount_str, charge_str, Acc, empty_str, empty_str, requestid, empty_str, empty_str, empty_str, empty_str, empty_str, empty_str, empty_str, empty_str, empty_str, empty_str, empty_str);

        //GetNWDAccounts(mobilePhoneNo, responseCode, responseMessage, errorMessage);
        //SpotcashRegistration(responseCode,responseMessage,errorMessage,responseMessage);

        //ApplyLoan(requestid, mobilePhoneNo, LoanCode, 10000, 11, responseCode, responseMessage, errorMessage);
        //PostMobileLoan('{F03B9655-1CEE-4954-BA02-DBB74C0ED3C7}');

        //
        //BosaBalance('00320100105624',ProdCategory,MemberNo);
        //MESSAGE('%1\%2',MemberNo,ProdCategory);

        //FosaMiniStatement('00120800105624');//
        //MESSAGE('%1\%2\%3',responseCode,responseMessage,errorMessage);

        //PostMobileLoan(3);
        //PostMobileTransaction('SSPDSP20YYR36121');
        //PostMobileTransaction('SSPSP16QVZ71707');

        //ReferAFriend(FName, LName, mobilePhoneNo, Genders, Location, IntroducerPhone, responseCode, responseMessage, errorMessage);
        //

        //ThibitiEligibility('254721431565','INST4');

        //TestValidateFinancials();


        //ReQID:='SSPSP18WKD46284';
        //ProcessReversal(ReQID,responseCode,responseMessage,errorMessage);



        //GetSavingsAccounts(mobilePhoneNo, responseCode, responseMessage, errorMessage);
        //GetShareCapitalAccount(mobilePhoneNo,responseCode,responseMessage,errorMessage);
        //GetLoanAccounts(mobilePhoneNo,responseCode,responseMessage,errorMessage);
        //GetNWDAccounts(mobilePhoneNo,responseCode,responseMessage,errorMessage);
        //GeteLoanTypes(mobilePhoneNo,responseCode,responseMessage,errorMessage);
        //GetStatementTransactions(mobilePhoneNo,responseCode,responseMessage,errorMessage);

        //GetMemberEligibility(mobilePhoneNo, LoanCode, responseCode, responseMessage, errorMessage);
        //GetBranchCodes(responseCode,responseMessage,errorMessage);
        //ValidateAccountDetails(Acc, responseCode, responseMessage, errorMessage);

        //GetStatementTransactions('00066',20010101D,TODAY,TIME,TIME,'wachiraaziz@gmail.com');
        //CallSpotCash();
        Message('- %1\- %2 -%3', responseCode, responseMessage, errorMessage);

        //MESSAGE('%1',Registrations);
        //CallSpotCash;

        //for I := 1 to 15 do
        // PostDeposits;


        //PostMbanking.RUN;
        //PostMiniBalance('');
        //UpdateWithdrawalTransactions();

        //MESSAGE('%1',AccountBalance('0101-001-00059'));

        Message('Done');
    end;

    var
        ChargeCode: Code[20];
        Channel: Enum "Transaction Channel";
        SaccoActivity: Codeunit "Sacco Activities";
        I: Integer;
        Sky: Codeunit "Sky MBanking";
        Value: Decimal;
        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
        Acc: Text[20];
        JSonString: Text;
        JObject: JsonObject;
        MActivities: Codeunit "Member Activities";
        SActivities: Codeunit "Sacco Activities";
        JsObject_1: JsonObject;
        JsObject_2: JsonObject;
        JsObject_3: JsonObject;
        JsObject_4: JsonObject;
        JsObject_5: JsonObject;
        JsObject_6: JsonObject;
        JsonResult: JsonObject;

        ArrayString: Text;
        JsonEmptyArray: JsonArray;
        JSON_Array: JsonArray;
        JsArray1: JsonArray;
        JsArray2: JsonArray;
        JsArray3: JsonArray;
        JsArray4: JsonArray;
        JsArray5: JsonArray;

        Source: Enum "SMS Source Enum";
        JsonText: Text;
        isDetected: Boolean;
        ErrMsg: Text;
        MsgCode: Text;
        ExciseDutyGL: Code[20];
        ExciseDutyRate: Decimal;
        ExciseDuty: Decimal;
        Sep: label '\::/';
        Null: label 'NULL';
        Success: label '200';
        Account_Does_Not_Exist: label '300';
        Parameters_Not_Valid_Or_Missing: label '400';
        Member_Not_Authorized_For_This_Request: label '401';
        Insufficient_Funds: label '402';
        Amount_Limit_Reached: label '403';
        Operation_Does_Not_Exist: label '404';
        Daily_Frequency_Limit_Reached: label '405';
        Severe_problem_Has_Occured: label '500';
        StatusOK: label '200';
        StatusNotFound: label '404';
        Unknown: label '000';
        Record_Exists: label '202';
        MbankingName: label 'CalMobile';
        ShortCode: label '*882#';
        SType: Option " ",Bosa,Fosa,Micro;
        ProdCategory: Option " ",Savings,"Share Capital",NWD;
        Member_Does_Not_Exist: label '14';
        LType: Option " ","Available on Mobile","Bosa Loan","Fosa Loan","All Loans";
        SaccoTrans: Codeunit "Sacco Activities";
        TType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer";
        MBSEloanLogs: Record "Mbanking Eloan Logs";
        requestid: Text;
        TChannel: Enum "Transaction Channel";


    procedure EMPTY(String: Text): Boolean
    begin
        exit(StrLen(DelChr(String, '<>')) = 0);
    end;


    procedure PARSEINT(String: Text): Integer
    var
        IntValue: Integer;
    begin
        if Evaluate(IntValue, String) then exit(IntValue);
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
        if GenSetup."Excise Duty (%)" > 0 then
            GenSetup.TestField("Excise Duty GL");
        account := GenSetup."Excise Duty GL";
    end;


    procedure MemberRegistration(var iDNo: Text; var firstName: Text; var middleName: Text; var branchCode: Text; var surname: Text; var pinNo: Text; var address: Text; var gender: Text; var occupation: Text; var phoneNo: Text; var email: Text; var passportPhoto: Text; var frontID: Text; var backID: Text; var signature: Text; var dateOfBirth: Text; var maritalStatus: Text; var applicationNo: Text; var responseCode: Text; var responseMessage: Text; var errorMessage: Text): Integer
    var
        MobileRegistrations: Record "Mobile Registrations";
        Members: Record "Savings Accounts";
    begin

        errorMessage := '';

        if StrLen(phoneNo) <> 12 then begin
            responseCode := '44';
            errorMessage := 'Phone Number Must be Equal to 12 Characters!';
            exit;
        end;
        if iDNo = '' then begin
            responseCode := '40';
            errorMessage := 'ID Number Must be input';
            exit;
        end;
        if (firstName = '') and (middleName = '') and (surname = '') then begin
            responseCode := '41';
            errorMessage := 'Member Name must be input!';
            exit;
        end;
        if branchCode = '' then begin
            responseCode := '42';
            errorMessage := 'Branch Code must be input';
            exit;
        end;

        Members.Reset;
        Members.SetRange("ID No.", iDNo);
        if Members.FindFirst then begin
            responseCode := '44';
            errorMessage := 'ID Number input already exists in Member Application';
            exit;
        end;

        Members.Reset;
        Members.SetRange("Phone No.", phoneNo);
        if Members.FindFirst then begin
            responseCode := '46';
            errorMessage := 'Phone No. already in use';
            exit;
        end;


        MobileRegistrations.Init;
        MobileRegistrations.iDNo := iDNo;
        MobileRegistrations.firstName := firstName;
        MobileRegistrations.middleName := middleName;
        MobileRegistrations.branchCode := branchCode;
        MobileRegistrations.surname := surname;
        MobileRegistrations.pinNo := pinNo;
        MobileRegistrations.address := address;
        MobileRegistrations.gender := gender;
        MobileRegistrations.occupation := occupation;
        MobileRegistrations.phoneNo := phoneNo;
        MobileRegistrations.email := email;
        MobileRegistrations.passportPhoto := passportPhoto;
        MobileRegistrations.frontID := frontID;
        MobileRegistrations.backID := backID;
        MobileRegistrations.signature := signature;
        MobileRegistrations.dateOfBirth := dateOfBirth;
        MobileRegistrations.maritalStatus := maritalStatus;
        MobileRegistrations.applicationNo := applicationNo;


        if gender = '0' then
            MobileRegistrations."Member Gender" := MobileRegistrations."member gender"::Male;
        if gender = '1' then
            MobileRegistrations."Member Gender" := MobileRegistrations."member gender"::Female;


        if maritalStatus = 'Married' then
            MobileRegistrations."Member Marital Status" := MobileRegistrations."member marital status"::Married;
        if maritalStatus = 'Single' then
            MobileRegistrations."Member Marital Status" := MobileRegistrations."member marital status"::Single;


        if MobileRegistrations.Insert then begin
            responseCode := '00';
            responseMessage := 'Successful Registration';
            errorMessage := '';
        end
        else begin
            responseCode := '';
            responseMessage := '';
            errorMessage := 'Member Not Created';
        end;

        phoneNo := ConvertPhoneNoRemove(phoneNo);
    end;


    procedure GetSavingsAccounts(var mobilePhoneNo: Text; var responseCode: Text; var responseMessage: Text; var errorMessage: Text): Integer
    var
        MemberAccounts: Record "Savings Accounts";
        Members: Record Members;
        MPESAApplications: Record "MBanking Applications";
        JsonAcc: JsonObject;
        JsonAccArray: JsonArray;
    begin
        responseCode := '';
        responseMessage := '';
        errorMessage := '';



        mobilePhoneNo := ConvertPhoneNo(mobilePhoneNo);

        //MESSAGE(mobilephoneno);
        //MemberAccounts.RESET;
        //MemberAccounts.SETRANGE("Transactional Mobile No",mobilephoneno);
        //MemberAccounts.SETRANGE("Loan Disbursement Account",FALSE);
        //IF MemberAccounts.FINDFIRST THEN BEGIN
        //    MemberAccounts."Loan Disbursement Account":=(TRUE);
        //    MemberAccounts.MODIFY;
        //END;



        MemberAccounts.Reset;
        MemberAccounts.SetRange("Transactional Mobile No", mobilePhoneNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
        //MemberAccounts.setfilter("Product Type",'0101|0102');
        if MemberAccounts.FindFirst then begin
            Members.Get(MemberAccounts."Member No.");


            MPESAApplications.Reset;
            MPESAApplications.SetRange(MPESAApplications."Customer ID No", Members."ID No.");
            MPESAApplications.SetRange(MPESAApplications."MPesa Mobile No", mobilephoneno);
            MPESAApplications.SetRange(MPESAApplications.Status, MPESAApplications.Status::Approved);
            if (MPESAApplications.FindFirst) or (true) then begin

                responseMessage := GetAccounts(MemberAccounts."Member No.", Stype::Fosa, Prodcategory::Savings);
                if responseMessage <> '' then begin

                    responseCode := '000';
                    errorMessage := '';
                end;
            end
            else begin
                responseCode := '08';
                responseMessage := '';
                errorMessage := 'Member Account not found';

            end;
        end
        else begin

            responseCode := '08';
            responseMessage := '';
            errorMessage := 'Member Account not found';

        end;
    end;


    procedure GetAccounts(MemberNo: Code[20]; SType: Option " ",Bosa,Fosa,Micro; ProdCategory: Option " ",Savings,"Share Capital",NWD) Response: Text
    var
        LocalJsonText: Text;
        LocalMsgCode: Text;
        CDate: Date;
        CTime: Time;
        Members: Record Members;
        MemberAccounts: Record "Savings Accounts";
        ProductSetup: Record "Product Setup";
        Found: Boolean;
        PSetup: Record "Product Setup";
        BosaBalance: Decimal;
        JsonAcc: JsonObject;
        JsonAccArray: JsonArray;
    begin



        Response := '';

        MemberAccounts.Reset;
        MemberAccounts.SetRange("Member No.", MemberNo);
        if ProdCategory = Prodcategory::Savings then
            MemberAccounts.SetFilter("Product Category", '%1|%2', MemberAccounts."Product Category"::"Ordinary Savings", MemberAccounts."Product Category"::"Dividend Account")
        else
            if ProdCategory = Prodcategory::"Share Capital" then
                MemberAccounts.SetFilter("Product Category", '%1', MemberAccounts."Product Category"::"Share Capital")
            else
                if ProdCategory = Prodcategory::NWD then
                    MemberAccounts.SetFilter("Product Category", '%1', MemberAccounts."Product Category"::"Deposit Contribution")

                else
                    Error('Invalid Account Type Option');
        if MemberAccounts.FindFirst then begin
            repeat
                MemberAccounts.CalcFields("Balance (LCY)");
                Found := true;

                Clear(JsonAcc);
                JsonAcc.Add('accountNo', MemberAccounts."No.");
                JsonAcc.Add('accountName', MemberAccounts."Product Name" + '(' + format(AccountBalance(MemberAccounts."No.")) + ')');
                //JsonAcc.Add('accountName', MemberAccounts.Name);

                if ProdCategory = Prodcategory::Savings then begin
                    JsonAcc.Add('canWithdraw', 'Yes');
                    if MemberAccounts."Product Category" = MemberAccounts."Product Category"::"Dividend Account" then
                        JsonAcc.Add('canDeposit', 'No')
                    else
                        JsonAcc.Add('canDeposit', 'Yes');
                    JsonAcc.Add('isLoanAccount', 'No');
                    JsonAcc.Add('isNWD', 'No');
                    JsonAcc.Add('isShareCapital', 'No');
                    JsonAcc.Add('isSavingsAccount', 'Yes');

                end;
                if ProdCategory = Prodcategory::"Share Capital" then begin
                    JsonAcc.Add('canWithdraw', 'No');
                    JsonAcc.Add('canDeposit', 'Yes');
                    JsonAcc.Add('isLoanAccount', 'No');
                    JsonAcc.Add('isNWD', 'No');
                    JsonAcc.Add('isShareCapital', 'Yes');
                    JsonAcc.Add('isSavingsAccount', 'No');

                end;
                if ProdCategory = Prodcategory::NWD then begin
                    JsonAcc.Add('canWithdraw', 'No');
                    JsonAcc.Add('canDeposit', 'Yes');
                    JsonAcc.Add('isLoanAccount', 'No');
                    JsonAcc.Add('isNWD', 'Yes');
                    JsonAcc.Add('isShareCapital', 'No');
                    JsonAcc.Add('isSavingsAccount', 'No');

                end;

                JsonAcc.Add('balance', AccountBalance(MemberAccounts."No."));
                JsonAcc.Add('maxWithdrawable', 0);
                JsonAcc.Add('maxDeposit', 0);

                JsonAccArray.Add(JsonAcc);

            until MemberAccounts.Next = 0;

            Members.get(MemberNo);


            JsObject_2.Add('name', Members.Name);
            JsObject_2.Add('nationalId', Members."ID No.");
            //JsObject_1.Add('member', JsObject_2);
            JsonResult.Add('member', JsObject_2);
            JsonResult.Add('accounts', JsonAccArray);
            //JsonResult.Add('response', JsObject_1);
            JsonResult.WriteTo(Response);

        end
        else begin
            JsonEmptyArray.WriteTo(Response);
        end;

    end;


    procedure AccountBalance(Account: Text[30]) AccountBal: Decimal
    var
        SActivities: Codeunit "Sacco Activities";
        SavingsAcc: Record "Savings Accounts";

    begin


        AccountBal := SActivities.GetAccountBalance(Account);
    end;


    procedure GetShareCapitalAccount(var mobilePhoneNo: Text; var responseCode: Text; var responseMessage: Text; var errorMessage: Text): Integer
    var
        MemberAccounts: Record "Savings Accounts";
        Members: Record Members;
    begin
        responseCode := '';
        responseMessage := '';
        errorMessage := '';



        mobilePhoneNo := ConvertPhoneNo(mobilePhoneNo);

        MemberAccounts.Reset;
        MemberAccounts.SetRange("Transactional Mobile No", mobilePhoneNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
        if MemberAccounts.FindFirst then begin
            Members.Get(MemberAccounts."Member No.");

            responseMessage := GetAccounts(MemberAccounts."Member No.", Stype::Bosa, Prodcategory::"Share Capital");

            if responseMessage <> '' then begin

                responseCode := '000';
                errorMessage := '';
            end;
        end
        else begin

            responseCode := '08';
            responseMessage := '';
            errorMessage := 'Member Account not found';

            mobilePhoneNo := ConvertPhoneNoRemove(mobilePhoneNo);

        end;
    end;



    procedure GetLoanAccounts(var mobilePhoneNo: Text; var responseCode: Text; var responseMessage: Text; var errorMessage: Text): Integer
    var
        MemberAccounts: Record "Savings Accounts";
        Members: Record Members;
        StPoint: Integer;
        PhoneLength: Integer;
    begin
        responseCode := '';
        responseMessage := '';
        errorMessage := '';


        mobilePhoneNo := ConvertPhoneNo(mobilePhoneNo);


        MemberAccounts.Reset;
        MemberAccounts.SetRange("Transactional Mobile No", mobilePhoneNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
        if MemberAccounts.FindFirst then begin
            Members.Get(MemberAccounts."Member No.");

            responseCode := '000';
            responseMessage := GetLoans(Members."No.");
            errorMessage := '';

            mobilePhoneNo := ConvertPhoneNoRemove(mobilePhoneNo);
        end
        else begin

            responseCode := '08';
            responseMessage := '';
            errorMessage := 'Member Account not found';

        end;
    end;


    procedure GetLoans(MemberNo: Code[20]) Response: Text
    var
        LocalJsonText: Text;
        LocalMsgCode: Text;
        CDate: Date;
        CTime: Time;
        Members: Record Members;
        MemberAccounts: Record "Savings Accounts";
        ProductSetup: Record "Product Setup";
        Found: Boolean;
        BosaBalance: Decimal;
        JsonAcc: JsonObject;
        JsonAccArray: JsonArray;
        Loans: Record Loans;
        LoanBal: Decimal;
        ExpectedAmt: decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        AsAt: Date;
        GracePeriod: DateFormula;
        LSchedule: Record "Loan Repayment Schedule";
    begin



        Response := '';


        Found := false;
        ProductSetup.Reset;
        ProductSetup.SetRange("Product Class", ProductSetup."product class"::Credit);
        if ProductSetup.FindFirst then begin
            repeat

                Loans.Reset;
                Loans.SetRange("Member No.", MemberNo);
                Loans.SetRange("Loan Product Type", ProductSetup."Product ID");
                Loans.SetFilter("Outstanding Principal", '>0');
                if Loans.FindFirst then begin
                    repeat
                        Found := true;


                        Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Principal Arrears", "Outstanding Penalty");
                        if Loans."Outstanding Interest" < 0 then
                            Loans."Outstanding Interest" := 0;

                        LoanBal := Loans."Outstanding Principal" + Loans."Outstanding Interest";

                        LSchedule.Reset();
                        LSchedule.SetRange("Loan No.", Loans."Loan No.");
                        LSchedule.SetRange("Repayment Date", CalcDate('-CM', Today), CalcDate('CM', Today));
                        if LSchedule.FindLast() then;

                        AsAt := CalcDate('CM', today);
                        ExpectedAmt := 0;
                        AmtPaid := 0;
                        DefAmount := 0;
                        DaysInArrear := 0;
                        ArrearsDate := 0D;

                        SaccoActivity.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, GracePeriod);

                        Clear(JsonAcc);
                        JsonAcc.Add('accountNo', Loans."Loan No.");
                        //JsonAcc.Add('loanNo', Loans."Loan No.");
                        JsonAcc.Add('accountName', ProductSetup."USSD Product Name" + '(Bal: ' + Format(LoanBal) + ': Rep: ' + Format(Loans."Outstanding Penalty" + Loans."Outstanding Interest" + LSchedule."Monthly Interest" + LSchedule."Monthly Principal" + DefAmount) + ')');
                        JsonAcc.Add('canWithdraw', 'No');
                        JsonAcc.Add('canDeposit', 'No');
                        JsonAcc.Add('isLoanAccount', 'Yes');
                        JsonAcc.Add('isNWD', 'No');
                        JsonAcc.Add('isShareCapital', 'No');
                        JsonAcc.Add('isSavingsAccount', 'No');
                        JsonAcc.Add('balance', LoanBal);
                        JsonAcc.Add('maxWithdrawable', 0);
                        JsonAcc.Add('maxDeposit', 0);
                        JsonAcc.Add('createdDate', ddMMyyyy(Loans."Disbursement Date"));
                        JsonAcc.Add('installmentAmount', Loans.Repayment);
                        JsonAcc.Add('tofinishdate', ddMMyyyy(Loans."Completion Date"));

                        JsonAccArray.Add(JsonAcc);

                    until Loans.Next = 0;





                end;
            until ProductSetup.Next = 0;

            Members.get(MemberNo);


            JsObject_2.Add('name', Members.Name);
            JsObject_2.Add('nationalId', Members."ID No.");
            JsonResult.Add('member', JsObject_2);
            JsonResult.Add('accounts', JsonAccArray);
            //JsonResult.Add('response', JsObject_1);
            JsonResult.WriteTo(Response);

        end
        else begin
            JsonEmptyArray.WriteTo(Response);
        end;


    end;



    procedure GetNWDAccounts(var mobilePhoneNo: Text; var responseCode: Text; var responseMessage: Text; var errorMessage: Text): Integer
    var
        MemberAccounts: Record "Savings Accounts";
        Members: Record Members;
    begin
        responseCode := '';
        responseMessage := '';
        errorMessage := '';



        mobilePhoneNo := ConvertPhoneNo(mobilePhoneNo);

        MemberAccounts.Reset;
        MemberAccounts.SetRange("Transactional Mobile No", mobilePhoneNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
        if MemberAccounts.FindFirst then begin
            Members.Get(MemberAccounts."Member No.");

            responseMessage := GetAccounts(MemberAccounts."Member No.", Stype::Bosa, Prodcategory::NWD);

            if responseMessage <> '' then begin

                responseCode := '000';
                errorMessage := '';
            end;
        end
        else begin


            responseCode := '08';
            responseMessage := '';
            errorMessage := 'Member Account not found';

            mobilePhoneNo := ConvertPhoneNoRemove(mobilePhoneNo);

        end;
    end;


    procedure GeteLoanTypes(var mobilePhoneNo: Text; var responseCode: Text; var responseMessage: Text; var errorMessage: Text)
    var
        MemberAccounts: Record "Savings Accounts";
        Members: Record Members;
    begin
        responseCode := '';
        responseMessage := '';
        errorMessage := '';

        if mobilePhoneNo = '' then begin

            responseMessage := LoanTypes(Ltype::"Available on Mobile");

            responseCode := '00';
            errorMessage := '';
        end
        else begin


            mobilePhoneNo := ConvertPhoneNo(mobilePhoneNo);


            //Robert
            MemberAccounts.Reset;
            MemberAccounts.SetRange("Transactional Mobile No", mobilePhoneNo);
            //MemberAccounts.SetRange("Product Type", '0101');
            MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
            if not MemberAccounts.FindFirst then begin

                responseCode := '00';
                //responseMessage := LoanTypes(Ltype::"Available on Mobile");
                responseMessage := LoanTypesUSSD(Ltype::"Available on Mobile", mobilePhoneNo);
                errorMessage := '';

            end
            else begin

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Transactional Mobile No", mobilePhoneNo);
                MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
                if MemberAccounts.FindFirst then begin
                    Members.Get(MemberAccounts."Member No.");

                    // responseMessage := LoanTypes(Ltype::"Available on Mobile");
                    responseMessage := LoanTypesUSSD(Ltype::"Available on Mobile", mobilePhoneNo);

                    responseCode := '00';
                    errorMessage := '';

                end
                else begin


                    responseCode := '08';
                    responseMessage := '';
                    errorMessage := 'Member Account not found';


                end;
            end;
        end;
    end;


    procedure LoanTypesUSSD(LType: Option " ","Available on Mobile","Bosa Loan","Fosa Loan","All Loans"; var mobilePhoneNo: Text) Response: Text
    var

        JsonAcc: JsonObject;
        JsonAccArray: JsonArray;
        LoanProductTypes: Record "Product Setup";
        ProductSetup: Record "Product Setup";
    begin

        Response := '';

        LoanProductTypes.Reset;

        if LType = Ltype::" " then
            Error('Invalid Loan Type Criteria')
        else
            if LType = Ltype::"Available on Mobile" then
                LoanProductTypes.SetRange("Available on Mobile", true)
            else
                Error('Invalid Loan Type Option');

        //  LoanProductTypes.SETRANGE("Product ID",'L16');


        LoanProductTypes.SetRange("Product Class", LoanProductTypes."Product Class"::Credit);
        if LoanProductTypes.FindFirst then begin
            repeat


                if (LoanProductTypes."Restrict to Emp. Code" = '') and (LoanProductTypes."Restrict to Member Code" = '') then begin
                    Clear(JsonAcc);

                    JsonAcc.Add('LoanCode', LoanProductTypes."Product ID");
                    JsonAcc.Add('LoanName', LoanProductTypes."Description" + ' (Qual: ' + Format(GetMemberEligibilityAmount(mobilePhoneNo, LoanProductTypes."Product ID")) + ')');

                    JsonAccArray.Add(JsonAcc);
                end;
            until LoanProductTypes.Next = 0;

            JsonResult.Add('eloanTypes', JsonAccArray);
            //JsonResult.Add('response', JsObject_1);
            JsonResult.WriteTo(Response);

        end;

    end;

    procedure LoanTypes(LType: Option " ","Available on Mobile","Bosa Loan","Fosa Loan","All Loans") Response: Text
    var

        JsonAcc: JsonObject;
        JsonAccArray: JsonArray;
        LoanProductTypes: Record "Product Setup";
        ProductSetup: Record "Product Setup";
    begin

        Response := '';

        LoanProductTypes.Reset;

        if LType = Ltype::" " then
            Error('Invalid Loan Type Criteria')
        else
            if LType = Ltype::"Available on Mobile" then
                LoanProductTypes.SetRange("Available on Mobile", true)
            else
                Error('Invalid Loan Type Option');

        //  LoanProductTypes.SETRANGE("Product ID",'L16');


        LoanProductTypes.SetRange("Product Class", LoanProductTypes."Product Class"::Credit);
        if LoanProductTypes.FindFirst then begin
            repeat


                if (LoanProductTypes."Restrict to Emp. Code" = '') and (LoanProductTypes."Restrict to Member Code" = '') then begin
                    Clear(JsonAcc);

                    JsonAcc.Add('LoanCode', LoanProductTypes."Product ID");
                    JsonAcc.Add('LoanName', LoanProductTypes."Description");

                    JsonAccArray.Add(JsonAcc);
                end;
            until LoanProductTypes.Next = 0;

            JsonResult.Add('eloanTypes', JsonAccArray);
            //JsonResult.Add('response', JsObject_1);
            JsonResult.WriteTo(Response);

        end;

    end;

    local procedure ddMMyyyy(Date: Date) NewDate: Text
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


    procedure GetStatementTransactions(accountNumber: Text; startDate: Date; endDate: Date; startTime: Time; endTime: Time; emailaddress: Text) Response: Text
    var
        MbankingNotifications: Record "Mbanking Notifications";
        Vendor: Record "Savings Accounts";
    begin
        Response := '';


        MbankingNotifications.Init;
        MbankingNotifications.Guid := CreateGuid;
        if Vendor.Get(accountNumber) then
            MbankingNotifications.Type := MbankingNotifications.Type::"FOSA Statement"
        else
            MbankingNotifications.Type := MbankingNotifications.Type::"BOSA Statement";
        MbankingNotifications."Account No" := accountNumber;
        MbankingNotifications."Filter SDate" := startDate;
        MbankingNotifications."Filter EDate" := endDate;
        MbankingNotifications."E-Mail" := emailaddress;
        MbankingNotifications.Insert;

        Response := 'Success. Please check your email';
        SendNotifications(MbankingNotifications.Guid, true);
    end;


    procedure GetMemberEligibility(var phoneNo: Text; var eLoanCode: Text; var responseCode: Text; var responseMessage: Text; var errorMessage: Text) resCode: Text[5];
    var
        Sky: Codeunit "Sky MBanking";
        LocalJsonText: Text;
        LocalMsgCode: Text;
        ProductSetup: Record "Product Setup";
        Loans: Record Loans;
        MemberAccounts: Record "Savings Accounts";
        Members: Record Members;
        SASRACategorization: Record "Sasra Categorization";
        TArrears: Decimal;
        LBal: Decimal;
        Eligibility: Decimal;
        Limit: Decimal;
        MobileLoanBal: Decimal;
        LoanProduct: Record "Product Setup";
        LoanGuarantor: Record "Loan Security";
        SelfGuarBal: Decimal;
        Ratio: Decimal;
        Continue: Boolean;
        SACCOAccount: Record "Savings Accounts";
        AccBalance: Decimal;
        DividendAdvance: Record "Dividend Advance";
        DividendAdvanceDefaulter: Record "Dividend Advance - Defaulter";
        eLoanBal: Decimal;
        QualAmt: Decimal;
        Remark: Text;
        ErrorCode: Text[10];

    begin
        responseCode := '39';
        responseMessage := '';
        errorMessage := 'Not Processed';

        ProductSetup.Reset;
        ProductSetup.SetRange("Product ID", eLoanCode);
        ProductSetup.SetRange("Available on Mobile", true);
        if ProductSetup.FindFirst() then begin


            phoneNo := ConvertPhoneNo(phoneNo);

            resCode := '0';
            Remark := '';
            ErrorCode := '';
            QualAmt := 0;
            MemberAccounts.Reset;
            MemberAccounts.SetRange("Transactional Mobile No", phoneNo);
            MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
            if MemberAccounts.FindFirst then begin

                Members.Get(MemberAccounts."Member No.");

                //if (eLoanCode = 'L30') or (eLoanCode = 'L24') or (eLoanCode = 'L27') or (eLoanCode = 'L43') then begin

                if eLoanCode = 'L43' then
                    sky.GetDividendLoanQualifiedAmount(MemberAccounts."No.", eLoanCode, QualAmt, Remark)
                else
                    Sky.GetLoanQualifiedAmount(MemberAccounts."No.", eLoanCode, QualAmt, Remark, ErrorCode);

                if QualAmt > 0 then begin

                    responseCode := '00';
                    responseMessage := 'You Qualify for KES ' + Format(QualAmt);
                    errorMessage := '';
                end
                else begin
                    if ErrorCode <> '' then
                        responseCode := ErrorCode;

                    if Remark = '' then
                        Remark := 'You do not have FREE deposits.';

                    if responseCode = '' then
                        responseCode := '52';

                    responseMessage := Remark;
                    errorMessage := responseMessage;
                    exit;
                    //end;
                end;


                AccBalance := AccountBalance(MemberAccounts."No.");

                /*Eligibility := 0;

                if eLoanCode = 'L43' then begin
                    sky.GetDividendLoanQualifiedAmount(MemberAccounts."No.", eLoanCode, QualAmt, Remark);
                    Eligibility := QualAmt;
                    // if DividendAdvance.Get(Members."No.") then begin
                    //     Eligibility := DividendAdvance."Qualifying Amount";
                    // end
                    // else
                    //     if DividendAdvanceDefaulter.Get(Members."No.") then begin
                    //         Eligibility := DividendAdvanceDefaulter."Qualifying Amount";
                    //     end;



                    Eligibility -= eLoanBal;
                    if Eligibility < 0 then
                        Eligibility := 0;

                    //Eligibility := ThibitiEligibility(phoneNo,eLoanCode);

                    responseCode := '00';
                    responseMessage := 'You Qualify for KES ' + Format(Eligibility);
                    errorMessage := '';
                end;*/

            end
            else begin
                responseCode := '08';
                responseMessage := '';
                errorMessage := 'Member Account not found';
            end;

        end
        else begin

            responseCode := '09';
            responseMessage := '';
            errorMessage := 'eLoan Product Types not setup';
        end;

        phoneNo := ConvertPhoneNoRemove(phoneNo);

    end;


    procedure GetMemberEligibilityAmount(var phoneNo: Text; var eLoanCode: Code[10]) QualAmt: Decimal;
    var
        Sky: Codeunit "Sky MBanking";
        LocalJsonText: Text;
        LocalMsgCode: Text;
        ProductSetup: Record "Product Setup";
        Loans: Record Loans;
        MemberAccounts: Record "Savings Accounts";
        Members: Record Members;
        SASRACategorization: Record "Sasra Categorization";
        TArrears: Decimal;
        LBal: Decimal;
        Eligibility: Decimal;
        Limit: Decimal;
        MobileLoanBal: Decimal;
        LoanProduct: Record "Product Setup";
        LoanGuarantor: Record "Loan Security";
        SelfGuarBal: Decimal;
        Ratio: Decimal;
        Continue: Boolean;
        SACCOAccount: Record "Savings Accounts";
        AccBalance: Decimal;
        DividendAdvance: Record "Dividend Advance";
        DividendAdvanceDefaulter: Record "Dividend Advance - Defaulter";
        eLoanBal: Decimal;

        Remark: Text;
        ErrorCode: Text[10];

    begin


        ProductSetup.Reset;
        ProductSetup.SetRange("Product ID", eLoanCode);
        ProductSetup.SetRange("Available on Mobile", true);
        if ProductSetup.FindFirst() then begin


            phoneNo := ConvertPhoneNo(phoneNo);


            Remark := '';
            ErrorCode := '';
            QualAmt := 0;
            MemberAccounts.Reset;
            MemberAccounts.SetRange("Transactional Mobile No", phoneNo);
            MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
            if MemberAccounts.FindFirst then begin

                Members.Get(MemberAccounts."Member No.");

                //if (eLoanCode = 'L30') or (eLoanCode = 'L24') or (eLoanCode = 'L27') or (eLoanCode = 'L43') then begin

                if eLoanCode = 'L43' then
                    sky.GetDividendLoanQualifiedAmount(MemberAccounts."No.", eLoanCode, QualAmt, Remark)
                else
                    Sky.GetLoanQualifiedAmount(MemberAccounts."No.", eLoanCode, QualAmt, Remark, ErrorCode);
                //end;


                Exit(QualAmt);

                /*Eligibility := 0;

                if eLoanCode = 'L43' then begin
                    sky.GetDividendLoanQualifiedAmount(MemberAccounts."No.", eLoanCode, QualAmt, Remark);
                    Eligibility := QualAmt;
                    // if DividendAdvance.Get(Members."No.") then begin
                    //     Eligibility := DividendAdvance."Qualifying Amount";
                    // end
                    // else
                    //     if DividendAdvanceDefaulter.Get(Members."No.") then begin
                    //         Eligibility := DividendAdvanceDefaulter."Qualifying Amount";
                    //     end;



                    Eligibility -= eLoanBal;
                    if Eligibility < 0 then
                        Eligibility := 0;

                    //Eligibility := ThibitiEligibility(phoneNo,eLoanCode);

                    responseCode := '00';
                    responseMessage := 'You Qualify for KES ' + Format(Eligibility);
                    errorMessage := '';
                end;*/

            end;

        end;

    end;


    procedure ApplyLoan(var requestid: Text; var phoneNo: Text; eLoanCode: Text; amount: Decimal; installments: Integer; var responseCode: Text; var responseMessage: Text; var errorMessage: Text)
    var
        LocalJsonText: Text;
        LocalMsgCode: Text;
        Response: Text;
        Rejected: Boolean;
        MBSEloanLogs: Record "Mbanking Eloan Logs";
        eloanTypes: Record "Product Setup";
    begin
        responseCode := '';
        responseMessage := '';
        errorMessage := '';

        phoneNo := ConvertPhoneNo(phoneNo);

        MBSEloanLogs.Init;
        MBSEloanLogs.Guid := CreateGuid;
        MBSEloanLogs.Date := Today;
        MBSEloanLogs.Time := Time;
        MBSEloanLogs.PhoneNo := phoneNo;
        MBSEloanLogs.LoanType := eLoanCode;
        MBSEloanLogs.LoanPeriod := installments;
        MBSEloanLogs.Amount := amount;

        Rejected := false;

        GetMemberEligibility(phoneNo, eLoanCode, responseCode, responseMessage, errorMessage);
        Message(errorMessage);

        if errorMessage = '' then
            MobileLoanProcessing(phoneNo, installments, eLoanCode, requestid, amount, Response, Rejected, responseCode)
        else
            Rejected := true;

        if not Rejected then begin

            eloanTypes.Get(eLoanCode);
            responseCode := '31';
            responseMessage := format(amount) + ' ' + eloanTypes.Description + ' application received successfuly';
            errorMessage := '';

        end
        else begin

            if responseCode = '' then
                responseCode := '39';

            if responseMessage <> '' then
                responseMessage := Response;

            if Response <> '' then
                errorMessage := Response;

            responseMessage := errorMessage;
        end;

        if responseMessage <> '' then
            MBSEloanLogs.Msg := responseMessage;

        if errorMessage <> '' then
            MBSEloanLogs.Msg := errorMessage;

        MBSEloanLogs.Response := responseCode;

        if MBSEloanLogs.Insert then
            Commit;
    end;


    procedure GetBranchCodes(var phoneNo: Text; var responseCode: Text; var responseMessage: Text; var errorMessage: Text)
    var
        MemberAccounts: Record "Savings Accounts";
        Members: Record "Savings Accounts";
    begin
        responseCode := '';
        responseMessage := '';
        errorMessage := '';

        MemberAccounts.Reset;
        MemberAccounts.SetRange("Transactional Mobile No", phoneNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
        if MemberAccounts.FindFirst then begin
            responseCode := '00';
            responseMessage := Branches;
            errorMessage := '';
        end else begin
            responseCode := '22';
            responseMessage := '';
            errorMessage := 'Member Account not found';
        end;
    end;


    procedure Branches() Response: Text
    var
        LocalJsonText: Text;
        LocalMsgCode: Text;
        DimensionValue: Record "Dimension Value";
        JsonAcc: JsonObject;
        JsonAccArray: JsonArray;
    begin

        Response := '';


        DimensionValue.Reset;
        DimensionValue.SetRange("Dimension Code", 'BRANCH');
        if DimensionValue.FindFirst then begin
            repeat

                Clear(JsonAcc);
                JsonAcc.Add('BranchCode', DimensionValue.Code);
                JsonAcc.Add('BranchName', DimensionValue.Name);

                JsonAccArray.Add(JsonAcc);

            until DimensionValue.Next = 0;


            JsonResult.Add('BranchDetails', JsonAccArray);
            JsonResult.WriteTo(Response);
        end;


    end;


    procedure ValidateAccountDetails(var accountNumber: Text; var responseCode: Text; var responseMessage: Text; var errorMessage: Text)
    var
        MemberAccounts: Record "Savings Accounts";
        Members: Record Members;
        JsonAcc: JsonObject;
        JsonAccArray: JsonArray;
        Loans: Record Loans;
        VariableBlobCW: Text;
        //CalwidePortal: Codeunit "Calwide Portal";
        OutStream: OutStream;
        InStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        Base64: Codeunit Base64;
        MemberImg: Record "Member Images";
    begin

        responseCode := '';
        responseMessage := '';
        errorMessage := '';
        VariableBlobCW := '';

        MemberAccounts.Reset;
        //MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
        MemberAccounts.SetRange("No.", accountNumber);
        if MemberAccounts.FindFirst then begin
            Members.get(MemberAccounts."Member No.");
            MemberImg.get(Members."No.");
            clear(JsonAcc);
            Base64.ConvertMemberPictureToBase64String(MemberImg, VariableBlobCW);

            //JsonAcc.Add('OwnerName', MemberAccounts.Name);
            JsonAcc.Add('AccountName', MemberAccounts."Product Name");
            //AzizSaccoTrans.CreateLocalObject(LocalJSONTextWriter,'AccountName"',MemberAccounts."Product Name",FALSE);
            JsonAcc.Add('MemberImage', VariableBlobCW);
            JsonAcc.Add('MobileNo', Members."Mobile Phone No.");
            JsonAcc.Add('IDNo', Members."ID No.");

            JsonAcc.WriteTo(responseMessage);
            //JsonResult.Add('', JsonAcc);
            //JsonResult.WriteTo(responseMessage);
            responseCode := '000';
            errorMessage := '';
        end
        else begin

            Loans.Reset;
            Loans.SetRange("Loan No.", accountNumber);
            //MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
            if Loans.FindFirst then begin
                clear(JsonAcc);

                Members.get(Loans."member no.");
                MemberImg.get(Members."No.");
                Base64.ConvertMemberPictureToBase64String(MemberImg, VariableBlobCW);

                JsonAcc.Add('AccountName', Loans."Loan Product Type Name");
                //AzizSaccoTrans.CreateLocalObject(LocalJSONTextWriter,'AccountName"',MemberAccounts."Product Name",FALSE);
                JsonAcc.Add('MemberImage', VariableBlobCW);
                JsonAcc.Add('MobileNo', Members."Mobile Phone No.");
                JsonAcc.Add('IDNo', Members."ID No.");

                JsonAcc.WriteTo(responseMessage);
                //JsonResult.Add('', JsonAcc);
                //JsonResult.WriteTo(responseMessage);
                responseCode := '000';
                errorMessage := '';

            end
            else begin

                responseCode := '22';
                responseMessage := '';
                errorMessage := 'Invalid Account';

            end;
        end;
    end;


    procedure SpotCash(var request_id: Text; var phone_no: Text; var transaction_type: Text; var amount: Text; var trnx_charges: Text; var account__number: Text; var cr_account: Text; var status: Text; var f_key: Text; var balance: Text; var message: Text; var response: Text; var response_message: Text; var customerType: Text; var description: Text; var startDate: Text; var endDate: Text; var startTime: Text; var endTime: Text; var emailaddress: Text)
    var
        MbankingNotifications: Record "Mbanking Notifications";
        Vendor: Record "Savings Accounts";
        SavAccount: Record "Savings Accounts";
        MTrans: Record "Spotcash Transactions";
        transaction_typeInt: Integer;
        amountDec: Decimal;
        trnx_chargesDec: Decimal;
        startDateD: Date;
        endDateD: Date;
        startTimeT: Time;
        endTimeT: Time;
        Loans: Record Loans;
    begin

        response := '';
        response_message := '';

        Evaluate(transaction_typeInt, transaction_type);
        Evaluate(amountDec, amount);
        Evaluate(trnx_chargesDec, trnx_charges);
        Evaluate(startDateD, startDate);
        Evaluate(endDateD, endDate);
        Evaluate(startTimeT, startTime);
        Evaluate(endTimeT, endTime);

        MTrans.Reset();
        MTrans.SetRange(request_id, request_id);
        if MTrans.FindFirst() then begin
            response := '00';
            response_message := 'Success';
            exit;
        end;

        phone_no := ConvertPhoneNo(phone_no);
        account__number := CopyStr(account__number, 1, 20);

        MTrans.Init;
        MTrans.request_id := request_id;
        MTrans.transaction := transaction_typeInt;
        MTrans.amount := amountDec;
        MTrans.trnx_charges := trnx_chargesDec;
        MTrans.account_number := account__number;
        MTrans.cr_account := cr_account;
        MTrans.status := status;
        MTrans.customerType := customerType;
        MTrans.description := description;
        MTrans.startDate := startDateD;
        MTrans.endDate := endDateD;
        MTrans.startTime := startTimeT;
        MTrans.endTime := endTimeT;
        MTrans.emailaddress := emailaddress;
        MTrans.phone_no := phone_no;
        MTrans."Transaction Date" := Today;


        case transaction_typeInt of
            700, 701, 702, 703:
                MTrans."Transaction Type" := MTrans."transaction type"::"Balance Enquiry";
            704:
                MTrans."Transaction Type" := MTrans."transaction type"::"Mini-Statement";
            705, 600, 5, 6, 7, 747, 749:
                MTrans."Transaction Type" := MTrans."transaction type"::Paybill;
            706, 746:
                MTrans."Transaction Type" := MTrans."transaction type"::"Mpesa Withdrawal";
            707, 748:
                MTrans."Transaction Type" := MTrans."transaction type"::Airtime;
            708:
                MTrans."Transaction Type" := MTrans."transaction type"::"Account Transfer";
            709:
                MTrans."Transaction Type" := MTrans."transaction type"::"Mini-Statement";
            712 .. 723:
                MTrans."Transaction Type" := MTrans."transaction type"::"Utility Payment";
            724:
                MTrans."Transaction Type" := MTrans."transaction type"::"Bank Transfer";
            735:
                MTrans."Transaction Type" := MTrans."transaction type"::"Utility Payment";
            737:
                MTrans."Transaction Type" := MTrans."transaction type"::"Pesalink Transfer";
            745 .. 749:
                begin
                    response := '27';
                    response_message := 'Sorry, this service is temporarily suspended.';
                    exit;
                end
        end;

        if MTrans."Transaction Type" = MTrans."transaction type"::"Mpesa Withdrawal" then
            MTrans."Withdrawal Request" := true;
        if MTrans."Transaction Type" = MTrans."transaction type"::Airtime then
            MTrans."Withdrawal Request" := true;
        if MTrans."Transaction Type" = MTrans."transaction type"::"Utility Payment" then
            MTrans."Withdrawal Request" := true;
        if MTrans."Transaction Type" = MTrans."transaction type"::"Bank Transfer" then
            MTrans."Withdrawal Request" := true;

        if MTrans.description = '' then
            MTrans.description := Format(MTrans."Transaction Type");
        if MTrans.description = '[string]' then
            MTrans.description := Format(MTrans."Transaction Type");

        MTrans."Reference No." := f_key;

        MTrans.Insert;


        case transaction_typeInt of
            700, 701, 702, 703:
                begin
                    response := '';

                    if Vendor.get(account__number) then begin

                        SavAccount.Reset();
                        SavAccount.SetRange("Member No.", Vendor."Member No.");
                        SavAccount.SetRange("Transactional Mobile No", phone_no);
                        SavAccount.SetRange("Product Category", SavAccount."Product Category"::"Ordinary Savings");
                        if SavAccount.FindFirst() then begin
                            SavAccount.CalcFields("Balance (LCY)");

                            CheckSufficientBalance(request_id, SavAccount."No.", amountDec, Today, response, response_message, Ttype::"Balance Enquiry");
                            if response = '00' then
                                response_message := Format(BalanceEnquiry(request_id, transaction_typeInt, account__number));
                            //response_message := 'Book Balance : ' + format(SavAccount."Balance (LCY)") + ',' + 'Available Balance : ' + Format(BalanceEnquiry(request_id, transaction_typeInt, account__number));
                        end else begin
                            response := '22';
                            response_message := 'Account Not Found';
                        end;
                    end else begin
                        response := '22';
                        response_message := 'Account Not Found';
                    end;

                    if (Loans.get(account__number)) and (response = '22') then begin

                        SavAccount.Reset();
                        SavAccount.SetRange("Member No.", Loans."Member No.");
                        SavAccount.SetRange("Transactional Mobile No", phone_no);
                        SavAccount.SetRange("Product Category", SavAccount."Product Category"::"Ordinary Savings");
                        if SavAccount.FindFirst() then begin

                            CheckSufficientBalance(request_id, SavAccount."No.", amountDec, Today, response, response_message, Ttype::"Balance Enquiry");
                            if response = '00' then
                                response_message := Format(BalanceEnquiry(request_id, transaction_typeInt, account__number));
                        end else begin
                            response := '22';
                            response_message := 'Account Not Found';
                        end;

                    end else if (response = '22') or (response = '') then begin
                        response := '22';
                        response_message := 'Account Not Found';
                    end;

                    /* if (not Vendor.get(account__number)) and (not Loans.get(account__number)) then begin
                         response := '22';
                         response_message := 'Account Not Found';
                     end;*/

                end;
            704:
                begin
                    response := '';

                    Vendor.get(account__number);

                    SavAccount.Reset();
                    SavAccount.SetRange("Member No.", Vendor."Member No.");
                    SavAccount.SetRange("Transactional Mobile No", phone_no);
                    SavAccount.SetRange("Product Category", SavAccount."Product Category"::"Ordinary Savings");
                    if SavAccount.FindFirst() then begin

                        CheckSufficientBalance(request_id, SavAccount."No.", amountDec, Today, response, response_message, Ttype::"Mini-Statement");
                        if response = '00' then
                            response_message := MiniStatement(request_id, account__number);
                    end else begin
                        response := '22';
                        response_message := 'Account Not Found';
                    end;


                end;
            705, 600, 5, 6, 7, 747, 749:
                begin
                    Commit();
                    response := '00';
                    if MpesaDeposit(request_id) then
                        response_message := 'Mpesa Deposit Successful'
                    else begin
                        response := '00';
                        response_message := 'Success';
                    end;
                end;
            706, 746:
                begin
                    WithdrawFunds(request_id, account__number, amountDec, Today, response, response_message, Ttype::"Mpesa Withdrawal");
                end;
            707, 748:
                begin
                    WithdrawFunds(request_id, account__number, amountDec, Today, response, response_message, Ttype::Airtime);
                end;
            708:
                begin
                    response := '';

                    response := '';
                    CheckSufficientBalance(request_id, account__number, amountDec, Today, response, response_message, Ttype::"Account Transfer");
                    if response = '00' then
                        if InterAccount(request_id) then
                            response_message := 'InterAccount Transfer Successful';

                end;
            709:
                begin
                    response := '00';
                    response_message := GetStatementTransactions(MTrans.account_number, MTrans.startDate, MTrans.endDate, MTrans.startTime, MTrans.endTime, MTrans.emailaddress);
                end;
            712 .. 723:
                begin
                    WithdrawFunds(request_id, account__number, amountDec, Today, response, response_message, Ttype::"Utility Payment");
                end;
            735:
                begin
                    WithdrawFunds(request_id, account__number, amountDec, Today, response, response_message, Ttype::"Utility Payment");
                end;

            737:
                begin
                    //xxxx
                    response := '00';
                    if PesaLinkDeposit(request_id) then
                        response_message := 'Pesalink Deposit Successful';
                end;
            724:
                begin
                    WithdrawFunds(request_id, account__number, amountDec, Today, response, response_message, Ttype::"Bank Transfer");
                    //        response := '00';
                    //        IF FosaToBank(request_id) THEN
                    //        response_message := 'Bank Transfer Successful';
                end;

        end;
        Commit;
        if not MTrans."Withdrawal Request" then
            PostMobileTransaction(request_id);

        phone_no := ConvertPhoneNoRemove(phone_no);

        //PostMbanking.RUN;
        //PostTransactions;
    end;

    local procedure BalanceEnquiry(ReqId: Code[20]; "Code": Integer; AccNo: Code[20]) Balance: Decimal
    var
        Members: Record "Savings Accounts";
        Vendor: Record "Savings Accounts";
        MemberNo: Code[20];
        Loans: Record Loans;
    begin

        PostMobileTransaction(ReqId);

        Balance := 0;
        if Code = 700 then begin
            Balance := AccountBalance(AccNo);
        end
        else
            if Code = 702 then begin

                Balance := LoanBalance(AccNo);
            end
            else begin
                Balance := AccountBalance(AccNo);
            end;
    end;


    procedure LoanBalance(Account: Text[30]) AccountBal: Decimal
    var
        Loans: Record Loans;
    begin
        AccountBal := 0;

        Loans.Reset;
        Loans.SetRange("Loan No.", Account);
        if Loans.Find('-') then begin
            Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
            AccountBal := Loans."Outstanding Principal" + Loans."Outstanding Interest";
        end;
    end;

    local procedure MiniStatement(ReqID: Code[20]; AccNo: Code[20]) Response: Text
    var
        Members: Record Members;
        Vendor: Record "Savings Accounts";
        MemberNo: Code[20];
        Loans: Record Loans;
    begin
        Response := '';
        PostMiniBalance(ReqID);


        if Loans.Get(AccNo) then begin
            Response := LoanMiniStatement(AccNo);
        end
        else
            if Vendor.Get(AccNo) then begin
                Response := FosaMiniStatement(AccNo);
            end
            else begin
                //Response := BosaMiniStatement(AccNo);
            end;
    end;

    local procedure FosaMiniStatement(AccNo: Code[20]) Statement: Text
    var
        VLedger: Record "Savings Ledger Entry";
        StartPoint: Integer;
        RCounter: Integer;
        Sendsms: Codeunit "Sky MBanking";
        Source: Enum "SMS Source Enum";
        NewSMS: Text;
    begin
        Statement := '';

        /*
        VLedger.RESET;
        VLedger.SETRANGE("Account No.",AccNo);
        VLedger.SETRANGE(Reversed,FALSE);
        IF VLedger.FINDFIRST THEN BEGIN
            IF VLedger.COUNT <= 10 THEN BEGIN
                REPEAT
                    VLedger.CALCFIELDS("Amount (LCY)");
                    Statement += FORMAT(VLedger."Posting Date")+' '+VLedger.Description+' '+FORMAT(-VLedger."Amount (LCY)")+' |';
                UNTIL VLedger.NEXT=0;
            END
            ELSE BEGIN
                StartPoint := VLedger.COUNT - 10;
                RCounter := 0;
                REPEAT
                    RCounter += 1;
                    VLedger.CALCFIELDS("Amount (LCY)");
                    IF RCounter > StartPoint THEN BEGIN
                        Statement += FORMAT(VLedger."Posting Date")+' '+VLedger.Description+' '+FORMAT(-VLedger."Amount (LCY)")+' |';
                    END;
                UNTIL VLedger.NEXT=0;
            END;
        END;
        */

        NewSMS := '';
        VLedger.Reset;
        VLedger.SetRange("Account No.", AccNo);
        VLedger.SetRange(Reversed, false);
        if VLedger.FindFirst then begin
            if VLedger.Count <= 10 then begin
                repeat
                    Statement += NewLine + Format(VLedger."Posting Date") + ': ' + VLedger.Description + ': ' + Format(-VLedger."Amount (LCY)");
                    if StrLen(Statement) < 200 then
                        NewSMS := Statement;

                until VLedger.Next = 0;
            end
            else begin
                StartPoint := VLedger.Count - 10;
                RCounter := 0;
                repeat
                    RCounter += 1;
                    if RCounter > StartPoint then begin
                        Statement += NewLine + Format(VLedger."Posting Date") + ': ' + VLedger.Description + ': ' + Format(-VLedger."Amount (LCY)");
                        if StrLen(Statement) < 200 then
                            NewSMS := Statement;
                    end;
                until VLedger.Next = 0;
            end;
        end;

    end;


    local procedure LoanMiniStatement(AccNo: Code[20]) Statement: Text
    var
        MLedger: Record "Credit Ledger Entry";
        StartPoint: Integer;
        RCounter: Integer;
        MemberNo: Code[20];
    begin
        Statement := '';

        if AccNo <> '' then begin
            MLedger.Reset;
            MLedger.SetRange("Loan No.", AccNo);
            MLedger.SetRange(Reversed, false);
            if MLedger.FindFirst then begin
                if MLedger.Count <= 10 then begin
                    repeat
                        MLedger.calcfields(Description);
                        Statement += NewLine + Format(MLedger."Posting Date") + ': ' + MLedger.Description + ': ' + Format(MLedger."Amount (LCY)");
                    until MLedger.Next = 0;
                end
                else begin
                    StartPoint := MLedger.Count - 10;
                    RCounter := 0;
                    repeat
                        MLedger.calcfields(Description);
                        RCounter += 1;
                        if RCounter > StartPoint then begin
                            Statement += NewLine + Format(MLedger."Posting Date") + ': ' + MLedger.Description + ': ' + Format(MLedger."Amount (LCY)");
                        end;
                    until MLedger.Next = 0;
                end;
            end;
        end;
    end;

    local procedure MpesaDeposit(TransCode: Code[20]) Success: Boolean
    var
        MTrans: Record "Spotcash Transactions";
    begin
        Success := false;
        Success := PostMobileTransaction(TransCode);
        //Success := true;
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

    local procedure WithdrawFunds(TransCode: Code[20]; AccountNo: Code[20]; Amount: Decimal; Date: Date; var response: Text; var response_message: Text; TransType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer") Success: Boolean
    var
        MTrans: Record "Spotcash Transactions";
        WithdrawalBuffer: Record "Mobile Withdrawal Buffer";
        MobileComm: Record "SpotCash Setup";
        SMSCharge: Decimal;
        SaccoFee: Decimal;
        DividendFee: Decimal;
        DivChargeAcc: Code[20];
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        AccBal: Decimal;
        Vendor: Record "Savings Accounts";
        SavAcc: Record "Savings Accounts";
        ProductSetup: Record "Product Setup";
        SafcomCharges: Record "Safcom Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        SAct: codeunit "Sacco Activities";
        Charges: Record "Transaction Charges Lines";
        SaccoSetup: Record "Sacco Setup";
        Member: Record Members;
    begin
        Success := false;
        MTrans.Get(TransCode);
        SaccoSetup.Get();
        MobileComm.Reset;
        MobileComm.SetRange("Transaction Type", TransType);
        if MobileComm.FindFirst then begin

            SMSCharge := MobileComm."SMS Charge";
            SaccoFee := MobileComm."Sacco Fee";
            VendorCommission := MobileComm."Vendor Commission";
            ExciseDutyRate := SaccoSetup."Excise Duty (%)";



            SafcomFee := 0;
            DividendFee := 0;
            if MTrans."Transaction Type" = MTrans."transaction type"::"Mpesa Withdrawal" then begin
                //MTrans.TESTFIELD("Reference No.");
                SafcomCharges.Reset;
                SafcomCharges.SetFilter(Charge, '>0');
                SafcomCharges.SetFilter(Minimum, '<=%1', MTrans.amount);
                SafcomCharges.SetFilter(Maximum, '>=%1', MTrans.amount);
                SafcomCharges.SetRange(Category, SafcomCharges.Category::Safaricom);
                if SafcomCharges.FindFirst then begin
                    SafcomFee := SafcomCharges.Charge;
                end;

                if MobileComm."Safcom Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(MobileComm."Safcom Staggered Charge", MTrans.Amount, SafcomFee, ChargeDuty, ChargeAcctType, ChargeAcct);

            end;

            if MTrans."Transaction Type" = MTrans."Transaction Type"::"Bank Transfer" then begin

                if MobileComm."Safcom Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(MobileComm."Safcom Staggered Charge", Amount, SafcomFee, ChargeDuty, ChargeAcctType, ChargeAcct);
            end;

            SaccoFee := MobileComm."Sacco Fee";
            if MobileComm."Sacco Staggered Fee" then
                MActivities.GetGeneralChargeAmountOnly(MobileComm."Sacco Staggered Charge", Amount, SaccoFee, ChargeDuty, ChargeAcctType, ChargeAcct);

            VendorCommission := MobileComm."Vendor Commission";
            if MobileComm."Vendor Staggered Fee" then
                MActivities.GetGeneralChargeAmountOnly(MobileComm."Vendor Staggered Charge", Amount, VendorCommission, ChargeDuty, ChargeAcctType, ChargeAcct);


            ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
            TotalCharge := SaccoFee + VendorCommission + SMSCharge + SafcomFee + ExciseDuty;
        end
        else begin
            Error('Setup Missing for %1', TransType);
        end;


        AccBal := AccountBalance(AccountNo);

        if Vendor.Get(AccountNo) then begin
            AccBal -= SAct.GetTotalArrears(Vendor."Member No.");
            if Vendor.Blocked <> Vendor.Blocked::" " then begin
                response := '39';
                response_message := 'Your Account is Blocked';
                MTrans.Remarks := response_message;
                MTrans.Failed := true;

                MTrans."Next Retry Date" := Today + 1;
                MTrans.Modify;

                exit;
            end;

            if ProductSetup.Get(Vendor."Product Type") then begin

                if ProductSetup."Savings Type" <> ProductSetup."Savings Type"::Withdrawable then begin

                    response := '39';
                    response_message := 'You cannot withdraw from this account';
                    MTrans.Remarks := response_message;
                    MTrans.Failed := true;

                    MTrans.Modify;

                    exit;
                end;

                if TransType = TransType::"Mpesa Withdrawal" then begin

                    if (Vendor.Status <> Vendor.Status::Active) and (Vendor.Status <> Vendor.Status::New) then begin
                        response := '39';
                        response_message := 'Your account is not active';
                        MTrans.Remarks := response_message;
                        MTrans.Failed := true;

                        MTrans.Modify;

                        exit;
                    end;

                    Member.Get(Vendor."Member No.");
                    If (Member."Member Status" <> Member."Member Status"::Active) and
                    (Member."Member Status" <> Member."Member Status"::New) then begin
                        response := '39';
                        response_message := 'Your account is not active';
                        MTrans.Remarks := response_message;
                        MTrans.Failed := true;

                        MTrans.Modify;

                        exit;
                    end;

                end;

                if ProductSetup."Savings Type" = ProductSetup."Savings Type"::Withdrawable then begin
                    if (ProductSetup."Product Category" <> ProductSetup."Product Category"::"Ordinary Savings") and
                        (ProductSetup."Product Category" <> ProductSetup."Product Category"::"Dividend Account") then begin

                        response := '39';
                        response_message := 'You cannot withdraw from this account';
                        MTrans.Remarks := response_message;
                        MTrans.Failed := true;

                        MTrans.Modify;

                        exit;

                    end;
                end;
            end;
        end;

        //Aziz
        IF Vendor."Product Category" = Vendor."Product Category"::"Dividend Account" THEN BEGIN

            //IF MpesaTrans."Transaction Type" <> MpesaTrans."Transaction Type"::"Bank Transfer" THEN BEGIN

            Charges.RESET;
            Charges.SETRANGE("Transaction Type", 'DIV');
            IF Charges.FINDFIRST THEN BEGIN
                Charges.TESTFIELD("Charge Account");
                DivChargeAcc := Charges."Charge Account";
                IF Charges."Percentage of Amount" > 0 THEN
                    DividendFee := ROUND(Charges."Percentage of Amount" / 100 * MTrans.amount)
                ELSE
                    DividendFee := Charges."Charge Amount";
            END;
            //END;
        END;

        if AccBal >= Amount + DividendFee + TotalCharge then begin

            WithdrawalBuffer.Init;
            WithdrawalBuffer."Trace ID" := TransCode;
            WithdrawalBuffer."Posting Date" := Date;
            WithdrawalBuffer.Source := WithdrawalBuffer.Source::"M-PESA";
            WithdrawalBuffer."Account No" := AccountNo;
            WithdrawalBuffer.Amount := Amount;

            WithdrawalBuffer."Transaction Date" := Date;// CREATEDATETIME(Date,TIME);
            WithdrawalBuffer.Description := Format(TransType);
            WithdrawalBuffer."Unit ID" := 'M-PESA';
            WithdrawalBuffer."Transaction Type" := Format(TransType);

            if TransType = TransType::"Mpesa Withdrawal" then
                WithdrawalBuffer."Transaction Type" := 'Withdrawal Request';
            if TransType = TransType::"Utility Payment" then
                WithdrawalBuffer."Transaction Type" := 'Utility Request';
            if TransType = TransType::"Bank Transfer" then
                WithdrawalBuffer."Transaction Type" := 'Bank Transfer Request';
            if TransType = TransType::Airtime then
                WithdrawalBuffer."Transaction Type" := 'Airtime Request';



            WithdrawalBuffer.Insert;

            response := '00';
            response_message := 'Success';
        end
        else begin
            IF Vendor."Product Category" = Vendor."Product Category"::"Dividend Account" THEN BEGIN
                Charges.RESET;
                Charges.SETRANGE("Transaction Type", 'DIV');
                IF Charges.FINDFIRST THEN begin
                    Charges.TESTFIELD("Charge Account");
                    DivChargeAcc := Charges."Charge Account";
                    IF Charges."Percentage of Amount" > 0 then
                        DividendFee := ROUND(Charges."Percentage of Amount" / 100 * AccBal)
                    else
                        DividendFee := Charges."Charge Amount";
                end;
            end;

            response := '01';
            response_message := 'You have insufficient balance. Your current withdrawable balance is KSH. ' + FORMAT(AccBal - (TotalCharge + DividendFee));
            MTrans.Remarks := response_message;
            MTrans.Failed := true;
            MTrans.Posted := true;
            MTrans."Next Retry Date" := Today + 1;
            MTrans.Modify;
            exit;
        end;

        Success := true;
    end;

    local procedure Airtime(TransCode: Code[20]) Success: Boolean
    var
        MTrans: Record "Spotcash Transactions";
    begin
        Success := false;

        PostMobileTransaction(TransCode);
        Success := true;
    end;

    local procedure InterAccount(TransCode: Code[20]) Success: Boolean
    var
        MTrans: Record "Spotcash Transactions";
    begin
        Success := false;

        PostMobileTransaction(TransCode);
        Success := true;
    end;

    local procedure getStatement(TransCode: Code[20]) Success: Text
    var
        MTrans: Record "Spotcash Transactions";
        Loans: Record Loans;
        Vendor: Record "Savings Accounts";
    begin
        Success := '';


        PostMobileTransaction(TransCode);

        MTrans.Reset;
        MTrans.SetRange(request_id, TransCode);
        if MTrans.FindFirst then begin
            Success := '';

            if Loans.Get(MTrans.account_number) then begin
                Success := LoanMiniStatement(MTrans.account_number);
            end
            else
                if Vendor.Get(MTrans.account_number) then begin
                    Success := FosaMiniStatement(MTrans.account_number);
                end
                else begin
                    //Success := BosaMiniStatement(MTrans.account_number);
                end;

        end;
    end;

    local procedure FosaStatement(AccNo: Code[20]) Statement: Text
    var
        VLedger: Record "Savings Ledger Entry";
        StartPoint: Integer;
        RCounter: Integer;
        LocalJsonText: Text;
        LocalMsgCode: Text;
    begin
        Statement := '';

        //JsonTreeInit;



        VLedger.Reset;
        VLedger.SetRange("Account No.", AccNo);
        VLedger.SetRange(Reversed, false);
        if VLedger.FindFirst then begin
            if VLedger.Count <= 10 then begin
                StartPoint := 0;
                RCounter := 0;
            end
            else begin
                StartPoint := VLedger.Count - 10;
                RCounter := 0;
            end;


            repeat
                RCounter += 1;
                if RCounter > StartPoint then begin

                    /*
                    LocalJSONTextWriter.WriteStartObject;

                    SaccoTrans.CreateLocalObject(LocalJSONTextWriter, 'transactionID', VLedger."Document No.", false);
                    SaccoTrans.CreateLocalObject(LocalJSONTextWriter, 'postingDate', VLedger."Posting Date", false);
                    SaccoTrans.CreateLocalObject(LocalJSONTextWriter, 'description', VLedger.Description, false);
                    SaccoTrans.CreateLocalObject(LocalJSONTextWriter, 'amount', VLedger."Amount (LCY)", false);

                    LocalJSONTextWriter.WriteEndObject;
                    */
                end;
            until VLedger.Next = 0;
            ;

        end;


        //LocalJsonText := LocalStringBuilder.ToString;
        //Statement := LocalJsonText;
    end;

    local procedure Utility(TransCode: Code[20]) Success: Boolean
    var
        MTrans: Record "Spotcash Transactions";
    begin
        Success := false;

        MTrans.Reset;
        MTrans.SetRange(request_id, TransCode);
        if MTrans.FindFirst then begin
            Success := true;
        end;
    end;

    local procedure PesaLinkDeposit(TransCode: Code[20]) Success: Boolean
    var
        MTrans: Record "Spotcash Transactions";
    begin
        Success := false;

        MTrans.Reset;
        MTrans.SetRange(request_id, TransCode);
        if MTrans.FindFirst then begin
            Success := true;
        end;
    end;

    local procedure PesaLinkWithdrawal(TransCode: Code[20]) Success: Boolean
    var
        MTrans: Record "Spotcash Transactions";
    begin
        Success := false;

        MTrans.Reset;
        MTrans.SetRange(request_id, TransCode);
        if MTrans.FindFirst then begin
            Success := true;
        end;
    end;


    procedure ReferAFriend(var firstName: Text; var lastName: Text; var phoneNo: Text; var gender: Text; var location: Text; var introducerPhone: Text; var responseCode: Text; var responseMessage: Text; var errorMessage: Text): Integer
    var
        LocalJsonText: Text;
        LocalMsgCode: Text;
        MemberAccounts: Record "Savings Accounts";
        Leads: Record Leads;
    begin
        responseCode := '';
        responseMessage := '';
        errorMessage := '';

        phoneNo := ConvertPhoneNoRemove(phoneNo);

        MemberAccounts.Reset;
        MemberAccounts.SetRange("Mobile Phone No.", phoneNo);
        //MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
        if MemberAccounts.FindFirst then begin

            responseCode := '07';
            responseMessage := 'Member Already Exits';
            errorMessage := 'Member Already Exits';

        end else begin
            //Init here
            Leads.Init();
            Leads."Mobile No." := phoneNo;
            Leads."First Name" := firstName;
            Leads."Last Name" := lastName;
            Leads.Gender := gender;
            Leads."Location" := location;
            Leads."Introducer Phone" := introducerPhone;
            Leads.Insert();

            responseCode := '00';
            responseMessage := 'Refer a Friend was Successful';
            errorMessage := ''

        end;
    end;


    procedure ProcessReversal(var requestID: Text; var responseCode: Text; var responseMessage: Text; var errorMessage: Text): Integer
    var
        LocalJsonText: Text;
        LocalMsgCode: Text;
        WithdrawalBuffer: Record "Mobile Withdrawal Buffer";
        MTrans: Record "Spotcash Transactions";
    begin
        responseCode := '';
        responseMessage := '';
        errorMessage := '';

        WithdrawalBuffer.Reset;
        WithdrawalBuffer.SetRange(WithdrawalBuffer."Trace ID", requestID);
        WithdrawalBuffer.SetRange(WithdrawalBuffer.Source, WithdrawalBuffer.Source::"M-PESA");
        WithdrawalBuffer.SetRange(Posted, false);
        if WithdrawalBuffer.Find('-') then begin

            if MTrans.Get(requestID) then begin
                MTrans.Posted := true;
                MTrans.Reversed := true;
                MTrans.Modify;

                WithdrawalBuffer.Reversed := true;
                WithdrawalBuffer.Posted := true;
                WithdrawalBuffer."Reversed Posted" := true;
                WithdrawalBuffer.Modify;

                responseCode := '00';
                responseMessage := 'Successfully Reversed';
            end;
        end
        else begin
            responseCode := '59';
            responseMessage := '';
            errorMessage := 'Document No not found for Reversal';
        end;
    end;

    local procedure FosaToBank(TransCode: Code[20]) Success: Boolean
    var
        MTrans: Record "Spotcash Transactions";
    begin
        Success := false;

        MTrans.Reset;
        MTrans.SetRange(request_id, TransCode);
        if MTrans.FindFirst then begin
            Success := true;
        end;
    end;


    procedure SpotcashRegistration(var responseCode: Text; var responseMessage: Text; var errorMessage: Text; var newMembersPayload: Text)
    var
        LocalJsonText: Text;
        LocalMsgCode: Text;
        MemberAccounts: Record "Savings Accounts";
        Members: Record "Savings Accounts";
        I: Integer;
        SkyMbanking: Codeunit "Sky MBanking";
    begin
        responseCode := '';
        responseMessage := '';
        errorMessage := '';



        responseCode := '00';
        responseMessage := 'SUCCESS';
        errorMessage := '';
        newMembersPayload := Registrations;


        Commit;

        /* for I := 1 to 5 do
             PostWithdrawals;
         for I := 1 to 5 do
             PostDeposits;
         //FOR I := 1 TO 5 DO
         //PostMiniBalance;

         PostTransactions;*/

    end;


    procedure Registrations() Response: Text
    var
        LocalJsonText: Text;
        LocalMsgCode: Text;
        CDate: Date;
        CTime: Time;
        Members: Record "Savings Accounts";
        MemberAccounts: Record "Savings Accounts";
        ProductSetup: Record "Product Setup";
        Found: Boolean;
        BosaBalance: Decimal;
        MPESAApplication: Record "MBanking Applications";
        OldApplications: Record "MPESA Applications";
        MLines: Record "MBanking Lines";
        OldLines: Record "MPESA Application Details";
        Vendor: Record "Savings Accounts";
        JsonAcc: JsonObject;
        JsonAccArray: JsonArray;
    begin

        Found := false;
        Response := '';

        OldApplications.Reset();
        OldApplications.SetRange(Status, OldApplications.Status::Approved);
        OldApplications.SetRange(Updated, false);
        if OldApplications.FindFirst() then begin
            repeat

                MPESAApplication.Reset;
                MPESAApplication.SetRange(No, OldApplications.No);
                if not MPESAApplication.FindFirst() then begin
                    MPESAApplication.Init();
                    MPESAApplication.No := OldApplications.No;
                    MPESAApplication."Date Entered" := OldApplications."Date Entered";
                    MPESAApplication."Time Entered" := OldApplications."Time Entered";
                    MPESAApplication."Entered By" := OldApplications."Entered By";
                    MPESAApplication."Customer ID No" := OldApplications."Customer ID No";
                    MPESAApplication."MPESA Mobile No" := OldApplications."MPESA Mobile No";
                    MPESAApplication.Status := MPESAApplication.Status::Approved;
                    MPESAApplication."Account No" := '';
                    MPESAApplication.Insert();

                    OldLines.Reset();
                    OldLines.SetRange("Application No", OldApplications.No);
                    OldLines.SetFilter("Account No.", '<>%1', '');
                    if OldLines.FindFirst() then begin
                        repeat
                            MLines.Reset();
                            MLines.SetRange("Application No", MPESAApplication.No);
                            if not MLines.FindFirst() then begin
                                MLines.Init();
                                MLines."Application No" := MPESAApplication.No;
                                MLines."Account No." := OldLines."Account No.";
                                if MLines.Insert() then begin
                                    MPESAApplication."Account No" := MLines."Account No.";
                                    MPESAApplication.Modify();
                                    OldApplications.Updated := true;
                                    OldApplications.Modify();
                                end;

                            end;
                        until OldLines.Next() = 0;
                    end;

                end;

            until OldApplications.Next() = 0;
        end;



        MPESAApplication.Reset;
        MPESAApplication.SetRange(MPESAApplication.Status, MPESAApplication.Status::Approved);
        MPESAApplication.SetFilter(MPESAApplication."Mpesa Mobile No", '<>%1', '');
        if MPESAApplication.FindFirst then begin

            // Found := TRUE;
            repeat
                if StrLen(MPESAApplication."Customer ID No") <= 20 then begin
                    Vendor.Reset;
                    Vendor.SetRange("ID No.", MPESAApplication."Customer ID No");
                    Vendor.SetFilter("Transactional Mobile No", MPESAApplication."Mpesa Mobile No");
                    Vendor.SetAutoCalcFields("ID No.");
                    if Vendor.FindFirst then begin
                        //            error('Count %1',Vendor.Count);
                        Found := true;
                        //LocalJSONTextWriter.WriteStartArray;
                        repeat
                            Clear(JsonAcc);
                            JsonAcc.Add('customer_name', Vendor.Name);
                            JsonAcc.Add('msisdn', ConvertPhoneNoRemove(Vendor."Transactional Mobile No"));
                            JsonAcc.Add('idno', Vendor."ID No.");

                            JsonAccArray.Add(JsonAcc);
                        until Vendor.Next = 0;
                        // LocalJSONTextWriter.WriteEndArray;
                    end;
                end;

            //MPESAApplication."Sent to SpotCash" := TRUE;
            //MPESAApplication.MODIFY;
            until MPESAApplication.Next = 0;

            JsonResult.Add('NewRegistrations', JsonAccArray);
            JsonResult.WriteTo(Response);



        end;



    end;


    procedure UpdateMpesaDetails(var spotCashID: Text; var mPESAID: Text; var phoneNo: Text; var responseCode: Text; var responseMessage: Text; var errorMessage: Text): Integer
    var
        LocalJsonText: Text;
        LocalMsgCode: Text;
    begin
        responseCode := '';
        responseMessage := '';
        errorMessage := '';
    end;


    procedure ValidateFinancials(var spotCashID: Text; var referenceid: Text; var phoneNo: Text; var responseCode: Text; var responseMessage: Text; var errorMessage: Text): Integer
    var
        LocalJsonText: Text;
        LocalMsgCode: Text;
        MemberAccounts: Record "Savings Accounts";
        WithdrawalBuffer: Record "Mobile Withdrawal Buffer";
        MTrans: Record "Spotcash Transactions";
    begin
        responseCode := '';
        responseMessage := '';
        errorMessage := '';



        MBSEloanLogs.Init;
        MBSEloanLogs.Guid := CreateGuid;
        MBSEloanLogs.Date := Today;
        MBSEloanLogs.Time := Time;
        MBSEloanLogs.PhoneNo := phoneNo;
        MBSEloanLogs.SpotCashID := spotCashID;
        MBSEloanLogs.ReferenceID := referenceid;
        if MBSEloanLogs.Insert then
            Commit;


        phoneNo := ConvertPhoneNo(phoneNo);

        MemberAccounts.Reset;
        MemberAccounts.SetRange("Transactional Mobile No", phoneNo);
        if MemberAccounts.FindFirst then begin

            WithdrawalBuffer.Reset;
            WithdrawalBuffer.SetRange(WithdrawalBuffer."Trace ID", spotCashID);
            WithdrawalBuffer.SetRange(WithdrawalBuffer.Source, WithdrawalBuffer.Source::"M-PESA");
            //WithdrawalBuffer.SETRANGE(WithdrawalBuffer."Account No",MemberAccounts."No.");
            WithdrawalBuffer.SetRange(Posted, false);
            if WithdrawalBuffer.Find('-') then begin
                if MTrans.Get(spotCashID) then begin
                    MTrans."Reference No." := referenceid;
                    MTrans.Modify;
                    Commit;

                    PostMobileTransaction(MTrans.request_id);

                    WithdrawalBuffer.Posted := true;
                    WithdrawalBuffer.Modify;
                    responseCode := '00';
                    if MTrans."Transaction Type" = MTrans."transaction type"::"Bank Transfer" then
                        responseMessage := 'Bank Transfer Successful';
                    if MTrans."Transaction Type" = MTrans."transaction type"::"Mpesa Withdrawal" then
                        responseMessage := 'Withdrawal Successful';
                    if MTrans."Transaction Type" = MTrans."transaction type"::Airtime then
                        responseMessage := 'Airtime Purchase Successful';
                    if MTrans."Transaction Type" = MTrans."transaction type"::"Utility Payment" then
                        responseMessage := 'Utility Payment Successful';
                end;
            end else begin
                WithdrawalBuffer.Reset;
                WithdrawalBuffer.SetRange(WithdrawalBuffer."Trace ID", spotCashID);
                WithdrawalBuffer.SetRange(WithdrawalBuffer.Source, WithdrawalBuffer.Source::"M-PESA");
                WithdrawalBuffer.SetRange(Posted, true);
                if WithdrawalBuffer.Find('-') then begin
                    responseCode := '00';
                    responseMessage := 'Successful'
                end else begin
                    responseCode := '06';
                    responseMessage := '';
                    errorMessage := 'Transaction Not Found';
                end;
            end;
        end
        else begin
            responseCode := '08';
            responseMessage := '';
            errorMessage := 'Member Account not found';
        end;
    end;


    procedure ClearTransactions(): Integer
    var
        LocalJsonText: Text;
        LocalMsgCode: Text;
        MemberAccounts: Record "Savings Accounts";
        WithdrawalBuffer: Record "Mobile Withdrawal Buffer";
        MTrans: Record "Spotcash Transactions";
    begin



        WithdrawalBuffer.Reset;
        WithdrawalBuffer.SetRange("Spotcash Transaction Posted", true);
        WithdrawalBuffer.SetRange(Posted, false);
        if WithdrawalBuffer.Find('-') then begin
            repeat
                MTrans.Reset();
                MTrans.SetRange(request_id, WithdrawalBuffer."Trace ID");
                if MTrans.FindFirst() then begin
                    WithdrawalBuffer.Posted := true;
                    WithdrawalBuffer.Modify();
                end;
            until WithdrawalBuffer.Next() = 0;
        end;

    end;

    procedure MobileLoanProcessing(mobile_no: Text; Period: Integer; LoanProduct: Text; doc_no: Text; loan_amount: Decimal; var Response: Text; var Stop: Boolean; var ResponseCode: Text): Text
    var
        Remark: Text;
        LocalisDetected: Boolean;
        LocalErrMsg: Text;
        Sky: Codeunit "Sky MBanking";

        LocalStringWriter: Text;

        LocalJsonText: Text;
        LocalMsgCode: Text;
        CDate: Date;
        CTime: Time;
        Members: Record Members;
        MemberAccounts: Record "Savings Accounts";
        SLedger: Record "Savings Ledger Entry";
        SDate: Date;
        EDate: Date;
        TestDate: Date;
        Loans: Record Loans;
        QualAmt: Decimal;
        MobileLoans: Record "Sky Mobile Loans";
        account_no: Text;
        LoanType: Record "Product Setup";
        DividendAdvance: Record "Dividend Advance";
        DividendAdvanceDefaulter: Record "Dividend Advance - Defaulter";
        eLoanBal: Decimal;
        ResCode: Text[10];
    begin

        Response := '';
        ResponseCode := '';



        mobile_no := ConvertPhoneNo(mobile_no);

        MobileLoans.Reset;
        MobileLoans.SetRange("DocumentNo", doc_no);
        if MobileLoans.FindFirst then begin
            Response := 'Loan Application already exists';
            ResponseCode := '99';
            Stop := true;
        end
        else begin


            if LoanType.Get(LoanProduct) then begin

                account_no := '';

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Transactional Mobile No", mobile_no);
                if MemberAccounts.FindFirst then begin

                    account_no := MemberAccounts."No.";
                    Stop := false;


                    Members.Get(MemberAccounts."Member No.");

                    if not Stop then begin


                        QualAmt := 0;// ThibitiEligibility(mobile_no,LoanProduct);


                        //if (LoanProduct = 'L30') or (LoanProduct = 'L24') or (LoanProduct = 'L27') or (LoanProduct = 'L43') then begin

                        if LoanProduct = 'L43' then begin
                            sky.GetDividendLoanQualifiedAmount(MemberAccounts."No.", LoanType."Product ID", QualAmt, Remark);
                        end else
                            Sky.GetLoanQualifiedAmount(MemberAccounts."No.", LoanType."Product ID", QualAmt, Remark, ResCode);

                        QualAmt -= eLoanBal;

                        //end;

                        if LoanType."Maximum Loan Amount" > 0 then
                            if QualAmt > LoanType."Maximum Loan Amount" then
                                QualAmt := LoanType."Maximum Loan Amount";

                        if QualAmt < 0 then
                            QualAmt := 0;

                        if QualAmt >= loan_amount then begin
                            Response := Success;
                            Stop := false;

                            MobileLoans.Init;
                            MobileLoans."Entry No" := CreateGuid();

                            MobileLoans.Channel := MobileLoans.Channel::SpotCash;
                            MobileLoans."Account No" := account_no;
                            MobileLoans."Account Name" := MemberAccounts.Name;
                            MobileLoans."Member No" := MemberAccounts."Member No.";
                            MobileLoans."Member No." := MemberAccounts."Member No.";
                            MobileLoans.Name := MemberAccounts.Name;
                            MobileLoans.Date := CurrentDatetime;
                            MobileLoans."Requested Amount" := loan_amount;
                            MobileLoans."Loan Period" := LoanType."Default Installments";
                            MobileLoans.Status := MobileLoans.Status::Pending;
                            MobileLoans."Loan Product Type" := LoanType."Product ID";
                            MobileLoans.Amount := loan_amount;
                            MobileLoans."DocumentNo" := doc_no;
                            MobileLoans."Date Entered" := Today;
                            MobileLoans."Time Entered" := Time;
                            MobileLoans."Telephone No" := MemberAccounts."Transactional Mobile No";

                            //if (MobileLoans."Loan Product Type" = 'L30') or (MobileLoans."Loan Product Type" = 'L24') or (MobileLoans."Loan Product Type" = 'L27') then
                            MobileLoans."Loan Purpose" := '8310';

                            MobileLoans.Insert;
                            Commit();

                            Sky.ProcessMobileLoan(MobileLoans."Entry No", Stop);

                            //Stop := false;
                        end
                        else begin
                            Response := 'The amount applied is greater than your eligibility of KES ' + Format(QualAmt);
                            ResponseCode := '47';
                            Stop := true;
                        end;
                    end;

                end
                else begin
                    Stop := true;
                    Response := 'Account Not found';
                    ResponseCode := '39';
                end;
            end;

        end;
        //ERROR(Response);

    end;


    procedure InsertMobileTransaction(TransactionID: Code[20]; TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer"; TransactionDate: Date; Description: Text[100]; AccountNo: Code[20]; Amount: Decimal; PhoneNo: Code[20]; PIN: Text; RequestApplication: Text; RequestCorrelationID: Text; SourceApplication: Text; unique_id: Text) Response: Text
    var
        LocalisDetected: Boolean;
        LocalErrMsg: Text;

        LocalStringWriter: Text;

        LocalJsonText: Text;
        LocalMsgCode: Text;
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        MpesaTrans: Record "Spotcash Transactions";
        Continue: Boolean;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        AccBal: Decimal;
        SafcomCharges: Record "Safcom Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        MemberID: Code[20];
        PrePaymentGL: Code[20];
        Loans: Record Loans;
        LoanNo: Code[20];
        MemberNo: Code[20];
        Type: Option Daily,Weekly,Monthly;
        Limit: Decimal;
        msg: Text;
        SacAcc: Code[20];
        EmpRestrict: Code[20];
        "Key": Text;
        LBal: Decimal;
        PayBillAcc: Code[20];
        MCommission: Record "SpotCash Setup";
    begin
        /*
        Response := '';
        
        MpesaTrans.RESET;
        MpesaTrans.SETRANGE(request_id, TransactionID);
        IF MpesaTrans.FINDFIRST THEN BEGIN
            Response := 'Transaction Already Exists';
            EXIT;
        END;
        
        // Get Excise duty G/L
        ExciseDutyGL := GetExciseDutyGL();
        ExciseDutyRate := GetExciseRate();
        ExciseDuty:=0;
        
        SafcomFee:=0;
        SaccoFee:=0;
        VendorCommission:=0;
        PrePaymentGL:='';
        
        
        MCommission.RESET;
        MCommission.SETRANGE("Transaction Type",TransactionType);
        IF MCommission.FINDFIRST THEN BEGIN
        
        
            IF (TransactionType = TransactionType::"Mpesa Withdrawal") THEN BEGIN
                IF MCommission."Transaction Limit" > 0 THEN BEGIN
                    IF Amount > MCommission."Transaction Limit"THEN BEGIN
                        Response := 'Your Transaction Amount Exceeds the Set Limit';
                        EXIT;
                    END;
                END;
        
                IF MCommission."Daily Limit" > 0 THEN BEGIN
                    Limit := MCommission."Daily Limit" - GetAmountTransacted(TransactionType,AccountNo,TransactionDate,Type::Daily,TransactionType);
        
                    IF Limit < 0 THEN
                        Limit := 0;
        
                    IF  Limit < Amount THEN BEGIN
                        Response := 'Your daily Transaction Limit has been Exceeded';
                        EXIT;
                    END;
                END;
                IF MCommission."Weekly Limit" > 0 THEN BEGIN
                    Limit := MCommission."Weekly Limit" - GetAmountTransacted(TransactionType,AccountNo,TransactionDate,Type::Weekly,TransactionType);
        
                    IF Limit < 0 THEN
                        Limit := 0;
        
                    IF  Limit < Amount THEN BEGIN
                        Response := 'Your weekly Transaction Limit has been Exceeded';
                        EXIT;
                    END;
        
                END;
                IF MCommission."Monthly Limit" > 0 THEN BEGIN
                    Limit := MCommission."Monthly Limit" - GetAmountTransacted(TransactionType,AccountNo,TransactionDate,Type::Monthly,TransactionType);
        
                    IF Limit < 0 THEN
                        Limit := 0;
        
                    IF  Limit < Amount THEN BEGIN
                        Response := 'Your monthly Transaction Limit has been Exceeded';
                        EXIT;
                    END;
                END;
        
            END;
        
        
            IF TransactionType = TransactionType::"Mpesa Withdrawal" THEN BEGIN
                SafcomCharges.RESET;
                SafcomCharges.SETFILTER(Charge,'>0');
                SafcomCharges.SETFILTER(Minimum,'<=%1',Amount);
                SafcomCharges.SETFILTER(Maximum,'>=%1',Amount);
                SafcomCharges.SETRANGE(Category,SafcomCharges.Category::Safaricom);
                IF SafcomCharges.FINDFIRST THEN BEGIN
                    SafcomFee:=SafcomCharges.Charge;
                END;
            END;
            IF TransactionType = TransactionType::"Bank Transfer" THEN BEGIN
                SafcomCharges.RESET;
                SafcomCharges.SETFILTER(Charge,'>0');
                SafcomCharges.SETFILTER(Minimum,'<=%1',Amount);
                SafcomCharges.SETFILTER(Maximum,'>=%1',Amount);
                SafcomCharges.SETRANGE(Category,SafcomCharges.Category::Bank);
                IF SafcomCharges.FINDFIRST THEN BEGIN
                    SafcomFee:=SafcomCharges.Charge;
                END;
            END;
        
            PrePaymentGL := MCommission."Pre-Payment Account";
            SaccoFee := MCommission."Sacco Fee";
            VendorCommission:=MCommission."Vendor Commission";
        
            IF MCommission."Charge Type" = MCommission."Charge Type"::Staggered THEN BEGIN
                SacAcc := '';
                GetChargeAmount(MCommission."Staggered Charge Code",SaccoFee,SacAcc,Amount,SafcomFee,VendorCommission);
            END;
            TotalCharge:=SaccoFee+VendorCommission+SafcomFee;
            ExciseDuty:=ROUND((SaccoFee)*ExciseDutyRate/100);
        
        
        END
        ELSE BEGIN
        
            ERROR('Setup Missing for '+FORMAT(TransactionType));
        
        END;
        
        
        IF SavAcc.GET(AccountNo) THEN BEGIN
        
            IF (TransactionType = TransactionType::"Mpesa Withdrawal")  THEN BEGIN
        
                IF (SavAcc.Status <> SavAcc.Status::Active) OR (SavAcc.Blocked <> SavAcc.Blocked::" ") THEN BEGIN
                    Response := 'Account Not Active';
                    EXIT;
                END;
        
                AccBal := AccountBalance(SavAcc."No.");
                IF (AccBal >= Amount+TotalCharge+ExciseDuty) THEN BEGIN
        
        
                    MobileWithdrawalsBuffer.RESET;
                    MobileWithdrawalsBuffer.SETRANGE("Trace ID", TransactionID);
                    IF MpesaTrans.FINDFIRST THEN BEGIN
                        Response := 'Transaction Already Exists';
                        EXIT;
                    END;
        
        
                    MobileWithdrawalsBuffer.INIT;
                    MobileWithdrawalsBuffer."Trace ID" := TransactionID;
                    MobileWithdrawalsBuffer."Transaction Date" := CREATEDATETIME(TransactionDate,TIME);
                    MobileWithdrawalsBuffer."Account No" := AccountNo;
                    MobileWithdrawalsBuffer.Description := COPYSTR(Description,1,50);
                    MobileWithdrawalsBuffer.Amount := Amount;
                    MobileWithdrawalsBuffer."Unit ID" := 'M-PESA';
                    MobileWithdrawalsBuffer."Transaction Type" := FORMAT(TransactionType);
                    MobileWithdrawalsBuffer.Source: := MobileWithdrawalsBuffer.Source::"M-PESA";
                    MobileWithdrawalsBuffer."Withdrawal Type" := Transaction;
                    MobileWithdrawalsBuffer.INSERT;
        
        
        
                    Priority := 211;
                    msg := 'Dear member, your '+Transaction+' has been received successfully. Kindly wait shortly as we process this request. Transaction ID: '+FORMAT(TransactionID);
                    SendSmsWithID(Source::MBANKING,SavAcc."Transactional Mobile No",msg,AccountNo,'',TRUE,0,FALSE, RequestApplication, RequestCorrelationID, SourceApplication);
        
        
                    LocalJSONTextWriter.WriteStartObject;
                    SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'status_code',Success,FALSE);
                    SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'Description','Success',FALSE);
                    SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'unique_id',unique_id,FALSE);
                    SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'reference',TransactionID,FALSE);
                    SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'Success',TRUE,FALSE);
                    LocalJSONTextWriter.WriteEndObject;
        
                    LocalJsonText:=LocalStringBuilder.ToString;
                    EXIT(LocalJsonText);
        
                END
                ELSE BEGIN
        
                    LocalJSONTextWriter.WriteStartObject;
                    SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'status_code',Severe_problem_Has_Occured,FALSE);
                    SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'Description','Insufficient Account Balance',FALSE);
                    SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'unique_id',unique_id,FALSE);
                    SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'reference',EntryCode,FALSE);
                    SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'Success',FALSE,FALSE);
                    LocalJSONTextWriter.WriteEndObject;
        
                    LocalJsonText:=LocalStringBuilder.ToString;
                    EXIT(LocalJsonText);
        
                END;
            END
            ELSE BEGIN
        
                MpesaTrans.INIT;
                MpesaTrans."Entry No.":=EntryCode;
                MpesaTrans.request_id:=TransactionID;
                MpesaTrans."Session ID":=TransactionID;
                MpesaTrans."Transaction Type" := TransactionType;
                MpesaTrans."Transaction Name" := Transaction;
                MpesaTrans.Description:=COPYSTR(Description,1,50);;
                MpesaTrans."Transaction Date":=DT2DATE(TransactionDate);
                MpesaTrans."Transaction Time":=DT2TIME(TransactionDate);
                MpesaTrans.account_number:=AccountNo;
                MpesaTrans.Amount:=Amount;
                MpesaTrans."Loan No." := LoanNo;
                MpesaTrans."Mobile No." := PhoneNo;
                MpesaTrans."Vendor Commission":=VendorCommission;
                MpesaTrans."Sacco Fee":=SaccoFee;
                MpesaTrans."Paybill Member ID" := MemberID;
                MpesaTrans.INSERT;
        
        
                LocalJSONTextWriter.WriteStartObject;
                SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'status_code',Success,FALSE);
                SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'Description','Success',FALSE);
                SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'unique_id',unique_id,FALSE);
                SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'reference',EntryCode,FALSE);
                SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'Success',TRUE,FALSE);
                LocalJSONTextWriter.WriteEndObject;
        
                LocalJsonText:=LocalStringBuilder.ToString;
                EXIT(LocalJsonText);
        
        
                //PostMobileTransaction(TransactionID);
            END;
        
        END
        ELSE BEGIN
            //IF (TransactionType = TransactionType::"Bank Deposit") OR (TransactionType = TransactionType::"Bank Agent Deposit") THEN BEGIN
        
                MpesaTrans.INIT;
                MpesaTrans."Entry No.":=EntryCode;
                MpesaTrans.request_id:=TransactionID;
                MpesaTrans."Session ID":=TransactionID;
                MpesaTrans."Transaction Type" := TransactionType;
                MpesaTrans."Transaction Name" := Transaction;
                MpesaTrans.Description:=COPYSTR(Description,1,50);;
                MpesaTrans."Transaction Date":=DT2DATE(TransactionDate);
                MpesaTrans."Transaction Time":=DT2TIME(TransactionDate);
                MpesaTrans.account_number:=AccountNo;
                MpesaTrans.Amount:=Amount;
                MpesaTrans."Loan No." := LoanNo;
                MpesaTrans."Mobile No." := PhoneNo;
                MpesaTrans."Vendor Commission":=VendorCommission;
                MpesaTrans."Sacco Fee":=SaccoFee;
                MpesaTrans."Needs Change" := TRUE;
                MpesaTrans."Paybill Member ID" := MemberID;
                MpesaTrans.INSERT;
        
        
                LocalJSONTextWriter.WriteStartObject;
                SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'status_code',Success,FALSE);
                SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'Description','Success',FALSE);
                SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'unique_id',unique_id,FALSE);
                SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'reference',EntryCode,FALSE);
                SaccoTrans.CreateLocalObject(LocalJSONTextWriter,'Success',TRUE,FALSE);
                LocalJSONTextWriter.WriteEndObject;
        
                LocalJsonText:=LocalStringBuilder.ToString;
                EXIT(LocalJsonText);
        
            //END
            ///ELSE
               // ERROR('Account Not Found');
        
        END;
        
        LocalJsonText:=LocalStringBuilder.ToString;
        EXIT(LocalJsonText);
         */

    end;


    procedure PostMobileTransaction(DocumentNo: Code[20]) Response: Boolean
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
        MpesaTrans: Record "Spotcash Transactions";
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
        IntRate: Decimal;
        MemberName: Text;
        Depositor: Text;
        GenSetup: Record "Sacco Setup";
        DepDesc: Text;
        MobileNo: Code[20];
        BLedger: Record "Bank Account Ledger Entry";
        SMSAccount: Text;
        SMSCharge: Decimal;
        MCommission: Record "SpotCash Setup";
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

        /*
        if DocumentNo = 'SSPDSP21AIR42942' then begin
            MpesaTrans.RESET;
            MpesaTrans.SETRANGE(request_id,DocumentNo);
            if MpesaTrans.findfirst then begin
                MpesaTrans.Posted := False
                ;
                MpesaTrans.modify;
                exit;
            end;
            message('est');
        end;
        */
        PrincipalArrears := 0;
        InterestArrears := 0;
        DividendFee := 0;


        Response := false;
        MpesaTrans.Reset;
        //MpesaTrans.SETFILTER("Transaction Type",'%1',MpesaTrans."Transaction Type"::"Loan Repayment");
        MpesaTrans.SetFilter("Transaction Type", '<>%1&<>%2', MpesaTrans."transaction type"::"Mini-Statement", MpesaTrans."transaction type"::"Balance Enquiry");
        MpesaTrans.SetRange(request_id, DocumentNo);
        MpesaTrans.SetRange(Posted, false);
        MpesaTrans.SetRange("Needs Change", false);

        GenSetup.Get;
        //IF GenSetup."MBanking Posting Date" <> 0D THEN
        //  MpesaTrans.SETRANGE("Transaction Date",GenSetup."MBanking Posting Date");


        if MpesaTrans.FindFirst then begin


            if MpesaTrans.description = '' then
                MpesaTrans.description := Format(MpesaTrans."Transaction Type");
            if MpesaTrans.description = '[string]' then
                MpesaTrans.description := Format(MpesaTrans."Transaction Type");

            if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill then begin

                SavAcc.reset();
                SavAcc.SetRange("No.", MpesaTrans.account_number);
                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Dividend Account");
                if SavAcc.FindFirst() then begin
                    MpesaTrans.Posted := false;
                    MpesaTrans.Failed := false;
                    MpesaTrans."Needs Change" := true;
                    MpesaTrans.Remarks := 'You cannot deposit to dividend account';
                    MpesaTrans.Modify;
                    exit;
                end;

            end;



            GenSetup.Get;

            BLedger.Reset;
            BLedger.SetRange("Document No.", MpesaTrans.request_id);
            if DocumentNo <> 'SSPDSP21AIR42942' then
                if BLedger.FindFirst then begin
                    MpesaTrans."Needs Change" := false;
                    MpesaTrans.Posted := true;
                    MpesaTrans.Failed := false;
                    MpesaTrans."Needs Change" := false;
                    MpesaTrans.Remarks := 'Already Posted';
                    MpesaTrans.Modify;
                    exit;
                end;



            BLedger.Reset;
            BLedger.SetRange("Document No.", MpesaTrans."Reference No.");
            if DocumentNo <> 'SSPDSP21AIR42942' then
                if BLedger.FindFirst then begin
                    MpesaTrans."Needs Change" := false;
                    MpesaTrans.Posted := true;
                    MpesaTrans.Failed := false;
                    MpesaTrans."Needs Change" := false;
                    MpesaTrans.Remarks := 'Already Posted';
                    MpesaTrans.Modify;
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

            MCommission.Reset;
            MCommission.SetRange("Transaction Type", MpesaTrans."Transaction Type");
            if MCommission.FindFirst then begin

                SMSAccount := MCommission."SMS Account";
                SMSCharge := MCommission."SMS Charge";


                if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Withdrawal" then begin
                    MpesaTrans.TestField("Reference No.");
                    SafcomCharges.Reset;
                    SafcomCharges.SetFilter(Charge, '>0');
                    SafcomCharges.SetFilter(Minimum, '<=%1', MpesaTrans.amount);
                    SafcomCharges.SetFilter(Maximum, '>=%1', MpesaTrans.amount);
                    SafcomCharges.SetRange(Category, SafcomCharges.Category::Safaricom);
                    if SafcomCharges.FindFirst then begin
                        SafcomFee := SafcomCharges.Charge;
                    end;
                end;

                if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Withdrawal" then begin

                    SafcomCharges.Reset;
                    SafcomCharges.SetFilter(Charge, '>0');
                    SafcomCharges.SetFilter(Minimum, '<=%1', MpesaTrans.amount);
                    SafcomCharges.SetFilter(Maximum, '>=%1', MpesaTrans.amount);
                    SafcomCharges.SetRange(Category, SafcomCharges.Category::Bank);
                    if SafcomCharges.FindFirst then begin
                        SafcomFee := SafcomCharges.Charge;
                    end;
                end;

                PrePaymentGL := MCommission."Pre-Payment Account";
                SafcomAcc := MCommission."Safaricom Account";
                SaccoAccount := MCommission."Sacco Fee Account";
                SaccoFee := MCommission."Sacco Fee";


                if MpesaTrans.account_number <> '' then
                    if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill then begin
                        MpesaTrans."Account No." := MpesaTrans.account_number;

                        Members.Reset();
                        Members.SetRange("ID No.", MpesaTrans.account_number);
                        if Members.FindFirst() then begin
                            MpesaTrans.account_number := Members."No.";
                        end;

                        if not SavAcc.Get(MpesaTrans.account_number) then
                            if not Members.Get(MpesaTrans.account_number) then begin
                                MAccNo := '';
                                Sky.GetAccountFromKeyWord(MpesaTrans.account_number, MAccNo, LoanAccount, DepositAccount, IDNo, MNo, BosaTransType, Key, LNo);
                                if MAccNo <> '' then begin
                                    MpesaTrans.account_number := MAccNo;
                                end;
                            end;



                        MpesaTrans.Modify();

                    end;


                if SavAcc.Get(MpesaTrans.account_number) then begin

                    //Aziz
                    IF SavAcc."Product Category" = SavAcc."Product Category"::"Dividend Account" THEN BEGIN

                        //IF MpesaTrans."Transaction Type" <> MpesaTrans."Transaction Type"::"Bank Transfer" THEN BEGIN

                        Charges.RESET;
                        Charges.SETRANGE("Transaction Type", 'DIV');
                        IF Charges.FINDFIRST THEN BEGIN
                            Charges.TESTFIELD("Charge Account");
                            DivChargeAcc := Charges."Charge Account";
                            IF Charges."Percentage of Amount" > 0 THEN
                                DividendFee := ROUND(Charges."Percentage of Amount" / 100 * MpesaTrans.amount)
                            ELSE
                                DividendFee := Charges."Charge Amount";
                        END;
                        //END;
                    END;

                end;



                VendorAccount := MCommission."Bank Account";
                VendorCommission := MCommission."Vendor Commission";


                SaccoFee := MCommission."Sacco Fee";
                if MCommission."Sacco Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(MCommission."Sacco Staggered Charge", MpesaTrans.Amount, SaccoFee, ChargeDuty, ChargeAcctType, ChargeAcct);

                VendorCommission := MCommission."Vendor Commission";
                if MCommission."Vendor Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(MCommission."Vendor Staggered Charge", MpesaTrans.Amount, VendorCommission, ChargeDuty, ChargeAcctType, ChargeAcct);

                if MCommission."Safcom Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(MCommission."Safcom Staggered Charge", MpesaTrans.Amount, SafcomFee, ChargeDuty, ChargeAcctType, ChargeAcct);


                TotalCharge := SaccoFee + VendorCommission + SafcomFee + DividendFee + SMSCharge;
                ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
            end
            else begin
                if MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Pay Loan From Account" then
                    Error('Setup Missing for %1', MpesaTrans."Transaction Type");
            end;

            //ERROR('SafcomFee %1\SaccoFee %2',SafcomFee,SaccoFee);

            if (SavAcc.Get(MpesaTrans.account_number)) or ((Members.Get(MpesaTrans.account_number) and (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill))) then begin

                if ((Members.Get(MpesaTrans.account_number) and (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill))) then begin
                    SavAcc.Reset();
                    SavAcc.SetRange("Member No.", Members."No.");
                    SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Ordinary Savings");
                    SavAcc.FindFirst();

                end;


                MemberName := SavAcc."No.";
                TransAmt := MpesaTrans.amount;
                AccountToCharge := '';
                MobileNo := '';

                DimID := 0;

                if Members."Member Status" = Members."Member Status"::Deceased then begin
                    MpesaTrans."Needs Change" := true;
                    MpesaTrans.Posted := false;
                    MpesaTrans.Failed := true;
                    MpesaTrans.Remarks := 'You cannot transact on a deceased account.';
                    MpesaTrans.Modify;
                    exit;
                end;

                if SavAcc.Status = SavAcc.Status::Deceased then begin
                    MpesaTrans."Needs Change" := true;
                    MpesaTrans.Posted := false;
                    MpesaTrans.Failed := true;
                    MpesaTrans.Remarks := 'You cannot transact on a deceased account.';
                    MpesaTrans.Modify;
                    exit;
                end;

                if SavAcc.Status = SavAcc.Status::Withdrawn then begin
                    MpesaTrans."Needs Change" := true;
                    MpesaTrans.Posted := false;
                    MpesaTrans.Failed := true;
                    MpesaTrans.Remarks := 'You cannot transact on a Withdrawn account.';
                    MpesaTrans.Modify;
                    exit;
                end;

                if Members."Member Status" = Members."Member Status"::Withdrawn then begin
                    MpesaTrans."Needs Change" := true;
                    MpesaTrans.Posted := false;
                    MpesaTrans.Failed := true;
                    MpesaTrans.Remarks := 'You cannot transact on a withdrawn account.';
                    MpesaTrans.Modify;
                    exit;
                end;

                if Members.Blocked = Members.Blocked::All then begin
                    //MpesaTrans.Posted := true;
                    MpesaTrans.Failed := true;
                    MpesaTrans."Needs Change" := true;
                    MpesaTrans.Remarks := 'You cannot transact on a blocked [All] account.';
                    MpesaTrans.Modify;
                    exit;
                end;

                BillAcc.Reset;
                BillAcc.SetRange("Member No.", SavAcc."Member No.");
                BillAcc.SETRANGE("Product Category", BillAcc."Product Category"::"Ordinary Savings");
                if BillAcc.FindFirst then begin
                    AccountToCharge := BillAcc."No.";
                    MobileNo := BillAcc."Transactional Mobile No";
                end;

                if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Loan Repayment") or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill) or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Deposit") or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Deposit") or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Agent Deposit") or
                    (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Pay Loan From Account")
                    then
                    TransAmt := TransAmt * -1;

                if TransAmt >= 0 then begin
                    if SavAcc.Blocked <> SavAcc.Blocked::" " then begin
                        if (MpesaTrans."Transaction Type" <> MpesaTrans."Transaction Type"::Paybill) and (MpesaTrans."Transaction Type" <> MpesaTrans."Transaction Type"::"Loan Repayment") then begin
                            MpesaTrans."Needs Change" := true;
                            MpesaTrans.Remarks := 'Account Blocked';
                            MpesaTrans.Modify;
                            exit;
                        end;
                    end;
                end;

                if TransAmt < 0 then begin
                    if (SavAcc.Blocked <> SavAcc.Blocked::" ") then begin
                        if (MpesaTrans."Transaction Type" <> MpesaTrans."Transaction Type"::Paybill) and (MpesaTrans."Transaction Type" <> MpesaTrans."Transaction Type"::"Loan Repayment") then begin
                            MpesaTrans."Needs Change" := true;
                            MpesaTrans.Remarks := 'Account Blocked';
                            MpesaTrans.Modify;
                            exit;
                        end;
                    end;
                end;

                if (SavAcc.Blocked = SavAcc.Blocked::All) then begin
                    if (MpesaTrans."Transaction Type" <> MpesaTrans."Transaction Type"::Paybill) and (MpesaTrans."Transaction Type" <> MpesaTrans."Transaction Type"::"Loan Repayment") then begin
                        MpesaTrans."Needs Change" := true;
                        MpesaTrans.Remarks := 'Account Blocked';
                        MpesaTrans.Modify;
                        exit;
                    end;
                end;

                BUser.GET(USERID);

                BUser.TESTFIELD("CashRec Journal Batch");
                BUser.TESTFIELD("CashRec Journal Template");

                JTemplate := BUser."CashRec Journal Template";
                JBatch := BUser."CashRec Journal Batch";


                if MpesaTrans.transaction = 600 then
                    BankAccount := GenSetup."Sacco Paybill Bank"
                else
                    BankAccount := MCommission."Bank Account";

                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                GenJournalBatch.SetRange(Name, JBatch);
                if not GenJournalBatch.FindFirst then begin
                    GenJournalBatch.Init;
                    GenJournalBatch."Journal Template Name" := JTemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.Description := 'Tangazo Batch';
                    GenJournalBatch.Insert;
                end;

                DocNo := MpesaTrans.request_id;
                //if MpesaTrans."Reference No." <> '' then
                //  DocNo := MpesaTrans."Reference No.";

                PDate := MpesaTrans."Transaction Date";

                //if PDate < CalcDate('-CM', Today) then //to be uncommented
                PDate := Today;

                AccNo := MpesaTrans.account_number;
                if MpesaTrans.transaction = 600 then begin
                    DocNo := MpesaTrans."Reference No.";
                    ExtDoc := MpesaTrans.request_id;
                end else
                    ExtDoc := MpesaTrans."Reference No.";


                LoanNo := '';
                TransType := Transtype::" ";
                Dim1 := SavAcc."Global Dimension 1 Code";
                Dim2 := SavAcc."Global Dimension 2 Code";

                DimID := SavAcc."Dimension Set ID";

                SystCreated := true;
                if MpesaTrans.description = '' then
                    MpesaTrans.description := MpesaTrans."Transaction Name";

                if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Loan Repayment") then
                    TChannel := TChannel::"Loan Repayment"
                else
                    if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill) then
                        TChannel := TChannel::"Paybill"
                    else
                        if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Deposit") then
                            TChannel := TChannel::"MDeposit"
                        else
                            if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Deposit") then
                                TChannel := TChannel::"BDeposit"
                            else
                                if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Agent Deposit") then
                                    TChannel := TChannel::"Bank Agent Deposit"
                                else
                                    if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Pay Loan From Account") then
                                        TChannel := TChannel::"Pay Loan From Account";



                SaccoTrans.JournalInit(JTemplate, JBatch);

                if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Withdrawal") then
                    MpesaTrans.description := Format(MpesaTrans."transaction type"::"Mpesa Withdrawal");

                if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Airtime) then begin

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr('Airtime Purchase', 1, 50), Balacctype::"G/L Account",
                                  '', TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);


                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", VendorAccount, CopyStr('Airtime Purchase', 1, 50), Balacctype::"G/L Account",
                                  '', -TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                end
                else
                    if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Account Transfer") then begin

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(Format(MpesaTrans."Transaction Type"), 1, 50), Balacctype::"G/L Account",
                              '', TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                        if Loans.Get(MpesaTrans.cr_account) then begin
                            RunBal := TransAmt;


                            Loans.CalcFields("Outstanding Principal", "Outstanding Interest");

                            IntAmt := Loans."Outstanding Interest";

                            if IntAmt > 0 then begin

                                if IntAmt > RunBal then
                                    IntAmt := RunBal;

                                AccNo := MpesaTrans.account_number;
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                TransType := Transtype::" ";
                                SystCreated := true;

                                MpesaTrans."Interest Paid" := IntAmt;

                                TransType := Transtype::"Interest Paid";
                                AccNo := Loans."Member No.";
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(MpesaTrans.description, 1, 50), Balacctype::"G/L Account",
                                              '', -IntAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                                RunBal -= IntAmt;

                            end;

                            if Loans."Outstanding Principal" > 0 then begin
                                PrAmt := Loans."Outstanding Principal";
                                if PrAmt > RunBal then
                                    PrAmt := RunBal;

                                AccNo := MpesaTrans.account_number;
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                SystCreated := true;

                                TransType := Transtype::" ";
                                MpesaTrans."Principal Paid" := PrAmt;

                                TransType := Transtype::"Principal Repayment";

                                AccNo := Loans."Loan Account";
                                //message('PrAmt %1',PrAmt);
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(MpesaTrans.description, 1, 50), Balacctype::"G/L Account",
                                              '', -PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                                RunBal -= PrAmt;

                            end;
                            if RunBal > 0 then begin

                                DepositAcc.Reset();
                                DepositAcc.SetRange("Member No.", Loans."Member No.");
                                DepositAcc.SetRange(DepositAcc."Product Category", DepositAcc."Product Category"::"Deposit Contribution");
                                if DepositAcc.FindFirst() then begin

                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, MpesaTrans.account_number, CopyStr(MpesaTrans.description, 1, 50), Balacctype::"G/L Account",
                                                                                                                      '', RunBal, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                    SaccoTrans.JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType::Savings, DepositAcc."No.", CopyStr('Additional: ' + Desc, 1, 50),
                                    AcctType::"G/l Account", '', -runBal, ExtDoc, LoanNo, TransType, '', '', true, TChannel, DimID);

                                end;
                            end;

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, MpesaTrans.cr_account, CopyStr(Format(MpesaTrans."Transaction Type") + ' on ' + format(MpesaTrans."Transaction Date"), 1, 50), Balacctype::"G/L Account",
                                          '', -TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);
                        end
                        else begin

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, MpesaTrans.cr_account, CopyStr(Format(MpesaTrans."Transaction Type") + ' on ' + format(MpesaTrans."Transaction Date"), 1, 50), Balacctype::"G/L Account",
                                          '', -TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                        end;



                    end
                    else begin


                        if ((Members.Get(MpesaTrans.account_number) and (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill))) then begin

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", BankAccount, CopyStr(MpesaTrans.description, 1, 50), Balacctype::"Bank Account",
                                      '', TransAmt * -1, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::Paybill, DimID);


                            SaccoActivity.GenerateMemberRepaymentJournals(JTemplate, JBatch, docNo, ExtDoc, pdate, MpesaTrans.Description, pdate, TransAmt * -1, Members."No.", LoanNo, '', BalAccType::"g/l account", 0, channel::"Paybill", true);

                        end
                        else begin

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(MpesaTrans.description, 1, 50), Balacctype::"Bank Account",
                                      BankAccount, TransAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                        end;
                    end;

                if MpesaTrans."Transaction Name" = '' then
                    MpesaTrans."Transaction Name" := Format(MpesaTrans."Transaction Type");


                if TotalCharge > 0 then begin
                    if (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::Paybill) and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Mpesa Deposit")
                        and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Loan Repayment") and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Bank Deposit")
                       and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Bank Agent Deposit") then begin

                        if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Withdrawal") then
                            AccountToCharge := AccNo;

                        if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Transfer" then
                            AccountToCharge := MpesaTrans.account_number;

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccountToCharge, CopyStr(MpesaTrans."Transaction Name" + ' Charges', 1, 50), Balacctype::"G/L Account",
                                      '', VendorCommission + DividendFee + SaccoFee + SafcomFee + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AccountToCharge,COPYSTR('Corporate Charge',1,50),BalAccType::"Bank Account",
                        //            SafcomAcc,SafcomFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", DivChargeAcc, CopyStr('Advance Dividend Interest Charge', 1, 50), Balacctype::"G/L Account",
                                      '', -DividendFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", SafcomAcc, CopyStr('Corporate Charge', 1, 50), Balacctype::"Bank Account",
                                      '', -SafcomFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AccountToCharge,COPYSTR('Transaction Charge',1,50),BalAccType::"G/L Account",
                        //            SaccoAccount,SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SaccoAccount, CopyStr(MpesaTrans."Transaction Name" + ' Charges', 1, 50), Balacctype::"G/L Account",
                                      '', -SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccountToCharge, CopyStr('SMS Charge - ', 1, 50), Balacctype::"G/L Account",
                                      SMSAccount, SMSCharge, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,Accttype::Savings,AccountToCharge,COPYSTR('Excise Duty ',1,50),BalAccType::"G/L Account",
                        //            ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty ', 1, 50), Balacctype::"G/L Account",
                                      '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                    end
                    else begin

                        MCommission.TestField("Non-Member Debit Account");
                        DepDesc := 'C2B Mpesa Deposit';
                        if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Deposit") then
                            DepDesc := 'C2B Bank Deposit';
                        if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Agent Deposit") then
                            DepDesc := 'C2B Bank Agent Deposit';

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", MCommission."Non-Member Debit Account", CopyStr(DepDesc, 1, 50), Balacctype::"G/L Account",
                              '', VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                        if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Agent Deposit") then begin
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", MCommission."Non-Member Debit Account", CopyStr('Corporate Charge', 1, 50), Balacctype::"Bank Account",
                                        SafcomAcc, SafcomFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                        end;

                    end;


                    AccNo := SafcomAcc;
                    ExtDoc := MpesaTrans.account_number;
                    LoanNo := '';
                    TransType := Transtype::" ";

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", SafcomAcc, CopyStr('Fee on ' + MpesaTrans.description, 1, 50), Balacctype::"G/L Account",
                                  '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);


                end;

                if MpesaTrans.request_id = 'SSPDSP21AIR42942' then
                    Message('Amt %1-%2', MpesaTrans.amount, MpesaTrans."Transaction Type");
                if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Loan Repayment" then begin

                    AccBal := AccountBalance(SavAcc."No.");
                    RunBal := AccBal + MpesaTrans.amount - (TotalCharge + ExciseDuty);

                    if RunBal > 0 then begin
                        RunBal := MpesaTrans.amount;
                        Loans.Reset;
                        Loans.SetRange("Loan No.", MpesaTrans."Loan No.");
                        Loans.SetRange("Member No.", SavAcc."Member No.");
                        if Loans.FindFirst then begin

                            Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
                            //Arrears   
                            InterestArrears := SaccoTrans.GetInterestArrears(Loans."Loan No.", CalcDate('-1M+CM', PDate));
                            if InterestArrears > 0 then
                                InterestArrears -= SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Interest Paid");

                            if InterestArrears < 0 then
                                InterestArrears := 0;

                            if InterestArrears > Loans."Outstanding Interest" then
                                InterestArrears := Loans."Outstanding Interest";

                            if InterestArrears > 0 then begin
                                if InterestArrears > 0 then begin

                                    Desc := CopyStr('Interest Arrears: ' + MpesaTrans.description, 1, 50);

                                    if InterestArrears > RunBal then
                                        InterestArrears := RunBal;

                                    AccNo := MpesaTrans.account_number;
                                    ExtDoc := '';
                                    LoanNo := Loans."Loan No.";
                                    TransType := Transtype::" ";
                                    SystCreated := true;

                                    MpesaTrans."Interest Paid" := IntAmt;
                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, Desc, Balacctype::"G/L Account",
                                                  '', InterestArrears, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                    TransType := Transtype::"Interest Paid";
                                    AccNo := Loans."Loan Account";
                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, Desc, Balacctype::"G/L Account",
                                                  '', -InterestArrears, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                                    RunBal -= InterestArrears;

                                end;
                            end;

                            PrincipalArrears := 0;
                            SaccoTrans.GetDefaultedAmount(Loans."Loan No.", PDate, ExpectedBal, CurrentBal, PrincipalArrears, DaysInArrear, ArrearsDate, true, GracePeriod);

                            if PrincipalArrears > 0 then begin
                                if PrincipalArrears > 0 then
                                    PrincipalArrears -= SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Principal Repayment");

                                if PrincipalArrears < 0 then
                                    PrincipalArrears := 0;

                                if PrincipalArrears > Loans."Outstanding Principal" then
                                    PrincipalArrears := Loans."Outstanding Principal";

                                if PrincipalArrears > RunBal then
                                    PrincipalArrears := RunBal;


                                Desc := CopyStr('Principal Arrears: ' + MpesaTrans.description, 1, 50);

                                AccNo := MpesaTrans.account_number;
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                SystCreated := true;

                                TransType := Transtype::" ";
                                MpesaTrans."Principal Paid" := PrincipalArrears;

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, Desc, Balacctype::"G/L Account",
                                              '', PrincipalArrears, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                TransType := Transtype::"Principal Repayment";

                                AccNo := Loans."Loan Account";
                                //message('PrAmt %1',PrAmt);
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", Desc, Balacctype::"G/L Account",
                                              '', -PrincipalArrears, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                                RunBal -= PrincipalArrears;
                                Loans."Outstanding Principal" -= SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Principal Repayment");

                            end;

                            IntAmt := Loans."Outstanding Interest" - SaccoTrans.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Interest Paid");

                            if IntAmt > 0 then begin

                                if IntAmt > RunBal then
                                    IntAmt := RunBal;

                                AccNo := MpesaTrans.account_number;
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                TransType := Transtype::" ";
                                SystCreated := true;

                                MpesaTrans."Interest Paid" := IntAmt;
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr('Interest ' + MpesaTrans.description, 1, 50), Balacctype::"G/L Account",
                                              '', IntAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                TransType := Transtype::"Interest Paid";
                                AccNo := Loans."Loan Account";
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr('Interest ' + MpesaTrans.description, 1, 50), Balacctype::"G/L Account",
                                              '', -IntAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                                RunBal -= IntAmt;

                            end;

                            if Loans."Outstanding Principal" > 0 then begin

                                PrAmt := Loans."Outstanding Principal";
                                if PrAmt > RunBal then
                                    PrAmt := RunBal;

                                AccNo := MpesaTrans.account_number;
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                SystCreated := true;

                                TransType := Transtype::" ";
                                MpesaTrans."Principal Paid" += PrAmt;

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, CopyStr(MpesaTrans.description, 1, 50), Balacctype::"G/L Account",
                                              '', PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                TransType := Transtype::"Principal Repayment";

                                AccNo := Loans."Loan Account";
                                //message('PrAmt %1',PrAmt);
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(MpesaTrans.description, 1, 50), Balacctype::"G/L Account",
                                              '', -PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                                RunBal -= PrAmt;

                            end;

                            if RunBal > 0 then begin

                                DepositAcc.Reset();
                                DepositAcc.SetRange("Member No.", Loans."Member No.");
                                DepositAcc.SetRange(DepositAcc."Product Category", DepositAcc."Product Category"::"Deposit Contribution");
                                if DepositAcc.FindFirst() then begin

                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, MpesaTrans.account_number, CopyStr(MpesaTrans.description, 1, 50), Balacctype::"G/L Account",
                                                                                  '', RunBal, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                    SaccoTrans.JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType::Savings, DepositAcc."No.", CopyStr('Additional: ' + MpesaTrans.description, 1, 50),
                                    AcctType::"G/l Account", '', -runBal, ExtDoc, '', TransType::" ", '', '', true, TChannel, DimID);

                                end;
                            end;
                        end;
                    end;

                    //error('RunBal %1 \PrAmt %2',RunBal,PrAmt);

                end;


                MpesaTrans.Posted := true;
                MpesaTrans.Failed := false;
                MpesaTrans."Needs Change" := false;
                MpesaTrans."Posted By" := UserId;
                MpesaTrans."Date Posted" := Today;
                MpesaTrans.Modify;
                Response := true;


                SaccoTrans.JournalPost(JTemplate, JBatch);

                if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Loan Repayment" then begin
                    if Loans.Get(LoanNo) then begin
                        Loans.CalcFields("Outstanding Principal");
                        LT := Loans."Loan Product Type Name";
                        if LoanType.Get(Loans."Loan Product Type") then
                            LT := LoanType."Description";

                        NewLoanBal := Loans."Outstanding Principal";
                        msg := 'Dear ' + MpesaTrans."Client Name" + NewLine +
                            Format(MpesaTrans."Transaction Type") + ' of KES ' + Format(MpesaTrans.amount) + ' done on ' + Format(ddMMyyyy(MpesaTrans."Transaction Date")) + ' has been processed successfully.' + NewLine +
                            ' New ' + LT + ' Balance is ' + Format(NewLoanBal) + NewLine +
                            'REF: ' + MpesaTrans.request_id;
                    end;
                end
                else begin
                    if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill then begin
                        Depositor := CopyStr(MpesaTrans.description, 24, StrLen(MpesaTrans.description));
                        //MemberName
                        msg := 'Dear ' + MpesaTrans."Client Name" + NewLine +
                        'KES ' + Format(MpesaTrans.amount) + ' has been deposited to your to your ' + SavAcc."Product Name" + ': ' + MpesaTrans.account_number +
                                  ' on ' + Format(ddMMyyyy(MpesaTrans."Transaction Date")) + NewLine +
                                  'REF: ' + MpesaTrans.request_id;
                    end
                    else begin
                        msg := 'Dear ' + MpesaTrans."Client Name" + NewLine +
                              Format(MpesaTrans."Transaction Type") + ' of KES ' + Format(MpesaTrans.amount) + ' done on ' + Format(ddMMyyyy(MpesaTrans."Transaction Date")) + '  has been processed successfully.' + NewLine +
                              'REF: ' + MpesaTrans.request_id;
                    end;
                end;


                if MobileNo = '' then
                    MobileNo := SavAcc."Mobile Phone No.";

                if (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Mini-Statement") and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Balance Enquiry") then
                    if (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Mobile App Login") then
                        SendSmsWithID(Source::MBANKING, MobileNo, msg, Format(MpesaTrans.request_id), '', true, 0, false, 'CBS', '', 'CBS');

            end
            else begin

                if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill) or (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Agent Deposit") or
                  (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Deposit") then begin

                    if Loans.Get(MpesaTrans.account_number) then begin
                        SavAcc.Reset;
                        SavAcc.SetRange("Member No.", Loans."Member No.");
                        SavAcc.SETRANGE("Product Category", SavAcc."Product Category"::"Ordinary Savings");
                        if SavAcc.FindFirst then begin
                            MpesaTrans.description := 'Loan Repayment ' + MpesaTrans.account_number;
                            MpesaTrans.account_number := SavAcc."No.";
                            MpesaTrans."Loan No." := Loans."Loan No.";
                            MpesaTrans."Transaction Type" := MpesaTrans."transaction type"::"Loan Repayment";
                            MpesaTrans."Needs Change" := false;
                            MpesaTrans.Modify;
                        end
                        else begin
                            MpesaTrans."Needs Change" := true;

                            MpesaTrans.Remarks := 'Clearing Account Not Found';
                            MpesaTrans.Modify;
                        end
                    end
                    else begin
                        MpesaTrans."Needs Change" := true;

                        MpesaTrans.Remarks := 'Account/Loan No. Not Found';
                        MpesaTrans.Modify;
                    end;

                end
                else begin
                    MpesaTrans."Needs Change" := true;

                    MpesaTrans.Remarks := 'Unknown Transaction type';
                    MpesaTrans.Modify;
                end;
            end;
        end;

    end;


    procedure PostMobileLoan(EntryNo: Guid) Processed: Boolean
    var
        MobileNo: Code[20];
        Loans: Record Loans;
        LoanProduct: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        MemberNo: Code[20];
        MaxLoan: Decimal;
        LoanAccountNo: Code[20];
        LoanType: Code[20];
        LoanAmount: Decimal;
        MobileLoan: Record "Sky Mobile Loans";
        Continue: Boolean;
        msg: Text;
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
        SourceType: Enum "SMS Source Enum";
        ExtDoc: Code[20];
        Dim1: Code[20];
        Dim2: Code[20];
        SystCreated: Boolean;
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement";
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        UpfrontInterest: Decimal;
        Amt: Decimal;
        LoanRec: Record Loans;
        Product: Record "Product Setup";
        SMSAccount: Code[10];
        SMSCharge: Decimal;
        MCommission: Record "SpotCash Setup";
        PCharges: Record "Loan Product Charges.";
        Duty: Decimal;
        ChargeValue: Decimal;
        GeneralSetUp: Record "Sacco Setup";
        LoanProductTypes: Record "Product Setup";
        DividendAdvance: Record "Dividend Advance";
        Accounts: Record "Savings Accounts";
        DividendAdvanceDefaulter: Record "Dividend Advance - Defaulter";
        LNo: Code[20];
        Sky: Codeunit "Sky MBanking";
        SaccoActivities: Codeunit "Sacco Activities";
        QualAmt: Decimal;
        Remarks: Text;
        DimID: Integer;
    begin

        Processed := false;
        MobileLoan.Reset;
        MobileLoan.SetRange("Entry No", EntryNo);
        MobileLoan.SetRange(Status, MobileLoan.Status::Pending);
        MobileLoan.SetRange(Posted, false);
        if MobileLoan.FindFirst then begin



            LoanProduct.Get(MobileLoan."Loan Product Type");
            SavAcc.Reset;
            SavAcc.SetRange("No.", MobileLoan."Account No");
            //AzizSavAcc.SETRANGE("Account Type",'SAVINGS');
            if SavAcc.FindFirst then begin

                MemberNo := SavAcc."Member No.";
                Continue := true;

                DimID := SavAcc."Dimension Set ID";
                TChannel := TChannel::"Mobile Loan";

                Members.Get(MemberNo);
                if MobileLoan."Loan Product Type" = 'L16' then begin
                    msg := 'Your ' + LoanProduct."Description" + ' request has failed, Product not launched ';
                    MobileLoan.Remarks := 'Product Not Launched';
                    MobileLoan.Status := MobileLoan.Status::Failed;
                    MobileLoan.Posted := true;
                    MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                    MobileLoan.Message := msg;
                    SendSms(Source::MBANKING, SavAcc."Transactional Mobile No", msg, Format(MobileLoan."Entry No"), '', true, 0, false);
                    MobileLoan.Modify;
                    Continue := false;
                end;


                /*
                IF Continue THEN BEGIN
                   IF (Members.Status <> Members.Status::Active) AND (Members.Status <> Members.Status::New) THEN BEGIN
                        msg:='Your '+LoanProduct."Description"+' request has failed, Your BOSA Account is not Active.';
                        MobileLoan.Remarks:='Member is not Active';
                        MobileLoan.Status:=MobileLoan.Status::Failed;
                        MobileLoan.Posted:=TRUE;
                        MobileLoan."Date Posted":=CURRENTDATETIME;//TODAY;
                        MobileLoan.Message:=msg;
                        SendSms(Source::MBANKING,SavAcc."Transactional Mobile No",msg,FORMAT(MobileLoan."Entry No"),'',TRUE,0,FALSE);
                        MobileLoan.MODIFY;
                        Continue:=FALSE;
                    END;
                END;
                */



                if Continue then begin
                    if SavAcc.Status <> SavAcc.Status::Active then begin

                        msg := 'Your ' + LoanProduct."Description" + ' request has failed, Your account is not Active.';
                        MobileLoan.Remarks := 'Account is not Active';
                        MobileLoan.Status := MobileLoan.Status::Failed;
                        MobileLoan.Posted := true;
                        MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                        MobileLoan.Message := msg;
                        SendSms(Source::MBANKING, SavAcc."Transactional Mobile No", msg, Format(MobileLoan."Entry No"), '', true, 0, false);
                        MobileLoan.Modify;
                        Continue := false;
                    end;
                end;


                /*
                //Check Membership Age
                IF Continue THEN BEGIN
                    nDays:=0;
        
                    IF SavAcc."Registration Date" <> 0D THEN
                        nDays:=TODAY -SavAcc."Registration Date"
                    ELSE
                        nDays:=0;
        
                    IF nDays<60 THEN BEGIN
                        msg:='Your '+LoanProduct."Description"+' request has failed, Your account ('+MobileLoan."Account No"+') must be active for atleast 2 months.';
                        MobileLoan.Remarks:='Account less than 2 months old';
                        MobileLoan.Status:=MobileLoan.Status::Failed;
                        MobileLoan.Posted:=TRUE;
                        MobileLoan."Date Posted":=CURRENTDATETIME;//TODAY;
                        MobileLoan.Message:=msg;
                        SendSms(Source::MBANKING,SavAcc."Transactional Mobile No",msg,FORMAT(MobileLoan."Entry No"),SavAcc."No.",FALSE);
                        MobileLoan.MODIFY;
                        Continue:=FALSE;
                    END;
                END;
                */




                //Check Share Capital
                if Continue then begin

                    ShareCap := 0;
                    /*
                    Aziz
                    Members.CALCFIELDS("Shares Retained");
                    ShareCap := Members."Shares Retained";


                    IF (ShareCap <= 0) THEN BEGIN
                        msg:='Your '+LoanProduct."Description"+' request was rejected, current share capital should be more than 0';
                        MobileLoan.Remarks:='Share capital should be more than 0';// ::' + FORMAT(membersShares);
                        MobileLoan.Status:=MobileLoan.Status::Failed;
                        MobileLoan.Posted:=TRUE;
                        MobileLoan."Date Posted":=CURRENTDATETIME;//TODAY;
                        MobileLoan.Message:=msg;
                        SendSms(Source::MBANKING,SavAcc."Transactional Mobile No",msg,FORMAT(MobileLoan."Entry No"),'',TRUE,0,FALSE);
                        MobileLoan.MODIFY;
                        Continue:=FALSE;
                    END;
                    */

                end;



                //Check Defaulter

                if MobileLoan."Loan Product Type" <> 'L16' then
                    if Continue then begin
                        Loans.Reset;
                        Loans.SetRange("Member No.", MemberNo);
                        Loans.SetFilter("Loans Category-SACCO", '%1|%2|%3', Loans."Loans Category-SACCO"::Substandard,
                        Loans."Loans Category-SACCO"::Doubtful, Loans."Loans Category-SACCO"::Loss);
                        //Loans.SETFILTER("Total Arrears",'>0');
                        if Loans.FindFirst then begin
                            if Product.Get(Loans."Loan Product Type") then begin

                                //                    msg:='Your '+LoanProduct."Description"+' request has failed, You have defaulted '+Product.Description;
                                //                    MobileLoan.Remarks:='Member has defaulted Loan No. '+Loans."Loan No."+' - '+Product.Description;
                                //                    MobileLoan.Status:=MobileLoan.Status::Failed;
                                //                    MobileLoan.Posted:=TRUE;
                                //                    MobileLoan."Date Posted":=CURRENTDATETIME;//TODAY;
                                //                    MobileLoan.Message:=msg;
                                //                    SendSms(Source::MBANKING,SavAcc."Transactional Mobile No",msg,FORMAT(MobileLoan."Entry No"),'',TRUE,0,FALSE);
                                //                    MobileLoan.MODIFY;
                                //                    Continue:=FALSE;
                            end;
                        end;
                    end;

                if Continue then begin
                    LoanProduct.Reset;
                    LoanProduct.SetRange("Product ID", MobileLoan."Loan Product Type");
                    LoanProduct.SetRange("Available on Mobile", true);
                    if LoanProduct.Find('-') then begin
                        if MobileLoan."Loan Period" = 0 then
                            MobileLoan."Loan Period" := 1;

                        MaxLoan := 0;


                        if MobileLoan."Loan Product Type" = 'L16' then begin
                            sky.GetDividendLoanQualifiedAmount(SavAcc."No.", MobileLoan."Loan Product Type", QualAmt, Remarks);
                            MaxLoan := QualAmt;

                            // if DividendAdvance.Get(MemberNo) then begin

                            //     MaxLoan := DividendAdvance."Qualifying Amount";
                            // end
                            // else
                            //     if DividendAdvanceDefaulter.Get(MemberNo) then begin
                            //         MaxLoan := DividendAdvanceDefaulter."Qualifying Amount";


                            //     end;

                        end;




                        LNo := '';
                        Loans.Reset;
                        Loans.SetRange("Member No.", MemberNo);
                        Loans.SetRange("Loan Product Type", LoanProduct."Product ID");
                        Loans.SetFilter("Outstanding Principal", '>0');
                        if Loans.FindFirst then begin
                            if LoanProduct."Product ID" = 'L16' then begin
                                repeat
                                    LNo := Loans."Loan No.";
                                    Loans.CalcFields("Outstanding Principal");
                                    MaxLoan -= Loans."Outstanding Principal";
                                until Loans.Next = 0;
                            end
                            else begin
                                msg := 'Your ' + LoanProduct."Description" + ' request has failed, You have an existing mobile loan.';
                                MobileLoan.Remarks := 'Member has an existing mobile loan';
                                MobileLoan.Status := MobileLoan.Status::Failed;
                                MobileLoan.Posted := true;
                                MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                                MobileLoan.Message := msg;
                                SendSms(Source::MBANKING, SavAcc."Transactional Mobile No", msg, Format(MobileLoan."Entry No"), '', true, 0, false);
                                MobileLoan.Modify;
                                Continue := false;
                            end;
                        end;
                        if MaxLoan < 0 then
                            MaxLoan := 0;


                        //MaxLoan := ThibitiEligibility(MobileLoan."Telephone No",MobileLoan."Loan Product Type");

                        if Continue then begin
                            if MobileLoan."Requested Amount" > MaxLoan then begin

                                msg := 'Your ' + LoanProduct."Description" + ' request has failed, your eligibility is KES ' + Format(MaxLoan);
                                MobileLoan.Remarks := 'Member eligibility is ' + Format(MaxLoan);
                                MobileLoan.Status := MobileLoan.Status::Failed;
                                MobileLoan.Posted := true;
                                MobileLoan."Date Posted" := CurrentDatetime;//TODAY;
                                MobileLoan.Message := msg;
                                SendSms(Source::MBANKING, SavAcc."Transactional Mobile No", msg, Format(MobileLoan."Entry No"), '', true, 0, false);
                                MobileLoan.Modify;
                                Continue := false;
                            end;
                        end;




                        if Continue then begin


                            JTemplate := 'CASHREC';
                            JBatch := 'TANGAZO';


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

                            MCommission.Reset;
                            MCommission.SetRange("Transaction Type", MCommission."transaction type"::"Loan Disbursement");
                            if MCommission.FindFirst then begin

                                SMSAccount := MCommission."SMS Account";
                                SMSCharge := MCommission."SMS Charge";


                                SaccoAccount := MCommission."Sacco Fee Account";
                                SaccoFee := MCommission."Sacco Fee";
                                VendorAccount := MCommission."Vendor Commission Account";
                                VendorCommission := MCommission."Vendor Commission";

                                TotalCharge := SaccoFee + VendorCommission + SMSCharge;
                                ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
                            end
                            else begin
                                Error('Setup Missing for %1', MCommission."transaction type"::"Loan Disbursement");
                            end;





                            IF LNo <> '' THEN BEGIN
                                Loans.GET(LNo);
                                Loans."Application Date" := TODAY;
                                Loans."Loan Product Type" := LoanProduct."Product ID";
                                Loans."Loan Product Type Name" := LoanProduct."Description";
                                Loans."Member No." := SavAcc."Member No.";// SavAcc."No.";
                                Loans."Member Name" := SavAcc.Name;
                                Loans."Requested Amount" += MobileLoan.Amount;
                                Loans."Approved Amount" += MobileLoan.Amount;
                                Loans.Status := Loans."Status"::Approved;
                                Loans.Source := Loans.Source::FOSA;
                                Loans."Annual Interest %" := LoanProduct."Interest Rate (Max.)";
                                Loans.Installments := LoanProduct."Default Installments";
                                Loans."Mode of Disbursement" := Loans."Mode of Disbursement"::"Transfer to FOSA";
                                //Loans."Global Dimension 1 Code":='FOSA';
                                Loans.Repayment += (ROUND(MobileLoan.Amount, 1));
                                //Loans."Interest to be paid":=ROUND((MobileLoan."Requested Amount" * (LoanProduct."Interest rate" /12/100)),1);
                                // Loans.Interest:=ROUND((MobileLoan."Requested Amount" * (LoanProduct."Interest rate" /12/100)),1);
                                //Loans."Interest Due":=ROUND((MobileLoan."Requested Amount" * (LoanProduct."Interest rate"/12/100)),1);
                                Loans."Loan Principle Repayment" += ROUND((MobileLoan.Amount / 1), 1);
                                //Loans."Recovery Mode":=Loans."Recovery Mode"::Mpesa;
                                Loans."Loan Interest Repayment" += ROUND((MobileLoan.Amount * (LoanProduct."Interest Rate (Max.)" / 12 / 100)), 1);
                                Loans."Repayment Start Date" := CALCDATE('31D', TODAY);
                                Loans."Completion Date" := CALCDATE('31D', TODAY);
                                Loans."Disbursement Date" := TODAY;
                                Loans.Repayment := ROUND((MobileLoan.Amount / 1), 1);
                                // Loans."Repayment Frequency":=LoanProduct."Repayment Frequency";
                                Loans."Interest Calculation Method" := LoanProduct."Interest Calculation Method";
                                Loans.Posted := TRUE;
                                Loans."Disbursement Date" := TODAY;
                                // Loans."Loan Account":=LoanType."/Account No. Prefix"+SavAcc."No.";
                                //Loans."Mobile Loan":=TRUE;
                                //Loans.Interest:=LoanType."Interest rate";
                                //Loans."Default Status":= Loans."Default Status"::Active;
                                //Loans."Outstanding Amount":=MsaccoLoans."Requested Amount";
                                //Loans."Payment Due Date":= FORMAT(CALCDATE('31D', TODAY));
                                Loans.MODIFY;

                            END
                            ELSE BEGIN
                                Loans.INIT;
                                Loans."Application Date" := TODAY;
                                Loans."Loan Product Type" := LoanProduct."Product ID";
                                Loans."Loan Product Type Name" := LoanProduct."Description";
                                Loans."Member No." := SavAcc."Member No.";// SavAcc."No.";
                                Loans."Member Name" := SavAcc.Name;
                                Loans."Requested Amount" += MobileLoan.Amount;
                                Loans."Approved Amount" += MobileLoan.Amount;
                                Loans.Status := Loans."Status"::Approved;
                                Loans.Source := Loans.Source::FOSA;
                                Loans."Annual Interest %" := LoanProduct."Interest Rate (Max.)";
                                Loans.Installments := LoanProduct."Default Installments";
                                Loans."Mode of Disbursement" := Loans."Mode of Disbursement"::"Transfer to FOSA";
                                //Loans."Global Dimension 1 Code":='FOSA';
                                Loans.Repayment += (ROUND(MobileLoan.Amount, 1));
                                //Loans."Interest to be paid":=ROUND((MobileLoan."Requested Amount" * (LoanProduct."Interest rate" /12/100)),1);
                                // Loans.Interest:=ROUND((MobileLoan."Requested Amount" * (LoanProduct."Interest rate" /12/100)),1);
                                //Loans."Interest Due":=ROUND((MobileLoan."Requested Amount" * (LoanProduct."Interest rate"/12/100)),1);
                                Loans."Loan Principle Repayment" += ROUND((MobileLoan.Amount / 1), 1);
                                //Loans."Recovery Mode":=Loans."Recovery Mode"::Mpesa;
                                Loans."Loan Interest Repayment" += ROUND((MobileLoan.Amount * (LoanProduct."Interest Rate (Max.)" / 12 / 100)), 1);
                                Loans."Repayment Start Date" := CALCDATE('31D', TODAY);
                                Loans."Completion Date" := CALCDATE('31D', TODAY);
                                Loans."Disbursement Date" := TODAY;
                                Loans.Repayment := ROUND((MobileLoan.Amount / 1), 1);
                                // Loans."Repayment Frequency":=LoanProduct."Repayment Frequency";
                                Loans."Interest Calculation Method" := LoanProduct."Interest Calculation Method";
                                Loans.Posted := TRUE;
                                Loans."Disbursement Date" := TODAY;
                                Loans.INSERT(TRUE);
                            END;


                            LoanNo := Loans."Loan No.";


                            Loans.RESET;
                            Loans.SETRANGE("Loan No.", LoanNo);
                            Loans.SETRANGE("Member No.", MemberNo);
                            Loans.SETRANGE("Loan Product Type", MobileLoan."Loan Product Type");
                            IF Loans.FINDFIRST THEN BEGIN
                                Loans.CalcFields("Outstanding Principal");
                                UpfrontInterest := 0;
                                IF (LoanProduct."Interest Recovered Upfront") THEN
                                    UpfrontInterest := ROUND((MobileLoan.Amount - Loans."Outstanding Principal") * LoanProduct."Interest Rate (Max.)" / 1200);

                                DocNo := Loans."Loan No.";
                                PDate := TODAY;

                                Dim1 := Loans."Global Dimension 1 Code";
                                //Dim2:=Loans."Global Dimension 2 Code";

                                AccNo := MobileLoan."Account No";// Loans."Disbursement Account No";
                                ExtDoc := '';
                                LoanNo := Loans."Loan No.";
                                TransType := TransType::" ";
                                SystCreated := TRUE;



                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, AccNo, COPYSTR(LoanProduct."Description" + ' Disbursement', 1, 50), BalAccType::"G/L Account",
                                              '', -MobileLoan.Amount, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);


                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, AccNo, COPYSTR('Processing Fee', 1, 50), BalAccType::"G/L Account",
                                              '', VendorCommission, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, AccNo, COPYSTR('SMS Charge', 1, 50), BalAccType::"G/L Account",
                                    SMSAccount, SMSCharge, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);


                                IF (LoanProduct."Interest Recovered Upfront") THEN
                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, AccNo, COPYSTR(LoanProduct."Description" + ' Interest', 1, 50), BalAccType::"G/L Account",
                                                  '', UpfrontInterest, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                                AccNo := Loans."Loan Account";
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Credit, AccNo, COPYSTR(LoanProduct."Description" + ' Disbursement', 1, 50), BalAccType::"G/L Account",
                                              '', MobileLoan.Amount, ExtDoc, LoanNo, TransType::"Loan Disbursement", Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                IF (LoanProduct."Interest Recovered Upfront") THEN BEGIN
                                    //Loans."Loan Interest Repayment" := ROUND(LoanProduct."Interest Rate" / 1200 * Loans."Approved Amount");
                                    LoanProduct.TESTFIELD(LoanProduct."Loan Interest Income [G/L]");
                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Credit, AccNo, COPYSTR(LoanProduct."Description" + ' Interest Due', 1, 50), BalAccType::"G/L Account",
                                                  LoanProduct."Loan Interest Income [G/L]", Loans."Loan Interest Repayment", ExtDoc, LoanNo, TransType::"Interest Due", Dim1, Dim2, SystCreated, TChannel::" ", DimID);
                                END;

                                IF (LoanProduct."Interest Recovered Upfront") THEN BEGIN
                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Credit, AccNo, COPYSTR(LoanProduct."Description" + ' Interest', 1, 50), BalAccType::"G/L Account",
                                              '', -UpfrontInterest, ExtDoc, LoanNo, TransType::"Interest Paid", Dim1, Dim2, SystCreated, TChannel::" ", DimID);

                                    Loans."Loan Interest Repayment" := 0;
                                    Loans.Repayment := Loans."Loan Principle Repayment";

                                END;

                                AccNo := VendorAccount;
                                //AzizExtDoc := Loans."Disbursement Account No";
                                LoanNo := '';
                                TransType := TransType::" ";

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Vendor, AccNo, COPYSTR(LoanProduct."Description" + ' Disbursement Commission', 1, 50), BalAccType::"G/L Account",
                                              '', -VendorCommission, ExtDoc, '', TransType, Dim1, Dim2, SystCreated, TChannel::" ", DimID);



                                //ProductCharges

                                GeneralSetUp.GET;
                                /*
                                PCharges.RESET;
                                PCharges.SETRANGE(PCharges."Product Code",MobileLoan."Loan Product Type");
                                IF PCharges.FIND('-') THEN BEGIN
                                    REPEAT
                                        PCharges.TESTFIELD(PCharges."G/L Account");

                                        IF PCharges."Use Perc" THEN
                                            ChargeValue:=(Loans."Approved Amount"*PCharges.Percentage/100)
                                        ELSE
                                            ChargeValue:=PCharges.Amount;


                                        SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Member,Loans."Disbursement Account No",PCharges.Description,BalAccType::"G/L Account",
                                                      PCharges."G/L Account",ChargeValue,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);


                                    UNTIL PCharges.NEXT = 0;
                                END;
                                */



                                MobileLoan.Remarks := 'Successful';
                                MobileLoan."Approved Amount" := Loans."Approved Amount";
                                MobileLoan.Status := MobileLoan.Status::Successful;
                                MobileLoan.Posted := TRUE;
                                MobileLoan."Date Posted" := CURRENTDATETIME;//TODAY;
                                MobileLoan.Message := msg;
                                MobileLoan.MODIFY;


                                Loans.Posted := TRUE;
                                Loans.MODIFY;
                                LoanNo := Loans."Loan No.";


                                SaccoTrans.JournalPost(JTemplate, JBatch);
                                Processed := TRUE;

                                Loans.GET(LoanNo);
                                Loans.CALCFIELDS("Outstanding Principal", "Outstanding Interest");
                                //xx
                                msg := 'Dear Member, Your Loan of KES ' + FORMAT(Loans."Outstanding Principal") + ' has been credited to your Fosa Savings Acc.';
                                SendSms(Source::MBANKING, SavAcc."Transactional Mobile No", msg, FORMAT(MobileLoan."Entry No"), '', TRUE, 0, FALSE);

                                COMMIT;

                                SaccoActivities.GenerateRepaymentSchedule(Loans); //

                            END;

                        END;
                    end;
                end;
            end;


        end;




    end;


    procedure GetAmountTransacted(TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer"; AccountNo: Code[20]; Date: Date; Type: Option Daily,Weekly,Monthly; TransCodes: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer") Amt: Decimal
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        MpesaTrans: Record "Spotcash Transactions";
        Continue: Boolean;
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        AccBal: Decimal;
        TransactionDate: DateTime;
        MemberID: Code[20];
        PrePaymentGL: Code[20];
    begin
        Amt := 0;
        /*
        IF(TransactionType = TransactionType::"Mpesa Withdrawal") tHEN BEGIN
            MobileWithdrawalsBuffer.RESET;
            MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer.Reversed,FALSE);
            MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Account No",AccountNo);
        //    MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Withdrawal Type",FORMAT(TransactionType);
            MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer.Source,MobileWithdrawalsBuffer.Source::MSacco);
            IF Type = Type::Daily THEN
            MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Transaction Date",Date);
            IF Type = Type::Weekly THEN
            MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Transaction Date",CALCDATE('-CW',Date),CALCDATE('CW',Date));
            IF Type = Type::Monthly THEN
            MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Transaction Date",CALCDATE('-CM',Date),CALCDATE('CM',Date));
            IF MobileWithdrawalsBuffer.FIND('-') THEN BEGIN
                MobileWithdrawalsBuffer.CALCSUMS(Amount);
                Amt := MobileWithdrawalsBuffer.Amount;
            END;
        END
        ELSE BEGIN
        
        END;
        */

    end;


    procedure GetChargeAmount("Code": Code[20]; var ChargeAmt: Decimal; var ChargeAcc: Code[20]; TransAmount: Decimal; var VendorCharge: Decimal; var SkyCharge: Decimal)
    begin

        ChargeAmt := 0;
        ChargeAcc := '';
        VendorCharge := 0;

        /*
        TransactionTypes.RESET;
        TransactionTypes.SETRANGE(Code,Code);
        TransactionTypes.SETRANGE(Type,TransactionTypes.Type::"38");
        IF TransactionTypes.FIND('-') THEN BEGIN
            TransCharges.RESET;
            TransCharges.SETRANGE("Transaction Type",TransactionTypes.Code);
            IF TransCharges.FIND('-') THEN BEGIN
                ChargeAcc := TransCharges."G/L Account";
        
                IF TransCharges."Charge Type" = TransCharges."Charge Type"::"0" THEN BEGIN
                    ChargeAmt := TransCharges."Charge Amount";
                END;
                IF TransCharges."Charge Type" = TransCharges."Charge Type"::"1" THEN BEGIN
                    ChargeAmt := ROUND(TransCharges."Percentage of Amount"/100*TransAmount);
                END;
                IF TransCharges."Charge Type" = TransCharges."Charge Type"::"2" THEN BEGIN
        
                    TariffDetails.RESET;
                    TariffDetails.SETRANGE(TariffDetails.Code,TransCharges."Staggered Charge Code");
                    IF TariffDetails.FIND('-') THEN BEGIN
                        REPEAT
                            IF (TransAmount >= TariffDetails."Lower Limit") AND (TransAmount <= TariffDetails."Upper Limit") THEN BEGIN
                                IF TariffDetails."Use Percentage"=TRUE THEN BEGIN
                                    ChargeAmt:=TransAmount*TariffDetails.Percentage*0.01;
                                END
                                ELSE BEGIN
                                    ChargeAmt := TariffDetails."Charge Amount";
                                    VendorCharge := TariffDetails."External Vendor Charge";
                                    SkyCharge := TariffDetails."Mobile Vendor Charge";
                                END;
                            END
                        UNTIL TariffDetails.NEXT=0;
                    END;
        
                END;
        
        
        
            END;
        END;
        */

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


    procedure SendSms(Source: Enum "SMS Source Enum"; Telephone: Text[200]; Textsms: Text; Reference: Text[50]; AccNo: Text[30]; Chargeable: Boolean; Priority: Integer; ChargeMember: Boolean)
    var
        EntryNo: Integer;
        Category: Code[100];
        SMSLength: Integer;
        SMSLoop: Integer;
        CurrSMS: Text;
        NewSMS: Text;
    begin
        //SendSms(Source,Telephone,Textsms,Reference,AccNo,FALSE,FALSE);

        /*
        EntryNo:=EntryNo+1;
        
        
        IF STRLEN(Telephone) = 13 THEN BEGIN
            Telephone := COPYSTR(Telephone,2,12);
        END;
        
        IF STRLEN(Telephone) = 10 THEN BEGIN
            IF COPYSTR(Telephone,1,1) = '0' THEN
                Telephone := '254'+COPYSTR(Telephone,2,9);
        END;
        
        IF STRLEN(Telephone) = 9 THEN BEGIN
            IF COPYSTR(Telephone,1,1) = '7' THEN
                Telephone := '254'+Telephone
        END;
        
        
        Category:=FORMAT(Source);
        
        IF Priority = 0 THEN
          Priority := 250;
        
        
        
        
        //Priority := GetSMSPriority(Category);
        
        
        GeneralLedgerSetup.GET;
        GeneralLedgerSetup.TESTFIELD("SMS Sender ID");
        GeneralLedgerSetup.TESTFIELD("SMS Sender Name");
        
        IF STRLEN(Telephone) = 12 THEN BEGIN
        
        
        
        
        
            IF STRLEN(Textsms) > 250 THEN BEGIN
                SMSLength := STRLEN(Textsms);
                SMSLoop := ROUND(SMSLength/250,1,'>');
                WHILE SMSLoop > 0 DO BEGIN
        
        
                    CurrSMS := COPYSTR(Textsms,1,250);
                    NewSMS := COPYSTR(Textsms,251,SMSLength);
        
                    SendSms(Source,Telephone,CurrSMS,Reference,AccNo,Chargeable,0,ChargeMember);
                    Textsms := NewSMS;
                    SMSLoop -= 1;
                END;
                EXIT;
            END;
        
        
            SkySMS.INIT;
            SkySMS.originator_id := CREATEGUID;
            SkySMS.msg_id:=0;
            SkySMS.msg_product_id:=GeneralLedgerSetup."SMS Sender ID";
            SkySMS.msg_provider_code:='0';
            SkySMS.msg_charge:='';
            SkySMS.msg_status_code:=10;
            SkySMS.msg_status_description:='New MSG';
            SkySMS.msg_status_date:=CURRENTDATETIME;
            SkySMS.sender:=GeneralLedgerSetup."SMS Sender Name";
            SkySMS.receiver:=Telephone;
            SkySMS.msg:=Textsms;
            SkySMS.msg_type:='MT';
            SkySMS.msg_source_reference:='';
            SkySMS.msg_destination_reference:='';
            SkySMS.msg_xml_data:='<OTHER_DETAILS/>';
            SkySMS.msg_category:=Category;
            SkySMS.msg_priority:=Priority;
            SkySMS.msg_mode := 'SAF';
            SkySMS.msg_request_application := 'CBS';
            SkySMS.msg_request_correlation_id := '';
            SkySMS.msg_source_application := 'CBS';
            SkySMS.msg_send_count:=0;
            SkySMS.schedule_msg:='NO';
            SkySMS.date_scheduled:=CURRENTDATETIME;
            SkySMS.msg_send_integrity_hash:='';
            //SkySMS.msg_response_date:=CURRENTDATETIME;
            //SkySMS.msg_response_xml_data:='';
            //SkySMS.msg_response_integrity_hash:='';
            SkySMS.transaction_date:=CURRENTDATETIME;
            SkySMS.date_created:=CURRENTDATETIME;
            SkySMS."SMS Date":=TODAY;
            IF Chargeable THEN
              SkySMS."Account To Charge" := AccNo;
        
            SkySMS.transaction_id := 0;
            SkySMS.server_id := 0;
            SkySMS.msg_charge_applied:='';
            SkySMS.msg_format := 'TEXT';
            SkySMS.msg_command := 'BulkSMS';
            SkySMS.msg_sensitivity := 'NORMAL';
            SkySMS.msg_response_description := '';
            SkySMS.msg_result_description := '';
            SkySMS.msg_result_xml_data := '';
            SkySMS.msg_result_date := CURRENTDATETIME;
            SkySMS.msg_result_integrity_hash := '';
            SkySMS.msg_result_submit_count := 0;
            SkySMS.msg_result_submit_status := 'PENDING';
            SkySMS.msg_result_submit_description := '';
            SkySMS.msg_result_submit_date:=CURRENTDATETIME;
            SkySMS.sender_type := 'SENDER_ID';
            SkySMS.receiver_type := 'MSISDN';
            IF Source = Source::MOBILE_PIN THEN BEGIN
                SkySMS.msg_general_flag := 'NOT_MASKED';
            END;
            SkySMS."Charge Member" := ChargeMember;
            IF Source = Source::CASH_WITHDRAWAL_CONFIRM THEN
              SkySMS."Split Charge" := TRUE;
        
            SkySMS.INSERT;
        
        END;
        */

    end;


    procedure SendSmsWithID(Source: Enum "SMS Source Enum"; Telephone: Text[200]; Textsms: Text; Reference: Text[30]; AccNo: Text[30]; Chargeable: Boolean; Priority: Integer; ChargeMember: Boolean; RequestApplication: Text[30]; RequestCorrelationID: Text[50]; SourceApplication: Text[30])
    var
        EntryNo: Integer;
        Category: Code[100];
        SMSLength: Integer;
        SMSLoop: Integer;
        CurrSMS: Text;
        NewSMS: Text;
    begin

        EntryNo := EntryNo + 1;


        //MemberActivities.SendSms(Source,Telephone,Textsms,Reference,AccNo,FALSE,FALSE);

        /*
        
        IF STRLEN(Telephone) = 13 THEN BEGIN
            Telephone := COPYSTR(Telephone,2,12);
        END;
        
        IF STRLEN(Telephone) = 10 THEN BEGIN
            IF COPYSTR(Telephone,1,1) = '0' THEN
                Telephone := '254'+COPYSTR(Telephone,2,9);
        END;
        
        IF STRLEN(Telephone) = 9 THEN BEGIN
            IF COPYSTR(Telephone,1,1) = '7' THEN
                Telephone := '254'+Telephone
        END;
        
        
        Category:=FORMAT(Source);
        
        //Priority := GetSMSPriority(Category);
        
        IF Priority = 0 THEN
          Priority := 250;
        
        GeneralLedgerSetup.GET;
        
        IF STRLEN(Telephone) = 12 THEN BEGIN
        
        
        
        
        
            IF STRLEN(Textsms) > 250 THEN BEGIN
                SMSLength := STRLEN(Textsms);
                SMSLoop := ROUND(SMSLength/250,1,'>');
                WHILE SMSLoop > 0 DO BEGIN
        
        
                    CurrSMS := COPYSTR(Textsms,1,250);
                    NewSMS := COPYSTR(Textsms,251,SMSLength);
        
                    SendSmsWithID(Source,Telephone,CurrSMS,Reference,AccNo,Chargeable,0,ChargeMember,RequestApplication,RequestCorrelationID,SourceApplication);
                    Textsms := NewSMS;
                    SMSLoop -= 1;
                END;
                EXIT;
            END;
        
            {
            SkySMS.INIT;
            SkySMS.originator_id := CREATEGUID;
            SkySMS.msg_id:=0;
            GeneralLedgerSetup.TESTFIELD("SMS Sender ID");
            GeneralLedgerSetup.TESTFIELD("SMS Sender Name");
        
            SkySMS.msg_product_id:=GeneralLedgerSetup."SMS Sender ID";
            SkySMS.msg_provider_code:='0';
            SkySMS.msg_charge:='';
            SkySMS.msg_status_code:=10;
            SkySMS.msg_status_description:='New MSG';
            SkySMS.msg_status_date:=CURRENTDATETIME;
            SkySMS.sender:=GeneralLedgerSetup."SMS Sender Name";
            SkySMS.receiver:=Telephone;
            SkySMS.msg:=Textsms;
            SkySMS.msg_type:='MT';
            SkySMS.msg_source_reference:='';
            SkySMS.msg_destination_reference:='';
            SkySMS.msg_xml_data:='<OTHER_DETAILS/>';
            SkySMS.msg_category:=Category;
            SkySMS.msg_priority:=Priority;
            SkySMS.msg_mode := 'SAF';
        
            SkySMS.msg_send_count:=0;
            SkySMS.schedule_msg:='NO';
            SkySMS.date_scheduled:=CURRENTDATETIME;
            SkySMS.msg_send_integrity_hash:='';
            //SkySMS.msg_response_date:=CURRENTDATETIME;
            //SkySMS.msg_response_xml_data:='';
            //SkySMS.msg_response_integrity_hash:='';
            SkySMS.transaction_date:=CURRENTDATETIME;
            SkySMS.date_created:=CURRENTDATETIME;
            SkySMS."SMS Date":=TODAY;
            IF Chargeable THEN
              SkySMS."Account To Charge" := AccNo;
        
            SkySMS.msg_request_application := RequestApplication;
            SkySMS.msg_request_correlation_id := RequestCorrelationID;
            SkySMS.msg_source_application := SourceApplication;
        
            SkySMS.transaction_id := 0;
            SkySMS.server_id := 0;
            SkySMS.msg_charge_applied:='';
            SkySMS.msg_format := 'TEXT';
            SkySMS.msg_command := 'BulkSMS';
            SkySMS.msg_sensitivity := 'NORMAL';
            SkySMS.msg_response_description := '';
            SkySMS.msg_result_description := '';
            SkySMS.msg_result_xml_data := '';
            SkySMS.msg_result_date := CURRENTDATETIME;
            SkySMS.msg_result_integrity_hash := '';
            SkySMS.msg_result_submit_count := 0;
            SkySMS.msg_result_submit_status := 'PENDING';
            SkySMS.msg_result_submit_description := '';
            SkySMS.msg_result_submit_date:=CURRENTDATETIME;
            SkySMS.sender_type := 'SENDER_ID';
            SkySMS.receiver_type := 'MSISDN';
            IF Source = Source::MOBILE_PIN THEN BEGIN
                SkySMS.msg_general_flag := 'NOT_MASKED';
            END;
            SkySMS."Charge Member" := ChargeMember;
            IF Source = Source::CASH_WITHDRAWAL_CONFIRM THEN
              SkySMS."Split Charge" := TRUE;
        
            SkySMS.INSERT;
            }
        END;
        
        */

    end;

    local procedure GetFreeShares(MemberNo: Code[20]): Decimal
    begin
    end;


    procedure ConvertPhoneNo(mobilePhoneNo: Text) NewPhoneNo: Text
    var
        PhoneLength: Integer;
        StPoint: Integer;
    begin
        NewPhoneNo := mobilePhoneNo;

        PhoneLength := StrLen(mobilePhoneNo);
        StPoint := PhoneLength - 8;

        if StPoint > 0 then
            NewPhoneNo := '+254' + CopyStr(mobilePhoneNo, StPoint, 9);
    end;

    local procedure ConvertPhoneNoRemove(mobilePhoneNo: Text) NewPhoneNo: Text
    var
        PhoneLength: Integer;
        StPoint: Integer;
    begin
        NewPhoneNo := mobilePhoneNo;

        PhoneLength := StrLen(mobilePhoneNo);
        StPoint := PhoneLength - 8;

        NewPhoneNo := '254' + CopyStr(mobilePhoneNo, StPoint, 9);
    end;

    local procedure PostWithdrawals()
    var
        MTrans: Record "Spotcash Transactions";
        MBSEloanLogs: Record "Mbanking Eloan Logs";
    begin


        MBSEloanLogs.Init;
        MBSEloanLogs.Guid := CreateGuid;
        MBSEloanLogs.Date := Today;
        MBSEloanLogs.Time := Time;
        MBSEloanLogs.PhoneNo := 'WITHDRAWAL';
        MBSEloanLogs.LoanType := '';
        MBSEloanLogs.LoanPeriod := 0;
        MBSEloanLogs.Amount := 0;
        if MBSEloanLogs.Insert then
            Commit;

        MTrans.Reset;
        MTrans.SetRange(Failed, false);
        MTrans.SetRange(Posted, false);
        MTrans.SetRange("Needs Change", false);
        MTrans.SetFilter("Reference No.", '<>%1', '');
        MTrans.SetFilter("Transaction Type", '%1', MTrans."transaction type"::"Mpesa Withdrawal");
        if MTrans.FindFirst then begin
            PostMobileTransaction(MTrans.request_id);
        end;


        MTrans.Reset;
        MTrans.SetRange(Failed, false);
        MTrans.SetRange(Posted, false);
        MTrans.SetRange("Needs Change", false);
        MTrans.SetFilter("Reference No.", '<>%1', '');
        MTrans.SetFilter("Transaction Type", '%1', MTrans."transaction type"::"Mpesa Withdrawal");
        if MTrans.FindLast then begin
            PostMobileTransaction(MTrans.request_id);
        end;



        MTrans.Reset;
        MTrans.SetRange(Failed, false);
        MTrans.SetRange(Posted, false);
        MTrans.SetRange("Needs Change", false);
        MTrans.SetFilter("Reference No.", '<>%1', '');
        MTrans.SetFilter("Transaction Type", '%1|%2|%3', MTrans."transaction type"::"Bank Transfer", MTrans."transaction type"::Airtime, MTrans."transaction type"::"Utility Payment");
        if MTrans.FindFirst then begin
            MBSEloanLogs.Init;
            MBSEloanLogs.Guid := CreateGuid;
            MBSEloanLogs.Date := Today;
            MBSEloanLogs.Time := Time;
            MBSEloanLogs.PhoneNo := Format(MTrans."Transaction Type");
            MBSEloanLogs.LoanType := '';
            MBSEloanLogs.LoanPeriod := 0;
            MBSEloanLogs.Amount := 0;
            if MBSEloanLogs.Insert then;

            PostMobileTransaction(MTrans.request_id);
        end;


        MTrans.Reset;
        MTrans.SetRange(Failed, false);
        MTrans.SetRange(Posted, false);
        MTrans.SetRange("Needs Change", false);
        MTrans.SetFilter("Reference No.", '<>%1', '');
        MTrans.SetFilter("Transaction Type", '%1|%2|%3', MTrans."transaction type"::"Bank Transfer", MTrans."transaction type"::Airtime, MTrans."transaction type"::"Utility Payment");
        if MTrans.FindLast then begin
            MBSEloanLogs.Init;
            MBSEloanLogs.Guid := CreateGuid;
            MBSEloanLogs.Date := Today;
            MBSEloanLogs.Time := Time;
            MBSEloanLogs.PhoneNo := Format(MTrans."Transaction Type");
            MBSEloanLogs.LoanType := '';
            MBSEloanLogs.LoanPeriod := 0;
            MBSEloanLogs.Amount := 0;
            if MBSEloanLogs.Insert then;

            PostMobileTransaction(MTrans.request_id);
        end;
    end;


    procedure TestValidateFinancials(): Integer
    var
        LocalisDetected: Boolean;
        LocalErrMsg: Text;

        LocalStringWriter: Text;

        LocalJsonText: Text;
        LocalMsgCode: Text;
        MemberAccounts: Record "Savings Accounts";
        WithdrawalBuffer: Record "Mobile Withdrawal Buffer";
        MTrans: Record "Spotcash Transactions";
        spotCashID: Text;
        referenceid: Text;
        phoneNo: Text;
        responseCode: Text;
        responseMessage: Text;
        errorMessage: Text;
    begin
        responseCode := '';
        responseMessage := '';
        errorMessage := '';



        MBSEloanLogs.Reset;
        MBSEloanLogs.SetFilter(PhoneNo, '<>%1', 'WITHDRAWAL');
        MBSEloanLogs.SetFilter(SpotCashID, 'SSPSP16RBJ25899|SSPSP16QVZ71707');
        if MBSEloanLogs.FindFirst then begin
            repeat
                spotCashID := MBSEloanLogs.SpotCashID;
                referenceid := MBSEloanLogs.ReferenceID;
                phoneNo := MBSEloanLogs.PhoneNo;


                phoneNo := ConvertPhoneNo(phoneNo);

                //MESSAGE(phoneNo);
                MemberAccounts.Reset;
                MemberAccounts.SetRange("Transactional Mobile No", phoneNo);
                if MemberAccounts.FindFirst then begin
                    //MESSAGE('-'+MemberAccounts."No.");
                    WithdrawalBuffer.Reset;
                    WithdrawalBuffer.SetRange(WithdrawalBuffer."Trace ID", spotCashID);
                    WithdrawalBuffer.SetRange(WithdrawalBuffer.Source, WithdrawalBuffer.Source::"M-PESA");
                    //WithdrawalBuffer.SETRANGE(WithdrawalBuffer."Account No",MemberAccounts."No.");
                    WithdrawalBuffer.SetRange(Posted, false);
                    if WithdrawalBuffer.Find('-') then begin
                        //MESSAGE('2');

                        if MTrans.Get(spotCashID) then begin

                            MTrans."Reference No." := referenceid;
                            MTrans.Modify;
                            Commit;
                            //MESSAGE('3');
                        end;
                    end
                    else begin
                        responseCode := '06';
                        responseMessage := '';
                        errorMessage := 'Transaction Not Found';
                    end;
                end
                else begin
                    responseCode := '08';
                    responseMessage := '';
                    errorMessage := 'Member Account not found';
                end;

            until MBSEloanLogs.Next = 0;
        end;
    end;

    local procedure PostDeposits()
    var
        MTrans: Record "Spotcash Transactions";
        MBSEloanLogs: Record "Mbanking Eloan Logs";
    begin


        MBSEloanLogs.Init;
        MBSEloanLogs.Guid := CreateGuid;
        MBSEloanLogs.Date := Today;
        MBSEloanLogs.Time := Time;
        MBSEloanLogs.PhoneNo := 'DEPOSITS';
        MBSEloanLogs.LoanType := '';
        MBSEloanLogs.LoanPeriod := 0;
        MBSEloanLogs.Amount := 0;
        if MBSEloanLogs.Insert then
            Commit;

        MTrans.Reset;
        MTrans.SetRange(Posted, false);
        MTrans.SetRange(Failed, false);
        MTrans.SetRange("Needs Change", false);
        MTrans.SetFilter("Transaction Type", '%1|%2', MTrans."transaction type"::Paybill, MTrans."transaction type"::"Loan Repayment");
        if MTrans.FindFirst then begin
            PostMobileTransaction(MTrans.request_id);
        end;


        MTrans.Reset;
        MTrans.SetRange(Posted, false);
        MTrans.SetRange(Failed, false);
        MTrans.SetRange("Needs Change", false);
        MTrans.SetFilter("Transaction Type", '%1|%2', MTrans."transaction type"::Paybill, MTrans."transaction type"::"Loan Repayment");
        if MTrans.FindLast then begin
            PostMobileTransaction(MTrans.request_id);
        end;
    end;

    local procedure PostMiniBalance(ReID: Text)
    var
        MTrans: Record "Spotcash Transactions";
        MBSEloanLogs: Record "Mbanking Eloan Logs";
    begin


        MBSEloanLogs.Init;
        MBSEloanLogs.Guid := CreateGuid;
        MBSEloanLogs.Date := Today;
        MBSEloanLogs.Time := Time;
        MBSEloanLogs.PhoneNo := 'MINI';
        MBSEloanLogs.LoanType := '';
        MBSEloanLogs.LoanPeriod := 0;
        MBSEloanLogs.Amount := 0;
        if MBSEloanLogs.Insert then
            Commit;

        MTrans.Reset;
        if ReID <> '' then
            MTrans.SetRange(request_id, ReID);
        MTrans.SetRange(Failed, false);
        MTrans.SetRange(Posted, false);
        MTrans.SetRange("Needs Change", false);
        MTrans.SetFilter("Transaction Type", '%1|%2', MTrans."transaction type"::"Mini-Statement", MTrans."transaction type"::"Balance Enquiry");
        if MTrans.FindFirst then begin
            repeat
                PostMobileBalanceTransaction(MTrans.request_id);
            until MTrans.Next = 0;
        end;


        MTrans.Reset;
        if ReID <> '' then
            MTrans.SetRange(request_id, ReID);
        MTrans.SetRange(Failed, false);
        MTrans.SetRange(Posted, false);
        MTrans.SetRange("Needs Change", false);
        MTrans.SetFilter("Transaction Type", '%1|%2', MTrans."transaction type"::"Mini-Statement", MTrans."transaction type"::"Balance Enquiry");
        if MTrans.FindLast then begin
            PostMobileBalanceTransaction(MTrans.request_id);
        end;
    end;


    procedure PostMobileBalanceTransaction(DocumentNo: Code[20]) Response: Boolean
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        MpesaTrans: Record "Spotcash Transactions";
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
        IntRate: Decimal;
        MemberName: Text;
        Depositor: Text;
        GenSetup: Record "Sacco Setup";
        DepDesc: Text;
        MobileNo: Code[20];
        BLedger: Record "Bank Account Ledger Entry";
        SMSAccount: Text;
        SMSCharge: Decimal;
        MCommission: Record "SpotCash Setup";
        SacAcc: Code[20];
        BillAcc: Record "Savings Accounts";
        GenJournalBatch: Record "Gen. Journal Batch";
        SaccoTrans: Codeunit "Sacco Activities";
        DimID: Integer;
    begin

        Response := false;
        MpesaTrans.Reset;
        MpesaTrans.SetFilter("Transaction Type", '%1|%2', MpesaTrans."transaction type"::"Mini-Statement", MpesaTrans."transaction type"::"Balance Enquiry");
        MpesaTrans.SetRange(request_id, DocumentNo);
        MpesaTrans.SetRange(Posted, false);
        MpesaTrans.SetRange("Needs Change", false);

        GenSetup.Get;

        //IF GenSetup."MBanking Posting Date" <> 0D THEN
        //    MpesaTrans.SETRANGE("Transaction Date",GenSetup."MBanking Posting Date");


        if MpesaTrans.FindFirst then begin
            GenSetup.Get;



            BLedger.Reset;
            BLedger.SetRange("Document No.", MpesaTrans.request_id);
            if BLedger.FindFirst then begin
                MpesaTrans."Needs Change" := true;
                MpesaTrans.Posted := true;
                MpesaTrans.Failed := false;
                MpesaTrans."Needs Change" := false;
                MpesaTrans.Remarks := 'Already Posted';
                MpesaTrans.Modify;
                exit;
            end;


            // Get Excise duty G/L
            ExciseDutyGL := GetExciseDutyGL();
            ExciseDutyRate := GetExciseRate();
            ExciseDuty := 0;
            DimID := 0;



            SaccoAccount := '';
            SaccoFee := 0;
            VendorAccount := '';
            VendorCommission := 0;
            SafcomAcc := '';
            SafcomFee := 0;
            PrePaymentGL := '';
            SMSAccount := '';
            SMSCharge := 0;

            MCommission.Reset;
            MCommission.SetRange("Transaction Type", MpesaTrans."Transaction Type");
            if MCommission.FindFirst then begin

                SMSAccount := MCommission."SMS Account";
                SMSCharge := MCommission."SMS Charge";

                PrePaymentGL := MCommission."Pre-Payment Account";
                SafcomAcc := MCommission."Safaricom Account";
                SaccoAccount := MCommission."Sacco Fee Account";
                SaccoFee := MCommission."Sacco Fee";
                VendorAccount := MCommission."Vendor Commission Account";
                VendorCommission := MCommission."Vendor Commission";


                SaccoFee := MCommission."Sacco Fee";
                if MCommission."Sacco Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(MCommission."Sacco Staggered Charge", MpesaTrans.Amount, SaccoFee, ChargeDuty, ChargeAcctType, ChargeAcct);

                VendorCommission := MCommission."Vendor Commission";
                if MCommission."Vendor Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(MCommission."Vendor Staggered Charge", MpesaTrans.Amount, VendorCommission, ChargeDuty, ChargeAcctType, ChargeAcct);





                TotalCharge := SaccoFee + VendorCommission + SafcomFee + SMSCharge;
                ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
            end
            else begin
                if MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Pay Loan From Account" then
                    Error('Setup Missing for %1', MpesaTrans."Transaction Type");
            end;

            //ERROR('SafcomFee %1\SaccoFee %2',SafcomFee,SaccoFee);
            SavAcc.Reset;
            SavAcc.SetRange("Transactional Mobile No", ConvertPhoneNo(MpesaTrans.phone_no));
            //AzizSavAcc.SETRANGE("Account Type",'SAVINGS');
            if SavAcc.FindFirst then begin

                MemberName := SavAcc.Name;
                TransAmt := MpesaTrans.amount;
                AccountToCharge := SavAcc."No.";
                MobileNo := SavAcc."Transactional Mobile No";
                /*
                BillAcc.RESET;
                BillAcc.SETRANGE("Member No.",SavAcc."Member No.");
                BillAcc.SETRANGE("Account Type",'SAVINGS');
                IF BillAcc.FINDFIRST THEN BEGIN
                    AccountToCharge := BillAcc."No.";
                    MobileNo := BillAcc."Transactional Mobile No";
                END;
                */

                TransAmt := 0;

                if TotalCharge >= 0 then begin
                    if SavAcc.Blocked <> SavAcc.Blocked::" " then begin
                        MpesaTrans."Needs Change" := true;
                        MpesaTrans.Remarks := 'Account Blocked';
                        MpesaTrans.Modify;
                        exit;
                    end;
                end;

                if TotalCharge < 0 then begin
                    if (SavAcc.Blocked <> SavAcc.Blocked::" ") then begin
                        MpesaTrans."Needs Change" := true;
                        MpesaTrans.Remarks := 'Account Blocked';
                        MpesaTrans.Modify;
                        exit;
                    end;
                end;

                if (SavAcc.Blocked = SavAcc.Blocked::All) then begin
                    MpesaTrans."Needs Change" := true;
                    MpesaTrans.Remarks := 'Account Blocked';
                    MpesaTrans.Modify;
                    exit;
                end;


                if TotalCharge + ExciseDuty > AccountBalance(SavAcc."No.") then begin
                    MpesaTrans."Needs Change" := true;
                    MpesaTrans."Needs Change" := true;
                    MpesaTrans.Remarks := 'Insufficient Balance';
                    MpesaTrans.Modify;
                    exit;
                end;


                //BUser.GET(USERID);

                //BUser.TESTFIELD("Cashier Journal Template");
                //BUser.TESTFIELD("Cashier Journal Batch");

                JTemplate := 'CASHREC';
                JBatch := 'TANGAZO';

                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                GenJournalBatch.SetRange(Name, JBatch);
                if not GenJournalBatch.FindFirst then begin
                    GenJournalBatch.Init;
                    GenJournalBatch."Journal Template Name" := JTemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.Description := 'Tangazo Batch';
                    GenJournalBatch.Insert();
                end;

                DocNo := MpesaTrans.request_id;
                if MpesaTrans."Reference No." <> '' then
                    DocNo := MpesaTrans."Reference No.";

                PDate := MpesaTrans."Transaction Date";
                PDate := Today;

                AccNo := MpesaTrans.account_number;
                ExtDoc := '';

                if MpesaTrans."Reference No." <> '' then
                    ExtDoc := MpesaTrans.request_id;

                LoanNo := '';
                TransType := Transtype::" ";
                Dim1 := SavAcc."Global Dimension 1 Code";
                Dim2 := SavAcc."Global Dimension 2 Code";
                DimID := SavAcc."Dimension Set ID";
                SystCreated := true;


                SaccoTrans.JournalInit(JTemplate, JBatch);

                if MpesaTrans."Transaction Name" = '' then
                    MpesaTrans."Transaction Name" := Format(MpesaTrans."Transaction Type");


                if TotalCharge > 0 then begin

                    TChannel := TChannel::"Bal";
                    if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill then
                        TChannel := TChannel::"Paybill"
                    else if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Agent Deposit" then
                        TChannel := TChannel::"BDeposit"
                    else
                        if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Deposit" then
                            TChannel := TChannel::"BDeposit"
                        else
                            if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Loan Repayment" then
                                TChannel := TChannel::"Loan Repayment"
                            else
                                if MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Withdrawal" then
                                    TChannel := TChannel::"Withdrawal";

                    if (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::Paybill) and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Mpesa Deposit")
                        and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Loan Repayment") and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Bank Deposit")
                       and (MpesaTrans."Transaction Type" <> MpesaTrans."transaction type"::"Bank Agent Deposit") then begin

                        if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Mpesa Withdrawal") then
                            AccountToCharge := AccNo;

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccountToCharge, CopyStr(MpesaTrans."Transaction Name" + ' Charges', 1, 50), Balacctype::"G/L Account",
                                      '', VendorCommission + SaccoFee + SafcomFee + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);
                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AccountToCharge,COPYSTR('Corporate Charge',1,50),BalAccType::"Bank Account",
                        //            SafcomAcc,SafcomFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", SafcomAcc, CopyStr('Corporate Charge', 1, 50), Balacctype::"Bank Account",
                                      '', -SafcomFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);
                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AccountToCharge,COPYSTR('Transaction Charge',1,50),BalAccType::"G/L Account",
                        //            SaccoAccount,SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SaccoAccount, CopyStr(MpesaTrans."Transaction Name" + ' Charges', 1, 50), Balacctype::"G/L Account",
                                      '', -SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccountToCharge, CopyStr('SMS Charge - ', 1, 50), Balacctype::"G/L Account",
                                      SMSAccount, SMSCharge, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);
                        //SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AccountToCharge,COPYSTR('Excise Duty ',1,50),BalAccType::"G/L Account",
                        //            ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty ', 1, 50), Balacctype::"G/L Account",
                                      '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                    end;


                    AccNo := VendorAccount;
                    ExtDoc := MpesaTrans.account_number;
                    LoanNo := '';
                    TransType := Transtype::" ";

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, AccNo, CopyStr('Fee on ' + MpesaTrans.description, 1, 50), Balacctype::"G/L Account",
                                  '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                end;


                MpesaTrans.Posted := true;
                MpesaTrans.Failed := false;
                MpesaTrans."Needs Change" := false;

                MpesaTrans."Posted By" := UserId;
                MpesaTrans."Date Posted" := Today;
                MpesaTrans.Modify;
                Response := true;


                SaccoTrans.JournalPost(JTemplate, JBatch);

            end
            else begin

                if (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::Paybill) or (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Agent Deposit") or
                  (MpesaTrans."Transaction Type" = MpesaTrans."transaction type"::"Bank Deposit") then begin

                    if Loans.Get(MpesaTrans.account_number) then begin
                        SavAcc.Reset;
                        SavAcc.SetRange("Member No.", Loans."Member No.");
                        //AzizSavAcc.SETRANGE("Account Type",'SAVINGS');
                        if SavAcc.FindFirst then begin
                            MpesaTrans.description := 'Loan Repayment ' + MpesaTrans.account_number;
                            MpesaTrans.account_number := SavAcc."No.";
                            MpesaTrans."Loan No." := Loans."Loan No.";
                            MpesaTrans."Transaction Type" := MpesaTrans."transaction type"::"Loan Repayment";
                            MpesaTrans."Needs Change" := false;
                            MpesaTrans.Modify;
                        end
                        else begin
                            MpesaTrans."Needs Change" := true;

                            MpesaTrans.Remarks := 'Savings Account Not Found';
                            MpesaTrans.Modify;
                        end
                    end
                    else begin
                        MpesaTrans."Needs Change" := true;

                        MpesaTrans.Remarks := 'Loan No. Not Found';
                        MpesaTrans.Modify;
                    end;

                end
                else begin
                    MpesaTrans."Needs Change" := true;

                    MpesaTrans.Remarks := 'Unknown Transaction type';
                    MpesaTrans.Modify;
                end;
            end;
        end;

    end;


    procedure PostTransactions()
    var
        I: Integer;
    begin


        Commit;
        for I := 1 to 5 do
            PostWithdrawals;

        Commit;
        for I := 1 to 5 do
            PostDeposits;

        Commit;
        for I := 1 to 5 do
            PostMiniBalance('');
    end;


    procedure UpdateWithdrawalTransactions()
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        SaccoAccount: Code[20];
        VendorAccount: Code[20];
        MpesaTrans: Record "Spotcash Transactions";
        TransAmt: Decimal;
        BUser: Record "User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Option " ","Registration Fee","Shares Capital","Deposit Contribution","Benevolent Fund",Loan,Repayment,"Interest Due","Interest Paid","Loan Penalty","Appraisal Fee","Unallocated Funds","Jiajiri Shares","Loan Provision","Loan Bill";
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
        IntRate: Decimal;
        MemberName: Text;
        Depositor: Text;
        GenSetup: Record "Sacco Setup";
        DepDesc: Text;
        MobileNo: Code[20];
        BLedger: Record "Bank Account Ledger Entry";
        SMSAccount: Text;
        SMSCharge: Decimal;
        MCommission: Record "SpotCash Setup";
        SacAcc: Code[20];
        BillAcc: Record "Savings Accounts";
        GenJournalBatch: Record "Gen. Journal Batch";
        SaccoTrans: Codeunit "Sacco Activities";
        wDEntry: Boolean;
    begin



        MpesaTrans.Reset;
        MpesaTrans.SetRange("Withdrawal Request", true);
        //MpesaTrans.SETRANGE(request_id,DocumentNo);
        MpesaTrans.SetRange(Posted, true);
        MpesaTrans.SetRange("Buffer Updated", false);
        if MpesaTrans.FindFirst then begin
            repeat

                //MARK BUFFER AS POSTED
                MobileWithdrawalsBuffer.Reset;
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Trace ID", MpesaTrans.request_id);
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Source, MobileWithdrawalsBuffer.Source::"M-PESA");
                //MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Account No",MpesaTrans.account_number);
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Amount, MpesaTrans.amount);
                if MobileWithdrawalsBuffer.Find('-') then begin

                    MobileWithdrawalsBuffer.Posted := true;
                    MobileWithdrawalsBuffer."Posting Date" := Today;
                    MobileWithdrawalsBuffer."Withdrawal Location" := 'SPOTCASH';
                    MobileWithdrawalsBuffer.Modify;
                    MpesaTrans."Buffer Updated" := true;
                    MpesaTrans.Modify;
                end;
            until MpesaTrans.Next = 0;
        end;


        MpesaTrans.Reset;
        MpesaTrans.SetRange("Withdrawal Request", true);
        MpesaTrans.SetRange(Remarks, 'You have insufficient balance');
        MpesaTrans.SetRange(Posted, false);
        if MpesaTrans.FindFirst then begin
            repeat

                //MARK BUFFER AS POSTED
                MobileWithdrawalsBuffer.Reset;
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Trace ID", MpesaTrans.request_id);
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Source, MobileWithdrawalsBuffer.Source::"M-PESA");
                //MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Account No",MpesaTrans.account_number);
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Amount, MpesaTrans.amount);
                MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Posted, true);
                if MobileWithdrawalsBuffer.Find('-') then begin
                    MobileWithdrawalsBuffer.Posted := false;
                    MobileWithdrawalsBuffer.Modify;
                end;
            until MpesaTrans.Next = 0;
        end;


        MpesaTrans.Reset;
        MpesaTrans.SetRange("Withdrawal Request", true);
        MpesaTrans.SetRange(Remarks, 'You have insufficient balance');
        MpesaTrans.SetRange(Posted, false);
        MpesaTrans.SetRange(Failed, false);
        if MpesaTrans.FindFirst then begin
            repeat
                MpesaTrans.Failed := true;
                MpesaTrans.Modify;

            until MpesaTrans.Next = 0;
        end;

        MpesaTrans.Reset;
        MpesaTrans.SetRange("Withdrawal Request", true);
        MpesaTrans.SetRange(Failed, true);
        MpesaTrans.SetRange(Posted, false);
        MpesaTrans.SetFilter("Next Retry Date", '<=%1', Today);
        if MpesaTrans.FindFirst then begin
            repeat
                MpesaTrans.Failed := false;
                MpesaTrans."Next Retry Date" := Today + 1;
                MpesaTrans.Modify;
            until MpesaTrans.Next = 0;
        end;
    end;

    local procedure GetMbankingUser(MobileNo: Code[20]) IDNo: Text
    var
        MPESAApplications: Record "MBanking Applications";
    begin
        IDNo := '';
        MPESAApplications.Reset;
        MPESAApplications.SetCurrentkey("Document Date");
        MPESAApplications.SetRange(MPESAApplications."Mpesa Mobile No", MobileNo);
        MPESAApplications.SetRange(MPESAApplications.Status, MPESAApplications.Status::Approved);
        if MPESAApplications.FindLast then begin
            IDNo := MPESAApplications."Customer ID No";
        end;
    end;

    local procedure CallSpotCash()
    var
        request_id: Text;
        phone_no: Text;
        transaction_type: Text;
        amount: Text;
        trnx_charges: Text;
        account__number: Text;
        cr_account: Text;
        status: Text;
        f_key: Text;
        balance: Text;
        tmessage: Text;
        response: Text;
        response_message: Text;
        customerType: Text;
        description: Text;
        startDate: Text;
        endDate: Text;
        startTime: Text;
        endTime: Text;
        emailaddress: Text;
    begin
        request_id := 'T123435156';
        f_key := 'T123435156';
        phone_no := '+254722970748';
        response := '';
        response_message := '';
        transaction_type := '706';
        amount := '5000';
        trnx_charges := '0';
        balance := '0';
        startDate := Format(Today);
        endDate := Format(Today);
        account__number := '001105002929';
        account__number := '001105002929';


        SpotCash(
        request_id,
        phone_no,
        transaction_type,
        amount,
        trnx_charges,
        account__number,
        cr_account,
        status,
        f_key,
        balance,
        tmessage,
        response,
        response_message,
        customerType,
        description,
        startDate,
        endDate,
        startTime,
        endTime,
        emailaddress);

        Message('- %1\- %2', response, response_message);
    end;

    local procedure SendNotifications("Key": Guid; Filtered: Boolean)
    var
        MbankingNotifications: Record "Mbanking Notifications";
        CompInfo: Record "Company Information";
        SenderName: Text;
        SenderAddress: Text;
        FileName: Text;
        FilePath: Text;
        SACCOAccount: Record "Savings Accounts";
        Members: Record Members;
    begin


        MbankingNotifications.Reset;
        if Filtered then
            MbankingNotifications.SetRange(Guid, Key);
        MbankingNotifications.SetRange(Sent, false);
        if MbankingNotifications.FindFirst then begin
            repeat


                SACCOAccount.Reset;
                SACCOAccount.SetRange("No.", MbankingNotifications."Account No");
                SACCOAccount.SetFilter("Date Filter", '%1..%2', MbankingNotifications."Filter SDate", MbankingNotifications."Filter EDate");
                if SACCOAccount.FindFirst then begin
                    CompInfo.Get;


                    Members.Reset;
                    Members.SetRange("No.", SACCOAccount."Member No.");
                    if Members.FindFirst then begin

                        Commit();
                        Report.Run(Report::"E-Mail Member Statement", true, false, Members);
                        Commit();
                        MbankingNotifications.Sent := true;
                        MbankingNotifications.modify;
                    end;

                end;

            until MbankingNotifications.Next() = 0;

        end;
    end;



    local procedure CheckSufficientBalance(TransCode: Code[20]; AccountNo: Code[20]; Amount: Decimal; Date: Date; var response: Text; var response_message: Text; TransType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer") Success: Boolean
    var
        MTrans: Record "Spotcash Transactions";
        WithdrawalBuffer: Record "Mobile Withdrawal Buffer";
        MobileComm: Record "SpotCash Setup";
        SaccoSetup: Record "Sacco Setup";
        SMSCharge: Decimal;
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        AccBal: Decimal;
        Vendor: Record "Savings Accounts";
        SavAcc: Record "Savings Accounts";
        ProductSetup: Record "Product Setup";
        SafcomCharges: Record "Safcom Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        DividendFee: decimal;
    begin
        Success := false;
        SaccoSetup.Get();

        MTrans.Get(TransCode);
        MobileComm.Reset;
        MobileComm.SetRange("Transaction Type", TransType);
        if MobileComm.FindFirst then begin

            SMSCharge := MobileComm."SMS Charge";
            SaccoFee := MobileComm."Sacco Fee";
            VendorCommission := MobileComm."Vendor Commission";
            ExciseDutyRate := SaccoSetup."Excise Duty (%)";

            SafcomFee := 0;
            DividendFee := 0;
            if MTrans."Transaction Type" = MTrans."transaction type"::"Mpesa Withdrawal" then begin
                //MTrans.TESTFIELD("Reference No.");
                SafcomCharges.Reset;
                SafcomCharges.SetFilter(Charge, '>0');
                SafcomCharges.SetFilter(Minimum, '<=%1', MTrans.amount);
                SafcomCharges.SetFilter(Maximum, '>=%1', MTrans.amount);
                SafcomCharges.SetRange(Category, SafcomCharges.Category::Safaricom);
                if SafcomCharges.FindFirst then begin
                    SafcomFee := SafcomCharges.Charge;
                end;

                if MobileComm."Safcom Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(MobileComm."Safcom Staggered Charge", MTrans.Amount, SafcomFee, ChargeDuty, ChargeAcctType, ChargeAcct);

            end;

            if MTrans."Transaction Type" = MTrans."Transaction Type"::"Bank Transfer" then begin

                if MobileComm."Safcom Staggered Fee" then
                    MActivities.GetGeneralChargeAmountOnly(MobileComm."Safcom Staggered Charge", Amount, SafcomFee, ChargeDuty, ChargeAcctType, ChargeAcct);
            end;

            SaccoFee := MobileComm."Sacco Fee";
            if MobileComm."Sacco Staggered Fee" then
                MActivities.GetGeneralChargeAmountOnly(MobileComm."Sacco Staggered Charge", Amount, SaccoFee, ChargeDuty, ChargeAcctType, ChargeAcct);

            VendorCommission := MobileComm."Vendor Commission";
            if MobileComm."Vendor Staggered Fee" then
                MActivities.GetGeneralChargeAmountOnly(MobileComm."Vendor Staggered Charge", Amount, VendorCommission, ChargeDuty, ChargeAcctType, ChargeAcct);


            ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
            TotalCharge := SaccoFee + VendorCommission + SMSCharge + SafcomFee + ExciseDuty;
        end
        else begin
            Error('Setup Missing for %1', TransType);
        end;



        AccBal := AccountBalance(AccountNo);

        if Vendor.Get(AccountNo) then begin
            if Vendor.Blocked <> Vendor.Blocked::" " then begin
                response := '39';
                response_message := 'Your Account is Blocked';
                MTrans.Remarks := response_message;
                MTrans.Failed := true;

                MTrans."Next Retry Date" := Today + 1;
                MTrans.Modify;

                exit;
            end;

            if ProductSetup.Get(Vendor."Product Type") then begin
                if ProductSetup."Savings Type" <> ProductSetup."Savings Type"::Withdrawable then begin

                    response := '39';
                    response_message := 'You cannot withdraw from this account';
                    MTrans.Remarks := response_message;
                    MTrans.Failed := true;

                    MTrans.Modify;

                    exit;
                end;

                if ProductSetup."Savings Type" = ProductSetup."Savings Type"::Withdrawable then begin
                    if (ProductSetup."Product Category" <> ProductSetup."Product Category"::"Ordinary Savings") and
                        (ProductSetup."Product Category" <> ProductSetup."Product Category"::"Dividend Account") then begin

                        response := '39';
                        response_message := 'You cannot withdraw from this account';
                        MTrans.Remarks := response_message;
                        MTrans.Failed := true;

                        MTrans.Modify;

                        exit;

                    end;
                end;
            end;

        end else begin
            response := '22';
            response_message := 'Account Not Found.';
            MTrans.Remarks := response_message;
            MTrans.Failed := true;
            MTrans.Posted := true;
            MTrans."Next Retry Date" := Today + 1;
            MTrans.Modify;
            exit;
        end;

        if Amount <= 0 then begin
            response := '01';
            response_message := 'You have insufficient balance';
            MTrans.Remarks := response_message;
            MTrans.Failed := true;
            MTrans.Posted := true;
            MTrans."Next Retry Date" := Today + 1;
            MTrans.Modify;
            exit;
        end;

        if AccBal >= Amount + TotalCharge + ExciseDuty then begin

            response := '00';
            response_message := 'Success';
        end
        else begin
            response := '01';
            response_message := 'You have insufficient balance';
            MTrans.Remarks := response_message;
            MTrans.Failed := true;
            MTrans.Posted := true;
            MTrans."Next Retry Date" := Today + 1;
            MTrans.Modify;
            exit;
        end;

        Success := true;
    end;


    procedure UpdateWithdrawalsBuffer(var spotCashID: Text; var referenceid: Text; var phoneNo: Text; var responseCode: Text; var responseMessage: Text; var errorMessage: Text): Integer
    var
        LocalisDetected: Boolean;
        LocalErrMsg: Text;

        LocalStringWriter: Text;

        LocalJsonText: Text;
        LocalMsgCode: Text;
        MemberAccounts: Record "Savings Accounts";
        WithdrawalBuffer: Record "Mobile Withdrawal Buffer";
        MTrans: Record "Spotcash Transactions";
    begin
        responseCode := '';
        responseMessage := '';
        errorMessage := '';


        MemberAccounts.Reset;
        MemberAccounts.SetRange("Transactional Mobile No", phoneNo);
        if MemberAccounts.FindFirst then begin

            WithdrawalBuffer.Reset;
            WithdrawalBuffer.SetRange(WithdrawalBuffer."Trace ID", spotCashID);
            WithdrawalBuffer.SetRange(WithdrawalBuffer.Source, WithdrawalBuffer.Source::"M-PESA");
            //WithdrawalBuffer.SETRANGE(WithdrawalBuffer."Account No",MemberAccounts."No.");
            WithdrawalBuffer.SetRange(Posted, false);
            if WithdrawalBuffer.Find('-') then begin
                if MTrans.Get(spotCashID) then begin
                    MTrans."Reference No." := referenceid;
                    MTrans.Modify;
                    Commit;
                    PostMobileTransaction(MTrans.request_id);
                    WithdrawalBuffer.Posted := true;
                    WithdrawalBuffer.Modify;
                    responseCode := '00';
                    if MTrans."Transaction Type" = MTrans."transaction type"::"Bank Transfer" then
                        responseMessage := 'Bank Transfer Successful';
                    if MTrans."Transaction Type" = MTrans."transaction type"::"Mpesa Withdrawal" then
                        responseMessage := 'Withdrawal Successful';
                    if MTrans."Transaction Type" = MTrans."transaction type"::Airtime then
                        responseMessage := 'Airtime Purchase Successful';
                    if MTrans."Transaction Type" = MTrans."transaction type"::"Utility Payment" then
                        responseMessage := 'Utility Payment Successful';
                end;
            end
            else begin
                responseCode := '06';
                responseMessage := '';
                errorMessage := 'Transaction Not Found';
            end;
        end
        else begin
            responseCode := '08';
            responseMessage := '';
            errorMessage := 'Member Account not found';
        end;
    end;



    procedure GetCharges(TransCode: Code[20])
    var
        MTrans: Record "Spotcash Transactions";
        WithdrawalBuffer: Record "Mobile Withdrawal Buffer";
        MobileComm: Record "SpotCash Setup";
        SMSCharge: Decimal;
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        AccBal: Decimal;
        Vendor: Record "Savings Accounts";
        SavAcc: Record "Savings Accounts";
        ProductSetup: Record "Product Setup";
        SafcomCharges: Record "Safcom Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
    begin
        MTrans.Get(TransCode);
        MobileComm.Reset;
        MobileComm.SetRange("Transaction Type", MTrans."Transaction Type");
        if MobileComm.FindFirst then begin

            SMSCharge := MobileComm."SMS Charge";
            SaccoFee := MobileComm."Sacco Fee";
            VendorCommission := MobileComm."Vendor Commission";



            SafcomFee := 0;
            if MTrans."Transaction Type" = MTrans."transaction type"::"Mpesa Withdrawal" then begin
                //MTrans.TESTFIELD("Reference No.");
                SafcomCharges.Reset;
                SafcomCharges.SetFilter(Charge, '>0');
                SafcomCharges.SetFilter(Minimum, '<=%1', MTrans.amount);
                SafcomCharges.SetFilter(Maximum, '>=%1', MTrans.amount);
                SafcomCharges.SetRange(Category, SafcomCharges.Category::Safaricom);
                if SafcomCharges.FindFirst then begin
                    SafcomFee := SafcomCharges.Charge;
                end;
            end;



            SaccoFee := MobileComm."Sacco Fee";
            if MobileComm."Sacco Staggered Fee" then
                MActivities.GetGeneralChargeAmountOnly(MobileComm."Sacco Staggered Charge", MTrans.Amount, SaccoFee, ChargeDuty, ChargeAcctType, ChargeAcct);

            VendorCommission := MobileComm."Vendor Commission";
            if MobileComm."Vendor Staggered Fee" then
                MActivities.GetGeneralChargeAmountOnly(MobileComm."Vendor Staggered Charge", MTrans.Amount, VendorCommission, ChargeDuty, ChargeAcctType, ChargeAcct);




            TotalCharge := SaccoFee + VendorCommission + SMSCharge + SafcomFee;
            ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
            Message('Vendor: %1\Sacco: %2\Safcom: %3\Duty: %4', VendorCommission, SaccoFee, SafcomFee, ExciseDuty);


        end
        else begin
            Error('Setup Missing for %1', MTrans."Transaction Type");
        end;
    end;


}

