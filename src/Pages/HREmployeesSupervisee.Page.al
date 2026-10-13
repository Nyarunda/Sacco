Page 50879 "HR Employees Supervisee"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "HR Employees Supervisees";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SupervisorNo; Rec."Supervisor No.")
                {
                    ApplicationArea = Basic;
                }
                field(SuperviseeNo; Rec."Supervisee No.")
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
                field(KeyExperience; Rec."Key Experience")
                {
                    ApplicationArea = Basic;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = Basic;
                }
                field("To"; Rec."To")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
                field(NumberofSupervisees; Rec."Number of Supervisees")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755011; Outlook)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        /*HREmployeeSupervisees.RESET;
        HREmployeeSupervisees.SETRANGE(HREmployeeSupervisees."Supervisor No.","Supervisor No.");
        IF HREmployeeSupervisees.GET THEN
        SETRANGE("Supervisor No.",HREmployeeSupervisees."Supervisor No.")
        ELSE
        //user id may not be the creator of the doc
        SETRANGE("Supervisor No.","Supervisor No.");
         */

    end;
}

