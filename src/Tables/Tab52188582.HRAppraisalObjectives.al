table 50245 "HR Appraisal Objectives"
{
    Caption = 'HR Appraisal Objectives';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job ID"; Code[20])
        {
            Caption = 'Job ID';
            DataClassification = ToBeClassified;
            TableRelation = "HR Jobs";
        }
        field(2; "Appraisal Pillar"; Code[70])
        {
            Caption = 'Appraisal Pillar';
            DataClassification = ToBeClassified;
            TableRelation = "HR Lookup Values".Code where(Type = const("Appraisal Pillar"));
        }
        field(3; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
        }
        field(4; "Key Value Driver"; Text[100])
        {
            Caption = 'Key Value Driver';
            DataClassification = ToBeClassified;
        }
        field(5; Weight; Decimal)
        {
            Caption = 'Weight';
            DataClassification = ToBeClassified;
        }
        field(6; Target; Text[100])
        {
            Caption = 'Target';
            DataClassification = ToBeClassified;
        }
        field(7; "Target in Figures"; Decimal)
        {
            Caption = 'Target in Figures';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Job ID", "Appraisal Pillar", "Entry No")
        {
            Clustered = true;
        }
    }
}
