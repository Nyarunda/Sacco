namespace UnitedWomen_Production.UnitedWomen_Production;
using Microsoft.Foundation.Company;
using Microsoft.Finance.GeneralLedger.Ledger;

report 50537 "FOSA Balance Summary"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Fosa Balances Summary.rdlc';

    dataset
    {
        dataitem("Product Factory"; "Product Setup")
        {
            DataItemTableView = WHERE("Product Class" = CONST(Savings),
                                      "Product Category" = const("UnAllocated Fund"));
            column(CI_Picture; CompanyInformation.Picture)
            {
            }
            column(CI_Name; CompanyInformation.Name)
            {
            }
            column(CI_Address; CompanyInformation.Address)
            {
            }
            column(ProductID; "Product Factory"."Product ID")
            {
            }
            column(ProductDescription; "Product Factory"."Description")
            {
            }
            column(CashInflowAmount; CashInflowAmount)
            {
            }
            column(CashOutFlowAmount; CashOutFlowAmount)
            {
            }
            column(CashWithdrawn; CashWithdrawn)
            {
            }
            column(CashDeposited; CashDeposited)
            {
            }
            column(ChequeDeposited; ChequeDeposited)
            {
            }
            column(ChequeWithdrawn; ChequeWithdrawn)
            {
            }
            column(LoanAmountIn; LoanAmountIn)
            {
            }
            column(LoanAmountOut; LoanAmountOut)
            {
            }
            column(AtmDeposits; AtmDeposits)
            {
            }
            column(AtmWithdrawals; AtmWithdrawals)
            {
            }
            column(From; From)
            {
            }
            column(dateTo; dateTo)
            {
            }
            column(AccountTransferAmountOut; AccountTransferAmountOut)
            {
            }
            column(AccountTransaferAmountIn; AccountTransaferAmountIn)
            {
            }
            column(MpesaDepositsAmount; MpesaDepositsAmount)
            {
            }
            column(MpesaWithdrawalAmount; MpesaWithdrawalAmount)
            {
            }
            column(CashInFlowOpeningBalance; CashInFlowOpeningBalance)
            {
            }
            column(CashOutFlowOpeningBalance; CashOutFlowOpeningBalance)
            {
            }
            column(TotalInOut; TotalInOut)
            {
            }
            column(OpeningBalance; OpeningBalance)
            {
            }
            column(AccountScheduleBalance; AccountScheduleBalance)
            {
            }
            column(TotalInOutTotals; TotalInOutTotals)
            {
            }
            column(AccountSchedulesOpeningBalance; AccountSchedulesOpeningBalance)
            {
            }
            column(SalaryIn; SalaryIn)
            {
            }
            column(SalaryOut; SalaryOut)
            {
            }
            column(CheckOffIn; CheckOffIn)
            {
            }
            column(CheckOffOut; CheckOffOut)
            {
            }
            column(MemberShipClosureIn; MemberShipClosureIn)
            {
            }
            column(MemberShipClosureOut; MemberShipClosureOut)
            {
            }
            column(TotalInFlows; TotalInFlows)
            {
            }
            column(TotalOutFlows; TotalOutFlows)
            {
            }
            column(BankersChequeOut; BankersChequeOut)
            {
            }
            column(RTGSOut; RTGSOut)
            {
            }
            column(LoanRepaymentOut; LoanRepaymentOut)
            {
            }
            column(ClosingBalanceAll; ClosingBalanceAll)
            {
            }
            column(STOOut; STOOut)
            {
            }
            column(FosaPenaltiesOut; FosaPenaltiesOut)
            {
            }
            column(LedgerFeeOut; LedgerFeeOut)
            {
            }
            column(AtmChargesOut; AtmChargesOut)
            {
            }
            column(JounalAmountIn; JounalAmountIn)
            {
            }
            column(JounalAmountOut; JounalAmountOut)
            {
            }
            column(AccountSchedulesClosingBalance; AccountSchedulesClosingBalance)
            {
            }

            trigger OnAfterGetRecord()
            begin
                InitializeVariablesAfterGetRecord;

                GetAccountSchedulesOpeningBalance;

                GetFosaSavingsOpeningBalAmtInOut;

                GetCashierTransactionsInOut;

                GetLoansInOut;

                GetAtmTransactionsInOut;

                GetAccountTransferInOut;

                GetMpesaTransactionsInOut;

                GetCheckOffInOut;

                GetSalaryInOut;

                GetClosureAmountInOut;

                GetRTGSAmountInOut;

                GetSTOAmountOut;

                GetLedgerFeesOut;

                GetFOSAPenaltiesAmountOut;

                GetAtmChargesInOut;

                GetJournalsAmountInOut;

                TotalInFlows := CashDeposited + ChequeDeposited + LoanAmountIn + AtmDeposits +
                AccountTransaferAmountIn + MpesaDepositsAmount + SalaryIn + CheckOffIn
                + CashInflowAmount + MemberShipClosureIn + JounalAmountIn;

                TotalOutFlows := CashWithdrawn + ChequeWithdrawn + LoanAmountOut + AtmWithdrawals +
                AccountTransferAmountOut + MpesaWithdrawalAmount + SalaryOut + MemberShipClosureOut +
                CashOutFlowAmount + BankersChequeOut + RTGSOut + LoanRepaymentOut + STOOut +
                LedgerFeeOut + FosaPenaltiesOut + AtmChargesOut + JounalAmountOut;

                ClosingBalanceAll := (AccountSchedulesOpeningBalance + TotalInFlows) - TotalOutFlows;


            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(From; From)
                {
                    ApplicationArea = All;
                    Caption = 'From';
                }
                field(dateTo; dateTo)
                {
                    ApplicationArea = All;
                    Caption = 'Date To';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin

        IF ((dateTo = 0D) OR (From = 0D)) THEN ERROR(Text000);
        IF dateTo < From THEN ERROR('The ''Date To'' must be greater than or equal to ''From''.');
        InitializeVariablesPreReport;
    end;

    var
        AccountSchedulesOpeningBalance: Decimal;
        OpeningBalanceAll: Decimal;
        ClosingBalanceAll: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        ProductOpeningBalance: Decimal;
        dateTo: Date;
        CashInflowAmount: Decimal;
        CashOutFlowAmount: Decimal;
        CashInFlowOpeningBalance: Decimal;
        CashOutFlowOpeningBalance: Decimal;
        TotalInOut: Decimal;
        TotalInOutTotals: Decimal;
        OpeningBalance: Decimal;
        ClosingBalance: Decimal;
        CompanyInformation: Record "Company Information";
        CashierTransactions: Record "Teller Transaction";
        CashWithdrawn: Decimal;
        CashDeposited: Decimal;
        From: Date;
        Text000: Label 'Kindly specify both dates';
        ChequeDeposited: Decimal;
        ChequeWithdrawn: Decimal;
        LoanDisbursementHeader: Record "Loan Disbursement Header";
        LoanAmountIn: Decimal;
        LoanAmountOut: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        ATMTransactions: Record "ATM Transactions";
        AtmWithdrawals: Decimal;
        AtmDeposits: Decimal;
        AccountTransferHeader: Record "Account Transfers";
        AccountTransferSource: Record "Source Account Transfer";
        AccountTransferDestination: Record "Destination Account Transfers";
        AccountTransferAmountOut: Decimal;
        AccountTransaferAmountIn: Decimal;
        MPESATransactions: Record "Sky Transactions.";
        MpesaDepositsAmount: Decimal;
        MpesaWithdrawalAmount: Decimal;
        LoanRepaymentOut: Decimal;
        AccountScheduleBalance: Decimal;
        AccountsScheduleDifference: Decimal;
        SalaryHeader: Record "Salary Header";
        Loans: Record "Loans";
        SalaryIn: Decimal;
        SalaryOut: Decimal;
        SalaryLines: Record "Salary Lines";
        CheckoffHeader: Record "Monthly Checkoff Header";
        CheckOffIn: Decimal;
        CheckOffOut: Decimal;
        CheckoffLines: Record "Monthly Checkoff Lines";
        Membershipclosure: Record "Member Exit";
        MemberShipClosureIn: Decimal;
        MemberShipClosureOut: Decimal;
        TotalInFlows: Decimal;
        TotalOutFlows: Decimal;
        BankersChequeOut: Decimal;
        EFTTransferHeader: Record "EFT Header";
        RTGSIn: Decimal;
        RTGSOut: Decimal;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        StandingOrderHeader: Record "Standing Order Header";
        STOIn: Decimal;
        STOOut: Decimal;
        FosaPenaltiesOut: Decimal;
        LedgerFeeOut: Decimal;
        AtmChargesIn: Decimal;
        AtmChargesOut: Decimal;
        ATMApplications: Record "ATM Applications";
        GLEntry: Record "G/L Entry";
        JounalAmountIn: Decimal;
        JounalAmountOut: Decimal;
        AccountSchedulesClosingBalance: Decimal;

    local procedure InitializeVariablesPreReport()
    begin
        OpeningBalanceAll := 0;
        ClosingBalanceAll := 0;
        ProductOpeningBalance := 0;
        CashWithdrawn := 0;
        CashDeposited := 0;
        AtmWithdrawals := 0;
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
        AccountTransaferAmountIn := 0;
        AccountTransferAmountOut := 0;
        MpesaDepositsAmount := 0;
        MpesaWithdrawalAmount := 0;
        LoanRepaymentOut := 0;
        AccountScheduleBalance := 0;
        TotalInOutTotals := 0;
        AccountSchedulesOpeningBalance := 0;
        AccountSchedulesClosingBalance := 0;
        SalaryIn := 0;
        SalaryOut := 0;
        CheckOffIn := 0;
        CheckOffOut := 0;
        TotalInFlows := 0;
        TotalOutFlows := 0;
        RTGSOut := 0;
        STOOut := 0;
        LedgerFeeOut := 0;
        FosaPenaltiesOut := 0;
        AtmChargesIn := 0;
        AtmChargesOut := 0;
        JounalAmountIn := 0;
        JounalAmountOut := 0;
    end;

    local procedure InitializeVariablesAfterGetRecord()
    begin
        CashInflowAmount := 0;
        CashOutFlowAmount := 0;
        LoanAmountIn := 0;
        LoanAmountOut := 0;
        CashInFlowOpeningBalance := 0;
        CashOutFlowOpeningBalance := 0;
        TotalInOut := 0;
        OpeningBalance := 0;
    end;

    local procedure GetFosaSavingsOpeningBalAmtInOut()
    begin
        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE(SavingsAccounts."Product Type", "Product Factory"."Product ID");
        SavingsAccounts.SETFILTER("Date Filter", '..%1', (From - 1));
        SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
        SavingsAccounts.SetLoadFields("Balance (LCY)");
        IF SavingsAccounts.FindSet() THEN
            REPEAT
                OpeningBalance += SavingsAccounts."Balance (LCY)";
            UNTIL SavingsAccounts.NEXT = 0;

        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE(SavingsAccounts."Product Type", "Product Factory"."Product ID");
        SavingsAccounts.SETFILTER("Date Filter", '..%1', dateTo);
        SavingsAccounts.SetAutoCalcFields("Debit Amount", "Credit Amount");
        SavingsAccounts.SetLoadFields("Debit Amount", "Credit Amount");
        IF SavingsAccounts.FindSet() THEN
            REPEAT
                CashInFlowOpeningBalance += SavingsAccounts."Credit Amount";
                CashOutFlowOpeningBalance += SavingsAccounts."Debit Amount";
            UNTIL SavingsAccounts.NEXT = 0;

        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE(SavingsAccounts."Product Type", "Product Factory"."Product ID");
        SavingsAccounts.SETFILTER("Date Filter", '%1..%2', From, dateTo);
        SavingsAccounts.SetAutoCalcFields("Debit Amount", "Credit Amount");
        SavingsAccounts.SetLoadFields("Debit Amount", "Credit Amount");
        IF SavingsAccounts.FindSet() THEN
            REPEAT
                CashInflowAmount += SavingsAccounts."Credit Amount";
                CashOutFlowAmount += SavingsAccounts."Debit Amount";
            UNTIL SavingsAccounts.NEXT = 0;

        TotalInOut := (OpeningBalance + CashInflowAmount) - CashOutFlowAmount;
        TotalInOutTotals += TotalInOut;
    end;

    local procedure GetAccountSchedulesOpeningBalance()
    begin
        SavingsAccounts.RESET;
        SavingsAccounts.SETFILTER("Date Filter", '..%1', (From - 1));
        SavingsAccounts.SETFILTER(SavingsAccounts."Product Category", '%1|%2|%3',
        SavingsAccounts."Product Category"::" ", SavingsAccounts."Product Category"::"Fixed Deposit", SavingsAccounts."Product Category"::"Junior Savings");
        IF SavingsAccounts.FINDFIRST THEN
            REPEAT
                SavingsAccounts.CALCFIELDS("Balance (LCY)");
                AccountSchedulesOpeningBalance += SavingsAccounts."Balance (LCY)";
            UNTIL SavingsAccounts.NEXT = 0;


        SavingsAccounts.RESET;
        SavingsAccounts.SETFILTER("Date Filter", '..%1', dateTo);
        SavingsAccounts.SETFILTER(SavingsAccounts."Product Category", '%1|%2|%3',
        SavingsAccounts."Product Category"::" ", SavingsAccounts."Product Category"::"Fixed Deposit", SavingsAccounts."Product Category"::"Junior Savings");
        IF SavingsAccounts.FINDFIRST THEN
            REPEAT
                SavingsAccounts.CALCFIELDS("Balance (LCY)");
                AccountSchedulesClosingBalance += SavingsAccounts."Balance (LCY)";
            UNTIL SavingsAccounts.NEXT = 0;
    end;

    local procedure GetLoansInOut()
    begin
        Loans.RESET;
        Loans.SETRANGE(Posted, TRUE);
        Loans.SETRANGE(Loans.Status, Loans.Status::Approved);
        Loans.SETRANGE("Disbursement Date", From, dateTo);
        IF Loans.FINDFIRST THEN
            REPEAT
                SavingsLedgerEntry.RESET;
                SavingsLedgerEntry.SETRANGE("Document No.", Loans."Loan No.");
                SavingsLedgerEntry.SetRange(Reversed, false);
                IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
                    SavingsLedgerEntry.CALCSUMS("Credit Amount (LCY)");
                    SavingsLedgerEntry.CALCSUMS("Debit Amount (LCY)");
                    LoanAmountIn += SavingsLedgerEntry."Credit Amount (LCY)";
                    LoanAmountOut += SavingsLedgerEntry."Debit Amount (LCY)";
                END;
            UNTIL Loans.NEXT = 0;

        // short term loans
        /* Loans.RESET;
        Loans.SETRANGE(Posted, TRUE);
        Loans.SetRange("Mobile Loan", true);
        Loans.SETRANGE("Disbursement Date", From, dateTo);
        IF Loans.FINDFIRST THEN
            REPEAT
                SavingsLedgerEntry.RESET;
                SavingsLedgerEntry.SETRANGE("Document No.", Loans."Loan No.");
                IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
                    SavingsLedgerEntry.CALCSUMS("Credit Amount (LCY)");
                    SavingsLedgerEntry.CALCSUMS("Debit Amount (LCY)");
                    LoanAmountIn += SavingsLedgerEntry."Credit Amount (LCY)";
                    LoanAmountOut += SavingsLedgerEntry."Debit Amount (LCY)";
                END;
            UNTIL Loans.NEXT = 0; */
    end;

    local procedure GetAtmTransactionsInOut()
    begin
        // Use CALCSUMS to compute totals for positive and negative ATM amounts separately
        ATMTransactions.RESET;
        ATMTransactions.SETRANGE("Posting Date", From, dateTo);
        ATMTransactions.SETRANGE(Posted, TRUE);
        ATMTransactions.SETFILTER(Amount, '>%1', 0);
        ATMTransactions.SETRANGE(ATMTransactions.Source, ATMTransactions.Source::ATM);
        IF ATMTransactions.FINDFIRST THEN BEGIN
            ATMTransactions.CALCSUMS(Amount);
            AtmWithdrawals := ATMTransactions.Amount;
        END else
            AtmWithdrawals := 0;

        ATMTransactions.RESET;
        ATMTransactions.SETRANGE("Posting Date", From, dateTo);
        ATMTransactions.SETRANGE(Posted, TRUE);
        ATMTransactions.SETRANGE(Reversed, FALSE);
        ATMTransactions.SETFILTER(Amount, '<%1', 0);
        ATMTransactions.SETRANGE(ATMTransactions.Source, ATMTransactions.Source::ATM);
        IF ATMTransactions.FINDFIRST THEN BEGIN
            ATMTransactions.CALCSUMS(Amount);
            AtmDeposits := ATMTransactions.Amount * -1;
        END else
            AtmDeposits := 0;

    end;

    local procedure GetCashierTransactionsInOut()
    begin
        CashierTransactions.RESET;
        CashierTransactions.SETRANGE(CashierTransactions.Posted, TRUE);
        CashierTransactions.SETRANGE("Transaction Date", From, dateTo);
        IF CashierTransactions.FINDFIRST THEN
            REPEAT
                CASE CashierTransactions.Type OF
                    CashierTransactions.Type::"Cash Withdrawal":
                        BEGIN
                            SavingsLedgerEntry.RESET;
                            SavingsLedgerEntry.SETRANGE("Document No.", CashierTransactions."Transaction No.");
                            IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
                                SavingsLedgerEntry.CALCSUMS("Debit Amount (LCY)");
                                CashWithdrawn += SavingsLedgerEntry."Debit Amount (LCY)";
                            END;
                        END;
                    //CashWithdrawn += CashierTransactions.Amount;
                    CashierTransactions.Type::"Cash Deposit":
                        BEGIN
                            SavingsLedgerEntry.RESET;
                            SavingsLedgerEntry.SETRANGE("Document No.", CashierTransactions."Transaction No.");
                            IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
                                SavingsLedgerEntry.CALCSUMS("Credit Amount (LCY)");
                                CashDeposited += SavingsLedgerEntry."Credit Amount (LCY)";
                            END;
                        END;
                    CashierTransactions.Type::"Cheque Deposit":
                        BEGIN
                            SavingsLedgerEntry.RESET;
                            SavingsLedgerEntry.SETRANGE("Document No.", CashierTransactions."Transaction No.");
                            IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
                                SavingsLedgerEntry.CALCSUMS("Credit Amount (LCY)");
                                ChequeDeposited += SavingsLedgerEntry."Credit Amount (LCY)";
                            END;
                        END;
                    CashierTransactions.Type::"Cheque Withdrawal":
                        BEGIN
                            SavingsLedgerEntry.RESET;
                            SavingsLedgerEntry.SETRANGE("Document No.", CashierTransactions."Transaction No.");
                            IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
                                SavingsLedgerEntry.CALCSUMS("Debit Amount (LCY)");
                                ChequeWithdrawn += SavingsLedgerEntry."Debit Amount (LCY)";
                            END;
                        END;
                    CashierTransactions.Type::"Bankers Cheque":
                        BEGIN
                            SavingsLedgerEntry.RESET;
                            SavingsLedgerEntry.SETRANGE("Document No.", CashierTransactions."Transaction No.");
                            IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
                                SavingsLedgerEntry.CALCSUMS("Debit Amount (LCY)");
                                BankersChequeOut += SavingsLedgerEntry."Debit Amount (LCY)";
                            END;
                        END;
                END
            UNTIL CashierTransactions.NEXT = 0;
    end;

    local procedure GetCheckOffInOut()
    begin
        CheckoffHeader.RESET;
        CheckoffHeader.SETRANGE(CheckoffHeader.Posted, TRUE);
        CheckoffHeader.SETRANGE(CheckoffHeader.Status, CheckoffHeader.Status::Approved);
        CheckoffHeader.SETRANGE(CheckoffHeader."Posting Date", From, dateTo);
        IF CheckoffHeader.FINDFIRST THEN
            REPEAT
                CheckoffLines.RESET;
                CheckoffLines.SETRANGE(CheckoffLines."Checkoff Header", CheckoffHeader."No.");
                IF CheckoffLines.FINDFIRST THEN
                    REPEAT
                        IF SavingsAccounts.GET(CheckoffLines."Account No.") THEN BEGIN
                            IF SavingsAccounts."Product Category"
                              IN [SavingsAccounts."Product Category"::" ", SavingsAccounts."Product Category"::"Fixed Deposit", SavingsAccounts."Product Category"::"Junior Savings"]
                              THEN BEGIN
                                CheckOffIn += CheckoffLines.Amount;
                            END;
                        END;

                    UNTIL CheckoffLines.NEXT = 0;

            //        CreditLedgerEntry.RESET;
            //        CreditLedgerEntry.SETRANGE("Document No.",CheckoffHeader."Document No.");
            //        IF CreditLedgerEntry.FINDFIRST THEN
            //           BEGIN
            //             CreditLedgerEntry.CALCSUMS("Credit Amount (LCY)");
            //             CheckOffOut += CreditLedgerEntry."Credit Amount (LCY)";
            //           END
            UNTIL CheckoffHeader.NEXT = 0;
    end;

    local procedure GetSalaryInOut()
    begin
        SalaryHeader.RESET;
        SalaryHeader.SETRANGE(SalaryHeader.Posted, TRUE);
        SalaryHeader.SETRANGE(SalaryHeader.Status, SalaryHeader.Status::Approved);
        SalaryHeader.SETRANGE(SalaryHeader."Posting date", From, dateTo);
        IF SalaryHeader.FINDFIRST THEN
            REPEAT
                SavingsLedgerEntry.RESET;
                SavingsLedgerEntry.SETRANGE(SavingsLedgerEntry."Document No.", SalaryHeader.No);
                IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
                    SavingsLedgerEntry.CALCSUMS("Credit Amount (LCY)");
                    SavingsLedgerEntry.CALCSUMS("Debit Amount (LCY)");
                    SalaryIn += SavingsLedgerEntry."Credit Amount (LCY)";
                    SalaryOut += SavingsLedgerEntry."Debit Amount (LCY)";
                END;

            UNTIL SalaryHeader.NEXT = 0;
    end;

    local procedure GetAccountTransferInOut()
    begin
        AccountTransferHeader.RESET;
        AccountTransferHeader.SETRANGE(AccountTransferHeader.Posted, TRUE);
        AccountTransferHeader.SETRANGE(AccountTransferHeader."Transaction Date", From, dateTo);
        IF AccountTransferHeader.FINDFIRST THEN
            REPEAT

                AccountTransferSource.RESET;
                AccountTransferSource.SETRANGE(AccountTransferSource."No.", AccountTransferHeader.No);
                AccountTransferSource.SETRANGE(AccountTransferSource."Source Account Type", AccountTransferSource."Source Account Type"::Savings);
                IF AccountTransferSource.FINDFIRST THEN
                    REPEAT
                        IF SavingsAccounts.GET(AccountTransferSource."Source Account No.") THEN BEGIN
                            IF SavingsAccounts."Product Category" IN [
                                    SavingsAccounts."Product Category"::" ",
                                    SavingsAccounts."Product Category"::"Junior Savings",
                                    SavingsAccounts."Product Category"::"Fixed Deposit",
                                    SavingsAccounts."Product Category"::"Unallocated Fund"
                                  ] THEN
                                AccountTransferAmountOut += AccountTransferSource."Source Amount";
                        END;
                    UNTIL AccountTransferSource.NEXT = 0;

                AccountTransferDestination.RESET;
                AccountTransferDestination.SETRANGE(AccountTransferDestination."No.", AccountTransferHeader.No);
                AccountTransferDestination.SETRANGE(AccountTransferDestination."Destination Account Type", AccountTransferDestination."Destination Account Type"::Savings);
                IF AccountTransferDestination.FINDFIRST THEN
                    REPEAT
                        IF SavingsAccounts.GET(AccountTransferDestination."Destination Account No.") THEN BEGIN
                            IF SavingsAccounts."Product Category" IN [
                                    SavingsAccounts."Product Category"::" ",
                                    SavingsAccounts."Product Category"::"Junior Savings",
                                    SavingsAccounts."Product Category"::"Fixed Deposit",
                                    SavingsAccounts."Product Category"::"Unallocated Fund"
                                  ] THEN
                                AccountTransaferAmountIn += AccountTransferDestination."Destination Amount";
                        END;
                    UNTIL AccountTransferDestination.NEXT = 0;

            UNTIL AccountTransferHeader.NEXT = 0;
    end;

    local procedure GetMpesaTransactionsInOut()
    begin
        MPESATransactions.RESET;
        MPESATransactions.SETRANGE(MPESATransactions.Posted, TRUE);
        MPESATransactions.SETRANGE(MPESATransactions."Transaction Date", From, dateTo);
        MPESATransactions.SETFILTER(MPESATransactions."Transaction Type", '=%1|%2|%3', MPESATransactions."Transaction Type"::"Mpesa Deposit", MPESATransactions."Transaction Type"::"Mpesa Withdrawal", MPESATransactions."Transaction Type"::"Loan Repayment");
        IF MPESATransactions.FINDFIRST THEN
            REPEAT
                IF SavingsAccounts.GET(MPESATransactions."Member Account") THEN
                    IF SavingsAccounts."Product Category" IN [
                       SavingsAccounts."Product Category"::" ",
                       SavingsAccounts."Product Category"::"Junior Savings",
                       SavingsAccounts."Product Category"::"Fixed Deposit",
                       SavingsAccounts."Product Category"::"Unallocated Fund"
                    ] THEN BEGIN
                        IF MPESATransactions."Transaction Type" = MPESATransactions."Transaction Type"::"Mpesa Deposit" THEN
                            MpesaDepositsAmount += (MPESATransactions.Amount * -1);
                        IF MPESATransactions."Transaction Type" = MPESATransactions."Transaction Type"::"Mpesa Withdrawal" THEN
                            MpesaWithdrawalAmount += MPESATransactions.Amount;
                        IF MPESATransactions."Transaction Type" = MPESATransactions."Transaction Type"::"Loan Repayment" THEN
                            LoanRepaymentOut += MPESATransactions.Amount;
                    END;

            UNTIL MPESATransactions.NEXT = 0;
    end;

    local procedure GetClosureAmountInOut()
    var
        SavLed: Record "Savings Ledger Entry";
    begin
        Membershipclosure.RESET;
        Membershipclosure.SETRANGE("Closing Date", From, dateTo);
        Membershipclosure.SETRANGE(Posted, TRUE);
        IF Membershipclosure.FINDFIRST THEN
            REPEAT
                SavingsLedgerEntry.RESET;
                SavingsLedgerEntry.SETRANGE(SavingsLedgerEntry."Document No.", Membershipclosure."No.");
                SavingsLedgerEntry.SETFILTER(SavingsLedgerEntry."Credit Amount (LCY)", '<>%1', 0);
                IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
                    SavingsLedgerEntry.CALCSUMS("Credit Amount (LCY)");
                    MemberShipClosureIn += SavingsLedgerEntry."Credit Amount (LCY)";
                    SavLed.RESET;
                    SavLed.SETRANGE(SavLed."Member No.", SavingsLedgerEntry."Member No.");
                    SavLed.SETRANGE(SavLed."Document No.", SavingsLedgerEntry."Document No.");
                    SavLed.SETFILTER(SavLed."Debit Amount (LCY)", '<>%1', 0);
                    IF SavLed.FINDFIRST THEN BEGIN
                        SavLed.CALCSUMS("Debit Amount (LCY)");
                        MemberShipClosureOut += SavLed."Debit Amount (LCY)";
                    END;
                END;
            UNTIL Membershipclosure.NEXT = 0;
    end;

    local procedure GetRTGSAmountInOut()
    begin
        EFTTransferHeader.RESET;
        EFTTransferHeader.SETRANGE(EFTTransferHeader.Status, EFTTransferHeader.Status::Transferred);
        EFTTransferHeader.SETRANGE("Date Transferred", From, dateTo);
        IF EFTTransferHeader.FINDFIRST THEN
            REPEAT
                SavingsLedgerEntry.RESET;
                SavingsLedgerEntry.SETRANGE("Document No.", EFTTransferHeader.Code);
                IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
                    SavingsLedgerEntry.CALCSUMS("Debit Amount (LCY)");
                    RTGSOut += SavingsLedgerEntry."Debit Amount (LCY)";
                END;
            UNTIL EFTTransferHeader.NEXT = 0;
    end;

    local procedure GetSTOAmountOut()
    begin
        StandingOrderHeader.RESET;
        StandingOrderHeader.SETFILTER(StandingOrderHeader.Status, '<>%1|<>%2', StandingOrderHeader.Status::Open, StandingOrderHeader.Status::Pending);
        IF StandingOrderHeader.FINDFIRST THEN
            REPEAT
                SavingsLedgerEntry.RESET;
                SavingsLedgerEntry.SETRANGE(SavingsLedgerEntry."Posting Date", From, dateTo);
                SavingsLedgerEntry.SETRANGE("Document No.", StandingOrderHeader.Code);
                IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
                    SavingsLedgerEntry.CALCSUMS("Debit Amount (LCY)");
                    STOOut += SavingsLedgerEntry."Debit Amount (LCY)";
                END;
            UNTIL StandingOrderHeader.NEXT = 0;
    end;

    local procedure GetFOSAPenaltiesAmountOut()
    begin
        SavingsLedgerEntry.RESET;
        SavingsLedgerEntry.SETRANGE("Document No.", 'FOSA Penalty');
        SavingsLedgerEntry.SETRANGE("Posting Date", From, dateTo);
        IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
            SavingsLedgerEntry.CALCSUMS("Debit Amount (LCY)");
            FosaPenaltiesOut += SavingsLedgerEntry."Debit Amount (LCY)";
        END;
    end;

    local procedure GetLedgerFeesOut()
    begin
        SavingsLedgerEntry.RESET;
        SavingsLedgerEntry.SETFILTER("Document No.", '%1|%2', 'LEDGERFEE', 'LedgerfeeExciceduty');
        SavingsLedgerEntry.SETRANGE("Posting Date", From, dateTo);
        IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
            SavingsLedgerEntry.CALCSUMS("Debit Amount (LCY)");
            LedgerFeeOut += SavingsLedgerEntry."Debit Amount (LCY)";
        END;
    end;

    local procedure GetAtmChargesInOut()
    begin
        ATMApplications.RESET;
        ATMApplications.SETRANGE(ATMApplications.Status, ATMApplications.Status::Approved);
        ATMApplications.SETRANGE(ATMApplications."ATM Charged Date", From, dateTo);
        IF ATMApplications.FINDFIRST THEN
            REPEAT
                SavingsLedgerEntry.RESET;
                SavingsLedgerEntry.SETRANGE("Document No.", ATMApplications."No.");
                IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
                    SavingsLedgerEntry.CALCSUMS("Debit Amount (LCY)");
                    AtmChargesOut += SavingsLedgerEntry."Debit Amount (LCY)"
                END;
            UNTIL ATMApplications.NEXT = 0;
    end;

    local procedure GetJournalsAmountInOut()
    begin
        SavingsLedgerEntry.RESET;
        SavingsLedgerEntry.SETRANGE("Source Code", 'GENJNL');
        SavingsLedgerEntry.SETRANGE("Posting Date", From, dateTo);
        IF SavingsLedgerEntry.FINDFIRST THEN
            REPEAT
                IF SavingsAccounts.GET(SavingsLedgerEntry."Member No.") THEN BEGIN
                    IF SavingsAccounts."Product Category" IN
                      [SavingsAccounts."Product Category"::" ",
                      SavingsAccounts."Product Category"::"Fixed Deposit", SavingsAccounts."Product Category"::"Junior Savings"] THEN BEGIN
                        JounalAmountIn += SavingsLedgerEntry."Credit Amount (LCY)";
                        JounalAmountOut += SavingsLedgerEntry."Debit Amount (LCY)";
                    END;
                END;
            UNTIL SavingsLedgerEntry.NEXT = 0;
        /*GLEntry.RESET;
        GLEntry.SETRANGE(GLEntry."Source Code",'GENJNL');
        GLEntry.SETRANGE(GLEntry."Posting Date",From,dateTo);
        IF GLEntry.FINDFIRST THEN
           REPEAT
        
           UNTIL GLEntry.NEXT = 0;*/

    end;
}
