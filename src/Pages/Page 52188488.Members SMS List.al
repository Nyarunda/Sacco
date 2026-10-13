
Page 50151 "Members SMS List"
{
    PageType = List;
    SourceTable = "Member SMS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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

