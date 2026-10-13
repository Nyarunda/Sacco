/// <summary>
/// Unknown CentralDB.
/// </summary>
namespace CentralDB.CentralDB;

report 50413 "Daily Teller Transactions"
{

    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Daily Teller Transactions.rdlc';
    Caption = 'Daily Teller Transactions';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(TellerTransaction; "Teller Transaction")
        {
            RequestFilterFields = Type, "Transaction Date", Cashier;
            DataItemTableView = where(posted = const(true));

            column(TransactionNo; "Transaction No.")
            {
            }
            column(TransactionType; "Transaction Type")
            {
            }
            column(TransactionDate; "Transaction Date")
            {
            }
            column(AccountName; "Account Name")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(AccountStatus; "Account Status")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(Cashier; Cashier)
            {
            }
            column(ChequeNo; "Cheque No")
            {
            }
            column(ChequeType; "Cheque Type")
            {
            }
            column(Amount; Amount)
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            dataitem(TellerLines; "Teller Lines")
            {
                DataItemLink = "Transaction No." = field("Transaction No.");
                column(Member_No_; TellerLines."Member No.")
                {

                }
                column(Loan_No_; TellerLines."Loan No.")
                {

                }
                column(Transaction_Type; TellerLines."Transaction Type")
                {

                }
                column(Account_No_; TellerLines."Account No.")
                {

                }

            }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                NoOfRecords := TellerTransaction.Count;



                dWindow.Open('Generating :      #1#########\'
                                    + 'Accounts:             #2#########\'
                                    + 'Counter:              #3#########\'
                                    + 'Progress:             @4@@@@@@@@@\'
                                    + 'Press Esc to abort');

                dWindow.Update(2, NoOfRecords);
            end;

            trigger OnAfterGetRecord()
            var
            // "`": Integer;
            begin
                CurrentRecordNo += 1;

                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
                Message('Completed');
            end;


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
    var
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
}

