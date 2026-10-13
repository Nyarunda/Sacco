Table 50993 "HR Employee Course of Study"
{

    fields
    {
        field(1; "Code"; Code[50])
        {
            Description = 'Code';
        }
        field(2; Description; Text[75])
        {
            Description = 'Description';
        }
        field(3; "Years of Study"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Description = 'Years of Study';
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

