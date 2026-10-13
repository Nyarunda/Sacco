page 50782 "CRB Submission List"
{
    Caption = 'CRB Submission List';
    PageType = List;
    SourceTable = "CRB Submission Header";
    CardPageId = "CRB Submission Card";
    Editable = false;
    DeleteAllowed = false;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Captured By field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Success; Rec.Success)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Success field.', Comment = '%';
                }
                field("Has Error"; Rec."Has Error")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Has Error field.', Comment = '%';
                }
                field("Api Code"; Rec."Api Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Api Code field.', Comment = '%';
                }
                field("Api Code Description"; Rec."Api Code Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Api Code Description field.', Comment = '%';
                }
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction ID field.', Comment = '%';
                }
            }
        }
    }
}
