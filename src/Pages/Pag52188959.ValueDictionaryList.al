namespace CentralDB.CentralDB;

page 50661 "Value Dictionary List"
{
    ApplicationArea = All;
    Caption = 'Value Dictionary List';
    PageType = List;
    SourceTable = "VALUE DICTIONARY";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Rating; Rec.Rating)
                {
                    ToolTip = 'Specifies the value of the Rating field.';
                }
            }
        }
    }
}
