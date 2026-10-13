
Page 50198 "Checkoff Import"
{
    PageType = ListPart;
    SourceTable = "Monthly Checkoff Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Payroll; Rec.Payroll)
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Savings Amount"; Rec."Savings Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Amount"; Rec."Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Reporting Name"; Rec."Reporting Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNotFound; Rec."Member Not Found")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNotFound; Rec."Loan Not Found")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Not Found"; Rec."Savings Not Found")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
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

