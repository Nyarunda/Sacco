
Report 50144 "Cheque Register Detailed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Cheque Register Detailed.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(ReportForNavId_14; 14)
            {
            }
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }
        }
        dataitem("Teller Transaction"; "Teller Transaction")
        {
            DataItemTableView = where("Transaction Mode" = const(Cheque));
            column(ReportForNavId_1; 1)
            {
            }
            column(TransactionNo_TellerTransaction; "Teller Transaction"."Transaction No.")
            {
            }
            column(AccountNo_TellerTransaction; "Teller Transaction"."Account No.")
            {
            }
            column(AccountName_TellerTransaction; "Teller Transaction"."Account Name")
            {
            }
            column(TransactionType_TellerTransaction; "Teller Transaction"."Transaction Type")
            {
            }
            column(Amount_TellerTransaction; "Teller Transaction".Amount)
            {
            }
            column(Cashier_TellerTransaction; "Teller Transaction".Cashier)
            {
            }
            column(TransactionDate_TellerTransaction; "Teller Transaction"."Transaction Date")
            {
            }
            column(ChequeType_TellerTransaction; "Teller Transaction"."Cheque Type")
            {
            }
            column(ChequeNo_TellerTransaction; "Teller Transaction"."Cheque No")
            {
            }
            column(ChequeDate_TellerTransaction; "Teller Transaction"."Cheque Date")
            {
            }
            column(DrawerName_TellerTransaction; "Teller Transaction"."Drawer Name")
            {
            }
            column(ChequeStatus_TellerTransaction; "Teller Transaction"."Cheque Status")
            {
            }
            column(Date_Cleared; "Date Cleared")
            {
            }
            column(Payee; Payee)
            {
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if "Drawer Name" = '' then
                    "Drawer Name" := Payee;
            end;
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
}

