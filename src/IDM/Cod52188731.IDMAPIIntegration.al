codeunit 50394 "IDM API Integration"
{
    Subtype = Normal;

    var
        IDMSetupNotConfiguredErr: Label 'IDM Setup is not configured. Please enter the API Key, Client ID, and Base URL in IDM Setup.';
        IDMDisabledErr: Label 'IDM Integration is disabled. Please enable it in IDM Setup.';
        RequestIDPrefixTok: Label 'IDM', Locked = true;

    // ─── Public Verification Procedures ────────────────────────────────────────

    /// <summary>Verify a Kenya National ID number.</summary>
    procedure VerifyNationalID(IDNumber: Text; MemberNo: Code[20]; RequestID: Code[20]): Integer
    var
        DataJson: JsonObject;
    begin
        DataJson.Add('id_number', IDNumber);
        exit(SendVerification("IDM Verification Type"::"National ID", IDNumber, '', DataJson, MemberNo, RequestID));
    end;

    /// <summary>Verify an Alien / Foreign Resident ID.</summary>
    procedure VerifyAlienID(AlienID: Text; MemberNo: Code[20]; RequestID: Code[20]): Integer
    var
        DataJson: JsonObject;
    begin
        DataJson.Add('alien_id', AlienID);
        exit(SendVerification("IDM Verification Type"::"Alien ID", AlienID, '', DataJson, MemberNo, RequestID));
    end;

    /// <summary>Verify a KRA PIN and retrieve tax registration details.</summary>
    procedure VerifyKRAPin(KRAPin: Text; MemberNo: Code[20]; RequestID: Code[20]): Integer
    var
        DataJson: JsonObject;
    begin
        DataJson.Add('kra_pin', KRAPin);
        exit(SendVerification("IDM Verification Type"::"KRA PIN", KRAPin, '', DataJson, MemberNo, RequestID));
    end;

    /// <summary>Verify a driving licence.</summary>
    procedure VerifyDrivingLicence(LicenceNo: Text; MemberNo: Code[20]; RequestID: Code[20]): Integer
    var
        DataJson: JsonObject;
    begin
        DataJson.Add('licence_number', LicenceNo);
        exit(SendVerification("IDM Verification Type"::"Driving Licence", LicenceNo, '', DataJson, MemberNo, RequestID));
    end;

    /// <summary>Verify that a phone number is registered to a specific National ID holder.</summary>
    procedure VerifyPhone(IDNumber: Text; PhoneNumber: Text; MemberNo: Code[20]; RequestID: Code[20]): Integer
    var
        DataJson: JsonObject;
        FormattedPhone: Text;
    begin
        FormattedPhone := FormatPhoneNumber(PhoneNumber);
        DataJson.Add('id_number', IDNumber);
        DataJson.Add('phone_number', FormattedPhone);
        exit(SendVerification("IDM Verification Type"::Phone, IDNumber, FormattedPhone, DataJson, MemberNo, RequestID));
    end;

    /// <summary>Verify vehicle registration details.</summary>
    procedure VerifyVehicle(RegNo: Text; MemberNo: Code[20]; RequestID: Code[20]): Integer
    var
        DataJson: JsonObject;
    begin
        DataJson.Add('registration_number', RegNo);
        exit(SendVerification("IDM Verification Type"::Vehicle, RegNo, '', DataJson, MemberNo, RequestID));
    end;

    /// <summary>Verify business registration and Ultimate Beneficial Owner (UBO) details.</summary>
    procedure VerifyBusinessUBO(RegNo: Text; MemberNo: Code[20]; RequestID: Code[20]): Integer
    var
        DataJson: JsonObject;
    begin
        DataJson.Add('registration_number', RegNo);
        exit(SendVerification("IDM Verification Type"::"Business UBO", RegNo, '', DataJson, MemberNo, RequestID));
    end;

    /// <summary>Verify bank account details.</summary>
    procedure VerifyBankAccount(AccountNo: Text; BankID: Text; MemberNo: Code[20]; RequestID: Code[20]): Integer
    var
        DataJson: JsonObject;
    begin
        DataJson.Add('account_number', AccountNo);
        DataJson.Add('bank_id', BankID);
        exit(SendVerification("IDM Verification Type"::"Bank Account", AccountNo, BankID, DataJson, MemberNo, RequestID));
    end;

    /// <summary>Retrieve a credit report for an individual using their National ID.</summary>
    procedure GetCreditReport(NationalID: Text; MemberNo: Code[20]; RequestID: Code[20]): Integer
    var
        DataJson: JsonObject;
    begin
        DataJson.Add('national_id', NationalID);
        DataJson.Add('include_pdf', true);
        exit(SendVerification("IDM Verification Type"::"Credit Report", NationalID, '', DataJson, MemberNo, RequestID));
    end;

    /// <summary>Returns true if a successful verification of the given type exists for the member or identifier.</summary>
    procedure IsVerified(VerificationType: Enum "IDM Verification Type"; Identifier: Text; MemberNo: Code[20]): Boolean
    var
        IDMLog: Record "IDM Verification Log";
    begin
        if MemberNo <> '' then begin
            IDMLog.SetRange("Member No.", MemberNo);
            IDMLog.SetRange("Verification Type", VerificationType);
            IDMLog.SetRange(Status, IDMLog.Status::Success);
            if not IDMLog.IsEmpty() then
                exit(true);
            IDMLog.Reset();
        end;
        IDMLog.SetRange("Verification Type", VerificationType);
        IDMLog.SetRange(Identifier, CopyStr(Identifier, 1, 100));
        IDMLog.SetRange(Status, IDMLog.Status::Success);
        exit(not IDMLog.IsEmpty());
    end;

    /// <summary>Opens the IDM Verification Log filtered to the given member.</summary>
    procedure OpenVerificationLog(MemberNo: Code[20])
    var
        IDMLog: Record "IDM Verification Log";
        IDMLogListPage: Page "IDM Verification Log List";
    begin
        if MemberNo <> '' then
            IDMLog.SetRange("Member No.", MemberNo);
        IDMLogListPage.SetTableView(IDMLog);
        IDMLogListPage.Run();
    end;

    // ─── Core HTTP Procedure ────────────────────────────────────────────────────

    local procedure SendVerification(
        VerificationType: Enum "IDM Verification Type";
        Identifier: Text;
        SecondaryIdentifier: Text;
        DataJson: JsonObject;
        MemberNo: Code[20];
        RequestID: Code[20]): Integer
    var
        IDMSetup: Record "IDM Setup";
        IDMLog: Record "IDM Verification Log";
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        RequestHeaders: HttpHeaders;
        RequestPayload: JsonObject;
        RequestJson: Text;
        ResponseText: Text;
        ResponseJsonObj: JsonObject;
        RequestIDValue: Text;
        IsSuccessful: Boolean;
        ApiStatus: Text;
        ApiMessage: Text;
        JsonToken: JsonToken;
        DataToken: JsonToken;
    begin
        // Validate setup
        IDMSetup := IDMSetup.GetSetup();
        if not IDMSetup.Enabled then
            Error(IDMDisabledErr);
        if (IDMSetup."API Key" = '') or (IDMSetup."Client ID" = '') or (IDMSetup."Base URL" = '') then
            Error(IDMSetupNotConfiguredErr);

        // Create pending log entry to get an Entry No. for the Request ID
        IDMLog.Init();
        IDMLog."Verification Type" := VerificationType;
        IDMLog.Identifier := CopyStr(Identifier, 1, 100);
        IDMLog."Secondary Identifier" := CopyStr(SecondaryIdentifier, 1, 100);
        IDMLog."API Request ID" := RequestID;
        IDMLog."Member No." := MemberNo;
        IDMLog."Requested By" := CopyStr(UserId(), 1, 50);
        IDMLog."Request Date Time" := CurrentDateTime();
        IDMLog.Status := IDMLog.Status::Pending;
        IDMLog.Insert(true);

        // Build idempotent Request ID using the log Entry No.
        RequestIDValue := StrSubstNo('%1-%2', RequestIDPrefixTok, Format(IDMLog."Entry No."));
        if IDMLog."API Request ID" = '' then
            IDMLog."API Request ID" := CopyStr(RequestIDValue, 1, 100);
        IDMLog.Modify(true);

        // Build the JSON request payload
        Clear(RequestPayload);
        RequestPayload.Add('client_id', IDMSetup."Client ID");
        RequestPayload.Add('verification_type', GetVerificationTypeCode(VerificationType));
        RequestPayload.Add('request_id', RequestIDValue);
        RequestPayload.Add('consent', true);
        RequestPayload.Add('data', DataJson);
        RequestPayload.WriteTo(RequestJson);

        IDMLog."Request JSON" := CopyStr(RequestJson, 1, 2048);
        IDMLog.Modify(true);

        // Prepare HTTP request
        Content.WriteFrom(RequestJson);
        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');

        HttpRequestMessage.Method := 'POST';
        HttpRequestMessage.SetRequestUri(IDMSetup."Base URL" + '/verify');
        HttpRequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Add('X-API-Key', IDMSetup."API Key");
        HttpRequestMessage.Content := Content;

        // Send the request
        IsSuccessful := HttpClient.Send(HttpRequestMessage, HttpResponseMessage);

        IDMLog."Response Date Time" := CurrentDateTime();
        IDMLog."HTTP Status Code" := HttpResponseMessage.HttpStatusCode();

        HttpResponseMessage.Content().ReadAs(ResponseText);
        IDMLog."Response JSON" := CopyStr(ResponseText, 1, 2048);

        if IsSuccessful then begin

            if ResponseJsonObj.ReadFrom(ResponseText) then begin
                // Parse common response fields
                if ResponseJsonObj.Get('status', JsonToken) then
                    ApiStatus := JsonToken.AsValue().AsText();
                if ResponseJsonObj.Get('message', JsonToken) then
                    ApiMessage := JsonToken.AsValue().AsText();

                IDMLog."API Response Status" := CopyStr(ApiStatus, 1, 50);

                case ApiStatus of
                    'success':
                        begin
                            IDMLog.Status := IDMLog.Status::Success;
                            if ResponseJsonObj.Get('data', DataToken) then
                                ParseResponseData(IDMLog, VerificationType, DataToken.AsObject());
                        end;
                    'not_found':
                        begin
                            IDMLog.Status := IDMLog.Status::"Not Found";
                            IDMLog."Error Message" := CopyStr(ApiMessage, 1, 500);
                        end;
                    else begin
                        IDMLog.Status := IDMLog.Status::Failed;
                        IDMLog."Error Message" := CopyStr(ApiMessage, 1, 500);
                        if ResponseJsonObj.Get('error_code', JsonToken) then
                            IDMLog."Error Code" := CopyStr(JsonToken.AsValue().AsText(), 1, 100);
                    end;
                end;
            end else begin
                IDMLog.Status := IDMLog.Status::Failed;
                IDMLog."Error Message" := CopyStr('Invalid JSON response received from API.', 1, 500);
            end;
        end else begin
            IDMLog.Status := IDMLog.Status::Failed;
            IDMLog."Error Message" := CopyStr('HTTP request failed. Check network connectivity and Base URL.', 1, 500);
        end;

        IDMLog.Modify(true);
        exit(IDMLog."Entry No.");
    end;

    // ─── Response Parsing ───────────────────────────────────────────────────────

    local procedure ParseResponseData(var IDMLog: Record "IDM Verification Log"; VerificationType: Enum "IDM Verification Type"; DataObj: JsonObject)
    var
        JsonToken: JsonToken;
        SummaryToken: JsonToken;
        SummaryObj: JsonObject;
        DOBText: Text;
        DateText: Text;
        InfoParts: Text;
        Base64Convert: Codeunit "Base64 Convert";
        PDFOutStream: OutStream;
    begin
        case VerificationType of
            "IDM Verification Type"::"National ID":
                begin
                    if DataObj.Get('full_name', JsonToken) then
                        IDMLog."Full Name" := CopyStr(JsonToken.AsValue().AsText(), 1, 150);


                    if DataObj.Get('first_name', JsonToken) then
                        IDMLog."First Name" := CopyStr(JsonToken.AsValue().AsText(), 1, 150);
                    if DataObj.Get('middle_name', JsonToken) then
                        IDMLog."Middle Name" := CopyStr(JsonToken.AsValue().AsText(), 1, 150);
                    if DataObj.Get('surname', JsonToken) then
                        IDMLog."Surname" := CopyStr(JsonToken.AsValue().AsText(), 1, 150);


                    if DataObj.Get('date_of_birth', JsonToken) then begin
                        DOBText := JsonToken.AsValue().AsText();
                        if DOBText <> '' then Evaluate(IDMLog."Date of Birth", DOBText);
                    end;
                    if DataObj.Get('gender', JsonToken) then
                        IDMLog.Gender := CopyStr(JsonToken.AsValue().AsText(), 1, 10);
                    if DataObj.Get('citizenship', JsonToken) then
                        IDMLog.Citizenship := CopyStr(JsonToken.AsValue().AsText(), 1, 50);
                    if DataObj.Get('district_of_birth', JsonToken) then
                        IDMLog."District of Birth" := CopyStr(JsonToken.AsValue().AsText(), 1, 100);
                    if DataObj.Get('serial_number', JsonToken) then begin
                        IDMLog."ID Serial No." := CopyStr(JsonToken.AsValue().AsText(), 1, 150);
                        InfoParts := 'Serial: ' + JsonToken.AsValue().AsText();
                    end;
                    if DataObj.Get('place_of_issue', JsonToken) then begin
                        if InfoParts <> '' then InfoParts += ' | ';
                        InfoParts += 'Issue Place: ' + JsonToken.AsValue().AsText();
                    end;
                    if DataObj.Get('date_of_issue', JsonToken) then begin
                        if InfoParts <> '' then InfoParts += ' | ';
                        InfoParts += 'Issue Date: ' + JsonToken.AsValue().AsText();
                    end;
                    IDMLog."Additional Info" := CopyStr(InfoParts, 1, 500);
                end;

            "IDM Verification Type"::"Alien ID":
                begin
                    if DataObj.Get('full_name', JsonToken) then
                        IDMLog."Full Name" := CopyStr(JsonToken.AsValue().AsText(), 1, 150);
                    if DataObj.Get('date_of_birth', JsonToken) then begin
                        DOBText := JsonToken.AsValue().AsText();
                        if DOBText <> '' then Evaluate(IDMLog."Date of Birth", DOBText);
                    end;
                    if DataObj.Get('gender', JsonToken) then
                        IDMLog.Gender := CopyStr(JsonToken.AsValue().AsText(), 1, 10);
                    if DataObj.Get('citizenship', JsonToken) then
                        IDMLog.Citizenship := CopyStr(JsonToken.AsValue().AsText(), 1, 50);
                    IDMLog."Additional Info" := CopyStr('Citizenship: ' + IDMLog.Citizenship, 1, 500);
                end;

            "IDM Verification Type"::"KRA PIN":
                begin
                    if DataObj.Get('taxpayer_name', JsonToken) then
                        IDMLog."Full Name" := CopyStr(JsonToken.AsValue().AsText(), 1, 150);
                    if DataObj.Get('trading_name', JsonToken) then
                        IDMLog."Trading Name" := CopyStr(JsonToken.AsValue().AsText(), 1, 150);
                    if DataObj.Get('tax_status', JsonToken) then
                        IDMLog."Tax Status" := CopyStr(JsonToken.AsValue().AsText(), 1, 50);
                    if DataObj.Get('paye_registered', JsonToken) then
                        IDMLog."PAYE Registered" := JsonToken.AsValue().AsBoolean();
                    if DataObj.Get('vat_registered', JsonToken) then
                        IDMLog."VAT Registered" := JsonToken.AsValue().AsBoolean();
                    if DataObj.Get('registration_date', JsonToken) then begin
                        DateText := JsonToken.AsValue().AsText();
                        if DateText <> '' then Evaluate(IDMLog."Registration Date", DateText);
                    end;
                    if DataObj.Get('locality', JsonToken) then
                        InfoParts := 'Locality: ' + JsonToken.AsValue().AsText();
                    if DataObj.Get('station', JsonToken) then begin
                        if InfoParts <> '' then InfoParts += ' | ';
                        InfoParts += 'Station: ' + JsonToken.AsValue().AsText();
                    end;
                    if DataObj.Get('email', JsonToken) then begin
                        if InfoParts <> '' then InfoParts += ' | ';
                        InfoParts += 'Email: ' + JsonToken.AsValue().AsText();
                    end;
                    IDMLog."Additional Info" := CopyStr(InfoParts, 1, 500);
                end;

            "IDM Verification Type"::"Driving Licence":
                begin
                    if DataObj.Get('holder_name', JsonToken) then
                        IDMLog."Full Name" := CopyStr(JsonToken.AsValue().AsText(), 1, 150);
                    if DataObj.Get('licence_class', JsonToken) then
                        IDMLog."Licence Class" := CopyStr(JsonToken.AsValue().AsText(), 1, 20);
                    if DataObj.Get('status', JsonToken) then
                        IDMLog."Registration Status" := CopyStr(JsonToken.AsValue().AsText(), 1, 50);
                    if DataObj.Get('expiry_date', JsonToken) then begin
                        DateText := JsonToken.AsValue().AsText();
                        if DateText <> '' then Evaluate(IDMLog."Licence Expiry Date", DateText);
                    end;
                    if DataObj.Get('issue_date', JsonToken) then
                        InfoParts := 'Issue Date: ' + JsonToken.AsValue().AsText();
                    IDMLog."Additional Info" := CopyStr(InfoParts, 1, 500);
                end;

            "IDM Verification Type"::Phone:
                begin
                    if DataObj.Get('full_name', JsonToken) then
                        IDMLog."Full Name" := CopyStr(JsonToken.AsValue().AsText(), 1, 150);
                    if DataObj.Get('is_matched', JsonToken) then
                        IDMLog."Phone Matched" := JsonToken.AsValue().AsBoolean();
                    if DataObj.Get('verification_status', JsonToken) then
                        InfoParts := 'Status: ' + JsonToken.AsValue().AsText();
                    if DataObj.Get('matching_service', JsonToken) then begin
                        if InfoParts <> '' then InfoParts += ' | ';
                        InfoParts += 'Service: ' + JsonToken.AsValue().AsText();
                    end;
                    IDMLog."Additional Info" := CopyStr(InfoParts, 1, 500);
                end;

            "IDM Verification Type"::Vehicle:
                begin
                    if DataObj.Get('owner_name', JsonToken) then begin
                        IDMLog."Owner Name" := CopyStr(JsonToken.AsValue().AsText(), 1, 150);
                        IDMLog."Full Name" := CopyStr(JsonToken.AsValue().AsText(), 1, 150);
                    end;
                    if DataObj.Get('make', JsonToken) then
                        IDMLog."Vehicle Make" := CopyStr(JsonToken.AsValue().AsText(), 1, 50);
                    if DataObj.Get('model', JsonToken) then
                        IDMLog."Vehicle Model" := CopyStr(JsonToken.AsValue().AsText(), 1, 50);
                    if DataObj.Get('color', JsonToken) then
                        IDMLog."Vehicle Color" := CopyStr(JsonToken.AsValue().AsText(), 1, 30);
                    if DataObj.Get('registration_status', JsonToken) then
                        IDMLog."Registration Status" := CopyStr(JsonToken.AsValue().AsText(), 1, 50);
                    if DataObj.Get('year_of_manufacture', JsonToken) then
                        InfoParts := 'Year: ' + JsonToken.AsValue().AsText();
                    if DataObj.Get('body_type', JsonToken) then begin
                        if InfoParts <> '' then InfoParts += ' | ';
                        InfoParts += 'Body: ' + JsonToken.AsValue().AsText();
                    end;
                    if DataObj.Get('fuel_type', JsonToken) then begin
                        if InfoParts <> '' then InfoParts += ' | ';
                        InfoParts += 'Fuel: ' + JsonToken.AsValue().AsText();
                    end;
                    if DataObj.Get('engine_number', JsonToken) then begin
                        if InfoParts <> '' then InfoParts += ' | ';
                        InfoParts += 'Engine No: ' + JsonToken.AsValue().AsText();
                    end;
                    if DataObj.Get('chassis_number', JsonToken) then begin
                        if InfoParts <> '' then InfoParts += ' | ';
                        InfoParts += 'Chassis: ' + JsonToken.AsValue().AsText();
                    end;
                    IDMLog."Additional Info" := CopyStr(InfoParts, 1, 500);
                end;

            "IDM Verification Type"::"Business UBO":
                begin
                    if DataObj.Get('business_name', JsonToken) then
                        IDMLog."Full Name" := CopyStr(JsonToken.AsValue().AsText(), 1, 150);
                    if DataObj.Get('business_type', JsonToken) then
                        IDMLog."Business Type" := CopyStr(JsonToken.AsValue().AsText(), 1, 100);
                    if DataObj.Get('status', JsonToken) then
                        IDMLog."Registration Status" := CopyStr(JsonToken.AsValue().AsText(), 1, 50);
                    if DataObj.Get('registration_date', JsonToken) then begin
                        DateText := JsonToken.AsValue().AsText();
                        if DateText <> '' then Evaluate(IDMLog."Registration Date", DateText);
                    end;
                    if DataObj.Get('kra_pin', JsonToken) then
                        InfoParts := 'KRA PIN: ' + JsonToken.AsValue().AsText();
                    if DataObj.Get('address', JsonToken) then begin
                        if InfoParts <> '' then InfoParts += ' | ';
                        InfoParts += 'Address: ' + JsonToken.AsValue().AsText();
                    end;
                    if DataObj.Get('email', JsonToken) then begin
                        if InfoParts <> '' then InfoParts += ' | ';
                        InfoParts += 'Email: ' + JsonToken.AsValue().AsText();
                    end;
                    IDMLog."Additional Info" := CopyStr(InfoParts, 1, 500);
                end;

            "IDM Verification Type"::"Bank Account":
                begin
                    if DataObj.Get('account_name', JsonToken) then
                        IDMLog."Full Name" := CopyStr(JsonToken.AsValue().AsText(), 1, 150);
                    if DataObj.Get('bank_name', JsonToken) then
                        IDMLog."Bank Name" := CopyStr(JsonToken.AsValue().AsText(), 1, 100);
                    if DataObj.Get('account_status', JsonToken) then
                        IDMLog."Account Status" := CopyStr(JsonToken.AsValue().AsText(), 1, 50);
                    if DataObj.Get('account_number', JsonToken) then
                        InfoParts := 'Account: ' + JsonToken.AsValue().AsText();
                    IDMLog."Additional Info" := CopyStr(InfoParts, 1, 500);
                end;

            "IDM Verification Type"::"Credit Report":
                begin
                    if DataObj.Get('pdf_base64', JsonToken) then begin
                        IDMLog."PDF Report".CreateOutStream(PDFOutStream);
                        Base64Convert.FromBase64(JsonToken.AsValue().AsText(), PDFOutStream);
                    end;
                    if DataObj.Get('summary', SummaryToken) then begin
                        SummaryObj := SummaryToken.AsObject();
                        if SummaryObj.Get('credit_score', JsonToken) then
                            IDMLog."Credit Score" := JsonToken.AsValue().AsInteger();
                        if SummaryObj.Get('score_grade', JsonToken) then
                            IDMLog."Score Grade" := CopyStr(JsonToken.AsValue().AsText(), 1, 5);
                        InfoParts := 'Score: ' + Format(IDMLog."Credit Score") + ' (' + IDMLog."Score Grade" + ')';
                        if SummaryObj.Get('total_accounts', JsonToken) then
                            InfoParts += ' | Accounts: ' + Format(JsonToken.AsValue().AsInteger());
                        if SummaryObj.Get('open_accounts', JsonToken) then
                            InfoParts += ' open: ' + Format(JsonToken.AsValue().AsInteger());
                        if SummaryObj.Get('overdue_balance', JsonToken) then
                            InfoParts += ' | Overdue: ' + Format(JsonToken.AsValue().AsDecimal());
                        if SummaryObj.Get('inquiries_last_12_months', JsonToken) then
                            InfoParts += ' | Inquiries (12m): ' + Format(JsonToken.AsValue().AsInteger());
                        IDMLog."Credit Summary" := CopyStr(InfoParts, 1, 500);
                        IDMLog."Additional Info" := CopyStr('Score: ' + Format(IDMLog."Credit Score") + ' | Grade: ' + IDMLog."Score Grade", 1, 500);
                    end;
                end;
        end;
    end;



    // ─── Utility Helpers ────────────────────────────────────────────────────────

    local procedure GetVerificationTypeCode(VerificationType: Enum "IDM Verification Type"): Text
    begin
        case VerificationType of
            "IDM Verification Type"::"National ID":
                exit('national_id');
            "IDM Verification Type"::"Alien ID":
                exit('alien_id');
            "IDM Verification Type"::"KRA PIN":
                exit('kra_pin');
            "IDM Verification Type"::"Driving Licence":
                exit('driving_licence');
            "IDM Verification Type"::Phone:
                exit('phone');
            "IDM Verification Type"::Vehicle:
                exit('vehicle');
            "IDM Verification Type"::"Business UBO":
                exit('business_ubo');
            "IDM Verification Type"::"Bank Account":
                exit('bank_account');
            "IDM Verification Type"::"Credit Report":
                exit('credit_report');
            else
                Error('Unsupported verification type: %1', VerificationType);
        end;
    end;

    local procedure FormatPhoneNumber(PhoneNo: Text): Text
    begin
        PhoneNo := PhoneNo.Trim();
        // Remove spaces or dashes
        PhoneNo := PhoneNo.Replace(' ', '').Replace('-', '');
        // +254XXXXXXXXX → 254XXXXXXXXX
        if PhoneNo.StartsWith('+254') then
            PhoneNo := PhoneNo.Substring(2)
        // 0XXXXXXXXX → 254XXXXXXXXX
        else if PhoneNo.StartsWith('0') then
            PhoneNo := '254' + PhoneNo.Substring(2)
        // 7XXXXXXXXX or 1XXXXXXXXX (9 digits, no prefix) → 254XXXXXXXXX
        else if (StrLen(PhoneNo) = 9) and (PhoneNo.StartsWith('7') or PhoneNo.StartsWith('1')) then
            PhoneNo := '254' + PhoneNo;
        // Already in 254XXXXXXXXX format — leave as-is
        exit(PhoneNo);
    end;
}
