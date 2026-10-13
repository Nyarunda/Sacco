page 50275 "Fixed Deposit Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Fixed Deposit Accounts";
    PromotedActionCategories = 'New,Process,Report,Approval Requests';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = gedit;

                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(SavingsAccount; Rec."Savings Account")
                {
                    ApplicationArea = Basic;
                }
                field(FixedAccountNo; Rec."Fixed Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(FDType; Rec."FD Type")
                {
                    ApplicationArea = Basic;
                }
                field(FDDuration; Rec."FD Duration")
                {
                    ApplicationArea = Basic;
                }
                field(FDStartDate; Rec."FD Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(FDMaturityDate; Rec."FD Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApprovalStatus; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(FDAmount; Rec."FD Amount")
                {
                    ApplicationArea = Basic;
                }
                field(NegotiatedInterest; Rec."Negotiated Interest %")
                {
                    ApplicationArea = Basic;
                }
                field(FDAnnualInterest; Rec."FD Annual Interest %")
                {
                    ApplicationArea = Basic;
                }
                field(FDStatus; Rec."FD Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = FDStatusHighlight;
                }
                field(SavingsAccountBalance; Rec."Savings Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field(FixedAccountBalance; Rec."Fixed Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field(FDMaturityInstructions; Rec."FD Maturity Instructions")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                    ToolTip = 'Current approved maturity instruction. To change, use Request Instruction Change action.';
                }
                field(MonthlyInterest; Rec."Monthly Interest")
                {
                    ApplicationArea = Basic;
                }
                field(TotalExpectedInterest; Rec."Total Expected Interest")
                {
                    ApplicationArea = Basic;
                }
                field(AccruedInterest; Rec."Accrued Interest")
                {
                    ApplicationArea = Basic;
                }
                field(UntransferedInterest; Rec."Untransfered Interest")
                {
                    ApplicationArea = Basic;
                }
                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }


            group(InstructionRevision)
            {
                Caption = 'Maturity Instruction Revision';
                Visible = RevisionVisible;

                field(CurrentMaturityInstruction; Rec."FD Maturity Instructions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Instruction';
                    Editable = false;
                    ToolTip = 'The currently active maturity instruction.';
                }
                field(RevisedMaturityInstruction; Rec."Revised Maturity Instructions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Proposed Instruction';
                    // Editable only while the member is capturing — locked once submitted
                    Editable = RevisionEditable;
                    ToolTip = 'The new maturity instruction proposed by the member. Requires approval before it takes effect.';
                }
            }


            group(MaturityPayeeDetails)
            {
                Caption = 'Maturity Payee Details';

                field("Payee Bank Code"; Rec."Payee Bank Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Code';
                    Editable = gedit;
                    TableRelation = "Bank Account"."No.";
                    ToolTip = 'Bank account number of the payee bank where maturity proceeds will be sent.';
                }

                field(PayeeBankName; Rec."Payee Bank Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Name';
                    Editable = False;
                    ToolTip = 'Name of the bank where maturity proceeds will be sent.';
                }
                field("Payee Branch"; Rec."Payee Branch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch Code';
                    Editable = gedit;
                    TableRelation = "Bank Branches"."Branch Code" where("Bank Code" = field("Payee Bank Code"));
                    ToolTip = 'Branch code of the bank where maturity proceeds will be sent.';
                }
                field("Payee Branch Name"; Rec."Payee Branch Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch Name';
                    Editable = False;
                    ToolTip = 'Branch name of the bank where maturity proceeds will be sent.';
                }
                field(PayeeAccountName; Rec."Payee Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Payee Name';
                    Editable = gedit;
                    ToolTip = 'Name of the account holder to be credited on maturity.';
                }
                field(PayeeAccountNo; Rec."Payee Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Number';
                    Editable = gedit;
                    ToolTip = 'Bank account number to be credited on maturity.';
                }

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Process)
            {
                action("Activate FDR")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        Rec."FD Status" := Rec."FD Status"::Active;
                        Rec.Modify();
                        Message('Activated');
                    end;
                }
                action("Process Fixed Deposit")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        Rec.CalcFields("Fixed Account Balance");
                        Rec.TestField("FD Start Date");
                        Rec.TestField("Savings Account");
                        Rec.TestField("Fixed Account No.");
                        Rec.TestField("FD Amount");
                        Rec.TestField("FD Duration");
                        Rec.TestField("FD Maturity Date");
                        if Rec."FD Maturity Instructions" = Rec."fd maturity instructions"::" " then
                            Error('Enter FD maturity Instruction');
                        Rec.TestField("Approval Status", Rec."approval status"::Approved);
                        Rec.TestField("FD Status", Rec."fd status"::Active);

                        FixedDepositAccounts.Reset();
                        FixedDepositAccounts.SetRange("No.", Rec."No.");
                        if FixedDepositAccounts.FindFirst() then
                            Report.Run(Report::"Process Fixed Deposit", true, false, FixedDepositAccounts);
                    end;
                }


                action("Request Instruction Change")
                {
                    ApplicationArea = Basic;
                    Caption = 'Request Instruction Change';
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = CanRequestRevision;
                    ToolTip = 'Submit a request to change the maturity instruction for this Fixed Deposit. The change requires approval before it takes effect.';

                    trigger OnAction()
                    var
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                        DocumentType: Enum "Custom Document Type";
                    begin
                        // Guard: only active FDs with no pending action can request a revision
                        Rec.TestField("FD Status", Rec."fd status"::Active);
                        Rec.TestField("Approval Status", Rec."approval status"::Approved);

                        if Rec."Revised Maturity Instructions" = Rec."fd maturity instructions"::" " then
                            Error('Please select the new maturity instruction you are requesting before submitting.');

                        if Rec."Revised Maturity Instructions" = Rec."FD Maturity Instructions" then
                            Error('The proposed instruction is the same as the current instruction. No change is needed.');

                        if not Confirm('Submit a request to change maturity instruction from "%1" to "%2"?',
                                        true,
                                        Rec."FD Maturity Instructions",
                                        Rec."Revised Maturity Instructions") then
                            exit;

                        // Stage the revision — status change signals to approvers
                        // what kind of FDR approval this is
                        Rec."FD Status" := Rec."fd status"::"Revision Pending";
                        Rec."Approval Status" := Rec."approval status"::Pending;
                        Rec.Modify();

                        // Reuse the existing FDR approval tracker
                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(
                            VarVariant,
                            Rec."No.",
                            Rec."FD Amount",
                            DocumentType::FDR,
                            Rec."Global Dimension 1 Code",
                            Rec."Global Dimension 2 Code",
                            0);

                        CurrPage.Update();
                        Message('Instruction change request submitted for approval.');
                    end;
                }
                action("Approve Instruction Change")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve Instruction Change';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = CanApproveRevision;
                    ToolTip = 'Approve the pending maturity instruction change. This will update the instruction and return the FD to Active status.';

                    trigger OnAction()
                    begin
                        Rec.TestField("FD Status", Rec."fd status"::"Revision Pending");

                        if not Confirm('Approve instruction change from "%1" to "%2"? This cannot be undone.',
                                        true,
                                        Rec."FD Maturity Instructions",
                                        Rec."Revised Maturity Instructions") then
                            exit;

                        // Commit the revision
                        Rec."FD Maturity Instructions" := Rec."Revised Maturity Instructions";
                        Rec."Revised Maturity Instructions" := Rec."fd maturity instructions"::" ";
                        Rec."FD Status" := Rec."fd status"::Active;
                        Rec."Approval Status" := Rec."approval status"::Approved;
                        Rec.Modify();

                        CurrPage.Update();
                        Message('Maturity instruction updated successfully.');
                    end;
                }


                action("Reject Instruction Change")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject Instruction Change';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = CanApproveRevision;
                    ToolTip = 'Reject the pending maturity instruction change. The FD will return to Active with the original instruction unchanged.';

                    trigger OnAction()
                    begin
                        Rec.TestField("FD Status", Rec."fd status"::"Revision Pending");

                        if not Confirm('Reject this instruction change request? The FD will return to Active with the original instruction.') then
                            exit;

                        // Roll back — clear the proposed instruction, restore status
                        Rec."Revised Maturity Instructions" := Rec."fd maturity instructions"::" ";
                        Rec."FD Status" := Rec."fd status"::Active;
                        Rec."Approval Status" := Rec."approval status"::Approved;
                        Rec.Modify();

                        CurrPage.Update();
                        Message('Instruction change request rejected. FD remains Active with original instruction.');
                    end;
                }


                action("Request Forfeit")
                {
                    ApplicationArea = Basic;
                    Caption = 'Request Forfeit';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = CanRequestForfeit;
                    ToolTip = 'Submit a request to forfeit this Fixed Deposit. The forfeit requires approval before the break can be processed.';

                    trigger OnAction()
                    var
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                        DocumentType: Enum "Custom Document Type";
                    begin
                        Rec.TestField("FD Status", Rec."fd status"::Active);
                        Rec.TestField("Approval Status", Rec."approval status"::Approved);

                        if not Confirm('Are you sure you want to request a forfeit for this Fixed Deposit? Interest will be forfeited.') then
                            exit;

                        Rec."FD Status" := Rec."fd status"::"Forfeit Pending";
                        Rec."Approval Status" := Rec."approval status"::Pending;
                        Rec.Modify();

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(
                            VarVariant,
                            Rec."No.",
                            Rec."FD Amount",
                            DocumentType::FDR,
                            Rec."Global Dimension 1 Code",
                            Rec."Global Dimension 2 Code",
                            0);

                        //CurrPage.Update();
                        Message('Forfeit request submitted for approval.');
                    end;
                }

                action("Break Fixed Deposit")
                {
                    ApplicationArea = Basic;
                    Caption = 'Break Fixed Deposit';
                    Enabled = CanBreak;
                    ToolTip = 'Process the forfeit of this Fixed Deposit. Only available after the forfeit request has been approved.';

                    trigger OnAction()
                    begin
                        // FD Status must be Forfeited — set by the approver
                        if Rec."FD Status" <> Rec."FD Status"::Forfeited then
                            Error('The forfeit request must be approved before you can break this Fixed Deposit.');

                        if not Confirm('Are you sure you want to break this Fixed Deposit? This cannot be undone.') then
                            exit;

                        Rec.CalcFields("Fixed Account Balance");
                        if Rec."FD Amount" > Rec."Fixed Account Balance" then
                            Error(
                                'Fixed Deposit %1 cannot be broken because the fixed account %2 has insufficient balance.\Required FD Amount: %3\Available Fixed Account Balance: %4\Shortage: %5',
                                Rec."No.",
                                Rec."Fixed Account No.",
                                Rec."FD Amount",
                                Rec."Fixed Account Balance",
                                Rec."FD Amount" - Rec."Fixed Account Balance");

                        Rec.TestField("FD Start Date");
                        Rec.TestField("Savings Account");
                        Rec.TestField("Fixed Account No.");
                        Rec.TestField("FD Amount");
                        Rec.TestField("FD Duration");
                        Rec.TestField("FD Maturity Date");
                        if Rec."FD Maturity Instructions" = Rec."fd maturity instructions"::" " then
                            Error('Enter FD maturity Instruction');
                        Rec.TestField("Approval Status", Rec."approval status"::Approved);
                        Rec.TestField("FD Status", Rec."fd status"::Forfeited);

                        ProductSetup.Reset();
                        ProductSetup.SetRange("Product Category", ProductSetup."product category"::"Fixed Deposit");
                        ProductSetup.FindFirst();
                        BankingActivities.BreakPlacement(Today, Rec."No.", ProductSetup);
                        CurrPage.Update();
                    end;
                }

                action("Place Fixed Deposit")
                {
                    ApplicationArea = Basic;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;

                    trigger OnAction()
                    var
                        DimID: Integer;
                    begin
                        UserSetup.Get(UserId);

                        Rec.TestField(Posted, false);
                        Rec.TestField("Savings Account");
                        Rec.TestField("FD Start Date");
                        Rec.TestField("Fixed Account No.");
                        Rec.TestField("FD Amount");
                        Rec.TestField("FD Duration");
                        Rec.TestField("FD Maturity Date");
                        if Rec."FD Maturity Instructions" = Rec."fd maturity instructions"::" " then
                            Error('Enter FD maturity Instruction');
                        // Rec.TestField("Approval Status", Rec."approval status"::Approved);
                        // Rec.TestField("FD Status", Rec."fd status"::" ");
                        // DimID := UserSetup."Dimension Set ID";

                        // if not Confirm('Are you sure you want to place this Fixed Deposit?') then
                        //     exit;

                        // if Rec."FD Amount" > MemberActivities.GetAccountBalance(Rec."Savings Account") then
                        //     Error('Insufficient Balance in Savings Account.');

                        Rec.PlaceFD;

                        // SaccoActivities.GetGeneralJournalTemplate(JTemplate, JBatch);
                        // SaccoActivities.JournalInit(JTemplate, JBatch);

                        // SaccoActivities.JournalInsert(
                        //     JTemplate, JBatch, Rec."No.", Rec."FD Start Date",
                        //     Accttype::Savings, Rec."Savings Account",
                        //     'Fixed Deposit Placement',
                        //     Balaccttype::"G/L Account", '', Rec."FD Amount",
                        //     Rec."Fixed Account No.", '', Transtype::" ",
                        //     Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code",
                        //     true, TChannel::" ", DimID);

                        // SaccoActivities.JournalInsert(
                        //     JTemplate, JBatch, Rec."No.", Rec."FD Start Date",
                        //     Accttype::Savings, Rec."Fixed Account No.",
                        //     'Fixed Deposit Placement',
                        //     Balaccttype::"G/L Account", '', -Rec."FD Amount",
                        //     Rec."Savings Account", '', Transtype::" ",
                        //     Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code",
                        //     true, TChannel::" ", DimID);

                        // Rec."FD Status" := Rec."fd status"::Active;
                        // Rec.Posted := true;
                        // Rec."Posted By" := UserId;
                        // Rec.Modify();
                        // SaccoActivities.JournalPost(JTemplate, JBatch);
                        // Message('Fixed Deposit Placed Successfully');
                    end;
                }
            }

            action("Validate Values")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to update these values?') then begin
                        Rec.Validate("FD Type");
                        Rec.Modify();
                    end;
                end;
            }

            action("FDR Certificate")
            {
                ApplicationArea = Basic;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Report;


                trigger OnAction()
                var
                    FDR: Record "Fixed Deposit Accounts";
                begin
                    FDR.Reset();
                    FDR.SetRange("No.", Rec."No.");
                    if FDR.FindFirst() then
                        Report.Run(Report::"Fixed Deposit Certificate", true, false, FDR);
                end;
            }
            action("FDR Maturity Report")
            {
                ApplicationArea = Basic;
                image = Certificate;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    FDR: Record "Fixed Deposit Accounts";
                begin
                    FDR.Reset();
                    FDR.SetRange("No.", Rec."No.");
                    if FDR.FindFirst() then
                        Report.Run(Report::"Fixed Deposit Report 1", true, false, FDR);
                end;
            }
            action("FDR Termination Report")
            {
                ApplicationArea = Basic;
                image = Certificate;
                Promoted = true;
                PromotedCategory = Report;


                trigger OnAction()
                var
                    FDR: Record "Fixed Deposit Accounts";
                begin
                    FDR.Reset();
                    FDR.SetRange("No.", Rec."No.");
                    if FDR.FindFirst() then
                        Report.Run(Report::"Fixed Deposit Termination", true, false, FDR);
                end;
            }
        }

        area(processing)
        {
            group(RequestApproval)
            {
                Caption = 'Request Approval';

                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = category4;

                    trigger OnAction()
                    var
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Posted, false);
                        Rec.TestField("Approval Status", Rec."approval status"::Open);
                        CheckControls();

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(
                            VarVariant,
                            Rec."No.",
                            Rec."FD Amount",
                            DocumentType::FDR,
                            Rec."Global Dimension 1 Code",
                            Rec."Global Dimension 2 Code",
                            0);
                    end;
                }

                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = category4;

                    trigger OnAction()
                    var
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField("Approval Status", Rec."approval status"::Pending);
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
                    PromotedCategory = category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR;
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := DocumentType::FDR;

                        ApprovalTracker.Reset();
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
                        ApprovalTracker.SetRange("Document Type", DocumentType);
                        if ApprovalTracker.FindFirst() then
                            ApprovalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }

                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        if Rec."Approval Status" = Rec."approval status"::Pending then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
                        end else begin
                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;
                            Rec."Approval Status" := Rec."approval status"::Open;
                            Rec.Modify();
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        UpdateControl();
    end;

    var
        gedit: Boolean;
        RevisionVisible: Boolean;
        RevisionEditable: Boolean;
        CanRequestRevision: Boolean;
        CanApproveRevision: Boolean;
        CanRequestForfeit: Boolean;
        CanBreak: Boolean;
        FDStatusHighlight: Boolean;
        UserSetup: Record "User Setup";
        FixedDepositAccounts: Record "Fixed Deposit Accounts";
        MemberActivities: Codeunit "Member Activities";
        SaccoActivities: Codeunit "Sacco Activities";
        BankingActivities: Codeunit "Banking Activities";
        JTemplate: Code[10];
        JBatch: Code[10];
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        ProductSetup: Record "Product Setup";
        TChannel: Enum "Transaction Channel";

    local procedure UpdateControl()
    begin
        // Main group editability — only while Open (initial capture)
        gedit := Rec."Approval Status" = Rec."approval status"::Open;

        // Revision group — visible whenever a revision is in flight
        RevisionVisible := (Rec."FD Status" = Rec."fd status"::"Revision Pending") or
                   ((Rec."FD Status" = Rec."fd status"::Active) and
                    (Rec."Approval Status" = Rec."approval status"::Approved));

        // Proposed instruction editable only before submission (still Active, not yet Pending)
        RevisionEditable := (Rec."FD Status" = Rec."fd status"::Active) and
                            (Rec."Approval Status" = Rec."approval status"::Approved);

        // Action availability — prevents impossible state transitions
        CanRequestRevision := (Rec."FD Status" = Rec."fd status"::Active) and
                              (Rec."Approval Status" = Rec."approval status"::Approved);

        CanApproveRevision := Rec."FD Status" = Rec."fd status"::"Revision Pending";

        CanRequestForfeit := (Rec."FD Status" = Rec."fd status"::Active) and
                             (Rec."Approval Status" = Rec."approval status"::Approved);

        CanBreak := Rec."FD Status" = Rec."fd status"::Forfeited;
        FDStatusHighlight := (Rec."FD Status" = Rec."fd status"::"Revision Pending") or
                             (Rec."FD Status" = Rec."fd status"::"Forfeit Pending");
    end;

    local procedure CheckControls()
    begin
        Rec."Application Date" := Today;
        Rec."Captured By" := UserId;
        Rec.Modify();

        Rec.TestField("Member No.");
        Rec.TestField("Savings Account");
        Rec.TestField("Fixed Account No.");
        Rec.TestField("FD Type");
        Rec.TestField("FD Start Date");
        Rec.TestField("FD Maturity Date");
        Rec.TestField("FD Amount");
        if Rec."FD Maturity Instructions" = Rec."fd maturity instructions"::" " then
            Error('Enter FD maturity Instruction');

        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 2 Code");

        if Rec."Global Dimension 2 Code" <> UserSetup."Global Dimension 2 Code" then begin
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec.Modify();
        end;
    end;
}
