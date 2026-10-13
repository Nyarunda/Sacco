Page 51012 "HR Jobs to Succeed List"
{
    ApplicationArea = All;
    CardPageID = "HR Jobs to Succeed Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions,Job,Administration';
    RefreshOnActivate = true;
    SourceTable = "HR Jobs";
    SourceTableView = where("Marked for Succession" = filter(true));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(JobTitle; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                }
                field(NoofPosts; Rec."No of Posts")
                {
                    ApplicationArea = Basic;
                }
                field(OccupiedPositions; Rec."Occupied Positions")
                {
                    ApplicationArea = Basic;
                }
                field(DateCreated; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(MarkedforSuccession; Rec."Marked for Succession")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part("<Page39003906>"; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = field("Job ID");
            }
            systempart(Control1102755004; Outlook)
            {
            }
        }
    }

    actions
    {
    }
}

