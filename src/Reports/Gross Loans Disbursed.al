
Report 50287 "Gross Loans Disbursed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Gross Loans Disbursed.rdlc';

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

                CurrentBalance := Legacy.GetLoansApprovedPerProduct("Product ID", 0D, CalcDate('CM', SearchDate));
                PreviousBalance := Legacy.GetLoansApprovedPerProduct("Product ID", 0D, CalcDate('CM', LastDate));
                NextBalance := Legacy.GetLoansApprovedPerProduct("Product ID", 0D, CalcDate('CM', NextDate));
                NoOfApplications := Legacy.GetNoOfApplicationsPerProduct("Product ID", CalcDate('-CM', SearchDate), CalcDate('CM', SearchDate));

                LastVariance := 0;
                if PreviousBalance > 0 then
                    LastVariance := Round((CurrentBalance - PreviousBalance) / PreviousBalance * 100);
                NextVariance := CurrentBalance - NextBalance;

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
                // field("End Date"; EndDate)
                // {
                //     ApplicationArea = Basic;
                // }
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
        EndDate: Date;
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
        LastDate: Date;
        NextDate: Date;
        Legacy: Codeunit Legacy;



}

