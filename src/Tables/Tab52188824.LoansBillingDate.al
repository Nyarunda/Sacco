table 50525 "Loans Billing Date"
{
    Caption = 'Loans Billing Date';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
        }
        field(2; "Current Billing Date"; Date)
        {
            Caption = 'Current Billing Date';
        }
        field(3; "Expected Billing Date"; Date)
        {
            Caption = 'Expected Billing Date';
        }
    }
    keys
    {
        key(PK; "Loan No")
        {
            Clustered = true;
        }
    }
}
