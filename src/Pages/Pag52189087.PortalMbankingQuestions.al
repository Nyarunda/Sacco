namespace UnitedWomen_Production.UnitedWomen_Production;

page 50789 "Portal Mbanking Questions"
{
    ApplicationArea = All;
    Caption = 'Portal Mbanking Questions';
    PageType = List;
    SourceTable = "Portal Mbanking Questions";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.id)
                {
                    ToolTip = 'Specifies the value of the id field.', Comment = '%';
                }
                field(Questions; Rec.Questions)
                {
                    ToolTip = 'Specifies the value of the Questions field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field(CreatedBy; Rec.CreatedBy)
                {
                    ToolTip = 'Specifies the value of the CreatedBy field.', Comment = '%';
                }
                field(DateCreated; Rec.DateCreated)
                {
                    ToolTip = 'Specifies the value of the DateCreated field.', Comment = '%';
                }
            }
        }
    }
}
