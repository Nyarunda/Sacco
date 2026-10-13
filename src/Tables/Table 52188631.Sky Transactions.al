
Table 50294 "Sky"
{

    fields
    {
        field(1; "Transaction ID"; Code[20])
        {
        }
        field(3; "Transaction Date"; Date)
        {
        }
        field(4; "Transaction Time"; Time)
        {
        }
        field(8; "Member Account"; Code[20])
        {
        }
        field(11; "Vendor Commission"; Decimal)
        {
        }
        field(13; "Sacco Fee"; Decimal)
        {
        }
        field(15; Description; Text[50])
        {
        }
        field(17; Amount; Decimal)
        {
        }
        field(18; Posted; Boolean)
        {
        }
        field(19; "Date Posted"; Date)
        {
        }
        field(20; "Time Posted"; Time)
        {
        }
        field(21; "Posted By"; Code[50])
        {
        }
        field(22; Reversed; Boolean)
        {
        }
        field(23; "Date Reversed"; Date)
        {
        }
        field(24; "Time Reversed"; Time)
        {
        }
        field(25; "Reversed By"; Code[50])
        {
        }
        field(26; "Reversal ID"; Code[20])
        {
        }
        field(27; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Mpesa Withdrawal,Mpesa Deposit,Utility Payment,Loan Repayment,Balance Enquiry,Mini-Statement,Loan Disbursement,Account Transfer,Pay Loan From Account,Paybill,Mobile App Login,Pesalink Transfer,Airtime,Bank Deposit,Bank Agent Deposit,Bank Transfer';
            OptionMembers = " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer";
        }
        field(28; "Transaction Name"; Text[50])
        {
        }
        field(32; "Session ID"; Code[20])
        {
        }
        field(33; "Loan No."; Code[20])
        {
        }
        field(34; Keyword; Code[20])
        {
        }
        field(35; "Mobile No."; Code[20])
        {
        }
        field(36; "Statement Max Rows"; Integer)
        {
        }
        field(37; "Statement Start Date"; Date)
        {
        }
        field(38; "Statement End Date"; Date)
        {
        }
        field(39; "Account to Check"; Code[20])
        {
        }
        field(40; "Entry No."; Guid)
        {
        }
        field(41; "Client Name"; Text[200])
        {
        }
        field(42; "Paybill Member ID"; Code[20])
        {
        }
        field(43; "Needs Change"; Boolean)
        {
        }
        field(44; "Changed By"; Code[50])
        {
        }
        field(45; "Date Changed"; Date)
        {
        }
        field(46; "Interest Paid"; Decimal)
        {
        }
        field(47; "Principal Paid"; Decimal)
        {
        }
        field(50050; MobileApp; Boolean)
        {
        }
        field(50051; "Manually Inserted"; Boolean)
        {
        }
        field(50052; "Inserted By"; Code[50])
        {
        }
        field(50053; "Date Inserted"; Date)
        {
        }
        field(50054; "Old Transaction Date"; Date)
        {
        }
        field(50055; "Ledger Entries"; Integer)
        {
            CalcFormula = count("Bank Account Ledger Entry" where("Document No." = field("Transaction ID"),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(50056; SMSMessage; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Transaction ID")
        {
        }
        key(Key3; "Transaction Date")
        {
        }
    }

    fieldgroups
    {
    }
}

