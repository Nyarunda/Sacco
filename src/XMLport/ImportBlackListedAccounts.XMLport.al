XmlPort 53001 "Import BlackListed Accounts"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Sky Black-Listed Account Nos"; "Sky Black-Listed Account Nos")
            {
                AutoUpdate = true;
                XmlName = 'Import_Loans';
                fieldelement(a; "Sky Black-Listed Account Nos"."Account No.")
                {
                }
                fieldelement(b; "Sky Black-Listed Account Nos"."Black-Listed")
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

