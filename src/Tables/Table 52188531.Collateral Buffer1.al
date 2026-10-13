
Table 50194 "Collateral Buffer1"
{

    fields
    {
        field(1; "Collateral No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Type; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Collateral No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

