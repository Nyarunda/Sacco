Table 51029 "HR Commitee Members"
{

    fields
    {
        field(1; "Committee Member No."; Code[20])
        {
            TableRelation = if (Type = const(Member)) Customer."No."
            else
            if (Type = const(Employees)) Employee."No.";

            trigger OnValidate()
            begin
                if Type = Type::Employees then begin
                    HREmp.Reset;
                    HREmp.Get("Committee Member No.");
                    "Member Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                end else begin
                    if Type = Type::Member then
                        Membrs.Reset;
                    Membrs.Get("Committee Member No.");
                    "Member Name" := Membrs.Name;
                end;
            end;
        }
        field(2; "Member Name"; Text[100])
        {
        }
        field(3; Role; Text[100])
        {
        }
        field(8; "Date Appointed"; Date)
        {
        }
        field(9; Grade; Code[20])
        {
        }
        field(10; Active; Boolean)
        {
        }
        field(11; Committee; Code[20])
        {
            TableRelation = "HR Disciplinary Cases"."Case Number";
        }
        field(12; No; Code[20])
        {
        }
        field(13; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50000; Type; Option)
        {
            OptionCaption = 'Member,Employees';
            OptionMembers = Member,Employees;
        }
    }

    keys
    {
        key(Key1; Committee, "Committee Member No.", No, "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmp: Record Employee;
        Membrs: Record Customer;
}

