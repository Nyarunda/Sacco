page 50456 "Vehicle classes"
{
    Caption = 'Vehicle classes';
    PageType = List;
    SourceTable = "Vehicle Class Category";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Vehicle Category"; Rec."Vehicle Category")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Category Description"; Rec."Vehicle Category Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
