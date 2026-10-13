Table 51114 "HR Manager Cue"
{

    fields
    {
        field(1; Active; Integer)
        {
            CalcFormula = count(Employee where(Status = filter(Active)));
            FieldClass = FlowField;
        }
        field(2; Female; Integer)
        {
            CalcFormula = count(Employee where(Gender = filter(" "),
                                                      Status = filter(Active)));
            FieldClass = FlowField;
        }
        field(3; Male; Integer)
        {
            CalcFormula = count(Employee where(Gender = filter(Male),
                                                      Status = filter(Active)));
            FieldClass = FlowField;
        }
        field(4; "Code"; Code[20])
        {
        }
        field(5; "Approved Job Posistions"; Integer)
        {
            CalcFormula = count("HR Jobs" where(Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(6; "Requisitions Pending Approval"; Integer)
        {
            //CalcFormula = count("HR Employee Requisitions" where("Approval Status" = const(Approved)));
            //FieldClass = FlowField;
        }
        field(7; "Pending Approvals"; Integer)
        {
            //CalcFormula = count(Table454 where(Field9 = const(1)));
            //FieldClass = FlowField;
        }
        field(8; "Contracts Due"; Integer)
        {
            //CalcFormula = count(Employee where("Contract End Date" = filter(040816)));
            //FieldClass = FlowField;
        }
        field(9; "Probation Due"; Integer)
        {
        }
        field(10; "Upcoming Birthdays"; Integer)
        {
        }
        field(11; "Leave Resume Due"; Integer)
        {
        }
        field(12; "Upcoming Leave"; Integer)
        {
        }
        field(13; "Upcoming Company Activities"; Integer)
        {
        }
        field(14; "Upcoming Staff Separation"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        OneMonth: Date;
}

