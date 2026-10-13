namespace UnitedWomen.UnitedWomen;

using System.Text;
using System.Utilities;

codeunit 50149 "Coseke EDMS"
{

    trigger Onrun()
    begin
    end;

    procedure UploadDocument(
        DocumentName: Text;
        DocumentType: Text;
        FolderName: Text;
        FileExistAction: Text;
        Base64Data: Text;
        FileExtension: Text;
        Metadata: JsonObject;
        var StatusMessage: Text
    ): Boolean
    var
        HttpClient: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        JsonBody: JsonObject;
        ResponseJson: JsonObject;
        ResponseToken: JsonToken;
        RequestBodyText: Text;
        ResponseBodyText: Text;
        StatusValue: Text;
        DocumentId: Integer;
        ReturnedDocName: Text;
        PDFPath: Text;
        XMLPath: Text;
    begin
        JsonBody.Add('document_name', DocumentName);
        JsonBody.Add('document_type', DocumentType);
        JsonBody.Add('folder_name', FolderName);
        JsonBody.Add('file_exist_action', FileExistAction);
        JsonBody.Add('metadata', Metadata);
        JsonBody.Add('file_extension', FileExtension);
        JsonBody.Add('base64_data', Base64Data);

        JsonBody.WriteTo(RequestBodyText);

        HttpContent.WriteFrom(RequestBodyText);
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');

        HttpRequest.SetRequestUri(GetBaseUrl() + '/api/documents/upload-sync/');
        HttpRequest.Method := 'POST';
        HttpRequest.Content := HttpContent;

        HttpRequest.GetHeaders(HttpHeaders);
        HttpHeaders.Add('Authorization', 'ApiKey ' + GetApiKey());

        if not HttpClient.Send(HttpRequest, HttpResponse) then begin
            StatusMessage := 'HTTP request failed!! ';
            HttpResponse.Content.ReadAs(ResponseBodyText);
            StatusMessage += StrSubstNo('EDMS error %1: %2', HttpResponse.HttpStatusCode, ResponseBodyText);

            exit(false);
        end;

        HttpResponse.Content.ReadAs(ResponseBodyText);

        if not ResponseJson.ReadFrom(ResponseBodyText) then begin
            StatusMessage := 'Failed to parse EDMS response.';
            exit(false);
        end;

        if not HttpResponse.IsSuccessStatusCode then begin
            StatusMessage := StrSubstNo('EDMS error %1: %2', HttpResponse.HttpStatusCode, ResponseBodyText);
            exit(false);
        end;

        if ResponseJson.Get('document_id', ResponseToken) then
            DocumentId := ResponseToken.AsValue().AsInteger();

        if ResponseJson.Get('status', ResponseToken) then
            StatusValue := ResponseToken.AsValue().AsText();

        if ResponseJson.Get('message', ResponseToken) then
            StatusMessage := ResponseToken.AsValue().AsText();

        if ResponseJson.Get('document_name', ResponseToken) then
            ReturnedDocName := ResponseToken.AsValue().AsText();

        if ResponseJson.Get('pdf_path', ResponseToken) then
            PDFPath := ResponseToken.AsValue().AsText();

        if ResponseJson.Get('xml_path', ResponseToken) then
            XMLPath := ResponseToken.AsValue().AsText();

        exit(StatusValue = 'completed');
    end;

    local procedure GetBaseUrl(): Text
    var
        EDMSSetup: Record "Sacco Setup";
    begin
        EDMSSetup.Get();
        EDMSSetup.TestField("Coseke EDMS Base URL");
        exit(EDMSSetup."Coseke EDMS Base URL");
    end;

    local procedure GetApiKey(): Text
    var
        EDMSSetup: Record "Sacco Setup";
    begin
        EDMSSetup.Get();
        EDMSSetup.TestField("Coseke EDMS API Key");
        exit(EDMSSetup."Coseke EDMS API Key");
    end;


    procedure UploadPaymentVoucher(PaymentVoucherNo: Code[20])
    var
        PaymentVoucher: Record "Payment Header";
        EDMSUpload: Codeunit "Coseke EDMS";
        Metadata: JsonObject;
        Base64Data: Text;
        DocumentId: Integer;
        ReturnedDocName: Text;
        PDFPath: Text;
        XMLPath: Text;
        StatusMessage: Text;
        Success: Boolean;
        SaccoSetup: Record "Sacco Setup";
    begin
        SaccoSetup.Get();
        SaccoSetup.TestField("Coseke Finance Folder Name");
        PaymentVoucher.Reset();
        PaymentVoucher.SetRange("No.", PaymentVoucherNo);
        if PaymentVoucher.FindFirst() then begin


            // Build metadata specific to payment vouchers
            Metadata.Add('voucher_no', PaymentVoucherNo);
            Metadata.Add('payee', PaymentVoucher.Payee);
            Metadata.Add('amount', PaymentVoucher."Total Payment Amount");
            Metadata.Add('currency', PaymentVoucher."Currency Code");
            Metadata.Add('posted_by', PaymentVoucher."Posted By");
            Metadata.Add('branch', PaymentVoucher."Shortcut Dimension 2 Code");
            Metadata.Add('created_by', UserId());

            // Generate base64 PDF of the voucher report
            Base64Data := GenerateVoucherBase64(PaymentVoucher);

            StatusMessage := '';
            Success := EDMSUpload.UploadDocument(
                PaymentVoucherNo,   // document_name
                'Payment Voucher',                        // document_type
                SaccoSetup."Coseke Finance Folder Name",                           // folder_name
                'REPLACE',                                  // file_exist_action: ERROR, REPLACE, ADD_VERSION
                Base64Data,                               // base64_data
                'pdf',                                    // file_extension
                Metadata,
                StatusMessage                                  // metadata      
            );

            if Success then begin
                Message('Voucher uploaded to EDMS. Document: %1', ReturnedDocName);
            end else
                Error('EDMS upload failed: %1', StatusMessage);

        end
        else
            Error('Payment Voucher %1 not found.', PaymentVoucherNo);
    end;

    local procedure GenerateVoucherBase64(PaymentVoucher: Record "Payment Header"): Text
    var
        ReportOutStream: OutStream;
        ReportInStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        RecRef: RecordRef;
    begin

        RecRef.GetTable(PaymentVoucher);
        TempBlob.CreateOutStream(ReportOutStream);
        Report.SaveAs(Report::"Payment Voucher", '', ReportFormat::Pdf, ReportOutStream, RecRef);
        TempBlob.CreateInStream(ReportInStream);
        exit(Base64Convert.ToBase64(ReportInStream));
    end;


}
