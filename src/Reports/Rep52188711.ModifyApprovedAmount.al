report 50374 "Modify Approved Amount"
{
    ApplicationArea = All;
    Caption = 'Modify Approved Amount';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Loan No." = filter('LN_120429'));
            column(LoanNo; "Loan No.")
            {
            }
            column(ApprovedAmount; "Approved Amount")
            {
            }

            trigger onAfterGetRecord()
            begin
                if "Loan No." = 'LN_120429' then begin

                    Loans."Approved Amount" := Loans."Approved Amount" * -1;
                    Loans.Modify();
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
