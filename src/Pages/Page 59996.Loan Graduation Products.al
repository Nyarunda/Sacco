page 59996 "Loan Graduation Products"
{
    PageType = ListPart;
    SourceTable = "Loan Graduation Product";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                }
                field("Product Role"; Rec."Product Role")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
