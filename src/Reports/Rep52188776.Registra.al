namespace CentralDB.CentralDB;
using System.Utilities;

report 50458 "Recover Interest"
{
    Caption = 'Recover Interest';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Total Arrears" = filter('>0'));

            trigger OnAfterGetRecord()
            var
                MA: Codeunit "Member Activities";
            begin
                // MA.InterestRecovery(Loans);
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
