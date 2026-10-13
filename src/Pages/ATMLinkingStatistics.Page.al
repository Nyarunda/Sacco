Page 50448 "ATM Linking Statistics"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ATM Linking  Statistics";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LinkingType; Rec."Linking Type")
                {
                    ApplicationArea = Basic;
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(ActivityDate; Rec."Activity Date")
                {
                    ApplicationArea = Basic;
                }
                field(ActivityTime; Rec."Activity Time")
                {
                    ApplicationArea = Basic;
                }
                field(Reasonforchange; Rec."Reason for change")
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

