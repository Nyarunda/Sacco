page 50030 "Member Statistics All"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = Members;

    layout
    {
        area(content)
        {
            group("Savings Statistics")
            {
                part(Accounts; "Member Accounts Listpart")
                {
                    SubPageLink = "Member No." = field("No.");
                }
            }
            group("Loans Statistics")
            {

                part(Loans; "Member Loans Listpart")
                {
                    SubPageLink = "Member No." = field("No.");
                }
            }
            group("Credit Statistics")
            {

                part(Credit; "Credit Account Listpast")
                {
                    SubPageLink = "Member No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
    }

    var
        UserSetup: Record "User Setup";
}

