
Table 50215 "Cheque Set Up_"
{
    DrillDownPageID = "Cheque Setup";
    LookupPageID = "Cheque Setup";

    fields
    {
        field(1; "Cheque Code"; Code[30])
        {
        }
        field(2; "Number Of Leaf"; Integer)
        {
        }
        field(3; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Cheque Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cheque Code", "Number Of Leaf", Amount)
        {
        }
    }
}

