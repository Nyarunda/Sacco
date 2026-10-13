
Report 50178 "Quotation Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Quotation Analysis.rdlc';

    dataset
    {
        dataitem(RFQHeader; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = filter(Quote), DocApprovalType = filter(Quote));
            RequestFilterFields = "No.", "Vendor Posting Group", "Buy-from Vendor No.";
            column(ReportForNavId_1; 1)
            {
            }
            dataitem(Quote; "Purchase Header")
            {
                DataItemTableView = sorting("Document Type", "No.") where("Document Type" = filter(Quote), DocApprovalType = filter(Quote));
                column(ReportForNavId_2; 2)
                {
                }
                dataitem(PurchLines; "Purchase Line")
                {
                    DataItemLink = "Document No." = field("No.");
                    DataItemTableView = sorting("Document Type", "Document No.", "Line No.") order(ascending) where("Document Type" = filter(Quote));
                    column(ReportForNavId_3; 3)
                    {
                    }
                    column(Description_PurchLines; PurchLines.Description)
                    {
                    }
                    column(Description2_PurchLines; PurchLines."Description 2")
                    {
                    }
                    column(No_PurchLines; PurchLines."No.")
                    {
                    }
                    dataitem(RFQLines; "Purchase Line")
                    {
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.") order(ascending) where("Document Type" = filter(Quote));
                        column(ReportForNavId_4; 4)
                        {
                        }
                        column(UnitofMeasure_RFQLines; RFQLines."Unit of Measure")
                        {
                        }
                        column(Quantity_RFQLines; RFQLines.Quantity)
                        {
                        }
                        column(BuyfromVendorNo_RFQLines; RFQLines."Buy-from Vendor No.")
                        {
                        }
                        column(Vno; VNo)
                        {
                        }
                        column(Vendors_Name; Vendors.Name)
                        {
                        }
                        column(Amount_RFQLines; RFQLines.Amount)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin

                            ShowLine := true;
                            Headers.Reset;
                            //Headers.SETRANGE(Headers."Document Type",Headers."Document Type"::Quote);
                            //Headers.SETRANGE(Headers.DocApprovalType,Headers."Document Type"::Quote);
                            Headers.SetRange(Headers."No.", RFQLines."Document No.");
                            Headers.SetRange(Headers."Invoice Basis", RFQHeader."Invoice Basis");
                            if Headers.Find('-') = false then ShowLine := false;
                            if Vendors.Get(RFQLines."Buy-from Vendor No.") then
                                VNo := VNo + 1;
                        end;

                        trigger OnPreDataItem()
                        begin

                            RFQLines.SetRange(RFQLines.Type, PurchLines.Type);
                            RFQLines.SetRange(RFQLines."No.", PurchLines."No.");
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin

                        TempPurchLines.Reset;
                        TempPurchLines.SetRange(TempPurchLines."No.", PurchLines."No.");
                        TempPurchLines.SetRange(TempPurchLines.Type, PurchLines.Type);
                        if TempPurchLines.Find('-') then begin
                            CurrReport.Skip;
                        end else begin
                            TempPurchLines := PurchLines;
                            TempPurchLines.Insert;
                        end;
                        LineCount := LineCount + 1;
                        VNo := 0;
                    end;
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
        TempPurchLines: Record "Purchase Line" temporary;
        LineCount: Integer;
        Headers: Record "Purchase Header";
        ShowLine: Boolean;
        Vendors: Record "Savings Accounts";
        VNo: Integer;
}

