codeunit 50393 "Bank Rec. Matching"
{
    Permissions = tabledata "Bank Reconciliation" = rim,
                  tabledata "Bank Reconciliation Line" = rim,
                  tabledata "Bank Account Ledger Entry" = rim,
                  tabledata "Bank Rec. History Line" = rim;

    procedure MatchManually(BankRecHeader: Record "Bank Reconciliation";

    var
        TempBankRecLine: Record "Bank Reconciliation Line" temporary;

    var
        TempBankLedgerEntry: Record "Bank Account Ledger Entry" temporary): Boolean
    var
        BankRecLine: Record "Bank Reconciliation Line";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        AppliedEntryCount: Integer;
        TotalAppliedAmount: Decimal;
    begin
        // Calculate totals
        AppliedEntryCount := 0;
        TotalAppliedAmount := 0;

        if TempBankLedgerEntry.FindSet() then
            repeat
                AppliedEntryCount += 1;
                TotalAppliedAmount += TempBankLedgerEntry.Amount;
            until TempBankLedgerEntry.Next() = 0;

        // Process statement lines
        if TempBankRecLine.FindSet() then
            repeat
                // Get the actual record
                BankRecLine.Get(TempBankRecLine."Document No.", TempBankRecLine."Line No.");

                // Update statement line
                BankRecLine.Validate(Difference, 0);
                BankRecLine.Validate(Matched, true);
                BankRecLine."Applied Amount" := TotalAppliedAmount;
                BankRecLine."Applied Entries" := AppliedEntryCount;

                // If there's just one bank entry, link it directly
                if AppliedEntryCount = 1 then begin
                    TempBankLedgerEntry.FindFirst();
                    BankRecLine."Bank Entry No." := TempBankLedgerEntry."Entry No.";
                end;

                BankRecLine.Modify(true);
            until TempBankRecLine.Next() = 0;

        // Process bank entries
        if TempBankLedgerEntry.FindSet() then
            repeat
                // Get the actual record
                BankLedgerEntry.Get(TempBankLedgerEntry."Entry No.");

                // Update bank ledger entry
                BankLedgerEntry.Validate("Statement Status", BankLedgerEntry."Statement Status"::Closed);
                BankLedgerEntry.Validate("Statement No.", BankRecHeader."No.");

                // If there's just one statement line, link it directly
                if TempBankRecLine.Count = 1 then begin
                    TempBankRecLine.FindFirst();
                    BankLedgerEntry.Validate("Statement Line No.", TempBankRecLine."Line No.");
                end;

                BankLedgerEntry."Statement Difference" := 0;
                BankLedgerEntry.Modify(true);
            until TempBankLedgerEntry.Next() = 0;

        // Update statement differences
        UpdateStatementDifferences(BankRecHeader);

        exit(true);
    end;

    local procedure UpdateStatementDifferences(BankRecHeader: Record "Bank Reconciliation")
    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        // Clear differences for matched entries
        BankLedgerEntry.Reset();
        BankLedgerEntry.SetRange("Bank Account No.", BankRecHeader."Bank Account No.");
        BankLedgerEntry.SetRange(Open, true);
        BankLedgerEntry.SetRange(Reversed, false);
        BankLedgerEntry.SetFilter("Posting Date", '<=%1', BankRecHeader."Statement Date");
        BankLedgerEntry.SetFilter("Amount (LCY)", '<>%1', 0);
        BankLedgerEntry.SetFilter("Statement Difference", '<>%1', 0);
        BankLedgerEntry.SetRange("Statement Status", BankLedgerEntry."Statement Status"::"Bank Acc. Entry Applied");
        if BankLedgerEntry.FindSet() then begin
            repeat
                BankLedgerEntry."Statement Difference" := 0;
                BankLedgerEntry.Modify();
            until BankLedgerEntry.Next() = 0;
        end;

        // Set differences for unmatched entries
        BankLedgerEntry.Reset();
        BankLedgerEntry.SetRange("Bank Account No.", BankRecHeader."Bank Account No.");
        BankLedgerEntry.SetRange(Open, true);
        BankLedgerEntry.SetRange(Reversed, false);
        BankLedgerEntry.SetFilter("Posting Date", '<=%1', BankRecHeader."Statement Date");
        BankLedgerEntry.SetFilter("Amount (LCY)", '<>%1', 0);
        BankLedgerEntry.SetFilter("Statement Difference", '%1', 0);
        BankLedgerEntry.SetFilter("Statement Status", '<>%1', BankLedgerEntry."Statement Status"::"Bank Acc. Entry Applied");
        if BankLedgerEntry.FindSet() then begin
            repeat
                BankLedgerEntry."Statement Difference" := BankLedgerEntry."Amount (LCY)";
                BankLedgerEntry.Modify();
            until BankLedgerEntry.Next() = 0;
        end;
    end;

    procedure MatchAutomatically(BankRecHeader: Record "Bank Reconciliation"): Boolean
    var
        StatementLine: Record "Bank Reconciliation Line";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        Window: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        ProgressMsg: Label 'Processing #1#### of #2####...';
        MatchCompletedMsg: Label 'Auto-matching completed. %1 entries matched.';
        MatchedCount: Integer;
    begin
        // Initialize
        MatchedCount := 0;

        // Get unmatched statement lines
        StatementLine.Reset();
        StatementLine.SetRange("Document No.", BankRecHeader."No.");
        StatementLine.SetFilter(Difference, '<>%1', 0);
        StatementLine.SetRange(Matched, false);

        if not StatementLine.FindFirst() then begin
            Message('No unmatched statement lines found.');
            exit(true);
        end;

        // Show progress dialog
        NoOfRecords := StatementLine.Count;
        Window.Open(ProgressMsg);
        Window.Update(2, NoOfRecords);

        // Process each unmatched line
        repeat
            CurrentRecordNo += 1;
            Window.Update(1, CurrentRecordNo);

            // Try matching by document number and amount
            BankLedgerEntry.Reset();
            BankLedgerEntry.SetRange("Bank Account No.", BankRecHeader."Bank Account No.");
            BankLedgerEntry.SetRange(Open, true);
            BankLedgerEntry.SetFilter("Statement Status", '%1|%2|%3',
                BankLedgerEntry."Statement Status"::Open,
                BankLedgerEntry."Statement Status"::"Bank Acc. Entry Applied",
                BankLedgerEntry."Statement Status"::"Check Entry Applied");
            BankLedgerEntry.SetRange(Reversed, false);
            BankLedgerEntry.SetFilter("Posting Date", '<=%1', BankRecHeader."Statement Date"); // Added statement date filter
            BankLedgerEntry.SetRange(Amount, StatementLine."Statement Amount");
            BankLedgerEntry.SetRange("Document No.", StatementLine."Reference No.");

            if not BankLedgerEntry.FindFirst() then begin
                // Try matching by external document no. if document no. didn't work
                BankLedgerEntry.Reset();
                BankLedgerEntry.SetRange("Bank Account No.", BankRecHeader."Bank Account No.");
                BankLedgerEntry.SetRange(Open, true);
                BankLedgerEntry.SetFilter("Statement Status", '%1|%2|%3',
                    BankLedgerEntry."Statement Status"::Open,
                    BankLedgerEntry."Statement Status"::"Bank Acc. Entry Applied",
                    BankLedgerEntry."Statement Status"::"Check Entry Applied");
                BankLedgerEntry.SetRange(Reversed, false);
                BankLedgerEntry.SetRange(Amount, StatementLine."Statement Amount");
                BankLedgerEntry.SetRange("External Document No.", StatementLine."Reference No.");
            end;

            if BankLedgerEntry.FindFirst() then begin
                // Match found - update records

                // Update statement line
                StatementLine.Validate(Difference, 0);
                StatementLine.Validate(Matched, true);
                StatementLine.Validate("Bank Entry No.", BankLedgerEntry."Entry No.");
                StatementLine."Applied Amount" := StatementLine."Statement Amount";
                StatementLine."Applied Entries" := 1;
                StatementLine.Modify(true);

                // Update bank ledger entry
                BankLedgerEntry.Validate("Statement Status", BankLedgerEntry."Statement Status"::"Bank Acc. Entry Applied");
                BankLedgerEntry.Validate("Statement No.", BankRecHeader."No.");
                BankLedgerEntry.Validate("Statement Line No.", StatementLine."Line No.");
                BankLedgerEntry."Statement Difference" := 0;
                BankLedgerEntry.Modify(true);

                MatchedCount += 1;
            end;
        until StatementLine.Next() = 0;

        Window.Close();
        Message(MatchCompletedMsg, MatchedCount);

        // Update statement differences
        UpdateStatementDifferences(BankRecHeader);

        exit(true);
    end;

    procedure RemoveMatches(BankRecHeader: Record "Bank Reconciliation";
                       var TempBankRecLine: Record "Bank Reconciliation Line" temporary): Boolean
    var
        BankRecLine: Record "Bank Reconciliation Line";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        // Process selected statement lines
        if TempBankRecLine.FindSet() then
            repeat
                // Get the actual record
                BankRecLine.Get(TempBankRecLine."Document No.", TempBankRecLine."Line No.");

                // Only process if it's already matched
                if BankRecLine.Matched then begin
                    // If there's a linked bank entry, update it first
                    if BankRecLine."Bank Entry No." <> 0 then begin
                        if BankLedgerEntry.Get(BankRecLine."Bank Entry No.") then begin
                            BankLedgerEntry.Validate("Statement Status", BankLedgerEntry."Statement Status"::Open);
                            BankLedgerEntry.Validate("Statement No.", '');
                            BankLedgerEntry.Validate("Statement Line No.", 0);
                            BankLedgerEntry."Statement Difference" := BankLedgerEntry.Amount;
                            BankLedgerEntry.Modify(true);
                        end;
                    end;

                    // Reset the statement line
                    BankRecLine.Validate(Matched, false);
                    BankRecLine.Validate(Difference, BankRecLine."Statement Amount");
                    BankRecLine."Bank Entry No." := 0;
                    BankRecLine."Applied Amount" := 0;
                    BankRecLine."Applied Entries" := 0;
                    BankRecLine.Modify(true);
                end;
            until TempBankRecLine.Next() = 0;

        // Update statement differences to ensure all unmatched entries are properly set
        UpdateStatementDifferences(BankRecHeader);

        exit(true);
    end;

    procedure PostReconciliation(BankRecHeader: Record "Bank Reconciliation"): Boolean
    var
        BankRecLine: Record "Bank Reconciliation Line";
        BankRecHistoryLine: Record "Bank Rec. History Line";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        BankAccount: Record "Bank Account";
        LineNo: Integer;
        ReconciliationMsg: Label 'Bank reconciliation %1 posted successfully. %2 entries reconciled, %3 entries unreconciled.';
        ReconciledCount: Integer;
        UnreconciledCount: Integer;
    begin
        // Validate bank reconciliation status
        if BankRecHeader.Status = BankRecHeader.Status::Posted then
            Error('Bank reconciliation %1 has already been posted.', BankRecHeader."No.");

        // Get bank account
        if not BankAccount.Get(BankRecHeader."Bank Account No.") then
            Error('Bank account %1 not found.', BankRecHeader."Bank Account No.");

        // Process statement lines
        BankRecLine.Reset();
        BankRecLine.SetRange("Document No.", BankRecHeader."No.");

        if not BankRecLine.FindSet() then
            Error('No statement lines found for bank reconciliation %1.', BankRecHeader."No.");

        // Start processing lines
        repeat
            // Determine if line is reconciled (matched with 0 difference)
            if BankRecLine.Matched and (BankRecLine.Difference = 0) then begin
                // This is a reconciled entry
                ReconciledCount += 1;

                // Close matched bank ledger entries
                if BankRecLine."Bank Entry No." <> 0 then begin
                    if BankLedgerEntry.Get(BankRecLine."Bank Entry No.") then begin
                        BankLedgerEntry.Open := false;  // Mark as closed
                        BankLedgerEntry."Remaining Amount" := 0;  // Clear remaining amount
                        BankLedgerEntry."Statement Status" := BankLedgerEntry."Statement Status"::Closed;
                        BankLedgerEntry."Statement Difference" := 0;
                        BankLedgerEntry.Modify(true);
                    end;
                end;
            end else begin
                // This is an unreconciled entry - save to history
                UnreconciledCount += 1;

                // Create history record only for unreconciled lines
                BankRecHistoryLine.Init();
                BankRecHistoryLine."Document No." := BankRecLine."Document No.";
                BankRecHistoryLine."Line No." := BankRecLine."Line No.";
                BankRecHistoryLine."Transaction Date" := BankRecLine."Transaction Date";
                BankRecHistoryLine."Document Type" := BankRecLine."Document Type";
                BankRecHistoryLine."Reference No." := BankRecLine."Reference No.";
                BankRecHistoryLine.Description := BankRecLine.Description;
                BankRecHistoryLine.Amount := BankRecLine.Amount;
                BankRecHistoryLine."Statement Amount" := BankRecLine."Statement Amount";
                BankRecHistoryLine.Difference := BankRecLine.Difference;
                BankRecHistoryLine.Matched := BankRecLine.Matched;
                BankRecHistoryLine."Bank Entry No." := BankRecLine."Bank Entry No.";
                BankRecHistoryLine."Applied Amount" := BankRecLine."Applied Amount";
                BankRecHistoryLine."Applied Entries" := BankRecLine."Applied Entries";
                BankRecHistoryLine."Statement No." := BankRecHeader."Statement No.";
                BankRecHistoryLine."Bank Account No." := BankRecHeader."Bank Account No.";
                BankRecHistoryLine."Statement Date" := BankRecHeader."Statement Date";
                BankRecHistoryLine.Reconciled := false;  // By definition, these are unreconciled
                BankRecHistoryLine.Insert();
            end;
        until BankRecLine.Next() = 0;

        // Update bank account information
        BankAccount."Balance Last Statement" := BankRecHeader."Statement Ending Balance";
        BankAccount."Last Statement No." := BankRecHeader."Statement No.";
        //BankAccount."Last Statement Date" := BankRecHeader."Statement Date";
        BankAccount.Modify();

        // Update header status
        BankRecHeader.Status := BankRecHeader.Status::Posted;
        BankRecHeader."Posted By" := UserId;
        BankRecHeader."Posted Date" := CurrentDateTime;
        BankRecHeader.Modify();

        Message(ReconciliationMsg, BankRecHeader."No.", ReconciledCount, UnreconciledCount);

        exit(true);
    end;

    procedure CarryForwardUnreconciledEntries(NewBankRecHeader: Record "Bank Reconciliation"): Boolean
    var
        BankRecHistoryLine: Record "Bank Rec. History Line";
        BankRecLine: Record "Bank Reconciliation Line";
        LineNo: Integer;
        CarryForwardMsg: Label '%1 unreconciled entries carried forward from previous statements.';
        Count: Integer;
    begin
        // Find unreconciled entries for this bank account
        BankRecHistoryLine.Reset();
        BankRecHistoryLine.SetRange("Bank Account No.", NewBankRecHeader."Bank Account No.");
        BankRecHistoryLine.SetRange(Reconciled, false);

        if not BankRecHistoryLine.FindSet() then
            exit(true); // No unreconciled entries to carry forward

        // Get the next line number
        BankRecLine.Reset();
        BankRecLine.SetRange("Document No.", NewBankRecHeader."No.");
        if BankRecLine.FindLast() then
            LineNo := BankRecLine."Line No."
        else
            LineNo := 0;

        // Carry forward unreconciled entries
        repeat
            LineNo += 10000;
            Count += 1;

            // Create new reconciliation line
            BankRecLine.Init();
            BankRecLine."Document No." := NewBankRecHeader."No.";
            BankRecLine."Line No." := LineNo;
            BankRecLine."Transaction Date" := BankRecHistoryLine."Transaction Date";
            BankRecLine."Document Type" := BankRecHistoryLine."Document Type";
            BankRecLine."Reference No." := BankRecHistoryLine."Reference No.";
            BankRecLine.Description := BankRecHistoryLine.Description + ' (carried forward)';
            BankRecLine.Amount := BankRecHistoryLine.Amount;
            BankRecLine."Statement Amount" := BankRecHistoryLine."Statement Amount";
            BankRecLine.Difference := BankRecHistoryLine.Difference;
            BankRecLine.Matched := false; // Reset matching status
            BankRecLine."Bank Entry No." := 0; // Reset bank entry link
            BankRecLine."Applied Amount" := 0;
            BankRecLine."Applied Entries" := 0;
            BankRecLine.Insert();
        until BankRecHistoryLine.Next() = 0;

        if Count > 0 then
            Message(CarryForwardMsg, Count);

        exit(true);
    end;


}