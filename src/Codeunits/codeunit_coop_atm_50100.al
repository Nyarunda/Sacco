codeunit 50100 "Coop ATM Processor"
{
    procedure ProcessIncomingTransaction(JsonPayload: Text): Boolean
    var
        TransactionLog: Record "Coop ATM Transaction Log";
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        ConnectionJson: JsonObject;
        OperationParamsJson: JsonObject;
        InstitutionJson: JsonObject;
        PostingJson: JsonObject;
        AdditionalInfoArray: JsonArray;
        SendFundsJson: JsonObject;
        Success: Boolean;
    begin
        Success := false;

        // Parse main JSON
        if not JsonObject.ReadFrom(JsonPayload) then
            Error('Invalid JSON format');

        // Initialize new transaction log record
        TransactionLog.Init();

        // Extract main fields
        if JsonObject.Get('serviceName', JsonToken) then
            TransactionLog."Service Name" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Service Name"));

        if JsonObject.Get('messageID', JsonToken) then
            TransactionLog."Message ID" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Message ID"));

        // Extract Connection details
        if JsonObject.Get('Connection', JsonToken) then begin
            ConnectionJson := JsonToken.AsObject();
            if ConnectionJson.Get('connectionID', JsonToken) then
                TransactionLog."Connection ID" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Connection ID"));
        end;

        // Extract sendFundsTransferRequest details
        if JsonObject.Get('sendFundsTransferRequest', JsonToken) then begin
            SendFundsJson := JsonToken.AsObject();

            // Extract OperationParameters
            if SendFundsJson.Get('OperationParameters', JsonToken) then begin
                OperationParamsJson := JsonToken.AsObject();

                if OperationParamsJson.Get('TransactionDate', JsonToken) then
                    if Evaluate(TransactionLog."Transaction Date", JsonToken.AsValue().AsText()) then;

                if OperationParamsJson.Get('TerminalID', JsonToken) then
                    TransactionLog."Terminal ID" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Terminal ID"));

                if OperationParamsJson.Get('Channel', JsonToken) then
                    TransactionLog."Channel" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Channel"));

                if OperationParamsJson.Get('TransactionType', JsonToken) then
                    TransactionLog."Transaction Type" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Transaction Type"));

                if OperationParamsJson.Get('OriginalMessageID', JsonToken) then
                    TransactionLog."Original Message ID" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Original Message ID"));
            end;

            // Extract Institution details
            if SendFundsJson.Get('Institution', JsonToken) then begin
                InstitutionJson := JsonToken.AsObject();

                if InstitutionJson.Get('InstitutionCode', JsonToken) then
                    TransactionLog."Institution Code" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Institution Code"));

                if InstitutionJson.Get('InstitutionName', JsonToken) then
                    TransactionLog."Institution Name" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Institution Name"));
            end;

            // Extract Posting details
            if SendFundsJson.Get('Posting', JsonToken) then begin
                PostingJson := JsonToken.AsObject();

                if PostingJson.Get('DebitAccount', JsonToken) then
                    TransactionLog."Debit Account" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Debit Account"));

                if PostingJson.Get('Amount', JsonToken) then
                    if Evaluate(TransactionLog."Amount", JsonToken.AsValue().AsText()) then;

                if PostingJson.Get('Currency', JsonToken) then
                    TransactionLog."Currency" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Currency"));

                if PostingJson.Get('CreditAccount', JsonToken) then
                    TransactionLog."Credit Account" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Credit Account"));

                if PostingJson.Get('ChargeAmount', JsonToken) then
                    if Evaluate(TransactionLog."Charge Amount", JsonToken.AsValue().AsText()) then;

                if PostingJson.Get('ChargeCurrency', JsonToken) then
                    TransactionLog."Charge Currency" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Charge Currency"));

                if PostingJson.Get('FeeAmount', JsonToken) then
                    if Evaluate(TransactionLog."Fee Amount", JsonToken.AsValue().AsText()) then;

                if PostingJson.Get('FeeCurrency', JsonToken) then
                    TransactionLog."Fee Currency" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Fee Currency"));

                if PostingJson.Get('Narrative1', JsonToken) then
                    TransactionLog."Narrative 1" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Narrative 1"));

                if PostingJson.Get('Narrative2', JsonToken) then
                    TransactionLog."Narrative 2" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(TransactionLog."Narrative 2"));
            end;

            // Extract AdditionalInfo
            if SendFundsJson.Get('AdditionalInfo', JsonToken) then begin
                AdditionalInfoArray := JsonToken.AsArray();
                TransactionLog.SetAdditionalInfo(Format(AdditionalInfoArray));
            end;
        end;

        // Store raw JSON payload
        TransactionLog.SetRawJsonPayload(JsonPayload);
        TransactionLog."Processing Status" := 'Processing';

        // Insert the record
        TransactionLog.Insert(true);

        // Process the transaction (add your business logic here)
        //ProcessBusinessLogic(TransactionLog);

        TransactionLog."Processed" := true;
        TransactionLog."Processing Status" := 'Completed';
        TransactionLog.Modify();


        Success := true;
        if TransactionLog."Entry No." <> 0 then begin
            TransactionLog."Processing Status" := 'Error';
            TransactionLog."Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(TransactionLog."Error Message"));
            TransactionLog.Modify();
        end;

        exit(Success);
    end;

    local procedure ProcessBusinessLogic(var TransactionLog: Record "Coop ATM Transaction Log")
    begin
        // Add your specific business logic here
        // For example:
        // - Validate accounts
        // - Create journal entries
        // - Update balances
        // - Send notifications
        // - etc.

        // Example validation
        if TransactionLog."Amount" <= 0 then
            Error('Transaction amount must be greater than zero');

        if TransactionLog."Debit Account" = '' then
            Error('Debit account is required');

        if TransactionLog."Credit Account" = '' then
            Error('Credit account is required');

        // Add more business logic as needed
    end;

    procedure GetTransactionStatus(MessageID: Text): Text
    var
        TransactionLog: Record "Coop ATM Transaction Log";
    begin
        TransactionLog.SetRange("Message ID", MessageID);
        if TransactionLog.FindFirst() then
            exit(TransactionLog."Processing Status")
        else
            exit('Not Found');
    end;
}

// Page Extension for Custom API Actions
