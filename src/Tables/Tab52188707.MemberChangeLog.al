table 50370 "Member Change Log"
{
    Caption = 'Member Change Log';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Log No."; Integer)
        {
            Caption = 'Log No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Field Name"; Text[100])
        {
            Caption = 'Field Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Previous Value"; Text[250])
        {
            Caption = 'Previous Value';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "New Value"; Text[250])
        {
            Caption = 'New Value';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Date Changed"; Date)
        {
            Caption = 'Date Changed';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Time Changed"; Time)
        {
            Caption = 'Time Changed';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "User ID"; Code[30])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Reason For Change"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Member Change No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Captured By"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Log No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    begin
        Error('');
    end;
}
