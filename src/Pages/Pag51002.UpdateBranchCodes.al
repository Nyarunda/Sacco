page 51004 "Update Branch Codes"
{
    Caption = 'Update Branch Codes';
    PageType = List;
    SourceTable = "Update Branch Codes";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Check No."; Rec."Check No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Check No. field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Updated field.';
                }
            }
        }
    }
}
