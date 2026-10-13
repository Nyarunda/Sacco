Page 51025 "HR 360 Appraisal Lines - JS"
{
    Caption = 'HR Appraisal Lines - Job Specific';
    PageType = ListPart;
    SourceTable = "HR 360 Appraisal Lines - JS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Rec.Description)
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
        Rec."Categorize As" := Rec."categorize as"::"Job Specific";
    end;
}

