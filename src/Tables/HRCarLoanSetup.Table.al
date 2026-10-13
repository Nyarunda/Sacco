Table 51118 "HR Car Loan Setup"
{

    fields
    {
        field(1; "code"; Code[10])
        {
        }
        field(2; "Loan type"; Text[50])
        {
            //TableRelation = "HR Staff Loan Typess".Code;
        }
        field(3; New; Boolean)
        {
        }
        field(4; Installments; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

