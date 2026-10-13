Page 50997 "HR 360 Appraisal Lines - EP"
{
    Caption = 'HR Appraisal Lines - Employee Peers';
    PageType = ListPart;
    SourceTable = "HR Appraisal Lines";
    SourceTableView = where("Categorize As" = const("Employee's Peers"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SubCategory; Rec."Sub Category")
                {
                    ApplicationArea = Basic;
                }
                field(PerfomanceGoalsandTargets; Rec."Perfomance Goals and Targets")
                {
                    ApplicationArea = Basic;
                }
                field(UnitofMeasure; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(MinTargetScore; Rec."Min. Target Score")
                {
                    ApplicationArea = Basic;
                }
                field(MaxTargetScore; Rec."Max Target Score")
                {
                    ApplicationArea = Basic;
                }
                field(WeightedRating; Rec."Weighted Rating")
                {
                    ApplicationArea = Basic;
                }
                field(Actualperformance; Rec."Actual performance")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeComments; Rec."Employee Comments")
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
        Rec."Categorize As" := Rec."categorize as"::"Employee's Subordinates";
    end;
}

