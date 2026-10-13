report 50100 "Request for Quotation Detail"
{
    ApplicationArea = All;
    Caption = 'Request for Quotation Detail';
    UsageCategory = ReportsAndAnalysis;
    ExcelLayout = 'Layouts/MsaPort Request For Quotation.xlsx';
    DefaultLayout = Excel;

    dataset
    {
        dataitem(RFQLine; "RFQ Line")
        {
            column(DocumentNo; "Document No.")
            {
            }
            column(Type; "Type")
            {
            }
            column(Description; Description)
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(UnitCost; "Unit Cost")
            {
            }
            column(Amount; Amount)
            {
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
}
