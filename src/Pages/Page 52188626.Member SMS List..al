
Page 50289 "Member SMS List."
{
    PageType = List;
    SourceTable = "Member SMS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MemberNo; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Rec.Source)
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

