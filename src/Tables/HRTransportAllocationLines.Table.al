Table 51043 "HR Transport Allocation Lines"
{

    fields
    {
        field(1; "Allocation No"; Code[20])
        {
            TableRelation = "HR Transport Allocations Head"."Transport Allocation No";
        }
        field(2; "Employee No"; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(3; "Passenger's Full Name"; Text[70])
        {
        }
        field(4; Department; Text[70])
        {
        }
        field(5; "Requisition No"; Code[10])
        {
            TableRelation = "HR Transport Requisition Head";

            trigger OnValidate()
            begin
                HRTransportRequests.Reset;
                if HRTransportRequests.Get("Requisition No") then begin
                    "Employee No" := HRTransportRequests."Employee No";
                    "Passenger's Full Name" := HRTransportRequests."Employee Name";
                    From := HRTransportRequests.From;
                    Destination := HRTransportRequests.Destination;
                end;
            end;
        }
        field(6; From; Text[30])
        {
        }
        field(7; Destination; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Allocation No", "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmp: Record Employee;
        HRTransportRequests: Record "HR Transport Requisition Head";
        HRTransportAllocationH: Record "HR Transport Allocations Head";
}

