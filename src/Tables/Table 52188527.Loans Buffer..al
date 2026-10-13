
Table 50190 "Loans Buffer."
{

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

