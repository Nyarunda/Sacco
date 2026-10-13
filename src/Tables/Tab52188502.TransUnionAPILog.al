table 50561 "TransUnion API Log"
{
    // TransUnion API Response Log for audit trail

    DataClassification = SystemMetadata;
    Caption = 'TransUnion API Log';

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

        field(20; "Response Code"; Integer)
        {
            Caption = 'Response Code';
            DataClassification = SystemMetadata;
        }

        field(30; "Response Message"; Text[250])
        {
            Caption = 'Response Message';
            DataClassification = SystemMetadata;
        }

        field(40; "Callback ID"; Text[100])
        {
            Caption = 'TransUnion Callback ID';
            DataClassification = SystemMetadata;
        }

        field(50; "Submission Date Time"; DateTime)
        {
            Caption = 'Submission Date Time';
            DataClassification = SystemMetadata;
        }

        field(60; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(70; "Request Type"; Option)
        {
            Caption = 'Request Type';
            DataClassification = SystemMetadata;
            OptionMembers = Authentication,"Daily Payment",Mobile,"Mobile Facility";
            OptionCaption = 'Authentication,Daily Payment,Mobile,Mobile Facility';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(DateKey; "Submission Date Time")
        {
        }

        key(AccountKey; "Account Number", "Submission Date Time")
        {
        }
    }
}