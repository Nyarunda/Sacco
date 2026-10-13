Report 50301 "EOD Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/EOD Report.rdlc';

    dataset
    {
        dataitem("Treasury Transactions"; "Treasury/Teller Transactions")
        {
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(No_TreasuryTransactions; "Treasury Transactions".Code)
            {
            }
            column(TransactionDate_TreasuryTransactions; Format("Treasury Transactions"."Transaction Date"))
            {
            }
            column(TransactionType_TreasuryTransactions; "Treasury Transactions"."Transaction Type")
            {
            }
            column(ToAccountName_TreasuryTransactions; "Treasury Transactions"."To Account Name")
            {
            }
            column(TInterTeller; TInterTeller)
            {
            }
            column(TCashDeposit; TCashDeposit)
            {
            }
            column(TCashWithdrawals; TCashWithdrawal)
            {
            }
            column(TissuetoTeller; TissuetoTeller)
            {
            }
            column(TotalReceipts; TotalReceipts)
            {
            }
            column(TotalAmountReceived; TotalAmountReceived)
            {
            }
            column(Tcheques; Tcheques)
            {
            }
            column(TotalPayment; TotalPayment)
            {
            }
            column(ActualCashAtHand_TreasuryTransactions; "Treasury Transactions"."Actual Cash At Hand")
            {
            }
            column(FromAccountName_TreasuryTransactions; "Treasury Transactions"."From Account Name")
            {
            }
            column(FromAccount_TreasuryTransactions; "Treasury Transactions"."From Account")
            {
            }
            column(ToAccount_TreasuryTransactions; "Treasury Transactions"."To Account")
            {
            }
            column(Description_TreasuryTransactions; "Treasury Transactions".Description)
            {
            }
            column(Amount_TreasuryTransactions; "Treasury Transactions".Amount)
            {
            }
            column(Posted_TreasuryTransactions; "Treasury Transactions".Posted)
            {
            }
            column(DatePosted_TreasuryTransactions; "Treasury Transactions"."Date Posted")
            {
            }
            column(TimePosted_TreasuryTransactions; "Treasury Transactions"."Time Posted")
            {
            }
            column(PostedBy_TreasuryTransactions; "Treasury Transactions"."Posted By")
            {
            }
            column(NoSeries_TreasuryTransactions; "Treasury Transactions"."No. Series")
            {
            }
            column(TransactionTime_TreasuryTransactions; "Treasury Transactions"."Transaction Time")
            {
            }
            column(CoinageAmount_TreasuryTransactions; "Treasury Transactions"."Denomination Total")
            {
            }
            column(CurrencyCode_TreasuryTransactions; "Treasury Transactions"."Currency Code")
            {
            }
            column(Issued_TreasuryTransactions; "Treasury Transactions".Issued)
            {
            }
            column(DateIssued_TreasuryTransactions; "Treasury Transactions"."Date Issued")
            {
            }
            column(TimeIssued_TreasuryTransactions; "Treasury Transactions"."Time Issued")
            {
            }
            column(IssueReceived_TreasuryTransactions; "Treasury Transactions"."Issue Received")
            {
            }
            column(DateReceived_TreasuryTransactions; "Treasury Transactions"."Date Received")
            {
            }
            column(TimeReceived_TreasuryTransactions; "Treasury Transactions"."Time Received")
            {
            }
            column(IssuedBy_TreasuryTransactions; "Treasury Transactions"."Issued By")
            {
            }
            column(ReceivedBy_TreasuryTransactions; "Treasury Transactions"."Received By")
            {
            }
            column(Received_TreasuryTransactions; "Treasury Transactions".Received)
            {
            }
            column(RequestNo_TreasuryTransactions; '')
            {
            }
            column(BankNo_TreasuryTransactions; '')
            {
            }
            column(ExternalDocumentNo_TreasuryTransactions; "Treasury Transactions"."External Document No.")
            {
            }
            column(ChequeNo_TreasuryTransactions; '')
            {
            }
            column(TransactingBranch_TreasuryTransactions; "Treasury Transactions"."Global Dimension 2 Code")
            {
            }
            column(Approved_TreasuryTransactions; "Treasury Transactions".Status)
            {
            }
            column(EndofDayTransTime_TreasuryTransactions; "Treasury Transactions"."Time Posted")
            {
            }
            column(EndofDay_TreasuryTransactions; '')
            {
            }
            column(LastTransaction_TreasuryTransactions; '')
            {
            }
            column(TotalCashonTreasuryCoinage_TreasuryTransactions; "Treasury Transactions"."Total Cash on Treasury Coinage")
            {
            }
            column(TillTreasuryBalance_TreasuryTransactions; "Treasury Transactions"."To Balance")
            {
            }
            column(ExcessShortageAmount_TreasuryTransactions; "Treasury Transactions"."Excess/Shortage Amount")
            {
            }
            column(Bank_Name; Bank.Name)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(BalanceBF; BalanceBF)
            {
            }
            column(AddReceipts; AddReceipts)
            {
            }
            column(LessPayments; LessPayments)
            {
            }
            column(Cheques; Cheques)
            {
            }
            column(ChequesCount; ChequesCount)
            {
            }
            column(Bcheque; Bcheque)
            {
            }
            column(BchequeCount; BchequeCount)
            {
            }
            column(From_Account; "From Account")
            {
            }
            dataitem("Treasury Coinage"; Coinage)
            {
                DataItemLink = No = field(COde);
                column(ReportForNavId_1102755001; 1102755001)
                {
                }
                column(No_TreasuryCoinage; "Treasury Coinage".No)
                {
                }
                column(Code_TreasuryCoinage; "Treasury Coinage".Code)
                {
                }
                column(Description_TreasuryCoinage; "Treasury Coinage".Description)
                {
                }
                column(Type_TreasuryCoinage; "Treasury Coinage".Type)
                {
                }
                column(Value_TreasuryCoinage; "Treasury Coinage".Value)
                {
                }
                column(Quantity_TreasuryCoinage; "Treasury Coinage".Quantity)
                {
                }
                column(TotalAmount_TreasuryCoinage; "Treasury Coinage"."Total Amount")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.Get;

                //TInterTeller:=0;
                issuetoTeller := 0;
                InterTeller := 0;


                TreasuryTrans.Reset;
                //TreasuryTrans.SETRANGE(TreasuryTrans.No,"Treasury Transactions".No);
                //TreasuryTrans.SETRANGE(TreasuryTrans."From Account","From Account");
                TreasuryTrans.SetRange(TreasuryTrans."Date Posted", "Treasury Transactions"."Date Posted");
                TreasuryTrans.SetRange(TreasuryTrans."Transaction Type", TreasuryTrans."transaction type"::"Teller to Teller");
                if TreasuryTrans.Find('-') then begin
                    repeat
                        InterTeller := TreasuryTrans.Amount * -1;
                        TInterTeller := TInterTeller + InterTeller;
                    // MESSAGE(FORMAT(TInterTeller));
                    until TreasuryTrans.Next = 0;
                end;



                TreasuryTrans.Reset;
                //TreasuryTrans.SETRANGE(TreasuryTrans."Posted By","Posted By");
                TreasuryTrans.SetRange(TreasuryTrans."From Account", "To Account");
                TreasuryTrans.SetRange(TreasuryTrans."Date Posted", "Treasury Transactions"."Date Posted");
                TreasuryTrans.SetRange(TreasuryTrans."Transaction Type", TreasuryTrans."transaction type"::"Treasury To Teller");
                if TreasuryTrans.Find('-') then begin
                    repeat
                        issuetoTeller := TreasuryTrans.Amount;
                        TissuetoTeller := TissuetoTeller + issuetoTeller;

                    until TreasuryTrans.Next = 0;
                end;


                CashDeposit := 0;


                CashDep.Reset;
                CashDep.SetRange(CashDep.Cashier, "Treasury Transactions"."Issued By");
                CashDep.SetRange(CashDep."Date Posted", "Treasury Transactions"."Date Posted");
                CashDep.SetRange(CashDep.Type, CashDep.Type::"Cash Deposit");
                if CashDep.Find('-') then begin
                    repeat
                        CashDeposit := CashDep.Amount;
                        TCashDeposit := TCashDeposit + CashDeposit;
                    until CashDep.Next = 0;
                end;

                CashWithdrawal := 0;

                CashDep.Reset;
                CashDep.SetRange(CashDep.Cashier, "Treasury Transactions"."Issued By");
                CashDep.SetRange(CashDep."Date Posted", "Treasury Transactions"."Date Posted");
                CashDep.SetRange(CashDep.Type, CashDep.Type::"Cash Withdrawal");
                if CashDep.Find('-') then begin
                    repeat
                        CashWithdrawal := CashDep.Amount;
                        TCashWithdrawal := TCashWithdrawal + CashWithdrawal;
                    until CashDep.Next = 0;
                end;

                FReceiptAm := 0;

                Receipts.Reset;
                Receipts.SetRange(Receipts."Posted By", "Posted By");
                Receipts.SetRange(Receipts."Date Posted", "Date Posted");
                if Receipts.Find('-') then begin
                    repeat
                        FReceiptAm := Receipts."Amount Recieved";
                        TFReceiptAm := TFReceiptAm + FReceiptAm;
                    until Receipts.Next = 0;
                end;



                BReceiptAm := 0;
                BosaReceipts.Reset;
                //BosaReceipts.SETRANGE(BosaReceipts."Employer No.","From Account");
                BosaReceipts.SetRange(BosaReceipts."Date Posted", "Date Posted");
                if BosaReceipts.Find('-') then begin
                    repeat
                        BReceiptAm := BosaReceipts."Amount Recieved";
                        TBReceiptAm := TBReceiptAm + BReceiptAm;
                    until BosaReceipts.Next = 0;
                end;
                TotalReceipts := TFReceiptAm + TBReceiptAm;
                //MESSAGE('TotalReceipts is %1',TotalReceipts);


                TotalAmountReceived := TotalReceipts + TCashDeposit + TissuetoTeller;


                TotalPayment := TCashWithdrawal;

                //Amount into words
                CheckReport.InitTextVariable;
                //CALCFIELDS("Actual Cash At Hand");
                CheckReport.FormatNoText(NumberText, Amount, '');
                //opening balance
                BankLedger.Reset;
                BankLedger.SetRange("Bank Account No.", "Treasury Transactions"."From Bank");
                BankLedger.SetFilter("Posting Date", '<=%1', "Treasury Transactions"."Date Posted");
                BankLedger.CalcSums(Amount);
                BalanceBF := BankLedger.Amount;
                /*
           //opening balance
           BankLedger.RESET;
           BankLedger.SETRANGE("Bank Account No.","Treasury Transactions"."To Account");
           BankLedger.SETRANGE("Posting Date","Treasury Transactions"."Date Posted");
           BankLedger.SETRANGE (BankLedger."User ID","Treasury Transactions"."Issued By");
           BankLedger.SETRANGE (BankLedger.Reversed,FALSE);
           BankLedger.SETFILTER("Document No.",'<>%1',"Treasury Transactions".No);
           IF BankLedger.FIND('+') THEN
           MESSAGE('%1 AND %2',BankLedger.Amount,"Treasury Transactions"."Date Posted");
                     */


                //transactions
                BankLedger.Reset;
                BankLedger.SetRange("Bank Account No.", "Treasury Transactions"."From Bank");
                BankLedger.SetRange("Posting Date", "Treasury Transactions"."Date Posted");
                BankLedger.SetRange(BankLedger."User ID", "Treasury Transactions"."Issued By");
                BankLedger.SetRange(BankLedger.Reversed, false);
                BankLedger.SetFilter("Document No.", '<>%1', "Treasury Transactions".Code);
                if BankLedger.FindSet then
                    repeat
                        if BankLedger.Amount > 0 then begin

                            if CopyStr(BankLedger."External Document No.", 1, 2) <> 'TR' then begin
                                AddReceipts += BankLedger.Amount
                            end else
                                if CopyStr(BankLedger."External Document No.", 1, 2) = 'TR' then
                                    AddReceipts += BankLedger.Amount
                                else
                                    Cheques += BankLedger.Amount;
                        end
                        else begin
                            LessPayments += BankLedger.Amount;
                        end
                    until BankLedger.Next = 0;



                CashDep.Reset;
                CashDep.SetRange(CashDep.Cashier, "Treasury Transactions"."Issued By");
                CashDep.SetRange(CashDep."Date Posted", "Treasury Transactions"."Date Posted");
                CashDep.SetRange(CashDep.Type, CashDep.Type::"Cheque Deposit");
                if CashDep.Find('-') then begin
                    repeat

                        //Aziz
                        //if CashDep.Status <> CashDep.Status::Stopped then begin
                        Cheques := CashDep.Amount;
                        Tcheques := Tcheques + Cheques;
                        ChequesCount += 1;

                    //end;

                    until CashDep.Next = 0;
                end;

                CashDep.RESET;
                CashDep.SetRange(CashDep.Cashier, "Treasury Transactions"."Issued By");
                CashDep.SETRANGE(CashDep."Date Posted", "Treasury Transactions"."Date Posted");
                CashDep.SETRANGE(CashDep.Type, CashDep.Type::"Bankers Cheque");
                IF CashDep.FIND('-') THEN BEGIN
                    REPEAT
                        Bcheque := Bcheque + CashDep.Amount;
                        BchequeCount += 1;
                    UNTIL CashDep.NEXT = 0;
                END;



            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        TreasuryTrans: Record "Treasury/Teller Transactions";
        TInterTeller: Decimal;
        CashDep: Record "Teller Transaction";
        TCashDeposit: Decimal;
        TCashWithdrawal: Decimal;
        TissuetoTeller: Decimal;
        issuetoTeller: Decimal;
        InterTeller: Decimal;
        CashDeposit: Decimal;
        CashWithdrawal: Decimal;
        Receipts: Record "Receipt Header";
        BosaReceipts: Record "Receipt Header";
        FReceiptAm: Decimal;
        TFReceiptAm: Decimal;
        BReceiptAm: Decimal;
        TBReceiptAm: Decimal;
        TotalReceipts: Decimal;
        TotalAmountReceived: Decimal;
        TotalPayment: Decimal;
        Bank: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        NumberText: array[2] of Text[120];
        CheckReport: Report Check;
        BankLedger: Record "Bank Account Ledger Entry";
        BalanceBF: Decimal;
        AddReceipts: Decimal;
        LessPayments: Decimal;
        Cheques: Decimal;
        ChequesCount: Decimal;
        Tcheques: Decimal;
        InterTellerr: Decimal;
        Bcheque: Decimal;
        TBcheque: Decimal;
        BchequeCount: Decimal;
}

