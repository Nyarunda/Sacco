page 50562 "HR Appraisal Pillar Objectives"
{
    Caption = 'HR Appraisal Pillar Objectives';
    PageType = ListPart;
    SourceTable = "HR Appraisal Objectives";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Appraisal Pillar"; Rec."Appraisal Pillar")
                {
                    ApplicationArea = All;
                }
                field("Key Value Driver"; Rec."Key Value Driver")
                {
                    ApplicationArea = All;
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = All;
                }
                field("Target in Figures"; Rec."Target in Figures")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
