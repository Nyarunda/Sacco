table 50095 Mandate
{
    Caption = 'Mandate';
    DataClassification = ToBeClassified;
    LookupPageId = Mandate;
    DrillDownPageId = Mandate;

    fields
    {
        field(1; Mandate; Text[50])
        {
            Caption = 'Mandate';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Mandate)
        {
            Clustered = true;
        }
    }
}
