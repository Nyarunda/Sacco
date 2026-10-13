codeunit 50113 "Calwide Event Subscriptions"
{
    Permissions = TableData "Approval Entry" = rim;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnBeforeGetConditionalCardPageID', '', false, false)]
    local procedure OnBeforeGetConditionalCardPageID(RecRef: RecordRef; var CardPageID: Integer; var IsHandled: Boolean);
    var
        MemberReg: Record "Member registration";
    begin

        case RecRef.Number of
            DATABASE::"Member Registration":
                Begin

                    RecRef.SetTable(MemberReg);
                    case MemberReg."Type" of
                        MemberReg."Type"::Member:
                            begin

                                CardPageID := Page::"Member Registration Card";
                                IsHandled := true;

                                if MemberReg."Account Category" = MemberReg."Account Category"::Joint then begin
                                    CardPageID := Page::"Joint Account Reg. Card";
                                    IsHandled := true;
                                end;
                            end;
                        MemberReg."Type"::group:
                            begin
                                if MemberReg."Group Section" = MemberReg."Group Section"::"Other Groups" then begin

                                    if MemberReg."Account Category" = MemberReg."Account Category"::Business then begin
                                        CardPageID := Page::"Business Registration Card";
                                        IsHandled := true;
                                    end
                                    else begin

                                        CardPageID := Page::"Group Registration Card";
                                        IsHandled := true;
                                    end;
                                end;
                                if MemberReg."Group Section" = MemberReg."Group Section"::"Micro Group" then begin
                                    CardPageID := Page::"Group Reg. Card - Micro";
                                    IsHandled := true;
                                end;
                            end;
                    end;
                end;

        /*DATABASE::"Gen. Journal Line":
            begin
                CardPageID := Page::"Sacco General Journal";
                IsHandled := true;
            end;

            */
        end;
    End;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    local procedure OnApproveApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    begin
        ApprovalEntry."Approved By" := UserId;
        ApprovalEntry.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    begin
        ApprovalEntry."Rejected By" := UserId;
        ApprovalEntry.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnBeforeMarkAllWhereUserisApproverOrSender', '', false, false)]

    local procedure OnBeforeMarkAllWhereUserisApproverOrSender(var ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    var
        CustomApprover: TextBuilder;
        WUserGroup: Record "Workflow User Group";
        WUserGroupMember: Record "Workflow User Group Member";
        FilterText: Text;
    begin


        CustomApprover.Append(UserId);
        WUserGroupMember.Reset();
        WUserGroupMember.SetRange("User Name", UserId);
        if WUserGroupMember.FindSet() then
            repeat
                CustomApprover.Append('|' + WUserGroupMember."Workflow User Group Code");
            until WUserGroupMember.Next() = 0;



        ApprovalEntry.FilterGroup := -1; // Used to support the cross-column search
        FilterText := CustomApprover.ToText();
        ApprovalEntry.SetFilter("Approver ID", FilterText);
        ApprovalEntry.SetFilter("Sender ID", FilterText);
        if ApprovalEntry.FindSet() then
            repeat
                ApprovalEntry.Mark(true);
            until ApprovalEntry.Next() = 0;

        ApprovalEntry.MarkedOnly(true);
        ApprovalEntry.FilterGroup(0);
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeGetNoSeriesCode', '', false, false)]

    local procedure OnBeforeGetNoSeriesCode(PurchSetup: Record "Purchases & Payables Setup"; var NoSeriesCode: Code[20]; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header")
    var
        Sales: Record "Sales & Receivables Setup";
    begin

        NoSeriesCode := '';
        Sales.get();
        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::"Purchase Requisition":
                NoSeriesCode := Sales."Purchase Requisition Nos";
        end;
        if NoSeriesCode <> '' then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeCheckUserAsApprovalAdministrator', '', false, false)]
    local procedure OnBeforeCheckUserAsApprovalAdministrator(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    var
        UserGroupMember: Record "Workflow User Group Member";

    begin


        IsHandled := false;

        UserGroupMember.RESET;
        UserGroupMember.SETRANGE("Workflow User Group Code", ApprovalEntry."Approver ID");
        UserGroupMember.SETRANGE("User Name", USERID);
        IF UserGroupMember.FINDFIRST THEN BEGIN
            IsHandled := true;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterRejectSelectedApprovalRequest', '', false, false)]
    local procedure OnAfterRejectSelectedApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        CalwideAppMgt: Codeunit "Calwide Approval Management";
        RecRef: RecordRef;
        RejectionComment: Text;
    begin
        RecRef.Get(ApprovalEntry."Record ID to Approve");

        if IsLoanApprovalDocument(ApprovalEntry."Custom Document Type") then begin
            RejectionComment := GetLatestApprovalComment(ApprovalEntry, RecRef.Number);
            if RejectionComment = '' then
                Error('Comment is mandatory when rejecting loan documents.');
        end;

        if not confirm('Are you sure you want to REJECT this document?') then
            Error('Aborted');

        CalwideAppMgt.RejectApprovalRequest(ApprovalEntry);

        if IsLoanApprovalDocument(ApprovalEntry."Custom Document Type") then
            SaveLoanRejectionComment(ApprovalEntry, RejectionComment);
    end;

    local procedure IsLoanApprovalDocument(DocType: Enum "Custom Document Type"): Boolean
    begin
        case DocType of
            DocType::"Loan Application",
            DocType::"Loan Batch",
            DocType::"Loan Changes",
            DocType::"Partial Loans",
            DocType::"Loan Appraisal":
                exit(true);
        end;

        exit(false);
    end;

    local procedure GetLatestApprovalComment(ApprovalEntry: Record "Approval Entry"; TableId: Integer): Text
    var
        ApprovalComment: Record "Approval Comment Line";
    begin
        ApprovalComment.Reset();
        //ApprovalComment.SetRange("Table ID", TableId);
        //ApprovalComment.SetRange("Document No.", ApprovalEntry."Document No.");
        ApprovalComment.SetRange("Record ID to Approve", ApprovalEntry."Record ID to Approve");
        ApprovalComment.SetFilter(Comment, '<>%1', '');

        if ApprovalComment.FindLast() then
            exit(ApprovalComment.Comment);

        exit('');
    end;

    local procedure SaveLoanRejectionComment(ApprovalEntry: Record "Approval Entry"; CommentText: Text)
    var
        LoanRec: Record Loans;
        SalaryAppraisal: Record "Member Salary Appraisal";
    begin
        // Standard loan approvals store Loan No. in Document No.
        if LoanRec.Get(ApprovalEntry."Document No.") then begin
            LoanRec."Loan Rejection Reason" := CopyStr(CommentText, 1, MaxStrLen(LoanRec."Loan Rejection Reason"));
            LoanRec.Modify(true);
            exit;
        end;

        // Loan Appraisal approvals use Appraisal No.; map to Loans via Salary Appraisal No.
        if ApprovalEntry."Custom Document Type" = ApprovalEntry."Custom Document Type"::"Loan Appraisal" then
            if SalaryAppraisal.Get(ApprovalEntry."Document No.") then begin

                LoanRec.Reset();
                LoanRec.SetRange("Salary Appraisal No.", SalaryAppraisal."Appraisal No.");
                LoanRec.SetRange("Member No.", SalaryAppraisal."Member No.");
                if LoanRec.FindLast() then begin
                    LoanRec."Loan Rejection Reason" := CopyStr(CommentText, 1, MaxStrLen(LoanRec."Loan Rejection Reason"));
                    LoanRec.Modify(true);
                end;

                SalaryAppraisal."Loan Rejection Reason" := CopyStr(CommentText, 1, MaxStrLen(LoanRec."Loan Rejection Reason"));
                SalaryAppraisal.Modify();
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApproveSelectedApprovalRequest', '', false, false)]
    local procedure OnBeforeApproveSelectedApprovalRequest(var ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    var
        CalwideAppMgt: Codeunit "Calwide Approval Management";
        ApprovalComment: Record "Approval Comment Line";
        RecRef: RecordRef;
        Confirm: Dialog;
    begin
        RecRef.Get(ApprovalEntry."Record ID to Approve");

        /* ApprovalComment.Reset();
         ApprovalComment.SetRange("Table ID", RecRef.Number);
         ApprovalComment.SetRange("Record ID to Approve", ApprovalEntry."Record ID to Approve");
         if not ApprovalComment.FindFirst() then
             Error('To approve this record, first write comment on the comment section');
             */

        if not confirm('Are you sure you want to approve this record ?') then
            Error('Aborted');

        CalwideAppMgt.ApproveApprovalRequest(ApprovalEntry);

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCode', '', false, false)]

    local procedure OnBeforeCode(var GenJnlLine: Record "Gen. Journal Line"; CheckLine: Boolean; var IsPosted: Boolean; var GLReg: Record "G/L Register")
    var
        AccountingPeriod: Record "Accounting Period";
        PSalesLine: Record "Sales Invoice Line";
        PLines: Record "Purch. Inv. Line";
        UserSetup: Record "User Setup";
    begin
        AccountingPeriod.Reset();
        AccountingPeriod.SetRange("Starting Date", CalcDate('-CM', GenJnlLine."Posting Date"), CalcDate('CM', GenJnlLine."Posting Date"));
        if AccountingPeriod.FindFirst() then begin
            if AccountingPeriod."Close Posting Period" then begin
                Error('Posting Period %1 Closed By %2', AccountingPeriod.Name, AccountingPeriod."Posting Period Closed By");
            end;
        end;

        if GenJnlLine."Posting Date" > Today then
            Error('Future Dates are not acceptable when posting transactions: %1', GenJnlLine."Posting Date");

        if GenJnlLine."Dimension Set ID" = 0 then begin
            UserSetup.Get(UserId);
            GenJnlLine."Dimension Set ID" := UserSetup."Dimension Set ID";
            // GenJnlLine.TestField("Dimension Set ID");
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", 'OnReverseEntriesOnAfterInsertReversalEntry', '', false, false)]
    local procedure OnReverseEntriesOnAfterInsertReversalEntry(var TempReversalEntry: Record "Reversal Entry" temporary; Number: Integer; RevType: Option Transaction,Register)
    var
        AutoReversalEntry: Record "Auto Reversal Entry";
        i: Integer;
    begin
        if TempReversalEntry.FindSet() then begin

            AutoReversalEntry.Reset();
            if AutoReversalEntry.FindLast() then i := AutoReversalEntry."Line No.";
            repeat
                i += 1;
                AutoReversalEntry.Init();
                AutoReversalEntry.TransferFields(TempReversalEntry);
                AutoReversalEntry."Line No." := i;
            //AutoReversalEntry.Insert();

            until TempReversalEntry.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reversal-Post", 'OnRunOnBeforeDeleteAll', '', false, false)]
    local procedure OnRunOnBeforeDeleteAll(var ReversalEntry: Record "Reversal Entry"; Number: Integer)
    var
        //ReversalEntry: Record "Reversal Entry";
        AutoReversalEntry: Record "Auto Reversal Entry";
    begin
        if ReversalEntry.FindSet() then
            repeat

            /* 
            AutoReversalEntry.Init();
             AutoReversalEntry.TransferFields(ReversalEntry, true);
             AutoReversalEntry.Insert(true);
             */

            until ReversalEntry.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Fixed Asset", 'OnBeforeValidateFAPostingGroup', '', false, false)]
    local procedure OnBeforeValidateFAPostingGroup(var FixedAsset: Record "Fixed Asset"; var xFixedAsset: Record "Fixed Asset"; var IsHandled: Boolean)
    Var
        FASubCalss: Record "FA Subclass";
        FABooK: Record "FA Depreciation Book";
    begin
        if FASubCalss.Get(FixedAsset."FA Subclass Code") then begin

            FABooK.Reset();
            FABooK.SetRange("FA No.", FixedAsset."No.");
            if FABooK.FindFirst() then begin
                FABooK."Depreciation Method" := FABooK."Depreciation Method"::"Declining-Balance 1";
                FABooK."Declining-Balance %" := FASubCalss."Depreciation Rate";
                FABooK.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Fixed Asset List", 'OnOpenPageEvent', '', true, true)]
    local procedure OnPageOpenHandler()
    var
        RecFixedAsset: Record "Fixed Asset";
    begin
        RecFixedAsset.SetRange(Inactive, false); // Assuming "Blocked" = true marks inactive assets
    end;


    /*[EventSubscriber(ObjectType::Page, Page::"G/L Account Card", 'OnBeforeEdit', '', true, true)]
    local procedure OnBeforeEditGLAccountPage(var Record: Record "G/L Account")
    var
        UserSetup: Record "User Setup";
    begin
        // Get current user's ID
        UserSetup.Get('User ID', UserId);
        if not UserSetup."Edit Chart of Accounts" then
        begin
            Error('You do not have permission to edit G/L Accounts.');
            //Record.// Cancel the editing action
        end;
    end; */
    //Subtype = Integration;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Document Attachment Mgmt", OnAfterGetRefTable, '', false, false)]
    local procedure OnAfterGetRefTable(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        MemberAccountApplication: Record "Member Accounts Application";
        MemberRegistration: Record "Member Registration";
        CollateralReg: Record "Loan Collateral Register";
        Loans: Record Loans;
        MemberExit: Record "Member Exit Notice";
        LoanApplication: Record "Member Salary Appraisal";
        DefaulterLoanRecovery: Record "Defaulter Loan Recovery";
        PartialLoansDisbHeader: Record "Partial Loans Disb. Header";
    begin
        case DocumentAttachment."Table ID" of
            Database::"Member Accounts Application":
                begin
                    RecRef.Open(Database::"Member Accounts Application");
                    if MemberAccountApplication.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(MemberAccountApplication);
                end;

            Database::"Member Registration":
                begin
                    RecRef.Open(Database::"Member Registration");
                    if MemberRegistration.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(MemberRegistration);
                end;
            Database::"Loan Collateral Register":
                begin
                    RecRef.Open(Database::"Loan Collateral Register");
                    if CollateralReg.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(CollateralReg);
                end;
            Database::Loans:
                begin
                    RecRef.Open(Database::Loans);
                    if Loans.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(Loans);
                end;

            Database::"Member Exit Notice":
                begin
                    RecRef.Open(Database::"Member Exit Notice");
                    if MemberExit.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(MemberExit);
                end;
            Database::"Member Salary Appraisal":
                begin
                    RecRef.Open(Database::"Member Salary Appraisal");
                    if LoanApplication.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(LoanApplication);
                end;
            Database::"Defaulter Loan Recovery":
                begin
                    RecRef.Open(Database::"Defaulter Loan Recovery");
                    if DefaulterLoanRecovery.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(DefaulterLoanRecovery);
                end;
            Database::"Partial Loans Disb. Header":
                begin
                    RecRef.Open(Database::"Partial Loans Disb. Header");
                    if PartialLoansDisbHeader.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(PartialLoansDisbHeader);
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin

        case RecRef.Number of
            Database::"Member Accounts Application":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;

                    DocumentAttachment.Validate("Table ID", Database::"Member Accounts Application");
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachment.Validate("Document Type", DocumentAttachment."Document Type"::Savings);
                end;
            Database::"Member Registration":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;

                    DocumentAttachment.Validate("Table ID", Database::"Member Registration");
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachment.Validate("Document Type", DocumentAttachment."Document Type"::Member);
                end;

            Database::"Loan Collateral Register":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;

                    DocumentAttachment.Validate("Table ID", Database::"Loan Collateral Register");
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachment.Validate("Document Type", DocumentAttachment."Document Type"::Collateral);
                end;

            Database::"Member Exit Notice":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;

                    DocumentAttachment.Validate("Table ID", Database::"Member Exit Notice");
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachment.Validate("Document Type", DocumentAttachment."Document Type"::"Member Exit");
                end;
            Database::"Member Salary Appraisal":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;

                    DocumentAttachment.Validate("Table ID", Database::"Member Salary Appraisal");
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachment.Validate("Document Type", DocumentAttachment."Document Type"::Loan);
                end;
            Database::"Defaulter Loan Recovery":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;

                    DocumentAttachment.Validate("Table ID", Database::"Defaulter Loan Recovery");
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachment.Validate("Document Type", DocumentAttachment."Document Type"::Loan);
                end;
            Database::"Partial Loans Disb. Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;

                    DocumentAttachment.Validate("Table ID", Database::"Partial Loans Disb. Header");
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachment.Validate("Document Type", DocumentAttachment."Document Type"::Loan);
                end;

        end;


    end;


}
