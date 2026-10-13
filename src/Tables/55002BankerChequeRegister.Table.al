Table 55002 "Banker Cheque Register"
{

    fields
    {
        field(1; "Banker Cheque No."; Code[30])
        {
        }
        field(2; Issued; Boolean)
        {


        }
        field(3; Cancelled; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Banker Cheque No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}

