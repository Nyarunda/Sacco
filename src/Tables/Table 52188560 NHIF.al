
Table 50223 NHIF
{

    fields
    {
        field(1; "Tier Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            SQLDataType = Integer;
        }
        field(2; "NHIF Tier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Lower Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Upper Limit"; Decimal)
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

