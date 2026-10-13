
Page 50173 "Job Titles"
{
    PageType = List;
    SourceTable = "Job Titles";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Title; Rec.Title)
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

