Page 50979 "HR Training App List -Approved"
{
    ApplicationArea = All;
    CardPageID = "HR Training App. Card - Approv";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Training App Header";
    SourceTableView = where(Status = filter(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ApplicationNo; Rec."Application No")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(CourseTitle; Rec."Course Title")
                {
                    ApplicationArea = Basic;
                }
                field(CourseDescription; Rec."Course Description")
                {
                    ApplicationArea = Basic;
                }
                field(NoofParticipants; Rec."No. of Participants")
                {
                    ApplicationArea = Basic;
                }
                field(StartDate; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control5; Outlook)
            {
            }
            systempart(Control4; Notes)
            {
            }
            systempart(Control3; Links)
            {
            }
        }
    }

    actions
    {
    }
}

