Page 51053 "HR Hiring Criteria"
{
    PageType = List;
    SourceTable = "HR Hiring Criteria";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ApplicationCode; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                }
                field(HiringCriteria; Rec."Hiring Criteria")
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

