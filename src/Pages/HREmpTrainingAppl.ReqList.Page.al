Page 51075 "HR Emp Training Appl. Req List"
{
    ApplicationArea = All;
    CardPageID = "HR Emp Training App. Header";
    DeleteAllowed = false;
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
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(TrainingInstitutionName; Rec."Training Institution Name")
                {
                    ApplicationArea = Basic;
                }
                field(TrainingVenue; Rec."Training Venue")
                {
                    ApplicationArea = Basic;
                }
                field(TrainingCostCstimated; Rec."Training Cost Cstimated")
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

