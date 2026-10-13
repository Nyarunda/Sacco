Table 51014 "HR Leave Family Employees"
{
    //DrillDownPageID = UnknownPage39005662;
    //LookupPageID = UnknownPage39005662;

    fields
    {
        field(1; Family; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Leave Family Groups".Code;
        }
        field(2; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Succession Job Rotation"."Line No.";
        }
        field(3; Remarks; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; Family, "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

