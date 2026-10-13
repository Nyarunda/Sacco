page 50369 "Sasra Main Sector"
{
    Caption = 'Sasra Main Sector';
    PageType = List;
    SourceTable = "Sasra Main Sector";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Main Sector Code"; Rec."Main Sector Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Main Sector Code field.';
                }
                field("Main Sector Description"; Rec."Main Sector Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Main Sector Description field.';
                }
            }
        }
    }
}
