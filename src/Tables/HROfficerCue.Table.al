Table 51112 "HR Officer Cue"
{

    fields
    {
        field(1; "Active Employee"; Integer)
        {
            CalcFormula = count(Employee where(Status = filter(Active)));
            FieldClass = FlowField;
        }
        field(2; "Female Employee"; Integer)
        {
            CalcFormula = count(Employee where(Gender = filter(Female),
                                                      Status = filter(Active)));
            FieldClass = FlowField;
        }
        field(3; "Male Employee"; Integer)
        {
            CalcFormula = count(Employee where(Gender = filter(Male),
                                                      Status = filter(Active)));
            FieldClass = FlowField;
        }
        field(4; "code"; Code[10])
        {
        }
        field(5; "Approved Leave"; Integer)
        {
            CalcFormula = count("HR Leave Application." where(Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(6; "Approved  Trainings"; Integer)
        {
            CalcFormula = count("HR Training App Header" where(Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(7; "Approved Transport Requisition"; Integer)
        {
            CalcFormula = count("HR Transport Requisition Head" where(Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(9; "New Employee"; Integer)
        {
            CalcFormula = count(Employee where(Status = filter(Active)));
            FieldClass = FlowField;
        }
        field(10; "Pending Approval Employee"; Integer)
        {
            CalcFormula = count(Employee where(Status = filter(Active)));
            FieldClass = FlowField;
        }
        field(11; "In-Active Employee"; Integer)
        {
            CalcFormula = count(Employee where(Status = filter(InActive)));
            FieldClass = FlowField;
        }
        field(12; "New Leave"; Integer)
        {
            CalcFormula = count("HR Leave Application." where(Status = const(New)));
            FieldClass = FlowField;
        }
        field(13; "Pending Leave"; Integer)
        {
            CalcFormula = count("HR Leave Application." where(Status = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(15; "Rejected Leave"; Integer)
        {
            CalcFormula = count("HR Leave Application." where(Status = const(Rejected)));
            FieldClass = FlowField;

        }
    }

    keys
    {
        key(Key1; "code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

