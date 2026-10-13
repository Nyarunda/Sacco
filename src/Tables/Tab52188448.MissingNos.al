table 50016 "Missing Nos"
{
    Caption = 'Missing Nos';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
        }
        field(2; Issued; Boolean)
        {
            Caption = 'Issued';
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
