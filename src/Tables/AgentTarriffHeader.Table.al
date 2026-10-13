Table 50393 "Agent Tarriff Header"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Transaction Type"; Option)
        {
            OptionCaption = 'None,Registration,Withdrawal,Deposit,LoanRepayment,Transfer,Sharedeposit,Schoolfeespayment,Balance,Ministatment,Paybill, Memberactivation,MemberRegistration,LoanBalance';//loan balance by munyao
            OptionMembers = "None",Registration,Withdrawal,Deposit,LoanRepayment,Transfer,Sharedeposit,Schoolfeespayment,Balance,Ministatment,Paybill," Memberactivation",MemberRegistration,LoanBalance;//loan balance by munyao
        }
        field(4; "Trans Type Agents"; Option)
        {
            OptionCaption = 'None,Registration,Withdrawal,Deposit,LoanRepayment,Transfer,Sharedeposit,Schoolfeespayment,Balance,Ministatment,Paybill, Memberactivation,MemberRegistration,LoanBalance';//loan balance by munyao
            OptionMembers = "None",Registration,Withdrawal,Deposit,LoanRepayment,Transfer,Sharedeposit,Schoolfeespayment,Balance,Ministatment,Paybill," Memberactivation",MemberRegistration,LoanBalance;//loan balance by munyao
        }
        field(5; "Charge Excise Duty"; Boolean)
        {
        }
        field(6; "Daily Limit"; Decimal)
        {
        }
        field(7; "Weekly Limit"; Decimal)
        {
        }
        field(8; "Monthly Limit"; Decimal)
        {
        }
        field(9; "Yearly Limit"; Decimal)
        {
        }
        field(10; "Transaction Limit"; Decimal)
        {
        }
        field(11; "Sacco Comm Acc"; Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(12; "Vendor Comm Acc"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(13; "SMS Acc"; Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(14; "Charge Acc"; Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(15; Tiered; Boolean)
        {
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

