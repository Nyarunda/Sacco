namespace CentralDB.CentralDB;

page 50714 "Paybill Keywords"
{
    ApplicationArea = All;
    Caption = 'Paybill Keywords';
    PageType = List;
    SourceTable = "Loan Paybill Keywords";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Keyword; Rec.Keyword)
                {
                    ToolTip = 'Specifies the value of the Keyword field.', Comment = '%';
                }
                field("Product Code"; Rec."Product Code")
                {
                    ToolTip = 'Specifies the value of the Product Code field.', Comment = '%';
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ToolTip = 'Specifies the value of the Destination Type field.', Comment = '%';
                }
            }
        }
    }
}
