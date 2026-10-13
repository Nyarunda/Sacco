Page 50931 "HR OSAccident Incident line"
{
    PageType = ListPart;
    SourceTable = "HR OSAccident Incident Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(InvestigationNo; Rec."Investigation No.")
                {
                    ApplicationArea = Basic;
                }
                field(Cause; Rec.Cause)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cause';
                }
                field(ResolutionRecommendation; Rec."Resolution/Recommendation")
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

