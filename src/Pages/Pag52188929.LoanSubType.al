page 50631 "Loan Sub. Type"
{
    ApplicationArea = All;
    Caption = 'Loan Sub. Type';
    PageType = ListPart;
    SourceTable = "Loan Sub. Types";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Product Sub. Type"; Rec."Product Sub. Type")
                {
                    ToolTip = 'Specifies the value of the Product Sub. Type field.';
                }
                field("Minimum Loan Amount"; Rec."Minimum Loan Amount")
                {
                    ToolTip = 'Specifies the value of the Minimum Loan Amount field.';
                }
                field("Maximum Loan Amount"; Rec."Maximum Loan Amount")
                {
                    ToolTip = 'Specifies the value of the Maximum Loan Amount field.';
                }
                field(Installement; Rec.Installement)
                {
                    ToolTip = 'Specifies the value of the Installement field.';
                }
                field(Interest; Rec.Interest)
                {
                    ToolTip = 'Specifies the value of the Interest field.';
                }
            }
        }
    }
}
