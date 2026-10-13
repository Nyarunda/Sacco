namespace CentralDB.CentralDB;

page 50701 "Vehicle Class Category"
{
    ApplicationArea = All;
    Caption = 'Vehicle Class Category';
    PageType = List;
    SourceTable = "Vehicle Class Category";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Vehicle Category"; Rec."Vehicle Category")
                {
                    ToolTip = 'Specifies the value of the Vehicle Category field.', Comment = '%';
                }
                field("Vehicle Category Description"; Rec."Vehicle Category Description")
                {
                    ToolTip = 'Specifies the value of the Vehicle Category Description field.', Comment = '%';
                }
            }
        }
    }
}
