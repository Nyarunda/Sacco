report 50544 "Sasra Loan Listing"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './src/Layouts/Sasra Loan Listing.rdlc';
    UsageCategory = ReportsandAnalysis;
    ProcessingOnly = false;

    dataset
    {
        dataitem(Loan; "Loans")
        {
            // columns from Loans
            column(LoanNo; "Loan No.") { }
            column(LoanProduct; "Loan Product Type") { }
            column(LoanProductName; "Loan Product Type Name") { }
            column(ApprovedAmount; "Approved Amount") { }
            column(DateDisbursed; "Disbursement Date") { }
            column(CompletionDate; "Completion Date") { }
            column(OutstandingPrincipal; "Outstanding Principal") { }
            column(OutstandingInterest; "Outstanding Interest") { }
            column(Source; Source) { }
            column(Repayment_Frequency; "Repayment Frequency") { }
            column(Installments; Installments) { }
            column(Annual_Interest__; "Annual Interest %") { }
            column(LoanMemberNo; "Member No.") { }
            column(LoanMemberName; "Member Name") { }
            column(Loans_Category_SASRA; "Loans Category-SASRA") { }
            column(Days_in_Arrears; '') { }
            column(Security_Plegde; 'Guarantor Deposit') { }

            trigger OnAfterGetRecord()
            begin
                // Calculate FlowFields for the current loan record
                //Loan.CalcFields("Outstanding Principal", "Outstanding Interest");
            end;
        }

    }

    trigger OnPreReport()
    begin
        // validate or set defaults if required
    end;

    var
    //Sasra: Record loans 
}
