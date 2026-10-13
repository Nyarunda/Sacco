report 50399 "TELLER REPORT SUMMARY"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/TELLER REPORT SUMMARY.rdlc';

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(MpesaDeposit; MpesaDeposit)
            {
            }
            column(IssueFromTreasury; IssueFromTreasury)
            {
            }
            column(CreditMemberCredits; CreditMemberCredits)
            {
            }
            column(CreditMemberDebits; CreditMemberDebits)
            {
            }
            column(CustomerLedgerCredits; CustomerLedgerCredits)
            {
            }
            column(CustomerLedgerDebits; CustomerLedgerDebits)
            {
            }
            column(MpesaWithdrawal; MpesaWithdrawal)
            {
            }
            column(ReturnToTreasury; ReturnToTreasury)
            {
            }
            column(OtherPayments; OtherPayments)
            {
            }
            column(ChequeDeposits; ChequeDeposits)
            {
            }
            column(Receipts; Receipts)
            {
            }
            column(Payments; Payments)
            {
            }
            column(CName; CI.Name)
            {
            }
            column(CPicture; CI.Picture)
            {
            }
            column(Deposit; Counter[1]) { }
            column(FromTreasury; Counter[3]) { }
            column(LoanRepayment; Counter[4]) { }
            column(ChequeDeposit; Counter[7]) { }
            column(Withdrawal; Counter[6]) { }
            column(TellerTre; Counter[9]) { }


            trigger OnAfterGetRecord()
            begin
                IssueFromTreasury := 0;
                MpesaDeposit := 0;
                MpesaWithdrawal := 0;
                CreditMemberCredits := 0;
                CreditMemberDebits := 0;
                CustomerLedgerCredits := 0;
                CustomerLedgerDebits := 0;
                ReturnToTreasury := 0;
                ChequeDeposits := 0;
                Receipts := 0;
                Payments := 0;

                for i := 1 to 6 do begin
                    Counter[i] := 0;
                end;

                CashTrans.Reset;
                CashTrans.SetRange(Mpesa, true);
                CashTrans.SetRange("Transaction Date", StartDate, EndDate);
                CashTrans.SetRange("Mpesa/Agent Transaction", CashTrans."Mpesa/Agent Transaction"::Deposit);
                CashTrans.SetRange(Cashier, Teller);
                CashTrans.SetRange(Posted, true);
                if CashTrans.FindFirst then begin
                    CashTrans.CalcSums(Amount);
                    MpesaDeposit += CashTrans.Amount;
                    Counter[1] := CashTrans.Count;
                end;

                CashTrans.Reset;
                CashTrans.SetRange(Mpesa, true);
                CashTrans.SetRange("Transaction Date", StartDate, EndDate);
                CashTrans.SetRange("Mpesa/Agent Transaction", CashTrans."Mpesa/Agent Transaction"::Withdrawal);
                CashTrans.SetRange(Cashier, Teller);
                CashTrans.SetRange(Posted, true);
                if CashTrans.FindFirst then begin
                    CashTrans.CalcSums(Amount);
                    MpesaWithdrawal += CashTrans.Amount;
                    Counter[2] := CashTrans.Count;
                end;

                TreasuryCashTrans.Reset;
                TreasuryCashTrans.SetRange("Transaction Date", StartDate, EndDate);
                TreasuryCashTrans.SetRange("Transaction Type", TreasuryCashTrans."Transaction Type"::"Treasury To Teller");
                TreasuryCashTrans.SetRange("Captured By", Teller);
                TreasuryCashTrans.SetRange(Posted, true);
                if TreasuryCashTrans.FindFirst then begin
                    TreasuryCashTrans.CalcSums(Amount);
                    IssueFromTreasury := TreasuryCashTrans.Amount;
                    Counter[3] := CashTrans.Count;
                end;

                LedgerCredit.Reset;
                LedgerCredit.SetRange("Transaction Type", LedgerCredit."Transaction Type"::"Principal Repayment");
                LedgerCredit.SetRange("Posting Date", StartDate, EndDate);
                LedgerCredit.SetRange("User ID", Teller);
                if LedgerCredit.FindFirst then begin
                    LedgerCredit.CalcSums(Amount);
                    CreditMemberCredits := -LedgerCredit.Amount;
                    Counter[4] := CashTrans.Count;
                end;

                LedgerSavings.Reset;
                LedgerSavings.SetRange("Posting Date", StartDate, EndDate);
                LedgerSavings.SetFilter(Amount, '<%1', 0);
                LedgerSavings.SetRange("User ID", Teller);
                if LedgerSavings.FindFirst then begin
                    LedgerSavings.CalcSums(Amount);
                    CustomerLedgerCredits := -LedgerSavings.Amount;
                    Counter[5] := LedgerSavings.Count;
                end;

                CashTrans.Reset;
                CashTrans.SetRange(Type, CashTrans.Type::"Cash Withdrawal");
                CashTrans.SetRange("Transaction Date", StartDate, EndDate);
                CashTrans.SetRange(Cashier, Teller);
                CashTrans.SetRange(Posted, true);
                if CashTrans.FindFirst then begin
                    CashTrans.CalcSums(Amount);
                    CustomerLedgerDebits += CashTrans.Amount;
                    Counter[6] := CashTrans.Count;
                end;

                CashTrans.Reset;
                CashTrans.SetRange(Type, CashTrans.Type::"Cheque Deposit");
                CashTrans.SetRange("Transaction Date", StartDate, EndDate);
                CashTrans.SetRange(Cashier, Teller);
                CashTrans.SetRange(Posted, true);
                if CashTrans.FindFirst then begin
                    CashTrans.CalcSums(Amount);
                    ChequeDeposits += CashTrans.Amount;
                    Counter[7] := CashTrans.Count;
                end;

                PaymentsHeader.Reset;
                PaymentsHeader.SetAutoCalcFields("Total Payment Amount");
                PaymentsHeader.SetRange("Payment Type", PaymentsHeader."Payment Type"::"Petty Cash");
                PaymentsHeader.SetRange(Cashier, Teller);
                PaymentsHeader.SetRange(Date, StartDate, EndDate);
                if PaymentsHeader.FindFirst then begin
                    OtherPayments := PaymentsHeader."Total Payment Amount";
                    Counter[8] := PaymentsHeader.Count;
                end;


                TreasuryCashTrans.Reset;
                TreasuryCashTrans.SetRange("Transaction Date", StartDate, EndDate);
                TreasuryCashTrans.SetRange("Transaction Type", TreasuryCashTrans."Transaction Type"::"Teller To Treasury");
                TreasuryCashTrans.SetRange("Captured By", Teller);
                TreasuryCashTrans.SetRange(Posted, true);
                if TreasuryCashTrans.FindFirst then begin
                    TreasuryCashTrans.CalcSums(Amount);
                    ReturnToTreasury := TreasuryCashTrans.Amount;
                    Counter[9] := TreasuryCashTrans.Count;
                end;

                Receipts := IssueFromTreasury + MpesaDeposit + CreditMemberCredits + CustomerLedgerCredits;
                Payments := CustomerLedgerDebits + MpesaWithdrawal + OtherPayments + ReturnToTreasury;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
                field(Teller; Teller)
                {
                    ApplicationArea = All;
                    Caption = 'Teller';
                    TableRelation = "Banking User Setup"."User Name";
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
        CI.Get;
        CI.CalcFields(Picture);
    end;

    var
        IssueFromTreasury: Decimal;
        MpesaDeposit: Decimal;
        CashTrans: Record "Teller Transaction";
        TreasuryCashTrans: Record "Treasury/Teller Transactions";
        StartDate: Date;
        EndDate: Date;
        MpesaWithdrawal: Decimal;
        LedgerSavings: Record "Savings Ledger Entry";
        LedgerCredit: Record "Credit Ledger Entry";
        CreditMemberCredits: Decimal;
        CustomerLedgerCredits: Decimal;
        CreditMemberDebits: Decimal;
        CustomerLedgerDebits: Decimal;
        ReturnToTreasury: Decimal;
        OtherPayments: Decimal;
        PaymentsHeader: Record "Payment Header";
        ChequeDeposits: Decimal;
        Receipts: Decimal;
        Payments: Decimal;
        CI: Record "Company Information";
        Teller: Code[50];
        Counter: array[10] of integer;
        i: Integer;
}

