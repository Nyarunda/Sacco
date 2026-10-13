namespace CentralDB.CentralDB;

page 50677 "Product Loan Documents"
{
    ApplicationArea = All;
    Caption = 'Product Loan Documents';
    PageType = List;
    SourceTable = "Product Loan Documents";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
