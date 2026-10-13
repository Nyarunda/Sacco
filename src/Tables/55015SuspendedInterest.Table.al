Table 55015 "Suspended Interest"
{

    fields
    {
        field(1; Entry; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Loan No"; Code[20])
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; Period; Date)
        {
        }
    }

    keys
    {
        key(Key1; Entry)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

