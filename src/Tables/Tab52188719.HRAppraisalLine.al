table 50382 "HR Appraisal Line"
{
    Caption = 'HR Appraisal Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
        }
        field(2; "Entry Type"; Option)
        {
            OptionMembers = " ",Objectives,Behaviors;
            OptionCaption = ' ,Objectives,Behaviors';
        }
        field(3; "Appraisal No"; Code[30])
        {
            TableRelation = "HR Appraisal Header"."Appraisal No";
        }
        field(4; Pillar; Code[70])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Appraisal Pillar"));
        }
        field(5; "Key Value Driver"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Weight; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Target; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Target in Figures"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Self Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Supervisor Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Agreed Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Actual Achievement"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if xRec."Actual Achievement" <> "Actual Achievement" then begin
                    if "Target in Figures" > 0 then
                        "Achievement/Expected Target %" := ("Actual Achievement" / "Target in Figures") * 100;
                end;
            end;

        }
        field(13; "Achievement/Expected Target %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Weighted Average"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Appraisers Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Core Value"; text[100])
        {
            //OptionMembers = "Team Work",Integrity,"Customer Obsession",Professionalism,"High Performance Culture";
            DataClassification = ToBeClassified;
        }
        field(17; "Behavioral Assesment"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Rating; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Example to Support Rating"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Core Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Core Compentencies";
            trigger OnValidate()
            var
                CoreC: Record "Core Compentencies";
            begin
                if CoreC.Get("Core Code") then
                    "Core Desc." := CoreC.Description;

                "Value Code" := '';
                "Value Desc." := '';
            end;
        }
        field(21; "Core Desc."; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Value Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VALUE DICTIONARY"."No." where(Code = field("Core Code"));
            trigger OnValidate()
            var
                CoreDict: Record "VALUE DICTIONARY";
            begin
                CoreDict.Reset();
                CoreDict.SetRange("No.", "Value Code");
                if CoreDict.FindFirst() then begin
                    "Behavioral Assesment" := CoreDict.Description;
                end
            end;
        }
        field(24; "Value Desc."; Text[150])
        {
            DataClassification = ToBeClassified;

        }
    }
    keys
    {
        key(PK; "Appraisal No", "Entry Type", "Entry No")
        {
            Clustered = true;
        }
    }
}
