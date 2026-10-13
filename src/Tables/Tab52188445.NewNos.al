table 50015 "New Nos"
{
    Caption = 'New Nos';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Old Member No."; Code[20])
        {
            Caption = 'Old Member No.';
            DataClassification = ToBeClassified;
        }
        field(2; "New Member No,"; Code[20])
        {
            Caption = 'New Member No,';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Old Member No.")
        {
            Clustered = true;
        }
    }
}
