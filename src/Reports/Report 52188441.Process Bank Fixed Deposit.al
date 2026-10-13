
Report 50487 "Process Bank Fixed Deposit"
{
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(FDAccount; "Fixed Deposit Accounts")
        {
            // DataItemTableView = where(select)
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RecordCounter += 1;
                dWindow.Update(1, FDAccount."No.");
                dWindow.Update(3, RecordCounter);
                dWindow.Update(4, ROUND(RecordCounter / TotalRecords * 10000, 1));

                if "FD Maturity Date" < DMY2Date(01, 01, 2023) then
                    CurrReport.Skip();

                if "FD Maturity Date" > DMY2Date(01, 01, 2023) then begin
                    if "FD Status" <> "FD Status"::Active then begin
                        "FD Status" := "FD Status"::Active;
                        Modify();
                    end;
                end;


                if (FDAccount."FD Start Date" <= SelectPeriod) and (FDAccount."FD Maturity Date" >= SelectPeriod) then
                    BankingActivities.CalculateFixedInterest(FDAccount, SelectPeriod, ProductSetup)
                else
                    if (FDAccount."FD Start Date" <= SelectPeriod) and (FDAccount."FD Maturity Date" < SelectPeriod) and (SaccoSetup."FD Interest Accrual" = SaccoSetup."FD Interest Accrual"::"Calculate and Post On Maturity") then
                        BankingActivities.CalculateFixedInterest(FDAccount, SelectPeriod, ProductSetup);

                BankingActivities.ProcessPlacement(FDAccount."No.", SelectPeriod, ProductSetup);
            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
            end;

            trigger OnPreDataItem()
            begin

                ProductSetup.Reset;
                ProductSetup.SetRange("Product Category", ProductSetup."product category"::"Fixed Deposit");
                if not ProductSetup.FindFirst then
                    CurrReport.Quit;

                if SelectPeriod = 0D then
                    SelectPeriod := Today;


                //FDAccount.SetRange("Date Filter", 0D, SelectPeriod);
                FDAccount.SetFilter("Fixed Account Balance", '>0');
                FDAccount.SetFilter("FD Start Date", '<%1', SelectPeriod);
                FDAccount.SetFilter("FD Maturity Date", '<=%1', SelectPeriod);
                dWindow.Open('Process Fixed Deposit:              #1#########\'
                                    + 'Total Accounts:             #2#########\'
                                    + 'Counter:                    #3#########\'
                                    + 'Progress:                  @4@@@@@@@@@\'
                                    + 'Press Esc to abort');

                TotalRecords := FDAccount.Count;
                dWindow.Update(2, TotalRecords);
                RecordCounter := 0;
            end;
        }
    }

    requestpage
    {


        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(SelectPeriod; SelectPeriod)
                    {
                        ApplicationArea = Basic;
                    }
                }
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
        TotalRecords: Integer;
        dWindow: Dialog;
        FAcc: Record "Savings Accounts";
        SaccoActivities: Codeunit "Sacco Activities";
        RecordCounter: Integer;
        StartDate: Date;
        EndDate: Date;
        SaccoSetup: Record "Sacco Setup";
        BankingActivities: Codeunit "Banking Activities";
        SelectPeriod: Date;
        ProductSetup: Record "Product Setup";
}

