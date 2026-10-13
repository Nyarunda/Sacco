table 50582 Witness
{
    Caption = 'Witness';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
        field(2; "Witness Name"; Text[100])
        {
            Caption = 'Witness Name';
        }
        field(3; "Witness ID No."; Code[16])
        {
            Caption = 'Witness ID No.';
        }
    }
    keys
    {
        key(PK; "Member No.","Witness ID No.")
        {
            Clustered = true;
        }
    }
}
