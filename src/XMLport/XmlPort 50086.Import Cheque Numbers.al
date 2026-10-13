
XmlPort 50078 "Import Cheque Numbers"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Ordinary Cheque Register"; "Ordinary Cheque Register")
            {
                AutoUpdate = true;
                XmlName = 'Buffer';
                fieldattribute(a; "Ordinary Cheque Register"."Ordinary Cheque No.")
                {
                }
                fieldattribute(b; "Ordinary Cheque Register".Issued)
                {
                }
                fieldattribute(c; "Ordinary Cheque Register".Cancelled)
                {
                }
                fieldattribute(d; "Ordinary Cheque Register"."Branch Code")
                {
                }
                fieldattribute(e; "Ordinary Cheque Register".Source)
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

