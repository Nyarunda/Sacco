table 50492 "Share Capital Controls"
{
    Caption = 'Share Capital Controls';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Minimum; Decimal)
        {
            Caption = 'Minimum';
        }
        field(2; Maximum; Decimal)
        {
            Caption = 'Maximum';
        }
        field(3; "Capitilize Amount %"; Decimal)
        {
            Caption = 'Capitilize Amount %';
        }
        field(4; "Loan Product"; Code[20])
        {
            Caption = 'Loan Product';
        }
    }
    keys
    {
        key(PK; Minimum, "Loan Product")
        {
            Clustered = true;
        }
    }
}
