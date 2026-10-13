Page 50878 "HR Employee Course of Study"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "HR Employee Course of Study";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(YearsofStudy; Rec."Years of Study")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755006; Outlook)
            {
            }
            systempart(Control1102755007; Notes)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup1102755009)
            {
            }
        }
    }
}

