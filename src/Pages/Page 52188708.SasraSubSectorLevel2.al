page 50371 "Sasra Sub-Sector Level 2"
{
    Caption = 'Sasra Sub-Sector Level 2';
    PageType = List;
    SourceTable = "Sasra Sectorial Level 2";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Main Sector"; Rec."Main Sector")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Main Sector field.';
                }
                field("Sub-Sector Level 1 Code"; Rec."Sub-Sector Level 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub-Sector Level 1 Code field.';
                }
                field("Sub-Sector Level 2 Code"; Rec."Sub-Sector Level 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub-Sector Level 2 Code field.';
                }
                field("Sub-Sector Level 2 Description"; Rec."Sub-Sector Level 2 Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub-Sector Level 2 Description field.';
                }
            }
        }
    }
}
