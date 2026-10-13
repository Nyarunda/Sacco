
Table 50166 "SMS Charges"
{

    fields
    {
        field(1; Source; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New Member,New Account,Loan Approval,Deposit Confirmation,Cash Withdrawal Confirm,Loan Application,Loan Appraisal,Loan Guarantors,Loan Rejected,Loan Posted,Loan defaulted,Salary Processing,Teller Cash Deposit,Teller Cash Withdrawal,Teller Cheque Deposit,Fixed Deposit Maturity,InterAccount Transfer,Account Status,Status Order,EFT Effected, ATM Application Failed,ATM Collection,MSACCO,Member Changes,Cashier Below Limit,Cashier Above Limit,Chq Book,Bankers Cheque,Teller Cheque Transfer,Defaulter Loan Issued,Bonus,Dividend,Bulk,Standing Order,Loan Bill Due,POS Deposit,Mini Bonus,Leave Application,Loan Witness,PV,CalMobile,CalPIN,Cheque Withdrawal';
            OptionMembers = "New Member","New Account","Loan Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit","Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued",Bonus,Dividend,Bulk,"Standing Order","Loan Bill Due","POS Deposit","Mini Bonus","Leave Application","Loan Witness",PV,CalMobile,CalPIN,"Cheque Withdrawal";
        }
        field(2; "Charge Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Charge G/L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; Source)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

