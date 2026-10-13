namespace AL_.AL_;
using Microsoft.Sales.Customer;

report 50477 "Update Loans Schedule"
{
    ApplicationArea = All;
    Caption = 'Update Loans Schedule';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Outstanding Principal" = filter('>0')/* , "Mobile Loan" = const(false) */);
            trigger OnAfterGetRecord()
            var
                LSchedule: Record "Loan Repayment Schedule";
                D: Integer;
                M: Integer;
                Y: Integer;
                SDate: Date;
                LoanPaymentDate: Date;
                NewRepaymentDate: Date;
                NewRepaymentDate2: Date;

                Cust: Record Customer;
                SaccoActivities: Codeunit "Sacco Activities";
            begin
                SaccoActivities.GenerateRepaymentScheduleOldLoans(Loans);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
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
}
