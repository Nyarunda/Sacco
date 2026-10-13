
Table 50288 "Sky Safcom Corporate Charges"
{

    fields
    {
        field(2; Minimum; Decimal)
        {
        }
        field(3; Maximum; Decimal)
        {
        }
        field(4; Charge; Decimal)
        {
        }
        field(5; Category; Option)
        {
            OptionMembers = Safaricom,Bank;
        }
    }

    keys
    {
        key(Key1; Minimum, Category)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

