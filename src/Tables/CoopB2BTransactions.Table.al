Table 50572 "Coop B2B Transactions"
{

    LookupPageId = "Coop B2B Transactions";
    DrillDownPageId = "Coop B2B Transactions";

    fields
    {
        field(1; "Transaction Reference Code"; Code[20])
        {
        }
        field(2; "Service Name"; Text[50])
        {
        }
        field(3; "Transaction Date"; Date)
        {
        }
        field(4; "Transaction Time"; Time)
        {
        }
        field(5; "Payment Date"; DateTime)
        {
        }
        field(6; "Document Reference Code"; Text[30])
        {
        }
        field(7; "Additional Info"; Text[200])
        {
        }
        field(8; "Account Number"; Code[20])
        {
        }
        field(9; "Institution Code"; Code[50])
        {
        }
        field(10; "Institution Name"; Text[100])
        {
        }
        field(11; "Bank Code"; Text[30])
        {
        }
        field(12; "Branch Code"; Text[30])
        {
        }
        field(13; "Payment Reference Code"; Text[30])
        {
        }
        field(14; Currency; Code[20])
        {
        }
        field(15; Description; Text[50])
        {
        }
        field(16; "Payment Code"; Text[30])
        {
        }
        field(17; "Total Amount"; Decimal)
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
        field(27; "Transaction Type"; Code[20])
        {
        }
        field(28; "Transaction Name"; Text[50])
        {
        }
        field(29; "Payment Mode"; Text[50])
        {
        }
        field(30; "Payment Amount"; Decimal)
        {
        }
        field(31; "Account Name"; Text[200])
        {
        }
        field(32; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(38; "Coop Fee"; Decimal)
        {
        }
        field(39; "Sacco Fee"; Decimal)
        {
        }
        field(40; "Sacco Excise Duty"; Decimal)
        {
        }
        field(41; "Total Charges"; Decimal)
        {
        }
        field(42; "Sacco Reference"; Code[20])
        {
        }

    }

    keys
    {
        key(Key1; "Transaction Reference Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

