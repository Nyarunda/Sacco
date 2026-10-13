page 51083 "Loan Share Capital Bands"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Loan Share Capital Bands';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Loan Share Capital Band";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan Product"; Rec."Loan Product")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Leave as zero to make this band open-ended.';
                }
                field("Required Share Capital"; Rec."Required Share Capital")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}
