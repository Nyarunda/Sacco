
Report 50067 "Loans Projection Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Projection Report.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(ExpectedInterest; ExpectedInterest)
            {
            }
            column(ExpectedPrincipal; ExpectedPrincipal)
            {
            }
            column(TotalExpected; TotalExpected)
            {
            }
            column(NewLoanBalance; NewLoanBalance)
            {
            }
            column(CurrentLoanBalance; CurrentLoanBalance)
            {
            }
            column(InterestCalculationMethod_Loans; Loans."Interest Calculation Method")
            {
            }
            column(DisbursementDate_Loans; Format(Loans."Disbursement Date"))
            {
            }
            column(LastPayDate_Loans; Format(Loans."Last Pay Date"))
            {
            }
            column(ExpectedDateofCompletion_Loans; Format(Loans."Completion Date"))
            {
            }
            column(LoansCategorySASRA_Loans; Loans."Loans Category-SASRA")
            {
            }
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
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
            column(OutBill; 0)
            {
            }
            column(Picture; Company.Picture)
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
            column(BridgeAmt; BridgeAmt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                sno += 1;

                Loans.CalcFields("Outstanding Principal", "Outstanding Interest");

                if Loans."Outstanding Interest" <= 0 then
                    Loans."Outstanding Interest" := 0;

                CurrentLoanBalance := Loans."Outstanding Principal" + Loans."Outstanding Interest";
                if Loans."Outstanding Principal" <= 0 then
                    CurrReport.Skip;

                ExpectedInterest := Loans."Outstanding Interest";
                if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
                    ExpectedPrincipal := Loans.Repayment - Loans."Outstanding Interest";
                    if ExpectedPrincipal < Loans."Loan Principle Repayment" then begin
                        DefAmt := 0;
                        DefPeriod := 0;
                        //LoansProcess.GetLoanDefaulter(Loans."Loan No.",DefPeriod,DefAmt,AsAt);
                        ExpectedPrincipal := DefAmt - ExpectedInterest;
                        if ExpectedPrincipal < 0 then
                            ExpectedPrincipal := 0;
                    end;
                end
                else
                    ExpectedPrincipal := Loans."Loan Principle Repayment";

                if ExpectedPrincipal > Loans."Outstanding Principal" then
                    ExpectedPrincipal := Loans."Outstanding Principal";

                TotalExpected := ExpectedInterest + ExpectedPrincipal;
                NewLoanBalance := CurrentLoanBalance - TotalExpected;
            end;

            trigger OnPreDataItem()
            begin
                if Loans.GetFilter("Date Filter") = '' then
                    Loans.SetFilter("Date Filter", '..%1', Today);


                AsAt := Loans.GetRangemax("Date Filter");
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
        RSchedule: Record "Loan Repayment Schedule";
        day: Integer;
        BridgeAmt: Decimal;
        DefAmt: Decimal;
        DefPeriod: Integer;
        AsAt: Date;
        ExpectedInterest: Decimal;
        ExpectedPrincipal: Decimal;
        TotalExpected: Decimal;
        NewLoanBalance: Decimal;
        CurrentLoanBalance: Decimal;
}

