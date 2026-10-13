Table 50331 "Statement Buffer"
{

    fields
    {
        field(1; entryNo; Integer)
        {
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; "Opening Balance"; Decimal)
        {
        }
        field(4; "Principal Paid"; Decimal)
        {
        }
        field(5; "Interest Paid"; Decimal)
        {
        }
        field(6; "Amount Paid"; Decimal)
        {
        }
        field(7; "Loan Balance"; Decimal)
        {
        }
        field(8; "Interest Due"; Decimal)
        {
        }
        field(9; "Interest Balance"; Decimal)
        {
        }
        field(10; "Receipt No"; Code[20])
        {
        }
        field(11; "Loan No."; Code[20])
        {
        }
        field(12; ledgerEntry; Integer)
        {
        }
    }

    keys
    {
        key(Key1; entryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

