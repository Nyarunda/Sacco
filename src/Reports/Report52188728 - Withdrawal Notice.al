report 50391 "Withdrawal Notice"
{
    DefaultLayout = RDLC;
    Caption = 'Member Exit Notice';
    RDLCLayout = './src/Layouts/Withdrawal Notice.rdlc';

    dataset
    {
        dataitem("Member withdrawal Notice"; "Member Exit Notice")
        {
            column(CName; Company.Name)
            {
            }
            column(CAddress; Company.Address)
            {
            }
            column(CPicture; Company.Picture)
            {
            }
            column(No_MemberwithdrawalNotice; "Member withdrawal Notice"."No.")
            {
            }
            column(MemberNo_MemberwithdrawalNotice; "Member withdrawal Notice"."Member No.")
            {
            }
            column(Reasonforwithdrawal_MemberwithdrawalNotice; "Member withdrawal Notice"."Reason for withdrawal")
            {
            }
            column(WithdrawaNoticelDate_MemberwithdrawalNotice; "Member withdrawal Notice"."Withdrawa Noticel Date")
            {
            }
            column(MaturityDate_MemberwithdrawalNotice; "Member withdrawal Notice"."Maturity Date")
            {
            }
            column(ClosureType_MemberwithdrawalNotice; "Member withdrawal Notice"."Entered By")
            {
            }

            dataitem(Members; Members)
            {
                DataItemLink = "No." = FIELD("Member No.");
                column(Shares; Shares)
                {
                }
                column(LoanBal; LoanBal)
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.Get;
        Company.CalcFields(Company.Picture);
    end;

    var
        Shares: Decimal;
        LoanBal: Decimal;
        Company: Record "Company Information";
}

