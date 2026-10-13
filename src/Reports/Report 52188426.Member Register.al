Report 50018 "Member Register"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Member Register.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Name, "ID No.", "Mobile Phone No.", "Company No.", "Payroll/Staff No.", "Date Filter", "Relationship Officer", "Relationship Officer Name", "Date Rejoined", "Registration Date", "Branch Code", Status;
            DataItemTableView = WHERE(Type = FILTER(Member | Group));

            column(Employer_Code; "Employer Code")
            {
            }

            column(SalaryProcessing; SalaryProcessing)
            {
            }
            column(KRA_PIN; "KRA PIN")
            {
            }
            column(Employement_Sector; "Employement Sector")
            {
            }
            column(Member_Tier; "Member Tier")
            { }
            column(Passport; Passport)
            {
            }
            column(Employer_Name; "Employer Name")
            {
            }
            column(Member_Category; AgeMemberCategory)
            {
            }
            column(Member_Status; "Member Status")
            {
            }
            column(E_Mail; "E-Mail")
            {
            }
            column(Occupation; "Employment Info")
            {
            }
            column(Recruited_By; "Recruited By")
            {
            }
            column(Recruited_By_Name; "Recruited By Name")
            {
            }

            column(Gender; Gender)
            {
            }
            column(Status_Members; Members."Member Status")
            {
            }
            column(Member_Class; Members."Member Class")
            {
            }
            column(BranchCode; Members."Global Dimension 2 Code")
            {
            }
            column(CompanyName; Company.Name)
            {
            }
            /*  column(CompanyPicture; Company.Picture )
             {
             } */
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
            column(Business_Name; "Business Name")
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
            column(OrdinaryShares; OrdinaryShares)
            {
            }
            column(ShareCapital; ShareCapital)
            {
            }
            column(AssetShares; AssetShares)
            {
            }
            column(FosaAvailBal; FosaAvailBal)
            {
            }
            column(FosaBookBal; FosaBookBal)
            {
            }
            column(RegFee; RegFee)
            {
            }
            column(DivBal; DivBal)
            {
            }
            column(RelationshipOfficerName_Members; Members."Relationship Officer Name")
            {
            }
            column(TotalLoanBalance; TotalLoanBalance)
            {
            }
            column(LoanBalance; LoanBalance)
            {
            }
            column(LoanInterest; LoanInterest)
            {
            }
            column(GCount; GCount)
            {
            }
            column(GTotal; GTotal)
            {
            }
            column(GBal; GBal)
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
            column(Risk_Rating; RiskRating)
            {
            }
            column(ContactPerson; ContactPerson)
            {
            }
            column(ContactPersonPhone; ContactPersonPhone)
            {
            }
            column(Locality; Locality)
            {
            }
            column(HasImages; HasImages)
            {
            }
            column(Exempt_Send_Email; "Exempt Send Email")
            {
            }
            column(Exempt_Send_SMS; "Exempt Send SMS")
            {
            }

            trigger OnAfterGetRecord()
            var
                Emp: Record customer;
                Log: Record "File Movement Log";
                Loans: Record Loans;
                Images: Record "Member Images";
                NOK: Record "Next of Kin.";

            begin
                MemberNo := "No.";
                TCont := 0;
                Age := 0;
                RiskRating := '';
                AgeMemberCategory := '';

                GCount := 0;
                GTotal := 0;
                GBal := 0;
                HasImages := true;

                Images.Reset();
                Images.SetRange("Member No.", "No.");
                if not Images.FindFirst() then
                    HasImages := false;

                /* 
                SalaryProcessing := '';
                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Member No.", "No.");
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Ordinary Savings");
                SavingsAccounts.SetLoadFields("Salary Processing");
                if SavingsAccounts.FindFirst() then begin
                    if SavingsAccounts."Salary Processing" then
                        SalaryProcessing := 'Yes';
                end; */

                /* //modified by Maisha Bora
                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Member No.", "No.");
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Dividend Account");
                SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
                SavingsAccounts.SetLoadFields("Balance (LCY)");
                if SavingsAccounts.FindFirst() then begin
                    DivBal := SavingsAccounts."Balance (LCY)";
                end;
 */
                if "Member Status" = "Member Status"::" " then begin
                    "Member Status" := "Member Status"::Active;
                    Modify();
                end;

                if Members."Date of Birth" <> 0D then begin
                    Age := Date2dmy(Today, 3) - Date2dmy(Members."Date of Birth", 3);
                end;

                if Age > 0 then
                    AgeMemberCategory := GetAgeMemberCategory(Age);

                RiskRating := GetRiskRating(Members."No.");

                if Members."Employer Code" = '004' then begin
                    if not Members.Pensioner then begin
                        Members.Pensioner := true;
                        Members.Modify();
                    end;

                    /*  Loans.Reset();
                     Loans.SetRange("Member No.", "No.");
                     Loans.SetLoadFields("Repay Mode", Source, "Global Dimension 1 Code");
                     if Loans.FindFirst() then begin
                         repeat
                             Loans."Repay Mode" := Loans."Repay Mode"::Pension;
                             Loans.Source := Loans.Source::FOSA;
                             Loans."Global Dimension 1 Code" := 'FOSA';
                             Loans.Modify();
                         until Loans.Next() = 0;
                     end; */
                end;

                if Emp.Get("Employer Code") then begin

                    if Members."Employer Name" <> Emp.Name then begin
                        Members."Employer Name" := Emp.Name;
                        Members.modify;
                        Commit();
                    end;
                    if Emp."Account Type" <> Emp."Account Type"::Employer then begin
                        Emp."Account Type" := Emp."Account Type"::Employer;
                        Emp.Modify();
                        Commit();
                    end;
                    if Emp."Advice Method" <> Emp."Advice Method"::Changes then begin
                        Emp."Advice Method" := Emp."Advice Method"::Changes;
                        Emp.Modify();
                        Commit();
                    end;
                end;

                Nok.Reset();
                NOK.SetRange("No.", Members."No.");
                NOK.SetLoadFields(Name, "Mobile Phone No.");
                if NOK.FindFirst() then begin
                    ContactPerson := NOK.Name;
                    ContactPersonPhone := NOK."Mobile Phone No.";
                end;

                ShareCapital := 0;
                ShareDeposit := 0;
                LoanBalance := 0;
                TotalLoanBalance := 0;
                LoanInterest := 0;
                RegFee := 0;
                OrdinaryShares := 0;


                SavingsAccounts.RESET;
                SavingsAccounts.SETRANGE(SavingsAccounts."Member No.", Members."No.");
                SavingsAccounts.SETFILTER(SavingsAccounts."Date Filter", DFilter);
                SavingsAccounts.SETFILTER(SavingsAccounts."Product Category", '%1|%2', SavingsAccounts."Product Category"::"Deposit Contribution", SavingsAccounts."Product Category"::"Micro Member Deposit");
                SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
                SavingsAccounts.SetLoadFields("Balance (LCY)");
                IF SavingsAccounts.FindSet() THEN BEGIN
                    REPEAT
                        ShareDeposit += SavingsAccounts."Balance (LCY)";
                    UNTIL SavingsAccounts.Next() = 0;
                END;

                case true of
                    ShareDeposit >= 10000000:
                        Members."Member Tier" := Members."Member Tier"::Platinum;

                    ShareDeposit >= 5000000:
                        Members."Member Tier" := Members."Member Tier"::Gold;

                    ShareDeposit >= 1000000:
                        Members."Member Tier" := Members."Member Tier"::Diamond;

                    ShareDeposit >= 1:
                        Members."Member Tier" := Members."Member Tier"::Silver;

                    else
                        Members."Member Tier" := Members."Member Tier"::" ";
                end;

                Members.Modify();

                /* SavingsAccounts.RESET;
                SavingsAccounts.SETRANGE(SavingsAccounts."Member No.", Members."No.");
                SavingsAccounts.SETFILTER(SavingsAccounts."Date Filter", DFilter);
                SavingsAccounts.SETFILTER(SavingsAccounts."Product Category", '%1', SavingsAccounts."Product Category"::"Ordinary Savings");
                SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
                SavingsAccounts.SetLoadFields("Balance (LCY)");
                IF SavingsAccounts.FindSet() THEN BEGIN
                    REPEAT
                        OrdinaryShares += SavingsAccounts."Balance (LCY)";
                    UNTIL SavingsAccounts.Next() = 0;
                END; */


                /*  ShareCapital := MemberActivities.GetAccountBalanceAsAt(Legacy.GetShareCapitalAccount("No."), AsAt);
                 RegFee := MemberActivities.GetAccountBalance(Legacy.GetRegFeeAccount("No."));
                 LoanBalance := Legacy.GetTotalLoanPrincipalBalance("No.", DFilter);
                 LoanInterest := Legacy.GetTotalLoanInterestBalance("No.", DFilter);
                 TotalLoanBalance := LoanBalance + LoanInterest; */


                /*  LGuar.RESET;
                 LGuar.SETRANGE(LGuar."Member No", Members."No.");
                 LGuar.SetAutoCalcFields("Outstanding Principal");
                 IF LGuar.FIND('-') THEN BEGIN
                     REPEAT
                         IF LGuar."Self Guarantee" = FALSE THEN BEGIN
                             IF LGuar."Outstanding Principal" > 0 THEN BEGIN
                                 GCount += 1;
                                 GTotal += LGuar."Amount Guaranteed";
                                 IF Loans.GET(LGuar."Loan No.") THEN BEGIN
                                     Loans.CALCFIELDS("Outstanding Principal");
                                     IF (Loans."Outstanding Principal" > 0) AND (Loans."Approved Amount" > 0) THEN
                                         GBal += (ROUND(((Loans."Outstanding Principal" / Loans."Approved Amount") * LGuar."Amount Guaranteed"), 0.01));
                                 END;
                             END;
                         END;
                     UNTIL LGuar.NEXT = 0;
                 END;*/


                /*                 if WithoutLoans then begin
                                    if LoanBalance > 0 then
                                        CurrReport.Skip();
                                end;
                 */

            end;

            trigger OnPreDataItem()
            var
                LoadCompanyPicture: Boolean;
            begin

                Company.Reset();
                Company.SetLoadFields("Name");
                Company.Get();

                DFilter := Members.GetFilter("Date Filter");

                if DFilter = '' then
                    Error('Please specify the "Date Filter" on the Members request filter before running the report.');

                AsAt := Members.GetRangeMax("Date Filter");
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

                    field("Members Without Loans"; WithoutLoans)
                    {
                        ApplicationArea = All;
                    }
                    /*  field(AsAt; AsAt)
                     {
                     } */
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

    local procedure GetRiskRating(MemberNo: Code[20]): Text[50]
    var
        LoanGraduationScore: Record "Loan Graduation Score";
    begin
        LoanGraduationScore.Reset();
        LoanGraduationScore.SetRange("Member No", MemberNo);
        if LoanGraduationScore.FindLast() then
            case LoanGraduationScore."Risk Category" of
                LoanGraduationScore."Risk Category"::"Very High Risk",
                LoanGraduationScore."Risk Category"::"High Risk":
                    exit('High');
                LoanGraduationScore."Risk Category"::"Moderate Risk":
                    exit('Medium');
                LoanGraduationScore."Risk Category"::"Low Risk",
                LoanGraduationScore."Risk Category"::"Very Low Risk":
                    exit('Low');
            end;

        exit('');
    end;

    local procedure GetAgeMemberCategory(MemberAge: Integer): Text[30]
    begin
        if MemberAge = 0 then
            exit('');

        if MemberAge <= 35 then
            exit('Youth');

        if MemberAge <= 59 then
            exit('Middle Aged');

        if MemberAge <= 79 then
            exit('Elderly');

        exit('Senior');
    end;

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        UserSetup.Get(UserId);
        if not UserSetup.Reports then
            Error('You do not have any permissions to access this report. Contact the administrator!');
    end;

    var
        ContactPerson: text[100];
        ContactPersonPhone: code[50];
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
        AsAt: Date;
        SDate: Date;
        EDate: Date;
        AdvDate: Date;
        EmpCode: Code[20];
        DFilter: Text;
        ReportCategry: Option Savings,Loans;
        ShareDeposit: Decimal;
        OrdinaryShares: Decimal;
        ShareCapital: Decimal;
        RegFee: Decimal;
        AssetShares: Decimal;
        Housing: Decimal;
        FosaBookBal: Decimal;
        MDFShares: Decimal;
        FosaAvailBal: Decimal;
        MemberActivities: Codeunit "Member Activities";
        TotalLoanBalance: Decimal;
        LoanBalance: Decimal;
        LoanInterest: Decimal;
        Employee: Record Employee;
        UserSetup: Record "User Setup";
        HREmployees: Record Employee;
        FreeShares: Decimal;
        SkyMbanking: Codeunit "Sky Mbanking";
        Micro: Decimal;
        Age: Integer;
        WithoutLoans: Boolean;
        Legacy: Codeunit Legacy;
        SalaryProcessing: Text;
        DivBal: Decimal;
        GCount: Decimal;
        GTotal: Decimal;
        GBal: Decimal;
        HasImages: Boolean;
        RiskRating: Text[50];
        AgeMemberCategory: Text[30];
        LGuar: Record "Loan Security";

}

