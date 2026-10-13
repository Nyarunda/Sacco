page 50598 "GL Balances"
{
    Caption = 'GL Balances';
    PageType = List;
    SourceTable = "GL Balances";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the G/L Account field.';
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the G/L Account Name field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field("Income/Balance"; Rec."Income/Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Income/Balance field.';
                }
            }
        }
    }
}
