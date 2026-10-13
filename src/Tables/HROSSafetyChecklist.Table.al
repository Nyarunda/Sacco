Table 51038 "HR OSSafety Checklist"
{

    fields
    {
        field(1; SafetyNo; Code[10])
        {
            TableRelation = "HR OSSafety Rules"."Safety No";

            trigger OnValidate()
            begin
                Rule.Reset;
                Rule.SetRange(Rule."Safety No", SafetyNo);
                if Rule.Find('-') then
                    "Safety Rules" := Rule."Safety Rules";
            end;
        }
        field(2; "Safety Rules"; Text[200])
        {
        }
        field(3; Observed; Boolean)
        {

            trigger OnValidate()
            begin
                if (Observed = true) and ("Not Observed" = true) then begin
                    Error('Both Option CANNOT apply');
                end;
            end;
        }
        field(4; "Not Observed"; Boolean)
        {

            trigger OnValidate()
            begin
                if (Observed = true) and ("Not Observed" = true) then begin
                    Error('Both Option CANNOT apply');
                end;
            end;
        }
        field(5; "Accident No"; Code[10])
        {
        }
        field(6; "Incident No"; Code[10])
        {
            TableRelation = "HR OSIncident"."Incident No";
        }
        field(7; "Observation Made"; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; SafetyNo, "Incident No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Rule: Record "HR OSSafety Rules";
}

