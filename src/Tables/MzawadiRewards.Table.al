Table 50415 "Mzawadi Rewards"
{

    fields
    {
        field(1; "Member No."; Code[20])
        {
        }
        field(2; Name; Text[200])
        {
        }
        field(3; Guid; Text[200])
        {
        }
        field(4; Rewarded; Boolean)
        {
        }
        field(5; Date; Date)
        {
        }
        field(6; Time; Time)
        {
        }
        field(7; Command; Text[30])
        {
        }
        field(8; "Created By"; Code[50])
        {
        }

        field(9; "Date Created"; Date)
        {
        }
        field(10; initiated; Boolean)
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

