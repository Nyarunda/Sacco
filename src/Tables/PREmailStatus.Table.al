Table 51127 "PR Email Status"
{

    fields
    {
        field(1; "Employee No"; Code[10])
        {
            Editable = false;
        }
        field(2; "Payroll Period"; Date)
        {
            Editable = false;
        }
        field(3; "Date Sent"; Date)
        {
            Editable = false;
        }
        field(4; Status; Text[100])
        {
            Editable = false;
        }
        field(5; Batch; Code[20])
        {
            Editable = false;
            Enabled = false;
        }
    }

    keys
    {
        key(Key1; "Employee No", "Payroll Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

