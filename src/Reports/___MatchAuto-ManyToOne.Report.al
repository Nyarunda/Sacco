Report 50330 "Match Auto - Many to One"
{
    // 
    // Bank Account No.=FIELD(Bank Account No.),Open=CONST(Yes),Statement Status=FILTER(Open|Bank Acc. Entry Applied|Check Entry Applied),Reversed=FILTER(No)
    // 
    // 
    // Bank Account No.=FIELD(Bank Account No.),Statement No.=FIELD(Statement No.)

    DefaultLayout = RDLC;

    ProcessingOnly = true;
    Permissions = tabledata "Bank Account Ledger Entry" = rimd,
                  tabledata "Bank Acc. Reconciliation Line" = rimd
                ;

    dataset
    {
        dataitem(BankRec; "Bank Acc. Reconciliation")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                LedgerEntryTotals: Record "Bank Account Ledger Entry";
                TotalRemainingAmount: Decimal;
                AppliedEntries: Integer;
            begin

                StatementLines.Reset;
                StatementLines.SetRange("Bank Account No.", BankRec."Bank Account No.");
                StatementLines.SetRange("Statement No.", BankRec."Statement No.");
                StatementLines.SetRange("Statement Type", BankRec."Statement Type");
                StatementLines.SetFilter("Difference", '<>%1', 0);
                if StatementLines.FindFirst then begin

                    NoOfRecords := StatementLines.Count;
                    CurrentRecordNo := 0;
                    SActivities.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);

                    repeat

                        CurrentRecordNo += 1;
                        SActivities.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, '');

                        LedgerEntry.Reset;
                        LedgerEntry.SetRange("Bank Account No.", BankRec."Bank Account No.");
                        LedgerEntry.SetRange(Open, true);
                        LedgerEntry.SetFilter("Statement Status", 'Open|Bank Acc. Entry Applied|Check Entry Applied');
                        LedgerEntry.SetRange(Reversed, false);
                        LedgerEntry.SetRange("Document No.", StatementLines."Document No.");
                        LedgerEntry.SetFilter("Statement Difference", '<>0'); //08.03.2025
                        /*  if MatchOption = Matchoption::"Date & Document No & Amount" then
                              LedgerEntry.SetRange("Posting Date", StatementLines."Transaction Date"); */
                        if LedgerEntry.FindFirst then begin
                            LedgerEntryTotals.CopyFilters(LedgerEntry);
                            LedgerEntryTotals.CalcSums("Remaining Amount");
                            TotalRemainingAmount := LedgerEntryTotals."Remaining Amount";

                            if TotalRemainingAmount = StatementLines."Statement Amount" then begin


                                LedgerEntry."Match Option" := LedgerEntry."Match Option"::"Document No & Amount";
                                StatementLines."Match Option" := StatementLines."Match Option"::"Document No & Amount";

                                StatementLines."Applied Amount" := StatementLines."Statement Amount";
                                AppliedEntries := LedgerEntry.Count();
                                StatementLines."Applied Entries" := AppliedEntries;
                                //StatementLines."Applied Amount" += LedgerEntry."Remaining Amount";
                                StatementLines.VALIDATE("Statement Amount");
                                StatementLines.Reconciled := true;
                                StatementLines.MODIFY;


                                repeat
                                    LedgerEntry.TestField(Open, true);
                                    if LedgerEntry."Posting Date" > DMY2Date(31, 10, 2022) then begin

                                        //LedgerEntry.TestField("Statement No.", '');
                                        //LedgerEntry.TestField("Statement Line No.", 0);
                                        if LedgerEntry."Statement Status" = LedgerEntry."Statement Status"::Closed then
                                            Error('Statement STatus CLosed');
                                    end;

                                    LedgerEntry.TestField("Bank Account No.", StatementLines."Bank Account No.");
                                    // this confirm is introduced because there can be ledger entries whose statement status is corrupt because of a bug with undo bank account statement

                                    LedgerEntry."Statement Status" :=
                                    LedgerEntry."Statement Status"::"Bank Acc. Entry Applied";
                                    LedgerEntry."Statement No." := StatementLines."Statement No.";
                                    LedgerEntry."Statement Line No." := StatementLines."Statement Line No.";

                                    LedgerEntry."Statement Difference" := 0;
                                    LedgerEntry.Modify();

                                until LedgerEntry.Next() = 0;
                            end;
                        end
                        ELSE begin

                            
                            LedgerEntry.Reset();
                            LedgerEntry.SetRange("Bank Account No.", BankRec."Bank Account No.");
                            LedgerEntry.SetRange(Open, true);
                            LedgerEntry.SetFilter("Statement Status", 'Open|Bank Acc. Entry Applied|Check Entry Applied');
                            LedgerEntry.SetRange(Reversed, false);
                            LedgerEntry.SetRange("External Document No.", StatementLines."Document No.");
                            /*  if MatchOption = Matchoption::"Date & Document No & Amount" then
                                 LedgerEntry.SetRange("Posting Date", StatementLines."Transaction Date"); */
                            if LedgerEntry.FindFirst then begin

                                LedgerEntryTotals.CopyFilters(LedgerEntry);
                                LedgerEntryTotals.CalcSums("Remaining Amount");
                                TotalRemainingAmount := LedgerEntryTotals."Remaining Amount";

                                if TotalRemainingAmount = StatementLines."Statement Amount" then begin

                                    LedgerEntry."Match Option" := LedgerEntry."Match Option"::"Document No & Amount";
                                    StatementLines."Match Option" := StatementLines."Match Option"::"Document No & Amount";



                                    //commit;
                                    //StatementLines.Type := StatementLines.Type::"Bank Account Ledger Entry";
                                    StatementLines."Applied Amount" := StatementLines."Statement Amount";
                                    AppliedEntries := LedgerEntry.Count();
                                    StatementLines."Applied Entries" := AppliedEntries;
                                    //BankAccSetStmtNo.SetReconNo(BLedger, StatementLines);
                                    //StatementLines."Applied Amount" += LedgerEntry."Remaining Amount";
                                    StatementLines.VALIDATE("Statement Amount");
                                    StatementLines.Reconciled := true;
                                    StatementLines.MODIFY;

                                    repeat
                                        LedgerEntry.TestField(Open, true);
                                        /*if LedgerEntry."Posting Date" > DMY2Date(31, 10, 2022) then begin //ez

                                            LedgerEntry.TestField("Statement No.", '');
                                            LedgerEntry.TestField("Statement Line No.", 0);
                                            if LedgerEntry."Statement Status" = LedgerEntry."Statement Status"::Closed then
                                                Error('Statement Status CLosed');
                                        end;*/

                                        LedgerEntry.TestField("Bank Account No.", StatementLines."Bank Account No.");
                                        // this confirm is introduced because there can be ledger entries whose statement status is corrupt because of a bug with undo bank account statement

                                        LedgerEntry."Statement Status" :=
                                        LedgerEntry."Statement Status"::"Bank Acc. Entry Applied";
                                        LedgerEntry."Statement No." := StatementLines."Statement No.";
                                        LedgerEntry."Statement Line No." := StatementLines."Statement Line No.";

                                        LedgerEntry."Statement Difference" := 0;
                                        LedgerEntry.Modify();
                                    until LedgerEntry.Next() = 0;
                                end;

                            end
                        end;





                    until StatementLines.Next = 0;
                    SActivities.ProgressClose(dWindow);
                end;


            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin

            end;


            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin


            end;
        }
    }

    requestpage
    {


        layout
        {
            area(content)
            {
                // field("Match Option"; MatchOption)
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }

        actions
        {

        }
    }

    labels
    {
    }

    var
        StatementLines: Record "Bank Acc. Reconciliation Line";
        LedgerEntry: Record "Bank Account Ledger Entry";
        MatchOption: Option "Date & Document No & Amount","Document No & Amount";
        StmtLines: Record "Bank Acc. Reconciliation Line";
        MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
        SActivities: Codeunit "Sacco Activities";
        dwIndow: Dialog;

        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
}

