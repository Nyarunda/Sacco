/// <summary>
/// Page Loan Repay Mode (ID 50620).
/// </summary>
page 50620 "Loan Repay Mode"
{
    ApplicationArea = All;
    Caption = 'Loan Repay Mode';
    PageType = ListPart;
    SourceTable = "Loan Repay Mode";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Repay Mode"; Rec."Repay Mode")
                {
                    ToolTip = 'Specifies the value of the Repay Mode field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }
}
