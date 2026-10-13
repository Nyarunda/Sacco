
Report 50307 "New Savings Advice - Std"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/New Savings Advice - Std.rdlc';

    dataset
    {
        dataitem("Monthly Advice"; "Monthly Advice")
        {
            RequestFilterFields = "No.";
            DataItemTableView = where("Loan No." = filter(''));

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
            column(Period_CheckoffAdviceHeader; "Monthly Advice"."Loan Period")
            {
            }
            column(Advice_Header_No_; "Advice Header No.") { }
            column(CustName; CustName) { }
            column(Ref; Ref) { }
            column(Line_No_; "Line No.") { }


            trigger OnAfterGetRecord()
            var
                MAHeader: Record "Monthly Advice Header";
            begin

                AdvDate := "Monthly Advice"."Advice Date";
                EmpCode := "Monthly Advice"."Employer Code";

                AdvDate := "Monthly Advice"."Advice Date";
                EmpCode := "Monthly Advice"."Employer Code";
                MAHeader.get("Advice Header No.");
                Cust.get(EmpCode);
                CustName := Cust.Name;

                DateEntered := MAHeader."Date Entered";
                Ref := MAHeader.Description;
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
        Ref: Text;
        CustName: Text;
        Interest: Decimal;
        Amount: Decimal;
        Turn: Integer;
        CulumnA: array[50] of Code[10];
        Company: Record "Company Information";
        i: Integer;
        EDcode: Code[10];
        SaccoCode: Code[10];
        DateEntered: date;
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

