
Table 50274 "Pin Change Log"
{

    fields
    {
        field(1; Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Changed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Old Value"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "New Value"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Field Modified"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

