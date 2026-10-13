
Table 50298 "Dummy Loans"
{

    fields
    {
        field(1; "Phone No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Message; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Name; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Phone No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

