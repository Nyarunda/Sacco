page 50379 "Employment Section"
{
    ApplicationArea = All;
    Caption = 'Employment Section';
    PageType = List;
    SourceTable = "Employment Sections";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Section field.';
                }
            }
        }
    }
}
