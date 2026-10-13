Page 50537 "Agent Tarriff Details"
{
    PageType = List;
    SourceTable = "Agent Tariff Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(LowerLimit; Rec."Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field(UpperLimit; Rec."Upper Limit")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeAmount; Rec."Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field(AgentComm; Rec."Agent Comm")
                {
                    ApplicationArea = Basic;
                }
                field(VendorComm; Rec."Vendor Comm")
                {
                    ApplicationArea = Basic;
                }
                field(SaccoComm; Rec."Sacco Comm")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeExciseDuty; Rec."Charge Excise Duty")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

