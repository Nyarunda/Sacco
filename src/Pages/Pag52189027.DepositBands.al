namespace CentralDB.CentralDB;

page 50729 "Deposit Bands"
{
    ApplicationArea = All;
    Caption = 'Deposit Bands';
    PageType = ListPart;
    SourceTable = "Deposit Bands";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Minimum; Rec.Minimum)
                {
                    ToolTip = 'Specifies the value of the Minimum field.', Comment = '%';
                }
                field(Maximum; Rec.Maximum)
                {
                    ToolTip = 'Specifies the value of the Maximum field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
            }
        }
    }
}
