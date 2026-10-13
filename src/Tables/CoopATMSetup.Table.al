Table 50334 "Coop ATM  Setup"
{

    fields
    {
        field(1; No; Integer)
        {
        }
        field(2; "Coop Commission Account"; Code[20])
        {
            TableRelation = "Bank Account";
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
        field(7; "Institution Code"; Text[30])
        {
        }
        field(8; "Institutio Name"; Text[50])
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

