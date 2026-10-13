
Table 50271 "Mobile Withdrawal Buffer"
{

    LookupPageId = "Sky Mobile Withdrawal Buffer";
    DrillDownPageId = "Sky Mobile Withdrawal Buffer";

    fields
    {
        field(1; "Trace ID"; Code[20])
        {
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; "Account No"; Code[20])
        {
        }
        field(4; Description; Text[200])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Posting S"; Text[50])
        {
        }
        field(7; Posted; Boolean)
        {
        }
        field(8; "Unit ID"; Code[10])
        {
        }
        field(9; "Transaction Type"; Text[30])
        {
        }
        field(10; "Trans Time"; Text[50])
        {
        }
        field(11; "Transaction Time"; Time)
        {
        }
        field(12; "Transaction Date"; Date)
        {
        }
        field(13; Source; Option)
        {
            OptionMembers = ATM,"M-PESA";
        }
        field(14; Reversed; Boolean)
        {
        }
        field(16; "Reversed Posted"; Boolean)
        {
            Editable = true;
        }
        field(17; "Reversal Trace ID"; Code[20])
        {
        }
        field(18; "Transaction Description"; Text[100])
        {
        }
        field(19; "Withdrawal Location"; Text[150])
        {
        }
        field(20; "Entry No"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(22; "Transaction Type Charges"; Option)
        {
            OptionCaption = 'Balance Enquiry,Mini Statement,Cash Withdrawal - Coop ATM,Cash Withdrawal - VISA ATM,Reversal,Utility Payment,Pos Normal Purchase,M-PESA Withdrawal,Airtime Purchase,POS - School Payment,POS - Purchase With Cash Back,POS - Cash Deposit,POS - Benefit Cash Withdrawal,POS - Cash Deposit to Card,POS - M Banking,Pos-cash Withdrawal,Pos-balance Enquiry,Pos-mini Statement,MINIMUM BALANCE,POS - Cash Withdrawal';
            OptionMembers = "Balance Enquiry","Mini Statement","Cash Withdrawal - Coop ATM","Cash Withdrawal - VISA ATM",Reversal,"Utility Payment","Pos Normal Purchase","M-PESA Withdrawal","Airtime Purchase","POS - School Payment","POS - Purchase With Cash Back","POS - Cash Deposit","POS - Benefit Cash Withdrawal","POS - Cash Deposit to Card","POS - M Banking","Pos-cash Withdrawal","Pos-balance Enquiry","Pos-mini Statement","MINIMUM BALANCE","POS - Cash Withdrawal";
        }
        field(23; "Card Acceptor Terminal ID"; Code[20])
        {
        }
        field(24; "ATM Card No"; Code[20])
        {
        }
        field(25; "Customer Names"; Text[100])
        {
        }
        field(26; "Process Code"; Code[20])
        {
        }
        field(27; "Is Coop Bank"; Boolean)
        {
        }
        field(28; "POS Vendor"; Option)
        {
            OptionCaption = 'ATM Lobby,Coop,Sacco';
            OptionMembers = "ATM Lobby",Coop,Sacco;
        }
        field(29; "Session ID"; Text[100])
        {
        }
        field(30; Comments; Text[100])
        {
        }
        field(31; "Date Reversed"; Date)
        {
        }
        field(32; "Reversed By"; Code[50])
        {
        }
        field(33; "Withdrawal Type"; Text[30])
        {
        }
        field(34; "Reference No"; Text[100])
        {
        }
        field(50; "Spotcash Transaction Posted"; Boolean)
        {

            CalcFormula = lookup("Spotcash Transactions".Posted where(request_id = field("Trace ID")));
            FieldClass = FlowField;
        }
        field(51; "Sky Transaction Posted"; Boolean)
        {

            CalcFormula = lookup("Sky Transactions.".Posted where("session id" = field("Trace ID")));
            FieldClass = FlowField;
        }

        field(52; "Fuuza Amount"; Decimal)
        {
        }
        field(53; "Fuuza Posted"; Boolean)
        {
        }

        field(54; "Total Charges"; Decimal)
        {
            Caption = 'Total Charges';
            Editable = false;
        }
        field(55; "Transaction Amount"; Decimal)
        {
            Caption = 'Total Debit Amount';
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Trace ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

