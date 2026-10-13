Page 50211 "Defaulter Loan Recovery Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Defaulter Loan Recovery";
    PromotedActionCategories = 'New,Process,Report,Validate Amounts,Request Approval,Post';

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
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Type"; Rec."Recovery Type")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    ValuesAllowed = " ", "Single Loan", "All Loans";
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        UpdateControls;
                    end;
                }
                group(Single)
                {
                    Visible = Rec."Recovery Type" = Rec."Recovery Type"::"Single Loan";
                    field("Loan No."; Rec."Loan No.")
                    {
                        ApplicationArea = Basic;
                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            if Rec."Loan No." <> '' then
                                Rec."Recovery Option" := Rec."Recovery Option"::"Recover from Single Account"
                            else
                                Rec."Recovery Option" := Rec."Recovery Option"::"Recover from Multiple Accounts";
                        end;
                    }
                    field("Source Account"; Rec."Source Account")
                    {
                        ApplicationArea = Basic;
                        LookupPageId = "Member Accounts List";
                        //Editable = FieldEditable;
                    }
                }
                field("Recovery Option"; Rec."Recovery Option")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    Editable = False;
                }
                field("Amount to Recover"; Rec."Amount to Recover")
                {
                    // visible = false;
                    ApplicationArea = Basic;
                }

                field("Recovery Source"; Rec."Recovery Source")
                {
                    ApplicationArea = Basic;
                    ValuesAllowed = " ", "Defaulter Withdrawable Savings", "Guarantor Withdrawable Savings", "Issue Guarantor Defaulter Loan", "Recovery From All", "Recover & Issue Guarantor Defaulter Loan";

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(DateEntered; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field(EnteredBy; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                }
                field(Recovered; Rec.Recovered)
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        UpdateControls;
                    end;
                }
                field("Total Available"; Rec."Total Available")
                {
                    ApplicationArea = Basic;
                }
                field("Free Shares"; Rec."Free Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Self Guaranteed"; Rec."Self Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Principal"; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Penalty"; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Insurance"; Rec."Outstanding Insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Principal Arrears"; Rec."Principal Arrears")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Interest Arrears"; Rec."Interest Arrears")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Arrears; Rec.Arrears)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Dividend Balance"; Rec."Dividend Balance")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Total Deduction"; Rec."Total Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Fee"; Rec."Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Balance"; Rec."Deposit Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Net Refund"; Rec."Net Refund")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control16; "Loans Offset List")
            {
                editable = false;
                ApplicationArea = Basic;
                SubPageLink = "Header No." = field("No."), "Member No" = field("Member No.");
            }
            part(Control15; "Defaulter Recovery Lines")
            {
                ApplicationArea = Basic;
                SubPageLink = "Header No." = field("No.");
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Defaulter Loan Recovery"),
                              "No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(ValidateAmounts)
            {
                ApplicationArea = Basic;
                Caption = 'Validate Amounts';
                Image = ValueLedger;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    AppraisalLine: Record "Offset Appraisal";
                    SActivities: Codeunit "Sacco Activities";
                    myInt: Integer;
                    j: Integer;
                    PSetup: Record "Product Setup";
                    MemberAccounts: Record "Savings Accounts";
                    AvailDep: Decimal;
                    Offset: Record "Loans Offet List";
                    LoanRecLines: Record "Loans Offet List";
                    RunBal: Decimal;
                    DedAmt: Decimal;
                    PrAmt: Decimal;
                    IntAmt: Decimal;
                    TotalGuaranteed: Decimal;
                    Header: Record "Defaulter Loan Recovery";
                begin

                    AppraisalLine.Reset();
                    AppraisalLine.SetRange("Offset No.", Rec."No.");
                    if AppraisalLine.FindFirst() then begin
                        AppraisalLine.DeleteAll();
                    end;

                    SaccoActivities.CalculateLoanOffset(Rec, false);

                    Commit();

                    Message('Updated');

                end;
            }

            action(OffsetReport)
            {
                ApplicationArea = Basic;
                Caption = 'Offset Report';
                Image = ItemGroup;
                Promoted = true;
                Visible = false;

                PromotedCategory = Process;
                trigger OnAction()
                var
                    AppraisalLine: Record "Offset Appraisal";
                    myInt: Integer;
                    j: Integer;
                    PSetup: Record "Product Setup";
                    MemberAccounts: Record "Savings Accounts";
                    AvailDep: Decimal;
                    Offset: Record "Loans Offet List";
                    LoanRecLines: Record "Loans Offet List";
                    RunBal: Decimal;
                    DedAmt: Decimal;
                    PrAmt: Decimal;
                    IntAmt: Decimal;
                    TotalGuaranteed: Decimal;
                    SActivities: Codeunit "Sacco Activities";
                    Header: Record "Defaulter Loan Recovery";
                    LoanOffsetCalculator: Report "Loan Offset Calculator";
                begin
                    //TestField(Stage, Stage::Booking);Rec.                  

                    Header.Reset();
                    Header.SetRange("No.", Rec."No.");
                    if Header.FindFirst() then
                        report.run(Report::"Loan Offset Calculator", true, false, Header);
                end;
            }

            action(Post)
            {
                ApplicationArea = Basic;
                Image = ItemGroup;
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                var
                    AppraisalLine: Record "Offset Appraisal";
                    myInt: Integer;
                    j: Integer;
                    PSetup: Record "Product Setup";
                    MemberAccounts: Record "Savings Accounts";
                    AvailDep: Decimal;
                    Offset: Record "Loans Offet List";
                    LoanRecLines: Record "Loans Offet List";
                    RunBal: Decimal;
                    DedAmt: Decimal;
                    PrAmt: Decimal;
                    IntAmt: Decimal;
                    TotalGuaranteed: Decimal;
                    SActivities: Codeunit "Sacco Activities";
                begin

                    Rec.TestField(Recovered, false);
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Confirm('Are you sure you want to Post this Offset?') then begin
                        SaccoActivities.CalculateLoanOffset(Rec, true);
                        Rec.Get(Rec."No.");
                        SendGuarantorAllocationEmails(Rec);
                        UpdateControls();
                        CurrPage.Update(false);
                    end;
                end;
            }

        }
        area(processing)
        {
            group("Request Approval")
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
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        CheckControls;
                        //SaccoActivities.CalculateLoanOffset(rec, false);
                        //Commit();

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Def. Recovery", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
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
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
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
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Def. Recovery";

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
                        ApprovalTracker.SetRange("Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin

                        if Rec.Status = Rec.Status::Pending then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }

    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls();
    end;

    trigger OnOpenPage()
    begin
        UpdateControls();
    end;

    var
        SingleAccountBool: Boolean;
        SingleLoanBool: Boolean;
        MultiAccountBool: Boolean;
        LoanSecurity: Record "Loan Security";
        SaccoActivities: Codeunit "Sacco Activities";
        LLedger: Record "Credit Ledger Entry";
        RecoveryLines: Record "Defaulter Recovery Lines";
        SLedger: Record "Savings Ledger Entry";
        Loans: Record Loans;
        FieldEditable: Boolean;
        EditRecoveryOpt: Boolean;

    local procedure UpdateControls()
    begin

        //if ("Recovery Type" = "Recovery Type"::"Single Loan") or ("Recovery Type" = "Recovery Type"::Arrears) then begin
        //Rec."Recovery Option" := Rec."Recovery Option"::"Recover from Single Account";
        if Rec."Recovery Source" = Rec."Recovery Source"::" " then
            Rec."Recovery Source" := Rec."Recovery Source"::"Defaulter Non-Withdrawable Deposits";
        FieldEditable := true;
        /* end else begin
            "Recovery Option" := "Recovery Option"::"Recover from Multiple Accounts";
            "Source Account" := '';
            "Loan No." := '';
            FieldEditable := false;
            "Amount to Recover" := 0;
        end;Rec.*/

        if (Rec.Status = Rec.Status::Open) and (not Rec.Recovered) then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;

    end;

    local procedure CheckControls()
    begin

        //TestField(Stage, Stage::Verification);
        if Rec."Recovery Type" = Rec."Recovery Type"::"Single Loan" then
            Rec.TestField("Amount to Recover");
    end;

    local procedure SendGuarantorAllocationEmails(RecoveryHeader: Record "Defaulter Loan Recovery")
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        GuarantorMember: Record Members;
        InStr: InStream;
        NoticeBlob: Codeunit "Temp Blob";
        NoticeOutStr: OutStream;
        NoticeRecRef: RecordRef;
        NoticeRecoveryLine: Record "Defaulter Recovery Lines";
        RecoveryLine: Record "Defaulter Recovery Lines";
        ToRecipients: List of [Text];
        CCRecipients: List of [Text];
        BCCRecipients: List of [Text];
        BodyMsg: Text;
        FileName: Text;
        RecipientEmail: Text;
        SentCount: Integer;
        SkippedCount: Integer;
        SubjectTxt: Label 'Loan Update - Guarantor Allocation %1';
    begin
        RecoveryLine.Reset();
        RecoveryLine.SetRange("Header No.", RecoveryHeader."No.");
        if not RecoveryLine.FindSet() then
            exit;

        repeat
            Clear(RecipientEmail);
            if GuarantorMember.Get(RecoveryLine."Guarantor Member No.") then
                RecipientEmail := GuarantorMember."E-Mail";

            if not SaccoActivities.ValidEmailAddress(RecipientEmail) then begin
                SkippedCount += 1;
            end else begin
                NoticeRecoveryLine.Reset();
                NoticeRecoveryLine.SetRange("Header No.", RecoveryLine."Header No.");
                NoticeRecoveryLine.SetRange("Loan No.", RecoveryLine."Loan No.");
                NoticeRecoveryLine.SetRange("Guarantor Savings Account", RecoveryLine."Guarantor Savings Account");
                NoticeRecoveryLine.SetRange("Guarantor Member No.", RecoveryLine."Guarantor Member No.");

                Clear(EmailMessage);
                Clear(NoticeBlob);
                Clear(NoticeRecRef);
                NoticeBlob.CreateOutStream(NoticeOutStr);
                NoticeRecRef.GetTable(NoticeRecoveryLine);
                if Report.SaveAs(Report::"Guarantor Allocation Notice", '', ReportFormat::Pdf, NoticeOutStr, NoticeRecRef) then begin
                    BodyMsg := 'Dear ' + RecoveryLine."Guarantor Name" + ',';
                    BodyMsg += '<br><br>';
                    BodyMsg += 'Please find attached your loan update guarantor allocation notice.';
                    BodyMsg += '<br><br>';
                    BodyMsg += 'Defaulter: <b>' + RecoveryHeader.Name + '</b><br>';
                    BodyMsg += 'Loan No.: <b>' + RecoveryLine."Loan No." + '</b><br>';
                    BodyMsg += 'Amount to Recover / Allocate: <b>KES ' + Format(RecoveryLine."Amount to Recover") + '</b>';
                    BodyMsg += '<br><br>';
                    BodyMsg += 'Kind Regards,<br>';
                    BodyMsg += CompanyProperty.DisplayName();
                    BodyMsg += '<br><br><HR>';
                    BodyMsg += 'This is a system generated email. Please do not reply.';

                    Clear(ToRecipients);
                    Clear(CCRecipients);
                    Clear(BCCRecipients);
                    ToRecipients.Add(RecipientEmail);

                    EmailMessage.Create(
                        ToRecipients,
                        StrSubstNo(SubjectTxt, RecoveryLine."Loan No."),
                        BodyMsg,
                        true,
                        CCRecipients,
                        BCCRecipients);

                    FileName := StrSubstNo('Guarantor-Allocation-%1-%2.pdf', RecoveryLine."Guarantor Member No.", RecoveryLine."Loan No.");
                    NoticeBlob.CreateInStream(InStr);
                    EmailMessage.AddAttachment(FileName, 'application/pdf', InStr);

                    if Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
                        SentCount += 1
                    else
                        SkippedCount += 1;
                end else
                    SkippedCount += 1;
            end;
        until RecoveryLine.Next() = 0;

        Message('%1 guarantor allocation notice(s) emailed. %2 skipped.', SentCount, SkippedCount);
    end;

    var
        SActivities: Codeunit "Sacco Activities";
        Legacy: Codeunit Legacy;
        MActivities: Codeunit "Member Activities";
        JTemplate: Code[20];
        JBatch: Code[20];
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        Security: Record "Loan Security";

}
