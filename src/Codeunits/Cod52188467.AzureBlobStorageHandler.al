namespace CentralDB.CentralDB;
using System.Security.Encryption;

codeunit 50135 "Azure Blob Storage Handler"
{

    SingleInstance = false;
    Subtype = Normal;

    procedure GetBlobContent(SASToken: Text[1024]; BlobURL: Text[1024]): Text;
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        Content: Text;
        ErrorMessage: Text;
    begin
        //HttpClient.DefaultRequestHeaders.Add('x-ms-version', '2020-02-10'); // Add the required headers
        //HttpClient.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + SASToken);


        HttpClient.DefaultRequestHeaders.Add('x-ms-blob-type', 'BlockBlob');
        HttpClient.DefaultRequestHeaders.Add('Date', FORMAT(CURRENTDATETIME, 0, '<Weekday Text,3>, <Day,2> <Month Text,3> <Year4> <Hour,2>:<Minute,2>:<Second,2> GMT'));

        if HttpClient.Get(BlobURL, HttpResponseMessage) then begin

            if HttpResponseMessage.IsSuccessStatusCode() then begin


                HttpResponseMessage.Content().ReadAs(Content);
                exit(Content);
            end else begin
                HttpResponseMessage.Content().ReadAs(ErrorMessage);
                Error('Failed to retrieve blob content. Status code: %1. Error message: %2', HttpResponseMessage.HttpStatusCode(), ErrorMessage);
            end;


        end else
            Error('HTTP request failed.');
    end;

    procedure UploadFileToAzureBlob(DocumentNo: Code[20]; FileName: Text; FileContent: InStream; var DocumentAttachment: Record "Cloud Document Attachment")
    var
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpResponse: HttpResponseMessage;
        BlobUrl: Text;
        AuthorizationHeader: Text;
        StorageAccountName: Text;
        StorageAccountKey: Text;
        HashAlgorithmType: Option HMACMD5,HMACSHA1,HMACSHA256,HMACSHA384,HMACSHA512;
        ContainerName: Text;
    begin
        StorageAccountName := 'yourstorageaccountname';
        ContainerName := 'businesscentral-documents';
        HashAlgorithmType := HashAlgorithmType::HMACSHA256; // Replace with the desired hashing algorithm

        // Create the authorization header
        AuthorizationHeader := CreateAuthorizationHeader(StorageAccountName, HashAlgorithmType, FileName, ContainerName);

        // Set up the HTTP request
        HttpContent.WriteFrom(FileContent);
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Clear();
        HttpHeaders.Add('x-ms-blob-type', 'BlockBlob');
        HttpHeaders.Add('x-ms-date', Format(CurrentDateTime, 0, '<Year>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>Z'));
        HttpHeaders.Add('x-ms-version', '2021-06-08');
        HttpHeaders.Add('Authorization', AuthorizationHeader);

        // Construct the Blob URL
        BlobUrl := StrSubstNo('https://%1.blob.core.windows.net/%2/%3', StorageAccountName, ContainerName, FileName);

        // Send the HTTP PUT request to upload the file
        if not HttpClient.Put(BlobUrl, HttpContent, HttpResponse) then
            Error('Failed to upload file to Azure Blob Storage.');

        if not HttpResponse.IsSuccessStatusCode then
            Error('Azure Blob Storage returned an error: %1', HttpResponse.ReasonPhrase);

        // Save metadata in Business Central
        DocumentAttachment.Init();
        DocumentAttachment."Document No." := DocumentNo; // Replace with the actual document number
        DocumentAttachment."File Name" := FileName;
        DocumentAttachment."Azure Blob URL" := BlobUrl;
        DocumentAttachment."Created Date" := Today;
        DocumentAttachment.Insert();
    end;


    local procedure CreateAuthorizationHeader(StorageAccountName: Text; HashAlgorithmType: Option HMACMD5,HMACSHA1,HMACSHA256,HMACSHA384,HMACSHA512; FileName: Text; ContainerName: Text): Text
    var
        StringToSign: Text;
        Signature: Text;
        AuthorizationHeader: Text;
    begin
        // Create the string to sign
        StringToSign := StrSubstNo(
            'PUT\n\n\n%1\n\n\n\n\n\n\n\n\n\n\nx-ms-blob-type:BlockBlob\nx-ms-date:%2\nx-ms-version:2021-06-08\n/%3/%4/%5',
            FileName,
            Format(CurrentDateTime, 0, '<Year>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>Z'),
            StorageAccountName,
            ContainerName,
            FileName
        );

        // Create the HMAC-SHA256 signature
        //Signature := CreateHMACSHA256Signature(StringToSign, HashAlgorithmType);

        // Create the authorization header
        AuthorizationHeader := StrSubstNo(
            'SharedKey %1:%2',
            StorageAccountName,
            Signature
        );

        exit(AuthorizationHeader);
    end;

    local procedure CreateHMACSHA256Signature(StringToSign: Text; SecretKey: Text; HashAlgorithmType: Option HMACMD5,HMACSHA1,HMACSHA256,HMACSHA384,HMACSHA512): Text
    var
        CryptographyManagement: Codeunit "Cryptography Management";
        SecretTextValue: SecretText;
    begin
        // Convert string key to SecretText (direct assignment works)
        SecretTextValue := SecretKey;

        // Generate the HMAC hash using the new method
        exit(CryptographyManagement.GenerateHash(StringToSign, SecretTextValue, HashAlgorithmType));
    end;
}
