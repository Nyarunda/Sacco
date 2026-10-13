Table 51102 "HR Interview Details"
{

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; "Item Description"; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

