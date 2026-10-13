

codeunit 50133 SMSDispatcher
{

    SingleInstance = false;
    Subtype = Normal;

    trigger OnRun()
    var
        SkySMS: record "SMS Messages";
        AllowedCompanyName: Text[50];
        ActiveSession: Record "Active Session";
        SaccoSetup: Record "Sacco Setup";
        ServerName: Text[100];
        j: Integer;
    begin

        /*
        AllowedCompanyName := 'United Women Regulated Non-WDT';
        if COMPANYNAME <> AllowedCompanyName then begin
            Error('This codeunit can only be executed in the company: %1.', AllowedCompanyName);
            exit;
        end;

        ServerName := '';

        ActiveSession.Reset();
        ActiveSession.SetRange("Session ID", SessionId());
        if ActiveSession.FindFirst() then
            ServerName := ActiveSession."Server Computer Name";

        if ServerName <> 'Prod000001' then
            exit;
        */



        for j := 1 to 15 do begin
            SkySMS.Reset();
            SkySMS.SetRange("Sent To Server", SkySMS."Sent To Server"::No);
            SkySMS.SetRange(Posted, false);
            SkySMS.SetRange(Source, SkySMS.Source::PIN);
            if SkySMS.FindSet() then
                repeat
                    SendOtp(SkySMS."SMS ID");
                until SkySMS.next = 0;


            SkySMS.Reset();
            SkySMS.SetRange("Sent To Server", SkySMS."Sent To Server"::No);
            SkySMS.SetRange(Posted, false);
            SkySMS.SetFilter(Source, '<>%1', SkySMS.Source::PIN);
            if SkySMS.FindSet() then
                repeat
                    SendSMS(SkySMS."SMS ID");
                until SkySMS.next = 0;

            Sleep(3000);
        end;
    end;

    procedure SendSMS(transID: Integer)
    var
        SMSMessageRec: Record "SMS Messages";
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        HttpRequestMessage: HttpRequestMessage;
        ResponseText: Text;
        URL: Text;
        PassKey: Text;
        ClientID: Text;
        Sender: Text;
        ServiceID: Text;
        PhoneNumber: Text;
        Message: Text;
        ResponseParts: List of [Text];
        Status: Text;
        j: integer;
        RespToken: JsonToken;
        ResponsesArray: JsonArray;
        RespElemToken: JsonToken;
        PropToken: JsonToken;
        RespItem: JsonObject;
        RespCode: Integer;
        RespDesc: Text;
        RespMessageId: Text;
        SaccoSetup: Record "Sacco Setup";
        JsonObject: JsonObject;
        JsonText: Text;
        Content: HttpContent;
        contentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        ApiKey: Text; //Label '08b091238c1ed15980b222d512d9a5cf';
        AllowedCompanyName: Text[50];
        ActiveSession: Record "Active Session";
        ServerName: Text[100];

    begin

        /*
        ServerName := '';
        ActiveSession.Reset();
        ActiveSession.SetRange("User ID", UserId);
        ActiveSession.SetRange("Session ID", SessionId());
        if ActiveSession.FindFirst() then
            ServerName := ActiveSession."Server Computer Name";

        if ServerName <> 'Prod000001' then
            exit;


        AllowedCompanyName := 'United Women Regulated Non-WDT';
        if COMPANYNAME <> AllowedCompanyName then begin
            exit;
        end;
        */


        SaccoSetup.get;
        SaccoSetup.TestField("Spot SMS PassKey");

        ApiKey := SaccoSetup."Spot SMS PassKey";

        ClientID := SaccoSetup."Spot SMS ClientID"; // Replace with your actual Client ID
        PassKey := ApiKey; // Replace with your actual Pass Key
        Sender := SaccoSetup."Spot SMS Sender"; // Replace with your actual sender name
        ServiceID := SaccoSetup."Spot SMS ClientID"; // Service ID for sending 

        // Filter unsent messages
        SMSMessageRec.Reset();
        if transID <> 0 then
            SMSMessageRec.SetRange("SMS ID", transID);
        SMSMessageRec.SetFilter(Source, '<>%1', SMSMessageRec.Source::PIN);
        SMSMessageRec.SetRange(Posted, false);
        SMSMessageRec.SetRange("Sent To Server", SMSMessageRec."Sent To Server"::No);
        if SMSMessageRec.FindSet() then begin
            j := 0;
            repeat
                j += 1;
                PhoneNumber := SMSMessageRec."Mobile Phone No.";
                Message := SMSMessageRec."SMS Message";
                Clear(JsonObject);

                // Build the JSON object for the request body
                JsonObject.Add('apikey', PassKey);
                JsonObject.Add('partnerID', ServiceID);
                JsonObject.Add('message', Message);
                JsonObject.Add('shortcode', Sender);
                JsonObject.Add('mobile', PhoneNumber);

                // Write the JSON object to a text variable
                JsonObject.WriteTo(JsonText);

                // Create a new StringContent from the JSON text
                Content.WriteFrom(JsonText);

                Content.GetHeaders(contentHeaders); // Pass HttpHeaders object
                contentHeaders.Clear();
                contentHeaders.Add('Content-Type', 'application/json'); // Set Content-Type

                // Set the HTTP request method to POST
                HttpRequestMessage.Method := 'POST';

                // Set the request URI
                HttpRequestMessage.SetRequestUri('https://quicksms.advantasms.com/api/services/sendsms/');

                // Add the request content (JSON body)
                HttpRequestMessage.Content := Content;

                SMSMessageRec.Posted := true;
                SMSMessageRec.Modify();
                IsSuccessful := HttpClient.Send(HttpRequestMessage, HttpResponseMessage);


                // Check for 200 OK
                if HttpResponseMessage.HttpStatusCode = 200 then begin
                    Commit();
                    // Read and display the response content
                    HttpResponseMessage.Content.ReadAs(ResponseText);

                end
                // Check for 422 Unprocessable Entity
                else if HttpResponseMessage.HttpStatusCode = 422 then begin

                    HttpResponseMessage.Content.ReadAs(ResponseText);
                    SMSMessageRec.Posted := false;
                    SMSMessageRec."Sent To Server" := SMSMessageRec."sent to server"::Failed;
                    SMSMessageRec.Remark := CopyStr(StrSubstNo('Error 422: Unprocessable Entity. Details: %1', ResponseText), 1, MaxStrLen(SMSMessageRec.Remark));
                    SMSMessageRec.Modify();
                    //Error('Error 422: Unprocessable Entity. Details: %1', ResponseText);
                end else begin

                    HttpResponseMessage.Content.ReadAs(ResponseText);
                    SMSMessageRec.Posted := false;
                    SMSMessageRec."Sent To Server" := SMSMessageRec."sent to server"::Failed;
                    SMSMessageRec.Remark := CopyStr(StrSubstNo('Failed to send POST request. Status code: %1. Details: %2', HttpResponseMessage.HttpStatusCode, ResponseText), 1, MaxStrLen(SMSMessageRec.Remark));
                    SMSMessageRec.Modify();
                    //Error('Failed to send POST request. Status code: %1', HttpResponseMessage.HttpStatusCode);
                end;

                // Parse the JSON response (expected structure: {"responses":[{...}]})
                // Example: {"responses":[{"response-code":200,"response-description":"Success","mobile":254734617961,"messageid":"226879805","networkid":2}]}
                // We try to read the first element of the "responses" array and use response-code/response-description
                if JsonObject.ReadFrom(ResponseText) then begin
                    if JsonObject.Get('responses', RespToken) then begin
                        ResponsesArray := RespToken.AsArray();
                        // initialize
                        RespDesc := '';
                        RespCode := 0;
                        RespMessageId := '';
                        // take first element (if any)
                        foreach RespElemToken in ResponsesArray do begin
                            RespItem := RespElemToken.AsObject();
                            if RespItem.Get('response-description', PropToken) then
                                RespDesc := PropToken.AsValue().AsText();
                            if RespItem.Get('response-code', PropToken) then
                                RespCode := PropToken.AsValue().AsInteger();
                            if RespItem.Get('messageid', PropToken) then
                                RespMessageId := PropToken.AsValue().AsText();
                            // we only need the first element
                            break;
                        end;

                        // Consider success when description is 'Success' or code is 200
                        if (RespDesc = 'Success') or (RespCode = 200) then begin
                            SMSMessageRec."Sent To Server" := SMSMessageRec."Sent To Server"::Yes;

                        end else begin
                            SMSMessageRec."Sent To Server" := SMSMessageRec."Sent To Server"::Failed;

                        end;

                        // Store the full response and optionally the provider message id
                        SMSMessageRec.Remark := CopyStr(ResponseText, 1, 1000);
                        if RespMessageId <> '' then
                            SMSMessageRec.ResponseID := RespMessageId;
                    end else
                        SMSMessageRec.Remark := 'Invalid Response (no responses array): ' + ResponseText;
                end else
                    SMSMessageRec.Remark := 'Invalid JSON Response: ' + ResponseText;

                SMSMessageRec.Modify();
                Commit();
                j += 1;

            until (SMSMessageRec.Next() = 0) or (j > 500);
        end;
    end;

    local procedure URLEncode(Value: Text): Text
    var
    //httpUtility: DotNet HttpUtility;
    begin
        // exit(httpUtility.Urlencode(Value));
    end;

    local procedure SplitResponse(ResponseText: Text; var ResponseParts: List of [Text]): Boolean
    begin
        Clear(ResponseParts);
        // Split the response into phone number and status
        ResponseParts.Add(ExtractSubstring(ResponseText, 1, '|'));
        ResponseParts.Add(ExtractSubstring(ResponseText, 2, '|'));
        exit(ResponseParts.Count() = 2);
    end;

    local procedure ExtractSubstring(SourceText: Text; Index: Integer; Delimiter: Char): Text
    var
        SubText: Text;
        CurrentPos: Integer;
        StartPos: Integer;
        DelimiterCount: Integer;
    begin
        CurrentPos := 1;
        StartPos := 1;
        DelimiterCount := 0;
        SubText := '';

        while CurrentPos <= StrLen(SourceText) do begin
            if SourceText[CurrentPos] = Delimiter then begin
                DelimiterCount += 1;
                if DelimiterCount = Index - 1 then
                    StartPos := CurrentPos + 1;
                if DelimiterCount = Index then begin
                    SubText := CopyStr(SourceText, StartPos, CurrentPos - StartPos);
                    break;
                end;
            end;
            CurrentPos += 1;
        end;

        if SubText = '' then
            SubText := CopyStr(SourceText, StartPos, StrLen(SourceText) - StartPos + 1);

        exit(SubText);
    end;


    procedure SendInstantSMS(Source: Enum "SMS Source Enum"; Telephone: Text[200]; Textsms: Text;
                                  Reference: Text[30];
                                  AccNo: Text[30];
                                  Chargeable: Boolean;
                                  Priority: Integer;
                                  ChargeMember: Boolean)
    var
        SMSMessageRec: Record "SMS Messages";
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
        PassKey: Text;
        ClientID: Text;
        Sender: Text;
        ServiceID: Text;
        Message: Text;
        ResponseParts: List of [Text];
        Status: Text;
        j: integer;
        SaccoSetup: Record "Sacco Setup";
        JsonObject: JsonObject;
        JsonText: Text;
        Content: HttpContent;
        contentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        HttpRequestMessage: HttpRequestMessage;
        ApiKey: Label '4708eb61e38d1c48cbe9210792c91a5d';
        MAct: Codeunit "Member Activities";
    begin

        SaccoSetup.get;

        SaccoSetup.TestField("Spot SMS PassKey");

        PassKey := SaccoSetup."Spot SMS PassKey";
        ClientID := SaccoSetup."Spot SMS ClientID"; // Replace with your actual Client ID
        Sender := SaccoSetup."Spot SMS Sender"; // Replace with your actual sender name
        ServiceID := SaccoSetup."Spot SMS ClientID"; // Service ID for sending 


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




        SMSMessageRec.Init;
        //SMSMessageRec."SMS ID" := CREATEGUID;
        SMSMessageRec.Source := Source;
        SMSMessageRec."Mobile Phone No." := MAct.Replacestring(Telephone, '-', '+');
        SMSMessageRec."Date Entered" := Today;
        SMSMessageRec."Time Entered" := Time;
        SMSMessageRec."Entered By" := UserId;
        SMSMessageRec."SMS Message" := Textsms;

        if ((StrLen(Telephone) >= 9) and (StrLen(Telephone) <= 13)) then begin
            SMSMessageRec."Sent To Server" := SMSMessageRec."sent to server"::No;
        end else begin
            SMSMessageRec."Sent To Server" := SMSMessageRec."sent to server"::Failed;
        end;

        SMSMessageRec."Document No" := Reference;
        SMSMessageRec."Account No" := AccNo;
        SMSMessageRec.IsChargeable := Chargeable;
        SMSMessageRec."Post to Loan Penalty" := false;
        SMSMessageRec.Posted := false;
        SMSMessageRec.Insert;

        if SMSMessageRec.Insert() then begin
            Commit();

            if Source = Source::PIN then
                SendOtp(SMSMessageRec."SMS ID")
            else
                SendSMS(SMSMessageRec."SMS ID");
        end;


    end;


    procedure SendOtp(transID: Integer)
    var
        SMSMessageRec: Record "SMS Messages";
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        HttpRequestMessage: HttpRequestMessage;
        ResponseText: Text;
        URL: Text;
        PassKey: Text;
        ClientID: Text;
        Sender: Text;
        ServiceID: Text;
        PhoneNumber: Text;
        Message: Text;
        ResponseParts: List of [Text];
        Status: Text;
        j: integer;
        RespToken: JsonToken;
        ResponsesArray: JsonArray;
        RespElemToken: JsonToken;
        PropToken: JsonToken;
        RespItem: JsonObject;
        RespCode: Integer;
        RespDesc: Text;
        RespMessageId: Text;
        SaccoSetup: Record "Sacco Setup";
        JsonObject: JsonObject;
        JsonText: Text;
        Content: HttpContent;
        contentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        ApiKey: Text; //Label '08b091238c1ed15980b222d512d9a5cf';
        AllowedCompanyName: Text[50];
        ActiveSession: Record "Active Session";
        ServerName: Text[100];

    begin


        /*
        ServerName := '';
        ActiveSession.Reset();
        ActiveSession.SetRange("User ID", UserId);
        ActiveSession.SetRange("Session ID", SessionId());
        if ActiveSession.FindFirst() then
            ServerName := ActiveSession."Server Computer Name";

        if ServerName <> 'Prod000001' then
            exit;


        AllowedCompanyName := 'United Women Regulated Non-WDT';
        if COMPANYNAME <> AllowedCompanyName then begin
            exit;
        end;
        */


        SaccoSetup.get;

        PassKey := SaccoSetup."Spot SMS PassKey";
        ClientID := SaccoSetup."Spot SMS ClientID"; // Replace with your actual Client ID
        Sender := SaccoSetup."Spot SMS Sender"; // Replace with your actual sender name
        ServiceID := SaccoSetup."Spot SMS ClientID"; // Service ID for sending 
        ApiKey := PassKey;


        // Filter unsent messages
        SMSMessageRec.Reset();
        if transID <> 0 then
            SMSMessageRec.SetRange("SMS ID", transID);
        SMSMessageRec.SetRange(Source, SMSMessageRec.Source::PIN);
        SMSMessageRec.SetRange(Posted, false);
        SMSMessageRec.SetRange("Sent To Server", SMSMessageRec."Sent To Server"::No);
        if SMSMessageRec.FindSet() then begin
            j := 0;
            repeat
                j += 1;
                PhoneNumber := SMSMessageRec."Mobile Phone No.";
                Message := SMSMessageRec."SMS Message";
                Clear(JsonObject);

                // Build the JSON object for the request body
                JsonObject.Add('apikey', PassKey);
                JsonObject.Add('partnerID', ServiceID);
                JsonObject.Add('message', Message);
                JsonObject.Add('shortcode', Sender);
                JsonObject.Add('mobile', PhoneNumber);

                // Write the JSON object to a text variable
                JsonObject.WriteTo(JsonText);

                // Create a new StringContent from the JSON text
                Content.WriteFrom(JsonText);

                Content.GetHeaders(contentHeaders); // Pass HttpHeaders object
                contentHeaders.Clear();
                contentHeaders.Add('Content-Type', 'application/json'); // Set Content-Type

                // Set the HTTP request method to POST
                HttpRequestMessage.Method := 'POST';

                // Set the request URI
                HttpRequestMessage.SetRequestUri('https://quicksms.advantasms.com/api/services/sendotp/');

                // Add the request content (JSON body)
                HttpRequestMessage.Content := Content;

                SMSMessageRec.Posted := true;
                SMSMessageRec.Modify();
                IsSuccessful := HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
                //tests

                // Check for 200 OK
                if HttpResponseMessage.HttpStatusCode = 200 then begin
                    Commit();
                    // Read and display the response content
                    HttpResponseMessage.Content.ReadAs(ResponseText);

                end
                // Check for 422 Unprocessable Entity
                else if HttpResponseMessage.HttpStatusCode = 422 then begin

                    HttpResponseMessage.Content.ReadAs(ResponseText);
                    SMSMessageRec.Posted := false;
                    SMSMessageRec.Remark := CopyStr(StrSubstNo('Error 422: Unprocessable Entity. Details: %1', ResponseText), 1, MaxStrLen(SMSMessageRec.Remark));
                    SMSMessageRec.Modify();

                end else begin

                    HttpResponseMessage.Content.ReadAs(ResponseText);
                    SMSMessageRec.Posted := false;
                    SMSMessageRec.Remark := CopyStr(StrSubstNo('Failed to send POST request. Status code: %1. Details: %2', HttpResponseMessage.HttpStatusCode, ResponseText), 1, MaxStrLen(SMSMessageRec.Remark));
                    SMSMessageRec.Modify();
                end;

                // Parse the JSON response (expected structure: {"responses":[{...}]})
                // Example: {"responses":[{"response-code":200,"response-description":"Success","mobile":254734617961,"messageid":"226879805","networkid":2}]}
                // We try to read the first element of the "responses" array and use response-code/response-description
                if JsonObject.ReadFrom(ResponseText) then begin
                    if JsonObject.Get('responses', RespToken) then begin
                        ResponsesArray := RespToken.AsArray();
                        // initialize
                        RespDesc := '';
                        RespCode := 0;
                        RespMessageId := '';
                        // take first element (if any)
                        foreach RespElemToken in ResponsesArray do begin
                            RespItem := RespElemToken.AsObject();
                            if RespItem.Get('response-description', PropToken) then
                                RespDesc := PropToken.AsValue().AsText();
                            if RespItem.Get('response-code', PropToken) then
                                RespCode := PropToken.AsValue().AsInteger();
                            if RespItem.Get('messageid', PropToken) then
                                RespMessageId := PropToken.AsValue().AsText();
                            // we only need the first element
                            break;
                        end;

                        // Consider success when description is 'Success' or code is 200
                        if (RespDesc = 'Success') or (RespCode = 200) then begin
                            SMSMessageRec."Sent To Server" := SMSMessageRec."Sent To Server"::Yes;
                        end else begin
                            SMSMessageRec."Sent To Server" := SMSMessageRec."Sent To Server"::No;
                        end;

                        // Store the full response and optionally the provider message id
                        SMSMessageRec.Remark := CopyStr(ResponseText, 1, 1000);
                        if RespMessageId <> '' then
                            SMSMessageRec.ResponseID := RespMessageId;
                    end else
                        SMSMessageRec.Remark := 'Invalid Response (no responses array): ' + ResponseText;
                end else
                    SMSMessageRec.Remark := 'Invalid JSON Response: ' + ResponseText;

                SMSMessageRec.Modify();
                Commit();
                j += 1;

            until (SMSMessageRec.Next() = 0) or (j > 500);
        end;
    end;











    procedure SendBulkSMS(transID: Integer)
    var
        SMSMessageRec: Record "SMS Messages";
        SMSMessageRec2: Record "SMS Messages";
        SaccoSetup: Record "Sacco Setup";
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Content: HttpContent;
        contentHeaders: HttpHeaders;
        BatchArray: JsonArray;
        SmsItem: JsonObject;
        RequestObj: JsonObject;
        JsonText: Text;
        ResponseText: Text;
        PassKey: Text;
        ClientID: Text;
        Sender: Text;
        ServiceID: Text;
        BatchCount: Integer;
        TotalInBatch: Integer;
        RespRoot: JsonObject;
        RespToken: JsonToken;
        ResponsesArray: JsonArray;
        RespElemToken: JsonToken;
        RespItem: JsonObject;
        PropToken: JsonToken;
        RespClientSmsId: Text;
        RespCode: Integer;
        RespDesc: Text;
        RespMessageId: Text;
        MaxBatchSize: Integer;
        IsSuccessful: Boolean;
        BatchSMSIds: List of [Integer];
        i: Integer;
    begin
        exit; // temporary disable until we can test it in production

        MaxBatchSize := 20;

        SaccoSetup.Get();
        SaccoSetup.TestField("Spot SMS PassKey");

        PassKey := SaccoSetup."Spot SMS PassKey";
        ClientID := SaccoSetup."Spot SMS ClientID";
        Sender := SaccoSetup."Spot SMS Sender";
        ServiceID := SaccoSetup."Spot SMS ClientID";

        SMSMessageRec.Reset();
        if transID <> 0 then
            SMSMessageRec.SetRange("SMS ID", transID);
        SMSMessageRec.SetRange(Posted, false);
        SMSMessageRec.SetRange("Sent To Server", SMSMessageRec."Sent To Server"::No);

        if not SMSMessageRec.FindSet() then
            exit;

        repeat
            // ---- Build one batch of up to MaxBatchSize messages ----
            Clear(BatchArray);
            Clear(BatchSMSIds);
            TotalInBatch := 0;

            repeat
                Clear(SmsItem);
                SmsItem.Add('partnerID', ServiceID);
                SmsItem.Add('apikey', PassKey);
                SmsItem.Add('pass_type', 'plain');
                SmsItem.Add('clientsmsid', Format(SMSMessageRec."SMS ID"));
                SmsItem.Add('mobile', SMSMessageRec."Mobile Phone No.");
                SmsItem.Add('message', SMSMessageRec."SMS Message");
                SmsItem.Add('shortcode', Sender);

                BatchArray.Add(SmsItem);
                BatchSMSIds.Add(SMSMessageRec."SMS ID");

                // mark as posted/in-flight so a re-run mid-batch doesn't re-pick it up
                SMSMessageRec.Posted := true;
                SMSMessageRec.Modify();

                TotalInBatch += 1;
            until (TotalInBatch >= MaxBatchSize) or (SMSMessageRec.Next() = 0);

            Commit();

            // ---- Build request body ----
            Clear(RequestObj);
            Clear(JsonText);
            RequestObj.Add('count', TotalInBatch);
            RequestObj.Add('smslist', BatchArray);
            RequestObj.WriteTo(JsonText);

            Clear(Content);
            Content.WriteFrom(JsonText);
            Content.GetHeaders(contentHeaders);
            contentHeaders.Clear();
            contentHeaders.Add('Content-Type', 'application/json');

            Clear(HttpRequestMessage);
            HttpRequestMessage.Method := 'POST';
            HttpRequestMessage.SetRequestUri('https://quicksms.advantasms.com/api/services/sendbulk/');
            HttpRequestMessage.Content := Content;

            Clear(ResponseText);
            IsSuccessful := HttpClient.Send(HttpRequestMessage, HttpResponseMessage);

            if not IsSuccessful then begin
                // transport-level failure (timeout/DNS/etc) - reset the whole batch for retry, move on
                MarkBatchFailed(BatchSMSIds, 'HTTP send failed (no response received).');
                Commit();
                continue;
            end;

            HttpResponseMessage.Content.ReadAs(ResponseText);

            if not ((HttpResponseMessage.HttpStatusCode = 200) or (HttpResponseMessage.HttpStatusCode = 422)) then begin
                MarkBatchFailed(BatchSMSIds, StrSubstNo('Failed. Status code: %1. Body: %2', HttpResponseMessage.HttpStatusCode, ResponseText));
                Commit();
                continue;
            end;

            // ---- Parse response, match each result back to its record via clientsmsid ----
            if not RespRoot.ReadFrom(ResponseText) then begin
                MarkBatchFailed(BatchSMSIds, 'Invalid JSON Response: ' + ResponseText);
                Commit();
                continue;
            end;

            if not RespRoot.Get('responses', RespToken) then begin
                MarkBatchFailed(BatchSMSIds, 'Invalid Response (no responses array): ' + ResponseText);
                Commit();
                continue;
            end;

            ResponsesArray := RespToken.AsArray();

            foreach RespElemToken in ResponsesArray do begin
                RespItem := RespElemToken.AsObject();

                RespClientSmsId := '';
                RespCode := 0;
                RespDesc := '';
                RespMessageId := '';

                if RespItem.Get('clientsmsid', PropToken) then
                    RespClientSmsId := Format(PropToken.AsValue());
                if RespItem.Get('response-description', PropToken) then
                    RespDesc := PropToken.AsValue().AsText();
                if RespItem.Get('respose-code', PropToken) then      // API's documented (misspelled) key
                    RespCode := PropToken.AsValue().AsInteger()
                else if RespItem.Get('response-code', PropToken) then // fallback, in case it's ever fixed
                    RespCode := PropToken.AsValue().AsInteger();
                if RespItem.Get('messageid', PropToken) then
                    RespMessageId := Format(PropToken.AsValue());

                if RespClientSmsId = '' then
                    continue; // can't match this result back to a record safely

                SMSMessageRec2.Reset();
                if SMSMessageRec2.Get(Evaluate2Int(RespClientSmsId)) then begin
                    if (RespDesc = 'Success') or (RespCode = 200) then begin
                        SMSMessageRec2."Sent To Server" := SMSMessageRec2."Sent To Server"::Yes;
                        SMSMessageRec2.Posted := true;
                    end else begin
                        SMSMessageRec2."Sent To Server" := SMSMessageRec2."Sent To Server"::Failed;
                        SMSMessageRec2.Posted := false; // allow retry
                    end;

                    SMSMessageRec2.Remark := CopyStr(StrSubstNo('%1 (code %2)', RespDesc, RespCode), 1, 1000);
                    if RespMessageId <> '' then
                        SMSMessageRec2.ResponseID := RespMessageId;

                    SMSMessageRec2.Modify();
                end;
            end;

            Commit();

        until SMSMessageRec.Next() = 0;
    end;

    local procedure MarkBatchFailed(var SMSIds: List of [Integer]; ReasonText: Text)
    var
        SMSMessageRec: Record "SMS Messages";
        SMSId: Integer;
    begin
        foreach SMSId in SMSIds do
            if SMSMessageRec.Get(SMSId) then begin
                SMSMessageRec.Posted := false;
                SMSMessageRec."Sent To Server" := SMSMessageRec."Sent To Server"::Failed;
                SMSMessageRec.Remark := CopyStr(ReasonText, 1, 1000);
                SMSMessageRec.Modify();
            end;
    end;

    local procedure Evaluate2Int(TextValue: Text): Integer
    var
        Result: Integer;
    begin
        if Evaluate(Result, TextValue) then
            exit(Result);
        exit(0);
    end;

}
