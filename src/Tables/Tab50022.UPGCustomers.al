table 50022 UPG_Customers
{
    Caption = 'UPG_Customers';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Posting group"; Code[200])
        {
            Caption = 'Posting group';
            DataClassification = ToBeClassified;
        }
        field(3; Balance; Decimal)
        {
            Caption = 'Balance';
            DataClassification = ToBeClassified;
        }
        field(4; Phone; Code[200])
        {
            Caption = 'Phone';
            DataClassification = ToBeClassified;
        }
        field(5; Contact; Text[200])
        {
            Caption = 'Contact';
            DataClassification = ToBeClassified;
        }
        field(6; Name; Text[200])
        {
            Caption = 'Contact';
            DataClassification = ToBeClassified;
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
