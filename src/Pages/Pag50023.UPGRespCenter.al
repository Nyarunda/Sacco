page 50023 "UPG_Resp. Center"
{
    Caption = 'UPG_Resp. Center';
    PageType = List;
    SourceTable = "Responsibility Center";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsibility center code.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name.';
                }
            }
        }
    }
}
