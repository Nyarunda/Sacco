
Report 50134 "Loans Security Report"
{
    DefaultLayout = RDLC;

    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/Layouts/Loans Security Report.rdlc';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(ReportForNavId_11; 11)
            {
            }
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }
        }
        dataitem("Loan Security"; "Loan Security")
        {
            RequestFilterFields = "Guarantor Type";
            column(ReportForNavId_1; 1)
            {
            }
            column(LoanNo_LoanSecurity; "Loan Security"."Loan No.")
            {
            }
            column(AccountNo_LoanSecurity; "Loan Security"."Account No.")
            {
            }
            column(GuarantorLoanBalance_LoanSecurity; "Loan Security"."Guarantor Loan Balance")
            {
            }
            column(GuarantorDeposits_LoanSecurity; "Loan Security"."Guarantor Deposits")
            {
            }
            column(LoansGuaranteed_LoanSecurity; "Loan Security"."Loans Guaranteed")
            {
            }
            column(AmountGuaranteed_LoanSecurity; "Loan Security"."Amount Guaranteed")
            {
            }
            column(OutstandingPrincipal_LoanSecurity; "Loan Security"."Outstanding Principal")
            {
            }
            column(MemberGuaranteed_LoanSecurity; "Loan Security"."Member Guaranteed")
            {
            }
            column(GuarantorType_LoanSecurity; "Loan Security"."Guarantor Type")
            {
            }
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
}

