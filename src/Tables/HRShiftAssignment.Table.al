Table 51136 "HR Shift Assignment"
{
    DrillDownPageID = "HR Shift Assignment List";
    LookupPageID = "HR Shift Assignment List";

    fields
    {
        field(1; "Staff No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee."No.";
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(4; "Clock In Time"; DateTime)
        {
        }
        field(5; "Clock Out Time"; DateTime)
        {
        }
        field(6; "Shift Code"; Code[20])
        {
        }
        field(7; "Start Date/Time"; DateTime)
        {
        }
        field(8; "End Date/Time"; DateTime)
        {
        }
        field(9; Duration; Duration)
        {
        }
        field(10; "Shift Status"; Option)
        {
            OptionMembers = " ","On Going",Completed;
        }
        field(11; "Rate Per Shift"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Staff No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Employee.Get("Staff No.");
    end;

    var
        Text000: label 'You cannot delete employee qualification information if there are comments associated with it.';
        HRLookupValues: Record "HR Lookup Values";
        Employee: Record Employee;
        HRQualifications: Record "HR Job Qualifications";
}

