table 50023 "Email Attachment Portal"
{
    Caption = 'Email Attachment';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Email Entry No."; Integer)
        {
            Caption = 'Email Entry No.';
            TableRelation = "Email Queue"."Entry No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "File Name"; Text[250])
        {
            Caption = 'File Name';
        }
        field(4; "Content Type"; Text[100])
        {
            Caption = 'Content Type';
            InitValue = 'application/octet-stream';
        }
        field(5; "File Content"; Blob)
        {
            Caption = 'File Content';
        }
        field(6; "File Size"; Integer)
        {
            Caption = 'File Size (bytes)';
        }
    }

    keys
    {
        key(PK; "Email Entry No.", "Line No.") { Clustered = true; }
    }
}
