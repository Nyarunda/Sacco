table 50122 County
{
    Caption = 'County';
    DataClassification = ToBeClassified;
    LookupPageId = County;
    DrillDownPageId = County;

    fields
    {
        field(1; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }
}
