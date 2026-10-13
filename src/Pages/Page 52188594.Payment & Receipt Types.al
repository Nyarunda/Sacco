
Page 50257 "Payment & Receipt Types"
{
    PageType = List;
    SourceTable = "Payment & Receipt Types";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(VAT; Rec."VAT %")
                {
                    ApplicationArea = Basic;
                }
                field(WithholdingVAT; Rec."Withholding VAT %")
                {
                    ApplicationArea = Basic;
                }
                field(Tax; Rec."Tax %")
                {
                    ApplicationArea = Basic;
                }
                field(WithholdingTax; Rec."Withholding Tax %")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultGrouping; Rec."Default Grouping")
                {
                    ApplicationArea = Basic;
                }
                field(TaxGLAccount; Rec."Tax GL Account")
                {
                    ApplicationArea = Basic;
                }
                field(VATGLAccount; Rec."VAT GL Account")
                {
                    ApplicationArea = Basic;
                }
                field(DailyTaxExemptAmount; Rec."Daily Tax Exempt. Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Board Expense Account No."; Rec."Board Expense Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Is Board"; Rec."Is Board")
                {
                    ApplicationArea = Basic;
                }
                field("Housing Levy %"; Rec."Housing Levy %")
                {
                    ApplicationArea = Basic;
                }
                field("Housing Levy GL"; Rec."Housing Levy GL")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Expense Account No."; Rec."Staff Expense Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Is Staff"; Rec."Is Staff")
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

