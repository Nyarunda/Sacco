page 50412 "Escalation Rule FactBox"
{
    Caption = 'Escalation Rule Details';
    PageType = CardPart;
    SourceTable = "Escalation Rules";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("Rule Name"; Rec."Rule Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the escalation rule.';
                }
                field("Priority Level"; Rec."Priority Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level of this escalation rule.';
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the escalation rule is active.';
                }
                field("Execution Count"; Rec."Execution Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many times this rule has been executed.';
                }
                field("Last Execution Date"; Rec."Last Execution Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when this rule was last executed.';
                }
            }
        }
    }
}