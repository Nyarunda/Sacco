Page 51016 "HR Appraisal Eval Areas - EP"
{
    Caption = 'HR Appraisal Evaluation Areas - Employee''s Peers';
    PageType = List;
    SourceTable = "HR 360 Appraisal Lines - JS";
    SourceTableView = where("Categorize As" = const("Employee's Peers"));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Code);
                    end;
                }
                field(UnitofMeasure; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(CategorizeAs; Rec."Categorize As")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SubCategory; Rec."Sub Category")
                {
                    ApplicationArea = Basic;
                }
                field(IncludeinEvaluationForm; Rec."Include in Evaluation Form")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalPeriod; Rec."Appraisal Period")
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
        Rec."Categorize As" := Rec."categorize as"::"Employee's Peers";
        Rec."Include in Evaluation Form" := true;
    end;
}

