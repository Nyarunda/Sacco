Page 50999 "HR Appraissal Appeal"
{
    PageType = Card;
    SourceTable = "HR Appraissal Training";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field(PerformanceGap; Rec."Performance Gap")
                {
                    ApplicationArea = Basic;
                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = Basic;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalNo; Rec."Appraisal No.")
                {
                    ApplicationArea = Basic;
                }
                field(AppraiserName; Rec."Appraiser Name")
                {
                    ApplicationArea = Basic;
                }
                field(AppraissalPeriod; Rec."Appraissal Period")
                {
                    ApplicationArea = Basic;
                }
                field(TrainingRequired; Rec."Training Required")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Enabled = not OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                begin

                    VarVariant := Rec;
                    /*//if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        //CustomApprovals.OnSendDocForApproval(VarVariant);Rec.*/
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                begin
                    VarVariant := Rec;
                    ////CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                begin

                    //approvalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                end;
            }
        }
    }

    var
        HREmp: Record Employee;
        EmpJobDesc: Text[50];
        HRJobs: Record "HR Jobs";
        SupervisorName: Text[60];
        ////SMTP: Codeunit UnknownCodeunit400;
        URL: Text[500];
        HRSetup: Record "HR Setup.";
        EmpDept: Text[30];
        DocumentType: Enum "Custom Document Type";//Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","IB Transfer",EmpTransfer,LeavePlanner,HrAssetTransfer,EmpConfirmation,EmpPromotion,Appraissalappeal;
        ApprovalEntries: Page "Approval Entries";
        //HRLeaveLedgerEntries: Record UnknownRecord39003930;
        EmpName: Text[70];
        ApprovalComments: Page "Approval Comments";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        varDaysApplied: Integer;
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        "LineNo.": Integer;
        sDate: Record Date;
        //Customized: Record "HR Leave Calendar.";
        //HREmailParameters: Record UnknownRecord39003942;
        HRJournalBatch: Record "HR Leave Journal Batch.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        ////CustomApprovals: Codeunit UnknownCodeunit39004245;
        VarVariant: Variant;
}

