namespace UnitedWomen.UnitedWomen;
using System.Utilities;
using System.Text;
using System.Email;
using Microsoft.Foundation.Company;

report 50585 "Email FD Certificate"
{
    Caption = 'Email FD Certificate';

    ProcessingOnly = true;

    dataset
    {
        dataitem(FixedDepositAccounts; "Fixed Deposit Accounts")
        {
            DataItemTableView = where("FD Status" = filter(Active));
            RequestFilterFields = "No.", "Member No.", "FD Status";

            column(ReportForNavId_1; 1)
            {
            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                SaccoSetup.Get();
                //SaccoSetup.TestField("Email File Path");
                //SaccoSetup.TestField("PDF Encrypt Function URL");

                NoOfRecords := FixedDepositAccounts.Count;
                if GuiAllowed then
                    dWindow.Open(
                        'Generating FD Certificates:  @1@@@@@@@@@\' +
                        'Counter   #2#########' +
                        'Total     #3#########' +
                        'Press Esc to abort');
            end;

            trigger OnAfterGetRecord()
            var
                TempBlob: Codeunit "Temp Blob";
                Email: Codeunit Email;
                EmailMessage: Codeunit "Email Message";
                HttpClient: HttpClient;
                HttpContent: HttpContent;
                HttpResponse: HttpResponseMessage;
                HttpHeaders: HttpHeaders;
                InStr: InStream;
                OutStr: OutStream;
                ToRecipients: List of [Text];
                CCRecipients: List of [Text];
                BCCRecipients: List of [Text];
                FDCertReport: Report "Fixed Deposit Certificate";
                MemberRec: Record Members;
                Base64Convert: Codeunit "Base64 Convert";
                RequestBody: JsonObject;
                ResponseBody: JsonObject;
                BodyMsg: Text;
                RequestText: Text;
                CompanyName: Text;
                FileName: Text;
                Password: Text;
                Base64Content: Text;
                EncryptedBase64: Text;
                ResponseText: Text;
                AzureFunctionUrl: Text;
                SubjectTxt: Label 'Your Fixed Deposit Certificate - %1';
                BodyTxt: Label 'Please find attached your encrypted Fixed Deposit Certificate.';
                PasswordTxt: Label 'Your certificate password is your ID Number.';
                RegardsTxt: Label 'Best Regards,';
                DisclaimerTxt: Label 'This is a system generated email. Please do not reply.';
            begin
                // Pull member record for email and ID
                MemberRec.Get("Member No.");

                if RecepientEmail = '' then
                    RecepientEmail := MemberRec."E-Mail";

                if not SaccoActivities.ValidEmailAddress(RecepientEmail) then
                    CurrReport.Skip();

                if "Approval Status" <> "approval status"::Approved then
                    CurrReport.Skip();

                CurrentRecordNo += 1;
                if GuiAllowed then begin
                    dWindow.Update(1, Round(CurrentRecordNo / NoOfRecords * 10000, 1));
                    dWindow.Update(2, CurrentRecordNo);
                    dWindow.Update(3, NoOfRecords);
                end;

                Password := MemberRec."ID No.";
                if Password = '' then
                    Password := "Member No.";

                CompanyName := CompanyProperty.DisplayName();
                FileName := "No." + '-FDCertificate.pdf';
                AzureFunctionUrl := GetEncryptBase64EndpointUrl(SaccoSetup."PDF Encrypt Function URL");

                // Step 1 — Generate PDF
                FDRec.Reset();
                FDRec.SetRange("No.", "No.");
                if not FDRec.FindFirst() then
                    CurrReport.Skip();

                TempBlob.CreateOutStream(OutStr);
                Clear(FDCertReport);
                FDCertReport.SetTableView(FDRec);
                if not FDCertReport.SaveAs('', ReportFormat::Pdf, OutStr) then
                    CurrReport.Skip();

                // Step 2 — Encrypt via Azure Function
                TempBlob.CreateInStream(InStr);
                Base64Content := Base64Convert.ToBase64(InStr);
                if Base64Content = '' then begin
                    if GuiAllowed then
                        Message('Failed to read FD certificate PDF for FD %1. Skipping.', "No.");
                    CurrReport.Skip();
                end;

                RequestBody.Add('password', Password);
                RequestBody.Add('base64_content', Base64Content);
                RequestBody.Add('input_type', 'base64');
                RequestBody.Add('output_type', 'base64');
                RequestBody.Add('base64_filename', FileName);
                RequestBody.WriteTo(RequestText);

                HttpContent.WriteFrom(RequestText);
                HttpContent.GetHeaders(HttpHeaders);
                if HttpHeaders.Contains('Content-Type') then
                    HttpHeaders.Remove('Content-Type');
                HttpHeaders.Add('Content-Type', 'application/json; charset=utf-8');

                if not HttpClient.Post(AzureFunctionUrl, HttpContent, HttpResponse) then begin
                    if GuiAllowed then
                        Message('Failed to connect to encryption service for FD %1 using endpoint %2. Skipping.', "No.", AzureFunctionUrl);
                    CurrReport.Skip();
                end;

                HttpResponse.Content.ReadAs(ResponseText);
                if not HttpResponse.IsSuccessStatusCode() then begin
                    if GuiAllowed then
                        Message('Encryption failed for FD %1: %2', "No.", ResponseText);
                    CurrReport.Skip();
                end;

                if not ResponseBody.ReadFrom(ResponseText) then begin
                    if GuiAllowed then
                        Message('Invalid JSON response from encryption service for FD %1. Skipping.', "No.");
                    CurrReport.Skip();
                end;

                EncryptedBase64 := GetEncryptedPayload(ResponseBody);
                if EncryptedBase64 = '' then begin
                    if GuiAllowed then
                        Message('Encryption service did not return encrypted content for FD %1. Skipping.', "No.");
                    CurrReport.Skip();
                end;

                // Step 4 — Build and send email
                BodyMsg := 'Dear ' + MemberRec.Name + ',';
                BodyMsg += '<br><br>';
                BodyMsg += BodyTxt;
                BodyMsg += '<br><br>';
                BodyMsg += PasswordTxt;
                BodyMsg += '<br><br>';
                BodyMsg += 'FD Account No: <b>' + "No." + '</b><br>';
                BodyMsg += 'FD Amount: <b>' + Format("FD Amount") + '</b><br>';
                BodyMsg += 'Maturity Date: <b>' + Format("FD Maturity Date") + '</b>';
                BodyMsg += '<br><br>';
                BodyMsg += RegardsTxt + '<br>';
                BodyMsg += CompanyName;
                BodyMsg += '<br><br><HR>';
                BodyMsg += DisclaimerTxt;

                Clear(ToRecipients);
                Clear(CCRecipients);
                Clear(BCCRecipients);
                ToRecipients.Add(RecepientEmail);

                EmailMessage.Create(
                    ToRecipients,
                    StrSubstNo(SubjectTxt, "No."),
                    BodyMsg,
                    true,
                    CCRecipients,
                    BCCRecipients);

                EmailMessage.AddAttachment(FileName, 'application/pdf', EncryptedBase64);

                if TrySendFinanceEmail(EmailMessage) then
                    j += 1;

                RecepientEmail := '';
            end;

            trigger OnPostDataItem()
            begin
                if GuiAllowed then begin
                    dWindow.Close();
                    Message('%1 FD Certificate(s) Sent', j);
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(RecepientEmail; RecepientEmail)
                {
                    ApplicationArea = Basic;
                    Caption = 'Override Recipient Email';
                    ToolTip = 'Leave blank to use the email on each members record.';
                }
            }
        }
    }

    var
        CompanyInformation: Record "Company Information";
        SaccoSetup: Record "Sacco Setup";
        SaccoActivities: Codeunit "Sacco Activities";
        EmailSend: Codeunit Email;
        FDRec: Record "Fixed Deposit Accounts";
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        RecepientEmail: Text;
        j: Integer;
        DefaultEncryptBase64EndpointUrl: Label 'https://pdf-encrypt.calwide.app/api/v1/encrypt-base64';

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

    local procedure GetEncryptBase64EndpointUrl(EndpointUrl: Text): Text
    begin
        EndpointUrl := DelChr(EndpointUrl, '<>', ' ');

        if EndpointUrl = '' then
            exit(DefaultEncryptBase64EndpointUrl);

        if StrPos(LowerCase(EndpointUrl), 'encrypt-base64') = 0 then
            exit(DefaultEncryptBase64EndpointUrl);

        exit(EndpointUrl);
    end;

    [TryFunction]
    local procedure TrySendFinanceEmail(var EmailMessage: Codeunit "Email Message")
    var
        Email: Codeunit Email;
    begin
        Email.Send(EmailMessage, Enum::"Email Scenario"::Finance);
    end;

}
