namespace CentralDB.CentralDB;

report 50446 "Delete Posted Loan"
{
    //ApplicationArea = All;
    Caption = 'Delete Posted Loan ';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(LoanInterestBuffer; Loans)
        {
            RequestFilterFields = "Loan No.", "Member No.";

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                LoanInterestBuffer.Delete();
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
