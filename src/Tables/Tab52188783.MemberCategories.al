table 50465 "Member Categories"
{
    Caption = 'Member Categories';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Member Categories";
    LookupPageId = "Member Categories";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Deposit Amount"; Decimal)
        {
            Caption = 'Deposit Amount';
        }
        field(3; "Share Capital"; Decimal)
        {
            Caption = 'Share Capital';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
