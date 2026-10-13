
XmlPort 50065 "Import Members Data."
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Member Buffer"; "Member Buffer")
            {
                AutoUpdate = true;
                XmlName = 'CheckoffBuffer';
                fieldelement(a; "Member Buffer"."Member No")
                {
                    Width = 20;
                }
                fieldelement(b; "Member Buffer"."Old Member No")
                {
                }
                fieldelement(c; "Member Buffer"."Member Name")
                {
                }
                fieldelement(d; "Member Buffer"."Branch Code")
                {
                }
                fieldelement(e; "Member Buffer".DOB)
                {
                }
                fieldelement(f; "Member Buffer"."ID No")
                {
                    Width = 20;
                }
                fieldelement(g; "Member Buffer"."Registration Date")
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

    var
        MyComment: Text;
        Response: Integer;
        Error001: label 'Invalid option, please respond with 1,2 or 3.';
        Text01: label 'Upload done successfully';
}

