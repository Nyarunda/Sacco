codeunit 59899 "Sacco Mpesa Activities Tests"
{
    Subtype = Test;
    TestPermissions = Disabled;
    Permissions = tabledata "Gen. Journal Line" = rimd;

    var
        SaccoActivities: Codeunit "Sacco Activities";
        MpesaActivities: Codeunit "Mpesa Activities";
        JTemplate: Code[10];
        JBatch: Code[10];
        TestAccountNo: Code[20];
        TestLoanNo: Code[20];

    [Test]
    procedure GetJournalDebitsIncludesDebitLinesAndCreditBalancingLines()
    var
        AccountType: Enum "Gen. Journal Account Type";
        ActualDebits: Decimal;
    begin
        Initialize();

        InsertGenJournalLine(10000, AccountType::"G/L Account", TestAccountNo, AccountType::"G/L Account", '', 100, '', "Transaction Type Enum"::" ");
        InsertGenJournalLine(20000, AccountType::"G/L Account", 'OTHER', AccountType::"G/L Account", TestAccountNo, -40, '', "Transaction Type Enum"::" ");
        InsertGenJournalLine(30000, AccountType::"G/L Account", TestAccountNo, AccountType::"G/L Account", '', -999, '', "Transaction Type Enum"::" ");

        ActualDebits := SaccoActivities.GetJournalDebits(JTemplate, JBatch, AccountType::"G/L Account", TestAccountNo);

        AssertDecimalEquals(140, ActualDebits, 'GetJournalDebits should total positive account lines and negative balancing lines.');
    end;

    [Test]
    procedure GetJournalCreditsIncludesCreditLinesAndDebitBalancingLines()
    var
        AccountType: Enum "Gen. Journal Account Type";
        ActualCredits: Decimal;
    begin
        Initialize();

        InsertGenJournalLine(10000, AccountType::"G/L Account", TestAccountNo, AccountType::"G/L Account", '', -60, '', "Transaction Type Enum"::" ");
        InsertGenJournalLine(20000, AccountType::"G/L Account", 'OTHER', AccountType::"G/L Account", TestAccountNo, 25, '', "Transaction Type Enum"::" ");
        InsertGenJournalLine(30000, AccountType::"G/L Account", TestAccountNo, AccountType::"G/L Account", '', 999, '', "Transaction Type Enum"::" ");

        ActualCredits := SaccoActivities.GetJournalCredits(JTemplate, JBatch, AccountType::"G/L Account", TestAccountNo);

        AssertDecimalEquals(85, ActualCredits, 'GetJournalCredits should total negative account lines and positive balancing lines.');
    end;

    [Test]
    procedure GetJournalLoanCreditsFiltersByLoanAndTransactionType()
    var
        AccountType: Enum "Gen. Journal Account Type";
        ActualCredits: Decimal;
    begin
        Initialize();

        InsertGenJournalLine(10000, AccountType::"G/L Account", TestAccountNo, AccountType::"G/L Account", '', -100, TestLoanNo, "Transaction Type Enum"::"Principal Repayment");
        InsertGenJournalLine(20000, AccountType::"G/L Account", TestAccountNo, AccountType::"G/L Account", '', -50, 'OTHERLOAN', "Transaction Type Enum"::"Principal Repayment");
        InsertGenJournalLine(30000, AccountType::"G/L Account", TestAccountNo, AccountType::"G/L Account", '', -30, TestLoanNo, "Transaction Type Enum"::"Interest Paid");
        InsertGenJournalLine(40000, AccountType::"G/L Account", 'OTHER', AccountType::"G/L Account", TestAccountNo, 25, TestLoanNo, "Transaction Type Enum"::"Principal Repayment");

        ActualCredits := SaccoActivities.GetJournalLoanCredits(
            JTemplate,
            JBatch,
            AccountType::"G/L Account",
            TestAccountNo,
            TestLoanNo,
            "Transaction Type Enum"::"Principal Repayment");

        AssertDecimalEquals(125, ActualCredits, 'GetJournalLoanCredits should only include the selected loan and transaction type.');
    end;

    [Test]
    procedure GetMonthsInDefaultReturnsZeroWhenLoanDoesNotExist()
    var
        DefAmount: Decimal;
        GracePeriod: DateFormula;
        ActualMonths: Decimal;
    begin
        Initialize();

        Evaluate(GracePeriod, '<0D>');
        ActualMonths := SaccoActivities.GetMonthsInDefault('UT-NOLOAN', Today, GracePeriod, DefAmount);

        AssertDecimalEquals(0, ActualMonths, 'Missing loans should not return months in default.');
        AssertDecimalEquals(0, DefAmount, 'Missing loans should not return a default amount.');
    end;

    [Test]
    procedure MpesaProcessRequestErrorsForInvalidJson()
    begin
        Initialize();

        asserterror MpesaActivities.ProcessRequest('this is not json');

        AssertTextContains(GetLastErrorText(), 'Invalid Json Input', 'Invalid JSON should raise the expected MPESA request error.');
    end;

    [Test]
    procedure PostMpesaDepositsTransactionReturnsFalseWhenTransactionIsMissing()
    var
        Posted: Boolean;
    begin
        Initialize();

        Posted := MpesaActivities.PostMpesaDepositsTransaction('UT-MISSING');

        AssertFalse(Posted, 'Missing MPESA transactions should not be posted.');
    end;

    local procedure Initialize()
    begin
        JTemplate := 'UTSACCO';
        JBatch := 'DEFAULT';
        TestAccountNo := 'UT-GL-001';
        TestLoanNo := 'UT-LOAN-001';

        CleanupTestJournalLines();
    end;

    local procedure InsertGenJournalLine(LineNo: Integer; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[20]; BalAccountType: Enum "Gen. Journal Account Type"; BalAccountNo: Code[20]; Amount: Decimal; LoanNo: Code[20]; TransactionType: Enum "Transaction Type Enum")
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := JTemplate;
        GenJournalLine."Journal Batch Name" := JBatch;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Posting Date" := WorkDate();
        GenJournalLine."Document No." := 'UT-DOC';
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Bal. Account Type" := BalAccountType;
        GenJournalLine."Bal. Account No." := BalAccountNo;
        GenJournalLine.Amount := Amount;
        GenJournalLine."Loan No." := LoanNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine.Insert(false);
    end;

    local procedure CleanupTestJournalLines()
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", JTemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if not GenJournalLine.IsEmpty() then
            GenJournalLine.DeleteAll(false);
    end;

    local procedure AssertDecimalEquals(Expected: Decimal; Actual: Decimal; FailureMessage: Text)
    begin
        if Expected <> Actual then
            Error('%1 Expected %2, actual %3.', FailureMessage, Expected, Actual);
    end;

    local procedure AssertFalse(Actual: Boolean; FailureMessage: Text)
    begin
        if Actual then
            Error(FailureMessage);
    end;

    local procedure AssertTextContains(ActualText: Text; ExpectedText: Text; FailureMessage: Text)
    begin
        if StrPos(ActualText, ExpectedText) = 0 then
            Error('%1 Expected text to contain "%2". Actual text: "%3".', FailureMessage, ExpectedText, ActualText);
    end;
}
