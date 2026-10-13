
Table 50065 "Member Buffer"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Old Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Branch Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; DOB; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "ID No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

