
Page 50159 "MBanking Lines"
{
    PageType = ListPart;
    SourceTable = "MBanking Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Accounts List";
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

