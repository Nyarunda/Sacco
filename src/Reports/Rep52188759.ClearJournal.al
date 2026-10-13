namespace CentralDB.CentralDB;

using Microsoft.Finance.GeneralLedger.Journal;

report 50441 "Clear Journal"
{
    ApplicationArea = All;
    Caption = 'Clear Journal';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(GenJournalLine; "Gen. Journal Line")
        {
            //DataItemTableView = where("Journal Batch Name" = filter(' '));
            RequestFilterFields = "Journal Template Name", "Journal Batch Name";
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if GenJournalLine."Journal Batch Name" <> '' then
                    GenJournalLine.Delete();
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                Message('Done');
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
}
