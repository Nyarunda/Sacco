table 50675 "Bulk Email Attachment"
{
    Caption = 'Bulk Email Attachment';

    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = true;
            TableRelation = "Bulk Email Header".No;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Source File Path"; Text[250])
        {
            Caption = 'PDF File Path or URL';
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Enabled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "File Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Mime Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "File Content"; Blob)
        {
            Caption = 'Uploaded File';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No, "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if not Enabled then
            Enabled := true;
    end;

    procedure SetUploadedFile(NewFileName: Text; var FileInStream: InStream)
    var
        FileOutStream: OutStream;
    begin
        "File Name" := ExtractFileNameFromPath(NewFileName); // CopyStr(NewFileName, 1, MaxStrLen("File Name"));
        Description := "File Name";
        "Mime Type" := 'application/pdf';
        "Source File Path" := '';

        "File Content".CreateOutStream(FileOutStream);

        CopyStream(FileOutStream, FileInStream);
    end;

    procedure ClearUploadedFile()
    var
        FileOutStream: OutStream;
    begin
        Clear("File Name");
        Clear("Mime Type");
        "File Content".CreateOutStream(FileOutStream);
    end;

    procedure HasUploadedFile(): Boolean
    begin
        CalcFields("File Content");
        exit("File Content".HasValue());
    end;

    procedure GetNextLineNo(): Integer
    var
        BulkEmailAttachment: Record "Bulk Email Attachment";
    begin
        BulkEmailAttachment.SetRange(No, No);
        if BulkEmailAttachment.FindLast() then
            exit(BulkEmailAttachment."Line No." + 1)
        else
            exit(1);
    end;

    local procedure ExtractFileNameFromPath(FullPath: Text): Text
    var
        SlashPos: Integer;
        BackslashPos: Integer;
        StartPos: Integer;
    begin
        StartPos := 1;

        BackslashPos := StrLen(FullPath);
        while BackslashPos > 0 do begin
            if (FullPath[BackslashPos] = '\') or (FullPath[BackslashPos] = '.') then begin
                StartPos := BackslashPos - 1;
                break;
            end;
            BackslashPos -= 1;
        end;

        if StartPos = 1 then begin
            SlashPos := StrLen(FullPath);
            while SlashPos > 0 do begin
                if (FullPath[SlashPos] = '/') or (FullPath[SlashPos] = '.') then begin
                    StartPos := SlashPos + 1;
                    break;
                end;
                SlashPos -= 1;
            end;
        end;

        if StartPos > StrLen(FullPath) then
            exit('document.pdf');

        //exit(CopyStr(FullPath, StartPos, StrLen(FullPath) - StartPos + 1));
        exit(CopyStr(FullPath, 1, StartPos));
    end;

}
