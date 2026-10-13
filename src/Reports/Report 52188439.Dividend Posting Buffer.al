
Report 50083 "Dividend Posting Buffer"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Members; Members)
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                ProductSetup: Record "Product Setup";
                MActicities: Codeunit "Member Activities";
                SaccoSetup: Record "Sacco Setup";
            begin
                RecordCounter += 1;
                dWindow.Update(1, Members.Name);
                dWindow.Update(3, RecordCounter);
                dWindow.Update(4, ROUND(RecordCounter / TotalRecords * 10000, 1));

                SaccoSetup.Get();

                DividendsProgression.Reset;
                DividendsProgression.SetRange("Member No", Members."No.");
                if not DividendsProgression.FindFirst then
                    CurrReport.Skip;

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                MemberAccounts.SetRange("Product Type", SaccoSetup."Dividend Processing Account");
                if not MemberAccounts.FindFirst then begin
                    ProductSetup.Reset();
                    ProductSetup.SetRange("Product ID", SaccoSetup."Dividend Processing Account");
                    if ProductSetup.FindFirst() then
                        MActicities.CreateSavingsAccount(ProductSetup, Members, 0, true, ProductSetup."Repay Mode");

                end;

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                MemberAccounts.SetRange("Product Type", SaccoSetup."Dividend Processing Account");
                if MemberAccounts.FindFirst then
                    SaccoActivities.GenerateDividendPostingBuffer(Members."No.", DivYear, MemberAccounts."No.", SaccoSetup."Dividend Activity Code", Members."Global Dimension 2 Code", PDate)
                else
                    Error('Member No. %1 - %2 does not have a dividend processing account.', Members."No.", Members.Name);
            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
            end;

            trigger OnPreDataItem()
            begin



                dWindow.Open('Dividend Generation:            #1#########\'
                                    + 'Total Members:              #2#########\'
                                    + 'Counter:                    #3#########\'
                                    + 'Progress:                  @4@@@@@@@@@\'
                                    + 'Press Esc to abort');




                TotalRecords := Members.Count;
                dWindow.Update(2, TotalRecords);
                RecordCounter := 0;


                SaccoSetup.Get;

                SaccoSetup.TestField("Dividend Year Date");
                SaccoSetup.TestField("Dividend Processing Account");
                SaccoSetup.TestField("Dividend Activity Code");

                StartDate := CalcDate('-CY', SaccoSetup."Dividend Year Date");
                EndDate := CalcDate('CY', SaccoSetup."Dividend Year Date");

                DivYear := Date2dmy(EndDate, 3);

                if PDate = 0D then
                    Error('Enter Posting Date');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Posting Date"; PDate)
                {
                    ApplicationArea = Basic;
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
        DivYear: Integer;
        PDate: Date;
        MemberAccounts: Record "Savings Accounts";
        DividendsProgression: Record "Dividends Progression";
}

