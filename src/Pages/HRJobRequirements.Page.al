Page 50848 "HR Job Requirements"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Jobs";

    layout
    {
        area(content)
        {
            group("Job Specification")
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
            }
            /*
            group("Job Requirements")
            {
                part("Job Req";Rec."HR Job Requirement Lines")
                {
                    SubPageLink = "Job ID" = field("Job ID");
                }
            }
            */
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Job- Requirements")
            {
                ApplicationArea = Basic;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    HRJobReq.Reset;
                    HRJobReq.SetRange(HRJobReq."Job ID", Rec."Job ID");
                    if HRJobReq.Find('-') then begin
                        Report.Run(Report::"HR Job Requirements", true, true, HRJobReq);
                    end;
                end;
            }
        }
    }

    var
        HRJobReq: Record "HR Jobs";
}

