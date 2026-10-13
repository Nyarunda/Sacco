Page 50859 "HR Employee Reqs List Approved"
{
    ApplicationArea = All;
    CardPageID = "HR Employee Requisition Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Job,Functions,Employee';
    ShowFilter = true;
    SourceTable = "HR Employee Requisitions";
    SourceTableView = where("Approval Status" = filter(Approved));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                field(RequisitionNo; Rec."Requisition No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }
                field(RequisitionDate; Rec."Requisition Date")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }
                field(JobTitle; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                }
                field(ReasonForRequest; Rec."Reason For Request")
                {
                    ApplicationArea = Basic;
                }
                field(RequiredPositions; Rec."Required Positions")
                {
                    ApplicationArea = Basic;
                }
                field(Contract; Rec."Type of Contract Required")
                {
                    ApplicationArea = Basic;
                    Caption = 'Contract';
                    Editable = false;
                }
                field(ApprovalStatus; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Style = Attention;
                }
            }
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
    }

    trigger OnAfterGetRecord()
    begin
        SetUpdateControl;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetUpdateControl;
    end;

    trigger OnOpenPage()
    begin
        SetUpdateControl;
    end;

    var
        HREmp: Record Employee;
        //HREmailParameters: Record UnknownRecord39003942;
        ////SMTP: Codeunit UnknownCodeunit400;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition";
        //ApprovalEntries: Page "Approval Entries";
        HREmpReq: Record "HR Employee Requisitions";

    local procedure SetUpdateControl()
    var
        myInt: Integer;
    begin
        if Rec."Approval Status" = Rec."Approval Status"::Approved then
            CurrPage.Editable := false;
    end;

    procedure TESTFIELDS()
    begin
        Rec.TestField("Job ID");
        Rec.TestField("Closing Date");
        Rec.TestField("Type of Contract Required");
        Rec.TestField("Requisition Type");
        Rec.TestField("Required Positions");
        if Rec."Reason For Request" = Rec."reason for request"::Other then
            Rec.TestField("Reason for Request(Other)");
    end;
}

