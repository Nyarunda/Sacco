namespace AL_.AL_;

report 50478 "Rev-Loans Interest Overpayment"
{
    ApplicationArea = All;
    Caption = 'Rev-Loans Interest Overpayment';
    dataset
    {
        dataitem(Loans; Loans)
        {
            column(LoanNo; "Loan No.")
            {
            }
            column(RepaymentStartDate; "Repayment Start Date")
            {
            }
            column(DisbursementDate; "Disbursement Date")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            trigger OnAfterGetRecord()
            var
                Loans: Record Loans;
            begin

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(DateFilter)
                {
                    field(SDate; SDate)
                    {
                        ApplicationArea = All;
                    }
                    field(EDate; EDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {

            }
        }
    }
    var
        SDate: Date;
        EDate: Date;
        Arrears: Decimal;
}
