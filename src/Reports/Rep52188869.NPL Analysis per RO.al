namespace UnitedWomen.UnitedWomen;

using System.Utilities;
using System.Security.User;
using Microsoft.Foundation.Company;

report 50574 "NPL Analysis per RO"
{
    Caption = 'NPL Analysis per RO';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/NPLAnalysisPerRO__.rdl';

    dataset
    {
        dataitem(HeaderLine; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(HeaderCompanyName; CompanyInformation.Name) { }
            column(HeaderCompanyLogo; CompanyInformation.Picture) { }
            column(HeaderROCaption; GetHeaderROCaption()) { }
        }

        dataitem(LoanList; Loans)
        {
            DataItemTableView = sorting("Loan No.") where(Posted = const(true));
            RequestFilterFields = "Loan No.", "Member No.", "Loan Product Type", "Disbursement Date", "Loan Officer", "Booking Branch";

            column(LoanNo; "Loan No.") { }
            column(LoanProduct; "Loan Product Type Name") { }
            column(MemberName; "Member Name") { }
            column(MemberNo; "Member No.") { }
            column(IssueDate; "Disbursement Date") { }
            column(LoanStart; "Repayment Start Date") { }
            column(LoanEnd; "Completion Date") { }
            column(ApprovedAmount; "Approved Amount") { }
            column(NetDisbursed; "Amount To Disburse") { }
            column(CurrentBalance; CurrentBalance) { }
            column(OutstandingInterest; OutstandingInterest) { }
            column(PenaltyAccrued; PenaltyAccrued) { }
            column(InsuranceAccrued; InsuranceAccrued) { }
            column(TotalLoanBalance; TotalLoanBalance) { }
            column(SharesBalance; SharesBalance) { }
            column(PrincipalRepayment; "Principal Repayment") { }
            column(DateLastRepay; "Last Pay Date") { }
            column(CurrentLastPaymentDate; "Last Pay Date") { }
            column(LoanScheduleBalance; "Schedule Balance") { }
            column(Total_Arrears; TotalArrears) { }
            column(ArrearsMonths; LoanListMonthsInArrears) { }
            column(DaysInArrears; LoanListDaysInArrear) { }
            column(DefaultedAmount; LoanListDefAmount) { }
            column(InterestArrears; LoanListInterestArrears) { }
            column(LoanCategoryAsAt; LoanListCategoryTxt) { }

            column(UnderPayment; UnderPayment) { }
            column(OverPayment; OverPayment) { }
            column(LoanOfficer; "Loan Officer") { }

            trigger OnPreDataItem()
            begin

                if LoanOfficerFilter <> '' then
                    SetRange("Loan Officer", LoanOfficerFilter);

                SetRange("Date Filter", 0D, EndMonth);
                ApplySelectedPeriodFilter(LoanList, EndMonth);
                ResetCurrentMonthSummary();
            end;

            trigger OnAfterGetRecord()
            begin
                CalcFields(
                    "Outstanding Principal",
                    "Outstanding Interest",
                    "Outstanding Penalty",
                    "Outstanding Insurance",
                    "Schedule Balance",
                    "Last Pay Date");

                Clear(OverPayment);
                Clear(LoanListDefAmount);
                Clear(LoanListDaysInArrear);
                Clear(LoanListMonthsInArrears);
                Clear(LoanListInterestArrears);
                Clear(LoanListCategory);
                Clear(LoanListCategoryTxt);

                CategorizeLoanAsAtUsingMonthsInDefault(
                    LoanList,
                    EndMonth,
                    LoanListDefAmount,
                    LoanListDaysInArrear,
                    LoanListMonthsInArrears,
                    LoanListInterestArrears,
                    LoanListInsuranceArrears,
                    LoanListCategory);

                CurrentBalance := "Outstanding Principal";
                OutstandingInterest := "Outstanding Interest";
                PenaltyAccrued := "Outstanding Penalty";
                InsuranceAccrued := "Outstanding Insurance";
                TotalArrears := GetTotalArrearsAsAt(
                    LoanListDefAmount,
                    LoanListInterestArrears,
                    LoanListInsuranceArrears);
                TotalLoanBalance := CurrentBalance + OutstandingInterest; // + PenaltyAccrued + InsuranceAccrued;

                // Match Loan Summary Sheet: retain loans with principal or interest outstanding.
                if TotalLoanBalance <= 0 then
                    CurrReport.Skip();

                AccumulateCurrentMonthSummary(LoanListCategory, TotalLoanBalance, TotalArrears);

                SharesBalance := GetSharesBalance("Member No.");

                UnderPayment := LoanListDefAmount;


                LSchedule.Reset();
                LSchedule.SetRange("Loan No.", LoanList."Loan No.");
                LSchedule.SetFilter("Repayment Date", '..%1', EndMonth);
                if LSchedule.FindLast() then begin
                    Overpayment := LSchedule."Loan Balance" - LoanList."Outstanding Principal";
                    if Overpayment < 0 then
                        Overpayment := 0;
                end;


                LoanListCategoryTxt := GetLoanCategoryText(LoanListCategory);
            end;
        }

        dataitem(CategoryLoop; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = filter(1 .. 5));

            column(CategoryName; GetCategoryName(Number)) { }
            column(CategoryLoanBalance; CategoryLoanBalance) { }
            column(CategoryLoanCount; CategoryLoanCount) { }
            column(CategoryArrears; CategoryArrears) { }
            column(CategoryPAR; CategoryPAR) { }
            column(CompanyName; CompanyInformation.Name) { }
            column(CompanyLogo; CompanyInformation.Picture) { }

            trigger OnPreDataItem()
            begin
                FinalizeCurrentMonthSummary();
            end;

            trigger OnAfterGetRecord()
            begin
                CalculateCategory(Number);

                if (CategoryLoanBalance = 0) and
                   (CategoryLoanCount = 0) and
                   (CategoryArrears = 0) then
                    CurrReport.Skip();
            end;
        }

        dataitem(MonthLoop; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = filter(1 .. 12));

            column(ComparisonLineNo; Number) { }
            column(MonthCaption; MonthCaptions[Number]) { }
            column(MonthLoanBalance; MonthLoanBalance[Number]) { }
            column(MonthArrears; MonthArrears[Number]) { }
            column(MonthLoanCount; MonthLoanCount[Number]) { }
            column(MonthPAR; MonthPAR[Number]) { }

            trigger OnPreDataItem()
            begin
                if MonthCount <= 0 then
                    CurrReport.Break();

                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);

                SetRange(Number, 1, MonthCount);
            end;
        }

        dataitem(ComparisonLoop; Integer)
        {
            DataItemTableView = sorting(Number);

            column(ComparisonSectionNo; ComparisonSectionNo) { }
            column(ComparisonSectionName; ComparisonSectionName) { }
            column(ComparisonLineNoDynamic; ComparisonLineNo) { }
            column(ComparisonLabel; ComparisonLabel) { }
            column(ComparisonMonthIndex; ComparisonMonthIndex) { }
            column(ComparisonMonthCaption; ComparisonMonthCaption) { }
            column(ComparisonAmount; ComparisonAmount) { }

            trigger OnPreDataItem()
            begin
                if MonthCount <= 0 then
                    CurrReport.Break();

                // 4 sections * 7 rows * dynamic MonthCount
                SetRange(Number, 1, 4 * 7 * MonthCount);
            end;

            trigger OnAfterGetRecord()
            begin
                DecodeComparisonNumber(Number);

                ComparisonSectionName := GetComparisonSectionName(ComparisonSectionNo);
                ComparisonLabel := GetComparisonLabel(ComparisonLineNo);
                ComparisonMonthCaption := MonthCaptions[ComparisonMonthIndex];

                ComparisonAmount :=
                    GetDynamicComparisonAmount(
                        ComparisonSectionNo,
                        ComparisonLineNo,
                        ComparisonMonthIndex);
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
                    field(LoanOfficerFilter; LoanOfficerFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Loan Officer';
                        TableRelation = "User Setup"."User ID";
                    }

                    field(StartMonth; StartMonth)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }

                    field(EndMonth; EndMonth)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);

        if EndMonth = 0D then
            EndMonth := Today;

        if StartMonth = 0D then
            StartMonth := DMY2Date(1, Date2DMY(EndMonth, 2), Date2DMY(EndMonth, 3));

        if StartMonth > EndMonth then
            Error('Start Month cannot be greater than End Month.');

        BuildMonths();

        TotalProgressSteps := MonthCount + 3;
        CurrentProgressStep := 0;

        ProgressWindow.Open(
            'NPL Analysis per RO Processing...\' +
            'Stage: #1###############################\' +
            'Month: #2###############################\' +
            'Record: #3######## of #4########\' +
            'Progress: @5@@@@@@@@@@@@@@@@@@@@');

        CurrentProgressStep += 1;
        UpdateProgressWindow('Calculating total portfolio balance', '', 0, 0);

        TotalCategoryBalance := GetTotalCategoryBalance();

        CurrentProgressStep += 1;
        UpdateProgressWindow('Calculating monthly analysis', '', 0, 0);

        CalculateMonthlyAnalysis();

        CurrentProgressStep += 1;
        UpdateProgressWindow('Preparing report layout', '', 0, 0);

        ProgressWindow.Close();
    end;

    var
        CompanyInformation: Record "Company Information";
        LoanOfficerFilter: Code[80];
        StartMonth: Date;
        EndMonth: Date;

        CurrentBalance: Decimal;
        OutstandingInterest: Decimal;
        PenaltyAccrued: Decimal;
        InsuranceAccrued: Decimal;
        TotalLoanBalance: Decimal;
        SharesBalance: Decimal;
        UnderPayment: Decimal;
        OverPayment: Decimal;
        TotalArrears: Decimal;
        LSchedule: Record "Loan Repayment Schedule";
        SASRAMgt: Codeunit "SASRA Categorization Mgt.";
        SaccoActivities: Codeunit "Sacco Activities";
        LoanListDefAmount: Decimal;
        LoanListDaysInArrear: Integer;
        LoanListMonthsInArrears: Integer;
        LoanListInterestArrears: Decimal;
        LoanListInsuranceArrears: Decimal;
        LoanListCategory: Option Performing,Watch,Substandard,Doubtful,Loss;
        LoanListCategoryTxt: Text[30];

        CategoryLoanBalance: Decimal;
        CategoryLoanCount: Integer;
        CategoryArrears: Decimal;
        CategoryPAR: Decimal;
        TotalCategoryBalance: Decimal;

        MonthEndDates: array[12] of Date;
        MonthCaptions: array[12] of Text[20];
        MonthLoanBalance: array[12] of Decimal;
        MonthArrears: array[12] of Decimal;
        MonthLoanCount: array[12] of Integer;
        MonthPAR: array[12] of Decimal;
        BucketLoanBalance: array[5, 12] of Decimal;
        BucketArrears: array[5, 12] of Decimal;
        BucketLoanCount: array[5, 12] of Integer;
        BucketPAR: array[5, 12] of Decimal;
        MonthCount: Integer;

        ComparisonSectionNo: Integer;
        ComparisonLineNo: Integer;
        ComparisonMonthIndex: Integer;
        ComparisonSectionName: Text[50];
        ComparisonLabel: Text[30];
        ComparisonMonthCaption: Text[20];
        ComparisonAmount: Decimal;

        ProgressWindow: Dialog;
        TotalProgressSteps: Integer;
        CurrentProgressStep: Integer;
        ProgressPercent: Integer;
        CurrentMonthSummaryReset: Boolean;
        CurrentMonthSummaryFinalized: Boolean;

    local procedure CategorizeLoanAsAtUsingMonthsInDefault(var Loan: Record Loans; AsAt: Date; var DefAmount: Decimal; var DaysInArrear: Integer; var MonthsInArrears: Integer; var InterestArrears: Decimal; var InsuranceArrears: Decimal; var LoanCategory: Option Performing,Watch,Substandard,Doubtful,Loss)
    var
        SaccoSetup: Record "Sacco Setup";
        GracePeriod: DateFormula;
        MDef: Decimal;
    begin
        DefAmount := 0;
        DaysInArrear := 0;
        MonthsInArrears := 0;
        InterestArrears := 0;
        InsuranceArrears := 0;
        LoanCategory := LoanCategory::Performing;

        SaccoSetup.Get();
        GracePeriod := SaccoSetup."Arrears Grace Period";

        Loan.SetRange("Date Filter", 0D, AsAt);
        Loan.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Insurance");

        MDef := SaccoActivities.GetMonthsInDefault(Loan."Loan No.", AsAt, GracePeriod, DefAmount);
        MDef := Round(MDef, 1, '=');

        MonthsInArrears := MDef;
        DaysInArrear := Round(MDef * 30, 1, '=');

        InterestArrears := SaccoActivities.GetInterestArrears(Loan."Loan No.", AsAt);

        InsuranceArrears := SaccoActivities.GetInsuranceArrears(Loan."Loan No.", CalcDate('<-CM-1D>', AsAt));

        case DaysInArrear of
            0:
                LoanCategory := LoanCategory::Performing;
            1 .. 30:
                LoanCategory := LoanCategory::Watch;
            31 .. 180:
                LoanCategory := LoanCategory::Substandard;
            181 .. 360:
                LoanCategory := LoanCategory::Doubtful;
            else
                LoanCategory := LoanCategory::Loss;
        end;
    end;

    local procedure BuildMonths()
    var
        WorkMonth: Date;
    begin
        MonthCount := 0;
        WorkMonth := StartMonth;

        while WorkMonth <= EndMonth do begin
            MonthCount += 1;

            if MonthCount > 12 then
                Error('Maximum allowed period is 12 months.');

            MonthEndDates[MonthCount] := CalcDate('<CM>', WorkMonth);
            // Do not calculate the last partial month beyond the selected As At date.
            if MonthEndDates[MonthCount] > EndMonth then
                MonthEndDates[MonthCount] := EndMonth;
            MonthCaptions[MonthCount] := Format(WorkMonth, 0, '<Month Text,3>-<Year,2>');

            WorkMonth := CalcDate('<1M>', WorkMonth);
        end;
    end;

    local procedure UpdateProgressWindow(StageTxt: Text; MonthTxt: Text; CurrentNo: Integer; TotalNo: Integer)
    begin

        ProgressPercent := 0;

        if TotalProgressSteps <> 0 then
            ProgressPercent := Round(CurrentProgressStep / TotalProgressSteps * 10000, 1);

        ProgressWindow.Update(1, CopyStr(StageTxt, 1, 50));
        ProgressWindow.Update(2, CopyStr(MonthTxt, 1, 30));
        ProgressWindow.Update(3, CurrentNo);
        ProgressWindow.Update(4, TotalNo);
        ProgressWindow.Update(5, ProgressPercent);
    end;

    local procedure CountLoansForPeriod(BalanceAsAt: Date): Integer
    var
        Loan: Record Loans;
        EligibleLoanCount: Integer;
    begin
        ApplyLoanListFilters(Loan, BalanceAsAt);
        if Loan.FindSet() then
            repeat
                Loan.CalcFields("Outstanding Principal", "Outstanding Interest");
                if (Loan."Outstanding Principal" + Loan."Outstanding Interest") > 0 then
                    EligibleLoanCount += 1;
            until Loan.Next() = 0;

        exit(EligibleLoanCount);
    end;

    local procedure ApplyLoanListFilters(var Loan: Record Loans; BalanceAsAt: Date)
    begin
        Loan.Reset();
        Loan.CopyFilters(LoanList);
        Loan.SetRange(Posted, true);
        Loan.SetRange("Date Filter", 0D, BalanceAsAt);
        ApplySelectedPeriodFilter(Loan, BalanceAsAt); //ez

        if LoanOfficerFilter <> '' then
            Loan.SetRange("Loan Officer", LoanOfficerFilter);
    end;

    local procedure ApplySelectedPeriodFilter(var Loan: Record Loans; BalanceAsAt: Date)
    var
        ExistingDisbursementFilter: Text;
    begin
        ExistingDisbursementFilter := Loan.GetFilter("Disbursement Date");

        // StartMonth controls the comparison columns, not portfolio eligibility.
        // Each snapshot includes every loan disbursed on or before its as-at date,
        // matching the Loan Summary Sheet.
        if ExistingDisbursementFilter = '' then
            Loan.SetFilter("Disbursement Date", '..%1', BalanceAsAt)
        else
            Loan.SetFilter("Disbursement Date", ExistingDisbursementFilter + '&..%1', BalanceAsAt);
    end;

    local procedure GetHeaderROCaption(): Text
    begin
        if LoanOfficerFilter = '' then
            exit('');

        exit(StrSubstNo('Relationship Officer: %1', LoanOfficerFilter));
    end;

    local procedure ResetCurrentMonthSummary()
    var
        BucketIndex: Integer;
    begin
        if MonthCount <= 0 then
            exit;

        MonthLoanBalance[MonthCount] := 0;
        MonthArrears[MonthCount] := 0;
        MonthLoanCount[MonthCount] := 0;
        MonthPAR[MonthCount] := 0;

        for BucketIndex := 1 to 5 do begin
            BucketLoanBalance[BucketIndex, MonthCount] := 0;
            BucketArrears[BucketIndex, MonthCount] := 0;
            BucketLoanCount[BucketIndex, MonthCount] := 0;
            BucketPAR[BucketIndex, MonthCount] := 0;
        end;

        CurrentMonthSummaryReset := true;
        CurrentMonthSummaryFinalized := false;
    end;

    local procedure AccumulateCurrentMonthSummary(LoanCategory: Option Performing,Watch,Substandard,Doubtful,Loss; LoanBalance: Decimal; Arrears: Decimal)
    var
        BucketNo: Integer;
    begin
        if MonthCount <= 0 then
            exit;

        if not CurrentMonthSummaryReset then
            ResetCurrentMonthSummary();

        BucketNo := GetBucketNoByCategory(LoanCategory);

        MonthLoanBalance[MonthCount] += LoanBalance;
        MonthArrears[MonthCount] += Arrears;
        MonthLoanCount[MonthCount] += 1;

        BucketLoanBalance[BucketNo, MonthCount] += LoanBalance;
        BucketArrears[BucketNo, MonthCount] += Arrears;
        BucketLoanCount[BucketNo, MonthCount] += 1;
    end;

    local procedure FinalizeCurrentMonthSummary()
    var
        BucketIndex: Integer;
    begin
        if (MonthCount <= 0) or CurrentMonthSummaryFinalized then
            exit;

        if MonthLoanBalance[MonthCount] <> 0 then begin
            MonthPAR[MonthCount] :=
                Round(
                    ((BucketLoanBalance[3, MonthCount] +
                      BucketLoanBalance[4, MonthCount] +
                      BucketLoanBalance[5, MonthCount]) /
                      MonthLoanBalance[MonthCount]) * 100,
                    0.01,
                    '=');

            for BucketIndex := 1 to 5 do
                BucketPAR[BucketIndex, MonthCount] :=
                    Round((BucketLoanBalance[BucketIndex, MonthCount] / MonthLoanBalance[MonthCount]) * 100, 0.01, '=');
        end;

        CurrentMonthSummaryFinalized := true;
    end;

    local procedure GetBucketNoByCategory(LoanCategory: Option Performing,Watch,Substandard,Doubtful,Loss): Integer
    begin
        case LoanCategory of
            LoanCategory::Performing:
                exit(1);
            LoanCategory::Watch:
                exit(2);
            LoanCategory::Substandard:
                exit(3);
            LoanCategory::Doubtful:
                exit(4);
            LoanCategory::Loss:
                exit(5);
        end;

        exit(1);
    end;

    local procedure CalculateCategory(CategoryNo: Integer)
    var
        LastMonthIndex: Integer;
    begin
        CategoryLoanBalance := 0;
        CategoryLoanCount := 0;
        CategoryArrears := 0;
        CategoryPAR := 0;

        LastMonthIndex := MonthCount;

        if LastMonthIndex <= 0 then
            exit;

        CategoryLoanBalance := BucketLoanBalance[CategoryNo, LastMonthIndex];
        CategoryLoanCount := BucketLoanCount[CategoryNo, LastMonthIndex];
        CategoryArrears := BucketArrears[CategoryNo, LastMonthIndex];

        if MonthLoanBalance[LastMonthIndex] <> 0 then
            CategoryPAR := Round((CategoryLoanBalance / MonthLoanBalance[LastMonthIndex]) * 100, 0.01, '=');
    end;

    local procedure GetTotalCategoryBalance(): Decimal
    var
        Loan: Record Loans;
        TotalBalance: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        MonthsInArrears: Integer;
        InterestArrears: Decimal;
        InsuranceArrears: Decimal;
        LoanCategory: Option Performing,Watch,Substandard,Doubtful,Loss;
        TotalLoans: Integer;
        CurrentLoanNo: Integer;
    begin
        TotalBalance := 0;

        ApplyLoanListFilters(Loan, EndMonth);

        TotalLoans := Loan.Count();
        CurrentLoanNo := 0;

        if Loan.FindSet() then
            repeat

                Loan.CalcFields("Outstanding Interest", "Outstanding Principal");

                CurrentLoanNo += 1;

                if (CurrentLoanNo mod 100 = 0) or (CurrentLoanNo = TotalLoans) then
                    UpdateProgressWindow(
                        'Calculating total portfolio balance',
                        Format(EndMonth, 0, '<Month Text,3>-<Year,2>'),
                        CurrentLoanNo,
                        TotalLoans);

                Clear(DefAmount);
                Clear(DaysInArrear);
                Clear(MonthsInArrears);
                Clear(InterestArrears);
                Clear(LoanCategory);
                Clear(InsuranceArrears);

                CategorizeLoanAsAtUsingMonthsInDefault(
                    Loan,
                    EndMonth,
                    DefAmount,
                    DaysInArrear,
                    MonthsInArrears,
                    InterestArrears,
                    InsuranceArrears,
                    LoanCategory);

                if (Loan."Outstanding Principal" + Loan."Outstanding Interest") > 0 then
                    TotalBalance += Loan."Outstanding Principal" + Loan."Outstanding Interest";
            until Loan.Next() = 0;

        exit(TotalBalance);
    end;

    local procedure CalculateMonthlyAnalysis()
    var
        Loan: Record Loans;
        MonthIndex: Integer;
        BucketIndex: Integer;
        Balance: Decimal;
        Arrears: Decimal;
        BucketNo: Integer;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        MonthsInArrears: Integer;
        InterestArrears: Decimal;
        InsuranceArrears: Decimal;
        LoanCategory: Option Performing,Watch,Substandard,Doubtful,Loss;
        TotalLoansInMonth: Integer;
        CurrentLoanNo: Integer;
        MonthTxt: Text[30];
    begin
        for MonthIndex := 1 to MonthCount do begin
            CurrentProgressStep += 1;

            MonthTxt := MonthCaptions[MonthIndex];

            TotalLoansInMonth := CountLoansForPeriod(MonthEndDates[MonthIndex]);
            CurrentLoanNo := 0;

            UpdateProgressWindow(
                StrSubstNo('Calculating month %1 of %2', MonthIndex, MonthCount),
                MonthTxt,
                CurrentLoanNo,
                TotalLoansInMonth);

            MonthLoanBalance[MonthIndex] := 0;
            MonthArrears[MonthIndex] := 0;
            MonthLoanCount[MonthIndex] := 0;
            MonthPAR[MonthIndex] := 0;

            for BucketIndex := 1 to 5 do begin
                BucketLoanBalance[BucketIndex, MonthIndex] := 0;
                BucketArrears[BucketIndex, MonthIndex] := 0;
                BucketLoanCount[BucketIndex, MonthIndex] := 0;
                BucketPAR[BucketIndex, MonthIndex] := 0;
            end;

            ApplyLoanListFilters(Loan, MonthEndDates[MonthIndex]);
            if Loan.FindSet() then
                repeat
                    CurrentLoanNo += 1;

                    if (CurrentLoanNo mod 50 = 0) or (CurrentLoanNo = TotalLoansInMonth) then
                        UpdateProgressWindow(
                            StrSubstNo('Categorizing loans for %1', MonthTxt),
                            MonthTxt,
                            CurrentLoanNo,
                            TotalLoansInMonth
                    );

                    Clear(DefAmount);
                    Clear(DaysInArrear);
                    Clear(MonthsInArrears);
                    Clear(InterestArrears);
                    Clear(InsuranceArrears);
                    Clear(LoanCategory);
                    Clear(Balance);
                    Clear(Arrears);
                    Clear(BucketNo);

                    CategorizeLoanAsAtUsingMonthsInDefault(
                        Loan,
                        MonthEndDates[MonthIndex],
                        DefAmount,
                        DaysInArrear,
                        MonthsInArrears,
                        InterestArrears,
                        InsuranceArrears,
                        LoanCategory);

                    Balance := Loan."Outstanding Principal" + Loan."Outstanding Interest";
                    Arrears := GetTotalArrearsAsAt(
                        DefAmount,
                        InterestArrears,
                        InsuranceArrears);

                    if Balance > 0 then begin
                        MonthLoanBalance[MonthIndex] += Balance;
                        MonthArrears[MonthIndex] += Arrears;
                        MonthLoanCount[MonthIndex] += 1;

                        BucketNo := GetBucketNoByMonths(MonthsInArrears);

                        BucketLoanBalance[BucketNo, MonthIndex] += Balance;
                        BucketArrears[BucketNo, MonthIndex] += Arrears;
                        BucketLoanCount[BucketNo, MonthIndex] += 1;
                    end;
                until Loan.Next() = 0;

            if MonthLoanBalance[MonthIndex] <> 0 then begin
                MonthPAR[MonthIndex] :=
                    Round(
                        ((BucketLoanBalance[3, MonthIndex] +
                          BucketLoanBalance[4, MonthIndex] +
                          BucketLoanBalance[5, MonthIndex]) /
                          MonthLoanBalance[MonthIndex]) * 100,
                        0.01,
                        '=');

                for BucketIndex := 1 to 5 do
                    BucketPAR[BucketIndex, MonthIndex] :=
                        Round((BucketLoanBalance[BucketIndex, MonthIndex] / MonthLoanBalance[MonthIndex]) * 100, 0.01, '=');
            end;
        end;
    end;

    local procedure DecodeComparisonNumber(NumberValue: Integer)
    var
        ZeroBasedNo: Integer;
    begin
        ZeroBasedNo := NumberValue - 1;

        ComparisonSectionNo := (ZeroBasedNo div (7 * MonthCount)) + 1;
        ComparisonLineNo := ((ZeroBasedNo mod (7 * MonthCount)) div MonthCount) + 1;
        ComparisonMonthIndex := (ZeroBasedNo mod MonthCount) + 1;
    end;

    local procedure GetComparisonSectionName(SectionNo: Integer): Text[50]
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

    local procedure GetDynamicComparisonAmount(SectionNo: Integer; LineNo: Integer; MonthIndex: Integer): Decimal
    begin
        if (MonthIndex < 1) or (MonthIndex > MonthCount) then
            exit(0);

        case SectionNo of
            1:
                exit(GetComparisonLoanBalance(LineNo, MonthIndex));
            2:
                exit(GetComparisonArrears(LineNo, MonthIndex));
            3:
                exit(GetComparisonLoanCount(LineNo, MonthIndex));
            4:
                exit(GetComparisonPAR(LineNo, MonthIndex));
        end;

        exit(0);
    end;

    local procedure GetBucketNoByMonths(MonthsInArrears: Integer): Integer
    begin
        case MonthsInArrears of
            0:
                exit(1);
            1:
                exit(2);
            2 .. 6:
                exit(3);
            7 .. 12:
                exit(4);
            else
                exit(5);
        end;
    end;

    local procedure GetLoanCategoryText(LoanCategory: Option Performing,Watch,Substandard,Doubtful,Loss): Text[30]
    begin
        case LoanCategory of
            LoanCategory::Performing:
                exit('Performing');
            LoanCategory::Watch:
                exit('Watch');
            LoanCategory::Substandard:
                exit('Substandard');
            LoanCategory::Doubtful:
                exit('Doubtful');
            LoanCategory::Loss:
                exit('Loss');
        end;

        exit('');
    end;

    local procedure GetComparisonLabel(LineNo: Integer): Text[30]
    begin
        case LineNo of
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

    local procedure GetComparisonLoanBalance(LineNo: Integer; MonthIndex: Integer): Decimal
    begin
        if (MonthIndex < 1) or (MonthIndex > MonthCount) then
            exit(0);

        case LineNo of
            1, 7:
                exit(MonthLoanBalance[MonthIndex]);
            2:
                exit(BucketLoanBalance[1, MonthIndex]);
            3:
                exit(BucketLoanBalance[2, MonthIndex]);
            4:
                exit(BucketLoanBalance[3, MonthIndex]);
            5:
                exit(BucketLoanBalance[4, MonthIndex]);
            6:
                exit(BucketLoanBalance[5, MonthIndex]);
        end;

        exit(0);
    end;

    local procedure GetComparisonArrears(LineNo: Integer; MonthIndex: Integer): Decimal
    begin
        if (MonthIndex < 1) or (MonthIndex > MonthCount) then
            exit(0);

        case LineNo of
            1, 7:
                exit(MonthArrears[MonthIndex]);
            2:
                exit(BucketArrears[1, MonthIndex]);
            3:
                exit(BucketArrears[2, MonthIndex]);
            4:
                exit(BucketArrears[3, MonthIndex]);
            5:
                exit(BucketArrears[4, MonthIndex]);
            6:
                exit(BucketArrears[5, MonthIndex]);
        end;

        exit(0);
    end;

    local procedure GetTotalArrearsAsAt(PrincipalArrears: Decimal; InterestArrears: Decimal; InsuranceArrears: Decimal): Decimal
    begin
        exit(PrincipalArrears + InterestArrears + InsuranceArrears);
    end;

    local procedure GetComparisonLoanCount(LineNo: Integer; MonthIndex: Integer): Decimal
    begin
        if (MonthIndex < 1) or (MonthIndex > MonthCount) then
            exit(0);

        case LineNo of
            1, 7:
                exit(MonthLoanCount[MonthIndex]);
            2:
                exit(BucketLoanCount[1, MonthIndex]);
            3:
                exit(BucketLoanCount[2, MonthIndex]);
            4:
                exit(BucketLoanCount[3, MonthIndex]);
            5:
                exit(BucketLoanCount[4, MonthIndex]);
            6:
                exit(BucketLoanCount[5, MonthIndex]);
        end;

        exit(0);
    end;

    local procedure GetComparisonPAR(LineNo: Integer; MonthIndex: Integer): Decimal
    begin
        if (MonthIndex < 1) or (MonthIndex > MonthCount) then
            exit(0);

        case LineNo of
            1:
                exit(MonthPAR[MonthIndex]);
            2:
                exit(BucketPAR[1, MonthIndex]);
            3:
                exit(BucketPAR[2, MonthIndex]);
            4:
                exit(BucketPAR[3, MonthIndex]);
            5:
                exit(BucketPAR[4, MonthIndex]);
            6:
                exit(BucketPAR[5, MonthIndex]);
            7:
                begin
                    if MonthLoanBalance[MonthIndex] <> 0 then
                        exit(100);

                    exit(0);
                end;
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
        end;

        exit('');
    end;

    local procedure GetSharesBalance(MemberNo: Code[20]): Decimal
    var
        SavAcc: Record "Savings Accounts";
    begin
        SavAcc.Reset();
        SavAcc.SetRange("Member No.", MemberNo);
        SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Deposit Contribution");

        if SavAcc.FindFirst() then begin
            SavAcc.CalcFields("Balance (LCY)");
            exit(SavAcc."Balance (LCY)");
        end;

        exit(0);
    end;
}
