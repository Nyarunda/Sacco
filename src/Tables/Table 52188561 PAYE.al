
Table 50224 PAYE
{

    fields
    {
        field(1; "Tier Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "PAYE Tier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Rate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "PAYE Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Tier Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

