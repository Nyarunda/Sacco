
Table 50242 "HR Leave Family Employees."
{
    //DrillDownPageID = UnknownPage39005662;
    //LookupPageID = UnknownPage39005662;

    fields
    {
        field(1; Family; Code[20])
        {
            NotBlank = true;
            //TableRelation = Table39003932.Field1;
        }
        field(2; "Employee No"; Code[20])
        {
            NotBlank = true;
            //TableRelation = Table39003910.Field1;
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

