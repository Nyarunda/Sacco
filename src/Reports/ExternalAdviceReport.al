
Report 50310 "External Advice Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/External Advice Report.rdlc';

    dataset
    {
        dataitem("Monthly Advice"; "Monthly Advice")
        {
            DataItemTableView = sorting("sort order");
            RequestFilterFields = "No.";

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
            column(Advice_Type; "Advice Type")
            {
            }
            column(Advice_Source; "Advice Source")
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
            column(Schedule_Balance; "Schedule Balance")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Principal; Principal)
            {
            }
            column(Interest; "Monthly Advice".Interest)
            {
            }
            column(DDate; DDate)
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

                if Loans.Get("Loan No.") then
                    DDate := Loans."Disbursement Date";

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

                //SearchDate := CalcDate('CM', SearchDate);
                //SearchYear := CalcDate('CY', SearchDate);
                //CurrentMonthName := CopyStr(Format(SearchDate, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy(SearchDate, 3));


            end;

            trigger OnPostDataItem()
            begin

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
        DDate: Date;
        ClolumHeader: Code[10];
        ColumnValue: Decimal;
        MemberNo: Code[10];
        PayrollNo: Code[10];
        Name: Text;
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
        SaccoActivities: Codeunit "Sacco Activities";
}

