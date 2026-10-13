Table 51087 "Leave Allowances"
{

    fields
    {
        field(1; "Application No."; Code[10])
        {
        }
        field(2; "Employee No."; Code[10])
        {
        }
        field(3; "Employee Name"; Text[50])
        {
        }
        field(4; "Start Date"; Date)
        {
        }
        field(5; "End Date"; Date)
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; Paid; Boolean)
        {
        }
        field(8; Year; Integer)
        {
        }
        field(9; "Date Posted"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Application No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

