
XmlPort 50064 "Import Mpesa Nos"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Dummy Upload Mpesa Nos"; "Dummy Upload Mpesa Nos")
            {
                XmlName = 'Mpesa';
                fieldelement(A; "Dummy Upload Mpesa Nos"."Old No.")
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

    var
        MyComment: Text;
        Response: Integer;
        Error001: label 'Invalid option, please respond with 1,2 or 3.';
        Text01: label 'Upload done successfully';
}

