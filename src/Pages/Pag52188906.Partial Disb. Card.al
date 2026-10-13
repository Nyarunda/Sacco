page 50772 "Partial Disb. Card"
{
    Caption = 'Partial Disbursement Card';
    PageType = Card;
    SourceTable = "Partial Loans Disb. Header";
    DeleteAllowed = false;

    PromotedActionCategories = 'New,Process,Report,Send Approval Request,Post,Loan Charges';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mode of Disbursement field.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }
                field("Disbursement Acc. Type"; Rec."Disbursement Acc. Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Disbursement Account No"; Rec."Disbursement Account No")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = all;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = all;
                }
                field(LoanProductType; Rec."Loan Product Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Loan Moratorium Start Date"; Rec."Loan Moratorium Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Moratorium Start Date field.';
                }
                field("Loan Moratorium End Date"; Rec."Loan Moratorium End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Moratorium End Date field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Schedule Start Date"; Rec."Schedule Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason field.';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Captured By field.';
                }
                field("Time Captured"; Rec."Time Captured")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Captured field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows whether the related credit ledger entry for this partial disbursement has been reversed.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = All;
                }
                field("Exempt Charges"; Rec."Exempt Charges")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether loan charges should be excluded from this partial disbursement posting.';

                    trigger OnValidate()
                    begin
                        CurrPage.category1.Page.Update(false);
                    end;
                }
            }
            part(category1; "Partial Disb. Lines")
            {
                ApplicationArea = all;
                Caption = 'Partial Disbursement Lines';
                Editable = PageEditable;
                SubPageLink = "Header No." = field("No."), "Member No" = field("Member No."), "Loan No." = field("Loan No.");
            }
            group(Disbursement)
            {
                part(Accounts; "HR Bank Accounts List")
                {
                    Caption = 'Disbursement Details';
                    ApplicationArea = Basic;
                    Editable = PageEditable;
                    SubPageLink = "Loan No." = field("No.");
                    UpdatePropagation = Both;
                }
            }

        }
        area(factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Partial Loans Disb. Header"),
                              "No." = field("No.");
                UpdatePropagation = Both;
            }
        }

    }
    actions
    {
        // Preview button action
        area(Reporting)
        {
            action(PreviewSchedule)
            {
                Caption = 'Preview Repayment Schedule';
                Image = ViewDetails;
                ApplicationArea = All;
                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                    LoansRec: Record Loans;
                    TempSchedule: Record "Loan Repayment Schedule" temporary;
                begin
                    if not LoansRec.Get(Rec."Loan No.") then
                        Error('Loan record %1 not found.', Rec."Loan No.");

                    SaccoActivities.PreviewRepaymentScheduleWithPartialDisbursement(LoansRec, Rec."No.");
                    Commit();

                    LoansRec.Reset();
                    LoansRec.SetRange("Loan No.", Rec."Loan No.");
                    if LoansRec.FindFirst() then begin
                        LoansRec."Disbursement Date" := Rec."Posting Date";
                        Report.Run(Report::"Static Loan Repayment Schedule", true, false, LoansRec);
                    end;
                end;
            }
            action("Disbursement Letter")
            {
                ApplicationArea = Basic;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LoanTopUp: Record "Loan Top Up";
                    PostedLoan: Record Loans;
                    PartialDisbursementPartial: Report "Partial Disbursement-Partial";
                begin
                    PostedLoan.Reset();
                    PostedLoan.SetRange("Loan No.", Rec."Loan No.");
                    if not PostedLoan.FindFirst() then
                        exit;

                    // Old call passed the page Rec directly:
                    // Report.Run(Report::"Partial Disbursement Letter", true, false, Rec)
                    PartialDisbursementPartial.SetPartialHeaderNo(Rec."No.");
                    PartialDisbursementPartial.SetTableView(PostedLoan);
                    PartialDisbursementPartial.RunModal();

                end;
            }
            action("Appraisal Back Page Partial")
            {
                ApplicationArea = Basic;
                Caption = 'Appraisal Back Page Partial';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    PartialDisbHeader: Record "Partial Loans Disb. Header";
                begin
                    PartialDisbHeader.SetRange("No.", Rec."No.");
                    Report.Run(Report::"Appraisal Back Page Partial", true, false, PartialDisbHeader);
                end;
            }

            action(AddGuarantors)
            {
                Caption = 'Add Guarantors';
                Image = SocialSecurity;
                ApplicationArea = All;
                ToolTip = 'Add new guarantors for this disbursement tranche.';

                trigger OnAction()
                var
                    LoanSecurityBufferPage: Page "Loan Security Buffer";
                begin
                    LoanSecurityBufferPage.SetLoanNo(Rec."Loan No.");
                    LoanSecurityBufferPage.RunModal();
                    CurrPage.Update(false);
                end;
            }
        }

        area(navigation)
        {
            action(Post)
            {
                Caption = 'Post';
                ApplicationArea = Basic;
                Image = Post;
                Visible = true;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    i: Integer;
                begin

                    Rec.TestField(Status, Rec.Status::Approved);
                    if Rec.Posted then
                        Error('The Partial Disbusements batch has been posted');

                    if Confirm('Are you sure you want to POST this Partial Disbusement?') then begin

                        SaccoT.PostPartialLoanDisbursement(Rec."No.");

                        PostLoanSecurityFromBuffer(Rec."Loan No.");

                        //SaccoT.SendLoansEmails(Rec."Loan No.");
                        LoanLogs.Reset();
                        if LoanLogs.FindLast() then
                            i := LoanLogs.Line + 1
                        else
                            i := 1;

                        LoanLogs.Init();
                        LoanLogs."Loan No." := Rec."Loan No.";
                        LoanLogs.Line := i;
                        LoanLogs.Source := LoanLogs.Source::"Partial Letter";
                        LoanLogs.Msg := '';
                        LoanLogs."Partial Disbur. Header No." := Rec."No.";
                        if LoanLogs.Insert() then;
                        Message('Partial Disbursement for Loan %1 has been processed successfully.', Rec."Loan No.");


                        CurrPage.Close();
                    end;
                end;
            }
            action("Mark as Posted")
            {
                Caption = 'Mark as Posted';
                ApplicationArea = Basic;
                Image = MakeAgreement;

                trigger OnAction()
                begin
                    if Rec.Posted then
                        Error('The Partial Disbursement has already been marked as posted.');

                    if not Confirm('Are you sure you want to mark this Partial Disbursement as posted?', false) then
                        exit;

                    Rec.Posted := true;
                    Rec."Date Posted" := Today;
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                Enabled = Rec.Status = rec.Status::Open;
                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";


                    DocumentType: Enum "Custom Document Type";
                    CalwideApprovals: Codeunit "Calwide Approvals";
                    VarVariant: Variant;
                    PartialLines: Record "Partial Loans Disb. Lines";
                    SecBuffer: Record "Loan Security Buffer";
                    BankAccounts: Record "HR Employee Bank Accounts";
                begin
                    BankAccounts.Reset();
                    BankAccounts.SetRange("Loan No.", Rec."No.");
                    if BankAccounts.IsEmpty() then
                        Error('No source bank accounts defined for Loan %1. Please define source accounts before posting.', Rec."Loan No.");

                    Rec.TestField(Reason);

                    PartialLines.ValidateGuarantorCoverage(Rec."No.");
                    VarVariant := Rec;
                    CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Partial Loans", '', '', 0);
                    CurrPage.Close();
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                Enabled = Rec.Status = rec.Status::Pending;
                PromotedCategory = Category4;
                //Visible = CancelBool;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    CalwideApprovals: Codeunit "Calwide Approvals";
                    VarVariant: Variant;
                begin
                    Rec.TestField(Status, Rec.Status::Pending);

                    VarVariant := Rec;
                    CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
                    CurrPage.Close();
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    RecRef: RecordRef;
                    DocumentType: Enum "Custom Document Type";
                    VarVariant: Variant;
                    ApprovalTracker: Record "Approval Tracker";
                begin
                    VarVariant := Rec;
                    RecRef.GetTable(VarVariant);


                    ApprovalTracker.Reset;
                    ApprovalTracker.SetRange("Table ID", RecRef.Number);
                    ApprovalTracker.SetRange("Document No.", Rec."No.");
                    ApprovalTracker.SetRange("Custom Document Type", DocumentType::"Partial Loans");
                    if ApprovalTracker.FindFirst then
                        approvalsMgmt.OpenApprovalEntriesPage(RecRef.RecordId);
                end;
            }
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                begin
                    Rec.TestField(status, Rec.Status::Pending);
                    ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    CurrPage.Close();
                end;
            }

            action("Loan Charges")
            {

                ApplicationArea = All;
                Image = Costs;
                Promoted = true;
                PromotedCategory = category6;
                RunObject = Page "Loan Charges";
                RunPageLink = "Loan No." = field("No."), "Loan Product Type" = field("Loan Product Type");
            }
            action("Reopen Document")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = Rec.Status = rec.Status::Approved;
                trigger OnAction()
                begin

                    if (Rec.Status <> Rec.Status::Open) and (Rec.Status <> Rec.Status::Pending) then begin

                        if not Confirm('Are you sure you want to re-open document?') then exit;

                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;

                        CurrPage.Close();

                    end;
                end;
            }

        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
    end;


    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;

    end;

    var
        SaccoT: Codeunit "Sacco Activities";
        TempLoanSecurityBuffer: Record "Loan Security Buffer";
        LoanLogs: Record "Email Logs Notifications";
        PageEditable: Boolean;



    local procedure UpdateControls()
    begin
        PageEditable := (Rec.Status = Rec.Status::Open) and (not Rec.Posted);
        CurrPage.Editable := PageEditable;
    end;

    procedure PostLoanSecurityFromBuffer(LoanNo: Code[20])
    var
        LoanSecurity: Record "Loan Security";
        LoopRec: Record "Loan Security Buffer";
    begin
        LoopRec.Reset();
        LoopRec.SetRange("Loan No.", LoanNo);
        if LoopRec.IsEmpty() then begin
            Message('No guarantor lines to post for Loan %1.', LoanNo);
            exit;
        end;

        LoopRec.FindSet();
        repeat
            // Check if this record already exists in Loan Security
            LoanSecurity.Reset();
            LoanSecurity.SetRange("Loan No.", LoopRec."Loan No.");
            LoanSecurity.SetRange("Account No.", LoopRec."Account No.");

            if not LoanSecurity.FindFirst() then begin
                // Does not exist — insert it
                LoanSecurity.Init();
                LoanSecurity."Loan No." := LoopRec."Loan No.";
                LoanSecurity."Account No." := LoopRec."Account No.";
                LoanSecurity."Collateral Reg. No." := LoopRec."Collateral Reg. No.";
                LoanSecurity."Guarantor Type" := LoopRec."Guarantor Type";
                LoanSecurity."Self Guarantee" := LoopRec."Self Guarantee";
                LoanSecurity."Member No" := LoopRec."Member No";
                LoanSecurity.Validate("Account No.", LoopRec."Account No.");
                LoanSecurity.Validate("Amount Guaranteed", LoopRec."Amount Guaranteed");
                LoanSecurity.Insert(true);
            end else begin

                LoanSecurity."Amount Guaranteed" += LoopRec."Amount Guaranteed";
                LoanSecurity."Collateral Reg. No." := LoopRec."Collateral Reg. No.";
                LoanSecurity.Modify(true);
            end;

        until LoopRec.Next() = 0;
    end;



}
