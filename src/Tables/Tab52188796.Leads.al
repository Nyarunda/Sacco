table 50478 Leads
{
    Caption = 'Leads';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Mobile No."; Code[13])
        {
            Caption = 'Mobile No.';
        }
        field(3; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(8; "Date Joined"; Date)
        {
            Caption = 'Date Joined';
        }
        field(9; Location; Text[30])
        {
            Caption = 'Location';
        }
        field(11; Gender; Text[20])
        {
            Caption = 'Gender';
        }
        field(13; "Introducer Phone"; Text[13])
        {
            Caption = 'Gender';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
