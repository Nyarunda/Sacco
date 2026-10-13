table 50463 "Loan Sub. Types"
{
    Caption = 'Loan Sub. Types';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Product Sub. Type"; Enum "Product Sub. Type")
        {
            Caption = 'Product Sub. Type';
        }
        field(2; "Loan Type"; Code[10])
        {
            Caption = 'Loan Type';
            Editable = false;
        }
        field(3; "Maximum Loan Amount"; Decimal)
        {
            Caption = 'Maximum Loan Amount';
        }
        field(4; Installement; Decimal)
        {
            Caption = 'Installement';
        }

        field(5; Interest; Decimal)
        {
            Caption = 'Annual Interest Rate %';
        }
        field(6; "Minimum Loan Amount"; Decimal)
        {
            Caption = 'Minimum Loan Amount';
        }
        field(7; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; "Product Sub. Type", "Loan Type", "Line No.")
        {
            Clustered = true;
        }
    }
}
