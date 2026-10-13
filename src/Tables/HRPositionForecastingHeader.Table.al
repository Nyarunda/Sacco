Table 51079 "HR Position Forecasting Header"
{

    fields
    {
        field(1; Region; Code[20])
        {
        }
        field(2; Department; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; Region)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

