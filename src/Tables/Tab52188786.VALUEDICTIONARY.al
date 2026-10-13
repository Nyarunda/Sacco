table 50468 "VALUE DICTIONARY"
{
    Caption = 'VALUE DICTIONARY';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Value Dictionary List";
    LookupPageId = "Value Dictionary List";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(3; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(4; Rating; Decimal)
        {

        }
    }
    keys
    {
        key(PK; "No.", "Code")
        {
            Clustered = true;
        }
    }
}
