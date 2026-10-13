Table 51075 "HR Medical Overexpenditure"
{

    fields
    {
        field(1; "Application No."; Code[20])
        {
        }
        field(2; "Employee No."; Code[10])
        {
            TableRelation = Employee."No.";
        }
        field(3; "Employee Name"; Text[50])
        {
        }
        field(4; Designation; Code[20])
        {
        }
        field(5; Region; Code[20])
        {
        }
        field(6; Department; Code[20])
        {
        }
        field(7; "Scheme Provider"; Code[20])
        {
        }
        field(8; Amount; Decimal)
        {
        }
        field(9; "Hospital to be paid"; Text[100])
        {
        }
        field(10; Date; Date)
        {
        }
        field(11; Status; Option)
        {
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(12; Eligible; Boolean)
        {
        }
        field(13; "No. Series"; Code[10])
        {
        }
        field(14; "Responsibility Centre"; Code[10])
        {
            //TableRelation = Table52018718.Field1;
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

