page 50560 "HR Appraisal Behaviours"
{
    Caption = 'HR Appraisal Behaviours';
    PageType = ListPart;
    SourceTable = "HR appraisal line";
    SourceTableView = where("Entry Type" = const(Behaviors));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Core Code"; Rec."Core Code")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Core Value 2 field.';
                }
                field("Core Desc."; Rec."Core Desc.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Core Decs field.';
                }
                field("Value Code"; Rec."Value Code")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Value Code field.';
                }
                field("Value Desc."; Rec."Value Desc.")
                {
                    ApplicationArea = All;
                    visible = false;
                    ToolTip = 'Specifies the value of the Value Desc. field.';
                }
                field("Behavioral Assesment"; Rec."Behavioral Assesment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Behavioral Assesment field.';
                }
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rating field.';
                }
                field("Example to Support Rating"; Rec."Example to Support Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Example to Support Rating field.';
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
        Rec."Entry Type" := Rec."Entry Type"::Behaviors;
    end;

}
