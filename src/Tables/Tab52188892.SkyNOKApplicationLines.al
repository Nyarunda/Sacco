table 50594 "NOK Application Lines"
{
    Caption = 'NOK Application Lines';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Application No."; Code[20])
        {
            TableRelation = "Sky Next Of Kin Application";
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; Name; Text[100])
        {
        }
        field(4; Relationship; Text[50])
        {
            TableRelation = Relationship;
        }
        field(5; "ID No."; Code[20])
        {
        }
        field(6; "Mobile No."; Text[30])
        {
        }
        field(7; Email; Text[100])
        {
        }
        field(8; Address; Text[100])
        {
        }
        field(9; "Date of Birth"; Date)
        {
        }
        field(10; "%Allocation"; Decimal)
        {
        }
        field(11; "Is Beneficiary"; Boolean)
        {
        }
        field(12; "Is Next of Kin"; Boolean)
        {
        }
        field(13; Gender; Option)
        {
            OptionMembers = Male,Female;
        }
        field(14; "Modified By"; Code[20])
        {
        }
        field(15; Deceased; Boolean)
        {
        }
        field(16; "NOK Residence"; Text[100])
        {
        }
        field(17; "Action Type"; Option)
        {
            OptionMembers = Insert,Update,Delete;
        }
        field(18; "Entry No Reference"; Integer)
        {
            Description = 'Reference to Members Nominee Entry No for Update/Delete';
        }
    }

    keys
    {
        key(Key1; "Application No.", "Line No.")
        {
        }
        key(Key2; "Application No.", Name)
        {
        }
        key(Key3; "Application No.", "Action Type")
        {
        }
    }

    fieldgroups
    {
    }
}
