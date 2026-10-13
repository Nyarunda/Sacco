report 50684 "Loans Bal. Without Schedules"
{
    Caption = 'Loans With Balances Without Schedules';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Permissions = tabledata Loans = r,
                  tabledata "Loan Repayment Schedule" = r;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = where(Number = const(1));

            trigger OnAfterGetRecord()
            begin
                GenerateExcel();
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
                    Caption = 'Filters';

                    field(AsAtDate; AsAtDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Balance As At Date';
                        ToolTip = 'Specifies the date to use when calculating outstanding loan balances.';
                    }
                    field(OnlyPostedLoans; OnlyPostedLoans)
                    {
                        ApplicationArea = All;
                        Caption = 'Only Posted Loans';
                        ToolTip = 'Specifies whether only posted loans should be included.';
                    }
                    field(OnlyLoansBeforeGoLiveDate; OnlyLoansBeforeGoLiveDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Only Loans Before Go-Live Date';
                        ToolTip = 'Specifies whether to include only loans disbursed on or before the Sacco Setup go-live date.';
                    }
                    field(MinimumBalance; MinimumBalance)
                    {
                        ApplicationArea = All;
                        Caption = 'Minimum Balance';
                        ToolTip = 'Specifies the minimum total outstanding balance required for a loan to be included.';
                    }
                    field(LoanNoFilter; LoanNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Loan No. Filter';
                        ToolTip = 'Specifies the loan number filter to apply.';
                    }
                    field(MemberNoFilter; MemberNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Member No. Filter';
                        ToolTip = 'Specifies the member number filter to apply.';
                    }
                    field(LoanProductTypeFilter; LoanProductTypeFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Loan Product Type Filter';
                        ToolTip = 'Specifies the loan product type filter to apply.';
                    }
                    field(DisbursementDateFilter; DisbursementDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Disbursement Date Filter';
                        ToolTip = 'Specifies the disbursement date filter to apply.';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        AsAtDate := Today;
        OnlyPostedLoans := true;
        OnlyLoansBeforeGoLiveDate := true;
        MinimumBalance := 0.01;
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        AsAtDate: Date;
        OnlyPostedLoans: Boolean;
        OnlyLoansBeforeGoLiveDate: Boolean;
        MinimumBalance: Decimal;
        LoanNoFilter: Text[250];
        MemberNoFilter: Text[250];
        LoanProductTypeFilter: Text[250];
        DisbursementDateFilter: Text[250];
        LoansFound: Integer;
        TotalOutstandingBalance: Decimal;
        GoLiveDate: Date;

    local procedure GenerateExcel()
    begin
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.CreateNewBook('Loans Without Schedules');

        SetGoLiveDate();
        WriteHeader();
        WriteLoanLines();
        WriteSummary();

        TempExcelBuffer.WriteSheet('Loans Without Schedules', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.OpenExcel();
    end;

    local procedure SetGoLiveDate()
    var
        SaccoSetup: Record "Sacco Setup";
    begin
        GoLiveDate := 0D;
        if SaccoSetup.Get() then
            GoLiveDate := SaccoSetup."Go Live Date";
    end;

    local procedure WriteHeader()
    begin
        TempExcelBuffer.NewRow();
        AddTextCell('LOANS WITH BALANCES BUT WITHOUT REPAYMENT SCHEDULES', true);

        TempExcelBuffer.NewRow();
        AddTextCell('Run Date', true);
        AddTextCell(Format(CurrentDateTime), false);

        TempExcelBuffer.NewRow();
        AddTextCell('Balance As At Date', true);
        AddTextCell(Format(AsAtDate), false);

        if OnlyLoansBeforeGoLiveDate then begin
            TempExcelBuffer.NewRow();
            AddTextCell('Go-Live Date Filter', true);
            if GoLiveDate = 0D then
                AddTextCell('No go-live date found in Sacco Setup', false)
            else
                AddTextCell(Format(GoLiveDate), false);
        end;

        WriteAppliedFilter('Loan No. Filter', LoanNoFilter);
        WriteAppliedFilter('Member No. Filter', MemberNoFilter);
        WriteAppliedFilter('Loan Product Type Filter', LoanProductTypeFilter);
        WriteAppliedFilter('Disbursement Date Filter', DisbursementDateFilter);

        TempExcelBuffer.NewRow();
        TempExcelBuffer.NewRow();
        AddTextCell('S/No.', true);
        AddTextCell('Loan No.', true);
        AddTextCell('Member No.', true);
        AddTextCell('Member Name', true);
        AddTextCell('Loan Product Type', true);
        AddTextCell('Loan Account', true);
        AddTextCell('Disbursement Date', true);
        AddTextCell('Approved Amount', true);
        AddTextCell('Installments', true);
        AddTextCell('Outstanding Principal', true);
        AddTextCell('Outstanding Interest', true);
        AddTextCell('Outstanding Penalty', true);
        AddTextCell('Outstanding Insurance', true);
        AddTextCell('Total Outstanding Balance', true);
        AddTextCell('Last Pay Date', true);
    end;

    local procedure WriteAppliedFilter(FilterCaption: Text; FilterValue: Text)
    begin
        if FilterValue = '' then
            exit;

        TempExcelBuffer.NewRow();
        AddTextCell(FilterCaption, true);
        AddTextCell(FilterValue, false);
    end;

    local procedure WriteLoanLines()
    var
        Loan: Record Loans;
        SerialNo: Integer;
    begin
        LoansFound := 0;
        TotalOutstandingBalance := 0;

        Loan.Reset();
        ApplyLoanFilters(Loan);
        if not Loan.FindSet() then
            exit;

        repeat
            Loan.SetFilter("Date Filter", '..%1', AsAtDate);
            Loan.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Insurance", "Total Outstanding Balance", "Last Pay Date");

            if IncludeLoan(Loan) then begin
                SerialNo += 1;
                LoansFound += 1;
                TotalOutstandingBalance += Loan."Total Outstanding Balance";

                TempExcelBuffer.NewRow();
                AddIntegerCell(SerialNo, false);
                AddTextCell(Loan."Loan No.", false);
                AddTextCell(Loan."Member No.", false);
                AddTextCell(Loan."Member Name", false);
                AddTextCell(Loan."Loan Product Type", false);
                AddTextCell(Loan."Loan Account", false);
                AddTextCell(Format(Loan."Disbursement Date"), false);
                AddDecimalCell(Loan."Approved Amount", false);
                AddIntegerCell(Loan.Installments, false);
                AddDecimalCell(Loan."Outstanding Principal", false);
                AddDecimalCell(Loan."Outstanding Interest", false);
                AddDecimalCell(Loan."Outstanding Penalty", false);
                AddDecimalCell(Loan."Outstanding Insurance", false);
                AddDecimalCell(Loan."Total Outstanding Balance", true);
                AddTextCell(Format(Loan."Last Pay Date"), false);
            end;
        until Loan.Next() = 0;
    end;

    local procedure ApplyLoanFilters(var Loan: Record Loans)
    begin
        if OnlyPostedLoans then
            Loan.SetRange(Posted, true);

        if OnlyLoansBeforeGoLiveDate and (GoLiveDate <> 0D) then
            Loan.SetFilter("Disbursement Date", '..%1', GoLiveDate);

        if LoanNoFilter <> '' then
            Loan.SetFilter("Loan No.", LoanNoFilter);

        if MemberNoFilter <> '' then
            Loan.SetFilter("Member No.", MemberNoFilter);

        if LoanProductTypeFilter <> '' then
            Loan.SetFilter("Loan Product Type", LoanProductTypeFilter);

        if DisbursementDateFilter <> '' then
            Loan.SetFilter("Disbursement Date", DisbursementDateFilter);
    end;

    local procedure IncludeLoan(Loan: Record Loans): Boolean
    begin
        if Abs(Loan."Total Outstanding Balance") < MinimumBalance then
            exit(false);

        exit(not LoanHasRepaymentSchedule(Loan."Loan No."));
    end;

    local procedure LoanHasRepaymentSchedule(LoanNo: Code[20]): Boolean
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange("Loan No.", LoanNo);
        exit(not LoanRepaymentSchedule.IsEmpty());
    end;

    local procedure WriteSummary()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.NewRow();

        if LoansFound = 0 then begin
            AddTextCell('No loans with balances and missing repayment schedules were found for the selected filters.', true);
            exit;
        end;

        AddTextCell('Loans Found', true);
        AddIntegerCell(LoansFound, true);

        TempExcelBuffer.NewRow();
        AddTextCell('Total Outstanding Balance', true);
        AddDecimalCell(TotalOutstandingBalance, true);
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
