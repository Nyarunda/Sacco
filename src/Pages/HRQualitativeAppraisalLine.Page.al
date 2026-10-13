Page 51026 "HR Qualitative Appraisal Line"
{
    Caption = 'HR Qualitative Appraisal Line';
    PageType = ListPart;
    SourceTable = "HR Qualitative Appraisal Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
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
        Rec."Categorize As" := Rec."categorize as"::"Employee's Subordinates";
    end;
}

