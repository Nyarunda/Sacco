namespace Wanandage.Wanandage;

page 50764 "Employer Group"
{
    ApplicationArea = All;
    Caption = 'Employer Group';
    PageType = List;
    SourceTable = "Employer Group";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Employer Code"; Rec."Employer Code")
                {
                    ToolTip = 'Specifies the value of the Employer Code field.', Comment = '%';
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ToolTip = 'Specifies the value of the Employer Name field.', Comment = '%';
                }
            }
        }
    }
}
