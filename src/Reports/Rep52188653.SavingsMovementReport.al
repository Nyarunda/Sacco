report 50321 "Savings Movement Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/SavingsMovement.rdlc';
    Caption = 'Savings Movement Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Product Setup"; "Product Setup")
        {
            DataItemTableView = where("Product Class" = const(Savings));
            column(Product_ID; "Product ID")
            {
            }

            column(Description; Description)
            {
            }

            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ReportForNavId_5444; 5444)
                {
                }
                column(OpeningBalance; OpeningBalance)
                {
                }
                column(ClosingBalance; ClosingBalance)
                {
                }
                column(Debits; Debits)
                {
                }
                column(Credits; Credits)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // BlankLineNo := "G/L Account"."No. of Blank Lines" + 1;

                    AccNo := '';
                    VpostingGroup.Reset();
                    VpostingGroup.SetRange(Code, "Product Setup"."Product Posting Group");
                    if VpostingGroup.FindFirst() then
                        AccNo := VpostingGroup."Payables Account";
                    GLAccount.Reset;
                    GLAccount.SetRange("No.", AccNo);
                    GLAccount.SetFilter("Date Filter", '..%1', StartDate - 1);
                    if GLAccount.FindFirst then begin
                        GLAccount.CalcFields("Net Change");
                        OpeningBalance := GLAccount."Net Change" + FYCloseBalance;
                    end;

                    GLAccount.Reset;
                    GLAccount.SetRange("No.", AccNo);
                    GLAccount.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
                    if GLAccount.FindFirst then begin
                        GLAccount.CalcFields("Debit Amount", "Credit Amount", "Net Change");
                        Debits := GLAccount."Debit Amount";
                        Credits := GLAccount."Credit Amount";
                        NetChange := GLAccount."Net Change";
                    end;
                    GLAccount.Reset;
                    GLAccount.SetRange("No.", AccNo);
                    GLAccount.SetFilter("Date Filter", '..%1', EndDate);
                    if GLAccount.FindFirst then begin
                        GLAccount.CalcFields("Net Change");
                        ClosingBalance := GLAccount."Net Change";
                    end;
                end;

                trigger OnPreDataItem()
                var
                    Postingentry: record "G/L Entry";
                begin
                    if StartDate = 0D then
                        Error('Enter Start Date');
                    if EndDate = 0D then
                        Error('Enter End Date');
                    // DFilter := Format(StartDate) + '..' + Format(EndDate);
                    Postingentry.SetRange("Posting Date", StartDate, EndDate);

                    // SetRange(Postingentry, StartDate, EndDate);
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
                group(CutstomFilters)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                    }
                    field(datefilter; datefilter)
                    {
                        ApplicationArea = All;
                    }
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
        OpeningBalance: Decimal;
        ClosingBalance: Decimal;
        Debits: Decimal;
        Credits: Decimal;
        BlankLineNo: Integer;
        FYCloseBalance: Decimal;
        SDate: date;
        AccNo: code[20];
        NetChange: Decimal;

        EDate: date;
        TOpeningBalance: date;
        TClosingBalance: date;
        TDebits: date;
        TCredits: Date;
        TNetChange: date;
        VpostingGroup: Record "Vendor Posting Group";
        GLAccount: Record "G/L Account";
        StartDate: date;
        EndDate: date;
        DFilter: text;
        datefilter: date;
        PageGroupNo: Integer;
        ChangeGroupNo: Boolean;
        PeriodText: Text[30];
        Entries: Record "G/L Entry";



}
