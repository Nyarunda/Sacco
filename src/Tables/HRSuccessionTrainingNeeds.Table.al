Table 51047 "HR Succession Training Needs"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Plan No."; Code[20])
        {
            TableRelation = "HR Succession Employee"."Plan No.";
        }
        field(3; "Need Code"; Code[20])
        {
            TableRelation = "HR Training Needs".Code;

            trigger OnValidate()
            begin

                TrainingNeeds.Reset;
                TrainingNeeds.SetRange(TrainingNeeds.Code, "Need Code");
                if TrainingNeeds.Find('-') then begin
                    Description := TrainingNeeds.Description;
                    "Acquired Qualification Type" := TrainingNeeds."Qualification Type";
                    "Acquired Qualification Code" := TrainingNeeds."Qualification Code";
                    "Qualification Description" := TrainingNeeds."Qualification Description";
                end else begin
                    Description := ' ';
                    "Acquired Qualification Type" := ' ';
                    "Acquired Qualification Code" := ' ';
                    "Qualification Description" := ' ';
                end;
            end;
        }
        field(4; Description; Text[50])
        {
        }
        field(5; "Acquired Qualification Type"; Code[20])
        {
        }
        field(6; "Acquired Qualification Code"; Code[20])
        {
        }
        field(7; "Qualification Description"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", "Plan No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        TrainingNeeds: Record "HR Training Needs";
}

