codeunit 50094 "Coop B2B_P2F"
{
    //was originally 50163 "CoopB2B_P2F"
    /// <summary>
    /// SACCO member account validation service for P2F (Person to FOSA) transactions
    /// Processes JSON requests and returns validation responses for SACCO members
    /// </summary>
    trigger OnRun()
    begin
    end;

    var
        // Reuse the same status codes as CoopB2B for consistency
        NonMemberAccount: Label 'NM0001';
        SkyMbanking: Codeunit "Sky MBanking";
        Success: label '200';
        Account_Does_Not_Exist: label '300';
        Parameters_Not_Valid_Or_Missing: label '400';
        Caller_Not_Authorized_For_This_Request: label '401';
        Insufficient_Funds: label '402';
        Daily_Amount_Limit_Reached: label '403';
        Operation_Does_Not_Exist: label '404';
        Daily_Frequency_Limit_Reached: label '405';
        Severe_problem_Has_Occured: label '500';

        // CoopB2B integration variables
        Source: Enum "SMS Source Enum";
        ExciseDutyGL: Code[20];
        ExciseDutyRate: Decimal;
        ExciseDuty: Decimal;
        CoopSetup: Record "Sacco Setup";
        ChargeAmount: Decimal;
        TransAmount: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        GenLedgerSetup: Record "General Ledger Setup";
        BUser: Record "User Setup";
        SaccoTrans: Codeunit "Sacco Activities";
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        AccNo: Code[20];
        BalAccNo: Code[20];
        ExtDoc: Code[20];
        LoanNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        SystCreated: Boolean;
        Continue: Boolean;

    /// <summary>
    /// Main entry point for processing JSON requests
    /// </summary>
    /// <param name="JSONRequest">The JSON request string</param>
    /// <returns>JSON response string</returns>
    procedure AccountValidation(JSONRequest: Text): Text
    var
        RequestObj: JsonObject;
        HeaderObj: JsonObject;
        RequestBodyObj: JsonObject;
        HeaderToken: JsonToken;
        RequestToken: JsonToken;
        TempToken: JsonToken;
        ServiceName: Text;
        MessageID: Text;
        ConnectionID: Text;
        ConnectionPassword: Text;
        TransactionReferenceCode: Text;
        TransactionDate: Text;
        InstitutionCode: Text;
        Response: Text;
    begin
        // Parse the JSON request
        if not RequestObj.ReadFrom(JSONRequest) then
            exit(CreateErrorResponse('', Parameters_Not_Valid_Or_Missing, 'Invalid JSON format'));

        // Extract header information
        if not RequestObj.Get('header', HeaderToken) then
            exit(CreateErrorResponse('', Parameters_Not_Valid_Or_Missing, 'Header section missing'));

        HeaderObj := HeaderToken.AsObject();

        if HeaderObj.Get('serviceName', TempToken) then ServiceName := TempToken.AsValue().AsText() else ServiceName := '';
        if HeaderObj.Get('messageID', TempToken) then MessageID := TempToken.AsValue().AsText() else MessageID := '';
        if HeaderObj.Get('connectionID', TempToken) then ConnectionID := TempToken.AsValue().AsText() else ConnectionID := '';
        if HeaderObj.Get('connectionPassword', TempToken) then ConnectionPassword := TempToken.AsValue().AsText() else ConnectionPassword := '';

        // Extract request body
        if not RequestObj.Get('request', RequestToken) then
            exit(CreateErrorResponse(MessageID, Parameters_Not_Valid_Or_Missing, 'Request section missing'));

        RequestBodyObj := RequestToken.AsObject();

        if RequestBodyObj.Get('TransactionReferenceCode', TempToken) then TransactionReferenceCode := TempToken.AsValue().AsText() else TransactionReferenceCode := '';
        if RequestBodyObj.Get('TransactionDate', TempToken) then TransactionDate := TempToken.AsValue().AsText() else TransactionDate := '';
        if RequestBodyObj.Get('InstitutionCode', TempToken) then InstitutionCode := TempToken.AsValue().AsText() else InstitutionCode := '';


        Response := ProcessAccountValidation(MessageID, TransactionReferenceCode, TransactionDate, InstitutionCode, ConnectionID);


        exit(Response);
    end;

    procedure OLDAccountValidation(JSONRequest: Text): Text
    var
        RequestObj: JsonObject;
        HeaderObj: JsonObject;
        RequestBodyObj: JsonObject;
        HeaderToken: JsonToken;
        RequestToken: JsonToken;
        TempToken: JsonToken;
        ServiceName: Text;
        MessageID: Text;
        ConnectionID: Text;
        ConnectionPassword: Text;
        TransactionReferenceCode: Text;
        TransactionDate: Text;
        InstitutionCode: Text;
        Response: Text;
    begin
        // Parse the JSON request
        if not RequestObj.ReadFrom(JSONRequest) then
            exit(CreateErrorResponse('', Parameters_Not_Valid_Or_Missing, 'Invalid JSON format'));

        // Extract header information
        if not RequestObj.Get('header', HeaderToken) then
            exit(CreateErrorResponse('', Parameters_Not_Valid_Or_Missing, 'Header section missing'));

        HeaderObj := HeaderToken.AsObject();

        if HeaderObj.Get('serviceName', TempToken) then ServiceName := TempToken.AsValue().AsText() else ServiceName := '';
        if HeaderObj.Get('messageID', TempToken) then MessageID := TempToken.AsValue().AsText() else MessageID := '';
        if HeaderObj.Get('connectionID', TempToken) then ConnectionID := TempToken.AsValue().AsText() else ConnectionID := '';
        if HeaderObj.Get('connectionPassword', TempToken) then ConnectionPassword := TempToken.AsValue().AsText() else ConnectionPassword := '';

        // Extract request body
        if not RequestObj.Get('request', RequestToken) then
            exit(CreateErrorResponse(MessageID, Parameters_Not_Valid_Or_Missing, 'Request section missing'));

        RequestBodyObj := RequestToken.AsObject();

        if RequestBodyObj.Get('TransactionReferenceCode', TempToken) then TransactionReferenceCode := TempToken.AsValue().AsText() else TransactionReferenceCode := '';
        if RequestBodyObj.Get('TransactionDate', TempToken) then TransactionDate := TempToken.AsValue().AsText() else TransactionDate := '';
        if RequestBodyObj.Get('InstitutionCode', TempToken) then InstitutionCode := TempToken.AsValue().AsText() else InstitutionCode := '';


        // Process based on service name - support multiple client institutions
        case ServiceName of
            'AccountValidation':
                Response := ProcessAccountValidation(MessageID, TransactionReferenceCode, TransactionDate, InstitutionCode, ConnectionID);
            'PaymentAdvise':
                Response := ProcessPaymentAdvise(JSONRequest);
            'Pay2Fosa':
                Response := ProcessPay2Fosa(JSONRequest);
            else
                Response := CreateErrorResponse(MessageID, Operation_Does_Not_Exist, 'Service not supported for client: ' + ServiceName);
        end;

        exit(Response);
    end;

    /// <summary>
    /// Validates connection credentials for various client institutions
    /// </summary>


    /// <summary>
    /// Processes account validation for SACCO member accounts
    /// </summary>



    local procedure ProcessAccountValidation(MessageID: Text; TransactionReferenceCode: Text; TransactionDate: Text; InstitutionCode: Text; ConnectionID: Text): Text
    var
        MemberInfo: Record Members;
        ResponseObj: JsonObject;
        HeaderObj: JsonObject;
        ResponseBodyObj: JsonObject;
        AccountName: Text;
        InstitutionName: Text;
        StatusCode: Text;
        StatusDescription: Text;
        AccountDescription: Text;
        Response: Text;
    begin
        // Initialize response values
        StatusCode := Account_Does_Not_Exist;
        StatusDescription := 'SACCO member account not found';
        AccountName := '';
        InstitutionName := '';
        AccountDescription := '';

        // Try to find SACCO member by transaction reference code using CoopB2B logic
        // The transaction reference code might contain member information
        if FindMemberAccount(TransactionReferenceCode, InstitutionCode, ConnectionID, AccountName, InstitutionName, AccountDescription) then begin
            StatusCode := Success;
            StatusDescription := 'Successfully validated member';
        end else begin
            if AccountDescription <> '' then begin
                // If there was an error description, use it
                StatusDescription := AccountDescription;
            end;

        end;


        // Build response header
        HeaderObj.Add('messageID', MessageID);
        HeaderObj.Add('statusCode', StatusCode);
        HeaderObj.Add('statusDescription', StatusDescription);

        // Build response body
        ResponseBodyObj.Add('TransactionReferenceCode', TransactionReferenceCode);
        ResponseBodyObj.Add('AccountName', AccountName);
        ResponseBodyObj.Add('InstitutionName', InstitutionName);

        // Combine into final response
        ResponseObj.Add('header', HeaderObj);
        ResponseObj.Add('response', ResponseBodyObj);

        ResponseObj.WriteTo(Response);
        exit(Response);
    end;

    /// <summary>
    /// Processes payment advise requests by borrowing from CoopB2B functionality
    /// </summary>
    procedure ProcessPaymentAdvise(JSONRequest: Text): Text
    var
        RequestObj: JsonObject;
        HeaderObj: JsonObject;
        RequestBodyObj: JsonObject;
        HeaderToken: JsonToken;
        RequestToken: JsonToken;
        TempToken: JsonToken;
        ServiceName: Text;
        MessageID: Text;
        ConnectionID: Text;
        ConnectionPassword: Text;
        TransactionReferenceCode: Text;
        TransactionDate: DateTime;
        TotalAmount: Decimal;
        Currency: Text;
        DocumentReferenceNumber: Text;
        BankCode: Text;
        BranchCode: Text;
        PaymentDate: DateTime;
        PaymentMode: Text;
        AccountNumber: Text;
        InstitutionCode: Text;
        InstitutionName: Text;
        Response: Text;
        DateTimeText: Text;
    begin
        // Parse the JSON request
        if not RequestObj.ReadFrom(JSONRequest) then
            exit(CreateErrorResponse('', Parameters_Not_Valid_Or_Missing, 'Invalid JSON format'));

        // Extract header information
        if not RequestObj.Get('header', HeaderToken) then
            exit(CreateErrorResponse('', Parameters_Not_Valid_Or_Missing, 'Header section missing'));

        HeaderObj := HeaderToken.AsObject();

        if HeaderObj.Get('serviceName', TempToken) then ServiceName := TempToken.AsValue().AsText() else ServiceName := '';
        if HeaderObj.Get('messageID', TempToken) then MessageID := TempToken.AsValue().AsText() else MessageID := '';
        if HeaderObj.Get('connectionID', TempToken) then ConnectionID := TempToken.AsValue().AsText() else ConnectionID := '';
        if HeaderObj.Get('connectionPassword', TempToken) then ConnectionPassword := TempToken.AsValue().AsText() else ConnectionPassword := '';

        // Extract request body
        if not RequestObj.Get('request', RequestToken) then
            exit(CreateErrorResponse(MessageID, Parameters_Not_Valid_Or_Missing, 'Request section missing'));

        RequestBodyObj := RequestToken.AsObject();

        if RequestBodyObj.Get('TransactionReferenceCode', TempToken) then TransactionReferenceCode := TempToken.AsValue().AsText() else TransactionReferenceCode := '';
        if RequestBodyObj.Get('TransactionDate', TempToken) then begin
            DateTimeText := TempToken.AsValue().AsText();
            if not Evaluate(TransactionDate, DateTimeText) then
                TransactionDate := CurrentDateTime;
        end else
            TransactionDate := CurrentDateTime;
        if RequestBodyObj.Get('TotalAmount', TempToken) then TotalAmount := TempToken.AsValue().AsDecimal() else TotalAmount := 0;
        if RequestBodyObj.Get('Currency', TempToken) then Currency := TempToken.AsValue().AsText() else Currency := '';
        if RequestBodyObj.Get('DocumentReferenceNumber', TempToken) then DocumentReferenceNumber := TempToken.AsValue().AsText() else DocumentReferenceNumber := '';
        if RequestBodyObj.Get('BankCode', TempToken) then BankCode := TempToken.AsValue().AsText() else BankCode := '';
        if RequestBodyObj.Get('BranchCode', TempToken) then BranchCode := TempToken.AsValue().AsText() else BranchCode := '';
        if RequestBodyObj.Get('PaymentDate', TempToken) then begin
            DateTimeText := TempToken.AsValue().AsText();
            if not Evaluate(PaymentDate, DateTimeText) then
                PaymentDate := CurrentDateTime;
        end else
            PaymentDate := CurrentDateTime;
        if RequestBodyObj.Get('PaymentMode', TempToken) then PaymentMode := TempToken.AsValue().AsText() else PaymentMode := '';
        if RequestBodyObj.Get('AccountNumber', TempToken) then AccountNumber := TempToken.AsValue().AsText() else AccountNumber := '';
        if RequestBodyObj.Get('InstitutionCode', TempToken) then InstitutionCode := TempToken.AsValue().AsText() else InstitutionCode := '';
        if RequestBodyObj.Get('InstitutionName', TempToken) then InstitutionName := TempToken.AsValue().AsText() else InstitutionName := '';


        // Call integrated PaymentAdvise function with extracted parameters
        Response := PaymentAdvise(
            ServiceName,
            MessageID,
            ConnectionID,
            ConnectionPassword,
            TransactionReferenceCode,
            TransactionDate,
            TotalAmount,
            Currency,
            DocumentReferenceNumber,
            BankCode,
            BranchCode,
            PaymentDate,
            DocumentReferenceNumber, // PaymentReferenceCode
            PaymentMode, // PaymentCode
            PaymentMode,
            TotalAmount, // PaymentAmount
            '', // AdditionalInfo
            AccountNumber,
            '', // AccountName (will be populated by integrated function)
            InstitutionCode,
            InstitutionName
        );

        exit(Response);
    end;

    /// <summary>
    /// Processes Pay2Fosa requests by parsing JSON and calling integrated Pay2FosaPaymentAdvise
    /// </summary>
    procedure ProcessPay2Fosa(JSONRequest: Text): Text
    var
        RequestObj: JsonObject;
        TempToken: JsonToken;
        AcctNo: Text;
        Amount: Decimal;
        BookedBalance: Decimal;
        ClearedBalance: Decimal;
        Currency: Text;
        CustMemoLine1: Text;
        CustMemoLine2: Text;
        CustMemoLine3: Text;
        EventType: Text;
        ExchangeRate: Text;
        Narration: Text;
        PaymentRef: Text;
        PostingDate: DateTime;
        ValueDate: DateTime;
        TransactionDate: DateTime;
        TransactionId: Text;
        TransactionType: Text;
        PostingDateText: Text;
        ValueDateText: Text;
        TransactionDateText: Text;
        AmountText: Text;
        Response: Text;
    begin
        // Parse the JSON request - direct format (no header/request structure)
        if not RequestObj.ReadFrom(JSONRequest) then
            exit('{"MessageCode": "400", "Message": "Invalid JSON format"}');

        // Extract all Pay2Fosa fields
        if RequestObj.Get('AcctNo', TempToken) then AcctNo := TempToken.AsValue().AsText() else AcctNo := '';
        if RequestObj.Get('Amount', TempToken) then begin
            AmountText := TempToken.AsValue().AsText();
            if not Evaluate(Amount, AmountText) then Amount := 0;
        end else
            Amount := 0;
        if RequestObj.Get('BookedBalance', TempToken) then begin
            AmountText := TempToken.AsValue().AsText();
            if not Evaluate(BookedBalance, AmountText) then BookedBalance := 0;
        end else
            BookedBalance := 0;
        if RequestObj.Get('ClearedBalance', TempToken) then begin
            AmountText := TempToken.AsValue().AsText();
            if not Evaluate(ClearedBalance, AmountText) then ClearedBalance := 0;
        end else
            ClearedBalance := 0;

        if RequestObj.Get('Currency', TempToken) then Currency := TempToken.AsValue().AsText() else Currency := '';
        if RequestObj.Get('CustMemoLine1', TempToken) then CustMemoLine1 := TempToken.AsValue().AsText() else CustMemoLine1 := '';
        if RequestObj.Get('CustMemoLine2', TempToken) then CustMemoLine2 := TempToken.AsValue().AsText() else CustMemoLine2 := '';
        if RequestObj.Get('CustMemoLine3', TempToken) then CustMemoLine3 := TempToken.AsValue().AsText() else CustMemoLine3 := '';
        if RequestObj.Get('EventType', TempToken) then EventType := TempToken.AsValue().AsText() else EventType := '';
        if RequestObj.Get('ExchangeRate', TempToken) then ExchangeRate := TempToken.AsValue().AsText() else ExchangeRate := '';
        if RequestObj.Get('Narration', TempToken) then Narration := TempToken.AsValue().AsText() else Narration := '';
        if RequestObj.Get('PaymentRef', TempToken) then PaymentRef := TempToken.AsValue().AsText() else PaymentRef := '';
        if RequestObj.Get('PostingDate', TempToken) then begin
            PostingDateText := TempToken.AsValue().AsText();
            if not Evaluate(PostingDate, PostingDateText) then
                PostingDate := CurrentDateTime;
        end else
            PostingDate := CurrentDateTime;
        if RequestObj.Get('ValueDate', TempToken) then begin
            ValueDateText := TempToken.AsValue().AsText();
            if not Evaluate(ValueDate, ValueDateText) then
                ValueDate := CurrentDateTime;
        end else
            ValueDate := CurrentDateTime;

        if RequestObj.Get('TransactionDate', TempToken) then begin
            TransactionDateText := TempToken.AsValue().AsText();
            if not Evaluate(TransactionDate, TransactionDateText) then
                TransactionDate := CurrentDateTime;
        end else
            TransactionDate := CurrentDateTime;
        if RequestObj.Get('TransactionId', TempToken) then TransactionId := TempToken.AsValue().AsText() else TransactionId := '';
        if RequestObj.Get('TransactionType', TempToken) then TransactionType := TempToken.AsValue().AsText() else TransactionType := '';

        // Call integrated Pay2FosaPaymentAdvise function
        Response := Pay2FosaPaymentAdvise(
            AcctNo,
            Amount,
            BookedBalance,
            ClearedBalance,
            Currency,
            CustMemoLine1,
            CustMemoLine2,
            CustMemoLine3,
            EventType,
            ExchangeRate,
            Narration,
            PaymentRef,
            PostingDate,
            ValueDate,
            TransactionDate,
            TransactionId
        );

        exit(Response);
    end;

    /// <summary>
    /// Attempts to find SACCO member account by transaction reference code
    /// Reuses the GetMemberAccount functionality from CoopB2B codeunit
    /// </summary>
    local procedure FindMemberAccount(TransactionRefCode: Text; InstCode: Text; ConnectionID: Text; var AccountName: Text; var InstitutionName: Text; var AccountDescription: Text): Boolean
    var
        MemberAccounts: Record "Savings Accounts";
        AcctNo: Text;

        AccErr: Text;
        Purpose: Option " ","Mid Salary","End Salary","Mid Pension","End Pension","Mid Allowance","End Allowance";
    begin
        // Use the integrated GetMemberAccount function
        AccountName := '';
        AccountDescription := '';
        AccErr := '';
        AcctNo := GetMemberAccount(TransactionRefCode, InstCode, AccountName, InstitutionName, AccErr, Purpose);
        AccountDescription := AccErr;

        // Check if we found a valid account
        if (AcctNo <> '') and (AccountName <> '') then begin
            exit(true);
        end;

        exit(false);
    end;



    /// <summary>
    /// Extracts member number from transaction reference code
    /// </summary>
    local procedure ExtractMemberNumber(TransactionRef: Text): Text
    var
        Parts: List of [Text];
        PartText: Text;
        i: Integer;
    begin
        // Split by common delimiters
        if StrPos(TransactionRef, '/') > 0 then begin
            Parts := TransactionRef.Split('/');
            // For "EDA/1140/13", return "1140"
            if Parts.Count() >= 2 then begin
                Parts.Get(2, PartText);
                exit(PartText);
            end;
        end;

        // Try other delimiters
        if StrPos(TransactionRef, '-') > 0 then begin
            Parts := TransactionRef.Split('-');
            if Parts.Count() >= 2 then begin
                Parts.Get(2, PartText);
                exit(PartText);
            end;
        end;

        exit('');
    end;


    /// <summary>
    /// Splits transaction reference using CoopB2B logic
    /// Reuses the SplitReference functionality from CoopB2B codeunit
    /// </summary>
    local procedure SplitTransactionReference(FullRef: Text; var DocumentNo: Code[20]; var DateString: Text): Boolean
    var
        Pos: Integer;
    begin
        // Reuse the same logic as CoopB2B.SplitReference
        DocumentNo := '';
        DateString := '';
        Pos := StrPos(FullRef, '_');

        if Pos > 0 then begin
            DateString := CopyStr(FullRef, Pos + 1, StrLen(FullRef));
            DocumentNo := CopyStr(FullRef, 1, Pos - 1);
            exit(true);
        end;

        // If no underscore found, treat entire string as document number
        DocumentNo := CopyStr(FullRef, 1, 20); // Limit to Code[20] length
        exit(false);
    end;

    /// <summary>
    /// Creates an error response JSON
    /// </summary>
    local procedure CreateErrorResponse(MessageID: Text; StatusCode: Text; StatusDescription: Text): Text
    var
        ResponseObj: JsonObject;
        HeaderObj: JsonObject;
        ResponseBodyObj: JsonObject;
        Response: Text;
    begin
        // Build error response header
        HeaderObj.Add('messageID', MessageID);
        HeaderObj.Add('statusCode', StatusCode);
        HeaderObj.Add('statusDescription', StatusDescription);

        // Build empty response body
        ResponseBodyObj.Add('TransactionReferenceCode', '');
        ResponseBodyObj.Add('AccountName', '');
        ResponseBodyObj.Add('InstitutionName', 'Unknown Client Institution');

        // Combine into final response
        ResponseObj.Add('header', HeaderObj);
        ResponseObj.Add('response', ResponseBodyObj);

        ResponseObj.WriteTo(Response);
        exit(Response);
    end;

    /// <summary>
    /// PaymentAdvise function integrated from CoopB2B codeunit
    /// </summary>
    procedure PaymentAdvise(ServiceName: Text; MessageID: Text; ConnectionID: Text; ConnectionPassword: Text; TransactionReferenceCode: Text; TransactionDate: DateTime; TotalAmount: Decimal; Currency: Text; DocumentReferenceCode: Text; BankCode: Text; BranchCode: Text; PaymentDate: DateTime; PaymentReferenceCode: Text; PaymentCode: Text; PaymentMode: Text; PaymentAmount: Decimal; AdditionalInfo: Text; AccountNumber: Text; AccountName: Text; InstitutionCode: Text; InstitutionName: Text) Response: Text
    var
        i: Decimal;
        MemberNo: Text[30];
        AccBalance: Decimal;
        thisSavAccNo: Text[30];
        foundChargeAccount: Boolean;
        A: Integer;
        MNo: Code[20];
        AcctNo: Code[20];
        TotalCharge: Decimal;
        AccBal: Decimal;
        RespMessageID: Text;
        RespStatusCode: Text;
        RespStatusDescription: Text;
        RespTransactionDate: DateTime;
        RespTransactionReferenceCode: Text;
        RespInstitutionCode: Text;
        RespInstitutionName: Text;
        RespAccountNumber: Text;
        RespTotalAmount: Decimal;
        RespAdditionalInfo: Text;
        RespCurrency: Text;
        Status: Code[50];
        ResponseTitle: Text;
        ResponseMessage: Text;
        Indent: Boolean;
        MemberAccounts: Record "Savings Accounts";
        "Action": Code[50];
        RespAccountName: Text;
        CoopTrans: Record "Coop B2B Transactions";
        Members: Record Members;
        Found: Boolean;
        Loans: Record Loans;
        AccErr: Text;
        SacooRef: Code[20];
        DateRef: Text;

        Purpose: Option " ","Mid Salary","End Salary","Mid Pension","End Pension","Mid Allowance","End Allowance";
        JsObject_1: JsonObject;
        JsObject_2: JsonObject;
        JsObject_3: JsonObject;
        JsonResult: JsonObject;
    begin
        RespMessageID := '';
        RespStatusCode := '';
        RespStatusDescription := '';
        RespTransactionReferenceCode := '';
        RespTransactionDate := 0DT;
        RespTotalAmount := 0;
        RespCurrency := '';
        RespAdditionalInfo := '';
        RespAccountNumber := '';
        RespAccountName := '';
        RespInstitutionCode := '';
        RespInstitutionName := '';
        Found := false;




        AccountName := '';
        AccErr := '';
        AcctNo := GetMemberAccount(AccountNumber, InstitutionCode, AccountName, InstitutionName, AccErr, Purpose);

        // Check if we found a valid account
        if (AcctNo <> '') and (AccountName <> '') then begin

            RespAdditionalInfo := AccountName;
            RespAccountNumber := AcctNo;
            RespAccountName := AccountName;
            Found := true;

            RespMessageID := MessageID;
            RespStatusCode := Success;
            RespStatusDescription := 'Member Validated Successfully';
            RespTransactionReferenceCode := TransactionReferenceCode;
            RespTransactionDate := TransactionDate;
            RespTotalAmount := 0;
            RespCurrency := '';
            RespInstitutionCode := InstitutionCode;
            RespInstitutionName := InstitutionName;

            CoopTrans.Reset;
            CoopTrans.SetRange("Transaction Reference Code", TransactionReferenceCode);
            if CoopTrans.FindFirst then begin
                RespMessageID := MessageID;
                RespStatusCode := Success;
                RespStatusDescription := 'Transaction Already Exists';
                RespTransactionReferenceCode := TransactionReferenceCode;
                RespTransactionDate := TransactionDate;
                RespTotalAmount := TotalAmount;
                RespCurrency := '';
                RespAdditionalInfo := '';
                RespAccountNumber := '';
                RespAccountName := '';
                RespInstitutionCode := InstitutionCode;
                RespInstitutionName := InstitutionName;
            end
            else begin
                CoopTrans.Init;
                CoopTrans."Transaction Reference Code" := TransactionReferenceCode;
                SplitTransactionReference(TransactionReferenceCode, CoopTrans."Sacco Reference", DateRef);
                CoopTrans."Service Name" := ServiceName;
                CoopTrans."Transaction Date" := Dt2Date(TransactionDate);
                CoopTrans."Transaction Time" := Dt2Time(TransactionDate);
                CoopTrans."Total Amount" := TotalAmount;
                CoopTrans.Currency := Currency;
                CoopTrans."Document Reference Code" := DocumentReferenceCode;
                CoopTrans."Bank Code" := BankCode;
                CoopTrans."Branch Code" := BranchCode;
                CoopTrans."Payment Date" := PaymentDate;
                CoopTrans."Payment Reference Code" := PaymentReferenceCode;
                CoopTrans."Payment Code" := PaymentCode;
                CoopTrans."Payment Mode" := PaymentMode;
                CoopTrans."Payment Amount" := PaymentAmount;
                CoopTrans."Additional Info" := AdditionalInfo;
                CoopTrans."Account Number" := AcctNo;
                CoopTrans."Account Name" := RespAccountName;
                CoopTrans."Institution Code" := InstitutionCode;
                CoopTrans."Institution Name" := InstitutionName;
                CoopTrans.Description := 'Coop Bank Deposit';
                CoopTrans.Insert;
                Commit();

                PostTransaction(TransactionReferenceCode);

                RespMessageID := MessageID;
                RespStatusCode := Success;
                RespStatusDescription := 'Payment successfully received';
                RespTransactionReferenceCode := TransactionReferenceCode;
                RespTransactionDate := TransactionDate;
                RespTotalAmount := TotalAmount;
                RespCurrency := Currency;
                RespAdditionalInfo := AdditionalInfo;
                RespInstitutionCode := InstitutionCode;
                RespInstitutionName := InstitutionName;
            end;

        end
        else begin
            RespMessageID := MessageID;
            RespStatusCode := Account_Does_Not_Exist;
            RespStatusDescription := AccErr;
            RespTransactionReferenceCode := TransactionReferenceCode;
            RespTransactionDate := TransactionDate;
            RespTotalAmount := 0;
            RespCurrency := '';
            RespAdditionalInfo := '';
            RespAccountNumber := '';
            RespAccountName := '';
            RespInstitutionCode := InstitutionCode;
            RespInstitutionName := InstitutionName;
        end;

        JsObject_3.Add('messageID', RespMessageID);
        JsObject_3.Add('statusCode', RespStatusCode);
        JsObject_3.Add('statusDescription', RespStatusDescription);

        JsObject_2.Add('TransactionReferenceCode', RespTransactionReferenceCode);
        JsObject_2.Add('TransactionDate', RespTransactionDate);
        JsObject_2.Add('TransactionAmount', RespTotalAmount);
        JsObject_2.Add('AccountNumber', RespAccountNumber);
        JsObject_2.Add('AccountName', RespAccountName);
        JsObject_2.Add('InstitutionCode', RespInstitutionCode);
        JsObject_2.Add('InstitutionName', RespInstitutionName);

        JsonResult.Add('header', JsObject_3);
        JsonResult.Add('response', JsObject_2);

        JsonResult.WriteTo(Response);
    end;

    /// <summary>
    /// GetMemberAccount function integrated from CoopB2B codeunit
    /// </summary>
    procedure GetMemberAccount(TransactionReferenceCode: Text; InstitutionCode: Text; var AccountName: Text; var InstName: Text; var AccErr: Text; var Purpose: Option " ","Mid Salary","End Salary","Mid Pension","End Pension","Mid Allowance","End Allowance") AcctNo: Text
    var
        i: Decimal;
        MemberNo: Text[30];
        AccBalance: Decimal;
        thisSavAccNo: Text[30];
        foundChargeAccount: Boolean;
        A: Integer;
        MNo: Code[20];
        ss: Code[20];
        KeyValue: Code[10];
        MemAccNo: Code[20];
        TotalCharge: Decimal;
        AccBal: Decimal;
        MemberAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        Members: Record Members;
        ProductFactory: Record "Product Setup";
        Found: Boolean;
    begin
        MemberNo := '';
        AcctNo := '';
        InstName := '';
        Found := false;
        AccountName := '';
        AccErr := '';
        Purpose := Purpose::" ";
        IF TransactionReferenceCode = '' then BEGIN
            AccErr := 'Transaction Reference Code is empty';
            exit;
        END;


        if TransactionReferenceCode = NonMemberAccount then begin
            AcctNo := NonMemberAccount;
            AccountName := 'Non Member Account';
            exit;
        end;

        if MemberAccounts.Get(TransactionReferenceCode) then begin
            AcctNo := MemberAccounts."No.";
            AccountName := MemberAccounts.Name + ': ' + MemberAccounts."Product Name";
            exit;
        end;


        if Members.Get(TransactionReferenceCode) then begin
            MemberNo := Members."No.";
        end
        else begin
            Members.Reset();
            Members.SetRange("Old Member No.", TransactionReferenceCode);
            if Members.FindFirst then begin
                MemberNo := Members."No.";
            end
            else begin
                if Loans.Get(TransactionReferenceCode) then begin
                    Loans.CalcFields("Total Outstanding Balance");
                    if Loans."Total Outstanding Balance" > 0 then begin
                        AcctNo := Loans."Loan No.";
                        AccountName := Loans."Member Name" + ': ' + Loans."Loan Product Type Name";
                        exit;
                    end;
                end else begin

                    ProcessString(TransactionReferenceCode, MemAccNo, KeyValue);

                    IF Members.GET(MemAccNo) THEN BEGIN
                        MemberNo := Members."No.";
                        AcctNo := Members."No.";
                    END ELSE BEGIN
                        IF MemAccNo = '' THEN
                            MemAccNo := TransactionReferenceCode;

                        Members.RESET();
                        Members.SETRANGE("ID No.", MemAccNo);
                        IF (Members.FIND('-')) AND (MemAccNo <> '') THEN BEGIN
                            MemberNo := Members."No.";
                            AcctNo := Members."No.";
                        END;
                    END;
                end;
            end;
        end;

        if (MemberNo <> '') and (InstitutionCode <> '') then begin
            ProductFactory.Reset;
            ProductFactory.SetRange("B2B Code", InstitutionCode); // Field may not exist in this setup
            if ProductFactory.FindFirst then begin
                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", MemberNo);
                MemberAccounts.SetRange("Product Type", ProductFactory."Product ID");
                if MemberAccounts.FindFirst then begin
                    AcctNo := MemberAccounts."No.";
                    AccountName := MemberAccounts.Name + ': ' + MemberAccounts."Product Name";
                    InstName := ProductFactory.Description;
                    exit;
                end
                else begin


                    Loans.Reset;
                    Loans.SetRange("Member No.", MemberNo);
                    Loans.SetRange("Loan Product Type", ProductFactory."Product ID");
                    Loans.SetFilter("Total Outstanding Balance", '>0');
                    if Loans.FindFirst then begin
                        AcctNo := Loans."Loan No.";
                        AccountName := Loans."Member Name" + ': ' + Loans."Loan Product Type Name";
                        exit;
                    end
                    else
                        AccErr := 'Member Found But Does not have this product';

                end;
            end
            else
                AccErr := 'Member Found But Does not have this product';
        end
        else begin
            if InstitutionCode <> '' then begin
                AccErr := 'Account Does Not Exist';
            end
            else begin
                //Pay2Fosa

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", TransactionReferenceCode);
                MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Unallocated Fund");
                if MemberAccounts.FindFirst then begin
                    AcctNo := MemberAccounts."No.";
                    AccountName := MemberAccounts.Name + ' ' + MemberAccounts."Product Name";
                    exit;
                end
                else begin


                    MemberAccounts.Reset;
                    MemberAccounts.SetRange("Old Member No.", TransactionReferenceCode);
                    MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Unallocated Fund");
                    if MemberAccounts.FindFirst then begin
                        AcctNo := MemberAccounts."No.";
                        AccountName := MemberAccounts.Name + ' ' + MemberAccounts."Product Name";
                        exit;
                    end
                    else begin

                        MemberAccounts.Reset;
                        MemberAccounts.SetRange("ID No.", TransactionReferenceCode);
                        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Unallocated Fund");
                        if MemberAccounts.FindFirst then begin
                            AcctNo := MemberAccounts."No.";
                            AccountName := MemberAccounts.Name + ' ' + MemberAccounts."Product Name";
                            exit;
                        end
                        else begin

                            MemberAccounts.Reset;
                            MemberAccounts.SetRange("Mobile Phone No.", TransactionReferenceCode);
                            MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Unallocated Fund");
                            if MemberAccounts.FindFirst then begin
                                AcctNo := MemberAccounts."No.";
                                AccountName := MemberAccounts.Name + ' ' + MemberAccounts."Product Name";
                                exit;
                            end
                            else begin

                                GetAccountFromKeyWord(TransactionReferenceCode, AcctNo, Purpose);
                                if AcctNo <> '' then begin
                                    MemberAccounts.Reset;
                                    MemberAccounts.SetRange("ID No.", AcctNo);
                                    MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Unallocated Fund");
                                    if MemberAccounts.FindFirst then begin
                                        AcctNo := MemberAccounts."No.";
                                        AccountName := MemberAccounts.Name + ' ' + MemberAccounts."Product Name";
                                        exit;
                                    end
                                    else begin
                                        MemberAccounts.Reset;
                                        MemberAccounts.SetRange("Member No.", AcctNo);
                                        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Unallocated Fund");
                                        if MemberAccounts.FindFirst then begin
                                            AcctNo := MemberAccounts."No.";
                                            AccountName := MemberAccounts.Name + ' ' + MemberAccounts."Product Name";
                                            exit;
                                        end
                                        else begin
                                            AccErr := 'Account Does Not Exist';
                                        end;
                                    end;
                                end;
                            end;
                        end;

                    end;
                end;

            end;


        end;
    end;

    local procedure ProcessString(InputString: Text; var MembAcc: Code[20]; var KeyValue: Code[10])
    var
        HashPosition: Integer;
    begin
        Clear(MembAcc);
        Clear(KeyValue);

        HashPosition := StrLen(InputString);

        if HashPosition <= 3 then begin
            KeyValue := CopyStr(InputString, 1, MaxStrLen(KeyValue));
            exit;
        end;

        MembAcc := CopyStr(InputString, 1, HashPosition - 3);
        KeyValue := CopyStr(InputString, HashPosition - 2, 3);
    end;

    local procedure GetCoopBankPostingDescription(Narration: Text; MemberNo: Code[20]; MemberName: Text): Text[100]
    var
        BankDescription: Text;
    begin
        BankDescription := Narration;

        if MemberNo <> '' then
            BankDescription += ' - ' + MemberNo;
        if MemberName <> '' then
            BankDescription += ' - ' + MemberName;

        exit(CopyStr(BankDescription, 1, 100));
    end;

    local procedure FindMemberUnallocatedAccount(MemberNo: Code[20]; var UnallocatedSavings: Record "Savings Accounts"): Boolean
    begin
        UnallocatedSavings.Reset();
        UnallocatedSavings.SetRange("Member No.", MemberNo);
        UnallocatedSavings.SetRange("Product Category", UnallocatedSavings."Product Category"::"Unallocated Fund");
        exit(UnallocatedSavings.FindFirst());
    end;

    local procedure GetCoopReceiptSmsMessage(MemberName: Text[100]; Amount: Decimal; PostingDate: Date; LoanNo: Code[20]; SavingsProductName: Text[100]; IsLoan: Boolean): Text[250]
    var
        SaccoName: Text;
        Body: Text;
        FirstName: Text;
    begin
        SaccoName := CompanyName;
        FirstName := SkyMbanking.FirstName(MemberName);
        if FirstName = '' then
            FirstName := MemberName;

        if IsLoan then
            Body := StrSubstNo(
                'We confirm receipt of KES %1 on %2. Your loan %3 has been updated. Thank you for your continued support. - %4',
                FormatCoopNotificationAmount(Amount), Format(PostingDate), LoanNo, SaccoName)
        else
            Body := StrSubstNo(
                'We confirm receipt of KES %1 on %2. Your %3 has been updated. Thank you for your continued support. - %4',
                FormatCoopNotificationAmount(Amount), Format(PostingDate), SavingsProductName, SaccoName);

        exit(CopyStr('Dear ' + FirstName + ', ' + Body, 1, 250));
    end;

    local procedure SendCoopReceiptSms(Telephone: Text[200]; MessageText: Text[250]; Reference: Code[20]; AccountNo: Code[20])
    var
        MemberActivities: Codeunit "Member Activities";
    begin
        if Telephone = '' then
            exit;

        MemberActivities.SendSms(Source::"Deposit Confirmation", Telephone, MessageText, Reference, AccountNo, false, false);
    end;

    local procedure GetSavingsProductName(SavingsAccount: Record "Savings Accounts"): Text[100]
    begin
        if SavingsAccount."Product Name" <> '' then
            exit(SavingsAccount."Product Name");

        if Format(SavingsAccount."Product Category") <> '' then
            exit(CopyStr(Format(SavingsAccount."Product Category"), 1, 100));

        exit(SavingsAccount."No.");
    end;

    local procedure FormatCoopNotificationAmount(Amount: Decimal): Text
    begin
        exit(Format(Amount, 0, '<Precision,2:2><Standard Format,0>'));
    end;

    local procedure CreateCoopLoanRepaymentJournals(TransactionAmount: Decimal; TransactionDescription: Text[100]; MemberNo: Code[20]; LoanNumber: Code[20]; UnallocatedAccountNo: Code[20]; DimensionSetID: Integer)
    var
        Loan: Record Loans;
        LoanType: Record "Product Setup";
        Savings: Record "Savings Accounts";
        FosaAccount: Record "Savings Accounts";
        LoanSchedule: Record "Loan Repayment Schedule";
        MemberActivities: Codeunit "Member Activities";
        AccountType: Enum "Gen. Journal Account Type";
        BalanceAccountType: Enum "Gen. Journal Account Type";
        TransactionChannel: Enum "Transaction Channel";
        TransactionType: Enum "Transaction Type Enum";
        RunBal: Decimal;
        AccountBalance: Decimal;
        RepayAmount: Decimal;
        PrincipalAmount: Decimal;
        ExpectedBalance: Decimal;
        ExpectedAmount: Decimal;
        AmountPaid: Decimal;
        DefaultedAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        ArrearsAsAt: Date;
        GracePeriod: DateFormula;
    begin
        if LoanNumber = '' then
            exit;

        if UnallocatedAccountNo = '' then
            Error(
                'Member %1 does not have an Unallocated Fund account. The Coop payment for loan %2 cannot be distributed.',
                MemberNo,
                LoanNumber);

        Loan.Reset();
        Loan.SetRange("Loan No.", LoanNumber);
        Loan.SetRange("Member No.", MemberNo);
        if not Loan.FindFirst() then
            Error('Loan %1 does not belong to member %2.', LoanNumber, MemberNo);

        LoanType.Get(Loan."Loan Product Type");
        AccountBalance := MemberActivities.GetAccountBalance(UnallocatedAccountNo);
        if AccountBalance > 0 then
            AccountBalance := 0;

        RunBal := AccountBalance + TransactionAmount;
        if RunBal > TransactionAmount then
            RunBal := TransactionAmount;
        if RunBal <= 0 then
            exit;

        ArrearsAsAt := CalcDate('<-CM>', PDate) - 1;

        Loan.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty");

        // Arrears: penalty, insurance, interest, then principal.
        RepayAmount := Loan."Outstanding Penalty" -
            SaccoTrans.GetJournalLoanCredits(JTemplate, JBatch, AccountType::Credit, Loan."Loan Account", Loan."Loan No.", TransactionType::"Penalty Paid");
        ApplyCoopLoanRepaymentComponent(
            Loan, UnallocatedAccountNo, RepayAmount,
            LoanType."USSD Product Name" + ': Penalty Repayment',
            TransactionType::"Penalty Paid", RunBal, DimensionSetID);

        RepayAmount := SaccoTrans.GetInsuranceArrears(Loan."Loan No.", ArrearsAsAt) -
            SaccoTrans.GetJournalLoanCredits(JTemplate, JBatch, AccountType::Credit, Loan."Loan Account", Loan."Loan No.", TransactionType::"Insurance Paid");
        if RepayAmount > Loan."Outstanding Insurance" then
            RepayAmount := Loan."Outstanding Insurance";
        ApplyCoopLoanRepaymentComponent(
            Loan, UnallocatedAccountNo, RepayAmount,
            LoanType."USSD Product Name" + ': Insurance Repayment',
            TransactionType::"Insurance Paid", RunBal, DimensionSetID);

        RepayAmount := SaccoTrans.GetInterestArrears(Loan."Loan No.", ArrearsAsAt) -
            SaccoTrans.GetJournalLoanCredits(JTemplate, JBatch, AccountType::Credit, Loan."Loan Account", Loan."Loan No.", TransactionType::"Interest Paid");
        if RepayAmount > Loan."Outstanding Interest" then
            RepayAmount := Loan."Outstanding Interest";
        ApplyCoopLoanRepaymentComponent(
            Loan, UnallocatedAccountNo, RepayAmount,
            LoanType."USSD Product Name" + ': Interest Repayment',
            TransactionType::"Interest Paid", RunBal, DimensionSetID);

        SaccoTrans.GetDefaultedAmount(
            Loan."Loan No.", Today, ExpectedAmount, AmountPaid, DefaultedAmount,
            DaysInArrear, ArrearsDate, true, GracePeriod);
        PrincipalAmount := DefaultedAmount -
            SaccoTrans.GetJournalLoanCredits(JTemplate, JBatch, AccountType::Credit, Loan."Loan Account", Loan."Loan No.", TransactionType::"Principal Repayment");
        if PrincipalAmount < 0 then
            PrincipalAmount := 0;
        if PrincipalAmount > Loan."Outstanding Principal" then
            PrincipalAmount := Loan."Outstanding Principal";
        ApplyCoopLoanRepaymentComponent(
            Loan, UnallocatedAccountNo, PrincipalAmount,
            LoanType."USSD Product Name" + ': Principal Repayment',
            TransactionType::"Principal Repayment", RunBal, DimensionSetID);

        // Recover the current-month deposit contribution before current loan dues.
        if RunBal > 0 then begin
            Savings.Reset();
            Savings.SetRange("Member No.", MemberNo);
            Savings.SetRange("Product Category", Savings."Product Category"::"Deposit Contribution");
            if Savings.FindFirst() then begin
                RepayAmount := Savings."Monthly Contribution";

                FosaAccount.Reset();
                FosaAccount.SetRange("No.", Savings."No.");
                FosaAccount.SetRange("Date Filter", CalcDate('<-CM>', PDate), CalcDate('<CM>', PDate));
                FosaAccount.SetAutoCalcFields("Balance (LCY)");
                FosaAccount.SetLoadFields("Balance (LCY)");
                if FosaAccount.FindFirst() and (FosaAccount."Balance (LCY)" > 0) then
                    RepayAmount -= FosaAccount."Balance (LCY)";

                ApplyCoopDepositContribution(
                    LoanNumber, UnallocatedAccountNo, Savings."No.",
                    RepayAmount, RunBal, DimensionSetID);
            end;
        end;

        // Current dues: penalty, insurance, interest, then scheduled principal.
        Loan.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty");

        RepayAmount := Loan."Outstanding Penalty" -
            SaccoTrans.GetJournalLoanCredits(JTemplate, JBatch, AccountType::Credit, Loan."Loan Account", Loan."Loan No.", TransactionType::"Penalty Paid");
        ApplyCoopLoanRepaymentComponent(
            Loan, UnallocatedAccountNo, RepayAmount,
            LoanType."USSD Product Name" + ': Penalty Repayment',
            TransactionType::"Penalty Paid", RunBal, DimensionSetID);

        RepayAmount := Loan."Outstanding Insurance" -
            SaccoTrans.GetJournalLoanCredits(JTemplate, JBatch, AccountType::Credit, Loan."Loan Account", Loan."Loan No.", TransactionType::"Insurance Paid");
        ApplyCoopLoanRepaymentComponent(
            Loan, UnallocatedAccountNo, RepayAmount,
            LoanType."USSD Product Name" + ': Insurance Repayment',
            TransactionType::"Insurance Paid", RunBal, DimensionSetID);

        RepayAmount := Loan."Outstanding Interest" -
            SaccoTrans.GetJournalLoanCredits(JTemplate, JBatch, AccountType::Credit, Loan."Loan Account", Loan."Loan No.", TransactionType::"Interest Paid");
        ApplyCoopLoanRepaymentComponent(
            Loan, UnallocatedAccountNo, RepayAmount,
            LoanType."USSD Product Name" + ': Interest Repayment',
            TransactionType::"Interest Paid", RunBal, DimensionSetID);

        if RunBal > 0 then begin
            LoanSchedule.Reset();
            LoanSchedule.SetRange("Loan No.", Loan."Loan No.");
            LoanSchedule.SetRange("Repayment Date", CalcDate('<-CM>', PDate), CalcDate('<CM>', PDate));
            if LoanSchedule.FindFirst() then begin
                ExpectedBalance := LoanSchedule."Loan Balance";
                PrincipalAmount := Loan."Outstanding Principal" - ExpectedBalance;
                if PrincipalAmount < 0 then
                    PrincipalAmount := 0;
            end else
                PrincipalAmount := Loan."Loan Principle Repayment";

            if PrincipalAmount > Loan."Outstanding Principal" then
                PrincipalAmount := Loan."Outstanding Principal";
            ApplyCoopLoanRepaymentComponent(
                Loan, UnallocatedAccountNo, PrincipalAmount,
                LoanType."USSD Product Name" + ': Loan Repayment',
                TransactionType::"Principal Repayment", RunBal, DimensionSetID);
        end;

        // Any balance still intended for this loan reduces its remaining principal.
        if RunBal > 0 then begin
            PrincipalAmount := Loan."Outstanding Principal" -
                SaccoTrans.GetJournalLoanCredits(JTemplate, JBatch, AccountType::Credit, Loan."Loan Account", Loan."Loan No.", TransactionType::"Principal Repayment");
            ApplyCoopLoanRepaymentComponent(
                Loan, UnallocatedAccountNo, PrincipalAmount,
                LoanType."USSD Product Name" + ': Loan Repayment',
                TransactionType::"Principal Repayment", RunBal, DimensionSetID);
        end;

        // Preserve the M-Pesa behavior for any excess after the stated loan is fully covered.
        if RunBal > 0 then
            SaccoTrans.GenerateMemberRepaymentJournals(
                JTemplate, JBatch, DocNo, ExtDoc, PDate,
                TransactionDescription, PDate,
                RunBal, MemberNo, LoanNumber, UnallocatedAccountNo,
                BalanceAccountType::Savings, DimensionSetID,
                TransactionChannel::"Coop P2F", true);
    end;

    local procedure ApplyCoopLoanRepaymentComponent(Loan: Record Loans; UnallocatedAccountNo: Code[20]; Amount: Decimal; Description: Text; ComponentTransactionType: Enum "Transaction Type Enum"; var RunBal: Decimal; DimensionSetID: Integer)
    var
        AccountType: Enum "Gen. Journal Account Type";
        BalanceAccountType: Enum "Gen. Journal Account Type";
        BlankTransactionType: Enum "Transaction Type Enum";
        TransactionChannel: Enum "Transaction Channel";
    begin
        if (Amount <= 0) or (RunBal <= 0) then
            exit;

        if Amount > RunBal then
            Amount := RunBal;

        SaccoTrans.JournalInsert(
            JTemplate, JBatch, DocNo, PDate,
            AccountType::Savings, UnallocatedAccountNo, CopyStr(Description, 1, 100),
            BalanceAccountType::"G/L Account", '', Amount,
            '', Loan."Loan No.", BlankTransactionType::" ",
            Dim1, Dim2, true, TransactionChannel::"Coop P2F", DimensionSetID);

        SaccoTrans.JournalInsert(
            JTemplate, JBatch, DocNo, PDate,
            AccountType::Credit, Loan."Loan Account", CopyStr(Description, 1, 100),
            BalanceAccountType::"G/L Account", '', -Amount,
            '', Loan."Loan No.", ComponentTransactionType,
            Dim1, Dim2, true, TransactionChannel::"Coop P2F", DimensionSetID);

        RunBal -= Amount;
    end;

    local procedure ApplyCoopDepositContribution(LoanNumber: Code[20]; UnallocatedAccountNo: Code[20]; DepositAccountNo: Code[20]; Amount: Decimal; var RunBal: Decimal; DimensionSetID: Integer)
    var
        AccountType: Enum "Gen. Journal Account Type";
        BalanceAccountType: Enum "Gen. Journal Account Type";
        TransactionType: Enum "Transaction Type Enum";
        TransactionChannel: Enum "Transaction Channel";
        Description: Text[100];
    begin
        if Amount < 0 then
            Amount := 0;
        if Amount > RunBal then
            Amount := RunBal;
        if Amount <= 0 then
            exit;

        Description := 'Deposit Contribution';
        SaccoTrans.JournalInsert(
            JTemplate, JBatch, DocNo, PDate,
            AccountType::Savings, UnallocatedAccountNo, Description,
            BalanceAccountType::"G/L Account", '', Amount,
            '', LoanNumber, TransactionType::" ",
            Dim1, Dim2, true, TransactionChannel::"Coop P2F", DimensionSetID);

        SaccoTrans.JournalInsert(
            JTemplate, JBatch, DocNo, PDate,
            AccountType::Savings, DepositAccountNo, Description,
            BalanceAccountType::"G/L Account", '', -Amount,
            '', LoanNumber, TransactionType::" ",
            Dim1, Dim2, true, TransactionChannel::"Coop P2F", DimensionSetID);

        RunBal -= Amount;
    end;

    /// <summary>
    /// PostTransaction function integrated from CoopB2B codeunit
    /// </summary>
    procedure PostTransaction(DocumentNo: Code[20])
    var
        CoopTrans: Record "Coop B2B Transactions";
        CreditAccount: Code[20];
        AcctNo: Code[20];
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Setup";
        BLedger: Record "Bank Account Ledger Entry";
        SMSMsg: Text;
        Phone: Code[20];
        DateStr: Text;
        Subject: Label 'B2B TRANSACTION: ';
        Salutation: Text;
        Body: Text;
        SAC: codeunit "Sacco Activities";
        Loans: Record Loans;
        SavAcc: Record "Savings Accounts";
        SkyMbanking: Codeunit "Sky MBanking";
        TChannel: Enum "Transaction Channel";
        DimID: Integer;
        Desc: Text[100];
        TargetAccountNo: Code[20];
        SavingsProductName: Text[100];
    begin
        CoopSetup.Get;
        // CoopSetup.testfield("Coop B2B Bank Account"); // Field may not exist in this setup

        BUser.Get(UserId);
        BUser.TestField("CashRec Journal Batch");
        BUser.TestField("CashRec Journal Template");

        JTemplate := BUser."CashRec Journal Template";
        JBatch := BUser."CashRec Journal Batch";

        CoopTrans.Reset;
        if DocumentNo <> '' then
            CoopTrans.SetRange("Transaction Reference Code", DocumentNo);
        CoopTrans.SetRange(Posted, false);
        if CoopTrans.FindFirst then begin
            repeat


                if CoopTrans."Sacco Reference" = '' then begin
                    SplitTransactionReference(CoopTrans."Transaction Reference Code", CoopTrans."Sacco Reference", DateStr);
                end;

                if CoopTrans."Sacco Reference" = '' then
                    CoopTrans."Sacco Reference" := CoopTrans."Transaction Reference Code";

                BLedger.Reset;
                BLedger.SetRange(Reversed, false);
                BLedger.SetRange("Document No.", CoopTrans."Sacco Reference");
                if BLedger.FindFirst then begin
                    CoopTrans.Posted := true;
                    CoopTrans.Modify;
                    exit;
                end;

                AcctNo := '';

                if Members.Get(CoopTrans."Account Number") then begin
                    ProductFactory.Reset;
                    ProductFactory.SetRange("B2B Code", CoopTrans."Institution Code"); // Field may not exist
                    if ProductFactory.FindFirst then begin
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange("Member No.", Members."No.");
                        SavingsAccounts.SetRange("Product Type", ProductFactory."Product ID");
                        if SavingsAccounts.FindFirst then begin
                            AcctNo := SavingsAccounts."No.";
                        end;
                    end;
                end;

                IF Loans.GET(CoopTrans."Account Number") THEN BEGIN
                    Members.Get(Loans."Member No.");
                    DocNo := CoopTrans."Sacco Reference";
                    PDate := CoopTrans."Transaction Date";
                    ExtDoc := AcctNo;
                    LoanNo := '';
                    Dim1 := Loans."Global Dimension 1 Code";
                    Dim2 := Loans."Booking Branch";
                    SystCreated := TRUE;

                    SaccoTrans.JournalInit(JTemplate, JBatch);

                    AccNo := CoopSetup."Coop B2B Bank Account";

                    if not FindMemberUnallocatedAccount(Loans."Member No.", SavingsAccounts) then
                        Error(
                            'Member %1 does not have an Unallocated Fund account. The Coop payment for loan %2 cannot be posted.',
                            Loans."Member No.",
                            Loans."Loan No.");
                    CreditAccount := SavingsAccounts."No.";

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, CreditAccount, CopyStr(CoopTrans.Description + ' - ' + AcctNo, 1, 100), Balacctype::"G/L Account",
                              '', -CoopTrans."Total Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop B2B", DimID);
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", CoopSetup."Coop B2B Bank Account", GetCoopBankPostingDescription(CoopTrans.Description, Members."No.", Members.Name), Balacctype::"G/L Account",
                              '', CoopTrans."Total Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop B2B", DimID);

                    LoanNo := Loans."Loan No.";
                    if LoanNo <> '' then begin
                        CreateCoopLoanRepaymentJournals(
                            CoopTrans."Total Amount",
                            CopyStr(CoopTrans.Description, 1, 100),
                            Members."No.",
                            LoanNo,
                            CreditAccount,
                            DimID);
                    end else
                        SaccoTrans.GenerateMemberRepaymentJournals(
                            JTemplate, JBatch, DocNo, ExtDoc, PDate,
                            CopyStr(CoopTrans.Description, 1, 100), PDate,
                            CoopTrans."Total Amount", Members."No.", LoanNo,
                            CreditAccount, BalAccType::Savings, DimID,
                            TChannel::"Coop P2F", true);

                    CoopTrans.Posted := true;
                    CoopTrans."Posted By" := UserId;
                    CoopTrans."Date Posted" := Today;
                    CoopTrans.Modify;

                    SaccoTrans.JournalPost(JTemplate, JBatch); // Journal posting

                    if Members.Get(SavingsAccounts."Member No.") then begin
                        Phone := Members."Mobile Phone No.";
                        SMSMsg := GetCoopReceiptSmsMessage(
                            Members.Name,
                            CoopTrans."Total Amount",
                            CoopTrans."Transaction Date",
                            Loans."Loan No.",
                            '',
                            true);
                        SendCoopReceiptSms(Phone, SMSMsg, DocNo, Loans."Loan No.");

                        if Members."E-Mail" <> '' then begin
                            Salutation := 'Dear ' + ' ' + Members.Name;
                            Body := 'A Transaction of KES ' + FORMAT(CoopTrans."Total Amount") +
                            ' done on ' + SkyMbanking.ddMMyyyy(CoopTrans."Transaction Date") + ' has been deposited into your account ' + CoopTrans."Account Number" + ' through Co-operative Bank. Ref ' + DocNo;
                            SAC.SendEmail(Members."E-Mail", '', '', Subject + UpperCase(COMPANYNAME), Salutation, Body);
                        end;
                    end;
                END;



                if (SavAcc.Get(CoopTrans."Account Number")) or (SavAcc.Get(AcctNo)) then begin
                    DocNo := CoopTrans."Sacco Reference";
                    PDate := CoopTrans."Transaction Date";
                    AcctNo := SavAcc."No.";
                    ExtDoc := AcctNo;
                    LoanNo := '';
                    TransType := Transtype::" ";
                    Dim1 := SavAcc."Global Dimension 1 Code";
                    Dim2 := SavAcc."Global Dimension 2 Code";
                    SystCreated := true;

                    SavAcc."Test Blocked" := SavAcc."Test Blocked"::" ";
                    if SavAcc.Blocked <> SavAcc.Blocked::" " then begin
                        SavAcc."Test Blocked" := SavAcc.Blocked;
                        SavAcc.Blocked := SavAcc.Blocked::" ";
                        SavAcc.Modify;
                    end;

                    SaccoTrans.JournalInit(JTemplate, JBatch);

                    Desc := Format(SavAcc."Product Category");

                    Clear(Members);
                    if SavAcc."Member No." <> '' then
                        if not Members.Get(SavAcc."Member No.") then
                            Clear(Members);

                    TargetAccountNo := AcctNo;
                    if SavAcc."Product Category" = SavAcc."Product Category"::"Unallocated Fund" then begin
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AcctNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                  '', -CoopTrans."Total Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop B2B", DimID);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", CoopSetup."Coop B2B Bank Account", GetCoopBankPostingDescription(CoopTrans.Description, Members."No.", Members.Name), Balacctype::"G/L Account",
                                  '', CoopTrans."Total Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop B2B", DimID);
                        SaccoTrans.GenerateMemberRepaymentJournals(JTemplate, JBatch, docNo, ExtDoc, pdate, CoopTrans.Description, pdate, CoopTrans."Total Amount", Members."No.", LoanNo, AcctNo, BalAccType::Savings, 0, TChannel::"Coop P2F", true);
                    end else begin
                        if not FindMemberUnallocatedAccount(SavAcc."Member No.", SavingsAccounts) then
                            Error('Member %1 does not have an Unallocated Fund account for Coop B2B distribution.', SavAcc."Member No.");

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, SavingsAccounts."No.", CopyStr(CoopTrans.Description + ' - ' + TargetAccountNo, 1, 100), Balacctype::"G/L Account",
                                  '', -CoopTrans."Total Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop B2B", DimID);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", CoopSetup."Coop B2B Bank Account", GetCoopBankPostingDescription(CoopTrans.Description, Members."No.", Members.Name), Balacctype::"G/L Account",
                                  '', CoopTrans."Total Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop B2B", DimID);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, SavingsAccounts."No.", CopyStr('Transfer to ' + TargetAccountNo, 1, 100), Balacctype::"G/L Account",
                                  '', CoopTrans."Total Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop B2B", DimID);
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, TargetAccountNo, CopyStr(Desc, 1, 100), Balacctype::"G/L Account",
                                  '', -CoopTrans."Total Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop B2B", DimID);
                    end;

                    CoopTrans.Posted := true;
                    CoopTrans."Posted By" := UserId;
                    CoopTrans."Date Posted" := Today;
                    CoopTrans.Modify;

                    SaccoTrans.JournalPost(JTemplate, JBatch); // Journal posting
                    if Members.Get(SavAcc."Member No.") then begin
                        Phone := Members."Mobile Phone No.";
                        SavingsProductName := GetSavingsProductName(SavAcc);
                        SMSMsg := GetCoopReceiptSmsMessage(
                            Members.Name,
                            CoopTrans."Total Amount",
                            CoopTrans."Transaction Date",
                            '',
                            SavingsProductName,
                            false
                            );
                        SendCoopReceiptSms(Phone, SMSMsg, DocNo, SavAcc."No.");

                        if Members."E-Mail" <> '' then begin
                            Salutation := 'Dear ' + ' ' + Members.Name;
                            Body := 'A Transaction of KES ' + FORMAT(CoopTrans."Total Amount") +
                            ' done on ' + SkyMbanking.ddMMyyyy(CoopTrans."Transaction Date") + ' has been deposited into your account ' + CoopTrans."Account Number" + ' through Co-operative Bank. Ref ' + DocNo;
                            SAC.SendEmail(Members."E-Mail", '', '', Subject + UpperCase(COMPANYNAME), Salutation, Body);
                        end;
                    end;

                    if SavAcc."Test Blocked" <> SavAcc."Test Blocked"::" " then begin
                        SavAcc.Blocked := SavAcc."Test Blocked";
                        SavAcc."Test Blocked" := SavAcc."Test Blocked"::" ";
                        SavAcc.Modify;
                    end;
                end;
            until CoopTrans.Next = 0;
        end;
    end;

    /// <summary>
    /// Pay2Fosa payment advise integrated from CoopB2B codeunit
    /// </summary>

    procedure ValidatePay2FosaPaymentAdvise(TransactionID: Text; ShowResp: Boolean) Response: Text
    var
        MemberNo: Text[30];
        AccBalance: Decimal;
        SavAccNo: Text[30];
        foundChargeAccount: Boolean;
        MNo: Code[20];
        AcctNo: Code[20];
        TotalCharge: Decimal;
        AccBal: Decimal;
        RespMessageID: Text;
        RespStatusCode: Text;
        RespStatusDescription: Text;
        RespTransactionDate: DateTime;
        RespTransactionReferenceCode: Text;
        RespInstitutionCode: Text;
        RespInstitutionName: Text;
        RespAccountNumber: Text;
        RespTotalAmount: Decimal;
        RespAdditionalInfo: Text;
        RespCurrency: Text;
        Status: Code[50];
        ResponseTitle: Text;
        ResponseMessage: Text;
        Indent: Boolean;
        MemberAccounts: Record "Savings Accounts";
        "Action": Code[50];
        RespAccountName: Text;
        CoopTrans: Record "Coop Pay2Fosa";
        Members: Record Members;
        Found: Boolean;
        Loans: Record Loans;
        AccErr: Text;
        SacooRef: Code[20];
        DateRef: Text;
        JsonResult: JsonObject;
        ArrayString: Text;
        SplitAccNo: Text;
        MemberAccount: Text;
        MemberAccountName: Text;
        Failed: label '400';
        Success: label '200';
        Pos: integer;
        InstCode: Text;
        AccountName: Text;
        InstitutionName: Text;

        Purpose: Option " ","Mid Salary","End Salary","Mid Pension","End Pension","Mid Allowance","End Allowance";
    begin
        RespMessageID := '';
        RespStatusCode := '';
        RespStatusDescription := '';
        Found := FALSE;


        // Check if transaction already exists
        CoopTrans.RESET;
        CoopTrans.SETRANGE("Transaction ID", TransactionID);
        CoopTrans.SetRange(Posted, false);
        IF CoopTrans.FINDFIRST THEN BEGIN

            // Extract account from CustMemoLine1
            SplitAccNo := GetP2FAccount(CoopTrans.CustomMemoLine1);
            if SPlitAccNo = '' then
                SplitAccNo := (CoopTrans.CustomMemoLine1);

            SplitAccNo := COPYSTR(SplitAccNo, 5, STRLEN(SplitAccNo));


            AccErr := '';
            Purpose := Purpose::" ";
            MemberAccount := '';
            AcctNo := GetMemberAccount(SplitAccNo, InstCode, AccountName, InstitutionName, AccErr, Purpose);

            if AcctNo <> '' then begin
                MemberAccount := AcctNo;
                MemberAccountName := AccountName;
                Found := TRUE;
            end;


            CoopTrans."Member Account No." := MemberAccount;
            CoopTrans."Split Account No." := SplitAccNo;
            CoopTrans.Purpose := Purpose;
            CoopTrans.Modify();

            if ShowResp then
                Message('Updated');
        END;


    end;

    local procedure Pay2FosaPaymentAdvise(AccountNo: Text; Amount: Decimal; BookedBalance: Decimal; ClearedBalance: Decimal; Currency: Text; CustMemoLine1: Text; CustMemoLine2: Text; CustMemoLine3: Text; EventType: Text; ExchangeRate: Text; Narration: Text; PaymentRef: Text; PostingDate: DateTime; ValueDate: DateTime; TransactionDate: DateTime; TransactionID: Text) Response: Text
    var
        MemberNo: Text[30];
        AccBalance: Decimal;
        SavAccNo: Text[30];
        foundChargeAccount: Boolean;
        MNo: Code[20];
        AcctNo: Code[20];
        TotalCharge: Decimal;
        AccBal: Decimal;
        RespMessageID: Text;
        RespStatusCode: Text;
        RespStatusDescription: Text;
        RespTransactionDate: DateTime;
        RespTransactionReferenceCode: Text;
        RespInstitutionCode: Text;
        RespInstitutionName: Text;
        RespAccountNumber: Text;
        RespTotalAmount: Decimal;
        RespAdditionalInfo: Text;
        RespCurrency: Text;
        Status: Code[50];
        ResponseTitle: Text;
        ResponseMessage: Text;
        Indent: Boolean;
        MemberAccounts: Record "Savings Accounts";
        "Action": Code[50];
        RespAccountName: Text;
        CoopTrans: Record "Coop Pay2Fosa";
        Members: Record Members;
        Found: Boolean;
        Loans: Record Loans;
        AccErr: Text;
        SacooRef: Code[20];
        DateRef: Text;
        JsonResult: JsonObject;
        ArrayString: Text;
        SplitAccNo: Text;
        MemberAccount: Text;
        MemberAccountName: Text;
        Failed: label '400';
        Success: label '200';
        Pos: integer;
        InstCode: Text;
        AccountName: Text;
        InstitutionName: Text;
        Purpose: Option " ","Mid Salary","End Salary","Mid Pension","End Pension","Mid Allowance","End Allowance";
    begin
        RespMessageID := '';
        RespStatusCode := '';
        RespStatusDescription := '';
        Found := FALSE;

        // Extract account from CustMemoLine1
        SplitAccNo := GetP2FAccount(CustMemoLine1);
        if SPlitAccNo = '' then
            SplitAccNo := (CustMemoLine1);

        SplitAccNo := COPYSTR(SplitAccNo, 5, STRLEN(SplitAccNo));


        AccErr := '';
        MemberAccount := '';
        Purpose := Purpose::" ";
        AcctNo := GetMemberAccount(SplitAccNo, InstCode, AccountName, InstitutionName, AccErr, Purpose);

        if AcctNo <> '' then begin
            MemberAccount := AcctNo;
            MemberAccountName := AccountName;
            Found := TRUE;
        end;

        MemberNo := '';
        AccErr := '';

        RespStatusCode := Success;
        RespStatusDescription := 'Member Validated Successfully';

        // Check if transaction already exists
        CoopTrans.RESET;
        CoopTrans.SETRANGE("Transaction ID", TransactionID);
        IF CoopTrans.FINDFIRST THEN BEGIN
            RespStatusCode := Success;
            RespStatusDescription := 'Transaction Already Exists';
        END
        ELSE BEGIN
            // Create new transaction record
            CoopTrans.INIT;
            CoopTrans."Institution A/C No" := AccountNo;
            CoopTrans.Amount := Amount;
            CoopTrans."Booked Balance" := BookedBalance;
            CoopTrans."Cleared Balance" := ClearedBalance;
            CoopTrans.Currency := Currency;
            CoopTrans.CustomMemoLine1 := CustMemoLine1;
            CoopTrans.CustomMemoLine2 := CustMemoLine2;
            CoopTrans.CustomMemoLine3 := CustMemoLine3;
            CoopTrans."Event Type" := EventType;
            CoopTrans."Exchange Rate" := ExchangeRate;
            CoopTrans.Narration := Narration;
            CoopTrans."Payment Ref" := PaymentRef;
            CoopTrans."Posting Date" := dt2date(PostingDate);
            CoopTrans."Value Date" := dt2date(ValueDate);
            CoopTrans."Transaction Date" := TransactionDate;
            CoopTrans."Transaction ID" := TransactionID;
            CoopTrans."Member Account No." := MemberAccount;
            CoopTrans."Split Account No." := SplitAccNo;
            CoopTrans.Purpose := Purpose;
            CoopTrans.INSERT;
            Commit();
            // Post transaction if member found
            IF Found THEN
                if CoopTrans.Purpose = CoopTrans.Purpose::" " then
                    PostP2FTransaction(TransactionID)
                else
                    PostP2FSalary(Purpose);

            RespStatusCode := Success;
            RespStatusDescription := 'Payment successfully received';
        END;


        // Build JSON response
        JsonResult.Add('MessageCode', RespStatusCode);
        JsonResult.Add('Message', RespStatusDescription);

        JsonResult.WriteTo(Response);
        exit(Response);
    end;

    /// <summary>
    /// Extract P2F account from memo line - integrated from CoopB2B
    /// </summary>
    local procedure GetP2FAccount(CustMemoLine: Text) Result: Text
    var
        Pos: Integer;
        P2FCode: label '9094';
    begin

        Result := CustMemoLine;
        pos := strpos(CustMemoLine, ' ');
        //919100010701 CHIME INC SF58GQ3I1E~~919100010701~MPESAC2B_400200~CHIME IN	
        //Message('Pos: %1', pos);
        if pos > 4 then begin
            Result := copystr(CustMemoLine, 1, pos - 1);
        end
        else begin
            pos := strpos(CustMemoLine, '~');
            if pos > 1 then
                if StrLen(CustMemoLine) > 4 then
                    Result := copystr(CustMemoLine, 1, pos - 1);
        end;

        Exit(Result);


    end;

    /// <summary>
    /// Post P2F transaction - integrated from CoopB2B
    /// </summary>

    procedure PostP2FTransaction(DocumentNo: Code[20])
    var
        CoopTrans: Record "Coop Pay2Fosa";
        AcctNo: Code[20];
        Members: Record Members;
        Loans: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        SavAcc: Record "Savings Accounts";
        ProductFactory: Record "Product Setup";
        BLedger: Record "Bank Account Ledger Entry";
        SMSMsg: Text;
        Phone: Code[20];
        DateStr: Text;
        No: Code[20];
        Desc: Text[100];
        SAC: Codeunit "Sacco Activities";
        Subject: Label 'P2F TRANSACTION: ';
        Salutation: Text;
        Body: Text;
        RunBal: Decimal;
        DedAmt: Decimal;
        Bank: Record "Bank Account";
        LoanNumber: Code[20];
        TChannel: Enum "Transaction Channel";
        DimID: Integer;
        Distribute: Boolean;
        MemberNo: Code[20];
        TargetAccountNo: Code[20];
        LoanFound: Boolean;

    begin

        CoopSetup.GET;


        CoopSetup.testfield("Coop P2F Bank Account");

        BUser.GET(USERID);

        BUser.Get(UserId);

        BUser.TestField("CashRec Journal Batch");
        BUser.TestField("CashRec Journal Template");

        JTemplate := BUser."CashRec Journal Template";
        JBatch := BUser."CashRec Journal Batch";



        CoopTrans.RESET;
        IF DocumentNo <> '' THEN
            CoopTrans.SETRANGE("Transaction ID", DocumentNo);
        CoopTrans.SETRANGE(Posted, FALSE);
        CoopTrans.SetRange(Purpose, CoopTrans.Purpose::" ");
        IF CoopTrans.FINDFIRST THEN BEGIN
            REPEAT

                Distribute := false;
                if not SavAcc.get(CoopTrans."Split Account No.") then
                    if not Loans.get(CoopTrans."Split Account No.") then
                        Distribute := true;

                BLedger.RESET;
                BLedger.SetRange(Reversed, false);
                BLedger.SETRANGE("Document No.", DocumentNo);
                IF BLedger.FINDFIRST THEN BEGIN
                    CoopTrans.Posted := TRUE;
                    //CoopTrans.Remark := 'Already Posted';
                    CoopTrans.MODIFY;
                    EXIT;
                END;






                SaccoTrans.JournalInit(JTemplate, JBatch);

                if CoopTrans."Event Type" = 'DEBIT' then begin

                    Bank.reset;
                    Bank.SetRange("Bank Account No.", CoopTrans.CustomMemoLine1);

                    IF Bank.FindFirst() THEN BEGIN




                        DocNo := CoopTrans."Transaction ID";
                        //PDate := TODAY;

                        PDate := DT2Date(CoopTrans."Transaction Date");
                        AcctNo := Bank."No.";
                        ExtDoc := CoopTrans.CustomMemoLine1;
                        LoanNo := '';
                        TransType := TransType::" ";
                        Dim1 := Bank."Global Dimension 1 Code";
                        Dim2 := Bank."Global Dimension 2 Code";
                        SystCreated := TRUE;


                        //MESSAGE('AcctNo %1\Coop Bank %2',AcctNo,CoopSetup."Coop B2B Bank Account");


                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::"Bank Account", AcctNo, COPYSTR(CoopTrans.Narration + ' - ' + AcctNo, 1, 50), BalAccType::"Bank Account",
                                  CoopSetup."Coop P2F Bank Account", CoopTrans."Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop P2F", DimID);


                        CoopTrans.Posted := TRUE;
                        CoopTrans."Posted By" := USERID;
                        CoopTrans."Date Posted" := TODAY;
                        CoopTrans.MODIFY;

                        SaccoTrans.JournalPost(JTemplate, JBatch);


                    END;
                end
                else
                    if CoopTrans."Event Type" = 'CREDIT' then begin


                        IF (SavAcc.GET(CoopTrans."Member Account No.")) THEN BEGIN


                            Members.Get(SavAcc."Member No.");


                            DocNo := CoopTrans."Transaction ID";
                            //PDate := TODAY;

                            PDate := DT2Date(CoopTrans."Transaction Date");
                            AcctNo := SavAcc."No.";
                            ExtDoc := AcctNo;
                            LoanNo := '';
                            TransType := TransType::" ";
                            Dim1 := SavAcc."Global Dimension 1 Code";
                            Dim2 := SavAcc."Global Dimension 2 Code";
                            SystCreated := TRUE;

                            SavAcc."Test Blocked" := SavAcc."Test Blocked"::" ";
                            IF SavAcc.Blocked <> SavAcc.Blocked::" " THEN BEGIN
                                SavAcc."Test Blocked" := SavAcc.Blocked;
                                SavAcc.Blocked := SavAcc.Blocked::" ";
                                SavAcc.MODIFY;
                            END;
                            Desc := COPYSTR(CoopTrans.Narration + ' - ' + AcctNo, 1, 100);
                            if SavAcc."Product Category" = SavAcc."Product Category"::"Unallocated Fund" then
                                Distribute := true
                            else
                                Desc := Format(SavAcc."Product Category");

                            //MESSAGE('AcctNo %1\Coop Bank %2',AcctNo,CoopSetup."Coop B2B Bank Account");

                            TargetAccountNo := AcctNo;
                            if Distribute then begin
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, AcctNo, Desc, BalAccType::"G/L Account",
                                      '', -CoopTrans."Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop P2F", DimID);
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::"Bank Account", CoopSetup."Coop P2F Bank Account", GetCoopBankPostingDescription(CoopTrans.Narration, Members."No.", Members.Name), BalAccType::"G/L Account",
                                      '', CoopTrans."Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop P2F", DimID);

                                if Distribute then
                                    SaccoTrans.GenerateMemberRepaymentJournals(JTemplate, JBatch, docNo, ExtDoc, pdate, CoopTrans.Narration, pdate, CoopTrans.Amount, Members."No.", LoanNo, AcctNo, BalAccType::Savings, 0, TChannel::"Coop P2F", true);

                            end else begin
                                if not FindMemberUnallocatedAccount(SavAcc."Member No.", SavingsAccounts) then
                                    Error('Member %1 does not have an Unallocated Fund account for Coop P2F distribution.', SavAcc."Member No.");

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, SavingsAccounts."No.", COPYSTR(CoopTrans.Narration + ' - ' + TargetAccountNo, 1, 100), BalAccType::"G/L Account",
                                      '', -CoopTrans."Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop P2F", DimID);
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::"Bank Account", CoopSetup."Coop P2F Bank Account", GetCoopBankPostingDescription(CoopTrans.Narration, Members."No.", Members.Name), BalAccType::"G/L Account",
                                      '', CoopTrans."Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop P2F", DimID);
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, SavingsAccounts."No.", CopyStr('Transfer to ' + TargetAccountNo, 1, 100), BalAccType::"G/L Account",
                                      '', CoopTrans."Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop P2F", DimID);
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, TargetAccountNo, Desc, BalAccType::"G/L Account",
                                      '', -CoopTrans."Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop P2F", DimID);
                            end;

                            CoopTrans.Posted := TRUE;
                            CoopTrans."Posted By" := USERID;
                            CoopTrans."Date Posted" := TODAY;
                            CoopTrans.MODIFY;

                            //Error('Test');
                            SaccoTrans.JournalPost(JTemplate, JBatch);

                            Phone := Members."Mobile Phone No.";
                            SMSMsg := 'Dear ' + SkyMbanking.FirstName(Members.Name) + ', A Transaction of KES ' + FORMAT(CoopTrans."Amount") +
                            ' done on ' + SkyMbanking.ddMMyyyy(DT2Date(CoopTrans."Transaction Date")) + ' (' + CoopTrans.narration + ') has been deposited into your account ' + CoopTrans."Member Account No." + ' through Co-operative Bank. Ref ' + DocNo;
                            SkyMbanking.SendSms(Source::Coop, Phone, SMSMsg, DocNo, '', false, 205, false);


                            if Members."E-Mail" <> '' then begin

                                Salutation := 'Dear ' + ' ' + Members.Name;

                                Body := 'A Transaction of KES ' + FORMAT(CoopTrans."Amount") +
                                ' done on ' + SkyMbanking.ddMMyyyy(DT2Date(CoopTrans."Transaction Date")) + ' (' + CoopTrans.narration + ') has been deposited into your account ' + CoopTrans."Member Account No." + ' through Co-operative Bank. Ref ' + DocNo;
                                SAC.SendEmail(Members."E-Mail", '', '', Subject + UpperCase(COMPANYNAME), Salutation, Body);
                            end;


                            IF SavAcc."Test Blocked" <> SavAcc."Test Blocked"::" " THEN BEGIN
                                SavAcc.Blocked := SavAcc."Test Blocked";
                                SavAcc."Test Blocked" := SavAcc."Test Blocked"::" ";
                                SavAcc.MODIFY;
                            END;
                        END
                        else begin

                            Clear(Loans);
                            Clear(Members);
                            Clear(LoanNumber);
                            Clear(MemberNo);
                            LoanFound := false;

                            if CoopTrans."Member Account No." <> '' then begin
                                if Loans.Get(CoopTrans."Member Account No.") then
                                    LoanFound := true
                                else begin
                                    Loans.Reset();
                                    Loans.SetRange("Loan Account", CoopTrans."Member Account No.");
                                    Loans.SetFilter("Outstanding Principal", '>0');
                                    LoanFound := Loans.FindFirst();
                                end;

                                if LoanFound then begin
                                    LoanNumber := Loans."Loan No.";
                                    MemberNo := Loans."Member No.";
                                end else
                                    if Members.Get(CoopTrans."Member Account No.") then
                                        MemberNo := Members."No.";
                            end;

                            if MemberNo = '' then
                                Error(
                                    'P2F account %1 could not be resolved to a member or an active loan.',
                                    CoopTrans."Member Account No.");

                            Members.Get(MemberNo);

                            DocNo := CoopTrans."Transaction ID";
                            //PDate := TODAY;
                            PDate := DT2Date(CoopTrans."Transaction Date");
                            TransType := TransType::" ";
                            SystCreated := TRUE;

                            if LoanFound then begin
                                ExtDoc := Loans."Member No.";
                                LoanNo := Loans."Loan No.";
                                Dim1 := Loans."Global Dimension 1 Code";
                                Dim2 := Loans."Booking Branch";
                            end else begin
                                ExtDoc := Members."No.";
                                LoanNo := '';
                                Dim1 := Members."Global Dimension 1 Code";
                                Dim2 := Members."Global Dimension 2 Code";
                            end;

                            if not FindMemberUnallocatedAccount(MemberNo, SavAcc) then
                                Error(
                                    'Member %1 does not have an Unallocated Fund account for Coop P2F distribution.',
                                    MemberNo);

                            AcctNo := SavAcc."No.";
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, AcctNo, COPYSTR(CoopTrans.Narration + ' - ' + CoopTrans."Member Account No.", 1, 100), BalAccType::"G/L Account",
                                  '', -CoopTrans."Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop P2F", DimID);
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::"Bank Account", CoopSetup."Coop P2F Bank Account", GetCoopBankPostingDescription(CoopTrans.Narration, SavAcc."Member No.", SavAcc.Name), BalAccType::"G/L Account",
                                  '', CoopTrans."Amount", ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel::"Coop P2F", DimID);

                            if LoanNo <> '' then begin
                                CreateCoopLoanRepaymentJournals(
                                    CoopTrans.Amount,
                                    CopyStr(CoopTrans.Narration, 1, 100),
                                    Members."No.",
                                    LoanNo,
                                    SavAcc."No.",
                                    DimID);
                            end else
                                SaccoTrans.GenerateMemberRepaymentJournals(JTemplate, JBatch, docNo, ExtDoc, pdate, CoopTrans.Narration, pdate, CoopTrans.Amount, Members."No.", LoanNumber, AcctNo, BalAccType::Savings, 0, TChannel::"Coop P2F", true);

                            CoopTrans.Posted := TRUE;
                            CoopTrans."Posted By" := USERID;
                            CoopTrans."Date Posted" := TODAY;
                            CoopTrans.MODIFY;

                            SaccoTrans.JournalPost(JTemplate, JBatch);

                            Phone := Members."Mobile Phone No.";
                            SMSMsg := 'Dear ' + SkyMbanking.FirstName(Members.Name) + ', A Transaction of KES ' + FORMAT(CoopTrans."Amount") +
                            ' done on ' + SkyMbanking.ddMMyyyy(DT2Date(CoopTrans."Transaction Date")) + ' (' + CoopTrans.narration + ') has been deposited into your account ' + CoopTrans."Member Account No." + ' through Co-operative Bank. Ref ' + DocNo;
                            SkyMbanking.SendSms(Source::Coop, Phone, SMSMsg, DocNo, '', false, 205, false);


                            if Members."E-Mail" <> '' then begin

                                Salutation := 'Dear ' + ' ' + Members.Name;

                                Body := 'A Transaction of KES ' + FORMAT(CoopTrans."Amount") +
                                ' done on ' + SkyMbanking.ddMMyyyy(DT2Date(CoopTrans."Transaction Date")) + ' (' + CoopTrans.narration + ') has been deposited into your account ' + CoopTrans."Member Account No." + ' through Co-operative Bank. Ref ' + DocNo;
                                SAC.SendEmail(Members."E-Mail", '', '', Subject + UpperCase(COMPANYNAME), Salutation, Body);
                            end;


                        end;
                    end
            UNTIL CoopTrans.NEXT = 0;
        end;
    end;


    procedure PostP2FSalary(Purpose: Option " ","Mid Salary","End Salary","Mid Pension","End Pension","Mid Allowance","End Allowance")
    var
        CoopTrans: Record "Coop Pay2Fosa";
        LineNo: Integer;
        AcctNo: Code[20];
        Members: Record Members;
        SaccoSetup: record "Sacco Setup";
        Loans: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        SavAcc: Record "Savings Accounts";
        ProductFactory: Record "Product Setup";
        BLedger: Record "Bank Account Ledger Entry";
        SMSMsg: Text;
        Phone: Code[20];
        DateStr: Text;
        No: Code[20];

        SAC: Codeunit "Sacco Activities";
        Subject: Label 'P2F TRANSACTION: ';
        Salutation: Text;
        Body: Text;
        RunBal: Decimal;
        DedAmt: Decimal;
        Bank: Record "Bank Account";
        LoanNumber: Code[20];
        SalHeader: Record "Salary Header";
        SalLines: Record "Salary Lines";
        UserSetup: Record "User Setup";
        SaccoT: Codeunit "Sacco Activities";

    begin

        CoopSetup.GET;


        CoopSetup.testfield("Coop P2F Bank Account");

        BUser.GET(USERID);

        BUser.Get(UserId);

        BUser.TestField("CashRec Journal Batch");
        BUser.TestField("CashRec Journal Template");

        JTemplate := BUser."CashRec Journal Template";
        JBatch := BUser."CashRec Journal Batch";


        CoopTrans.RESET;
        CoopTrans.SETRANGE(Posted, FALSE);
        CoopTrans.SETRANGE(Purpose, Purpose);
        CoopTrans.SetRange("Salary Header", '');
        IF CoopTrans.FINDFIRST THEN BEGIN
            if CoopTrans.Count > 1 then begin

                SalHeader.Init();
                SalHeader.No := '';
                SalHeader.P2F := true;
                SalHeader.Insert(true);
                SalHeader.validate("Global Dimension 2 Code", 'MOMBASA');
                SalHeader.validate("Destination Transaction Type", 'SAL_PRO');
                SalHeader."Process Type" := SalHeader."Process Type"::"General Process";
                SalHeader."Account Type" := SalHeader."Account Type"::"Bank Account";
                SalHeader.validate("Account No", CoopSetup."Coop P2F Bank Account");
                SalHeader.validate("Posting date", Today);
                SalHeader."Batch Entries" := 1;
                if CoopTrans.Purpose = CoopTrans.Purpose::"Mid Salary" then begin
                    SalHeader.validate(Period, SalHeader.Period::"Mid Month");
                    SalHeader.validate("Income Type", SalHeader."Income Type"::Salary);

                end;
                if CoopTrans.Purpose = CoopTrans.Purpose::"End Salary" then begin


                    if Date2DMY(DT2Date(CoopTrans."Transaction Date"), 1) <= 10 then
                        SalHeader.validate(Period, SalHeader.Period::"After Month")
                    else
                        SalHeader.validate(Period, SalHeader.Period::"End Month");
                    SalHeader.validate("Income Type", SalHeader."Income Type"::Salary);

                end;
                if CoopTrans.Purpose = CoopTrans.Purpose::"Mid Pension" then begin
                    SalHeader.validate(Period, SalHeader.Period::"Mid Month");
                    SalHeader.validate("Income Type", SalHeader."Income Type"::Pension);
                end;
                if CoopTrans.Purpose = CoopTrans.Purpose::"End Pension" then begin

                    if Date2DMY(DT2Date(CoopTrans."Transaction Date"), 1) <= 10 then
                        SalHeader.validate(Period, SalHeader.Period::"After Month")
                    else
                        SalHeader.validate(Period, SalHeader.Period::"End Month");
                    SalHeader.validate("Income Type", SalHeader."Income Type"::Pension);
                end;

                if CoopTrans.Purpose = CoopTrans.Purpose::"Mid Allowance" then begin
                    SalHeader.validate(Period, SalHeader.Period::Allowance);
                    SalHeader.validate("Income Type", SalHeader."Income Type"::Allowance);
                end;
                if CoopTrans.Purpose = CoopTrans.Purpose::"End Allowance" then begin
                    SalHeader.validate(Period, SalHeader.Period::Allowance);
                    SalHeader.validate("Income Type", SalHeader."Income Type"::Allowance);
                end;
                LineNo := 0;

                SalHeader.Remarks := Format(SalHeader."Income Type");



                SalHeader.Modify();

                REPEAT


                    if CoopTrans."Event Type" = 'CREDIT' then begin

                        IF (SavAcc.GET(CoopTrans."Member Account No.")) THEN BEGIN

                            if Members.Get(SavAcc."Member No.") then begin
                                SalLines.Reset();
                                SalLines.SetRange("Salary Header No.", SalHeader.NO);
                                SalLines.SetRange("Account No.", SavAcc."No.");
                                IF NOT SalLines.FindFirst() then begin
                                    LineNo += 1;

                                    SalLines.init;
                                    SalLines."Salary Header No." := SalHeader.no;
                                    SalLines."No." := LineNo;
                                    SalLines.P2F := true;
                                    SalLines.Validate("Account No.", SavAcc."no.");
                                    SalLines.Validate("Account Name", SavAcc.Name);
                                    SalLines.Validate("Name", SavAcc.Name);
                                    SalLines.Validate("Staff No.", SavAcc."Payroll/Staff No.");
                                    SalLines.Validate(Amount, CoopTrans.Amount);
                                    SalLines.Validate("Employer Code", SavAcc."Employer Code");
                                    SalLines.Validate("Member No.", SavAcc."Member No.");

                                    SalLines."Account Not Found" := false;
                                    SalLines."ID No." := Members."ID No.";
                                    SalLines."Account No." := SavAcc."No.";
                                    SalLines.Status := SavAcc.Status;
                                    SalLines."Reference No." := CoopTrans."Transaction ID";

                                    if SavAcc.Blocked <> SavAcc.Blocked::" " then
                                        SalLines."Blocked Accounts" := true
                                    else
                                        SalLines."Blocked Accounts" := false;


                                    SalLines."Employer Code" := Members."Employer Code";

                                    if SalHeader."Process Type" = SalHeader."process type"::"General Process" then begin
                                        if SavAcc."Global Dimension 1 Code" <> '' then
                                            SalLines."Global Dimension 1 Code" := SavAcc."Global Dimension 1 Code"
                                        else
                                            SalLines."Global Dimension 1 Code" := Members."Global Dimension 1 Code";

                                        if SavAcc."Global Dimension 2 Code" <> '' then
                                            SalLines."Global Dimension 2 Code" := SavAcc."Global Dimension 2 Code"
                                        else
                                            SalLines."Global Dimension 2 Code" := Members."Global Dimension 2 Code";
                                    end
                                    else
                                        if SalHeader."Process Type" = SalHeader."process type"::"Branch Process" then begin
                                            UserSetup.Get(UserId);
                                            SalLines."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                                        end
                                        else
                                            Error('Process Type Must Have a Value');

                                    SalLines.Insert();

                                end;

                            end;

                            CoopTrans."Salary Header" := SalHeader.No;
                            CoopTrans.Modify();
                        end;
                    end
                UNTIL CoopTrans.NEXT = 0;





                SaccoSetup.get;
                SalHeader.TestField("Destination Transaction Type");
                if SalHeader."Process Type" = SalHeader."process type"::" " then
                    Error('Process Type Must have a value');



                SalHeader.CalcFields("Scheduled Amount");
                SalHeader."Document No" := SalHeader.No;

                SalHeader.Amount := SalHeader."Scheduled Amount";

                SalHeader."Posting date" := Today;


                SalHeader.Status := SalHeader.Status::Approved;
                SalHeader.Modify();

                SalHeader.CalcFields("Posted Entries");
                if SalHeader."Posted Entries" = 0 then
                    SaccoT.BatchSalary(SalHeader, false);
                SalHeader.Modify();
                Commit();

                if SalHeader.Period = SalHeader.Period::"End Month" then
                    SaccoT.UpdateLoanSchedules(SalHeader);


                SalLines.Reset;
                SalLines.SetRange(SalLines."Salary Header No.", SalHeader.No);
                SalLines.SetRange(Posted, false);
                if SalLines.Find('-') then begin
                    repeat
                        SaccoT.GenerateP2FSalaryDeductions(SalHeader, SalLines."Member No.");
                    until SalLines.Next() = 0;
                end;

                SaccoT.GenerateSalaryPostingBuffer(SalHeader);
                SaccoT.PostSalaryBuffer(SalHeader, true);

            end;
        END;


    end;



    procedure CommitP2FSalary()
    var
        CoopTrans: Record "Coop Pay2Fosa";
        LineNo: Integer;
        AcctNo: Code[20];
        Members: Record Members;
        SaccoSetup: record "Sacco Setup";
        Loans: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        SavAcc: Record "Savings Accounts";
        ProductFactory: Record "Product Setup";
        BLedger: Record "Bank Account Ledger Entry";
        SMSMsg: Text;
        Phone: Code[20];
        DateStr: Text;
        No: Code[20];

        SAC: Codeunit "Sacco Activities";
        Subject: Label 'P2F TRANSACTION: ';
        Salutation: Text;
        Body: Text;
        RunBal: Decimal;
        DedAmt: Decimal;
        Bank: Record "Bank Account";
        LoanNumber: Code[20];
        SalHeader: Record "Salary Header";
        SalLines: Record "Salary Lines";
        UserSetup: Record "User Setup";
        SaccoT: Codeunit "Sacco Activities";

    begin

        CoopTrans.RESET;
        CoopTrans.SETRANGE(Posted, FALSE);
        CoopTrans.SETFILTER("Salary Header", '<>%1', '');
        IF CoopTrans.FINDFIRST THEN BEGIN
            REPEAT
                if SalHeader.GET(CoopTrans."Salary Header") then begin
                    SalLines.Reset();
                    SalLines.SetRange("Salary Header No.", SalHeader.No);
                    SalLines.SetRange("Account No.", CoopTrans."Member Account No.");
                    SalLines.SetRange(Posted, true);
                    if SalLines.FINDFIRST then begin
                        if SalLines."Reference No." = CoopTrans."Transaction ID" then begin
                            if SalLines.Amount = SalLines.Amount then begin
                                CoopTrans.Posted := true;
                                CoopTrans.Modify();
                            end;
                        end;
                    end;

                end;
            UNTIL CoopTrans.NEXT = 0;
        END;


        CoopTrans.RESET;
        CoopTrans.SETRANGE(Posted, FALSE);
        CoopTrans.SETFILTER("Salary Header", '<>%1', '');
        IF CoopTrans.FINDFIRST THEN BEGIN
            REPEAT
                SalHeader.GET(CoopTrans."Salary Header");

                SalHeader.CalcFields("Posted Entries");
                if SalHeader."Posted Entries" = 0 then
                    SaccoT.BatchSalary(SalHeader, false);
                SalHeader.Modify();
                Commit();

                if SalHeader.Period = SalHeader.Period::"End Month" then
                    SaccoT.UpdateLoanSchedules(SalHeader);


                SalLines.Reset;
                SalLines.SetRange(SalLines."Salary Header No.", SalHeader.No);
                SalLines.SetRange(Posted, false);
                if SalLines.Find('-') then begin
                    repeat
                        SaccoT.GenerateSalaryDeductions(SalHeader);
                    until SalLines.Next() = 0;
                end;

                SaccoT.GenerateSalaryPostingBuffer(SalHeader);
                SaccoT.PostSalaryBuffer(SalHeader, true);

            UNTIL CoopTrans.NEXT = 0;
        END;




    end;


    local procedure GetAccountFromKeyWord(SearchAccount: Text[200]; var AccountNo: Text[20]; var Purpose: Option " ","Mid Salary","End Salary","Mid Pension","End Pension","Mid Allowance","End Allowance")
    var
        Keyword: Record "P2F Keywords";
        KeyW: Text;
    begin
        AccountNo := '';
        Purpose := Purpose::" ";


        // Check deposit keywords
        Keyword.Reset;
        if Keyword.FindSet() then begin
            repeat begin

                if SearchAccount.EndsWith(Keyword.Keyword) then begin
                    if StrLen(SearchAccount) - StrLen(Keyword.Keyword) >= 0 then begin
                        AccountNo := CopyStr(SearchAccount, 1, StrLen(SearchAccount) - StrLen(Keyword.Keyword));
                        Purpose := Keyword.Purpose;
                        Exit;
                    end;
                end;

            end until (AccountNo <> '') or (Keyword.Next() = 0);
        end;

    end;
}
