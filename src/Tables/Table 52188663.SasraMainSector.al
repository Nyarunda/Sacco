table 50326 "Sasra Main Sector"
{
    Caption = 'Sasra Main Sector';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Main Sector Code"; Code[5])
        {
            Caption = 'Main Sector Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Main Sector Description"; Text[250])
        {
            Caption = 'Main Sector Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Main Sector Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Main Sector Code", "Main Sector Description")
        {
        }
    }
}
