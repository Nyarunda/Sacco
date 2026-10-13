
XmlPort 50067 "Import Shares Nos"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Share Capital Nos"; "Share Capital Nos")
            {
                XmlName = 'CheckoffBuffer';
                fieldelement(a; "Share Capital Nos"."Member No")
                {
                    Width = 20;
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

    trigger OnPreXmlPort()
    begin
        ShareCapitalNos.DeleteAll;
    end;

    var
        MyComment: Text;
        Response: Integer;
        Error001: label 'Invalid option, please respond with 1,2 or 3.';
        Text01: label 'Upload done successfully';
        ShareCapitalNos: Record "Share Capital Nos";
}

