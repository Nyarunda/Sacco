report 50455 "E-Mail Staff Payslip"
{
    ApplicationArea = All;
    Caption = 'E-Mail Staff Payslip';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = where(Status = filter(Active));
            RequestFilterFields = "No.", "Date Filter";
            column(ReportForNavId_1; 1)
            {
            }


            trigger OnAfterGetRecord()
            var
                TempBlob: Codeunit "Temp Blob";
                Email: Codeunit Email;
                EmailMessage: Codeunit "Email Message";

                InStr: InStream;
                OutStr: OutStream;
                Recipients: List of [Text];
                CCRecipients: List of [Text];
                BCCRecipients: List of [Text];
                RecipientEmailToUse: Text;
                FileName: Text;
                BodyMsg: Text;
                Emp: Record Employee;
                StaffPayslipReport: Report "Staff Payslip";
                AccountStatementTxt: Label 'Employee Payslip';
                BodyTxt: Label 'Please find attached your payslip for the current period.';
                RegardsTxt: Label 'Best Regards,';
                DesclaimerTxt: Label 'This is a system generated email. Please do not reply.';
                CompanyName: Text;
            begin
                RecipientEmailToUse := RecepientEmail;

                if RecipientEmailToUse = '' then
                    RecipientEmailToUse := Employee."E-Mail";

                if not SaccoActivities.ValidEmailAddress(RecipientEmailToUse) then
                    CurrReport.Skip();

                CurrentRecordNo += 1;

                // Update progress dialog
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                if NoOfRecords > 0 then
                    dWindow.Update(1, Round(CurrentRecordNo / NoOfRecords * 10000, 1));

                CompanyName := CompanyProperty.DisplayName();

                // Generate filename for display purposes
                FileName := Employee."No." + '-Payslip.pdf';

                // Generate payslip report to TempBlob
                Emp.Reset();
                Emp.SetRange("No.", "No.");
                Emp.SetFilter("Date Filter", Employee.GetFilter("Date Filter"));
                if Emp.FindFirst() then begin
                    if Emp."National Id" = '' then
                        Emp."National Id" := Emp."Personal ID No.";

                    if Emp."National Id" = '' then
                        Emp.TestField("National Id", 'Employee must have a National ID to generate payslip.');

                    TempBlob.CreateOutStream(OutStr);

                    // Initialize and run the payslip report
                    Clear(StaffPayslipReport);
                    StaffPayslipReport.SetTableView(Emp);
                    if StaffPayslipReport.SaveAs('', ReportFormat::Pdf, OutStr) then begin

                        // Handle encryption if needed (you'll need to adapt this based on your encryption method)
                        // Since we can't use file system, you might need to encrypt the stream data directly
                        // or implement in-memory encryption through your SaccoActivities codeunit

                        if ReportAction = ReportAction::"Send Email" then begin

                            // Prepare email content
                            BodyMsg := 'Dear ' + Emp.FullName();
                            BodyMsg += '<br><br>';
                            BodyMsg += BodyTxt;
                            BodyMsg += '<br><br>';
                            BodyMsg += RegardsTxt;
                            BodyMsg += '<br>';
                            BodyMsg += CompanyName;
                            BodyMsg += '<br><br>';
                            BodyMsg += '<HR>';
                            BodyMsg += DesclaimerTxt;

                            // Create and send email
                            Clear(Recipients);
                            Clear(CCRecipients);
                            Clear(BCCRecipients);

                            Recipients.Add(RecipientEmailToUse);
                            EmailMessage.Create(Recipients, AccountStatementTxt, BodyMsg, true, CCRecipients, BCCRecipients);

                            // Add attachment from TempBlob
                            // Note: If you need encryption, you'll need to modify SaccoActivities to work with streams
                            TempBlob.CreateInStream(InStr);
                            EmailMessage.AddAttachment(FileName, 'application/pdf', InStr);

                            // Send email
                            if Email.Send(EmailMessage, Enum::"Email Scenario"::HR) then
                                j += 1;
                        end;
                    end;
                end;
            end;


            trigger OnPostDataItem()
            begin
                dWindow.Close;
                Message('%1 Email(s) Sent', j);
            end;

            trigger OnPreDataItem()
            begin
                //if SMTPSetup.Get then
                //SMTPSetup.TestField("File Path");
                CompanyInformation.Get;

                dWindow.Open('Generating Statements:    @1@@@@@@@@@\'
                                            + 'Counter   #2#########\'
                                            + 'Total     #3#########\'
                                            + 'Press Esc to abort');

                NoOfRecords := Employee.Count;
                CurrentRecordNo := 0;
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                SaccoSetup.Get();
                //SaccoSetup.testfield("Email File Path");
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
                field(RecepientEmail; RecepientEmail)
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
        FileName, EncryptedFileName : Text;
        AccountStatementTxt: label 'STAFF PAYSLIP';
        SalutationTxt: label 'Dear Sir / Madam,';
        BodyTxt: label 'Please find attached you Staff Payslip. <br>. Please note that the statement has been encrypted. Use your ID as the password.';
        RegardsTxt: label 'Kind Regards,';
        DesclaimerTxt: label 'This is a system generated email. please do not respond to this email';
        ProcessTxt: label 'Successfully Processed.';
        CompanyInformation: Record "Company Information";
        ReportAction: Option "Send Email","Save Only";
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        Emp: Record Employee;
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




}
