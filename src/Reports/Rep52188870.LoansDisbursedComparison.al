report 50572 "Loans Disbursed Comparison"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/LoansDisbursedComparison.rdl';

    dataset
    {
        dataitem(MonthLoop; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = filter(1 .. 12));
            column(MonthNo; Number) { }
            column(MonthName; Format(DMY2Date(1, Number, YearParam), 0, '<Month Text,3>')) { }
            column(YearSelected; YearParam) { }
            column(ApplicationsCY; ApplicationsCY) { }
            column(DisbursedCntCY; DisbursedCntCY) { }

            column(NetDisbursedCY; NetDisbursedCY) { }

            column(ApprovedCY; ApprovedCY) { }

            column(NetDisbursedPY; NetDisbursedPY) { }

            column(ApprovedPY; ApprovedPY) { }

            column(Picture; CompanyInfo.Picture) { }

            trigger OnAfterGetRecord()
            var
                StartDate: Date;
                EndDate: Date;
                StartDatePY: Date;
                EndDatePY: Date;
            begin
                StartDate := DMY2Date(1, Number, YearParam);
                EndDate := CalcDate('<CM>', StartDate);

                ApplicationsCY := CountApplications(StartDate, EndDate);
                DisbursedCntCY := CountDisbursed(StartDate, EndDate);
                NetDisbursedCY := SumDisbursed(StartDate, EndDate);
                ApprovedCY := SumApproved(StartDate, EndDate);

                StartDatePY := CalcDate('-1Y', StartDate);
                EndDatePY := CalcDate('-1Y', EndDate);

                NetDisbursedPY := SumDisbursed(StartDatePY, EndDatePY);
                ApprovedPY := SumApproved(StartDatePY, EndDatePY);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(YearParam; YearParam)
                {
                    ApplicationArea = All;
                    Caption = 'Report Year';
                }

                field(ProductFilter; ProductFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Product';
                    TableRelation = "Product Setup"."Product ID";
                }

                field(LoanSourceFilter; LoanSourceFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Loan Source';
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        if YearParam = 0 then
            YearParam := Date2DMY(Today, 3);

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;


    var
        YearParam: Integer;
        ProductFilter: Code[20];
        LoanSourceFilter: Option All,BOSA,FOSA,MICRO;
        CompanyInfo: Record "Company Information";

        ApplicationsCY: Integer;
        DisbursedCntCY: Integer;
        NetDisbursedCY: Decimal;
        ApprovedCY: Decimal;
        NetDisbursedPY: Decimal;
        ApprovedPY: Decimal;

    local procedure CountApplications(StartDate: Date; EndDate: Date): Integer
    var
        Loan: Record Loans;
    begin
        PrepareLoanFilters(Loan);
        Loan.SetRange("Application Date", StartDate, EndDate);
        exit(Loan.Count());
    end;

    local procedure CountDisbursed(StartDate: Date; EndDate: Date): Integer
    var
        Loan: Record Loans;
    begin
        PrepareLoanFilters(Loan);
        Loan.SetRange("Disbursement Date", StartDate, EndDate);
        exit(Loan.Count());
    end;

    local procedure SumDisbursed(StartDate: Date; EndDate: Date): Decimal
    var
        Loan: Record Loans;
        Total: Decimal;
    begin
        PrepareLoanFilters(Loan);
        Loan.SetRange("Disbursement Date", StartDate, EndDate);

        if Loan.FindSet() then
            repeat
                Total += Loan."Amount To Disburse";
            until Loan.Next() = 0;

        exit(Total);
    end;

    local procedure SumApproved(StartDate: Date; EndDate: Date): Decimal
    var
        Loan: Record Loans;
        Total: Decimal;
    begin
        PrepareLoanFilters(Loan);
        Loan.SetRange("Disbursement Date", StartDate, EndDate);

        if Loan.FindSet() then
            repeat
                Total += Loan."Approved Amount";
            until Loan.Next() = 0;

        exit(Total);
    end;

    local procedure PrepareLoanFilters(var Loan: Record Loans)
    var
        Product: Record "Product Setup";
        ProductList: Text;
    begin
        Loan.Reset();

        if ProductFilter <> '' then
            Loan.SetRange("Loan Product Type", ProductFilter);

        if LoanSourceFilter = LoanSourceFilter::All then
            exit;

        Product.Reset();
        if ProductFilter <> '' then
            Product.SetRange("Product ID", ProductFilter);
        Product.SetRange("Product Class", Product."Product Class"::Credit);

        case LoanSourceFilter of
            LoanSourceFilter::BOSA:
                Product.SetRange("Loan Source", Product."Loan Source"::BOSA);
            LoanSourceFilter::FOSA:
                Product.SetRange("Loan Source", Product."Loan Source"::FOSA);
            LoanSourceFilter::MICRO:
                Product.SetRange("Loan Source", Product."Loan Source"::MICRO);
        end;

        if Product.FindSet() then
            repeat
                if ProductList <> '' then
                    ProductList += '|';

                ProductList += Product."Product ID";
            until Product.Next() = 0;

        if ProductList <> '' then
            Loan.SetFilter("Loan Product Type", ProductList)
        else
            Loan.SetRange("Loan Product Type", '');
    end;
}