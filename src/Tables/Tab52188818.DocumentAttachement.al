table 50509 "Cloud Document Attachment"
{
    Caption = 'Document Attachment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "File Name"; Text[150])
        {
            Caption = 'File Name';
        }
        field(3; "Azure Blob URL"; Code[200])
        {
            Caption = 'Azure Blob URL';
        }
        field(4; "Created Date"; Date)
        {
            Caption = 'Created Date';
        }
        field(5; Blob; Blob)
        {
            Caption = 'Blob';
            Subtype = Bitmap;
        }
        field(6; RecordId; RecordId)
        {
        }
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }


    procedure DownLoadBlobFromRecord()
    var
        InStr: InStream;
        OutStr: OutStream;
        Content: Text;
        ToFileName: Variant;
    begin
        ToFileName := Rec."File Name";
        //Download(Rec."File Name", 'Export', '', 'All Files (*.*)|*.*', ToFileName);
        //Download(Format(Blob), 'Export', '', 'All Files (*.*)|*.*', ToFileName);
    end;

    procedure UploadBlobToRecord()
    var
        InStr: InStream;
        OutStr: OutStream;
        FileName: Text;
    begin
        if UploadIntoStream('', '', '', FileName, InStr) then begin
            Rec.Blob.CreateOutStream(OutStr);
            CopyStream(OutStr, InStr);
            Rec.Modify();
        end;


    end;
}
