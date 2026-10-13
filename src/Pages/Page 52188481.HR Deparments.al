
Page 50144 "HR Deparments"
{
    PageType = List;
    SourceTable = "HR Departments";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Department; Rec.Department)
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

