
Table 50265 "MBanking Setup"
{

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Vendor Commission Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(3; "Sacco Fee Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(4; "Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(5; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mpesa Withdrawal,Mpesa Deposit,Utility Payment,Loan Repayment,Balance Enquiry,Mini-Statement,Loan Disbursement,Account Transfer,Pay Loan From Account,Paybill,Mobile App Login,Pesalink Transfer,Airtime,Bank Deposit,Bank Agent Deposit,Bank Transfer';
            OptionMembers = " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer";
        }
        field(6; "Vendor Commission"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Sacco Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Safaricom Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(9; "Safaricom Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Pre-Payment Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(11; "SMS Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "SMS Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(13; "Transaction Limit"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                if "Transaction Limit" > 0 then begin
                    if ("Transaction Type" <> "transaction type"::"Mpesa Withdrawal") and ("Transaction Type" <> "transaction type"::"Utility Payment") then
                        Error('This option is not applicable for this transaction');
                end;
            end;
        }
        field(14; "Non-Member Debit Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(15; "Daily Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Weekly Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Monthly Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Staggered Charge Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Charge Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Fixed",Percentage,Staggered;
        }
        field(20; "Restrict to Employer"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Employer));
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

