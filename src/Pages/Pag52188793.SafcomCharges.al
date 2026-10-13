page 50475 "Safcom Charges"
{
    Caption = 'Safcom Charges';
    PageType = List;
    SourceTable = "Safcom Charges";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Minimum; Rec.Minimum)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum field.';
                }
                field(Maximum; Rec.Maximum)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum field.';
                }
                field(Charge; Rec.Charge)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge field.';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field.';
                }
            }
        }
    }
}
