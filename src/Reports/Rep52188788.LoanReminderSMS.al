
report 50470 "Loan Reminder SMS"
{
    Caption = 'Loan Reminder SMS';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Total Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Loan No.", "Member No.", "Loans Category-SASRA", "Mobile Loan", "Disbursement Date";
            trigger OnAfterGetRecord()
            var
                SaccoActivities: Codeunit "Sacco Activities";
            begin
                SaccoActivities.SendLoanReminderPerLoan(Loans."Loan No.");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
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
}
