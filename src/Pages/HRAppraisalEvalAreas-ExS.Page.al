Page 51017 "HR Appraisal Eval Areas - ExS"
{
    Caption = 'HR Appraisal Evaluation Areas - External Sources';
    PageType = List;
    SourceTable = "HR 360 Appraisal Lines - JS";
    SourceTableView = where("Categorize As" = const("External Sources"));

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
        Rec."Categorize As" := Rec."categorize as"::"External Sources";
        Rec."Include in Evaluation Form" := true;
    end;
}

