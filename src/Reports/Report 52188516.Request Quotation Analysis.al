
Report 50179 "Request Quotation Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Request Quotation Analysis.rdlc';

    dataset
    {
        dataitem("RFQ Header"; "RFQ Header")
        {
            //DataItemTableView = sorting("Document Type","No.");
            RequestFilterFields = "Document Type", "No.";
            column(ReportForNavId_1; 1)
            {
            }
            dataitem("RFQ Line"; "RFQ Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                column(ReportForNavId_2; 2)
                {
                }
                dataitem("Purchase Line"; "Purchase Line")
                {
                    //DataItemLink = Field50005 = field("Document No."), "Order No." = field("Line No.");
                    //DataItemTableView = sorting("Unit Cost (LCY)") order(ascending);
                    column(ReportForNavId_3; 3)
                    {
                    }
                    column(UnitCostLCY_PurchaseLine; "Purchase Line"."Unit Cost (LCY)")
                    {
                    }
                    column(BuyfromVendorNo_PurchaseLine; "Purchase Line"."Buy-from Vendor No.")
                    {
                    }
                    column(DocumentNo_PurchaseLine; "Purchase Line"."Document No.")
                    {
                    }
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

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Vend: Record "Savings Accounts";
}

