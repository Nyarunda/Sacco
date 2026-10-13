
Table 50159 "FD Interest Rates"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Minimum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Maximum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Int Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Margin; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", Minimum)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

