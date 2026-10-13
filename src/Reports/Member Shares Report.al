
Report 50314 "Member Shares Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Member Shares Report.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Name, "ID No.", "Mobile Phone No.", "Company No.", "Payroll/Staff No.", "Date Filter", "Relationship Officer", "Relationship Officer Name", "Registration Date", "Branch Code", Status;
            column(ReportForNavId_1; 1)
            {
            }
            column(DepositDate; DepositDate)
            {
            }
            column(DepositAmount; DepositAmount)
            {
            }
            column(RegistrationFee; RegistrationFee)
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
                MemberNo := "No.";
                TCont := 0;
                Age := 0;

                if Members."Date of Birth" <> 0D then begin
                    Age := Date2dmy(Today, 3) - Date2dmy(Members."Date of Birth", 3);
                end;



                DepositAmount := 0;
                DepositDate := 0D;
                RegistrationFee := 0;
                Housing := 0;
                FosaAvailBal := 0;
                FosaBookBal := 0;
                MDFShares := 0;
                LoanBalance := 0;
                Micro := 0;
                FreeShares := 0;



                RegistrationFee := 0;

                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Member No.", Members."No.");
                SavingsAccounts.SetFilter("Product Category", '%1|%2',
                SavingsAccounts."product category"::"Share Capital",
                SavingsAccounts."product category"::"Registration Fee");
                if SavingsAccounts.FindFirst then begin
                    repeat

                        if SavingsAccounts."Product Category" = SavingsAccounts."product category"::"Share Capital" then begin
                            SLedger.Reset();
                            SLedger.SetRange("Account No.", SavingsAccounts."No.");
                            SLedger.SetFilter("Amount (LCY)", '<0');
                            if SLedger.FindFirst() then begin
                                FreeShares := SLedger."Amount (LCY)" * -1;
                                DepositDate := SLedger."Posting Date";
                            end;

                        end;
                        if SavingsAccounts."Product Category" = SavingsAccounts."product category"::"Registration Fee" then begin

                            SavingsAccounts.CalcFields("Balance (LCY)");
                            RegistrationFee := SavingsAccounts."Balance (LCY)";
                        end;
                    until SavingsAccounts.Next = 0;
                end;



            end;

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

            area(content)
            {
                group(CustomFilters)
                {
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
        DepositAmount: Decimal;

        RegistrationFee: Decimal;
        DepositDate: Date;
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
        SLedger: Record "Savings Ledger Entry";
}

