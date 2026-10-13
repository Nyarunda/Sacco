Page 50290 "Partial Disbursement Schedule"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Partial Disbursement Schedule";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ScheduledDisbursementDate; Rec."Scheduled Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementDestination; Rec."Disbursement Destination")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
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

