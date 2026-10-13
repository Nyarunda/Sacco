
Page 50119 "HR Leave Carryover Request"
{
    PageType = Card;
    SourceTable = "HR Leave Carry Allocation.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(ApplicationCode; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(ApplicantComments; Rec."Applicant Comments")
                {
                    ApplicationArea = Basic;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(JobTittle; Rec."Job Tittle")
                {
                    ApplicationArea = Basic;
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Approveddays; Rec."Approved days")
                {
                    ApplicationArea = Basic;
                }
                field(Attachments; Rec.Attachments)
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
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition",Job;
                    ApprovalEntries: Page "Approval Entries";
                begin

                    /*
                    DocumentType:=DocumentType::Job;
                    ApprovalEntries.Setfilters(DATABASE::Table39005606,DocumentType,"Application Code");
                    ApprovalEntries.RUN;
                    */

                end;
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    /*
                    
                    IF CONFIRM('Send this Carry over request for Approval?',TRUE)=FALSE THEN EXIT;
                    //AppMgmt.SendLeaveCarryoverApprovalReq(Rec);*/

                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    /*
                    IF CONFIRM('Cancel Approval Request?',TRUE)=FALSE THEN EXIT;
                    //AppMgmt.CancelLeaveCarryoverAreasRequest(Rec,TRUE,TRUE);
                    */

                end;
            }
        }
    }
}

