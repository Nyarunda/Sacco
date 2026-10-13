Report 50339 "Bank Acc. Recon. Clear Lines"
{
    // 
    // Bank Account No.=FIELD(Bank Account No.),Open=CONST(Yes),Statement Status=FILTER(Open|Bank Acc. Entry Applied|Check Entry Applied),Reversed=FILTER(No)
    // 
    // 
    // Bank Account No.=FIELD(Bank Account No.),Statement No.=FIELD(Statement No.)
    ProcessingOnly = true;


    dataset
    {
        dataitem(BankRec; "Bank Acc. Reconciliation")
        {
            column(ReportForNavId_1; 1)
            {
            }



            trigger OnAfterGetRecord()
            begin


                if Confirm('Are you sure you want to DELETE Statement Lines?') then begin

                    StatementLines.Reset;
                    StatementLines.SetRange("Bank Account No.", BankRec."Bank Account No.");
                    StatementLines.SetRange("Statement No.", BankRec."Statement No.");
                    StatementLines.SetRange("Statement Type", BankRec."Statement Type");
                    if StatementLines.FindFirst then begin

                        NoOfRecords := StatementLines.Count;
                        CurrentRecordNo := 0;
                        SActivities.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);

                        repeat

                            CurrentRecordNo += 1;
                            SActivities.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, '');

                            StatementLines.Delete(true);

                        until StatementLines.Next = 0;
                        SActivities.ProgressClose(dWindow);
                    end;

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

