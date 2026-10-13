
Page 50206 "Collateral Return List"
{
    ApplicationArea = Basic;
    CardPageID = "Collateral Return Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Collateral Collection";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Listing";
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Collateral; Rec.Collateral)
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

