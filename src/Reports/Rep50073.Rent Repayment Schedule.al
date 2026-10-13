namespace UnitedWomen_Production.UnitedWomen_Production;
using Microsoft.Foundation.Company;
using Microsoft.Sales.Customer;

/// <summary>
/// Report Loan Repayment Schedule (ID 50079).
/// </summary>
report 50073 "Rent Repayment Schedule"
{
    Caption = 'Rent Repayment Schedule';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Rent Repayment Schedule.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Rent_Amount; "Rent Amount")
            {
            }
            column(Service_Charge; "Service Charge")
            {
            }
            column(Installments; Installments)
            {
            }
            column(Repayment_Startdate; "Repayment Startdate")
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompLogo; CompInfo.Picture)
            {
            }

            dataitem(Schedule; "Rent Repayment Schedule")
            {
                // DataItemTableView = sorting("line no.");
                DataItemLink = "Customer No." = field("No.");
                column(ReportForNavId_11; 11)
                {
                }
                column(RepaymentDate; Schedule."Repayment Date")
                {
                }
                column(LoanAmount; Schedule."Rent Amount")
                {
                }
                column(MonthlyPrincipal; Schedule."Monthly Principal")
                {
                }
                column(MonthlyInterest; Schedule."Monthly Charges")
                {
                }
                column(MonthlyRepayment; Schedule."Monthly Repayment")
                {
                }
                column(LoanBalance; Schedule."Rent Balance")
                {
                }
                column(LineNo; Schedule."Line No.")
                {
                }
                column(VAT; Schedule."VAT Amt")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Customer No.", Customer."No.");
                if LoanRepaymentSchedule.FindFirst then begin
                    LoanAmt := LoanRepaymentSchedule."Rent Amount";
                end;

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
        LoanRepaymentSchedule: Record "Rent Repayment Schedule";
        LoanAmt: Decimal;
        MonthlyDep: Decimal;
        TotalExpected: Decimal;
        TDays: Integer;
        Days: Integer;
        EndMonth: Date;
        MonthlyInterest: Decimal;

}


