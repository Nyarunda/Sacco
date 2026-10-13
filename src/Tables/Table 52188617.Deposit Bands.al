
Table 50280 "Deposit Bands"
{

    fields
    {
        field(1; Minimum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Maximum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Loan Product"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan Product", Minimum)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

