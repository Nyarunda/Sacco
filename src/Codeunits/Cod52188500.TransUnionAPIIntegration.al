codeunit 50163 "TransUnion API Integration"
{
    // TransUnion Kenya CIS4 Data Submission API Integration
    // Version 1.0 - October 2025

    var
        TransUnionSetup: Record "TransUnion Setup";
        CurrentAuthToken: Text;
        TokenExpiry: DateTime;
        TestBaseURL: Label 'https://secure3.crbafrica.com/duv2';
        LiveBaseURL: Label 'https://secure3.transunionafrica.com/duv2';
        LoginEndpoint: Label '/login';
        DailyPaymentEndpoint: Label '/data/ke/update/dailypaymentinformation';

    /// <summary>
    /// Submits daily payment information to TransUnion Kenya API
    /// </summary>
    /// <param name="PaymentData">Daily payment information record to submit</param>
    /// <returns>True if submission successful, False otherwise</returns>
    procedure SubmitDailyPaymentInformation(ParentLogEntryNo: Integer; PaymentData: Record "TransUnion Daily Payment"): Boolean
    var
        JsonPayload: Text;
        ResponseText: Text;
        Success: Boolean;
    begin
        // Ensure we have valid authentication
        if not EnsureAuthentication() then
            Error('Failed to authenticate with TransUnion API');

        // Build JSON payload
        JsonPayload := BuildDailyPaymentJSON(PaymentData);

        //Message('Submitting JSON to TransUnion API:\n%1', JsonPayload);
        // Submit to API
        Success := SendDataToAPI(DailyPaymentEndpoint, JsonPayload, ResponseText);

        // Process response
        ProcessAPIResponse(ParentLogEntryNo, ResponseText, PaymentData);

        exit(Success);
    end;

    /// <summary>
    /// Ensures we have a valid authentication token
    /// </summary>
    /// <returns>True if authentication successful</returns>
    local procedure EnsureAuthentication(): Boolean
    var
        TokenResponse: Text;
    begin
        // Check if we have a valid token that hasn't expired
        if (CurrentAuthToken <> '') and (TokenExpiry > CurrentDateTime) then
            exit(true);

        // Get fresh token
        if GenerateAuthToken(TokenResponse) then begin
            ParseTokenResponse(TokenResponse);
            exit(true);
        end;

        exit(false);
    end;

    /// <summary>
    /// Generates authentication token from TransUnion API
    /// </summary>
    /// <param name="ResponseText">Response from API</param>
    /// <returns>True if token generation successful</returns>
    local procedure GenerateAuthToken(var ResponseText: Text): Boolean
    var
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpResponse: HttpResponseMessage;
        JsonPayload: Text;
        RequestUrl: Text;
    begin
        // Get setup
        GetTransUnionSetup();

        // Build login JSON
        JsonPayload := BuildLoginJSON();

        // Setup HTTP content
        HttpContent.WriteFrom(JsonPayload);
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Clear();
        HttpHeaders.Add('Content-Type', 'application/json');

        // Make request
        RequestUrl := LiveBaseURL + LoginEndpoint;
        if TransUnionSetup."Test Mode" then
            RequestUrl := TestBaseURL + LoginEndpoint;

        //Message('Request URL: %1\ Payload: %2', RequestUrl, JsonPayload);

        if not HttpClient.Post(RequestUrl, HttpContent, HttpResponse) then begin
            //Message('Failed to send request to TransUnion API: %1', HttpResponse);
            exit(false);
        end;

        HttpResponse.Content.ReadAs(ResponseText);
        //Message('Failed to send request to TransUnion API: %1', ResponseText);


        if not HttpResponse.IsSuccessStatusCode then begin

            HttpResponse.Content.ReadAs(ResponseText);
            //Message('Failed to send request to TransUnion API: %1', ResponseText);
            exit(false);
        end;

        HttpResponse.Content.ReadAs(ResponseText);
        exit(true);
    end;

    /// <summary>
    /// Sends data to TransUnion API endpoint
    /// </summary>
    /// <param name="Endpoint">API endpoint to call</param>
    /// <param name="JsonData">JSON payload to send</param>
    /// <param name="ResponseText">Response from API</param>
    /// <returns>True if request successful</returns>
    local procedure SendDataToAPI(Endpoint: Text; JsonData: Text; var ResponseText: Text): Boolean
    var
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestHeaders: HttpHeaders;
        HttpResponse: HttpResponseMessage;
        RequestUrl: Text;
    begin
        // Setup HTTP content
        HttpContent.WriteFrom(JsonData);
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Clear();
        HttpHeaders.Add('Content-Type', 'application/json');

        // Setup authorization header
        HttpClient.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + CurrentAuthToken);

        // Make request
        RequestUrl := LiveBaseURL + Endpoint;
        if TransUnionSetup."Test Mode" then
            RequestUrl := TestBaseURL + Endpoint;

        //Message('Request URL: %1\ Payload: %2', RequestUrl, JsonData);
        if not HttpClient.Post(RequestUrl, HttpContent, HttpResponse) then begin
            //Message('Failed to send request to TransUnion API: %1', HttpResponse);
            exit(false);
        end;

        HttpResponse.Content.ReadAs(ResponseText);
        //Message('TransUnion API Response: %1', ResponseText);

        if not HttpResponse.IsSuccessStatusCode then begin

            //Message('TransUnion API returned error: %1', ResponseText);
        end;

        exit(HttpResponse.IsSuccessStatusCode);
    end;

    /// <summary>
    /// Builds JSON payload for login request
    /// </summary>
    /// <returns>JSON string for login</returns>
    local procedure BuildLoginJSON(): Text
    var
        JsonObject: JsonObject;
    begin
        JsonObject.Add('infinityCode', TransUnionSetup."Infinity Code");
        JsonObject.Add('username', TransUnionSetup.Username);
        JsonObject.Add('password', TransUnionSetup.Password);

        exit(Format(JsonObject));
    end;

    /// <summary>
    /// Builds JSON payload for daily payment information
    /// </summary>
    /// <param name="PaymentData">Payment data to convert to JSON</param>
    /// <returns>JSON string for daily payment submission</returns>
    local procedure BuildDailyPaymentJSON(PaymentData: Record "TransUnion Daily Payment"): Text
    var
        MainJsonObject: JsonObject;
        PaymentJsonObject: JsonObject;
        MainJsonArray: JsonArray;

    begin
        /*
        Clear(MainJsonArray);
        if PaymentData.FindSet() then begin
            repeat
                Clear(PaymentJsonObject);
                Clear(MainJsonObject);

                MainJsonArray.Add(MainJsonObject);
            until PaymentData.Next() = 0;
        end;
        */


        // Build daily payment information object
        PaymentJsonObject.Add('accountNumber', PaymentData."Account Number");
        PaymentJsonObject.Add('accountStatus', GetAccountStatusCode(PaymentData."Account Status"));
        PaymentJsonObject.Add('clientType', PaymentData."Client Type");
        PaymentJsonObject.Add('companyName', PaymentData."Company Name");
        PaymentJsonObject.Add('currencyOfFacility', PaymentData."Currency Code");
        PaymentJsonObject.Add('currentBalance', FormatAmountForAPI(PaymentData."Current Balance"));
        PaymentJsonObject.Add('daysInArrears', PaymentData."Days in Arrears");
        PaymentJsonObject.Add('forename1', PaymentData."Forename 1");
        PaymentJsonObject.Add('forename2', PaymentData."Forename 2");
        PaymentJsonObject.Add('forename3', PaymentData."Forename 3");
        PaymentJsonObject.Add('installmentsInArrears', PaymentData."Installments in Arrears");
        PaymentJsonObject.Add('originalAmount', FormatAmountForAPI(PaymentData."Original Amount"));
        PaymentJsonObject.Add('paymentAmount', FormatAmountForAPI(PaymentData."Payment Amount"));
        PaymentJsonObject.Add('paymentDate', FormatDateForAPI(PaymentData."Payment Date"));
        PaymentJsonObject.Add('primaryIdentificationDocNumber', PaymentData."Primary ID Doc Number");
        PaymentJsonObject.Add('primaryIdentificationDocumentType', GetIDDocumentTypeCode(PaymentData."Primary ID Doc Type"));
        PaymentJsonObject.Add('snapshotDate', FormatDateForAPI(PaymentData."Snapshot Date"));
        PaymentJsonObject.Add('surname', PaymentData.Surname);

        // Build main object
        MainJsonObject.Add('dailyPaymentInformationRecord', PaymentJsonObject);
        MainJsonObject.Add('recordType', 'DP');
        exit(Format(MainJsonObject));
        //exit(Format(MainJsonArray));
    end;

    /// <summary>
    /// Parses authentication token response
    /// </summary>
    /// <param name="ResponseText">JSON response from login API</param>
    local procedure ParseTokenResponse(ResponseText: Text)
    var
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        ExpirySeconds: BigInteger;
    begin
        if not JsonObject.ReadFrom(ResponseText) then
            Error('Invalid JSON response from authentication');

        // Get token
        if JsonObject.Get('token', JsonToken) then
            CurrentAuthToken := JsonToken.AsValue().AsText();

        // Get expiry (in milliseconds, convert to DateTime)
        if JsonObject.Get('expiresAfter', JsonToken) then begin
            ExpirySeconds := JsonToken.AsValue().AsBigInteger();
            TokenExpiry := CurrentDateTime + (ExpirySeconds); // Convert ms to days
        end;
    end;

    /// <summary>
    /// Processes API response and logs results
    /// </summary>
    /// <param name="ResponseText">JSON response from API</param>
    /// <param name="PaymentData">Original payment data for reference</param>
    local procedure ProcessAPIResponse(ParentLogEntryNo: Integer; ResponseText: Text; PaymentData: Record "TransUnion Daily Payment")
    var
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        JsonArray: JsonArray;
        JsonArrayElement: JsonToken;
        ErrorJsonObject: JsonObject;
        ResponseCode: Integer;
        Message: Text;
        CallbackId: Text;
        ErrorAccountNumber: Text;
        ErrorMessage: Text;
        FieldName: Text;
        FieldValue: Text;
        ErrorCode: Integer;
        i: Integer;
        HasErrors: Boolean;
        TransUnionLog: Record "TransUnion API Log";
        TransUnionErrorLog: Record "TransUnion Error Log";
        TransUnionParsedError: Record "TransUnion Parsed Error";
    begin
        if not JsonObject.ReadFrom(ResponseText) then begin
            // Handle case where response is an error array directly
            if JsonArray.ReadFrom(ResponseText) then begin
                ProcessErrorArray(ParentLogEntryNo, JsonArray, PaymentData."Account Number");
                Error('TransUnion API returned validation errors. Check the error log for details.');
            end else
                Error('Invalid JSON response from TransUnion API');
        end;

        // Check if response is an error array at root level
        if JsonObject.Get('length', JsonToken) then begin
            // This might be an array response, try to parse as array
            if JsonArray.ReadFrom(ResponseText) then begin
                ProcessErrorArray(ParentLogEntryNo, JsonArray, PaymentData."Account Number");
                Error('TransUnion API returned validation errors. Check the error log for details.');
            end;
        end;

        // Get response details for successful responses
        if JsonObject.Get('responseCode', JsonToken) then
            ResponseCode := JsonToken.AsValue().AsInteger();

        if JsonObject.Get('message', JsonToken) then
            Message := JsonToken.AsValue().AsText();

        if JsonObject.Get('callbackId', JsonToken) then
            CallbackId := JsonToken.AsValue().AsText();

        // Log the response
        LogAPIResponse(PaymentData."Account Number", ResponseCode, Message, CallbackId);

        if ResponseCode <> 200 then begin
            exit; // No errors to process

            // Handle recordErrors array in standard response
            if JsonObject.Get('recordErrors', JsonToken) then begin
                if JsonToken.IsArray then begin
                    JsonArray := JsonToken.AsArray();
                    ProcessErrorArray(ParentLogEntryNo, JsonArray, PaymentData."Account Number");
                    HasErrors := true;
                end else begin
                    JsonToken.WriteTo(ResponseText);
                    LogValidationErrors(PaymentData."Account Number", ResponseText);
                    HasErrors := true;
                end;
            end;

            //if HasErrors then
            //  Error('TransUnion API validation errors occurred. Check the error log for details.');

            // Show success message
            //if ResponseCode = 200 then
            //  Message('Successfully submitted payment data to TransUnion. Callback ID: ' + CallbackId);
        end;
    end;

    /// <summary>
    /// Processes error array from TransUnion API response
    /// </summary>
    /// <param name="ErrorArray">JSON array containing error objects</param>
    /// <param name="AccountNumber">Account number for reference</param>
    local procedure ProcessErrorArray(ParentLogEntryNo: Integer; ErrorArray: JsonArray; AccountNumber: Code[50])
    var
        JsonArrayElement: JsonToken;
        ErrorJsonObject: JsonObject;
        ErrorAccountNumber: Text;
        ErrorMessage: Text;
        FieldName: Text;
        FieldValue: Text;
        ErrorCode: Integer;
    begin
        foreach JsonArrayElement in ErrorArray do begin
            if JsonArrayElement.IsObject then begin
                ErrorJsonObject := JsonArrayElement.AsObject();

                // Extract error details
                if ErrorJsonObject.Get('accountNumber', JsonArrayElement) then
                    ErrorAccountNumber := JsonArrayElement.AsValue().AsText();

                if ErrorJsonObject.Get('errorMessage', JsonArrayElement) then
                    ErrorMessage := JsonArrayElement.AsValue().AsText();

                if ErrorJsonObject.Get('fieldName', JsonArrayElement) then
                    FieldName := JsonArrayElement.AsValue().AsText();

                if ErrorJsonObject.Get('fieldValue', JsonArrayElement) then
                    FieldValue := JsonArrayElement.AsValue().AsText();

                if ErrorJsonObject.Get('errorCode', JsonArrayElement) then
                    ErrorCode := JsonArrayElement.AsValue().AsInteger();

                // Log each individual error
                LogDetailedValidationError(ParentLogEntryNo, AccountNumber, ErrorAccountNumber, ErrorMessage, FieldName, FieldValue, ErrorCode);
            end;
        end;
    end;

    /// <summary>
    /// Formats date for TransUnion API (YYYYMMDD)
    /// </summary>
    /// <param name="DateValue">Date to format</param>
    /// <returns>Formatted date string</returns>
    local procedure FormatDateForAPI(DateValue: Date): Text
    begin
        exit(Format(DateValue, 0, '<Year4><Month,2><Day,2>'));
    end;

    /// <summary>
    /// Formats amount for TransUnion API according to specification
    /// All amounts with assumed double decimal point excluding currency symbol and separators
    /// E.g. KES 3,125.45 becomes 312545, KES 3,125.00 becomes 312500
    /// </summary>
    /// <param name="AmountValue">Decimal amount to format</param>
    /// <returns>Formatted amount as integer string (cents)</returns>
    local procedure FormatAmountForAPI(AmountValue: Decimal): Text
    begin
        // TransUnion specification: multiply by 100 to convert to cents, then format as integer
        // E.g. 3125.45 becomes 312545, 3125.00 becomes 312500
        exit(Format(Round(AmountValue * 100, 1), 0, '<Integer>'));
    end;

    /// <summary>
    /// Gets TransUnion setup record
    /// </summary>
    local procedure GetTransUnionSetup()
    begin
        if not TransUnionSetup.Get() then begin
            TransUnionSetup.Init();
            TransUnionSetup.Insert();
            Commit();
            Error('TransUnion setup is not configured. Please configure the setup first.');
        end;

        if (TransUnionSetup."Infinity Code" = '') or (TransUnionSetup.Username = '') or (TransUnionSetup.Password = '') then
            Error('TransUnion setup is incomplete. Please configure all required fields.');
    end;

    /// <summary>
    /// Logs API response for audit trail
    /// </summary>
    /// <param name="AccountNumber">Account number for reference</param>
    /// <param name="ResponseCode">API response code</param>
    /// <param name="Message">Response message</param>
    /// <param name="CallbackId">TransUnion callback ID</param>
    local procedure LogAPIResponse(AccountNumber: Code[50]; ResponseCode: Integer; Message: Text; CallbackId: Text)
    var
        TransUnionLog: Record "TransUnion API Log";
    begin
        TransUnionLog.Init();
        TransUnionLog."Entry No." := 0; // Auto-increment field
        TransUnionLog."Account Number" := AccountNumber;
        TransUnionLog."Response Code" := ResponseCode;
        TransUnionLog."Response Message" := CopyStr(Message, 1, MaxStrLen(TransUnionLog."Response Message"));
        TransUnionLog."Callback ID" := CopyStr(CallbackId, 1, MaxStrLen(TransUnionLog."Callback ID"));
        TransUnionLog."Submission Date Time" := CurrentDateTime;
        TransUnionLog."User ID" := UserId;
        TransUnionLog.Insert(true);
    end;

    /// <summary>
    /// Logs validation errors for troubleshooting
    /// </summary>
    /// <param name="AccountNumber">Account number for reference</param>
    /// <param name="ErrorDetails">JSON error details from API</param>
    local procedure LogValidationErrors(AccountNumber: Code[50]; ErrorDetails: Text)
    var
        TransUnionErrorLog: Record "TransUnion Error Log";
    begin
        TransUnionErrorLog.Init();
        TransUnionErrorLog."Entry No." := 0; // Auto-increment field
        TransUnionErrorLog."Account Number" := AccountNumber;
        TransUnionErrorLog."Error Details" := CopyStr(ErrorDetails, 1, MaxStrLen(TransUnionErrorLog."Error Details"));
        TransUnionErrorLog."Error Date Time" := CurrentDateTime;
        TransUnionErrorLog."User ID" := UserId;
        TransUnionErrorLog.Insert(true);
        commit();
    end;

    /// <summary>
    /// Logs detailed validation error for specific field
    /// </summary>
    /// <param name="AccountNumber">Account number for reference</param>
    /// <param name="ErrorAccountNumber">Account number from error response</param>
    /// <param name="ErrorMessage">Error message from TransUnion</param>
    /// <param name="FieldName">Field that caused the error</param>
    /// <param name="FieldValue">Value that caused the error</param>
    /// <param name="ErrorCode">TransUnion error code</param>
    local procedure LogDetailedValidationError(ParentLogEntryNo: Integer; AccountNumber: Code[50]; ErrorAccountNumber: Text; ErrorMessage: Text; FieldName: Text; FieldValue: Text; ErrorCode: Integer)
    var
        TransUnionErrorLog: Record "TransUnion Error Log";
        TransUnionParsedError: Record "TransUnion Parsed Error";
        ErrorLogEntryNo: Integer;
        NextLineNo: Integer;
    begin
        // First log to the main error log
        TransUnionErrorLog.Init();
        TransUnionParsedError."Parent Entry No." := ParentLogEntryNo;
        TransUnionErrorLog."Entry No." := 0; // Auto-increment field
        TransUnionErrorLog."Account Number" := AccountNumber;
        TransUnionErrorLog."Error Details" := CopyStr(StrSubstNo('Field: %1, Value: %2, Error: %3', FieldName, FieldValue, ErrorMessage), 1, MaxStrLen(TransUnionErrorLog."Error Details"));
        TransUnionErrorLog."Error Date Time" := CurrentDateTime;
        TransUnionErrorLog."User ID" := UserId;
        TransUnionErrorLog.Insert(true);
        ErrorLogEntryNo := TransUnionErrorLog."Entry No.";

        // Get next line number for parsed errors
        TransUnionParsedError.SetRange("Parent Entry No.", ParentLogEntryNo);
        if TransUnionParsedError.FindLast() then
            NextLineNo := TransUnionParsedError."Line No." + 10000
        else
            NextLineNo := 10000;

        // Then log to the detailed parsed error table
        TransUnionParsedError.Init();
        TransUnionParsedError."Parent Entry No." := ParentLogEntryNo;
        TransUnionParsedError."Line No." := NextLineNo;
        TransUnionParsedError."Account Number" := AccountNumber;
        TransUnionParsedError."Field Name" := CopyStr(FieldName, 1, MaxStrLen(TransUnionParsedError."Field Name"));
        TransUnionParsedError."Field Value" := CopyStr(FieldValue, 1, MaxStrLen(TransUnionParsedError."Field Value"));
        TransUnionParsedError."Error Message" := CopyStr(ErrorMessage, 1, MaxStrLen(TransUnionParsedError."Error Message"));
        TransUnionParsedError."Error Code" := CopyStr(Format(ErrorCode), 1, MaxStrLen(TransUnionParsedError."Error Code"));
        TransUnionParsedError.Insert(true);

        // Update submission line status if we're in batch mode
        UpdateSubmissionLineError(AccountNumber, ErrorMessage);
        commit();
    end;

    /// <summary>
    /// Updates submission line with error information
    /// </summary>
    /// <param name="AccountNumber">Account number to find submission line</param>
    /// <param name="ErrorMessage">Error message to record</param>
    local procedure UpdateSubmissionLineError(AccountNumber: Code[50]; ErrorMessage: Text)
    var
        TransUnionLine: Record "TransUnion Submission Line";
    begin
        TransUnionLine.SetRange("Account Number", AccountNumber);
        TransUnionLine.SetRange("Submission Status", TransUnionLine."Submission Status"::"Not Submitted");
        if TransUnionLine.FindFirst() then begin
            TransUnionLine."Submission Status" := TransUnionLine."Submission Status"::Error;
            TransUnionLine."Last Error Message" := CopyStr(ErrorMessage, 1, MaxStrLen(TransUnionLine."Last Error Message"));
            TransUnionLine.Modify();
        end;
    end;

    /// <summary>
    /// Tests connection to TransUnion API
    /// </summary>
    /// <returns>True if connection successful</returns>
    procedure TestConnection(): Boolean
    var
        ResponseText: Text;
    begin
        exit(GenerateAuthToken(ResponseText));
    end;

    /// <summary>
    /// Generates a new authentication token and updates setup
    /// </summary>
    /// <returns>True if token generation successful</returns>
    procedure GenerateNewToken(): Boolean
    var
        ResponseText: Text;
    begin
        if GenerateAuthToken(ResponseText) then begin
            ParseTokenResponse(ResponseText);

            // Update setup record
            GetTransUnionSetup();
            TransUnionSetup."Last Token Generated" := CurrentDateTime;
            TransUnionSetup."Token Expiry" := TokenExpiry;
            TransUnionSetup.Modify();

            exit(true);
        end;

        exit(false);
    end;

    /// <summary>
    /// Test amount formatting to show how values will be sent to TransUnion
    /// </summary>
    procedure TestAmountFormatting()
    var
        TestResults: Text;
    begin
        TestResults := 'TransUnion Amount Formatting Test Results:\';
        TestResults += 'Original Examples from Error:\';
        TestResults += StrSubstNo('KES 450,000.00 → %1\', FormatAmountForAPI(450000.0));
        TestResults += StrSubstNo('KES 335,364.49 → %1\', FormatAmountForAPI(335364.49));
        TestResults += StrSubstNo('KES 0.00 → %1\', FormatAmountForAPI(0.0));
        TestResults += '\Additional Test Cases:\';
        TestResults += StrSubstNo('KES 3,125.45 → %1 (spec example)\', FormatAmountForAPI(3125.45));
        TestResults += StrSubstNo('KES 3,125.00 → %1 (spec example)\', FormatAmountForAPI(3125.00));
        TestResults += StrSubstNo('KES 1,000.50 → %1\', FormatAmountForAPI(1000.50));
        TestResults += StrSubstNo('KES 10.99 → %1', FormatAmountForAPI(10.99));

        Message(TestResults);
    end;

    /// <summary>
    /// Converts ID Document Type enum to TransUnion API code
    /// </summary>
    /// <param name="IDDocType">ID Document Type enum value</param>
    /// <returns>TransUnion API code for the document type</returns>
    local procedure GetIDDocumentTypeCode(IDDocType: Enum "TransUnion ID Document Type"): Text
    begin
        case IDDocType of
            IDDocType::"001":
                exit('001');
            IDDocType::"002":
                exit('002');
            IDDocType::"003":
                exit('003');
            IDDocType::"004":
                exit('004');
            IDDocType::"005":
                exit('005');
            IDDocType::"006":
                exit('006');
            IDDocType::"007":
                exit('007');
            IDDocType::"008":
                exit('008');
            IDDocType::"009":
                exit('009');
            IDDocType::"010":
                exit('010');
            else
                exit('001'); // Default to National ID if not specified
        end;
    end;

    /// <summary>
    /// Converts Account Status enum to TransUnion API code
    /// </summary>
    /// <param name="AccountStatus">Account Status enum value</param>
    /// <returns>TransUnion API code for the account status</returns>
    local procedure GetAccountStatusCode(AccountStatus: Enum "TransUnion Account Status"): Text
    begin
        case AccountStatus of
            AccountStatus::A:
                exit('A');
            AccountStatus::B:
                exit('B');
            AccountStatus::C:
                exit('C');
            AccountStatus::D:
                exit('D');
            AccountStatus::E:
                exit('E');
            AccountStatus::F:
                exit('F');
            AccountStatus::G:
                exit('G');
            AccountStatus::H:
                exit('H');
            AccountStatus::J:
                exit('J');
            AccountStatus::K:
                exit('K');
            AccountStatus::L:
                exit('L');
            AccountStatus::M:
                exit('M');
            AccountStatus::N:
                exit('N');
            AccountStatus::P:
                exit('P');
            else
                exit('A'); // Default to Active if not specified
        end;
    end;
}