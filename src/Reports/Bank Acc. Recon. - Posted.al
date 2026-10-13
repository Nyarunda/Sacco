Report 50346 "Bank Acc. Recon. Posted"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Bank Acc. Recon. - Posted.rdlc';
    Caption = 'Bank Acc. Recon. - Posted';

    dataset
    {
        dataitem("Posted Bank Rec"; "Posted Bank Rec")
        {
            RequestFilterFields = "Statement No.";
            column(ReportForNavId_30; 30)
            {
            }
            column(BankCode; BankCode)
            {
            }
            column(BankAccountNo_BankAccReconciliation; "Posted Bank Rec"."Bank Account No.")
            {
            }
            column(StatementNo_BankAccReconciliation; "Posted Bank Rec"."Statement No.")
            {
            }
            column(StatementDate_BankAccReconciliation; "Posted Bank Rec"."Statement Date")
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(StatementEndingBalance_BankAccReconciliation; "Posted Bank Rec"."Statement Ending Balance")
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankAccountBalanceasperCashBook; BankAccountBalanceasperCashBook)
            {
            }
            column(UnpresentedChequesTotal; UnpresentedChequesTotal)
            {
            }
            column(UncreditedBanking; UncreditedBanking)
            {
            }
            column(ReconciliationStatement; ReconciliationStatement)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(RecCashBkBal; RecCashBkBal)
            {
            }
            column(NotesLine1_BankAccReconciliation; "Posted Bank Rec"."Notes Line 1")
            {
            }
            column(NotesLine2_BankAccReconciliation; "Posted Bank Rec"."Notes Line 2")
            {
            }
            column(NotesLine3_BankAccReconciliation; "Posted Bank Rec"."Notes Line 3")
            {
            }
            column(NotesLine4_BankAccReconciliation; "Posted Bank Rec"."Notes Line 4")
            {
            }
            column(NotesLine5_BankAccReconciliation; "Posted Bank Rec"."Notes Line 5")
            {
            }
            column(NotesLine6_BankAccReconciliation; "Posted Bank Rec"."Notes Line 6")
            {
            }
            column(DifferencesBW; DifferencesBW)
            {
            }
            column(DifferencesInBankTotal; DifferencesInBankTotal)
            {
            }
            column(Direct_Debits; DirectDebits)
            {
            }
            column(Direct_Credits; DirecCredits)
            {
            }
            dataitem(BankAccountLedgerEntry; "Posted Cashbook Lines")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                DataItemTableView = where(Open = const(true), Reversed = const(false));
                column(ReportForNavId_16; 16)
                {
                }
                column(StatementLineNo_BankAccountLedgerEntry; BankAccountLedgerEntry."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccountLedgerEntry; BankAccountLedgerEntry."Document No.")
                {
                }
                column(TransactionDate_BankAccountLedgerEntry; BankAccountLedgerEntry."Posting Date")
                {
                }
                column(Description_BankAccountLedgerEntry; BankAccountLedgerEntry.Description)
                {
                }
                column(StatementAmount_BankAccountLedgerEntry; BankAccountLedgerEntry.Amount)
                {
                }
                column(SNo; SNo)
                {
                }
                column(Remarks_BankAccountLedgerEntry; BankAccountLedgerEntry.Remarks)
                {
                }
                column(StatementDifference_BankAccountLedgerEntry; BankAccountLedgerEntry."Amount (LCY)" * -1)
                {
                }
                column(ExternalDocumentNo_BankAccountLedgerEntry; BankAccountLedgerEntry."External Document No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SNo += 1;
                end;

                trigger OnPreDataItem()
                begin
                    //Reconciled=CONST(No)
                    BankAccountLedgerEntry.SetFilter("Posting Date", '<=%1', "Posted Bank Rec"."Statement Date");
                    //BankAccountLedgerEntry.SETFILTER("Statement Difference",'<>%1',0);
                    //SETFILTER(Amount,'<%1',0);
                    //ADDED HERE
                    BankAccountLedgerEntry.SetRange("Statement No.", "Posted Bank Rec"."Statement No.");

                    SetFilter("Statement Difference", '<%1', 0);
                    //SetFilter("Amount (LCY)", '<%1', 0);
                    SetRange(Open, true);
                end;
            }
            dataitem(BankAccountLedgerEntry1; "Posted Cashbook Lines")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                DataItemTableView = where(Open = const(true), Reversed = const(false));
                column(ReportForNavId_8; 8)
                {
                }
                column(StatementLineNo_BankAccountLedgerEntry1; BankAccountLedgerEntry1."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccountLedgerEntry1; BankAccountLedgerEntry1."Document No.")
                {
                }
                column(TransactionDate_BankAccountLedgerEntry1; BankAccountLedgerEntry1."Posting Date")
                {
                }
                column(Description_BankAccountLedgerEntry1; BankAccountLedgerEntry1.Description)
                {
                }
                column(StatementAmount_BankAccountLedgerEntry1; BankAccountLedgerEntry1.Amount)
                {
                }
                column(SNo1; SNo1)
                {
                }
                column(Remarks_BankAccountLedgerEntry1; BankAccountLedgerEntry1.Remarks)
                {
                }
                column(StatementDifference_BankAccountLedgerEntry1; BankAccountLedgerEntry1."Amount (LCY)" * -1)
                {
                }
                column(ExternalDocumentNo_BankAccountLedgerEntry1; BankAccountLedgerEntry1."External Document No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SNo1 += 1;

                end;

                trigger OnPreDataItem()
                begin
                    //Reconciled=CONST(No)
                    //ADDED HERE
                    BankAccountLedgerEntry1.SetRange("Statement No.", "Posted Bank Rec"."Statement No.");

                    BankAccountLedgerEntry1.SetFilter("Posting Date", '<=%1', "Posted Bank Rec"."Statement Date");
                    //BankAccountLedgerEntry1.SETFILTER("Statement Difference",'<>%1',0);
                    SetFilter("Statement Difference", '>%1', 0);
                    //SetFilter("Amount (LCY)", '>%1', 0);
                end;
            }
            dataitem("Posted Bank Acc. Recon. Line"; "Posted Bank Acc. Recon. Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                DataItemTableView = where(Difference = filter(> 0));
                column(ReportForNavId_1000000002; 1000000002)
                {
                }
                column(StatementLineNo_BankAccReconciliationLine; "Posted Bank Acc. Recon. Line"."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine; "Posted Bank Acc. Recon. Line"."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine; "Posted Bank Acc. Recon. Line"."Transaction Date")
                {
                }
                column(Description_BankAccReconciliationLine; "Posted Bank Acc. Recon. Line".Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine; "Posted Bank Acc. Recon. Line"."Statement Amount")
                {
                }
                column(Difference_BankAccReconciliationLine; "Posted Bank Acc. Recon. Line".Difference)
                {
                }
                column(CheckNo_BankAccReconciliationLine; "Posted Bank Acc. Recon. Line"."Check No.")
                {
                }
                column(AdditionalTransactionInfo_BankAccReconciliationLine; "Posted Bank Acc. Recon. Line"."Additional Transaction Info")
                {
                }
            }
            dataitem(BankAccReconciliationLine1; "Posted Bank Acc. Recon. Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                DataItemTableView = where(Difference = filter(< 0));
                column(ReportForNavId_1000000015; 1000000015)
                {
                }
                column(StatementLineNo_BankAccReconciliationLine1; BankAccReconciliationLine1."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine1; BankAccReconciliationLine1."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine1; BankAccReconciliationLine1."Transaction Date")
                {
                }
                column(Description_BankAccReconciliationLine1; BankAccReconciliationLine1.Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine1; BankAccReconciliationLine1."Statement Amount")
                {
                }
                column(Difference_BankAccReconciliationLine1; BankAccReconciliationLine1.Difference)
                {
                }
                column(CheckNo_BankAccReconciliationLine1; BankAccReconciliationLine1."Check No.")
                {
                }
                column(AdditionalTransactionInfo_BankAccReconciliationLine1; BankAccReconciliationLine1."Additional Transaction Info")
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                BankAccountLedgerEntry2: Record "Posted Cashbook Lines";
                BankAccountRecLine: Record "Posted Bank Acc. Recon. Line";
            begin
                BankCode := '';
                BankAccountNo := '';
                BankName := '';
                BankAccountBalanceasperCashBook := 0;
                UnpresentedChequesTotal := 0;
                UncreditedBanking := 0;

                RecCashBkBal := 0;

                TotalDiffFunc();

                Bank.Reset;
                Bank.SetRange(Bank."No.", "Bank Account No.");
                if Bank.Find('-') then begin
                    BankCode := Bank."No.";
                    BankAccountNo := Bank."Bank Account No.";
                    BankName := Bank.Name;
                    Bank.SetRange(Bank."Date Filter", 0D, "Statement Date");
                    Bank.CalcFields(Bank."Net Change");
                    BankAccountBalanceasperCashBook := Bank."Net Change";
                    /*
                      BankStatementLine.RESET;
                      BankStatementLine.SETRANGE(BankStatementLine."Bank Account No.",Bank."No.");
                      BankStatementLine.SETRANGE(BankStatementLine."Statement No.","Statement No.");
                      BankStatementLine.SETRANGE(BankStatementLine.Reconciled,FALSE);
                      IF BankStatementLine.FIND('-') THEN REPEAT
                        IF BankStatementLine."Statement Amount"<0 THEN
                         UnpresentedChequesTotal:=UnpresentedChequesTotal+BankStatementLine."Statement Amount"
                        ELSE IF BankStatementLine."Statement Amount">0 THEN
                         UncreditedBanking:=UncreditedBanking+BankStatementLine."Statement Amount";
                      UNTIL BankStatementLine.NEXT=0;
                    */

                    BankStatementLine.Reset;
                    BankStatementLine.SetRange(BankStatementLine."Bank Account No.", Bank."No.");
                    BankStatementLine.SetRange(BankStatementLine."Statement No.", "Statement No.");
                    //BankStatementLine.SETRANGE(BankStatementLine.Reconciled,FALSE);
                    if BankStatementLine.Find('-') then
                        repeat
                            RecCashBkBal += BankStatementLine."Applied Amount";
                        until BankStatementLine.Next = 0;



                    BankAccountLedgerEntry2.Reset;
                    BankAccountLedgerEntry2.SetRange("Bank Account No.", Bank."No.");
                    BankAccountLedgerEntry2.SetRange(Open, true);
                    BankAccountLedgerEntry2.SetRange(Reversed, false);
                    //ADDED HERE
                    BankAccountLedgerEntry2.SetRange("Statement No.", "Posted Bank Rec"."Statement No.");

                    BankAccountLedgerEntry2.SetFilter("Posting Date", '<=%1', "Posted Bank Rec"."Statement Date");
                    BankAccountLedgerEntry2.SetFilter("Amount (LCY)", '<>%1', 0);
                    BankAccountLedgerEntry2.SetFilter("Statement Difference", '<>%1', 0);
                    BankAccountLedgerEntry2.SetRange(BankAccountLedgerEntry2."Statement Status", BankAccountLedgerEntry2."Statement Status"::"Bank Acc. Entry Applied");
                    if BankAccountLedgerEntry2.Find('-') then begin
                        repeat
                            BankAccountLedgerEntry2."Statement Difference" := 0;
                            BankAccountLedgerEntry2.Modify();
                        until BankAccountLedgerEntry2.Next() = 0;
                    end;

                    BankAccountLedgerEntry2.Reset;
                    BankAccountLedgerEntry2.SetRange("Bank Account No.", Bank."No.");
                    BankAccountLedgerEntry2.SetRange(Open, true);
                    BankAccountLedgerEntry2.SetRange(Reversed, false);
                    //ADDED HERE
                    BankAccountLedgerEntry2.SetRange("Statement No.", "Posted Bank Rec"."Statement No.");

                    BankAccountLedgerEntry2.SetFilter("Posting Date", '<=%1', "Posted Bank Rec"."Statement Date");
                    BankAccountLedgerEntry2.SetFilter("Amount (LCY)", '<>%1', 0);
                    BankAccountLedgerEntry2.SetFilter("Statement Difference", '%1', 0);
                    BankAccountLedgerEntry2.SetFilter(BankAccountLedgerEntry2."Statement Status", '<>%1', BankAccountLedgerEntry2."Statement Status"::"Bank Acc. Entry Applied");
                    if BankAccountLedgerEntry2.Find('-') then begin
                        repeat
                            BankAccountLedgerEntry2."Statement Difference" := BankAccountLedgerEntry2."Amount (LCY)";
                            BankAccountLedgerEntry2.Modify();
                        until BankAccountLedgerEntry2.Next() = 0;
                    end;


                    BankAccountLedgerEntry2.Reset;
                    BankAccountLedgerEntry2.SetRange("Bank Account No.", Bank."No.");
                    BankAccountLedgerEntry2.SetRange(Open, true);
                    //ADDED HERE
                    BankAccountLedgerEntry2.SetRange("Statement No.", "Posted Bank Rec"."Statement No.");

                    BankAccountLedgerEntry2.SetRange(Reversed, false);
                    BankAccountLedgerEntry2.SetFilter("Posting Date", '<=%1', "Posted Bank Rec"."Statement Date");
                    //BankAccountLedgerEntry2.SetFilter("Amount (LCY)", '<>%1', 0);
                    BankAccountLedgerEntry2.SetFilter("Statement Difference", '<>%1', 0);
                    if BankAccountLedgerEntry2.Find('-') then
                        repeat

                            if BankAccountLedgerEntry2."Amount (LCY)" < 0 then
                                UnpresentedChequesTotal := UnpresentedChequesTotal + BankAccountLedgerEntry2."Amount (LCY)"
                            else
                                if BankAccountLedgerEntry2."Amount (LCY)" > 0 then
                                    UncreditedBanking := UncreditedBanking + BankAccountLedgerEntry2."Amount (LCY)";
                        until BankAccountLedgerEntry2.Next = 0;

                    UnpresentedChequesTotal := UnpresentedChequesTotal * -1;
                    //UncreditedBanking := UncreditedBanking * -1;

                    BankStatBalance := "Posted Bank Rec"."Statement Ending Balance";

                    DifferencesBW := 0;
                    /*BankAccReconciliationLine.RESET;
                    BankAccReconciliationLine.SETRANGE(BankAccReconciliationLine."Bank Account No.","Posted Bank Rec"."Bank Account No.");
                    BankAccReconciliationLine.SETRANGE(BankAccReconciliationLine."Statement No.","Posted Bank Rec"."Statement No.");
                    BankAccReconciliationLine.SETRANGE(Imported,FALSE);
                    BankAccReconciliationLine.SETRANGE(BankAccReconciliationLine.Type,BankAccReconciliationLine.Type::"Posted Cashbook Lines");
                    BankAccReconciliationLine.SETFILTER("Applied Amount",'<>%1',0);
                    IF BankAccReconciliationLine.FINDSET THEN
                    BEGIN
                      BankAccReconciliationLine.CALCSUMS(Difference);
                      DifferencesBW := BankAccReconciliationLine.Difference;
                    END;
                    */
                    DifferencesInBankTotal := 0;
                    BankAccReconciliationLine2.Reset;
                    BankAccReconciliationLine2.SetRange(BankAccReconciliationLine2."Bank Account No.", "Posted Bank Rec"."Bank Account No.");
                    BankAccReconciliationLine2.SetRange(BankAccReconciliationLine2."Statement No.", "Posted Bank Rec"."Statement No.");
                    //ADDED HERE
                    BankAccountLedgerEntry2.SetRange("Statement No.", "Posted Bank Rec"."Statement No.");

                    BankAccReconciliationLine2.SetFilter(Difference, '<>%1', 0);
                    if BankAccReconciliationLine2.FindSet then begin
                        repeat
                            if BankAccReconciliationLine2.Difference > 0 then begin
                                //BankAccReconciliationLine2.CALCSUMS(Difference);
                                DirecCredits := DirecCredits + BankAccReconciliationLine2.Difference
                            end else begin
                                //BankAccReconciliationLine2.CALCSUMS(Difference);
                                DirectDebits := DirectDebits + BankAccReconciliationLine2.Difference;
                            end;

                            BankAccReconciliationLine2.CalcSums(Difference);

                            DifferencesInBankTotal := BankAccReconciliationLine2.Difference;
                        until BankAccReconciliationLine2.Next = 0
                    end;

                    if ((BankAccountBalanceasperCashBook + UnpresentedChequesTotal - UncreditedBanking) + TotalDifference - DifferencesBW = "Statement Ending Balance") then
                        ReconciliationStatement := ''
                    else
                        ReconciliationStatement := 'Reconciliation is incomplete please go through it again';
                end;

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
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

    trigger OnPreReport()
    begin
        //BankAccReconFilter := "Posted Bank Rec".GETFILTERS;
    end;

    var
        Text000: label '%1 must be specified.';
        Text001: label '%1 is not equal to Total Balance.';
        Text002: label '%1 must be %2 for %3 %4.';
        Text003: label '%1 %2 does not exist.';
        Text004: label '%1 must be %2.';
        Text005: label 'Application is wrong.';
        Text006: label 'The total difference is %1. It must be %2.';
        Bank_Account_Statement___TestCaptionLbl: label 'Bank Account Statement - Test';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Bank_Acc__Reconciliation___Balance_Last_Statement_CaptionLbl: label 'Balance Last Statement';
        Bank_Acc__Reconciliation___Statement_Date_CaptionLbl: label 'Statement Date';
        Bank_Acc__Reconciliation___Statement_Ending_Balance_CaptionLbl: label 'Statement Ending Balance';
        ErrorText_Number_CaptionLbl: label 'Warning!';
        Bank_Acc__Reconciliation_Line__Transaction_Date_CaptionLbl: label 'Transaction Date';
        Bank_Acc__Reconciliation_Line__Value_Date_CaptionLbl: label 'Value Date';
        TotalsCaptionLbl: label 'Totals';
        ErrorText_Number__Control97CaptionLbl: label 'Warning!';
        ErrorText_Number__Control31CaptionLbl: label 'Warning!';
        Bank: Record "Bank Account";
        BankCode: Code[20];
        BankAccountNo: Code[20];
        BankName: Text;
        BankAccountBalanceasperCashBook: Decimal;
        UnpresentedChequesTotal: Decimal;
        UncreditedBanking: Decimal;
        BankStatementLine: Record "Posted Bank Acc. Recon. Line";
        CompanyInfo: Record "Company Information";
        ReconciliationStatement: Text;
        TotalDifference: Decimal;
        BankRecPresented: Record "Posted Bank Acc. Recon. Line";
        BankRecUnPresented: Record "Posted Bank Acc. Recon. Line";
        BankStatBalance: Decimal;
        RecCashBkBal: Decimal;
        SNo: Integer;
        SNo1: Integer;
        DifferencesBW: Decimal;
        BankAccReconciliationLine: Record "Posted Bank Acc. Recon. Line";
        DifferencesInBankTotal: Decimal;
        BankAccReconciliationLine2: Record "Posted Bank Acc. Recon. Line";
        DirectDebits: Decimal;
        DirecCredits: Decimal;

    local procedure AddError(Text: Text[250])
    begin
        /*
        ErrorCounter := ErrorCounter + 1;
        ErrorText[ErrorCounter] := Text;
        */

    end;


    procedure TotalDiffFunc()
    begin
        BankRecPresented.Reset;
        BankRecPresented.SetRange(BankRecPresented."Bank Account No.", "Posted Bank Rec"."Bank Account No.");
        BankRecPresented.SetRange(BankRecPresented."Statement No.", "Posted Bank Rec"."Statement No.");
        //BankRecPresented.SETRANGE(BankRecPresented.Reconciled,TRUE);
        if BankRecPresented.Find('-') then
            repeat
                TotalDifference := TotalDifference + BankRecPresented.Difference;
            until BankRecPresented.Next = 0;
        //MESSAGE('%1',TotalDifference);
    end;
}

