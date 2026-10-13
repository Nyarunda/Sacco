Table 55003 Banks
{

    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Bank Name"; Text[150])
        {
        }
        field(3; Branch; Text[150])
        {
        }
        field(4; "Branch Code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Bank Code", "Bank Name", "Branch Code", Branch)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

