Table 50207 "Coop ATM Charges"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Minimum; Decimal)
        {
        }
        field(3; Maximum; Decimal)
        {
        }
        field(4; "Bank Commission"; Decimal)
        {
        }
        field(5; "Sacco Commission"; Decimal)
        {
        }
        field(6; Terminal; Code[10])
        {
        }
        field(7; Channel; Code[10])
        {
        }
        field(8; "Sacco Per Every"; Decimal)
        {
        }
        field(9; "Daily Limit"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Code", Terminal, Channel, Minimum)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

