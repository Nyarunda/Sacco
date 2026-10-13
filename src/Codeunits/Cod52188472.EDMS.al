codeunit 50130 EDMS
{


    trigger OnRun()
    var
        Instream: InStream;
    BEGIN
        //PAGE.RUN(50100);


        //RetrieveDocument('01445544.pdf',Instream);
        //RetrieveDocument('20000.pdf', Instream);
    END;


    local procedure Sha256Hash(ClearText: Text): Text
    var
        CryptographyManagement: codeunit "Cryptography Management";
        HashAlgorithmType: option MD5,SHA1,SHA256,SHA384,SHA512;
    begin
        exit(Text.LowerCase(CryptographyManagement.GenerateHash(ClearText, HashAlgorithmType::SHA256)));
    end;

    procedure CreateAuthorizationHeader(BlobUrl: Text; Method: Text; ContentLength: Integer; StorageAccountName: Text; StorageAccountKey: Text): Text;
    var
        Signature: Text;
        StringToSign: Text;
    begin
        DateHeader := Format(CurrentDateTime); // Current DateTime in GMT
        ContentTypeHeader := 'application/octet-stream';
        ContentLengthHeader := Format(ContentLength);

        StringToSign := Method + '\n\n\n' + ContentLengthHeader + '\n\n' + ContentTypeHeader + '\n\n\n\n\n\n\nx-ms-date:' + DateHeader + '\nx-ms-version:2017-11-09\n/' + StorageAccountName + '/' + BlobUrl;

        Signature := Sha256Hash(StringToSign);

        exit('SharedKey ' + StorageAccountName + ':' + Signature);
    end;

    procedure MakeHttpRequest(RequestMethod: Text[10]; RequestUrl: Text; RequestStreamBody: InStream; ContentType: Text) ResponseText: Text;
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        ResponseStatusCode: Integer;
    begin

        // Set the request URI
        HttpRequestMessage.SetRequestUri(RequestUrl);

        // Set the method
        HttpRequestMessage.Method := RequestMethod;

        // Prepare HttpContent from InStream
        HttpContent.WriteFrom(RequestStreamBody);

        // Set Content-Type header
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Clear();
        HttpHeaders.Add('Content-Type', ContentType);

        // Add custom headers
        HttpHeaders.Add('x-ms-blob-type', 'BlockBlob');
        HttpHeaders.Add('Date', Format(CurrentDateTime(), 0, '<Weekday Text,3>, <Day,2> <Month Text,3> <Year4> <Hour,2>:<Minute,2>:<Second,2> GMT'));

        // Set content to the request message
        HttpRequestMessage.Content := HttpContent;

        // Send the request based on the method
        case RequestMethod of
            'GET':
                HttpClient.Get(RequestUrl, HttpResponseMessage);
            'POST':
                HttpClient.Post(RequestUrl, HttpContent, HttpResponseMessage);
            'PUT':
                HttpClient.Put(RequestUrl, HttpContent, HttpResponseMessage);
            'DELETE':
                HttpClient.Delete(RequestUrl, HttpResponseMessage);
            else
                Error('Unsupported HTTP method: %1', RequestMethod);
        end;

        // Read the response status code and content
        ResponseStatusCode := HttpResponseMessage.HttpStatusCode();
        HttpResponseMessage.Content().ReadAs(ResponseText);

        // Optionally, handle the response status code here
        // Example: if not HttpResponseMessage.IsSuccessStatusCode then Error('Request failed with status code: %1', ResponseStatusCode);

        // Clean up (Dispose is handled automatically in AL)
        exit(ResponseText);
    end;

    procedure GetHttpRequest(RequestMethod: Text[10]; RequestUrl: Text; AuthorizationHeader: Text; var ResponseStatus: Integer; var ResponseStream: InStream) ResponseText: Text;
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpHeaders: HttpHeaders;
        HttpContent: HttpContent;
        BlobInStream: InStream;
        OutStream: OutStream;
        TempBlob: Record CustomTempBlob;
        htmlString: Text;
        filePath: Text;
        base64String: Text;
    begin
        // Initialize HttpClient and HttpRequestMessage
        //HttpClient := HttpClient.HttpClient();
        //HttpRquestMessage := HttpRequestMessage.HttpRequestMessage();

        // Set the request URI and method
        HttpRequestMessage.SetRequestUri(RequestUrl);
        HttpRequestMessage.Method := RequestMethod;

        // Add authorization and custom headers
        HttpClient.DefaultRequestHeaders().Add('Authorization', AuthorizationHeader);
        HttpClient.DefaultRequestHeaders().Add('x-ms-blob-type', 'BlockBlob');
        HttpClient.DefaultRequestHeaders().Add('Date', Format(CurrentDateTime(), 0, '<Weekday Text,3>, <Day,2> <Month Text,3> <Year4> <Hour,2>:<Minute,2>:<Second,2> GMT'));

        // Send the request based on the method
        case RequestMethod of
            'GET':
                HttpClient.Get(RequestUrl, HttpResponseMessage);
            'POST':
                HttpClient.Post(RequestUrl, HttpContent, HttpResponseMessage);
            'PUT':
                HttpClient.Put(RequestUrl, HttpContent, HttpResponseMessage);
            'DELETE':
                HttpClient.Delete(RequestUrl, HttpResponseMessage);
            else
                Error('Unsupported HTTP method: %1', RequestMethod);
        end;

        // Check the Response
        if HttpResponseMessage.IsSuccessStatusCode() then begin
            // Read the content into a Blob
            HttpResponseMessage.Content().ReadAs(BlobInStream);

            // Check if the response contains a file and handle content type
            HttpResponseMessage.Content().GetHeaders(HttpHeaders);

        end else
            Error('HTTP request failed with status code %1', HttpResponseMessage.HttpStatusCode());

        // Return the status code
        ResponseStatus := HttpResponseMessage.HttpStatusCode();

        exit(ResponseText);
    end;

    procedure UploadFileToBlob(FileName: Text; Content: Text);
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        BlobUrl: Text;
        ResponseText: Text;
    begin
        // Construct the full URL using the container, file name, and SAS token
        SASToken := GetSASToken();
        BlobUrl := 'https://' + StorageAccountName + '.blob.core.windows.net/' + ContainerName + '/' + FileName + '?' + SASToken;

        // Prepare the HTTP Request
        HttpRequestMessage.SetRequestUri(BlobUrl);
        HttpRequestMessage.Method := 'PUT';



        // Add the content and headers
        HttpContent.WriteFrom(Content);
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Clear();
        HttpHeaders.Add('x-ms-blob-type', 'BlockBlob');
        HttpHeaders.Add('Content-Type', 'application/octet-stream');

        HttpRequestMessage.Content := HttpContent;

        // Send the Request
        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);

        // Check the Response
        if HttpResponseMessage.IsSuccessStatusCode then
            Message('File uploaded successfully.')
        else begin
            HttpResponseMessage.Content().ReadAs(ResponseText);
            Error('Failed to upload file. Response: %1', ResponseText);
        end;
    end;




    /*
    procedure NewUploadFileToBlob(FileName: Text; var FileContent: InStream)
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        BlobUrl: Text;
        ResponseText: Text;
    begin
        // Construct the Blob URL
        BlobUrl := 'https://' + StorageAccountName + '.blob.core.windows.net/' + ContainerName + '/' + FileName + '?' + SASToken;

        // Prepare the HTTP Request
        HttpRequestMessage.SetRequestUri(BlobUrl);
        HttpRequestMessage.Method := 'PUT';

        // Add the content and headers
        HttpContent.WriteFrom(FileContent); // Use the InStream from TempBlob
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Clear();
        HttpHeaders.Add('x-ms-blob-type', 'BlockBlob');
        HttpHeaders.Add('Content-Type', 'application/octet-stream');

        HttpRequestMessage.Content := HttpContent;

        // Send the Request
        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);

        // Check the Response
        if HttpResponseMessage.IsSuccessStatusCode then
            Message('File uploaded successfully.')
        else begin
            HttpResponseMessage.Content().ReadAs(ResponseText);
            Error('Failed to upload file. Response: %1', ResponseText);
        end;
    end;
    */
    local procedure GetSASToken(): Text
    var
        myInt: Integer;
    begin
        SaccoSet.Get();
        exit(SaccoSet."Azure Storage SASToken");
    end;

    procedure NewUploadFileToBlob(FileName: Text; var FileContent: InStream; var BlobUrl: Text) Uploaded: Boolean;
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;

        ResponseText: Text;
    begin
        SASToken := GetSASToken();
        Uploaded := false;
        // Construct the Blob URL
        BlobUrl := 'https://' + StorageAccountName + '.blob.core.windows.net/' + ContainerName + '/' + FileName + '?' + SASToken;

        // Prepare the HTTP Request
        HttpRequestMessage.SetRequestUri(BlobUrl);
        HttpRequestMessage.Method := 'PUT';

        // Add the content and headers
        HttpContent.WriteFrom(FileContent);
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Clear();
        HttpHeaders.Add('x-ms-blob-type', 'BlockBlob');
        HttpHeaders.Add('Content-Type', 'application/octet-stream');

        HttpRequestMessage.Content := HttpContent;

        // Send the Request
        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);

        // Check the Response
        if HttpResponseMessage.IsSuccessStatusCode then begin

            Uploaded := true;
            Message('File uploaded successfully.');

        end
        else begin
            BlobUrl := '';
            HttpResponseMessage.Content().ReadAs(ResponseText);
            Error('Failed to upload file. Response: %1', ResponseText);
        end;
    end;


    procedure NewDownloadFileFromBlob(FileName: Text): Text;
    var
        BlobUrl: Text;
        FileContent: InStream;
        ResponseText: Text;
    //pdfViewer: DotNet PdfImageViewerLibrary;
    begin
        // Construct the full URL using the container, file name, and SAS token
        SASToken := GetSASToken();
        BlobUrl := 'https://' + StorageAccountName + '.blob.core.windows.net/' + ContainerName + '/' + FileName + '?' + SASToken;


        /* pdfViewer := pdfViewer.PdfImageViewer();

        pdfViewer.ShowPdfFromFilePath(BlobUrl); */
        // Open the document in the default web browser
        HYPERLINK(BlobUrl);

        // Alternatively, if you want to read the content as text
        // HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        // HttpResponseMessage.Content().ReadAs(ResponseText);
        // exit(ResponseText);
    end;








    procedure DownloadFileFromBlob(FileName: Text): Text;
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        ResponseText: Text;
    begin
        // Construct the full URL using the container, file name, and SAS token
        SASToken := GetSASToken();
        BlobUrl := 'https://' + StorageAccountName + '.blob.core.windows.net/' + ContainerName + '/' + FileName + '?' + SASToken;

        // Prepare the HTTP Request
        HttpRequestMessage.SetRequestUri(BlobUrl);
        HttpRequestMessage.Method := 'GET';

        // Send the Request
        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);

        // Check the Response
        if HttpResponseMessage.IsSuccessStatusCode then begin
            HttpResponseMessage.Content().ReadAs(ResponseText);
            Message('File downloaded successfully.');
            exit(ResponseText);
        end else begin
            HttpResponseMessage.Content().ReadAs(ResponseText);
            Error('Failed to download file. Response: %1', ResponseText);
        end;
    end;

    procedure TestBlobStorageWithSAS();
    var
        UploadedContent: Text;
        RetrievedContent: Text;
    begin

        UploadedContent := 'This is a test content for Azure Blob Storage with SAS Token.';
        UploadFileToBlob('example.txt', UploadedContent);

        RetrievedContent := DownloadFileFromBlob('example.txt');
        Message('Retrieved Content: %1', RetrievedContent);
    end;

    procedure GenerateBlobUrl(FileName: Text): Text;
    var
        BlobUrl: Text;
    begin
        // Construct the full URL using the container, file name, and SAS token
        SASToken := GetSASToken();
        BlobUrl := 'https://' + ContainerName + '.blob.core.windows.net/' + ContainerName + '/' + FileName + '?' + SASToken;
        exit(BlobUrl);
    end;

    procedure OpenDocumentInBrowser(ContainerName: Text; FileName: Text);
    var
        BlobUrl: Text;
    begin
        // Generate the Blob URL
        BlobUrl := GenerateBlobUrl(FileName);

        // Open the document in the default web browser
        HYPERLINK(BlobUrl);
    end;




    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Content: HttpContent;
        BlobUrl: Text;
        StorageAccountKey: Text;
        FileName: Text;
        ContentBytes: Text;
        AuthorizationHeader: Text;
        DateHeader: Text;
        ContentLengthHeader: Text;
        ContentTypeHeader: Text;
        ResponseText: Text;
        SaccoSet: Record "Sacco Setup";
        Base64Converter: Codeunit "Base64 Convert";
        //StorageAccountName: label 'edms';
        //ContainerName: label 'edms-test';

        //SASToken: label 'st=2024-04-09T01:22:11Z&se=2050-12-31T09:22:11Z&si=test&sv=2022-11-02&sr=c&sig=7tBLLc0X518gadPNNP%2FEUXCRwCXWoaj%2FSQzu4oLcakI%3D';
        SASToken: Text;
        //label 'sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2036-01-01T14:12:50Z&st=2025-01-23T06:12:50Z&spr=https&sig=Tnlomm8%2Bg4%2BR8JNmIags%2FuRifbsOu1HHOV6lv3r7vTQ%3D';
        StorageAccountName: label 'calwideportaldocs';
        ContainerName: label 'portal-v1';

    //sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2036-01-01T14:12:50Z&st=2025-01-23T06:12:50Z&spr=https&sig=Tnlomm8%2Bg4%2BR8JNmIags%2FuRifbsOu1HHOV6lv3r7vTQ%3D
    //https://calwideportaldocs.blob.core.windows.net/portal-v1?sp=rcw&st=2025-01-13T10:09:37Z&se=2025-01-13T18:09:37Z&spr=https&sv=2022-11-02&sr=c&sig=7kPnHM9dn2h498uJHJ5Ia1NlIm2vuwLEKy19x61yu7M%3D


}
