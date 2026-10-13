Page 50539 "Agent Tariff Details"
{
    PageType = ListPart;
    SourceTable = "Agent Tariff Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field(SaccoComm; Rec."Sacco Comm")
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
                field(SMSCharge; Rec."SMS Charge")
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

