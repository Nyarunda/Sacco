Page 51105 "HR Employee Separation List"
{
    CardPageID = "HR Employee Separation";
    PageType = List;
    SourceTable = "HR Employee Separation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SeparationNo; Rec."Separation No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                }
                field(JobTitle; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field(NatureofSeparation; Rec."Nature of Separation")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
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

