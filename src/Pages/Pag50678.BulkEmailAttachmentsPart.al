page 51204 "Bulk Email Attachments Part"
{
    ApplicationArea = All;
    Caption = 'Bulk Email Attachments';
    PageType = ListPart;
    SourceTable = "Bulk Email Attachment";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Enabled; Rec.Enabled) { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field("File Name"; Rec."File Name") { ApplicationArea = All; Editable = false; }
                field("Source File Path"; Rec."Source File Path") { ApplicationArea = All; }
                field("Mime Type"; Rec."Mime Type") { ApplicationArea = All; Editable = false; }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(UploadAttachment)
            {
                ApplicationArea = All;
                Caption = 'Upload Attachment';
                Image = Import;

                trigger OnAction()
                var
                    FileName: Text;
                    InStr: InStream;
                begin
                    if not UploadIntoStream('Select PDF attachment', '', 'PDF Files (*.pdf)|*.pdf|All Files (*.*)|*.*', FileName, InStr) then
                        exit;

                    Rec.SetUploadedFile(FileName, InStr);
                    Rec.Modify(true);
                end;
            }
            action(ClearAttachment)
            {
                ApplicationArea = All;
                Caption = 'Clear Attachment';
                Image = ClearLog;

                trigger OnAction()
                begin
                    Rec.ClearUploadedFile();
                    Rec.Modify(true);
                end;
            }
        }
    }
}
