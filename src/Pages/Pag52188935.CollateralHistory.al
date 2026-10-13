page 50783 "Collateral History"
{
    ApplicationArea = All;
    Caption = 'Collateral History';
    PageType = ListPart;
    SourceTable = "Collateral History";

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Col. Reg. No"; Rec."Col. Reg. No")
                {
                    ToolTip = 'Specifies the value of the Col. Reg. No field.';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                    ToolTip = 'Specifies the value of the Amount Guaranteed field.';
                }
            }
        }

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CurrPage.Editable := False;
    end;
}
