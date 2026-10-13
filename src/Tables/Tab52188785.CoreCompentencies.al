table 50467 "Core Compentencies"
{
    Caption = 'Core Compentencies';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Core Compentencies List";
    LookupPageId = "Core Compentencies List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
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
