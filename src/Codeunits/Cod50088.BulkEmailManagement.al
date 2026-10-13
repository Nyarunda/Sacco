codeunit 50089 "Bulk Email Management"
{
    procedure SendFromHeader(var BulkEmailHeader: Record "Bulk Email Header")
    var
        BulkEmailLines: Record "Bulk Email Lines";
        SentCount: Integer;
        FailedCount: Integer;
        BulkEmailAttachment: Record "Bulk Email Attachment";
    begin
        if BulkEmailHeader."Email Status" = BulkEmailHeader."Email Status"::Cancelled then
            Error('Cannot send emails for a cancelled header.');

        BulkEmailLines.Reset();
        BulkEmailLines.SetRange(No, BulkEmailHeader.No);
        if not BulkEmailLines.FindSet() then
            Error('No email lines found for header %1.', BulkEmailHeader.No);

        repeat
            if BulkEmailLines.Status <> BulkEmailLines.Status::Sent then
                if not TryProcessLine(BulkEmailHeader, BulkEmailLines, SentCount, FailedCount) then
                    SetLineFailure(BulkEmailLines, GetLastErrorText(), FailedCount);
        until BulkEmailLines.Next() = 0;

        BulkEmailHeader."Status Date" := Today;
        BulkEmailHeader."Status Time" := Time;
        BulkEmailHeader."Status By" := UserId;
        if FailedCount = 0 then begin
            BulkEmailHeader."Email Status" := BulkEmailHeader."Email Status"::Sent;
        end
        else
            BulkEmailHeader."Email Status" := BulkEmailHeader."Email Status"::Pending;
        BulkEmailHeader.Modify();

        Message('Bulk email processing complete. Sent: %1. Failed: %2.', SentCount, FailedCount);
    end;

    [TryFunction]
    local procedure TryProcessLine(BulkEmailHeader: Record "Bulk Email Header"; var BulkEmailLine: Record "Bulk Email Lines"; var SentCount: Integer; var FailedCount: Integer)
    begin
        ProcessLine(BulkEmailHeader, BulkEmailLine, SentCount, FailedCount);
    end;

    local procedure ProcessLine(BulkEmailHeader: Record "Bulk Email Header"; var BulkEmailLine: Record "Bulk Email Lines"; var SentCount: Integer; var FailedCount: Integer)
    var
        Member: Record Members;
        Email: Codeunit Email;
        EmailMessageCU: Codeunit "Email Message";
        SaccoActivities: Codeunit "Sacco Activities";
        Recipients: List of [Text];
        BulkEmailAttachment: Record "Bulk Email Attachment";
        MemberNo: Code[20];
        MemberPassword: Text;
        RecipientEmail: Text;
        LineSubject: Text;
        LineBody: Text;
        EndpointUrl: Text;
        ResultMessage: Text;
        AttachmentAdded: Boolean;
    begin
        ResultMessage := '';
        EndpointUrl := BulkEmailHeader."Endpoint URL";
        if EndpointUrl = '' then
            EndpointUrl := DefaultEndpointUrl;

        MemberNo := BulkEmailLine."Member No.";
        RecipientEmail := BulkEmailLine."E-Mail";
        MemberPassword := BulkEmailLine.Password;

        if (MemberNo <> '') and Member.Get(MemberNo) then begin
            if RecipientEmail = '' then
                RecipientEmail := Member."E-Mail";
            if MemberPassword = '' then
                MemberPassword := Member."ID No.";
        end;

        if RecipientEmail = '' then begin
            ResultMessage := 'Recipient email is required.';
            SetLineFailure(BulkEmailLine, ResultMessage, FailedCount);
            exit;
        end;

        if not SaccoActivities.ValidEmailAddress(RecipientEmail) then begin
            ResultMessage := StrSubstNo('Invalid recipient email address: %1.', RecipientEmail);
            SetLineFailure(BulkEmailLine, ResultMessage, FailedCount);
            exit;
        end;

        if MemberNo = '' then begin
            Member.Reset();
            Member.SetRange("E-Mail", RecipientEmail);
            if Member.FindFirst() then
                MemberNo := Member."No.";
        end;

        if MemberNo = '' then
            MemberNo := RecipientEmail;

        if MemberPassword = '' then
            MemberPassword := MemberNo;

        LineSubject := BulkEmailHeader."Email Subject";
        if BulkEmailLine."Email Subject" <> '' then
            LineSubject := BulkEmailLine."Email Subject";
        if LineSubject = '' then
            LineSubject := 'Encrypted document';
        LineSubject := PersonalizeText(LineSubject, Member);

        LineBody := BulkEmailHeader."Email Body";
        if BulkEmailLine."Email Body" <> '' then
            LineBody := BulkEmailLine."Email Body";
        if LineBody = '' then
            LineBody := 'Please find attached your encrypted PDF document. Password is your member id.';
        LineBody := PersonalizeText(LineBody, Member);

        Recipients.Add(RecipientEmail);
        EmailMessageCU.Create(Recipients, LineSubject, LineBody, true);

        BulkEmailAttachment.Reset();
        BulkEmailAttachment.SetRange(No, BulkEmailHeader.No);
        BulkEmailAttachment.SetRange(Enabled, true);
        if BulkEmailAttachment.FindSet() then
            repeat
                if not AddEncryptedAttachment(EmailMessageCU, EndpointUrl, MemberPassword, MemberNo, BulkEmailAttachment."Source File Path", ResultMessage, BulkEmailAttachment) then begin
                    SetLineFailure(BulkEmailLine, ResultMessage, FailedCount);
                    exit;
                end;
                AttachmentAdded := true;
            until BulkEmailAttachment.Next() = 0;

        if (not AttachmentAdded) and (BulkEmailHeader."Source File Path" <> '') then begin
            if not AddEncryptedAttachment(EmailMessageCU, EndpointUrl, MemberPassword, MemberNo, BulkEmailHeader."Source File Path", ResultMessage, BulkEmailAttachment) then begin
                SetLineFailure(BulkEmailLine, ResultMessage, FailedCount);
                exit;
            end;
            AttachmentAdded := true;
        end;

        if not Email.Send(EmailMessageCU) then begin
            if AttachmentAdded then
                SetLineFailure(BulkEmailLine, 'Encryption succeeded but email send failed.', FailedCount)
            else
                SetLineFailure(BulkEmailLine, 'Email send failed.', FailedCount);
            exit;
        end;

        BulkEmailLine.Status := BulkEmailLine.Status::Sent;
        if AttachmentAdded then
            BulkEmailLine."Result Message" := 'Document encrypted and emailed successfully.'
        else
            BulkEmailLine."Result Message" := 'Email sent successfully.';
        BulkEmailLine."Sent DateTime" := CurrentDateTime;
        BulkEmailLine.Modify();

        SentCount += 1;
    end;

    local procedure AddEncryptedAttachment(var EmailMessageCU: Codeunit "Email Message"; EndpointUrl: Text; MemberPassword: Text; MemberNo: Code[20]; SourceFilePath: Text; var ResultMessage: Text; BulkEmailAttachment: Record "Bulk Email Attachment"): Boolean
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        ResponseContent: Text;
        RequestContent: Text;
        Base64Content: Text;
        EncryptedBase64: Text;
        FileName: Text;
    begin
        ResultMessage := '';

        ReadSourceAsBase64(SourceFilePath, Base64Content, ResultMessage, BulkEmailAttachment);
        if Base64Content = '' then begin
            if ResultMessage = '' then
                ResultMessage := 'Failed to read source file or file is empty.';
            exit(false);
        end;

        RequestBody.Add('password', MemberPassword);
        RequestBody.Add('base64_content', Base64Content);
        RequestBody.Add('input_type', 'base64');
        RequestBody.Add('output_type', 'base64');

        FileName := ExtractFileNameFromPath(SourceFilePath);
        if FileName <> '' then
            RequestBody.Add('base64_filename', FileName);

        RequestBody.WriteTo(RequestContent);
        HttpContent.WriteFrom(RequestContent);
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Clear();
        HttpHeaders.Add('Content-Type', 'application/json');

        if not HttpClient.Post(EndpointUrl, HttpContent, HttpResponseMessage) then begin
            ResultMessage := 'Unable to call encryption API endpoint.';
            exit(false);
        end;

        HttpResponseMessage.Content.ReadAs(ResponseContent);
        if not HttpResponseMessage.IsSuccessStatusCode then begin
            ResultMessage := StrSubstNo('Encryption API failed with status %1: %2', HttpResponseMessage.HttpStatusCode, ResponseContent);
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

        if MemberNo = '' then
            MemberNo := 'document';

        FileName := CopyStr(MemberNo + '_' + FileName, 1, 250);
        EmailMessageCU.AddAttachment(FileName, 'application/pdf', EncryptedBase64);
        exit(true);
    end;

    local procedure HasAttachmentSource(BulkEmailHeader: Record "Bulk Email Header"): Boolean
    var
        BulkEmailAttachment: Record "Bulk Email Attachment";
    begin
        if BulkEmailHeader."Source File Path" <> '' then
            exit(true);

        BulkEmailAttachment.Reset();
        BulkEmailAttachment.SetRange(No, BulkEmailHeader.No);
        BulkEmailAttachment.SetRange(Enabled, true);
        exit(BulkEmailAttachment.FindFirst());
    end;

    local procedure SetLineFailure(var BulkEmailLine: Record "Bulk Email Lines"; ResultMessage: Text; var FailedCount: Integer)
    begin
        BulkEmailLine.Status := BulkEmailLine.Status::Failed;
        BulkEmailLine."Result Message" := CopyStr(ResultMessage, 1, MaxStrLen(BulkEmailLine."Result Message"));
        BulkEmailLine."Sent DateTime" := CurrentDateTime;
        BulkEmailLine.Modify();
        FailedCount += 1;
    end;

    local procedure ReadSourceAsBase64(SourceFilePath: Text; var Base64Content: Text; var ErrorMessage: Text; BulkEmailAttachment: Record "Bulk Email Attachment")
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        InStream: InStream;
        OutStream: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
        FileMgt: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
    begin
        Base64Content := '';
        ErrorMessage := '';

        /*  
            if not File.Exists(SourceFilePath) then begin

                MyFile.Open(SourceFilePath);
                MyFile.CreateInStream(InStream);

                // Convert directly without CopyStream
                Base64Content := Base64Convert.ToBase64(InStream, false);

                MyFile.Close();
            end else begin
                if (StrPos(LowerCase(SourceFilePath), 'http://') <> 1) and (StrPos(LowerCase(SourceFilePath), 'https://') <> 1) then begin
                    ErrorMessage := 'Local file paths are not supported in Cloud extensions. Use an HTTP/HTTPS URL.';
                    exit;
                end else
                    Error('File not found: %1', SourceFilePath);
            end; 

            if not HttpClient.Get(SourceFilePath, HttpResponseMessage) then begin
                ErrorMessage := StrSubstNo('Unable to download source file from URL: %1', SourceFilePath);
                exit;
            end;

            if not HttpResponseMessage.IsSuccessStatusCode then begin
                ErrorMessage := StrSubstNo('Failed to download source file. Status: %1', HttpResponseMessage.HttpStatusCode);
                exit;
            end;
        */

        // write content into blob
        BulkEmailAttachment.CalcFields("File Content");
        BulkEmailAttachment."File Content".CreateInStream(InStream);

        BulkEmailAttachment."File Content".CreateOutStream(OutStream);

        if BulkEmailAttachment."File Content".Length() = 0 then
            Error('InStream is NULL before CopyStream');
        // recreate instream AFTER writing

        Base64Content := Base64Convert.ToBase64(InStream, false);


    end;

    local procedure ExtractFileNameFromPath(FullPath: Text): Text
    var
        SlashPos: Integer;
        BackslashPos: Integer;
        StartPos: Integer;
    begin
        StartPos := 1;

        BackslashPos := StrLen(FullPath);
        while BackslashPos > 0 do begin
            if FullPath[BackslashPos] = '\' then begin
                StartPos := BackslashPos + 1;
                break;
            end;
            BackslashPos -= 1;
        end;

        if StartPos = 1 then begin
            SlashPos := StrLen(FullPath);
            while SlashPos > 0 do begin
                if FullPath[SlashPos] = '/' then begin
                    StartPos := SlashPos + 1;
                    break;
                end;
                SlashPos -= 1;
            end;
        end;

        /*  if StartPos > StrLen(FullPath) then
             exit('document.pdf'); */

        exit(CopyStr(FullPath, StartPos, StrLen(FullPath) - StartPos + 1));
    end;

    local procedure GetEncryptedPayload(ResponseBody: JsonObject) EncryptedContent: Text
    var
        JsonToken: JsonToken;
    begin
        if ResponseBody.Get('encrypted_base64', JsonToken) then
            if not JsonToken.AsValue().IsNull() then
                exit(JsonToken.AsValue().AsText());

        if ResponseBody.Get('encrypted_data', JsonToken) then
            if not JsonToken.AsValue().IsNull() then
                exit(JsonToken.AsValue().AsText());

        if ResponseBody.Get('data', JsonToken) then begin
            if JsonToken.IsObject() then begin
                if JsonToken.AsObject().Get('encrypted_base64', JsonToken) then
                    exit(JsonToken.AsValue().AsText());
                if JsonToken.AsObject().Get('encrypted_data', JsonToken) then
                    exit(JsonToken.AsValue().AsText());
            end;
        end;

        exit('');
    end;

    local procedure PersonalizeText(SourceText: Text; Member: Record Members): Text
    var
        ResultText: Text;
        FirstName: Text;
    begin
        ResultText := SourceText;
        if Member."No." = '' then
            exit(ResultText);

        FirstName := GetFirstName(Member.Name);

        ResultText := ReplaceToken(ResultText, '[Member Name]', Member.Name);
        ResultText := ReplaceToken(ResultText, '[MEMBER NAME]', Member.Name);
        ResultText := ReplaceToken(ResultText, '[MemberName]', Member.Name);
        ResultText := ReplaceToken(ResultText, '[First Name]', FirstName);
        ResultText := ReplaceToken(ResultText, '[FIRST NAME]', FirstName);
        ResultText := ReplaceToken(ResultText, '[FirstName]', FirstName);
        ResultText := ReplaceToken(ResultText, '[Member No.]', Member."No.");
        ResultText := ReplaceToken(ResultText, '[Member No]', Member."No.");
        ResultText := ReplaceToken(ResultText, '[MEMBER NO]', Member."No.");
        ResultText := ReplaceToken(ResultText, '[MemberNo]', Member."No.");
        ResultText := ReplaceToken(ResultText, '[Email]', Member."E-Mail");
        ResultText := ReplaceToken(ResultText, '[Mobile No.]', Member."Mobile Phone No.");
        ResultText := ReplaceToken(ResultText, '[Mobile No]', Member."Mobile Phone No.");

        exit(ResultText);
    end;

    local procedure ReplaceToken(SourceText: Text; Token: Text; Value: Text): Text
    begin
        exit(SourceText.Replace(Token, Value));
    end;

    local procedure GetFirstName(FullName: Text): Text
    var
        SpacePos: Integer;
    begin
        FullName := DelChr(FullName, '<>');
        SpacePos := StrPos(FullName, ' ');
        if SpacePos = 0 then
            exit(FullName);

        exit(CopyStr(FullName, 1, SpacePos - 1));
    end;

    var
        DefaultEndpointUrl: Label 'https://pdf-encrypt.calwide.app/api/v1/encrypt-base64';
}
