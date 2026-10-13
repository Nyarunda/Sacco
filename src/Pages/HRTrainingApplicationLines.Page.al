Page 50980 "HR Training Application Lines"
{
    AutoSplitKey = false;
    Caption = 'HR Training Participants';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "HR Training App Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EmployeeNo; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(JobTitle; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Objectives; Rec.Objectives)
                {
                    ApplicationArea = Basic;
                }
                field(ParticipantEmail; Rec."Participant Email")
                {
                    ApplicationArea = Basic;
                }
                field(Notified; Rec.Notified)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        HREmployees: Record Employee;
        HRTrainingAppHeader: Record "HR Training App Header";
        HRTrainingAppLines: Record "HR Training App Lines";
}

