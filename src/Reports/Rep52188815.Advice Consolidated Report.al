namespace Wanandage.Wanandage;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Company;

report 50497 "Advice Consolidated Report"
{
    Caption = 'Advice Consolidated Report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Advice Consolidated Report.rdl';
    dataset
    {
        dataitem("Monthly Advice Header"; "Monthly Advice Header")
        {
            RequestFilterFields = "No.", "Employer Code", "Date Entered";
            dataitem("Monthly Advice"; "Checkoff Report Buffer")
            {
                DataItemLink = "Advice Header No." = field("No.");

                column(EnteredBy; MAdvice."Entered By")
                {
                }
                column(DateEntered; DateEntered) { }

                column(AdvDate; AdvDate) { }

                column(No_; MAdvice."No.")
                {
                }
                column(Line_No_; "Line No.")
                {
                }
                column(EmployerName; CompanyName)
                {
                }
                column(Ref; Ref)
                {
                }
                column(Address; Address)
                {
                }
                column(Address2; Address2)
                {
                }
                column(Current_Balance; "Current Balance")
                {
                }
                column(Change_Balance; "Change Balance")
                {
                }
                column(Cummulative_Contribution; "Cummulative Contribution")
                {
                }
                column(ReportForNavId_1; 1)
                {
                }
                column(Payroll_No; "Payroll No")
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
                column(Principal; Principal)
                {
                }
                column(Interest; Interest)
                {
                }
                column(Advice_Type; "Advice Type")
                {
                }
                column(Advice_Source; "Advice Source")
                {
                }
                column(LineDescription; Description)
                {
                }
                column(Member_No_; "Member No.")
                {
                }
                column(ID_No_; "ID No.")
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
                column(Schedule_Balance; "Schedule Balance")
                {
                }
                column(Amount; Amount)
                {
                }

                column(Product_Name; "Product Name")
                {
                }
                column(Product_Type; "Product Type")
                {
                }
                column(CompanyName; Company.Name)
                {
                }
                column(CompanyPicture; Company.Picture)
                {
                }
                column(City; Cust.City)
                {
                }
                column(CustName; Cust.Name)
                {
                }
                column(SNo; SNo)
                {
                }
                column(EmployerCode_CheckoffAdviceHeader; "Employer Code")
                {
                }
                column(EmployerName_CheckoffAdviceHeader; "Monthly Advice"."Employer Account No.")
                {
                }
                column(EName; MAdvice."Employer Name")
                {
                }
                column(Description; MAdvice.Description)
                {
                }
                column(EndDate_CheckoffAdviceHeader; "Advice Date")
                {
                }
                column(Period_CheckoffAdviceHeader; "Monthly Advice"."Loan Period")
                {
                }
                column(CurrentMonthName; CurrentMonthName)
                {
                }
                trigger OnAfterGetRecord()
                var
                    MA: Record "Monthly Advice";
                begin
                    SNo := SNo + 1;
                    AdvDate := "Monthly Advice"."Advice Date";
                    EmpCode := "Monthly Advice"."Employer Code";
                    MAdvice.get("Advice Header No.");
                    Cust.get(EmpCode);
                    CompanyName := Cust.name;
                    Address := Cust.address;
                    Address2 := Cust."Address 2";
                    DateEntered := MAdvice."Date Entered";
                    Ref := MAdvice.Description;
                    //Description := "Monthly Advice"."Product Type";
                    //"Advice Type" := "Monthly Advice"."Product Name";


                    MA.Reset();
                    MA.SetRange("Payroll No", "Monthly Advice"."Payroll No");
                    if MA.FindFirst() then begin
                        SNo := 1
                    end else
                        SNo := SNo + 1;




                end;


                trigger OnPreDataItem()
                begin

                    SNo := 0;

                    Company.Get;
                    Company.CalcFields(Picture);
                    Company.Name := UpperCase(Company.Name);

                end;

                trigger OnPostDataItem()
                begin

                end;
            }

            trigger OnAfterGetRecord()
            var
                MA: Record "Monthly Advice";
                AdviceBuffer: Record "Checkoff Report Buffer";
                SaccoActivities: Codeunit "Sacco Activities";
            begin
                AdviceBuffer.Reset();
                AdviceBuffer.SetRange("Advice Header No.", "Monthly Advice Header"."No.");
                if AdviceBuffer.FindFirst() then
                    AdviceBuffer.DeleteAll();

                SaccoActivities.ConsolidateCheckoffAdvice("Monthly Advice Header");

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

    var

        SearchYear: date;
        SearchDate: date;
        CurrentMonthName: Text;
        Memb: Record Members;
        Cust: Record Customer;
        ProductFactory: Record "Product Setup";
        Loans: Record Loans;
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
        Address: Text;
        Address2: Text;
        CompanyName: Text;
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
        DateEntered: Date;
        EmpCode: Code[20];
        MAdvice: Record "Monthly Advice Header";
        SNo: Decimal;
        Ref: Code[100];
}


