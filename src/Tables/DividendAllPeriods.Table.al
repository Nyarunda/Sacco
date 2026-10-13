Table 50336 "Dividend Periods"
{

    fields
    {
        field(1; No; Integer)
        {
        }
        field(2; Year; Code[4])
        {
        }
        field(3; "Start Date"; Date)
        {
        }
        field(4; "End Date"; Date)
        {
        }
        field(5; "Div Year"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

