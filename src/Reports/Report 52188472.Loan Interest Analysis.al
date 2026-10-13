
Report 50135 "Loan Interest Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Interest Analysis.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Disbursement Date" = filter(<> ''), Posted = const(true), "Stop Interest Due" = filter(false), "Loan Product Type" = filter(<> '279'));
            column(ReportForNavId_1; 1)
            {
            }
            column(IssuedDate; Format(Loans."Disbursement Date"))
            {
            }
            column(LoanNo; Loans."Loan No.")
            {
            }
            column(ProductType; Loans."Loan Product Type")
            {
            }
            column(ClientCode; Loans."Member No.")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(ClientName; Loans."Member Name")
            {
            }
            column(InterestDue; InterestAmount)
            {
            }
            column(InterestPaid; IntPaid)
            {
            }
            column(InterestArrears; InterestAmount)
            {
            }
            column(SDate; Format(SDate))
            {
            }
            column(EDate; Format(EDate))
            {
            }
            column(LoanBalance; Loans."Outstanding Principal")
            {
            }
            column(InterestAmount; InterestAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin


                InterestAmount := 0;

                if "Disbursement Date" <> 0D then begin
                    PayDay := Date2dmy(Loans."Disbursement Date", 1);
                    if PayDay < Date2dmy(SDate, 1) then
                        CurrReport.Skip;
                end;

                LRec.Reset;
                LRec.SetRange("Loan No.", Loans."Loan No.");
                LRec.SetFilter("Outstanding Principal", '>0');
                if LRec.FindFirst then begin
                    LRec.CalcFields(LRec."Interest Due Date");
                    if LRec."Interest Due Date" < CalcDate('-CM', SDate) then begin
                        PayDay := Date2dmy(LRec."Disbursement Date", 1);

                        MonthEnd := CalcDate('CM', SDate);
                        if PayDay > Date2dmy(MonthEnd, 1) then
                            PayDay := Date2dmy(MonthEnd, 1);

                        IntDate := Date2dmy(SDate, 1);

                        if (PayDay >= IntDate) and ("Disbursement Date" <> Today) and (PayDay <= Date2dmy(EDate, 1)) then
                            InterestAmount := ROUND(Periodic.GetInterestAmount(Loans."Loan No.", SDate, SDate, false), 0.01, '>');
                    end;
                end;

                if InterestAmount <= 0 then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin

                Loans.SetFilter("Loan Product Type", '<>%1', 'HISTORICAL');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; SDate)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; EDate)
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

    var
        LRec: Record Loans;
        IntDue: Decimal;
        IntPaid: Decimal;
        IntArrears: Decimal;
        SDate: Date;
        EDate: Date;
        PayDay: Integer;
        Periodic: Codeunit "Sacco Activities";
        MonthEnd: Date;
        IntDate: Integer;
        InterestAmount: Decimal;
}

