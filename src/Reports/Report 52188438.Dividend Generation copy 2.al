
Report 51061 "Transfer MLedger Balances"
{
    ProcessingOnly = true;


    dataset
    {
        dataitem("Member Ledger Entry"; "Member Ledger Entry")
        {
            DataItemTableView = where("Product Type" = filter('S02' | 'S03'));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RecordCounter += 1;
                dWindow.Update(1, "Entry No.");
                dWindow.Update(3, RecordCounter);
                dWindow.Update(4, ROUND(RecordCounter / TotalRecords * 10000, 1));


                if not MLedger.Get("Entry No.") then begin
                    MLedger.Init();
                    MLedger.TransferFields("Member Ledger Entry");
                    MLedger.Insert();
                end;

            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
            end;

            trigger OnPreDataItem()
            begin



                dWindow.Open('Balances Generation:            #1#########\'
                                    + 'Total Members:              #2#########\'
                                    + 'Counter:                    #3#########\'
                                    + 'Progress:                  @4@@@@@@@@@\'
                                    + 'Press Esc to abort');




                TotalRecords := Count;
                dWindow.Update(2, TotalRecords);
                RecordCounter := 0;
                StartDate := DMY2Date(31, 01, 2022);
                EndDate := DMY2Date(31, 10, 2022);

            end;
        }


    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        TotalRecords: Integer;
        dWindow: Dialog;
        FAcc: Record "Savings Accounts";
        SaccoActivities: Codeunit "Sacco Activities";
        RecordCounter: Integer;
        StartDate: Date;
        EndDate: Date;
        SaccoSetup: Record "Sacco Setup";
        SNo: Code[20];
        ENo: Code[20];
        MemberBalances: Record "Member Balances";
        MLedger: Record "Dividend Ledger Entry";
        TDate: Date;
}

