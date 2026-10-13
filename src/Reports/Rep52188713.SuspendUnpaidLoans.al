report 50376 "Suspend Unpaid Loans"
{
    ApplicationArea = All;
    Caption = 'Suspend Unpaid Loans';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(posted = const(true), "Last Pay Date" = filter(<> 0D));
            column(LoanNo; "Loan No.")
            {
            }
            column(ApprovedAmount; "Approved Amount")
            {
            }
            column(DisbursementDate; "Disbursement Date")
            {
            }
            column(RepayMode; "Repay Mode")
            {
            }
            column(Installments; Installments)
            {
            }
            column(OutstandingPrincipal; "Outstanding Principal")
            {
            }
            column(PrincipalArrears; "Principal Arrears")
            {
            }
            column(LastPrincipalPayDate; "Last Principal Pay Date")
            {
            }
            column(OutstandingInterest; "Outstanding Interest")
            {
            }
            column(TotalOutstandingBalance; "Total Outstanding Balance")
            {
            }
            column(AnnualInterest; "Annual Interest %")
            {
            }
            column(LastPayDate; "Last Pay Date")
            {
            }

            trigger onpredataitem()
            begin
                Loans.setfilter("Last Pay Date", '..%1', CalcDate('-6M', Today));
            end;

            trigger onaftergetrecord()
            var
                SaccoAct: Codeunit "Sacco Activities";
                DocNo: Text;
            begin
                CalcFields("Last Pay Date");
                DocNo := 'Suspend Interest Due' + ' ' + CopyStr(Format("Last Pay Date", 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy("Last Pay Date", 3));

                // SaccoAct.SuspendInterest(DocNo, Loans."Loan No.", "Last Pay Date");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
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
}
