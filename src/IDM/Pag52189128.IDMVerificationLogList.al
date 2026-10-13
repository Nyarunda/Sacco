page 50887 "IDM Verification Log List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "IDM Verification Log";
    Caption = 'IDM Verification Log';
    Editable = false;
    CardPageId = "IDM Verification Log Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique log entry number.';
                }
                field("Request Date Time"; Rec."Request Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date and time the verification was requested.';
                }
                field("Verification Type"; Rec."Verification Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type of verification performed.';
                }
                field(Identifier; Rec.Identifier)
                {
                    ApplicationArea = All;
                    ToolTip = 'The primary value verified (ID number, KRA PIN, plate number, etc.).';
                }
                field("Secondary Identifier"; Rec."Secondary Identifier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Secondary value used in the verification (e.g. phone number or bank code).';
                    Visible = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Member number linked to this verification.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the linked member.';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full name returned from the verification service.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Verification result status.';
                    StyleExpr = StatusStyle;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    ToolTip = 'User who performed the verification.';
                }
                field("Additional Info"; Rec."Additional Info")
                {
                    ApplicationArea = All;
                    ToolTip = 'Key information extracted from the verification response.';
                }
                field("Error Code"; Rec."Error Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Error code returned by the API, if applicable.';
                    Visible = false;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Error message if the verification failed.';
                }
                field("HTTP Status Code"; Rec."HTTP Status Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'HTTP status code returned by the API.';
                    Visible = false;
                }
                field("Response Date Time"; Rec."Response Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date and time the API responded.';
                    Visible = false;
                }
                field("API Request ID"; Rec."API Request ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique request ID sent to the Calwide IDM API.';
                    Visible = false;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(IDMSetup)
            {
                ApplicationArea = All;
                Caption = 'IDM Setup';
                ToolTip = 'Open the Calwide IDM API setup.';
                Image = Setup;
                RunObject = Page "IDM Setup";
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        case Rec.Status of
            Rec.Status::Success:
                StatusStyle := 'Favorable';
            Rec.Status::Failed:
                StatusStyle := 'Unfavorable';
            Rec.Status::"Not Found":
                StatusStyle := 'Attention';
            else
                StatusStyle := 'Standard';
        end;
    end;

    var
        StatusStyle: Text;
}
