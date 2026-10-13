table 50564 "TransUnion Error Log"
{
    // TransUnion API Validation Error Log

    DataClassification = SystemMetadata;
    Caption = 'TransUnion Error Log';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(10; "Account Number"; Code[50])
        {
            Caption = 'Account Number';
            DataClassification = SystemMetadata;
        }

        field(20; "Error Details"; Text[2048])
        {
            Caption = 'Error Details (JSON)';
            DataClassification = SystemMetadata;
        }

        field(30; "Error Date Time"; DateTime)
        {
            Caption = 'Error Date Time';
            DataClassification = SystemMetadata;
        }

        field(40; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(50; "Resolved"; Boolean)
        {
            Caption = 'Resolved';
            DataClassification = SystemMetadata;
        }

        field(60; "Resolution Notes"; Text[250])
        {
            Caption = 'Resolution Notes';
            DataClassification = SystemMetadata;
        }

        field(61; "Parent Entry No."; Integer)
        {
            Caption = 'Parent Entry No.';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Parent Entry No.", "Entry No.")
        {
            Clustered = true;
        }

        key(DateKey; "Error Date Time")
        {
        }

        key(AccountKey; "Account Number", "Error Date Time")
        {
        }

        key(StatusKey; Resolved, "Error Date Time")
        {
        }
    }
}