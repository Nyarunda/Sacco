
Report 51060 "Generate Old Balances"
{
    ProcessingOnly = true;


    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = where("Product Type" = filter('S02' | 'S03'));
            RequestFilterFields = "No.", "Member No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RecordCounter += 1;
                dWindow.Update(1, Vendor.Name);
                dWindow.Update(3, RecordCounter);
                dWindow.Update(4, ROUND(RecordCounter / TotalRecords * 10000, 1));

                CloseBal := 0;

                MemberBalances.Reset();
                MemberBalances.SetRange("Account No.", "No.");
                MemberBalances.SetRange(Date, DMY2Date(31, 12, 2021));
                if MemberBalances.FindFirst() then begin
                    CloseBal := MemberBalances.Balance;
                end;
                TDate := StartDate;
                while TDate <= Enddate do begin

                    MLedger.Reset();
                    MLedger.SetCurrentKey("Customer No.");
                    MLedger.SetRange("Customer No.", "No.");
                    MLedger.SetFilter("Posting Date", '..%1', TDate);
                    if MLedger.FindFirst() then begin
                        MLedger.CalcSums("Amount (LCY)");
                        MLedger."Amount (LCY)" := MLedger."Amount (LCY)" * -1;

                        MemberBalances.Reset();
                        MemberBalances.SetRange("Account No.", "No.");
                        MemberBalances.SetRange(Date, TDAte);
                        if MemberBalances.FindFirst() then begin

                            MemberBalances.Name := Name;
                            MemberBalances.Balance := CloseBal + MLedger."Amount (LCY)";
                            MemberBalances.Modify;
                        end
                        else begin
                            MemberBalances.Init();
                            MemberBalances."Account No." := "No.";
                            MemberBalances.Date := TDate;
                            MemberBalances.Name := Name;
                            MemberBalances.Balance := CloseBal + MLedger."Amount (LCY)";
                            MemberBalances.Insert();
                        end;
                    end;
                    TDate := CalcDate('1M+CM', TDAte)
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





                TotalRecords := Vendor.Count;
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
        CloseBal: Decimal;
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

