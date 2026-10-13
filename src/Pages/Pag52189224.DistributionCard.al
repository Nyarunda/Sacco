page 50926 "Distribution Card"
{
    ApplicationArea = All;
    Caption = 'Distribution Card';
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "Distributions Header";
    PromotedActionCategories = 'New,Process,Report,GenerateDistribution,Post Distribution,Request Approvals';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No. field.', Comment = '%';
                }
                field(DepositBalance; Rec."Deposit Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deposit Balance field.', Comment = '%';
                }
                field("Amount To Distribute"; Rec."Amount To Distribute")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount To Distribute field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }

                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Captured By field.', Comment = '%';
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Captured field.', Comment = '%';
                }
            }

            part(Control1; "Distribution Lines")
            {
                //Editable = false;
                ApplicationArea = All;
                SubPageLink = "Header No." = field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SelectLoan)
            {
                ApplicationArea = Basic;
                Caption = 'Select Defaulter Loan';
                Image = SelectLineToApply;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Select a defaulter loan to distribute recoveries';
                RunObject = Page "Defaulter Loan Selection";
                RunPageLink = "Advice No." = field("No."), "Member No." = field("Member No.");
            }
            action(GenerateDistribution)
            {
                ApplicationArea = Basic;
                Caption = 'Generate Distribution';
                Image = GeneralPostingSetup;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    Legacy: Codeunit Legacy;
                    MemberActivities: Codeunit "Member Activities";
                    SelectedLoans: Record "Defaulter Loan Selection";
                    CLedger: Record "Credit Ledger Entry";
                    Loans: Record Loans;
                    RecoveryLines: Record "Defaulter Recovery Lines";
                    DefaulterPaidAmount: Decimal;
                    TotalDistributionAmount: Decimal;
                    LinesCreated: Integer;
                begin
                    // Clear existing distribution lines
                    DistributionLines.Reset();
                    DistributionLines.SetRange("Header No.", Rec."No.");
                    DistributionLines.DeleteAll();

                    LinesCreated := 0;

                    // Process based on whether a specific loan is selected or using selection table
                    if Rec."Loan No." <> '' then begin
                        // Single defaulter loan mode: use the original recovery lines so savings-only guarantors are included.
                        DefaulterPaidAmount := CalculateTotalRecoveryAmount(Rec."Loan No.");

                        if DefaulterPaidAmount = 0 then begin
                            Message('No guarantor recovery lines found for defaulter loan %1', Rec."Loan No.");
                            exit;
                        end;

                        TotalDistributionAmount := Rec."Amount To Distribute";
                        if TotalDistributionAmount = 0 then
                            TotalDistributionAmount := MemberActivities.GetAccountBalance(Legacy.GetDepositAccounts(Rec."Member No."));

                        RecoveryLines.Reset();
                        RecoveryLines.SetRange("Loan No.", Rec."Loan No.");
                        RecoveryLines.SetFilter("Amount to Recover", '>0');
                        RecoveryLines.SetRange(Reversed, false);
                        if RecoveryLines.FindSet() then
                            repeat
                                if CreateDistributionLineFromRecoveryLine(RecoveryLines, DefaulterPaidAmount, TotalDistributionAmount, false, 0) then
                                    LinesCreated += 1;
                            until RecoveryLines.Next() = 0;

                    end else begin
                        // Multiple loan selection mode: Process each selected loan individually
                        SelectedLoans.Reset();
                        SelectedLoans.SetRange("Advice No.", Rec."No.");
                        if not SelectedLoans.FindSet() then begin
                            Message('No loans selected for distribution. Please use "Select Defaulter Loan" action first.');
                            exit;
                        end;

                        repeat
                            DefaulterPaidAmount := CalculateTotalRecoveryAmount(SelectedLoans."Loan No.");
                            RecoveryLines.Reset();
                            RecoveryLines.SetRange("Loan No.", SelectedLoans."Loan No.");
                            RecoveryLines.SetFilter("Amount to Recover", '>0');
                            RecoveryLines.SetRange(Reversed, false);
                            if RecoveryLines.FindSet() then
                                repeat
                                    if CreateDistributionLineFromRecoveryLine(RecoveryLines, DefaulterPaidAmount, SelectedLoans."Amount To Distribute", false, 0) then
                                        LinesCreated += 1;
                                until RecoveryLines.Next() = 0;
                        until SelectedLoans.Next() = 0;
                    end;

                    if LinesCreated > 0 then
                        Message('Distribution generated successfully. %1 line(s) created.', LinesCreated)
                    else
                        Message('No distribution lines were created. Please verify the loan data.');
                end;
            }
            action(PostDistribution)
            {
                ApplicationArea = Basic;
                Caption = 'Post Distribution';
                Image = GeneralPostingSetup;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = not Rec.Posted;

                trigger OnAction()
                var
                    DistributionLines: Record "Distribution Lines";
                    SaccoActivities: Codeunit "Sacco Activities";
                    UserSetup: Record "User Setup";
                    DepositAcc: Record "Savings Accounts";
                    SavAcc: Record "Savings Accounts";
                    GuarantorLoan: Record Loans;
                    JTemplate: Code[20];
                    JBatch: Code[20];
                    PDate: Date;
                    RunBal: Decimal;
                    Amt: Decimal;
                    LoanOutstanding: Decimal;
                    AmtToLoan: Decimal;
                    AmtToSavings: Decimal;
                    Desc: Text[100];
                    ExtDocNo: Code[20];
                    DocNo: Code[20];
                    DActivity2: Code[20];
                    DBranch2: Code[20];
                    AcctType: Enum "Gen. Journal Account Type";
                    BalAcctType: Enum "Gen. Journal Account Type";
                    BalAcctNo: Code[20];
                    TransType: Enum "Transaction Type Enum";
                    TChannel: Enum "Transaction Channel";
                    Source: Enum "SMS Source Enum";
                    LinePosted: Boolean;
                begin
                    Rec.TestField(Posted, false);
                    Rec.TestField(Status, Rec.Status::Approved);

                    SaccoActivities.GetPaymentJournalTemplate(JTemplate, JBatch);
                    SaccoActivities.JournalInit(JTemplate, JBatch);
                    PDate := Rec."Posting Date";

                    UserSetup.Get(UserId);

                    // Get defaulter's deposit account
                    DepositAcc.Reset();
                    DepositAcc.SetRange("Member No.", Rec."Member No.");
                    DepositAcc.SetFilter("Balance (LCY)", '>0');
                    DepositAcc.SetRange("Product Category", DepositAcc."Product Category"::"Deposit Contribution");
                    DepositAcc.SetAutoCalcFields("Balance (LCY)");
                    if not DepositAcc.FindFirst() then begin
                        Message('No deposit account with sufficient balance found for member %1.', Rec."Member No.");
                        exit;
                    end;

                    RunBal := DepositAcc."Balance (LCY)";
                    if RunBal <= 0 then begin
                        Message('Insufficient balance in defaulter deposit account.');
                        exit;
                    end;

                    DistributionLines.Reset();
                    DistributionLines.SetRange("Header No.", Rec."No.");
                    if not DistributionLines.FindSet() then begin
                        Message('No distribution lines found.');
                        exit;
                    end;

                    repeat
                        Amt := DistributionLines."Disbributed Amount";
                        LinePosted := false;

                        if Amt <= 0 then
                            continue;

                        if Amt > RunBal then
                            Error('Insufficient deposit balance to post distribution line for guarantor %1. Required: %2, Available: %3',
                                DistributionLines."Guarantor Member No.", Amt, RunBal);

                        if RunBal <= 0 then
                            Error('Insufficient balance in defaulter deposit account.');

                        // -------------------------------------------------------
                        // Check if this guarantor has an active defaulter loan
                        // that still has an outstanding balance to recover first
                        // -------------------------------------------------------
                        AmtToLoan := 0;
                        AmtToSavings := 0;

                        if DistributionLines."Amount as Loan" > 0 then begin
                            GuarantorLoan.Reset();
                            if DistributionLines."Guarantor Outstanding Loan No." <> '' then
                                GuarantorLoan.SetRange("Loan No.", DistributionLines."Guarantor Outstanding Loan No.")
                            else begin
                                GuarantorLoan.SetRange("Defaulter Loan No.", DistributionLines."Loan No");
                                GuarantorLoan.SetRange("Member No.", DistributionLines."Guarantor Member No.");
                                GuarantorLoan.SetRange("Defaulter Member No.", Rec."Member No.");
                            end;
                            GuarantorLoan.SetAutoCalcFields("Outstanding Principal", "Outstanding Interest", "Total Outstanding Balance");
                            GuarantorLoan.SetFilter("Total Outstanding Balance", '>0');
                        end;

                        if (DistributionLines."Amount as Loan" > 0) and GuarantorLoan.FindFirst() then begin
                            // Guarantor has a defaulter loan — prioritize clearing it
                            LoanOutstanding := GuarantorLoan."Total Outstanding Balance";
                            if Amt > DistributionLines."Amount as Loan" then
                                AmtToLoan := DistributionLines."Amount as Loan"
                            else
                                AmtToLoan := Amt;

                            if AmtToLoan >= LoanOutstanding then begin
                                // Full loan clearance possible
                                AmtToLoan := LoanOutstanding;
                                AmtToSavings := Amt - LoanOutstanding; // remainder goes to savings
                            end else begin
                                // Partial recovery only
                                AmtToSavings := Amt - AmtToLoan;
                            end;

                            // --- Post recovery against guarantor's defaulter loan ---
                            if AmtToLoan > 0 then begin
                                Desc := CopyStr('Loan Recovery - Refund from ' + Rec."Member No." + ' for Loan ' + GuarantorLoan."Loan No.", 1, 100);

                                // Debit defaulter's deposit account
                                SaccoActivities.JournalInsert(
                                    JTemplate, JBatch, Rec."No.", PDate,
                                    AcctType::Savings, DepositAcc."No.",
                                    Desc, BalAcctType, BalAcctNo,
                                    AmtToLoan, ExtDocNo, '', TransType,
                                    DActivity2, DBranch2, true,
                                    TChannel::Distribution, UserSetup."Dimension Set ID");

                                // Credit against guarantor's loan (loan repayment posting)
                                // Adjust AcctType and account to match your loan repayment setup
                                SaccoActivities.JournalInsert(
                                    JTemplate, JBatch, Rec."No.", PDate,
                                    AcctType::Credit, GuarantorLoan."Loan Account",
                                    Desc, BalAcctType, BalAcctNo,
                                    -AmtToLoan, ExtDocNo, '', TransType,
                                    DActivity2, DBranch2, true,
                                    TChannel::Distribution, UserSetup."Dimension Set ID");

                                RunBal -= AmtToLoan;
                                LinePosted := true;
                            end;

                        end else begin
                            // Savings/default recovery, or the issued defaulter loan has already been cleared.
                            AmtToSavings := Amt;
                        end;

                        // --- Post remainder (or full amount) to guarantor savings ---
                        if AmtToSavings > 0 then begin
                            SavAcc.Reset();
                            SavAcc.SetRange("Member No.", DistributionLines."Guarantor Member No.");
                            SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Unallocated Fund");

                            if SavAcc.FindFirst() then begin
                                Desc := CopyStr(Rec."Loan No." + ' Recovery Refund ' + 'MNo. ' + DepositAcc."Member No." + ' ' + SavAcc.Name, 1, 100);

                                if AmtToSavings > RunBal then
                                    AmtToSavings := RunBal;

                                if (AmtToSavings > 0) and (RunBal > 0) then begin
                                    // Debit defaulter deposit
                                    SaccoActivities.JournalInsert(
                                        JTemplate, JBatch, Rec."No.", PDate,
                                        AcctType::Savings, DepositAcc."No.",
                                        Desc, BalAcctType, BalAcctNo,
                                        AmtToSavings, ExtDocNo, '', TransType,
                                        DActivity2, DBranch2, true,
                                        TChannel::Distribution, UserSetup."Dimension Set ID");

                                    // Credit guarantor savings
                                    SaccoActivities.JournalInsert(
                                        JTemplate, JBatch, Rec."No.", PDate,
                                        AcctType::Savings, SavAcc."No.",
                                        Desc, BalAcctType, BalAcctNo,
                                        -AmtToSavings, ExtDocNo, '', TransType,
                                        DActivity2, DBranch2, true,
                                        TChannel::Distribution, UserSetup."Dimension Set ID");

                                    RunBal -= AmtToSavings;
                                    LinePosted := true;
                                end;
                            end else
                                Error('No unallocated fund savings account found for guarantor %1. Distribution line was not posted.',
                                    DistributionLines."Guarantor Member No.");
                        end;

                        if LinePosted then begin
                            DistributionLines.Posted := true;
                            DistributionLines.Modify();
                        end;

                    until DistributionLines.Next() = 0;

                    SaccoActivities.JournalPost(JTemplate, JBatch);

                    Rec.Posted := true;
                    Rec."Posted By" := UserId;
                    Rec."Date Posted" := Today;
                    Rec.Modify();

                    Message('Distribution posted successfully.');
                end;
            }
        }
        area(Navigation)
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
                    PromotedCategory = Category6;
                    Enabled = not Rec.Posted;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::Distribution, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Enabled = not Rec.Posted;

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
                    PromotedCategory = Category6;


                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Enum "Custom Document Type"; //Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Collateral Return",CheckOff,"Bankers Cheque",Salary,Receipt;
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::Distribution;

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
                    Promoted = true;
                    PromotedCategory = Category6;
                    Enabled = not Rec.Posted;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        rec.TestField(Status, Rec.Status::Pending);
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
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if (Rec.Posted) or (rec.Status <> rec.Status::Open) then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if (Rec.Posted) or (rec.Status <> rec.Status::Open) then
            CurrPage.Editable := false;
    end;

    local procedure CalculateTotalRecoveryAmount(DefaulterLoanNo: Code[20]): Decimal
    var
        RecoveryLines: Record "Defaulter Recovery Lines";
        TotalAmount: Decimal;
    begin
        RecoveryLines.Reset();
        RecoveryLines.SetRange("Loan No.", DefaulterLoanNo);
        RecoveryLines.SetFilter("Amount to Recover", '>0');
        if RecoveryLines.FindSet() then
            repeat
                TotalAmount += RecoveryLines."Amount to Recover";
            until RecoveryLines.Next() = 0;

        exit(TotalAmount);
    end;

    local procedure CalculateTotalDefaulterAmount(DefaulterLoanNo: Code[20]): Decimal
    var
        Loans: Record Loans;
        CLedger: Record "Credit Ledger Entry";
        TotalAmount: Decimal;
    begin
        TotalAmount := 0;

        Loans.Reset();
        Loans.SetRange("Defaulter Loan No.", DefaulterLoanNo);
        Loans.SetLoadFields("Approved Amount", "Loan No.");

        if Loans.FindSet() then
            repeat
                // Only count loans that have been disbursed (have credit ledger entries)
                CLedger.Reset();
                CLedger.SetRange("Loan No.", Loans."Loan No.");
                CLedger.SetRange(Reversed, false);
                if CLedger.FindFirst() then
                    TotalAmount += Loans."Approved Amount";
            until Loans.Next() = 0;

        exit(TotalAmount);
    end;

    local procedure CreateDistributionLineFromRecoveryLine(var RecoveryLines: Record "Defaulter Recovery Lines"; DefaulterPaidAmount: Decimal; TotalDistributionAmount: Decimal; UseFixedAmount: Boolean; FixedAmount: Decimal): Boolean
    var
        NewDistributionLine: Record "Distribution Lines";
        GuarantorLoan: Record Loans;
        PreviousPaidAmt: Decimal;
        DistributionAmount: Decimal;
        MaxAllowedAmount: Decimal;
    begin
        if RecoveryLines."Amount to Recover" <= 0 then
            exit(false);

        PreviousPaidAmt := GetPreviouslyDistributedAmountForGuarantor(RecoveryLines."Loan No.", RecoveryLines."Guarantor Member No.");

        if UseFixedAmount then
            DistributionAmount := FixedAmount
        else if DefaulterPaidAmount > 0 then
            DistributionAmount := (RecoveryLines."Amount to Recover" / DefaulterPaidAmount) * TotalDistributionAmount
        else
            exit(false);

        MaxAllowedAmount := RecoveryLines."Amount to Recover" - PreviousPaidAmt;
        if DistributionAmount > MaxAllowedAmount then
            DistributionAmount := MaxAllowedAmount;

        if DistributionAmount <= 0 then
            exit(false);

        NewDistributionLine.Init();
        NewDistributionLine."Header No." := Rec."No.";
        NewDistributionLine."Loan No" := RecoveryLines."Loan No.";
        NewDistributionLine."Guarantor Member No." := RecoveryLines."Guarantor Member No.";
        NewDistributionLine."Guarantor Name" := RecoveryLines."Guarantor Name";
        NewDistributionLine."Approved Amount" := RecoveryLines."Amount Guaranteed";
        NewDistributionLine."Disbributed Amount" := DistributionAmount;
        NewDistributionLine."Recovery Method" := RecoveryLines."Recovery Method";
        NewDistributionLine."Amount from Savings" := RecoveryLines.GetSavingsAmount();
        NewDistributionLine."Amount as Loan" := RecoveryLines.GetLoanAmount();
        NewDistributionLine."Guarantor Savings Account" := RecoveryLines."Guarantor Savings Account";
        NewDistributionLine."Recovery Header No." := RecoveryLines."Header No.";

        GuarantorLoan.Reset();
        GuarantorLoan.SetRange("Member No.", RecoveryLines."Guarantor Member No.");
        GuarantorLoan.SetRange("Defaulter Loan No.", RecoveryLines."Loan No.");
        GuarantorLoan.SetRange("Defaulter Member No.", Rec."Member No.");
        GuarantorLoan.SetAutoCalcFields("Outstanding Principal", "Outstanding Interest", "Total Outstanding Balance");
        GuarantorLoan.SetFilter("Total Outstanding Balance", '>0');
        if GuarantorLoan.FindFirst() then begin
            NewDistributionLine."Has Defaulter Loan" := true;
            NewDistributionLine."Guarantor Outstanding Loan No." := GuarantorLoan."Loan No.";
            NewDistributionLine."Current Outstanding Balance" := GuarantorLoan."Outstanding Principal";
            NewDistributionLine."Current Outstanding Interest" := GuarantorLoan."Outstanding Interest";
        end;

        NewDistributionLine.Insert();
        exit(true);
    end;

    local procedure CreateDistributionLine(var Loans: Record Loans; DefaulterPaidAmount: Decimal; TotalDistributionAmount: Decimal; UseFixedAmount: Boolean; FixedAmount: Decimal): Boolean
    var
        NewDistributionLine: Record "Distribution Lines";
        PreviousPaidAmt: Decimal;
        LinePaid: Decimal;
        DistributionAmount: Decimal;
        MaxAllowedAmount: Decimal;
        GuarantorLoan: Record Loans;
    begin
        // Calculate the loan's total amount (principal + interest)
        LinePaid := Loans."Interest Due" + Loans."Approved Amount";

        if LinePaid <= 0 then
            exit(false);

        // Get previously distributed amount for this loan
        PreviousPaidAmt := GetPreviouslyDistributedAmount(Loans."Loan No.");

        // Calculate distribution amount
        if UseFixedAmount then
            DistributionAmount := FixedAmount
        else if DefaulterPaidAmount > 0 then
            DistributionAmount := (LinePaid / DefaulterPaidAmount) * TotalDistributionAmount
        else
            exit(false);

        // Ensure we don't overpay the loan (principal + interest - already paid)
        MaxAllowedAmount := Loans."Approved Amount" + Loans."Interest Due" - PreviousPaidAmt;

        if DistributionAmount > MaxAllowedAmount then
            DistributionAmount := MaxAllowedAmount;

        // Don't create lines with zero or negative amounts
        if DistributionAmount <= 0 then
            exit(false);

        // Create the distribution line
        NewDistributionLine.Init();
        NewDistributionLine."Header No." := Rec."No.";
        NewDistributionLine."Loan No" := Loans."Loan No.";
        NewDistributionLine."Current Outstanding Balance" := Loans."Outstanding Principal";
        NewDistributionLine."Current Outstanding Interest" := Loans."Outstanding Interest";
        NewDistributionLine."Guarantor Member No." := Loans."Member No.";
        NewDistributionLine."Guarantor Name" := Loans."Member Name";
        NewDistributionLine."Approved Amount" := Loans."Approved Amount";
        NewDistributionLine."Disbributed Amount" := DistributionAmount;
        NewDistributionLine.Insert();

        //Flag whether this guarantor's refund will go to their
        // outstanding defaulter loan or straight to savings

        GuarantorLoan.Reset();
        GuarantorLoan.SetRange("Member No.", Loans."Member No.");
        GuarantorLoan.SetRange("Defaulter Loan No.", Loans."Defaulter Loan No.");
        GuarantorLoan.SetRange("Defaulter Member No.", Rec."Member No.");
        GuarantorLoan.SetAutoCalcFields("Total Outstanding Balance");
        GuarantorLoan.SetFilter("Total Outstanding Balance", '>0');
        if GuarantorLoan.FindFirst() then begin
            NewDistributionLine."Has Defaulter Loan" := true;
            NewDistributionLine."Guarantor Outstanding Loan No." := GuarantorLoan."Loan No.";
            NewDistributionLine.Modify();
        end;

        exit(true);
    end;

    local procedure GetPreviouslyDistributedAmountForGuarantor(LoanNo: Code[20]; GuarantorMemberNo: Code[20]): Decimal
    var
        PostedDistLines: Record "Distribution Lines";
        TotalAmount: Decimal;
    begin
        PostedDistLines.Reset();
        PostedDistLines.SetRange("Loan No", LoanNo);
        PostedDistLines.SetRange("Guarantor Member No.", GuarantorMemberNo);
        PostedDistLines.SetRange(Posted, true);
        PostedDistLines.SetRange(Reversed, false);
        if PostedDistLines.FindSet() then
            repeat
                TotalAmount += PostedDistLines."Disbributed Amount";
            until PostedDistLines.Next() = 0;

        exit(TotalAmount);
    end;

    local procedure GetPreviouslyDistributedAmount(LoanNo: Code[20]): Decimal
    var
        PostedDistLines: Record "Distribution Lines";
    begin
        PostedDistLines.Reset();
        PostedDistLines.SetRange("Loan No", LoanNo);
        PostedDistLines.SetRange(Posted, true);

        if PostedDistLines.FindFirst() then begin
            PostedDistLines.CalcSums("Disbributed Amount");
            exit(PostedDistLines."Disbributed Amount");
        end;

        exit(0);
    end;

    var
        DistributionLines: Record "Distribution Lines";
        PostedLines: Record "Distribution Lines";
}
