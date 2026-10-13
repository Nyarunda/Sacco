Page 51070 "HR Activity Participants SF"
{
    Caption = 'Activity Participants';
    PageType = ListPart;
    SaveValues = true;
    SourceTable = "HR Activity Participants";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(Notified; Rec.Notified)
                {
                    ApplicationArea = Basic;
                }
                field(Participant; Rec.Participant)
                {
                    ApplicationArea = Basic;
                }
                field(ParticipantName; Rec."Participant Name")
                {
                    ApplicationArea = Basic;
                }
                field(ParticipantEMail; Rec."Participant E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field(ParticipantRole; Rec."Participant Role")
                {
                    ApplicationArea = Basic;
                }
                field(Contribution; Rec.Contribution)
                {
                    Visible = false;
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

