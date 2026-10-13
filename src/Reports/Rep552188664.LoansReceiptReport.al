report 50327 LoansReceiptReport
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/LoansReceipt.rdlc';
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

                    FYCloseBalance := 0;
                    if SDate = CalcDate('-CY', SDate) then begin
                        GLAccount.Reset;
                        GLAccount.SetRange("No.", AccNo);
                        GLAccount.SetFilter("Date Filter", '%1..%2', EndDate);
                        //GLAccount.SetFilter("Date Filter", '%1', ClosingDate(SDate - 1));
                        if GLAccount.FindFirst then begin
                            GLAccount.CalcFields("Net Change");
                            FYCloseBalance := GLAccount."Net Change";
                        end;
                    end;
                    GLAccount.Reset;
                    GLAccount.SetRange("No.", AccNo);
                    GLAccount.SetFilter("Date Filter", '..%1', SDate - 1);
                    if GLAccount.FindFirst then begin
                        GLAccount.CalcFields("Net Change");
                        OpeningBalance := GLAccount."Net Change" + FYCloseBalance;
                    end;
                    GLAccount.Reset;
                    GLAccount.SetRange("No.", AccNo);
                    GLAccount.SetFilter("Date Filter", '%1..%2', SDate, EDate);
                    if GLAccount.FindFirst then begin
                        GLAccount.CalcFields("Debit Amount", "Credit Amount", "Net Change");
                        Debits := GLAccount."Debit Amount";
                        Credits := GLAccount."Credit Amount";
                        NetChange := GLAccount."Net Change";
                    end;
                    GLAccount.Reset;
                    GLAccount.SetRange("No.", AccNo);
                    GLAccount.SetFilter("Date Filter", '..%1', EDate);
                    if GLAccount.FindFirst then begin
                        GLAccount.CalcFields("Net Change");
                        ClosingBalance := GLAccount."Net Change";
                    end;
                    if GLAccount."Account Type" = GLAccount."account type"::Posting then begin
                        TOpeningBalance += OpeningBalance;
                        TClosingBalance += ClosingBalance;
                        TDebits += Debits;
                        TCredits += Credits;
                        TNetChange += NetChange;
                    end;
                end;
                /*
                                trigger OnPreDataItem()
                                begin
                                    if StartDate = 0D then
                                        Error('Enter Start Date');
                                    if EndDate = 0D then
                                        Error('Enter End Date');
                                    DFilter := Format(StartDate) + '..' + Format(EndDate);
                                    SetRange(StartDate, EndDate);
                                end;*/

                trigger OnPreDataItem()
                begin
                    PageGroupNo := 0;
                    ChangeGroupNo := false;


                    DFilter := GLAccount.GetFilter("Date Filter")
                    ;

                    SDate := 20010101D;
                    EDate := Today;
                    if DFilter <> '' then begin
                        if CopyStr(DFilter, 1, 2) = '..' then
                            EDate := GLAccount.GetRangemax("Date Filter")
                        else begin
                            SDate := GLAccount.GetRangeMin("Date Filter");
                            EDate := GLAccount.GetRangemax("Date Filter");
                        end;
                    end;
                    if PeriodText = '' then begin
                        PeriodText := Format(SDate) + '..' + Format(EDate);
                        if SDate = 20010101D then
                            PeriodText := '..' + Format(EDate);
                    end;
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
        PageGroupNo: Integer;
        ChangeGroupNo: Boolean;
        PeriodText: Text[30];









}
