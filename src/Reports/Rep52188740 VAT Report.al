/*namespace CentralDB.CentralDB;

using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.; */

report 50414 "VAT Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/VAT Report.rdlc';
    Caption = 'VAT Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(GLAccount; "G/L Account")
        {
            // DataItemTableView = "Is Vat Account" = const(true);

            dataitem(GL; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = field("No.");
                column(ReportForNavId_4645; 4645)
                {
                }
                column(EntryNo_Credit; "Entry No.")
                {
                }
                column(CustomerNo_Credit; GL."G/L Account No.")
                {
                }
                column(PostingDate_Credit; "Posting Date")
                {
                }
                column(DocumentNo_Credit; "Document No.")
                {
                }
                column(Description_Credit; Description)
                {
                }
                column(Amount_Credit; Amount)
                {
                }
                column(LoanNo_Credit; '')
                {
                }
                column(LoanType_Credit; '')
                {
                }
                column(TransactionType_Credit; '')
                {
                }

                trigger OnAfterGetRecord()
                var
                    "`": Integer;
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

                trigger OnPreDataItem()
                begin

                    dWindow.Open('Retrieving Ledgers        @1@@@@@@@@@\'
                                                + 'Counter   #2#########'
                                                + 'Total     #3#########'
                                                + 'Press Esc to abort');


                end;

            }

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
