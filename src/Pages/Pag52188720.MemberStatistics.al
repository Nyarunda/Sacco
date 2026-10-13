page 50395 "Member Statistics"
{
    ApplicationArea = All;
    Caption = 'Member Statistics';
    PageType = Card;
    SourceTable = Members;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {

            part(Accounts; "Member Accounts Listpart")
            {
                SubPageLink = "Member No." = field("No.");
            }
            part(Loans; "Member Loans Listpart")
            {
                SubPageLink = "Member No." = field("No.");
            }

        }
    }
}
