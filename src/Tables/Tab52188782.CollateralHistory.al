/// <summary>
/// Table Collateral History (ID 50464).
/// </summary>
table 50464 "Collateral History"
{
    Caption = 'Collateral History';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Col. Reg. No"; Code[20])
        {
            Caption = 'Col. Reg. No';
        }
        field(2; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
        }
        field(3; "Amount Guaranteed"; Decimal)
        {
            Caption = 'Amount Guaranteed';
        }
        field(4; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
    }
    keys
    {
        key(PK; "Col. Reg. No", "Loan No.")
        {
            Clustered = true;
        }
    }
}
