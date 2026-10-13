
Page 50325 "Non-Member Listing"
{
    PageType = List;
    SourceTable = "Non-Member Listing";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(MobilePhoneNo; Rec."Mobile Phone No.")
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

