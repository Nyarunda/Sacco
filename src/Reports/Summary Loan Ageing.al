
Report 50295 "Summary Loan Ageing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Summary Loan Ageing.rdlc';

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
            column(PortfCont; PortfCont)
            {
            }
            column(PVar; PVar)
            {
            }
            column(PreviousMonthName; PreviousMonthName)
            {
            }
            column(PreviousMonthName2; PreviousMonthName2)
            {
            }
            column(PreviousMonthName3; PreviousMonthName3)
            {
            }
            column(CurrentNonPerformingBalance; CurrentNonPerformingBalance)
            {
            }
            column(CurrentPerformingBalance; CurrentPerformingBalance)
            {
            }
            column(CurrentPerformingPercentage; CurrentPerformingPercentage)
            {
            }
            column(TotalArrears; TotalArrears)
            {
            }
            column(PreviousNonPerformingBalance; PreviousNonPerformingBalance)
            {
            }
            column(PreviousNonPerformingBalance2; PreviousNonPerformingBalance2)
            {
            }
            column(PreviousNonPerformingBalance3; PreviousNonPerformingBalance3)
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
            var
                Days: Integer;
                DefAmt: Decimal;
                PerformingBal: Decimal;
                NonPerformingBal: Decimal;
            begiN
                sno += 1;
                Days := 31;
                SearchDate := CalcDate('CM', SearchDate);
                TotalArrears := 0;



                DefAmt := 0;
                NonPerformingBal := 0;
                PerformingBal := 0;
                CurrentBalance := Legacy.GetNonPerformingLoansPerProduct("Product ID", CalcDate('CM', SearchDate), Days, DefAmt, NonPerformingBal, PerformingBal);
                CurrentNonPerformingBalance := NonPerformingBal;
                CurrentPerformingBalance := PerformingBal;
                CurrentPerformingPercentage := 0;
                if CurrentBalance > 0 then
                    CurrentPerformingPercentage := Round(CurrentNonPerformingBalance / CurrentBalance * 100);

                TotalArrears := DefAmt;



                DefAmt := 0;
                NonPerformingBal := 0;
                PerformingBal := 0;
                Legacy.GetNonPerformingLoansPerProduct("Product ID", CalcDate('CM', LastDate), Days, DefAmt, NonPerformingBal, PerformingBal);
                PreviousNonPerformingBalance := NonPerformingBal;
                LastVariance := CurrentNonPerformingBalance - PreviousNonPerformingBalance;



                DefAmt := 0;
                NonPerformingBal := 0;
                PerformingBal := 0;
                CurrentBalance := Legacy.GetNonPerformingLoansPerProduct("Product ID", CalcDate('CM', LastDate2), Days, DefAmt, NonPerformingBal, PerformingBal);
                PreviousNonPerformingBalance2 := NonPerformingBal;



                DefAmt := 0;
                NonPerformingBal := 0;
                PerformingBal := 0;
                Legacy.GetNonPerformingLoansPerProduct("Product ID", CalcDate('CM', LastDate3), Days, DefAmt, NonPerformingBal, PerformingBal);
                PreviousNonPerformingBalance3 := NonPerformingBal;


            end;

            trigger OnPreDataItem()
            begiN
                SearchDate := CalcDate('CM', SearchDate);
                LastDate := CalcDate('-1M+CM', SearchDate);
                LastDate2 := CalcDate('-2M+CM', SearchDate);
                LastDate3 := CalcDate('-3M+CM', SearchDate);

                CurrentMonthName := CopyStr(Format(SearchDate, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy(SearchDate, 3));
                PreviousMonthName := CopyStr(Format(LastDate, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy(LastDate, 3));
                PreviousMonthName2 := CopyStr(Format(LastDate2, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy(LastDate2, 3));
                PreviousMonthName3 := CopyStr(Format(LastDate3, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy(LastDate3, 3));
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
        PreviousMonthName2: Text;
        PreviousMonthName3: Text;
        NextMonthName: Text;

        CurrentBalance: Decimal;
        PreviousPerformingPercentage: Decimal;
        CurrentPerformingPercentage: Decimal;
        CurrentPerformingBalance: Decimal;
        CurrentNonPerformingBalance: Decimal;
        PreviousNonPerformingBalance: Decimal;
        PreviousNonPerformingBalance2: Decimal;
        PreviousNonPerformingBalance3: Decimal;
        NextBalance: Decimal;
        LastVariance: Decimal;

        NoOfApplications: Integer;
        NextVariance: Decimal;
        LastDate: Date;
        LastDate2: Date;
        LastDate3: Date;
        NextDate: Date;
        Legacy: Codeunit Legacy;
        PortfCont: Decimal;
        PVar: Decimal;
        TotalArrears: Decimal;



}

