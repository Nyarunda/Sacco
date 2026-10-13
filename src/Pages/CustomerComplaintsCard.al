page 51128 "Customer Complaint Card"
{
    PageType = Card;
    SourceTable = "Customer Complaints";
    ApplicationArea = All;
    Caption = 'CRM Case Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case number.';
                }
                field("Service Type"; Rec."Service Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the service type for this case.';

                    trigger OnValidate()
                    begin
                        UpdateFieldVisibility();
                        CurrPage.Update();
                    end;
                }
                field("Reponsibility Center"; Rec."Reponsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department for this case.';
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this case is for a Member or Lead.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer number.';
                    caption = 'Member No.';

                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer name.';
                    caption = 'Member Name';
                    Editable = false;
                }
                field("Contact Phone"; Rec."Contact Phone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the contact phone number.';
                    editable = false;
                }
                field("Contact Email"; Rec."Contact Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the contact email address.';
                    editable = false;
                }
            }
            group(CaseDetails)
            {
                //Visible = IsFullFieldsVisible;
                Caption = 'Case Details';

                field("Case Details;"; Rec.Title)
                {
                    ApplicationArea = All;
                    Caption = 'Case Details';
                    ToolTip = 'Specifies the case title/subject.';
                    MultiLine = true;

                }
                field("Case Status"; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case status.';
                    Editable = false;

                }
                field("Case Priority"; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case priority.';

                }
                field("Case Source"; Rec."Case Source")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how the case was received.';

                }

                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case description.';
                    MultiLine = true;
                }

            }

            group(Assignment)
            {
                Caption = 'Assignment';


                Visible = IsFullFieldsVisible;
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the case is assigned to.';

                }
                field("Assigned To 2"; Rec."Assigned To 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the case is assigned to 2.';

                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department handling the case.';
                }
                field("Escalate To"; Rec."Escalate To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the case is Escalate to.';

                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who approved the case closure.';
                }

            }

        }
    }

    actions
    {
        area(Promoted)
        {
            group(Category_CaseActions)
            {
                Caption = '🔄 Case Actions';

                actionref(EscalateCase_Promoted; EscalateCase)
                {
                }
                // actionref(ResolveCase_Promoted; ResolveCase)
                // {
                // }
                actionref(CloseCase_Promoted; CloseCase)
                {
                }
            }
            group(Category_Communication)
            {
                Visible = false;
                Caption = '📧 Communication';

                actionref(SendEmail_Promoted; SendEmail)
                {
                }
                actionref(SendSMS_Promoted; SendSMS)
                {
                }
            }

        }

        area(Processing)
        {
            group(CaseManagement)
            {
                Caption = 'Case Management';

                action(EscalateCase)
                {
                    ApplicationArea = All;
                    Caption = 'Escalate Case';
                    Image = ImportExport;
                    ToolTip = 'Escalate the case to higher priority.';

                    trigger OnAction()
                    var
                        UserSetup: Record "User Setup";
                        SelectedUser: Code[50];
                    begin
                        if Confirm('Do you want to escalate this case?') then begin
                            // Open user setup lookup to select escalation user
                            if Page.RunModal(Page::"User Setup", UserSetup) = Action::LookupOK then begin
                                SelectedUser := UserSetup."User ID";

                                // Set the escalate to user with validation
                                Rec.Validate("Escalate To", SelectedUser);

                                // Increment escalation level
                                Rec."Escalation Level" := Rec."Escalation Level" + 1;
                                Rec."Last Escalated Date" := Today;

                                // Escalate priority if not already at highest level
                                case Rec.Priority of
                                    Rec.Priority::Low:
                                        Rec.Priority := Rec.Priority::Medium;
                                    Rec.Priority::Medium:
                                        Rec.Priority := Rec.Priority::High;
                                    Rec.Priority::High:
                                        Rec.Priority := Rec.Priority::Critical;
                                    Rec.Priority::Critical:
                                        ; // Already at highest level
                                end;

                                // Set status to escalated if not already resolved/closed
                                if Rec.Status in [Rec.Status::Open, Rec.Status::InProgress, Rec.Status::"Pending Customer", Rec.Status::Assigned] then
                                    Rec.Status := Rec.Status::Escalated;

                                // Save changes with validation
                                if Rec.Modify(true) then begin
                                    CurrPage.Update(false);

                                    // Send escalation notification email
                                    SendEscalationEmail(Rec."No.", Rec.Title, Rec."Escalation Level", Rec.Priority);

                                    Message('Case has been escalated to %1 (Level %2) with priority %3.',
                                        Rec."Escalate To", Rec."Escalation Level", Rec.Priority);
                                end else
                                    Error('Failed to save escalation changes.');
                            end else begin
                                Message('Case escalation cancelled.');
                            end;
                        end;
                    end;
                }
                // action(ResolveCase)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Resolve Case';
                //     Image = Completed;
                //     ToolTip = 'Mark the case as resolved.';

                //     trigger OnAction()
                //     begin
                //         if Confirm('Do you want to mark this case as resolved?') then begin
                //             Rec."Resolved Date" := Today;
                //             Rec."Resolved DateTime" := CurrentDateTime;
                //             Rec.Status := Rec.Status::Resolved;
                //             Rec."Closed Date" := Today;

                //             // Calculate resolution hours
                //             if Rec."Created DateTime" <> 0DT then begin
                //                 Rec."Resolution Hours" := Round((Rec."Resolved DateTime" - Rec."Created DateTime") / 3600000, 1);
                //             end;

                //             Rec.Status := Rec.Status::Resolved;

                //             Rec.Modify();

                //             // Send resolution notification email to customer
                //             SendResolutionEmail(Rec."No.", Rec.Title, Rec."Resolution Hours", Rec."Contact Email");

                //             Message('Case has been marked as resolved. Resolution time: %1 hours.', Rec."Resolution Hours");
                //         end;
                //     end;
                // }
                action(CloseCase)
                {
                    ApplicationArea = All;
                    Caption = 'Close Case';
                    Image = Close;
                    ToolTip = 'Close the case.';

                    trigger OnAction()
                    var
                        Msg: Text;
                        MemberActivities: Codeunit "Member Activities";
                        SMSSource: Enum "SMS Source Enum";
                        UserSetup: Record "User Setup";
                    begin
                        UserSetup.get(UserId);
                        if not UserSetup."Can Close Cases" then begin
                            Message('You do not have permission to close cases. Please contact your administrator.');
                            exit;
                        end;

                        if Confirm('Do you want to close this case?') then begin
                            // Ensure case is resolved before closing
                            if Rec.Status <> Rec.Status::Resolved then begin
                                if Confirm('This case is not resolved yet. Do you want to resolve it first?') then begin

                                    Msg := 'Thank you for visiting our office. Kindly take a moment to complete this short questionnaire https://forms.gle/GPUvk4mhFcFYDd819 Your feedback will help us serve you better.';

                                    if Rec."Contact Phone" <> '' then
                                        MemberActivities.SendSms(SMSSource::Bulk, Rec."Contact Phone", Msg, Rec."Member No.", '', false, false);


                                    // Auto-resolve the case
                                    Rec."Resolved Date" := Today;
                                    Rec.Status := Rec.Status::Closed;
                                    Rec."Resolved DateTime" := CurrentDateTime;
                                    Rec."Approved By" := UserId;

                                    // Calculate resolution hours if not already calculated
                                    if (Rec."Resolution Hours" = 0) and (Rec."Created DateTime" <> 0DT) then begin
                                        Rec."Resolution Hours" := Round((Rec."Resolved DateTime" - Rec."Created DateTime") / 3600000, 1);
                                    end;

                                end;
                            end;

                            // Close the case
                            Rec.Status := Rec.Status::Closed;
                            Rec.Modify();
                            CurrPage.Update();

                            // // Send closure notification email to customer
                            // SendClosureEmail(Rec."No.", Rec.Title, Rec."Contact Email");

                            // Message('Case has been closed successfully.');
                        end;
                    end;
                }
            }



            group(Communication)
            {
                Caption = 'Communication';

                action(SendEmail)
                {
                    ApplicationArea = All;
                    Caption = 'Send Email';
                    Image = Email;
                    ToolTip = 'Send an email regarding this case.';

                    trigger OnAction()
                    var
                        EmailMessage: Codeunit "Email Message";
                        Email: Codeunit Email;
                        Subject: Text;
                        Body: Text;
                        ToEmail: Text[250];
                    begin
                        // Get customer email
                        ToEmail := Rec."Contact Email";

                        if ToEmail = '' then begin
                            Message('No email address found for this customer.');
                            exit;
                        end;

                        Subject := StrSubstNo('Regarding Case: %1 - %2', Rec."No.", Rec.Title);
                        Body := StrSubstNo('Dear %1,\n\nThis is regarding your case:\n\nCase No.: %2\nTitle: %3\nStatus: %4\nPriority: %5\n\nWe will update you on any progress.\n\nBest regards,\nCustomer Support Team',
                            Rec."Customer Name", Rec."No.", Rec.Title, Rec.Status, Rec.Priority);

                        EmailMessage.Create(ToEmail, Subject, Body);
                        if Email.Send(EmailMessage) then
                            Message('Email sent successfully to %1', ToEmail)
                        else
                            Message('Failed to send email to %1', ToEmail);
                    end;
                }
                action(SendSMS)
                {
                    ApplicationArea = All;
                    Caption = 'Send SMS';
                    Image = ExportMessage;
                    ToolTip = 'Send an SMS regarding this case.';

                    trigger OnAction()
                    begin
                        // Add SMS functionality here
                        Message('SMS functionality to be implemented.');
                    end;
                }
            }

        }

    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Set default values for new records
        Rec."Created Date" := Today;
        Rec."Created DateTime" := CurrentDateTime;
        Rec."Created Time" := Time;
        UpdateFieldVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateFieldVisibility();
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

        UpdateFieldVisibility();
    end;

    local procedure UpdateFieldVisibility()
    begin
        // Show all fields for Case Management, hide most fields for Reception Service
        IsFullFieldsVisible := (Rec."Service Type" = Rec."Service Type"::"Case Management");
    end;

    var
        IsFullFieldsVisible: Boolean;

    // Email notification procedures
    local procedure SendAssignmentEmail(AssignedUser: Code[50]; CaseNo: Code[20]; CaseTitle: Text[100]; CustomerName: Text[100])
    var
        UserSetup: Record "User Setup";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Body: Text;
        CaseLink: Text;
    begin
        if AssignedUser = '' then exit;

        if UserSetup.Get(AssignedUser) then begin
            if UserSetup."E-Mail" <> '' then begin
                // Create direct link to case
                CaseLink := GetCaseUrl(CaseNo);

                Subject := StrSubstNo('Case Assignment: %1 - %2', CaseNo, CaseTitle);
                Body := StrSubstNo('Dear %1,<br><br>A new case has been assigned to you:<br><br><strong>Case No.:</strong> %2<br><strong>Title:</strong> %3<br><strong>Customer:</strong> %4<br><br><a href="%5" style="background-color: #0078d4; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">Open Case</a><br><br>Please review and take appropriate action.<br><br>Best regards,<br>CRM System',
                    AssignedUser, CaseNo, CaseTitle, CustomerName, CaseLink);

                EmailMessage.Create(UserSetup."E-Mail", Subject, Body, true); // true for HTML format
                Email.Send(EmailMessage);
            end;
        end;
    end;

    local procedure SendEscalationEmail(CaseNo: Code[20]; CaseTitle: Text[100]; EscalationLevel: Integer; Priority: Enum "Case Priority")
    var
        UserSetup: Record "User Setup";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Body: Text;
        ToEmail: Text[250];
        CaseLink: Text;
    begin
        // Send to current assigned user and their manager
        if Rec."Assigned To" <> '' then begin
            if UserSetup.Get(Rec."Assigned To") then begin
                if UserSetup."E-Mail" <> '' then begin
                    ToEmail := UserSetup."E-Mail";
                end;
            end;
        end;

        if ToEmail <> '' then begin
            // Create direct link to case
            CaseLink := GetCaseUrl(CaseNo);

            Subject := StrSubstNo('🚨 ESCALATED Case: %1 - Level %2', CaseNo, EscalationLevel);
            Body := StrSubstNo('<div style="border-left: 5px solid #dc3545; padding-left: 20px;"><h3 style="color: #dc3545;">URGENT: Case has been escalated</h3><br><strong>Case No.:</strong> %1<br><strong>Title:</strong> %2<br><strong>Escalation Level:</strong> %3<br><strong>Priority:</strong> %4<br><br><a href="%5" style="background-color: #dc3545; color: white; padding: 12px 24px; text-decoration: none; border-radius: 5px; font-weight: bold;">🚀 OPEN CASE IMMEDIATELY</a><br><br><span style="color: #dc3545; font-weight: bold;">Immediate attention required.</span><br><br>Best regards,<br>CRM System</div>',
                CaseNo, CaseTitle, EscalationLevel, Priority, CaseLink);

            EmailMessage.Create(ToEmail, Subject, Body, true); // true for HTML format
            Email.Send(EmailMessage);
        end;
    end;

    local procedure SendResolutionEmail(CaseNo: Code[20]; CaseTitle: Text[100]; ResolutionHours: Decimal; CustomerEmail: Text[80])
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Body: Text;
    begin
        if CustomerEmail <> '' then begin
            Subject := StrSubstNo('Case Resolved: %1', CaseNo);
            Body := StrSubstNo('Dear Customer,\n\nYour case has been resolved:\n\nCase No.: %1\nTitle: %2\nResolution Time: %3 hours\n\nThank you for your patience.\n\nBest regards,\nCustomer Support Team',
                CaseNo, CaseTitle, ResolutionHours);

            EmailMessage.Create(CustomerEmail, Subject, Body);
            Email.Send(EmailMessage);
        end;
    end;

    local procedure SendClosureEmail(CaseNo: Code[20]; CaseTitle: Text[100]; CustomerEmail: Text[80])
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Body: Text;
    begin
        if CustomerEmail <> '' then begin
            if Rec."Service Type" = Rec."Service Type"::"Case Management" then begin
                Subject := StrSubstNo('Case Closed: %1', CaseNo);
                Body := StrSubstNo('Dear Customer,<br><br>Your case has been closed:<br><br>Case No.: %1<br>Title: %2<br><br>If you need further assistance, please call 0709309000.<br><br>Thank you for choosing our services.<br><br>Best regards,<br>Kentours SACCO',
                    CaseNo, CaseTitle);

                EmailMessage.Create(CustomerEmail, Subject, '');
                EmailMessage.AppendToBody(Body);
                Email.Send(EmailMessage);
            end;
            if Rec."Service Type" = Rec."Service Type"::"Reception Service" then begin
                Subject := StrSubstNo('Case Closed: %1', CaseNo);
                Body := 'Thank you for visiting our office. Kindly take a moment to complete this short questionnaire https://forms.gle/GPUvk4mhFcFYDd819 Your feedback will help us serve you better.';

                EmailMessage.Create(CustomerEmail, Subject, Body);
                Email.Send(EmailMessage);
            end;
        end;
    end;

    local procedure GetCaseUrl(CaseNo: Code[20]): Text
    var
        EnvironmentInfo: Codeunit "Environment Information";
        TenantInfo: Codeunit "Tenant Information";
        BaseUrl: Text;
    begin
        // Create a direct link to the case card page
        BaseUrl := StrSubstNo('https://businesscentral.dynamics.com/?page=50499&filter=''Case Header''.''No.'' IS ''%1''', CaseNo);
        exit(BaseUrl);
    end;
}
