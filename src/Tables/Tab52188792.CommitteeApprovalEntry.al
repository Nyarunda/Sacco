table 50474 "Committee Approval Entry"
{
    Caption = 'Committee Approval Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Document Amount"; Decimal)
        {
            Caption = 'Document Amount';
        }
        field(4; "Date Created"; DateTime)
        {
            Caption = 'Date Created';
        }
        field(5; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(6; "Description 1"; Text[100])
        {
            Caption = 'Description 1';
        }
        field(7; "Description 2"; Text[100])
        {
            Caption = 'Description 2';
        }
        field(8; "Description 3"; Text[100])
        {
            Caption = 'Description 3';
        }
        field(9; "Sender ID"; Code[50])
        {
            Caption = 'Sender ID';
        }
        field(10; "Approver ID"; Code[50])
        {
            Caption = 'Approver ID';
        }
        field(11; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
        }
        field(12; "Date Approved"; Date)
        {
            Caption = 'Date Approved';
        }
        field(13; "Rejected By"; Code[50])
        {
            Caption = 'Rejected By';
        }
        field(14; "Date Rejected"; Date)
        {
            Caption = 'Date Rejected';
        }
        field(15; Status; Enum "Approval Status")
        {
            Caption = 'Status';
        }
        field(23; "Approval Sequence"; Integer)
        {
            Caption = 'Approval Sequence';
        }
        field(24; "Comment"; Text[1000])
        {
        }
        field(25; "Approver Details"; Text[1000])
        {
        }
        field(26; "Reject Details"; Text[1000])
        {
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(PK2; "Approval Sequence")
        {
        }
    }
}
