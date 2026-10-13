Report 50410 "Match Auto - Many to Many"
{
    DefaultLayout = RDLC;
    ProcessingOnly = true;
    Permissions = tabledata "Bank Account Ledger Entry" = rimd,
                  tabledata "Bank Acc. Reconciliation Line" = rimd;

    dataset
    {
        dataitem(BankRec; "Bank Acc. Reconciliation")
        {
            trigger OnAfterGetRecord()
            begin
                MatchManyToManyGroups(BankRec);
            end;
        }
    }

    var
        SActivities: Codeunit "Sacco Activities";
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        MatchedGroups: Integer;
        MatchedStatementLines: Integer;
        MatchedLedgerEntries: Integer;

    local procedure MatchManyToManyGroups(BankRec: Record "Bank Acc. Reconciliation")
    var
        StatementLine: Record "Bank Acc. Reconciliation Line";
        ProcessedDocumentNos: Dictionary of [Code[20], Boolean];
        DocumentNo: Code[20];
    begin
        Clear(ProcessedDocumentNos);

        StatementLine.Reset();
        StatementLine.SetRange("Bank Account No.", BankRec."Bank Account No.");
        StatementLine.SetRange("Statement No.", BankRec."Statement No.");
        StatementLine.SetRange("Statement Type", BankRec."Statement Type");
        StatementLine.SetFilter("Document No.", '<>%1', '');
        StatementLine.SetFilter(Difference, '<>%1', 0);

        if not StatementLine.FindSet() then
            exit;

        NoOfRecords := StatementLine.Count();
        CurrentRecordNo := 0;
        SActivities.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);

        repeat
            CurrentRecordNo += 1;
            SActivities.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, StatementLine."Document No.");

            DocumentNo := StatementLine."Document No.";
            if not ProcessedDocumentNos.ContainsKey(DocumentNo) then begin
                ProcessedDocumentNos.Add(DocumentNo, true);
                MatchDocumentGroup(BankRec, DocumentNo);
            end;
        until StatementLine.Next() = 0;

        SActivities.ProgressClose(dWindow);

        Message(
            'Many-to-many auto matching completed.\Matched Groups: %1\Statement Lines: %2\Bank Ledger Entries: %3',
            MatchedGroups,
            MatchedStatementLines,
            MatchedLedgerEntries);
    end;

    local procedure MatchDocumentGroup(BankRec: Record "Bank Acc. Reconciliation"; DocumentNo: Code[20])
    var
        StatementTotal: Decimal;
        LedgerTotal: Decimal;
        StatementLineCount: Integer;
        LedgerEntryCount: Integer;
        ApplyStatementLineNo: Integer;
        GroupGuid: Guid;
    begin
        GetStatementGroupTotals(BankRec, DocumentNo, StatementTotal, StatementLineCount, ApplyStatementLineNo);
        if StatementLineCount <= 1 then
            exit;

        GetLedgerGroupTotals(BankRec, DocumentNo, LedgerTotal, LedgerEntryCount);
        if LedgerEntryCount = 0 then
            exit;

        if not AmountsAreEqual(StatementTotal, LedgerTotal) then
            exit;

        GroupGuid := CreateGuid();
        ApplyStatementGroup(BankRec, DocumentNo, LedgerEntryCount, GroupGuid);
        ApplyLedgerGroup(BankRec, DocumentNo, ApplyStatementLineNo);

        MatchedGroups += 1;
        MatchedStatementLines += StatementLineCount;
        MatchedLedgerEntries += LedgerEntryCount;
    end;

    local procedure GetStatementGroupTotals(BankRec: Record "Bank Acc. Reconciliation"; DocumentNo: Code[20]; var StatementTotal: Decimal; var StatementLineCount: Integer; var FirstStatementLineNo: Integer)
    var
        StatementLine: Record "Bank Acc. Reconciliation Line";
    begin
        StatementTotal := 0;
        StatementLineCount := 0;
        FirstStatementLineNo := 0;

        StatementLine.Reset();
        StatementLine.SetRange("Bank Account No.", BankRec."Bank Account No.");
        StatementLine.SetRange("Statement No.", BankRec."Statement No.");
        StatementLine.SetRange("Statement Type", BankRec."Statement Type");
        StatementLine.SetRange("Document No.", DocumentNo);
        StatementLine.SetFilter(Difference, '<>%1', 0);
        if StatementLine.FindSet() then
            repeat
                StatementLineCount += 1;
                StatementTotal += StatementLine."Statement Amount";
                if FirstStatementLineNo = 0 then
                    FirstStatementLineNo := StatementLine."Statement Line No.";
            until StatementLine.Next() = 0;
    end;

    local procedure GetLedgerGroupTotals(BankRec: Record "Bank Acc. Reconciliation"; DocumentNo: Code[20]; var LedgerTotal: Decimal; var LedgerEntryCount: Integer)
    var
        LedgerEntry: Record "Bank Account Ledger Entry";
    begin
        LedgerTotal := 0;
        LedgerEntryCount := 0;

        LedgerEntry.Reset();
        SetLedgerGroupFilters(LedgerEntry, BankRec, DocumentNo);
        if LedgerEntry.FindSet() then
            repeat
                LedgerEntryCount += 1;
                LedgerTotal += LedgerEntry."Amount (LCY)";
            until LedgerEntry.Next() = 0;
    end;

    local procedure ApplyStatementGroup(BankRec: Record "Bank Acc. Reconciliation"; DocumentNo: Code[20]; LedgerEntryCount: Integer; GroupGuid: Guid)
    var
        StatementLine: Record "Bank Acc. Reconciliation Line";
    begin
        StatementLine.Reset();
        StatementLine.SetRange("Bank Account No.", BankRec."Bank Account No.");
        StatementLine.SetRange("Statement No.", BankRec."Statement No.");
        StatementLine.SetRange("Statement Type", BankRec."Statement Type");
        StatementLine.SetRange("Document No.", DocumentNo);
        StatementLine.SetFilter(Difference, '<>%1', 0);
        if StatementLine.FindSet(true) then
            repeat
                StatementLine."Match Option" := StatementLine."Match Option"::"Document No & Amount";
                StatementLine."Applied Amount" := StatementLine."Statement Amount";
                StatementLine."Applied Entries" := LedgerEntryCount;
                StatementLine.Validate("Statement Amount");
                StatementLine.Reconciled := true;
                StatementLine."Statement Guid No." := GroupGuid;
                StatementLine.Modify();
            until StatementLine.Next() = 0;
    end;

    local procedure ApplyLedgerGroup(BankRec: Record "Bank Acc. Reconciliation"; DocumentNo: Code[20]; StatementLineNo: Integer)
    var
        LedgerEntry: Record "Bank Account Ledger Entry";
    begin
        LedgerEntry.Reset();
        SetLedgerGroupFilters(LedgerEntry, BankRec, DocumentNo);
        if LedgerEntry.FindSet(true) then
            repeat
                LedgerEntry.TestField(Open, true);
                if LedgerEntry."Posting Date" > DMY2Date(31, 10, 2022) then
                    if LedgerEntry."Statement Status" = LedgerEntry."Statement Status"::Closed then
                        Error('Statement Status Closed');

                LedgerEntry.TestField("Bank Account No.", BankRec."Bank Account No.");
                LedgerEntry."Match Option" := LedgerEntry."Match Option"::"Document No & Amount";
                LedgerEntry."Statement Status" := LedgerEntry."Statement Status"::"Bank Acc. Entry Applied";
                LedgerEntry."Statement No." := BankRec."Statement No.";
                LedgerEntry."Statement Line No." := StatementLineNo;
                LedgerEntry."Statement Difference" := 0;
                LedgerEntry.Modify();
            until LedgerEntry.Next() = 0;
    end;

    local procedure SetLedgerGroupFilters(var LedgerEntry: Record "Bank Account Ledger Entry"; BankRec: Record "Bank Acc. Reconciliation"; DocumentNo: Code[20])
    begin
        LedgerEntry.SetRange("Bank Account No.", BankRec."Bank Account No.");
        LedgerEntry.SetRange(Open, true);
        LedgerEntry.SetFilter("Statement Status", 'Open|Bank Acc. Entry Applied|Check Entry Applied');
        LedgerEntry.SetRange(Reversed, false);
        LedgerEntry.SetRange("External Document No.", DocumentNo);
        LedgerEntry.SetFilter("Statement Difference", '<>%1', 0);
    end;

    local procedure AmountsAreEqual(Amount1: Decimal; Amount2: Decimal): Boolean
    begin
        exit(Abs(Amount1 - Amount2) < 0.01);
    end;
}
