
Report 50333 "IFRS STaging Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/IFRS STaging Summary.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("IFRS-9 Model"; "IFRS-9 Model")
        {

            column(IFRS_Stage; "IFRS Stage")
            {

            }

            column(No__Of_Loans; "No. Of Loans")
            {

            }
            column(Total_Outstanding_Balance; "Total Outstanding Balance")
            {

            }

            column(Total_ECL; "Total ECL")
            {

            }
            column(As_At; "As At")
            {

            }


            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Picture);

            end;
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

}

