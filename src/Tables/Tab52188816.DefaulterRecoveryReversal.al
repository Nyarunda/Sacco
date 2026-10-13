table 50498 "Defaulter Recovery Reversal"
{
    Caption = 'Defaulter Recovery Reversal';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
        field(4; Balance; Decimal)
        {
            Caption = 'Balance';
        }
        field(5; Product; Text[100])
        {
            Caption = 'Product';
        }
        field(6; "Entry Found"; Boolean)
        {
            Caption = 'Entry Found';
        }
        field(7; "Amount Reversed"; Decimal)
        {
            Caption = 'Amount Reversed';
        }
        field(8; Variance; Decimal)
        {
            Caption = 'Variance';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
