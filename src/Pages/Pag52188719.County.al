page 50396 County
{
    ApplicationArea = All;
    Caption = 'County';
    PageType = List;
    SourceTable = COunty;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
            }
        }
    }
}
