


// Escalation History List Page
page 50523 "Escalation History List"
{
    ApplicationArea = All;
    Caption = 'Escalation History';
    PageType = List;
    SourceTable = "Escalation History";
    UsageCategory = History;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                }
                field("Rule Code"; Rec."Rule Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the escalation rule code.';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source type.';
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source document number.';
                }
                field("Escalated To User ID"; Rec."Escalated To User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user ID that the issue was escalated to.';
                }
                field("Escalation Date"; Rec."Escalation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the escalation occurred.';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the escalation.';
                }
                field("Resolution Date"; Rec."Resolution Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the escalation was resolved.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created this escalation entry.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Mark as Resolved")
            {
                ApplicationArea = All;
                Caption = 'Mark as Resolved';
                Image = Approve;
                ToolTip = 'Mark the selected escalation as resolved.';

                trigger OnAction()
                begin
                    if Rec."Status" = Rec."Status"::Resolved then
                        Error('Escalation is already resolved.');

                    Rec."Status" := Rec."Status"::Resolved;
                    Rec."Resolution Date" := CurrentDateTime;
                    Rec.Modify(true);
                    Message('Escalation marked as resolved.');
                end;
            }
        }
    }
}