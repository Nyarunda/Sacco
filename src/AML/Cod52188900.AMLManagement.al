

codeunit 50991 "AML Management"
{
    Access = Public;

    var
        AMLSetup: Record "AML Setup";
        HasSetup: Boolean;

    procedure AnalyzeTransaction(var TransactionMonitor: Record "AML Transaction Monitor")
    var
        CustomerRiskProfile: Record "AML Customer Risk Profile";
        SuspiciousActivity: Record "AML Suspicious Activity";
        RiskScore: Decimal;
        ShouldAlert: Boolean;
        AlertType: Enum "AML Alert Type";
        AlertDescription: Text[250];
    begin
        GetAMLSetup();

        // Get or create customer risk profile
        if not CustomerRiskProfile.Get(TransactionMonitor."Customer No.") then begin
            CreateCustomerRiskProfile(TransactionMonitor."Customer No.");
            CustomerRiskProfile.Get(TransactionMonitor."Customer No.");
        end;

        // Calculate transaction risk score
        RiskScore := CalculateTransactionRiskScore(TransactionMonitor, CustomerRiskProfile);
        TransactionMonitor."Risk Score" := RiskScore;

        // Analyze for suspicious patCalculateTransactionRiskScoreterns
        AnalyzeSuspiciousPatterns(TransactionMonitor, CustomerRiskProfile, ShouldAlert, AlertType, AlertDescription);

        if ShouldAlert then begin
            TransactionMonitor."Alert Generated" := true;
            TransactionMonitor."Alert Type" := AlertType;
            TransactionMonitor."Alert Description" := AlertDescription;

            // Create suspicious activity record
            SuspiciousActivity.CreateFromTransactionMonitor(TransactionMonitor);
        end;

        TransactionMonitor.Modify();
    end;

    procedure CalculateTransactionRiskScore(TransactionMonitor: Record "AML Transaction Monitor"; CustomerRiskProfile: Record "AML Customer Risk Profile"): Decimal
    var
        RiskScore: Decimal;
        BaseCustomerRisk: Decimal;
    begin
        GetAMLSetup();

        // Base customer risk score
        case CustomerRiskProfile."Risk Level" of
            CustomerRiskProfile."Risk Level"::Low:
                BaseCustomerRisk := 10;
            CustomerRiskProfile."Risk Level"::Medium:
                BaseCustomerRisk := 30;
            CustomerRiskProfile."Risk Level"::High:
                BaseCustomerRisk := 60;
            CustomerRiskProfile."Risk Level"::Prohibited:
                BaseCustomerRisk := 90;
        end;

        RiskScore := BaseCustomerRisk;

        // High value transaction risk
        if TransactionMonitor."Transaction Type" = TransactionMonitor."Transaction Type"::Deposit then begin
            if TransactionMonitor."Amount (LCY)" > AMLSetup."High Value Threshold (D)" then
                RiskScore += 25;
        end else if TransactionMonitor."Transaction Type" = TransactionMonitor."Transaction Type"::Withdrawal then begin
            if TransactionMonitor."Amount (LCY)" > AMLSetup."High Value Threshold (W)" then
                RiskScore += 25;
        end;


        // Velocity risk - multiple transactions in short period
        if TransactionMonitor."Transaction Type" = TransactionMonitor."Transaction Type"::Deposit then begin
            if TransactionMonitor."Daily Transaction Count" > AMLSetup."Max Daily Transactions (D)" then
                RiskScore += 20;
            if TransactionMonitor."Daily Transaction Amount" > AMLSetup."Max Daily Amount (D)" then
                RiskScore += 15;
            if TransactionMonitor."Monthly Transaction Count" > AMLSetup."Max Monthly Transactions (D)" then
                RiskScore += 20;
            if TransactionMonitor."Monthly Transaction Amount" > AMLSetup."Max Monthly Amount (D)" then
                RiskScore += 15;
        end else if TransactionMonitor."Transaction Type" = TransactionMonitor."Transaction Type"::Withdrawal then begin
            if TransactionMonitor."Daily Transaction Count" > AMLSetup."Max Daily Transactions (W)" then
                RiskScore += 20;
            if TransactionMonitor."Daily Transaction Amount" > AMLSetup."Max Daily Amount (W)" then
                RiskScore += 15;
            if TransactionMonitor."Monthly Transaction Count" > AMLSetup."Max Monthly Transactions (W)" then
                RiskScore += 20;
            if TransactionMonitor."Monthly Transaction Amount" > AMLSetup."Max Monthly Amount (W)" then
                RiskScore += 15;
        end;

        // Round amount risk (potential structuring)
        if IsRoundAmount(TransactionMonitor."Amount (LCY)") then
            RiskScore += 10;

        // Weekend/Holiday transaction risk
        if IsWeekendOrHoliday(TransactionMonitor."Transaction Date") then
            RiskScore += 5;

        // Time-based risk (off-hours transactions)
        if IsOffHours(TransactionMonitor."Transaction Time") then
            RiskScore += 5;

        // Cash transaction risk
        if IsCashTransaction(TransactionMonitor) then
            RiskScore += 10;

        // Cross-border risk
        if IsCrossBorderTransaction(TransactionMonitor) then
            RiskScore += 15;

        // PEP risk
        if CustomerRiskProfile."Is PEP" then
            RiskScore += 20;

        // High risk country
        if CustomerRiskProfile."High Risk Country" then
            RiskScore += 15;

        // Ensure risk score is within bounds
        if RiskScore > 100 then RiskScore := 100;
        if RiskScore < 0 then RiskScore := 0;

        exit(RiskScore);
    end;

    procedure AnalyzeSuspiciousPatterns(TransactionMonitor: Record "AML Transaction Monitor"; CustomerRiskProfile: Record "AML Customer Risk Profile"; var ShouldAlert: Boolean; var AlertType: Enum "AML Alert Type"; var AlertDescription: Text[250])
    begin
        GetAMLSetup();
        ShouldAlert := false;

        // High value transaction alert
        if TransactionMonitor."Transaction Type" = TransactionMonitor."Transaction Type"::Deposit then begin
            if TransactionMonitor."Amount (LCY)" > AMLSetup."High Value Threshold (D)" then begin
                ShouldAlert := true;
                AlertType := AlertType::HighValue;
                AlertDescription := StrSubstNo('High value deposit of %1 detected', TransactionMonitor."Amount (LCY)");
                exit;
            end;
        end;
        if TransactionMonitor."Transaction Type" = TransactionMonitor."Transaction Type"::Withdrawal then begin
            if TransactionMonitor."Amount (LCY)" > AMLSetup."High Value Threshold (W)" then begin
                ShouldAlert := true;
                AlertType := AlertType::HighValue;
                AlertDescription := StrSubstNo('High value withdrawal of %1 detected', TransactionMonitor."Amount (LCY)");
                exit;
            end;
        end;

        // Velocity alert
        if TransactionMonitor."Transaction Type" = TransactionMonitor."Transaction Type"::Deposit then begin
            if (TransactionMonitor."Daily Transaction Count" > AMLSetup."Max Daily Transactions (D)") or
               (TransactionMonitor."Daily Transaction Amount" > AMLSetup."Max Daily Amount (D)") then begin
                ShouldAlert := true;
                AlertType := AlertType::Velocity;
                AlertDescription := StrSubstNo('High velocity detected: %1 transactions totaling %2',
                    TransactionMonitor."Daily Transaction Count", TransactionMonitor."Daily Transaction Amount");
                exit;
            end;
        end else if TransactionMonitor."Transaction Type" = TransactionMonitor."Transaction Type"::Withdrawal then begin
            if (TransactionMonitor."Daily Transaction Count" > AMLSetup."Max Daily Transactions (W)") or
               (TransactionMonitor."Daily Transaction Amount" > AMLSetup."Max Daily Amount (W)") then begin
                ShouldAlert := true;
                AlertType := AlertType::Velocity;
                AlertDescription := StrSubstNo('High velocity detected: %1 transactions totaling %2',
                    TransactionMonitor."Daily Transaction Count", TransactionMonitor."Daily Transaction Amount");
                exit;
            end;
        end;

        // Structured transaction alert (just under reporting threshold)
        if IsStructuredTransaction(TransactionMonitor) then begin
            ShouldAlert := true;
            AlertType := AlertType::Structured;
            AlertDescription := 'Potential structuring detected - transaction just under threshold';
            exit;
        end;

        // PEP transaction alert
        if TransactionMonitor."Transaction Type" = TransactionMonitor."Transaction Type"::Deposit then begin
            if CustomerRiskProfile."Is PEP" and (TransactionMonitor."Amount (LCY)" > AMLSetup."PEP Alert Threshold (D)") then begin
                ShouldAlert := true;
                AlertType := AlertType::PEP;
                AlertDescription := 'PEP transaction above threshold detected';
                exit;
            end;
        end else if TransactionMonitor."Transaction Type" = TransactionMonitor."Transaction Type"::Withdrawal then begin
            if CustomerRiskProfile."Is PEP" and (TransactionMonitor."Amount (LCY)" > AMLSetup."PEP Alert Threshold (W)") then begin
                ShouldAlert := true;
                AlertType := AlertType::PEP;
                AlertDescription := 'PEP transaction above threshold detected';
                exit;
            end;
        end;

        // Unusual pattern alert
        if DetectUnusualPattern(TransactionMonitor) then begin
            ShouldAlert := true;
            AlertType := AlertType::Unusual;
            AlertDescription := 'Unusual transaction pattern detected';
            exit;
        end;

        // High risk score alert
        if TransactionMonitor."Risk Score" >= AMLSetup."Alert Risk Threshold" then begin
            ShouldAlert := true;
            AlertType := AlertType::Threshold;
            AlertDescription := StrSubstNo('High risk score of %1 calculated', TransactionMonitor."Risk Score");
            exit;
        end;
    end;

    procedure CreateCustomerRiskProfile(CustomerNo: Code[20]): Boolean
    var
        SavingsAccount: Record "Savings Accounts";
        CustomerRiskProfile: Record "AML Customer Risk Profile";
    begin
        if not SavingsAccount.Get(CustomerNo) then
            exit(false);

        CustomerRiskProfile.Init();
        CustomerRiskProfile."Customer No." := CustomerNo;
        CustomerRiskProfile."Risk Level" := CustomerRiskProfile."Risk Level"::Low;
        CustomerRiskProfile."Risk Score" := 10;
        CustomerRiskProfile."Review Frequency Months" := 12;
        CustomerRiskProfile."Last Review Date" := Today;

        if CustomerRiskProfile.Insert() then begin
            CustomerRiskProfile.UpdateRiskMetrics();
            exit(true);
        end;

        exit(false);
    end;

    procedure UpdateAllCustomerRiskProfiles()
    var
        CustomerRiskProfile: Record "AML Customer Risk Profile";
        ProgressDialog: Dialog;
        Counter: Integer;
        Total: Integer;
    begin
        Total := CustomerRiskProfile.Count;
        ProgressDialog.Open('Updating customer risk profiles...\Progress: @1@@@@@@@@@@@@@@@@');

        if CustomerRiskProfile.FindSet() then
            repeat
                Counter += 1;
                ProgressDialog.Update(1, Round(Counter / Total * 10000, 1));
                CustomerRiskProfile.UpdateRiskMetrics();
            until CustomerRiskProfile.Next() = 0;

        ProgressDialog.Close();
        Message('Updated %1 customer risk profiles.', Total);
    end;

    procedure ProcessSavingsTransaction(SavingsEntry: Record "Savings Ledger Entry")
    var
        TransactionMonitor: Record "AML Transaction Monitor";
    begin
        // Create transaction monitor record
        CreateFromSavingsEntry(SavingsEntry);
    end;

    procedure ProcessCreditTransaction(CreditEntry: Record "Credit Ledger Entry")
    var
        TransactionMonitor: Record "AML Transaction Monitor";
    begin
        // Create transaction monitor record
        CreateFromCreditEntry(CreditEntry);
    end;



    procedure CreateFromSavingsEntry(SavingsEntry: Record "Savings Ledger Entry")
    var
        TransactionMonitor: Record "AML Transaction Monitor";
    begin
        if SavingsEntry.Reversed then
            exit;

        TransactionMonitor.Init();
        TransactionMonitor."Entry No." := SavingsEntry."Entry No.";
        TransactionMonitor."Customer No." := SavingsEntry."Account No.";
        TransactionMonitor."Transaction Date" := SavingsEntry."Posting Date";
        TransactionMonitor."Source Table ID" := Database::"Savings Ledger Entry";
        TransactionMonitor."Source Entry No." := SavingsEntry."Entry No.";
        TransactionMonitor."Source Document No." := SavingsEntry."Document No.";
        TransactionMonitor."Account No." := SavingsEntry."Account No.";
        TransactionMonitor."Account Type" := 'Savings';
        TransactionMonitor."Member No." := SavingsEntry."Member No.";

        if SavingsEntry."Debit Amount" > 0 then begin
            TransactionMonitor."Transaction Type" := TransactionMonitor."Transaction Type"::Withdrawal;
            TransactionMonitor."Amount" := SavingsEntry."Debit Amount";
            TransactionMonitor."Amount (LCY)" := SavingsEntry."Debit Amount";
        end else begin
            TransactionMonitor."Transaction Type" := TransactionMonitor."Transaction Type"::Deposit;
            TransactionMonitor."Amount" := SavingsEntry."Credit Amount";
            TransactionMonitor."Amount (LCY)" := SavingsEntry."Credit Amount";
        end;

        TransactionMonitor."Currency Code" := '';

        TransactionMonitor.Insert(true);

        //TransactionMonitor.SetRange("Entry No.", SavingsEntry."Entry No.");
        //if TransactionMonitor.FindFirst() then
        AnalyzeTransaction(TransactionMonitor);

    end;

    procedure CreateFromCreditEntry(CreditEntry: Record "Credit Ledger Entry")
    var
        TransactionMonitor: Record "AML Transaction Monitor";
    begin
        if CreditEntry.Reversed then
            exit;

        TransactionMonitor.Init();
        TransactionMonitor."Customer No." := CreditEntry."Loan No.";
        TransactionMonitor."Transaction Date" := CreditEntry."Posting Date";
        TransactionMonitor."Source Table ID" := Database::"Credit Ledger Entry";
        TransactionMonitor."Source Entry No." := CreditEntry."Entry No.";
        TransactionMonitor."Source Document No." := CreditEntry."Document No.";
        TransactionMonitor."Account No." := CreditEntry."Account No.";
        TransactionMonitor."Account Type" := 'Credit';
        TransactionMonitor."Member No." := CreditEntry."Member No.";
        TransactionMonitor."Loan No." := CreditEntry."Loan No.";

        if CreditEntry."Debit Amount" > 0 then begin
            TransactionMonitor."Transaction Type" := TransactionMonitor."Transaction Type"::LoanDisbursement;
            TransactionMonitor."Amount" := CreditEntry."Debit Amount";
            TransactionMonitor."Amount (LCY)" := CreditEntry."Debit Amount";
        end else begin
            TransactionMonitor."Transaction Type" := TransactionMonitor."Transaction Type"::LoanRepayment;
            TransactionMonitor."Amount" := CreditEntry."Credit Amount";
            TransactionMonitor."Amount (LCY)" := CreditEntry."Credit Amount";
        end;

        TransactionMonitor."Currency Code" := '';

        TransactionMonitor.Insert(true);
    end;

    procedure SimulateTransaction(CustomerNo: Code[20]; Amount: Decimal; TransactionType: Enum "AML Transaction Type"; PostingDate: Date; AccountType: Text[20]; MemberNo: Code[20]; TransactionChannel: Text[20]; CurrencyCode: Code[10])
    var
        TransactionMonitor: Record "AML Transaction Monitor";
    begin
        // Create a simulated transaction monitor entry and run analysis
        TransactionMonitor.Init();
        TransactionMonitor."Customer No." := CustomerNo;
        TransactionMonitor."Transaction Date" := PostingDate;
        TransactionMonitor."Source Table ID" := 0; // simulated
        TransactionMonitor."Source Entry No." := 0;
        TransactionMonitor."Source Document No." := CopyStr(Format(CreateGuid()), 2, 15);
        TransactionMonitor."Account Type" := AccountType;
        TransactionMonitor."Member No." := MemberNo;
        TransactionMonitor."Transaction Type" := TransactionType;
        TransactionMonitor."Amount" := Amount;
        TransactionMonitor."Amount (LCY)" := Amount;
        TransactionMonitor."Currency Code" := CurrencyCode;
        TransactionMonitor."Transaction Channel" := TransactionChannel;

        TransactionMonitor.Insert(true);

        // Analyze immediately so the simulated entry behaves like a real one
        AnalyzeTransaction(TransactionMonitor);
    end;

    procedure SimulateTransactionsForSavingsAccounts(FromDate: Date; ToDate: Date)
    var
        SavingsAccount: Record "Savings Accounts";
        ProgressDialog: Dialog;
        SimulatedCount: Integer;
        TotalAvailable: Integer;  // actual count from DB
        PickCount: Integer;       // how many members to pick (max 100)
        SimulatedMembers: Integer;
        TxType: Enum "AML Transaction Type";
        CustNo: Code[20];
        MemNo: Code[20];
        PostingDate: Date;
        Amount: Decimal;
        DateRange: Integer;
        RandomDay: Integer;
        TxPerMember: Integer;
        i: Integer;               // total accounts iterated (for probability)
    begin
        // Default date window
        if FromDate = 0D then
            FromDate := CalcDate('<-1M>', Today);
        if ToDate = 0D then
            ToDate := Today;

        if FromDate > ToDate then
            Error('From Date %1 cannot be greater than To Date %2.', FromDate, ToDate);

        DateRange := ToDate - FromDate;

        SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Ordinary Savings");

        TotalAvailable := SavingsAccount.Count;
        if TotalAvailable = 0 then begin
            Message('No savings accounts found.');
            exit;
        end;

        PickCount := 100;  // pick 100 or all if fewer exist
        if TotalAvailable < PickCount then
            PickCount := TotalAvailable;

        ProgressDialog.Open(
            'Simulating AML Test Transactions...\' +
            'Members:      #1####  of  #2####\' +
            'Transactions: #3####\' +
            'Progress:     @4@@@@@@@@@@@@@@@@@@@');

        ProgressDialog.Update(2, PickCount);

        SimulatedCount := 0;
        SimulatedMembers := 0;
        i := 0;  // accounts iterated — increments every loop

        if SavingsAccount.FindSet() then
            repeat
                i += 1;  // always increment — tracks position for probability formula

                // Sequential random sampling:
                // As remaining needed approaches remaining available, probability → 1
                if Random(TotalAvailable - (i - 1)) <= (PickCount - SimulatedMembers) then begin

                    CustNo := SavingsAccount."No.";
                    MemNo := SavingsAccount."Member No.";

                    // Random transactions per member: 1 to 5
                    TxPerMember := Random(5);

                    repeat
                        TxPerMember -= 1;

                        // Random date within range
                        RandomDay := 0;
                        if DateRange > 0 then
                            RandomDay := Random(DateRange) - 1;
                        PostingDate := FromDate + RandomDay;

                        // Random amount: KES 500 to KES 500,000
                        Amount := (Random(999) + 1) * 500;

                        // Random type
                        if Random(2) = 1 then
                            TxType := TxType::Deposit
                        else
                            TxType := TxType::Withdrawal;

                        SimulateTransaction(CustNo, Amount, TxType, PostingDate, 'Savings', MemNo, 'CASH', '');
                        SimulatedCount += 1;

                    until TxPerMember = 0;

                    SimulatedMembers += 1;

                    ProgressDialog.Update(1, SimulatedMembers);
                    ProgressDialog.Update(3, SimulatedCount);
                    ProgressDialog.Update(4, Round(SimulatedMembers / PickCount * 10000, 1));
                end;

            until (SavingsAccount.Next() = 0) or (SimulatedMembers >= PickCount);

        ProgressDialog.Close();

        Message('Simulation complete.\nMembers picked: %1 of %2\nTransactions created: %3',
                SimulatedMembers, TotalAvailable, SimulatedCount);
    end;

    local procedure IsRoundAmount(Amount: Decimal): Boolean
    begin
        // Check if amount is a round number (ending in multiple zeros)
        exit((Amount mod 1000) = 0);
    end;

    local procedure IsWeekendOrHoliday(TransactionDate: Date): Boolean
    begin
        // Check if transaction is on weekend
        exit(Date2DWY(TransactionDate, 1) in [1, 7]); // Sunday = 1, Saturday = 7
    end;

    local procedure IsOffHours(TransactionTime: Time): Boolean
    begin
        GetAMLSetup();
        // Check if transaction is outside business hours
        exit((TransactionTime < AMLSetup."Business Hours Start") or
             (TransactionTime > AMLSetup."Business Hours End"));
    end;

    local procedure IsCashTransaction(TransactionMonitor: Record "AML Transaction Monitor"): Boolean
    begin
        // Check if transaction involves cash (based on transaction channel or other indicators)
        exit(TransactionMonitor."Transaction Channel" = 'CASH');
    end;

    local procedure IsCrossBorderTransaction(TransactionMonitor: Record "AML Transaction Monitor"): Boolean
    begin
        // Check if transaction involves cross-border elements
        exit(TransactionMonitor."Currency Code" <> '');
    end;

    local procedure IsStructuredTransaction(TransactionMonitor: Record "AML Transaction Monitor"): Boolean
    begin
        GetAMLSetup();
        // Check if amount is just under the reporting threshold (potential structuring)
        if transactionMonitor."Transaction Type" = transactionMonitor."Transaction Type"::Deposit then
            exit((TransactionMonitor."Amount (LCY)" >= (AMLSetup."Cash Reporting Threshold (D)" * 0.9)) and
                 (TransactionMonitor."Amount (LCY)" < AMLSetup."Cash Reporting Threshold (D)"))
        else if transactionMonitor."Transaction Type" = transactionMonitor."Transaction Type"::Withdrawal then
            exit((TransactionMonitor."Amount (LCY)" >= (AMLSetup."Cash Reporting Threshold (W)" * 0.9)) and
                 (TransactionMonitor."Amount (LCY)" < AMLSetup."Cash Reporting Threshold (W)"));
    end;

    local procedure DetectUnusualPattern(TransactionMonitor: Record "AML Transaction Monitor"): Boolean
    var
        HistoricalAverage: Decimal;
        DeviationThreshold: Decimal;
    begin
        GetAMLSetup();

        // Calculate historical average for this customer and transaction type
        HistoricalAverage := CalculateHistoricalAverage(TransactionMonitor."Customer No.", TransactionMonitor."Transaction Type");

        if HistoricalAverage = 0 then
            exit(false); // No historical data

        DeviationThreshold := AMLSetup."Pattern Deviation Threshold";

        // Check if current transaction deviates significantly from historical pattern
        exit(Abs(TransactionMonitor."Amount (LCY)" - HistoricalAverage) >
             (HistoricalAverage * (DeviationThreshold / 100)));
    end;

    local procedure CalculateHistoricalAverage(CustomerNo: Code[20]; TransactionType: Enum "AML Transaction Type"): Decimal
    var
        TransactionMonitor: Record "AML Transaction Monitor";
        TotalAmount: Decimal;
        Count: Integer;
        DateFilter: Date;
    begin
        DateFilter := CalcDate('<-3M>', Today);

        TransactionMonitor.SetRange("Customer No.", CustomerNo);
        TransactionMonitor.SetRange("Transaction Type", TransactionType);
        TransactionMonitor.SetFilter("Transaction Date", '>=%1', DateFilter);

        if TransactionMonitor.FindSet() then
            repeat
                TotalAmount += TransactionMonitor."Amount (LCY)";
                Count += 1;
            until TransactionMonitor.Next() = 0;

        if Count > 0 then
            exit(TotalAmount / Count)
        else
            exit(0);
    end;

    local procedure GetAMLSetup()
    begin
        if HasSetup then
            exit;

        if not AMLSetup.Get() then begin
            AMLSetup.Init();
            AMLSetup."High Value Threshold (D)" := 1000000; // 1M
            AMLSetup."High Value Threshold (W)" := 500000; // 500K
            AMLSetup."Cash Reporting Threshold (D)" := 500000; // 500K
            AMLSetup."Cash Reporting Threshold (W)" := 500000; // 500K
            AMLSetup."Max Daily Transactions (D)" := 20;
            AMLSetup."Max Daily Transactions (W)" := 20;
            AMLSetup."Max Daily Amount (D)" := 5000000; // 5M
            AMLSetup."Max Daily Amount (W)" := 5000000; // 5M
            AMLSetup."Alert Risk Threshold" := 70;
            AMLSetup."PEP Alert Threshold (D)" := 100000; // 100K
            AMLSetup."PEP Alert Threshold (W)" := 100000; // 100K
            AMLSetup."Pattern Deviation Threshold" := 200; // 200%
            AMLSetup."Business Hours Start" := 080000T; // 8:00 AM
            AMLSetup."Business Hours End" := 170000T; // 5:00 PM
            AMLSetup.Insert();
        end;

        HasSetup := true;
    end;

    procedure ProcessPendingTransactions()
    var
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        TempSavingsEntry: Record "Savings Ledger Entry" temporary;
        AMLTransactionMonitor: Record "AML Transaction Monitor";
        ProcessedCount: Integer;
        ErrorCount: Integer;
        ProgressDialog: Dialog;
        TotalRecords: Integer;
        CurrentRecord: Integer;
        j: Integer;
    begin
        ProcessedCount := 0;
        ErrorCount := 0;
        // --- Phase 1: Snapshot into temp table (short live cursor) ---
        SavingsLedgerEntry.SetLoadFields(
                            "Entry No.", "Member No.", "Amount", "Posting Date",
                            "Debit Amount", "Credit Amount",
                            "Document No.", "Reversed",
                            "Account No.");

        // Count first for the dialog
        TotalRecords := SavingsLedgerEntry.Count;

        if TotalRecords = 0 then
            exit;

        ProgressDialog.Open(
            'Loading transactions into buffer...\' +
            'Total to load:  #1#########\' +
            'Loaded so far:  #2#########');

        ProgressDialog.Update(1, TotalRecords);

        if SavingsLedgerEntry.FindSet() then
            repeat
                TempSavingsEntry := SavingsLedgerEntry;
                TempSavingsEntry.Insert();
                CurrentRecord += 1;
                ProgressDialog.Update(2, CurrentRecord);
            until SavingsLedgerEntry.Next() = 0;

        ProgressDialog.Close();
        // Live cursor on SavingsLedgerEntry is now CLOSED

        // --- Phase 2: Process from temp table (no live table lock) ---
        TotalRecords := TempSavingsEntry.Count;
        CurrentRecord := 0;
        j := 0;

        if TotalRecords = 0 then
            exit;

        ProgressDialog.Open(
            'Processing AML Savings Transactions...\' +
            'Progress: @1@@@@@@@@@@@@@@@@@@@@\' +
            'Current Record: #2#########\' +
            'Total Records: #5#########\' +
            'Processed: #3######## Errors: #4#####');

        if TempSavingsEntry.FindSet() then
            repeat
                j += 1;
                if j > 500 then begin
                    Commit();   // ✅ Safe now — temp table cursor is unaffected by Commit()
                    j := 0;
                end;

                CurrentRecord += 1;
                ProgressDialog.Update(1, Round(CurrentRecord / TotalRecords * 10000, 1));
                ProgressDialog.Update(2, CurrentRecord);
                ProgressDialog.Update(3, ProcessedCount);
                ProgressDialog.Update(4, ErrorCount);
                ProgressDialog.Update(5, TotalRecords);

                AMLTransactionMonitor.SetRange("Source Table ID", Database::"Savings Ledger Entry");
                AMLTransactionMonitor.SetRange("Source Entry No.", TempSavingsEntry."Entry No.");
                if AMLTransactionMonitor.IsEmpty then begin
                    if TryProcessSavingsTransaction(TempSavingsEntry) then
                        ProcessedCount += 1
                    else
                        ErrorCount += 1;
                end;
            until TempSavingsEntry.Next() = 0;

        ProgressDialog.Close();

        if ProcessedCount > 0 then
            Message('AML Processing completed. Processed: %1 transactions. Errors: %2',
                    ProcessedCount, ErrorCount);
    end;

    procedure OldProcessPendingTransactions()
    var
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        AMLTransactionMonitor: Record "AML Transaction Monitor";
        ProcessedCount: Integer;
        ErrorCount: Integer;
        ProgressDialog: Dialog;
        TotalRecords: Integer;
        CurrentRecord: Integer;
        j: Integer;
    begin
        ProcessedCount := 0;
        ErrorCount := 0;

        // Process unmonitored Savings transactions from last 24 hours
        SavingsLedgerEntry.SetFilter("Posting Date", '>=%1', CalcDate('<-CY>', Today));


        // Count total records for progress tracking
        TotalRecords := SavingsLedgerEntry.Count;
        CurrentRecord := 0;
        j := 0;

        if TotalRecords > 0 then begin
            ProgressDialog.Open('Processing AML Savings Transactions...\' +
                              'Progress: @1@@@@@@@@@@@@@@@@@@@@\' +
                              'Current Record: #2#########\' +
                              'Total Records: #5#########\' +
                              'Processed: #3######## Errors: #4#####');

            if SavingsLedgerEntry.FindSet() then
                repeat
                    j += 1;
                    if j > 500 then begin
                        Commit();
                        j := 0;
                    end;
                    CurrentRecord += 1;
                    ProgressDialog.Update(1, Round(CurrentRecord / TotalRecords * 10000, 1));
                    ProgressDialog.Update(2, CurrentRecord);
                    ProgressDialog.Update(3, ProcessedCount);
                    ProgressDialog.Update(4, ErrorCount);
                    ProgressDialog.Update(5, TotalRecords);

                    // Check if transaction is already monitored
                    AMLTransactionMonitor.SetRange("Source Table ID", Database::"Savings Ledger Entry");
                    AMLTransactionMonitor.SetRange("Source Entry No.", SavingsLedgerEntry."Entry No.");
                    if AMLTransactionMonitor.IsEmpty then begin
                        if TryProcessSavingsTransaction(SavingsLedgerEntry) then
                            ProcessedCount += 1
                        else
                            ErrorCount += 1;
                    end;
                until SavingsLedgerEntry.Next() = 0;

            ProgressDialog.Close();
        end;

        // Process unmonitored Credit transactions from last 24 hours
        /*
        CreditLedgerEntry.SetFilter("Amount", '<0');
        CreditLedgerEntry.SetRange("AML Entry Exists", false);
        if CreditLedgerEntry.FindSet() then
            repeat
                // Check if transaction is already monitored
                AMLTransactionMonitor.SetRange("Source Table ID", Database::"Credit Ledger Entry");
                AMLTransactionMonitor.SetRange("Source Entry No.", CreditLedgerEntry."Entry No.");
                if AMLTransactionMonitor.IsEmpty then begin
                    if TryProcessCreditTransaction(CreditLedgerEntry) then
                        ProcessedCount += 1
                    else
                        ErrorCount += 1;
                end;
            until CreditLedgerEntry.Next() = 0;

        */

        // Log results
        if ProcessedCount > 0 then
            Message('AML Processing completed. Processed: %1 transactions. Errors: %2', ProcessedCount, ErrorCount);
    end;


    local procedure TryProcessSavingsTransaction(SavingsEntry: Record "Savings Ledger Entry"): Boolean
    begin
        ProcessSavingsTransaction(SavingsEntry);
        exit(true);
    end;


    local procedure TryProcessCreditTransaction(CreditEntry: Record "Credit Ledger Entry"): Boolean
    begin
        ProcessCreditTransaction(CreditEntry);
        exit(true);
    end;
}
