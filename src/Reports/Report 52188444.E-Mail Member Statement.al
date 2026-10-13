Report 50088 "E-Mail Member Statement"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where("E-Mail" = filter(<> ''));
            RequestFilterFields = "No.", "Date Filter", Status, "Registration Date";
            column(ReportForNavId_1; 1)
            {
            }
            trigger OnAfterGetRecord()
            var
                ResultMessage: Text;
                EncryptedBase64: Text;
                SourceTempBlob: Codeunit "Temp Blob";
                OutStr: OutStream;
                RecRef: RecordRef;
                SourceFileName: Text;
            begin
                RecipientEmail := '';

                Cust.Reset();
                Cust.SetRange("No.", Members."No.");
                if Cust.FindFirst() then
                    RecipientEmail := Cust."E-Mail";

                RecipientEmail := DelChr(RecipientEmail, '<>', ' ');

                if not ValidEmailAddress(RecipientEmail) then begin
                    SkippedCount += 1;
                    CurrReport.Skip();
                    exit;
                end;

                CurrentRecordNo += 1;
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);

                if NoOfRecords > 0 then
                    dWindow.Update(1, Round(CurrentRecordNo / NoOfRecords * 10000, 1))
                else
                    dWindow.Update(1, 0);

                Cust.Reset();
                Cust.SetRange("No.", Members."No.");
                Cust.SetFilter("Date Filter", Members.GetFilter("Date Filter"));

                if not Cust.FindFirst() then begin
                    SkippedCount += 1;
                    CurrReport.Skip();
                    exit;
                end;

                SourceTempBlob.CreateOutStream(OutStr);
                RecRef.GetTable(Cust);
                Report.SaveAs(Report::"Summary Member Statement", '', ReportFormat::Pdf, OutStr, RecRef);

                SourceFileName := Members."No." + '-Statement.pdf';

                if ReportAction = ReportAction::"Send Email" then begin
                    BodyMsg :=
                        'Dear ' + Members.Name + '<br><br>' +
                        BodyTxt + '<br><br>' +
                        RegardsTxt + '<br>' +
                        CompanyInformation.Name + '<br><br>' +
                        '<hr>' +
                        DesclaimerTxt;

                    MemberNo := Cust."No.";

                    if not ExecuteRequest(ResultMessage, EncryptedBase64, SourceTempBlob, SourceFileName) then begin
                        FailedCount += 1;
                        CurrReport.Skip();
                        exit;
                    end;

                    SentCount += 1;
                end;
            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
                Message(
                    'Completed.\' +
                    'Sent: %1\' +
                    'Failed: %2\' +
                    'Skipped: %3',
                    SentCount,
                    FailedCount,
                    SkippedCount);

            end;

            trigger OnPreDataItem()
            begin
                //if SMTPSetup.Get then
                //SMTPSetup.TestField("File Path");
                CompanyInformation.Get;

                dWindow.Open('Generating Statements:    @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Press Esc to abort');

                NoOfRecords := Members.Count;
                SaccoSetup.Get();
                SaccoSetup.testfield("Email File Path");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Report Action"; ReportAction)
                {
                    ApplicationArea = Basic;
                }
                field(RecepientEmail; RecipientEmail)
                {
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        MemberNo: Code[20];
        CompanyInformation: Record "Company Information";
        SaccoSetup: Record "Sacco Setup";
        Cust: Record Members;
        ReportAction: Option "Send Email","Save Only";
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        SentCount: Integer;
        FailedCount: Integer;
        SkippedCount: Integer;
        RecipientEmail: Text;
        BodyMsg: Text;
        BodyTxt: Label 'Please find attached your Member Statement.<br><br>Please note that the statement has been encrypted. Use your ID number as the password.';
        RegardsTxt: Label 'Kind Regards,';
        DesclaimerTxt: Label 'This is a system generated email. Please do not respond to this email.';



    local procedure ExecuteRequest(var ResultMessage: Text; var EncryptedBase64: Text; SourceTempBlob: Codeunit "Temp Blob"; SourceFileName: Text): Boolean
    var
        Member: Record Members;
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        ResponseContent: Text;
        RequestContent: Text;
        EmailCU: Codeunit Email;
        EmailMessageCU: Codeunit "Email Message";
        Recipients: List of [Text];
        FileName: Text;
        InStr: InStream;
        Base64Content: Text;
        Base64Convert: Codeunit "Base64 Convert";
        EndpointUrl: Text;
        EmailSubject: Text[250];
    begin
        ResultMessage := '';
        EncryptedBase64 := '';
        EndpointUrl := 'https://pdf-encrypt.calwide.app/api/v1/encrypt-base64';

        if RecipientEmail = '' then
            if MemberNo <> '' then
                if Member.Get(MemberNo) then
                    RecipientEmail := DelChr(Member."E-Mail", '<>', ' ');

        if not ValidEmailAddress(RecipientEmail) then begin
            ResultMessage := StrSubstNo('Invalid recipient email: %1', RecipientEmail);
            exit(false);
        end;

        if MemberNo = '' then begin
            Member.Reset();
            Member.SetRange("E-Mail", RecipientEmail);
            if Member.FindFirst() then
                MemberNo := Member."No.";
        end;

        if (MemberNo <> '') and (not Member.Get(MemberNo)) then begin
            ResultMessage := StrSubstNo('Member %1 was not found.', MemberNo);
            exit(false);
        end;

        SourceTempBlob.CreateInStream(InStr);
        Base64Content := Base64Convert.ToBase64(InStr);

        if Base64Content = '' then begin
            ResultMessage := 'Failed to read source document or file is empty.';
            exit(false);
        end;

        RequestBody.Add('password', Member."ID No.");
        RequestBody.Add('base64_content', Base64Content);
        RequestBody.Add('input_type', 'base64');
        RequestBody.Add('output_type', 'base64');

        if SourceFileName <> '' then
            RequestBody.Add('base64_filename', SourceFileName);

        RequestBody.WriteTo(RequestContent);

        HttpContent.WriteFrom(RequestContent);
        HttpContent.GetHeaders(HttpHeaders);
        if HttpHeaders.Contains('Content-Type') then
            HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json; charset=utf-8');

        if not HttpClient.Post(EndpointUrl, HttpContent, HttpResponseMessage) then begin
            ResultMessage := 'Unable to call encryption API endpoint.';
            exit(false);
        end;

        HttpResponseMessage.Content.ReadAs(ResponseContent);

        if not HttpResponseMessage.IsSuccessStatusCode() then begin
            ResultMessage := StrSubstNo(
                'Encryption API failed with status %1: %2',
                HttpResponseMessage.HttpStatusCode(),
                ResponseContent);
            exit(false);
        end;

        if not ResponseBody.ReadFrom(ResponseContent) then begin
            ResultMessage := 'Invalid JSON response from encryption API.';
            exit(false);
        end;

        EncryptedBase64 := GetEncryptedPayload(ResponseBody);
        if EncryptedBase64 = '' then begin
            ResultMessage := 'Encryption API response did not return encrypted content.';
            exit(false);
        end;

        Clear(Recipients);

        if SourceFileName = '' then
            FileName := CopyStr(MemberNo + '_encrypted.pdf', 1, 250)
        else
            FileName := CopyStr(MemberNo + '_' + SourceFileName, 1, 250);

        Recipients.Add(RecipientEmail);

        EmailSubject := CopyStr('Member Statement - ' + MemberNo, 1, MaxStrLen(EmailSubject));

        EmailMessageCU.Create(Recipients, EmailSubject, BodyMsg, true);
        EmailMessageCU.AddAttachment(FileName, 'application/pdf', EncryptedBase64);

        if not EmailCU.Send(EmailMessageCU) then begin
            ResultMessage := StrSubstNo('Email send failed for %1', RecipientEmail);
            exit(false);
        end;

        ResultMessage := 'Document encrypted and emailed successfully.';
        exit(true);
    end;

    local procedure GetEncryptedPayload(ResponseBody: JsonObject) EncryptedContent: Text
    var
        JsonToken: JsonToken;
        DataToken: JsonToken;
    begin
        if ResponseBody.Get('encrypted_base64', JsonToken) then
            if not JsonToken.AsValue().IsNull() then
                exit(JsonToken.AsValue().AsText());

        if ResponseBody.Get('encrypted_data', JsonToken) then
            if not JsonToken.AsValue().IsNull() then
                exit(JsonToken.AsValue().AsText());

        if ResponseBody.Get('data', DataToken) then
            if DataToken.IsObject() then begin
                if DataToken.AsObject().Get('encrypted_base64', JsonToken) then
                    if not JsonToken.AsValue().IsNull() then
                        exit(JsonToken.AsValue().AsText());

                if DataToken.AsObject().Get('encrypted_data', JsonToken) then
                    if not JsonToken.AsValue().IsNull() then
                        exit(JsonToken.AsValue().AsText());
            end;

        exit('');
    end;

    local procedure ValidEmailAddress(EmailAddress: Text): Boolean
    var
        AtPos: Integer;
        DomainPart: Text;
        DotPos: Integer;
    begin
        EmailAddress := DelChr(EmailAddress, '<>', ' ');

        if EmailAddress = '' then
            exit(false);

        if (StrPos(EmailAddress, ';') > 0) or (StrPos(EmailAddress, ',') > 0) then
            exit(false);

        AtPos := StrPos(EmailAddress, '@');
        if AtPos <= 1 then
            exit(false);

        if AtPos = StrLen(EmailAddress) then
            exit(false);

        if StrPos(CopyStr(EmailAddress, AtPos + 1), '@') > 0 then
            exit(false);

        DomainPart := CopyStr(EmailAddress, AtPos + 1);
        DotPos := StrPos(DomainPart, '.');

        if DotPos <= 1 then
            exit(false);

        if EmailAddress[StrLen(EmailAddress)] = '.' then
            exit(false);

        exit(true);
    end;





}

