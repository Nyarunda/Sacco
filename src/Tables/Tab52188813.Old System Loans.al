table 50495 "Old System Loans"
{
    Caption = 'Old System Loans';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
        field(3; "Entry No."; integer)
        {
        }
    }
    keys
    {
        key(PK; "Loan No.", "Entry No.")
        {
            Clustered = true;
        }
    }
}
