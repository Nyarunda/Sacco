table 50097 "FDR Import"
{
    Caption = 'FDR Import';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Reference No"; Code[20])
        {
            Caption = 'Reference No';
            DataClassification = ToBeClassified;
        }
        field(2; "Account No"; Code[20])
        {
            Caption = 'Account No';
            DataClassification = ToBeClassified;
        }
        field(3; "Fixed Deposit Type"; Code[20])
        {
            Caption = 'Fixed Deposit Type';
            DataClassification = ToBeClassified;
        }
        field(4; "Duration"; Code[20])
        {
            Caption = 'Duration';
            DataClassification = ToBeClassified;
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Maturity Date"; Date)
        {
            Caption = 'Maturity Date';
            DataClassification = ToBeClassified;
        }
        field(8; "Maturity Instructions"; Text[30])
        {
            Caption = 'Maturity Instructions';
            DataClassification = ToBeClassified;
        }
        field(9; "Negotiated Interest"; Decimal)
        {
            Caption = 'Negotiated Interest';
            DataClassification = ToBeClassified;
        }
        field(10; "Interest Expected"; Decimal)
        {
            Caption = 'Interest Expected';
            DataClassification = ToBeClassified;
        }
        field(11; "AMount + Interest"; Decimal)
        {
            Caption = 'AMount + Interest';
            DataClassification = ToBeClassified;
        }
        field(12; Created; Boolean)
        {
            Caption = 'Created';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Reference No")
        {
            Clustered = true;
        }
    }
}
