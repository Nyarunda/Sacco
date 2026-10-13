table 50613 "IDM Setup"
{
    Caption = 'IDM Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(10; "API Key"; Text[250])
        {
            Caption = 'API Key';
            DataClassification = EndUserPseudonymousIdentifiers;
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                if "API Key" <> '' then
                    "API Key" := "API Key".Trim();
            end;
        }
        field(20; "Client ID"; Text[50])
        {
            Caption = 'Client ID (UUID)';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Client ID" <> '' then
                    "Client ID" := "Client ID".Trim();
            end;
        }
        field(30; "Base URL"; Text[250])
        {
            Caption = 'Base URL';
            DataClassification = CustomerContent;
            InitValue = 'https://idm.calwide.app/api/v1';

            trigger OnValidate()
            begin
                if "Base URL" <> '' then begin
                    "Base URL" := "Base URL".Trim();
                    if "Base URL".EndsWith('/') then
                        "Base URL" := "Base URL".Substring(1, StrLen("Base URL") - 1);
                end;
            end;
        }
        field(40; Enabled; Boolean)
        {
            Caption = 'Enabled';
            DataClassification = CustomerContent;
        }
        field(50; "Auto Verify ID No."; Boolean)
        {
            Caption = 'Auto Verify ID No. on Entry';
            DataClassification = CustomerContent;
        }
        field(60; "Auto Verify KRA PIN"; Boolean)
        {
            Caption = 'Auto Verify KRA PIN on Entry';
            DataClassification = CustomerContent;
        }
        field(70; "Auto Verify Phone"; Boolean)
        {
            Caption = 'Auto Verify Phone No. on Entry';
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

    procedure GetSetup(): Record "IDM Setup"
    var
        IDMSetup: Record "IDM Setup";
    begin
        if not IDMSetup.Get('') then begin
            IDMSetup.Init();
            IDMSetup."Primary Key" := '';
            IDMSetup."Base URL" := 'https://idm.calwide.app/api/v1/external';
            IDMSetup.Insert();
        end;
        exit(IDMSetup);
    end;
}
