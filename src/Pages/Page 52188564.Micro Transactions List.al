
Page 50227 "Micro Transactions List"
{
    ApplicationArea = Basic;
    CardPageID = "Micro Transactions Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Micro Credit Transactions";
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
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionTime; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field(GroupCode; Rec."Group Code")
                {
                    ApplicationArea = Basic;
                }
                field(GroupName; Rec."Group Name")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Rec.Cashier)
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

