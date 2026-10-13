namespace UnitedWomen.UnitedWomen;

using System.Utilities;
using Microsoft.Foundation.Company;

report 50570 "Loan Product Analysis"
{
    Caption = 'Loan Product Analysis';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/LoanProductAnalysis.rdl';

    dataset
    {
        dataitem(ProductLoop; "Product Setup")
        {
            DataItemTableView = sorting("Product ID") where("Product Class" = const(Credit));
            column(ReportTitle; 'LOAN PRODUCT ANALYSIS') { }
            column(AsAtDateValue; AsAtDate) { }

            column(ProductNo; RowNo) { }
            column(ProductID; "Product ID") { }
            column(ProductName; Description) { }
            column(ApprovedAmount; ApprovedAmount) { }
            column(NetDisbursed; NetDisbursed) { }
            column(CurrentBalance; CurrentBalance) { }

            trigger OnPreDataItem()
            begin
                if ProductFilter <> '' then
                    SetRange("Product ID", ProductFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                ApprovedAmount := 0;
                NetDisbursed := 0;
                CurrentBalance := 0;

                ProductLoan.Reset();
                ProductLoan.SetRange("Loan Product Type", "Product ID");
                ProductLoan.SetRange(Posted, true);
                ProductLoan.SetRange("Date Filter", 0D, AsAtDate);
                ProductLoan.SetAutoCalcFields("Outstanding Principal", "Total Disbursed", "Outstanding Interest");
                ProductLoan.SetLoadFields("Outstanding Principal", "Approved Amount", "Total Disbursed", "Outstanding Interest");
                if ProductLoan.FindSet() then
                    repeat

                        ApprovedAmount += ProductLoan."Approved Amount";
                        NetDisbursed += ProductLoan."Total Disbursed";
                        CurrentBalance += ProductLoan."Outstanding Principal" + ProductLoan."Outstanding Interest";

                    until ProductLoan.Next() = 0;

                if (ApprovedAmount = 0) and
                   (NetDisbursed = 0) and
                   (CurrentBalance = 0) then
                    CurrReport.Skip();

                RowNo += 1;

                TotalApprovedAmount += ApprovedAmount;
                TotalNetDisbursed += NetDisbursed;
                TotalCurrentBalance += CurrentBalance;
            end;
        }

        dataitem(CategoryLoop; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = filter(1 .. 5));

            column(CategoryName; GetCategoryName(Number)) { }
            column(CategoryLoanBalance; CategoryLoanBalance) { }
            column(CategoryLoanCount; CategoryLoanCount) { }
            column(CategoryArrears; CategoryArrears) { }
            column(CategoryPAR; CategoryPAR) { }

            trigger OnAfterGetRecord()
            begin
                CalculateCategory(Number);

                if (CategoryLoanBalance = 0) and
                   (CategoryLoanCount = 0) and
                   (CategoryArrears = 0) then
                    CurrReport.Skip();
            end;
        }

        dataitem(TotalLine; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            column(CompanyName; CompanyInformation.Name) { }
            column(CompanyLogo; CompanyInformation.Picture) { }
            column(TotalApprovedAmount; TotalApprovedAmount) { }
            column(TotalNetDisbursed; TotalNetDisbursed) { }
            column(TotalCurrentBalance; TotalCurrentBalance) { }
            column(TotalCategoryLoanBalance; TotalCategoryLoanBalance) { }
            column(TotalCategoryLoanCount; TotalCategoryLoanCount) { }
            column(TotalCategoryArrears; TotalCategoryArrears) { }
            column(TotalCategoryPAR; 100) { }
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

        CompanyInformation.Get();
        companyInformation.CalcFields(Picture);

        ClearTotals();
    end;

    var
        ProductLoan: Record Loans;
        CompanyInformation: Record "Company Information";
        AsAtDate: Date;
        ProductFilter: Code[20];
        RowNo: Integer;

        ApprovedAmount: Decimal;
        NetDisbursed: Decimal;
        CurrentBalance: Decimal;

        TotalApprovedAmount: Decimal;
        TotalNetDisbursed: Decimal;
        TotalCurrentBalance: Decimal;

        CategoryLoanBalance: Decimal;
        CategoryLoanCount: Integer;
        CategoryArrears: Decimal;
        CategoryPAR: Decimal;

        TotalCategoryLoanBalance: Decimal;
        TotalCategoryLoanCount: Integer;
        TotalCategoryArrears: Decimal;

    local procedure ClearTotals()
    begin
        RowNo := 0;

        TotalApprovedAmount := 0;
        TotalNetDisbursed := 0;
        TotalCurrentBalance := 0;

        TotalCategoryLoanBalance := 0;
        TotalCategoryLoanCount := 0;
        TotalCategoryArrears := 0;
    end;

    local procedure CalculateCategory(CategoryNo: Integer)
    var
        Loan: Record Loans;
    begin
        CategoryLoanBalance := 0;
        CategoryLoanCount := 0;
        CategoryArrears := 0;
        CategoryPAR := 0;

        Loan.Reset();
        Loan.SetRange(Posted, true);
        Loan.SetRange("Date Filter", 0D, AsAtDate);

        if ProductFilter <> '' then
            Loan.SetRange("Loan Product Type", ProductFilter);

        case CategoryNo of
            1:
                Loan.SetRange("Loans Category-SASRA", Loan."Loans Category-SASRA"::Performing);
            2:
                Loan.SetRange("Loans Category-SASRA", Loan."Loans Category-SASRA"::Watch);
            3:
                Loan.SetRange("Loans Category-SASRA", Loan."Loans Category-SASRA"::Substandard);
            4:
                Loan.SetRange("Loans Category-SASRA", Loan."Loans Category-SASRA"::Doubtful);
            5:
                Loan.SetRange("Loans Category-SASRA", Loan."Loans Category-SASRA"::Loss);
        end;

        Loan.SetAutoCalcFields(
            "Outstanding Principal",
            "Principal Arrears",
            "Interest Arrears");
        Loan.SetLoadFields(
            "Outstanding Principal",
            "Principal Arrears",
            "Interest Arrears");
        if Loan.FindSet() then
            repeat

                if Loan."Outstanding Principal" > 0 then begin
                    CategoryLoanBalance += Loan."Outstanding Principal";
                    CategoryArrears += Loan."Principal Arrears" + Loan."Interest Arrears";
                    CategoryLoanCount += 1;
                end;
            until Loan.Next() = 0;

        TotalCategoryLoanBalance += CategoryLoanBalance;
        TotalCategoryLoanCount += CategoryLoanCount;
        TotalCategoryArrears += CategoryArrears;

        if TotalCurrentBalance <> 0 then
            CategoryPAR := Round((CategoryLoanBalance / TotalCurrentBalance) * 100, 0.01, '=');
    end;

    local procedure GetCategoryName(CategoryNo: Integer): Text[30]
    begin
        case CategoryNo of
            1:
                exit('Performing');
            2:
                exit('Watch');
            3:
                exit('Substandard');
            4:
                exit('Doubtful');
            5:
                exit('Loss');
        end;

        exit('');
    end;
}