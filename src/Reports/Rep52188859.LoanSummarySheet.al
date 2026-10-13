namespace UnitedWomen.UnitedWomen;
using Microsoft.Foundation.Company;

report 50561 "Loan Summary Sheet"
{
    ApplicationArea = All;
    Caption = 'Loan Summary Sheet';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/LoanSummarySheet.rdlc';
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = sorting("Loan No.") order(ascending) where(Posted = filter(true));
            CalcFields = "Total Arrears", "Interest Arrears", "Principal Arrears", "Outstanding Principal", "Outstanding Insurance", "Outstanding Penalty", "Outstanding Interest", "Last Pay Date", "Schedule Balance";
            RequestFilterFields = "Member No.", "Loan No.", "Loan Officer", "Date Filter";
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
            column(Insurance_Due; Loans."Outstanding Insurance")
            { }
            column(Penalty_Due; Loans."Outstanding Penalty")
            { }
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
            column(AmountToDisburse; "Amount To Disburse" + PartialAmt)
            {
            }
            column(OutstandingPrincipal; "Outstanding Principal")
            {
            }
            column(OutstandingInterest; "Outstanding Interest")
            {
            }
            column(TotalOutstandingBalance; "Outstanding Principal" + "Outstanding Interest")
            {
            }
            column(LoanPrincipleRepayment; PRepayment)
            {
            }
            column(LastPayDate; "Last Pay Date")
            {
            }
            column(Schedule_Balance; "Schedule Balance")
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(SASRA_Months_Arrears; MDef)
            {
            }
            column(Deposit; Deposit)
            {
            }
            column(LoansInterest; LoansInterest)
            {
            }
            column(Loans_Category_SASRA; "Loans Category-SASRA")
            {
            }
            column(DaysInArrears; DaysInArrear)
            {
            }
            column(UnderPayment; DefAmount)
            {
            }
            column(Overpayment; overpayment)
            { }
            column(TotalArrears; DefAmount + Loans."Outstanding Insurance" + Loans."Outstanding Penalty" + Loans."Outstanding Interest")
            { }


            trigger OnAfterGetRecord()
            var
                LSchedule: Record "Loan Repayment Schedule";
                SaccoActivities: Codeunit "Sacco Activities";
                ExpectedAmt, AmtPaid : Decimal;
                ArrearsDate: Date;
                GracePeriod: Dateformula;
            begin

                Deposit := 0;
                PartialAmt := 0;
                PRepayment := 0;

                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                SavAcc.SetFilter("Product Category", '%1', SavAcc."product category"::"Deposit Contribution");
                SavAcc.SetLoadFields("Balance (LCY)");
                SavAcc.SetFilter("Date Filter", '..%1', AsAt);
                if SavAcc.Find('-') then begin
                    SavAcc.CalcFields("Balance (LCY)");
                    Deposit := SavAcc."Balance (LCY)";
                end;

                if (GenSetUp."Go Live Date" <> 0D) and ("Loans"."Disbursement Date" <= GenSetUp."Go Live Date") then begin
                    PartialDisbHeader.Reset();
                    PartialDisbHeader.SetRange("Loan No.", "Loans"."Loan No.");
                    PartialDisbHeader.SetRange(Posted, true);
                    PartialDisbHeader.SetFilter("Posting Date", '<=%1', AsAt);
                    if PartialDisbHeader.FindSet() then
                        repeat
                            PartialDisbHeader.CalcFields(Reversed);
                            if not PartialDisbHeader.Reversed then begin
                                PartialDisbLine.Reset();
                                PartialDisbLine.SetRange("Header No.", PartialDisbHeader."No.");
                                PartialDisbLine.SetRange("Loan No.", "Loans"."Loan No.");
                                PartialDisbLine.CalcSums("Amount to Disbuse");
                                PartialAmt += PartialDisbLine."Amount to Disbuse";
                            end;
                        until PartialDisbHeader.Next() = 0;
                end;

                LSchedule.Reset();
                LSchedule.SetRange("Loan No.", Loans."Loan No.");
                LSchedule.SetFilter("Repayment Date", '..%1', AsAt);
                if LSchedule.FindLast() then begin
                    Overpayment := LSchedule."Loan Balance" - Loans."Outstanding Principal";
                    if Overpayment < 0 then
                        Overpayment := 0;

                    PRepayment := LSchedule."Monthly Principal";
                end;

                ExpectedAmt := 0;
                DefAmount := 0;
                AmtPaid := 0;
                DefAmount := 0;
                DaysInArrear := 0;
                ArrearsDate := 0D;
                MDef := 0;
                LoansInterest := 0;

                //SaccoActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePeriod);

                MDef := SaccoActivities.GetMonthsInDefault(Loans."Loan No.", AsAt, GracePeriod, DefAmount);

                MDef := ROUND(MDef, 1, '=');

                DaysInArrear := ROUND(MDef * 30, 1, '=');

                InterestArrears := SaccoActivities.GetInterestArrears(Loans."Loan No.", AsAt);

                LoansInterest := SaccoActivities.GetInterestAmountMobile(Loans."Loan No.", AsAt, false);

                Loans."Schedule Balance" := GetScheduleBalanceAsAt(AsAt);

                if (Loans."Outstanding Principal" + Loans."Outstanding Interest") <= 0 then
                    CurrReport.Skip();

                case DaysInArrear of
                    0:
                        Loans."Loans Category-SASRA" := Loans."Loans Category-SASRA"::Performing;

                    1 .. 30:
                        Loans."Loans Category-SASRA" := Loans."Loans Category-SASRA"::Watch;

                    31 .. 180:
                        Loans."Loans Category-SASRA" := Loans."Loans Category-SASRA"::Substandard;

                    181 .. 360:
                        Loans."Loans Category-SASRA" := Loans."Loans Category-SASRA"::Doubtful;

                    else
                        Loans."Loans Category-SASRA" := Loans."Loans Category-SASRA"::Loss;
                end;

            end;

            trigger OnPreDataItem()
            var
                DateFilter: Text;
            begin
                DateFilter := GetFilter("Date Filter");

                if AsAt = 0D then begin
                    if DateFilter <> '' then
                        AsAt := GetRangeMax("Date Filter")
                    else
                        AsAt := Today;
                end;

                //date filter-mwende
                if DateFilter = '' then
                    SetFilter("Date Filter", '..%1', AsAt);
                SetFilter("Disbursement Date", '..%1', AsAt);
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
        PartialAmt: Decimal;
        DaysInArrear: Integer;
        MDef: Decimal;
        DefAmount: Decimal;
        CompanyInfo: Record "Company Information";
        LoanLookup: Record Loans;
        SavAcc: Record "Savings Accounts";
        Deposit: Decimal;
        Overpayment: Decimal;
        InterestArrears: Decimal;
        LoansInterest: Decimal;
        PRepayment: Decimal;
        GenSetUp: Record "Sacco Setup";
        PartialDisbHeader: Record "Partial Loans Disb. Header";
        PartialDisbLine: Record "Partial Loans Disb. Lines";

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
