namespace UnitedWomen_Production.UnitedWomen_Production;
using Microsoft.Finance.GeneralLedger.Ledger;

report 50022 "Correct Loans GL Entry"
{
    Caption = 'Correct Loans GL Entry';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Loan Product Type";
            trigger OnAfterGetRecord()
            var
                GLEntry: Record "G/L Entry";
            begin


                //Pro
                GLEntry.Reset();
                GLEntry.SetRange("Loan No.", Loans."Loan No.");
                GLEntry.SetRange("G/L Account No.", '14190');
                if GLEntry.FindFirst() then begin
                    GLEntry."G/L Account No." := '14112';
                    GLEntry.Modify();
                end;

                //Pro
                GLEntry.Reset();
                GLEntry.SetRange("Loan No.", Loans."Loan No.");
                GLEntry.SetRange("G/L Account No.", '14821');
                if GLEntry.FindFirst() then begin
                    GLEntry."G/L Account No." := '14805';
                    GLEntry.Modify();
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
