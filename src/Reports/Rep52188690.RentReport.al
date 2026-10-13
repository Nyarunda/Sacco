/// <summary>
/// Report Rent Analysis Report (ID 50353).
/// </summary>
report 50353 "Rent Analysis Report"
{
    ApplicationArea = All;
    Caption = 'Rent Analysis Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/RentReport.rdlc';

    dataset
    {

        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Account Type" = const(Tenant));
            RequestFilterFields = "No.";
            column(No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(Address_1; CompanyInfo.Address)
            {
            }
            column(Address_2; CompanyInfo."Address 2")
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Phone_No2; CompanyInfo."Phone No. 2")
            {
            }
            column(Month; Month) { }
            column(ExpectedAmount; ExpectedAmount) { }
            dataitem("Credit Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLinkReference = Customer;
                DataItemLink = "customer No." = field("No.");
                DataItemTableView = where(Amount = filter(< 0));
                column(AmountPaid; AmountPaid) { }
                column(CPosting_Date; "Posting Date") { }
                trigger OnPreDataItem()

                begin
                    SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                end;

                trigger onafterGetRecord()
                begin
                    Month := CopyStr(Format("Credit Ledger Entry"."Posting Date", 0, '<Month Text>'), 1, 3);

                    if "Credit Ledger Entry".Amount > 0 then
                        ExpectedAmount := "Credit Ledger Entry".Amount;
                    if "Credit Ledger Entry".Amount > 0 then
                        AmountPaid := "Credit Ledger Entry".Amount * -1;
                end;
            }
            dataitem(SHeader; "Sales Invoice Header")
            {
                DataItemLinkReference = Customer;
                DataItemLink = "sell-to Customer No." = field("No.");

                column(Posting_Date; "Posting Date") { }


                dataitem(SLines; "Sales Invoice Line")
                {

                    DataItemLink = "Document No." = field("No.");
                    column(Amount_Including_VAT; "Amount Including VAT")
                    { }
                    column(Sell_to_Customer_No_; "Sell-to Customer No.") { }


                }
                trigger onpredataItem()
                begin
                    CompanyInfo.Get;
                    CompanyInfo.CalcFields(Picture);
                    SetFilter("Posting Date", '%1..%2', StartDate, EndDate);

                end;

            }
            trigger onpredataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
                Month := CopyStr(Format(StartDate, 0, '<Month Text>'), 1, 3);

            end;


        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(CutstomFilters)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                    }
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
    var
        CompanyInfo: Record "Company Information";
        StartDate: date;
        EndDate: date;
        Month: Text;
        ExpectedAmount: Decimal;
        AmountPaid: Decimal;
}
