Table 50388 "Sky Agency Setup"
{

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Vendor Commission Account"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(3; "Sacco Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(4; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(5; "Transaction Type"; Option)
        {
            OptionCaption = ',Cash Withdrawal,Cash Deposit,Account Balance,Account Statement,Loan Repayment';
            OptionMembers = ,"Cash Withdrawal","Cash Deposit","Account Balance","Account Statement","Loan Repayment";
        }
        field(6; "Vendor Commission"; Decimal)
        {
        }
        field(7; "Sacco Fee"; Decimal)
        {
        }
        field(8; "Safaricom Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(9; "Safaricom Fee"; Decimal)
        {
        }
        field(10; "Pre-Payment Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(11; "SMS Charge"; Decimal)
        {
        }
        field(12; "SMS Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(13; "Transaction Limit"; Decimal)
        {

            trigger OnLookup()
            begin
                if "Transaction Limit" > 0 then begin
                    if ("Transaction Type" <> "transaction type"::"Cash Withdrawal") and ("Transaction Type" <> "transaction type"::"Account Balance") then
                        Error('This option is not applicable for this transaction');
                end;
            end;
        }
        field(14; "Non-Member Debit Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(15; "Daily Limit"; Decimal)
        {
        }
        field(16; "Weekly Limit"; Decimal)
        {
        }
        field(17; "Monthly Limit"; Decimal)
        {
        }
        field(18; "Staggered Charge Code"; Code[20])
        {
            TableRelation = "Transaction Charges" where(Type = const(38));
        }
        field(19; "Charge Type"; Option)
        {
            OptionMembers = "Fixed",Percentage,Staggered;
        }
        field(20; "Restrict to Employer"; Code[20])
        {
            TableRelation = Customer where("Account Type" = const(Employer));
        }
        field(21; "Agent Commision %"; Decimal)
        {
        }
        field(22; "Agent Commision"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

