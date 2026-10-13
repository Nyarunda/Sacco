Table 51040 "HR OSInjured Person"
{

    fields
    {
        field(1; LineNo; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Employee No"; Code[10])
        {
            TableRelation = if (Type = const(Employee)) Employee."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Employee No");
                if HREmp.Find('-') then begin
                    "Employee No" := HREmp."No.";
                    "Injured Person" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    //Address := HREmp."Postal Address";
                    // "Phone No":=HREmp."Cellular Phone Number";
                    //"ID No":=HREmp."ID Number";
                    //"Date Of Birth" := HREmp."Date Of Birth";
                end;
            end;
        }
        field(3; "Injured Person"; Text[100])
        {
        }
        field(4; Address; Code[50])
        {
        }
        field(5; "Phone No"; Code[30])
        {
        }
        field(6; "ID No"; Code[10])
        {
        }
        field(7; "Date Of Birth"; Date)
        {
        }
        field(8; Email; Text[30])
        {
        }
        field(9; "Incident No"; Code[10])
        {
            TableRelation = "HR OSIncident"."Incident No";
        }
        field(10; Type; Option)
        {
            OptionCaption = ' ,Employee,Non-Employee';
            OptionMembers = " ",Employee,"Non-Employee";
        }
    }

    keys
    {
        key(Key1; LineNo, "Employee No", "Incident No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmp: Record Employee;
        Casual: Boolean;
}

