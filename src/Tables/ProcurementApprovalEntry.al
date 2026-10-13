table 50505 "Procurement Approval Entry"
{
    Caption = 'Procurement Approval Entry';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = "Store Requisition","External Requisition","LPO/LSO";
            OptionCaption = 'Store Requisition,External Requisition,LPO/LSO';
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(4; "Approval Level"; Integer)
        {
            Caption = 'Approval Level';
            DataClassification = CustomerContent;
        }
        field(5; "Approver User ID"; Code[50])
        {
            Caption = 'Approver User ID';
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Approved,Rejected;
            OptionCaption = 'Open,Approved,Rejected';
            DataClassification = CustomerContent;
        }
        field(7; "Approval Date"; DateTime)
        {
            Caption = 'Approval Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; Comments; Text[250])
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.", "Approval Level")
        {
        }
        key(Key3; "Approver User ID", Status)
        {
        }
    }
}
