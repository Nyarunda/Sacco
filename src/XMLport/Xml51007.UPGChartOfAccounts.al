xmlport 51007 UPG_ChartOfAccounts
{
    Caption = 'UPG_ChartOfAccounts';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(GLAccount; "G/L Account")
            {
                fieldelement(No; GLAccount."No.")
                {
                }
                fieldelement(Name; GLAccount.Name)
                {
                }
                fieldelement(IncomeBalance; GLAccount."Income/Balance")
                {
                }
                fieldelement(AccountType; GLAccount."Account Type")
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
