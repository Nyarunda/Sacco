page 50410 "Escalation Rules List"
{
    ApplicationArea = All;
    Caption = 'Escalation Rules';
    PageType = List;
    SourceTable = "Escalation Rules";
    UsageCategory = Lists;
    CardPageId = "Escalation Rules Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Rule Code"; Rec."Rule Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique code for the escalation rule.';
                }
                field("Rule Name"; Rec."Rule Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the escalation rule.';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source type that triggers this escalation rule.';
                }
                field("Priority Level"; Rec."Priority Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level of this escalation rule.';
                }
                field("Escalation Trigger"; Rec."Escalation Trigger")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the trigger type for this escalation rule.';
                }
                field("Trigger Value"; Rec."Trigger Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the trigger value for the escalation.';
                }
                field("Time Unit"; Rec."Time Unit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the time unit for the trigger value.';
                }
                field("Escalate To User ID"; Rec."Escalate To User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user ID to escalate to.';
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the escalation rule is active.';
                }
                field("Auto Execute"; Rec."Auto Execute")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the escalation rule executes automatically.';
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
        area(factboxes)
        {
            part("Escalation Rule Details"; "Escalation Rule FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Rule Code" = field("Rule Code");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Test Rule")
            {
                ApplicationArea = All;
                Caption = 'Test Rule';
                Image = TestFile;
                ToolTip = 'Test the selected escalation rule.';

                trigger OnAction()
                begin
                    if Rec.ValidateRule() then
                        Message('Escalation rule %1 is valid.', Rec."Rule Code");
                end;
            }
            action("Execute Rule")
            {
                ApplicationArea = All;
                Caption = 'Execute Rule';
                Image = ExecuteBatch;
                ToolTip = 'Manually execute the selected escalation rule.';

                trigger OnAction()
                begin
                    if Confirm('Do you want to execute escalation rule %1?', false, Rec."Rule Code") then begin
                        Rec.IncrementExecutionCount();
                        Message('Escalation rule %1 has been executed.', Rec."Rule Code");
                    end;
                end;
            }
            action("Escalation History")
            {
                ApplicationArea = All;
                Caption = 'Escalation History';
                Image = History;
                RunObject = page "Escalation History List";
                RunPageLink = "Rule Code" = field("Rule Code");
                ToolTip = 'View the escalation history for this rule.';
            }
        }
        area(navigation)
        {
            action("Setup")
            {
                ApplicationArea = All;
                Caption = 'Setup';
                RunObject = page "Escalation Setup";
                Image = Setup;
                ToolTip = 'Open escalation setup.';
            }
        }
    }
}
