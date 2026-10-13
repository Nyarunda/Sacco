
XmlPort 50019 "Checkoff Buffer"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Monthly Checkoff Buffer"; "Monthly Checkoff Buffer")
            {
                XmlName = 'CheckoffBuffer';
                fieldelement(CheckoffNo; "Monthly Checkoff Buffer"."Checkoff No")
                {
                }
                fieldelement(OldMemberNO; "Monthly Checkoff Buffer"."Old Member No.")
                {
                }
                fieldelement(ReceiptNo; "Monthly Checkoff Buffer"."Receipt No.")
                {
                }
                fieldelement(Amount; "Monthly Checkoff Buffer".Amount)
                {
                }

                trigger OnAfterInitRecord()
                begin
                    "Monthly Checkoff Buffer"."User Id" := UserId;
                    "Monthly Checkoff Buffer"."Upload Response" := Response;
                end;
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
        Message(Text01);
    end;

    trigger OnPreXmlPort()
    begin

    end;

    var
        MyComment: Text;
        Response: Integer;
        Error001: label 'Invalid option, please respond with 1,2 or 3.';
        Text01: label 'Upload done successfully';
}

