Page 50929 "HR OSIncident Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR OSIncident";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(IncidentNo; Rec."Incident No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(IncidentDescription; Rec."Incident Description")
                {
                    ApplicationArea = Basic;
                }
                field(TypeofIncident; Rec."Type of Incident")
                {
                    ApplicationArea = Basic;
                }
                field(LocationName; Rec."Location Name")
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
                field(FirstWitnessName; Rec."First Witness Name")
                {
                    ApplicationArea = Basic;
                }
                field(FirstWitnessAddress; Rec."First Witness Address")
                {
                    ApplicationArea = Basic;
                }
                field(SecondWitnessName; Rec."Second Witness Name")
                {
                    ApplicationArea = Basic;
                }
                field(SecondWitnessAddress; Rec."Second Witness Address")
                {
                    ApplicationArea = Basic;
                }
                field(FirstAidGiven; Rec."First Aid Given")
                {
                    ApplicationArea = Basic;
                }
                field(TakenHome; Rec."Taken Home")
                {
                    ApplicationArea = Basic;
                }
                field(ReturntoWorkonsameday; Rec."Return to Work on same day")
                {
                    ApplicationArea = Basic;
                }
                field(WentAbsent; Rec."Went Absent")
                {
                    ApplicationArea = Basic;
                }
                field(TakentoHospital; Rec."Taken to Hospital")
                {
                    ApplicationArea = Basic;
                }
                field(Admitted; Rec.Admitted)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control7; "HR OSInjured Person List")
            {
                SubPageLink = "Incident No" = field("Incident No");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approval)
            {
                ApplicationArea = Basic;
                Caption = 'Approval';
            }
            action(SendApproval)
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval';
            }
            action(CancelApproval)
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval';
            }
            action(SendforInvestigation)
            {
                ApplicationArea = Basic;
                Caption = 'Send for Investigation';
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Send Incident for Investigation?', true, false) then begin
                        Rec.Status := Rec.Status::Investigation;
                        Rec.Modify;
                    end;
                end;
            }
        }
    }
}

