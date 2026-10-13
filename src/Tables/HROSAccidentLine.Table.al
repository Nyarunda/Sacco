Table 51036 "HR OSAccident Line"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; "Accident No"; Code[10])
        {
        }
        field(4; Description; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Accident No")
        {
            Clustered = true;
        }
        key(Key2; "Accident No")
        {
        }
    }

    fieldgroups
    {
    }
}

