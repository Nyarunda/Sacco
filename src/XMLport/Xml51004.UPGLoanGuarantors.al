xmlport 51004 UPG_LoanGuarantors
{
    Caption = 'UPG_LoanGuarantors';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(UPG_LoanGuarantors; "UPG_Loan Guarantors")
            {
                fieldelement(LoanNo; UPG_LoanGuarantors."Loan No")
                {
                }
                fieldelement(MemberNo; UPG_LoanGuarantors."Member No")
                {
                }
                fieldelement(AccountNo; UPG_LoanGuarantors."Account No")
                {
                }
                fieldelement(Name; UPG_LoanGuarantors."Member Name")
                {
                }
                fieldelement(LoanBalance; UPG_LoanGuarantors."Loan Balance")
                {
                }
                fieldelement(Shares; UPG_LoanGuarantors.Shares)
                {
                }
                fieldelement(Substituted; UPG_LoanGuarantors.Substituted)
                {
                }
                fieldelement(Date; UPG_LoanGuarantors."Date")
                {
                }
                fieldelement(AmontGuaranteed; UPG_LoanGuarantors."Amount Guaranteed")
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
