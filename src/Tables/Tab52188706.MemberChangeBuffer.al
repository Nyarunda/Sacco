table 50369 "Member Change Buffer"
{
    Caption = 'Member Change Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Field No."; Integer)
        {
            Caption = 'Field No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Table No."; Integer)
        {
            Caption = 'Table No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Current Value"; Text[2048])
        {
            Caption = 'Current Value';
            DataClassification = ToBeClassified;
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
