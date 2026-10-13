
Report 50137 "Fosa Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Fosa Register.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Name, "ID No.", "Mobile Phone No.", "Company No.", "Payroll/Staff No.", "Date Filter", "Relationship Officer", "Relationship Officer Name";
            column(ReportForNavId_1; 1)
            {
            }
            column(Status_Members; Members.Status)
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
            column(Business; Business)
            {
            }
            column(Junior; Junior)
            {
            }
            column("Fixed"; Fixed)
            {
            }
            column(Benevolent; Benevolent)
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

            trigger OnAfterGetRecord()
            begin
                MemberNo := "No.";
                TCont := 0;


                Business := 0;
                Junior := 0;
                Fixed := 0;
                Benevolent := 0;
                FosaAvailBal := 0;
                FosaBookBal := 0;
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

                SavingsAccounts.Reset();
                SavingsAccounts.SetFilter("Date Filter", DFilter);
                SavingsAccounts.SetRange("Member No.", Members."No.");
                SavingsAccounts.SetFilter("Product Category", '%1|%2|%3|%4|%5',
                    SavingsAccounts."Product Category"::"Fixed Deposit",
                    SavingsAccounts."Product Category"::"Junior Savings",
                    SavingsAccounts."Product Category"::"Benevolent Fund",
                    SavingsAccounts."Product Category"::Business,
                    SavingsAccounts."Product Category"::"Ordinary Savings");

                SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
                SavingsAccounts.SetLoadFields("Product Category", "Balance (LCY)");

                if SavingsAccounts.FindSet() then
                    repeat
                        case SavingsAccounts."Product Category" of
                            SavingsAccounts."Product Category"::"Fixed Deposit":
                                Fixed := SavingsAccounts."Balance (LCY)";
                            SavingsAccounts."Product Category"::"Junior Savings":
                                Junior := SavingsAccounts."Balance (LCY)";
                            SavingsAccounts."Product Category"::"Benevolent Fund":
                                Benevolent := SavingsAccounts."Balance (LCY)";
                            SavingsAccounts."Product Category"::Business:
                                Business := SavingsAccounts."Balance (LCY)";
                            SavingsAccounts."Product Category"::"Ordinary Savings":
                                begin
                                    FosaBookBal := SavingsAccounts."Balance (LCY)";
                                    FosaAvailBal := MemberActivities.GetAccountBalanceByDate(
                                        SavingsAccounts."No.",
                                        Members.GetRangeMax("Date Filter")
                                    );
                                end;
                        end;
                    until SavingsAccounts.Next() = 0;

                if FosaAvailBal < 0 then
                    FosaAvailBal := 0;


                LoanBalance := 0;
                Loans.Reset;
                Loans.SetRange("Member No.", Members."No.");
                Loans.SetFilter("Total Outstanding Balance", '<>0');
                Loans.SetAutoCalcFields("Total Outstanding Balance");
                Loans.SetLoadFields("Total Outstanding Balance");
                if Loans.FindFirst then begin
                    repeat
                        LoanBalance += Loans."Total Outstanding Balance";
                    until Loans.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Picture);

                DFilter := Members.GetFilter("Date Filter");
                if DFilter = '' then begin
                    Members.SetFilter("Date Filter", '..%1', Today);
                    DFilter := Members.GetFilter("Date Filter");
                end;
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
        Business: Decimal;
        Junior: Decimal;
        "Fixed": Decimal;
        Benevolent: Decimal;
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
}

