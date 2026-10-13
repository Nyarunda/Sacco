Page 51106 "HR Employee Competence List"
{
    PageType = List;
    SourceTable = "HR Employee Competence";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CompetenceCode; Rec."Competence Code")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(CompetencyScore; Rec."Competency Score")
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

