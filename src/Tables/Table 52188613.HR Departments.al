
Table 50276 "HR Departments"
{
    DrillDownPageID = "HR Deparments";
    LookupPageID = "HR Deparments";

    fields
    {
        field(1; Department; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Leave Applicants Limit"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Department)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

