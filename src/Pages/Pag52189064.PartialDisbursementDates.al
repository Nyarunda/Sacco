namespace Wanandage.Wanandage;

page 50766 "Partial Disbursement Dates"
{
    ApplicationArea = All;
    Caption = 'Partial Disbursement Dates';
    PageType = List;
    SourceTable = "Partial Disbursement Dates";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.', Comment = '%';
                }
                field("Disbursement Date"; Rec."Disbursement Date")
                {
                    ToolTip = 'Specifies the value of the Disbursement Date field.', Comment = '%';
                }
            }
        }
    }
}
