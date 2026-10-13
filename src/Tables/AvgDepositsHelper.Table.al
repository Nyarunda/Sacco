Table 50377 "Avg Deposits Helper"
{

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Checkoff Deposits"; Decimal)
        {
        }
        field(4; "Non Checkoff Deposits"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

