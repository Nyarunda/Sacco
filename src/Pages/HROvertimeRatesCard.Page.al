Page 51095 "HR Overtime Rates Card"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "HR Overtime Rates";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(ConversionType; Rec."Conversion Type")
                {
                    ApplicationArea = Basic;
                }
                field(ExtraHoursRate; Rec."Extra Hours Rate")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("WeekDay Hours Rate"; Rec."WeekDay Hours Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Holiday/Sunday Hours Rate"; Rec."Holiday/Sunday Hours Rate")
                {
                    ApplicationArea = Basic;
                    Caption = 'Holiday/Weekends Rate';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Outlook)
            {
            }
            systempart(Control9; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

