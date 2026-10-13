namespace UnitedWomen.UnitedWomen;

using Microsoft.Foundation.Company;
using Microsoft.HumanResources.Employee;
using System.Security.User;
using System.Utilities;

report 50559 "Loans Disbursed List"
{
    ApplicationArea = All;
    Caption = 'Loans Disbursed List';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/LoansDisbursedList.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = sorting("Disbursement Date") where(Posted = const(true));
            CalcFields = "Total Disbursed";
            RequestFilterFields = "Loan Officer";

            column(CompanyName; CompanyInfo.Name) { }
            column(Picture; CompanyInfo.Picture) { }
            column(ReportTitle; ReportTitle) { }
            column(PeriodCaption; PeriodCaption) { }
            column(ReportYearValue; ReportYear) { }
            column(PreparedBy; PreparedBy) { }
            column(PreparedDesignation; PreparedDesignation) { }
            column(PreparedDate; PreparedDate) { }
            column(MemberNo; "Member No.") { }
            column(Loan_No_; "Loan No.") { }
            column(MemberName; "Member Name") { }
            column(Installments; Installments) { }
            // column(NetToBeDisbursed; "Amount To Disburse") { }
            column(NetToBeDisbursed; "Net To Be Disbursed") { }
            column(TotalDisbursed; "Total Disbursed") { }
            column(LoanProductTypeName; "Loan Product Type Name") { }

            trigger OnPreDataItem()
            begin
                SetRange("Disbursement Date", StartDate, EndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                if IsFullLoanDisbursementReversed("Loan No.", "Disbursement Date") then
                    CurrReport.Skip();
            end;
        }

        dataitem(PartialDisbursementHeader; "Partial Loans Disb. Header")
        {
            DataItemTableView = where(Posted = const(true));

            dataitem(PartialDisbursementLine; "Partial Loans Disb. Lines")
            {
                DataItemLink = "Header No." = field("No.");

                column(PartialMemberNo; PartialDisbursementHeader."Member No.") { }
                column(PartialLoanNo; "Loan No.") { }
                column(PartialMemberName; PartialMemberName) { }
                column(PartialInstallments; PartialInstallments) { }
                column(PartialNetDisbursed; "Amount to Disbuse") { }
                column(PartialTotalDisbursed; "Amount to Disbuse") { }
                column(PartialLoanProductTypeName; PartialLoanProductTypeName) { }

                trigger OnAfterGetRecord()
                begin
                    LoadPartialDisbursementDetails();
                end;
            }

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", StartDate, EndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                if IsPartialDisbursementReversed(PartialDisbursementHeader) then
                    CurrReport.Skip();
            end;
        }

        dataitem(MonthLoop; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = filter(1 .. 12));

            column(MonthName; MonthName[Number]) { }
            column(PreparedBy_MonthLoop; PreparedBy) { }
            column(PreparedDesignation_MonthLoop; PreparedDesignation) { }
            column(PreparedDate_MonthLoop; PreparedDate) { }

            column(CY_Applications; CYApplications[Number]) { }
            column(CY_NoDisbursed; CYNoDisbursed[Number]) { }
            column(CY_NetDisbursed; CYNetDisbursed[Number]) { }
            column(CY_TotalApproved; CYTotalApproved[Number]) { }

            column(PY_NetDisbursed; PYNetDisbursed[Number]) { }
            column(PY_TotalApproved; PYTotalApproved[Number]) { }

            column(TotalCYApplications; TotalCYApplications) { }
            column(TotalCYNoDisbursed; TotalCYNoDisbursed) { }
            column(TotalCYNetDisbursed; TotalCYNetDisbursed) { }
            column(TotalCYApproved; TotalCYApproved) { }

            column(TotalPYNetDisbursed; TotalPYNetDisbursed) { }
            column(TotalPYApproved; TotalPYApproved) { }

            column(AvgCYNetDisbursed; AvgCYNetDisbursed) { }
            column(AvgCYApproved; AvgCYApproved) { }
            column(AvgPYNetDisbursed; AvgPYNetDisbursed) { }
            column(AvgPYApproved; AvgPYApproved) { }

            column(NetGrowthRate; NetGrowthRate) { }
            column(ApprovedGrowthRate; ApprovedGrowthRate) { }
            column(MonthNoDifference; MonthNoDifference) { }

            trigger OnAfterGetRecord()
            begin
                MonthNoDifference := EndMonthNo - StartMonthNo + 1;
            end;

            trigger OnPreDataItem()
            begin
                SetRange(Number, StartMonthNo, EndMonthNo);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(ReportYear; ReportYear)
                    {
                        ApplicationArea = All;
                        Caption = 'Report Year';
                    }

                    field(StartMonthNo; StartMonthNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Month No.';
                    }

                    field(EndMonthNo; EndMonthNo)
                    {
                        ApplicationArea = All;
                        Caption = 'End Month No.';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if ReportYear = 0 then
            ReportYear := Date2DMY(Today, 3);

        if StartMonthNo = 0 then
            StartMonthNo := 1;

        if EndMonthNo = 0 then
            EndMonthNo := Date2DMY(Today, 2);

        if StartMonthNo < 1 then
            StartMonthNo := 1;

        if EndMonthNo > 12 then
            EndMonthNo := 12;

        if StartMonthNo > EndMonthNo then
            Error('Start Month cannot be greater than End Month.');

        StartDate := DMY2Date(1, StartMonthNo, ReportYear);
        EndDate := CalcDate('<CM>', DMY2Date(1, EndMonthNo, ReportYear));

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        LoadPreparedBy();

        ReportTitle := StrSubstNo('LOANS DISBURSED LIST %1 %2', UpperCase(Format(EndDate, 0, '<Month Text>')), ReportYear);
        PeriodCaption := StrSubstNo('Report - %1 - %2 %3', Format(StartDate, 0, '<Month Text,3>'), Format(EndDate, 0, '<Month Text,3>'), ReportYear);

        BuildMonthNames();
        CalculateMonthlyComparison();
    end;

    var
        CompanyInfo: Record "Company Information";

        ReportYear: Integer;
        StartMonthNo: Integer;
        EndMonthNo: Integer;
        MonthNoDifference: Integer;
        StartDate: Date;
        EndDate: Date;
        ReportTitle: Text[100];
        PeriodCaption: Text[100];

        MonthName: array[12] of Text[20];

        CYApplications: array[12] of Integer;
        CYNoDisbursed: array[12] of Integer;
        CYNetDisbursed: array[12] of Decimal;
        CYTotalApproved: array[12] of Decimal;

        PYNetDisbursed: array[12] of Decimal;
        PYTotalApproved: array[12] of Decimal;

        TotalCYApplications: Integer;
        TotalCYNoDisbursed: Integer;
        TotalCYNetDisbursed: Decimal;
        TotalCYApproved: Decimal;
        TotalPYNetDisbursed: Decimal;
        TotalPYApproved: Decimal;

        AvgCYNetDisbursed: Decimal;
        AvgCYApproved: Decimal;
        AvgPYNetDisbursed: Decimal;
        AvgPYApproved: Decimal;

        NetGrowthRate: Decimal;
        ApprovedGrowthRate: Decimal;
        PreparedBy: Text[100];
        PreparedDate: Date;
        PreparedDesignation: Text[100];
        PartialMemberName: Text[100];
        PartialInstallments: Integer;
        PartialLoanProductTypeName: Text[100];

    local procedure BuildMonthNames()
    var
        i: Integer;
    begin
        for i := 1 to 12 do
            MonthName[i] := Format(DMY2Date(1, i, ReportYear), 0, '<Month Text,3>');
    end;

    local procedure CalculateMonthlyComparison()
    var
        i: Integer;
    begin
        ClearTotals();

        for i := StartMonthNo to EndMonthNo do begin
            CalculateCurrentYearMonth(i);
            CalculatePreviousYearMonth(i);

            TotalCYApplications += CYApplications[i];
            TotalCYNoDisbursed += CYNoDisbursed[i];
            TotalCYNetDisbursed += CYNetDisbursed[i];
            TotalCYApproved += CYTotalApproved[i];

            TotalPYNetDisbursed += PYNetDisbursed[i];
            TotalPYApproved += PYTotalApproved[i];
        end;

        if (EndMonthNo - StartMonthNo + 1) > 0 then begin
            AvgCYNetDisbursed := Round(TotalCYNetDisbursed / (EndMonthNo - StartMonthNo + 1), 0.01, '=');
            AvgCYApproved := Round(TotalCYApproved / (EndMonthNo - StartMonthNo + 1), 0.01, '=');
            AvgPYNetDisbursed := Round(TotalPYNetDisbursed / (EndMonthNo - StartMonthNo + 1), 0.01, '=');
            AvgPYApproved := Round(TotalPYApproved / (EndMonthNo - StartMonthNo + 1), 0.01, '=');
        end;

        if TotalPYNetDisbursed <> 0 then
            NetGrowthRate := Round(((TotalCYNetDisbursed - TotalPYNetDisbursed) / TotalPYNetDisbursed) * 100, 1, '=');

        if TotalPYApproved <> 0 then
            ApprovedGrowthRate := Round(((TotalCYApproved - TotalPYApproved) / TotalPYApproved) * 100, 1, '=');
    end;

    local procedure CalculateCurrentYearMonth(MonthNo: Integer)
    var
        LoanRec: Record Loans;
        PartialDisbursementHeader: Record "Partial Loans Disb. Header";
        PartialDisbursementLine: Record "Partial Loans Disb. Lines";
        MemberApprisal: Record "Member Salary Appraisal";
        FromDate: Date;
        ToDate: Date;
    begin
        FromDate := DMY2Date(1, MonthNo, ReportYear);
        ToDate := CalcDate('<CM>', FromDate);

        MemberApprisal.Reset();
        MemberApprisal.SetRange(Date, FromDate, ToDate);
        if MemberApprisal.FindSet() then
            CYApplications[MonthNo] := MemberApprisal.Count();


        LoanRec.Reset();
        LoanRec.SetRange(Posted, true);
        LoanRec.SetRange("Disbursement Date", FromDate, ToDate);
        LoanRec.SetAutoCalcFields("Total Disbursed");
        LoanRec.SetLoadFields("Amount To Disburse", "Approved Amount", "Requested Amount", "Total Disbursed");
        if LoanRec.FindSet() then
            repeat
                if not IsFullLoanDisbursementReversed(LoanRec."Loan No.", LoanRec."Disbursement Date") then begin
                    CYNoDisbursed[MonthNo] += 1;
                    CYNetDisbursed[MonthNo] += LoanRec."Total Disbursed";
                    if LoanRec."Approved Amount" > 0 then
                        CYTotalApproved[MonthNo] += LoanRec."Approved Amount"
                    else
                        CYTotalApproved[MonthNo] += LoanRec."Requested Amount";
                end;
            until LoanRec.Next() = 0;

        PartialDisbursementHeader.SetRange(Posted, true);
        PartialDisbursementHeader.SetRange("Posting Date", FromDate, ToDate);
        if PartialDisbursementHeader.FindSet() then
            repeat
                if not IsPartialDisbursementReversed(PartialDisbursementHeader) then begin
                    PartialDisbursementLine.SetRange("Header No.", PartialDisbursementHeader."No.");
                    if PartialDisbursementLine.FindSet() then
                        repeat
                            CYNoDisbursed[MonthNo] += 1;
                            CYNetDisbursed[MonthNo] += PartialDisbursementLine."Amount to Disbuse";
                            CYTotalApproved[MonthNo] += PartialDisbursementLine."Amount to Disbuse";
                        until PartialDisbursementLine.Next() = 0;
                    PartialDisbursementLine.Reset();
                end;
            until PartialDisbursementHeader.Next() = 0;
    end;

    local procedure CalculatePreviousYearMonth(MonthNo: Integer)
    var
        LoanRec: Record Loans;
        PartialDisbursementHeader: Record "Partial Loans Disb. Header";
        PartialDisbursementLine: Record "Partial Loans Disb. Lines";
        FromDate: Date;
        ToDate: Date;
    begin
        FromDate := DMY2Date(1, MonthNo, ReportYear - 1);
        ToDate := CalcDate('<CM>', FromDate);

        LoanRec.Reset();
        LoanRec.SetRange(Posted, true);
        LoanRec.SetRange("Disbursement Date", FromDate, ToDate);
        LoanRec.SetAutoCalcFields("Total Disbursed");
        LoanRec.SetLoadFields("Amount To Disburse", "Approved Amount", "Total Disbursed");
        if LoanRec.FindSet() then
            repeat
                if not IsFullLoanDisbursementReversed(LoanRec."Loan No.", LoanRec."Disbursement Date") then begin
                    PYNetDisbursed[MonthNo] += LoanRec."Total Disbursed";
                    PYTotalApproved[MonthNo] += LoanRec."Approved Amount";
                end;
            until LoanRec.Next() = 0;

        PartialDisbursementHeader.SetRange(Posted, true);
        PartialDisbursementHeader.SetRange("Posting Date", FromDate, ToDate);
        if PartialDisbursementHeader.FindSet() then
            repeat
                if not IsPartialDisbursementReversed(PartialDisbursementHeader) then begin
                    PartialDisbursementLine.SetRange("Header No.", PartialDisbursementHeader."No.");
                    if PartialDisbursementLine.FindSet() then
                        repeat
                            PYNetDisbursed[MonthNo] += PartialDisbursementLine."Amount to Disbuse";
                            PYTotalApproved[MonthNo] += PartialDisbursementLine."Amount to Disbuse";
                        until PartialDisbursementLine.Next() = 0;
                    PartialDisbursementLine.Reset();
                end;
            until PartialDisbursementHeader.Next() = 0;
    end;

    local procedure ClearTotals()
    var
        i: Integer;
    begin
        TotalCYApplications := 0;
        TotalCYNoDisbursed := 0;
        TotalCYNetDisbursed := 0;
        TotalCYApproved := 0;
        TotalPYNetDisbursed := 0;
        TotalPYApproved := 0;
        AvgCYNetDisbursed := 0;
        AvgCYApproved := 0;
        AvgPYNetDisbursed := 0;
        AvgPYApproved := 0;
        NetGrowthRate := 0;
        ApprovedGrowthRate := 0;

        for i := 1 to 12 do begin
            CYApplications[i] := 0;
            CYNoDisbursed[i] := 0;
            CYNetDisbursed[i] := 0;
            CYTotalApproved[i] := 0;
            PYNetDisbursed[i] := 0;
            PYTotalApproved[i] := 0;
        end;
    end;

    local procedure LoadPreparedBy()
    var
        Employee: Record Employee;
        UserSetup: Record "User Setup";
    begin
        PreparedDate := Today;
        PreparedBy := UserId;
        Clear(PreparedDesignation);

        if UserSetup.Get(UserId) then
            if Employee.Get(UserSetup."Staff No") then begin
                PreparedBy := Employee.FullName();
                PreparedDesignation := Employee."Job Title";
            end;
    end;

    local procedure LoadPartialDisbursementDetails()
    var
        Loan: Record Loans;
    begin
        Clear(PartialMemberName);
        Clear(PartialInstallments);
        Clear(PartialLoanProductTypeName);

        if Loan.Get(PartialDisbursementLine."Loan No.") then begin
            PartialMemberName := Loan."Member Name";
            PartialInstallments := Loan.Installments;
            PartialLoanProductTypeName := CopyStr(Loan."Loan Product Type Name" + ' (Partial Disbursement)', 1, MaxStrLen(PartialLoanProductTypeName));
        end;
    end;

    local procedure IsFullLoanDisbursementReversed(LoanNo: Code[20]; DisbursementDate: Date): Boolean
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        CreditLedgerEntry.SetRange("Loan No.", LoanNo);
        CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."Transaction Type"::"Loan Disbursement");
        CreditLedgerEntry.SetRange("Posting Date", DisbursementDate);
        if CreditLedgerEntry.IsEmpty() then
            exit(false);

        CreditLedgerEntry.SetRange(Reversed, false);
        exit(CreditLedgerEntry.IsEmpty());
    end;

    local procedure IsPartialDisbursementReversed(PartialDisbursementHeader: Record "Partial Loans Disb. Header"): Boolean
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        PartialDisbursementHeader.CalcFields(Reversed);
        if PartialDisbursementHeader.Reversed then
            exit(true);

        CreditLedgerEntry.SetRange("Document No.", PartialDisbursementHeader."No.");
        CreditLedgerEntry.SetRange("Loan No.", PartialDisbursementHeader."Loan No.");
        CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."Transaction Type"::"Loan Disbursement");
        if CreditLedgerEntry.IsEmpty() then
            exit(false);

        CreditLedgerEntry.SetRange(Reversed, false);
        exit(CreditLedgerEntry.IsEmpty());
    end;

}
