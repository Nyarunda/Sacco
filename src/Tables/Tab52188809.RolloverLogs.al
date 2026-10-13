table 50491 "Rollover Logs"
{
    Caption = 'Rollover Logs';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            //AutoIncrement = true;
        }
        field(2; "Loan no."; Code[20])
        {
            Caption = 'Loan no.';
        }
        field(3; "Date Processed"; Date)
        {
            Caption = 'Date Processed';
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
