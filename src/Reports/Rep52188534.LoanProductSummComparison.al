report 50232 "Loan Product Summ. Comparison"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    Caption = 'Loan Product Summary Comparison';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/Layouts/LoanProductSummaryComparison.rdl';
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
            column(CurrentMonthOutstandingBalance; CurrentMonthOutstandingBalance)
            {

            }

            column(CurrentMonthPreviousYearOutstandingBalance; CurrentMonthPreviousYearOutstandingBalance)
            {

            }
            column(VarianceAnnual; VarianceAnnual)
            {

            }
            column(Contribution; Contribution)
            {

            }
            column(TotalOutstandingBalance; TotalOutstandingBalance)
            {

            }
            column(CurrentSearchDate; SearchDate)
            {
            }
            column(CurrentBalNairobi; CurrentBalNairobi)
            {
            }
            column(CurrentBalMombasa; CurrentBalMombasa)
            {
            }
            column(PreviousSearchDate; CALCDATE('-1M', SearchDate))
            {
            }

            trigger OnAfterGetRecord()
            begin
                CurrentMonthOutstandingBalance := 0;
                CurrentMonthPreviousYearOutstandingBalance := 0;
                VarianceAnnual := 0;
                Contribution := 0;
                CurrentBalMombasa := 0;
                CurrentBalNairobi := 0;

                LoanListing.RESET;
                LoanListing.SETFILTER("Date Filter", '%1..%2', CalcDate('-CM', SearchDate), CalcDate('CM', SearchDate));
                LoanListing.SetRange("Loan Product Type", productsetup."Product ID");
                LoanListing.SetAutoCalcFields("Total Outstanding Balance");
                LoanListing.SetLoadFields("Loan No.", "Total Outstanding Balance");
                IF LoanListing.FindFirst() then begin
                    repeat
                        CurrentMonthOutstandingBalance += LoanListing."Total Outstanding Balance";
                    until LoanListing.NEXT = 0;
                end;

                LoanListing.RESET;
                LoanListing.SETFILTER("Date Filter", '%1..%2', CalcDate('-CM-1M', SearchDate), CalcDate('CM-1M', SearchDate));
                LoanListing.SetRange("Loan Product Type", productsetup."Product ID");
                LoanListing.SetAutoCalcFields("Total Outstanding Balance");
                LoanListing.SetLoadFields("Loan No.", "Total Outstanding Balance");
                IF LoanListing.FindFirst() then begin
                    repeat
                        CurrentMonthPreviousYearOutstandingBalance += LoanListing."Total Outstanding Balance";
                    until LoanListing.NEXT = 0;
                end;

                LoanListing.RESET;
                LoanListing.SETFILTER("Date Filter", '%1..%2', CalcDate('-CM', SearchDate), CalcDate('CM', SearchDate));
                LoanListing.SetAutoCalcFields("Total Outstanding Balance");
                LoanListing.SetLoadFields("Loan No.", "Total Outstanding Balance");
                IF LoanListing.FindFirst() then begin
                    repeat
                        TotalOutstandingBalance += LoanListing."Total Outstanding Balance";
                        if LoanListing."Booking Branch" = 'NAIROBI' then
                            CurrentBalNairobi += LoanListing."Total Outstanding Balance";
                        if LoanListing."Booking Branch" = 'MOMBASA' then
                            CurrentBalMombasa += LoanListing."Total Outstanding Balance";

                    until LoanListing.NEXT = 0;
                end;

                VarianceAnnual := CurrentMonthOutstandingBalance - CurrentMonthPreviousYearOutstandingBalance;
                IF TotalOutstandingBalance > 0 THEN
                    Contribution := ROUND((CurrentMonthOutstandingBalance / TotalOutstandingBalance) * 100, 0.01);

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
        CurrentMonthOutstandingBalance: Decimal;
        CurrentBalNairobi: Decimal;
        CurrentBalMombasa: Decimal;
        PreviousYearDecemberOutstandingBalance: Decimal;
        CurrentMonthPreviousYearOutstandingBalance: Decimal;
        VarianceAnnual: Decimal;
        Contribution: Decimal;
        TotalOutstandingBalance: Decimal;

}
