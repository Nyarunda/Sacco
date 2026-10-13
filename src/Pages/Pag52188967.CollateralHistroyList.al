namespace CentralDB.CentralDB;

page 50669 "Collateral Histroy List"
{
    ApplicationArea = All;
    Caption = 'Collateral Histroy List';
    CardPageId = "Collateral History Card";
    PageType = List;
    SourceTable = "Collateral Valuation History";
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Col. Reg. No."; Rec."Col. Reg. No.")
                {
                    ToolTip = 'Specifies the value of the Col. Reg. No. field.';
                }
                field("Charged Value"; Rec."Charged Value")
                {
                    ToolTip = 'Specifies the value of the Charged Value field.';
                }
                field("Date Charged"; Rec."Date Charged")
                {
                    ToolTip = 'Specifies the value of the Date Charged field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(User; Rec.User)
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field("Valuation Date"; Rec."Valuation Date")
                {
                    ToolTip = 'Specifies the value of the Valuation Date field.';
                }
                field("Valuation Value"; Rec."Valuation Value")
                {
                    ToolTip = 'Specifies the value of the Valuation Value field.';
                }
            }
        }
    }
}
