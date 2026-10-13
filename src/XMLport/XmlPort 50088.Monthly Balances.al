
XmlPort 50075 "Monthly Balances"
{
    Format = VariableText;

    schema
    {
        textelement(roots)
        {
            tableelement(MemberBalancesFromOld; MemberBalancesFromOld)
            {
                XmlName = 'ImportPhone';
                fieldelement(A; MemberBalancesFromOld.IDNo)
                {
                }
                fieldelement(B; MemberBalancesFromOld.MNo)
                {
                }
                fieldelement(C; MemberBalancesFromOld.MName)
                {
                }
                fieldelement(d; MemberBalancesFromOld.DecDepo)
                {
                }
                fieldelement(e; MemberBalancesFromOld.DecShare)
                {
                }
                fieldelement(f; MemberBalancesFromOld.JanDepo)
                {
                }
                fieldelement(g; MemberBalancesFromOld.JanShare)
                {
                }
                fieldelement(A; MemberBalancesFromOld.FebDepo)
                {
                }
                fieldelement(B; MemberBalancesFromOld.FebShare)
                {
                }
                fieldelement(C; MemberBalancesFromOld.MarDepo)
                {
                }
                fieldelement(d; MemberBalancesFromOld.MarShare)
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

