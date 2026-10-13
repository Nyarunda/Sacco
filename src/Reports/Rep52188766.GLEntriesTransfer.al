namespace CentralDB.CentralDB;

using Microsoft.Finance.GeneralLedger.Ledger;

report 50448 "GL Entries Transfer"
{
    ApplicationArea = All;
    Caption = 'GL Entries Transfer';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(GLEntry; "G/L Entry")
        {
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetFilter("G/L Account No.", '21140350');
                SetFilter("Posting Date", '%1', DMY2Date(31, 08, 2024));
                SetFilter("Document No.", 'OPENIBAL-REG');
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                GLEntry."G/L Account No." := '21140360';
                GLEntry.Modify();
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
