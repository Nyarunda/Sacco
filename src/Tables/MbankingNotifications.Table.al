Table 50373 "Mbanking Notifications"
{

    fields
    {
        field(1; Guid; Guid)
        {
        }
        field(2; Type; Option)
        {
            OptionMembers = " ","FOSA Statement","BOSA Statement";
        }
        field(3; "Account No"; Code[20])
        {
        }
        field(4; "Filter SDate"; Date)
        {
        }
        field(5; "Filter EDate"; Date)
        {
        }
        field(6; "E-Mail"; Text[200])
        {
        }
        field(7; Sent; Boolean)
        {
        }
        field(8; "Date Sent"; Date)
        {
        }
    }

    keys
    {
        key(Key1; Guid)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

