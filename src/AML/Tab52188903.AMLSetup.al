

table 50693 "AML Setup"
{
    Caption = 'AML Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(10; "High Value Threshold (D)"; Decimal)
        {
            Caption = 'High Value Threshold (D)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(11; "Cash Reporting Threshold (D)"; Decimal)
        {
            Caption = 'Cash Reporting Threshold (D)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(12; "PEP Alert Threshold (D)"; Decimal)
        {
            Caption = 'PEP Alert Threshold (D)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(13; "PEP Alert Threshold (W)"; Decimal)
        {
            Caption = 'PEP Alert Threshold (W)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(20; "Max Daily Transactions (D)"; Integer)
        {
            Caption = 'Max Daily Transactions (D)';
            DataClassification = CustomerContent;
            MinValue = 1;
        }
        field(21; "Max Daily Amount (D)"; Decimal)
        {
            Caption = 'Max Daily Amount (D)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(22; "Max Monthly Transactions (D)"; Integer)
        {
            Caption = 'Max Monthly Transactions (D)';
            DataClassification = CustomerContent;
            MinValue = 1;
        }
        field(23; "Max Monthly Amount (D)"; Decimal)
        {
            Caption = 'Max Monthly Amount (D)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(30; "Alert Risk Threshold"; Decimal)
        {
            Caption = 'Alert Risk Threshold';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
        }
        field(31; "Pattern Deviation Threshold"; Decimal)
        {
            Caption = 'Pattern Deviation Threshold (%)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(40; "Business Hours Start"; Time)
        {
            Caption = 'Business Hours Start';
            DataClassification = CustomerContent;
        }
        field(41; "Business Hours End"; Time)
        {
            Caption = 'Business Hours End';
            DataClassification = CustomerContent;
        }
        field(50; "Enable Real Time Monitoring"; Boolean)
        {
            Caption = 'Enable Real Time Monitoring';
            DataClassification = CustomerContent;
        }
        field(51; "Auto Generate Alerts"; Boolean)
        {
            Caption = 'Auto Generate Alerts';
            DataClassification = CustomerContent;
        }
        field(52; "Send Email Notifications"; Boolean)
        {
            Caption = 'Send Email Notifications';
            DataClassification = CustomerContent;
        }
        field(60; "Compliance Officer Email"; Text[100])
        {
            Caption = 'Compliance Officer Email';
            DataClassification = CustomerContent;
        }
        field(61; "AML Manager Email"; Text[100])
        {
            Caption = 'AML Manager Email';
            DataClassification = CustomerContent;
        }
        field(70; "STR Report Path"; Text[250])
        {
            Caption = 'STR Report Path';
            DataClassification = CustomerContent;
        }
        field(71; "Archive Path"; Text[250])
        {
            Caption = 'Archive Path';
            DataClassification = CustomerContent;
        }

        field(72; "High Value Threshold (W)"; Decimal)
        {
            Caption = 'High Value Threshold (W)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }

        field(73; "Cash Reporting Threshold (W)"; Decimal)
        {
            Caption = 'Cash Reporting Threshold (W)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(74; "Max Daily Transactions (W)"; Integer)
        {
            Caption = 'Max Daily Transactions (W)';
            DataClassification = CustomerContent;
            MinValue = 1;
        }

        field(75; "Max Daily Amount (W)"; Decimal)
        {
            Caption = 'Max Daily Amount (W)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }

        field(76; "Max Monthly Transactions (W)"; Integer)
        {
            Caption = 'Max Monthly Transactions (W)';
            DataClassification = CustomerContent;
            MinValue = 1;
        }
        field(77; "Max Monthly Amount (W)"; Decimal)
        {
            Caption = 'Max Monthly Amount (W)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}
