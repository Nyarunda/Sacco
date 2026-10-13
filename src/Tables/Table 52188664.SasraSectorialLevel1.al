table 50327 "Sasra Sectorial Level 1"
{
    Caption = 'Sasra Sectorial Level 1';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Main Sector Code"; Code[5])
        {
            Caption = 'Main Sector Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Sub-Sector Level 1 Code"; Code[5])
        {
            Caption = 'Sub-Sector Level 1 Code ';
            DataClassification = ToBeClassified;
        }
        field(3; "Sub-Sector Level 1 Description"; Text[250])
        {
            Caption = 'Sub-Sector Level 1 Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Main Sector Code", "Sub-Sector Level 1 Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Sub-Sector Level 1 Code", "Sub-Sector Level 1 Description")
        {
        }
    }
}
