table 50549 "MCRB Identity Info"
{
    Caption = 'MCRB Identity Info';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "IdentityID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "IdentityNumber"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "FirstName"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "LastName"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "DateOfBirth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Gender"; Option)
        {
            OptionMembers = M,F,Other;
            DataClassification = ToBeClassified;
        }
        field(7; "Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Phone"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        // Add additional fields as required.
    }

    keys
    {
        key(PK; "IdentityID")
        {
            Clustered = true;
        }
    }
}

