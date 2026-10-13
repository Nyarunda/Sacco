page 50437 "Sacco Journal Card"
{
    Caption = 'Sacco Journal Card';
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "Sacco Journal Header";
    PromotedActionCategories = 'New,Process,Report,Import Journal,Approval Request';

    layout
    {

        area(content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Captured By field.';
                }
                field("Posting Type"; Rec."Posting Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Type field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Type field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Preview Done"; Rec."Preview Done")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Time"; Rec."Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.';
                }
            }

            part(SaccoJnlLine; "Posted Custom Journal Lines")
            {
                ApplicationArea = all;
                Visible = ShowPosted;
                SubPageLink = "Batch No." = field("Document No.");
            }

            part(SaccoJnlLine2; "Custom Journal Lines")
            {
                Visible = ShowUnPosted;
                ApplicationArea = all;
                SubPageLink = "Journal Batch Name" = field("Document No."), "Journal Template Name" = field("Custom Journal Template");
            }

        }

    }


    actions
    {
        area(Reporting)
        {


            action("Generate Loan Refunds")
            {
                ApplicationArea = Basic;
                Image = Link;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                trigger OnAction()
                var
                    SActivities: Codeunit "Sacco Activities";
                begin

                    if Confirm('Are you sure you want to generate Loan Refunds?') then begin
                        SActivities.RefundLoanOverpayements(Rec);
                    end;
                end;
            }
        }
        area(processing)
        {


            action("Attachment")
            {
                ApplicationArea = Basic;
                Image = Link;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    DMSint: Record "DMS Endpoints";
                begin

                    DMSint.RESET;
                    DMSint.SETRANGE(DMSint."Link Type", DMSint."Link Type"::jv);
                    IF DMSint.FIND('-') THEN BEGIN
                        HYPERLINK(DMSint."Path" + Rec."Document No.");
                    END;
                end;
            }

            action("Import Journal")
            {
                ApplicationArea = Basic;
                Caption = 'Import Journal';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin


                    Message('Ensure the document is as follows: ' +
                    '\1. Line No.\' +
                    '\2. Posting Date\' +
                    '\3. Document No.\' +
                    '\4. Account Type\' +
                    '\5. Account No.\' +
                    '\6. Description\' +
                    '\7. Debit Amount\' +
                    '\8. Credit Amount\' +
                    '\9. Transaction Type\' +
                    '\10. Loan No.\' +
                    '\11. External Document No.\' +
                    '\12. Activity Code\' +
                    '\13. Branch Code\' +
                    '\14. Batch No.\' +
                    '\\\[Document Format should be Excel and Should include the Headers]');


                    if Confirm('Are you sure you want to Import Journal?') then begin
                        Rec.ImportJournalLinesFromExcel();
                    end;
                end;
            }

            action(Preview)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Preview Posting';
                Image = ViewPostedOrder;
                ShortCutKey = 'Ctrl+Alt+F9';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                trigger OnAction()
                var
                    GenJnlPost: Codeunit Microsoft.Finance.GeneralLedger.Posting."Gen. Jnl.-Post";
                    Lines: Record "Gen. Journal Line";
                begin

                    Lines.Reset();
                    Lines.SetCurrentKey("Line No.");
                    Lines.SetRange("Journal Template Name", Rec."Custom Journal Template");
                    Lines.Setrange("Journal Batch Name", Rec."Document No.");
                    if Lines.findset() then begin
                        GenJnlPost.Preview(Lines);

                        Rec."Preview Done" := true;
                        Rec.Modify();
                        Commit();
                    end;
                end;
            }

            action("Post Entries")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Lines: Record "Gen. Journal Line";
                    GenJnlPost: Codeunit Microsoft.Finance.GeneralLedger.Posting."Gen. Jnl.-Post";
                begin
                    //if not "Preview Done" then
                    //    Error('You must preview this document before you POST!');
                    Rec.TestField(Posted, false);
                    Rec.TestField(Status, Rec.Status::Approved);
                    CheckBalance();

                    if Confirm('Are you sure you want to post these entries') then begin
                        SaccoActivities.PostNewSaccoJournal(Rec."Document No.");
                    end;
                end;
            }

            action("JV Report")
            {
                ApplicationArea = Basic;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SaccoLines: Record "Sacco Journal Line";
                begin

                    SaccoLines.Reset();
                    SaccoLines.SetRange("Batch No.", Rec."Document No.");
                    if SaccoLines.FindFirst() then
                        Report.Run(Report::"Sacco Journal Report", true, false, SaccoLines);
                end;
            }

            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        DocumentType: Enum "Custom Document Type";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: variant;
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        SaccoActivities.CheckSaccoJournalForApproval(Rec."Custom Journal Template", Rec."Document No.");
                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Document No.", 0, Documenttype::"Journal Vouchers", '', '', 0);
                        CurrPage.close()
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: variant;
                        DocumentType: Enum "Custom Document Type"; //Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Member Application","Loan Application";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        CheckBalance();

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."Document No.");
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page System.Automation."Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocType: Enum "Approval Document Type";
                        ApprovalTracker: Record "Approval Tracker";
                        VarVariant: variant;
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocType := Doctype::"Loan Application";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."Document No.");
                        ApprovalTracker.SetRange("Document Type", DocType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        if (Rec.Status <> Rec.Status::Open) and (Rec.Status <> Rec.Status::Pending) then begin

                            if not Confirm('Are you sure you want to re-open document?') then exit;
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }


    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        // "Posting Type" := "Posting Type"::"User Header Document No.";
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;

        if Rec.posted then
            ShowPosted := true
        else
            ShowPosted := false;

        if Rec.posted then
            ShowUnPosted := false
        else
            ShowUnPosted := true;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        // "Posting Type" := "Posting Type"::"User Header Document No.";
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;

        if Rec.posted then
            ShowPosted := true
        else
            ShowPosted := false;

        if Rec.posted then
            ShowUnPosted := false
        else
            ShowUnPosted := true;
    end;

    local procedure CheckBalance()
    begin
        SaccoActivities.CheckSaccoJournalControls(Rec."Custom Journal Template", Rec."Document No.");
    end;

    local procedure CheckPostedDocumentNo()
    var
        myInt: Integer;
        JnlLine: Record "Sacco Journal Line";
        Lines: Record "Gen. Journal Line";
    begin
        Lines.Reset();
        Lines.SetRange("Journal Template Name", Rec."Custom Journal Template");
        Lines.Setrange("Journal Batch Name", Rec."Document No.");
        if Lines.FindSet() then
            repeat
                JnlLine.Reset();
                JnlLine.SetRange("Document No.", Lines."Document No.");
                if JnlLine.FindFirst() then
                    repeat
                        Error('Document No. %1 has been posted. Kindly use a different one.', Lines."Document No.");
                    until JnlLine.Next() = 0;
            until Lines.Next() = 0;

    end;

    var
        Members: Record Members;
        SaccoActivities: Codeunit "Sacco Activities";
        ShowPosted: Boolean;
        ShowUnPosted: Boolean;
}
