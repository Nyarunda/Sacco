
Report 50281 "Appraisal Repayment Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/AppraisalRepaymentSchedule.rdlc';

    dataset
    {
        dataitem(Loans; "Member Salary Appraisal")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(LInsurance; Loans.Insurance)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompLogo; CompInfo.Picture)
            {
            }
            column(LoanNo; Loans."Appraisal No.")
            {
            }
            column(LoanProductType; Loans."Loan Product Type")
            {
            }
            column(MemberNo; Loans."Member No.")
            {
            }
            column(ID_Number; "ID Number")
            {

            }
            column(ApprovedAmount; Loans."Recommended Amount")
            {
            }
            column(LoanAmt; LoanAmt)
            {
            }
            column(AnnualInterest; Loans."Annual Interest %")
            {
            }
            column(MemberName; Loans."Name")
            {
            }
            column(Installments; Loans.Period)
            {
            }
            column(DisbursementDate; Loans.Date)
            {
            }
            column(LoanProductTypeName; Loans."Loan Product Type")
            {
            }

            column(Monthly_Savings; Loans."BOSA Savings")
            {
            }
            column(Max__Monthly_Deduction; Loans."Max. Monthly Deduction")
            {

            }
            dataitem(Schedule; "Loan Repayment Schedule")
            {
                DataItemLink = "Loan No." = field("Appraisal No.");
                column(ReportForNavId_11; 11)
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
                column(LineNo; Schedule."Line No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                LoanAmt := Loans."Recommended Amount";
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", Loans."Appraisal No.");
                LoanRepaymentSchedule.SetFilter("Loan Amount", '>0');
                if LoanRepaymentSchedule.FindFirst then
                    LoanAmt := LoanRepaymentSchedule."Loan Amount";
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
}

