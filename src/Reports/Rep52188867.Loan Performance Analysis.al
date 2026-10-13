report 50575 "Loan Performance Analysis"
{
    Caption = 'Loan Performance Analysis';
    ProcessingOnly = false;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field(StartMonth; StartMonth)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Month';
                    }

                    field(EndMonth; EndMonth)
                    {
                        ApplicationArea = All;
                        Caption = 'End Month';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if StartMonth = 0D then
            Error('Start Month must be specified.');

        if EndMonth = 0D then
            Error('End Month must be specified.');

        StartMonth := DMY2Date(1, Date2DMY(StartMonth, 2), Date2DMY(StartMonth, 3));
        EndMonth := CalcDate('<CM>', EndMonth);

        if StartMonth > EndMonth then
            Error('Start Month cannot be greater than End Month.');

        BuildMonths();
        GenerateExcel();
    end;

    var
        StartMonth: Date;
        EndMonth: Date;
        TempExcelBuffer: Record "Excel Buffer" temporary;

        MonthEndDates: array[12] of Date;
        MonthCaptions: array[12] of Text[20];
        MonthCount: Integer;

        LoanBalance: array[5, 12] of Decimal;
        ArrearsAmount: array[5, 12] of Decimal;
        LoanCountArr: array[5, 12] of Integer;
        PARBucketPercent: array[5, 12] of Decimal;

        TotalLoanBalance: array[12] of Decimal;
        TotalArrears: array[12] of Decimal;
        TotalLoanCount: array[12] of Integer;
        PARPercent: array[12] of Decimal;
        LoanBookGrowth: array[12] of Decimal;
        PARGrowth: array[12] of Decimal;

        ProgressWindow: Dialog;
        TotalLoans: Integer;
        ProcessedLoans: Integer;

    local procedure BuildMonths()
    var
        WorkMonth: Date;
    begin
        MonthCount := 0;
        WorkMonth := StartMonth;

        while WorkMonth <= EndMonth do begin
            MonthCount += 1;

            if MonthCount > 12 then
                Error('This report supports a maximum of 12 months at a time.');

            MonthEndDates[MonthCount] := CalcDate('<CM>', WorkMonth);
            MonthCaptions[MonthCount] := Format(WorkMonth, 0, '<Month Text,3>-<Year,2>');

            WorkMonth := CalcDate('1M', WorkMonth);
        end;
    end;

    local procedure GenerateExcel()
    begin
        ClearArrays();
        CalculateData();

        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.CreateNewBook('Loan Performance');

        WriteExcelLikeTemplate();

        TempExcelBuffer.WriteSheet('Loan Performance', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.OpenExcel();
    end;

    local procedure ClearArrays()
    var
        BucketNo: Integer;
        MonthIndex: Integer;
    begin
        for BucketNo := 1 to 5 do
            for MonthIndex := 1 to 12 do begin
                LoanBalance[BucketNo, MonthIndex] := 0;
                ArrearsAmount[BucketNo, MonthIndex] := 0;
                LoanCountArr[BucketNo, MonthIndex] := 0;
                PARBucketPercent[BucketNo, MonthIndex] := 0;
            end;

        for MonthIndex := 1 to 12 do begin
            TotalLoanBalance[MonthIndex] := 0;
            TotalArrears[MonthIndex] := 0;
            TotalLoanCount[MonthIndex] := 0;
            PARPercent[MonthIndex] := 0;
            LoanBookGrowth[MonthIndex] := 0;
            PARGrowth[MonthIndex] := 0;
        end;
    end;

    local procedure CalculateData()
    var
        MonthIndex: Integer;
    begin
        CalculateAllMonths();

        for MonthIndex := 1 to MonthCount do
            CalculateMonthTotals(MonthIndex);

        CalculateGrowth();
    end;

    local procedure CalculateAllMonths()
    var
        Loan: Record Loans;
        MonthIndex: Integer;
        BucketNo: Integer;
        BalanceAmt: Decimal;
        ArrearsAmt: Decimal;
        MonthsInArrears: Integer;
    begin
        Loan.Reset();
        Loan.SetCurrentKey(Posted, "Disbursement Date");
        Loan.SetRange(Posted, true);
        Loan.SetFilter("Disbursement Date", '..%1', MonthEndDates[MonthCount]);
        Loan.SetFilter("Total Outstanding Balance", '>0');

        Loan.SetLoadFields(
            "Loan No.",
            Posted,
            "Disbursement Date"
        );

        TotalLoans := Loan.Count();
        ProcessedLoans := 0;

        ProgressWindow.Open(
            'Processing Loan Performance Analysis...\' +
            'Processed Loans: #1########\' +
            'Total Loans:     #2########'
        );

        if Loan.FindSet() then
            repeat
                ProcessedLoans += 1;

                if (ProcessedLoans mod 100) = 0 then begin
                    ProgressWindow.Update(1, ProcessedLoans);
                    ProgressWindow.Update(2, TotalLoans);
                end;

                for MonthIndex := 1 to MonthCount do begin
                    if Loan."Disbursement Date" <= MonthEndDates[MonthIndex] then begin
                        Loan.SetRange("Date Filter", 0D, MonthEndDates[MonthIndex]);

                        Loan.CalcFields(
                            "Outstanding Principal",
                            "Outstanding Interest",
                            "Principal Arrears",
                            "Interest Arrears",
                            "SASRA Months Arrears"
                        );

                        BalanceAmt := Loan."Outstanding Principal" + Loan."Outstanding Interest";

                        if BalanceAmt > 0 then begin
                            MonthsInArrears := Loan."SASRA Months Arrears";
                            BucketNo := GetBucketNo(MonthsInArrears);

                            ArrearsAmt := Loan."Principal Arrears" + Loan."Interest Arrears";

                            LoanBalance[BucketNo, MonthIndex] += BalanceAmt;
                            ArrearsAmount[BucketNo, MonthIndex] += ArrearsAmt;
                            LoanCountArr[BucketNo, MonthIndex] += 1;
                        end;
                    end;
                end;
            until Loan.Next() = 0;

        ProgressWindow.Update(1, ProcessedLoans);
        ProgressWindow.Update(2, TotalLoans);
        ProgressWindow.Close();
    end;

    local procedure CalculateMonthTotals(MonthIndex: Integer)
    var
        BucketNo: Integer;
        NonPerformingAmount: Decimal;
    begin
        for BucketNo := 1 to 5 do begin
            TotalLoanBalance[MonthIndex] += LoanBalance[BucketNo, MonthIndex];
            TotalArrears[MonthIndex] += ArrearsAmount[BucketNo, MonthIndex];
            TotalLoanCount[MonthIndex] += LoanCountArr[BucketNo, MonthIndex];
        end;

        for BucketNo := 1 to 5 do
            if TotalLoanBalance[MonthIndex] <> 0 then
                PARBucketPercent[BucketNo, MonthIndex] :=
                    Round((LoanBalance[BucketNo, MonthIndex] / TotalLoanBalance[MonthIndex]) * 100, 0.01, '=');

        NonPerformingAmount :=
            LoanBalance[3, MonthIndex] +
            LoanBalance[4, MonthIndex] +
            LoanBalance[5, MonthIndex];

        if TotalLoanBalance[MonthIndex] <> 0 then
            PARPercent[MonthIndex] := Round((NonPerformingAmount / TotalLoanBalance[MonthIndex]) * 100, 0.01, '=');
    end;

    local procedure CalculateGrowth()
    var
        MonthIndex: Integer;
    begin
        for MonthIndex := 2 to MonthCount do begin
            if TotalLoanBalance[MonthIndex - 1] <> 0 then
                LoanBookGrowth[MonthIndex] :=
                    Round(((TotalLoanBalance[MonthIndex] - TotalLoanBalance[MonthIndex - 1]) / TotalLoanBalance[MonthIndex - 1]) * 100, 0.01, '=');

            if PARPercent[MonthIndex - 1] <> 0 then
                PARGrowth[MonthIndex] :=
                    Round(((PARPercent[MonthIndex] - PARPercent[MonthIndex - 1]) / PARPercent[MonthIndex - 1]) * 100, 0.01, '=');
        end;
    end;

    local procedure WriteExcelLikeTemplate()
    var
        BucketNo: Integer;
        MonthIndex: Integer;
    begin
        TempExcelBuffer.NewRow();
        AddTextCell(
            'LOAN PERFORMANCE ANALYSIS ' +
            UpperCase(Format(StartMonth, 0, '<Month Text,3>')) + ' ' +
            Format(Date2DMY(StartMonth, 3)) + '-' +
            UpperCase(Format(EndMonth, 0, '<Month Text,3>')) + ' ' +
            Format(Date2DMY(EndMonth, 3)),
            true);

        TempExcelBuffer.NewRow();
        TempExcelBuffer.NewRow();

        AddTextCell('Months In Arrears', true);

        AddTextCell('LOAN BALANCE', true);
        for MonthIndex := 2 to MonthCount do
            AddTextCell('', true);

        AddTextCell('', false);

        AddTextCell('PRINCIPAL ARREARS+INTEREST', true);
        for MonthIndex := 2 to MonthCount do
            AddTextCell('', true);

        AddTextCell('', false);

        AddTextCell('NO. OF LOANS', true);
        for MonthIndex := 2 to MonthCount do
            AddTextCell('', true);

        AddTextCell('', false);

        AddTextCell('PAR', true);
        for MonthIndex := 2 to MonthCount do
            AddTextCell('', true);

        TempExcelBuffer.NewRow();
        AddTextCell('', false);

        for MonthIndex := 1 to MonthCount do
            AddTextCell(MonthCaptions[MonthIndex], true);

        AddTextCell('', false);

        for MonthIndex := 1 to MonthCount do
            AddTextCell(MonthCaptions[MonthIndex], true);

        AddTextCell('', false);

        for MonthIndex := 1 to MonthCount do
            AddTextCell(MonthCaptions[MonthIndex], true);

        AddTextCell('', false);

        for MonthIndex := 1 to MonthCount do
            AddTextCell(MonthCaptions[MonthIndex], true);

        for BucketNo := 1 to 5 do begin
            TempExcelBuffer.NewRow();

            AddTextCell(GetBucketCaption(BucketNo), true);

            for MonthIndex := 1 to MonthCount do
                AddDecimalCell(LoanBalance[BucketNo, MonthIndex], false);

            AddTextCell('', false);

            for MonthIndex := 1 to MonthCount do
                AddDecimalCell(ArrearsAmount[BucketNo, MonthIndex], false);

            AddTextCell('', false);

            for MonthIndex := 1 to MonthCount do
                AddIntegerCell(LoanCountArr[BucketNo, MonthIndex], false);

            AddTextCell('', false);

            for MonthIndex := 1 to MonthCount do
                AddDecimalCell(PARBucketPercent[BucketNo, MonthIndex], false);
        end;

        TempExcelBuffer.NewRow();
        AddTextCell('Total', true);

        for MonthIndex := 1 to MonthCount do
            AddDecimalCell(TotalLoanBalance[MonthIndex], true);

        AddTextCell('', false);

        for MonthIndex := 1 to MonthCount do
            AddDecimalCell(TotalArrears[MonthIndex], true);

        AddTextCell('', false);

        for MonthIndex := 1 to MonthCount do
            AddIntegerCell(TotalLoanCount[MonthIndex], true);

        AddTextCell('', false);

        for MonthIndex := 1 to MonthCount do
            AddDecimalCell(100, true);

        TempExcelBuffer.NewRow();
        AddTextCell('Growth of loan book', true);

        for MonthIndex := 1 to MonthCount do
            AddDecimalCell(LoanBookGrowth[MonthIndex], false);

        AddTextCell('', false);

        for MonthIndex := 1 to MonthCount do
            AddTextCell('', false);

        AddTextCell('', false);

        for MonthIndex := 1 to MonthCount do
            AddTextCell('', false);

        AddTextCell('', false);

        for MonthIndex := 1 to MonthCount do
            AddTextCell('', false);

        TempExcelBuffer.NewRow();
        TempExcelBuffer.NewRow();

        AddTextCell('PAR', true);

        for MonthIndex := 1 to MonthCount do
            AddDecimalCell(
                LoanBalance[3, MonthIndex] +
                LoanBalance[4, MonthIndex] +
                LoanBalance[5, MonthIndex],
                true);

        AddTextCell('', false);

        for MonthIndex := 1 to MonthCount do
            AddDecimalCell(
                ArrearsAmount[3, MonthIndex] +
                ArrearsAmount[4, MonthIndex] +
                ArrearsAmount[5, MonthIndex],
                true);

        AddTextCell('', false);

        for MonthIndex := 1 to MonthCount do
            AddIntegerCell(
                LoanCountArr[3, MonthIndex] +
                LoanCountArr[4, MonthIndex] +
                LoanCountArr[5, MonthIndex],
                true);

        AddTextCell('', false);

        for MonthIndex := 1 to MonthCount do
            AddDecimalCell(PARPercent[MonthIndex], true);

        TempExcelBuffer.NewRow();
        AddTextCell('Monthly growth', true);

        for MonthIndex := 1 to MonthCount do
            AddDecimalCell(PARGrowth[MonthIndex], false);
    end;

    local procedure GetBucketNo(MonthsInArrears: Integer): Integer
    begin
        if MonthsInArrears <= 0 then
            exit(1);

        if MonthsInArrears = 1 then
            exit(2);

        if MonthsInArrears <= 6 then
            exit(3);

        if MonthsInArrears <= 12 then
            exit(4);

        exit(5);
    end;

    local procedure GetBucketCaption(BucketNo: Integer): Text[30]
    begin
        case BucketNo of
            1:
                exit('0');
            2:
                exit('1');
            3:
                exit('2 to 6');
            4:
                exit('7 to 12');
            5:
                exit('Over 12');
        end;

        exit('');
    end;

    local procedure AddTextCell(Value: Text; Bold: Boolean)
    begin
        TempExcelBuffer.AddColumn(Value, false, '', Bold, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure AddDecimalCell(Value: Decimal; Bold: Boolean)
    begin
        TempExcelBuffer.AddColumn(Value, false, '', Bold, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
    end;

    local procedure AddIntegerCell(Value: Integer; Bold: Boolean)
    begin
        TempExcelBuffer.AddColumn(Value, false, '', Bold, false, false, '#,##0', TempExcelBuffer."Cell Type"::Number);
    end;
}
