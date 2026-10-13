Page 51010 "HR Promotion Recommendation Ls"
{
    PageType = ListPart;
    SourceTable = "HR Promo. Recommend Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DocumentNo; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(EmployeeAbilities; Rec."Employee Abilities")
                {
                    ApplicationArea = Basic;
                }
                field(Experience; Rec.Experience)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

