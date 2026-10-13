
Report 50286 "New Members Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/New Members Report.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "Registration Date", "No.", Name, "ID No.", "Mobile Phone No.", "Company No.", "Payroll/Staff No.", "Date Filter", "Relationship Officer", "Relationship Officer Name", "Branch Code", Status;
            column(Entrance; Entrance)
            {
            }
            column(Employer_Code; "Employer Code")
            {
            }
            column(Status_Members; Members.Status)
            {
            }
            column(Relationship_Officer_Name; "Relationship Officer Name")
            {
            }
            column(Recruited_By; "Recruited By")
            {
            }
            column(Recruited_By_Name; "Recruited By Name")
            {
            }

            column(DFilter; DFilter)
            {
            }
            column(CompanyName; Company.Name)
            {
            }
            column(CompanyPicture; Company.Picture)
            {
            }
            column(No_Members; "No.")
            {
            }
            column(Old_Member_No; Members."Old Member No.")
            {
            }
            column(Name_Members; Name)
            {
            }
            column(CompanyName_Members; Members."Company Name")
            {
            }
            column(PayrollStaffNo_Members; "Payroll/Staff No.")
            {
            }
            column(RegistrationDate_Members; Members."Registration Date")
            {
            }
            column(IDNo_Members; Members."ID No.")
            {
            }
            column(MobilePhoneNo_Members; Members."Mobile Phone No.")
            {
            }
            column(ShareDeposit; ShareDeposit)
            {
            }
            column(ShareCapital; ShareCapital)
            {
            }
            column(AssetShares; AssetShares)
            {
            }
            column(MDFShares; MDFShares)
            {
            }
            column(FosaAvailBal; FosaAvailBal)
            {
            }
            column(FosaBookBal; FosaBookBal)
            {
            }
            column(RelationshipOfficerName_Members; Members."Relationship Officer Name")
            {
            }
            column(LoanBalance; LoanBalance)
            {
            }
            column(FreeShares; FreeShares)
            {
            }
            column(Micro; Micro)
            {
            }
            column(DateofBirth_Members; Members."Date of Birth")
            {
            }
            column(Age; Age)
            {
            }

            trigger OnAfterGetRecord()
            begin
                MemberNo := "No.";
                TCont := 0;
                Age := 0;

                if Members."Date of Birth" <> 0D then begin
                    Age := Date2dmy(Today, 3) - Date2dmy(Members."Date of Birth", 3);
                end;



                ShareCapital := 0;
                ShareDeposit := 0;
                LoanBalance := 0;

                if Employee.Get(Members."Relationship Officer") then begin
                    if Members."Relationship Officer Name" <> Employee."First Name" + ' ' + Employee."Last Name" then begin
                        Members."Relationship Officer Name" := Employee."First Name" + ' ' + Employee."Last Name";
                        Members.Modify;
                    end;
                end;

                if ("Relationship Officer Name" = '') or ("Branch Manager Name" = '') then begin


                    if UserSetup.Get("Captured By") then begin
                        UserSetup.TestField("Global Dimension 2 Code");

                        "Relationship Officer" := UserSetup."Staff No";

                        if HREmployees.Get("Relationship Officer") then
                            "Relationship Officer Name" := HREmployees."First Name" + ' ' + HREmployees."Last Name";

                        UserSetup.Reset;
                        UserSetup.SetRange("Global Dimension 2 Code", "Global Dimension 2 Code");
                        UserSetup.SetRange("Branch Manager", true);
                        if UserSetup.FindFirst then begin
                            "Branch Manager" := UserSetup."Staff No";
                            HREmployees.Get("Branch Manager");
                            "Branch Manager Name" := HREmployees."First Name" + ' ' + HREmployees."Last Name";
                        end;

                        Modify;
                    end;

                end;

                ShareCapital := MemberActivities.GetAccountBalance(Legacy.GetShareCapitalAccount("No."));
                Entrance := MemberActivities.GetAccountBalance(Legacy.GetRegFeeAccount("No."));
                ShareDeposit := MemberActivities.GetAccountBalance(Legacy.GetDepositAccounts("No."));
                LoanBalance := Legacy.GetTotalLoanOutstandingBalance("No.", '');
                FosaBookBal := MemberActivities.GetAccountBookBalance(Legacy.GetOrdinaryAccount("No."));
                FosaAvailBal := MemberActivities.GetAccountBalance(Legacy.GetOrdinaryAccount("No."));
                //LoanBalance := 




            end;

            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Picture);

                if StartDate = 0D then
                    Error('Enter Start Date');
                if EndDate = 0D then
                    Error('Enter End Date');
                DFilter := Format(StartDate) + '..' + Format(EndDate);
                SetRange("Registration Date", StartDate, EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {

            area(content)
            {
                group(CustomFilters)
                {

                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
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
        DFilter: Text;
        ReportCategry: Option Savings,Loans;
        ShareDeposit: Decimal;
        ShareCapital: Decimal;
        AssetShares: Decimal;
        Entrance: Decimal;
        FosaBookBal: Decimal;
        MDFShares: Decimal;
        FosaAvailBal: Decimal;
        MemberActivities: Codeunit "Member Activities";
        LoanBalance: Decimal;
        Employee: Record Employee;
        UserSetup: Record "User Setup";
        HREmployees: Record Employee;
        FreeShares: Decimal;
        SkyMbanking: Codeunit "Sky Mbanking";
        Micro: Decimal;
        Age: Integer;
        WithoutLoans: Boolean;
        Legacy: Codeunit Legacy;
        StartDate: Date;
        EndDate: Date;

}

