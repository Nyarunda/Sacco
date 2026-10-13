
Table 50165 "Transaction Charges"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = 'Cash Deposit,Cash Withdrawal,Credit Receipt,Credit Cheque,Bankers Cheque,Cheque Deposit,Cheque Withdrawal,Salary Processing,EFT,RTGS,Overdraft,Standing Order,Dividend Processing,CalMobile,CalMobile Deposit,CalMobile Ministatement,CalMobile Transfer,CalMobile Withdrawal,CalMobile Registration,CalMobile Charge,Transfers,ATM Applications,Member Withdrawal,ATM Replacement,Statement,Bounced Cheque,Lien,Cheque Application,Bank Transfer Mode,Sacco_Co-op Charge,Savings Penalty,Delegates Payment,CalMobile Sms,Income Transactions,Cheque Unpay,Inhouse Cheque Transfer,Mobile Transaction,CalMobile Utility Payment,Sky Mobile,Loan Changes,Bankers Cheque GL,Account Closure, Account Activation,Share Exit,Share Trading,Cash Deposit Customer,Cash Withdrawal Customer,MBanking Application';
            OptionMembers = "Cash Deposit","Cash Withdrawal","Credit Receipt","Credit Cheque","Bankers Cheque","Cheque Deposit","Cheque Withdrawal","Salary Processing",EFT,RTGS,Overdraft,"Standing Order","Dividend Processing",CalMobile,"CalMobile Deposit","CalMobile Ministatement","CalMobile Transfer","CalMobile Withdrawal","CalMobile Registration","CalMobile Charge",Transfers,"ATM Applications","Member Withdrawal","ATM Replacement",Statement,"Bounced Cheque",Lien,"Cheque Application","Bank Transfer Mode","Sacco_Co-op Charge","Savings Penalty","Delegates Payment","CalMobile Sms","Income Transactions","Cheque Unpay","Inhouse Cheque Transfer","Mobile Transaction","CalMobile Utility Payment","Sky Mobile","Loan Changes","Bankers Cheque GL","Account Closure","Account Activation","Share Exit","Share Trading","Cash Deposit Customer","Cash Withdrawal Customer","MBanking Application";
        }
        field(4; "Product Type"; Code[20])
        {
            TableRelation = "Product Setup"."Product ID" where("Product Class" = const(Savings));

            trigger OnValidate()
            var
                ProductSetup: Record "Product Setup";
            begin
                if ProductSetup.Get("Product Type") then
                    "Product Name" := ProductSetup.Description;
            end;
        }
        field(5; "Default Mode"; Option)
        {
            OptionCaption = 'Cash,Cheque';
            OptionMembers = Cash,Cheque;
        }
        field(13; "Product Name"; Text[50])
        {
            Editable = false;
        }
        field(14; "Upper Limit"; Decimal)
        {
        }
        field(15; Category; Option)
        {
            OptionCaption = ' ,Cashier';
            OptionMembers = " ",Cashier;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

