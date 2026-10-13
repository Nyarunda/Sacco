namespace CentralDB.CentralDB;
using Microsoft.Foundation.Company;

report 50434 "Checkoff Advice Summary"
{
    Caption = 'Checkoff Advice Summary';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Checkoff Advice Summary.rdlc';

    dataset
    {
        dataitem(MonthlyAdviceHeader; "Monthly Advice Header")
        {
            RequestFilterFields = "No.";
            column(CompanyName; Company.Name)
            {
            }
            column(CompanyPicture; Company.Picture)
            {
            }
            column(EmployerCode_CheckoffAdviceHeader; "Employer Code")
            {
            }
            column(EmployerName_CheckoffAdviceHeader; "Monthly Advice"."Employer Account No.")
            {
            }
            column(EndDate_CheckoffAdviceHeader; "End Date")
            {
            }
            column(Period_CheckoffAdviceHeader; FORMAT("End Date", 0, '<Month Text>'))
            {
            }
            dataitem("Monthly Advice"; "Monthly Advice")
            {
                DataItemLink = "Advice Header No." = field("No.");
                column(ReportForNavId_2; 2)
                {
                }
                column(Loan_Balance; "Loan Balance")
                {
                }
                column(Amount_On; "Amount On")
                {
                }
                column(Amount_Off; "Amount Off")
                {
                }
                column(Advice_Type; "Advice Type")
                {
                }
                column(Member_No_; "Member No.")
                {
                }
                column(Account_No_; "Account No.")
                {
                }
                column(Name; Name)
                {
                }
                column(Loan_No_; "Loan No.")
                {
                }
                column(Amount; Amount)
                {
                }
                column(ID_No_; "ID No.")
                {
                }


                trigger OnAfterGetRecord()

                begin

                    AdvDate := "Monthly Advice"."Advice Date";
                    EmpCode := "Monthly Advice"."Employer Code";
                    Amount += "Monthly Advice".Amount;
                    Name := "Monthly Advice".Name;
                    MemberNo := "Monthly Advice"."Member No.";

                end;
            }
            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Picture);
            end;
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

    var
        ProductFactory: Record "Product Setup";
        Loans: Record Loans;
        Cust: Record Members;
        ClolumHeader: Code[10];
        ColumnValue: Decimal;
        MemberNo: Code[10];
        PayrollNo: Code[10];
        Name: Text;
        Interest: Decimal;
        Amount: Decimal;
        Turn: Integer;
        CulumnA: array[50] of Code[10];
        Company: Record "Company Information";
        i: Integer;
        EDcode: Code[10];
        SaccoCode: Code[10];
        NarationCode: Text;
        IntCode: Integer;
        ActionCode: Code[10];
        TransCode: Integer;
        ChAdvice: Record "Monthly Advice";
        AccCont: Decimal;
        AccBalance: Decimal;
        HeaderNo: Code[20];
        TCont: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        SDate: Date;
        EDate: Date;
        AdvDate: Date;
        EmpCode: Code[20];

}
