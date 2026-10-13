
Report 50288 "Member Withdrawals"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Member Withdrawals.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(MemberExit; "Member Exit")
        {
            RequestFilterFields = "Closing Date", "No.", "Closure Type";
            DataItemTableView = where(Posted = const(true));

            column(WithdrawalType; WithdrawalType)
            {

            }

            column(Net_Refundable; "Net Refundable")
            {

            }
            column(Date; Date)
            {

            }

            column(EmpCode; EmpCode)
            {

            }
            column(EmpName; EmpName)
            {

            }
            column(Closing_Date; MemberExit."Closing Date")
            {

            }
            column(Reason_for_Withdrawal; "Reason for Withdrawal")
            {
            }
            column(NoticeDate; NoticeDate)
            {
            }
            column(MatirityDate; MatirityDate)
            { }
            column(Reason; Reason)
            { }
            dataitem(Members; Members)
            {
                DataItemLink = "No." = field("Member No.");
                RequestFilterFields = "No.", Name, "ID No.", "Mobile Phone No.", "Company No.", "Payroll/Staff No.", "Date Filter", "Relationship Officer", "Relationship Officer Name", "Registration Date", "Branch Code", Status;
                column(DFilter; DFilter)
                {
                }
                column(Closure_Type; MemberExit."Closure Type")
                {

                }
                column(Status_Members; Members.Status)
                {
                }
                column(Employer_Code; "Employer Code")
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
                column(Housing; Housing)
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


                    FosaBookBal := MemberActivities.GetAccountBookBalance(Legacy.GetOrdinaryAccount("No."));


                    EmpCode := Members."Employer Code";
                    EmpName := Members."Employer Name";



                end;
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                NoticeDate := 0D;
                MatirityDate := 0D;
                Notice.Reset();
                Notice.SetRange("No.", MemberExit."Notice No.");
                Notice.SetRange("Withdrawa Noticel Date", StartDate, EndDate);
                if Notice.FindFirst() then begin
                    NoticeDate := Notice."Withdrawa Noticel Date";
                    MatirityDate := Notice."Maturity Date";
                    Reason := Notice."Reason for withdrawal";
                end else
                    CurrReport.Skip();
            end;


            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Picture);

                DFilter := Format(StartDate) + '..' + Format(EndDate);
                //SetFilter("Closing Date", DFilter);
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
        EmpName: Text[100];
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
        Housing: Decimal;
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
        NoticeDate: Date;
        MatirityDate: Date;
        Reason: Text;
        Notice: Record "Member Exit Notice";

}

