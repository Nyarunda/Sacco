
Table 50303 MemberBalancesFromOld
{

    fields
    {
        field(1; IDNo; Code[120])
        {
            DataClassification = ToBeClassified;
        }
        field(2; MNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; MName; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; DecDepo; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; DecShare; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; JanDepo; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; JanShare; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; FebDepo; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; FebShare; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; MarDepo; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; MarShare; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; MNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

