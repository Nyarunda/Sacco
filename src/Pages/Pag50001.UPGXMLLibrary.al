page 50001 "UPG_XML Library"
{
    ApplicationArea = All;
    Caption = 'UPG_XML Library';
    PageType = Card;
    Permissions = tabledata "Credit Ledger Entry" = m,
                  tabledata "G/L Entry" = md,
                  tabledata "Vendor Ledger Entry" = m,
                  tabledata "Detailed Vendor Ledg. Entry" = m,
                  tabledata "Savings Ledger Entry" = m,
                  tabledata "Bank Account Ledger Entry" = m,
                  tabledata "Loan Security" = d,
                  tabledata "Fixed Deposit Accounts" = d,
                  tabledata Loans = m,
                  tabledata "Loan Repayment Schedule" = rmd,
                  tabledata "G/L Entry Migration" = r,
                  tabledata "Vendor Ledger Entry Migration" = r,
                  tabledata "Sky M-Banking Transactions" = m,
                  tabledata "Email Logs Notifications" = d;
    PromotedActionCategories = 'New,Process,Report,Loans&Banks,Members,Import,Loans,Products&Chat,Create,Posting,Others';


    layout
    {        
        area(content)
        {
            group(General)
            {
                field(BankCodeToClean; BankCodeToClean)
                {
                    ApplicationArea = All;
                    Caption = 'Bank Code to Clean';
                    TableRelation = "Bank Account"."No.";
                    ToolTip = 'Specifies the bank account code prefix to remove from ledger descriptions, for example BANK008.';
                }
                field(BankLedgerRepairBankAccountNo; BankLedgerRepairBankAccountNo)
                {
                    ApplicationArea = All;
                    Caption = 'Bank Ledger Repair Bank Account';
                    TableRelation = "Bank Account"."No.";
                    ToolTip = 'Optionally filters the bank account ledger entries to repair by bank account.';
                }
                field(BankLedgerRepairExternalDocNo; BankLedgerRepairExternalDocNo)
                {
                    ApplicationArea = All;
                    Caption = 'Bank Ledger Repair External Doc. No.';
                    ToolTip = 'Filters the corrupted bank account ledger entries to repair by external document number.';
                }
                field(BankLedgerRepairEntryNoFilter; BankLedgerRepairEntryNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Bank Ledger Repair Entry No. Filter';
                    ToolTip = 'Optionally filters the corrupted bank account ledger entries by entry number, for example 1000..1010 or 1000|1005.';
                }
                field(BankLedgerRepairPostingDateFilter; BankLedgerRepairPostingDateFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Bank Ledger Repair Posting Date Filter';
                    ToolTip = 'Optionally filters the corrupted bank account ledger entries by posting date, for example 010726..310726.';
                }
                field(BankLedgerReopenEntryNo; BankLedgerReopenEntryNo)
                {
                    ApplicationArea = All;
                    Caption = 'Bank Ledger Reopen Entry No.';
                    ToolTip = 'Specifies the bank account ledger entry number to reopen for bank reconciliation.';
                }
                field(BankLedgerReopenBankAccountNo; BankLedgerReopenBankAccountNo)
                {
                    ApplicationArea = All;
                    Caption = 'Bank Ledger Reopen Bank Account';
                    TableRelation = "Bank Account"."No.";
                    ToolTip = 'Optionally confirms the bank account number on the bank ledger entry being reopened.';
                }
                field(LedgerReversalNewValue; LedgerReversalNewValue)
                {
                    ApplicationArea = All;
                    Caption = 'Mark As Reversed';
                    ToolTip = 'Specifies the new Reversed value to apply to the selected G/L entries.';
                }
                field(LedgerReversalEntryNoFilter; LedgerReversalEntryNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Entry No. Filter';
                    ToolTip = 'Optionally filters ledger entries by entry number, for example 1000..1010 or 1000|1005.';
                }
                field(LedgerReversalDocumentNoFilter; LedgerReversalDocumentNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Document No. Filter';
                    ToolTip = 'Optionally filters ledger entries by document number.';
                }
                field(LedgerReversalExternalDocNoFilter; LedgerReversalExternalDocNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Ledger External Doc. No. Filter';
                    ToolTip = 'Optionally filters ledger entries by external document number.';
                }
                field(LedgerReversalTransactionNoFilter; LedgerReversalTransactionNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Transaction No. Filter';
                    ToolTip = 'Optionally filters ledger entries by transaction number.';
                }
                field(LedgerReversalPostingDateFilter; LedgerReversalPostingDateFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Posting Date Filter';
                    ToolTip = 'Optionally filters ledger entries by posting date, for example 010126..310126.';
                }
                field(VendorLedgerOpenNewValue; VendorLedgerOpenNewValue)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Ledger Mark As Open';
                    ToolTip = 'Specifies the new Open value to apply to the selected vendor ledger entries.';
                }
                field(VendorLedgerEntryNoFilter; VendorLedgerEntryNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Ledger Entry No. Filter';
                    ToolTip = 'Optionally filters vendor ledger entries by entry number, for example 1000..1010 or 1000|1005.';
                }
                field(VendorLedgerDocumentNoFilter; VendorLedgerDocumentNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Ledger Document No. Filter';
                    ToolTip = 'Optionally filters vendor ledger entries by document number.';
                }
                field(VendorLedgerVendorNoFilter; VendorLedgerVendorNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Ledger Vendor No. Filter';
                    ToolTip = 'Optionally filters vendor ledger entries by vendor number.';
                }
                field(VendorLedgerExternalDocNoFilter; VendorLedgerExternalDocNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Ledger External Doc. No. Filter';
                    ToolTip = 'Optionally filters vendor ledger entries by external document number.';
                }
                field(VendorLedgerTransactionNoFilter; VendorLedgerTransactionNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Ledger Transaction No. Filter';
                    ToolTip = 'Optionally filters vendor ledger entries by transaction number.';
                }
                field(VendorLedgerPostingDateFilter; VendorLedgerPostingDateFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Ledger Posting Date Filter';
                    ToolTip = 'Optionally filters vendor ledger entries by posting date, for example 010126..310126.';
                }
                field(GLEntryNewTransactionNo; GLEntryNewTransactionNo)
                {
                    ApplicationArea = All;
                    Caption = 'G/L New Transaction No.';
                    ToolTip = 'Specifies the new transaction number to apply to selected G/L entries.';
                }
                field(GLEntryTransactionEntryNoFilter; GLEntryTransactionEntryNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'G/L Trans. Entry No. Filter';
                    ToolTip = 'Optionally filters G/L entries by entry number, for example 514811 or 514811..514820.';
                }
                field(GLEntryTransactionDocumentNoFilter; GLEntryTransactionDocumentNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'G/L Trans. Document No. Filter';
                    ToolTip = 'Optionally filters G/L entries by document number.';
                }
                field(GLEntryOldTransactionNoFilter; GLEntryOldTransactionNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'G/L Old Transaction No. Filter';
                    ToolTip = 'Optionally filters G/L entries by the current transaction number.';
                }
                field(GLEntryTransactionPostingDateFilter; GLEntryTransactionPostingDateFilter)
                {
                    ApplicationArea = All;
                    Caption = 'G/L Trans. Posting Date Filter';
                    ToolTip = 'Optionally filters G/L entries by posting date, for example 010126..310126.';
                }
            }
            group(SavingsAccountDeletion)
            {
                Caption = 'Delete Wrongly Imported Savings Account';
                Visible = false;
                field(SavingsAccountNo; SavingsAccountNo)
                {
                    ApplicationArea = All;
                    Caption = 'Savings Account No.';
                    TableRelation = "Savings Accounts"."No.";
                    ToolTip = 'Specifies the wrongly imported savings account to delete.';

                    trigger OnValidate()
                    var
                        SavingsAccount: Record "Savings Accounts";
                    begin
                        Clear(SavingsAccountName);
                        if SavingsAccountNo = '' then
                            exit;

                        if SavingsAccount.Get(SavingsAccountNo) then
                            SavingsAccountName := SavingsAccount.Name;
                    end;
                }
                field(SavingsAccountName; SavingsAccountName)
                {
                    ApplicationArea = All;
                    Caption = 'Account Name';
                    Editable = false;
                    ToolTip = 'Shows the name of the selected savings account for confirmation.';
                }
            }
            group(FixedDepositLedgerRepair)
            {
                Caption = 'Fix Savings Ledger Entries To Fixed Deposit';
                field(FDLedgerSourceSavingsAccountNo; FDLedgerSourceSavingsAccountNo)
                {
                    ApplicationArea = All;
                    Caption = 'Source Savings Account No.';
                    TableRelation = "Savings Accounts"."No.";
                    ToolTip = 'Specifies the wrong savings account currently on the savings ledger entries.';

                    trigger OnValidate()
                    var
                        SavingsAccount: Record "Savings Accounts";
                    begin
                        Clear(FDLedgerSourceAccountName);
                        if FDLedgerSourceSavingsAccountNo = '' then
                            exit;

                        SavingsAccount.Get(FDLedgerSourceSavingsAccountNo);
                        FDLedgerSourceAccountName := SavingsAccount.Name;
                    end;
                }
                field(FDLedgerSourceAccountName; FDLedgerSourceAccountName)
                {
                    ApplicationArea = All;
                    Caption = 'Source Account Name';
                    Editable = false;
                    ToolTip = 'Shows the source savings account name.';
                }
                field(FDLedgerFixedDepositNo; FDLedgerFixedDepositNo)
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Deposit No.';
                    TableRelation = "Fixed Deposit Accounts"."No.";
                    ToolTip = 'Specifies the fixed deposit record whose fixed account should receive the selected ledger entries.';

                    trigger OnValidate()
                    begin
                        ResolveFixedDepositLedgerTarget();
                    end;
                }
                field(FDLedgerTargetFixedAccountNo; FDLedgerTargetFixedAccountNo)
                {
                    ApplicationArea = All;
                    Caption = 'Target Fixed Account No.';
                    Editable = true;
                    TableRelation = "Savings Accounts"."No." where("Product Category" = const("Fixed Deposit"));
                    ToolTip = 'Shows the fixed deposit savings account that will replace the source account on matching ledger entries.';
                }
                field(FDLedgerTargetAccountName; FDLedgerTargetAccountName)
                {
                    ApplicationArea = All;
                    Caption = 'Target Account Name';
                    Editable = false;
                    ToolTip = 'Shows the target fixed deposit account name.';
                }
                field(FDLedgerEntryNoFilter; FDLedgerEntryNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Entry No. Filter';
                    ToolTip = 'Optionally filters the savings ledger entries by entry number, for example 1000..1010 or 1000|1005.';
                }
                field(FDLedgerDocumentNoFilter; FDLedgerDocumentNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Document No. Filter';
                    ToolTip = 'Optionally filters the savings ledger entries by document number.';
                }
                field(FDLedgerPostingDateFilter; FDLedgerPostingDateFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date Filter';
                    ToolTip = 'Optionally filters the savings ledger entries by posting date, for example 010126..310126.';
                }
            }
            group(LoanDeletion)
            {
                Caption = 'Delete Wrongly Imported Loan';
                Visible = false;
                field(LoanNoToDelete; LoanNoToDelete)
                {
                    ApplicationArea = All;
                    Caption = 'Loan No.';
                    TableRelation = Loans."Loan No.";
                    ToolTip = 'Specifies the wrongly imported loan to delete.';

                    trigger OnValidate()
                    var
                        Loan: Record Loans;
                    begin
                        Clear(LoanMemberName);
                        if LoanNoToDelete = '' then
                            exit;

                        if Loan.Get(LoanNoToDelete) then
                            LoanMemberName := Loan."Member Name";
                    end;
                }
                field(LoanMemberName; LoanMemberName)
                {
                    ApplicationArea = All;
                    Caption = 'Member Name';
                    Editable = false;
                    ToolTip = 'Shows the member name on the selected loan for confirmation.';
                }
            }
            group(LoanSecurityDeletion)
            {
                Caption = 'Delete Selected Loan Security';
                Visible = true;
                field(LoanSecurityLoanNoToDelete; LoanSecurityLoanNoToDelete)
                {
                    ApplicationArea = All;
                    Caption = 'Loan No.';
                    TableRelation = Loans."Loan No.";
                    ToolTip = 'Specifies the loan whose selected loan security records will be deleted.';
                }
                field(LoanSecurityGuarantorTypeToDelete; LoanSecurityGuarantorTypeToDelete)
                {
                    ApplicationArea = All;
                    Caption = 'Guarantor Type';
                    ToolTip = 'Optionally filters the loan security records by guarantor type.';
                }
                field(LoanSecurityFilterByGuarantorType; LoanSecurityFilterByGuarantorType)
                {
                    ApplicationArea = All;
                    Caption = 'Filter by Guarantor Type';
                    ToolTip = 'Specifies whether the delete should be filtered by guarantor type.';
                }
                field(LoanSecurityMemberNoToDelete; LoanSecurityMemberNoToDelete)
                {
                    ApplicationArea = All;
                    Caption = 'Member No.';
                    TableRelation = Members."No.";
                    ToolTip = 'Optionally filters the loan security records by member number.';
                }
                field(LoanSecurityAccountNoToDelete; LoanSecurityAccountNoToDelete)
                {
                    ApplicationArea = All;
                    Caption = 'Account No.';
                    ToolTip = 'Optionally filters the loan security records by account number.';
                }
                field(LoanSecurityCollateralNoToDelete; LoanSecurityCollateralNoToDelete)
                {
                    ApplicationArea = All;
                    Caption = 'Collateral Reg. No.';
                    TableRelation = "Loan Collateral Register"."No.";
                    ToolTip = 'Optionally filters the loan security records by collateral registration number.';
                }
            }
            group(EmailLogDeletion)
            {
                Caption = 'Delete Email Log Entries';
                field(EmailLogLoanNoFilter; EmailLogLoanNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Loan No. Filter';
                    ToolTip = 'Filters email log entries by loan number.';
                }
                field(EmailLogLineFilter; EmailLogLineFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Line No. Filter';
                    ToolTip = 'Optionally filters email log entries by line number or a line-number filter expression.';
                }
                field(EmailLogSourceFilter; EmailLogSourceFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Source Filter';
                    ToolTip = 'Optionally filters email log entries by source, for example Loan Application or Guarantor.';
                }
            }

        }
    }


    actions
    {
        area(Processing)
        {
            action(UpdateJuneInsuranceDocumentNo)
            {
                Visible = false;
                ApplicationArea = All;
                Caption = 'Correct Jul 2026 Insurance Description';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Changes the description from Insurance Due Jun 2026 to Insurance Due Jul 2026 for credit and G/L entries posted with document number JUL 2026-INSURANCE.';

                trigger OnAction()
                var
                    CreditLedgerEntry: Record "Credit Ledger Entry";
                    GLEntry: Record "G/L Entry";
                    UpdatedCreditEntries: Integer;
                    UpdatedGLEntries: Integer;
                    NewDocumentNo: Code[20];
                    SourceDescription: Text[100];
                    TargetDescription: Text[100];
                begin
                    SourceDescription := 'Insurance Due Jun 2026';
                    TargetDescription := 'Insurance Due Jul 2026';
                    NewDocumentNo := 'JUL 2026-INSURANCE';

                    CreditLedgerEntry.Reset();
                    CreditLedgerEntry.SetRange("Document No.", NewDocumentNo);
                    CreditLedgerEntry.SetRange(Description, SourceDescription);
                    if CreditLedgerEntry.IsEmpty() then begin
                        Message('No credit ledger entries require correction.');
                        exit;
                    end;

                    if not Confirm(
                        'Change the description from "%1" to "%2" for %3 credit ledger entry/entries with document number %4 and their corresponding G/L entries?',
                        false,
                        SourceDescription,
                        TargetDescription,
                        CreditLedgerEntry.Count(),
                        NewDocumentNo)
                    then
                        exit;

                    if CreditLedgerEntry.FindSet(true) then
                        repeat
                            GLEntry.Reset();
                            GLEntry.SetRange("Transaction No.", CreditLedgerEntry."Transaction No.");
                            if GLEntry.IsEmpty() then
                                Error(
                                    'No corresponding G/L entry was found for credit ledger entry %1, transaction %2. Nothing was changed.',
                                    CreditLedgerEntry."Entry No.",
                                    CreditLedgerEntry."Transaction No.");

                            if GLEntry.FindSet(true) then
                                repeat
                                    if (GLEntry."Document No." = NewDocumentNo) and (GLEntry.Description = SourceDescription) then begin
                                        GLEntry.Description := TargetDescription;
                                        GLEntry.Modify();
                                        UpdatedGLEntries += 1;
                                    end;
                                until GLEntry.Next() = 0;

                            CreditLedgerEntry.Description := TargetDescription;
                            CreditLedgerEntry.Modify();
                            UpdatedCreditEntries += 1;
                        until CreditLedgerEntry.Next() = 0;

                    Message(
                        'Insurance description correction completed. Updated %1 credit ledger entry/entries and %2 G/L entry/entries.',
                        UpdatedCreditEntries,
                        UpdatedGLEntries);
                end;
            }

            action(UpdateSavingsLedgerToFixedDepositAccount)
            {
                ApplicationArea = All;
                Caption = 'Move Savings Ledger Entries To Fixed Deposit';
                Image = Change;
                Promoted = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Updates selected savings ledger entries from the wrong savings account to the fixed deposit account selected on the card.';

                trigger OnAction()
                var
                    SavingsLedgerEntry: Record "Savings Ledger Entry";
                    SourceSavingsAccount: Record "Savings Accounts";
                    TargetSavingsAccount: Record "Savings Accounts";
                    EntriesToUpdate: Integer;
                    UpdatedEntries: Integer;
                begin
                    FDLedgerSourceSavingsAccountNo := DelChr(FDLedgerSourceSavingsAccountNo, '<>');
                    FDLedgerFixedDepositNo := DelChr(FDLedgerFixedDepositNo, '<>');
                    FDLedgerEntryNoFilter := DelChr(FDLedgerEntryNoFilter, '<>');
                    FDLedgerDocumentNoFilter := DelChr(FDLedgerDocumentNoFilter, '<>');
                    FDLedgerPostingDateFilter := DelChr(FDLedgerPostingDateFilter, '<>');

                    if FDLedgerSourceSavingsAccountNo = '' then
                        Error('Enter the source savings account number.');
                    if FDLedgerFixedDepositNo = '' then
                        Error('Enter the fixed deposit number.');
                    if (FDLedgerEntryNoFilter = '') and (FDLedgerDocumentNoFilter = '') and (FDLedgerPostingDateFilter = '') then
                        Error('Enter at least one selective filter: Entry No. Filter, Document No. Filter, or Posting Date Filter.');

                    SourceSavingsAccount.Get(FDLedgerSourceSavingsAccountNo);
                    ResolveFixedDepositLedgerTarget();
                    TargetSavingsAccount.Get(FDLedgerTargetFixedAccountNo);
                    TargetSavingsAccount.TestField("Product Category", TargetSavingsAccount."Product Category"::"Fixed Deposit");

                    if SourceSavingsAccount."Member No." <> TargetSavingsAccount."Member No." then
                        Error(
                            'The source account %1 belongs to member %2, but fixed account %3 belongs to member %4.',
                            SourceSavingsAccount."No.",
                            SourceSavingsAccount."Member No.",
                            TargetSavingsAccount."No.",
                            TargetSavingsAccount."Member No.");

                    SavingsLedgerEntry.Reset();
                    SavingsLedgerEntry.SetRange("Account No.", SourceSavingsAccount."No.");
                    SavingsLedgerEntry.SetRange(Reversed, false);
                    if FDLedgerEntryNoFilter <> '' then
                        SavingsLedgerEntry.SetFilter("Entry No.", FDLedgerEntryNoFilter);
                    if FDLedgerDocumentNoFilter <> '' then
                        SavingsLedgerEntry.SetFilter("Document No.", FDLedgerDocumentNoFilter);
                    if FDLedgerPostingDateFilter <> '' then
                        SavingsLedgerEntry.SetFilter("Posting Date", FDLedgerPostingDateFilter);

                    EntriesToUpdate := SavingsLedgerEntry.Count();
                    if EntriesToUpdate = 0 then
                        Error('No unreversed savings ledger entries matched the selected filters.');

                    if not Confirm(
                        'Update %1 savings ledger entry/entries from account %2 to fixed deposit account %3?',
                        false,
                        EntriesToUpdate,
                        SourceSavingsAccount."No.",
                        TargetSavingsAccount."No.")
                    then
                        exit;

                    if SavingsLedgerEntry.FindSet(true) then
                        repeat
                            SavingsLedgerEntry."Account No." := TargetSavingsAccount."No.";
                            SavingsLedgerEntry."Customer Name" := TargetSavingsAccount.Name;
                            SavingsLedgerEntry."Member No." := TargetSavingsAccount."Member No.";
                            SavingsLedgerEntry."Customer Posting Group" := TargetSavingsAccount."Customer Posting Group";
                            SavingsLedgerEntry."Global Dimension 1 Code" := TargetSavingsAccount."Global Dimension 1 Code";
                            SavingsLedgerEntry."Global Dimension 2 Code" := TargetSavingsAccount."Global Dimension 2 Code";
                            SavingsLedgerEntry.Modify();
                            UpdatedEntries += 1;
                        until SavingsLedgerEntry.Next() = 0;

                    Message(
                        'Savings ledger repair completed. Updated %1 entry/entries from %2 to fixed deposit account %3.',
                        UpdatedEntries,
                        SourceSavingsAccount."No.",
                        TargetSavingsAccount."No.");
                end;
            }

            action(RemoveBank008DescriptionPrefix)
            {
                ApplicationArea = All;
                Caption = 'Remove Bank Code From Ledger Descriptions';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Removes the selected leading bank code prefix from descriptions in savings ledger, bank ledger, credit ledger, and G/L entries.';

                trigger OnAction()
                var
                    BankAccount: Record "Bank Account";
                    SavingsLedgerEntry: Record "Savings Ledger Entry";
                    BankLedgerEntry: Record "Bank Account Ledger Entry";
                    CreditLedgerEntry: Record "Credit Ledger Entry";
                    GLEntry: Record "G/L Entry";
                    BankCode: Code[20];
                    PrefixToRemove: Text[30];
                    UpdatedSavingsEntries: Integer;
                    UpdatedBankEntries: Integer;
                    UpdatedCreditEntries: Integer;
                    UpdatedGLEntries: Integer;
                    ProcessedBanks: Integer;
                begin
                    if not Confirm(
                        'Remove leading bank-code prefixes from descriptions in Savings Ledger Entries, Bank Account Ledger Entries, Credit Ledger Entries, and G/L Entries? Leave Bank Code to Clean blank to loop through all bank accounts.',
                        false)
                    then
                        exit;

                    BankAccount.Reset();
                    if BankCodeToClean <> '' then
                        BankAccount.SetRange("No.", BankCodeToClean);

                    if BankAccount.FindSet() then
                        repeat
                            BankCode := BankAccount."No.";
                            PrefixToRemove := Format(BankCode);
                            if CopyStr(PrefixToRemove, StrLen(PrefixToRemove), 1) <> ':' then
                                PrefixToRemove += ':';

                            ProcessedBanks += 1;

                            SavingsLedgerEntry.Reset();
                            SavingsLedgerEntry.SetFilter(Description, '%1', PrefixToRemove + '*');
                            if SavingsLedgerEntry.FindSet(true) then
                                repeat
                                    SavingsLedgerEntry.Description := CopyStr(DelStr(SavingsLedgerEntry.Description, 1, StrLen(PrefixToRemove)), 1, MaxStrLen(SavingsLedgerEntry.Description));
                                    SavingsLedgerEntry.Modify();
                                    UpdatedSavingsEntries += 1;
                                until SavingsLedgerEntry.Next() = 0;

                            BankLedgerEntry.Reset();
                            BankLedgerEntry.SetRange("Bank Account No.", BankCode);
                            BankLedgerEntry.SetFilter(Description, '%1', PrefixToRemove + '*');
                            if BankLedgerEntry.FindSet(true) then
                                repeat
                                    BankLedgerEntry.Description := CopyStr(DelStr(BankLedgerEntry.Description, 1, StrLen(PrefixToRemove)), 1, MaxStrLen(BankLedgerEntry.Description));
                                    BankLedgerEntry.Modify();
                                    UpdatedBankEntries += 1;
                                until BankLedgerEntry.Next() = 0;

                            CreditLedgerEntry.Reset();
                            CreditLedgerEntry.SetFilter(Description, '%1', PrefixToRemove + '*');
                            if CreditLedgerEntry.FindSet(true) then
                                repeat
                                    CreditLedgerEntry.Description := CopyStr(DelStr(CreditLedgerEntry.Description, 1, StrLen(PrefixToRemove)), 1, MaxStrLen(CreditLedgerEntry.Description));
                                    CreditLedgerEntry.Modify();
                                    UpdatedCreditEntries += 1;
                                until CreditLedgerEntry.Next() = 0;

                            GLEntry.Reset();
                            GLEntry.SetFilter(Description, '%1', PrefixToRemove + '*');
                            if GLEntry.FindSet(true) then
                                repeat
                                    GLEntry.Description := CopyStr(DelStr(GLEntry.Description, 1, StrLen(PrefixToRemove)), 1, MaxStrLen(GLEntry.Description));
                                    GLEntry.Modify();
                                    UpdatedGLEntries += 1;
                                until GLEntry.Next() = 0;
                        until BankAccount.Next() = 0;

                    Message(
                        'Bank-code description cleanup completed for %1 bank account(s).\Savings Ledger Entries: %2\Bank Account Ledger Entries: %3\Credit Ledger Entries: %4\G/L Entries: %5',
                        ProcessedBanks,
                        UpdatedSavingsEntries,
                        UpdatedBankEntries,
                        UpdatedCreditEntries,
                        UpdatedGLEntries);
                end;
            }

            action(MarkBankLedgerEntriesReconciledToJune2026)
            {
                ApplicationArea = All;
                Caption = 'Mark Bank Ledger Reconciled To Jun 2026';
                Image = ApplyEntries;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Marks open, non-reversed bank account ledger entries posted on or before 30 June 2026 as reconciled/closed.';

                trigger OnAction()
                var
                    BankLedgerEntry: Record "Bank Account Ledger Entry";
                    CutoffDate: Date;
                    EntriesToUpdate: Integer;
                    UpdatedEntries: Integer;
                begin
                    CutoffDate := DMY2Date(30, 6, 2026);

                    BankLedgerEntry.Reset();
                    BankLedgerEntry.SetRange(Open, true);
                    BankLedgerEntry.SetRange(Reversed, false);
                    BankLedgerEntry.SetFilter("Posting Date", '..%1', CutoffDate);
                    BankLedgerEntry.SetFilter("Statement Status", '%1|%2|%3',
                        BankLedgerEntry."Statement Status"::Open,
                        BankLedgerEntry."Statement Status"::"Bank Acc. Entry Applied",
                        BankLedgerEntry."Statement Status"::"Check Entry Applied");

                    EntriesToUpdate := BankLedgerEntry.Count();
                    if EntriesToUpdate = 0 then begin
                        Message('No open bank ledger entries up to %1 require reconciliation.', CutoffDate);
                        exit;
                    end;

                    if not Confirm(
                        'Mark %1 open, non-reversed bank account ledger entry/entries posted on or before %2 as reconciled/closed?',
                        false,
                        EntriesToUpdate,
                        CutoffDate)
                    then
                        exit;

                    if BankLedgerEntry.FindSet(true) then
                        repeat
                            BankLedgerEntry.Open := false;
                            BankLedgerEntry."Remaining Amount" := 0;
                            BankLedgerEntry."Statement Status" := BankLedgerEntry."Statement Status"::Closed;
                            BankLedgerEntry."Statement Difference" := 0;
                            BankLedgerEntry.Modify(true);
                            UpdatedEntries += 1;
                        until BankLedgerEntry.Next() = 0;

                    Message(
                        'Bank ledger reconciliation cleanup completed. Marked %1 entry/entries posted on or before %2 as reconciled/closed.',
                        UpdatedEntries,
                        CutoffDate);
                end;
            }

            action(ReopenSpecificBankLedgerEntry)
            {
                ApplicationArea = All;
                Caption = 'Reopen Bank Ledger Entry';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Reopens a specific bank account ledger entry that was marked as reconciled.';

                trigger OnAction()
                var
                    BankLedgerEntry: Record "Bank Account Ledger Entry";
                begin
                    if BankLedgerReopenEntryNo = 0 then
                        Error('Enter the Bank Ledger Reopen Entry No.');

                    BankLedgerEntry.Get(BankLedgerReopenEntryNo);
                    if BankLedgerReopenBankAccountNo <> '' then
                        if BankLedgerEntry."Bank Account No." <> BankLedgerReopenBankAccountNo then
                            Error(
                                'Bank ledger entry %1 belongs to bank account %2, not %3.',
                                BankLedgerEntry."Entry No.",
                                BankLedgerEntry."Bank Account No.",
                                BankLedgerReopenBankAccountNo);

                    if not Confirm(
                        'Reopen bank ledger entry %1 for bank account %2, document %3, amount %4? This will clear the bank reconciliation statement link.',
                        false,
                        BankLedgerEntry."Entry No.",
                        BankLedgerEntry."Bank Account No.",
                        BankLedgerEntry."Document No.",
                        BankLedgerEntry.Amount)
                    then
                        exit;

                    BankLedgerEntry.Open := true;
                    BankLedgerEntry."Remaining Amount" := BankLedgerEntry.Amount;
                    BankLedgerEntry."Statement Status" := BankLedgerEntry."Statement Status"::Open;
                    BankLedgerEntry."Statement No." := '';
                    BankLedgerEntry."Statement Line No." := 0;
                    BankLedgerEntry."Statement Difference" := BankLedgerEntry.Amount;
                    BankLedgerEntry.Modify(true);

                    Message('Bank ledger entry %1 has been reopened.', BankLedgerEntry."Entry No.");
                end;
            }

            action(UpdateLedgerReversedStatus)
            {
                ApplicationArea = All;
                Caption = 'Mark/Unmark G/L Entry Reversed';
                Image = ReverseLines;
                Promoted = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Marks or unmarks the Reversed field on selected G/L entries using the filters entered on the card.';

                trigger OnAction()
                var
                    EntriesToUpdate: Integer;
                    VendorEntriesToUpdate: Integer;
                    DetailedVendorEntriesToUpdate: Integer;
                    UpdatedEntries: Integer;
                    UpdatedVendorEntries: Integer;
                    UpdatedDetailedVendorEntries: Integer;
                begin
                    NormalizeLedgerReversalFilters();

                    if not LedgerReversalHasSelectiveFilter() then
                        Error('Enter at least one selective filter: Entry No., Document No., External Document No., Transaction No., or Posting Date.');

                    EntriesToUpdate := CountLedgerReversalEntries();
                    if EntriesToUpdate = 0 then
                        Error('No G/L Entry records matched the selected filters.');

                    CountVendorLedgerEntriesFromMatchedGLEntries(VendorEntriesToUpdate, DetailedVendorEntriesToUpdate);

                    if not Confirm(
                        'Set Reversed = %1 on %2 G/L Entry record(s)%3?',
                        false,
                        Format(LedgerReversalNewValue),
                        EntriesToUpdate,
                        GetVendorLedgerReversalConfirmText(VendorEntriesToUpdate, DetailedVendorEntriesToUpdate))
                    then
                        exit;

                    UpdatedEntries := ApplyLedgerReversedStatus();
                    UpdateVendorLedgerEntriesFromMatchedGLEntries(UpdatedVendorEntries, UpdatedDetailedVendorEntries);

                    Message(
                        'G/L Entry reversed-status update completed.\Reversed value: %1\G/L Entries updated: %2\Vendor Ledger Entries updated by Document No.: %3\Detailed Vendor Ledger Entries marked/unmarked by Document No.: %4',
                        Format(LedgerReversalNewValue),
                        UpdatedEntries,
                        UpdatedVendorEntries,
                        UpdatedDetailedVendorEntries);
                end;
            }

            action(UpdateVendorLedgerOpenStatus)
            {
                ApplicationArea = All;
                Caption = 'Mark Vendor Ledger Open/Closed';
                Image = ApplyEntries;
                Promoted = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Marks selected vendor ledger entries as open or closed using the filters entered on the card.';

                trigger OnAction()
                var
                    EntriesToUpdate: Integer;
                    UpdatedEntries: Integer;
                begin
                    NormalizeVendorLedgerOpenFilters();

                    if not VendorLedgerOpenHasSelectiveFilter() then
                        Error('Enter at least one selective vendor ledger filter: Entry No., Document No., Vendor No., External Document No., Transaction No., or Posting Date.');

                    EntriesToUpdate := CountVendorLedgerOpenEntries();
                    if EntriesToUpdate = 0 then
                        Error('No Vendor Ledger Entry records matched the selected filters.');

                    if not Confirm(
                        'Set Open = %1 on %2 Vendor Ledger Entry record(s) using the selected filters?',
                        false,
                        Format(VendorLedgerOpenNewValue),
                        EntriesToUpdate)
                    then
                        exit;

                    UpdatedEntries := ApplyVendorLedgerOpenStatus();

                    Message(
                        'Vendor Ledger Entry open-status update completed.\Open value: %1\Entries updated: %2',
                        Format(VendorLedgerOpenNewValue),
                        UpdatedEntries);
                end;
            }

            action(UpdateGLEntryTransactionNo)
            {
                ApplicationArea = All;
                Caption = 'Update G/L Entry Transaction No.';
                Image = Change;
                Promoted = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Updates the transaction number on selected imported G/L entries using the filters entered on the card.';

                trigger OnAction()
                var
                    EntriesToUpdate: Integer;
                    UpdatedEntries: Integer;
                begin
                    NormalizeGLEntryTransactionNoFilters();

                    if GLEntryNewTransactionNo = 0 then
                        Error('Enter the new G/L transaction number before running the update.');

                    if not GLEntryTransactionNoHasSelectiveFilter() then
                        Error('Enter at least one selective G/L filter: Entry No., Document No., Old Transaction No., or Posting Date.');

                    EntriesToUpdate := CountGLEntryTransactionNoEntries();
                    if EntriesToUpdate = 0 then
                        Error('No G/L Entry records matched the selected transaction-number filters.');

                    if not Confirm(
                        'Set Transaction No. = %1 on %2 G/L Entry record(s) using the selected filters?',
                        false,
                        GLEntryNewTransactionNo,
                        EntriesToUpdate)
                    then
                        exit;

                    UpdatedEntries := ApplyGLEntryTransactionNo();

                    Message(
                        'G/L Entry transaction-number update completed.\New Transaction No.: %1\Entries updated: %2',
                        GLEntryNewTransactionNo,
                        UpdatedEntries);
                end;
            }

            action(RepairBankLedgerAmountFromRemainingAmount)
            {
                ApplicationArea = All;
                Caption = 'Repair Bank Ledger Amount From Remaining';
                Image = Restore;
                Promoted = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Repairs bank account ledger entries whose Amount was overwritten by many-to-one matching by restoring Amount from Remaining Amount.';

                trigger OnAction()
                var
                    BankLedgerEntry: Record "Bank Account Ledger Entry";
                    EntriesToUpdate: Integer;
                    UpdatedEntries: Integer;
                begin
                    BankLedgerRepairBankAccountNo := DelChr(BankLedgerRepairBankAccountNo, '<>');
                    BankLedgerRepairExternalDocNo := DelChr(BankLedgerRepairExternalDocNo, '<>');
                    BankLedgerRepairEntryNoFilter := DelChr(BankLedgerRepairEntryNoFilter, '<>');
                    BankLedgerRepairPostingDateFilter := DelChr(BankLedgerRepairPostingDateFilter, '<>');

                    if (BankLedgerRepairExternalDocNo = '') and (BankLedgerRepairEntryNoFilter = '') then
                        Error('Enter Bank Ledger Repair External Doc. No. or Bank Ledger Repair Entry No. Filter before running the repair.');

                    BankLedgerEntry.Reset();
                    BankLedgerEntry.SetRange(Reversed, false);
                    BankLedgerEntry.SetFilter("Remaining Amount", '<>%1', 0);
                    BankLedgerEntry.SetFilter(Amount, '<>%1', 0);
                    if BankLedgerRepairBankAccountNo <> '' then
                        BankLedgerEntry.SetRange("Bank Account No.", BankLedgerRepairBankAccountNo);
                    if BankLedgerRepairExternalDocNo <> '' then
                        BankLedgerEntry.SetRange("External Document No.", BankLedgerRepairExternalDocNo);
                    if BankLedgerRepairEntryNoFilter <> '' then
                        BankLedgerEntry.SetFilter("Entry No.", BankLedgerRepairEntryNoFilter);
                    if BankLedgerRepairPostingDateFilter <> '' then
                        BankLedgerEntry.SetFilter("Posting Date", BankLedgerRepairPostingDateFilter);

                    EntriesToUpdate := CountBankLedgerEntriesWithDifferentAmountAndRemainingAmount(BankLedgerEntry);
                    if EntriesToUpdate = 0 then begin
                        Message('No bank account ledger entries were found where Amount differs from Remaining Amount.');
                        exit;
                    end;

                    if not Confirm(
                        'Repair %1 bank account ledger entry/entries by setting Amount, Amount (LCY), Debit Amount, and Credit Amount from Remaining Amount?',
                        false,
                        EntriesToUpdate)
                    then
                        exit;

                    if BankLedgerEntry.FindSet(true) then
                        repeat
                            if not AmountsAreEqual(BankLedgerEntry.Amount, BankLedgerEntry."Remaining Amount") then begin
                                BankLedgerEntry.Amount := BankLedgerEntry."Remaining Amount";
                                BankLedgerEntry."Amount (LCY)" := BankLedgerEntry."Remaining Amount";
                                if BankLedgerEntry.Amount >= 0 then begin
                                    BankLedgerEntry."Debit Amount" := BankLedgerEntry.Amount;
                                    BankLedgerEntry."Credit Amount" := 0;
                                    BankLedgerEntry."Debit Amount (LCY)" := BankLedgerEntry.Amount;
                                    BankLedgerEntry."Credit Amount (LCY)" := 0;
                                end else begin
                                    BankLedgerEntry."Debit Amount" := 0;
                                    BankLedgerEntry."Credit Amount" := -BankLedgerEntry.Amount;
                                    BankLedgerEntry."Debit Amount (LCY)" := 0;
                                    BankLedgerEntry."Credit Amount (LCY)" := -BankLedgerEntry.Amount;
                                end;
                                BankLedgerEntry.Modify(false);
                                UpdatedEntries += 1;
                            end;
                        until BankLedgerEntry.Next() = 0;

                    Message('Bank ledger amount repair completed. Updated %1 entry/entries.', UpdatedEntries);
                end;
            }

            action(UpdateSkyPostedLedgerDatesFromTransactionDate)
            {
                ApplicationArea = All;
                Caption = 'Correct Sky Posted Ledger Dates';
                Image = ChangeDates;
                Promoted = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Updates Sky M-Banking posting dates and related credit, savings, G/L, and bank ledger posting dates to match the Sky transaction date.';

                trigger OnAction()
                var
                    SkyTrans: Record "Sky M-Banking Transactions";
                    CreditLedgerEntry: Record "Credit Ledger Entry";
                    SavingsLedgerEntry: Record "Savings Ledger Entry";
                    GLEntry: Record "G/L Entry";
                    BankLedgerEntry: Record "Bank Account Ledger Entry";
                    DocumentNo: Code[20];
                    CorrectPostingDate: Date;
                    TransactionsToUpdate: Integer;
                    UpdatedSkyTransactions: Integer;
                    UpdatedCreditEntries: Integer;
                    UpdatedSavingsEntries: Integer;
                    UpdatedGLEntries: Integer;
                    UpdatedBankEntries: Integer;
                begin
                    SkyTrans.Reset();
                    SkyTrans.SetRange(Posted, true);
                    SkyTrans.SetFilter("Transaction Date", '<>%1', 0D);
                    if SkyTrans.FindSet() then
                        repeat
                            if IsAllowedSkyPostingDateCorrectionTransaction(SkyTrans."Transaction ID") /* and (SkyTrans."Posting Date" <> SkyTrans."Transaction Date") */ then
                                TransactionsToUpdate += 1;
                        until SkyTrans.Next() = 0;

                    if TransactionsToUpdate = 0 then begin
                        Message('No whitelisted posted Sky M-Banking transactions have a posting date different from the transaction date.');
                        exit;
                    end;

                    if not Confirm(
                        'Correct posting dates for %1 whitelisted posted Sky M-Banking transaction(s) and their related Credit Ledger, Savings Ledger, G/L Entry, and Bank Account Ledger entries? The new posting date will be each Sky transaction date.',
                        false,
                        TransactionsToUpdate)
                    then
                        exit;

                    SkyTrans.Reset();
                    SkyTrans.SetRange(Posted, true);
                    SkyTrans.SetFilter("Transaction Date", '<>%1', 0D);
                    if SkyTrans.FindSet(true) then
                        repeat
                            if IsAllowedSkyPostingDateCorrectionTransaction(SkyTrans."Transaction ID") /* and (SkyTrans."Posting Date" <> SkyTrans."Transaction Date") */ then begin
                                CorrectPostingDate := SkyTrans."Transaction Date";
                                DocumentNo := CopyStr(SkyTrans."Transaction ID", 1, MaxStrLen(DocumentNo));

                                CreditLedgerEntry.Reset();
                                CreditLedgerEntry.SetRange("Document No.", DocumentNo);
                                CreditLedgerEntry.SetFilter("Posting Date", '<>%1', CorrectPostingDate);
                                if CreditLedgerEntry.FindSet(true) then
                                    repeat
                                        CreditLedgerEntry."Posting Date" := CorrectPostingDate;
                                        CreditLedgerEntry.Modify();
                                        UpdatedCreditEntries += 1;
                                    until CreditLedgerEntry.Next() = 0;

                                SavingsLedgerEntry.Reset();
                                SavingsLedgerEntry.SetRange("Document No.", DocumentNo);
                                SavingsLedgerEntry.SetFilter("Posting Date", '<>%1', CorrectPostingDate);
                                if SavingsLedgerEntry.FindSet(true) then
                                    repeat
                                        SavingsLedgerEntry."Posting Date" := CorrectPostingDate;
                                        SavingsLedgerEntry.Modify();
                                        UpdatedSavingsEntries += 1;
                                    until SavingsLedgerEntry.Next() = 0;

                                GLEntry.Reset();
                                GLEntry.SetRange("Document No.", DocumentNo);
                                GLEntry.SetFilter("Posting Date", '<>%1', CorrectPostingDate);
                                if GLEntry.FindSet(true) then
                                    repeat
                                        GLEntry."Posting Date" := CorrectPostingDate;
                                        GLEntry.Modify();
                                        UpdatedGLEntries += 1;
                                    until GLEntry.Next() = 0;

                                BankLedgerEntry.Reset();
                                BankLedgerEntry.SetRange("Document No.", DocumentNo);
                                BankLedgerEntry.SetFilter("Posting Date", '<>%1', CorrectPostingDate);
                                if BankLedgerEntry.FindSet(true) then
                                    repeat
                                        BankLedgerEntry."Posting Date" := CorrectPostingDate;
                                        BankLedgerEntry.Modify();
                                        UpdatedBankEntries += 1;
                                    until BankLedgerEntry.Next() = 0;

                                SkyTrans."Posting Date" := CorrectPostingDate;
                                SkyTrans.Modify();
                                UpdatedSkyTransactions += 1;
                            end;
                        until SkyTrans.Next() = 0;

                    Message(
                        'Sky posting date correction completed.\Sky M-Banking Transactions: %1\Credit Ledger Entries: %2\Savings Ledger Entries: %3\G/L Entries: %4\Bank Account Ledger Entries: %5',
                        UpdatedSkyTransactions,
                        UpdatedCreditEntries,
                        UpdatedSavingsEntries,
                        UpdatedGLEntries,
                        UpdatedBankEntries);
                end;
            }

            action(DeleteSelectedSavingsAccount)
            {
                ApplicationArea = All;
                Caption = 'Delete Savings Account';
                Image = Delete;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category10;
                PromotedIsBig = true;
                ToolTip = 'Permanently deletes the selected wrongly imported savings account after confirmation.';

                trigger OnAction()
                var
                    SavingsAccount: Record "Savings Accounts";
                    SavingsLedgerEntry: Record "Savings Ledger Entry";
                begin
                    if SavingsAccountNo = '' then
                        Error('Enter the savings account number to delete.');

                    if not SavingsAccount.Get(SavingsAccountNo) then
                        Error('Savings account %1 does not exist.', SavingsAccountNo);

                    SavingsLedgerEntry.SetRange("Account No.", SavingsAccountNo);
                    if not SavingsLedgerEntry.IsEmpty() then
                        Error(
                            'Savings account %1 cannot be deleted because it has savings ledger entries.',
                            SavingsAccountNo);

                    if not Confirm(
                        'Permanently delete savings account %1 (%2)? This action cannot be undone.',
                        false,
                        SavingsAccount."No.",
                        SavingsAccount.Name)
                    then
                        exit;

                    SavingsAccount.Delete(true);
                    Message('Savings account %1 was deleted.', SavingsAccountNo);
                    Clear(SavingsAccountNo);
                    Clear(SavingsAccountName);
                    CurrPage.Update(false);
                end;
            }

            action(DeleteSelectedLoan)
            {
                ApplicationArea = All;
                Caption = 'Delete Loan';
                Image = Delete;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category10;
                PromotedIsBig = true;
                ToolTip = 'Permanently deletes the selected wrongly imported loan after confirmation.';

                trigger OnAction()
                var
                    Loan: Record Loans;
                    CreditLedgerEntry: Record "Credit Ledger Entry";
                begin
                    if LoanNoToDelete = '' then
                        Error('Enter the loan number to delete.');

                    if not Loan.Get(LoanNoToDelete) then
                        Error('Loan %1 does not exist.', LoanNoToDelete);

                    CreditLedgerEntry.SetRange("Loan No.", LoanNoToDelete);
                    if not CreditLedgerEntry.IsEmpty() then
                        Error(
                            'Loan %1 cannot be deleted because it has credit ledger entries.',
                            LoanNoToDelete);

                    if not Confirm(
                        'Permanently delete loan %1 for %2? This action cannot be undone.',
                        false,
                        Loan."Loan No.",
                        Loan."Member Name")
                    then
                        exit;

                    Loan.Delete(true);
                    Message('Loan %1 was deleted.', LoanNoToDelete);
                    Clear(LoanNoToDelete);
                    Clear(LoanMemberName);
                    CurrPage.Update(false);
                end;
            }

            action(DeleteNomineesAndNextOfKin)
            {
                ApplicationArea = Basic;
                Caption = 'Delete Nominees and Next of Kin';
                Image = Delete;
                Promoted = true;
                visible = false;
                PromotedCategory = Category10;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Nominee: Record Nominee;
                    NextOfKin: Record "Next of Kin.";
                    NomineeCount: Integer;
                    NextOfKinCount: Integer;
                begin
                    NomineeCount := Nominee.Count();
                    NextOfKinCount := NextOfKin.Count();

                    if (NomineeCount = 0) and (NextOfKinCount = 0) then begin
                        Message('No Nominee or Next of Kin records found to delete.');
                        exit;
                    end;

                    if not Confirm(
                        'This will permanently delete %1 Nominee record(s) and %2 Next of Kin record(s). Continue?',
                        false,
                        NomineeCount,
                        NextOfKinCount)
                    then
                        exit;

                    if NomineeCount > 0 then begin
                        Nominee.Reset();
                        Nominee.DeleteAll(true);
                    end;

                    if NextOfKinCount > 0 then begin
                        NextOfKin.Reset();
                        NextOfKin.DeleteAll(true);
                    end;

                    Message('Deleted %1 Nominee record(s) and %2 Next of Kin record(s).', NomineeCount, NextOfKinCount);
                end;
            }

            action(DeleteBlankLoanSecurityCollateralLien)
            {
                ApplicationArea = All;
                Caption = 'Delete Blank Loan Security Collateral/Lien';
                Image = Delete;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Deletes loan security collateral and lien records where both member number and account number are blank.';

                trigger OnAction()
                var
                    LoanSecurity: Record "Loan Security";
                    DeletedCollateralCount: Integer;
                    DeletedLienCount: Integer;
                    TotalToDelete: Integer;
                begin
                    LoanSecurity.Reset();
                    LoanSecurity.SetRange("Member No", '');
                    LoanSecurity.SetRange("Account No.", '');
                    LoanSecurity.SetFilter("Guarantor Type", '%1|%2', LoanSecurity."Guarantor Type"::Collateral, LoanSecurity."Guarantor Type"::Lien);
                    TotalToDelete := LoanSecurity.Count();

                    if TotalToDelete = 0 then begin
                        Message('No blank collateral/lien loan security records were found.');
                        exit;
                    end;

                    if not Confirm(
                        'Delete %1 loan security collateral/lien record(s) where Member No and Account No are blank?',
                        false,
                        TotalToDelete)
                    then
                        exit;

                    if LoanSecurity.FindSet(true) then
                        repeat
                            case LoanSecurity."Guarantor Type" of
                                LoanSecurity."Guarantor Type"::Collateral:
                                    DeletedCollateralCount += 1;
                                LoanSecurity."Guarantor Type"::Lien:
                                    DeletedLienCount += 1;
                            end;
                            LoanSecurity.Delete();
                        until LoanSecurity.Next() = 0;

                    Message(
                        'Deleted %1 blank loan security record(s): %2 collateral and %3 lien.',
                        DeletedCollateralCount + DeletedLienCount,
                        DeletedCollateralCount,
                        DeletedLienCount);
                end;
            }

            action(DeleteSelectedLoanSecurity)
            {
                ApplicationArea = All;
                Caption = 'Delete Selected Loan Security';
                Image = Delete;
                Promoted = true;
                Visible = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Deletes selected loan security records for a specific loan after confirmation.';

                trigger OnAction()
                var
                    LoanSecurity: Record "Loan Security";
                    TotalToDelete: Integer;
                begin
                    if LoanSecurityLoanNoToDelete = '' then
                        Error('Enter the loan number whose loan security records should be deleted.');

                    ApplyLoanSecurityDeleteFilters(LoanSecurity);
                    TotalToDelete := LoanSecurity.Count();
                    if TotalToDelete = 0 then begin
                        Message('No loan security records were found for the selected filters.');
                        exit;
                    end;

                    if not Confirm(
                        'Delete %1 loan security record(s) for loan %2? This action cannot be undone.',
                        false,
                        TotalToDelete,
                        LoanSecurityLoanNoToDelete)
                    then
                        exit;

                    LoanSecurity.DeleteAll(true);
                    Message('Deleted %1 loan security record(s) for loan %2.', TotalToDelete, LoanSecurityLoanNoToDelete);
                end;
            }

            action(DeleteFixedDepositAccounts)
            {
                ApplicationArea = All;
                Caption = 'Delete Fixed Deposit Accounts';
                Image = Delete;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Deletes all records from the Fixed Deposit Accounts table after confirmation.';

                trigger OnAction()
                var
                    FixedDepositAccount: Record "Fixed Deposit Accounts";
                    TotalToDelete: Integer;
                begin
                    FixedDepositAccount.Reset();
                    TotalToDelete := FixedDepositAccount.Count();

                    if TotalToDelete = 0 then begin
                        Message('No fixed deposit account records were found to delete.');
                        exit;
                    end;

                    if not Confirm(
                        'This will permanently delete %1 Fixed Deposit Accounts record(s). Continue?',
                        false,
                        TotalToDelete)
                    then
                        exit;

                    FixedDepositAccount.DeleteAll(true);

                    Message('Deleted %1 Fixed Deposit Accounts record(s).', TotalToDelete);
                end;
            }

            action(UpdateLoanDepositInsuranceFromSchedule)
            {
                ApplicationArea = All;
                Caption = 'Update Loan Deposit/Insurance From Schedule';
                Image = UpdateDescription;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Checks loan repayment schedules and updates the loan Deposit Contribution and Total Insurance from the first non-zero schedule amounts.';

                trigger OnAction()
                var
                    Loan: Record Loans;
                    Window: Dialog;
                    DepositAmount: Decimal;
                    InsuranceAmount: Decimal;
                    FoundDeposit: Boolean;
                    FoundInsurance: Boolean;
                    LoansChecked: Integer;
                    LoansWithScheduleValues: Integer;
                    UpdatedLoans: Integer;
                    UpdatedDepositLoans: Integer;
                    UpdatedInsuranceLoans: Integer;
                    NoScheduleValueLoans: Integer;
                    ModifyLoan: Boolean;
                    TotalLoans: Integer;
                begin
                    Loan.Reset();
                    TotalLoans := Loan.Count();

                    if TotalLoans = 0 then begin
                        Message('No loan records were found.');
                        exit;
                    end;

                    if not Confirm(
                        'Check %1 loan record(s) and update Deposit Contribution / Total Insurance from the first non-zero repayment schedule amounts?',
                        false,
                        TotalLoans)
                    then
                        exit;

                    Window.Open(
                        'Updating loan deposit/insurance from schedules...\' +
                        'Checked: #1#######\' +
                        'Updated: #2#######\' +
                        'No Schedule Value: #3#######');

                    if Loan.FindSet(true) then
                        repeat
                            LoansChecked += 1;
                            Clear(DepositAmount);
                            Clear(InsuranceAmount);
                            Clear(FoundDeposit);
                            Clear(FoundInsurance);
                            Clear(ModifyLoan);

                            GetLoanScheduleDepositInsuranceAmounts(Loan."Loan No.", DepositAmount, InsuranceAmount, FoundDeposit, FoundInsurance);

                            if FoundDeposit or FoundInsurance then begin
                                LoansWithScheduleValues += 1;

                                if FoundDeposit and (Loan."Deposit COntribution" <> DepositAmount) then begin
                                    Loan."Deposit COntribution" := DepositAmount;
                                    ModifyLoan := true;
                                    UpdatedDepositLoans += 1;
                                end;

                                if FoundInsurance and (Loan."Total Insurance" <> InsuranceAmount) then begin
                                    Loan."Total Insurance" := InsuranceAmount;
                                    ModifyLoan := true;
                                    UpdatedInsuranceLoans += 1;
                                end;

                                if ModifyLoan then begin
                                    Loan.Modify();
                                    UpdatedLoans += 1;
                                end;
                            end else
                                NoScheduleValueLoans += 1;

                            Window.Update(1, LoansChecked);
                            Window.Update(2, UpdatedLoans);
                            Window.Update(3, NoScheduleValueLoans);
                        until Loan.Next() = 0;

                    Window.Close();

                    Message(
                        'Loan deposit/insurance update completed.\Loans checked: %1\Loans with schedule values: %2\Loans updated: %3\Deposit Contribution updated: %4\Total Insurance updated: %5\Loans without non-zero schedule values: %6',
                        LoansChecked,
                        LoansWithScheduleValues,
                        UpdatedLoans,
                        UpdatedDepositLoans,
                        UpdatedInsuranceLoans,
                        NoScheduleValueLoans);
                end;
            }

            action(ClearFirstInstallmentDepositInsuranceOnly)
            {
                ApplicationArea = All;
                Caption = 'Clear First Installment Deposit/Insurance Only';
                Image = UpdateDescription;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Sets Deposit Amount and Insurance Contribution to zero on the first schedule installment where principal and interest are zero.';

                trigger OnAction()
                var
                    Loan: Record Loans;
                    LoanRepaymentSchedule: Record "Loan Repayment Schedule";
                    Window: Dialog;
                    TotalLoans: Integer;
                    LoansChecked: Integer;
                    FirstInstallmentsChecked: Integer;
                    UpdatedSchedules: Integer;
                    SkippedNoSchedule: Integer;
                    SkippedNoCleanupNeeded: Integer;
                begin
                    Loan.Reset();
                    Loan.SetRange("Application Date", 0D, DMY2Date(30, 06, 2026));
                    Loan.SetRange("Disbursement Date", 0D, DMY2Date(30, 06, 2026));
                    TotalLoans := Loan.Count();

                    if TotalLoans = 0 then begin
                        Message('No loan records were found.');
                        exit;
                    end;

                    if not Confirm(
                        'Check the first repayment schedule installment for %1 loan(s) and clear Deposit Amount / Insurance Contribution where principal and interest are zero?',
                        false,
                        TotalLoans)
                    then
                        exit;

                    Window.Open(
                        'Clearing first installment deposit/insurance only...\' +
                        'Loans checked: #1#######\' +
                        'First installments checked: #2#######\' +
                        'Updated schedules: #3#######');

                    if Loan.FindSet() then
                        repeat
                            LoansChecked += 1;

                            LoanRepaymentSchedule.Reset();
                            LoanRepaymentSchedule.SetCurrentKey("Loan No.", "Repayment Date", "Member No.");
                            LoanRepaymentSchedule.SetRange("Loan No.", Loan."Loan No.");
                            if LoanRepaymentSchedule.FindFirst() then begin
                                FirstInstallmentsChecked += 1;

                                if ((LoanRepaymentSchedule."Deposit Amount" <> 0) or
                                    (LoanRepaymentSchedule."Insurance Contribution" <> 0)) and
                                   (LoanRepaymentSchedule."Monthly Principal" = 0) and
                                   (LoanRepaymentSchedule."Monthly Interest" = 0)
                                then begin
                                    LoanRepaymentSchedule."Deposit Amount" := 0;
                                    LoanRepaymentSchedule."Insurance Contribution" := 0;
                                    LoanRepaymentSchedule.Modify();

                                    UpdatedSchedules += 1;
                                end else
                                    SkippedNoCleanupNeeded += 1;
                            end else
                                SkippedNoSchedule += 1;

                            Window.Update(1, LoansChecked);
                            Window.Update(2, FirstInstallmentsChecked);
                            Window.Update(3, UpdatedSchedules);
                        until Loan.Next() = 0;

                    Window.Close();

                    Message(
                        'First installment cleanup completed.\Loans checked: %1\First installments checked: %2\Schedule lines updated: %3\Loans without schedule: %4\First installments skipped/no cleanup needed: %5',
                        LoansChecked,
                        FirstInstallmentsChecked,
                        UpdatedSchedules,
                        SkippedNoSchedule,
                        SkippedNoCleanupNeeded);
                end;
            }

            action(UpdateScheduleRepaymentDatesToEndMonth)
            {
                ApplicationArea = All;
                Caption = 'Update Schedule Dates To End Month';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Checks loan repayment schedule lines and changes any repayment date that is not month-end to the end date of that month.';

                trigger OnAction()
                var
                    LoanRepaymentSchedule: Record "Loan Repayment Schedule";
                    Window: Dialog;
                    TotalSchedules: Integer;
                    CheckedSchedules: Integer;
                    UpdatedSchedules: Integer;
                    SkippedBlankDates: Integer;
                    SkippedExistingEndMonthLine: Integer;
                    EndMonthDate: Date;
                    ExistingSchedule: Record "Loan Repayment Schedule";
                begin
                    LoanRepaymentSchedule.Reset();
                    TotalSchedules := LoanRepaymentSchedule.Count();

                    if TotalSchedules = 0 then begin
                        Message('No loan repayment schedule lines were found.');
                        exit;
                    end;

                    if not Confirm(
                        'Check %1 loan repayment schedule line(s) and update repayment dates that are not month-end to the end date of that month?',
                        false,
                        TotalSchedules)
                    then
                        exit;

                    Window.Open(
                        'Updating repayment dates to end month...\' +
                        'Checked: #1#######\' +
                        'Updated: #2#######\' +
                        'Blank Dates: #3#######\' +
                        'Existing End Month: #4#######');

                    if LoanRepaymentSchedule.FindSet(true) then
                        repeat
                            CheckedSchedules += 1;

                            if LoanRepaymentSchedule."Repayment Date" = 0D then
                                SkippedBlankDates += 1
                            else begin
                                EndMonthDate := CalcDate('<CM>', LoanRepaymentSchedule."Repayment Date");
                                if LoanRepaymentSchedule."Repayment Date" <> EndMonthDate then begin
                                    if ExistingSchedule.Get(LoanRepaymentSchedule."Loan No.", EndMonthDate, LoanRepaymentSchedule."Member No.") then
                                        SkippedExistingEndMonthLine += 1
                                    else begin
                                        LoanRepaymentSchedule.Rename(LoanRepaymentSchedule."Loan No.", EndMonthDate, LoanRepaymentSchedule."Member No.");
                                        UpdatedSchedules += 1;
                                    end;
                                end;
                            end;

                            Window.Update(1, CheckedSchedules);
                            Window.Update(2, UpdatedSchedules);
                            Window.Update(3, SkippedBlankDates);
                            Window.Update(4, SkippedExistingEndMonthLine);
                        until LoanRepaymentSchedule.Next() = 0;

                    Window.Close();

                    Message(
                        'Schedule repayment date update completed.\Schedule lines checked: %1\Schedule lines updated: %2\Blank repayment dates skipped: %3\Lines skipped because end-month key already exists: %4',
                        CheckedSchedules,
                        UpdatedSchedules,
                        SkippedBlankDates,
                        SkippedExistingEndMonthLine);
                end;
            }

            action(DeleteLoanRepaymentSchedulesBeforeJuly2026)
            {
                ApplicationArea = All;
                Caption = 'Delete Loan Schedules Disbursed Before Jul 2026';
                Image = Delete;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Deletes loan repayment schedule lines for loans whose disbursement date is on or before 30 June 2026.';

                trigger OnAction()
                var
                    Loan: Record Loans;
                    LoanRepaymentSchedule: Record "Loan Repayment Schedule";
                    CutoffDate: Date;
                    TotalSchedulesToDelete: Integer;
                    DeletedSchedules: Integer;
                    LoansWithSchedules: Integer;
                begin
                    CutoffDate := DMY2Date(30, 6, 2026);

                    Loan.Reset();
                    Loan.SetFilter("Disbursement Date", '..%1', CutoffDate);
                    if Loan.FindSet() then
                        repeat
                            LoanRepaymentSchedule.Reset();
                            LoanRepaymentSchedule.SetRange("Loan No.", Loan."Loan No.");
                            if not LoanRepaymentSchedule.IsEmpty() then begin
                                TotalSchedulesToDelete += LoanRepaymentSchedule.Count();
                                LoansWithSchedules += 1;
                            end;
                        until Loan.Next() = 0;

                    if TotalSchedulesToDelete = 0 then begin
                        Message('No loan repayment schedule lines were found for loans disbursed on or before %1.', CutoffDate);
                        exit;
                    end;

                    if not Confirm(
                        'This will permanently delete %1 loan repayment schedule line(s) for %2 loan(s) disbursed on or before %3. Continue?',
                        false,
                        TotalSchedulesToDelete,
                        LoansWithSchedules,
                        CutoffDate)
                    then
                        exit;

                    Loan.Reset();
                    Loan.SetFilter("Disbursement Date", '..%1', CutoffDate);
                    if Loan.FindSet() then
                        repeat
                            LoanRepaymentSchedule.Reset();
                            LoanRepaymentSchedule.SetRange("Loan No.", Loan."Loan No.");
                            if not LoanRepaymentSchedule.IsEmpty() then begin
                                DeletedSchedules += LoanRepaymentSchedule.Count();
                                LoanRepaymentSchedule.DeleteAll(true);
                            end;
                        until Loan.Next() = 0;

                    Message(
                        'Deleted %1 loan repayment schedule line(s) for loans disbursed on or before %2.',
                        DeletedSchedules,
                        CutoffDate);
                end;
            }

            action(DeleteZeroSourceCurrencyGLEntriesFromVendorMigration)
            {
                ApplicationArea = All;
                Caption = 'Delete Zero Source Currency G/L Entries';
                Image = Delete;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Deletes G/L entries whose Source Currency Amount is zero and whose document number exists in Vendor Ledger Entry Migration.';

                trigger OnAction()
                var
                    VendorLedgerMigration: Record "Vendor Ledger Entry Migration";
                    GLEntry: Record "G/L Entry";
                    ProcessedDocumentNos: Dictionary of [Code[20], Boolean];
                    DocumentNo: Code[20];
                    TotalToDelete: Integer;
                    DeletedEntries: Integer;
                    MatchedDocumentNos: Integer;
                begin
                    VendorLedgerMigration.Reset();
                    VendorLedgerMigration.SetFilter("Document No.", '<>%1', '');
                    if VendorLedgerMigration.FindSet() then
                        repeat
                            DocumentNo := VendorLedgerMigration."Document No.";
                            if not ProcessedDocumentNos.ContainsKey(DocumentNo) then begin
                                ProcessedDocumentNos.Add(DocumentNo, true);

                                GLEntry.Reset();
                                GLEntry.SetRange("Document No.", DocumentNo);
                                GLEntry.SetRange("Source Currency Amount", 0);
                                if not GLEntry.IsEmpty() then begin
                                    TotalToDelete += GLEntry.Count();
                                    MatchedDocumentNos += 1;
                                end;
                            end;
                        until VendorLedgerMigration.Next() = 0;

                    if TotalToDelete = 0 then begin
                        Message('No G/L entries were found with Source Currency Amount = 0 and document numbers from Vendor Ledger Entry Migration.');
                        exit;
                    end;

                    if not Confirm(
                        'This will permanently delete %1 G/L Entry record(s) with Source Currency Amount = 0 across %2 Vendor Ledger Migration document number(s). Continue?',
                        false,
                        TotalToDelete,
                        MatchedDocumentNos)
                    then
                        exit;

                    Clear(ProcessedDocumentNos);
                    VendorLedgerMigration.Reset();
                    VendorLedgerMigration.SetFilter("Document No.", '<>%1', '');
                    if VendorLedgerMigration.FindSet() then
                        repeat
                            DocumentNo := VendorLedgerMigration."Document No.";
                            if not ProcessedDocumentNos.ContainsKey(DocumentNo) then begin
                                ProcessedDocumentNos.Add(DocumentNo, true);

                                GLEntry.Reset();
                                GLEntry.SetRange("Document No.", DocumentNo);
                                GLEntry.SetRange("Source Currency Amount", 0);
                                if not GLEntry.IsEmpty() then begin
                                    DeletedEntries += GLEntry.Count();
                                    GLEntry.DeleteAll(true);
                                end;
                            end;
                        until VendorLedgerMigration.Next() = 0;

                    Message(
                        'Deleted %1 G/L Entry record(s) with Source Currency Amount = 0 for document numbers found in Vendor Ledger Entry Migration.',
                        DeletedEntries);
                end;
            }

            action(UpdateBlankLedgerDescriptionsFromVendorMigration)
            {
                ApplicationArea = All;
                Caption = 'Update Blank Ledger Descriptions';
                Image = UpdateDescription;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Updates blank descriptions in G/L Entry, Vendor Ledger Entry, and Bank Account Ledger Entry using Vendor Ledger Entry Migration descriptions matched by document number.';

                trigger OnAction()
                var
                    VendorLedgerMigration: Record "Vendor Ledger Entry Migration";
                    GLEntry: Record "G/L Entry";
                    VendorLedgerEntry: Record "Vendor Ledger Entry";
                    BankLedgerEntry: Record "Bank Account Ledger Entry";
                    ProcessedDocumentNos: Dictionary of [Code[20], Boolean];
                    DocumentNo: Code[20];
                    SourceDescription: Text[100];
                    DocumentsToProcess: Integer;
                    UpdatedGLEntries: Integer;
                    UpdatedVendorEntries: Integer;
                    UpdatedBankEntries: Integer;
                begin
                    VendorLedgerMigration.Reset();
                    VendorLedgerMigration.SetFilter("Document No.", '<>%1', '');
                    VendorLedgerMigration.SetFilter(Description, '<>%1', '');
                    if VendorLedgerMigration.FindSet() then
                        repeat
                            DocumentNo := VendorLedgerMigration."Document No.";
                            if not ProcessedDocumentNos.ContainsKey(DocumentNo) then begin
                                ProcessedDocumentNos.Add(DocumentNo, true);
                                DocumentsToProcess += 1;
                            end;
                        until VendorLedgerMigration.Next() = 0;

                    if DocumentsToProcess = 0 then begin
                        Message('No Vendor Ledger Entry Migration records with both Document No. and Description were found.');
                        exit;
                    end;

                    if not Confirm(
                        'Update blank descriptions in G/L Entry, Vendor Ledger Entry, and Bank Account Ledger Entry using %1 Vendor Ledger Migration document number(s)?',
                        false,
                        DocumentsToProcess)
                    then
                        exit;

                    Clear(ProcessedDocumentNos);
                    VendorLedgerMigration.Reset();
                    VendorLedgerMigration.SetFilter("Document No.", '<>%1', '');
                    VendorLedgerMigration.SetFilter(Description, '<>%1', '');
                    if VendorLedgerMigration.FindSet() then
                        repeat
                            DocumentNo := VendorLedgerMigration."Document No.";
                            if not ProcessedDocumentNos.ContainsKey(DocumentNo) then begin
                                ProcessedDocumentNos.Add(DocumentNo, true);
                                SourceDescription := CopyStr(VendorLedgerMigration.Description, 1, MaxStrLen(SourceDescription));

                                GLEntry.Reset();
                                GLEntry.SetRange("Document No.", DocumentNo);
                                GLEntry.SetRange(Description, '');
                                if GLEntry.FindSet(true) then
                                    repeat
                                        GLEntry.Description := CopyStr(SourceDescription, 1, MaxStrLen(GLEntry.Description));
                                        GLEntry.Modify();
                                        UpdatedGLEntries += 1;
                                    until GLEntry.Next() = 0;

                                VendorLedgerEntry.Reset();
                                VendorLedgerEntry.SetRange("Document No.", DocumentNo);
                                VendorLedgerEntry.SetRange(Description, '');
                                if VendorLedgerEntry.FindSet(true) then
                                    repeat
                                        VendorLedgerEntry.Description := CopyStr(SourceDescription, 1, MaxStrLen(VendorLedgerEntry.Description));
                                        VendorLedgerEntry.Modify();
                                        UpdatedVendorEntries += 1;
                                    until VendorLedgerEntry.Next() = 0;

                                BankLedgerEntry.Reset();
                                BankLedgerEntry.SetRange("Document No.", DocumentNo);
                                BankLedgerEntry.SetRange(Description, '');
                                if BankLedgerEntry.FindSet(true) then
                                    repeat
                                        BankLedgerEntry.Description := CopyStr(SourceDescription, 1, MaxStrLen(BankLedgerEntry.Description));
                                        BankLedgerEntry.Modify();
                                        UpdatedBankEntries += 1;
                                    until BankLedgerEntry.Next() = 0;
                            end;
                        until VendorLedgerMigration.Next() = 0;

                    Message(
                        'Blank description update completed.\G/L Entries: %1\Vendor Ledger Entries: %2\Bank Account Ledger Entries: %3',
                        UpdatedGLEntries,
                        UpdatedVendorEntries,
                        UpdatedBankEntries);
                end;
            }

            action(UpdateVendorAndGLDescFromGLMigrationAction)
            {
                ApplicationArea = All;
                Caption = 'Update Vendor/GL Descriptions From GL Migration';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Updates G/L Entry and blank Vendor Ledger Entry descriptions using matching G/L Entry Migration records.';

                trigger OnAction()
                begin
                    UpdateVendorAndGLEntryDescriptionsFromGLMigration();
                end;
            }

            action(LoansBalWithoutSchedules)
            {
                ApplicationArea = All;
                Caption = 'Loans Bal. Without Schedules';
                Image = Report;
                Promoted = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                RunObject = Report "Loans Bal. Without Schedules";
                ToolTip = 'Runs the report that lists loans with outstanding balances but no repayment schedules.';
            }

            action(UpdateGLEntryMemberNoFromDescription)
            {
                ApplicationArea = All;
                Caption = 'Update G/L Member No. From Description';
                Image = UpdateXML;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Extracts the member number before the colon in G/L Entry descriptions and updates blank Member No. fields.';

                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                    Members: Record Members;
                    DescriptionText: Text[100];
                    ExtractedMemberNo: Code[20];
                    EntriesToUpdate: Integer;
                    UpdatedEntries: Integer;
                    SkippedInvalidMembers: Integer;
                    SkippedNoBankLink: Integer;
                begin
                    GLEntry.Reset();
                    GLEntry.SetRange("Member No.", '');
                    GLEntry.SetFilter(Description, '*:*');
                    if GLEntry.FindSet() then
                        repeat
                            if GLEntryHasLinkedBankLedgerEntry(GLEntry) then begin
                                DescriptionText := CopyStr(GLEntry.Description, 1, MaxStrLen(DescriptionText));
                                ExtractedMemberNo := ExtractMemberNoFromGLEntryDescription(DescriptionText);
                                if ExtractedMemberNo <> '' then
                                    if Members.Get(ExtractedMemberNo) then
                                        EntriesToUpdate += 1;
                            end;
                        until GLEntry.Next() = 0;

                    if EntriesToUpdate = 0 then begin
                        Message('No bank-linked G/L entries with blank Member No. and valid member number in description were found.');
                        exit;
                    end;

                    if not Confirm(
                        'Update Member No. on %1 bank-linked G/L Entry record(s) using the member number in Description?',
                        false,
                        EntriesToUpdate)
                    then
                        exit;

                    GLEntry.Reset();
                    GLEntry.SetRange("Member No.", '');
                    GLEntry.SetFilter(Description, '*:*');
                    if GLEntry.FindSet(true) then
                        repeat
                            if GLEntryHasLinkedBankLedgerEntry(GLEntry) then begin
                                DescriptionText := CopyStr(GLEntry.Description, 1, MaxStrLen(DescriptionText));
                                ExtractedMemberNo := ExtractMemberNoFromGLEntryDescription(DescriptionText);
                                if ExtractedMemberNo <> '' then begin
                                    if Members.Get(ExtractedMemberNo) then begin
                                        GLEntry."Member No." := ExtractedMemberNo;
                                        GLEntry.Modify();
                                        UpdatedEntries += 1;
                                    end else
                                        SkippedInvalidMembers += 1;
                                end;
                            end else
                                SkippedNoBankLink += 1;
                        until GLEntry.Next() = 0;

                    Message(
                        'G/L Member No. update completed.\Updated entries: %1\Skipped invalid member numbers: %2\Skipped entries without bank link: %3',
                        UpdatedEntries,
                        SkippedInvalidMembers,
                        SkippedNoBankLink);
                end;
            }

            action(CheckCreditFundsMissingSavingsLedger)
            {
                ApplicationArea = All;
                Caption = 'Update Savings Ext. Doc. From Receipt Lines';
                Image = CheckLedger;
                Promoted = true;
                PromotedCategory = Category11;
                Visible = false;
                PromotedIsBig = true;
                ToolTip = 'Updates blank External Document No. on matching savings ledger entries using the External Doc. on receipt document lines where account type is Savings.';

                trigger OnAction()
                var
                    DocLine: Record "Document Line";
                    CheckedDocumentLines: Dictionary of [Text, Boolean];
                    CheckKey: Text;
                    CheckedSavingsDocumentLines: Integer;
                    UpdatedSavingsEntries: Integer;
                    UpdatedDocumentLineGroups: Integer;
                    NoSavingsEntryFound: Integer;
                    EntriesUpdatedNow: Integer;
                    Details: Text;
                begin
                    if not Confirm(
                        'Update blank External Document No. on Savings Ledger Entries from receipt Document Lines where Account Type is Savings and External Doc. is filled?',
                        false)
                    then
                        exit;

                    DocLine.Reset();
                    DocLine.SetCurrentKey("Header No.", "Account Type", "Account No.", "Transaction Type", "Loan No.", Type, "Line No.", "Entry No.");
                    DocLine.SetRange("Account Type", DocLine."Account Type"::Savings);
                    DocLine.SetFilter("External Doc.", '<>%1', '');
                    //DocLine.SetFilter("Posting Date", '>%1', DMY2Date(01, 07, 2026));
                    if DocLine.FindSet() then
                        repeat
                            CheckedSavingsDocumentLines += 1;

                            CheckKey := GetSavingsDocumentLineExtDocUpdateKey(DocLine);
                            if not CheckedDocumentLines.ContainsKey(CheckKey) then begin
                                CheckedDocumentLines.Add(CheckKey, true);

                                EntriesUpdatedNow := UpdateSavingsLedgerExternalDocNoFromDocumentLine(DocLine);
                                if EntriesUpdatedNow > 0 then begin
                                    UpdatedDocumentLineGroups += 1;
                                    UpdatedSavingsEntries += EntriesUpdatedNow;
                                end else
                                    if not MatchingSavingsLedgerEntryExistsForDocumentLine(DocLine) then begin
                                        NoSavingsEntryFound += 1;
                                        if NoSavingsEntryFound <= 20 then
                                            Details += StrSubstNo(
                                                '%1. Ext. Doc: %2, Member: %3, Account: %4, Doc: %5, Amount: %6\',
                                                NoSavingsEntryFound,
                                                DocLine."External Doc.",
                                                DocLine."Member No.",
                                                DocLine."Account No.",
                                                DocLine."Header No.",
                                                Format(DocLine.Amount));
                                    end;
                            end;
                        until DocLine.Next() = 0;

                    if NoSavingsEntryFound = 0 then begin
                        Message(
                            'Update completed. Scanned %1 savings document line(s). Updated %2 savings ledger entry/entries from %3 document line group(s). No unmatched savings ledger entry was found.',
                            CheckedSavingsDocumentLines,
                            UpdatedSavingsEntries,
                            UpdatedDocumentLineGroups);
                        exit;
                    end;

                    Message(
                        'Update completed. Scanned %1 savings document line(s). Updated %2 savings ledger entry/entries from %3 document line group(s). Could not find matching savings ledger entries for %4 group(s).\%5',
                        CheckedSavingsDocumentLines,
                        UpdatedSavingsEntries,
                        UpdatedDocumentLineGroups,
                        NoSavingsEntryFound,
                        Details);

                end;
            }
        }

        area(navigation)
        {
            group(DoNoOpen)
            {
                action("Reverse ALL")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    visible = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = report "Reverse penalty";
                }
            }
            group(Additional)
            {
                Image = Employee;
                Visible = false;
                action("Upload Images")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Upload Pictures";
                }

                action("Update PRD Details")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Page "Update PRD Details";
                }

                action("Update Branch Codes")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Page "Update Branch Codes";
                }
                action("Modify Bank Account Ledgers")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Page "Modify Bank Account Ledgers";
                }
                action("Import FA Lines")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = xmlport "Import FA Lines";
                }
                action("Interest Refund")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;
                    RunObject = report "Interest Refund";
                }
                action("Member Balances")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;
                    RunObject = page "Member Balances";
                }
                action("Import Member Balances")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = xmlport "Import Member Balances";
                }

                action("Transfer MLedger Balances")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Transfer MLedger Balances";
                }
                action(GenerateMemberBalances)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Generate Old Balances";
                }
                action(DivLedger)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Page "Dividend Ledger Entry";
                }
                action(IntDueCorrection)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Interest Due Correction";
                }
                action("Div Interest Correction")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Div Interest Correction";
                }

                action(UpdatePension)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        myInt: Integer;
                        PeriodTrans: Record "Payroll Period Transactions";
                        EmployeeTRans: Record "Payroll Employee Transactions";
                    begin
                        PeriodTrans.Reset();
                        PeriodTrans.SetRange("Transaction Code", 'D001');
                        PeriodTrans.SetRange(Updated, false);
                        if PeriodTrans.FindFirst() then begin
                            repeat
                                PeriodTrans.Balance += PeriodTrans.Amount;
                                PeriodTrans.Updated := true;
                                PeriodTrans.Modify();
                                EmployeeTRans.Reset();
                                EmployeeTRans.SetRange("Employee Code", PeriodTrans."Employee Code");
                                EmployeeTRans.SetRange("Transaction Code", PeriodTrans."Transaction Code");
                                EmployeeTRans.SetRange("Payroll Period", DMY2Date(01, 01, 2023), Today);
                                if EmployeeTRans.FindFirst() then begin
                                    EmployeeTRans.Balance := PeriodTrans.Balance;
                                    EmployeeTRans.Modify();
                                end;
                            until PeriodTrans.Next() = 0;
                            Message('Updated: %1', PeriodTrans.Count);
                        end;
                    end;
                }
                action(P9OLD)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Page P9OLD;
                }
                action(P9NEW)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Visible = true;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Page P9NEW;
                }

                action("Update Pension")
                {
                    Image = ViewComments;
                    trigger OnAction()
                    var
                        STO: Record "Standing Order Header";
                        BanK: Record "Bank Account";
                        GLEntry: Record "G/L Entry";
                        Members: Record Members;
                    begin
                        Members.Reset();
                        Members.SetRange(Pensioner, true);
                        if Members.FindFirst() then begin
                            repeat

                                STO.Reset();
                                STO.SetRange("Member No.", Members."No.");
                                STO.Setfilter("Income Type", '<>%1', STO."Income Type"::Pension);
                                if STO.FindFirst() then begin
                                    repeat
                                        STO."Income Type" := STO."Income Type"::Pension;
                                        STO.Modify();
                                    until STO.Next = 0;
                                    Message('UPdated');
                                end;
                            until Members.Next() = 0;
                        end;

                    end;
                }
                action("Update Bank 14")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        BLedger: Record "Bank Account Ledger Entry";
                        STO: Record "Standing Order Header";
                        BanK: Record "Bank Account";
                        GLEntry: Record "G/L Entry";
                    begin

                        BLedger.Reset();
                        BLedger.SetRange("Bank Account No.", 'BNK_014');
                        BLedger.SetFilter("External Document No.", 'STO*');
                        if BLedger.FindFirst() then begin
                            if Confirm('Proceed: ' + Format(BLedger.count) + '?') Then begin
                                repeat

                                    if STO.Get(BLedger."External Document No.") then begin
                                        BanK.get(BLedger."Bank Account No.");
                                        Bank.CalcFields("GL Account");
                                        BLedger.Description := STO."Source Account No." + ': ' + STO."Source Account Name";
                                        BLedger.Modify();

                                        GLEntry.Reset();
                                        GLEntry.SetRange("G/L Account No.", BanK."GL Account");
                                        GLEntry.SetRange("Entry No.", BLedger."Entry No.");
                                        GLEntry.SetRange(Amount, BLedger."Amount (LCY)");
                                        if GLEntry.FindFirst() then begin
                                            GLEntry.Description := BLedger.Description;
                                            GLEntry.Modify();
                                        end;
                                    end;

                                until BLedger.Next() = 0;
                                Message('UPdated');
                            end;
                        end;

                    end;
                }
                action("Update GL Account Shares DEC")
                {
                    Image = ViewComments;

                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        BLedger: Record "Bank Account Ledger Entry";
                        STO: Record "Standing Order Header";
                        BanK: Record "Bank Account";
                        GLEntry: Record "G/L Entry";
                    begin

                        GLEntry.Reset();
                        GLEntry.SetRange("G/L Account No.", '41129010');
                        GLEntry.SetFilter("Document No.", '%1', 'SHARES :12/31/24');
                        GLEntry.SetFilter(Amount, '<0');
                        if GLEntry.FindFirst() then begin
                            repeat

                                GLEntry."G/L Account No." := '51110010';
                                GLEntry.Modify();

                            until GLEntry.Next() = 0;
                            Message('UPdated');
                        end;
                    end;
                }
                action("Update GL Account Shares Nov")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        BLedger: Record "Bank Account Ledger Entry";
                        STO: Record "Standing Order Header";
                        BanK: Record "Bank Account";
                        GLEntry: Record "G/L Entry";
                    begin

                        GLEntry.Reset();
                        GLEntry.SetRange("G/L Account No.", '41129010');
                        GLEntry.SetFilter("Document No.", '%1', 'SHARES :11/30/24');
                        GLEntry.SetFilter(Amount, '<0');
                        if GLEntry.FindFirst() then begin
                            repeat

                                GLEntry."G/L Account No." := '51110010';
                                GLEntry.Modify();

                            until GLEntry.Next() = 0;
                            Message('UPdated');
                        end;
                    end;
                }
                action("Update GL Account Shares Oct")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        BLedger: Record "Bank Account Ledger Entry";
                        STO: Record "Standing Order Header";
                        BanK: Record "Bank Account";
                        GLEntry: Record "G/L Entry";
                    begin

                        GLEntry.Reset();
                        GLEntry.SetRange("G/L Account No.", '41129010');
                        GLEntry.SetRange("Document No.", 'SHARES :10/31/24');
                        GLEntry.SetFilter(Amount, '<0');
                        if GLEntry.FindFirst() then begin
                            repeat

                                GLEntry."G/L Account No." := '51110010';
                                GLEntry.Modify();

                            until GLEntry.Next() = 0;
                            Message('UPdated');
                        end;
                    end;
                }

                action("Update GL Account Shares Sept")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        BLedger: Record "Bank Account Ledger Entry";
                        STO: Record "Standing Order Header";
                        BanK: Record "Bank Account";
                        GLEntry: Record "G/L Entry";
                    begin

                        GLEntry.Reset();
                        GLEntry.SetRange("G/L Account No.", '41129010');
                        GLEntry.SetRange("Document No.", 'SHARES :30/09/24');
                        GLEntry.SetFilter(Amount, '<0');
                        if GLEntry.FindFirst() then begin
                            repeat

                                GLEntry."G/L Account No." := '51110010';
                                GLEntry.Modify();

                            until GLEntry.Next() = 0;
                            Message('UPdated');
                        end;
                    end;
                }

                action("Update STO Next Date")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        STO: Record "Standing Order Header";
                        BanK: Record "Bank Account";
                        GLEntry: Record "G/L Entry";
                    begin
                        STO.Reset();
                        STO.SetRange("Income Type", STO."Income Type"::Business);
                        STO.SetRange(Status, STO.Status::Approved);
                        STO.setfilter("Effective/Start Date", '<%1', DMY2Date(01, 01, 2023));
                        if STO.FindFirst() then begin
                            repeat
                                if STO."Effective/Start Date" <> 0D then begin
                                    STO."Next Run Date" := DMY2Date(Date2DMY(STO."Effective/Start Date", 1), 01, 2023);
                                    STO.Modify();
                                end;
                            until STO.Next = 0;
                            Message('UPdated');
                        end;

                    end;
                }
            }
            group(HR)
            {
                Caption = 'HR';
                Image = Employee;
                Visible = false;
                action("Loan Interest Reversal")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Report "Loan Interest Reversal";
                }
                action("FA LEDGER")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "FA LEDGER";
                }
                action("Update Junior")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Update Junior";
                }
                action("VendorsListing")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page VendorsListing;
                }
                action("Bank Ledger")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Bank Ledger";
                }
                action("Payslip Data")
                {
                    Image = ViewComments;
                    RunObject = Page "Payslip Data";
                }
                action("UPGX HR Employee Transfer")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "UPGX HR Employee Transfer";
                }
                action("FDR Import")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "FDR Import";
                }

                action("Transaction Codes")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Transaction Codes";
                }
                action("Employee Transactions")
                {
                    Image = ViewComments;
                    RunObject = Page "Employee Transactions";
                }
            }
            group(TestCodeunits)
            {
                Caption = 'Test Codeunits';
                Image = Employee;
                Visible = false;
                action("Upload Pictures")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Report "Upload Pictures";
                }
                action("HR EMPLOYEE")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "HR EMPLOYEE";
                }
                action("Member Updates")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Member Updates";
                }
                action("Banks Import")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Bank Accounts Listing";
                }
                action("Coop ATM Charges Import")
                {
                    Image = ViewComments;
                    RunObject = Page "Coop ATM Charges Import";
                }
                action(CalwidePortal)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    //RunObject = codeunit "Calwide Portal";
                }
                action(TestXML)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = xmlport Test;
                }
                action("SACCO Loan Categorization")
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Report "SACCO Loan Categorization";
                }
            }
            group(Registry)
            {
                Caption = 'Registry';
                Image = Employee;
                Visible = false;
                action(ImportMembers)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = xmlport "UPG_Import Members";
                }
                action(ImportMemberAccounts)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = xmlport "Import Sacco accounts";
                }
                action(ImportMemberBalances)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = xmlport "UPG_Member Balances";
                }
                //aziz
                action(ImportVendorBalances)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = page UPG_Vendors;
                }
                action(ImportCustomerBalances)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = page UPG_Customer;
                }

                action(CreateAccountsAccounts)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    //RunObject = report "Create Accounts Accounts";
                }

                action(ImportResponsibilityCenter)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = page "UPG_Resp. Center";
                }
                action(ImportSTO)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = page UPG_STO;
                }
                action(ImportNoSeriesLine)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = page "UPG_No Series Line";
                }
                action(ImportBudgetLines)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = page UPG_BudgetLines;
                }
                action(ImportFixedAssets)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = page "UPG_Fixed Assets";
                }
                action(ImportAccScheduleLine)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = page UPG_AccScheduleLine;
                }

            }

            group(UWSLedger)
            {
                Caption = 'UWS Ledgers';
                Image = Invoice;

                action(MLedger)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Page "Member Ledger Entry";
                }
                action(GLEntryMigration)
                {
                    Caption = 'G/L Entry Migration';
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Page "G/L Entry Migration";
                }

                action(ImportGLEntryDirect)
                {
                    Caption = 'Import G/L Entry Direct';
                    Image = ImportDatabase;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = xmlport "Import G/L Entry Direct";
                }
                action(OneLeggedGLTransactions)
                {
                    Caption = 'One Legged G/L Transactions';
                    Image = Balance;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "One Legged G/L Transactions";
                }
                action(VendorLedgerEntryMigration)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Page "Vendor Ledger Entry Migration";
                }

                action(BankAccountLedgerMigration)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Page "Bank Account Ledger Migration";
                }

                action(UpdateMLedger)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        MLedger: Record "Member Ledger Entry Migration";
                        dWindow: Dialog;
                        CurrentRecordNo: Integer;
                        NoOfRecords: Integer;
                        SActivities: Codeunit "Sacco Activities";
                        pdate: Date;
                        edate: Date;
                        sdate: Date;
                        updated: Integer;
                        Members: Record Members;
                        Accounts: Record "Savings Accounts";
                        Skip: Boolean;
                        Loans: Record Loans;
                        SavingFound: Boolean;
                        CLedger: Record "Credit Ledger Entry";
                        ProductSetup: Record "Product Setup";
                        MemberActivities: Codeunit "Member Activities";
                    begin
                        updated := 0;
                        edate := DMY2Date(03, 07, 2026);
                        sdate := DMY2Date(01, 01, 2026);

                        MLedger.Reset();
                        MLedger.SetRange(Posted, false);
                        MLedger.SetRange("Posting Date", sdate, edate);
                        MLedger.SetRange(Reversed, false);
                        MLedger.SetRange(Posted, false);
                        //MLedger.SetFilter("Transaction Type", '%1|%2', MLedger."Transaction Type"::Insurance_Charge, MLedger."Transaction Type"::"Interest Due");
                        if MLedger.FindFirst() then begin
                            NoOfRecords := MLedger.Count;
                            SActivities.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
                            CurrentRecordNo := 0;
                            repeat
                                CurrentRecordNo += 1;
                                Skip := true;
                                SavingFound := false;

                                SActivities.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, '');

                                Members.Reset();
                                Members.SetRange("Old Member No.", MLedger."Customer No.");
                                if Members.FindFirst() then begin
                                    if Members.Count = 1 then begin

                                        MLedger.MemberFound := true;
                                        MLedger.Modify();

                                        Accounts.Reset();
                                        Accounts.SetRange("Member No.", Members."Member No.");
                                        case

                                            MLedger."Transaction Type" of
                                            MLedger."Transaction Type"::"Deposit Contribution":
                                                begin
                                                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Deposit Contribution");
                                                    Skip := false;
                                                end;
                                            MLedger."Transaction Type"::Fixed_deposit:
                                                begin
                                                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Fixed Deposit");
                                                    Skip := false;
                                                end;
                                            MLedger."Transaction Type"::"Junior Savings":
                                                begin
                                                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Junior Savings");
                                                    Skip := false;
                                                end;
                                            MLedger."Transaction Type"::"Holiday Savings":
                                                begin
                                                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Holiday Savings");
                                                    Skip := false;
                                                end;
                                            MLedger."Transaction Type"::"Registration Fee":
                                                begin
                                                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Registration Fee");
                                                    Skip := false;
                                                end;
                                            MLedger."Transaction Type"::"Shares Capital":
                                                begin
                                                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Share Capital");
                                                    Skip := false;
                                                end;
                                            MLedger."Transaction Type"::"Distribution Account":
                                                begin
                                                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Unallocated Fund");
                                                    Skip := false;
                                                end;
                                            MLedger."Transaction Type"::"Interest On Deposits":
                                                begin
                                                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Dividend Account");
                                                    Skip := false;
                                                end;
                                        end;

                                        if not Skip then begin

                                            if Accounts.FindFirst() then begin
                                                MLedger.AccountNo := Accounts."No.";
                                                MLedger.ProductID := Accounts."Product Type";
                                                MLedger.Modify();
                                                updated += 1;

                                                SavingFound := true;
                                            end else begin
                                                ProductSetup.Reset();
                                                ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Savings);
                                                if MLedger."Transaction Type" = MLedger."Transaction Type"::"Shares Capital" then
                                                    ProductSetup.SetRange("Product Category", ProductSetup."Product Category"::"Share Capital");
                                                if MLedger."Transaction Type" = MLedger."Transaction Type"::"Deposit Contribution" then
                                                    ProductSetup.SetRange("Product Category", ProductSetup."Product Category"::"Deposit Contribution");
                                                if MLedger."Transaction Type" = MLedger."Transaction Type"::"Holiday Savings" then
                                                    ProductSetup.SetRange("Product Category", ProductSetup."Product Category"::"Holiday Savings");
                                                if MLedger."Transaction Type" = MLedger."Transaction Type"::"Distribution Account" then
                                                    ProductSetup.SetRange("Product Category", ProductSetup."Product Category"::"Unallocated Fund");
                                                if MLedger."Transaction Type" = MLedger."Transaction Type"::"Interest On Deposits" then
                                                    ProductSetup.SetRange("Product Category", ProductSetup."Product Category"::"Dividend Account");
                                                if ProductSetup.FindFirst() then begin

                                                    Accounts.Reset();
                                                    Accounts.SetRange("Member No.", Members."No.");
                                                    Accounts.SetRange("Product Type", ProductSetup."Product ID");
                                                    if NOT Accounts.FindFirst() then begin
                                                        MemberActivities.CreateSavingsAccount(ProductSetup, Members, 0, true, ProductSetup."Repay Mode");

                                                        Accounts.Reset();
                                                        Accounts.SetRange("Member No.", Members."No.");
                                                        Accounts.SetRange("Product Type", ProductSetup."Product ID");
                                                        if Accounts.FindFirst() then begin
                                                            if Accounts.Count = 1 then begin
                                                                MLedger.AccountNo := Accounts."No.";
                                                                MLedger.ProductID := Accounts."Product Type";
                                                                MLedger.Modify();
                                                                updated += 1;
                                                            end;
                                                        end;
                                                    end;

                                                end;
                                            end;
                                        end else begin

                                            if (Skip) and (not SavingFound) then begin
                                                Loans.Reset();
                                                Loans.SetRange("Old Member No.", MLedger."Customer No.");
                                                Loans.SetRange("Loan No.", MLedger."Loan No");

                                                case
                                                    MLedger."Transaction Type" of
                                                    MLedger."Transaction Type"::Loan:
                                                        begin
                                                            Skip := false;
                                                        end;
                                                    MLedger."Transaction Type"::"Loan Penalty":
                                                        begin
                                                            Skip := false;
                                                        end;
                                                    MLedger."Transaction Type"::"Penalty Charged":
                                                        begin
                                                            Skip := false;
                                                        end;
                                                    MLedger."Transaction Type"::"Penalty Paid":
                                                        begin
                                                            Skip := false;
                                                        end;
                                                    MLedger."Transaction Type"::"Interest Due":
                                                        begin
                                                            Skip := false;
                                                        end;
                                                    MLedger."Transaction Type"::"Interest Paid":
                                                        begin
                                                            Skip := false;
                                                        end;
                                                    MLedger."Transaction Type"::Insurance_Charge:
                                                        begin
                                                            Skip := false;
                                                        end;
                                                    MLedger."Transaction Type"::"Insurance Paid":
                                                        begin
                                                            Skip := false;
                                                        end;
                                                    MLedger."Transaction Type"::Repayment:
                                                        begin
                                                            Skip := false;
                                                        end;
                                                end;

                                                if not Skip then begin

                                                    if Loans.FindFirst() then begin
                                                        MLedger.AccountNo := Loans."Loan Account";
                                                        if Loans."Loan Account" = '' then begin

                                                            CLedger.Reset();
                                                            CLedger.SetRange("Loan No.", Loans."Loan No.");
                                                            if CLedger.FindFirst() then begin
                                                                MLedger.AccountNo := CLedger."Account No.";
                                                                Loans."Loan Account" := CLedger."Account No.";
                                                                Loans.Modify();
                                                            end;

                                                        end;
                                                        MLedger.ProductID := Loans."Loan Product Type";
                                                        MLedger.Modify();
                                                        updated += 1;

                                                        Skip := true;
                                                    end;
                                                end;
                                            end;
                                        end;

                                    end else begin
                                        Error('Multiple members found for Old Member No. %1. Please fix the data and try again.', MLedger."Customer No.");
                                    end;
                                end else begin
                                    Accounts.Reset();
                                    Accounts.SetRange("Old Account No.", MLedger."Customer No.");
                                    if Accounts.FindFirst() then begin
                                        MLedger.AccountNo := Accounts."No.";
                                        MLedger.ProductID := Accounts."Product Type";
                                        MLedger.MemberFound := true;
                                        MLedger.Modify();
                                        updated += 1;
                                    end
                                end;

                            until MLedger.Next() = 0;
                            SActivities.ProgressClose(dWindow);

                        end;
                        Message('Total Records Updated: %1', updated);

                    end;
                }
            }

            group(UWS_DataPosting)
            {
                Image = Invoice;


                action(PostGL)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    trigger OnAction()

                    var
                        UPGLoans: Record SaccoLoans;
                        dWindow: Dialog;
                        CurrentRecordNo: Integer;
                        NoOfRecords: Integer;
                        SActivities: Codeunit "Sacco Activities";
                        MNo: Code[20];
                        SalesSetup: Record "Sales & Receivables Setup";
                        UserSetup: Record "User Setup";
                        //NoSeriesMgt: Codeunit NoSeriesManagement;
                        AcctType: Enum "Gen. Journal Account Type";
                        TransType: Enum "Transaction Type Enum";
                        pAmt: Decimal;
                        iAmt: Decimal;
                        pdate: Date;
                        sdate: Date;
                        edate: Date;
                        DimID: Integer;
                        SaccoSetup: Record "Sacco Setup";
                        j: Integer;
                        TotalAmt: Decimal;
                        GLAccount: Record "G/L Account";
                        GLLedger: Record "G/L Entry Migration";
                        MLedger: Record "Member Ledger Entry Migration";
                        BLedger: Record "Bank Account Ledger Migration";
                        VLedger: Record "Vendor Ledger Entry Migration";
                    begin
                        if Confirm('Are you sure you want to Direct Post G/L Enytry Data ?') then begin

                            edate := DMY2Date(31, 05, 2026);
                            sdate := DMY2Date(01, 01, 2026);

                            SaccoSetup.Get();
                            SaccoSetup.TestField("Opening Balances GL");
                            SaccoSetup.TestField("Suspense GL Account");
                            //SaccoSetup.TestField("Go Live Date");

                            CurrentRecordNo := 0;
                            NoOfRecords := 0;
                            UserSetup.Get(UserId);
                            pdate := SaccoSetup."Go Live Date"; //DMY2Date(20, 04, 2025);
                            edate := pdate;
                            SActivities.JournalInit(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                            if pdate = 0D then
                                pdate := sdate;

                            While pdate <= edate do begin


                                GLLedger.Reset();
                                GLLedger.SetRange(Posted, false);
                                GLLedger.SetRange("Posting Date", CalcDate('-CM', pdate), CalcDate('CM', pdate));
                                GLLedger.SetRange(Reversed, false);
                                //GLLedger.SetRange("Source Type", GLLedger."Source Type"::" ");
                                if GLLedger.FindFirst() then begin
                                    NoOfRecords := GLLedger.Count;
                                    SActivities.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
                                    pAmt := 0;
                                    iAmt := 0;
                                    CurrentRecordNo := 0;
                                    TotalAmt := 0;

                                    SActivities.JournalInit(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                                    repeat

                                        MLedger.Reset();
                                        MLedger.SetRange("Entry No.", GLLedger."Entry No.");
                                        if MLedger.FindFirst() then begin
                                            GLLedger.Skipped := true;
                                            GLLedger.Modify();
                                        end else begin

                                            BLedger.Reset();
                                            BLedger.SetRange("Entry No.", GLLedger."Entry No.");
                                            if BLedger.FindFirst() then begin
                                                GLLedger.Skipped := true;
                                                GLLedger.Modify();
                                            end;

                                            VLedger.Reset();
                                            VLedger.SetRange("Entry No.", GLLedger."Entry No.");
                                            if VLedger.FindFirst() then begin
                                                GLLedger.Skipped := true;
                                                GLLedger.Modify();
                                            end;

                                        end;



                                        if not GLLedger.Skipped then begin



                                            CurrentRecordNo += 1;
                                            SActivities.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, GLLedger.Description);

                                            DimID := 0;
                                            //GLLedger."Old Account No" := MLedger.AccountNo;
                                            //GLLedger.AccountNo := SaccoSetup."Suspense GL Account";
                                            GLLedger.Posted := true;
                                            GLLedger.Modify();

                                            if not GLLedger.Skipped then
                                                SActivities.JournalInsert(UserSetup."General Journal Template", UserSetup."General Journal Batch", GLLedger."Document No.", GLLedger."Posting Date", Accttype::"G/L Account", GLLedger."G/L Account No.", CopyStr(GLLedger.Description, 1, 100), AcctType::"G/L Account",
                                                    SaccoSetup."Opening Balances GL", GLLedger.Amount, GLLedger."External Document No.", '', TransType::" ", GLLedger."Global Dimension 1 Code", GLLedger."Global Dimension 2 Code", TRUE, TChannel::"Open Balance", DimID);


                                        end;
                                    until GLLedger.Next() = 0;

                                    SActivities.ProgressClose(dWindow);

                                    SActivities.JournalPost(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                                end;


                                PDate := CalcDate('1M+CM', PDate);
                            end;
                        end;

                    end;

                }

                action(PostGLSuspense)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    trigger OnAction()

                    var
                        UPGLoans: Record SaccoLoans;
                        dWindow: Dialog;
                        CurrentRecordNo: Integer;
                        NoOfRecords: Integer;
                        SActivities: Codeunit "Sacco Activities";
                        MNo: Code[20];
                        SalesSetup: Record "Sales & Receivables Setup";
                        UserSetup: Record "User Setup";
                        //NoSeriesMgt: Codeunit NoSeriesManagement;
                        AcctType: Enum "Gen. Journal Account Type";
                        TransType: Enum "Transaction Type Enum";
                        pAmt: Decimal;
                        iAmt: Decimal;
                        pdate: Date;
                        sdate: Date;
                        edate: Date;
                        DimID: Integer;
                        SaccoSetup: Record "Sacco Setup";
                        j: Integer;
                        TotalAmt: Decimal;
                        GLAccount: Record "G/L Account";
                        MLedger: Record "Member Ledger Entry Migration";
                    begin
                        if Confirm('Are you sure you want to Post PostGLSuspense Data ?') then begin

                            edate := DMY2Date(31, 05, 2026);
                            sdate := DMY2Date(01, 01, 2026);

                            SaccoSetup.Get();
                            SaccoSetup.TestField("Opening Balances GL");
                            SaccoSetup.TestField("Suspense GL Account");
                            //SaccoSetup.TestField("Go Live Date");

                            CurrentRecordNo := 0;
                            NoOfRecords := 0;
                            UserSetup.Get(UserId);
                            pdate := SaccoSetup."Go Live Date"; //DMY2Date(20, 04, 2025);
                            edate := pdate;
                            SActivities.JournalInit(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                            if pdate = 0D then
                                pdate := sdate;

                            While pdate <= edate do begin


                                MLedger.Reset();
                                MLedger.SetRange(Posted, false);
                                MLedger.SetFilter("ProductID", '%1', '');
                                MLedger.SetRange("Posting Date", CalcDate('-CM', pdate), CalcDate('CM', pdate));
                                MLedger.SetRange(Reversed, false);
                                //MLedger.SetRange(MemberFound, true);
                                MLedger.SetRange("Customer No.", 'SUSPENSE');
                                if MLedger.FindFirst() then begin
                                    NoOfRecords := MLedger.Count;
                                    SActivities.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
                                    pAmt := 0;
                                    iAmt := 0;
                                    CurrentRecordNo := 0;
                                    TotalAmt := 0;
                                    SActivities.JournalInit(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                                    repeat
                                        CurrentRecordNo += 1;
                                        SActivities.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, MLedger.Description);

                                        DimID := 0;
                                        MLedger."Old Account No" := MLedger.AccountNo;
                                        MLedger.AccountNo := SaccoSetup."Suspense GL Account";
                                        MLedger.Posted := true;
                                        MLedger.Modify();

                                        SActivities.JournalInsert(UserSetup."General Journal Template", UserSetup."General Journal Batch", MLedger."Document No.", MLedger."Posting Date", Accttype::"G/L Account", MLedger.AccountNo, CopyStr(MLedger.Description, 1, 100), AcctType::"G/L Account",
                                            SaccoSetup."Opening Balances GL", MLedger."Amount (LCY)", MLedger."External Document No.", '', TransType::"Loan Disbursement", MLedger."Global Dimension 1 Code", MLedger."Global Dimension 2 Code", TRUE, TChannel::"Open Balance", DimID);

                                    until MLedger.Next() = 0;
                                    SActivities.ProgressClose(dWindow);

                                    SActivities.JournalPost(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                                end;

                                PDate := CalcDate('1M+CM', PDate);
                            end;
                        end;

                    end;

                }

                action(PostVendors)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    trigger OnAction()

                    var
                        UPGLoans: Record SaccoLoans;
                        Vendor: Record Vendor;
                        dWindow: Dialog;
                        CurrentRecordNo: Integer;
                        NoOfRecords: Integer;
                        SActivities: Codeunit "Sacco Activities";
                        MNo: Code[20];
                        SalesSetup: Record "Sales & Receivables Setup";
                        UserSetup: Record "User Setup";
                        //NoSeriesMgt: Codeunit NoSeriesManagement;
                        AcctType: Enum "Gen. Journal Account Type";
                        TransType: Enum "Transaction Type Enum";
                        pAmt: Decimal;
                        iAmt: Decimal;
                        pdate: Date;
                        sdate: Date;
                        edate: Date;
                        DimID: Integer;
                        SaccoSetup: Record "Sacco Setup";
                        VLedger: Record "Vendor Ledger Entry Migration";
                        j: Integer;
                        TotalAmt: Decimal;

                    begin
                        if Confirm('Are you sure you want to Post Vendors Data ?') then begin

                            edate := DMY2Date(30, 04, 2026);
                            sdate := DMY2Date(01, 01, 2026);

                            SaccoSetup.Get();
                            SaccoSetup.TestField("Opening Balances GL");
                            //SaccoSetup.TestField("Go Live Date");

                            CurrentRecordNo := 0;
                            NoOfRecords := 0;
                            UserSetup.Get(UserId);
                            pdate := SaccoSetup."Go Live Date"; //DMY2Date(20, 04, 2025);
                            edate := pdate;
                            SActivities.JournalInit(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                            if pdate = 0D then
                                pdate := sdate;

                            While pdate <= edate do begin

                                Vendor.Reset();
                                IF Vendor.FindFirst() THEN begin
                                    repeat
                                        VLedger.Reset();
                                        VLedger.SetRange(Posted, false);
                                        VLedger.SetRange("Vendor No.", Vendor."No.");
                                        VLedger.SetRange("Posting Date", CalcDate('-CM', pdate), CalcDate('CM', pdate));
                                        VLedger.SetRange(Reversed, false);
                                        if VLedger.FindFirst() then begin
                                            NoOfRecords := VLedger.Count;
                                            SActivities.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
                                            pAmt := 0;
                                            iAmt := 0;
                                            CurrentRecordNo := 0;
                                            TotalAmt := 0;
                                            SActivities.JournalInit(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                                            repeat
                                                CurrentRecordNo += 1;
                                                SActivities.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, Vendor.Name);

                                                //VLedger.CalcFields("Amount (LCY)");
                                                DimID := 0;
                                                VLedger.Posted := true;
                                                VLedger.Modify();
                                                SActivities.JournalInsert(UserSetup."General Journal Template", UserSetup."General Journal Batch", VLedger."Document No.", VLedger."Posting Date", Accttype::Vendor, Vendor."No.", CopyStr(VLedger.Description, 1, 100), AcctType::"G/L Account",
                                                    SaccoSetup."Opening Balances GL", VLedger."Amount (LCY)", VLedger."External Document No.", '', TransType::" ", Vendor."Global Dimension 1 Code", Vendor."Global Dimension 2 Code", TRUE, TChannel::"Open Balance", DimID);

                                            until VLedger.Next() = 0;

                                            SActivities.JournalPost(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                                            SActivities.ProgressClose(dWindow);
                                        end;


                                    until Vendor.Next() = 0;
                                end;

                                PDate := CalcDate('1M+CM', PDate);
                            end;



                        end;
                    end;

                }

                action(PostBanks)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    trigger OnAction()

                    var
                        UPGLoans: Record SaccoLoans;
                        Banks: Record "Bank Account";
                        dWindow: Dialog;
                        CurrentRecordNo: Integer;
                        NoOfRecords: Integer;
                        SActivities: Codeunit "Sacco Activities";
                        MNo: Code[20];
                        SalesSetup: Record "Sales & Receivables Setup";
                        UserSetup: Record "User Setup";
                        //NoSeriesMgt: Codeunit NoSeriesManagement;
                        AcctType: Enum "Gen. Journal Account Type";
                        TransType: Enum "Transaction Type Enum";
                        pAmt: Decimal;
                        iAmt: Decimal;
                        pdate: Date;
                        sdate: Date;
                        edate: Date;
                        DimID: Integer;
                        SaccoSetup: Record "Sacco Setup";
                        BLedger: Record "Bank Account Ledger Migration";
                        j: Integer;
                        TotalAmt: Decimal;

                    begin
                        if Confirm('Are you sure you want to Post Banks Data ?') then begin

                            edate := DMY2Date(03, 07, 2026);
                            sdate := DMY2Date(01, 01, 2026);

                            SaccoSetup.Get();
                            SaccoSetup.TestField("Opening Balances GL");
                            //SaccoSetup.TestField("Go Live Date");

                            CurrentRecordNo := 0;
                            NoOfRecords := 0;
                            UserSetup.Get(UserId);
                            pdate := SaccoSetup."Go Live Date"; //DMY2Date(20, 04, 2025);
                            edate := pdate;
                            SActivities.JournalInit(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                            if pdate = 0D then
                                pdate := sdate;

                            While pdate <= edate do begin

                                Banks.Reset();
                                IF Banks.FindFirst() THEN begin
                                    repeat
                                        BLedger.Reset();
                                        BLedger.SetRange(Posted, false);
                                        BLedger.SetRange("Bank Account No.", Banks."No.");
                                        BLedger.SetRange("Posting Date", CalcDate('-CM', pdate), CalcDate('CM', pdate));
                                        BLedger.SetRange(Reversed, false);
                                        if BLedger.FindFirst() then begin
                                            NoOfRecords := BLedger.Count;
                                            SActivities.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
                                            pAmt := 0;
                                            iAmt := 0;
                                            CurrentRecordNo := 0;
                                            TotalAmt := 0;
                                            SActivities.JournalInit(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                                            repeat
                                                CurrentRecordNo += 1;
                                                SActivities.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, Banks.Name);


                                                DimID := 0;
                                                BLedger.Posted := true;
                                                BLedger.Modify();
                                                SActivities.JournalInsert(UserSetup."General Journal Template", UserSetup."General Journal Batch", BLedger."Document No.", BLedger."Posting Date", Accttype::"Bank Account", Banks."No.", CopyStr(BLedger.Description, 1, 50), AcctType::"G/L Account",
                                                    SaccoSetup."Opening Balances GL", BLedger."Amount (LCY)", BLedger."External Document No.", '', TransType::" ", Banks."Global Dimension 1 Code", Banks."Global Dimension 2 Code", TRUE, TChannel::"Open Balance", DimID);


                                            until BLedger.Next() = 0;
                                            SActivities.ProgressClose(dWindow);

                                            SActivities.JournalPost(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                                        end;


                                    until Banks.Next() = 0;
                                end;

                                PDate := CalcDate('1M+CM', PDate);
                            end;



                        end;
                    end;

                }

                action(PostAccounts)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    trigger OnAction()

                    var
                        UPGLoans: Record SaccoLoans;
                        PSetup: Record "Product Setup";
                        Member: Record Members;
                        Accounts: Record "Savings Accounts";
                        dWindow: Dialog;
                        CurrentRecordNo: Integer;
                        NoOfRecords: Integer;
                        SActivities: Codeunit "Sacco Activities";
                        MNo: Code[20];
                        SalesSetup: Record "Sales & Receivables Setup";
                        UserSetup: Record "User Setup";
                        //NoSeriesMgt: Codeunit NoSeriesManagement;
                        AcctType: Enum "Gen. Journal Account Type";
                        TransType: Enum "Transaction Type Enum";
                        pAmt: Decimal;
                        iAmt: Decimal;
                        pdate: Date;
                        sdate: Date;
                        edate: Date;
                        DimID: Integer;
                        SaccoSetup: Record "Sacco Setup";
                        MLedger: Record "Member Ledger Entry Migration";
                        j: Integer;
                        TotalAmt: Decimal;

                    begin
                        if Confirm('Are you sure you want to Post Accounts Data ?') then begin

                            edate := DMY2Date(03, 07, 2026);
                            sdate := DMY2Date(01, 01, 2026);

                            SaccoSetup.Get();
                            SaccoSetup.TestField("Opening Balances GL");
                            //SaccoSetup.TestField("Go Live Date");

                            CurrentRecordNo := 0;
                            NoOfRecords := 0;
                            UserSetup.Get(UserId);
                            pdate := SaccoSetup."Go Live Date"; //DMY2Date(20, 04, 2025);
                            edate := pdate;
                            SActivities.JournalInit(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                            if pdate = 0D then
                                pdate := sdate;

                            While pdate <= edate do begin

                                pSetup.Reset();
                                pSetup.SetRange("Product Class", pSetup."Product Class"::Savings);
                                IF pSetup.FindFirst() THEN begin
                                    repeat
                                        MLedger.Reset();
                                        MLedger.SetRange(Posted, false);
                                        MLedger.SetRange("ProductID", pSetup."Product ID");
                                        MLedger.SetRange("Posting Date", CalcDate('-CM', pdate), CalcDate('CM', pdate));
                                        MLedger.SetRange(Reversed, false);
                                        MLedger.SetRange(MemberFound, true);
                                        MLedger.SetFilter("Loan No", '%1', '');
                                        if MLedger.FindFirst() then begin
                                            NoOfRecords := MLedger.Count;
                                            SActivities.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
                                            pAmt := 0;
                                            iAmt := 0;
                                            CurrentRecordNo := 0;
                                            TotalAmt := 0;
                                            SActivities.JournalInit(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                                            repeat
                                                CurrentRecordNo += 1;
                                                SActivities.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, pSetup.Description);

                                                if Accounts.Get(MLedger."AccountNo") then begin
                                                    DimID := Accounts."Dimension Set ID";
                                                    MLedger.Posted := true;
                                                    MLedger.Modify();
                                                    SActivities.JournalInsert(UserSetup."General Journal Template", UserSetup."General Journal Batch", MLedger."Document No.", MLedger."Posting Date", Accttype::Savings, Accounts."No.", CopyStr(MLedger.Description, 1, 50), AcctType::"G/L Account",
                                                        SaccoSetup."Opening Balances GL", MLedger."Amount (LCY)", MLedger."External Document No.", '', TransType, Accounts."Global Dimension 1 Code", Accounts."Global Dimension 2 Code", TRUE, TChannel::"Open Balance", DimID);
                                                end;

                                            until MLedger.Next() = 0;
                                            SActivities.ProgressClose(dWindow);

                                            SActivities.JournalPost(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                                        end;


                                    until pSetup.Next() = 0;
                                end;

                                PDate := CalcDate('1M+CM', PDate);
                            end;



                        end;
                    end;

                }

                action(PostLoans)
                {
                    Image = ViewComments;
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    trigger OnAction()

                    var
                        UPGLoans: Record SaccoLoans;
                        PSetup: Record "Product Setup";
                        Member: Record Members;
                        Loans: Record Loans;
                        dWindow: Dialog;
                        CurrentRecordNo: Integer;
                        NoOfRecords: Integer;
                        SActivities: Codeunit "Sacco Activities";
                        MNo: Code[20];
                        SalesSetup: Record "Sales & Receivables Setup";
                        UserSetup: Record "User Setup";
                        //NoSeriesMgt: Codeunit NoSeriesManagement;
                        AcctType: Enum "Gen. Journal Account Type";
                        TransType: Enum "Transaction Type Enum";
                        pAmt: Decimal;
                        iAmt: Decimal;
                        pdate: Date;
                        sdate: Date;
                        edate: Date;
                        DimID: Integer;
                        SaccoSetup: Record "Sacco Setup";
                        MLedger: Record "Member Ledger Entry Migration";
                        j: Integer;
                        TotalAmt: Decimal;

                    begin
                        if Confirm('Are you sure you want to Post Loan Data ?') then begin

                            edate := DMY2Date(03, 07, 2026);
                            sdate := DMY2Date(01, 01, 2026);

                            SaccoSetup.Get();
                            SaccoSetup.TestField("Opening Balances GL");
                            //SaccoSetup.TestField("Go Live Date");

                            CurrentRecordNo := 0;
                            NoOfRecords := 0;
                            UserSetup.Get(UserId);
                            pdate := SaccoSetup."Go Live Date"; //DMY2Date(20, 04, 2025);
                            edate := pdate;
                            SActivities.JournalInit(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                            //pdate := sdate;
                            if pdate = 0D then
                                pdate := sdate;

                            While pdate <= edate do begin

                                pSetup.Reset();
                                pSetup.SetRange("Product Class", pSetup."Product Class"::Credit);
                                IF pSetup.FindFirst() THEN begin
                                    repeat
                                        MLedger.Reset();
                                        MLedger.SetRange(Posted, false);
                                        MLedger.SetFilter("Loan No", '<>%1', '');
                                        MLedger.SetRange("ProductID", pSetup."Product ID");
                                        MLedger.SetRange("Posting Date", CalcDate('-CM', pdate), CalcDate('CM', pdate));
                                        MLedger.SetRange(Reversed, false);
                                        MLedger.SetRange(MemberFound, true);
                                        if MLedger.FindFirst() then begin
                                            NoOfRecords := MLedger.Count;
                                            SActivities.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
                                            pAmt := 0;
                                            iAmt := 0;
                                            CurrentRecordNo := 0;
                                            TotalAmt := 0;
                                            SActivities.JournalInit(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                                            repeat
                                                CurrentRecordNo += 1;
                                                SActivities.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, pSetup.Description);

                                                TransType := TransType::" ";
                                                case MLedger."Transaction Type" of
                                                    MLedger."Transaction Type"::"Loan":
                                                        TransType := TransType::"Loan Disbursement";
                                                    MLedger."Transaction Type"::Repayment:
                                                        TransType := TransType::"Principal Repayment";
                                                    MLedger."Transaction Type"::"Interest Due":
                                                        TransType := TransType::"Interest Due";
                                                    MLedger."Transaction Type"::"Interest Paid":
                                                        TransType := TransType::"Interest Paid";
                                                    MLedger."Transaction Type"::"Penalty Charged":
                                                        TransType := TransType::"Penalty Due";
                                                    MLedger."Transaction Type"::"Penalty Paid":
                                                        TransType := TransType::"Penalty Paid";
                                                    MLedger."Transaction Type"::Insurance_Charge:
                                                        TransType := TransType::"Insurance Due";
                                                    MLedger."Transaction Type"::"Insurance Paid":
                                                        TransType := TransType::"Insurance Paid";
                                                end;

                                                if TransType <> TransType::" " then begin
                                                    if Loans.Get(MLedger."Loan No") then begin
                                                        DimID := Loans."Dimension Set ID";
                                                        MLedger.Posted := true;
                                                        MLedger.Modify();
                                                        SActivities.JournalInsert(UserSetup."General Journal Template", UserSetup."General Journal Batch", MLedger."Document No.", MLedger."Posting Date", Accttype::Credit, Loans."Loan Account", CopyStr(MLedger.Description, 1, 50), AcctType::"G/L Account",
                                                            SaccoSetup."Opening Balances GL", MLedger."Amount (LCY)", MLedger."External Document No.", loans."Loan No.", TransType, Loans."Global Dimension 1 Code", Loans."Booking Branch", TRUE, TChannel::"Open Balance", DimID);
                                                    end;
                                                end;

                                            until MLedger.Next() = 0;
                                            SActivities.ProgressClose(dWindow);

                                            SActivities.JournalPost(UserSetup."General Journal Template", UserSetup."General Journal Batch");
                                        end;


                                    until pSetup.Next() = 0;
                                end;

                                pdate := CalcDate('1M+CM', pdate);


                            end;



                        end;
                    end;

                }

                action(RunCopyMigrationData)
                {
                    ApplicationArea = All;
                    Caption = 'Copy Migration Data';
                    Image = CopyLedgerToBudget;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Report.RunModal(Report::"Copy Migration Data");
                    end;
                }

            }

            group(Other)
            {
                Visible = true;
               

                action(DeleteEmailLogEntries)
                {
                    ApplicationArea = All;
                    Caption = 'Delete Email Log Entries';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Category11;
                    PromotedIsBig = true;
                    ToolTip = 'Permanently deletes matching Email Logs Notifications records. At least one filter is required.';

                    trigger OnAction()
                    var
                        EmailLog: Record "Email Logs Notifications";
                        EntriesToDelete: Integer;
                        DeletedEntries: Integer;
                        HasFilters: Boolean;
                    begin
                        EmailLogLoanNoFilter := DelChr(EmailLogLoanNoFilter, '<>');
                        EmailLogLineFilter := DelChr(EmailLogLineFilter, '<>');
                        EmailLogSourceFilter := DelChr(EmailLogSourceFilter, '<>');

                        HasFilters := (EmailLogLoanNoFilter <> '') or
                                      (EmailLogLineFilter <> '') or
                                      (EmailLogSourceFilter <> '');

                        EmailLog.Reset();
                        if EmailLogLoanNoFilter <> '' then
                            EmailLog.SetFilter("Loan No.", EmailLogLoanNoFilter);
                        if EmailLogLineFilter <> '' then
                            EmailLog.SetFilter(Line, EmailLogLineFilter);
                        if EmailLogSourceFilter <> '' then
                            EmailLog.SetFilter(Source, EmailLogSourceFilter);

                        EntriesToDelete := EmailLog.Count();
                        if EntriesToDelete = 0 then begin
                            Message('No email log entries matched the supplied filters.');
                            exit;
                        end;

                        if HasFilters then begin
                            if not Confirm(
                                'Permanently delete %1 matching email log entry/entries? This cannot be undone.',
                                false,
                                EntriesToDelete)
                            then
                                exit;
                        end else
                            if not Confirm(
                                'No filters are entered. Permanently delete ALL %1 email log entry/entries? This cannot be undone.',
                                false,
                                EntriesToDelete)
                            then
                                exit;

                        EmailLog.DeleteAll(true);
                        DeletedEntries := EntriesToDelete;

                        Message('%1 email log entry/entries deleted.', DeletedEntries);
                        Clear(EmailLogLoanNoFilter);
                        Clear(EmailLogLineFilter);
                        Clear(EmailLogSourceFilter);
                        CurrPage.Update(false);
                    end;
                }
                action(DeleteAllEmailLogEntries)
                {
                    ApplicationArea = All;
                    Caption = 'Delete All Email Log Entries';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Category11;
                    PromotedIsBig = true;
                    ToolTip = 'Permanently deletes every Email Logs Notifications record after showing the total and asking for confirmation.';

                    trigger OnAction()
                    var
                        EmailLog: Record "Email Logs Notifications";
                        EntriesToDelete: Integer;
                    begin
                        EmailLog.Reset();
                        EntriesToDelete := EmailLog.Count();
                        if EntriesToDelete = 0 then begin
                            Message('There are no email log entries to delete.');
                            exit;
                        end;

                        if not Confirm(
                            'Permanently delete ALL %1 email log entry/entries? This cannot be undone.',
                            false,
                            EntriesToDelete)
                        then
                            exit;

                        EmailLog.DeleteAll(true);
                        Message('%1 email log entry/entries deleted.', EntriesToDelete);
                    end;
                }
            }
        }
    }


    trigger OnInit()
    begin
        RestrictAccess
    end;

    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange("General Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "General Setups"');
    end;

    local procedure ResolveFixedDepositLedgerTarget()
    var
        FixedDepositAccount: Record "Fixed Deposit Accounts";
        TargetSavingsAccount: Record "Savings Accounts";
    begin
        Clear(FDLedgerTargetFixedAccountNo);
        Clear(FDLedgerTargetAccountName);
        if FDLedgerFixedDepositNo = '' then
            exit;

        FixedDepositAccount.Get(FDLedgerFixedDepositNo);
        FixedDepositAccount.TestField("Fixed Account No.");
        FDLedgerTargetFixedAccountNo := FixedDepositAccount."Fixed Account No.";

        TargetSavingsAccount.Get(FDLedgerTargetFixedAccountNo);
        TargetSavingsAccount.TestField("Product Category", TargetSavingsAccount."Product Category"::"Fixed Deposit");
        FDLedgerTargetAccountName := TargetSavingsAccount.Name;
    end;

    local procedure ApplyLoanSecurityDeleteFilters(var LoanSecurity: Record "Loan Security")
    begin
        LoanSecurity.Reset();
        LoanSecurity.SetRange("Loan No.", LoanSecurityLoanNoToDelete);
        if LoanSecurityFilterByGuarantorType then
            LoanSecurity.SetRange("Guarantor Type", LoanSecurityGuarantorTypeToDelete);
        if LoanSecurityMemberNoToDelete <> '' then
            LoanSecurity.SetRange("Member No", LoanSecurityMemberNoToDelete);
        if LoanSecurityAccountNoToDelete <> '' then
            LoanSecurity.SetRange("Account No.", LoanSecurityAccountNoToDelete);
        if LoanSecurityCollateralNoToDelete <> '' then
            LoanSecurity.SetRange("Collateral Reg. No.", LoanSecurityCollateralNoToDelete);
    end;

    local procedure ExtractMemberNoFromGLEntryDescription(DescriptionText: Text[100]): Code[20]
    var
        FirstColonPosition: Integer;
        SecondPartText: Text[100];
        SecondColonPosition: Integer;
        CandidateMemberNo: Text[100];
    begin
        FirstColonPosition := StrPos(DescriptionText, ':');
        if FirstColonPosition <= 1 then
            exit('');

        CandidateMemberNo := CopyStr(DescriptionText, 1, FirstColonPosition - 1);
        if CopyStr(UpperCase(CandidateMemberNo), 1, 4) <> 'BANK' then
            exit(CopyStr(CandidateMemberNo, 1, 20));

        SecondPartText := CopyStr(DescriptionText, FirstColonPosition + 1);
        SecondColonPosition := StrPos(SecondPartText, ':');
        if SecondColonPosition <= 1 then
            exit('');

        CandidateMemberNo := CopyStr(SecondPartText, 1, SecondColonPosition - 1);
        exit(CopyStr(CandidateMemberNo, 1, 20));
    end;

    local procedure GLEntryHasLinkedBankLedgerEntry(GLEntry: Record "G/L Entry"): Boolean
    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        BankAccountPostingGroup: Record "Bank Account Posting Group";
    begin
        if GLEntry."Transaction No." <> 0 then begin
            BankLedgerEntry.Reset();
            BankLedgerEntry.SetRange("Transaction No.", GLEntry."Transaction No.");
            BankLedgerEntry.SetRange(Reversed, false);
            if not BankLedgerEntry.IsEmpty() then
                exit(true);
        end;

        if (GLEntry."Document No." = '') or (GLEntry."External Document No." = '') then
            exit(false);

        BankLedgerEntry.Reset();
        BankLedgerEntry.SetRange("Document No.", GLEntry."Document No.");
        BankLedgerEntry.SetRange("External Document No.", GLEntry."External Document No.");
        BankLedgerEntry.SetRange(Reversed, false);
        if not BankLedgerEntry.IsEmpty() then
            exit(true);

        if GLEntry."G/L Account No." = '' then
            exit(false);

        BankAccountPostingGroup.Reset();
        BankAccountPostingGroup.SetRange("G/L Account No.", GLEntry."G/L Account No.");
        exit(not BankAccountPostingGroup.IsEmpty());
    end;

    local procedure MatchingSavingsLedgerEntryExists(CreditLedgerEntry: Record "Credit Ledger Entry"): Boolean
    var
        SavingsLedgerEntry: Record "Savings Ledger Entry";
    begin
        if CreditLedgerEntry."External Document No." = '' then
            exit(false);

        SavingsLedgerEntry.Reset();
        SavingsLedgerEntry.SetRange("External Document No.", CreditLedgerEntry."External Document No.");
        SavingsLedgerEntry.SetRange(Reversed, false);
        if CreditLedgerEntry."Member No." <> '' then
            SavingsLedgerEntry.SetRange("Member No.", CreditLedgerEntry."Member No.");

        exit(not SavingsLedgerEntry.IsEmpty());
    end;

    local procedure MatchingSavingsLedgerEntryExistsForDocumentLine(DocLine: Record "Document Line"): Boolean
    var
        SavingsLedgerEntry: Record "Savings Ledger Entry";
    begin
        if DocLine."External Doc." = '' then
            exit(false);

        SavingsLedgerEntry.Reset();
        SavingsLedgerEntry.SetRange("External Document No.", DocLine."External Doc.");
        SavingsLedgerEntry.SetRange(Reversed, false);
        SavingsLedgerEntry.SetRange("Document No.", DocLine."Header No.");
        if DocLine."Member No." <> '' then
            SavingsLedgerEntry.SetRange("Member No.", DocLine."Member No.");
        if DocLine."Account No." <> '' then
            SavingsLedgerEntry.SetRange("Account No.", DocLine."Account No.");

        exit(not SavingsLedgerEntry.IsEmpty());
    end;

    local procedure GetSavingsDocumentLineExtDocUpdateKey(DocLine: Record "Document Line"): Text
    begin
        exit(CopyStr(DocLine."Header No." + '|' + DocLine."Member No." + '|' + DocLine."Account No." + '|' + Format(DocLine."Posting Date") + '|' + DocLine."External Doc.", 1, 250));
    end;

    local procedure UpdateSavingsLedgerExternalDocNoFromDocumentLine(DocLine: Record "Document Line"): Integer
    var
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        UpdatedEntries: Integer;
    begin
        if DocLine."External Doc." = '' then
            exit(0);

        DocLine.TestField("Account Type", DocLine."Account Type"::Savings);
        DocLine.TestField("Account No.");
        DocLine.TestField("Header No.");

        SavingsLedgerEntry.Reset();
        SavingsLedgerEntry.SetRange(Reversed, false);
        SavingsLedgerEntry.SetRange("External Document No.", '');
        SavingsLedgerEntry.SetRange("Document No.", DocLine."Header No.");
        SavingsLedgerEntry.SetRange("Account No.", DocLine."Account No.");
        /* if DocLine."Member No." <> '' then
            SavingsLedgerEntry.SetRange("Member No.", DocLine."Member No.");
        if DocLine."Posting Date" <> 0D then
            SavingsLedgerEntry.SetRange("Posting Date", DocLine."Posting Date"); */

        if SavingsLedgerEntry.FindSet(true) then
            repeat
                SavingsLedgerEntry."External Document No." := DocLine."External Doc.";
                SavingsLedgerEntry.Modify();
                UpdatedEntries += 1;
            until SavingsLedgerEntry.Next() = 0;

        exit(UpdatedEntries);
    end;

    local procedure GetCreditLedgerSavingsExtDocUpdateKey(CreditLedgerEntry: Record "Credit Ledger Entry"): Text
    begin
        if CreditLedgerEntry."Transaction No." <> 0 then
            exit(CopyStr(Format(CreditLedgerEntry."Transaction No.") + '|' + CreditLedgerEntry."Member No." + '|' + CreditLedgerEntry."External Document No.", 1, 250));

        exit(CopyStr(CreditLedgerEntry."Document No." + '|' + Format(CreditLedgerEntry."Posting Date") + '|' + CreditLedgerEntry."Member No." + '|' + CreditLedgerEntry."External Document No.", 1, 250));
    end;

    local procedure UpdateMatchingSavingsLedgerExternalDocNo(CreditLedgerEntry: Record "Credit Ledger Entry"): Integer
    var
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        UpdatedEntries: Integer;
    begin
        if CreditLedgerEntry."External Document No." = '' then
            exit(0);

        UpdatedEntries := UpdateReceiptCardSavingsLedgerExternalDocNo(CreditLedgerEntry);
        if UpdatedEntries > 0 then
            exit(UpdatedEntries);

        SavingsLedgerEntry.Reset();
        SavingsLedgerEntry.SetRange(Reversed, false);
        SavingsLedgerEntry.SetRange("External Document No.", '');
        if CreditLedgerEntry."Transaction No." <> 0 then
            SavingsLedgerEntry.SetRange("Transaction No.", CreditLedgerEntry."Transaction No.")
        else begin
            SavingsLedgerEntry.SetRange("Document No.", CreditLedgerEntry."Document No.");
            SavingsLedgerEntry.SetRange("Posting Date", CreditLedgerEntry."Posting Date");
        end;

        if CreditLedgerEntry."Member No." <> '' then
            SavingsLedgerEntry.SetRange("Member No.", CreditLedgerEntry."Member No.");

        if SavingsLedgerEntry.FindSet(true) then
            repeat
                SavingsLedgerEntry."External Document No." := CreditLedgerEntry."External Document No.";
                SavingsLedgerEntry.Modify();
                UpdatedEntries += 1;
            until SavingsLedgerEntry.Next() = 0;

        exit(UpdatedEntries);
    end;

    local procedure UpdateReceiptCardSavingsLedgerExternalDocNo(CreditLedgerEntry: Record "Credit Ledger Entry"): Integer
    var
        DocLine: Record "Document Line";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        UpdatedEntries: Integer;
    begin
        if (CreditLedgerEntry."Document No." = '') or (CreditLedgerEntry."External Document No." = '') then
            exit(0);

        DocLine.Reset();
        DocLine.SetCurrentKey("Header No.", "Account Type", "Account No.", "Transaction Type", "Loan No.", Type, "Line No.", "Entry No.");
        DocLine.SetRange("Header No.", CreditLedgerEntry."Document No.");
        DocLine.SetRange("Member No.", CreditLedgerEntry."Member No.");
        DocLine.SetRange("External Doc.", CreditLedgerEntry."External Document No.");
        if not DocLine.FindSet() then
            exit(0);

        repeat
            SavingsLedgerEntry.Reset();
            SavingsLedgerEntry.SetRange(Reversed, false);
            SavingsLedgerEntry.SetRange("External Document No.", '');
            SavingsLedgerEntry.SetRange("Document No.", CreditLedgerEntry."Document No.");
            SavingsLedgerEntry.SetRange("Member No.", CreditLedgerEntry."Member No.");
            SavingsLedgerEntry.SetRange("Posting Date", DocLine."Posting Date");

            case DocLine."Account Type" of
                DocLine."Account Type"::Savings:
                    SavingsLedgerEntry.SetRange("Account No.", DocLine."Account No.");
                DocLine."Account Type"::Credit:
                    begin
                        SavingsLedgerEntry.SetRange("Bal. Account Type", SavingsLedgerEntry."Bal. Account Type"::Credit);
                        SavingsLedgerEntry.SetRange("Bal. Account No.", DocLine."Account No.");
                    end;
                else
                    SavingsLedgerEntry.SetRange("Entry No.", 0);
            end;

            if not SavingsLedgerEntry.IsEmpty() then
                if SavingsLedgerEntry.FindSet(true) then
                    repeat
                        SavingsLedgerEntry."External Document No." := CreditLedgerEntry."External Document No.";
                        SavingsLedgerEntry.Modify();
                        UpdatedEntries += 1;
                    until SavingsLedgerEntry.Next() = 0;
        until DocLine.Next() = 0;

        exit(UpdatedEntries);
    end;

    local procedure CreditLedgerIsReceiptOrBankPosting(CreditLedgerEntry: Record "Credit Ledger Entry"): Boolean
    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        if CreditLedgerEntry.Channel = CreditLedgerEntry.Channel::Receipt then
            exit(true);

        if CopyStr(UpperCase(CreditLedgerEntry."Document No."), 1, 3) = 'RCT' then
            exit(true);

        if CreditLedgerEntry."Transaction No." <> 0 then begin
            BankLedgerEntry.Reset();
            BankLedgerEntry.SetRange("Transaction No.", CreditLedgerEntry."Transaction No.");
            BankLedgerEntry.SetRange(Reversed, false);
            if not BankLedgerEntry.IsEmpty() then
                exit(true);
        end;

        if (CreditLedgerEntry."Document No." = '') or (CreditLedgerEntry."External Document No." = '') then
            exit(false);

        BankLedgerEntry.Reset();
        BankLedgerEntry.SetRange("Document No.", CreditLedgerEntry."Document No.");
        BankLedgerEntry.SetRange("External Document No.", CreditLedgerEntry."External Document No.");
        BankLedgerEntry.SetRange(Reversed, false);
        exit(not BankLedgerEntry.IsEmpty());
    end;

    local procedure IsAllowedSkyPostingDateCorrectionTransaction(TransactionID: Code[100]): Boolean
    begin
        case TransactionID of
            'UG1P69PQRY', 'UG1RF9TK1M', 'UG1909IQ7O', 'UG1LT9J4VW', 'UG1EO9TOIJ', 'UG11NA8NCS', 'UG1JW9DB9H', 'UG19S9PP5P', 'UG19S9PQ6I', 'UG1029T68S',
            'UG1JCA1MRM', 'UG1JCA1O55', 'UG1U91FKR4', 'UG2UG0RYLK', 'UG2BUA63EL', 'UG2DB9NV2Q', 'UG2U91FS31', 'UG2GM9WUQO', 'UG2339T4E6', 'UG2H39VENW',
            'UG264AF33I', 'UG26E9KAFI', 'UG2RG9YYFB', 'UG2RG9Z10E', 'UG21C9PKF1', 'UG21C9PKFX', 'UG21C9PKGU', 'UG2RNA7HEY', 'UG2ERA9CUL', 'UG29PA1CVT',
            'UG22G9VSSF', 'UG2MC9PG1V', 'UG2NGA1TMM', 'UG2R59QJ8F', 'UG277A7D05', 'UG277A7H9E', 'UG3849RGF4', 'UG3849RM1A', 'UG32FA55ZI', 'UG38HA21SB',
            'UG31YA845N', 'UG32RA6ZTQ', 'UG369A19T3', 'UG3GAA93VU', 'UG3FOA31N2', 'UG2559QJXX', 'UG61NATLHR', 'UG6ISA71A0', 'UG6FAAJNUZ', 'UG69YA3CNK',
            'UG73BB04AS', 'UG7QEA6DE9', 'UG6U91M91C', 'UG7N3AJ8G3', 'UG7P9AJGGQ', 'UG7SG31T24', 'UG7L3ANIAF', 'UG7G2A8P3H', 'UG72UAL3LV', 'UG7QCAGYSO',
            'UG7HUA6V3B', 'UG7P4AD9I3', 'UG7OLAKXU8', 'UG7S82EAYP', 'UG7S82E5BO', 'UG7NDA7B3N', 'UG7FAANKLQ', 'UG6QEA2B3M', 'UG88TALKCM', 'UG8AQAEHET',
            'UG8FPAD0FH', 'UG8MTAKI6J', 'UG85VAK9LT', 'UG8CIALGC3', 'UG89RAJO71', 'UG7NOAQQES', 'UG8RBAKAI3', 'UG8M7AU9XT', 'UG773ATVBO':
                exit(true);
        end;

        exit(false);
    end;

    local procedure GetLoanScheduleDepositInsuranceAmounts(LoanNo: Code[20]; var DepositAmount: Decimal; var InsuranceAmount: Decimal; var FoundDeposit: Boolean; var FoundInsurance: Boolean)
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        Clear(DepositAmount);
        Clear(InsuranceAmount);
        Clear(FoundDeposit);
        Clear(FoundInsurance);

        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetCurrentKey("Loan No.", "Repayment Date", "Member No.");
        LoanRepaymentSchedule.SetRange("Loan No.", LoanNo);
        if LoanRepaymentSchedule.FindSet() then
            repeat
                if (not FoundDeposit) and (LoanRepaymentSchedule."Deposit Amount" <> 0) then begin
                    DepositAmount := LoanRepaymentSchedule."Deposit Amount";
                    FoundDeposit := true;
                end;

                if (not FoundInsurance) and (LoanRepaymentSchedule."Insurance Contribution" <> 0) then begin
                    InsuranceAmount := LoanRepaymentSchedule."Insurance Contribution";
                    FoundInsurance := true;
                end;
            until (LoanRepaymentSchedule.Next() = 0) or (FoundDeposit and FoundInsurance);
    end;

    local procedure UpdateVendorAndGLEntryDescriptionsFromGLMigration()
    var
        GLEntryMigration: Record "G/L Entry Migration";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        BlankVendorEntries: Integer;
        UpdatedGLEntries: Integer;
        UpdatedVendorEntries: Integer;
        SkippedVendorEntries: Integer;
    begin
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetRange(Description, '');
        BlankVendorEntries := VendorLedgerEntry.Count();
        if BlankVendorEntries = 0 then begin
            Message('No Vendor Ledger Entry records with missing descriptions were found.');
            exit;
        end;

        if not Confirm(
            'Update %1 blank Vendor Ledger Entry description(s), and their matching blank G/L Entry descriptions, from G/L Entry Migration?',
            false,
            BlankVendorEntries)
        then
            exit;

        if VendorLedgerEntry.FindSet(true) then
            repeat
                if FindVendorDescriptionGLEntryMigration(VendorLedgerEntry, GLEntryMigration) then begin
                    VendorLedgerEntry.Description := CopyStr(GLEntryMigration.Description, 1, MaxStrLen(VendorLedgerEntry.Description));
                    VendorLedgerEntry.Modify(false);
                    UpdatedVendorEntries += 1;
                    UpdatedGLEntries += UpdateMissingGLEntryDescriptionsForVendorLedgerEntry(VendorLedgerEntry);
                end else
                    SkippedVendorEntries += 1;
            until VendorLedgerEntry.Next() = 0;

        Message(
            'Description update completed.\G/L Entries updated: %1\Vendor Ledger Entries updated: %2\Blank Vendor Ledger Entries skipped: %3',
            UpdatedGLEntries,
            UpdatedVendorEntries,
            SkippedVendorEntries);
    end;

    local procedure UpdateMissingGLEntryDescriptionsForVendorLedgerEntry(VendorLedgerEntry: Record "Vendor Ledger Entry"): Integer
    var
        GLEntryMigration: Record "G/L Entry Migration";
        GLEntry: Record "G/L Entry";
        UpdatedGLEntries: Integer;
    begin
        GLEntryMigration.Reset();
        GLEntryMigration.SetRange("Posting Date", VendorLedgerEntry."Posting Date");
        GLEntryMigration.SetRange("Document No.", VendorLedgerEntry."Document No.");
        GLEntryMigration.SetFilter(Description, '<>%1', '');
        if VendorLedgerEntry."External Document No." <> '' then
            GLEntryMigration.SetRange("External Document No.", VendorLedgerEntry."External Document No.");
        /* if VendorLedgerEntry."Transaction No." <> 0 then
            GLEntryMigration.SetRange("Transaction No.", VendorLedgerEntry."Transaction No."); */

        if GLEntryMigration.FindSet() then
            repeat
                if FindGLEntryFromGLEntryMigration(GLEntryMigration, GLEntry) then
                    if GLEntry.Description = '' then begin
                        GLEntry.Description := CopyStr(GLEntryMigration.Description, 1, MaxStrLen(GLEntry.Description));
                        GLEntry.Modify(false);
                        UpdatedGLEntries += 1;
                    end;
            until GLEntryMigration.Next() = 0;

        exit(UpdatedGLEntries);
    end;

    local procedure FindGLEntryFromGLEntryMigration(GLEntryMigration: Record "G/L Entry Migration"; var GLEntry: Record "G/L Entry"): Boolean
    begin
        if (GLEntryMigration."Entry No." <> 0) and GLEntry.Get(GLEntryMigration."Entry No.") then
            exit(true);

        GLEntry.Reset();
        GLEntry.SetRange("Posting Date", GLEntryMigration."Posting Date");
        GLEntry.SetRange("Document No.", GLEntryMigration."Document No.");
        GLEntry.SetRange("G/L Account No.", GLEntryMigration."G/L Account No.");
        /* if GLEntryMigration."Transaction No." <> 0 then
            GLEntry.SetRange("Transaction No.", GLEntryMigration."Transaction No."); */
        /* if GLEntryMigration."Source No." <> '' then
            GLEntry.SetRange("Source No.", GLEntryMigration."Source No."); */
        if GLEntryMigration."External Document No." <> '' then
            GLEntry.SetRange("External Document No.", GLEntryMigration."External Document No.");

        if GLEntry.FindSet() then
            repeat
                if AmountsAreEqual(GLEntry.Amount, GLEntryMigration.Amount) then
                    exit(true);
            until GLEntry.Next() = 0;

        exit(false);
    end;

    local procedure FindVendorDescriptionGLEntryMigration(VendorLedgerEntry: Record "Vendor Ledger Entry"; var GLEntryMigration: Record "G/L Entry Migration"): Boolean
    begin
        VendorLedgerEntry.CalcFields(Amount, "Amount (LCY)");

        GLEntryMigration.Reset();
        GLEntryMigration.SetRange("Posting Date", VendorLedgerEntry."Posting Date");
        GLEntryMigration.SetRange("Document No.", VendorLedgerEntry."Document No.");
        //GLEntryMigration.SetRange("Source Type", GLEntryMigration."Source Type"::Vendor);
        //GLEntryMigration.SetRange("Source No.", VendorLedgerEntry."Vendor No.");
        GLEntryMigration.SetFilter(Description, '<>%1', '');
        if VendorLedgerEntry."External Document No." <> '' then
            GLEntryMigration.SetRange("External Document No.", VendorLedgerEntry."External Document No.");

        if GLEntryMigration.FindSet() then
            repeat
                if AmountsAreEqual(GLEntryMigration.Amount, VendorLedgerEntry."Amount (LCY)") or
                   AmountsAreEqual(GLEntryMigration.Amount, VendorLedgerEntry.Amount)
                then
                    exit(true);
            until GLEntryMigration.Next() = 0;

        exit(false);
    end;

    local procedure AmountsAreEqual(Amount1: Decimal; Amount2: Decimal): Boolean
    begin
        exit(Abs(Amount1 - Amount2) < 0.01);
    end;

    local procedure CountBankLedgerEntriesWithDifferentAmountAndRemainingAmount(var BankLedgerEntry: Record "Bank Account Ledger Entry"): Integer
    var
        BankLedgerEntryToCount: Record "Bank Account Ledger Entry";
        EntriesToUpdate: Integer;
    begin
        BankLedgerEntryToCount.CopyFilters(BankLedgerEntry);
        if BankLedgerEntryToCount.FindSet() then
            repeat
                if not AmountsAreEqual(BankLedgerEntryToCount.Amount, BankLedgerEntryToCount."Remaining Amount") then
                    EntriesToUpdate += 1;
            until BankLedgerEntryToCount.Next() = 0;

        exit(EntriesToUpdate);
    end;

    local procedure NormalizeLedgerReversalFilters()
    begin
        LedgerReversalEntryNoFilter := DelChr(LedgerReversalEntryNoFilter, '<>');
        LedgerReversalDocumentNoFilter := DelChr(LedgerReversalDocumentNoFilter, '<>');
        LedgerReversalExternalDocNoFilter := DelChr(LedgerReversalExternalDocNoFilter, '<>');
        LedgerReversalTransactionNoFilter := DelChr(LedgerReversalTransactionNoFilter, '<>');
        LedgerReversalPostingDateFilter := DelChr(LedgerReversalPostingDateFilter, '<>');
    end;

    local procedure LedgerReversalHasSelectiveFilter(): Boolean
    begin
        exit(
            (LedgerReversalEntryNoFilter <> '') or
            (LedgerReversalDocumentNoFilter <> '') or
            (LedgerReversalExternalDocNoFilter <> '') or
            (LedgerReversalTransactionNoFilter <> '') or
            (LedgerReversalPostingDateFilter <> ''));
    end;

    local procedure CountLedgerReversalEntries(): Integer
    var
        GLEntry: Record "G/L Entry";
    begin
        ApplyGLEntryReversalFilters(GLEntry);
        exit(GLEntry.Count());
    end;

    local procedure ApplyLedgerReversedStatus(): Integer
    var
        GLEntry: Record "G/L Entry";
        UpdatedEntries: Integer;
    begin
        ApplyGLEntryReversalFilters(GLEntry);
        if GLEntry.FindSet(true) then
            repeat
                GLEntry.Reversed := LedgerReversalNewValue;
                GLEntry.Modify(false);
                UpdatedEntries += 1;
            until GLEntry.Next() = 0;

        exit(UpdatedEntries);
    end;

    local procedure CountVendorLedgerEntriesFromMatchedGLEntries(var VendorEntriesToUpdate: Integer; var DetailedVendorEntriesToUpdate: Integer)
    var
        GLEntry: Record "G/L Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        ProcessedDocumentNos: Dictionary of [Code[20], Boolean];
        DocumentNo: Code[20];
    begin
        Clear(VendorEntriesToUpdate);
        Clear(DetailedVendorEntriesToUpdate);

        ApplyGLEntryReversalFilters(GLEntry);
        if GLEntry.FindSet() then
            repeat
                DocumentNo := GLEntry."Document No.";
                if (DocumentNo <> '') and (not ProcessedDocumentNos.ContainsKey(DocumentNo)) then begin
                    ProcessedDocumentNos.Add(DocumentNo, true);

                    VendorLedgerEntry.Reset();
                    VendorLedgerEntry.SetRange("Document No.", DocumentNo);
                    VendorEntriesToUpdate += VendorLedgerEntry.Count();

                    DetailedVendorLedgerEntry.Reset();
                    DetailedVendorLedgerEntry.SetRange("Document No.", DocumentNo);
                    DetailedVendorEntriesToUpdate += DetailedVendorLedgerEntry.Count();
                end;
            until GLEntry.Next() = 0;
    end;

    local procedure UpdateVendorLedgerEntriesFromMatchedGLEntries(var UpdatedVendorEntries: Integer; var UpdatedDetailedVendorEntries: Integer)
    var
        GLEntry: Record "G/L Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        ProcessedDocumentNos: Dictionary of [Code[20], Boolean];
        DocumentNo: Code[20];
    begin
        Clear(UpdatedVendorEntries);
        Clear(UpdatedDetailedVendorEntries);

        ApplyGLEntryReversalFilters(GLEntry);
        if GLEntry.FindSet() then
            repeat
                DocumentNo := GLEntry."Document No.";
                if (DocumentNo <> '') and (not ProcessedDocumentNos.ContainsKey(DocumentNo)) then begin
                    ProcessedDocumentNos.Add(DocumentNo, true);

                    VendorLedgerEntry.Reset();
                    VendorLedgerEntry.SetRange("Document No.", DocumentNo);
                    if VendorLedgerEntry.FindSet(true) then
                        repeat
                            VendorLedgerEntry.Reversed := LedgerReversalNewValue;
                            VendorLedgerEntry.Modify(false);
                            UpdatedVendorEntries += 1;
                        until VendorLedgerEntry.Next() = 0;

                    DetailedVendorLedgerEntry.Reset();
                    DetailedVendorLedgerEntry.SetRange("Document No.", DocumentNo);
                    if DetailedVendorLedgerEntry.FindSet(true) then
                        repeat
                            DetailedVendorLedgerEntry.Unapplied := LedgerReversalNewValue;
                            DetailedVendorLedgerEntry.Modify(false);
                            UpdatedDetailedVendorEntries += 1;
                        until DetailedVendorLedgerEntry.Next() = 0;
                end;
            until GLEntry.Next() = 0;
    end;

    local procedure GetVendorLedgerReversalConfirmText(VendorEntriesToUpdate: Integer; DetailedVendorEntriesToUpdate: Integer): Text
    begin
        if (VendorEntriesToUpdate = 0) and (DetailedVendorEntriesToUpdate = 0) then
            exit('');

        exit(StrSubstNo(' and %1 Vendor Ledger Entry record(s), plus %2 Detailed Vendor Ledger Entry record(s), matched by the selected G/L document no(s)', VendorEntriesToUpdate, DetailedVendorEntriesToUpdate));
    end;

    local procedure ApplyGLEntryReversalFilters(var GLEntry: Record "G/L Entry")
    begin
        GLEntry.Reset();
        if LedgerReversalEntryNoFilter <> '' then
            GLEntry.SetFilter("Entry No.", LedgerReversalEntryNoFilter);
        if LedgerReversalDocumentNoFilter <> '' then
            GLEntry.SetFilter("Document No.", LedgerReversalDocumentNoFilter);
        if LedgerReversalExternalDocNoFilter <> '' then
            GLEntry.SetFilter("External Document No.", LedgerReversalExternalDocNoFilter);
        if LedgerReversalTransactionNoFilter <> '' then
            GLEntry.SetFilter("Transaction No.", LedgerReversalTransactionNoFilter);
        if LedgerReversalPostingDateFilter <> '' then
            GLEntry.SetFilter("Posting Date", LedgerReversalPostingDateFilter);
    end;

    local procedure NormalizeVendorLedgerOpenFilters()
    begin
        VendorLedgerEntryNoFilter := DelChr(VendorLedgerEntryNoFilter, '<>');
        VendorLedgerDocumentNoFilter := DelChr(VendorLedgerDocumentNoFilter, '<>');
        VendorLedgerVendorNoFilter := DelChr(VendorLedgerVendorNoFilter, '<>');
        VendorLedgerExternalDocNoFilter := DelChr(VendorLedgerExternalDocNoFilter, '<>');
        VendorLedgerTransactionNoFilter := DelChr(VendorLedgerTransactionNoFilter, '<>');
        VendorLedgerPostingDateFilter := DelChr(VendorLedgerPostingDateFilter, '<>');
    end;

    local procedure VendorLedgerOpenHasSelectiveFilter(): Boolean
    begin
        exit(
            (VendorLedgerEntryNoFilter <> '') or
            (VendorLedgerDocumentNoFilter <> '') or
            (VendorLedgerVendorNoFilter <> '') or
            (VendorLedgerExternalDocNoFilter <> '') or
            (VendorLedgerTransactionNoFilter <> '') or
            (VendorLedgerPostingDateFilter <> ''));
    end;

    local procedure CountVendorLedgerOpenEntries(): Integer
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        ApplyVendorLedgerOpenFilters(VendorLedgerEntry);
        exit(VendorLedgerEntry.Count());
    end;

    local procedure ApplyVendorLedgerOpenStatus(): Integer
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        UpdatedEntries: Integer;
    begin
        ApplyVendorLedgerOpenFilters(VendorLedgerEntry);
        if VendorLedgerEntry.FindSet(true) then
            repeat
                VendorLedgerEntry.Open := VendorLedgerOpenNewValue;
                VendorLedgerEntry.Modify(false);
                UpdatedEntries += 1;
            until VendorLedgerEntry.Next() = 0;

        exit(UpdatedEntries);
    end;

    local procedure ApplyVendorLedgerOpenFilters(var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        VendorLedgerEntry.Reset();
        if VendorLedgerEntryNoFilter <> '' then
            VendorLedgerEntry.SetFilter("Entry No.", VendorLedgerEntryNoFilter);
        if VendorLedgerDocumentNoFilter <> '' then
            VendorLedgerEntry.SetFilter("Document No.", VendorLedgerDocumentNoFilter);
        if VendorLedgerVendorNoFilter <> '' then
            VendorLedgerEntry.SetFilter("Vendor No.", VendorLedgerVendorNoFilter);
        if VendorLedgerExternalDocNoFilter <> '' then
            VendorLedgerEntry.SetFilter("External Document No.", VendorLedgerExternalDocNoFilter);
        if VendorLedgerTransactionNoFilter <> '' then
            VendorLedgerEntry.SetFilter("Transaction No.", VendorLedgerTransactionNoFilter);
        if VendorLedgerPostingDateFilter <> '' then
            VendorLedgerEntry.SetFilter("Posting Date", VendorLedgerPostingDateFilter);
    end;

    local procedure NormalizeGLEntryTransactionNoFilters()
    begin
        GLEntryTransactionEntryNoFilter := DelChr(GLEntryTransactionEntryNoFilter, '<>');
        GLEntryTransactionDocumentNoFilter := DelChr(GLEntryTransactionDocumentNoFilter, '<>');
        GLEntryOldTransactionNoFilter := DelChr(GLEntryOldTransactionNoFilter, '<>');
        GLEntryTransactionPostingDateFilter := DelChr(GLEntryTransactionPostingDateFilter, '<>');
    end;

    local procedure GLEntryTransactionNoHasSelectiveFilter(): Boolean
    begin
        exit(
            (GLEntryTransactionEntryNoFilter <> '') or
            (GLEntryTransactionDocumentNoFilter <> '') or
            (GLEntryOldTransactionNoFilter <> '') or
            (GLEntryTransactionPostingDateFilter <> ''));
    end;

    local procedure CountGLEntryTransactionNoEntries(): Integer
    var
        GLEntry: Record "G/L Entry";
    begin
        ApplyGLEntryTransactionNoFilters(GLEntry);
        exit(GLEntry.Count());
    end;

    local procedure ApplyGLEntryTransactionNo(): Integer
    var
        GLEntry: Record "G/L Entry";
        UpdatedEntries: Integer;
    begin
        ApplyGLEntryTransactionNoFilters(GLEntry);
        if GLEntry.FindSet(true) then
            repeat
                GLEntry."Transaction No." := GLEntryNewTransactionNo;
                GLEntry.Modify(false);
                UpdatedEntries += 1;
            until GLEntry.Next() = 0;

        exit(UpdatedEntries);
    end;

    local procedure ApplyGLEntryTransactionNoFilters(var GLEntry: Record "G/L Entry")
    begin
        GLEntry.Reset();
        if GLEntryTransactionEntryNoFilter <> '' then
            GLEntry.SetFilter("Entry No.", GLEntryTransactionEntryNoFilter);
        if GLEntryTransactionDocumentNoFilter <> '' then
            GLEntry.SetFilter("Document No.", GLEntryTransactionDocumentNoFilter);
        if GLEntryOldTransactionNoFilter <> '' then
            GLEntry.SetFilter("Transaction No.", GLEntryOldTransactionNoFilter);
        if GLEntryTransactionPostingDateFilter <> '' then
            GLEntry.SetFilter("Posting Date", GLEntryTransactionPostingDateFilter);
    end;

    var
        TChannel: Enum "Transaction Channel";
        BankLedgerRepairBankAccountNo: Code[20];
        BankLedgerRepairEntryNoFilter: Text[250];
        BankLedgerRepairExternalDocNo: Code[35];
        BankLedgerRepairPostingDateFilter: Text[100];
        BankLedgerReopenBankAccountNo: Code[20];
        BankLedgerReopenEntryNo: Integer;
        FDLedgerDocumentNoFilter: Text[250];
        FDLedgerEntryNoFilter: Text[250];
        FDLedgerFixedDepositNo: Code[20];
        FDLedgerPostingDateFilter: Text[100];
        FDLedgerSourceAccountName: Text[100];
        FDLedgerSourceSavingsAccountNo: Code[20];
        FDLedgerTargetAccountName: Text[100];
        FDLedgerTargetFixedAccountNo: Code[20];
        SavingsAccountNo: Code[20];
        SavingsAccountName: Text[100];
        LoanNoToDelete: Code[20];
        LoanMemberName: Text[100];
        LoanSecurityLoanNoToDelete: Code[20];
        LoanSecurityGuarantorTypeToDelete: Option Guarantor,Collateral,Lien;
        LoanSecurityFilterByGuarantorType: Boolean;
        LoanSecurityMemberNoToDelete: Code[20];
        LoanSecurityAccountNoToDelete: Code[20];
        LoanSecurityCollateralNoToDelete: Code[20];
        BankCodeToClean: Code[20];
        LedgerReversalNewValue: Boolean;
        LedgerReversalEntryNoFilter: Text[250];
        LedgerReversalDocumentNoFilter: Text[250];
        LedgerReversalExternalDocNoFilter: Text[250];
        LedgerReversalTransactionNoFilter: Text[250];
        LedgerReversalPostingDateFilter: Text[250];
        VendorLedgerOpenNewValue: Boolean;
        VendorLedgerEntryNoFilter: Text[250];
        VendorLedgerDocumentNoFilter: Text[250];
        VendorLedgerVendorNoFilter: Text[250];
        VendorLedgerExternalDocNoFilter: Text[250];
        VendorLedgerTransactionNoFilter: Text[250];
        VendorLedgerPostingDateFilter: Text[250];
        GLEntryNewTransactionNo: Integer;
        GLEntryTransactionEntryNoFilter: Text[250];
        GLEntryTransactionDocumentNoFilter: Text[250];
        GLEntryOldTransactionNoFilter: Text[250];
        GLEntryTransactionPostingDateFilter: Text[250];
        EmailLogLoanNoFilter: Text[250];
        EmailLogLineFilter: Text[250];
        EmailLogSourceFilter: Text[100];
}
