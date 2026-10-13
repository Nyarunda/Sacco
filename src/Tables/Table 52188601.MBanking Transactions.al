
Table 50264 "MBanking Upload Transactions"
{

    fields
    {
        field(1; "Transaction ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Transaction Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Member Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Vendor Commission"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Sacco Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Time Posted"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Date Reversed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Time Reversed"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Reversed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Reversal ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mpesa Withdrawal,Mpesa Deposit,Utility Payment,Loan Repayment,Balance Enquiry,Mini-Statement,Loan Disbursement,Account Transfer,Pay Loan From Account,Paybill,Mobile App Login,Pesalink Transfer,Airtime,Bank Deposit,Bank Agent Deposit,Bank Transfer';
            OptionMembers = " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer";
        }
        field(28; "Transaction Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Session ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34; Keyword; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Mobile No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Statement Max Rows"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Statement Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Statement End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Account to Check"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Entry No."; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Client Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Paybill Member ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Needs Change"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Changed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Date Changed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Interest Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Principal Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; MobileApp; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Manually Inserted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Inserted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Date Inserted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Old Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Destination Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Loan Transfer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; Remarks; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Penalty Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Short Code"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Paybill Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "Ledger Entries"; Integer)
        {
            CalcFormula = count("Bank Account Ledger Entry" where("Document No." = field("Transaction ID"),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }


        field(50062; "Destination Name"; Text[100])
        {
        }
        field(50063; "Organization"; Text[100])
        {
        }



    }

    keys
    {
        key(Key1; "Transaction ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

