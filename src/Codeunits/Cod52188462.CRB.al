codeunit 50139 CRB
{
    trigger OnRun()
    var
        Req: Text;

    begin


        Req := '{' +
        '"request": {' +
        '"id": "string",' +
        '"action": "get-unreported-records",' +
        '"hash": "string",' +
        '"session_id": "string",' +
        '"user": "string",' +
        '"timestamp": "datetime",' +
        '"payload": {' +
        '"data": {' +
        '"type": "individual-accounts-ce",' +
        '"page": {' +
        '"limit": 10,' +
        '"offset": 0' +
        '}' +
        '}' +
        '}' +
        '} ' +
        '}';
    end;
    //LOCAL GenerateJSONResponse(ID : Text;Action : Code[50];Status : Code[50];Hash : Text;Session_id : Text;User : Text;Payload : DotNet "System.String";Indent : Boolean) Response : Text
    procedure IndividualConsumerEmployerAccountSubmission(Header: integer)
    var
        DataJson: JsonObject;
        Json_DataSubmissionCE: JsonObject;
        result_obj: JsonObject;
        JsonArray_DataSubmissionCE: JsonArray;
        "CRBMonthlySubmissionCE": Record "CRB Monthly Submission CE";
        CRBHeader: Record "CRB Submission Header";
        result: text;
        EndBat: Integer;
        StartBat: Integer;
        TestBat: Integer;
        SAct: Codeunit "Sacco Activities";
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        isFinal: Boolean;
    begin
        CRBHeader.Get(Header);

        CRBMonthlySubmissionCE.Reset;
        CRBMonthlySubmissionCE.SetCurrentKey(Batch_No);
        CRBMonthlySubmissionCE.SetRange(HeaderNo, Header);
        CRBMonthlySubmissionCE.Setfilter(Submit_Status, '<>%1', CRBMonthlySubmissionCE.Submit_Status::Success);
        //CRBMonthlySubmissionCE.SetRange(Sent, false);
        if CRBMonthlySubmissionCE.FindLast() then begin
            EndBat := CRBMonthlySubmissionCE.Batch_No;
        end;

        TestBat := 1;
        CurrentRecordNo := TestBat;
        NoOfRecords := EndBat;
        SAct.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
        While TestBat <= EndBat do begin
            Clear(JsonArray_DataSubmissionCE);
            CRBMonthlySubmissionCE.Reset;
            CRBMonthlySubmissionCE.SetRange(HeaderNo, Header);
            CRBMonthlySubmissionCE.SetRange(Batch_No, TestBat);
            CRBMonthlySubmissionCE.Setfilter(Submit_Status, '<>%1', CRBMonthlySubmissionCE.Submit_Status::Success);
            //CRBMonthlySubmissionCE.SetRange(Sent, false);
            if CRBMonthlySubmissionCE.FindFirst then begin
                repeat
                    Clear(Json_DataSubmissionCE);
                    Json_DataSubmissionCE.Add('account_closure_reason', CRBMonthlySubmissionCE.account_closure_reason);
                    Json_DataSubmissionCE.Add('account_indicator', CRBMonthlySubmissionCE.account_indicator);
                    Json_DataSubmissionCE.Add('account_number', CRBMonthlySubmissionCE.account_number);
                    Json_DataSubmissionCE.Add('account_product_type', CRBMonthlySubmissionCE.account_product_type);
                    Json_DataSubmissionCE.Add('account_status', CRBMonthlySubmissionCE.account_status);
                    Json_DataSubmissionCE.Add('account_status_date', CRBMonthlySubmissionCE.account_status_date);
                    Json_DataSubmissionCE.Add('current_balance_kes', CRBMonthlySubmissionCE.current_balance_kes);
                    Json_DataSubmissionCE.Add('client_number', CRBMonthlySubmissionCE.client_number);
                    Json_DataSubmissionCE.Add('consumer_email', CRBMonthlySubmissionCE.consumer_email);
                    Json_DataSubmissionCE.Add('currency_facility', CRBMonthlySubmissionCE.currency_facility);
                    Json_DataSubmissionCE.Add('current_balance', CRBMonthlySubmissionCE.current_balance);
                    Json_DataSubmissionCE.Add('date_account_opened', CRBMonthlySubmissionCE.date_account_opened);
                    //Json_DataSubmissionCE.Add('date_at_physical_address', CRBMonthlySubmissionCE.date_at_physical_address);
                    Json_DataSubmissionCE.Add('days_arrears', CRBMonthlySubmissionCE.days_arrears);
                    Json_DataSubmissionCE.Add('deferred_payment_amount', CRBMonthlySubmissionCE.deferred_payment_amount);
                    Json_DataSubmissionCE.Add('deferred_payment_date', CRBMonthlySubmissionCE.deferred_payment_date);
                    Json_DataSubmissionCE.Add('disbursement_date', CRBMonthlySubmissionCE.disbursement_date);
                    Json_DataSubmissionCE.Add('dob', CRBMonthlySubmissionCE.dob);
                    Json_DataSubmissionCE.Add('employer_name', CRBMonthlySubmissionCE.employer_name);
                    Json_DataSubmissionCE.Add('employment_date', CRBMonthlySubmissionCE.employment_date);
                    Json_DataSubmissionCE.Add('employment_type', CRBMonthlySubmissionCE.employment_type);
                    Json_DataSubmissionCE.Add('forename1', CRBMonthlySubmissionCE.forename1);
                    Json_DataSubmissionCE.Add('forename2', CRBMonthlySubmissionCE.forename2);
                    Json_DataSubmissionCE.Add('forename3', CRBMonthlySubmissionCE.forename3);
                    Json_DataSubmissionCE.Add('gender', CRBMonthlySubmissionCE.gender);
                    Json_DataSubmissionCE.Add('group_id', '');
                    Json_DataSubmissionCE.Add('home_telephone_number', CRBMonthlySubmissionCE.home_telephone_number);

                    Json_DataSubmissionCE.Add('income_amount', '0');
                    Json_DataSubmissionCE.Add('old_account_number', '');
                    Json_DataSubmissionCE.Add('passport_country_code', '');
                    Json_DataSubmissionCE.Add('prudential_risk_classification', CRBMonthlySubmissionCE.Prudential_Risk_Classification);
                    Json_DataSubmissionCE.Add('type_of_residency', '');
                    Json_DataSubmissionCE.Add('trading_as', '');
                    Json_DataSubmissionCE.Add('industry_type', CRBMonthlySubmissionCE.industry_type);
                    Json_DataSubmissionCE.Add('installment_amount', CRBMonthlySubmissionCE.installment_amount);
                    Json_DataSubmissionCE.Add('installment_arrears', CRBMonthlySubmissionCE.installment_arrears);
                    Json_DataSubmissionCE.Add('installment_due_date', CRBMonthlySubmissionCE.installment_due_date);
                    Json_DataSubmissionCE.Add('latest_payment_amount', CRBMonthlySubmissionCE.latest_payment_amount);
                    Json_DataSubmissionCE.Add('latest_payment_date', CRBMonthlySubmissionCE.latest_payment_date);
                    Json_DataSubmissionCE.Add('lenders_branch_code', CRBMonthlySubmissionCE.lenders_branch_code);
                    Json_DataSubmissionCE.Add('lenders_branch_name', CRBMonthlySubmissionCE.lenders_branch_name);
                    Json_DataSubmissionCE.Add('lenders_registered_name', CRBMonthlySubmissionCE.lenders_registered_name);
                    Json_DataSubmissionCE.Add('lenders_trading_name', CRBMonthlySubmissionCE.lenders_trading_name);
                    Json_DataSubmissionCE.Add('location_country', CRBMonthlySubmissionCE.location_country);
                    Json_DataSubmissionCE.Add('location_town', CRBMonthlySubmissionCE.location_town);
                    Json_DataSubmissionCE.Add('marital_status', CRBMonthlySubmissionCE.marital_status);
                    Json_DataSubmissionCE.Add('mobile_telephone_number', CRBMonthlySubmissionCE.mobile_telephone_number);
                    Json_DataSubmissionCE.Add('nationality', CRBMonthlySubmissionCE.nationality);
                    //Json_DataSubmissionCE.Add('original_amount_kes', CRBMonthlySubmissionCE.original_amount);
                    Json_DataSubmissionCE.Add('original_amount', CRBMonthlySubmissionCE.original_amount);
                    Json_DataSubmissionCE.Add('other_id_doc_no', CRBMonthlySubmissionCE.other_id_doc_no);
                    Json_DataSubmissionCE.Add('other_id_doc_type', CRBMonthlySubmissionCE.other_id_doc_type);
                    Json_DataSubmissionCE.Add('overdue_balance', CRBMonthlySubmissionCE.overdue_balance);
                    Json_DataSubmissionCE.Add('overdue_date', CRBMonthlySubmissionCE.overdue_date);
                    Json_DataSubmissionCE.Add('payment_frequency', CRBMonthlySubmissionCE.payment_frequency);
                    //Json_DataSubmissionCE.Add('performing_npl_indicator', CRBMonthlySubmissionCE.performing_npl_indicator);
                    Json_DataSubmissionCE.Add('physical_address1', CRBMonthlySubmissionCE.physical_address1);
                    Json_DataSubmissionCE.Add('physical_address2', CRBMonthlySubmissionCE.physical_address2);
                    Json_DataSubmissionCE.Add('pin_number', CRBMonthlySubmissionCE.pin_number);
                    Json_DataSubmissionCE.Add('plot_number', CRBMonthlySubmissionCE.plot_number);
                    Json_DataSubmissionCE.Add('post_code', CRBMonthlySubmissionCE.post_code);
                    Json_DataSubmissionCE.Add('postal_address1', CRBMonthlySubmissionCE.postal_address1);
                    Json_DataSubmissionCE.Add('postal_address2', CRBMonthlySubmissionCE.postal_address2);
                    Json_DataSubmissionCE.Add('postal_location_country', CRBMonthlySubmissionCE.postal_location_country);
                    Json_DataSubmissionCE.Add('postal_location_town', CRBMonthlySubmissionCE.postal_location_town);
                    Json_DataSubmissionCE.Add('primary_id_doc_no', CRBMonthlySubmissionCE.primary_id_doc_no);
                    Json_DataSubmissionCE.Add('primary_id_doc_type', CRBMonthlySubmissionCE.primary_id_doc_type);
                    Json_DataSubmissionCE.Add('repayment_period', CRBMonthlySubmissionCE.repayment_period);
                    //Json_DataSubmissionCE.Add('salary_band', CRBMonthlySubmissionCE.salary_band);
                    //Json_DataSubmissionCE.Add('salutation', CRBMonthlySubmissionCE.salutation);
                    Json_DataSubmissionCE.Add('secondary_id_doc_no', CRBMonthlySubmissionCE.secondary_id_doc_no);
                    Json_DataSubmissionCE.Add('secondary_id_doc_type', CRBMonthlySubmissionCE.secondary_id_doc_type);
                    Json_DataSubmissionCE.Add('security_type', CRBMonthlySubmissionCE.security_type);
                    Json_DataSubmissionCE.Add('surname', CRBMonthlySubmissionCE.surname);
                    Json_DataSubmissionCE.Add('work_telephone_number', CRBMonthlySubmissionCE.work_telephone_number);

                    JsonArray_DataSubmissionCE.Add(Json_DataSubmissionCE);
                    CRBMonthlySubmissionCE.Sent := true;
                    CRBMonthlySubmissionCE.Modify();
                until CRBMonthlySubmissionCE.Next = 0;

                isFinal := false;
                if CRBHeader."Is Final Submission" = CRBHeader."Is Final Submission"::Yes then
                    isFinal := true;
                result := ProcessRequest(JsonArray_DataSubmissionCE, 'CE', 'M', '4', isFinal);

                if not result_obj.ReadFrom(result) then
                    Error('Invalid Json Response');

                CRBHeader.Success := SelectJsonToken(result_obj, '$.success').AsValue.AsBoolean();
                CRBHeader."Has Error" := SelectJsonToken(result_obj, '$.has_error').AsValue.AsBoolean();
                CRBHeader."Api Code" := SelectJsonToken(result_obj, '$.api_code').AsValue.AsText();
                CRBHeader."Api Code Description" := SelectJsonToken(result_obj, '$.success').AsValue.AsText();
                CRBHeader."Transaction ID" := SelectJsonToken(result_obj, '$.trx_id').AsValue.AsText();
                CRBHeader.Modify();
                CRBMonthlySubmissionCE.ModifyAll(Transaction_ID, CRBHeader."Transaction ID");
                //Message('Record Updated');

            end;
            TestBat += 1;
            CurrentRecordNo := TestBat;
            SAct.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, 'CRB Submission');
        end;
        SAct.ProgressClose(dWindow);

    end;


    procedure ValidateCRBStatus(Header: integer)
    var
        DataJson: JsonObject;
        Json_DataSubmissionCE: JsonObject;
        result_obj: JsonObject;
        JsonArray_DataSubmissionCE: JsonArray;
        "CRBMonthlySubmissionCE": Record "CRB Monthly Submission CE";
        CRBHeader: Record "CRB Submission Header";
        result: text;
        EndBat: Integer;
        StartBat: Integer;
        TestBat: Integer;
        SAct: Codeunit "Sacco Activities";
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
    begin
        CRBHeader.Get(Header);

        CRBMonthlySubmissionCE.Reset;
        CRBMonthlySubmissionCE.SetCurrentKey(Batch_No);
        CRBMonthlySubmissionCE.SetRange(HeaderNo, Header);
        CRBMonthlySubmissionCE.Setfilter(Submit_Status, '<>%1', CRBMonthlySubmissionCE.Submit_Status::Success);
        //CRBMonthlySubmissionCE.SetRange(Sent, false);
        if CRBMonthlySubmissionCE.FindLast() then begin
            EndBat := CRBMonthlySubmissionCE.Batch_No;
        end;

        TestBat := 1;
        CurrentRecordNo := TestBat;
        NoOfRecords := EndBat;
        SAct.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
        While TestBat <= EndBat do begin
            Clear(JsonArray_DataSubmissionCE);
            CRBMonthlySubmissionCE.Reset;
            CRBMonthlySubmissionCE.SetRange(HeaderNo, Header);
            CRBMonthlySubmissionCE.SetRange(Batch_No, TestBat);
            CRBMonthlySubmissionCE.Setfilter(Submit_Status, '<>%1', CRBMonthlySubmissionCE.Submit_Status::Success);
            //CRBMonthlySubmissionCE.SetRange(Sent, false);
            CRBMonthlySubmissionCE.SetFilter(Transaction_ID, '<>%1', '');
            if CRBMonthlySubmissionCE.FindFirst then begin

                result := GetCRBStatus(CRBMonthlySubmissionCE.Transaction_ID);


                CRBMonthlySubmissionCE.ModifyAll(Reference_Code, result);
                //Message('Record Updated');

            end;
            TestBat += 1;
            CurrentRecordNo := TestBat;
            SAct.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, 'CRB Validation');
        end;
        SAct.ProgressClose(dWindow);

    end;


    procedure generateCRBErrorLog(Header: integer)
    var
        DataJson: JsonObject;
        Json_DataSubmissionCE: JsonObject;
        result_obj: JsonObject;
        JsonArray_DataSubmissionCE: JsonArray;
        "CRBMonthlySubmissionCE": Record "CRB Monthly Submission CE";
        CRBHeader: Record "CRB Submission Header";
        result: text;
        EndBat: Integer;
        StartBat: Integer;
        TestBat: Integer;
        SAct: Codeunit "Sacco Activities";
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        ErrorLog: Record "CRB Submission Logs";
    begin


        CRBHeader.Get(Header);

        ErrorLog.Reset();
        ErrorLog.SetRange("Header No.", Header);
        if ErrorLog.FindFirst() then
            ErrorLog.DeleteAll();


        CRBMonthlySubmissionCE.Reset;
        CRBMonthlySubmissionCE.SetCurrentKey(Batch_No);
        CRBMonthlySubmissionCE.SetRange(HeaderNo, Header);
        CRBMonthlySubmissionCE.Setfilter(Submit_Status, '<>%1', CRBMonthlySubmissionCE.Submit_Status::Success);
        //CRBMonthlySubmissionCE.SetRange(Sent, false);
        if CRBMonthlySubmissionCE.FindLast() then begin
            EndBat := CRBMonthlySubmissionCE.Batch_No;
        end;

        TestBat := 1;
        CurrentRecordNo := TestBat;
        NoOfRecords := EndBat;
        SAct.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
        While TestBat <= EndBat do begin
            Clear(JsonArray_DataSubmissionCE);
            CRBMonthlySubmissionCE.Reset;
            CRBMonthlySubmissionCE.SetRange(HeaderNo, Header);
            CRBMonthlySubmissionCE.SetRange(Batch_No, TestBat);
            CRBMonthlySubmissionCE.Setfilter(Submit_Status, '<>%1', CRBMonthlySubmissionCE.Submit_Status::Success);
            //CRBMonthlySubmissionCE.SetRange(Sent, false);
            CRBMonthlySubmissionCE.SetFilter(Transaction_ID, '<>%1', '');
            CRBMonthlySubmissionCE.SetFilter(Reference_Code, '<>%1', '');
            if CRBMonthlySubmissionCE.FindFirst then begin

                result := GetCRBErrorLog(Header, CRBMonthlySubmissionCE.Reference_Code);

            end;
            TestBat += 1;
            CurrentRecordNo := TestBat;
            SAct.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, 'Error Logs');
        end;
        SAct.ProgressClose(dWindow);

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


    procedure NonIndividualConsumerEmployerAccountSubmission(Header: integer)
    var
        DataJson: JsonObject;
        Json_DataSubmissionCI: JsonObject;
        result_obj: JsonObject;
        JsonArray_DataSubmissionCE: JsonArray;
        "CRBMonthlySubmissionCI": Record "CRB Monthly Submission CE";
        CRBHeader: Record "CRB Submission Header";
        result: text;
        EndBat: Integer;
        StartBat: Integer;
        TestBat: Integer;
        SAct: Codeunit "Sacco Activities";
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        isFinal: Boolean;
    begin
        CRBHeader.Get(Header);

        CRBMonthlySubmissionCI.Reset;
        CRBMonthlySubmissionCI.SetCurrentKey(Batch_No);
        CRBMonthlySubmissionCI.SetRange(HeaderNo, Header);
        CRBMonthlySubmissionCI.Setfilter(Submit_Status, '<>%1', CRBMonthlySubmissionCI.Submit_Status::Success);
        //CRBMonthlySubmissionCE.SetRange(Sent, false);
        if CRBMonthlySubmissionCI.FindLast() then begin
            EndBat := CRBMonthlySubmissionCI.Batch_No;
        end;

        TestBat := 1;
        CurrentRecordNo := TestBat;
        NoOfRecords := EndBat;
        SAct.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
        While TestBat <= EndBat do begin
            Clear(JsonArray_DataSubmissionCE);
            CRBMonthlySubmissionCI.Reset;
            CRBMonthlySubmissionCI.SetRange(HeaderNo, Header);
            CRBMonthlySubmissionCI.SetRange(Batch_No, TestBat);
            CRBMonthlySubmissionCI.Setfilter(Submit_Status, '<>%1', CRBMonthlySubmissionCI.Submit_Status::Success);
            //CRBMonthlySubmissionCE.SetRange(Sent, false);
            if CRBMonthlySubmissionCI.FindFirst then begin
                repeat
                    Clear(Json_DataSubmissionCI);
                    Json_DataSubmissionCI.Add('account_closure_reason', CRBMonthlySubmissionCI.account_closure_reason);
                    Json_DataSubmissionCI.Add('account_holder_type', CRBMonthlySubmissionCI.account_holder_type);
                    Json_DataSubmissionCI.Add('account_indicator', CRBMonthlySubmissionCI.account_indicator);
                    Json_DataSubmissionCI.Add('account_number', CRBMonthlySubmissionCI.account_number);
                    Json_DataSubmissionCI.Add('account_product_type', CRBMonthlySubmissionCI.account_product_type);
                    Json_DataSubmissionCI.Add('account_status', CRBMonthlySubmissionCI.account_status);
                    Json_DataSubmissionCI.Add('account_status_date', CRBMonthlySubmissionCI.account_status_date);
                    Json_DataSubmissionCI.Add('current_balance_kes', CRBMonthlySubmissionCI.current_balance_kes);
                    Json_DataSubmissionCI.Add('annual_turnover_band', CRBMonthlySubmissionCI.annual_turnover_band);
                    Json_DataSubmissionCI.Add('client_number', CRBMonthlySubmissionCI.client_number);
                    Json_DataSubmissionCI.Add('company_type', CRBMonthlySubmissionCI.company_type);
                    Json_DataSubmissionCI.Add('country', CRBMonthlySubmissionCI.country);
                    Json_DataSubmissionCI.Add('currency_facility', CRBMonthlySubmissionCI.currency_facility);
                    Json_DataSubmissionCI.Add('current_balance', CRBMonthlySubmissionCI.current_balance);
                    Json_DataSubmissionCI.Add('date_account_opened', CRBMonthlySubmissionCI.date_account_opened);
                    Json_DataSubmissionCI.Add('days_arrears', CRBMonthlySubmissionCI.days_arrears);
                    Json_DataSubmissionCI.Add('deferred_payment_amount', CRBMonthlySubmissionCI.deferred_payment_amount);
                    Json_DataSubmissionCI.Add('deferred_payment_date', CRBMonthlySubmissionCI.deferred_payment_date);
                    Json_DataSubmissionCI.Add('disbursement_date', CRBMonthlySubmissionCI.disbursement_date);
                    Json_DataSubmissionCI.Add('industry_code', CRBMonthlySubmissionCI.industry_code);
                    Json_DataSubmissionCI.Add('installment_amount', CRBMonthlySubmissionCI.installment_amount);
                    Json_DataSubmissionCI.Add('installment_arrears', CRBMonthlySubmissionCI.installment_arrears);
                    Json_DataSubmissionCI.Add('installment_due_date', CRBMonthlySubmissionCI.installment_due_date);
                    Json_DataSubmissionCI.Add('latest_payment_amount', CRBMonthlySubmissionCI.latest_payment_amount);
                    Json_DataSubmissionCI.Add('latest_payment_date', CRBMonthlySubmissionCI.latest_payment_date);
                    Json_DataSubmissionCI.Add('lenders_branch_code', CRBMonthlySubmissionCI.lenders_branch_code);
                    Json_DataSubmissionCI.Add('lenders_branch_name', CRBMonthlySubmissionCI.lenders_branch_name);
                    Json_DataSubmissionCI.Add('lenders_registered_name', CRBMonthlySubmissionCI.lenders_registered_name);
                    Json_DataSubmissionCI.Add('lenders_trading_name', CRBMonthlySubmissionCI.lenders_trading_name);
                    Json_DataSubmissionCI.Add('main_telephone_number', CRBMonthlySubmissionCI.main_telephone_number);
                    Json_DataSubmissionCI.Add('nationality', CRBMonthlySubmissionCI.nationality);
                    Json_DataSubmissionCI.Add('number_of_shares', CRBMonthlySubmissionCI.number_of_shares);
                    Json_DataSubmissionCI.Add('original_amount', CRBMonthlySubmissionCI.original_amount);
                    Json_DataSubmissionCI.Add('other_telephone_number', CRBMonthlySubmissionCI.other_telephone_number);
                    Json_DataSubmissionCI.Add('overdue_balance', CRBMonthlySubmissionCI.overdue_balance);
                    Json_DataSubmissionCI.Add('overdue_date', CRBMonthlySubmissionCI.overdue_date);
                    Json_DataSubmissionCI.Add('payment_frequency', CRBMonthlySubmissionCI.payment_frequency);
                    Json_DataSubmissionCI.Add('performing_npl_indicator', CRBMonthlySubmissionCI.performing_npl_indicator);
                    Json_DataSubmissionCI.Add('physical_address1', CRBMonthlySubmissionCI.physical_address1);
                    Json_DataSubmissionCI.Add('physical_address2', CRBMonthlySubmissionCI.physical_address2);
                    Json_DataSubmissionCI.Add('physical_location_country', CRBMonthlySubmissionCI.physical_location_country);
                    Json_DataSubmissionCI.Add('physical_location_town', CRBMonthlySubmissionCI.physical_location_town);
                    Json_DataSubmissionCI.Add('pin_number', CRBMonthlySubmissionCI.pin_number);
                    Json_DataSubmissionCI.Add('plot_number', CRBMonthlySubmissionCI.plot_number);
                    Json_DataSubmissionCI.Add('post_code', CRBMonthlySubmissionCI.post_code);
                    Json_DataSubmissionCI.Add('postal_address1', CRBMonthlySubmissionCI.postal_address1);
                    Json_DataSubmissionCI.Add('postal_address2', CRBMonthlySubmissionCI.postal_address2);
                    Json_DataSubmissionCI.Add('previous_registration_number', CRBMonthlySubmissionCI.previous_registration_number);
                    Json_DataSubmissionCI.Add('registered_name', CRBMonthlySubmissionCI.registered_name);
                    Json_DataSubmissionCI.Add('registration_date', CRBMonthlySubmissionCI.registration_date);
                    Json_DataSubmissionCI.Add('registration_number', CRBMonthlySubmissionCI.registration_number);
                    Json_DataSubmissionCI.Add('repayment_period', CRBMonthlySubmissionCI.repayment_period);
                    Json_DataSubmissionCI.Add('security_type', CRBMonthlySubmissionCI.security_type);
                    Json_DataSubmissionCI.Add('town', CRBMonthlySubmissionCI.town);
                    Json_DataSubmissionCI.Add('trading_name', CRBMonthlySubmissionCI.trading_name);
                    Json_DataSubmissionCI.Add('trading_status', CRBMonthlySubmissionCI.trading_status);
                    Json_DataSubmissionCI.Add('trading_status_date', CRBMonthlySubmissionCI.trading_status_date);
                    Json_DataSubmissionCI.Add('vat_number', CRBMonthlySubmissionCI.vat_number);


                    JsonArray_DataSubmissionCE.Add(Json_DataSubmissionCI);
                    CRBMonthlySubmissionCI.Sent := true;
                    CRBMonthlySubmissionCI.Modify();
                until CRBMonthlySubmissionCI.Next = 0;

                isFinal := false;
                if CRBHeader."Is Final Submission" = CRBHeader."Is Final Submission"::Yes then
                    isFinal := true;
                result := ProcessRequest(JsonArray_DataSubmissionCE, 'CE', 'M', '4', isFinal);

                if not result_obj.ReadFrom(result) then
                    Error('Invalid Json Response');

                CRBHeader.Success := SelectJsonToken(result_obj, '$.success').AsValue.AsBoolean();
                CRBHeader."Has Error" := SelectJsonToken(result_obj, '$.has_error').AsValue.AsBoolean();
                CRBHeader."Api Code" := SelectJsonToken(result_obj, '$.api_code').AsValue.AsText();
                CRBHeader."Api Code Description" := SelectJsonToken(result_obj, '$.success').AsValue.AsText();
                CRBHeader."Transaction ID" := SelectJsonToken(result_obj, '$.trx_id').AsValue.AsText();
                CRBHeader.Modify();
                CRBMonthlySubmissionCI.ModifyAll(Transaction_ID, CRBHeader."Transaction ID");
                //Message('Record Updated');

            end;
            TestBat += 1;
            CurrentRecordNo := TestBat;
            SAct.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, 'CRB Submission');
        end;
        SAct.ProgressClose(dWindow);

    end;


    procedure yyyyMMdd(Date: Date) NewDate: Text
    var
        d: Text;
        y: Text;
        m: Text;
    Begin

        d := FORMAT(DATE2DMY(Date, 1));
        m := FORMAT(DATE2DMY(Date, 2));
        y := FORMAT(DATE2DMY(Date, 3));

        IF STRLEN(d) = 1 THEN
            d := '0' + d;

        IF STRLEN(m) = 1 THEN
            m := '0' + m;

        NewDate := y + '/' + m + '/' + d;
        NewDate := y + m + d;
    end;

    Local procedure ProcessRequest(JsonData: JsonArray; DataRef: Text; submissionType: Text; TemplateVersion: Text; isFinal: Boolean) ResponseText: Text;
    var
        JsonText: Text;
        Content: HttpContent;
        contentHeaders: HttpHeaders;
        HttpResponseMessage: HttpResponseMessage;
        HttpRequestMessage: HttpRequestMessage;
        CRBJsonObject: JsonObject;
        CallbackURL: Text[50];
        SubmissionDate: code[10];
        InstitutionRef: Code[2];
        IsSuccessful: Boolean;

        HttpClient: HttpClient;
        SaccoSetup: Record "Sacco Setup";
    begin
        SaccoSetup.Get();
        SaccoSetup.TestField("Metropol Base URL");

        //S for SACCO
        InstitutionRef := 'S';
        CallbackURL := SaccoSetup."Metropol Base URL" + '/crb/callback/';

        SubmissionDate := yyyyMMdd(today);

        CRBJsonObject.Add('data_ref', DataRef);
        CRBJsonObject.Add('institution_ref', InstitutionRef);
        CRBJsonObject.Add('is_final_submission', isFinal);
        CRBJsonObject.Add('submission_date', SubmissionDate);
        CRBJsonObject.Add('submission_type', submissionType);
        CRBJsonObject.Add('template_version', TemplateVersion);
        CRBJsonObject.Add('callback_url', CallbackURL);
        CRBJsonObject.Add('data', JsonData);


        //Message('Req: %1', CRBJsonObject);
        // Write the JSON object to a text variable
        CRBJsonObject.WriteTo(JsonText);
        //message(format(JsonText));

        // Create a new StringContent from the JSON text
        Content.WriteFrom(JsonText);

        Content.GetHeaders(contentHeaders); // Pass HttpHeaders object
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json'); // Set Content-Type

        // Set the HTTP request method to POST
        HttpRequestMessage.Method := 'POST';

        // Set the request URI
        HttpRequestMessage.SetRequestUri(SaccoSetup."Metropol Base URL" + '/crb/submitdata/');

        // Add the request content (JSON body)
        HttpRequestMessage.Content := Content;


        IsSuccessful := HttpClient.Send(HttpRequestMessage, HttpResponseMessage);


        // Check for 200 OK
        //if HttpResponseMessage.HttpStatusCode = 200 then begin
        // Read and display the response content
        HttpResponseMessage.Content.ReadAs(ResponseText);

        //Message(ResponseText);

        //end

    end;




    local procedure GetCRBStatus(RequestCode: Text): Text
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        RequestUrl: Text;
        IsSuccessful: Boolean;
        ref_code: Text;
        SaccoSetup: Record "Sacco Setup";
    begin
        SaccoSetup.Get();
        SaccoSetup.TestField("Metropol Base URL");
        ref_code := '';
        // Build the request URL with request_code parameter
        RequestUrl := SaccoSetup."Metropol Base URL" + '/crb/status/?request_code=' + RequestCode;

        // Set the HTTP request method to GET
        HttpRequestMessage.Method := 'GET';

        // Set the request URI
        HttpRequestMessage.SetRequestUri(RequestUrl);

        // Send the request
        IsSuccessful := HttpClient.Send(HttpRequestMessage, HttpResponseMessage);

        if IsSuccessful then begin
            // Read the response content
            HttpResponseMessage.Content.ReadAs(ResponseText);
            //Message('Status Response: %1', ResponseText);

            // Process the status response
            ref_code := ProcessCRBSubmissionResponse(ResponseText);

        end;
        exit(ref_code);
    end;


    local procedure GetCRBErrorLog(HeaderNo: Integer; ReferenceCode: Text): Text
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        RequestUrl: Text;
        IsSuccessful: Boolean;
        SaccoSetup: Record "Sacco Setup";
    begin
        SaccoSetup.Get();
        SaccoSetup.TestField("Metropol Base URL");
        // Build the request URL with reference_code parameter
        RequestUrl := SaccoSetup."Metropol Base URL" + '/crb/errorlog/?reference_code=' + ReferenceCode;

        // Set the HTTP request method to GET
        HttpRequestMessage.Method := 'GET';

        // Set the request URI
        HttpRequestMessage.SetRequestUri(RequestUrl);

        // Send the request
        IsSuccessful := HttpClient.Send(HttpRequestMessage, HttpResponseMessage);

        if IsSuccessful then begin
            // Read the response content
            HttpResponseMessage.Content.ReadAs(ResponseText);
            //Message('Error Log Response: %1', ResponseText);

            // Process the error log response
            ProcessCRBErrorLog(HeaderNo, ResponseText);

        end else begin
            Error('Failed to retrieve CRB error log for reference code: %1', ReferenceCode);
        end;
    end;


    local procedure ProcessCRBSubmissionResponse(ResponseText: Text) ReferenceCode: Text
    var
        JsonResponse: JsonObject;
        JsonToken: JsonToken;
        JsonArray: JsonArray;
        DataObject: JsonObject;
        StatusObject: JsonObject;
        MetaObject: JsonObject;
        SortObject: JsonObject;

        // Main response variables
        Success: Boolean;
        HasError: Boolean;
        ApiCode: Integer;
        ApiCodeDescription: Text;
        Message: Text;
        TrxId: Text;

        // Data variables
        CugId: Text;
        TemplateVersion: Text;
        DataRef: Text;
        IsFinalSubmission: Boolean;
        RecordsImported: Integer;
        RecordsCount: Integer;
        EmptyRecords: Integer;
        RecordsPassed: Integer;
        RecordsRejected: Integer;
        ErrorCount: Integer;
        DownloadUrl: Text;
        PostliveErrorUrl: Text;
        ErrorLogStatus: Text;
        PostLiveErrorStatus: Text;
        PostErrorCount: Integer;
        LiveStatus: Integer;
        SubmissionType: Text;
        SubmissionTemplateType: Text;

        // Status variables
        StatusId: Integer;
        StatusName: Text;

        // Meta variables
        MetaFirst: Boolean;
        MetaLast: Boolean;
        MetaNumber: Integer;
        MetaSize: Integer;
        NumberOfElements: Integer;
        TotalPages: Integer;
        TotalElements: Integer;

        // Sort variables
        SortEmpty: Boolean;
        SortSorted: Boolean;
        SortUnsorted: Boolean;

    begin
        ReferenceCode := '';
        // Parse the JSON response
        if JsonResponse.ReadFrom(ResponseText) then begin

            // Extract main response fields
            if JsonResponse.Get('success', JsonToken) then
                Success := JsonToken.AsValue().AsBoolean();

            if JsonResponse.Get('has_error', JsonToken) then
                HasError := JsonToken.AsValue().AsBoolean();

            if JsonResponse.Get('api_code', JsonToken) then
                ApiCode := JsonToken.AsValue().AsInteger();

            if JsonResponse.Get('api_code_description', JsonToken) then
                ApiCodeDescription := JsonToken.AsValue().AsText();

            if JsonResponse.Get('message', JsonToken) then
                if not JsonToken.AsValue().IsNull() then
                    Message := JsonToken.AsValue().AsText();

            if JsonResponse.Get('trx_id', JsonToken) then
                TrxId := JsonToken.AsValue().AsText();

            // Extract data array (get first element)
            if JsonResponse.Get('data', JsonToken) then begin
                JsonArray := JsonToken.AsArray();

                if JsonArray.Get(0, JsonToken) then begin
                    DataObject := JsonToken.AsObject();

                    // Extract data fields
                    if DataObject.Get('cugId', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            CugId := ''
                        else
                            CugId := JsonToken.AsValue().AsText();
                    end;

                    if DataObject.Get('reference_code', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            ReferenceCode := ''
                        else
                            ReferenceCode := JsonToken.AsValue().AsText();
                    end;

                    if DataObject.Get('template_version', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            TemplateVersion := ''
                        else
                            TemplateVersion := JsonToken.AsValue().AsText();
                    end;

                    if DataObject.Get('data_ref', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            DataRef := ''
                        else
                            DataRef := JsonToken.AsValue().AsText();
                    end;

                    if DataObject.Get('is_final_submission', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            IsFinalSubmission := false
                        else
                            IsFinalSubmission := JsonToken.AsValue().AsBoolean();
                    end;

                    if DataObject.Get('records_imported', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            RecordsImported := 0
                        else
                            RecordsImported := JsonToken.AsValue().AsInteger();
                    end;

                    if DataObject.Get('records_count', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            RecordsCount := 0
                        else
                            RecordsCount := JsonToken.AsValue().AsInteger();
                    end;

                    if DataObject.Get('empty_records', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            EmptyRecords := 0
                        else
                            EmptyRecords := JsonToken.AsValue().AsInteger();
                    end;

                    if DataObject.Get('records_passed', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            RecordsPassed := 0
                        else
                            RecordsPassed := JsonToken.AsValue().AsInteger();
                    end;

                    if DataObject.Get('records_rejected', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            RecordsRejected := 0
                        else
                            RecordsRejected := JsonToken.AsValue().AsInteger();
                    end;

                    if DataObject.Get('error_count', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            ErrorCount := 0
                        else
                            ErrorCount := JsonToken.AsValue().AsInteger();
                    end;

                    if DataObject.Get('download_url', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            DownloadUrl := ''
                        else
                            DownloadUrl := JsonToken.AsValue().AsText();
                    end;

                    if DataObject.Get('postlive_error_url', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            PostliveErrorUrl := ''
                        else
                            PostliveErrorUrl := JsonToken.AsValue().AsText();
                    end;

                    if DataObject.Get('error_log_status', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            ErrorLogStatus := ''
                        else
                            ErrorLogStatus := JsonToken.AsValue().AsText();
                    end;

                    if DataObject.Get('post_live_error_status', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            PostLiveErrorStatus := ''
                        else
                            PostLiveErrorStatus := JsonToken.AsValue().AsText();
                    end;

                    if DataObject.Get('post_error_count', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            PostErrorCount := 0
                        else
                            PostErrorCount := JsonToken.AsValue().AsInteger();
                    end;

                    if DataObject.Get('live_status', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            LiveStatus := 0
                        else
                            LiveStatus := JsonToken.AsValue().AsInteger();
                    end;

                    if DataObject.Get('submission_type', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            SubmissionType := ''
                        else
                            SubmissionType := JsonToken.AsValue().AsText();
                    end;

                    if DataObject.Get('submission_template_type', JsonToken) then begin
                        if JsonToken.AsValue().IsNull then
                            SubmissionTemplateType := ''
                        else
                            SubmissionTemplateType := JsonToken.AsValue().AsText();
                    end;

                    // Extract status object
                    if DataObject.Get('status', JsonToken) then begin
                        StatusObject := JsonToken.AsObject();

                        if StatusObject.Get('id', JsonToken) then begin
                            if JsonToken.AsValue().IsNull then
                                StatusId := 0
                            else
                                StatusId := JsonToken.AsValue().AsInteger();
                        end;

                        if StatusObject.Get('name', JsonToken) then begin
                            if JsonToken.AsValue().IsNull then
                                StatusName := ''
                            else
                                StatusName := JsonToken.AsValue().AsText();
                        end;
                    end;
                end;
            end;

            // Extract meta object
            if JsonResponse.Get('meta', JsonToken) then begin
                MetaObject := JsonToken.AsObject();

                if MetaObject.Get('first', JsonToken) then
                    MetaFirst := JsonToken.AsValue().AsBoolean();

                if MetaObject.Get('last', JsonToken) then
                    MetaLast := JsonToken.AsValue().AsBoolean();

                if MetaObject.Get('number', JsonToken) then
                    MetaNumber := JsonToken.AsValue().AsInteger();

                if MetaObject.Get('size', JsonToken) then
                    MetaSize := JsonToken.AsValue().AsInteger();

                if MetaObject.Get('number_of_elements', JsonToken) then
                    NumberOfElements := JsonToken.AsValue().AsInteger();

                if MetaObject.Get('total_pages', JsonToken) then
                    TotalPages := JsonToken.AsValue().AsInteger();

                if MetaObject.Get('total_elements', JsonToken) then
                    TotalElements := JsonToken.AsValue().AsInteger();

                // Extract sort object
                if MetaObject.Get('sort', JsonToken) then begin
                    SortObject := JsonToken.AsObject();

                    if SortObject.Get('empty', JsonToken) then
                        SortEmpty := JsonToken.AsValue().AsBoolean();

                    if SortObject.Get('sorted', JsonToken) then
                        SortSorted := JsonToken.AsValue().AsBoolean();

                    if SortObject.Get('unsorted', JsonToken) then
                        SortUnsorted := JsonToken.AsValue().AsBoolean();
                end;
            end;

            // Process based on the extracted data
            if Success then begin
                //Message('CRB Submission processed successfully');
                //Message('Reference Code: %1, Status: %2', ReferenceCode, StatusName);
                //Message('Records - Imported: %1, Passed: %2, Rejected: %3',
                //      RecordsImported, RecordsPassed, RecordsRejected);

                // Add your business logic here based on the status
                case StatusId of
                    6:
                        begin // Validated
                            //Message('Submission has been validated successfully');
                            // Add logic for validated submissions
                        end;
                // Add other status cases as needed
                end;
            end;

        end else begin
            //Error('Failed to parse JSON response');
            //exit(false);
        end;
    end;

    local procedure ProcessCRBErrorLog(HeaderNo: Integer; ResponseText: Text): Boolean
    var
        JsonResponse: JsonObject;
        JsonToken: JsonToken;
        JsonArray: JsonArray;
        ErrorObject: JsonObject;

        // Main response variables
        Success: Boolean;
        HasError: Boolean;
        ApiCode: Integer;
        ApiCodeDescription: Text;
        TrxId: Text;

        // Error record variables
        ColumnName: Text;
        ColumnIndex: Integer;
        RowIndex: Integer;
        ValueProvided: Text;
        ErrorClassId: Integer;
        DataRuleIdTypeId: Integer;
        ErrorDescription: Text;
        ClientNumber: Text;
        AccountNumber: Text;

        // Counters and summary
        TotalErrors: Integer;
        ErrorCounter: Integer;
        ErrorSummary: Text;

    begin
        // Parse the JSON response
        if JsonResponse.ReadFrom(ResponseText) then begin

            // Extract main response fields
            if JsonResponse.Get('success', JsonToken) then
                Success := JsonToken.AsValue().AsBoolean();

            if JsonResponse.Get('has_error', JsonToken) then
                HasError := JsonToken.AsValue().AsBoolean();

            if JsonResponse.Get('api_code', JsonToken) then
                ApiCode := JsonToken.AsValue().AsInteger();

            if JsonResponse.Get('api_code_description', JsonToken) then
                ApiCodeDescription := JsonToken.AsValue().AsText();

            if JsonResponse.Get('trx_id', JsonToken) then
                TrxId := JsonToken.AsValue().AsText();

            // Process error data array
            if JsonResponse.Get('data', JsonToken) then begin
                JsonArray := JsonToken.AsArray();
                TotalErrors := JsonArray.Count();

                //Message('Processing %1 error records from CRB submission', TotalErrors);

                // Loop through all error records
                for ErrorCounter := 0 to TotalErrors - 1 do begin
                    if JsonArray.Get(ErrorCounter, JsonToken) then begin
                        ErrorObject := JsonToken.AsObject();

                        // Clear variables for this iteration
                        Clear(ColumnName);
                        Clear(ColumnIndex);
                        Clear(RowIndex);
                        Clear(ValueProvided);
                        Clear(ErrorClassId);
                        Clear(DataRuleIdTypeId);
                        Clear(ErrorDescription);
                        Clear(ClientNumber);
                        Clear(AccountNumber);

                        // Extract error fields
                        if ErrorObject.Get('column_name', JsonToken) then
                            ColumnName := JsonToken.AsValue().AsText();

                        if ErrorObject.Get('column_index', JsonToken) then
                            ColumnIndex := JsonToken.AsValue().AsInteger();

                        if ErrorObject.Get('row_index', JsonToken) then
                            RowIndex := JsonToken.AsValue().AsInteger();

                        //if ErrorObject.Get('value_provided', JsonToken) then
                        //  ValueProvided := JsonToken.AsValue().AsText();

                        if ErrorObject.Get('error_class_id', JsonToken) then
                            if not JsonToken.AsValue().IsNull() then
                                ErrorClassId := JsonToken.AsValue().AsInteger();

                        if ErrorObject.Get('data_rule_id_type_id', JsonToken) then
                            DataRuleIdTypeId := JsonToken.AsValue().AsInteger();

                        if ErrorObject.Get('error_description', JsonToken) then
                            ErrorDescription := JsonToken.AsValue().AsText();

                        if ErrorObject.Get('client_number', JsonToken) then
                            ClientNumber := JsonToken.AsValue().AsText();

                        if ErrorObject.Get('account_number', JsonToken) then
                            AccountNumber := JsonToken.AsValue().AsText();

                        // Process individual error record
                        ProcessSingleErrorRecord(HeaderNo, ColumnName, ColumnIndex, RowIndex, ValueProvided,
                                               ErrorClassId, DataRuleIdTypeId, ErrorDescription,
                                               ClientNumber, AccountNumber, ErrorCounter + 1);
                    end;
                end;

                // Display summary
                //Message('CRB Error Log Processing Complete');
                //Message('Total Errors Processed: %1', TotalErrors);
                //Message('Transaction ID: %1', TrxId);

                // Group errors by type for better analysis
                //DisplayErrorSummary(ResponseText);

                exit(true);

            end else begin
                //Message('No error data found in response');
                exit(false);
            end;

        end else begin
            //Error('Failed to parse CRB Error Log JSON response');
            exit(false);
        end;
    end;

    local procedure ProcessSingleErrorRecord(HeaderNo: Integer; ColumnName: Text; ColumnIndex: Integer; RowIndex: Integer;
                                           ValueProvided: Text; ErrorClassId: Integer; DataRuleIdTypeId: Integer;
                                           ErrorDescription: Text; ClientNumber: Text; AccountNumber: Text;
                                           RecordNumber: Integer)

    var
        crbLog: Record "CRB Submission Logs";
        CRBMonthlySubmissionCE: Record "CRB Monthly Submission CE";
    begin

        crbLog.Init();
        crbLog."Header No." := HeaderNo;
        crbLog.GUID := CreateGuid();
        crbLog."Loan No." := AccountNumber;
        crbLog."Member No." := ClientNumber;
        crbLog.column_name := ColumnName;
        crbLog.error_description := ErrorDescription;
        crbLog.value_provided := ValueProvided;
        crbLog.insert;


        CRBMonthlySubmissionCE.Reset;
        CRBMonthlySubmissionCE.SetRange(HeaderNo, HeaderNo);
        CRBMonthlySubmissionCE.SetRange(account_number, AccountNumber);
        CRBMonthlySubmissionCE.SetRange(client_number, ClientNumber);
        if CRBMonthlySubmissionCE.FindFirst then begin
            CRBMonthlySubmissionCE.Submit_Status := CRBMonthlySubmissionCE.Submit_Status::Failed;
            CRBMonthlySubmissionCE.Modify();
        end;

        // Log individual error details
        //Message('Error %1: %2', RecordNumber, ErrorDescription);
        //Message('  - Field: %1 (Column %2)', ColumnName, ColumnIndex);
        //Message('  - Client: %1, Account: %2', ClientNumber, AccountNumber);
        //Message('  - Value: "%1"', ValueProvided);

        // Here you can add logic to:
        // 1. Insert into an error log table
        // 2. Send notifications
        // 3. Update record status
        // 4. Generate correction reports

        // Example: Insert into custom error log table
        // InsertCRBErrorLogEntry(ColumnName, ColumnIndex, RowIndex, ValueProvided, 
        //                       ErrorClassId, DataRuleIdTypeId, ErrorDescription, 
        //                       ClientNumber, AccountNumber);
    end;

    local procedure DisplayErrorSummary(ResponseText: Text)
    var
        JsonResponse: JsonObject;
        JsonToken: JsonToken;
        JsonArray: JsonArray;
        ErrorObject: JsonObject;
        ErrorType: Text;
        ErrorCount: Integer;
        TempErrorTypes: Record "Name/Value Buffer" temporary;
        i: Integer;
    begin
        // Parse again to create summary by error type
        if JsonResponse.ReadFrom(ResponseText) then begin
            if JsonResponse.Get('data', JsonToken) then begin
                JsonArray := JsonToken.AsArray();

                // Count error types
                for i := 0 to JsonArray.Count() - 1 do begin
                    if JsonArray.Get(i, JsonToken) then begin
                        ErrorObject := JsonToken.AsObject();
                        if ErrorObject.Get('error_description', JsonToken) then begin
                            ErrorType := JsonToken.AsValue().AsText();

                            // Extract error code (e.g., "ENF028" from "ENF028 Data field characters must be Numeric")
                            if StrPos(ErrorType, ' ') > 0 then
                                ErrorType := CopyStr(ErrorType, 1, StrPos(ErrorType, ' ') - 1);

                            // Count occurrences
                            TempErrorTypes.SetRange(Name, ErrorType);
                            if TempErrorTypes.FindFirst() then begin
                                //TempErrorTypes.Value := Format(TempErrorTypes.Value.AsInteger() + 1);
                                TempErrorTypes.Modify();
                            end else begin
                                TempErrorTypes.Init();
                                TempErrorTypes.ID := TempErrorTypes.Count() + 1;
                                TempErrorTypes.Name := ErrorType;
                                TempErrorTypes.Value := '1';
                                TempErrorTypes.Insert();
                            end;
                        end;
                    end;
                end;

                // Display summary
                Message('=== ERROR SUMMARY ===');
                TempErrorTypes.Reset();
                if TempErrorTypes.FindSet() then
                    repeat
                        Message('%1: %2 occurrences', TempErrorTypes.Name, TempErrorTypes.Value);
                    until TempErrorTypes.Next() = 0;
            end;
        end;
    end;



    /*    Local CRBSubmission()
        var
            CRBCredentials: Record "CRB Credentials";
            url : text[100];
            JObject: JsonObject;
            data : JsonArray;
            stringContent : DotNet HttpRequestHeaders;
        begin

            CRBCredentials.GET();
            CRBCredentials.TESTFIELD("Access Token");




            data := getCRBData();
            stringContent := stringContent.StringContent(data, encoding.UTF8, 'application/json');


            url := 'http://localhost:8000/api/credentials/submit_data/';


            url := 'http://84.247.177.92:8000/submission/credentials/submit_data/';
            url := 'http://84.247.177.92:8000/submission/credentials/submit_data/';
            url := 'http://109.199.109.61:8006/submission/credentials/submit_data/';


            ResponsText := LocalHttpRequest('POST',url,stringContent,status);

            MESSAGE('Last: '+ResponsText);
            JObject := JObject.Parse(ResponsText);
            {
            "success": true,
            "has_error": false,
            "api_code": 1010,
            "api_code_description": "Data Submitted Successful",
            "trx_id": "PPPG-OUZQ-20240731"
            }


            EVALUATE(success , FORMAT(JObject.GetValue('success')));    
            trx_id := FORMAT(JObject.GetValue('trx_id'));    

            MESSAGE('Success: %1\trx_id: %2',success,trx_id);
        end;*/



}