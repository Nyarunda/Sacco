codeunit 50896 "Loan Schedule Import Mgt."
{
    procedure ImportBatch(Payload: Text): Text
    var
        Root: JsonObject;
        LinesToken: JsonToken;
        LinesArray: JsonArray;
        LineToken: JsonToken;
        LineObject: JsonObject;
        ResponseObject: JsonObject;
        ResponsePayload: JsonObject;
        ErrorsArray: JsonArray;
        ErrorObject: JsonObject;
        BatchId: Text;
        SuccessCount: Integer;
        ErrorCount: Integer;
        Index: Integer;
        ErrorText: Text;
        Response: Text;
        DeletedLoans: List of [Code[20]];
    begin
        if Payload = '' then
            exit(BuildErrorResponse('', 'EMPTY_PAYLOAD', 'Payload cannot be empty.'));

        BatchId := CreateGuidAsText();

        if not Root.ReadFrom(Payload) then
            exit(BuildErrorResponse('', 'INVALID_JSON', 'Invalid JSON payload.'));

        if not Root.Get('lines', LinesToken) then
            exit(BuildErrorResponse(BatchId, 'MISSING_LINES', 'Missing lines array.'));

        if not LinesToken.IsArray() then
            exit(BuildErrorResponse(BatchId, 'INVALID_LINES', 'The lines property must be an array.'));

        LinesArray := LinesToken.AsArray();

        if LinesArray.Count() = 0 then
            exit(BuildErrorResponse(BatchId, 'EMPTY_LINES', 'Lines array cannot be empty.'));

        foreach LineToken in LinesArray do begin
            Index += 1;

            if not LineToken.IsObject() then begin
                ErrorCount += 1;

                Clear(ErrorObject);
                ErrorObject.Add('index', Index);
                ErrorObject.Add('error_code', 'INVALID_LINE_OBJECT');
                ErrorObject.Add('error_message', 'Line must be a JSON object.');
                ErrorsArray.Add(ErrorObject);
            end else begin
                LineObject := LineToken.AsObject();


                DeleteExistingScheduleOnce(LineObject, DeletedLoans);

                ClearLastError();

                if TryImportLine(LineObject) then
                    SuccessCount += 1
                else begin
                    ErrorCount += 1;
                    ErrorText := GetLastErrorText();

                    Clear(ErrorObject);
                    ErrorObject.Add('index', Index);
                    ErrorObject.Add('loan_no', GetCode(LineObject, 'loanNo'));
                    ErrorObject.Add('member_no', GetCode(LineObject, 'memberNo'));
                    ErrorObject.Add('line_no', GetInteger(LineObject, 'lineNo'));
                    ErrorObject.Add('repayment_date', GetText(LineObject, 'repaymentDate'));
                    ErrorObject.Add('error_code', 'LINE_IMPORT_ERROR');
                    ErrorObject.Add('error_message', ErrorText);
                    ErrorsArray.Add(ErrorObject);
                end;
            end;
        end;

        ResponsePayload.Add('batch_id', BatchId);
        ResponsePayload.Add('success_count', SuccessCount);
        ResponsePayload.Add('error_count', ErrorCount);
        ResponsePayload.Add('total_count', LinesArray.Count());
        ResponsePayload.Add('errors', ErrorsArray);

        if ErrorCount = 0 then begin
            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'Loan schedule batch imported successfully.');
        end else begin
            if SuccessCount > 0 then begin
                ResponseObject.Add('request_status', 'PARTIAL_SUCCESS');
                ResponseObject.Add('request_status_description', 'Loan schedule batch imported with some errors.');
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                ResponseObject.Add('request_status_description', 'Loan schedule batch import failed.');
            end;
        end;

        ResponseObject.Add('response_payload', ResponsePayload);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    procedure ImportMemberImages(Payload: Text): Text
    var
        Root: JsonObject;
        ImagesToken: JsonToken;
        ImagesArray: JsonArray;
        ImageToken: JsonToken;
        ImageObject: JsonObject;
        ResponseObject: JsonObject;
        ResponsePayload: JsonObject;
        ErrorsArray: JsonArray;
        ErrorObject: JsonObject;
        BatchId: Text;
        SuccessCount: Integer;
        ErrorCount: Integer;
        Index: Integer;
        ErrorText: Text;
        Response: Text;
    begin
        if Payload = '' then
            exit(BuildErrorResponse('', 'EMPTY_PAYLOAD', 'Payload cannot be empty.'));

        if not Root.ReadFrom(Payload) then
            exit(BuildErrorResponse('', 'INVALID_JSON', 'Invalid JSON payload.'));

        BatchId := GetText(Root, 'batchId');

        if BatchId = '' then
            BatchId := CreateGuidAsText();

        if not Root.Get('images', ImagesToken) then
            exit(BuildErrorResponse(BatchId, 'MISSING_IMAGES', 'Missing images array.'));

        if not ImagesToken.IsArray() then
            exit(BuildErrorResponse(BatchId, 'INVALID_IMAGES', 'The images property must be an array.'));

        ImagesArray := ImagesToken.AsArray();

        if ImagesArray.Count() = 0 then
            exit(BuildErrorResponse(BatchId, 'EMPTY_IMAGES', 'Images array cannot be empty.'));

        foreach ImageToken in ImagesArray do begin
            Index += 1;

            if not ImageToken.IsObject() then begin
                ErrorCount += 1;

                Clear(ErrorObject);
                ErrorObject.Add('index', Index);
                ErrorObject.Add('error_code', 'INVALID_IMAGE_OBJECT');
                ErrorObject.Add('error_message', 'Image line must be a JSON object.');
                ErrorsArray.Add(ErrorObject);
            end else begin
                ImageObject := ImageToken.AsObject();

                ClearLastError();

                if TryImportMemberImage(ImageObject) then
                    SuccessCount += 1
                else begin
                    ErrorCount += 1;
                    ErrorText := GetLastErrorText();

                    Clear(ErrorObject);
                    ErrorObject.Add('index', Index);
                    ErrorObject.Add('old_member_no', GetCode(ImageObject, 'memberNo'));
                    ErrorObject.Add('error_code', 'IMAGE_IMPORT_ERROR');
                    ErrorObject.Add('error_message', ErrorText);
                    ErrorsArray.Add(ErrorObject);
                end;
            end;
        end;

        ResponsePayload.Add('batch_id', BatchId);
        ResponsePayload.Add('success_count', SuccessCount);
        ResponsePayload.Add('error_count', ErrorCount);
        ResponsePayload.Add('total_count', ImagesArray.Count());
        ResponsePayload.Add('errors', ErrorsArray);

        if ErrorCount = 0 then begin
            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'Member images imported successfully.');
        end else
            if SuccessCount > 0 then begin
                ResponseObject.Add('request_status', 'PARTIAL_SUCCESS');
                ResponseObject.Add('request_status_description', 'Member images imported with some errors.');
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                ResponseObject.Add('request_status_description', 'Member image import failed.');
            end;

        ResponseObject.Add('response_payload', ResponsePayload);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    procedure ImportMemberLedger(Payload: Text): Text
    var
        Root: JsonObject;
        LinesToken: JsonToken;
        LinesArray: JsonArray;
        LineToken: JsonToken;
        LineObject: JsonObject;
        ResponseObject: JsonObject;
        ResponsePayload: JsonObject;
        ErrorsArray: JsonArray;
        ErrorObject: JsonObject;
        BatchId: Text;
        SuccessCount: Integer;
        ErrorCount: Integer;
        Index: Integer;
        ErrorText: Text;
        Response: Text;
    begin
        if Payload = '' then
            exit(BuildErrorResponse('', 'EMPTY_PAYLOAD', 'Payload cannot be empty.'));

        if not Root.ReadFrom(Payload) then
            exit(BuildErrorResponse('', 'INVALID_JSON', 'Invalid JSON payload.'));

        BatchId := GetText(Root, 'batchId');

        if BatchId = '' then
            BatchId := CreateGuidAsText();

        // Expected JSON:
        // {
        //   "batchId": "...",
        //   "lines": [
        //      { "entryNo": 1, "accountNo": "...", ... }
        //   ]
        // }
        if not Root.Get('lines', LinesToken) then
            exit(BuildErrorResponse(BatchId, 'MISSING_LINES', 'Missing lines array.'));

        if not LinesToken.IsArray() then
            exit(BuildErrorResponse(BatchId, 'INVALID_LINES', 'The lines property must be an array.'));

        LinesArray := LinesToken.AsArray();

        if LinesArray.Count() = 0 then
            exit(BuildErrorResponse(BatchId, 'EMPTY_LINES', 'Lines array cannot be empty.'));

        foreach LineToken in LinesArray do begin
            Index += 1;

            if not LineToken.IsObject() then begin
                ErrorCount += 1;

                Clear(ErrorObject);
                ErrorObject.Add('index', Index);
                ErrorObject.Add('error_code', 'INVALID_LINE_OBJECT');
                ErrorObject.Add('error_message', 'Line must be a JSON object.');
                ErrorsArray.Add(ErrorObject);
            end else begin
                LineObject := LineToken.AsObject();

                ClearLastError();

                if TryImportMemberLedgerLine(LineObject) then
                    SuccessCount += 1
                else begin
                    ErrorCount += 1;
                    ErrorText := GetLastErrorText();

                    Clear(ErrorObject);
                    ErrorObject.Add('index', Index);
                    ErrorObject.Add('entry_no', GetInteger(LineObject, 'entryNo'));
                    ErrorObject.Add('account_no', GetCode(LineObject, 'accountNo'));
                    ErrorObject.Add('customer_no', GetCode(LineObject, 'customerNo'));
                    ErrorObject.Add('document_no', GetCode(LineObject, 'documentNo'));
                    ErrorObject.Add('error_code', 'MEMBER_LEDGER_IMPORT_ERROR');
                    ErrorObject.Add('error_message', ErrorText);
                    ErrorsArray.Add(ErrorObject);
                end;
            end;
        end;

        ResponsePayload.Add('batch_id', BatchId);
        ResponsePayload.Add('success_count', SuccessCount);
        ResponsePayload.Add('error_count', ErrorCount);
        ResponsePayload.Add('total_count', LinesArray.Count());
        ResponsePayload.Add('errors', ErrorsArray);

        if ErrorCount = 0 then begin
            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'Member ledger entries imported successfully.');
        end else
            if SuccessCount > 0 then begin
                ResponseObject.Add('request_status', 'PARTIAL_SUCCESS');
                ResponseObject.Add('request_status_description', 'Member ledger entries imported with some errors.');
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                ResponseObject.Add('request_status_description', 'Member ledger entry import failed.');
            end;

        ResponseObject.Add('response_payload', ResponsePayload);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    [TryFunction]
    local procedure TryImportMemberLedgerLine(LineObject: JsonObject)
    var
        MemberLedgerMigration: Record "Member Ledger Entry Migration";
        EntryNo: Integer;
    begin
        EntryNo := GetInteger(LineObject, 'entryNo');

        if EntryNo = 0 then
            Error('Entry No. is required.');

        // Upsert by Entry No.
        MemberLedgerMigration.Reset();
        MemberLedgerMigration.SetRange("Entry No.",EntryNo);
        if MemberLedgerMigration.FindFirst() then begin
            UpdateMemberLedgerMigrationFields(MemberLedgerMigration, LineObject);
            MemberLedgerMigration.Modify(true);
        end else begin
            MemberLedgerMigration.Init();
            MemberLedgerMigration."Entry No." := EntryNo;
            UpdateMemberLedgerMigrationFields(MemberLedgerMigration, LineObject);
            MemberLedgerMigration.Insert(true);
        end;
    end;

    local procedure UpdateMemberLedgerMigrationFields(var MemberLedgerMigration: Record "Member Ledger Entry Migration"; LineObject: JsonObject)
    var
        TransactionTypeText: Text;
    begin
        MemberLedgerMigration."Customer No." := CopyStr(GetCode(LineObject, 'customerNo'), 1, MaxStrLen(MemberLedgerMigration."Customer No."));
        MemberLedgerMigration.Posted := GetBoolean(LineObject, 'posted');
        MemberLedgerMigration."Posting Date" := GetDate(LineObject, 'postingDate');
        MemberLedgerMigration."Document No." := CopyStr(GetCode(LineObject, 'documentNo'), 1, MaxStrLen(MemberLedgerMigration."Document No."));
        MemberLedgerMigration.Description := CopyStr(GetText(LineObject, 'description'), 1, MaxStrLen(MemberLedgerMigration.Description));
        MemberLedgerMigration.Amount := GetDecimal(LineObject, 'amount');
        MemberLedgerMigration."Amount (LCY)" := GetDecimal(LineObject, 'amountLCY');
        MemberLedgerMigration."Transaction No." := GetInteger(LineObject, 'transactionNo');
        MemberLedgerMigration.Reversed := GetBoolean(LineObject, 'reversed');
        MemberLedgerMigration."Reversed by Entry No." := GetInteger(LineObject, 'reversedByEntryNo');
        MemberLedgerMigration."Reversed Entry No." := GetInteger(LineObject, 'reversedEntryNo');
        MemberLedgerMigration."Loan No" := CopyStr(GetCode(LineObject, 'loanNo'), 1, MaxStrLen(MemberLedgerMigration."Loan No"));
        MemberLedgerMigration."Transaction Type" := GetInteger(LineObject, 'transactionType');
    end;

    procedure ImportBankAccountLedger(Payload: Text): Text
    var
        Root: JsonObject;
        LinesToken: JsonToken;
        LinesArray: JsonArray;
        LineToken: JsonToken;
        LineObject: JsonObject;
        ResponseObject: JsonObject;
        ResponsePayload: JsonObject;
        ErrorsArray: JsonArray;
        ErrorObject: JsonObject;
        BatchId: Text;
        SuccessCount: Integer;
        ErrorCount: Integer;
        Index: Integer;
        ErrorText: Text;
        Response: Text;
    begin
        if Payload = '' then
            exit(BuildErrorResponse('', 'EMPTY_PAYLOAD', 'Payload cannot be empty.'));

        if not Root.ReadFrom(Payload) then
            exit(BuildErrorResponse('', 'INVALID_JSON', 'Invalid JSON payload.'));

        BatchId := GetText(Root, 'batchId');

        if BatchId = '' then
            BatchId := CreateGuidAsText();

        if not Root.Get('lines', LinesToken) then
            exit(BuildErrorResponse(BatchId, 'MISSING_LINES', 'Missing lines array.'));

        if not LinesToken.IsArray() then
            exit(BuildErrorResponse(BatchId, 'INVALID_LINES', 'The lines property must be an array.'));

        LinesArray := LinesToken.AsArray();

        if LinesArray.Count() = 0 then
            exit(BuildErrorResponse(BatchId, 'EMPTY_LINES', 'Lines array cannot be empty.'));

        foreach LineToken in LinesArray do begin
            Index += 1;

            if not LineToken.IsObject() then begin
                ErrorCount += 1;

                Clear(ErrorObject);
                ErrorObject.Add('index', Index);
                ErrorObject.Add('error_code', 'INVALID_LINE_OBJECT');
                ErrorObject.Add('error_message', 'Line must be a JSON object.');
                ErrorsArray.Add(ErrorObject);
            end else begin
                LineObject := LineToken.AsObject();

                ClearLastError();

                if TryImportBankAccountLedgerLine(LineObject) then
                    SuccessCount += 1
                else begin
                    ErrorCount += 1;
                    ErrorText := GetLastErrorText();

                    Clear(ErrorObject);
                    ErrorObject.Add('index', Index);
                    ErrorObject.Add('entry_no', GetInteger(LineObject, 'entryNo'));
                    ErrorObject.Add('bank_account_no', GetCode(LineObject, 'bankAccountNo'));
                    ErrorObject.Add('document_no', GetCode(LineObject, 'documentNo'));
                    ErrorObject.Add('error_code', 'BANK_LEDGER_IMPORT_ERROR');
                    ErrorObject.Add('error_message', ErrorText);
                    ErrorsArray.Add(ErrorObject);
                end;
            end;
        end;

        ResponsePayload.Add('batch_id', BatchId);
        ResponsePayload.Add('success_count', SuccessCount);
        ResponsePayload.Add('error_count', ErrorCount);
        ResponsePayload.Add('total_count', LinesArray.Count());
        ResponsePayload.Add('errors', ErrorsArray);

        if ErrorCount = 0 then begin
            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'Bank account ledger entries imported successfully.');
        end else
            if SuccessCount > 0 then begin
                ResponseObject.Add('request_status', 'PARTIAL_SUCCESS');
                ResponseObject.Add('request_status_description', 'Bank account ledger entries imported with some errors.');
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                ResponseObject.Add('request_status_description', 'Bank account ledger entry import failed.');
            end;

        ResponseObject.Add('response_payload', ResponsePayload);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    procedure ImportVendorLedger(Payload: Text): Text
    var
        Root: JsonObject;
        LinesToken: JsonToken;
        LinesArray: JsonArray;
        LineToken: JsonToken;
        LineObject: JsonObject;
        ResponseObject: JsonObject;
        ResponsePayload: JsonObject;
        ErrorsArray: JsonArray;
        ErrorObject: JsonObject;
        BatchId: Text;
        SuccessCount: Integer;
        ErrorCount: Integer;
        Index: Integer;
        ErrorText: Text;
        Response: Text;
    begin
        if Payload = '' then
            exit(BuildErrorResponse('', 'EMPTY_PAYLOAD', 'Payload cannot be empty.'));

        if not Root.ReadFrom(Payload) then
            exit(BuildErrorResponse('', 'INVALID_JSON', 'Invalid JSON payload.'));

        BatchId := GetText(Root, 'batchId');

        if BatchId = '' then
            BatchId := CreateGuidAsText();

        if not Root.Get('lines', LinesToken) then
            exit(BuildErrorResponse(BatchId, 'MISSING_LINES', 'Missing lines array.'));

        if not LinesToken.IsArray() then
            exit(BuildErrorResponse(BatchId, 'INVALID_LINES', 'The lines property must be an array.'));

        LinesArray := LinesToken.AsArray();

        if LinesArray.Count() = 0 then
            exit(BuildErrorResponse(BatchId, 'EMPTY_LINES', 'Lines array cannot be empty.'));

        foreach LineToken in LinesArray do begin
            Index += 1;

            if not LineToken.IsObject() then begin
                ErrorCount += 1;

                Clear(ErrorObject);
                ErrorObject.Add('index', Index);
                ErrorObject.Add('error_code', 'INVALID_LINE_OBJECT');
                ErrorObject.Add('error_message', 'Line must be a JSON object.');
                ErrorsArray.Add(ErrorObject);
            end else begin
                LineObject := LineToken.AsObject();

                ClearLastError();

                if TryImportVendorLedgerLine(LineObject) then
                    SuccessCount += 1
                else begin
                    ErrorCount += 1;
                    ErrorText := GetLastErrorText();

                    Clear(ErrorObject);
                    ErrorObject.Add('index', Index);
                    ErrorObject.Add('entry_no', GetInteger(LineObject, 'entryNo'));
                    ErrorObject.Add('vendor_no', GetCode(LineObject, 'vendorNo'));
                    ErrorObject.Add('document_no', GetCode(LineObject, 'documentNo'));
                    ErrorObject.Add('error_code', 'VENDOR_LEDGER_IMPORT_ERROR');
                    ErrorObject.Add('error_message', ErrorText);
                    ErrorsArray.Add(ErrorObject);
                end;
            end;
        end;

        ResponsePayload.Add('batch_id', BatchId);
        ResponsePayload.Add('success_count', SuccessCount);
        ResponsePayload.Add('error_count', ErrorCount);
        ResponsePayload.Add('total_count', LinesArray.Count());
        ResponsePayload.Add('errors', ErrorsArray);

        if ErrorCount = 0 then begin
            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'Vendor ledger entries imported successfully.');
        end else
            if SuccessCount > 0 then begin
                ResponseObject.Add('request_status', 'PARTIAL_SUCCESS');
                ResponseObject.Add('request_status_description', 'Vendor ledger entries imported with some errors.');
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                ResponseObject.Add('request_status_description', 'Vendor ledger entry import failed.');
            end;

        ResponseObject.Add('response_payload', ResponsePayload);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    procedure ImportDetailedVendorLedger(Payload: Text): Text
    var
        Root: JsonObject;
        LinesToken: JsonToken;
        LinesArray: JsonArray;
        LineToken: JsonToken;
        LineObject: JsonObject;
        ResponseObject: JsonObject;
        ResponsePayload: JsonObject;
        ErrorsArray: JsonArray;
        ErrorObject: JsonObject;
        BatchId: Text;
        SuccessCount: Integer;
        ErrorCount: Integer;
        Index: Integer;
        ErrorText: Text;
        Response: Text;
    begin
        if Payload = '' then
            exit(BuildErrorResponse('', 'EMPTY_PAYLOAD', 'Payload cannot be empty.'));

        if not Root.ReadFrom(Payload) then
            exit(BuildErrorResponse('', 'INVALID_JSON', 'Invalid JSON payload.'));

        BatchId := GetText(Root, 'batchId');

        if BatchId = '' then
            BatchId := CreateGuidAsText();

        if not Root.Get('lines', LinesToken) then
            exit(BuildErrorResponse(BatchId, 'MISSING_LINES', 'Missing lines array.'));

        if not LinesToken.IsArray() then
            exit(BuildErrorResponse(BatchId, 'INVALID_LINES', 'The lines property must be an array.'));

        LinesArray := LinesToken.AsArray();

        if LinesArray.Count() = 0 then
            exit(BuildErrorResponse(BatchId, 'EMPTY_LINES', 'Lines array cannot be empty.'));

        foreach LineToken in LinesArray do begin
            Index += 1;

            if not LineToken.IsObject() then begin
                ErrorCount += 1;

                Clear(ErrorObject);
                ErrorObject.Add('index', Index);
                ErrorObject.Add('error_code', 'INVALID_LINE_OBJECT');
                ErrorObject.Add('error_message', 'Line must be a JSON object.');
                ErrorsArray.Add(ErrorObject);
            end else begin
                LineObject := LineToken.AsObject();

                ClearLastError();

                if TryImportDetailedVendorLedgerLine(LineObject) then
                    SuccessCount += 1
                else begin
                    ErrorCount += 1;
                    ErrorText := GetLastErrorText();

                    Clear(ErrorObject);
                    ErrorObject.Add('index', Index);
                    ErrorObject.Add('entry_no', GetInteger(LineObject, 'entryNo'));
                    ErrorObject.Add('vendor_ledger_entry_no', GetInteger(LineObject, 'vendorLedgerEntryNo'));
                    ErrorObject.Add('vendor_no', GetCode(LineObject, 'vendorNo'));
                    ErrorObject.Add('document_no', GetCode(LineObject, 'documentNo'));
                    ErrorObject.Add('error_code', 'DETAILED_VENDOR_LEDGER_IMPORT_ERROR');
                    ErrorObject.Add('error_message', ErrorText);
                    ErrorsArray.Add(ErrorObject);
                end;
            end;
        end;

        ResponsePayload.Add('batch_id', BatchId);
        ResponsePayload.Add('success_count', SuccessCount);
        ResponsePayload.Add('error_count', ErrorCount);
        ResponsePayload.Add('total_count', LinesArray.Count());
        ResponsePayload.Add('errors', ErrorsArray);

        if ErrorCount = 0 then begin
            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'Detailed vendor ledger entries imported successfully.');
        end else
            if SuccessCount > 0 then begin
                ResponseObject.Add('request_status', 'PARTIAL_SUCCESS');
                ResponseObject.Add('request_status_description', 'Detailed vendor ledger entries imported with some errors.');
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                ResponseObject.Add('request_status_description', 'Detailed vendor ledger entry import failed.');
            end;

        ResponseObject.Add('response_payload', ResponsePayload);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    procedure ImportGLEntry(Payload: Text): Text
    var
        Root: JsonObject;
        LinesToken: JsonToken;
        LinesArray: JsonArray;
        LineToken: JsonToken;
        LineObject: JsonObject;
        ResponseObject: JsonObject;
        ResponsePayload: JsonObject;
        ErrorsArray: JsonArray;
        ErrorObject: JsonObject;
        BatchId: Text;
        SuccessCount: Integer;
        ErrorCount: Integer;
        Index: Integer;
        ErrorText: Text;
        Response: Text;
    begin
        if Payload = '' then
            exit(BuildErrorResponse('', 'EMPTY_PAYLOAD', 'Payload cannot be empty.'));

        if not Root.ReadFrom(Payload) then
            exit(BuildErrorResponse('', 'INVALID_JSON', 'Invalid JSON payload.'));

        BatchId := GetText(Root, 'batchId');

        if BatchId = '' then
            BatchId := CreateGuidAsText();

        if not Root.Get('lines', LinesToken) then
            exit(BuildErrorResponse(BatchId, 'MISSING_LINES', 'Missing lines array.'));

        if not LinesToken.IsArray() then
            exit(BuildErrorResponse(BatchId, 'INVALID_LINES', 'The lines property must be an array.'));

        LinesArray := LinesToken.AsArray();

        if LinesArray.Count() = 0 then
            exit(BuildErrorResponse(BatchId, 'EMPTY_LINES', 'Lines array cannot be empty.'));

        foreach LineToken in LinesArray do begin
            Index += 1;

            if not LineToken.IsObject() then begin
                ErrorCount += 1;

                Clear(ErrorObject);
                ErrorObject.Add('index', Index);
                ErrorObject.Add('error_code', 'INVALID_LINE_OBJECT');
                ErrorObject.Add('error_message', 'Line must be a JSON object.');
                ErrorsArray.Add(ErrorObject);
            end else begin
                LineObject := LineToken.AsObject();

                ClearLastError();

                if TryImportGLEntryLine(LineObject) then
                    SuccessCount += 1
                else begin
                    ErrorCount += 1;
                    ErrorText := GetLastErrorText();

                    Clear(ErrorObject);
                    ErrorObject.Add('index', Index);
                    ErrorObject.Add('entry_no', GetInteger(LineObject, 'entryNo'));
                    ErrorObject.Add('gl_account_no', GetCode(LineObject, 'glAccountNo'));
                    ErrorObject.Add('document_no', GetCode(LineObject, 'documentNo'));
                    ErrorObject.Add('error_code', 'GL_ENTRY_IMPORT_ERROR');
                    ErrorObject.Add('error_message', ErrorText);
                    ErrorsArray.Add(ErrorObject);
                end;
            end;
        end;

        ResponsePayload.Add('batch_id', BatchId);
        ResponsePayload.Add('success_count', SuccessCount);
        ResponsePayload.Add('error_count', ErrorCount);
        ResponsePayload.Add('total_count', LinesArray.Count());
        ResponsePayload.Add('errors', ErrorsArray);

        if ErrorCount = 0 then begin
            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'G/L entries imported successfully.');
        end else
            if SuccessCount > 0 then begin
                ResponseObject.Add('request_status', 'PARTIAL_SUCCESS');
                ResponseObject.Add('request_status_description', 'G/L entries imported with some errors.');
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                ResponseObject.Add('request_status_description', 'G/L entry import failed.');
            end;

        ResponseObject.Add('response_payload', ResponsePayload);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;


    [TryFunction]
    local procedure TryImportGLEntryLine(LineObject: JsonObject)
    var
        GLEntryMigration: Record "G/L Entry Migration";
        EntryNo: Integer;
    begin
        EntryNo := GetInteger(LineObject, 'entryNo');

        if EntryNo = 0 then
            Error('Entry No. is required.');

        if GLEntryMigration.Get(EntryNo) then begin
            UpdateGLEntryMigrationFields(GLEntryMigration, LineObject);
            GLEntryMigration.Modify(true);
        end else begin
            GLEntryMigration.Init();
            GLEntryMigration."Entry No." := EntryNo;
            UpdateGLEntryMigrationFields(GLEntryMigration, LineObject);
            GLEntryMigration.Insert(true);
        end;
    end;


    local procedure UpdateGLEntryMigrationFields(var GLEntryMigration: Record "G/L Entry Migration"; LineObject: JsonObject)
    begin
        GLEntryMigration."G/L Account No." := CopyStr(GetCode(LineObject, 'glAccountNo'), 1, MaxStrLen(GLEntryMigration."G/L Account No."));
        GLEntryMigration."Posting Date" := GetDate(LineObject, 'postingDate');
        GLEntryMigration."Document No." := CopyStr(GetCode(LineObject, 'documentNo'), 1, MaxStrLen(GLEntryMigration."Document No."));
        GLEntryMigration.Description := CopyStr(GetText(LineObject, 'description'), 1, MaxStrLen(GLEntryMigration.Description));
        GLEntryMigration."Bal. Account No." := CopyStr(GetCode(LineObject, 'balAccountNo'), 1, MaxStrLen(GLEntryMigration."Bal. Account No."));

        GLEntryMigration.Amount := GetDecimal(LineObject, 'amount');
        GLEntryMigration."Source Code" := CopyStr(GetCode(LineObject, 'sourceCode'), 1, MaxStrLen(GLEntryMigration."Source Code"));
        GLEntryMigration."Reason Code" := CopyStr(GetCode(LineObject, 'reasonCode'), 1, MaxStrLen(GLEntryMigration."Reason Code"));
        GLEntryMigration."Transaction No." := GetInteger(LineObject, 'transactionNo');
        GLEntryMigration."External Document No." := CopyStr(GetCode(LineObject, 'externalDocumentNo'), 1, MaxStrLen(GLEntryMigration."External Document No."));
        GLEntryMigration."Source No." := CopyStr(GetCode(LineObject, 'sourceNo'), 1, MaxStrLen(GLEntryMigration."Source No."));

        GLEntryMigration.Reversed := GetBoolean(LineObject, 'reversed');
        GLEntryMigration."Reversed by Entry No." := GetInteger(LineObject, 'reversedByEntryNo');
        GLEntryMigration."Reversed Entry No." := GetInteger(LineObject, 'reversedEntryNo');

        SetGLEntryDocumentType(GLEntryMigration, GetInteger(LineObject, 'documentType'));
        SetGLEntryBalAccountType(GLEntryMigration, GetInteger(LineObject, 'balAccountType'));
        SetGLEntrySourceType(GLEntryMigration, GetInteger(LineObject, 'sourceType'));
    end;

    local procedure SetGLEntryDocumentType(var GLEntryMigration: Record "G/L Entry Migration"; DocumentTypeValue: Integer)
    begin
        case DocumentTypeValue of
            0:
                GLEntryMigration."Document Type" := GLEntryMigration."Document Type"::" ";
            1:
                GLEntryMigration."Document Type" := GLEntryMigration."Document Type"::Payment;
            2:
                GLEntryMigration."Document Type" := GLEntryMigration."Document Type"::Invoice;
            3:
                GLEntryMigration."Document Type" := GLEntryMigration."Document Type"::"Credit Memo";
            4:
                GLEntryMigration."Document Type" := GLEntryMigration."Document Type"::"Finance Charge Memo";
            5:
                GLEntryMigration."Document Type" := GLEntryMigration."Document Type"::Reminder;
            6:
                GLEntryMigration."Document Type" := GLEntryMigration."Document Type"::Refund;
            else
                Error('Invalid G/L Document Type value: %1', DocumentTypeValue);
        end;
    end;


    local procedure SetGLEntryGenPostingType(var GLEntryMigration: Record "G/L Entry Migration"; GenPostingTypeValue: Integer)
    begin
        case GenPostingTypeValue of
            0:
                GLEntryMigration."Gen. Posting Type" := GLEntryMigration."Gen. Posting Type"::" ";
            1:
                GLEntryMigration."Gen. Posting Type" := GLEntryMigration."Gen. Posting Type"::Purchase;
            2:
                GLEntryMigration."Gen. Posting Type" := GLEntryMigration."Gen. Posting Type"::Sale;
            3:
                GLEntryMigration."Gen. Posting Type" := GLEntryMigration."Gen. Posting Type"::Settlement;
            else
                Error('Invalid G/L Gen. Posting Type value: %1', GenPostingTypeValue);
        end;
    end;


    local procedure SetGLEntryBalAccountType(var GLEntryMigration: Record "G/L Entry Migration"; BalAccountTypeValue: Integer)
    begin
        case BalAccountTypeValue of
            0:
                GLEntryMigration."Bal. Account Type" := GLEntryMigration."Bal. Account Type"::"G/L Account";
            1:
                GLEntryMigration."Bal. Account Type" := GLEntryMigration."Bal. Account Type"::Customer;
            2:
                GLEntryMigration."Bal. Account Type" := GLEntryMigration."Bal. Account Type"::Vendor;
            3:
                GLEntryMigration."Bal. Account Type" := GLEntryMigration."Bal. Account Type"::"Bank Account";
            4:
                GLEntryMigration."Bal. Account Type" := GLEntryMigration."Bal. Account Type"::"Fixed Asset";
            5:
                GLEntryMigration."Bal. Account Type" := GLEntryMigration."Bal. Account Type"::"IC Partner";
            6:
                GLEntryMigration."Bal. Account Type" := GLEntryMigration."Bal. Account Type"::Employee;
            else
                Error('Invalid G/L Bal. Account Type value: %1', BalAccountTypeValue);
        end;
    end;


    local procedure SetGLEntrySourceType(var GLEntryMigration: Record "G/L Entry Migration"; SourceTypeValue: Integer)
    begin
        case SourceTypeValue of
            0:
                GLEntryMigration."Source Type" := GLEntryMigration."Source Type"::" ";
            1:
                GLEntryMigration."Source Type" := GLEntryMigration."Source Type"::Customer;
            2:
                GLEntryMigration."Source Type" := GLEntryMigration."Source Type"::Vendor;
            3:
                GLEntryMigration."Source Type" := GLEntryMigration."Source Type"::"Bank Account";
            4:
                GLEntryMigration."Source Type" := GLEntryMigration."Source Type"::"Fixed Asset";
            5:
                GLEntryMigration."Source Type" := GLEntryMigration."Source Type"::Employee;
            6:
                GLEntryMigration."Source Type" := GLEntryMigration."Source Type"::Member;
            else
                Error('Invalid G/L Source Type value: %1', SourceTypeValue);
        end;
    end;

    [TryFunction]
    local procedure TryImportVendorLedgerLine(LineObject: JsonObject)
    var
        VendorLedgerMigration: Record "Vendor Ledger Entry Migration";
        EntryNo: Integer;
    begin
        EntryNo := GetInteger(LineObject, 'entryNo');

        if EntryNo = 0 then
            Error('Entry No. is required.');

        if VendorLedgerMigration.Get(EntryNo) then begin
            UpdateVendorLedgerMigrationFields(VendorLedgerMigration, LineObject);
            VendorLedgerMigration.Modify(true);
        end else begin
            VendorLedgerMigration.Init();
            VendorLedgerMigration."Entry No." := EntryNo;
            UpdateVendorLedgerMigrationFields(VendorLedgerMigration, LineObject);
            VendorLedgerMigration.Insert(true);
        end;
    end;


    local procedure UpdateVendorLedgerMigrationFields(var VendorLedgerMigration: Record "Vendor Ledger Entry Migration"; LineObject: JsonObject)
    begin
        VendorLedgerMigration."Entry No." := GetInteger(LineObject, 'vendorLedgerEntryNo');
        VendorLedgerMigration."Posting Date" := GetDate(LineObject, 'postingDate');
        VendorLedgerMigration."Document No." := CopyStr(GetCode(LineObject, 'documentNo'), 1, MaxStrLen(VendorLedgerMigration."Document No."));
        VendorLedgerMigration.Amount := GetDecimal(LineObject, 'amount');
        VendorLedgerMigration."Amount (LCY)" := GetDecimal(LineObject, 'amountLCY');
        VendorLedgerMigration."Vendor No." := CopyStr(GetCode(LineObject, 'vendorNo'), 1, MaxStrLen(VendorLedgerMigration."Vendor No."));
        VendorLedgerMigration."Source Code" := CopyStr(GetCode(LineObject, 'sourceCode'), 1, MaxStrLen(VendorLedgerMigration."Source Code"));
        VendorLedgerMigration."Transaction No." := GetInteger(LineObject, 'transactionNo');
        VendorLedgerMigration."Journal Batch Name" := CopyStr(GetCode(LineObject, 'journalBatchName'), 1, MaxStrLen(VendorLedgerMigration."Journal Batch Name"));


        SetVendorLedgerDocumentType(VendorLedgerMigration, GetInteger(LineObject, 'documentType'));
        SetVendorLedgerAppliesToDocType(VendorLedgerMigration, GetInteger(LineObject, 'appliesToDocType'));
        SetVendorLedgerBalAccountType(VendorLedgerMigration, GetInteger(LineObject, 'balAccountType'));
    end;


    local procedure SetVendorLedgerDocumentType(var VendorLedgerMigration: Record "Vendor Ledger Entry Migration"; DocumentTypeValue: Integer)
    begin
        case DocumentTypeValue of
            0:
                VendorLedgerMigration."Document Type" := VendorLedgerMigration."Document Type"::" ";
            1:
                VendorLedgerMigration."Document Type" := VendorLedgerMigration."Document Type"::Payment;
            2:
                VendorLedgerMigration."Document Type" := VendorLedgerMigration."Document Type"::Invoice;
            3:
                VendorLedgerMigration."Document Type" := VendorLedgerMigration."Document Type"::"Credit Memo";
            4:
                VendorLedgerMigration."Document Type" := VendorLedgerMigration."Document Type"::"Finance Charge Memo";
            5:
                VendorLedgerMigration."Document Type" := VendorLedgerMigration."Document Type"::Reminder;
            6:
                VendorLedgerMigration."Document Type" := VendorLedgerMigration."Document Type"::Refund;
            else
                Error('Invalid Vendor Ledger Document Type value: %1', DocumentTypeValue);
        end;
    end;


    local procedure SetVendorLedgerAppliesToDocType(var VendorLedgerMigration: Record "Vendor Ledger Entry Migration"; AppliesToDocTypeValue: Integer)
    begin
        case AppliesToDocTypeValue of
            0:
                VendorLedgerMigration."Applies-to Doc. Type" := VendorLedgerMigration."Applies-to Doc. Type"::" ";
            1:
                VendorLedgerMigration."Applies-to Doc. Type" := VendorLedgerMigration."Applies-to Doc. Type"::Payment;
            2:
                VendorLedgerMigration."Applies-to Doc. Type" := VendorLedgerMigration."Applies-to Doc. Type"::Invoice;
            3:
                VendorLedgerMigration."Applies-to Doc. Type" := VendorLedgerMigration."Applies-to Doc. Type"::"Credit Memo";
            4:
                VendorLedgerMigration."Applies-to Doc. Type" := VendorLedgerMigration."Applies-to Doc. Type"::"Finance Charge Memo";
            5:
                VendorLedgerMigration."Applies-to Doc. Type" := VendorLedgerMigration."Applies-to Doc. Type"::Reminder;
            6:
                VendorLedgerMigration."Applies-to Doc. Type" := VendorLedgerMigration."Applies-to Doc. Type"::Refund;
            else
                Error('Invalid Vendor Ledger Applies-to Doc. Type value: %1', AppliesToDocTypeValue);
        end;
    end;


    local procedure SetVendorLedgerBalAccountType(var VendorLedgerMigration: Record "Vendor Ledger Entry Migration"; BalAccountTypeValue: Integer)
    begin
        case BalAccountTypeValue of
            0:
                VendorLedgerMigration."Bal. Account Type" := VendorLedgerMigration."Bal. Account Type"::"G/L Account";
            1:
                VendorLedgerMigration."Bal. Account Type" := VendorLedgerMigration."Bal. Account Type"::Customer;
            2:
                VendorLedgerMigration."Bal. Account Type" := VendorLedgerMigration."Bal. Account Type"::Vendor;
            3:
                VendorLedgerMigration."Bal. Account Type" := VendorLedgerMigration."Bal. Account Type"::"Bank Account";
            4:
                VendorLedgerMigration."Bal. Account Type" := VendorLedgerMigration."Bal. Account Type"::"Fixed Asset";
            else
                Error('Invalid Vendor Ledger Bal. Account Type value: %1', BalAccountTypeValue);
        end;
    end;

    [TryFunction]
    local procedure TryImportDetailedVendorLedgerLine(LineObject: JsonObject)
    var
        DetailedVendorLedgerMigration: Record "Detailed Vendor Ledg Migration";
        EntryNo: Integer;
    begin
        EntryNo := GetInteger(LineObject, 'entryNo');

        if EntryNo = 0 then
            Error('Entry No. is required.');

        if DetailedVendorLedgerMigration.Get(EntryNo) then begin
            UpdateDetailedVendorLedgerMigrationFields(DetailedVendorLedgerMigration, LineObject);
            DetailedVendorLedgerMigration.Modify(true);
        end else begin
            DetailedVendorLedgerMigration.Init();
            DetailedVendorLedgerMigration."Entry No." := EntryNo;
            UpdateDetailedVendorLedgerMigrationFields(DetailedVendorLedgerMigration, LineObject);
            DetailedVendorLedgerMigration.Insert(true);
        end;
    end;

    local procedure UpdateDetailedVendorLedgerMigrationFields(var DetailedVendorLedgerMigration: Record "Detailed Vendor Ledg Migration"; LineObject: JsonObject)
    begin
        DetailedVendorLedgerMigration."Vendor Ledger Entry No." := GetInteger(LineObject, 'vendorLedgerEntryNo');
        DetailedVendorLedgerMigration."Posting Date" := GetDate(LineObject, 'postingDate');
        DetailedVendorLedgerMigration."Document No." := CopyStr(GetCode(LineObject, 'documentNo'), 1, MaxStrLen(DetailedVendorLedgerMigration."Document No."));
        DetailedVendorLedgerMigration.Amount := GetDecimal(LineObject, 'amount');
        DetailedVendorLedgerMigration."Amount (LCY)" := GetDecimal(LineObject, 'amountLCY');
        DetailedVendorLedgerMigration."Vendor No." := CopyStr(GetCode(LineObject, 'vendorNo'), 1, MaxStrLen(DetailedVendorLedgerMigration."Vendor No."));
        DetailedVendorLedgerMigration."Currency Code" := CopyStr(GetCode(LineObject, 'currencyCode'), 1, MaxStrLen(DetailedVendorLedgerMigration."Currency Code"));
        DetailedVendorLedgerMigration."User ID" := CopyStr(GetCode(LineObject, 'userId'), 1, MaxStrLen(DetailedVendorLedgerMigration."User ID"));
        DetailedVendorLedgerMigration."Source Code" := CopyStr(GetCode(LineObject, 'sourceCode'), 1, MaxStrLen(DetailedVendorLedgerMigration."Source Code"));
        DetailedVendorLedgerMigration."Transaction No." := GetInteger(LineObject, 'transactionNo');
        DetailedVendorLedgerMigration."Journal Batch Name" := CopyStr(GetCode(LineObject, 'journalBatchName'), 1, MaxStrLen(DetailedVendorLedgerMigration."Journal Batch Name"));
        DetailedVendorLedgerMigration."Reason Code" := CopyStr(GetCode(LineObject, 'reasonCode'), 1, MaxStrLen(DetailedVendorLedgerMigration."Reason Code"));
        DetailedVendorLedgerMigration."Debit Amount" := GetDecimal(LineObject, 'debitAmount');
        DetailedVendorLedgerMigration."Credit Amount" := GetDecimal(LineObject, 'creditAmount');
        DetailedVendorLedgerMigration."Debit Amount (LCY)" := GetDecimal(LineObject, 'debitAmountLCY');
        DetailedVendorLedgerMigration."Credit Amount (LCY)" := GetDecimal(LineObject, 'creditAmountLCY');
        DetailedVendorLedgerMigration."Initial Entry Due Date" := GetDate(LineObject, 'initialEntryDueDate');
        DetailedVendorLedgerMigration."Initial Entry Global Dim. 1" := CopyStr(GetCode(LineObject, 'initialEntryGlobalDim1'), 1, MaxStrLen(DetailedVendorLedgerMigration."Initial Entry Global Dim. 1"));
        DetailedVendorLedgerMigration."Initial Entry Global Dim. 2" := CopyStr(GetCode(LineObject, 'initialEntryGlobalDim2'), 1, MaxStrLen(DetailedVendorLedgerMigration."Initial Entry Global Dim. 2"));
        DetailedVendorLedgerMigration."Gen. Bus. Posting Group" := CopyStr(GetCode(LineObject, 'genBusPostingGroup'), 1, MaxStrLen(DetailedVendorLedgerMigration."Gen. Bus. Posting Group"));
        DetailedVendorLedgerMigration."Gen. Prod. Posting Group" := CopyStr(GetCode(LineObject, 'genProdPostingGroup'), 1, MaxStrLen(DetailedVendorLedgerMigration."Gen. Prod. Posting Group"));
        DetailedVendorLedgerMigration."Use Tax" := GetBoolean(LineObject, 'useTax');
        DetailedVendorLedgerMigration."VAT Bus. Posting Group" := CopyStr(GetCode(LineObject, 'vatBusPostingGroup'), 1, MaxStrLen(DetailedVendorLedgerMigration."VAT Bus. Posting Group"));
        DetailedVendorLedgerMigration."VAT Prod. Posting Group" := CopyStr(GetCode(LineObject, 'vatProdPostingGroup'), 1, MaxStrLen(DetailedVendorLedgerMigration."VAT Prod. Posting Group"));
        DetailedVendorLedgerMigration."Applied Vend. Ledger Entry No." := GetInteger(LineObject, 'appliedVendLedgerEntryNo');
        DetailedVendorLedgerMigration.Unapplied := GetBoolean(LineObject, 'unapplied');
        DetailedVendorLedgerMigration."Unapplied by Entry No." := GetInteger(LineObject, 'unappliedByEntryNo');
        DetailedVendorLedgerMigration."Remaining Pmt. Disc. Possible" := GetDecimal(LineObject, 'remainingPmtDiscPossible');
        DetailedVendorLedgerMigration."Max. Payment Tolerance" := GetDecimal(LineObject, 'maxPaymentTolerance');
        DetailedVendorLedgerMigration."Tax Jurisdiction Code" := CopyStr(GetCode(LineObject, 'taxJurisdictionCode'), 1, MaxStrLen(DetailedVendorLedgerMigration."Tax Jurisdiction Code"));
        DetailedVendorLedgerMigration."Application No." := GetInteger(LineObject, 'applicationNo');
        DetailedVendorLedgerMigration."Ledger Entry Amount" := GetBoolean(LineObject, 'ledgerEntryAmount');

        SetDetailedVendorLedgerEntryType(DetailedVendorLedgerMigration, GetInteger(LineObject, 'entryType'));
        SetDetailedVendorLedgerDocumentType(DetailedVendorLedgerMigration, GetInteger(LineObject, 'documentType'));
        SetDetailedVendorLedgerInitialDocumentType(DetailedVendorLedgerMigration, GetInteger(LineObject, 'initialDocumentType'));
    end;

    local procedure SetDetailedVendorLedgerEntryType(var DetailedVendorLedgerMigration: Record "Detailed Vendor Ledg Migration"; EntryTypeValue: Integer)
    begin
        case EntryTypeValue of
            0:
                Clear(DetailedVendorLedgerMigration."Entry Type");
            1:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Initial Entry";
            2:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::Application;
            3:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Unrealized Loss";
            4:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Unrealized Gain";
            5:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Realized Loss";
            6:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Realized Gain";
            7:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Payment Discount";
            8:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Payment Discount (VAT Excl.)";
            9:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Payment Discount (VAT Adjustment)";
            10:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Appln. Rounding";
            11:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Correction of Remaining Amount";
            12:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Payment Tolerance";
            13:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Payment Discount Tolerance";
            14:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Payment Tolerance (VAT Excl.)";
            15:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Payment Tolerance (VAT Adjustment)";
            16:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Payment Discount Tolerance (VAT Excl.)";
            17:
                DetailedVendorLedgerMigration."Entry Type" := DetailedVendorLedgerMigration."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)";
            else
                Error('Invalid Detailed Vendor Ledger Entry Type value: %1', EntryTypeValue);
        end;
    end;

    local procedure SetDetailedVendorLedgerDocumentType(var DetailedVendorLedgerMigration: Record "Detailed Vendor Ledg Migration"; DocumentTypeValue: Integer)
    begin
        case DocumentTypeValue of
            0:
                DetailedVendorLedgerMigration."Document Type" := DetailedVendorLedgerMigration."Document Type"::" ";
            1:
                DetailedVendorLedgerMigration."Document Type" := DetailedVendorLedgerMigration."Document Type"::Payment;
            2:
                DetailedVendorLedgerMigration."Document Type" := DetailedVendorLedgerMigration."Document Type"::Invoice;
            3:
                DetailedVendorLedgerMigration."Document Type" := DetailedVendorLedgerMigration."Document Type"::"Credit Memo";
            4:
                DetailedVendorLedgerMigration."Document Type" := DetailedVendorLedgerMigration."Document Type"::"Finance Charge Memo";
            5:
                DetailedVendorLedgerMigration."Document Type" := DetailedVendorLedgerMigration."Document Type"::Reminder;
            6:
                DetailedVendorLedgerMigration."Document Type" := DetailedVendorLedgerMigration."Document Type"::Refund;
            else
                Error('Invalid Detailed Vendor Ledger Document Type value: %1', DocumentTypeValue);
        end;
    end;

    local procedure SetDetailedVendorLedgerInitialDocumentType(var DetailedVendorLedgerMigration: Record "Detailed Vendor Ledg Migration"; InitialDocumentTypeValue: Integer)
    begin
        case InitialDocumentTypeValue of
            0:
                DetailedVendorLedgerMigration."Initial Document Type" := DetailedVendorLedgerMigration."Initial Document Type"::" ";
            1:
                DetailedVendorLedgerMigration."Initial Document Type" := DetailedVendorLedgerMigration."Initial Document Type"::Payment;
            2:
                DetailedVendorLedgerMigration."Initial Document Type" := DetailedVendorLedgerMigration."Initial Document Type"::Invoice;
            3:
                DetailedVendorLedgerMigration."Initial Document Type" := DetailedVendorLedgerMigration."Initial Document Type"::"Credit Memo";
            4:
                DetailedVendorLedgerMigration."Initial Document Type" := DetailedVendorLedgerMigration."Initial Document Type"::"Finance Charge Memo";
            5:
                DetailedVendorLedgerMigration."Initial Document Type" := DetailedVendorLedgerMigration."Initial Document Type"::Reminder;
            6:
                DetailedVendorLedgerMigration."Initial Document Type" := DetailedVendorLedgerMigration."Initial Document Type"::Refund;
            else
                Error('Invalid Detailed Vendor Ledger Initial Document Type value: %1', InitialDocumentTypeValue);
        end;
    end;

    local procedure GetBoolean(var JsonObj: JsonObject; PropertyName: Text): Boolean
    var
        Token: JsonToken;
        ValueText: Text;
        ValueBoolean: Boolean;
    begin
        if not JsonObj.Get(PropertyName, Token) then
            exit(false);

        if not Token.IsValue() then
            exit(false);

        if Token.AsValue().IsNull() then
            exit(false);

        ValueText := LowerCase(Token.AsValue().AsText());

        if ValueText = '' then
            exit(false);

        case ValueText of
            'True', 'true', ' 1', ' yes', ' y':
                exit(true);

            'False', 'false', '0', 'no', 'n':
                exit(false);
        end;

        if Evaluate(ValueBoolean, Token.AsValue().AsText()) then
            exit(ValueBoolean);

        Error('Invalid boolean value for %1. Value: %2.', PropertyName, Token.AsValue().AsText());
    end;

    [TryFunction]
    local procedure TryImportBankAccountLedgerLine(LineObject: JsonObject)
    var
        BankLedgerMigration: Record "Bank Account Ledger Migration";
        EntryNo: Integer;
    begin
        EntryNo := GetInteger(LineObject, 'entryNo');

        if EntryNo = 0 then
            Error('Entry No. is required.');

        if BankLedgerMigration.Get(EntryNo) then begin
            UpdateBankLedgerMigrationFields(BankLedgerMigration, LineObject);
            BankLedgerMigration.Modify(true);
        end else begin
            BankLedgerMigration.Init();
            BankLedgerMigration."Entry No." := EntryNo;

            UpdateBankLedgerMigrationFields(BankLedgerMigration, LineObject);
            BankLedgerMigration.Insert(true);
        end;
    end;

    [TryFunction]
    local procedure TryImportMemberImage(ImageObject: JsonObject)
    var
        MemberImage: Record "Member Images";
        NewMemberNo: Code[20];
        OldMemberNo: Code[20];
        PictureBase64: Text;
        SignatureBase64: Text;
    begin
        OldMemberNo := CopyStr(GetCode(ImageObject, 'memberNo'), 1, MaxStrLen(OldMemberNo));
        PictureBase64 := GetText(ImageObject, 'pictureBase64');
        SignatureBase64 := GetText(ImageObject, 'signatureBase64');

        if OldMemberNo = '' then
            Error('Old Member No. is required.');

        if (PictureBase64 = '') and (SignatureBase64 = '') then
            Error('Picture or signature is required for old member no. %1.', OldMemberNo);

        NewMemberNo := GetNewMemberNoFromOldMemberNo(OldMemberNo);

        if MemberImage.Get(NewMemberNo) then begin
            SaveBase64ToMemberImageBlob(MemberImage, PictureBase64, 'PICTURE');
            SaveBase64ToMemberImageBlob(MemberImage, SignatureBase64, 'SIGNATURE');
            MemberImage.Modify(false);
        end else begin
            MemberImage.Init();
            MemberImage."Member No." := NewMemberNo;
            SaveBase64ToMemberImageBlob(MemberImage, PictureBase64, 'PICTURE');
            SaveBase64ToMemberImageBlob(MemberImage, SignatureBase64, 'SIGNATURE');
            MemberImage.Insert(false);
        end;
    end;

    local procedure UpdateBankLedgerMigrationFields(var BankLedgerMigration: Record "Bank Account Ledger Migration"; LineObject: JsonObject)
    begin
        BankLedgerMigration."Bank Account No." := CopyStr(GetCode(LineObject, 'bankAccountNo'), 1, MaxStrLen(BankLedgerMigration."Bank Account No."));
        BankLedgerMigration."Posting Date" := GetDate(LineObject, 'postingDate');
        BankLedgerMigration."Document No." := CopyStr(GetCode(LineObject, 'documentNo'), 1, MaxStrLen(BankLedgerMigration."Document No."));
        BankLedgerMigration.Description := CopyStr(GetText(LineObject, 'description'), 1, MaxStrLen(BankLedgerMigration.Description));
        BankLedgerMigration."Currency Code" := CopyStr(GetCode(LineObject, 'currencyCode'), 1, MaxStrLen(BankLedgerMigration."Currency Code"));
        BankLedgerMigration.Amount := GetDecimal(LineObject, 'amount');
        BankLedgerMigration."Amount (LCY)" := GetDecimal(LineObject, 'amountLCY');
        BankLedgerMigration."Debit Amount" := GetDecimal(LineObject, 'debitAmount');
        BankLedgerMigration."Credit Amount" := GetDecimal(LineObject, 'creditAmount');
        BankLedgerMigration."Debit Amount (LCY)" := GetDecimal(LineObject, 'debitAmountLCY');
        BankLedgerMigration."Credit Amount (LCY)" := GetDecimal(LineObject, 'creditAmountLCY');
        BankLedgerMigration."Transaction No." := GetInteger(LineObject, 'transactionNo');
        BankLedgerMigration."Document Date" := GetDate(LineObject, 'documentDate');
        BankLedgerMigration."External Document No." := CopyStr(GetCode(LineObject, 'externalDocumentNo'), 1, MaxStrLen(BankLedgerMigration."External Document No."));
        BankLedgerMigration.Reversed := GetBoolean(LineObject, 'reversed');
        BankLedgerMigration."Reversed by Entry No." := GetInteger(LineObject, 'reversedByEntryNo');
        BankLedgerMigration."Reversed Entry No." := GetInteger(LineObject, 'reversedEntryNo');
        BankLedgerMigration.Posted := GetBoolean(LineObject, 'posted');

    end;

    local procedure SaveBase64ToMemberImageBlob(var MemberImage: Record "Member Images"; Base64Text: Text; ImageType: Text)
    var
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        TempOutStream: OutStream;
        TempInStream: InStream;
        TargetOutStream: OutStream;
    begin
        if Base64Text = '' then
            exit;

        TempBlob.CreateOutStream(TempOutStream);
        Base64Convert.FromBase64(Base64Text, TempOutStream);

        TempBlob.CreateInStream(TempInStream);

        case ImageType of
            'PICTURE':
                begin
                    Clear(MemberImage.Picture);
                    MemberImage.Picture.CreateOutStream(TargetOutStream);
                    CopyStream(TargetOutStream, TempInStream);
                end;

            'SIGNATURE':
                begin
                    Clear(MemberImage.Signature);
                    MemberImage.Signature.CreateOutStream(TargetOutStream);
                    CopyStream(TargetOutStream, TempInStream);
                end;
        end;
    end;

    local procedure GetNewMemberNoFromOldMemberNo(OldMemberNo: Code[20]): Code[20]
    var
        Member: Record Members;
    begin
        if OldMemberNo = '' then
            Error('Old Member No. cannot be blank.');

        Member.Reset();
        Member.SetRange("Old Member No.", OldMemberNo);

        if Member.FindFirst() then
            exit(Member."No.");

        if Member.Get(OldMemberNo) then
            exit(Member."No.");

        Error('Member mapping not found. Old Member No. %1 does not exist in Members table.', OldMemberNo);
    end;

    [TryFunction]
    local procedure TryImportLine(LineObject: JsonObject)
    var
        Schedule: Record "Loan Repayment Schedule";
        ExistingByLineNo: Record "Loan Repayment Schedule";
        ExistingDestination: Record "Loan Repayment Schedule";
        LoanNo: Code[20];
        MemberNo: Code[20];
        LineNo: Integer;
        RepaymentDate: Date;
    begin
        LoanNo := CopyStr(GetCode(LineObject, 'loanNo'), 1, MaxStrLen(LoanNo));
        MemberNo := CopyStr(GetCode(LineObject, 'memberNo'), 1, MaxStrLen(MemberNo));
        LineNo := GetInteger(LineObject, 'lineNo');
        RepaymentDate := GetDate(LineObject, 'repaymentDate');

        if LoanNo = '' then
            Error('Loan No. is required.');

        if MemberNo = '' then
            Error('Member No. is required.');

        if RepaymentDate = 0D then
            Error('Repayment Date is required.');

        // 1. Same primary key exists: update it.
        // Primary key = Loan No. + Repayment Date + Member No.
        if Schedule.Get(LoanNo, RepaymentDate, MemberNo) then begin
            Schedule."Line No." := LineNo;
            UpdateScheduleFields(Schedule, LineObject);
            Schedule.Modify(true);
            exit;
        end;

        // 2. Same Loan No. + Line No. exists, but date/member changed:
        // Rename primary key safely, then update.
        ExistingByLineNo.Reset();

        // Requires secondary key: key(LoanLineKey; "Loan No.", "Line No.")
        ExistingByLineNo.SetCurrentKey("Loan No.", "Line No.");
        ExistingByLineNo.SetRange("Loan No.", LoanNo);
        ExistingByLineNo.SetRange("Line No.", LineNo);

        if ExistingByLineNo.FindFirst() then begin

            ExistingByLineNo.Rename(LoanNo, RepaymentDate, MemberNo);
            ExistingByLineNo.Get(LoanNo, RepaymentDate, MemberNo);

            ExistingByLineNo."Line No." := LineNo;
            UpdateScheduleFields(ExistingByLineNo, LineObject);
            ExistingByLineNo.Modify(true);
            exit;
        end;

        // 3. Insert new schedule line.
        Schedule.Init();
        Schedule."Loan No." := LoanNo;
        Schedule."Member No." := MemberNo;
        Schedule."Line No." := LineNo;
        Schedule."Repayment Date" := RepaymentDate;
        UpdateScheduleFields(Schedule, LineObject);
        Schedule.Insert(true);
    end;

    local procedure UpdateScheduleFields(var Schedule: Record "Loan Repayment Schedule"; LineObject: JsonObject)
    var
        OldRepaymentDate: Date;
    begin
        OldRepaymentDate := GetDate(LineObject, 'oldRepaymentDate');

        if OldRepaymentDate = 0D then
            OldRepaymentDate := Schedule."Repayment Date";

        Schedule."Old Repayment Date" := OldRepaymentDate;
        Schedule."Loan Amount" := GetDecimal(LineObject, 'loanAmount');
        Schedule."Monthly Principal" := GetDecimal(LineObject, 'monthlyPrincipal');
        Schedule."Monthly Interest" := GetDecimal(LineObject, 'monthlyInterest');
        Schedule."Monthly Appraisal" := GetDecimal(LineObject, 'monthlyAppraisal');
        Schedule."Monthly Repayment" := GetDecimal(LineObject, 'monthlyRepayment');
        Schedule."Loan Balance" := GetDecimal(LineObject, 'loanBalance');
        Schedule."Deposit Amount" := GetDecimal(LineObject, 'depositAmount');
        Schedule."Insurance Contribution" := GetDecimal(LineObject, 'insuranceContribution');
        Schedule."Monthly Shares" := GetDecimal(LineObject, 'monthlyShares');
    end;

    local procedure BuildErrorResponse(BatchId: Text; ErrorCode: Text; ErrorMessage: Text): Text
    var
        ResponseObject: JsonObject;
        ResponsePayload: JsonObject;
        Response: Text;
    begin
        ResponseObject.Add('request_status', 'ERROR');
        ResponseObject.Add('request_status_description', 'Processing failed.');

        ResponsePayload.Add('batch_id', BatchId);
        ResponsePayload.Add('error_code', ErrorCode);
        ResponsePayload.Add('error_message', ErrorMessage);

        ResponseObject.Add('response_payload', ResponsePayload);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure CreateGuidAsText(): Text
    var
        NewGuid: Guid;
        GuidText: Text;
    begin
        NewGuid := CreateGuid();
        GuidText := Format(NewGuid);
        GuidText := DelChr(GuidText, '=', '{}');
        exit(GuidText);
    end;

    local procedure GetText(var JsonObj: JsonObject; PropertyName: Text): Text
    var
        Token: JsonToken;
    begin
        if not JsonObj.Get(PropertyName, Token) then
            exit('');

        if not Token.IsValue() then
            exit('');

        if Token.AsValue().IsNull() then
            exit('');

        exit(Token.AsValue().AsText());
    end;

    local procedure GetCode(var JsonObj: JsonObject; PropertyName: Text): Code[50]
    var
        ValueText: Text;
    begin
        ValueText := GetText(JsonObj, PropertyName);
        exit(CopyStr(ValueText, 1, 100));
    end;

    local procedure GetInteger(var JsonObj: JsonObject; PropertyName: Text): Integer
    var
        Token: JsonToken;
        ValueText: Text;
        ValueInt: Integer;
    begin
        if not JsonObj.Get(PropertyName, Token) then
            exit(0);

        if not Token.IsValue() then
            exit(0);

        if Token.AsValue().IsNull() then
            exit(0);

        ValueText := Token.AsValue().AsText();

        if ValueText = '' then
            exit(0);

        if Evaluate(ValueInt, ValueText) then
            exit(ValueInt);

        Error('Invalid integer value for %1. Value: %2.', PropertyName, ValueText);
    end;

    local procedure GetDecimal(var JsonObj: JsonObject; PropertyName: Text): Decimal
    var
        Token: JsonToken;
        ValueText: Text;
        ValueDecimal: Decimal;
    begin
        if not JsonObj.Get(PropertyName, Token) then
            exit(0);

        if not Token.IsValue() then
            exit(0);

        if Token.AsValue().IsNull() then
            exit(0);

        ValueText := Token.AsValue().AsText();

        if ValueText = '' then
            exit(0);

        if Evaluate(ValueDecimal, ValueText) then
            exit(ValueDecimal);

        Error('Invalid decimal value for %1. Value: %2.', PropertyName, ValueText);
    end;

    local procedure GetDate(var JsonObj: JsonObject; PropertyName: Text): Date
    var
        Token: JsonToken;
        DateText: Text;
        ParsedDate: Date;
    begin
        if not JsonObj.Get(PropertyName, Token) then
            exit(0D);

        if not Token.IsValue() then
            exit(0D);

        if Token.AsValue().IsNull() then
            exit(0D);

        DateText := Token.AsValue().AsText();

        if DateText = '' then
            exit(0D);

        if Evaluate(ParsedDate, DateText, 9) then
            exit(ParsedDate);

    end;

    local procedure DeleteExistingScheduleOnce(LineObject: JsonObject; var DeletedLoans: List of [Code[20]])
    var
        Schedule: Record "Loan Repayment Schedule";
        LoanNo: Code[20];
    begin
        LoanNo := CopyStr(GetCode(LineObject, 'loanNo'), 1, MaxStrLen(LoanNo));

        if LoanNo = '' then
            exit;

        if DeletedLoans.Contains(LoanNo) then
            exit;

        Schedule.Reset();
        Schedule.SetCurrentKey("Loan No.");
        Schedule.SetRange("Loan No.", LoanNo);

        if not Schedule.IsEmpty() then
            Schedule.DeleteAll(false);

        DeletedLoans.Add(LoanNo);
    end;

    local procedure AddDateTimeToResponse(var ResponseObject: JsonObject)
    begin
        ResponseObject.Add('response_date', Format(Today, 0, 9));
        ResponseObject.Add('response_time', Format(Time));
    end;
}
