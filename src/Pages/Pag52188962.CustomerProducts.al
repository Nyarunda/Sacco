namespace CentralDB.CentralDB;

page 50664 "Customer Products"
{
    ApplicationArea = All;
    Caption = 'Customer Products';
    PageType = List;
    SourceTable = "Customer Products";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Product Code"; Rec."Product Code")
                {
                    ToolTip = 'Specifies the value of the Product Code field.';
                }
            }
        }
    }
}
