report 50370 "Modify BankLedgerEntries"
{
    ApplicationArea = All;
    Caption = 'Modify BankLedgerEntries';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(LedgerEntry; "Bank Account Ledger Entry")
        {
            RequestFilterFields = "Document No.";
            trigger OnAfterGetRecord()
            begin
                LedgerEntry.Open := false;
                LedgerEntry.MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                LedgerEntry.SetRange("Bank Account No.", 'BNK_042');

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
}
