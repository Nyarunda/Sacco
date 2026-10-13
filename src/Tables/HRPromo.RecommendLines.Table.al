Table 51071 "HR Promo. Recommend Lines"
{

    fields
    {
        field(1; "Employee Abilities"; Text[250])
        {
        }
        field(3; Experience; Text[250])
        {
        }
        field(4; "Document No"; Code[20])
        {
        }
        field(5; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Employee Abilities")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

