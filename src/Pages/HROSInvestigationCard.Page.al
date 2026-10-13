Page 50909 "HR OSInvestigation Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR OSInvestigation";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(InvestigationNo; Rec."Investigation No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field(PersonInvestigating; Rec."Person Investigating")
                {
                    ApplicationArea = Basic;
                }
                field(DateofAssigning; Rec."Date of Assigning")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cause; Rec.Cause)
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(ResolutionRecommendation; Rec."Resolution/Recommendation")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendForInspection)
            {
                ApplicationArea = Basic;
                Caption = 'Send For Inspection';

                trigger OnAction()
                begin
                    Rec.TestField("Person Investigating");
                    if Confirm('Are you sure you want to Send for Inspection?', true, false) then begin
                        Rec.Status := Rec.Status::"Assigned Investigation";
                        Rec.Modify;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*
        Status:=Status::"Reported Investigation";
        MODIFY;
        */

    end;
}

