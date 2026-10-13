Page 50861 "HR Job Applications List"
{
    ApplicationArea = All;
    CardPageID = "HR Job Applications Card";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Applicant,Functions,Print';
    SourceTable = "HR Job Applications";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                field(JobApplicationNo; Rec."Job Application No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(FullName; Rec."Full Name")
                {
                    ApplicationArea = Basic;
                }
                field(DateApplied; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }
                field(ApplicationRefNo; Rec."Employee Requisition No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application Ref. No.';
                }
                field(JobAppliedFor; Rec."Job Applied For")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Applied For';
                }
                field(JobDescription; Rec."Job Applied for Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Description';
                }
                field(DocumentStatus; Rec."Document Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1; Links)
            {
            }
        }
    }

    actions
    {
    }

    var
        HRJobApplications: Record "HR Job Applications";
        Text001: label 'Are you sure you want to Upload Applicants Details to the Employee Card?';
        Text002: label 'Are you sure you want to Send an Interview Application?';
}

