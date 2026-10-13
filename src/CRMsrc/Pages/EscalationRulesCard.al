page 50411 "Escalation Rules Card"
{
    ApplicationArea = All;
    Caption = 'Escalation Rule Card';
    PageType = Card;
    SourceTable = "Escalation Rules";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the escalation rule.';
                    MultiLine = true;
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
            }
            group("Trigger Settings")
            {
                Caption = 'Trigger Settings';
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
                field("Max Escalations"; Rec."Max Escalations")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum number of escalations allowed.';
                }
            }
            group("Assignment")
            {
                Caption = 'Assignment';
                field("Escalate To User ID"; Rec."Escalate To User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user ID to escalate to.';

                    trigger OnValidate()
                    begin
                        Rec."Escalate To User Name" := Rec.GetEscalateToUserName();
                    end;
                }
                field("Escalate To User Name"; Rec."Escalate To User Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the user to escalate to.';
                }
                field("CC User ID"; Rec."CC User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user ID to copy on escalation notifications.';
                }
                field("Email Template Code"; Rec."Email Template Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email template to use for escalation notifications.';
                }
            }
            group("Filters")
            {
                Caption = 'Filters';
                field("Customer Filter"; Rec."Customer Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a customer filter for this escalation rule.';
                }
                field("Item Category Filter"; Rec."Item Category Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies an item category filter for this escalation rule.';
                }
            }
            group("Timing")
            {
                Caption = 'Timing';
                field("Business Hours Only"; Rec."Business Hours Only")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether escalations should only occur during business hours.';
                }
                field("Working Days Only"; Rec."Working Days Only")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether escalations should only occur on working days.';
                }
            }
            group("Statistics")
            {
                Caption = 'Statistics';
                field("Execution Count"; Rec."Execution Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many times this rule has been executed.';
                    Editable = false;
                }
                field("Last Execution Date"; Rec."Last Execution Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when this rule was last executed.';
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when this rule was created.';
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created this rule.';
                    Editable = false;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when this rule was last modified.';
                    Editable = false;
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who last modified this rule.';
                    Editable = false;
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
                ToolTip = 'Test this escalation rule.';

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
                ToolTip = 'Manually execute this escalation rule.';

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