//namespace CentralDB.CentralDB;

report 50469 "Reverse penalty"
{
    Caption = 'Reverse [ALL]';
    ProcessingOnly = true;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "User ID", "Document No.", "Posting Date", Description, "Transaction No.", "Journal Batch Name";
            DataItemTableView = where(Reversed = const(false));
            trigger OnPreDataItem()
            var
                Usersetup: Record "User Setup";
            begin
                if not Usersetup.Get(UserId) then
                    Error('User setup for %1 was not found.', UserId);

                if not Usersetup."Reverse Report Right" then
                    Error('You do have permission to reverse general everything!');

                if GetFilter("User ID") + GetFilter("Document No.") + GetFilter("Posting Date") + GetFilter(Description) + GetFilter("Transaction No.") + GetFilter("Journal Batch Name") = '' then
                    Error('Enter at least one filter before running this reversal report.');

                if not Confirm('Are you sure you want to reverse the filtered transactions? This is a very dangerous process.', false) then
                    Error('Process Cancelled by user!');
            end;

            trigger OnAfterGetRecord()
            var
                Usersetup: Record "User Setup";
            begin
                Counter += 1;
                if not Usersetup.Get(UserId) then
                    Error('User setup for %1 was not found.', UserId);

                if not Usersetup."Reverse Report Right" then
                    Error('You do have permission to reverse general evrything!');

                if "G/L Entry"."Transaction No." = 0 then
                    CurrReport.Skip();

                if ReversedTransactions.ContainsKey("G/L Entry"."Transaction No.") then
                    CurrReport.Skip();

                EnsureTransactionIsFullyInsideFilters("G/L Entry"."Transaction No.");

                ReversedTransactions.Add("G/L Entry"."Transaction No.", true);
                Custom.SetHideWarningDialogs();
                Custom.ReverseTransaction("G/L Entry"."Transaction No.");

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        Counter: Integer;
        Custom: Record "Reversal Entry";
        ReversedTransactions: Dictionary of [Integer, Boolean];

    local procedure EnsureTransactionIsFullyInsideFilters(TransactionNo: Integer)
    var
        AllTransactionGLEntries: Record "G/L Entry";
        FilteredTransactionGLEntries: Record "G/L Entry";
    begin
        AllTransactionGLEntries.Reset();
        AllTransactionGLEntries.SetRange(Reversed, false);
        AllTransactionGLEntries.SetRange("Transaction No.", TransactionNo);

        FilteredTransactionGLEntries.CopyFilters("G/L Entry");
        FilteredTransactionGLEntries.SetRange("Transaction No.", TransactionNo);

        if AllTransactionGLEntries.Count() <> FilteredTransactionGLEntries.Count() then
            Error(
                'Transaction No. %1 has unreversed G/L entries outside the filters entered on this report. Refine the filters to include the whole transaction before reversing.',
                TransactionNo);
    end;
}
