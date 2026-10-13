namespace Wanandage.Wanandage;

page 50768 "Mobile Loan Limit"
{
    ApplicationArea = All;
    Caption = 'Mobile Loan Limit';
    PageType = ListPart;
    SourceTable = "Mobile Loan Limit";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    Editable = false;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ToolTip = 'Specifies the value of the Loan Type field.', Comment = '%';
                }
                field("Repay Mode"; Rec."Repay Mode")
                {
                    ToolTip = 'Specifies the value of the Loan Rapay Mode field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Mobile Loan Limit field.', Comment = '%';
                }
            }
        }
    }
}
