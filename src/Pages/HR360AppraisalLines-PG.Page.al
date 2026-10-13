Page 51024 "HR 360 Appraisal Lines - PG"
{
    Caption = 'HR Appraisal Lines - Personal Goals/Objectives';
    PageType = ListPart;
    SourceTable = "HR Appraisal Lines";
    SourceTableView = where("Categorize As" = const("Personal Goals/Objectives"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(KeyPerformanceIndicator; Rec."Key Performance Indicator")
                {
                    ApplicationArea = Basic;
                }
                field(Weight; Rec."Weight%")
                {
                    ApplicationArea = Basic;
                }
                field(MeasurementCriteria; Rec."Measurement Criteria")
                {
                    ApplicationArea = Basic;
                }
                field(Actualperformance; Rec."Actual performance")
                {
                    ApplicationArea = Basic;
                }
                field(PerformanceRating; Rec."Performance Rating")
                {
                    ApplicationArea = Basic;
                }
                field(WeightedRating; Rec."Weighted Rating")
                {
                    ApplicationArea = Basic;
                }
                field(SelfRating; Rec."Self Rating")
                {
                    ApplicationArea = Basic;
                }
                field(SupervisorRating; Rec."Supervisor Rating")
                {
                    ApplicationArea = Basic;
                }
                field(AgreedRating; Rec."Agreed Rating")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Categorize As" := Rec."categorize as"::"Personal Goals/Objectives";
        Rec."Sub Category" := Rec."sub category"::"Personal Goals";
    end;
}

