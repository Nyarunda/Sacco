
Table 50191 "Loans Penalty Buffer"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "GL Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Product Type"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Penalty Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Loan Issue Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Member No", "Loan No", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

