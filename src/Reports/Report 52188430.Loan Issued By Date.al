
Report 50065 "Loan Issued By Date"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Issued By Date.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = sorting("Disbursement Date") order(ascending) where(Posted = const(true));
            RequestFilterFields = "Loan No.", "Application Date", "Loan Product Type", "Member No.", "Disbursement Date", "Captured By", "Booking Branch";
            column(ReportForNavId_1; 1)
            {
            }
            column(DisbursementDate_Loans; Loans."Disbursement Date")
            {
            }
            column(Repayment_Loans; Loans.Repayment)
            {
            }
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(ApplicationDate_Loans; Loans."Disbursement Date")
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(CustomerCID; Loans."Form Serial No")
            {
            }
            column(MemberName_Loans; Loans."Member Name")
            {
            }
            column(Installemnt; Loans.Installments)
            {
            }
            column(RecommendedBy_Loans; Loans."Recommended By Name")
            {
            }
            column(RecommendedbyType_Loans; Loans."Recommended by Type")
            {
            }
            column(RequestedAmount; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(OutBal; Loans."Outstanding Principal")
            {
            }
            column(OutInt; Loans."Outstanding Interest")
            {
            }
            column(Picture; Company.Picture)
            {
            }
            column(OutPenalty; Loans."Outstanding Penalty")
            {
            }
            column(OutAppraisal; Loans."Outstanding Appraisal")
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(sno; sno)
            {
            }

            trigger OnAfterGetRecord()
            begin
                sno += 1;
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

    trigger OnPreReport()
    begin
        Company.Get;
        Company.CalcFields(Company.Picture);
    end;

    var
        ProductType: Text;
        MemberBiodata: Text;
        Company: Record "Company Information";
        sno: Integer;
        ProductSetup: Record "Product Setup";
        SaccoActivities: Codeunit "Sacco Activities";
}

