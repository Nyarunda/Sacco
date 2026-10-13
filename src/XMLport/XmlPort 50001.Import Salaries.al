
XmlPort 50018 "Import Salaries"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Salary Lines"; "Salary Lines")
            {
                XmlName = 'SalaryLines';
                fieldattribute(HNo; "Salary Lines"."Salary Header No.")
                {
                }
                fieldattribute(AccountNo; "Salary Lines"."Account No.")
                {
                    FieldValidate = yes;
                }
                fieldattribute(Amount; "Salary Lines".Amount)
                {
                }
                fieldattribute(Staff; "Salary Lines"."Staff No.")
                {
                    FieldValidate = yes;
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

    trigger OnPostXmlPort()
    begin
        Message('Salary Uploaded Successfuly');
    end;
}

