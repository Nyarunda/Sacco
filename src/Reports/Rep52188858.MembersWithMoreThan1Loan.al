namespace UnitedWomen.UnitedWomen;
using Microsoft.Foundation.Company;

report 50560 "Members With More Than 1 Loan"
{
    ApplicationArea = All;
    Caption = 'Members With More Than 1 Loan';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/MoreThan1Loan.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = sorting("Member No.") order(ascending) where(Posted = filter(true), "Total Outstanding Balance" = filter(> 0));
            CalcFields = "Total Arrears", "Interest Arrears", "Principal Arrears", "Outstanding Principal";
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(LoanProductTypeName; "Loan Product Type Name")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(DisbursementDate; "Disbursement Date")
            {
            }
            column(RepaymentStartDate; "Repayment Start Date")
            {
            }
            column(CompletionDate; "Completion Date")
            {
            }
            column(ApprovedAmount; "Approved Amount")
            {
            }
            column(AmountToDisburse; "Amount To Disburse")
            {
            }
            column(OutstandingPrincipal; "Outstanding Principal")
            {
            }
            column(OutstandingInterest; "Outstanding Interest")
            {
            }
            column(TotalOutstandingBalance; "Total Outstanding Balance")
            {
            }
            column(LoanPrincipleRepayment; "Loan Principle Repayment")
            {
            }
            column(LastPayDate; "Last Pay Date")
            {
            }
            column(Schedule_Balance; Loans."Schedule Balance")
            {

            }
            column(AsAt; AsAt)
            {
            }
            column(SASRA_Months_Arrears; "SASRA Months Arrears")
            {

            }
            column(Deposit; Deposit)
            {

            }
            column(LoansInterest; Loans."Outstanding Interest")
            {

            }
            column(UnderPayment; "Total Arrears")
            {

            }
            column(Overpayment; overpayment)
            { }


            trigger OnAfterGetRecord()
            var
                LSchedule: Record "Loan Repayment Schedule";
            begin

                if CountActivePostedLoans(Loans."Member No.") <= 1 then
                    CurrReport.Skip();

                Deposit := 0;
                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                SavAcc.SetFilter("Product Category", '%1', SavAcc."product category"::"Deposit Contribution");
                SavAcc.SetLoadFields("Balance (LCY)");
                SavAcc.SetFilter("Date Filter", '..%1', AsAt);
                if SavAcc.Find('-') then begin
                    SavAcc.CalcFields("Balance (LCY)");
                    Deposit := SavAcc."Balance (LCY)";
                end;

                LSchedule.Reset();
                LSchedule.SetRange("Loan No.", Loans."Loan No.");
                LSchedule.SetFilter("Repayment Date", '..%1', AsAt);
                if LSchedule.FindLast() then begin
                    Overpayment := abs(LSchedule."Loan Balance" - Loans."Outstanding Principal");
                    if Overpayment < 0 then
                        Overpayment := 0;
                end;


                Loans."Schedule Balance" := GetScheduleBalanceAsAt(AsAt);
            end;

            trigger OnPreDataItem()
            var
            begin

                if AsAt = 0D then
                    AsAt := Today;

                Loans.Setfilter("Date Filter", '..%1', AsAt);

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                field("As At"; AsAt)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnPreReport()
    begin

        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var

        AsAt: Date;
        CompanyInfo: Record "Company Information";
        LoanLookup: Record Loans;
        SavAcc: Record "Savings Accounts";
        Deposit: Decimal;
        Overpayment: Decimal;

        LoansInterest: Decimal;
        CreditLedgEntry: Record "Credit Ledger Entry";

    local procedure CountActivePostedLoans(MemberNo: Code[20]): Integer
    var
        LoanLookup: Record Loans;
        LoanCount: Integer;
    begin
        if MemberNo = '' then
            exit(0);

        LoanLookup.Reset();
        LoanLookup.SetRange("Member No.", MemberNo);
        LoanLookup.SetRange(Posted, true);

        if LoanLookup.FindSet() then
            repeat
                LoanLookup.CalcFields("Outstanding Principal");

                // Active loan = posted loan with outstanding principal
                if LoanLookup."Outstanding Principal" > 0 then begin
                    LoanCount += 1;

                    // No need to continue counting after 2
                    if LoanCount > 1 then
                        exit(LoanCount);
                end;
            until LoanLookup.Next() = 0;

        exit(LoanCount);
    end;

    procedure GetScheduleBalanceAsAt(AsAtDate: Date): Decimal
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        if AsAtDate = 0D then
            exit(0);

        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetCurrentKey("Loan No.", "Repayment Date", "Member No.");
        LoanRepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
        LoanRepaymentSchedule.SetFilter("Repayment Date", '..%1', AsAtDate);

        if LoanRepaymentSchedule.FindLast() then
            exit(LoanRepaymentSchedule."Loan Balance");

        exit(0);
    end;
}
