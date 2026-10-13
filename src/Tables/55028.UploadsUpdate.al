table 55028 "Uploads Update"
{
    Caption = 'Uploads Update';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
            DataClassification = ToBeClassified;
        }
        field(4; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Member No.")
        {
            Clustered = true;
        }
    }
}
