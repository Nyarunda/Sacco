
Report 50019 "Member Balances Report."
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Member Balances Report..rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Name, "ID No.", "Mobile Phone No.", "Company No.", "Payroll/Staff No.", "Date Filter";
            column(ReportForNavId_1; 1)
            {
            }
            column(Title; Title)
            {
            }
            column(Status_Members; Members.Status)
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
            dataitem("Product Setup"; "Product Setup")
            {
                DataItemTableView = where("Dont Show on Member Register" = const(false));
                RequestFilterFields = "Product ID", "Product Category";
                column(ReportForNavId_3; 3)
                {
                }
                column(ProductID_ProductFactory; Description)
                {
                }
                column(ProductDescription_ProductFactory; Description)
                {
                }
                dataitem(Account; "Product Setup")
                {
                    DataItemLink = "Product ID" = field("Product ID");
                    column(ReportForNavId_4; 4)
                    {
                    }
                    column(AccBalance; AccBalance)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        AccCont := 0;
                        AccBalance := 0;
                        if Account."Product Class" = Account."product class"::Savings then begin
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange("Member No.", MemberNo);
                            SavingsAccounts.SetRange("Product Type", Account."Product ID");
                            if DFilter <> '' then
                                SavingsAccounts.SetFilter("Date Filter", DFilter);
                            if SavingsAccounts.FindFirst then begin
                                repeat

                                    SavingsAccounts.CalcFields("Balance (LCY)");
                                    AccBalance += SavingsAccounts."Balance (LCY)";
                                until SavingsAccounts.Next = 0;
                            end;
                        end;



                        if Account."Product Class" = Account."product class"::Credit then begin
                            Loans.Reset;
                            Loans.SetRange("Member No.", MemberNo);
                            Loans.SetRange("Loan Product Type", Account."Product ID");
                            if DFilter <> '' then
                                Loans.SetFilter("Date Filter", DFilter);
                            if Loans.FindFirst then begin
                                AccCont := 0;
                                repeat
                                    Loans.CalcFields("Total Outstanding Balance");
                                    AccBalance := Loans."Total Outstanding Balance";
                                until Loans.Next = 0;
                            end;
                        end;
                    end;
                }

                trigger OnPreDataItem()
                begin

                    if ReportCategry = Reportcategry::Loans then begin
                        "Product Setup".SetRange("Product Class", "Product Setup"."product class"::Credit);
                        Title := 'MEMBER LOANS REPORT';
                    end;
                    if ReportCategry = Reportcategry::Savings then begin
                        "Product Setup".SetRange("Product Class", "Product Setup"."product class"::Savings);
                        Title := 'MEMBER SAVINGS REPORT';
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                MemberNo := "No.";
                TCont := 0;
            end;

            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Picture);

                DFilter := Members.GetFilter("Date Filter");
                Title := 'MEMBER BALANCES REPORT';
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Report Categry"; ReportCategry)
                {
                    ApplicationArea = Basic;
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
        Title: Code[200];
}

