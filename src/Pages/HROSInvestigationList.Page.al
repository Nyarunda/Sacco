Page 50908 "HR OSInvestigation List"
{
    CardPageID = "HR OSInvestigation Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HR OSInvestigation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(InvestigationNo; Rec."Investigation No")
                {
                    ApplicationArea = Basic;
                }
                field(IncidentNo; Rec."Incident No")
                {
                    ApplicationArea = Basic;
                }
                field(IncidentDescription; Rec."Incident Description")
                {
                    ApplicationArea = Basic;
                }
                field(DateofIncident; Rec."Date of Incident")
                {
                    ApplicationArea = Basic;
                }
                field(LocationName; Rec."Location Name")
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

