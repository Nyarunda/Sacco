report 50060 "Daily Liquidity SASRA [FORM2B]"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Daily Liquidity SASRA [FORM2B].rdlc';
    ProcessingOnly = false;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(ReceiptAmountcont; Receipt2 + thiss + ReceiptAmount)
            {
            }
            column(Asat; Asat)
            {
            }
            column(OpeningBankBalances; OpeningBankBalances)
            {
            }
            column(OpeningTreasuryBalances; OpeningTreasuryBalances)
            {
            }
            column(OpeningTillBalances; OpeningTillBalances)
            {
            }
            column(OpeningMobile; 505)
            {
            }
            column(OpeningFdrs; OpeningFdrs)
            {
            }
            column(DayDeposits; DayDeposits + agencytransaction + deposits + ChequeDepo)
            {
            }
            column(Loanreceipts; Loanreceipts)
            {
            }
            column(OtherDeposits; OtherDeposits)
            {
            }
            column(Daywithdrawals; mpesaatmwithdr)
            {
            }
            column(TellerDaywithdrawals; Daywithdrawals)
            {
            }
            column(Cashpayments; Cashpayments)
            {
            }
            column(ClosingBankBalances; ClosingBankBalances)
            {
            }
            column(ClosingTreasuryBalances; ClosingTreasuryBalances)
            {
            }
            column(ClosingTillBalances; ClosingTillBalances)
            {
            }
            column(ClosingMobile; ClosingMobile)
            {
            }
            column(ClosingFdrs; ClosingFdrs)
            {
            }
            column(BOSADeposits; BOSADeposits)
            {
            }
            column(FOSADeposits; FOSADeposits)
            {
            }
            column(CashPayAmt; CashPayAmt)
            {
            }
            column(OtherCashReceipts; OtherCashReceipts)
            {
            }
            column(OtherCashpay; OtherCashpay)
            {
            }
            column(OpeningMobAmt; OpeningMobAmt)
            {
            }
            column(CashPaymentsotherthantoMembers; totpay + DayDeposits122)
            {
            }
            column(ReceiptAmountaa; ReceiptAmount)
            {
            }
            column(deposits; deposits)
            {
            }
            column(ChequeDepo; ChequeDepo)
            {
            }
            column(withrawals; withrawals)
            {
            }
            dataitem("<Cashier Transactions1>"; "Teller Transaction")
            {

                trigger OnAfterGetRecord()
                begin
                    DayDeposits122 := 0;
                    CTRCHARGES12 := 0;
                    //not banked cheq
                    "<Cashier Transactions1>".RESET;
                    "<Cashier Transactions1>".SETRANGE(Posted, TRUE);
                    //CashierTransactions.SETRANGE(
                    "<Cashier Transactions1>".SETFILTER("Transaction Date", '%1..%2', ENDDATE12, Asat);
                    IF "<Cashier Transactions1>".FIND('-') THEN
                        REPEAT

                            checkifreversed.RESET;
                            checkifreversed.SETFILTER(Reversed, 'FALSE');
                            checkifreversed.SETFILTER("Posting Date", '%1..%2', ENDDATE12, Asat);

                            checkifreversed.SETRANGE("Document No.", "<Cashier Transactions1>"."Transaction No.");
                            IF checkifreversed.FIND('-') THEN
                                IF "<Cashier Transactions1>".Type = "<Cashier Transactions1>".Type::"Cheque Deposit" THEN BEGIN
                                    /* IF "<Cashier Transactions1>"."Bank Status" = "<Cashier Transactions1>"."Bank Status"::Banked THEN  */
                                    DayDeposits122 += "<Cashier Transactions1>".Amount;
                                END;
                        UNTIL "<Cashier Transactions1>".NEXT = 0;
                    //BRZ-06-1000-4021|BRZ-061006-1000-7882
                    //MESSAGE('DONE%1',DayDeposits122);
                    //not banked
                    "<Cashier Transactions1>".RESET;
                    "<Cashier Transactions1>".SETRANGE(Posted, TRUE);

                    //CashierTransactions.SETRANGE(
                    "<Cashier Transactions1>".SETFILTER("Transaction Date", '%1..%2', ENDDATE12, Asat);
                    IF "<Cashier Transactions1>".FIND('-') THEN
                        REPEAT
                            /*CASE "<Cashier Transactions1>"."Transaction Type" OF
                              'CD': BEGIN
                                DayDeposits+=CashierTransactions.Amount;
                               END;
                              'SC': BEGIN
                                DayDeposits+=CashierTransactions.Amount;
                               END;
                              'SD': BEGIN

                                DayDeposits+=CashierTransactions.Amount;
                               END;*/
                            checkifreversed.RESET;
                            checkifreversed.SETRANGE(Reversed, FALSE);
                            checkifreversed.SETFILTER("Posting Date", '%1..%2', ENDDATE12, Asat);
                            checkifreversed.SETRANGE("Document No.", "<Cashier Transactions1>"."Transaction No.");
                            IF checkifreversed.FIND('-') THEN BEGIN

                                CASE "<Cashier Transactions1>".Type OF
                                    "<Cashier Transactions1>".Type::"Cash Deposit Customer":
                                        thiss += "<Cashier Transactions1>".Amount;
                                    "<Cashier Transactions1>".Type::"Cash Deposit":
                                        BEGIN
                                            IF "<Cashier Transactions1>"."Transaction Type" <> 'SC' THEN BEGIN
                                                DayDeposits += "<Cashier Transactions1>".Amount;
                                                // DayDeposits:=DayDeposits+DayDeposits122;SC
                                            END;
                                        END;
                                END;
                            END;
                            CASE "<Cashier Transactions1>".Type OF
                                // "<Cashier Transactions1>".Type::Other: thiss+="<Cashier Transactions1>".Amount;
                                "<Cashier Transactions1>".Type::"Cash Deposit":
                                    BEGIN
                                        IF ("<Cashier Transactions1>"."Transaction Type" = 'SC') THEN
                                            Receipt2 += "<Cashier Transactions1>".Amount;
                                    END;

                            END;

                            CASE "<Cashier Transactions1>".Type OF

                                "<Cashier Transactions1>".Type::"Cash Withdrawal":
                                    BEGIN
                                        /* IF ("<Cashier Transactions1>"."Transaction Type" = 'CW') OR//CW|BCW|GCW|BW|CWITHJD|CWITHBUS|CWG|MCW|ACW //wanadege
                                           ("<Cashier Transactions1>"."Transaction Type" = 'BCW') OR
                                           ("<Cashier Transactions1>"."Transaction Type" = 'GCW') OR
                                           ("<Cashier Transactions1>"."Transaction Type" = 'BW') OR
                                           ("<Cashier Transactions1>"."Transaction Type" = 'CWITHJD') OR
                                           ("<Cashier Transactions1>"."Transaction Type" = 'CWITHBUS') OR
                                           ("<Cashier Transactions1>"."Transaction Type" = 'CWG') OR
                                           ("<Cashier Transactions1>"."Transaction Type" = 'MCW') OR
                                           ("<Cashier Transactions1>"."Transaction Type" = 'ACW') THEN */
                                        CTRCHARGES.RESET;
                                        CTRCHARGES.SETRANGE("Document No.", "<Cashier Transactions1>"."Transaction No.");
                                        CTRCHARGES.SETRANGE("Posting Date", "<Cashier Transactions1>"."Transaction Date");
                                        // CTRCHARGES.SETFILTER("Bal. Account Type",'<>%1',CTRCHARGES."Bal. Account Type"::"Bank Account");
                                        IF CTRCHARGES.FIND('-') THEN BEGIN
                                            REPEAT
                                                CTRCHARGES12 += CTRCHARGES."Amount (LCY)";
                                            UNTIL CTRCHARGES.NEXT = 0;
                                        END;
                                        GLAccEntry.RESET;
                                        GLAccEntry.SETRANGE(Reversed, FALSE);
                                        GLAccEntry.SETFILTER("Posting Date", '%1..%2', ENDDATE12, Asat);
                                        GLAccEntry.SETRANGE("Document No.", "<Cashier Transactions1>"."Transaction No.");
                                        IF GLAccEntry.FIND('-') THEN BEGIN
                                            Daywithdrawals += "<Cashier Transactions1>".Amount;
                                        END;
                                        // Daywithdrawals:=0;
                                    END;

                            END;
                        /*  CASE CashierTransactions.Type OF
                       CashierTransactions.Type::"Cheque Deposit": BEGIN
                       IF (CashierTransactions."Transaction Type" = 'CHEQUE') OR
                          (CashierTransactions."Transaction Type" = 'CHEQUE-BAK') OR
                          (CashierTransactions."Transaction Type" = 'CHEQUE-BUS') OR
                          (CashierTransactions."Transaction Type" = 'CHEQUE-GP') THEN BEGIN
                         REPEAT ChequeDepo+= CashierTransactions.Amount;
                         UNTIL CashierTransactions.NEXT = 0;
                         END;
                         //DayDeposits+= CashierTransactions.Amount;
                        END;

                   END; */
                        /*"<Cashier Transactions1>".Type::"Cheque Deposit": BEGIN
                              IF ("<Cashier Transactions1>"."Transaction Type" = 'CHEQUE') OR
                                 ("<Cashier Transactions1>"."Transaction Type" = 'CHEQUE-BAK) OR
                                 ("<Cashier Transactions1>"."Transaction Type" = 'CHEQUE-BUS') OR
                                 ("<Cashier Transactions1>"."Transaction Type" = 'CHEQUE-GP') OR
                                  ChequeDepo+= "<Cashier Transactions1>".Amount;
                            END;

                          END;*/
                        UNTIL "<Cashier Transactions1>".NEXT = 0;
                    //END;

                end;
            }

            trigger OnAfterGetRecord()
            var
                RegPrefix: Code[10];
                GLEntry: Record "G/L Entry";
                Savings: Record "Savings Accounts";
                BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
                test: Decimal;
            begin


                //Normal Banks opening balance//DayDeposits+agencytransaction+deposits+ChequeDepo
                //Daywithdrawals+withrawals+agentwithdrawal
                mpesaatmwithdr := 0;
                OpeningBankBalances := 0;
                ATMTR12 := 0;
                Daywithdrawals := 0;
                agentwithdrawal := 0;
                CTRCHARGES12 := 0;
                totpay := 0;
                /**/
                OpeningBankBalances := 0;
                OpeningBankBalances1 := 0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.", OpeningBankBalance11);
                GLAccount.SETFILTER(GLAccount."Date Filter", '..%1', ENDDATE12/*,CALCDATE('-1D',Asat)*/);
                GLAccount.SetAutoCalcFields(GLAccount."Balance at Date");
                IF GLAccount.FINDSET THEN BEGIN
                    REPEAT
                        OpeningBankBalances1 := OpeningBankBalances1 + GLAccount."Balance at Date";
                    UNTIL GLAccount.NEXT = 0;
                END;

                //...........
                OpeningBankBalances := OpeningBankBalances1 + OpeningBankBalances2;


                OpeningTreasuryBalances := 0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.", OpeningTreasuryBalances1);
                GLAccount.SETFILTER(GLAccount."Date Filter", '..%1', CALCDATE('-1D', ENDDATE12)/*,CALCDATE('-1D',Asat)*/);
                IF GLAccount.FINDSET THEN BEGIN
                    REPEAT
                        GLAccount.CALCFIELDS(GLAccount."Balance at Date");
                        OpeningTreasuryBalances := OpeningTreasuryBalances + GLAccount."Balance at Date";
                    UNTIL GLAccount.NEXT = 0;
                END;

                //teller tills opening balance
                OpeningTillBalances := 0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.", OpeningTillBalances1);
                GLAccount.SETFILTER(GLAccount."Date Filter", '..%1', CALCDATE('-1D', ENDDATE12)/*,CALCDATE('-1D',Asat)*/);
                IF GLAccount.FINDSET THEN BEGIN
                    REPEAT
                        GLAccount.CALCFIELDS(GLAccount."Balance at Date");
                        OpeningTillBalances += GLAccount."Balance at Date";
                    UNTIL GLAccount.NEXT = 0;
                END;

                //mobile banking float opening balance
                OpeningMobile := 0;
                OpeningMobAmt := 0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.", OpeningMobile1);
                GLAccount.SETFILTER(GLAccount."Date Filter", '..%1', CALCDATE('-1D', ENDDATE12)/*,CALCDATE('-1D',Asat)*/);
                IF GLAccount.FINDSET THEN BEGIN
                    REPEAT
                        GLAccount.CALCFIELDS("Balance at Date");
                        OpeningMobile += GLAccount."Balance at Date";
                        OpeningMobAmt := OpeningMobAmt + GLAccount."Balance at Date";
                    UNTIL GLAccount.NEXT = 0;
                END;
                //BRZ-06-1000-4021|BRZ-061006-1000-7882
                Savings.Reset();
                Savings.SetFilter("No.", SavingsMobile);
                Savings.SetFilter("Date Filter", '..%1', CALCDATE('-1D', ENDDATE12));
                Savings.SetAutoCalcFields("Balance (LCY)");
                if Savings.FindFirst() then
                    repeat
                        OpeningMobAmt := OpeningMobAmt - Savings."Balance (LCY)";
                    until Savings.Next() = 0;

                //Placement with Banks (FDRs, Near Liquid Assets) opening balance
                OpeningFdrs := 0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.", OpeningFdrs1);
                GLAccount.SETFILTER(GLAccount."Date Filter", '..%1', CALCDATE('-1D', ENDDATE12)/*,CALCDATE('-1D',Asat)*/);
                IF GLAccount.FINDSET THEN BEGIN
                    REPEAT
                        GLAccount.CALCFIELDS(GLAccount."Balance at Date");
                        OpeningFdrs := OpeningFdrs + GLAccount."Balance at Date";
                    UNTIL GLAccount.NEXT = 0;
                END;

                //Deposits from members
                checkifreversed.RESET;
                checkifreversed.SETFILTER(Reversed, 'FALSE');
                checkifreversed.SETFILTER("Posting Date", '%1', Asat);
                checkifreversed.SETFILTER("Debit Amount", '>0');
                IF checkifreversed.FIND('-') THEN BEGIN
                    DayDeposits := 0;
                    ChequeDepo := 0;
                    CashierTransactions.RESET;
                    CashierTransactions.SETRANGE(Posted, TRUE);

                    //CashierTransactions.SETRANGE(
                    CashierTransactions.SETFILTER("Transaction Date", '%1', Asat);
                    IF CashierTransactions.FIND('-') THEN
                        REPEAT
                            /*CASE CashierTransactions."Transaction Type" OF
                              'CD': BEGIN
                                DayDeposits+=CashierTransactions.Amount;
                               END;
                              'SC': BEGIN
                                DayDeposits+=CashierTransactions.Amount;
                               END;
                              'SD': BEGIN

                                DayDeposits+=CashierTransactions.Amount;
                               END;*/
                            checkifreversed.RESET;
                            checkifreversed.SETFILTER(Reversed, 'FALSE');
                            checkifreversed.SETFILTER("Posting Date", '%1', Asat);
                            //checkifreversed.SETFILTER("Debit Amount",'>0');
                            //checkifreversed.SETRANGE("Customer No.",CashierTransactions."Account No");
                            checkifreversed.SETRANGE("Posting Date", CashierTransactions."Transaction Date");
                            checkifreversed.SETRANGE("Document No.", CashierTransactions."Transaction No.");
                            IF checkifreversed.FIND('-') THEN
                                /*CurrReport.SKIP;*/
                            BankAccountLedgerEntry.RESET;
                            BankAccountLedgerEntry.SETRANGE("Document No.", CashierTransactions."Transaction No.");
                            BankAccountLedgerEntry.SETRANGE(Reversed, FALSE);
                            //IF NOT BankAccountLedgerEntry.FIND('-') THEN
                            //CurrReport.SKIP;

                            CASE CashierTransactions.Type OF
                                CashierTransactions.Type::"Cash Deposit":
                                    BEGIN
                                        IF (CashierTransactions."Transaction Type" = 'ACD') OR
                                           (CashierTransactions."Transaction Type" = 'BCD') OR
                                           (CashierTransactions."Transaction Type" = 'GCD') OR
                                           (CashierTransactions."Transaction Type" = 'MCD') OR
                                           (CashierTransactions."Transaction Type" = 'BD') OR
                                           (CashierTransactions."Transaction Type" = 'CD') OR
                                           (CashierTransactions."Transaction Type" = 'CDBUS') OR
                                           (CashierTransactions."Transaction Type" = 'CDEPJD') OR
                                           (CashierTransactions."Transaction Type" = 'CDOS') THEN BEGIN

                                            //DayDeposits+= CashierTransactions.Amount;
                                        END;

                                    END;
                                CashierTransactions.Type::"Cash Deposit Customer":
                                    thiss += CashierTransactions.Amount;

                            END;
                        UNTIL CashierTransactions.NEXT = 0;
                END;

                /*  CASE CashierTransactions.Type OF
                 CashierTransactions.Type::"Cheque Deposit": BEGIN
                 IF (CashierTransactions."Transaction Type" = 'CHEQUE') OR
                    (CashierTransactions."Transaction Type" = 'CHEQUE-BAK') OR
                    (CashierTransactions."Transaction Type" = 'CHEQUE-BUS') OR
                    (CashierTransactions."Transaction Type" = 'CHEQUE-GP') THEN BEGIN
                   REPEAT ChequeDepo+= CashierTransactions.Amount;
                   UNTIL CashierTransactions.NEXT = 0;
                   END;
                   //DayDeposits+= CashierTransactions.Amount;
                  END;

             END; */

                //other day receipts
                OtherDeposits := 0;
                GLEntry.RESET;
                GLEntry.SETFILTER(GLEntry."G/L Account No.", OtherDeposits1);
                GLEntry.SETFILTER(GLEntry."Posting Date", '%1', Asat);
                //GLEntry.SETFILTER(GLEntry."External Document No.",'<>%1','');
                IF GLEntry.FINDSET THEN BEGIN
                    REPEAT
                        OtherDeposits := OtherDeposits + GLEntry."Debit Amount";
                    UNTIL GLEntry.NEXT = 0;
                END;

                BankAccountLedgerEntry.RESET;
                BankAccountLedgerEntry.SETRANGE(BankAccountLedgerEntry.Description, 'Loan Issued- Normal Loan');
                BankAccountLedgerEntry.SETFILTER(BankAccountLedgerEntry."Posting Date", '%1', Asat);
                IF BankAccountLedgerEntry.FINDFIRST THEN BEGIN
                    BankAccountLedgerEntry.CALCSUMS("Credit Amount (LCY)");
                    OtherDeposits += BankAccountLedgerEntry."Credit Amount (LCY)";
                END;

                MESSAGE('OtherDeposits %1', OtherDeposits);

                CashierTransactions.RESET;
                CashierTransactions.SETRANGE(Posted, TRUE);
                CashierTransactions.SETFILTER("Transaction Date", '%1', Asat);
                CashierTransactions.SETRANGE(Type, CashierTransactions.Type::"Credit Receipt");
                IF CashierTransactions.FIND('-') THEN
                    REPEAT
                        Loanreceipts += CashierTransactions.Amount;
                    UNTIL CashierTransactions.NEXT = 0;
                //AGENT DEPOSITS
                AgentTrans.RESET;
                AgentTrans.SETRANGE("Transaction Type", AgentTrans."Transaction Type"::LoanRepayment);
                AgentTrans.SETFILTER("Transaction Date", '%1..%2', ENDDATE12, Asat);
                IF AgentTrans.FINDSET THEN
                    REPEAT
                        Loanreceipts += AgentTrans.Amount;
                    UNTIL AgentTrans.NEXT = 0;

                AgentTrans.RESET;
                AgentTrans.SETFILTER("Transaction Type", 'Deposit|ShareDeposit');
                AgentTrans.SETFILTER("Transaction Date", '%1..%2', ENDDATE12, Asat);
                IF AgentTrans.FINDSET THEN
                    REPEAT
                        GLEntry.RESET;
                        GLEntry.SETFILTER("Posting Date", '%1..%2', ENDDATE12, Asat);
                        GLEntry.SETRANGE("Document No.", AgentTrans."Document No.");
                        GLEntry.SETRANGE(Reversed, FALSE);
                        IF GLEntry.FIND('-') THEN BEGIN
                            agencytransaction += AgentTrans.Amount;
                        END;
                    UNTIL AgentTrans.NEXT = 0;

                AgentTrans.RESET;
                AgentTrans.SETFILTER("Transaction Type", 'Withdrawal');
                AgentTrans.SETFILTER("Transaction Date", '%1..%2', ENDDATE12, Asat);
                IF AgentTrans.FINDSET THEN
                    REPEAT
                        GLEntry.RESET;
                        GLEntry.SETRANGE(Reversed, FALSE);
                        GLEntry.SETFILTER("Posting Date", '%1..%2', ENDDATE12, Asat);
                        GLEntry.SETRANGE("Document No.", AgentTrans."Document No.");
                        IF GLEntry.FIND('-') THEN BEGIN
                            agentwithdrawal += AgentTrans.Amount;
                        END;
                    UNTIL AgentTrans.NEXT = 0;
                //Other cash receipts
                //OtherCashReceipts
                OtherCashReceipts := 0;
                SavingsLedgerEntry.RESET;
                SavingsLedgerEntry.SETFILTER(SavingsLedgerEntry."Posting Date", '%1', Asat);
                SavingsLedgerEntry.SETFILTER(SavingsLedgerEntry."Credit Amount (LCY)", '<>%1', 0);
                SavingsLedgerEntry.SETFILTER(SavingsLedgerEntry.Description, '%1', 'Registration Fee');
                IF SavingsLedgerEntry.FINDSET THEN BEGIN
                    SavingsLedgerEntry.CALCSUMS(SavingsLedgerEntry."Credit Amount (LCY)");
                    OtherCashReceipts := OtherCashReceipts + SavingsLedgerEntry."Credit Amount (LCY)";
                END;

                GLEntry.RESET;
                GLEntry.SETFILTER(GLEntry."G/L Account No.", '%1', '400-000-402');
                GLEntry.SETFILTER(GLEntry."Posting Date", '%1', Asat);
                IF GLEntry.FINDSET THEN BEGIN
                    REPEAT
                        OtherCashReceipts := OtherCashReceipts + GLEntry."Credit Amount";
                    UNTIL GLEntry.NEXT = 0;
                END; //end OtherCashReceipts
                MESSAGE('OtherCashReceipts %1', OtherCashReceipts);

                //Otherdeposits
                Daywithdrawals := 0;
                ATMTransactions.RESET;
                ATMTransactions.SETRANGE("Date Posted", Asat);
                IF ATMTransactions.FIND('-') THEN BEGIN
                    REPEAT
                        SavingsLedgerEntry.RESET;
                        SavingsLedgerEntry.SETRANGE("Account No.", ATMTransactions."Member Account");
                        SavingsLedgerEntry.SETRANGE("Posting Date", Asat);
                        SavingsLedgerEntry.SETFILTER(Description, '%1|%2', '*Charges*', '*commission*');
                        IF SavingsLedgerEntry.FIND('-') THEN BEGIN
                            REPEAT
                                CTRCHARGES12 += SavingsLedgerEntry."Amount (LCY)";
                            UNTIL SavingsLedgerEntry.NEXT = 0;
                        END;
                        ATMTR12 += ATMTransactions.Amount;
                    UNTIL ATMTransactions.NEXT = 0;
                END;
                GLEntry.RESET;
                GLEntry.SETFILTER(GLEntry."G/L Account No.", DaywithdrawalsL);
                GLEntry.SETFILTER(GLEntry."Posting Date", '%1', Asat);
                IF GLEntry.FINDSET THEN BEGIN
                    REPEAT
                        OtherDeposits := OtherDeposits + GLEntry."Debit Amount";
                    UNTIL GLEntry.NEXT = 0;
                END;
                //DaywithdrawalsL
                //mpesaatmwith
                BankAccountLedgerEntry.RESET;
                BankAccountLedgerEntry.SETRANGE(Reversed, FALSE);
                BankAccountLedgerEntry.SETFILTER(BankAccountLedgerEntry."Bank Account No.", '%1|%2', 'BANK013', 'BANK003');
                BankAccountLedgerEntry.SETFILTER(BankAccountLedgerEntry."Posting Date", '%1..%2', ENDDATE12, Asat);
                BankAccountLedgerEntry.SETFILTER(Amount, '<%1', 0);
                IF BankAccountLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        mpesaatmwithdr += BankAccountLedgerEntry."Credit Amount (LCY)";
                    UNTIL BankAccountLedgerEntry.NEXT = 0;
                END;
                //mpesaatmwith
                /*Daywithdrawals:=0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.",DaywithdrawalsL);
                GLAccount.SETRANGE(GLAccount."Date Filter",Asat);
                IF GLAccount.FINDSET THEN BEGIN REPEAT
                  GLAccount.CALCFIELDS("Net Change");
                  Daywithdrawals:= Daywithdrawals+GLAccount."Net Change";
                  UNTIL GLAccount.NEXT = 0;
                END;
                */
                checkifreversed.RESET;
                checkifreversed.SETFILTER(Reversed, 'FALSE');
                checkifreversed.SETFILTER("Posting Date", '%1', Asat);
                checkifreversed.SETFILTER("Debit Amount", '>0');
                IF checkifreversed.FIND('-') THEN BEGIN
                    DayDeposits := 0;

                    CashierTransactions.RESET;
                    CashierTransactions.SETRANGE(Posted, TRUE);
                    //CashierTransactions.CALCFIELDS(Amount);
                    //CashierTransactions.SETRANGE(
                    CashierTransactions.SETFILTER("Transaction Date", '%1', Asat);
                    IF CashierTransactions.FIND('-') THEN
                        REPEAT
                            /*CASE CashierTransactions."Transaction Type" OF
                              'CD': BEGIN
                                DayDeposits+=CashierTransactions.Amount;
                               END;
                              'SC': BEGIN
                                DayDeposits+=CashierTransactions.Amount;
                               END;
                              'SD': BEGIN

                                DayDeposits+=CashierTransactions.Amount;
                               END;*/
                            checkifreversed.RESET;
                            checkifreversed.SETFILTER(Reversed, 'FALSE');
                            checkifreversed.SETFILTER("Posting Date", '%1', Asat);
                            //checkifreversed.SETFILTER("Debit Amount",'>0');
                            //checkifreversed.SETRANGE("Customer No.",CashierTransactions."Account No");
                            //checkifreversed.SETRANGE("Posting Date",CashierTransactions."Transaction Date");
                            checkifreversed.SETRANGE("Document No.", CashierTransactions."Transaction No.");
                            IF checkifreversed.FIND('-') THEN
                                CASE CashierTransactions.Type OF
                                    CashierTransactions.Type::"Cash Withdrawal":
                                        BEGIN
                                            IF (CashierTransactions."Transaction Type" = 'CW') OR
                                               (CashierTransactions."Transaction Type" = 'BCW') OR
                                               (CashierTransactions."Transaction Type" = 'GCW') OR
                                               (CashierTransactions."Transaction Type" = 'BW') OR
                                               (CashierTransactions."Transaction Type" = 'CWITHJD') OR
                                               (CashierTransactions."Transaction Type" = 'CWITHBUS') OR
                                               (CashierTransactions."Transaction Type" = 'CWG') OR
                                               (CashierTransactions."Transaction Type" = 'MCW') OR
                                               (CashierTransactions."Transaction Type" = 'ACW') THEN
                                                thisss += CashierTransactions.Amount;
                                        END;

                                    CashierTransactions.Type::"Cash Deposit Customer":
                                        BEGIN
                                            thiss += CashierTransactions.Amount;
                                        END;
                                END;
                        UNTIL CashierTransactions.NEXT = 0;
                END;
                Cashpayments := 0;
                CashPayAmt := 0;
                BankAccount.RESET;
                BankAccount.SETRANGE("Bank Type", BankAccount."Bank Type"::Cashier);
                IF BankAccount.FINDSET THEN BEGIN
                    REPEAT
                        BankAccountLedgerEntry.RESET;
                        BankAccountLedgerEntry.SETRANGE("Bank Account No.", BankAccount."No.");
                        BankAccountLedgerEntry.SETFILTER("Posting Date", '%1', Asat);
                        BankAccountLedgerEntry.SETRANGE(Reversed, FALSE);
                        BankAccountLedgerEntry.SETFILTER(Amount, '<%1', 0);
                        BankAccountLedgerEntry.SETFILTER("Bal. Account No.", '=%1', '');
                        IF BankAccountLedgerEntry.FINDSET THEN
                            REPEAT
                                CashPayAmt += BankAccountLedgerEntry.Amount
                            UNTIL BankAccountLedgerEntry.NEXT = 0;
                    UNTIL BankAccount.NEXT = 0;
                END;

                CashierTransactions.RESET;
                CashierTransactions.SETRANGE(Posted, TRUE);
                CashierTransactions.SETRANGE(Type, CashierTransactions.Type::"Cheque Deposit");
                CashierTransactions.SETFILTER("Transaction Date", '%1', Asat);
                IF CashierTransactions.FIND('-') THEN
                    REPEAT
                        CashPayAmt += -1 * CashierTransactions.Amount;
                    UNTIL CashierTransactions.NEXT = 0;
                /**/
                TestDate := CALCDATE('-1D +1D', Asat);
                //MESSAGE('date %1',TestDate);
                Cashpayments := 0;
                OpenCashpayments := 0;
                EndCashpayments := 0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.", '%1', '40999');
                //GLAccount.SETFILTER(GLAccount."Date Filter",'..%1',CALCDATE('-1D +1D',Asat));
                GLAccount.SETFILTER(GLAccount."Date Filter", '%1', TestDate);
                IF GLAccount.FINDSET THEN BEGIN
                    //MESSAGE('No %1',GLAccount."Date Filter");
                    REPEAT
                        GLAccount.CALCFIELDS(GLAccount."Debit Amount");
                        Cashpayments := Cashpayments + GLAccount."Debit Amount";
                    UNTIL GLAccount.NEXT = 0;
                END;

                /*OtherCashpayL*/
                OtherCashpay := 0;
                GLAccEntry.RESET;
                GLAccEntry.SETFILTER(GLAccEntry."Posting Date", '%1', Asat);
                GLAccEntry.SETFILTER(GLAccEntry."G/L Account No.", OtherCashpayL);
                GLAccEntry.SETFILTER(GLAccEntry."Credit Amount", '<>%1', 0);
                IF GLAccEntry.FINDSET THEN BEGIN
                    REPEAT
                        OtherCashpay := 0;//OtherCashpay+(GLAccEntry."Credit Amount");
                    UNTIL GLAccEntry.NEXT = 0;
                    MESSAGE('OTHER CASH %1', OtherCashpay); //ndetei Testing code
                END;

                ClosingBankBalances := 0;
                ClosingBankBalances1 := 0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.", OpeningBankBalance11);
                GLAccount.SETFILTER(GLAccount."Date Filter", '..%1', CALCDATE('+1D', Asat)); //CALCDATE('-1D',Asat)
                IF GLAccount.FINDSET THEN BEGIN
                    REPEAT
                        GLAccount.CALCFIELDS(GLAccount."Balance at Date");
                        ClosingBankBalances1 := ClosingBankBalances1 + GLAccount."Balance at Date";
                    UNTIL GLAccount.NEXT = 0;
                END;

                //
                ClosingBankBalances := ClosingBankBalances1;

                //

                ClosingTreasuryBalances := 0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.", OpeningTreasuryBalances1);
                GLAccount.SETFILTER(GLAccount."Date Filter", '%1', Asat);
                GLAccount.SetAutoCalcFields(GLAccount."Balance at Date");
                IF GLAccount.FINDSET THEN BEGIN
                    REPEAT
                        ClosingTreasuryBalances := (ClosingTreasuryBalances + GLAccount."Balance at Date");
                    UNTIL GLAccount.NEXT = 0;
                END;
                //teller tills closing balance
                ClosingTillBalances := 0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.", OpeningTillBalances1);
                GLAccount.SETFILTER(GLAccount."Date Filter", '..%1', Asat);
                IF GLAccount.FINDSET THEN BEGIN
                    REPEAT
                        GLAccount.CALCFIELDS(GLAccount."Balance at Date");
                        ClosingTillBalances += GLAccount."Balance at Date";
                    UNTIL GLAccount.NEXT = 0;
                END;
                //mobile banking float closing balance
                ClosingMobile := 0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.", OpeningMobile1);
                GLAccount.SETFILTER(GLAccount."Date Filter", '%1', Asat);
                IF GLAccount.FINDSET THEN BEGIN
                    REPEAT
                        GLAccount.CALCFIELDS("Balance at Date");
                        ClosingMobile := ClosingMobile + GLAccount."Balance at Date";
                    UNTIL GLAccount.NEXT = 0;
                END;

                //Placement with Banks (FDRs, Near Liquid Assets) closing balance
                ClosingFdrs := 0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.", OpeningFdrs1);
                GLAccount.SETFILTER(GLAccount."Date Filter", '%1', Asat);
                IF GLAccount.FINDSET THEN BEGIN
                    REPEAT
                        GLAccount.CALCFIELDS(GLAccount."Balance at Date");
                        ClosingFdrs := ClosingFdrs + GLAccount."Balance at Date";
                    UNTIL GLAccount.NEXT = 0;
                END;


                //bosa deposits
                BOSADeposits := 0;
                BOSADeposits1 := 0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.", BOSADeposits1L);
                GLAccount.SETFILTER(GLAccount."Date Filter", '%1', CALCDATE('-1D+1D', Asat));
                IF GLAccount.FINDSET THEN BEGIN
                    REPEAT
                        GLAccount.CALCFIELDS(GLAccount."Balance at Date");
                        BOSADeposits1 := BOSADeposits1 + (-1 * GLAccount."Balance at Date");
                    UNTIL GLAccount.NEXT = 0;
                END;


                //
                BOSADeposits := BOSADeposits1;

                //fosa deposits FOSADepositsL
                FOSADeposits := 0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.", FOSADepositsL);
                GLAccount.SETFILTER(GLAccount."Date Filter", '%1', CALCDATE('-1D+1D', Asat));
                IF GLAccount.FINDSET THEN BEGIN
                    REPEAT
                        GLAccount.CALCFIELDS(GLAccount."Balance at Date");
                        FOSADeposits := FOSADeposits + (-1 * GLAccount."Balance at Date");
                    UNTIL GLAccount.NEXT = 0;
                END;
                // GLEntry.RESET;
                // GLEntry.SETRANGE(Reversed,FALSE);
                // GLEntry.SETFILTER("Posting Date",'%1',Asat);
                // IF GLEntry.FIND('-') THEN BEGIN REPEAT
                PaymentsHeader.RESET;
                PaymentsHeader.SETFILTER(PaymentsHeader."Date Posted", '%1..%2', ENDDATE12, Asat);
                PaymentsHeader.SETRANGE(Posted, TRUE);
                //PaymentsHeader.SETFILTER("Responsibility Center", '%1', 'TELLER');
                IF PaymentsHeader.FINDSET THEN
                    REPEAT
                    BEGIN
                        GLEntry.RESET;
                        GLEntry.SETRANGE(Reversed, FALSE);
                        GLEntry.SETFILTER("Posting Date", '%1..%2', ENDDATE12, Asat);
                        GLEntry.SETRANGE("Document No.", PaymentsHeader."No.");
                        IF GLEntry.FIND('-') THEN BEGIN
                            PaymentsHeader.CALCFIELDS("Total Net Amount");
                            // totpay += PaymentsHeader."Total Net Amount";
                        END;
                    END;

                    UNTIL PaymentsHeader.NEXT = 0;
                //       UNTIL GLEntry.NEXT=0;
                //       END;
                ReceiptsHeader.RESET;
                ReceiptsHeader.SETFILTER("Date Posted", '%1', Asat);
                ReceiptsHeader.SETFILTER("Responsibility Center", 'TELLER');
                //ReceiptsHeader.SETRANGE("Shortcut Dimension 2 Code",DimensionValue.Code);
                ReceiptsHeader.SETRANGE(Posted, TRUE);
                //ReceiptsHeader.SETRANGE("Shortcut Dimension 2 Code",DimensionValue.Code);
                //ReceiptsHeader.SETFILTER("Amount Recieved",'>0');
                IF ReceiptsHeader.FINDSET THEN
                    REPEAT
                        ReceiptAmount += ReceiptsHeader."Amount Recieved";
                    //END;
                    UNTIL ReceiptsHeader.NEXT = 0;

                //withrawals
                GLAccount.RESET;
                //GLAccount.SETFILTER
                GLAccount.SETFILTER(GLAccount."No.", '400-000-416|400-000-410|400-000-418|400-000-412');
                GLAccount.SETFILTER(GLAccount."Date Filter", '%1..%2', ENDDATE12, Asat);
                //GLAccount.SETFILTER(GLAccount."Date Filter",'..%1',CALCDATE('-1D+1D',Asat));400-000-402|400-000-416|400-000-412|500-100-310|500-100-303
                IF GLAccount.FINDSET THEN BEGIN
                    REPEAT
                        GLEntry.RESET;
                        //GLEntry.SETFILTER(GLEntry."G/L Account No.",'%1', '400-000-402');
                        //GLEntry.SETFILTER("Source Code",'PAYMENTJNL|CASHRECJNL');
                        GLEntry.SETRANGE("G/L Account No.", GLAccount."No.");
                        GLEntry.SETFILTER("G/L Account No.", '400-000-416|400-000-410|400-000-418|400-000-412');
                        GLEntry.SETFILTER("Posting Date", '%1..%2', ENDDATE12, Asat);
                        //GLEntry.SETFILTER(Description,'<>%1','MPESA Corporate Charges');
                        GLEntry.SETFILTER(Amount, '<0');
                        GLEntry.SETRANGE(Reversed, FALSE);
                        GLEntry.SETFILTER(GLEntry."Posting Date", '%1..%2', ENDDATE12, Asat);
                        IF GLEntry."Source Code" <> 'PAYMENTJNL|CASHRECJNL' THEN BEGIN
                            GLAccount.CALCFIELDS(GLAccount."Credit Amount");
                            withrawals += GLAccount."Credit Amount";
                        END;
                    UNTIL GLAccount.NEXT = 0;
                END;
                //withrawals
                //deposits
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."No.", '400-000-416|400-000-410|400-000-418');
                GLAccount.SETFILTER(GLAccount."Date Filter", '%1..%2', ENDDATE12, Asat);
                //GLAccount.SETFILTER(GLAccount."Date Filter",'..%1',CALCDATE('-1D+1D',Asat));
                IF GLAccount.FINDSET THEN BEGIN
                    REPEAT
                        GLEntry.RESET;
                        //GLEntry.SETFILTER(GLEntry."G/L Account No.",'%1', '400-000-402');
                        //GLEntry.SETFILTER("Source Code",'PAYMENTJNL|CASHRECJNL');
                        GLEntry.SETRANGE("G/L Account No.", GLAccount."No.");
                        GLEntry.SETFILTER("G/L Account No.", '400-000-416|400-000-410|400-000-418');
                        //GLEntry.SETRANGE("Posting Date",GLAccount."Date Filter");
                        GLEntry.SETFILTER(Amount, '>0');
                        GLEntry.SETRANGE(Reversed, FALSE);
                        GLEntry.SETFILTER(GLEntry."Posting Date", '%1..%2', Asat, ENDDATE12);
                        IF GLEntry."Source Code" <> 'PAYMENTJNL|CASHRECJNL' THEN BEGIN
                            GLAccount.CALCFIELDS(GLAccount."Debit Amount");
                            deposits += GLAccount."Debit Amount";
                            //GLEntry.CALCFIELDS(Amount);
                            // deposits+=GLEntry.Amount;
                        END;
                    UNTIL GLAccount.NEXT = 0;
                END;

                MicroTeller.Reset();
                MicroTeller.SetRange("Date Banked", ENDDATE12, Asat);
                if MicroTeller.FindSet() then begin
                    repeat
                        MicroLines.Reset();
                        MicroLines.SetRange("No.", MicroTeller."No.");
                        if MicroLines.FindFirst() then begin
                            MicroLines.CalcSums("Deposit Paid");
                            deposits += MicroLines."Deposit Paid";
                        end;
                    until Next() = 0;
                end;
                //deposits

                /*GLEntry.SETRANGE("G/L Account No.",GLAccount."No.");
                GLEntry.SETFILTER("G/L Account No.",'400-000-416|400-000-410|400-000-418');
                GLEntry.SETRANGE("Posting Date",GLAccount."Date Filter");
                GLEntry.SETFILTER(Amount,'>0');
                GLEntry.SETRANGE(GLEntry."Posting Date", Asat);
                IF GLEntry."Source Code"<>'PAYMENTJNL|CASHRECJNL' THEN BEGIN
                    GLAccount.CALCFIELDS(GLAccount."Debit Amount");
                    deposits+=GLAccount."Debit Amount";
                   //GLEntry.CALCFIELDS(Amount);
                  // deposits+=GLEntry.Amount;

                  */

            end;

            trigger OnPreDataItem()
            begin
                //Daywithdrawals+agentwithdrawal+ATMTR12
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ENDDATE12; ENDDATE12)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(Asat; Asat)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
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

    trigger OnPostReport()
    begin
        MESSAGE('day %1 agent %2 depo %3 cheq %4', DayDeposits, agencytransaction, deposits, ChequeDepo);
    end;

    trigger OnPreReport()
    begin
        GLFilter := GLAccount.GETFILTERS;
        PeriodText := GLAccount.GETFILTER("Date Filter");
    end;

    var
        Asat: Date;
        ReceiptAmountcont: Decimal;
        thisss: Decimal;
        MicroTeller: Record "Micro Credit Transactions";
        MicroLines: Record "Micro Credit Transaction Lines";
        ChequeDepo: Decimal;
        BankAccount: Record "Bank Account";
        OpeningBankBalances: Decimal;
        OpeningTreasuryBalances: Decimal;
        OpeningTillBalances: Decimal;
        OpeningMobile: Decimal;
        OpeningMobAmt: Decimal;
        GLAccount: Record "G/L Account";
        OpeningFdrs: Decimal;
        MemberLedgerEntry: Record "Member Ledger Entry";
        Loanreceipts: Decimal;
        DayDeposits: Decimal;
        Vendor: Record Vendor;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        OtherDeposits: Decimal;
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        Daywithdrawals: Decimal;
        OpenCashpayments: Decimal;
        Cashpayments: Decimal;
        EndCashpayments: Decimal;
        ClosingBankBalances: Decimal;
        ClosingTreasuryBalances: Decimal;
        ClosingTillBalances: Decimal;
        ClosingMobile: Decimal;
        ClosingFdrs: Decimal;
        BOSADeposits: Decimal;
        FOSADeposits: Decimal;
        TestDate: Date;
        GLFilter: Text;
        PeriodText: Text[30];
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        CashPayAmt: Decimal;
        OtherCashReceipts: Decimal;
        BOSADeposits1: Decimal;
        BOSADeposits2: Decimal;
        OpeningBankBalances1: Decimal;
        OpeningBankBalances2: Decimal;
        ClosingBankBalances1: Decimal;
        ClosingBankBalances2: Decimal;
        OtherCashpay: Decimal;
        GLAccEntry: Record "G/L Entry";
        SavingsMobile: Label 'WA01314404|WA01360804';
        OpeningBankBalance11: Label '14610|14620|14635';
        OpeningBankBalance22: Label '10920|10925';
        OpeningTreasuryBalances1: Label '14510';
        OpeningTillBalances1: Label '400-000-405|400-000-407|400-000-409|400-000-403|400-000-402';
        OpeningMobile1: Label '14640|14650|14680';
        OpeningFdrs1: Label '13750|13800|13850';
        OtherDeposits1: Label '''10914''';
        CashPayAmt1: Label ' 400-000-402';
        Cashpayments1: Label '''%1'',''40999''';
        BOSADeposits1L: Label '20099';
        DaywithdrawalsL: Label '400-000-402|500-100-310|400-000-412|400-000-416';
        OtherCashpayL: Label '400-000-402';
        FOSADepositsL: Label '20190';
        DayDepositsL: Label '400-000-402|500-100-310|400-000-410|400-000-416|400-000-418';
        CashierTransactions: Record "Teller Transaction";
        AgentTrans: Record "Agent Transactions";
        PaymentsHeader: Record "Payment Header";
        totpay: Decimal;
        ReceiptsHeader: Record "Receipt Header";
        ReceiptAmount: Decimal;
        deposits: Decimal;
        withrawals: Decimal;
        checkifreversed: Record "Savings Ledger Entry";
        depositss: Record "G/L Account";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        agencytransaction: Decimal;
        thiss: Decimal;
        agentwithdrawal: Decimal;
        Receipt2: Decimal;
        ENDDATE12: Date;
        DayDeposits122: Decimal;
        ATMTransactions: Record "Coop ATM Transaction";
        ATMTR12: Decimal;
        CTRCHARGES: Record "Savings Ledger Entry";
        CTRCHARGES12: Decimal;
        mpesaatmwithdr: Decimal;
}

