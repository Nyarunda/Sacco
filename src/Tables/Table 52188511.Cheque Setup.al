
Table 50174 "Cheque Setup"
{

    fields
    {
        field(1; "Cheque Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Number Of Leaf"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Cheque Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

