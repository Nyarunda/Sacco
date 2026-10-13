Page 50974 "HR Training Application List"
{
    ApplicationArea = All;
    CardPageID = "HR Training Application Header";
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Training App Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ApplicationNo; Rec."Application No")
                {
                    ApplicationArea = Basic;
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
                }
            }
        }
        area(factboxes)
        {
            systempart(Control17; Outlook)
            {
            }
            systempart(Control18; Notes)
            {
            }
            systempart(Control19; Links)
            {
            }
        }
    }

    actions
    {
    }
}

