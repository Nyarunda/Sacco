Table 51048 "HR Succession Requirements"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Job ID"; Code[20])
        {
            TableRelation = "HR Jobs"."Job ID";
        }
        field(3; "Requirement Code"; Code[20])
        {
        }
        field(4; Requirement; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Job ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

