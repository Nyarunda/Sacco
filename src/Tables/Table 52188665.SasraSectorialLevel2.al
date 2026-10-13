table 50328 "Sasra Sectorial Level 2"
{
    Caption = 'Sasra Sectorial Level 2';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Main Sector"; Code[5])
        {
            Caption = 'Main Sector';
            DataClassification = ToBeClassified;
        }
        field(2; "Sub-Sector Level 1 Code"; Code[5])
        {
            Caption = 'Sub-Sector Level 1 Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Sub-Sector Level 2 Code"; Code[5])
        {
            Caption = 'Sub-Sector Level 2 Code';
            DataClassification = ToBeClassified;
        }
        field(4; "Sub-Sector Level 2 Description"; Text[250])
        {
            Caption = 'Sub-Sector Level 2 Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Main Sector Description"; Text[250])
        {

            CalcFormula = lookup("Sasra Main Sector"."Main Sector Description" where("Main Sector Code" = field("Main Sector")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Sub-Sector Level 1 Description"; Text[250])
        {

            CalcFormula = lookup("Sasra Sectorial Level 1"."Sub-Sector Level 1 Description" where("Sub-Sector Level 1 Code" = field("Sub-Sector Level 1 Code")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(PK; "Main Sector", "Sub-Sector Level 1 Code", "Sub-Sector Level 2 Code")
        {
            Clustered = true;
        }

        key(Key2; "Sub-Sector Level 2 Code")
        {
        }
    }


    fieldgroups
    {
        fieldgroup(DropDown; "Sub-Sector Level 2 Code", "Sub-Sector Level 2 Description")
        {
        }
    }
}
