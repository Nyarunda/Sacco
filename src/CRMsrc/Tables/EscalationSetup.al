
// Escalation Setup Table
table 50422 "Escalation Setup"
{
    Caption = 'Escalation Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "Default Email Template"; Code[20])
        {
            Caption = 'Default Email Template';
            DataClassification = CustomerContent;
        }
        field(3; "Business Hours Start"; Time)
        {
            Caption = 'Business Hours Start';
            DataClassification = CustomerContent;
            InitValue = 080000T;
        }
        field(4; "Business Hours End"; Time)
        {
            Caption = 'Business Hours End';
            DataClassification = CustomerContent;
            InitValue = 170000T;
        }
        field(5; "Enable Escalations"; Boolean)
        {
            Caption = 'Enable Escalations';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(6; "Max Escalations Per Hour"; Integer)
        {
            Caption = 'Max Escalations Per Hour';
            DataClassification = CustomerContent;
            InitValue = 100;
        }
        field(7; "Log All Escalations"; Boolean)
        {
            Caption = 'Log All Escalations';
            DataClassification = CustomerContent;
            InitValue = true;
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