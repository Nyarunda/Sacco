namespace CentralDB.CentralDB;
using Microsoft.Foundation.Company;

report 50433 "Loan Defaulter Recovery"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Defaulter Recovery.rdlc';
    Caption = 'Loan Defaulter Recovery';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(DefaulterLoanRecovery; "Defaulter Loan Recovery")
        {
            DataItemTableView = where(Recovered = const(true));
            column(No; "No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Name; Name)
            {
            }
            column(TotalDeductionLoans; "Total Deduction Loans")
            {
            }
            column(TotalDeductionSavings; "Total Deduction Savings")
            {
            }
            column(Status; Status)
            {
            }
            column(Description; Description)
            {
            }
            column(EnteredBy; "Entered By")
            {
            }
            column(Recovered; Recovered)
            {
            }
            column(Picture; Company.Picture)
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            dataitem(DefaulterRecoveryBuffer; "Defaulter Recovery Buffer")
            {
                DataItemLink = "Header No." = field("No.");
                DataItemTableView = where("Credit Amount" = filter(< 0));

                column(Buffer_LoanNo; DefaulterRecoveryBuffer."Loan No")
                {
                }
                column(Buffer_AccNo; DefaulterRecoveryBuffer."Account No.")
                {
                }
                column(Buffer_Transacion; DefaulterRecoveryBuffer."Transaction Type")
                {
                }
                column(Buffer_MemberNo; DefaulterRecoveryBuffer."Member No.")
                {
                }
                column(Buffer_Amount; DefaulterRecoveryBuffer.Amount * -1)
                {
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    // if DefaulterRecoveryBuffer."Loan No" = '' then CurrReport.Skip();
                end;
            }

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(Source; DefaulterLoanRecovery.Source)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        Company.Get;
        Company.CalcFields(Company.Picture);
    end;

    var
        MemberBiodata: Text;
        Company: Record "Company Information";
}

