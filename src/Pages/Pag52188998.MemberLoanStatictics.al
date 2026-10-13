namespace CentralDB.CentralDB;

page 50700 "Member Loan Statictics"
{
    ApplicationArea = All;
    Caption = 'Member Loan Statistics';
    PageType = CardPart;
    SourceTable = Loans;

    layout
    {
        area(content)
        {
            group("All Member Loans")
            {
                Caption = 'All Member Loans';
                field("Total Penalty"; AllPenalty)
                {
                    ApplicationArea = Basic;
                }
                field("Total Insurance"; AllInsurance)
                {
                    ApplicationArea = Basic;
                }
                field("Total Out. Interest"; AllInterest)
                {
                    ApplicationArea = Basic;
                }
                field("Total Principal Balance"; AllLoanBalance)
                {
                    ApplicationArea = Basic;
                }
                field(TotalPrincipalRepayment; TotalPrincipalArrears)
                {
                    ApplicationArea = Basic;
                }
                field("Total  Arrears"; AllBills)
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = AllBills > 0;
                }
                field("Months in Arrears"; ArrearsMonth)
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = ArrearsMonth > 0;
                }
                field(TotalContribution; TotalContribution)
                {
                    ApplicationArea = Basic;
                    Caption = 'Monthly Contribution';
                }
                field("Current Month Repayment"; CurrentMonthRepayment)
                {
                    ApplicationArea = Basic;
                }
                field("Total Loan"; AllLoanBalance + AllAppraisal + AllInsurance + AllInterest + AllPenalty)
                {
                    Visible = true;
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalcValues;
    end;

    var
        Text000: label 'Overdue Amounts (LCY) as of %1';
        ProdType: Record "Product Setup";
        MinBalance: Decimal;
        PeriodicActivities: Codeunit "Member Activities";
        AvailBalance: Decimal;
        AllPenalty: Decimal;
        AllAppraisal: Decimal;
        AllInsurance: Decimal;
        AllInterest: Decimal;
        AllBills: Decimal;
        AllLoanBalance: Decimal;
        Loans: Record Loans;
        ArrearsMonth: Integer;
        AppFee: Decimal;
        TAppFee: Decimal;
        AppAmt: Decimal;
        InterestPaid: Decimal;
        IntAmount: Decimal;
        TIntAmount: Decimal;
        Int: Decimal;
        AppraisalToDate: Decimal;
        InterestToDate: Decimal;
        BillToDate: Decimal;
        TAppraisalToDate: Decimal;
        TInterestToDate: Decimal;
        TBillToDate: Decimal;
        TLoans: Decimal;
        BillAmt: Decimal;
        SaccoActivities: Codeunit "Sacco Activities";
        TotalPrincipalArrears: Decimal;
        MonthlyRepayment: Decimal;
        TotalContribution: Decimal;
        CurrentMonthRepayment: Decimal;
        LSchedule: Record "Loan Repayment Schedule";
        ShareCpital: Decimal;
        Deposits: Decimal;
        GFE: Decimal;

    local procedure ShowDetails()
    begin
        Page.Run(Page::"Member Account Card", Rec);
    end;


    local procedure CalcValues()
    begin
        AllAppraisal := 0;
        AllBills := 0;
        AllInterest := 0;
        AllLoanBalance := 0;
        AllPenalty := 0;
        Deposits := 0;
        GFE := 0;
        ShareCpital := 0;


        AppraisalToDate := 0;
        InterestToDate := 0;
        BillToDate := 0;

        TAppraisalToDate := 0;
        TInterestToDate := 0;
        TBillToDate := 0;
        AllInsurance := 0;
        ArrearsMonth := 0;
        AllInterest := 0;
        TLoans := 0;
        MonthlyRepayment := 0;
        TotalPrincipalArrears := 0;
        TotalContribution := 0;
        CurrentMonthRepayment := 0;

        //SETFILTER("Date Filter",'..%1',TODAY);
        Rec.CalcFields("Total Arrears", "SASRA Months Arrears", "Outstanding Appraisal", "Outstanding Interest", "Schedule Interest", "Interest Paid", "Outstanding Insurance");


        Loans.Reset;
        Loans.SetRange("Member No.", Rec."Member No.");
        Loans.SetFilter("Total Outstanding Balance", '>0');
        if Loans.FindFirst then begin
            repeat
                Loans.CalcFields("Outstanding Appraisal", "Outstanding Insurance", "Outstanding Penalty", "SASRA Months Arrears", "Outstanding Penalty", "Total Outstanding Balance", "Principal Arrears", "Outstanding Interest", "Total Arrears", "Outstanding Principal");


                BillAmt := Loans."Total Arrears";

                if BillAmt < 0 then
                    BillAmt := 0;


                AllAppraisal += Loans."Outstanding Appraisal";
                AllInsurance += Loans."Outstanding Insurance";
                AllBills += Loans."Total Arrears";
                ArrearsMonth += Loans."SASRA Months Arrears";
                AllInterest += Loans."Outstanding Interest";
                AllLoanBalance += Loans."Outstanding Principal";
                AllPenalty += Loans."Outstanding Penalty";
                TLoans += Loans."Total Outstanding Balance";
                TotalPrincipalArrears += Loans."Principal Arrears" + Loans."Loan Principle Repayment";
                if SaccoActivities.GetCurrentMonthlyRepayment(Loans."Loan No.") > 0 then
                    CurrentMonthRepayment += SaccoActivities.GetCurrentMonthlyRepayment(Loans."Loan No.")
                else
                    CurrentMonthRepayment += Loans."Total Arrears";


                TAppraisalToDate += AppAmt;
                TInterestToDate += IntAmount;
                TBillToDate += BillAmt;


            until Loans.Next = 0;
        end;

        SaccoActivities.GetMonthlyRepayment(Rec."Member No.", Deposits, ShareCpital, GFE);
        TotalContribution := Deposits + ShareCpital + GFE;
    end;
}
