Table 50311 "Portal Announcements"
{

    fields
    {
        field(1; id; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Title; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Body; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

