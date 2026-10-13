Page 50393 "HR Advanced Setup"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = false;
    SourceTable = "HR Setup.";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(DefaultLeavePostingTemplate; Rec."Default Leave Posting Template")
                {
                    ApplicationArea = Basic;
                }
                field(PositiveLeavePostingBatch; Rec."Positive Leave Posting Batch")
                {
                    ApplicationArea = Basic;
                }
                field(NegativeLeavePostingBatch; Rec."Negative Leave Posting Batch")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field(JobIDNos; Rec."Job ID Nos")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeRequisitionNos; Rec."Employee Requisition Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(JobApplicationNos; Rec."Job Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNos; Rec."Employee Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeConfirmationNo; Rec."Employee Confirmation No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeePromotionNo; Rec."Employee Promotion No.")
                {
                    ApplicationArea = Basic;
                }
                field(TrainingApplicationNos; Rec."Training Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(LeaveApplicationNos; Rec."Leave Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(LeaveReimbursmentNos; Rec."Leave Reimbursment Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(LeaveCarryOverAppNos; Rec."Leave Carry Over App Nos.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(LeavePlannerNos; Rec."Leave Planner Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Plan Application Month"; Rec."Leave Plan Application Month")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Plan Min Days Allowed"; Rec."Leave Plan Min Days Allowed")
                {
                    ApplicationArea = Basic;
                }
                field(DisciplinaryCasesNos; Rec."Disciplinary Cases Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(ExitInterviewNos; Rec."Exit Interview Nos")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalNos; Rec."Appraisal Nos")
                {
                    ApplicationArea = Basic;
                }
                field(CompanyActivities; Rec."Company Activities")
                {
                    ApplicationArea = Basic;
                }
                field(NoticeBoardNos; Rec."Notice Board Nos.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(CompanyDocuments; Rec."Company Documents")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(TransportReqNos; Rec."Transport Req Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Advance Nos."; Rec."Salary Advance Nos.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary Advance Nos.';
                }
                field(TransportAllocationNos; Rec."Transport Allocation Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(HRPolicies; Rec."HR Policies")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeTransferNos; Rec."Employee Transfer Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeAssetTransferNo; Rec."Employee Asset Transfer No.")
                {
                    ApplicationArea = Basic;
                }
                field(ShiftNos; Rec."Shift Nos")
                {
                    ApplicationArea = Basic;
                }
                field(ShiftScheduleNos; Rec."Shift Schedule Nos")
                {
                    ApplicationArea = Basic;
                }
                field(ProffessionalBodiesNos; Rec."Proffessional Bodies Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(TraningNeedsNos; Rec."Traning Needs Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(SuccessionPlanningNos; Rec."Succession Planning Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(MedicalClaimsNos; Rec."Medical Claims Nos")
                {
                    ApplicationArea = Basic;
                }
                field(InductionNos; Rec."Induction Nos")
                {
                    ApplicationArea = Basic;
                }
                field(OvertimeReqNos; Rec."Overtime Req Nos.")
                {
                    ApplicationArea = Basic;
                }


                field(IncidentNos; Rec."Incident Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(InvestigationNos; Rec."Investigation Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(PRDeductionNos; Rec."PR Deduction Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(PRAllowancesNos; Rec."PR Allowances Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(PaychangeNo; Rec."Pay-change No.")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Training Application Nos."; Rec."Training Application Nos.")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Transport Application Nos"; Rec."Transport Application Nos")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
            }
            group(Appraisal)
            {
                Caption = 'Appraisal';
                field(AppraisalPostingPeriodFROM; Rec."Appraisal Posting Period[FROM]")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalPostingPeriodTO; Rec."Appraisal Posting Period[TO]")
                {
                    ApplicationArea = Basic;
                }
                field(MaxAppraisalRating; Rec."Max Appraisal Rating")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(AppraisalMethod; Rec."Appraisal Method")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(AppraisalTemplate; Rec."Appraisal Template")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(AppraisalBatch; Rec."Appraisal Batch")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(TargetSettingMonth; Rec."Target Setting Month")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field(AppraisalInterval; Rec."Appraisal Interval")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Max Appraisal Rating"; Rec."Max Appraisal Rating")
                {
                    ApplicationArea = Basic;

                }

            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}

