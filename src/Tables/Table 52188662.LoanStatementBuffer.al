table 50325 "Loan Statement Buffer"
{
    Caption = 'Loan Statement Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Accrued Interest"; Decimal)
        {
            Caption = 'Accrued Interest';
            DataClassification = ToBeClassified;
        }
        field(6; "Interest Paid"; Decimal)
        {
            Caption = 'Interest Paid';
            DataClassification = ToBeClassified;
        }
        field(7; "Principal Paid"; Decimal)
        {
            Caption = 'Principal Paid';
            DataClassification = ToBeClassified;
        }
        field(8; "Total Paid"; Decimal)
        {
            Caption = 'Total Paid';
            DataClassification = ToBeClassified;
        }
        field(9; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(10; "New Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Amount; Decimal)
        {
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
