namespace UnitedWomen.UnitedWomen;

report 50592 "Loan Rescheduled Report"
{
    ApplicationArea = All;
    Caption = 'Loan Rescheduled Report';
    UsageCategory = ReportsAndAnalysis;

    RDLCLayout = './src/Layouts/loanrecheduledreport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Loans; Loans)
        {
            column(LoanNo; "Loan No.") { }
            column(MemberNo; "Member No.") { }
            column(MemberName; "Member Name") { }
            column(IDNo; "ID No.") { }
            column(AmountToDisburse; "Amount To Disburse") { }
            column(DisbursementDate; Format("Disbursement Date")) { }
            column(DateRescheduled; Format(ReschedulingDate)) { }
            column(Installments; Installments) { }
            column(InitialRepaymentPeriod; InitialRepaymentPeriod) { }
            column(OutstandingLoanBalance; OutstandingLoanBalance) { }
            column(OutstandingLoanPeriod; OutstandingLoanPeriod) { }
            column(RevisedLoanPeriod; RevisedLoanPeriod) { }
            column(NewLoanEndDate; Format(NewLoanEndDate)) { }
            column(RescheduleRemarks; RescheduleRemarks) { }
            column(CompletionDate; "Completion Date") { }
            column(LoanProductTypeName; "Loan Product Type Name") { }
            column(LoanBalanceAtRescheduling; "Loan Balance at Rescheduling") { }
            column(RescheduleBy; "Reschedule by") { }
            column(LoanRescheduled; "Loan Rescheduled") { }

            trigger OnAfterGetRecord()
            begin
                SetLoanChangeValues();
            end;

            trigger OnPreDataItem()
            begin
                // Only rescheduled loans
                SetRange("Loan Rescheduled", true);

                // Date filter
                if FromDate <> 0D then begin
                    if ToDate = 0D then
                        ToDate := FromDate;

                    SetRange("Date Rescheduled", FromDate, ToDate);
                end;
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(FromDate; FromDate)
                    {
                        ApplicationArea = All;
                        Caption = 'From';
                    }

                    field(ToDate; ToDate)
                    {
                        ApplicationArea = All;
                        Caption = 'To';
                    }
                }
            }
        }
    }

    var
        FromDate: Date;
        ToDate: Date;
        InitialRepaymentPeriod: Integer;
        OutstandingLoanBalance: Decimal;
        OutstandingLoanPeriod: Integer;
        RevisedLoanPeriod: Integer;
        NewLoanEndDate: Date;
        ReschedulingDate: Date;
        RescheduleRemarks: Text[200];

    local procedure SetLoanChangeValues()
    var
        LoanChanges: Record "Loan Changes";
    begin
        InitialRepaymentPeriod := Loans.Installments;
        OutstandingLoanBalance := Loans."Loan Balance at Rescheduling";
        OutstandingLoanPeriod := 0;
        RevisedLoanPeriod := Loans.Installments;
        NewLoanEndDate := Loans."Completion Date";
        ReschedulingDate := 0D;
        RescheduleRemarks := '';

        LoanChanges.Reset();
        LoanChanges.SetRange("Loan No.", Loans."Loan No.");
        LoanChanges.SetRange(Processed, true);
        LoanChanges.SetRange("Type of Change", LoanChanges."Type of Change"::"Loan Rescheduling");
        if not LoanChanges.FindLast() then
            exit;

        ReschedulingDate := LoanChanges."Rescheduling Date";

        if LoanChanges."Original Installments" <> 0 then
            InitialRepaymentPeriod := LoanChanges."Original Installments";

        if LoanChanges."New Loan Amount" <> 0 then
            OutstandingLoanBalance := LoanChanges."New Loan Amount"
        else
            if LoanChanges."Total Outstanding" <> 0 then
                OutstandingLoanBalance := LoanChanges."Total Outstanding";

        OutstandingLoanPeriod := LoanChanges."Remaining Installments";

        if LoanChanges."New Installments" <> 0 then
            RevisedLoanPeriod := LoanChanges."New Installments";

        if NewLoanEndDate = 0D then
            if (LoanChanges."Rescheduling Date" <> 0D) and (RevisedLoanPeriod <> 0) then
                NewLoanEndDate := CalcDate(Format(RevisedLoanPeriod) + 'M', LoanChanges."Rescheduling Date");

        RescheduleRemarks := LoanChanges.Remarks;
    end;

}
