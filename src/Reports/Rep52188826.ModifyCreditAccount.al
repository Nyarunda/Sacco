namespace UnitedWomen_Production.UnitedWomen_Production;

report 50528 "Modify Credit Account"
{
    Caption = 'Modify Credit Account';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.";

            trigger OnAfterGetRecord()
            var
                CreditAcc: Record "Credit Accounts";
                OldNo: Code[20];
                NewNo: Code[20];
                LnAcc: Code[20];
                CLedgers: Record "Credit Ledger Entry";
                SaccoActivities: Codeunit "Sacco Activities";
                LSchedule: Record "Loan Repayment Schedule";
                RunBal: Decimal;
            begin

                LSchedule.Reset();
                LSchedule.SetRange("Loan No.", Loans."Loan No.");
                if LSchedule.FindFirst() then begin
                    RunBal := Loans."Approved Amount";
                    repeat
                        RunBal -= LSchedule."Monthly Principal";
                        LSchedule."Loan Balance" := RunBal;
                        LSchedule.Modify();

                    until LSchedule.Next() = 0;
                end;

                /*
                LnAcc := SaccoActivities.CreateCreditAccount(Loans);

                if Loans."Loan Account" <> LnAcc then begin
                    Loans."Loan Account" := LnAcc;
                    Loans.Modify();
                end;

                CLedgers.Reset();
                CLedgers.SetRange("Loan No.", Loans."Loan No.");
                if CLedgers.FindSet() then begin

                    repeat
                        Loans.TestField("Loan Account");
                        CLedgers."Account No." := Loans."Loan Account";
                        CLedgers.Modify();
                    until CLedgers.Next() = 0;
                end;

                */

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
