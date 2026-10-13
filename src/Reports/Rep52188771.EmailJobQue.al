//namespace CentralDB.CentralDB;

report 50453 "Email Stetements Job Que"
{
    ProcessingOnly = true;
    Caption = 'Email Job Que';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Member Category";
            DataItemTableView = where("Member Status" = filter(Active | Dormant));

            trigger OnAfterGetRecord()
            begin
                if "No." <> '00113028' then begin


                    if SaccoActivities.ValidEmailAddress(Members."E-Mail") then begin
                        // CurrReport.Skip();
                        Clear(CCRecipients);
                        Clear(BCCRecipients);
                        Clear(ToRecipients);

                        SaccoSetup.Get();
                        SaccoSetup.testfield("Email File Path");
                        CCRecipients.add(SaccoSetup."Statements E-Mail");
                        FileName := SaccoSetup."Email File Path" + Members."No." + '-' + 'Statement.pdf';
                        //EncryptedFileName := SaccoSetup."Email File Path" + Members."No." + '-' + 'EStatement.pdf';

                        //if FILE.Exists(FileName) then
                        //  FILE.Erase(FileName);


                        Cust.Reset;
                        Cust.SetRange("No.", Members."No.");
                        //Cust.SetFilter("Date Filter", '=%1', DMY2Date(31, 08, 2024));
                        //if Cust.FindFirst then
                        //  //Report.SaveAsPdf(Report::"Member Statement - Summary", FileName, Cust);

                        //if FILE.Exists(EncryptedFileName) then FILE.Erase(EncryptedFileName);
                        //if File.Exists(FileName) then
                        //   SaccoActivities.EncryptFile(FileName, EncryptedFileName, Cust."ID No.");


                        // if ReportAction = Reportaction::"Send Email" then begin

                        //TempBlob.BLOBImportFromServerFile(TempBlob, EncryptedFileName);
                        //TempBlob.BLOBImportFromServerFile(TempBlob, FileName);
                        //Base64 := Format(TempBlob.ToBase64String);

                        BodyMsg := ('Dear ' + Name);
                        BodyMsg += ('<br><br>');
                        BodyMsg += (BodyTxt);
                        BodyMsg += ('<br><br>');
                        BodyMsg += (RegardsTxt);
                        BodyMsg += ('<br>');
                        BodyMsg += (COMPANYNAME);
                        BodyMsg += ('<br><br>');
                        BodyMsg += ('<HR>');
                        BodyMsg += (DesclaimerTxt);

                        // SMTPMail.Create(Members."E-Mail", AccountStatementTxt, BodyMsg, true);

                        //SMTPMail.AddAttachment(EncryptedFileName, 'pdf', Base64);
                        ToRecipients.Add(Members."E-Mail");
                        /*
                        FileM.Open(FileName);
                        FileM.CreateInStream(InStr);
                        EmailMsg.Create(ToRecipients, AccountStatementTxt, BodyMsg, true, CCRecipients, BCCRecipients);
                        EmailMsg.AddAttachment(FileName, 'PDF', InStr);
                        if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then;
                        FileM.Close();
                        */

                        if EmailSend.Send(SMTPMail) then
                            j += 1;

                        //Message('test');

                        //if FILE.Exists(FileName) then
                        //  FILE.Erase(FileName);
                        /* if File.Exists(EncryptedFileName) then
                            File.Erase(EncryptedFileName); */
                    end;
                end
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        FileName, EncryptedFileName : Text;
        AccountStatementTxt: label 'MEMBER STATEMENT';
        SalutationTxt: label 'Dear Sir / Madam,';
        BodyTxt: label 'Please find attached you Member Statement. <br>.';
        RegardsTxt: label 'Kind Regards,';
        DesclaimerTxt: label 'This is a system generated email. please do not respond to this email';
        ProcessTxt: label 'Successfully Processed.';
        CompanyInformation: Record "Company Information";
        ReportAction: Option "Send Email","Save Only";
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        Cust: Record Members;
        FileManagement: Codeunit "File Management";
        SMTPSetup: Record "Email Account";
        SMTPMail: Codeunit "Email Message";

        SaccoSetup: Record "Sacco Setup";
        BodyMsg: Text;
        Base64: Text;
        EmailSend: Codeunit Email;
        RecepientEmail: Text;
        TempBlob: Record CustomTempBlob;
        MActivities: Codeunit "Member Activities";
        j: Integer;

        SaccoActivities: Codeunit "Sacco Activities";
        EmailMsg: Codeunit "Email Message";
        FileM: File;
        InStr: InStream;
        BCCRecipients: List of [Text];
        CCRecipients: List of [Text];
        ToRecipients: List of [Text];
        Email: Codeunit Email;
}
