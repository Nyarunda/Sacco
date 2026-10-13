Table 50292 "Sky Virtual Member"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Telephone; Text[13])
        {
        }
        field(3; Names; Text[50])
        {
        }
        field(4; "Date Of Birth"; Date)
        {
        }
        field(5; Gender; Option)
        {
            OptionCaption = '  ,Male,Female';
            OptionMembers = "  ",Male,Female;
        }
        field(6; Citizenship; Text[30])
        {
        }
        field(7; "Entry Date"; Date)
        {
        }
        field(8; "Entry Time"; Time)
        {
        }
        field(9; "Reffered By"; Code[20])
        {
        }
        field(10; "Employer Name"; Text[50])
        {
        }
        field(11; "Payroll Number"; Code[30])
        {
        }
        field(12; Validated; Boolean)
        {
        }
        field(13; "Sent To Application"; Boolean)
        {
        }
        field(14; "ID Number"; Code[30])
        {
        }
        field(15; "Employer Code"; Code[10])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Customer.Get("Employer Code") then
                    "Employer Name" := Customer.Name;
            end;
        }
        field(16; "Actioned By"; Code[50])
        {
        }
        field(17; Email; Text[30])
        {
        }
        field(18; "Session ID"; Code[50])
        {
        }
        field(19; "Service Number"; Text[30])
        {
        }
        field(20; Employer; Text[50])
        {
        }
        field(21; "Referer Member No"; Code[30])
        {
            TableRelation = Customer;
        }
        field(22; "Name on IPRS"; Code[100])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Customer: Record Customer;
}

