namespace AL_.AL_;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Sales.Customer;

report 50491 "Match Sledger to GL"
{
    ApplicationArea = All;
    Caption = 'Match Sledger to GL';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(SavingsLedgerEntry; "Savings Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "Document No.", "Transaction No.", "Entry No.", "Product Type";
            column(EntryNo; "Entry No.")
            {
            }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                NoOfRecords := SavingsLedgerEntry.Count;
                SAct.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
            end;



            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin

                SAct.ProgressClose(dWindow);

            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                GLEntry: Record "G/L Entry";
                Savings: Record "Savings Accounts";
                PGroup: Record "Customer Posting Group";
                PSetup: Record "Product Setup";

            begin
                CurrentRecordNo += 1;
                SAct.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, 'Current Entry:' + SavingsLedgerEntry."Document No.");
                GLEntry.Reset();
                GLEntry.SetRange("Entry No.", SavingsLedgerEntry."Entry No.");
                GLEntry.SetRange("Transaction No.", SavingsLedgerEntry."Transaction No.");
                GLEntry.SetRange(Amount, SavingsLedgerEntry.Amount);
                GLEntry.SetRange("Source No.", SavingsLedgerEntry."Account No.");
                if GLEntry.FindFirst() then begin
                    if Savings.get(SavingsLedgerEntry."Account No.") then begin
                        if PSetup.get(Savings."Product Type") then begin
                            PGroup.Reset();
                            PGroup.SetRange(Code, PSetup."Product Posting Group");
                            PGroup.SetFilter("Receivables Account", '<>%1', '');
                            if PGroup.FindFirst() then begin
                                if GLEntry."G/L Account No." <> PGroup."Receivables Account" then begin
                                    GLEntry."G/L Account No." := PGroup."Receivables Account";
                                    GLEntry.Modify();
                                end;
                            end;
                        end;
                    end;


                end;
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
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;

        SAct: Codeunit "Sacco Activities";

}
