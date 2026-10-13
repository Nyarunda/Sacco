Table 50990 "HR Employee Grievance"
{
    DrillDownPageID = "HR Employee Grievance List";
    LookupPageID = "HR Employee Grievance List";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                OK := Employee.Get("Employee No.");
                if OK then begin
                    "Employee First Name" := Employee."First Name";
                    "Employee Last Name" := Employee."Last Name";
                end;
            end;
        }
        field(2; "Follow Up Completed"; Boolean)
        {
        }
        field(3; "Follow Up Date (Actual Date)"; Date)
        {
        }
        field(4; "Release Date"; Date)
        {
        }
        field(5; "Follow Up Date"; Date)
        {
        }
        field(6; "Letter Sent To Employee"; Boolean)
        {
        }
        field(7; "Letter Sent By Whom"; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(8; "Cause Of Grievance"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Grievance Outcome"));
        }
        field(9; "Outcome Of Grievance"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Appraiser Recom"));
        }
        field(10; "Employee First Name"; Text[30])
        {
        }
        field(11; "Employee Last Name"; Text[30])
        {
        }
        field(12; "Date Of Grievance"; Date)
        {
        }
        field(13; Comment; Boolean)
        {
            Editable = false;
            FieldClass = Normal;
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        OK: Boolean;
        Employee: Record Employee;
}

