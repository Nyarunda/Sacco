table 50324 "Member Exit Beneficiary"
{
    Caption = 'Member Exit Beneficiary';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Exit No."; Code[20])
        {
            Caption = 'Exit No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Principal Member No."; Code[20])
        {
            Caption = 'Principal Member No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Principal Member Name"; Text[200])
        {
            Caption = 'Principal Member Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Beneficiary Name"; Text[200])
        {
            Caption = 'Beneficiary Name';
            DataClassification = ToBeClassified;
        }
        field(5; Remark; Text[200])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
        field(6; Relation; Text[200])
        {
            Caption = 'Relation';
            DataClassification = ToBeClassified;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(8; "PV No."; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Exit No.", "Beneficiary Name")
        {
            Clustered = true;
        }
    }
}
