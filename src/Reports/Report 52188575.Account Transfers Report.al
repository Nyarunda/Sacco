
Report 50238 "Account Transfers Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Account Transfers Report.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Transfers; "Account Transfers")
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = No, "Transaction Date", "Created By";
            column(ReportForNavId_1; 1)
            {
            }
            column(No_Transfers; Transfers.No)
            {
            }
            column(TransactionDate_Transfers; Transfers."Transaction Date")
            {
            }
            column(CreatedBy_Transfers; Transfers."Created By")
            {
            }
            column(AccountType; AccountType)
            {
            }
            column(AccountNo; AccountNo)
            {
            }
            column(Product; Product)
            {
            }
            column(Balance; Balance)
            {
            }
            column(TransferAmount; TransferAmount)
            {
            }
            column(LoanNo; LoanNo)
            {
            }
            column(TType; TType)
            {
            }
            dataitem(Destination; "Destination Account Transfers")
            {
                DataItemLink = "No." = field(No);
                column(ReportForNavId_5; 5)
                {
                }
                column(DestinationAccountTypeDestination; Destination."Destination Account Type")
                {
                }
                column(DestinationAccountNo; Destination."Destination Account No.")
                {
                }
                column(DestinationLoanNo; Destination."Destination Loan No.")
                {
                }
                column(DestinationTransactionType; Destination."Destination Transaction Type")
                {
                }
                column(DestinationAccountName; Destination."Destination Account Name")
                {
                }
                column(DestinationAmount; Destination."Destination Amount")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                AccountType := '';
                AccountNo := '';
                Product := '';
                Balance := 0;
                TransferAmount := 0;
                LoanNo := '';
                TType := '';



                Source.Reset;
                Source.SetRange("No.", Transfers.No);
                if Source.FindFirst then begin
                    AccountType := Format(Source."Source Account Type");
                    AccountNo := Source."Source Account No.";
                    Product := Source."Product Name";
                    Balance := Source."Available Balance";
                    TransferAmount := Source."Source Amount";
                    LoanNo := Source."Source Loan No.";
                    TType := Format(Source."Source Transaction Type");

                end;
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

    var
        AccountType: Text;
        AccountNo: Text;
        Product: Text;
        Balance: Decimal;
        TransferAmount: Decimal;
        LoanNo: Code[20];
        TType: Text;
        Source: Record "Source Account Transfer";
}

