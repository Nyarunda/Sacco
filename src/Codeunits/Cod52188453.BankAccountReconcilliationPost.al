codeunit 50119 BankAccountReconciliationPost
{

    Permissions = TableData "Bank Account Ledger Entry" = rm,
                  TableData "Check Ledger Entry" = rm,
                  TableData "Bank Account Statement" = ri,
                  TableData "Bank Account Statement Line" = ri,
                  TableData "Posted Payment Recon. Hdr" = ri;
    TableNo = "Bank Acc. Reconciliation";

    trigger OnRun()
    begin
        if GuiAllowed and not PreviewMode then begin
            Window.Open('#1#################################\\' + PostingLinesTxt);
            Window.Update(1, StrSubstNo('%1 %2', Rec."Bank Account No.", Rec."Statement No."));
        end;

        InitPost(Rec);
        Post(Rec);
        FinalizePost(Rec);

        if PreviewMode then
            exit;

        if GuiAllowed then
            Window.Close();

        Commit();
    end;

    var
        PostingLinesTxt: Label 'Posting lines              #2######';
        Text001: Label '%1 is not equal to Total Balance.';
        Text002: Label 'There is nothing to post.';
        Text003: Label 'The application is not correct. The total amount applied is %1; it should be %2.';
        Text004: Label 'The total difference is %1. It must be %2.';
        BankAcc: Record "Bank Account";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
        GenJnlLine: Record "Gen. Journal Line";
        GLSetup: Record "General Ledger Setup";
        SourceCodeSetup: Record "Source Code Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        Window: Dialog;
        SourceCode: Code[10];
        PostedStamentNo: Code[20];
        TotalAmount: Decimal;
        TotalAppliedAmount: Decimal;
        TotalDiff: Decimal;
        Lines: Integer;
        Difference: Decimal;
        PreviewMode: Boolean;
        ExcessiveAmtErr: Label 'You must apply the excessive amount of %1 %2 manually.', Comment = '%1 a decimal number, %2 currency code';
        PostPaymentsOnly: Boolean;
        NotFullyAppliedErr: Label 'One or more payments are not fully applied.\\The sum of applied amounts is %1. It must be %2.', Comment = '%1 - total applied amount, %2 - total transaction amount';
        LineNoTAppliedErr: Label 'The line with transaction date %1 and transaction text ''%2'' is not applied. You must apply all lines.', Comment = '%1 - transaction date, %2 - arbitrary text';
        TransactionAlreadyReconciledErr: Label 'The line with transaction date %1 and transaction text ''%2'' is already reconciled.\\You must remove it from the payment reconciliation journal before posting.', Comment = '%1 - transaction date, %2 - arbitrary text';

    [Scope('OnPrem')]
    [CommitBehavior(CommitBehavior::Ignore)]
    procedure RunPreview(var BankAccReconciliation: Record "Bank Acc. Reconciliation"): Boolean
    begin
        PreviewMode := true;
        InitPost(BankAccReconciliation);
        Post(BankAccReconciliation);
        FinalizePost(BankAccReconciliation);
        exit(true);
    end;

    local procedure InitPost(var BankAccRecon: Record "Bank Acc. Reconciliation")
    begin
        OnBeforeInitPost(BankAccRecon);
        GLSetup.Get();
        case BankAccRecon."Statement Type" of
            BankAccRecon."Statement Type"::"Bank Reconciliation":
                begin
                    BankAccRecon.TestField("Statement Date");
                    CheckLinesMatchEndingBalance(BankAccRecon, Difference);
                end;
            BankAccRecon."Statement Type"::"Payment Application":
                begin
                    SourceCodeSetup.Get();
                    SourceCode := SourceCodeSetup."Payment Reconciliation Journal";
                    PostPaymentsOnly := BankAccRecon."Post Payments Only";
                    if PreviewMode then
                        exit;
                    if not PostPaymentsOnly then
                        if GuiAllowed then begin
                            if PAGE.RunModal(Page::"Post Pmts and Rec. Bank Acc.", BankAccRecon) <> ACTION::LookupOK then
                                Error('');

                            BankAccRecon.Get(BankAccRecon."Statement Type", BankAccRecon."Bank Account No.", BankAccRecon."Statement No.");
                            CheckLinesMatchEndingBalance(BankAccRecon, Difference);
                        end;
                end;
        end;
    end;

    local procedure StoreFieldsPrePosting(BankAccRecon: Record "Bank Acc. Reconciliation"; var PrePostingOutstdPayments: Decimal; var PrePostingOutstdBankTransactions: Decimal; var PrePostingGLBalance: Decimal; var PrePostingTotalPositiveDifference: Decimal; var PrePostingTotalNegativeDifference: Decimal)
    var
        PreBankAcc: Record "Bank Account";
        BankAccReconTest: Codeunit "Bank Acc. Recon. Test";
    begin
        BankAccRecon.CalcFields(
            "Total Applied Amount",
            //"Total Applied Amount Payments",
            "Total Outstd Bank Transactions",
            "Total Outstd Payments",
            "Total Unposted Applied Amount"
        );
        PrePostingOutstdPayments := BankAccReconTest.TotalOutstandingPayments(BankAccRecon);
        PrePostingOutstdBankTransactions := BankAccReconTest.TotalOutstandingBankTransactions(BankAccRecon);
        PrePostingTotalPositiveDifference := BankAccReconTest.TotalPositiveDifference(BankAccRecon);
        PrePostingTotalNegativeDifference := BankAccReconTest.TotalNegativeDifference(BankAccRecon);
        PreBankAcc.SetFilter("Date Filter", '..%1', BankAccRecon."Statement Date");
        PreBankAcc.SetAutoCalcFields("Balance at Date");
        if PreBankAcc.Get(BankAccRecon."Bank Account No.") then
            PrePostingGLBalance := PreBankAcc."Balance at Date";
    end;

    local procedure Post(BankAccRecon: Record "Bank Acc. Reconciliation")
    var
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
        BankAccRecMatchBuffer: Record "Bank Acc. Rec. Match Buffer";
        AppliedAmount: Decimal;
        PrePostingOutstdPayments: Decimal;
        PrePostingOutstdBankTransactions: Decimal;
        PrePostingGLBalance: Decimal;
        PrePostingTotalPositiveDifference: Decimal;
        PrePostingTotalNegativeDifference: Decimal;
        TotalTransAmtNotAppliedErr: Text;
        UnreconciledLines: Record "Bank Account Statement Line";
        PostedBankAccReconLine: Record "Posted Cashbook Lines";
        LineNo: Integer;
    begin

        // Run through lines
        BankAccReconLine.FilterBankRecLines(BankAccRecon);
        BankAccReconLine.SETFILTER("Statement Amount", '<>%1', 0);
        // upgrade addition

        /*
                    // Run through lines
                    BankAccReconLine.Reset();           
                    BankAccReconLine.SetRange("Bank Account No.", BankAccRecon."Bank Account No.");
                    BankAccReconLine.SetRange("Statement No.", BankAccRecon."Statement No.");
                    BankAccReconLine.SETFILTER("Statement Amount", '<>%1', 0);
                    BankAccReconLine.SETFILTER(Difference, '<>%1', 0);
                    IF BankAccReconLine.FindSet() THEN
                        REPEAT
                            //BankAccReconLine.CustomRemoveApplication(BankAccReconLine.Type); //note that the function "Removeapplication" property on the table has been modified Bank Recon Line to No from yes
                            UnreconciledLines.Init();
                            UnreconciledLines.TRANSFERFIELDS(BankAccReconLine);
                            UnreconciledLines.INSERT;
                        UNTIL BankAccReconLine.NEXT = 0;
                        */

        BankAccReconLine.RESET;
        BankAccReconLine.SETRANGE("Bank Account No.", BankAccRecon."Bank Account No.");
        BankAccReconLine.SETRANGE("Statement No.", BankAccRecon."Statement No.");
        BankAccReconLine.SETFILTER(Difference, '%1', 0);
        BankAccReconLine.SETFILTER("Statement Amount", '<>%1', 0);
        //BankAccReconLine.SETRANGE(Reconciled, TRUE);//****This is an addition

        //End for upgrade addition

        TotalAmount := 0;
        TotalAppliedAmount := 0;
        TotalDiff := 0;
        Lines := 0;
        IF BankAccReconLine.ISEMPTY THEN
            ERROR(Text002);
        BankAccLedgEntry.LOCKTABLE;
        CheckLedgEntry.LOCKTABLE;

        PostedStamentNo := GetPostedStamentNo(BankAccRecon);

        //Transfer Bank Acc. Ledger Entries
        BankAccLedgEntry.RESET;
        BankAccLedgEntry.SetRange(Open, true);
        BankAccLedgEntry.SetRange(Reversed, false);
        BankAccLedgEntry.SETRANGE("Bank Account No.", BankAccRecon."Bank Account No.");
        BankAccLedgEntry.SETFILTER("Posting Date", '<=%1', BankAccRecon."Statement Date");
        BankAccLedgEntry.SETFILTER("Statement Status", '%1|%2|%3', BankAccLedgEntry."Statement Status"::Open, BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied", BankAccLedgEntry."Statement Status"::"Check Entry Applied");
        IF BankAccLedgEntry.FindSet() THEN
            REPEAT
                LineNo += 1000;
                PostedBankAccReconLine.INIT;
                PostedBankAccReconLine.TransferFields(BankAccLedgEntry);
                PostedBankAccReconLine."Statement No." := PostedStamentNo;
                PostedBankAccReconLine.INSERT;
            UNTIL BankAccLedgEntry.NEXT = 0;


        BankAcc.SetLoadFields("Previous Statement No.");
        BankAcc.get(BankAccRecon."Bank Account No.");
        BankAcc."Previous Statement No." := PostedStamentNo;
        BankAcc.Modify();


        IF BankAccReconLine.FINDSET THEN
            REPEAT
                Lines := Lines + 1;
                Window.UPDATE(2, Lines);
                AppliedAmount := 0;
                // Adjust entries
                // Test amount and settled amount
                CASE BankAccRecon."Statement Type" OF
                    BankAccRecon."Statement Type"::"Bank Reconciliation":
                        /*  CASE BankAccReconLine.Type OF
                             BankAccReconLine.Type::"Bank Account Ledger Entry":
                                 CloseBankAccLedgEntry(BankAccReconLine, AppliedAmount);
                             BankAccReconLine.Type::"Check Ledger Entry":
                                 CloseCheckLedgEntry(BankAccReconLine, AppliedAmount);
                             BankAccReconLine.Type::Difference:
                                 TotalDiff += BankAccReconLine."Statement Amount";
                         END; */

                        //"Statement Type"::"Payment Application":
                        //PostPaymentApplications(BankAccReconLine, AppliedAmount);
                        CloseBankAccLedgEntry(BankAccReconLine, AppliedAmount);
                END;
                //BankAccReconLine.TESTFIELD("Applied Amount",AppliedAmount); Commented on upgrade
                TotalAmount += BankAccReconLine."Statement Amount";
                TotalAppliedAmount += AppliedAmount;
            UNTIL BankAccReconLine.NEXT = 0;



        if PreviewMode then
            exit;

        // Get bank
        if not PostPaymentsOnly then
            UpdateBank(BankAccRecon, TotalAmount);

        case BankAccRecon."Statement Type" of
            BankAccRecon."Statement Type"::"Bank Reconciliation":
                TransferToBankStmt(BankAccRecon, PrePostingOutstdPayments, PrePostingOutstdBankTransactions, PrePostingGLBalance, PrePostingTotalPositiveDifference, PrePostingTotalNegativeDifference);
            BankAccRecon."Statement Type"::"Payment Application":
                HandlePaymentApplicationTransfer(BankAccRecon, PrePostingOutstdPayments, PrePostingOutstdBankTransactions, PrePostingGLBalance, PrePostingTotalPositiveDifference, PrePostingTotalNegativeDifference);
        end;
        /*
OnBeforePost(BankAccRecon, BankAccReconLine);
StoreFieldsPrePosting(BankAccRecon, PrePostingOutstdPayments, PrePostingOutstdBankTransactions, PrePostingGLBalance, PrePostingTotalPositiveDifference, PrePostingTotalNegativeDifference);
with BankAccRecon do begin
    // Run through lines
    BankAccReconLine.FilterBankRecLines(BankAccRecon);
    OnPostAfterFilterBankAccRecLines(BankAccReconLine, BankAccRecon);
    TotalAmount := 0;
    TotalAppliedAmount := 0;
    TotalDiff := 0;
    Lines := 0;
    if BankAccReconLine.IsEmpty() then
        Error(Text002);
    BankAccLedgEntry.LockTable();
    CheckLedgEntry.LockTable();

    PostedStamentNo := GetPostedStamentNo(BankAccRecon);

    if BankAccReconLine.FindSet() then
        repeat
            Lines := Lines + 1;
            if GuiAllowed then
                if not PreviewMode then
                    Window.Update(2, Lines);
            AppliedAmount := 0;

            BankAccReconLine.FilterManyToOneMatches(BankAccRecMatchBuffer);
            if BankAccRecMatchBuffer.FindFirst() then begin
                if (not BankAccRecMatchBuffer."Is Processed") then
                    CloseBankAccLEManyToOne(BankAccRecMatchBuffer, AppliedAmount);
            end else begin
                // Adjust entries
                // Test amount and settled amount
                case "Statement Type" of
                    "Statement Type"::"Bank Reconciliation":
                        case BankAccReconLine.Type of
                            BankAccReconLine.Type::"Bank Account Ledger Entry":
                                CloseBankAccLedgEntry(BankAccReconLine, AppliedAmount);
                            BankAccReconLine.Type::"Check Ledger Entry":
                                CloseCheckLedgEntry(BankAccReconLine, AppliedAmount);
                            BankAccReconLine.Type::Difference:
                                TotalDiff += BankAccReconLine."Statement Amount";
                        end;
                    "Statement Type"::"Payment Application":
                        PostPaymentApplications(BankAccReconLine, AppliedAmount);
                end;
                OnBeforeAppliedAmountCheck(BankAccReconLine, AppliedAmount);
                BankAccReconLine.TestField("Applied Amount", AppliedAmount);
            end;
            TotalAmount += BankAccReconLine."Statement Amount";
            TotalAppliedAmount += AppliedAmount;
        until BankAccReconLine.Next() = 0;

    // Test amount
    if "Statement Type" = "Statement Type"::"Payment Application" then
        TotalTransAmtNotAppliedErr := NotFullyAppliedErr
    else
        TotalTransAmtNotAppliedErr := Text003;
    if TotalAmount <> TotalAppliedAmount + TotalDiff then
        Error(
          TotalTransAmtNotAppliedErr,
          TotalAppliedAmount + TotalDiff, TotalAmount);
    if Difference <> TotalDiff then
        Error(Text004, Difference, TotalDiff);

    if PreviewMode then
        exit;

    // Get bank
    if not PostPaymentsOnly then
        UpdateBank(BankAccRecon, TotalAmount);

    case "Statement Type" of
        "Statement Type"::"Bank Reconciliation":
            TransferToBankStmt(BankAccRecon, PrePostingOutstdPayments, PrePostingOutstdBankTransactions, PrePostingGLBalance, PrePostingTotalPositiveDifference, PrePostingTotalNegativeDifference);
        "Statement Type"::"Payment Application":
            HandlePaymentApplicationTransfer(BankAccRecon, PrePostingOutstdPayments, PrePostingOutstdBankTransactions, PrePostingGLBalance, PrePostingTotalPositiveDifference, PrePostingTotalNegativeDifference);
    end;
end;
*/
    end;

    local procedure HandlePaymentApplicationTransfer(BankAccRecon: Record "Bank Acc. Reconciliation"; PrePostingOutstdPayments: Decimal; PrePostingOutstdBankTransactions: Decimal; PrePostingGLBalance: Decimal; PrePostingTotalPositiveDifference: Decimal; PrePostingTotalNegativeDifference: Decimal)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeHandlePaymentApplicationTransfer(BankAccRecon, IsHandled);
        if IsHandled then
            exit;

        TransferToPostPmtAppln(BankAccRecon);
        if not BankAccRecon."Post Payments Only" then
            TransferToBankStmt(BankAccRecon, PrePostingOutstdPayments, PrePostingOutstdBankTransactions, PrePostingGLBalance, PrePostingTotalPositiveDifference, PrePostingTotalNegativeDifference);
    end;

    local procedure FinalizePost(BankAccRecon: Record "Bank Acc. Reconciliation")
    var
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
        AppliedPmtEntry: Record "Applied Payment Entry";
    begin
        if PreviewMode then
            exit;
        OnBeforeFinalizePost(BankAccRecon);
        if BankAccReconLine.LinesExist(BankAccRecon) then
            repeat
                AppliedPmtEntry.FilterAppliedPmtEntry(BankAccReconLine);
                AppliedPmtEntry.DeleteAll();

                BankAccReconLine.Delete();
                BankAccReconLine.ClearDataExchEntries;

            until BankAccReconLine.Next() = 0;

        BankAccRecon.Find;
        BankAccRecon.Delete;
        OnAfterFinalizePost(BankAccRecon);
    end;

    local procedure CheckLinesMatchEndingBalance(BankAccRecon: Record "Bank Acc. Reconciliation"; var Difference: Decimal)
    var
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";

        BankAccReconLine2: Record "Bank Acc. Reconciliation Line";
        TotalReconciled: Decimal;
        TotalDifference: Decimal;
        DifferenceExplained: Decimal;
        Compare: Decimal;
        BankAccLedger: Record "Bank Account Ledger Entry";

    begin

        BankAccReconLine.Reset();
        BankAccReconLine.SetRange("Bank Account No.", BankAccRecon."Bank Account No.");
        BankAccReconLine.SetRange("Statement No.", BankAccRecon."Statement No.");
        BankAccReconLine.LinesExist(BankAccRecon);
        BankAccReconLine.CALCSUMS("Statement Amount", Difference);
        Difference := BankAccReconLine.Difference;

        BankAccLedger.RESET;
        BankAccLedger.SETRANGE("Bank Account No.", BankAccRecon."Bank Account No.");
        BankAccLedger.SETRANGE("Statement Status", BankAccLedger."Statement Status"::"Bank Acc. Entry Applied");
        BankAccLedger.SETRANGE("Statement No.", BankAccRecon."Statement No.");
        BankAccLedger.SETFILTER("Statement Difference", '<>%1', 0);
        IF BankAccLedger.FINDSET THEN begin

            REPEAT
                IF BankAccLedger."Statement Difference" <> BankAccLedger.Amount THEN
                    ERROR('Statement difference %1 exist for document %2', BankAccLedger."Statement Difference", BankAccLedger."Document No.");
            UNTIL BankAccLedger.NEXT = 0;

        end;

        BankAccLedger.RESET;
        BankAccLedger.SETRANGE("Bank Account No.", BankAccRecon."Bank Account No.");
        BankAccLedger.SETRANGE("Statement Status", BankAccLedger."Statement Status"::"Bank Acc. Entry Applied");
        BankAccLedger.SETRANGE("Statement No.", BankAccRecon."Statement No.");
        BankAccLedger.SETFILTER("Statement Difference", '%1', 0);
        IF not BankAccLedger.FINDSET THEN begin
            Error('Reconciled Entries Missing');
        end;




    end;

    Procedure GetBank(VAR AcNo: Code[20]; VAR StatendingDate: Date) CashBkBal: Decimal
    begin

        IF BankAcc.GET(AcNo) THEN BEGIN
            BankAcc.SETRANGE(BankAcc."Date Filter", 0D, StatendingDate);
            BankAcc.CALCFIELDS(BankAcc."Balance at Date");
            CashBkBal := BankAcc."Balance at Date";
        END;
    end;

    local procedure CloseBankAccLEManyToOne(BankAccRecMatchBuffer: Record "Bank Acc. Rec. Match Buffer"; var AppliedAmount: Decimal);
    var
        BankAccRecMatchBufferCopy: Record "Bank Acc. Rec. Match Buffer";
        BankAccRecLine: Record "Bank Acc. Reconciliation Line";
        LedgerEntryNo: Integer;
        TotalRecLinesAmount: Decimal;
    begin
        BankAccRecMatchBufferCopy.SetRange("Bank Account No.", BankAccRecMatchBuffer."Bank Account No.");
        BankAccRecMatchBufferCopy.SetRange("Statement No.", BankAccRecMatchBuffer."Statement No.");
        BankAccRecMatchBufferCopy.SetRange("Match ID", BankAccRecMatchBuffer."Match ID");
        if (not BankAccRecMatchBufferCopy.IsEmpty()) then
            if BankAccRecMatchBufferCopy.FindSet() then
                repeat
                    LedgerEntryNo := BankAccRecMatchBufferCopy."Ledger Entry No.";
                    BankAccRecMatchBufferCopy."Is Processed" := true;
                    BankAccRecMatchBufferCopy.Modify();
                    BankAccRecLine.SetRange("Bank Account No.", BankAccRecMatchBufferCopy."Bank Account No.");
                    BankAccRecLine.SetRange("Statement No.", BankAccRecMatchBufferCopy."Statement No.");
                    BankAccRecLine.SetRange("Statement Line No.", BankAccRecMatchBufferCopy."Statement Line No.");
                    if BankAccRecLine.FindFirst() then
                        TotalRecLinesAmount += BankAccRecLine."Statement Amount";
                until BankAccRecMatchBufferCopy.Next() = 0;

        BankAccLedgEntry.Get(LedgerEntryNo);
        BankAccLedgEntry.TestField("Remaining Amount", TotalRecLinesAmount);
        AppliedAmount += BankAccLedgEntry."Remaining Amount";
        BankAccLedgEntry."Remaining Amount" := 0;
        BankAccLedgEntry.Open := false;
        BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Closed;
        OnCloseBankAccLedgEntryOnBeforeBankAccLedgEntryModify(BankAccLedgEntry, BankAccRecLine);
        BankAccLedgEntry.Modify();

        CheckLedgEntry.Reset();
        CheckLedgEntry.SetCurrentKey("Bank Account Ledger Entry No.");
        CheckLedgEntry.SetRange(
            "Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
        CheckLedgEntry.SetRange(Open, true);
        if CheckLedgEntry.Find('-') then
            repeat
                CheckLedgEntry.TestField(Open, true);
                CheckLedgEntry.TestField(
                    "Statement Status",
                    CheckLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                CheckLedgEntry.TestField("Statement No.", '');
                CheckLedgEntry.TestField("Statement Line No.", 0);
                CheckLedgEntry.Open := false;
                CheckLedgEntry."Statement Status" := CheckLedgEntry."Statement Status"::Closed;
                CheckLedgEntry.Modify();
            until CheckLedgEntry.Next() = 0;
    end;

    local procedure CloseBankAccLedgEntry(BankAccReconLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal)
    var
        IsHandled: Boolean;
    begin
        OnBeforeCloseBankAccLedgEntry(BankAccReconLine, AppliedAmount, IsHandled);
        if IsHandled then
            exit;

        //Add function to transfer field to the History TB


        BankAccLedgEntry.Reset();
        BankAccLedgEntry.SetCurrentKey("Bank Account No.", Open);
        BankAccLedgEntry.SetRange("Bank Account No.", BankAccReconLine."Bank Account No.");
        BankAccLedgEntry.SetRange(Open, true);
        BankAccLedgEntry.SetRange(
          "Statement Status", BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
        BankAccLedgEntry.SetRange("Statement No.", BankAccReconLine."Statement No.");
        //BankAccLedgEntry.SetRange("Statement Line No.", BankAccReconLine."Statement Line No.");
        OnCloseBankAccLedgEntryOnAfterBankAccLedgEntrySetFilters(BankAccLedgEntry, BankAccReconLine);
#pragma warning disable AL0667
        if BankAccLedgEntry.FindSet(true, true) then
#pragma warning restore AL0667
            repeat
                AppliedAmount += BankAccLedgEntry."Remaining Amount";
                BankAccLedgEntry."Remaining Amount" := 0;
                BankAccLedgEntry.Open := false;
                BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Closed;
                //BankAccLedgEntry."Statement No." := PostedStamentNo;
                BankAccLedgEntry."Statement No." := BankAccLedgEntry."Statement No.";
                OnCloseBankAccLedgEntryOnBeforeBankAccLedgEntryModify(BankAccLedgEntry, BankAccReconLine);
                BankAccLedgEntry.Modify();

                CheckLedgEntry.Reset();
                CheckLedgEntry.SetCurrentKey("Bank Account Ledger Entry No.");
                CheckLedgEntry.SetRange(
                  "Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
                CheckLedgEntry.SetRange(Open, true);
                if CheckLedgEntry.Find('-') then
                    repeat
                        CheckLedgEntry.TestField(Open, true);
                        CheckLedgEntry.TestField(
                          "Statement Status",
                          CheckLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                        CheckLedgEntry.TestField("Statement No.", '');
                        CheckLedgEntry.TestField("Statement Line No.", 0);
                        CheckLedgEntry.Open := false;
                        CheckLedgEntry."Statement Status" := CheckLedgEntry."Statement Status"::Closed;
                        CheckLedgEntry.Modify();
                    until CheckLedgEntry.Next() = 0;
            until BankAccLedgEntry.Next() = 0;
    end;

    local procedure CloseCheckLedgEntry(BankAccReconLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal)
    var
        CheckLedgEntry2: Record "Check Ledger Entry";
    begin
        CheckLedgEntry.Reset();
        CheckLedgEntry.SetCurrentKey("Bank Account No.", Open);
        CheckLedgEntry.SetRange("Bank Account No.", BankAccReconLine."Bank Account No.");
        CheckLedgEntry.SetRange(Open, true);
        CheckLedgEntry.SetRange(
          "Statement Status", CheckLedgEntry."Statement Status"::"Check Entry Applied");
        CheckLedgEntry.SetRange("Statement No.", BankAccReconLine."Statement No.");
        CheckLedgEntry.SetRange("Statement Line No.", BankAccReconLine."Statement Line No.");
#pragma warning disable AL0667
        if CheckLedgEntry.FindSet(true, true) then
#pragma warning restore AL0667
            repeat
                AppliedAmount -= CheckLedgEntry.Amount;
                CheckLedgEntry.Open := false;
                CheckLedgEntry."Statement Status" := CheckLedgEntry."Statement Status"::Closed;
                CheckLedgEntry."Statement No." := PostedStamentNo;
                CheckLedgEntry.Modify();

                BankAccLedgEntry.Get(CheckLedgEntry."Bank Account Ledger Entry No.");
                BankAccLedgEntry.TestField(Open, true);
                BankAccLedgEntry.TestField(
                  "Statement Status", BankAccLedgEntry."Statement Status"::"Check Entry Applied");
                BankAccLedgEntry.TestField("Statement No.", '');
                BankAccLedgEntry.TestField("Statement Line No.", 0);
                BankAccLedgEntry."Remaining Amount" :=
                  BankAccLedgEntry."Remaining Amount" + CheckLedgEntry.Amount;
                if BankAccLedgEntry."Remaining Amount" = 0 then begin
                    BankAccLedgEntry.Open := false;
                    BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Closed;
                    BankAccLedgEntry."Statement No." := PostedStamentNo;
                    BankAccLedgEntry."Statement Line No." := CheckLedgEntry."Statement Line No.";
                end else begin
                    CheckLedgEntry2.Reset();
                    CheckLedgEntry2.SetCurrentKey("Bank Account Ledger Entry No.");
                    CheckLedgEntry2.SetRange("Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
                    CheckLedgEntry2.SetRange(Open, true);
                    CheckLedgEntry2.SetRange("Check Type", CheckLedgEntry2."Check Type"::"Partial Check");
                    CheckLedgEntry2.SetRange(
                      "Statement Status", CheckLedgEntry2."Statement Status"::"Check Entry Applied");
                    if not CheckLedgEntry2.FindFirst() then
                        BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Open;
                end;
                BankAccLedgEntry.Modify();
            until CheckLedgEntry.Next() = 0;
    end;

    local procedure PostPaymentApplications(BankAccReconLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal)
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        CurrExchRate: Record "Currency Exchange Rate";
        AppliedPmtEntry: Record "Applied Payment Entry";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        DimensionManagement: Codeunit DimensionManagement;
        PaymentLineAmount: Decimal;
        RemainingAmount: Decimal;
        IsApplied: Boolean;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforePostPaymentApplications(BankAccReconLine, AppliedAmount, IsHandled);
        if IsHandled then
            exit;

        if BankAccReconLine.IsTransactionPostedAndReconciled then
            Error(TransactionAlreadyReconciledErr, BankAccReconLine."Transaction Date", BankAccReconLine."Transaction Text");

        OnPostPaymentApplicationsOnAfterTransactionPostedAndReconciledCheck(BankAccReconLine, AppliedAmount, SourceCode);

        if BankAccReconLine."Account No." = '' then
            Error(LineNoTAppliedErr, BankAccReconLine."Transaction Date", BankAccReconLine."Transaction Text");

        BankAcc.Get(BankAccReconLine."Bank Account No.");

        GenJnlLine.Init();
        GenJnlLine.SetSuppressCommit(true);
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;

        if IsRefund(BankAccReconLine) then
            if BankAccReconLine."Account Type" = BankAccReconLine."Account Type"::Employee then
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
            else
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund;

        GenJnlLine."Posting Date" := BankAccReconLine."Transaction Date";
        GenJnlLine."Account Type" := "Gen. Journal Account Type".FromInteger(BankAccReconLine.GetAppliedToAccountType());
        BankAccReconciliation.Get(
          BankAccReconLine."Statement Type", BankAccReconLine."Bank Account No.", BankAccReconLine."Statement No.");
        GenJnlLine."Copy VAT Setup to Jnl. Lines" := BankAccReconciliation."Copy VAT Setup to Jnl. Line";
        GenJnlLine.Validate("Account No.", BankAccReconLine.GetAppliedToAccountNo);
        GenJnlLine."Dimension Set ID" := BankAccReconLine."Dimension Set ID";
        DimensionManagement.UpdateGlobalDimFromDimSetID(
          BankAccReconLine."Dimension Set ID", GenJnlLine."Shortcut Dimension 1 Code", GenJnlLine."Shortcut Dimension 2 Code");

        GenJnlLine.Description := BankAccReconLine.GetDescription();

        GenJnlLine."Document No." := PostedStamentNo;
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        GenJnlLine."Bal. Account No." := BankAcc."No.";

        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Allow Zero-Amount Posting" := true;

        GenJnlLine."Applies-to ID" := BankAccReconLine.GetAppliesToID();
        if GLSetup."Journal Templ. Name Mandatory" then begin
            GLSetup.TestField("Bank Acc. Recon. Template Name");
            GLSetup.TestField("Bank Acc. Recon. Batch Name");
            GenJnlLine."Journal Template Name" := GLSetup."Bank Acc. Recon. Template Name";
            GenJnlLine."Journal Batch Name" := GLSetup."Bank Acc. Recon. Batch Name";
        end;

        OnPostPaymentApplicationsOnAfterInitGenJnlLine(GenJnlLine, BankAccReconLine);

        IsApplied := false;
        if AppliedPmtEntry.AppliedPmtEntryLinesExist(BankAccReconLine) then
            repeat
                AppliedAmount += AppliedPmtEntry."Applied Amount" - AppliedPmtEntry."Applied Pmt. Discount";
                PaymentLineAmount += AppliedPmtEntry."Applied Amount" - AppliedPmtEntry."Applied Pmt. Discount";
                AppliedPmtEntry.TestField("Account Type", BankAccReconLine."Account Type");
                AppliedPmtEntry.TestField("Account No.", BankAccReconLine."Account No.");
                if AppliedPmtEntry."Applies-to Entry No." <> 0 then begin
                    case AppliedPmtEntry."Account Type" of
                        AppliedPmtEntry."Account Type"::Employee:
                            ApplyEmployeeLedgEntry(
                              AppliedPmtEntry, GenJnlLine."Applies-to ID", GenJnlLine."Posting Date", 0D, 0D, AppliedPmtEntry."Applied Pmt. Discount");
                        AppliedPmtEntry."Account Type"::"Bank Account":
                            begin
                                BankAccountLedgerEntry.Get(AppliedPmtEntry."Applies-to Entry No.");
                                RemainingAmount := BankAccountLedgerEntry."Remaining Amount";
                                case true of
                                    RemainingAmount = AppliedPmtEntry."Applied Amount":
                                        begin
                                            if not PostPaymentsOnly then
                                                CloseBankAccountLedgerEntry(AppliedPmtEntry."Applies-to Entry No.", AppliedPmtEntry."Applied Amount");
                                            PaymentLineAmount -= AppliedPmtEntry."Applied Amount";
                                        end;
                                    Abs(RemainingAmount) > Abs(AppliedPmtEntry."Applied Amount"):
                                        begin
                                            if not PostPaymentsOnly then begin
                                                BankAccountLedgerEntry."Remaining Amount" -= AppliedPmtEntry."Applied Amount";
                                                BankAccountLedgerEntry.Modify();
                                            end;
                                            PaymentLineAmount -= AppliedPmtEntry."Applied Amount";
                                        end;
                                    Abs(RemainingAmount) < Abs(AppliedPmtEntry."Applied Amount"):
                                        begin
                                            if not PostPaymentsOnly then
                                                CloseBankAccountLedgerEntry(AppliedPmtEntry."Applies-to Entry No.", RemainingAmount);
                                            PaymentLineAmount -= RemainingAmount;
                                        end;
                                end;
                            end;
                        else
                            OnPostPaymentApplicationsOnAccountTypeCaseElse(AppliedPmtEntry, GenJnlLine);
                    end;
                    IsApplied := true;
                end;
            until AppliedPmtEntry.Next() = 0;

        if PaymentLineAmount <> 0 then begin
            if not IsApplied then
                GenJnlLine."Applies-to ID" := '';
            if (GenJnlLine."Account Type" <> GenJnlLine."Account Type"::"Bank Account") or
               (GenJnlLine."Currency Code" = BankAcc."Currency Code")
            then begin
                GenJnlLine.Validate("Currency Code", BankAcc."Currency Code");
                GenJnlLine.Amount := -PaymentLineAmount;
                if GenJnlLine."Currency Code" <> '' then
                    GenJnlLine."Amount (LCY)" := Round(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          GenJnlLine."Posting Date", GenJnlLine."Currency Code",
                          GenJnlLine.Amount, GenJnlLine."Currency Factor"));
                GenJnlLine.Validate("VAT %");
                GenJnlLine.Validate("Bal. VAT %")
            end else
                Error(ExcessiveAmtErr, PaymentLineAmount, GLSetup.GetCurrencyCode(BankAcc."Currency Code"));

            OnPostPaymentApplicationsOnBeforeValidateApplyRequirements(BankAccReconLine, GenJnlLine, AppliedAmount);

            GenJnlLine.ValidateApplyRequirements(GenJnlLine);
            GenJnlPostLine.RunWithCheck(GenJnlLine);
            OnPostPaymentApplicationsOnAfterPostGenJnlLine(GenJnlLine, GenJnlPostLine);
            if not PostPaymentsOnly then begin
                BankAccountLedgerEntry.SetRange(Open, true);
                BankAccountLedgerEntry.SetRange("Bank Account No.", BankAcc."No.");
                BankAccountLedgerEntry.SetRange("Document Type", GenJnlLine."Document Type");
                BankAccountLedgerEntry.SetRange("Document No.", PostedStamentNo);
                BankAccountLedgerEntry.SetRange("Posting Date", GenJnlLine."Posting Date");
                if BankAccountLedgerEntry.FindLast() then begin
                    BankAccountLedgerEntry."Statement No." := PostedStamentNo;
                    BankAccountLedgerEntry."Statement Line No." := BankAccReconLine."Statement Line No.";
                    BankAccountLedgerEntry.Modify();
                    CloseBankAccountLedgerEntry(BankAccountLedgerEntry."Entry No.", BankAccountLedgerEntry.Amount);
                end;
            end;
        end;
    end;

    local procedure UpdateBank(BankAccRecon: Record "Bank Acc. Reconciliation"; Amt: Decimal)
    begin
        BankAcc.LockTable();
        BankAcc.Get(BankAccRecon."Bank Account No.");
        BankAcc.TestField(Blocked, false);
        BankAcc."Last Statement No." := PostedStamentNo;
        BankAcc."Balance Last Statement" := BankAccRecon."Balance Last Statement" + Amt;
        BankAcc.Modify;
    end;

    local procedure TransferToBankStmt(BankAccRecon: Record "Bank Acc. Reconciliation"; PrePostingOutstdPayments: Decimal; PrePostingOutstdBankTransactions: Decimal; PrePostingGLBalance: Decimal; PrePostingTotalPositiveDifference: Decimal; PrePostingTotalNegativeDifference: Decimal)
    var
        BankAccStmt: Record "Bank Account Statement";
        BankAccStmtLine: Record "Bank Account Statement Line";
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
        IsHandled: Boolean;
        PostedBankAccReconLine: Record "Posted Cashbook Lines";
        PostedBankRec: Record "Posted Bank Rec";
        PostedStatementLines: Record "Posted Bank Acc. Recon. Line";
        LineNo: Integer;
    begin
        IsHandled := false;
        OnBeforeTransferToBankStmt(BankAccRecon, IsHandled);
        if IsHandled then
            exit;



        PostedBankRec.Init();
        PostedBankRec.TransferFields(BankAccRecon);
        PostedBankRec."Statement No." := PostedStamentNo;
        PostedBankRec.Insert();


        BankAccReconLine.Reset();
        BankAccReconLine.SetRange("Bank Account No.", BankAccRecon."Bank Account No.");
        BankAccReconLine.SetRange("Statement No.", BankAccRecon."Statement No.");
        BankAccReconLine.SETFILTER("Statement Amount", '<>%1', 0);
        // BankAccReconLine.SETFILTER(Difference, '<>%1', 0);
        IF BankAccReconLine.FindSet() THEN
            repeat
                PostedStatementLines.Init();
                PostedStatementLines.TransferFields(BankAccReconLine);
                PostedStatementLines."Statement No." := PostedStamentNo;
                PostedStatementLines.Insert();
            until BankAccReconLine.Next() = 0;




        BankAccStmt.Init();
        BankAccStmt.TransferFields(BankAccRecon);
        if BankAccReconLine.LinesExist(BankAccRecon) then
            repeat
                BankAccStmtLine.TransferFields(BankAccReconLine);
                BankAccStmtLine."Statement No." := BankAccStmt."Statement No.";
                OnTransferToBankStmtOnBeforeBankAccStmtLineInsert(BankAccStmtLine, BankAccReconLine);
                BankAccStmtLine.Insert();
                BankAccReconLine.ClearDataExchEntries;
            until BankAccReconLine.Next() = 0;


        BankAccStmtLine.SetRange("Bank Account No.", BankAccStmt."Bank Account No.");
        BankAccStmtLine.SetRange("Statement No.", BankAccStmt."Statement No.");
        BankAccStmtLine.CalcSums("Statement Amount");
        BankAccStmt."G/L Balance at Posting Date" := PrePostingGLBalance;
        BankAccStmt."Outstd. Payments at Posting" := PrePostingOutstdPayments;
        BankAccStmt."Outstd. Transact. at Posting" := PrePostingOutstdBankTransactions;
        BankAccStmt."Total Pos. Diff. at Posting" := PrePostingTotalPositiveDifference;
        BankAccStmt."Total Neg. Diff. at Posting" := PrePostingTotalNegativeDifference;




        //**end of changes

        BankAccStmt.TRANSFERFIELDS(BankAccRecon);
        BankAccStmt."Statement No." := PostedStamentNo;
        //added by Calwide
        IF BankAcc.GET(BankAccRecon."Bank Account No.") THEN BEGIN
            BankAcc.SETRANGE("Date Filter", 0D, BankAccRecon."Statement Date");
            BankAcc.CALCFIELDS(BankAcc."Balance at Date");
            BankAccStmt."Cash Book Balance" := BankAcc."Balance at Date";
        END;
        //end of addition


        OnBeforeBankAccStmtInsert(BankAccStmt, BankAccRecon);
        BankAccStmt.Insert();
    end;

    local procedure GetPostedStamentNo(BankAccRecon: Record "Bank Acc. Reconciliation") StatementNo: Code[20]
    var
        BankAccStmt: Record "Bank Account Statement";
    begin
        StatementNo := BankAccRecon."Statement No.";

        BankAccStmt.SetRange("Bank Account No.", BankAccRecon."Bank Account No.");
        BankAccStmt.SetRange("Statement No.", BankAccRecon."Statement No.");
        if not BankAccStmt.IsEmpty() then
            StatementNo := GetNextStatementNoAndUpdateBankAccount(BankAccRecon."Bank Account No.");
    end;

    local procedure TransferToPostPmtAppln(BankAccRecon: Record "Bank Acc. Reconciliation")
    var
        PostedPmtReconHdr: Record "Posted Payment Recon. Hdr";
        PostedPmtReconLine: Record "Posted Payment Recon. Line";
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
        TypeHelper: Codeunit "Type Helper";
        FieldLength: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeTransferToPostPmtAppln(BankAccRecon, IsHandled);
        if IsHandled then
            exit;

        if BankAccReconLine.LinesExist(BankAccRecon) then
            repeat
                PostedPmtReconLine.TransferFields(BankAccReconLine);

                FieldLength := TypeHelper.GetFieldLength(DATABASE::"Posted Payment Recon. Line",
                    PostedPmtReconLine.FieldNo("Applied Document No."));
                PostedPmtReconLine."Applied Document No." := CopyStr(BankAccReconLine.GetAppliedToDocumentNo, 1, FieldLength);

                FieldLength := TypeHelper.GetFieldLength(DATABASE::"Posted Payment Recon. Line",
                    PostedPmtReconLine.FieldNo("Applied Entry No."));
                PostedPmtReconLine."Applied Entry No." := CopyStr(BankAccReconLine.GetAppliedToEntryNo, 1, FieldLength);

                PostedPmtReconLine.Reconciled := not PostPaymentsOnly;

                OnTransferToPostPmtApplnOnBeforePostedPmtReconLineInsert(PostedPmtReconLine, BankAccReconLine);
                PostedPmtReconLine.Insert();
                BankAccReconLine.ClearDataExchEntries;
            until BankAccReconLine.Next() = 0;

        PostedPmtReconHdr.TransferFields(BankAccRecon);
        OnBeforePostedPmtReconInsert(PostedPmtReconHdr, BankAccRecon);
        PostedPmtReconHdr.Insert();
    end;

    [CommitBehavior(CommitBehavior::Ignore)]
    local procedure CustEntryEditNoCommit(var CustLedgerEntry: Record "Credit Ledger Entry")
    begin
        CODEUNIT.Run(CODEUNIT::"Cust. Entry-Edit", CustLedgerEntry);
    end;

    [CommitBehavior(CommitBehavior::Ignore)]
    local procedure VendEntryEditNoCommit(var VendorLedgerEntry: Record "Savings Ledger Entry")
    begin
        CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", VendorLedgerEntry);
    end;

    procedure ApplyEmployeeLedgEntry(AppliedPmtEntry: Record "Applied Payment Entry"; AppliesToID: Code[50]; PostingDate: Date; PmtDiscDueDate: Date; PmtDiscToleranceDate: Date; RemPmtDiscPossible: Decimal)
    var
        EmployeeLedgerEntry: Record "Employee Ledger Entry";
    begin
        EmployeeLedgerEntry.Get(AppliedPmtEntry."Applies-to Entry No.");
        EmployeeLedgerEntry.TestField(Open);
        BankAcc.Get(AppliedPmtEntry."Bank Account No.");
        if AppliesToID <> '' then begin
            EmployeeLedgerEntry."Applies-to ID" := AppliesToID;
            EmployeeLedgerEntry."Amount to Apply" := AppliedPmtEntry.CalcAmountToApply(PostingDate);
        end;

        if PreviewMode then
            EmplEntryEditNoCommit(EmployeeLedgerEntry)
        else
            CODEUNIT.Run(CODEUNIT::"Empl. Entry-Edit", EmployeeLedgerEntry);
    end;

    [CommitBehavior(CommitBehavior::Ignore)]
    local procedure EmplEntryEditNoCommit(var EmployeeLedgerEntry: Record "Employee Ledger Entry")
    begin
        CODEUNIT.Run(CODEUNIT::"Empl. Entry-Edit", EmployeeLedgerEntry);
    end;

    local procedure CloseBankAccountLedgerEntry(EntryNo: Integer; AppliedAmount: Decimal)
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        CheckLedgerEntry: Record "Check Ledger Entry";
    begin
        BankAccountLedgerEntry.Get(EntryNo);
        BankAccountLedgerEntry.TestField(Open);
        BankAccountLedgerEntry.TestField("Remaining Amount", AppliedAmount);
        BankAccountLedgerEntry."Remaining Amount" := 0;
        BankAccountLedgerEntry.Open := false;
        BankAccountLedgerEntry."Statement Status" := BankAccountLedgerEntry."Statement Status"::Closed;
        BankAccountLedgerEntry.Modify;

        CheckLedgerEntry.Reset();
        CheckLedgerEntry.SetCurrentKey("Bank Account Ledger Entry No.");
        CheckLedgerEntry.SetRange(
          "Bank Account Ledger Entry No.", BankAccountLedgerEntry."Entry No.");
        CheckLedgerEntry.SetRange(Open, true);
        if CheckLedgerEntry.FindSet() then
            repeat
                CheckLedgerEntry.Open := false;
                CheckLedgerEntry."Statement Status" := CheckLedgerEntry."Statement Status"::Closed;
                CheckLedgerEntry.Modify();
            until CheckLedgerEntry.Next() = 0;
    end;

    local procedure GetNextStatementNoAndUpdateBankAccount(BankAccountNo: Code[20]): Code[20]
    var
        BankAccount: Record "Bank Account";
    begin
        BankAccount.SetLoadFields("Last Statement No.");
        BankAccount.Get(BankAccountNo);
        if BankAccount."Last Statement No." <> '' then
            BankAccount."Last Statement No." := IncStr(BankAccount."Last Statement No.")
        else
            BankAccount."Last Statement No." := '1';
        BankAccount.Modify;
        exit(BankAccount."Last Statement No.");
    end;

    local procedure IsRefund(BankAccReconLine: Record "Bank Acc. Reconciliation Line"): Boolean
    begin
        if (BankAccReconLine."Account Type" = BankAccReconLine."Account Type"::Customer) and (BankAccReconLine."Statement Amount" < 0) or
   (BankAccReconLine."Account Type" in [BankAccReconLine."Account Type"::Vendor, BankAccReconLine."Account Type"::Employee]) and (BankAccReconLine."Statement Amount" > 0)
then
            exit(true);
        exit(false);
    end;

    procedure Preview(var BankAccReconciliationSource: Record "Bank Acc. Reconciliation")
    var
        BankAccReconPostPreview: Codeunit "Bank. Acc. Recon. Post Preview";
        BankAccountReconciliationPost: Codeunit "Bank Acc. Reconciliation Post";
    begin
        BankAccReconPostPreview.Preview(BankAccountReconciliationPost, BankAccReconciliationSource);
    end;



    [IntegrationEvent(false, false)]
    local procedure OnBeforeAppliedAmountCheck(var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeBankAccStmtInsert(var BankAccStatement: Record "Bank Account Statement"; BankAccReconciliation: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCloseBankAccLedgEntry(var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFinalizePost(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostPaymentApplications(BankAccReconLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFinalizePost(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInitPost(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePost(var BankAccReconciliation: Record "Bank Acc. Reconciliation"; var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostedPmtReconInsert(var PostedPaymentReconHdr: Record "Posted Payment Recon. Hdr"; BankAccReconciliation: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTransferToPostPmtAppln(var BankAccReconciliation: Record "Bank Acc. Reconciliation"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTransferToBankStmt(var BankAccRecon: Record "Bank Acc. Reconciliation"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCheckLinesMatchEndingBalanceOnAfterCalcSums(var BankAccReconLine: Record "Bank Acc. Reconciliation Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCloseBankAccLedgEntryOnBeforeBankAccLedgEntryModify(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCloseBankAccLedgEntryOnAfterBankAccLedgEntrySetFilters(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeHandlePaymentApplicationTransfer(var BankAccRecon: Record "Bank Acc. Reconciliation"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostPaymentApplicationsOnAfterInitGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostPaymentApplicationsOnAfterPostGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostPaymentApplicationsOnAfterTransactionPostedAndReconciledCheck(BankAccReconLine: Record "Bank Acc. Reconciliation Line"; var AppliedAmount: Decimal; SourceCode: Code[10])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostPaymentApplicationsOnBeforeValidateApplyRequirements(var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; var GenJournalLine: Record "Gen. Journal Line"; AppliedAmount: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostPaymentApplicationsOnAccountTypeCaseElse(var AppliedPaymentEntry: Record "Applied Payment Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostAfterFilterBankAccRecLines(var BankAccReconLines: Record "Bank Acc. Reconciliation Line"; BankAccRecon: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnTransferToBankStmtOnBeforeBankAccStmtLineInsert(var BankAccStmtLine: Record "Bank Account Statement Line"; BankAccReconLine: Record "Bank Acc. Reconciliation Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnTransferToPostPmtApplnOnBeforePostedPmtReconLineInsert(var PostedPmtReconLine: Record "Posted Payment Recon. Line"; BankAccReconLine: Record "Bank Acc. Reconciliation Line")
    begin
    end;
}
