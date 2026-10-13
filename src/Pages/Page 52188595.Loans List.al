
Page 50258 "Loans List"
{
    CardPageID = "Loan Application Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = Loans;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(LoanProductType; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(RequestedAmount; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedAmount; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementDate; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPrincipal; Rec."Outstanding Principal")
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
                field(OutstandingAppraisal; Rec."Outstanding Appraisal")
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

