namespace Kentours.Kentours;

page 51109 "Defaulter Loan Selection"
{
    ApplicationArea = All;
    Caption = 'Defaulter Loan Selection';
    PageType = List;
    SourceTable = "Defaulter Loan Selection";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    Caption = 'Loan No.';
                    ToolTip = 'Specifies the loan number.';
                }
                field("Amount To Distribute"; Rec."Amount To Distribute")
                {
                    Caption = 'Amount To Distribute';
                    ToolTip = 'Specifies the amount to distribute.';
                }
            }
        }
    }
}
