Page 51120 "HR Promotion Recommend AppHead"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Promotion';
    SourceTable = "HR Promo. Recommend Header";
    SourceTableView = where(Promoted = const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(JobTitle; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SalaryGrade; Rec."Salary Grade")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SalaryNotch; Rec."Salary Notch")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Region; Rec."Shortcut Dimension code1")
                {
                    ApplicationArea = Basic;
                    Caption = 'Region';
                    Editable = false;
                }
                field(Department; Rec."Shortcut Dimension code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Department';
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Competencies; Rec.Competencies)
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(DevelopmentAreas; Rec."Development Areas")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(NewJobID; Rec."New Job ID")
                {
                    ApplicationArea = Basic;
                }
                field(NewJobTitle; Rec."New Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(NewSalaryGrade; Rec."New Salary Grade")
                {
                    ApplicationArea = Basic;
                }
                field(NewSalaryNotch; Rec."New Salary Notch")
                {
                    ApplicationArea = Basic;
                }
                field(Reason; Rec.Reason)
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
            }
            /*
            part(Control16;Rec."HR Employee Qualification Ln")
            {
                Caption = 'Employee Qualifications';
                SubPageLink = "Employee No." = field("Employee No.");
            }
            */
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*
        PromoLinesrec.Reset;
        PromoLinesrec.SetRange(PromoLinesrec."Document No", No);
        if PromoLinesrec.Find('-') then
            PromoLinesrec."Document No" := No;
            */
    end;

    var
        HREmp: Record Employee;
        EmpJobDesc: Text[50];
        HRJobs: Record "HR Jobs";
        SupervisorName: Text[60];
        //SMTP: Codeunit UnknownCodeunit400;
        URL: Text[500];
        HRSetup: Record "HR Setup.";
        EmpDept: Text[30];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","IB Transfer",EmpTransfer,LeavePlanner,HrAssetTransfer,EmpConfirmation,EmpPromotion;
        ApprovalEntries: Page "Approval Request Entries";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries.";
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
        Customized: Record "HR Leave Calendar.";
        //HREmailParameters: Record UnknownRecord39003942;
        HRJournalBatch: Record "HR Leave Journal Batch.";
        //PromoLinesrec: Record UnknownRecord39003986;
        Txt001: label 'Do you want to promote this employee?';
        Txt002: label 'Employee No. %1 has been successfully promoted';
        Employees: Record Employee;
}

