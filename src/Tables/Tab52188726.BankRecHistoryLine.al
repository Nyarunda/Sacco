table 52007 "Bank Rec. History Line"
{
    DataClassification = CustomerContent;
    Caption = 'Bank Reconciliation History Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
            DataClassification = CustomerContent;
        }
        field(4; "Document Type"; Option)
        {
            OptionMembers = " ",Payment,Receipt,"Bank Charge","Bank Interest";
        }
        field(5; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(8; "Statement Amount"; Decimal)
        {
            Caption = 'Statement Amount';
            DataClassification = CustomerContent;
        }
        field(9; Difference; Decimal)
        {
            Caption = 'Difference';
            DataClassification = CustomerContent;
        }
        field(10; Matched; Boolean)
        {
            Caption = 'Matched';
            DataClassification = CustomerContent;
        }
        field(11; "Bank Entry No."; Integer)
        {
            Caption = 'Bank Entry No.';
            DataClassification = CustomerContent;
        }
        field(12; "Applied Amount"; Decimal)
        {
            Caption = 'Applied Amount';
            DataClassification = CustomerContent;
        }
        field(13; "Applied Entries"; Integer)
        {
            Caption = 'Applied Entries';
            DataClassification = CustomerContent;
        }
        field(14; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            DataClassification = CustomerContent;
        }
        field(15; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            DataClassification = CustomerContent;
        }
        field(16; "Statement Date"; Date)
        {
            Caption = 'Statement Date';
            DataClassification = CustomerContent;
        }
        field(17; Reconciled; Boolean)
        {
            Caption = 'Reconciled';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Bank Account No.", "Statement No.", "Line No.")
        {
        }
        key(Key3; "Bank Account No.", Reconciled)
        {
        }
    }
}