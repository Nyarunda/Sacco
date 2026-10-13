XmlPort 53004 "Import Loan BlackListed IDs"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Sky Mobile Loan Black-List"; "Sky Mobile Loan Black-List")
            {
                AutoUpdate = true;
                XmlName = 'Import_Loans';
                fieldelement(a; "Sky Mobile Loan Black-List"."ID Nos.")
                {
                }
                fieldelement(b; "Sky Mobile Loan Black-List"."Black-Listed")
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

