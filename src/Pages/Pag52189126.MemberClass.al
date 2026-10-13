page 50828 "Member Class"
{
    ApplicationArea = All;
    Caption = 'Member Class';
    PageType = List;
    SourceTable = "Member Class";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member Class"; Rec."Member Class")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Class field.';
                }
                field("Minimum Registration Fee"; Rec."Minimum Registration Fee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Registration Fee field.';
                }
                field("Default Share Capital"; Rec."Default Share Capital")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Share Capital field.';
                }
                field("Default Share Deposits"; Rec."Default Share Deposits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Share Deposits field.';
                }
                field("Minimum Share Capital"; Rec."Minimum Share Capital")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Share Capital field.';
                }
                field("Minimum Share Deposits"; Rec."Minimum Share Deposits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Share Deposits field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
