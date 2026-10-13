Page 50531 "Sky Agent Transfer List"
{
    CardPageID = "Agent Transfer Page";
    PageType = List;
    SourceTable = "Sky Agent Transfer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TransactionID; Rec."Transaction ID")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionTime; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field(AgentCode; Rec."Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field(AgentName; Rec."Agent Name")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Rejected; Rec.Rejected)
                {
                    ApplicationArea = Basic;
                }
                field(RejectedBy; Rec."Rejected By")
                {
                    ApplicationArea = Basic;
                }
                field(RejectionReason; Rec."Rejection Reason")
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(TimePosted; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
        }
    }

    var
}

