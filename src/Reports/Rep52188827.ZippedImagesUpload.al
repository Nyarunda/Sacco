namespace UnitedWomen_Production.UnitedWomen_Production;
using System.Utilities;
using System.IO;

report 50529 "Zipped Images Upload"
{
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CurrentRecordNo += 1;

                // Skip individual processing if batch mode is enabled
                if not BatchUploadMode then begin
                    ProcessIndividualMember();
                end;

                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, Round(CurrentRecordNo / NoOfRecords * 10000, 1));
            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close();

                if BatchUploadMode then begin
                    BatchUploadFromZip();
                end else begin
                    Message('Upload process completed');
                end;
            end;

            trigger OnPreDataItem()
            begin
                if BatchUploadMode then begin
                    dWindow.Open('Preparing for batch upload...\' +
                                'Processing Members: @1@@@@@@@@@\' +
                                'Member: #2#########\' +
                                'Total: #3#########');
                end else begin
                    dWindow.Open('Uploading Images:        @1@@@@@@@@@\'
                                                + 'Counter   #2#########\'
                                                + 'Total     #3#########\'
                                                + 'Press Esc to abort');
                end;

                NoOfRecords := Members.Count();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Upload Options';
                    field(SignatureUpload; SignatureUpload)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            if SignatureUpload then
                                PictureUpload := false
                            else
                                PictureUpload := true;

                        end;
                    }
                    field(PictureUpload; PictureUpload)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            if PictureUpload then
                                SignatureUpload := false
                            else
                                SignatureUpload := true;

                        end;
                    }

                    field(BatchUploadMode; BatchUploadMode)
                    {
                        Caption = 'Batch Upload Mode (Recommended for 1000+ images)';
                        ToolTip = 'Enable this to upload multiple files at once using a zip file. Much faster for large quantities.';
                        ApplicationArea = All;
                    }
                    field(OverwriteExisting; OverwriteExisting)
                    {
                        Caption = 'Overwrite Existing Images';
                        ToolTip = 'If enabled, existing images will be replaced. If disabled, only missing images will be added.';
                        ApplicationArea = All;
                    }
                    field(ValidateMembers; ValidateMembers)
                    {
                        Caption = 'Validate Member Numbers';
                        ToolTip = 'If enabled, only images for existing members will be processed.';
                        ApplicationArea = All;
                        Enabled = BatchUploadMode;
                    }
                }
                group(Instructions)
                {
                    Caption = 'Batch Upload Instructions';
                    Visible = BatchUploadMode;

                    label(InstructionText)
                    {
                        Caption = 'For batch upload, organize your images in a ZIP file with this naming convention:';
                        ApplicationArea = All;
                    }
                    label(NamingExample1)
                    {
                        Caption = '• Pictures: [MemberNo].jpg (e.g., M001.jpg, MEMBER123.png)';
                        ApplicationArea = All;
                    }
                    label(NamingExample2)
                    {
                        Caption = '• Signatures: [MemberNo]_sig.jpg (e.g., M001_sig.jpg, MEMBER123_sig.png)';
                        ApplicationArea = All;
                    }
                    label(SupportedFormats)
                    {
                        Caption = '• Supported formats: JPG, JPEG, PNG, BMP, GIF';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    // Enhanced batch upload method for large volumes
    procedure BatchUploadFromZip()
    var
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;
        OutStream: OutStream;
        ZipArchive: Codeunit "Data Compression";
        EntryList: List of [Text];
        EntryName: Text;
        MemberNo: Text;
        IsSignature: Boolean;
        FileName: Text;
        ProcessedCount: Integer;
        SkippedCount: Integer;
        ErrorCount: Integer;
        ProgressDialog: Dialog;
        TotalEntries: Integer;
        EntryTempBlob: Codeunit "Temp Blob";
        EntryInStream: InStream;
    begin
        FileName := 'member_images.zip';
        if UploadIntoStream('Select ZIP file containing member images', '', 'ZIP Files (*.zip)|*.zip', FileName, InStream) then begin

            ProgressDialog.Open('Processing ZIP file...\' +
                              'Extracting: @1@@@@@@@@@@@@@@\' +
                              'Current: #2##################\' +
                              'Processed: #3######## of #4########\' +
                              'Errors: #5########\' +
                              'Press Esc to cancel');

            ZipArchive.OpenZipArchive(InStream, false);
            ZipArchive.GetEntryList(EntryList);
            TotalEntries := EntryList.Count();

            foreach EntryName in EntryList do begin
                ProgressDialog.Update(2, EntryName);
                ProgressDialog.Update(3, ProcessedCount);
                ProgressDialog.Update(4, TotalEntries);
                ProgressDialog.Update(5, ErrorCount);
                ProgressDialog.Update(1, Round(ProcessedCount / TotalEntries * 10000, 1));

                if IsImageFile(EntryName) then begin
                    if ProcessZipEntry(ZipArchive, EntryName, ProcessedCount, SkippedCount, ErrorCount) then
                        ProcessedCount += 1
                    else
                        ErrorCount += 1;
                end else begin
                    SkippedCount += 1;
                end;
            end;

            ZipArchive.CloseZipArchive();
            ProgressDialog.Close();

            // Show completion summary
            Message('Batch upload completed!\' +
                   'Processed: %1\' +
                   'Skipped: %2\' +
                   'Errors: %3\' +
                   'Total files in ZIP: %4',
                   ProcessedCount, SkippedCount, ErrorCount, TotalEntries);
        end;
    end;

    local procedure ProcessZipEntry(var ZipArchive: Codeunit "Data Compression"; EntryName: Text; ProcessedCount: Integer; SkippedCount: Integer; var ErrorCount: Integer): Boolean
    var
        TempBlob: Codeunit "Temp Blob";
        TempInStream: InStream;
        TempOutStream: OutStream;
        FinalOutStream: OutStream;
        MemberNo: Text;
        IsSignature: Boolean;
        Length: Integer;
    begin
        MemberNo := GetMemberNoFromFileName(EntryName);

        if MemberNo = '' then begin
            // Log invalid filename but don't count as error
            exit(false);
        end;

        if ValidateMembers then
            if not Members.Get(MemberNo) then begin
                // Member doesn't exist and validation is enabled
                exit(false);
            end;

        // Initialize Member Images record if it doesn't exist
        if not MemberImages.Get(MemberNo) then begin
            MemberImages.Init();
            MemberImages."Member No." := MemberNo;
            if not MemberImages.Insert() then
                exit(false);
        end;

        // Check if we should skip existing images
        if not OverwriteExisting then begin
            if SignatureUpload then begin
                if MemberImages.Signature.HasValue() then
                    exit(false);
            end else begin
                if MemberImages.Picture.HasValue() then
                    exit(false);
            end;
        end;

        // Extract to temporary blob first
        TempBlob.CreateOutStream(TempOutStream);
        Length := ZipArchive.ExtractEntry(EntryName, TempOutStream);

        if Length = 0 then begin
            ErrorCount += 1;
            exit(false);
        end;

        // Now copy from temp blob to final destination
        TempBlob.CreateInStream(TempInStream);

        if SignatureUpload then begin
            MemberImages.Signature.CreateOutStream(FinalOutStream);
        end else begin
            MemberImages.Picture.CreateOutStream(FinalOutStream);
        end;

        CopyStream(FinalOutStream, TempInStream);

        if not MemberImages.Modify() then begin
            ErrorCount += 1;
            exit(false);
        end;

        exit(true);
    end;

    local procedure IsImageFile(FileName: Text): Boolean
    var
        LowerFileName: Text;
    begin
        LowerFileName := LowerCase(FileName);
        exit((StrPos(LowerFileName, '.jpg') > 0) or
             (StrPos(LowerFileName, '.jpeg') > 0) or
             (StrPos(LowerFileName, '.png') > 0) or
             (StrPos(LowerFileName, '.bmp') > 0) or
             (StrPos(LowerFileName, '.gif') > 0));
    end;

    local procedure ProcessIndividualMember()
    var
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;
        OutStream: OutStream;
        FileName: Text;
    begin
        PicName := Members."No.";
        SigName := Members."No.";

        // Initialize Member Images record if it doesn't exist
        if not MemberImages.Get(Members."No.") then begin
            MemberImages.Init();
            MemberImages."Member No." := Members."No.";
            MemberImages.Insert();
        end;

        if MemberImages.Get(Members."No.") then begin
            // Handle Picture Upload
            FileName := StrSubstNo('%1.jpg', PicName);
            if UploadIntoStream('Select Picture for Member: ' + PicName, '', 'Image Files (*.jpg;*.jpeg;*.png;*.bmp)|*.jpg;*.jpeg;*.png;*.bmp', FileName, InStream) then begin
                MemberImages.Picture.CreateOutStream(OutStream);
                CopyStream(OutStream, InStream);
                MemberImages.Modify();
            end;

            // Handle Signature Upload
            FileName := StrSubstNo('%1_sig.jpg', SigName);
            if UploadIntoStream('Select Signature for Member: ' + SigName, '', 'Image Files (*.jpg;*.jpeg;*.png;*.bmp)|*.jpg;*.jpeg;*.png;*.bmp', FileName, InStream) then begin
                MemberImages.Signature.CreateOutStream(OutStream);
                CopyStream(OutStream, InStream);
                MemberImages.Modify();
            end;
        end;
    end;

    local procedure GetMemberNoFromFileName(EntryName: Text): Text
    var
        MemberNo: Text;
        StartPos: Integer;
        EndPos: Integer;
    begin
        // Extract filename without path
        StartPos := EntryName.LastIndexOf('\');
        if StartPos = 0 then
            StartPos := EntryName.LastIndexOf('/');

        if StartPos > 0 then
            MemberNo := CopyStr(EntryName, StartPos + 1)
        else
            MemberNo := EntryName;

        // Remove file extension
        EndPos := MemberNo.LastIndexOf('.');
        if EndPos > 0 then
            MemberNo := CopyStr(MemberNo, 1, EndPos - 1);

        // Remove signature indicator if present
        if StrPos(LowerCase(MemberNo), '_sig') > 0 then
            MemberNo := CopyStr(MemberNo, 1, StrPos(LowerCase(MemberNo), '_sig') - 1);

        // Validate that this is a valid member number
        if Members.Get(MemberNo) then
            exit(MemberNo);

        exit('');
    end;

    var
        PicName: Text;
        SigName: Text;
        MemberImages: Record "Member Images";
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        dWindow: Dialog;
        BatchUploadMode: Boolean;
        OverwriteExisting: Boolean;
        ValidateMembers: Boolean;
        PictureUpload: Boolean;
        SignatureUpload: Boolean;
}
