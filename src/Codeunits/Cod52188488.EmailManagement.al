namespace Calwide.Calwide;
using System.Text;

codeunit 50005 "Email Management"
{ // ─────────────────────────────────────────────────────────────────────────
    //  INTEGRATION SUMMARY
    //
    //  Two actions are handled inside SaccoPortal.ProcessRequest:
    //
    //    'get-email-queue'     → EmailMgt.HandleGetEmailQueue(RequestDataJson)
    //    'confirm-email-sent'  → EmailMgt.HandleConfirmEmailSent(RequestDataJson)
    //
    //  Flow:
    //    1. Portal calls  get-email-queue  → BC returns SMTP config + unsent emails
    //    2. Portal sends emails via SMTP
    //    3. Portal calls  confirm-email-sent  → BC sets Sent = TRUE on each record
    //
    //  CONVENIENCE FUNCTIONS (call from any codeunit, page, or table trigger):
    //
    //    EmailMgt.QueueEmail(To, Subject, Body)
    //    EmailMgt.QueueEmailCC(To, CC, Subject, Body)
    //    EmailMgt.QueueEmailFull(To, CC, BCC, Subject, Body, Priority, TableId, EntryNo)
    //    EmailMgt.QueueEmailWithAttachment(To, Subject, Body, FileName, ContentType, InStr, FileSize)
    //    EmailMgt.QueueBulkEmails(ToList, Subject, Body, BulkGroupId)
    // ─────────────────────────────────────────────────────────────────────────


    // ════════════════════════════════════════════════════════════════════════
    //  ProcessRequest handlers  (called from SaccoPortal codeunit)
    // ════════════════════════════════════════════════════════════════════════

    /// Returns SMTP credentials (from Email Setup) + all unsent Email Queue
    /// entries, base64-encoded attachments included.
    /// The portal opens one SMTP connection with the returned credentials
    /// and sends every email in the list.
    procedure HandleGetEmailQueue(RequestDataJson: JsonObject) ResponseJson: JsonObject
    var
        EmailSetup: Record "Email Setup";
        EmailQueue: Record "Email Queue";
        EmailAttachment: Record "Email Attachment Portal";
        Convert: Codeunit "Base64 Convert";
        SmtpObj: JsonObject;
        DataObj: JsonObject;
        EmailsArr: JsonArray;
        EmailObj: JsonObject;
        AttachmentsArr: JsonArray;
        AttachObj: JsonObject;
        InStr: InStream;
        BodyText: Text;
        Base64Content: Text;
        BatchSize: Integer;
        Count: Integer;
    begin
        EmailSetup := EmailSetup.GetSetup();

        if not EmailSetup.Enabled then begin
            SetStatus(ResponseJson, 'error', 'Email Dispatch Disabled',
                'Enable email dispatch in Email Setup before fetching the queue.');
            exit;
        end;

        // SMTP block — portal reads this to open the mail connection
        SmtpObj.Add('host', EmailSetup."SMTP Host");
        SmtpObj.Add('port', EmailSetup."SMTP Port");
        SmtpObj.Add('username', EmailSetup."SMTP Username");
        SmtpObj.Add('password', EmailSetup."SMTP Password");
        SmtpObj.Add('use_tls', EmailSetup."Use TLS");
        SmtpObj.Add('from_name', EmailSetup."From Name");
        SmtpObj.Add('from_address', EmailSetup."From Address");

        // Collect pending entries up to Max Bulk Size
        BatchSize := EmailSetup."Max Bulk Size";
        if BatchSize = 0 then BatchSize := 50;

        EmailQueue.SetRange(Sent, false);
        EmailQueue.SetFilter("Retry Count", '<%1', 3);
        EmailQueue.SetCurrentKey("Entry No.");

        if EmailQueue.FindSet() then
            repeat
                Clear(EmailObj);
                Clear(AttachmentsArr);
                BodyText := '';

                EmailQueue.CalcFields(Body);
                if EmailQueue.Body.HasValue() then begin
                    EmailQueue.Body.CreateInStream(InStr, TextEncoding::UTF8);
                    InStr.ReadText(BodyText);
                end;

                EmailObj.Add('entry_no', EmailQueue."Entry No.");
                EmailObj.Add('to', EmailQueue."To Address");
                EmailObj.Add('cc', EmailQueue."CC Address");
                EmailObj.Add('bcc', EmailQueue."BCC Address");
                EmailObj.Add('subject', EmailQueue.Subject);
                EmailObj.Add('body', BodyText);
                EmailObj.Add('from_name', EmailQueue."From Name");
                EmailObj.Add('from_address', EmailQueue."From Address");

                if EmailQueue."Has Attachments" then begin
                    EmailAttachment.SetRange("Email Entry No.", EmailQueue."Entry No.");
                    if EmailAttachment.FindSet() then
                        repeat
                            Clear(AttachObj);
                            Base64Content := '';
                            EmailAttachment.CalcFields("File Content");
                            if EmailAttachment."File Content".HasValue() then begin
                                EmailAttachment."File Content".CreateInStream(InStr);
                                Base64Content := Convert.ToBase64(InStr);
                            end;
                            AttachObj.Add('filename', EmailAttachment."File Name");
                            AttachObj.Add('content_type', EmailAttachment."Content Type");
                            AttachObj.Add('content', Base64Content);
                            AttachmentsArr.Add(AttachObj);
                        until EmailAttachment.Next() = 0;
                end;

                EmailObj.Add('attachments', AttachmentsArr);
                EmailsArr.Add(EmailObj);
                Count += 1;
                if Count >= BatchSize then break;
            until EmailQueue.Next() = 0;

        DataObj.Add('smtp', SmtpObj);
        DataObj.Add('emails', EmailsArr);

        SetStatus(ResponseJson, 'success', 'Email Queue',
            StrSubstNo('%1 email(s) ready for dispatch', Count));
        ResponseJson.Add('data', DataObj);
    end;

    /// Receives per-entry delivery results from the portal and sets
    /// Sent = TRUE on successful entries (or increments Retry Count on failures).
    ///
    /// RequestDataJson is already $.request.payload.data, so just read "results":
    ///   { "results": [
    ///       { "entry_no": 1, "sent": true,  "error": "" },
    ///       { "entry_no": 2, "sent": false, "error": "SMTP timeout" }
    ///   ]}
    procedure HandleConfirmEmailSent(RequestDataJson: JsonObject) ResponseJson: JsonObject
    var
        EmailQueue: Record "Email Queue";
        ResultsToken: JsonToken;
        ResultsArr: JsonArray;
        ItemToken: JsonToken;
        ItemObj: JsonObject;
        EntryToken: JsonToken;
        SentToken: JsonToken;
        ErrorToken: JsonToken;
        EntryNo: Integer;
        SuccessCount: Integer;
        FailCount: Integer;
        Idx: Integer;
    begin
        if not RequestDataJson.Get('results', ResultsToken) then begin
            SetStatus(ResponseJson, 'error', 'Invalid Input', 'Missing "results" array in payload.');
            exit;
        end;

        ResultsArr := ResultsToken.AsArray();

        for Idx := 0 to ResultsArr.Count - 1 do begin
            ResultsArr.Get(Idx, ItemToken);
            ItemObj := ItemToken.AsObject();

            if ItemObj.Get('entry_no', EntryToken) then begin
                EntryNo := EntryToken.AsValue().AsInteger();
                if EmailQueue.Get(EntryNo) then begin
                    if ItemObj.Get('sent', SentToken) and SentToken.AsValue().AsBoolean() then begin
                        MarkEmailSent(EmailQueue);       // ← Sent = TRUE
                        SuccessCount += 1;
                    end else begin
                        if ItemObj.Get('error', ErrorToken) then
                            MarkEmailFailed(EmailQueue, CopyStr(ErrorToken.AsValue().AsText(), 1, 1000))
                        else
                            MarkEmailFailed(EmailQueue, 'Portal reported failure without details.');
                        FailCount += 1;
                    end;
                end;
            end;
        end;

        SetStatus(ResponseJson, 'success', 'Email Confirmation',
            StrSubstNo('%1 confirmed sent, %2 failed', SuccessCount, FailCount));
    end;


    // ════════════════════════════════════════════════════════════════════════
    //  CONVENIENCE FUNCTIONS — call from any codeunit, page, or table trigger
    // ════════════════════════════════════════════════════════════════════════

    /// Simplest one-liner: queue a plain HTML email to one address.
    ///
    ///   EmailMgt.QueueEmail('member@example.com', 'Loan Approved', '<h1>Congratulations!</h1>');
    procedure QueueEmail(ToAddress: Text; Subject: Text; Body: Text): Integer
    begin
        exit(AddEmailToQueue(ToAddress, Subject, Body, '', '', 0, 0, '', ''));
    end;

    /// Queue with CC.
    ///
    ///   EmailMgt.QueueEmailCC('member@example.com', 'loans@sacco.com', 'Approved', Body);
    procedure QueueEmailCC(ToAddress: Text; CCAddress: Text; Subject: Text; Body: Text): Integer
    begin
        exit(AddEmailToQueue(ToAddress, Subject, Body, CCAddress, '', 0, 0, '', ''));
    end;

    /// Queue with full options: BCC, priority, source table/entry tracing.
    ///
    ///   Priority: 0 = Normal, 1 = High, 2 = Low
    ///   SourceTableId / SourceEntryNo  link the email back to the triggering record.
    ///
    ///   EmailMgt.QueueEmailFull(
    ///       'member@sacco.com', '', '', 'Loan Approved', Body,
    ///       1,                          // High priority
    ///       Database::"Loan Application",
    ///       LoanApp."Application No.",
    ///       ''                          // no bulk group
    ///   );
    procedure QueueEmailFull(
        ToAddress: Text;
        CCAddress: Text;
        BCCAddress: Text;
        Subject: Text;
        Body: Text;
        Priority: Option;
        SourceTableId: Integer;
        SourceEntryNo: Text;
        BulkGroupId: Code[20]
    ): Integer
    begin
        exit(AddEmailToQueue(ToAddress, Subject, Body, CCAddress, BCCAddress,
            Priority, SourceTableId, SourceEntryNo, BulkGroupId));
    end;

    /// Queue one email AND attach a file in a single call.
    /// Returns the Entry No. (use it to add more attachments if needed).
    ///
    ///   var
    ///       TempBlob: Codeunit "Temp Blob";
    ///       InStr: InStream;
    ///   TempBlob.CreateInStream(InStr);
    ///   EntryNo := EmailMgt.QueueEmailWithAttachment(
    ///       'member@sacco.com', 'Statement', Body,
    ///       'statement.pdf', 'application/pdf', InStr, 0);
    procedure QueueEmailWithAttachment(
        ToAddress: Text;
        Subject: Text;
        Body: Text;
        FileName: Text;
        ContentType: Text;
        var FileContent: InStream;
        FileSize: Integer
    ): Integer
    var
        EntryNo: Integer;
    begin
        EntryNo := AddEmailToQueue(ToAddress, Subject, Body, '', '', 0, 0, '', '');
        AddAttachment(EntryNo, FileName, ContentType, FileContent, FileSize);
        exit(EntryNo);
    end;

    /// Queue the same subject/body to a list of addresses.
    /// All entries share a BulkGroupId so the portal can process them together.
    /// If BulkGroupId is blank a unique one is generated automatically.
    ///
    ///   var
    ///       Members: Record Members;
    ///       ToList: List of [Text];
    ///   Members.FindSet();
    ///   repeat
    ///       ToList.Add(Members."E-mail");
    ///   until Members.Next() = 0;
    ///   EmailMgt.QueueBulkEmails(ToList, 'AGM Notice', Body, 'AGM2025');
    procedure QueueBulkEmails(
        var ToList: List of [Text];
        Subject: Text;
        Body: Text;
        BulkGroupId: Code[20]
    ): Code[20]
    var
        ToAddress: Text;
        GroupId: Code[20];
    begin
        if BulkGroupId = '' then
            GroupId := CopyStr(Format(CreateGuid()), 1, 20)
        else
            GroupId := BulkGroupId;

        foreach ToAddress in ToList do
            if ToAddress <> '' then
                AddEmailToQueue(ToAddress, Subject, Body, '', '', 0, 0, '', GroupId);

        exit(GroupId);
    end;

    /// Attach an extra file to an existing queue entry.
    /// Use after QueueEmail* when you have multiple attachments.
    ///
    ///   EntryNo := EmailMgt.QueueEmail(To, Subject, Body);
    ///   EmailMgt.AddAttachment(EntryNo, 'doc1.pdf', 'application/pdf', InStr1, 0);
    ///   EmailMgt.AddAttachment(EntryNo, 'doc2.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', InStr2, 0);
    procedure AddAttachment(
        EmailEntryNo: Integer;
        FileName: Text;
        ContentType: Text;
        var FileContent: InStream;
        FileSize: Integer
    )
    var
        EmailAttachment: Record "Email Attachment Portal";
        EmailQueue: Record "Email Queue";
        OutStr: OutStream;
    begin
        if not EmailQueue.Get(EmailEntryNo) then
            Error('Email queue entry %1 not found.', EmailEntryNo);

        EmailAttachment.SetRange("Email Entry No.", EmailEntryNo);
        if EmailAttachment.FindLast() then
            EmailAttachment."Line No." := EmailAttachment."Line No." + 10000
        else
            EmailAttachment."Line No." := 10000;

        EmailAttachment.Init();
        EmailAttachment."Email Entry No." := EmailEntryNo;
        EmailAttachment."File Name" := CopyStr(FileName, 1, 250);
        EmailAttachment."Content Type" := CopyStr(ContentType, 1, 100);
        EmailAttachment."File Size" := FileSize;
        EmailAttachment."File Content".CreateOutStream(OutStr);
        CopyStream(OutStr, FileContent);
        EmailAttachment.Insert(true);

        if not EmailQueue."Has Attachments" then begin
            EmailQueue."Has Attachments" := true;
            EmailQueue.Modify(true);
        end;
    end;


    // ════════════════════════════════════════════════════════════════════════
    //  Internal core
    // ════════════════════════════════════════════════════════════════════════

    local procedure AddEmailToQueue(
        ToAddress: Text;
        Subject: Text;
        Body: Text;
        CCAddress: Text;
        BCCAddress: Text;
        Priority: Option;
        SourceTableId: Integer;
        SourceEntryNo: Text;
        BulkGroupId: Code[20]
    ): Integer
    var
        EmailQueue: Record "Email Queue";
        EmailSetup: Record "Email Setup";
        OutStr: OutStream;
    begin
        EmailSetup := EmailSetup.GetSetup();

        EmailQueue.Init();
        EmailQueue."To Address" := CopyStr(ToAddress, 1, 500);
        EmailQueue."CC Address" := CopyStr(CCAddress, 1, 500);
        EmailQueue."BCC Address" := CopyStr(BCCAddress, 1, 500);
        EmailQueue.Subject := CopyStr(Subject, 1, 250);
        EmailQueue.Body.CreateOutStream(OutStr, TextEncoding::UTF8);
        OutStr.WriteText(Body);
        EmailQueue.Priority := Priority;
        EmailQueue."Source Table ID" := SourceTableId;
        EmailQueue."Source Entry No." := CopyStr(SourceEntryNo, 1, 100);
        EmailQueue."Bulk Group ID" := BulkGroupId;
        EmailQueue."From Name" := EmailSetup."From Name";
        EmailQueue."From Address" := EmailSetup."From Address";
        EmailQueue.Insert(true);

        exit(EmailQueue."Entry No.");
    end;

    local procedure MarkEmailSent(var EmailQueue: Record "Email Queue")
    begin
        EmailQueue.Sent := true;
        EmailQueue."Sent At" := CurrentDateTime();
        EmailQueue."Error Message" := '';
        EmailQueue.Modify(true);
    end;

    local procedure MarkEmailFailed(var EmailQueue: Record "Email Queue"; ErrorMsg: Text)
    begin
        EmailQueue.Sent := false;
        EmailQueue."Error Message" := CopyStr(ErrorMsg, 1, 1000);
        EmailQueue."Retry Count" += 1;
        EmailQueue.Modify(true);
    end;

    local procedure SetStatus(var ResponseJson: JsonObject; Status: Text; Title: Text; Message: Text)
    begin
        ResponseJson.Add('status', Status);
        ResponseJson.Add('title', Title);
        ResponseJson.Add('message', Message);
    end;
}
