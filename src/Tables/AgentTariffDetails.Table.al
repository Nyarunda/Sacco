Table 50394 "Agent Tariff Details"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            TableRelation = "Agent Tarriff Header".Code;
        }
        field(2; "Lower Limit"; Decimal)
        {
        }
        field(3; "Upper Limit"; Decimal)
        {
        }
        field(4; "Charge Amount"; Decimal)
        {
        }
        field(5; "Agent Comm"; Decimal)
        {
        }
        field(6; "Vendor Comm"; Decimal)
        {
        }
        field(7; "Sacco Comm"; Decimal)
        {
        }
        field(8; "Charge Excise Duty"; Boolean)
        {
        }
        field(9; "SMS Charge"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Lower Limit")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

