table 50026 "Email Setup"
{
    Caption = 'Email Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; Enabled; Boolean)
        {
            Caption = 'Enabled';
            ToolTip = 'When disabled no emails will be dispatched.';
        }
        field(3; "From Name"; Text[100])
        {
            Caption = 'From Name';
            ToolTip = 'Display name shown as the sender, e.g. Nyati SACCO.';
        }
        field(4; "From Address"; Text[100])
        {
            Caption = 'From Address';
            ToolTip = 'Sender email address, e.g. noreply@calwide.co.ke.';
        }
        field(5; "SMTP Host"; Text[100])
        {
            Caption = 'SMTP Host';
            ToolTip = 'Outgoing mail server, e.g. smtp.gmail.com or smtp.office365.com.';
        }
        field(6; "SMTP Port"; Integer)
        {
            Caption = 'SMTP Port';
            InitValue = 587;
            MinValue = 1;
            MaxValue = 65535;
        }
        field(7; "SMTP Username"; Text[100])
        {
            Caption = 'SMTP Username';
            ToolTip = 'Login username for the SMTP server (usually the sender email address).';
        }
        field(8; "SMTP Password"; Text[100])
        {
            Caption = 'SMTP Password';
            ExtendedDatatype = Masked;
            ToolTip = 'App password or SMTP password for the sender account.';
        }
        field(9; "Use TLS"; Boolean)
        {
            Caption = 'Use TLS';
            InitValue = true;
            ToolTip = 'Enable STARTTLS encryption (required by most providers on port 587).';
        }
        field(10; "Max Bulk Size"; Integer)
        {
            Caption = 'Max Bulk Size';
            InitValue = 50;
            MinValue = 1;
            MaxValue = 500;
            ToolTip = 'Maximum number of emails fetched and sent in one portal cycle.';
        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }

    procedure GetSetup(): Record "Email Setup"
    var
        EmailSetup: Record "Email Setup";
    begin
        if not EmailSetup.Get('') then begin
            EmailSetup.Init();
            EmailSetup."Primary Key" := '';
            EmailSetup."SMTP Port" := 587;
            EmailSetup."Use TLS" := true;
            EmailSetup."Max Bulk Size" := 50;
            EmailSetup.Insert(true);
        end;
        exit(EmailSetup);
    end;
}
