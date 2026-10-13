
namespace UnitedWomen.UnitedWomen;

using System.Utilities;
using Microsoft.Foundation.Company;
report 50576 "Loans Product Summary"
{
    Caption = 'Loans Product Summary';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/LoansProductSummary.rdl';

    dataset
    {
        dataitem(HeaderLine; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            column(HeaderCompanyName; CompanyInfo.Name) { }
            column(HeaderCompanyPicture; CompanyInfo.Picture) { }
        }

        dataitem(ProductLoop; "Product Setup")
        {
            DataItemTableView = sorting("Product ID") where("Product Class" = const(Credit));

            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyPicture; CompanyInfo.Picture) { }
            column(ReportTitle; 'LOAN PER PRODUCT SUMMARY') { }
            column(AsAtDateValue; AsAtDate) { }

            column(LoanProduct; Description) { }
            column(NoOfLoans; NoOfLoans) { }
            column(LoanBalance; LoanBalance) { }

            trigger OnPreDataItem()
            begin
                if ProductFilter <> '' then
                    SetRange("Product ID", ProductFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                NoOfLoans := 0;
                LoanBalance := 0;

                LoansRec.Reset();
                LoansRec.SetRange(Posted, true);
                LoansRec.SetRange("Loan Product Type", "Product ID");
                LoansRec.SetRange("Date Filter", 0D, AsAtDate);
                LoansRec.SetFilter("Outstanding Principal", '>0');
                LoansRec.SetAutoCalcFields("Outstanding Principal", "Outstanding Interest");
                LoansRec.SetLoadFields("Outstanding Principal", "Outstanding Interest");
                if LoansRec.FindSet() then
                    repeat

                        NoOfLoans += 1;
                        LoanBalance += LoansRec."Outstanding Principal" + LoansRec."Outstanding Interest";

                    until LoansRec.Next() = 0;

                if (NoOfLoans = 0) and (LoanBalance = 0) then
                    CurrReport.Skip();

                TotalNoOfLoans += NoOfLoans;
                TotalLoanBalance += LoanBalance;
            end;
        }

        dataitem(TotalLine; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            column(TotalNoOfLoans; TotalNoOfLoans) { }
            column(TotalLoanBalance; TotalLoanBalance) { }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field(AsAtDate; AsAtDate)
                    {
                        ApplicationArea = All;
                        Caption = 'As At Date';
                    }

                    field(ProductFilter; ProductFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Loan Product';
                        TableRelation = "Product Setup"."Product ID" where("Product Class" = const(Credit));
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if AsAtDate = 0D then
            AsAtDate := Today;

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        TotalNoOfLoans := 0;
        TotalLoanBalance := 0;
    end;

    var
        CompanyInfo: Record "Company Information";
        LoansRec: Record Loans;

        AsAtDate: Date;
        ProductFilter: Code[20];

        NoOfLoans: Integer;
        LoanBalance: Decimal;

        TotalNoOfLoans: Integer;
        TotalLoanBalance: Decimal;
}
