
XmlPort 50077 "Import Chart of Accounts"
{
    Format = VariableText;

    schema
    {
        textelement(roots)
        {
            tableelement("G/L Account"; "G/L Account")
            {
                XmlName = 'ImportCOA';
                fieldelement(A; "G/L Account"."No.")
                {
                }
                fieldelement(B; "G/L Account".Name)
                {
                }
                fieldelement(C; "G/L Account"."Income/Balance")
                {
                }
                fieldelement(d; "G/L Account"."Account Type")
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

