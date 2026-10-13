page 55032 "Valuation History"
{
    ApplicationArea = All;
    Caption = 'Valuation History';
    PageType = List;
    CardPageId = "Collateral History Card";
    SourceTable = "Collateral Valuation History";
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Col. Reg. No."; Rec."Col. Reg. No.")
                {
                    ToolTip = 'Specifies the value of the Col. Reg. No. field.';
                }
                field("Valuation Date"; Rec."Valuation Date")
                {
                    ToolTip = 'Specifies the value of the Valuation Date field.';
                }
                field("Original Valuation Value"; Rec."Original Valuation Value")
                {
                    ToolTip = 'Specifies the value of the Original Valuation Value field.';
                }
                field("Valuation Value"; Rec."Valuation Value")
                {
                    ToolTip = 'Specifies the value of the Valuation Value field.';
                }
                field("Original Charged Value"; Rec."Original Charged Value")
                {
                    ToolTip = 'Specifies the value of the Original Charged Value field.';
                }
                field("Charged Value"; Rec."Charged Value")
                {
                    ToolTip = 'Specifies the value of the Charged Value field.';
                }
                field("Date Charged"; Rec."Date Charged")
                {
                    ToolTip = 'Specifies the value of the Date Charged field.';
                }

            }
        }
    }
}
