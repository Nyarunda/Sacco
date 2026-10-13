namespace CentralDB.CentralDB;

xmlport 50086 "Loan Security Upload"
{
    Caption = 'Loan Security Upload';
    Format = VariableText;

    schema
    {
        textelement(roots)
        {
            tableelement(LoanSecurity; "Loan Security")
            {
                fieldelement(LoanNo; LoanSecurity."Loan No.")
                {
                }
                fieldelement(GuarantorType; LoanSecurity."Guarantor Type")
                {
                }
                fieldelement(AccountNo; LoanSecurity."Account No.")
                {
                }
                fieldelement(CollateralRegNo; LoanSecurity."Collateral Reg. No.")
                {
                }
                fieldelement(CollateralValue; LoanSecurity."Collateral Value")
                {
                }
                fieldelement(CurrentCommitted; LoanSecurity."Current Committed")
                {
                }
                fieldelement(AmountGuaranteed; LoanSecurity."Amount Guaranteed")
                {
                }
                fieldelement(DepositMultiplier; LoanSecurity."Deposit Multiplier")
                {
                }
                fieldelement(Substituted; LoanSecurity.Substituted)
                {
                }
                fieldelement(SelfGuaranteed; LoanSecurity."Self Guarantee")
                {

                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
