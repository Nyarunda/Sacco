Table 50397 "Spotcash Agency Transactions"
{

    fields
    {
        field(1; request_id; Code[20])
        {
        }
        field(2; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; transaction; Integer)
        {
        }
        field(4; amount; Decimal)
        {
        }
        field(5; trnx_charges; Decimal)
        {
        }
        field(6; account_number; Code[20])
        {
        }
        field(7; cr_account; Text[30])
        {
        }
        field(8; status; Text[30])
        {
        }
        field(14; customerType; Text[30])
        {
        }
        field(15; description; Text[50])
        {
        }
        field(16; startDate; Date)
        {
        }
        field(17; endDate; Date)
        {
        }
        field(18; startTime; Time)
        {
        }
        field(19; endTime; Time)
        {
        }
        field(20; emailaddress; Text[30])
        {
        }
        field(28; "Transaction Type"; Option)
        {
            OptionMembers = " ","Cash Withdrawal","Cash Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer";
        }
        field(29; Posted; Boolean)
        {
        }
        field(30; "Needs Change"; Boolean)
        {
        }
        field(31; "Transaction Date"; Date)
        {
        }
        field(32; "Transaction Name"; Text[50])
        {
        }
        field(33; "Loan No."; Code[20])
        {
        }
        field(34; "Interest Paid"; Decimal)
        {
        }
        field(35; "Principal Paid"; Decimal)
        {
        }
        field(36; "Posted By"; Code[50])
        {
        }
        field(37; "Date Posted"; Date)
        {
        }
        field(38; "Client Name"; Text[200])
        {
        }
        field(39; phone_no; Text[30])
        {
        }
        field(40; "Withdrawal Request"; Boolean)
        {
        }
        field(41; "Reference No."; Code[20])
        {
        }
        field(42; Reversed; Boolean)
        {
        }
        field(43; Remarks; Text[50])
        {
        }
        field(44; Failed; Boolean)
        {
        }
        field(45; "Buffer Updated"; Boolean)
        {
        }
        field(46; "Next Retry Date"; Date)
        {
        }
        field(47; agent_phone_no; Text[30])
        {
        }
        field(48; "Date Reversed"; Date)
        {
        }
        field(49; "Time Reversed"; Time)
        {
        }
        field(50; "Reversed By"; Code[50])
        {
        }
        field(51; "Reversal ID"; Code[50])
        {
        }

    }

    keys
    {
        key(Key1; request_id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

