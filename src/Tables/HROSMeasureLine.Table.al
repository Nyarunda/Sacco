Table 51037 "HR OSMeasure Line"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; "Measure No"; Code[10])
        {
        }
        field(4; Description; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Measure No")
        {
            Clustered = true;
        }
        key(Key2; "Measure No")
        {
        }
    }

    fieldgroups
    {
    }
}

