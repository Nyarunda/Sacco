Table 51110 "HR Employee Separation"
{

    fields
    {
        field(1; "Separation No."; Code[20])
        {
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                "Employee Name" := hremp."First Name" + ' ' + hremp."Middle Name" + ' ' + hremp."Last Name";
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; Department; Code[20])
        {
            TableRelation = Employee.Department;
        }
        field(5; "Job Title"; Code[20])
        {
        }
        field(6; "Nature of Separation"; Option)
        {
            OptionMembers = " ",Dismissal,Retirement,"Early Retirement","End of Contract","Medical grounds";
        }
        field(7; "Reason for Separation"; Text[250])
        {
        }
        field(8; Status; Option)
        {
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(9; "Separation Date"; Date)
        {
        }
        field(10; "Responsibility Center"; Code[10])
        {
            ////TableRelation = Table52018718.Field1;
        }
        field(11; "Reason for Retirement"; Text[250])
        {
        }
        field(12; Illness; Text[250])
        {
        }
        field(13; Justification; Text[250])
        {
        }
        field(14; "End of contract Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Separation No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        hremp: Record Employee;
}

