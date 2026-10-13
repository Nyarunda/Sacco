codeunit 50128 "NewMobileBankingEngine"
{
    /*
    SingleInstance = true;

    var
        TitleLbl: Label 'Title';
        MessageLbl: Label 'Message';
        StatusLbl: Label 'Status';
        DataLbl: Label 'Data';
        SuccessStatusLbl: Label 'Success';
        ErrorStatusLbl: Label 'Error';
        FailStatusLbl: Label 'Fail';

    procedure ProcessRequest(Request: Text): Text;
    var
        RequestJsonObject: JsonObject;
        ResponseJsonObject: JsonObject;
        RequestDataJsonObject: JsonObject;
        RequestAction: Text;
        SessionId: Text;
        IsSessionValid: Boolean;
    begin
        if not RequestJsonObject.ReadFrom(Request) then
            Error('Invalid JSON input');

        SessionId := GetJsonToken(RequestJsonObject, '$.request.session_id').AsValue().AsText();
        RequestAction := GetJsonToken(RequestJsonObject, '$.request.action').AsValue().AsText();
        RequestDataJsonObject := GetJsonToken(RequestJsonObject, '$.request.payload.data').AsObject();
        ValidateRequestHash(RequestJsonObject);
        IsSessionValid := true;

        if not (RequestAction in ['login']) then
            IsSessionValid := ValidateUserSession(RequestJsonObject);

        if IsSessionValid then
            case RequestAction of
                'get-member-details':
                    ResponseJsonObject := GetMemberDetails(RequestDataJsonObject);
                'get-accounts':
                    ResponseJsonObject := GetAccounts(RequestDataJsonObject);
                'balance-enquiry':
                    ResponseJsonObject := BalanceEnquiry(RequestDataJsonObject);
                'statement-enquiry':
                    ResponseJsonObject := StatementEnquiry(RequestDataJsonObject);
                'pesa-out-request':
                    ResponseJsonObject := PESAOUTRequest(RequestDataJsonObject);
                'pesa-out-confirmation':
                    ResponseJsonObject := PESAOUTConfirmation(RequestDataJsonObject);
                'internal-funds-transfer':
                    ResponseJsonObject := InternalFundsTransfer(RequestDataJsonObject);
                'pesa-in-confirmation':
                    ResponseJsonObject := PESAINConfirmation(RequestDataJsonObject);
                'get-loan-types':
                    ResponseJsonObject := GetLoanTypes(RequestDataJsonObject);
                'check-loan-limit':
                    ResponseJsonObject := CheckLoanLimit(RequestDataJsonObject);
                'loan-application':
                    ResponseJsonObject := LoanApplication(RequestDataJsonObject);
                'get-outstanding-loans':
                    ResponseJsonObject := GetOutstandingLoans(RequestDataJsonObject);
                'get-transaction-charges':
                    ResponseJsonObject := GetTransCharge(RequestDataJsonObject);
                'virtual-member-registration':
                    ResponseJsonObject := VirtualMemberRegistration(RequestDataJsonObject);
                else
                    SetResponseStatus(ResponseJsonObject, ErrorStatusLbl, 'Invalid request action');
            end
        else
            SetResponseStatus(ResponseJsonObject, ErrorStatusLbl, '401 Unauthorized', 'Your request could not be processed');

        exit(WrapResponse(RequestJsonObject, ResponseJsonObject));
    end;

    local procedure GetMemberDetails(RequestJsonObject: JsonObject): JsonObject;
    var
        ResponseJsonObject: JsonObject;
        DataJsonObject: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        Customer: Record Customer;
    begin
        IdentifierType := GetJsonToken(RequestJsonObject, '$.identifier_type').AsValue().AsText();
        Identifier := GetJsonToken(RequestJsonObject, '$.identifier').AsValue().AsText();

        if (IdentifierType in ['MOBILE_NUMBER', 'MEMBER_NO', 'CUSTOMER_NO', 'NATIONAL_ID_NO']) then begin
            DataJsonObject.Add('customer_type', 'INDIVIDUAL');
            DataJsonObject.Add('identifier_type', IdentifierType);
            DataJsonObject.Add('identifier', Identifier);

            if Customer.Get(Identifier) then begin
                DataJsonObject.Add('full_name', Customer.Name);
                DataJsonObject.Add('gender', Format(Customer.Gender));
                DataJsonObject.Add('date_of_birth', Customer."Birth Date");
                DataJsonObject.Add('primary_email_address', Customer."E-Mail");
                DataJsonObject.Add('primary_mobile_number', Customer."Phone No.");
                DataJsonObject.Add('member_status', Format(Customer.Blocked));
                SetResponseStatus(ResponseJsonObject, SuccessStatusLbl, 'Member details retrieved successfully');
            end else
                SetResponseStatus(ResponseJsonObject, ErrorStatusLbl, 'Member does not exist');

            ResponseJsonObject.Add(DataLbl, DataJsonObject);

        end else
            SetResponseStatus(ResponseJsonObject, ErrorStatusLbl, 'Invalid identifier type');

        exit(ResponseJsonObject);
    end;

    local procedure GetAccounts(RequestJsonObject: JsonObject): JsonObject;
    var
        ResponseJsonObject: JsonObject;
        DataJsonObject: JsonObject;
        AccountsJsonArray: JsonArray;
        AccountJsonObject: JsonObject;
        CustomerNo: Text;
        BankAccount: Record "Bank Account";
    begin
        CustomerNo := GetJsonToken(RequestJsonObject, '$.identifier').AsValue().AsText();

        BankAccount.SetRange("Customer No.", CustomerNo);
        if BankAccount.FindSet() then begin
            repeat
                Clear(AccountJsonObject);
                AccountJsonObject.Add('account_name', BankAccount.Name);
                AccountJsonObject.Add('account_number', BankAccount."Bank Account No.");
                AccountJsonObject.Add('account_type', Format(BankAccount."Account Type"));
                AccountJsonObject.Add('account_balance', BankAccount.Balance);
                AccountJsonObject.Add('account_status', Format(BankAccount.Blocked));
                AccountsJsonArray.Add(AccountJsonObject);
            until BankAccount.Next() = 0;

            DataJsonObject.Add('accounts', AccountsJsonArray);
            SetResponseStatus(ResponseJsonObject, SuccessStatusLbl, 'Accounts retrieved successfully');
        end else
            SetResponseStatus(ResponseJsonObject, ErrorStatusLbl, 'No accounts found');

        ResponseJsonObject.Add(DataLbl, DataJsonObject);
        exit(ResponseJsonObject);
    end;

    // ... (rest of procedures omitted for brevity)

    local procedure WrapResponse(RequestJsonObject: JsonObject; ResponseJsonObject: JsonObject): Text
    var
        ResponseInnerJson: JsonObject;
        WrappedJson: JsonObject;
        ResponseHash: Text;
        RequestId: Text;
        RequestAction: Text;
        ResponseStatus: Text;
        ResponsePayload: Text;
    begin
        RequestId := GetJsonToken(RequestJsonObject, '$.request.id').AsValue().AsText();
        RequestAction := GetJsonToken(RequestJsonObject, '$.request.action').AsValue().AsText();
        ResponseStatus := GetJsonToken(ResponseJsonObject, StrSubstNo('$.%1', StatusLbl)).AsValue().AsText();

        ResponseJsonObject.Remove(StatusLbl);

        ResponseJsonObject.WriteTo(ResponsePayload);
        ResponseHash := GenerateSHA256HashFromString(ResponsePayload);

        ResponseInnerJson.Add('id', RequestId);
        ResponseInnerJson.Add('action', RequestAction);
        ResponseInnerJson.Add('status', ResponseStatus);
        ResponseInnerJson.Add('hash', ResponseHash);
        ResponseInnerJson.Add('timestamp', CurrentDateTime);
        ResponseInnerJson.Add('payload', ResponseJsonObject);

        WrappedJson.Add('response', ResponseInnerJson);

        WrappedJson.WriteTo(ResponsePayload);
        exit(ResponsePayload);
    end;

    local procedure SetResponseStatus(var ResponseJsonObject: JsonObject; Status: Text; Title: Text; Message: Text)
    begin
        ResponseJsonObject.Add(StatusLbl, Status);
        ResponseJsonObject.Add(TitleLbl, Title);
        ResponseJsonObject.Add(MessageLbl, Message);
    end;

    local procedure GetJsonToken(JsonObject: JsonObject; Path: Text): JsonToken
    var
        JsonToken: JsonToken;
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('Could not find a token with path %1', Path);
        exit(JsonToken);
    end;

    local procedure ValidateRequestHash(RequestJsonObject: JsonObject)
    var
        PayloadJsonObject: JsonObject;
        PayloadText: Text;
        HashFromPayload: Text;
        HashedPayload: Text;
    begin
        HashFromPayload := GetJsonToken(RequestJsonObject, '$.request.hash').AsValue().AsText();
        PayloadJsonObject := GetJsonToken(RequestJsonObject, '$.request.payload').AsObject();

        PayloadJsonObject.WriteTo(PayloadText);
        HashedPayload := GenerateSHA256HashFromString(PayloadText);

        if HashedPayload <> HashFromPayload then
            Error('Payload hash mismatch');
    end;

    local procedure GenerateSHA256HashFromString(InputString: Text): Text;
    var
        HashAlgorithm: Codeunit "Hash Algorithm";
        HashText: Text;
    begin
        HashText := HashAlgorithm.GenerateHash(InputString, HashAlgorithm.GetSupportedAlgorithms().Get(3)); // SHA256
        exit(HashText);
    end;

    local procedure ValidateUserSession(RequestJsonObject: JsonObject): Boolean;
    var
        UserSetup: Record "User Setup";
        UserName: Text;
        SessionId: Text;
    begin
        UserName := GetJsonToken(RequestJsonObject, '$.request.user').AsValue().AsText();
        SessionId := GetJsonToken(RequestJsonObject, '$.request.session_id').AsValue().AsText();

        if UserSetup.Get(UserName) then
            if UserSetup."Session ID" = SessionId then
                exit(true);

        exit(false);
    end;
    */
}