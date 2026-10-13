namespace UnitedWomen.UnitedWomen;
using Microsoft.Foundation.Company;

report 50567 "Loan Repayment Schedule Prev"
{
    ApplicationArea = All;
    Caption = 'Loan Repayment Schedule Prev';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/LoanRepaymentPrev.rdlc';

    dataset
    {
        dataitem(LoanChanges; "Loan Changes")
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
            column(LoanNo; LoanChanges."Loan No.")
            {
            }
            column(LoanProductType; LoanChanges."Loan Product Type")
            {
            }
            column(Deposit_COntribution; LoanChanges."Deposit Contribution")
            { }
            column(Total_Insurance; LoanChanges."Insurance Amount")
            { }
            column(MemberNo; LoanChanges."Member No.")
            {
            }
            column(ApprovedAmount; LoanChanges."New Loan Amount")
            {
            }
            column(LoanAmt; LoanAmt)
            {
            }
            column(ID_Number; '')
            {
            }
            column(AnnualInterest; LoanChanges."Interest Rate")
            {
            }
            column(MemberName; LoanChanges."Member Name")
            {
            }
            column(Installments; LoanChanges."New Installments")
            {
            }
            column(Max_Monthly_Deduction; LoanChanges."New Repayment" + LoanChanges."Deposit Contribution" + LoanChanges."Insurance Amount")
            {
            }
            column(DisbursementDate; LoanChanges."Rescheduling Date")
            {
            }
            column(LoanProductTypeName; LoanChanges."Loan Product Type Name")
            {
            }
            column(Loan_Interest_Repayment; 0)
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
            dataitem(Schedule; "Loan Repayment Schedule II")
            {
                DataItemLink = "Loan No." = field("No.");
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
                column(MonthlyDeposit_Amount; "Deposit Amount")
                {
                }
                column(LineNo; Schedule."Line No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin



                LoanAmt := LoanChanges."New Loan Amount";
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoanChanges."No.");
                LoanRepaymentSchedule.SetFilter("Loan Amount", '>0');
                if LoanRepaymentSchedule.FindFirst then begin
                    LoanAmt := LoanRepaymentSchedule."Loan Amount";

                    if LoanChanges."New Installments" = 0 then
                        LoanChanges."New Installments" := LoanRepaymentSchedule.Count()
                end;
                //MonthlyDep := 1600 + LoanChanges."New Repayment";

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
        LoanRepaymentSchedule: Record "Loan Repayment Schedule II";
        LoanAmt: Decimal;
        MonthlyDep: Decimal;
        TotalExpected: Decimal;
        TDays: Integer;
        Days: Integer;
        EndMonth: Date;
        MonthlyInterest: Decimal;

}
