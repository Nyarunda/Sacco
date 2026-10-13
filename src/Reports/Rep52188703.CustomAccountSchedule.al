report 50366 "Custom Account Schedule"
{
    Caption = 'Custom Account Schedule';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Custom Account Schedule.rdlc';


    dataset
    {
        dataitem(AccScheduleLine; "Acc. Schedule Line")
        {
            RequestFilterFields = "Schedule Name";
            column(ScheduleName; "Schedule Name")
            {
            }
            column(DFilter; DFilter)
            {
            }
            column(RowNo; "Row No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Bold; Bold)
            {
            }
            column(Italic; Italic)
            {
            }
            column(Underline; Underline)
            {
            }
            column(ShowOppositeSign; "Show Opposite Sign")
            {
            }


            column(Actuals; Actuals)
            {
            }
            column(Budgeted; Budgeted)
            {
            }
            column(Variance; Variance)
            {
            }
            column(VarianceP; VarianceP)
            {
            }
            column(LastYearActuals; LastYearActuals)
            {
            }
            column(LastYearBudgeted; LastYearBudgeted)
            {
            }


            trigger OnAfterGetRecord()
            var
                GLAcc: Record "G/L Account";
                BEntry: Record "G/L Budget Entry";
            begin

                Actuals := 0;
                Budgeted := 0;
                Variance := 0;
                VarianceP := 0;
                LastYearActuals := 0;
                LastYearBudgeted := 0;

                if Totaling <> '' then begin

                    GLAcc.Reset();
                    GLAcc.SetFilter("No.", Totaling);
                    GLAcc.SetFilter("Date Filter", '%1..%2', SDate, EDate);
                    if GLAcc.FindFirst() then begin
                        GLAcc.CalcFields("Net Change");
                        Actuals := GLAcc."Net Change" * -1;
                    end;

                    BEntry.Reset();
                    BEntry.SetFilter("G/L Account No.", Totaling);
                    BEntry.SetRange(Date, SDate, EDate);
                    if BEntry.FindFirst() then begin
                        BEntry.CalcSums(Amount);
                        Budgeted := BEntry.Amount;
                    end;

                    Variance := Budgeted - Actuals;
                    if Budgeted > 0 then
                        VarianceP := (Budgeted + Actuals) / Budgeted * 100;

                    Variance := Variance * -1;
                    VarianceP := VarianceP * -1;


                    GLAcc.Reset();
                    GLAcc.SetRange("No.", Totaling);
                    GLAcc.SetFilter("Date Filter", '%1..%2', CalcDate('-1Y', SDate), CalcDate('-1Y', EDate));
                    if GLAcc.FindFirst() then begin
                        GLAcc.CalcFields("Net Change");
                        LastYearActuals := GLAcc."Net Change" * -1;
                    end;

                    GLBAlances.Reset();
                    GLBAlances.SetRange("G/L Account", Totaling);
                    GLBAlances.SetFilter("Date", '%1..%2', CalcDate('-1Y', SDate), CalcDate('-1Y', EDate));
                    if GLBAlances.FindFirst() then begin
                        GLBAlances.CalcSums(Balance);
                        LastYearActuals += GLBAlances.Balance;
                    end;

                    BEntry.Reset();
                    BEntry.SetRange("G/L Account No.", Totaling);
                    BEntry.SetRange(Date, CalcDate('-1Y', SDate), CalcDate('-1Y', EDate));
                    if BEntry.FindFirst() then begin
                        BEntry.CalcSums(Amount);
                        LastYearBudgeted := BEntry.Amount;
                    end;

                end;


            end;

            trigger OnPreDataItem()
            begin
                if SDate = 0D then
                    SDate := DMY2Date(01, 01, 2001);

                if EDate = 0D then
                    EDate := Today;

                DFilter := Format(SKy.ddMMyyyy(SDate)) + '..' + Format(SKy.ddMMyyyy(EDate));
            end;

        }
    }


    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Date Filters';
                    field(SDate; SDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Start Date';
                    }
                    field(EDate; EDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'End Date';
                    }
                }
            }
        }

        actions
        {
        }
    }

    Var
        Actuals: Decimal;
        Budgeted: Decimal;
        Variance: Decimal;
        VarianceP: Decimal;
        LastYearActuals: Decimal;
        LastYearBudgeted: Decimal;
        SDate: Date;
        EDate: Date;
        DFilter: Text;
        GLBAlances: Record "GL Balances";
        SKy: Codeunit "Sky MBanking";

}
