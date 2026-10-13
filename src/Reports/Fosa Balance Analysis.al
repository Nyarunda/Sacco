report 50041 "Fosa Balance Analysis"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Fosa Balance Analysis.rdlc';

    dataset
    {
        dataitem("Product Factory"; "Product Setup")
        {
            DataItemTableView = WHERE("Product Class" = CONST(Savings),
                                      "Product Category" = FILTER(' ' | "Fixed Deposit" | "Junior Savings" | "Unallocated Fund" | "Ordinary Savings"));
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
            column(DifferenceBetweenScheduleAndTotals; TotalInOutTotals - AccountScheduleBalance)
            {
            }
            column(TotalOfOpeningBal; TotalOfOpeningBal)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CashInflowAmount := 0;
                CashOutFlowAmount := 0;
                LoanAmountIn := 0;
                LoanAmountOut := 0;
                CashInFlowOpeningBalance := 0;
                CashOutFlowOpeningBalance := 0;
                TotalInOut := 0;
                OpeningBalance := 0;


                SavingsAccounts.RESET;
                SavingsAccounts.SETRANGE(SavingsAccounts."Product Type", "Product Factory"."Product ID");
                SavingsAccounts.SETFILTER("Date Filter", '..%1', (From - 1));
                IF SavingsAccounts.FINDFIRST THEN
                    REPEAT

                        SavingsAccounts.CALCFIELDS("Balance (LCY)");
                        OpeningBalance += SavingsAccounts."Balance (LCY)";

                    UNTIL SavingsAccounts.NEXT = 0;

                SavingsAccounts.RESET;
                SavingsAccounts.SETRANGE(SavingsAccounts."Product Type", "Product Factory"."Product ID");
                SavingsAccounts.SETFILTER("Date Filter", '..%1', dateTo);
                IF SavingsAccounts.FINDFIRST THEN
                    REPEAT
                        SavingsAccounts.CALCFIELDS("Credit Amount");
                        SavingsAccounts.CALCFIELDS("Debit Amount");
                        CashInFlowOpeningBalance += SavingsAccounts."Credit Amount";
                        CashOutFlowOpeningBalance += SavingsAccounts."Debit Amount";
                    UNTIL SavingsAccounts.NEXT = 0;

                SavingsAccounts.RESET;
                SavingsAccounts.SETRANGE(SavingsAccounts."Product Type", "Product Factory"."Product ID");
                SavingsAccounts.SETFILTER("Date Filter", '%1..%2', From, dateTo);
                IF SavingsAccounts.FINDFIRST THEN
                    REPEAT
                        SavingsAccounts.CALCFIELDS("Credit Amount");
                        SavingsAccounts.CALCFIELDS("Debit Amount");
                        CashInflowAmount += SavingsAccounts."Credit Amount";
                        CashOutFlowAmount += SavingsAccounts."Debit Amount";
                    UNTIL SavingsAccounts.NEXT = 0;

                TotalInOut := (OpeningBalance + CashInflowAmount) - CashOutFlowAmount;
                TotalOfOpeningBal += TotalInOut;
                TotalInOutTotals += TotalInOut;

                SavingsAccounts.RESET;
                SavingsAccounts.SETFILTER("Date Filter", '..%1', dateTo);
                SavingsAccounts.SETFILTER(SavingsAccounts."Product Category", '%1|%2|%3',
                SavingsAccounts."Product Category"::" ", SavingsAccounts."Product Category"::"Fixed Deposit", SavingsAccounts."Product Category"::"Junior Savings");
                IF SavingsAccounts.FINDFIRST THEN
                    REPEAT
                        SavingsAccounts.CALCFIELDS("Balance (LCY)");
                        AccountScheduleBalance += SavingsAccounts."Balance (LCY)";
                    UNTIL SavingsAccounts.NEXT = 0;




                CashierTransactions.RESET;
                CashierTransactions.SETRANGE(CashierTransactions.Posted, TRUE);
                CashierTransactions.SETRANGE("Transaction Date", From, dateTo);
                IF CashierTransactions.FINDFIRST THEN
                    REPEAT
                        CASE CashierTransactions.Type OF
                            CashierTransactions.Type::"Cash Withdrawal":
                                CashWithdrawn += CashierTransactions.Amount;
                            CashierTransactions.Type::"Cash Deposit":
                                CashDeposited += CashierTransactions.Amount;
                            CashierTransactions.Type::"Cheque Deposit":
                                ChequeDeposited += CashierTransactions.Amount;
                            CashierTransactions.Type::"Cheque Withdrawal":
                                ChequeWithdrawn += CashierTransactions.Amount;
                        END
                    UNTIL CashierTransactions.NEXT = 0;


                LoanDisbursementHeader.RESET;
                LoanDisbursementHeader.SETRANGE(Posted, TRUE);
                LoanDisbursementHeader.SETRANGE(LoanDisbursementHeader.Status, LoanDisbursementHeader.Status::Approved);
                LoanDisbursementHeader.SETRANGE("Posting Date", From, dateTo);
                IF LoanDisbursementHeader.FINDFIRST THEN
                    REPEAT
                        SavingsLedgerEntry.RESET;
                        SavingsLedgerEntry.SETRANGE("Document No.", LoanDisbursementHeader."No.");
                        IF SavingsLedgerEntry.FINDFIRST THEN BEGIN
                            SavingsLedgerEntry.CALCSUMS("Credit Amount (LCY)");
                            SavingsLedgerEntry.CALCSUMS("Debit Amount (LCY)");
                            LoanAmountIn += SavingsLedgerEntry."Credit Amount (LCY)";
                            LoanAmountOut += SavingsLedgerEntry."Debit Amount (LCY)";
                        END;
                    UNTIL LoanDisbursementHeader.NEXT = 0;


                ATMTransactions.RESET;
                ATMTransactions.SETRANGE("Posting Date", From, dateTo);
                ATMTransactions.SETRANGE(Posted, TRUE);
                ATMTransactions.SETRANGE(Reversed, FALSE);
                ATMTransactions.SETRANGE(ATMTransactions."Transaction Type", 'AW');
                IF ATMTransactions.FINDFIRST THEN BEGIN
                    ATMTransactions.CALCSUMS(Amount);
                    AtmWithdrawals := ATMTransactions.Amount;
                END;

                AccountTransferHeader.RESET;
                AccountTransferHeader.SETRANGE(Posted, TRUE);
                AccountTransferHeader.SETRANGE(AccountTransferHeader."Transaction Date", From, dateTo);
                IF AccountTransferHeader.FINDFIRST THEN
                    REPEAT
                        AccountTransferSource.RESET;
                        AccountTransferSource.SETRANGE("No.", AccountTransferHeader.No);
                        IF AccountTransferSource.FINDFIRST THEN
                            if AccountTransferSource."Source Transaction Type" =
                                AccountTransferSource."Source Account Type"::Savings then BEGIN
                                IF SavingsAccounts.GET(AccountTransferSource."Source Account No.") THEN BEGIN
                                    IF SavingsAccounts."Product Category" IN [
                                             SavingsAccounts."Product Category"::" ",
                                             SavingsAccounts."Product Category"::"Junior Savings",
                                             SavingsAccounts."Product Category"::"Fixed Deposit",
                                             SavingsAccounts."Product Category"::"Unallocated Fund"
                                          ] THEN
                                        AccountTransferAmountOut += AccountTransferSource."Source Amount";
                                END;

                            END;

                        AccountTransferDestination.RESET;
                        AccountTransferDestination.SETRANGE("No.", AccountTransferHeader.No);
                        IF AccountTransferDestination.FINDFIRST THEN
                            CASE AccountTransferDestination."Destination Account Type" OF
                                AccountTransferDestination."Destination Account Type"::Savings:
                                    BEGIN
                                        IF SavingsAccounts.GET(AccountTransferDestination."Destination Account No.") THEN BEGIN
                                            IF SavingsAccounts."Product Category" IN [
                                                     SavingsAccounts."Product Category"::" ",
                                                     SavingsAccounts."Product Category"::"Junior Savings",
                                                     SavingsAccounts."Product Category"::"Fixed Deposit",
                                                     SavingsAccounts."Product Category"::"Unallocated Fund"
                                                  ] THEN
                                                AccountTransaferAmountIn += AccountTransferDestination."Destination Amount";
                                        END;

                                    END;
                            END;

                    UNTIL AccountTransferHeader.NEXT = 0;

                MPESATransactions.RESET;
                MPESATransactions.SETRANGE(Posted, TRUE);
                MPESATransactions.SETRANGE("Transaction Date", From, dateTo);
                MPESATransactions.SETFILTER("Transaction Type", '=%1|%2', MPESATransactions."Transaction Type"::"Mpesa Deposit", MPESATransactions."Transaction Type"::"Mpesa Withdrawal");
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
                            END;

                    UNTIL MPESATransactions.NEXT = 0;
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

        OpeningBalanceAll := 0;
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
        AccountScheduleBalance := 0;
        TotalInOutTotals := 0;
        TotalOfOpeningBal := 0;
    end;

    var
        OpeningBalanceAll: Decimal;
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
        AccountScheduleBalance: Decimal;
        AccountsScheduleDifference: Decimal;
        TotalOfOpeningBal: Decimal;
}

