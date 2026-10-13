Table 50352 "Transactions Buffer"
{

    fields
    {
        field(1; Guid; Guid)
        {
        }
        field(2; Date; DateTime)
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; "Account No."; Code[20])
        {
        }
        field(5; Reversed; Boolean)
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Transaction ID"; Code[20])
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

