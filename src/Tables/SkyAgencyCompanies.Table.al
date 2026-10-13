Table 50386 "Sky Agency Companies"
{

    fields
    {
        field(1; ID; Code[30])
        {
        }
        field(2; Name; Text[50])
        {
        }
        field(3; Location; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

