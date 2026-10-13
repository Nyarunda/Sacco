namespace UnitedWomen_Production.UnitedWomen_Production;

page 50112 "Industry Type List"
{
    ApplicationArea = All;
    Caption = 'Industry Type List';
    PageType = List;
    SourceTable = "Industry Type";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
