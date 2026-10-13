
Report 50139 "Micro Group Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Micro Group Schedule.rdlc';

    dataset
    {
        dataitem(Group; Members)
        {
            RequestFilterFields = "No.", Name, "ID No.", "Mobile Phone No.", "Company No.", "Payroll/Staff No.", "Date Filter", "Relationship Officer", "Relationship Officer Name";
            column(ReportForNavId_27; 27)
            {
            }
            column(GroupNo; Group."No.")
            {
            }
            column(GroupName; Group.Name)
            {
            }
            dataitem(Members; Members)
            {
                DataItemLink = "Group No." = field("No.");
                RequestFilterFields = "No.", Name, "ID No.", "Mobile Phone No.", "Company No.", "Payroll/Staff No.", "Date Filter", "Relationship Officer", "Relationship Officer Name";
                column(ReportForNavId_1; 1)
                {
                }
                column(Status_Members; Members.Status)
                {
                }
                column(GroupNo_Members; Members."Group No.")
                {
                }
                column(BranchCode; Members."Global Dimension 2 Code")
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
                column(MicroInterest; MInterest)
                {
                }
                column(MicroPrincipal; MPrincipal)
                {
                }
                column(MicroPenalty; MPenalty)
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
                    AssetShares := 0;
                    Housing := 0;
                    FosaAvailBal := 0;
                    FosaBookBal := 0;
                    MDFShares := 0;
                    LoanBalance := 0;
                    Micro := 0;

                    if Employee.Get(Members."Relationship Officer") then begin
                        if Members."Relationship Officer Name" <> Employee."First Name" + ' ' + Employee."Last Name" then begin
                            Members."Relationship Officer Name" := Employee."First Name" + ' ' + Employee."Last Name";
                            Members.Modify;
                        end;
                    end;

                    if ("Relationship Officer Name" = '') or ("Branch Manager Name" = '') then begin


                        if UserSetup.Get("Captured By") then begin
                            UserSetup.TestField("Global Dimension 2 Code");

                            UserSetup.TestField("Staff No");
                            "Relationship Officer" := UserSetup."Staff No";

                            HREmployees.Get("Relationship Officer");
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

                    FreeShares := 0;

                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("Member No.", Members."No.");
                    SavingsAccounts.SetFilter("Product Category", '%1|%2',
                    SavingsAccounts."product category"::"Micro Member Deposit",
                    SavingsAccounts."product category"::"Micro Group Deposit");
                    if SavingsAccounts.FindFirst then begin
                        repeat
                            SavingsAccounts.CalcFields("Balance (LCY)");

                            if SavingsAccounts."Product Category" = SavingsAccounts."product category"::"Micro Member Deposit" then begin
                                Micro += SavingsAccounts."Balance (LCY)";
                            end;
                            if SavingsAccounts."Product Category" = SavingsAccounts."product category"::"Micro Group Deposit" then begin
                                Micro += SavingsAccounts."Balance (LCY)";
                            end;

                        until SavingsAccounts.Next = 0;
                    end;


                    MInterest := 0;
                    MPenalty := 0;
                    MPrincipal := 0;

                    LoanBalance := 0;
                    Loans.Reset;
                    Loans.SetRange("Member No.", Members."No.");
                    Loans.SetRange(Source, Loans.Source::MICRO);
                    Loans.SetFilter("Total Outstanding Balance", '<>0');
                    if Loans.FindFirst then begin
                        repeat
                            Loans.CalcFields("Outstanding Interest", "Outstanding Penalty", "Outstanding Principal", "Total Outstanding Balance");
                            MInterest += Loans."Outstanding Interest";
                            MPenalty += Loans."Outstanding Penalty";
                            MPrincipal += Loans."Outstanding Principal";
                            LoanBalance += Loans."Total Outstanding Balance";
                        until Loans.Next = 0;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    Company.Get;
                    Company.CalcFields(Picture);

                    DFilter := Members.GetFilter("Date Filter");
                end;
            }

            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Picture);

                DFilter := Members.GetFilter("Date Filter");
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
        MInterest: Decimal;
        MPrincipal: Decimal;
        MPenalty: Decimal;
}

