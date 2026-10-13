namespace CentralDB.CentralDB;

using System.Utilities;

report 50490 "Send Emails"
{
    Caption = 'Send Emails';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = where(Number = const(1));
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                SaccoActivities: Codeunit "Sacco Activities";
                MemberActivities: Codeunit "Member Activities";
                LoanSource: Enum "Loan Source";
            begin
                SaccoActivities.SendLoansEmails('', LoanSource);
                Sleep(1000);
                MemberActivities.RegistrationEmail();
                SaccoActivities.SendPartialLoansEmails('', LoanSource::"Partial Letter");
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
