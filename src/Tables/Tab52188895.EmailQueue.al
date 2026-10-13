table 50025 "Email Queue"
{
    Caption = 'Email Queue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }
        field(3; "To Address"; Text[500])
        {
            Caption = 'To Address';
            ToolTip = 'One or more recipient addresses separated by commas.';
        }
        field(4; "CC Address"; Text[500])
        {
            Caption = 'CC';
        }
        field(5; "BCC Address"; Text[500])
        {
            Caption = 'BCC';
        }
        field(6; Subject; Text[250])
        {
            Caption = 'Subject';
        }
        field(7; Body; Blob)
        {
            Caption = 'Body';
            ToolTip = 'HTML email body content.';
        }
        field(8; Sent; Boolean)
        {
            Caption = 'Sent';
            Editable = false;
        }
        field(9; "Sent At"; DateTime)
        {
            Caption = 'Sent At';
            Editable = false;
        }
        field(10; "Error Message"; Text[1000])
        {
            Caption = 'Error Message';
            Editable = false;
        }
        field(11; "Bulk Group ID"; Code[20])
        {
            Caption = 'Bulk Group ID';
            ToolTip = 'Groups emails dispatched together. Leave blank for single sends.';
        }
        field(12; "Has Attachments"; Boolean)
        {
            Caption = 'Has Attachments';
            Editable = false;
        }
        field(13; "Source Table ID"; Integer)
        {
            Caption = 'Source Table ID';
            ToolTip = 'Table number of the record that triggered this email.';
        }
        field(14; "Source Entry No."; Text[100])
        {
            Caption = 'Source Entry No.';
            ToolTip = 'Primary key value of the source record.';
        }
        field(15; Priority; Option)
        {
            Caption = 'Priority';
            OptionMembers = Normal,High,Low;
            OptionCaption = 'Normal,High,Low';
        }
        field(16; "From Name"; Text[100])
        {
            Caption = 'From Name';
        }
        field(17; "From Address"; Text[100])
        {
            Caption = 'From Address';
        }
        field(18; "Retry Count"; Integer)
        {
            Caption = 'Retry Count';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(BulkGroup; "Bulk Group ID") { }
        key(SentPending; Sent, "Retry Count") { }
    }

    trigger OnInsert()
    begin
        if "Created At" = 0DT then
            "Created At" := CurrentDateTime();
    end;
}
