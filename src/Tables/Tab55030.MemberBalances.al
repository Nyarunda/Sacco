table 55030 "Member Balances"
{
    Caption = 'Member Balances';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(3; Name; Text[200])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(4; Balance; Decimal)
        {
            Caption = 'Balance';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Account No.", Date)
        {
            Clustered = true;
        }
    }
}
