XmlPort 50100 "Import Vendor Quotations"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(RFQVendor; "RFQ Vendors Quotations")
            {
                XmlName = 'VendorQuotations';
                fieldelement(DocumentNo; RFQVendor."Document No")
                {
                }
                fieldelement(Type; RFQVendor.Type)
                {
                }
                fieldelement(Description; RFQVendor.Description)
                {
                }
                fieldelement(Quantity; RFQVendor.Quantity)
                {
                }
                fieldelement(UnitCost; RFQVendor."Unit Cost")
                {
                }
                fieldelement(Amount; RFQVendor.Amount)
                {
                }
                fieldelement(VendorNo; RFQVendor."Vendor No")
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

