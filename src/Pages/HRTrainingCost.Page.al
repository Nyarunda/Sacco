Page 50977 "HR Training Cost"
{
    PageType = List;
    SourceTable = "HR Training Cost";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CostItem; Rec."Cost Item")
                {
                    ApplicationArea = Basic;
                }
                field(CostItemDescription; Rec."Cost Item Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cost; Rec.Cost)
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

