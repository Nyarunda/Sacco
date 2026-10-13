namespace UnitedWomen.UnitedWomen;

using System.Security.User;
using Microsoft.Foundation.Company;
using System.Utilities;

report 50573 "Arrears Movement per RO"
{
    Caption = 'Arrears Movement per RO';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/ArrearsMovementPerRO_.rdl';

    dataset
    {
        dataitem(HeaderLine; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(CompanyName; CompanyInformation.Name) { }
            column(CompanyLogo; CompanyInformation.Picture) { }
            column(LoanOfficerCaption; LoanOfficer) { }
            column(StartWeekEndingCaption; FormatDate(StartWeekEndingDate)) { }
            column(NoOfWeeksCaption; NoOfWeeks) { }
            column(VisibleWeekCountCaption; VisibleWeekCount) { }
            column(ReportTitle; ReportTitleTxt) { }
            column(ReportSubTitle; ReportSubTitleTxt) { }
        }

        dataitem(WeeklyCategoryLoop; Integer)
        {
            DataItemTableView = sorting(Number);

            column(WeekIndex; CurrentWeekIndex) { }
            column(VisibleWeekIndex; CurrentVisibleWeekIndex) { }
            column(WeekEndingDate; CurrentWeekEndingDate) { }
            column(WeekEndingCaption; CurrentWeekEndingCaption) { }

            column(CategoryNo; CurrentCategoryNo) { }
            column(Category; CurrentCategoryName) { }
            column(IsTotalLine; IsTotalLine) { }

            column(LoanBalance; CurrentLoanBalance) { }
            column(LoanCount; CurrentLoanCount) { }
            column(Collections; CurrentCollections) { }
            column(Arrears; CurrentArrears) { }
            column(PARPercent; CurrentPAR) { }

            trigger OnPreDataItem()
            begin
                if VisibleWeekCount <= 0 then
                    CurrReport.Break();

                // 6 rows per visible week:
                // 1 Performing
                // 2 Watch
                // 3 Substandard
                // 4 Doubtful
                // 5 Loss
                // 6 Total
                SetRange(Number, 1, VisibleWeekCount * 6);
            end;

            trigger OnAfterGetRecord()
            begin
                DecodeVisibleWeeklyNumber(Number);

                if CurrentWeekIndex = 0 then
                    CurrReport.Skip();

                if WeekCategoryLoanBalance[CurrentWeekIndex, 6] = 0 then
                    CurrReport.Skip();

                CurrentWeekEndingDate := WeekEndDates[CurrentWeekIndex];
                CurrentWeekEndingCaption := StrSubstNo('Week ending %1', FormatDate(CurrentWeekEndingDate));
                CurrentCategoryName := GetCategoryName(CurrentCategoryNo);
                IsTotalLine := CurrentCategoryNo = 6;

                CurrentLoanBalance := WeekCategoryLoanBalance[CurrentWeekIndex, CurrentCategoryNo];
                CurrentLoanCount := WeekCategoryLoanCount[CurrentWeekIndex, CurrentCategoryNo];
                CurrentCollections := WeekCategoryCollections[CurrentWeekIndex, CurrentCategoryNo];
                CurrentArrears := WeekCategoryArrears[CurrentWeekIndex, CurrentCategoryNo];

                if IsTotalLine then begin
                    if CurrentLoanBalance <> 0 then
                        CurrentPAR := 100
                    else
                        CurrentPAR := 0;
                end else begin
                    if WeekCategoryLoanBalance[CurrentWeekIndex, 6] <> 0 then
                        CurrentPAR :=
                            Round(
                                (CurrentLoanBalance / WeekCategoryLoanBalance[CurrentWeekIndex, 6]) * 100,
                                0.01,
                                '=')
                    else
                        CurrentPAR := 0;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field(LoanOfficer; LoanOfficer)
                    {
                        ApplicationArea = All;
                        Caption = 'Loan Officer';
                        TableRelation = "User Setup"."User ID";
                    }

                    field(StartWeekEndingDate; StartWeekEndingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Week Ending Date';
                    }

                    field(NoOfWeeks; NoOfWeeks)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Weeks';
                    }

                }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);

        if StartWeekEndingDate = 0D then
            Error('Please specify Start Week Ending Date.');

        if NoOfWeeks <= 0 then
            Error('No. of Weeks must be greater than zero.');

        if NoOfWeeks > 52 then
            Error('No. of Weeks cannot be more than 52.');

        if LoanOfficer = '' then
            Error('Loan Officer is required');

        StartWeekEndingDate := GetWeekEndingDate(StartWeekEndingDate);

        ReportTitleTxt := 'Arrears Movement Report';
        ReportSubTitleTxt := 'Weekly Movement';

        BuildWeekDates();

        ProgressWindow.Open(
            'Arrears Movement Processing...\' +
            'Stage: #1###############################\' +
            'Week: #2###############################\' +
            'Record: #3######## of #4########\' +
            'Progress: @5@@@@@@@@@@@@@@@@@@@@');

        TotalProgressSteps := NoOfWeeks * 3;
        CurrentProgressStep := 0;

        PrepareSnapshotsForWeeks();
        CalculateWeeklyArrays();
        BuildVisibleWeeks();

        if VisibleWeekCount = 0 then
            Error('No arrears movement data was found for the selected week range.');

            ProgressWindow.Close();
    end;

    var
        CompanyInformation: Record "Company Information";
        LoanOfficer: Code[50];
        StartWeekEndingDate: Date;
        NoOfWeeks: Integer;
        RegenerateSnapshots: Boolean;
        ReportTitleTxt: Text[100];
        ReportSubTitleTxt: Text[100];

        WeekEndDates: array[52] of Date;
        VisibleWeekMap: array[52] of Integer;
        VisibleWeekCount: Integer;

        // Dimension 1 = Week Index, Dimension 2 = Category No.
        // 1 Performing
        // 2 Watch
        // 3 Substandard
        // 4 Doubtful
        // 5 Loss
        // 6 Total
        WeekCategoryLoanBalance: array[52, 6] of Decimal;
        WeekCategoryLoanCount: array[52, 6] of Integer;
        WeekCategoryCollections: array[52, 6] of Decimal;
        WeekCategoryArrears: array[52, 6] of Decimal;

        CurrentWeekIndex: Integer;
        CurrentVisibleWeekIndex: Integer;
        CurrentWeekEndingDate: Date;
        CurrentWeekEndingCaption: Text[50];

        CurrentCategoryNo: Integer;
        CurrentCategoryName: Text[30];
        IsTotalLine: Boolean;

        CurrentLoanBalance: Decimal;
        CurrentLoanCount: Integer;
        CurrentCollections: Decimal;
        CurrentArrears: Decimal;
        CurrentPAR: Decimal;

        ProgressWindow: Dialog;
        TotalProgressSteps: Integer;
        CurrentProgressStep: Integer;
        ProgressPercent: Integer;

    local procedure BuildWeekDates()
    var
        WeekIndex: Integer;
    begin
        for WeekIndex := 1 to 52 do begin
            WeekEndDates[WeekIndex] := 0D;
            VisibleWeekMap[WeekIndex] := 0;
        end;

        for WeekIndex := 1 to NoOfWeeks do
            WeekEndDates[WeekIndex] := GetMonthAwareWeekEndingDate(StartWeekEndingDate + ((WeekIndex - 1) * 7));
    end;

    local procedure GetWeekEndingDate(WeekDate: Date): Date
    begin
        if WeekDate = 0D then
            exit(0D);

        exit(CalcDate('<CW>', WeekDate));
    end;

    local procedure GetMonthAwareWeekEndingDate(WeekEndingDate: Date): Date
    var
        MonthEndDate: Date;
    begin
        if WeekEndingDate = 0D then
            exit(0D);

        MonthEndDate := CalcDate('<CM>', WeekEndingDate);
        if WeekEndingDate + 7 > MonthEndDate then
            exit(MonthEndDate);

        exit(WeekEndingDate);
    end;

    local procedure PrepareSnapshotsForWeeks()
    var
        WeekIndex: Integer;
        SASRASnapshotMgt: Codeunit "SASRA Categorization Mgt.";
    begin
        for WeekIndex := 1 to NoOfWeeks do begin
            CurrentProgressStep += 1;

            UpdateProgressWindow(
                'Preparing SASRA snapshot',
                FormatDate(WeekEndDates[WeekIndex]),
                WeekIndex,
                NoOfWeeks);

            //if RegenerateSnapshots or not SnapshotExists(WeekEndDates[WeekIndex]) then
            SASRASnapshotMgt.GenerateSnapshot(WeekEndDates[WeekIndex], LoanOfficer, false);
        end;
    end;

    local procedure SnapshotExists(AsAtDate: Date): Boolean
    var
        Snapshot: Record "SASRA Category Snapshot";
    begin
        Snapshot.Reset();
        Snapshot.SetLoadFields("As At", "Loan Officer");

        if LoanOfficer <> '' then
            Snapshot.SetCurrentKey("Loan Officer", "As At", "Loan Category");

        Snapshot.SetRange("As At", AsAtDate);

        if LoanOfficer <> '' then
            Snapshot.SetRange("Loan Officer", LoanOfficer);

        exit(not Snapshot.IsEmpty());
    end;

    local procedure CalculateWeeklyArrays()
    var
        WeekIndex: Integer;
    begin
        for WeekIndex := 1 to NoOfWeeks do begin
            CurrentProgressStep += 1;

            UpdateProgressWindow(
                'Calculating weekly totals',
                FormatDate(WeekEndDates[WeekIndex]),
                WeekIndex,
                NoOfWeeks);

            CalculateWeekInOnePass(WeekIndex, WeekEndDates[WeekIndex]);
        end;
    end;

    local procedure CalculateWeekInOnePass(WeekIndex: Integer; AsAtDate: Date)
    var
        Snapshot: Record "SASRA Category Snapshot";
        CategoryNo: Integer;
    begin
        ClearWeekArrays(WeekIndex);

        Snapshot.Reset();

        Snapshot.SetLoadFields(
            "As At",
            "Loan Officer",
            "Loan Category",
            "Outstanding Principal",
            "Outstanding Interest",
            "Principal Paid",
            "Total Arrears");

        if LoanOfficer <> '' then
            Snapshot.SetCurrentKey("Loan Officer", "As At", "Loan Category");

        Snapshot.SetRange("As At", AsAtDate);

        if LoanOfficer <> '' then
            Snapshot.SetRange("Loan Officer", LoanOfficer);

        if Snapshot.FindSet(false) then
            repeat
                if (Snapshot."Outstanding Principal" + Snapshot."Outstanding Interest") > 0 then begin
                    CategoryNo := GetCategoryNoFromSnapshot(Snapshot);

                    if CategoryNo in [1 .. 5] then begin
                        AddSnapshotToWeek(WeekIndex, CategoryNo, Snapshot);
                        AddSnapshotToWeek(WeekIndex, 6, Snapshot);
                    end;
                end;
            until Snapshot.Next() = 0;
    end;

    local procedure BuildVisibleWeeks()
    var
        WeekIndex: Integer;
    begin
        VisibleWeekCount := 0;

        for WeekIndex := 1 to NoOfWeeks do begin
            CurrentProgressStep += 1;

            UpdateProgressWindow(
                'Removing blank week columns',
                FormatDate(WeekEndDates[WeekIndex]),
                WeekIndex,
                NoOfWeeks);

            if HasWeekData(WeekIndex) then begin
                VisibleWeekCount += 1;
                VisibleWeekMap[VisibleWeekCount] := WeekIndex;
            end;
        end;
    end;

    local procedure HasWeekData(WeekIndex: Integer): Boolean
    begin
        if WeekCategoryLoanBalance[WeekIndex, 6] <> 0 then
            exit(true);

        if WeekCategoryLoanCount[WeekIndex, 6] <> 0 then
            exit(true);

        if WeekCategoryCollections[WeekIndex, 6] <> 0 then
            exit(true);

        if WeekCategoryArrears[WeekIndex, 6] <> 0 then
            exit(true);

        exit(false);
    end;

    local procedure AddSnapshotToWeek(WeekIndex: Integer; CategoryNo: Integer; Snapshot: Record "SASRA Category Snapshot")
    begin
        WeekCategoryLoanBalance[WeekIndex, CategoryNo] += Snapshot."Outstanding Principal" + Snapshot."Outstanding Interest";
        WeekCategoryLoanCount[WeekIndex, CategoryNo] += 1;

        // Collections should be within the specific report week, not cumulative to As At.
        WeekCategoryCollections[WeekIndex, CategoryNo] +=
            GetWeeklyLoanCollections(
                Snapshot."Loan No.",
                WeekIndex,
                Snapshot."As At");

        WeekCategoryArrears[WeekIndex, CategoryNo] += Snapshot."Total Arrears";
    end;

    local procedure GetWeeklyLoanCollections(LoanNo: Code[20]; WeekIndex: Integer; AsAtDate: Date): Decimal
    var
        LoanRec: Record Loans;
        WeekStartDate: Date;
        WeekEndDate: Date;
        PrincipalPaid: Decimal;
        InterestPaid: Decimal;
        PenaltyPaid: Decimal;
        InsurancePaid: Decimal;
    begin
        Clear(PrincipalPaid);
        Clear(InterestPaid);

        if LoanNo = '' then
            exit(0);

        if AsAtDate = 0D then
            exit(0);

        WeekEndDate := AsAtDate;

        // First week starts 6 days before the first selected week ending date.
        // Other weeks start one day after the previous week ending date.
        if WeekIndex = 1 then
            WeekStartDate := WeekEndDate - 6
        else begin
            if WeekEndDates[WeekIndex - 1] <> 0D then
                WeekStartDate := WeekEndDates[WeekIndex - 1] + 1
            else
                WeekStartDate := WeekEndDate - 6;
        end;

        LoanRec.Reset();
        LoanRec.SetRange("Loan No.", LoanNo);
        LoanRec.SetRange("Date Filter", WeekStartDate, WeekEndDate);
        LoanRec.SetAutoCalcFields("Principal Paid", "Interest Paid", "Penalty Paid", "Insurance Paid");
        if LoanRec.FindFirst() then begin
            PrincipalPaid := LoanRec."Principal Paid";
            InterestPaid := LoanRec."Interest Paid";
            PenaltyPaid := LoanRec."Penalty Paid";
            InsurancePaid := LoanRec."Insurance Paid";
        end;

        exit(PrincipalPaid + InterestPaid + InsurancePaid + PenaltyPaid);
    end;

    local procedure ClearWeekArrays(WeekIndex: Integer)
    var
        CategoryNo: Integer;
    begin
        for CategoryNo := 1 to 6 do begin
            WeekCategoryLoanBalance[WeekIndex, CategoryNo] := 0;
            WeekCategoryLoanCount[WeekIndex, CategoryNo] := 0;
            WeekCategoryCollections[WeekIndex, CategoryNo] := 0;
            WeekCategoryArrears[WeekIndex, CategoryNo] := 0;
        end;
    end;

    local procedure DecodeVisibleWeeklyNumber(NumberValue: Integer)
    var
        ZeroBasedNo: Integer;
    begin
        ZeroBasedNo := NumberValue - 1;

        CurrentVisibleWeekIndex := (ZeroBasedNo div 6) + 1;
        CurrentWeekIndex := VisibleWeekMap[CurrentVisibleWeekIndex];
        CurrentCategoryNo := (ZeroBasedNo mod 6) + 1;
    end;

    local procedure GetCategoryNoFromSnapshot(Snapshot: Record "SASRA Category Snapshot"): Integer
    begin
        case Snapshot."Loan Category" of
            Snapshot."Loan Category"::Performing:
                exit(1);
            Snapshot."Loan Category"::Watch:
                exit(2);
            Snapshot."Loan Category"::Substandard:
                exit(3);
            Snapshot."Loan Category"::Doubtful:
                exit(4);
            Snapshot."Loan Category"::Loss:
                exit(5);
        end;

        exit(0);
    end;

    local procedure GetCategoryName(CategoryNo: Integer): Text[30]
    begin
        case CategoryNo of
            1:
                exit('Performing');
            2:
                exit('Watch');
            3:
                exit('Substandard');
            4:
                exit('Doubtful');
            5:
                exit('Loss');
            6:
                exit('Total');
        end;

        exit('');
    end;

    local procedure UpdateProgressWindow(StageTxt: Text; WeekTxt: Text; CurrentNo: Integer; TotalNo: Integer)
    begin

        ProgressPercent := 0;

        if TotalProgressSteps <> 0 then
            ProgressPercent := Round(CurrentProgressStep / TotalProgressSteps * 10000, 1);

        ProgressWindow.Update(1, CopyStr(StageTxt, 1, 50));
        ProgressWindow.Update(2, CopyStr(WeekTxt, 1, 30));
        ProgressWindow.Update(3, CurrentNo);
        ProgressWindow.Update(4, TotalNo);
        ProgressWindow.Update(5, ProgressPercent);
    end;

    local procedure FormatDate(Value: Date): Text
    begin
        if Value = 0D then
            exit('');

        exit(Format(Value, 0, '<Day,2>/<Month,2>/<Year4>'));
    end;
}
