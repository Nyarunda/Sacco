codeunit 50136 "Sky Mobile Banking Integration"
{
    trigger OnRun()
    var
        // Preferences: Explicit Type Hints
        TestRawJson: Text;
        RequestJson: JsonObject;
        RequestPayloadToken: JsonToken;
        RequestPayloadObj: JsonObject;
        RequestAPIIdText: Text;
        RequestAPIIdToken: JsonToken;
        Response: Text;
        JValue: JsonValue;
    begin
        // 1. Setup the Test Data
        //TestRawJson := '{"action": "GET_LOAN_TYPES", "api_request_id": "df3e7cf5-1e4b-41ef-a22f-e755be665432", "payload": {"identifier_type": "MSISDN", "identifier": "254113877811"}}';
        TestRawJson := '{"action":"ACCOUNT_FULL_STATEMENT","api_request_id":"df3e7cf5-1e4b-41ef-a22f-e755be665432","payload":{"identifier_type":"CUSTOMER_NO","identifier":"009932","account_number":"S06-009932","start_date":"2025-01-01","end_date":"2026-04-22"}}';
        if not RequestJson.ReadFrom(TestRawJson) then
            Error('Invalid JSON');

        // 2. Handle Argument 1: Convert Payload Token to Object
        if RequestJson.Get('payload', RequestPayloadToken) then
            RequestPayloadObj := RequestPayloadToken.AsObject()
        else
            Error('Payload not found');

        // 3. Handle Argument 2: Convert API ID Text to JsonToken
        // First, get the text
        RequestAPIIdText := GetJsonValue(RequestJson, 'api_request_id');
        // Then, wrap it in a JsonValue/Token
        JValue.SetValue(RequestAPIIdText);
        RequestAPIIdToken := JValue.AsToken();

        // 4. THE CALL: Now Argument 1 is JsonObject and Argument 2 is JsonToken
        // Set your breakpoint (F9) here
        Response := AccountFullStatement(RequestPayloadObj, RequestAPIIdToken);

        Message('Debug Result: %1', Response);
    end;

    local procedure GetJsonValue(Container: JsonObject; KeyName: Text): Text
    var
        Token: JsonToken;
    begin
        if Container.Get(KeyName, Token) then
            exit(Token.AsValue().AsText());
    end;

    procedure HandleRequest(Request: Text): Text
    var
        RequestParser: JsonObject;
        RequestAction: JsonToken;
        RequestAPIId: JsonToken;
        RequestPayload: JsonToken;
    begin
        RequestParser.ReadFrom(Request);
        RequestParser.SelectToken('$.action', RequestAction);
        RequestParser.SelectToken('$.api_request_id', RequestAPIId);
        RequestParser.SelectToken('$.payload', RequestPayload);

        // API actions here
        case RequestAction.AsValue().AsText() of
            'CALL_SERVICE':
                exit(CallServiceFunction(RequestPayload.AsObject));
            'CALL_SERVICE_JOB_QUEUE':
                exit(CallServiceFunctionJobQueue(RequestPayload.AsObject));
            // 1. Dashboard & Core Accounts
            'GET_MEMBER_DETAILS':
                exit(GetMemberDetails(RequestPayload.AsObject, RequestAPIId));
            'GET_DEPOSIT_ACCOUNTS':
                exit(GetDepositAccounts(RequestPayload.AsObject, RequestAPIId));
            'VALIDATE_ACCOUNT':
                exit(ValidateAccount(RequestPayload.AsObject, RequestAPIId));
            'BALANCE_ENQUIRY':
                exit(BalanceEnquiry(RequestPayload.AsObject, RequestAPIId));

            'ACCOUNT_MINI_STATEMENT':
                exit(AccountMiniStatement(RequestPayload.AsObject, RequestAPIId));
            'ACCOUNT_FULL_STATEMENT':
                exit(AccountFullStatement(RequestPayload.AsObject, RequestAPIId));
            'ACCOUNT_FULL_STATEMENT_BASE64':
                exit(AccountFullStatementPDF(RequestPayload.AsObject, RequestAPIId));
            'WITHDRAWAL':
                exit(Withdrawal(RequestPayload.AsObject, RequestAPIId));
            'WITHDRAWAL_RESULT':
                exit(WithdrawalResult(RequestPayload.AsObject, RequestAPIId));
            'IFT_ACCOUNT_TO_ACCOUNT':
                exit(IFTAccountToAccount(RequestPayload.AsObject, RequestAPIId));
            'IFT_LOAN_REPAYMENT':
                exit(IFTLoanRepayment(RequestPayload.AsObject, RequestAPIId));
            'INTERNAL_FUNDS_TRANSFER':
                exit(InternalFundsTransfer(RequestPayload.AsObject, RequestAPIId));
            'DEPOSIT':
                exit(Deposit(RequestPayload.AsObject, RequestAPIId));
            'GET_LOAN_TYPES':
                exit(GetLoanTypes(RequestPayload.AsObject, RequestAPIId));
            'GET_LOAN_DETAILS':
                exit(GetLoanDetails(RequestPayload.AsObject(), RequestAPIId));
            'GET_LOAN_PURPOSES':
                exit(GetLoanPurposes(RequestPayload.AsObject, RequestAPIId));
            'CHECK_LOAN_LIMIT':
                exit(CheckLoanLimit(RequestPayload.AsObject, RequestAPIId));
            'LOAN_APPLICATION':
                exit(LoanApplication(RequestPayload.AsObject, RequestAPIId));
            'GET_LOANS_IN_SERVICE':
                exit(GetLoansInService(RequestPayload.AsObject, RequestAPIId));
            'LOAN_BALANCE_ENQUIRY':
                exit(LoanBalanceEnquiry(RequestPayload.AsObject, RequestAPIId));
            'LOAN_MINI_STATEMENT':
                exit(LoanMiniStatement(RequestPayload.AsObject, RequestAPIId));
            'LOAN_FULL_STATEMENT':
                exit(LoanFullStatement(RequestPayload.AsObject, RequestAPIId));
            'LOAN_FULL_STATEMENT_BASE64':
                exit(LoanFullStatementPDF(RequestPayload.AsObject, RequestAPIId));
            'GET_CHARGES':
                exit(GetCharges(RequestPayload.AsObject, RequestAPIId));
            //'CALL_SERVICE':
            //  exit(PostMpesaTransactions(RequestPayload.AsObject, RequestAPIId));

            // LOAN APPLICATION + GUARANTORSHIP
            'GET_LOAN_APPLICATION_PRODUCTS':
                exit(GetLoanApplicationProducts(RequestPayload.AsObject, RequestAPIId));
            'VALIDATE_GUARANTOR_ELIGIBILITY_REQUEST':
                exit(ValidateGuarantorEligibilityRequest(RequestPayload.AsObject));
            'CREATE_LOAN_APPLICATION_REQUEST':
                exit(CreateLoanApplicationRequest(RequestPayload.AsObject, RequestAPIId));
            'GET_LOAN_APPLICATION_REQUESTS':
                exit(GetLoanApplicationRequests(RequestPayload.AsObject, RequestAPIId));
            'GET_MAX_LOAN_INSTALLMENTS':
                exit(GetLoanMaxInstallments(RequestPayload.AsObject, RequestAPIID));
            'GET_LOAN_APPLICATION_REQUEST':
                exit(GetLoanApplicationRequest(RequestPayload.AsObject, RequestAPIId));
            'EDIT_LOAN_APPLICATION_REQUEST':
                exit(EditLoanApplicationRequest(RequestPayload.AsObject, RequestAPIId));
            'CANCEL_LOAN_APPLICATION_REQUEST':
                exit(CancelLoanApplicationRequest(RequestPayload.AsObject, RequestAPIId));
            'GUARANTOR_ELIGIBILITY_CHECK':
                exit(GuarantorEligibilityCheck(RequestPayload.AsObject, RequestAPIId));
            'MANAGE_LOAN_APPLICATION_GUARANTORS_REQUEST':
                exit(ManageLoanGuarantorsRequest(RequestPayload.AsObject, RequestAPIId));
            'GET_LOAN_GUARANTORSHIP_REQUESTS':
                exit(GetLoanGuarantorshipRequests(RequestPayload.AsObject, RequestAPIId));
            'GET_LOAN_GUARANTORSHIP_REQUEST':
                exit(GetLoanGuarantorshipRequest(RequestPayload.AsObject, RequestAPIId));
            'ACTION_LOAN_GUARANTORSHIP_REQUEST':
                exit(ActionLoanGuarantorshipRequest(RequestPayload.AsObject, RequestAPIId));
            'GET_LOANS_WITH_GUARANTORS':
                exit(GetLoansWithGuarantors(RequestPayload.AsObject, RequestAPIId));
            'ADD_GUARANTOR':
                exit(AddGuarantor(RequestPayload.AsObject, RequestAPIId));
            'REMOVE_GUARANTOR':
                exit(RemoveGuarantor(RequestPayload.AsObject, RequestAPIId));
            'GET_LOANS_GUARANTEED':
                exit(GetLoansGuaranteed(RequestPayload.AsObject, RequestAPIId));
            'GET_LOAN_GUARANTORS':
                exit(GetLoanGuarantors(RequestPayload.AsObject, RequestAPIId));
            'GET_LOAN_BUFFER_GUARANTORS':
                exit(GetLoanBufferGuarantors(RequestPayload.AsObject, RequestAPIId));
            'GET_LOANS_PENDING_GUARANTORSHIP':
                exit(GetLoansPendingGuarantorship(RequestPayload.AsObject, RequestAPIId));

            // Standing Orders
            'GET_STANDING_ORDER_SOURCE_ACCOUNTS':
                exit(GetSTOSourceAccounts(RequestPayload.AsObject));
            'GET_STANDING_ORDER_INCOME_TYPES':
                exit(GetSTOIncomeTypes(RequestPayload.AsObject));
            'CREATE_STANDING_ORDER_REQUEST':
                exit(CreateStandingOrderRequest(RequestPayload.AsObject));
            'GET_STANDING_ORDER_REQUESTS':
                exit(GetStandingOrderRequests(RequestPayload.AsObject));
            'GET_STANDING_ORDER_REQUEST':
                exit(GetStandingOrderRequest(RequestPayload.AsObject));
            'CANCEL_STANDING_ORDER_REQUEST':
                exit(CancelStandingOrderRequest(RequestPayload.AsObject));

            // Fixed Deposit Contracts
            'GET_FD_ACCOUNTS':
                exit(GetFDAccountsList(RequestPayload.AsObject));
            'GET_FD_MATURITY_INSTRUCTIONS':
                exit(GetFDAccountMaturityInstructions(RequestPayload.AsObject));
            'UPDATE_FD_MATURITY_INSTRUCTION_REQUEST':
                exit(UpdateFDAccountMaturityRequest(RequestPayload.AsObject));


            'ATM_CARD_REQUEST':
                exit(ATMApplicationRequest(RequestPayload.AsObject));
            'GET_ATM_CARDS':
                exit(GetATMCards(RequestPayload.AsObject));
            'ATM_CARD_ACTION':
                exit(ATMCardAction(RequestPayload.AsObject));
            'DIVIDEND_PAYSLIP':
                exit(DividendSlip(RequestPayload.AsObject));
            'GET_DIVIDEND_PAYSLIP_YEARS':
                exit(GetDividendSlipYears(RequestPayload.AsObject));
            'GET_VARIATION_AMOUNT':
                exit(GetVariationAmount(RequestPayload.AsObject));
            'ACCOUNT_VARIATION':
                exit(AccountVariationRequest(RequestPayload.AsObject));
            'VALIDATE_BUSINESS_SHORT_CODE':
                exit(ValidateBusinessShortCode(RequestPayload.AsObject, RequestAPIId));

            // SMS Messaging - Get Pending & Update Pending
            'GET_PENDING_MESSAGES':
                exit(GetPendingMessages(RequestPayload.AsObject, RequestAPIId));
            'UPDATE_PENDING_MESSAGES':
                exit(UpdatePendingMessages(RequestPayload.AsObject, RequestAPIId));


            else
                exit(UnsupportedAction(RequestAction.AsValue.AsText))
        end;
    end;


    local procedure InternalFundsTransfer(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        originator_id: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        source_account: JsonToken;
        destination_account: JsonToken;
        amount: JsonToken;
        transaction_type: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        source_application: JsonToken;
        transaction_description: JsonToken;
        transaction_date_time: JsonToken;

        InitiatorMember: Record Members;
        SourceSavingsAccount: Record "Savings Accounts";
        IsSourceAccActive: Boolean;
        DestinationSavingsAccount: Record "Savings Accounts";
        DestinationLoanAccount: Record Loans;
        IsDestinationAccActive: Boolean;
        SavingsProduct: Record "Product Setup";
        MpesaTrans: Record "Sky M-Banking Transactions";
        TotalCharges: Decimal;

        IsSharesTrading: Boolean;
        IsLoanRepayment: Boolean;
        TransactionTypeText: Text;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('source_account', source_account);
        Payload.Get('destination_account', destination_account);
        Payload.Get('amount', amount);
        Payload.Get('transaction_type', transaction_type);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('source_application', source_application);
        Payload.Get('transaction_description', transaction_description);
        Payload.Get('transaction_date_time', transaction_date_time);

        TransactionTypeText := UpperCase(transaction_type.AsValue().AsText());
        IsLoanRepayment := TransactionTypeText = 'LOAN_REPAYMENT';

        GetMemberRecord(
            InitiatorMember,
            identifier_type.AsValue().AsText(),
            identifier.AsValue().AsText(),
            'Transaction initiator'
        );

        // Validate amount
        if amount.AsValue().AsDecimal() <= 0 then begin
            Datum.Add('transaction_status', 'Failed');
            Datum.Add('transaction_status_description', 'Transaction amount must be greater than zero');
            Datum.Add('error_code', 'ERROR_INVALID_AMOUNT');
            ResponseObject.Add('request_status', 'ERROR');
            ResponseObject.Add('request_status_description', 'Processing failed');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Validate source <> destination
        if source_account.AsValue().AsText() = destination_account.AsValue().AsText() then begin
            Datum.Add('transaction_status', 'Failed');
            Datum.Add('transaction_status_description', 'Source account and destination account must be different');
            Datum.Add('error_code', 'ERROR_SAME_ACCOUNT');
            ResponseObject.Add('request_status', 'ERROR');
            ResponseObject.Add('request_status_description', 'Processing failed');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Duplicate check - Originator ID
        MpesaTrans.Reset();
        MpesaTrans.SetRange("Originator ID", originator_id.AsValue().AsText());
        MpesaTrans.SetLoadFields("Originator ID", "Transaction ID");
        if MpesaTrans.FindFirst() then begin
            Datum.Add('transaction_status', 'Failed');
            Datum.Add('transaction_status_description', 'This transaction already exists. Originator ID = ' + MpesaTrans."Originator ID");
            Datum.Add('error_code', 'IFT_REQUEST_EXISTS');
            ResponseObject.Add('request_status', 'IFT_REQUEST_EXISTS');
            ResponseObject.Add('request_status_description', 'Processing failed');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            //SkyMbankingTrans.PostAccountTransferTransaction(MpesaTrans."Transaction ID");
            exit(Response);
        end;

        // Duplicate check - Source Reference
        MpesaTrans.Reset();
        MpesaTrans.SetRange("Transaction Source Reference", source_reference.AsValue().AsText());
        MpesaTrans.SetLoadFields("Transaction Source Reference");
        if MpesaTrans.FindFirst() then begin
            Datum.Add('transaction_status', 'Failed');
            Datum.Add('transaction_status_description', 'This transaction already exists. Source Reference = ' + MpesaTrans."Transaction Source Reference");
            Datum.Add('error_code', 'IFT_REQUEST_EXISTS');
            ResponseObject.Add('request_status', 'IFT_REQUEST_EXISTS');
            ResponseObject.Add('request_status_description', 'Processing failed');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // ── Source Account Validations ────────────────────────────────────────────

        // Savings account source
        SourceSavingsAccount.Reset();
        SourceSavingsAccount.SetRange("No.", source_account.AsValue().AsText());
        if not SourceSavingsAccount.FindFirst() then begin
            Datum.Add('transaction_status', 'Failed');
            Datum.Add('transaction_status_description', 'Account ' + source_account.AsValue().AsText() + ' does not exist');
            Datum.Add('error_code', 'ACCOUNT_NOT_FOUND');
            ResponseObject.Add('request_status', 'ACCOUNT_NOT_FOUND');
            ResponseObject.Add('request_status_description', 'Processing failed');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;


        // Product withdrawability
        SavingsProduct.Reset();
        SavingsProduct.SetRange("Product ID", SourceSavingsAccount."Product Type");
        if SavingsProduct.FindFirst() then begin
            if SavingsProduct."Product Category" = SavingsProduct."Product Category"::"Share Capital" then
                IsSharesTrading := true;

            if SavingsProduct."Product Category" <> SavingsProduct."Product Category"::"Ordinary Savings" then begin
                Datum.Add('transaction_status', 'Failed');
                Datum.Add('transaction_status_description', 'Account ' + source_account.AsValue().AsText() + ' is NOT withdrawable');
                Datum.Add('error_code', 'INVALID_ACCOUNT');
                ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                ResponseObject.Add('request_status_description', 'Processing failed');
                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        // Belongs to member?
        if SourceSavingsAccount."Member No." <> InitiatorMember."No." then begin
            Datum.Add('transaction_status', 'Failed');
            Datum.Add('transaction_status_description', 'Account ' + source_account.AsValue().AsText() + ' does NOT belong to the given member');
            Datum.Add('error_code', 'INVALID_ACCOUNT');
            ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
            ResponseObject.Add('request_status_description', 'Processing failed');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Active?
        case SourceSavingsAccount.Status of
            SourceSavingsAccount.Status::Active,
            SourceSavingsAccount.Status::New:
                IsSourceAccActive := true;
            else
                IsSourceAccActive := false;
        end;

        if IsSharesTrading then
            IsSourceAccActive := true;

        if not IsSourceAccActive then begin
            Datum.Add('transaction_status', 'Failed');
            Datum.Add('transaction_status_description', 'Account ' + source_account.AsValue().AsText() + ' is NOT active. Current status is ' + Format(SourceSavingsAccount.Status));
            Datum.Add('error_code', 'ACCOUNT_NOT_ACTIVE');
            ResponseObject.Add('request_status', 'ACCOUNT_NOT_ACTIVE');
            ResponseObject.Add('request_status_description', 'Processing failed');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Blocked?
        if (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::All) or
           (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::Payment) then begin
            Datum.Add('transaction_status', 'Failed');
            Datum.Add('transaction_status_description', 'Account ' + source_account.AsValue().AsText() + ' is blocked from withdrawal transactions');
            Datum.Add('error_code', 'BLOCKED');
            ResponseObject.Add('request_status', 'BLOCKED');
            ResponseObject.Add('request_status_description', 'Processing failed');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        GetMobileCharge(TransType::"Account Transfer", amount.AsValue().AsDecimal(), vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);

        // Insufficient balance?
        if SkyMbankingTrans.InsufficientAccountBalance(
            amount.AsValue().AsDecimal() + TotalCharge,
            SourceSavingsAccount,
            'IFT_' + TransactionTypeText,
            InitiatorMember) then begin
            Datum.Add('transaction_status', 'Failed');
            Datum.Add('transaction_status_description', 'Insufficient funds in source account ' + source_account.AsValue().AsText());
            Datum.Add('error_code', 'INSUFFICIENT_BAL');
            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
            ResponseObject.Add('request_status_description', 'Processing failed');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // ── Destination Account Validations ──────────────────────────────────────
        if IsLoanRepayment then begin
            // Loan destination
            DestinationLoanAccount.Reset();
            DestinationLoanAccount.SetRange("Loan No.", destination_account.AsValue().AsText());
            DestinationLoanAccount.SetLoadFields(Status, Posted);
            if not DestinationLoanAccount.FindFirst() then begin
                Datum.Add('transaction_status', 'Failed');
                Datum.Add('transaction_status_description', 'Loan account ' + destination_account.AsValue().AsText() + ' does not exist');
                Datum.Add('error_code', 'ACCOUNT_NOT_FOUND');
                ResponseObject.Add('request_status', 'ACCOUNT_NOT_FOUND');
                ResponseObject.Add('request_status_description', 'Processing failed');
                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            if not DestinationLoanAccount.Posted then begin
                Datum.Add('transaction_status', 'Failed');
                Datum.Add('transaction_status_description', 'Loan account ' + destination_account.AsValue().AsText() + ' is NOT active. Current status is ' + Format(DestinationLoanAccount.Status));
                Datum.Add('error_code', 'DEST_ACCOUNT_NOT_ACTIVE');
                ResponseObject.Add('request_status', 'DEST_ACCOUNT_NOT_ACTIVE');
                ResponseObject.Add('request_status_description', 'Processing failed');
                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end else begin
            // Savings destination
            DestinationSavingsAccount.Reset();
            DestinationSavingsAccount.SetRange("No.", destination_account.AsValue().AsText());
            DestinationSavingsAccount.SetLoadFields("Product Type", Blocked);
            if not DestinationSavingsAccount.FindFirst() then begin
                Datum.Add('transaction_status', 'Failed');
                Datum.Add('transaction_status_description', 'Destination account ' + destination_account.AsValue().AsText() + ' does not exist');
                Datum.Add('error_code', 'ACCOUNT_NOT_FOUND');
                ResponseObject.Add('request_status', 'ACCOUNT_NOT_FOUND');
                ResponseObject.Add('request_status_description', 'Processing failed');
                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // Shares trading destination must be Share Capital
            if IsSharesTrading then begin
                SavingsProduct.Reset();
                SavingsProduct.SetRange("Product ID", DestinationSavingsAccount."Product Type");
                if SavingsProduct.FindFirst() then
                    if SavingsProduct."Product Category" <> SavingsProduct."Product Category"::"Share Capital" then begin
                        Datum.Add('transaction_status', 'Failed');
                        Datum.Add('transaction_status_description', 'Destination account ' + destination_account.AsValue().AsText() + ' must be a share capital account');
                        Datum.Add('error_code', 'INVALID_ACCOUNT');
                        ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                        ResponseObject.Add('request_status_description', 'Processing failed');
                        ResponseObject.Add('response_payload', Datum);
                        AddDateTimeToResponse(ResponseObject);
                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
            end;

            // Destination blocked?
            if DestinationSavingsAccount.Blocked = DestinationSavingsAccount.Blocked::All then begin
                Datum.Add('transaction_status', 'Failed');
                Datum.Add('transaction_status_description', 'Destination account ' + destination_account.AsValue().AsText() + ' is blocked from deposit transactions');
                Datum.Add('error_code', 'BLOCKED');
                ResponseObject.Add('request_status', 'BLOCKED');
                ResponseObject.Add('request_status_description', 'Processing failed');
                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        // ── Log & Process ─────────────────────────────────────────────────────────
        MpesaTrans.Reset();
        TotalCharges := 0;

        if amount.AsValue().AsDecimal() <= TotalCharges then begin
            Datum.Add('transaction_status', 'Failed');
            Datum.Add('transaction_status_description', 'Transaction amount must be greater than ' + Format(TotalCharges));
            Datum.Add('error_code', 'ERROR_INVALID_AMOUNT');
            ResponseObject.Add('request_status', 'ERROR');
            ResponseObject.Add('request_status_description', 'Processing failed');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        if IsLoanRepayment then
            SkyMbankingTrans.LogIFTLoanRepayment(MpesaTrans, Payload, APIRequestID)
        else
            SkyMbankingTrans.LogIFTAccountToAccount(MpesaTrans, Payload, APIRequestID);

        if MpesaTrans.Insert(true) then begin
            Datum.Add('transaction_status', 'Success');
            Datum.Add('transaction_status_description',
                'Transfer of KES ' + Format(amount.AsValue().AsDecimal(), 0, '<Precision,2:2><Standard Format,0>') +
                ' from ' + source_account.AsValue().AsText() +
                ' to ' + destination_account.AsValue().AsText() + ' was successful.');
            Datum.Add('transaction_reference', MpesaTrans."Transaction ID");
            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'Internal Funds Transfer request received successfully and is being processed');
            //SkyMbankingTrans.PostAccountTransferTransaction(MpesaTrans."Transaction ID");
        end else begin
            Datum.Add('transaction_status', 'Failed');
            Datum.Add('transaction_status_description', 'Unable to process the transaction at the moment');
            Datum.Add('error_code', 'ERROR_INSERT_FAILED');
            ResponseObject.Add('request_status', 'ERROR');
            ResponseObject.Add('request_status_description', 'Processing failed');
        end;

        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure CallServiceFunctionJobQueue(Payload: JsonObject): Text
    var
        service_id: JsonToken;

        Datum: JsonObject;
        Response: Text;
        ResponseObject: JsonObject;
    begin
        Payload.Get('service_id', service_id);
        SkyMbankingTrans.CallServiceFunction(service_id.AsValue.AsText);

        ResponseObject.Add('request_status', 'SUCCESS');
        Datum.Add('response_message', 'SUCCESS');
        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure CallServiceFunction(Payload: JsonObject): Text
    var
        service_id: JsonToken;

        Datum: JsonObject;
        Response: Text;
        ResponseObject: JsonObject;
    begin
        Payload.Get('service_id', service_id);
        //SkyMbankingTrans.CallServiceFunction(service_id.AsValue.AsText);

        ResponseObject.Add('request_status', 'SUCCESS');
        Datum.Add('response_message', 'SUCCESS');
        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure GetMemberDetails(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        SearchMember: Record Members;
        Accounts: Record "Savings Accounts";
        DimensionValues: Record "Dimension Value";
        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        phone_no: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO, NATIONAL_ID, PASSPORT_NO, GROWER_NO
        Payload.Get('identifier', identifier);

        if identifier.AsValue.AsText = '' then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Identifier value must NOT be empty!');

            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        Accounts.Reset;

        case identifier_type.AsValue.AsText of
            'MSISDN':
                begin
                    Accounts.SetRange("Transactional Mobile No", ConvertPhoneNo(identifier.AsValue.AsText));
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            'CUSTOMER_NO':
                begin

                    Accounts.SetRange("Member No.", identifier.AsValue.AsText);
                    Accounts.SetFilter("Transactional Mobile No", '<>%1', '');
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            'NATIONAL_ID':
                begin

                    Accounts.SetRange("ID No.", identifier.AsValue.AsText);
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            'PASSPORT_NO':
                begin

                    Accounts.SetRange("ID No.", identifier.AsValue.AsText);
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            'GROWER_NO':
                begin

                    Accounts.SetRange("Payroll/Staff No.", identifier.AsValue.AsText);
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            else
                Accounts.SetRange("No.", identifier.AsValue.AsText);
        end;

        IF Accounts.FindFirst() then begin
            SearchMember.get(Accounts."Member No.");
            if SearchMember."Account Category" = SearchMember."Account Category"::Individual then begin
                Datum.Add('customer_type', 'INDIVIDUAL');
            end else begin
                Datum.Add('customer_type', 'CORPORATE');
            end;

            Datum.Add('identifier_type', 'CUSTOMER_NO');
            Datum.Add('identifier', SearchMember."No.");

            Datum.Add('primary_identity_type', 'NATIONAL_ID');
            if SearchMember."ID No." = '' then begin
                Datum.Add('primary_identity_no', SearchMember.Passport);
            end else begin
                Datum.Add('primary_identity_no', SearchMember."ID No.");
            end;

            Datum.Add('title', '');
            Datum.Add('full_name', SearchMember.Name);
            Datum.Add('gender', Format(SearchMember.Gender).ToUpper);
            Datum.Add('date_of_birth', ddMMyyyy(SearchMember."Date of Birth"));
            Datum.Add('primary_email_address', SearchMember."E-Mail");

            Datum.Add('primary_mobile_number', Accounts."Transactional Mobile No");


            Datum.Add('status', Format(SearchMember."Member Status").ToUpper);
            Datum.Add('registration_date', ddMMyyyy(SearchMember."Registration Date"));
            Datum.Add('tax_authority', 'KRA');
            Datum.Add('tax_authority_pin_number', SearchMember."KRA PIN");

            Datum.Add('status_date', ddMMyyyy(SearchMember."Registration Date"));
            Datum.Add('status_description', Format(SearchMember."Member Status").ToUpper);

            Datum.Add('branch_code', SearchMember."Branch Code");
            DimensionValues.Reset;
            DimensionValues.SetRange("Dimension Code", BranchDimensionCode);
            DimensionValues.SetRange(Code, SearchMember."Branch Code");
            if DimensionValues.FindFirst then begin
                Datum.Add('branch', DimensionValues.Name);
            end else begin
                Datum.Add('branch', SearchMember."Branch Code");
            end;

            Datum.Add('main_savings_account_no', SkyMbankingTrans.GetMemberFosaAcc(SearchMember));
            Datum.Add('main_deposits_account_no', SkyMbankingTrans.GetMemberDepositsAcc(SearchMember));

            ResponseObject.Add('request_status', 'SUCCESS');
        end else begin
            ResponseObject.Add('request_status', 'NOT_FOUND');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetDepositAccounts(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        account_type: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        apply_charges: JsonToken;

        SearchMember: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        FOSAAccount: Record "Savings Accounts";
        SavingsProduct: Record "Product Setup";

        TotalCharges: Decimal;
        FosaAcc: Text;

        IsWithdrawable: Boolean;
        IsDepositable: Boolean;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        Found: Boolean;

        MemberActivities: Codeunit "Member Activities";
    begin
        Payload.Get('account_type', account_type); // FOSA, BOSA, WITHDRAWABLE, DEPOSIT, ALL, BUSINESS
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO, ID_NUMBER
        Payload.Get('identifier', identifier);

        Found := GetMemberRecord(SearchMember, identifier_type.AsValue.AsText, identifier.AsValue.AsText, '');

        IF Found then begin
            SavingsAccounts.Reset;
            SavingsAccounts.SetRange("Member No.", SearchMember."No.");
            SavingsAccounts.SetFilter(Status, '<>%1&<>%2', SavingsAccounts.Status::Closed, SavingsAccounts.Status::Deceased);
            SavingsAccounts.SetFilter("Product Category", '<>%1&<>%2', SavingsAccounts."Product Category"::"Registration Fee", SavingsAccounts."Product Category"::"Unallocated Fund");
            if account_type.AsValue.AsText = 'FOSA' then begin
                SavingsAccounts.SetRange("Global Dimension 1 Code", 'FOSA');
            end else if account_type.AsValue.AsText = 'BOSA' then begin
                SavingsAccounts.SetRange("Global Dimension 1 Code", 'BOSA');
            end else if account_type.AsValue.AsText = 'WITHDRAWABLE' then begin
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Ordinary Savings");
            end else if account_type.AsValue.AsText = 'DEPOSIT' then begin
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Fixed Deposit");
            end else if account_type.AsValue.AsText = 'ALL' then begin
                SavingsAccounts.SetFilter("Product Category", '<>%1&<>%2&<>%3', SavingsAccounts."Product Category"::"Fixed Deposit", SavingsAccounts."Product Category"::"Registration Fee", SavingsAccounts."Product Category"::"Dividend Account");
            end
            else begin

                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);

            end;
            SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
            IF SavingsAccounts.FindSet() then begin
                repeat begin
                    IsWithdrawable := false;
                    IsDepositable := false;

                    SavingsProduct.Get(SavingsAccounts."Product Type");


                    if (SavingsProduct."USSD Product Name" <> '') then begin
                        Datum.Add('account_label', SavingsProduct."USSD Product Name");
                        Datum.Add('account_name', GetSavingsAccountDisplayName(SavingsAccounts, SavingsProduct."USSD Product Name"));
                    end else begin
                        Datum.Add('account_label', SavingsAccounts."Product Name");
                        Datum.Add('account_name', GetSavingsAccountDisplayName(SavingsAccounts, SavingsAccounts."Product Name"));
                    end;

                    Datum.Add('account_number', SavingsAccounts."No.");
                    Datum.Add('member_number', SavingsAccounts."Member No.");
                    Datum.Add('account_type', SavingsAccounts."Global Dimension 2 Code");

                    Datum.Add('account_balance', MemberActivities.GetAccountBalance(SavingsAccounts."No."));
                    Datum.Add('book_balance', SavingsAccounts."Balance (LCY)");
                    Datum.Add('account_status', Format(SavingsAccounts.Status).ToUpper);
                    if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Ordinary Savings" then begin

                        IsWithdrawable := false;
                        Datum.Add('can_withdraw', 'YES');
                        Datum.Add('can_withdraw_ift', 'YES');
                    enD
                    else begin
                        Datum.Add('can_withdraw', 'NO');
                        Datum.Add('can_withdraw_ift', 'NO');
                    end;

                    Datum.Add('can_deposit', 'YES');
                    IsDepositable := true;
                    Datum.Add('max_withdrawable_amount', 0);
                    Datum.Add('max_deposit_amount', 999999999999L);
                    Datum.Add('product_id', SavingsProduct."Product ID");
                    Datum.Add('product_name', SavingsProduct."Description");

                    case SavingsAccounts."Product Category" of
                        SavingsAccounts."Product Category"::"Registration Fee",
                        SavingsAccounts."Product Category"::"Fixed Deposit":
                            Datum.Add('show_balance', false);
                        else
                            Datum.Add('show_balance', true);
                    end;
                    Data.Add(Datum);

                    // Reset
                    Datum.ReadFrom('{}');

                end until SavingsAccounts.Next = 0;
            end;


            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure ValidateAccount(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        account_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        SavingsAccount: Record "Savings Accounts";
        SavingsProduct: Record "Product Setup";

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;
        Members: Record Members;

    begin
        Payload.Get('account_number', account_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);


        IF GetMemberRecord(SearchMember, identifier_type.AsValue.AsText, identifier.AsValue.AsText, '') then begin

            SavingsAccount.Reset;
            SavingsAccount.FilterGroup := -1;
            SavingsAccount.SetRange("No.", account_number.AsValue.AsText);
            SavingsAccount.SetAutoCalcFields("Balance (LCY)", "ID No.");
            if SavingsAccount.FindFirst then begin

                SavingsProduct.GET(SavingsAccount."Product Type");
                Members.GET(SavingsAccount."Member No.");

                Datum.Add('account_name', GetSavingsAccountDisplayName(SavingsAccount, SavingsAccount.Name));

                if (SavingsProduct."USSD Product Name" <> '') then begin
                    Datum.Add('account_label', SavingsProduct."USSD Product Name");
                end else begin
                    Datum.Add('account_label', SavingsAccount."Product Name");
                end;

                Datum.Add('account_number', SavingsAccount."No.");
                Datum.Add('account_type', SavingsAccount."Product Type");
                Datum.Add('account_type_name', SavingsAccount."Product Name");
                Datum.Add('account_status', Format(SavingsAccount.Status).ToUpper);

                if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Share Capital" then begin
                    Datum.Add('account_balance', SavingsAccount."Balance (LCY)");
                end else begin
                    Datum.Add('account_balance', MemberActivities.GetAccountBalance(SavingsAccount."No."));
                end;

                //SavingsAccount.CalcFields("Balance (LCY)");
                Datum.Add('book_balance', SavingsAccount."Balance (LCY)");


                if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Ordinary Savings" then begin
                    Datum.Add('can_withdraw', 'YES');
                    Datum.Add('can_withdraw_ift', 'YES');
                enD
                else begin
                    Datum.Add('can_withdraw', 'NO');
                    Datum.Add('can_withdraw_ift', 'NO');
                end;

                Datum.Add('can_deposit', 'YES');

                Datum.Add('max_withdrawable_amount', 0);



                Datum.Add('max_deposit_amount', 999999L);

                MemberDetails.Add('full_name', SavingsAccount.Name);
                MemberDetails.Add('mobile_number', Members."Mobile Phone No.");

                MemberDetails.Add('id_number', SavingsAccount."ID No.");

                MemberDetails.Add('member_number', SavingsAccount."Member No.");

                Datum.Add('member_details', MemberDetails);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Account with number ' + account_number.AsValue.AsText + ' NOT found!');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure BalanceEnquiry(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        account_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        originatorId: JsonToken;

        SearchMember: Record Members;
        SavingsAccount: Record "Savings Accounts";
        FOSAAccount: Record "Savings Accounts";
        FosaAcc: Text;
        TotalCharges: Decimal;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;
        Found: Boolean;
    begin
        // Database.SelectLatestVersion();

        Payload.Get('account_number', account_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('originator_id', originatorId);

        Found := GetMemberRecord(SearchMember, identifier_type.AsValue.AsText, identifier.AsValue.AsText, '');

        IF Found then begin
            if CheckFOSASavingsAccountBlocked(SearchMember, 'DEBIT') then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Account is blocked from debit transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            SavingsAccount.Reset;
            SavingsAccount.SetRange("No.", account_number.AsValue.AsText);
            SavingsAccount.SetRange("Member No.", SearchMember."No.");
            SavingsAccount.SetAutoCalcFields("Balance (LCY)");
            if SavingsAccount.FindFirst then begin

                GetMobileCharge(TransType::"Account Balance Enquiry", 0, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);

                TotalCharges := TotalCharge + ExciseDutyFee;

                if TotalCharges > 0 then begin
                    // Log the transaction
                    FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

                    FOSAAccount.Reset;
                    FOSAAccount.SetRange("No.", FosaAcc);
                    if FOSAAccount.FindFirst() then begin
                        // INSUFFICIENT_BAL
                        if SkyMbankingTrans.InsufficientAccountBalance(
                            0,
                            FOSAAccount,
                            'SINGLE_ACCOUNT_BALANCE_ENQUIRY',
                            SearchMember
                        ) then begin
                            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                            Datum.Add('error_message', 'FOSA Account has insufficient balance to complete the transaction.');
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;

                        SkyMbankingTrans.LogAccountBalanceEnquiry(
                            APIRequestID.AsValue.AsText,
                            originatorId.AsValue.AsText,
                            identifier_type.AsValue.AsText,
                            identifier.AsValue.AsText,
                            account_number.AsValue.AsText,
                            SearchMember
                        );


                    end;
                end;

                Datum.Add('account_name', GetSavingsAccountDisplayName(SavingsAccount, SavingsAccount.Name));
                Datum.Add('account_label', SavingsAccount."Product Name");
                Datum.Add('account_number', SavingsAccount."No.");
                Datum.Add('account_type', SavingsAccount."Product Type");

                if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Share Capital" then begin
                    Datum.Add('account_balance', SavingsAccount."Balance (LCY)");
                end else begin
                    Datum.Add('account_balance', MemberActivities.GetAccountBalance(SavingsAccount."No."));
                end;

                SavingsAccount.CalcFields("Balance (LCY)");
                Datum.Add('book_balance', SavingsAccount."Balance (LCY)");

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);

                exit(Response);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Account with number ' + account_number.AsValue.AsText + ' NOT found for the given member');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);

                exit(Response);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure AccountMiniStatement(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        account_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        number_of_transactions: JsonToken;

        SearchMember: Record Members;
        SavingsAccount: Record "Savings Accounts";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        FOSAAccount: Record "Savings Accounts";

        Count: Integer;
        FosaAcc: Text;
        TotalCharges: Decimal;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Transactions: JsonArray;
        Transaction: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('account_number', account_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('number_of_transactions', number_of_transactions);



        IF GetMemberRecord(SearchMember, identifier_type.AsValue.AsText, identifier.AsValue.AsText, '') then begin
            if CheckFOSASavingsAccountBlocked(SearchMember, 'DEBIT') then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Account is blocked from debit transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            SavingsAccount.Reset;
            SavingsAccount.SetRange("No.", account_number.AsValue.AsText);
            SavingsAccount.SetRange("Member No.", SearchMember."No.");
            SavingsAccount.SetAutoCalcFields("Balance (LCY)");
            if SavingsAccount.FindFirst then begin

                GetMobileCharge(TransType::"Account Mini-Statement", 0, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
                TotalCharges := TotalCharge + ExciseDutyFee;
                FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);
                if TotalCharges > 0 then begin
                    FOSAAccount.Reset;
                    FOSAAccount.SetRange("No.", FosaAcc);
                    if FOSAAccount.FindFirst() then begin
                        // INSUFFICIENT_BAL
                        if SkyMbankingTrans.InsufficientAccountBalance(
                            0,
                            FOSAAccount,
                            'ACCOUNT_MINI_STATEMENT',
                            SearchMember
                        ) then begin
                            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                            Datum.Add('error_message', 'FOSA Account has insufficient balance to complete the transaction.');
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;
                end;

                Datum.Add('account_name', GetSavingsAccountDisplayName(SavingsAccount, SavingsAccount.Name));

                Datum.Add('account_number', SavingsAccount."No.");

                if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Share Capital" then begin
                    Datum.Add('available_balance', SavingsAccount."Balance (LCY)");
                end else begin
                    Datum.Add('available_balance', MemberActivities.GetAccountBalance(SavingsAccount."No."));
                end;

                Datum.Add('book_balance', SavingsAccount."Balance (LCY)");

                SavingsLedgerEntry.Reset;
                SavingsLedgerEntry.SetCurrentkey("Entry No.");
                SavingsLedgerEntry.Ascending(false);
                SavingsLedgerEntry.SetRange("Account No.", SavingsAccount."No.");
                SavingsLedgerEntry.SetRange(Reversed, false);
                IF SavingsLedgerEntry.FindSet then begin
                    repeat begin
                        Count += 1;

                        Transaction.Add('transaction_reference', SavingsLedgerEntry."Document No.");
                        Transaction.Add('transaction_date', ddMMyyyy(SavingsLedgerEntry."Posting Date"));
                        Transaction.Add('transaction_time', SavingsLedgerEntry."Creation Time");

                        if SavingsLedgerEntry."Amount (LCY)" < 0 then begin
                            Transaction.Add('transaction_amount', Abs(SavingsLedgerEntry."Amount (LCY)"));
                            Transaction.Add('transaction_type', 'CREDIT');
                        end else begin
                            Transaction.Add('transaction_amount', SavingsLedgerEntry."Amount (LCY)");
                            Transaction.Add('transaction_type', 'DEBIT');
                        end;

                        Transaction.Add('running_balance', SavingsAccount."Balance (LCY)");
                        Transaction.Add('transaction_description', SavingsLedgerEntry.Description);
                        Transaction.Add('other_details', SavingsLedgerEntry.Description);

                        Transactions.Add(Transaction);
                        // Reset
                        Transaction.ReadFrom('{}');
                    end until (Count = number_of_transactions.AsValue.AsInteger) or (SavingsLedgerEntry.Next = 0);
                end;

                Datum.Add('transactions', Transactions);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);

                // Log the transaction
                // Currently MNS only FOSA account balance enquiry is charged
                if TotalCharges > 0 then begin
                    if FosaAcc = SavingsAccount."No." then begin
                        SkyMbankingTrans.LogAccountMiniStatement(
                            APIRequestID.AsValue.AsText,
                            identifier_type.AsValue.AsText,
                            identifier.AsValue.AsText,
                            account_number.AsValue.AsText,
                            SearchMember
                        );
                    end;
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Account with number ' + account_number.AsValue.AsText + ' NOT found for the given member');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;


    local procedure AccountFullStatementPDF(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        account_number: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        SearchMember: Record Members;
        OtherMember: Record Members;
        MobileTrans: Record "Sky M-Banking Transactions";
        TempBlob1: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        Account: Text;
        ProductID: Text;
        MemberNo: Text;
        StartDate: Date;
        EndDate: Date;
        SourceRef: Code[20];
        ReportID: Integer;
        ReportOutStream: OutStream;
        Base64String: Text;
        Savings: Record "Savings Accounts";
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('account_number', account_number);
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);
        Account := account_number.AsValue().AsText();
        SourceRef := CopyStr(APIRequestID.AsValue().AsText(), 1, 20);

        if StrPos(Account, '#') > 0 then begin
            MemberNo := CopyStr(Account, 1, StrPos(Account, '#') - 1);
            ProductID := CopyStr(Account, StrPos(Account, '#') + 1, StrLen(Account));
        end else begin
            MemberNo := Account;
            ProductID := 'S06';
        end;

        StartDate := ParseDateString(start_date.AsValue().AsText());
        EndDate := ParseDateString(end_date.AsValue().AsText());

        if not MemberExists(identifier_type.AsValue().AsText(), identifier.AsValue().AsText(), SearchMember, ResponseText, ResponseDescription) then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        MobileTrans.Init();
        MobileTrans."API Request ID" := APIRequestID.AsValue().AsText();
        MobileTrans."Originator ID" := APIRequestID.AsValue().AsText();
        MobileTrans."Transaction ID" := CreateGuid();
        MobileTrans."Entry No." := CreateGuid();
        MobileTrans."Transaction ID" := SourceRef;
        MobileTrans."Session ID" := SourceRef;
        MobileTrans."Transaction Date" := Today();
        MobileTrans."Transaction Time" := Time();
        MobileTrans."Source Account" := SearchMember."No.";
        MobileTrans."Account to Check" := CopyStr(SearchMember."No." + '#S06', 1, 50);
        MobileTrans."Transaction Type" := MobileTrans."Transaction Type"::"Account Full-Statement";
        MobileTrans.Insert(true);

        Savings.Reset();
        Savings.SetRange("No.", account_number.AsValue().AsText());
        if EndDate <> 0D then
            Savings.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);

        // ← Replaced file path approach with in-memory stream
        TempBlob1.CreateOutStream(ReportOutStream);
        Report.SaveAs(Report::"Savings Statement", '', ReportFormat::Pdf, ReportOutStream, Savings);
        Base64String := Base64Convert.ToBase64(TempBlob1.CreateInStream());

        ResponseObject.Add('request_status', 'SUCCESS');
        Datum.Add('data', Base64String);
        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure AccountFullStatement(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        account_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;

        SearchMember: Record Members;
        SavingsAccount: Record "Savings Accounts";
        RunBalSavings: Record "Savings Accounts";
        SavingsLedgerEntry: Record "Savings Ledger Entry";

        FosaAcc: Text;
        FosaAccount: Record "Savings Accounts";
        TotalCharges: Decimal;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Transactions: JsonArray;
        Transaction: JsonObject;
        Datum: JsonObject;
        Response: Text;
        Found: Boolean;
    begin
        Payload.Get('account_number', account_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        Found := GetMemberRecord(SearchMember, identifier_type.AsValue.AsText, identifier.AsValue.AsText, '');

        IF Found then begin
            if CheckFOSASavingsAccountBlocked(SearchMember, 'DEBIT') then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Account is blocked from debit transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            SavingsAccount.Reset;
            SavingsAccount.SetRange("No.", account_number.AsValue.AsText);
            SavingsAccount.SetRange("Member No.", SearchMember."No.");
            SavingsAccount.SetAutoCalcFields("Balance (LCY)");
            if SavingsAccount.FindFirst then begin
                GetMobileCharge(TransType::"Account Full-Statement", 0, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
                TotalCharges := TotalCharge + ExciseDutyFee;
                FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

                if TotalCharges > 0 then begin
                    FosaAccount.Reset;
                    FosaAccount.SetRange("No.", FosaAcc);
                    if FosaAccount.FindFirst then begin
                        // INSUFFICIENT_BAL
                        if SkyMbankingTrans.InsufficientAccountBalance(
                            0,
                            FosaAccount,
                            'ACCOUNT_FULL_STATEMENT',
                            SearchMember
                        ) then begin
                            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                            Datum.Add('error_message', 'Account has insufficient balance to complete the transaction.');
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;
                end;

                Datum.Add('account_holder', SavingsAccount."Product Name");
                Datum.Add('account_name', GetSavingsAccountDisplayName(SavingsAccount, SavingsAccount.Name));
                Datum.Add('account_number', SavingsAccount."No.");

                if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Share Capital" then begin
                    Datum.Add('available_balance', SavingsAccount."Balance (LCY)");
                end else begin
                    Datum.Add('available_balance', MemberActivities.GetAccountBalance(SavingsAccount."No."));
                end;

                Datum.Add('book_balance', SavingsAccount."Balance (LCY)");

                SavingsLedgerEntry.Reset;
                SavingsLedgerEntry.SetCurrentkey("Entry No.");
                SavingsLedgerEntry.Ascending(false);
                SavingsLedgerEntry.SetRange("Account No.", SavingsAccount."No.");

                StartDate := DT2Date(ParseDateTimeString(start_date.AsValue.AsText));
                EndDate := DT2Date(ParseDateTimeString(end_date.AsValue.AsText));

                SavingsLedgerEntry.SetFilter("Posting Date", '>=%1&<=%2', StartDate, EndDate);
                IF SavingsLedgerEntry.FindSet then begin
                    repeat begin

                        RunBalSavings.Reset();
                        RunBalSavings.SetRange("No.", SavingsLedgerEntry."Account No.");
                        RunBalSavings.SetFilter("Date Filter", '..%1', SavingsLedgerEntry."Posting Date");
                        RunBalSavings.SetAutoCalcFields("Balance (LCY)");
                        RunBalSavings.SetLoadFields("Balance (LCY)");
                        if RunBalSavings.FindFirst() then;

                        Transaction.Add('transaction_reference', SavingsLedgerEntry."Document No.");
                        Transaction.Add('transaction_date', ddMMyyyy(SavingsLedgerEntry."Posting Date"));
                        Transaction.Add('transaction_time', SavingsLedgerEntry."Creation Time");

                        if SavingsLedgerEntry."Amount (LCY)" < 0 then begin
                            Transaction.Add('transaction_amount', Abs(SavingsLedgerEntry."Amount (LCY)"));
                            Transaction.Add('transaction_type', 'CREDIT');
                        end else begin
                            Transaction.Add('transaction_amount', SavingsLedgerEntry."Amount (LCY)");
                            Transaction.Add('transaction_type', 'DEBIT');
                        end;

                        Transaction.Add('running_balance', RunBalSavings."Balance (LCY)");
                        Transaction.Add('transaction_description', SavingsLedgerEntry.Description);
                        Transaction.Add('other_details', SavingsLedgerEntry.Description);

                        Transactions.Add(Transaction);
                        // Reset
                        Transaction.ReadFrom('{}');
                    end until (SavingsLedgerEntry.Next = 0);
                end;

                Datum.Add('transactions', Transactions);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);

                if TotalCharges > 0 then begin
                    // Log the transaction
                    SkyMbankingTrans.LogAccountFullStatement(
                        APIRequestID.AsValue.AsText,
                        identifier_type.AsValue.AsText,
                        identifier.AsValue.AsText,
                        account_number.AsValue.AsText,
                        SearchMember
                    );
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Account with number ' + account_number.AsValue.AsText + ' NOT found for the given member');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure DividendSlip(Payload: JsonObject): Text
    var
        account_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        year: JsonToken;

        SearchMember: Record Members;
        SavingsAccount: Record "Savings Accounts";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        FOSAAccount: Record "Savings Accounts";

        Count: Integer;
        FosaAcc: Text;
        TotalCharges: Decimal;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Transactions: JsonArray;
        Transaction: JsonObject;
        Datum: JsonObject;
        Response: Text;
        DivSlipReport: report "Dividend Slip";
        vConvertedContent: text;
        varTempBlob: CodeUnit "Temp Blob";
        varBase64Conversion: CodeUnit "Base64 Convert";
        OStream: OutStream;
        RecRef: RecordRef;
        IStream: InStream;
        DivProg: Record "Dividends Progression";
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('year', year);

        IF GetMemberRecord(SearchMember, identifier_type.AsValue.AsText, identifier.AsValue.AsText, '') then begin



            DivProg.Reset();
            DivProg.SetRange("Member No", SearchMember."no.");
            if DivProg.FindFirst() then begin

                DivSlipReport.SetTableview(DivProg);
                varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);
                DivSlipReport.SaveAs('', REPORTFORMAT::Pdf, OStream);
                varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
                vConvertedContent := varBase64Conversion.ToBase64(IStream);

                Datum.Add('pdf', vConvertedContent);

            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Dividend Slip  NOT found for the given member');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure GetDividendSlipYears(Payload: JsonObject): Text
    var
        account_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        year: JsonToken;
        SaccoSetup: Record "Sacco Setup";

        SearchMember: Record Members;

        Count: Integer;
        TotalCharges: Decimal;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Transactions: JsonArray;
        Transaction: JsonObject;
        Datum: JsonObject;
        Response: Text;

        DivProg: Record "Dividends Progression";
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('year', year);

        IF GetMemberRecord(SearchMember, identifier_type.AsValue.AsText, identifier.AsValue.AsText, '') then begin

            SaccoSetup.Get();
            if SaccoSetup."Dividend Year Date" <> 0D then begin
                ResponseObject.Add('request_status', 'SUCCESS');

                Datum.Add('dividend_year', Format(Date2DMY(SaccoSetup."Dividend Year Date", 3)));

                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Dividend Setup missing');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    // Withdrawal ------------------------------------------------------------------------------------------------------------------
    local procedure Withdrawal(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        originator_id: JsonToken;
        pesa_type: JsonToken;
        action: JsonToken;
        command: JsonToken;
        // sensitivity: JsonToken;
        // charge: JsonToken;
        // identifier_type: JsonToken;
        // identifier: JsonToken;

        // Initiator
        transaction_initiator_details_identifier_type: JsonToken;
        transaction_initiator_details_identifier: JsonToken;
        transaction_initiator_details_account: JsonToken;
        transaction_initiator_details_name: JsonToken;
        transaction_initiator_details_reference: JsonToken;
        transaction_initiator_details_other_details: JsonToken;
        // Source
        transaction_source_details_identifier_type: JsonToken;
        transaction_source_details_identifier: JsonToken;
        transaction_source_details_account: JsonToken;
        transaction_source_details_name: JsonToken;
        transaction_source_details_reference: JsonToken;
        transaction_source_details_other_details: JsonToken;
        // Sender
        transaction_sender_details_identifier_type: JsonToken;
        transaction_sender_details_identifier: JsonToken;
        transaction_sender_details_account: JsonToken;
        transaction_sender_details_name: JsonToken;
        transaction_sender_details_reference: JsonToken;
        transaction_sender_details_other_details: JsonToken;
        // Receiver
        transaction_receiver_details_identifier_type: JsonToken;
        transaction_receiver_details_identifier: JsonToken;
        transaction_receiver_details_account: JsonToken;
        transaction_receiver_details_name: JsonToken;
        transaction_receiver_details_reference: JsonToken;
        transaction_receiver_details_other_details: JsonToken;
        // Beneficiary
        transaction_beneficiary_details_identifier_type: JsonToken;
        transaction_beneficiary_details_identifier: JsonToken;
        transaction_beneficiary_details_account: JsonToken;
        transaction_beneficiary_details_name: JsonToken;
        transaction_beneficiary_details_reference: JsonToken;
        transaction_beneficiary_details_other_details: JsonToken;
        TransType: enum "Sky M-Banking Trans Types";
        amount: JsonToken;
        transaction_description: JsonToken;
        category: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        source_application: JsonToken;
        transaction_date_time: JsonToken;

        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        MpesaTrans: Record "Sky M-Banking Transactions";
        SourceSavingsAccount: Record "Savings Accounts";
        InitiatorMember: Record Members;
        SavingsProduct: Record "Product Setup";
        IsSourceAccActive: Boolean;
        theSMS: Text;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('pesa_type', pesa_type);
        Payload.Get('action', action);
        Payload.Get('command', command);
        // Payload.Get('sensitivity', sensitivity);
        // Payload.Get('charge', charge);
        // Payload.Get('identifier_type', identifier_type);
        // Payload.Get('identifier', identifier);

        Payload.SelectToken('$.transaction_initiator_details.identifier_type', transaction_initiator_details_identifier_type);
        Payload.SelectToken('$.transaction_initiator_details.identifier', transaction_initiator_details_identifier);
        Payload.SelectToken('$.transaction_initiator_details.account', transaction_initiator_details_account);
        Payload.SelectToken('$.transaction_initiator_details.name', transaction_initiator_details_name);
        Payload.SelectToken('$.transaction_initiator_details.reference', transaction_initiator_details_reference);
        Payload.SelectToken('$.transaction_initiator_details.other_details', transaction_initiator_details_other_details);

        Payload.SelectToken('$.transaction_source_details.identifier_type', transaction_source_details_identifier_type);
        Payload.SelectToken('$.transaction_source_details.identifier', transaction_source_details_identifier);
        Payload.SelectToken('$.transaction_source_details.account', transaction_source_details_account);
        Payload.SelectToken('$.transaction_source_details.name', transaction_source_details_name);
        Payload.SelectToken('$.transaction_source_details.reference', transaction_source_details_reference);
        Payload.SelectToken('$.transaction_source_details.other_details', transaction_source_details_other_details);

        Payload.SelectToken('$.transaction_sender_details.identifier_type', transaction_sender_details_identifier_type);
        Payload.SelectToken('$.transaction_sender_details.identifier', transaction_sender_details_identifier);
        Payload.SelectToken('$.transaction_sender_details.account', transaction_sender_details_account);
        Payload.SelectToken('$.transaction_sender_details.name', transaction_sender_details_name);
        Payload.SelectToken('$.transaction_sender_details.reference', transaction_sender_details_reference);
        Payload.SelectToken('$.transaction_sender_details.other_details', transaction_sender_details_other_details);

        Payload.SelectToken('$.transaction_receiver_details.identifier_type', transaction_receiver_details_identifier_type);
        Payload.SelectToken('$.transaction_receiver_details.identifier', transaction_receiver_details_identifier);
        Payload.SelectToken('$.transaction_receiver_details.account', transaction_receiver_details_account);
        Payload.SelectToken('$.transaction_receiver_details.name', transaction_receiver_details_name);
        Payload.SelectToken('$.transaction_receiver_details.reference', transaction_receiver_details_reference);
        Payload.SelectToken('$.transaction_receiver_details.other_details', transaction_receiver_details_other_details);

        Payload.SelectToken('$.transaction_beneficiary_details.identifier_type', transaction_beneficiary_details_identifier_type);
        Payload.SelectToken('$.transaction_beneficiary_details.identifier', transaction_beneficiary_details_identifier);
        Payload.SelectToken('$.transaction_beneficiary_details.account', transaction_beneficiary_details_account);
        Payload.SelectToken('$.transaction_beneficiary_details.name', transaction_beneficiary_details_name);
        Payload.SelectToken('$.transaction_beneficiary_details.reference', transaction_beneficiary_details_reference);
        Payload.SelectToken('$.transaction_beneficiary_details.other_details', transaction_beneficiary_details_other_details);

        Payload.Get('amount', amount);
        Payload.Get('transaction_description', transaction_description);
        Payload.Get('category', category);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('source_application', source_application);
        Payload.Get('transaction_date_time', transaction_date_time);

        GetMemberRecord(InitiatorMember, transaction_initiator_details_identifier_type.AsValue.AsText, transaction_initiator_details_identifier.AsValue.AsText, '');

        // if not GlobalFunctions.CheckMemberSubflagTransactionAbility(InitiatorMember."No.") then begin
        //     ResponseObject.Add('request_status', 'BLOCKED');
        //     Datum.Add('error_message', 'The member is NOT allowed to transact. Current sub-flag status is ' + Format(InitiatorMember.Subflag));
        //     ResponseObject.Add('response_payload', Datum);

        //     AddDateTimeToResponse(ResponseObject);

        //     ResponseObject.WriteTo(Response);

        //     exit(Response);
        // end;

        // Validations
        if amount.AsValue.AsDecimal <= 0 then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Transaction amount must be greater than zero');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        // DUPLICATE
        MobileWithdrawalsBuffer.Reset;
        MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Trace ID", originator_id.AsValue.AsText);
        if MobileWithdrawalsBuffer.FindFirst then begin
            ResponseObject.Add('request_status', 'DUPLICATE');
            Datum.Add('error_message', 'This transaction already exists. Originator ID = ' + MobileWithdrawalsBuffer."Trace ID");
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // INVALID_ACCOUNT
        SourceSavingsAccount.Reset;
        SourceSavingsAccount.SetRange("No.", transaction_source_details_account.AsValue.AsText);
        if not SourceSavingsAccount.FindFirst then begin
            ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
            Datum.Add('error_message', 'Account with identifier number ' + transaction_source_details_account.AsValue.AsText + ' does not exist!');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end else begin
            // Is withdrawable?
            SavingsProduct.Reset;
            SavingsProduct.SetRange("Product ID", SourceSavingsAccount."Product Type");
            if SavingsProduct.FindFirst then begin
                if (SavingsProduct."Product Category" <> SavingsProduct."Product Category"::"Ordinary Savings") then begin
                    ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                    Datum.Add('error_message', 'Account with identifier number ' + transaction_source_details_account.AsValue.AsText + ' is NOT withdrawable!');
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end;

            // Does it belong to the member?
            if SourceSavingsAccount."Member No." <> InitiatorMember."No." then begin
                ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                Datum.Add('error_message', 'Account with identifier number ' + transaction_source_details_account.AsValue.AsText + ' does NOT belong to the given member');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // Is it active?
            case SourceSavingsAccount.Status of
                SourceSavingsAccount.Status::Active:
                    IsSourceAccActive := true;
                else
                    IsSourceAccActive := false;
            end;

            if not IsSourceAccActive then begin
                ResponseObject.Add('request_status', 'ACCOUNT_NOT_ACTIVE');
                Datum.Add('error_message', 'Account with identifier number ' + transaction_source_details_account.AsValue.AsText + ' is NOT active. Current status is ' + Format(SourceSavingsAccount.Status));
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // BLOCKED
            if (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::All) OR
            (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::Payment) then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Account with identifier number ' + transaction_source_details_account.AsValue.AsText + ' is blocked from withdrawal transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // INSUFFICIENT_BAL
            if SkyMbankingTrans.InsufficientAccountBalance(
                amount.AsValue.AsDecimal,
                SourceSavingsAccount,
                category.AsValue.AsText,
                InitiatorMember
            )
             then begin
                ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                Datum.Add('error_message', 'Account has insufficient balance to complete the transaction.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // WITHDRAWAL_LIMIT_VIOLATION
            if (SavingsProduct."Mobile Withdrawal Daily Limit" > 0) then begin
                if amount.AsValue.AsDecimal() > SavingsProduct."Mobile Withdrawal Daily Limit" then begin

                    ResponseObject.Add('request_status', 'WITHDRAWAL_LIMIT_VIOLATION');
                    Datum.Add('error_message', 'The requested transaction amount exceeds the maximum withdrawal limit of KES ' + Format(SavingsProduct."Mobile Withdrawal Daily Limit"));
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end;
            if (SavingsProduct."Mobile Withdrawal Trans Limit" > 0) then begin
                if amount.AsValue.AsDecimal() > SavingsProduct."Mobile Withdrawal Trans Limit" then begin

                    ResponseObject.Add('request_status', 'WITHDRAWAL_LIMIT_VIOLATION');
                    Datum.Add('error_message', 'The requested transaction amount exceeds the maximum withdrawal limit of KES ' + Format(SavingsProduct."Mobile Withdrawal Trans Limit"));
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end;
        end;

        // Log the transaction

        Payload.SelectToken('$.transaction_source_details.identifier_type', transaction_source_details_identifier_type);
        Payload.SelectToken('$.transaction_source_details.identifier', transaction_source_details_identifier);
        Payload.SelectToken('$.transaction_source_details.account', transaction_source_details_account);
        Payload.SelectToken('$.transaction_source_details.name', transaction_source_details_name);
        Payload.SelectToken('$.transaction_source_details.reference', transaction_source_details_reference);
        Payload.SelectToken('$.transaction_source_details.other_details', transaction_source_details_other_details);

        Payload.Get('amount', amount);
        Payload.Get('transaction_description', transaction_description);
        Payload.Get('category', category);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('source_application', source_application);
        Payload.Get('transaction_date_time', transaction_date_time);


        GetMobileCharge(TransType::"Mpesa Withdrawal", amount.AsValue.AsDecimal, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);


        MobileWithdrawalsBuffer.Init;
        MobileWithdrawalsBuffer."Reference No" := originator_id.AsValue.AsText;
        MobileWithdrawalsBuffer."Trace ID" := originator_id.AsValue.AsText;
        MobileWithdrawalsBuffer."Posting Date" := Dt2Date(CurrentDatetime);

        MobileWithdrawalsBuffer."Account No" := transaction_source_details_account.AsValue.AsText();
        MobileWithdrawalsBuffer.Description := CopyStr(transaction_description.AsValue.AsText(), 1, 50);
        MobileWithdrawalsBuffer."Unit ID" := 'M-PESA';
        MobileWithdrawalsBuffer."Transaction Type" := 'Withdrawal';
        MobileWithdrawalsBuffer."Transaction Date" := Dt2Date(CurrentDatetime);
        MobileWithdrawalsBuffer."Transaction Time" := Time;//Dt2Time(CurrentDatetime);
        MobileWithdrawalsBuffer.Source := MobileWithdrawalsBuffer.Source::"M-PESA";
        MobileWithdrawalsBuffer."Total Charges" := TotalCharge + ExciseDutyFee;
        MobileWithdrawalsBuffer."Transaction Amount" := amount.AsValue.AsDecimal;
        MobileWithdrawalsBuffer."Amount" := amount.AsValue.AsDecimal + MobileWithdrawalsBuffer."Total Charges";

        if MobileWithdrawalsBuffer."Amount" <= MemberActivities.GetAccountBalance(MobileWithdrawalsBuffer."Account No") then begin
            MobileWithdrawalsBuffer.Insert;

            SkyMbankingTrans.LogWithdrawalRequest(MpesaTrans, Payload, APIRequestID);
            ResponseObject.Add('request_status', 'SUCCESS');

            Datum.Add('transaction_reference', MobileWithdrawalsBuffer."Trace ID");
            Datum.Add('transaction_status_description', 'Withdrawal processed successfully');
            Datum.Add('transaction_status_date_time', ddMMyyyyTime(CurrentDateTime));

            ResponseObject.Add('response_payload', Datum);
        end
        else begin

            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
            Datum.Add('error_message', 'Account has insufficient balance to complete the transaction with charges.');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;


        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure WithdrawalResult(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        originator_id: JsonToken;
        transaction_status: JsonToken;
        transaction_status_description: JsonToken;

        // Beneficiary
        transaction_beneficiary_details_identifier_type: JsonToken;
        transaction_beneficiary_details_identifier: JsonToken;
        transaction_beneficiary_details_name: JsonToken;
        transaction_beneficiary_details_other_details: JsonToken;

        beneficiary_reference: JsonToken;
        transaction_date_time: JsonToken;

        MpesaTrans: Record "Sky M-Banking Transactions";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('transaction_status', transaction_status);
        Payload.Get('transaction_status_description', transaction_status_description);

        Payload.SelectToken('$.transaction_beneficiary_details.identifier_type', transaction_beneficiary_details_identifier_type);
        Payload.SelectToken('$.transaction_beneficiary_details.identifier', transaction_beneficiary_details_identifier);
        Payload.SelectToken('$.transaction_beneficiary_details.name', transaction_beneficiary_details_name);
        Payload.SelectToken('$.transaction_beneficiary_details.other_details', transaction_beneficiary_details_other_details);

        Payload.Get('beneficiary_reference', beneficiary_reference);
        Payload.Get('transaction_date_time', transaction_date_time);

        // Check initial withdrawal request exists
        MpesaTrans.Reset;
        MpesaTrans.SetRange("Originator ID", originator_id.AsValue.AsText);
        // MpesaTrans.SetRange("Transaction ID", originator_id.AsValue.AsText);
        if MpesaTrans.FindFirst then begin

            if MpesaTrans.Posted then begin
                ResponseObject.Add('request_status', 'DUPLICATE');

                Datum.Add('transaction_status', 'DUPLICATE');
                Datum.Add('transaction_status_description', 'Transaction with Originator ID ' + originator_id.AsValue.AsText + ' has already been posted');
                Datum.Add('transaction_status_date_time', ddMMyyyyTime(CurrentDateTime));

                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                //SkyMbankingTrans.PostWithdrawalTransaction(MpesaTrans."Transaction ID");
                exit(Response);
            end else begin
                SkyMbankingTrans.ProcessWithdrawalResult(Payload, APIRequestID, MpesaTrans);

                ResponseObject.Add('request_status', 'SUCCESS');

                Datum.Add('transaction_status', 'SUCCESS');
                Datum.Add('transaction_status_description', 'Result processed successfully');
                Datum.Add('transaction_status_date_time', ddMMyyyyTime(CurrentDateTime));

                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);

                //SkyMbankingTrans.PostWithdrawalTransaction(MpesaTrans."Transaction ID");
                exit(Response);
            end;
        end else begin
            ResponseObject.Add('request_status', 'FAILED');

            Datum.Add('transaction_status', 'FAILED');
            Datum.Add('transaction_status_description', 'Transaction with Originator ID ' + originator_id.AsValue.AsText + ' does not exist!');
            Datum.Add('transaction_status_date_time', ddMMyyyyTime(CurrentDateTime));

            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        ResponseObject.Add('request_status', 'ERROR');

        Datum.Add('transaction_status', 'ERROR');
        Datum.Add('transaction_status_description', 'Error. Unable to process the transaction at the moment');
        Datum.Add('transaction_status_date_time', ddMMyyyyTime(CurrentDateTime));

        ResponseObject.Add('response_payload', Datum);

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    // IFT -------------------------------------------------------------------------------------------------------------------------
    local procedure IFTAccountToAccount(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        originator_id: JsonToken;

        identifier_type: JsonToken;
        identifier: JsonToken;
        source_account: JsonToken;

        destination_account: JsonToken;
        amount: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        source_application: JsonToken;
        transaction_description: JsonToken;
        transaction_date_time: JsonToken;

        InitiatorMember: Record Members;
        SourceSavingsAccount: Record "Savings Accounts";
        IsSourceAccActive: Boolean;
        DestinationSavingsAccount: Record "Savings Accounts";
        IsDestinationAccActive: Boolean;
        SavingsProduct: Record "Product Setup";
        MpesaTrans: Record "Sky M-Banking Transactions";
        TotalCharges: Decimal;
        currCharges: List of [decimal];

        IsSharesTrading: Boolean;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('source_account', source_account);
        Payload.Get('destination_account', destination_account);
        Payload.Get('amount', amount);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('source_application', source_application);
        Payload.Get('transaction_description', transaction_description);
        Payload.Get('transaction_date_time', transaction_date_time);

        GetMemberRecord(
           InitiatorMember,
           identifier_type.AsValue.AsText,
           identifier.AsValue.AsText,
           'Transaction initiator');

        // if not GlobalFunctions.CheckMemberSubflagTransactionAbility(InitiatorMember."No.") then begin
        //     // Support shares trading
        //     if InitiatorMember.Subflag <> InitiatorMember.Subflag::Withdrawal then begin
        //         ResponseObject.Add('request_status', 'BLOCKED');
        //         Datum.Add('error_message', 'The member is NOT allowed to transact. Current sub-flag status is ' + Format(InitiatorMember.Subflag));
        //         ResponseObject.Add('response_payload', Datum);

        //         AddDateTimeToResponse(ResponseObject);

        //         ResponseObject.WriteTo(Response);

        //         exit(Response);
        //     end;
        // end;

        // Validations
        if amount.AsValue.AsDecimal <= 0 then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Transaction amount must be greater than zero');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        if source_account.AsValue.AsText = destination_account.AsValue.AsText then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Source account and destination account must be different');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        // DUPLICATE / IFT_REQUEST_EXISTS
        MpesaTrans.Reset;
        MpesaTrans.SetRange(MpesaTrans."Originator ID", originator_id.AsValue.AsText);
        MpesaTrans.SetLoadFields("Originator ID");
        if MpesaTrans.FindFirst then begin
            ResponseObject.Add('request_status', 'IFT_REQUEST_EXISTS');
            Datum.Add('error_message', 'This transaction already exists. Originator ID = ' + MpesaTrans."Originator ID");
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            //Process transaction
            //SkyMbankingTrans.PostAccountTransferTransaction(MpesaTrans."Transaction ID");
            exit(Response);
        end;

        MpesaTrans.Reset;
        MpesaTrans.SetRange(MpesaTrans."Transaction Source Reference", source_reference.AsValue.AsText);
        MpesaTrans.SetLoadFields("Transaction Source Reference");
        if MpesaTrans.FindFirst then begin
            ResponseObject.Add('request_status', 'IFT_REQUEST_EXISTS');
            Datum.Add('error_message', 'This transaction already exists. Transaction Source Reference = ' + MpesaTrans."Transaction Source Reference");
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;
        // Source Account
        SourceSavingsAccount.Reset;
        SourceSavingsAccount.SetRange("No.", source_account.AsValue.AsText);
        if not SourceSavingsAccount.FindFirst then begin
            // ACCOUNT_NOT_FOUND
            ResponseObject.Add('request_status', 'ACCOUNT_NOT_FOUND');
            Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' does not exist!');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end else begin
            // Is withdrawable?
            SavingsProduct.Reset;
            SavingsProduct.SetRange("Product ID", SourceSavingsAccount."Product Type");
            if SavingsProduct.FindFirst then begin
                // Determine if it is shares trading process
                if SavingsProduct."Product Category" = SavingsProduct."Product Category"::"Share Capital" then begin
                    IsSharesTrading := true;
                end;

                if (SavingsProduct."Product Category" <> SavingsProduct."Product Category"::"Ordinary Savings")
            then begin
                    ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                    Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' is NOT withdrawable!');
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end;

            // Does it belong to the member?
            if SourceSavingsAccount."Member No." <> InitiatorMember."No." then begin
                ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' does NOT belong to the given member');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // Is it active?
            case SourceSavingsAccount.Status of
                SourceSavingsAccount.Status::Active, SourceSavingsAccount.Status::New:
                    IsSourceAccActive := true;
                else
                    IsSourceAccActive := false;
            end;

            if IsSharesTrading then begin
                IsSourceAccActive := true;
            end;


            if not IsSourceAccActive then begin
                ResponseObject.Add('request_status', 'ACCOUNT_NOT_ACTIVE');
                Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' is NOT active. Current status is ' + Format(SourceSavingsAccount.Status));
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // BLOCKED
            if (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::All) OR
            (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::Payment) then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' is blocked from withdrawal transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            GetMobileCharge(TransType::"Account Transfer", amount.AsValue.AsDecimal, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);

            // INSUFFICIENT_BAL
            if SkyMbankingTrans.InsufficientAccountBalance(
                amount.AsValue.AsDecimal + totalCharge,
                SourceSavingsAccount,
                'IFT_ACCOUNT_TO_ACCOUNT',
                InitiatorMember
            ) then begin
                ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                Datum.Add('error_message', 'Account has insufficient balance to complete the transaction.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        // Destination Account
        DestinationSavingsAccount.Reset;
        DestinationSavingsAccount.SetRange("No.", destination_account.AsValue.AsText);

        DestinationSavingsAccount.SetLoadFields(
            "Product Type", Blocked
        );
        if not DestinationSavingsAccount.FindFirst then begin
            // ACCOUNT_NOT_FOUND
            ResponseObject.Add('request_status', 'ACCOUNT_NOT_FOUND');
            Datum.Add('error_message', 'Destination account with identifier number ' + destination_account.AsValue.AsText + ' does not exist!');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end else begin
            // Is depositable?
            SavingsProduct.Reset;
            SavingsProduct.SetRange("Product ID", DestinationSavingsAccount."Product Type");

            if SavingsProduct.FindFirst then begin
                // Destination account must be share capital for shares trading process!
                if IsSharesTrading then begin
                    if SavingsProduct."Product Category" <> SavingsProduct."Product Category"::"Share Capital" then begin
                        ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                        Datum.Add('error_message', 'Destination account with identifier number ' + destination_account.AsValue.AsText + ' must be a share capital account!');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;


            end;

            // Is it active?
            // case DestinationSavingsAccount.Status of
            //     DestinationSavingsAccount.Status::Active, DestinationSavingsAccount.Status::New:
            //         IsDestinationAccActive := true;
            //     else
            //         IsDestinationAccActive := false;
            // end;

            // if not IsDestinationAccActive then begin
            //     ResponseObject.Add('request_status', 'DEST_ACCOUNT_NOT_ACTIVE');
            //     Datum.Add('error_message', 'Destination account with identifier number ' + destination_account.AsValue.AsText + ' is NOT active. Current status is ' + Format(DestinationSavingsAccount.Status));
            //     ResponseObject.Add('response_payload', Datum);

            //     AddDateTimeToResponse(ResponseObject);

            //     ResponseObject.WriteTo(Response);
            //     exit(Response);
            // end;

            // BLOCKED
            if (DestinationSavingsAccount.Blocked = DestinationSavingsAccount.Blocked::All) then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Destination account with identifier number ' + destination_account.AsValue.AsText + ' is blocked from deposit transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        // Process the request
        MpesaTrans.Reset;
        SkyMbankingTrans.LogIFTAccountToAccount(MpesaTrans, Payload, APIRequestID);

        TotalCharges := 0;

        if amount.AsValue.AsDecimal <= TotalCharges then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Transaction amount must be greater than ' + Format(TotalCharges));
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        if MpesaTrans.Insert(true) then begin
            ResponseObject.Add('request_status', 'SUCCESS');

            Datum.Add('transaction_reference', MpesaTrans."Transaction ID");
            Datum.Add('transaction_status', 'SUCCESS');
            Datum.Add('transaction_status_description', 'Internal Funds Transfer request received successfully');


            //Process transaction
            //SkyMbankingTrans.PostAccountTransferTransaction(MpesaTrans."Transaction ID");
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Unable to process the transaction at the moment');
        end;

        ResponseObject.Add('response_payload', Datum);

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure IFTLoanRepayment(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        originator_id: JsonToken;

        identifier_type: JsonToken;
        identifier: JsonToken;
        source_account: JsonToken;

        destination_account: JsonToken;
        amount: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        source_application: JsonToken;
        transaction_description: JsonToken;
        transaction_date_time: JsonToken;

        InitiatorMember: Record Members;
        SourceSavingsAccount: Record "Savings Accounts";
        IsSourceAccActive: Boolean;
        DestinationLoanAccount: Record Loans;
        IsDestinationAccActive: Boolean;
        SavingsProduct: Record "Product Setup";
        MpesaTrans: Record "Sky M-Banking Transactions";
        TotalCharges: Decimal;
        currCharges: List of [decimal];

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('source_account', source_account);
        Payload.Get('destination_account', destination_account);
        Payload.Get('amount', amount);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('source_application', source_application);
        Payload.Get('transaction_description', transaction_description);
        Payload.Get('transaction_date_time', transaction_date_time);

        GetMemberRecord(
            InitiatorMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            'Transaction initiator');

        // if not GlobalFunctions.CheckMemberSubflagTransactionAbility(InitiatorMember."No.") then begin
        //     ResponseObject.Add('request_status', 'BLOCKED');
        //     Datum.Add('error_message', 'The member is NOT allowed to transact. Current sub-flag status is ' + Format(InitiatorMember.Subflag));
        //     ResponseObject.Add('response_payload', Datum);

        //     AddDateTimeToResponse(ResponseObject);

        //     ResponseObject.WriteTo(Response);

        //     exit(Response);
        // end;

        // Validations
        if amount.AsValue.AsDecimal <= 0 then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Transaction amount must be greater than zero');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        // DUPLICATE / IFT_REQUEST_EXISTS
        MpesaTrans.Reset;
        MpesaTrans.SetRange(MpesaTrans."Originator ID", originator_id.AsValue.AsText);
        MpesaTrans.SetLoadFields("Originator ID");
        if MpesaTrans.FindFirst then begin
            ResponseObject.Add('request_status', 'IFT_REQUEST_EXISTS');
            Datum.Add('error_message', 'This transaction already exists. Originator ID = ' + MpesaTrans."Originator ID");
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            //Process transaction
            //SkyMbankingTrans.PostAccountTransferTransaction(MpesaTrans."Transaction ID");
            exit(Response);
        end;


        MpesaTrans.Reset;
        MpesaTrans.SetRange(MpesaTrans."Transaction Source Reference", source_reference.AsValue.AsText);
        MpesaTrans.SetLoadFields("Transaction Source Reference");
        if MpesaTrans.FindFirst then begin
            ResponseObject.Add('request_status', 'IFT_REQUEST_EXISTS');
            Datum.Add('error_message', 'This transaction already exists. Transaction Source Reference = ' + MpesaTrans."Transaction Source Reference");
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Source Account
        SourceSavingsAccount.Reset;
        SourceSavingsAccount.SetRange("No.", source_account.AsValue.AsText);

        if not SourceSavingsAccount.FindFirst then begin
            // ACCOUNT_NOT_FOUND
            ResponseObject.Add('request_status', 'ACCOUNT_NOT_FOUND');
            Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' does not exist!');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end else begin
            // Is withdrawable?
            SavingsProduct.Reset;
            SavingsProduct.SetRange("Product ID", SourceSavingsAccount."Product Type");

            if SavingsProduct.FindFirst then begin
                if (SavingsProduct."Product Category" <> SavingsProduct."Product Category"::"Ordinary Savings")
            then begin
                    ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                    Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' is NOT withdrawable!');
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end;

            // Does it belong to the member?
            if SourceSavingsAccount."Member No." <> InitiatorMember."No." then begin
                ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' does NOT belong to the given member');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // Is it active?
            case SourceSavingsAccount.Status of
                SourceSavingsAccount.Status::Active, SourceSavingsAccount.Status::New:
                    IsSourceAccActive := true;
                else
                    IsSourceAccActive := false;
            end;

            if not IsSourceAccActive then begin
                ResponseObject.Add('request_status', 'ACCOUNT_NOT_ACTIVE');
                Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' is NOT active. Current status is ' + Format(SourceSavingsAccount.Status));
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // BLOCKED
            if (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::All) OR
            (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::Payment) then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' is blocked from withdrawal transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            GetMobileCharge(TransType::"Account Transfer", amount.AsValue.AsDecimal, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);

            // INSUFFICIENT_BAL
            if SkyMbankingTrans.InsufficientAccountBalance(
                amount.AsValue.AsDecimal + TotalCharges,
                SourceSavingsAccount,
                'IFT_LOAN_REPAYMENT',
                InitiatorMember
            ) then begin
                ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                Datum.Add('error_message', 'Account has insufficient balance to complete the transaction.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        // Destination Account - Loan
        DestinationLoanAccount.Reset;
        DestinationLoanAccount.SetRange("Loan No.", destination_account.AsValue.AsText);

        DestinationLoanAccount.SetLoadFields(Status, Posted);

        if not DestinationLoanAccount.FindFirst then begin
            // ACCOUNT_NOT_FOUND
            ResponseObject.Add('request_status', 'ACCOUNT_NOT_FOUND');
            Datum.Add('error_message', 'Loan account with identifier number ' + destination_account.AsValue.AsText + ' does not exist!');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end else begin
            // Is it active?
            case DestinationLoanAccount.Status of
                DestinationLoanAccount.Status::Approved:
                    IsDestinationAccActive := true;
                else
                    IsDestinationAccActive := false;
            end;

            if DestinationLoanAccount.Posted = false then begin
                IsDestinationAccActive := false;
            end else begin
                IsDestinationAccActive := true;
            end;

            if not IsDestinationAccActive then begin
                ResponseObject.Add('request_status', 'DEST_ACCOUNT_NOT_ACTIVE');
                Datum.Add('error_message', 'Loan account with identifier number ' + destination_account.AsValue.AsText + ' is NOT approved. Current status is ' + Format(DestinationLoanAccount.Status));
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        MpesaTrans.Reset;
        SkyMbankingTrans.LogIFTLoanRepayment(MpesaTrans, Payload, APIRequestID);

        TotalCharges := 0;

        if amount.AsValue.AsDecimal <= TotalCharges then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Transaction amount must be greater than ' + Format(TotalCharges));
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        if MpesaTrans.Insert(true) then begin
            ResponseObject.Add('request_status', 'SUCCESS');

            Datum.Add('transaction_reference', MpesaTrans."Transaction ID");
            Datum.Add('transaction_status', 'SUCCESS');
            Datum.Add('transaction_status_description', 'Internal Loan Repayment request received successfully');

            //Process transaction
            //SkyMbankingTrans.PostAccountTransferTransaction(MpesaTrans."Transaction ID");
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Unable to process the transaction at the moment');
        end;

        ResponseObject.Add('response_payload', Datum);

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    // Paybill Deposits------------------------------------------------------------------------------------------------------------
    local procedure Deposit(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        originator_id: JsonToken;
        pesa_type: JsonToken;
        action: JsonToken;
        command: JsonToken;
        sensitivity: JsonToken;
        charge: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        // Initiator
        transaction_initiator_details_identifier_type: JsonToken;
        transaction_initiator_details_identifier: JsonToken;
        transaction_initiator_details_account: JsonToken;
        transaction_initiator_details_name: JsonToken;
        transaction_initiator_details_reference: JsonToken;
        transaction_initiator_details_other_details: JsonToken;
        // Source
        transaction_source_details_identifier_type: JsonToken;
        transaction_source_details_identifier: JsonToken;
        transaction_source_details_account: JsonToken;
        transaction_source_details_name: JsonToken;
        transaction_source_details_reference: JsonToken;
        transaction_source_details_other_details: JsonToken;
        // Sender
        transaction_sender_details_identifier_type: JsonToken;
        transaction_sender_details_identifier: JsonToken;
        transaction_sender_details_account: JsonToken;
        transaction_sender_details_name: JsonToken;
        transaction_sender_details_reference: JsonToken;
        transaction_sender_details_other_details: JsonToken;
        // Receiver
        transaction_receiver_details_identifier_type: JsonToken;
        transaction_receiver_details_identifier: JsonToken;
        transaction_receiver_details_account: JsonToken;
        transaction_receiver_details_name: JsonToken;
        transaction_receiver_details_reference: JsonToken;
        transaction_receiver_details_other_details: JsonToken;
        // Beneficiary
        transaction_beneficiary_details_identifier_type: JsonToken;
        transaction_beneficiary_details_identifier: JsonToken;
        transaction_beneficiary_details_account: JsonToken;
        transaction_beneficiary_details_name: JsonToken;
        transaction_beneficiary_details_reference: JsonToken;
        transaction_beneficiary_details_other_details: JsonToken;

        amount: JsonToken;
        transaction_description: JsonToken;
        category: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        source_application: JsonToken;
        transaction_date_time: JsonToken;
        posting_date: JsonToken;

        MpesaDepositTrans: Record "Sky M-Banking Transactions";
        BeneficiarySavingsAccount: Record "Savings Accounts";
        BeneficiaryLoanAccount: Record Loans;
        IsLoanRepayment: Boolean;
        AccountOwner: record Members;
        theSMS: Text;

        ResponseObject: JsonObject;
        AccountOwnerDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin


        Payload.Get('originator_id', originator_id);
        Payload.Get('pesa_type', pesa_type);
        Payload.Get('action', action);
        Payload.Get('command', command);
        Payload.Get('sensitivity', sensitivity);
        Payload.Get('charge', charge);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);

        Payload.SelectToken('$.transaction_initiator_details.identifier_type', transaction_initiator_details_identifier_type);
        Payload.SelectToken('$.transaction_initiator_details.identifier', transaction_initiator_details_identifier);
        Payload.SelectToken('$.transaction_initiator_details.account', transaction_initiator_details_account);
        Payload.SelectToken('$.transaction_initiator_details.name', transaction_initiator_details_name);
        Payload.SelectToken('$.transaction_initiator_details.reference', transaction_initiator_details_reference);
        Payload.SelectToken('$.transaction_initiator_details.other_details', transaction_initiator_details_other_details);

        Payload.SelectToken('$.transaction_source_details.identifier_type', transaction_source_details_identifier_type);
        Payload.SelectToken('$.transaction_source_details.identifier', transaction_source_details_identifier);
        Payload.SelectToken('$.transaction_source_details.account', transaction_source_details_account);
        Payload.SelectToken('$.transaction_source_details.name', transaction_source_details_name);
        Payload.SelectToken('$.transaction_source_details.reference', transaction_source_details_reference);
        Payload.SelectToken('$.transaction_source_details.other_details', transaction_source_details_other_details);

        Payload.SelectToken('$.transaction_sender_details.identifier_type', transaction_sender_details_identifier_type);
        Payload.SelectToken('$.transaction_sender_details.identifier', transaction_sender_details_identifier);
        Payload.SelectToken('$.transaction_sender_details.account', transaction_sender_details_account);
        Payload.SelectToken('$.transaction_sender_details.name', transaction_sender_details_name);
        Payload.SelectToken('$.transaction_sender_details.reference', transaction_sender_details_reference);
        Payload.SelectToken('$.transaction_sender_details.other_details', transaction_sender_details_other_details);

        Payload.SelectToken('$.transaction_receiver_details.identifier_type', transaction_receiver_details_identifier_type);
        Payload.SelectToken('$.transaction_receiver_details.identifier', transaction_receiver_details_identifier);
        Payload.SelectToken('$.transaction_receiver_details.account', transaction_receiver_details_account);
        Payload.SelectToken('$.transaction_receiver_details.name', transaction_receiver_details_name);
        Payload.SelectToken('$.transaction_receiver_details.reference', transaction_receiver_details_reference);
        Payload.SelectToken('$.transaction_receiver_details.other_details', transaction_receiver_details_other_details);

        Payload.SelectToken('$.transaction_beneficiary_details.identifier_type', transaction_beneficiary_details_identifier_type);
        Payload.SelectToken('$.transaction_beneficiary_details.identifier', transaction_beneficiary_details_identifier);
        Payload.SelectToken('$.transaction_beneficiary_details.account', transaction_beneficiary_details_account);
        Payload.SelectToken('$.transaction_beneficiary_details.name', transaction_beneficiary_details_name);
        Payload.SelectToken('$.transaction_beneficiary_details.reference', transaction_beneficiary_details_reference);
        Payload.SelectToken('$.transaction_beneficiary_details.other_details', transaction_beneficiary_details_other_details);

        Payload.Get('amount', amount);
        Payload.Get('transaction_description', transaction_description);
        Payload.Get('category', category);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('source_application', source_application);
        Payload.Get('transaction_date_time', transaction_date_time);
        if Payload.Get('posting_date', posting_date) then;

        // Validations
        if amount.AsValue.AsDecimal <= 0 then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Transaction amount must be greater than zero');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        // DUPLICATE
        MpesaDepositTrans.Reset;
        MpesaDepositTrans.SetRange(MpesaDepositTrans."Originator ID", originator_id.AsValue.AsText);
        MpesaDepositTrans.SetLoadFields("Originator ID");
        if MpesaDepositTrans.FindFirst then begin
            ResponseObject.Add('request_status', 'DUPLICATE');
            Datum.Add('error_message', 'This transaction already exists. Originator ID = ' + MpesaDepositTrans."Originator ID");
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            //SkyMbankingTrans.PostMpesaDepositsTransaction(MpesaDepositTrans."Transaction ID");
            exit(Response);
        end;

        // DUPLICATE
        MpesaDepositTrans.Reset;
        MpesaDepositTrans.SetRange(MpesaDepositTrans."Transaction Source Reference", source_reference.AsValue.AsText);
        MpesaDepositTrans.SetLoadFields("Transaction Source Reference", "Transaction ID");
        if MpesaDepositTrans.FindFirst then begin
            ResponseObject.Add('request_status', 'DUPLICATE');
            Datum.Add('error_message', 'This transaction already exists. "Source Reference" = ' + MpesaDepositTrans."Transaction Source Reference");
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            //SkyMbankingTrans.PostMpesaDepositsTransaction(MpesaDepositTrans."Transaction ID");
            exit(Response);
        end;

        // INVALID_ACCOUNT
        BeneficiarySavingsAccount.Reset;
        BeneficiarySavingsAccount.SetRange("No.", CopyStr(transaction_receiver_details_account.AsValue.AsText, 1, 20));
        BeneficiarySavingsAccount.SetLoadFields("No.");
        if not BeneficiarySavingsAccount.FindFirst then begin
            // Check if it is loan account
            BeneficiaryLoanAccount.Reset;
            BeneficiaryLoanAccount.SetRange("Loan No.", CopyStr(transaction_receiver_details_account.AsValue.AsText, 1, 20));
            BeneficiaryLoanAccount.SetLoadFields("Loan No.");
            if not BeneficiaryLoanAccount.FindFirst then begin
                // ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                // Datum.Add('error_message', 'Beneficiary account with identifier number ' + transaction_beneficiary_details_account.AsValue.AsText + ' does not exist!');
                // ResponseObject.Add('response_payload', Datum);

                // AddDateTimeToResponse(ResponseObject);

                // ResponseObject.WriteTo(Response);
                // exit(Response);
                IsLoanRepayment := false;
            end else begin
                IsLoanRepayment := true;
            end;
        end else begin
            IsLoanRepayment := false;
        end;

        // ACCOUNT_NOT_ACTIVE
        /* BeneficiarySavingsAccount.Reset;
        BeneficiarySavingsAccount.SetRange("No.", transaction_receiver_details_account.AsValue.AsText);
        BeneficiarySavingsAccount.SetRange(Status, BeneficiarySavingsAccount.Status::Closed);
        BeneficiarySavingsAccount.SetLoadFields(Status);
        if BeneficiarySavingsAccount.FindFirst then begin
            ResponseObject.Add('request_status', 'ACCOUNT_NOT_ACTIVE');
            Datum.Add('error_message', 'Account with identifier number ' + transaction_beneficiary_details_account.AsValue.AsText + ' is NOT active. Current status is ' + Format(BeneficiarySavingsAccount.Status));
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end; */

        // BLOCKED
        BeneficiarySavingsAccount.Reset;
        BeneficiarySavingsAccount.SetRange("No.", CopyStr(transaction_receiver_details_account.AsValue.AsText, 1, 20));
        BeneficiarySavingsAccount.SetFilter(Blocked, '%1', BeneficiarySavingsAccount.Blocked::All);
        BeneficiarySavingsAccount.SetLoadFields("No.");
        if BeneficiarySavingsAccount.FindFirst then begin
            ResponseObject.Add('request_status', 'BLOCKED');
            Datum.Add('error_message', 'Account with identifier number ' + transaction_receiver_details_account.AsValue.AsText + ' is blocked from deposit transactions.');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        MpesaDepositTrans.Reset;
        SkyMbankingTrans.LogDepositRequest(MpesaDepositTrans, Payload, APIRequestID, IsLoanRepayment);

        if MpesaDepositTrans.Insert(true) then begin
            ResponseObject.Add('request_status', 'SUCCESS');

            Datum.Add('transaction_reference', MpesaDepositTrans."Transaction ID");
            Datum.Add('transaction_status_description', 'Deposit processed successfully');
            Datum.Add('transaction_status_date_time', ddMMyyyyTime(CurrentDateTime));

            if IsLoanRepayment then begin
                BeneficiaryLoanAccount.Reset;
                BeneficiaryLoanAccount.SetRange("Loan No.", CopyStr(MpesaDepositTrans."Beneficiary Account", 1, 20));
                BeneficiaryLoanAccount.SetLoadFields(
                    "Loan No.", "Loan Product Type Name", "Member No."
                );

                if BeneficiaryLoanAccount.FindFirst then begin
                    Datum.Add('account_number', BeneficiaryLoanAccount."Loan No.");
                    Datum.Add('account_name', BeneficiaryLoanAccount."Loan Product Type Name");
                    Datum.Add('product_type', 'LOAN');

                    AccountOwner.Reset;
                    AccountOwner.SetRange("No.", BeneficiaryLoanAccount."Member No.");
                    if AccountOwner.FindFirst then begin
                        AccountOwnerDetails.Add('full_name', AccountOwner.Name);
                        AccountOwnerDetails.Add('mobile_number', AccountOwner."Phone No.");
                        AccountOwnerDetails.Add('id_number', AccountOwner."ID No.");

                        Datum.Add('account_owner_details', AccountOwnerDetails);

                    end;
                end;
            end else begin
                BeneficiarySavingsAccount.Reset;
                BeneficiarySavingsAccount.SetRange("No.", CopyStr(MpesaDepositTrans."Beneficiary Account", 1, 20));
                BeneficiarySavingsAccount.SetLoadFields("No.", Name, "Member No.");

                if BeneficiarySavingsAccount.FindFirst then begin
                    Datum.Add('account_number', BeneficiarySavingsAccount."No.");
                    Datum.Add('account_name', BeneficiarySavingsAccount.Name);
                    Datum.Add('product_type', 'DEPOSIT');

                    AccountOwner.Reset;
                    AccountOwner.SetRange("No.", BeneficiarySavingsAccount."Member No.");
                    if AccountOwner.FindFirst then begin
                        AccountOwnerDetails.Add('full_name', AccountOwner.Name);
                        AccountOwnerDetails.Add('mobile_number', AccountOwner."Phone No.");
                        AccountOwnerDetails.Add('id_number', AccountOwner."ID No.");

                        Datum.Add('account_owner_details', AccountOwnerDetails);

                    end;
                end else begin
                    Datum.Add('account_number', transaction_beneficiary_details_account);
                    Datum.Add('account_name', transaction_beneficiary_details_name);
                    Datum.Add('product_type', 'DEPOSIT');

                    AccountOwnerDetails.Add('full_name', '');
                    AccountOwnerDetails.Add('mobile_number', '');
                    AccountOwnerDetails.Add('id_number', '');

                    Datum.Add('account_owner_details', AccountOwnerDetails);
                end;
            end;

            ResponseObject.Add('response_payload', Datum);
            commit;
            //Process transaction
            //SkyMbankingTrans.PostMpesaDepositsTransaction(MpesaDepositTrans."Transaction ID");

        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Unable to insert MPESA transaction');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    // ---------------------------------------------------------------------------------------------------------------------------
    local procedure GetLoanTypes(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        MobileLoanProducts: Record "Product Setup";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        PresetObj: JsonObject;
        PresetArray: JsonArray;
        Response: Text;
        Found: Boolean;
        j: Integer;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);

        Found := GetMemberRecord(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF Found then begin
            MobileLoanProducts.Reset;
            MobileLoanProducts.SetRange("Product Class", MobileLoanProducts."Product Class"::Credit);
            MobileLoanProducts.SetRange("Available on Mobile", true);
            IF MobileLoanProducts.FindSet then begin
                repeat
                    Datum.Add('loan_type_id', MobileLoanProducts."Product ID");
                    Datum.Add('loan_type_name', UpperCase(MobileLoanProducts."Description"));
                    Datum.Add('loan_type_min_amount', MobileLoanProducts."Minimum Loan Amount");
                    Datum.Add('maximum_installents', MobileLoanProducts."Default Installments");
                    Datum.Add('installment_type', format(MobileLoanProducts."Mobile Installments Type"));
                    if MobileLoanProducts."Mobile Installments Type" = MobileLoanProducts."Mobile Installments Type"::Preset then begin
                        clear(PresetArray);
                        for j := 1 to MobileLoanProducts."Default Installments" do begin
                            clear(PresetObj);
                            PresetObj.Add('id', j);
                            PresetObj.Add('value', j);
                            PresetArray.Add(PresetObj);
                        end;
                        Datum.Add('installment_presets', PresetArray);
                    end;

                    Datum.Add('loan_type_max_amount', MobileLoanProducts."Maximum Loan Amount");


                    Data.Add(Datum);

                    // Reset
                    Datum.ReadFrom('{}');
                until MobileLoanProducts.Next = 0;
            end;


            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanDetails(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        LoanNoToken: JsonToken;
        IdTypeToken: JsonToken;
        IdValueToken: JsonToken;
        LoanRec: Record Loans;
        ResponseObj: JsonObject;
        DataObj: JsonObject;
        ResultText: Text;
    begin
        // Error Handling
        if not (Payload.Get('loan_number', LoanNoToken) and
                Payload.Get('identifier_type', IdTypeToken) and
                Payload.Get('identifier', IdValueToken)) then
            exit(FormatErrorResponse('Missing required payload parameters: loan_number, identifier, or identifier_type.'));

        // Set Filters
        LoanRec.Reset();
        LoanRec.SetRange("Member No.", IdValueToken.AsValue().AsText());

        // Filter by Loan No. or Application No. (Functional approach: filtering covers both possibilities)
        LoanRec.SetFilter("Loan No.", '%1|%2', LoanNoToken.AsValue().AsText(), LoanNoToken.AsValue().AsText());

        if not LoanRec.FindFirst() then
            exit(FormatErrorResponse('Loan ' + LoanNoToken.AsValue().AsText() + ' not found for this member.'));

        // Map Record to JSON
        DataObj := MapLoanToData(LoanRec);

        // Build Success Response
        ResponseObj.Add('request_status', 'SUCCESS');
        ResponseObj.Add('api_request_id', APIRequestID.AsValue().AsText());
        ResponseObj.Add('response_payload', DataObj);
        AddDateTimeToResponse(ResponseObj);

        ResponseObj.WriteTo(ResultText);
        exit(ResultText);
    end;

    local procedure MapLoanToData(Loan: Record Loans): JsonObject
    var
        Item: JsonObject;
    begin
        Item.Add('loan_no', Loan."Loan No.");
        Item.Add('product_code', Loan."Loan Product Type");
        Item.Add('product_name', Loan."Loan Product Type Name");
        Item.Add('applied_amount', Loan."Requested Amount");
        Item.Add('approved_amount', Loan."Approved Amount");
        Loan.CalcFields("Total Outstanding Balance");
        Item.Add('outstanding_balance', Loan."Total Outstanding Balance");
        Item.Add('status', Format(Loan.Status));
        Item.Add('disbursement_date', ddMMyyyy(Loan."Disbursement Date"));
        exit(Item);
    end;

    local procedure FormatErrorResponse(ErrorMessage: Text): Text
    var
        ErrorObj: JsonObject;
        Payload: JsonObject;
        FinalText: Text;
    begin
        ErrorObj.Add('request_status', 'ERROR');
        Payload.Add('error_message', ErrorMessage);
        ErrorObj.Add('response_payload', Payload);
        AddDateTimeToResponse(ErrorObj);
        ErrorObj.WriteTo(FinalText);
        exit(FinalText);
    end;

    local procedure GetLoanPurposes(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        MobileLoanPurposes: Record "Sasra Sectorial Level 2";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        Found: Boolean;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);

        Found := GetMemberRecord(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF Found then begin
            MobileLoanPurposes.Reset;
            IF MobileLoanPurposes.FindSet then begin
                repeat begin
                    Datum.Add('code', MobileLoanPurposes."Sub-Sector Level 2 Code");
                    Datum.Add('description', MobileLoanPurposes."Sub-Sector Level 2 Description");

                    Data.Add(Datum);

                    // Reset
                    Datum.ReadFrom('{}');
                end until MobileLoanPurposes.Next = 0;
            end;


            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CheckLoanLimit(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        originator_id: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_type_id: JsonToken;

        SearchMember: Record Members;
        MobileLoanProduct: Record "Product Setup";
        ExistingDepositAccounts: Record "Product Setup";
        ExistingProductFact: Record "Product Setup";
        FullyDisbursed: Record Loans;

        NetEligibleAmount: Decimal;
        ExistingNonTopupLoans: Decimal;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        Found: Boolean;
    begin
        // ----------------------------------------------------------
        // Parse payload
        // ----------------------------------------------------------
        Payload.Get('originator_id', originator_id);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_type_id', loan_type_id);

        // Reset globals used across helper calls
        GrossEligibleAmount := 0;
        RefinancingFee := 0;
        ExistingLoanBalance := 0;
        ApprovedAmt := 0;
        AmountPaid := 0;
        MonthsSinceIssue := 0;
        Reason := '';

        // ----------------------------------------------------------
        // Validate member
        // ----------------------------------------------------------
        Found := GetMemberRecord(
            SearchMember,
            identifier_type.AsValue().AsText(),
            identifier.AsValue().AsText(),
            '');

        if not Found then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message',
                'Member with identification ' +
                identifier_type.AsValue().AsText() + ' = ' +
                identifier.AsValue().AsText() + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // ----------------------------------------------------------
        // Validate loan product exists and is available on mobile
        // ----------------------------------------------------------
        MobileLoanProduct.Reset();
        MobileLoanProduct.SetRange("Product ID", loan_type_id.AsValue().AsText());
        MobileLoanProduct.SetRange("Product Class", MobileLoanProduct."Product Class"::Credit);

        if not MobileLoanProduct.FindFirst() then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message',
                'Loan product with ID = ' + loan_type_id.AsValue().AsText() + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // ----------------------------------------------------------
        // Calculate net eligible amount via helper
        // This sets the GrossEligibleAmount global as a side effect
        // ----------------------------------------------------------
        NetEligibleAmount := GetLoanEligibleAmount(
            loan_type_id.AsValue().AsText(),
            SearchMember);

        // ----------------------------------------------------------
        // PATH A: Net eligible amount is zero — member not eligible
        // ----------------------------------------------------------
        if NetEligibleAmount <= 0 then begin
            ExistingLoanBalance := GetExistingLoanBalance(
                SearchMember."No.",
                MobileLoanProduct."Product ID");

            BuildLoanLimitResponse(
                ResponseObject, Datum,
                'SUCCESS',
                MobileLoanProduct."Product ID",
                MobileLoanProduct.Description,
                0,                          // gross_eligible_amount
                ExistingLoanBalance,
                RefinancingFee,
                0,                          // processing_fee
                0,                          // net_eligible_amount
                MobileLoanProduct."Minimum Loan Amount",
                MobileLoanProduct."Maximum Loan Amount",
                Reason,
                CalcMinimumAmount(ExistingLoanBalance, RefinancingFee, 0, MobileLoanProduct."Minimum Loan Amount"));

            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // ----------------------------------------------------------
        // PATH B: Member IS eligible — calculate fees and net amount
        // ----------------------------------------------------------
        RefinancingFee := 0;
        ExistingLoanBalance := GetExistingLoanBalance(
            SearchMember."No.",
            MobileLoanProduct."Product ID");

        // Calculate refinancing and processing fees
        CalcTopUpFees(
            loan_type_id.AsValue().AsText(),
            SearchMember,
            ExistingLoanBalance,
            GrossEligibleAmount,
            RefinancingFee,
            ProcessingFee);

        // ----------------------------------------------------------
        // For certain loan types: sum competing loan balances that
        // reduce the net eligible amount
        // ----------------------------------------------------------
        if NetEligibleAmount > 0 then begin
            ExistingNonTopupLoans := 0;

            if loan_type_id.AsValue().AsText() in ['SLN', 'ELN', 'EMERGENCY', 'DLN'] then begin
                ExistingNonTopupLoans := SumCompetingLoanBalances(
                    loan_type_id.AsValue().AsText(),
                    SearchMember."No.");
            end;

            ExistingLoanBalance += ExistingNonTopupLoans;
            NetEligibleAmount :=
                GrossEligibleAmount - RefinancingFee - ExistingLoanBalance - ProcessingFee;

            if NetEligibleAmount < 0 then
                NetEligibleAmount := 0;

            // Restore ExistingLoanBalance for minimum_amount calc
            ExistingLoanBalance -= ExistingNonTopupLoans;
        end;

        // ----------------------------------------------------------
        // Build success response
        // ----------------------------------------------------------
        BuildLoanLimitResponse(
            ResponseObject, Datum,
            'SUCCESS',
            MobileLoanProduct."Product ID",
            MobileLoanProduct.Description,
            GrossEligibleAmount,
            ExistingLoanBalance,
            RefinancingFee,
            ProcessingFee,
            NetEligibleAmount,
            MobileLoanProduct."Minimum Loan Amount",
            MobileLoanProduct."Maximum Loan Amount",
            Reason,
            CalcMinimumAmount(
                ExistingLoanBalance, RefinancingFee, ProcessingFee,
                MobileLoanProduct."Minimum Loan Amount"));

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure BuildLoanLimitResponse(
        var ResponseObject: JsonObject;
        var Datum: JsonObject;
        RequestStatus: Text;
        LoanTypeId: Text;
        LoanName: Text;
        GrossAmount: Decimal;
        ExistingBalance: Decimal;
        RefFee: Decimal;
        ProcFee: Decimal;
        NetAmount: Decimal;
        MinAmount: Decimal;
        MaxAmount: Decimal;
        ReasonText: Text;
        MinimumAmount: Decimal)
    begin
        ResponseObject.Add('request_status', RequestStatus);

        Datum.Add('loan_type_id', LoanTypeId);
        Datum.Add('loan_name', LoanName);
        Datum.Add('eligible_amount', NetAmount);
        Datum.Add('gross_eligible_amount', GrossAmount);
        Datum.Add('existing_loan_balance', ExistingBalance);
        Datum.Add('refinancing_fee', RefFee);
        Datum.Add('processing_fee', ProcFee);
        Datum.Add('net_eligible_amount', NetAmount);
        Datum.Add('loan_type_min_amount', MinAmount);
        Datum.Add('loan_type_max_amount', MaxAmount);
        Datum.Add('reason', ReasonText);
        Datum.Add('minimum_amount', MinimumAmount);

        ResponseObject.Add('response_payload', Datum);
    end;

    local procedure GetLoanEligibleAmount(LoanProduct: Code[20]; SearchMember: Record Members): Decimal
    var
        LoanProductSetup: Record "Product Setup";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        CurrentLoanBalance: Decimal;
        MemberCurrentShares: Decimal;
        MemberSharesRetained: Decimal;
        MinMembershipPeriod: DateFormula;
        MinLoanAmount: Decimal;
        MaxLoanAmount: Decimal;
        EligibleAmount: Decimal;
        SavingAccounts: Record "Savings Accounts";
    begin
        EligibleAmount := 0;
        GrossEligibleAmount := 0;
        Reason := '';

        SavingAccounts.Reset();
        SavingAccounts.SetRange("Member No.", SearchMember."No.");
        SavingAccounts.SetRange("Product Category", SavingAccounts."Product Category"::"Deposit Contribution");
        if SavingAccounts.FindFirst() then begin
            SavingAccounts.CalcFields("Balance (LCY)");

            MemberCurrentShares := SavingAccounts."Balance (LCY)";
            MemberSharesRetained := SavingAccounts."Balance (LCY)";
        end;
        // Allow overriding shares from product-specific rules
        GetMembersCurrentShares(MemberCurrentShares, SearchMember."No.", LoanProduct);

        // Find loan product
        LoanProductSetup.Reset();
        LoanProductSetup.SetRange("Product ID", LoanProduct);
        LoanProductSetup.SetRange("Product Class", LoanProductSetup."Product Class"::Credit);
        if not LoanProductSetup.FindFirst() then
            exit(0);

        MinLoanAmount := LoanProductSetup."Minimum Loan Amount";
        MaxLoanAmount := LoanProductSetup."Maximum Loan Amount";

        // Basic eligibility: shares retained and deposits threshold
        if not CheckBasicEligibility(SearchMember, MemberSharesRetained, MemberCurrentShares) then
            exit(0);

        // Membership period check: minimum 6 months
        Evaluate(MinMembershipPeriod, '6M');

        if SearchMember."Registration Date" = 0D then begin
            // Fall back to first ledger entry date
            SavingsLedgerEntry.Reset();
            SavingsLedgerEntry.SetCurrentKey("Entry No.");
            SavingsLedgerEntry.Ascending(false);
            SavingsLedgerEntry.SetRange("Account No.", SearchMember."No.");
            SavingsLedgerEntry.SetRange(Reversed, false);
            if SavingsLedgerEntry.FindFirst() then begin
                if CalcDate(MinMembershipPeriod, SavingsLedgerEntry."Posting Date") > Today() then begin
                    Reason := 'You must be a member for 6 months before accessing this product';
                    exit(0);
                end;
            end;
        end else begin
            if CalcDate(MinMembershipPeriod, SearchMember."Registration Date") > Today() then begin
                Reason := 'You must be a member for 6 months before accessing this product';
                exit(0);
            end;
        end;

        // Calculate gross eligible amount based on loan type
        GrossEligibleAmount := CalculateLoanAmount(
            LoanProduct,
            MemberCurrentShares,
            MinLoanAmount,
            MaxLoanAmount,
            SearchMember);

        // Get existing balance for top-up deduction
        CurrentLoanBalance := GetExistingLoanBalance(SearchMember."No.", LoanProductSetup."Product ID");

        // Net eligible = gross minus existing balance (respects top-up rules)
        EligibleAmount := CalculateNetEligibleAmount(LoanProduct, GrossEligibleAmount, CurrentLoanBalance);

        if EligibleAmount < 0 then
            EligibleAmount := 0;

        exit(EligibleAmount);
    end;

    local procedure CalculateNetEligibleAmount(
       LoanProductCode: Code[20];
       GrossAmount: Decimal;
       TotalCurrentBalance: Decimal): Decimal
    var
        NetAmount: Decimal;
    begin
        /*  if not IsTopUpAllowed(LoanProductCode) then begin
             if TotalCurrentBalance > 0 then begin
                 Reason := 'You have an existing active loan of this type. ' +
                            'Top-up not allowed for this product';
                 exit(0);
             end;
             exit(GrossAmount);
         end; */

        NetAmount := GrossAmount - TotalCurrentBalance;
        if NetAmount < 0 then
            NetAmount := 0;

        if NetAmount <= 0 then begin
            if TotalCurrentBalance >= GrossAmount then
                Reason := StrSubstNo(
                    'Your total loan balance (KES %1) meets or exceeds ' +
                    'your maximum eligible amount (KES %2)',
                    Format(TotalCurrentBalance), Format(GrossAmount))
            else
                Reason := 'You are not eligible for any additional loan amount';
            exit(0);
        end;

        exit(NetAmount);
    end;

    local procedure CheckBasicEligibility(
       SearchMember: Record Members;
       SharesRetained: Decimal;
       CurrentShares: Decimal): Boolean
    var
        MinShareCapital: Decimal;
        MinDeposits: Decimal;
    begin
        MinShareCapital := 20000.0;
        MinDeposits := 100000.0;

        if SharesRetained < MinShareCapital then begin
            Reason := 'You have insufficient share capital (minimum KES 20,000 required)';
            exit(false);
        end;

        if CurrentShares < MinDeposits then begin
            Reason := 'You have insufficient deposits (minimum KES ' +
                       Format(MinDeposits) + ' required)';
            exit(false);
        end;

        exit(true);
    end;

    local procedure IsTopUpAllowed(LoanProductCode: Code[20]): Boolean
    begin
        case LoanProductCode of
            'DLN', 'ALN', 'PLN', 'PPL':
                exit(true);
            else
                exit(false);
        end;
    end;

    local procedure CalcTopUpFees(LoanTypeID: Text; SearchMember: Record Members; ExistingBalance: Decimal; GrossAmount: Decimal; var OutRefinancingFee: Decimal; var OutProcessingFee: Decimal)
    var
        SavAccount: Record "Savings Accounts";
    begin
        OutRefinancingFee := 0;
        OutProcessingFee := 0;

        if (ExistingBalance <= 0) or (GrossAmount <= 0) then
            exit;

        AmountPaid := ApprovedAmt - ExistingBalance;

        case LoanTypeID of
            'ALN':
                begin
                    // Refinancing fee: 2% if paid < half, 1% if paid >= half
                    if AmountPaid >= (ApprovedAmt / 2) then
                        OutRefinancingFee := Round(ExistingBalance * 0.01, 0.01, '>')
                    else
                        OutRefinancingFee := Round(ExistingBalance * 0.02, 0.01, '>');

                    // Processing fee: 1% of new gross amount
                    OutProcessingFee := Round(GrossAmount * 0.01, 0.01, '>');

                    // Keep only the higher of the two fees
                    if OutRefinancingFee > OutProcessingFee then
                        OutProcessingFee := 0
                    else
                        OutRefinancingFee := 0;
                end;

            'DLN', 'DEVT':
                begin
                    SavAccount.Reset();
                    SavAccount.SetRange("Member No.", SearchMember."No.");
                    SavAccount.SetRange("Product Category", SavAccount."Product Category"::"Deposit Contribution");
                    if SavAccount.FindFirst() then begin
                        SavAccount.CalcFields("Balance (LCY)");
                        if GrossAmount > SavAccount."Balance (LCY)" then begin
                            if AmountPaid < (ApprovedAmt / 2) then
                                OutRefinancingFee := Round(ExistingBalance * 0.02, 0.01, '>')
                            else
                                OutRefinancingFee := Round(ExistingBalance * 0.01, 0.01, '>');
                        end;
                    end;

                end;

            'PLN', 'PPL':
                begin
                    SavAccount.Reset();
                    SavAccount.SetRange("Member No.", SearchMember."No.");
                    SavAccount.SetRange("Product Category", SavAccount."Product Category"::"Deposit Contribution");
                    if SavAccount.FindFirst() then begin
                        SavAccount.CalcFields("Balance (LCY)");
                        if GrossAmount > SavAccount."Balance (LCY)" then begin
                            if AmountPaid >= (ApprovedAmt / 2) then
                                OutRefinancingFee := Round(ExistingBalance * 0.01, 0.01, '>')
                            else
                                OutRefinancingFee := Round(ExistingBalance * 0.02, 0.01, '>');
                        end;
                    end;
                end;
        // All other loan types: no top-up fees
        end;
    end;

    local procedure CalculateLoanAmount(
LoanProductCode: Code[20];
CurrentShares: Decimal;
MinLoanAmount: Decimal;
MaxLoanAmount: Decimal;
SearchMember: Record Members): Decimal
    var
        ProductSetup: Record "Product Setup";
        GraduationScore: Record "Loan Graduation Score";
        GraduationCalculator: Codeunit "Loan Graduation Calculator";
        LoanMultiplier: Decimal;
        CalculatedAmount: Decimal;
        MinDepositsRequired: Decimal;
        HelaEligibleAmount: Decimal;
        FinalScore: Decimal;
    begin
        if not ProductSetup.Get(LoanProductCode) then begin
            Reason := StrSubstNo('Loan product %1 was not found in Product Setup.', LoanProductCode);
            exit(0);
        end;

        MinDepositsRequired := ProductSetup."Min. Share Deposits";

        if MinDepositsRequired > 0 then begin
            if CurrentShares < MinDepositsRequired then begin
                Reason :=
                    'You have insufficient deposits (minimum KES ' +
                    Format(MinDepositsRequired) +
                    ' required)';
                exit(0);
            end;
        end;

        case ProductSetup."Mobile Loan Calc. Method" of
            ProductSetup."Mobile Loan Calc. Method"::"Shares Multiplier":
                begin
                    LoanMultiplier := ProductSetup."Deposit Multiplier";

                    if LoanMultiplier = 0 then begin
                        Reason := StrSubstNo(
                            'Deposit multiplier is not configured for loan product %1.',
                            LoanProductCode);
                        exit(0);
                    end;

                    CalculatedAmount := CurrentShares * LoanMultiplier;

                    if CalculatedAmount < MinLoanAmount then begin
                        Reason := StrSubstNo(
                            'Calculated loan amount KES %1 is below the minimum loan amount KES %2.',
                            CalculatedAmount,
                            MinLoanAmount);
                        exit(0);
                    end;

                    if CalculatedAmount > MaxLoanAmount then
                        exit(MaxLoanAmount);

                    exit(CalculatedAmount);
                end;

            ProductSetup."Mobile Loan Calc. Method"::"Max Amount":
                begin
                    exit(MaxLoanAmount);
                end;

            ProductSetup."Mobile Loan Calc. Method"::"Graduation Score":
                begin
                    HelaEligibleAmount := GraduationCalculator.GetEligibleHelaAmount(SearchMember."No.");

                    if HelaEligibleAmount = 0 then begin
                        FinalScore := GraduationCalculator.CalculateGraduationScore(SearchMember."No.");
                        HelaEligibleAmount := GraduationCalculator.GetEligibleHelaAmount(SearchMember."No.");
                    end;

                    if HelaEligibleAmount < MinLoanAmount then begin
                        GraduationScore.Reset();
                        GraduationScore.SetRange("Member No", SearchMember."No.");
                        GraduationScore.SetCurrentKey("Member No", "Evaluation Date");
                        GraduationScore.Ascending(false);

                        if GraduationScore.FindFirst() then
                            Reason :=
                                'Your graduation score is ' +
                                Format(GraduationScore."Score Percentage", 0, '<Integer><Decimals,1>') +
                                '%. Minimum required: 50%. Eligible amount: KES ' +
                                Format(HelaEligibleAmount, 0, '<Integer><Decimals,2>')
                        else
                            Reason :=
                                'You do not qualify for this loan at this time. ' +
                                'Please improve your loan repayment history and savings consistency.';

                        exit(0);
                    end;

                    if HelaEligibleAmount > MaxLoanAmount then
                        exit(MaxLoanAmount);

                    exit(HelaEligibleAmount);
                end;

            else begin
                Reason := StrSubstNo(
                    'Mobile loan calculation method is not configured for loan product %1.',
                    LoanProductCode);
                exit(0);
            end;
        end;
    end;

    local procedure GetExistingLoanBalance(MemberNo: Code[20]; LoanProductType: Code[20]): Decimal
    var
        ActiveLoan: Record Loans;
        TotalBalance: Decimal;
    begin
        TotalBalance := 0;
        ApprovedAmt := 0;
        LoanIssueDate := 0D;

        ActiveLoan.Reset();
        ActiveLoan.SetRange("Member No.", MemberNo);
        ActiveLoan.SetRange("Loan Product Type", LoanProductType);
        ActiveLoan.SetFilter("Total Outstanding Balance", '>0');
        ActiveLoan.SetRange(Posted, true);
        ActiveLoan.SetAutoCalcFields("Total Outstanding Balance");

        if ActiveLoan.FindSet() then
            repeat
                // Track the most recent loan's issue date and approved amount
                // for fee calculations (mirrors CAL behaviour)
                LoanIssueDate := ActiveLoan."Disbursement Date";
                ApprovedAmt := ActiveLoan."Approved Amount";
                TotalBalance += ActiveLoan."Total Outstanding Balance";
            until ActiveLoan.Next() = 0;

        exit(TotalBalance);
    end;

    local procedure SumCompetingLoanBalances(LoanTypeID: Text; MemberNo: Code[20]): Decimal
    var
        CompetingProduct: Record "Product Setup";
        CompetingLoan: Record Loans;
        Total: Decimal;
    begin
        Total := 0;

        CompetingProduct.Reset();
        CompetingProduct.SetRange("Product Class", CompetingProduct."Product Class"::Credit);

        // Build the filter of competing product IDs — mirrors the CAL SETFILTER
        if LoanTypeID <> 'DLN' then
            CompetingProduct.SetFilter(
                "Product ID",
                '%1|%2|%3|%4|%5|%6|%7|%8',
                'BLN', 'DLN', 'NLN', 'SLN', 'EMERGENCY', 'BDVT', 'HELA', 'ELN')
        else
            CompetingProduct.SetFilter(
                "Product ID",
                '%1|%2|%3|%4|%5|%6|%7',
                'BLN', 'NLN', 'SLN', 'EMERGENCY', 'BDVT', 'HELA', 'ELN');

        if CompetingProduct.FindSet() then
            repeat
                CompetingLoan.Reset();
                CompetingLoan.SetRange("Member No.", MemberNo);
                CompetingLoan.SetRange("Loan Product Type", CompetingProduct."Product ID");
                CompetingLoan.SetFilter("Total Outstanding Balance", '>0');
                CompetingLoan.SetAutoCalcFields("Total Outstanding Balance");
                if CompetingLoan.FindSet() then
                    repeat
                        Total += CompetingLoan."Total Outstanding Balance";
                    until CompetingLoan.Next() = 0;
            until CompetingProduct.Next() = 0;

        exit(Total);
    end;

    local procedure GetJsonTextValue(JsonObj: JsonObject; KeyName: Text): Text
    var
        Token: JsonToken;
    begin
        if JsonObj.Get(KeyName, Token) then
            if Token.IsValue then
                exit(Token.AsValue().AsText());

        exit('');
    end;

    local procedure LoanApplication(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        originator_id: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_type_id: JsonToken;
        amount: JsonToken;
        Installmemts: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        transaction_date_time: JsonToken;
        mobile_loan_purpose: JsonToken;
        bank_name: JsonToken;
        account_number: JsonToken;
        branch: JsonToken;
        beneficiary_mobile_number: JsonToken;

        KeyExists: Boolean;
        PortalLoans: Record "Portal Loans";

        Installment: decimal;
        LoanSerial: Text[100];
        SearchMember: Record Members;
        MobileLoanProduct: Record "Product Setup";
        TheLoan: Record Loans;
        TheLoanPurposes: Record "Sasra Sectorial Level 2";
        MobileLoanPurpose: Text;
        theSMS: Text;
        Found: Boolean;
        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ErrorMsg: text[250];
        Sledger: Record "Savings Ledger Entry";
        BankNameTxt: Text;
        AccountNumberTxt: Text;
        BranchTxt: Text;
        BeneficiaryMobileNumberTxt: Text;

        loan_security: JsonToken;
        LoanSecurityArray: JsonArray;
        LoanSecurityToken: JsonToken;
        LoanSecurityObj: JsonObject;
        security_type: JsonToken;
        SecurityTypeTxt: Text;
        HasMyDeposits: Boolean;
        HasGuaranteedByOtherMembers: Boolean;
        HasHolidaySavings: Boolean;
        i: Integer;

        SkyPortal: Codeunit "Sky Portal";
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('loan_type_id', loan_type_id);
        Payload.Get('amount', amount);
        Payload.Get('installments', Installmemts);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('transaction_date_time', transaction_date_time);
        Payload.Get('bank_name', bank_name);
        Payload.Get('account_number', account_number);
        Payload.Get('branch', branch);
        Payload.Get('beneficiary_mobile_number', beneficiary_mobile_number);

        if Payload.Get('bank_name', bank_name) then
            BankNameTxt := bank_name.AsValue().AsText();

        if Payload.Get('account_number', account_number) then
            AccountNumberTxt := account_number.AsValue().AsText();

        if Payload.Get('branch', branch) then
            BranchTxt := branch.AsValue().AsText();

        if Payload.Get('beneficiary_mobile_number', beneficiary_mobile_number) then
            BeneficiaryMobileNumberTxt := beneficiary_mobile_number.AsValue().AsText();

        KeyExists := Payload.Get('mobile_loan_purpose', mobile_loan_purpose);
        if Payload.Get('loan_security', loan_security) then begin
            if loan_security.IsArray() then begin
                LoanSecurityArray := loan_security.AsArray();

                for i := 0 to LoanSecurityArray.Count() - 1 do begin
                    LoanSecurityArray.Get(i, LoanSecurityToken);

                    if LoanSecurityToken.IsObject() then begin
                        LoanSecurityObj := LoanSecurityToken.AsObject();

                        if LoanSecurityObj.Get('security_type', security_type) then begin
                            SecurityTypeTxt := UpperCase(SkyPortal.GetJsonTokenAsText(security_type));

                            case SecurityTypeTxt of
                                'MY_DEPOSITS':
                                    HasMyDeposits := true;

                                'GUARANTEED_BY_OTHER_MEMBERS':
                                    HasGuaranteedByOtherMembers := true;

                                'HOLIDAY_SAVINGS':
                                    HasHolidaySavings := true;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        MobileLoanPurpose := '';
        ErrorMsg := '';

        TheLoanPurposes.Reset;
        if TheLoanPurposes.FindFirst then begin
            MobileLoanPurpose := TheLoanPurposes."Sub-Sector Level 2 Code";
        end;
        if KeyExists then begin
            MobileLoanPurpose := mobile_loan_purpose.AsValue.AsText;
        end;

        Found := GetMemberRecord(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF Found then begin
            if CheckFOSASavingsAccountBlocked(SearchMember, 'CREDIT') then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Account is blocked from credit transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            MobileLoanProduct.Reset;
            MobileLoanProduct.SetRange("Product ID", loan_type_id.AsValue.AsText);
            MobileLoanProduct.SetRange("Available on Mobile", true);

            MobileLoanProduct.SetLoadFields(
                "Product ID", "Maximum Loan Amount", "Minimum Loan Amount"
            );

            if MobileLoanProduct.FindFirst then begin

                if MobileLoanProduct."Restrict to Emp. Code" <> '' then begin
                    if SearchMember."Employer Code" <> MobileLoanProduct."Restrict to Emp. Code" then begin
                        ErrorMsg := StrSubstNo('This loan product is restricted to a specific employer %1', SearchMember."Employer Code");
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', ErrorMsg);
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);

                    end
                end;

                if MobileLoanProduct."Restrict to Member Code" <> '' then begin
                    if SearchMember."No." <> MobileLoanProduct."Restrict to Member Code" then begin
                        ErrorMsg := StrSubstNo('This loan product is restricted to a specific member %1', SearchMember."No.");
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', ErrorMsg);
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);

                    end
                end;

                if MobileLoanProduct."Loan Type" = MobileLoanProduct."Loan Type"::Mavuno then begin

                    if SearchMember."Member Status" <> SearchMember."Member Status"::Active then begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', 'Your account is not active.');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;

                    if amount.AsValue.AsDecimal > MemberActivities.GetAccountBalance(Legacy.GetDepositAccounts(SearchMember."No.")) then begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', 'You do not qualify for this loan product');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;


                    Sledger.Reset();
                    Sledger.SetRange("Account No.", Legacy.GetDepositAccounts(SearchMember."No."));
                    Sledger.SetFilter("User ID", '<>%1', 'WANANDEGE\SKYWORLD');
                    Sledger.SetFilter("Debit Amount (LCY)", '>0');
                    if Sledger.FindFirst() then begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', 'Your deposits contributions are irregular');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;

                    TheLoan.Reset();
                    TheLoan.SetRange("Member No.", SearchMember."No.");
                    TheLoan.SetFilter("Total Outstanding Balance", '>0');
                    TheLoan.SetFilter("Loan Product Type", 'L17');
                    if TheLoan.FindFirst() then begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', 'You have an existing maisha loan.');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;

                    TheLoan.Reset();
                    TheLoan.SetRange("Member No.", SearchMember."No.");
                    TheLoan.SetFilter("Total Outstanding Balance", '>0');
                    TheLoan.SetFilter("Loans Category-SASRA", '<>%1', TheLoan."Loans Category-SASRA"::Performing);
                    if TheLoan.FindFirst() then begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', 'You have non-performing loan/s.');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;

                end;
                // Check loan Limit
                if GetLoanEligibleAmount(MobileLoanProduct."Product ID", SearchMember) < amount.AsValue.AsDecimal then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Loan amount exceeds the maximum limit allowed for the member of ' + Format(SkyMbankingTrans.GetLoansQualifyAmount(SearchMember."No.", MobileLoanProduct."Product ID")));
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
                // Check Max Appliable Amount for loan
                if amount.AsValue.AsDecimal > MobileLoanProduct."Maximum Loan Amount" then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Loan amount exceeds the maximum limit allowed for the loan product of ' + Format(MobileLoanProduct."Maximum Loan Amount"));
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
                // Check Min Appliable Amount for loan
                if amount.AsValue.AsDecimal < MobileLoanProduct."Minimum Loan Amount" then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Loan amount is less than the minimum limit allowed for the loan product of ' + Format(MobileLoanProduct."Minimum Loan Amount"));
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                TheLoan.Reset();
                TheLoan.SetRange("Member No.", SearchMember."No.");
                TheLoan.SetRange("Loan Product Type", MobileLoanProduct."Product ID");
                TheLoan.SetFilter("Total Outstanding Balance", '>0');
                TheLoan.SetAutoCalcFields("Total Outstanding Balance");
                if TheLoan.FindFirst() then begin
                    if amount.AsValue.AsDecimal < TheLoan."Total Outstanding Balance" then begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', StrSubstNo(
                                'You have an existing loan for product %1 with an outstanding balance %2. Applied amount is %3.',
                                MobileLoanProduct.Description,
                                Format(TheLoan."Total Outstanding Balance"),
                                Format(amount.AsValue.AsDecimal)
                            )
                        );
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;



                if MobileLoanProduct."Loan Type" = MobileLoanProduct."Loan Type"::"Salary In Advance" then begin

                    TheLoan.Reset();
                    TheLoan.SetRange("Member No.", SearchMember."No.");
                    TheLoan.SetRange("Loan Product Type", MobileLoanProduct."Product ID");
                    TheLoan.SetFilter("Total Outstanding Balance", '>0');
                    TheLoan.SetAutoCalcFields("Total Outstanding Balance", "Top Up Amount");
                    if TheLoan.FindFirst() then begin

                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', StrSubstNo(
                                'You have an existing loan for product %1 with an outstanding balance. Current Balance is %2.',
                                MobileLoanProduct.Description,
                                Format(TheLoan."Total Outstanding Balance")
                            )
                        );
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;

                PortalLoans.Reset();
                PortalLoans.SetRange("Member No.", SearchMember."No.");
                PortalLoans.SetRange("Loan Product Type", MobileLoanProduct."Product ID");
                PortalLoans.SetFilter("Status", '%1', PortalLoans."Status"::"Pending Guarantor Action");
                if PortalLoans.FindFirst() then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', StrSubstNo(
                            'You have an existing loan application for product %1 with status %2.',
                            MobileLoanProduct.Description,
                            Format(PortalLoans."Status")
                        )
                    );
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                LoanSerial := '';
                // if Conditions are met then create loan application
                if SkyMbankingTrans.BufferLoanApplication(
                    SearchMember."No.", MobileLoanProduct."Product ID",
                    amount.AsValue.AsDecimal,
                    source_reference.AsValue.AsText,
                    request_application.AsValue.AsText,
                    LoanSerial,
                    MobileLoanPurpose,
                    Installmemts.AsValue.AsText,
                    BankNameTxt,
                    AccountNumberTxt,
                    BranchTxt,
                    BeneficiaryMobileNumberTxt,
                    HasMyDeposits,
                    HasGuaranteedByOtherMembers,
                    HasHolidaySavings
                    ) then begin

                    Datum.Add('transaction_reference', CreateGuid());

                    Datum.Add('loan_serial_number', LoanSerial);

                    Datum.Add('loan_type_id', MobileLoanProduct."Product ID");
                    Datum.Add('loan_name', MobileLoanProduct."Description");
                    // Datum.Add('amount', 0);
                    Datum.Add('amount', amount.AsValue.AsDecimal);
                    if BankNameTxt <> '' then
                        Datum.Add('bank_name', BankNameTxt);
                    if AccountNumberTxt <> '' then
                        Datum.Add('account_number', AccountNumberTxt);
                    if BranchTxt <> '' then
                        Datum.Add('branch', BranchTxt);
                    if BeneficiaryMobileNumberTxt <> '' then
                        Datum.Add('beneficiary_mobile_number', BeneficiaryMobileNumberTxt);

                    ResponseObject.Add('request_status', 'SUCCESS');
                    ResponseObject.Add('response_payload', Datum);

                end else begin
                    ResponseObject.Add('request_status', 'FAILED');
                    Datum.Add('error_message', 'Loan creation failed');
                    ResponseObject.Add('response_payload', Datum);
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan product with ID = ' + loan_type_id.AsValue.AsText + ' NOT available for mobile application!');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoansInService(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        MemberLoans: Record Loans;
        TotalCharges: Decimal;
        currCharges: List of [decimal];
        TotalChargesIFT: Decimal;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        Found: Boolean;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);

        Found := GetMemberRecord(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF Found then begin
            MemberLoans.Reset;
            MemberLoans.SetRange("Member No.", SearchMember."No.");
            MemberLoans.SetFilter("Total Outstanding Balance", '>0');
            MemberLoans.SetAutoCalcFields(
               "Outstanding Principal", "Loans Category-SASRA", "Outstanding Interest", "Principal Arrears", "Total Outstanding Balance"
           //"Total Monthly Repayment"
           );

            IF MemberLoans.FindSet then begin
                TotalCharges := 0;

                TotalChargesIFT := 0;

                repeat begin
                    Datum.Add('loan_serial_number', MemberLoans."Loan No.");
                    Datum.Add('loan_type_id', MemberLoans."Loan Product Type");
                    Datum.Add('loan_type_name', MemberLoans."Loan Product Type Name");
                    Datum.Add('loan_amount', MemberLoans."Approved Amount");

                    Datum.Add('loan_balance', MemberLoans."Total Outstanding Balance");
                    Datum.Add('loan_repayment_charges', TotalCharges);
                    Datum.Add('total_repayment', MemberLoans."Total Monthly Repayment" + TotalCharges);

                    Datum.Add('loan_repayment_charges_ift', TotalChargesIFT);
                    Datum.Add('total_repayment_ift', MemberLoans."Outstanding Principal" + TotalChargesIFT);

                    Datum.Add('installment_amount', MemberLoans.Repayment);
                    Datum.Add('interest_amount', MemberLoans."Outstanding Interest");
                    Datum.Add('loan_defaulted_amount', MemberLoans."Principal Arrears");

                    Datum.Add('loan_issued_date', ddMMyyyy(MemberLoans."Disbursement Date"));
                    Datum.Add('loan_end_date', ddMMyyyy(MemberLoans."Completion Date"));

                    Datum.Add('loan_performance', UpperCase(Format(MemberLoans."Loans Category-SASRA")));
                    Datum.Add('loan_performance_description', Format(MemberLoans."Loans Category-SASRA"));

                    Data.Add(Datum);

                    // Reset
                    Datum.ReadFrom('{}');
                end until MemberLoans.Next = 0;
            end;


            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure LoanBalanceEnquiry(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        loan_serial_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        MemberLoan: Record Loans;
        TotalCharges: Decimal;

        SavingsAccount: Record "Savings Accounts";
        FosaAcc: Text;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;
        Found: Boolean;
    begin
        Payload.Get('loan_serial_number', loan_serial_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);

        Found := GetMemberRecord(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF Found then begin
            MemberLoan.Reset;
            MemberLoan.SetRange("Loan No.", loan_serial_number.AsValue.AsText);
            MemberLoan.SetRange("Member No.", SearchMember."No.");

            MemberLoan.SetLoadFields(
                "Loan No.", "Loan Product Type Name", "Member Name", Repayment
            );

            MemberLoan.SetAutoCalcFields(
                "Outstanding Principal", "Outstanding Interest", "Total Outstanding Balance"
            );

            if MemberLoan.FindFirst then begin
                // "loan_serial_number": "LN0239201",
                // "loan_type_name": "Development Loan",
                // "account_label": "Development(LN0239201)",
                // "loan_balance": 16000.00,
                // "installment_amount ": 10000.00,
                // "interest_amount ": 500.00
                Datum.Add('loan_serial_number', MemberLoan."Loan No.");
                Datum.Add('loan_type_name', MemberLoan."Loan Product Type Name");
                Datum.Add('account_label', MemberLoan."Member Name");
                Datum.Add('loan_balance', MemberLoan."Total Outstanding Balance");
                Datum.Add('installment_amount', MemberLoan.Repayment);
                Datum.Add('interest_amount', MemberLoan."Outstanding Interest");

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);

                GetMobileCharge(TransType::"Loan Balance Enquiry", 0, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
                TotalCharges := TotalCharge + ExciseDutyFee;
                if TotalCharges > 0 then begin
                    FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

                    SavingsAccount.Reset;
                    SavingsAccount.SetRange("No.", FosaAcc);
                    if SavingsAccount.FindFirst then begin
                        // INSUFFICIENT_BAL
                        if SkyMbankingTrans.InsufficientAccountBalance(
                            0,
                            SavingsAccount,
                            'LOAN_BALANCE_ENQUIRY',
                            SearchMember
                        ) then begin
                            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                            Datum.Add('error_message', 'FOSA Account has insufficient balance to complete the transaction.');
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;

                    if CheckFOSASavingsAccountBlocked(SearchMember, 'DEBIT') then begin
                        ResponseObject.Add('request_status', 'BLOCKED');
                        Datum.Add('error_message', 'Account is blocked from debit transactions.');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;

                    // Log the transaction
                    SkyMbankingTrans.LogLoanBalanceEnquiry(
                        APIRequestID.AsValue.AsText,
                        identifier_type.AsValue.AsText,
                        identifier.AsValue.AsText,
                        loan_serial_number.AsValue.AsText,
                        SearchMember
                    );
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan with serial number ' + loan_serial_number.AsValue.AsText + ' NOT found for the given member');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure LoanMiniStatement(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        loan_serial_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        number_of_transactions: JsonToken;

        TotalCharges: Decimal;

        SearchMember: Record Members;
        LoanAccount: Record Loans;
        CreditLedgerEntry: Record "Credit Ledger Entry";

        SavingsAccount: Record "Savings Accounts";
        FosaAcc: Text;

        Count: Integer;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Transactions: JsonArray;
        Transaction: JsonObject;
        Datum: JsonObject;
        Response: Text;
        Found: Boolean;

        Loans: Record Loans;
    begin
        Payload.Get('loan_serial_number', loan_serial_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('number_of_transactions', number_of_transactions);

        Found := GetMemberRecord(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF Found then begin
            LoanAccount.Reset;
            LoanAccount.SetRange("Loan No.", loan_serial_number.AsValue.AsText);
            LoanAccount.SetRange("Member No.", SearchMember."No.");

            LoanAccount.SetLoadFields(
                "Loan Product Type Name", "Loan No.", "Approved Amount", "Outstanding Principal", "Outstanding Interest",
                Repayment, "Total Outstanding Balance"
            );
            LoanAccount.SetAutoCalcFields(
                "Outstanding Principal", "Outstanding Interest", "Total Outstanding Balance"
            );

            if LoanAccount.FindFirst then begin
                Datum.Add('loan_name', LoanAccount."Loan Product Type Name");
                Datum.Add('loan_serial_number', LoanAccount."Loan No.");
                Datum.Add('loan_amount', LoanAccount."Approved Amount");
                Datum.Add('loan_balance', LoanAccount."Total Outstanding Balance");
                Datum.Add('installment_amount', LoanAccount.Repayment);
                Datum.Add('interest_amount', LoanAccount."Outstanding Interest");

                CreditLedgerEntry.Reset;
                CreditLedgerEntry.SetCurrentkey("Entry No.");
                CreditLedgerEntry.Ascending(false);
                CreditLedgerEntry.SetRange("Loan No.", LoanAccount."Loan No.");
                CreditLedgerEntry.SetRange(Reversed, false);
                CreditLedgerEntry.SetLoadFields(
                    "Document No.", "Posting Date", Amount, "Entry No.", Description
                );

                IF CreditLedgerEntry.FindSet then begin

                    repeat begin
                        Count += 1;

                        Loans.Reset();
                        Loans.SetRange("Loan No.", LoanAccount."Loan No.");
                        Loans.SetFilter("Date Filter", '..%1', CreditLedgerEntry."Posting Date");
                        Loans.SetAutoCalcFields("Total Outstanding Balance");
                        Loans.SetLoadFields("Total Outstanding Balance");
                        if Loans.FindFirst() then;

                        Transaction.Add('transaction_reference', CreditLedgerEntry."Document No.");
                        Transaction.Add('transaction_date', ddMMyyyy(CreditLedgerEntry."Posting Date"));
                        Transaction.Add('transaction_time', CreditLedgerEntry."Creation Time");

                        if CreditLedgerEntry.Amount > 0 then begin
                            Transaction.Add('transaction_amount', CreditLedgerEntry.Amount);
                            Transaction.Add('transaction_type', 'CREDIT');
                        end else begin
                            Transaction.Add('transaction_amount', Abs(CreditLedgerEntry.Amount));
                            Transaction.Add('transaction_type', 'DEBIT');
                        end;

                        Transaction.Add('running_balance', Loans."Total Outstanding Balance");
                        Transaction.Add('transaction_description', CreditLedgerEntry.Description);
                        Transaction.Add('other_details', CreditLedgerEntry.Description);

                        Transactions.Add(Transaction);
                        // Reset
                        Transaction.ReadFrom('{}');
                    end until (Count = number_of_transactions.AsValue.AsInteger) or (CreditLedgerEntry.Next = 0);
                end;

                Datum.Add('transactions', Transactions);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);

                GetMobileCharge(TransType::"Loan Mini-Statement", 0, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
                TotalCharges := TotalCharge + ExciseDutyFee;
                if TotalCharges > 0 then begin
                    FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

                    SavingsAccount.Reset;
                    SavingsAccount.SetRange("No.", FosaAcc);
                    if SavingsAccount.FindFirst then begin
                        // INSUFFICIENT_BAL
                        if SkyMbankingTrans.InsufficientAccountBalance(
                            0,
                            SavingsAccount,
                            'LOAN_MINI_STATEMENT',
                            SearchMember
                        ) then begin
                            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                            Datum.Add('error_message', 'FOSA Account has insufficient balance to complete the transaction.');
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;

                    if CheckFOSASavingsAccountBlocked(SearchMember, 'DEBIT') then begin
                        ResponseObject.Add('request_status', 'BLOCKED');
                        Datum.Add('error_message', 'Account is blocked from debit transactions.');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;

                    // Log the transaction
                    SkyMbankingTrans.LogLoanMiniStatement(
                        APIRequestID.AsValue.AsText,
                        identifier_type.AsValue.AsText,
                        identifier.AsValue.AsText,
                        loan_serial_number.AsValue.AsText,
                        SearchMember
                    );
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan with number ' + loan_serial_number.AsValue.AsText + ' NOT found for the given member');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure LoanFullStatementPDF(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_serial_number: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        SearchMember: Record Members;
        FullyDisbursed: Record Loans;
        LoansRegister: Record Loans;
        MobileTrans: Record "Sky M-Banking Transactions";
        GenSetup: Record "Sacco Setup";
        TempBlob1: Codeunit "Temp Blob";
        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        LoanSerialNumber: Text;
        StartDate: Date;
        EndDate: Date;
        SourceRef: Code[20];
        ReportOutStream: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
        Base64String: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_serial_number', loan_serial_number);
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);
        LoanSerialNumber := loan_serial_number.AsValue().AsText();
        StartDate := ParseDateString(start_date.AsValue().AsText());
        EndDate := ParseDateString(end_date.AsValue().AsText());
        SourceRef := CopyStr(APIRequestID.AsValue().AsText(), 1, 20);

        if not MemberExists(identifier_type.AsValue().AsText(), identifier.AsValue().AsText(), SearchMember, ResponseText, ResponseDescription) then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        FullyDisbursed.Reset();
        FullyDisbursed.SetRange("Member No.", SearchMember."No.");
        FullyDisbursed.SetRange("Loan No.", LoanSerialNumber);
        if not FullyDisbursed.FindLast() then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Loan ' + LoanSerialNumber + ' not found for this member');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        MobileTrans.Init();
        MobileTrans."Entry No." := CreateGuid();
        MobileTrans."Originator ID" := SourceRef;
        MobileTrans."Transaction ID" := SourceRef;
        MobileTrans."Session ID" := SourceRef;
        MobileTrans."Transaction Date" := Today();
        MobileTrans."Transaction Time" := Time();
        MobileTrans."Source Account" := SearchMember."No.";
        MobileTrans."Account to Check" := CopyStr(SearchMember."No.", 1, 50);
        MobileTrans."Transaction Type" := MobileTrans."Transaction Type"::"Loan Full-Statement";
        MobileTrans.Insert(true);

        LoansRegister.Reset();
        LoansRegister.SetRange("Member No.", SearchMember."No.");
        LoansRegister.SetRange("Loan No.", LoanSerialNumber);
        if EndDate <> 0D then
            LoansRegister.SetFilter("Date filter", '%1..%2', StartDate, EndDate);

        if LoansRegister.FindFirst() then begin
            // ← Replaced file path approach with in-memory stream
            TempBlob1.CreateOutStream(ReportOutStream);
            Report.SaveAs(Report::"Loan Statement", '', ReportFormat::Pdf, ReportOutStream, LoansRegister);
            Base64String := Base64Convert.ToBase64(TempBlob1.CreateInStream());
            ResponseObject.Add('request_status', 'SUCCESS');
            Datum.Add('loan_pdf', Base64String);
        end else begin
            ResponseObject.Add('request_status', 'SUCCESS');
            Datum.Add('loan_pdf', '');
        end;

        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure LoanFullStatement(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        loan_serial_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;

        SearchMember: Record Members;
        LoanAccount: Record Loans;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        TotalCharges: Decimal;

        FosaAcc: Text;
        SavingsAccount: record "Savings Accounts";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Transactions: JsonArray;
        Transaction: JsonObject;
        Datum: JsonObject;
        Response: Text;
        Found: Boolean;
    begin
        Payload.Get('loan_serial_number', loan_serial_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        Found := GetMemberRecord(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF Found then begin
            LoanAccount.Reset;
            LoanAccount.SetRange("Loan No.", loan_serial_number.AsValue.AsText);
            LoanAccount.SetRange("Member No.", SearchMember."No.");

            LoanAccount.SetLoadFields(
                "Loan Product Type Name", "Loan No.", "Approved Amount", "Outstanding Principal", "Outstanding Interest",
                Repayment, "Total Outstanding Balance"
                );
            LoanAccount.SetAutoCalcFields(
                "Outstanding Principal", "Outstanding Interest", "Total Outstanding Balance"
            );

            if LoanAccount.FindFirst then begin
                Datum.Add('account_holder', LoanAccount."Member Name");
                Datum.Add('loan_name', LoanAccount."Loan Product Type Name");
                Datum.Add('loan_serial_number', LoanAccount."Loan No.");
                Datum.Add('loan_amount', LoanAccount."Approved Amount");
                Datum.Add('loan_balance', LoanAccount."Total Outstanding Balance");
                Datum.Add('installment_amount', LoanAccount.Repayment + LoanAccount."Deposit COntribution" + LoanAccount."Total Insurance");
                Datum.Add('interest_amount', LoanAccount."Outstanding Interest");

                CreditLedgerEntry.Reset;
                CreditLedgerEntry.SetCurrentkey("Entry No.");
                CreditLedgerEntry.Ascending(false);
                CreditLedgerEntry.SetRange("Loan No.", LoanAccount."Loan No.");
                CreditLedgerEntry.SetRange(Reversed, false);
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));

                CreditLedgerEntry.SetFilter("Posting Date", '>=%1&<=%2', StartDate, EndDate);

                CreditLedgerEntry.SetLoadFields(
                    "Document No.", "Posting Date", Amount, "Entry No.", Description
                );


                IF CreditLedgerEntry.FindSet then begin
                    repeat begin
                        Transaction.Add('transaction_reference', CreditLedgerEntry."Document No.");
                        Transaction.Add('transaction_date', ddMMyyyy(CreditLedgerEntry."Posting Date"));
                        Transaction.Add('transaction_time', CreditLedgerEntry."Creation Time");

                        if CreditLedgerEntry.Amount > 0 then begin
                            Transaction.Add('transaction_amount', CreditLedgerEntry.Amount);
                            Transaction.Add('transaction_type', 'CREDIT');
                        end else begin
                            Transaction.Add('transaction_amount', Abs(CreditLedgerEntry.Amount));
                            Transaction.Add('transaction_type', 'DEBIT');
                        end;

                        Transaction.Add('running_balance', LoanAccount."Total Outstanding Balance");
                        Transaction.Add('transaction_description', CreditLedgerEntry.Description);
                        Transaction.Add('other_details', CreditLedgerEntry.Description);

                        Transactions.Add(Transaction);
                        // Reset
                        Transaction.ReadFrom('{}');
                    end until (CreditLedgerEntry.Next = 0);
                end;

                Datum.Add('transactions', Transactions);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);

                GetMobileCharge(TransType::"Loan Full-Statement", 0, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
                TotalCharges := TotalCharge + ExciseDutyFee;
                if TotalCharges > 0 then begin
                    FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

                    SavingsAccount.Reset;
                    SavingsAccount.SetRange("No.", FosaAcc);
                    if SavingsAccount.FindFirst then begin
                        // INSUFFICIENT_BAL
                        if SkyMbankingTrans.InsufficientAccountBalance(
                            0,
                            SavingsAccount,
                            'LOAN_FULL_STATEMENT',
                            SearchMember
                        ) then begin
                            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                            Datum.Add('error_message', 'FOSA Account has insufficient balance to complete the transaction.');
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;

                    if CheckFOSASavingsAccountBlocked(SearchMember, 'DEBIT') then begin
                        ResponseObject.Add('request_status', 'BLOCKED');
                        Datum.Add('error_message', 'Account is blocked from debit transactions.');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;

                    // Log the transaction
                    SkyMbankingTrans.LogLoanFullStatement(
                        APIRequestID.AsValue.AsText,
                        identifier_type.AsValue.AsText,
                        identifier.AsValue.AsText,
                        loan_serial_number.AsValue.AsText,
                        SearchMember
                    );
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan with number ' + loan_serial_number.AsValue.AsText + ' NOT found for the given member');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetCharges(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        account_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        charge_action: JsonToken;
        amount: JsonToken;

        SearchMember: Record Members;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;
        Found: Boolean;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('account_number', account_number);
        Payload.Get('charge_action', charge_action);
        Payload.Get('amount', amount);


        Found := GetMemberRecord(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF Found then begin
            GetTransChargesPreview(charge_action.AsValue.AsText, amount.AsValue.AsDecimal, chargeAmount, exDutyAmount, totalChargeAmount);
            Datum.Add('charge_amount', chargeAmount);
            Datum.Add('excise_duty', exDutyAmount);
            Datum.Add('total_charges', totalChargeAmount);

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('response_payload', Datum);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMembersCurrentShares(
        var FullShares: Decimal;
        MemberNo: Code[20];
        LoanProduct: Code[20])
    var
        ActiveLoan: Record Loans;
        TotalSharesReduction: Decimal;
        ExistingLoanBalance: Decimal;
        IsApplyingForLLN: Boolean;
        IsApplyingForMultiplierProduct: Boolean;
        ExistingProductCode: Code[20];
    begin
        // ----------------------------------------------------------
        // Step 1: Classify the product being applied for.
        //         This drives which existing loans we count against
        //         the member's free shares.
        // ----------------------------------------------------------
        IsApplyingForLLN := (LoanProduct = 'LLN');
        IsApplyingForMultiplierProduct := IsDepositMultiplierProduct(LoanProduct);

        // Products that are neither LLN nor deposit-multiplier based
        // (e.g. ALN, NQS) do not use free-share calculation at all.
        if not IsApplyingForLLN and not IsApplyingForMultiplierProduct then
            exit;

        // ----------------------------------------------------------
        // Step 2: Loop over all active loans for this member and
        //         accumulate the total shares already committed.
        // ----------------------------------------------------------
        TotalSharesReduction := 0;

        ActiveLoan.Reset();
        ActiveLoan.SetRange("Member No.", MemberNo);
        ActiveLoan.SetRange(Posted, true);
        ActiveLoan.SetAutoCalcFields("Total Outstanding Balance");
        ActiveLoan.SetFilter("Total Outstanding Balance", '>0');

        if not ActiveLoan.FindSet() then begin
            // No active loans — no reduction needed
            exit;
        end;

        repeat
            ExistingLoanBalance := ActiveLoan."Total Outstanding Balance";

            // Resolve the product code (e.g. 'LLN') from the
            // loan's product type ID stored on the loan record.
            // Adjust field name below to match your Loans table schema.
            ExistingProductCode := ActiveLoan."Loan Product Type";

            // ----------------------------------------------------------
            // CASE 1 — Applying for LLN:
            //   Count ALL existing loans that use any deposit multiplier,
            //   reversing the multiplier to get the share equivalent.
            // ----------------------------------------------------------
            if IsApplyingForLLN then begin
                if ExistingProductCode = 'LLN' then
                    // LLN uses 8× multiplier
                    TotalSharesReduction += Round(ExistingLoanBalance / 8, 0.01)
                else if IsDepositMultiplierProduct(ExistingProductCode) then
                    // All other multiplier products use 5×
                    TotalSharesReduction += Round(ExistingLoanBalance / 5, 0.01);
                // Non-multiplier products (ALN, NQS, etc.) → no share impact
            end

            // ----------------------------------------------------------
            // CASE 2 — Applying for any other deposit-multiplier product:
            //   Only count existing LLN loans (reverse 8×).
            //   Other multiplier-vs-multiplier loans are not counted —
            //   this matches the client-accepted behaviour from the
            //   previous vendor.
            // ----------------------------------------------------------
            else begin
                if ExistingProductCode = 'LLN' then
                    TotalSharesReduction += Round(ExistingLoanBalance / 8, 0.01);
                // Other multiplier products: no reduction (by design)
            end;

        until ActiveLoan.Next() = 0;

        // ----------------------------------------------------------
        // Step 3: Reduce the member's free shares and floor at zero.
        // ----------------------------------------------------------
        FullShares -= TotalSharesReduction;

        if FullShares < 0 then
            FullShares := 0;
    end;

    local procedure IsDepositMultiplierProduct(ProductCode: Code[20]): Boolean
    begin
        case ProductCode of
            'BLN', 'DLN', 'NLN', 'SLN',
            'ELN', 'EMERGENCY', 'HELA',
            'PLN', 'PPL':
                exit(true);
            else
                exit(false);
        end;
    end;

    // LOAN APPLICATIONS
    local procedure GetLoanApplicationProducts(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        MemberRec: Record Members;
        ProductFactory: Record "Product Setup";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            ProductFactory.Reset;
            ProductFactory.SetRange("Product Class", ProductFactory."Product Class"::Credit);
            ProductFactory.SetRange("Available on Mobile", true);


            if ProductFactory.FindSet then begin
                repeat begin
                    Clear(Datum);

                    Datum.Add('product_id', ProductFactory."Product ID");
                    Datum.Add('product_name', ProductFactory."Description");
                    Datum.Add('minimum_guarantors', ProductFactory."Minimum Guarantors");
                    Datum.Add('maximum_guarantors', ProductFactory."Maximum Guarantors");
                    Datum.Add('minimum_amount', ProductFactory."Minimum Loan Amount");
                    Datum.Add('maximum_amount', ProductFactory."Maximum Loan Amount");
                    Datum.Add('repayment_frequency', Format(ProductFactory."Repayment Frequency"));
                    Datum.Add('min_interest_rate', Format(ProductFactory."Interest Rate (Min.)"));
                    Datum.Add('maximum_installments', ProductFactory."Default Installments");
                    Datum.Add('interest_calculation_method', Format(ProductFactory."Interest Calculation Method"));

                    Data.Add(Datum);
                end until ProductFactory.Next = 0;
            end;

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'Loan application product list has been fetched successfully');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CalcMinimumAmount(
       ExistingBalance: Decimal;
       RefFee: Decimal;
       ProcFee: Decimal;
       ProductMinAmount: Decimal): Decimal
    var
        BalancePlusFees: Decimal;
    begin
        if ExistingBalance <= 0 then
            exit(ProductMinAmount);

        BalancePlusFees := ExistingBalance + RefFee + ProcFee;

        if BalancePlusFees >= ProductMinAmount then
            exit(BalancePlusFees)
        else
            exit(ProductMinAmount);
    end;

    local procedure ValidateGuarantorEligibilityRequest(Payload: JsonObject): Text
    var
        member_no: JsonToken;
        loan_type_id: JsonToken;

        SearchMember: Record Members;
        MobileLoanProduct: Record "Product Setup";
        SalaryAmount: decimal;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;

        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('member_no', member_no);
        Payload.Get('loan_type_id', loan_type_id);

        SearchMember.Reset;
        SearchMember.SetRange("No.", member_no.asValue.Astext);
        SearchMember.SetRange("Member Status", SearchMember."Member Status"::Active);
        SearchMember.SetFilter("Employer Code", '<>%1', 'SACCO_STAFF'); // Omit staff
        IF SearchMember.FindFirst then begin
            SalaryAmount := GuarantorSalaryEligibility(loan_type_id.AsValue.AsText, SearchMember);

            if SalaryAmount <= 0 then begin
                Datum.Add('eligible', false);
            end else begin
                Datum.Add('eligible', true);
            end;

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('response_payload', Datum);
        end else begin
            SearchMember.Reset;
            SearchMember.SetRange("No.", member_no.asValue.Astext);

            IF SearchMember.FindFirst then begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('request_status_description', 'Member with no. ' + member_no.AsValue.AsText + ' NOT eligible.');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('request_status_description', 'Member with no. ' + member_no.AsValue.AsText + ' NOT found!');
                ResponseObject.Add('response_payload', Datum);
            end;
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure GuarantorSalaryEligibility(LoanTypeID: Text; SearchMember: Record Members): Decimal
    var
        SalAvg: decimal;
        SalaryAmount: decimal;
        SalaryAccount: record "Savings Accounts";
        FosaAccount: Text;
        BosaAccount: Text;
        SalaryLines: Record "Salary Lines";
        ProdFac: record "Product Setup";
        STOAmount: decimal;
        LoanRec: decimal;


        MinDateProduct: Date;
        MinDateMember: Date;
        Members: Record Members;
    begin
        SalAvg := 0;
        SalaryAmount := 0;
        FosaAccount := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);


        if SalaryAmount < 0 then begin
            exit(0);
        end;
        exit(SalaryAmount);
    end;

    local procedure CreateLoanApplicationRequest(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_product: JsonToken;
        loan_purpose: JsonToken;
        installments: JsonToken;
        requested_amount: JsonToken;
        sasra_main_sector: JsonToken;
        sasra_sub_sector_1: JsonToken;
        sasra_sub_sector_2: JsonToken;
        is_self_guarantee: JsonToken;

        loans_to_be_cleared: JsonToken;
        loan_to_be_cleared: JsonToken;

        files: JsonToken;
        file: JsonToken;
        file_name: JsonToken;
        file_contents: JsonToken;

        guarantors: JsonToken;
        guarantor: JsonToken;
        guarantor_member_number: JsonToken;

        SearchMember: record Members;
        TheLoanApplication: record "Sky Mobile Loans";
        TheLoanGuarantorshipRequest: Record "Mobile Loan Guarantors";

        SalaryAmount: decimal;
        GuarantorMember: Record Members;
        MobileLoanProduct: Record "Product Setup";
        LoansToBeCleared: Record Loans;
        TopupAmount: Decimal;




        ExistingLoanApplications: Record "Sky Mobile Loans";

        KeyExists: Boolean;
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        Base64Convert: Codeunit "Base64 Convert";

        StoreImageRef: FieldRef;
        StoreRecRef: RecordRef;

        KeyExists1: Boolean;
        KeyExists2: Boolean;
        KeyExists3: Boolean;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_product', loan_product);
        Payload.Get('loan_purpose', loan_purpose);
        Payload.Get('installments', installments);
        Payload.Get('requested_amount', requested_amount);
        Payload.Get('guarantors', guarantors);
        KeyExists1 := Payload.Get('sasra_main_sector', sasra_main_sector);
        KeyExists1 := Payload.Get('sasra_sub_sector_1', sasra_sub_sector_1);
        KeyExists1 := Payload.Get('sasra_sub_sector_2', sasra_sub_sector_2);
        KeyExists2 := Payload.Get('is_self_guarantee', is_self_guarantee);
        KeyExists3 := Payload.Get('loans_to_be_cleared', loans_to_be_cleared);
        KeyExists := Payload.Get('files', files);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            ExistingLoanApplications.Reset;
            ExistingLoanApplications.SetRange("Member No.", SearchMember."No.");
            ExistingLoanApplications.SetFilter(Status,
            '%1|%2',
            ExistingLoanApplications.Status::Pending,
            ExistingLoanApplications.Status::"Pending Update");
            if ExistingLoanApplications.FindFirst then begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', StrSubstNo('There is an ongoing loan application %2 at status = %1', ExistingLoanApplications.Status, ExistingLoanApplications."Entry No"));
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);

                exit(Response);
            end;

            TheLoanApplication.Init;

            TheLoanApplication."Member No." := SearchMember."No.";
            TheLoanApplication."Loan Product Type" := loan_product.AsValue.AsText;
            TheLoanApplication."Loan Purpose" := loan_purpose.AsValue.AsText;
            TheLoanApplication.Period := installments.AsValue.AsInteger;
            TheLoanApplication."Requested Amount" := requested_amount.AsValue.AsDecimal;


            if KeyExists1 then begin
                //TheLoanApplication."Main Sector" := sasra_main_sector.AsValue.AsText;
                //TheLoanApplication."Sub Sector Level1" := sasra_sub_sector_1.AsValue.AsText;
                //TheLoanApplication."Sub Sector Level2" := sasra_sub_sector_2.AsValue.AsText;
            end;

            if KeyExists2 then begin
                //TheLoanApplication."Is Self Guarantee" := is_self_guarantee.AsValue.AsBoolean;
            end;



            // Validate loan guarantors
            foreach guarantor in guarantors.AsArray do begin
                guarantor.AsObject.Get('member_number', guarantor_member_number);

                SalaryAmount := 0;

                GuarantorMember.Reset;
                GuarantorMember.SetRange("No.", guarantor_member_number.AsValue.AsText);
                if GuarantorMember.FindFirst then begin
                    SalaryAmount := GuarantorSalaryEligibility(loan_product.AsValue.AsText, GuarantorMember);

                    if SalaryAmount <= 0 then begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', 'Member with no. ' + guarantor_member_number.AsValue.AsText + ' is NOT eligible for guarantorship due to deposits/salary requirements!');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;
            end;

            if KeyExists3 then begin
                // Loan Top up
                if loans_to_be_cleared.IsArray then begin
                    //loans_to_be_cleared.WriteTo(TheLoanApplication."Loan Top Up");

                    foreach loan_to_be_cleared in loans_to_be_cleared.AsArray do begin
                        LoansToBeCleared.Reset;
                        LoansToBeCleared.SetRange("Loan No.", loan_to_be_cleared.AsValue.AsText);
                        LoansToBeCleared.SetFilter("Total Outstanding Balance", '>0');
                        LoansToBeCleared.SetRange(Posted, true);
                        LoansToBeCleared.SetAutoCalcFields("Total Outstanding Balance");

                        if LoansToBeCleared.FindFirst then begin
                            TopupAmount += LoansToBeCleared."Total Outstanding Balance";
                        end;
                    end;

                    if (TopupAmount * 1.5) > (TheLoanApplication."Requested Amount") then begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', 'The requested amount is insufficient to top up the requested loan(s)');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;

            end;

            if TheLoanApplication.Insert(true) then begin
                // Guarantor requests
                foreach guarantor in guarantors.AsArray do begin
                    guarantor.AsObject.Get('member_number', guarantor_member_number);

                    TheLoanGuarantorshipRequest.Reset;
                    Clear(TheLoanGuarantorshipRequest);
                    TheLoanGuarantorshipRequest.Init;

                    TheLoanGuarantorshipRequest."Guarantor Member No." := guarantor_member_number.AsValue.AsText;

                    TheLoanGuarantorshipRequest.Status := TheLoanGuarantorshipRequest.Status::"Pending Approval";
                    TheLoanGuarantorshipRequest."Date Created" := CurrentDateTime;
                    TheLoanGuarantorshipRequest."Loan Entry No." := TheLoanApplication."Entry No";

                    TheLoanGuarantorshipRequest.Insert(true);
                    Commit;
                end;



                // Files
                if KeyExists then begin

                    foreach file in files.AsArray() do begin
                        file.AsObject.Get('name', file_name);

                        /*
                        if EDMSFunctions.GetFileTypeFromFileName(file_name.AsValue.AsText) = EDMSFileTypes::" " then begin
                            ResponseObject.Add('request_status', 'ERROR');
                            Datum.Add('error_message', 'Unsupported file type for uploading the file = ' + file_name.AsValue.AsText);
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);
                            ResponseObject.WriteTo(Response);

                            exit(Response);
                        end;
                        */
                    end;

                    foreach file in files.AsArray() do begin
                        file.AsObject.Get('name', file_name);
                        file.AsObject.Get('contents', file_contents);

                        /*
                        TheLoanApplicationDocuments.Reset;
                        Clear(TheLoanApplicationDocuments);
                        TheLoanApplicationDocuments.Init;

                        TheLoanApplicationDocuments."Application Type" := TheLoanApplicationDocuments."Application Type"::"Loan Application";
                        TheLoanApplicationDocuments."Application No." := TheLoanApplication."Application No.";
                        TheLoanApplicationDocuments."Document Name" := file_name.AsValue.AsText;

                        // B64 to Blob
                        TempBlob.CreateOutStream(OutStr);
                        Base64Convert.FromBase64(file_contents.AsValue.AsText, OutStr);
                        Clear(TheLoanApplicationDocuments.Document);
                        StoreRecRef.Open(52186564);

                        TempBlob.ToFieldRef(StoreImageRef);
                        StoreImageRef.TestField();

                        TheLoanApplicationDocuments.Document := StoreImageRef.Value;
                        TheLoanApplicationDocuments."Document Extension" := EDMSFunctions.GetFileTypeFromFileName(file_name.AsValue.AsText);

                        TheLoanApplicationDocuments.Insert(true);
                        */
                        // Commit;

                        Clear(TempBlob);
                        Clear(OutStr);
                        Clear(Base64Convert);
                        Clear(StoreRecRef);
                        Clear(StoreImageRef);
                    end;

                end;

                Datum.Add('application_no', TheLoanApplication."Entry No");

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('request_status_description', 'Loan application request has been created successfully');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Unable to create loan application request at the moment.');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('request_status_description', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanApplicationRequests(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheLoanApplications: Record "Sky Mobile Loans";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        LoanProduct: Record "Product Setup";
        Appraisal: Record "Portal Loans";
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin

            Appraisal.Reset;
            Appraisal.SetRange("Member No.", SearchMember."No.");
            Appraisal.SetRange(Status, Appraisal.Status::"Pending Guarantor Action");
            if Appraisal.findset() then
                repeat
                    Clear(Datum);
                    Datum.Add('application_no', Appraisal."Application No.");
                    Datum.Add('member_no', Appraisal."Member No.");
                    Datum.Add('member_name', Appraisal."Account Name");
                    Datum.Add('application_date_time', (Appraisal."Date"));
                    Datum.Add('loan_product_type', Appraisal."Loan Product Type");
                    Datum.Add('loan_product_name', Appraisal."Loan Product Type");
                    Datum.Add('requested_amount', Appraisal."Requested Amount");
                    Datum.Add('eligible_amount', Appraisal."Approved Amount");

                    Datum.Add('loan_purpose', Appraisal."Loan Purpose");
                    Datum.Add('installments', Appraisal."Loan period");
                    Datum.Add('status', Format(Appraisal.Status));

                    Data.Add(Datum);
                until Appraisal.Next = 0;


            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'Loan application request list has been fetched successfully');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;


    local procedure GetLoanMaxInstallments(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        amount_tok: JsonToken;
        loan_type_id: JsonToken;
        asset_type: JsonToken;
        SearchMember: Record Members;
        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        RequestedAmt: Decimal;
        LoanProduct: Code[20];
        AssetType: Text;
        MaxInstallments: Integer;
        Loans: Record Loans;
        SkyPortal: Codeunit "Sky Portal";
        LoanType: Record "Product Setup";
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('amount', amount_tok);
        Payload.Get('loan_type_id', loan_type_id);
        Payload.Get('asset_type', asset_type);
        Evaluate(RequestedAmt, amount_tok.AsValue().AsText());
        LoanProduct := CopyStr(loan_type_id.AsValue().AsText(), 1, 20);
        AssetType := asset_type.AsValue().AsText();

        if not MemberExists(identifier_type.AsValue().AsText(), identifier.AsValue().AsText(), SearchMember, ResponseText, ResponseDescription) then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;
        if LoanType.Get(LoanProduct) then begin

            //use tier debt threshold table to determine max installments based on loan amount and asset type
            if LoanType."Use Tiered Debt Threshold" then begin
                MaxInstallments := Loans.GetTieredInstallments(LoanProduct, RequestedAmt);
            end else
                MaxInstallments := LoanType."Default Installments";

            SkyPortal.PopulateSubType(MaxInstallments, LoanProduct, AssetType, amount_tok.AsValue().AsDecimal());

            ResponseObject.Add('request_status', 'SUCCESS');
            Datum.Add('max_installments', MaxInstallments);
            Datum.Add('gross_amount', RequestedAmt);
            ResponseObject.Add('response_payload', Datum);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Loan product with ID ' + LoanProduct + ' not found!');
            ResponseObject.Add('response_payload', Datum);
        end;
        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;


    local procedure GetLoanApplicationRequest(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        TheLoanApplications: Record "Sky Mobile Loans";
        GuarantorRequests: Record "Mobile Loan Guarantors";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Guarantors: JsonArray;
        Guarantor: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);

        SearchMember.Reset;
        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoanApplications.Reset;
            TheLoanApplications.SetRange("Member No.", SearchMember."No.");
            TheLoanApplications.SetFilter(Status, '=%1|%2', TheLoanApplications.Status::Pending, TheLoanApplications.Status::"Pending Guarantors");


            if TheLoanApplications.FindFirst then begin


                Datum.Add('application_no', TheLoanApplications."Entry No");
                Datum.Add('member_no', TheLoanApplications."Member No.");
                Datum.Add('member_name', TheLoanApplications."Name");
                Datum.Add('application_date_time', (TheLoanApplications."Date Entered"));
                Datum.Add('loan_product_type', TheLoanApplications."Loan Product Type");
                Datum.Add('loan_product_name', TheLoanApplications."Loan Product Type");
                Datum.Add('requested_amount', TheLoanApplications."Requested Amount");
                Datum.Add('eligible_amount', TheLoanApplications."Approved Amount");

                Datum.Add('loan_purpose', TheLoanApplications."Loan Purpose");
                Datum.Add('installments', TheLoanApplications.Period);
                Datum.Add('status', Format(TheLoanApplications.Status));

                GuarantorRequests.Reset;
                GuarantorRequests.SetRange("Loan Entry No.", TheLoanApplications."Entry No");
                if GuarantorRequests.FindSet then begin
                    repeat begin
                        Clear(Guarantor);


                        Guarantor.Add('entry_no', GuarantorRequests."Loan Entry No.");
                        Guarantor.Add('member_number', GuarantorRequests."Guarantor Member No.");

                        if SearchMember.Get(GuarantorRequests."Guarantor Member No.") then
                            Guarantor.Add('phone_number', SearchMember."Phone No.")
                        else
                            Guarantor.Add('phone_number', '');

                        Guarantor.Add('member_name', GuarantorRequests."Guarantor Name");
                        Guarantor.Add('request_status', Format(GuarantorRequests.Status));
                        Guarantor.Add('request_status_date_time', ddMMyyyyTime(GuarantorRequests."Date Created"));

                        Guarantors.Add(Guarantor);
                    end until GuarantorRequests.Next = 0;
                end;
                Datum.Add('guarantorship_requests', Guarantors);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('request_status_description', 'Loan application request has been fetched successfully');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan application request ' + application_no.AsValue.AsText + ' NOT found');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure EditLoanApplicationRequest(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;
        requested_amount: JsonToken;

        SearchMember: record Members;
        TheLoanApplication: Record "Sky Mobile Loans";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);
        Payload.Get('requested_amount', requested_amount);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoanApplication.Reset;

            TheLoanApplication.SetRange("Entry No", application_no.AsValue.AsText);
            TheLoanApplication.SetRange(Status, TheLoanApplication.Status::Pending);

            if TheLoanApplication.FindFirst then begin
                TheLoanApplication."Requested Amount" := requested_amount.AsValue.AsInteger;

                if TheLoanApplication.Modify(true) then begin
                    ResponseObject.Add('request_status', 'SUCCESS');
                    ResponseObject.Add('request_status_description', 'Loan application request has been updated successfully');
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Unable to update loan application request at the moment');
                    ResponseObject.Add('response_payload', Datum);
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'The loan application ' + application_no.AsValue.AsText + ' is NOT available for update');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('request_status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CancelLoanApplicationRequest(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: record Members;
        TheLoanApplication: Record "Sky Mobile Loans";
        TheLoanGuarantorshipRequests: Record "Mobile Loan Guarantors";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoanApplication.Reset;

            TheLoanApplication.SetRange("Loan No.", application_no.AsValue.AsText);
            TheLoanApplication.SetRange(Status, TheLoanApplication.Status::Pending);

            if TheLoanApplication.FindFirst then begin
                TheLoanGuarantorshipRequests.Reset;

                TheLoanGuarantorshipRequests.SetRange("Loan Entry No.", TheLoanApplication."Entry No");
                if TheLoanGuarantorshipRequests.FindSet then begin
                    repeat begin
                        TheLoanGuarantorshipRequests.Delete(true);
                    end until TheLoanGuarantorshipRequests.Next = 0;
                end;

                if TheLoanApplication.Delete(true) then begin
                    ResponseObject.Add('request_status', 'SUCCESS');
                    ResponseObject.Add('request_status_description', 'Loan application request has been cancelled successfully');
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Unable to cancel loan application request at the moment');
                    ResponseObject.Add('response_payload', Datum);
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'The loan application ' + application_no.AsValue.AsText + ' is NOT available for cancellation');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('request_status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GuarantorEligibilityCheck(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        guarantorno_tok: JsonToken;
        SearchMember: Record Members;
        GuarantorMember: Record Members;
        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        guarantorno: Text;

        SkyMobileBanking: Codeunit "Sky Mobile Banking Integration";
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        //Payload.Get('guarantor_no', guarantorno_tok);
        //guarantorno := identifier.AsValue().AsText();
        if not MemberExists(identifier_type.AsValue().AsText(), identifier.AsValue().AsText(), SearchMember, ResponseText, ResponseDescription) then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;
        /* if not MemberExists('CUSTOMER_NO', guarantorno, GuarantorMember, ResponseText, ResponseDescription) then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end; */
        ResponseObject.Add('request_status', 'SUCCESS');
        Datum.Add('free_shares', SkyMobileBanking.GetMemberFreeShares(SearchMember."No."));
        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure ManageLoanGuarantorsRequest(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;
        action: JsonToken;
        guarantor_member_number: JsonToken;

        SearchMember: Record Members;
        TheLoanGuarantorshipRequest: Record "Mobile Loan Guarantors";
        TheLoanApplication: Record "Sky Mobile Loans";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);
        Payload.Get('action', action); // ADD, REMOVE
        Payload.Get('guarantor_member_number', guarantor_member_number);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if TheLoanApplication.Get(application_no.AsValue.AsText) then begin
                case action.AsValue.AsText of
                    'ADD':
                        begin
                            TheLoanGuarantorshipRequest.Init;

                            TheLoanGuarantorshipRequest."Guarantor Member No." := guarantor_member_number.AsValue.AsText;

                            TheLoanGuarantorshipRequest.Status := TheLoanGuarantorshipRequest.Status::"Pending Approval";
                            //TheLoanGuarantorshipRequest."Status Date Time" := CurrentDateTime;
                            TheLoanGuarantorshipRequest."Loan Entry No." := TheLoanApplication."Entry No";

                            if TheLoanGuarantorshipRequest.Insert(true) then begin
                                ResponseObject.Add('request_status', 'SUCCESS');
                                ResponseObject.Add('request_status_description', 'Loan guarantor has been added successfully');
                            end else begin
                                ResponseObject.Add('request_status', 'ERROR');
                                Datum.Add('error_message', 'Error. Unable to add loan guarantor at the moment.');
                                ResponseObject.Add('response_payload', Datum);
                            end;
                        end;
                    'REMOVE':
                        begin
                            TheLoanGuarantorshipRequest.Reset;

                            TheLoanGuarantorshipRequest.SetRange("Guarantor Member No.", guarantor_member_number.AsValue.AsText);
                            TheLoanGuarantorshipRequest.SetRange(Status, TheLoanGuarantorshipRequest.Status::"Pending Approval");
                            TheLoanGuarantorshipRequest.SetRange("Loan Entry No.", TheLoanApplication."Entry No");

                            if TheLoanGuarantorshipRequest.FindFirst then begin
                                if TheLoanGuarantorshipRequest.Delete(true) then begin
                                    ResponseObject.Add('request_status', 'SUCCESS');
                                    ResponseObject.Add('request_status_description', 'Loan guarantor has been removed successfully');
                                end else begin
                                    ResponseObject.Add('request_status', 'ERROR');
                                    Datum.Add('error_message', 'Error. Unable to remove loan guarantorship request');
                                    ResponseObject.Add('response_payload', Datum);
                                end;
                            end else begin
                                ResponseObject.Add('request_status', 'ERROR');
                                Datum.Add('error_message', 'Loan guarantorship request NOT found');
                                ResponseObject.Add('response_payload', Datum);
                            end;
                        end;
                    else
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan application with no ' + application_no.AsValue.AsText + ' NOT found');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;


    local procedure GetLoanGuarantorshipRequests(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheLoanGuarantorshipRequests: Record "Mobile Loan Guarantors";
        TheLoanApplications: Record "Sky Mobile Loans";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;

        LoanType: Record "Product Setup";
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoanGuarantorshipRequests.Reset;
            TheLoanGuarantorshipRequests.SetRange("Guarantor Member No.", SearchMember."No.");
            //TheLoanGuarantorshipRequests.SetRange(Status, TheLoanGuarantorshipRequests.Status::"Pending Approval");

            if TheLoanGuarantorshipRequests.FindSet then begin
                repeat begin
                    Clear(Datum);

                    TheLoanApplications.Reset();
                    TheLoanApplications.SetRange("Loan No.", TheLoanGuarantorshipRequests."Loan No.");
                    if TheLoanApplications.FindFirst() then;

                    if LoanType.Get(TheLoanApplications."Loan Product Type") then;

                    Datum.Add('entry_no', TheLoanGuarantorshipRequests."Loan Entry No.");

                    Datum.Add('application_no', TheLoanApplications."Loan No.");
                    Datum.Add('member_no', TheLoanApplications."Member No.");
                    Datum.Add('member_name', TheLoanApplications."Account Name");
                    Datum.Add('application_date_time', (TheLoanApplications."Date Entered"));
                    Datum.Add('loan_product_type', TheLoanApplications."Loan Product Type");
                    Datum.Add('loan_product_name', LoanType.Description);
                    Datum.Add('requested_amount', TheLoanGuarantorshipRequests."Amount Guaranteed");
                    Datum.Add('eligible_amount', TheLoanGuarantorshipRequests."Amount Guaranteed");

                    Datum.Add('loan_purpose', TheLoanApplications."Loan Purpose");
                    Datum.Add('installments', TheLoanApplications.Period);
                    Datum.Add('status', Format(TheLoanGuarantorshipRequests.Status));
                    Data.Add(Datum);
                end until TheLoanGuarantorshipRequests.Next = 0;
            end;

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'Loan guarantorship request list has been fetched successfully');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure AddGuarantor(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_serial_number: JsonToken;
        guarantor_no: JsonToken;
        amount: JsonToken;

        Members: Record Members;
        GuarantorMembers: Record Members;
        //MobileLoans: Record "Sky Mobile Loans";
        MobileLoanGuarantors: Record "Mobile Loan Guarantors";
        ProductFact: Record "Product Setup";
        PortalGuarantors: Record "Portal Guarantors";
        PortalLoan: Record "Portal Loans";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;

        LoanNo: Code[20];
        GuarantorAmount: Decimal;

        msg: Text;
        FreeShares: Decimal;
        SkyMobileBanking: Codeunit "Sky Mobile Banking Integration";
    begin
        // Read payload
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_serial_number', loan_serial_number);
        Payload.Get('guarantor_no', guarantor_no);
        Payload.Get('amount', amount);

        Evaluate(LoanNo, loan_serial_number.AsValue().AsText());

        if amount.IsValue() then
            Evaluate(GuarantorAmount, amount.AsValue().AsText());

        // Validate member
        if not MemberExists(identifier_type.AsValue().AsText(), identifier.AsValue().AsText(), Members, ResponseText, ResponseDescription) then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;


        // Validate loan
        PortalLoan.Reset();
        PortalLoan.SetRange("Application No.", loan_serial_number.AsValue().AsText());
        PortalLoan.SetRange(Status, PortalLoan.Status::"Pending Guarantor Action");
        PortalLoan.SetRange("Member No.", Members."No.");

        if not PortalLoan.FindFirst() then begin
            ResponseObject.Add('request_status', 'ERROR');

            Datum.Add(
                'error_message',
                'Loan application not found, does not belong to the member, or is not pending guarantor action.'
            );

            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        PortalGuarantors.Reset();
        PortalGuarantors.SetRange("Loan Entry No.", loan_serial_number.AsValue().AsText());
        PortalGuarantors.SetRange("Guarantor Member No.", guarantor_no.AsValue().AsText());
        if PortalGuarantors.FindFirst() then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'You have already added this member as a guarantor');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Check duplicate guarantor
        MobileLoanGuarantors.Reset();
        MobileLoanGuarantors.SetRange("Loan No.", loan_serial_number.AsValue().AsText());
        MobileLoanGuarantors.SetRange("Guarantor Member No.", guarantor_no.AsValue().AsText());

        if MobileLoanGuarantors.FindFirst() then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'You have already added this member as a guarantor');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        if GuarantorMembers.Get(guarantor_no.AsValue().AsText()) then begin
            // proceed
            /*  FreeShares := SkyMobileBanking.GetMemberFreeShares(GuarantorMembers."No.");
             if amount.AsValue().AsDecimal() > FreeShares then begin

                 ResponseObject.Add('request_status', 'ERROR');
                 Datum.Add('error_message',
                         StrSubstNo(
                             'Insufficient free shares. Required: %1, Available: %2',
                             Format(amount.AsValue().AsDecimal()),
                             Format(FreeShares)
                         ));
                 ResponseObject.Add('response_payload', Datum);
                 AddDateTimeToResponse(ResponseObject);
                 ResponseObject.WriteTo(Response);
                 exit(Response);
             end; */

        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Guarantor member number is invalid');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        PortalLoan.Reset();
        PortalLoan.SetRange("Application No.", loan_serial_number.AsValue().AsText());
        PortalLoan.SetRange("Member No.", Members."No.");
        if PortalLoan.FindFirst() then
            ProductFact.Get(PortalLoan."Loan Product Type");


        // Create guarantor
        MobileLoanGuarantors.Init();
        MobileLoanGuarantors."Loan Entry No." := CreateGuid();
        MobileLoanGuarantors."Loan No." := loan_serial_number.AsValue().AsText();
        MobileLoanGuarantors."Guarantor Member No." := guarantor_no.AsValue().AsText();


        MobileLoanGuarantors."Guarantor Mobile No." := GuarantorMembers."Mobile Phone No.";
        MobileLoanGuarantors."Loan Product" := PortalGuarantors."Loan Product";

        MobileLoanGuarantors."Loan Product Name" := ProductFact.Description;
        MobileLoanGuarantors."Guarantor Name" := GuarantorMembers.Name;

        MobileLoanGuarantors.Status := MobileLoanGuarantors.Status::"Pending Approval";
        MobileLoanGuarantors."Date Created" := CurrentDateTime;

        if GuarantorAmount > 0 then
            MobileLoanGuarantors."Amount Guaranteed" := GuarantorAmount;

        MobileLoanGuarantors."Guarantor Accepted" := MobileLoanGuarantors."Guarantor Accepted"::Pending;
        MobileLoanGuarantors."Guarantor Type" := MobileLoanGuarantors."Guarantor Type"::Guarantor;

        MobileLoanGuarantors.Insert();

        // ======================
        // SMS 1 (Borrower)
        // ======================
        msg :=
            'Dear ' + CopyStr(Members.Name, 1, StrPos(Members.Name, ' ')) + NewLine +
            'You have successfully requested ' + MobileLoanGuarantors."Guarantor Name" +
            ' (' + GuarantorMembers."Mobile Phone No." + ') to guarantee KES ' +
            Format(MobileLoanGuarantors."Amount Guaranteed") + ' for your ' +
            ProductFact.Description + NewLine +
            'Ref: ' + Format(LoanNo) + ' Date: ' + ddMMyyyy(Today);

        MemberActivities.SendSms(SMSSource::PORTAL, Members."Mobile Phone No.", msg, Format(Members."No."), '', true, false);

        // ======================
        // SMS 2 (Guarantor)
        // ======================
        msg :=
            'Dear, ' + CopyStr(MobileLoanGuarantors."Guarantor Name", 1, StrPos(MobileLoanGuarantors."Guarantor Name", ' ')) + ', ' + NewLine +
            CopyStr(Members.Name, 1, StrPos(Members.Name, ' ')) + '(' + Members."Mobile Phone No." + '), has requested you to guarantee KSH ' +
            Format(MobileLoanGuarantors."Amount Guaranteed") + ' for their ' +
            ProductFact.Description + ' of KSH ' +
            Format(PortalLoan."Requested Amount") +
            '. Kindly log in to the members portal or mobile app to action.' +
            NewLine + 'REF: ' + Format(PortalLoan."Application No.") + ' Date ' + Format(CurrentDateTime);

        msg := CopyStr(msg, 1, 250); // ensure message is within 160 char limit

        MemberActivities.SendSms(SMSSource::SkyMobile, MobileLoanGuarantors."Guarantor Mobile No.", msg, guarantor_no.AsValue().AsText(), '', true, false);

        // ======================
        // SUCCESS RESPONSE
        // ======================
        ResponseObject.Add('request_status', 'SUCCESS');
        Datum.Add('status', 'SUCCESS');
        Datum.Add('status_description', 'Guarantor captured successfully');
        ResponseObject.Add('response_payload', Datum);

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        PortalLoan.Reset();
        PortalLoan.SetRange("Application No.", loan_serial_number.AsValue().AsText());
        PortalLoan.SetRange(Status, PortalLoan.Status::"Pending Guarantor Action");
        PortalLoan.SetRange("Member No.", Members."No.");
        if PortalLoan.FindFirst() then begin
            MobileLoanGuarantors.Reset();
            MobileLoanGuarantors.SetRange("Loan No.", PortalLoan."Application No.");
            if MobileLoanGuarantors.FindSet() then begin
                MobileLoanGuarantors.CalcSums("Amount Guaranteed");
                if PortalGuarantors."Amount Guaranteed" >= PortalLoan."Requested Amount" then begin
                    PortalLoan.Status := PortalLoan.Status::"Pending Appraisal";
                    PortalLoan.Modify();
                end;
            end;
        end;

        exit(Response);
    end;

    local procedure RemoveGuarantor(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_serial_number: JsonToken;
        guarantor_no: JsonToken;

        Members: Record Members;
        MobileLoans: Record "Sky Mobile Loans";
        MobileLoanGuarantors: Record "Mobile Loan Guarantors";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;

        LoanNo: Code[20];
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_serial_number', loan_serial_number);
        Payload.Get('guarantor_no', guarantor_no);

        if not Evaluate(LoanNo, loan_serial_number.AsValue().AsText()) then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Invalid loan serial number');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        if not MemberExists(
            identifier_type.AsValue().AsText(),
            identifier.AsValue().AsText(),
            Members,
            ResponseText,
            ResponseDescription)
        then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        MobileLoans.Reset();
        MobileLoans.SetRange("Loan No.", loan_serial_number.AsValue().AsText());
        MobileLoans.SetRange(Status, MobileLoans.Status::"Pending Guarantors");
        MobileLoans.SetRange("Member No.", Members."No.");

        if not MobileLoans.FindFirst() then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'A loan with this entry no does not exist');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        MobileLoanGuarantors.Reset();
        MobileLoanGuarantors.SetRange("Loan No.", loan_serial_number.AsValue().AsText());
        MobileLoanGuarantors.SetRange("Guarantor Member No.", guarantor_no.AsValue().AsText());

        if not MobileLoanGuarantors.FindFirst() then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'This guarantor does not exist on this loan no');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        if MobileLoanGuarantors.Delete(true) then begin
            ResponseObject.Add('request_status', 'SUCCESS');
            Datum.Add('status', 'SUCCESS');
            Datum.Add('status_description', 'Guarantor removed successfully');
            ResponseObject.Add('response_payload', Datum);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Unable to remove guarantor at the moment');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure GetLoanBufferGuarantors(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_no_tok: JsonToken;
        SearchMember: Record Members;
        MobileLoans: Record "Sky Mobile Loans";
        MobileLoanGuarantors: Record "Mobile Loan Guarantors";
        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        LoanNo: Code[20];
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_serial_number', loan_no_tok);

        Evaluate(LoanNo, loan_no_tok.AsValue().AsText());

        if not MemberExists(identifier_type.AsValue().AsText(), identifier.AsValue().AsText(), SearchMember, ResponseText, ResponseDescription) then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;
        MobileLoans.Reset();
        MobileLoans.SetRange("Member No.", SearchMember."No.");
        MobileLoans.SetRange("Loan No.", LoanNo);
        if not MobileLoans.FindFirst() then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'This loan no was not found for this member');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        MobileLoanGuarantors.Reset();
        MobileLoanGuarantors.SetRange("Loan No.", LoanNo);
        if MobileLoanGuarantors.FindSet() then
            repeat
                Clear(Datum);
                Datum.Add('member_number', MobileLoanGuarantors."Guarantor Member No.");
                Datum.Add('guarantor_name', MobileLoanGuarantors."Guarantor Name");
                Datum.Add('status', Format(MobileLoanGuarantors.Status));
                Datum.Add('amount_guaranteed', MobileLoanGuarantors."Amount Guaranteed");
                Data.Add(Datum);
            until MobileLoanGuarantors.Next() = 0;

        ResponseObject.Add('request_status', 'SUCCESS');
        ResponseObject.Add('response_payload', Data);
        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure GetLoanGuarantors(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_serial_number: JsonToken;

        SearchMember: Record Members;
        MemberRec: Record Members;
        LoanGuarantorsSecurity: Record "Loan Security";
        Loans: Record Loans;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Data: JsonArray;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        // Read payload
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_serial_number', loan_serial_number);

        SearchMember.Reset();

        if MemberExists(identifier_type.AsValue().AsText(), identifier.AsValue().AsText(), SearchMember, ResponseText, ResponseDescription) then begin

            // Validate loan
            Loans.Reset();
            Loans.SetRange("Loan No.", loan_serial_number.AsValue().AsText());

            if Loans.FindFirst() then begin

                Clear(Data);

                LoanGuarantorsSecurity.Reset();
                LoanGuarantorsSecurity.SetRange("Loan No.", loan_serial_number.AsValue().AsText());
                LoanGuarantorsSecurity.SetRange(Substituted, false);
                //LoanGuarantorsSecurity.SetRange("Self Guarantee", false);

                if LoanGuarantorsSecurity.FindSet() then begin
                    ResponseText := 'SUCCESS';
                    ResponseDescription := 'Loan guarantors list has been fetched successfully';

                    repeat
                        Clear(Datum);

                        Datum.Add('guarantor_type', Format(LoanGuarantorsSecurity."Guarantor Type"));
                        Datum.Add('member_number', LoanGuarantorsSecurity."Member No");
                        Datum.Add('name', LoanGuarantorsSecurity.Name);
                        Datum.Add('amount_guaranteed', LoanGuarantorsSecurity."Amount Guaranteed");
                        Datum.Add('obligation', LoanGuarantorsSecurity."Current Committed");

                        // Fetch member details
                        if MemberRec.Get(LoanGuarantorsSecurity."Member No") then begin
                            Datum.Add('phone_number', MemberRec."Mobile Phone No.");
                            Datum.Add('member_status', Format(MemberRec.Status));
                        end else begin
                            Datum.Add('phone_number', '');
                            Datum.Add('member_status', '');
                        end;

                        Data.Add(Datum);

                    until LoanGuarantorsSecurity.Next() = 0;

                end else begin
                    ResponseText := 'SUCCESS';
                    ResponseDescription := 'No guarantors found for this loan';
                end;

                Clear(Datum);
                Datum.Add('data', Data);
                Datum.Add('status', ResponseText);
                Datum.Add('status_description', ResponseDescription);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('request_status_description', ResponseDescription);
                ResponseObject.Add('response_payload', Datum);

            end else begin
                // Loan not found
                ResponseObject.Add('request_status', 'ERROR');

                Datum.Add('error_message', 'Loan with number ' + loan_serial_number.AsValue().AsText() + ' not found');
                ResponseObject.Add('response_payload', Datum);
            end;

        end else begin
            // Member not found
            ResponseObject.Add('request_status', 'ERROR');

            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue().AsText() + ' = ' + identifier.AsValue().AsText() + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoansGuaranteed(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        GuarantorMember: Record Members;
        LoanGuarantorsSecurity: Record "Loan Security";
        MemberLoan: Record Loans;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Data: JsonArray;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;

        OutStandingBalance: Decimal;
        ApplicationDate: Date;
    begin
        Payload.Get('identifier_type', identifier);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);

        SearchMember.Reset();

        if MemberExists(identifier_type.AsValue().AsText(), identifier.AsValue().AsText(), SearchMember, ResponseText, ResponseDescription) then begin
            LoanGuarantorsSecurity.Reset();
            LoanGuarantorsSecurity.SetRange("Member No", SearchMember."No.");
            LoanGuarantorsSecurity.SetFilter("Outstanding Principal", '<>%1', 0);

            if LoanGuarantorsSecurity.FindSet() then begin
                ResponseText := 'SUCCESS';
                ResponseDescription := 'Member''s loans guaranteed list has been fetched successfully';

                repeat
                    Clear(Datum);
                    Clear(OutStandingBalance);
                    Clear(ApplicationDate);

                    if LoanGuarantorsSecurity."Member Guaranteed" <> SearchMember."No." then begin
                        MemberLoan.Reset();
                        MemberLoan.SetRange("Loan No.", LoanGuarantorsSecurity."Loan No.");
                        if MemberLoan.FindFirst() then begin
                            MemberLoan.CalcFields("Outstanding Principal");
                            OutStandingBalance := MemberLoan."Outstanding Principal";
                            ApplicationDate := MemberLoan."Application Date";
                        end;

                        if OutStandingBalance > 0 then begin
                            Datum.Add('member_number', MemberLoan."Member No.");
                            Datum.Add('name', MemberLoan."Member Name");

                            if GuarantorMember.Get(MemberLoan."Member No.") then
                                Datum.Add('phone_number', GuarantorMember."Mobile Phone No.")
                            else
                                Datum.Add('phone_number', '');

                            Datum.Add('loan_number', LoanGuarantorsSecurity."Loan No.");
                            Datum.Add('loan_type', MemberLoan."Loan Product Type Name");
                            Datum.Add('amount_guaranteed', LoanGuarantorsSecurity."Amount Guaranteed");
                            Datum.Add('loan_category', Format(MemberLoan."Loans Category-SASRA"));
                            Datum.Add('loan_balance', OutStandingBalance);
                            Datum.Add('application_date', ddMMyyyy(ApplicationDate));
                            Datum.Add('obligation', LoanGuarantorsSecurity."Current Committed");

                            Data.Add(Datum);
                            Clear(Datum);
                        end;
                    end;
                until LoanGuarantorsSecurity.Next() = 0;
            end else begin
                ResponseText := 'SUCCESS';
                ResponseDescription := 'No guaranteed loans found for this member';
            end;

            Datum.Add('data', Data);
            Datum.Add('status', ResponseText);
            Datum.Add('status_description', ResponseDescription);
            Datum.add('member_number', SearchMember."No.");
            Datum.add('name', SearchMember.Name);
            Datum.Add('phone_number', SearchMember."Mobile Phone No.");

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue().AsText() + ' = ' + identifier.AsValue().AsText() + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanGuarantorshipRequest(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        TheLoanGuarantorshipRequests: Record "Mobile Loan Guarantors";
        TheLoanApplications: Record "Sky Mobile Loans";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoanGuarantorshipRequests.Reset;
            TheLoanGuarantorshipRequests.SetRange("Guarantor Member No.", SearchMember."No.");
            TheLoanGuarantorshipRequests.SetRange(Status, TheLoanGuarantorshipRequests.Status::"Pending Approval");
            TheLoanGuarantorshipRequests.SetRange("Loan No.", application_no.AsValue.AsText);

            if TheLoanGuarantorshipRequests.FindFirst then begin
                TheLoanApplications.Get(TheLoanGuarantorshipRequests."Loan Entry No.");



                Datum.Add('entry_no', TheLoanGuarantorshipRequests."Loan Entry No.");

                Datum.Add('application_no', TheLoanApplications."Entry No");
                Datum.Add('member_no', TheLoanApplications."Member No.");
                Datum.Add('member_name', TheLoanApplications."Name");
                Datum.Add('application_date_time', (TheLoanApplications."Date Entered"));
                Datum.Add('loan_product_type', TheLoanApplications."Loan Product Type");
                Datum.Add('loan_product_name', TheLoanApplications."Loan Product Type");
                Datum.Add('requested_amount', TheLoanGuarantorshipRequests."Amount Guaranteed");
                Datum.Add('eligible_amount', TheLoanGuarantorshipRequests."Amount Guaranteed");

                Datum.Add('loan_purpose', TheLoanApplications."Loan Purpose");
                Datum.Add('installments', TheLoanApplications.Period);
                Datum.Add('status', Format(TheLoanApplications.Status));

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('request_status_description', 'Loan guarantorship request has been fetched successfully');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan guarantorship request with number ' + application_no.AsValue.AsText + ' is NOT found');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;


    local procedure GetLoansWithGuarantors(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        SearchMember: Record Members;
        FullyDisbursed: Record Loans;
        LoanGuarantorsSecurity: Record "Loan Security";
        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        WrapObj: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        LoanBalance: Decimal;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        if not MemberExists(identifier_type.AsValue().AsText(), identifier.AsValue().AsText(), SearchMember, ResponseText, ResponseDescription) then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;
        FullyDisbursed.Reset();
        FullyDisbursed.SetRange("Member No.", SearchMember."No.");
        FullyDisbursed.SetAutoCalcFields("Total Outstanding Balance");
        FullyDisbursed.SetFilter("Total Outstanding Balance", '>0');
        if FullyDisbursed.FindSet() then
            repeat
                LoanBalance := FullyDisbursed."Total Outstanding Balance";
                LoanGuarantorsSecurity.Reset();
                LoanGuarantorsSecurity.SetRange("Loan No.", FullyDisbursed."Loan No.");
                LoanGuarantorsSecurity.SetRange(Substituted, false);
                LoanGuarantorsSecurity.SetRange("Self Guarantee", false);
                if LoanGuarantorsSecurity.FindFirst() then begin
                    Clear(Datum);
                    Datum.Add('loan_serial_number', FullyDisbursed."Loan No.");
                    Datum.Add('loan_type_id', FullyDisbursed."Loan Product Type");
                    Datum.Add('loan_type_name', FullyDisbursed."Loan Product Type Name");
                    Datum.Add('loan_amount', FullyDisbursed."Approved Amount");
                    Datum.Add('loan_balance', LoanBalance);
                    Datum.Add('installment_amount', FullyDisbursed.Repayment);
                    Datum.Add('loan_issued_date', ddMMyyyy(FullyDisbursed."Disbursement Date"));
                    Datum.Add('loan_end_date', ddMMyyyy(FullyDisbursed."Completion Date"));
                    Datum.Add('loan_performance', Format(FullyDisbursed."Loans Category-SASRA"));
                    Data.Add(Datum);
                end;
            until FullyDisbursed.Next() = 0;
        ResponseObject.Add('request_status', 'SUCCESS');
        WrapObj.Add('data', Data);
        ResponseObject.Add('response_payload', WrapObj);
        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure GetLoansPendingGuarantorship(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        SearchMember: Record Members;
        MobileLoans: Record "Sky Mobile Loans";
        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        if not MemberExists(identifier_type.AsValue().AsText(), identifier.AsValue().AsText(), SearchMember, ResponseText, ResponseDescription) then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        MobileLoans.Reset();
        MobileLoans.SetRange("Account No", SearchMember."No.");
        MobileLoans.SetRange(Status, MobileLoans.Status::"Pending Guarantors");
        if not MobileLoans.FindSet() then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'No loans pending guarantorship found for this member');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        repeat
            Clear(Datum);
            Datum.Add('loan_serial_number', MobileLoans."Entry No");
            Datum.Add('loan_product', MobileLoans."Loan Product Type");
            Datum.Add('requested_amount', MobileLoans."Requested Amount");
            Data.Add(Datum);
        until MobileLoans.Next() = 0;

        ResponseObject.Add('request_status', 'SUCCESS');
        ResponseObject.Add('response_payload', Data);
        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;


    local procedure ActionLoanGuarantorshipRequest(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;
        revised_amount: JsonToken;
        action: JsonToken;

        SearchMember: Record Members;
        TheLoanGuarantorshipRequests: Record "Mobile Loan Guarantors";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);
        Payload.Get('revised_amount', revised_amount);
        Payload.Get('action', action);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoanGuarantorshipRequests.Reset;
            TheLoanGuarantorshipRequests.SetRange("Guarantor Member No.", SearchMember."No.");
            //TheLoanGuarantorshipRequests.SetRange(Status, TheLoanGuarantorshipRequests.Status::"Pending Approval");
            TheLoanGuarantorshipRequests.SetRange("Loan No.", application_no.AsValue.AsText);

            if TheLoanGuarantorshipRequests.FindFirst() then begin

                case UpperCase(action.AsValue().AsText()) of
                    'ACCEPT':
                        begin
                            TheLoanGuarantorshipRequests.Status :=
                                TheLoanGuarantorshipRequests.Status::Approved;
                            TheLoanGuarantorshipRequests."Guarantor Accepted" :=
                                TheLoanGuarantorshipRequests."Guarantor Accepted"::Yes;

                            UpdatePortalLoanStatus(TheLoanGuarantorshipRequests);
                        end;

                    'REJECT':
                        begin
                            TheLoanGuarantorshipRequests.Status :=
                                TheLoanGuarantorshipRequests.Status::Rejected;
                            TheLoanGuarantorshipRequests."Guarantor Accepted" :=
                                TheLoanGuarantorshipRequests."Guarantor Accepted"::No;

                            UpdatePortalLoanStatus(TheLoanGuarantorshipRequests);
                        end;

                    'AMEND':
                        begin
                            TheLoanGuarantorshipRequests.Status :=
                                TheLoanGuarantorshipRequests.Status::Approved;
                            TheLoanGuarantorshipRequests."Guarantor Accepted" :=
                                TheLoanGuarantorshipRequests."Guarantor Accepted"::Yes;
                            TheLoanGuarantorshipRequests."Amount Guaranteed" :=
                                revised_amount.AsValue().AsDecimal();
                        end;

                    else begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', 'Unsupported action. Supported actions are: ACCEPT, REJECT and AMEND');
                        ResponseObject.Add('response_payload', Datum);
                        exit(Response);
                    end;
                end;

                TheLoanGuarantorshipRequests."Guarantor Response Date" := Today;
                TheLoanGuarantorshipRequests."Guarantor Response Time" := Time;

                if TheLoanGuarantorshipRequests.Modify(true) then begin
                    ResponseObject.Add('request_status', 'SUCCESS');
                    ResponseObject.Add(
                        'request_status_description',
                        'Loan guarantorship request has been actioned successfully'
                    );
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Unable to action the loan guarantorship request at the moment');
                    ResponseObject.Add('response_payload', Datum);
                end;

            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan guarantorship request not found');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    procedure UpdatePortalLoanStatus(TheLoanGuarantorshipRequests: Record "Mobile Loan Guarantors")
    var
        PortalLoan: Record "Portal Loans";
        MobileLoanGuarantor: Record "Mobile Loan Guarantors";
        TotalGuaranteed: Decimal;
    begin
        if TheLoanGuarantorshipRequests."Loan No." = '' then
            exit;

        PortalLoan.Reset();
        PortalLoan.SetRange("Application No.", TheLoanGuarantorshipRequests."Loan No.");
        PortalLoan.SetRange(Status, PortalLoan.Status::"Pending Guarantor Action");

        if not PortalLoan.FindFirst() then
            exit;

        MobileLoanGuarantor.Reset();
        MobileLoanGuarantor.SetRange("Loan No.", TheLoanGuarantorshipRequests."Loan No.");

        // Optional: uncomment this if only accepted guarantors should count.
        // MobileLoanGuarantor.SetRange(Status, MobileLoanGuarantor.Status::Accepted);

        MobileLoanGuarantor.CalcSums("Amount Guaranteed");
        TotalGuaranteed := MobileLoanGuarantor."Amount Guaranteed";

        if (TotalGuaranteed > 0) and (TotalGuaranteed >= PortalLoan."Requested Amount") then begin
            PortalLoan.Status := PortalLoan.Status::"Pending Appraisal";
            PortalLoan.Modify(true);
        end;
    end;

    // Standing Orders
    local procedure GetSTOSourceAccounts(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheSTOAccounts: record "Savings Accounts";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheSTOAccounts.Reset;

            TheSTOAccounts.SetRange("Member No.", SearchMember."No.");
            TheSTOAccounts.SetRange("Product Category", TheSTOAccounts."Product Category"::"Ordinary Savings");
            TheSTOAccounts.SetRange(Status, TheSTOAccounts.Status::Active);

            if TheSTOAccounts.FindSet then begin
                repeat begin
                    Clear(Datum);

                    Datum.Add('account_no', TheSTOAccounts."No.");
                    Datum.Add('account_name', TheSTOAccounts.Name);
                    Datum.Add('account_type', TheSTOAccounts."Product Name");
                    Datum.Add('status', Format(TheSTOAccounts.Status));
                    Datum.Add('available_balance', MemberActivities.GetAccountBalance(TheSTOAccounts."No."));

                    Data.Add(Datum);
                end until TheSTOAccounts.Next = 0;
            end;

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'STO source accounts list has been fetched successfully');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetSTOIncomeTypes(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            // Salary,Direct Debit,SAYE,Periodic,Pension
            Clear(Datum);
            Datum.Add('code', 0);
            Datum.Add('description', 'Salary');
            Data.Add(Datum);

            Clear(Datum);
            Datum.Add('code', 1);
            Datum.Add('description', 'Direct Debit');
            Data.Add(Datum);

            Clear(Datum);
            Datum.Add('code', 2);
            Datum.Add('description', 'SAYE');
            Data.Add(Datum);

            Clear(Datum);
            Datum.Add('code', 3);
            Datum.Add('description', 'Periodic');
            Data.Add(Datum);

            Clear(Datum);
            Datum.Add('code', 4);
            Datum.Add('description', 'Pension');
            Data.Add(Datum);

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'STO income types list has been fetched successfully');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateStandingOrderRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        source_account: JsonToken;
        income_type: JsonToken;
        frequency: JsonToken;
        duration: JsonToken;
        start_date: JsonToken;
        description: JsonToken;
        amount: JsonToken;

        destinations: JsonToken;
        destination: JsonToken;
        destination_account_type: JsonToken;
        destination_account_no: JsonToken;
        destination_amount: JsonToken;

        SearchMember: record Members;
        TheSTORequest: Record "Standing Order Header";
        TheSTOLines: Record "Standing Order Lines";
        TheMemberFosaAccount: Record "Savings Accounts";
        TheMemberLoan: Record Loans;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('source_account', source_account);
        Payload.Get('income_type', income_type);
        Payload.Get('frequency', frequency);
        Payload.Get('duration', duration);
        Payload.Get('start_date', start_date);
        Payload.Get('description', description);
        Payload.Get('amount', amount);
        Payload.Get('destinations', destinations);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin

            TheSTORequest.Init;


            TheSTORequest."Source Account Type" := TheSTORequest."Source Account Type"::Savings;

            TheMemberFosaAccount.Reset;
            TheMemberFosaAccount.SetRange("Product Category", TheMemberFosaAccount."Product Category"::"Ordinary Savings");
            TheMemberFosaAccount.SetRange("Member No.", SearchMember."No.");

            if TheMemberFosaAccount.FindFirst then begin
                TheSTORequest."Source Account No." := TheMemberFosaAccount."No.";
                TheSTORequest.Validate("Source Account No.");
            end else begin
                Error('FOSA source account cannot be found!');
            end;

            TheSTORequest.Description := description.AsValue.AsText;
            TheSTORequest.Amount := amount.AsValue.AsDecimal;
            TheSTORequest."Standing Order Type" := income_type.AsValue.AsInteger;

            Evaluate(TheSTORequest."Frequency (Months)", Format(frequency.AsValue.AsInteger) + 'M');
            TheSTORequest."Effective/Start Date" := start_date.AsValue.AsDate;
            TheSTORequest.Validate("Effective/Start Date");
            Evaluate(TheSTORequest."Duration (Months)", Format(duration.AsValue.AsInteger) + 'M');
            TheSTORequest.Validate("Duration (Months)");

            TheSTORequest."Standing Order Type" := TheSTORequest."Standing Order Type"::Internal;
            // TheSTORequest.Type := TheSTORequest.Type::" ";
            // TheSTORequest.Validate(Type);
            TheSTORequest."Transaction Type" := 'STO';
            TheSTORequest."Global Dimension 1 Code" := SearchMember."Global Dimension 1 Code";
            TheSTORequest."Global Dimension 2 Code" := 'FOSA';
            TheSTORequest.Status := TheSTORequest.Status::Open;
            TheSTORequest."Source Application" := TheSTORequest."Source Application"::"Mobile Banking";

            if TheSTORequest.Insert(true) then begin

                TheSTORequest."Standing Order Type" := income_type.AsValue.AsInteger;
                TheSTORequest."Global Dimension 1 Code" := SearchMember."Global Dimension 1 Code";
                TheSTORequest."Global Dimension 2 Code" := 'FOSA';
                TheSTORequest.Status := TheSTORequest.Status::Open;
                TheSTORequest.Modify;

                foreach destination in destinations.AsArray do begin
                    destination.AsObject.Get('destination_account_type', destination_account_type);
                    destination.AsObject.Get('destination_account_no', destination_account_no);
                    destination.AsObject.Get('amount', destination_amount);

                    TheSTOLines.Init();

                    TheSTOLines."Document No." := TheSTOrequest.Code;
                    if destination_account_type.AsValue.AsText = 'SAVINGS' then begin
                        TheSTOLines."Destination Account Type" := TheSTOLines."Destination Account Type"::Internal;
                        TheSTOLines.Validate("Destination Account Type");

                        TheSTOLines."Destination Account No." := destination_account_no.AsValue.AsText;
                        TheSTOLines.Validate("Destination Account No.");
                    end;
                    if destination_account_type.AsValue.AsText = 'LOAN' then begin
                        TheSTOLines."Destination Account Type" := TheSTOLines."Destination Account Type"::Credit;
                        TheSTOLines.Validate("Destination Account Type");

                        if TheMemberLoan.Get(destination_account_no.AsValue.AsText) then begin
                            TheSTOLines."Destination Account No." := TheMemberLoan."Loan Account";
                            TheSTOLines.Validate("Destination Account No.");

                            TheSTOLines."Loan No." := TheMemberLoan."Loan No.";
                        end else begin
                            Error('Destination loan account %1 NOT found', destination_account_no.AsValue.AsText);
                        end;
                    end;

                    TheSTOLines.Amount := destination_amount.AsValue.AsDecimal;
                    TheSTOLines.Validate(Amount);

                    TheSTOLines."Member No." := TheSTORequest."Member No.";

                    TheSTOLines.Insert(true);
                end;

                Datum.Add('application_no', TheSTORequest.Code);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('request_status_description', 'STO application request is successful');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Unable to create STO application request at the moment.');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('request_status_description', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStandingOrderRequests(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheSTORequests: Record "Standing Order Header";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheSTORequests.Reset;
            TheSTORequests.SetRange("Member No.", SearchMember."No.");
            TheSTORequests.SetFilter(Status, '=%1|%2', TheSTORequests.Status::Open, TheSTORequests.Status::Pending);
            TheSTORequests.SetFilter("Source Application", '=%1|%2', TheSTORequests."Source Application"::"Member Portal", TheSTORequests."Source Application"::"Mobile Banking");

            if TheSTORequests.FindSet then begin
                repeat begin
                    Clear(Datum);

                    Datum.Add('application_no', TheSTORequests.Code);
                    Datum.Add('member_no', TheSTORequests."Member No.");
                    Datum.Add('source_account', TheSTORequests."Source Account No.");
                    Datum.Add('source_account_name', TheSTORequests."Source Account Name");
                    Datum.Add('income_type', Format(TheSTORequests."Income Type"));
                    Datum.Add('frequency', Format(TheSTORequests."Frequency (Months)"));
                    Datum.Add('duration', Format(TheSTORequests."Duration (Months)"));
                    Datum.Add('start_date', ddMMyyyy(TheSTORequests."Effective/Start Date"));
                    Datum.Add('amount', TheSTORequests.Amount);
                    Datum.Add('application_date', ddMMyyyy(TheSTORequests."Application Date"));
                    Datum.Add('status', Format(TheSTORequests.Status));
                    Datum.Add('description', TheSTORequests.Description);

                    Data.Add(Datum);
                end until TheSTORequests.Next = 0;
            end;

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'STO application request list has been fetched successfully');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStandingOrderRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        TheSTORequests: Record "Standing Order Header";
        TheSTOLines: Record "Standing Order Lines";
        TheMemberFosaAccount: Record "Savings Accounts";
        TheMemberLoanAccount: Record "Credit Accounts";
        TheMemberLoan: Record Loans;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Destinations: JsonArray;
        Destination: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);

        SearchMember.Reset;
        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheSTORequests.Reset;

            TheSTORequests.SetRange(Code, application_no.AsValue.AsText);
            TheSTORequests.SetRange("Member No.", SearchMember."No.");
            TheSTORequests.SetFilter(Status, '=%1|%2', TheSTORequests.Status::Open, TheSTORequests.Status::Pending);
            TheSTORequests.SetFilter("Source Application", '=%1|%2', TheSTORequests."Source Application"::"Member Portal", TheSTORequests."Source Application"::"Mobile Banking");

            if TheSTORequests.FindFirst then begin
                Datum.Add('application_no', TheSTORequests.Code);
                Datum.Add('member_no', TheSTORequests."Member No.");
                Datum.Add('source_account', TheSTORequests."Source Account No.");
                Datum.Add('source_account_name', TheSTORequests."Source Account Name");
                Datum.Add('income_type', Format(TheSTORequests."Income Type"));
                Datum.Add('frequency', Format(TheSTORequests."Frequency (Months)"));
                Datum.Add('duration', Format(TheSTORequests."Duration (Months)"));
                Datum.Add('start_date', ddMMyyyy(TheSTORequests."Effective/Start Date"));
                Datum.Add('amount', TheSTORequests.Amount);
                Datum.Add('application_date', ddMMyyyy(TheSTORequests."Application Date"));
                Datum.Add('status', Format(TheSTORequests.Status));
                Datum.Add('description', TheSTORequests.Description);

                TheSTOLines.Reset;
                TheSTOLines.SetRange("Document No.", TheSTORequests.Code);

                if TheSTOLines.FindSet then begin
                    repeat begin
                        Clear(Destination);

                        Destination.Add('entry_no', TheSTOLines."Entry No.");
                        Destination.Add('document_no', TheSTOLines."Document No.");
                        Destination.Add('destination_account_type', Format(TheSTOLines."Destination Account Type"));
                        Destination.Add('destination_account_no', TheSTOLines."Destination Account No.");

                        if TheSTOLines."Destination Account Type" = TheSTOLines."Destination Account Type"::Internal then begin
                            if TheMemberFosaAccount.Get(TheSTOLines."Destination Account No.") then begin
                                Destination.Add('destination_account_name', TheMemberFosaAccount.Name);
                                Destination.Add('destination_account_product_name', TheMemberFosaAccount."Product Name");
                                Destination.Add('destination_account_status', Format(TheMemberFosaAccount.Status));
                            end;
                        end;

                        if TheSTOLines."Destination Account Type" = TheSTOLines."Destination Account Type"::Credit then begin
                            if TheMemberLoanAccount.Get(TheSTOLines."Destination Account No.") then begin
                                TheMemberLoan.Reset;
                                TheMemberLoan.SetRange("Loan Account", TheMemberLoanAccount."No.");

                                if TheMemberLoan.FindFirst then begin
                                    Destination.Add('destination_account_name', TheMemberLoan."Member Name");
                                    Destination.Add('destination_account_product_name', TheMemberLoan."Loan Product Type Name");
                                    Destination.Add('destination_account_status', Format(TheMemberLoan.Status));
                                end;
                            end;
                        end;

                        Destinations.Add(Destination);
                    end until TheSTOLines.Next = 0;
                end;

                Datum.Add('destinations', Destinations);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('request_status_description', 'STO application request has been fetched successfully');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'STO application request ' + application_no.AsValue.AsText + ' NOT found');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CancelStandingOrderRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        TheSTORequests: Record "Standing Order Header";
        TheSTOLines: Record "Standing Order Lines";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheSTORequests.Reset;

            TheSTORequests.SetRange(Code, application_no.AsValue.AsText);
            TheSTORequests.SetRange(Status, TheSTORequests.Status::Open);

            if TheSTORequests.FindFirst then begin
                TheSTOLines.Reset;

                TheSTOLines.SetRange("Document No.", TheSTORequests.Code);
                if TheSTOLines.FindSet then begin
                    repeat begin
                        TheSTOLines.Delete(true);
                    end until TheSTOLines.Next = 0;
                end;

                if TheSTORequests.Delete(true) then begin
                    ResponseObject.Add('request_status', 'SUCCESS');
                    ResponseObject.Add('request_status_description', 'STO application request has been cancelled successfully');
                    ResponseObject.Add('response_payload', Datum);
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Unable to cancel STO application request at the moment');
                    ResponseObject.Add('response_payload', Datum);
                end;
            end else begin
                ResponseObject.Add('request_status', 'NOT_FOUND');
                ResponseObject.Add('request_status_description', 'The STO application ' + application_no.AsValue.AsText + ' is NOT available for cancellation');
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('request_status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // Fixed Deposits

    local procedure GetFDAccountsList(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        FDAccountsList: Record "Fixed Deposit Accounts";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            FDAccountsList.Reset;
            FDAccountsList.SetRange("Approval Status", FDAccountsList."Approval Status"::Approved);
            FDAccountsList.SetRange("FD Status", FDAccountsList."FD Status"::Active);
            FDAccountsList.SetRange("Member No.", SearchMember."No.");


            if FDAccountsList.FindSet then begin
                repeat begin
                    Clear(Datum);
                    FDAccountsList.CalcFields("Fixed Account Balance");

                    Datum.Add('account_no', FDAccountsList."No.");
                    Datum.Add('account_name', FDAccountsList.Name);
                    Datum.Add('fixed_amount', FDAccountsList."FD Amount");
                    Datum.Add('balance', FDAccountsList."Fixed Account Balance");
                    Datum.Add('member_no', FDAccountsList."Member No.");
                    Datum.Add('status', Format(FDAccountsList."FD Status"));
                    Datum.Add('product_type', 'FDR');
                    Datum.Add('product_name', 'Fixed Deposit');
                    Datum.Add('registration_date', ddMMyyyy(FDAccountsList."FD Start Date"));
                    Datum.Add('expected_maturity_date', ddMMyyyy(FDAccountsList."FD Maturity Date"));
                    Datum.Add('maturity_instructions', Format(FDAccountsList."FD Maturity Instructions"));

                    Data.Add(Datum);
                end until FDAccountsList.Next = 0;
            end;

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Fixed deposit accounts list has been fetched successfully');
        end else begin
            ResponseObject.Add('request_status', 'NOT_FOUND');
            ResponseObject.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('response_payload', Data);

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetFDAccountMaturityInstructions(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            // "Transfer all to Savings","Renew Principal","Renew Principal & Interest";
            Clear(Datum);
            Datum.Add('code', 1);
            Datum.Add('description', 'Transfer All to Savings Account');
            Data.Add(Datum);

            Clear(Datum);
            Datum.Add('code', 2);
            Datum.Add('description', 'Renew Principal Amount');
            Data.Add(Datum);

            Clear(Datum);
            Datum.Add('code', 3);
            Datum.Add('description', 'Renew Principal + Interest Amount');
            Data.Add(Datum);

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('status_description', 'FD Account maturity instructions list has been fetched successfully');
        end else begin
            ResponseObject.Add('request_status', 'NOT_FOUND');
            ResponseObject.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('response_payload', Data);

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure UpdateFDAccountMaturityRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        account_no: JsonToken;
        maturity_instruction: JsonToken;

        SearchMember: Record Members;
        FDAccount: Record "Fixed Deposit Accounts";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('account_no', account_no);
        Payload.Get('maturity_instruction', maturity_instruction);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            FDAccount.Reset;

            FDAccount.SetRange("No.", account_no.AsValue.AsText);
            FDAccount.SetRange("Member No.", SearchMember."No.");
            FDAccount.SetRange("FD Status", FDAccount."FD Status"::Active);

            if FDAccount.FindFirst then begin
                FDAccount."FD Maturity Instructions" := maturity_instruction.AsValue.AsInteger;

                if FDAccount.Modify(true) then begin
                    ResponseObject.Add('request_status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Fixed deposit maturity request has been updated successfully');
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    ResponseObject.Add('error_message', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end else begin
                ResponseObject.Add('request_status', 'NOT_FOUND');
                ResponseObject.Add('error_message', 'The fixed deposit account ' + account_no.AsValue.AsText + ' is NOT available for update');
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        ResponseObject.Add('response_payload', Datum);

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // COMMON

    local procedure MemberExists(identifier_type: Text; identifier: Text; var SearchMember: Record Members; var ResponseText: Text; var ResponseDescription: Text): Boolean

    var
        Accounts: Record "Savings Accounts";
        phone_no: Text;
    begin
        if identifier = '' then begin
            ResponseText := 'ERROR';
            ResponseDescription := 'Identifier value must NOT be empty!';
            exit(false);
        end;

        Accounts.Reset;

        case identifier_type of
            'MSISDN':
                begin
                    Accounts.SetRange("Transactional Mobile No", ConvertPhoneNo(identifier));
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            'CUSTOMER_NO', 'MEMBER_NO':
                begin

                    Accounts.SetRange("Member No.", identifier);
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            'NATIONAL_ID', 'ID_NUMBER':
                begin

                    Accounts.SetRange("ID No.", identifier);
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            'PASSPORT_NO':
                begin

                    Accounts.SetRange(Passport, identifier);
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            'GROWER_NO':
                begin

                    Accounts.SetRange("Payroll/Staff No.", identifier);
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            else begin
                ResponseText := 'ERROR';
                ResponseDescription := 'Identifier type ' + identifier_type + ' is not valid';
                exit(false);
            end;
        end;

        if Accounts.FindFirst() then begin
            SearchMember.get(Accounts."Member No.");
            ResponseText := 'SUCCESS';
            ResponseDescription := 'Member with' + identifier_type + ' ' + identifier + ' cannot be found';
            exit(true);
        end else begin
            ResponseText := 'FAILED';
            ResponseDescription := 'Member with ' + identifier_type + ' ' + identifier + ' cannot be found';
            exit(false);
        end;
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure GetMemberRecord(var SearchMember: Record Members; IdentifierType: Text; Identifier: Text; MemberTypeLabel: Text) Found: Boolean
    var
        Accounts: Record "Savings Accounts";
        phone_no: Text;
    begin
        Found := false;
        if Identifier = '' then begin
            Error('Identifier value must NOT be empty!');
        end;



        Accounts.Reset;

        case IdentifierType of
            'MSISDN':
                begin
                    /* if CopyStr(identifier, 1, 1) <> '+' then
                        Identifier := '+' + Identifier; */

                    Accounts.SetRange("Transactional Mobile No", ConvertPhoneNo(identifier));
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            'CUSTOMER_NO':
                begin

                    Accounts.SetRange("Member No.", identifier);
                    Accounts.SetFilter("Transactional Mobile No", '<>%1', ''); // Ensure that we only pick members with mobile number for MSISDN search
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            'NATIONAL_ID':
                begin

                    Accounts.SetRange("ID No.", identifier);
                    Accounts.SetFilter("Transactional Mobile No", '<>%1', ''); // Ensure that we only pick members with mobile number for MSISDN search
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            'PASSPORT_NO':
                begin

                    Accounts.SetRange(Passport, identifier);
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            'GROWER_NO':
                begin

                    Accounts.SetRange("Payroll/Staff No.", identifier);
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                end;
            else
                Accounts.SetRange("No.", identifier);
        end;

        IF Accounts.FindFirst() then begin

            SearchMember.get(Accounts."Member No.");

            Found := true;
        end
        else begin
            if MemberTypeLabel = '' then begin
                MemberTypeLabel := 'Member';
            end;

            //Error('%3 with identifier %1 = %2 NOT found!', IdentifierType, Identifier, MemberTypeLabel);
        end;
    end;

    local procedure CheckFOSASavingsAccountBlocked(SearchMember: Record Members; BlockType: Text): Boolean
    var
        FosaAcc: Text;
        MemberSavAcc: Record "Savings Accounts";

    begin
        FosaAcc := Legacy.GetMBankingOrdinaryAccount(SearchMember."No.");

        if FosaAcc <> '' then begin

            MemberSavAcc.Reset;
            MemberSavAcc.SetRange("No.", FosaAcc);
            case BlockType of
                'ALL':
                    begin
                        MemberSavAcc.SetRange(Blocked, MemberSavAcc.Blocked::All);
                    end;
                'CREDIT':
                    begin
                        MemberSavAcc.SetFilter(Blocked, '%1|%2', MemberSavAcc.Blocked::All, MemberSavAcc.Blocked::All);
                    end;
                'DEBIT':
                    begin
                        MemberSavAcc.SetFilter(Blocked, '%1|%2', MemberSavAcc.Blocked::All, MemberSavAcc.Blocked::Payment);
                    end;
                else
                    exit(false);
            end;
            if MemberSavAcc.FindFirst then begin
                exit(true);
            end;

        end;

    end;

    // local procedure FormatPhoneNo(Telephone: Text[50]): Text[50]
    // begin
    //     Telephone := DelChr(Telephone, '=', ' ');

    //     if StrLen(Telephone) = 12 then begin
    //         exit(Telephone);
    //     end;
    //     if StrLen(Telephone) = 13 then begin
    //         Telephone := CopyStr(Telephone, 2, 12);
    //         exit(Telephone);
    //     end;
    //     if StrLen(Telephone) = 10 then begin
    //         if CopyStr(Telephone, 1, 1) = '0' then
    //             Telephone := '254' + CopyStr(Telephone, 2, 9);
    //         exit(Telephone);
    //     end;

    //     if StrLen(Telephone) = 9 then begin
    //         if CopyStr(Telephone, 1, 1) = '7' then
    //             Telephone := '254' + Telephone;
    //         exit(Telephone);
    //     end;
    //     if StrLen(Telephone) > 13 then begin
    //         Telephone := CopyStr(Telephone, StrLen(Telephone) - 9, 10);
    //         if CopyStr(Telephone, 1, 1) = '0' then
    //             Telephone := '254' + CopyStr(Telephone, 2, 9);
    //         exit(Telephone);
    //     end;
    // end;



    local procedure UnsupportedAction(RequestAction: Text): Text
    var
        ResponseObject: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        ResponseObject.Add('request_status', 'ERROR');
        ResponseObject.Add('request_status_description', 'The requested action ' + RequestAction + ' is NOT supported.');
        ResponseObject.Add('errors', Errors);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure AddDateTimeToResponse(var ResponseObject: JsonObject)
    begin
        ResponseObject.Add('date_time', ddMMyyyyTime(CurrentDateTime));
    end;


    procedure ConvertPhoneNo(mobilePhoneNo: Text) NewPhoneNo: Text
    var
        PhoneLength: Integer;
        StPoint: Integer;
    begin
        NewPhoneNo := mobilePhoneNo;

        PhoneLength := StrLen(mobilePhoneNo);
        StPoint := PhoneLength - 8;

        if StPoint > 0 then
            NewPhoneNo := '+254' + CopyStr(mobilePhoneNo, StPoint, 9);
    end;

    procedure RemoveConvertPhoneNo(mobilePhoneNo: Text) NewPhoneNo: Text
    var
        PhoneLength: Integer;
        StPoint: Integer;
    begin
        NewPhoneNo := mobilePhoneNo;

        PhoneLength := StrLen(mobilePhoneNo);
        StPoint := PhoneLength - 8;

        if StPoint > 0 then
            NewPhoneNo := '254' + CopyStr(mobilePhoneNo, StPoint, 9);
    end;

    local procedure PostSkyLoansInterest()
    var

    begin


    end;



    procedure ddMMyyyyTime(Date: Datetime) NewDate: Text
    var
        d: Text;
        m: Text;
        y: Text;
    begin


        d := Format(Date2dmy(Date.Date, 1));
        m := Format(Date2dmy(Date.Date, 2));
        y := Format(Date2dmy(Date.Date, 3));

        if StrLen(d) = 1 then
            d := '0' + d;

        if StrLen(m) = 1 then
            m := '0' + m;

        NewDate := d + '/' + m + '/' + y;

    end;

    procedure ddMMyyyy(Date: Date) NewDate: Text
    var
        d: Text;
        m: Text;
        y: Text;
    begin
        if Date <> 0D then begin

            d := Format(Date2dmy(Date, 1));
            m := Format(Date2dmy(Date, 2));
            y := Format(Date2dmy(Date, 3));

            if StrLen(d) = 1 then
                d := '0' + d;

            if StrLen(m) = 1 then
                m := '0' + m;

            NewDate := d + '/' + m + '/' + y;
        end;
    end;


    procedure ParseDateString(DateStr: Text): Date
    var
        Year: Integer;
        Month: Integer;
        Day: Integer;
        DateParts: List of [Text];
    begin
        // Split the date string by '-'
        DateParts := DateStr.Split('-');

        if DateParts.Count = 3 then begin
            Evaluate(Year, DateParts.Get(1));
            Evaluate(Month, DateParts.Get(2));
            Evaluate(Day, DateParts.Get(3));

            exit(DMY2Date(Day, Month, Year));
        end;

        exit(0D); // Return blank date if parsing fails
    end;

    procedure ParseDateTimeString(DateTimeStr: Text): DateTime
    var
        DatePart: Text;
        TimePart: Text;
        ParsedDate: Date;
        ParsedTime: Time;
        SpacePos: Integer;
    begin
        // Find the space that separates date and time
        SpacePos := StrPos(DateTimeStr, ' ');

        if SpacePos > 0 then begin
            DatePart := CopyStr(DateTimeStr, 1, SpacePos - 1);
            TimePart := CopyStr(DateTimeStr, SpacePos + 1);

            ParsedDate := ParseDateString(DatePart);
            ParsedTime := ParseTimeString(TimePart);

            exit(CreateDateTime(ParsedDate, ParsedTime));
        end;

        exit(0DT); // Return blank datetime if parsing fails
    end;

    procedure ParseTimeString(TimeStr: Text): Time
    var
        Hour: Integer;
        Minute: Integer;
        TimeParts: List of [Text];
    begin
        // Split the time string by ':'
        TimeParts := TimeStr.Split(':');

        if TimeParts.Count = 2 then begin
            Evaluate(Hour, TimeParts.Get(1));
            Evaluate(Minute, TimeParts.Get(2));

            exit(000000T + (Hour * 60 * 60 * 1000) + (Minute * 60 * 1000));
        end;

        exit(0T); // Return blank time if parsing fails
    end;


    procedure GetMobileCharge(TransType: enum "Sky M-Banking Trans Types"; TransAmount: Decimal; var vendorFee: Decimal; var vendorAccount: code[20]; var saccoFee: Decimal; var saccoAccount: code[20]; var safcomFee: Decimal; var safcomAccount: code[20]; var ExciseDutyFee: Decimal; var TotalCharge: Decimal)
    var
        myInt: Integer;
        SkySetup: Record "Sky Mobile Setup.";
        MActivities: Codeunit "Member Activities";
        ChargeDuty: Decimal;
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
    begin
        SkySetup.Reset;
        SkySetup.SetRange("Transaction Type", TransType);
        if SkySetup.FindFirst then begin
            ExciseDutyFee := 0;

            SafcomFee := SkySetup."Safaricom Fee";
            safcomAccount := SkySetup."Safaricom Account";
            if SkySetup."Safcom Staggered Fee" then begin
                ChargeAcct := '';
                ChargeDuty := 0;
                MActivities.GetGeneralChargeAmountOnly(SkySetup."Safcom Staggered Charge", TransAmount, SafcomFee, ChargeDuty, ChargeAcctType, ChargeAcct);
                if ChargeAcct <> '' then
                    safcomAccount := ChargeAcct;
                if ChargeDuty > 0 then
                    ExciseDutyFee += ChargeDuty

            end;



            saccoFee := SkySetup."Sacco Fee";
            saccoAccount := SkySetup."Sacco Fee Account";
            if SkySetup."Sacco Staggered Fee" then begin
                ChargeAcct := '';
                ChargeDuty := 0;
                MActivities.GetGeneralChargeAmountOnly(SkySetup."Sacco Staggered Charge", TransAmount, saccoFee, ChargeDuty, ChargeAcctType, ChargeAcct);
                if ChargeAcct <> '' then
                    saccoAccount := ChargeAcct;
                if ChargeDuty > 0 then
                    ExciseDutyFee += ChargeDuty
            end;


            vendorFee := SkySetup."Vendor Commission";
            vendorAccount := SkySetup."Vendor Commission Account";
            if SkySetup."vendor Staggered Fee" then begin
                ChargeAcct := '';
                ChargeDuty := 0;
                MActivities.GetGeneralChargeAmountOnly(SkySetup."Vendor Staggered Charge", TransAmount, vendorFee, ChargeDuty, ChargeAcctType, ChargeAcct);
                if ChargeAcct <> '' then
                    vendorAccount := ChargeAcct;
                if ChargeDuty > 0 then
                    ExciseDutyFee += ChargeDuty
            end;

            if SkySetup."Total Charges" > 0 then begin
                TotalCharge := SkySetup."Total Charges" - ExciseDutyFee;
                SaccoFee := SkySetup."Total Charges" - (SafcomFee + VendorFee);
            end else
                TotalCharge := SaccoFee + VendorFee + SafcomFee;

        end
        else begin
            ERROR('Setup Missing for %1', TransType);
        end;


    end;

    procedure GetTransChargesPreview(chargeAction: Code[100]; transAmount: Decimal; var chargeAmount: Decimal; var exDutyAmount: Decimal; var totalChargeAmount: Decimal)
    var
        TransType: enum "Sky M-Banking Trans Types";
        vendorFee: Decimal;
        vendorAccount: code[20];
        saccoFee: Decimal;
        saccoAccount: code[20];
        safcomFee: Decimal;
        safcomAccount: code[20];
        ExciseDutyFee: Decimal;
        TotalCharge: Decimal;
    begin
        TotalCharge := 0;
        ExciseDutyFee := 0;

        case chargeAction of
            'MPESA_WITHDRAWAL':
                GetMobileCharge(TransType::"Mpesa Withdrawal", transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
            'AIRTIME_PURCHASE':
                GetMobileCharge(TransType::Airtime, transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
            'BILL_PAYMENT':
                GetMobileCharge(TransType::"Utility Payment", transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
            'BANK_TRANSFER':
                GetMobileCharge(TransType::"Bank Transfer", transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
            'EXTERNAL_BANK_TRANSFER':
                GetMobileCharge(TransType::"External Bank Transfer", transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
            'IFT_ACCOUNT_TO_ACCOUNT':
                GetMobileCharge(TransType::"Account Transfer", transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
            'DEPOSIT':
                GetMobileCharge(TransType::"Mpesa Deposit", transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
            'SINGLE_ACCOUNT_BALANCE_ENQUIRY':
                GetMobileCharge(TransType::"Account Balance Enquiry", transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
            'ACCOUNT_MINI_STATEMENT':
                GetMobileCharge(TransType::"Account Mini-Statement", transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
            'ACCOUNT_FULL_STATEMENT':
                GetMobileCharge(TransType::"Account Full-Statement", transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
            'LOAN_BALANCE_ENQUIRY':
                GetMobileCharge(TransType::"Loan Balance Enquiry", transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
            'LOAN_MINI_STATEMENT':
                GetMobileCharge(TransType::"Loan Mini-Statement", transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
            'LOAN_FULL_STATEMENT':
                GetMobileCharge(TransType::"Loan Full-Statement", transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
            'LOAN_APPLICATION':
                GetMobileCharge(TransType::"Loan Disbursement", transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
            'IFT_LOAN_REPAYMENT':
                GetMobileCharge(TransType::"Pay Loan From Account", transAmount, vendorFee, vendorAccount, saccoFee, saccoAccount, safcomFee, safcomAccount, ExciseDutyFee, TotalCharge);
        end;

        chargeAmount := TotalCharge;
        exDutyAmount := ExciseDutyFee;
        totalChargeAmount := chargeAmount + exDutyAmount;


    end;


    local procedure ATMApplicationRequest(Payload: JsonObject): Text
    var
        originator_id: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        request_application: JsonToken;
        account_no: JsonToken;
        transaction_date_time: JsonToken;

        SearchMember: Record Members;
        ATMApplication: Record "ATM Card Applications";
        MemberAccounts: Record "Savings Accounts";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        FosaAccount: Code[20];
    begin
        // Extract values from payload
        Payload.Get('originator_id', originator_id);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('request_application', request_application);
        Payload.Get('account_no', account_no);
        Payload.Get('transaction_date_time', transaction_date_time);

        // Validate member exists
        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            FosaAccount := (account_no.AsValue.AsText);
            MemberAccounts.Get(FosaAccount);
            if MemberAccounts."ATM No." <> '' then begin
                ResponseObject.Add('request_status', 'DUPLICATE');
                Datum.Add('error_message', 'Member already has an ATM card');
                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            if MemberActivities.GetAccountBalance(FosaAccount) <= 600 then begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Member does not have sufficient balance to apply for an ATM card');
                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // Check for duplicate application
            ATMApplication.Reset();
            ATMApplication.SetRange("Account No", FosaAccount);
            if ATMApplication.FindFirst() then begin
                ResponseObject.Add('request_status', 'DUPLICATE');
                Datum.Add('error_message', 'Member has a pending ATM card application');
                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // Create new ATM application
            ATMApplication.Init();
            ATMApplication.Validate("Account No", FosaAccount);
            ATMApplication."Application Date" := DT2Date(ParseDateTimeString(transaction_date_time.AsValue.AsText));
            //ATMApplication."Originator ID" := originator_id.AsValue.AsText;
            //ATMApplication."Request Channel" := request_application.AsValue.AsText;
            ATMApplication.Status := ATMApplication.Status::Pending;
            ATMApplication."Mobile Application" := true; // Indicate this is a mobile application request

            if ATMApplication.Insert(true) then begin
                ResponseObject.Add('request_status', 'SUCCESS');
                Datum.Add('transaction_reference', ATMApplication."No.");
                Datum.Add('transaction_description', 'Request received successfully');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Unable to create ATM application request');
                ResponseObject.Add('response_payload', Datum);
            end;

        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('request_status_description', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;


    local procedure GetATMCards(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        MemberAccounts: Record "Savings Accounts";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;

        ATM: Record "ATM Applications";
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            MemberAccounts.Reset();
            MemberAccounts.SetRange("Member No.", SearchMember."No.");
            if MemberAccounts.FindSet() then begin
                repeat
                    Clear(Datum);
                    if MemberAccounts."ATM No." <> '' then begin

                        ATM.Reset();
                        ATM.SetRange("Account No", MemberAccounts."No.");
                        if ATM.FindLast() then;

                        Datum.Add('atm_card_name', 'ATM Card - ' + MemberAccounts."Product Name");
                        Datum.Add('atm_label', MemberAccounts."Product Name");
                        Datum.Add('account_holder_name', MemberAccounts.Name);
                        Datum.Add('atm_number', MemberAccounts."ATM No.");
                        Datum.Add('atm_creation_date', Format(ATM."Date Activated"));
                        Datum.Add('atm_expiry_date', format(ATM."Card Expiry Date"));
                        Datum.Add('atm_status', ATM."Card Status");
                        Data.Add(Datum);
                    end

                    else if MemberAccounts."Old ATM No" <> '' then begin
                        Datum.Add('atm_card_name', 'ATM Card - ' + MemberAccounts."Product Name");
                        Datum.Add('atm_label', MemberAccounts."Product Name");
                        Datum.Add('atm_number', MemberAccounts."ATM No.");
                        Data.Add(Datum);
                    end;
                until MemberAccounts.Next() = 0;

                ResponseObject.Add('request_status', 'SUCCESS');
            end else begin
                ResponseObject.Add('request_status', 'SUCCESS'); // Return empty array if no cards found
            end;

            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;


    local procedure ATMCardAction(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        card_status: JsonToken;
        card_number: JsonToken;

        SearchMember: Record Members;
        MemberAccounts: Record "Savings Accounts";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;

        ATM: Record "ATM Applications";
    begin
        // Extract values from payload
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('card_status', card_status);
        Payload.Get('card_number', card_number);

        // Validate member exists
        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            // Find account with ATM card
            MemberAccounts.Reset();
            MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
            MemberAccounts.SetRange("Member No.", SearchMember."No.");
            if card_status.AsValue.AsText = 'ENABLE' then
                MemberAccounts.SetRange("ATM No.", '<>%1', '') // Only find accounts with ATM cards
            else
                MemberAccounts.SetRange("ATM No.", card_number.AsValue.AsText);
            if MemberAccounts.FindFirst() then begin
                case card_status.AsValue.AsText of
                    'ENABLE':
                        begin
                            MemberAccounts."Old ATM No" := MemberAccounts."ATM No.";
                            MemberAccounts."ATM No." := '';
                            if MemberAccounts.Modify(true) then begin
                                ResponseObject.Add('request_status', 'SUCCESS');
                                Datum.Add('transaction_status', 'SUCCESS');
                                Datum.Add('transaction_status_description', 'Card enabled successfully');
                            end else begin
                                ResponseObject.Add('request_status', 'ERROR');
                                Datum.Add('transaction_status', 'ERROR');
                                Datum.Add('transaction_status_description', 'Failed to enable ATM card');
                            end;
                        end;
                    'DISABLE':
                        begin
                            MemberAccounts."ATM No." := MemberAccounts."Old ATM No";
                            MemberAccounts."Old ATM No" := '';
                            if MemberAccounts.Modify(true) then begin
                                ResponseObject.Add('request_status', 'SUCCESS');
                                Datum.Add('transaction_status', 'SUCCESS');
                                Datum.Add('transaction_status_description', 'Card disabled successfully');
                            end else begin
                                ResponseObject.Add('request_status', 'ERROR');
                                Datum.Add('transaction_status', 'ERROR');
                                Datum.Add('transaction_status_description', 'Failed to disable ATM card');
                            end;
                        end;

                    'REPLACE':
                        begin
                            ATM.init();
                            ATM."Card Type" := 'VISA';
                            ATM."Account Type" := ATM."Account Type"::Savings;
                            ATM."Request Type" := ATM."Request Type"::Replacement;
                            ATM.Validate("Account No", MemberAccounts."No.");
                            if ATM.Modify() then begin
                                ResponseObject.Add('request_status', 'SUCCESS');
                                Datum.Add('transaction_status', 'SUCCESS');
                                Datum.Add('transaction_status_description', 'Card Replacement Initiated successfully');
                            end else begin
                                ResponseObject.Add('request_status', 'ERROR');
                                Datum.Add('transaction_status', 'ERROR');
                                Datum.Add('transaction_status_description', 'Failed to disable ATM card');
                            end;
                        end;
                    else begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('transaction_status', 'ERROR');
                        Datum.Add('transaction_status_description', 'Invalid card status. Use ENABLE or DISABLE');
                    end;
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('transaction_status', 'ERROR');
                Datum.Add('transaction_status_description', 'ATM card not found for the given member');
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            Datum.Add('transaction_status', 'ERROR');
            Datum.Add('transaction_status_description', ResponseDescription);
        end;

        Datum.Add('transaction_status_date_time', ddMMyyyyTime(CurrentDateTime));
        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure GetVariationAmount(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        account_type: JsonToken;
        account_number: JsonToken;

        SearchMember: Record Members;
        SavingsAccount: Record "Savings Accounts";
        LoanAccount: Record Loans;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        CurrentAmount: Decimal;
    begin
        // Extract values from payload
        Payload.Get('account_type', account_type);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('account_number', account_number);

        // Validate member exists
        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            case account_type.AsValue.AsText of
                'LOAN':
                    begin
                        // Get loan amount
                        LoanAccount.Reset();
                        LoanAccount.SetRange("Loan No.", account_number.AsValue.AsText);
                        LoanAccount.SetRange("Member No.", SearchMember."No.");
                        if LoanAccount.FindFirst() then begin
                            CurrentAmount := LoanAccount.Repayment;
                            ResponseObject.Add('request_status', 'SUCCESS');
                        end else begin
                            ResponseObject.Add('request_status', 'ERROR');
                            Datum.Add('error_message', 'Loan account not found');
                            ResponseObject.Add('response_payload', Datum);
                            AddDateTimeToResponse(ResponseObject);
                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;
                'FOSA', 'BOSA', 'WITHDRAWABLE', 'DEPOSIT', 'ALL':
                    begin
                        // Get deposit/savings amount
                        SavingsAccount.Reset();
                        SavingsAccount.SetRange("No.", account_number.AsValue.AsText);
                        SavingsAccount.SetRange("Member No.", SearchMember."No.");
                        if SavingsAccount.FindFirst() then begin
                            CurrentAmount := SavingsAccount."Monthly Contribution";
                            ResponseObject.Add('request_status', 'SUCCESS');
                        end else begin
                            ResponseObject.Add('request_status', 'ERROR');
                            Datum.Add('error_message', 'Savings account not found');
                            ResponseObject.Add('response_payload', Datum);
                            AddDateTimeToResponse(ResponseObject);
                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;
                else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Invalid account type');
                    ResponseObject.Add('response_payload', Datum);
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end;

            Clear(Datum);
            Datum.Add('current_amount', CurrentAmount);
            ResponseObject.Add('response_payload', Datum);

        end else begin
            ResponseObject.Add('request_status', ResponseText);
            Datum.Add('error_message', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure AccountVariationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        account_number: JsonToken;
        new_amount: JsonToken;

        SearchMember: Record Members;
        SavingsAccount: Record "Savings Accounts";
        LoanAccount: Record Loans;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        CurrentAmount: Decimal;

        Type: Option LOAN,SAVINGS;
    begin
        // Extract values from payload
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('account_number', account_number);
        Payload.Get('new_amount', new_amount);

        // Validate member exists
        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            // First try savings account
            SavingsAccount.Reset();
            SavingsAccount.SetRange("No.", account_number.AsValue.AsText);
            SavingsAccount.SetRange("Member No.", SearchMember."No.");
            if SavingsAccount.FindFirst() then begin
                // Validate new amount is higher than current
                if new_amount.AsValue.AsDecimal() <= SavingsAccount."Monthly Contribution" then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('transaction_status', 'ERROR');
                    Datum.Add('transaction_status_description', 'New amount must be greater than current amount');
                    Datum.Add('transaction_status_date_time', ddMMyyyyTime(CurrentDateTime));
                    ResponseObject.Add('response_payload', Datum);
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                // Update monthly contribution
                SavingsAccount."Monthly Contribution" := new_amount.AsValue.AsDecimal();
                if SavingsAccount.Modify(true) then begin
                    ResponseObject.Add('request_status', 'SUCCESS');
                    Datum.Add('transaction_status', 'SUCCESS');
                    Datum.Add('transaction_status_description', 'Account variation processed successfully');
                    SkyMbankingTrans.VariationLog(SavingsAccount."Member No.", SavingsAccount."No.", new_amount.AsValue.AsDecimal(), Type::SAVINGS);
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('transaction_status', 'ERROR');
                    Datum.Add('transaction_status_description', 'Failed to update account variation');
                end;
            end else begin
                // Try loan account
                LoanAccount.Reset();
                LoanAccount.SetRange("Loan No.", account_number.AsValue.AsText);
                LoanAccount.SetRange("Member No.", SearchMember."No.");

                if LoanAccount.FindFirst() then begin
                    // Validate new amount is higher than current
                    if new_amount.AsValue.AsDecimal() <= LoanAccount.Repayment then begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('transaction_status', 'ERROR');
                        Datum.Add('transaction_status_description', 'New amount must be greater than current repayment amount');
                        Datum.Add('transaction_status_date_time', ddMMyyyyTime(CurrentDateTime));
                        ResponseObject.Add('response_payload', Datum);
                        AddDateTimeToResponse(ResponseObject);
                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;

                    // Update repayment amount
                    LoanAccount."Adjusted Repayment" := new_amount.AsValue.AsDecimal();
                    if LoanAccount.Modify(true) then begin
                        ResponseObject.Add('request_status', 'SUCCESS');
                        Datum.Add('transaction_status', 'SUCCESS');
                        Datum.Add('transaction_status_description', 'Loan variation processed successfully');

                        SkyMbankingTrans.VariationLog(LoanAccount."Member No.", LoanAccount."Loan No.", new_amount.AsValue.AsDecimal(), Type::LOAN);
                    end else begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('transaction_status', 'ERROR');
                        Datum.Add('transaction_status_description', 'Failed to update loan variation');
                    end;
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('transaction_status', 'ERROR');
                    Datum.Add('transaction_status_description', 'Account/Loan not found');
                end;
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            Datum.Add('transaction_status', 'ERROR');
            Datum.Add('transaction_status_description', ResponseDescription);
        end;

        Datum.Add('transaction_status_date_time', ddMMyyyyTime(CurrentDateTime));
        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure RepaymentSchedule(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_number: JsonToken;

        SearchMember: Record Members;
        LoanAccount: Record Loans;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        RepaymentScheduleReport: Report "Loan Repayment Schedule";
        vConvertedContent: Text;
        varTempBlob: Codeunit "Temp Blob";
        varBase64Conversion: Codeunit "Base64 Convert";
        OStream: OutStream;
        IStream: InStream;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('loan_number', loan_number);

        IF GetMemberRecord(SearchMember, identifier_type.AsValue.AsText, identifier.AsValue.AsText, '') then begin
            // Find the loan account
            LoanAccount.Reset();
            LoanAccount.SetRange("Loan No.", loan_number.AsValue.AsText);
            LoanAccount.SetRange("Member No.", SearchMember."No.");
            LoanAccount.SetRange(Posted, true); // Only posted loans

            if LoanAccount.FindFirst() then begin

                // Generate the repayment schedule report as PDF
                LoanAccount.SetRecFilter(); // Filter to current loan record
                RepaymentScheduleReport.SetTableView(LoanAccount);

                varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);
                RepaymentScheduleReport.SaveAs('', REPORTFORMAT::Pdf, OStream);
                varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
                vConvertedContent := varBase64Conversion.ToBase64(IStream);

                Datum.Add('pdf', vConvertedContent);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan with number ' + loan_number.AsValue.AsText + ' NOT found for the given member');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;


    local procedure UpdatePendingMessages(Payload: JsonObject; RequestAPIId: JsonToken): Text
    var
        ResponseObject: JsonObject;
        ResponsePayload: JsonObject;
        ResponseText: Text;

        messages: JsonToken;

        MsgToken: JsonToken;
        MsgObject: JsonObject;

        StatusCode: JsonToken;
        OriginatorId: JsonToken;

        MsgRec: Record "Sky SMS Messages";

        UpdatedCount: Integer;
    begin

        if not Payload.Get('messages', messages) then begin
            ResponseObject.Add('request_status', 'ERROR');
            ResponsePayload.Add('error_message', 'Missing messages array');
            ResponseObject.Add('response_payload', ResponsePayload);
            ResponseObject.Add('api_request_id', RequestAPIId.AsValue().AsText());

            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(ResponseText);
            exit(ResponseText);
        end;



        foreach MsgToken in messages.AsArray() do begin
            MsgObject := MsgToken.AsObject();

            MsgObject.Get('originator_id', OriginatorId);
            MsgObject.Get('msg_status_code', StatusCode);

            if OriginatorId.AsValue().AsText() = '' then
                continue;

            MsgRec.Reset();
            MsgRec.SetRange("originator_id", OriginatorId.AsValue().AsText());
            if MsgRec.FindSet() then
                repeat
                    MsgRec."msg_status_code" := StatusCode.AsValue().AsInteger();
                    MsgRec.Modify();
                    UpdatedCount += 1;
                until MsgRec.Next() = 0;
        end;

        ResponsePayload.Add('updated_count', UpdatedCount);
        ResponseObject.Add('request_status', 'SUCCESS');
        ResponseObject.Add('response_payload', ResponsePayload);
        ResponseObject.Add('api_request_id', RequestAPIId.AsValue().AsText());

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(ResponseText);
        exit(ResponseText);
    end;

    local procedure GetPendingMessages(Payload: JsonObject; RequestAPIId: JsonToken): Text
    var
        NoOfMessagesTok: JsonToken;
        ResponseObj: JsonObject;
        ResponsePayload: JsonObject;
        MessagesArray: JsonArray;
        MsgRec: Record "Sky SMS Messages";
        NoOfMessages: Integer;
        Count: Integer;
        MsgJson: JsonObject;
        ResponseText: Text;
    begin
        if Payload.Get('number_of_messages', NoOfMessagesTok) and Evaluate(NoOfMessages, NoOfMessagesTok.AsValue().AsText()) then
            NoOfMessages := NoOfMessages
        else
            NoOfMessages := 10;

        MsgRec.Reset();
        MsgRec.SetRange("msg_status_code", 10);
        MsgRec.SetCurrentKey("date_created", msg_priority);
        MsgRec.SetRange(Posted, false);
        MsgRec.SetCurrentKey("date_created");
        MsgRec.Ascending(true);

        Count := 0;

        if MsgRec.FindSet() then
            repeat
                Clear(MsgJson);

                MsgJson.Add('originator_id', MsgRec."originator_id");
                MsgJson.Add('message', MsgRec.msg);
                MsgJson.Add('recipient', MsgRec.receiver);
                MsgJson.Add('msg_category', MsgRec.msg_category);
                MsgJson.Add('date_created', Format(MsgRec."date_created"));
                MsgJson.Add('msg_priority', MsgRec.msg_priority);

                MessagesArray.Add(MsgJson);

                Count += 1;
            until (MsgRec.Next() = 0) or (Count >= NoOfMessages);

        ResponsePayload.Add('messages', MessagesArray);

        ResponseObj.Add('request_status', 'SUCCESS');
        ResponseObj.Add('api_request_id', RequestAPIId.AsValue().AsText());
        ResponseObj.Add('response_payload', ResponsePayload);
        AddDateTimeToResponse(ResponseObj);

        ResponseObj.WriteTo(ResponseText);
        exit(ResponseText);
    end;


    Procedure GetDividendLoanQualifiedAmount(AccountNo: Code[20]; LoanProductType: Code[20]; VAR QualAmt: Decimal; VAR Remark: Text)
    var
        saccoAccount: Record "Savings Accounts";
        Acc: Record "Savings Accounts";
        GeneralSetUp: record "Sacco Setup";
        Legacy: Codeunit Legacy;
        SActivities: Codeunit "SAcco Activities";
        MActivities: Codeunit "Member Activities";
        PSetup: Record "Product Setup";
        Loans: Record Loans;
        nDays: integer;

        SalStart: date;
        sCount: integer;

        Salary1: decimal;
        Salary2: decimal;
        Salary3: decimal;
        SalAvg: Decimal;

        SalEnd: date;

        SalBuffer: Record "Salary Lines";
        NetSal: Decimal;
        STO: Decimal;
        RepAmt: decimal;
        MaxLoanAmount: decimal;
        TotalSalary: decimal;
        SmallestSal: Decimal;
        OldAccount: Record "Sacco Account";
        LBal: Decimal;
        DividendAdvance: Record "M-Dividend Progression";
        DividendAdvanceDefaulter: Record "Dividend Advance - Defaulter";
        MDividend: Record "M-Dividend Progression";
        DividendProgression: record "Dividends Progression";
        SaccoSetup: Record "Sacco Setup";
        DivYear: Text;
        StartDate: date;
        DividendAcc: Record "Savings Accounts";
        MemberActivities: Codeunit "Member Activities";
        Diff: Decimal;
        DivAcc: code[30];
        Unqualified: Record "Unqualified For Dividend Adv";
        BalDate: Date;
        TotArrears: Decimal;
        TArrears: Decimal;
        SaccoActivities: Codeunit "Sacco Activities";
        InterestArrears: Decimal;
        PrincipalArrears: Decimal;
        MonthlyBalance: Decimal;
        DimSetID: Integer;
        ExpectedBal: Decimal;
        CurrentBal: Decimal;
        DaysInArrear: integer;
        PDate: Date;
        ArrearsDate: Date;
        OLDMembers: Record "OLD Member";
        Members: Record Members;
        LoanType: Record "Product Setup";
        DividendBuffer: Record "Dividend Posting";
    begin


        Remark := '';
        QualAmt := 0;
        PrincipalArrears := 0;
        PDate := Today();

        saccoAccount.RESET;
        saccoAccount.SETRANGE("No.", AccountNo);
        IF saccoAccount.FIND('-') THEN BEGIN


            // Transfer Dividend Progression to the Mobile Dividend Progression
            PSetup.Get(saccoAccount."Product Type");
            SaccoSetup.Get();
            StartDate := Calcdate('-1Y+1D', SaccoSetup."Dividend Year Date");
            DivAcc := saccoAccount."No.";// Legacy.GetDepositAccount(saccoAccount."Member No.");
            QualAmt := 0;

            DividendProgression.Reset();
            DividendProgression.setrange("Product Type", PSetup."Product ID");
            DividendProgression.setrange("Account No", DivAcc);
            DividendProgression.SetFilter("Start Date", '%1..%2', CalcDate('-1M', StartDate), DMY2Date(30, 11, 2024));
            DividendProgression.SetFilter("End Date", '<=%1', SaccoSetup."Dividend Year Date");
            if DividendProgression.FindFirst() then begin
                repeat
                    QualAmt += DividendProgression."Net Dividends";
                until DividendProgression.next = 0;
            end;

            LoanType.Get(LoanProductType);


            Members.GET(saccoAccount."Member No.");

            QualAmt := Round(QualAmt, 1, '<');

            QualAmt := QualAmt * LoanType."Appraisal % on Amount" * 0.01;

            MaxLoanAmount := LoanType."Maximum Loan Amount";

            IF QualAmt > MaxLoanAmount THEN
                QualAmt := MaxLoanAmount;


            if QualAmt < 0 then
                QualAmt := 0;

            if LoanType."Restrict to Emp. Code" <> '' then begin
                if Members."Employer Code" <> LoanType."Restrict to Emp. Code" then
                    QualAmt := 0;
            end;

            if LoanType."Restrict to Member Code" <> '' then begin
                if Members."No." <> LoanType."Restrict to Member Code" then
                    QualAmt := 0;
            end;


            LBal := 0;
            Loans.RESET;
            Loans.SETRANGE("Member No.", saccoAccount."Member No.");
            Loans.SETRANGE("Loan Product Type", LoanProductType);
            Loans.SETFILTER("Total Outstanding Balance", '>0');
            IF Loans.FINDFIRST THEN BEGIN
                repeat
                    Loans.CALCFIELDS("Outstanding Principal");
                    LBal += Loans."Outstanding Principal";
                until Loans.next = 0;
            END;


            Acc.Reset();
            Acc.SetRange("Member No.", Members."No.");
            Acc.SetRange("Product Category", PSetup."Product Category"::"Deposit Contribution");
            Acc.SetRange(Status, Acc.Status::Dormant);


            OLDMembers.Reset();
            OLDMembers.SetRange("No.", saccoAccount."Member No.");
            if OLDMembers.FindFirst() then
                QualAmt := 0;

            /*if Acc.FindFirst() then begin

                QualAmt := 0;
                Remark := 'Your account is DORMANT. Activate your deposits account to enjoy our M-Loan services. Dial *470# and follow prompts.';
                EXIT;

            end;*/

        END;
    end;

    local procedure ValidateBusinessShortCode(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        business_short_code: JsonToken;

        SearchMember: Record Members;
        PaybillKeyword: Record "Loan Paybill Keywords";
        ProductSetup: Record "Product Setup";
        MemberSavingsAccount: Record "Savings Accounts";
        MemberLoanAccount: Record Loans;

        ResponseObject: JsonObject;
        AssociatedAccount: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        ShortCodeText: Text;
        AccountName: Text;
        AccountLabel: Text;
        AccountNumber: Text;
        AccountBalance: Decimal;
        BusinessName: Text;
    begin
        // ----------------------------------------------------------
        // Parse request fields
        // ----------------------------------------------------------
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('business_short_code', business_short_code);

        ShortCodeText := business_short_code.AsValue().AsText();

        // ----------------------------------------------------------
        // Guard: short code must not be blank
        // ----------------------------------------------------------
        if ShortCodeText = '' then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'business_short_code must NOT be empty.');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // ----------------------------------------------------------
        // Validate requesting member exists
        // ----------------------------------------------------------
        if not MemberExists(
            identifier_type.AsValue().AsText(),
            identifier.AsValue().AsText(),
            SearchMember,
            ResponseText,
            ResponseDescription)
        then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message',
                'Member with identification ' +
                identifier_type.AsValue().AsText() + ' = ' +
                identifier.AsValue().AsText() + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // ----------------------------------------------------------
        // Look up the keyword (business short code) in the
        // "Loan Paybill Keywords" table.
        // The Keyword field is the primary key, so this is a direct
        // get rather than a filtered find.
        // ----------------------------------------------------------
        if not PaybillKeyword.Get(ShortCodeText) then begin
            ResponseObject.Add('request_status', 'SHORT_CODE_NOT_FOUND');
            Datum.Add('error_message',
                'Business short code ' + ShortCodeText + ' was NOT found.');
            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // ----------------------------------------------------------
        // Resolve business name from the linked Product Setup record.
        // Falls back to the keyword itself if product not found.
        // ----------------------------------------------------------
        BusinessName := ShortCodeText;
        if ProductSetup.Get(PaybillKeyword."Product Code") then
            BusinessName := ProductSetup.Description;

        // ----------------------------------------------------------
        // Resolve the member's account linked to this short code.
        // We use Product Class to know which table to query:
        //   - Savings  → "Savings Accounts" filtered by product type
        //   - Credit   → "Loans" filtered by loan product type
        // ----------------------------------------------------------
        AccountName := '';
        AccountLabel := '';
        AccountNumber := '';
        AccountBalance := 0;

        case PaybillKeyword."Product Class" of

            PaybillKeyword."Product Class"::Savings:
                begin
                    MemberSavingsAccount.Reset();
                    MemberSavingsAccount.SetRange("Member No.", SearchMember."No.");
                    MemberSavingsAccount.SetRange("Product Type", PaybillKeyword."Product Code");
                    MemberSavingsAccount.SetFilter(
                        Status,
                        '<>%1',
                        MemberSavingsAccount.Status::Closed);

                    if MemberSavingsAccount.FindFirst() then begin
                        AccountNumber := MemberSavingsAccount."No.";
                        AccountName := MemberSavingsAccount.Name;

                        // Label mirrors format used in rest of codeunit:
                        // "Product Name (Account No)"
                        if ProductSetup.Get(MemberSavingsAccount."Product Type") then begin
                            if ProductSetup."USSD Product Name" <> '' then
                                AccountLabel := ProductSetup."USSD Product Name"
                            else
                                AccountLabel := MemberSavingsAccount."Product Name";
                        end else
                            AccountLabel := MemberSavingsAccount."Product Name";

                        AccountLabel := AccountLabel + ' (' + AccountNumber + ')';
                        AccountBalance := MemberActivities.GetAccountBalance(AccountNumber);
                    end else begin
                        // Member exists but has no account of this product type
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message',
                            'No savings account of product type ' +
                            PaybillKeyword."Product Code" +
                            ' found for this member.');
                        ResponseObject.Add('response_payload', Datum);
                        AddDateTimeToResponse(ResponseObject);
                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;

            PaybillKeyword."Product Class"::Credit:
                begin
                    MemberLoanAccount.Reset();
                    MemberLoanAccount.SetRange("Member No.", SearchMember."No.");
                    MemberLoanAccount.SetRange("Loan Product Type", PaybillKeyword."Product Code");
                    MemberLoanAccount.SetFilter("Total Outstanding Balance", '>0');
                    MemberLoanAccount.SetRange(Posted, true);
                    MemberLoanAccount.SetAutoCalcFields("Total Outstanding Balance");

                    if MemberLoanAccount.FindFirst() then begin
                        AccountNumber := MemberLoanAccount."Loan No.";
                        AccountName := MemberLoanAccount."Member Name";
                        AccountLabel :=
                            MemberLoanAccount."Loan Product Type Name" +
                            ' (' + AccountNumber + ')';
                        AccountBalance := MemberLoanAccount."Total Outstanding Balance";
                    end else begin
                        // Member has no active loan of this type
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message',
                            'No active loan of product type ' +
                            PaybillKeyword."Product Code" +
                            ' found for this member.');
                        ResponseObject.Add('response_payload', Datum);
                        AddDateTimeToResponse(ResponseObject);
                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;

            else begin
                // Product class is blank/None — keyword exists but is
                // not fully configured yet
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message',
                    'Business short code ' + ShortCodeText +
                    ' is not fully configured. Product class is not set.');
                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        // ----------------------------------------------------------
        // Build the associated_account nested object
        // ----------------------------------------------------------
        AssociatedAccount.Add('account_name', AccountName);
        AssociatedAccount.Add('account_label', AccountLabel);
        AssociatedAccount.Add('account_number', AccountNumber);
        AssociatedAccount.Add('account_balance', AccountBalance);

        // ----------------------------------------------------------
        // Per the spec, business_short_code and business_name sit
        // at the TOP LEVEL of the response (not inside response_payload)
        // ----------------------------------------------------------
        ResponseObject.Add('request_status', 'SUCCESS');
        ResponseObject.Add('business_short_code', ShortCodeText);
        ResponseObject.Add('business_name', BusinessName);

        Datum.Add('associated_account', AssociatedAccount);
        ResponseObject.Add('response_payload', Datum);

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;


    procedure GetMemberFreeShares(MemberNo: Code[20]): Decimal
    var
        MemberAccounts: Record "Savings Accounts";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Committed: Decimal;
        Available: decimal;
        FreeShares: decimal;
        AvailableGuarantorship: Decimal;
        LoanSecurity: Record "Loan Security";
    begin
        MemberAccounts.Reset;
        MemberAccounts.SetRange("Member No.", MemberNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Deposit Contribution");
        //MemberAccounts.SetLoadFields("No.");
        if MemberAccounts.FindFirst then begin

            LoanSecurity.CalculateAvailableShares(MemberAccounts, DepAmt, GuaranteedInApplication, Committed, Available, false);
            FreeShares := Available;

            exit(FreeShares);
        end;
    end;

    local procedure GetSavingsAccountDisplayName(SavingsAccount: Record "Savings Accounts"; DefaultName: Text): Text[100]
    begin
        if (SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Junior Savings") and
           (SavingsAccount."Child Name" <> '')
        then
            exit(CopyStr(SavingsAccount."Child Name", 1, 100));

        if DefaultName <> '' then
            exit(CopyStr(DefaultName, 1, 100));

        exit(SavingsAccount.Name);
    end;

    local procedure NewLine(): Text
    var
        cr: Char;
        lf: Char;
    begin
        cr := 10;
        lf := 13;
        exit(Format(cr));
    end;

    var
        BranchDimensionCode: Label 'BRANCH';
        VendorName: Label 'Mobile Banking - Sky World Limited';
        SkyMbankingTrans: Codeunit "Sky M-Banking Transactions";
        SkySMS: Codeunit "Sky MBanking";
        SMSSource: enum "SMS Source Enum";
        MemberActivities: Codeunit "Member Activities";
        Legacy: Codeunit Legacy;
        Channel: Enum "Transaction Channel";
        chargeAmount: Decimal;
        exDutyAmount: Decimal;
        totalChargeAmount: Decimal;

        vendorFee: Decimal;
        vendorAccount: code[20];
        saccoFee: Decimal;
        saccoAccount: code[20];
        safcomFee: Decimal;
        safcomAccount: code[20];
        ExciseDutyFee: Decimal;
        TotalCharge: Decimal;
        TransType: enum "Sky M-Banking Trans Types";
        MobileWithdrawalsBuffer: Record "Mobile Withdrawal Buffer";
        GrossEligibleAmount: Decimal;
        Reason: Text;
        ApprovedAmt: Decimal;
        LoanIssueDate: Date;
        RefinancingFee: Decimal;
        ExistingLoanBalance: Decimal;
        ProcessingFee: Decimal;
        MonthsSinceIssue: Integer;
        AmountPaid: Decimal;

}
