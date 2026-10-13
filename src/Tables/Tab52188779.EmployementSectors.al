/// <summary>
/// Table Employement Sectors (ID 50461).
/// </summary>
table 50461 "Employement Sectors"
{
    Caption = 'Employment Sectors';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Employement Sector List";
    LookupPageId = "Employement Sector List";

    fields
    {
        field(1; "Code"; Code[15])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; Type; option)
        {
            OptionMembers = Business,Employed;
        }
        field(4; "Location"; Text[30])
        {
            Caption = 'Location';
        }
    }
    keys
    {
        key(PK; "Code", Description, Type)
        {
            Clustered = true;
        }
    }

}
