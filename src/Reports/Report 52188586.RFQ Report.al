
Report 50249 "RFQ Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/RFQ Report.rdlc';

    dataset
    {
        dataitem("Purchase Quote Header"; "RFQ Header")
        {
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(No_PurchaseQuoteHeader; "Purchase Quote Header"."No.")
            {
            }
            column(ShiptoCode_PurchaseQuoteHeader; "Purchase Quote Header"."Ship-to Code")
            {
            }
            column(ShiptoName_PurchaseQuoteHeader; "Purchase Quote Header"."Ship-to Name")
            {
            }
            column(ShiptoAddress_PurchaseQuoteHeader; "Purchase Quote Header"."Ship-to Address")
            {
            }
            column(LocationCode_PurchaseQuoteHeader; "Purchase Quote Header"."Location Code")
            {
            }
            column(ShortcutDimension1Code_PurchaseQuoteHeader; "Purchase Quote Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchaseQuoteHeader; "Purchase Quote Header"."Shortcut Dimension 2 Code")
            {
            }
            column(PostingDescription_PurchaseQuoteHeader; "Purchase Quote Header"."Posting Description")
            {
            }
            column(ExpectedClosingDate_PurchaseQuoteHeader; "Purchase Quote Header"."Expected Closing Date")
            {
            }
            column(CompayInfoName; CompayInfo.Name)
            {
            }
            column(CompayInfoPicture; CompayInfo.Picture)
            {
            }
            column(PostingDate_PurchaseQuoteHeader; "Purchase Quote Header"."Posting Date")
            {
            }
            column(ReleasedBy_PurchaseQuoteHeader; "Purchase Quote Header"."Released By")
            {
            }
            column(ReleaseDate_PurchaseQuoteHeader; "Purchase Quote Header"."Release Date")
            {
            }
            dataitem("Quotation Request Vendors"; "RFQ Vendors")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Requisition Document No." = field("No.");
                column(ReportForNavId_1102755001; 1102755001)
                {
                }
                column(VendorNo_QuotationRequestVendors; "Quotation Request Vendors"."Account No.")
                {
                }
                column(VendorName_QuotationRequestVendors; "Quotation Request Vendors"."Vendor Name")
                {
                }
                column(VendorAddress; Vendor.Address)
                {
                }
                column(VendorAddress2; Vendor."Address 2")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Vendor.Get("Quotation Request Vendors"."Account No.");
                    ;
                end;
            }
            dataitem("Purchase Quote Line"; "RFQ Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                column(ReportForNavId_1102755002; 1102755002)
                {
                }
                column(Type_PurchaseQuoteLine; "Purchase Quote Line".Type)
                {
                }
                column(No_PurchaseQuoteLine; "Purchase Quote Line"."No.")
                {
                }
                column(Description_PurchaseQuoteLine; "Purchase Quote Line".Description)
                {
                }
                column(UnitofMeasure_PurchaseQuoteLine; "Purchase Quote Line"."Unit of Measure")
                {
                }
                column(Quantity_PurchaseQuoteLine; "Purchase Quote Line".Quantity)
                {
                }
                column(LineNo_PurchaseQuoteLine; "Purchase Quote Line"."Line No.")
                {
                }
                column(Purchase_Quote_LineUnit_Price; "Purchase Quote Line"."Unit Price (LCY)")
                {
                }
                column(Purchase_Quote_Receipt_date; "Purchase Quote Line"."Expected Receipt Date")
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompayInfo.Get;
        CompayInfo.CalcFields(Picture);
    end;

    var
        CompayInfo: Record "Company Information";
        Vendor: Record Vendor;
}

