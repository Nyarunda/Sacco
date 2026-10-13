
Report 50294 "Gross Loan Portfolio"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Gross Loan Portfolio.rdlc';

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

                CurrentBalance := Legacy.GetTotalOutstandingBalancePerProduct("Product ID", CalcDate('CM', SearchDate));
                PreviousBalance := Legacy.GetTotalOutstandingBalancePerProduct("Product ID", CalcDate('CM', LastDate));
                NextBalance := Legacy.GetTotalOutstandingBalancePerProduct("Product ID", CalcDate('CM', NextDate));
                NoOfApplications := Legacy.GetNoOfApplicationsPerProduct("Product ID", CalcDate('-CM', SearchDate), CalcDate('CM', SearchDate));

                LastVariance := CurrentBalance - PreviousBalance;
                PortfCont := 0;
                if TotalLoanBal > 0 then
                    PortfCont := round(CurrentBalance / TotalLoanBal * 100);
                NextVariance := CurrentBalance - NextBalance;


                PVar := 0;
                if NextBalance > 0 then
                    PVar := round(NextVariance / NextBalance * 100);

            end;

            trigger OnPreDataItem()
            var
                Loans: Record Loans;
            begiN
                SearchDate := CalcDate('CM', SearchDate);
                LastDate := CalcDate('-1Y+CM', SearchDate);
                NextDate := CalcDate('CY', LastDate);
                CurrentMonthName := CopyStr(Format(SearchDate, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy(SearchDate, 3));
                PreviousMonthName := CopyStr(Format(LastDate, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy(LastDate, 3));
                NextMonthName := CopyStr(Format(NextDate, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy(NextDate, 3));


                PSetup.Reset();
                PSetup.SetRange("Product Class", PSetup."Product Class"::Credit);
                if PSetup.FindFirst() then begin
                    repeat
                        TotalLoanBal := 0;
                        Loans.Reset();
                        Loans.SetRange("Loan Product Type", PSetup."Product ID");
                        Loans.SetFilter("Date Filter", '..%1', CalcDate('CM', SearchDate));
                        if Loans.FindFirst() then begin
                            repeat
                                Loans.CalcFields("Total Outstanding Balance");
                                TotalLoanBal += Loans."Total Outstanding Balance";
                            until Loans.Next() = 0;
                        end;
                    until PSetup.Next() = 0;
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
        LastDate: Date;
        NextDate: Date;
        Legacy: Codeunit Legacy;
        PortfCont: Decimal;
        PSetup: Record "Product Setup";
        TotalLoanBal: Decimal;
        PVar: Decimal;



}

