
Report 50292 "Net Loans Disbursed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Net Loans Disbursed.rdlc';

    dataset
    {
        dataitem("Product Setup"; "Product Setup")
        {
            RequestFilterFields = "Product ID", "Loan Source";
            DataItemTableView = where("Product Class" = const(Credit));
            column(Product_ID; "Product ID")
            {
            }
            column(Description; Description)
            {
            }
            column(Loan_Source; "Loan Source")
            {
            }

            column(Budget; Budget)
            {
            }
            column(PNextVariance; PNextVariance)
            {
            }
            column(PreviousMonthName; PreviousMonthName)
            {
            }
            column(PreviousBalance; PreviousBalance)
            {
            }
            column(CurrentMonthName; CurrentMonthName)
            {
            }
            column(CurrentBalance; CurrentBalance)
            {
            }
            column(NextMonthName; NextMonthName)
            {
            }
            column(NextBalance; NextBalance)
            {
            }
            column(LastVariance; LastVariance)
            {
            }
            column(NoOfApplications; NoOfApplications)
            {
            }
            column(NextVariance; NextVariance)
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

            trigger OnAfterGetRecord()
            begiN
                sno += 1;
                SearchDate := CalcDate('CM', SearchDate);
                Budget := 0;

                CurrentBalance := Legacy.GetLoansApprovedPerProduct("Product ID", CalcDate('-CM', SearchDate), CalcDate('CM', SearchDate));
                PreviousBalance := Legacy.GetLoansApprovedPerProduct("Product ID", CalcDate('-CM', LastDate), CalcDate('CM', LastDate));
                NextBalance := Legacy.GetLoansApprovedPerProduct("Product ID", CalcDate('-CM', NextDate), CalcDate('CM', NextDate));
                NoOfApplications := Legacy.GetNoOfApplicationsPerProduct("Product ID", CalcDate('-CM', SearchDate), CalcDate('CM', SearchDate));

                BLines.Reset();
                BLines.SetRange("G/L Account No.", "Loan Account [G/L]");
                BLines.SetRange(Date, CalcDate('-CM', SearchDate), CalcDate('CM', SearchDate));
                if BLines.FindFirst() then begin
                    BLines.CalcSums(Amount);
                    Budget := BLines.Amount;
                end;

                LastVariance := 0;
                if Budget > 0 then
                    LastVariance := Round((CurrentBalance - Budget) / Budget * 100);

                NextVariance := CurrentBalance - NextBalance;
                If NextBalance > 0 then
                    PNextVariance := Round(NextVariance / NextBalance * 100);

            end;

            trigger OnPreDataItem()
            begiN
                SearchDate := CalcDate('CM', SearchDate);
                LastDate := CalcDate('-1Y+CM', SearchDate);
                NextDate := CalcDate('1M+CM', SearchDate);
                CurrentMonthName := CopyStr(Format(SearchDate, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy(SearchDate, 3));
                PreviousMonthName := CopyStr(Format(LastDate, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy(LastDate, 3));
                NextMonthName := CopyStr(Format(NextDate, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy(NextDate, 3));




            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Date"; SearchDate)
                {
                    ApplicationArea = Basic;
                }
            }
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
        Company: Record "Company Information";
        SearchDate: Date;
        sno: Integer;
        Loans: Record Loans;
        CurrentMonthName: Text;
        PreviousMonthName: Text;
        NextMonthName: Text;

        CurrentBalance: Decimal;
        PreviousBalance: Decimal;
        NextBalance: Decimal;
        LastVariance: Decimal;

        NoOfApplications: Integer;
        NextVariance: Decimal;
        PNextVariance: Decimal;
        LastDate: Date;
        NextDate: Date;
        Legacy: Codeunit Legacy;
        Budget: Decimal;
        BLines: Record "G/L Budget Entry";



}

