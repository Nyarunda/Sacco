codeunit 50141 "Sacco Portal"
{
    trigger OnRun()
    begin
        // This codeunit handles authentication for the member portal
    end;

    var
        Channel: Enum "Transaction Channel";
        smsDispatch: Codeunit SMSDispatcher;
        ExpAmt: Decimal;
        AmtPaid: Decimal;
        DefAmt: Decimal;
        DaysDef: Integer;
        ArrearsDate: Date;
        ResponseStatus: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        Data: Label 'data';
        Status: Label 'status';
        SecurityUtils: Codeunit "Security Utils";
        SkyMbanking: Codeunit "Sky Mbanking";
        Source: Enum "SMS Source Enum";
        SaccoActivity: Codeunit "Sacco Activities";
        Legacy: Codeunit "Legacy";
        NotificationMgmt: Codeunit "Member Notification Management";
        MemberSecurityMgmt: Codeunit "Member Security Management";
        SaccoSetup: Record "Sacco Setup";
        EmailMgt: Codeunit "Email Management";
        PortalLogMgt: Codeunit "Portal Log Management";

    // ################################################################################################
    // MAIN PROCESSING FUNCTION
    // ################################################################################################

    procedure ProcessRequest(Request: Text) Response: Text;
    var
        RequestJson: JsonObject;
        OutputJson: JsonObject;
        RequestDataJson: JsonObject;
        RequestAction: Text;
        IsValid: Boolean;
        SessionID: Text;
        PortalActionLogEntryNo: Integer;
    begin
        if not RequestJson.ReadFrom(Request) then
            Error('Invalid Json Input');

        RequestAction := SelectJsonToken(RequestJson, '$.request.action').AsValue.AsText;
        RequestDataJson := SelectJsonToken(RequestJson, '$.request.payload.data').AsObject();
        PortalActionLogEntryNo := LogPortalActionFromRequest(RequestDataJson, RequestAction);

        // Validate the request hash to ensure data integrity

        IsValid := false;
        if (RequestAction <> 'login') and (RequestAction <> 'verify-otp') and (RequestAction <> 'logout') and (RequestAction <> 'activate') and (RequestAction <> 'password-changed')
            and (RequestAction <> 'get-email-queue') and (RequestAction <> 'confirm-email-sent') then begin

            SessionID := SelectJsonToken(RequestJson, '$.request.session_id').AsValue.AsText;
            OutputJson := ValidateSession(RequestJson, IsValid, SessionID)
        end
        else
            IsValid := true;

        if IsValid then begin
            clear(OutputJson);
            case RequestAction of
                'activate':
                    begin
                        // First step of authentication - validate credentials and generate OTP
                        OutputJson := ResetPassword(RequestDataJson);
                    end;
                'login':
                    begin
                        // First step of authentication - validate credentials and generate OTP
                        OutputJson := InitiateLogin(RequestDataJson);
                    end;
                'verify-otp':
                    begin
                        // Second step of authentication - verify OTP and create session
                        OutputJson := VerifyOTP(RequestDataJson);
                    end;
                'password-changed':
                    begin
                        OutputJson := ProcessPasswordChanged(RequestDataJson);
                    end;
                'logout':
                    begin
                        // Simple logout functionality
                        OutputJson := LogoutMember(RequestDataJson);
                    end;
                'dashboard':
                    begin
                        // Get member dashboard data
                        OutputJson := GetMemberDashboard(RequestDataJson);
                    end;
                'mark-notification-read':
                    begin
                        // Mark notification as read
                        OutputJson := MarkNotificationRead(RequestDataJson);
                    end;
                'notifications':
                    begin
                        // Get all notifications for member
                        OutputJson := GetNotifications(RequestDataJson);
                    end;
                'accounts':
                    begin
                        // Get member account details
                        OutputJson := GetMemberAccounts(RequestDataJson);
                    end;
                'loans':
                    begin
                        // Get member loan details
                        OutputJson := GetMemberLoans(RequestDataJson);
                    end;
                'profile':
                    begin
                        // Get member profile details
                        OutputJson := GetMemberProfile(RequestDataJson);
                    end;
                'request-account-reactivation':
                    begin
                        OutputJson := ProcessPortalMemberRequest(
                            RequestDataJson,
                            'ACCOUNT_REACTIVATION',
                            'Account Reactivation Requested',
                            'Your dormant account reactivation request has been received.',
                            PortalActionLogEntryNo
                        );
                    end;
                'request-atm-card-reactivation':
                    begin
                        OutputJson := ProcessPortalMemberRequest(
                            RequestDataJson,
                            'ATM_CARD_REACTIVATION',
                            'ATM Card Reactivation Requested',
                            'Your ATM card renewal/reactivation request has been received.',
                            PortalActionLogEntryNo
                        );
                    end;
                'transfers':
                    begin
                        // Get member transfer details
                        OutputJson := GetMemberTransfers(RequestDataJson);
                    end;
                'internal-transfer':
                    begin
                        // Get member transfer details
                        OutputJson := ProcessInternalTransfer(RequestDataJson);
                    end;
                'security-questions':
                    begin
                        // Get security questions for member
                        OutputJson := GetMemberSecurityQuestions(RequestDataJson);
                    end;
                'validate-security-question':
                    begin
                        // Validate member's answer to a security question
                        OutputJson := ValidateMemberSecurityQuestion(RequestDataJson);
                    end;
                'setup-security-question':
                    begin
                        // Set up a new security question for member
                        OutputJson := SetupSecurityQuestion(RequestDataJson);
                    end;


                'get-statement':
                    begin
                        // Set up a new security question for member
                        OutputJson := GetMemberStatement(RequestDataJson);
                    end;



                'generate-loan-application':
                    begin
                        // Generate a new loan application
                        OutputJson := GenerateLoanApplication(RequestDataJson);
                    end;


                'validate-guarantor':
                    begin
                        // Generate a new loan application
                        OutputJson := ValidateGuarantor(RequestDataJson);
                    end;

                'validate-witness':
                    begin
                        // Generate a new loan application
                        OutputJson := ValidateWitness(RequestDataJson);
                    end;


                'save-guarantor-data':
                    begin
                        // Generate a new loan application
                        OutputJson := SaveGuarantors(RequestDataJson);
                    end;
                'complete-loan-application':
                    begin
                        // Generate a new loan application
                        OutputJson := CompleteLoanApplication(RequestDataJson);
                    end;

                'get-loan-details':
                    begin
                        // Get loan application details
                        OutputJson := GetLoanDetails(RequestDataJson);
                    end;

                'update-loan-details':
                    begin
                        // Get loan application details
                        OutputJson := UpdateLoanDetails(RequestDataJson);
                    end;



                // Add this case in the ProcessRequest procedure around line 60
                'get-loan-application-details':
                    begin
                        OutputJson := GetLoanApplicationDetails(RequestDataJson);
                    end;


                'get-loan-schedule':
                    begin
                        // Get loan application details
                        OutputJson := GetLoanSchedule(RequestDataJson);
                    end;

                'get-loan-guarantors':
                    begin
                        // Get loan application details
                        OutputJson := GetLoanGuarantors(RequestDataJson);
                    end;

                'get-loans-guaranteed':
                    begin
                        // Get loan application details
                        OutputJson := GetLoansGuaranteed(RequestDataJson);
                    end;


                'get-loan-form':
                    begin
                        // Get loan application details
                        OutputJson := GetLoanForm(RequestDataJson);
                    end;


                'remove-guarantor-from-application':
                    begin
                        // Remove guarantor from loan application
                        OutputJson := RemoveGuarantorFromApplication(RequestDataJson);
                    end;

                'add-guarantor-to-application':
                    begin
                        // Add guarantor to loan application
                        OutputJson := AddGuarantorToApplication(RequestDataJson);
                    end;

                'add-witness-to-application':
                    begin
                        OutputJson := AddWitnessToApplication(RequestDataJson);
                    end;
                'save-document-info':
                    begin
                        // Save document information for loan application
                        OutputJson := SaveDocumentInfo(RequestDataJson);
                    end;

                'delete-document-info':
                    begin
                        // Delete document information for loan application
                        OutputJson := DeleteDocumentInfo(RequestDataJson);
                    end;


                'get-application-documents':
                    begin
                        OutputJson := GetApplicationDocuments(RequestDataJson);
                    end;

                // Add to the ProcessRequest case statement
                'guarantor-response':
                    begin
                        // Handle guarantor response (accept/reject)
                        OutputJson := ProcessGuarantorResponse(RequestDataJson);
                    end;
                // Add to the ProcessRequest case statement
                'witness-response':
                    begin
                        // Handle guarantor response (accept/reject)
                        OutputJson := ProcessWitnessResponse(RequestDataJson);
                    end;

                'calculate-loan-with-schedule':
                    begin
                        OutputJson := CalculateLoanWithSchedule(RequestDataJson);
                    end;




                'get-comprehensive-leave-data':
                    begin
                        OutputJson := GetEmployeeLeaveDetails(RequestDataJson);
                    end;

                'initiate-new-leave-application':
                    begin
                        OutputJson := InitiateNewLeaveApplication(RequestDataJson);
                    end;


                'update-leave-application':
                    begin
                        OutputJson := UpdateLeaveApplication(RequestDataJson, false);
                    end;



                'complete-leave-application':
                    begin
                        OutputJson := UpdateLeaveApplication(RequestDataJson, true);
                    end;


                'get-p9-form':
                    begin
                        OutputJson := GetStaffP9Form(RequestDataJson);
                    end;


                'get-payslip':
                    begin
                        // Get payslip PDF
                        OutputJson := GetStaffPayslip(RequestDataJson);
                    end;



                'get-comprehensive-approval-data':
                    begin
                        OutputJson := GetComprehensiveApprovalData(RequestDataJson);
                    end;

                'get-leave-application-report':
                    begin
                        // Get Leave Application Report PDF
                        OutputJson := GetLeaveApplicationReport(RequestDataJson);
                    end;


                'create-savings-account':
                    begin
                        // Create new savings account
                        OutputJson := CreateSavingsAccount(RequestDataJson);
                    end;



                'create-fixed-deposit':
                    begin
                        // Create new fixed deposit account
                        OutputJson := CreateFixedDeposit(RequestDataJson);
                    end;


                'create-standing-order':
                    begin
                        // Create new standing order
                        OutputJson := CreateStandingOrder(RequestDataJson);
                    end;


                'pause-standing-order':
                    begin
                        // Pause standing order
                        OutputJson := PauseStandingOrder(RequestDataJson);
                    end;

                'resume-standing-order':
                    begin
                        // Resume standing order (uses same logic as pause-standing-order)
                        OutputJson := PauseStandingOrder(RequestDataJson);
                    end;


                'update-sto-amount':
                    begin
                        OutputJson := UpdateStandingOrderAmount(RequestDataJson);
                    end;
                'get-dividend-slip':
                    begin
                        // Set up a new security question for member
                        OutputJson := GetDividendSlip(RequestDataJson);
                    end;

                // ── Email queue (portal fetches → sends via SMTP → confirms back) ──────
                'get-email-queue':
                    begin
                        OutputJson := EmailMgt.HandleGetEmailQueue(RequestDataJson);
                    end;
                'confirm-email-sent':
                    begin
                        OutputJson := EmailMgt.HandleConfirmEmailSent(RequestDataJson);
                    end;

                else begin
                    //Aziz
                    Clear(OutputJson);
                    OutputJson.Add('status', 'error');
                    OutputJson.Add('message', 'Invalid request action');
                end;
            end;
        end;

        OutputJson.Add('session_id', SessionID);
        OutputJson.WriteTo(Response);
    end;







    procedure ProcessRegistrationRequest(Request: Text) Response: Text;
    var

        PreviousDataJson: JsonObject;
        NomineesArray: JsonArray;
        NomineeJson: JsonObject;
        RequiredDocsArray: JsonArray;
        DocJson: JsonObject;
        EmployersArray: JsonArray;
        EmployerJson: JsonObject;
        UploadedDocsArray: JsonArray;
        UploadedDocJson: JsonObject;
        //NextOfKinRec: Record "Next of Kin.";
        NextOfKinRec: Record Nominee;
        GeneralDocuments: Record "Attachment Documents";
        Customer: Record Customer;
        PortalUploads: Record "Portal Uploads";
        SMSBody: Text;
        EmailBody: Text;
        Subject: Text;
        LoginAttempts: Integer;
        IPAddress: Text;
        Salutation: Text;
        RequestJson: JsonObject;
        OutputJson: JsonObject;
        RequestDataJson: JsonObject;
        RequestAction: Text;
        DataJson: JsonObject;
        JsonToken: JsonToken;
        OnlineRegReport: Report "Online Membership Application";
        Lead: Record "Portal Registration Attempt";
        MemberReg: Record "Member Registration";
        ExistingReg: Record "Member Registration";
        // NextOfKin: Record "Next of Kin.";
        NextOfKin: Record Nominee;
        Members: Record "Members";
        Name: Text[200];
        NOKArr: JsonArray;
        NOKObj: JsonObject;
        i: Integer;
        DocumentsObj: JsonObject;
        DocumentTypeArr: JsonArray;
        DocumentObj: JsonObject;

        varTempBlob: CodeUnit "Temp Blob";
        vConvertedContent: text;
        j: Integer;
        ApplicationNo: Code[20];
        TotalAllocation: Decimal;
        DocumentType: Text;
        FileName: Text;
        BlobPath: Text;
        FileUrl: Text;
        UploadTimestamp: Text;
        DocumentTypeName: Text;

        MpesaReceipt: Text;
        AcceptTerms: Boolean;
        TempBlob: Codeunit "Temp Blob";
        ReportInStream: InStream;
        ReportOutStream: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
        PdfBase64: Text;

        OTPCode: Code[20];
        AccessKey: Text[2000];
        ExpiryTime: DateTime;
        SkyTransaction: Record "Sky M-Banking Transactions";
        ProdSetup: Record "Product Setup";
        RegistrationFee: Decimal;
        DefaultAccounts: Record "Default Savings Products.";
        EnrolMobileBanking: Boolean;
    begin
        if not RequestJson.ReadFrom(Request) then
            Error('Invalid Json Input');

        RequestAction := SelectJsonToken(RequestJson, '$.request.action').AsValue.AsText;
        RequestDataJson := SelectJsonToken(RequestJson, '$.request.payload.data').AsObject();

        if RequestAction = 'generate-otp' then begin


            Members.Reset();
            Members.SetRange("E-mail", SelectJsonToken(RequestDataJson, '$.email').AsValue.AsText);
            if Members.FindFirst() then begin
                // User already has a registration attempt
                SetResponseStatus(OutputJson, 'error', 'OTP Generation Failed', 'Email already in use.');
                OutputJson.WriteTo(Response);
                exit;
            end;

            Members.Reset();
            Members.SetRange("Mobile Phone No.", SelectJsonToken(RequestDataJson, '$.mobile_number').AsValue.AsText);
            if Members.FindFirst() then begin
                // User already has a registration attempt
                SetResponseStatus(OutputJson, 'error', 'OTP Generation Failed', 'Mobile number already in use.');
                OutputJson.WriteTo(Response);
                exit;
            end;

            // Check if user already has a registration attempt
            Lead.Reset();
            Lead.SetRange("E-mail", SelectJsonToken(RequestDataJson, '$.email').AsValue.AsText);
            if Lead.FindFirst() then begin
                // Update existing record
                Lead."Phone No." := SelectJsonToken(RequestDataJson, '$.mobile_number').AsValue.AsText;
                Lead."First Name" := SelectJsonToken(RequestDataJson, '$.first_name').AsValue.AsText;
                Lead.Surname := SelectJsonToken(RequestDataJson, '$.surname').AsValue.AsText;
                Lead."Other Names" := SelectJsonToken(RequestDataJson, '$.second_name').AsValue.AsText;
                Lead.Name := Lead."First Name" + ' ' + Lead."Other Names" + ' ' + Lead.Surname;
                Lead.Date := Today;

                // Generate new OTP (6-digit random number)
                OTPCode := Format(Random(900000) + 100000);
                Lead.OTP := OTPCode;

                // Generate access key (simple GUID for now)
                AccessKey := Format(CreateGuid());
                Lead."Access Key" := CopyStr(AccessKey, 1, MaxStrLen(Lead."Access Key"));

                // Set OTP expiry time (10 minutes from now)
                ExpiryTime := CurrentDateTime + (10 * 60 * 1000); // 10 minutes in milliseconds
                Lead."OTP Expiry Time" := ExpiryTime;

                Lead."Member Type" := Lead."Member Type"::Individual;

                if Lead.Modify() then begin
                    SetResponseStatus(OutputJson, 'success', 'OTP Generated', 'OTP has been sent to your phone and email.');
                    OutputJson.Add('otp_sent', true);
                    OutputJson.Add('otp', Lead.OTP);
                    OutputJson.Add('email', Lead."E-mail");
                    OutputJson.Add('phone', Lead."Phone No.");
                    OutputJson.Add('access_key', Lead."Access Key");
                    OutputJson.Add('expires_at', Format(Lead."OTP Expiry Time", 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>Z'));


                    // Send OTP via SMS if phone number available
                    if Lead."Phone No." <> '' then begin

                        SMSBody := 'Dear ' + Lead."First Name" + ',';
                        SMSBody := 'Your Registration verification code is ' + Lead.OTP + '. Valid up to ' + Format(Lead."OTP Expiry Time") + '. Do not share this code.';
                        smsDispatch.SendInstantSMS(Source::PIN, Lead."Phone No.", SMSBody, '', '', FALSE, 205, FALSE);


                    end;


                    // Send OTP via email if email available
                    if Lead."E-Mail" <> '' then begin
                        Subject := 'Your Registration Verification Code';
                        EmailBody := 'Dear ' + Lead."First Name" + ',<br><br>';
                        EmailBody += 'Your registration verification code is <strong>' + Lead.OTP + '</strong> Valid up to ' + Format(Lead."OTP Expiry Time") + '. Do not share this code.';
                        EmailBody += 'Do not share this code with anyone.<br><br>';
                        EmailBody += 'Best regards,<br>Your SACCO Team';

                        EmailMgt.QueueEmail(Lead."E-Mail", Subject, EmailBody);

                        if SaccoSetup.get and (SaccoSetup."Send Email via Portal") then
                            SendEmailTryFunction(Lead."E-Mail", '', '', Subject, Salutation, EmailBody);
                        //if SaccoActivity.SendEmail(Lead."E-Mail", '', '', Subject, Salutation, EmailBody) then;

                    end;

                end else begin
                    SetResponseStatus(OutputJson, 'error', 'OTP Generation Failed', 'Could not update registration attempt.');
                end;
            end else begin
                // Create new registration attempt
                Lead.Init();
                Lead."E-mail" := SelectJsonToken(RequestDataJson, '$.email').AsValue.AsText;
                Lead."Phone No." := SelectJsonToken(RequestDataJson, '$.mobile_number').AsValue.AsText;
                Lead."First Name" := SelectJsonToken(RequestDataJson, '$.first_name').AsValue.AsText;
                Lead.Surname := SelectJsonToken(RequestDataJson, '$.surname').AsValue.AsText;
                Lead."Other Names" := SelectJsonToken(RequestDataJson, '$.second_name').AsValue.AsText;
                Lead.Name := CopyStr(Name, 1, MaxStrLen(Lead.Name));
                Lead.Date := Today;

                // Generate OTP (6-digit random number)
                OTPCode := Format(Random(900000) + 100000);
                Lead.OTP := OTPCode;

                // Generate access key
                AccessKey := Format(CreateGuid());
                Lead."Access Key" := CopyStr(AccessKey, 1, MaxStrLen(Lead."Access Key"));

                // Set OTP expiry time (10 minutes from now)
                ExpiryTime := CurrentDateTime + (10 * 60 * 1000); // 10 minutes in milliseconds
                Lead."OTP Expiry Time" := ExpiryTime;

                Lead."Member Type" := Lead."Member Type"::Individual;

                if Lead.Insert(true) then begin
                    SetResponseStatus(OutputJson, 'success', 'OTP Generated', 'OTP has been sent to your phone and email.');
                    OutputJson.Add('otp_sent', true);
                    OutputJson.Add('email', Lead."E-mail");
                    OutputJson.Add('phone', Lead."Phone No.");
                    OutputJson.Add('access_key', Lead."Access Key");
                    OutputJson.Add('expires_at', Format(Lead."OTP Expiry Time", 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>Z'));


                    // Send OTP via SMS if phone number available
                    if Lead."Phone No." <> '' then begin

                        SMSBody := 'Dear ' + Lead."First Name" + ',';
                        SMSBody := 'Your Registration verification code is ' + Lead.OTP + '. Valid up to ' + Format(Lead."OTP Expiry Time") + '. Do not share this code.';

                        smsDispatch.SendInstantSMS(Source::PIN, Lead."Phone No.", SMSBody, '', '', FALSE, 205, FALSE);

                    end;

                    // Send OTP via email if email available
                    if Lead."E-Mail" <> '' then begin
                        Subject := 'Your Registration Verification Code';
                        EmailBody := 'Dear ' + Lead."First Name" + ',<br><br>';
                        EmailBody += 'Your registration verification code is <strong>' + Lead.OTP + '</strong> Valid up to ' + Format(Lead."OTP Expiry Time") + '. Do not share this code.';
                        EmailBody += 'Do not share this code with anyone.<br><br>';
                        EmailBody += 'Best regards,<br>Your SACCO Team';

                        //if SaccoActivity.SendEmail(Lead."E-Mail", '', '', Subject, Salutation, EmailBody) then;
                        if SaccoSetup.get and (SaccoSetup."Send Email via Portal") then
                            SendEmailTryFunction(Lead."E-Mail", '', '', Subject, Salutation, EmailBody)

                    end;

                end else begin
                    SetResponseStatus(OutputJson, 'error', 'OTP Generation Failed', 'Could not create registration attempt.');
                end;

            end;
        end else if RequestAction = 'verify-otp' then begin
            // Extract OTP and email from request

            // Check if user already has a registration attempt
            Lead.Reset();
            Lead.SetRange("E-mail", SelectJsonToken(RequestDataJson, '$.email').AsValue.AsText);
            //Lead.SetRange("OTP", SelectJsonToken(RequestDataJson, '$.otp').AsValue.AsText);
            if Lead.FindFirst() then begin
                // OTP found, verify it
                if Lead."OTP Expiry Time" > CurrentDateTime then begin


                    MemberReg.Reset();
                    MemberReg.SetRange("E-mail", SelectJsonToken(RequestDataJson, '$.email').AsValue.AsText);
                    if not MemberReg.FindFirst() then begin
                        MemberReg.Init();
                        MemberReg."Portal Application" := true;
                        MemberReg."First Name" := Lead."First Name";
                        MemberReg."Middle Name" := Lead."Other Names";
                        MemberReg.Surname := Lead.Surname;
                        MemberReg."Mobile Phone No." := Lead."Phone No.";
                        MemberReg."E-mail" := Lead."E-mail";
                        MemberReg.Insert(true);
                    end;


                    MemberReg.Reset();
                    MemberReg.SetRange("E-mail", SelectJsonToken(RequestDataJson, '$.email').AsValue.AsText);
                    if MemberReg.FindFirst() then begin
                        // Build previous data response with existing registration details


                        // Build basic member details
                        PreviousDataJson.Add('first_name', MemberReg."First Name");
                        PreviousDataJson.Add('second_name', MemberReg."Middle Name");
                        PreviousDataJson.Add('surname', MemberReg.Surname);
                        PreviousDataJson.Add('dob', yyyyMMdd(MemberReg."Date of Birth"));
                        PreviousDataJson.Add('gender', Format(MemberReg.Gender));
                        PreviousDataJson.Add('id_type', Format(MemberReg."ID Type"));
                        PreviousDataJson.Add('id_number', MemberReg."ID No.");
                        PreviousDataJson.Add('phone_number', MemberReg."Mobile Phone No.");
                        PreviousDataJson.Add('email', MemberReg."E-Mail");
                        PreviousDataJson.Add('postal_address', MemberReg.Address);
                        PreviousDataJson.Add('physical_address', MemberReg."Address 2");
                        PreviousDataJson.Add('marital_status', Format(MemberReg."Marital Status"));
                        PreviousDataJson.Add('employer', MemberReg."Employer Code");
                        PreviousDataJson.Add('staff_number', MemberReg."Payroll/Staff No.");
                        PreviousDataJson.Add('pin_number', MemberReg."KRA PIN");
                        PreviousDataJson.Add('recruited_by_id', MemberReg."Recruited By");
                        PreviousDataJson.Add('recruited_by_name', MemberReg."Recruited By Name");
                        PreviousDataJson.Add('recruited_by_phone', MemberReg."Recruited By Phone");
                        PreviousDataJson.Add('is_employed', MemberReg."Self Employed");
                        PreviousDataJson.Add('business_name', MemberReg."Business Name");
                        PreviousDataJson.Add('business_type', MemberReg."Other Type Of Business");
                        PreviousDataJson.Add('business_location', MemberReg."Business/Group Location");

                        // Get nominees/next of kin
                        NextOfKinRec.Reset();
                        NextOfKinRec.SetRange("No.", MemberReg."No.");
                        if NextOfKinRec.FindSet() then begin
                            repeat
                                Clear(NomineeJson);
                                NomineeJson.Add('name', NextOfKinRec.Name);
                                NomineeJson.Add('relationship', NextOfKinRec.Relationship);
                                NomineeJson.Add('phone', NextOfKinRec."Mobile Phone No.");
                                NomineeJson.Add('id', NextOfKinRec."ID No.");
                                NomineeJson.Add('dob', yyyyMMdd(NextOfKinRec."Date of Birth"));
                                NomineeJson.Add('email', NextOfKinRec."E-Mail");
                                NomineeJson.Add('percentage', NextOfKinRec."%Allocation");
                                NomineesArray.Add(NomineeJson);
                            until NextOfKinRec.Next() = 0;
                        end;
                        PreviousDataJson.Add('nominees', NomineesArray);

                        // Get required documents (using general documents as example)
                        GeneralDocuments.Reset();
                        GeneralDocuments.SetRange("Application Type", GeneralDocuments."Application Type"::Individual);
                        GeneralDocuments.SetFilter("Document Decsription", '<>%1', '');
                        if GeneralDocuments.FindSet() then begin
                            repeat
                                Clear(DocJson);
                                DocJson.Add('code', GeneralDocuments."Document ID");
                                DocJson.Add('label', GeneralDocuments."Document Decsription");
                                DocJson.Add('allowed_formats', '.pdf,.jpg,.png'); // or dynamic (see below)
                                DocJson.Add('max_size_mb', 2);
                                DocJson.Add('max_files', 1);
                                RequiredDocsArray.Add(DocJson);
                            until GeneralDocuments.Next() = 0;
                        end;
                        PreviousDataJson.Add('required_documents', RequiredDocsArray);

                        // Get employers list
                        Customer.Reset();
                        Customer.SetRange("Account Type", Customer."Account Type"::Employer);
                        if Customer.FindSet() then begin
                            repeat
                                Clear(EmployerJson);
                                EmployerJson.Add('code', Customer."No.");
                                EmployerJson.Add('name', Customer.Name);
                                EmployersArray.Add(EmployerJson);
                            until Customer.Next() = 0;
                        end;
                        PreviousDataJson.Add('employers', EmployersArray);

                        // Get uploaded documents for this application
                        PortalUploads.Reset();
                        PortalUploads.SetRange("Member No.", MemberReg."ID No.");
                        PortalUploads.SetRange("Loan Application No.", MemberReg."No.");
                        if PortalUploads.FindSet() then begin
                            repeat
                                Clear(UploadedDocJson);
                                UploadedDocJson.Add('id', Format(PortalUploads.ID));
                                UploadedDocJson.Add('document_type', PortalUploads.Type);
                                UploadedDocJson.Add('file_name', PortalUploads.Name);
                                UploadedDocJson.Add('blob_path', PortalUploads."Blob Name");
                                UploadedDocJson.Add('file_url', PortalUploads."Blob Url");
                                UploadedDocJson.Add('upload_timestamp', Format(PortalUploads.Date) + 'T' + Format(PortalUploads.Time));
                                UploadedDocsArray.Add(UploadedDocJson);
                            until PortalUploads.Next() = 0;
                        end;
                        PreviousDataJson.Add('uploaded_documents', UploadedDocsArray);

                        // Add previous data to main response
                        OutputJson.Add('previous_data', PreviousDataJson);
                        OutputJson.Add('application_number', MemberReg."No.");
                        OutputJson.Add('application_stage', Format(MemberReg."Portal Application Stage"));


                        SetResponseStatus(OutputJson, 'success', 'OTP Verification Successful', 'OTP has been verified successfully.');
                    end
                end else begin
                    SetResponseStatus(OutputJson, 'error', 'OTP Verification Failed', 'OTP has expired.');
                end;

            end else begin
                SetResponseStatus(OutputJson, 'error', 'OTP Verification Failed', 'Could not verify OTP.');
            end;

        end
        else if RequestAction = 'member-details' then begin
            if not ValidateRegistrationMemberDetails(RequestDataJson, ResponseMessage) then begin
                SetResponseStatus(OutputJson, 'error', 'Invalid Member Details', ResponseMessage);
                OutputJson.WriteTo(Response);
                exit;
            end;

            if RequestDataJson.Contains('enrol_mobile_banking') then
                EnrolMobileBanking := SelectJsonToken(RequestDataJson, '$.enrol_mobile_banking').AsValue.AsBoolean
            else
                EnrolMobileBanking := false;

            // Check if registration already exists by ID number or phone
            ExistingReg.Reset();
            ExistingReg.SetRange("No.", SelectJsonToken(RequestDataJson, '$.application_number').AsValue.AsText);
            ExistingReg.SetRange("E-Mail", SelectJsonToken(RequestDataJson, '$.email').AsValue.AsText);
            if ExistingReg.FindFirst() then begin
                if ExistingReg.Status = ExistingReg.Status::Open then begin
                    // Update existing record - use ExistingReg, not MemberReg

                    ExistingReg.Type := ExistingReg.Type::Member;
                    ExistingReg."Account Category" := ExistingReg."Account Category"::Individual;
                    ExistingReg."First Name" := SelectJsonToken(RequestDataJson, '$.first_name').AsValue.AsText;
                    ExistingReg."Middle Name" := SelectJsonToken(RequestDataJson, '$.second_name').AsValue.AsText;
                    ExistingReg.Surname := SelectJsonToken(RequestDataJson, '$.surname').AsValue.AsText;
                    ExistingReg.Validate("First Name");
                    ExistingReg."Date of Birth" := SelectJsonToken(RequestDataJson, '$.dob').AsValue.AsDate;
                    if LowerCase(SelectJsonToken(RequestDataJson, '$.gender').AsValue.AsText) = 'male' then
                        ExistingReg.Gender := ExistingReg.Gender::"Male";
                    if LowerCase(SelectJsonToken(RequestDataJson, '$.gender').AsValue.AsText) = 'female' then
                        ExistingReg.Gender := ExistingReg.Gender::"Female";
                    ExistingReg."ID Type" := ExistingReg."ID Type"::"National ID";
                    if LowerCase(SelectJsonToken(RequestDataJson, '$.id_type').AsValue.AsText) = 'passport' then
                        ExistingReg."ID Type" := ExistingReg."ID Type"::Passport;
                    ExistingReg."ID No." := SelectJsonToken(RequestDataJson, '$.id_number').AsValue.AsText;
                    ExistingReg."Mobile Phone No." := SelectJsonToken(RequestDataJson, '$.phone_number').AsValue.AsText;
                    ExistingReg."E-Mail" := SelectJsonToken(RequestDataJson, '$.email').AsValue.AsText;
                    ExistingReg.Address := SelectJsonToken(RequestDataJson, '$.postal_address').AsValue.AsText;
                    ExistingReg."Address 2" := SelectJsonToken(RequestDataJson, '$.physical_address').AsValue.AsText;
                    ExistingReg."Marital Status" := ExistingReg."Marital Status"::Single;
                    if LowerCase(SelectJsonToken(RequestDataJson, '$.marital_status').AsValue.AsText) = 'others' then
                        ExistingReg."Marital Status" := ExistingReg."Marital Status"::Others;
                    if LowerCase(SelectJsonToken(RequestDataJson, '$.marital_status').AsValue.AsText) = 'separated' then
                        ExistingReg."Marital Status" := ExistingReg."Marital Status"::Seperated;
                    if LowerCase(SelectJsonToken(RequestDataJson, '$.marital_status').AsValue.AsText) = 'single' then
                        ExistingReg."Marital Status" := ExistingReg."Marital Status"::Single;
                    if LowerCase(SelectJsonToken(RequestDataJson, '$.marital_status').AsValue.AsText) = 'widowed' then
                        ExistingReg."Marital Status" := ExistingReg."Marital Status"::Widowed;
                    if LowerCase(SelectJsonToken(RequestDataJson, '$.marital_status').AsValue.AsText) = 'widower' then
                        ExistingReg."Marital Status" := ExistingReg."Marital Status"::Widower;
                    if LowerCase(SelectJsonToken(RequestDataJson, '$.marital_status').AsValue.AsText) = 'married' then
                        ExistingReg."Marital Status" := ExistingReg."Marital Status"::Married;
                    if LowerCase(SelectJsonToken(RequestDataJson, '$.marital_status').AsValue.AsText) = 'divorced' then
                        ExistingReg."Marital Status" := ExistingReg."Marital Status"::Divorced;

                    if SelectJsonToken(RequestDataJson, '$.is_self_employed').AsValue.AsBoolean then begin // in the system taken as eself employed

                        // Clear employment fields
                        ExistingReg."Employer Code" := '';


                        // Fill business fields
                        ExistingReg."Business Name" :=
                            SelectJsonToken(RequestDataJson, '$.business_name').AsValue.AsText;

                        ExistingReg."Other Type Of Business" :=
                            SelectJsonToken(RequestDataJson, '$.business_type').AsValue.AsText;

                        ExistingReg."Business/Group Location" :=
                            SelectJsonToken(RequestDataJson, '$.business_location').AsValue.AsText;




                    end else begin
                        ExistingReg."Employer Code" :=
                            SelectJsonToken(RequestDataJson, '$.employer').AsValue.AsText;

                        // Clear business fields
                        ExistingReg."Business Name" := '';
                        ExistingReg."Other Type Of Business" := '';
                        ExistingReg."Business/Group Location" := '';

                    end;
                    ExistingReg."Recruited By" := SelectJsonToken(RequestDataJson, '$.recruited_by_id').AsValue.AsText;
                    ExistingReg."Recruited By Name" := SelectJsonToken(RequestDataJson, '$.recruited_by_name').AsValue.AsText;
                    ExistingReg."Recruited By Phone" := SelectJsonToken(RequestDataJson, '$.recruited_by_phone').AsValue.AsText;
                    ExistingReg.Validate("Employer Code");
                    ExistingReg."Payroll/Staff No." := SelectJsonToken(RequestDataJson, '$.staff_number').AsValue.AsText;

                    ExistingReg."KRA PIN" := SelectJsonToken(RequestDataJson, '$.pin_number').AsValue.AsText;
                    ExistingReg."Join Mobile Banking" := EnrolMobileBanking;
                    ExistingReg.Status := ExistingReg.Status::Open;
                    ExistingReg."Portal Application" := true;
                    ExistingReg."Portal Application Stage" := ExistingReg."Portal Application Stage"::"Member Details";
                    if SelectJsonToken(RequestDataJson, '$.monthly_deposit_contribution_amount').AsValue.AsDecimal <> 0 then begin
                        DefaultAccounts.Init();
                        DefaultAccounts."Monthly Contribution" := SelectJsonToken(RequestDataJson, '$.monthly_deposit_contribution_amount').AsValue.AsDecimal;
                        DefaultAccounts.Product := 'S02';
                        DefaultAccounts.Validate(Product);
                        DefaultAccounts.Code := ExistingReg."No.";
                        if not DefaultAccounts.Insert() then
                            DefaultAccounts.Modify();

                    end;
                    if SelectJsonToken(RequestDataJson, '$.monthly_share_contribution').AsValue.AsDecimal <> 0 then begin
                        DefaultAccounts.Init();
                        DefaultAccounts."Monthly Contribution" := SelectJsonToken(RequestDataJson, '$.monthly_share_contribution').AsValue.AsDecimal;
                        DefaultAccounts.Product := 'S01';
                        DefaultAccounts.Validate(Product);
                        DefaultAccounts.Code := ExistingReg."No.";
                        if not DefaultAccounts.Insert() then
                            DefaultAccounts.Modify();

                    end;

                    if ExistingReg.Modify() then begin
                        if EnrolMobileBanking then
                            PortalLogMgt.LogAction(ExistingReg."No.", ExistingReg."E-Mail", 'MOBILE_BANKING_ENROLMENT', 'Member requested Mobile Banking enrolment during registration.');

                        SetResponseStatus(OutputJson, 'success', 'Registration Successful', 'Member application updated.');
                        OutputJson.Add('application_number', ExistingReg."No.");
                    end else begin
                        SetResponseStatus(OutputJson, 'error', 'Registration Failed', 'Could not update member application.');
                    end;
                end
                else begin
                    SetResponseStatus(OutputJson, 'error', 'Registration Failed', 'Member application with this ID already exists and is being processed.');
                    OutputJson.Add('application_no', ExistingReg."No.");
                end;
            end else begin
                // Create new registration record
                MemberReg.Init();
                MemberReg.Type := MemberReg.Type::Member;
                MemberReg."Account Category" := MemberReg."Account Category"::Individual;
                MemberReg."First Name" := SelectJsonToken(RequestDataJson, '$.first_name').AsValue.AsText;
                MemberReg."Middle Name" := SelectJsonToken(RequestDataJson, '$.second_name').AsValue.AsText;
                MemberReg.Surname := SelectJsonToken(RequestDataJson, '$.surname').AsValue.AsText;
                MemberReg.Validate("First Name");
                MemberReg."Date of Birth" := SelectJsonToken(RequestDataJson, '$.dob').AsValue.AsDate;
                if LowerCase(SelectJsonToken(RequestDataJson, '$.gender').AsValue.AsText) = 'male' then
                    MemberReg.Gender := MemberReg.Gender::"Male";
                if LowerCase(SelectJsonToken(RequestDataJson, '$.gender').AsValue.AsText) = 'female' then
                    MemberReg.Gender := MemberReg.Gender::"Female";
                MemberReg."ID Type" := MemberReg."ID Type"::"National ID";
                if LowerCase(SelectJsonToken(RequestDataJson, '$.id_type').AsValue.AsText) = 'passport' then
                    MemberReg."ID Type" := MemberReg."ID Type"::Passport;
                MemberReg."ID No." := SelectJsonToken(RequestDataJson, '$.id_number').AsValue.AsText;
                MemberReg."Mobile Phone No." := SelectJsonToken(RequestDataJson, '$.phone_number').AsValue.AsText;
                MemberReg."E-Mail" := SelectJsonToken(RequestDataJson, '$.email').AsValue.AsText;
                MemberReg.Address := SelectJsonToken(RequestDataJson, '$.postal_address').AsValue.AsText;
                MemberReg."Address 2" := SelectJsonToken(RequestDataJson, '$.physical_address').AsValue.AsText;
                MemberReg."Marital Status" := MemberReg."Marital Status"::Single;
                if LowerCase(SelectJsonToken(RequestDataJson, '$.marital_status').AsValue.AsText) = 'others' then
                    MemberReg."Marital Status" := MemberReg."Marital Status"::Others;
                if LowerCase(SelectJsonToken(RequestDataJson, '$.marital_status').AsValue.AsText) = 'separated' then
                    MemberReg."Marital Status" := MemberReg."Marital Status"::Seperated;
                if LowerCase(SelectJsonToken(RequestDataJson, '$.marital_status').AsValue.AsText) = 'single' then
                    MemberReg."Marital Status" := MemberReg."Marital Status"::Single;
                if LowerCase(SelectJsonToken(RequestDataJson, '$.marital_status').AsValue.AsText) = 'widowed' then
                    MemberReg."Marital Status" := MemberReg."Marital Status"::Widowed;
                if LowerCase(SelectJsonToken(RequestDataJson, '$.marital_status').AsValue.AsText) = 'widower' then
                    MemberReg."Marital Status" := MemberReg."Marital Status"::Widower;
                if LowerCase(SelectJsonToken(RequestDataJson, '$.marital_status').AsValue.AsText) = 'married' then
                    MemberReg."Marital Status" := MemberReg."Marital Status"::Married;
                if LowerCase(SelectJsonToken(RequestDataJson, '$.marital_status').AsValue.AsText) = 'divorced' then
                    MemberReg."Marital Status" := MemberReg."Marital Status"::Divorced;
                if SelectJsonToken(RequestDataJson, '$.is_self_employed').AsValue.AsBoolean then begin
                    MemberReg."Employer Code" := SelectJsonToken(RequestDataJson, '$.employer').AsValue.AsText;
                    MemberReg.Validate("Employer Code");

                    // Clear business fields
                    MemberReg."Business Name" := '';
                    MemberReg."Other Type Of Business" := '';
                    MemberReg."Business/Group Location" := '';

                end else begin

                    // Clear employment fields
                    MemberReg."Employer Code" := '';
                    // Fill business fields
                    MemberReg."Business Name" :=
                        SelectJsonToken(RequestDataJson, '$.business_name').AsValue.AsText;

                    MemberReg."Other Type Of Business" :=
                        SelectJsonToken(RequestDataJson, '$.business_type').AsValue.AsText;

                    MemberReg."Business/Group Location" :=
                        SelectJsonToken(RequestDataJson, '$.business_location').AsValue.AsText;
                end;




                MemberReg."Recruited By" := SelectJsonToken(RequestDataJson, '$.recruited_by_id').AsValue.AsText;
                MemberReg."Recruited By Name" := SelectJsonToken(RequestDataJson, '$.recruited_by_name').AsValue.AsText;
                MemberReg."Recruited By Phone" := SelectJsonToken(RequestDataJson, '$.recruited_by_phone').AsValue.AsText;
                MemberReg."Payroll/Staff No." := SelectJsonToken(RequestDataJson, '$.staff_number').AsValue.AsText;
                MemberReg."KRA PIN" := SelectJsonToken(RequestDataJson, '$.pin_number').AsValue.AsText;
                MemberReg."Join Mobile Banking" := EnrolMobileBanking;
                MemberReg.Status := MemberReg.Status::Open;
                MemberReg."Portal Application" := true;
                MemberReg."Portal Application Stage" := MemberReg."Portal Application Stage"::"Member Details";


                if SelectJsonToken(RequestDataJson, '$.monthly_deposit_contribution_amount').AsValue.AsDecimal <> 0 then begin
                    DefaultAccounts.Init();
                    DefaultAccounts."Monthly Contribution" := SelectJsonToken(RequestDataJson, '$.monthly_deposit_contribution_amount').AsValue.AsDecimal;
                    DefaultAccounts.Product := 'S02';
                    DefaultAccounts.Validate(Product);
                    DefaultAccounts.Code := MemberReg."No.";
                    if not DefaultAccounts.Insert(true) then
                        DefaultAccounts.Modify();

                end;
                if SelectJsonToken(RequestDataJson, '$.monthly_share_contribution').AsValue.AsDecimal <> 0 then begin
                    DefaultAccounts.Init();
                    DefaultAccounts."Monthly Contribution" := SelectJsonToken(RequestDataJson, '$.monthly_share_contribution').AsValue.AsDecimal;
                    DefaultAccounts.Product := 'S01';
                    DefaultAccounts.Validate(Product);
                    DefaultAccounts.Code := MemberReg."No.";
                    if not DefaultAccounts.Insert(true) then
                        DefaultAccounts.Modify();

                end;


                if MemberReg.Insert(true) then begin
                    if EnrolMobileBanking then
                        PortalLogMgt.LogAction(MemberReg."No.", MemberReg."E-Mail", 'MOBILE_BANKING_ENROLMENT', 'Member requested Mobile Banking enrolment during registration.');

                    SetResponseStatus(OutputJson, 'success', 'Registration Successful', 'Member application received.');
                    OutputJson.Add('application_number', MemberReg."No.");
                end else begin
                    SetResponseStatus(OutputJson, 'error', 'Registration Failed', 'Could not create member application.');
                end;
            end;
        end else
            if RequestAction = 'nominees' then begin
                ApplicationNo := SelectJsonToken(RequestDataJson, '$.application_number').AsValue.AsText;

                // Check if registration exists
                MemberReg.Reset();
                MemberReg.SetRange("No.", ApplicationNo);
                if not MemberReg.FindFirst() then begin
                    SetResponseStatus(OutputJson, 'error', 'Nominee Capture Failed', 'Application not found.');
                    OutputJson.Add('application_no', ApplicationNo);
                end else begin
                    if MemberReg.Status <> MemberReg.Status::Open then begin
                        SetResponseStatus(OutputJson, 'error', 'Registration Failed', 'Member application with this ID already exists and is being processed.');
                        OutputJson.Add('application_no', MemberReg."No.");
                    end
                    else begin
                        // Delete existing nominees for this application
                        NextOfKin.Reset();
                        NextOfKin.SetRange("No.", ApplicationNo);
                        if NextOfKin.FindFirst() then
                            NextOfKin.DeleteAll();

                        // Validate total allocation first
                        TotalAllocation := 0;
                        NOKArr := SelectJsonToken(RequestDataJson, '$.nominees').AsArray();
                        for i := 0 to NOKArr.Count - 1 do begin
                            NOKArr.Get(i, JsonToken);
                            NOKObj := JsonToken.AsObject();
                            TotalAllocation += SelectJsonToken(NOKObj, '$.percentage').AsValue.AsDecimal;
                        end;

                        if TotalAllocation <> 100 then begin
                            SetResponseStatus(OutputJson, 'error', 'Invalid Allocation', 'Total nominee allocation must equal 100%.');
                            OutputJson.Add('total_allocation', TotalAllocation);
                            OutputJson.Add('application_no', ApplicationNo);
                        end else begin
                            // Insert nominees
                            for i := 0 to NOKArr.Count - 1 do begin
                                NOKArr.Get(i, JsonToken);
                                NOKObj := JsonToken.AsObject();

                                NextOfKin.Init();
                                NextOfKin."No." := ApplicationNo;
                                //NextOfKin."Principal ID No." := MemberReg."ID No.";
                                NextOfKin.Name := CopyStr(SelectJsonToken(NOKObj, '$.name').AsValue.AsText, 1, MaxStrLen(NextOfKin.Name));
                                NextOfKin.Relationship := CopyStr(SelectJsonToken(NOKObj, '$.relationship').AsValue.AsText, 1, MaxStrLen(NextOfKin.Relationship));
                                NextOfKin."Mobile Phone No." := CopyStr(SelectJsonToken(NOKObj, '$.phone').AsValue.AsText, 1, MaxStrLen(NextOfKin."Mobile Phone No."));
                                NextOfKin."ID No." := CopyStr(SelectJsonToken(NOKObj, '$.id').AsValue.AsText, 1, MaxStrLen(NextOfKin."ID No."));
                                NextOfKin."E-Mail" := CopyStr(SelectJsonToken(NOKObj, '$.email').AsValue.AsText, 1, MaxStrLen(NextOfKin."E-Mail"));
                                NextOfKin."EMail" := NextOfKin."E-Mail";
                                NextOfKin."Date of Birth" := SelectJsonToken(NOKObj, '$.dob').AsValue.AsDate;
                                NextOfKin."%Allocation" := SelectJsonToken(NOKObj, '$.percentage').AsValue.AsDecimal;
                                NextOfKin.Beneficiary := true;
                                //NextOfKin."Next Of Kin" := true;
                                NextOfKin.Type := NextOfKin.Type::"Next of Kin";
                                NextOfKin.Insert(true);
                            end;
                            MemberReg."Portal Application Stage" := MemberReg."Portal Application Stage"::"Next of Kin Details";
                            MemberReg.Modify();
                            SetResponseStatus(OutputJson, 'success', 'Nominees Saved', 'Nominee details captured successfully.');
                            OutputJson.Add('application_no', ApplicationNo);
                            OutputJson.Add('nominees_count', NOKArr.Count);
                        end;
                    end;
                end;
            end
            else
                if RequestAction = 'documents' then begin
                    ApplicationNo := SelectJsonToken(RequestDataJson, '$.application_number').AsValue.AsText;

                    // Check if registration exists
                    MemberReg.Reset();
                    MemberReg.SetRange("No.", ApplicationNo);
                    if not MemberReg.FindFirst() then begin
                        SetResponseStatus(OutputJson, 'error', 'Document Upload Failed', 'Application not found.');
                        OutputJson.Add('application_no', ApplicationNo);
                    end else begin
                        if MemberReg.Status <> MemberReg.Status::Open then begin
                            SetResponseStatus(OutputJson, 'error', 'Registration Failed', 'Member application is already being processed.');
                            OutputJson.Add('application_no', MemberReg."No.");
                        end
                        else begin
                            // Delete existing documents for this application
                            PortalUploads.Reset();
                            PortalUploads.SetRange("Member No.", MemberReg."ID No.");
                            PortalUploads.SetRange("Loan Application No.", ApplicationNo);
                            if PortalUploads.FindFirst() then
                                PortalUploads.DeleteAll();

                            // Get documents object from JSON
                            DocumentTypeArr := SelectJsonToken(RequestDataJson, '$.documents').AsArray();


                            // Iterate through document types (id_copy, passport_photo, etc.)

                            // Process each document in the document type array
                            for j := 0 to DocumentTypeArr.Count - 1 do begin
                                DocumentTypeArr.Get(j, JsonToken);
                                DocumentObj := JsonToken.AsObject();

                                // Extract document details
                                DocumentType := SelectJsonToken(DocumentObj, '$.document_type').AsValue.AsText;
                                FileName := SelectJsonToken(DocumentObj, '$.file_name').AsValue.AsText;
                                BlobPath := SelectJsonToken(DocumentObj, '$.blob_path').AsValue.AsText;
                                FileUrl := SelectJsonToken(DocumentObj, '$.file_url').AsValue.AsText;
                                UploadTimestamp := SelectJsonToken(DocumentObj, '$.upload_timestamp').AsValue.AsText;

                                // Create portal upload record
                                PortalUploads.Init();
                                PortalUploads.GUID := CreateGuid();
                                PortalUploads.Date := Today;
                                PortalUploads.Time := Time;
                                PortalUploads."Member No." := MemberReg."ID No.";
                                PortalUploads."Member Name" := MemberReg.Name;
                                PortalUploads.Type := DocumentType;
                                PortalUploads.Name := FileName;
                                PortalUploads.Status := PortalUploads.Status::Pending;
                                PortalUploads."Blob Name" := BlobPath;
                                PortalUploads."Blob Url" := FileUrl;
                                PortalUploads.Path := FileUrl;
                                PortalUploads."Loan Application No." := ApplicationNo;

                                if not DownloadFileToPortalUploadBlob(FileUrl, PortalUploads) then begin
                                    SetResponseStatus(OutputJson, 'error', 'Document Storage Failed', 'Could not store document in Business Central: ' + FileName);
                                    OutputJson.WriteTo(Response);
                                    exit;
                                end;

                                // Extract file format from filename
                                if StrPos(FileName, '.') > 0 then
                                    PortalUploads.Format := CopyStr(FileName, StrPos(FileName, '.'), MaxStrLen(PortalUploads.Format));

                                PortalUploads.Insert(true);
                            end;



                            // Update member registration status to indicate documents uploaded
                            MemberReg."Portal Application Stage" := MemberReg."Portal Application Stage"::"Document Upload";
                            MemberReg.Modify();

                            SetResponseStatus(OutputJson, 'success', 'Documents Saved', 'Document details captured successfully.');
                            OutputJson.Add('application_no', ApplicationNo);
                            OutputJson.Add('documents_processed', PortalUploads.Count);
                        end;

                        if MemberReg.Get(ApplicationNo) then
                            CopyPortalUploadsToMemberReg(MemberReg);



                    end;
                end else
                    if RequestAction = 'terms' then begin
                        ApplicationNo := SelectJsonToken(RequestDataJson, '$.application_number').AsValue.AsText;
                        MpesaReceipt := SelectJsonToken(RequestDataJson, '$.mpesa_receipt').AsValue.AsText;
                        AcceptTerms := SelectJsonToken(RequestDataJson, '$.accept_terms').AsValue.AsBoolean;

                        ProdSetup.reset;
                        ProdSetup.SetRange("Product Category", ProdSetup."Product Category"::"Registration Fee");
                        if ProdSetup.findfirst then
                            RegistrationFee := ProdSetup."Minimum Contribution";

                        SkyTransaction.reset;
                        SkyTransaction.SetRange("Originator ID", MpesaReceipt);
                        SkyTransaction.setrange("Transaction Type", SkyTransaction."Transaction Type"::"Mpesa Deposit");

                        if not skytransaction.findfirst then begin
                            // SetResponseStatus(OutputJson, 'error', 'Registration Fee not Paid', 'Valid Mpesa receipt is required to confirm payment of registration fee of ' + Format(RegistrationFee));
                            // OutputJson.Add('application_no', ApplicationNo);
                            //OutputJson.WriteTo(Response);
                            // exit(Response);
                        end;



                        // Check if registration exists
                        MemberReg.Reset();
                        MemberReg.SetRange("No.", ApplicationNo);
                        if not MemberReg.FindFirst() then begin
                            SetResponseStatus(OutputJson, 'error', 'Terms Acceptance Failed', 'Application not found.');
                            OutputJson.Add('application_no', ApplicationNo);
                            OutputJson.WriteTo(Response);
                            exit(Response);
                        end else begin
                            if not AcceptTerms then begin
                                SetResponseStatus(OutputJson, 'error', 'Terms Acceptance Failed', 'Terms and conditions must be accepted.');
                                OutputJson.Add('application_no', ApplicationNo);
                                OutputJson.WriteTo(Response);
                                exit(Response);
                            end else begin
                                // Update member registration with terms acceptance
                                MemberReg."Terms Accepted" := true;
                                MemberReg."Terms Acceptance Date" := Today;
                                MemberReg."Mpesa Receipt No." := MpesaReceipt;
                                MemberReg."Portal Application Stage" := MemberReg."Portal Application Stage"::Completed;

                                if MemberReg.Modify() then begin

                                    if MemberReg."Mobile Phone No." <> '' then begin
                                        SMSBody := 'Dear ' + MemberReg."First Name" + ', your SACCO registration has been completed successfully. Application No: ' + MemberReg."No." + '.';
                                        smsDispatch.SendInstantSMS(Source::PIN, MemberReg."Mobile Phone No.", SMSBody, MemberReg."No.", '', FALSE, 205, FALSE);
                                    end;

                                    // Set filters for the report
                                    MemberReg.Reset();
                                    MemberReg.SetRange("No.", ApplicationNo);

                                    OnlineRegReport.SetTableView(MemberReg);
                                    varTempBlob.CreateOutStream(ReportOutStream, TextEncoding::UTF8);
                                    OnlineRegReport.SaveAs('', REPORTFORMAT::Pdf, ReportOutStream);
                                    varTempBlob.CreateInStream(ReportInStream, TextEncoding::UTF8);
                                    PdfBase64 := Base64Convert.ToBase64(ReportInStream);


                                    SetResponseStatus(OutputJson, 'success', 'Terms Accepted', 'Terms and conditions accepted successfully. Application completed.');
                                    OutputJson.Add('application_no', ApplicationNo);
                                    OutputJson.Add('mpesa_receipt', MpesaReceipt);
                                    OutputJson.Add('pdf_base64', PdfBase64);
                                    OutputJson.Add('application_status', 'Completed');

                                end else begin
                                    SetResponseStatus(OutputJson, 'error', 'Terms Acceptance Failed', 'Could not update application status.');
                                    OutputJson.Add('application_no', ApplicationNo);
                                end;
                            end;
                        end;
                    end else begin
                        SetResponseStatus(OutputJson, 'error', 'Invalid Action', 'Unknown registration action.');
                    end;

        OutputJson.WriteTo(Response);
    end;

    // ################################################################################################
    // update documents  in member registration
    procedure CopyPortalUploadsToMemberReg(var MemberReg: Record "Member Registration")
    var
        PortalUploads: Record "Portal Uploads";
        AttachmentDocs: Record "Attachment Documents";
        InS: InStream;
        OutS: OutStream;
        DocumentType: Text;
        Handled: Boolean;
    begin
        PortalUploads.Reset();
        PortalUploads.SetRange("Member No.", MemberReg."ID No.");

        if PortalUploads.FindSet() then begin
            repeat
                PortalUploads.CalcFields(Blob);

                if PortalUploads.Blob.HasValue then begin
                    DocumentType := UpperCase(PortalUploads.Type);
                    Handled := false;

                    case DocumentType of
                        'PICTURE', 'MEMBER_PICTURE', 'MEMBER_PHOTO', 'PASSPORT_PHOTO', 'APPLICANT_PHOTO':
                            begin
                                PortalUploads.Blob.CreateInStream(InS);

                                Clear(MemberReg.Picture);
                                MemberReg.Picture.CreateOutStream(OutS);

                                CopyStream(OutS, InS);
                                Handled := true;
                            end;

                        'SIGNATURE', 'APPLICANT_SIGNATURE':
                            begin
                                PortalUploads.Blob.CreateInStream(InS);

                                Clear(MemberReg.Signature);
                                MemberReg.Signature.CreateOutStream(OutS);

                                CopyStream(OutS, InS);
                                Handled := true;
                            end;
                    end;

                    if (not Handled) and AttachmentDocs.Get(PortalUploads.Type) then begin

                        case UpperCase(AttachmentDocs."Document ID") of

                            'PICTURE':
                                begin
                                    PortalUploads.Blob.CreateInStream(InS);

                                    Clear(MemberReg.Picture);
                                    MemberReg.Picture.CreateOutStream(OutS);

                                    CopyStream(OutS, InS);
                                end;

                            'SIGNATURE':
                                begin
                                    PortalUploads.Blob.CreateInStream(InS);

                                    Clear(MemberReg.Signature);
                                    MemberReg.Signature.CreateOutStream(OutS);

                                    CopyStream(OutS, InS);
                                end;

                        end;

                    end;

                end;

            until PortalUploads.Next() = 0;

            MemberReg.Modify(true);
        end;
    end;

    local procedure DownloadFileToPortalUploadBlob(FileUrl: Text; var PortalUploads: Record "Portal Uploads"): Boolean
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        Content: HttpContent;
        InS: InStream;
        OutS: OutStream;
    begin
        if FileUrl = '' then
            exit(false);

        if not Client.Get(FileUrl, ResponseMessage) then
            exit(false);

        if not ResponseMessage.IsSuccessStatusCode() then
            exit(false);

        Content := ResponseMessage.Content();
        Content.ReadAs(InS);

        Clear(PortalUploads.Blob);
        PortalUploads.Blob.CreateOutStream(OutS);
        CopyStream(OutS, InS);

        exit(true);
    end;


    // ################################################################################################
    // AUTHENTICATION FUNCTIONS
    // ################################################################################################

    local procedure InitiateLogin(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        DataJson: JsonObject;
        UserName: Text;
        Password: Text;
        MemberFound: Boolean;
        MemberNo: Code[20];
        OTPSent: Boolean;
        OTP: Text;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        ExpiryMinutes: Integer;
        SMSBody: Text;
        EmailBody: Text;
        Subject: Text;
        LoginAttempts: Integer;
        IPAddress: Text;
        Salutation: Text;
    begin
        // Extract credentials from request
        UserName := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        Password := SelectJsonToken(RequestJson, '$.password').AsValue.AsText;

        if UserName = '' then begin
            SetResponseStatus(ResponseJson, 'error', 'Missing Username', 'Username is required for login.');
            exit(ResponseJson);
        end;

        if Password = '' then begin
            SetResponseStatus(ResponseJson, 'error', 'Missing Password', 'Password is required for login.');
            exit(ResponseJson);
        end;


        // Try to get client IP address if available in the request
        if RequestJson.Contains('ip_address') then
            IPAddress := SelectJsonToken(RequestJson, '$.ip_address').AsValue.AsText()
        else
            IPAddress := 'Unknown';

        // Check rate limiting for login attempts
        if not EnforceRateLimit(UserName, 'LoginAttempt') then begin
            LogSecurityEvent('LoginRateLimited', UserName, 'Too many login attempts. Rate limit exceeded.', true);
            SetResponseStatus(ResponseJson, 'error', 'Rate Limit Exceeded', 'Too many login attempts. Please try again later.');
            exit(ResponseJson);
        end;

        MemberFound := false;


        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, UserName);
        if not PortalAuth.FindFirst() then begin

            PortalAuth.Reset();
            PortalAuth.SetRange("Member No.", UserName);
            if PortalAuth.FindFirst() then begin
                UserName := PortalAuth.UserName;
            end
            else begin

                PortalAuth.Reset();
                PortalAuth.SetRange("Old Member No.", UserName);
                if PortalAuth.FindFirst() then begin
                    UserName := PortalAuth.UserName;
                end
            end;

        end;



        // Attempt to authenticate
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, UserName);
        if PortalAuth.FindFirst() then begin
            // No need to check if account is locked, we'll rely on login attempt count
            /* if PortalAuth."Login Attempts Count" >= 5 then begin
                LogSecurityEvent('LoginAttemptBlocked', UserName, 'Login attempt on blocked account', true);
                SetResponseStatus(ResponseJson, 'error', 'Account Blocked', 'Your account has been blocked due to too many failed login attempts. Please contact support.');
                exit(ResponseJson);
            end; */

            // Check if password matches (either plaintext or hashed)
            if (UpperCase(PortalAuth.Password) = UpperCase(Password)) then begin
                MemberFound := true;

                // Reset login attempts on successful authentication
                PortalAuth."Login Attempts Count" := 0;
                PortalAuth.Modify();

                // Log successful authentication
                LogSecurityEvent('LoginSuccess', UserName, StrSubstNo('Successful login from IP: %1', IPAddress), false);

                Members.Get(PortalAuth."Member No.");
                MemberNo := Members."No.";

                // Check rate limiting for OTP generation
                if not EnforceRateLimit(UserName, 'OTPGeneration') then begin
                    LogSecurityEvent('OTPRateLimited', UserName, 'Too many OTP requests. Rate limit exceeded.', true);
                    SetResponseStatus(ResponseJson, 'error', 'Rate Limit Exceeded', 'Too many verification code requests. Please try again later.');
                    exit(ResponseJson);
                end;

                // Generate OTP
                OTP := GenerateRandomOTP();
                ExpiryMinutes := 5; // OTP valid for 5 minutes
                OTPSent := false;
                PortalAuth.OTP := OTP;
                PortalAuth."Session Expiry" := CurrentDateTime + (60 * 60 * 1000);
                PortalAuth."OTP Expiry" := CurrentDateTime + (ExpiryMinutes * 60 * 1000);
                PortalAuth.Modify();

                // Send OTP via SMS if phone number available
                if Members."Mobile Phone No." <> '' then begin

                    SMSBody := 'Dear ' + Members."First Name" + ',';
                    SMSBody := 'Your login verification code is ' + OTP + '. Valid for ' + Format(ExpiryMinutes) + ' minutes. Do not share this code.';

                    smsDispatch.SendInstantSMS(Source::PIN, Members."Mobile Phone No.", SMSBody, Members."No.", '', FALSE, 205, FALSE);
                    OTPSent := true;
                end;
                if Members."E-Mail" <> '' then begin
                    Subject := 'Your Login Verification Code';
                    EmailBody := 'Dear ' + Members."First Name" + ',<br><br>';
                    EmailBody += 'Your login verification code is <strong>' + OTP + '</strong><br>';
                    EmailBody += 'This code is valid for ' + Format(ExpiryMinutes) + ' minutes.<br>';
                    EmailBody += 'Do not share this code with anyone.<br><br>';
                    //EmailMgt.QueueEmail(Members."E-Mail", Subject, EmailBody);
                    EmailMessage.Create(Members."E-Mail", Subject, EmailBody);
                    Email.Send(EmailMessage);
                end;


                // Send OTP via email if email available
                if Members."E-Mail" <> '' then begin
                    Subject := 'Your Login Verification Code';
                    EmailBody := 'Dear ' + Members."First Name" + ',<br><br>';
                    EmailBody += 'Your login verification code is <strong>' + OTP + '</strong><br>';
                    EmailBody += 'This code is valid for ' + Format(ExpiryMinutes) + ' minutes.<br>';
                    EmailBody += 'Do not share this code with anyone.<br><br>';

                    //EmailMgt.QueueEmail(Members."E-Mail", Subject, EmailBody);
                    EmailMessage.Create(Members."E-Mail", Subject, EmailBody);
                    Email.Send(EmailMessage);

                    //if SaccoActivity.SendEmail(Members."E-Mail", '', '', Subject, Salutation, EmailBody) then;
                    if SaccoSetup.get and (SaccoSetup."Send Email via Portal") then begin
                        SendEmailTryFunction(Members."E-Mail", '', '', Subject, Salutation, EmailBody);
                        OTPSent := true;
                    end;
                end;

                // Log OTP generation
                LogSecurityEvent('OTPGenerated', UserName, 'OTP generated and sent to user', false);

                // Build success response
                SetResponseStatus(ResponseJson, 'success', 'OTP Generated', 'Verification code has been sent');

                // Create data object with minimal information needed for OTP verification
                DataJson.Add('member_id', MemberNo);
                DataJson.Add('member_no', MemberNo);
                DataJson.Add('username', PortalAuth.UserName);


                if (Members."First Name" = '') then
                    DataJson.Add('first_name', CopyStr(Members.Name, 1, StrPos(Members.Name, ' ') - 1))
                else
                    DataJson.Add('first_name', Members."First Name");


                DataJson.Add('member_category', format(Members."Member Category"));
                if (Members.Surname <> '') then
                    DataJson.Add('last_name', Members.Surname)
                else begin
                    if Members."Middle Name" <> '' then
                        DataJson.Add('last_name', Members."Middle Name")
                    else
                        DataJson.Add('last_name', CopyStr(Members.Name, StrPos(Members.Name, ' ') + 1))
                end;
                DataJson.Add('phone_number', Members."Mobile Phone No.");
                DataJson.Add('email', Members."E-Mail");
                DataJson.Add('otp_expires_in_minutes', ExpiryMinutes);




                ResponseJson.Add(Data, DataJson);
            end else begin
                // Failed authentication - increment login attempts
                LoginAttempts := PortalAuth."Login Attempts Count" + 1;
                PortalAuth."Login Attempts Count" := LoginAttempts;

                // Check if account should be locked
                if LoginAttempts >= 5 then begin
                    PortalAuth."Login Attempts Action" := 'Account locked due to multiple failed login attempts';
                    LogSecurityEvent('AccountLocked', UserName, StrSubstNo('Account locked after %1 failed attempts from IP: %2', LoginAttempts, IPAddress), true);
                end else begin
                    LogSecurityEvent('LoginFailure', UserName, StrSubstNo('Failed login attempt (%1 of 5) from IP: %2', LoginAttempts, IPAddress), true);
                end;

                PortalAuth.Modify();

                // Authentication failed response
                SetResponseStatus(ResponseJson, 'error', 'Authentication Failed', 'Invalid username or password');
            end;
        end else begin
            // User not found - log the attempt
            LogSecurityEvent('LoginFailureUserNotFound', UserName, StrSubstNo('Login attempt with non-existent username from IP: %1', IPAddress), true);
            SetResponseStatus(ResponseJson, 'error', 'Authentication Failed', 'Invalid username or password');
        end;
    end;

    local procedure ValidateSession(RequestJson: JsonObject; var IsValid: Boolean; SessionID: Text) ResponseJson: JsonObject
    var
        PortalAuth: Record "Portal Auth";
        username: Text;

    begin

        username := SelectJsonToken(RequestJson, '$.request.user').AsValue.AsText;

        IsValid := false;

        // Check if session exists and is valid
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, username);
        PortalAuth.SetRange("Access Key", SessionID);
        if PortalAuth.FindFirst() then begin

            if PortalAuth."Force PIN" then begin

                SetResponseStatus(ResponseJson, 'force_password_change', 'Change Password', 'Please change your password.');
                exit(ResponseJson);
            end;

            if CurrentDateTime <= PortalAuth."Session Expiry" then begin
                IsValid := true;
                PortalAuth."Last Active" := CurrentDateTime;
                PortalAuth."Session Expiry" := CurrentDateTime + (60 * 60 * 1000);
                PortalAuth.Modify();
            end
            else begin
                // Session expired
                SetResponseStatus(ResponseJson, 'session_error', 'Session Expired', 'Your session has expired. Please log in again.');
                exit(ResponseJson);
            end;


        end;

        if IsValid then
            SetResponseStatus(ResponseJson, 'success', 'Session Valid', 'Session is valid and active')
        else
            SetResponseStatus(ResponseJson, 'session_error', 'Session Invalid', 'Session has expired or is invalid');
    end;

    local procedure LogoutMember(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        PortalAuth: Record "Portal Auth";
        SessionID: Text;
        username: Text;
    begin
        SessionID := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;
        username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        // Remove or invalidate session
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, username);
        if PortalAuth.FindFirst() then begin
            PortalAuth."Access Key" := ''; // Clear session
            PortalAuth.Modify();

            SetResponseStatus(ResponseJson, 'success', 'Logout Successful', 'Member has been logged out successfully');
        end else
            SetResponseStatus(ResponseJson, 'error', 'Logout Failed', 'Session not found');
    end;


    local procedure VerifyOTP(RequestJson: JsonObject) ResponseJson: JsonObject
    var

        PortalAuth: Record "Portal Auth";
        Members: Record Members;
        DataJson: JsonObject;
        MemberNo: Code[20];
        OTP: Text;
        IsValid: Boolean;
        SessionID: Text;
        FirstName: Text;
        Branch: Text;
        BranchCode: Text;
        AccountStatus: Text;
        UserName: Text;
        Password: Text;
        MembershipDate: Date;
    begin

        OTP := SelectJsonToken(RequestJson, '$.otp').AsValue.AsText;
        // Extract credentials from request
        UserName := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        IsValid := false;
        // Attempt to authenticate with member number (direct match)
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, UserName);
        PortalAuth.SetRange(OTP, OTP);
        if PortalAuth.FindFirst() then begin
            if CurrentDateTime <= PortalAuth."OTP Expiry" then begin

                // Generate session ID
                SessionID := Format(CreateGuid());


                // Update existing record
                PortalAuth."Access Key" := SessionID;
                PortalAuth."Last Active" := CurrentDateTime;


                PortalAuth.OTP := '';
                PortalAuth.Modify();
                IsValid := true;

                Members.Get(PortalAuth."Member No.");

                // Create data object with session and member details
                DataJson.Add('member_id', Members."no.");
                DataJson.Add('session_id', SessionID);
                DataJson.Add('first_name', Members."First Name");
                DataJson.Add('member_no', Members."No.");
                DataJson.Add('username', PortalAuth.username);
                DataJson.Add('branch', Members."Global Dimension 2 Code");
                DataJson.Add('branch_code', Members."Global Dimension 2 Code");
                DataJson.Add('phone_number', Members."Mobile Phone No.");
                DataJson.Add('id_number', Members."ID No.");
                DataJson.Add('member_category', format(Members."Member Category"));
                DataJson.Add('membership_date', Format(Members."Registration Date"));
                DataJson.Add('account_status', AccountStatus);

                // Build success response
                SetResponseStatus(ResponseJson, 'success', 'Login Successful', 'Authentication completed successfully');
            end;
        end;

        if not IsValid then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid OTP', 'Verification code is invalid or expired');
            exit(ResponseJson);
        end;




        ResponseJson.Add(Data, DataJson);
    end;


    local procedure ProcessPasswordChanged(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        PortalAuth: Record "Portal Auth";
        Members: Record Members;
        Username: Text;
        Identifier: Text;
        CurrentPassword: Text;
        NewPassword: Text;
        ChangeTimestamp: Text;
        IsValid: Boolean;
        CryptoMgmt: Codeunit "Cryptography Management";
        Salt: Text;
        HashAlgorithmOption: Option MD5,SHA1,SHA256,SHA384,SHA512;
        HashedNewPassword: Text;
    begin
        // Extract parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        CurrentPassword := SelectJsonToken(RequestJson, '$.current_password').AsValue.AsText;
        NewPassword := SelectJsonToken(RequestJson, '$.new_password').AsValue.AsText;
        ChangeTimestamp := SelectJsonToken(RequestJson, '$.change_timestamp').AsValue.AsText;

        // Validate session and user
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        // Validate member exists
        if not Members.Get(PortalAuth."Member No.") then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Check current password
        if (UpperCase(PortalAuth.Password) <> UpperCase(CurrentPassword)) then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Password', 'Current password is incorrect');
            exit(ResponseJson);
        end;


        PortalAuth.Password := (NewPassword);
        PortalAuth."Force PIN" := false;
        PortalAuth.Modify();

        // Log the password change event
        LogSecurityEvent('PasswordChanged', Username, 'Password changed via portal at ' + ChangeTimestamp, false);

        SetResponseStatus(ResponseJson, 'success', 'Password Changed', 'Your password has been changed successfully');
        ResponseJson.Add('timestamp', Format(CurrentDateTime));
        exit(ResponseJson);
    end;

    local procedure ResetPassword(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        username: Code[20];
        randomText: Text;
        idNo: Text;
        OTPValid: Boolean;
        ExpiryMinutes: Integer;
        EmailBody: Text;
        SMSBody: Text;
        Subject: Text;
        Salutation: Text;
    begin
        username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        idNo := SelectJsonToken(RequestJson, '$.id_no').AsValue.AsText;


        randomText := '';
        // Update password
        PortalAuth.Reset();
        PortalAuth.SetRange("Username", username);
        if PortalAuth.FindFirst() and (username <> '') then begin
            Members.Reset();
            Members.SetRange("ID No.", PortalAuth.Username);
            //Members.SetRange("No.", PortalAuth."Member No.");
            //Members.SetRange("ID No.", idNo);
            if Members.FindFirst() then begin
                randomText := GenerateRandomWordNumber();
                //PortalAuth.UserName := Members."No.";
                PortalAuth.UserName := Members."ID No.";
                PortalAuth."User Status" := PortalAuth."user status"::Active;
                PortalAuth."Member No." := Members."No.";
                PortalAuth."Member Name" := Members.Name;
                PortalAuth."Old Member No." := Members."Old Member No.";
                PortalAuth.Password := randomText;
                PortalAuth."Mobile No." := Members."Mobile Phone No.";
                PortalAuth."Date Updated" := Today;
                PortalAuth."Created By" := UserId;
                PortalAuth."Force PIN" := true;
                PortalAuth."Reset PIN" := true;
                PortalAuth."PIN Encrypted" := false;
                PortalAuth."Login Attempts Action" := '';
                PortalAuth."Login Attempts Count" := 0;
                PortalAuth."Suspended Before" := false;
                PortalAuth."Last Active" := CurrentDateTime;
                PortalAuth.Password := SetPassword(randomText);
                PortalAuth.Modify();

            end
            else begin
                SetResponseStatus(ResponseJson, 'error', 'Password Reset', 'ID/Member not found');
                exit(ResponseJson);
            end;

        end else begin

            Members.Reset();
            Members.SetRange("ID No.", username);
            //Members.SetRange("No.", username);
            //Members.SetRange("ID No.", idNo);
            if Members.FindFirst() and (username <> '') then begin

                PortalAuth.Init();
                randomText := GenerateRandomWordNumber();
                PortalAuth.UserName := Members."ID No.";
                //PortalAuth.UserName := Members."No.";
                PortalAuth."User Status" := PortalAuth."user status"::Active;
                PortalAuth."Member No." := Members."No.";
                PortalAuth."Member Name" := Members.Name;
                PortalAuth."Old Member No." := Members."Old Member No.";
                PortalAuth.Password := randomText;
                PortalAuth."Mobile No." := Members."Mobile Phone No.";
                PortalAuth."Date Updated" := Today;
                PortalAuth."Created By" := UserId;
                PortalAuth."Force PIN" := true;
                PortalAuth."Reset PIN" := true;
                PortalAuth."PIN Encrypted" := false;
                PortalAuth."Login Attempts Action" := '';
                PortalAuth."Login Attempts Count" := 0;
                PortalAuth."Suspended Before" := false;
                PortalAuth."Last Active" := CurrentDateTime;
                PortalAuth.Password := SetPassword(randomText);
                PortalAuth.Insert();
            end
            else begin
                SetResponseStatus(ResponseJson, 'error', 'Password Reset', 'ID/Member not found #AXA');
                exit(ResponseJson);
            end;
        end;

        if randomText <> '' then begin

            ExpiryMinutes := 5; // OTP valid for 5 minutes
                                // Send OTP via SMS if phone number available
            if Members."Mobile Phone No." <> '' then begin
                SMSBody := 'Dear ' + Members."First Name" + ',';
                SMSBody += 'Your initial portal password is ' + randomText + '. Valid for ' + Format(ExpiryMinutes) + ' minutes. Do not share this code with anyone.';
                smsDispatch.SendInstantSMS(Source::PIN, Members."Mobile Phone No.", SMSBody, Members."No.", '', FALSE, 205, FALSE);
            end;

            // Send OTP via email if email available
            if Members."E-Mail" <> '' then begin
                Subject := 'Your Portal Verification Code';
                EmailBody := 'Dear ' + Members."First Name" + ',<br><br>';
                EmailBody += 'Your initial portal password is <strong>' + randomText + '</strong><br>';
                EmailBody += 'This code is valid for ' + Format(ExpiryMinutes) + ' minutes.<br>';
                EmailBody += 'Do not share this code with anyone.<br><br>';

                EmailMgt.QueueEmail(Members."E-Mail", Subject, EmailBody);

                //if SaccoActivity.SendEmail(Members."E-Mail", '', '', Subject, Salutation, EmailBody) then;
                if SaccoSetup.get and (SaccoSetup."Send Email via Portal") then
                    SendEmailTryFunction(Members."E-Mail", '', '', Subject, Salutation, EmailBody);
            end;
            SetResponseStatus(ResponseJson, 'success', 'Password Reset', 'Password has been reset successfully');
        end
        else
            SetResponseStatus(ResponseJson, 'error', 'Password Reset', 'Password could not be set');


    end;

    local procedure ChangePassword(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        PortalAuth: Record "Portal Auth";
        username: Text;
        OldPassword: Text;
        NewPassword: Text;
        PasswordValid: Boolean;
        CryptoMgmt: Codeunit "Cryptography Management";
        HashAlgorithmOption: Option MD5,SHA1,SHA256,SHA384,SHA512;
        Salt: Text;
        Util: Codeunit "Security Utils";
        HashedNewPassword: Text;
    begin
        username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        OldPassword := SelectJsonToken(RequestJson, '$.old_password').AsValue.AsText;
        NewPassword := SelectJsonToken(RequestJson, '$.new_password').AsValue.AsText;

        if not Util.ValidatePasswordComplexity(NewPassword) then begin
            SetResponseStatus(ResponseJson, 'error', 'Password Complexity', 'Password does not meet complexity requirements. must contain at least 8 characters, including uppercase, lowercase, number, and special character.');
            exit(ResponseJson);
        end;

        // Check rate limiting for password changes
        if not EnforceRateLimit(Username, 'PasswordReset') then begin
            LogSecurityEvent('PasswordResetRateLimited', Username, 'Too many password reset attempts', true);
            SetResponseStatus(ResponseJson, 'error', 'Rate Limit Exceeded', 'Too many password reset attempts. Please try again later.');
            exit(ResponseJson);
        end;

        // Verify old password (using secure verification method)
        PasswordValid := false;
        PortalAuth.Reset();
        PortalAuth.SetRange("UserName", UserName);
        if PortalAuth.FindFirst() then begin
            // Verify using hashed password
            if VerifyPasswordHash(OldPassword, PortalAuth.Password) then begin
                // Hash the new password
                Salt := Format(CreateGuid()); // Generate a new salt for each password change
                HashAlgorithmOption := 2; // SHA256 = 2
                HashedNewPassword := CryptoMgmt.GenerateHash(NewPassword + Salt, HashAlgorithmOption);

                // Store hashed password and combined format
                PortalAuth.Password := HashedNewPassword + '::' + Salt;
                PortalAuth.Modify();

                // Log successful password change
                LogSecurityEvent('PasswordChanged', username, 'Password changed successfully', false);

                SetResponseStatus(ResponseJson, 'success', 'Password Changed', 'Password has been changed successfully');
            end else begin
                // Log failed password change attempt
                LogSecurityEvent('PasswordChangeFailed', username, 'Incorrect old password', true);

                SetResponseStatus(ResponseJson, 'error', 'Invalid Password', 'Current password is incorrect');
            end;
        end else
            SetResponseStatus(ResponseJson, 'error', 'User Not Found', 'User account not found');
    end;

    // ################################################################################################
    // HELPER FUNCTIONS
    // ################################################################################################




    procedure SetResponseStatus(var ResponseJson: JsonObject; Status: Text; Title: Text; Message: Text)
    begin
        ResponseJson.Add('status', Status);
        ResponseJson.Add('title', Title);
        ResponseJson.Add('message', Message);
    end;

    local procedure ProcessPortalMemberRequest(RequestJson: JsonObject; ActionCode: Code[50]; ResponseTitle: Text; ResponseMessage: Text; PortalActionLogEntryNo: Integer) ResponseJson: JsonObject
    var
        Members: Record "Members";
        PortalAuth: Record "Portal Auth";
        DataJson: JsonObject;
        MemberNo: Code[20];
        Username: Text;
    begin
        if RequestJson.Contains('member_id') then
            MemberNo := CopyStr(SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText, 1, MaxStrLen(MemberNo));

        if MemberNo = '' then
            MemberNo := CopyStr(SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText, 1, MaxStrLen(MemberNo));

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        if MemberNo = '' then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Request', 'Member number is required.');
            exit(ResponseJson);
        end;

        if not Members.Get(MemberNo) then begin
            PortalAuth.Reset();
            PortalAuth.SetRange(UserName, Username);
            if PortalAuth.FindFirst() then
                MemberNo := PortalAuth."Member No.";
        end;

        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
            exit(ResponseJson);
        end;

        if ActionCode = 'ACCOUNT_REACTIVATION' then begin
            if Members."Member Status" = Members."Member Status"::Active then begin
                SetResponseStatus(ResponseJson, 'error', 'Account Already Active', 'Your account is already active.');
                exit(ResponseJson);
            end;

            if Members."Member Status" <> Members."Member Status"::Dormant then begin
                SetResponseStatus(ResponseJson, 'error', 'Account Not Dormant', 'Only dormant accounts can be reactivated from the portal.');
                exit(ResponseJson);
            end;

            Members."Member Status" := Members."Member Status"::Active;
            Members.Modify(true);
        end;

        SetResponseStatus(ResponseJson, 'success', ResponseTitle, ResponseMessage);
        DataJson.Add('member_id', MemberNo);
        DataJson.Add('request_action', ActionCode);
        DataJson.Add('request_reference', PortalActionLogEntryNo);
        DataJson.Add('request_time', Format(CurrentDateTime, 0, 9));
        ResponseJson.Add('data', DataJson);
        exit(ResponseJson);
    end;

    local procedure LogPortalActionFromRequest(RequestJson: JsonObject; RequestAction: Text) EntryNo: Integer
    var
        PortalAuth: Record "Portal Auth";
        MemberNo: Code[20];
        Username: Text;
        ActionCode: Code[50];
    begin
        if RequestJson.Contains('member_id') then
            MemberNo := CopyStr(SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText, 1, MaxStrLen(MemberNo));

        if (MemberNo = '') and RequestJson.Contains('identifier') then
            MemberNo := CopyStr(SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText, 1, MaxStrLen(MemberNo));

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        if (Username = '') and RequestJson.Contains('identifier') then
            Username := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        if (MemberNo = '') and (Username <> '') then begin
            PortalAuth.Reset();
            PortalAuth.SetRange(UserName, Username);
            if PortalAuth.FindFirst() then
                MemberNo := PortalAuth."Member No.";
        end;

        if RequestAction <> '' then begin
            ActionCode := CopyStr(UpperCase(RequestAction), 1, MaxStrLen(ActionCode));
            EntryNo := PortalLogMgt.LogAction(MemberNo, Username, ActionCode, 'Portal action performed: ' + RequestAction);
        end;
    end;

    // ################################################################################################
    // DASHBOARD FUNCTIONS
    // ################################################################################################

    local procedure GetMemberDashboard(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        DataJson: JsonObject;
        TransactionsArray: JsonArray;
        SavingsAccountsArray: JsonArray;
        LoanAccountsArray: JsonArray;
        LoanQualificationArray: JsonArray;
        GoalsArray: JsonArray;
        NotificationsArray: JsonArray;
        TransactionJson: JsonObject;
        GoalJson: JsonObject;
        NotificationJson: JsonObject;
        MemberId: Text;
        MemberNo: Code[20];
        SessionId: Text;
        Username: Text;
        SavingsDividendsChartArray: JsonArray;
    begin
        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;


        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if PortalAuth.FindFirst() then begin
            // Get Member No from Portal Auth if it exists
            MemberNo := PortalAuth."Member No.";


            // If we have a Member ID but no Member No, try to find Member No
            if not Members.Get(MemberNo) then begin
                SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
                exit(ResponseJson);
            end;

            // Initialize response
            SetResponseStatus(ResponseJson, 'success', 'Dashboard Data', 'Dashboard data retrieved successfully');
            ResponseJson.Add('timestamp', Format(CurrentDateTime));

            // Create data object
            DataJson.Add('member_id', MemberNo);
            DataJson.Add('member_no', MemberNo);
            DataJson.Add('old_member_no', Members."Old Member No.");


            if (Members."First Name" = '') then
                DataJson.Add('first_name', CopyStr(Members.Name, 1, StrPos(Members.Name, ' ') - 1))
            else
                DataJson.Add('first_name', Members."First Name");

            DataJson.Add('member_category', format(Members."Member Category"));

            if (Members.Surname <> '') then
                DataJson.Add('last_name', Members.Surname)
            else begin
                if Members."Middle Name" <> '' then
                    DataJson.Add('last_name', Members."Middle Name")
                else
                    DataJson.Add('last_name', CopyStr(Members.Name, StrPos(Members.Name, ' ') + 1))
            end;


            DataJson.Add('account_status', Format(Members."Global Dimension 1 Code"));

            // Add member financial data (replace with actual DB queries)
            GetMemberFinancialData(MemberNo, DataJson);

            // Create recent transactions array
            GetRecentTransactions(MemberNo, TransactionsArray);
            DataJson.Add('recent_transactions', TransactionsArray);

            // Create savings goals array
            GetSavingsGoals(MemberNo, GoalsArray);
            DataJson.Add('savings_goals', GoalsArray);

            // Create notifications array
            GetRecentNotifications(MemberNo, NotificationsArray);
            DataJson.Add('recent_notifications', NotificationsArray);

            // Add savings accounts array
            GetDashboardSavingsAccounts(MemberNo, SavingsAccountsArray);
            DataJson.Add('savings_accounts', SavingsAccountsArray);

            // Add loan accounts array
            GetDashboardLoanAccounts(MemberNo, LoanAccountsArray);
            DataJson.Add('loan_accounts', LoanAccountsArray);

            // Add savings against dividends chart data
            GetSavingsDividendsChartData(MemberNo, SavingsDividendsChartArray);
            DataJson.Add('savings_dividends_chart', SavingsDividendsChartArray);

            GetLoanQualificationDetails(MemberNo, LoanQualificationArray);
            DataJson.Add('loan_qualification_details', LoanQualificationArray);


            // Add data to response
            ResponseJson.Add(Data, DataJson);
        end;
    end;






    local procedure GetDashboardSavingsAccounts(MemberNo: Code[20]; var SavingsAccountsArray: JsonArray)
    var
        SavingsAccounts: Record "Savings Accounts";
        ProductSetup: Record "Product Setup";
        AccountJson: JsonObject;
        MonthlyContribution: Decimal;
        InterestRate: Decimal;
    begin
        // Get savings accounts from the Savings Accounts table
        SavingsAccounts.Reset();
        SavingsAccounts.SetRange("Member No.", MemberNo);
        SavingsAccounts.SetFilter("Monthly Contribution", '>0');
        SavingsAccounts.SetFilter("Product Category", '<>%1', SavingsAccounts."Product Category"::"Registration Fee");
        if SavingsAccounts.FindSet() then begin
            repeat
                // Calculate balance for the account
                SavingsAccounts.CalcFields("Balance (LCY)");

                // Get product setup details for interest rate
                InterestRate := 0;
                if ProductSetup.Get(SavingsAccounts."Product Type") then
                    InterestRate := ProductSetup."Interest Rate (Max.)";

                // You could calculate this from Savings Ledger Entry records for more accuracy

                // Create account JSON object
                Clear(AccountJson);
                AccountJson.Add('account_no', SavingsAccounts."No.");
                AccountJson.Add('account_name', SavingsAccounts."Product Name");
                AccountJson.Add('account_type', Format(SavingsAccounts."Product Category"));
                AccountJson.Add('monthly_contribution', SavingsAccounts."Monthly Contribution");
                AccountJson.Add('current_balance', SavingsAccounts."Balance (LCY)");
                AccountJson.Add('interest_rate', InterestRate);
                AccountJson.Add('status', Format(SavingsAccounts.Status));

                // Add to array
                SavingsAccountsArray.Add(AccountJson);
            until SavingsAccounts.Next() = 0;
        end;

    end;

    local procedure GetSavingsDividendsChartData(MemberNo: Code[20]; var ChartArray: JsonArray)
    var
        DivProg: Record "Dividends Progression";
        ChartJson: JsonObject;
        CurrentYear: Integer;
        ChartYear: Integer;
        YearStartDate: Date;
        YearEndDate: Date;
        TotalSavings: Decimal;
        DividendAmount: Decimal;
    begin
        CurrentYear := Date2DMY(Today, 3);
        TotalSavings := SkyMbanking.GetAccountBalance(Legacy.GetDepositAccounts(MemberNo));

        for ChartYear := CurrentYear - 4 to CurrentYear do begin
            YearStartDate := DMY2Date(1, 1, ChartYear);
            YearEndDate := DMY2Date(31, 12, ChartYear);
            DividendAmount := 0;

            DivProg.Reset();
            DivProg.SetRange("Member No", MemberNo);
            DivProg.SetRange("Processing Date", YearStartDate, YearEndDate);
            if DivProg.FindFirst() then begin
                DivProg.CalcSums("Net Dividends");
                DividendAmount := DivProg."Net Dividends";
            end;

            Clear(ChartJson);
            ChartJson.Add('label', Format(ChartYear));
            ChartJson.Add('year', ChartYear);
            ChartJson.Add('savings', TotalSavings);
            ChartJson.Add('dividends', DividendAmount);
            ChartArray.Add(ChartJson);
        end;
    end;

    local procedure GetDashboardLoanAccounts(MemberNo: Code[20]; var LoanAccountsArray: JsonArray)
    var
        Loans: Record Loans;
        LoanRepaySchedule: Record "Loan Repayment Schedule";
        ProductSetup: Record "Product Setup";
        AccountJson: JsonObject;
        NextDueDate: Date;
        ArrearsAmount: Decimal;
        ArrearsMonths: Integer;
        MonthlyRepayment: Decimal;
        InterestRate: Decimal;
        LoanStatus: Text;
        GracePeriod: DateFormula;
    begin
        // Get loan accounts from the Loans table
        Loans.Reset();
        Loans.SetRange("Member No.", MemberNo);
        Loans.SetFilter("Outstanding Principal", '>0');
        if Loans.FindSet() then begin
            repeat
                // Calculate fields for the loan
                Loans.CalcFields("Total Outstanding Balance");

                // Get product setup details for interest rate
                InterestRate := Loans."Annual Interest %";
                if InterestRate <= 0 then
                    if ProductSetup.Get(Loans."Loan Product Type") then
                        InterestRate := ProductSetup."Interest Rate (Max.)";

                // Determine next due date and monthly payment
                NextDueDate := Loans."Repayment Start Date";
                MonthlyRepayment := Loans."Repayment";

                // Get next due date from repayment schedule
                LoanRepaySchedule.Reset();
                LoanRepaySchedule.SetRange("Loan No.", Loans."Loan No.");
                LoanRepaySchedule.SetFilter("Repayment Date", '>=%1', Today);
                if LoanRepaySchedule.FindFirst() then begin
                    NextDueDate := LoanRepaySchedule."Repayment Date";
                    if LoanRepaySchedule."Monthly Repayment" > 0 then
                        MonthlyRepayment := LoanRepaySchedule."Monthly Repayment";
                end;


                // Calculate arrears (simplified calculation)
                ArrearsAmount := 0;
                ArrearsMonths := 0;

                SaccoActivity.GetDefaultedAmount(Loans."Loan No.", Today, ExpAmt, AmtPaid, DefAmt, DaysDef, ArrearsDate, true, GracePeriod);
                ArrearsAmount := DefAmt;
                ArrearsMonths := Round(DaysDef / 30, 1, '=');


                // Determine loan status
                if ArrearsAmount > 0 then
                    LoanStatus := 'OVERDUE'
                else
                    LoanStatus := 'ACTIVE';

                // Create loan JSON object
                Clear(AccountJson);
                AccountJson.Add('loan_no', Loans."Loan No.");
                AccountJson.Add('loan_name', Loans."Loan Product Type Name");
                AccountJson.Add('loan_type', Loans."Loan Product Type");

                AccountJson.Add('outstanding_balance', Loans."Total Outstanding Balance");
                AccountJson.Add('monthly_repayment', MonthlyRepayment);
                AccountJson.Add('interest_rate', InterestRate);
                AccountJson.Add('arrears_amount', ArrearsAmount);
                AccountJson.Add('arrears_months', ArrearsMonths);
                AccountJson.Add('next_due_date', Format(NextDueDate));
                AccountJson.Add('status', LoanStatus);

                // Add to array
                LoanAccountsArray.Add(AccountJson);
            until Loans.Next() = 0;
        end;

        /*   // If no loans found, add sample data for demonstration
          if LoanAccountsArray.Count = 0 then begin
              // Personal Loan
              Clear(AccountJson);
              AccountJson.Add('loan_no', 'LN001234567');
              AccountJson.Add('loan_name', 'Personal Loan');
              AccountJson.Add('loan_type', 'PERSONAL');
              AccountJson.Add('outstanding_balance', 150000.00);
              AccountJson.Add('monthly_repayment', 7500.00);
              AccountJson.Add('interest_rate', 12.0);
              AccountJson.Add('arrears_amount', 0.00);
              AccountJson.Add('arrears_months', 0);
              AccountJson.Add('next_due_date', '2025-02-01');
              AccountJson.Add('status', 'ACTIVE');
              LoanAccountsArray.Add(AccountJson);

              // Emergency Loan
              Clear(AccountJson);
              AccountJson.Add('loan_no', 'LN001234568');
              AccountJson.Add('loan_name', 'Emergency Loan');
              AccountJson.Add('loan_type', 'EMERGENCY');
              AccountJson.Add('outstanding_balance', 50000.00);
              AccountJson.Add('monthly_repayment', 2500.00);
              AccountJson.Add('interest_rate', 10.0);
              AccountJson.Add('arrears_amount', 5000.00);
              AccountJson.Add('arrears_months', 2);
              AccountJson.Add('next_due_date', '2025-01-15');
              AccountJson.Add('status', 'OVERDUE');
              LoanAccountsArray.Add(AccountJson);
          end;
      */
    end;


    local procedure GetLoanQualificationDetails(MemberNo: Code[20]; var LoanQualificationArray: JsonArray)
    var
        LoanProducts: Record "Product Setup";
        SavingsAccount: Record "Savings Accounts";
        Loans: Record Loans;
        MAct: Codeunit "Member Activities";
        Legacy: Codeunit Legacy;
        LoanQualificationJson: JsonObject;
        SkipLoan: Boolean;
        Deposits: Decimal;
        QualifiedAmount: Decimal;
    begin
        LoanProducts.Reset;
        LoanProducts.SetRange("Product Class", LoanProducts."Product Class"::Credit);
        if LoanProducts.FindFirst() then begin
            repeat
                SkipLoan := false;
                Deposits := 0;
                QualifiedAmount := 0;
                if (LoanProducts."Product ID" = 'D306') then
                    SkipLoan := true;
                if (LoanProducts."Product ID" = 'D312') then
                    SkipLoan := true;
                if (LoanProducts."Product ID" = 'D319') then
                    SkipLoan := true;

                if not SkipLoan then begin
                    Clear(LoanQualificationJson);
                    LoanQualificationJson.Add('loan_product_code', LoanProducts."Product ID");
                    if LoanProducts."Product ID" = 'D301' then
                        LoanQualificationJson.Add('loan_product', 'Normal/Refinance Loan')
                    else
                        LoanQualificationJson.Add('loan_product', LoanProducts.Description);

                    LoanQualificationJson.Add('loan_multiplier', LoanProducts."Deposit Multiplier");

                    if LoanProducts."Appraisal Product" <> '' then begin
                        SavingsAccount.Reset;
                        SavingsAccount.SetRange("Member No.", MemberNo);
                        SavingsAccount.SetRange("Product Type", LoanProducts."Appraisal Product");
                        if SavingsAccount.FindFirst() then begin
                            Deposits := MAct.GetAccountBalance(SavingsAccount."No.");
                            QualifiedAmount := Deposits * (LoanProducts."Deposit Multiplier");
                        end else begin
                            Deposits := 0;
                            QualifiedAmount := 0;
                        end;
                    end else begin
                        Deposits := MAct.GetAccountBalance(Legacy.GetDepositAccounts(MemberNo));
                        QualifiedAmount := (Deposits * LoanProducts."Deposit Multiplier") - (Legacy.GetTotalBosaLoanPrincipalBalance(MemberNo) + Legacy.GetTotalFosaLoanPrincipalBalance(MemberNo));
                    end;

                    Loans.Reset;
                    Loans.SetRange("Member No.", MemberNo);
                    Loans.SetRange("Loan Product Type", LoanProducts."Product ID");
                    Loans.SetFilter("Outstanding Principal", '>0');
                    if Loans.FindFirst() then
                        LoanQualificationJson.Add('has_existing_loan', true)
                    else
                        LoanQualificationJson.Add('has_existing_loan', false);

                    // Special handling for product D308
                    if LoanProducts."Product ID" = 'D308' then begin
                        QualifiedAmount := MAct.GetAccountBalance(Legacy.GetDepositAccounts(MemberNo));
                    end;

                    // Ensure qualified amount is not negative
                    if QualifiedAmount < 0 then
                        QualifiedAmount := 0;

                    // Apply maximum loan amount limit
                    if QualifiedAmount > LoanProducts."Maximum Loan Amount" then
                        QualifiedAmount := LoanProducts."Maximum Loan Amount";

                    LoanQualificationJson.Add('deposits', Deposits);
                    LoanQualificationJson.Add('qualified_amount', QualifiedAmount);
                    LoanQualificationJson.Add('maximum_loan_amount', LoanProducts."Maximum Loan Amount");
                    LoanQualificationJson.Add('last_update', Format(Today()));

                    LoanQualificationArray.Add(LoanQualificationJson);
                end;
            until LoanProducts.Next() = 0;
        end;
    end;





    local procedure GetMemberFinancialData(MemberNo: Code[20]; var DataJson: JsonObject)
    var
        TotalSavings: Decimal;
        FosaSavings: Decimal;
        ActiveLoans: Integer;
        LoanBalance: Decimal;
        SharesValue: Decimal;
        SharesCount: Integer;
        SharePrice: Decimal;
        DividendsYTD: Decimal;
        DividendRate: Decimal;
        Loans: Record Loans;
        DivProg: Record "Dividends Progression";
        LoanProduct: Record "Product Setup";
    begin
        // In a real implementation, we would query the database to get this data
        // For now, we'll use sample data

        // TODO: Replace with actual database queries
        TotalSavings := SkyMbanking.GetAccountBalance(Legacy.GetDepositAccounts(MemberNo));
        FosaSavings := SkyMbanking.GetAccountBalance(Legacy.GetOrdinaryAccount(MemberNo));
        Loans.SetRange("Member No.", MemberNo);
        Loans.SetFilter("Outstanding Principal", '<>0');
        if Loans.FindFirst() then begin
            ActiveLoans := Loans.Count();
            repeat
                Loans.CalcFields("Total Outstanding Balance");
                LoanBalance += Loans."Total Outstanding Balance";
            until Loans.Next() = 0;
        end;
        SharesValue := SkyMbanking.GetAccountBalance(Legacy.GetShareCapitalAccount(MemberNo));
        SharesCount := 0;
        SharePrice := 0.00;

        DivProg.Reset();
        DivProg.Reset();
        DivProg.SetRange("Member No", MemberNo);
        // Only include dividends processed in the current year
        DivProg.SetRange("Processing Date", DMY2Date(1, 1, Date2DMY(Today, 3)), DMY2Date(31, 12, Date2DMY(Today, 3)));
        if DivProg.FindFirst() then begin
            DivProg.CalcSums("Net Dividends");
            DividendsYTD := DivProg."Net Dividends";
            // DividendRate := DivProg."Dividend Rate";
        end else begin
            DividendsYTD := 0;
            DividendRate := 0;
        end;




        // Add financial data to JSON
        DataJson.Add('total_savings', TotalSavings);
        DataJson.Add('fosa_savings', FosaSavings);

        DataJson.Add('active_loans', ActiveLoans);
        DataJson.Add('loan_balance', LoanBalance);
        DataJson.Add('shares_value', SharesValue);
        DataJson.Add('shares_count', SharesCount);
        DataJson.Add('share_price', SharePrice);
        DataJson.Add('dividends_ytd', DividendsYTD);
        DataJson.Add('dividend_rate', DividendRate);
        LoanProduct.Reset();
        LoanProduct.SetCurrentKey("Deposit Multiplier");
        LoanProduct.SetRange("Default Portal Mult. Product", true);
        LoanProduct.SetRange("Product Class", LoanProduct."Product Class"::Credit);
        LoanProduct.FindLast();
        DataJson.Add('max_credit_limit', GetMaximumCredit(LoanProduct, MemberNo));
    end;


    local procedure GetMaximumCredit(LoanProduct: Record "Product Setup"; MemberNo: COde[20]) MaxCredit: Decimal;
    var
        Loans: Record Loans;
        Legacy: Codeunit Legacy;
        AccountNo: Code[20];
        Sky: Codeunit "Sky MBanking";
        Bal: Decimal;
        LRec: Record Loans;
        LProduct: Record "Product Setup";
        LSecurity: Record "Loan Security";
        CommittedDep: Decimal;
    begin
        MaxCredit := 0;
        CommittedDep := 0;

        AccountNo := Legacy.GetDepositAccounts(MemberNo);
        Bal := Sky.GetAccountBalance(AccountNo);


        LRec.Reset;
        LRec.SetRange("Member No.", MemberNo);
        LRec.SetFilter("Outstanding Principal", '>0');
        if LRec.Find('-') then begin
            repeat

                LProduct.Get(LRec."Loan Product Type");
                if not LProduct."Exempt Portal Eligibility" then begin

                    LRec.CalcFields("Outstanding Principal");

                    LSecurity.Reset();
                    LSecurity.SetRange("Loan No.", LRec."Loan No.");
                    LSecurity.SetFilter("Member No", LRec."Member No.");
                    LSecurity.SetRange("Self Guarantee", true);
                    if (LSecurity.FindFirst()) and (LRec."Loan Product Type" <> 'L30') then
                        CommittedDep += LRec."Outstanding Principal"
                    else begin

                        if LProduct."Deposit Multiplier" > 0 then
                            CommittedDep += ROUND(LRec."Outstanding Principal" / LProduct."Deposit Multiplier", 0.01, '>')
                    end;

                end;
            until LRec.Next = 0;
        end;

        //Message('Bal %1 CommittedDep %2', Bal, CommittedDep);
        MaxCredit := Bal - CommittedDep;

        if MaxCredit > 0 then
            if LoanProduct."Deposit Multiplier" > 0 then
                MaxCredit := MaxCredit * LoanProduct."Deposit Multiplier";




    end;


    local procedure GetMemberAccounts(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        DivProg: Record "Dividends Progression";
        SavingsStandingOrdersArray: JsonArray;
        LoanStandingOrdersArray: JsonArray;
        DataJson: JsonObject;
        SavingsArray: JsonArray;
        LoansArray: JsonArray;
        SharesArray: JsonArray;
        DividendsArray: JsonArray;
        FixedDepositArray: JsonArray;
        SavingsProductsArray: JsonArray;
        AvailableSavingsProductTypesArray: JsonArray;
        AccountJson: JsonObject;
        ShareJson: JsonObject;
        DividendJson: JsonObject;
        MemberId: Text;
        MemberNo: Code[20];
        SessionId: Text;
        Username: Text;
        LastDueDate: Date;
        MonthlyPayment: Decimal;
        ShareCapitalAccount: Code[20];
        SharesValue: Decimal;
        SharesCount: Integer;
        SharePrice: Decimal;
        LoanSchedule: Record "Loan Repayment Schedule";
        DividendsYTD: Decimal;
        DividendRate: Decimal;
    begin
        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;


        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if PortalAuth.FindFirst() then begin
            // Get Member No from Portal Auth if it exists
            MemberNo := PortalAuth."Member No.";


            // If we have a Member ID but no Member No, try to find Member No
            if not Members.Get(MemberNo) then begin
                SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
                exit(ResponseJson);
            end;

            // Initialize response
            SetResponseStatus(ResponseJson, 'success', 'Account Data Retrieved', 'Account data retrieved successfully');
            ResponseJson.Add('timestamp', Format(CurrentDateTime));

            // Create data object
            DataJson.Add('member_id', MemberNo);

            // Get Savings Accounts
            SavingsAccounts.Reset();
            SavingsAccounts.SetRange("Member No.", MemberNo);
            SavingsAccounts.SetFilter("Product Category", '<>%1', SavingsAccounts."Product Category"::"Registration Fee");
            if SavingsAccounts.FindSet() then begin
                repeat
                    // Calculate balance for the account
                    SavingsAccounts.CalcFields("Balance (LCY)");

                    // Create account JSON object
                    Clear(AccountJson);
                    AccountJson.Add('name', SavingsAccounts."Product Name");
                    AccountJson.Add('balance', SavingsAccounts."Balance (LCY)");
                    AccountJson.Add('account_no', SavingsAccounts."No.");
                    AccountJson.Add('status', Format(SavingsAccounts.Status));
                    AccountJson.Add('interest_rate', ''); // Default interest rate as actual field may vary
                    // Add to array
                    SavingsArray.Add(AccountJson);
                until SavingsAccounts.Next() = 0;
            end;
            DivProg.Reset();
            DivProg.Reset();
            DivProg.SetRange("Member No", MemberNo);
            // Only include dividends processed in the current year
            DivProg.SetRange("Processing Date", DMY2Date(1, 1, Date2DMY(Today, 3)), DMY2Date(31, 12, Date2DMY(Today, 3)));
            if DivProg.FindFirst() then begin
                DivProg.CalcSums("Net Dividends");
                DividendsYTD := DivProg."Net Dividends";
                // DividendRate := DivProg."Dividend Rate";
            end else begin
                DividendsYTD := 0;
                DividendRate := 0;
            end;
            DataJson.Add('dividends_ytd', DividendsYTD);
            DataJson.Add('savings_accounts', SavingsArray);

            // Get Loan Accounts
            Loans.Reset();
            Loans.SetRange("Member No.", MemberNo);
            Loans.SetFilter("Outstanding Principal", '>0');
            if Loans.FindSet() then begin
                repeat
                    // Calculate balance for the loan
                    Loans.CalcFields("Total Outstanding Balance");

                    // Determine next due date and monthly payment
                    LastDueDate := Loans."Repayment Start Date"; // Default to next month

                    LoanSchedule.Reset();
                    LoanSchedule.SetRange("Loan No.", Loans."Loan No.");
                    LoanSchedule.SetFilter("Repayment Date", '<= %1', Today);
                    if LoanSchedule.FindLast() then
                        LastDueDate := LoanSchedule."Repayment Date";

                    if LastDueDate < CalcDate('<-CM>', Today) then
                        LastDueDate := CalcDate('<CM>', Today);

                    MonthlyPayment := Loans."Repayment"; // Using Repayment field instead of Installment Amount

                    // Create loan JSON object
                    Clear(AccountJson);
                    AccountJson.Add('loan_no', Loans."Loan No."); // Using Loan No as name since Product Name field isn't available
                    AccountJson.Add('name', Loans."Loan Product Type Name"); // Using Loan No as name since Product Name field isn't available
                    AccountJson.Add('outstanding_balance', Loans."Total Outstanding Balance");
                    AccountJson.Add('account_no', Loans."Loan No.");
                    AccountJson.Add('status', Format(Loans.Status)); // Using Status field instead of Loan Status
                    AccountJson.Add('monthly_payment', MonthlyPayment);
                    AccountJson.Add('next_due_date', Format(LastDueDate));

                    // Add to array
                    LoansArray.Add(AccountJson);
                until Loans.Next() = 0;
            end;
            DataJson.Add('loan_accounts', LoansArray);

            // Get Share Holdings
            ShareCapitalAccount := Legacy.GetShareCapitalAccount(MemberNo);
            SharesValue := SkyMbanking.GetAccountBalance(ShareCapitalAccount);

            // Calculate shares count based on share price
            SharePrice := 0; // Default share price if not defined elsewhere
            SharesCount := 0;
            if SharePrice > 0 then
                SharesCount := Round(SharesValue / SharePrice, 1);

            // Create shares JSON
            Clear(ShareJson);
            ShareJson.Add('name', 'Ordinary Shares');
            ShareJson.Add('value', SharesValue);
            ShareJson.Add('number_of_shares', SharesCount);
            ShareJson.Add('status', 'Active');
            ShareJson.Add('dividend_rate', ''); // Default or last year's rate

            // Add to array
            SharesArray.Add(ShareJson);
            DataJson.Add('share_holdings', SharesArray);

            // Get Dividend History
            DividendsArray := GetDividendHistory(MemberNo);
            DataJson.Add('dividend_history', DividendsArray);


            // Add Fixed Deposit Accounts
            GetFixedDepositAccounts(MemberNo, FixedDepositArray);
            DataJson.Add('fixed_deposit_accounts', FixedDepositArray);

            // Add Savings Products
            GetSavingsProducts(MemberNo, SavingsProductsArray);
            DataJson.Add('available_savings_product_types', SavingsProductsArray);

            // Add Available Savings Product Types
            GetAvailableSavingsProductTypes(AvailableSavingsProductTypesArray);
            DataJson.Add('savings_products', AvailableSavingsProductTypesArray);


            // Add Savings Standing Orders
            GetSavingsStandingOrders(MemberNo, SavingsStandingOrdersArray);
            DataJson.Add('savings_standing_orders', SavingsStandingOrdersArray);

            // Add Loan Standing Orders
            GetLoanStandingOrders(MemberNo, LoanStandingOrdersArray);
            DataJson.Add('loan_standing_orders', LoanStandingOrdersArray);



            // Add data to response
            ResponseJson.Add(Data, DataJson);
        end;
    end;




    local procedure GetFixedDepositAccounts(MemberNo: Code[20]; var FixedDepositArray: JsonArray)
    var
        FixedDepositAccounts: Record "Fixed Deposit Accounts";
        FDTypes: Record "FD Types";
        AccountJson: JsonObject;
        PrincipalAmount: Decimal;
        CurrentValue: Decimal;
        InterestEarned: Decimal;
        TermMonths: Integer;
        StartDate: Date;
        MaturityDate: Date;
        StatusText: Text;
        AutoRollover: Boolean;
        InterestRate: Decimal;
        MaturityInstructions: Text;
    begin
        // Get fixed deposit accounts from Fixed Deposit Accounts table
        FixedDepositAccounts.Reset();
        FixedDepositAccounts.SetRange("Member No.", MemberNo);
        if FixedDepositAccounts.FindSet() then begin
            repeat
                FixedDepositAccounts.CalcFields("Fixed Account Balance", "Accrued Interest", "Untransfered Interest");

                // Get FD type details for term and other information
                TermMonths := FixedDepositAccounts.Months;
                if FDTypes.Get(FixedDepositAccounts."FD Type") then begin
                    if TermMonths = 0 then // Fallback if Months field is not set
                        TermMonths := FDTypes.Months;
                end;

                if TermMonths = 0 then
                    TermMonths := 12; // Default term

                // Get values from Fixed Deposit Accounts record
                PrincipalAmount := FixedDepositAccounts."FD Amount";
                CurrentValue := FixedDepositAccounts."Fixed Account Balance";
                InterestEarned := FixedDepositAccounts."Accrued Interest" + FixedDepositAccounts."Untransfered Interest";
                StartDate := FixedDepositAccounts."FD Start Date";
                MaturityDate := FixedDepositAccounts."FD Maturity Date";

                // Get interest rate (use negotiated rate if available, otherwise use FD annual rate)
                if FixedDepositAccounts."Negotiated Interest %" > 0 then
                    InterestRate := FixedDepositAccounts."Negotiated Interest %"
                else
                    InterestRate := FixedDepositAccounts."FD Annual Interest %";

                // Determine status based on FD Status and dates
                case FixedDepositAccounts."FD Status" of
                    FixedDepositAccounts."FD Status"::Active:
                        if Today > MaturityDate then
                            StatusText := 'MATURED'
                        else
                            StatusText := 'ACTIVE';
                    FixedDepositAccounts."FD Status"::Matured:
                        StatusText := 'MATURED';
                    FixedDepositAccounts."FD Status"::Closed:
                        StatusText := 'CLOSED';
                    else
                        if (FixedDepositAccounts."Approval Status" = FixedDepositAccounts."Approval Status"::Approved) and
                           not FixedDepositAccounts.Posted then
                            StatusText := 'PENDING'
                        else if FixedDepositAccounts."Approval Status" = FixedDepositAccounts."Approval Status"::Rejected then
                            StatusText := 'REJECTED'
                        else
                            StatusText := 'PENDING APPROVAL';
                end;

                // Determine auto rollover based on maturity instructions
                case FixedDepositAccounts."FD Maturity Instructions" of
                    FixedDepositAccounts."FD Maturity Instructions"::"Transfer Interest & Renew Principal",
                    FixedDepositAccounts."FD Maturity Instructions"::"Renew Both Principal & Interest":
                        AutoRollover := true;
                    else
                        AutoRollover := false;
                end;

                // Get maturity instructions text
                case FixedDepositAccounts."FD Maturity Instructions" of
                    FixedDepositAccounts."FD Maturity Instructions"::" ":
                        MaturityInstructions := 'Not Set';
                    FixedDepositAccounts."FD Maturity Instructions"::"Transfer all to Savings":
                        MaturityInstructions := 'Transfer all to Savings';
                    FixedDepositAccounts."FD Maturity Instructions"::"Transfer Interest & Renew Principal":
                        MaturityInstructions := 'Transfer Interest & Renew Principal';
                    FixedDepositAccounts."FD Maturity Instructions"::"Renew Both Principal & Interest":
                        MaturityInstructions := 'Renew Both Principal & Interest';
                end;

                Clear(AccountJson);
                AccountJson.Add('name', StrSubstNo('%1-Month Fixed Deposit', TermMonths));
                AccountJson.Add('account_no', FixedDepositAccounts."No.");
                AccountJson.Add('fixed_account_no', FixedDepositAccounts."Fixed Account No.");
                AccountJson.Add('fd_type', FixedDepositAccounts."FD Type");
                AccountJson.Add('principal_amount', PrincipalAmount);
                AccountJson.Add('current_value', CurrentValue);
                AccountJson.Add('interest_rate', Format(InterestRate, 0, '<Precision,2>') + '% p.a.');
                AccountJson.Add('term_months', TermMonths);
                AccountJson.Add('start_date', Format(StartDate));
                AccountJson.Add('maturity_date', Format(MaturityDate));
                AccountJson.Add('status', StatusText);
                AccountJson.Add('account_type', 'fixed_deposit');
                AccountJson.Add('interest_earned', InterestEarned);
                AccountJson.Add('accrued_interest', FixedDepositAccounts."Accrued Interest");
                AccountJson.Add('untransfered_interest', FixedDepositAccounts."Untransfered Interest");
                AccountJson.Add('auto_rollover', AutoRollover);
                AccountJson.Add('maturity_instructions', MaturityInstructions);
                AccountJson.Add('payment_frequency', Format(FixedDepositAccounts."Payment Frequency"));
                AccountJson.Add('monthly_interest', FixedDepositAccounts."Monthly Interest");
                AccountJson.Add('total_expected_interest', FixedDepositAccounts."Total Expected Interest");
                AccountJson.Add('application_date', Format(FixedDepositAccounts."Application Date"));
                AccountJson.Add('approval_status', Format(FixedDepositAccounts."Approval Status"));
                AccountJson.Add('posted', FixedDepositAccounts.Posted);
                AccountJson.Add('exempt_withholding_tax', FixedDepositAccounts."Exempt W/Tax");

                FixedDepositArray.Add(AccountJson);
            until FixedDepositAccounts.Next() = 0;
        end;


    end;



    local procedure GetSavingsProducts(MemberNo: Code[20]; var SavingsProductsArray: JsonArray)
    var
        SavingsGoals: Record "Savings Goals";
        SavingsAccounts: Record "Savings Accounts";
        ProductSetup: Record "Product Setup";
        StandingOrder: Record "Standing Order Header";
        ProductJson: JsonObject;
        StandingOrderJson: JsonObject;
        TargetAmount: Decimal;
        CurrentBalance: Decimal;
        MonthlyContribution: Decimal;
        InitialContribution: Decimal;
        ProgressPercentage: Decimal;
        TargetDate: Date;
        StartDate: Date;
        Purpose: Text;
        StatusText: Text;
        InterestRate: Decimal;
        NextDebitDate: Date;
        StandingOrderEnabled: Boolean;
    begin
        // Get savings products from Savings Goals table
        SavingsGoals.Reset();
        SavingsGoals.SetRange("Member No.", MemberNo);
        if SavingsGoals.FindSet() then begin
            repeat
                // Get account details
                if SavingsAccounts.Get(SavingsGoals."Account No. ") then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    CurrentBalance := SavingsAccounts."Balance (LCY)";

                    // Get product setup for interest rate
                    if ProductSetup.Get(SavingsAccounts."Product Type") then
                        InterestRate := ProductSetup."Interest Rate (Max.)"
                    else
                        InterestRate := 8.5;
                end;

                TargetAmount := SavingsGoals."Target Balance";
                MonthlyContribution := SavingsAccounts."Monthly Contribution";
                InitialContribution := SavingsGoals."Starting Balance";

                // Calculate target date based on period months (if available)
                if SavingsGoals."Period (Months)" > 0 then
                    TargetDate := CalcDate(StrSubstNo('<+%1M>', SavingsGoals."Period (Months)"), SavingsGoals."Date Created")
                else
                    TargetDate := 0D;

                StartDate := SavingsGoals."Date Created";
                Purpose := SavingsGoals."Account Name"; // Using account name as purpose since no specific purpose field

                // Calculate progress
                if TargetAmount > 0 then
                    ProgressPercentage := Round((CurrentBalance / TargetAmount) * 100, 1)
                else
                    ProgressPercentage := 0;

                // Determine status
                case SavingsGoals.Status of
                    SavingsGoals.Status::Active:
                        if ProgressPercentage >= 100 then
                            StatusText := 'COMPLETED'
                        else
                            StatusText := 'ACTIVE';
                    SavingsGoals.Status::Achieved:
                        StatusText := 'COMPLETED';
                    SavingsGoals.Status::Cancelled:
                        StatusText := 'CANCELLED';
                    else
                        StatusText := 'INACTIVE';
                end;

                // Check for standing order
                StandingOrder.Reset();
                StandingOrder.SetRange("Source Account No.", Legacy.GetOrdinaryAccount(MemberNo));
                StandingOrder.SetFilter(Description, '*' + SavingsGoals."Account Name" + '*');
                StandingOrderEnabled := StandingOrder.FindFirst();

                if StandingOrderEnabled then
                    NextDebitDate := CalcDate('<+1M>', Today)
                else
                    NextDebitDate := 0D;

                Clear(ProductJson);
                ProductJson.Add('name', SavingsGoals."Account Name");
                ProductJson.Add('account_no', 'SP' + CopyStr(MemberNo, StrLen(MemberNo) - 5) + Format(SavingsGoals."Account No. "));
                ProductJson.Add('product_code', UpperCase(DelChr(SavingsGoals."Account Name", '=', ' ')) + '_SAVINGS');
                ProductJson.Add('target_amount', TargetAmount);
                ProductJson.Add('current_balance', CurrentBalance);
                ProductJson.Add('monthly_contribution', MonthlyContribution);
                ProductJson.Add('initial_contribution', InitialContribution);
                ProductJson.Add('progress_percentage', ProgressPercentage);

                // Handle target date formatting
                if TargetDate <> 0D then
                    ProductJson.Add('target_date', Format(TargetDate))
                else
                    ProductJson.Add('target_date', '');

                ProductJson.Add('start_date', Format(StartDate));
                ProductJson.Add('purpose', Purpose);
                ProductJson.Add('status', StatusText);
                ProductJson.Add('account_type', 'savings_product');
                ProductJson.Add('interest_rate', Format(InterestRate) + '% p.a.');

                // Add standing order details
                Clear(StandingOrderJson);
                StandingOrderJson.Add('enabled', StandingOrderEnabled);
                StandingOrderJson.Add('frequency', 'MONTHLY');
                StandingOrderJson.Add('amount', MonthlyContribution);
                if StandingOrderEnabled then
                    StandingOrderJson.Add('next_debit_date', Format(NextDebitDate))
                else
                    StandingOrderJson.Add('next_debit_date', '');

                ProductJson.Add('standing_order', StandingOrderJson);

                SavingsProductsArray.Add(ProductJson);
            until SavingsGoals.Next() = 0;
        end;


    end;

    local procedure GetAvailableSavingsProductTypes(var AvailableProductTypesArray: JsonArray)
    var
        ProductSetup: Record "Product Setup";
        ProductJson: JsonObject;
        FeaturesArray: JsonArray;
    begin
        // Get available savings product types from Product Setup
        ProductSetup.Reset();
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Savings);
        ProductSetup.SetRange("Available on Portal", true);
        ProductSetup.SetFilter("Product Category", '<>%1', ProductSetup."Product Category"::"Registration Fee");

        if ProductSetup.FindSet() then begin
            repeat
                Clear(ProductJson);
                Clear(FeaturesArray);

                ProductJson.Add('code', ProductSetup."Product ID");
                ProductJson.Add('name', ProductSetup."Description");
                ProductJson.Add('description', '');
                ProductJson.Add('icon', '');
                ProductJson.Add('minAmount', ProductSetup."Minimum Contribution");
                ProductJson.Add('interestRate', ProductSetup."Interest Rate (Max.)");

                // Add features based on product
                ProductJson.Add('features', FeaturesArray);

                AvailableProductTypesArray.Add(ProductJson);
            until ProductSetup.Next() = 0;
        end;

    end;













    local procedure GetDividendHistory(MemberNo: Code[20]) DividendsArray: JsonArray
    var
        DivProg: Record "Dividends Progression";
        DividendJson: JsonObject;
        CurrentYear: Integer;
        LastYear: Integer;
        Rate: Decimal;
        DividendAmount: Decimal;
        YearStartDate: Date;
        YearEndDate: Date;
    begin
        // Get current year and last year
        CurrentYear := Date2DMY(Today, 3);
        LastYear := CurrentYear - 1;

        // Add last year's dividend data if available
        YearStartDate := DMY2Date(1, 1, LastYear);
        YearEndDate := DMY2Date(31, 12, LastYear);

        DivProg.Reset();
        DivProg.SetRange("Member No", MemberNo);
        DivProg.SetRange("End Date", YearStartDate, YearEndDate);
        if DivProg.FindFirst() then begin
            DivProg.CalcSums("Net Dividends");
            DividendAmount := DivProg."Net Dividends";
            Rate := 0; // Default or get from configuration

            Clear(DividendJson);
            DividendJson.Add('year', LastYear);
            DividendJson.Add('rate', Format(Rate) + '%');
            DividendJson.Add('amount', DividendAmount);
            DividendsArray.Add(DividendJson);
        end;

        // Add previous year's dividend data
        YearStartDate := DMY2Date(1, 1, LastYear - 1);
        YearEndDate := DMY2Date(31, 12, LastYear - 1);

        DivProg.Reset();
        DivProg.SetRange("Member No", MemberNo);
        DivProg.SetRange("End Date", YearStartDate, YearEndDate);
        if DivProg.FindFirst() then begin
            DivProg.CalcSums("Net Dividends");
            DividendAmount := DivProg."Net Dividends";
            Rate := 0; // Default or get from configuration

            Clear(DividendJson);
            DividendJson.Add('year', LastYear - 1);
            DividendJson.Add('rate', Format(Rate) + '%');
            DividendJson.Add('amount', DividendAmount);
            DividendsArray.Add(DividendJson);
        end;
    end;

    local procedure GetMemberLoans(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        PortalWitness: Record "Portal Loan Witness";
        WitnessJson: JsonObject;
        Applicant: Record Members;
        WitnessesArray: JsonArray;
        LoansPending: Record "Portal Loans";
        DocumentJson: JsonObject;
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        Loans: Record Loans;
        LoanRepaySchedule: Record "Loan Repayment Schedule";
        DataJson: JsonObject;
        LoanProductsArray: JsonArray;
        LoanPurposeArray: JsonArray;
        LoanToGuaranteeArray: JsonArray;
        LoanPeriodArray: JsonArray;
        EligibilityChecksArray: JsonArray;
        LoanApplicationsArray: JsonArray;
        ActiveLoansArray: JsonArray;
        RepaymentHistoryArray: JsonArray;
        LoanSummaryJson: JsonObject;
        CalculatorJson: JsonObject;
        MemberId: Text;
        MemberNo: Code[20];
        SessionId: Text;
        Username: Text;
        TotalLoanBalance: Decimal;
        TotalMonthlyPayment: Decimal;
        InterestPaidYTD: Decimal;
        PrincipalPaidYTD: Decimal;
    begin
        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;


        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if PortalAuth.FindFirst() then begin
            // Get Member No from Portal Auth if it exists
            MemberNo := PortalAuth."Member No.";


            // If we have a Member ID but no Member No, try to find Member No
            if not Members.Get(MemberNo) then begin
                SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
                exit(ResponseJson);
            end;

            // Initialize response
            SetResponseStatus(ResponseJson, 'success', 'Loan Data Retrieved', 'Loan data retrieved successfully');
            ResponseJson.Add('timestamp', Format(CurrentDateTime));

            // Create data object
            DataJson.Add('member_id', MemberNo);

            // 1. Get Loan Products - loan products offered by the SACCO
            GetLoanProducts(LoanProductsArray, MemberNo);
            DataJson.Add('loan_products', LoanProductsArray);

            // 2. Get Eligibility Checks for the member
            GetMemberLoanEligibility(MemberNo, EligibilityChecksArray);
            DataJson.Add('eligibility_checks', EligibilityChecksArray);

            // 3. Get Loan Applications for the member
            GetMemberLoanApplications(MemberNo, LoanApplicationsArray);
            DataJson.Add('loan_applications', LoanApplicationsArray);

            // 4. Get Active Loans for the member
            GetMemberActiveLoans(MemberNo, ActiveLoansArray, TotalLoanBalance, TotalMonthlyPayment);
            DataJson.Add('active_loans', ActiveLoansArray);

            // 5. Get Loan Repayment History
            GetLoanRepaymentHistory(MemberNo, RepaymentHistoryArray, InterestPaidYTD, PrincipalPaidYTD);
            DataJson.Add('repayment_history', RepaymentHistoryArray);

            // 6. Build Loan Summary JSON
            LoanSummaryJson.Add('total_loan_balance', TotalLoanBalance);
            LoanSummaryJson.Add('total_monthly_payment', TotalMonthlyPayment);
            LoanSummaryJson.Add('interest_paid_ytd', InterestPaidYTD);
            LoanSummaryJson.Add('principal_paid_ytd', PrincipalPaidYTD);
            DataJson.Add('loan_summary', LoanSummaryJson);

            // 7. Build Calculator data with sample values
            DataJson.Add('calculator', CalculatorJson);

            // 8. Get Loan Products - loan products offered by the SACCO
            GetLoanPurpose(LoanPurposeArray);
            DataJson.Add('loan_purpose', LoanPurposeArray);


            // 9. Get Loan to Guarantee
            GetLoansToGuarantee(MemberNo, LoanToGuaranteeArray);
            DataJson.Add('loans_to_guarantee', LoanToGuaranteeArray);




            // Build witnesses section
            PortalWitness.Reset();
            PortalWitness.SetRange("Witness No.", MemberNo);
            PortalWitness.SetRange("Witness Approved", PortalWitness."Witness Approved"::Pending);
            if PortalWitness.FindSet() then begin
                repeat
                    Clear(WitnessJson);


                    LoansPending.Get(PortalWitness."Loan Application No.");

                    // Not already a guarantor, so eligible
                    Clear(WitnessJson);
                    WitnessJson.Add('application_id', LoansPending."Application No.");

                    // Get applicant info
                    if Applicant.Get(LoansPending."Member No.") then begin
                        WitnessJson.Add('applicant_name', Applicant.Name);
                        WitnessJson.Add('applicant_member_number', Applicant."No.");
                    end else begin
                        WitnessJson.Add('applicant_name', '');
                        WitnessJson.Add('applicant_member_number', LoansPending."Member No.");
                    end;

                    WitnessJson.Add('loan_type', LoansPending."Loan Name");
                    WitnessJson.Add('loan_amount', LoansPending."Requested Amount");
                    WitnessJson.Add('repayment_period', LoansPending."Loan Period");
                    WitnessJson.Add('application_date', Format(LoansPending."Date"));


                    WitnessesArray.Add(WitnessJson);
                until PortalWitness.Next() = 0;
            end;
            DataJson.Add('loans_to_witness', WitnessesArray);

            // Add data to response
            ResponseJson.Add(Data, DataJson);
        end;
    end;


    local procedure GetLoanProducts(var LoanProductsArray: JsonArray; MemberNo: code[20])
    var
        ProductSetup: Record "Product Setup";
        ProductDocuments: Record "Product Loan Documents";
        GeneralDocuments: Record "General Loan Documents";
        ProductJson: JsonObject;
        RequiredDocumentsArray: JsonArray;
        DocumentJson: JsonObject;
        AllowedFormatsArray: JsonArray;
    begin
        // Get loan products from Product Setup table where Product Class is Credit/Loan
        ProductSetup.Reset();
        ProductSetup.SetRange("Available on Portal", true);
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Credit);
        if ProductSetup.FindSet() then begin
            repeat
                Clear(ProductJson);
                Clear(RequiredDocumentsArray);

                ProductJson.Add('code', ProductSetup."Product ID");
                ProductJson.Add('name', ProductSetup."Description");
                ProductJson.Add('description', ProductSetup."Description");
                ProductJson.Add('interest_rate', (ProductSetup."Interest Rate (Max.)"));
                ProductJson.Add('max_amount', ProductSetup."Maximum Loan Amount");
                ProductJson.Add('max_period', ProductSetup."Default Installments");

                ProductJson.Add('max_credit', GetMaximumCredit(ProductSetup, MemberNo));
                // Get required documents based on product setup
                if ProductSetup."Mandatory Documents" = ProductSetup."Mandatory Documents"::General then begin
                    // Get general documents
                    GeneralDocuments.Reset();
                    GeneralDocuments.SetFilter(Description, '<>%1', '');
                    if GeneralDocuments.FindFirst() then begin
                        repeat
                            Clear(DocumentJson);
                            Clear(AllowedFormatsArray);

                            // Set allowed formats based on document type or use default
                            AllowedFormatsArray.Add('.pdf');
                            //AllowedFormatsArray.Add('.jpg');
                            //AllowedFormatsArray.Add('.jpeg');
                            //AllowedFormatsArray.Add('.png');

                            DocumentJson.Add('document_type', GeneralDocuments.Code);
                            DocumentJson.Add('display_name', GeneralDocuments.Description);
                            DocumentJson.Add('description', GeneralDocuments.Description);
                            DocumentJson.Add('required', true);
                            DocumentJson.Add('allowed_formats', AllowedFormatsArray);
                            DocumentJson.Add('max_size_mb', 5);
                            RequiredDocumentsArray.Add(DocumentJson);
                        until GeneralDocuments.Next() = 0;
                    end;
                end;

                if ProductSetup."Mandatory Documents" = ProductSetup."Mandatory Documents"::Specific then begin
                    // Get product-specific documents
                    ProductDocuments.Reset();
                    ProductDocuments.SetRange(Product, ProductSetup."Product ID");
                    ProductDocuments.SetFilter(Description, '<>%1', '');
                    if ProductDocuments.FindFirst() then begin
                        repeat
                            Clear(DocumentJson);
                            Clear(AllowedFormatsArray);

                            // Set allowed formats based on document type or use default
                            AllowedFormatsArray.Add('.pdf');
                            AllowedFormatsArray.Add('.jpg');
                            AllowedFormatsArray.Add('.jpeg');
                            AllowedFormatsArray.Add('.png');

                            DocumentJson.Add('document_type', ProductDocuments.Code);
                            DocumentJson.Add('display_name', ProductDocuments.Description);
                            DocumentJson.Add('description', ProductDocuments.Description);
                            DocumentJson.Add('required', true);
                            DocumentJson.Add('allowed_formats', AllowedFormatsArray);
                            DocumentJson.Add('max_size_mb', 5);
                            RequiredDocumentsArray.Add(DocumentJson);
                        until ProductDocuments.Next() = 0;
                    end;
                end;

                // Add the required documents array to the product
                ProductJson.Add('required_documents', RequiredDocumentsArray);

                LoanProductsArray.Add(ProductJson);
            until ProductSetup.Next() = 0;
        end;
    end;



    local procedure GetLoanPurpose(var LoanPurposeArray: JsonArray)
    var
        Purpose: Record "Sasra Sectorial Level 2";
        ProductJson: JsonObject;
    begin
        // Get loan products from Product Setup table where Product Class is Credit/Loan
        Purpose.Reset();
        if Purpose.FindSet() then begin
            repeat
                Clear(ProductJson);
                ProductJson.Add('id', Purpose."Sub-Sector Level 2 Code");
                ProductJson.Add('description', Purpose."Sub-Sector Level 2 Description");
                LoanPurposeArray.Add(ProductJson);
            until Purpose.Next() = 0;
        end;
    end;

    local procedure GetLoanPeriod(var LoanPeriodArray: JsonArray; Period: Integer)
    var
        Purpose: Record "Sasra Sectorial Level 2";
        ProductJson: JsonObject;
        j: Integer;
    begin
        // Get loan products from Product Setup table where Product Class is Credit/Loan
        for j := 1 to Period do begin
            Clear(ProductJson);
            ProductJson.Add('id', j);
            ProductJson.Add('value', j);
            LoanPeriodArray.Add(ProductJson);
        end;
    end;

    local procedure GetMemberLoanEligibility(MemberNo: Code[20]; var EligibilityChecksArray: JsonArray)
    var
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        SaccoLoans: Record SaccoLoans;
        EligibilityJson: JsonObject;
        HasDefaulted: Boolean;
        MembershipDuration: Integer;
        RegularSavings: Boolean;
        HasGuarantors: Boolean;
    begin
        // Check 1: Member for 6+ months
        MembershipDuration := 0;
        if Members.Get(MemberNo) then
            if Members."Registration Date" <> 0D then
                MembershipDuration := ((DATE2DMY(TODAY, 3) - DATE2DMY(Members."Registration Date", 3)) * 12) +
                                     (DATE2DMY(TODAY, 2) - DATE2DMY(Members."Registration Date", 2));

        // Check 2: Regular savings contributions
        RegularSavings := false;
        SavingsAccounts.Reset();
        SavingsAccounts.SetRange("Member No.", MemberNo);
        if SavingsAccounts.FindSet() then
            RegularSavings := true;

        // Check 3: No loan defaults
        HasDefaulted := false;
        SaccoLoans.Reset();
        SaccoLoans.SetRange("Member No.", MemberNo);
        //SaccoLoans.setrange(Posted, true);
        // Since we can't check for defaulted status directly, we'll check for overdue loans
        if SaccoLoans.FindSet() then begin
            if SaccoLoans."Defaulter SMS Date" <> 0D then
                HasDefaulted := true;
        end;

        // Check 4: Guarantors required (2)
        HasGuarantors := false;

        // Add eligibility checks to array
        Clear(EligibilityJson);
        EligibilityJson.Add('text', 'Member for 6+ months');
        EligibilityJson.Add('is_eligible', MembershipDuration >= 6);
        EligibilityChecksArray.Add(EligibilityJson);

        Clear(EligibilityJson);
        EligibilityJson.Add('text', 'Regular savings contributions');
        EligibilityJson.Add('is_eligible', RegularSavings);
        EligibilityChecksArray.Add(EligibilityJson);

        Clear(EligibilityJson);
        EligibilityJson.Add('text', 'No loan defaults');
        EligibilityJson.Add('is_eligible', not HasDefaulted);
        EligibilityChecksArray.Add(EligibilityJson);

        Clear(EligibilityJson);
        EligibilityJson.Add('text', 'Guarantors required (2)');
        EligibilityJson.Add('is_eligible', HasGuarantors);
        EligibilityChecksArray.Add(EligibilityJson);
    end;

    local procedure GetMemberLoanApplications(MemberNo: Code[20]; var LoanApplicationsArray: JsonArray)
    var
        SaccoLoans: Record Loans;
        PortalLoans: Record "Portal Loans";
        ApplicationJson: JsonObject;
        Progress: Integer;
    begin
        // Check for loan applications in the SaccoLoans table
        SaccoLoans.Reset();
        SaccoLoans.SetRange("Member No.", MemberNo);
        SaccoLoans.SetRange("Loan Calculator", false);
        SaccoLoans.SetRange(Posted, false);

        if SaccoLoans.FindSet() then begin
            repeat
                Clear(ApplicationJson);
                ApplicationJson.Add('application_id', SaccoLoans."Loan No.");
                ApplicationJson.Add('loan_type', SaccoLoans."Loan Product Type Name");
                ApplicationJson.Add('amount_requested', SaccoLoans."Requested Amount");

                if SaccoLoans."Approved Amount" > 0 then
                    ApplicationJson.Add('amount_approved', SaccoLoans."Approved Amount");

                ApplicationJson.Add('repayment_period', SaccoLoans.Installments);
                ApplicationJson.Add('application_date', Format(SaccoLoans."Application Date"));


                ApplicationJson.Add('status', Format(SaccoLoans."Status"));
                // Calculate status and progress based on issue date
                if SaccoLoans.Status = SaccoLoans.Status::Approved then begin
                    Progress := 100;
                end else if SaccoLoans.Status = SaccoLoans.Status::Pending then begin
                    Progress := 80;
                end else if SaccoLoans.Status = SaccoLoans.Status::Open then begin
                    Progress := 30;
                end else if SaccoLoans.Status = SaccoLoans.Status::Rejected then begin
                    Progress := 30;
                end
                else begin
                    Progress := 0; // Default for other statuses
                end;
                ApplicationJson.Add('progress', Progress);
                LoanApplicationsArray.Add(ApplicationJson);
            until SaccoLoans.Next() = 0;
        end;



        // Check for loan applications in the SaccoLoans table
        PortalLoans.Reset();
        PortalLoans.SetRange("Member No.", MemberNo);
        PortalLoans.SetRange(Posted, false);
        PortalLoans.SetFilter("Loan No.", '%1', '');
        PortalLoans.SetFilter(Status, '<>%1', PortalLoans.Status::Failed);
        if PortalLoans.FindSet() then begin
            repeat
                Clear(ApplicationJson);
                ApplicationJson.Add('application_id', PortalLoans."Application No.");
                ApplicationJson.Add('loan_type', PortalLoans."Loan Name");
                ApplicationJson.Add('amount_requested', PortalLoans."Requested Amount");

                if PortalLoans."Approved Amount" > 0 then
                    ApplicationJson.Add('amount_approved', PortalLoans."Approved Amount");

                ApplicationJson.Add('repayment_period', PortalLoans."Loan Period");
                ApplicationJson.Add('application_date', Format(PortalLoans."Date"));


                ApplicationJson.Add('status', Format(PortalLoans."Status"));
                // Calculate status and progress based on issue date
                if PortalLoans.Status = PortalLoans.Status::Approved then begin
                    Progress := 100;
                end else if PortalLoans.Status = PortalLoans.Status::Appraisal then begin
                    Progress := 80;
                end else if PortalLoans.Status = PortalLoans.Status::Pending then begin
                    Progress := 50;
                end else if PortalLoans.Status = PortalLoans.Status::Open then begin
                    Progress := 30;
                end
                else begin
                    Progress := 0; // Default for other statuses
                end;
                ApplicationJson.Add('progress', Progress);
                LoanApplicationsArray.Add(ApplicationJson);
            until PortalLoans.Next() = 0;
        end;

    end;

    local procedure GetMemberActiveLoans(MemberNo: Code[20]; var ActiveLoansArray: JsonArray; var TotalLoanBalance: Decimal; var TotalMonthlyPayment: Decimal)
    var
        SaccoLoans: Record Loans;
        LoanRepaySchedule: Record "Loan Repayment Schedule";
        ActiveLoanJson: JsonObject;
        NextDueDate: Date;
        RemainingMonths: Integer;
        ProgressPercent: Integer;
        MonthlyPayment: Decimal;
    begin
        TotalLoanBalance := 0;
        TotalMonthlyPayment := 0;

        SaccoLoans.Reset();
        SaccoLoans.SetRange("Member No.", MemberNo);
        // Filter for loans with outstanding balance
        SaccoLoans.SetFilter("Outstanding Principal", '>0');
        if SaccoLoans.FindSet() then begin
            repeat
                SaccoLoans.CalcFields("Total Outstanding Balance", "Outstanding Principal");
                // Calculate monthly payment based on approved amount, interest and installments
                MonthlyPayment := SaccoLoans.Repayment;

                // Default next due date to next month
                NextDueDate := CalcDate('<+1M>', Today);

                // Default remaining months to half of total installments
                RemainingMonths := Round(SaccoLoans.Installments / 2, 1);

                // Try to get the next installment date from repayment schedule if available
                LoanRepaySchedule.Reset();
                LoanRepaySchedule.SetRange("Loan No.", SaccoLoans."Loan No.");
                LoanRepaySchedule.SetFilter("Repayment Date", '>=%1', Today);
                if LoanRepaySchedule.FindFirst() then begin
                    NextDueDate := LoanRepaySchedule."Repayment Date";
                    RemainingMonths := LoanRepaySchedule.Count;
                end;

                // Calculate progress percentage based on outstanding vs approved
                ProgressPercent := 0;
                if SaccoLoans."Approved Amount" > 0 then
                    ProgressPercent := Round(100 * (1 - SaccoLoans."Outstanding Principal" / SaccoLoans."Approved Amount"), 1);

                if ProgressPercent < 0 then ProgressPercent := 0;
                if ProgressPercent > 100 then ProgressPercent := 100;

                // Create the active loan JSON
                Clear(ActiveLoanJson);
                ActiveLoanJson.Add('loan_type', SaccoLoans."Loan Product Type Name");
                ActiveLoanJson.Add('loan_number', SaccoLoans."Loan No.");
                ActiveLoanJson.Add('outstanding_balance', SaccoLoans."Total Outstanding Balance");
                ActiveLoanJson.Add('monthly_payment', MonthlyPayment);
                ActiveLoanJson.Add('next_due_date', Format(NextDueDate));
                ActiveLoanJson.Add('remaining_months', RemainingMonths);
                ActiveLoanJson.Add('progress_percent', ProgressPercent);

                ActiveLoansArray.Add(ActiveLoanJson);

                // Add to totals
                TotalLoanBalance += SaccoLoans."Outstanding Principal";
                TotalMonthlyPayment += MonthlyPayment;
            until SaccoLoans.Next() = 0;
        end;

    end;

    local procedure GetLoanRepaymentHistory(MemberNo: Code[20]; var RepaymentHistoryArray: JsonArray; var InterestPaidYTD: Decimal; var PrincipalPaidYTD: Decimal)
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
        Loans: Record Loans;
        RepaymentJson: JsonObject;
        YearStartDate: Date;
        EntryCount: Integer;
        LoanType: Text;
        TransactionStatus: Text;
    begin
        InterestPaidYTD := 0;
        PrincipalPaidYTD := 0;

        // Calculate year start date
        YearStartDate := DMY2Date(1, 1, Date2DMY(Today, 3));

        // Get loan repayment history from Credit Ledger Entry
        CreditLedgerEntry.Reset();
        CreditLedgerEntry.SetCurrentKey("Posting Date"); // Order by date
        CreditLedgerEntry.SetAscending("Posting Date", false); // Most recent first
        CreditLedgerEntry.SetRange("Member No.", MemberNo);
        CreditLedgerEntry.SetFilter("Transaction Type", '%1|%2|%3|%4',
                                  CreditLedgerEntry."Transaction Type"::"Principal Repayment",
                                  CreditLedgerEntry."Transaction Type"::"Interest Paid",
                                  CreditLedgerEntry."Transaction Type"::"Penalty Paid",
                                  CreditLedgerEntry."Transaction Type"::"Insurance Paid");
        CreditLedgerEntry.SetRange(Reversed, false); // Exclude reversed entries

        if CreditLedgerEntry.FindSet() then begin
            EntryCount := 0;

            repeat
                // Get loan type from Loans table or use the field if available
                LoanType := '';
                if Loans.Get(CreditLedgerEntry."Loan No.") then begin
                    LoanType := Loans."Loan Product Type Name";
                    if LoanType = '' then
                        LoanType := Loans."Loan Product Type";
                end;

                if LoanType = '' then
                    LoanType := 'Loan ' + CreditLedgerEntry."Loan No.";

                // Create repayment history entry
                Clear(RepaymentJson);
                RepaymentJson.Add('loan_type', LoanType);
                RepaymentJson.Add('loan_no', CreditLedgerEntry."Loan No.");
                RepaymentJson.Add('date', Format(CreditLedgerEntry."Posting Date"));
                RepaymentJson.Add('amount', Abs(CreditLedgerEntry.Amount));
                RepaymentJson.Add('transaction_type', Format(CreditLedgerEntry."Transaction Type"));

                // Determine payment status (simple version - could be enhanced with due date checks)
                TransactionStatus := 'On Time';
                RepaymentJson.Add('status', TransactionStatus);

                // Add to repayment history array (limit to 10 entries)
                if EntryCount < 10 then begin
                    RepaymentHistoryArray.Add(RepaymentJson);
                    EntryCount += 1;
                end;

                // Calculate YTD totals
                if CreditLedgerEntry."Posting Date" >= YearStartDate then begin
                    case CreditLedgerEntry."Transaction Type" of
                        CreditLedgerEntry."Transaction Type"::"Interest Paid":
                            InterestPaidYTD += Abs(CreditLedgerEntry.Amount);
                        CreditLedgerEntry."Transaction Type"::"Principal Repayment":
                            PrincipalPaidYTD += Abs(CreditLedgerEntry.Amount);
                    end;
                end;

            until (CreditLedgerEntry.Next() = 0) or (EntryCount >= 10);
        end;


    end;

    local procedure GetRecentTransactions(MemberNo: Code[20]; var TransactionsArray: JsonArray)
    var
        MemberAccounts: Record "Savings Accounts";
        SLedger: Record "Savings Ledger Entry";
        TransactionJson: JsonObject;
        RunBal: Decimal;
        j: Integer;
        k: Integer;
        AmountText: Text;
        FormattedDate: Text;
        IconBg: Text;
        IconColor: Text;
        Direction: Text;
    begin
        // Find the member's ordinary savings account
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MemberNo);
        MemberAccounts.SetFilter("Product Category", '<>%1', MemberAccounts."Product Category"::"Registration Fee");
        if MemberAccounts.FindFirst() then begin
            SLedger.Reset();
            SLedger.SetCurrentKey("Posting Date");
            SLedger.SetFilter("Product Category", '<>%1', MemberAccounts."Product Category"::"Registration Fee");
            SLedger.SetAscending("Posting Date", false); // Most recent first
            SLedger.SetFilter("Member No.", MemberNo);
            SLedger.SetRange(Reversed, false);

            if SLedger.FindSet() then begin
                // Get the last 10 transactions
                j := 0;
                RunBal := 0;

                repeat
                    j += 1;

                    // Get and format the transaction amount
                    if SLedger."Amount (LCY)" < 0 then begin
                        AmountText := '+KES ' + Format(SLedger."Credit Amount (LCY)", 0, '<Precision,2><Standard Format,0>');
                        IconBg := 'bg-green-100';
                        IconColor := 'text-green-500';
                        Direction := 'Funds In';
                    end else begin
                        AmountText := '-KES ' + Format(SLedger."Debit Amount (LCY)", 0, '<Precision,2><Standard Format,0>');
                        IconBg := 'bg-red-100';
                        IconColor := 'text-red-500';
                        Direction := 'Funds Out';
                    end;

                    // Format the date
                    FormattedDate := Format(SLedger."Posting Date");

                    // Create transaction JSON
                    TransactionJson := AddSampleTransaction(
                        SLedger.Description,
                        FormattedDate,
                        SLedger."Amount (LCY)" * -1,
                        Direction,
                        IconBg,
                        IconColor
                    );

                    // Add additional transaction details
                    TransactionJson.Add('id', Format(SLedger."Entry No."));
                    TransactionJson.Add('account_no', SLedger."Account No.");
                    if MemberAccounts.Get(SLedger."Account No.") then
                        TransactionJson.Add('account_type', MemberAccounts."Product Name")
                    else
                        TransactionJson.Add('account_type', 'Savings Account');
                    TransactionJson.Add('transaction_date', SLedger."Posting Date");
                    TransactionJson.Add('debit_amount', SLedger."Amount (LCY)");
                    TransactionJson.Add('credit_amount', SLedger."Amount (LCY)" * -1);

                    // Add to the transactions array
                    TransactionsArray.Add(TransactionJson);

                    // Limit to 10 transactions
                    if j >= 10 then
                        break;
                until SLedger.Next() = 0;
            end;
        end;

    end;

    local procedure GetSavingsGoals(MemberNo: Code[20]; var GoalsArray: JsonArray)
    var
        SavingsGoals: Record "Savings Goals";
        MemberAccounts: Record "Savings Accounts";
        GoalJson: JsonObject;
        CurrentBalance: Decimal;
        TargetBalance: Decimal;
        StartingBalance: Decimal;
        Progress: Integer;
    begin
        // Check if there are any savings goals for this member
        SavingsGoals.Reset();
        SavingsGoals.SetRange("Member No.", MemberNo);
        SavingsGoals.SetFilter(Status, '%1|%2', SavingsGoals.Status::Active, SavingsGoals.Status::Achieved);
        if SavingsGoals.FindSet() then begin
            repeat
                // Get current balance of the savings account
                CurrentBalance := 0;
                if MemberAccounts.Get(SavingsGoals."Account No. ") then begin
                    MemberAccounts.CalcFields("Balance (LCY)");
                    CurrentBalance := MemberAccounts."Balance (LCY)";
                end;

                TargetBalance := SavingsGoals."Target Balance";
                StartingBalance := SavingsGoals."Starting Balance";

                // Calculate progress using the function from Savings Goals table
                Progress := SavingsGoals.CalculateProgress(CurrentBalance);

                // Create and add the goal JSON
                GoalJson := AddSampleGoal(
                    SavingsGoals."Account Name",
                    Progress,
                    CurrentBalance,
                    TargetBalance
                );
                GoalsArray.Add(GoalJson);
            until SavingsGoals.Next() = 0;
        end;
    end;

    local procedure GetRecentNotifications(MemberNo: Code[20]; var NotificationsArray: JsonArray)
    var
        MemberNotification: Record "Member Notifications";
        NotificationJson: JsonObject;
        RelativeDate: Text;
        NotificationCount: Integer;
    begin
        // Query the database to get recent notifications for the member
        MemberNotification.Reset();
        MemberNotification.SetRange("Member No.", MemberNo);
        MemberNotification.SetFilter("Expiry Date", '>=%1', CurrentDateTime);
        MemberNotification.SetCurrentKey("Created Date");
        MemberNotification.Ascending(false); // Most recent first

        if MemberNotification.FindSet() then begin
            NotificationCount := 0;
            repeat
                // Create notification JSON object
                NotificationJson.Add('id', Format(MemberNotification."Entry No."));
                NotificationJson.Add('title', MemberNotification.Title);
                NotificationJson.Add('content', MemberNotification.Content);
                NotificationJson.Add('date', MemberNotification.FormatRelativeDate());
                NotificationJson.Add('link_text', MemberNotification."Link Text");
                NotificationJson.Add('link_url', MemberNotification."Link URL");
                NotificationJson.Add('is_read', MemberNotification."Is Read");
                NotificationJson.Add('category', Format(MemberNotification.Category));
                NotificationJson.Add('created_date', MemberNotification."Created Date");

                // Add to the notifications array
                NotificationsArray.Add(NotificationJson);

                // Limit to 10 notifications
                NotificationCount += 1;
                if NotificationCount >= 10 then
                    break;
            until MemberNotification.Next() = 0;
        end;





        // Query the database to get recent notifications for the member
        MemberNotification.Reset();
        MemberNotification.SetRange("Member No.", '');
        MemberNotification.SetFilter("Expiry Date", '>=%1', CurrentDateTime);
        MemberNotification.SetCurrentKey("Created Date");
        MemberNotification.Ascending(false); // Most recent first
        if MemberNotification.FindSet() then begin
            NotificationCount := 0;
            repeat
                // Create notification JSON object
                NotificationJson.Add('id', Format(MemberNotification."Entry No."));
                NotificationJson.Add('title', MemberNotification.Title);
                NotificationJson.Add('content', MemberNotification.Content);
                NotificationJson.Add('date', MemberNotification.FormatRelativeDate());
                NotificationJson.Add('link_text', MemberNotification."Link Text");
                NotificationJson.Add('link_url', MemberNotification."Link URL");
                NotificationJson.Add('is_read', MemberNotification."Is Read");
                NotificationJson.Add('category', Format(MemberNotification.Category));
                NotificationJson.Add('created_date', MemberNotification."Created Date");

                // Add to the notifications array
                NotificationsArray.Add(NotificationJson);

                // Limit to 10 notifications
                NotificationCount += 1;
                if NotificationCount >= 10 then
                    break;
            until MemberNotification.Next() = 0;
        end;
    end;

    local procedure AddSampleTransaction(Description: Text; TransactionDate: Text; Amount: Decimal; Status: Text; IconBg: Text; IconColor: Text): JsonObject
    var
        TransactionJson: JsonObject;
        TransactionType: Text;
    begin
        // Determine transaction type based on amount prefix
        if Amount < 0 then
            TransactionType := 'Credit'
        else if Amount > 0 then
            TransactionType := 'Debit'
        else
            TransactionType := 'Unknown';

        // Create the transaction JSON object with enhanced data
        TransactionJson.Add('description', Description);
        TransactionJson.Add('date', TransactionDate);
        TransactionJson.Add('amount', Amount);
        TransactionJson.Add('status', Status);
        TransactionJson.Add('transaction_type', TransactionType);
        TransactionJson.Add('icon_bg', IconBg);
        TransactionJson.Add('icon_color', IconColor);

        // Add a transaction summary for display purposes
        if StrLen(Description) > 30 then
            TransactionJson.Add('summary', CopyStr(Description, 1, 27) + '...')
        else
            TransactionJson.Add('summary', Description);

        exit(TransactionJson);
    end;

    local procedure AddSampleGoal(Name: Text; Progress: Integer; CurrentAmount: Decimal; TargetAmount: Decimal): JsonObject
    var
        GoalJson: JsonObject;
        FormattedCurrent: Text;
        FormattedTarget: Text;
        RemainingAmount: Decimal;
        FormattedRemaining: Text;
    begin
        // Format currency amounts
        FormattedCurrent := Format(CurrentAmount, 0, '<Precision,2><Standard Format,0>');
        FormattedTarget := Format(TargetAmount, 0, '<Precision,2><Standard Format,0>');

        // Calculate remaining amount
        RemainingAmount := TargetAmount - CurrentAmount;
        if RemainingAmount < 0 then
            RemainingAmount := 0;
        FormattedRemaining := Format(RemainingAmount, 0, '<Precision,2><Standard Format,0>');

        // Create the goal JSON
        GoalJson.Add('name', Name);
        GoalJson.Add('progress', Progress);
        GoalJson.Add('current_amount', CurrentAmount);
        GoalJson.Add('target_amount', TargetAmount);
        GoalJson.Add('remaining_amount', RemainingAmount);
        GoalJson.Add('formatted_current', 'KES ' + FormattedCurrent);
        GoalJson.Add('formatted_target', 'KES ' + FormattedTarget);
        GoalJson.Add('formatted_remaining', 'KES ' + FormattedRemaining);

        exit(GoalJson);
    end;

    local procedure AddSampleNotification(Title: Text; Content: Text; NotificationDate: Text; LinkText: Text; LinkUrl: Text): JsonObject
    var
        NotificationJson: JsonObject;
    begin
        NotificationJson.Add('title', Title);
        NotificationJson.Add('content', Content);
        NotificationJson.Add('date', NotificationDate);
        NotificationJson.Add('link_text', LinkText);
        NotificationJson.Add('link_url', LinkUrl);
        NotificationJson.Add('is_read', false);
        NotificationJson.Add('id', '0');
        NotificationJson.Add('category', 'General');
        exit(NotificationJson);
    end;

    local procedure GetNotifications(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        MemberNotification: Record "Member Notifications";
        NotificationsArray: JsonArray;
        NotificationJson: JsonObject;
        DataJson: JsonObject;
        MemberNo: Code[20];
        UnreadOnly: Boolean;
        Category: Text;
        NotificationCount: Integer;
    begin
        // Extract request parameters
        MemberNo := SelectJsonToken(RequestJson, '$.member_no').AsValue.AsText;

        // Optional filters
        if RequestJson.Contains('unread_only') then
            UnreadOnly := SelectJsonToken(RequestJson, '$.unread_only').AsValue.AsBoolean();

        if RequestJson.Contains('category') then
            Category := SelectJsonToken(RequestJson, '$.category').AsValue.AsText();

        // Query notifications
        MemberNotification.Reset();
        MemberNotification.SetRange("Member No.", MemberNo);
        MemberNotification.SetFilter("Expiry Date", '>=%1', CurrentDateTime);

        if UnreadOnly then
            MemberNotification.SetRange("Is Read", false);

        // Filter by category if specified
        if Category <> '' then begin
            case Category of
                'General':
                    MemberNotification.SetRange(Category, MemberNotification.Category::General);
                'Account':
                    MemberNotification.SetRange(Category, MemberNotification.Category::Account);
                'Loan':
                    MemberNotification.SetRange(Category, MemberNotification.Category::Loan);
                'Transaction':
                    MemberNotification.SetRange(Category, MemberNotification.Category::Transaction);
                'System':
                    MemberNotification.SetRange(Category, MemberNotification.Category::System);
                'Important':
                    MemberNotification.SetRange(Category, MemberNotification.Category::Important);
            end;
        end;

        MemberNotification.SetCurrentKey("Created Date");
        MemberNotification.Ascending(false); // Most recent first

        if MemberNotification.FindSet() then begin
            NotificationCount := 0;
            repeat
                // Create notification JSON object
                NotificationJson.Add('id', Format(MemberNotification."Entry No."));
                NotificationJson.Add('title', MemberNotification.Title);
                NotificationJson.Add('content', MemberNotification.Content);
                NotificationJson.Add('date', MemberNotification.FormatRelativeDate());
                NotificationJson.Add('link_text', MemberNotification."Link Text");
                NotificationJson.Add('link_url', MemberNotification."Link URL");
                NotificationJson.Add('is_read', MemberNotification."Is Read");
                NotificationJson.Add('category', Format(MemberNotification.Category));
                NotificationJson.Add('created_date', MemberNotification."Created Date");

                // Add to the notifications array
                NotificationsArray.Add(NotificationJson);
                Clear(NotificationJson);

                // Limit to 30 notifications for full list
                NotificationCount += 1;
                if NotificationCount >= 30 then
                    break;
            until MemberNotification.Next() = 0;
        end;

        // Build response
        DataJson.Add('notifications', NotificationsArray);
        DataJson.Add('total_count', NotificationCount);

        SetResponseStatus(ResponseJson, 'success', 'Notifications Retrieved', 'Member notifications retrieved successfully');
        ResponseJson.Add(Data, DataJson);
    end;

    local procedure MarkNotificationRead(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        MemberNotification: Record "Member Notifications";
        NotificationMgmt: Codeunit "Member Notification Management";
        MemberNo: Code[20];
        NotificationId: Integer;
        IsSuccess: Boolean;
    begin
        // Extract request parameters
        MemberNo := SelectJsonToken(RequestJson, '$.member_no').AsValue.AsText;
        NotificationId := SelectJsonToken(RequestJson, '$.notification_id').AsValue.AsInteger();

        // Mark notification as read
        NotificationMgmt.MarkAsRead(MemberNo, NotificationId);

        // Check if notification was marked as read
        if MemberNotification.Get(NotificationId) then
            IsSuccess := MemberNotification."Is Read" = true;

        if IsSuccess then
            SetResponseStatus(ResponseJson, 'success', 'Notification Updated', 'Notification marked as read')
        else
            SetResponseStatus(ResponseJson, 'error', 'Notification Update Failed', 'Failed to mark notification as read');
    end;

    local procedure SelectJsonToken(JsonObject: JsonObject; Path: Text) JsonToken: JsonToken
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('Could not find token with path %1', Path);
    end;

    local procedure SelectJsonTokenWithoutError(JsonObject: JsonObject; Path: Text; var Found: Boolean) JsonToken: JsonToken
    begin
        Found := false;
        if JsonObject.SelectToken(Path, JsonToken) then
            Found := true;
    end;

    local procedure ValidateRegistrationMemberDetails(RequestJson: JsonObject; var ValidationMessage: Text): Boolean
    var
        IDNumber: Text;
        IDType: Text;
        PhoneNumber: Text;
    begin
        IDNumber := DelChr(SelectJsonToken(RequestJson, '$.id_number').AsValue.AsText, '=', ' ');
        IDType := LowerCase(SelectJsonToken(RequestJson, '$.id_type').AsValue.AsText);
        PhoneNumber := NormalizePhoneNumber(SelectJsonToken(RequestJson, '$.phone_number').AsValue.AsText);

        if (StrLen(IDNumber) < 7) or (StrLen(IDNumber) > 9) then begin
            ValidationMessage := 'ID/Passport number must be 7 to 9 characters.';
            exit(false);
        end;

        if (IDType = 'national id') and (not IsDigitsOnly(IDNumber)) then begin
            ValidationMessage := 'National ID must contain digits only.';
            exit(false);
        end;

        if not IsValidKenyanPhoneNumber(PhoneNumber) then begin
            ValidationMessage := 'Please enter a valid Kenyan phone number.';
            exit(false);
        end;

        exit(true);
    end;

    local procedure NormalizePhoneNumber(PhoneNumber: Text): Text
    begin
        PhoneNumber := DelChr(PhoneNumber, '=', '+');
        PhoneNumber := DelChr(PhoneNumber, '=', ' ');
        PhoneNumber := DelChr(PhoneNumber, '=', '-');
        PhoneNumber := DelChr(PhoneNumber, '=', '(');
        PhoneNumber := DelChr(PhoneNumber, '=', ')');
        exit(PhoneNumber);
    end;

    local procedure IsValidKenyanPhoneNumber(PhoneNumber: Text): Boolean
    begin
        if not IsDigitsOnly(PhoneNumber) then
            exit(false);

        if StrLen(PhoneNumber) = 10 then
            exit((CopyStr(PhoneNumber, 1, 2) = '07') or (CopyStr(PhoneNumber, 1, 2) = '01'));

        if StrLen(PhoneNumber) = 12 then
            exit((CopyStr(PhoneNumber, 1, 4) = '2547') or (CopyStr(PhoneNumber, 1, 4) = '2541'));

        exit(false);
    end;

    local procedure IsDigitsOnly(Value: Text): Boolean
    var
        i: Integer;
        Character: Text[1];
    begin
        if Value = '' then
            exit(false);

        for i := 1 to StrLen(Value) do begin
            Character := CopyStr(Value, i, 1);
            if (Character < '0') or (Character > '9') then
                exit(false);
        end;

        exit(true);
    end;

    local procedure GenerateRandomOTP(): Text[6]
    var
        OTP: Text[6];
        i: Integer;
    begin
        // Generate a 6-digit OTP
        OTP := '';
        for i := 1 to 6 do
            OTP += Format(Random(10) - 1);  // Random digit 0-9

        //exit('123456');
        exit(OTP);
    end;

    local procedure GenerateRandomWordNumber(): Text[6]
    var
        Result: Text[6];
        i: Integer;
        Letters: Text;
        Numbers: Text;
        RandomIndex: Integer;
    begin
        // Allowed sets
        Letters := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        Numbers := '0123456789';

        // First 3 letters
        for i := 1 to 3 do begin
            RandomIndex := Random(StrLen(Letters)) + 1;
            Result += CopyStr(Letters, RandomIndex, 1);
        end;

        // Next 3 digits
        for i := 1 to 3 do begin
            RandomIndex := Random(StrLen(Numbers)) + 1;
            Result += CopyStr(Numbers, RandomIndex, 1);
        end;

        //exit('123456');
        exit(Result);
    end;



    // ################################################################################################
    // SECURITY FUNCTIONS
    // ################################################################################################

    local procedure HashPassword(PlainTextPassword: Text; Salt: Text): Text
    var
        CryptoMgmt: Codeunit "Cryptography Management";
        HashType: Enum "Hash Algorithm";
        HashAlgorithmOption: Option MD5,SHA1,SHA256,SHA384,SHA512;
    begin
        // Use SHA-256 for password hashing
        HashType := HashType::SHA256;
        HashAlgorithmOption := HashAlgorithmOption::SHA256; // SHA256 = 2
        exit(CryptoMgmt.GenerateHash(PlainTextPassword, HashAlgorithmOption));
    end;

    local procedure VerifyPasswordHash(PlainTextPassword: Text; HashedPassword: Text): Boolean
    var
        PortalAuth: Record "Portal Auth";
        CryptoMgmt: Codeunit "Cryptography Management";
        HashType: Enum "Hash Algorithm";
        HashAlgorithmOption: Option MD5,SHA1,SHA256,SHA384,SHA512;
        CurrentHash: Text;
        ExtractedSalt: Text;
    begin
        // First check if it's a temporary plaintext password (for backward compatibility)
        if PlainTextPassword = HashedPassword then
            exit(true);

        // Check if the password contains salt information (modern format)
        if StrPos(HashedPassword, '::') > 0 then begin
            // Split the hash and salt
            CurrentHash := CopyStr(HashedPassword, 1, StrPos(HashedPassword, '::') - 1);
            ExtractedSalt := CopyStr(HashedPassword, StrPos(HashedPassword, '::') + 2);

            // Generate hash with the extracted salt
            HashAlgorithmOption := 2; // SHA256 = 2
            exit(CryptoMgmt.GenerateHash(PlainTextPassword + ExtractedSalt, HashAlgorithmOption) = CurrentHash);
        end;

        // Default: plaintext comparison as fallback
        exit(PlainTextPassword = HashedPassword);
    end;

    local procedure LogSecurityEvent(EventType: Text; Username: Text; EventDetails: Text; IsAlert: Boolean)
    var
        SecurityLog: Record "Security Log";
    begin
        // Log security events for audit purposes
        SecurityLog.Init();
        SecurityLog."Event Type" := EventType;
        SecurityLog."User ID" := Username;
        SecurityLog."Date and Time" := CurrentDateTime;
        SecurityLog."Details" := EventDetails;
        SecurityLog."Is Alert" := IsAlert;

        // Try to get client IP if available
        // This would require obtaining the IP from the request
        // SecurityLog."IP Address" := ClientIP;

        SecurityLog.Insert(true);

        // For critical security events, also log a telemetry event
        if IsAlert or (EventType = 'LoginFailure') or (EventType = 'AccountLocked') or
           (EventType = 'PasswordReset') or (EventType = 'SuspiciousActivity') then
            LogMessage('SecurityAlert', EventDetails, Verbosity::Warning, DataClassification::EndUserPseudonymousIdentifiers,
                      TelemetryScope::ExtensionPublisher, 'Username', Username);
    end;

    local procedure EnforceRateLimit(Username: Text; ActionType: Text): Boolean
    var
        SecurityLog: Record "Security Log";
        LastMinuteCount: Integer;
        LastHourCount: Integer;
        RateLimitExceeded: Boolean;
        OneMinuteAgo: DateTime;
        OneHourAgo: DateTime;
    begin
        // Implement rate limiting for security-sensitive actions
        // Return true if rate limit is NOT exceeded (action allowed)
        // Return false if rate limit IS exceeded (action blocked)

        OneMinuteAgo := CurrentDateTime - (60 * 1000); // 1 minute ago in milliseconds
        OneHourAgo := CurrentDateTime - (60 * 60 * 1000); // 1 hour ago in milliseconds

        // Count events in the last minute
        SecurityLog.Reset();
        SecurityLog.SetRange("User ID", Username);
        SecurityLog.SetRange("Event Type", ActionType);
        SecurityLog.SetFilter("Date and Time", '>%1', OneMinuteAgo);
        LastMinuteCount := SecurityLog.Count;

        // Count events in the last hour
        SecurityLog.Reset();
        SecurityLog.SetRange("User ID", Username);
        SecurityLog.SetRange("Event Type", ActionType);
        SecurityLog.SetFilter("Date and Time", '>%1', OneHourAgo);
        LastHourCount := SecurityLog.Count;

        // Apply rate limits based on action type
        RateLimitExceeded := false;

        case ActionType of
            'OTPGeneration':
                RateLimitExceeded := (LastMinuteCount >= 3) or (LastHourCount >= 10);
            'LoginAttempt':
                RateLimitExceeded := (LastMinuteCount >= 5) or (LastHourCount >= 20);
            'PasswordReset':
                RateLimitExceeded := (LastMinuteCount >= 2) or (LastHourCount >= 5);
        end;

        if RateLimitExceeded then
            LogSecurityEvent('RateLimitExceeded', Username, StrSubstNo('Rate limit exceeded for %1', ActionType), true);

        exit(not RateLimitExceeded);
    end;

    local procedure GetMemberProfile(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        MemberBeneficiaries: Record "Member Beneficiaries";
        //NextOfKin: Record "Next of Kin.";
        NextOfKin: Record "Next of Kin.";
        PortalQuestions: Record "Portal Mbanking Questions";
        SMSMessages: Record "Sky SMS Messages";
        SecurityLog: Record "Security Log";
        Base64Convert: Codeunit "Base64";
        PortalUploads: Record "Portal Uploads";
        DataJson: JsonObject;
        ProfileDataJson: JsonObject;
        EmploymentInfoJson: JsonObject;
        NextOfKinArray: JsonArray;
        SecuritySettingsJson: JsonObject;
        SecurityQuestionsArray: JsonArray;
        AvailableQuestionsArray: JsonArray;
        NotificationPreferencesJson: JsonObject;
        NotificationTypesJson: JsonObject;
        LoginActivityArray: JsonArray;
        BeneficiariesArray: JsonArray;
        NotificationsArray: JsonArray;
        KYCDocumentsArray: JsonArray;
        FinancialDocumentsArray: JsonArray;
        NextOfKinJson: JsonObject;
        SecurityQuestionJson: JsonObject;
        AvailableQuestionJson: JsonObject;
        LoginActivityJson: JsonObject;
        BeneficiaryJson: JsonObject;
        NotificationJson: JsonObject;
        DocumentJson: JsonObject;
        MemberId: Text;
        MemberNo: Code[20];
        SessionId: Text;
        Username: Text;
        PhysicalAddress: Text;
        MemberSince: Text;
        ProfilePhotoUrl: Text;
        PhotoBase64: Text;
        LoginCount: Integer;
        DaysDiff: Decimal;
        TimeDescription: Text;

    begin
        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if PortalAuth.FindFirst() then begin
            // Get Member No from Portal Auth if it exists
            MemberNo := PortalAuth."Member No.";

            // If we have a Member ID but no Member No, try to find Member No
            if not Members.Get(MemberNo) then begin
                SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
                exit(ResponseJson);
            end;

            // Initialize response
            SetResponseStatus(ResponseJson, 'success', 'Profile Data Retrieved', 'Member profile data retrieved successfully');
            ResponseJson.Add('timestamp', Format(CurrentDateTime));

            // Create data object
            DataJson.Add('member_id', MemberNo);

            // Format physical address
            PhysicalAddress := '';
            if Members.Address <> '' then
                PhysicalAddress := Members.Address;
            if Members."Address 2" <> '' then
                PhysicalAddress += ', ' + Members."Address 2";
            if Members.City <> '' then
                PhysicalAddress += ', ' + Members.City;

            // Format member since date
            MemberSince := '';
            if Members."Registration Date" <> 0D then
                MemberSince := Format(Members."Registration Date");

            // Profile Data Section
            ProfileDataJson.Add('member_id', MemberNo);
            ProfileDataJson.Add('member_name', Members.Name);
            ProfileDataJson.Add('first_name', Members."First Name");
            ProfileDataJson.Add('last_name', Members.Surname);
            ProfileDataJson.Add('email', Members."E-Mail");
            ProfileDataJson.Add('phone_number', Members."Mobile Phone No.");
            ProfileDataJson.Add('id_number', Members."ID No.");
            DataJson.Add('member_category', format(Members."Member Category"));
            ProfileDataJson.Add('date_of_birth', yyyyMMdd(Members."Date of Birth"));
            ProfileDataJson.Add('physical_address', PhysicalAddress);
            ProfileDataJson.Add('member_since', MemberSince);
            ProfileDataJson.Add('account_status', Format(Members."Member Status"));
            ProfileDataJson.Add('kyc_status', 'Verified'); // Default value as field may not exist

            // Get profile photo URL from external API if available (based on member number)

            PhotoBase64 := GetMemberPhotoBase64(MemberNo);

            ProfileDataJson.Add('profile_photo_url', PhotoBase64);
            DataJson.Add('profile_data', ProfileDataJson);

            // Employment Info Section
            EmploymentInfoJson.Add('employer', Members."Employer Name");
            EmploymentInfoJson.Add('job_title', Format(Members."Terms of Employment"));
            EmploymentInfoJson.Add('monthly_salary', 0); // Default value as field may not exist
            EmploymentInfoJson.Add('employment_date', Format(Members."Registration Date")); // Using registration date as fallback
            EmploymentInfoJson.Add('employer_address', ''); // Default value as field may not exist
            DataJson.Add('employment_info', EmploymentInfoJson);

            // Next of Kin Section (using actual data from Next of Kin BOSA table)
            NextOfKin.Reset();
            NextOfKin.SetRange("No.", MemberNo);

            if NextOfKin.FindSet() then begin
                repeat
                    Clear(NextOfKinJson);
                    NextOfKinJson.Add('id', Format(NextOfKin."ID No.") + '-' + Format(NextOfKin.Name));
                    NextOfKinJson.Add('name', NextOfKin.Name);
                    NextOfKinJson.Add('relationship', NextOfKin.Relationship);
                    NextOfKinJson.Add('phone_number', NextOfKin."Mobile Phone No.");
                    NextOfKinJson.Add('email', NextOfKin.Email);
                    NextOfKinJson.Add('address', '');
                    NextOfKinJson.Add('percentage', NextOfKin."%Allocation");
                    // Use current date as fallback if not available
                    NextOfKinJson.Add('date_added', Format(Today));
                    NextOfKinArray.Add(NextOfKinJson);
                until NextOfKin.Next() = 0;
            end;



            PortalQuestions.Reset;
            PortalQuestions.SetFilter(Questions, '<>%1', '');
            if PortalQuestions.FindFirst then begin
                //message('-- %1', SMS.Count);
                repeat

                    Clear(SecuritySettingsJson);
                    SecuritySettingsJson.Add('question_id', PortalQuestions.id);
                    SecuritySettingsJson.Add('question', PortalQuestions.Questions);
                    SecurityQuestionsArray.Add(SecuritySettingsJson);

                until PortalQuestions.Next = 0;
            end;

            DataJson.Add('available_questions', SecurityQuestionsArray);





            smsMessages.Reset;
            smsMessages.SetFilter(msg_status_code, '10');
            smsMessages.SetRange(receiver, Members."Mobile Phone No.");
            if smsMessages.FindFirst then begin
                //message('-- %1', SMS.Count);
                repeat

                    Clear(NotificationJson);
                    NotificationJson.Add('date', smsMessages.msg_status_date);
                    NotificationJson.Add('sms', smsMessages.msg);
                    NotificationsArray.Add(NotificationJson);

                until smsMessages.Next = 0;
            end;

            DataJson.Add('notifications', NotificationsArray);



            // Notification Preferences Section
            NotificationPreferencesJson.Add('email_notifications', true);
            NotificationPreferencesJson.Add('sms_notifications', false);

            NotificationTypesJson.Add('transaction_alerts', true);
            NotificationTypesJson.Add('loan_payment_reminders', true);
            NotificationTypesJson.Add('meeting_notifications', true);
            NotificationTypesJson.Add('product_updates', false);
            NotificationTypesJson.Add('marketing_communications', false);
            NotificationTypesJson.Add('security_alerts', true);
            NotificationPreferencesJson.Add('notification_types', NotificationTypesJson);

            DataJson.Add('notification_preferences', NotificationPreferencesJson);

            // Login Activity Section - Get from Security Log table
            SecurityLog.Reset();
            SecurityLog.SetCurrentKey("Date and Time");  // Sort by date, newest first
            SecurityLog.SetRange("User ID", MemberNo);  // Filter by member number
            SecurityLog.SetRange("Event Type", 'LOGIN');  // Filter for login events
            SecurityLog.SetAscending("Date and Time", false);  // Newest first



            // Add previous logins from Security Log
            LoginCount := 0;
            if SecurityLog.FindSet() then begin
                repeat
                    if LoginCount < 5 then begin  // Limit to 5 most recent logins
                        Clear(LoginActivityJson);

                        // Try to parse device/browser info from details
                        if SecurityLog.Details.Contains('Mobile') then begin
                            LoginActivityJson.Add('device', 'Mobile Device');
                            LoginActivityJson.Add('browser', 'Mobile App');
                        end else begin
                            LoginActivityJson.Add('device', 'Windows PC');
                            LoginActivityJson.Add('browser', 'Web Browser');
                        end;

                        // Use IP address if available
                        if SecurityLog."IP Address" <> '' then
                            LoginActivityJson.Add('ip_address', SecurityLog."IP Address")
                        else
                            LoginActivityJson.Add('ip_address', 'Unknown');

                        LoginActivityJson.Add('location', 'Kenya');

                        // Calculate relative time (today, yesterday, X days ago)
                        DaysDiff := Round((CurrentDateTime - SecurityLog."Date and Time") / 86400000, 1);
                        if DaysDiff = 0 then
                            TimeDescription := 'Today'
                        else if DaysDiff = 1 then
                            TimeDescription := 'Yesterday'
                        else if DaysDiff < 7 then
                            TimeDescription := Format(DaysDiff) + ' days ago'
                        else if DaysDiff < 30 then
                            TimeDescription := Format(Round(DaysDiff / 7, 1)) + ' weeks ago'
                        else
                            TimeDescription := Format(Round(DaysDiff / 30, 1)) + ' months ago';

                        LoginActivityJson.Add('time', TimeDescription);
                        LoginActivityJson.Add('timestamp', Format(SecurityLog."Date and Time"));
                        LoginActivityJson.Add('details', SecurityLog.Details);
                        LoginActivityArray.Add(LoginActivityJson);
                        LoginCount += 1;
                    end;
                until (SecurityLog.Next() = 0) or (LoginCount >= 5);
            end;

            DataJson.Add('login_activity', LoginActivityArray);

            // Beneficiaries Section (using actual data from Member Beneficiaries table)
            MemberBeneficiaries.Reset();
            MemberBeneficiaries.SetRange("Member No.", MemberNo);
            if MemberBeneficiaries.FindSet() then begin
                repeat
                    Clear(BeneficiaryJson);
                    BeneficiaryJson.Add('id', MemberBeneficiaries."Beneficiary ID");
                    BeneficiaryJson.Add('name', MemberBeneficiaries.Name);
                    BeneficiaryJson.Add('type', Format(MemberBeneficiaries.Type));
                    if MemberBeneficiaries.Type = MemberBeneficiaries.Type::Bank then
                        BeneficiaryJson.Add('bank', MemberBeneficiaries.Bank)
                    else
                        BeneficiaryJson.Add('bank', '');

                    BeneficiaryJson.Add('account_number', MemberBeneficiaries."Account Number");
                    BeneficiaryJson.Add('date_added', Format(MemberBeneficiaries."Date Added"));
                    BeneficiariesArray.Add(BeneficiaryJson);
                until MemberBeneficiaries.Next() = 0;
            end;


            DataJson.Add('beneficiaries', BeneficiariesArray);








            PortalUploads.Reset;
            PortalUploads.SetRange("Member No.", Members."No.");
            if PortalUploads.FindFirst then begin
                repeat

                    Clear(DocumentJson);
                    DocumentJson.Add('id', PortalUploads.ID);
                    DocumentJson.Add('date', PortalUploads.Date);
                    DocumentJson.Add('type', PortalUploads.Type);
                    DocumentJson.Add('name', PortalUploads.Name);
                    DocumentJson.Add('format', PortalUploads.Format);
                    DocumentJson.Add('status', Format(PortalUploads.Status));
                    DocumentJson.Add('date_uploaded', Format(DMY2Date(1, 1, Date2DMY(PortalUploads.Date, 3) - 1)) + 'T12:00:00Z');

                    KYCDocumentsArray.Add(DocumentJson);
                until PortalUploads.Next = 0;

            end;
            DataJson.Add('financial_documents', KYCDocumentsArray);


            // Add data to response
            ResponseJson.Add(Data, DataJson);
        end;
    end;

    // Helper function to validate member session and get member number
    local procedure GetMemberNoFromSession(SessionId: Text; MemberToken: Text; var MemberNo: Code[20]): Boolean
    var
        PortalAuth: Record "Portal Auth";
    begin
        MemberNo := '';

        // Check if session exists and is valid
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, MemberToken);
        PortalAuth.SetRange("Access Key", SessionId);
        if PortalAuth.FindFirst() then begin
            if CurrentDateTime <= PortalAuth."Session Expiry" then begin
                MemberNo := PortalAuth."Member No.";
                PortalAuth."Last Active" := CurrentDateTime;
                PortalAuth.Modify();
                exit(true);
            end;
        end;

        exit(false);
    end;

    local procedure GetMemberSecurityQuestions(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        MemberNo: Code[20];
        SessionId: Text;
        MemberToken: Text;
        JsonToken: JsonToken;
        PortalQuestions: Record "Portal Mbanking Questions";
        MemberSecurityQuestions: Record "Member Security Questions";
        DataJson: JsonObject;
        QuestionsArray: JsonArray;
        QuestionJson: JsonObject;
        QuestionIDList: List of [Integer];
        QuestionIDValue: Integer;
    begin
        // Extract request parameters
        if RequestJson.Get('session_id', JsonToken) then
            SessionId := JsonToken.AsValue().AsText();
        if RequestJson.Get('member_token', JsonToken) then
            MemberToken := JsonToken.AsValue().AsText();

        // Validate session
        if not GetMemberNoFromSession(SessionId, MemberToken, MemberNo) then begin
            ResponseJson.Add('status', 'error');
            ResponseJson.Add('message', 'Invalid session');
            exit;
        end;

        // Get security questions for this member
        MemberSecurityMgmt.GetMemberSecurityQuestions(MemberNo, QuestionIDList);

        // Create questions array
        foreach QuestionIDValue in QuestionIDList do begin
            Clear(QuestionJson);

            // Get the question details
            if PortalQuestions.Get(QuestionIDValue) then begin
                QuestionJson.Add('question_id', QuestionIDValue);
                QuestionJson.Add('question', PortalQuestions.Questions);

                // Get the date created
                MemberSecurityQuestions.Reset();
                MemberSecurityQuestions.SetRange("Member No", MemberNo);
                MemberSecurityQuestions.SetRange("Question ID", QuestionIDValue);
                if MemberSecurityQuestions.FindFirst() then
                    QuestionJson.Add('date_added', Format(MemberSecurityQuestions."Date Created"));

                QuestionsArray.Add(QuestionJson);
            end;
        end;

        // Add questions array to response
        DataJson.Add('questions', QuestionsArray);

        // Get all available questions
        Clear(QuestionsArray);
        PortalQuestions.Reset();
        if PortalQuestions.FindSet() then begin
            repeat
                Clear(QuestionJson);
                QuestionJson.Add('question_id', PortalQuestions.id);
                QuestionJson.Add('question', PortalQuestions.Questions);
                QuestionsArray.Add(QuestionJson);
            until PortalQuestions.Next() = 0;
        end;

        // Add available questions to response
        DataJson.Add('available_questions', QuestionsArray);

        // Add minimum required questions
        DataJson.Add('min_required_questions', 3);

        // Set response status
        ResponseJson.Add('status', 'success');
        ResponseJson.Add('message', 'Security questions retrieved successfully');
        ResponseJson.Add('data', DataJson);
    end;

    local procedure ValidateMemberSecurityQuestion(RequestJson: JsonObject) ResponseJson: JsonObject
    var

        Members: Record Members;
        IsValid: Boolean;
        PortalAuth: Record "Portal Auth";
        DataJson: JsonObject;
        TransactionsArray: JsonArray;
        GoalsArray: JsonArray;
        NotificationsArray: JsonArray;
        TransactionJson: JsonObject;
        GoalJson: JsonObject;
        NotificationJson: JsonObject;
        MemberId: Text;
        MemberNo: Code[20];
        SessionId: Text;

        QuestionID: Integer;
        Answer: Text;
        Username: Text;
    begin


        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        QuestionID := SelectJsonToken(RequestJson, '$.question_id').AsValue.AsInteger;
        Answer := SelectJsonToken(RequestJson, '$.answer').AsValue.AsText;


        MemberNo := '';
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if PortalAuth.FindFirst() then begin
            // Get Member No from Portal Auth if it exists
            MemberNo := PortalAuth."Member No.";

            // If we have a Member ID but no Member No, try to find Member No
            if not Members.Get(MemberNo) then begin
                SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
                exit(ResponseJson);
            end;
        end;

        // Validate security question answer
        IsValid := MemberSecurityMgmt.ValidateSecurityQuestion(MemberNo, QuestionID, Answer);

        DataJson.Add('is_valid', IsValid);
        if IsValid then begin
            SetResponseStatus(ResponseJson, 'success', 'Validated Successfully', 'Question validated successfully');
        end else begin
            SetResponseStatus(ResponseJson, 'error', 'Validation Failed', 'Question validation failed.');
        end;
        exit(ResponseJson);
    end;


    local procedure SetupSecurityQuestion(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        MemberSecurityQuestions: Record "Member Security Questions";
        SecurityUtils: Codeunit "Security Utils";
        MemberNo: Code[20];
        QuestionID: Integer;
        Answer: Text;
    begin
        // Check if this question is already set for the member
        MemberSecurityQuestions.Reset();
        MemberSecurityQuestions.SetRange("Member No", MemberNo);
        MemberSecurityQuestions.SetRange("Question ID", QuestionID);
        if MemberSecurityQuestions.FindFirst() then begin
            // Update existing question
            MemberSecurityQuestions."Answer" := SecurityUtils.GenerateHash(Answer);
            MemberSecurityQuestions."Is Active" := true;
            MemberSecurityQuestions.Modify();
            SetResponseStatus(ResponseJson, 'success', 'Validated Successfully', 'Question validated successfully');
        end else begin
            // Create new question
            MemberSecurityQuestions.Init();
            MemberSecurityQuestions.Validate("Member No", MemberNo);
            MemberSecurityQuestions.Validate("Question ID", QuestionID);
            MemberSecurityQuestions.Validate("Answer", SecurityUtils.GenerateHash(Answer));
            MemberSecurityQuestions.Validate("Is Active", true);
            MemberSecurityQuestions.Insert();
            SetResponseStatus(ResponseJson, 'success', 'Validated Successfully', 'Question validated successfully');
        end;
        exit(ResponseJson);
    end;



    // Helper function to get member photo as base64 string
    local procedure GetMemberPhotoBase64(MemberNo: Code[20]) PhotoBase64: Text
    var
        Base64Convert: Codeunit "Base64 Convert";
        InStr: InStream;
        MemberImage: Record "Member Images";
    begin
        PhotoBase64 := '';

        MemberImage.Reset();
        MemberImage.SetRange("Member No.", MemberNo);
        if MemberImage.FindFirst() then begin
            if MemberImage.Picture.HasValue() then begin
                // Get the image as InStream - we need to pass the InStr variable to the method
                MemberImage.Picture.CreateInStream(InStr);

                // Convert the image to base64 string
                PhotoBase64 := Base64Convert.ToBase64(InStr);
            end;
        end;

        exit(PhotoBase64);
    end;

    procedure SetPassword(NewPassword: Text) HashedPassword: Text
    var
        CryptoMgmt: Codeunit "Cryptography Management";
        Salt: Text;
        HashAlgorithm: Option MD5,SHA1,SHA256,SHA384,SHA512;

    begin
        // Generate a random salt
        //Salt := Format(CreateGuid());


        // Hash the password with the salt using SHA256
        HashAlgorithm := HashAlgorithm::SHA256;
        HashedPassword := CryptoMgmt.GenerateHash(NewPassword, HashAlgorithm);

    end;


    local procedure GetMemberTransfers(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        AccountsJson: JsonArray;
        BeneficiariesJson: JsonArray;
        TransactionsJson: JsonArray;
        TransferLimitsJson: JsonObject;
        TransferFeesJson: JsonArray;
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        SavingsAccounts: Record "Savings Accounts";
        SLedger: Record "Savings Ledger Entry";
        MemberBeneficiaries: Record "Member Beneficiaries";
        MemberNo: Code[20];
        AccountJson: JsonObject;
        SourceAccountsJson: JsonArray;
        DestinationAccountsJson: JsonArray;
        BeneficiaryJson: JsonObject;
        TransactionJson: JsonObject;
        TransferFeeJson: JsonObject;
        NumberOfDays: Integer;
        MemberId: Text;
        SessionId: Text;
        Username: Text;
        Loans: Record Loans;
    begin

        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if PortalAuth.FindFirst() then begin
            // Get Member No from Portal Auth if it exists
            MemberNo := PortalAuth."Member No.";

            // If we have a Member ID but no Member No, try to find Member No
            if not Members.Get(MemberNo) then begin
                SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
                exit(ResponseJson);
            end;


            // Get member accounts from the Savings Accounts table
            SavingsAccounts.Reset();
            SavingsAccounts.SetRange("Member No.", MemberNo);
            if SavingsAccounts.FindSet() then begin
                repeat
                    Clear(AccountJson);
                    AccountJson.Add('id', SavingsAccounts."No.");
                    AccountJson.Add('name', SavingsAccounts."Product Name");
                    AccountJson.Add('balance', SavingsAccounts.GetAvailableBalance());
                    AccountJson.Add('type', Format(SavingsAccounts."Product Category"));
                    AccountJson.Add('status', Format(SavingsAccounts.Status));
                    AccountsJson.Add(AccountJson);
                until SavingsAccounts.Next() = 0;
            end;


            // Get member accounts from the Savings Accounts table
            SavingsAccounts.Reset();
            SavingsAccounts.SetRange("Member No.", MemberNo);
            SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Ordinary Savings");
            if SavingsAccounts.FindSet() then begin
                repeat
                    Clear(AccountJson);
                    AccountJson.Add('id', SavingsAccounts."No.");
                    AccountJson.Add('name', SavingsAccounts."Product Name");
                    AccountJson.Add('balance', SavingsAccounts.GetAvailableBalance());
                    AccountJson.Add('type', Format(SavingsAccounts."Product Category"));
                    AccountJson.Add('status', Format(SavingsAccounts.Status));
                    SourceAccountsJson.Add(AccountJson);
                until SavingsAccounts.Next() = 0;
            end;



            // Get member accounts from the Savings Accounts table
            SavingsAccounts.Reset();
            SavingsAccounts.SetRange("Member No.", MemberNo);
            SavingsAccounts.Setfilter("Product Category", '<>%1&<>%2&<>%3',
                    SavingsAccounts."Product Category"::"Ordinary Savings",
                    SavingsAccounts."Product Category"::"Registration Fee",
                    SavingsAccounts."Product Category"::"Unallocated Fund"
                    );
            if SavingsAccounts.FindSet() then begin
                repeat
                    Clear(AccountJson);
                    AccountJson.Add('id', SavingsAccounts."No.");
                    AccountJson.Add('name', 'SAVINGS::' + SavingsAccounts."Product Name");
                    AccountJson.Add('balance', SavingsAccounts.GetAvailableBalance());
                    AccountJson.Add('type', Format(SavingsAccounts."Product Category"));
                    AccountJson.Add('status', Format(SavingsAccounts.Status));
                    DestinationAccountsJson.Add(AccountJson);
                until SavingsAccounts.Next() = 0;
            end;


            Loans.Reset();
            Loans.SetRange("Member No.", MemberNo);
            Loans.Setfilter("Total Outstanding Balance", '>%1', 0);
            if Loans.FindSet() then begin
                repeat
                    Loans.CalcFields("Total Outstanding Balance");
                    Clear(AccountJson);
                    AccountJson.Add('id', Loans."Loan No.");
                    AccountJson.Add('name', 'LOAN::' + Loans."Loan Product Type Name");
                    AccountJson.Add('balance', Loans."Total Outstanding Balance");
                    AccountJson.Add('type', Format(Loans."Loan Product Type"));
                    AccountJson.Add('status', Format(Loans.Status));
                    DestinationAccountsJson.Add(AccountJson);
                until Loans.Next() = 0;
            end;

            // Get member beneficiaries from the Member Beneficiaries table
            MemberBeneficiaries.Reset();
            MemberBeneficiaries.SetRange("Member No.", MemberNo);
            if MemberBeneficiaries.FindSet() then begin
                repeat
                    Clear(BeneficiaryJson);
                    BeneficiaryJson.Add('id', Format(MemberBeneficiaries."Entry No."));
                    BeneficiaryJson.Add('name', MemberBeneficiaries.Name);
                    BeneficiaryJson.Add('type', Format(MemberBeneficiaries."Type"));
                    BeneficiaryJson.Add('bank', MemberBeneficiaries.Bank);
                    BeneficiaryJson.Add('account_number', MemberBeneficiaries."Account Number");
                    BeneficiaryJson.Add('date_added', Format(Today));
                    BeneficiariesJson.Add(BeneficiaryJson);
                until MemberBeneficiaries.Next() = 0;
            end;


            // Get transaction history - last 10 transactions from Savings Ledger Entries
            NumberOfDays := 90; // Get transactions for last 90 days
            SLedger.Reset();
            SLedger.SetRange("Member No.", MemberNo);
            SLedger.SetFilter("Posting Date", '>=%1', CalcDate(StrSubstNo('<-%1D>', NumberOfDays), Today));
            SLedger.SetCurrentKey("Posting Date"); // Sort by date
            SLedger.Ascending(false); // Most recent first
            if SLedger.FindSet() then begin
                repeat
                    Clear(TransactionJson);
                    TransactionJson.Add('transaction_id', Format(SLedger."Entry No."));
                    // For transaction type, determine based on description or amount
                    if SLedger.Amount > 0 then
                        TransactionJson.Add('type', 'debit')
                    else
                        TransactionJson.Add('type', 'credit');
                    TransactionJson.Add('description', SLedger.Description);
                    TransactionJson.Add('date', Format(SLedger."Posting Date"));
                    TransactionJson.Add('amount', SLedger.Amount);
                    TransactionJson.Add('currency', 'KES'); // Default currency
                    TransactionJson.Add('status', 'Completed');
                    TransactionJson.Add('reference', SLedger."Document No.");
                    TransactionsJson.Add(TransactionJson);

                    if TransactionsJson.Count >= 10 then
                        break; // Only get last 10 transactions
                until SLedger.Next() = 0;
            end;        // If no transactions found, add sample transactions


            // Set transfer limits
            TransferLimitsJson.Add('daily_limit', 500000);
            TransferLimitsJson.Add('transaction_limit', 100000);
            TransferLimitsJson.Add('remaining_daily_limit', 495000);

            // Set transfer fees
            Clear(TransferFeeJson);
            TransferFeeJson.Add('type', 'internal');
            TransferFeeJson.Add('fee', 0);
            TransferFeesJson.Add(TransferFeeJson);

            Clear(TransferFeeJson);
            TransferFeeJson.Add('type', 'member');
            TransferFeeJson.Add('fee', 0);
            TransferFeesJson.Add(TransferFeeJson);

            Clear(TransferFeeJson);
            TransferFeeJson.Add('type', 'bank');
            TransferFeeJson.Add('fee', 55);
            TransferFeesJson.Add(TransferFeeJson);

            Clear(TransferFeeJson);
            TransferFeeJson.Add('type', 'mobile_money');
            TransferFeeJson.Add('fee', 25);
            TransferFeesJson.Add(TransferFeeJson);

            // Combine all data
            DataJson.Add('member_id', MemberNo);
            DataJson.Add('accounts', AccountsJson);
            DataJson.Add('source_accounts', SourceAccountsJson);
            DataJson.Add('destination_accounts', DestinationAccountsJson);
            DataJson.Add('beneficiaries', BeneficiariesJson);
            DataJson.Add('transactions', TransactionsJson);
            DataJson.Add('transfer_limits', TransferLimitsJson);
            DataJson.Add('transfer_fees', TransferFeesJson);

            SetResponseStatus(ResponseJson, 'success', 'Success', 'Transfer data retrieved successfully');
            ResponseJson.Add('data', DataJson);
            ResponseJson.Add('timestamp', Format(CurrentDateTime));
            exit(ResponseJson);
        end;
    end;




    local procedure ProcessInternalTransfer(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        JsonTransactionsToken: JsonToken;
        JsonTransactionArrays: JsonArray;
        JsonTokenLine: JsonToken;
        JsonTransaction: JsonObject;
        DataJson: JsonObject;
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        AccountTransfer: Record "Account Transfers";
        SourceAccounts: Record "Source Account Transfer";
        DestinationAccounts: Record "Destination Account Transfers";
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        Username: Text;
        MemberId: Text;
        SourceAccount: Text;
        TransfersArray: JsonArray;
        HeaderNo: Code[20];
        TransferCount: Integer;
        ProdName: Text[100];
        class: Text;
        PrAmt: Decimal;
        INtAmt: Decimal;
        LoanRunBal: Decimal;
        SourceAmt: Decimal;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        MemberId := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        SourceAccount := SelectJsonToken(RequestJson, '$.source_account').AsValue.AsText;
        TransfersArray := SelectJsonToken(RequestJson, '$.transfers').AsArray();

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        // Validate member exists
        if not Members.Get(MemberId) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Create transfer header once we have valid transfers
        TransferCount := 0;
        HeaderNo := '';

        // Process each transfer
        foreach JsonTokenLine in TransfersArray do begin
            JsonTransaction := JsonTokenLine.AsObject();

            // Get destination account and amount
            ProdName := '';
            class := '';

            // Validate destination account exists and get product name
            if SavingsAccounts.Get(SelectJsonToken(JsonTransaction, '$.destination_account').AsValue.AsText) then begin
                ProdName := SavingsAccounts."Product Name";
                if SavingsAccounts."Member No." = Members."No." then
                    class := 'Savings';
            end else if Loans.Get(SelectJsonToken(JsonTransaction, '$.destination_account').AsValue.AsText) then begin
                ProdName := Loans."Loan Product Type Name";
                if Loans."Member No." = Members."No." then
                    class := 'Loan';
            end;

            if class = '' then
                Error('Invalid destination account');

            // Create header for first valid transfer
            if (TransferCount = 0) and (class <> '') then begin
                AccountTransfer.Init();
                AccountTransfer."Portal Transfer" := true;
                AccountTransfer.No := '';
                AccountTransfer.Status := AccountTransfer.Status::Approved;
                AccountTransfer.Remarks := 'Portal Transfer';
                AccountTransfer.Insert(true);
                HeaderNo := AccountTransfer.No;
            end;


            SourceAmt := 0;
            if class = 'Loan' then begin
                LoanRunBal := SelectJsonToken(JsonTransaction, '$.amount').AsValue.AsDecimal();
                Loans.CalcFields("Outstanding Interest", "Outstanding Principal");
                INtAmt := Loans."Outstanding Interest";
                if INtAmt < 0 then
                    INtAmt := 0;

                if INtAmt > 0 then begin
                    if INtAmt > LoanRunBal then
                        Intamt := LoanRunBal;

                    // Create destination account entry
                    DestinationAccounts.Init();
                    DestinationAccounts."No." := HeaderNo;
                    DestinationAccounts."Member No." := Members."No.";
                    DestinationAccounts."Destination Account Type" := DestinationAccounts."Destination Account Type"::Credit;
                    DestinationAccounts.Validate("Destination Loan No.", SelectJsonToken(JsonTransaction, '$.destination_account').AsValue.AsText);

                    DestinationAccounts.Validate("Destination Amount", Intamt);
                    DestinationAccounts.Description := 'Portal Transfer from ' + SavingsAccounts."Product Name";
                    DestinationAccounts."Destination Transaction Type" := DestinationAccounts."Destination Transaction Type"::"Interest Paid";
                    DestinationAccounts.Insert();
                    LoanRunBal -= iNTaMT;
                    SourceAmt += DestinationAccounts."Destination Amount";
                end;

                IF LoanRunBal > 0 then begin
                    if LoanRunBal > Loans."Outstanding Principal" then
                        LoanRunBal := Loans."Outstanding Principal";

                    if LoanRunBal < 0 then
                        LoanRunBal := 0;

                    if LoanRunBal > 0 then begin

                        // Create destination account entry
                        DestinationAccounts.Init();
                        DestinationAccounts."No." := HeaderNo;
                        DestinationAccounts."Member No." := Members."No.";
                        DestinationAccounts."Destination Account Type" := DestinationAccounts."Destination Account Type"::Credit;
                        DestinationAccounts.Validate("Destination Loan No.", SelectJsonToken(JsonTransaction, '$.destination_account').AsValue.AsText);

                        DestinationAccounts.Validate("Destination Amount", LoanRunBal);
                        DestinationAccounts.Description := 'Portal Transfer from ' + SavingsAccounts."Product Name";
                        DestinationAccounts."Destination Transaction Type" := DestinationAccounts."Destination Transaction Type"::"Principal Repayment";
                        DestinationAccounts.Insert();
                        LoanRunBal -= iNTaMT;
                        SourceAmt += DestinationAccounts."Destination Amount";
                    end;
                End;

            end
            else begin

                SourceAmt := SelectJsonToken(JsonTransaction, '$.amount').AsValue.AsDecimal();


                // Create destination account entry
                DestinationAccounts.Init();
                DestinationAccounts."No." := HeaderNo;
                DestinationAccounts."Member No." := Members."No.";
                DestinationAccounts."Destination Account Type" := DestinationAccounts."Destination Account Type"::Savings;
                DestinationAccounts.Validate("Destination Account No.", SelectJsonToken(JsonTransaction, '$.destination_account').AsValue.AsText);
                DestinationAccounts.Validate("Destination Amount", SourceAmt);
                DestinationAccounts.Description := 'Portal Transfer from ' + SavingsAccounts."Product Name";
                DestinationAccounts.Insert();
            end;
            // Create source account entry
            SourceAccounts.Init();
            SourceAccounts."No." := HeaderNo;
            SourceAccounts."Member No." := Members."No.";
            SourceAccounts."Source Account Type" := SourceAccounts."Source Account Type"::Savings;
            SourceAccounts.Validate("Source Account No.", SourceAccount);
            SourceAccounts.Validate("Source Amount", SourceAmt);
            SourceAccounts.Description := 'Portal Transfer to ' + ProdName;
            SourceAccounts.Insert();

            TransferCount += 1;
        end;

        // Validate and post transfers
        AccountTransfer.Reset();
        AccountTransfer.SetRange(No, HeaderNo);
        AccountTransfer.SetFilter("Total Credits", '>0');
        AccountTransfer.SetFilter("Total Debits", '>0');
        if AccountTransfer.FindFirst() then begin
            PostPortalTransfers(AccountTransfer);
            SetResponseStatus(ResponseJson, 'success', 'Transfers Completed', 'Transfers processed successfully');
        end else begin
            SetResponseStatus(ResponseJson, 'error', 'Transfer Failed', 'Failed to process transfers');
        end;

        // Build response with updated account information
        DataJson.Add('transfer_id', HeaderNo);
        DataJson.Add('member_id', MemberId);
        DataJson.Add('source_account', SourceAccount);
        DataJson.Add('transfers_processed', TransferCount);
        DataJson.Add('date_processed', Format(CurrentDateTime));

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;




    local procedure PostPortalTransfers(Transfers: Record "Account Transfers")
    var
        Text0001: label 'Ensure the Transfer Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0003: label 'A transfer of ';
        Text0004: label 'The transaction has already been posted.';
        Source: Record "Source Account Transfer";
        Destination: Record "Destination Account Transfers";
        GenJournalLine: Record "Gen. Journal Line";
        MobNo: Code[20];
        Text0005: label ' has been effected on your account at ';
        RunBal: Decimal;
        Interest: Decimal;
        Lrepay: Decimal;
        SActivities: Codeunit "Sacco Activities";
        Jtemplate: Code[20];
        JBatch: Code[20];
        BalAcctType: Enum "Gen. Journal Account Type";
        Loans: Record Loans;
        DedAmt: Decimal;
        IntAmt: Decimal;
        PriAmt: Decimal;
        PenAmt: Decimal;
        Legacy: Codeunit Legacy;
        Desc: Text[100];
    begin

        if Transfers.Posted then
            Error(Text0004);

        //BankingUser.Get(UserId);

        SActivities.GetGeneralJournalTemplate(Jtemplate, JBatch);

        Transfers.CalcFields("Total Credits", "Total Debits");

        Transfers.TestField(Remarks);
        Desc := Transfers.Remarks;

        if Transfers."Total Debits" <> Transfers."Total Credits" then
            Error('Debits must be equal to credits, please cheque your schedule');

        if Transfers."Total Debits" > 0 then begin

            SActivities.JournalInit(Jtemplate, JBatch);


            Source.Reset;
            Source.SetRange(Source."No.", Transfers.No);
            if Source.Find('-') then begin
                repeat
                    if Source.Description <> '' then
                        Desc := Source.Description;
                    SActivities.JournalInsert(
                        Jtemplate,
                        JBatch,
                        Transfers.No,
                        Transfers."Transaction Date",
                        Source."Source Account Type",
                        Source."Source Account No.",
                        CopyStr(Desc, 1, 50),
                        Balaccttype::"G/L Account",
                        '',
                        (Source."Source Amount"),
                        Source."External Document No.",
                        Source."Source Loan No.",
                        Source."Source Transaction Type",
                        Transfers."Global Dimension 1 Code",
                        Transfers."Global Dimension 2 Code",
                        true,
                        Channel::Portal,
                        Transfers."Dimension Set ID"
                        );
                until Source.Next = 0;
            end;

            Destination.Reset;
            Destination.SetRange(Destination."No.", Transfers.No);
            if Destination.Find('-') then begin
                repeat

                    if Destination.Description <> '' then
                        Desc := Destination.Description;
                    if Destination."Destination Account Type" = Destination."Destination Account Type"::Savings then begin

                        SActivities.JournalInsert(
                            Jtemplate,
                            JBatch,
                            Transfers.No,
                            Transfers."Transaction Date",
                            Destination."Destination Account Type",
                            Destination."Destination Account No.",
                            CopyStr(Desc, 1, 50),
                            Balaccttype::"G/L Account",
                            '',
                            -(Destination."Destination Amount"),
                            Destination."External Document No.",
                            Destination."Destination Loan No.",
                            Destination."Destination Transaction Type",
                            Transfers."Global Dimension 1 Code",
                            Transfers."Global Dimension 2 Code",
                            true,
                        Channel::Portal,
                        Transfers."Dimension Set ID"
                            );

                    end
                    else begin
                        Loans.Get(Destination."Destination Loan No.");
                        Loans.CalcFields("Outstanding Penalty", "Outstanding Interest", "Outstanding Principal");
                        DedAmt := Destination."Destination Amount";

                        PenAmt := Loans."Outstanding Penalty";
                        if PenAmt < 0 then
                            PenAmt := 0;

                        if PenAmt > DedAmt then
                            PenAmt := DedAmt;

                        if PenAmt > 0 then begin

                            SActivities.JournalInsert(
                                Jtemplate,
                                JBatch,
                                Transfers.No,
                                Transfers."Transaction Date",
                                Destination."Destination Account Type",
                                Destination."Destination Account No.",
                                CopyStr(Desc, 1, 50),
                                Balaccttype::"G/L Account",
                                '',
                                -(PenAmt),
                                Destination."External Document No.",
                                Destination."Destination Loan No.",
                                Destination."Destination Transaction Type"::"Penalty Paid",
                                Transfers."Global Dimension 1 Code",
                                Transfers."Global Dimension 2 Code",
                                true,
                        Channel::Portal,
                        Transfers."Dimension Set ID"
                                );

                            DedAmt -= PenAmt;

                        end;

                        if DedAmt > 0 then begin

                            IntAmt := Loans."Outstanding Interest";
                            if IntAmt < 0 then
                                IntAmt := 0;

                            if IntAmt > DedAmt then
                                IntAmt := DedAmt;

                            if IntAmt > 0 then begin

                                SActivities.JournalInsert(
                                    Jtemplate,
                                    JBatch,
                                    Transfers.No,
                                    Transfers."Transaction Date",
                                    Destination."Destination Account Type",
                                    Destination."Destination Account No.",
                                    CopyStr(Desc, 1, 50),
                                    Balaccttype::"G/L Account",
                                    '',
                                    -(IntAmt),
                                    Destination."External Document No.",
                                    Destination."Destination Loan No.",
                                    Destination."Destination Transaction Type"::"Interest Paid",
                                    Transfers."Global Dimension 1 Code",
                                    Transfers."Global Dimension 2 Code",
                                    true,
                        Channel::Portal,
                        Transfers."Dimension Set ID"
                                    );

                                DedAmt -= IntAmt;

                            end;

                            if DedAmt > 0 then begin

                                PriAmt := Loans."Outstanding Principal";
                                if PriAmt < 0 then
                                    PriAmt := 0;

                                if PriAmt > DedAmt then
                                    PriAmt := DedAmt;

                                if PriAmt > 0 then begin

                                    SActivities.JournalInsert(
                                        Jtemplate,
                                        JBatch,
                                        Transfers.No,
                                        Transfers."Transaction Date",
                                        Destination."Destination Account Type",
                                        Destination."Destination Account No.",
                                        CopyStr(Desc, 1, 50),
                                        Balaccttype::"G/L Account",
                                        '',
                                        -(PriAmt),
                                        Destination."External Document No.",
                                        Destination."Destination Loan No.",
                                        Destination."Destination Transaction Type"::"Principal Repayment",
                                        Transfers."Global Dimension 1 Code",
                                        Transfers."Global Dimension 2 Code",
                                        true,
                        Channel::Portal,
                        Transfers."Dimension Set ID"
                                        );

                                    DedAmt -= PriAmt;

                                end;


                            end;



                            if DedAmt > 0 then begin


                                SActivities.JournalInsert(
                                    Jtemplate,
                                    JBatch,
                                    Transfers.No,
                                    Transfers."Transaction Date",
                                    Destination."Destination Account Type"::Savings,
                                    Legacy.GetDepositAccounts(Destination."Member No."),
                                    CopyStr(Desc, 1, 50),
                                    Balaccttype::"G/L Account",
                                    '',
                                    -(DedAmt),
                                    Destination."External Document No.",
                                    Destination."Destination Loan No.",
                                    Destination."Destination Transaction Type",
                                    Transfers."Global Dimension 1 Code",
                                    Transfers."Global Dimension 2 Code",
                                    true,
                        Channel::Portal,
                        Transfers."Dimension Set ID"
                                    );


                            end;



                        end;

                    end;
                until Destination.Next = 0;
            end;

            Transfers.Posted := true;
            Transfers.Modify;

            SActivities.JournalPost(Jtemplate, JBatch);

        end;
    end;



    local procedure GetMemberStatement(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        SavingsAccounts: Record "Savings Accounts";
        SavingsStatement: Report "Savings Statement";
        PortalSetup: Record "Portal Setup";
        Base64: Codeunit "Base64 Convert";
        DetailedStatement: Report "Summary Member Statement";
        SummaryStatement: Report "Member Statement - Summary";
        varBase64Conversion: CodeUnit "Base64 Convert";
        OStream: OutStream;
        RecRef: RecordRef;
        IStream: InStream;
        Loans: Record Loans;
        DivProg: Record "Dividends Progression";
        DataJson: JsonObject;
        SavingsArray: JsonArray;
        LoansArray: JsonArray;
        SharesArray: JsonArray;
        DividendsArray: JsonArray;
        AccountJson: JsonObject;
        ShareJson: JsonObject;
        DividendJson: JsonObject;
        MemberId: Text;
        MemberNo: Code[20];
        SessionId: Text;
        Username: Text;
        LastDueDate: Date;
        MonthlyPayment: Decimal;
        ShareCapitalAccount: Code[20];
        SharesValue: Decimal;
        SharesCount: Integer;
        SharePrice: Decimal;
        varTempBlob: CodeUnit "Temp Blob";
        LoanSchedule: Record "Loan Repayment Schedule";
        statement_type: Text;
        StartDate: Date;
        EndDate: Date;
        vConvertedContent: text;
        AccountNumber: Text;
    begin
        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        if RequestJson.Contains('account_number') then
            AccountNumber := SelectJsonToken(RequestJson, '$.account_number').AsValue.AsText;


        statement_type := SelectJsonToken(RequestJson, '$.statement_type').AsValue.AsText;

        if RequestJson.Contains('start_date') then
            StartDate := SelectJsonToken(RequestJson, '$.start_date').AsValue.AsDate;

        if RequestJson.Contains('end_date') then
            EndDate := SelectJsonToken(RequestJson, '$.end_date').AsValue.AsDate;


        if EndDate = 0D then
            EndDate := Today;
        if StartDate = 0D then
            StartDate := CalcDate('-12M', EndDate);



        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if PortalAuth.FindFirst() then begin
            // Get Member No from Portal Auth if it exists
            MemberNo := PortalAuth."Member No.";


            // If we have a Member ID but no Member No, try to find Member No
            if not Members.Get(MemberNo) then begin
                SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
                exit(ResponseJson);
            end;

            // Initialize response
            SetResponseStatus(ResponseJson, 'success', 'Account Data Retrieved', 'Account data retrieved successfully');
            ResponseJson.Add('timestamp', Format(CurrentDateTime));

            // Create data object
            DataJson.Add('member_id', MemberNo);



            vConvertedContent := '';
            if statement_type = 'full' then begin

                Members.Reset();
                Members.SetRange("No.", MemberNo);
                Members.SetRange("Date Filter", StartDate, EndDate);
                if Members.FindFirst() then begin

                    DetailedStatement.SetTableview(Members);
                    varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);
                    DetailedStatement.SaveAs('', REPORTFORMAT::Pdf, OStream);
                    varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
                    vConvertedContent := varBase64Conversion.ToBase64(IStream);


                end;
            end;

            if statement_type = 'account' then begin

                Members.Reset();
                Members.SetRange("No.", MemberNo);
                Members.SetRange("Date Filter", StartDate, EndDate);
                if Members.FindFirst() then begin

                    DetailedStatement.AccountFilter(AccountNumber);
                    DetailedStatement.SetTableview(Members);

                    varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);
                    DetailedStatement.SaveAs('', REPORTFORMAT::Pdf, OStream);
                    varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
                    vConvertedContent := varBase64Conversion.ToBase64(IStream);

                end;
            end;


            DataJson.Add('pdf_base64', vConvertedContent);


            // Add data to response
            ResponseJson.Add(Data, DataJson);
        end;

    end;



    local procedure GetLoanSchedule(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        SavingsAccounts: Record "Savings Accounts";
        SavingsStatement: Report "Savings Statement";
        PortalSetup: Record "Portal Setup";
        Base64: Codeunit "Base64 Convert";
        LoanSchedule: Report "Loan Repayment Schedule";
        SummaryStatement: Report "Member Statement - Summary";
        varBase64Conversion: CodeUnit "Base64 Convert";
        OStream: OutStream;
        RecRef: RecordRef;
        IStream: InStream;
        Loans: Record Loans;
        DivProg: Record "Dividends Progression";
        DataJson: JsonObject;
        SavingsArray: JsonArray;
        LoansArray: JsonArray;
        SharesArray: JsonArray;
        DividendsArray: JsonArray;
        AccountJson: JsonObject;
        ShareJson: JsonObject;
        DividendJson: JsonObject;
        MemberId: Text;
        MemberNo: Code[20];
        SessionId: Text;
        Username: Text;
        LastDueDate: Date;
        MonthlyPayment: Decimal;
        ShareCapitalAccount: Code[20];
        SharesValue: Decimal;
        SharesCount: Integer;
        SharePrice: Decimal;
        varTempBlob: CodeUnit "Temp Blob";
        statement_type: Text;
        StartDate: Date;
        EndDate: Date;
        vConvertedContent: text;
        LoanNumber: Text;
    begin
        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;


        LoanNumber := SelectJsonToken(RequestJson, '$.loan_number').AsValue.AsText;



        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if PortalAuth.FindFirst() then begin
            // Get Member No from Portal Auth if it exists
            MemberNo := PortalAuth."Member No.";


            // If we have a Member ID but no Member No, try to find Member No
            if not Members.Get(MemberNo) then begin
                SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
                exit(ResponseJson);
            end;

            // Initialize response
            SetResponseStatus(ResponseJson, 'success', 'Account Data Retrieved', 'Account data retrieved successfully');
            ResponseJson.Add('timestamp', Format(CurrentDateTime));

            // Create data object
            DataJson.Add('member_id', MemberNo);



            vConvertedContent := '';
            Loans.Reset();
            Loans.SetRange("Loan No.", LoanNumber);
            if Loans.FindFirst() then begin

                LoanSchedule.SetTableview(Loans);
                varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);
                LoanSchedule.SaveAs('', REPORTFORMAT::Pdf, OStream);
                varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
                vConvertedContent := varBase64Conversion.ToBase64(IStream);



                DataJson.Add('pdf_base64', vConvertedContent);


                // Add data to response
                ResponseJson.Add(Data, DataJson);
            end;

        end;

    end;



    local procedure GetLoanGuarantors(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        SavingsAccounts: Record "Savings Accounts";
        SavingsStatement: Report "Savings Statement";
        PortalSetup: Record "Portal Setup";
        Base64: Codeunit "Base64 Convert";
        LoanGuarantor: Report "Loan Guarantors Reports";
        SummaryStatement: Report "Member Statement - Summary";
        varBase64Conversion: CodeUnit "Base64 Convert";
        OStream: OutStream;
        RecRef: RecordRef;
        IStream: InStream;
        Loans: Record Loans;
        DivProg: Record "Dividends Progression";
        DataJson: JsonObject;
        SavingsArray: JsonArray;
        LoansArray: JsonArray;
        SharesArray: JsonArray;
        DividendsArray: JsonArray;
        AccountJson: JsonObject;
        ShareJson: JsonObject;
        DividendJson: JsonObject;
        MemberId: Text;
        MemberNo: Code[20];
        SessionId: Text;
        Username: Text;
        LastDueDate: Date;
        MonthlyPayment: Decimal;
        ShareCapitalAccount: Code[20];
        SharesValue: Decimal;
        SharesCount: Integer;
        SharePrice: Decimal;
        varTempBlob: CodeUnit "Temp Blob";
        statement_type: Text;
        StartDate: Date;
        EndDate: Date;
        vConvertedContent: text;
        LoanNumber: Text;
    begin
        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;


        LoanNumber := SelectJsonToken(RequestJson, '$.loan_number').AsValue.AsText;



        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if PortalAuth.FindFirst() then begin
            // Get Member No from Portal Auth if it exists
            MemberNo := PortalAuth."Member No.";


            // If we have a Member ID but no Member No, try to find Member No
            if not Members.Get(MemberNo) then begin
                SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
                exit(ResponseJson);
            end;

            // Initialize response
            SetResponseStatus(ResponseJson, 'success', 'Account Data Retrieved', 'Account data retrieved successfully');
            ResponseJson.Add('timestamp', Format(CurrentDateTime));

            // Create data object
            DataJson.Add('member_id', MemberNo);



            vConvertedContent := '';
            Members.Reset();
            Members.SetRange("No.", MemberNo);
            if Members.FindFirst() then begin
                LoanGuarantor.SetLoanFilter(LoanNumber);
                LoanGuarantor.SetTableview(Members);
                varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);
                LoanGuarantor.SaveAs('', REPORTFORMAT::Pdf, OStream);
                varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
                vConvertedContent := varBase64Conversion.ToBase64(IStream);



                DataJson.Add('pdf_base64', vConvertedContent);


                // Add data to response
                ResponseJson.Add(Data, DataJson);
            end;

        end;

    end;




    local procedure GetLoanForm(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        SavingsAccounts: Record "Savings Accounts";
        SavingsStatement: Report "Savings Statement";
        PortalSetup: Record "Portal Setup";
        Base64: Codeunit "Base64 Convert";
        LoanAppForm: Report "Online loan Application";
        SummaryStatement: Report "Member Statement - Summary";
        varBase64Conversion: CodeUnit "Base64 Convert";
        OStream: OutStream;
        RecRef: RecordRef;
        IStream: InStream;
        Loans: Record "Portal Loans";
        DivProg: Record "Dividends Progression";
        DataJson: JsonObject;
        SavingsArray: JsonArray;
        LoansArray: JsonArray;
        SharesArray: JsonArray;
        DividendsArray: JsonArray;
        AccountJson: JsonObject;
        ShareJson: JsonObject;
        DividendJson: JsonObject;
        MemberId: Text;
        MemberNo: Code[20];
        SessionId: Text;
        Username: Text;
        LastDueDate: Date;
        MonthlyPayment: Decimal;
        ShareCapitalAccount: Code[20];
        SharesValue: Decimal;
        SharesCount: Integer;
        SharePrice: Decimal;
        varTempBlob: CodeUnit "Temp Blob";
        statement_type: Text;
        StartDate: Date;
        EndDate: Date;
        vConvertedContent: text;
        LoanNumber: Text;
    begin
        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;


        LoanNumber := SelectJsonToken(RequestJson, '$.loan_number').AsValue.AsText;



        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if PortalAuth.FindFirst() then begin
            // Get Member No from Portal Auth if it exists
            MemberNo := PortalAuth."Member No.";


            // If we have a Member ID but no Member No, try to find Member No
            if not Members.Get(MemberNo) then begin
                SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
                exit(ResponseJson);
            end;

            // Initialize response
            SetResponseStatus(ResponseJson, 'success', 'Account Data Retrieved', 'Account data retrieved successfully');
            ResponseJson.Add('timestamp', Format(CurrentDateTime));

            // Create data object
            DataJson.Add('member_id', MemberNo);



            vConvertedContent := '';
            Loans.Reset();
            Loans.SetRange("Application No.", LoanNumber);
            if Loans.FindFirst() then begin

                LoanAppForm.SetTableview(Loans);
                varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);
                LoanAppForm.SaveAs('', REPORTFORMAT::Pdf, OStream);
                varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
                vConvertedContent := varBase64Conversion.ToBase64(IStream);



                DataJson.Add('pdf_base64', vConvertedContent);


                // Add data to response
                ResponseJson.Add(Data, DataJson);
            end;

        end;

    end;




    local procedure GetLoansGuaranteed(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        SavingsAccounts: Record "Savings Accounts";
        SavingsStatement: Report "Savings Statement";
        PortalSetup: Record "Portal Setup";
        Base64: Codeunit "Base64 Convert";
        LoansGuaranteed: Report "Loan Guaranteed";
        SummaryStatement: Report "Member Statement - Summary";
        varBase64Conversion: CodeUnit "Base64 Convert";
        OStream: OutStream;
        RecRef: RecordRef;
        IStream: InStream;
        Loans: Record Loans;
        DivProg: Record "Dividends Progression";
        DataJson: JsonObject;
        SavingsArray: JsonArray;
        LoansArray: JsonArray;
        SharesArray: JsonArray;
        DividendsArray: JsonArray;
        AccountJson: JsonObject;
        ShareJson: JsonObject;
        DividendJson: JsonObject;
        MemberId: Text;
        MemberNo: Code[20];
        SessionId: Text;
        Username: Text;
        LastDueDate: Date;
        MonthlyPayment: Decimal;
        ShareCapitalAccount: Code[20];
        SharesValue: Decimal;
        SharesCount: Integer;
        SharePrice: Decimal;
        varTempBlob: CodeUnit "Temp Blob";
        statement_type: Text;
        StartDate: Date;
        EndDate: Date;
        vConvertedContent: text;
        LoanNumber: Text;
    begin
        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;


        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if PortalAuth.FindFirst() then begin
            // Get Member No from Portal Auth if it exists
            MemberNo := PortalAuth."Member No.";


            // If we have a Member ID but no Member No, try to find Member No
            if not Members.Get(MemberNo) then begin
                SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
                exit(ResponseJson);
            end;

            // Initialize response
            SetResponseStatus(ResponseJson, 'success', 'Account Data Retrieved', 'Account data retrieved successfully');
            ResponseJson.Add('timestamp', Format(CurrentDateTime));

            // Create data object
            DataJson.Add('member_id', MemberNo);



            vConvertedContent := '';
            Members.Reset();
            Members.SetRange("No.", MemberNo);
            if Members.FindFirst() then begin
                LoansGuaranteed.SetTableview(Members);
                varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);
                LoansGuaranteed.SaveAs('', REPORTFORMAT::Pdf, OStream);
                varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
                vConvertedContent := varBase64Conversion.ToBase64(IStream);



                DataJson.Add('pdf_base64', vConvertedContent);


                // Add data to response
                ResponseJson.Add(Data, DataJson);
            end;

        end;

    end;


    local procedure GenerateLoanApplication(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Loans: Record "Loans";
        NoSeries: Codeunit "No. Series";
        ProductSetup: Record "Product Setup";
        Members: Record Members;
        LoanNo: Text;
        TopupLoansText: Text;
        ExistingLoan: record Loans;
        LoanTopUp: Record "POrtal Top Up";
        Found: Boolean;
        PortalLoans: Record "Portal Loans";
        PortalAuth: Record "Portal Auth";
        DataJson: JsonObject;
        MemberNo: Code[20];
        Username: Text;
        ApplicationNumber: Text;
        LoanType: Text;
        LoanAmount: Decimal;
        BasicSalary: Decimal;
        Allowances: Decimal;
        Deductions: Decimal;
        PayeAmount: Decimal;
        EnableTopup: Boolean;
        TopupLoansArray: JsonArray;
        TopupLoansList: List of [Text];
        LoanApplicationNo: Code[20];
        MaxLoanAmount: Decimal;
        InterestRate: Decimal;
        IsEligible: Boolean;
        EligibilityMessage: Text;

        NSetup: Record "Sales & Receivables Setup";
        JsonToken: JsonToken;
        TopupLoanNo: Text;
        NetSalary: Decimal;
        MaxRepaymentCapacity: Decimal;
        RepaymentRatio: Decimal;
        ApplicationDate: Date;
        TotalTopupAmount: Decimal;
        NetLoanAmount: Decimal;
        TopUpRelease: Decimal;
        i: Integer;
        ErrMsg: Text;

        Designation: Text;
        TermsOfAppointment: Text;
        FosaBranch: Text;
        DateOfAppointment: Date;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        LoanType := SelectJsonToken(RequestJson, '$.loan_type').AsValue.AsText;
        ApplicationNumber := SelectJsonToken(RequestJson, '$.application_number').AsValue.AsText;

        // Safely get loan amount
        if not Evaluate(LoanAmount, SelectJsonToken(RequestJson, '$.loan_amount').AsValue.AsText) then
            LoanAmount := 0;

        // Safely get salary information
        if not Evaluate(BasicSalary, SelectJsonToken(RequestJson, '$.basic_salary').AsValue.AsText) then
            BasicSalary := 0;

        if RequestJson.Contains('allowances') then
            if not Evaluate(Allowances, SelectJsonToken(RequestJson, '$.allowances').AsValue.AsText) then
                Allowances := 0;

        if RequestJson.Contains('deductions') then
            if not Evaluate(Deductions, SelectJsonToken(RequestJson, '$.deductions').AsValue.AsText) then
                Deductions := 0;

        if RequestJson.Contains('paye') then
            if SelectJsonToken(RequestJson, '$.paye').AsValue.AsText <> '' then
                if not Evaluate(PayeAmount, SelectJsonToken(RequestJson, '$.paye').AsValue.AsText) then
                    PayeAmount := 0;

        if RequestJson.Contains('enable_topup') then
            EnableTopup := SelectJsonToken(RequestJson, '$.enable_topup').AsValue.AsBoolean;




        if RequestJson.Contains('designation') then
            Designation := SelectJsonToken(RequestJson, '$.designation').AsValue.AsText;

        if RequestJson.Contains('terms_of_appointment') then
            TermsOfAppointment := SelectJsonToken(RequestJson, '$.terms_of_appointment').AsValue.AsText;

        if RequestJson.Contains('fosa_branch') then
            FosaBranch := SelectJsonToken(RequestJson, '$.fosa_branch').AsValue.AsText;

        if RequestJson.Contains('date_of_appointment') then
            if not Evaluate(DateOfAppointment, SelectJsonToken(RequestJson, '$.date_of_appointment').AsValue.AsText) then
                DateOfAppointment := 0D;


        // Get topup loans array if enabled
        if EnableTopup and RequestJson.Contains('topup_loans') then begin
            TopupLoansArray := SelectJsonToken(RequestJson, '$.topup_loans').AsArray;
            for i := 0 to TopupLoansArray.Count - 1 do begin
                TopupLoansArray.Get(i, JsonToken);
                TopupLoansList.Add(JsonToken.AsValue.AsText);
            end;
        end;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Validate loan product
        if not ValidateLoanProduct(LoanType, MaxLoanAmount, InterestRate) then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Loan Product', 'The specified loan product is not available');
            exit(ResponseJson);
        end;

        // Calculate net salary
        NetSalary := BasicSalary + Allowances - Deductions - PayeAmount;


        // Calculate topup amount if enabled
        TotalTopupAmount := 0;
        TopUpRelease := 0;
        if EnableTopup then
            TotalTopupAmount := CalculateTopupAmount(MemberNo, TopupLoansList, TopUpRelease);


        // Check loan eligibility
        IsEligible := CheckLoanEligibility(MemberNo, LoanType, LoanAmount, NetSalary, EligibilityMessage, TopUpRelease);
        if not IsEligible then begin
            SetResponseStatus(ResponseJson, 'error', 'Loan Eligibility Failed', EligibilityMessage);
            exit(ResponseJson);
        end;

        // Calculate net loan amount (requested amount minus topup amount)
        NetLoanAmount := LoanAmount - TotalTopupAmount;

        if NetLoanAmount < 1000 then begin
            SetResponseStatus(ResponseJson, 'error', 'Application Creation Failed', 'Loan Amount not enough to clear existing loan(s): KES ' + Format(TotalTopupAmount));
            exit(ResponseJson);
        end;

        // Generate loan application number
        LoanApplicationNo := '';
        PortalLoans.Reset();
        PortalLoans.SetRange("Member No.", MemberNo);
        PortalLoans.SetRange(Posted, false);
        PortalLoans.SetRange("Loan No.", '');
        PortalLoans.SetFilter(Status, '<>%1', PortalLoans.Status::Failed);
        if PortalLoans.FindFirst() then begin
            //SetResponseStatus(ResponseJson, 'error', 'Application Creation Failed', 'You have a pending loan application: ' + PortalLoans."Loan Name" + ', KES ' + Format(PortalLoans."Requested Amount"));
            //exit(ResponseJson);
        end;


        Loans.Reset();
        Loans.SetRange("Member No.", MemberNo);
        Loans.SetRange(Posted, false);
        Loans.SetFilter(Status, '<>%1', Loans.Status::Rejected);
        Loans.SetFilter("Loan Product Type", '<>%1', '');
        if Loans.FindFirst() then begin
            //SetResponseStatus(ResponseJson, 'error', 'Application Creation Failed', 'You have a pending loan application: ' + Loans."Loan Product Type Name" + ', KES ' + Format(Loans."Requested Amount"));
            //exit(ResponseJson);
        end;

        ErrMsg := '';
        // Create loan application record
        if ApplicationNumber = '' then begin
            NSetup.Get;
            NSetup.TestField("Portal Loan Nos");
            PortalLoans.Init();
            PortalLoans."Application No." := NoSeries.GetNextNo(NSetup."Portal Loan Nos", today, true);

            if CaptureLoanDetails(PortalLoans, ErrMsg, MemberNo, LoanType, LoanAmount, NetSalary,
                                             BasicSalary, Allowances, Deductions, PayeAmount, EnableTopup,
                                             TopupLoansList, TotalTopupAmount, NetLoanAmount) then begin

                PortalLoans."Account No" := Legacy.GetOrdinaryAccount(MemberNo);
                PortalLoans.Designation := Designation;
                PortalLoans."Terms Of Appointment" := TermsOfAppointment;
                PortalLoans.Branch := FosaBranch;
                PortalLoans."Date Of Appointment" := DateOfAppointment;

                if PortalLoans.Insert(true) then begin

                    ApplicationNumber := PortalLoans."Application No.";
                    LoanApplicationNo := ApplicationNumber;
                end
                else begin

                    SetResponseStatus(ResponseJson, 'error', 'Loan Application Creation Failed', 'Loan Application Creation Failed');
                    exit(ResponseJson);
                end;

            end
            else begin

                if ErrMsg = '' then
                    ErrMsg := 'Application Creation Failed';
                SetResponseStatus(ResponseJson, 'error', 'Application Creation Failed', ErrMsg);
                exit(ResponseJson);
            end;
        end
        else begin

            PortalLoans.Get(ApplicationNumber);

            if CaptureLoanDetails(PortalLoans, ErrMsg, MemberNo, LoanType, LoanAmount, NetSalary,
                                             BasicSalary, Allowances, Deductions, PayeAmount, EnableTopup,
                                             TopupLoansList, TotalTopupAmount, NetLoanAmount) then begin

                PortalLoans.Designation := Designation;
                PortalLoans."Terms Of Appointment" := TermsOfAppointment;
                PortalLoans.Branch := FosaBranch;
                PortalLoans."Date Of Appointment" := DateOfAppointment;

                if PortalLoans.Modify(true) then begin

                    ApplicationNumber := PortalLoans."Application No.";
                    LoanApplicationNo := ApplicationNumber;


                end
                else begin

                    SetResponseStatus(ResponseJson, 'error', 'Loan Modification Failed', 'Loan Modification Failed');
                    exit(ResponseJson);
                end;


            end
            else begin

                if ErrMsg = '' then
                    ErrMsg := 'Application Modification Failed';
                SetResponseStatus(ResponseJson, 'error', 'Application Modification Failed', ErrMsg);
                exit(ResponseJson);
            end;
        end;

        if PortalLoans.Get(ApplicationNumber) then begin


            LoanTopUp.reset();
            LoanTopUp.SetRange("Loan No.", ApplicationNumber);
            if LoanTopUp.FindFirst() then
                LoanTopUp.DeleteAll();

            // Create topup records if enabled
            if EnableTopup and (TopupLoansList.Count > 0) then begin
                foreach LoanNo in TopupLoansList do begin
                    // Get the existing loan details
                    ExistingLoan.Reset();
                    ExistingLoan.SetRange("Member No.", MemberNo);
                    ExistingLoan.SetRange("Loan No.", LoanNo);
                    ExistingLoan.SetFilter("Outstanding Principal", '>0');
                    if ExistingLoan.FindFirst() then begin
                        // Calculate fields for the existing loan
                        ExistingLoan.CalcFields("Total Outstanding Balance");

                        // Create topup record
                        LoanTopUp.Init();
                        LoanTopUp."Loan No." := ApplicationNumber;
                        LoanTopUp."Member No." := ExistingLoan."Member No.";
                        LoanTopUp.Validate("Loan Top Up", ExistingLoan."Loan No.");
                        LoanTopUp.Insert(true);
                    end;
                end;
            end;
        end;

        // Build success response
        SetResponseStatus(ResponseJson, 'success', 'Loan Application Created', 'Your loan application has been submitted successfully');

        // Create response data
        DataJson.Add('application_number', LoanApplicationNo);
        DataJson.Add('member_no', MemberNo);
        DataJson.Add('loan_type', LoanType);
        DataJson.Add('requested_amount', LoanAmount);
        DataJson.Add('net_loan_amount', NetLoanAmount);
        DataJson.Add('topup_amount', TotalTopupAmount);
        DataJson.Add('net_salary', NetSalary);
        DataJson.Add('application_date', Format(Today));
        DataJson.Add('status', 'Pending Review');
        DataJson.Add('estimated_processing_days', 3);

        DataJson.Add('designation', Designation);
        DataJson.Add('terms_of_appointment', TermsOfAppointment);
        DataJson.Add('fosa_branch', FosaBranch);
        DataJson.Add('date_of_appointment', Format(DateOfAppointment));

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;

    local procedure ValidateLoanProduct(LoanType: Text; var MaxLoanAmount: Decimal; var InterestRate: Decimal): Boolean
    var
        ProductSetup: Record "Product Setup";
    begin
        ProductSetup.Reset();
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Credit);
        ProductSetup.SetRange(Status, ProductSetup.Status::Active);
        ProductSetup.SetFilter("Description", '@' + LoanType + '*'); // Partial match

        if ProductSetup.FindFirst() then begin
            MaxLoanAmount := ProductSetup."Maximum Loan Amount";
            InterestRate := ProductSetup."Interest Rate (Max.)";
            exit(true);
        end;

        // If exact match not found, try finding by product type
        ProductSetup.Reset();
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Credit);
        ProductSetup.SetRange(Status, ProductSetup.Status::Active);
        if ProductSetup.FindFirst() then begin
            MaxLoanAmount := ProductSetup."Maximum Loan Amount";
            InterestRate := ProductSetup."Interest Rate (Max.)";
            exit(true);
        end;

        exit(false);
    end;

    local procedure CheckLoanEligibility(MemberNo: Code[20]; LoanType: Text; RequestedAmount: Decimal; NetSalary: Decimal; var EligibilityMessage: Text; TopUpRelease: Decimal): Boolean
    var
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        LoanApp: Record Loans;
        MembershipMonths: Integer;
        HasActiveLoan: Boolean;
        TotalOutstanding: Decimal;
        MaxRepaymentCapacity: Decimal;
        RepaymentRatio: Decimal;
        MinSavingsBalance: Decimal;
        MaxCredit: Decimal;
        SaccoSetup: record "Sacco Setup";
        PSetup: record "Product Setup";
        LoanSetup: record "Product Setup";
        DefaultDF: DateFormula;
        TTotalArrears: decimal;
    begin
        EligibilityMessage := '';


        if not Members.Get(MemberNo) then begin
            EligibilityMessage := 'Member record not found';
            exit(false);
        end;

        PSetup.get(LoanType);



        if PSetup."Loan Application Period" <> DefaultDF then begin
            if not Members."From Another Sacco" then
                If Members."Registration Date" <> 0D then begin
                    if CalcDate(PSetup."Loan Application Period", Members."Registration Date") > Today then begin
                        EligibilityMessage := 'Minimum Membership Period not achieved to apply this loan';
                        exit(false);
                    end;
                end;
        end;


        if TopUpRelease = 0 then begin
            if PSetup."Allow Multiple Running Loans" = false then begin
                LoanApp.Reset;
                LoanApp.SetRange("Member No.", Members."No.");
                LoanApp.SetRange("Loan Product Type", LoanType);
                LoanApp.SetFilter("Outstanding Principal", '>0');
                if LoanApp.Find('-') then begin
                    EligibilityMessage := 'You already have an existing ' + LoanApp."Loan Product Type Name";
                    exit(false);
                end;
            end;
        end;

        TTotalArrears := 0;
        if PSetup."Check Arrears" then begin
            //arrears
            LoanApp.Reset;
            LoanApp.SetRange("Member No.", Members."No.");
            LoanApp.SetFilter("Principal Arrears", '>0');
            if LoanApp.Find('-') then
                repeat
                    LoanApp.CalcFields("Total Arrears");
                    TTotalArrears += LoanApp."Total Arrears";
                until LoanApp.Next() = 0;

            if TTotalArrears > 10 then begin
                EligibilityMessage := 'You have loan arrears of KES ' + format(TTotalArrears);
                exit(false);
            end;
        end;

        MaxCredit := GetMaximumCredit(PSetup, Members."No.");
        MaxCredit += (TopUpRelease * PSetup."Deposit Multiplier");
        if RequestedAmount > MaxCredit then begin
            if MaxCredit < 0 then
                MaxCredit := 0;
            EligibilityMessage := 'You do not qualify for this amount. Current Eligibiity for this product is KES ' + format(MaxCredit);
            exit(false);
        end;

        exit(true);
    end;

    local procedure CalculateTopupAmount(MemberNo: Code[20]; TopupLoansList: List of [Text]; var TopUpRelease: Decimal): Decimal
    var
        Loans: Record Loans;
        TotalTopupAmount: Decimal;
        LoanNo: Text;
        Product: record "Product Setup";
    begin
        TotalTopupAmount := 0;
        TopUpRelease := 0;

        foreach LoanNo in TopupLoansList do begin
            Loans.Reset();
            Loans.SetRange("Member No.", MemberNo);
            Loans.SetRange("Loan No.", LoanNo);
            if Loans.FindFirst() then begin
                Loans.CalcFields("Total Outstanding Balance", "Outstanding Principal");
                TotalTopupAmount += Loans."Total Outstanding Balance";
                Product.get(Loans."Loan Product Type");
                if Product."Deposit Multiplier" > 0 then begin
                    TopUpRelease += Round(Loans."Outstanding Principal" / Product."Deposit Multiplier");
                end;
            end;
        end;

        exit(TotalTopupAmount);
    end;



    local procedure CaptureLoanDetails(var Loans: Record "Portal Loans"; var ErrMsg: Text[100]; MemberNo: Code[20]; LoanType: Text;
                                              LoanAmount: Decimal; NetSalary: Decimal; BasicSalary: Decimal;
                                              Allowances: Decimal; Deductions: Decimal; PayeAmount: Decimal;
                                              EnableTopup: Boolean; TopupLoansList: List of [Text];
                                              TotalTopupAmount: Decimal; NetLoanAmount: Decimal): Boolean
    var

        ProductSetup: Record "Product Setup";
        Members: Record Members;
        LoanNo: Text;
        TopupLoansText: Text;
        ExistingLoan: record Loans;
        LoanTopUp: Record "POrtal Top Up";
        Found: Boolean;
    begin


        // Get member details
        if not Members.Get(MemberNo) then begin
            ErrMsg := 'Member ' + MemberNo + ' Not Found ';
            exit(false);
        end;

        // Find loan product setup
        ProductSetup.Reset();
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Credit);
        ProductSetup.SetRange("Product ID", LoanType);
        if not ProductSetup.FindFirst() then begin
            ErrMsg := 'Product ' + LoanType + ' Not Found ';
            exit(false);
        end;

        Found := false;
        // When top-up is enabled, any selected running loan should satisfy the
        // top-up duplicate-loan check. The loan product does not have to match
        // the newly requested product.
        if EnableTopup and (TopupLoansList.Count > 0) then begin
            foreach LoanNo in TopupLoansList do begin
                // Get the existing loan details
                ExistingLoan.Reset();
                ExistingLoan.SetRange("Member No.", MemberNo);
                ExistingLoan.SetRange("Loan No.", LoanNo);
                ExistingLoan.SetFilter("Outstanding Principal", '>0');
                if ExistingLoan.FindFirst() then begin
                    Found := true;
                end;
            end;
        end;


        if not found then begin

            ExistingLoan.Reset();
            ExistingLoan.SetRange("Member No.", MemberNo);
            ExistingLoan.SetRange("Loan Product Type", ProductSetup."Product ID");
            ExistingLoan.SetFilter("Outstanding Principal", '>0');
            if ExistingLoan.FindFirst() then begin
                ExistingLoan.CalcFields("Total Outstanding Balance");
                ErrMsg := 'You have an existing ' + ExistingLoan."Loan Product Type Name" + ' of KES ' + Format(ExistingLoan."Total Outstanding Balance");
                exit(false);
            end;
        end;

        Loans."Loan No." := '';
        Loans."Member No." := MemberNo;
        Loans."Account Name" := Members.Name;
        Loans.Date := CurrentDateTime;
        Loans."Loan Product Type" := ProductSetup."Product ID";
        Loans."Loan Name" := ProductSetup."Description";
        Loans."Requested Amount" := LoanAmount;
        Loans."Basic Salary" := BasicSalary;
        Loans.Allowances := Allowances;
        Loans.Deductions := Deductions;
        Loans.PAYE := PayeAmount;
        //Loans.Interest := ProductSetup."Interest Rate (Max.)";
        Loans."Loan Period" := ProductSetup."Default Installments";
        //Loans."Repayment Method" := Loans."Repayment Method"::"Reducing Balance";
        Loans.Status := Loans.Status::GuarantorUpload;
        Loans.Posted := false;

        exit(true);
    end;




    local procedure CreateLoanApplicationRecord(var ErrMsg: Text; var ApplicationNo: Code[20]; MemberNo: Code[20]; LoanType: Text;
                                              LoanAmount: Decimal; NetSalary: Decimal; BasicSalary: Decimal;
                                              Allowances: Decimal; Deductions: Decimal; PayeAmount: Decimal;
                                              EnableTopup: Boolean; TopupLoansList: List of [Text];
                                              TotalTopupAmount: Decimal; NetLoanAmount: Decimal): Boolean
    var
        Loans: Record "Portal Loans";
        ProductSetup: Record "Product Setup";
        Members: Record Members;
        LoanNo: Text;
        TopupLoansText: Text;
        ExistingLoan: record Loans;
        LoanTopUp: Record "POrtal Top Up";
        Found: Boolean;
    begin
        // Get member details
        if not Members.Get(MemberNo) then
            exit(false);

        // Find loan product setup
        ProductSetup.Reset();
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Credit);
        ProductSetup.SetRange("Product ID", LoanType);
        if not ProductSetup.FindFirst() then begin
            exit(false);
        end;

        // Convert topup loans list to text
        TopupLoansText := '';
        foreach LoanNo in TopupLoansList do begin
            if TopupLoansText <> '' then
                TopupLoansText += ',';
            TopupLoansText += LoanNo;
        end;

        Found := false;
        // Create topup records if enabled
        if EnableTopup and (TopupLoansList.Count > 0) then begin
            foreach LoanNo in TopupLoansList do begin
                // Get the existing loan details
                ExistingLoan.Reset();
                ExistingLoan.SetRange("Member No.", MemberNo);
                ExistingLoan.SetRange("Loan No.", LoanNo);
                ExistingLoan.SetRange("Loan Product Type", ProductSetup."Product ID");
                ExistingLoan.SetFilter("Outstanding Principal", '>0');
                if ExistingLoan.FindFirst() then begin
                    Found := true;
                end;
            end;
        end;


        if not found then begin

            ExistingLoan.Reset();
            ExistingLoan.SetRange("Member No.", MemberNo);
            ExistingLoan.SetRange("Loan Product Type", ProductSetup."Product ID");
            ExistingLoan.SetFilter("Outstanding Principal", '>0');
            if ExistingLoan.FindFirst() then begin
                ExistingLoan.CalcFields("Total Outstanding Balance");
                ErrMsg := 'You have an existing ' + ExistingLoan."Loan Product Type Name" + ' of KES ' + Format(ExistingLoan."Total Outstanding Balance");
                exit;
            end;
        end;


        // Create loan application record
        Loans.Init();
        Loans."Loan No." := '';
        Loans."Member No." := MemberNo;
        Loans."Account Name" := Members.Name;
        Loans.Date := CurrentDateTime;
        Loans."Loan Product Type" := ProductSetup."Product ID";
        Loans."Loan Name" := ProductSetup."Description";
        Loans."Requested Amount" := LoanAmount;
        Loans."Basic Salary" := BasicSalary;
        Loans.Allowances := Allowances;
        Loans.Deductions := Deductions;
        Loans.PAYE := PayeAmount;
        //Loans.Interest := ProductSetup."Interest Rate (Max.)";
        Loans."Loan Period" := ProductSetup."Default Installments";
        //Loans."Repayment Method" := Loans."Repayment Method"::"Reducing Balance";
        Loans.Status := Loans.Status::GuarantorUpload;
        Loans.Posted := false;

        // Add salary information in comments or description fields
        //Loans.Comments := StrSubstNo('Basic Salary: %1, Allowances: %2, Deductions: %3, PAYE: %4, Net Salary: %5',
        //BasicSalary, Allowances, Deductions, PayeAmount, NetSalary);

        // Store topup information if applicable
        //if EnableTopup and (TopupLoansText <> '') then begin
        //Loans.Purpose := StrSubstNo('Topup for loans: %1, Topup Amount: %2, Net Amount: %3',
        //                         TopupLoansText, TotalTopupAmount, NetLoanAmount);
        //end;

        Loans.Insert(true);
        ApplicationNo := Loans."Application No.";



        // Create topup records if enabled
        if EnableTopup and (TopupLoansList.Count > 0) then begin
            foreach LoanNo in TopupLoansList do begin
                // Get the existing loan details
                ExistingLoan.Reset();
                ExistingLoan.SetRange("Member No.", MemberNo);
                ExistingLoan.SetRange("Loan No.", LoanNo);
                ExistingLoan.SetFilter("Outstanding Principal", '>0');
                if ExistingLoan.FindFirst() then begin
                    // Calculate fields for the existing loan
                    ExistingLoan.CalcFields("Total Outstanding Balance");

                    // Create topup record
                    LoanTopUp.Init();
                    LoanTopUp."Loan No." := ApplicationNo;
                    LoanTopUp."Member No." := ExistingLoan."Member No.";
                    LoanTopUp.Validate("Loan Top Up", ExistingLoan."Loan No.");
                    if LoanTopUp.Insert(true) then begin
                        // Log successful topup record creation
                        LogSecurityEvent('LoanTopupCreated', MemberNo,
                                       StrSubstNo('Topup record created for loan %1 with amount %2',
                                                LoanNo, ExistingLoan."Total Outstanding Balance"), false);
                    end else begin
                        // Log error but don't fail the entire process
                        LogSecurityEvent('LoanTopupFailed', MemberNo,
                                       StrSubstNo('Failed to create topup record for loan %1', LoanNo), true);
                    end;
                end;
            end;
        end;


        exit(true);
    end;


    local procedure UpdateLoanApplicationRecord(ApplicationNo: Code[20]; MemberNo: Code[20]; LoanType: Text;
                                              LoanAmount: Decimal; NetSalary: Decimal; BasicSalary: Decimal;
                                              Allowances: Decimal; Deductions: Decimal; PayeAmount: Decimal;
                                              EnableTopup: Boolean; TopupLoansList: List of [Text];
                                              TotalTopupAmount: Decimal; NetLoanAmount: Decimal): Boolean
    var
        Loans: Record "Portal Loans";
        ProductSetup: Record "Product Setup";
        Members: Record Members;
        LoanNo: Text;
        TopupLoansText: Text;
        ExistingLoan: record Loans;
        LoanTopUp: Record "POrtal Top Up";
    begin
        // Get member details
        if not Members.Get(MemberNo) then
            exit(false);

        // Find loan product setup
        ProductSetup.Reset();
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Credit);
        ProductSetup.SetRange("Product ID", LoanType);
        if not ProductSetup.FindFirst() then begin
            exit(false);
        end;

        // Convert topup loans list to text
        TopupLoansText := '';
        foreach LoanNo in TopupLoansList do begin
            if TopupLoansText <> '' then
                TopupLoansText += ',';
            TopupLoansText += LoanNo;
        end;

        // Create loan application record
        Loans.Get(ApplicationNo);
        Loans."Loan No." := '';
        Loans."Member No." := MemberNo;
        Loans."Account Name" := Members.Name;
        Loans.Date := CurrentDateTime;
        Loans."Loan Product Type" := ProductSetup."Product ID";
        Loans."Loan Name" := ProductSetup."Description";
        Loans."Requested Amount" := LoanAmount;
        //Loans.Interest := ProductSetup."Interest Rate (Max.)";
        Loans."Loan Period" := ProductSetup."Default Installments";
        Loans."Basic Salary" := BasicSalary;
        Loans.Allowances := Allowances;
        Loans.Deductions := Deductions;
        Loans.PAYE := PayeAmount;
        //Loans."Repayment Method" := Loans."Repayment Method"::"Reducing Balance";
        Loans.Posted := false;

        // Add salary information in comments or description fields
        //Loans.Comments := StrSubstNo('Basic Salary: %1, Allowances: %2, Deductions: %3, PAYE: %4, Net Salary: %5',
        //BasicSalary, Allowances, Deductions, PayeAmount, NetSalary);

        // Store topup information if applicable
        //if EnableTopup and (TopupLoansText <> '') then begin
        //Loans.Purpose := StrSubstNo('Topup for loans: %1, Topup Amount: %2, Net Amount: %3',
        //                         TopupLoansText, TotalTopupAmount, NetLoanAmount);
        //end;

        Loans.Modify(true);


        LoanTopUp.reset();
        LoanTopUp.SetRange("Loan No.", ApplicationNo);
        if LoanTopUp.FindFirst() then
            LoanTopUp.DeleteAll();

        // Create topup records if enabled
        if EnableTopup and (TopupLoansList.Count > 0) then begin
            foreach LoanNo in TopupLoansList do begin
                // Get the existing loan details
                ExistingLoan.Reset();
                ExistingLoan.SetRange("Member No.", MemberNo);
                ExistingLoan.SetRange("Loan No.", LoanNo);
                ExistingLoan.SetFilter("Outstanding Principal", '>0');
                if ExistingLoan.FindFirst() then begin
                    // Calculate fields for the existing loan
                    ExistingLoan.CalcFields("Total Outstanding Balance");

                    // Create topup record
                    LoanTopUp.Init();
                    LoanTopUp."Loan No." := ApplicationNo;
                    LoanTopUp."Member No." := ExistingLoan."Member No.";
                    LoanTopUp.Validate("Loan Top Up", ExistingLoan."Loan No.");
                    if LoanTopUp.Insert(true) then begin
                        // Log successful topup record creation
                        LogSecurityEvent('LoanTopupCreated', MemberNo,
                                       StrSubstNo('Topup record created for loan %1 with amount %2',
                                                LoanNo, ExistingLoan."Total Outstanding Balance"), false);
                    end else begin
                        // Log error but don't fail the entire process
                        LogSecurityEvent('LoanTopupFailed', MemberNo,
                                       StrSubstNo('Failed to create topup record for loan %1', LoanNo), true);
                    end;
                end;
            end;
        end;


        exit(true);
    end;

    local procedure ValidateGuarantor(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        MemberFound: Boolean;
        DataJson: JsonObject;
        SaccoLoans: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        IdentifierType: Text;
        Identifier: Text;
        CanGuarantee: Boolean;
        ReasonText: Text;
        ActiveLoansCount: Integer;
        LoansGuaranteedCount: Integer;
        SavingsBalance: Decimal;
        DepositBalance: Decimal;
        MinimumSavingsRequired: Decimal;
        MaximumGuarantorshipLimit: Integer;
        Username: Text;
        Name: Text;
        MemberNo: Code[20];
        MobileNo: Code[20];
        TotalGuaranteedAmount: Decimal;
        LoanGuarantors: Record "Loan Security";
        Legacy: Codeunit Legacy;
        MemberAct: Codeunit "Member Activities";
        PortalAuth: record "portal auth";
        ErrorMessage: text;
    begin
        // Extract request parameters
        if RequestJson.Contains('identifier_type') then
            IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;

        if RequestJson.Contains('identifier') then
            Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;



        if Identifier = '' then begin
            SetResponseStatus(ResponseJson, 'error', 'Validation Failed', 'No identifier provided');
            exit(ResponseJson);
        end;

        // Initialize response

        MemberNo := '';
        Name := SearchLoanGuarantor(Identifier, MobileNo, MemberNo);
        // Find member by identifier
        MemberFound := false;

        Members.Reset();
        Members.SetRange("No.", MemberNo);
        if (MemberNo <> '') and (Members.FindFirst()) then begin
            MemberFound := true;

            // Check if the guarantor has active loans
            SaccoLoans.Reset();
            SaccoLoans.SetRange("Member No.", Members."No.");
            SaccoLoans.SetFilter("Outstanding Principal", '>0');
            ActiveLoansCount := SaccoLoans.Count;

            // Check how many loans they are already guaranteeing
            LoanGuarantors.Reset();
            LoanGuarantors.SetRange("Member No", Members."No.");
            LoanGuarantors.SetFilter("Outstanding Principal", '>0');
            LoansGuaranteedCount := LoanGuarantors.Count;

            // Calculate total amount guaranteed
            LoanGuarantors.CalcSums("Current Committed");
            TotalGuaranteedAmount := LoanGuarantors."Current Committed";

            // Check deposit account balance
            DepositBalance := MemberAct.GetAccountBalance(Legacy.GetDepositAccounts(Members."No."));


            // Check if member can be a guarantor
            MinimumSavingsRequired := 10000; // Example threshold
            MaximumGuarantorshipLimit := 3; // Example limit

            CanGuarantee := true;
            ReasonText := '';


            // Validate guarantor's eligibility (optional - implement based on business rules)
            if not ValidateGuarantorEligibility(MemberNo, 100, POrtalAuth."Member no." = MemberNo, ErrorMessage) then begin
                SetResponseStatus(ResponseJson, 'error', 'Guarantor Not Eligible', 'Guarantor ' + Members.Name + ' found but does not meet eligibility criteria');
                exit(ResponseJson);
            end;
            /*
            // Apply business rules
            if ActiveLoansCount >= 2 then begin
                CanGuarantee := false;
                ReasonText := 'Member has too many active loans';
            end else if LoansGuaranteedCount >= MaximumGuarantorshipLimit then begin
                CanGuarantee := false;
                ReasonText := 'Member has reached maximum number of allowed guarantorships';
            end else if SavingsBalance < MinimumSavingsRequired then begin
                CanGuarantee := false;
                ReasonText := StrSubstNo('Insufficient savings balance. Minimum required: %1', Format(MinimumSavingsRequired));
            end else if (Members."Member Status" <> Members."Member Status"::Active) then begin
                CanGuarantee := false;
                ReasonText := 'Member account is not in good standing';
            end;
            */

            // Create response
            SetResponseStatus(ResponseJson, 'success', 'Member Found', 'Member validation completed');

            // Create data object with member details
            DataJson.Add('member_id', Members."No.");
            DataJson.Add('member_name', Members.Name);
            DataJson.Add('first_name', Members."First Name");
            DataJson.Add('last_name', Members.Surname);
            if Members."E-Mail" <> '' then
                DataJson.Add('email', Members."E-Mail")
            else
                DataJson.Add('email', '');
            DataJson.Add('phone_number', Members."Mobile Phone No.");
            DataJson.Add('id_number', Members."ID No.");
            DataJson.Add('is_valid_guarantor', CanGuarantee);
            DataJson.Add('reason', ReasonText);
            DataJson.Add('active_loans_count', ActiveLoansCount);
            DataJson.Add('loans_guaranteed_count', LoansGuaranteedCount);
            DataJson.Add('total_guaranteed_amount', TotalGuaranteedAmount);
            DataJson.Add('savings_balance', SavingsBalance);
            DataJson.Add('deposit_balance', DepositBalance);
            DataJson.Add('membership_status', Format(Members."Member Status"));
            DataJson.Add('membership_date', Format(Members."Registration Date"));

            ResponseJson.Add(Data, DataJson);
        end;

        if not MemberFound then
            SetResponseStatus(ResponseJson, 'error', 'Not Found', 'No member found with the provided identifier');

        exit(ResponseJson);
    end;




    local procedure ValidateWitness(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        MemberFound: Boolean;
        DataJson: JsonObject;
        SaccoLoans: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        IdentifierType: Text;
        Identifier: Text;
        CanGuarantee: Boolean;
        ReasonText: Text;
        ActiveLoansCount: Integer;
        LoansGuaranteedCount: Integer;
        SavingsBalance: Decimal;
        DepositBalance: Decimal;
        MinimumSavingsRequired: Decimal;
        MaximumGuarantorshipLimit: Integer;
        Username: Text;
        Name: Text;
        MemberNo: Code[20];
        MobileNo: Code[20];
        TotalGuaranteedAmount: Decimal;
        LoanGuarantors: Record "Loan Security";
        Legacy: Codeunit Legacy;
        MemberAct: Codeunit "Member Activities";
        PortalAuth: record "portal auth";
        ErrorMessage: text;
    begin
        // Extract request parameters
        if RequestJson.Contains('identifier_type') then
            IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;

        if RequestJson.Contains('identifier') then
            Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;



        if Identifier = '' then begin
            SetResponseStatus(ResponseJson, 'error', 'Validation Failed', 'No identifier provided');
            exit(ResponseJson);
        end;

        // Initialize response

        MemberNo := '';
        Name := SearchLoanGuarantor(Identifier, MobileNo, MemberNo);
        // Find member by identifier
        MemberFound := false;

        Members.Reset();
        Members.SetRange("No.", MemberNo);
        if (MemberNo <> '') and (Members.FindFirst()) then begin
            MemberFound := true;

            // Check if the guarantor has active loans
            SaccoLoans.Reset();
            SaccoLoans.SetRange("Member No.", Members."No.");
            SaccoLoans.SetFilter("Outstanding Principal", '>0');
            ActiveLoansCount := SaccoLoans.Count;

            // Check how many loans they are already guaranteeing
            LoanGuarantors.Reset();
            LoanGuarantors.SetRange("Member No", Members."No.");
            LoanGuarantors.SetFilter("Outstanding Principal", '>0');
            LoansGuaranteedCount := LoanGuarantors.Count;

            // Calculate total amount guaranteed
            LoanGuarantors.CalcSums("Current Committed");
            TotalGuaranteedAmount := LoanGuarantors."Current Committed";

            // Check deposit account balance
            DepositBalance := MemberAct.GetAccountBalance(Legacy.GetDepositAccounts(Members."No."));


            // Check if member can be a guarantor
            MinimumSavingsRequired := 10000; // Example threshold
            MaximumGuarantorshipLimit := 3; // Example limit

            CanGuarantee := true;
            ReasonText := '';


            /*
            // Apply business rules
            if ActiveLoansCount >= 2 then begin
                CanGuarantee := false;
                ReasonText := 'Member has too many active loans';
            end else if LoansGuaranteedCount >= MaximumGuarantorshipLimit then begin
                CanGuarantee := false;
                ReasonText := 'Member has reached maximum number of allowed guarantorships';
            end else if SavingsBalance < MinimumSavingsRequired then begin
                CanGuarantee := false;
                ReasonText := StrSubstNo('Insufficient savings balance. Minimum required: %1', Format(MinimumSavingsRequired));
            end else if (Members."Member Status" <> Members."Member Status"::Active) then begin
                CanGuarantee := false;
                ReasonText := 'Member account is not in good standing';
            end;
            */

            // Create response
            SetResponseStatus(ResponseJson, 'success', 'Member Found', 'Member validation completed');

            // Create data object with member details
            DataJson.Add('member_id', Members."No.");
            DataJson.Add('member_name', Members.Name);
            DataJson.Add('first_name', Members."First Name");
            DataJson.Add('last_name', Members.Surname);
            if Members."E-Mail" <> '' then
                DataJson.Add('email', Members."E-Mail")
            else
                DataJson.Add('email', '');
            DataJson.Add('phone_number', Members."Mobile Phone No.");
            DataJson.Add('id_number', Members."ID No.");
            DataJson.Add('is_valid_guarantor', CanGuarantee);
            DataJson.Add('reason', ReasonText);
            DataJson.Add('active_loans_count', ActiveLoansCount);
            DataJson.Add('loans_guaranteed_count', LoansGuaranteedCount);
            DataJson.Add('total_guaranteed_amount', TotalGuaranteedAmount);
            DataJson.Add('savings_balance', SavingsBalance);
            DataJson.Add('deposit_balance', DepositBalance);
            DataJson.Add('membership_status', Format(Members."Member Status"));
            DataJson.Add('membership_date', Format(Members."Registration Date"));

            ResponseJson.Add(Data, DataJson);
        end;

        if not MemberFound then
            SetResponseStatus(ResponseJson, 'error', 'Not Found', 'No member found with the provided identifier');

        exit(ResponseJson);
    end;




    procedure SearchLoanGuarantor(Identifier: Code[20]; var MobileNo: Code[20]; var MemberNo: Code[20]) Response: Text
    var
        //--LocalJsonTextWriter: dotnet JsonTextWriter;
        LocalStringWriter: Text;
        Status: Code[50];
        Payload: Text;
        ResponseTitle: Text;
        ResponseMessage: Text;
        Indent: Boolean;
        PortalAuth: Record "Portal Auth";
        "Action": Code[50];
        Members: Record Members;
        MemberImages: Record "Member Images";
        PicBase64: Text;
        Found: Boolean;
        Criteria: Code[20];
        Len: Integer;
        JsonMember: JsonObject;
        JsonMemberArray: JsonArray;
    begin

        Response := '';
        MemberNo := '';

        Members.Reset;
        Members.SetFilter("ID No.", Identifier);
        if Members.FindFirst() then begin
            Response := Members.Name;
            MobileNo := Members."Mobile Phone No.";
            MemberNo := Members."No.";
        end
        else begin

            Members.Reset;
            Members.SetFilter("No.", Identifier);
            if Members.FindFirst() then begin
                Response := Members.Name;
                MobileNo := Members."Mobile Phone No.";
                MemberNo := Members."No.";
            end
            else begin

                Members.Reset;
                Members.SetFilter("Mobile Phone No.", Identifier);
                if Members.FindFirst() then begin
                    Response := Members.Name;
                    MobileNo := Members."Mobile Phone No.";
                    MemberNo := Members."No.";
                end
                else begin

                    Len := StrLen(Identifier);
                    if Len - 8 > 0 then begin

                        Criteria := CopyStr(Identifier, Len - 8, 9);

                        Members.Reset;
                        Members.SetFilter("Mobile Phone No.", '*' + Criteria);
                        if Members.FindFirst() then begin
                            Response := Members.Name;
                            MobileNo := Members."Mobile Phone No.";
                            MemberNo := Members."No.";
                        end
                    end;
                end;
            end;
        end;
    end;


    local procedure SaveGuarantors(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalLoan: Record "Portal Loans";
        ProductSetup: Record "Product Setup";
        PortalWitness: record "Portal Loan Witness";
        PortalAuth: Record "Portal Auth";
        PortalGuarantors: Record "Portal Guarantors";
        LoanTopUp: Record "Portal Top Up";
        ExistingLoan: Record Loans;
        DataJson: JsonObject;
        MemberNo: Code[20];
        Username: Text;
        ApplicationNumber: Text;
        WitnessesArray: JsonArray;
        WitnessJson: JsonObject;
        WitnessMemberNo: Text;
        WitnessName: Text;
        WitnessPhone: Text;
        WitnessRole: Text;
        GuarantorsArray: JsonArray;
        GuarantorJson: JsonObject;
        JsonToken: JsonToken;
        GuarantorName: Text;
        GuarantorPhone: Text;
        GuarantorMemberNo: Text;
        GuaranteedAmount: Decimal;
        Relationship: Text;
        StepCompleted: Integer;
        TotalGuaranteedAmount: Decimal;
        GuaranteeCoveragePercent: Decimal;
        LoanDetailsJson: JsonObject;
        TotalTopupAmount: Decimal;
        NetLoanAmount: Decimal;
        IsUpdate: Boolean;
        i: Integer;
        LoanNo: Text;
        PortalDocs: Record "Portal Uploads";
        DocumentsArray: JsonArray;
        DocumentJson: JsonObject;
        DocumentId: Text;
        FileName: Text;
        FileSize: Integer;
        BlobPath: Text;
        FileUrl: Text;
        UploadTimestamp: Text;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        // Check if this is an update (application_number provided) or new application
        ApplicationNumber := SelectJsonToken(RequestJson, '$.application_number').AsValue.AsText;
        IsUpdate := (ApplicationNumber <> '');

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        PortalLoan.Get(ApplicationNumber);
        // Handle guarantors if provided
        if RequestJson.Contains('guarantors') then begin
            GuarantorsArray := SelectJsonToken(RequestJson, '$.guarantors').AsArray;

            PortalGuarantors.Reset();
            PortalGuarantors.SetRange("Loan Entry No.", ApplicationNumber);
            PortalGuarantors.DeleteAll();

            // Add new guarantors
            for i := 0 to GuarantorsArray.Count - 1 do begin
                GuarantorsArray.Get(i, JsonToken);
                GuarantorJson := JsonToken.AsObject;

                GuarantorName := SelectJsonToken(GuarantorJson, '$.name').AsValue.AsText;
                GuarantorPhone := SelectJsonToken(GuarantorJson, '$.phone_number').AsValue.AsText;
                GuarantorMemberNo := SelectJsonToken(GuarantorJson, '$.member_number').AsValue.AsText;

                if not Evaluate(GuaranteedAmount, SelectJsonToken(GuarantorJson, '$.guaranteed_amount').AsValue.AsText) then
                    GuaranteedAmount := 0;

                //Relationship := SelectJsonToken(GuarantorJson, '$.relationship').AsValue.AsText;

                // Create guarantor record
                if Members.Get(GuarantorMemberNo) then begin

                    PortalGuarantors.Init;
                    PortalGuarantors."Loan Entry No." := ApplicationNumber;
                    PortalGuarantors."Guarantor Mobile No." := Members."Mobile Phone No.";
                    PortalGuarantors.Validate("Guarantor Member No.", Members."No.");
                    PortalGuarantors."Loan Product" := PortalLoan."Loan Product Type";
                    PortalGuarantors."Loan Product Name" := PortalLoan."Loan Name";
                    PortalGuarantors."Guarantor Name" := Members.Name;
                    PortalGuarantors."Amount Guaranteed" := GuaranteedAmount;
                    //PortalGuarantors."Date Created":=CURRENTDATETIME;
                    PortalGuarantors.Insert;
                end;
            end;
        end;

        // Handle witnesses if provided
        if RequestJson.Contains('witnesses') then begin
            WitnessesArray := SelectJsonToken(RequestJson, '$.witnesses').AsArray;

            PortalWitness.Reset();
            PortalWitness.SetRange("Loan Application No.", ApplicationNumber);
            PortalWitness.DeleteAll();

            for i := 0 to WitnessesArray.Count - 1 do begin
                WitnessesArray.Get(i, JsonToken);
                WitnessJson := JsonToken.AsObject;

                WitnessMemberNo := SelectJsonToken(WitnessJson, '$.member_number').AsValue.AsText;
                WitnessName := SelectJsonToken(WitnessJson, '$.name').AsValue.AsText;
                WitnessPhone := SelectJsonToken(WitnessJson, '$.phone_number').AsValue.AsText;
                WitnessRole := '';
                if WitnessJson.Contains('role') then
                    WitnessRole := SelectJsonToken(WitnessJson, '$.role').AsValue.AsText;

                if Members.Get(WitnessMemberNo) then begin
                    PortalWitness.Init();
                    PortalWitness."Loan Application No." := ApplicationNumber;
                    PortalWitness."Witness No." := WitnessMemberNo;
                    PortalWitness."Witness Name" := Members.Name;
                    PortalWitness."Witness Phone" := Members."Mobile Phone No.";
                    //PortalWitness."Role" := WitnessRole;
                    PortalWitness."Date Added" := Today;
                    PortalWitness.Insert();
                end;
            end;
        end;


        // Handle application progress tracking
        StepCompleted := SelectJsonToken(RequestJson, '$.step_completed').AsValue.AsInteger;

        // Update the loan application with progress
        PortalLoan."Step Completed" := StepCompleted;

        // Update status based on step completed

        PortalLoan.Status := PortalLoan.Status::DocumentUpload;

        PortalLoan.Modify(true);

        SetResponseStatus(ResponseJson, 'success', 'Application Updated', 'Loan application has been updated successfully');

        // Create response data
        DataJson.Add('application_number', PortalLoan."Application No.");
        DataJson.Add('member_no', PortalLoan."Member No.");
        DataJson.Add('loan_type', PortalLoan."Loan Product Type");
        DataJson.Add('requested_amount', PortalLoan."Requested Amount");
        DataJson.Add('net_loan_amount', NetLoanAmount);
        DataJson.Add('topup_amount', TotalTopupAmount);
        DataJson.Add('net_salary', PortalLoan."Net Salary");
        DataJson.Add('application_date', Format(Today));
        DataJson.Add('guarantors', GuarantorsArray);
        DataJson.Add('estimated_processing_days', 3);
        DataJson.Add('step_completed', StepCompleted);
        DataJson.Add('total_guaranteed_amount', TotalGuaranteedAmount);
        DataJson.Add('guarantee_coverage_percent', GuaranteeCoveragePercent);

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;






    local procedure CompleteLoanApplication(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalLoan: Record "Portal Loans";
        ProductSetup: Record "Product Setup";
        PortalAuth: Record "Portal Auth";
        PortalGuarantors: Record "Portal Guarantors";
        LoanTopUp: Record "Portal Top Up";
        ExistingLoan: Record Loans;
        DataJson: JsonObject;
        MemberNo: Code[20];
        Username: Text;
        ApplicationNumber: Text;
        Relationship: Text;
        StepCompleted: Integer;
        TotalGuaranteedAmount: Decimal;
        GuaranteeCoveragePercent: Decimal;
        JsonToken: JsonToken;
        TotalTopupAmount: Decimal;
        NetLoanAmount: Decimal;
        IsUpdate: Boolean;
        i: Integer;
        LoanNo: Text;
        PortalDocs: Record "Portal Uploads";
        DocumentsArray: JsonArray;
        DocumentJson: JsonObject;
        DocumentId: Text;
        FileName: Text;
        FileSize: Integer;
        BlobPath: Text;
        FileUrl: Text;
        UploadTimestamp: Text;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        // Check if this is an update (application_number provided) or new application
        ApplicationNumber := SelectJsonToken(RequestJson, '$.application_number').AsValue.AsText;
        IsUpdate := (ApplicationNumber <> '');

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;


        PortalLoan.Get(ApplicationNumber);

        // Handle application progress tracking
        StepCompleted := SelectJsonToken(RequestJson, '$.step_completed').AsValue.AsInteger;

        // Update the loan application with progress
        PortalLoan."Step Completed" := StepCompleted;

        // Update status based on step completed

        PortalLoan.Status := PortalLoan.Status::"Pending Guarantor Action";


        PortalLoan.Modify(true);


        SetResponseStatus(ResponseJson, 'success', 'Application Updated', 'Loan application has been updated successfully');

        // Create response data
        DataJson.Add('application_number', ApplicationNumber);
        DataJson.Add('member_no', PortalLoan."Member No.");
        DataJson.Add('loan_type', PortalLoan."Loan Product Type");
        DataJson.Add('requested_amount', PortalLoan."Requested Amount");
        DataJson.Add('net_loan_amount', NetLoanAmount);
        DataJson.Add('topup_amount', TotalTopupAmount);
        DataJson.Add('net_salary', PortalLoan."Net Salary");
        DataJson.Add('application_date', Format(Today));

        DataJson.Add('estimated_processing_days', 3);
        DataJson.Add('step_completed', StepCompleted);
        DataJson.Add('total_guaranteed_amount', TotalGuaranteedAmount);
        DataJson.Add('guarantee_coverage_percent', GuaranteeCoveragePercent);

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;





    local procedure UpdateLoanDetails(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        PortalLoan: Record "Portal Loans";
        PortalAuth: Record "Portal Auth";
        Members: Record Members;
        Username: Text;
        MemberNo: Code[20];
        ApplicationNumber: Code[20];
        LoanProductCode: Code[20];
        LoanAmount: Decimal;
        RepaymentPeriod: Integer;
        BasicSalary: Decimal;
    begin

        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        ApplicationNumber := SelectJsonToken(RequestJson, '$.application_number').AsValue.AsText;
        LoanProductCode := SelectJsonToken(RequestJson, '$.loan_product_code').AsValue.AsText;
        //LoanProductCode := SelectJsonToken(RequestJson, '$.loan_product_code').AsValue.AsText;
        LoanAmount := SelectJsonToken(RequestJson, '$.loan_amount').AsValue.AsDecimal;
        RepaymentPeriod := SelectJsonToken(RequestJson, '$.repayment_period').AsValue.AsInteger;
        BasicSalary := SelectJsonToken(RequestJson, '$.basic_salary').AsValue.AsDecimal;


        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";

        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;


        PortalLoan.Reset();
        PortalLoan.SetRange("Application No.", ApplicationNumber);
        PortalLoan.SetRange("Member No.", MemberNo);

        if not PortalLoan.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Application Not Found', 'Loan not found');
            exit(ResponseJson);
        end;


        if (PortalLoan.Status <> PortalLoan.Status::Pending) and
   (PortalLoan.Status <> PortalLoan.Status::Open) then begin
            SetResponseStatus(ResponseJson, 'error', 'Not Editable', 'Loan cannot be modified at this stage');
            exit(ResponseJson);
        end;


        PortalLoan."Loan Product Type" := LoanProductCode;
        PortalLoan.Validate("Loan Product Type", LoanProductCode);
        //PortalLoan.Validate("Requested Amount", LoanAmount);
        PortalLoan."Requested Amount" := LoanAmount;
        //PortalLoan.Validate("Loan Period", RepaymentPeriod);
        PortalLoan."Loan Period" := RepaymentPeriod;
        //PortalLoan.Validate("Basic Salary", BasicSalary);
        PortalLoan."Basic Salary" := BasicSalary;
        PortalLoan.Modify();


        SetResponseStatus(ResponseJson, 'success', 'Updated', 'Loan product updated successfully');
        exit(ResponseJson);
    end;





    local procedure GetLoanDetails(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalLoan: Record "Portal Loans";
        ProductSetup: Record "Product Setup";
        PortalAuth: Record "Portal Auth";
        PortalGuarantors: Record "Portal Guarantors";
        PortalDocs: Record "Portal Uploads";
        PortalTopUp: Record "Portal Top Up";
        GeneralDocuments: Record "General Loan Documents";
        ProductDocuments: Record "Product Loan Documents";
        DataJson: JsonObject;
        PortalWitness: Record "Portal Loan Witness";
        WitnessJson: JsonObject;
        DocumentJson: JsonObject;
        WitnessesArray: JsonArray;
        LoanDetailsJson: JsonObject;
        GuarantorsArray: JsonArray;
        DocumentsArray: JsonArray;
        TopUpArray: JsonArray;
        DocumentRequirementsArray: JsonArray;
        LoanCalculationJson: JsonObject;
        SummaryJson: JsonObject;
        EditableSectionsJson: JsonObject;
        GuarantorJson: JsonObject;
        DocumentRequirementJson: JsonObject;
        MemberNo: Code[20];
        Username: Text;
        ApplicationNumber: Text;
        Progress: Integer;
        InterestRate: Decimal;
        MonthlyPayment: Decimal;
        TotalInterest: Decimal;
        TotalRepayment: Decimal;
        TotalGuaranteedAmount: Decimal;
        GuaranteeCoveragePercent: Decimal;
        MinimumGuaranteeRequired: Decimal;
        DocumentsComplete: Boolean;
        ReadyForReview: Boolean;
        GuaranteeStatus: Text;
        RequiredDocCount: Integer;
        UploadedDocCount: Integer;
        DocumentStatus: Text;
        Loans: record loans;
        LoanProductsArray: JsonArray;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        ApplicationNumber := SelectJsonToken(RequestJson, '$.application_number').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        //get loan products for dropdown
        GetLoanProducts(LoanProductsArray, MemberNo);
        DataJson.Add('loan_products', LoanProductsArray);
        // Get loan application details
        PortalLoan.Reset();
        PortalLoan.SetRange("Application No.", ApplicationNumber);
        PortalLoan.SetRange("Member No.", MemberNo);
        if not PortalLoan.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Application Not Found', 'Loan application not found');
            exit(ResponseJson);
        end;

        // Get product setup for interest rate and other details
        ProductSetup.Reset();
        ProductSetup.SetRange("Product ID", PortalLoan."Loan Product Type");
        if ProductSetup.FindFirst() then
            InterestRate := ProductSetup."Interest Rate (Max.)"
        else
            InterestRate := 12.5; // Default rate

        // Calculate loan metrics
        MonthlyPayment := 0;
        TotalInterest := 0;
        TotalRepayment := 0;

        // Calculate progress based on status
        case PortalLoan.Status of
            PortalLoan.Status::GuarantorUpload:
                Progress := 25;
            PortalLoan.Status::"Pending Guarantor Action":
                Progress := 50;
            PortalLoan.Status::Appraisal:
                Progress := 75;
            PortalLoan.Status::Approved:
                Progress := 100;
            else
                Progress := 10;
        end;

        // Build main data object
        DataJson.Add('application_number', ApplicationNumber);
        DataJson.Add('application_date', Format(PortalLoan.Date));
        DataJson.Add('status', Format(PortalLoan.Status));
        DataJson.Add('progress', Progress);
        DataJson.Add('member_id', MemberNo);

        // Build loan details section
        LoanDetailsJson.Add('loan_type', PortalLoan."Loan Name");
        LoanDetailsJson.Add('loan_product_code', PortalLoan."Loan Product Type");
        LoanDetailsJson.Add('loan_amount', PortalLoan."Requested Amount");
        LoanDetailsJson.Add('repayment_period', PortalLoan."Loan Period");
        LoanDetailsJson.Add('loan_purpose', PortalLoan."Loan Purpose");
        LoanDetailsJson.Add('basic_salary', PortalLoan."Basic Salary");
        LoanDetailsJson.Add('allowances', PortalLoan."Allowances");
        LoanDetailsJson.Add('deductions', PortalLoan."Deductions");
        LoanDetailsJson.Add('paye', PortalLoan."PAYE");
        LoanDetailsJson.Add('interest_rate', InterestRate);
        LoanDetailsJson.Add('monthly_payment', MonthlyPayment);
        LoanDetailsJson.Add('total_interest', TotalInterest);
        LoanDetailsJson.Add('total_repayment', TotalRepayment);


        // Build documents section
        PortalTopUp.Reset();
        PortalTopUp.SetRange("Loan No.", ApplicationNumber);
        if PortalTopUp.FindSet() then begin
            repeat
                Clear(DocumentJson);
                Loans.get(PortalTopUp."Loan Top Up");
                DocumentJson.Add('id', Format(PortalTopUp."Loan No."));
                DocumentJson.Add('top_up_loan_no', PortalTopUp."Loan Top Up");
                DocumentJson.Add('fileSize', 0); // Default as field may not exist
                DocumentJson.Add('file_size', 0);
                DocumentJson.Add('loan_product', Loans."Loan Product Type Name");
                DocumentJson.Add('total_top_up', PortalTopUp."Total Top Up");
                TopUpArray.Add(DocumentJson);
            until PortalTopUp.Next() = 0;

            LoanDetailsJson.Add('enable_topup', true); // Default as field may not exist
        end
        else
            LoanDetailsJson.Add('enable_topup', false); // Default as field may not exist
        DataJson.Add('topup_loans', TopUpArray);



        DataJson.Add('loan_details', LoanDetailsJson);

        // Build guarantors section
        TotalGuaranteedAmount := 0;
        PortalGuarantors.Reset();
        PortalGuarantors.SetRange("Loan Entry No.", ApplicationNumber);
        //PortalGuarantors.SetFilter("Guarantor Accepted", '%1|%2', PortalGuarantors."Guarantor Accepted"::Pending, PortalGuarantors."Guarantor Accepted"::Yes);
        if PortalGuarantors.FindSet() then begin
            repeat
                Clear(GuarantorJson);
                GuarantorJson.Add('id', Format(PortalGuarantors."Loan Entry No."));
                GuarantorJson.Add('name', PortalGuarantors."Guarantor Name");
                GuarantorJson.Add('phone_number', PortalGuarantors."Guarantor Mobile No.");
                GuarantorJson.Add('member_number', PortalGuarantors."Guarantor Member No.");
                GuarantorJson.Add('guaranteed_amount', PortalGuarantors."Amount Guaranteed");

                // Get additional guarantor details from Members table
                GuarantorJson.Add('id_number', '');
                GuarantorJson.Add('email', '');

                GuarantorJson.Add('guarantor_accepted', format(PortalGuarantors."Guarantor Accepted"));
                //GuarantorJson.Add('date_added', Format(PortalGuarantors."Date Created"));

                GuarantorsArray.Add(GuarantorJson);
                TotalGuaranteedAmount += PortalGuarantors."Amount Guaranteed";
            until PortalGuarantors.Next() = 0;
        end;
        DataJson.Add('guarantors', GuarantorsArray);



        // Build witnesses section
        PortalWitness.Reset();
        PortalWitness.SetRange("Loan Application No.", ApplicationNumber);
        if PortalWitness.FindSet() then begin
            repeat
                Clear(WitnessJson);
                WitnessJson.Add('witness_id', Format(PortalWitness."Witness No."));
                WitnessJson.Add('name', PortalWitness."Witness Name");
                WitnessJson.Add('member_number', PortalWitness."Witness No.");
                WitnessJson.Add('phone_number', PortalWitness."Witness Phone");
                WitnessJson.Add('date_added', Format(PortalWitness."Date Added"));

                // Get additional witness details from Members table if needed
                if Members.Get(PortalWitness."Witness No.") then begin
                    WitnessJson.Add('id_number', Members."ID No.");
                    WitnessJson.Add('email', Members."E-Mail");
                    WitnessJson.Add('relationship', ''); // Add if you have this field
                end else begin
                    WitnessJson.Add('id_number', '');
                    WitnessJson.Add('email', '');
                    WitnessJson.Add('relationship', '');
                end;

                WitnessesArray.Add(WitnessJson);
            until PortalWitness.Next() = 0;
        end;
        DataJson.Add('witnesses', WitnessesArray);


        // Build documents section
        PortalDocs.Reset();
        PortalDocs.SetRange("Loan Application No.", ApplicationNumber);
        if PortalDocs.FindSet() then begin
            repeat
                Clear(DocumentJson);
                DocumentJson.Add('id', Format(PortalDocs.ID));
                DocumentJson.Add('file_name', PortalDocs.Name);
                DocumentJson.Add('file_size', 0);
                DocumentJson.Add('blob_path', PortalDocs."Blob Name");
                DocumentJson.Add('file_url', PortalDocs."Blob Url");
                DocumentJson.Add('document_type', PortalDocs.Type);

                DocumentsArray.Add(DocumentJson);
            until PortalDocs.Next() = 0;
        end;
        DataJson.Add('documents', DocumentsArray);

        // Build document requirements section
        DocumentsComplete := true;
        RequiredDocCount := 0;
        UploadedDocCount := DocumentsArray.Count;

        // Get document requirements based on product setup
        if ProductSetup."Mandatory Documents" = ProductSetup."Mandatory Documents"::General then begin
            GeneralDocuments.Reset();
            GeneralDocuments.SetFilter(Description, '<>%1', '');
            if GeneralDocuments.FindSet() then begin
                repeat
                    RequiredDocCount += 1;
                    Clear(DocumentRequirementJson);
                    DocumentRequirementJson.Add('document_type', GeneralDocuments.Code);
                    DocumentRequirementJson.Add('display_name', GeneralDocuments.Description);
                    DocumentRequirementJson.Add('required', true);
                    DocumentRequirementJson.Add('max_files', 1);

                    // Count uploaded documents of this type
                    PortalDocs.Reset();
                    PortalDocs.SetRange("Loan Application No.", ApplicationNumber);
                    PortalDocs.SetRange(Type, GeneralDocuments.Code);
                    UploadedDocCount := PortalDocs.Count;

                    DocumentRequirementJson.Add('uploaded_count', UploadedDocCount);

                    if UploadedDocCount > 0 then
                        DocumentStatus := 'complete'
                    else begin
                        DocumentStatus := 'pending';
                        DocumentsComplete := false;
                    end;

                    DocumentRequirementJson.Add('status', DocumentStatus);
                    DocumentRequirementsArray.Add(DocumentRequirementJson);
                until GeneralDocuments.Next() = 0;
            end;
        end;

        if ProductSetup."Mandatory Documents" = ProductSetup."Mandatory Documents"::Specific then begin
            ProductDocuments.Reset();
            ProductDocuments.SetRange(Product, PortalLoan."Loan Product Type");
            ProductDocuments.SetFilter(Description, '<>%1', '');
            if ProductDocuments.FindSet() then begin
                repeat
                    RequiredDocCount += 1;
                    Clear(DocumentRequirementJson);
                    DocumentRequirementJson.Add('document_type', ProductDocuments.Code);
                    DocumentRequirementJson.Add('display_name', ProductDocuments.Description);
                    DocumentRequirementJson.Add('required', true);
                    DocumentRequirementJson.Add('max_files', 1);

                    // Count uploaded documents of this type
                    PortalDocs.Reset();
                    PortalDocs.SetRange("Loan Application No.", ApplicationNumber);
                    PortalDocs.SetRange(Type, ProductDocuments.Code);
                    UploadedDocCount := PortalDocs.Count;

                    DocumentRequirementJson.Add('uploaded_count', UploadedDocCount);

                    if UploadedDocCount > 0 then
                        DocumentStatus := 'complete'
                    else begin
                        DocumentStatus := 'pending';
                        DocumentsComplete := false;
                    end;

                    DocumentRequirementJson.Add('status', DocumentStatus);
                    DocumentRequirementsArray.Add(DocumentRequirementJson);
                until ProductDocuments.Next() = 0;
            end;
        end;

        DataJson.Add('document_requirements', DocumentRequirementsArray);

        // Build loan calculation section
        LoanCalculationJson.Add('principal_amount', PortalLoan."Requested Amount");
        LoanCalculationJson.Add('interest_rate', InterestRate);
        LoanCalculationJson.Add('repayment_period', PortalLoan."Loan Period");
        LoanCalculationJson.Add('monthly_payment', MonthlyPayment);
        LoanCalculationJson.Add('total_interest', TotalInterest);
        LoanCalculationJson.Add('total_repayment', TotalRepayment);
        DataJson.Add('loan_calculation', LoanCalculationJson);

        // Build summary section
        MinimumGuaranteeRequired := PortalLoan."Requested Amount";
        if MinimumGuaranteeRequired > 0 then
            GuaranteeCoveragePercent := (TotalGuaranteedAmount / MinimumGuaranteeRequired) * 100
        else
            GuaranteeCoveragePercent := 0;

        if GuaranteeCoveragePercent >= 100 then
            GuaranteeStatus := 'adequate'
        else if GuaranteeCoveragePercent >= 75 then
            GuaranteeStatus := 'partial'
        else
            GuaranteeStatus := 'insufficient';

        ReadyForReview := DocumentsComplete and (GuaranteeCoveragePercent >= 100);

        SummaryJson.Add('total_guaranteed_amount', TotalGuaranteedAmount);
        SummaryJson.Add('guarantee_coverage_percent', GuaranteeCoveragePercent);
        SummaryJson.Add('minimum_guarantee_required', MinimumGuaranteeRequired);
        SummaryJson.Add('guarantee_status', GuaranteeStatus);
        SummaryJson.Add('documents_complete', DocumentsComplete);
        SummaryJson.Add('ready_for_review', ReadyForReview);
        DataJson.Add('summary', SummaryJson);

        // Build editable sections
        EditableSectionsJson.Add('loan_details', PortalLoan.Status = PortalLoan.Status::Pending);
        EditableSectionsJson.Add('guarantors', PortalLoan.Status <> PortalLoan.Status::Approved);
        EditableSectionsJson.Add('documents', PortalLoan.Status <> PortalLoan.Status::Approved);
        EditableSectionsJson.Add('personal_info', false);
        DataJson.Add('editable_sections', EditableSectionsJson);

        // Build response
        SetResponseStatus(ResponseJson, 'success', 'Loan Details Retrieved', 'Loan application details retrieved successfully');
        ResponseJson.Add('timestamp', Format(CurrentDateTime));
        ResponseJson.Add('payload', DataJson);

        exit(ResponseJson);
    end;



    local procedure RemoveGuarantorFromApplication(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalLoan: Record "Portal Loans";
        PortalAuth: Record "Portal Auth";
        PortalGuarantors: Record "Portal Guarantors";
        DataJson: JsonObject;
        GuarantorsArray: JsonArray;
        GuarantorJson: JsonObject;
        MemberNo: Code[20];
        Username: Text;
        ApplicationNumber: Text;
        GuarantorId: Text;
        GuarantorFound: Boolean;
        GuarantorRemoved: Boolean;
        TotalGuaranteedAmount: Decimal;
        RemainingGuarantorsCount: Integer;
        MinimumGuarantorsRequired: Integer;
        GuaranteeCoveragePercent: Decimal;
        LoanAmount: Decimal;
        RemovedGuarantorName: Text;
        RemovedGuarantorAmount: Decimal;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        ApplicationNumber := SelectJsonToken(RequestJson, '$.application_number').AsValue.AsText;
        GuarantorId := SelectJsonToken(RequestJson, '$.guarantor_id').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Validate that the loan application exists and belongs to the member
        PortalLoan.Reset();
        PortalLoan.SetRange("Application No.", ApplicationNumber);
        PortalLoan.SetRange("Member No.", MemberNo);
        if not PortalLoan.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Application Not Found', 'Loan application not found or access denied');
            exit(ResponseJson);
        end;

        // Check if the guarantor exists for this application
        PortalGuarantors.Reset();
        PortalGuarantors.SetRange("Loan Entry No.", ApplicationNumber);
        PortalGuarantors.SetRange("Guarantor Member No.", GuarantorId);
        if PortalGuarantors.FindFirst() then begin
            PortalGuarantors.Delete();
        end
        else begin

            SetResponseStatus(ResponseJson, 'error', 'Guarantor Not Found', 'The specified guarantor is not found for this application');
            exit(ResponseJson);
        end;


        // Recalculate guarantee totals after removal
        TotalGuaranteedAmount := 0;
        PortalGuarantors.Reset();
        PortalGuarantors.SetRange("Loan Entry No.", ApplicationNumber);
        if PortalGuarantors.FindSet() then begin
            repeat
                TotalGuaranteedAmount += PortalGuarantors."Amount Guaranteed";

                // Build updated guarantors array for response
                Clear(GuarantorJson);
                GuarantorJson.Add('id', PortalGuarantors."Guarantor Member No.");
                GuarantorJson.Add('name', PortalGuarantors."Guarantor Name");
                GuarantorJson.Add('phone_number', PortalGuarantors."Guarantor Mobile No.");
                GuarantorJson.Add('member_number', PortalGuarantors."Guarantor Member No.");
                GuarantorJson.Add('guaranteed_amount', PortalGuarantors."Amount Guaranteed");
                GuarantorsArray.Add(GuarantorJson);
            until PortalGuarantors.Next() = 0;
        end;


        // Build success response
        SetResponseStatus(ResponseJson, 'success', 'Guarantor Removed', 'Guarantor has been successfully removed from the application');

        // Create response data
        DataJson.Add('application_number', ApplicationNumber);
        DataJson.Add('member_no', MemberNo);
        DataJson.Add('removed_guarantor_id', GuarantorId);
        DataJson.Add('removed_guarantor_name', RemovedGuarantorName);
        DataJson.Add('removed_guaranteed_amount', RemovedGuarantorAmount);
        DataJson.Add('remaining_guarantors_count', RemainingGuarantorsCount);
        DataJson.Add('total_guaranteed_amount', TotalGuaranteedAmount);
        DataJson.Add('guarantee_coverage_percent', GuaranteeCoveragePercent);
        DataJson.Add('minimum_guarantors_required', MinimumGuarantorsRequired);
        DataJson.Add('guarantors', GuarantorsArray);
        DataJson.Add('status', Format(PortalLoan.Status));
        DataJson.Add('last_updated', Format(CurrentDateTime));

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;


    local procedure AddWitnessToApplication(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        PortalLoan: Record "Portal Loans";
        PortalWitness: Record "Portal Loan Witness";
        DataJson: JsonObject;
        WitnessDataJson: JsonObject;
        MemberNo: Code[20];
        Username: Text;
        ApplicationNumber: Text;
        WitnessMemberNo: Text;
        WitnessName: Text;
        WitnessPhone: Text;
        WitnessRole: Text;
        WitnessId: Integer;
        WitnessEmail: Text;
        WitnessAdded: Boolean;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        ApplicationNumber := SelectJsonToken(RequestJson, '$.application_number').AsValue.AsText;
        WitnessDataJson := SelectJsonToken(RequestJson, '$.witness_data').AsObject;

        WitnessMemberNo := SelectJsonToken(WitnessDataJson, '$.member_number').AsValue.AsText;
        WitnessName := SelectJsonToken(WitnessDataJson, '$.name').AsValue.AsText;
        WitnessRole := '';
        if WitnessDataJson.Contains('role') then
            WitnessRole := SelectJsonToken(WitnessDataJson, '$.role').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Validate that the loan application exists and belongs to the member
        PortalLoan.Reset();
        PortalLoan.SetRange("Application No.", ApplicationNumber);
        PortalLoan.SetRange("Member No.", MemberNo);
        if not PortalLoan.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Application Not Found', 'Loan application not found or access denied');
            exit(ResponseJson);
        end;

        // Optionally, check if witness already exists for this application
        PortalWitness.Reset();
        PortalWitness.SetRange("Loan Application No.", ApplicationNumber);
        PortalWitness.SetRange("Witness No.", WitnessMemberNo);
        if PortalWitness.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Duplicate Witness', 'This witness is already added to the application');
            exit(ResponseJson);
        end;

        // Optionally, get witness email if member exists
        WitnessEmail := '';
        if Members.Get(WitnessMemberNo) then
            WitnessEmail := Members."E-Mail";

        // Insert witness record
        PortalWitness.Init();
        PortalWitness."Loan Application No." := ApplicationNumber;
        PortalWitness."Witness No." := WitnessMemberNo;
        PortalWitness."Witness Name" := Members.Name;
        PortalWitness."Witness Phone" := Members."Mobile Phone No.";
        //PortalWitness."Role" := WitnessRole;
        PortalWitness."Date Added" := Today;
        PortalWitness.Insert(true);

        // Build response
        SetResponseStatus(ResponseJson, 'success', 'Witness Added', 'Witness has been successfully added to the application');
        DataJson.Add('application_number', ApplicationNumber);
        DataJson.Add('witness_member_number', WitnessMemberNo);
        DataJson.Add('witness_name', Members.Name);
        DataJson.Add('witness_phone', Members."Mobile Phone No.");
        DataJson.Add('witness_email', WitnessEmail);
        DataJson.Add('role', WitnessRole);
        DataJson.Add('date_added', Format(CurrentDateTime));

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));
        exit(ResponseJson);
    end;

    local procedure AddGuarantorToApplication(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalLoan: Record "Portal Loans";
        PortalAuth: Record "Portal Auth";
        PortalGuarantors: Record "Portal Guarantors";
        GuarantorMember: Record Members;
        DataJson: JsonObject;
        GuarantorsArray: JsonArray;
        GuarantorJson: JsonObject;
        GuarantorDataJson: JsonObject;
        MemberNo: Code[20];
        Username: Text;
        ApplicationNumber: Text;
        GuarantorMemberNo: Text;
        GuarantorName: Text;
        GuarantorPhone: Text;
        GuaranteedAmount: Decimal;
        GuarantorExists: Boolean;
        TotalGuaranteedAmount: Decimal;
        GuaranteeCoveragePercent: Decimal;
        LoanAmount: Decimal;
        MaximumGuarantorsAllowed: Integer;
        CurrentGuarantorsCount: Integer;
        MinimumGuaranteeAmount: Decimal;
        MaximumGuaranteeAmount: Decimal;
        ErrorMessage: Text;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        ApplicationNumber := SelectJsonToken(RequestJson, '$.application_number').AsValue.AsText;

        // Get guarantor data
        GuarantorDataJson := SelectJsonToken(RequestJson, '$.guarantor_data').AsObject;
        GuarantorMemberNo := SelectJsonToken(GuarantorDataJson, '$.member_number').AsValue.AsText;
        GuarantorName := SelectJsonToken(GuarantorDataJson, '$.name').AsValue.AsText;
        GuarantorPhone := SelectJsonToken(GuarantorDataJson, '$.phone_number').AsValue.AsText;

        if not Evaluate(GuaranteedAmount, SelectJsonToken(GuarantorDataJson, '$.guaranteed_amount').AsValue.AsText) then
            GuaranteedAmount := 0;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Validate that the loan application exists and belongs to the member
        PortalLoan.Reset();
        PortalLoan.SetRange("Application No.", ApplicationNumber);
        PortalLoan.SetRange("Member No.", MemberNo);
        if not PortalLoan.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Application Not Found', 'Loan application not found or access denied');
            exit(ResponseJson);
        end;

        // Validate guarantor member exists
        if not GuarantorMember.Get(GuarantorMemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Guarantor Not Found', 'The specified guarantor member does not exist');
            exit(ResponseJson);
        end;


        // Check if guarantor already exists for this application
        PortalGuarantors.Reset();
        PortalGuarantors.SetRange("Loan Entry No.", ApplicationNumber);
        PortalGuarantors.SetRange("Guarantor Member No.", GuarantorMemberNo);
        GuarantorExists := PortalGuarantors.FindFirst();

        if GuarantorExists then begin
            SetResponseStatus(ResponseJson, 'error', 'Guarantor Already Added', 'This guarantor has already been added to the application');
            exit(ResponseJson);
        end;

        // Business rule validations
        MaximumGuarantorsAllowed := 5; // Default maximum
        MinimumGuaranteeAmount := 1000; // Default minimum
        LoanAmount := PortalLoan."Requested Amount";
        MaximumGuaranteeAmount := LoanAmount; // Cannot guarantee more than loan amount

        // Count current guarantors
        PortalGuarantors.Reset();
        PortalGuarantors.SetRange("Loan Entry No.", ApplicationNumber);
        CurrentGuarantorsCount := PortalGuarantors.Count;



        // Validate guarantor's eligibility (optional - implement based on business rules)
        if not ValidateGuarantorEligibility(GuarantorMemberNo, GuaranteedAmount, GuarantorMemberNo = MemberNo, ErrorMessage) then begin
            SetResponseStatus(ResponseJson, 'error', 'Guarantor Not Eligible', 'Guarantor does not meet eligibility criteria');
            exit(ResponseJson);
        end;

        // Create guarantor record
        PortalGuarantors.Init();
        PortalGuarantors."Loan Entry No." := ApplicationNumber;
        PortalGuarantors."Guarantor Mobile No." := GuarantorMember."Mobile Phone No.";
        PortalGuarantors.Validate("Guarantor Member No.", GuarantorMember."No.");
        PortalGuarantors."Loan Product" := PortalLoan."Loan Product Type";
        PortalGuarantors."Loan Product Name" := PortalLoan."Loan Name";
        PortalGuarantors."Guarantor Name" := GuarantorMember.Name;
        PortalGuarantors."Amount Guaranteed" := GuaranteedAmount;
        PortalGuarantors.Insert(true);

        // Recalculate guarantee totals
        TotalGuaranteedAmount := 0;
        PortalGuarantors.Reset();
        PortalGuarantors.SetRange("Loan Entry No.", ApplicationNumber);
        if PortalGuarantors.FindSet() then begin
            repeat
                TotalGuaranteedAmount += PortalGuarantors."Amount Guaranteed";

                // Build guarantors array for response
                Clear(GuarantorJson);
                GuarantorJson.Add('id', PortalGuarantors."Guarantor Member No.");
                GuarantorJson.Add('name', PortalGuarantors."Guarantor Name");
                GuarantorJson.Add('phone_number', PortalGuarantors."Guarantor Mobile No.");
                GuarantorJson.Add('member_number', PortalGuarantors."Guarantor Member No.");
                GuarantorJson.Add('guaranteed_amount', PortalGuarantors."Amount Guaranteed");
                GuarantorsArray.Add(GuarantorJson);
            until PortalGuarantors.Next() = 0;
        end;

        PortalLoan.Status := PortalLoan.Status::"Pending Guarantor Action";


        PortalLoan.Modify(true);

        // Log the guarantor addition
        LogSecurityEvent('GuarantorAdded', Username,
                        StrSubstNo('Guarantor %1 (%2) added to application %3. Amount: %4',
                                 GuarantorName, GuarantorMemberNo, ApplicationNumber, GuaranteedAmount), false);

        // Build success response
        SetResponseStatus(ResponseJson, 'success', 'Guarantor Added', 'Guarantor has been successfully added to the application');

        // Create response data
        DataJson.Add('application_number', ApplicationNumber);
        DataJson.Add('member_no', MemberNo);
        DataJson.Add('added_guarantor_id', GuarantorMemberNo);
        DataJson.Add('added_guarantor_name', GuarantorName);
        DataJson.Add('added_guaranteed_amount', GuaranteedAmount);
        DataJson.Add('total_guarantors_count', CurrentGuarantorsCount + 1);
        DataJson.Add('total_guaranteed_amount', TotalGuaranteedAmount);
        DataJson.Add('guarantee_coverage_percent', GuaranteeCoveragePercent);
        DataJson.Add('maximum_guarantors_allowed', MaximumGuarantorsAllowed);
        DataJson.Add('guarantors', GuarantorsArray);
        DataJson.Add('status', Format(PortalLoan.Status));
        DataJson.Add('last_updated', Format(CurrentDateTime));

        // Add validation flags
        DataJson.Add('can_add_more_guarantors', (CurrentGuarantorsCount + 1) < MaximumGuarantorsAllowed);
        DataJson.Add('adequate_guarantee_coverage', GuaranteeCoveragePercent >= 100);
        DataJson.Add('ready_for_submission', GuaranteeCoveragePercent >= 100);

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;



    local procedure SaveDocumentInfo(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalLoan: Record "Portal Loans";
        PortalAuth: Record "Portal Auth";
        PortalDocs: Record "Portal Uploads";
        DataJson: JsonObject;
        DocumentDataJson: JsonObject;
        MemberNo: Code[20];
        Username: Text;
        ApplicationNumber: Text;
        DocumentType: Text;
        FileName: Text;
        FileSize: Integer;
        BlobPath: Text;
        FileUrl: Text;
        UploadTimestamp: Text;
        DocumentId: Integer;
        ExistingDocument: Boolean;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        ApplicationNumber := SelectJsonToken(RequestJson, '$.application_number').AsValue.AsText;

        // Get document data
        DocumentDataJson := SelectJsonToken(RequestJson, '$.document_data').AsObject;
        DocumentType := SelectJsonToken(DocumentDataJson, '$.document_type').AsValue.AsText;
        FileName := SelectJsonToken(DocumentDataJson, '$.file_name').AsValue.AsText;

        if DocumentDataJson.Contains('file_size') then
            FileSize := SelectJsonToken(DocumentDataJson, '$.file_size').AsValue.AsInteger;

        BlobPath := SelectJsonToken(DocumentDataJson, '$.blob_path').AsValue.AsText;
        FileUrl := SelectJsonToken(DocumentDataJson, '$.file_url').AsValue.AsText;

        if DocumentDataJson.Contains('upload_timestamp') then
            UploadTimestamp := SelectJsonToken(DocumentDataJson, '$.upload_timestamp').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Validate that the loan application exists and belongs to the member
        PortalLoan.Reset();
        PortalLoan.SetRange("Application No.", ApplicationNumber);
        PortalLoan.SetRange("Member No.", MemberNo);
        if not PortalLoan.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Application Not Found', 'Loan application not found or access denied');
            exit(ResponseJson);
        end;

        // Check if document of this type already exists for this application

        // Create new document record
        PortalDocs.Init();
        PortalDocs.GUID := CreateGuid();
        PortalDocs.Date := Today;
        PortalDocs.Time := Time;
        PortalDocs."Member No." := Members."No.";
        PortalDocs."Member Name" := Members.Name;
        PortalDocs.Type := DocumentType;
        PortalDocs.Name := FileName;
        PortalDocs.Path := FileUrl;
        PortalDocs.Status := PortalDocs.Status::Pending;
        PortalDocs."Blob Name" := BlobPath;
        PortalDocs."Blob Url" := FileUrl;
        PortalDocs."Loan Application No." := ApplicationNumber;
        PortalDocs.Insert(true);
        DocumentId := PortalDocs.ID;

        // Log the document save action
        LogSecurityEvent('DocumentSaved', Username,
                        StrSubstNo('Document %1 (%2) saved for application %3. File: %4',
                                 DocumentType, DocumentId, ApplicationNumber, FileName), false);

        SetResponseStatus(ResponseJson, 'success', 'Document Saved', 'Document information has been saved successfully');

        // Create response data
        DataJson.Add('application_number', ApplicationNumber);
        DataJson.Add('member_no', MemberNo);
        DataJson.Add('document_id', DocumentId);
        DataJson.Add('document_type', DocumentType);
        DataJson.Add('file_name', FileName);
        DataJson.Add('file_size', FileSize);
        DataJson.Add('blob_path', BlobPath);
        DataJson.Add('file_url', FileUrl);
        DataJson.Add('upload_timestamp', UploadTimestamp);
        DataJson.Add('status', Format(PortalDocs.Status));
        DataJson.Add('date_saved', Format(CurrentDateTime));
        DataJson.Add('is_update', ExistingDocument);

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;

    local procedure DeleteDocumentInfo(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalLoan: Record "Portal Loans";
        PortalAuth: Record "Portal Auth";
        PortalDocs: Record "Portal Uploads";
        DataJson: JsonObject;
        DocumentDataJson: JsonObject;
        MemberNo: Code[20];
        Username: Text;
        ApplicationNumber: Text;
        DocumentId: Text;
        DocumentType: Text;
        BlobPath: Text;
        DocumentFound: Boolean;
        DocumentDeleted: Boolean;
        DeletedDocumentName: Text;
        RemainingDocumentsCount: Integer;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        ApplicationNumber := SelectJsonToken(RequestJson, '$.application_number').AsValue.AsText;

        // Get document data
        DocumentDataJson := SelectJsonToken(RequestJson, '$.document_data').AsObject;
        DocumentId := SelectJsonToken(DocumentDataJson, '$.document_id').AsValue.AsText;
        DocumentType := SelectJsonToken(DocumentDataJson, '$.document_type').AsValue.AsText;
        BlobPath := SelectJsonToken(DocumentDataJson, '$.blob_path').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Validate that the loan application exists and belongs to the member
        PortalLoan.Reset();
        PortalLoan.SetRange("Application No.", ApplicationNumber);
        PortalLoan.SetRange("Member No.", MemberNo);
        if not PortalLoan.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Application Not Found', 'Loan application not found or access denied');
            exit(ResponseJson);
        end;

        // Find the document to delete
        DocumentFound := false;
        PortalDocs.Reset();
        PortalDocs.SetRange("Loan Application No.", ApplicationNumber);
        PortalDocs.SetRange("Blob Name", BlobPath);
        if PortalDocs.FindFirst() then begin
            PortalDocs.Delete();
        end
        else begin

            SetResponseStatus(ResponseJson, 'error', 'Document Not Found', 'Document not found');
            exit(ResponseJson);
        end;


        // Log the document deletion
        LogSecurityEvent('DocumentDeleted', Username,
                        StrSubstNo('Document %1 (%2) deleted from application %3. File: %4',
                                 DocumentType, DocumentId, ApplicationNumber, DeletedDocumentName), false);

        // Build success response
        SetResponseStatus(ResponseJson, 'success', 'Document Deleted', 'Document has been successfully deleted');

        // Create response data
        DataJson.Add('application_number', ApplicationNumber);
        DataJson.Add('member_no', MemberNo);
        DataJson.Add('deleted_document_id', DocumentId);
        DataJson.Add('deleted_document_type', DocumentType);
        DataJson.Add('deleted_document_name', DeletedDocumentName);
        DataJson.Add('remaining_documents_count', RemainingDocumentsCount);
        DataJson.Add('blob_path', BlobPath);
        DataJson.Add('date_deleted', Format(CurrentDateTime));

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;




    // 2. Add the function to your codeunit:

    local procedure GetApplicationDocuments(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        PortalUploads: Record "Portal Uploads";
        DataJson: JsonObject;
        DocumentsArray: JsonArray;
        DocumentJson: JsonObject;
        Identifier: Text;
        ApplicationNumber: Text;
        MemberNo: Code[20];
    begin
        // Extract parameters
        if RequestJson.Contains('identifier') then
            Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        if RequestJson.Contains('application_number') then
            ApplicationNumber := SelectJsonToken(RequestJson, '$.application_number').AsValue.AsText;

        // Default: use identifier as MemberNo
        MemberNo := Identifier;

        // Query Portal Uploads for documents linked to this application and member
        PortalUploads.Reset();
        PortalUploads.SetRange("Member No.", MemberNo);
        PortalUploads.SetRange("Loan Application No.", ApplicationNumber);
        if PortalUploads.FindSet() then begin
            repeat


                Clear(DocumentJson);
                DocumentJson.Add('blobPath', PortalUploads."Blob Name");
                DocumentJson.Add('fileName', PortalUploads.Name);
                DocumentJson.Add('fileUrl', PortalUploads."Blob Url");
                DocumentsArray.Add(DocumentJson);
            until PortalUploads.Next() = 0;
        end;

        DataJson.Add('application_number', ApplicationNumber);
        DataJson.Add('documents', DocumentsArray);

        SetResponseStatus(ResponseJson, 'success', 'Documents Retrieved', 'Application documents retrieved successfully');
        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));
        exit(ResponseJson);
    end;



    local procedure GetLoansToGuarantee(MemberNo: Code[20]; var LoansToGuaranteeArray: JsonArray)
    var
        LoansToGuaranteeJson: JsonObject;
        LoansGuarantors: Record "Portal Guarantors";
        LoansPending: Record "Portal Loans";
        Applicant: Record Members;
        RequiredGuarantors: Integer;
        CurrentGuarantors: Integer;
        OutstandingGuaranteeAmount: Decimal;
        Deadline: DateTime;
    begin

        // Find loans with status "Pending Guarantors" where this member is not already a guarantor
        LoansGuarantors.Reset();
        LoansGuarantors.SetRange("Guarantor Member No.", MemberNo);
        LoansGuarantors.SetRange("Guarantor Accepted", LoansGuarantors."Guarantor Accepted"::Pending);
        LoansGuarantors.Setfilter("Loan Status", '%1|%2', LoansGuarantors."Loan Status"::"Pending Guarantor Action", LoansGuarantors."Loan Status"::DocumentUpload);
        if LoansGuarantors.FindSet() then begin
            repeat

                LoansPending.Get(LoansGuarantors."Loan Entry No.");

                // Not already a guarantor, so eligible
                Clear(LoansToGuaranteeJson);
                LoansToGuaranteeJson.Add('application_id', LoansPending."Application No.");

                // Get applicant info
                if Applicant.Get(LoansPending."Member No.") then begin
                    LoansToGuaranteeJson.Add('applicant_name', Applicant.Name);
                    LoansToGuaranteeJson.Add('applicant_member_number', Applicant."No.");
                end else begin
                    LoansToGuaranteeJson.Add('applicant_name', '');
                    LoansToGuaranteeJson.Add('applicant_member_number', LoansPending."Member No.");
                end;

                LoansToGuaranteeJson.Add('loan_type', LoansPending."Loan Name");
                LoansToGuaranteeJson.Add('loan_amount', LoansPending."Requested Amount");
                LoansToGuaranteeJson.Add('amount_guaranteed', LoansGuarantors."Amount Guaranteed");
                LoansToGuaranteeJson.Add('repayment_period', LoansPending."Loan Period");
                LoansToGuaranteeJson.Add('application_date', Format(LoansPending."Date"));
                LoansToGuaranteeJson.Add('status', 'Pending Guarantors');

                LoansToGuaranteeArray.Add(LoansToGuaranteeJson);

            until LoansGuarantors.Next() = 0;
        end;
    end;





    local procedure ProcessWitnessResponse(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        Loans: Record "Portal Loans";
        LoanWitness: Record "Portal Loan Witness";
        PortalAuth: Record "Portal Auth";
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        Username: Text;
        GuarantorAction: Text;
        GuaranteedAmount: Decimal;
        GuarantorMemberId: Code[20];
        ApplicationId: Code[20];
        MemberNo: Code[20];
        LoanFound: Boolean;
        GuarantorEntryExists: Boolean;
        NextEntryNo: Integer;
        SavingsBalance: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        CanGuarantee: Boolean;
        ErrorMessage: Text;
        RequiredGuarantors: Integer;
        CurrentGuarantors: Integer;
    begin
        // Extract request parameters
        if RequestJson.Contains('identifier_type') then
            IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;

        if RequestJson.Contains('identifier') then
            Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        if RequestJson.Contains('witness_action') then
            GuarantorAction := SelectJsonToken(RequestJson, '$.witness_action').AsValue.AsText;


        if RequestJson.Contains('witness_member_id') then
            GuarantorMemberId := CopyStr(SelectJsonToken(RequestJson, '$.witness_member_id').AsValue.AsText, 1, 20);

        if RequestJson.Contains('application_id') then
            ApplicationId := CopyStr(SelectJsonToken(RequestJson, '$.application_id').AsValue.AsText, 1, 20);

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";

        // Verify that the guarantor member ID matches the session member
        if MemberNo <> GuarantorMemberId then begin
            SetResponseStatus(ResponseJson, 'error', 'Authorization Failed', 'You can only respond for your own witness requests');
            exit(ResponseJson);
        end;

        // Validate that the member exists
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Find the loan application
        Loans.Reset();
        Loans.SetRange("Application No.", ApplicationId);
        LoanFound := Loans.FindFirst();
        if not LoanFound then begin
            SetResponseStatus(ResponseJson, 'error', 'Application Not Found', 'Loan application not found');
            exit(ResponseJson);
        end;

        // Check if guarantor entry already exists
        LoanWitness.Reset();
        LoanWitness.SetRange("Loan Application No.", ApplicationId);
        LoanWitness.SetRange("Witness Approved", LoanWitness."Witness Approved"::Pending);
        LoanWitness.SetRange("Witness No.", MemberNo);
        GuarantorEntryExists := LoanWitness.FindFirst();

        case GuarantorAction of
            'accept':
                begin




                    // Create or update guarantor record
                    if GuarantorEntryExists then begin
                        // Update existing record
                        LoanWitness."Witness Approved" := LoanWitness."Witness Approved"::Yes;
                        LoanWitness."Date Approved" := Today;
                        LoanWitness.Modify(true);
                    end else begin
                        ErrorMessage := 'You do not exist as a witness';
                        SetResponseStatus(ResponseJson, 'error', 'Witness Not Found', ErrorMessage);
                        exit(ResponseJson);
                    end;

                    SetResponseStatus(ResponseJson, 'success', 'Witness Accepted', 'You have successfully accepted the witness request');

                    // Build response data
                    DataJson.Add('action', 'accepted');
                    DataJson.Add('application_id', ApplicationId);
                    DataJson.Add('winess_member_id', MemberNo);
                    DataJson.Add('loan_status', Format(Loans.Status));


                end;

            'reject':
                begin
                    // Create or update guarantor record with rejection
                    if GuarantorEntryExists then begin
                        // Update existing record
                        LoanWitness."Witness Approved" := LoanWitness."Witness Approved"::No;
                        LoanWitness."Date Approved" := Today;
                        LoanWitness.Modify(true);
                        LoanWitness.Modify(true);
                    end else begin

                        ErrorMessage := 'You do not exist as a guarantor';
                        SetResponseStatus(ResponseJson, 'error', 'Guarantor Not Found', ErrorMessage);
                        exit(ResponseJson);
                    end;

                    SetResponseStatus(ResponseJson, 'success', 'Witness Rejected', 'You have successfully rejected the witness request');

                    // Build response data
                    DataJson.Add('action', 'rejected');
                    DataJson.Add('application_id', ApplicationId);
                    DataJson.Add('guarantor_member_id', MemberNo);
                    DataJson.Add('message', 'Your response has been recorded. The applicant will be notified.');
                end;

            else begin
                SetResponseStatus(ResponseJson, 'error', 'Invalid Action', 'Guarantor action must be either "accept" or "reject"');
                exit(ResponseJson);
            end;
        end;

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));
        exit(ResponseJson);
    end;


    local procedure ProcessGuarantorResponse(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        Loans: Record "Portal Loans";
        LoanGuarantors: Record "Portal Guarantors";
        PortalAuth: Record "Portal Auth";
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        Username: Text;
        GuarantorAction: Text;
        GuaranteedAmount: Decimal;
        GuarantorMemberId: Code[20];
        ApplicationId: Code[20];
        MemberNo: Code[20];
        LoanFound: Boolean;
        GuarantorEntryExists: Boolean;
        NextEntryNo: Integer;
        SavingsBalance: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        CanGuarantee: Boolean;
        ErrorMessage: Text;
        RequiredGuarantors: Integer;
        CurrentGuarantors: Integer;
    begin
        // Extract request parameters
        if RequestJson.Contains('identifier_type') then
            IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;

        if RequestJson.Contains('identifier') then
            Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        if RequestJson.Contains('guarantor_action') then
            GuarantorAction := SelectJsonToken(RequestJson, '$.guarantor_action').AsValue.AsText;

        if RequestJson.Contains('guaranteed_amount') then
            Evaluate(GuaranteedAmount, SelectJsonToken(RequestJson, '$.guaranteed_amount').AsValue.AsText);

        if RequestJson.Contains('guarantor_member_id') then
            GuarantorMemberId := CopyStr(SelectJsonToken(RequestJson, '$.guarantor_member_id').AsValue.AsText, 1, 20);

        if RequestJson.Contains('application_id') then
            ApplicationId := CopyStr(SelectJsonToken(RequestJson, '$.application_id').AsValue.AsText, 1, 20);

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";

        // Verify that the guarantor member ID matches the session member
        if MemberNo <> GuarantorMemberId then begin
            SetResponseStatus(ResponseJson, 'error', 'Authorization Failed', 'You can only respond for your own guarantorship requests');
            exit(ResponseJson);
        end;

        // Validate that the member exists
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Find the loan application
        Loans.Reset();
        Loans.SetRange("Application No.", ApplicationId);
        LoanFound := Loans.FindFirst();
        if not LoanFound then begin
            SetResponseStatus(ResponseJson, 'error', 'Application Not Found', 'Loan application not found');
            exit(ResponseJson);
        end;

        // Check if guarantor entry already exists
        LoanGuarantors.Reset();
        LoanGuarantors.SetRange("Loan Entry No.", ApplicationId);
        LoanGuarantors.SetRange("Guarantor Member No.", MemberNo);
        LoanGuarantors.SetRange("Guarantor Accepted", LoanGuarantors."Guarantor Accepted"::Pending);
        GuarantorEntryExists := LoanGuarantors.FindFirst();

        case GuarantorAction of
            'accept':
                begin
                    // Validate guarantor eligibility before accepting
                    CanGuarantee := ValidateGuarantorEligibility(MemberNo, GuaranteedAmount, LoanGuarantors."Guarantor Member No." = Loans."Member No.", ErrorMessage);

                    if not CanGuarantee then begin
                        SetResponseStatus(ResponseJson, 'error', 'Eligibility Check Failed', ErrorMessage);
                        exit(ResponseJson);
                    end;

                    // Create or update guarantor record
                    if GuarantorEntryExists then begin
                        // Update existing record
                        LoanGuarantors."Guarantor Accepted" := LoanGuarantors."Guarantor Accepted"::Yes;
                        LoanGuarantors."Amount Guaranteed" := GuaranteedAmount;
                        LoanGuarantors."Guarantor Response Date" := Today;
                        LoanGuarantors."Guarantor Response Time" := Time;
                        LoanGuarantors.Modify(true);
                    end else begin
                        ErrorMessage := 'You do not exist as a guarantor';
                        SetResponseStatus(ResponseJson, 'error', 'Guarantor Not Found', ErrorMessage);
                        exit(ResponseJson);
                    end;



                    LoanGuarantors.Reset();
                    LoanGuarantors.SetRange("Loan Entry No.", Loans."Application No.");
                    LoanGuarantors.SetRange(LoanGuarantors."Guarantor Accepted", LoanGuarantors."Guarantor Accepted"::Yes);
                    if LoanGuarantors.FindFirst() then begin
                        if LoanGuarantors.Count >= Loans."Expected Guarantors" then begin
                            LoanGuarantors.CalcSums("Amount Guaranteed");
                            if LoanGuarantors."Amount Guaranteed" >= Loans."Requested Amount" then begin
                                Loans.Status := Loans.status::Appraisal;
                                Loans.Modify();
                            end;
                        end;
                    end;

                    SetResponseStatus(ResponseJson, 'success', 'Guarantorship Accepted', 'You have successfully accepted the guarantorship request');

                    // Build response data
                    DataJson.Add('action', 'accepted');
                    DataJson.Add('application_id', ApplicationId);
                    DataJson.Add('guarantor_member_id', MemberNo);
                    DataJson.Add('guaranteed_amount', GuaranteedAmount);
                    DataJson.Add('loan_status', Format(Loans.Status));


                end;

            'reject':
                begin
                    // Create or update guarantor record with rejection
                    if GuarantorEntryExists then begin
                        // Update existing record
                        LoanGuarantors."Guarantor Accepted" := LoanGuarantors."Guarantor Accepted"::No;
                        LoanGuarantors."Amount Guaranteed" := 0;
                        LoanGuarantors."Guarantor Response Date" := Today;
                        LoanGuarantors."Guarantor Response Time" := Time;
                        LoanGuarantors.Modify(true);
                    end else begin

                        ErrorMessage := 'You do not exist as a guarantor';
                        SetResponseStatus(ResponseJson, 'error', 'Guarantor Not Found', ErrorMessage);
                        exit(ResponseJson);
                    end;

                    SetResponseStatus(ResponseJson, 'success', 'Guarantorship Rejected', 'You have successfully rejected the guarantorship request');

                    // Build response data
                    DataJson.Add('action', 'rejected');
                    DataJson.Add('application_id', ApplicationId);
                    DataJson.Add('guarantor_member_id', MemberNo);
                    DataJson.Add('message', 'Your response has been recorded. The applicant will be notified.');
                end;

            else begin
                SetResponseStatus(ResponseJson, 'error', 'Invalid Action', 'Guarantor action must be either "accept" or "reject"');
                exit(ResponseJson);
            end;
        end;

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));
        exit(ResponseJson);
    end;

    local procedure ValidateGuarantorEligibility(MemberNo: Code[20]; GuaranteedAmount: Decimal; SelfGuarantee: boolean; var ErrorMessage: Text): Boolean
    var
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        LoanGuarantors: Record "Loan Security";
        CurrentSavingsBalance: Decimal;
        TotalGuaranteedAmount: Decimal;
        MaxGuaranteeLimit: Decimal;
        ActiveGuarantorships: Integer;
        MaxGuarantorships: Integer;
        Legacy: codeunit Legacy;
        Employer: record Customer;
        "DepositMultiplier": decimal;
        "ApplicationAmountGuaranteed": decimal;
        "TotalGuarantorCommitment": decimal;
        "AvailableGuarantorship": decimal;
    begin
        ErrorMessage := '';
        MaxGuarantorships := 3; // Maximum number of loans a member can guarantee

        if not Members.Get(MemberNo) then begin
            ErrorMessage := 'Member record not found';
            exit(false);
        end;

        // Check if member account is in good standing
        if (Members."Member Status" <> Members."Member Status"::Active) then begin
            ErrorMessage := 'Member Not Active';
            exit(false);
        end;

        SavingsAccounts.get(Legacy.GetDepositAccounts(MemberNo));

        if (SavingsAccounts."Status" <> SavingsAccounts."Status"::Active) then begin
            ErrorMessage := 'Deposit Account is not Active';
            exit(false);
        end;


        if Employer.Get(Members."Employer Code") then begin
            if Employer."Cannot Guarantee" then begin
                ErrorMessage := 'Members under ' + Employer.Name + ' are not allowed to Guarantee';
                exit(false);
            end;
        end;


        LoanGuarantors.CalculateAvailableShares(SavingsAccounts, "DepositMultiplier", "ApplicationAmountGuaranteed", "TotalGuarantorCommitment", "AvailableGuarantorship", "SelfGuarantee");

        if GuaranteedAmount > AvailableGuarantorship then begin
            ErrorMessage := 'Cannot Guarantee More than  ' + Format(AvailableGuarantorship);
            exit(false);
        end;



        exit(true);
    end;



    local procedure CalculateLoanWithSchedule(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        CalculationDataJson: JsonObject;
        ScheduleArray: JsonArray;
        ScheduleJson: JsonObject;
        SummaryJson: JsonObject;
        PdfMetadataJson: JsonObject;
        Members: Record Members;
        Loans: Record Loans;
        Schedule: Record "Loan Repayment Schedule";
        PSetup: Record "Product Setup";
        SActivity: Codeunit "Sacco Activities";
        LSchedule: Report "Loan Repayment Schedule";
        varTempBlob: Codeunit "Temp Blob";
        varBase64Conversion: Codeunit "Base64 Convert";
        OStream: OutStream;
        IStream: InStream;
        vConvertedContent: Text;

        IdentifierType: Text;
        Identifier: Text;
        Username: Text;
        LoanType: Code[20];
        LoanAmount: Decimal;
        RepaymentPeriod: Integer;
        GeneratePdf: Boolean;

        InterestRate: Decimal;
        MonthlyPayment: Decimal;
        TotalAmount: Decimal;
        TotalInterest: Decimal;
        TotalPrincipalPayments: Decimal;
        TotalInterestPayments: Decimal;
        CurrentBalance: Decimal;
        MonthlyInterest: Decimal;
        MonthlyPrincipal: Decimal;
        LoanTypeName: Text;
        PdfFilename: Text;
        PdfSize: Integer;
        i: Integer;
    begin
        // Extract request parameters
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        LoanType := CopyStr(SelectJsonToken(RequestJson, '$.loan_type').AsValue.AsText, 1, 20);
        LoanAmount := SelectJsonToken(RequestJson, '$.loan_amount').AsValue.AsDecimal;
        RepaymentPeriod := SelectJsonToken(RequestJson, '$.repayment_period').AsValue.AsInteger;

        // Check if PDF generation is requested
        if RequestJson.Contains('generate_pdf') then
            GeneratePdf := SelectJsonToken(RequestJson, '$.generate_pdf').AsValue.AsText = 'True'
        else
            GeneratePdf := false;

        // Validate member exists
        if not Members.Get(Identifier) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Member does not exist');
            exit(ResponseJson);
        end;

        // Get loan product details
        if not PSetup.Get(LoanType) then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Loan Type', 'Loan product not found');
            exit(ResponseJson);
        end;

        // Set loan product details
        LoanTypeName := PSetup.Description;
        InterestRate := PSetup."Interest Rate (Max.)";



        // Calculate monthly payment using standard loan formula
        // PMT = P * [r(1+r)^n] / [(1+r)^n - 1]

        if Loans.get(Members."No.") then begin
            Loans."Loan Calculator" := true;
            Loans."Loan No." := Members."No.";
            Loans."Member No." := Identifier;
            Loans."Member Name" := Members.Name;
            Loans."Loan Product Type" := LoanType;
            Loans.Validate("Loan Product Type");
            Loans.Validate("Requested Amount", LoanAmount);
            Loans.Validate(Installments, RepaymentPeriod);
            Loans.Validate("Disbursement Date", Today);
            Loans.Modify();
        end
        else begin

            Loans.Init();
            Loans."Loan Calculator" := true;
            Loans."Loan No." := Members."No.";
            Loans."Member No." := Identifier;
            Loans."Member Name" := Members.Name;
            Loans."Loan Product Type" := LoanType;
            Loans.Validate("Loan Product Type");
            Loans.Validate("Requested Amount", LoanAmount);
            Loans.Validate(Installments, RepaymentPeriod);
            Loans.Validate("Disbursement Date", Today);
            Loans.Insert();
        end;

        // Create temporary loan record for calculation

        // Generate repayment schedule
        SActivity.GenerateRepaymentSchedule(Loans);

        // Build schedule array from generated schedule
        CurrentBalance := LoanAmount;
        TotalPrincipalPayments := 0;
        TotalInterestPayments := 0;

        MonthlyPayment := 0;
        TotalAmount := 0;
        TotalInterest := 0;

        Schedule.Reset();
        Schedule.SetRange("Loan No.", Loans."Loan No.");
        Schedule.SetCurrentKey("Repayment Date");
        if Schedule.FindSet() then begin
            MonthlyPayment := Schedule."Monthly Repayment";
            repeat
                TotalAmount += Schedule."Monthly Repayment";
                TotalInterest += Schedule."Monthly Interest";
                TotalInterestPayments += Schedule."Monthly Interest";
                TotalPrincipalPayments += Schedule."Monthly Principal";
                Clear(ScheduleJson);
                ScheduleJson.Add('month', Schedule."Line No.");
                ScheduleJson.Add('payment', Round(Schedule."Monthly Repayment", 0.01));
                ScheduleJson.Add('principal', Round(Schedule."Monthly Principal", 0.01));
                ScheduleJson.Add('interest', Round(Schedule."Monthly Interest", 0.01));
                ScheduleJson.Add('balance', Round(Schedule."Loan Balance", 0.01));

                ScheduleArray.Add(ScheduleJson);
            until Schedule.Next() = 0;
        end;

        // Generate PDF if requested
        vConvertedContent := '';
        Loans.Reset();
        Loans.SetRange("Loan No.", Members."No.");
        if Loans.FindFirst() then begin
            LSchedule.SetTableview(Loans);
            varTempBlob.CreateOutStream(OStream, TextEncoding::UTF8);
            LSchedule.SaveAs('', ReportFormat::Pdf, OStream);
            varTempBlob.CreateInStream(IStream, TextEncoding::UTF8);
            vConvertedContent := varBase64Conversion.ToBase64(IStream);

            // Calculate PDF metadata
            PdfFilename := StrSubstNo('loan_calculation_schedule_%1_%2_%3months.pdf', LoanType, Format(LoanAmount, 0, '<Integer>'), RepaymentPeriod);
            PdfSize := varTempBlob.Length();
        end;

        /*
        // Clean up temporary records
        Schedule.Reset();
        Schedule.SetRange("Loan No.", Loans."Loan No.");
        if Schedule.FindFirst() then
            Schedule.DeleteAll();
        Loans.Delete();
        
        */

        // Build calculation data response
        CalculationDataJson.Add('loan_type', LoanType);
        CalculationDataJson.Add('loan_type_name', LoanTypeName);
        CalculationDataJson.Add('principal', Round(LoanAmount, 0.01));
        CalculationDataJson.Add('interest_rate', InterestRate);
        CalculationDataJson.Add('repayment_period', RepaymentPeriod);
        CalculationDataJson.Add('monthly_payment', Round(MonthlyPayment, 0.01));
        CalculationDataJson.Add('total_amount', Round(TotalAmount, 0.01));
        CalculationDataJson.Add('total_interest', Round(TotalInterest, 0.01));
        CalculationDataJson.Add('schedule', ScheduleArray);

        // Build summary
        SummaryJson.Add('total_principal_payments', Round(TotalPrincipalPayments, 0.01));
        SummaryJson.Add('total_interest_payments', Round(TotalInterestPayments, 0.01));
        SummaryJson.Add('effective_interest_rate', InterestRate);
        SummaryJson.Add('loan_to_income_ratio', ''); // Add if available
        SummaryJson.Add('calculated_at', Format(CurrentDateTime));

        CalculationDataJson.Add('summary', SummaryJson);

        // Add calculation data to main response
        DataJson.Add('calculation_data', CalculationDataJson);

        // Add PDF data if generated
        DataJson.Add('pdf_base64', vConvertedContent);

        PdfMetadataJson.Add('filename', PdfFilename);
        PdfMetadataJson.Add('size_bytes', PdfSize);
        PdfMetadataJson.Add('generated_at', Format(CurrentDateTime));

        DataJson.Add('pdf_metadata', PdfMetadataJson);


        SetResponseStatus(ResponseJson, 'success', 'Loan Calculation Completed', 'Loan calculation and schedule generated successfully');
        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;



    // Add this new procedure at the end of the codeunit
    local procedure GetLoanApplicationDetails(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalLoan: Record "Portal Loans";
        PortalAuth: Record "Portal Auth";
        PortalGuarantors: Record "Portal Guarantors";
        PortalDocs: Record "Portal Uploads";
        ProductSetup: Record "Product Setup";
        //NextOfKin: Record "Next of Kin.";
        NextOfKin: Record Nominee;
        DataJson: JsonObject;
        ApplicantDetailsJson: JsonObject;
        EmploymentDetailsJson: JsonObject;
        LoanDetailsJson: JsonObject;
        GuarantorsArray: JsonArray;
        WitnessesArray: JsonArray;
        DocumentsArray: JsonArray;
        SaccoDetailsJson: JsonObject;
        WorkflowJson: JsonObject;
        WorkflowHistoryArray: JsonArray;
        AdditionalInfoJson: JsonObject;
        GuarantorJson: JsonObject;
        DocumentJson: JsonObject;
        WorkflowStepJson: JsonObject;
        MemberNo: Code[20];
        Username: Text;
        ApplicationNumber: Text;
        Identifier: Text;
        IdentifierType: Text;
        Progress: Integer;
        InterestRate: Decimal;
        MonthlyPayment: Decimal;
        ProcessingFee: Decimal;
        InsurancePremium: Decimal;
        TotalLoanCost: Decimal;
        SharesBalance: Decimal;
        SavingsBalance: Decimal;
        LoanHistoryCount: Integer;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        ApplicationNumber := SelectJsonToken(RequestJson, '$.application_number').AsValue.AsText;

        if RequestJson.Contains('identifier') then
            Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        if RequestJson.Contains('identifier_type') then
            IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Get loan application details
        PortalLoan.Reset();
        PortalLoan.SetRange("Application No.", ApplicationNumber);
        PortalLoan.SetRange("Member No.", MemberNo);
        if not PortalLoan.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Application Not Found', 'Loan application not found or access denied');
            exit(ResponseJson);
        end;

        // Get product setup details
        ProductSetup.Reset();
        ProductSetup.SetRange("Product ID", PortalLoan."Loan Product Type");
        if ProductSetup.FindFirst() then begin
            InterestRate := ProductSetup."Interest Rate (Max.)";
            ProcessingFee := 0;
        end;

        // Calculate loan details
        MonthlyPayment := CalculateMonthlyPayment(PortalLoan."Requested Amount", InterestRate, PortalLoan."Loan Period");
        InsurancePremium := PortalLoan."Requested Amount" * 0.005; // 0.5% of loan amount
        TotalLoanCost := PortalLoan."Requested Amount" + ProcessingFee + InsurancePremium;

        // Get member financial details
        SharesBalance := SkyMbanking.GetAccountBalance(Legacy.GetShareCapitalAccount(MemberNo));
        SavingsBalance := SkyMbanking.GetAccountBalance(Legacy.GetDepositAccounts(MemberNo));

        // Count loan history
        LoanHistoryCount := 0; // You can implement this based on your loan history tracking

        // Build applicant details
        ApplicantDetailsJson.Add('applicant_name', Members.Name);
        ApplicantDetailsJson.Add('first_name', Members."First Name");
        ApplicantDetailsJson.Add('middle_name', ''); // Add if available
        ApplicantDetailsJson.Add('last_name', Members.Surname);
        ApplicantDetailsJson.Add('id_number', Members."ID No.");
        ApplicantDetailsJson.Add('date_of_birth', yyyyMMdd(Members."Date of Birth"));
        ApplicantDetailsJson.Add('phone_number', Members."Mobile Phone No.");
        ApplicantDetailsJson.Add('email', Members."E-Mail");
        ApplicantDetailsJson.Add('po_box', Members."Post Code");
        ApplicantDetailsJson.Add('postal_code', Members."Post Code");
        ApplicantDetailsJson.Add('physical_address', Members.Address);
        ApplicantDetailsJson.Add('staff_number', Members."Payroll/Staff No.");
        ApplicantDetailsJson.Add('pin_number', Members."KRA PIN");
        ApplicantDetailsJson.Add('member_since', Format(Members."Registration Date"));

        // Build employment details
        EmploymentDetailsJson.Add('employer', Members."Employer Code");
        EmploymentDetailsJson.Add('designation', Format(Members."Terms of Employment"));
        EmploymentDetailsJson.Add('employment_type', 'Permanent'); // Default or get from member data
        EmploymentDetailsJson.Add('appointment_date', Format(Members."Registration Date"));
        EmploymentDetailsJson.Add('basic_salary', PortalLoan."Basic Salary");
        EmploymentDetailsJson.Add('allowances', PortalLoan.Allowances);
        EmploymentDetailsJson.Add('gross_salary', PortalLoan."Basic Salary" + PortalLoan.Allowances);
        EmploymentDetailsJson.Add('deductions', PortalLoan.Deductions);
        EmploymentDetailsJson.Add('net_salary', PortalLoan."Basic Salary" + PortalLoan.Allowances - PortalLoan.Deductions - PortalLoan.PAYE);
        EmploymentDetailsJson.Add('paye', PortalLoan.PAYE);
        EmploymentDetailsJson.Add('hr_officer_name', ''); // Add if available
        EmploymentDetailsJson.Add('hr_designation', ''); // Add if available
        EmploymentDetailsJson.Add('company_phone', ''); // Add if available

        // Build loan details
        LoanDetailsJson.Add('loan_type', PortalLoan."Loan Name");
        LoanDetailsJson.Add('loan_type_code', PortalLoan."Loan Product Type");
        LoanDetailsJson.Add('loan_amount', PortalLoan."Requested Amount");
        LoanDetailsJson.Add('loan_amount_words', ConvertAmountToWords(PortalLoan."Requested Amount"));
        LoanDetailsJson.Add('repayment_period', PortalLoan."Loan Period");
        LoanDetailsJson.Add('interest_rate', InterestRate);
        LoanDetailsJson.Add('monthly_installment', MonthlyPayment);
        LoanDetailsJson.Add('loan_purpose', PortalLoan."Loan Purpose");
        LoanDetailsJson.Add('commencement_date', Format(CalcDate('<+1M>', Today)));
        LoanDetailsJson.Add('maturity_date', Format(CalcDate(StrSubstNo('<+%1M>', PortalLoan."Loan Period"), CalcDate('<+1M>', Today))));
        LoanDetailsJson.Add('processing_fee', ProcessingFee);
        LoanDetailsJson.Add('insurance_premium', InsurancePremium);
        LoanDetailsJson.Add('total_loan_cost', TotalLoanCost);

        // Build guarantors array
        PortalGuarantors.Reset();
        PortalGuarantors.SetRange("Loan Entry No.", ApplicationNumber);
        if PortalGuarantors.FindSet() then begin
            repeat
                Clear(GuarantorJson);
                GuarantorJson.Add('guarantor_id', PortalGuarantors."Guarantor Member No.");
                GuarantorJson.Add('name', PortalGuarantors."Guarantor Name");
                GuarantorJson.Add('member_number', PortalGuarantors."Guarantor Member No.");
                GuarantorJson.Add('phone_number', PortalGuarantors."Guarantor Mobile No.");
                GuarantorJson.Add('id_number', ''); // Add if available
                GuarantorJson.Add('email', ''); // Add if available
                GuarantorJson.Add('guaranteed_amount', PortalGuarantors."Amount Guaranteed");
                GuarantorJson.Add('status', Format(PortalGuarantors.Status));
                //GuarantorJson.Add('date_added', Format(PortalGuarantors."Date Created"));
                //GuarantorJson.Add('relationship', PortalGuarantors.Relationship);
                GuarantorsArray.Add(GuarantorJson);
            until PortalGuarantors.Next() = 0;
        end;

        // Build documents array
        PortalDocs.Reset();
        PortalDocs.SetRange("Member No.", MemberNo);
        PortalDocs.SetRange("Loan Application No.", ApplicationNumber);
        if PortalDocs.FindSet() then begin
            repeat
                Clear(DocumentJson);
                DocumentJson.Add('document_id', Format(PortalDocs.GUID));
                DocumentJson.Add('document_type', PortalDocs.Type);
                DocumentJson.Add('document_name', PortalDocs.Name);
                DocumentJson.Add('file_name', PortalDocs.Name);
                DocumentJson.Add('file_size', 0); // Add if available
                DocumentJson.Add('upload_date', Format(PortalDocs.Date));
                DocumentJson.Add('status', Format(PortalDocs.Status));
                DocumentJson.Add('azure_blob_path', PortalDocs."Blob Name");
                DocumentsArray.Add(DocumentJson);
            until PortalDocs.Next() = 0;
        end;

        // Build SACCO details
        SaccoDetailsJson.Add('position_in_sacco', 'Member');
        SaccoDetailsJson.Add('fosa_branch', Members."Global Dimension 2 Code");
        SaccoDetailsJson.Add('membership_date', Format(Members."Registration Date"));
        SaccoDetailsJson.Add('shares_balance', SharesBalance);
        SaccoDetailsJson.Add('savings_balance', SavingsBalance);
        SaccoDetailsJson.Add('loan_history_count', LoanHistoryCount);
        SaccoDetailsJson.Add('last_loan_date', ''); // Add if available
        SaccoDetailsJson.Add('credit_score', 'Good'); // Default or calculate

        // Build workflow information
        //Progress := CalculateApplicationProgress(PortalLoan.Status);
        //WorkflowJson.Add('current_step', GetCurrentWorkflowStep(PortalLoan.Status));
        //WorkflowJson.Add('next_step', GetNextWorkflowStep(PortalLoan.Status));
        //WorkflowJson.Add('progress_percentage', Progress);
        //WorkflowJson.Add('estimated_completion', Format(CalcDate('<+5D>', Today)));

        // Add workflow history
        //BuildWorkflowHistory(PortalLoan, WorkflowHistoryArray);
        //WorkflowJson.Add('workflow_history', WorkflowHistoryArray);

        // Build additional info
        AdditionalInfoJson.Add('topup_enabled', false); // Add logic for topup
        //AdditionalInfoJson.Add('topup_loans', CreateJsonArray()); // Empty for now
        //AdditionalInfoJson.Add('special_conditions', CreateJsonArray()); // Empty for now
        AdditionalInfoJson.Add('internal_notes', 'Application under review');
        AdditionalInfoJson.Add('risk_rating', 'Medium');
        AdditionalInfoJson.Add('collateral_required', false);
        AdditionalInfoJson.Add('insurance_required', true);

        // Build main response
        DataJson.Add('application_number', ApplicationNumber);
        DataJson.Add('application_status', Format(PortalLoan.Status));
        DataJson.Add('application_date', Format(PortalLoan.Date));
        DataJson.Add('member_id', MemberNo);
        DataJson.Add('member_number', MemberNo);
        DataJson.Add('applicant_details', ApplicantDetailsJson);
        DataJson.Add('employment_details', EmploymentDetailsJson);
        DataJson.Add('loan_details', LoanDetailsJson);
        DataJson.Add('guarantors', GuarantorsArray);
        DataJson.Add('witnesses', WitnessesArray); // Empty for now
        DataJson.Add('documents', DocumentsArray);
        DataJson.Add('sacco_details', SaccoDetailsJson);
        DataJson.Add('application_workflow', WorkflowJson);
        DataJson.Add('additional_info', AdditionalInfoJson);

        SetResponseStatus(ResponseJson, 'success', 'Application Details Retrieved', 'Loan application details retrieved successfully');
        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;

    // Helper procedures
    local procedure CalculateMonthlyPayment(LoanAmount: Decimal; InterestRate: Decimal; PeriodMonths: Integer): Decimal
    var
        MonthlyRate: Decimal;
        Payment: Decimal;
    begin
        if (InterestRate = 0) or (PeriodMonths = 0) then
            exit(LoanAmount / PeriodMonths);

        MonthlyRate := InterestRate / 100 / 12;
        Payment := LoanAmount * (MonthlyRate * Power(1 + MonthlyRate, PeriodMonths)) / (Power(1 + MonthlyRate, PeriodMonths) - 1);
        exit(Payment);
    end;


    local procedure ConvertAmountToWords(Amount: Decimal): Text
    begin
        // Implement amount to words conversion
        exit(Format(Amount) + ' Shillings Only');
    end;








    procedure yyyyMMdd(Date: Date) NewDate: Text
    var
        d: Text;
        y: Text;
        m: Text;
    Begin

        if Date <> 0D then begin

            d := FORMAT(DATE2DMY(Date, 1));
            m := FORMAT(DATE2DMY(Date, 2));
            y := FORMAT(DATE2DMY(Date, 3));

            IF STRLEN(d) = 1 THEN
                d := '0' + d;

            IF STRLEN(m) = 1 THEN
                m := '0' + m;

            NewDate := y + '-' + m + '-' + d;
        end;
    end;





    [TryFunction]
    local procedure SendEmailTryFunction(ToEmail: Text; CCEmail: Text; BCCEmail: Text; Subject: Text; Salutation: Text; EmailBody: Text)
    var
        SaccoActivity: Codeunit "Sacco Activities";
    begin
        // Try to send email - if it fails or times out, TryFunction will handle the error
        SaccoActivity.SendEmail(ToEmail, CCEmail, BCCEmail, Subject, Salutation, EmailBody);
    end;









    local procedure GetEmployeeLeaveDetails(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        Employee: Record Employee;
        HRLeaveTypes: Record "HR Leave Types.";
        HRLeaveApplication: Record "HR Leave Application.";
        HRLeaveLedger: Record "HR Leave Ledger Entries.";
        HRLeaveCalendar: Record "HR Leave Calendar.";
        DataJson: JsonObject;
        LeaveBalancesJson: JsonObject;
        LeaveStatisticsJson: JsonObject;
        EmployeeDetailsJson: JsonObject;
        LeavePoliciesJson: JsonObject;
        LeaveTypesArray: JsonArray;
        RecentApplicationsArray: JsonArray;
        LeaveRequestsArray: JsonArray;
        PendingApprovalsArray: JsonArray;
        PotentialRelieversArray: JsonArray;
        LeaveTypeJson: JsonObject;
        ApplicationJson: JsonObject;
        RelieverJson: JsonObject;
        Username: Text;
        MemberNo: Code[20];
        EmployeeNo: Code[20];
        TotalAllocatedDays: Decimal;
        TotalEarnedDays: Decimal;
        TotalUsedDays: Decimal;
        TotalAvailableDays: Decimal;
        TotalPendingDays: Decimal;
        LeaveUtilizationPercentage: Decimal;
        AverageLeavePerMonth: Decimal;
        YearsOfService: Integer;
        CurrentYear: Integer;
        LeaveYearStart: Date;
        LeaveYearEnd: Date;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Session Invalid', 'Invalid session or user not found');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Member record not found');
            exit(ResponseJson);
        end;

        // Find linked employee record
        Employee.Reset();
        Employee.SetRange("Member No", MemberNo);
        if not Employee.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Employee Not Found', 'Employee record not linked to member');
            exit(ResponseJson);
        end;

        EmployeeNo := Employee."No.";
        CurrentYear := Date2DMY(Today, 3);

        // Get current leave calendar FIRST - this defines the actual leave year (should be 2026)
        HRLeaveCalendar.Reset();
        HRLeaveCalendar.SetRange("Current Leave Calendar", true);
        if HRLeaveCalendar.FindFirst() then begin
            // Use leave calendar dates (e.g., 2026)
            LeaveYearStart := HRLeaveCalendar."Start Date";
            LeaveYearEnd := HRLeaveCalendar."End Date";
        end else begin
            // Fallback: use calendar year
            LeaveYearStart := DMY2Date(1, 1, CurrentYear);
            LeaveYearEnd := DMY2Date(31, 12, CurrentYear);
        end;

        // Calculate years of service
        if Employee."Employment Date" <> 0D then
            YearsOfService := CurrentYear - Date2DMY(Employee."Employment Date", 3)
        else
            YearsOfService := 0;

        // Build leave balances by type
        TotalAllocatedDays := 0;
        TotalEarnedDays := 0;
        TotalUsedDays := 0;
        TotalAvailableDays := 0;
        TotalPendingDays := 0;

        // IMPORTANT: Initialize LeaveBalancesJson before passing to BuildLeaveBalanceForType
        Clear(LeaveBalancesJson);

        HRLeaveTypes.Reset();
        if HRLeaveTypes.FindSet() then begin
            repeat
                BuildLeaveBalanceForType(EmployeeNo, HRLeaveTypes,
                                         LeaveYearStart, LeaveYearEnd, LeaveBalancesJson,
                                       TotalAllocatedDays, TotalEarnedDays, TotalUsedDays,
                                       TotalAvailableDays, TotalPendingDays);
            until HRLeaveTypes.Next() = 0;
        end;

        // Calculate leave statistics
        if TotalAllocatedDays > 0 then
            LeaveUtilizationPercentage := Round((TotalUsedDays / TotalAllocatedDays) * 100, 1)
        else
            LeaveUtilizationPercentage := 0;

        AverageLeavePerMonth := Round(TotalUsedDays / 12, 2);

        // Build leave statistics
        LeaveStatisticsJson.Add('total_allocated_days', TotalAllocatedDays);
        LeaveStatisticsJson.Add('total_earned_days', TotalEarnedDays);
        LeaveStatisticsJson.Add('total_used_days', TotalUsedDays);
        LeaveStatisticsJson.Add('total_available_days', TotalAvailableDays);
        LeaveStatisticsJson.Add('leave_taken_this_year', TotalUsedDays);
        LeaveStatisticsJson.Add('leave_pending_approval', TotalPendingDays);
        LeaveStatisticsJson.Add('leave_utilization_percentage', LeaveUtilizationPercentage);
        LeaveStatisticsJson.Add('average_leave_per_month', AverageLeavePerMonth);

        // Build employee details
        EmployeeDetailsJson.Add('employee_no', EmployeeNo);
        EmployeeDetailsJson.Add('employee_name', Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
        EmployeeDetailsJson.Add('designation', Employee."Job Title");
        EmployeeDetailsJson.Add('department', Employee.Department);
        EmployeeDetailsJson.Add('supervisor', GetSupervisorName(Employee."Supervisor Code"));
        EmployeeDetailsJson.Add('supervisor_email', GetSupervisorEmail(Employee."Supervisor Code"));
        EmployeeDetailsJson.Add('date_of_joining', Format(Employee."Employment Date"));
        EmployeeDetailsJson.Add('employment_type', Format(Employee."Employee Type"));
        EmployeeDetailsJson.Add('leave_group', 'Standard');
        EmployeeDetailsJson.Add('years_of_service', YearsOfService);

        // Build leave types array
        BuildLeaveTypesArray(LeaveTypesArray);

        // Build recent applications (filtered by leave year)
        BuildRecentApplications(EmployeeNo, LeaveYearStart, LeaveYearEnd, RecentApplicationsArray, LeaveRequestsArray);

        // Build pending approvals (if user is supervisor)
        BuildPendingApprovals(Employee."Supervisor Code", Username, PendingApprovalsArray);

        // Build leave policies
        LeavePoliciesJson.Add('annual_leave_accrual_rate', 0);
        LeavePoliciesJson.Add('max_consecutive_leave_days', 0);
        LeavePoliciesJson.Add('min_leave_balance_required', 0);
        LeavePoliciesJson.Add('leave_year_start', Format(LeaveYearStart));
        LeavePoliciesJson.Add('leave_year_end', Format(LeaveYearEnd));
        LeavePoliciesJson.Add('advance_leave_allowed', false);
        LeavePoliciesJson.Add('max_advance_leave_days', 0);

        // Build potential relievers
        BuildPotentialRelievers(EmployeeNo, PotentialRelieversArray);

        // Assemble final response
        DataJson.Add('leave_balances', LeaveBalancesJson);
        DataJson.Add('leave_statistics', LeaveStatisticsJson);
        DataJson.Add('employee_details', EmployeeDetailsJson);
        DataJson.Add('leave_types', LeaveTypesArray);
        DataJson.Add('recent_applications', RecentApplicationsArray);
        DataJson.Add('leave_requests', LeaveRequestsArray);
        DataJson.Add('pending_approvals', PendingApprovalsArray);
        DataJson.Add('leave_policies', LeavePoliciesJson);
        DataJson.Add('reliever_options', PotentialRelieversArray);

        SetResponseStatus(ResponseJson, 'success', 'Leave Details Retrieved', 'Employee leave details retrieved successfully');
        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;


    local procedure GetEmployeeLeaveDetailsByID(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        Employee: Record Employee;
        HRLeaveTypes: Record "HR Leave Types.";
        HRLeaveApplication: Record "HR Leave Application.";
        HRLeaveLedger: Record "HR Leave Ledger Entries.";
        HRLeaveCalendar: Record "HR Leave Calendar.";
        DataJson: JsonObject;
        LeaveBalancesJson: JsonObject;
        LeaveStatisticsJson: JsonObject;
        EmployeeDetailsJson: JsonObject;
        LeavePoliciesJson: JsonObject;
        LeaveTypesArray: JsonArray;
        RecentApplicationsArray: JsonArray;
        LeaveRequestsArray: JsonArray;
        PendingApprovalsArray: JsonArray;
        PotentialRelieversArray: JsonArray;
        LeaveTypeJson: JsonObject;
        ApplicationJson: JsonObject;
        RelieverJson: JsonObject;
        Username: Text;
        MemberNo: Code[20];
        EmployeeNo: Code[20];
        TotalAllocatedDays: Decimal;
        TotalEarnedDays: Decimal;
        TotalUsedDays: Decimal;
        TotalAvailableDays: Decimal;
        TotalPendingDays: Decimal;
        LeaveUtilizationPercentage: Decimal;
        AverageLeavePerMonth: Decimal;
        YearsOfService: Integer;
        CurrentYear: Integer;
        LeaveYearStart: Date;
        LeaveYearEnd: Date;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Session Invalid', 'Invalid session or user not found');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Member record not found');
            exit(ResponseJson);
        end;

        // Find linked employee record
        Employee.Reset();
        Employee.SetRange("Member No", MemberNo);
        if not Employee.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Employee Not Found', 'Employee record not linked to member');
            exit(ResponseJson);
        end;

        EmployeeNo := Employee."No.";
        CurrentYear := Date2DMY(Today, 3);

        // Get current leave calendar FIRST - this defines the actual leave year (should be 2026)
        HRLeaveCalendar.Reset();
        HRLeaveCalendar.SetRange("Current Leave Calendar", true);
        if HRLeaveCalendar.FindFirst() then begin
            // Use leave calendar dates (e.g., 2026)
            LeaveYearStart := HRLeaveCalendar."Start Date";
            LeaveYearEnd := HRLeaveCalendar."End Date";
        end else begin
            // Fallback: use calendar year
            LeaveYearStart := DMY2Date(1, 1, CurrentYear);
            LeaveYearEnd := DMY2Date(31, 12, CurrentYear);
        end;

        // Build leave balances by type
        TotalAllocatedDays := 0;
        TotalEarnedDays := 0;
        TotalUsedDays := 0;
        TotalAvailableDays := 0;
        TotalPendingDays := 0;

        // IMPORTANT: Initialize LeaveBalancesJson before passing to BuildLeaveBalanceForType
        Clear(LeaveBalancesJson);

        HRLeaveTypes.Reset();
        if HRLeaveTypes.FindSet() then begin
            repeat
                BuildLeaveBalanceForType(EmployeeNo, HRLeaveTypes, LeaveYearStart, LeaveYearEnd, LeaveBalancesJson,
                                       TotalAllocatedDays, TotalEarnedDays, TotalUsedDays,
                                       TotalAvailableDays, TotalPendingDays);
            until HRLeaveTypes.Next() = 0;
        end;

        // Calculate leave statistics
        if TotalAllocatedDays > 0 then
            LeaveUtilizationPercentage := Round((TotalUsedDays / TotalAllocatedDays) * 100, 1)
        else
            LeaveUtilizationPercentage := 0;

        AverageLeavePerMonth := Round(TotalUsedDays / 12, 2);

        // Build leave statistics
        LeaveStatisticsJson.Add('total_allocated_days', TotalAllocatedDays);
        LeaveStatisticsJson.Add('total_earned_days', TotalEarnedDays);
        LeaveStatisticsJson.Add('total_used_days', TotalUsedDays);
        LeaveStatisticsJson.Add('total_available_days', TotalAvailableDays);
        LeaveStatisticsJson.Add('leave_taken_this_year', TotalUsedDays);
        LeaveStatisticsJson.Add('leave_pending_approval', TotalPendingDays);
        LeaveStatisticsJson.Add('leave_utilization_percentage', LeaveUtilizationPercentage);
        LeaveStatisticsJson.Add('average_leave_per_month', AverageLeavePerMonth);

        // Build employee details
        EmployeeDetailsJson.Add('employee_no', EmployeeNo);
        EmployeeDetailsJson.Add('employee_name', Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
        EmployeeDetailsJson.Add('designation', Employee."Job Title");
        EmployeeDetailsJson.Add('department', Employee.Department);
        EmployeeDetailsJson.Add('supervisor', GetSupervisorName(Employee."Supervisor Code"));
        EmployeeDetailsJson.Add('supervisor_email', GetSupervisorEmail(Employee."Supervisor Code"));
        EmployeeDetailsJson.Add('date_of_joining', Format(Employee."Employment Date"));
        EmployeeDetailsJson.Add('employment_type', Format(Employee."Employee Type"));
        EmployeeDetailsJson.Add('leave_group', 'Standard');
        EmployeeDetailsJson.Add('years_of_service', YearsOfService);

        // Build leave types array
        BuildLeaveTypesArray(LeaveTypesArray);

        // Build recent applications (filtered by leave year)
        BuildRecentApplications(EmployeeNo, LeaveYearStart, LeaveYearEnd, RecentApplicationsArray, LeaveRequestsArray);

        // Build pending approvals (if user is supervisor)
        BuildPendingApprovals(Employee."Supervisor Code", Username, PendingApprovalsArray);

        // Build leave policies
        LeavePoliciesJson.Add('annual_leave_accrual_rate', 0);
        LeavePoliciesJson.Add('max_consecutive_leave_days', 0);
        LeavePoliciesJson.Add('min_leave_balance_required', 0);
        LeavePoliciesJson.Add('leave_year_start', Format(LeaveYearStart));
        LeavePoliciesJson.Add('leave_year_end', Format(LeaveYearEnd));
        LeavePoliciesJson.Add('advance_leave_allowed', false);
        LeavePoliciesJson.Add('max_advance_leave_days', 0);

        // Build potential relievers
        BuildPotentialRelievers(EmployeeNo, PotentialRelieversArray);

        // Assemble final response
        DataJson.Add('leave_balances', LeaveBalancesJson);
        DataJson.Add('leave_statistics', LeaveStatisticsJson);
        DataJson.Add('employee_details', EmployeeDetailsJson);
        DataJson.Add('leave_types', LeaveTypesArray);
        DataJson.Add('recent_applications', RecentApplicationsArray);
        DataJson.Add('leave_requests', LeaveRequestsArray);
        DataJson.Add('pending_approvals', PendingApprovalsArray);
        DataJson.Add('leave_policies', LeavePoliciesJson);
        DataJson.Add('reliever_options', PotentialRelieversArray);

        SetResponseStatus(ResponseJson, 'success', 'Leave Details Retrieved', 'Employee leave details retrieved successfully');
        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;

    local procedure BuildLeaveBalanceForType(EmployeeNo: Code[20]; HRLeaveTypes: Record "HR Leave Types.";
                                                LeaveStartDate: Date; LeaveEndDate: Date;
                                            var LeaveBalancesJson: JsonObject; var TotalAllocated: Decimal;
                                            var TotalEarned: Decimal; var TotalUsed: Decimal;
                                            var TotalAvailable: Decimal; var TotalPending: Decimal)
    var
        HRLeaveLedger: Record "HR Leave Ledger Entries.";
        HRLeaveApplication: Record "HR Leave Application.";
        LeaveTypeBalanceJson: JsonObject;
        AllocatedDays: Decimal;
        EarnedDays: Decimal;
        UsedDays: Decimal;
        AvailableDays: Decimal;
        CarryForwardDays: Decimal;
        PendingDays: Decimal;
        LeaveTypeCode: Text;
        LeaveCalendarCode: Code[10];
    begin
        AllocatedDays := 0;
        EarnedDays := 0;
        UsedDays := 0;
        CarryForwardDays := 0;
        PendingDays := 0;

        // Validate date parameters - prevent invalid filters
        if LeaveEndDate = 0D then
            LeaveEndDate := DMY2Date(31, 12, Date2DMY(Today, 3)); // Set to end of current year
        if LeaveStartDate = 0D then
            LeaveStartDate := DMY2Date(1, 1, Date2DMY(Today, 3));
        LeaveCalendarCode := Format(Date2DMY(Today, 3)) + 'L'; // Set to start of current year

        // Get allocated days (positive entries)
        // Filter by posting date to get only allocations for the current leave year
        // NOTE: We do NOT filter by Closed status - we want ALL allocated days
        HRLeaveLedger.Reset();
        HRLeaveLedger.SetRange("Staff No.", EmployeeNo);
        HRLeaveLedger.SetRange("Leave Type", HRLeaveTypes.Code);
        HRLeaveLedger.SetRange("Leave Entry Type", HRLeaveLedger."Leave Entry Type"::Positive);
        HRLeaveLedger.SetRange("Leave Calendar Code", LeaveCalendarCode);
        // Only allocations within the current leave year (by posting date)
        //HRLeaveLedger.SetRange("Posting Date",LeaveStartDate,LeaveEndDate);
        /* 
     if HRLeaveLedger.FindSet() then begin kinyua
         repeat
             AllocatedDays += HRLeaveLedger."No. of days";
         until HRLeaveLedger.Next() = 0;
     end;
     */
        HRLeaveLedger.CalcSums("No. of days");
        AllocatedDays := HRLeaveLedger."No. of days";

        // Get used days (negative entries)
        // Filter by posting date to get only usage for the current leave year
        // NOTE: We do NOT filter by Closed status - we want ALL used/posted days
        HRLeaveLedger.Reset();
        HRLeaveLedger.SetRange("Staff No.", EmployeeNo);
        HRLeaveLedger.SetRange("Leave Type", HRLeaveTypes.Code);
        HRLeaveLedger.SetRange("Leave Entry Type", HRLeaveLedger."Leave Entry Type"::Negative);
        // Only usage within the current leave year (by posting date)
        //HRLeaveLedger.SetRange("Posting Date",LeaveStartDate,LeaveEndDate);
        HRLeaveLedger.SetRange("Leave Calendar Code", LeaveCalendarCode);
        /*
                if HRLeaveLedger.FindSet() then begin
                    repeat
                        UsedDays += Abs(HRLeaveLedger."No. of days");
                    until HRLeaveLedger.Next() = 0;
                end;
                */
        HRLeaveLedger.CalcSums("No. of days");
        UsedDays := Abs(HRLeaveLedger."No. of days");
        //usedDays := 45; //temporary hardcode for testing - remove after testing kinyua

        // ALSO count APPROVED leave applications (not just ledger entries)
        // Approved applications represent leave that has been taken
        /*
        HRLeaveApplication.Reset();
        HRLeaveApplication.SetRange("Applicant Staff No.", EmployeeNo);
        HRLeaveApplication.SetRange("Leave Type", HRLeaveTypes.Code);
        HRLeaveApplication.SetRange(Status, HRLeaveApplication.Status::Approved);
        HRLeaveApplication.SetRange("Application Date", LeaveStartDate, LeaveEndDate);
        
        if HRLeaveApplication.FindSet() then begin
            repeat
                UsedDays += HRLeaveApplication."Days Applied";
            until HRLeaveApplication.Next() = 0;
        end;
        
        HRLeaveApplication.CalcSums("Days Applied");
        UsedDays := HRLeaveApplication."Days Applied";
        */
        // Get pending applications for current leave year
        HRLeaveApplication.Reset();
        HRLeaveApplication.SetRange("Applicant Staff No.", EmployeeNo);
        HRLeaveApplication.SetRange("Leave Type", HRLeaveTypes.Code);
        HRLeaveApplication.SetRange(Status, HRLeaveApplication.Status::"Pending Approval");
        HRLeaveApplication.SetRange("Application Date", LeaveStartDate, LeaveEndDate);
        /*
        if HRLeaveApplication.FindSet() then
            repeat
                PendingDays += HRLeaveApplication."Days Applied";
            until HRLeaveApplication.Next() = 0;
            */
        HRLeaveApplication.CalcSums("Days Applied");
        PendingDays := HRLeaveApplication."Days Applied";

        // Calculate earned days based on leave type //kinyua
        // if HRLeaveTypes."Is Annual Leave" then
        //     EarnedDays := CalculateEarnedAnnualLeaveDays(EmployeeNo, AllocatedDays)
        // else //kinyua - for non-annual leave types, we assume all allocated days are earned (no pro-rata)
        EarnedDays := AllocatedDays;

        // Calculate available days
        AvailableDays := EarnedDays - UsedDays - PendingDays;

        // Determine leave type code for JSON key (keep the mapping, don't overwrite)
        LeaveTypeCode := LowerCase(HRLeaveTypes.Code);
        if StrPos(LeaveTypeCode, 'annual') > 0 then
            LeaveTypeCode := 'annual_leave'
        else if StrPos(LeaveTypeCode, 'sick') > 0 then
            LeaveTypeCode := 'sick_leave'
        else if StrPos(LeaveTypeCode, 'maternity') > 0 then
            LeaveTypeCode := 'maternity_leave'
        else if StrPos(LeaveTypeCode, 'paternity') > 0 then
            LeaveTypeCode := 'paternity_leave'
        else if StrPos(LeaveTypeCode, 'study') > 0 then
            LeaveTypeCode := 'study_leave'
        else if StrPos(LeaveTypeCode, 'compassionate') > 0 then
            LeaveTypeCode := 'compassionate_leave'
        else
            LeaveTypeCode := DelChr(LowerCase(HRLeaveTypes.Code), '=', ' ') + '_leave';

        // Build leave type balance JSON
        LeaveTypeBalanceJson.Add('allocated', AllocatedDays);
        LeaveTypeBalanceJson.Add('earned', EarnedDays);
        LeaveTypeBalanceJson.Add('used', UsedDays);
        LeaveTypeBalanceJson.Add('available', AvailableDays);
        LeaveTypeBalanceJson.Add('carry_forward', CarryForwardDays);
        LeaveTypeBalanceJson.Add('pending', PendingDays);

        LeaveBalancesJson.Add(LeaveTypeCode, LeaveTypeBalanceJson);

        // Add to totals
        TotalAllocated += AllocatedDays;
        TotalEarned += EarnedDays;
        TotalUsed += UsedDays;
        TotalAvailable += AvailableDays;
        TotalPending += PendingDays;
    end;

    local procedure CalculateEarnedAnnualLeaveDays(EmployeeNo: Code[20]; AllocatedDays: Decimal): Decimal
    var
        Employee: Record Employee;
        CurrentMonth: Integer;
        EarnedDays: Decimal;
        MonthsWorkedThisYear: Integer;
    begin
        if not Employee.Get(EmployeeNo) then
            exit(AllocatedDays);

        // Calculate months worked THIS YEAR (Jan = 1, Feb = 2, ... Dec = 12)
        CurrentMonth := Date2DMY(Today, 2); // Current month number (1-12)
        MonthsWorkedThisYear := CurrentMonth; // Months worked from Jan to current month

        // If employee started THIS YEAR, calculate based on months actually worked
        if Employee."Employment Date" > DMY2Date(1, 1, Date2DMY(Today, 3)) then begin
            // Employee started after Jan 1 this year
            // Calculate months from employment date to today
            MonthsWorkedThisYear := CurrentMonth - Date2DMY(Employee."Employment Date", 2);
            if MonthsWorkedThisYear < 0 then MonthsWorkedThisYear := 0;
            if MonthsWorkedThisYear = 0 then MonthsWorkedThisYear := 1; // At least 1 month
        end;

        // Calculate earned days (pro-rata based on months worked this year)
        // Standard: Full year = 12 months = AllocatedDays
        EarnedDays := Round((AllocatedDays / 12) * MonthsWorkedThisYear, 0.01);

        // Never exceed allocated
        if EarnedDays > AllocatedDays then
            EarnedDays := AllocatedDays;

        exit(EarnedDays);
    end;

    local procedure BuildLeaveTypesArray(var LeaveTypesArray: JsonArray)
    var
        HRLeaveTypes: Record "HR Leave Types.";
        LeaveTypeJson: JsonObject;
        IconClass: Text;
        ColorClass: Text;
    begin
        HRLeaveTypes.Reset();
        if HRLeaveTypes.FindSet() then begin
            repeat
                Clear(LeaveTypeJson);

                // Determine icon and color based on leave type
                case LowerCase(HRLeaveTypes.Code) of
                    'annual':
                        begin
                            IconClass := 'fas fa-umbrella-beach';
                            ColorClass := 'blue';
                        end;
                    'sick':
                        begin
                            IconClass := 'fas fa-user-md';
                            ColorClass := 'red';
                        end;
                    'maternity':
                        begin
                            IconClass := 'fas fa-baby';
                            ColorClass := 'pink';
                        end;
                    'paternity':
                        begin
                            IconClass := 'fas fa-male';
                            ColorClass := 'green';
                        end;
                    'compassionate':
                        begin
                            IconClass := 'fas fa-heart';
                            ColorClass := 'purple';
                        end;
                    'study':
                        begin
                            IconClass := 'fas fa-graduation-cap';
                            ColorClass := 'indigo';
                        end;
                    else begin
                        IconClass := 'fas fa-calendar';
                        ColorClass := 'gray';
                    end;
                end;

                LeaveTypeJson.Add('code', HRLeaveTypes.Code);
                LeaveTypeJson.Add('name', HRLeaveTypes.Description);
                LeaveTypeJson.Add('description', HRLeaveTypes.Description);
                LeaveTypeJson.Add('max_days_per_request', HRLeaveTypes.Days);
                LeaveTypeJson.Add('min_notice_days', 7); // Default, can be enhanced
                LeaveTypeJson.Add('can_carry_forward', HRLeaveTypes."Carry Forward Allowed");
                LeaveTypeJson.Add('requires_documentation', true); // Default, can be enhanced
                LeaveTypeJson.Add('icon', IconClass);
                LeaveTypeJson.Add('color', ColorClass);

                LeaveTypesArray.Add(LeaveTypeJson);
            until HRLeaveTypes.Next() = 0;
        end;
    end;

    local procedure BuildRecentApplications(EmployeeNo: Code[20]; LeaveYearStart: Date; LeaveYearEnd: Date; var RecentApplicationsArray: JsonArray; var LeaveRequestsArray: JsonArray)
    var
        HRLeaveApplication: Record "HR Leave Application.";
        ApplicationJson: JsonObject;
        StatusColor: Text;
        CanEdit: Boolean;
        CanCancel: Boolean;
        Counter: Integer;
        IncludeApplication: Boolean;
    begin
        HRLeaveApplication.Reset();
        HRLeaveApplication.SetRange("Applicant Staff No.", EmployeeNo);
        // Filter applications by Application Date within leave year
        HRLeaveApplication.SetFilter("Application Date", '>=%1&<=%2', LeaveYearStart, LeaveYearEnd);
        HRLeaveApplication.SetCurrentKey("Application Date");
        HRLeaveApplication.Ascending(false);

        if HRLeaveApplication.FindSet() then begin
            repeat
                IncludeApplication := true;

                // Additional validation: ensure leave dates fall within leave year
                // Skip if leave was entirely requested for previous year
                if (HRLeaveApplication."End Date" <> 0D) and (HRLeaveApplication."End Date" < LeaveYearStart) then
                    IncludeApplication := false
                else if (HRLeaveApplication."Start Date" <> 0D) and (HRLeaveApplication."Start Date" < LeaveYearStart) and (HRLeaveApplication."End Date" < LeaveYearStart) then
                    IncludeApplication := false;

                if IncludeApplication then begin
                    Clear(ApplicationJson);

                    // Determine status color and edit capabilities
                    case HRLeaveApplication.Status of
                        HRLeaveApplication.Status::New:
                            begin
                                StatusColor := 'blue';
                                CanEdit := true;
                                CanCancel := true;
                            end;
                        HRLeaveApplication.Status::"Pending Approval":
                            begin
                                StatusColor := 'yellow';
                                CanEdit := false;
                                CanCancel := true;
                            end;
                        HRLeaveApplication.Status::Approved:
                            begin
                                StatusColor := 'green';
                                CanEdit := false;
                                CanCancel := false;
                            end;
                        HRLeaveApplication.Status::Rejected:
                            begin
                                StatusColor := 'red';
                                CanEdit := false;
                                CanCancel := false;
                            end;
                    end;

                    ApplicationJson.Add('id', HRLeaveApplication."Application Code");
                    ApplicationJson.Add('leave_type', HRLeaveApplication.Description);
                    ApplicationJson.Add('leave_type_code', HRLeaveApplication."Leave Type");
                    ApplicationJson.Add('start_date', Format(HRLeaveApplication."Start Date"));
                    ApplicationJson.Add('end_date', Format(HRLeaveApplication."End Date"));
                    ApplicationJson.Add('days_requested', HRLeaveApplication."Days Applied");
                    ApplicationJson.Add('reliever_code', HRLeaveApplication.Reliever);
                    ApplicationJson.Add('reliever_name', HRLeaveApplication."Reliever Name");
                    ApplicationJson.Add('status', Format(HRLeaveApplication.Status));
                    ApplicationJson.Add('status_color', StatusColor);
                    ApplicationJson.Add('request_date', Format(HRLeaveApplication."Application Date"));
                    ApplicationJson.Add('reason', HRLeaveApplication."Applicant Comments");
                    ApplicationJson.Add('approver', GetSupervisorName(HRLeaveApplication."Applicant Supervisor"));
                    ApplicationJson.Add('comments', HRLeaveApplication."Approver Comments");
                    ApplicationJson.Add('can_edit', CanEdit);
                    ApplicationJson.Add('can_cancel', CanCancel);

                    // Add to recent applications (limit to 10)
                    if Counter < 10 then begin
                        RecentApplicationsArray.Add(ApplicationJson);
                        Counter += 1;
                    end;

                    // Add all to leave requests
                    LeaveRequestsArray.Add(ApplicationJson);
                end;

            until HRLeaveApplication.Next() = 0;
        end;
    end;

    local procedure BuildPendingApprovals(SupervisorCode: Code[50]; Username: Text; var PendingApprovalsArray: JsonArray)
    var
        HRLeaveApplication: Record "HR Leave Application.";
        ApplicationJson: JsonObject;
        CurrentYear: Integer;
        LeaveYearStart: Date;
        LeaveYearEnd: Date;
    begin
        // Only show pending approvals if user is a supervisor
        HRLeaveApplication.Reset();
        HRLeaveApplication.SetRange("Applicant Supervisor", SupervisorCode);
        HRLeaveApplication.SetRange(Status, HRLeaveApplication.Status::"Pending Approval");

        // Filter by current leave year (same as BuildRecentApplications)
        CurrentYear := Date2DMY(Today, 3);
        LeaveYearStart := DMY2Date(1, 1, CurrentYear);
        LeaveYearEnd := DMY2Date(31, 12, CurrentYear);
        HRLeaveApplication.SetFilter("Application Date", '>=%1&<=%2', LeaveYearStart, LeaveYearEnd);

        if HRLeaveApplication.FindSet() then begin
            repeat
                Clear(ApplicationJson);

                ApplicationJson.Add('id', HRLeaveApplication."Application Code");
                ApplicationJson.Add('employee_name', HRLeaveApplication.Names);
                ApplicationJson.Add('leave_type', HRLeaveApplication.Description);
                ApplicationJson.Add('reliever_code', HRLeaveApplication.Reliever);
                ApplicationJson.Add('reliever_name', HRLeaveApplication."Reliever Name");
                ApplicationJson.Add('start_date', Format(HRLeaveApplication."Start Date"));
                ApplicationJson.Add('end_date', Format(HRLeaveApplication."End Date"));
                ApplicationJson.Add('days_requested', HRLeaveApplication."Days Applied");
                ApplicationJson.Add('request_date', Format(HRLeaveApplication."Application Date"));
                ApplicationJson.Add('reason', HRLeaveApplication."Applicant Comments");

                PendingApprovalsArray.Add(ApplicationJson);
            until HRLeaveApplication.Next() = 0;
        end;
    end;

    local procedure BuildPotentialRelievers(EmployeeNo: Code[20]; var PotentialRelieversArray: JsonArray)
    var
        Employee: Record Employee;
        RelieverJson: JsonObject;
    begin
        Employee.Reset();
        Employee.SetRange(Status, Employee.Status::Active);
        Employee.SetFilter("No.", '<>%1', EmployeeNo);

        if Employee.FindSet() then begin
            repeat
                Clear(RelieverJson);

                RelieverJson.Add('code', Employee."No.");
                RelieverJson.Add('name', Employee."First Name" + ' ' + Employee."Last Name");
                RelieverJson.Add('designation', Employee."Job Title");

                PotentialRelieversArray.Add(RelieverJson);
            until Employee.Next() = 0;
        end;
    end;

    local procedure GetSupervisorName(SupervisorCode: Code[50]): Text
    var
        Employee: Record Employee;
    begin
        Employee.Reset();
        Employee.SetRange("User ID", SupervisorCode);
        if Employee.FindFirst() then
            exit(Employee."First Name" + ' ' + Employee."Last Name")
        else
            exit('');
    end;

    local procedure GetSupervisorEmail(SupervisorCode: Code[50]): Text
    var
        Employee: Record Employee;
    begin
        Employee.Reset();
        Employee.SetRange("User ID", SupervisorCode);
        if Employee.FindFirst() then
            exit(Employee."Company E-Mail")
        else
            exit('');
    end;







    local procedure InitiateNewLeaveApplication(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        LeaveDetailsData: JsonToken;
        LeaveDetailsRequest: JsonObject;
        LeaveDetailsResponse: JsonObject;
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        Employee: Record Employee;
        HRLeaveApplication: Record "HR Leave Application.";
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
        DataJson: JsonObject;
        Username: Text;
        IdentifierType: Text;
        Identifier: Text;
        MemberNo: Code[20];
        EmployeeNo: Code[20];
        ApplicationCode: Code[20];
        RequestDate: DateTime;
        ApplicationCreated: Boolean;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        if RequestJson.Contains('request_date') then
            RequestDate := SelectJsonToken(RequestJson, '$.request_date').AsValue.AsDateTime
        else
            RequestDate := CurrentDateTime;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Session Invalid', 'Invalid session or user not found');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Member record not found');
            exit(ResponseJson);
        end;

        // Find linked employee record
        Employee.Reset();
        Employee.SetRange("Member No", MemberNo);
        if not Employee.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Employee Not Found', 'Employee record not linked to member');
            exit(ResponseJson);
        end;

        EmployeeNo := Employee."No.";

        // Get HR Setup for numbering series
        if not HRSetup.Get() then begin
            SetResponseStatus(ResponseJson, 'error', 'HR Setup Not Found', 'HR Setup record not found');
            exit(ResponseJson);
        end;

        // Create new leave application
        ApplicationCreated := false;

        HRLeaveApplication.Init();

        // Generate application code/number
        ApplicationCode := '';
        /*
        if HRSetup."Leave Application Nos." <> '' then
            ApplicationCode := NoSeries.GetNextNo(HRSetup."Leave Application Nos.", Today, true)
        else
            ApplicationCode := 'LA' + Format(Today, 0, '<Year4><Month,2><Day,2>') + Format(Time, 0, '<Hours24,2><Minutes,2>');
        */

        HRLeaveApplication."Applicant User ID" := Employee."User ID";
        HRLeaveApplication."Portal Application" := true;
        /*
        HRLeaveApplication."Application Code" := ApplicationCode;
        HRLeaveApplication."Applicant Staff No." := EmployeeNo;
        HRLeaveApplication.Names := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
        HRLeaveApplication."Application Date" := DT2Date(RequestDate);
        HRLeaveApplication."Applicant Supervisor" := Employee."Supervisor Code";
        HRLeaveApplication.Status := HRLeaveApplication.Status::New;

        // Set default values
        HRLeaveApplication."Days Applied" := 0;
        HRLeaveApplication."Start Date" := 0D;
        HRLeaveApplication."End Date" := 0D;
        HRLeaveApplication."Leave Type" := '';
        HRLeaveApplication.Description := '';
        HRLeaveApplication."Applicant Comments" := '';
        */

        HRLeaveApplication.Insert(true);
        ApplicationCreated := true;
        ApplicationCode := HRLeaveApplication."Application Code";


        // Build success response with application details
        DataJson.Add('application_created', true);
        DataJson.Add('application_id', ApplicationCode);
        DataJson.Add('application_date', Format(HRLeaveApplication."Application Date"));
        DataJson.Add('employee_no', EmployeeNo);
        DataJson.Add('member_no', MemberNo);
        DataJson.Add('status', Format(HRLeaveApplication.Status));
        DataJson.Add('message', 'Leave application initiated successfully. You can now add leave details.');

        // Build a request for getting leave details
        LeaveDetailsRequest.Add('username', Username);

        // Get the complete leave details
        LeaveDetailsResponse := GetEmployeeLeaveDetails(LeaveDetailsRequest);

        // Extract the data from the leave details response
        if LeaveDetailsResponse.Contains('data') then begin

            if LeaveDetailsResponse.Get('data', LeaveDetailsData) then
                DataJson.Add('leave_details', LeaveDetailsData);
        end;

        SetResponseStatus(ResponseJson, 'success', 'Leave Application Initiated', 'New leave application created successfully');
        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;





    local procedure UpdateLeaveApplication(RequestJson: JsonObject; final: boolean) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        Employee: Record Employee;
        HRLeaveApplication: Record "HR Leave Application.";
        HRLeaveTypes: Record "HR Leave Types.";
        RelieverEmployee: Record Employee;
        DataJson: JsonObject;
        LeaveDetailsRequest: JsonObject;
        LeaveDetailsResponse: JsonObject;
        LeaveDetailsData: JsonToken;
        Username: Text;
        IdentifierType: Text;
        Identifier: Text;
        ApplicationId: Code[20];
        TriggerField: Text;
        TriggerValue: Text;
        LeaveType: Code[20];
        StartDate: Date;
        EndDate: Date;
        DaysApplied: Integer;
        Reason: Text;
        RelieverCode: Code[20];
        RelieverName: Text;
        CellPhone: Text;
        AltCellPhone: Text;
        Email: Text;
        Address: Text;
        ExamDetails: Text;
        ExamDate: Date;
        PreviousAttempts: Text;
        RequestLeaveAllowance: Boolean;
        MemberNo: Code[20];
        EmployeeNo: Code[20];
        RequestTimestamp: DateTime;
        ApplicationFound: Boolean;
        LeaveTypeFound: Boolean;
        RelieverFound: Boolean;
        CalculatedEndDate: Date;
        DateDifference: Integer;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        ApplicationId := CopyStr(SelectJsonToken(RequestJson, '$.application_id').AsValue.AsText, 1, 20);
        //TriggerField := SelectJsonToken(RequestJson, '$.trigger_field').AsValue.AsText;
        //TriggerValue := SelectJsonToken(RequestJson, '$.trigger_value').AsValue.AsText;

        // Extract leave application details
        LeaveType := CopyStr(SelectJsonToken(RequestJson, '$.leave_type').AsValue.AsText, 1, 20);

        if SelectJsonToken(RequestJson, '$.start_date').AsValue.AsText <> '' then
            StartDate := SelectJsonToken(RequestJson, '$.start_date').AsValue.AsDate;

        if SelectJsonToken(RequestJson, '$.end_date').AsValue.AsText <> '' then
            EndDate := SelectJsonToken(RequestJson, '$.end_date').AsValue.AsDate;

        if SelectJsonToken(RequestJson, '$.days_applied').AsValue.AsText <> '' then
            DaysApplied := SelectJsonToken(RequestJson, '$.days_applied').AsValue.AsInteger;

        Reason := SelectJsonToken(RequestJson, '$.reason').AsValue.AsText;
        RelieverCode := CopyStr(SelectJsonToken(RequestJson, '$.reliever_code').AsValue.AsText, 1, 20);
        RelieverName := SelectJsonToken(RequestJson, '$.reliever_name').AsValue.AsText;
        CellPhone := SelectJsonToken(RequestJson, '$.cell_phone').AsValue.AsText;
        AltCellPhone := SelectJsonToken(RequestJson, '$.alt_cell_phone').AsValue.AsText;
        Email := SelectJsonToken(RequestJson, '$.email').AsValue.AsText;
        Address := SelectJsonToken(RequestJson, '$.address').AsValue.AsText;
        ExamDetails := SelectJsonToken(RequestJson, '$.exam_details').AsValue.AsText;

        if SelectJsonToken(RequestJson, '$.exam_date').AsValue.AsText <> '' then
            ExamDate := SelectJsonToken(RequestJson, '$.exam_date').AsValue.AsDate;

        PreviousAttempts := SelectJsonToken(RequestJson, '$.previous_attempts').AsValue.AsText;
        RequestLeaveAllowance := SelectJsonToken(RequestJson, '$.request_leave_allowance').AsValue.AsBoolean;
        RequestTimestamp := SelectJsonToken(RequestJson, '$.timestamp').AsValue.AsDateTime;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Session Invalid', 'Invalid session or user not found');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Member record not found');
            exit(ResponseJson);
        end;

        // Find linked employee record
        Employee.Reset();
        Employee.SetRange("Member No", MemberNo);
        if not Employee.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Employee Not Found', 'Employee record not linked to member');
            exit(ResponseJson);
        end;

        EmployeeNo := Employee."No.";

        // Find the leave application
        HRLeaveApplication.Reset();
        HRLeaveApplication.SetRange("Application Code", ApplicationId);
        HRLeaveApplication.SetRange("Applicant Staff No.", EmployeeNo);
        ApplicationFound := HRLeaveApplication.FindFirst();

        if not ApplicationFound then begin
            SetResponseStatus(ResponseJson, 'error', 'Application Not Found', 'Leave application not found or access denied');
            exit(ResponseJson);
        end;

        // Check if application can be edited
        if HRLeaveApplication.Status <> HRLeaveApplication.Status::New then begin
            SetResponseStatus(ResponseJson, 'error', 'Application Cannot Be Modified', 'Leave application cannot be modified in its current status');
            exit(ResponseJson);
        end;

        // Validate leave type if provided
        LeaveTypeFound := true;
        if LeaveType <> '' then begin
            HRLeaveTypes.Reset();
            HRLeaveTypes.SetRange(Code, LeaveType);
            LeaveTypeFound := HRLeaveTypes.FindFirst();

            if not LeaveTypeFound then begin
                SetResponseStatus(ResponseJson, 'error', 'Invalid Leave Type', 'The specified leave type does not exist');
                exit(ResponseJson);
            end;
        end;

        // Validate reliever if provided
        RelieverFound := true;
        if RelieverCode <> '' then begin
            RelieverEmployee.Reset();
            RelieverEmployee.SetRange("No.", RelieverCode);
            RelieverFound := RelieverEmployee.FindFirst();

            if not RelieverFound then begin
                SetResponseStatus(ResponseJson, 'error', 'Invalid Reliever', 'The specified reliever does not exist');
                exit(ResponseJson);
            end else begin
                RelieverName := RelieverEmployee."First Name" + ' ' + RelieverEmployee."Last Name";
            end;
        end;

        if LeaveType <> '' then begin
            HRLeaveApplication.validate("Leave Type", LeaveType);
            if LeaveTypeFound then
                HRLeaveApplication.Description := HRLeaveTypes.Description;
        end;

        if DaysApplied >= 0 then begin
            HRLeaveApplication.validate("Days Applied", DaysApplied);
        end;

        if StartDate <> 0D then begin
            HRLeaveApplication.validate("Start Date", StartDate);
        end;

        if RelieverCode <> '' then begin
            HRLeaveApplication.validate(Reliever, RelieverCode);
        end;



        if Reason <> '' then
            HRLeaveApplication."Applicant Comments" := CopyStr(Reason, 1, MaxStrLen(HRLeaveApplication."Applicant Comments"));


        // Update contact information if provided
        if CellPhone <> '' then
            HRLeaveApplication."Cell Phone Number" := CopyStr(CellPhone, 1, MaxStrLen(HRLeaveApplication."Cell Phone Number"));

        if Email <> '' then
            HRLeaveApplication."E-mail Address" := Email;


        if ExamDetails <> '' then
            HRLeaveApplication."Details of Examination" := ExamDetails;

        if ExamDate <> 0D then
            HRLeaveApplication."Date of Exam" := ExamDate;


        HRLeaveApplication.Modify(true);
        Commit();

        if final then
            sendLeaveApproval(HRLeaveApplication);

        // Build success response with updated application details
        DataJson.Add('application_updated', true);
        DataJson.Add('application_id', ApplicationId);
        DataJson.Add('final_step', final);
        DataJson.Add('trigger_field', TriggerField);
        DataJson.Add('trigger_value', TriggerValue);
        DataJson.Add('leave_type', HRLeaveApplication."Leave Type");
        DataJson.Add('leave_type_description', HRLeaveApplication.Description);
        DataJson.Add('start_date', Format(HRLeaveApplication."Start Date"));
        DataJson.Add('end_date', Format(HRLeaveApplication."End Date"));
        DataJson.Add('return_date', Format(HRLeaveApplication."Return Date"));
        DataJson.Add('days_applied', HRLeaveApplication."Days Applied");
        DataJson.Add('reason', HRLeaveApplication."Applicant Comments");
        DataJson.Add('reliever_code', HRLeaveApplication.Reliever);
        DataJson.Add('reliever_name', HRLeaveApplication."Reliever Name");
        DataJson.Add('status', Format(HRLeaveApplication.Status));
        DataJson.Add('last_modified', Format(Today));
        DataJson.Add('message', 'Leave application updated successfully');

        // Get updated leave details
        LeaveDetailsRequest.Add('username', Username);
        LeaveDetailsResponse := GetEmployeeLeaveDetails(LeaveDetailsRequest);

        // Extract the data from the leave details response
        if LeaveDetailsResponse.Contains('data') then begin
            if LeaveDetailsResponse.Get('data', LeaveDetailsData) then
                DataJson.Add('leave_details', LeaveDetailsData);
        end;

        SetResponseStatus(ResponseJson, 'success', 'Leave Application Updated', 'Leave application has been updated successfully');
        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;





    local procedure sendLeaveApproval(HRLeaveApplication: Record "HR Leave Application.")
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        NextofKinError: label 'You must specify next of Kin for this application.';
        NextofKIN: Record "Service Item";
        ProductFactory: Record "Service Item";
        SavingsAccountRegistration: Record "Service Item";
        DocumentType: Enum "Custom Document Type";
        CalwideApprovals: Codeunit "Calwide Approvals";
        VarVariant: Variant;
    begin
        //TESTFIELD(e)
        //TESTFIELD("Cell Phone Number");
        //TESTFIELD(Address);
        HRLeaveApplication.TestField("Start Date");
        HRLeaveApplication.TestField("Job Tittle");
        //TESTFIELD("Interest Due Date");}

        HRLeaveApplication.TestField("Leave Type");
        HRLeaveApplication.TestField("Days Applied");
        HRLeaveApplication.TestField("Start Date");
        //TestField(Reliever);
        HRLeaveApplication.TestField("Applicant Supervisor");
        HRLeaveApplication.TestField("Responsibility Center");


        VarVariant := HRLeaveApplication;
        CalwideApprovals.CreateCustomTracker(VarVariant, HRLeaveApplication."Application Code", 0, Documenttype::Leave, HRLeaveApplication."Global Dimension 1 Code", HRLeaveApplication."Global Dimension 2 Code", 0);
        VarVariant := HRLeaveApplication;
        CalwideApprovals.CreateCustomTracker(VarVariant, HRLeaveApplication."Application Code", 0, Documenttype::Leave, HRLeaveApplication."Global Dimension 1 Code", HRLeaveApplication."Global Dimension 2 Code", 0);

    end;

    local procedure GetStaffPayslip(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        Employee: Record Employee;
        StaffPayslipReport: Report "Staff Payslip";
        varBase64Conversion: Codeunit "Base64 Convert";
        OStream: OutStream;
        IStream: InStream;
        varTempBlob: Codeunit "Temp Blob";
        DataJson: JsonObject;
        MemberId: Text;
        MemberNo: Code[20];
        SessionId: Text;
        Username: Text;
        PayslipDate: Date;
        PayslipMonth: Integer;
        PayslipYear: Integer;
        PayslipPeriod: Text;
        EmployeeNo: Code[20];
        vConvertedContent: Text;
        PayrollPeriod: Record "Payroll Periods";
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        PeriodFound: Boolean;
        Emp: Record Employee;
        SaccoActivities: Codeunit "Sacco Activities";
        FileName: Text;
        DateFilterText: Text;
        CompanyInformation: Record "Company Information";
        SaccoSetup: Record "Sacco Setup";
    begin
        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        if RequestJson.Contains('identifier') then
            MemberId := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        // Get payslip parameters
        if RequestJson.Contains('payslip_date') then
            PayslipDate := SelectJsonToken(RequestJson, '$.payslip_date').AsValue.AsDate;

        if RequestJson.Contains('payslip_month') then
            PayslipMonth := SelectJsonToken(RequestJson, '$.payslip_month').AsValue.AsInteger;

        if RequestJson.Contains('payslip_year') then
            PayslipYear := SelectJsonToken(RequestJson, '$.payslip_year').AsValue.AsInteger;

        if RequestJson.Contains('payslip_period') then
            PayslipPeriod := SelectJsonToken(RequestJson, '$.payslip_period').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Session Invalid', 'Invalid session or user not found');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
            exit(ResponseJson);
        end;

        // Find linked employee record
        Employee.Reset();
        Employee.SetRange("Member No", MemberNo);
        if not Employee.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Employee Not Found', 'Employee record not linked to member');
            exit(ResponseJson);
        end;

        EmployeeNo := Employee."No.";

        // If no specific date provided, find the most recent payroll period
        if PayslipDate = 0D then begin
            if (PayslipMonth > 0) and (PayslipYear > 0) then begin
                // Build date from month and year
                PayslipDate := DMY2Date(1, PayslipMonth, PayslipYear);
            end else begin
                SetResponseStatus(ResponseJson, 'error', 'No Payroll Period Found', 'No payroll periods found');
                exit(ResponseJson);
            end;
        end;

        // Find the specific payroll period if not already found
        /*
        if not PeriodFound then begin
            PayrollPeriod.Reset();
            PayrollPeriod.SetFilter("Date Opened", '%1', PayslipDate);
            if PayrollPeriod.FindFirst() then begin
                PeriodStartDate := PayrollPeriod."Date Opened";
                PeriodEndDate := PayrollPeriod."Date Opened";
                PeriodFound := true;
            end;
        end;
        */

        if not PeriodFound then begin
            PayrollPeriod.Reset();
            PayrollPeriod.setrange("Period Month", PayslipMonth);
            PayrollPeriod.setrange("Period Year", PayslipYear);
            if PayrollPeriod.FindFirst() then begin
                PeriodStartDate := PayrollPeriod."Date Opened";
                PeriodEndDate := PayrollPeriod."Date Opened";
                PeriodFound := true;
            end;
        end;

        if not PeriodFound then begin
            SetResponseStatus(ResponseJson, 'error', 'Payroll Period Not Found', 'No payroll period found for the specified date');
            exit(ResponseJson);
        end;


        // Generate filename (same format as email report)
        FileName := EmployeeNo + '-Payslip.pdf';

        // Generate payslip report to TempBlob (exactly as in email report)
        Emp.Reset();
        Emp.SetRange("No.", EmployeeNo);

        // Set date filter in the same format as email report
        DateFilterText := Format(PeriodStartDate);// + '..' + Format(PeriodEndDate);
        Emp.SetFilter("Date Filter", DateFilterText);

        if Emp.FindFirst() then begin

            // Create TempBlob output stream
            varTempBlob.CreateOutStream(OStream);

            // Initialize and run the Staff Payslip report (exactly as email report)
            Clear(StaffPayslipReport);
            StaffPayslipReport.SetTableView(Emp);
            ClearLastError();

            if StaffPayslipReport.SaveAs('', ReportFormat::Pdf, OStream) then begin
                // Convert to Base64
                varTempBlob.CreateInStream(IStream);
                vConvertedContent := varBase64Conversion.ToBase64(IStream);

                // Initialize response
                SetResponseStatus(ResponseJson, 'success', 'Payslip Retrieved', 'Payslip retrieved successfully');
                ResponseJson.Add('timestamp', Format(CurrentDateTime));

                // Create data object
                DataJson.Add('member_id', MemberNo);
                DataJson.Add('employee_no', EmployeeNo);
                DataJson.Add('employee_name', Emp.FullName());
                DataJson.Add('national_id', Emp."National Id");
                DataJson.Add('email', Emp."E-Mail");
                DataJson.Add('department', Emp.Department);
                DataJson.Add('designation', Emp."Job Title");
                DataJson.Add('payroll_period_start', Format(PeriodStartDate));
                DataJson.Add('payroll_period_end', Format(PeriodEndDate));
                DataJson.Add('payslip_month', Date2DMY(PeriodStartDate, 2));
                DataJson.Add('payslip_year', Date2DMY(PeriodStartDate, 3));
                DataJson.Add('date_filter', DateFilterText);

                // PDF details
                DataJson.Add('pdf_base64', vConvertedContent);
                DataJson.Add('file_name', FileName);
                DataJson.Add('file_size', varTempBlob.Length());
                DataJson.Add('generated_at', Format(CurrentDateTime));
                DataJson.Add('content_type', 'application/pdf');

                // Company information (if needed)
                if CompanyInformation.Get() then begin
                    DataJson.Add('company_name', CompanyInformation.Name);
                    DataJson.Add('company_display_name', CompanyProperty.DisplayName());
                end;



                // Add data to response
                ResponseJson.Add('data', DataJson);

            end else begin
                if GetLastErrorText() <> '' then
                    SetResponseStatus(ResponseJson, 'error', 'Payslip Generation Failed',
                        StrSubstNo('Staff Payslip report failed: %1', GetLastErrorText()))
                else
                    SetResponseStatus(ResponseJson, 'error', 'Payslip Generation Failed',
                        StrSubstNo('Staff Payslip report returned no PDF for employee %1 and payroll period %2', EmployeeNo, Format(PeriodStartDate)));
                exit(ResponseJson);
            end;
        end else begin
            SetResponseStatus(ResponseJson, 'error', 'Employee Data Not Found', 'No employee data found for the specified period');
            exit(ResponseJson);
        end;

        exit(ResponseJson);
    end;




    // Add this case to your main ProcessRequest procedure:


    // Add this function after the other get functions in your codeunit:

    local procedure GetStaffP9Form(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        Employee: Record Employee;
        PayrollP9Buffer: Record "Payroll P9 Buffer";
        //P9Report: Report "P9 Report Portal";
        varBase64Conversion: Codeunit "Base64 Convert";
        OStream: OutStream;
        IStream: InStream;
        varTempBlob: Codeunit "Temp Blob";
        DataJson: JsonObject;
        MemberId: Text;
        MemberNo: Code[20];
        SessionId: Text;
        Username: Text;
        P9Year: Integer;
        EmployeeNo: Code[20];
        vConvertedContent: Text;
        Emp: Record Employee;
        SaccoActivities: Codeunit "Sacco Activities";
        FileName: Text;
        CompanyInformation: Record "Company Information";
    begin

        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        if RequestJson.Contains('identifier') then
            MemberId := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        if RequestJson.Contains('year') then
            P9Year := SelectJsonToken(RequestJson, '$.year').AsValue.AsInteger;

        // Default to previous year
        if P9Year = 0 then
            P9Year := Date2DMY(Today, 3) - 1;

        // Validate session
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);

        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Session Invalid', 'Invalid session or user not found');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";

        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
            exit(ResponseJson);
        end;

        // Find employee
        Employee.Reset();
        Employee.SetRange("Member No", MemberNo);

        if not Employee.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Employee Not Found', 'Employee record not linked to member');
            exit(ResponseJson);
        end;

        EmployeeNo := Employee."No.";

        // Validate P9 data exists
        PayrollP9Buffer.Reset();
        PayrollP9Buffer.SetRange("Employee Code", EmployeeNo);
        PayrollP9Buffer.SetRange("Period Year", P9Year);

        if PayrollP9Buffer.IsEmpty then begin
            SetResponseStatus(ResponseJson, 'error', 'P9 Data Not Found',
            StrSubstNo('No P9 data found for employee %1 in year %2', EmployeeNo, P9Year));
            exit(ResponseJson);
        end;

        // Validate email
        if not SaccoActivities.ValidEmailAddress(Employee."E-Mail") then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Email', 'Employee email address is not valid');
            exit(ResponseJson);
        end;

        FileName := EmployeeNo + '-P9-' + Format(P9Year) + '.pdf';

        // Generate P9 Report
        Emp.Reset();
        Emp.SetRange("No.", EmployeeNo);


        /*
        if Emp.FindFirst() then begin

            varTempBlob.CreateOutStream(OStream);

            Clear(P9Report);

            // Pass employee filter
            P9Report.SetTableView(Emp);

            // VERY IMPORTANT: PASS THE YEAR TO THE REPORT
            P9Report.SetSelectedPeriod(P9Year);

            // Generate PDF
            P9Report.SaveAs('', ReportFormat::Pdf, OStream);

            // Convert PDF to Base64
            varTempBlob.CreateInStream(IStream);
            vConvertedContent := varBase64Conversion.ToBase64(IStream);

            // Build response
            SetResponseStatus(ResponseJson, 'success', 'P9 Form Retrieved', 'P9 form retrieved successfully');
            ResponseJson.Add('timestamp', Format(CurrentDateTime));

            DataJson.Add('member_id', MemberNo);
            DataJson.Add('employee_no', EmployeeNo);
            DataJson.Add('employee_name', Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name");
            DataJson.Add('employee_pin', Emp.PIN);
            DataJson.Add('email', Emp."E-Mail");
            DataJson.Add('department', Emp.Department);
            DataJson.Add('designation', Emp."Job Title");
            DataJson.Add('p9_year', P9Year);
            DataJson.Add('employment_date', Format(Emp."Employment Date"));

            // PDF
            DataJson.Add('pdf_base64', vConvertedContent);
            DataJson.Add('file_name', FileName);
            DataJson.Add('file_size', varTempBlob.Length());
            DataJson.Add('generated_at', Format(CurrentDateTime));
            DataJson.Add('content_type', 'application/pdf');

            // Company info
            if CompanyInformation.Get() then begin
                DataJson.Add('company_name', CompanyInformation.Name);
                DataJson.Add('employer_pin', CompanyInformation."KRA PIN");
            end;

            DataJson.Add('usage_note', 'This P9 form can be used for tax returns filing with KRA');
            DataJson.Add('validity_note', StrSubstNo('Valid for tax year %1', P9Year));
            DataJson.Add('filing_deadline', StrSubstNo('File your returns by 30th June %1', P9Year + 1));

            ResponseJson.Add('data', DataJson);

        end else begin
            SetResponseStatus(ResponseJson, 'error', 'Employee Data Not Found', 'No employee data found for P9 generation');
            exit(ResponseJson);
        end;

        */

        exit(ResponseJson);
    end;






    local procedure GetStaffP9FormOld(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        Employee: Record Employee;
        PayrollP9Buffer: Record "Payroll P9 Buffer";
        P9Report: Report "P9 Report";
        varBase64Conversion: Codeunit "Base64 Convert";
        OStream: OutStream;
        IStream: InStream;
        varTempBlob: Codeunit "Temp Blob";
        DataJson: JsonObject;
        MemberId: Text;
        MemberNo: Code[20];
        SessionId: Text;
        Username: Text;
        P9Year: Integer;
        EmployeeNo: Code[20];
        vConvertedContent: Text;
        Emp: Record Employee;
        SaccoActivities: Codeunit "Sacco Activities";
        FileName: Text;
        CompanyInformation: Record "Company Information";
        P9RecordsFound: Boolean;
    begin
        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        if RequestJson.Contains('identifier') then
            MemberId := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        // Get P9 parameters
        if RequestJson.Contains('year') then
            P9Year := SelectJsonToken(RequestJson, '$.year').AsValue.AsInteger;

        // Default to previous year if no year specified
        if P9Year = 0 then
            P9Year := Date2DMY(Today, 3) - 1;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Session Invalid', 'Invalid session or user not found');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
            exit(ResponseJson);
        end;

        // Find linked employee record
        Employee.Reset();
        Employee.SetRange("Member No", MemberNo);
        if not Employee.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Employee Not Found', 'Employee record not linked to member');
            exit(ResponseJson);
        end;

        EmployeeNo := Employee."No.";

        // Check if P9 data exists for the specified year
        PayrollP9Buffer.Reset();
        PayrollP9Buffer.SetRange("Employee Code", EmployeeNo);
        PayrollP9Buffer.SetRange("Period Year", P9Year);
        P9RecordsFound := PayrollP9Buffer.FindFirst();

        if not P9RecordsFound then begin
            SetResponseStatus(ResponseJson, 'error', 'P9 Data Not Found', StrSubstNo('No P9 data found for employee %1 in year %2', EmployeeNo, P9Year));
            exit(ResponseJson);
        end;

        // Validate email address (same validation as payslip report)
        if not SaccoActivities.ValidEmailAddress(Employee."E-Mail") then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Email', 'Employee email address is not valid');
            exit(ResponseJson);
        end;

        // Generate filename
        FileName := EmployeeNo + '-P9-' + Format(P9Year) + '.pdf';

        // Generate P9 report to TempBlob (same approach as payslip)
        Emp.Reset();
        Emp.SetRange("No.", EmployeeNo);

        if Emp.FindFirst() then begin
            // Validate employee PIN (P9 requirement)
            if Emp.PIN = '' then begin
                //SetResponseStatus(ResponseJson, 'error', 'Missing PIN', 'Employee PIN is required for P9 generation');
                //exit(ResponseJson);
            end;

            // Create TempBlob output stream
            varTempBlob.CreateOutStream(OStream);

            // Initialize and run the P9 Report
            Clear(P9Report);
            P9Report.SetTableView(Emp);

            // Set the selected period for the report (this is how the P9 report expects the year)
            // The P9 report uses a SelectedPeriod variable that needs to be set

            if P9Report.SaveAs('', ReportFormat::Pdf, OStream) then begin
                // Convert to Base64
                varTempBlob.CreateInStream(IStream);
                vConvertedContent := varBase64Conversion.ToBase64(IStream);


            end;
            // Initialize response
            SetResponseStatus(ResponseJson, 'success', 'P9 Form Retrieved', 'P9 form retrieved successfully');
            ResponseJson.Add('timestamp', Format(CurrentDateTime));

            // Create data object
            DataJson.Add('member_id', MemberNo);
            DataJson.Add('employee_no', EmployeeNo);
            DataJson.Add('employee_name', Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name");
            DataJson.Add('employee_pin', Emp.PIN);
            DataJson.Add('email', Emp."E-Mail");
            DataJson.Add('department', Emp.Department);
            DataJson.Add('designation', Emp."Job Title");
            DataJson.Add('p9_year', P9Year);
            DataJson.Add('employment_date', Format(Emp."Employment Date"));

            // PDF details
            DataJson.Add('pdf_base64', vConvertedContent);
            DataJson.Add('file_name', FileName);
            DataJson.Add('file_size', varTempBlob.Length());
            DataJson.Add('generated_at', Format(CurrentDateTime));
            DataJson.Add('content_type', 'application/pdf');

            // Company information
            if CompanyInformation.Get() then begin
                DataJson.Add('company_name', CompanyInformation.Name);
                DataJson.Add('employer_pin', CompanyInformation."KRA PIN");
            end;


            // Add usage notes
            DataJson.Add('usage_note', 'This P9 form can be used for tax returns filing with KRA');
            DataJson.Add('validity_note', StrSubstNo('Valid for tax year %1', P9Year));
            DataJson.Add('filing_deadline', StrSubstNo('File your returns by 30th June %1', P9Year + 1));

            // Add data to response
            ResponseJson.Add('data', DataJson);

        end else begin
            SetResponseStatus(ResponseJson, 'error', 'Employee Data Not Found', 'No employee data found for P9 generation');
            exit(ResponseJson);
        end;

        exit(ResponseJson);
    end;





    local procedure GetComprehensiveApprovalData(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        Tracker: Record "Approval Tracker";
        PortalAuth: Record "Portal Auth";
        Employee: Record Employee;
        HRLeaveApplication: Record "HR Leave Application.";
        HRLeaveTypes: Record "HR Leave Types.";
        DataJson: JsonObject;
        PendingApprovalsArray: JsonArray;
        RecentApprovalsArray: JsonArray;
        ApprovalHistoryArray: JsonArray;
        StatisticsJson: JsonObject;
        ApplicationJson: JsonObject;
        Username: Text;
        MemberNo: Code[20];
        EmployeeNo: Code[20];
        SupervisorCode: Text;
        Year: Integer;
        DaysBack: Integer;
        IncludePendingApprovals: Boolean;
        IncludeRecentApprovals: Boolean;
        IncludeApprovalStatistics: Boolean;
        IncludeApprovalHistory: Boolean;
        PendingCount: Integer;
        UrgentCount: Integer;
        ApprovedToday: Integer;
        AvgProcessingTime: Decimal;
        TotalProcessingDays: Integer;
        ProcessedCount: Integer;
        FilterStartDate: Date;
        UrgentDate: Date;
        StatusColor: Text;
        CanApprove: Boolean;
        ApprovalEntries: Record "Approval Entry";
        ProcessedPendingApps: List of [Text];
        ProcessedRecentApps: List of [Text];
        ProcessedHistoryApps: List of [Text];
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        if RequestJson.Contains('year') then
            Year := SelectJsonToken(RequestJson, '$.year').AsValue.AsInteger
        else
            Year := Date2DMY(Today, 3);

        if RequestJson.Contains('days_back') then
            DaysBack := SelectJsonToken(RequestJson, '$.days_back').AsValue.AsInteger
        else
            DaysBack := 30;

        if RequestJson.Contains('include_pending_approvals') then
            IncludePendingApprovals := SelectJsonToken(RequestJson, '$.include_pending_approvals').AsValue.AsBoolean
        else
            IncludePendingApprovals := true;

        if RequestJson.Contains('include_recent_approvals') then
            IncludeRecentApprovals := SelectJsonToken(RequestJson, '$.include_recent_approvals').AsValue.AsBoolean
        else
            IncludeRecentApprovals := true;

        if RequestJson.Contains('include_approval_statistics') then
            IncludeApprovalStatistics := SelectJsonToken(RequestJson, '$.include_approval_statistics').AsValue.AsBoolean
        else
            IncludeApprovalStatistics := true;

        if RequestJson.Contains('include_approval_history') then
            IncludeApprovalHistory := SelectJsonToken(RequestJson, '$.include_approval_history').AsValue.AsBoolean
        else
            IncludeApprovalHistory := true;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Session Invalid', 'Invalid session or user not found');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Member record not found');
            exit(ResponseJson);
        end;

        // Find linked employee record to get supervisor code
        Employee.Reset();
        Employee.SetRange("Member No", MemberNo);
        if not Employee.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Employee Not Found', 'Employee record not linked to member');
            exit(ResponseJson);
        end;

        EmployeeNo := Employee."No.";
        SupervisorCode := Employee."User ID"; // Assuming User ID is used as supervisor code

        // Calculate filter dates
        FilterStartDate := CalcDate(StrSubstNo('<-%1D>', DaysBack), Today);
        UrgentDate := CalcDate('<+7D>', Today); // Applications with start date within 7 days are urgent

        // Initialize counters
        PendingCount := 0;
        UrgentCount := 0;
        ApprovedToday := 0;
        TotalProcessingDays := 0;
        ProcessedCount := 0;

        // Build pending approvals

        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Custom Document Type", ApprovalEntries."Custom Document Type"::Leave);
        //ApprovalEntries.SetRange("Approver ID", Employee."User ID");
        ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Open);
        if ApprovalEntries.FindFirst() then begin
            repeat
                if Tracker.get(ApprovalEntries."Tracker ID") then begin


                    HRLeaveApplication.Reset();
                    HRLeaveApplication.SetRange("Application Code", Tracker."Document No.");
                    HRLeaveApplication.SetRange(Status, HRLeaveApplication.Status::"Pending Approval");
                    HRLeaveApplication.SetCurrentKey("Application Date");
                    HRLeaveApplication.Ascending(false);

                    if HRLeaveApplication.FindSet() then begin
                        repeat


                            if not ProcessedPendingApps.Contains(HRLeaveApplication."Application Code") then begin
                                ProcessedPendingApps.Add(HRLeaveApplication."Application Code");

                                PendingCount += 1;

                                // Check if urgent (start date within 7 days)
                                if HRLeaveApplication."Start Date" <= UrgentDate then
                                    UrgentCount += 1;

                                Clear(ApplicationJson);

                                // Determine status color based on urgency
                                if HRLeaveApplication."Start Date" <= CalcDate('<+3D>', Today) then
                                    StatusColor := 'red'
                                else if HRLeaveApplication."Start Date" <= UrgentDate then
                                    StatusColor := 'yellow'
                                else
                                    StatusColor := 'blue';

                                CanApprove := true; // User is supervisor, so can approve

                                ApplicationJson.Add('id', HRLeaveApplication."Application Code");
                                ApplicationJson.Add('employee_name', HRLeaveApplication.Names);
                                ApplicationJson.Add('employee_id', HRLeaveApplication."Applicant Staff No.");
                                ApplicationJson.Add('leave_type', HRLeaveApplication.Description);
                                ApplicationJson.Add('leave_type_code', HRLeaveApplication."Leave Type");
                                ApplicationJson.Add('start_date', Format(HRLeaveApplication."Start Date"));
                                ApplicationJson.Add('end_date', Format(HRLeaveApplication."End Date"));
                                ApplicationJson.Add('days_requested', HRLeaveApplication."Days Applied");
                                ApplicationJson.Add('status', 'Pending Review');
                                ApplicationJson.Add('status_color', StatusColor);
                                ApplicationJson.Add('submitted_date', yyyyMMdd(HRLeaveApplication."Application Date"));
                                ApplicationJson.Add('reason', HRLeaveApplication."Applicant Comments");
                                ApplicationJson.Add('reliever_name', HRLeaveApplication."Reliever Name");
                                ApplicationJson.Add('reliever_code', HRLeaveApplication.Reliever);
                                ApplicationJson.Add('can_approve', CanApprove);

                                // Calculate days since submission
                                ApplicationJson.Add('days_pending', Today - HRLeaveApplication."Application Date");

                                // Add urgency flag
                                ApplicationJson.Add('is_urgent', HRLeaveApplication."Start Date" <= UrgentDate);

                                PendingApprovalsArray.Add(ApplicationJson);
                            end;
                        until HRLeaveApplication.Next() = 0;
                    end;

                end;

            until ApprovalEntries.next = 0;
        end;

        // Build recent approvals
        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Custom Document Type", ApprovalEntries."Custom Document Type"::Leave);
        //ApprovalEntries.SetRange("Approver ID", Employee."User ID");
        ApprovalEntries.SetFilter(Status, '%1|%2', ApprovalEntries.Status::Approved, ApprovalEntries.Status::Rejected);
        if ApprovalEntries.FindFirst() then begin
            repeat

                if Tracker.get(ApprovalEntries."Tracker ID") then begin

                    HRLeaveApplication.Reset();
                    HRLeaveApplication.SetRange("Application Code", Tracker."Document No.");
                    HRLeaveApplication.SetFilter(Status, '%1|%2', HRLeaveApplication.Status::Approved, HRLeaveApplication.Status::Rejected);
                    HRLeaveApplication.Ascending(false);
                    if HRLeaveApplication.FindSet() then begin
                        repeat


                            if not ProcessedRecentApps.Contains(HRLeaveApplication."Application Code") then begin
                                ProcessedRecentApps.Add(HRLeaveApplication."Application Code");

                                ProcessedCount += 1;

                                // Calculate processing time
                                if DT2Date(ApprovalEntries."Last Date-Time Modified") <> 0D then
                                    TotalProcessingDays += DT2Date(ApprovalEntries."Last Date-Time Modified") - HRLeaveApplication."Application Date";

                                // Count approvals processed today
                                if DT2Date(ApprovalEntries."Last Date-Time Modified") = Today then
                                    ApprovedToday += 1;

                                Clear(ApplicationJson);

                                // Determine status color
                                case HRLeaveApplication.Status of
                                    HRLeaveApplication.Status::Approved:
                                        StatusColor := 'green';
                                    HRLeaveApplication.Status::Rejected:
                                        StatusColor := 'red';
                                    else
                                        StatusColor := 'gray';
                                end;

                                ApplicationJson.Add('id', HRLeaveApplication."Application Code");
                                ApplicationJson.Add('employee_name', HRLeaveApplication.Names);
                                ApplicationJson.Add('employee_id', HRLeaveApplication."Applicant Staff No.");
                                ApplicationJson.Add('leave_type', HRLeaveApplication.Description);
                                ApplicationJson.Add('leave_type_code', HRLeaveApplication."Leave Type");
                                ApplicationJson.Add('start_date', Format(HRLeaveApplication."Start Date"));
                                ApplicationJson.Add('end_date', Format(HRLeaveApplication."End Date"));
                                ApplicationJson.Add('days_requested', HRLeaveApplication."Days Applied");
                                ApplicationJson.Add('status', Format(HRLeaveApplication.Status));
                                ApplicationJson.Add('status_color', StatusColor);
                                ApplicationJson.Add('processed_date', Format(DT2Date(ApprovalEntries."Last Date-Time Modified")));
                                ApplicationJson.Add('reason', HRLeaveApplication."Applicant Comments");
                                ApplicationJson.Add('processed_by', MemberNo);
                                ApplicationJson.Add('approver_comments', HRLeaveApplication."Approver Comments");

                                // Calculate processing time in days
                                if ApprovalEntries."Last Date-Time Modified" <> 0DT then
                                    ApplicationJson.Add('processing_time_days', Round((DT2Date(ApprovalEntries."Last Date-Time Modified") - HRLeaveApplication."Application Date"), 1))
                                else
                                    ApplicationJson.Add('processing_time_days', 0);

                                RecentApprovalsArray.Add(ApplicationJson);
                            end;
                        until HRLeaveApplication.Next() = 0;
                    end;

                end;
            until ApprovalEntries.next = 0;
        end;

        // Build approval history (if requested)
        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Custom Document Type", ApprovalEntries."Custom Document Type"::Leave);
        //ApprovalEntries.SetRange("Approver ID", Employee."User ID");
        ApprovalEntries.SetFilter(Status, '%1|%2', ApprovalEntries.Status::Approved, ApprovalEntries.Status::Rejected);
        if ApprovalEntries.FindFirst() then begin
            repeat

                if Tracker.get(ApprovalEntries."Tracker ID") then begin
                    HRLeaveApplication.Reset();
                    HRLeaveApplication.SetRange("Application Code", Tracker."Document No.");
                    HRLeaveApplication.SetFilter("Application Date", '>=%1', DMY2Date(1, 1, Year));
                    HRLeaveApplication.SetFilter("Application Date", '<=%1', DMY2Date(31, 12, Year));
                    HRLeaveApplication.SetCurrentKey("Application Date");
                    HRLeaveApplication.Ascending(false);

                    if HRLeaveApplication.FindSet() then begin
                        repeat


                            if not ProcessedHistoryApps.Contains(HRLeaveApplication."Application Code") then begin
                                ProcessedHistoryApps.Add(HRLeaveApplication."Application Code");

                                Clear(ApplicationJson);

                                // Determine status color
                                case HRLeaveApplication.Status of
                                    HRLeaveApplication.Status::Approved:
                                        StatusColor := 'green';
                                    HRLeaveApplication.Status::Rejected:
                                        StatusColor := 'red';
                                    HRLeaveApplication.Status::"Pending Approval":
                                        StatusColor := 'yellow';
                                    else
                                        StatusColor := 'blue';
                                end;

                                ApplicationJson.Add('id', HRLeaveApplication."Application Code");
                                ApplicationJson.Add('employee_name', HRLeaveApplication.Names);
                                ApplicationJson.Add('employee_id', HRLeaveApplication."Applicant Staff No.");
                                ApplicationJson.Add('leave_type', HRLeaveApplication.Description);
                                ApplicationJson.Add('start_date', Format(HRLeaveApplication."Start Date"));
                                ApplicationJson.Add('end_date', Format(HRLeaveApplication."End Date"));
                                ApplicationJson.Add('days_requested', HRLeaveApplication."Days Applied");
                                ApplicationJson.Add('status', Format(HRLeaveApplication.Status));
                                ApplicationJson.Add('status_color', StatusColor);
                                ApplicationJson.Add('application_date', Format(HRLeaveApplication."Application Date"));
                                ApplicationJson.Add('reason', HRLeaveApplication."Applicant Comments");

                                if ApprovalEntries."Last Date-Time Modified" <> 0DT then
                                    ApplicationJson.Add('processed_date', Format(DT2Date(ApprovalEntries."Last Date-Time Modified")))
                                else
                                    ApplicationJson.Add('processed_date', '');

                                ApprovalHistoryArray.Add(ApplicationJson);
                            end;
                        until HRLeaveApplication.Next() = 0;
                    end;
                end;
            until ApprovalEntries.next = 0;
        end;

        // Build statistics
        if IncludeApprovalStatistics then begin
            // Calculate average processing time
            if ProcessedCount > 0 then
                AvgProcessingTime := Round(TotalProcessingDays / ProcessedCount / 86400000, 1) // Convert to days
            else
                AvgProcessingTime := 0;

            StatisticsJson.Add('pending_count', PendingCount);
            StatisticsJson.Add('urgent_count', UrgentCount);
            StatisticsJson.Add('approved_today', ApprovedToday);
            StatisticsJson.Add('avg_processing_time', Format(AvgProcessingTime));
            StatisticsJson.Add('processed_last_30_days', ProcessedCount);
            StatisticsJson.Add('year', Year);
            StatisticsJson.Add('days_back', DaysBack);

            // Additional statistics
            StatisticsJson.Add('overdue_count', GetOverdueApprovalsCount(SupervisorCode));
            StatisticsJson.Add('approval_rate', CalculateApprovalRate(SupervisorCode, Year));
        end;

        // Build main response
        DataJson.Add('member_id', MemberNo);
        DataJson.Add('employee_no', EmployeeNo);
        DataJson.Add('supervisor_code', SupervisorCode);
        DataJson.Add('year', Year);
        DataJson.Add('days_back', DaysBack);

        if IncludePendingApprovals then
            DataJson.Add('pending_approvals', PendingApprovalsArray);

        if IncludeRecentApprovals then
            DataJson.Add('recent_approvals', RecentApprovalsArray);

        if IncludeApprovalHistory then
            DataJson.Add('approval_history', ApprovalHistoryArray);

        if IncludeApprovalStatistics then
            DataJson.Add('statistics', StatisticsJson);

        SetResponseStatus(ResponseJson, 'success', 'Approval Data Retrieved', 'Comprehensive approval data retrieved successfully');
        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;

    // Helper functions

    local procedure GetOverdueApprovalsCount(SupervisorCode: Text): Integer
    var
        HRLeaveApplication: Record "HR Leave Application.";
        OverdueCount: Integer;
    begin
        OverdueCount := 0;

        HRLeaveApplication.Reset();
        HRLeaveApplication.SetRange("Applicant Supervisor", SupervisorCode);
        HRLeaveApplication.SetRange(Status, HRLeaveApplication.Status::"Pending Approval");
        HRLeaveApplication.SetFilter("Start Date", '<%1', Today);

        if HRLeaveApplication.FindSet() then
            OverdueCount := HRLeaveApplication.Count;

        exit(OverdueCount);
    end;

    local procedure CalculateApprovalRate(SupervisorCode: Text; Year: Integer): Decimal
    var
        HRLeaveApplication: Record "HR Leave Application.";
        TotalApplications: Integer;
        ApprovedApplications: Integer;
        ApprovalRate: Decimal;
    begin
        // Count total applications for the year
        HRLeaveApplication.Reset();
        HRLeaveApplication.SetRange("Applicant Supervisor", SupervisorCode);
        HRLeaveApplication.SetFilter("Application Date", '>=%1', DMY2Date(1, 1, Year));
        HRLeaveApplication.SetFilter("Application Date", '<=%1', DMY2Date(31, 12, Year));
        HRLeaveApplication.SetFilter(Status, '<>%1', HRLeaveApplication.Status::New);
        TotalApplications := HRLeaveApplication.Count;

        // Count approved applications
        HRLeaveApplication.SetRange(Status, HRLeaveApplication.Status::Approved);
        ApprovedApplications := HRLeaveApplication.Count;

        // Calculate approval rate
        if TotalApplications > 0 then
            ApprovalRate := Round((ApprovedApplications / TotalApplications) * 100, 1)
        else
            ApprovalRate := 0;

        exit(ApprovalRate);
    end;



    local procedure GetLeaveApplicationReport(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        Employee: Record Employee;
        HRLeaveApplication: Record "HR Leave Application.";
        HRLeaveApplicationsReport: Report "HR Leave Applications";
        varBase64Conversion: Codeunit "Base64 Convert";
        OStream: OutStream;
        IStream: InStream;
        varTempBlob: Codeunit "Temp Blob";
        DataJson: JsonObject;
        MemberId: Text;
        MemberNo: Code[20];
        SessionId: Text;
        Username: Text;
        EmployeeNo: Code[20];
        vConvertedContent: Text;
        FileName: Text;
        CompanyInformation: Record "Company Information";
        FilterStartDate: Date;
        FilterEndDate: Date;
        Year: Integer;
        DaysBack: Integer;
        ApplicationCode: Text;
        ReportTitle: Text;
    begin
        // Extract request parameters
        if RequestJson.Contains('member_id') then
            MemberId := SelectJsonToken(RequestJson, '$.member_id').AsValue.AsText;

        if RequestJson.Contains('session_id') then
            SessionId := SelectJsonToken(RequestJson, '$.session_id').AsValue.AsText;

        if RequestJson.Contains('username') then
            Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;

        if RequestJson.Contains('identifier') then
            MemberId := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        // Get optional filter parameters
        if RequestJson.Contains('year') then
            Year := SelectJsonToken(RequestJson, '$.year').AsValue.AsInteger
        else
            Year := Date2DMY(Today, 3);

        if RequestJson.Contains('days_back') then
            DaysBack := SelectJsonToken(RequestJson, '$.days_back').AsValue.AsInteger
        else
            DaysBack := 365; // Default to current year

        if RequestJson.Contains('application_code') then
            ApplicationCode := SelectJsonToken(RequestJson, '$.application_code').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Session Invalid', 'Invalid session or user not found');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details.');
            exit(ResponseJson);
        end;

        // Find linked employee record
        Employee.Reset();
        Employee.SetRange("Member No", MemberNo);
        if not Employee.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Employee Not Found', 'Employee record not linked to member');
            exit(ResponseJson);
        end;

        EmployeeNo := Employee."No.";

        // Calculate filter dates
        FilterStartDate := CalcDate(StrSubstNo('<-%1D>', DaysBack), Today);
        FilterEndDate := Today;

        // Set up filters for HR Leave Applications
        HRLeaveApplication.Reset();

        HRLeaveApplication.SetRange("Application Code", ApplicationCode);
        ReportTitle := 'Leave Application - ' + ApplicationCode;
        FileName := EmployeeNo + '-LeaveApp-' + ApplicationCode + '.pdf';

        if not HRLeaveApplication.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'No Leave Applications Found', 'No leave applications found for the specified criteria');
            exit(ResponseJson);
        end;

        // Generate PDF using the HR Leave Applications report
        varTempBlob.CreateOutStream(OStream);

        Clear(HRLeaveApplicationsReport);
        HRLeaveApplicationsReport.SetTableView(HRLeaveApplication);

        if HRLeaveApplicationsReport.SaveAs('', ReportFormat::Pdf, OStream) then begin
            // Convert to Base64
            varTempBlob.CreateInStream(IStream);
            vConvertedContent := varBase64Conversion.ToBase64(IStream);

            // Initialize response
            SetResponseStatus(ResponseJson, 'success', 'Leave Application Report Retrieved', 'Leave application report generated successfully');
            ResponseJson.Add('timestamp', Format(CurrentDateTime));

            // Create data object
            DataJson.Add('member_id', MemberNo);
            DataJson.Add('employee_no', EmployeeNo);
            DataJson.Add('employee_name', Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
            DataJson.Add('department', Employee.Department);
            DataJson.Add('designation', Employee."Job Title");
            DataJson.Add('report_title', ReportTitle);
            DataJson.Add('filter_start_date', Format(FilterStartDate));
            DataJson.Add('filter_end_date', Format(FilterEndDate));
            DataJson.Add('year', Year);
            DataJson.Add('days_back', DaysBack);

            // PDF details
            DataJson.Add('pdf_base64', vConvertedContent);
            DataJson.Add('file_name', FileName);
            DataJson.Add('file_size', varTempBlob.Length());
            DataJson.Add('generated_at', Format(CurrentDateTime));
            DataJson.Add('content_type', 'application/pdf');

            // Company information
            if CompanyInformation.Get() then begin
                DataJson.Add('company_name', CompanyInformation.Name);
            end;

            // Report metadata
            DataJson.Add('applications_included', HRLeaveApplication.Count);
            if ApplicationCode <> '' then begin
                DataJson.Add('specific_application', true);
                DataJson.Add('application_code', ApplicationCode);
            end else begin
                DataJson.Add('specific_application', false);
                DataJson.Add('report_type', 'Summary Report');
            end;

            // Add usage notes
            DataJson.Add('usage_note', 'This report contains leave application details and can be used for record keeping');
            DataJson.Add('confidentiality_note', 'This document contains confidential employee information');

            // Add data to response
            ResponseJson.Add('data', DataJson);

        end else begin
            SetResponseStatus(ResponseJson, 'error', 'Report Generation Failed', 'Could not generate leave application report PDF');
            exit(ResponseJson);
        end;

        exit(ResponseJson);
    end;




    local procedure CreateSavingsAccount(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        SavingsAccounts: Record "Savings Accounts";
        ProductSetup: Record "Product Setup";
        MemberActivities: Codeunit "Member Activities";
        SaccoSetup: Record "Sacco Setup";
        DataJson: JsonObject;
        StandingOrderJson: JsonObject;
        Username: Text;
        IdentifierType: Text;
        Identifier: Text;
        MemberNo: Code[20];
        ProductCode: Code[20];
        AccountName: Text[100];
        InitialDeposit: Decimal;
        PaymentMethod: Text;
        StandingOrderAmount: Decimal;
        StandingOrderStartDate: Date;
        StandingOrderFrequency: Text;
        StandingOrderType: Text;
        NewAccountNo: Code[20];
        ProductFound: Boolean;
        AccountCreated: Boolean;
        ErrorMessage: Text;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        ProductCode := CopyStr(SelectJsonToken(RequestJson, '$.product_code').AsValue.AsText, 1, 20);
        AccountName := CopyStr(SelectJsonToken(RequestJson, '$.account_name').AsValue.AsText, 1, 100);

        // Parse initial deposit
        if not Evaluate(InitialDeposit, SelectJsonToken(RequestJson, '$.initial_deposit').AsValue.AsText) then
            InitialDeposit := 0;

        PaymentMethod := SelectJsonToken(RequestJson, '$.payment_method').AsValue.AsText;

        // Extract standing order details if provided
        if RequestJson.Contains('standing_order') then begin
            StandingOrderJson := SelectJsonToken(RequestJson, '$.standing_order').AsObject;

            if not Evaluate(StandingOrderAmount, SelectJsonToken(StandingOrderJson, '$.amount').AsValue.AsText) then
                StandingOrderAmount := 0;

            if not Evaluate(StandingOrderStartDate, SelectJsonToken(StandingOrderJson, '$.start_date').AsValue.AsText) then
                StandingOrderStartDate := 0D;

            StandingOrderFrequency := SelectJsonToken(StandingOrderJson, '$.frequency').AsValue.AsText;
            StandingOrderType := SelectJsonToken(StandingOrderJson, '$.type').AsValue.AsText;
        end;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Validate that the identifier matches the session member
        if Identifier <> MemberNo then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Identifier', 'Identifier does not match session member');
            exit(ResponseJson);
        end;

        // Validate product exists and is available for portal
        ProductSetup.Reset();
        ProductSetup.SetRange("Product ID", ProductCode);
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Savings);
        ProductSetup.SetRange("Available on Portal", true);
        ProductFound := ProductSetup.FindFirst();

        if not ProductFound then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Product', 'Savings product not found or not available for online opening');
            exit(ResponseJson);
        end;

        // Check if member already has this type of account
        SavingsAccounts.Reset();
        SavingsAccounts.SetRange("Member No.", MemberNo);
        SavingsAccounts.SetRange("Product Type", ProductCode);
        if SavingsAccounts.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Account Already Exists', 'You already have an account of this type');
            exit(ResponseJson);
        end;

        /*
        // Validate minimum opening balance
        if InitialDeposit < ProductSetup."Minimum Balance" then begin
            SetResponseStatus(ResponseJson, 'error', 'Insufficient Initial Deposit', 
                             StrSubstNo('Minimum opening balance for %1 is KES %2', 
                                       ProductSetup.Description, ProductSetup."Minimum Balance"));
            exit(ResponseJson);
        end;
        */
        // Create new savings account
        AccountCreated := false;

        MemberActivities.CreateSavingsAccount(ProductSetup, Members, 0, true, ProductSetup."Repay Mode");
        AccountCreated := true;

        if AccountCreated then begin
            SavingsAccounts.Reset();
            SavingsAccounts.SetRange("Member No.", MemberNo);
            SavingsAccounts.SetRange("Product Type", ProductCode);
            SavingsAccounts.Ascending(false); // Get the most recent one
            if SavingsAccounts.FindFirst() then begin
                NewAccountNo := SavingsAccounts."No.";
            end;
        end;
        // Build success response
        SetResponseStatus(ResponseJson, 'success', 'Account Created Successfully',
                         'Your savings account has been created successfully');

        // Create response data
        DataJson.Add('account_created', true);
        DataJson.Add('account_number', NewAccountNo);

        // Add standing order details if configured
        if StandingOrderAmount > 0 then begin
            CreateSavingsStandingOrder(SavingsAccounts, StandingOrderAmount, StandingOrderFrequency, StandingOrderType, StandingOrderStartDate);
            SavingsAccounts.Modify(true);
            DataJson.Add('standing_order_configured', true);
            DataJson.Add('standing_order_amount', StandingOrderAmount);
            DataJson.Add('standing_order_start_date', Format(StandingOrderStartDate));
            DataJson.Add('standing_order_frequency', StandingOrderFrequency);
        end else begin
            DataJson.Add('standing_order_configured', false);
        end;

        DataJson.Add('payment_method', PaymentMethod);
        DataJson.Add('next_steps', 'Complete your initial deposit to activate the account');
        DataJson.Add('account_activation_required', InitialDeposit = 0);

        ResponseJson.Add('data', DataJson);



        ResponseJson.Add('timestamp', Format(CurrentDateTime));
        exit(ResponseJson);
    end;

    procedure CreateSavingsStandingOrder(VAR SavingsAccounts: Record "Savings Accounts"; StandingOrderAmount: Decimal; Frequency: Text; StandingOrderType: Text; StartDate: Date)
    var
        STOHeader: Record "Standing Order Header";
        STOLines: Record "Standing Order Lines";
        SourceAccount: Record "Savings Accounts";
        Members: Record Members;
        Legacy: Codeunit Legacy;
        FrequencyDateFormula: DateFormula;
    begin
        // Validate standing order amount
        if StandingOrderAmount <= 0 then
            exit;


        // Get member details
        if not Members.Get(SavingsAccounts."Member No.") then
            exit;

        // Get source account (member's ordinary savings account)
        SourceAccount.Reset();
        SourceAccount.SetRange("Member No.", SavingsAccounts."Member No.");
        SourceAccount.SetRange("Product Category", SourceAccount."Product Category"::"Ordinary Savings");
        if not SourceAccount.FindFirst() then begin
            Error('No ordinary savings account found for member');
        end;

        // Create new standing order
        STOHeader.Init();
        STOHeader.Code := '';
        STOHeader."Source Account Type" := STOHeader."Source Account Type"::Savings;
        STOHeader.Validate("Source Account No.", SourceAccount."No.");
        STOHeader.Description := 'Auto Save - ' + SavingsAccounts."Product Name";
        STOHeader.Amount := StandingOrderAmount;
        STOHeader."Allow Partial Deduction" := true;
        if StandingOrderType = 'SALARY_BASED' then
            STOHeader."Income Type" := STOHeader."Income Type"::Salary
        else
            STOHeader."Income Type" := STOHeader."Income Type"::Business;
        STOHeader."Created By" := UserId;
        STOHeader.Status := STOHeader.Status::Approved;

        if StartDate < Today then
            StartDate := calcDate('1M', StartDate);

        STOHeader."Effective/Start Date" := StartDate;

        // Set frequency based on user input (default monthly)
        case LowerCase(Frequency) of
            'weekly':
                Evaluate(FrequencyDateFormula, '1W');
            'fortnightly':
                Evaluate(FrequencyDateFormula, '2W');
            'monthly':
                Evaluate(FrequencyDateFormula, '1M');
            'quarterly':
                Evaluate(FrequencyDateFormula, '3M');
            'annually':
                Evaluate(FrequencyDateFormula, '12M');
            else
                Evaluate(FrequencyDateFormula, '1M'); // Default to monthly
        end;

        STOHeader."Frequency (Months)" := FrequencyDateFormula;
        Evaluate(STOHeader."Duration (Months)", '999M'); // Long duration for savings
        STOHeader.Validate("Duration (Months)");
        STOHeader."Auto Process" := true;
        STOHeader.Insert(true);


        // Create standing order line
        STOLines.Init();
        STOLines."Document No." := STOHeader.Code;
        STOLines."Member No." := SavingsAccounts."Member No.";
        STOLines."Destination Account Type" := STOLines."Destination Account Type"::Internal;
        STOLines."Destination Account No." := SavingsAccounts."No.";
        STOLines.Validate("Destination Account No.");
        STOLines.Amount := STOHeader.Amount;
        //STOLines.Description := 'Monthly Savings - ' + SavingsAccounts."Product Name";
        STOLines.Insert();
    end;




    local procedure CreateFixedDeposit(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        MemberActivities: Codeunit "Member Activities";
        PortalAuth: Record "Portal Auth";
        FixedDepositAccounts: Record "Fixed Deposit Accounts";
        FDTypes: Record "FD Types";
        SavingsAccounts: Record "Savings Accounts";
        ProductSetup: Record "Product Setup";
        SaccoSetup: Record "Sacco Setup";
        NoSeries: Codeunit "No. Series";
        DataJson: JsonObject;
        Username: Text;
        IdentifierType: Text;
        Identifier: Text;
        MemberNo: Code[20];
        DepositAmount: Decimal;
        TermMonths: Integer;
        MaturityInstructions: Text;
        FDTypeCode: Code[20];
        NewFDAccountNo: Code[20];
        InterestRate: Decimal;
        MaturityDate: Date;
        MonthlyInterest: Decimal;
        TotalExpectedInterest: Decimal;
        SourceAccount: Code[20];
        FDCreated: Boolean;
        ErrorMessage: Text;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        // Parse deposit amount
        if not Evaluate(DepositAmount, SelectJsonToken(RequestJson, '$.deposit_amount').AsValue.AsText) then
            DepositAmount := 0;

        // Parse term months
        if not Evaluate(TermMonths, SelectJsonToken(RequestJson, '$.term_months').AsValue.AsText) then
            TermMonths := 0;

        MaturityInstructions := SelectJsonToken(RequestJson, '$.maturity_instructions').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Validate that the identifier matches the session member
        if Identifier <> MemberNo then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Identifier', 'Identifier does not match session member');
            exit(ResponseJson);
        end;

        // Validate deposit amount
        if DepositAmount <= 0 then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Amount', 'Deposit amount must be greater than zero');
            exit(ResponseJson);
        end;

        // Validate term months
        if TermMonths <= 0 then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Term', 'Term must be greater than zero months');
            exit(ResponseJson);
        end;

        // Find appropriate FD Type based on term
        FDTypes.Reset();
        FDTypes.SetRange(Months, TermMonths);
        if not FDTypes.FindFirst() then begin
            // Try to find the closest FD type
            FDTypes.Reset();
            FDTypes.SetFilter(Months, '>=%1', TermMonths);
            if not FDTypes.FindFirst() then begin
                FDTypes.Reset();
                if FDTypes.FindFirst() then
                    FDTypeCode := FDTypes.Code
                else begin
                    SetResponseStatus(ResponseJson, 'error', 'No FD Types Available', 'No fixed deposit types are configured');
                    exit(ResponseJson);
                end;
            end else
                FDTypeCode := FDTypes.Code;
        end else
            FDTypeCode := FDTypes.Code;


        // Get member's source account (deposit account)
        SourceAccount := Legacy.GetOrdinaryAccount(MemberNo);
        if not SavingsAccounts.Get(SourceAccount) then begin
            SetResponseStatus(ResponseJson, 'error', 'Source Account Not Found', 'Member deposit account not found');
            exit(ResponseJson);
        end;

        // Check if member has sufficient balance
        SavingsAccounts.CalcFields("Balance (LCY)");
        if MemberActivities.GetAccountBalance(SourceAccount) < DepositAmount then begin
            SetResponseStatus(ResponseJson, 'error', 'Insufficient Balance',
                             StrSubstNo('Insufficient balance in deposit account. Available: KES %1, Required: KES %2',
                                       MemberActivities.GetAccountBalance(SourceAccount), DepositAmount));
            exit(ResponseJson);
        end;



        // Create Fixed Deposit Account record
        FDCreated := CreateFixedDepositRecord(
            MemberNo, Members.Name, FDTypeCode, DepositAmount, TermMonths,
            InterestRate, MaturityDate, MaturityInstructions, MonthlyInterest,
            TotalExpectedInterest, SourceAccount, NewFDAccountNo, ErrorMessage);

        if not FDCreated then begin
            SetResponseStatus(ResponseJson, 'error', 'FD Creation Failed', ErrorMessage);
            exit(ResponseJson);
        end;

        // Log the FD creation
        LogSecurityEvent('FixedDepositCreated', Username,
                        StrSubstNo('Fixed deposit %1 created for member %2. Amount: KES %3, Term: %4 months',
                                 NewFDAccountNo, MemberNo, DepositAmount, TermMonths), false);

        // Build success response
        SetResponseStatus(ResponseJson, 'success', 'Fixed Deposit Created', 'Your fixed deposit has been created successfully');

        // Create response data
        DataJson.Add('fd_created', true);
        DataJson.Add('fd_account_no', NewFDAccountNo);
        DataJson.Add('member_no', MemberNo);
        DataJson.Add('member_name', Members.Name);
        DataJson.Add('deposit_amount', DepositAmount);
        DataJson.Add('term_months', TermMonths);
        DataJson.Add('fd_type', FDTypeCode);
        DataJson.Add('interest_rate', InterestRate);
        DataJson.Add('start_date', Format(Today));
        DataJson.Add('maturity_date', Format(MaturityDate));
        DataJson.Add('monthly_interest', MonthlyInterest);
        DataJson.Add('total_expected_interest', TotalExpectedInterest);
        DataJson.Add('maturity_value', DepositAmount + TotalExpectedInterest);
        DataJson.Add('maturity_instructions', MaturityInstructions);
        DataJson.Add('status', 'Pending Approval');
        DataJson.Add('source_account', SourceAccount);
        DataJson.Add('application_date', Format(Today));

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;

    local procedure CreateFixedDepositRecord(MemberNo: Code[20]; MemberName: Text[200]; FDTypeCode: Code[20];
                                           DepositAmount: Decimal; TermMonths: Integer; InterestRate: Decimal;
                                           MaturityDate: Date; MaturityInstructions: Text; MonthlyInterest: Decimal;
                                           TotalExpectedInterest: Decimal; SourceAccount: Code[20];
                                           var NewFDAccountNo: Code[20]; var ErrorMessage: Text): Boolean
    var
        FixedDepositAccounts: Record "Fixed Deposit Accounts";
        SaccoSetup: Record "Sacco Setup";
        NoSeries: Codeunit "No. Series";
        Members: Record Members;
        UserSetup: Record "User Setup";
        MaturityInstructionOption: Option;
    begin
        // Initialize new Fixed Deposit record
        FixedDepositAccounts.Init();

        FixedDepositAccounts."No." := '';
        FixedDepositAccounts.Portal := true;
        FixedDepositAccounts."Member No." := MemberNo;
        FixedDepositAccounts.Name := MemberName;
        FixedDepositAccounts.Validate("Member No.");
        FixedDepositAccounts."FD Type" := FDTypeCode;
        FixedDepositAccounts.Validate("FD Type");
        FixedDepositAccounts."FD Amount" := DepositAmount;
        FixedDepositAccounts.Validate("FD Amount");
        FixedDepositAccounts."FD Start Date" := Today;
        FixedDepositAccounts.Validate("FD Start Date");
        FixedDepositAccounts."Application Date" := Today;
        FixedDepositAccounts."Captured By" := UserId;
        FixedDepositAccounts."Approval Status" := FixedDepositAccounts."Approval Status"::Approved;
        FixedDepositAccounts."FD Status" := FixedDepositAccounts."FD Status"::Active;
        FixedDepositAccounts.Posted := false;
        FixedDepositAccounts."Savings Account" := SourceAccount;

        // Set maturity instructions
        case LowerCase(MaturityInstructions) of
            'transfer all to savings':
                FixedDepositAccounts."FD Maturity Instructions" := FixedDepositAccounts."FD Maturity Instructions"::"Transfer all to Savings";
            'transfer interest & renew principal':
                FixedDepositAccounts."FD Maturity Instructions" := FixedDepositAccounts."FD Maturity Instructions"::"Transfer Interest & Renew Principal";
            'renew both principal & interest':
                FixedDepositAccounts."FD Maturity Instructions" := FixedDepositAccounts."FD Maturity Instructions"::"Renew Both Principal & Interest";
            else
                FixedDepositAccounts."FD Maturity Instructions" := FixedDepositAccounts."FD Maturity Instructions"::"Transfer all to Savings";
        end;

        // Set payment frequency (default to monthly)
        FixedDepositAccounts."Payment Frequency" := FixedDepositAccounts."Payment Frequency"::Monthly;

        // Set dimensions from member
        if Members.Get(MemberNo) then begin
            FixedDepositAccounts."Global Dimension 1 Code" := Members."Global Dimension 1 Code";
            FixedDepositAccounts."Global Dimension 2 Code" := Members."Global Dimension 2 Code";
        end;

        // Insert the record
        FixedDepositAccounts.Insert(true);
        FixedDepositAccounts.PlaceFD();


        exit(true);
    end;


    local procedure CreateStandingOrder(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        STOHeader: Record "Standing Order Header";
        STOLines: Record "Standing Order Lines";
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        DataJson: JsonObject;
        Username: Text;
        IdentifierType: Text;
        Identifier: Text;
        MemberNo: Code[20];
        RequestId: Text;
        STOType: Text;
        SourceAccount: Text;
        DestinationAccount: Text;
        StartDate: Date;
        Frequency: Text;
        Amount: Decimal;
        Status: Text;
        NewSTONo: Code[20];
        FrequencyDateFormula: DateFormula;
        DestinationAccountType: Option "G/L Account",Customer,Vendor,External,"Fixed Asset","IC Partner",Employee,Internal,Credit;
        SourceAccountCode: Code[20];
        DestinationAccountCode: Code[20];
        STOCreated: Boolean;
        ErrorMessage: Text;
        SourceAccountBalance: Decimal;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        RequestId := SelectJsonToken(RequestJson, '$.request_id').AsValue.AsText;
        STOType := SelectJsonToken(RequestJson, '$.sto_type').AsValue.AsText;
        SourceAccount := SelectJsonToken(RequestJson, '$.source_account').AsValue.AsText;
        DestinationAccount := SelectJsonToken(RequestJson, '$.destination_account').AsValue.AsText;

        // Parse start date
        if not Evaluate(StartDate, SelectJsonToken(RequestJson, '$.start_date').AsValue.AsText) then
            StartDate := Today;

        Frequency := SelectJsonToken(RequestJson, '$.frequency').AsValue.AsText;

        // Parse amount
        if not Evaluate(Amount, SelectJsonToken(RequestJson, '$.amount').AsValue.AsText) then
            Amount := 0;

        Status := SelectJsonToken(RequestJson, '$.status').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Validate that the identifier matches the session member
        if Identifier <> MemberNo then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Identifier', 'Identifier does not match session member');
            exit(ResponseJson);
        end;

        // Validate amount
        if Amount <= 0 then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Amount', 'Standing order amount must be greater than zero');
            exit(ResponseJson);
        end;

        // Validate start date
        if StartDate < Today then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Start Date', 'Start date cannot be in the past');
            exit(ResponseJson);
        end;

        // Get source account details
        SourceAccountCode := Legacy.GetOrdinaryAccount(MemberNo); // Default to ordinary account
        if SourceAccount = 'FOSA Account' then begin
            SourceAccountCode := Legacy.GetOrdinaryAccount(MemberNo);
        end else begin
            // Try to find specific savings account by number
            SavingsAccounts.Reset();
            SavingsAccounts.SetRange("Member No.", MemberNo);
            SavingsAccounts.SetRange("No.", SourceAccount);
            if SavingsAccounts.FindFirst() then
                SourceAccountCode := SavingsAccounts."No."
            else begin
                SetResponseStatus(ResponseJson, 'error', 'Source Account Not Found', 'Specified source account not found');
                exit(ResponseJson);
            end;
        end;

        // Check source account balance
        /*
        SourceAccountBalance := SkyMbanking.GetAccountBalance(SourceAccountCode);
        if SourceAccountBalance < Amount then begin
            SetResponseStatus(ResponseJson, 'error', 'Insufficient Balance',
                             StrSubstNo('Insufficient balance in source account. Available: KES %1, Required: KES %2',
                                       SourceAccountBalance, Amount));
            exit(ResponseJson);
        end;
        */

        // Determine destination account type and validate
        DestinationAccountCode := DestinationAccount;

        // Check if destination is a savings account
        SavingsAccounts.Reset();
        SavingsAccounts.SetRange("Member No.", MemberNo);
        SavingsAccounts.SetRange("No.", DestinationAccount);
        if SavingsAccounts.FindFirst() then begin
            DestinationAccountType := DestinationAccountType::Internal;
        end else begin
            // Check if destination is a loan account
            Loans.Reset();
            Loans.SetRange("Member No.", MemberNo);
            Loans.SetRange("Loan No.", DestinationAccount);
            if Loans.FindFirst() then begin
                DestinationAccountType := DestinationAccountType::Credit;
            end else begin
                SetResponseStatus(ResponseJson, 'error', 'Destination Account Not Found', 'Specified destination account not found');
                exit(ResponseJson);
            end;
        end;

        // Create standing order record
        STOCreated := CreateStandingOrderRecord(
            MemberNo, SourceAccountCode, DestinationAccountCode, DestinationAccountType,
            Amount, StartDate, Frequency, STOType, RequestId, NewSTONo, ErrorMessage);

        if not STOCreated then begin
            SetResponseStatus(ResponseJson, 'error', 'Standing Order Creation Failed', ErrorMessage);
            exit(ResponseJson);
        end;

        // Log the standing order creation
        LogSecurityEvent('StandingOrderCreated', Username,
                        StrSubstNo('Standing order %1 created for member %2. Amount: KES %3, Frequency: %4',
                                 NewSTONo, MemberNo, Amount, Frequency), false);

        // Build success response
        SetResponseStatus(ResponseJson, 'success', 'Standing Order Created', 'Your standing order has been created successfully');

        // Create response data
        DataJson.Add('sto_created', true);
        DataJson.Add('sto_number', NewSTONo);
        DataJson.Add('member_no', MemberNo);
        DataJson.Add('member_name', Members.Name);
        DataJson.Add('request_id', RequestId);
        DataJson.Add('sto_type', STOType);
        DataJson.Add('source_account', SourceAccountCode);
        DataJson.Add('destination_account', DestinationAccountCode);
        DataJson.Add('amount', Amount);
        DataJson.Add('frequency', Frequency);
        DataJson.Add('start_date', Format(StartDate));
        DataJson.Add('status', 'Active');
        DataJson.Add('created_date', Format(Today));
        DataJson.Add('next_execution_date', Format(StartDate));

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;


    local procedure CreateStandingOrderRecord(MemberNo: Code[20]; SourceAccountCode: Code[20];
                                             DestinationAccountCode: Code[20]; DestAccountType: Option "G/L Account",Customer,Vendor,External,"Fixed Asset","IC Partner",Employee,Internal,Credit;
                                             Amount: Decimal; StartDate: Date; Frequency: Text; STOType: Text;
                                             RequestId: Text; var NewSTONo: Code[20]; var ErrorMessage: Text): Boolean
    var
        STOHeader: Record "Standing Order Header";
        STOLines: Record "Standing Order Lines";
        FrequencyDateFormula: DateFormula;
        Members: Record Members;
        Loans: Record Loans;
    begin

        // Initialize Standing Order Header
        STOHeader.Init();
        STOHeader.Code := '';
        STOHeader."Source Account Type" := STOHeader."Source Account Type"::Savings;
        STOHeader.Validate("Source Account No.", SourceAccountCode);
        STOHeader.Description := 'Portal Standing Order - ' + RequestId;
        STOHeader.Amount := Amount;
        STOHeader."Allow Partial Deduction" := true;
        STOHeader."Income Type" := STOHeader."Income Type"::Business;
        STOHeader."Created By" := UserId;
        STOHeader.Status := STOHeader.Status::Approved;
        STOHeader."Effective/Start Date" := StartDate;

        // Set frequency based on user input
        case UpperCase(Frequency) of
            'WEEKLY':
                Evaluate(FrequencyDateFormula, '1W');
            'FORTNIGHTLY':
                Evaluate(FrequencyDateFormula, '2W');
            'MONTHLY':
                Evaluate(FrequencyDateFormula, '1M');
            'QUARTERLY':
                Evaluate(FrequencyDateFormula, '3M');
            'ANNUALLY':
                Evaluate(FrequencyDateFormula, '12M');
            else
                Evaluate(FrequencyDateFormula, '1M'); // Default to monthly
        end;

        STOHeader."Frequency (Months)" := FrequencyDateFormula;

        // Set duration based on STO type
        Evaluate(STOHeader."Duration (Months)", '999M');
        STOHeader.Validate("Duration (Months)");
        STOHeader."Auto Process" := true;

        // Set member information
        if Members.Get(MemberNo) then begin
            STOHeader."Global Dimension 1 Code" := Members."Global Dimension 1 Code";
            STOHeader."Global Dimension 2 Code" := Members."Global Dimension 2 Code";
        end;

        STOHeader.Insert(true);
        NewSTONo := STOHeader.Code;

        // Create Standing Order Line
        STOLines.Init();
        STOLines."Document No." := STOHeader.Code;
        STOLines."Member No." := MemberNo;
        STOLines."Destination Account Type" := DestAccountType;

        if DestAccountType = DestAccountType::Credit then begin
            if Loans.Get(DestinationAccountCode) then begin
                STOLines."Destination Account No." := Loans."Loan Account";
                STOLines."Loan No." := DestinationAccountCode;
            end;
        end
        else
            STOLines."Destination Account No." := DestinationAccountCode;

        STOLines.Validate("Destination Account No.");
        STOLines.Amount := Amount;


        STOLines.Insert();

        exit(true);

    end;


    local procedure GetSavingsStandingOrders(MemberNo: Code[20]; var SavingsStandingOrdersArray: JsonArray)
    var
        STOHeader: Record "Standing Order Header";
        STOLines: Record "Standing Order Lines";
        SavingsAccounts: Record "Savings Accounts";
        StandingOrderJson: JsonObject;
        DestinationName: Text;
        StatusText: Text;
        NextExecutionDate: Date;
        LastExecutionDate: Date;
        TotalExecutions: Integer;
        FrequencyText: Text;
    begin
        // Get savings standing orders (destination is savings accounts)
        STOHeader.Reset();
        STOHeader.SetFilter(Status, '<>%1&<>%2&<>%3', STOHeader.Status::Open, STOHeader.Status::Pending, STOHeader.Status::Rejected);

        // Filter for this member's source accounts
        STOHeader.SetFilter("Source Account No.", GetMemberAccountFilter(MemberNo));

        if STOHeader.FindSet() then begin
            repeat
                // Check if this STO has lines that go to savings accounts
                STOLines.Reset();
                STOLines.SetRange("Document No.", STOHeader.Code);
                STOLines.SetRange("Destination Account Type", STOLines."Destination Account Type"::Internal);

                if STOLines.FindSet() then begin
                    repeat
                        // Verify destination is a savings account for this member
                        SavingsAccounts.Reset();
                        SavingsAccounts.SetRange("No.", STOLines."Destination Account No.");
                        SavingsAccounts.SetRange("Member No.", MemberNo);
                        if SavingsAccounts.FindFirst() then begin
                            DestinationName := SavingsAccounts."Product Name";

                            // Determine status
                            if STOHeader.Status = STOHeader.Status::Approved then
                                StatusText := 'ACTIVE'
                            else
                                StatusText := 'PAUSED';

                            // Calculate next execution date
                            NextExecutionDate := STOHeader."Next Run Date";

                            // Calculate last execution date
                            //LastExecutionDate := NextExecutionDate;
                            //LastExecutionDate := CalcDate('-' + Format(STOHeader."Frequency (Months)"), LastExecutionDate);

                            // Estimate total executions (simplified calculation)
                            TotalExecutions := Round((Today - STOHeader."Effective/Start Date") / 30, 1, '<');

                            // Convert frequency to text
                            FrequencyText := ConvertFrequencyToText(STOHeader."Frequency (Months)");

                            Clear(StandingOrderJson);
                            StandingOrderJson.Add('id', Format(STOLines."Document No."));
                            StandingOrderJson.Add('destination_name', DestinationName);
                            StandingOrderJson.Add('destination_account', STOLines."Destination Account No.");
                            StandingOrderJson.Add('source_account', STOHeader."Source Account No.");
                            StandingOrderJson.Add('standing_order_type', 'SAVINGS_TRANSFER');
                            StandingOrderJson.Add('amount', STOLines.Amount);
                            StandingOrderJson.Add('frequency', FrequencyText);
                            StandingOrderJson.Add('status', StatusText);
                            StandingOrderJson.Add('start_date', Format(STOHeader."Effective/Start Date"));
                            StandingOrderJson.Add('next_execution_date', Format(NextExecutionDate));
                            StandingOrderJson.Add('created_date', Format(STOHeader."Effective/Start Date"));
                            StandingOrderJson.Add('last_execution_date', Format(LastExecutionDate));
                            StandingOrderJson.Add('total_executions', TotalExecutions);
                            StandingOrderJson.Add('description', STOHeader.Description);

                            SavingsStandingOrdersArray.Add(StandingOrderJson);
                        end;
                    until STOLines.Next() = 0;
                end;
            until STOHeader.Next() = 0;
        end;


    end;

    local procedure GetLoanStandingOrders(MemberNo: Code[20]; var LoanStandingOrdersArray: JsonArray)
    var
        STOHeader: Record "Standing Order Header";
        STOLines: Record "Standing Order Lines";
        Loans: Record Loans;
        StandingOrderJson: JsonObject;
        LoanDetailsJson: JsonObject;
        LoanAccountName: Text;
        StatusText: Text;
        NextExecutionDate: Date;
        LastExecutionDate: Date;
        TotalExecutions: Integer;
        FrequencyText: Text;
        PaymentsMade: Integer;
        PaymentsRemaining: Integer;
    begin
        // Get loan standing orders (destination is loan accounts)
        STOHeader.Reset();

        STOHeader.SetFilter(Status, '<>%1&<>%2&<>%3', STOHeader.Status::Open, STOHeader.Status::Pending, STOHeader.Status::Rejected);

        // Filter for this member's source accounts
        STOHeader.SetFilter("Source Account No.", GetMemberAccountFilter(MemberNo));

        if STOHeader.FindSet() then begin
            repeat
                // Check if this STO has lines that go to loan accounts
                STOLines.Reset();
                STOLines.SetRange("Document No.", STOHeader.Code);
                STOLines.SetRange("Destination Account Type", STOLines."Destination Account Type"::Credit);

                if STOLines.FindSet() then begin
                    repeat
                        // Verify destination is a loan account for this member
                        Loans.Reset();
                        Loans.SetRange("Loan No.", STOLines."Loan No.");
                        Loans.SetRange("Member No.", MemberNo);
                        if Loans.FindFirst() then begin
                            Loans.CalcFields("Total Outstanding Balance", "Outstanding Principal");
                            LoanAccountName := Loans."Loan Product Type Name";

                            // Determine status
                            if STOHeader.Status = STOHeader.Status::Approved then
                                StatusText := 'ACTIVE'
                            else
                                StatusText := 'PAUSED';

                            // Calculate next execution date
                            NextExecutionDate := STOHeader."Next Run Date";
                            // Calculate last execution date
                            //LastExecutionDate := NextExecutionDate;
                            //LastExecutionDate := CalcDate('-' + Format(STOHeader."Frequency (Months)"), LastExecutionDate);

                            // Estimate total executions and payments
                            TotalExecutions := Round((Today - STOHeader."Effective/Start Date") / 30, 1, '<');
                            PaymentsMade := TotalExecutions;
                            PaymentsRemaining := Loans.Installments - PaymentsMade;
                            if PaymentsRemaining < 0 then PaymentsRemaining := 0;

                            // Convert frequency to text
                            FrequencyText := ConvertFrequencyToText(STOHeader."Frequency (Months)");

                            Clear(StandingOrderJson);
                            StandingOrderJson.Add('id', Format(STOLines."Document No."));
                            StandingOrderJson.Add('loan_account_name', LoanAccountName);
                            StandingOrderJson.Add('loan_account_number', Loans."Loan No.");
                            StandingOrderJson.Add('source_account', STOHeader."Source Account No.");
                            StandingOrderJson.Add('standing_order_type', 'LOAN_REPAYMENT');
                            StandingOrderJson.Add('amount', STOLines.Amount);
                            StandingOrderJson.Add('frequency', FrequencyText);
                            StandingOrderJson.Add('status', StatusText);
                            StandingOrderJson.Add('start_date', Format(STOHeader."Effective/Start Date"));
                            StandingOrderJson.Add('next_execution_date', Format(NextExecutionDate));
                            StandingOrderJson.Add('created_date', Format(STOHeader."Effective/Start Date"));
                            StandingOrderJson.Add('last_execution_date', Format(LastExecutionDate));
                            StandingOrderJson.Add('total_executions', TotalExecutions);
                            StandingOrderJson.Add('description', STOHeader.Description);

                            // Add loan details
                            Clear(LoanDetailsJson);
                            LoanDetailsJson.Add('principal_amount', Loans."Approved Amount");
                            LoanDetailsJson.Add('outstanding_balance', Loans."Total Outstanding Balance");
                            LoanDetailsJson.Add('interest_rate', Format(Loans."Annual Interest %") + '% p.a.');
                            LoanDetailsJson.Add('term_months', Loans.Installments);
                            LoanDetailsJson.Add('payments_made', PaymentsMade);
                            LoanDetailsJson.Add('payments_remaining', PaymentsRemaining);

                            StandingOrderJson.Add('loan_details', LoanDetailsJson);

                            LoanStandingOrdersArray.Add(StandingOrderJson);
                        end;
                    until STOLines.Next() = 0;
                end;
            until STOHeader.Next() = 0;
        end;



    end;

    // Helper procedures
    local procedure GetMemberAccountFilter(MemberNo: Code[20]): Text
    var
        SavingsAccounts: Record "Savings Accounts";
        FilterText: Text;
    begin
        FilterText := '';

        SavingsAccounts.Reset();
        SavingsAccounts.SetRange("Member No.", MemberNo);
        if SavingsAccounts.FindSet() then begin
            repeat
                if FilterText <> '' then
                    FilterText += '|';
                FilterText += SavingsAccounts."No.";
            until SavingsAccounts.Next() = 0;
        end;

        exit(FilterText);
    end;

    local procedure ConvertFrequencyToText(FrequencyFormula: DateFormula): Text
    begin
        case Format(FrequencyFormula) of
            '1W':
                exit('WEEKLY');
            '2W':
                exit('BI_WEEKLY');
            '1M':
                exit('MONTHLY');
            '3M':
                exit('QUARTERLY');
            '6M':
                exit('SEMI_ANNUALLY');
            '12M':
                exit('ANNUALLY');
            else
                exit('MONTHLY');
        end;
    end;


    local procedure PauseStandingOrder(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        STOHeader: Record "Standing Order Header";
        DataJson: JsonObject;
        Username: Text;
        IdentifierType: Text;
        Identifier: Text;
        MemberNo: Code[20];
        RequestId: Text;
        StandingOrderId: Code[20];
        Status: Text;
        STOFound: Boolean;
        OriginalStatus: Option;
        NewStatus: Option;
        StatusText: Text;
        ActionText: Text;
        NextExecutionDate: Date;
        PausedDate: Date;
        CanResume: Boolean;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        RequestId := SelectJsonToken(RequestJson, '$.request_id').AsValue.AsText;
        StandingOrderId := CopyStr(SelectJsonToken(RequestJson, '$.standing_order_id').AsValue.AsText, 1, 20);
        Status := SelectJsonToken(RequestJson, '$.status').AsValue.AsText;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Validate that the identifier matches the session member
        if Identifier <> MemberNo then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Identifier', 'Identifier does not match session member');
            exit(ResponseJson);
        end;

        // Find the standing order
        STOHeader.Reset();
        STOHeader.SetRange(Code, StandingOrderId);
        STOFound := STOHeader.FindFirst();

        if not STOFound then begin
            SetResponseStatus(ResponseJson, 'error', 'Standing Order Not Found', 'The specified standing order was not found');
            exit(ResponseJson);
        end;

        // Verify that this standing order belongs to the member (check source account)
        if not ValidateSTOOwnership(STOHeader, MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Access Denied', 'You do not have permission to modify this standing order');
            exit(ResponseJson);
        end;

        // Store original status for logging
        OriginalStatus := STOHeader.Status;

        // Process the status change based on requested action
        case UpperCase(Status) of
            'PAUSED':
                begin
                    if STOHeader.Status = STOHeader.Status::Approved then begin
                        STOHeader.Status := STOHeader.Status::Suspended;
                        STOHeader."Suspended Date" := Today;
                        STOHeader."Suspended By" := UserId;
                        STOHeader."Suspension Reason" := 'Paused via Portal by Member';
                        ActionText := 'paused';
                        StatusText := 'PAUSED';
                        CanResume := true;
                        PausedDate := Today;
                    end else begin
                        SetResponseStatus(ResponseJson, 'error', 'Invalid Status Change', 'Standing order is not in a state that can be paused');
                        exit(ResponseJson);
                    end;
                end;
            'ACTIVE', 'RESUMED':
                begin
                    if STOHeader.Status = STOHeader.Status::Suspended then begin
                        STOHeader.Status := STOHeader.Status::Approved;
                        STOHeader."Suspended Date" := 0D;
                        STOHeader."Suspended By" := '';
                        STOHeader."Suspension Reason" := '';
                        ActionText := 'resumed';
                        StatusText := 'ACTIVE';
                        CanResume := false;
                        PausedDate := 0D;

                        // Calculate next execution date
                        NextExecutionDate := CalcDate(STOHeader."Frequency (Months)", Today);
                        STOHeader."Next Run Date" := NextExecutionDate;
                    end else begin
                        SetResponseStatus(ResponseJson, 'error', 'Invalid Status Change', 'Standing order is not in a paused state');
                        exit(ResponseJson);
                    end;
                end;
            'CANCELLED', 'STOPPED':
                begin
                    if (STOHeader.Status = STOHeader.Status::Approved) or
                       (STOHeader.Status = STOHeader.Status::Suspended) then begin
                        STOHeader.Status := STOHeader.Status::Stopped;
                        STOHeader."Suspended Date" := Today;
                        STOHeader."Suspended By" := UserId;
                        STOHeader."Suspension Reason" := 'Stopped via Portal by Member';
                        ActionText := 'stopped';
                        StatusText := 'STOPPED';
                        CanResume := false;
                        PausedDate := Today;
                    end else begin
                        SetResponseStatus(ResponseJson, 'error', 'Invalid Status Change', 'Standing order cannot be cancelled in its current state');
                        exit(ResponseJson);
                    end;
                end;
            else begin
                SetResponseStatus(ResponseJson, 'error', 'Invalid Status', 'Invalid status specified. Use PAUSED, ACTIVE, or CANCELLED');
                exit(ResponseJson);
            end;
        end;

        // Update the standing order record
        STOHeader.Modify(true);

        // Log the standing order status change
        LogSecurityEvent('StandingOrderStatusChanged', Username,
                        StrSubstNo('Standing order %1 %2 for member %3. Changed from %4 to %5',
                                 StandingOrderId, ActionText, MemberNo, Format(OriginalStatus), StatusText), false);

        // Build success response
        SetResponseStatus(ResponseJson, 'success', 'Standing Order Updated',
                         StrSubstNo('Standing order has been %1 successfully', ActionText));

        // Create response data
        DataJson.Add('standing_order_updated', true);
        DataJson.Add('standing_order_id', StandingOrderId);
        DataJson.Add('member_no', MemberNo);
        DataJson.Add('member_name', Members.Name);
        DataJson.Add('request_id', RequestId);
        DataJson.Add('action_performed', ActionText);
        DataJson.Add('previous_status', Format(OriginalStatus));
        DataJson.Add('current_status', StatusText);
        DataJson.Add('status_changed_date', Format(Today));
        DataJson.Add('can_resume', CanResume);

        // Add execution dates
        if PausedDate <> 0D then
            DataJson.Add('paused_date', Format(PausedDate))
        else
            DataJson.Add('paused_date', '');

        if NextExecutionDate <> 0D then
            DataJson.Add('next_execution_date', Format(NextExecutionDate))
        else
            DataJson.Add('next_execution_date', '');

        // Add standing order details for confirmation
        DataJson.Add('description', STOHeader.Description);
        DataJson.Add('amount', STOHeader.Amount);
        DataJson.Add('frequency', ConvertFrequencyToText(STOHeader."Frequency (Months)"));
        DataJson.Add('source_account', STOHeader."Source Account No.");

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;

    // Helper function to validate standing order ownership
    local procedure ValidateSTOOwnership(STOHeader: Record "Standing Order Header"; MemberNo: Code[20]): Boolean
    var
        SavingsAccounts: Record "Savings Accounts";
    begin
        // Check if the source account belongs to the member
        SavingsAccounts.Reset();
        SavingsAccounts.SetRange("No.", STOHeader."Source Account No.");
        SavingsAccounts.SetRange("Member No.", MemberNo);
        exit(SavingsAccounts.FindFirst());
    end;


    local procedure UpdateStandingOrderAmount(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        STOHeader: Record "Standing Order Header";
        STOLines: Record "Standing Order Lines";
        DataJson: JsonObject;
        Username: Text;
        IdentifierType: Text;
        Identifier: Text;
        MemberNo: Code[20];
        RequestId: Text;
        StandingOrderId: Code[20];
        NewAmount: Decimal;
        STOFound: Boolean;
        OldAmount: Decimal;
    begin
        // Extract request parameters
        Username := SelectJsonToken(RequestJson, '$.username').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        RequestId := SelectJsonToken(RequestJson, '$.request_id').AsValue.AsText;
        StandingOrderId := CopyStr(SelectJsonToken(RequestJson, '$.standing_order_id').AsValue.AsText, 1, 20);
        if not Evaluate(NewAmount, SelectJsonToken(RequestJson, '$.new_amount').AsValue.AsText) then
            NewAmount := 0;

        // Validate session and get member details
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Session', 'Session not found or expired');
            exit(ResponseJson);
        end;

        MemberNo := PortalAuth."Member No.";
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Unable to find member details');
            exit(ResponseJson);
        end;

        // Validate that the identifier matches the session member
        if Identifier <> MemberNo then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Identifier', 'Identifier does not match session member');
            exit(ResponseJson);
        end;

        // Find the standing order
        STOHeader.Reset();
        STOHeader.SetRange(Code, StandingOrderId);
        STOFound := STOHeader.FindFirst();

        if not STOFound then begin
            SetResponseStatus(ResponseJson, 'error', 'Standing Order Not Found', 'The specified standing order was not found');
            exit(ResponseJson);
        end;

        // Verify that this standing order belongs to the member (check source account)
        if not ValidateSTOOwnership(STOHeader, MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Access Denied', 'You do not have permission to modify this standing order');
            exit(ResponseJson);
        end;

        // Validate new amount
        if NewAmount <= 0 then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Amount', 'New amount must be greater than zero');
            exit(ResponseJson);
        end;

        // Store old amount for audit
        OldAmount := STOHeader.Amount;

        // Update the standing order amount in header
        STOHeader.Amount := NewAmount;
        STOHeader."Last Modified Date" := Today;
        STOHeader."Last Modified By" := UserId;
        STOHeader.Modify(true);

        // Update all related lines to new amount
        STOLines.Reset();
        STOLines.SetRange("Document No.", STOHeader.Code);
        if STOLines.FindSet() then begin
            repeat
                STOLines.Amount := NewAmount;
                STOLines.Modify(true);
            until STOLines.Next() = 0;
        end;

        // Log the standing order amount change
        LogSecurityEvent('StandingOrderAmountChanged', Username,
            StrSubstNo('Standing order %1 amount updated for member %2. Changed from %3 to %4',
                StandingOrderId, MemberNo, OldAmount, NewAmount), false);

        // Build success response
        SetResponseStatus(ResponseJson, 'success', 'Standing Order Updated',
            'Standing order amount has been updated successfully');

        // Create response data
        DataJson.Add('standing_order_updated', true);
        DataJson.Add('standing_order_id', StandingOrderId);
        DataJson.Add('member_no', MemberNo);
        DataJson.Add('member_name', Members.Name);
        DataJson.Add('request_id', RequestId);
        DataJson.Add('old_amount', OldAmount);
        DataJson.Add('new_amount', NewAmount);
        DataJson.Add('status_changed_date', Format(Today));
        DataJson.Add('description', STOHeader.Description);
        DataJson.Add('frequency', ConvertFrequencyToText(STOHeader."Frequency (Months)"));
        DataJson.Add('source_account', STOHeader."Source Account No.");

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime));

        exit(ResponseJson);
    end;

    local procedure GetDividendSlip(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        Members: Record Members;
        PortalAuth: Record "Portal Auth";
        DividendSlip: Report "Dividend Slip Portal 2";
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        DataJson: JsonObject;
        OutStr: OutStream;
        InStr: InStream;
        MemberNo: Code[20];
        Username: Text;
        EncodedPdf: Text;
    begin
        // Extract username from request
        Username := SelectJsonToken(RequestJson, '$.username').AsValue().AsText();

        if Username = '' then
            Username := SelectJsonToken(RequestJson, '$.identifier').AsValue().AsText();

        if Username = '' then begin
            SetResponseStatus(ResponseJson, 'error', 'Invalid Request', 'User not provided');
            exit(ResponseJson);
        end;

        // Validate portal user
        PortalAuth.Reset();
        PortalAuth.SetRange(UserName, Username);
        if not PortalAuth.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'error', 'Unauthorized', 'User not found');
            exit(ResponseJson);
        end;
        MemberNo := PortalAuth."Member No.";

        // Validate member
        if not Members.Get(MemberNo) then begin
            SetResponseStatus(ResponseJson, 'error', 'Member Not Found', 'Member record missing');
            exit(ResponseJson);
        end;

        // ----------------------------
        // Generate PDF properly
        // ----------------------------
        DividendSlip.SetMemberNo(MemberNo);

        TempBlob.CreateOutStream(OutStr);
        // SAVE the report to OutStream
        DividendSlip.SaveAs('', ReportFormat::Pdf, OutStr);

        // IMPORTANT: Create InStream AFTER writing to OutStream
        TempBlob.CreateInStream(InStr);
        EncodedPdf := Base64Convert.ToBase64(InStr);

        if EncodedPdf = '' then begin
            SetResponseStatus(ResponseJson, 'error', 'PDF Generation Failed', 'No PDF content generated');
            exit(ResponseJson);
        end;

        // ----------------------------
        // Build Response
        // ----------------------------
        SetResponseStatus(
            ResponseJson,
            'success',
            'Dividend Slip Retrieved',
            'Dividend slip generated successfully'
        );

        Clear(DataJson);
        DataJson.Add('member_id', MemberNo);
        DataJson.Add('member_name', Members.Name);
        DataJson.Add('pdf_base64', EncodedPdf);
        DataJson.Add('report_type', 'dividend_slip');
        DataJson.Add('generated_date', Format(Today, 0, 9));

        ResponseJson.Add('data', DataJson);
        ResponseJson.Add('timestamp', Format(CurrentDateTime, 0, 9));

        exit(ResponseJson);
    end;


}
