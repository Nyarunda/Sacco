namespace UnitedWomen_Production.UnitedWomen_Production;

using System.Utilities;

report 50062 "Transfer Loan Securities"
{
    Caption = 'Transfer Loan Securities';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = where(Number = const(1));
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                LoanSecurity: Record "Loan Security";
                LoanSecurityII: Record "Loan Security II";
            begin

                LoanSecurity.Reset();
                if LoanSecurity.FindSet() then begin
                    repeat
                        LoanSecurityII.Init();
                        LoanSecurityII.TransferFields(LoanSecurity);
                        LoanSecurityII.Insert();
                    until LoanSecurity.Next() = 0;
                end;

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
