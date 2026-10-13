Table 50319 CustomTempBlob
{
    Caption = 'TempBlob';

    fields
    {
        field(1; "Primary Key"; Integer)
        {
            Caption = 'Primary Key';
        }
        field(2; Blob; Blob)
        {
            Caption = 'Blob';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure ReadAsText(LineSeperator: Text; Encoding: TextEncoding) Content: Text
    var
        InStream: InStream;
        ContentLine: Text;
    begin
        Blob.CreateInstream(InStream, Encoding);

        InStream.ReadText(Content);
        while not InStream.eos do begin
            InStream.ReadText(ContentLine);
            Content += LineSeperator + ContentLine;
        end;
    end;


    // procedure ToBase64String(): Text
    // var
    //     IStream: InStream;
    //     //Convert: dotnet Convert;
    //     //MemoryStream: dotnet MemoryStream;
    //     Base64String: Text;
    // begin

    //     if not Blob.Hasvalue then
    //         exit('');

    //     Blob.CreateInstream(IStream);
    //     /*MemoryStream := MemoryStream.MemoryStream;
    //     CopyStream(MemoryStream, IStream);
    //     Base64String := Convert.ToBase64String(MemoryStream.ToArray);
    //     MemoryStream.Close;*/
    //     exit(Base64String);

    // end; Commented JN

    procedure ToBase64String(): Text
    var
        TempBlob: Codeunit "Temp Blob";
        Base64String: Text;
        InStream: InStream;
        OutStr: OutStream;
        B64: Codeunit Base64;
    begin
        if not Blob.HasValue then
            exit('');

        // Create an InStream from the Blob
        Blob.CreateInStream(InStream);

        // Write the InStream to the Temp Blob
        TempBlob.CreateOutStream(OutStr);
        CopyStream(OutStr, InStream);

        // Recreate the InStream from Temp Blob
        TempBlob.CreateInStream(InStream);

        // Encode the content in Temp Blob to Base64
        Base64String := B64.StreamToBase64String(InStream);

        exit(Base64String);
    end;



    [Scope('OnPrem')]
    procedure BLOBImportFromServerFile(var TempBlob: Record CustomTempBlob; FilePath: Text)
    var
        OutStream: OutStream;
        InStream: InStream;
        InputFile: File;
    begin

        //IF NOT FILE.EXISTS(FilePath) THEN
        //ERROR('The file %1 does not exist.', FilePath);



    end;

}

