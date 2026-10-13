XmlPort 54001 "Import FA Lines"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(FADepreciationBook; "FA Depreciation Book")
            {
                AutoUpdate = true;
                fieldelement(FANo; FADepreciationBook."FA No.")
                {
                }
                fieldelement(FADepCode; FADepreciationBook."Depreciation Book Code")
                {
                }
                fieldelement(a; FADepreciationBook."Depreciation Method")
                {
                    FieldValidate = No;
                }
                fieldelement(b; FADepreciationBook."Depreciation Starting Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c; FADepreciationBook."Straight-Line %")
                {
                    FieldValidate = No;
                }
                fieldelement(d; FADepreciationBook."No. of Depreciation Years")
                {
                    FieldValidate = No;
                }
                fieldelement(e; FADepreciationBook."No. of Depreciation Months")
                {
                }
                fieldelement(f; FADepreciationBook."Declining-Balance %")
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

