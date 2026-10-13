table 50513 "Loans Recovery Logs"
{
    Caption = 'Loans Recovery Logs';
    DataClassification = ToBeClassified;

    fields
    {
        field(2; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
        }
        field(3; "Recovery Date"; Date)
        {
            Caption = 'Recovery Date';
        }
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
    }
    keys
    {
        key(PK; "Loan No", "Entry No")
        {
            Clustered = true;
        }
    }
}
