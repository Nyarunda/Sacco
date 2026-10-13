report 50283 "Loan Offset Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Offset Report.rdlc';
    ApplicationArea = All;
    Caption = 'Loan Offset Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(DefaulterLoanRecovery; "Defaulter Loan Recovery")
        {
            RequestFilterFields = "Posting Date";
            column(No; DefaulterLoanRecovery."No.")
            {
            }
            column(MemberNo; DefaulterLoanRecovery."Member No.")
            {
            }
            column(Name; DefaulterLoanRecovery.Name)
            {
            }

            column(Loan_No_; "Loan No.")
            {
            }
            column(Member_No_; "Member No.")
            {
            }
            column(Loan_Product; '')
            {
            }
            column(Approved_Amount; 0)
            {
            }
            column(Share_Deposits; DefaulterLoanRecovery."Total Available")
            {
            }
            column(Share_Capital; "Share Capital")
            {
            }
            column(Share_Capital_Top_Up; "Share Capital Top Up")
            {
            }
            column(New_Share_Capital; DefaulterLoanRecovery."Share Capital" + DefaulterLoanRecovery."Share Capital Top Up")
            {
            }
            column(Outstanding_Interest; "Outstanding Interest")
            {
            }
            column(Interest_Waived; DefaulterLoanRecovery.Waiver)
            {
            }

            column(Out__Interest_After_Waiver; DefaulterLoanRecovery."Outstanding Interest" - DefaulterLoanRecovery.Waiver)
            {
            }

            column(New_Outstanding_Interest; 0)
            {
            }
            column(Outstanding_Balance; DefaulterLoanRecovery."Outstanding Principal")
            {
            }
            column(New_Outstanding_Balance; NewOutBal)
            {
            }
            column(New_Deposit_Balance; DefaulterLoanRecovery."Deposit Balance")
            {
            }
            column(WithdrawalFee; DefaulterLoanRecovery."Withdrawal Fee")
            {
            }

            column(NetRefund; DefaulterLoanRecovery."Net Refund")
            {
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                NewOutBal := 0;
                Appraisal.Reset();
                Appraisal.SetRange("Offset No.", "No.");
                if Appraisal.FindFirst() then begin
                    repeat
                        NewOutBal += Appraisal."New Outstanding Balance";
                    until Appraisal.Next() = 0;
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


    var
        NewOutBal: decimal;
        Appraisal: Record "Offset Appraisal";

}
