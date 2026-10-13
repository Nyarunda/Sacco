/// <summary>
/// Report Loan Repay Schedule Full Date (ID 50597).
/// </summary>
Report 50597 "Loan Repay Schedule Full Date"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Repayment Schedule Full Date.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompLogo; CompInfo.Picture)
            {
            }
            column(LoanNo; Loans."Loan No.")
            {
            }
            column(LoanProductType; Loans."Loan Product Type")
            {
            }
            column(Deposit_COntribution; "Deposit COntribution")
            { }
            column(Total_Insurance; "Total Insurance")
            { }
            column(MemberNo; Loans."Member No.")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(LoanAmt; LoanAmt)
            {
            }
            column(ID_Number; "ID No.")
            {
            }
            column(AnnualInterest; Loans."Annual Interest %")
            {
            }
            column(MemberName; Loans."Member Name")
            {
            }
            column(Installments; Loans.Installments)
            {
            }
            column(Max_Monthly_Deduction; Loans.Repayment + Loans."Deposit COntribution" + Loans."Total Insurance")
            {
            }
            column(DisbursementDate; Loans."Disbursement Date")
            {
            }
            column(LoanProductTypeName; Loans."Loan Product Type Name")
            {
            }
            column(Loan_Interest_Repayment; "Loan Interest Repayment")
            {
            }
            column(MonthlyDep; MonthlyDep)
            {
            }
            column(MonthlyInterestUpfront; MonthlyInterest)
            {
            }
            column(Days; Days)
            {
            }
            dataitem(Schedule; "Loan Repayment Schedule")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                column(ReportForNavId_11; 11)
                {
                }
                column(Old_Repayment_Date; "Old Repayment Date")
                {
                }
                column(RepaymentDate; Schedule."Repayment Date")
                {
                }
                column(LoanAmount; Schedule."Loan Amount")
                {
                }
                column(MonthlyPrincipal; Schedule."Monthly Principal")
                {
                }
                column(MonthlyInterest; Schedule."Monthly Interest")
                {
                }
                column(MonthlyAppraisal; Schedule."Monthly Appraisal")
                {
                }
                column(MonthlyRepayment; Schedule."Monthly Repayment")
                {
                }
                column(LoanBalance; Schedule."Loan Balance")
                {
                }
                column(Insurance_Contribution; "Insurance Contribution")
                { }
                column(Schedule_Deposit_Contribution; "Deposit Amount")
                { }
                column(LineNo; Schedule."Line No.")
                {
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

                end;
            }

            trigger OnAfterGetRecord()
            begin

                LoanAmt := Loans."Approved Amount";
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
                LoanRepaymentSchedule.SetFilter("Loan Amount", '>0');
                if LoanRepaymentSchedule.FindFirst then begin
                    LoanAmt := LoanRepaymentSchedule."Loan Amount";
                end;
                //MonthlyDep := 1600 + Loans.Repayment;

                /*
                MonthlyInterest := 0;
                TDays := 0;
                EndMonth := 0D;
                Days := 0;

                 if Loans."Schedule Start Date" > Loans."Repayment Start Date" then begin

                    MonthlyInterest := ROUND(Loans."Amount To Disburse" * Loans."Annual Interest %" / 1200, 0.01, '=');
                    //Repayment Start
                    EndMonth := CalcDate('CM', Loans."Schedule Start Date");
                    TDays := Date2dmy(EndMonth, 1);
                    Days := Date2dmy(Loans."Schedule Start Date", 1) - Date2dmy(Loans."Repayment Start Date", 1) + 1;
                    MonthlyInterest := ROUND(MonthlyInterest * Days / TDays);

                end; */
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        LoanAmt: Decimal;
        MonthlyDep: Decimal;
        TotalExpected: Decimal;
        TDays: Integer;
        Days: Integer;
        EndMonth: Date;
        MonthlyInterest: Decimal;

}

