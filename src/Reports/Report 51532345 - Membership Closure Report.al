report 50386 "Membership Closure Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Membership Closure Report.rdl';
    Caption = 'Member Exit Notice Report';


    dataset
    {
        dataitem("Membership closure"; "Member Exit")
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
            column(No; "Membership closure"."No.")
            {
            }
            column(MemberNo; "Membership closure"."Member No.")
            {
            }
            column(MemberName; "Membership closure"."Member Name")
            {
            }
            column(ClosingDate; "Membership closure"."Closing Date")
            {
            }
            column(TotalLoan; "Membership closure"."Total Principal")
            {
            }
            column(TotalInterest; "Membership closure"."Total Interest")
            {
            }
            column(MemberSavings; "Membership closure"."Member Savings")
            {
            }
            column(ClosureType; "Membership closure"."Closure Type")
            {
            }
            column(RefundableDeposit; "Membership closure"."Total Refundable")
            {
            }
            dataitem("Member withdrawal Notice"; "Member Exit Notice")
            {
                DataItemLink = "Member No." = FIELD("Member No.");
                column(WithdrawaNoticelDate_MemberwithdrawalNotice; "Member withdrawal Notice"."Withdrawa Noticel Date")
                {
                }
                column(No_MemberwithdrawalNotice; "Member withdrawal Notice"."No.")
                {
                }
                column(Reasonforwithdrawal_MemberwithdrawalNotice; "Member withdrawal Notice"."Reason for withdrawal")
                {
                }
                column(MaturityDate_MemberwithdrawalNotice; "Member withdrawal Notice"."Maturity Date")
                {
                }
                column(Occupation_Status; "Occupation Status")
                {
                }
                column(Recommendation_Comments;"Recommendation Comments")
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
        Company: Record "Company Information";
}

