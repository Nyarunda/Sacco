page 50060 "Transaction Codes"
{
    Caption = 'Transaction Codes';
    PageType = List;
    SourceTable = "Payroll Codes";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Name field.';
                }
                field("Balance Type"; Rec."Balance Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance Type field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Frequency field.';
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Taxable field.';
                }
                field("Calculation Type"; Rec."Calculation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Calculation Type field.';
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Formula field.';
                }
                field("Special Transactions"; Rec."Special Transactions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Special Transactions field.';
                }
                field("Deduct Premium"; Rec."Deduct Premium")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deduct Premium field.';
                }
                field("Employer Deduction"; Rec."Employer Deduction")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Deduction field.';
                }
                field("Special Identifier"; Rec."Special Identifier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Special Identifier field.';
                }
                field("Include Employer Deduction"; Rec."Include Employer Deduction")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Include Employer Deduction field.';
                }
                field("Is Formula for employer"; Rec."Is Formula for employer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Is Formula for employer field.';
                }
                field("GL Account"; Rec."GL Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GL Account field.';
                }
                field("Employer GL Account"; Rec."Employer GL Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer GL Account field.';
                }
                field(Subledger; Rec.Subledger)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Subledger field.';
                }
                field(Suspended; Rec.Suspended)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Suspended field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Global Dimension 1 Name"; Rec."Global Dimension 1 Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Name field.';
                }
                field("Global Dimension 2 Name"; Rec."Global Dimension 2 Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Name field.';
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Type field.';
                }
                field("Standard Amount"; Rec."Standard Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Standard Amount field.';
                }
                field("Employer Calculation Type"; Rec."Employer Calculation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Calculation Type field.';
                }
                field("Employer Standard Amount"; Rec."Employer Standard Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Standard Amount field.';
                }
                field("Deduct Mortgage"; Rec."Deduct Mortgage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deduct Mortgage field.';
                }
                field("Fringe Benefit"; Rec."Fringe Benefit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fringe Benefit field.';
                }
                field("Sort Order"; Rec."Sort Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sort Order field.';
                }
                field("Sacco Transaction Type"; Rec."Sacco Transaction Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sacco Transaction Type field.';
                }
                field("Sub-Ledger Product Type"; Rec."Sub-Ledger Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub-Ledger Product Type field.';
                }
                field("Ledger Types"; Rec."Ledger Types")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ledger Types field.';
                }
                field("Sub-Ledger Account"; Rec."Sub-Ledger Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub-Ledger Account field.';
                }
                field("Loan Interest Method"; Rec."Loan Interest Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Interest Method field.';
                }
                field("Post Loan Interest Due"; Rec."Post Loan Interest Due")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Loan Interest Due field.';
                }
                field("Employer Only"; Rec."Employer Only")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Only field.';
                }
            }
        }
    }
}
