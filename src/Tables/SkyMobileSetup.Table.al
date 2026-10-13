Table 50347 "Sky Mobile Setup."
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
        field(5; "Transaction Type"; Enum "Sky M-Banking Trans Types")
        {

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
                    if ("Transaction Type" <> "transaction type"::"Mpesa Withdrawal") and ("Transaction Type" <> "transaction type"::"Utility Payment") then
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
        field(18; "Restrict to Employer"; Code[20])
        {
            TableRelation = Customer where("Account Type" = const(Employer));
        }
        field(19; "Sacco Staggered Charge"; Code[20])
        {
            TableRelation = "Transaction Charges";
        }
        field(20; "Sacco Staggered Fee"; Boolean)
        {
        }
        field(21; "Restrict to Staff"; Boolean)
        {
        }
        field(22; "Restrict to Board"; Boolean)
        {
        }
        field(23; "Vendor Staggered Charge"; Code[20])
        {
            TableRelation = "Transaction Charges";
        }
        field(24; "Vendor Staggered Fee"; Boolean)
        {
        }
        field(25; "Safcom Staggered Charge"; Code[20])
        {
            TableRelation = "Transaction Charges";
        }
        field(26; "Safcom Staggered Fee"; Boolean)
        {
        }
        field(27; "Safaricom Dep Charges GL"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(28; "Staff G/L Account Charges"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(29; "Total Charges"; Decimal)
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

