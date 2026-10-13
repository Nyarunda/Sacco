
Page 50331 "Stopped Interest List"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = Loans;
    SourceTableView = where("Stop Interest Due" = const(true));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(LoanProductType; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedAmount; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPenalty; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPrincipal; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(TotalOutstandingBalance; Rec."Total Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field(BookingBranch; Rec."Booking Branch")
                {
                    ApplicationArea = Basic;
                }
                field(InterestDue; Rec."Interest Due")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementDate; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field(IntStopDate; Rec."Int Stop Date")
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

