Page 51030 "HR Individual BSC List"
{
    ApplicationArea = All;
    CardPageID = "HR Leave Carryover Request";
    PageType = List;
    SourceTable = "HR Appraisal Header";
    SourceTableView = where("Target Type" = filter("Individual Targets"),
                            Sent = filter(Appraisee));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalType; Rec."Appraisal Type")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalPeriod; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalNo; Rec."Appraisal No")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(JobTitle; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control11; Outlook)
            {
            }
            systempart(Control12; Notes)
            {
            }
            systempart(Control13; MyNotes)
            {
            }
            systempart(Control14; Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Approve All Individual Targets")
            {
                ApplicationArea = Basic;
            }
            action("Approve Marked Targets")
            {
                ApplicationArea = Basic;
            }
            action("Return All Individual Targets")
            {
                ApplicationArea = Basic;
            }
            action("Return Marked Targets")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

