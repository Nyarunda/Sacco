codeunit 50140 "MCRB API Integration"
{
    Subtype = Normal;

    trigger OnRun()
    var
        myInt: Integer;
    begin

    end;

    // Main procedure to process any report and submit the body to your Django app.

    procedure ProcessReportOld(LoanNo: Code[20]; MemberNo: Code[20]; RequestID: Integer; ReportType: Enum "CRB Report Type"; IdentityNumber: Text; IdentityType: Text; LoanAmount: Decimal; ReportReason: Integer; MobileScore: Boolean)
    var
        delinquency_code: text;
        ToFile: text;
        FileMan: Codeunit "File Management";
        pdfInStream: InStream;
        ReportTypeInt: Integer;
        Content: HttpContent;
        contentHeaders: HttpHeaders;
        HttpResponseMessage: HttpResponseMessage;
        HttpRequestMessage: HttpRequestMessage;
        HttpClient: HttpClient;
        JsonObject: JsonObject;
        ResponseJsonObj: JsonObject;
        RequestJson: Text;
        ResponseJson: Text;
        Timestamp: Text;
        APIKey: Text;
        PrivateKey: Text;
        Hash: Text;
        BaseUrl: Text;
        Endpoint: Text;
        IsSuccessful: Boolean;
        PdfToken: JsonToken;
        JsonToken: JsonToken;
        has_error: Boolean;
        api_code_description: Text;
        api_code: Text;
        IntegrationLog: Record "MCRB Integration Log";
        ResponseText: Text;

        PdfBase64: Text;
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        pdfOutstream: OutStream;
        SaccoSetup: Record "Sacco Setup";
    begin

        SaccoSetup.Get();
        SaccoSetup.TestField("Metropol Base URL");

        if ReportType = ReportType::"Identity Verification" then
            ReportTypeInt := 1
        else if ReportType = ReportType::"Delinquency Status" then
            ReportTypeInt := 2
        else if ReportType = ReportType::"Credit Score" then
            ReportTypeInt := 3
        else if ReportType = ReportType::"PDF Report" then
            ReportTypeInt := 4
        else if ReportType = ReportType::"JSON Report" then
            ReportTypeInt := 5
        else if ReportType = ReportType::"Identity Scrub" then
            ReportTypeInt := 6
        else if ReportType = ReportType::"Credit Info" then
            ReportTypeInt := 8
        else if ReportType = ReportType::"Enhanced Credit Info" then
            ReportTypeInt := 10
        else if ReportType = ReportType::"Enhanced Credit Info Mobile" then
            ReportTypeInt := 11
        else if ReportType = ReportType::"Full Enhanced Credit Info" then
            ReportTypeInt := 12
        else if ReportType = ReportType::"Minified Credit Info" then
            ReportTypeInt := 13
        else if ReportType = ReportType::"Full JSON Report" then
            ReportTypeInt := 14
        else if ReportType = ReportType::"Credit Accounts Summary" then
            ReportTypeInt := 16
        else if ReportType = ReportType::"Accounts Info History" then
            ReportTypeInt := 22;

        // Determine the correct endpoint based on report type using the enum values.
        case ReportType of
            ReportType::"Identity Verification":
                Endpoint := 'identity/verify';
            ReportType::"Delinquency Status":
                Endpoint := 'delinquency/status';
            ReportType::"Credit Score":
                Endpoint := 'score/consumer';
            ReportType::"PDF Report":
                Endpoint := 'report/pdf';
            ReportType::"JSON Report":
                Endpoint := 'report/json';
            ReportType::"Identity Scrub":
                Endpoint := 'identity/scrub';
            ReportType::"Credit Info":
                Endpoint := 'report/credit_info';
            ReportType::"Enhanced Credit Info":
                Endpoint := 'report/credit_info_enhanced';
            ReportType::"Enhanced Credit Info Mobile":
                Endpoint := 'report/creditinfo/mobile';
            // For report types that share the same endpoint, use the same string.
            ReportType::"Full Enhanced Credit Info":
                Endpoint := 'report/credit_info';
            ReportType::"Minified Credit Info":
                Endpoint := 'report/credit_info';
            ReportType::"Full JSON Report":
                Endpoint := 'report/json';
            ReportType::"Credit Accounts Summary":
                Endpoint := 'report/credit_info';
            ReportType::"Accounts Info History":
                Endpoint := 'report/credit_info';
            else
                Error('Unsupported report type');
        end;

        // Build the timestamp as required (YYYYMMDDHHMMSSmmm)
        Timestamp := Format(CurrentDateTime(), 0);  // Adjust formatting as needed

        // Build JSON request payload using AL's JSON objects.
        Clear(JsonObject);
        JsonObject.Add('endpoint', Endpoint);
        // Use ReportTypeInt in the JSON payload.Clear(JsonObject);
        JsonObject.Add('report_type', ReportTypeInt);  // Numeric value starting at 1
        JsonObject.Add('identity_number', IdentityNumber);
        JsonObject.Add('identity_type', IdentityType);

        case ReportType of
            //ReportType::"Identity Verification",
            //ReportType::"Identity Scrub":
            // No additional fields required.
            ReportType::"Delinquency Status":
                JsonObject.Add('loan_amount', LoanAmount);
            ReportType::"Credit Score":
                // For Metro score, mobile_score is optional. We add it with a default of false.
                JsonObject.Add('mobile_score', MobileScore);
            ReportType::"PDF Report",
            ReportType::"JSON Report":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;
            ReportType::"Credit Info":
                begin

                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;
            ReportType::"Enhanced Credit Info":
                begin
                    // application_ref_no is optional – default as empty string.
                    //JsonObject.Add('application_ref_no', '');
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;
            ReportType::"Enhanced Credit Info Mobile":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;
            ReportType::"Full Enhanced Credit Info":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;
            ReportType::"Minified Credit Info":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;
            ReportType::"Full JSON Report":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;
            ReportType::"Credit Accounts Summary":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;
            ReportType::"Accounts Info History":
                begin
                    // For Accounts Info History, application_ref_no is optional.
                    //JsonObject.Add('application_ref_no', '');
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;
        end;

        // Write the JSON object to a text variable.
        JsonObject.WriteTo(RequestJson);

        // Create a new StringContent from the JSON text.
        Content.WriteFrom(RequestJson);
        Content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');

        // Set the HTTP request method to POST and the request URI to your Django app.
        HttpRequestMessage.Method := 'POST';
        //HttpRequestMessage.SetRequestUri(SaccoSetup."Metropol Base URL" + '/crb/referencing/');
        HttpRequestMessage.SetRequestUri('http://172.20.10.10:2100/crb/referencing/');
        HttpRequestMessage.Content := Content;

        // Generate hash using the formula: SHA256(PrivateKey + RequestJson + APIKey + Timestamp)
        Hash := Sha256Hash(PrivateKey + RequestJson + APIKey + Timestamp);

        // Add required headers as per CRB API documentation.
        /*
        HttpRequestMessage.GetHeaders().Add('X-METROPOL-REST-API-KEY', APIKey);
        HttpRequestMessage.GetHeaders().Add('X-METROPOL-REST-API-HASH', Hash);
        HttpRequestMessage.GetHeaders().Add('X-METROPOL-REST-API-TIMESTAMP', Timestamp);
        */

        // Log the outgoing request.
        IntegrationLog.Init();
        IntegrationLog.LoanNo := LoanNo;
        IntegrationLog.MemberNo := MemberNo;
        IntegrationLog.RequestID := RequestID;
        IntegrationLog."ReportType" := ReportType;
        IntegrationLog."RequestTimestamp" := CurrentDateTime();
        IntegrationLog."RequestJSON" := RequestJson;
        IntegrationLog."ProcessingStatus" := IntegrationLog."ProcessingStatus"::Pending;
        IntegrationLog.Insert(true);

        IsSuccessful := HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        HttpResponseMessage.Content.ReadAs(ResponseText);
        //

        //Message(ResponseText);

        if IsSuccessful then begin
            HttpResponseMessage.Content().ReadAs(ResponseJson);


            if not ResponseJsonObj.ReadFrom(ResponseJson) then
                Error('Invalid JSON response');

            has_error := false;

            IF ResponseJsonObj.Get('has_error', JsonToken) then
                has_error := JsonToken.AsValue().AsBoolean();

            IF ResponseJsonObj.Get('api_code_description', JsonToken) THEN
                api_code_description := JsonToken.AsValue().AsText();

            IF ResponseJsonObj.Get('api_code', JsonToken) then
                api_code := JsonToken.AsValue().AsText();


            delinquency_code := '';
            IF ResponseJsonObj.Get('delinquency_code', JsonToken) then begin

                delinquency_code := JsonToken.AsValue().AsText();


            end;



            if has_error then begin
                Message(api_code_description);
            end
            else begin

                // Check if the "pdf_report" tag exists
                if ResponseJsonObj.SelectToken('pdf_credit_info', PdfToken) then begin
                    PdfBase64 := PdfToken.AsValue().AsText();
                    IntegrationLog.calcfields(CreditInfoPDFReport);
                    IntegrationLog.CreditInfoPDFReport.CreateOutStream(pdfOutstream);
                    Base64Convert.FromBase64(PdfBase64, pdfOutstream);
                    ResponseJsonObj.Remove('pdf_credit_info');
                    ResponseJsonObj.WriteTo(ResponseJson);

                    // Open the PDF by first creating an InStream from the blob field.
                    IntegrationLog.CreditInfoPDFReport.CreateInStream(pdfInStream);
                    if not FileMan.DownloadFromStreamHandler(pdfInStream,
                                                    'Open PDF Report',
                                                    '',                    // Folder: leave blank to use default
                                                    'PDF Files|*.pdf',     // Filter string: adjust as needed
                                                    'Report.pdf') then      // The file name for the PDF
                        Error('Failed to open PDF report.');


                end;

                // Check if the "pdf_report" tag exists
                if ResponseJsonObj.SelectToken('pdf_credit_info_enhanced', PdfToken) then begin
                    PdfBase64 := PdfToken.AsValue().AsText();
                    IntegrationLog.calcfields(CreditInfoEnhancedPDFReport);
                    IntegrationLog.CreditInfoEnhancedPDFReport.CreateOutStream(pdfOutstream);
                    Base64Convert.FromBase64(PdfBase64, pdfOutstream);
                    ResponseJsonObj.Remove('pdf_credit_info_enhanced');
                    ResponseJsonObj.WriteTo(ResponseJson);

                    // Open the PDF by first creating an InStream from the blob field.
                    IntegrationLog.CreditInfoEnhancedPDFReport.CreateInStream(pdfInStream);
                    if not FileMan.DownloadFromStreamHandler(pdfInStream,
                                                    'Open PDF Report',
                                                    '',                    // Folder: leave blank to use default
                                                    'PDF Files|*.pdf',     // Filter string: adjust as needed
                                                    'Report.pdf') then      // The file name for the PDF
                        Error('Failed to open PDF report.');


                end;


                // Check if the "pdf_report" tag exists
                if ResponseJsonObj.SelectToken('pdf_json_report', PdfToken) then begin
                    PdfBase64 := PdfToken.AsValue().AsText();
                    IntegrationLog.calcfields(JsonPDFReport);
                    IntegrationLog.JsonPDFReport.CreateOutStream(pdfOutstream);
                    Base64Convert.FromBase64(PdfBase64, pdfOutstream);
                    ResponseJsonObj.Remove('pdf_json_report');
                    ResponseJsonObj.WriteTo(ResponseJson);

                    // Open the PDF by first creating an InStream from the blob field.
                    IntegrationLog.JsonPDFReport.CreateInStream(pdfInStream);
                    if not FileMan.DownloadFromStreamHandler(pdfInStream,
                                                    'Open PDF Report',
                                                    '',                    // Folder: leave blank to use default
                                                    'PDF Files|*.pdf',     // Filter string: adjust as needed
                                                    'Report.pdf') then      // The file name for the PDF
                        Error('Failed to open PDF report.');


                end;

                // Check if the "pdf_report" tag exists
                if ResponseJsonObj.SelectToken('pdf_identity', PdfToken) then begin
                    PdfBase64 := PdfToken.AsValue().AsText();
                    IntegrationLog.calcfields(IdentityPDFReport);
                    IntegrationLog.IdentityPDFReport.CreateOutStream(pdfOutstream);
                    Base64Convert.FromBase64(PdfBase64, pdfOutstream);
                    ResponseJsonObj.Remove('pdf_identity');
                    ResponseJsonObj.WriteTo(ResponseJson);

                    // Open the PDF by first creating an InStream from the blob field.
                    IntegrationLog.IdentityPDFReport.CreateInStream(pdfInStream);
                    if not FileMan.DownloadFromStreamHandler(pdfInStream,
                                                    'Open PDF Report',
                                                    '',                    // Folder: leave blank to use default
                                                    'PDF Files|*.pdf',     // Filter string: adjust as needed
                                                    'Report.pdf') then      // The file name for the PDF
                        Error('Failed to open PDF report.');


                end;

                // Check if the "pdf_report" tag exists
                if ResponseJsonObj.SelectToken('pdf_full_json_report', PdfToken) then begin
                    PdfBase64 := PdfToken.AsValue().AsText();
                    IntegrationLog.calcfields(FullJsonPDFReport);
                    IntegrationLog.FullJsonPDFReport.CreateOutStream(pdfOutstream);
                    Base64Convert.FromBase64(PdfBase64, pdfOutstream);
                    ResponseJsonObj.Remove('pdf_full_json_report');
                    ResponseJsonObj.WriteTo(ResponseJson);

                    // Open the PDF by first creating an InStream from the blob field.
                    IntegrationLog.FullJsonPDFReport.CreateInStream(pdfInStream);
                    if not FileMan.DownloadFromStreamHandler(pdfInStream,
                                                    'Open PDF Report',
                                                    '',                    // Folder: leave blank to use default
                                                    'PDF Files|*.pdf',     // Filter string: adjust as needed
                                                    'Report.pdf') then      // The file name for the PDF
                        Error('Failed to open PDF report.');


                end;

                // Check if the "pdf_report" tag exists
                if ResponseJsonObj.SelectToken('pdf_credit_summary', PdfToken) then begin
                    PdfBase64 := PdfToken.AsValue().AsText();
                    IntegrationLog.calcfields(CreditSummaryPDFReport);
                    IntegrationLog.CreditSummaryPDFReport.CreateOutStream(pdfOutstream);
                    Base64Convert.FromBase64(PdfBase64, pdfOutstream);
                    ResponseJsonObj.Remove('pdf_credit_summary');
                    ResponseJsonObj.WriteTo(ResponseJson);

                    // Open the PDF by first creating an InStream from the blob field.
                    IntegrationLog.CreditSummaryPDFReport.CreateInStream(pdfInStream);
                    if not FileMan.DownloadFromStreamHandler(pdfInStream,
                                                    'Open PDF Report',
                                                    '',                    // Folder: leave blank to use default
                                                    'PDF Files|*.pdf',     // Filter string: adjust as needed
                                                    'Report.pdf') then      // The file name for the PDF
                        Error('Failed to open PDF report.');


                end;

                // Check if the "pdf_report" tag exists
                if ResponseJsonObj.SelectToken('pdf_identity_scrub', PdfToken) then begin
                    PdfBase64 := PdfToken.AsValue().AsText();
                    IntegrationLog.calcfields(IdentityScrubPDFReport);
                    IntegrationLog.IdentityScrubPDFReport.CreateOutStream(pdfOutstream);
                    Base64Convert.FromBase64(PdfBase64, pdfOutstream);
                    ResponseJsonObj.Remove('pdf_identity_scrub');
                    ResponseJsonObj.WriteTo(ResponseJson);

                    // Open the PDF by first creating an InStream from the blob field.
                    IntegrationLog.IdentityScrubPDFReport.CreateInStream(pdfInStream);
                    if not FileMan.DownloadFromStreamHandler(pdfInStream,
                                                    'Open PDF Report',
                                                    '',                    // Folder: leave blank to use default
                                                    'PDF Files|*.pdf',     // Filter string: adjust as needed
                                                    'Report.pdf') then      // The file name for the PDF
                        Error('Failed to open PDF report.');


                end;

                // Check if the "pdf_report" tag exists
                if ResponseJsonObj.SelectToken('pdf_creditinfo_mobile', PdfToken) then begin
                    PdfBase64 := PdfToken.AsValue().AsText();
                    IntegrationLog.calcfields(CreditinfoMobilePDFReport);
                    IntegrationLog.CreditinfoMobilePDFReport.CreateOutStream(pdfOutstream);
                    Base64Convert.FromBase64(PdfBase64, pdfOutstream);
                    ResponseJsonObj.Remove('pdf_creditinfo_mobile');
                    ResponseJsonObj.WriteTo(ResponseJson);

                    // Open the PDF by first creating an InStream from the blob field.
                    IntegrationLog.CreditinfoMobilePDFReport.CreateInStream(pdfInStream);
                    if not FileMan.DownloadFromStreamHandler(pdfInStream,
                                                    'Open PDF Report',
                                                    '',                    // Folder: leave blank to use default
                                                    'PDF Files|*.pdf',     // Filter string: adjust as needed
                                                    'Report.pdf') then      // The file name for the PDF
                        Error('Failed to open PDF report.');


                end;

                // Check if the "pdf_report" tag exists
                if ResponseJsonObj.SelectToken('pdf_full_enhancedcredit_info', PdfToken) then begin
                    PdfBase64 := PdfToken.AsValue().AsText();
                    IntegrationLog.calcfields(FullEnhancedCreditinfoPDF);
                    IntegrationLog.FullEnhancedCreditinfoPDF.CreateOutStream(pdfOutstream);
                    Base64Convert.FromBase64(PdfBase64, pdfOutstream);
                    ResponseJsonObj.Remove('pdf_full_enhancedcredit_info');
                    ResponseJsonObj.WriteTo(ResponseJson);

                    // Open the PDF by first creating an InStream from the blob field.
                    IntegrationLog.FullEnhancedCreditinfoPDF.CreateInStream(pdfInStream);
                    if not FileMan.DownloadFromStreamHandler(pdfInStream,
                                                    'Open PDF Report',
                                                    '',                    // Folder: leave blank to use default
                                                    'PDF Files|*.pdf',     // Filter string: adjust as needed
                                                    'Report.pdf') then      // The file name for the PDF
                        Error('Failed to open PDF report.');


                end;

                // Check if the "pdf_report" tag exists
                if ResponseJsonObj.SelectToken('pdf_account_history', PdfToken) then begin
                    PdfBase64 := PdfToken.AsValue().AsText();
                    IntegrationLog.calcfields(AccountHistoryPDFReport);
                    IntegrationLog.AccountHistoryPDFReport.CreateOutStream(pdfOutstream);
                    Base64Convert.FromBase64(PdfBase64, pdfOutstream);
                    ResponseJsonObj.Remove('pdf_account_history');
                    ResponseJsonObj.WriteTo(ResponseJson);

                    // Open the PDF by first creating an InStream from the blob field.
                    IntegrationLog.AccountHistoryPDFReport.CreateInStream(pdfInStream);
                    if not FileMan.DownloadFromStreamHandler(pdfInStream,
                                                    'Open PDF Report',
                                                    '',                    // Folder: leave blank to use default
                                                    'PDF Files|*.pdf',     // Filter string: adjust as needed
                                                    'Report.pdf') then      // The file name for the PDF
                        Error('Failed to open PDF report.');


                end;

                IntegrationLog."CRB Status Code" := delinquency_code;
                if delinquency_code = '001' then
                    IntegrationLog."CRB Status Description" := 'Identity not found - ID number not found in the database';
                if delinquency_code = '002' then
                    IntegrationLog."CRB Status Description" := 'No account information - ID number has been found but it has no credit information';
                if delinquency_code = '003' then
                    IntegrationLog."CRB Status Description" := 'No delinquency - ID number has credit info with no NPA';
                if delinquency_code = '004' then
                    IntegrationLog."CRB Status Description" := 'Currently delinquent - True - ID number has credit information with at least one current NPA';
                if delinquency_code = '005' then
                    IntegrationLog."CRB Status Description" := 'Historical delinquency - True - ID number has credit information with at least one historical NPA';

                IntegrationLog."ResponseTimestamp" := CurrentDateTime();
                IntegrationLog."ResponseJSON" := CopyStr(ResponseJson, 1, 2024);
                IntegrationLog."HTTPStatusCode" := HttpResponseMessage.HttpStatusCode();
                IntegrationLog."ProcessingStatus" := IntegrationLog."ProcessingStatus"::Success;
                IntegrationLog.Modify();

            end;
        end else begin
            Message('Response: %1', ResponseText);
            IntegrationLog."ResponseTimestamp" := CurrentDateTime();
            IntegrationLog."ErrorMessage" := 'HTTP request failed';
            IntegrationLog."ProcessingStatus" := IntegrationLog."ProcessingStatus"::Failed;
            IntegrationLog.Modify();
            Error('HTTP request failed');
        end;

        // Process the response based on report type using the enum.
        ProcessResponse(ReportType, ResponseJson);
    end;



    procedure ProcessReport(
 LoanNo: Code[20];
 MemberNo: Code[20];
 RequestID: Integer;
 ReportType: Enum "CRB Report Type";
 IdentityNumber: Text;
 IdentityType: Text;
 LoanAmount: Decimal;
 ReportReason: Integer;
 MobileScore: Boolean)
    var
        delinquency_code: Text;
        ToFile: Text;
        FileMan: Codeunit "File Management";
        pdfInStream: InStream;
        ReportTypeInt: Integer;
        Content: HttpContent;
        contentHeaders: HttpHeaders;
        HttpResponseMessage: HttpResponseMessage;
        HttpRequestMessage: HttpRequestMessage;
        HttpClient: HttpClient;
        JsonObject: JsonObject;
        ResponseJsonObj: JsonObject;
        RequestJson: Text;
        ResponseJson: Text;
        Timestamp: Text;
        APIKey: Text;
        PrivateKey: Text;
        Hash: Text;
        BaseUrl: Text;
        Endpoint: Text;
        IsSuccessful: Boolean;
        PdfToken: JsonToken;
        JsonToken: JsonToken;
        has_error: Boolean;
        api_code_description: Text;
        api_code: Text;
        IntegrationLog: Record "MCRB Integration Log";
        ResponseText: Text;
        OutFileName: Text;
        PdfBase64: Text;
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        pdfOutstream: OutStream;
    begin

        // ---------------------------------------------------------
        // DETERMINE REPORT TYPE INTEGER
        // ---------------------------------------------------------
        if ReportType = ReportType::"Identity Verification" then
            ReportTypeInt := 1
        else if ReportType = ReportType::"Delinquency Status" then
            ReportTypeInt := 2
        else if ReportType = ReportType::"Credit Score" then
            ReportTypeInt := 3
        else if ReportType = ReportType::"PDF Report" then
            ReportTypeInt := 4
        else if ReportType = ReportType::"JSON Report" then
            ReportTypeInt := 5
        else if ReportType = ReportType::"Identity Scrub" then
            ReportTypeInt := 6
        else if ReportType = ReportType::"Credit Info" then
            ReportTypeInt := 8
        else if ReportType = ReportType::"Enhanced Credit Info" then
            ReportTypeInt := 10
        else if ReportType = ReportType::"Enhanced Credit Info Mobile" then
            ReportTypeInt := 11
        else if ReportType = ReportType::"Full Enhanced Credit Info" then
            ReportTypeInt := 12
        else if ReportType = ReportType::"Minified Credit Info" then
            ReportTypeInt := 13
        else if ReportType = ReportType::"Full JSON Report" then
            ReportTypeInt := 14
        else if ReportType = ReportType::"Credit Accounts Summary" then
            ReportTypeInt := 16
        else if ReportType = ReportType::"Accounts Info History" then
            ReportTypeInt := 22;


        // ---------------------------------------------------------
        // DETERMINE ENDPOINT
        // ---------------------------------------------------------
        case ReportType of

            ReportType::"Identity Verification":
                Endpoint := 'identity/verify';

            ReportType::"Delinquency Status":
                Endpoint := 'delinquency/status';

            ReportType::"Credit Score":
                Endpoint := 'score/consumer';

            ReportType::"PDF Report":
                Endpoint := 'report/pdf';

            ReportType::"JSON Report":
                Endpoint := 'report/json';

            ReportType::"Identity Scrub":
                Endpoint := 'identity/scrub';

            ReportType::"Credit Info":
                Endpoint := 'report/credit_info';

            ReportType::"Enhanced Credit Info":
                Endpoint := 'report/credit_info_enhanced';

            ReportType::"Enhanced Credit Info Mobile":
                Endpoint := 'report/creditinfo/mobile';

            ReportType::"Full Enhanced Credit Info":
                Endpoint := 'report/credit_info';

            ReportType::"Minified Credit Info":
                Endpoint := 'report/credit_info';

            ReportType::"Full JSON Report":
                Endpoint := 'report/json';

            ReportType::"Credit Accounts Summary":
                Endpoint := 'report/credit_info';

            ReportType::"Accounts Info History":
                Endpoint := 'report/credit_info';

            else
                Error('Unsupported report type');
        end;


        // ---------------------------------------------------------
        // TIMESTAMP
        // ---------------------------------------------------------
        Timestamp := Format(CurrentDateTime(), 0);


        // ---------------------------------------------------------
        // CREATE JSON REQUEST
        // ---------------------------------------------------------
        Clear(JsonObject);

        JsonObject.Add('endpoint', Endpoint);
        JsonObject.Add('report_type', ReportTypeInt);
        JsonObject.Add('identity_number', IdentityNumber);
        JsonObject.Add('identity_type', IdentityType);


        case ReportType of

            ReportType::"Delinquency Status":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                end;

            ReportType::"Credit Score":
                begin
                    JsonObject.Add('mobile_score', MobileScore);
                end;

            ReportType::"PDF Report",
            ReportType::"JSON Report":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;

            ReportType::"Credit Info":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;

            ReportType::"Enhanced Credit Info":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;

            ReportType::"Enhanced Credit Info Mobile":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;

            ReportType::"Full Enhanced Credit Info":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;

            ReportType::"Minified Credit Info":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;

            ReportType::"Full JSON Report":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;

            ReportType::"Credit Accounts Summary":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;

            ReportType::"Accounts Info History":
                begin
                    JsonObject.Add('loan_amount', LoanAmount);
                    JsonObject.Add('report_reason', ReportReason);
                end;

        end;


        // ---------------------------------------------------------
        // CONVERT JSON OBJECT TO TEXT
        // ---------------------------------------------------------
        Clear(RequestJson);
        JsonObject.WriteTo(RequestJson);


        // ---------------------------------------------------------
        // INITIALIZE HTTP CONTENT
        // ---------------------------------------------------------
        Clear(Content);

        Content.WriteFrom(RequestJson);

        Content.GetHeaders(contentHeaders);

        contentHeaders.Clear();

        contentHeaders.Add(
            'Content-Type',
            'application/json'
        );


        // ---------------------------------------------------------
        // BUILD HTTP REQUEST
        // ---------------------------------------------------------
        Clear(HttpRequestMessage);

        HttpRequestMessage.Method := 'POST';

        // HttpRequestMessage.SetRequestUri(
        //     'http://192.168.60.150:8401/crb/referencing/'
        // );
        HttpRequestMessage.SetRequestUri(
           'http://172.20.10.10:2100/crb/referencing/'
       );

        HttpRequestMessage.Content := Content;


        // ---------------------------------------------------------
        // GENERATE HASH
        // ---------------------------------------------------------
        Hash :=
            Sha256Hash(
                PrivateKey +
                RequestJson +
                APIKey +
                Timestamp
            );


        // ---------------------------------------------------------
        // API HEADERS
        // Uncomment if the middleware requires them
        // ---------------------------------------------------------

        /*
        HttpRequestMessage.GetHeaders().Add(
            'X-METROPOL-REST-API-KEY',
            APIKey
        );

        HttpRequestMessage.GetHeaders().Add(
            'X-METROPOL-REST-API-HASH',
            Hash
        );

        HttpRequestMessage.GetHeaders().Add(
            'X-METROPOL-REST-API-TIMESTAMP',
            Timestamp
        );
        */


        // ---------------------------------------------------------
        // CREATE INTEGRATION LOG
        // ---------------------------------------------------------
        IntegrationLog.Init();

        IntegrationLog.LoanNo := LoanNo;
        IntegrationLog.MemberNo := MemberNo;
        IntegrationLog.RequestID := RequestID;
        IntegrationLog."ReportType" := ReportType;
        IntegrationLog."RequestTimestamp" := CurrentDateTime();

        IntegrationLog."RequestJSON" :=
            CopyStr(
                RequestJson,
                1,
                MaxStrLen(IntegrationLog."RequestJSON")
            );

        IntegrationLog."ProcessingStatus" :=
            IntegrationLog."ProcessingStatus"::Pending;

        IntegrationLog.Insert(true);


        // ---------------------------------------------------------
        // SEND HTTP REQUEST
        // ---------------------------------------------------------
        Clear(HttpResponseMessage);

        IsSuccessful :=
            HttpClient.Send(
                HttpRequestMessage,
                HttpResponseMessage
            );


        // ---------------------------------------------------------
        // IMPORTANT:
        // DO NOT READ HttpResponseMessage.Content
        // UNTIL Send() HAS SUCCEEDED
        // ---------------------------------------------------------
        if not IsSuccessful then begin

            IntegrationLog."ResponseTimestamp" :=
                CurrentDateTime();

            IntegrationLog."ErrorMessage" :=
                CopyStr(
                    'Unable to send HTTP request to CRB middleware',
                    1,
                    MaxStrLen(IntegrationLog."ErrorMessage")
                );

            IntegrationLog."ProcessingStatus" :=
                IntegrationLog."ProcessingStatus"::Failed;

            IntegrationLog.Modify();

            Error(
                'Unable to connect to CRB middleware at %1. Please confirm that the middleware is running and reachable from Business Central.',
                'http://172.20.10.10:2100/crb/referencing/'
            );

        end;


        // ---------------------------------------------------------
        // READ HTTP RESPONSE
        // Send() has succeeded, therefore Content is available
        // ---------------------------------------------------------
        Clear(ResponseJson);

        HttpResponseMessage.Content.ReadAs(ResponseJson);


        // ---------------------------------------------------------
        // EMPTY RESPONSE
        // ---------------------------------------------------------
        if ResponseJson = '' then begin

            IntegrationLog."ResponseTimestamp" :=
                CurrentDateTime();

            IntegrationLog."HTTPStatusCode" :=
                HttpResponseMessage.HttpStatusCode();

            IntegrationLog."ErrorMessage" :=
                CopyStr(
                    'CRB middleware returned an empty response',
                    1,
                    MaxStrLen(IntegrationLog."ErrorMessage")
                );

            IntegrationLog."ProcessingStatus" :=
                IntegrationLog."ProcessingStatus"::Failed;

            IntegrationLog.Modify();

            Error(
                'CRB middleware returned an empty response. HTTP Status: %1',
                HttpResponseMessage.HttpStatusCode()
            );

        end;


        // ---------------------------------------------------------
        // HTTP ERROR STATUS
        // ---------------------------------------------------------
        if not HttpResponseMessage.IsSuccessStatusCode() then begin

            IntegrationLog."ResponseTimestamp" :=
                CurrentDateTime();

            IntegrationLog."HTTPStatusCode" :=
                HttpResponseMessage.HttpStatusCode();

            IntegrationLog."ResponseJSON" :=
                CopyStr(
                    ResponseJson,
                    1,
                    MaxStrLen(IntegrationLog."ResponseJSON")
                );

            IntegrationLog."ErrorMessage" :=
                CopyStr(
                    StrSubstNo(
                        'HTTP %1 - %2',
                        HttpResponseMessage.HttpStatusCode(),
                        ResponseJson
                    ),
                    1,
                    MaxStrLen(IntegrationLog."ErrorMessage")
                );

            IntegrationLog."ProcessingStatus" :=
                IntegrationLog."ProcessingStatus"::Failed;

            IntegrationLog.Modify();

            Error(
                'CRB API returned HTTP Status %1\Response: %2',
                HttpResponseMessage.HttpStatusCode(),
                ResponseJson
            );

        end;


        // ---------------------------------------------------------
        // PARSE JSON RESPONSE
        // ---------------------------------------------------------
        Clear(ResponseJsonObj);

        if not ResponseJsonObj.ReadFrom(ResponseJson) then begin

            IntegrationLog."ResponseTimestamp" :=
                CurrentDateTime();

            IntegrationLog."HTTPStatusCode" :=
                HttpResponseMessage.HttpStatusCode();

            IntegrationLog."ResponseJSON" :=
                CopyStr(
                    ResponseJson,
                    1,
                    MaxStrLen(IntegrationLog."ResponseJSON")
                );

            IntegrationLog."ErrorMessage" :=
                CopyStr(
                    'Invalid JSON response received from CRB middleware',
                    1,
                    MaxStrLen(IntegrationLog."ErrorMessage")
                );

            IntegrationLog."ProcessingStatus" :=
                IntegrationLog."ProcessingStatus"::Failed;

            IntegrationLog.Modify();

            Error(
                'Invalid JSON response received from CRB middleware\Response: %1',
                ResponseJson
            );

        end;


        // ---------------------------------------------------------
        // READ RESPONSE FIELDS
        // ---------------------------------------------------------
        has_error := false;
        api_code_description := '';
        api_code := '';
        delinquency_code := '';


        if ResponseJsonObj.Get('has_error', JsonToken) then
            has_error :=
                JsonToken.AsValue().AsBoolean();


        if ResponseJsonObj.Get(
            'api_code_description',
            JsonToken
        ) then
            api_code_description :=
                JsonToken.AsValue().AsText();


        if ResponseJsonObj.Get(
            'api_code',
            JsonToken
        ) then
            api_code :=
                JsonToken.AsValue().AsText();


        if ResponseJsonObj.Get(
            'delinquency_code',
            JsonToken
        ) then
            delinquency_code :=
                JsonToken.AsValue().AsText();


        // ---------------------------------------------------------
        // CRB API RETURNED ERROR
        // ---------------------------------------------------------
        if has_error then begin

            IntegrationLog."ResponseTimestamp" :=
                CurrentDateTime();

            IntegrationLog."HTTPStatusCode" :=
                HttpResponseMessage.HttpStatusCode();

            IntegrationLog."ResponseJSON" :=
                CopyStr(
                    ResponseJson,
                    1,
                    MaxStrLen(IntegrationLog."ResponseJSON")
                );

            IntegrationLog."ErrorMessage" :=
                CopyStr(
                    StrSubstNo(
                        '%1 - %2',
                        api_code,
                        api_code_description
                    ),
                    1,
                    MaxStrLen(IntegrationLog."ErrorMessage")
                );

            IntegrationLog."ProcessingStatus" :=
                IntegrationLog."ProcessingStatus"::Failed;

            IntegrationLog.Modify();

            Error(
                'CRB Error %1: %2',
                api_code,
                api_code_description
            );

        end;


        // ---------------------------------------------------------
        // CREDIT INFO PDF
        // ---------------------------------------------------------
        if ResponseJsonObj.SelectToken(
            'pdf_credit_info',
            PdfToken
        ) then begin

            PdfBase64 :=
                PdfToken.AsValue().AsText();

            IntegrationLog.CalcFields(
                CreditInfoPDFReport
            );

            IntegrationLog.CreditInfoPDFReport.CreateOutStream(
                pdfOutstream
            );

            Base64Convert.FromBase64(
                PdfBase64,
                pdfOutstream
            );

            ResponseJsonObj.Remove(
                'pdf_credit_info'
            );

            Clear(ResponseJson);
            ResponseJsonObj.WriteTo(ResponseJson);

            IntegrationLog.CreditInfoPDFReport.CreateInStream(
                pdfInStream
            );

            OutFileName := 'Report.pdf';

            if not DownloadFromStream(
                pdfInStream,
                'Open PDF Report',
                '',
                'PDF Files|*.pdf',
                OutFileName
            ) then
                Error('Failed to open PDF report.');

        end;


        // ---------------------------------------------------------
        // ENHANCED CREDIT INFO PDF
        // ---------------------------------------------------------
        if ResponseJsonObj.SelectToken(
            'pdf_credit_info_enhanced',
            PdfToken
        ) then begin

            PdfBase64 :=
                PdfToken.AsValue().AsText();

            IntegrationLog.CalcFields(
                CreditInfoEnhancedPDFReport
            );

            IntegrationLog.CreditInfoEnhancedPDFReport.CreateOutStream(
                pdfOutstream
            );

            Base64Convert.FromBase64(
                PdfBase64,
                pdfOutstream
            );

            ResponseJsonObj.Remove(
                'pdf_credit_info_enhanced'
            );

            Clear(ResponseJson);
            ResponseJsonObj.WriteTo(ResponseJson);

            IntegrationLog.CreditInfoEnhancedPDFReport.CreateInStream(
                pdfInStream
            );

            OutFileName := 'Report.pdf';

            if not DownloadFromStream(
                pdfInStream,
                'Open PDF Report',
                '',
                'PDF Files|*.pdf',
                OutFileName
            ) then
                Error('Failed to open PDF report.');

        end;


        // ---------------------------------------------------------
        // JSON REPORT PDF
        // ---------------------------------------------------------
        if ResponseJsonObj.SelectToken(
            'pdf_json_report',
            PdfToken
        ) then begin

            PdfBase64 :=
                PdfToken.AsValue().AsText();

            IntegrationLog.CalcFields(
                JsonPDFReport
            );

            IntegrationLog.JsonPDFReport.CreateOutStream(
                pdfOutstream
            );

            Base64Convert.FromBase64(
                PdfBase64,
                pdfOutstream
            );

            ResponseJsonObj.Remove(
                'pdf_json_report'
            );

            Clear(ResponseJson);
            ResponseJsonObj.WriteTo(ResponseJson);

            IntegrationLog.JsonPDFReport.CreateInStream(
                pdfInStream
            );

            OutFileName := 'Report.pdf';

            if not DownloadFromStream(
                pdfInStream,
                'Open PDF Report',
                '',
                'PDF Files|*.pdf',
                OutFileName
            ) then
                Error('Failed to open PDF report.');

        end;


        // ---------------------------------------------------------
        // IDENTITY PDF
        // ---------------------------------------------------------
        if ResponseJsonObj.SelectToken(
            'pdf_identity',
            PdfToken
        ) then begin

            PdfBase64 :=
                PdfToken.AsValue().AsText();

            IntegrationLog.CalcFields(
                IdentityPDFReport
            );

            IntegrationLog.IdentityPDFReport.CreateOutStream(
                pdfOutstream
            );

            Base64Convert.FromBase64(
                PdfBase64,
                pdfOutstream
            );

            ResponseJsonObj.Remove(
                'pdf_identity'
            );

            Clear(ResponseJson);
            ResponseJsonObj.WriteTo(ResponseJson);

            IntegrationLog.IdentityPDFReport.CreateInStream(
                pdfInStream
            );

            OutFileName := 'Report.pdf';

            if not DownloadFromStream(
                pdfInStream,
                'Open PDF Report',
                '',
                'PDF Files|*.pdf',
                OutFileName
            ) then
                Error('Failed to open PDF report.');

        end;


        // ---------------------------------------------------------
        // FULL JSON REPORT PDF
        // ---------------------------------------------------------
        if ResponseJsonObj.SelectToken(
            'pdf_full_json_report',
            PdfToken
        ) then begin

            PdfBase64 :=
                PdfToken.AsValue().AsText();

            IntegrationLog.CalcFields(
                FullJsonPDFReport
            );

            IntegrationLog.FullJsonPDFReport.CreateOutStream(
                pdfOutstream
            );

            Base64Convert.FromBase64(
                PdfBase64,
                pdfOutstream
            );

            ResponseJsonObj.Remove(
                'pdf_full_json_report'
            );

            Clear(ResponseJson);
            ResponseJsonObj.WriteTo(ResponseJson);

            IntegrationLog.FullJsonPDFReport.CreateInStream(
                pdfInStream
            );

            OutFileName := 'Report.pdf';

            if not DownloadFromStream(
                pdfInStream,
                'Open PDF Report',
                '',
                'PDF Files|*.pdf',
                OutFileName
            ) then
                Error('Failed to open PDF report.');

        end;


        // ---------------------------------------------------------
        // CREDIT SUMMARY PDF
        // ---------------------------------------------------------
        if ResponseJsonObj.SelectToken(
            'pdf_credit_summary',
            PdfToken
        ) then begin

            PdfBase64 :=
                PdfToken.AsValue().AsText();

            IntegrationLog.CalcFields(
                CreditSummaryPDFReport
            );

            IntegrationLog.CreditSummaryPDFReport.CreateOutStream(
                pdfOutstream
            );

            Base64Convert.FromBase64(
                PdfBase64,
                pdfOutstream
            );

            ResponseJsonObj.Remove(
                'pdf_credit_summary'
            );

            Clear(ResponseJson);
            ResponseJsonObj.WriteTo(ResponseJson);

            IntegrationLog.CreditSummaryPDFReport.CreateInStream(
                pdfInStream
            );

            OutFileName := 'Report.pdf';

            if not DownloadFromStream(
                pdfInStream,
                'Open PDF Report',
                '',
                'PDF Files|*.pdf',
                OutFileName
            ) then
                Error('Failed to open PDF report.');

        end;


        // ---------------------------------------------------------
        // IDENTITY SCRUB PDF
        // ---------------------------------------------------------
        if ResponseJsonObj.SelectToken(
            'pdf_identity_scrub',
            PdfToken
        ) then begin

            PdfBase64 :=
                PdfToken.AsValue().AsText();

            IntegrationLog.CalcFields(
                IdentityScrubPDFReport
            );

            IntegrationLog.IdentityScrubPDFReport.CreateOutStream(
                pdfOutstream
            );

            Base64Convert.FromBase64(
                PdfBase64,
                pdfOutstream
            );

            ResponseJsonObj.Remove(
                'pdf_identity_scrub'
            );

            Clear(ResponseJson);
            ResponseJsonObj.WriteTo(ResponseJson);

            IntegrationLog.IdentityScrubPDFReport.CreateInStream(
                pdfInStream
            );

            OutFileName := 'Report.pdf';

            if not DownloadFromStream(
                pdfInStream,
                'Open PDF Report',
                '',
                'PDF Files|*.pdf',
                OutFileName
            ) then
                Error('Failed to open PDF report.');

        end;


        // ---------------------------------------------------------
        // MOBILE CREDIT INFO PDF
        // ---------------------------------------------------------
        if ResponseJsonObj.SelectToken(
            'pdf_creditinfo_mobile',
            PdfToken
        ) then begin

            PdfBase64 :=
                PdfToken.AsValue().AsText();

            IntegrationLog.CalcFields(
                CreditinfoMobilePDFReport
            );

            IntegrationLog.CreditinfoMobilePDFReport.CreateOutStream(
                pdfOutstream
            );

            Base64Convert.FromBase64(
                PdfBase64,
                pdfOutstream
            );

            ResponseJsonObj.Remove(
                'pdf_creditinfo_mobile'
            );

            Clear(ResponseJson);
            ResponseJsonObj.WriteTo(ResponseJson);

            IntegrationLog.CreditinfoMobilePDFReport.CreateInStream(
                pdfInStream
            );

            OutFileName := 'Report.pdf';

            if not DownloadFromStream(
                pdfInStream,
                'Open PDF Report',
                '',
                'PDF Files|*.pdf',
                OutFileName
            ) then
                Error('Failed to open PDF report.');

        end;


        // ---------------------------------------------------------
        // FULL ENHANCED CREDIT INFO PDF
        // ---------------------------------------------------------
        if ResponseJsonObj.SelectToken(
            'pdf_full_enhancedcredit_info',
            PdfToken
        ) then begin

            PdfBase64 :=
                PdfToken.AsValue().AsText();

            IntegrationLog.CalcFields(
                FullEnhancedCreditinfoPDF
            );

            IntegrationLog.FullEnhancedCreditinfoPDF.CreateOutStream(
                pdfOutstream
            );

            Base64Convert.FromBase64(
                PdfBase64,
                pdfOutstream
            );

            ResponseJsonObj.Remove(
                'pdf_full_enhancedcredit_info'
            );

            Clear(ResponseJson);
            ResponseJsonObj.WriteTo(ResponseJson);

            IntegrationLog.FullEnhancedCreditinfoPDF.CreateInStream(
                pdfInStream
            );

            OutFileName := 'Report.pdf';

            if not DownloadFromStream(
                pdfInStream,
                'Open PDF Report',
                '',
                'PDF Files|*.pdf',
                OutFileName
            ) then
                Error('Failed to open PDF report.');

        end;


        // ---------------------------------------------------------
        // ACCOUNT HISTORY PDF
        // ---------------------------------------------------------
        if ResponseJsonObj.SelectToken(
            'pdf_account_history',
            PdfToken
        ) then begin

            PdfBase64 :=
                PdfToken.AsValue().AsText();

            IntegrationLog.CalcFields(
                AccountHistoryPDFReport
            );

            IntegrationLog.AccountHistoryPDFReport.CreateOutStream(
                pdfOutstream
            );

            Base64Convert.FromBase64(
                PdfBase64,
                pdfOutstream
            );

            ResponseJsonObj.Remove(
                'pdf_account_history'
            );

            Clear(ResponseJson);
            ResponseJsonObj.WriteTo(ResponseJson);

            IntegrationLog.AccountHistoryPDFReport.CreateInStream(
                pdfInStream
            );

            OutFileName := 'Report.pdf';

            if not DownloadFromStream(
                pdfInStream,
                'Open PDF Report',
                '',
                'PDF Files|*.pdf',
                OutFileName
            ) then
                Error('Failed to open PDF report.');

        end;


        // ---------------------------------------------------------
        // SET DELINQUENCY STATUS
        // ---------------------------------------------------------
        IntegrationLog."CRB Status Code" :=
            delinquency_code;


        case delinquency_code of

            '001':
                IntegrationLog."CRB Status Description" :=
                    'Identity not found - ID number not found in the database';

            '002':
                IntegrationLog."CRB Status Description" :=
                    'No account information - ID number has been found but it has no credit information';

            '003':
                IntegrationLog."CRB Status Description" :=
                    'No delinquency - ID number has credit info with no NPA';

            '004':
                IntegrationLog."CRB Status Description" :=
                    'Currently delinquent - True - ID number has credit information with at least one current NPA';

            '005':
                IntegrationLog."CRB Status Description" :=
                    'Historical delinquency - True - ID number has credit information with at least one historical NPA';

        end;


        // ---------------------------------------------------------
        // UPDATE SUCCESSFUL INTEGRATION LOG
        // ---------------------------------------------------------
        IntegrationLog."ResponseTimestamp" :=
            CurrentDateTime();

        IntegrationLog."ResponseJSON" :=
            CopyStr(
                ResponseJson,
                1,
                MaxStrLen(IntegrationLog."ResponseJSON")
            );

        IntegrationLog."HTTPStatusCode" :=
            HttpResponseMessage.HttpStatusCode();

        IntegrationLog."ProcessingStatus" :=
            IntegrationLog."ProcessingStatus"::Success;

        IntegrationLog.Modify();


        // ---------------------------------------------------------
        // PROCESS RESPONSE
        // ---------------------------------------------------------
        ProcessResponse(
            ReportType,
            ResponseJson
        );

    end;


    // Generate SHA-256 hash using Cryptography Management codeunit.
    local procedure Sha256Hash(ClearText: Text): Text
    var
        CryptographyManagement: Codeunit "Cryptography Management";
        HashAlgorithmType: Option MD5,SHA1,SHA256,SHA384,SHA512;
    begin
        exit(Text.LowerCase(CryptographyManagement.GenerateHash(ClearText, HashAlgorithmType::SHA256)));
    end;

    // Dispatch the response JSON to the correct parser based on report type.
    local procedure ProcessResponse(ReportType: Enum "CRB Report Type"; ResponseJson: Text)
    begin
        case ReportType of
            ReportType::"Identity Verification":
                ProcessIdentityVerification(ResponseJson);
            ReportType::"Delinquency Status":
                ProcessDelinquencyStatus(ResponseJson);
            ReportType::"Credit Score":
                ProcessCreditScore(ResponseJson);
            ReportType::"PDF Report":
                ProcessPDFReport(ResponseJson);
            ReportType::"JSON Report":
                ProcessJSONReport(ResponseJson);
            ReportType::"Identity Scrub":
                ProcessIdentityScrub(ResponseJson);
            ReportType::"Credit Info":
                ProcessCreditInfo(ResponseJson);
            ReportType::"Enhanced Credit Info":
                ProcessEnhancedCreditInfo(ResponseJson);
            ReportType::"Enhanced Credit Info Mobile":
                ProcessEnhancedCreditInfoMobile(ResponseJson);
            ReportType::"Full Enhanced Credit Info":
                ProcessFullEnhancedCreditInfo(ResponseJson);
            ReportType::"Minified Credit Info":
                ProcessMinifiedCreditInfo(ResponseJson);
            ReportType::"Full JSON Report":
                ProcessFullJSONReport(ResponseJson);
            ReportType::"Credit Accounts Summary":
                ProcessCreditAccountsSummary(ResponseJson);
            ReportType::"Accounts Info History":
                ProcessAccountsInfoHistory(ResponseJson);
            else
                Error('Unsupported report type');
        end;
    end;

    // Sample stub procedure to process Identity Verification (report type 1).
    procedure ProcessIdentityVerification(ResponseJson: Text)
    var
        JsonObj: JsonObject;
        FirstName, LastName, identity_number : Text;
        IdentityRec: Record "MCRB Identity Info";
    begin
        if not JsonObj.ReadFrom(ResponseJson) then
            Error('Invalid JSON Input');
        FirstName := SelectJsonToken(JsonObj, '$.first_name').AsValue.AsText();
        LastName := SelectJsonToken(JsonObj, '$.last_name').AsValue.AsText();
        identity_number := SelectJsonToken(JsonObj, '$.identity_number').AsValue.AsText();
        if (FirstName <> '') and (LastName <> '') then begin
            IdentityRec.Init();
            IdentityRec."IdentityNumber" := identity_number;
            IdentityRec."FirstName" := FirstName;
            IdentityRec."LastName" := LastName;
            IdentityRec.Insert(true);
        end;
    end;

    // The following procedures are stubs. Expand these to parse the expected JSON responses
    // for each report type and update the appropriate tables.
    procedure ProcessDelinquencyStatus(ResponseJson: Text)
    var
        JsonObj: JsonObject;
        DelinquencyCode: Text;
        DelinquencySummary: Text;
        IdentityNumber: Text;
        LoanAmount: Decimal;
        TrxID: Text;
        JsonToken: JsonToken;
    begin
        if not JsonObj.ReadFrom(ResponseJson) then
            Error('Invalid JSON input for Delinquency Status.');

        // Extract fields from the JSON response
        JsonObj.Get('delinquency_code', JsonToken);
        DelinquencyCode := JsonToken.AsValue().AsText();

        JsonObj.Get('delinquency_summary', JsonToken);
        DelinquencySummary := JsonToken.AsValue().AsText();

        JsonObj.Get('identity_number', JsonToken);
        IdentityNumber := JsonToken.AsValue().AsText();

        JsonObj.Get('loan_amount', JsonToken);
        LoanAmount := JsonToken.AsValue().AsDecimal();

        JsonObj.Get('trx_id', JsonToken);
        TrxID := JsonToken.AsValue().AsText();


        // For demonstration, display a message with the parsed information.
        Message('Delinquency Status Processed: %1\Code: %2 \Summary: %3 \Identity: %4 \Loan: %5 \TRX: %6',
            '', DelinquencyCode, DelinquencySummary, IdentityNumber, Format(LoanAmount), TrxID);

        // TODO: Replace the Message with logic to update your database or further process the data.
    end;


    procedure ProcessCreditScore(ResponseJson: Text)
    var
        category: Text;
        credit_score: Text;
        IdentityNumber: Text;
        JsonObj: JsonObject;
        LoanAmount: Decimal;
        TrxID: Text;
        JsonToken: JsonToken;
    begin
        if not JsonObj.ReadFrom(ResponseJson) then
            Error('Invalid JSON input for Delinquency Status.');

        // Extract fields from the JSON response
        JsonObj.Get('category', JsonToken);
        category := JsonToken.AsValue().AsText();

        JsonObj.Get('credit_score', JsonToken);
        credit_score := JsonToken.AsValue().AsText();

        JsonObj.Get('identity_number', JsonToken);
        IdentityNumber := JsonToken.AsValue().AsText();


        JsonObj.Get('trx_id', JsonToken);
        TrxID := JsonToken.AsValue().AsText();


        // For demonstration, display a message with the parsed information.
        Message('Credit Score: %1\category: %2 \Credit Score: %3 \Identity: %4 \TRX: %6',
            '', category, credit_score, IdentityNumber, TrxID);

    end;

    procedure ProcessPDFReport(ResponseJson: Text)
    begin
        // Process the PDF report (e.g., decode Base64 data) and store or attach the PDF file.
    end;

    procedure ProcessJSONReport(ResponseJson: Text)
    begin
        // Parse the JSON credit report; populate account details, etc.
    end;

    procedure ProcessIdentityScrub(ResponseJson: Text)
    begin
        // Parse scrub data and update MCRB Identity Info table.
    end;

    procedure ProcessCreditInfo(ResponseJson: Text)
    begin
        // Parse detailed credit info and update MCRB Account Detail table.
    end;

    procedure ProcessEnhancedCreditInfo(ResponseJson: Text)
    begin
        // Parse enhanced credit info (including guarantor and stakeholder details).
    end;

    procedure ProcessEnhancedCreditInfoMobile(ResponseJson: Text)
    begin
        // Parse mobile credit info response with income estimation.
    end;

    procedure ProcessFullEnhancedCreditInfo(ResponseJson: Text)
    begin
        // Parse the full enhanced report combining identity, scrub, credit info, score trend, etc.
    end;

    procedure ProcessMinifiedCreditInfo(ResponseJson: Text)
    var
        category: Text;
        credit_score: Text;
        IdentityNumber: Text;
        JsonObj: JsonObject;
        outstanding_balance: Decimal;
        TrxID: Text;
        JsonToken: JsonToken;
        days_in_arrears: Integer;
        negative_his_indicator: integer;
        npl_flag: Integer;
    begin
        if not JsonObj.ReadFrom(ResponseJson) then
            Error('Invalid JSON input for Delinquency Status.');

        // Extract fields from the JSON response
        JsonObj.Get('days_in_arrears', JsonToken);
        days_in_arrears := JsonToken.AsValue().AsInteger();

        JsonObj.Get('negative_his_indicator', JsonToken);
        negative_his_indicator := JsonToken.AsValue().AsInteger();


        JsonObj.Get('npl_flag', JsonToken);
        npl_flag := JsonToken.AsValue().AsInteger();

        JsonObj.Get('outstanding_balance', JsonToken);
        outstanding_balance := JsonToken.AsValue().AsDecimal();


        JsonObj.Get('identity_number', JsonToken);
        IdentityNumber := JsonToken.AsValue().AsText();


        JsonObj.Get('trx_id', JsonToken);
        TrxID := JsonToken.AsValue().AsText();


        // For demonstration, display a message with the parsed information.
        Message('Minified Credit infor: %1\Days in Arrears: %2 \Negative his Indicator: %3 \NPL Flag: %4\Outstanding Balance: %5 \Identity: %6 \TRX: %7',
            '', days_in_arrears, negative_his_indicator, npl_flag, outstanding_balance, IdentityNumber, TrxID);

    end;

    procedure ProcessFullJSONReport(ResponseJson: Text)
    begin
        // Parse the full JSON report response.
    end;

    procedure ProcessCreditAccountsSummary(ResponseJson: Text)
    begin
        // Parse and process the credit accounts summary response.
    end;

    procedure ProcessAccountsInfoHistory(ResponseJson: Text)
    begin
        // Parse and process the accounts info history response.
    end;

    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: Text) JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;

    local procedure SelectJsonToken(JsonObject: JsonObject; Path: Text) JsonToken: JsonToken;
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('Could not find a token with path %1', Path);
    end;


}
