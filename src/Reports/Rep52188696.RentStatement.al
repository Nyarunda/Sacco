report 50359 "Rent Statement"
{
    ApplicationArea = All;
    Caption = 'Rent Statement Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/RentStatementReport.rdlc';

    dataset
    {

        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Account Type" = const(Tenant));
            column(No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(CustomerNo; CustomerNo)
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(Address_1; CompanyInformation.Address)
            {
            }
            column(Address_2; CompanyInformation."Address 2")
            {
            }
            column(City; CompanyInformation.City)
            {
            }
            column(Email; CompanyInformation."E-Mail")
            {
            }
            column(Phone_No; CompanyInformation."Phone No.")
            {
            }
            column(Phone_No2; CompanyInformation."Phone No. 2")
            {
            }
            column(Month; Month) { }

            dataitem("Credit Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLinkReference = Customer;
                DataItemLink = "customer No." = field("No.");

                column(Amount; Amount) { }
                column(CPosting_Date; "Posting Date") { }
                column(ExpectedAmount; ExpectedAmount) { }
                column(AmountPaid; AmountPaid) { }
                trigger OnPreDataItem()

                begin
                    SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                end;

                trigger onafterGetRecord()
                begin
                    Month := CopyStr(Format("Credit Ledger Entry"."Posting Date", 0, '<Month Text>'), 1, 3);
                    Year := Date2DMY("Credit Ledger Entry"."Posting Date", 3);
                    YearStr := CopyStr(format(Year), 3, 2);
                    Month := StrSubstNo(Month + '-' + YearStr);
                    if "Credit Ledger Entry".Amount > 0 then
                        ExpectedAmount := "Credit Ledger Entry".Amount;
                    if "Credit Ledger Entry".Amount > 0 then
                        AmountPaid := "Credit Ledger Entry".Amount * -1;
                end;
            }
            dataitem(SHeader; "Sales Invoice Header")
            {
                dataitem(SLines; "Sales Invoice Line")
                {

                    // DataItemLink = "Document No." = field("No."), "sell-to Customer No." = field("No.");
                    // column(Amount_Including_VAT; "Amount Including VAT")
                    // { }
                    // column(Sell_to_Customer_No_; "Sell-to Customer No.") { }

                }
                trigger OnPreDataItem()

                begin
                    // SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                end;


            }
            trigger OnPreDataItem()
            begin
                if CompanyInformation.Get then
                    CompanyInformation.CalcFields(CompanyInformation.Picture);
                CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
                CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
#pragma warning disable AL0432
                CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432
                if CustomerNo = '' then begin
                    Error('Please Specify the customer No. before proceeding');


                end;
                if CustomerNo <> '' then SetFilter("No.", '%1', CustomerNo);

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
                    field("Customer No"; CustomerNo)
                    {
                        ApplicationArea = All;
                        TableRelation = Customer where("Account Type" = const(Tenant));

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
        CompanyInformation: Record "Company Information";
        StartDate: date;
        EndDate: date;
        Month: Text;
        ExpectedAmount: Decimal;
        CustomerNo: code[20];
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Year: Integer;
        YearStr: Text;
        AmountPaid: Decimal;

}
