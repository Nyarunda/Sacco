page 50609 "Salary Grades List"
{
    ApplicationArea = All;
    Caption = 'Salary Grades List';
    PageType = List;
    SourceTable = "Salary Grades";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Salary Grade"; Rec."Salary Grade")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Salary Grade field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Amount field.';
                }
                field("Maxmum Amount"; Rec."Maxmum Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maxmum Amount field.';
                }
                field("Leave Allowance"; Rec."Leave Allowance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Allowance field.';
                }
            }
        }
    }
}
