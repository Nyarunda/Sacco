page 50561 "HR Appraisal Objectives"
{
    Caption = 'HR Appraisal Objectives';
    PageType = ListPart;
    SourceTable = "HR Appraisal Line";
    AutoSplitKey = true;
    SourceTableView = where("Entry Type" = const(Objectives));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Pillar; Rec.Pillar)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pillar field.';
                }
                field("Key Value Driver"; Rec."Key Value Driver")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Key Value Driver field.';
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Weight field.';
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target field.';
                }
                field("Target in Figures"; Rec."Target in Figures")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target in Figures field.';
                }
                field("Self Rating"; Rec."Self Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Self rating field';
                }
                field("Actual Achievement"; Rec."Actual Achievement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual Achievement field.';
                }
                field("Achievement/Expected Target %"; Rec."Achievement/Expected Target %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Achievement/Expected Target % field.';
                }
                field("Weighted Average"; Rec."Weighted Average")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Weighted Average field.';
                }
                field("Appraisers Comments"; Rec."Appraisers Comments")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appraisers Comments field.';
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Entry Type" := Rec."Entry Type"::Objectives;
    end;
}
