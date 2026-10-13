Table 50598 "Sky Staggered Charges"
{
    DrillDownPageID = "Sky Staggered Charges";
    LookupPageID = "Sky Staggered Charges";

    fields
    {
        field(1; "No."; Code[10])
        {
        }
        field(2; Minimum; Decimal)
        {
        }
        field(3; Maximum; Decimal)
        {
        }
        field(4; Charge; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.", Minimum)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

