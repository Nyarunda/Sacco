page 50596 AgentTarrif
{
    Caption = 'AgentTarrif';
    PageType = Card;
    SourceTable = "Agent Tariff Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Agent Comm"; Rec."Agent Comm")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent Comm field.';
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge Amount field.';
                }
                field("Charge Excise Duty"; Rec."Charge Excise Duty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge Excise Duty field.';
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lower Limit field.';
                }
                field("SMS Charge"; Rec."SMS Charge")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SMS Charge field.';
                }
                field("Sacco Comm"; Rec."Sacco Comm")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sacco Comm field.';
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Upper Limit field.';
                }
                field("Vendor Comm"; Rec."Vendor Comm")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Comm field.';
                }
            }
        }
    }
}
