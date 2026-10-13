
Table 50158 "FD Types"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "FD Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Call Deposit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Months; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

