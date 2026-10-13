Report 50275 "Bank Branch Transactions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Bank Branch Transactions.rdlc';

    dataset
    {
        dataitem(Treasury; "Treasury/Teller Transactions")
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Date Issued";
            column(ReportForNavId_1; 1)
            {
            }
            column(DateReceived_TreasuryCashierTransactions; "Date Received")
            {
            }
            column(DateIssued_TreasuryCashierTransactions; "Date Issued")
            {
            }
            column(No_TreasuryCashierTransactions; Code)
            {
            }
            column(TransactionDate_TreasuryCashierTransactions; "Transaction Date")
            {
            }
            column(BankFrom; BankFrom)
            {
            }
            column(BankTo; BankTo)
            {
            }
            column(Amount_Treasury; Treasury.Amount)
            {
            }
            column(FromName; FromName)
            {
            }
            column(ToName; ToName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                BankFrom := '';
                BankTo := '';

                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetRange("Document No.", Treasury.Code);
                if BankAccountLedgerEntry.FindFirst then begin
                    repeat
                        BankAccount.Get(BankAccountLedgerEntry."Bank Account No.");
                        if BankAccount."Bank Type" <> BankAccount."bank type"::Treasury then
                            CurrReport.Skip;

                        if BankAccountLedgerEntry.Amount < 0 then
                            BankFrom := BankAccountLedgerEntry."Bank Account No.";

                        if BankAccountLedgerEntry.Amount > 0 then
                            BankTo := BankAccountLedgerEntry."Bank Account No.";

                    until BankAccountLedgerEntry.Next = 0;
                end
                else
                    CurrReport.Skip;

                BankAccount.Get(BankFrom);
                FromName := BankAccount.Name;

                BankAccount.Get(BankTo);
                ToName := BankAccount.Name;
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
        BankAccount: Record "Bank Account";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        BankFrom: Code[20];
        BankTo: Code[20];
        FromName: Text;
        ToName: Text;
}

