xmlport 50079 "Import Member Balances"
{
    Format = VariableText;

    Caption = 'Import Member Balances';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(MemberBalances; "Member Balances")
            {
                fieldattribute(AccountNo; MemberBalances."Account No.")
                {
                }
                fieldattribute(Balance; MemberBalances.Balance)
                {
                }
                fieldattribute(Date; MemberBalances."Date")
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
