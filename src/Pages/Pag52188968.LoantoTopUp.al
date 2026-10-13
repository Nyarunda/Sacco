namespace VisionSacco.VisionSacco;

page 50544 "Top Up Products"
{
    ApplicationArea = All;
    Caption = 'Loan to Top Up';
    PageType = List;
    SourceTable = "Top Up Products";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Top Up Product"; Rec."Top Up Product")
                {
                    ToolTip = 'Specifies the value of the Top Up Product field.', Comment = '%';
                }
                field("Commission %"; Rec."Commission %")
                {
                    ToolTip = 'Specifies the value of the Commission % field.', Comment = '%';
                }
                field("Commission GL"; Rec."Commission GL")
                {
                    ToolTip = 'Specifies the value of the Commission GL field.', Comment = '%';
                }
                field("Use Payment Threshold"; Rec."Use Payment Threshold")
            {
                ApplicationArea = All;
                ToolTip = 'Enable payment threshold-based commission rates';
            }
            field("Payment Threshold %"; Rec."Payment Threshold %")
            {
                ApplicationArea = All;
                Enabled = Rec."Use Payment Threshold";
                ToolTip = 'Percentage of loan that must be paid to qualify for lower commission rate (e.g., 50%)';
            }
            field("Commission % Above Threshold"; Rec."Commission % Above Threshold")
            {
                ApplicationArea = All;
                Enabled = Rec."Use Payment Threshold";
                ToolTip = 'Commission rate when payment is above threshold (e.g., 1% for those who paid >50%)';
                Style = Favorable;
                StyleExpr = true;
            }
            field("Commission % Below Threshold"; Rec."Commission % Below Threshold")
            {
                ApplicationArea = All;
                Enabled = Rec."Use Payment Threshold";
                ToolTip = 'Commission rate when payment is below threshold (e.g., 2% for those who paid <50%)';
                Style = Unfavorable;
                StyleExpr = true;
            }
               
            }
        }
    }
}
