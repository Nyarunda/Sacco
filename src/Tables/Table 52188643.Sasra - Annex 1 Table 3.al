
Table 50306 "Sasra - Annex 1 Table 3"
{

    fields
    {
        field(1; "Share Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Member Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Member Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Share Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Share Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Share Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

