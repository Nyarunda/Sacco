codeunit 50138 "Online Regsitration"
{
    trigger OnRun()
    begin


    end;

    var
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
        RequestId := SelectJsonToken(RequestJson, '$.request.id').AsValue.AsText;
        RequestAction := SelectJsonToken(RequestJson, '$.request.action').AsValue.AsText;
        UserName := SelectJsonToken(RequestJson, '$.request.user').AsValue.AsText;
        SessionId := SelectJsonToken(RequestJson, '$.request.session_id').AsValue.AsText;
        Timestamp := SelectJsonToken(RequestJson, '$.request.timestamp').AsValue.AsText;



        ResponseJson.Remove(Status);

        PayloadJson.WriteTo(ResponsePayload);
        ResponseHash := Sha256Hash(ResponsePayload);

        ResponseInnerJson.Add('id', RequestId);
        ResponseInnerJson.Add('action', RequestAction);
        ResponseInnerJson.Add('status', ResponseStatus);
        ResponseInnerJson.Add('status_message', ResponseMessage);
        ResponseInnerJson.Add('hash', ResponseHash);
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
        UserName := SelectJsonToken(RequestJson, '$.request.user').AsValue.AsText;
        SessionId := SelectJsonToken(RequestJson, '$.request.session_id').AsValue.AsText;

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














































    //OnlineRegistration
    procedure MemberRegistrationLead(Request: Text) Response: Text
    var
        //--LocalJsonTextWriter: dotnet JsonTextWriter;
        Status: Code[50];
        Source: Enum "SMS Source Enum";
        ResponseTitle: Text;
        ResponseMessage: Text;
        Indent: Boolean;
        PortalAuth: Record "Portal Auth";
        "Action": Code[50];
        Members: Record Customer;
        MemberImages: Record "Member Images";
        SkyMbanking: Codeunit "Sky Mbanking";
        PicBase64: Text;
        Found: Boolean;
        Criteria: Code[20];
        Len: Integer;
        PortalRegInit: Record "Portal Registration Attempt";
        SActivity: Codeunit "Sacco Activities";
        Subject: Label 'OTP';
        Salutation: Text;
        Body: Text;
        Email: Text;
        PhoneNo: Text;
        FName: Text;
        SName: Text;
        ONames: Text;

        JObject: JsonObject;
        JsObject_1: JsonObject;
        JsObject_2: JsonObject;
        JsObject_3: JsonObject;
        JsObject_4: JsonObject;
        JsObject_5: JsonObject;
        JsObject_6: JsonObject;
        JsonResult: JsonObject;
        RequestJson: JsonObject;
        OutputJson: JsonObject;
        RequestDataJson: JsonObject;
        RequestAction: Text;
        SessionId: Text;
        SessionValid: Boolean;
        PortalRegistration: Record "Member Registration";

    begin
        if not RequestJson.ReadFrom(Request) then
            Error('Invalid Json Input');

        Email := SelectJsonToken(RequestJson, '$.Email').AsValue.AsText;
        PhoneNo := SelectJsonToken(RequestJson, '$.PhoneNo').AsValue.AsText;
        FName := SelectJsonToken(RequestJson, '$.FirstName').AsValue.AsText;
        SName := SelectJsonToken(RequestJson, '$.Surname').AsValue.AsText;
        ONames := SelectJsonToken(RequestJson, '$.OtherNames').AsValue.AsText;

        PhoneNo := ValidatePhoneNo(PhoneNo);

        Status := 'FAILED';
        ResponseTitle := 'REGISTRATION LEAD';
        ResponseMessage := 'Portal Registration Failed';
        /*-------------------------------------------------------------------------------------*/

        Members.reset;
        Members.setrange("E-mail", Email);
        if Members.findfirst then begin

            Status := 'FAILED';
            ResponseTitle := 'OTP Notification Failed';
            ResponseMessage := 'Email Already Exists';
        end
        else begin

            Members.reset;
            Members.setrange("Mobile Phone No.", PhoneNo);
            if Members.findfirst then begin

                Status := 'FAILED';
                ResponseTitle := 'OTP Notification Failed';
                ResponseMessage := 'Mobile No. Already Exists';
            end
            else begin


                PortalRegInit.Reset;
                PortalRegInit.SetRange("E-mail", Email);
                if PortalRegInit.FindFirst then begin

                    PortalRegInit.Date := today;
                    PortalRegInit."Phone No." := PhoneNo;
                    PortalRegInit."First Name" := FName;
                    PortalRegInit."Surname" := SName;
                    PortalRegInit."Other Names" := FName;
                    PortalRegInit.OTP := '1234';//SkyMbanking.RandomPIN;
                    PortalRegInit."OTP Expiry Time" := CurrentDateTime + 120000;
                    PortalRegInit.Modify();
                    Found := true;
                end
                else begin

                    PortalRegInit.init;
                    PortalRegInit."E-mail" := Email;
                    PortalRegInit."Phone No." := PhoneNo;
                    PortalRegInit."First Name" := FName;
                    PortalRegInit."Surname" := SName;
                    PortalRegInit."Other Names" := FName;
                    PortalRegInit.OTP := '1234';//SkyMbanking.RandomPIN;
                    PortalRegInit.Date := today;
                    PortalRegInit."OTP Expiry Time" := CurrentDateTime + (120000 * 5);

                    PortalRegInit.insert;

                end;


                Salutation := 'Greetings,<br>';


                Body := 'Welcome to ' + CompanyName + ', Your OTP for Member Registration is ' + PortalRegInit.OTP;






                if /*(SActivity.SendEmail(Email, '', '', Subject, Salutation, Body))
                    OR*/ (SkyMbanking.SendSms(Source::"New Member", PhoneNo, Body, Email, '', FALSE, 205, FALSE))
                 then begin

                    Status := 'SUCCESS';
                    ResponseTitle := 'OTP Notification Successful';
                    ResponseMessage := 'OTP Notification Successful.' + Body;
                end
                else begin

                    Status := 'FAILED';
                    ResponseTitle := 'OTP Notification Failed: ' + PortalRegInit.OTP;
                    ResponseMessage := 'OTP Notification Failed: ' + PortalRegInit.OTP;
                end;

            end;
        end;


        /*----------------------------------------------------------------------------------*/


        Action := 'OTP_NOTIFICATION';

        JsObject_1.Add('title', ResponseTitle);
        JsObject_1.Add('message', ResponseMessage);

        JsObject_2.Add('action', Action);
        JsObject_2.Add('status', Status);
        JsObject_2.Add('payload', JsObject_1);

        JsonResult.Add('response', JsObject_2);

        JsonResult.WriteTo(Response);


    end;


    //OnlineRegistration
    procedure VerifyOTPForRegistrationLead(Request: Text) Response: Text
    var
        PortalReg: Record "Member Registration";

        JsonDocs: JsonObject;
        JsonNOK: JsonObject;
        JsonNOKArray: JsonArray;
        JsonDocsArray: JsonArray;
        JsonResult: JsonObject;

        ApplicationDocs: Record "Attachment Documents";

        MemberDataJS: JsonObject;
        Nok: Record "Next of Kin.";
        Status: Code[50];
        ResponseTitle: Text;
        ResponseMessage: Text;
        Indent: Boolean;
        PortalAuth: Record "Portal Auth";
        "Action": Code[50];
        Members: Record Customer;
        MemberImages: Record "Member Images";
        PicBase64: Text;
        Found: Boolean;
        Criteria: Code[20];
        Len: Integer;
        PortalRegInit: Record "Portal Registration Attempt";
        SActivity: Codeunit "Sacco Activities";
        Subject: Label 'OTP';
        Salutation: Text;
        Body: Text;
        Email: Text;
        OTP: Text;
        FName: Text;
        SName: Text;
        ONames: Text;

        JObject: JsonObject;
        JsObject_1: JsonObject;
        JsObject_2: JsonObject;
        JsObject_3: JsonObject;
        JsObject_4: JsonObject;
        JsObject_5: JsonObject;
        JsObject_6: JsonObject;
        RequestJson: JsonObject;
        OutputJson: JsonObject;
        RequestDataJson: JsonObject;
        RequestAction: Text;
        SessionId: Text;
        SessionValid: Boolean;

        Banks: Record "Bank Codes";
        BankBranches: Record "Bank Branches";

        JsonBank: JsonObject;
        JsonBankArray: JsonArray;


        JsonBranch: JsonObject;
        JsonBranchArray: JsonArray;
    begin
        if not RequestJson.ReadFrom(Request) then
            Error('Invalid Json Input');

        Email := SelectJsonToken(RequestJson, '$.Email').AsValue.AsText;
        OTP := SelectJsonToken(RequestJson, '$.OTP').AsValue.AsText;



        Status := 'FAILED';
        ResponseTitle := 'Change Request Failed';
        ResponseMessage := 'Request to Fetch Change Request Model has Failed';
        /*-------------------------------------------------------------------------------------*/




        Banks.reset;
        if Banks.findfirst then begin
            repeat
                clear(JsonBank);
                clear(JsonBranchArray);
                JsonBank.add('bank_code', Banks."Bank Code");
                JsonBank.add('bank_name', Banks."Bank Name");
                BankBranches.reset;
                BankBranches.setrange("Bank Code", Banks."Bank Code");
                if BankBranches.findfirst then begin
                    repeat
                        clear(JsonBranch);
                        JsonBranch.add('branch_code', BankBranches."Branch Code");
                        JsonBranch.add('branch_name', BankBranches."Branch Name");
                        JsonBranchArray.add(JsonBranch);
                    until BankBranches.next = 0;
                end;
                JsonBank.add('bank_branches', JsonBranchArray);
                JsonBankArray.add(JsonBank);
            until Banks.next = 0;
        end;



        PortalRegInit.Reset;
        PortalRegInit.SetRange("E-mail", Email);
        PortalRegInit.setrange(OTP, OTP);
        if PortalRegInit.FindFirst then begin
            if CurrentDateTime > PortalRegInit."OTP Expiry Time" then begin


                Status := 'FAILED';
                ResponseTitle := 'OTP has Expired';
                ResponseMessage := 'OTP has Expired';
            end
            else begin


                Status := 'SUCCESS';
                ResponseTitle := 'OTP Verification Successful';
                ResponseMessage := 'OTP Verification Successful';

                PortalReg.reset;
                PortalReg.setrange("E-mail", Email);
                if not PortalReg.findfirst then begin

                    MemberDataJS.add('first_name', PortalRegInit."First Name");
                    MemberDataJS.add('surname', PortalRegInit.Surname);
                    MemberDataJS.add('other_names', PortalRegInit.surname);
                    MemberDataJS.add('mobile_phone_number', PortalRegInit."Phone No.");
                    MemberDataJS.add('email', PortalRegInit."E-Mail");
                end
                else begin


                    Status := 'APPLICATION_EXISTS';
                    MemberDataJS.add('first_name', PortalReg."First Name");
                    MemberDataJS.add('surname', PortalReg.Surname);
                    MemberDataJS.add('other_names', PortalReg."Middle Name");
                    MemberDataJS.add('id_type', PortalReg."ID Type");
                    MemberDataJS.add('id_number', PortalReg."ID No.");
                    MemberDataJS.add('kra_pin', PortalReg."KRA PIN");
                    MemberDataJS.add('email', PortalReg."E-Mail");
                    MemberDataJS.add('date_of_birth', PortalReg."Date of Birth");
                    MemberDataJS.add('gender', PortalReg.Gender);
                    MemberDataJS.add('marital_status', PortalReg."Marital Status");
                    MemberDataJS.add('post_code', PortalReg."Post Code");
                    MemberDataJS.add('po_box', PortalReg.address);
                    MemberDataJS.add('physical_address', PortalReg."Address 2");
                    //MemberDataJS.add('nearest_landmark', PortalReg."Nearest Land Mark");
                    MemberDataJS.add('country_code', PortalReg."Country/Region Code");
                    //MemberDataJS.add('country_name', PortalReg."Country Name");
                    MemberDataJS.add('mobile_phone_number', PortalReg."Mobile Phone No.");
                    MemberDataJS.add('personal_email', PortalReg."E-Mail");
                    MemberDataJS.add('employer_name', PortalReg."Employer Name");
                    //MemberDataJS.add('employment_status', Format(PortalReg."Employment Status"));
                    MemberDataJS.add('terms_of_employment', PortalReg."Terms of Employment");
                    MemberDataJS.add('recruited_by_type', PortalReg."recruited By type");
                    //MemberDataJS.add('recruited_by_reference', PortalReg."Recruited By Reference");
                    MemberDataJS.add('bank_code', PortalReg."Bank Code");
                    MemberDataJS.add('bank_name', PortalReg."Bank Name");
                    MemberDataJS.add('bank_branch_code', PortalReg."Branch Code");
                    MemberDataJS.add('bank_branch_name', PortalReg."Branch Name");
                    MemberDataJS.add('bank_account_no', PortalReg."Bank Account No.");
                    MemberDataJS.add('bank_account_name', PortalReg."Bank Account Name");
                    MemberDataJS.add('swift_code', PortalReg."Swift Code");
                    //MemberDataJS.add('security_question_1', PortalReg."Question 1");
                    //MemberDataJS.add('security_question_2', PortalReg."Question 2");
                    //MemberDataJS.add('answer_1', PortalReg."Answer 1");
                    //MemberDataJS.add('answer_2', PortalReg."Answer 2");
                    MemberDataJS.add('application_no', PortalReg."No.");
                    MemberDataJS.add('customer_type', Format(PortalReg."Account Category"));


                    Nok.Reset;
                    Nok.SetRange("No.", PortalReg."No.");
                    if Nok.FindFirst() then begin
                        repeat

                            Clear(JsonNOK);
                            JsonNOK.Add('number', Nok."No.");
                            JsonNOK.Add('name', Nok.Name);
                            JsonNOK.Add('mobile_number', Nok."Mobile Phone No.");
                            JsonNOK.Add('id_pp_number', Nok."ID No.");
                            JsonNOK.Add('relation', Nok.Relationship);
                            JsonNOK.Add('allocation', Nok."%Allocation");
                            JsonNOK.Add('kin_age_group', Nok.NokType);
                            JsonNOK.Add('guardian', Nok.GuardianName);
                            JsonNOKArray.Add(JsonNOK);

                        until nok.next = 0;
                    end;
                    MemberDataJS.Add('NextOfKin', JsonNOKArray);



                end;



                ApplicationDocs.Reset;
                ApplicationDocs.SetRange("Application Type", PortalRegInit."Member Type");
                ApplicationDocs.SetRange(Active, ApplicationDocs.Active::Yes);
                if ApplicationDocs.FindFirst() then begin
                    repeat

                        Clear(JsonDocs);
                        JsonDocs.Add('code', ApplicationDocs."document id");
                        JsonDocs.Add('description', ApplicationDocs."document Decsription");
                        JsonDocs.Add('document_type', Format(ApplicationDocs."Document Type"));
                        JsonDocsArray.Add(JsonDocs);

                    until ApplicationDocs.next = 0;
                end;
            end;

        end
        else begin

            Status := 'FAILED';
            ResponseTitle := 'OTP Verification Failed';
            ResponseMessage := 'OTP Verification Failed';
        end;


        /*----------------------------------------------------------------------------------*/


        Action := 'OTP_VERIFICATION';

        JsObject_1.Add('title', ResponseTitle);
        JsObject_1.Add('message', ResponseMessage);
        JsObject_1.Add('application_data', MemberDataJS);
        JsObject_1.Add('application_documents', JsonDocsArray);
        JsObject_1.Add('banks', JsonBankArray);

        JsObject_2.Add('action', Action);
        JsObject_2.Add('status', Status);
        JsObject_2.Add('payload', JsObject_1);

        JsonResult.Add('response', JsObject_2);

        JsonResult.WriteTo(Response);


    end;


    //OnlineRegistration
    procedure SubmitPersonalData(Request: Text) Response: Text;
    var
        Kin_id_number: Text;
        Kin_allocation: TExt;
        NewApplication: Boolean;
        ApplicationNo: Code[20];
        RefereeContact: Text;
        SpouseName: Text;
        SpouseIdNumber: Text;
        SpouseMobilePhoneNumber: Text;


        fileID: Text;
        fieldName: Text;
        fileName: Text;
        fileUrl: Text;
        blobName: Text;

        //PortalReg: Record "Portal Member Registration";
        PortalReg: Record "Member Registration";
        KinName: Text;
        KinRelationship: Text;
        KinContactInfo: Text;
        RequestJson: JsonObject;
        JsonNOKToken: JsonToken;
        JsonNOKArrays: JsonArray;
        JsonTokenLine: JsonToken;
        JsonNOK: JsonObject;
        Status: Code[50];
        ResponseTitle: Text;
        ResponseMessage: Text;
        Members: Record Customer;
        JsonResult: JsonObject;
        JsObject_1: JsonObject;
        JsObject_2: JsonObject;

        PlcInterest: Boolean;
        PlcInterestTxt: Text;

        Terms: Boolean;
        TermsTxt: Text;


        JsonDocumentToken: JsonToken;
        JsonDocumentArrays: JsonArray;
        JsonDocument: JsonObject;


        NextofKin: Record "Next of Kin.";
        FName: Text;
        KRAPIN: Text;
        SName: Text;
        ONames: Text;
        Email: Text;
        PhoneNo: Text;
        NationalID: Text;
        IDType: Text;
        IDNumber: Text;
        PassportExpiryDate: Date;
        DateOfBirth: Date;
        Gender: Text;
        MaritalStatus: Text;
        PostCode: Text;
        POBox: Text;
        PhysicalAddress: Text;
        NearestLandMark: Text;
        CountryCode: Text;
        CountryName: Text;
        MobilePhoneNumber: Text;
        PersonalEmail: Text;
        EmployerName: Text;
        EmploymentStatus: Text;
        PortalUploads: Record "Portal Application Documents";
        TermsOfEmployment: Text;
        RecruitedByType: Text;
        RecruitedByName: Text;
        RecruitedByID: Text;
        RecruitedByPhone: Text;
        BankCode: Text;
        BankName: Text;
        BankBranchCode: Text;
        BankBranchName: Text;
        BankAccountNo: Text;
        BankAccountName: Text;
        RegPath: Text;
        SwiftCode: Text;
        Found: Boolean;
        AboutUs: Text;
    begin
        if not RequestJson.ReadFrom(Request) then
            Error('Invalid JSON Input');

        //Error('TEST 2');
        // Extract Personal Data from JSON
        FName := SelectJsonToken(RequestJson, '$.FirstName').AsValue.AsText;
        SName := SelectJsonToken(RequestJson, '$.Surname').AsValue.AsText;
        ONames := SelectJsonToken(RequestJson, '$.OtherNames').AsValue.AsText;
        Email := SelectJsonToken(RequestJson, '$.Email').AsValue.AsText;
        PhoneNo := SelectJsonToken(RequestJson, '$.PhoneNo').AsValue.AsText;

        RegPath := SelectJsonToken(RequestJson, '$.RegistrationForm').AsValue.AsText;
        KRAPIN := SelectJsonToken(RequestJson, '$.KraPin').AsValue.AsText;
        // Additional fields
        IDType := SelectJsonToken(RequestJson, '$.IDType').AsValue.AsText;

        // Error('TEST 5');
        IDNumber := SelectJsonToken(RequestJson, '$.IDNumber').AsValue.AsText;
        if SelectJsonToken(RequestJson, '$.PassportExpiryDate').AsValue.AsText <> '' then
            Evaluate(PassportExpiryDate, SelectJsonToken(RequestJson, '$.PassportExpiryDate').AsValue.AsText);
        if SelectJsonToken(RequestJson, '$.DateOfBirth').AsValue.AsText() <> '' then
            Evaluate(DateOfBirth, SelectJsonToken(RequestJson, '$.DateOfBirth').AsValue.AsText());
        //Error('TEST 3');

        Gender := SelectJsonToken(RequestJson, '$.Gender').AsValue.AsText;
        MaritalStatus := SelectJsonToken(RequestJson, '$.MaritalStatus').AsValue.AsText;
        PostCode := SelectJsonToken(RequestJson, '$.PostCode').AsValue.AsText;
        POBox := SelectJsonToken(RequestJson, '$.POBox').AsValue.AsText;
        PhysicalAddress := SelectJsonToken(RequestJson, '$.PhysicalAddress').AsValue.AsText;
        NearestLandMark := SelectJsonToken(RequestJson, '$.NearestLandMark').AsValue.AsText;
        CountryCode := SelectJsonToken(RequestJson, '$.CountryCode').AsValue.AsText;
        CountryName := SelectJsonToken(RequestJson, '$.CountryName').AsValue.AsText;


        SpouseName := SelectJsonToken(RequestJson, '$.SpouseName').AsValue.AsText;
        SpouseIdNumber := SelectJsonToken(RequestJson, '$.SpouseIdNumber').AsValue.AsText;
        SpouseMobilePhoneNumber := SelectJsonToken(RequestJson, '$.SpouseMobilePhoneNumber').AsValue.AsText;




        AboutUs := SelectJsonToken(RequestJson, '$.AboutUs').AsValue.AsText;
        MobilePhoneNumber := SelectJsonToken(RequestJson, '$.MobilePhoneNumber').AsValue.AsText;
        PersonalEmail := SelectJsonToken(RequestJson, '$.Email').AsValue.AsText;
        EmployerName := SelectJsonToken(RequestJson, '$.EmployerName').AsValue.AsText;
        EmploymentStatus := SelectJsonToken(RequestJson, '$.EmploymentStatus').AsValue.AsText;
        TermsOfEmployment := SelectJsonToken(RequestJson, '$.TermsOfEmployment').AsValue.AsText;
        RecruitedByID := SelectJsonToken(RequestJson, '$.RecruitedByID').AsValue.AsText;
        RecruitedByPhone := SelectJsonToken(RequestJson, '$.RecruitedByPhone').AsValue.AsText;
        RecruitedByName := SelectJsonToken(RequestJson, '$.RecruitedByName').AsValue.AsText;
        RefereeContact := SelectJsonToken(RequestJson, '$.RefereeContact').AsValue.AsText;

        BankCode := SelectJsonToken(RequestJson, '$.BankCode').AsValue.AsText;
        BankName := SelectJsonToken(RequestJson, '$.BankName').AsValue.AsText;
        BankBranchCode := SelectJsonToken(RequestJson, '$.BankBranchCode').AsValue.AsText;
        BankBranchName := SelectJsonToken(RequestJson, '$.BankBranchName').AsValue.AsText;
        BankAccountNo := SelectJsonToken(RequestJson, '$.BankAccountNo').AsValue.AsText;
        BankAccountName := SelectJsonToken(RequestJson, '$.BankAccountName').AsValue.AsText;
        SwiftCode := SelectJsonToken(RequestJson, '$.SwiftCode').AsValue.AsText;
        PlcInterestTxt := SelectJsonToken(RequestJson, '$.PlcInterest').AsValue.AsText;

        TermsTxt := SelectJsonToken(RequestJson, '$.Terms').AsValue.AsText;

        if PlcInterestTxt <> '' then begin
            EVALUATE(PlcInterest, PlcInterestTxt);
        end;
        if TermsTxt <> '' then begin
            EVALUATE(Terms, TermsTxt);
        end;

        NewApplication := true;

        if PersonalEmail = '' then
            error('Email MUST have a value');

        PortalReg.Reset();
        PortalReg.setrange("E-Mail", PersonalEmail);
        //PortalReg.setrange("No.", ApplicationNo);
        if PortalReg.FindFirst then begin
            NewApplication := false;

        end;

        if NewApplication then
            PortalReg.init;

        Found := true;
        PortalReg."First Name" := FName;
        PortalReg."Application Date" := TOday;
        PortalReg.Surname := SName;
        PortalReg."Middle Name" := ONames;
        PortalReg.Validate(Surname);
        PortalReg."Registration Form" := RegPath;
        //PortalReg."Hide Application" := false;
        PortalReg.status := PortalReg.status::Open;
        PortalReg."KRA PIN" := KRAPIN;
        PortalReg.validate("First Name");
        PortalReg.Type := PortalReg.Type::Member;
        PortalReg."Account Category" := PortalReg."Account Category"::Individual;
        PortalReg."Terms Accepted" := Terms;
        PortalReg."ID Type" := PortalReg."ID tYPE"::"National ID";
        if IDType = 'Passport' THEN
            PortalReg."ID Type" := PortalReg."ID tYPE"::Passport;

        PortalReg."ID No." := IDNumber;
        PortalReg."Portal Application" := true;
        PortalReg."Date of Birth" := DateOfBirth;
        if Gender = 'Male' then
            PortalReg.Gender := PortalReg.Gender::Male;
        if Gender = 'Female' then
            PortalReg.Gender := PortalReg.Gender::Female;

        if MaritalStatus = 'Married' then
            PortalReg."Marital Status" := PortalReg."Marital Status"::Married;
        if MaritalStatus = 'Divorced' then
            PortalReg."Marital Status" := PortalReg."Marital Status"::Divorced;
        if MaritalStatus = 'Others' then
            PortalReg."Marital Status" := PortalReg."Marital Status"::Others;
        if MaritalStatus = 'Single' then
            PortalReg."Marital Status" := PortalReg."Marital Status"::Single;
        if MaritalStatus = 'Widowed' then
            PortalReg."Marital Status" := PortalReg."Marital Status"::Widowed;

        PortalReg."Post Code" := PostCode;
        PortalReg.address := POBox;
        PortalReg."Address 2" := PhysicalAddress;
        PortalReg."Country/Region Code" := CountryCode;
        //PortalReg."Country Name" := CountryName;
        PortalReg."Mobile Phone No." := MobilePhoneNumber;
        PortalReg."E-Mail" := PersonalEmail;
        PortalReg."Employer Name" := EmployerName;

        if TermsOfEmployment = 'Permanent' then
            PortalReg."Terms of Employment" := PortalReg."Terms of Employment"::Permanent;
        if TermsOfEmployment = 'Casual' then
            PortalReg."Terms of Employment" := PortalReg."Terms of Employment"::Casual;
        if TermsOfEmployment = 'Contract' then
            PortalReg."Terms of Employment" := PortalReg."Terms of Employment"::Contract;

        //if RecruitedByType = 'Website' then
        //  PortalReg."recruited By type" := PortalReg."recruited By type"::Website;
        if RecruitedByType = 'Member' then
            PortalReg."recruited By type" := PortalReg."recruited By type"::Member;

        //PortalReg."About Us" := AboutUs;
        //PortalReg."Recruited By ID" := RecruitedById;
        PortalReg."Recruited By Name" := RecruitedByName + ' - ' + RefereeContact;
        //PortalReg."Recruited By Phone" := RecruitedByPhone;
        PortalReg."Bank Code" := BankCode;
        PortalReg."Bank Name" := BankName;
        PortalReg."Branch Code" := BankBranchCode;
        PortalReg."Branch Name" := BankBranchName;
        PortalReg."Bank Account No." := BankAccountNo;
        PortalReg."Bank Account Name" := BankAccountName;
        PortalReg."Swift Code" := SwiftCode;
        PortalReg."Account Category" := PortalReg."Account Category"::Individual;

        if NewApplication then
            PortalReg.insert(True)
        else
            PortalReg.Modify();

        ApplicationNo := PortalReg."No.";

        //Munya
        if not PortalReg.insert() then
            PortalReg.Modify();

        //Munya
        commit;
        JsonNOKToken := SelectJsonToken(RequestJson, '$.NextOfKin');

        //RequestJson.Get('NextOfKin', JsonNOKToken);
        JsonNOKArrays := JsonNOKToken.AsArray();



        JsonDocumentToken := SelectJsonToken(RequestJson, '$.DocumentUploads');
        //RequestJson.Get('NextOfKin', JsonDocumentToken);
        JsonDocumentArrays := JsonDocumentToken.AsArray();



        //Clear Next of Kin
        NextOfKin.Reset();
        NextOfKin.SetRange("No.", ApplicationNo);
        if NextOfKin.findfirst then
            NextOfKin.deleteall;

        //Clear Nominee


        //Clear Uploaded Documents-
        PortalUploads.reset;
        PortalUploads.setrange("No.", ApplicationNo);
        if PortalUploads.findfirst then
            PortalUploads.deleteall;

        foreach JsonTokenLine in JsonNOKArrays do begin
            JsonNOK := JsonTokenLine.AsObject();

            KinName := SelectJsonToken(JsonNOK, '$.name').AsValue.AsTExt();
            KinRelationship := SelectJsonToken(JsonNOK, '$.relationship').AsValue.AsTExt();
            KinContactInfo := SelectJsonToken(JsonNOK, '$.contact_info').AsValue.AsTExt();

            kin_id_number := SelectJsonToken(JsonNOK, '$.id_number').AsValue.AsTExt();
            Kin_allocation := SelectJsonToken(JsonNOK, '$.allocation').AsValue.AsTExt();

            //Insert Next of Kin Details
            NextOfKin.init;
            NextOfKin."No." := ApplicationNo;
            NextOfKin.Name := KinName;
            NextOfKin."ID NO." := kin_id_number;
            NextOfKin."MObile Phone No." := KinContactInfo;
            NextOfKin.GuardianName := SelectJsonToken(JsonNOK, '$.guardian').AsValue.AsTExt();
            NextOfKin.NokType := SelectJsonToken(JsonNOK, '$.kin_age_group').AsValue.AsTExt();
            //NextOfKin.Email := NOKEmail;
            NextOfKin.Relationship := KinRelationship;
            if Kin_allocation <> '' then
                if Evaluate(NextOfKin."%Allocation", Kin_allocation) then;

            NextOfKin.insert(True);



        end;



        foreach JsonTokenLine in JsonDocumentArrays do begin
            JsonDocument := JsonTokenLine.AsObject();

            fileID := SelectJsonToken(JsonDocument, '$.fileID').AsValue.AsTExt();
            fieldName := SelectJsonToken(JsonDocument, '$.fieldName').AsValue.AsTExt();
            fileName := SelectJsonToken(JsonDocument, '$.fileName').AsValue.AsTExt();

            fileUrl := SelectJsonToken(JsonDocument, '$.fileUrl').AsValue.AsTExt();
            blobName := SelectJsonToken(JsonDocument, '$.blobName').AsValue.AsTExt();


            PortalUploads.Init;
            PortalUploads.GUID := CreateGuid();
            PortalUploads."No." := ApplicationNo;
            PortalUploads."Document ID" := fieldName;
            PortalUploads."Document Description" := fileName;
            PortalUploads.Date := Today;
            PortalUploads.Time := Time;
            PortalUploads."Member Name" := Members.Name;
            PortalUploads.Type := fileID;
            PortalUploads."Blob Url" := fileUrl;
            PortalUploads."blob Name" := blobName;
            PortalUploads.Status := PortalUploads.Status::Pending;
            PortalUploads.Insert(true);
            //Munya

        end;


        Status := 'SUCCESS';
        ResponseTitle := 'Data Submission Successful';
        ResponseMessage := 'Personal Data Submission Successful';

        // Prepare the JSON response
        JsObject_1.Add('title', ResponseTitle);
        JsObject_1.Add('message', ResponseMessage);

        JsObject_2.Add('action', 'DATA_SUBMISSION');
        JsObject_2.Add('status', Status);
        JsObject_2.Add('payload', JsObject_1);

        JsonResult.Add('response', JsObject_2);
        JsonResult.WriteTo(Response);
    end;


    procedure OldSubmitPersonalData(Request: Text; var Response: Text)
    var
        Status: Code[50];
        ResponseTitle: Text;
        ResponseMessage: Text;
        Members: Record Customer;
        KinDataJsonArray: JsonArray;
        KinDataJsonObject: JsonObject;
        KinName: Text;
        KinRelationship: Text;
        KinContactInfo: Text;
        JsonResult: JsonObject;
        JsObject_1: JsonObject;
        JsObject_2: JsonObject;
        Email: Text;
        PhoneNo: Text;
        NationalID: Text;
        RequestJson: JsonObject;
        JsonNOKToken: JsonToken;
        JsonNOKArrays: JsonArray;
        JsonTokenLine: JsonToken;
        JsonNOK: JsonObject;
        FName: Text;
        SName: Text;
        ONames: Text;

        IDType: Text;
        IDNumber: Text;
        PassportExpiryDate: Date;
        DateOfBirth: Date;
        Gender: Text;
        MaritalStatus: Text;
        PostCode: Text;
        POBox: Text;
        PhysicalAddress: Text;
        NearestLandMark: Text;
        CountryCode: Text;
        CountryName: Text;
        MobilePhoneNumber: Text;
        PersonalEmail: Text;
        EmployerName: Text;
        EmploymentStatus: Text;
        TermsOfEmployment: Text;
        RecruitedByType: Text;
        RecruitedByReference: Text;
        BankCode: Text;
        BankName: Text;
        BankBranchCode: Text;
        BankBranchName: Text;
        BankAccountNo: Text;
        BankAccountName: Text;
        SwiftCode: Text;
    begin
        if not RequestJson.ReadFrom(Request) then
            Error('Invalid JSON Input');


        Status := 'FAILED';
        ResponseTitle := 'PERSONAL DATA SUBMISSION';
        ResponseMessage := 'Personal Data Submission Failed';

        // Extract Personal Data from JSON
        FName := SelectJsonToken(RequestJson, '$.FirstName').AsValue.AsText;
        SName := SelectJsonToken(RequestJson, '$.Surname').AsValue.AsText;
        ONames := SelectJsonToken(RequestJson, '$.OtherNames').AsValue.AsText;
        Email := SelectJsonToken(RequestJson, '$.Email').AsValue.AsText;
        PhoneNo := SelectJsonToken(RequestJson, '$.PhoneNo').AsValue.AsText;
        NationalID := SelectJsonToken(RequestJson, '$.NationalID').AsValue.AsText;



        RequestJson.Get('kins', JsonNOKToken);
        JsonNOKArrays := JsonNOKToken.AsArray();

        foreach JsonTokenLine in JsonNOKArrays do begin
            JsonNOK := JsonTokenLine.AsObject();


            KinName := SelectJsonToken(JsonNOK, '$.KinName').AsValue.AsTExt();
            KinRelationship := SelectJsonToken(JsonNOK, '$.KinRelationship').AsValue.AsTExt();
            KinContactInfo := SelectJsonToken(JsonNOK, '$.KinContactInfo').AsValue.AsTExt();

        end;





        // Process and store the personal data
        // Implement your logic for handling personal data here

        Status := 'SUCCESS';
        ResponseTitle := 'Data Submission Successful';
        ResponseMessage := 'Personal Data Submission Successful';


        // Prepare the JSON response
        JsObject_1.Add('title', ResponseTitle);
        JsObject_1.Add('message', ResponseMessage);

        JsObject_2.Add('action', 'DATA_SUBMISSION');
        JsObject_2.Add('status', Status);
        JsObject_2.Add('payload', JsObject_1);

        JsonResult.Add('response', JsObject_2);
        JsonResult.WriteTo(Response);
    end;


    procedure SubmitBase64Data(Request: Text) Response: Text;
    var
        Status: Code[50];
        ResponseTitle: Text;
        ResponseMessage: Text;
        MemberImages: Record "Member Images";
        PicBase64: Text;
        FileType: Text;
        JsonResult: JsonObject;
        JsObject_1: JsonObject;
        JsObject_2: JsonObject;
        RequestJson: JsonObject;
        Email: Text;
        PortalReg: Record "Member Registration";
        PortalUploads: Record "Portal Application Documents";
        PortalInit: Record "Portal Registration Attempt";
        DocOutStream: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
        CustomTempBlob: Record CustomTempBlob;

        Ext: text;
    begin
        if not RequestJson.ReadFrom(Request) then
            Error('Invalid JSON Input');

        // Extract File Data from JSON
        FileType := SelectJsonToken(RequestJson, '$.FileType').AsValue.AsText;
        PicBase64 := SelectJsonToken(RequestJson, '$.FileContent').AsValue.AsText;
        Email := SelectJsonToken(RequestJson, '$.Email').AsValue.AsText;
        Ext := SelectJsonToken(RequestJson, '$.Ext').AsValue.AsText;


        PortalReg.reset;
        PortalReg.setrange("E-mail", Email);
        if PortalReg.findfirst then begin

            if FileType = 'Document' then begin

                PortalUploads.Init;
                PortalUploads.GUID := Createguid;
                PortalUploads."No." := PortalReg."No.";
                //PortalUploads."Document ID" := format(DocumentID);
                PortalUploads."Document Description" := FileType;


                PortalUploads.Extension := Ext;

                PortalUploads.calcfields(Document);
                //Create empty OutStream for our logo blob
                PortalUploads.Document.CreateOutStream(DocOutStream);

                //Directly convert the incoming base64 string into the OutStream
                Base64Convert.FromBase64(PicBase64, DocOutStream);
                PortalUploads.Insert(true);

            end
            else if FileType = 'Picture' then begin

                PortalReg.calcfields(Picture);
                //Create empty OutStream for our logo blob
                PortalReg.Picture.CreateOutStream(DocOutStream);

                //Directly convert the incoming base64 string into the OutStream
                Base64Convert.FromBase64(PicBase64, DocOutStream);
                PortalReg.modify;
            end
            else if FileType = 'Signature' then begin

                PortalReg.calcfields(Signature);
                //Create empty OutStream for our logo blob
                PortalReg.Signature.CreateOutStream(DocOutStream);

                //Directly convert the incoming base64 string into the OutStream
                Base64Convert.FromBase64(PicBase64, DocOutStream);
                PortalReg.modify;
            end;

        end;


        Status := 'SUCCESS';
        ResponseTitle := 'File Submission Successful';
        ResponseMessage := 'Document Submitted Successfully';



        // Prepare the JSON response
        JsObject_1.Add('title', ResponseTitle);
        JsObject_1.Add('message', ResponseMessage);

        JsObject_2.Add('action', 'FILE_SUBMISSION');
        JsObject_2.Add('status', Status);
        JsObject_2.Add('payload', JsObject_1);

        JsonResult.Add('response', JsObject_2);
        JsonResult.WriteTo(Response);
    end;

    Procedure SendEmailNotification(MemberNo: code[30]; Password: text[250])
    var
        Members: Record Customer;
        SAC: Codeunit "Sacco Activities";
        Subject: Label 'OTP';
        Salutation: Text;
        Body: Text;
    begin
        if Members.get(MemberNo) then begin


            //Members."e-mail" := 'stokeotp@calwide.co.ke';
            if Members."E-Mail" <> '' then begin
                Salutation := 'Dear ' + ' ' + Members.Name;
                Body := 'Your Sacco Portal Password is ' + Password + '. Your Username is ' + MemberNo;
                SAC.SendEmail(Members."E-Mail", '', '', Subject, Salutation, Body);
            end;


        end;
    end;




    local procedure GetClientData(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        JsonClient: JsonObject;
        JsonTicket: JsonObject;
        JsonTicketArray: JsonArray;
        JsonLoan: JsonObject;
        JsonLoanArray: JsonArray;
        JsonSavings: JsonObject;
        JsonSavingsArray: JsonArray;
        JsonTransaction: JsonObject;
        JsonTransactionArray: JsonArray;
        JsonATMTransaction: JsonObject;
        JsonATMTransactionArray: JsonArray;
        JsonCheque: JsonObject;
        JsonChequeArray: JsonArray;
        Identifier: Text;
        Clients: Record Members;
        //Tickets: Record "Support Ticket";
        Loans: Record Loans;
        MobileLoans: Record "Sky Mobile Loans";
        SavingsAccounts: Record "Savings Accounts";
        CashierTrans: Record "Teller Transaction";
        MobileBuffer: Record "Mobile Withdrawal Buffer";
        ATMBuffer: Record "Coop ATM Transaction";
        SkyTrans: Record "Sky Transactions.";
        MobileNo: Code[20];
        Sky: Codeunit "Sky MBanking";
        SLedger: Record "Savings Ledger Entry";
        CLedger: Record "Credit Ledger Entry";
        k: integer;
    begin
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        MobileNo := validatePhoneNo(Identifier);
        if MobileNo <> '' then begin
            Clients.Reset();
            Clients.SetRange("Mobile Phone No.", MobileNo);
            if Clients.FindFirst() then begin
                // Populate basic client profile
                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                JsonClient.Add('no', Clients."No.");
                JsonClient.Add('name', Clients.Name);
                JsonClient.Add('client_code', Clients."No.");
                JsonClient.Add('email', Clients."E-mail");
                JsonClient.Add('phone_numbers', Clients."Mobile Phone No.");
                JsonClient.Add('location', Clients."Address 2");
                JsonClient.Add('gender', Format(Clients.Gender));
                JsonClient.Add('address', Clients.Address);
                JsonClient.Add('max_credit_limit', 0);
                JsonClient.Add('mobile_loan_limit', 0);
                DataJson.Add('client', JsonClient);


                // Populate savings accounts and transactions
                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Member No.", Clients."No.");
                if SavingsAccounts.FindSet() then begin
                    repeat
                        Clear(JsonSavings);
                        SavingsAccounts.CalcFields("Balance (LCY)");
                        JsonSavings.Add('account_number', SavingsAccounts."No.");
                        JsonSavings.Add('account_name', SavingsAccounts."Name");
                        JsonSavings.Add('account_type', SavingsAccounts."Product Name");
                        JsonSavings.Add('book_balance', sky.GetAccountBalance(SavingsAccounts."No."));
                        JsonSavings.Add('available_balance', SavingsAccounts."Balance (LCY)");

                        SLedger.Reset();
                        SLedger.SetCurrentKey("Posting Date");
                        SLedger.Ascending(false);
                        SLedger.SetRange("Account No.", SavingsAccounts."No.");
                        SLedger.SetRange("Reversed", false);
                        if SLedger.FindSet() then begin
                            Clear(JsonTransactionArray);
                            k := 0;
                            repeat
                                k += 1;

                                Clear(JsonTransaction);
                                JsonTransaction.Add('document_no', SLedger."Document No.");
                                JsonTransaction.Add('posting_date', SLedger."Posting Date");
                                JsonTransaction.Add('amount', SLedger.Amount);
                                JsonTransaction.Add('description', SLedger.Description);
                                JsonTransactionArray.Add(JsonTransaction);
                            until (SLedger.Next() = 0) or (k >= 10);
                        end;
                        JsonSavings.Add('last_10_transactions', JsonTransactionArray);
                        JsonSavingsArray.Add(JsonSavings);
                    until SavingsAccounts.Next() = 0;
                end;
                DataJson.Add('savings_accounts', JsonSavingsArray);

                // Populate active loans and transactions
                Loans.Reset();
                Loans.SetRange("Member No.", Clients."No.");
                Loans.Setfilter("Total Outstanding Balance", '>0');
                if Loans.FindSet() then begin
                    repeat
                        Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Total Outstanding Balance");
                        Clear(JsonLoan);
                        JsonLoan.Add('loan_no', Loans."Loan No.");
                        JsonLoan.Add('type', Loans."Loan product Type Name");
                        JsonLoan.Add('date_issued', Loans."Disbursement Date");
                        JsonLoan.Add('approved_amount', Loans."Approved Amount");
                        JsonLoan.Add('interest_balance', Loans."Outstanding Interest");
                        JsonLoan.Add('principla_balance', Loans."Outstanding Principal");
                        JsonLoan.Add('total_balance', Loans."Total Outstanding Balance");


                        CLedger.Reset();
                        CLedger.SetCurrentKey("Posting Date");
                        CLedger.Ascending(false);
                        CLedger.SetRange("Account No.", Loans."Member No.");
                        CLedger.SetRange("Loan No.", Loans."Loan No.");
                        CLedger.SetRange("Reversed", false);
                        if CLedger.FindSet() then begin
                            Clear(JsonTransactionArray);
                            k := 0;
                            repeat
                                k += 1;

                                Clear(JsonTransaction);
                                JsonTransaction.Add('document_no', CLedger."Document No.");
                                JsonTransaction.Add('posting_date', CLedger."Posting Date");
                                JsonTransaction.Add('amount', CLedger.Amount);
                                JsonTransaction.Add('description', CLedger."Description");
                                JsonTransaction.Add('transaction_type', format(CLedger."Transaction type"));
                                JsonTransactionArray.Add(JsonTransaction);
                            until (CLedger.Next() = 0) or (k >= 10);
                        end;

                        JsonSavings.Add('last_10_transactions', JsonTransactionArray);
                        JsonLoanArray.Add(JsonLoan);
                    until Loans.Next() = 0;
                end;
                DataJson.Add('active_loans', JsonLoanArray);

                // Add more sections as needed for ATM transactions, pending mobile transactions, and uncleared cheques...

                ResponseJson.Add('data', DataJson);
            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Client does not exist');
        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Invalid Identifier');
    end;

    local procedure ValidatePhoneNo(PhoneNumber: Text): Text
    var
        ValidatedPhoneNumber: Text;
        i: integer;
    begin
        // Remove non-numeric characters from the phone number
        ValidatedPhoneNumber := PhoneNumber;

        // Ensure we only take the last 9 digits
        if StrLen(ValidatedPhoneNumber) >= 9 then
            ValidatedPhoneNumber := '+254' + CopyStr(PhoneNumber, StrLen(PhoneNumber) - 8, 9)
        else
            Error('Invalid phone number format');

        exit(ValidatedPhoneNumber);
    end;



}
