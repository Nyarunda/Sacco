
Table 50269 "Mbanking Logs"
{

    fields
    {
        field(1; "Entry Code"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Start Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Expiry Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

