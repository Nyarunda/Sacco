page 50890 "IDM Verification Log Part"
{
    PageType = ListPart;
    SourceTable = "IDM Verification Log";

    Caption = 'Verification History';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Log entry number.';
                    Width = 5;
                }

                field("Request Date Time"; Rec."Request Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'When the verification was requested.';
                }
                field("Verification Type"; Rec."Verification Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type of verification performed.';
                }
                field(Identifier; Rec.Identifier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Primary identifier that was verified.';
                }
                field("Secondary Identifier"; Rec."Secondary Identifier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Secondary identifier (e.g. phone number or bank code).';
                    Visible = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Linked member number.';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full name returned by the verification service.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Verification outcome.';
                    StyleExpr = StatusStyle;
                }
                field("Additional Info"; Rec."Additional Info")
                {
                    ApplicationArea = All;
                    ToolTip = 'Key details from the response.';
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Error message if verification failed.';
                    Visible = false;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    ToolTip = 'User who performed the verification.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenCard)
            {
                ApplicationArea = All;
                Caption = 'View Details';
                ToolTip = 'Open the full log entry for this verification.';
                Image = ViewDetails;


                trigger OnAction()
                begin
                    Page.Run(Page::"IDM Verification Log Card", Rec);
                end;
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
