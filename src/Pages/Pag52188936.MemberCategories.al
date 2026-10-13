/// <summary>
/// Page Member Categories (ID 50638).
/// </summary>
page 50638 "Member Categories"
{
    ApplicationArea = All;
    Caption = 'Member Categories';
    PageType = List;
    SourceTable = "Member Categories";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Deposit Amount"; Rec."Deposit Amount")
                {
                    ToolTip = 'Specifies the value of the Deposit Amount field.';
                }
                field("Share Capital"; Rec."Share Capital")
                {
                    ToolTip = 'Specifies the value of the Share Capital field.';
                }
            }
        }
    }
}
