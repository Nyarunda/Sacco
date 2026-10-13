tableextension 50077 "Team Member Cue ext" extends "Team Member Cue"
{
    fields
    {
        field(90000; "Overtime - Application"; Integer)
        {
            Caption = 'Overtime Application';
            CalcFormula = count("HR Overtime Header" where(Status = const(Open),
                            "Created By" = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(90001; "Transport Application"; Integer)
        {
            Caption = 'Transport Application';
            CalcFormula = count("HR Transport Application" where(Code = filter(<> '')));
            FieldClass = FlowField;
        }
        field(90002; "Leave - Application"; Integer)
        {
            Caption = 'Leave - Application';
            CalcFormula = count("HR Leave Application." where(Status = const(New),
                                                               "Applicant User ID" = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(90003; "Leave - Pending"; Integer)
        {
            Caption = 'Leave - Pending';
            CalcFormula = count("HR Leave Application." where(Status = const("Pending Approval"),
                                                               "Applicant User ID" = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(90004; "Leave - Approved"; Integer)
        {
            Caption = 'Leave - Approved';
            CalcFormula = count("HR Leave Application." where(Status = const(Approved),
                                                               "Applicant User ID" = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(90005; "Leave - Rejected"; Integer)
        {
            Caption = 'Leave - Rejected';
            CalcFormula = count("HR Leave Application." where(Status = const(Rejected),
                                                               "Applicant User ID" = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(90006; "Salary Advance Application"; Integer)
        {
            Caption = 'Salary Advance - Application';
            CalcFormula = count("PR Salary Advance" where(Status = filter(open),
                                                               "Created By" = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(90007; "Leave - Planner"; Integer)
        {
            Caption = 'Leave Planner';
            CalcFormula = count("HR Leave Planner Header" where("Employee User ID" = field("User ID Filter")));
            FieldClass = FlowField;
        }
    }
}
