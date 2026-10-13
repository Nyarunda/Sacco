Report 50091 "Upload Pictures"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1) { }

            trigger OnAfterGetRecord()
            var
                PicOutStream: OutStream;
                SigOutStream: OutStream;
                PicTempBlob: Codeunit "Temp Blob";
                SigTempBlob: Codeunit "Temp Blob";
                PicInStream: InStream;
                SigInStream: InStream;
                EntryLength: Integer;
                PicFileName: Text;
                SigFileName: Text;
            begin
                CurrentRecordNo += 1;

                PicName := Members."Old Member No.";
                SigName := Members."Old Member No.";

                // ← Debug 1: Check Old Member No.
                Message('Member: %1 Old No: %2', Members."No.", PicName);

                if PicName = '' then begin
                    UpdateProgress();
                    exit;
                end;

                if not MemberImages.Get(Members."No.") then begin
                    MemberImages.Init();
                    MemberImages."Member No." := Members."No.";
                    MemberImages.Insert();
                end;

                if MemberImages.Get(Members."No.") then begin

                    PicFileName := PicName + '.jpg';

                    // ← Debug 2: Check if file exists in ZIP
                    Message('Looking for: %1 Found: %2', PicFileName, PicEntryList.Contains(PicFileName));

                    if PicEntryList.Contains(PicFileName) then begin
                        PicTempBlob.CreateOutStream(PicOutStream);
                        PictureZip.ExtractEntry(PicFileName, PicOutStream);
                        PicTempBlob.CreateInStream(PicInStream);
                        MemberImages.Picture.CreateOutStream(OutStream1);
                        CopyStream(OutStream1, PicInStream);
                        MemberImages.Modify();

                        // ← Debug 3: Check if picture was saved
                        Message('Picture saved for member: %1 Size: %2', Members."No.");
                    end;

                end;

                UpdateProgress();
            end;


            trigger OnPostDataItem()
            begin
                dWindow.Close();
                Message('Completed');
            end;

            trigger OnPreDataItem()
            var
                PicZipInStream: InStream;
                SigZipInStream: InStream;
            begin
                // ← Upload Pictures ZIP
                if not UploadIntoStream('Select Pictures ZIP', '', 'Zip Files|*.zip', PicZipFileName, PicZipInStream) then
                    Error('No pictures ZIP selected.');
                PictureZip.OpenZipArchive(PicZipInStream, false);
                PictureZip.GetEntryList(PicEntryList);

                // // ← Upload Signatures ZIP
                // if not UploadIntoStream('Select Signatures ZIP', '', 'Zip Files|*.zip', SigZipFileName, SigZipInStream) then
                //     Error('No signatures ZIP selected.');
                // SignatureZip.OpenZipArchive(SigZipInStream, false);
                // SignatureZip.GetEntryList(SigEntryList);

                dWindow.Open('Uploading Images:        @1@@@@@@@@@\'
                                + 'Counter   #2#########\'
                                + 'Total     #3#########\'
                                + 'Press Esc to abort');
                NoOfRecords := Members.Count();
            end;
        }
    }

    requestpage
    {
        layout { }
        actions { }
    }

    labels { }

    var
        PicName: Text;
        SigName: Text;
        MemberImages: Record "Member Images";
        PictureZip: Codeunit "Data Compression";
        SignatureZip: Codeunit "Data Compression";
        PicZipFileName: Text;
        SigZipFileName: Text;
        PicEntryList: List of [Text];
        SigEntryList: List of [Text];
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        dWindow: Dialog;
        OutStream1: OutStream;

    local procedure UpdateProgress()
    begin
        dWindow.Update(2, CurrentRecordNo);
        dWindow.Update(3, NoOfRecords);
        dWindow.Update(1, Round(CurrentRecordNo / NoOfRecords * 10000, 1));
    end;
}