
Table 50250 "Coop Setup"
{

    fields
    {
        field(1; No; Integer)
        {
        }
        field(2; "Coop Commission Account"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(3; "Coop Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(4; "Coop Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(5; "Daily Withdrawal Limit"; Decimal)
        {
        }
        field(6; "Transactional Withdrawal Limit"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

