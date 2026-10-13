
Page 50086 "Savings Interest Buffer"
{
    PageType = List;
    SourceTable = "Savings Interest Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(InterestDate; Rec."Interest Date")
                {
                    ApplicationArea = Basic;
                }
                field(QualifyingAmount; Rec."Qualifying Amount")
                {
                    ApplicationArea = Basic;
                }
                field(InterestRate; Rec."Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(InterestAmount; Rec."Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Accrued; Rec.Accrued)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(WitholdingTax; Rec."Witholding Tax")
                {
                    ApplicationArea = Basic;
                }
                field(PayableAccount; Rec."Payable Account")
                {
                    ApplicationArea = Basic;
                }
                field(WithholdingTaxAccount; Rec."Withholding Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field(ExpenseAccount; Rec."Expense Account")
                {
                    ApplicationArea = Basic;
                }
                field(AccruedBy; Rec."Accrued By")
                {
                    ApplicationArea = Basic;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(UserID; Rec."User ID")
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

