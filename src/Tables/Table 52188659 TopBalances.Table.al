Table 50322 "Top Balances"
{

    fields
    {
        field(1; "Account No."; Code[20])
        {
        }
        field(2; Name; Text[200])
        {
        }
        field(3; Balance; Decimal)
        {
        }
        field(4; Product; Text[50])
        {
        }
        field(5; UserName; Code[50])
        {
        }
        field(7; "Member No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Account No.", UserName)
        {
            Clustered = true;
        }
        key(Key2; Balance)
        {
        }
    }

    fieldgroups
    {
    }
}

