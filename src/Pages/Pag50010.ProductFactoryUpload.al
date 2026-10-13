page 50010 "Product Factory Upload"
{
    Caption = 'Product Factory Upload';
    PageType = List;
    SourceTable = "Product Setup";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Product ID"; Rec."Product ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product ID field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Product Class"; Rec."Product Class")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Class field.';
                }
                field("Interest Rate (Min.)"; Rec."Interest Rate (Min.)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Rate (Min.) field.';
                }
                field("Interest Rate (Max.)"; Rec."Interest Rate (Max.)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Rate (Max.) field.';
                }
                field("Default Installments"; Rec."Default Installments")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Installments field.';
                }
                field("Product Category"; Rec."Product Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Category field.';
                }
                field("Min. Customer Age"; Rec."Min. Customer Age")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Min. Customer Age field.';
                }
                field("Max.Customer Age"; Rec."Max.Customer Age")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Max.Customer Age field.';
                }
                field("Minimum Account Balance"; Rec."Minimum Account Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Account Balance field.';
                }
                field("Loan Account [G/L]"; Rec."Loan Account [G/L]")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Account [G/L] field.';
                }
                field("Loan Interest Income [G/L]"; Rec."Loan Interest Income [G/L]")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Interest Income [G/L] field.';
                }
                field("Loan Interest Receivable [G/L]"; Rec."Loan Interest Receivable [G/L]")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Interest Receivable [G/L] field.';
                }
                field("Product Posting Group"; Rec."Product Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Posting Group field.';
                }
                field("Dormancy Period"; Rec."Dormancy Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dormancy Period field.';
                }
                field("Account No. Prefix"; Rec."Account No. Prefix")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dormancy Period field.';
                }
                field("Maximum Guarantors"; Rec."Maximum Guarantors")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Guarantors field.';
                }
                field("Minimum Guarantors"; Rec."Minimum Guarantors")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Guarantors field.';
                }
                field("Deposit Multiplier"; Rec."Deposit Multiplier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deposit Multiplier field.';
                }
                field("Minimum Loan Amount"; Rec."Minimum Loan Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Loan Amount field.';
                }
                field("Maximum Loan Amount"; Rec."Maximum Loan Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Loan Amount field.';
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Calculation Method field.';
                }
                field("Earns Interest"; Rec."Earns Interest")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Earns Interest field.';
                }
                field("Interest Expense Account"; Rec."Interest Expense Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Expense Account field.';
                }
                field("Interest Payable Account"; Rec."Interest Payable Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Payable Account field.';
                }
                field("Interest Calc Min Balance"; Rec."Interest Calc Min Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Calc Min Balance field.';
                }
                field("Appraisal % on Amount"; Rec."Appraisal % on Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appraisal % on Amount field.';
                }
                field("Interest Due on Disbursement"; Rec."Interest Due on Disbursement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Due on Disbursement field.';
                }
                field("Repay Mode"; Rec."Repay Mode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Repay Mode field.';
                }
                field("Withholding Tax Account"; Rec."Withholding Tax Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Withholding Tax Account field.';
                }
                field("Nature of Loan Type"; Rec."Nature of Loan Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nature of Loan Type field.';
                }
                field("Available on Mobile"; Rec."Available on Mobile")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Available on Mobile field.';
                }
                field("Cutoff Day"; Rec."Cutoff Day")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cutoff Day field.';
                }
            }
        }
    }
}
