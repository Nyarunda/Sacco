page 50370 "Sasra Sub-Sector Level 1"
{
    Caption = 'Sasra Sub-Sector Level 1';
    PageType = List;
    SourceTable = "Sasra Sectorial Level 1";

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
                field("Sub-Sector Level 1 Code"; Rec."Sub-Sector Level 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub-Sector Level 1 Code  field.';
                }
                field("Sub-Sector Level 1 Description"; Rec."Sub-Sector Level 1 Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub-Sector Level 1 Description field.';
                }
            }
        }
    }
}
