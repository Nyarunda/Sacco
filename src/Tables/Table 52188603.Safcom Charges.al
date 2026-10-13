
Table 50266 "Safcom Charges"
{

    fields
    {
        field(2; Minimum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Maximum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Charge; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Category; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Safaricom,Bank;
        }
    }

    keys
    {
        key(Key1; Minimum)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

