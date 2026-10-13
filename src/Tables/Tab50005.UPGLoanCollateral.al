table 50005 "UPG_Loan Collateral"
{
    Caption = 'Loan Collateral';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Type"; Text[200])
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(3; "Security Details"; Text[200])
        {
            Caption = 'Security Details';
            DataClassification = ToBeClassified;
        }
        field(4; Remarks; Text[200])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(5; "Value"; Decimal)
        {
            Caption = 'Value';
            DataClassification = ToBeClassified;
        }
        field(6; "Guarantee Value"; Decimal)
        {
            Caption = 'Guarantee Value';
            DataClassification = ToBeClassified;
        }
        field(7; "Motor Vehicle Registration No"; Text[200])
        {
            Caption = 'Motor Vehicle Registration No';
            DataClassification = ToBeClassified;
        }
        field(8; "Title Deed No."; Text[200])
        {
            Caption = 'Title Deed No.';
            DataClassification = ToBeClassified;
        }
        field(9; "Comitted Collateral Value"; Decimal)
        {
            Caption = 'Comitted Collateral Value';
            DataClassification = ToBeClassified;
        }
        field(10; Created; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Loan No.", "Security Details")
        {
            Clustered = true;
        }
    }
}
