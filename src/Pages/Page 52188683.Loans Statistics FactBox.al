
Page 50346 "Loans Statistics FactBox"
{
    ApplicationArea = All;
    Caption = 'Loans Statistics';
    PageType = CardPart;
    SourceTable = Loans;

    layout
    {
        area(content)
        {
            group("Loan Details")
            {
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(LoanProductType; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedAmount; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            group(CurrentLoan)
            {
                Caption = 'Current Loan';
                field(OutstandingPenalty; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                    //DrillDownPageId = "Loan Ledger Entries";
                }
                field("Outstanding Insurance"; Rec."Outstanding Insurance")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    //DrillDownPageId = "Loan Ledger Entries";
                }

                field(PrincipalArrears; Rec."Principal Arrears")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Arrears"; Rec."Interest Arrears")
                {
                    ApplicationArea = basic;
                }
                field(TotalArrears; Rec."Total Arrears")
                {
                    ApplicationArea = Basic;
                }
                field(ArrearsMonths; ArrearsMonths)
                {
                    ApplicationArea = Basic;
                    Caption = 'Months in Arrears';
                    Style = Unfavorable;
                    StyleExpr = ArrearsMonths > 0;
                }
                field(OutstandingPrincipal; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                    //DrillDownPageId = "Loan Ledger Entries";
                }
                field("Current Month Repayment"; TotalRepayments)
                {
                    ApplicationArea = Basic;
                }
                field(TotalOutstandingBalance; Rec."Total Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    //DrillDownPageId = "Loan Ledger Entries";

                    trigger OnDrillDown()
                    begin
                        ShowDetails;
                    end;
                }
            }
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
                field(TotalPrincipalRepayment; TotalPrincipalRepayment)
                {
                    ApplicationArea = Basic;
                }
                field("Total  Arrears"; AllBills)
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = AllBills > 0;
                }
                field("Total Loan Balance"; AllLoanBalance)
                {
                    ApplicationArea = Basic;
                }
                field(TotalContribution; TotalContirbution)
                {
                }
                field("Total Current Repayment"; AllPenalty + TotalPrincipalArrears + AllInterest + TotalContirbution)
                {
                    ApplicationArea = Basic;
                }
                field("Total Outstanding - All"; TLoans)
                {
                    Visible = false;
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
        CalcValues(Rec."Loan No.");
        TotalRepayments := SaccoActivities.GetCurrentMonthlyRepayment(Rec."Loan No.");

        //if TotalRepayments = 0 then
        //TotalRepayments := Rec."Total Arrears";

        if TotalPrincipalRepayment = 0 then
            TotalPrincipalRepayment := Rec."Total Arrears";
    end;

    var
        Text000: label 'Overdue Amounts (LCY) as of %1';
        ProdType: Record "Product Setup";
        MinBalance: Decimal;
        PeriodicActivities: Codeunit "Member Activities";
        AvailBalance: Decimal;
        AllPenalty: Decimal;
        AllInsurance: Decimal;
        AllAppraisal: Decimal;
        AllInterest: Decimal;
        AllBills: Decimal;
        AllLoanBalance: Decimal;
        ArrearsMonths: Integer;
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
        TotalPrincipalRepayment: Decimal;
        TotalContirbution: Decimal;
        ShareCpital: Decimal;
        Deposits: Decimal;
        GFE: Decimal;
        TotalRepayments: Decimal;
        LSchedule: Record "Loan Repayment Schedule";
        CachedLoanNo: Code[20];
        CachedMonthStart: Date;
        CachedMonthEnd: Date;
        CachedTotalRepayments: Decimal;

    local procedure ShowDetails()
    begin
        Page.Run(Page::"Loan Posted Card", Rec);
    end;

    /*   local procedure GetCurrentMonthlyRepayment(): Decimal
      var
          MonthStart: Date;
          MonthEnd: Date;
          ExpectedAmt: Decimal;
          AmtPaid: Decimal;
          DefAmount: Decimal;
          DaysInArrear: Integer;
          ArrearsDate: Date;
          AsAt: Date;
          MDef: decimal;
          LSchedule: Record "Loan Repayment Schedule";
          Loan: Record Loans;
          GracePeriod: DateFormula;
          MonthlyPrincipal: Decimal;
          OutstandingInterest: Decimal;
          OutstandingInsurance: Decimal;
          DepositContribution: Decimal;
      begin
          MonthStart := CalcDate('<-CM>', Today);
          MonthEnd := CalcDate('<CM>', Today);


          if (CachedLoanNo = Rec."Loan No.") and
             (CachedMonthStart = MonthStart) and
             (CachedMonthEnd = MonthEnd)
          then
              exit(CachedTotalRepayments);

          CachedLoanNo := Rec."Loan No.";
          CachedMonthStart := MonthStart;
          CachedMonthEnd := MonthEnd;
          CachedTotalRepayments := 0;

          ExpectedAmt := 0;
          AmtPaid := 0;
          DefAmount := 0;
          DaysInArrear := 0;
          ArrearsDate := 0D;
          MDef := 0;


          LSchedule.Reset();
          LSchedule.SetRange("Loan No.", Rec."Loan No.");
          LSchedule.SetFilter("Repayment Date", '%1..%2', MonthStart, MonthEnd);
          if LSchedule.FindFirst() then
              MonthlyPrincipal := LSchedule."Monthly Principal";

          Loan.Reset();
          Loan.SetRange("Loan No.", Rec."Loan No.");
          if Loan.FindFirst() then begin
              Loan.SetFilter("Date Filter", '%1..%2', MonthStart, MonthEnd);
              Loan.CalcFields("Outstanding Interest", "Outstanding Insurance");
              OutstandingInterest := Loan."Outstanding Interest";
              OutstandingInsurance := Loan."Outstanding Insurance";
              DepositContribution := Loan."Deposit COntribution";
          end;

          CachedTotalRepayments := MonthlyPrincipal + OutstandingInterest + OutstandingInsurance + DepositContribution;

          if CachedTotalRepayments < 0 then
              CachedTotalRepayments := 0;

          exit(CachedTotalRepayments);
      end;
   */
    local procedure CalcValues(LoanNo: Code[20])
    var
        Loan: record Loans;
    begin
        AllAppraisal := 0;
        AllBills := 0;
        AllInterest := 0;
        AllLoanBalance := 0;
        AllPenalty := 0;
        AllInsurance := 0;
        Deposits := 0;
        GFE := 0;
        ShareCpital := 0;
        TotalPrincipalRepayment := 0;
        TotalContirbution := 0;


        AppraisalToDate := 0;
        InterestToDate := 0;
        BillToDate := 0;

        TAppraisalToDate := 0;
        TInterestToDate := 0;
        TBillToDate := 0;
        TLoans := 0;

        ArrearsMonths := 0;

        //SETFILTER("Date Filter",'..%1',TODAY);
        Rec.CalcFields("Total Arrears", "SASRA Months Arrears", "Outstanding Appraisal", "Outstanding Interest", "Schedule Interest", "Interest Paid", "Outstanding Insurance");


        Loan.Reset;
        Loan.SetRange("Member No.", Rec."Member No.");
        Loan.SetFilter("Total Outstanding Balance", '<>%1', 0);
        if LoanNo <> '' then
            Loan.SetRange("Loan No.", LoanNo);
        if Loan.FindFirst then begin
            repeat
                Loan.CalcFields("Outstanding Appraisal", "Outstanding Penalty", "Outstanding Interest", "Total Arrears", "Outstanding Principal");
                Loan.CalcFields("Total Outstanding Balance", "Principal Arrears", "Outstanding Insurance", "SASRA Months Arrears");


                BillAmt := Loan."Total Arrears";

                ArrearsMonths += Loan."SASRA Months Arrears";

                if BillAmt < 0 then
                    BillAmt := 0;


                AllAppraisal += Loan."Outstanding Appraisal";
                AllBills += Loan."Total Arrears";
                AllInterest += Loan."Outstanding Interest";
                AllLoanBalance += Loan."Outstanding Principal";
                AllPenalty += Loan."Outstanding Penalty";
                AllInsurance += Loan."Outstanding Insurance";
                TLoans += Loan."Total Outstanding Balance";
                TotalPrincipalRepayment += Loan."Loan Principle Repayment";
                TotalPrincipalArrears += Loan."Principal Arrears";

                TAppraisalToDate += AppAmt;
                TInterestToDate += IntAmount;
                TBillToDate += BillAmt;


            until Loan.Next = 0;
        end;

        SaccoActivities.GetMonthlyRepayment(Rec."Member No.", Deposits, ShareCpital, GFE);
        TotalContirbution += Deposits + ShareCpital + GFE;
    end;
}
