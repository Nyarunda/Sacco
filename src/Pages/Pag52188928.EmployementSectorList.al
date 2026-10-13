/// <summary>
/// Page Employement Sector List (ID 50630).
/// </summary>
page 50630 "Employement Sector List"
{
    ApplicationArea = All;
    Caption = 'Employement Sector List';
    PageType = List;
    SourceTable = "Employement Sectors";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
            }
        }
    }
}