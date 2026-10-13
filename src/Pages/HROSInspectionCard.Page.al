Page 50911 "HR OSInspection Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "HR OSInvestigation";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
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
                    Editable = false;
                }
            }
            part(Control9; "HR OSSafety Checklist List")
            {
                SubPageLink = "Incident No" = field("Incident No");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ReturnforInvestigation)
            {
                ApplicationArea = Basic;
                Caption = 'Return for Investigation';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Retrun for Investigation?', true, false) then begin
                        Rec.Status := Rec.Status::"Reported Investigation";
                        Rec.Modify;
                    end;
                end;
            }
            action(GenerateTrainingNeed)
            {
                ApplicationArea = Basic;
                Caption = 'Generate Training Need';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Generate Training Need for this Measures?', true, false) then begin
                        Message('Training Need Has been created Successfully');
                    end;
                end;
            }
        }
    }
}

