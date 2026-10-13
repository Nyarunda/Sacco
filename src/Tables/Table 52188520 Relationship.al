
Table 50183 Relationship
{
    DrillDownPageID = Relationship;
    LookupPageID = Relationship;

    fields
    {
        field(1; Relationship; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Relationship)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

