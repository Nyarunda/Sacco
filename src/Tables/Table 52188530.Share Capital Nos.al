
Table 50193 "Share Capital Nos"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Member Found"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Journal Updated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

