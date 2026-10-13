namespace Wanandage.Wanandage;

page 50765 "Default Product Class"
{
    ApplicationArea = All;
    Caption = 'Default Product Class';
    PageType = List;
    Editable = true;
    SourceTable = "Default Products Classes";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Class; Rec.Class)
                {
                    ToolTip = 'Specifies the value of the Class field.', Comment = '%';
                    TableRelation = "Member Class";
                }
                field("Product ID"; Rec."Product ID")
                {
                    ToolTip = 'Specifies the value of the Product ID field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
