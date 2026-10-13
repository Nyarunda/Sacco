
Table 50214 "Refference Number_"
{

    fields
    {
        field(1; CurrUserID; Code[50])
        {
        }
        field(2; "Reference No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; CurrUserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

