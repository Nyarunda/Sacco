table 50472 "Board Committees"
{
    Caption = 'Board Committees';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[20])
        {
            Caption = 'Description';
        }
        field(3; "Approval Sequence"; Integer)
        {
            Caption = 'Approval Sequence';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(PK2; "Approval Sequence")
        {
        }
    }
}
