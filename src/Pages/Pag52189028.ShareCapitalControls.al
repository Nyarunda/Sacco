namespace CentralDB.CentralDB;

page 50730 "Share Capital Controls"
{
    ApplicationArea = All;
    Caption = 'Share Capital Controls';
    PageType = ListPart;
    SourceTable = "Share Capital Controls";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Minumum; Rec.Minimum)
                {
                    ToolTip = 'Specifies the value of the Minimum field.', Comment = '%';
                }
                field(Maximum; Rec.Maximum)
                {
                    ToolTip = 'Specifies the value of the Maximum field.', Comment = '%';
                }
                field("Capitilize Amount %"; Rec."Capitilize Amount %")
                {
                    ToolTip = 'Specifies the value of the Capitilize  % field.', Comment = '%';
                }
            }
        }
    }
}
