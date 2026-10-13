page 50554 "Sky Search Options"
{
    Caption = 'Sky Search Options';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Sky Search Options";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(Caption; Rec.Caption)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Caption field.';
                }
            }
        }
    }
}
