Page 50912 "HR Disciplinary Actions"
{
    PageType = List;
    SourceTable = "HR Disciplinary Actions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ActionCode; Rec."Action Code")
                {
                    ApplicationArea = Basic;
                }
                field(Instance; Rec.Instance)
                {
                    ApplicationArea = Basic;
                }
                field(RecommendedAction; Rec."Recommended Action")
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

