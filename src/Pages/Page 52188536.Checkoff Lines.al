
Page 50199 "Checkoff Lines"
{
    PageType = ListPart;
    SourceTable = "Monthly Checkoff Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollNo; Rec."Payroll No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(ExcessAmount; Rec."Excess Amount")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Multiple; Rec.Multiple)
                {
                    ApplicationArea = Basic;
                }
                field(ProductID; Rec."Product ID")
                {
                    ApplicationArea = Basic;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SavingsAccount; Rec."Savings Account")
                {
                    ApplicationArea = Basic;
                }
                field(CreditAccount; Rec."Credit Account")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Expected Interest"; Rec."Expected Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Variation"; Rec."Interest Variation")
                {
                    ApplicationArea = Basic;
                }
                field("Principal Arrears"; Rec."Principal Arrears")
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

