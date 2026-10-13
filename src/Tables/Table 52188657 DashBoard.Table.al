Table 50320 DashBoard
{

    fields
    {
        field(1; Date; Date)
        {
        }
        field(2; "Total Income"; Decimal)
        {
        }
        field(3; "Total Expense"; Decimal)
        {
        }
        field(4; "Loan Portfolio"; Decimal)
        {
        }
        field(5; "Active Accounts"; Integer)
        {
        }
        field(6; "Dormant Accounts"; Integer)
        {
        }
        field(7; Assets; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

