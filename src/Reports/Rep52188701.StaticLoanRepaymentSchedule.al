report 50364 "Static Loan Repayment Schedule"
{
    ApplicationArea = All;
    Caption = 'Loan Repayment Schedule Partial';

    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    //ProcessingOnly = true;
    RDLCLayout = './src/Layouts/Static Repayment Schedule.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = filter(true));
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
            column(MemberNo; Loans."Member No.")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(LoanAmt; LoanAmt)
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
            column(DisbursementDate; Loans."Disbursement Date")
            {
            }
            column(LoanProductTypeName; Loans."Loan Product Type Name")
            {
            }
            dataitem(Schedule; "Loan Repayment Schedule II")
            {
                DataItemLink = "Loan No." = field("Loan No.");
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
                column(MonthlyDeposit; Schedule."Deposit Amount")
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
            var
                SActivities: Codeunit "Sacco Activities";
            begin
                /* SActivities.GenerateRepaymentScheduleII(Loans);
                LoanAmt := Loans."Approved Amount";
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
                LoanRepaymentSchedule.SetFilter("Loan Amount", '>0');
                if LoanRepaymentSchedule.FindFirst then begin
                    LoanAmt := LoanRepaymentSchedule."Loan Amount";
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
        LoanRepaymentSchedule: Record "Loan Repayment Schedule II";
        LoanAmt: Decimal;


}
