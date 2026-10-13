Table 51132 "HR Employee Login Management"
{
    DrillDownPageID = "HR Emp. Login Management List";
    LookupPageID = "HR Emp. Login Management List";

    fields
    {
        field(1; "Staff No."; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.Reset;
                if Employee.Get("Staff No.") then
                    "Staff Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name"
                else
                    "Staff Name" := '';
            end;
        }
        field(2; "Staff Name"; Text[100])
        {
            Editable = false;
        }
        field(3; "Fingerprint ID"; Blob)
        {
            SubType = Bitmap;
        }
        field(4; Username; Code[10])
        {
        }
        field(5; Password; Text[30])
        {
        }
        field(6; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(7; "Clock In Date/Time"; DateTime)
        {
            Editable = false;
        }
        field(8; "Clock Out Date/Time"; DateTime)
        {
            Editable = false;
        }
        field(9; "Rate Per Shift"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Staff No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
}

