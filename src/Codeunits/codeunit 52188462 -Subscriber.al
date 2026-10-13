/// <summary>
/// Codeunit GLPOSTSubscriber (ID 50125).
/// </summary>
Codeunit 50125 GLPOSTSubscriber
{
    EventSubscriberInstance = StaticAutomatic;

    var
        NextTransactionNo: Integer;
        NextEntryNo: Integer;

    local procedure PostCredit(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        myInt: Integer;
        CreditAcc: Record "Credit Accounts";
        Loans: Record Loans;
        PSetup: Record "Product Setup";
        ReceivablesAccount: Code[20];
        CLedger: Record "Credit Ledger Entry";
    begin
        CreditAcc.Get(GenJournalLine."Account No.");

        CreditAcc.CheckBlockedCustOnJnls(CreditAcc, GenJournalLine."Document Type", TRUE);

        Loans.Reset();
        Loans.SetRange("Loan No.", GenJournalLine."Loan No.");
        if Loans.Find('-') then begin
            Loans.CalcFields("Loans Category-SASRA");
            ReceivablesAccount := PSetup.GetReceivablesAccount(Loans."Loan Product Type", GenJournalLine."Transaction Type");
        end;

        if ReceivablesAccount = '' then
            Error(
                'Transaction Type Blocked for:\ - Loan No.: %1\ - Account No. %2\ - Transaction Type %3\ - Loan Product Type %4',
                GenJournalLine."Loan No.",
                GenJournalLine."Account No.",
                GenJournalLine."Transaction Type",
                Loans."Loan Product Type"
                + '-' + Loans."Loan Product Type Name"
            );

        if GenJournalLine."Group Code" <> Loans."Group Code" then
            GenJournalLine."Group Code" := Loans."Group Code";

        CLedger.LockTable();
        InitCLedgerEntry(GenJournalLine, CLedger);
        CLedger."Customer Posting Group" := CreditAcc."Customer Posting Group";
        CLedger."Currency Code" := GenJournalLine."Currency Code";
        IF GenJournalLine."Currency Code" <> '' THEN
            CLedger.Amount := GenJournalLine.Amount
        ELSE
            CLedger.Amount := GenJournalLine."Amount (LCY)";
        CLedger."Amount (LCY)" := GenJournalLine."Amount (LCY)";
        CLedger."Debit Amount" := GenJournalLine."Debit Amount";
        CLedger."Credit Amount" := GenJournalLine."Credit Amount";
        CLedger."Debit Amount (LCY)" := GenJournalLine."Debit Amount";
        CLedger."Credit Amount (LCY)" := GenJournalLine."Credit Amount";

        Cledger."Member No." := Loans."Member No.";
        CLedger."Staff No." := Loans."Staff No";

        CLedger.Open := GenJournalLine.Amount <> 0;
        CLedger."Remaining Amount" := CLedger.Amount;
        CLedger.Positive := GenJournalLine.Amount > 0;
        CLedger."Current Loans Category-SASRA" := Loans."Loans Category-SASRA";
        CLedger.Channel := GenJournalLine.Channel;
        CLedger.INSERT(TRUE);

        Sender.CreateGLEntryBalAcc(
            GenJournalLine, ReceivablesAccount, GenJournalLine."Amount (LCY)", GenJournalLine."Source Currency Amount",
           GenJournalLine."Bal. Account Type", GenJournalLine."Bal. Account No.");
        // GenJnlPost.DeferralPosting("Deferral Code", "Source Code", ReceivablesAccount, GenJournalLine, Balancing);
        OnMoveGenJournalLine(GenJournalLine, CLedger.RECORDID);
    end;

    local procedure InitCLedgerEntry(var GenJnlLine: Record "Gen. Journal Line"; var CLedgerEntry: Record "Credit Ledger Entry")
    begin
        CLedgerEntry.INIT;
        CLedgerEntry.CopyFromGenJnlLine(GenJnlLine);
        CLedgerEntry."Entry No." := NextEntryNo;
        CLedgerEntry."Transaction No." := NextTransactionNo;
    end;

    local procedure PostSavings(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        Savings: Record "Savings Accounts";
        CustPostingGr: Record "Customer Posting Group";
        SLedger: Record "Savings Ledger Entry";
        CVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary;
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        ReceivablesAccount: Code[20];
        DtldLedgEntryInserted: Boolean;
        members: Record Members;
        MemberAcitivities: Codeunit "Member Activities";
        UserSetup: Record "User Setup";
        SaccoSetup: Record "Sacco Setup";
        ConfirmTxt: Text;
    begin
        Savings.GET(GenJournalLine."Account No.");
        SaccoSetup.Get();

        // Savings.CheckBlockedCustOnJnls(Savings, GenJournalLine."Document Type", TRUE);

        IF GenJournalLine."Posting Group" = '' THEN BEGIN
            Savings.TESTFIELD("Customer Posting Group");
            GenJournalLine."Posting Group" := Savings."Customer Posting Group";
        END;

        CustPostingGr.GET(GenJournalLine."Posting Group");
        ReceivablesAccount := CustPostingGr.GetReceivablesAccount;

        SLedger.LOCKTABLE;

        InitSavingsLedgEntry(GenJournalLine, SLedger);
        SLedger."Customer Posting Group" := GenJournalLine."Posting Group";

        SLedger."Member No." := GenJournalLine."Member No.";

        IF Savings."Currency Code" <> '' THEN
            SLedger.Amount := GenJournalLine.Amount
        ELSE
            SLedger.Amount := GenJournalLine."Amount (LCY)";
        SLedger."Amount (LCY)" := GenJournalLine."Amount (LCY)";
        SLedger.Open := GenJournalLine.Amount <> 0;
        SLedger."Remaining Amount" := SLedger.Amount;
        SLedger."Credit Amount" := GenJournalLine."Credit Amount";
        SLedger."Debit Amount (LCY)" := GenJournalLine."Debit Amount";
        SLedger."Credit Amount (LCY)" := GenJournalLine."Credit Amount";

        SLedger."Debit Amount" := GenJournalLine."Debit Amount";
        SLedger.Positive := GenJournalLine.Amount > 0;
        SLedger.Channel := GenJournalLine.Channel;
        //SLedger.UpdateDebitCredit(Correction);
        UserSetup.Get(UserId);
        if (SLedger."Debit Amount" > 0) and (not UserSetup."Skip Overdrawal Check") then begin
            if MemberAcitivities.GetAccountBalance(SLedger."Account No.") - SLedger."Debit Amount" < 0 then
                if not UserSetup."Allow overdrawal" then
                    Error('This transaction will lead to overdrawal by %1 on %2', MemberAcitivities.GetAccountBalance(SLedger."Account No.") - SLedger."Debit Amount", SLedger."Account No.")
                else begin
                    /* ConfirmTxt := StrSubstNo('Are you sure ' + 'this transaction will lead to overdrawal by %1 on %2', MemberAcitivities.GetAccountBalance(SLedger."Account No.") - SLedger."Debit Amount", SLedger."Account No.");
                    if not Confirm(ConfirmTxt + '?') then begin
                        Error('Aborted');
                    end */
                end;
        end;

        if (SLedger."Credit Amount" > 0) and (Savings."Product Category" = Savings."Product Category"::"Share Capital") then begin
            if MemberAcitivities.GetAccountBalance(SLedger."Account No.") + SLedger."Credit Amount (LCY)" > SaccoSetup."Maximum Share Capital Amount" then
                Error('This transaction will lead to Overpayment to %1 allowed %2 on %3', MemberAcitivities.GetAccountBalance(SLedger."Account No.") + SLedger."Credit Amount (LCY)", SaccoSetup."Maximum Share Capital Amount", SLedger."Account No.");
        end;

        SLedger.INSERT(TRUE);
        Sender.CreateGLEntryBalAcc(
            GenJournalLine, ReceivablesAccount, GenJournalLine."Amount (LCY)", GenJournalLine."Source Currency Amount",
           GenJournalLine."Bal. Account Type", GenJournalLine."Bal. Account No.");
        // GenJnlPost.DeferralPosting("Deferral Code", "Source Code", ReceivablesAccount, GenJournalLine, Balancing);
        OnMoveGenJournalLine(GenJournalLine, SLedger.RECORDID);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    local procedure OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; Amount: Decimal; AddCurrAmount: Decimal; UseAddCurrAmount: Boolean; var CurrencyFactor: Decimal; var GLRegister: Record "G/L Register")
    Var
        UserSetup: Record "User Setup";

    begin
        if GenJournalLine."Dimension Set ID" = 0 then begin
            UserSetup.Get(UserId);
            GenJournalLine."Dimension Set ID" := UserSetup."Dimension Set ID";
        end;
        GLEntry."Member No." := GenJournalLine."Member No.";
        GLEntry."Loan No." := GenJournalLine."Loan No.";
        GLEntry.Channel := GenJournalLine.Channel;

    end;

    local procedure InitSavingsLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var CustLedgEntry: Record "Savings Ledger Entry")

    begin
        CustLedgEntry.INIT;
        CustLedgEntry.CopyFromGenJnlLine(GenJournalLine);
        CustLedgEntry."Entry No." := NextEntryNo;
        CustLedgEntry."Transaction No." := NextTransactionNo;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure OnBeforePostGenJnlLine(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean);
    var
        SaccoActivities: Codeunit "Sacco Activities";
    begin
        NextEntryNo := Sender.GetNextEntryNo();
        NextTransactionNo := Sender.GetNextTransactionNo();

        case GenJournalLine."Account Type" of
            GenJournalLine."Account Type"::Savings:
                begin
                    PostSavings(Sender, GenJournalLine, true);
                end;
            GenJournalLine."Account Type"::Credit:
                begin
                    PostCredit(Sender, GenJournalLine, true);
                end;
        end;

        if GenJournalLine.Receipt then begin
            SaccoActivities.MarkReceiptAsPosted(GenJournalLine."Document No.");
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostBankAccOnBeforeBankAccLedgEntryInsert', '', false, false)]
    local procedure OnPostBankAccOnBeforeBankAccLedgEntryInsert(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; BankAccount: Record "Bank Account"; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextTransactionNo: Integer)
    begin
        BankAccountLedgerEntry."Statement Difference" := GenJournalLine.Amount;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnMoveGenJournalLine', '', false, false)]
    local procedure OnMoveGenJournalLine(var GenJournalLine: Record "Gen. Journal Line"; ToRecordID: RecordID)
    begin

    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', false, false)]


    local procedure OnAfterNavigateFindRecords(var Sender: Page Navigate; var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text)
    var
        SavingAccLedgEntry: Record "Savings Ledger Entry";
        CreditAccLedgeEntry: Record "Credit Ledger Entry";
    //DocumentEntry: Record "Document Entry";
    begin

        IF SavingAccLedgEntry.READPERMISSION THEN BEGIN
            SavingAccLedgEntry.RESET;
            SavingAccLedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
            SavingAccLedgEntry.SETFILTER("Document No.", DocNoFilter);
            SavingAccLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            DocumentEntry.InsertIntoDocEntry(DATABASE::"Savings Ledger Entry", SavingAccLedgEntry.TABLECAPTION, SavingAccLedgEntry.COUNT);
            //Sender.InsertIntoDocEntry(DocumentEntry, DATABASE::"Savings Ledger Entry", SavingAccLedgEntry.TABLECAPTION, SavingAccLedgEntry.COUNT);
            //DocumentEntry.InsertIntoDocEntry(SavingAccLedgEntry.id, DATABASE::"Savings Ledger Entry", SavingAccLedgEntry.TABLECAPTION, SavingAccLedgEntry.COUNT);
        END;


        IF CreditAccLedgeEntry.READPERMISSION THEN BEGIN
            CreditAccLedgeEntry.RESET;
            CreditAccLedgeEntry.SETCURRENTKEY("Document No.", "Posting Date");
            CreditAccLedgeEntry.SETFILTER("Document No.", DocNoFilter);
            CreditAccLedgeEntry.SETFILTER("Posting Date", PostingDateFilter);
            //Sender.InsertIntoDocEntry(DocumentEntry, DATABASE::"Credit Ledger Entry", CreditAccLedgeEntry.TABLECAPTION, CreditAccLedgeEntry.COUNT);
            DocumentEntry.InsertIntoDocEntry(DATABASE::"Credit Ledger Entry", CreditAccLedgeEntry.TABLECAPTION, CreditAccLedgeEntry.COUNT);
        END;
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnBeforeShowRecords', '', false, false)]
    local procedure OnBeforeShowRecords(var TempDocumentEntry: Record "Document Entry" temporary; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean; ContactNo: Code[250]; ExtDocNo: Code[250]; var IsHandled: Boolean)
    var
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        case TempDocumentEntry."Table ID" of
            DATABASE::"Savings Ledger Entry":
                begin
                    SavingsLedgerEntry.Reset();
                    SavingsLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
                    SavingsLedgerEntry.SetFilter("Document No.", DocNoFilter);
                    if SavingsLedgerEntry.Find('-') then begin
                        PAGE.Run(0, SavingsLedgerEntry);
                        IsHandled := true;
                    end;
                end;
            DATABASE::"Credit Ledger Entry":
                begin
                    CreditLedgerEntry.Reset();
                    CreditLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
                    CreditLedgerEntry.SetFilter("Document No.", DocNoFilter);
                    if CreditLedgerEntry.Find('-') then begin
                        PAGE.Run(0, CreditLedgerEntry);
                        IsHandled := true;
                    end;
                end;
        end;
    end;

}

