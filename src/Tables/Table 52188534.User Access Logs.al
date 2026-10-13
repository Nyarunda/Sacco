
Table 50197 "User Access Logs"
{

    fields
    {
        field(1; Guid; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "User Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Login Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Login Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Logout Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Logout Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Guid)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

