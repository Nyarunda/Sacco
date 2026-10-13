report 50429 "Expected vs Received"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Expected vs Received.rdlc';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Member Status", "Branch Code", "Registration Date";
            column(CompanyName_TransactionSummary; COMPANYNAME)
            {
            }
            column(Today_TransactionSummary; FORMAT(TODAY, 0, 4))
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(LoanRepayment; LoanRepayment)
            {
            }
            column(MonthlyRepaymentPaid; MonthlyRepaymentPaid)
            {
            }
            column(TotalActual; TotalActual)
            {
            }
            column(ActualPaid; ActualPaid)
            {
            }
            column(Variance; TotalActual - ActualPaid)
            {
            }
            column(Balance; Balance)
            {
            }
            column(IntDue; IntDue)
            {
            }
            column(IntPaid; IntPaid)
            {
            }
            column(RepVariance; LoanRepayment - MonthlyRepaymentPaid)
            {
            }
            column(IntVariance; IntDue - IntPaid)
            {
            }
            column(PenVariance; PenalltyDue - PenaltyPaid)
            {
            }
            column(PenalltyDue; PenalltyDue)
            {
            }
            column(PenaltyPaid; PenaltyPaid)
            {
            }
            column(MonthyDep; MonthyDep)
            {
            }
            column(TDed; TDed)
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF (ToDate = 0D) OR (FromDate = 0D) THEN
                    ERROR('Specify the date options');

                ActualPaid := 0;
                TotalBal := 0;
                Variance := 0;
                MonthlyRepaymentPaid := 0;
                LoanRepayment := 0;
                Repayment := 0;
                LAmount := 0;
                Balance := 0;
                TotalActual := 0;
                IntDue := 0;
                IntPaid := 0;
                PenalltyDue := 0;
                PenaltyPaid := 0;

                Loans.RESET;
                Loans.SETRANGE(Loans."Member No.", Members."No.");
                Loans.SETRANGE(Loans.Posted, TRUE);
                Loans.SETRANGE(Loans."Date Filter", 0D, CALCDATE('-1D', FromDate));
                Loans.SETFILTER(Loans."Outstanding Principal", '>0');
                IF Loans.FIND('-') THEN BEGIN
                    REPEAT
                        Loans.CALCFIELDS("Outstanding Interest", "Penalty Due");
                        IntDue := Loans."Outstanding Interest";
                        PenalltyDue := Loans."Penalty Due";


                        LRec.RESET;
                        LRec.SETRANGE("Loan No.", Loans."Loan No.");
                        LRec.SETRANGE("Date Filter", FromDate, ToDate);
                        IF LRec.FIND('-') THEN BEGIN
                            LRec.CALCFIELDS("Outstanding Principal", "Interest Paid", "Principal Paid", "Interest Due", "Penalty Due", "Penalty Paid");
                            IntDue += LRec."Interest Due";
                            IntPaid += LRec."Interest Paid";
                            PenalltyDue += LRec."Penalty Due";
                            LoanRepayment += LRec."Loan Principle Repayment";
                            MonthlyRepaymentPaid += LRec."Principal Paid";


                            TotalActual += (LRec."Loan Principle Repayment" + IntDue + PenalltyDue);
                            ActualPaid += (LRec."Principal Paid" + LRec."Interest Paid" + LRec."Penalty Paid");

                            LAmount := LAmount + Loans."Approved Amount";
                        END;

                    UNTIL Loans.NEXT = 0;
                END;


                Variance := TotalActual - ActualPaid;


                Loans.RESET;
                Loans.SETRANGE(Loans."Member No.", Members."No.");
                Loans.SETRANGE(Loans.Posted, TRUE);
                Loans.SETRANGE(Loans."Date Filter", 0D, ToDate);
                Loans.SETFILTER("Outstanding Principal", '>0');
                IF Loans.FIND('-') THEN BEGIN
                    REPEAT
                        Loans.CALCFIELDS("Outstanding Principal", "Interest Paid", "Principal Paid", "Interest Due");
                        Balance += Loans."Outstanding Principal";
                    UNTIL Loans.NEXT = 0;
                END;

                SAcc.RESET;
                SAcc.SETRANGE("Member No.", "No.");
                SAcc.SETRANGE("Date Filter", FromDate, ToDate);
                SAcc.SetAutoCalcFields("Balance (LCY)");
                IF SAcc.FIND('-') THEN BEGIN
                    MonthyDep := SAcc."Balance (LCY)";
                END;

                TotalMonthly := TotalMonthly + MonthyDep;

                TDed := ActualPaid + MonthyDep;
            end;

            trigger OnPreDataItem()
            begin
                //IF Loans.GETFILTER(Loans."Date Filter") <>'' THEN
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("From Date:"; FromDate)
                {
                    ApplicationArea =basic;
                }
                field("To Date:"; ToDate)
                {
                    ApplicationArea=basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        Header = 'Loan Repayment Summary';
        Period = 'Period Filter';
    }

    var
        Membr: Record Members;
        LoanSchedule: Record "Loan Repayment Schedule";
        Repayment: Decimal;
        ActualPaid: Decimal;
        Variance: Decimal;
        TotalBal: Decimal;
        MonthlyRepaymentPaid: Decimal;
        TotalActual: Decimal;
        LoanRepayment: Decimal;
        Balance: Decimal;
        LAmount: Decimal;
        DateFilterBF: Date;
        ToDate: Date;
        FromDate: Date;
        TotalVariance: Decimal;
        TotalActualPaid: Decimal;
        TotalLoanAmount: Decimal;
        TotalRepyment: Decimal;
        MonthyDep: Decimal;
        TotalMonthly: Decimal;
        Loans: Record Loans;
        IntDue: Decimal;
        IntPaid: Decimal;
        PenalltyDue: Decimal;
        PenaltyPaid: Decimal;
        TDed: Decimal;
        LRec: Record Loans;
        SAcc: Record "Savings Accounts";
}

