codeunit 50127 "MobileBankingEngine"
{
    trigger OnRun()
    begin


    end;

    var
        Title: Label 'title';
        Message: Label 'message';
        Status: Label 'status';
        Data: Label 'data';
        Response: Text;

    // ################################################################################################
    // MAIN FUNCTIONS
    // ################################################################################################
    procedure ProcessRequest(Request: Text) Response: Text;
    var
        RequestJson: JsonObject;
        OutputJson: JsonObject;
        RequestDataJson: JsonObject;
        RequestAction: Text;
        SessionId: Text;
        SessionValid: Boolean;
    begin
        if not RequestJson.ReadFrom(Request) then
            Error('Invalid Json Input');

        SessionId := SelectJsonToken(RequestJson, '$.request.session_id').AsValue.AsText;
        RequestAction := SelectJsonToken(RequestJson, '$.request.action').AsValue.AsText;
        RequestDataJson := SelectJsonToken(RequestJson, '$.request.payload.data').AsObject();
        ValidateRequestHash(RequestJson);
        SessionValid := true;

        if not (RequestAction in ['login']) then begin
            SessionValid := ValidateUserSession(RequestJson);
        end;

        if SessionValid then begin
            case RequestAction of
                'get-member-details':
                    begin
                        OutputJson := GetMemberDetails(RequestDataJson);
                    end;
                'get-accounts':
                    begin
                        OutputJson := GetAccounts(RequestDataJson);
                    end;
                'balance-enquiry':
                    begin
                        OutputJson := BalanceEnquiry(RequestDataJson);
                    end;
                'statement-enquiry':
                    begin
                        OutputJson := StatementEnquiry(RequestDataJson);
                    end;
                'pesa-out-request':
                    begin
                        OutputJson := PESAOUTRequest(RequestDataJson);
                    end;
                'pesa-out-confirmation':
                    begin
                        OutputJson := PESAOUTConfirmation(RequestDataJson);
                    end;
                'internal-funds-transfer':
                    begin
                        OutputJson := InternalFundsTransfer(RequestDataJson);
                    end;
                'pesa-in-confirmation':
                    begin
                        OutputJson := PESAINConfirmation(RequestDataJson);
                    end;
                'get-loan-types':
                    begin
                        OutputJson := GetLoanTypes(RequestDataJson);
                    end;
                'check-loan-limit':
                    begin
                        OutputJson := CheckLoanLimit(RequestDataJson);
                    end;
                'loan-application':
                    begin
                        OutputJson := LoanApplication(RequestDataJson);
                    end;
                'get-outstanding-loans':
                    begin
                        OutputJson := GetOutstandingLoans(RequestDataJson);
                    end;
                'get-transaction-charges':
                    begin
                        OutputJson := GetTransCharge(RequestDataJson);
                    end;
                'virtual-member-registration':
                    begin
                        OutputJson := VirtualMemberRegistration(RequestDataJson);
                    end;
            end;
        end
        else begin
            SetResponseStatus(OutputJson, 'error', '401 Unauthorized', 'Your request could not be processed');
        end;

        Response := WrapResponse(RequestJson, OutputJson);
    end;


    // ################################################################################################
    // REQUEST PROCESSING PROCEDURES 
    // ################################################################################################
    local procedure GetMemberDetails(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        Members: Record Members;
        Legacy: Codeunit Legacy;
    begin
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        if (IdentifierType = 'MOBILE_NUMBER') or (IdentifierType = 'MEMBER_NO') or (IdentifierType = 'CUSTOMER_NO') or (IdentifierType = 'NATIONAL_ID_NO') then begin
            Members.Reset();
            if IdentifierType = 'MOBILE_NUMBER' then
                Members.SetRange("Mobile Phone No.", Identifier)
            else
                if (IdentifierType = 'MEMBER_NO') or (IdentifierType = 'CUSTOMER_NO') then
                    Members.SetRange("No.", Identifier)
                else
                    if IdentifierType = 'NATIONAL_ID_NO' then
                        Members.SetRange("ID No.", Identifier)
                    else
                        Error('Invalid Identifier Type');

            if Members.FindFirst() then begin
                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                DataJson.Add('customer_type', 'INDIVIDUAL');

                DataJson.Add('identifier_type', IdentifierType);
                DataJson.Add('identifier', Members."No.");
                DataJson.Add('primary_identity_type', 'NATIONAL_ID');
                DataJson.Add('primary_identity_no', Members."ID No.");
                DataJson.Add('title', '');
                DataJson.Add('full_name', Members.Name);
                DataJson.Add('gender', Format(Members.Gender));
                DataJson.Add('date_of_birth', Members."Date of Birth");
                DataJson.Add('primary_email_address', Members."E-Mail");
                DataJson.Add('primary_mobile_number', Members."Mobile Phone No.");
                DataJson.Add('status', UpperCase(format(Members.Status)));
                DataJson.Add('registration_date', Members."Registration Date");
                DataJson.Add('tax_authority', 'KRA');
                DataJson.Add('tax_authority_pin_number', Members."KRA PIN");
                DataJson.Add('branch_code', Members."Global Dimension 2 Code");
                DataJson.Add('branch', 'NAIROBI');
                DataJson.Add('main_savings_account_no', Legacy.GetOrdinaryAccount(Members."No."));
            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Member does not exist');

            ResponseJson.Add(Data, DataJson);
        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Invalid Identify Type');
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure GetAccounts(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        AccountType: Text;
        IdentifierType: Text;
        Identifier: Text;
        AccountsArray: JsonArray;
        AccountObject: JsonObject;
        Iterator: Integer;
        SavAccount: Record "Savings Accounts";
        CanWithdraw: Text;
    begin
        Iterator := 0;

        AccountType := SelectJsonToken(RequestJson, '$.account_type').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;



        //Get account details
        SavAccount.Reset();
        SavAccount.SetRange("Member No.", Identifier);
        SavAccount.SetFilter("Product Category", '<>%1&<>%2', SavAccount."Product Category"::"Registration Fee", SavAccount."Product Category"::"Fixed Deposit");
        if SavAccount.FindFirst() then begin
            if AccountType <> 'ALL' then
                SavAccount.SetRange(SavAccount."Global Dimension 1 Code", AccountType);
            if SavAccount.FindFirst() then begin
                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                SavAccount.CalcFields("Balance (LCY)");
                repeat
                    /*if SavAccount."Loan Disbursement Account" = true then
                        CanWithdraw := 'YES' else
                        CanWithdraw := 'NO';*/
                    AccountObject.Add('account_name', SavAccount."Product Name");
                    AccountObject.Add('account_label', SavAccount."Product Name");
                    AccountObject.Add('account_number', SavAccount."No.");
                    AccountObject.Add('account_type', AccountType);
                    AccountObject.Add('account_balance', SavAccount."Balance (LCY)");
                    AccountObject.Add('account_status', format(SavAccount.Status));
                    AccountObject.Add('can_withdraw', Format(SavAccount."Loan Disbursement Account"));
                    AccountObject.Add('max_withdrawable_amount', SavAccount.GetAvailableBalance());
                    AccountObject.Add('can_deposit', 'YES');
                    AccountObject.Add('max_deposit_amount', 0.00);

                    AccountsArray.Add(AccountObject);
                    Clear(AccountObject);
                    Iterator := Iterator + 1;
                until SavAccount.Next() = 0;
            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Account Type Invalid');
        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Member account does not exist');


        DataJson.Add('accounts', AccountsArray);


        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure BalanceEnquiry(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        AccountType: Text;
        AccountNumber: Text;
        DocumentNumber: Text;
        SavAccount: Record "Savings Accounts";
        Loan: Record Loans;
        Balance: Decimal;
        Members: Record Members;
        AccountName: Text;
        ProductType: Text;
        AvailableBalance: Decimal;
        //Mob: Codeunit MobileBanking_New;
        BufferTable: Record "ATM Transactions";
        PendingAmount: Decimal;
    //RandText: Text;
    begin
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        AccountType := SelectJsonToken(RequestJson, '$.account_type').AsValue.AsText;
        AccountNumber := SelectJsonToken(RequestJson, '$.account_number').AsValue.AsText;
        DocumentNumber := SelectJsonToken(RequestJson, '$.reference_id').AsValue().AsText;


        if (AccountType = 'ACCOUNT') or (AccountType = 'LOAN') then begin
            //Get Savings Balance
            if AccountType = 'ACCOUNT' then begin
                SavAccount.Reset();
                SavAccount.SetRange("Member No.", Identifier);
                SavAccount.SetRange("No.", AccountNumber);
                if SavAccount.FindFirst() then begin
                    SavAccount.CalcFields("Balance (LCY)");
                    Balance := SavAccount."Balance (LCY)";
                    //get pending transactions
                    PendingAmount := 0;
                    BufferTable.Reset();
                    BufferTable.SetRange("Account No", AccountNumber);
                    BufferTable.Setrange("Transaction Type", 'Withdrawal');
                    BufferTable.SetRange(Posted, false);
                    BufferTable.SetRange(Reversed, false);
                    if BufferTable.FindFirst() then begin
                        BufferTable.CalcSums(Amount);
                        PendingAmount := BufferTable.Amount;
                    end;
                    AvailableBalance := SavAccount.GetAvailableBalance() - PendingAmount;
                    if AvailableBalance < 0 then AvailableBalance := 0;
                    AccountName := SavAccount."Product Name";
                    ProductType := SavAccount."Product Type";

                    DataJson.Add('account_name', AccountName);
                    DataJson.Add('account_label', ProductType);
                    DataJson.Add('account_number', AccountNumber);
                    DataJson.Add('account_type', AccountType);
                    DataJson.Add('account_balance', Balance);
                    DataJson.Add('available_balance', AvailableBalance);
                    //AZIZRandText := Mob.GetBalanceEnquiry(Identifier, DocumentNumber);
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully')
                end else
                    SetResponseStatus(ResponseJson, 'error', 'Error', 'Account does not exist')


            end else begin
                if AccountType = 'LOAN' then begin

                    loan.Reset();
                    Loan.SetRange("Member No.", Identifier);
                    Loan.SetRange("Loan No.", AccountNumber);
                    if loan.FindFirst() then begin
                        loan.CalcFields("Total Outstanding Balance");
                        Balance := loan."Total Outstanding Balance";
                        AccountName := loan."Loan Product Type Name";
                        ProductType := loan."Loan Product Type";
                        DataJson.Add('account_name', AccountName);
                        DataJson.Add('account_label', ProductType);
                        DataJson.Add('account_number', AccountNumber);
                        DataJson.Add('account_type', AccountType);
                        DataJson.Add('account_balance', Balance);
                        DataJson.Add('available_balance', AvailableBalance);
                        //AZIZRandText := Mob.GetBalanceEnquiry(Identifier, DocumentNumber);
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully')
                    end else
                        SetResponseStatus(ResponseJson, 'error', 'Error', 'Loan does not exist');
                end;
            end;
        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Account Type Invalid');

        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure StatementEnquiry(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        AccountType: Text;
        AccountNumber: Text;
        NumberOfTransactions: Integer;
        StartDate: Date;
        EndDate: Date;
        StatementType: Text;

        TransactionsArray: JsonArray;
        TransactionObject: JsonObject;
        Iterator: Integer;
        SavAccount: Record "Savings Accounts";
        SavLedger: Record "Savings Ledger Entry";
        Loans: Record Loans;
        CredLedger: Record "Credit Ledger Entry";
        vConvertedContent: text;
        varTempBlob: CodeUnit "Temp Blob";
        varBase64Conversion: CodeUnit "Base64 Convert";
        OStream: OutStream;
        RecRef: RecordRef;
        IStream: InStream;
        Members: Record Members;
        DocumentNumber: Text;
    //AZIZRandText: Text;
    //AZIZMob: Codeunit MobileBanking_New;

    begin

        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        AccountType := SelectJsonToken(RequestJson, '$.account_type').AsValue.AsText;
        AccountNumber := SelectJsonToken(RequestJson, '$.account_number').AsValue.AsText;
        NumberOfTransactions := SelectJsonToken(RequestJson, '$.number_of_transactions').AsValue.AsInteger();
        StartDate := SelectJsonToken(RequestJson, '$.start_date').AsValue.AsDate;
        EndDate := SelectJsonToken(RequestJson, '$.end_date').AsValue.AsDate;
        StatementType := SelectJsonToken(RequestJson, '$.statement_type').AsValue.AsText;
        DocumentNumber := SelectJsonToken(RequestJson, '$.reference_id').AsValue().AsText;

        if (StatementType = 'MINI_STATEMENT') or (StatementType = 'FULL_STATEMENT') or (StatementType = 'PDF_STATEMENT') then begin
            if (AccountType = 'ACCOUNT') or (AccountType = 'LOAN') then begin
                if AccountType = 'ACCOUNT' then begin

                    SavAccount.Reset();
                    SavAccount.SetRange("No.", AccountNumber);
                    if SavAccount.FindFirst() then begin
                        SavAccount.CalcFields("Balance (LCY)");
                        DataJson.Add('account_name', SavAccount."Product Name");
                        DataJson.Add('account_number', AccountNumber);
                        DataJson.Add('available_balance', SavAccount."Balance (LCY)");
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                        if StatementType = 'MINI_STATEMENT' then begin
                            Iterator := 0;
                            SavLedger.Reset();
                            SavLedger.SetCurrentKey("Posting Date");
                            SavLedger.SetAscending("Posting Date", false);
                            SavLedger.SetRange("Account No.", AccountNumber);
                            if SavLedger.FindSet() then
                                repeat
                                    TransactionObject.Add('transaction_reference', SavLedger."Document No.");
                                    TransactionObject.Add('transaction_date', SavLedger."Posting Date");
                                    TransactionObject.Add('transaction_time', SavLedger."creation Time");
                                    TransactionObject.Add('transaction_amount', SavLedger.Amount);
                                    TransactionObject.Add('running_balance', SavAccount."Balance (LCY)");
                                    TransactionObject.Add('transaction_description', SavLedger.Description);
                                    TransactionObject.Add('other_details', SavLedger.Description);


                                    Clear(TransactionObject);
                                    if Iterator < NumberOfTransactions then
                                        TransactionsArray.Add(TransactionObject);

                                    Iterator := Iterator + 1;
                                until SavLedger.Next() = 0;

                            DataJson.Add('transactions', TransactionsArray);
                        end;
                        if StatementType = 'FULL_STATEMENT' then begin

                            SavLedger.Reset();
                            SavLedger.SetRange("Account No.", AccountNumber);
                            SavLedger.SetRange("Posting Date", StartDate, EndDate);
                            if SavLedger.FindFirst() then
                                repeat
                                    TransactionObject.Add('transaction_reference', SavLedger."Document No.");
                                    TransactionObject.Add('transaction_date', SavLedger."Posting Date");
                                    TransactionObject.Add('transaction_time', SavLedger."Creation Time");
                                    TransactionObject.Add('transaction_amount', SavLedger.Amount);
                                    TransactionObject.Add('running_balance', SavAccount."Balance (LCY)");
                                    TransactionObject.Add('transaction_description', SavLedger.Description);
                                    TransactionObject.Add('other_details', SavLedger.Description);

                                    TransactionsArray.Add(TransactionObject);
                                    Clear(TransactionObject);
                                until SavLedger.Next() = 0;

                            DataJson.Add('transactions', TransactionsArray);
                        end;
                        if StatementType = 'PDF_STATEMENT' then begin
                            SavAccount.Reset();
                            SavAccount.SetRange("No.", AccountNumber);
                            if SavAccount.FindFirst() then begin
                                varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);

                                RecRef.GetTable(SavAccount);
                                Report.SaveAs(Report::"Savings Statement", '', REPORTFORMAT::Pdf, OStream, RecRef);
                                varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
                                vConvertedContent := varBase64Conversion.ToBase64(IStream);
                                DataJson.Add('pdf', vConvertedContent);
                            end;
                        end;
                    end else
                        SetResponseStatus(ResponseJson, 'error', 'Error', 'Account does not exist');
                end;
                if AccountType = 'LOAN' then begin

                    Loans.Reset();
                    Loans.SetRange("Loan No.", AccountNumber);
                    if Loans.FindFirst() then begin
                        Loans.CalcFields("Total Outstanding Balance");
                        DataJson.Add('account_name', Loans."Loan Product Type Name");
                        DataJson.Add('account_number', AccountNumber);
                        DataJson.Add('available_balance', Loans."Total Outstanding Balance");
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                        if StatementType = 'MINI_STATEMENT' then begin
                            Iterator := 0;
                            CredLedger.Reset();
                            CredLedger.SetCurrentKey("Posting Date");
                            CredLedger.SetAscending("Posting Date", false);
                            CredLedger.SetRange("Loan No.", AccountNumber);
                            if CredLedger.FindSet() then
                                repeat
                                    TransactionObject.Add('transaction_reference', CredLedger."Document No.");
                                    TransactionObject.Add('transaction_date', CredLedger."Posting Date");
                                    TransactionObject.Add('transaction_time', CredLedger."Creation Time");
                                    TransactionObject.Add('transaction_amount', CredLedger.Amount);
                                    TransactionObject.Add('running_balance', Loans."Total Outstanding Balance");
                                    TransactionObject.Add('transaction_description', CredLedger.Description);
                                    TransactionObject.Add('other_details', CredLedger.Description);


                                    Clear(TransactionObject);
                                    if Iterator < NumberOfTransactions then
                                        TransactionsArray.Add(TransactionObject);

                                    Iterator := Iterator + 1;
                                until CredLedger.Next() = 0;

                            DataJson.Add('transactions', TransactionsArray);
                        end;
                        if StatementType = 'FULL_STATEMENT' then begin

                            CredLedger.Reset();
                            CredLedger.SetRange("Loan No.", AccountNumber);
                            CredLedger.SetRange("Posting Date", StartDate, EndDate);
                            if CredLedger.FindFirst() then
                                repeat
                                    TransactionObject.Add('transaction_reference', CredLedger."Document No.");
                                    TransactionObject.Add('transaction_date', CredLedger."Posting Date");
                                    TransactionObject.Add('transaction_time', CredLedger."Creation Time");
                                    TransactionObject.Add('transaction_amount', CredLedger.Amount);
                                    TransactionObject.Add('running_balance', Loans."Total Outstanding Balance");
                                    TransactionObject.Add('transaction_description', CredLedger.Description);
                                    TransactionObject.Add('other_details', CredLedger.Description);

                                    TransactionsArray.Add(TransactionObject);
                                    Clear(TransactionObject);
                                until CredLedger.Next() = 0;

                            DataJson.Add('transactions', TransactionsArray);
                        end;
                        if StatementType = 'PDF_STATEMENT' then begin
                            Loans.Reset();
                            Loans.SetRange(Loans."Loan No.", AccountNumber);
                            if Loans.FindFirst() then begin
                                Members.Reset();
                                Members.SetRange("No.", Loans."Member No.");
                                if Members.FindFirst() then
                                    varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);

                                RecRef.GetTable(Members);
                                Report.SaveAs(Report::"Portal Loan Statement", '', REPORTFORMAT::Pdf, OStream, RecRef);
                                varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
                                vConvertedContent := varBase64Conversion.ToBase64(IStream);
                                DataJson.Add('pdf', vConvertedContent);
                            end;
                        end;
                    end else
                        SetResponseStatus(ResponseJson, 'error', 'Error', 'Loan does not exist');
                end;

                ResponseJson.Add(Data, DataJson);
                //AZIZRandText := Mob.GetBalanceEnquiry(Identifier, DocumentNumber);
            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Account Type Invalid');
        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Invalid statement type');


    end;


    // ------------------------------------------------------------------------------------------------
    local procedure PESAOUTRequest(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;

        OriginatorID: Text;
        ProductID: Text;
        PesaType: Text;
        TransactionAction: Text;
        Command: Text;
        TransactionInitiatorIdentifierType: Text;
        TransactionInitiatorIdentifier: Text;
        TransactionInitiatorAccount: Text;
        TransactionInitiatorName: Text;
        TransactionInitiatorReference: Text;
        TransactionSourceIdentifierType: Text;
        TransactionSourceIdentifier: Text;
        TransactionSourceAccount: Text;
        TransactionSourceName: Text;
        TransactionSenderIdentifierType: Text;
        TransactionSenderIdentifier: Text;
        TransactionSenderAccount: Text;
        TransactionSenderName: Text;
        TransactionReceiverIdentifierType: Text;
        TransactionReceiverIdentifier: Text;
        TransactionReceiverAccount: Text;
        TransactionReceiverName: Text;
        TransactionBeneficiaryIdentifierType: Text;
        TransactionBeneficiaryIdentifier: Text;
        TransactionBeneficiaryAccount: Text;
        TransactionBeneficiaryName: Text;
        Amount: Decimal;
        Category: Text;
        TransactionDescription: Text;
        SourceReference: Text;
        RequestApplication: Text;
        SourceApplication: Text;
        TransactionDateTime: Text;
        //AZIZMob: Codeunit MobileBanking_New;
        Response: Text;
    begin
        OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
        ProductID := SelectJsonToken(RequestJson, '$.product_id').AsValue.AsText;
        PesaType := SelectJsonToken(RequestJson, '$.pesa_type').AsValue.AsText;
        TransactionAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;
        Command := SelectJsonToken(RequestJson, '$.command').AsValue.AsText;

        TransactionInitiatorIdentifierType := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier_type').AsValue.AsText;
        TransactionInitiatorIdentifier := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier').AsValue.AsText;
        TransactionInitiatorAccount := SelectJsonToken(RequestJson, '$.transaction_initiator_details.account').AsValue.AsText;
        TransactionInitiatorName := SelectJsonToken(RequestJson, '$.transaction_initiator_details.name').AsValue.AsText;
        TransactionInitiatorReference := SelectJsonToken(RequestJson, '$.transaction_initiator_details.reference').AsValue.AsText;

        TransactionSourceIdentifierType := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier_type').AsValue.AsText;
        TransactionSourceIdentifier := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier').AsValue.AsText;
        TransactionSourceAccount := SelectJsonToken(RequestJson, '$.transaction_source_details.account').AsValue.AsText;
        TransactionSourceName := SelectJsonToken(RequestJson, '$.transaction_source_details.name').AsValue.AsText;

        TransactionSenderIdentifierType := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier_type').AsValue.AsText;
        TransactionSenderIdentifier := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier').AsValue.AsText;
        TransactionSenderAccount := SelectJsonToken(RequestJson, '$.transaction_sender_details.account').AsValue.AsText;
        TransactionSenderName := SelectJsonToken(RequestJson, '$.transaction_sender_details.name').AsValue.AsText;

        TransactionReceiverIdentifierType := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier_type').AsValue.AsText;
        TransactionReceiverIdentifier := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier').AsValue.AsText;
        TransactionReceiverAccount := SelectJsonToken(RequestJson, '$.transaction_receiver_details.account').AsValue.AsText;
        TransactionReceiverName := SelectJsonToken(RequestJson, '$.transaction_receiver_details.name').AsValue.AsText;

        TransactionBeneficiaryIdentifierType := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier_type').AsValue.AsText;
        TransactionBeneficiaryIdentifier := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier').AsValue.AsText;
        TransactionBeneficiaryAccount := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.account').AsValue.AsText;
        TransactionBeneficiaryName := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.name').AsValue.AsText;

        Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
        Category := SelectJsonToken(RequestJson, '$.category').AsValue.AsText;
        TransactionDescription := SelectJsonToken(RequestJson, '$.transaction_description').AsValue.AsText;
        SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
        RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
        SourceApplication := SelectJsonToken(RequestJson, '$.source_application').AsValue.AsText;
        TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;


        //AZIZResponse := Mob.MsaccoWithdrawalRequest(OriginatorID, TransactionSourceAccount, OriginatorID, Amount, Category);
        if Response <> 'Success' then
            SetResponseStatus(ResponseJson, 'FAIL', 'Fail', Response) else
            if Response = 'Success' then
                SetResponseStatus(ResponseJson, 'success', 'SUCCESS', 'Request processed successfully');

        DataJson.Add('transaction_reference', OriginatorID);
        DataJson.Add('transaction_status_description', Response);
        DataJson.Add('transaction_date_time', CurrentDateTime);

        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure PESAOUTConfirmation(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        OriginatorID: Text;
        TransactionStatus: Text;
        TransactionStatusDescription: Text;
        BeneficiaryIdentifierType: Text;
        BeneficiaryIdentifier: Text;
        BeneficiaryName: Text;
        BeneficiaryReference: Text;
        TransactionDateTime: Text;
        MPESATRANS: Record "Sky Transactions.";
        BufferTable: Record "ATM Transactions";
    //AZIZMob: Codeunit MobileBanking_New;
    begin
        OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
        TransactionStatus := SelectJsonToken(RequestJson, '$.transaction_status').AsValue.AsText;
        TransactionStatusDescription := SelectJsonToken(RequestJson, '$.transaction_status_description').AsValue.AsText;

        BeneficiaryIdentifierType := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier_type').AsValue.AsText;
        BeneficiaryIdentifier := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier').AsValue.AsText;
        BeneficiaryName := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.name').AsValue.AsText;

        BeneficiaryReference := SelectJsonToken(RequestJson, '$.beneficiary_reference').AsValue.AsText;
        TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;

        if TransactionStatus = 'CONFIRMED' then begin

            BufferTable.Reset();
            BufferTable.SetRange("Reference No", OriginatorID);
            BufferTable.SetRange(Posted, false);
            if BufferTable.FindFirst() then begin

                /*
                MPESATRANS.Init;
                MPESATRANS."Document No." := OriginatorID;
                MPESATRANS.Trace := BeneficiaryReference;
                MPESATRANS.Description := TransactionStatusDescription;
                MPESATRANS."Telephone No" := BeneficiaryIdentifier;
                MPESATRANS."Account No." := BufferTable."Account No";
                MPESATRANS.Amount := BufferTable.Amount;
                MPESATRANS."Transaction Type" := 'Withdrawal';
                MPESATRANS."Document Date" := Today;
                MPESATRANS."Transaction Date Time" := Format(CurrentDateTime);
                MPESATRANS.Posted := false;
                MPESATRANS."Transaction Reference" := OriginatorID;
                MPESATRANS."Transaction Category" := BufferTable."Transaction Description";
                MPESATRANS.Insert;

                if BufferTable."Transaction Description" = 'MPESA_WITHDRAWAL' then
                    Mob.PostMPESAWithdrawals(OriginatorID) else
                    Mob.PostUtilityPayments(OriginatorID);

                */
                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                DataJson.Add('transaction_status', 'SUCCESS');
                DataJson.Add('transaction_status_description', 'Result processed successfully');
                DataJson.Add('transaction_date_time', CurrentDateTime);

            end else
                SetResponseStatus(ResponseJson, 'success', 'Success', 'Invalid originator ID');
            ResponseJson.Add(Data, DataJson);
        end;
        if TransactionStatus = 'REVERSE_CONFIRMED' then begin
            BufferTable.Reset();
            BufferTable.SetRange("Reference No", OriginatorID);
            if BufferTable.FindFirst() then begin
                BufferTable.Reversed := true;
                // Using this to confirm why its always marking reversed true
                BufferTable."Reversed Posted" := true;
                BufferTable."Transaction Description" := (BufferTable."Transaction Description" + '_Reversed');
                if BufferTable.Modify() then begin
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Transaction reversed successfully');
                    DataJson.Add('transaction_status', 'SUCCESS');
                    DataJson.Add('transaction_status_description', 'Transaction reversed successfully');
                    DataJson.Add('transaction_date_time', CurrentDateTime);
                end;
            end;
            ResponseJson.Add(Data, DataJson);
        end;
        /*if (TransactionStatus <> 'REVERSE_CONFIRMED') or (TransactionStatus <> 'CONFIRMED') then begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
        end;*/

    end;

    // ------------------------------------------------------------------------------------------------
    local procedure InternalFundsTransfer(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        OriginatorID: Text;
        IdentifierType: Text;
        Identifier: Text;
        SourceAccount: Text;
        DestinationAccount: Text;
        Amount: Decimal;
        SourceReference: Text;
        RequestApplication: Text;
        SourceApplication: Text;
        TransactionDescription: Text;
        TransactionDateTime: Text;
        SavAccount: Record "Savings Accounts";
        MPESATRANS: Record "Sky Transactions.";
        //AZIZMob: Codeunit MobileBanking_New;
        Members: Record Members;
    begin
        OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        SourceAccount := SelectJsonToken(RequestJson, '$.source_account').AsValue.AsText;
        DestinationAccount := SelectJsonToken(RequestJson, '$.destination_account').AsValue.AsText;
        Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
        SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
        RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
        SourceApplication := SelectJsonToken(RequestJson, '$.source_application').AsValue.AsText;
        TransactionDescription := SelectJsonToken(RequestJson, '$.transaction_description').AsValue.AsText;
        TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;

        if Members.Get(Identifier) then begin
            //verify account
            SavAccount.Reset();
            SavAccount.SetRange("Member No.", Identifier);
            SavAccount.SetRange("No.", SourceAccount);
            if SavAccount.FindFirst() then begin

                if SavAccount.get(SourceAccount) then begin
                    //get account balance
                    if SavAccount.GetAvailableBalance() > Amount then begin
                        // if SavAccount.get(DestinationAccount) then begin

                        /*
                        MPESATRANS.Init;
                        MPESATRANS."Document No." := SourceReference;
                        MPESATRANS.Description := 'Mobile Funds Transfer -' + SourceReference;
                        MPESATRANS."Account No." := DestinationAccount;
                        MPESATRANS.Amount := Amount;
                        MPESATRANS."Transaction Type" := 'Funds Transfer';
                        MPESATRANS."Document Date" := Today;
                        MPESATRANS."Transaction Date Time" := Format(CurrentDateTime);
                        MPESATRANS."Key Word" := '';
                        MPESATRANS.Posted := false;
                        MPESATRANS."Telephone No" := Identifier;
                        MPESATRANS."Source Account" := SourceAccount;
                        MPESATRANS.Insert;

                        Mob.PostMsaccoFundsTransfer(DestinationAccount, SourceAccount, Amount, SourceReference);
                        */
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                        DataJson.Add('transaction_reference', SourceReference);
                        DataJson.Add('transaction_status', 'SUCCESS');
                        DataJson.Add('transaction_status_description', 'Transfer posted successfully');

                        ResponseJson.Add(Data, DataJson);
                        //end else
                        //SetResponseStatus(ResponseJson, 'error', 'Error', 'Destination Account does not exist');
                    end else
                        SetResponseStatus(ResponseJson, 'error', 'Error', 'Insufficient balance');
                end else
                    SetResponseStatus(ResponseJson, 'error', 'Error', 'Source Account does not exist');
            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Source account does not match identifier');

        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Member does not exist');
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure PESAINConfirmation(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        OriginatorID: Text;
        PesaType: Text;
        TransactionAction: Text;
        Command: Text;
        Sensitivity: Text;
        Charge: Decimal;
        IdentifierType: Text;
        Identifier: Text;
        TransactionInitiatorIdentifierType: Text;
        TransactionInitiatorIdentifier: Text;
        TransactionInitiatorAccount: Text;
        TransactionInitiatorName: Text;
        TransactionInitiatorReference: Text;
        TransactionSourceIdentifierType: Text;
        TransactionSourceIdentifier: Text;
        TransactionSourceAccount: Text;
        TransactionSourceName: Text;
        TransactionSourceReference: Text;
        TransactionSenderIdentifierType: Text;
        TransactionSenderIdentifier: Text;
        TransactionSenderAccount: Text;
        TransactionSenderName: Text;
        TransactionSenderReference: Text;
        TransactionReceiverIdentifierType: Text;
        TransactionReceiverIdentifier: Text;
        TransactionReceiverAccount: Text;
        TransactionReceiverName: Text;
        TransactionBeneficiaryIdentifierType: Text;
        TransactionBeneficiaryIdentifier: Text;
        TransactionBeneficiaryAccount: Text;
        TransactionBeneficiaryName: Text;
        TransactionReceiverReference: Text;
        Amount: Decimal;
        TransactionDescription: Text;
        SourceReference: Text;
        RequestApplication: Text;
        SourceApplication: Text;
        TransactionDateTime: Text;
        MPESATRANS: Record "Sky Transactions.";
        //AZIZMob: Codeunit MobileBanking_New;
        Member: Record Members;
    begin
        OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
        PesaType := SelectJsonToken(RequestJson, '$.pesa_type').AsValue.AsText;
        TransactionAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;
        Command := SelectJsonToken(RequestJson, '$.command').AsValue.AsText;
        Sensitivity := SelectJsonToken(RequestJson, '$.sensitivity').AsValue.AsText;
        Charge := SelectJsonToken(RequestJson, '$.charge').AsValue.AsDecimal;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        TransactionInitiatorIdentifierType := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier_type').AsValue.AsText;
        TransactionInitiatorIdentifier := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier').AsValue.AsText;
        TransactionInitiatorAccount := SelectJsonToken(RequestJson, '$.transaction_initiator_details.account').AsValue.AsText;
        TransactionInitiatorName := SelectJsonToken(RequestJson, '$.transaction_initiator_details.name').AsValue.AsText;
        TransactionInitiatorReference := SelectJsonToken(RequestJson, '$.transaction_initiator_details.reference').AsValue.AsText;

        TransactionSourceIdentifierType := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier_type').AsValue.AsText;
        TransactionSourceIdentifier := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier').AsValue.AsText;
        TransactionSourceAccount := SelectJsonToken(RequestJson, '$.transaction_source_details.account').AsValue.AsText;
        TransactionSourceName := SelectJsonToken(RequestJson, '$.transaction_source_details.name').AsValue.AsText;
        TransactionSourceReference := SelectJsonToken(RequestJson, '$.transaction_source_details.reference').AsValue.AsText;

        TransactionSenderIdentifierType := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier_type').AsValue.AsText;
        TransactionSenderIdentifier := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier').AsValue.AsText;
        TransactionSenderAccount := SelectJsonToken(RequestJson, '$.transaction_sender_details.account').AsValue.AsText;
        TransactionSenderName := SelectJsonToken(RequestJson, '$.transaction_sender_details.name').AsValue.AsText;
        TransactionSenderReference := SelectJsonToken(RequestJson, '$.transaction_sender_details.reference').AsValue.AsText;

        TransactionReceiverIdentifierType := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier_type').AsValue.AsText;
        TransactionReceiverIdentifier := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier').AsValue.AsText;
        TransactionReceiverAccount := SelectJsonToken(RequestJson, '$.transaction_receiver_details.account').AsValue.AsText;
        TransactionReceiverName := SelectJsonToken(RequestJson, '$.transaction_receiver_details.name').AsValue.AsText;
        TransactionReceiverReference := SelectJsonToken(RequestJson, '$.transaction_receiver_details.reference').AsValue.AsText;

        TransactionBeneficiaryIdentifierType := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier_type').AsValue.AsText;
        TransactionBeneficiaryIdentifier := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier').AsValue.AsText;
        TransactionBeneficiaryAccount := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.account').AsValue.AsText;
        TransactionBeneficiaryName := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.name').AsValue.AsText;

        Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
        TransactionDescription := SelectJsonToken(RequestJson, '$.transaction_description').AsValue.AsText;
        SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
        RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
        SourceApplication := SelectJsonToken(RequestJson, '$.source_application').AsValue.AsText;
        TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;


        /*
        //if Member.Get(Identifier) then begin
        MPESATRANS.INIT;
        MPESATRANS."Document No." := SourceReference;
        MPESATRANS.Description := TransactionDescription;
        MPESATRANS."Account No." := TransactionReceiverAccount;
        MPESATRANS.Amount := Amount;
        MPESATRANS."Transaction Type" := 'Deposit';
        MPESATRANS."Document Date" := Today;
        MPESATRANS."Transaction Date Time" := Format(TransactionDateTime);
        MPESATRANS."Transaction Time" := Time;
        MPESATRANS.Posted := FALSE;
        MPESATRANS."Telephone No" := Member."Mobile Phone No.";
        MPESATRANS."Transaction Reference" := OriginatorID;
        MPESATRANS.Insert();

        Mob.PostDeposits(SourceReference);
        */

        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

        DataJson.Add('transaction_reference', OriginatorID);
        DataJson.Add('transaction_status', 'SUCCESS');
        DataJson.Add('transaction_status_description', 'Transaction processed successfully');
        DataJson.Add('transaction_date_time', TransactionDateTime);
        /*end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Member does not exist');*/

        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure GetLoanTypes(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        LoanTypesArray: JsonArray;
        LoanTypeObject: JsonObject;
        Iterator: Integer;
        ProdFactory: Record "Product Setup";
    begin
        Iterator := 0;

        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;


        ProdFactory.Reset();
        ProdFactory.SetRange("Available on Mobile", true);
        if ProdFactory.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
            repeat
                LoanTypeObject.Add('loan_type_id', ProdFactory."Product ID");
                LoanTypeObject.Add('loan_type_name', ProdFactory."Description");
                LoanTypeObject.Add('loan_type_min_amount', ProdFactory."Minimum Loan Amount");
                LoanTypeObject.Add('loan_type_max_amount', ProdFactory."Maximum Loan Amount");

                LoanTypesArray.Add(LoanTypeObject);
                Clear(LoanTypeObject);
            until ProdFactory.Next() = 0;
            DataJson.Add('loan_types', LoanTypesArray);
        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'No product exists');

        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure CheckLoanLimit(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        OriginatorID: Text;
        IdentifierType: Text;
        Identifier: Text;
        LoanTypeID: Text;
        Loans: Record Loans;
        ProdFactory: Record "Product Setup";
        Members: Record Members;
        EligibleAmt: Decimal;
        Customer: Record Customer;

    begin
        OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        LoanTypeID := SelectJsonToken(RequestJson, '$.loan_type_id').AsValue.AsText;

        if Members.get(Identifier) then begin
            //Get product
            if ProdFactory.Get(LoanTypeID) then begin
                EligibleAmt := ProdFactory."Maximum Loan Amount";

                if Customer.get(Members."Employer Code") then begin
                    //if Customer."Mobile Withdrawal Limit" > 0 then
                    //  EligibleAmt := Customer."Mobile Withdrawal Limit";
                end;

                //check defaulted loan
                Loans.Reset();
                Loans.SetRange("Member No.", Identifier);
                Loans.SetRange("Loan Product Type", LoanTypeID);
                Loans.SetFilter("Loans Category-SACCO", '%1|%2|%3', Loans."Loans Category-SACCO"::Substandard, Loans."Loans Category-SACCO"::Doubtful, Loans."Loans Category-SACCO"::Loss);
                Loans.SetFilter("Total Outstanding Balance", '>%1', 0);
                if Loans.FindFirst() then EligibleAmt := 0;

                //Check for existing Mobile Loan
                Loans.Reset();
                Loans.SetRange("Member No.", Identifier);
                Loans.SetRange("Loan Product Type", LoanTypeID);
                Loans.SetFilter("Total Outstanding Balance", '>%1', 0);
                if Loans.FindFirst() then EligibleAmt := 0;

                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                DataJson.Add('loan_type_id', LoanTypeID);
                DataJson.Add('loan_name', ProdFactory."Description");
                DataJson.Add('eligible_amount', EligibleAmt);

            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Product is not valid');
        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Member does not exist');

        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure LoanApplication(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        OriginatorID: Text;
        IdentifierType: Text;
        Identifier: Text;
        LoanTypeID: Text;
        Amount: Decimal;
        SourceReference: Text;
        RequestApplication: Text;
        TransactionDateTime: Text;
        Loans: Record Loans;
        ProdFactory: Record "Product Setup";
        Members: Record Members;
        MsaccoLoans: Record "Sky Mobile Loans";
    //AZIZMob: Codeunit MobileBanking_New;
    begin
        OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        LoanTypeID := SelectJsonToken(RequestJson, '$.loan_type_id').AsValue.AsText;
        Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
        SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
        RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
        TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;


        MsaccoLoans.Reset();
        MsaccoLoans.SetRange(DocumentNo, SourceReference);
        if not MsaccoLoans.FindFirst() then begin
            //check member
            if Members.get(Identifier) then begin
                //check existing product
                Loans.Reset;
                Loans.SetRange("Member No.", Identifier);
                Loans.SetRange("Loan Product Type", LoanTypeID);
                Loans.SetFilter("Total Outstanding Balance", '>0');
                if not Loans.Find('-') then begin

                    //getProduct
                    ProdFactory.Reset();
                    ProdFactory.SetRange("Product ID", LoanTypeID);
                    if ProdFactory.FindFirst() then begin
                        //get Member
                        Members.Reset();
                        Members.SetRange(Members."No.", Identifier);
                        if Members.FindFirst() then
                            MsaccoLoans.INIT;
                        MsaccoLoans."Account No" := Members."No.";
                        MsaccoLoans.Date := CURRENTDATETIME;
                        MsaccoLoans."Requested Amount" := amount;
                        MsaccoLoans.Amount := amount;
                        MsaccoLoans.Posted := FALSE;
                        MsaccoLoans.Status := MsaccoLoans.Status::Pending;
                        MsaccoLoans.DocumentNo := SourceReference;
                        MsaccoLoans."Loan Product Type" := LoanTypeID;
                        MsaccoLoans.INSERT;
                        //AZIZMob.ProcessAdvanceLoansFinal(SourceReference);
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                        //Get Loan No
                        Loans.Reset();
                        Loans.SetRange("Loan No.", SourceReference);
                        if Loans.FindFirst() then
                            DataJson.Add('transaction_reference', SourceReference);

                        DataJson.Add('loan_serial_number', Loans."Loan No.");
                        DataJson.Add('loan_type_id', LoanTypeID);
                        DataJson.Add('loan_name', ProdFactory."Description");
                        DataJson.Add('amount', Amount);
                    end else
                        SetResponseStatus(ResponseJson, 'error', 'Error', 'Product is not valid');
                end else
                    SetResponseStatus(ResponseJson, 'error', 'Error', 'Member has exisiting loan of this product');
            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Member does not exist');
        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Source reference already exists');

        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure GetOutstandingLoans(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        LoansArray: JsonArray;
        LoanObject: JsonObject;
        Iterator: Integer;
        Loans: Record Loans;
        Members: Record Members;

    begin
        Iterator := 0;

        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        if Members.get(Identifier) then begin
            SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
            Loans.Reset();
            Loans.SetRange("Member No.", Identifier);
            Loans.SetFilter("Total Outstanding Balance", '>%1', 0);
            if Loans.FindFirst() then begin

                repeat
                    Loans.CalcFields("Loans Category-SACCO", "Total Outstanding Balance");
                    LoanObject.Add('loan_serial_number', Loans."Loan No.");
                    LoanObject.Add('loan_type_id', Loans."Loan Product Type");
                    LoanObject.Add('loan_type_name', Loans."Loan Product Type Name");
                    LoanObject.Add('loan_amount', Loans."Approved Amount");
                    LoanObject.Add('loan_balance', Loans."Total Outstanding Balance");
                    LoanObject.Add('installment_amount', loans.Repayment);
                    LoanObject.Add('loan_defaulted_amount', Loans."Total Arrears");
                    LoanObject.Add('loan_issued_date', Loans."Disbursement Date");
                    LoanObject.Add('loan_end_date', Loans."Completion Date");
                    LoanObject.Add('loan_performance', Format(Loans."Loans Category-SACCO"));
                    LoanObject.Add('loan_performance_description', StrSubstNo('Loan is %1', Format(Loans."Loans Category-SACCO")));

                    LoansArray.Add(LoanObject);
                    Clear(LoanObject);
                    Iterator := Iterator + 1;
                until Loans.Next() = 0;
            end;

            DataJson.Add('loans', LoansArray);

        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Member does not exist');

        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure GetTransCharge(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        TransactionType: Text;
        TransactionAmount: Decimal;
        TransType: Record "Transaction Charges";
        TransCharge: Record "Transaction Charges";
        ChargeAmount: Decimal;
        //AZIZTariffDetails: Record "Tiered Charges Lines";
        ProductID: code[30];
        ExciseDutyAmt: Decimal;
        GenSet: Record "Sacco Setup";
        ExcisableAmt: Decimal;
    begin
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        TransactionType := SelectJsonToken(RequestJson, '$.transaction_type').AsValue.AsText;
        TransactionAmount := SelectJsonToken(RequestJson, '$.transaction_amount').AsValue.AsDecimal;
        //ProductID := SelectJsonToken(RequestJson, '$.product_id').AsValue.AsCode;

        GenSet.Get;
        /*
        TransType.Reset();
        TransType.SetRange(TransType."Mobile Transaction Type", TransactionType);
        if TransType.FindFirst() then
            TransCharge.Reset;
        TransCharge.SetRange(TransCharge."Transaction Type", TransType.Code);
        if TransCharge.Find('-') then begin
            repeat

                ChargeAmount := 0;
                ExcisableAmt := 0;
                if TransCharge."Charge Type" = TransCharge."Charge Type"::"% of Amount" = true then
                    ChargeAmount := (TransactionAmount * TransCharge."Percentage of Amount") * 0.01
                else
                    ChargeAmount := TransCharge."Charge Amount";

                if TransCharge."Charge Type" = TransCharge."Charge Type"::Staggered then begin

                    TransCharge.TestField(TransCharge."Staggered Charge Code");

                    TariffDetails.Reset;
                    TariffDetails.SetRange(TariffDetails.Code, TransCharge."Staggered Charge Code");
                    if TariffDetails.Find('-') then begin
                        repeat
                            if (TransactionAmount >= TariffDetails."Lower Limit") and (TransactionAmount <= TariffDetails."Upper Limit") then begin
                                if TariffDetails."Use Percentage" = true then begin
                                    ChargeAmount := TransactionAmount * TariffDetails.Percentage * 0.01;
                                end else begin
                                    ChargeAmount := TariffDetails."Charge Amount" + TariffDetails."Vendor Charge Amount";
                                    ExcisableAmt := TariffDetails."Vendor Charge Amount";
                                end;
                            end;
                        until TariffDetails.Next = 0;
                    end;
                end;
                if (TransCharge."Recover Excise Duty" = true) then
                    ExciseDutyAmt := Round((ChargeAmount - ExcisableAmt) * GenSet."Excise Duty (%)" * 0.01, 0.0001, '=');
                ChargeAmount := ChargeAmount + ExciseDutyAmt;
            until TransCharge.Next() = 0;
            SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Transaction Type not set up');
        DataJson.Add('total_charge_amount', ChargeAmount);
        */

        //SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');

        ResponseJson.Add(Data, DataJson);
    end;


    // ------------------------------------------------------------------------------------------------
    local procedure VirtualMemberRegistration(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        OriginatorID: Text;
        MobileNumber: Text;
        Name: Text;
        NationalIDNumber: Text;
        EmailAddress: Text;
        ReferrerMobileNumber: Text;
    begin
        OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
        MobileNumber := SelectJsonToken(RequestJson, '$.mobile_number').AsValue.AsText;
        Name := SelectJsonToken(RequestJson, '$.name').AsValue.AsText;
        NationalIDNumber := SelectJsonToken(RequestJson, '$.national_id_number').AsValue.AsText;
        EmailAddress := SelectJsonToken(RequestJson, '$.email_address').AsValue.AsText;
        ReferrerMobileNumber := SelectJsonToken(RequestJson, '$.referrer_mobile_number').AsValue.AsText;


        if true then begin
            SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
        end
        else begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
        end;
        ResponseJson.Add(Data, DataJson);
    end;

    // ################################################################################################
    // RESPONSE GENERATION PROCEDURE
    // ################################################################################################
    local procedure WrapResponse(RequestJson: JsonObject; ResponseJson: JsonObject) Wrapped: Text;
    var
        ResponseInnerJson: JsonObject;
        WrappedJson: JsonObject;
        PayloadJson: JsonObject;

        RequestAction: Text;
        RequestId: Text;
        ResponseStatus: Text;
        ResponsePayload: Text;
        ResponseHash: Text;
        UserName: Text;
        SessionId: Text;
        Timestamp: Text;
    begin
        RequestId := SelectJsonToken(RequestJson, '$.request.id').AsValue.AsText;
        RequestAction := SelectJsonToken(RequestJson, '$.request.action').AsValue.AsText;
        ResponseStatus := SelectJsonToken(ResponseJson, '$.' + Status).AsValue.AsText;
        UserName := SelectJsonToken(RequestJson, '$.request.user').AsValue.AsText;
        SessionId := SelectJsonToken(RequestJson, '$.request.session_id').AsValue.AsText;
        Timestamp := SelectJsonToken(RequestJson, '$.request.timestamp').AsValue.AsText;



        ResponseJson.Remove(Status);

        PayloadJson.WriteTo(ResponsePayload);
        ResponseHash := Sha256Hash(ResponsePayload);

        ResponseInnerJson.Add('id', RequestId);
        ResponseInnerJson.Add('action', RequestAction);
        ResponseInnerJson.Add('status', ResponseStatus);
        ResponseInnerJson.Add('hash', ResponseHash);
        ResponseInnerJson.Add('timestamp', CurrentDateTime);
        ResponseInnerJson.Add('payload', ResponseJson);

        WrappedJson.Add('response', ResponseInnerJson);
        WrappedJson.WriteTo(Wrapped);
    end;

    // SUPPORTING PROCEDURES
    // ------------------------------------------------------------------------------------------------

    local procedure SetResponseStatus(var ResponseJson: JsonObject; TheStatus: Text; TheTitle: Text; TheMessage: Text)
    begin
        ResponseJson.Add(Status, TheStatus);
        ResponseJson.Add(Title, TheTitle);
        ResponseJson.Add(Message, TheMessage);
    end;

    local procedure ValidateUserSession(RequestJson: JsonObject) Response: Boolean
    var
        UserName: Text;
        SessionId: Text;
        Employee: Record Employee;
    begin
        UserName := SelectJsonToken(RequestJson, '$.request.user').AsValue.AsText;
        SessionId := SelectJsonToken(RequestJson, '$.request.session_id').AsValue.AsText;

        Response := true;
    end;

    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;

    local procedure SelectJsonToken(JsonObject: JsonObject; Path: text) JsonToken: JsonToken;
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('Could not find a token with path %1', Path);
    end;

    local procedure ValidateRequestHash(RequestJson: JsonObject)
    var
        PayLoadJson: JsonObject;
        PayLoad: Text;
        HashFromPayload: Text;
        HashedPayload: Text;
    begin
        exit;
        HashFromPayload := SelectJsonToken(RequestJson, '$.request.hash').AsValue.AsText;
        PayLoadJson := SelectJsonToken(RequestJson, '$.request.payload').AsObject;
        PayLoadJson.WriteTo(PayLoad);
        HashedPayload := Sha256Hash(PayLoad);

        if HashedPayload <> HashFromPayload then
            Error('Payload hash mismatch');
    end;

    local procedure Sha256Hash(ClearText: Text): Text
    var
        CryptographyManagement: codeunit "Cryptography Management";
        HashAlgorithmType: option MD5,SHA1,SHA256,SHA384,SHA512;
    begin
        exit(Text.LowerCase(CryptographyManagement.GenerateHash(ClearText, HashAlgorithmType::SHA256)));
    end;
}
