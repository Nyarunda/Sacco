namespace CentralDB.CentralDB;

xmlport 50085 "Loan Schedule"
{
    Caption = 'Loan Schedule';
    Format = VariableText;


    schema
    {
        textelement(roots)
        {
            tableelement(LoanRepaymentSchedule; "Loan Repayment Schedule")
            {
                AutoUpdate = true;
                fieldelement(LoanNo; LoanRepaymentSchedule."Loan No.")
                {
                }
                fieldelement(LineNo; LoanRepaymentSchedule."Line No.")
                {
                }
                fieldelement(RepaymentDate; LoanRepaymentSchedule."Repayment Date")
                {
                }
                fieldelement(Principal; LoanRepaymentSchedule."Monthly Principal")
                {
                }
                fieldelement(Interest; LoanRepaymentSchedule."Monthly Interest")
                {
                }
                fieldelement(Repayment; LoanRepaymentSchedule."Monthly Repayment")
                {
                }
            }
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
