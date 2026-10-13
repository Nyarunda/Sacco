namespace Wanandage.Wanandage;
using System.IO;
using Microsoft.EServices.EDocument;
using System.Integration;
using Microsoft.Foundation.Attachment;
using System.Utilities;
using Microsoft.CRM.Outlook;
using Microsoft.Finance.VAT.Reporting;


page 50747 "Loan Attachment Details"
{
    Caption = 'Loan Attachment Details';
    DelayedInsert = true;
    Editable = true;
    PageType = List;
    SourceTable = "Loan Attachments";
    SourceTableView = SORTING(ID, "Table ID");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Name; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the filename of the attachment.';

                    trigger OnDrillDown()
                    var
                        Selection: Integer;
                    begin
                        /*if Rec."Document Reference ID".HasValue then
                            REc.Export(true)
                        else
                            if not IsOfficeAddin or not EmailHasAttachments then
                                InitiateUploadFile()
                            else begin
                                Selection := StrMenu(MenuOptionsTxt, 1, SelectInstructionTxt);
                                case
                                    Selection of
                                    1:
                                        InitiateAttachFromEmail();
                                    2:
                                        InitiateUploadFile();
                                end;
                            end;
                            */
                    end;
                }

                field("Doc. Desc."; Rec."Doc. Desc.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the file extension of the attachment.';
                }
                field("Document Reference ID"; Rec."Document Reference ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the type of document that the attachment is.';
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the user who attached the document.';
                }
                field("Attached Date"; Rec."Attached Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the date when the document was attached.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            /* action(OpenInOneDrive)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Open in OneDrive';
                ToolTip = 'Copy the file to your Business Central folder in OneDrive and open it in a new window so you can manage or share the file.', Comment = 'OneDrive should not be translated';
                Image = Cloud;
                Enabled = ShareOptionsEnabled;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                Visible = ShareOptionsVisible;
                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    DocumentServiceMgt: Codeunit "Document Service Management";
                    FileName: Text;
                    FileExtension: Text;
                begin
                    FileName := FileManagement.StripNotsupportChrInFileName(Rec."File Name");
                    FileExtension := StrSubstNo(FileExtensionLbl, Rec."File Extension");

                    DocumentServiceMgt.OpenInOneDriveFromMedia(FileName, FileExtension, "Document Reference ID".MediaId());
                end;
            }
            action(ShareWithOneDrive)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Share';
                ToolTip = 'Copy the file to your Business Central folder in OneDrive and share the file. You can also see who it''s already shared with.', Comment = 'OneDrive should not be translated';
                Image = Share;
                Enabled = ShareOptionsEnabled;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                Visible = ShareOptionsVisible;
                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    DocumentServiceMgt: Codeunit "Document Service Management";
                    FileName: Text;
                    FileExtension: Text;
                begin
                    FileName := FileManagement.StripNotsupportChrInFileName(Rec."File Name");
                    FileExtension := StrSubstNo(FileExtensionLbl, Rec."File Extension");

                    DocumentServiceMgt.ShareWithOneDriveFromMedia(FileName, FileExtension, "Document Reference ID".MediaId());
                end;
            } */
            action(UloadFileAzure)
            {
                ApplicationArea = All;
                Caption = 'Upload File To Azure';
                Image = Import;
                Enabled = true;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    FileName: Text;
                    FileContent: InStream;
                    AzureBlobHandler: Codeunit CentralDB.CentralDB."Azure Blob Storage Handler";
                    DocumentAttachment: Record "CLoud Document Attachment";
                begin
                    if UploadIntoStream('Select a file to upload', '', '', FileName, FileContent) then begin
                        AzureBlobHandler.UploadFileToAzureBlob(Rec."Document No.", FileName, FileContent, DocumentAttachment);
                        Message('File uploaded successfully.');
                    end;
                end;
            }
            action(AttachFromEmail)
            {
                ApplicationArea = All;
                Caption = 'Attach from email';
                Image = Email;
                Enabled = EmailHasAttachments;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Page;
                ToolTip = 'Attach files directly from email.';
                Visible = IsOfficeAddin;

                trigger OnAction()
                begin
                    InitiateAttachFromEmail();
                end;
            }
            action(Preview)
            {
                ApplicationArea = All;
                Caption = 'Download';
                Image = Download;
                Enabled = DowbloadEnabled;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Download the file to your device. Depending on the file, you will need an app to view or edit the file.';

                trigger OnAction()
                begin
                    // if Rec."File Name" <> '' then
                    //     Rec.Export(true);
                end;
            }
            action(UploadFile)
            {
                ApplicationArea = All;
                Caption = 'Upload file';
                Image = Document;
                Enabled = true;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Page;
                ToolTip = 'Upload file';
                Visible = IsOfficeAddin;

                trigger OnAction()
                begin
                    InitiateUploadFile();
                end;
            }
        }
    }

    trigger OnInit()
    begin
        FlowFieldsEditable := true;
        IsOfficeAddin := OfficeMgmt.IsAvailable();
        ShareOptionsVisible := false;

        /*  if IsOfficeAddin then
             EmailHasAttachments := OfficeHostMgmt.EmailHasAttachments()
         else begin
             EmailHasAttachments := false;
             ShareOptionsVisible := NOT OfficeMgmt.IsPopOut();
         end; */
    end;

    trigger OnAfterGetCurrRecord()
    var
        DocumentSharing: Codeunit "Document Sharing";
    begin
        ShareOptionsEnabled := (Rec."Document Reference ID".HasValue()) and (DocumentSharing.ShareEnabled());
        DowbloadEnabled := Rec."Document Reference ID".HasValue();
    end;

    procedure OpenForRecRef(RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        LineNo: Integer;
        VATRepConfigType: Enum "VAT Report Configuration";
    begin
        Rec.Reset;

        FromRecRef := RecRef;

        Rec.SetRange("Table ID", 50067);

        if RecRef.Number = DATABASE::Loans then begin
            Rec.SetRange("Document No.", RecNo);
        end;

        case RecRef.Number of
            DATABASE::Loans:
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    Rec.SetRange("Document No.", RecNo);
                end;
        end;


        //OnAfterOpenForRecRef(Rec, RecRef, FlowFieldsEditable);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."File Name" := SelectFileTxt;
    end;

    var
        OfficeMgmt: Codeunit "Office Management";
        OfficeHostMgmt: Codeunit "Office Host Management";
        SalesDocumentFlow: Boolean;
        FileExtensionLbl: Label '.%1', Locked = true;
        FileDialogTxt: Label 'Attachments (%1)|%1', Comment = '%1=file types, such as *.txt or *.docx';
        FilterTxt: Label '*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.tiff;*.tif;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.msg;*.xml;*.*', Locked = true;
        ImportTxt: Label 'Attach a document.';
        SelectFileTxt: Label 'Attach File(s)...';
        PurchaseDocumentFlow: Boolean;
        ShareOptionsEnabled: Boolean;
        LoanApp: Record Loans;
        //AppDocs: Record "Attachment Documents";
        DowbloadEnabled: Boolean;
        FlowToPurchTxt: Label 'Flow to Purch. Trx';
        FlowToSalesTxt: Label 'Flow to Sales Trx';
        FlowFieldsEditable: Boolean;
        EmailHasAttachments: Boolean;
        IsOfficeAddin: Boolean;
        MenuOptionsTxt: Label 'Attach from email,Upload file', Comment = 'Comma seperated phrases must be translated seperately.';
        SelectInstructionTxt: Label 'Choose the files to attach.';
        ShareOptionsVisible: Boolean;

    protected var
        FromRecRef: RecordRef;

    local procedure InitiateAttachFromEmail()
    begin
        OfficeMgmt.InitiateSendToAttachments(FromRecRef);
        CurrPage.Update(true);
    end;

    local procedure InitiateUploadFile()
    var
        DocumentAttachment: Record "Loan Attachments";
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
    begin
        /*  ImportWithFilter(TempBlob, FileName);
         if FileName <> '' then
             DocumentAttachment.SaveAttachment(FromRecRef, FileName, TempBlob);
         CurrPage.Update(true); */
    end;

    local procedure ImportWithFilter(var TempBlob: Codeunit "Temp Blob"; var FileName: Text)
    var
        FileManagement: Codeunit "File Management";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeImportWithFilter(TempBlob, FileName, IsHandled);
        if IsHandled then
            exit;

        FileName := FileManagement.BLOBImportWithFilter(
            TempBlob, ImportTxt, FileName, StrSubstNo(FileDialogTxt, FilterTxt), FilterTxt);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Loan Attachments"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeImportWithFilter(var TempBlob: Codeunit "Temp Blob"; var FileName: Text; var IsHandled: Boolean)
    begin
    end;
}
