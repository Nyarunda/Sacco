Table 50414 "Mzawadi Registrations"
{

    fields
    {
        field(1; "Member No."; Code[20])
        {
        }
        field(2; Name; Text[200])
        {
        }
        field(3; "Phone No."; Code[20])
        {
        }
        field(4; Registered; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Member No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

