Table 51131 "HR Employee Competence"
{

    fields
    {
        field(1; "Competence Code"; Code[25])
        {
            TableRelation = "HR Lookup Values";

            trigger OnValidate()
            begin

                /*HRlookup.Reset;
                HRlookup.SetRange(HRlookup.Code, "Competence Code");
                if HRlookup.Find('-') then begin
                    Description := HRlookup.Description;
                end;
                */
            end;
        }
        field(2; "Employee No"; Code[10])
        {
        }
        field(3; Description; Text[100])
        {
        }
        field(4; "Competency Score"; Decimal)
        {
        }
        field(5; "Line No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Competence Code", "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
    //HRlookup: Record "HR Lookup Values";
}

