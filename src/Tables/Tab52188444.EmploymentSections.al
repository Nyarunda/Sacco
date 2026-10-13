table 50205 "Employment Sections"
{
    Caption = 'Employment Sections';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Employment Section";
    LookupPageId = "Employment Section";

    fields
    {
        field(1; Section; Text[50])
        {
            Caption = 'Section';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Section)
        {
            Clustered = true;
        }
    }
}
