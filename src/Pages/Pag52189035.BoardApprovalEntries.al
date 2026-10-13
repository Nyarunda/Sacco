namespace AL_.AL_;

page 50737 "Board Approval Entries"
{
    ApplicationArea = All;
    Caption = 'Board Approval Entries';
    PageType = ListPart;
    Editable = false;
    SourceTable = "Committee Approval Entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Approver Details"; Rec."Approver Details")
                {
                    ToolTip = 'Specifies the value of the Approver Details field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Document Amount"; Rec."Document Amount")
                {
                    ToolTip = 'Specifies the value of the Document Amount field.', Comment = '%';
                }
                field("Description 1"; Rec."Description 1")
                {
                    ToolTip = 'Specifies the value of the Description 1 field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Approved By field.', Comment = '%';
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ToolTip = 'Specifies the value of the Rejected By field.', Comment = '%';
                }
            }
        }
    }
}
