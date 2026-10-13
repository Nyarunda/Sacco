
Page 50338 "Imprest Surrender Lines"
{
    PageType = ListPart;
    SourceTable = "Imprest Surrender Lines";

    layout
    {
        area(content)
        {
            repeater(Control18)
            {
                field(AccountNo; Rec."Account No:")
                {
                    ApplicationArea = Basic;
                }
                field(Purpose; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Purpose';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ActualSpent; Rec."Actual Spent")
                {
                    ApplicationArea = Basic;
                }
                field(CashReceiptNo; Rec."Cash Receipt No")
                {
                    ApplicationArea = Basic;
                }
                field(CashReceiptAmount; Rec."Cash Receipt Amount")
                {
                    ApplicationArea = Basic;
                }
                field(ImprestHolder; Rec."Imprest Holder")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Applyto; Rec."Apply to")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

