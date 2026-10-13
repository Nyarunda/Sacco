Table 51128 "HR Overtime Ledger Entries"
{
    Caption = 'Leave Ledger Entry';
    DrillDownPageID = "HR Leave Ledger Entries";
    LookupPageID = "HR Leave Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
        }
        field(3; "Staff Name"; Text[70])
        {
            Caption = 'Staff Name';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(7; Hours; Decimal)
        {
        }
        field(8; Posted; Boolean)
        {
        }
        field(9; Amount; Decimal)
        {
        }
        field(10; "Date Approved"; Date)
        {
        }
        field(11; "Document No."; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Staff No.", "Posting Date")
        {
        }
    }
}

