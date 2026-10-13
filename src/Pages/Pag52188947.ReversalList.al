page 50649 "Reversal List"
{
    ApplicationArea = All;
    Caption = 'Reversal List';
    PageType = List;
    CardPageId = "Reversal Card";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Reversal Header";
    UsageCategory = Lists;



    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Reversal No."; Rec."Reversal No.")
                {
                    ToolTip = 'Specifies the value of the Reversal No. field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }

                field("Account Type"; Rec."Account Type")
                {

                }
                field("Account No"; Rec."Account No")
                {
                }

                field(Amount; Rec.Amount)
                {
                    editable = false;
                }
                field(Description; Rec.Description)
                {
                    editable = false;
                }
                field("Reponsibility Center"; Rec."Reponsibility Center")
                {
                }
                field(Branch; Rec.Branch)
                {
                }

                field("Time Posted"; Rec."Time Posted")
                {
                    editable = false;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    editable = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    editable = false;
                }
                field("Reversed By"; Rec."Reversed By")
                {
                    editable = false;
                }
                field(Reason; Rec.Reason)
                {

                }
            }
        }
    }
}
