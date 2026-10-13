Table 55021 "Dividend Advance - Defaulter"
{

    fields
    {
        field(1; "Count"; Integer)
        {
        }
        field(2; "No."; Code[20])
        {
        }
        field(3; Name; Text[200])
        {
        }
        field(4; "Staff No."; Code[100])
        {
        }
        field(5; "Phone No."; Code[100])
        {
        }
        field(6; "ID No."; Code[100])
        {
        }
        field(7; Deposits; Decimal)
        {
        }
        field(8; "Qualifying Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

