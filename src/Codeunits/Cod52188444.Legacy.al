/// <summary>
/// Codeunit Legacy (ID 52188435).
/// </summary>
codeunit 50078 Legacy
{



    /// <summary>
    /// CreateGnlJournalLine.
    /// </summary>
    /// <param name="TemplateName">Text.</param>
    /// <param name="BatchName">Text.</param>
    /// <param name="DocumentNo">Code[30].</param>
    /// <param name="LineNo">Integer.</param>
    /// <param name="TransactionType">Enum "Transaction Type Enum".</param>
    /// <param name="AccountType">Enum "Gen. Journal Account Type".</param>
    /// <param name="AccountNo">Code[50].</param>
    /// <param name="TransactionDate">Date.</param>
    /// <param name="TransactionAmount">Decimal.</param>
    /// <param name="DimensionActivity">Code[40].</param>
    /// <param name="ExternalDocumentNo">Code[50].</param>
    /// <param name="TransactionDescription">Text.</param>
    /// <param name="LoanNumber">Code[50].</param>
    procedure CreateGnlJournalLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Enum "Transaction Type Enum"; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No." := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."System-Created Entry" := true;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    /// <summary>
    /// CreateGnlJournalLineBalanced.
    /// </summary>
    /// <param name="TemplateName">Text.</param>
    /// <param name="BatchName">Text.</param>
    /// <param name="DocumentNo">Code[30].</param>
    /// <param name="LineNo">Integer.</param>
    /// <param name="TransactionType">Enum "Transaction Type Enum".</param>
    /// <param name="AccountType">Enum "Gen. Journal Account Type".</param>
    /// <param name="AccountNo">Code[50].</param>
    /// <param name="TransactionDate">Date.</param>
    /// <param name="TransactionAmount">Decimal.</param>
    /// <param name="DimensionActivity">Code[40].</param>
    /// <param name="ExternalDocumentNo">Code[50].</param>
    /// <param name="TransactionDescription">Text.</param>
    /// <param name="LoanNumber">Code[50].</param>
    /// <param name="BalancingAccountType">Enum "Gen. Journal Account Type".</param>
    /// <param name="BalancingAccountNo">Code[40].</param>
    procedure CreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Enum "Transaction Type Enum"; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; BalancingAccountType: Enum "Gen. Journal Account Type"; BalancingAccountNo: Code[40])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."System-Created Entry" := true;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetUserBranch() branchCode: Code[20]
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            branchCode := UserSetup."Global Dimension 2 Code";
        end;
        exit(branchCode);
    end;




    procedure CreatePVLine(PVNumber: Code[20]; PostingDate: Date; PVLineCode: Code[40]; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[20]; Amount: Decimal; Remarks: Text[60]; ActivityCode: Code[10]; BranchCode: Code[10]; TransactionType: Enum "Transaction Type Enum"; LoanNo: Code[20]; Reference: Code[20])
    var
        PVLines: Record "Document Line";
    begin
        if Amount <> 0 then begin
            PVLines.Init;
            PVLines."Header No." := PVNumber;
            PVLines."Posting Date" := PostingDate;
            PVLines.Type := PVLineCode;//code
            PVLines."Account Type" := AccountType;
            PVLines."Account No." := AccountNo;

            PVLines."Transaction Type" := TransactionType;
            PVLines.Amount := Amount;
            PVLines.Validate(PVLines.Amount);
            PVLines.Description := Remarks;
            PVLines."Shortcut Dimension 1 Code" := ActivityCode;
            PVLines."Shortcut Dimension 2 Code" := BranchCode;
            PVLines."Loan No." := LoanNo;
            //PVLines.Reference := Reference;
            if PVLines.Amount <> 0 then
                PVLines.Insert;
            //PVLines.VALIDATE(PVLines."Account No.");
        end;
    end;


    procedure GetDepositAccounts(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record "Savings Accounts";
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Deposit Contribution");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetMicroDepositAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record "Savings Accounts";
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Micro Member Deposit");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;

    end;

    procedure GetShareCapitalAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record "Savings Accounts";
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Share Capital");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetMBankingOrdinaryAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record "Savings Accounts";
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
        MemberAccounts.SetFilter("Transactional Mobile No", '<>%1', '');
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetOrdinaryAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record "Savings Accounts";
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetFosaSharesAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record "Savings Accounts";
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"FOSA Shares");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetRegFeeAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record "Savings Accounts";
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Registration Fee");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetDividendAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record "Savings Accounts";
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Dividend Account");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetHousingAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record "Savings Accounts";
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::Housing);
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetHolidayAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record "Savings Accounts";
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Holiday Savings");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetFixedDepositAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record "Savings Accounts";
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Fixed Deposit");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetJuniorSavAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record "Savings Accounts";
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Junior Savings");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetSchFeeAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record "Savings Accounts";
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"School Fee");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetUnallocatedAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record "Savings Accounts";
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Unallocated Fund");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;



    procedure GetNonWithdrawableBalance(MNo: Code[200]) Bal: Decimal;
    var
        MemberAccounts: Record "Savings Accounts";
        PSetup: Record "Product Setup";
    begin
        Bal := 0;
        PSetup.Reset();
        PSetup.SetRange("Savings Type", PSetup."Savings Type"::"Non-Withdrawable");
        if PSetup.FindFirst() then begin
            repeat

                MemberAccounts.Reset();
                MemberAccounts.SetRange("Member No.", MNo);
                MemberAccounts.SetRange("Product Type", PSetup."Product ID");
                if MemberAccounts.FindFirst() then begin
                    MemberAccounts.CalcFields("Balance (LCY)");
                    Bal += MemberAccounts."Balance (LCY)";
                end;
            until PSetup.Next() = 0;
        end;
    end;

    procedure GetProductsToOffsetAccountBalance(MNo: Code[200]) Bal: Decimal;
    var
        MemberAccounts: Record "Savings Accounts";
        PSetup: Record "Product Setup";
        MemberActivities: Codeunit "Member Activities";
        Legacy: Codeunit Legacy;
    begin
        Bal := 0;
        PSetup.Reset();
        PSetup.SetRange("Can Offset Loan", true);
        if PSetup.FindFirst() then begin
            repeat

                MemberAccounts.Reset();
                MemberAccounts.SetRange("Member No.", MNo);
                MemberAccounts.SetRange("Product Type", PSetup."Product ID");
                if MemberAccounts.FindFirst() then begin
                    if MemberAccounts."Product Category" = MemberAccounts."Product Category"::"Deposit Contribution" then
                        Bal += (MemberActivities.GetAccountBalance(MemberAccounts."No.")) //- (MemberActivities.GetMemberCommittedDeposits(MemberAccounts."No.", true) + MemberActivities.GetSelfGuaranteeCommitment(MemberAccounts."No.", true))
                    else begin
                        MemberAccounts.CalcFields("Balance (LCY)");
                        Bal += MemberAccounts."Balance (LCY)";
                    end;
                end;
            until PSetup.Next() = 0;
        end;
    end;

    procedure GetTotalLoanPrincipalBalance(MNo: Code[200]; DateFilter: Text[20]) Bal: Decimal;
    var
        Loans: Record Loans;
        PSetup: Record "Product Setup";
    begin
        Bal := 0;

        Loans.Reset();
        Loans.SetRange("Member No.", MNo);
        if DateFilter <> '' then
            Loans.Setfilter("Date Filter", DateFilter);
        Loans.SetAutoCalcFields("Outstanding Principal");
        Loans.SetLoadFields("Outstanding Principal");
        if Loans.FindFirst() then begin
            repeat
                Bal += Loans."Outstanding Principal";
            until Loans.Next() = 0;
        end;
    end;


    procedure GetTotalLoanOutstandingBalance(MNo: Code[200]; DateFilter: Text[20]) Bal: Decimal;
    var
        Loans: Record Loans;
        PSetup: Record "Product Setup";
    begin
        Bal := 0;

        Loans.Reset();
        Loans.SetRange("Member No.", MNo);
        if DateFilter <> '' then
            Loans.Setfilter("Date Filter", DateFilter);
        Loans.SetAutoCalcFields("Outstanding Principal", "Outstanding Interest");
        Loans.SetLoadFields("Outstanding Interest", "Outstanding Principal");
        if Loans.FindFirst() then begin
            repeat
                Bal += Loans."Outstanding Principal" + Loans."Outstanding Interest";
            until Loans.Next() = 0;
        end;
    end;

    procedure GetTotalLoanInterestBalance(MNo: Code[200]; DateFilter: Text[20]) Bal: Decimal;
    var
        Loans: Record Loans;
        PSetup: Record "Product Setup";
    begin
        Bal := 0;

        Loans.Reset();
        Loans.SetRange("Member No.", MNo);
        if DateFilter <> '' then
            Loans.Setfilter("Date Filter", DateFilter);
        Loans.SetAutoCalcFields("Outstanding Interest");
        Loans.SetLoadFields("Outstanding Interest");
        if Loans.FindFirst() then begin
            repeat
                Bal += Loans."Outstanding Interest";
            until Loans.Next() = 0;
        end;
    end;


    procedure GetTotalBOSALoanPrincipalBalance(MNo: Code[200]) Bal: Decimal;
    var
        Loans: Record Loans;
        PSetup: Record "Product Setup";
    begin
        Bal := 0;

        Loans.Reset();
        Loans.SetRange("Member No.", MNo);
        Loans.SetFilter("Outstanding Principal", '>0');
        if Loans.FindFirst() then begin
            repeat
                PSetup.Get(Loans."Loan Product Type");

                if not PSetup."Appraise Security" then //exclude asset loans
                    if PSetup."Loan Source" = PSetup."Loan Source"::BOSA then begin

                        Loans.CalcFields("Outstanding Principal");
                        Bal += Loans."Outstanding Principal";

                    end;

            until Loans.Next() = 0;
        end;
    end;

    procedure GetTotalFOSALoanPrincipalBalance(MNo: Code[200]) Bal: Decimal;
    var
        Loans: Record Loans;
        PSetup: Record "Product Setup";
    begin
        Bal := 0;

        Loans.Reset();
        Loans.SetRange("Member No.", MNo);
        Loans.SetFilter("Outstanding Principal", '>0');
        if Loans.FindFirst() then begin
            repeat
                PSetup.Get(Loans."Loan Product Type");
                if PSetup."Loan Source" = PSetup."Loan Source"::FOSA then begin

                    Loans.CalcFields("Outstanding Principal");
                    Bal += Loans."Outstanding Principal";

                end;
            until Loans.Next() = 0;
        end;
    end;

    /// <summary>
    /// GetTotalBosaLoanInterestBalance.
    /// </summary>
    /// <param name="MNo">Code[200].</param>
    /// <returns>Return variable Bal of type Decimal.</returns>
    procedure GetTotalBosaLoanInterestBalance(MNo: Code[200]) Bal: Decimal;
    var
        Loans: Record Loans;
        PSetup: Record "Product Setup";
    begin
        Bal := 0;

        Loans.Reset();
        Loans.SetRange("Member No.", MNo);
        Loans.SetFilter("Outstanding Principal", '>0');
        if Loans.FindFirst() then begin
            repeat
                PSetup.Get(Loans."Loan Product Type");
                if PSetup."Loan Source" = PSetup."Loan Source"::BOSA then begin

                    Loans.CalcFields("Outstanding Interest");
                    Bal += Loans."Outstanding Interest";

                end;
            until Loans.Next() = 0;
        end;
    end;

    procedure GetTotalFosaLoanInterestBalance(MNo: Code[200]) Bal: Decimal;
    var
        Loans: Record Loans;
        PSetup: Record "Product Setup";
    begin
        Bal := 0;

        Loans.Reset();
        Loans.SetRange("Member No.", MNo);
        Loans.SetFilter("Outstanding Principal", '>0');
        if Loans.FindFirst() then begin
            repeat
                PSetup.Get(Loans."Loan Product Type");
                if PSetup."Loan Source" = PSetup."Loan Source"::FOSA then begin

                    Loans.CalcFields("Outstanding Interest");
                    Bal += Loans."Outstanding Interest";

                end;
            until Loans.Next() = 0;
        end;
    end;


    procedure GetLoansApprovedPerProduct(Product: Code[20]; SDate: date; EDate: date) Bal: Decimal
    var
        Loans: Record Loans;
    begin

        Bal := 0;
        Loans.Reset();
        Loans.SetRange("Loan Product Type", Product);
        Loans.SetFilter("Disbursement Date", '%1..%2', SDate, EDate);
        if Loans.FindFirst() then begin
            repeat
                Bal += Loans."Approved Amount";
            until Loans.Next() = 0;
        end;
    end;


    procedure GetTotalOutstandingBalancePerProduct(Product: Code[20]; AsAt: date) Bal: Decimal
    var
        Loans: Record Loans;
    begin

        Bal := 0;
        Loans.Reset();
        Loans.SetRange("Loan Product Type", Product);
        Loans.SetFilter("Date Filter", '..%1', Asat);
        Loans.SetFilter("Outstanding Principal", '>0');
        if Loans.FindFirst() then begin
            repeat
                Loans.CalcFields("Total Outstanding Balance");
                Bal += Loans."Total Outstanding Balance";
            until Loans.Next() = 0;
        end;
    end;

    procedure GetTotalOutstandingBalance(AsAt: date) Bal: Decimal
    var
        Loans: Record Loans;
    begin

        Bal := 0;
        Loans.Reset();
        Loans.SetFilter("Date Filter", '..%1', Asat);
        Loans.SetFilter("Outstanding Principal", '>0');
        Loans.SetLoadFields("Total Outstanding Balance");
        Loans.SetAutoCalcFields("Total Outstanding Balance");
        if Loans.FindFirst() then begin
            repeat
                Bal += Loans."Total Outstanding Balance";
            until Loans.Next() = 0;
        end;
    end;

    procedure GetShareCapitalAccountBookBalance(AsAt: Date): Decimal
    var
        SavingsAccounts: Record "Savings Accounts";
        Bal: Decimal;
    begin

        Bal := 0;
        SavingsAccounts.Reset();
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Share Capital");
        SavingsAccounts.SetFilter("Date Filter", '..%1', AsAt);
        SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
        if SavingsAccounts.FindSet() then begin
            repeat
                Bal += SavingsAccounts."Balance (LCY)";
            until SavingsAccounts.Next() = 0;
        end;
        exit(Bal);

    end;

    procedure GetShareDepositAccountBookBalance(AsAt: Date): Decimal
    var
        SavingsAccounts: Record "Savings Accounts";
        Bal: Decimal;
    begin

        Bal := 0;
        SavingsAccounts.Reset();
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Deposit Contribution");
        SavingsAccounts.SetFilter("Date Filter", '..%1', AsAt);
        SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
        if SavingsAccounts.Findset() then begin
            repeat
                Bal += SavingsAccounts."Balance (LCY)";
            until SavingsAccounts.Next() = 0;
        end;
        exit(Bal);

    end;



    procedure GetNoOfApplicationsPerProduct(Product: Code[20]; SDate: date; EDate: date) LCount: Integer
    var
        Loans: Record Loans;
    begin

        LCount := 0;
        Loans.Reset();
        Loans.SetRange("Loan Product Type", Product);
        Loans.SetFilter("Disbursement Date", '%1..%2', SDate, EDate);
        if Loans.FindFirst() then begin
            LCount := Loans.Count;
        end;
    end;


    procedure GetTotalPrincipalBalancePerProduct(Product: Code[20]; AsAt: date) Bal: Decimal
    var
        Loans: Record Loans;
    begin

        Bal := 0;
        Loans.Reset();
        Loans.SetRange("Loan Product Type", Product);
        Loans.SetFilter("Date Filter", '..%1', Asat);
        if Loans.FindFirst() then begin
            repeat
                Loans.CalcFields("Outstanding Principal");
                Bal += Loans."Outstanding Principal";
            until Loans.Next() = 0;
        end;
    end;

    procedure GetTotalInterestBalancePerProduct(Product: Code[20]; AsAt: date) Bal: Decimal
    var
        Loans: Record Loans;
    begin

        Bal := 0;
        Loans.Reset();
        Loans.SetRange("Loan Product Type", Product);
        Loans.SetFilter("Date Filter", '..%1', Asat);
        if Loans.FindFirst() then begin
            repeat
                Loans.CalcFields("Outstanding Interest");
                Bal += Loans."Outstanding Interest";
            until Loans.Next() = 0;
        end;
    end;




    procedure GetNonPerformingLoansPerProduct(Product: Code[20]; AsAt: date; Days: Integer; var DefAmt: Decimal; var PerformingBal: Decimal; var NonPerformingBal: Decimal) Bal: Decimal
    var
        Loans: Record Loans;
        SActivities: Codeunit "Sacco Activities";
        AmtDefaulted: Decimal;
        UserSetup: Record "User Setup";
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        MDef: Integer;
        GrarePriod: DateFormula;
    begin
        //UserSetup."CashRec Journal Batch"

        NonPerformingBal := 0;
        PerformingBal := 0;
        DefAmt := 0;
        Bal := 0;
        Loans.Reset();
        Loans.SetRange("Loan Product Type", Product);
        Loans.SetFilter("Date Filter", '..%1', AsAt);
        Loans.SetFilter("Outstanding Principal", '>0');
        Loans.SetAutoCalcFields("Outstanding Principal");
        if Loans.FindSet() then begin
            repeat
                Bal += Loans."Outstanding Principal";

                ExpectedAmt := 0;
                AmtPaid := 0;
                DefAmount := 0;
                DaysInArrear := 0;
                ArrearsDate := 0D;

                SActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GrarePriod);

                if DaysInArrear >= Days then begin
                    DefAmt += DefAmount;
                    NonPerformingBal += Loans."Outstanding Principal";
                end
                else begin

                    PerformingBal += Loans."Outstanding Principal";
                end;

            until Loans.Next() = 0;
        end;
    end;



    //procedure GetRandomCustomerData(Var FName: Text; Var SName: Text; Var IDNo: Code[20]);

    procedure GetRandomCustomerData(Var FName: Text; Var SName: Text; Var IDNo: Code[20]; Var Email: Text; var Phone: Text);
    var
        Gender: Text;
        Title: Text;
        Cell: Text;
        Username: Text;
        Password: Text;
        UUID: Text;
        Country: Text;
        City: Text;
        State: Text;
        Street: Text;
        Postcode: Text;
        Latitude: Text;
        Longitude: Text;
        DateOfBirth: Text;
        Age: Text;
        RegisteredDate: Text;
        RegisteredAge: Text;
        Picture: Text;
        Nationality: Text;
        Client: HttpClient;
        Response: HttpResponseMessage;
        ResponseJson: JsonObject;
        ResultsArray: JsonArray;
        ResultToken: JsonToken;
        UserObject: JsonObject;
        ResponseText: Text;
        MaxRetries: Integer;
        RetryCount: Integer;
        AllFieldsFound: Boolean;

    begin
        // Set maximum retry attempts to prevent infinite loops
        MaxRetries := 10;
        RetryCount := 0;
        AllFieldsFound := false;

        repeat
            RetryCount += 1;

            // Initialize variables for each attempt
            FName := '';
            SName := '';
            IDNo := '';
            Gender := '';
            Title := '';
            Email := '';
            Phone := '';
            Cell := '';
            Username := '';
            Password := '';
            UUID := '';
            Country := '';
            City := '';
            State := '';
            Street := '';
            Postcode := '';
            Latitude := '';
            Longitude := '';
            DateOfBirth := '';
            Age := '';
            RegisteredDate := '';
            RegisteredAge := '';
            Picture := '';
            Nationality := '';

            if Client.Get('https://randomuser.me/api/?nat=us', Response) then
                if Response.IsSuccessStatusCode() then begin
                    Response.Content().ReadAs(ResponseText);
                    ResponseJson.ReadFrom(ResponseText);

                    // Extract results array
                    if ResponseJson.Get('results', ResultToken) then begin
                        ResultsArray := ResultToken.AsArray();
                        if ResultsArray.Count > 0 then begin
                            ResultsArray.Get(0, ResultToken);
                            UserObject := ResultToken.AsObject();

                            // Personal Information
                            Gender := GetNestedJsonTextField(UserObject, '', 'gender');
                            Title := GetNestedJsonTextField(UserObject, 'name', 'title');
                            FName := GetNestedJsonTextField(UserObject, 'name', 'first');
                            SName := GetNestedJsonTextField(UserObject, 'name', 'last');
                            Email := GetNestedJsonTextField(UserObject, '', 'email');
                            Phone := GetNestedJsonTextField(UserObject, '', 'phone');
                            Cell := GetNestedJsonTextField(UserObject, '', 'cell');
                            Nationality := GetNestedJsonTextField(UserObject, '', 'nat');

                            // ID Information
                            IDNo := GetNestedJsonTextField(UserObject, 'id', 'value');

                            // Location Information
                            Street := GetNestedJsonTextField(UserObject, 'location', 'street') + ' ' + GetNestedJsonTextField(UserObject, 'location', 'name');
                            City := GetNestedJsonTextField(UserObject, 'location', 'city');
                            State := GetNestedJsonTextField(UserObject, 'location', 'state');
                            Country := GetNestedJsonTextField(UserObject, 'location', 'country');
                            Postcode := GetNestedJsonTextField(UserObject, 'location', 'postcode');
                            Latitude := GetNestedJsonTextFieldDeepNested(UserObject, 'location', 'coordinates', 'latitude');
                            Longitude := GetNestedJsonTextFieldDeepNested(UserObject, 'location', 'coordinates', 'longitude');

                            // Login Information
                            UUID := GetNestedJsonTextField(UserObject, 'login', 'uuid');
                            Username := GetNestedJsonTextField(UserObject, 'login', 'username');
                            Password := GetNestedJsonTextField(UserObject, 'login', 'password');

                            // Date of Birth
                            DateOfBirth := GetNestedJsonTextField(UserObject, 'dob', 'date');
                            Age := GetNestedJsonTextField(UserObject, 'dob', 'age');

                            // Registration Information
                            RegisteredDate := GetNestedJsonTextField(UserObject, 'registered', 'date');
                            RegisteredAge := GetNestedJsonTextField(UserObject, 'registered', 'age');

                            // Picture
                            Picture := GetNestedJsonTextField(UserObject, 'picture', 'large');

                            // Check if all required fields have valid values
                            AllFieldsFound := (FName <> '') and (SName <> '') and (IDNo <> '') and (Email <> '') and (Phone <> '');
                        end;
                    end;
                end;

            // If we don't have all fields and haven't reached max retries, wait briefly before retry
            if not AllFieldsFound and (RetryCount < MaxRetries) then
                Sleep(100); // Brief delay to avoid hammering the API

        until AllFieldsFound or (RetryCount >= MaxRetries);

        // If we still don't have all fields after max retries, generate fallback values
        if not AllFieldsFound then begin
            if FName = '' then FName := 'John';
            if SName = '' then SName := 'Doe';
            if IDNo = '' then IDNo := Format(Random(99999999));
            if Email = '' then Email := 'user' + Format(Random(9999)) + '@example.com';
            if Phone = '' then Phone := '+1-555-' + Format(Random(999)) + '-' + Format(Random(9999));
        end;
    end;



    procedure GetJsonTextField(o: JsonObject; Member: Text): Text;
    var
        Result: JsonToken;

    begin
        if O.get(Member, Result) then begin
            if Result.IsValue then begin
                if not Result.AsValue().IsNull then
                    exit(Result.AsValue().AsText());
            end;
        end;
        exit('');
    end;

    procedure GetNestedJsonTextField(o: JsonObject; ParentMember: Text; ChildMember: Text): Text;
    var
        ParentToken: JsonToken;
        ParentObject: JsonObject;
        ChildToken: JsonToken;

    begin
        if ParentMember = '' then begin
            if O.Get(ChildMember, ChildToken) then begin
                if ChildToken.IsValue then begin
                    if not ChildToken.AsValue().IsNull then
                        exit(ChildToken.AsValue().AsText());
                end;
            end;
        end else begin
            if O.Get(ParentMember, ParentToken) then begin
                if ParentToken.IsObject then begin
                    ParentObject := ParentToken.AsObject();
                    if ParentObject.Get(ChildMember, ChildToken) then begin
                        if ChildToken.IsValue then begin
                            if not ChildToken.AsValue().IsNull then
                                exit(ChildToken.AsValue().AsText());
                        end;
                    end;
                end;
            end;
        end;
        exit('');
    end;

    procedure GetNestedJsonTextFieldDeepNested(o: JsonObject; Level1: Text; Level2: Text; Level3: Text): Text;
    var
        Level1Token: JsonToken;
        Level1Object: JsonObject;
        Level2Token: JsonToken;
        Level2Object: JsonObject;
        Level3Token: JsonToken;

    begin
        if O.Get(Level1, Level1Token) then begin
            if Level1Token.IsObject then begin
                Level1Object := Level1Token.AsObject();
                if Level1Object.Get(Level2, Level2Token) then begin
                    if Level2Token.IsObject then begin
                        Level2Object := Level2Token.AsObject();
                        if Level2Object.Get(Level3, Level3Token) then begin
                            if Level3Token.IsValue then begin
                                if not Level3Token.AsValue().IsNull then
                                    exit(Level3Token.AsValue().AsText());
                            end;
                        end;
                    end;
                end;
            end;
        end;
        exit('');
    end;

    procedure FnGetLoanDisbursementTransactionNo(LoanNo: Code[50]; AsAt: Date): Integer
    var
        CustLedgerEntries: Record "Credit Ledger Entry";
    begin
        CustLedgerEntries.Reset();
        CustLedgerEntries.SetRange("Loan No.", LoanNo);
        CustLedgerEntries.SetFilter("Posting Date", '..%1', AsAt);
        CustLedgerEntries.SetRange("Transaction Type", CustLedgerEntries."Transaction Type"::"Loan Disbursement");
        if CustLedgerEntries.FindLast() then
            exit(CustLedgerEntries."Transaction No.");
        exit(0);
    end;

    procedure FnGetLoanDocumentNoAndPostingDate(TransNo: Integer; LoanNo: Code[50]; var PostingDate: Date; var DocumentNo: Code[50])
    var
        CustLedger: Record "Credit Ledger Entry";
    begin
        DocumentNo := '';
        PostingDate := 0D;
        CustLedger.Reset();
        CustLedger.SetRange("Loan No.", LoanNo);
        CustLedger.SetRange("Transaction No.", TransNo);
        CustLedger.SetRange(Reversed, false);
        if CustLedger.FindLast() then begin
            DocumentNo := CustLedger."Document No.";
            PostingDate := CustLedger."Posting Date";
        end;
    end;

    procedure FnGetLoanNetDisbursedToBank(TransNo: Integer; DocumentNo: Code[50]; PostingDate: Date): Decimal
    var
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        Total: Decimal;
    begin
        Total := 0;
        BankLedgerEntries.Reset();
        //BankLedgerEntries.SetRange("Transaction No.", TransNo);
        BankLedgerEntries.SetRange("Document No.", DocumentNo);
        BankLedgerEntries.SetFilter("Posting Date", '..%1', PostingDate);
        BankLedgerEntries.SetRange(Reversed, false);
        if BankLedgerEntries.FindSet() then
            repeat
                Total += BankLedgerEntries.Amount * -1;
            until BankLedgerEntries.Next() = 0;
        exit(Total);
    end;

    procedure FnGetOffsetCommissionByALoan(TransNo: Integer; DocumentNo: Code[50]; PostingDate: Date; LoanNo: Code[50]): Decimal
    var
        GeneralLedgerEntries: Record "G/L Entry";
        Total: Decimal;
    begin
        Total := 0;
        GeneralLedgerEntries.Reset();
        GeneralLedgerEntries.SetRange("Transaction No.", TransNo);
        GeneralLedgerEntries.SetRange("Document No.", DocumentNo);
        //GeneralLedgerEntries.SetRange("Posting Date", PostingDate);
        GeneralLedgerEntries.SetRange("G/L Account No.", '30303');
        //GeneralLedgerEntries.SetRange("External Document No.", LoanNo);
        GeneralLedgerEntries.SetRange(Reversed, false);
        if GeneralLedgerEntries.FindSet() then
            repeat
                Total += GeneralLedgerEntries.Amount * -1;
            until GeneralLedgerEntries.Next() = 0;
        exit(Total);
    end;

    procedure FnGetOffsetChargesByALoanExcludingOffsetCommision(TransNo: Integer; DocumentNo: Code[50]; PostingDate: Date; CustomerNo: Code[50]): Decimal
    var
        CustLedgerEntry: Record "Credit Ledger Entry";
        Total: Decimal;
    begin
        Total := 0;
        CustLedgerEntry.Reset();
        CustLedgerEntry.SetRange("Transaction No.", TransNo);
        CustLedgerEntry.SetRange("Document No.", DocumentNo);
        CustLedgerEntry.SetRange("Posting Date", PostingDate);
        CustLedgerEntry.SetRange("Member No.", CustomerNo);
        CustLedgerEntry.SetFilter(
            "Transaction Type",
            '%1|%2|%3',
            CustLedgerEntry."Transaction Type"::"Principal Repayment",
            CustLedgerEntry."Transaction Type"::"Interest Paid",
            CustLedgerEntry."Transaction Type"::"Insurance Paid");
        if CustLedgerEntry.FindSet() then
            repeat
                Total += CustLedgerEntry.Amount * -1;
            until CustLedgerEntry.Next() = 0;
        exit(Total);
    end;

    procedure FnGetTotalLoanDisbursementsDisbursedToMemberSoFar(LoanNo: Code[50]; AsAt: Date): Decimal
    var
        CustLedgerEntry: Record "Credit Ledger Entry";
        Total: Decimal;
    begin
        Total := 0;
        CustLedgerEntry.Reset();
        CustLedgerEntry.SetRange(Reversed, false);
        CustLedgerEntry.SetRange("Loan No.", LoanNo);
        CustLedgerEntry.SetFilter("Posting Date", '..%1', AsAt);
        CustLedgerEntry.SetFilter("Transaction Type", '%1', CustLedgerEntry."Transaction Type"::"Loan Disbursement");
        if CustLedgerEntry.FindSet() then
            repeat
                Total += CustLedgerEntry.Amount;
            until CustLedgerEntry.Next() = 0;
        exit(Total);
    end;
}
