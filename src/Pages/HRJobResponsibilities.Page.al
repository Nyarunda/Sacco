Page 50849 "HR Job Responsibilities"
{
    ApplicationArea = All;
    Caption = 'HR Job Responsibilities';
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Qualification';
    SourceTable = "HR Jobs";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Job Details';
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(JobDescription; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(PositionReportingto; Rec."Position Reporting to")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(SupervisorName; Rec."Supervisor Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(NoofPosts; Rec."No of Posts")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field(OccupiedPositions; Rec."Occupied Positions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(VacantPositions; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field(EmployeeRequisitions; Rec."Employee Requisitions")
                {
                    ApplicationArea = Basic;
                }
            }
            /*
            part(Control1102755008;Rec."HR Job Responsiblities Lines")
            {
                Caption = 'Job Responsibilities';
                SubPageLink = "Job ID" = field("Job ID");
            }
            */

        }
        area(factboxes)
        {
            systempart(Control1102755013; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(JobResposibilities)
            {
                ApplicationArea = Basic;
                Caption = 'Job Resposibilities';
                Image = "Report";
                Promoted = true;

                trigger OnAction()
                begin
                    HRJobResponsibilities.Reset;
                    HRJobResponsibilities.SetRange(HRJobResponsibilities."Job ID", Rec."Job ID");
                    if HRJobResponsibilities.Find('-') then begin
                        Report.Run(Report::"HR Job Responsibilities", true, true, HRJobResponsibilities);
                    end;
                end;
            }
        }
    }

    var
        HRJobResponsibilities: Record "HR Job Responsiblities";
}

