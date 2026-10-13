Page 50530 "Sky Agencies"
{
    CardPageID = "Sky Agencies Page";
    PageType = List;
    SourceTable = "Sky Agency Companies";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Location; Rec.Location)
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

