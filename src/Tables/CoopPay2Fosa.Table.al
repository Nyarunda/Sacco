Table 50571 "Coop Pay2Fosa"
{

    LookupPageId = "Coop P2F Transactions";
    DrillDownPageId = "Coop P2F Transactions";
    fields
    {
        field(1; "Transaction ID"; Code[20])
        {
        }
        field(2; "Transaction Date"; DateTime)
        {
        }
        field(3; "Value Date"; Date)
        {
        }
        field(4; "Posting Date"; Date)
        {
        }
        field(5; "Payment Ref"; Text[100])
        {
        }
        field(6; Narration; Text[100])
        {
        }
        field(7; "Exchange Rate"; Text[50])
        {
        }
        field(8; "Event Type"; Text[100])
        {
        }
        field(9; CustomMemoLine1; Text[100])
        {
        }
        field(10; CustomMemoLine2; Text[100])
        {
        }
        field(11; CustomMemoLine3; Text[100])
        {
        }
        field(12; Currency; Code[10])
        {
        }
        field(13; "Cleared Balance"; Decimal)
        {
        }
        field(14; "Booked Balance"; Decimal)
        {
        }
        field(15; Amount; Decimal)
        {
        }
        field(16; "Institution A/C No"; Text[100])
        {
        }
        field(17; "Member Account No."; Code[20])
        {
        }
        field(18; "Split Account No."; Text[100])
        {
        }
        field(19; Posted; Boolean)
        {
        }
        field(20; "Posted By"; Code[50])
        {
        }
        field(21; "Date Posted"; Date)
        {
        }
        field(22; Purpose; Option)
        {
            OptionMembers = " ","Mid Salary","End Salary","Mid Pension","End Pension","Mid Allowance","End Allowance";
        }
        field(23; "Salary Header"; Code[50])
        {
        }

        field(72; "Changed By"; code[50])
        {
            Caption = 'Changed by';
            Editable = false;
        }

        field(73; "Changed Date"; Date)
        {
            Caption = 'Changed Date';
            Editable = false;
        }
        field(74; "Changed Time"; Time)
        {
            Caption = 'Changed Time';
            Editable = false;
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

