table 50559 "TransUnion Setup"
{
    // TransUnion Kenya API Configuration Setup

    DataClassification = CustomerContent;
    Caption = 'TransUnion Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }

        field(10; "Infinity Code"; Text[100])
        {
            Caption = 'Infinity Code';
            DataClassification = EndUserPseudonymousIdentifiers;

            trigger OnValidate()
            begin
                if "Infinity Code" <> '' then
                    "Infinity Code" := "Infinity Code".Trim();
            end;
        }

        field(20; Username; Text[100])
        {
            Caption = 'Username';
            DataClassification = EndUserPseudonymousIdentifiers;

            trigger OnValidate()
            begin
                if Username <> '' then
                    Username := Username.Trim();
            end;
        }

        field(30; Password; Text[100])
        {
            Caption = 'Password';
            DataClassification = EndUserPseudonymousIdentifiers;
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                if Password <> '' then
                    Password := Password.Trim();
            end;
        }

        field(40; "Base URL"; Text[250])
        {
            Caption = 'Base URL';
            DataClassification = CustomerContent;
            InitValue = 'https://secure3.crbafrica.com/duv2';
        }

        field(50; "Test Mode"; Boolean)
        {
            Caption = 'Test Mode';
            DataClassification = CustomerContent;
            InitValue = true;
        }

        field(60; "Last Token Generated"; DateTime)
        {
            Caption = 'Last Token Generated';
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(70; "Token Expiry"; DateTime)
        {
            Caption = 'Token Expiry';
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(80; "Auto Submit"; Boolean)
        {
            Caption = 'Auto Submit Daily Payments';
            DataClassification = CustomerContent;
            InitValue = false;
        }

        field(90; "Submit Time"; Time)
        {
            Caption = 'Auto Submit Time';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}