
Table 50307 "Dummy Staff HR"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; FNAme; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; SName; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; PIN; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; NSSF; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; NHIF; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; JOB; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; DEPT; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; MemberNo; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Email; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Updated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Employee.Get("No.") then begin
            Employee.PIN := PIN;
            Employee."NSSF No." := NSSF;
            Employee."NHIF No." := NHIF;
            Employee."Job Title" := JOB;
            Employee.Department := DEPT;
            Employee."Member No" := MemberNo;
            Employee."E-Mail" := Email;
            Employee.Modify;
            Updated := true;

        end;
    end;

    var
        Employee: Record Employee;
}

