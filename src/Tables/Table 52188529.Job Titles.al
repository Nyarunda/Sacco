
Table 50192 "Job Titles"
{
    DrillDownPageID = "Job Titles";
    LookupPageID = "Job Titles";

    fields
    {
        field(1; Title; Code[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Title)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

