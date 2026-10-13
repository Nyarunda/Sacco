report 59999 "TRADE PAYABLES REPORT"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'TRADE PAYABLES REPORT';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Trade Payables Report.rdlc';

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = where(Open = const(true), "Document Type" = const(Invoice));
            RequestFilterFields = "Vendor No.", "Posting Date", "Due Date";

            column(ReportForNavId_1; 1)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(VendorNo; "Vendor No.")
            {
            }
            column(SupplierName; SupplierName)
            {
            }
            column(InvoiceNumber; "Document No.")
            {
            }
            column(InvoiceDate; "Posting Date")
            {
            }
            column(OriginalAmount; OriginalAmount)
            {
            }
            column(AmountPaid; AmountPaid)
            {
            }
            column(OutstandingBalance; OutstandingBalance)
            {
            }
            column(AgingDays; AgingDays)
            {
            }
            column(Aging_0_30; Aging0To30)
            {
            }
            column(Aging_31_60; Aging31To60)
            {
            }
            column(Aging_61_90; Aging61To90)
            {
            }
            column(Aging_91_120; Aging91To120)
            {
            }
            column(Aging_Above_120; AgingAbove120)
            {
            }
            column(AsAt; AsAtDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ClearAgingBuckets();
                "Vendor Ledger Entry".CalcFields("Remaining Amount", "Original Amount");

                if VendorRec.Get("Vendor No.") then
                    SupplierName := VendorRec.Name
                else
                    SupplierName := '';

                OriginalAmount := Abs("Original Amount");
                OutstandingBalance := Abs("Remaining Amount");
                AmountPaid := OriginalAmount - OutstandingBalance;
                if AmountPaid < 0 then
                    AmountPaid := 0;

                AgingDays := AsAtDate - "Posting Date";
                if AgingDays < 0 then
                    AgingDays := 0;

                if (AgingDays <= 30) then
                    Aging0To30 := OutstandingBalance
                else
                    if (AgingDays <= 60) then
                        Aging31To60 := OutstandingBalance
                    else
                        if (AgingDays <= 90) then
                            Aging61To90 := OutstandingBalance
                        else
                            if (AgingDays <= 120) then
                                Aging91To120 := OutstandingBalance
                            else
                                AgingAbove120 := OutstandingBalance;
            end;

            trigger OnPreDataItem()
            begin
                if AsAtDate = 0D then
                    AsAtDate := Today;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(AsAtDateField; AsAtDate)
                {
                    ApplicationArea = All;
                    Caption = 'As At Date';
                }
            }
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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    local procedure ClearAgingBuckets()
    begin
        Aging0To30 := 0;
        Aging31To60 := 0;
        Aging61To90 := 0;
        Aging91To120 := 0;
        AgingAbove120 := 0;
    end;

    var
        CompanyInfo: Record "Company Information";
        VendorRec: Record Vendor;
        AsAtDate: Date;
        SupplierName: Text[100];
        OriginalAmount: Decimal;
        AmountPaid: Decimal;
        OutstandingBalance: Decimal;
        AgingDays: Integer;
        Aging0To30: Decimal;
        Aging31To60: Decimal;
        Aging61To90: Decimal;
        Aging91To120: Decimal;
        AgingAbove120: Decimal;
}
