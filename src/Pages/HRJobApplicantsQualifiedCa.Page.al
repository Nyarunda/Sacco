Page 51054 "Job Applicants Qualified Card"
{
    Caption = 'HR Job Applicants Qualified Card';
    DeleteAllowed = false;
    Description = 'HR Job Applicants Qualified Card';
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "HR Job Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(JobApplicationNo; Rec."Job Application No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = AttentionAccent;
                    StyleExpr = true;
                }
                field(FirstName; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LastName; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EMail; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateApplied; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(JobAppliedforDescription; Rec."Job Applied for Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                label(InterviewDetails)
                {
                    ApplicationArea = Basic;
                    Caption = 'Interview Details';
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(DateofInterview; Rec."Date of Interview")
                {
                    ApplicationArea = Basic;
                    Style = StandardAccent;
                    StyleExpr = true;
                }
                field(FromTime; Rec."From Time")
                {
                    ApplicationArea = Basic;
                }
                field(ToTime; Rec."To Time")
                {
                    ApplicationArea = Basic;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = Basic;
                }
                field(TotalScoreAfterInterview; Rec."Total Score After Interview")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovalStatus; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","IB Transfer",EmpTransfer,LeavePlanner,HrAssetTransfer;
                //ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::"Job Approval";
                    //ApprovalEntries.Setfilters(Database::"HR Job Applications", DocumentType, HRJobApplicants."Job Application No.");
                    //ApprovalEntries.Run;
                end;
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    /*TESTFIELD("No of Posts");
                    TESTFIELD("Responsibility Center");
                    
                    CALCFIELDS("No. of Requirements");
                    IF "No. of Requirements" = 0 THEN  ERROR('Please Specify the Job Requirements');
                     CALCFIELDS("No. of Responsibilities");
                    
                    IF "No. of Responsibilities" = 0 THEN ERROR('Please Specify the Job Responsibilities');
                     */
                    if Confirm('Send this Job Applicant for Approval?', true) = false then exit;
                    //AppMgmt.SendQualifiedAplicantApprovalReq(Rec);

                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Cancel Approval Request?', true) = false then exit;
                    //AppMgmt.CancelEmpChangeDetailsRequest(Rec,TRUE,TRUE);
                end;
            }
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec."Approval Status" := Rec."approval status"::Approved;
                    Rec.Modify;
                end;
            }
        }
    }

    var
        HRJobApplicants: Record "HR Job Applications";
}

