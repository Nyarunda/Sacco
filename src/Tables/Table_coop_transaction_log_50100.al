table 50540 "Coop ATM Transaction Log"
{
    DataClassification = CustomerContent;
    Caption = 'Transaction Log';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Service Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Service Name';
        }
        field(3; "Message ID"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Message ID';
        }
        field(4; "Connection ID"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Connection ID';
        }
        field(5; "Transaction Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction Date';
        }
        field(6; "Terminal ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Terminal ID';
        }
        field(7; "Channel"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Channel';
        }
        field(8; "Transaction Type"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction Type';
        }
        field(9; "Original Message ID"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Original Message ID';
        }
        field(10; "Institution Code"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Institution Code';
        }
        field(11; "Institution Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Institution Name';
        }
        field(12; "Debit Account"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Debit Account';
        }
        field(13; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(14; "Currency"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency';
        }
        field(15; "Credit Account"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Account';
        }
        field(16; "Charge Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Charge Amount';
        }
        field(17; "Charge Currency"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Charge Currency';
        }
        field(18; "Fee Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Amount';
        }
        field(19; "Fee Currency"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Currency';
        }
        field(20; "Narrative 1"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Narrative 1';
        }
        field(21; "Narrative 2"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Narrative 2';
        }
        field(22; "Additional Info"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Additional Info JSON';
        }
        field(23; "Raw JSON Payload"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Raw JSON Payload';
        }
        field(24; "Created DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Created DateTime';
        }
        field(25; "Processed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Processed';
        }
        field(26; "Processing Status"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Processing Status';
        }
        field(27; "Error Message"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Error Message';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(MessageID; "Message ID")
        {
        }
        key(ServiceName; "Service Name")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created DateTime" := CurrentDateTime;
        "Processing Status" := 'Received';
    end;

    procedure SetAdditionalInfo(JsonText: Text)
    var
        OutStream: OutStream;
    begin
        "Additional Info".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(JsonText);
        Modify();
    end;

    procedure GetAdditionalInfo(): Text
    var
        InStream: InStream;
        JsonText: Text;
    begin
        "Additional Info".CreateInStream(InStream, TextEncoding::UTF8);
        InStream.ReadText(JsonText);
        exit(JsonText);
    end;

    procedure SetRawJsonPayload(JsonText: Text)
    var
        OutStream: OutStream;
    begin
        "Raw JSON Payload".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(JsonText);
        Modify();
    end;

    procedure GetRawJsonPayload(): Text
    var
        InStream: InStream;
        JsonText: Text;
    begin
        "Raw JSON Payload".CreateInStream(InStream, TextEncoding::UTF8);
        InStream.ReadText(JsonText);
        exit(JsonText);
    end;
}

// Page 50100 - Transaction Log API
