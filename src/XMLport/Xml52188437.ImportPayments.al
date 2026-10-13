xmlport 50083 "Import Payments"
{
    Caption = 'Import Payments';
    Format = VariableText;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(salary; "Salary Lines")
            {
                XmlName = 'SalaryLines';
                fieldattribute(Header; salary."Salary Header No.")
                { }

                fieldattribute(Staff; Salary."Staff No.")
                {
                    FieldValidate = yes;
                }
                fieldattribute(Amount; Salary.Amount)
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
    trigger OnPostXmlPort()
    begin
        Message('Salary Uploaded Successfuly');
    end;
}
