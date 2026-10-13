report 50589 "Loan Performance Analysis New"
{
    Caption = 'LOAN PERFORMANCE ANALYSIS';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/LoanPerformanceAnalysis_.rdl';

    dataset
    {
        dataitem(HeaderLine; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(ReportTitle; ReportTitleTxt) { }
            column(StartDateFilter; StartDate) { }
            column(EndDateFilter; EndDate) { }
            column(ReportPeriodTxt; ReportPeriodTxt) { }
            column(CompanyPicture; CI.Picture) { }
        }

        dataitem(MatrixLoop; Integer)
        {
            DataItemTableView = sorting(Number);

            column(MatrixSectionNo; MatrixSectionNo) { }
            column(MatrixSectionCaption; MatrixSectionCaption) { }
            column(MatrixMonthNo; MatrixMonthNo) { }
            column(MatrixMonthCaption; MatrixMonthCaption) { }
            column(MatrixMonthSort; MatrixMonthSort) { }
            column(MatrixRowNo; MatrixRowNo) { }
            column(MatrixRowCaption; MatrixRowCaption) { }
            column(MatrixAmount; MatrixAmount) { }

            trigger OnPreDataItem()
            begin
                if NoOfMonths <= 0 then
                    CurrReport.Break();

                // 4 sections * 7 rows * NoOfMonths
                SetRange(Number, 1, 4 * 7 * NoOfMonths);
            end;

            trigger OnAfterGetRecord()
            begin
                DecodeMatrixNumber(Number);

                MatrixSectionCaption := GetSectionCaption(MatrixSectionNo);
                MatrixMonthCaption := MonthCaptions[MatrixMonthNo];
                MatrixMonthSort := MonthSorts[MatrixMonthNo];
                MatrixRowCaption := GetRowCaption(MatrixRowNo);
                MatrixAmount := MatrixValues[MatrixSectionNo, MatrixRowNo, MatrixMonthNo];
            end;
        }

        dataitem(SummaryLoop; Integer)
        {
            DataItemTableView = sorting(Number);

            column(SummaryRowNo; SummaryRowNo) { }
            column(SummaryRowCaption; SummaryRowCaption) { }
            column(SummaryMonthNo; SummaryMonthNo) { }
            column(SummaryMonthCaption; SummaryMonthCaption) { }
            column(SummaryMonthSort; SummaryMonthSort) { }
            column(SummaryAmount; SummaryAmount) { }

            trigger OnPreDataItem()
            begin
                if NoOfMonths <= 0 then
                    CurrReport.Break();

                // 6 summary rows * NoOfMonths
                SetRange(Number, 1, 6 * NoOfMonths);
            end;

            trigger OnAfterGetRecord()
            begin
                DecodeSummaryNumber(Number);

                SummaryRowCaption := GetSummaryRowCaption(SummaryRowNo);
                SummaryMonthCaption := MonthCaptions[SummaryMonthNo];
                SummaryMonthSort := MonthSorts[SummaryMonthNo];
                SummaryAmount := SummaryValues[SummaryRowNo, SummaryMonthNo];
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
                group(Filters)
                {
                    Caption = 'Period';

                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }

                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }

                    field(LoanOfficerFilter; LoanOfficerFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Loan Officer';
                        TableRelation = "User Setup"."User ID";
                    }

                    field(LoanProductTypeFilter; LoanProductTypeFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Loan Product Type';
                        TableRelation = "Product Setup"."Product ID";
                    }

                    field(MemberCategoryFilter; MemberCategoryFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Member Category';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        ValidateDates();

        CI.Get();
        CI.CalcFields(Picture);

        ReportPeriodTxt :=
            StrSubstNo(
                'LOAN PERFORMANCE ANALYSIS %1-%2',
                UpperCase(Format(StartDate, 0, '<Month Text,3> <Year4>')),
                UpperCase(Format(EndDate, 0, '<Month Text,3> <Year4>')));

        BuildMonths();
        CalculateAllMonths();
        BuildMatrixValues();
        BuildSummaryValues();
    end;

    var
        ReportTitleTxt: Label 'LOAN PERFORMANCE ANALYSIS';

        StartDate: Date;
        EndDate: Date;
        StartMonthDate: Date;
        NoOfMonths: Integer;
        ReportPeriodTxt: Text[100];

        LoanOfficerFilter: Code[80];
        LoanProductTypeFilter: Code[20];
        MemberCategoryFilter: Option " ",Member,"Staff Members","Board Members",Delegates,"Non-Member";
        CI: Record "Company Information";
        SASRAMgt: Codeunit "SASRA Categorization Mgt.";

        MonthEndDates: array[12] of Date;
        MonthCaptions: array[12] of Text[20];
        MonthSorts: array[12] of Integer;

        // Bucket 1 = Total OLB
        // Bucket 2 = 0
        // Bucket 3 = 1
        // Bucket 4 = 2 to 6
        // Bucket 5 = 7 to 12
        // Bucket 6 = Over 12
        // Bucket 7 = Total
        LoanBalance: array[7, 12] of Decimal;
        PrincipalInterestArrears: array[7, 12] of Decimal;
        LoanCount: array[7, 12] of Decimal;
        PARPercent: array[7, 12] of Decimal;

        // Section 1 = Loan Balance
        // Section 2 = Principal Arrears + Interest
        // Section 3 = No of Loans
        // Section 4 = PAR
        MatrixValues: array[4, 7, 12] of Decimal;

        // Summary row 1 = Growth of loan book
        // Summary row 2 = PAR
        // Summary row 3 = Monthly growth
        // Summary row 4 = Month
        // Summary row 5 = Total Loan book
        // Summary row 6 = Non Performing Loan
        SummaryValues: array[6, 12] of Decimal;

        MatrixSectionNo: Integer;
        MatrixMonthNo: Integer;
        MatrixRowNo: Integer;
        MatrixSectionCaption: Text[50];
        MatrixMonthCaption: Text[20];
        MatrixMonthSort: Integer;
        MatrixRowCaption: Text[30];
        MatrixAmount: Decimal;

        SummaryRowNo: Integer;
        SummaryMonthNo: Integer;
        SummaryRowCaption: Text[50];
        SummaryMonthCaption: Text[20];
        SummaryMonthSort: Integer;
        SummaryAmount: Decimal;

    local procedure ValidateDates()
    begin
        if StartDate = 0D then
            Error('Start Date is required.');

        if EndDate = 0D then
            Error('End Date is required.');

        if StartDate > EndDate then
            Error('Start Date cannot be greater than End Date.');

        StartMonthDate := DMY2Date(1, Date2DMY(StartDate, 2), Date2DMY(StartDate, 3));
        NoOfMonths := GetNoOfMonths(StartMonthDate, EndDate);

        if NoOfMonths <= 0 then
            Error('No valid months found between Start Date and End Date.');

        if NoOfMonths > 12 then
            Error('Maximum allowed period is 12 months.');
    end;

    local procedure GetNoOfMonths(FromDate: Date; ToDate: Date): Integer
    var
        WorkMonth: Date;
        CountMonths: Integer;
    begin
        WorkMonth := FromDate;

        while WorkMonth <= ToDate do begin
            CountMonths += 1;
            WorkMonth := CalcDate('<1M>', WorkMonth);
        end;

        exit(CountMonths);
    end;

    local procedure BuildMonths()
    var
        MonthNo: Integer;
        WorkMonth: Date;
    begin
        WorkMonth := StartMonthDate;

        for MonthNo := 1 to NoOfMonths do begin
            MonthEndDates[MonthNo] := CalcDate('<CM>', WorkMonth);

            if MonthEndDates[MonthNo] > EndDate then
                MonthEndDates[MonthNo] := EndDate;

            MonthCaptions[MonthNo] := Format(WorkMonth, 0, '<Month Text,3>-<Year4>');
            MonthSorts[MonthNo] := Date2DMY(WorkMonth, 3) * 100 + Date2DMY(WorkMonth, 2);

            WorkMonth := CalcDate('<1M>', WorkMonth);
        end;
    end;

    local procedure CalculateAllMonths()
    var
        MonthNo: Integer;
    begin
        for MonthNo := 1 to NoOfMonths do
            CalculateMonth(MonthNo, MonthEndDates[MonthNo]);
    end;

    local procedure CalculateMonth(MonthNo: Integer; AsAtDate: Date)
    var
        Loan: Record Loans;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        MonthsInArrears: Integer;
        InterestArrears: Decimal;
        LoanCategory: Option Performing,Watch,Substandard,Doubtful,Loss;
        BucketNo: Integer;
        Balance: Decimal;
        Arrears: Decimal;
    begin
        ClearMonth(MonthNo);

        Loan.Reset();
        Loan.SetRange(Posted, true);
        Loan.SetFilter("Disbursement Date", '..%1', AsAtDate);
        Loan.SetRange("Date Filter", 0D, AsAtDate);
        Loan.SetFilter("Outstanding Principal", '>0');

        if LoanOfficerFilter <> '' then
            Loan.SetRange("Loan Officer", LoanOfficerFilter);

        if LoanProductTypeFilter <> '' then
            Loan.SetRange("Loan Product Type", LoanProductTypeFilter);

        if MemberCategoryFilter <> MemberCategoryFilter::" " then
            Loan.SetRange("Member Category", MemberCategoryFilter);

        if Loan.FindSet(false) then
            repeat
                Loan.SetRange("Date Filter", 0D, AsAtDate);
                Loan.CalcFields(
                    "Outstanding Principal",
                    "Outstanding Interest",
                    "Outstanding Penalty",
                    "Outstanding Insurance",
                    "Total Outstanding Balance",
                    "Principal Arrears",
                    "Interest Arrears",
                    "Principal Paid",
                    "Interest Paid");

                Balance := Loan."Outstanding Principal" + Loan."Outstanding Interest";

                if Loan."Outstanding Principal" > 0 then begin
                    Clear(DefAmount);
                    Clear(DaysInArrear);
                    Clear(MonthsInArrears);
                    Clear(InterestArrears);
                    Clear(LoanCategory);

                    SASRAMgt.CategorizeLoanAsAt(
                        Loan,
                        AsAtDate,
                        DefAmount,
                        DaysInArrear,
                        MonthsInArrears,
                        InterestArrears,
                        LoanCategory);

                    Arrears := Loan."Principal Arrears" + Loan."Interest Arrears";
                    BucketNo := GetBucketNo(MonthsInArrears);

                    AddToBucket(MonthNo, 1, Balance, Arrears); // Total OLB
                    AddToBucket(MonthNo, BucketNo, Balance, Arrears);
                    AddToBucket(MonthNo, 7, Balance, Arrears); // Total
                end;
            until Loan.Next() = 0;

        CalculatePARForMonth(MonthNo);
    end;

    local procedure ClearMonth(MonthNo: Integer)
    var
        RowNo: Integer;
    begin
        for RowNo := 1 to 7 do begin
            LoanBalance[RowNo, MonthNo] := 0;
            PrincipalInterestArrears[RowNo, MonthNo] := 0;
            LoanCount[RowNo, MonthNo] := 0;
            PARPercent[RowNo, MonthNo] := 0;
        end;
    end;

    local procedure AddToBucket(MonthNo: Integer; BucketNo: Integer; Balance: Decimal; Arrears: Decimal)
    begin
        LoanBalance[BucketNo, MonthNo] += Balance;
        PrincipalInterestArrears[BucketNo, MonthNo] += Arrears;
        LoanCount[BucketNo, MonthNo] += 1;
    end;

    local procedure CalculatePARForMonth(MonthNo: Integer)
    var
        RowNo: Integer;
        TotalBalance: Decimal;
        NonPerformingBalance: Decimal;
    begin
        TotalBalance := LoanBalance[1, MonthNo];

        for RowNo := 1 to 7 do begin
            if TotalBalance <> 0 then
                PARPercent[RowNo, MonthNo] :=
                    Round((LoanBalance[RowNo, MonthNo] / TotalBalance) * 100, 0.01, '=')
            else
                PARPercent[RowNo, MonthNo] := 0;
        end;

        NonPerformingBalance :=
            LoanBalance[4, MonthNo] +
            LoanBalance[5, MonthNo] +
            LoanBalance[6, MonthNo];

        if TotalBalance <> 0 then
            PARPercent[1, MonthNo] := Round((NonPerformingBalance / TotalBalance) * 100, 0.01, '=')
        else
            PARPercent[1, MonthNo] := 0;

        if TotalBalance <> 0 then
            PARPercent[7, MonthNo] := 100
        else
            PARPercent[7, MonthNo] := 0;
    end;

    local procedure BuildMatrixValues()
    var
        MonthNo: Integer;
        RowNo: Integer;
    begin
        for MonthNo := 1 to NoOfMonths do
            for RowNo := 1 to 7 do begin
                MatrixValues[1, RowNo, MonthNo] := LoanBalance[RowNo, MonthNo];
                MatrixValues[2, RowNo, MonthNo] := PrincipalInterestArrears[RowNo, MonthNo];
                MatrixValues[3, RowNo, MonthNo] := LoanCount[RowNo, MonthNo];
                MatrixValues[4, RowNo, MonthNo] := PARPercent[RowNo, MonthNo];
            end;
    end;

    local procedure BuildSummaryValues()
    var
        MonthNo: Integer;
        CurrentLoanBook: Decimal;
        PreviousLoanBook: Decimal;
        CurrentNPL: Decimal;
        PreviousNPL: Decimal;
    begin
        for MonthNo := 1 to NoOfMonths do begin
            CurrentLoanBook := LoanBalance[1, MonthNo];
            CurrentNPL :=
                LoanBalance[4, MonthNo] +
                LoanBalance[5, MonthNo] +
                LoanBalance[6, MonthNo];

            if MonthNo > 1 then begin
                PreviousLoanBook := LoanBalance[1, MonthNo - 1];
                PreviousNPL :=
                    LoanBalance[4, MonthNo - 1] +
                    LoanBalance[5, MonthNo - 1] +
                    LoanBalance[6, MonthNo - 1];

                // Formula requested:
                // (Current Month Balance - Previous Month Balance) / Current Month Balance * 100
                if CurrentLoanBook <> 0 then
                    SummaryValues[1, MonthNo] := Round(((CurrentLoanBook - PreviousLoanBook) / CurrentLoanBook) * 100, 0.01, '=');

                if CurrentNPL <> 0 then
                    SummaryValues[3, MonthNo] := Round(((CurrentNPL - PreviousNPL) / CurrentNPL) * 100, 0.01, '=');
            end;

            SummaryValues[2, MonthNo] := CurrentNPL;
            SummaryValues[4, MonthNo] := 0;
            SummaryValues[5, MonthNo] := CurrentLoanBook;
            SummaryValues[6, MonthNo] := CurrentNPL;
        end;
    end;

    local procedure DecodeMatrixNumber(NumberValue: Integer)
    var
        ZeroBasedNo: Integer;
    begin
        ZeroBasedNo := NumberValue - 1;

        MatrixSectionNo := (ZeroBasedNo div (7 * NoOfMonths)) + 1;
        MatrixRowNo := ((ZeroBasedNo mod (7 * NoOfMonths)) div NoOfMonths) + 1;
        MatrixMonthNo := (ZeroBasedNo mod NoOfMonths) + 1;
    end;

    local procedure DecodeSummaryNumber(NumberValue: Integer)
    var
        ZeroBasedNo: Integer;
    begin
        ZeroBasedNo := NumberValue - 1;

        SummaryRowNo := (ZeroBasedNo div NoOfMonths) + 1;
        SummaryMonthNo := (ZeroBasedNo mod NoOfMonths) + 1;
    end;

    local procedure GetSectionCaption(SectionNo: Integer): Text[50]
    begin
        case SectionNo of
            1:
                exit('LOAN BALANCE');
            2:
                exit('PRINCIPAL ARREARS+INTEREST');
            3:
                exit('No of Loans');
            4:
                exit('PAR');
        end;

        exit('');
    end;

    local procedure GetRowCaption(RowNo: Integer): Text[30]
    begin
        case RowNo of
            1:
                exit('Total OLB');
            2:
                exit('0');
            3:
                exit('1');
            4:
                exit('2 to 6');
            5:
                exit('7 to 12');
            6:
                exit('Over 12');
            7:
                exit('Total');
        end;

        exit('');
    end;

    local procedure GetSummaryRowCaption(RowNo: Integer): Text[50]
    begin
        case RowNo of
            1:
                exit('Growth of loan book');
            2:
                exit('PAR');
            3:
                exit('Monthly growth');
            4:
                exit('Month');
            5:
                exit('Total Loan book');
            6:
                exit('Non Performing Loan');
        end;

        exit('');
    end;

    local procedure GetBucketNo(MonthsInArrears: Integer): Integer
    begin
        case true of
            MonthsInArrears = 0:
                exit(2);
            MonthsInArrears = 1:
                exit(3);
            (MonthsInArrears >= 2) and (MonthsInArrears <= 6):
                exit(4);
            (MonthsInArrears >= 7) and (MonthsInArrears <= 12):
                exit(5);
            MonthsInArrears > 12:
                exit(6);
        end;

        exit(2);
    end;
}
