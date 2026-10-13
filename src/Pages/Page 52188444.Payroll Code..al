
Page 50088 "Payroll Code."
{
    PageType = Card;
    SourceTable = "Payroll Codes";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(TransactionCode; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionName; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field(BalanceType; Rec."Balance Type")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = Basic;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = Basic;
                }
                field(CalculationType; Rec."Calculation Type")
                {
                    ApplicationArea = Basic;
                }
                field(StandardAmount; Rec."Standard Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = Basic;
                }
                field(SpecialTransactions; Rec."Special Transactions")
                {
                    ApplicationArea = Basic;
                }
                field(DeductPremium; Rec."Deduct Premium")
                {
                    ApplicationArea = Basic;
                }
                field(SpecialIdentifier; Rec."Special Identifier")
                {
                    ApplicationArea = Basic;
                }
                field(GLAccount; Rec."GL Account")
                {
                    ApplicationArea = Basic;
                }
                field(Suspended; Rec.Suspended)
                {
                    ApplicationArea = Basic;
                }
                field(SortOrder; Rec."Sort Order")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Deduction"; Rec."Employer Deduction")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                group("Employer Details")
                {
                    field(IncludeEmployerDeduction; Rec."Include Employer Deduction")
                    {
                        ApplicationArea = Basic;
                    }
                    field(EmployerCalculationType; Rec."Employer Calculation Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field(EmployerStandardAmount; Rec."Employer Standard Amount")
                    {
                        ApplicationArea = Basic;
                    }
                    field(IsFormulaforemployer; Rec."Is Formula for employer")
                    {
                        ApplicationArea = Basic;
                    }
                    field(EmployerGLAccount; Rec."Employer GL Account")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Sacco Deductions")
                {
                    field("Fringe Benefit"; Rec."Fringe Benefit")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Subledger; Rec.Subledger)
                    {
                        ApplicationArea = Basic;
                    }
                    field(SubLedgerAccount; Rec."Sub-Ledger Account")
                    {
                        ApplicationArea = Basic;
                    }
                    field(SubLedgerProductType; Rec."Sub-Ledger Product Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field(LoanInterestMethod; Rec."Loan Interest Method")
                    {
                        ApplicationArea = Basic;
                    }
                    field(PostLoanInterestDue; Rec."Post Loan Interest Due")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Irregular Income"; Rec."Irregular Income")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Group Order"; Rec."Group Order")
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
        }
    }

    actions
    {
    }
}

