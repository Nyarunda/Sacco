Page 50904 "HR Applicant Hobbies"
{
    PageType = List;
    SourceTable = "HR Applicant Hobbies";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Hobby; Rec.Hobby)
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

