table 50021 UPG_Vendors
{
    Caption = 'UPG_Vendors';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No,"; Code[20])
        {
            Caption = 'No,';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[200])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; Balance; Decimal)
        {
            Caption = 'Balance';
            DataClassification = ToBeClassified;
        }
        field(4; Phone; Text[200])
        {
            Caption = 'Phone';
            DataClassification = ToBeClassified;
        }
        field(5; Contact; Text[200])
        {
            Caption = 'Contact';
            DataClassification = ToBeClassified;
        }
        field(6; "Posting group"; Code[20])
        {
            Caption = 'Posting group';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No,")
        {
            Clustered = true;
        }
    }
}
