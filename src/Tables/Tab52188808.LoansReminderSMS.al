table 50490 "Loans Reminder SMS"
{
    Caption = 'Loans Reminder SMS';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
        }
        field(2; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = " ","Before Due Date","On Due Date","After Due Date";
        }
        field(3; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
        }
        field(4; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
    }

    keys
    {
        key(PK; "Loan No", "Entry No", Type)
        {
            Clustered = true;
        }
    }
}
