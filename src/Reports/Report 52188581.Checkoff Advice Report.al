
Report 50244 "Checkoff Advice Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Checkoff Advice Report.rdlc';

    dataset
    {
        dataitem("Monthly Advice"; "Monthly Advice")
        {
            RequestFilterFields = "No.";
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
            column(EmployerCode_CheckoffAdviceHeader; "Employer Code")
            {
            }
            column(EmployerName_CheckoffAdviceHeader; "Monthly Advice"."Employer Account No.")
            {
            }
            column(EndDate_CheckoffAdviceHeader; "Advice Date")
            {
            }
            column(Period_CheckoffAdviceHeader; "Monthly Advice".Period)
            {
            }

            trigger OnAfterGetRecord()
            begin

                AdvDate := "Monthly Advice"."Advice Date";
                EmpCode := "Monthly Advice"."Employer Code";
            end;

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
        }

        actions
        {
        }
    }

    labels
    {
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

