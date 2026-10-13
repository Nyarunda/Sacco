Page 52210 "Loans Offset List"
{
    PageType = ListPart;
    SourceTable = "Loans Offet List";
    SourceTableView = where(status = filter("Book Loan to Offset" | "TopUp Shares" | Open | Pending | Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MemberNo; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanNo; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNames; Rec."Member Names")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanProduct; Rec."Loan Product")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedAmount; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingBalance; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding insurance"; Rec."Outstanding insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Penalty"; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Allocation Amount"; Rec."Deposit Allocation Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Recover From Guarantors"; Rec."Recover From Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Recover"; Rec."Amount to Recover")
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

