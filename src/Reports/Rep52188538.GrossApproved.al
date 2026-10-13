report 50250 "Gross Approved"
{
    ApplicationArea = All;
    Caption = 'Gross Approved';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Gross Approved Disb.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(ProductSetup; "Product Setup")
        {
            column(Description; Description)
            {
            }
            column(ProductID; "Product ID")
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(TotalAmount2; TotalAmount2)
            {
            }
            column(period; period)
            {
            }
            column(period1; period1)
            {
            }
            column(Variance; Variance)
            {
            }
            column(Loan_Source; "Loan Source")
            {
            }
            column(CompanyName; Company.Name)
            {
            }
            column(CompanyPicture; Company.Picture)
            {
            }
            trigger OnPreDataItem()
            begin
                SetRange("Product Class", "Product Class"::Credit);
                Company.Get;
                Company.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;
                TotalAmount2 := 0;
                year := 0;
                year2 := 0;
                year := Date2DMY(AsAt, 1);
                year2 := Date2DMY(EndAt, 1);
                Dates.Reset();
                Dates.SetRange("Period Type", dates."Period Type"::Year);
                Dates.SetRange("Period No.", year);
                if Dates.FindFirst() then begin
                    Loans.Reset();
                    Loans.SetRange(Posted, true);
                    Loans.SetFilter("Disbursement Date", '%1..%2', Dates."Period Start", Dates."Period End");
                    Loans.SetRange(Loans."Loan Product Type", "Product ID");
                    if Loans.FindFirst() then begin
                        repeat
                            TotalAmount += Loans."Approved Amount";
                        Until Loans.Next() = 0;
                    end;
                    period := 'JAN ' + Format(Dates."Period No.");

                end;

                Dates.Reset();
                Dates.SetRange("Period Type", dates."Period Type"::Year);
                Dates.SetRange("Period No.", year2);
                if Dates.FindFirst() then begin
                    Loans.Reset();
                    Loans.SetRange(Posted, true);
                    Loans.SetFilter("Disbursement Date", '%1..%2', Dates."Period Start", Dates."Period End");
                    Loans.SetRange(Loans."Loan Product Type", "Product ID");
                    if Loans.FindFirst() then begin
                        repeat
                            TotalAmount2 += Loans."Approved Amount";
                        Until Loans.Next() = 0;
                    end;
                    period1 := 'JAN ' + Format(Dates."Period No.");
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(AsAt; AsAt)
                {
                    ApplicationArea = All;

                }
                field(EndAt; EndAt)
                {
                    ApplicationArea = All;

                }
                group(GroupName)
                {
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
        year: Integer;
        year2: Integer;
        Budget: Decimal;
        variance: Decimal;
        period: text;
        period1: text;
        Sdate: Date;
        Dates: Record Date;
        AsAt: Date;
        EndAt: Date;
        Amount: Decimal;
        TotalAmount: Decimal;
        TotalAmount2: Decimal;
        Loans: Record Loans;
        company: record "Company Information";
}
