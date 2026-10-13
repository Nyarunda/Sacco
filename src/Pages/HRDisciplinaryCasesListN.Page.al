Page 51078 "HR Disciplinary Cases List N"
{
    ApplicationArea = All;
    Caption = 'Employee Disciplinary Cases ';
    CardPageID = "HR Disciplinary Case Card N";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Functions,Case Status,Show';
    SourceTable = "HR Disciplinary Cases NCA";
    SourceTableView = where("Disciplinary Stage Status" = filter(<> Closed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CaseNumber; Rec."Case Number")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(DateofComplaint; Rec."Date of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(TypeComplaint; Rec."Type Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(Reporter; Rec.Reporter)
                {
                    ApplicationArea = Basic;
                }
                field(AccusedEmployee; Rec."Accused Employee")
                {
                    ApplicationArea = Basic;
                }
                field(DescriptionofComplaint; Rec."Description of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(DisciplinaryStageStatus; Rec."Disciplinary Stage Status")
                {
                    ApplicationArea = Basic;
                    Style = StandardAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755006; "HR Disciplinary Cases Factbox")
            {
                Caption = 'HR Disciplinary Cases Factbox';
                SubPageLink = "Case Number" = field("Case Number");
            }
            systempart(Control1102755009; Outlook)
            {
            }
        }
    }

    actions
    {
    }

    var
        "Document Type": Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Leave Journal","Medical Claims","Activity Approval","Disciplinary Approvals";
}

