Table 51013 "HR Leave Family Groups"
{
    //DrillDownPageID = UnknownPage39005661;
    //LookupPageID = UnknownPage39005661;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Remarks; Text[200])
        {
        }
        field(4; "Max Employees On Leave"; Integer)
        {
            Description = 'Maximum nmber of employees allowed to be on leave at once';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

