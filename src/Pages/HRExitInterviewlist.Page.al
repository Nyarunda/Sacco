Page 51101 "HR Exit Interview list"
{
    CardPageID = "HR Employee Exit Interviews";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Employee Exit Interviews";
    SourceTableView = where(Closed = const(false),
                            Status = filter(<> Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ExitInterviewNo; Rec."Exit Interview No")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(DateOfInterview; Rec."Date Of Interview")
                {
                    ApplicationArea = Basic;
                }
                field(InterviewerName; Rec."Interviewer Name")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(ReasonForLeaving; Rec."Reason For Leaving")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

