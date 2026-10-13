XmlPort 53000 "Import BlackListed Phone"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Sky Black-Listed Phone Nos"; "Sky Black-Listed Phone Nos")
            {
                AutoUpdate = true;
                XmlName = 'Import_Loans';
                fieldelement(a; "Sky Black-Listed Phone Nos"."Transactional Phone No.")
                {
                }
                fieldelement(b; "Sky Black-Listed Phone Nos"."Black-Listed")
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

