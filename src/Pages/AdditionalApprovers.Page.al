Page 50457 "Additional Approvers"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Additional Approvers';
    PageType = List;
    SourceTable = "Additional Approvers";
    SourceTableView = sorting("Sequence No.");

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(ApproverID; Rec."Approver ID")
                {
                    ApplicationArea = Basic;
                }
                field(LimitType; Rec."Limit Type")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovalCode; Rec."Approval Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApprovalType; Rec."Approval Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Custom Document Type"; Rec."Custom Document Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DocumentType; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SequenceNo; Rec."Sequence No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }
}

