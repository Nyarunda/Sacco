Table 50349 "Sky PIN Change Log."
{

    fields
    {
        field(1; Date; DateTime)
        {
        }
        field(2; "Account No."; Code[20])
        {
        }
        field(3; "Account Name"; Text[100])
        {
        }
        field(4; "Changed By"; Code[50])
        {
        }
        field(5; "Old Value"; Text[100])
        {
        }
        field(6; "New Value"; Text[100])
        {
        }
        field(7; "Field Modified"; Text[30])
        {
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

