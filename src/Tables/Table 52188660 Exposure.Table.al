Table 50323 Exposure
{

    fields
    {
        field(1; "Member No."; Code[20])
        {
        }
        field(2; Name; Text[100])
        {
        }
        field(3; "Total Loans"; Decimal)
        {
        }
        field(4; "Member Deposits"; Decimal)
        {
        }
        field(5; Security; Decimal)
        {
        }
        field(6; Date; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Member No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

