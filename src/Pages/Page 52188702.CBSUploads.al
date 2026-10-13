page 50751 "CBS Uploads"
{
    Caption = 'CBS Uploads';
    PageType = List;
    SourceTable = "CBS Uploads";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(Document; Rec.Document)
                {
                    ApplicationArea = All;

                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                    Editable = false;
                }
                field(Path; Rec."Azure Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Path field.';
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                    Editable = false;
                }
                field(Format; Rec.Format)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Format field.';
                    Editable = false;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                    Editable = false;
                }
                field("Time"; Rec."Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.';
                    Editable = false;
                }
                field("Loan Application No."; Rec."Loan Application No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.';
                    Editable = false;
                }

            }
        }
    }


    actions
    {
        area(processing)
        {

            action("Upload File to Azure")
            {
                ApplicationArea = All;
                Caption = 'Upload File';
                Image = Import;
                Enabled = true;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    InStr: InStream;
                    OutStr: OutStream;
                    FileName: Text;
                    SaccoSetup: Record "Sacco Setup";
                    Document: Record "Cloud Document Attachment";
                    DMS_: Codeunit EDMS;
                    Directory: Text;
                    UserSetup: Record "User Setup";
                    Members: Record "Members";
                begin
                    UserSetup.Get(UserId);

                    if not UserSetup."Upload File" then
                        Error('Permission Denied. User does not have permission to upload files![Upload Files]');


                    //Check if Already Uploaded
                    if Rec."Azure Path" <> '' then begin

                        if not UserSetup."Overwrite Upload File" then
                            Error('Permission Denied. User does not have permission to overwite uploaded files![Overwrite Upload Files]');

                        if not Confirm('Document Already Upload. DO you want to upload again?') then
                            Error('Aborted');
                    end;

                    //Add Permission to ennsure only the user who initially uploaded the document is the one uploading again. 


                    //Set File Name
                    Rec."Name" := Rec."Loan Application No." + '-' + Rec."Member No." + '.pdf';

                    //Set Directory
                    Directory := 'MaishaBora/Loans/' + Rec."Loan Application No." + '/';

                    //Set Full FIle Path
                    Rec."Document Path" := Directory + Rec."Name";
                    Rec.Date := Today;
                    Rec.time := Rec.time;

                    Rec."Member Name" := '';
                    if Members.Get(Rec."Member No.") then
                        Rec."Member Name" := Members.Name;

                    Rec.Modify;


                    //Upload to Blob Field
                    Rec.Blob.CREATEINSTREAM(InStr, TextEncoding::WINDOWS);



                    UploadBlobToRecord; //(We dont need this unless we want to save the file in the database as well)


                    DMS_.NewUploadFileToBlob(Rec."Document Path", InStr, Rec."Azure Path");
                    //DMS_.NewUploadFileToBlob(SaccoSetup."Azure Path", InStr, SaccoSetup."Azure Storage Path");

                end;
            }
            action("Open File")
            {
                ApplicationArea = Basic;
                Image = ChangeLog;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    file: File;
                    fileMan: Codeunit "File Management";
                begin
                    ///fileMan.open (file, Rec."Path");
                    if Rec."Blob Url" <> '' then
                        Hyperlink(Rec."Blob Url");
                end;
            }
        }
    }


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
