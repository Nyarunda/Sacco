codeunit 50392 "Bank Rec. Validation"
{
    procedure ValidateEndingBalance(var BankRecLine: Record "Bank Reconciliation Line")
    var
        BankRec: Record "Bank Reconciliation";
        TotalAmount: Decimal;
        ErrorMsg: Text;
    begin
        // Get header record
        if not BankRec.Get(BankRecLine."Document No.") then
            Error('Bank reconciliation header not found');

        // Calculate total from lines
        BankRecLine.Reset();
        BankRecLine.SetRange("Document No.", BankRec."No.");
        if BankRecLine.FindSet() then
            repeat
                TotalAmount += BankRecLine."Statement Amount";
            until BankRecLine.Next() = 0;

        // Compare with statement ending balance
        if BankRec."Statement Ending Balance" <> (BankRec."Balance Last Statement" + TotalAmount) then begin
            ErrorMsg := 'Balance mismatch:\';
            ErrorMsg += 'Statement Ending Balance: ' + Format(BankRec."Statement Ending Balance") + '\';
            ErrorMsg += 'Calculated Balance: ' + Format(BankRec."Balance Last Statement" + TotalAmount) + '\';
            ErrorMsg += 'Difference: ' + Format(BankRec."Statement Ending Balance" - (BankRec."Balance Last Statement" + TotalAmount));
            Error(ErrorMsg);
        end else
            Message('Bank reconciliation balances match.');
    end;

    procedure ValidateRequiredFields(var BankRecLine: Record "Bank Reconciliation Line")
    begin
        BankRecLine.TestField("Transaction Date");
        BankRecLine.TestField("Document Type");
        BankRecLine.TestField("Statement Amount");
    end;

    procedure CheckDuplicateReferences(var BankRecLine: Record "Bank Reconciliation Line")
    var
        TempBankRecLine: Record "Bank Reconciliation Line";
    begin
        if BankRecLine."Reference No." = '' then
            exit;

        TempBankRecLine.Reset();
        TempBankRecLine.SetRange("Document No.", BankRecLine."Document No.");
        TempBankRecLine.SetRange("Reference No.", BankRecLine."Reference No.");
        TempBankRecLine.SetFilter("Line No.", '<>%1', BankRecLine."Line No.");
        
        if not TempBankRecLine.IsEmpty then
            Error('Reference No. %1 already exists in this reconciliation.', BankRecLine."Reference No.");
    end;

    procedure ValidateAmountSign(var BankRecLine: Record "Bank Reconciliation Line")
    begin
        case BankRecLine."Document Type" of 
            BankRecLine."Document Type"::Payment:
                if BankRecLine."Statement Amount" > 0 then
                    Error('Payment amount must be negative');
            BankRecLine."Document Type"::Receipt:
                if BankRecLine."Statement Amount" < 0 then
                    Error('Receipt amount must be positive');
        end;
    end;
}