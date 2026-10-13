page 50604 "PR Salary Advance List"
{
    ApplicationArea = All;
    Caption = 'PR Salary Advance List';
    PageType = List;
    SourceTable = "PR Salary Advance";
    CardPageId = "PR Salary Advance Card";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }

                field(" Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the  Application Date field.';
                }
                field("Advance Amount Requested"; Rec."Advance Amount Requested")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Advance Amount Requested field.';
                }

            }
        }
    }
}
