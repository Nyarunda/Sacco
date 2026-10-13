Page 50538 "Agent Tarriff Header"
{
    PageType = List;
    SourceTable = "Agent Tarriff Header";

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(TransTypeAgents; Rec."Trans Type Agents")
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

