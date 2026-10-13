xmlport 51006 "UPG_Product Setup"
{
    Caption = 'UPG_Product Setup';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(ProductSetup; "Product Setup")
            {
                fieldelement(ProductID; ProductSetup."Product ID")
                {
                }
                fieldelement(Description; ProductSetup.Description)
                {
                }
                fieldelement(ProductClass; ProductSetup."Product Class")
                {
                }
                fieldelement(MinimumLoanAmount; ProductSetup."Minimum Loan Amount")
                {
                }
                fieldelement(MaximumLoanAmount; ProductSetup."Maximum Loan Amount")
                {
                }
                fieldelement(InterestRateMin; ProductSetup."Interest Rate (Min.)")
                {
                }
                fieldelement(InterestRateMax; ProductSetup."Interest Rate (Max.)")
                {
                }
                fieldelement(DefaultInstallments; ProductSetup."Default Installments")
                {
                }
                fieldelement(DepositMultiplier; ProductSetup."Deposit Multiplier")
                {
                }
                fieldelement(LoanAccountGL; ProductSetup."Loan Account [G/L]")
                {
                }
                fieldelement(LoanInterestIncomeGL; ProductSetup."Loan Interest Income [G/L]")
                {
                }
                fieldelement(LoanInterestReceivableGL; ProductSetup."Loan Interest Receivable [G/L]")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
