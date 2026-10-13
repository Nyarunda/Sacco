Page 51019 "HR Appraisal Company Target"
{
    Caption = 'HR Appraisal Evaluation Areas - Job Specific';
    PageType = List;
    SourceTable = "HR Appraisal Company Target";

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
                }
                field(Score; Rec.Score)
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
        //"Categorize As":="Categorize As"::"Job Specific";
        //"Include in Evaluation Form":=TRUE;
    end;
}

