

enum 50691 "AML Transaction Type"
{
    Extensible = true;

    value(0; Deposit)
    {
        Caption = 'Deposit';
    }
    value(1; Withdrawal)
    {
        Caption = 'Withdrawal';
    }
    value(2; Transfer)
    {
        Caption = 'Transfer';
    }
    value(3; LoanDisbursement)
    {
        Caption = 'Loan Disbursement';
    }
    value(4; LoanRepayment)
    {
        Caption = 'Loan Repayment';
    }
    value(5; SharePurchase)
    {
        Caption = 'Share Purchase';
    }
    value(6; ShareSale)
    {
        Caption = 'Share Sale';
    }
    value(7; MobileBanking)
    {
        Caption = 'Mobile Banking';
    }
    value(8; CashTransaction)
    {
        Caption = 'Cash Transaction';
    }
    value(9; Other)
    {
        Caption = 'Other';
    }
}
