page 50452 "HR Vehicle List"
{
    ApplicationArea = All;
    Caption = 'HR Vehicle List';
    PageType = List;
    SourceTable = "HR Vehicle List";
    CardPageId = "HR Vehicle Card";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Registration No"; Rec."Registration No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registration No field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Make "; Rec."Make")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Make  field.';
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Model field.';
                }
                field("Year of Manufacture"; Rec."Year of Manufacture")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year of Manufacture field.';
                }
                field("Assigned Driver"; Rec."Assigned Driver")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the assigned driver.';
                }
                field("Assigned Driver Name"; Rec."Assigned Driver Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the assigned driver name.';
                }
            }
        }
    }
}
