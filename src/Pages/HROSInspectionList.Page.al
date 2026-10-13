Page 50910 "HR OSInspection List"
{
    CardPageID = "HR OSInspection Card";
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
            }
        }
    }

    actions
    {
    }
}

