page 50599 "STO Recovery Priority List"
{
    ApplicationArea = All;
    Caption = 'STO Recovery Priority List';
    PageType = List;
    SourceTable = "STO Recovery Priority";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Destination Acc. Type"; Rec."Destination Acc. Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Acc. Type field.';
                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recovery Priority field.';
                }
            }
        }
    }
}
