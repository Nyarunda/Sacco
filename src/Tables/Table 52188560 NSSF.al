
Table 50416 NSSF
{

    fields
    {
        field(1; "Tier Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            SQLDataType = Integer;
        }
        field(2; "NSSF Tier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Employer Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Employee Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Lower Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Upper Limit"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(7; "Use Percentage"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "% Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Max. NSSF"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Tier Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

