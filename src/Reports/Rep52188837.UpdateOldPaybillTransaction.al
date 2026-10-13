namespace UnitedWomen_Production.UnitedWomen_Production;

report 50539 "Update Old Paybill Transaction"
{
    Caption = 'Update Old Paybill Transaction';
    ProcessingOnly = true;
    dataset
    {
        dataitem(SkyMBankingTransactions; "Sky M-Banking Transactions")
        {

            trigger OnPreDataItem()
            begin
                SkyMBankingTransactions.SetFilter("Transaction Date", '..%1', DMY2Date(23, 08, 2025));
            end;

            trigger OnAfterGetRecord()
            begin
                SkyMBankingTransactions."Needs Change" := false;
                SkyMBankingTransactions.posted := true;
                SkyMBankingTransactions.Modify();
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
    trigger OnPostReport()

    begin
        Message('Old Paybill Transactions Updated Successfully');
    end;
}
