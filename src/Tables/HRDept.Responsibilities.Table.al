Table 51107 "HR Dept. Responsibilities"
{

    fields
    {
        field(1; "Responsibility code"; Code[20])
        {
        }
        field(2; "Responsibility Description"; Text[250])
        {
        }
        field(3; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Responsibility code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

