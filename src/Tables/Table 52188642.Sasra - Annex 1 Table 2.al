
Table 50305 "Sasra - Annex 1 Table 2"
{

    fields
    {
        field(1; "Deposit Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Member Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Member Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Employer Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Employer Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Mobile Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Deposit Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Deposit interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Deposit Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Loan Number"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Guarantee Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Deposit Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

