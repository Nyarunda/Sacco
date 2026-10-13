Page 51032 "HR Company Target Line"
{
    PageType = List;
    SourceTable = "HR Company Target Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LineNo; Rec."Line No")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalNo; Rec."Appraisal No")
                {
                    ApplicationArea = Basic;
                }
                field(PerspectiveCode; Rec."Perspective Code")
                {
                    ApplicationArea = Basic;
                }
                field(PerspectiveDescription; Rec."Perspective Description")
                {
                    ApplicationArea = Basic;
                }
                field(TargetedScore; Rec."Targeted Score")
                {
                    ApplicationArea = Basic;
                }
                field(Perspectivetype; Rec."Perspective type")
                {
                    ApplicationArea = Basic;
                }
                field(AchievedScore; Rec."Achieved Score")
                {
                    ApplicationArea = Basic;
                }
                field(UnachievedTargets; Rec."Unachieved Targets")
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

