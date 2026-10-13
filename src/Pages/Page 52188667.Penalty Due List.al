
Page 50330 "Penalty Due List"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Loans Penalty Buffer";
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MemberNo; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(GLAccount; Rec."GL Account")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingBalance; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(PenaltyDate; Rec."Penalty Date")
                {
                    ApplicationArea = Basic;
                }
                field(LoanIssueDate; Rec."Loan Issue Date")
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

