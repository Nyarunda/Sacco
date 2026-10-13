report 50252 "Loan Portfolio Summary"

{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    Caption = 'Loan Portfoli Summary';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/Layouts/LoanPortfolioSummary.rdl';
    dataset
    {
        dataitem(productsetup; "product setup")
        {
            DataItemTableView = where("Product Class" = filter(Credit));
            column(ProductID; productsetup."Product ID")
            {

            }
            column(ProductDescription; productsetup.Description)
            {

            }
            column(TotalOutstandingBalance; TotalOutstandingBalance)
            {

            }
            column(NoOfLoans; NoOfLoans)
            {

            }
            column(PercentageCount; PercentageCount)
            {

            }
            column(TotalNoOfLoans; TotalNoOfLoans)
            {

            }
            column(LoansAverage; LoansAverage)
            {

            }
            column(LoansIssuedForMonth; LoansIssuedForMonth)
            {

            }
            column(SearchDate; SearchDate)
            {

            }

            trigger OnAfterGetRecord()
            begin
                TotalOutstandingBalance := 0;
                NoOfLoans := 0;
                TotalNoOfLoans := 0;
                PercentageCount := 0;
                LoansAverage := 0;
                LoansIssuedForMonth := 0;

                LoanListing.RESET;
                LoanListing.SETFILTER("Disbursement Date", '..%1', SearchDate);
                LoanListing.SetRange("Loan Product Type", productsetup."Product ID");
                IF LoanListing.FindFirst() then begin
                    repeat
                        LoanListing.CalcFields("Total Outstanding Balance");
                        TotalOutstandingBalance += LoanListing."Total Outstanding Balance";
                        NoOfLoans += 1;
                    until LoanListing.NEXT = 0;
                end;
                LoanListing.RESET;
                LoanListing.SETFILTER("Disbursement Date", '..%1', SearchDate);
                IF LoanListing.FindSet() then
                    TotalNoOfLoans := LoanListing.COUNT;

                LoanListing.RESET;
                LoanListing.SETFILTER("Disbursement Date", '%1..%2', CalcDate('-CM', SearchDate), CalcDate('CM', SearchDate));
                LoanListing.SetRange("Loan Product Type", productsetup."Product ID");
                IF LoanListing.FindSet() then
                    LoansIssuedForMonth := LoanListing.COUNT;


                IF TotalNoOfLoans > 0 then
                    PercentageCount := Round((NoOfLoans / TotalNoOfLoans) * 100, 0.01);
                IF NoOfLoans > 0 then
                    LoansAverage := Round((TotalOutstandingBalance / NoOfLoans) * 100, 0.01);

            end;

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Date)
                {
                    Caption = 'Select Month';
                    field(SearchDate; SearchDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Select Month';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        LoanListing: Record Loans;
        SearchDate: Date;
        TotalOutstandingBalance: Decimal;
        NoOfLoans: integer;
        TotalNoOfLoans: integer;
        LoansIssuedForMonth: integer;
        PercentageCount: Decimal;
        LoansAverage: Decimal;

}
