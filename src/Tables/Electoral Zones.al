table 50530 "Electoral Zones"
{
    LookupPageID = "Electoral Zones List";

    fields
    {
        field(1; Type; Option)
        {
            OptionMembers = " ","Electral Zone","Area Service Centers";
        }
        field(2; "Code"; Code[20])
        {
        }
        field(3; Description; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

