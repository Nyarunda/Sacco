Page 50930 "HR OSIncident List"
{
    CardPageID = "HR OSIncident Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HR OSIncident";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(IncidentNo; Rec."Incident No")
                {
                    ApplicationArea = Basic;
                }
                field(IncidentDescription; Rec."Incident Description")
                {
                    ApplicationArea = Basic;
                }
                field(TypeofIncident; Rec."Type of Incident")
                {
                    ApplicationArea = Basic;
                }
                field(DateofIncident; Rec."Date of Incident")
                {
                    ApplicationArea = Basic;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = Basic;
                }
                field(DateNotificationReceived; Rec."Date Notification Received")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
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

