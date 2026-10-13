Table 51057 "HR Training Cost"
{

    fields
    {
        field(1; "Training ID"; Code[50])
        {
            Editable = false;
        }
        field(2; "Cost Item"; Code[30])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Training Cost Item"));

            trigger OnValidate()
            begin
                "Cost Item Description" := '';
                LookUpVal.Reset;
                LookUpVal.SetRange(LookUpVal.Type, LookUpVal.Type::"Training Cost Item");
                LookUpVal.SetRange(LookUpVal.Code, "Cost Item");
                if LookUpVal.Find('-') then
                    "Cost Item Description" := LookUpVal.Description;
            end;
        }
        field(3; Cost; Decimal)
        {
        }
        field(4; "Cost Item Description"; Text[100])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Training ID", "Cost Item")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LookUpVal: Record "HR Lookup Values";
}

