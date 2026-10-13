report 50564 "Loan Listing"
{
    ApplicationArea = All;
    Caption = 'Loan Listing';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Listing.rdlc';
    dataset
    {
        dataitem("Sasra - Annex 1 Tabke 1"; "Sasra - Annex 1 Tabke 1")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(LoanNumber; "Sasra - Annex 1 Tabke 1"."Loan Number")
            {
            }
            column(MemberNumber; "Sasra - Annex 1 Tabke 1"."Member Number")
            {
            }
            column(MemberName; "Sasra - Annex 1 Tabke 1"."Member Name")
            {
            }
            column(BranchName; "Sasra - Annex 1 Tabke 1"."Branch Name")
            {
            }
            column(LoanOfficer; "Sasra - Annex 1 Tabke 1"."Loan Officer")
            {
            }
            column(EmployerName; "Sasra - Annex 1 Tabke 1"."Employer Name")
            {
            }
            column(Loan_Balance; "Sasra - Annex 1 Tabke 1"."Loan Balance")
            {

            }
            column(Loan_Interest_Due; Loan_Interest_Due)
            {

            }
            column(LoanType; "Sasra - Annex 1 Tabke 1"."Loan Type")
            {
            }
            column(LoanAmortizationType; "Sasra - Annex 1 Tabke 1"."Loan Amortization Type")
            {
            }
            column(LoanInstallments; "Sasra - Annex 1 Tabke 1"."Loan Installments")
            {
            }
            column(AnnualLoanRate; "Sasra - Annex 1 Tabke 1"."Annual Loan Rate")
            {
            }
            column(LoanFrequency; "Sasra - Annex 1 Tabke 1"."Loan Frequency")
            {
            }
            column(Loan_category; "Sasra - Annex 1 Tabke 1"."Loan category")
            {
            }
            column(DateLoanDisbursed; "Sasra - Annex 1 Tabke 1"."Date Loan Disbursed")
            {
            }
            column(LoanAmount; "Sasra - Annex 1 Tabke 1"."Loan Amount")
            {
            }
            column(LoanMaturity; "Sasra - Annex 1 Tabke 1"."Loan Maturity")
            {
            }
            column(LoanFirstPmtdate; "Sasra - Annex 1 Tabke 1"."Loan First Pmt date")
            {
            }
            column(Latestamountpaid; "Sasra - Annex 1 Tabke 1"."Latest amount paid")
            {
            }
            column(Latestpaymentdate; "Sasra - Annex 1 Tabke 1"."Latest payment date")
            {
            }
            column(LoanBalance; "Sasra - Annex 1 Tabke 1"."Loan Balance")
            {
            }
            column(DaysinArrears; "Sasra - Annex 1 Tabke 1"."Days in Arrears")
            {
            }
            column(Arrearsdate; "Sasra - Annex 1 Tabke 1"."Arrears date")
            {
            }
            column(LoanClassification; "Sasra - Annex 1 Tabke 1"."Loan-Classification")
            {
            }
            column(LoanlossProvision; "Sasra - Annex 1 Tabke 1"."Loan loss Provision")
            {
            }
            column(LoanRestructureFlag; "Sasra - Annex 1 Tabke 1"."Loan Restructure Flag[1]")
            {
            }
            column(LoanInterestDue; "Sasra - Annex 1 Tabke 1".Loan_Interest_Due)
            {
            }
            column(NoofLoanGuarantors; "Sasra - Annex 1 Tabke 1"."No. of Loan Guarantors")
            {
            }
            column(Amountofguarantee; "Sasra - Annex 1 Tabke 1"."Amount of guarantee")
            {
            }
            column(OtherCollateralSecurity; "Sasra - Annex 1 Tabke 1"."Other Collateral_Security")
            {
            }
            dataitem(MemberDetails; Members)
            {
                dataitemlink = "No." = field("Member Number");
                column(MemberIDNo; "ID No.")
                {
                }
                column(MemberGender; Gender)
                {
                }
                column(MemberDOB; "Date of Birth")
                {
                }
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