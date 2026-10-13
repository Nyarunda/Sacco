Page 50847 "HR Jobs Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Jobs";

    layout
    {
        area(content)
        {
            field(JobID; Rec."Job ID")
            {
                ApplicationArea = Basic;
            }
            field(JobDescription; Rec."Job Description")
            {
                ApplicationArea = Basic;
            }
            field(NoofPosts; Rec."No of Posts")
            {
                ApplicationArea = Basic;
            }
            field(PositionReportingto; Rec."Position Reporting to")
            {
                ApplicationArea = Basic;
            }
            field(OccupiedPositions; Rec."Occupied Positions")
            {
                ApplicationArea = Basic;
            }
            field(VacantPositions; Rec."Vacant Positions")
            {
                ApplicationArea = Basic;
            }
            field(Category; Rec.Category)
            {
                ApplicationArea = Basic;
            }
            field(Grade; Rec.Grade)
            {
                ApplicationArea = Basic;
            }
            field(EmployeeRequisitions; Rec."Employee Requisitions")
            {
                ApplicationArea = Basic;
            }
            field(SupervisorName; Rec."Supervisor Name")
            {
                ApplicationArea = Basic;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
            field(ResponsibilityCenter; Rec."Responsibility Center")
            {
                ApplicationArea = Basic;
            }
            field(DateCreated; Rec."Date Created")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.Validate("Vacant Positions");
    end;
}

