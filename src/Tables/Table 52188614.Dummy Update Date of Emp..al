
Table 50277 "Dummy Update Date of Emp."
{

    fields
    {
        field(1; Staff; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Updated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Staff)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Employee.Get(Staff) then begin
            Employee."Employment Date" := Date;
            Updated := true;
            Employee.Modify;
        end;
    end;

    var
        Employee: Record Employee;
}

