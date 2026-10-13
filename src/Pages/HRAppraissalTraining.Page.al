Page 51072 "HR Appraissal Training"
{
    Caption = 'HR Appraissal Training';
    CardPageID = "HR Appraissal Appeal";
    PageType = List;
    SourceTable = "HR Appraissal Training";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(PerformanceGap; Rec."Performance Gap")
                {
                    ApplicationArea = Basic;
                }
                field(TrainingRequired; Rec."Training Required")
                {
                    ApplicationArea = Basic;
                }
                field(ExpectedPerformance; Rec."Expected Performance")
                {
                    ApplicationArea = Basic;
                }
                field(TimeFrame; Rec."Time Frame")
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

