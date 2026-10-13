report 50285 "Loan Offset Calculator"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Offset Calculator.rdlc';
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
            column(Net_Refund; "Net Refund")
            {
            }
            column(Total_Deduction; "Total Deduction")
            {
            }
            column(Dividend_Balance; "Dividend Balance")
            {
            }
            column(Withdrawal_Fee; "Withdrawal Fee")
            {
            }
            column(MemberNo; DefaulterLoanRecovery."Member No.")
            {
            }
            column(Name; DefaulterLoanRecovery.Name)
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Entered_By; "Entered By")
            {
            }
            column(HShare_Capital; "Share Capital")
            {
            }
            column(HShare_Capital_Top_Up; "Share Capital Top Up")
            {
            }
            column(Total_Available; "Total Available")
            {
            }
            column(HOutstanding_Interest; "Outstanding Interest")
            {
            }
            column(HOutstanding_Principal; "Outstanding Principal")
            {
            }
            column(HDeposit_Balance; "Deposit Balance")
            {
            }
            column(Waiver; Waiver)
            {
            }
            dataitem(Appraisal; "Offset Appraisal")
            {

                DataItemLink = "Offset No." = field("No.");
                column(Loan_No_; "Loan No.")
                {
                }
                column(Member_No_; "Member No.")
                {
                }
                column(Loan_Product; "Loan Product")
                {
                }
                column(Approved_Amount; "Approved Amount")
                {
                }
                column(Share_Deposits; Savings)
                {
                }
                column(Share_Capital; "Share Capital")
                {
                }
                column(Share_Capital_Top_Up; "Share Capital Top Up")
                {
                }
                column(New_Share_Capital; "New Share Capital")
                {
                }
                column(Outstanding_Interest; "Outstanding Interest")
                {
                }
                column(Interest_Waived; "Interest Waived")
                {
                }

                column(Out__Interest_After_Waiver; "Out. Interest After Waiver")
                {
                }

                column(New_Outstanding_Interest; "New Outstanding Interest")
                {
                }
                column(Outstanding_Balance; "Outstanding Balance")
                {
                }
                column(New_Outstanding_Balance; "New Outstanding Balance")
                {
                }
                column(New_Share_Deposits; "New Savings Balance")
                {
                }
                column(Loan_Balance_Before_Guarantors; "Loan Balance Before Guarantors")
                {
                }

            }
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
