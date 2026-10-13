Table 51065 "HR Medical Schemes"
{
    DrillDownPageID = "HR Medical Schemes List";
    LookupPageID = "HR Medical Schemes List";

    fields
    {
        field(1; "Scheme No"; Code[10])
        {
        }
        field(2; "Medical Insurer"; Code[20])
        {
            TableRelation = vendor;

            trigger OnValidate()
            begin

                Insurer.Reset;
                Insurer.SetRange(Insurer."No.", "Medical Insurer");
                if Insurer.Find('-') then begin
                    "Insurer Name" := Insurer.Name;

                end;
            end;
        }
        field(3; "Scheme Name"; Text[250])
        {
        }
        field(4; "In-patient limit"; Decimal)
        {
        }
        field(5; "Out-patient limit"; Decimal)
        {
        }
        field(6; "Area Covered"; Text[30])
        {
        }
        field(7; "Dependants Included"; Boolean)
        {
        }
        field(8; Comments; Text[100])
        {
        }
        field(9; "Insurer Name"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Scheme No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Insurer: Record "Savings Accounts";
}

