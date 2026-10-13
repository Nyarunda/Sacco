
Report 50184 "Statement Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Statement Summary.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Total Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Loan No.", "Member No.", "Loan Product Type";
            column(ReportForNavId_1; 1)
            {
            }
            column(Period; Loans.Installments)
            {
            }
            column(LoanNo; Loans."Loan No.")
            {
            }
            column(MemberNo; Loans."Member No.")
            {
            }
            column(LoanAmount; Loans."Approved Amount")
            {
            }
            column(ProductName; Loans."Loan Product Type Name")
            {
            }
            column(LoanBalance; Loans."Total Outstanding Balance")
            {
            }
            column(OutstandingPrincipal_Loans; Loans."Outstanding Principal")
            {
            }
            column(InterestBilled; Loans."Outstanding Interest")
            {
            }
            column(PenaltyToDate; Loans."Outstanding Penalty")
            {
            }
            column(Name; Loans."Member Name")
            {
            }
            column(IDNo; Members."ID No.")
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(Logo; CompInfo.Picture)
            {
            }
            column(LoanDate; Loans."Disbursement Date")
            {
            }
            column(PaidToDate; PaidToDate)
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

    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        Members: Record Members;
        CompInfo: Record "Company Information";
        PaidToDate: Decimal;
}

