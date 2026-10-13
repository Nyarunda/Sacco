namespace UnitedWomen_Production.UnitedWomen_Production;

report 50009 GenerateLoanSchedules
{
    Caption = 'Generate LoanSchedules For Guarantor Loans';
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Loan; Loans)
        {
            RequestFilterFields = "Loan No.", "Member No.", "Loan Product Type";

            trigger OnPreDataItem()
            begin
                SetRange("Annual Interest %", 0);
                SetFilter("Approved Amount", '>%1', 0);
                SetFilter(Installments, '>%1', 0);
            end;

            trigger OnAfterGetRecord()
            begin
                GenerateSchedule(Loan);
                LoansProcessed += 1;
            end;
        }
    }

    trigger OnPostReport()
    begin
        Message('%1 zero-interest loan schedule(s) generated.', LoansProcessed);
    end;

    local procedure GenerateSchedule(CurrentLoan: Record Loans)
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        InstallmentNo: Integer;
        RepaymentDate: Date;
        MonthlyPrincipal: Decimal;
        LoanBalance: Decimal;
    begin
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange("Loan No.", CurrentLoan."Loan No.");
        if LoanRepaymentSchedule.FindFirst() then
            LoanRepaymentSchedule.DeleteAll();

        LoanBalance := CurrentLoan."Approved Amount";
        MonthlyPrincipal := Round(CurrentLoan."Approved Amount" / CurrentLoan.Installments, 0.01, '=');
        RepaymentDate := GetFirstRepaymentDate(CurrentLoan);

        for InstallmentNo := 1 to CurrentLoan.Installments do begin
            LoanRepaymentSchedule.Init();
            LoanRepaymentSchedule."Line No." := InstallmentNo;
            LoanRepaymentSchedule."Loan No." := CurrentLoan."Loan No.";
            LoanRepaymentSchedule."Member No." := CurrentLoan."Member No.";
            LoanRepaymentSchedule."Loan Amount" := CurrentLoan."Approved Amount";
            LoanRepaymentSchedule."Repayment Date" := RepaymentDate;

            if InstallmentNo = CurrentLoan.Installments then
                LoanRepaymentSchedule."Monthly Principal" := LoanBalance
            else
                LoanRepaymentSchedule."Monthly Principal" := MonthlyPrincipal;

            LoanRepaymentSchedule."Monthly Interest" := 0;
            LoanRepaymentSchedule."Monthly Appraisal" := 0;
            LoanRepaymentSchedule."Monthly Repayment" := LoanRepaymentSchedule."Monthly Principal";

            LoanBalance -= LoanRepaymentSchedule."Monthly Principal";
            if LoanBalance < 1 then
                LoanBalance := 0;

            LoanRepaymentSchedule."Loan Balance" := LoanBalance;
            LoanRepaymentSchedule.Insert();

            RepaymentDate := CalcDate('<1M>', RepaymentDate);
        end;
    end;

    local procedure GetFirstRepaymentDate(CurrentLoan: Record Loans): Date
    begin
        if CurrentLoan."Repayment Start Date" <> 0D then
            exit(CurrentLoan."Repayment Start Date");

        if CurrentLoan."Disbursement Date" <> 0D then
            exit(CalcDate('<1M>', CurrentLoan."Disbursement Date"));

        exit(WorkDate());
    end;

    var
        LoansProcessed: Integer;
}

