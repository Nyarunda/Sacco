page 50705 "Custom SMTP Setup"
{
    Caption = 'Custom SMTP Setup';
    PageType = Card;
    SourceTable = "Custom SMTP Setup";
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("SMTP Server"; Rec."SMTP Server")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SMTP Server field.', Comment = '%';
                }
                field(Authentication; Rec.Authentication)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Authentication field.', Comment = '%';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
                field("SMTP Server Port"; Rec."SMTP Server Port")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SMTP Server Port field.', Comment = '%';
                }
                field("Secure Connection"; Rec."Secure Connection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Secure Connection field.', Comment = '%';
                }
                field("Password Key"; Rec."Password Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Password Key field.', Comment = '%';
                    ExtendedDatatype = Masked;
                }
                field("Send As"; Rec."Send As")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Send As field.', Comment = '%';
                }
                field("Allow Sender Substitution"; Rec."Allow Sender Substitution")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow Sender Substitution field.', Comment = '%';
                }
                field("Test Email"; Rec."Test Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Test Email field.', Comment = '%';
                }
            }
        }
    }



    actions
    {
        area(Navigation)
        {
            action(SendTestMail)
            {
                ApplicationArea = Basic;
                Caption = 'Send Test Email';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    myInt: Integer;
                    SMTP: Codeunit SMTP;
                    Msg: Text;
                begin
                    IF CONFIRM('Are you sure you want to send test email?') THEN BEGIN
                        Msg := '';
                        SMTP.SendCustomEmail(Rec."User ID", Rec."Test Email", '', '', 'TEST EMAIL FROM' + CompanyName, 'Test Email from ' + UserId, '', Msg);
                        Message(Msg);
                    END;
                end;
            }
        }
    }
}
