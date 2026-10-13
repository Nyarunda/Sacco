XmlPort 53002 "Import BlackListed IDs"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Sky Black-Listed ID Nos"; "Sky Black-Listed ID Nos")
            {
                AutoUpdate = true;
                XmlName = 'Import_Loans';
                fieldelement(a; "Sky Black-Listed ID Nos"."ID Nos.")
                {
                }
                fieldelement(b; "Sky Black-Listed ID Nos"."Black-Listed")
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

