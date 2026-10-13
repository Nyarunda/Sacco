Page 51056 "HR Induction Participants List"
{
    PageType = List;
    SourceTable = "HR Staff  Induction";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ParticipantCode; Rec."Participant Code")
                {
                    ApplicationArea = Basic;
                }
                field(ParticipantName; Rec."Participant Name")
                {
                    ApplicationArea = Basic;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = Basic;
                }
                field(ToDate; Rec."To Date")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
                field(DaysAttended; Rec."Days Attended")
                {
                    ApplicationArea = Basic;
                }
                field(InductionStatus; Rec."Induction Status")
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

