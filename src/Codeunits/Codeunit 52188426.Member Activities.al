
Codeunit 50018 "Member Activities"
{

    trigger OnRun()
    begin
        //Base64Header;
    end;

    var
        GenSetup: Record "Sacco Setup";
        Source: Enum "SMS Source Enum";
        SaccoActivities: Codeunit "Sacco Activities";
        Emp: Record Employee;
        MinBal: Decimal;
        SkyMbanking: Codeunit "Sky Mbanking";
        TChannel: Enum "Transaction Channel";
        Member: Record Members;
        Member2: Record Members;
        Loans: Record Loans;


    procedure CreateMember(MemberApplication: Record "Member Registration")
    var
        Member: Record Members;
        Employer: Record Customer;
        ImageData: Record "Member Images";
        NextOfKin: Record "Next of Kin.";
        NextOfKinApp: Record "Next of Kin.";
        Nominee: Record Nominee;
        NomineeApp: Record Nominee;
        DefaultSavingsProducts: Record "Default Savings Products.";
        ProductSetup: Record "Product Setup";
        Msg: Text;
        SenderName: Text;
        SenderAddress: Text;
        Signatory: Record "Account Signatories.";
        SignatoryApp: Record "Account Signatories.";
        MemberAccounts: Record "Savings Accounts";
        MNo: Code[20];

        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        NoSeriesLine: Record "No. Series Line";
        EmailLogs: Record "Email Logs Notifications";
        ApplicationDocument: Record "Application Documents";
        i: Integer;
        Sky: Codeunit "Sky Mobile Banking Integration";
        Witness: Record Witness;
        WitnessApp: Record Witness;
    begin

        MNo := '';
        Member.Init;
        SalesSetup.Get;
        SalesSetup.TestField("Member Nos.");

        if Member."No." = '' then begin
            Member."No. Series" := SalesSetup."Member Nos.";
            Member."No." := NoSeries.GetNextNo(Member."No. Series");
        end;

        Member.TestField("No.");
        Member.Type := MemberApplication.Type;
        Member."Cost Center" := MemberApplication."Cost Center";
        Member."Account Category" := MemberApplication."Account Category";
        Member."First Name" := MemberApplication."First Name";
        Member.Surname := MemberApplication.Surname;
        Member."Middle Name" := MemberApplication."Middle Name";
        Member.Name := MemberApplication.Name;
        Member."Application Date" := MemberApplication."Application Date";
        Member."Registration Date" := MemberApplication."Registration Date";
        Member."How Did You Know About Us" := MemberApplication."How Did You Know About Us";
        Member."Member Class" := MemberApplication."Member Class";
        Member."ID Type" := MemberApplication."ID Type";
        If MemberApplication."ID Type" = MemberApplication."ID Type"::Passport then begin
            Member.Passport := MemberApplication.Passport;
            Member."Passport Expiry Date" := MemberApplication."Expiry Date";
        end
        else
            Member."ID No." := MemberApplication."ID No.";
        Member."Date of Birth" := MemberApplication."Date of Birth";
        Member."KRA PIN" := MemberApplication."KRA PIN";
        Member.Gender := MemberApplication.Gender;
        Member."Marital Status" := MemberApplication."Marital Status";
        Member."Employer Code" := MemberApplication."Employer Code";
        Member."Employer Name" := MemberApplication."Employer Name";
        Member."Terms of Employment" := MemberApplication."Terms of Employment";
        Member."Payroll/Staff No." := MemberApplication."Payroll/Staff No.";
        Member."Member Category" := MemberApplication."Member Category";
        Member."Captured By" := MemberApplication."Captured By";
        Member."Post Code" := MemberApplication."Post Code";
        Member.Address := MemberApplication.Address;
        Member."Address 2" := MemberApplication."Address 2";
        Member.City := MemberApplication.City;
        Member."Country/Region Code" := MemberApplication."Country/Region Code";
        Member."Phone No." := MemberApplication."Alternative Phone No.";
        Member."Mobile Phone No." := MemberApplication."Mobile Phone No.";
        Member."E-Mail" := MemberApplication."E-Mail";
        Member."Global Dimension 2 Code" := MemberApplication."Global Dimension 2 Code";
        Member."Recruited by Type" := MemberApplication."Recruited by Type";
        Member."Recruited By" := MemberApplication."Recruited By";
        Member."Recruited By Name" := MemberApplication."Recruited By Name";
        Member."Recruited By Phone" := MemberApplication."Recruited By Phone";
        Member."Member Status" := Member."Member Status"::Active;
        Member."Bank Code" := MemberApplication."Bank Code";
        Member."Bank Name" := MemberApplication."Bank Name";
        Member."Branch Code" := MemberApplication."Branch Code";
        Member."Swift Code" := MemberApplication."Swift Code";
        Member."Branch Name" := MemberApplication."Branch Name";
        Member."Bank Account No." := MemberApplication."Bank Account No.";
        Member."Salutation Code" := MemberApplication."Salutation Code";
        Member."Group No." := MemberApplication."Group No.";
        Member.Locality := MemberApplication.Locality;
        Member."Address Details" := MemberApplication."Address Details";
        Member."Trading As" := MemberApplication."Trading As";
        Member."Business Name" := MemberApplication."Business Name";
        Member."Position Held" := MemberApplication."Position Held";
        Member."Reference code" := MemberApplication."Reference code";
        Member."Self Employed" := MemberApplication."Self Employed";
        member."Employment Info" := MemberApplication."Employment Info";

        Member."Relationship Officer" := MemberApplication."Relationship Officer";
        Member."Relationship Officer Name" := MemberApplication."Relationship Officer Name";
        Member."Branch Manager" := MemberApplication."Branch Manager";
        Member."Branch Manager Name" := MemberApplication."Branch Manager Name";
        Member."From Another Sacco" := MemberApplication."From Another Sacco";
        Member.Residential := MemberApplication.Residential;
        Member."Employement Sector" := MemberApplication."Employement Sector";
        Member.State := MemberApplication.State;
        Member.Country := MemberApplication.Country;
        Member."Level of Employement" := MemberApplication."Level of Employement";
        Member."Checkoff Station" := MemberApplication."Checkoff Station";
        Member."Checkoff Station Name" := MemberApplication."Checkoff Station Name";
        Member."Remit Checkoff" := MemberApplication."Remit Checkoff";
        Member."Member Electoral Zone" := MemberApplication."Member Electoral Zone";

        //Group
        Member."Group Account" := MemberApplication."Group Account";
        Member."Other Type Of Business" := MemberApplication."Other Type Of Business";
        Member."Business Reg. No." := MemberApplication."Business Reg. No.";
        Member."Incorporation No." := MemberApplication."Incorporation No.";
        Member."Date of Bus. Incorporation" := MemberApplication."Date of Bus. Incorporation";
        Member."Business/Group Location" := MemberApplication."Business/Group Location";
        Member."Group Type" := MemberApplication."Group Type";
        Member."Other Group Type" := MemberApplication."Other Group Type";
        Member."Date of Bus. Reg." := MemberApplication."Date of Bus. Reg.";
        Member."Group Category" := MemberApplication."Group Category";
        Member."Type of Business" := MemberApplication."Type of Business";
        Member."Account Category" := MemberApplication."Account Category";
        Member."Meeting Day" := MemberApplication."Meeting Day";
        Member."Meeting Location" := MemberApplication."Meeting Location";
        Member."Signing Instructions" := MemberApplication."Signing Instructions";
        Member."Signing Instruction Narration" := MemberApplication."Signing Instruction narration";
        Member."Previous Sacco No." := MemberApplication."Previous Sacco No.";
        Member."Group Section" := MemberApplication."Group Section";
        Member."Account Category" := MemberApplication."Account Category";
        Member.Insert();


        if Employer.get(Member."Employer Code") then begin
            if not Employer."Employer Based Staff Nos" then begin
                Member."Payroll/Staff No." := Member."No.";
                Member.Modify();
            end;
        end;



        MemberApplication.CalcFields(Signature, Picture);
        ImageData.Init;
        ImageData."Member No." := Member."No.";
        ImageData.Picture := MemberApplication.Picture;
        ImageData.Signature := MemberApplication.Signature;
        ImageData.Insert(true);


        ApplicationDocument.RESET;
        ApplicationDocument.SETRANGE(ApplicationDocument."Reference No.", MemberApplication."No.");
        IF ApplicationDocument.FIND('-') THEN BEGIN
            REPEAT
                i += 1;
                ApplicationDocuments(i, ApplicationDocument."Document Type", ApplicationDocument."Document No.", ApplicationDocument.Description, ApplicationDocument."Single Party/Multiple",
                                     Member."No.", ApplicationDocument."Product ID", ApplicationDocument."Product Name", ApplicationDocument.Provided);
            UNTIL ApplicationDocument.NEXT = 0;
        END;

        WitnessApp.Reset();
        WitnessApp.SetRange(WitnessApp."Member No.", MemberApplication."No.");
        if WitnessApp.Find('-') then begin
            repeat
                Witness.Init;
                Witness."Member No." := Member."No.";
                Witness."Witness Name" := UpperCase(WitnessApp."Witness Name");
                Witness."Witness ID No." := WitnessApp."Witness ID No.";
                Witness.Insert;
            until WitnessApp.Next = 0;
        end;


        NextOfKinApp.Reset;
        NextOfKinApp.SetRange(NextOfKinApp."No.", MemberApplication."No.");
        if NextOfKinApp.Find('-') then begin
            repeat
                NextOfKin.Init;
                NextOfKin."No." := Member."No.";
                NextOfKin.Type := NextOfKinApp.Type;
                NextOfKin."ID No." := NextOfKinApp."ID No.";
                NextOfKin.Name := NextOfKinApp.Name;
                NextOfKin.Relationship := NextOfKinApp.Relationship;
                NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                NextOfKin."Next Of Kin" := NextOfKinApp."Next Of Kin";
                NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                NextOfKin."Mobile Phone No." := NextOfKinApp."Mobile Phone No.";
                NextOfKin.Email := NextOfKinApp.Email;
                NextOfKin."%Allocation" := NextOfKinApp."%Allocation";
                NextOfKin.Spouse := NextOfKinApp.Spouse;
                NextOfKin.Insert;
            until NextOfKinApp.Next = 0;
        end;




        NomineeApp.Reset;
        NomineeApp.SetRange(NomineeApp."No.", MemberApplication."No.");
        if NomineeApp.Find('-') then begin
            repeat
                Nominee.Init;
                Nominee."No." := Member."No.";
                Nominee."ID No." := NomineeApp."ID No.";
                Nominee."Line No." += 1;
                Nominee.Name := NomineeApp.Name;
                Nominee.Relationship := NomineeApp.Relationship;
                Nominee.Beneficiary := NomineeApp.Beneficiary;
                Nominee."Date of Birth" := NomineeApp."Date of Birth";
                Nominee."Mobile Phone No." := NomineeApp."Mobile Phone No.";
                Nominee.Email := NomineeApp.Email;
                Nominee."%Allocation" := NomineeApp."%Allocation";
                Nominee.Spouse := NomineeApp.Spouse;
                Nominee."Guardian Name" := NomineeApp."Guardian Name";
                Nominee."Guardian Phone No." := NomineeApp."Guardian Phone No.";
                Nominee.Insert;
            until NomineeApp.Next = 0;
        end;


        SignatoryApp.Reset;
        SignatoryApp.SetRange(SignatoryApp.Code, MemberApplication."No.");
        if SignatoryApp.Find('-') then begin
            repeat
                Signatory.Init;
                Signatory.Code := Member."No.";
                Signatory."Member No." := SignatoryApp."Member No.";
                Signatory."ID No." := SignatoryApp."ID No.";
                Signatory.Name := SignatoryApp.Name;
                Signatory."Date Of Birth" := SignatoryApp."Date Of Birth";
                Signatory."Staff/Payroll" := SignatoryApp."Staff/Payroll";
                //Signatory."Salesperson Code":=SignatoryApp."Salesperson Code";
                Signatory."Phone No." := SignatoryApp."Phone No.";
                Signatory.Signatory := SignatoryApp.Signatory;
                Signatory."Must Sign" := SignatoryApp."Must Sign";
                Signatory."Must be Present" := SignatoryApp."Must be Present";
                SignatoryApp.CalcFields(SignatoryApp.Signature, SignatoryApp.Picture);
                Signatory.Picture := SignatoryApp.Picture;
                Signatory.Signature := SignatoryApp.Signature;
                Signatory."Expiry Date" := SignatoryApp."Expiry Date";
                //Signatory."Mobile No.":=SignatoryApp."Mobile No.";
                Signatory.Type := Signatory.Type;
                Signatory.Insert;

                if SignatoryApp.Picture.Hasvalue then begin
                    Clear(SignatoryApp.Picture);
                    SignatoryApp.Modify;
                end;

                if SignatoryApp.Signature.Hasvalue then begin
                    Clear(SignatoryApp.Signature);
                    SignatoryApp.Modify;
                end;

            until SignatoryApp.Next = 0;
        end;


        DefaultSavingsProducts.Reset;
        DefaultSavingsProducts.SetRange(Code, MemberApplication."No.");
        if DefaultSavingsProducts.Find('-') then begin
            repeat
                if ProductSetup.Get(DefaultSavingsProducts.Product) then begin
                    ProductSetup.TestField("Product Posting Group");
                    CreateSavingsAccount(ProductSetup, Member, DefaultSavingsProducts."Monthly Contribution", false, DefaultSavingsProducts."Repay Mode");

                    //if MemberApplication."Signing Instruction narration" <> '' then begin

                    if ProductSetup."Product Category" = ProductSetup."Product Category"::"Ordinary Savings" then begin
                        MemberAccounts.Reset();
                        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
                        MemberAccounts.SetRange("Member No.", Member."No.");
                        if MemberAccounts.FindFirst() then begin
                            MemberAccounts."Signing Instructions narration" := MemberApplication."Signing Instruction narration";
                            MemberAccounts."Signing Instructions" := MemberApplication."Signing Instructions";
                            MemberAccounts.Modify();
                        end;
                    end;

                    //end;
                end;
            until DefaultSavingsProducts.Next = 0;
        end;

        MemberApplication.Status := MemberApplication.Status::Created;
        MemberApplication.Modify;
        Commit;
        // Msg := 'Dear ' + Member."First Name" + ', Welcome to ' + COMPANYNAME + '. Your Membership No. is ' + Member."No." + 'We are honored to be your chosen financial partner. We aim to walk with you' +
        // 'every step of the way as you seek to experience financial freedom.';
        // SendSms(Source::"New Member", Member."Mobile Phone No.", Msg, Member."No.", '', false, false);


        //Send Email Notification
        Membership_New(Member."No.");
        Commit;

        //Log Email Notification


        EmailLogs.Reset();
        if EmailLogs.FindLast() then
            i := EmailLogs.Line + 1;

        EmailLogs.Init();
        EmailLogs."Loan No." := Member."No.";
        EmailLogs.Line := i;
        EmailLogs.Source := EmailLogs.Source::Regstration;
        EmailLogs.Insert();

        Message('Member Created Successfuly: Member No - %1', Member."No.");

    end;

    local procedure Membership_New(TheMember: Code[20])
    var
        MemberDetails: Record Members;
        MemberEmail: Text;
        MobileNo: Text;
        Msg: Text;
        EmailMsg: Codeunit "Email Message";
        BCCRecipients: List of [Text];
        CCRecipients: List of [Text];
        ToRecipients: List of [Text];
        Email: Codeunit Email;
        FileName: Text;
        HeaderTxt: Label 'NEW MEMBER WELCOME EMAIL';
        EmailNotification: Text;
        MemberAcceptanceReport: Report MembershipAcceptanceLetter;
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
    begin
        if not SendNotifications(TheMember) then
            exit;

        if not MemberDetails.Get(TheMember) then
            exit;

        MemberEmail := MemberDetails."E-Mail";
        MobileNo := MemberDetails."Mobile Phone No.";

        if MobileNo = '' then
            MobileNo := MemberDetails."Phone No.";

        // Send SMS
        if MobileNo <> '' then begin
            Msg :=
                'Dear ' + MemberDetails."First Name" +
                ', Welcome to ' + CompanyName +
                '. Your Membership No. is ' + MemberDetails."No." +
                '. We are honored to be your chosen financial partner.';

            SendSms(
                Source::"New Member",
                MobileNo,
                Msg,
                MemberDetails."No.",
                '',
                false,
                false);

            Commit();
        end;

        // Send Email with attachment
        if MemberEmail <> '' then begin
            Clear(ToRecipients);
            Clear(CCRecipients);
            Clear(BCCRecipients);
            Clear(EmailMsg);
            Clear(TempBlob);
            Clear(MemberAcceptanceReport);

            ToRecipients.Add(MemberEmail);

            EmailNotification :=
                'Dear ' + MemberDetails."First Name" + ',<br/><br/>' +
                'Welcome to ' + CompanyName + '. Your Membership No. is <strong>' + MemberDetails."No." + '</strong>.<br/><br/>' +
                'Attached find your Sacco Membership Acceptance Letter. You can view, save or print the letter at your convenience.<br/><br/>' +
                'To open it, kindly use your ID number or Passport number as the password.<br/><br/>' +
                'In case of any challenges, do not hesitate to contact us.<br/><br/>' +
                'Best Regards,<br/>' +
                CompanyName;

            EmailMsg.Create(ToRecipients, HeaderTxt, EmailNotification, true, CCRecipients, BCCRecipients);

            FileName := MemberDetails."No." + '-Membership-Acceptance-Letter.pdf';

            // Important: filter report to this member only
            MemberDetails.SetRecFilter();

            // Save report PDF into TempBlob
            TempBlob.CreateOutStream(OutStr);

            MemberAcceptanceReport.SetTableView(MemberDetails);

            if not MemberAcceptanceReport.SaveAs('', ReportFormat::Pdf, OutStr) then
                Error('Failed to generate membership acceptance letter for member %1.', MemberDetails."No.");

            // Create InStream from same TempBlob and attach
            TempBlob.CreateInStream(InStr);
            EmailMsg.AddAttachment(FileName, 'application/pdf', InStr);

            Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;

    local procedure Membership_NewAccount(TheMember: Text; TheAccountType: Text; TheAccountNo: Text)
    var
        MemberDetails: Record Members;
        MemberEmail: Text;
        MobileNo: Text;
        Msg: Text;
        EmailMsg: Codeunit "Email Message";
        BCCRecipients: List of [Text];
        CCRecipients: List of [Text];
        ToRecipients: List of [Text];
        Email: Codeunit Email;
        HeaderTxt: Label 'NEW MEMBER ACCOUNT EMAIL';
        EmailNotification: Text;
    begin
        if not SendNotifications(TheMember) then exit;

        if MemberDetails.Get(TheMember) then begin


            MemberEmail := MemberDetails."E-Mail";
            MobileNo := MemberDetails."Mobile Phone No.";

            if EMPTY(MobileNo) then MobileNo := MemberDetails."Phone No.";

            //Send SMS.
            if ((not EMPTY(MobileNo))) then
                Msg := 'Dear ' + Member."First Name" + ', Your ' + UpperCase(TheAccountType) + ' has been created successfully. Your Account No. is ' + TheAccountNo;
            SendSms(Source::"New Member", Member."Mobile Phone No.", Msg, Member."No.", '', false, false);
            Commit;

            //Send Email.
            if ((not EMPTY(MemberEmail))) then begin
                ToRecipients.Add(MemberEmail);
                EmailNotification := '<br>Dear ' + MemberDetails.Name + '<br><br>' + 'Your Account Application for (' + UpperCase(TheAccountType) + ') has been processed.<br>' +
                'Your Account No. is ' + TheAccountNo + '.<br><br>' + 'Always quote your Membership/Account Number when making any transactions and/or enquiries. ' +
                'For any queries please contact our offices.<br>' + 'Thank you for your Continued Suppport.';

                EmailMsg.Create(ToRecipients, HeaderTxt, EmailNotification, true, CCRecipients, BCCRecipients);

                Email.Send(EmailMsg, Enum::"Email Scenario"::Default);

            end;

        end;
    end;

    local procedure SendJuniorAcceptanceLetter(AccountNo: Code[20])
    var
        Savings: Record "Savings Accounts";
        ParentMember: Record Members;
        JuniorAcceptanceReport: Report JuniorAcceptanceLetter;
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        TempBlob: Codeunit "Temp Blob";
        ToRecipients: List of [Text];
        CCRecipients: List of [Text];
        BCCRecipients: List of [Text];
        OutStr: OutStream;
        InStr: InStream;
        EmailBody: Text;
        FileName: Text;
    begin
        Savings.Reset();
        Savings.SetRange("No.", AccountNo);
        if not Savings.FindFirst() then
            exit;

        if Savings."Product Category" <> Savings."Product Category"::"Junior Savings" then
            exit;

        Savings.TestField("Member No.");
        Savings.TestField("Child Name");

        ParentMember.Get(Savings."Member No.");
        ParentMember.TestField("E-Mail");

        if not SendNotifications(ParentMember."No.") then
            exit;

        ToRecipients.Add(ParentMember."E-Mail");
        EmailBody :=
            'Dear ' + ParentMember.Name + ',<br><br>' +
            'Attached find the Junior Savings Acceptance Letter for ' + Savings."Child Name" + '.<br><br>' +
            'The junior membership account number is <strong>' + Savings."No." + '</strong>.<br><br>' +
            'Kind Regards,<br>' +
            COMPANYNAME;

        EmailMsg.Create(ToRecipients, 'JUNIOR SAVINGS ACCEPTANCE LETTER', EmailBody, true, CCRecipients, BCCRecipients);

        Clear(JuniorAcceptanceReport);
        JuniorAcceptanceReport.SetTableView(Savings);

        TempBlob.CreateOutStream(OutStr);
        if not JuniorAcceptanceReport.SaveAs('', ReportFormat::Pdf, OutStr) then
            exit;

        TempBlob.CreateInStream(InStr);
        FileName := Savings."No." + '-JuniorAcceptanceLetter.pdf';
        EmailMsg.AddAttachment(FileName, 'application/pdf', InStr);
        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    end;


    procedure NotifyFinanceOfExitNotice(ExitNo: Code[20])
    var
        SaccoSetup: Record "Sacco Setup";
        EmailMsg: Codeunit "Email Message";
        BCCRecipients: List of [Text];
        CCRecipients: List of [Text];
        ToRecipients: List of [Text];
        Email: Codeunit Email;
        EmailBody: Text;
        EmailHeader: Label 'MEMBER EXIT NOTICE SUBMITTED';
    begin
        //notify finance department
        SaccoSetup.Get();
        if not EMPTY(SaccoSetup."Finance Email") then begin
            //send email
            EmailBody := 'Dear Finance Team,<br/><br/> A member exit notice' + ExitNo + ' has been submitted and is pending your review and processing.' +
            'Kindly log into the system to review the details and take the necessary actions.<br/><br/>' +
            'Best Regards,<br/>' + COMPANYNAME + ' Customer Service Team';

            ToRecipients.Add(SaccoSetup."Finance Email");
            EmailMsg.Create(ToRecipients, EmailHeader, EmailBody, true, CCRecipients, BCCRecipients);
            Email.Send(EmailMsg, Enum::"Email Scenario"::Default);

        end;

    end;

    local procedure SendNotifications(MemberNo: code[10]): Boolean
    var
        Member: Record Members;
    begin
        Member.Get(MemberNo);
        if Member."Exempt Send SMS" or Member."Exempt Send Email" then
            exit(false);
        exit(true);
    end;

    procedure EMPTY(TheString: Text): Boolean
    begin
        exit(StrLen(DelChr(TheString, '<>')) <= 0);
    end;

    local procedure ApplicationDocuments(EntrNo: Integer; DocumentType: Option; DocumentNo: Code[20]; Description: Text; SingleMultiple: Option; ReferenceNo: Code[20]; ProductID: Code[20]; ProductName: Text; DocProvided: Boolean)
    var
        myInt: Integer;
        MemberDocuments: Record "Member Documents";
        i: Integer;
    begin

        MemberDocuments.RESET;

        IF MemberDocuments.FIND('+') THEN
            i := MemberDocuments."Entry No.";

        //EntrNo:=MemberDocuments."Entry No."+1;
        MemberDocuments.INIT;
        MemberDocuments."Entry No." := i + 1;//+=EntrNo;
        MemberDocuments."Document Type" := DocumentType;
        MemberDocuments."Document No." := DocumentNo;
        MemberDocuments.Description := Description;
        MemberDocuments."Single Party/Multiple" := SingleMultiple;
        MemberDocuments."Reference No." := ReferenceNo;
        MemberDocuments."Product ID" := ProductID;
        MemberDocuments."Product Name" := ProductName;
        MemberDocuments.Provided := DocProvided;
        MemberDocuments.INSERT;

    end;

    procedure CreateSavingsAccount(ProductSetup: Record "Product Setup"; Cust: Record Members; MonthlyCont: Decimal; SkipExisting: Boolean; RepayMode: Enum "Repay Mode Enum") AccountNo: Code[20]
    var
        Savings: Record "Savings Accounts";
        AccNo: Code[20];
        AccCount: Integer;
        AccCode: Code[10];
        Nominee: Record Nominee;
        NomineeApp: Record Nominee;

    begin
        if (ProductSetup."Account No. Prefix" = '') and (ProductSetup."Account No. Suffix" = '') then
            Error('Prefix or Suffix MUST be setup in the %1 "Product Setup".', ProductSetup.Description);


        AccountNo := '';

        AccNo := ProductSetup."Account No. Prefix" + Cust."No." + ProductSetup."Account No. Suffix";


        if ProductSetup."Allow Multiple Accounts" then begin
            AccCount := 0;
            Savings.Reset;
            Savings.SetRange("Member No.", Cust."No.");
            Savings.SetRange("Product Type", ProductSetup."Product ID");
            if Savings.FindFirst then
                AccCount := Savings.Count;
            AccCount += 1;
            AccCode := Format(AccCount);
            if StrLen(AccCode) = 1 then
                AccCode := '0' + AccCode;

             AccNo := AccNo + '-' + AccCode;
        end
        else begin

            Savings.Reset;
            Savings.SetRange("Member No.", Cust."No.");
            Savings.SetRange("Product Type", ProductSetup."Product ID");
            if Savings.FindFirst then begin
                if SkipExisting then
                    exit
                else
                    error('Account Already Exists');
            end;
        end;

        if Savings.Get(AccNo) then begin

            if ProductSetup."Allow Multiple Accounts" then begin
                AccCount := 0;
                Savings.Reset;
                Savings.SetRange("Member No.", Cust."No.");
                Savings.SetRange("Product Type", ProductSetup."Product ID");
                if Savings.FindFirst then
                    AccCount := Savings.Count;
                AccCount += 1;
                AccCode := Format(AccCount);
                if StrLen(AccCode) = 1 then
                    AccCode := '0' + AccCode;

                //AccNo := AccNo + '-' + AccCode;
            end
            else
                if not SkipExisting then
                    Error('Account already Exists');
        end;


        if not Savings.Get(AccNo) then begin
            Savings.Init;
            Savings."No." := AccNo;
            Savings."Member No." := Cust."No.";
            Savings.Name := Cust.Name;
            // If Cust."Member Status" = Cust."Member Status"::New then
            //     Savings.Status := Savings.Status::New
            // else
            Savings.Status := Savings.Status::Active;
            Savings."Mobile Phone No." := Cust."Mobile Phone No.";
            Savings."Member Staff No." := Cust."Payroll/Staff No.";
            Savings."Member ID" := Cust."ID No.";
            Savings."Product Type" := ProductSetup."Product ID";
            Savings."Product Name" := ProductSetup.Description;
            Savings."Product Category" := ProductSetup."Product Category";
            Savings."Customer Posting Group" := ProductSetup."Product Posting Group";
            Savings."Monthly Contribution" := MonthlyCont;
            Savings."Repay Mode" := RepayMode;
            Savings."Document Type" := Savings."Document Type"::Savings;

            Savings."Creditor Type" := Savings."Creditor type"::FOSA;
            Savings."Group No." := Cust."Group No.";
            Savings."Global Dimension 1 Code" := ProductSetup."Global Dimension 1 Code";
            Savings.Insert;
        end;

        AccountNo := Savings."No.";

    end;


    procedure CreateVirtualFuuzaAccount(FosaNo: Code[20]; Cust: Record Members) AccountNo: Code[20]
    var
        Savings: Record "Savings Accounts";
        AccNo: Code[20];
        AccCount: Integer;
        AccCode: Code[10];
        ProductSetup: Record "Product Setup";

    begin

        ProductSetup.Reset();
        ProductSetup.SetRange("Product Category", ProductSetup."Product Category"::"Virtual Account");
        if ProductSetup.FindFirst() then begin

            AccountNo := '';

            AccNo := 'VA' + FosaNo;

            if not Savings.Get(AccNo) then begin
                Savings.Init;
                Savings."No." := AccNo;
                Savings."Member No." := Cust."No.";
                Savings.Name := Cust.Name;
                Savings."Mobile Phone No." := Cust."Mobile Phone No.";
                //Savings."Member Staff No." := Cust."Payroll/Staff No.";
                //Savings."Member ID" := Cust."ID No.";
                Savings."Product Type" := ProductSetup."Product ID";
                Savings."Product Name" := ProductSetup.Description;
                Savings."Product Category" := ProductSetup."Product Category";
                Savings."Customer Posting Group" := ProductSetup."Product Posting Group";
                Savings."Creditor Type" := Savings."Creditor type"::FOSA;
                Savings."Group No." := Cust."Group No.";
                Savings.Insert;
            end;

            AccountNo := Savings."No.";
        end;
    end;

    procedure SendSms(Source: Enum "SMS Source Enum"; Telephone: Text[200];
                                  Textsms: Text[250];
                                  Reference: Text[30];
                                  AccNo: Text[30];
                                  Chargeable: Boolean;
                                  LoanPenalty: Boolean)
    var
        Sms: Record "SMS Messages";
        Member: Record Members;
        MemberSMS: Record "Member SMS";
        SkipSMS: Boolean;
    begin

        //Subs.RESET;

        SkipSMS := false;
        if (Source <> Source::"Loan Rejected") and (Source <> Source::"Loan Bill Due") then begin
            Member.Reset;
            Member.SetRange("Mobile Phone No.", Telephone);
            if Member.Find('-') then begin
                MemberSMS.Reset;
                MemberSMS.SetRange("Member No", Member."No.");
                MemberSMS.SetRange(Source, Source);
                if MemberSMS.FindFirst then begin
                    SkipSMS := true;
                end;
            end;
        end;

        if not SkipSMS then begin

            Sms.Init;
            //Sms."SMS ID" := CREATEGUID;
            Sms.Source := Source;
            Sms."Mobile Phone No." := Replacestring(Telephone, '-', '+');
            Sms."Date Entered" := Today;
            Sms."Time Entered" := Time;
            Sms."Entered By" := UserId;
            Sms."SMS Message" := Textsms;

            if ((StrLen(Telephone) >= 9) and (StrLen(Telephone) <= 13)) then begin
                Sms."Sent To Server" := Sms."sent to server"::No;
            end else begin
                Sms."Sent To Server" := Sms."sent to server"::Failed;
            end;

            Sms."Document No" := Reference;
            Sms."Account No" := AccNo;
            Sms.IsChargeable := Chargeable;
            Sms."Post to Loan Penalty" := LoanPenalty;
            Sms.Posted := false;
            Sms.Insert;

        end;
    end;


    procedure Replacestring(string: Text[200]; findwhat: Text[30]; replacewith: Text[200]) Newstring: Text[200]
    begin
        while StrPos(string, findwhat) > 0 do
            string := DelStr(string, StrPos(string, findwhat)) + replacewith + CopyStr(string, StrPos(string, findwhat) + StrLen(findwhat));
        Newstring := string;
    end;


    procedure GetMemberCommittedDeposits(DepositAccount: Code[20]; ActiveLoan: Boolean): Decimal
    var
        Cust: Record Members;
        PFact: Record "Product Setup";
        Savings: Record "Savings Accounts";
        LRec: Record Loans;
        LoanSecurity: Record "Loan Security";
        LSecurity: Record "Loan Security";
        TopUp: Record "Appraisal Top Up";
        CommittedAmount: Decimal;
        Loans: Record Loans;
    begin
        CommittedAmount := 0;
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."guarantor type"::Guarantor);
        LoanSecurity.SetRange("Account No.", DepositAccount);
        LoanSecurity.SetRange(Substituted, false);

        // Only load the fields we use and ask server to auto-calc flowfields
        LoanSecurity.SetLoadFields("Loan No.", "Current Committed", "Outstanding Principal", "Member No");
        LoanSecurity.SetAutoCalcFields("Outstanding Principal");

        if ActiveLoan then
            LoanSecurity.SetFilter("Outstanding Principal", '>0')
        else
            LoanSecurity.SetFilter("Outstanding Principal", '<=0');

        LoanSecurity.SetRange("Mobile Loan", false);

        if LoanSecurity.FindSet(false) then begin
            repeat
                // No LoanSecurity.CalcFields() here — Current Committed / Outstanding Principal already pre-calculated
                if Loans.Get(LoanSecurity."Loan No.") then;
                Savings.Get(DepositAccount);

                if ActiveLoan then begin
                    LSecurity.Reset();
                    LSecurity.SetRange("Account No.", DepositAccount);
                    if LSecurity.FindFirst() then begin
                        TopUp.Reset;
                        TopUp.SetRange("Loan No.", LSecurity."Loan No.");
                        TopUp.SetRange("Member No.", LSecurity."Member No");
                        if not TopUp.Find('-') then begin
                            if Loans."Member No." <> Savings."Member No." then //to check both self and other guarantor committement subject to change 13.05.2026
                                CommittedAmount += LoanSecurity."Current Committed";
                        end;
                    end;
                end else begin
                    LRec.Reset;
                    LRec.SetRange("Loan No.", LoanSecurity."Loan No.");
                    LRec.SetFilter(Status, '<>%1&<>%2', LRec.Status::Deffered, LRec.Status::Rejected);
                    LRec.SetRange(Posted, false);
                    if LRec.FindFirst then
                        if Loans."Member No." <> Savings."Member No." then
                            CommittedAmount += LoanSecurity."Current Committed";
                end;
            until LoanSecurity.Next = 0;
        end;

        exit(CommittedAmount);
    end;



    procedure GetSelfGuaranteeCommitment(DepositAccount: Code[20]; ActiveLoan: Boolean): Decimal
    var
        Cust: Record Members;
        PFact: Record "Product Setup";
        Savings: Record "Savings Accounts";
        LRec: Record Loans;
        LoanSecurity: Record "Loan Security";
        LSecurity: Record "Loan Security";
        TopUp: Record "Loan Top Up";
        MyCommittedAmount: Decimal;
        Loans: Record Loans;
        AppTopUp: Record "Appraisal Top Up";
        LoanApp: Record "Member Salary Appraisal";

    begin
        MyCommittedAmount := 0;
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."guarantor type"::Guarantor);
        LoanSecurity.SetRange("Account No.", DepositAccount);
        LoanSecurity.SetRange(Substituted, false);

        // Limit load and pre-calc FlowFields
        LoanSecurity.SetLoadFields("Loan No.", "Current Committed", "Outstanding Principal", "Member No");
        LoanSecurity.SetAutoCalcFields("Outstanding Principal");

        if ActiveLoan then
            LoanSecurity.SetFilter("Outstanding Principal", '>0')
        else
            LoanSecurity.SetFilter("Outstanding Principal", '<=0');

        LoanSecurity.SetRange("Mobile Loan", false);

        if LoanSecurity.FindSet(false) then begin
            repeat
                Loans.Get(LoanSecurity."Loan No.");
                Savings.Get(DepositAccount);

                // No LoanSecurity.CalcFields() — fields already calculated
                if ActiveLoan then begin
                    LSecurity.Reset();
                    LSecurity.SetRange("Account No.", DepositAccount);
                    if LSecurity.FindFirst() then begin
                        TopUp.Reset;
                        TopUp.SetRange("Loan No.", LSecurity."Loan No.");
                        TopUp.SetRange("Member No.", LSecurity."Member No");
                        if not TopUp.Find('-') then begin
                            if Loans."Member No." = Savings."Member No." then
                                MyCommittedAmount += LoanSecurity."Current Committed";
                        end;
                    end;

                    LSecurity.Reset();
                    LSecurity.SetRange("Account No.", DepositAccount);
                    if LSecurity.FindFirst() then begin
                        AppTopUp.Reset;
                        AppTopUp.SetRange("Loan No.", LSecurity."Loan No.");
                        AppTopUp.SetRange("Member No.", LSecurity."Member No");
                        if not AppTopUp.Find('-') then begin
                            if LoanApp."Member No." = Savings."Member No." then
                                MyCommittedAmount += LoanSecurity."Current Committed";
                        end;
                    end;

                end else begin
                    LRec.Reset;
                    LRec.SetRange("Loan No.", LoanSecurity."Loan No.");
                    LRec.SetFilter(Status, '<>%1&<>%2', LRec.Status::Deffered, LRec.Status::Rejected);
                    LRec.SetRange(Posted, false);
                    if LRec.FindFirst then
                        if Loans."Member No." = Savings."Member No." then
                            MyCommittedAmount += LoanSecurity."Current Committed";
                end;
            until LoanSecurity.Next = 0;
        end;

        exit(MyCommittedAmount);
    end;


    procedure GetCurrentSelfCommittedDeposits(DepositAccount: Code[20]; ActiveLoan: Boolean; LoanProduct: Record "Product Setup"): Decimal
    var
        Cust: Record Members;
        PFact: Record "Product Setup";
        Savings: Record "Savings Accounts";
        LRec: Record Loans;
        LoanSecurity: Record "Loan Security";
        CommittedAmount: Decimal;
    begin

        //Current commited to you loan
        /* 
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."guarantor type"::Guarantor);
        LoanSecurity.SetRange("Account No.", DepositAccount);
        LoanSecurity.SetRange(Substituted, false);
        LoanSecurity.SetFilter("Outstanding Principal", '>0');
        if LoanSecurity.FindSet(false) then
            repeat
                Report.Run(Report::"Update Guarantor Commitment", false, false, LoanSecurity);
                Commit();
            until LoanSecurity.Next() = 0;
        */

        CommittedAmount := 0;
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."guarantor type"::Guarantor);
        LoanSecurity.SetRange("Account No.", DepositAccount);
        LoanSecurity.SetRange(Substituted, false);
        //LoanSecurity.SETFILTER("Loan Type", '<>L45');//Added By Tony
        if LoanProduct."Guarantorship Option" = LoanProduct."Guarantorship Option"::" " then
            LoanSecurity.SetRange("Self Guarantee", true)
        else
            LoanSecurity.SetRange("Mobile Loan", false); //Condition for development loan on mobile
        //LoanSecurity.SETRANGE("Defaulter Release",FALSE);
        //LoanSecurity.SETFILTER("Amount Guaranteed",'>0');

        if ActiveLoan then
            LoanSecurity.SetFilter("Outstanding Principal", '>0')
        else
            LoanSecurity.SetFilter("Outstanding Principal", '<=0');

        if LoanSecurity.FindSet(false) then begin
            repeat
                LoanSecurity.CalcFields("Outstanding Principal");
                // MESSAGE('T - %1\%2', LoanSecurity."Outstanding Principal", LoanSecurity."Loan No.");
                if ActiveLoan then
                    CommittedAmount += LoanSecurity."Current Committed"
                else begin
                    LRec.Reset;
                    LRec.SetRange("Loan No.", LoanSecurity."Loan No.");
                    LRec.SetFilter(Status, '<>%1&<>%2', LRec.Status::Deffered, LRec.Status::Rejected);
                    LRec.SetRange(Posted, false);
                    if LRec.FindFirst then
                        CommittedAmount += LoanSecurity."Current Committed";
                end;
            until LoanSecurity.Next = 0;
        end;

        // MESSAGE(DepositAccount);
        // IF DepositAccount = 'S02-06340' THEN
        //     MESSAGE('%1', CommittedAmount);


        exit(CommittedAmount);
    end;


    procedure GetCommittedCollateral(CollateralRegNo: Code[20]; ActiveLoan: Boolean): Decimal
    var
        Cust: Record Members;
        PFact: Record "Product Setup";
        Savings: Record "Savings Accounts";
        LRec: Record Loans;
        LoanSecurity: Record "Loan Security";
        CommittedAmount: Decimal;
        TopUp: Record "Appraisal Top Up";
        LSecurity: Record "Loan Security";
    begin

        CommittedAmount := 0;
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."guarantor type"::Collateral);
        LoanSecurity.SetRange("Collateral Reg. No.", CollateralRegNo);
        LoanSecurity.SetRange(Substituted, false);
        //LoanSecurity.SETRANGE("Defaulter Release",FALSE);
        LoanSecurity.SetFilter("Amount Guaranteed", '>0');

        if ActiveLoan then
            LoanSecurity.SetFilter("Outstanding Principal", '>0')
        else
            LoanSecurity.SetFilter("Outstanding Principal", '<=0');

        if LoanSecurity.Find('-') then begin
            repeat
                if ActiveLoan then begin

                    LSecurity.Reset();
                    LSecurity.SetRange("Account No.", LoanSecurity."Account No.");
                    LSecurity.SetRange("Collateral Reg. No.", CollateralRegNo);
                    LoanSecurity.SetRange("Loan No.", LoanSecurity."Loan No.");
                    if LSecurity.FindLast() then begin

                        TopUp.Reset;
                        TopUp.SetRange("Loan Top Up", LSecurity."Loan No.");
                        TopUp.SetRange("Member No.", LSecurity."Member No");
                        if not TopUp.Find('-') then begin
                            CommittedAmount += LoanSecurity."Current Committed"
                        end;

                    end
                end
                else begin
                    LRec.Reset;
                    LRec.SetRange("Loan No.", LoanSecurity."Loan No.");
                    LRec.SetFilter(Status, '<>%1&<>%2', LRec.Status::Deffered, LRec.Status::Rejected);
                    LRec.SetRange(Posted, false);
                    if LRec.FindFirst then
                        CommittedAmount += LoanSecurity."Current Committed";
                end;
            until LoanSecurity.Next = 0;
        end;

        exit(CommittedAmount);
    end;


    procedure GetMemberCommittedLien(LienAccount: Code[20]; ActiveLoan: Boolean): Decimal
    var
        Cust: Record Members;
        PFact: Record "Product Setup";
        Savings: Record "Savings Accounts";
        LRec: Record Loans;
        LoanSecurity: Record "Loan Security";
        TopUp: Record "Appraisal Top Up";
        CommittedAmount: Decimal;
    begin

        CommittedAmount := 0;
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."guarantor type"::Lien);
        LoanSecurity.SetRange("Account No.", LienAccount);
        LoanSecurity.SetRange(Substituted, false);
        //LoanSecurity.SETRANGE("Defaulter Release",FALSE);
        //LoanSecurity.SETRANGE("Loan Top Up",FALSE);
        LoanSecurity.SetFilter("Amount Guaranteed", '>0');

        if ActiveLoan then
            LoanSecurity.SetFilter("Outstanding Principal", '>0')
        else
            LoanSecurity.SetFilter("Outstanding Principal", '<=0');

        if LoanSecurity.Find('-') then begin
            repeat
                if ActiveLoan then begin
                    TopUp.Reset;
                    TopUp.SetRange("Loan Top Up", LoanSecurity."Loan No.");
                    TopUp.SetRange("Member No.", LoanSecurity."Member No");
                    if not TopUp.Find('-') then begin
                        CommittedAmount += LoanSecurity."Current Committed"
                    end;
                end else begin
                    LRec.Reset;
                    LRec.SetRange("Loan No.", LoanSecurity."Loan No.");
                    LRec.SetFilter(Status, '<>%1&<>%2', LRec.Status::Deffered, LRec.Status::Rejected);
                    LRec.SetRange(Posted, false);
                    if LRec.FindFirst then
                        CommittedAmount += LoanSecurity."Current Committed";
                end;
            until LoanSecurity.Next = 0;
        end;

        exit(CommittedAmount);
    end;

    procedure GetCommittedCollateralForMember(CollateralRegNo: Code[20]; MemberNo: Code[20]; ActiveLoan: Boolean): Decimal
    var
        LRec: Record Loans;
        LoanSecurity: Record "Loan Security";
        CommittedAmount: Decimal;
        TopUp: Record "Appraisal Top Up";
    begin
        CommittedAmount := 0;

        LoanSecurity.Reset();
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."Guarantor Type"::Collateral);
        LoanSecurity.SetRange("Collateral Reg. No.", CollateralRegNo);
        LoanSecurity.SetRange("Account No.", MemberNo);
        LoanSecurity.SetRange(Substituted, false);
        LoanSecurity.SetFilter("Amount Guaranteed", '>0');

        if ActiveLoan then
            LoanSecurity.SetFilter("Outstanding Principal", '>0')
        else
            LoanSecurity.SetFilter("Outstanding Principal", '<=0');

        if LoanSecurity.FindSet() then begin
            repeat
                // If this loan is being topped up, its security is released —  skip it
                TopUp.Reset();
                TopUp.SetRange("Loan Top Up", LoanSecurity."Loan No.");
                TopUp.SetRange("Member No.", LoanSecurity."Member No");
                if TopUp.IsEmpty() then begin
                    // Security is NOT released by a top-up — check further
                    if ActiveLoan then begin
                        // Active loans: count committed amount directly
                        CommittedAmount += LoanSecurity."Current Committed";
                    end else begin
                        // Inactive loans: only count if there's a pending unposted application
                        LRec.Reset();
                        LRec.SetRange("Loan No.", LoanSecurity."Loan No.");
                        LRec.SetFilter(
                            Status, '<>%1&<>%2',
                            LRec.Status::Deffered,
                            LRec.Status::Rejected
                        );
                        LRec.SetRange(Posted, false);
                        if LRec.FindFirst() then
                            CommittedAmount += LoanSecurity."Current Committed";
                    end;
                end;
            // else: top-up exists → security is released → skip (add nothing)

            until LoanSecurity.Next() = 0;
        end;

        exit(CommittedAmount);
    end;

    procedure GetCommittedCollateralWithAllocation(CollateralRegNo: Code[20]; MemberNo: Code[20]; ActiveLoan: Boolean): Decimal
    var
        CollateralAllocation: Record "Collateral Allocation";
        HasAllocation: Boolean;
    begin

        CollateralAllocation.Reset();
        CollateralAllocation.SetRange("Collateral No.", CollateralRegNo);
        HasAllocation := not CollateralAllocation.IsEmpty;

        if HasAllocation then
            exit(GetCommittedCollateralForMember(CollateralRegNo, MemberNo, ActiveLoan))

    end;

    procedure SendRejectSms(Loans: Record Loans)
    var
        SaccoSetup: Record "Sacco Setup";
        Member: Record Members;
        EmailLogs: Record "Email Logs Notifications";
        EmailLogs2: Record "Email Logs Notifications";
        Msg: Text;
        MemberActivities: Codeunit "Member Activities";
        Smssource: Enum "SMS Source Enum";
        Sky: Codeunit "Sky MBanking";
        LoanSecurity: Record "Loan Security";
        i: Integer;
    begin

        SaccoSetup.get;

        if Member.Get(Loans."Member No.") then begin

            Msg := 'Dear ' + Sky.FirstName(Member.Name) + ', Your ' + Loans."Loan Product Type Name" + ' of KES ' + Format(Loans."Requested Amount") + ' has been rejected . Call ' + SaccoSetup."Sacco Contacts" + ' if in dispute.';

            MemberActivities.SendSms(Smssource::"Loan Rejected", Member."Mobile Phone No.", Msg,
            Loans."Loan No.", Loans."Disbursement Account No", true, false);
        end;
    end;

    procedure ShowMemberInfo(MemberNo: Code[20])
    var
        InfoBase: Record "Information Base.";
        InfoMessage: Text;
    begin
        InfoBase.SetRange("Member No.", MemberNo);
        if InfoBase.FindSet() then begin
            InfoMessage := 'Important Information:\';

            repeat
                InfoMessage += '\';
                InfoMessage += 'Date: ' + Format(InfoBase.Date) + '\';
                InfoMessage += InfoBase.Info + '\';
                InfoMessage += 'Captured By: ' + InfoBase."Captured By" + '\';
                if InfoBase."Action Date" <> 0D then
                    InfoMessage += 'Action Date: ' + Format(InfoBase."Action Date") + '\';
                InfoMessage += '-----------------------------------\';
            until InfoBase.Next() = 0;

            Message(InfoMessage);
        end;
    end;

    procedure CheckMemberHasInfo(MemberNo: Code[20]): Boolean
    var
        InfoBase: Record "Information Base.";
    begin
        InfoBase.SetRange("Member No.", MemberNo);
        exit(not InfoBase.IsEmpty);
    end;

    procedure SendAnSmsToTheGuarantor(Loans: Record Loans)
    var
        SaccoSetup: Record "Sacco Setup";
        Member: Record Members;
        EmailLogs: Record "Email Logs Notifications";
        EmailLogs2: Record "Email Logs Notifications";
        Msg: Text;
        MemberActivities: Codeunit "Member Activities";
        Smssource: Enum "SMS Source Enum";
        Sky: Codeunit "Sky MBanking";
        LoanSecurity: Record "Loan Security";
        i: Integer;
    begin

        SaccoSetup.get;
        LoanSecurity.Reset();
        LoanSecurity.SetRange("Loan No.", Loans."Loan No.");
        LoanSecurity.SetRange("SMS Sent", false);
        if LoanSecurity.FindSet() then
            repeat
                if Member.Get(LoanSecurity."Member No") then begin

                    // Msg := 'Dear ' + Sky.FirstName(Member.Name) + ', You have guaranteed ' + Loans."Member Name" + ' for a ' + Loans."Loan Product Type Name" + ' of KES ' + Format(Loans."Approved Amount") + '. Call ' + SaccoSetup."Sacco Contacts" + ' if in dispute.';

                    //TestField("Disbursement Account No");
                    /* if LoanSecurity."Member No" <> Loans."Member No." then
                        MemberActivities.SendSms(Smssource::"Loan Guarantors", Member."Mobile Phone No.", Msg,
                        Loans."Loan No.", Loans."Disbursement Account No", true, false); */

                end;

                LoanSecurity."SMS Sent" := true;
                LoanSecurity.Modify();

                // Send email to the guarantor
                // Send email to the 
                EmailLogs2.Reset();
                if EmailLogs2.FindLast() then
                    i := EmailLogs2.Line + 1;

                EmailLogs.Init();
                EmailLogs."Loan No." := Loans."Loan No.";
                EmailLogs.Line := i;
                EmailLogs."Guarantor No." := Member."No.";
                EmailLogs.Msg := Sky.FirstName(Member.Name) + ', You have guaranteed ' + Loans."Member Name" + ' for a ' + Loans."Loan Product Type Name" + ' of KES ' + Format(Loans."Approved Amount") + '. Call ' + SaccoSetup."Sacco Contacts" + ' if in dispute.';
                EmailLogs.Source := EmailLogs.Source::Guarantor;
                if EmailLogs.Insert() then;

            until LoanSecurity.Next() = 0;

    end;


    procedure SetLoanAppraisal(LoanNo: Code[20])
    var
        ProdFact: Record "Product Setup";
        LType: Record "Product Setup";
        Loans: Record Loans;
        Appraisal: Record "Loan Appraisal";
        Savings: Record "Savings Accounts";
        LRec: Record Loans;
        LBal: Decimal;
        LSecurity: Record "Loan Security";
        LGuarAmount: Decimal;
        TopUp: Record "Loan Top Up";
        ChargeExtraComms: Boolean;
        PCharges: Record "Loan Product Charges.";
        TopUpComms: Decimal;
        Amt: Decimal;
        GenSetup: Record "General Ledger Setup";
        AppraisalSal: Record "Appraisal Salary Details";
        TBasic: Decimal;
        TGross: Decimal;
        TEarning: Decimal;
        TAllowance: Decimal;
        TClearedEffects: Decimal;
        TDeductions: Decimal;
        ExternalEff: Record "General Ledger Setup";
        ExternalCharges: Decimal;
        OCharges: Record "General Ledger Setup";
        OtherCharges: Decimal;
        DepDiff: Decimal;
        PVA: Decimal;
        Duty: Decimal;
        TBoost: Decimal;
        BoostComm: Decimal;
        LCharges: Record "General Ledger Setup";
        TCurrBonus: Decimal;
        TPrevBonus: Decimal;
        LoanType: Record "Product Setup";
        LProduct: Record "Product Setup";
        TJunior: Decimal;
        TopUpApproved: Decimal;
        Micro: Boolean;
        ShareCapBoost: Decimal;
        NoCharge: Boolean;
        ChgAmt: Decimal;
        Reverse: Decimal;
        ProductCharge: Decimal;
        PrincIntQual: Decimal;
        RecomAppraisal: Decimal;
        Loantypes: Record "Product Setup";
        LoanRecord: Record Loans;
        MainLoan: Record Loans;
        MainProduct: Record "Product Setup";
        StaggeredLines: Record "Staggered Lines.";
        SLedger: Record "Savings Ledger Entry";
        LCheck: Record "Loan Appraisal Check";
        PChAmt: Decimal;
        GL: Code[20];
        EDuty: Decimal;
        OtherClearance: Record "Other Committments Clearance";
        STOHeader: Record "Standing Order Header";
        Mem: Record Members;
    begin

        GenSetup.Get;
        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNo);
        Loans.SetRange(Posted, false);
        if Loans.FindFirst then begin

            Appraisal.Reset;
            Appraisal.SetRange("Loan No.", Loans."Loan No.");
            if Appraisal.FindFirst then
                Appraisal.Delete;



            LoanType.Get(Loans."Loan Product Type");

            if Mem.get(Loans."Member No.") then;

            TBoost := 0;

            IF Loans."Loan Calculator" then begin

                LCheck.Init();
                LCheck."Member No." := Loans."Member No.";
                LCheck."Member Name" := Loans."Member Name";
                LCheck.Date := Today;
                LCheck."Requested Amount" := Loans."Requested Amount";

            end;




            Appraisal.Init;
            Appraisal."Loan No." := Loans."Loan No.";
            Appraisal."Member No." := Loans."Member No.";
            Appraisal."Loan Disbursement Account" := Loans."Disbursement Account No";
            Appraisal.Name := Loans."Member Name";
            Appraisal."Product Code" := Loans."Loan Product Type";
            Appraisal."Requested Amount" := Loans."Requested Amount";
            Appraisal."Approved Amount" := Loans."Approved Amount";
            Appraisal."Registration Fee" := Loans."Registration Fee";
            Appraisal.Multiplier := LoanType."Deposit Multiplier";
            Appraisal."Share Financing" := Loans."Share Capital Boosting";
            Appraisal."Deposit Financing" := Loans."Deposit Boosting";
            Appraisal."Boosting Commission" := Loans."Deposit Boosting Commission";
            Appraisal."Application Date" := Loans."Application Date";
            Appraisal."Total Arrears" := Loans."Total Arrears";
            Appraisal."Net Pay" := Loans."Net Income Per Month";
            Appraisal."Monthly Expenditure" := Loans."Monthly Expenditure";

            ProdFact.Reset;
            if Mem."Group Account" then
                ProdFact.SetRange("Auto Open Chamaa Account", true)
            else
                ProdFact.SetRange("Auto Open Chamaa Account", false);
            ProdFact.SetRange("Product Category", ProdFact."product category"::"Deposit Contribution");
            if ProdFact.FindFirst then begin

                Savings.Reset;
                Savings.SetRange("Member No.", Loans."Member No.");
                Savings.SetRange("Product Type", ProdFact."Product ID");
                if Savings.FindFirst then begin
                    Savings.CalcFields("Balance (LCY)");

                    Appraisal."Bosa Deposits" := Savings."Balance (LCY)";

                    SLedger.Reset();
                    SLedger.SetRange("Account No.", Savings."No.");
                    SLedger.SetFilter("Amount (LCY)", '<0');
                    SLedger.SetRange(Reversed, false);
                    if SLedger.FindLast() then begin
                        SLedger.CalcSums("Amount (LCY)");
                        Appraisal."Last Deposit Amount" := SLedger."Amount (LCY)" * -1;
                        Appraisal."Last Deposit Date" := SLedger."Posting Date";
                    end;

                end;
            end;

            Appraisal."STO Deduction" := 0;

            if LoanType."Appraisal Include STO Ded." then begin
                STOHeader.Reset();
                STOHeader.SetRange("Member No.", Loans."Member No.");
                STOHeader.setfilter("Income Type", '%1|%2', STOHeader."Income Type"::Salary, STOHeader."Income Type"::Pension);
                STOHeader.SetRange(Status, STOHeader.Status::Approved);
                STOHeader.SetRange("Source Account No.", Loans."Disbursement Account No");
                if STOHeader.FindFirst() then begin
                    repeat
                    //Appraisal."STO Deduction" += STOHeader.Amount;
                    until STOHeader.Next() = 0;
                end;
            end;

            ProdFact.Reset;
            ProdFact.SetRange("Product Category", ProdFact."product category"::"Micro Member Deposit");
            if ProdFact.FindFirst then begin
                Savings.Reset;
                Savings.SetRange("Member No.", Loans."Member No.");
                Savings.SetRange("Product Type", ProdFact."Product ID");
                if Savings.FindFirst then begin
                    Savings.CalcFields("Balance (LCY)");
                    Appraisal."Micro Deposits" := Savings."Balance (LCY)";
                end;
            end;

            Appraisal."Total Deposits" := Appraisal."Bosa Deposits" + Appraisal."Class B Deposits" + Appraisal."Micro Deposits";

            LBal := 0;
            LRec.Reset;
            LRec.SetRange("Member No.", Loans."Member No.");
            LRec.SetFilter("Outstanding Principal", '>0');
            //LRec.SetRange(Source, LRec.Source::FOSA);
            if LRec.Find('-') then begin
                repeat
                    LRec.CalcFields("Outstanding Principal", "Outstanding Interest");
                    LBal += LRec."Outstanding Principal" + LRec."Outstanding Interest";
                    Appraisal."Current Loans Repayments" += LRec."Principal Repayment"
                until LRec.Next = 0;
            end;

            Appraisal."Current Loan Balance" := LBal;

            Appraisal.Installments := Loans.Installments;

            Appraisal."No. of Guarantors" := 0;
            LGuarAmount := 0;
            LSecurity.Reset;
            LSecurity.SetRange("Loan No.", Loans."Loan No.");
            if LSecurity.Find('-') then begin
                repeat
                    LGuarAmount += LSecurity."Amount Guaranteed";
                    Appraisal."No. of Guarantors" += 1;
                until LSecurity.Next = 0;
            end;
            Appraisal."Amount Guaranteed" := LGuarAmount;

            //xxx
            Appraisal."Salary Through Fosa" := false;


            ProdFact.Reset;
            ProdFact.SetRange("Product Category", ProdFact."product category"::"Share Capital");
            if ProdFact.FindFirst then begin
                Savings.Reset;
                Savings.SetRange("Member No.", Loans."Member No.");
                Savings.SetRange("Product Type", ProdFact."Product ID");
                if Savings.FindFirst then begin
                    Savings.CalcFields("Balance (LCY)");
                    Appraisal."Share Capital" := Savings."Balance (LCY)";
                end;
                Appraisal."Minimum Share Capital" := ProdFact."Minimum Contribution";
            end;

            Appraisal."Activity Code" := Loans."Global Dimension 1 Code";
            Appraisal."Branch Code" := Loans."Booking Branch";


            Appraisal."Previous Contribution" := 0;

            ProdFact.Reset;
            if Mem."Group Account" then
                ProdFact.SetRange("Auto Open Chamaa Account", true)
            else
                ProdFact.SetRange("Auto Open Chamaa Account", false);
            ProdFact.SetRange("Product Category", ProdFact."product category"::"Deposit Contribution");
            if ProdFact.FindFirst then begin

                Savings.Reset;
                Savings.SetRange("Member No.", Loans."Member No.");
                Savings.SetRange("Product Type", ProdFact."Product ID");
                Savings.SetFilter("Date Filter", '%1..%2', CalcDate('-1M-CM', Loans."Application Date"), CalcDate('-1M+CM', Loans."Application Date"));
                if Savings.FindFirst then begin
                    //MESSAGE(Savings.GETFILTER("Date Filter"));
                    Savings.CalcFields("Balance (LCY)");
                    Appraisal."Previous Contribution" := Savings."Balance (LCY)";
                end;
            end;



            if LoanType."Loan Source" = LoanType."loan source"::MICRO then
                Appraisal.Deposits := Appraisal."Micro Deposits"
            else
                Appraisal.Deposits := Appraisal."Bosa Deposits";



            LBal := 0;
            LRec.Reset;
            LRec.SetRange("Member No.", Loans."Member No.");
            LRec.SetFilter("Outstanding Principal", '>0');
            if LRec.Find('-') then begin
                repeat
                    LRec.CalcFields("Outstanding Principal", "Outstanding Interest");
                    LBal += LRec."Outstanding Principal";

                until LRec.Next = 0;
            end;
            Appraisal."Loan Outstanding" := LBal;



            Appraisal."Exisiting Loan Repayment" := 0;
            // IF LoanType."Appraisal-Check Repayments" THEN BEGIN
            LRec.Reset;
            LRec.SetRange("Member No.", Loans."Member No.");
            LRec.SetFilter("Outstanding Principal", '>0');
            LRec.SetRange(Source, LRec.Source::BOSA);
            if LRec.Find('-') then begin
                repeat
                    LRec.CalcFields("Outstanding Principal");
                    TopUp.Reset;
                    TopUp.SetRange("Loan Top Up", LRec."Loan No.");
                    TopUp.SetFilter("Principle Top Up", '>0');
                    if not TopUp.Find('-') then begin
                        repeat
                            Appraisal."Exisiting Loan Repayment" += LRec."Loan Principle Repayment";
                        until TopUp.Next = 0;
                    end;
                until LRec.Next = 0;
            end;
            //END;


            Appraisal."Committed Deposits" := 0;
            Appraisal."Product Frequency" := 0;

            LRec.Reset;
            LRec.SetRange("Member No.", Loans."Member No.");
            LRec.SetRange("Loan Product Type", Loans."Loan Product Type");
            if LRec.Find('-') then begin
                Appraisal."Product Frequency" := LRec.Count();
            end;


            LRec.Reset;
            LRec.SetRange("Member No.", Loans."Member No.");
            LRec.SetFilter("Outstanding Principal", '>0');
            if LRec.Find('-') then begin
                repeat

                    LRec.CalcFields("Outstanding Principal");
                    TopUp.Reset;
                    TopUp.SetRange("Loan Top Up", LRec."Loan No.");
                    TopUp.SetFilter("Principle Top Up", '>0');
                    if not TopUp.Find('-') then begin
                        repeat
                            LProduct.Get(LRec."Loan Product Type");

                            if LProduct."Deposit Multiplier" > 0 then
                                Appraisal."Committed Deposits" += ROUND(LRec."Outstanding Principal" / LProduct."Deposit Multiplier", 0.01, '>')

                        until TopUp.Next = 0;
                    end;
                until LRec.Next = 0;
            end;

            Appraisal."Available Deposits" := Appraisal.Deposits - Appraisal."Committed Deposits";

            if Appraisal."Available Deposits" < 0 then
                Appraisal."Available Deposits" := 0;

            Appraisal."Deposit Multiplier" := (Appraisal."Available Deposits") * LoanType."Deposit Multiplier";
            Appraisal.Multiplier := LoanType."Deposit Multiplier";

            Appraisal."Maximum Credit" := Appraisal."Deposit Multiplier";

            Duty := 0;
            TopUpApproved := 0;

            //Toatl top ups
            TopUp.Reset;
            TopUp.SetRange("Loan No.", Loans."Loan No.");
            TopUp.SetRange("Member No.", Loans."Member No.");
            if TopUp.Find('-') then begin
                TopUpComms := 0;
                repeat
                    Appraisal."Principle Top Up" += TopUp."Principle Top Up";
                    Appraisal."Top Up Penalty" += TopUp."Penalty Top Up";
                    Appraisal."Top Up Appraisal" += TopUp."Appraisal Top Up";
                    Appraisal."Interest Top Up" += TopUp."Interest Top Up";
                    Appraisal."Top Up Commission" += TopUp.Commision;

                until TopUp.Next = 0;
            end;



            // Appraisal."Maximum Credit" := Appraisal."Deposit Multiplier";

            Appraisal."Current Share Capital" := Appraisal."Share Capital";
            Appraisal."Deficit Share Capital" := Appraisal."Minimum Share Capital" - Appraisal."Current Share Capital";

            if Appraisal."Deficit Share Capital" < 0 then
                Appraisal."Deficit Share Capital" := 0;


            //ShareCapBoost := 0;
            //Appraisal."Share Financing" := 0;



            //Income Analysis
            //Qualification on salary
            TGross := 0;
            TBasic := 0;
            TEarning := 0;
            TAllowance := 0;
            TClearedEffects := 0;
            TDeductions := 0;
            TCurrBonus := 0;
            TPrevBonus := 0;
            TJunior := 0;
            AppraisalSal.Reset;
            AppraisalSal.SetRange("Loan No", Loans."Loan No.");
            if AppraisalSal.Find('-') then begin
                repeat
                    if AppraisalSal.Type = AppraisalSal.Type::"Gross Pay" then
                        TGross := TGross + AppraisalSal.Amount
                    else
                        if AppraisalSal.Type = AppraisalSal.Type::Basic then
                            TBasic := TBasic + AppraisalSal.Amount
                        else
                            if AppraisalSal.Type = AppraisalSal.Type::Earnings then
                                TEarning := TEarning + AppraisalSal.Amount
                            else
                                if AppraisalSal.Type = AppraisalSal.Type::"Other Allowances" then
                                    TAllowance := TAllowance + AppraisalSal.Amount
                                else
                                    if AppraisalSal.Type = AppraisalSal.Type::"House Allowance" then
                                        TAllowance := TAllowance + AppraisalSal.Amount
                                    else
                                        if AppraisalSal.Type = AppraisalSal.Type::"Commuter Allowance" then
                                            TAllowance := TAllowance + AppraisalSal.Amount
                                        else
                                            if AppraisalSal.Type = AppraisalSal.Type::"Bosa Deductions" then
                                                TDeductions := TDeductions + AppraisalSal.Amount
                                            else
                                                if AppraisalSal.Type = AppraisalSal.Type::"Cleared Effects" then
                                                    TClearedEffects := TClearedEffects + AppraisalSal.Amount
                                                else
                                                    if AppraisalSal.Type = AppraisalSal.Type::Deductions then
                                                        TDeductions := TDeductions + AppraisalSal.Amount
                                                    else
                                                        if AppraisalSal.Type = AppraisalSal.Type::Junior then
                                                            TJunior := TJunior + AppraisalSal.Amount
                                                        else
                                                            if AppraisalSal.Type = AppraisalSal.Type::"Current Bonus" then
                                                                TCurrBonus := TCurrBonus + AppraisalSal.Amount
                                                            else
                                                                if AppraisalSal.Type = AppraisalSal.Type::"Previous Bonus" then
                                                                    TPrevBonus := TPrevBonus + AppraisalSal.Amount;





                    if AppraisalSal.Type = AppraisalSal.Type::Basic then
                        LCheck.Basic := LCheck.Basic + AppraisalSal.Amount
                    else
                        if AppraisalSal.Type = AppraisalSal.Type::"Other Allowances" then
                            LCheck."Other Allowances" := LCheck."Other Allowances" + AppraisalSal.Amount
                        else
                            if AppraisalSal.Type = AppraisalSal.Type::"House Allowance" then
                                LCheck."House Allowance" := LCheck."House Allowance" + AppraisalSal.Amount
                            else
                                if AppraisalSal.Type = AppraisalSal.Type::"Commuter Allowance" then
                                    LCheck."Commuter Allowance" := LCheck."Commuter Allowance" + AppraisalSal.Amount
                                else
                                    if AppraisalSal.Type = AppraisalSal.Type::"Bosa Deductions" then
                                        LCheck."Sacco Bosa Deductions" := LCheck."Sacco Bosa Deductions" + AppraisalSal.Amount


                until AppraisalSal.Next = 0;
            end;
            TCurrBonus -= TDeductions;

            //MESSAGE('%1',TBasic);

            Appraisal."Average Income" := TBasic;

            if LoanType."Appraisal Parameter Type" = LoanType."appraisal parameter type"::Bonus then begin
                if LoanType."Appraised on Expected Bonus" then begin
                    Appraisal."Average Income" := TCurrBonus;
                    Appraisal."Outstanding Tea Bills" := 0;
                    LRec.Reset;
                    LRec.SetRange("Member No.", Loans."Member No.");
                    LRec.SetFilter("Outstanding Principal", '>0');
                    //LRec.SETFILTER("Outstanding Bills",'>0');
                    if LRec.Find('-') then begin
                        repeat
                            LProduct.Get(LRec."Loan Product Type");
                            if LProduct."Repay Mode" = LProduct."repay mode"::Tea then begin
                                //LRec.CALCFIELDS("Outstanding Bills","Outstanding Interest");
                                //Appraisal."Outstanding Tea Bills"+=("Outstanding Bills"+"Outstanding Interest");
                            end;
                            if LRec."Loan Product Type" = 'MSINGI' then begin
                                if LRec."Loan Principle Repayment" = 0 then
                                    LRec."Loan Principle Repayment" := ROUND(LRec."Approved Amount" / LRec.Installments, 0.01, '>');
                                Appraisal."Outstanding Tea Bills" += LRec."Loan Principle Repayment";
                            end;
                        until LRec.Next = 0;
                    end;
                    Appraisal."Outstanding Tea Bills" += Loans."Loan Principle Repayment";
                end
                else
                    Appraisal."Average Income" := TPrevBonus;
            end;


            if LoanType."Appraisal Parameter Type" = LoanType."appraisal parameter type"::Junior then begin
                Appraisal."Average Income" := TJunior;
            end;

            Appraisal.Earnings := TEarning;
            Appraisal.Allowances := TAllowance;
            Appraisal.Deductions := TDeductions;
            Appraisal."Basic Pay" := TBasic;
            Appraisal."Gross Pay" := TGross;
            //Appraisal."Net Salary" :=  Appraisal."Average Income" + Appraisal.Earnings + Appraisal.Allowances - Appraisal.Deductions - Appraisal."STO Deduction";
            //Appraisal."2/3 of Average Income" := ROUND(2 / 3 * Appraisal."Net Salary");
            Appraisal."Net Salary" := Appraisal."Net Pay" + Appraisal.Earnings + Appraisal.Allowances - Appraisal.Deductions - Appraisal."STO Deduction" - Appraisal."Monthly Expenditure";
            Appraisal."1/3 of Average Income" := ROUND(1 / 3 * Appraisal."Gross Pay");
            Appraisal."2/3 of Gross" := ROUND(2 / 3 * Appraisal."Gross Pay");
            Appraisal."1/3 of Gross" := ROUND(1 / 3 * Appraisal."Gross Pay");
            Appraisal."2/3 of Average Income" := ROUND(Appraisal."2/3 of Gross") - Appraisal.Deductions - Appraisal."STO Deduction";
            //MESSAGE('Appraisal."2/3 of Average Income" %1 (Appraisal."Net Salary" %2);',Appraisal."2/3 of Average Income",Appraisal."Net Salary");


            Appraisal."Adjusted Net" := Appraisal."Net Salary" + Appraisal."External Effects";

            Appraisal."Current Loan Repayment" := Loans.Repayment;

            Appraisal."Current Loans Repayments" += Appraisal."Current Loan Repayment";

            Loans.validate("Approved Amount");
            Loans.CalcFields("Loan Charges", "TopUp Commission");

            Appraisal."Total Charges" := Loans."Loan Charges" + Loans."TopUp Commission"; //Appraisal."Top Up Commission" + Appraisal."External Commitment Commission";

            //MESSAGE('%1',Appraisal."Total Charges");

            Appraisal."Qualification as Per Guarantor" := Appraisal."Amount Guaranteed";

            PVA := Loans.Installments;


            if Loans."Annual Interest %" = 0 then begin
                PVA := (Loans.Installments * 100) / ((Loans.Installments * 12 / 12) + 100);
            end
            else begin
                if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then
                    PVA := ((1 - Power((1 + (Loans."Annual Interest %" / 1200)), -Loans.Installments)) / (Loans."Annual Interest %" / 1200))
                else
                    PVA := (Loans.Installments * 100) / ((Loans.Installments * (Loans."Annual Interest %" / 12)) + 100);
            end;


            RecomAppraisal := 0;
            PrincIntQual := ROUND((Appraisal."2/3 of Average Income" - Appraisal."Exisiting Loan Repayment") * PVA, 1, '<');
            //RecomAppraisal :=GetAppraisalFee(PrincIntQual);

            Appraisal."Qualification as Per Income" := ROUND((Appraisal."Net Pay" - Appraisal."Monthly Expenditure"), 1, '<');



            Appraisal."Qualification As Per Deposits" := Appraisal."Maximum Credit";
            ProductCharge := 0;
            Duty := 0;

            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
            //PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
            PCharges.SetRange("Posting Type", PCharges."Posting Type"::"Deduct From Net Payable");
            if PCharges.Find('-') then begin
                repeat
                    PChAmt := 0;
                    GL := '';
                    EDuty := 0;
                    GetLoanChargeAmount(Loans."Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", Loans."Approved Amount", PChAmt, EDuty, GL);
                    ProductCharge += PChAmt;
                    Duty += EDuty;
                until
            PCharges.Next = 0;

            end;


            Appraisal."New Total Repayment" := 0;
            LRec.Reset;
            LRec.SetRange("Member No.", Loans."Member No.");
            LRec.SetFilter("Outstanding Principal", '>0');
            if LRec.FindFirst then begin
                repeat
                    TopUp.Reset;
                    TopUp.SetRange("Loan No.", Loans."Loan No.");
                    TopUp.SetRange("Member No.", Loans."Member No.");
                    TopUp.SetRange("Loan Top Up", LRec."Loan No.");
                    if not TopUp.Find('-') then begin
                        LRec.CalcFields("Outstanding Appraisal", "Outstanding Penalty", "Outstanding Interest", "Outstanding Principal");
                        if LRec."Outstanding Principal" < 0 then
                            LRec."Outstanding Principal" := 0;
                        if LRec."Outstanding Appraisal" < 0 then
                            LRec."Outstanding Appraisal" := 0;

                        if LRec."Outstanding Appraisal" > 0 then
                            if LRec."Outstanding Appraisal" > LRec."Appraisal Fee" then
                                LRec."Outstanding Appraisal" := LRec."Appraisal Fee";

                        Appraisal."New Total Repayment" += (LRec."Outstanding Appraisal" +
                                  LRec."Outstanding Principal" +
                                  LRec."Outstanding Interest" +
                                  LRec."Outstanding Penalty");

                    end;
                until LRec.Next = 0;
            end;
            Appraisal."New Total Repayment" += Loans.Repayment;



            Appraisal."Recommended Amount" := Appraisal."Requested Amount";


            if LoanType."Appraise Salary" then begin
                if Appraisal."Recommended Amount" > Appraisal."Qualification as Per Income" then
                    Appraisal."Recommended Amount" := Appraisal."Qualification as Per Income";
            end;


            if LoanType."Appraise Deposits" then begin
                if Appraisal."Qualification As Per Deposits" < 0 then
                    Appraisal."Qualification As Per Deposits" := 0;

                if LoanType."Deposit Multiplier" > 0 then begin
                    if Appraisal."Recommended Amount" > Appraisal."Qualification As Per Deposits" then
                        Appraisal."Recommended Amount" := Appraisal."Qualification As Per Deposits";
                end;
            end;

            if LoanType."Appraise Security" then begin
                if (LoanType."Minimum Guarantors" > 0) and (LoanType."Guarantorship Type" = LoanType."guarantorship type"::Amount) then begin
                    if Appraisal."Recommended Amount" > Appraisal."Qualification as Per Guarantor" then
                        Appraisal."Recommended Amount" := Appraisal."Qualification as Per Guarantor";
                end;
            end;


            Appraisal."External Commitment" := 0;
            OtherClearance.Reset();
            OtherClearance.SetRange("Loan Application No.", Loans."Loan No.");
            if OtherClearance.FindFirst() then begin
                repeat
                    Appraisal."External Commitment" += OtherClearance.Amount;
                    Appraisal."Other Clearance Desc." := OtherClearance.Description;
                until OtherClearance.Next() = 0;
            end;



            Appraisal."Excise Duty" := Duty;
            Appraisal."Net Take Home" := Appraisal."Approved Amount" -
            (Appraisal."Registration Fee" + Appraisal."Total Financing" + Appraisal."Principle Top Up" + Appraisal."Interest Top Up" + Appraisal."Top Up Appraisal" + Appraisal."Top Up Penalty"
            + Appraisal."External Commitment" + Appraisal."Total Charges" + Appraisal."Deposit Financing" + Appraisal."Share Financing" + Appraisal."Boosting Commission" /*+ Appraisal."Top Up Commission" + Duty*/);

            //MESSAGE('Appraisal."Approved Amount": %1 \Appraisal."Total Financing": %2 \Appraisal."Principle Top Up": %3 \Appraisal."Interest Top Up"  %4\ Appraisal."Total Charges": %5 \Duty: %6);',
            //      Appraisal."Approved Amount",Appraisal."Total Financing",Appraisal."Principle Top Up",Appraisal."Interest Top Up",Appraisal."Total Charges",Duty);

            //Appraisal."Total Charges"+=OtherCharges;
            Appraisal."Total Charges" := Loans."Loan Charges" + Loans."TopUp Commission"; //ProductCharge;

            Appraisal."Total Financing" := Appraisal."Principle Top Up" + Appraisal."Interest Top Up" + Appraisal."Top Up Appraisal" + Appraisal."Top Up Penalty";// + Appraisal."Top Up Commission";

            Loans."Recommended Amount" := Appraisal."Recommended Amount";

            Loans.Validate("Approved Amount", Loans."Recommended Amount");
            Loans.validate("Net To Be Disbursed", Appraisal."Net Take Home");

            if Loans."Appraised By" = '' then begin
                Loans."Appraised By" := UserId;
                Loans."Appraised On" := CurrentDateTime;
            end;

            Loans.Modify;
            Appraisal.Insert;
            Commit();

        end;
    end;


    procedure GetAccountBalance(AcctNo: Code[20]): Decimal
    var
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Setup";
        Bal: Decimal;
        Members: Record Members;
        Emp: Record Customer;
    begin

        Bal := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", AcctNo);
        if SavingsAccounts.Find('-') then begin


            if ProductFactory.Get(SavingsAccounts."Product Type") then
                MinBal := ProductFactory."Minimum Account Balance";

            Members.Get(SavingsAccounts."Member No.");
            if Emp.Get(Members."Employer Code") then
                if Emp."Dont Charge Transactions" then
                    MinBal := 0;


            SavingsAccounts.CalcFields("Balance (LCY)", "Uncleared Cheques", "Authorised Over Draft", "Lien Placed", "Mobile Withdrawals"/*,"ATM Transactions","Lien Guaranteed"*/);
            SavingsAccounts.CalcFields("Share Trading Buffer", "OLD ATM Balance", "Old Uncleared Cheques", "Loan Lien", "Virtual Balance (LCY)");
            Bal := SavingsAccounts."Balance (LCY)" + SavingsAccounts."Authorised Over Draft" + SavingsAccounts."Virtual Balance (LCY)"
                  - SavingsAccounts."Mobile Withdrawals"
                  - SavingsAccounts."Uncleared Cheques"
                  - SavingsAccounts."Lien Placed"
                  - SavingsAccounts."Loan Lien"
                  - SavingsAccounts."Old Uncleared Cheques"
                  - SavingsAccounts."OLD ATM Balance"
                  - SavingsAccounts."Share Trading Buffer"
                  - MinBal;


            /*
            Bal:=(SavingsAccounts."Balance (LCY)"{+SavingsAccounts."Authorised Over Draft"})-
                  SavingsAccounts."Yetu ATM Transactions"-ProductFactory."Minimum Balance"-SavingsAccounts."Uncleared Cheques"-
                  SavingsAccounts."Lien Placed"-SavingsAccounts."ATM Transactions"-SavingsAccounts."Lien Guaranteed";
                  */

        end;
        exit(Bal);

    end;

    procedure GetAccountBalanceWithoutFuuza(AcctNo: Code[20]): Decimal
    var
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Setup";
        Bal: Decimal;
        Members: Record Members;
        Emp: Record Customer;
    begin

        Bal := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", AcctNo);
        if SavingsAccounts.Find('-') then begin


            if ProductFactory.Get(SavingsAccounts."Product Type") then
                MinBal := ProductFactory."Minimum Account Balance";

            Members.Get(SavingsAccounts."Member No.");
            if Emp.Get(Members."Employer Code") then
                if Emp."Dont Charge Transactions" then
                    MinBal := 0;


            SavingsAccounts.CalcFields("Balance (LCY)", "Uncleared Cheques", "Authorised Over Draft", "Lien Placed", "Mobile Withdrawals"/*,"ATM Transactions","Lien Guaranteed"*/);
            SavingsAccounts.CalcFields("Share Trading Buffer", "OLD ATM Balance", "Old Uncleared Cheques", "Loan Lien");
            Bal := SavingsAccounts."Balance (LCY)" + SavingsAccounts."Authorised Over Draft"
                  - SavingsAccounts."Mobile Withdrawals"
                  - SavingsAccounts."Share Trading Buffer"
                  - SavingsAccounts."Uncleared Cheques"
                  - SavingsAccounts."Lien Placed"
                  - SavingsAccounts."Loan Lien"
                  - SavingsAccounts."Old Uncleared Cheques"
                  - SavingsAccounts."OLD ATM Balance"
                  - MinBal;


            /*
            Bal:=(SavingsAccounts."Balance (LCY)"{+SavingsAccounts."Authorised Over Draft"})-
                  SavingsAccounts."Yetu ATM Transactions"-ProductFactory."Minimum Balance"-SavingsAccounts."Uncleared Cheques"-
                  SavingsAccounts."Lien Placed"-SavingsAccounts."ATM Transactions"-SavingsAccounts."Lien Guaranteed";
                  */

        end;
        exit(Bal);

    end;

    procedure GetAccountBalanceAsAt(AcctNo: Code[20]; AsAt: Date): Decimal
    var
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Setup";
        Bal: Decimal;
        Members: Record Members;
        Emp: Record Customer;
    begin

        Bal := 0;
        SavingsAccounts.Reset();
        SavingsAccounts.SetRange("No.", AcctNo);
        SavingsAccounts.SetFilter("Date Filter", '..%1', AsAt);
        if SavingsAccounts.Find('-') then begin
            Bal := 0;

            if ProductFactory.Get(SavingsAccounts."Product Type") then
                MinBal := ProductFactory."Minimum Account Balance";

            Members.Get(SavingsAccounts."Member No.");
            if Emp.Get(Members."Employer Code") then
                if Emp."Dont Charge Transactions" then
                    MinBal := 0;


            SavingsAccounts.CalcFields("New Balance (LCY)", "Uncleared Cheques", "Authorised Over Draft", "Lien Placed", "Mobile Withdrawals"/*,"ATM Transactions","Lien Guaranteed"*/);
            SavingsAccounts.CalcFields("Share Trading Buffer", "OLD ATM Balance", "Old Uncleared Cheques", "Loan Lien");
            Bal := SavingsAccounts."New Balance (LCY)" + SavingsAccounts."Authorised Over Draft"
                  - SavingsAccounts."Mobile Withdrawals"
                  - SavingsAccounts."Uncleared Cheques"
                  - SavingsAccounts."Share Trading Buffer"
                  - SavingsAccounts."Lien Placed"
                  - SavingsAccounts."Loan Lien"
                  - SavingsAccounts."Old Uncleared Cheques"
                  - SavingsAccounts."OLD ATM Balance"
                  - MinBal;


            /*
            Bal:=(SavingsAccounts."Balance (LCY)"{+SavingsAccounts."Authorised Over Draft"})-
                  SavingsAccounts."Yetu ATM Transactions"-ProductFactory."Minimum Balance"-SavingsAccounts."Uncleared Cheques"-
                  SavingsAccounts."Lien Placed"-SavingsAccounts."ATM Transactions"-SavingsAccounts."Lien Guaranteed";
                  */

            if Bal = 0 then begin
                // Bal := GetOpeningBal(AcctNo);
            end;

        end;
        exit(Bal);

    end;

    procedure GetOpeningBal(AccNo: code[50]): Decimal
    var
        SavAcc: Record "Savings Ledger Entry";
    begin
        SavAcc.Reset();
        SavAcc.SetRange("Account No.", AccNo);
        if SavAcc.FindFirst() then begin
            exit(SavAcc.Amount * -1);
        end

    end;


    procedure GetAccountBalanceWithoutMinAccBalance(AcctNo: Code[20]): Decimal
    var
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Setup";
        Bal: Decimal;
        Members: Record Members;
        Emp: Record Customer;
    begin

        Bal := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", AcctNo);
        if SavingsAccounts.Find('-') then begin


            if ProductFactory.Get(SavingsAccounts."Product Type") then;


            MinBal := 0;


            Members.Get(SavingsAccounts."Member No.");
            if Emp.Get(Members."Employer Code") then
                if Emp."Dont Charge Transactions" then
                    MinBal := 0;


            SavingsAccounts.CalcFields("Balance (LCY)", "Share Trading Buffer", "Uncleared Cheques", "Authorised Over Draft", "Lien Placed", "Mobile Withdrawals"/*,"ATM Transactions","Lien Guaranteed"*/);

            Bal := SavingsAccounts."Balance (LCY)" + SavingsAccounts."Authorised Over Draft"
                  - SavingsAccounts."Mobile Withdrawals"
                  - SavingsAccounts."Uncleared Cheques"
                  - SavingsAccounts."Share Trading Buffer"
                  - SavingsAccounts."Lien Placed"
                  - MinBal;


            /*
            Bal:=(SavingsAccounts."Balance (LCY)"{+SavingsAccounts."Authorised Over Draft"})-
                  SavingsAccounts."Yetu ATM Transactions"-ProductFactory."Minimum Balance"-SavingsAccounts."Uncleared Cheques"-
                  SavingsAccounts."Lien Placed"-SavingsAccounts."ATM Transactions"-SavingsAccounts."Lien Guaranteed";
                  */

        end;
        exit(Bal);

    end;

    procedure GetAccountBookBalance(AcctNo: Code[20]): Decimal
    var
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Setup";
        Bal: Decimal;
        Members: Record Members;
        Emp: Record Customer;
    begin

        Bal := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", AcctNo);
        if SavingsAccounts.Find('-') then begin


            SavingsAccounts.CalcFields("Balance (LCY)");

            Bal := SavingsAccounts."Balance (LCY)";


        end;
        exit(Bal);

    end;

    procedure GetLoanChargeAmount(LoanCode: Code[20]; ChargeCode: Code[20]; ChargeType: Option General,"Top up","External Loan","Deposit Financing","Share Capital","Share Financing","Deposit Financing on Maximum","External Payment to Vendor",Rescheduling; Value: Decimal; var ChargeAmt: Decimal; var Duty: Decimal; var ChargeGL: Code[20])
    var
        PCharges: Record "Loan Product Charges.";
        Amt: Decimal;
        StaggeredLines: Record "Staggered Lines.";
    begin

        GenSetup.Get;
        Duty := 0;
        ChargeAmt := 0;
        ChargeGL := '';

        PCharges.Reset;
        PCharges.SetRange("Product Code", LoanCode);
        PCharges.SetRange("Charge Code", ChargeCode);
        //PCharges.SETRANGE("Charge Type",ChargeType);
        if PCharges.Find('-') then begin

            PCharges.TestField("Account No.");

            ChargeGL := PCharges."Account No.";
            //Message('Percentage: %1\Value %2', PCharges.Percentage, Value);
            if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                Amt := (Value * (PCharges.Percentage / 100))
            else
                if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                    Amt := PCharges."Charge Amount"
                else
                    if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                        PCharges.TestField(PCharges."Staggered Charge Code");

                        StaggeredLines.Reset;
                        StaggeredLines.SetRange(StaggeredLines.Code, PCharges."Staggered Charge Code");
                        if StaggeredLines.Find('-') then begin
                            repeat
                                if (Value >= StaggeredLines."Lower Limit") and (Value <= StaggeredLines."Upper Limit") then begin
                                    if StaggeredLines."Use Percentage" = true then
                                        Amt := Value * StaggeredLines.Percentage * 0.01
                                    else
                                        Amt := StaggeredLines."Charge Amount";
                                end;
                            until StaggeredLines.Next = 0;
                        end;

                    end;

            if PCharges.Minimum > 0 then
                if Amt < PCharges.Minimum then
                    Amt := PCharges.Minimum;
            if PCharges.Maximum > 0 then
                if Amt > PCharges.Maximum then
                    Amt := PCharges.Maximum;

            ChargeAmt := Amt;
            ChargeAmt := SaccoActivities.SmartRound(ChargeAmt);

            if ChargeAmt < 0 then
                ChargeAmt := 0;

            if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                Duty := ChargeAmt * GenSetup."Excise Duty (%)" * 0.01;
                Duty := SaccoActivities.SmartRound(Duty);
            end;

        end
        else
            Error('Charge not Found under this product');
    end;


    procedure Base64Logo() Base64: Text
    var
        CompanyInfo: Record "Company Information";
    begin
        Base64 := '';
        CompanyInfo.Get;

        CompanyInfo.CalcFields(Picture);
    end;


    procedure Base64Header() Base64: Text
    var
        CompanyInfo: Record "Company Information";
    begin
    end;


    procedure Base64Footer() Base64: Text
    var
        CompanyInfo: Record "Company Information";
    begin
        Base64 := '';
    end;

    procedure CreateMemberAccount(AccountApp: Record "Member Accounts Application")
    var
        Member: Record Members;
        ImageData: Record "Junior Images";
        NextOfKin: Record "Next of Kin.";
        NextOfKinApp: Record "Next of Kin.";
        Savings: Record "Savings Accounts";
        ProductSetup: Record "Product Setup";
        Msg: Text;
        SenderName: Text;
        SenderAddress: Text;
        Signatory: Record "Account Signatories.";
        SignatoryApp: Record "Account Signatories.";
        AccountNo: Code[20];
        Nominee: Record Nominee;
        NomineeApp: Record Nominee;
        AccountApplication: Record "Member Accounts Application";

    begin


        Member.Get(AccountApp."Member No.");

        ProductSetup.Get(AccountApp."Product Type");
        AccountNo := CreateSavingsAccount(ProductSetup, Member, AccountApp."Monthly Contribution", false, AccountApp."Repay Mode");




        if AccountNo = '' then
            Error('Account Could not be created. Contact System Admin');

        if ProductSetup."Product Category" = ProductSetup."product category"::"Junior Savings" then begin
            Savings.Get(AccountNo);
            Savings."Child Birth Cet. No." := AccountApp."Child Birth Cet. No.";
            Savings."Child Date Of Birth" := AccountApp."Child Date Of Birth";
            Savings."Child Name" := AccountApp."Child Name";
            Savings.Name := Savings."Child Name";
            Savings.Modify;

            //JuniorAccount 
            AccountApp.CalcFields(Signature, Picture);
            ImageData.Init;
            ImageData."Junior Account No." := AccountNo;
            ImageData."Member No." := Member."No.";
            ImageData.Picture := AccountApp.Picture;
            ImageData.Signature := AccountApp.Signature;
            ImageData.Insert(true);
        end;


        Savings.Get(AccountNo);
        Savings."Signing Instructions" := AccountApp."Signing Instructions";
        Savings."Signing Instructions Narration" := AccountApp."Signing Instruction Narration";
        Savings."Document Ref. No." := AccountApp."No.";
        Savings."Registration Date" := AccountApp."Date of Registration";
        Savings.Modify();



        SignatoryApp.Reset;
        SignatoryApp.SetRange(SignatoryApp.Code, AccountApp."No.");
        if SignatoryApp.Find('-') then begin
            repeat
                Signatory.Init;
                Signatory.Code := AccountNo;
                Signatory.Name := SignatoryApp.Name;
                Signatory."Date Of Birth" := SignatoryApp."Date Of Birth";
                Signatory."Staff/Payroll" := SignatoryApp."Staff/Payroll";
                //Signatory."Salesperson Code":=SignatoryApp."Salesperson Code";
                Signatory."Phone No." := SignatoryApp."Phone No.";
                Signatory.Signatory := SignatoryApp.Signatory;
                Signatory."Must Sign" := SignatoryApp."Must Sign";
                Signatory."Must be Present" := SignatoryApp."Must be Present";
                SignatoryApp.CalcFields(SignatoryApp.Signature, SignatoryApp.Picture);
                Signatory.Picture := SignatoryApp.Picture;
                Signatory.Signature := SignatoryApp.Signature;
                Signatory."Expiry Date" := SignatoryApp."Expiry Date";
                Signatory.Type := SignatoryApp.Type;
                Signatory.Insert;

                if SignatoryApp.Picture.Hasvalue then begin
                    Clear(SignatoryApp.Signature);
                    SignatoryApp.Modify;
                end;

                if SignatoryApp.Signature.Hasvalue then begin
                    Clear(SignatoryApp.Signature);
                    SignatoryApp.Modify;
                end;
            until SignatoryApp.Next = 0;
        end;

        NomineeApp.Reset;
        NomineeApp.SetRange(NomineeApp."No.", AccountApp."No.");
        if NomineeApp.Find('-') then begin
            repeat
                Nominee.Init;
                Nominee."No." := AccountNo;
                Nominee."ID No." := NomineeApp."ID No.";
                Nominee.Name := NomineeApp.Name;
                Nominee.Relationship := NomineeApp.Relationship;
                Nominee.Beneficiary := NomineeApp.Beneficiary;
                Nominee."Date of Birth" := NomineeApp."Date of Birth";
                Nominee."Mobile Phone No." := NomineeApp."Mobile Phone No.";
                Nominee.Email := NomineeApp.Email;
                Nominee."%Allocation" := NomineeApp."%Allocation";
                Nominee.Spouse := NomineeApp.Spouse;
                Nominee.Insert;
            until NomineeApp.Next = 0;
        end;


        AccountApp.Status := AccountApp.Status::Created;
        AccountApp.Modify;
        Commit;

        if ProductSetup."Product Category" = ProductSetup."Product Category"::"Junior Savings" then begin
            SendJuniorAcceptanceLetter(AccountNo);
            if TrySendJuniorAccountSms(AccountNo) then;
        end else if ProductSetup."Product Category" = ProductSetup."Product Category"::"Holiday Savings" then begin
            if TrySendHolidayAccountSms(AccountNo) then;
            if TrySendHolidayAccountEmail(AccountNo) then;
        end else begin
            Msg := 'Dear ' + Member."First Name" + ', Your ' + ProductSetup.Description + ' has been created successfully. Your Account No. is ' + AccountNo;
            SendSms(Source::"New Member", Member."Mobile Phone No.", Msg, Member."No.", '', false, false);
            Commit;
        end;


        /* 
        if SMTPSetup.Get then begin
            SenderAddress := SMTPSetup."User ID";
            SenderName := COMPANYNAME;

            if SaccoActivities.ValidEmailAddress(SenderAddress) then begin

                SMTP.CreateMessage(SenderName, SenderAddress, Member."E-Mail", 'ACCOUNT OPENING: ' + COMPANYNAME, '', true);
                SMTP.AppendBody('Dear ' + Member."First Name");
                SMTP.AppendBody('<br><br>');
                SMTP.AppendBody('A warm welcome and lots of good wishes on opening a new savings product.');
                SMTP.AppendBody('<p>');
                SMTP.AppendBody('Your ' + ProductSetup.Description + ' Account No. is <b>' + AccountNo + '</b>');
                SMTP.AppendBody('<br><br>');
                SMTP.AppendBody('Kind Regards,');
                SMTP.AppendBody('<br>');
                SMTP.AppendBody(COMPANYNAME);
                SMTP.AppendBody('<br><br>');
                SMTP.AppendBody('<hr>');
                if SMTP.TrySend then;
            end;
        end;
 */
        Message('Account Created Successfuly: Account No - %1', AccountNo);
    end;

    [TryFunction]
    local procedure TrySendJuniorAccountSms(AccountNo: Code[20])
    var
        Savings: Record "Savings Accounts";
        ParentMember: Record Members;
        MobileNo: Text[200];
        Msg: Text[250];
    begin
        if AccountNo = '' then
            exit;

        Savings.Get(AccountNo);
        if Savings."Product Category" <> Savings."Product Category"::"Junior Savings" then
            exit;

        ParentMember.Get(Savings."Member No.");
        MobileNo := ParentMember."Mobile Phone No.";
        if MobileNo = '' then
            MobileNo := ParentMember."Phone No.";

        if MobileNo = '' then
            exit;

        Msg := 'Dear ' + ParentMember.Name + ', Thank you for opening a ' + format(Savings."Product Category") + 'account with us! This junior membership account number is ' + Savings."No." +
            '. Kindly take note of this membership number as you will be required to indicate it when making payments to this account. ';
        SendSms(Source::"New Member", MobileNo, Msg, ParentMember."No.", Savings."No.", false, false);
        Commit;
    end;

    [TryFunction]
    local procedure TrySendHolidayAccountSms(AccountNo: Code[20])
    var
        Savings: Record "Savings Accounts";
        Member: Record Members;
        MobileNo: Text[200];
        MemberFirstName: Text;
        Msg: Text[250];
    begin
        if AccountNo = '' then
            exit;

        Savings.Get(AccountNo);
        if Savings."Product Category" <> Savings."Product Category"::"Holiday Savings" then
            exit;

        Member.Get(Savings."Member No.");
        MobileNo := Member."Mobile Phone No.";
        if MobileNo = '' then
            MobileNo := Member."Phone No.";

        if MobileNo = '' then
            exit;

        MemberFirstName := Member."First Name";
        if MemberFirstName = '' then
            MemberFirstName := Member.Name;

        Msg := 'Dear ' + MemberFirstName + ', Thank you for opening a ' + format(Savings."Product Category") + ' account with us! Your Holiday Savings account number is ' + Savings."No." +
            '. Kindly take note of this membership number as you will be required to indicate it when making payments to this account.';
        SendSms(Source::"New Member", MobileNo, Msg, Member."No.", Savings."No.", false, false);
        Commit;
    end;

    [TryFunction]
    local procedure TrySendHolidayAccountEmail(AccountNo: Code[20])
    var
        Savings: Record "Savings Accounts";
        Member: Record Members;
        Email: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        MemberFirstName: Text;
        Subject: Text;
        Body: Text;
    begin
        if AccountNo = '' then
            exit;

        Savings.Get(AccountNo);
        if Savings."Product Category" <> Savings."Product Category"::"Holiday Savings" then
            exit;

        Member.Get(Savings."Member No.");
        if not SaccoActivities.ValidEmailAddress(Member."E-Mail") then
            exit;

        MemberFirstName := Member."First Name";
        if MemberFirstName = '' then
            MemberFirstName := Member.Name;

        Subject := 'Holiday Savings Account Opening';
        Body := 'Dear ' + MemberFirstName + ', Thank you for opening a ' + Format(Savings."Product Category") + ' account with us! Your Holiday Savings account number is ' + Savings."No." +
            '. Kindly take note of this membership number as you will be required to indicate it when making payments to this account.';

        EmailMsg.Create(Member."E-Mail", Subject, Body, false);
        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    end;

    procedure RegistrationEmail()
    var
        EmailLogs: Record "Email Logs Notifications";
        Heading: Text[30];
        Msg: Text[250];
        SalutationTxt: Text[50];
        Receiver: Text[45];
        RegardsTxt: Text[30];
        BodyTxt: Text;
        FullString: Text;
        SaccoSetp: Record "Sacco Setup";
        Member: Record Members;
        CI: Record "Company Information";
    begin
        SaccoSetp.Get();
        CI.Get();

        EmailLogs.Reset();
        EmailLogs.SetRange(Sent, false);
        EmailLogs.SetRange(Source, EmailLogs.Source::Regstration);
        EmailLogs.SetFilter(Status, '<>%1', EmailLogs.Status::Failed);
        if EmailLogs.FindSet() then begin
            repeat

                Member.Reset();
                Member.setrange("No.", EmailLogs."Loan No.");
                if Member.FindFirst() then begin

                    if SaccoActivities.ValidEmailAddress(Member."E-Mail") then begin

                        Receiver := Member."E-Mail";
                        Heading := 'REGISTRATION FOR ' + Format(Member."No.");

                        SalutationTxt := 'Dear' + ' ' + SkyMbanking.FirstName(Member.Name) + ',';

                        RegardsTxt := 'Kind Regards';

                        Msg := STRSUBSTNO('Kindly be advised that your membership application has been successful. Your Membership No. is %1 ', Format(Member."No."));


                        BodyTxt := STRSUBSTNO(
                                        '%1.' + '              ' +
                                        'Here are key details to help you get started:' + '        ' +
                                        'Our registration fee is Ksh %2, and the minimum monthly contribution is Ksh %3.' + '             ' +
                                        'The minimum share capital of Ksh %4 can be paid once or in instalments.' + '      ' +
                                        'For more details on how to remit as well as our Sacco FAQs, please click here: %5/faqs/#collapse-1882.' + '            ' +
                                        'We are committed to supporting your financial journey and are here to assist whenever you need.' + '       ' +
                                        'For any queries, contact us through ' + CI."Phone No." + ' or ' + CI."E-Mail",
                                        Msg,
                                        SaccoSetp."Registration Fee",
                                        SaccoSetp."Min. Contribution [Deposits]" +
                                        SaccoSetp."Min. Contribution [Shares]" +
                                        SaccoSetp."Min. Benevolent Contrib",
                                        SaccoSetp."Minimum Share Capital",
                                        CI."Home Page"
                                    );



                        SendEmailNotification(
                            Heading,
                            SalutationTxt,
                            BodyTxt,
                            RegardsTxt,
                            Receiver,
                            '',
                            ''
                        );

                        EmailLogs.Sent := true;

                    end else begin
                        EmailLogs.Status := EmailLogs.Status::Failed;
                        EmailLogs."Error Msg" := 'Invalid Email Address';
                    end;

                    EmailLogs.Modify;
                    Commit();
                end;

            until emailLogs.next() = 0;
        end;
    end;


    procedure SendEmailCCNotification(Heading: text; SalutationTxt: Text; BodyTxt: text; RegardsTxt: Text; Receiver: List of [Text]; FilePath_Name: Text; CCRecipients: List of [Text]; BCCRecipients: List of [Text]) Sent: Boolean;
    var
        myInt: Integer;
        CompanyInformation: Record "Company Information";
        Cust: Record Members;
        FileManagement: Codeunit "File Management";
        SMTPSetup: Record "Email Account";
        SMTPMail: Codeunit "Email Message";
        SaccoSetup: Record "Sacco Setup";
        BodyMsg: Text;
        Base64: Text;
        EmailSend: Codeunit Email;
        TempBlob: Record CustomTempBlob;
        MActivities: Codeunit "Member Activities";
        j: Integer;
        TempEmailItem: record "Email Item";
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        VarTempBlob: Codeunit "Temp Blob";
        B64: Codeunit Base64;
        EmailMsg: Codeunit "Email Message";
        FileM: File;
        InStr: InStream;
        ToRecipients: List of [Text];
        Email: Codeunit Email;
    begin
        Sent := false;


        /* if FilePath_Name <> '' then begin
            if not FileMgt.ServerFileExists(FilePath_Name) then Error('The file %1 does not exist', FilePath_Name);
            FileMgt.BLOBImportFromServerFile(VarTempBlob, FilePath_Name);
            VarTempBlob.CreateInStream(IStream);
            Base64 := B64.StreamToBase64String(IStream);
        end; */

        BodyMsg := (SalutationTxt);
        BodyMsg += ('<br><br>');
        BodyMsg += (BodyTxt);
        BodyMsg += ('<br><br>');
        BodyMsg += (RegardsTxt);
        BodyMsg += ('<br>');
        BodyMsg += (COMPANYNAME);
        BodyMsg += ('<br><br>');
        BodyMsg += ('<br>');

        SMTPMail.Create(Receiver, Heading, BodyMsg, true, CCRecipients, BCCRecipients);

        /*if FilePath_Name <> '' then begin
            FileM.Open(FilePath_Name);
            FileM.CreateInStream(InStr);
            EmailMsg.Create(Receiver, Heading, BodyMsg, true, CCRecipients, BCCRecipients);
            EmailMsg.AddAttachment(FilePath_Name, 'PDF', InStr);
            if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then;
            FileM.Close();
        end;
        */

        /* if FilePath_Name <> '' then begin
            SMTPMail.AddAttachment(FilePath_Name, 'pdf', Base64);
        end;
 */
        /* if EmailSend.Send(SMTPMail) then
            Sent := true; */


    end;

    procedure SendHREmailCCNotification(Heading: Text; SalutationTxt: Text; BodyTxt: Text; RegardsTxt: Text; Receiver: List of [Text]; FilePath_Name: Text; CCRecipients: List of [Text]; BCCRecipients: List of [Text]) Sent: Boolean
    var
        EmailMsg: Codeunit "Email Message";
        BodyMsg: Text;
    begin
        Sent := false;

        BodyMsg := SalutationTxt;
        BodyMsg += '<br><br>';
        BodyMsg += BodyTxt;
        BodyMsg += '<br><br>';
        BodyMsg += RegardsTxt;
        BodyMsg += '<br>';
        BodyMsg += CompanyName;
        BodyMsg += '<br><br>';
        BodyMsg += '<br>';

        EmailMsg.Create(Receiver, Heading, BodyMsg, true, CCRecipients, BCCRecipients);

        Sent := TrySendHREmail(EmailMsg);
    end;

    [TryFunction]
    local procedure TrySendHREmail(var EmailMsg: Codeunit "Email Message")
    var
        Email: Codeunit Email;
    begin
        Email.Send(EmailMsg, Enum::"Email Scenario"::HR);
    end;


    PROCEDURE SendEmailWithAttachment(
        EmailSubject: Text;
        Salutation: Text;
        MessageBody: Text;
        Regards: Text;
        Recipients: List of [Text];
        AttachmentName: Text;
        AttachmentStream: InStream;
        CCList: List of [Text];
        BCCList: List of [Text]
    )
    VAR
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Recipient: Text;
        CCRecipient: Text;
        BCCRecipient: Text;
        FullMessageBody: Text;
    BEGIN
        // Build the complete email message
        FullMessageBody := Salutation + '<br><br>' + MessageBody + '<br><br>' + Regards;

        // Create email message
        foreach Recipient in Recipients do begin
            if Recipient <> '' then begin
                EmailMessage.Create(Recipient, EmailSubject, FullMessageBody, true);
                break; // Use first recipient as primary recipient
            end;
        end;

        // Add CC recipients
        foreach CCRecipient in CCList do begin
            if CCRecipient <> '' then
                EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, CCRecipient);
        end;

        // Add BCC recipients  
        foreach BCCRecipient in BCCList do begin
            if BCCRecipient <> '' then
                EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Bcc, BCCRecipient);
        end;

        // Add attachment from stream
        EmailMessage.AddAttachment(AttachmentName, 'application/pdf', AttachmentStream);

        // Send the email
        if Email.Send(EmailMessage) then;
    END;

    procedure GetGeneral_SharingChargeAmount(ChargeCode: Code[20]; Value: Decimal; var ChargeAmt: Decimal; var ChargeDuty: Decimal; var ChargeAcctType: Enum "Gen. Journal Account Type"; var ChargeAcct: Code[20]; var SharingAmt: Decimal; var SharingDuty: Decimal; var SharingChargeAcctType: Enum "Gen. Journal Account Type"; var SharingChargeAcct: Code[20])
    var
        ChargesLines: Record "Transaction Charges Lines";
        Amt: Decimal;
        StaggeredLines: Record "Staggered Lines.";
        ChargeAmount: Decimal;
    begin

        GenSetup.Get;
        ChargeAmt := 0;
        ChargeAcct := '';
        ChargeDuty := 0;


        SharingAmt := 0;
        SharingChargeAcct := '';
        SharingDuty := 0;

        ChargesLines.Reset;
        ChargesLines.SetRange("Transaction Type", ChargeCode);
        if ChargesLines.Find('-') then begin
            // repeat


            ChargeAmount := 0;
            if ChargesLines."Charge Type" = ChargesLines."charge type"::"% of Amount" then //modified kelvin
                ChargeAmount := (Value * ChargesLines."Percentage of Amount") * 0.01
            else
                ChargeAmount := ChargesLines."Charge Amount";

            if ChargesLines."Charge Type" = ChargesLines."charge type"::Staggered then begin

                ChargesLines.TestField("Staggered Charge Code");

                StaggeredLines.Reset;
                StaggeredLines.SetRange(Code, ChargesLines."Staggered Charge Code");
                if StaggeredLines.Find('-') then begin
                    repeat
                        if (Value >= StaggeredLines."Lower Limit") and (Value <= StaggeredLines."Upper Limit") then begin
                            if StaggeredLines."Use Percentage" = true then begin
                                ChargeAmount := Value * StaggeredLines.Percentage * 0.01;
                            end
                            else begin
                                ChargeAmount := StaggeredLines."Charge Amount";
                            end;
                        end;
                    until StaggeredLines.Next = 0;
                end;
            end;

            ChargeAmt := ChargeAmount;
            ChargeAcct := ChargesLines."Charge Account";
            ChargeAcctType := ChargesLines."Charge Account Type";

            //MESSAGE('%1\%2',ChargeAmt,Value);

            if ChargesLines."Minimum Amount" > 0 then
                if ChargeAmt < ChargesLines."Minimum Amount" then
                    ChargeAmt := ChargesLines."Minimum Amount";

            if ChargesLines."Maximum Amount" > 0 then
                if ChargeAmt > ChargesLines."Maximum Amount" then
                    ChargeAmt := ChargesLines."Maximum Amount";


            if ChargeAmt > 0 then
                ChargesLines.TestField("Charge Account");

            if ChargesLines."Sharing Value" > 0 then begin

                SharingChargeAcctType := ChargesLines."Sharing Account Type";
                SharingChargeAcct := ChargesLines."Sharing Account No.";

                if ChargesLines."Sharing Use Percentage" then
                    SharingAmt := ChargesLines."Sharing Value" / 100 * ChargeAmount
                else
                    SharingAmt := ChargesLines."Sharing Value";

                if ChargesLines."Sharing Excise Duty" then begin
                    if ChargesLines."Sharing Excise Duty %" > 0 then
                        SharingDuty := (SharingAmt * ChargesLines."Sharing Excise Duty %" * 0.01)
                    else
                        SharingDuty := (SharingAmt * GenSetup."Excise Duty (%)" * 0.01);
                end;

                SharingAmt += SharingDuty;

                if ChargeAmt < SharingAmt then
                    Error('Sharing Charge Cannot be Greater than Charge Amount in Transaction Charge: %1', ChargesLines."Transaction Type")
                else begin
                    ChargeAmt -= SharingAmt;

                end;

            end;

            if ChargesLines."Charge Excise Duty" then begin

                if ChargesLines."Excise Duty %" > 0 then
                    ChargeDuty := ChargeAmt * ChargesLines."Excise Duty %" * 0.01
                else
                    ChargeDuty := ChargeAmt * GenSetup."Excise Duty (%)" * 0.01;
            end;

            //until ChargesLines.Next() = 0;
        end;
    end;




    procedure GetGeneral_SharingChargeAmountBankers(ChargeCode: Code[20]; Value: Decimal; var ChargeAmt: Decimal; var ChargeDuty: Decimal; var ChargeAcctType: Enum "Gen. Journal Account Type"; var ChargeAcct: Code[20]; var SharingAmt: Decimal; var SharingDuty: Decimal; var SharingChargeAcctType: Enum "Gen. Journal Account Type"; var SharingChargeAcct: Code[20])
    var
        ChargesLines: Record "Transaction Charges Lines";
        Amt: Decimal;
        StaggeredLines: Record "Staggered Lines.";
        ChargeAmount: Decimal;
    begin

        GenSetup.Get;
        ChargeAmt := 0;
        ChargeAcct := '';
        ChargeDuty := 0;


        SharingAmt := 0;
        SharingChargeAcct := '';
        SharingDuty := 0;

        ChargesLines.Reset;
        ChargesLines.SetRange("Transaction Type", ChargeCode);
        if ChargesLines.Find('-') then begin
            // repeat


            ChargeAmount := 0;
            if ChargesLines."Charge Type" = ChargesLines."charge type"::"% of Amount" then //modified kelvin
                ChargeAmount := (Value * ChargesLines."Percentage of Amount") * 0.01
            else
                ChargeAmount := ChargesLines."Charge Amount";

            if ChargesLines."Charge Type" = ChargesLines."charge type"::Staggered then begin

                ChargesLines.TestField("Staggered Charge Code");

                StaggeredLines.Reset;
                StaggeredLines.SetRange(Code, ChargesLines."Staggered Charge Code");
                if StaggeredLines.Find('-') then begin
                    repeat
                        if (Value >= StaggeredLines."Lower Limit") and (Value <= StaggeredLines."Upper Limit") then begin
                            if StaggeredLines."Use Percentage" = true then begin
                                ChargeAmount := Value * StaggeredLines.Percentage * 0.01;
                            end
                            else begin
                                ChargeAmount := StaggeredLines."Charge Amount";
                            end;
                        end;
                    until StaggeredLines.Next = 0;
                end;
            end;

            ChargeAmt := ChargeAmount;
            ChargeAcct := ChargesLines."Charge Account";
            ChargeAcctType := ChargesLines."Charge Account Type";

            //MESSAGE('%1\%2',ChargeAmt,Value);

            if ChargesLines."Minimum Amount" > 0 then
                if ChargeAmt < ChargesLines."Minimum Amount" then
                    ChargeAmt := ChargesLines."Minimum Amount";

            if ChargesLines."Maximum Amount" > 0 then
                if ChargeAmt > ChargesLines."Maximum Amount" then
                    ChargeAmt := ChargesLines."Maximum Amount";


            if ChargeAmt > 0 then
                ChargesLines.TestField("Charge Account");

            if ChargesLines."Sharing Value" > 0 then begin

                SharingChargeAcctType := ChargesLines."Sharing Account Type";
                SharingChargeAcct := ChargesLines."Sharing Account No.";

                if ChargesLines."Sharing Use Percentage" then
                    SharingAmt := ChargesLines."Sharing Value" / 100 * ChargeAmount
                else
                    SharingAmt := ChargesLines."Sharing Value";

                if ChargesLines."Sharing Excise Duty" then begin
                    if ChargesLines."Sharing Excise Duty %" > 0 then
                        SharingDuty := (SharingAmt * ChargesLines."Sharing Excise Duty %" * 0.01)
                    else
                        SharingDuty := (SharingAmt * GenSetup."Excise Duty (%)" * 0.01);
                end;

                SharingAmt += SharingDuty;

                if ChargeAmt < SharingAmt then
                    Error('Sharing Charge Cannot be Greater than Charge Amount in Transaction Charge: %1', ChargesLines."Transaction Type")
                else begin
                    ChargeAmt -= SharingAmt;

                end;

            end;

            if ChargesLines."Charge Excise Duty" then begin

                if ChargesLines."Excise Duty %" > 0 then begin
                    ChargeDuty := (ChargeAmt * ChargesLines."Excise Duty %") / (ChargesLines."Excise Duty %" + 100);
                    ChargeAmt -= ChargeDuty;
                end
                else
                    ChargeDuty := ChargeAmt * GenSetup."Excise Duty (%)" * 0.01;
            end;

            ChargeAmt += 10;

            //until ChargesLines.Next() = 0;
        end;
    end;



    procedure FirstName(FullName: Text[100]) FName: Text[100]
    var
        Pos: Integer;
        Separator: Text[1];
    begin
        FName := FullName;

        Pos := StrPos(FullName, ' ');

        if Pos > 0 then begin
            FName := CopyStr(FullName, 1, Pos - 1);
        end;
    end;

    procedure GetGeneralCumulativeChargeAmount(ChargeCode: Code[20]; Value: Decimal; var ChargeAmt: Decimal; var ChargeDuty: Decimal; var ChargeAcctType: Enum "Gen. Journal Account Type"; var ChargeAcct: Code[20])
    var
        ChargesLines: Record "Transaction Charges Lines";
        Amt: Decimal;
        StaggeredLines: Record "Staggered Lines.";
        ChargeAmount: Decimal;
    begin

        GenSetup.Get;
        ChargeAmt := 0;
        ChargeAcct := '';
        ChargeDuty := 0;

        Message(ChargeCode);
        ChargeAmount := 0;
        ChargesLines.Reset;
        ChargesLines.SetRange("Transaction Type", ChargeCode);
        if ChargesLines.Find('-') then begin


            repeat

                ChargeAmount := 0;

                if ChargesLines."Charge Type" = ChargesLines."charge type"::"% of Amount" = true then
                    ChargeAmount := (Value * ChargesLines."Percentage of Amount") * 0.01
                else
                    ChargeAmount := ChargesLines."Charge Amount";

                if ChargesLines."Charge Type" = ChargesLines."charge type"::Staggered then begin

                    ChargesLines.TestField("Staggered Charge Code");

                    StaggeredLines.Reset;
                    StaggeredLines.SetRange(Code, ChargesLines."Staggered Charge Code");
                    if StaggeredLines.Find('-') then begin
                        repeat
                            if (Value >= StaggeredLines."Lower Limit") then begin
                                if StaggeredLines."Use Percentage" = true then begin
                                    ChargeAmount := Value * StaggeredLines.Percentage * 0.01;
                                end
                                else begin
                                    ChargeAmount := StaggeredLines."Charge Amount";
                                end;
                            end;
                        until StaggeredLines.Next = 0;
                    end;
                end;



                if ChargesLines."Minimum Amount" > 0 then
                    if ChargeAmount < ChargesLines."Minimum Amount" then
                        ChargeAmount := ChargesLines."Minimum Amount";

                if ChargesLines."Maximum Amount" > 0 then
                    if ChargeAmount > ChargesLines."Maximum Amount" then
                        ChargeAmount := ChargesLines."Maximum Amount";



                if ChargesLines."Charge Excise Duty" then
                    ChargeDuty += ChargeDuty + (ChargeAmount * GenSetup."Excise Duty (%)" * 0.01);



                //Message('%1', ChargeAmount);

                ChargeAmt += ChargeAmount;
                ChargeAcct := ChargesLines."Charge Account";
                ChargeAcctType := ChargesLines."Charge Account Type";

                //Message('Sum: %1', ChargeAmount);



                if ChargeAmt > 0 then
                    ChargesLines.TestField("Charge Account");


            until ChargesLines.Next() = 0;
        end;
    end;

    procedure GetGeneralChargeAmount(ChargeCode: Code[20]; Value: Decimal; var ChargeAmt: Decimal; var ChargeDuty: Decimal; var ChargeAcctType: Enum "Gen. Journal Account Type"; var ChargeAcct: Code[20])
    var
        ChargesLines: Record "Transaction Charges Lines";
        Amt: Decimal;
        StaggeredLines: Record "Staggered Lines.";
        ChargeAmount: Decimal;
    begin

        GenSetup.Get;
        ChargeAmt := 0;
        ChargeAcct := '';
        ChargeDuty := 0;


        ChargesLines.Reset;
        ChargesLines.SetRange("Transaction Type", ChargeCode);
        ChargesLines.SetFilter(Description, '<>%1', '');
        if ChargesLines.Find('-') then begin



            ChargeAmount := 0;
            if ChargesLines."Charge Type" = ChargesLines."charge type"::"% of Amount" = true then
                ChargeAmount := (Value * ChargesLines."Percentage of Amount") * 0.01
            else
                ChargeAmount := ChargesLines."Charge Amount";

            if ChargesLines."Charge Type" = ChargesLines."charge type"::Staggered then begin

                ChargesLines.TestField("Staggered Charge Code");

                StaggeredLines.Reset;
                StaggeredLines.SetRange(Code, ChargesLines."Staggered Charge Code");
                if StaggeredLines.Find('-') then begin
                    repeat
                        if (Value >= StaggeredLines."Lower Limit") and (Value <= StaggeredLines."Upper Limit") then begin
                            if StaggeredLines."Use Percentage" = true then begin
                                ChargeAmount := Value * StaggeredLines.Percentage * 0.01;
                            end
                            else begin
                                ChargeAmount := StaggeredLines."Charge Amount";
                            end;
                        end;
                    until StaggeredLines.Next = 0;
                end;
            end;

            ChargeAmt := ChargeAmount;
            ChargeAcct := ChargesLines."Charge Account";
            ChargeAcctType := ChargesLines."Charge Account Type";


            if ChargesLines."Minimum Amount" > 0 then
                if ChargeAmt < ChargesLines."Minimum Amount" then
                    ChargeAmt := ChargesLines."Minimum Amount";

            if ChargesLines."Maximum Amount" > 0 then
                if ChargeAmt > ChargesLines."Maximum Amount" then
                    ChargeAmt := ChargesLines."Maximum Amount";


            if ChargeAmt > 0 then
                ChargesLines.TestField("Charge Account");

            if ChargesLines."Charge Excise Duty" then
                if ChargesLines."Excise Duty %" > 0 then
                    ChargeDuty := ChargeAmt * ChargesLines."Excise Duty %" * 0.01
                else
                    ChargeDuty := ChargeAmt * GenSetup."Excise Duty (%)" * 0.01;


        end;
    end;

    procedure GetLineChargeAmount(ChargeCode: Code[20]; Value: Decimal; var ChargeAmt: Decimal; var ChargeDuty: Decimal; var ChargeAcctType: Enum "Gen. Journal Account Type"; var ChargeAcct: Code[20]; Description: Text)
    var
        Amt: Decimal;
        StaggeredLines: Record "Staggered Lines.";
        ChargeAmount: Decimal;
        ChargesLines: Record "Transaction Charges Lines";
    begin

        GenSetup.Get;
        ChargeAmt := 0;
        ChargeAcct := '';
        ChargeDuty := 0;

        ChargesLines.Reset();
        ChargesLines.SetRange("Transaction Type", ChargeCode);
        ChargesLines.SetRange(Description, Description);
        if ChargesLines.Find('-') then begin



            ChargeAmount := 0;
            if ChargesLines."Charge Type" = ChargesLines."charge type"::"% of Amount" = true then
                ChargeAmount := (Value * ChargesLines."Percentage of Amount") * 0.01
            else
                ChargeAmount := ChargesLines."Charge Amount";

            if ChargesLines."Charge Type" = ChargesLines."charge type"::Staggered then begin

                ChargesLines.TestField("Staggered Charge Code");

                StaggeredLines.Reset;
                StaggeredLines.SetRange(Code, ChargesLines."Staggered Charge Code");
                if StaggeredLines.Find('-') then begin
                    repeat
                        if (Value >= StaggeredLines."Lower Limit") and (Value <= StaggeredLines."Upper Limit") then begin
                            if StaggeredLines."Use Percentage" = true then begin
                                ChargeAmount := Value * StaggeredLines.Percentage * 0.01;
                            end
                            else begin
                                ChargeAmount := StaggeredLines."Charge Amount";
                            end;
                        end;
                    until StaggeredLines.Next = 0;
                end;
            end;

            ChargeAmt := ChargeAmount;
            ChargeAcct := ChargesLines."Charge Account";
            ChargeAcctType := ChargesLines."Charge Account Type";


            if ChargesLines."Minimum Amount" > 0 then
                if ChargeAmt < ChargesLines."Minimum Amount" then
                    ChargeAmt := ChargesLines."Minimum Amount";

            if ChargesLines."Maximum Amount" > 0 then
                if ChargeAmt > ChargesLines."Maximum Amount" then
                    ChargeAmt := ChargesLines."Maximum Amount";


            if ChargeAmt > 0 then
                ChargesLines.TestField("Charge Account");

            if ChargesLines."Charge Excise Duty" then begin

                if ChargesLines."Excise Duty %" > 0 then
                    ChargeDuty := ChargeAmt * ChargesLines."Excise Duty %" * 0.01
                else
                    ChargeDuty := ChargeAmt * GenSetup."Excise Duty (%)" * 0.01;

            end;


        end;
    end;


    procedure GetGeneralChargeAmountOnly(ChargeCode: Code[20]; Value: Decimal; var ChargeAmt: Decimal; var ChargeDuty: Decimal; var ChargeAcctType: Enum "Gen. Journal Account Type"; var ChargeAcct: Code[20])
    var
        ChargesLines: Record "Transaction Charges Lines";
        Amt: Decimal;
        StaggeredLines: Record "Staggered Lines.";
        ChargeAmount: Decimal;
    begin

        GenSetup.Get;
        ChargeAmt := 0;
        ChargeAcct := '';
        ChargeDuty := 0;


        ChargesLines.Reset;
        ChargesLines.SetRange("Transaction Type", ChargeCode);
        if ChargesLines.Find('-') then begin

            ChargeAmount := 0;
            if ChargesLines."Charge Type" = ChargesLines."charge type"::"% of Amount" = true then
                ChargeAmount := (Value * ChargesLines."Percentage of Amount") * 0.01
            else
                ChargeAmount := ChargesLines."Charge Amount";

            if ChargesLines."Charge Type" = ChargesLines."charge type"::Staggered then begin

                ChargesLines.TestField("Staggered Charge Code");

                StaggeredLines.Reset;
                StaggeredLines.SetRange(Code, ChargesLines."Staggered Charge Code");
                if StaggeredLines.Find('-') then begin
                    repeat
                        if (Value >= StaggeredLines."Lower Limit") and (Value <= StaggeredLines."Upper Limit") then begin
                            if StaggeredLines."Use Percentage" = true then begin
                                ChargeAmount := Value * StaggeredLines.Percentage * 0.01;
                            end
                            else begin
                                ChargeAmount := StaggeredLines."Charge Amount";
                            end;
                        end;
                    until StaggeredLines.Next = 0;
                end;
            end;

            ChargeAmt := ChargeAmount;
            ChargeAcct := ChargesLines."Charge Account";
            ChargeAcctType := ChargesLines."Charge Account Type";


            if ChargesLines."Minimum Amount" > 0 then
                if ChargeAmt < ChargesLines."Minimum Amount" then
                    ChargeAmt := ChargesLines."Minimum Amount";

            if ChargesLines."Maximum Amount" > 0 then
                if ChargeAmt > ChargesLines."Maximum Amount" then
                    ChargeAmt := ChargesLines."Maximum Amount";


            //if ChargeAmt > 0 then
            //  ChargesLines.TestField("Charge Account");

            if ChargesLines."Charge Excise Duty" then begin

                if ChargesLines."Excise Duty %" > 0 then
                    ChargeDuty := ChargeAmt * ChargesLines."Excise Duty %" * 0.01
                else
                    ChargeDuty := ChargeAmt * GenSetup."Excise Duty (%)" * 0.01;

            end;


        end;
    end;

    procedure IsDefaulter(MemberNo: Code[20]): Boolean
    var
        Loans: Record Loans;
    begin

        Loans.Reset;
        Loans.SetRange("Member No.", MemberNo);
        Loans.SetFilter("Outstanding Principal", '>0');
        Loans.SetFilter("Loans Category-SACCO", '<>%1&<>%2', Loans."Loans Category-SACCO"::Perfoming, Loans."Loans Category-SACCO"::Watch);
        if Loans.FindFirst then
            exit(true);

        exit(false);
    end;

    procedure CloseAccs(Rec: Record "Member Exit Notice"; DimID: Integer)
    var
        ChargeAmount: Decimal;
        EDuty: Decimal;
        AcctType: Enum "Gen. Journal Account Type";
        AccNo: Code[50];
        Desc: Text;
        SA: Codeunit "Sacco Activities";
        JTemplate: Code[10];
        JBatch: code[10];
        TransType: Enum "Transaction Type Enum";
        Dim1: Text;
        Dim2: Text;
        SavingsAccounts: Record "Savings Accounts";
        UserSetup: Record "User Setup";

    begin
        // Validate record and user setup
        Rec.TestField(Status, Rec.Status::Approved);
        UserSetup.Get(UserId);
        UserSetup.TestField("CashRec Journal Template");
        UserSetup.TestField("CashRec Journal Batch");

        // Initialize parameters
        JTemplate := UserSetup."CashRec Journal Template";
        JBatch := UserSetup."CashRec Journal Batch";
        Dim1 := UserSetup."Global Dimension 1 Code";
        Dim2 := UserSetup."Global Dimension 2 Code";
        Desc := 'Account Closure';

        // Calculate charges
        GetGeneralChargeAmountOnly(Rec."Transaction Type", Rec."Account Balance", ChargeAmount, EDuty, AcctType, AccNo);

        // Insert main transaction (net amount)
        SA.JournalInsert(
            JTemplate, JBatch, Rec."No.", Today, AcctType::Savings, Rec."Account To Close", Desc,
            AcctType::"G/L Account", '', Rec."Account Balance" - ChargeAmount - EDuty, '', '',
            TransType::" ", Dim1, Dim2, true, TChannel::" ", DimID);

        // Post charge and duties
        SA.JournalInit(JTemplate, JBatch);
        SA.JournalInsert(
            JTemplate, JBatch, Rec."No.", Today, AcctType::Savings, Rec."Account To Close", Desc,
            AcctType, AccNo, ChargeAmount, '', '', TransType::" ", Dim1, Dim2, true, TChannel::" ", DimID);

        if EDuty > 0 then
            SA.JournalInsert(
                JTemplate, JBatch, Rec."No.", Today, AcctType::Savings, Rec."Account To Close",
                StrSubstNo('%1 - Excise Duty', Desc),
                AcctType, AccNo, EDuty, '', '', TransType::" ", Dim1, Dim2, true, TChannel::" ", DimID);

        // Post any residual balance to the transfer account
        if Rec."Transfer Account" <> '' then
            SA.JournalInsert(
                JTemplate, JBatch, Rec."No.", Today, AcctType::Savings, Rec."Transfer Account", Desc,
                AcctType::"G/L Account", '', -(Rec."Account Balance" - ChargeAmount - EDuty), '', '',
                TransType::" ", Dim1, Dim2, true, TChannel::" ", DimID);

        // Finalize posting
        SA.JournalPost(JTemplate, JBatch);

        // Close the account
        SavingsAccounts.Get(Rec."Account To Close");
        SavingsAccounts.Status := SavingsAccounts.Status::Closed;
        SavingsAccounts.Modify;
    end;

    procedure getDividendRate(DividendsSimulationHeader: Record "Dividend Simulation Header"): Boolean
    var
        DividendCalculationBuffer: Record "Dividend Simulation Lines";
        ProductFactory: Record "Product Setup";
        CustomerPostingGroup: Record "Customer Posting Group";
        DividendAccount: Code[20];
        Period: Integer;
    begin

        DividendCalculationBuffer.RESET;
        DividendCalculationBuffer.SETRANGE(DividendCalculationBuffer."Document No.", DividendsSimulationHeader."No.");
        IF DividendCalculationBuffer.FINDSET THEN
            DividendCalculationBuffer.DELETEALL;

        IF DividendsSimulationHeader."All Products" THEN BEGIN
            ProductFactory.RESET;
            ProductFactory.SETFILTER("Dividend Calc. Method", '<>%1', ProductFactory."Dividend Calc. Method"::" ");
            IF ProductFactory.FIND('-') THEN BEGIN
                REPEAT
                    ProductFactory.TESTFIELD("Interest Rate (Min.)");
                    IF CustomerPostingGroup.GET(ProductFactory."Product Posting Group") THEN
                        getSavingsContribution(DividendsSimulationHeader."Start Date", DividendsSimulationHeader."End Date", CustomerPostingGroup."Payables Account", 12, '1',
                                            ProductFactory."Product ID", DividendsSimulationHeader."No.", ProductFactory."Interest Rate (Min.)");
                UNTIL ProductFactory.NEXT = 0;
            END;

        END
        ELSE BEGIN
            /*  DividendsSimulationHeader.TESTFIELD(Rate);
             if DividendsSimulationHeader."Start Date" <> 0D then
                 Period := Date2DMY(DividendsSimulationHeader."Start Date", 2)
             else */
            Period := 12;

            getSavingsContribution(DividendsSimulationHeader."Start Date", DividendsSimulationHeader."End Date", DividendsSimulationHeader."G/L Account", Period, '1',
                                DividendsSimulationHeader."Product Type", DividendsSimulationHeader."No.", DividendsSimulationHeader.Rate);
        END;
    end;

    procedure getSavingsContribution(StartDate: Date; EndDate: Date; DividendAccount: Code[20]; CalculationPeriod: Integer; SimulationNo: Code[20]; ProductType: Code[10]; DocumentNo: Code[10]; DivRate: Decimal)
    var
        DividendCalculationBuffer: Record "Dividend Simulation Lines";
        ProductFactory: Record "Product Setup";
        CustomerPostingGroup: Record "Vendor Posting Group";
        GLAccount: Record "G/L Account";
        i: Integer;
        LineNo: Integer;
        x: Integer;
        SaccoSetup: Record "Sacco Setup";
        OriginalEndDate: Date;
    begin

        ProductFactory.GET(ProductType);
        SaccoSetup.GET();
        OriginalEndDate := EndDate;
        i := Date2DMY(OriginalEndDate, 2);

        DividendCalculationBuffer.RESET;
        LineNo := DividendCalculationBuffer.COUNT;

        EndDate := CALCDATE('CM', StartDate);

        IF ProductFactory."Dividend Calc. Method" = ProductFactory."Dividend Calc. Method"::Prorated THEN BEGIN

            x := CalculationPeriod;
            FOR i := CalculationPeriod DOWNTO 1 DO BEGIN

                if StartDate <= OriginalEndDate then begin
                    GLAccount.RESET;
                    LineNo += 1;

                    if (i = Date2DMY(StartDate, 2)) and (Date2DMY(StartDate, 3) = Date2DMY(SaccoSetup."Go Live Date", 3)) then
                        StartDate := CalcDate('+1D', SaccoSetup."Go Live Date"); //adjustment for go live date for corrent to avoid opening balances ezra

                    IF i = 12 THEN BEGIN
                        EndDate := CALCDATE('-1D', StartDate);
                        GLAccount.SETRANGE(GLAccount."Date Filter", 0D, EndDate);
                    END
                    ELSE
                        GLAccount.SETRANGE(GLAccount."Date Filter", StartDate, EndDate);

                    GLAccount.SETRANGE(GLAccount."No.", DividendAccount);
                    IF GLAccount.FINDFIRST THEN
                        GLAccount.CALCFIELDS(GLAccount."Net Change");

                    /*  IF StartDate > EndDate THEN //simulation issue
                         EXIT; */

                    DividendCalculationBuffer.INIT;
                    DividendCalculationBuffer."No." := SimulationNo;
                    DividendCalculationBuffer."Entry No" := LineNo;
                    DividendCalculationBuffer."G/L Account" := DividendAccount;
                    IF i <> 12 THEN
                        DividendCalculationBuffer."Start Date" := StartDate;
                    DividendCalculationBuffer."End Date" := EndDate;
                    DividendCalculationBuffer.Amount := ABS(GLAccount."Net Change");
                    DividendCalculationBuffer."Weighted Amount" := DividendCalculationBuffer.Amount * (i / CalculationPeriod);
                    DividendCalculationBuffer.Rate := DivRate;
                    DividendCalculationBuffer."Pay Out" := ROUND(DividendCalculationBuffer.Rate / 100 * DividendCalculationBuffer."Weighted Amount", 0.01, '=');
                    DividendCalculationBuffer."W/Tax" := ROUND(ProductFactory."WithHolding Tax" / 100 * DividendCalculationBuffer."Pay Out", 0.01, '=');
                    DividendCalculationBuffer."Net Pay" := DividendCalculationBuffer."Pay Out" - DividendCalculationBuffer."W/Tax";
                    DividendCalculationBuffer."Product Type" := ProductType;
                    DividendCalculationBuffer."Document No." := DocumentNo;
                    DividendCalculationBuffer.INSERT;

                    LineNo += 1;
                    if i = Date2DMY(StartDate, 2) then //ezra simulation
                        StartDate := CalcDate('-CM', StartDate);

                    StartDate := CALCDATE('1M-CM', StartDate);
                    EndDate := CALCDATE('CM', StartDate);
                end;
            end;
        END;


        IF ProductFactory."Dividend Calc. Method" = ProductFactory."Dividend Calc. Method"::"Flat Rate" THEN BEGIN

            LineNo += 1;

            GLAccount.RESET;
            GLAccount.SETRANGE(GLAccount."Date Filter", 0D, OriginalEndDate);
            GLAccount.SETRANGE(GLAccount."No.", DividendAccount);
            IF GLAccount.FINDFIRST THEN
                GLAccount.CALCFIELDS(GLAccount."Net Change");

            DividendCalculationBuffer.INIT;

            DividendCalculationBuffer."No." := SimulationNo;
            DividendCalculationBuffer."Entry No" := LineNo;
            DividendCalculationBuffer."G/L Account" := DividendAccount;
            DividendCalculationBuffer."Start Date" := StartDate;
            DividendCalculationBuffer."End Date" := EndDate;
            DividendCalculationBuffer.Amount := ABS(GLAccount."Net Change");
            DividendCalculationBuffer."Weighted Amount" := DividendCalculationBuffer.Amount;
            DividendCalculationBuffer.Rate := DivRate;
            DividendCalculationBuffer."Pay Out" := ROUND(DividendCalculationBuffer.Rate / 100 * DividendCalculationBuffer."Weighted Amount", 0.01, '=');
            DividendCalculationBuffer."W/Tax" := ROUND(ProductFactory."WithHolding Tax" / 100 * DividendCalculationBuffer."Pay Out", 0.01, '=');
            DividendCalculationBuffer."Net Pay" := DividendCalculationBuffer."Pay Out" - DividendCalculationBuffer."W/Tax";
            DividendCalculationBuffer."Product Type" := ProductType;
            DividendCalculationBuffer."Document No." := DocumentNo;
            DividendCalculationBuffer.INSERT;
        END;

    end;

    procedure GetMemberCommittedDeposits_NRS(DepositAccount: Code[20]; ActiveLoan: Boolean; Loanee: Code[20]): Decimal
    var
        Cust: Record Members;
        PFact: Record "Product Setup";
        Savings: Record "Savings Accounts";
        LRec: Record Loans;
        LoanSecurity: Record "Loan Security";
        CommittedAmount: Decimal;
        CommittedOnAppliedLoans: Decimal;
    begin

        CommittedOnAppliedLoans := 0;

        LRec.Reset;
        LRec.SetRange("Member No.", Loanee);
        LRec.SetFilter("Outstanding Principal", '>0');
        LRec.SetRange(Source, LRec.Source::BOSA);
        if LRec.FindFirst then begin
            repeat
                PFact.Get(LRec."Loan Product Type");
                PFact.TestField("Deposit Multiplier");
                LRec.CalcFields("Outstanding Principal");
                CommittedOnAppliedLoans += ROUND(LRec."Outstanding Principal" / PFact."Deposit Multiplier");
            until LRec.Next = 0;
        end;

        CommittedAmount := 0;
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."guarantor type"::Guarantor);
        LoanSecurity.SetRange("Account No.", DepositAccount);
        LoanSecurity.SetRange(Substituted, false);
        //LoanSecurity.SETRANGE("Defaulter Release",FALSE);
        LoanSecurity.SetFilter("Amount Guaranteed", '>0');
        if ActiveLoan then
            LoanSecurity.SetFilter("Outstanding Principal", '>0')
        else
            LoanSecurity.SetFilter("Outstanding Principal", '<=0');

        if LoanSecurity.Find('-') then begin
            repeat
                if ActiveLoan then
                    CommittedAmount += LoanSecurity."Current Committed"
                else begin
                    LRec.Reset;
                    LRec.SetRange("Loan No.", LoanSecurity."Loan No.");
                    LRec.SetFilter(Status, '<>%1&<>%2', LRec.Status::Deffered, LRec.Status::Rejected);
                    LRec.SetRange(Posted, false);
                    if LRec.FindFirst then
                        CommittedAmount += LoanSecurity."Current Committed";
                end;
            until LoanSecurity.Next = 0;
        end;

        exit(CommittedAmount + CommittedOnAppliedLoans);
    end;


    procedure UpdateNewMembers(PeriodFilter: Date; Members: Record Members)
    var
        ProductFactory: Record "Product Setup";
        DormancyPeriod: DateFormula;
        SavingsAccounts: Record "Savings Accounts";
        SAccounts: Record "Savings Accounts";
        SA: Record "Savings Accounts";
        LastTransDate: Date;
        k: Integer;
        Msg: Text;
        MemberActicities: Codeunit "Member Activities";
        Source: Enum "SMS Source Enum";
        SMS: Record "SMS Messages";
        "3M": Label '3M';
        SSetup: record "Sacco Setup";
        MinContrib: Decimal;
        CurrentContrib: Decimal;
    begin

        SSetup.Get();

        if PeriodFilter = 0D then
            PeriodFilter := Today;

        if Members."Member Status" = Members."Member Status"::New then begin
            MinContrib := 0;
            CurrentContrib := 0;

            MinContrib += SSetup."Min. Contribution [Deposits]" + SSetup."Min. Contribution [Shares]" + SSetup."Min. Benevolent Contrib";

            SavingsAccounts.Reset();
            SavingsAccounts.SetRange("Member No.", Members."No.");
            SavingsAccounts.SetFilter("Product Category", '%1|%2|%3', SavingsAccounts."Product Category"::"Deposit Contribution",
                                                                    SavingsAccounts."Product Category"::"Benevolent Fund",
                                                                    SavingsAccounts."Product Category"::"Share Capital");
            SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
            if SavingsAccounts.FindSet() then begin
                repeat
                    CurrentContrib += SavingsAccounts."Balance (LCY)";
                until SavingsAccounts.Next() = 0;
            end;

            if CurrentContrib >= MinContrib then begin
                Members."Member Status" := Members."Member Status"::Active;

                SAccounts.Reset();
                SAccounts.SetRange("Member No.", Members."No.");
                if SAccounts.FindSet() then
                    repeat
                        SAccounts.Status := SAccounts.Status::Active;
                        SAccounts.Modify();
                    until SAccounts.Next() = 0;

                Members.Modify();
            end;

        end;
        /* else begin

            SavingsAccounts.Reset;
            SavingsAccounts.SetRange("Member No.", Members."No.");
            SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Deposit Contribution");
            SavingsAccounts.SetFilter(Status, '%1|%2', SavingsAccounts.Status::Active, SavingsAccounts.Status::Dormant);
            SavingsAccounts.SetAutoCalcFields("Last Transaction Date");
            if SavingsAccounts.FindFirst then begin
                repeat
                    with SavingsAccounts do begin

                        if "Last Transaction Date" = 0D then
                            "Last Transaction Date" := SavingsAccounts."Registration Date";

                        if "Last Transaction Date" = 0D then
                            "Last Transaction Date" := Members."Registration Date";

                        if "Last Transaction Date" <> 0D then begin
                            ProductFactory.Reset;
                            ProductFactory.SetFilter("Product ID", "Product Type");
                            ProductFactory.SetFilter(ProductFactory."Dormancy Period", '<>%1', DormancyPeriod);
                            if ProductFactory.Find('-') then begin

                                if (CalcDate("3M", "Last Transaction Date") = PeriodFilter) and (CheckMinimumContr(SavingsAccounts."Member No.") < SSetup."Min. Contrib. Amount") then begin
                                    if (Status = Status::Dormant) or (Status = Status::Active) then begin
                                        //Status := Status::Closed;
                                        //Blocked := Blocked::Payment;
                                        Modify;
                                    end;
                                end else
                                    if CalcDate(ProductFactory."Dormancy Period", "Last Transaction Date") < PeriodFilter then begin
                                        if Status = Status::Active then begin
                                            Status := Status::Dormant;
                                            Blocked := Blocked::Payment;
                                            Modify;
                                        end;
                                    end else begin
                                        if Status = Status::Dormant then begin
                                            //Status := Status::Active;
                                            //Blocked := Blocked::" ";
                                            //Modify;
                                        end;
                                    end;
                            end;

                            ProductFactory.Reset;
                            ProductFactory.SetFilter("Product ID", "Product Type");
                            ProductFactory.SetFilter(ProductFactory."Dormancy Period Notification", '<>%1', DormancyPeriod);
                            if ProductFactory.Find('-') then begin

                                if (CalcDate(ProductFactory."Dormancy Period", "Last Transaction Date") > PeriodFilter) and (CalcDate(ProductFactory."Dormancy Period Notification", "Last Transaction Date") < PeriodFilter) then begin
                                    if Status = Status::Active then begin
                                        Msg := 'Dear ' + SkyMbanking.FirstName(Members.Name) + ' Please note that your ' + ProductFactory.Description + ' account will become dormant on ' + format(CalcDate(ProductFactory."Dormancy Period", "Last Transaction Date")) + '. ';
                                        sms.Reset();
                                        sms.SetRange("SMS Message", Msg);
                                        sms.SetRange("Mobile Phone No.", Members."Mobile Phone No.");
                                        if not sms.FindFirst() then begin
                                            MemberActicities.SendSms(Source::"Account Dormancy", Members."Mobile Phone No.", Msg, Members."No.", '', false, false);
                                        end;
                                    end;
                                end;

                            end;
                        end;

                    end;
                until SavingsAccounts.Next() = 0;

            end;

        end;*/
    end;


    procedure UpdateDormantMembers(PeriodFilter: Date; Members: Record Members)
    var
        ProductFactory: Record "Product Setup";
        DormancyPeriod: DateFormula;
        SavingsAccounts: Record "Savings Accounts";
        SAccounts: Record "Savings Accounts";
        SA: Record "Savings Accounts";
        LastTransDate: Date;
        k: Integer;
        Msg: Text;
        MemberActicities: Codeunit "Member Activities";
        Source: Enum "SMS Source Enum";
        SMS: Record "SMS Messages";
        "3M": Label '3M';
        SSetup: record "Sacco Setup";
        MinContrib: Decimal;
        CurrentContrib: Decimal;
        AccountStatus: Enum "Account Status Enum";
        MemberClass: Record "Member Class";
        DepositDate: Date;
        FosaDate: Date;
    begin

        SSetup.Get();

        if PeriodFilter = 0D then
            PeriodFilter := Today;

        if Members."Member Status" = Members."Member Status"::New then begin
            MinContrib := 0;
            CurrentContrib := 0;

            if Members."Member Class" <> '' then begin
                MemberClass.Get(Members."Member Class");
                MinContrib := MemberClass."Minimum Registration Fee";
            end else
                MinContrib += SSetup."Min. Contribution [Deposits]" + SSetup."Min. Contribution [Shares]" + SSetup."Min. Benevolent Contrib";

            SavingsAccounts.Reset();
            SavingsAccounts.SetRange("Member No.", Members."No.");
            SavingsAccounts.SetFilter("Product Category", '%1|%2', SavingsAccounts."Product Category"::"Deposit Contribution",
                                                                    SavingsAccounts."Product Category"::"Share Capital");
            SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
            if SavingsAccounts.FindSet() then begin
                repeat
                    CurrentContrib += SavingsAccounts."Balance (LCY)";
                until SavingsAccounts.Next() = 0;
            end;

            if CurrentContrib >= MinContrib then begin
                Members."Member Status" := Members."Member Status"::Active;

                SAccounts.Reset();
                SAccounts.SetRange("Member No.", Members."No.");
                if SAccounts.FindSet() then
                    repeat
                        SAccounts.Status := SAccounts.Status::Active;
                        SAccounts.Modify();
                    until SAccounts.Next() = 0;

                Members.Modify();
            end;

        end else begin

            SavingsAccounts.Reset;
            SavingsAccounts.SetRange("Member No.", Members."No.");
            SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Deposit Contribution");
            SavingsAccounts.SetFilter(Status, '%1|%2', SavingsAccounts.Status::Active, SavingsAccounts.Status::Dormant);
            //SavingsAccounts.SetAutoCalcFields("Last Transaction Date");
            if SavingsAccounts.FindFirst then begin
                repeat
                    SavingsAccounts.CalcFields("Last Transaction Date");

                    if SavingsAccounts."Last Transaction Date" = 0D then
                        SavingsAccounts."Last Transaction Date" := SavingsAccounts."Registration Date";

                    if SavingsAccounts."Last Transaction Date" = 0D then
                        SavingsAccounts."Last Transaction Date" := Members."Registration Date";

                    if SavingsAccounts."Last Transaction Date" <> 0D then begin

                        DepositDate := SavingsAccounts."Last Transaction Date";

                        ProductFactory.Reset;
                        ProductFactory.SetFilter("Product ID", SavingsAccounts."Product Type");
                        ProductFactory.SetFilter(ProductFactory."Dormancy Period", '<>%1', DormancyPeriod);
                        if ProductFactory.Find('-') then begin

                            if CalcDate(ProductFactory."Dormancy Period", SavingsAccounts."Last Transaction Date") > PeriodFilter then begin
                                /* Members."Member Status" := Members."Member Status"::Active; //Only through member changes
                                Members.Modify;
                                UpdateAccountStatus(SavingsAccounts."Member No.", AccountStatus::Active); */
                                SavingsAccounts.Status := SavingsAccounts.Status::Active;
                                SavingsAccounts.Modify;
                            end else begin
                                //Members."Member Status" := Members."Member Status"::Dormant;
                                SavingsAccounts.Status := SavingsAccounts.Status::Dormant;
                                SavingsAccounts.Modify;
                                //UpdateAccountStatus(SavingsAccounts."Member No.", AccountStatus::Dormant);
                            end;
                        end;

                        ProductFactory.Reset;
                        ProductFactory.SetFilter("Product ID", SavingsAccounts."Product Type");
                        ProductFactory.SetFilter(ProductFactory."Dormancy Period Notification", '<>%1', DormancyPeriod);
                        if ProductFactory.Find('-') then begin

                            if (CalcDate(ProductFactory."Dormancy Period", SavingsAccounts."Last Transaction Date") < PeriodFilter) /* and (CalcDate(ProductFactory."Dormancy Period Notification", SavingsAccounts."Last Transaction Date") < PeriodFilter)  */
                                then begin
                                //if Status = Status::Active then begin
                                // Msg := 'Dear ' + SkyMbanking.FirstName(Members.Name) + ' Please note that your ' + ProductFactory.Description + ' account will become dormant on '
                                //    + format(CalcDate(ProductFactory."Dormancy Period", "Last Transaction Date")) + '. ';
                                Msg := CopyStr('Dear Member, Your account is currently dormant due to inactivity. Reactivate it with a minimum deposit of Ksh 1,600 via Paybill 600110 or by visiting our office. To activate online, fill out the form here: https://bit.ly/4cOzzXA. Call: 0709446000', 1, 250);

                                /* sms.Reset();
                                sms.SetRange("SMS Message", Msg);
                                sms.SetRange("Mobile Phone No.", Members."Mobile Phone No.");
                                SMS.SetRange(Source, SMS.Source::"Account Dormancy");
                                SMS.SetRange("Date Entered", CalcDate('-CM', Today), CalcDate('CM', Today));
                                if not sms.FindFirst() then begin
                                    MemberActicities.SendSms(Source::"Account Dormancy", Members."Mobile Phone No.", Msg, Members."No.", '', false, false);
                                end; */
                                // end;
                            end;
                        end;
                    end;
                until SavingsAccounts.Next() = 0;

            end; //else begin
            SavingsAccounts.Reset;
            SavingsAccounts.SetRange("Member No.", Members."No.");
            SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Ordinary Savings");
            SavingsAccounts.SetFilter(Status, '%1|%2', SavingsAccounts.Status::Active, SavingsAccounts.Status::Dormant);
            //SavingsAccounts.SetAutoCalcFields("Last Transaction Date");
            if SavingsAccounts.FindFirst then begin
                repeat
                    SavingsAccounts.CalcFields("Last Transaction Date");

                    if SavingsAccounts."Last Transaction Date" = 0D then
                        SavingsAccounts."Last Transaction Date" := SavingsAccounts."Registration Date";

                    if SavingsAccounts."Last Transaction Date" = 0D then
                        SavingsAccounts."Last Transaction Date" := Members."Registration Date";

                    if SavingsAccounts."Last Transaction Date" <> 0D then begin

                        FosaDate := SavingsAccounts."Last Transaction Date";

                        ProductFactory.Reset;
                        ProductFactory.SetFilter("Product ID", SavingsAccounts."Product Type");
                        ProductFactory.SetFilter(ProductFactory."Dormancy Period", '<>%1', DormancyPeriod);
                        if ProductFactory.Find('-') then begin

                            if CalcDate(ProductFactory."Dormancy Period", SavingsAccounts."Last Transaction Date") > PeriodFilter then begin
                                /* Members."Member Status" := Members."Member Status"::Active; //Only through member changes
                                Members.Modify;
                                UpdateAccountStatus(SavingsAccounts."Member No.", AccountStatus::Active); */
                            end else begin
                                SavingsAccounts.Status := SavingsAccounts.Status::Dormant;
                                SavingsAccounts.Modify;
                            end;
                        end;

                        ProductFactory.Reset;
                        ProductFactory.SetFilter("Product ID", SavingsAccounts."Product Type");
                        ProductFactory.SetFilter(ProductFactory."Dormancy Period Notification", '<>%1', DormancyPeriod);
                        if ProductFactory.Find('-') then begin

                            if (CalcDate(ProductFactory."Dormancy Period", SavingsAccounts."Last Transaction Date") < PeriodFilter) /* and (CalcDate(ProductFactory."Dormancy Period Notification", SavingsAccounts."Last Transaction Date") < PeriodFilter)  */
                                then begin
                                //if Status = Status::Active then begin
                                // Msg := 'Dear ' + SkyMbanking.FirstName(Members.Name) + ' Please note that your ' + ProductFactory.Description + ' account will become dormant on '
                                //    + format(CalcDate(ProductFactory."Dormancy Period", "Last Transaction Date")) + '. ';
                                Msg := CopyStr('Dear Member, Your account is currently dormant due to inactivity. Reactivate it with a minimum deposit of Ksh 1,600 via Paybill 600110 or by visiting our office. To activate online, fill out the form here: https://bit.ly/4cOzzXA. Call: 0709446000', 1, 250);

                                /* sms.Reset();
                                sms.SetRange("SMS Message", Msg);
                                sms.SetRange("Mobile Phone No.", Members."Mobile Phone No.");
                                SMS.SetRange(Source, SMS.Source::"Account Dormancy");
                                SMS.SetRange("Date Entered", CalcDate('-CM', Today), CalcDate('CM', Today));
                                if not sms.FindFirst() then begin
                                    MemberActicities.SendSms(Source::"Account Dormancy", Members."Mobile Phone No.", Msg, Members."No.", '', false, false);
                                end; */
                                // end;
                            end;
                        end;
                    end;
                until SavingsAccounts.Next() = 0;
            end;

            //Fosa Member Bosa Account
            if (DepositDate <> 0D) and (FosaDate <> 0D) then begin

                if CalcDate(ProductFactory."Dormancy Period", MostRecentDate(DepositDate, FosaDate)) > PeriodFilter then begin
                    Members."Member Status" := Members."Member Status"::Active;
                    Members.Modify;
                end else begin
                    Members."Member Status" := Members."Member Status"::Dormant;
                    Members.Modify;
                end;
            end;

            //end;

        end;
    end;

    local procedure MostRecentDate(Date1: Date; Date2: Date) MostRecentDate: Date
    begin


        if Date1 > Date2 then
            MostRecentDate := Date1
        else
            MostRecentDate := Date2;

        Exit(MostRecentDate);

    end;

    local procedure UpdateAccountStatus(MembNo: Code[20]; AccStatus: Enum "Account Status Enum")
    var
        SavingsAccounts: Record "Savings Accounts";
        Members: Record Members;
    begin
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("Member No.", MembNo);
        SavingsAccounts.SetFilter("Product Category", '%1|%2|%3',
                                SavingsAccounts."Product Category"::"Deposit Contribution",
                                SavingsAccounts."Product Category"::"Share Capital",
                                SavingsAccounts."Product Category"::"Benevolent Fund",
                                SavingsAccounts."Product Category"::"Holiday Savings",
                                SavingsAccounts."Product Category"::"Fixed Deposit",
                                SavingsAccounts."Product Category"::"Dividend Account",
                                SavingsAccounts."Product Category"::Jiajiri,
                                SavingsAccounts."Product Category"::"Junior Savings",
                                SavingsAccounts."Product Category"::"Unallocated Fund",
                                SavingsAccounts."Product Category"::"Ordinary Savings"
                            );
        SavingsAccounts.SetFilter(Status, '%1|%2', SavingsAccounts.Status::Active, SavingsAccounts.Status::Dormant);
        if SavingsAccounts.FindFirst then begin
            repeat
                SavingsAccounts.Status := AccStatus;
                SavingsAccounts.Modify();
            until SavingsAccounts.Next() = 0;
        end;
    end;

    procedure CheckMinimumContr(MembNo: Code[20]): Decimal //Check if member contirbuted min 3,600
    var
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Setup";
        Bal: Decimal;
        Members: Record Members;
        Emp: Record Customer;
    begin

        Bal := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("Member No.", MembNo);
        SavingsAccounts.SetFilter("Product Category", '%1|%2|%3', SavingsAccounts."Product Category"::"Deposit Contribution",
                                                                SavingsAccounts."Product Category"::"Benevolent Fund",
                                                                SavingsAccounts."Product Category"::"Share Capital"
                                                                );
        SavingsAccounts.SetAutoCalcFields("Balance (LCY)", "Uncleared Cheques", "Authorised Over Draft");
        if SavingsAccounts.Find('-') then
            repeat


                if ProductFactory.Get(SavingsAccounts."Product Type") then
                    MinBal := ProductFactory."Minimum Account Balance";


                Members.Get(SavingsAccounts."Member No.");
                if Emp.Get(Members."Employer Code") then
                    if Emp."Dont Charge Transactions" then
                        MinBal := 0;

                Bal += SavingsAccounts."Balance (LCY)" + SavingsAccounts."Authorised Over Draft"
                      - SavingsAccounts."Uncleared Cheques"
                      - MinBal;


            until SavingsAccounts.next() = 0;
        exit(Bal);
    end;

    procedure GetAccountBalanceByDate(AcctNo: Code[20]; AsAt: Date): Decimal
    var
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Setup";
        Bal: Decimal;
        Members: Record Members;
        Emp: Record Customer;
    begin

        Bal := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", AcctNo);
        SavingsAccounts.SetFilter("Date Filter", '..%1', AsAt);
        if SavingsAccounts.Find('-') then begin


            if ProductFactory.Get(SavingsAccounts."Product Type") then
                MinBal := ProductFactory."Minimum Account Balance";


            Members.Get(SavingsAccounts."Member No.");
            if Emp.Get(Members."Employer Code") then
                if Emp."Dont Charge Transactions" then
                    MinBal := 0;


            SavingsAccounts.CalcFields("Balance (LCY)", "Share Trading Buffer", "Uncleared Cheques", "Authorised Over Draft"/*,"ATM Transactions","Lien Placed","Lien Guaranteed"*/);

            Bal := SavingsAccounts."Balance (LCY)" + SavingsAccounts."Authorised Over Draft"
                  - SavingsAccounts."Uncleared Cheques"
                  - SavingsAccounts."Share Trading Buffer"
                  - MinBal;


            /*
            Bal:=(SavingsAccounts."Balance (LCY)"{+SavingsAccounts."Authorised Over Draft"})-
                  SavingsAccounts."Yetu ATM Transactions"-ProductFactory."Minimum Balance"-SavingsAccounts."Uncleared Cheques"-
                  SavingsAccounts."Lien Placed"-SavingsAccounts."ATM Transactions"-SavingsAccounts."Lien Guaranteed";
                  */

        end;
        exit(Bal);

    end;


    procedure GetGeneralChargeAmountWithCounter(ChargeCode: Code[20]; Value: Decimal; var ChargeAmt: Decimal; var ChargeDuty: Decimal; var ChargeAcctType: Enum "Gen. Journal Account Type"; var ChargeAcct: Code[20]; var Counter: Integer; var Lines: Integer; var Desc: Text)
    var
        ChargesLines: Record "Transaction Charges Lines";
        Amt: Decimal;
        StaggeredLines: Record "Staggered Lines.";
        ChargeAmount: Decimal;
        k: Integer;
    begin

        GenSetup.Get;
        ChargeAmt := 0;
        ChargeAcct := '';
        ChargeDuty := 0;
        Lines := 0;
        Desc := '';

        ChargesLines.Reset;
        ChargesLines.SetRange("Transaction Type", ChargeCode);
        if ChargesLines.Find('-') then begin
            k := 0;
            Lines := ChargesLines.Count;
            repeat
                k += 1;
                if Counter = k then begin

                    Desc := ChargesLines.Description;
                    ChargeAmount := 0;
                    if ChargesLines."Charge Type" = ChargesLines."charge type"::"% of Amount" = true then
                        ChargeAmount := (Value * ChargesLines."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := ChargesLines."Charge Amount";

                    if ChargesLines."Charge Type" = ChargesLines."charge type"::Staggered then begin

                        ChargesLines.TestField("Staggered Charge Code");

                        StaggeredLines.Reset;
                        StaggeredLines.SetRange(Code, ChargesLines."Staggered Charge Code");
                        if StaggeredLines.Find('-') then begin
                            repeat

                                if (Value >= StaggeredLines."Lower Limit") and (Value <= StaggeredLines."Upper Limit") then begin
                                    if StaggeredLines."Use Percentage" = true then begin
                                        ChargeAmount := Value * StaggeredLines.Percentage * 0.01;
                                    end
                                    else begin
                                        ChargeAmount := StaggeredLines."Charge Amount";
                                    end;
                                end;
                            until StaggeredLines.Next = 0;
                        end;
                    end;

                    ChargeAmt := ChargeAmount;
                    ChargeAcct := ChargesLines."Charge Account";
                    ChargeAcctType := ChargesLines."Charge Account Type";


                    if ChargesLines."Minimum Amount" > 0 then
                        if ChargeAmt < ChargesLines."Minimum Amount" then
                            ChargeAmt := ChargesLines."Minimum Amount";

                    if ChargesLines."Maximum Amount" > 0 then
                        if ChargeAmt > ChargesLines."Maximum Amount" then
                            ChargeAmt := ChargesLines."Maximum Amount";

                    ChargeAmt := ROUND(ChargeAmt, 0.01, '=');
                    if ChargeAmt > 0 then
                        ChargesLines.TestField("Charge Account");

                    if ChargesLines."Excise Duty %" > 0 then
                        ChargeDuty := ChargeAmt * ChargesLines."Excise Duty %" * 0.01
                    else
                        ChargeDuty := ROUND(ChargeAmt * GenSetup."Excise Duty (%)" * 0.01, 0.01, '=');
                end;
            until ChargesLines.Next = 0;

        end;

        Counter += 1;
    end;


    procedure GenerateLoanStatementBuffer(LoanNo: Code[20]; MemberNo: Code[20]; ClearAll: Boolean)
    var
        CLedger: Record "Credit Ledger Entry";
        Statement: Record "Loan Statement Buffer";
    begin
        CLedger.Reset();
        CLedger.SetRange("Loan No.", LoanNo);
        CLedger.SetRange("Member No.", MemberNo);
        if not ClearAll then
            CLedger.SetRange(Transfered, false);
        if CLedger.FindFirst() then begin
            repeat
                CLedger.calcfields(Amount);

                if ClearAll then begin



                    Statement.Reset();
                    Statement.SetRange("Entry No.", CLedger."Entry No.");
                    Statement.SetRange("Member No.", MemberNo);
                    Statement.SetRange("Loan No.", LoanNo);
                    if Statement.FindFirst() then begin
                        Statement.DeleteAll();
                    end;

                    CLedger.CalcFields(Amount);


                    Statement.Init();
                    Statement."Entry No." := CLedger."Entry No.";
                    Statement.Date := CLedger."Posting Date";
                    Statement."Loan No." := CLedger."Loan No.";
                    Statement."Member No." := CLedger."Account No.";

                    if CLedger."Transaction Type" = CLedger."Transaction Type"::"Interest Due" then
                        Statement."Accrued Interest" := CLedger.Amount;
                    if CLedger."Transaction Type" = CLedger."Transaction Type"::"Interest Paid" then
                        Statement."Interest Paid" := CLedger.Amount * -1;
                    if CLedger."Transaction Type" = CLedger."Transaction Type"::"Principal Repayment" then
                        Statement."Principal Paid" := CLedger.Amount * -1;
                    if CLedger."Transaction Type" = CLedger."Transaction Type"::"Loan Disbursement" then
                        Statement."New Loan" := CLedger.Amount;

                    Statement."Total Paid" := Statement."Interest Paid" + Statement."Principal Paid";
                    Statement.Insert();
                    CLedger.Transfered := true;
                    CLedger.Modify();

                end
                else begin
                    Statement.Reset();
                    Statement.SetRange("Entry No.", CLedger."Entry No.");
                    Statement.SetRange("Member No.", MemberNo);
                    Statement.SetRange("Loan No.", LoanNo);
                    if not Statement.FindFirst() then begin
                        Statement.Init();
                        Statement."Entry No." := CLedger."Entry No.";
                        Statement.Date := CLedger."Posting Date";
                        Statement."Loan No." := CLedger."Loan No.";
                        Statement."Member No." := CLedger."Account No.";

                        if CLedger."Transaction Type" = CLedger."Transaction Type"::"Interest Due" then
                            Statement."Accrued Interest" := CLedger.Amount;
                        if CLedger."Transaction Type" = CLedger."Transaction Type"::"Interest Paid" then
                            Statement."Interest Paid" := CLedger.Amount;
                        if CLedger."Transaction Type" = CLedger."Transaction Type"::"Principal Repayment" then
                            Statement."Principal Paid" := CLedger.Amount;
                        if CLedger."Transaction Type" = CLedger."Transaction Type"::"Loan Disbursement" then
                            Statement."New Loan" := CLedger.Amount;

                        Statement."Total Paid" := Statement."Interest Paid" + Statement."Principal Paid";
                        Statement.Insert();
                        CLedger.Transfered := true;
                        CLedger.Modify();
                    end;
                end;

            until CLedger.Next() = 0;
        end;
    end;

    procedure populateStatement(LoanNumber: Code[20]; MemberNo: Code[20])
    var
        myInt: Integer;
        MLedger: Record "Credit Ledger Entry";
        StatementTable: Record "Statement Buffer";
        LineNo: Integer;
        LRec: Record Loans;
        IntDue: Decimal;
        IntPaid: Decimal;
    begin
        LineNo := 0;

        StatementTable.RESET;
        IF StatementTable.FINDLAST THEN
            LineNo := StatementTable.entryNo;


        StatementTable.RESET;
        StatementTable.SETRANGE("Loan No.", LoanNumber);
        IF StatementTable.FINDFIRST THEN
            StatementTable.DELETEALL;



        MLedger.RESET;
        MLedger.SETRANGE("Loan No.", LoanNumber);
        MLedger.SETRANGE("Account No.", MemberNo);
        //MLedger.SETRANGE(Transferred,FALSE);
        MLedger.SETRANGE(Reversed, FALSE);
        //MLedger.SETFILTER("Document No.",'%1','<>@*R-*');
        IF MLedger.FINDFIRST THEN BEGIN
            REPEAT
                MLedger.CalcFields(Amount);
                LineNo += 1;
                StatementTable.INIT;
                StatementTable.entryNo := LineNo;
                StatementTable."Loan No." := LoanNumber;
                StatementTable."Posting Date" := MLedger."Posting Date";

                LRec.RESET;
                LRec.SETRANGE("Loan No.", MLedger."Loan No.");
                LRec.SETFILTER("Date filter", '..%1', CALCDATE('-1D', MLedger."Posting Date"));
                IF LRec.FINDFIRST THEN BEGIN
                    LRec.CALCFIELDS("Outstanding Principal");
                    StatementTable."Opening Balance" := LRec."Outstanding Principal";
                END;

                IF MLedger."Transaction Type" = MLedger."Transaction Type"::"Principal Repayment" THEN
                    StatementTable."Principal Paid" := MLedger.Amount * -1;

                IF MLedger."Transaction Type" = MLedger."Transaction Type"::"Interest Paid" THEN
                    StatementTable."Interest Paid" := MLedger.Amount * -1;

                StatementTable."Amount Paid" := StatementTable."Principal Paid" + StatementTable."Interest Paid";

                IntPaid := 0;

                IntDue := 0;
                LRec.RESET;
                LRec.SETRANGE("Loan No.", MLedger."Loan No.");
                LRec.SETFILTER("Date filter", '..%1', MLedger."Posting Date");
                IF LRec.FINDFIRST THEN BEGIN
                    LRec.CALCFIELDS("Outstanding Principal", "Interest Paid", "Interest Due");
                    StatementTable."Loan Balance" := LRec."Outstanding Principal";
                    IntPaid := LRec."Interest Paid";
                END;

                IF MLedger."Posting Date" >= DMY2DATE(1, 1, 2022) THEN BEGIN

                    LRec.RESET;
                    LRec.SETRANGE("Loan No.", MLedger."Loan No.");
                    LRec.SETFILTER("Date filter", '..%1', MLedger."Posting Date");
                    IF LRec.FINDFIRST THEN BEGIN
                        LRec.CALCFIELDS("Outstanding Principal", "Interest Paid", "Interest Due");
                        IntDue := LRec."Interest Due";
                    END;
                END
                ELSE BEGIN

                    LRec.RESET;
                    LRec.SETRANGE("Loan No.", MLedger."Loan No.");
                    LRec.SETFILTER("Date filter", '..%1', MLedger."Posting Date");
                    IF LRec.FINDFIRST THEN BEGIN
                        LRec.CALCFIELDS("Outstanding Principal", "Interest Paid", "Interest Due");
                        IntDue := LRec."Interest Due";
                    END;
                END;

                StatementTable."Interest Balance" := IntDue + IntPaid;

                IF MLedger."Posting Date" >= DMY2DATE(1, 1, 2022) THEN
                    IF MLedger."Transaction Type" = MLedger."Transaction Type"::"Interest Due" THEN
                        StatementTable."Interest Due" := MLedger.Amount;

                StatementTable."Receipt No" := MLedger."Document No.";
                StatementTable.ledgerEntry := MLedger."Entry No.";



                IF (MLedger."Transaction Type" <> MLedger."Transaction Type"::"Interest Due") THEN
                    StatementTable.INSERT
                ELSE
                    IF (MLedger."Posting Date" >= DMY2DATE(1, 1, 2022)) AND (MLedger."Transaction Type" = MLedger."Transaction Type"::"Interest Due") THEN
                        StatementTable.INSERT;

            UNTIL MLedger.NEXT = 0;

        END;
    end;


    procedure SendEmailNotification(Heading: text; SalutationTxt: Text; BodyTxt: text; RegardsTxt: Text; Receiver: Text; FilePath_Name: Text; MsgEcryt: Text[200]) Sent: Boolean;
    var
        myInt: Integer;


        CompanyInformation: Record "Company Information";
        Cust: Record Members;
        FileManagement: Codeunit "File Management";
        SMTPSetup: Record "Email Account";
        SMTPMail: Codeunit "Email Message";
        TempBlob: Record CustomTempBlob;
        SaccoSetup: Record "Sacco Setup";
        BodyMsg: Text;
        Base64: Text;
        EmailSend: Codeunit Email;
        TmpCustomTempBlob: Record CustomTempBlob temporary;
        MActivities: Codeunit "Member Activities";
        j: Integer;
        RT: Enum "Email Recipient Type";
    begin
        Sent := false;

        if FilePath_Name <> '' then begin

            //TempBlob.BLOBImportFromServerFile(TempBlob, FilePath_Name);
            //Base64 := Format(TempBlob.ToBase64String);

        end;

        BodyMsg := (SalutationTxt);
        BodyMsg += ('<br><br>');
        BodyMsg += (BodyTxt);
        BodyMsg += ('<br><br>');
        BodyMsg += (MsgEcryt);
        BodyMsg += ('<br>');
        BodyMsg += (RegardsTxt);
        BodyMsg += ('<br><br>');
        BodyMsg += (COMPANYNAME);
        BodyMsg += ('<br><br>');
        BodyMsg += ('<br>');

        SMTPMail.Create(Receiver, Heading, BodyMsg, true);
        //SMTPMail.AddRecipient(RT::Cc, 'loans@maishaborasacco.com');
        //SMTPMail.AddRecipient(RT::Cc, 'tony.kiprono@maishaborasacco.com');
        //SMTPMail.AddRecipient(RT::Cc, 'dwafula@maishaborasacco.com');

        if FilePath_Name <> '' then begin
            SMTPMail.AddAttachment(FilePath_Name, 'pdf', Base64);
        end;

        if EmailSend.Send(SMTPMail) then
            Sent := true;

    end;


    procedure SendBirthDaySms(Members: Record Members)
    var
        MemberActivities: Codeunit "Member Activities";
        Month: Text[50];
        Msg: Text;
        LBal: Decimal;
        MonthlyRep: Decimal;
        Product: Record "Product Setup";
        Sky: Codeunit "Sky MBanking";
        SMSSource: Enum "SMS Source Enum";
        BirthDay: Integer;
        BirthMonth: Integer;
        TheDayNumberToday: Integer;
        TheMonthNumberToday: Integer;
        JuniorBirthDay: Integer;
        JuniorBirthMonth: Integer;
        FosaAcc: Record "Savings Accounts";
        BlankDate: Date;
        DateOfBirthHasValue: Boolean;
        SMSMessages: Record "SMS Messages";
        DateofBirth: Date;
        Juniorbashsms: Label 'Dear %1, Today is the birthday of a very special young member. I hope you enjoy every moment of this beautiful day.';
        BashSms: Label 'Dear %1, Happy Birthday! On behalf of United Women Sacco, we appreciate your continued trust and membership. Wishing you a year of good health, growth and prosperity.';
    begin
        if Members."Mobile Phone No." <> '' then
            DateOfBirthHasValue := (Members."Date of Birth" <> BlankDate);
        IF DateOfBirthHasValue THEN BEGIN
            IF (Members."Phone No." <> '') THEN BEGIN

                TheDayNumberToday := DATE2DMY(Today, 1);
                TheMonthNumberToday := DATE2DMY(Today, 2);

                FosaAcc.RESET;
                FosaAcc.SETRANGE("Product Category", FosaAcc."Product Category"::"Junior Savings");
                FosaAcc.SETRANGE("Member No.", Members."No.");
                IF FosaAcc.FINDSET THEN
                    REPEAT
                        IF FosaAcc."Child Date Of Birth" <> 0D THEN BEGIN

                            JuniorBirthDay := DATE2DMY(FosaAcc."Child Date Of Birth", 1);
                            JuniorBirthMonth := DATE2DMY(FosaAcc."Child Date Of Birth", 2);

                            IF (JuniorBirthDay = TheDayNumberToday) AND (JuniorBirthMonth = TheMonthNumberToday) THEN BEGIN

                                Msg := STRSUBSTNO(JuniorBashsms, Sky.FirstName(FosaAcc.Name));

                                SMSMessages.RESET;
                                SMSMessages.SETRANGE("Account No", FosaAcc."No.");
                                SMSMessages.SETRANGE(Source, SmsSource::Birthday);
                                SMSMessages.SETRANGE("Date Entered", TODAY);
                                SMSMessages.SETRANGE("Mobile Phone No.", Members."Phone No.");
                                IF NOT SMSMessages.FINDFIRST THEN
                                    MemberActivities.SendSms(Source::Birthday, Members."Mobile Phone No.", Msg, Members."No.", FosaAcc."No.", false, false);
                            END;
                        END;
                    UNTIL FosaAcc.NEXT = 0;



                BirthDay := DATE2DMY(Members."Date of Birth", 1);
                BirthMonth := DATE2DMY(Members."Date of Birth", 2);

                IF BirthDay = TheDayNumberToday THEN begin
                    IF BirthMonth = TheMonthNumberToday THEN begin

                        Msg := STRSUBSTNO(BashSms, Sky.FirstName(Members.Name));

                        SMSMessages.RESET;
                        SMSMessages.SETRANGE("Account No", Members."No.");
                        SMSMessages.SETRANGE(Source, SmsSource::Birthday);
                        SMSMessages.SETRANGE("Date Entered", TODAY);
                        SMSMessages.SETRANGE("Mobile Phone No.", Members."Phone No.");
                        IF NOT SMSMessages.FINDFIRST THEN
                            MemberActivities.SendSms(Source::Birthday, Members."Mobile Phone No.", Msg, Members."No.", Members."No.", false, false);

                    end;
                end;
            END;
        END;
    end;

    procedure ConvertPhoneNo(mobilePhoneNo: Text) NewPhoneNo: Text
    var
        PhoneLength: Integer;
        StPoint: Integer;
    begin
        NewPhoneNo := mobilePhoneNo;

        PhoneLength := StrLen(mobilePhoneNo);
        StPoint := PhoneLength - 8;

        NewPhoneNo := '+254' + CopyStr(mobilePhoneNo, StPoint, 9);
    end;

    /// <summary>
    /// PostSinkClaims.
    /// </summary>
    /// <param name="BBFHeaderClaim">Record "BBF Entitlement Header".</param>
    procedure PostSinkClaims(BBFHeaderClaim: Record "BBF Entitlement Header")
    var
        SA: Codeunit "Sacco Activities";
        Template: Code[10];
        Batch: Code[10];
        OfficeTemp: Record "User Setup";
        ClaimLines: Record "BBF Entitlement Lines";
        GeneralSetUp: Record "Sacco SetUp";
        LineNo: Integer;
        KinDetails: Record "Next of KIN.";
        ErrorOnPayMode: Label 'Pay mode must be Bank or Cheque';
        MsgOnCompletePosting: Label 'Application No. -%1- successfully posted.';
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        AccType: Integer;
        BBFRequisationLines: Record "BBF Entitlement Header";
        Temp: Record "Banking User Setup";
        Jtemplate: Code[10];
        JBatch: Code[10];
        MsgOnConfirmDialog: Label 'Are you want to Post this Claim?';
        AccTypes: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        DimID: Integer;
        Acc: Code[20];
        Msg: Text[250];
    begin

        BBFHeaderClaim.TestField(Posted, false);
        BBFHeaderClaim.TestField(Status, BBFHeaderClaim.Status::Approved);
        BBFHeaderClaim.TestField("Collector ID");
        BBFHeaderClaim.TestField("Collector Name");

        //TESTFIELD("Payment Release Date",TODAY);
        GeneralSetUp.Get();
        GeneralSetUp.TestField("BBF Expense Account");
        BBFHeaderClaim.TestField("Global Dimension 1 Code");
        BBFHeaderClaim.TestField("Global Dimension 2 Code");
        Temp.Get(UserId);
        Temp.TestField("Cashier Journal Template");
        Temp.TestField("Cashier Journal Batch");
        Template := Temp."Cashier Journal Template";
        Batch := Temp."Cashier Journal Batch";
        if Confirm(MsgOnConfirmDialog, true) = false then exit;
        SA.JournalInit(Template, Batch);
        DimID := BBFHeaderClaim."Dimension Set ID";
        Acc := '';

        SavingsAccounts.Reset();
        SavingsAccounts.SetRange("Member No.", BBFHeaderClaim."Member No");
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Ordinary Savings");
        if SavingsAccounts.FindFirst() then
            Acc := SavingsAccounts."No."
        else
            Error('No Benevolent account  for %1 found', BBFHeaderClaim."Account Name");

        begin

            ClaimLines.Reset();
            ClaimLines.SetRange("Header No", BBFHeaderClaim."No.");
            ClaimLines.SetRange(Deceased, true);
            if ClaimLines.FindFirst() then begin
                repeat

                    KinDetails.Reset();
                    if ClaimLines."ID No." <> '' then
                        KinDetails.Setrange("ID No.", ClaimLines."ID No.")
                    else
                        KinDetails.SetRange(Name, ClaimLines.Name);
                    if KinDetails.FindFirst() then begin
                        KinDetails.Deceased := true;
                        KinDetails.Modify();
                    end;
                until ClaimLines.Next() = 0;
            end;



            BBFHeaderClaim.CalcFields(Amount);

            LineNo := LineNo + 1;

            //Debit Bank
            SA.JournalInsert(Template, Batch, BBFHeaderClaim."No.", BBFHeaderClaim."Payment Release Date", AccTypes::"G/L Account", GeneralSetUp."BBF Expense Account", PadStr(BBFHeaderClaim."Member No" + ' GFE Pay: ' + ClaimLines.Name, 50), BalAcctType::Savings, Acc, BBFHeaderClaim.Amount, '', '', TransType::" ", BBFHeaderClaim."Global Dimension 1 Code", BBFHeaderClaim."Global Dimension 2 Code", false, TChannel::" ", DimID);


            /* if "Pay Mode" <> "Pay Mode"::FOSA then begin

                 SA.JournalInsert(
                     Template, Batch, "No.", "Payment Release Date", AccTypes::Savings, Acc, PadStr(ClaimLines."Next of Kin" + ' GFE Pay: ' + "Collector ID" + '-' + "Collector Name", 50), BalAcctType::"G/L Account", '', Amount, '', '', TransType::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", false, TChannel::" ", DimID);

                 AccTypes := AccTypes::"Bank Account";

                 SA.JournalInsert(
                 Template, Batch, "No.", "Payment Release Date", AccTypes, "Paying Bank", PadStr(ClaimLines."Next of Kin" + ' GFE Pay: ' + "Collector ID" + '-' + "Collector Name", 50), BalAcctType::"G/L Account", '', Amount * -1, '', '', TransType::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", false, TChannel::" ", DimID);

             end;
             */

            SA.JournalPost(Template, Batch);

            Commit;
            Msg := 'Dear ' + BBFHeaderClaim."Collector Name" + ', We  have disbursed your GFE Claim, and its ready for collection';
            SendSms(Source::GFE, BBFHeaderClaim."Collector Mobile No.", Msg, BBFHeaderClaim."No.", '', false, false);
            Commit;

        end;
        BBFHeaderClaim.Posted := true;
        BBFHeaderClaim.modify;
    end;

    Procedure RegistrationFeeFullyPaid(MemberNo: Code[20]; MinRegfee: decimal): Boolean
    var
        SavingsAccounts: Record "Savings Accounts";
        ProdSetup: Record "Product Setup";
    begin
        ProdSetup.Reset();
        ProdSetup.SetRange("Product Category", ProdSetup."Product Category"::"Registration Fee");
        if ProdSetup.FindFirst() then begin
            SavingsAccounts.RESET;
            SavingsAccounts.SETRANGE(SavingsAccounts."Member No.", MemberNo);
            SavingsAccounts.SETRANGE("Product Category", ProdSetup."Product Category");
            IF SavingsAccounts.FINDFIRST THEN BEGIN
                SavingsAccounts.CALCFIELDS("Balance (LCY)");


                EXIT(SavingsAccounts."Balance (LCY)" >= MinRegfee);

            END;

        end;


    end;

    Procedure DepositContributionFullyPaid(MemberNo: Code[20]; MinDeposits: Decimal): Boolean
    var
        SavingsAccounts: Record "Savings Accounts";
        ProdSetup: Record "Product Setup";
    begin
        ProdSetup.Reset();
        ProdSetup.SetRange("Product Category", ProdSetup."Product Category"::"Deposit Contribution");
        if ProdSetup.FindFirst() then begin
            SavingsAccounts.RESET;
            SavingsAccounts.SETRANGE(SavingsAccounts."Member No.", MemberNo);
            SavingsAccounts.SETRANGE("Product Category", ProdSetup."Product Category");
            IF SavingsAccounts.FINDFIRST THEN BEGIN
                SavingsAccounts.CALCFIELDS("Balance (LCY)");


                EXIT(SavingsAccounts."Balance (LCY)" >= MinDeposits);

            END;

        end;


    end;

    procedure GetMemberQualificationLoanAmount(MemberNo: Code[20]; Product: Code[20]; Var QuaAmt: Decimal; Var LoanBalance: Decimal)
    var
        LProducts: Record "Product Setup";
    begin

        Loans.Reset();
        Loans.SetRange("Member No.", MemberNo);
        Loans.SetRange("Loan Product Type", Product);
        Loans.SetFilter("Total Outstanding Balance", '>0');
        Loans.SetLoadFields("Total Outstanding Balance", "Loan No.");
        Loans.SetAutoCalcFields("Total Outstanding Balance");
        if Loans.FindSet() then
            repeat
                LoanBalance += Loans."Total Outstanding Balance";
            until Loans.Next() = 0;

        QuaAmt := QuaAmt - LoanBalance;

    end;

    procedure CheckViewReportsPermmission(UserID: code[80])
    var
        UserSetup: Record "User Setup";
        Text001: Label 'You do not have permmission to view this report';
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange(Reports, false);
        if UserSetup.FindFirst() then Error(Text001);
    end;

    procedure GFEAutoRecoveryFromDeposits()
    var
        SAactivities: Codeunit "Sacco Activities";
        Template: Code[10];
        Batch: Code[10];
        OfficeTemp: Record "User Setup";
        ClaimLines: Record "BBF Entitlement Lines";
        GeneralSetUp: Record "Sacco SetUp";
        LineNo: Integer;
        MsgOnCompletePosting: Label 'Application No. -%1- successfully posted.';
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        AccType: Integer;
        BBFRequisationLines: Record "BBF Entitlement Header";
        Temp: Record "Banking User Setup";
        Jtemplate: Code[10];
        JBatch: Code[10];
        MsgOnConfirmDialog: Label 'Are you want to Post this Claim?';
        AccTypes: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        DimID: Integer;
        Acc: Code[20];
        SA: Record "Savings Accounts";
        SADepsits: Record "Savings Accounts";
        DocNo: Text[20];
        RunBal: Decimal;
        CurrContrib: Decimal;
        ExpContrib: Decimal;
        PSetup: Record "Product Setup";
        TTotalAmt: Decimal;
    begin
        if Today = CalcDate('CM', Today) then begin
            SADepsits.Reset();
            SADepsits.SetRange("Product Category", SADepsits."Product Category"::"Deposit Contribution");
            if SADepsits.FindFirst() then begin
                TTotalAmt := 0;
                repeat
                    ExpContrib := 0;
                    CurrContrib := 0;
                    RunBal := 0;
                    RunBal := GetAccountBalance(SADepsits."No.");

                    SA.Reset();
                    SA.SetRange("Product Category", SA."Product Category"::"Benevolent Fund");
                    Sa.SetFilter("Date Filter", '%1..%2', CalcDate('-CM', Today), CalcDate('CM', Today));
                    if (SA.FindFirst()) and (RunBal > 0) then begin

                        PSetup.Get(SA."Product Type");
                        ExpContrib := PSetup."Minimum Contribution";
                        CurrContrib := SA."Balance (LCY)";

                        If CurrContrib >= ExpContrib then
                            CurrContrib := 0;

                        if CurrContrib >= RunBal Then CurrContrib := RunBal;

                        DocNo := 'GFE :' + Format(Today);
                        SAactivities.JournalInit(Template, Batch);
                        //Debit Bank
                        SAactivities.JournalInsert(Template, Batch, DocNo, Today, AccTypes::Savings, SADepsits."No.", PadStr(DocNo + ': ' + Sa.Name, 50), BalAcctType::Savings, SA."No.", CurrContrib, '', '', TransType::" ", SA."Global Dimension 1 Code", SA."Global Dimension 2 Code", false, TChannel::" ", DimID);

                        TTotalAmt += CurrContrib;

                    end;
                until SADepsits.Next() = 0;

                if TTotalAmt > 0 then
                    SAactivities.JournalPost(Template, Batch);

            end;
        end;
    end;

    procedure SharesAutoRecoveryFromDeposits(MembNo: Code[20]; PDate: Date; SourceAccount: Option " ",Deposits,FOSA)
    var
        SAactivities: Codeunit "Sacco Activities";
        Template: Code[10];
        Batch: Code[10];
        OfficeTemp: Record "User Setup";
        ClaimLines: Record "BBF Entitlement Lines";
        GeneralSetUp: Record "Sacco SetUp";
        LineNo: Integer;
        MsgOnCompletePosting: Label 'Application No. -%1- successfully posted.';
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        AccType: Integer;
        BBFRequisationLines: Record "BBF Entitlement Header";
        Temp: Record "Banking User Setup";
        Jtemplate: Code[10];
        JBatch: Code[10];
        MsgOnConfirmDialog: Label 'Are you want to Post this Claim?';
        AccTypes: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        DimID: Integer;
        Acc: Code[20];
        SA: Record "Savings Accounts";
        SADepsits: Record "Savings Accounts";
        CurMonthDeposits: Record "Savings Accounts";
        DocNo: Text[20];
        RunBal: Decimal;
        CurrContrib: Decimal;
        ExpContrib: Decimal;
        SaccoSetup: Record "Sacco Setup";
        PSetup: Record "Product Setup";
        TTotalAmt: Decimal;
        Legacy: Codeunit Legacy;
        Members: Record Members;
        Sharecapital: Record "Savings Accounts";
        Class: Record "Member Class";
        UserSetup: Record "User Setup";
        Dim1: Code[20];
        Dim2: Code[20];
    begin
        //if Today = CalcDate('CM', Today) then begin
        SAactivities.GetPaymentJournalTemplate(template, Batch);
        //SAactivities.JournalInit(Template, Batch);
        //ProductType: Option " ",Deposits,FOSA
        SADepsits.Reset();
        SADepsits.SetRange("Member No.", MembNo);
        if SourceAccount = SourceAccount::Deposits then
            SADepsits.SetRange("Product Category", SADepsits."Product Category"::"Deposit Contribution");
        if SourceAccount = SourceAccount::FOSA then
            SADepsits.SetRange("Product Category", SADepsits."Product Category"::"Ordinary Savings");
        //SADepsits.SetFilter("Date Filter", '..%1', PDate);
        SADepsits.SetAutoCalcFields("Balance (LCY)");
        if SADepsits.FindFirst() then begin
            TTotalAmt := 0;
            // repeat
            SaccoSetup.Get();

            ExpContrib := 0;
            CurrContrib := 0;
            RunBal := 0;


            RunBal := SADepsits."Balance (LCY)";
            if RunBal < 0 then
                RunBal := 0;

            Members.Get(SADepsits."Member No.");
            Dim1 := Members."Global Dimension 1 Code";
            Dim2 := Members."Global Dimension 2 Code";
            Class.Get(Members."Member Class");

            if UserSetup.Get(UserId) then;
            if Dim2 = '' then
                Dim2 := UserSetup."Global Dimension 2 Code";

            SA.Reset();
            Sa.SetRange("Member No.", SADepsits."Member No.");
            SA.SetRange("Product Category", SA."Product Category"::"Share Capital");
            //Sa.SetFilter("Date Filter", '%1..%2', CalcDate('-CM', PDate), CalcDate('CM', PDate));
            SA.SetFilter("Balance (LCY)", '<%1', Class."Minimum Share Capital");
            SA.SetAutoCalcFields("Balance (LCY)");
            if (SA.FindFirst()) and (RunBal > 0) then begin

                PSetup.Get(SA."Product Type");


                If CurrContrib >= ExpContrib then
                    CurrContrib := 0;

                ExpContrib := Class."Minimum Share Capital" - SA."Balance (LCY)";
                if ExpContrib < 0 then
                    ExpContrib := 0;

                CurrContrib := ExpContrib;


                if CurrContrib > RunBal Then
                    CurrContrib := RunBal;

                DocNo := 'Shares :' + Format(PDate);

                //Debit Bank
                SAactivities.InsertToMonthlyBuffer(Template, Batch, DocNo, PDate, AccTypes::Savings, SADepsits."No.", PadStr(DocNo + ': ' + Sa.Name, 50), BalAcctType::"G/L Account", '', CurrContrib, '', '', TransType::" ", Dim1, Dim2, false, TChannel::" ", DimID);

                SAactivities.InsertToMonthlyBuffer(Template, Batch, DocNo, PDate, AccTypes::Savings, SA."No.", PadStr(DocNo + ': ' + Sa.Name, 50), BalAcctType::"G/L Account", '', -CurrContrib, '', '', TransType::" ", Dim1, Dim2, false, TChannel::" ", DimID);

                TTotalAmt += CurrContrib;

                //end;
            end;
        end;
    end;

    procedure UnallocatedTransfer(MembNo: Code[20]; PDate: Date; JTemplate: Text[20]; JBatch: Text[20])
    var
        SAactivities: Codeunit "Sacco Activities";
        OfficeTemp: Record "User Setup";
        ClaimLines: Record "BBF Entitlement Lines";
        GeneralSetUp: Record "Sacco SetUp";
        LineNo: Integer;
        MsgOnCompletePosting: Label 'Application No. -%1- successfully posted.';
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        AccType: Integer;
        BBFRequisationLines: Record "BBF Entitlement Header";
        Temp: Record "Banking User Setup";
        MsgOnConfirmDialog: Label 'Are you want to Post this Claim?';
        AccTypes: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        DimID: Integer;
        Acc: Code[20];
        SA: Record "Savings Accounts";
        SADepsits: Record "Savings Accounts";
        CurMonthDeposits: Record "Savings Accounts";
        DocNo: Text[20];
        RunBal: Decimal;
        CurrContrib: Decimal;
        ExpContrib: Decimal;
        SaccoSetup: Record "Sacco Setup";
        PSetup: Record "Product Setup";
        TTotalAmt: Decimal;
        Legacy: Codeunit Legacy;
        Classes: Record "Member Class";
        GenJournalBatch: Record "Gen. Journal Batch";
        Template: Code[20];
        Batch: Code[20];
        DepositAmount: Decimal;
        ShareCapitalAmount: Decimal;
        GFEAmount: Decimal;
        TransferAmount: Decimal;
        Dim1: Code[20];
        Dim2: Code[20];
        UserSetup: Record "User Setup";
        Instructions: Record "Dividend Instructions";
        Loans: Record Loans;
        LSchedule: Record "Loan Repayment Schedule";
        Narration: Text[100];
        LoanOutstanding: Decimal;
        CheckDate: Date;
        ExpectedBal: Decimal;
        CurrentBal: Decimal;
        PrincipalArrears: Decimal;
        InterestArrears: Decimal;
        InsuranceArrears: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        GracePeriod: DateFormula;
        AvailAmt: Decimal;
        StartMonth: Date;
        EndMonth: Date;
        PrincipalRepayment: Decimal;
        InterestRepayment: Decimal;
        InsuranceRepayment: Decimal;
        OpeningRunBal: Decimal;
        TotalTransferred: Decimal;
        FosaAccount: Record "Savings Accounts";
    begin
        if MembNo = '' then
            exit;

        if PDate = 0D then
            PDate := Today;

        StartMonth := CalcDate('-CM', PDate);
        EndMonth := CalcDate('CM', PDate);

        Template := CopyStr(JTemplate, 1, MaxStrLen(Template));
        Batch := CopyStr(JBatch, 1, MaxStrLen(Batch));

        if Template = '' then
            Error('Journal Template must have a value.');
        if Batch = '' then
            Error('Journal Batch must have a value.');

        if UserSetup.Get(UserId) then;

        SADepsits.Reset();
        SADepsits.SetRange("Member No.", MembNo);
        SADepsits.SetRange("Product Category", SADepsits."Product Category"::"Unallocated Fund");
        SADepsits.SetFilter("Balance (LCY)", '>0');
        SADepsits.SetAutoCalcFields("Balance (LCY)");
        if not SADepsits.FindFirst() then
            exit;

        RunBal := SADepsits."Balance (LCY)";
        OpeningRunBal := RunBal;

        if RunBal <= 0 then
            exit;

        Dim1 := SADepsits."Global Dimension 1 Code";
        Dim2 := SADepsits."Global Dimension 2 Code";
        if Dim2 = '' then
            Dim2 := UserSetup."Global Dimension 2 Code";

        SAactivities.GetMonthlyRepayment(MembNo, DepositAmount, ShareCapitalAmount, GFEAmount);

        Loans.Reset();
        Loans.SetCurrentKey("Disbursement Date");
        Loans.SetAscending("Disbursement Date", true);
        Loans.SetRange("Member No.", MembNo);
        Loans.SetRange("Date Filter", 0D, PDate);
        Loans.SetFilter("Total Outstanding Balance", '>0');
        if Loans.FindSet() then
            repeat
                if RunBal <= 0 then
                    RunBal := 0;

                PSetup.Get(Loans."Loan Product Type");

                Loans.CalcFields("Outstanding Insurance", "Outstanding Interest", "Outstanding Principal");

                LSchedule.Reset();
                LSchedule.SetRange("Loan No.", Loans."Loan No.");
                LSchedule.SetRange("Repayment Date", StartMonth, EndMonth);
                if LSchedule.FindFirst() then begin
                    PrincipalRepayment := LSchedule."Monthly Principal";
                end else
                    PrincipalRepayment := Loans."Outstanding Principal";


                TransferAmount := Loans."Outstanding Insurance" - SAactivities.GetJournalLoanCredits(Template, Batch, AccTypes::Credit, Loans."Loan Account", Loans."Loan No.", TransType::"Insurance Paid");
                if TransferAmount < 0 then
                    TransferAmount := 0;
                if TransferAmount > RunBal then
                    TransferAmount := RunBal;
                if TransferAmount > 0 then begin
                    DocNo := 'UNTRANS';
                    Narration := CopyStr(PSetup."USSD Product Name" + ' Insurance Repayment', 1, MaxStrLen(Narration));
                    InsertUnallocatedTransferBufferLine(SAactivities, Template, Batch, CopyStr(DocNo, 1, 20), PDate, SADepsits, AccTypes::Credit, Loans."Loan Account", Narration, TransferAmount, '', Loans."Loan No.", TransType::"Insurance Paid", Dim1, Dim2, DimID);
                    RunBal -= TransferAmount;
                    TotalTransferred += TransferAmount;
                end;

                if RunBal <= 0 then
                    RunBal := 0;

                TransferAmount := Loans."Outstanding Interest" - SAactivities.GetJournalLoanCredits(Template, Batch, AccTypes::Credit, Loans."Loan Account", Loans."Loan No.", TransType::"Interest Paid");
                if TransferAmount < 0 then
                    TransferAmount := 0;
                if TransferAmount > RunBal then
                    TransferAmount := RunBal;
                if TransferAmount > 0 then begin
                    DocNo := 'UNTRANS';
                    Narration := CopyStr(PSetup."USSD Product Name" + ' Interest Repayment', 1, MaxStrLen(Narration));
                    InsertUnallocatedTransferBufferLine(SAactivities, Template, Batch, CopyStr(DocNo, 1, 20), PDate, SADepsits, AccTypes::Credit, Loans."Loan Account", Narration, TransferAmount, '', Loans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, DimID);
                    RunBal -= TransferAmount;
                    TotalTransferred += TransferAmount;
                end;

                if RunBal <= 0 then
                    RunBal := 0;

                TransferAmount := 0;
                if Loans."Outstanding Principal" > 0 then begin
                    TransferAmount := Loans."Loan Principle Repayment";

                    LSchedule.Reset();
                    LSchedule.SetRange("Loan No.", Loans."Loan No.");
                    LSchedule.SetFilter("Repayment Date", '..%1', CalcDate('CM', Today));
                    if LSchedule.FindLast() then
                        TransferAmount := LSchedule."Monthly Principal";

                    if TransferAmount <= 0 then
                        TransferAmount := Loans."Outstanding Principal";

                    if PrincipalRepayment <= 0 then
                        TransferAmount := 0;

                    TransferAmount -= SAactivities.GetJournalLoanCredits(Template, Batch, AccTypes::Credit, Loans."Loan Account", Loans."Loan No.", TransType::"Principal Repayment");
                    if TransferAmount < 0 then
                        TransferAmount := 0;
                    if TransferAmount > Loans."Outstanding Principal" then
                        TransferAmount := Loans."Outstanding Principal";
                end;
                if TransferAmount > RunBal then
                    TransferAmount := RunBal;
                if TransferAmount > 0 then begin
                    DocNo := 'UNTRANS';
                    Narration := CopyStr(PSetup."USSD Product Name" + ' Loan Repayment', 1, MaxStrLen(Narration));
                    InsertUnallocatedTransferBufferLine(SAactivities, Template, Batch, CopyStr(DocNo, 1, 20), PDate, SADepsits, AccTypes::Credit, Loans."Loan Account", Narration, TransferAmount, '', Loans."Loan No.", TransType::"Principal Repayment", Dim1, Dim2, DimID);
                    RunBal -= TransferAmount;
                    TotalTransferred += TransferAmount;
                end;
            until Loans.Next() = 0;

        if (DepositAmount > 0) and (RunBal > 0) then begin
            SA.Reset();
            SA.SetRange("Member No.", MembNo);
            SA.SetRange("Product Category", SA."Product Category"::"Deposit Contribution");
            if SA.FindFirst() then begin
                DepositAmount := SA."Monthly Contribution";

                FosaAccount.Reset();
                FosaAccount.SetRange("No.", SA."No.");
                FosaAccount.SetRange("Date Filter", CalcDate('-CM', PDate), CalcDate('CM', PDate));
                FosaAccount.SetAutoCalcFields("Balance (LCY)");
                FosaAccount.SetLoadFields("Balance (LCY)");
                if FosaAccount.FindFirst() then
                    if FosaAccount."Balance (LCY)" > 0 then
                        DepositAmount -= FosaAccount."Balance (LCY)";

                if DepositAmount < 0 then
                    DepositAmount := 0;

                Narration := CopyStr(StrSubstNo(Format(SA."Product Category")), 1, MaxStrLen(Narration));

                TransferAmount := DepositAmount;
                if TransferAmount > RunBal then
                    TransferAmount := RunBal;

                DocNo := 'UNTRANS';
                InsertUnallocatedTransferBufferLine(SAactivities, Template, Batch, CopyStr(DocNo, 1, 20), PDate, SADepsits, AccTypes::Savings, SA."No.", Narration, TransferAmount, '', '', TransType::" ", Dim1, Dim2, DimID);
                RunBal -= TransferAmount;
                TotalTransferred += TransferAmount;
            end;
        end;

        if (ShareCapitalAmount > 0) and (RunBal > 0) then begin
            Narration := 'Share Capital Contribution';

            SA.Reset();
            SA.SetRange("Member No.", MembNo);
            SA.SetRange("Product Category", SA."Product Category"::"Share Capital");
            if SA.FindFirst() then begin
                TransferAmount := ShareCapitalAmount;
                if TransferAmount > RunBal then
                    TransferAmount := RunBal;

                DocNo := 'UNTRANS';
                InsertUnallocatedTransferBufferLine(SAactivities, Template, Batch, CopyStr(DocNo, 1, 20), PDate, SADepsits, AccTypes::Savings, SA."No.", SA.Name, TransferAmount, '', '', TransType::" ", Dim1, Dim2, DimID);
                RunBal -= TransferAmount;
                TotalTransferred += TransferAmount;
            end;
        end;

        if TotalTransferred <> (OpeningRunBal - RunBal) then
            TotalTransferred := OpeningRunBal - RunBal;

        if TotalTransferred > 0 then
            InsertUnallocatedTransferSourceDebitLine(SAactivities, Template, Batch, 'UNTRANS', PDate, SADepsits, TotalTransferred, Dim1, Dim2, DimID);

        /*  if RunBal > 0 then begin
             SA.Reset();
             SA.SetRange("Member No.", MembNo);
             SA.SetRange("Product Category", SA."Product Category"::"Deposit Contribution");
             if SA.FindFirst() then begin
                 DocNo := 'Deposits :' + Format(PDate);
                 InsertUnallocatedTransferBufferLine(SAactivities, Template, Batch, CopyStr(DocNo, 1, 20), PDate, SADepsits, AccTypes::Savings, SA."No.", SA.Name, RunBal, '', '', TransType::" ", Dim1, Dim2, DimID);
                 RunBal := 0;
             end;
         end; */


    end;

    local procedure InsertUnallocatedTransferBufferLine(SAactivities: Codeunit "Sacco Activities"; JTemplate: Code[20]; JBatch: Code[20]; DocNo: Code[20]; PDate: Date; SourceAccount: Record "Savings Accounts"; TargetAcctType: Enum "Gen. Journal Account Type"; TargetAccountNo: Code[20]; TargetName: Text[100]; Amount: Decimal; ExtDocNo: Code[20]; LoanNo: Code[20]; TransType: Enum "Transaction Type Enum"; Dim1: Code[20]; Dim2: Code[20]; DimID: Integer)
    var
        AccTypes: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        Desc: Text[100];
    begin
        if Amount <= 0 then
            exit;

        Desc := CopyStr(TargetName, 1, MaxStrLen(Desc));

        SAactivities.InsertToMonthlyBuffer(JTemplate, JBatch, DocNo, PDate, TargetAcctType, TargetAccountNo, Desc, BalAcctType::"G/L Account", '', -Amount, ExtDocNo, LoanNo, TransType, Dim1, Dim2, false, TChannel::" ", DimID);
    end;

    local procedure InsertUnallocatedTransferSourceDebitLine(SAactivities: Codeunit "Sacco Activities"; JTemplate: Code[20]; JBatch: Code[20]; DocNo: Code[20]; PDate: Date; SourceAccount: Record "Savings Accounts"; Amount: Decimal; Dim1: Code[20]; Dim2: Code[20]; DimID: Integer)
    var
        AccTypes: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        Desc: Text[100];
    begin
        if Amount <= 0 then
            exit;

        Desc := CopyStr('Unallocated transfer ' + SourceAccount."Member No.", 1, MaxStrLen(Desc));

        SAactivities.InsertToMonthlyBuffer(JTemplate, JBatch, DocNo, PDate, AccTypes::Savings, SourceAccount."No.", Desc, BalAcctType::"G/L Account", '', Amount, '', '', TransType::" ", Dim1, Dim2, false, TChannel::" ", DimID);
    end;

    procedure RegistrationFeeAutoRecoveryFromDeposits(MembNo: Code[20]; PDate: Date; SourceAccount: Option " ",Deposits,FOSA)
    var
        SAactivities: Codeunit "Sacco Activities";
        Template: Code[10];
        Batch: Code[10];
        OfficeTemp: Record "User Setup";
        ClaimLines: Record "BBF Entitlement Lines";
        GeneralSetUp: Record "Sacco SetUp";
        LineNo: Integer;
        MsgOnCompletePosting: Label 'Application No. -%1- successfully posted.';
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        AccType: Integer;
        BBFRequisationLines: Record "BBF Entitlement Header";
        Temp: Record "Banking User Setup";
        Jtemplate: Code[10];
        JBatch: Code[10];
        MsgOnConfirmDialog: Label 'Are you want to Post this Claim?';
        AccTypes: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        DimID: Integer;
        Acc: Code[20];
        SA: Record "Savings Accounts";
        SADepsits: Record "Savings Accounts";
        CurMonthDeposits: Record "Savings Accounts";
        DocNo: Text[20];
        RunBal: Decimal;
        CurrContrib: Decimal;
        ExpContrib: Decimal;
        SaccoSetup: Record "Sacco Setup";
        PSetup: Record "Product Setup";
        TTotalAmt: Decimal;
        Legacy: Codeunit Legacy;
        Classes: Record "Member Class";
        Dim1: Code[20];
        Dim2: Code[20];
        UserSetup: Record "User Setup";
    begin
        //if Today = CalcDate('CM', Today) then begin
        SAactivities.GetPaymentJournalTemplate(template, Batch);
        if UserSetup.Get(UserId) then;

        SADepsits.Reset();
        SADepsits.SetRange("Member No.", MembNo);
        if SourceAccount = SourceAccount::Deposits then
            SADepsits.SetRange("Product Category", SADepsits."Product Category"::"Deposit Contribution");
        if SourceAccount = SourceAccount::FOSA then
            SADepsits.SetRange("Product Category", SADepsits."Product Category"::"Ordinary Savings");
        SADepsits.SetFilter("Balance (LCY)", '>0');
        // SADepsits.SetFilter("Date Filter", '..%1', PDate);
        SADepsits.SetAutoCalcFields("Balance (LCY)");
        if SADepsits.FindFirst() then begin
            TTotalAmt := 0;
            Member.Get(SADepsits."Member No.");
            Dim1 := Member."Global Dimension 1 Code";
            Dim2 := Member."Global Dimension 2 Code";
            if Dim2 = '' then
                Dim2 := UserSetup."Global Dimension 2 Code";

            SaccoSetup.Get();
            Member.Get(SADepsits."Member No.");

            Member.TestField("Member Class");

            Classes.Reset();
            Classes.SetRange("Member Class", Member."Member Class");
            if Classes.FindFirst() then begin
                ExpContrib := 0;
                CurrContrib := 0;
                RunBal := 0;

                if GetAccountBalance(Legacy.GetRegFeeAccount(SADepsits."Member No.")) < Classes."Minimum Registration Fee" then begin

                    RunBal := SADepsits."Balance (LCY)" - Classes."Minimum Registration Fee";
                    if RunBal < 0 then
                        RunBal := 0;

                    SA.Reset();
                    Sa.SetRange("Member No.", SADepsits."Member No.");
                    Sa.SetFilter("Balance (LCY)", '<%1', Classes."Minimum Registration Fee");
                    SA.SetRange("Product Category", SA."Product Category"::"Registration Fee");
                    if (SA.FindFirst()) and (RunBal > 0) then begin

                        SA.CalcFields("Balance (LCY)");

                        ExpContrib := Classes."Minimum Registration Fee" - SA."Balance (LCY)";
                        CurrContrib := ExpContrib;

                        If CurrContrib < 0 then
                            CurrContrib := 0;

                        if CurrContrib >= RunBal Then
                            CurrContrib := RunBal;

                        DocNo := 'REG-FEE :' + Format(PDate);

                        SAactivities.InsertToMonthlyBuffer(Template, Batch, DocNo, PDate, AccTypes::Savings, SADepsits."No.", PadStr(DocNo + ': ' + Sa.Name, 50), BalAcctType::"G/L Account", '', CurrContrib, '', '', TransType::" ", SA."Global Dimension 1 Code", SA."Global Dimension 2 Code", false, TChannel::" ", DimID);
                        SAactivities.InsertToMonthlyBuffer(Template, Batch, DocNo, PDate, AccTypes::Savings, SA."No.", PadStr(DocNo + ': ' + Sa.Name, 50), BalAcctType::"G/L Account", '', -CurrContrib, '', '', TransType::" ", SA."Global Dimension 1 Code", SA."Global Dimension 2 Code", false, TChannel::" ", DimID);

                        TTotalAmt += CurrContrib;

                    end;
                end;
            end;


        end;
    end;


    procedure LedgerFeeRecoveryFromDeposits(AccNo: Code[20]; PDate: Date; Bal: Decimal)
    var
        SAactivities: Codeunit "Sacco Activities";
        Template: Code[10];
        Batch: Code[10];
        OfficeTemp: Record "User Setup";
        ClaimLines: Record "BBF Entitlement Lines";
        GeneralSetUp: Record "Sacco SetUp";
        LineNo: Integer;
        MsgOnCompletePosting: Label 'Application No. -%1- successfully posted.';
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        AccType: Integer;
        BBFRequisationLines: Record "BBF Entitlement Header";
        Temp: Record "Banking User Setup";
        Jtemplate: Code[10];
        JBatch: Code[10];
        MsgOnConfirmDialog: Label 'Are you want to Post this Claim?';
        AccTypes: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        DimID: Integer;
        Acc: Code[20];
        SA: Record "Savings Accounts";
        SADepsits: Record "Savings Accounts";
        CurMonthDeposits: Record "Savings Accounts";
        DocNo: Text[20];
        RunBal: Decimal;
        CurrContrib: Decimal;
        ExpContrib: Decimal;
        SaccoSetup: Record "Sacco Setup";
        PSetup: Record "Product Setup";
        TTotalAmt: Decimal;
        Excise: Decimal;
        Legacy: Codeunit Legacy;
        Classes: Record "Member Class";
        Sledgers: Record "Savings Ledger Entry";
        Dim1: Code[20];
        Dim2: Code[20];
        UserSetup: Record "User Setup";
    begin
        //if Today = CalcDate('CM', Today) then begin
        SaccoSetup.get();
        CurrContrib := 0;
        Excise := 0;
        SAactivities.GetPaymentJournalTemplate(template, Batch);

        SA.Get(AccNo);
        PSetup.Get(SA."Product Type");

        PSetup.TestField("Maintenance Fee [G/L]");
        PSetup.TestField("Monthly Maintenance Fee");

        //if (PSetup."Monthly Maintenance Fee" > Sa."Balance (LCY)") then begin
        DocNo := 'LEDGER FEE :' + Format(PDate);
        Member.Get(SA."Member No.");
        Dim1 := Member."Global Dimension 1 Code";
        Dim2 := Member."Global Dimension 2 Code";

        if UserSetup.Get(UserId) then;
        if Dim2 = '' then
            Dim2 := UserSetup."Global Dimension 2 Code";
        //Bal := GetAccountBalance(Sa."No.");

        Sledgers.Reset();
        Sledgers.SetRange("Account No.", SA."No.");
        Sledgers.SetRange("Document No.", DocNo);
        if not Sledgers.FindFirst() then begin
            if bal > 0 then begin

                CurrContrib := PSetup."Monthly Maintenance Fee";

                If CurrContrib < 0 then
                    CurrContrib := 0;

                if CurrContrib > Bal then
                    CurrContrib := Bal;

                Excise := CurrContrib * SaccoSetup."Excise Duty (%)" / 100;

                //CurrContrib = Excise;

                if Bal <= PSetup."Monthly Maintenance Fee" then
                    CurrContrib -= Excise;

                if CurrContrib > 0 then begin

                    SAactivities.InsertToMonthlyBuffer(Template, Batch, DocNo, PDate, AccTypes::Savings, SA."No.", PadStr(DocNo, 50), BalAcctType::"G/L Account", PSetup."Maintenance Fee [G/L]", CurrContrib, '', '', TransType::" ", Dim1, Dim2, false, TChannel::" ", DimID);

                    SAactivities.InsertToMonthlyBuffer(Template, Batch, DocNo, PDate, AccTypes::Savings, SA."No.", PadStr('Excise duty on ' + DocNo, 50), BalAcctType::"G/L Account", SaccoSetup."Excise Duty GL", Excise, '', '', TransType::" ", Dim1, Dim2, false, TChannel::" ", DimID);
                end;

            end;


        end;
    end;


    procedure ChargePenalty(AccNo: Code[20]; PDate: Date; Bal: Decimal)
    var
        SAactivities: Codeunit "Sacco Activities";
        Template: Code[10];
        Batch: Code[10];
        OfficeTemp: Record "User Setup";
        ClaimLines: Record "BBF Entitlement Lines";
        GeneralSetUp: Record "Sacco SetUp";
        LineNo: Integer;
        MsgOnCompletePosting: Label 'Application No. -%1- successfully posted.';
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        AccType: Integer;
        BBFRequisationLines: Record "BBF Entitlement Header";
        Temp: Record "Banking User Setup";
        Jtemplate: Code[10];
        JBatch: Code[10];
        MsgOnConfirmDialog: Label 'Are you want to Post this Claim?';
        AccTypes: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        DimID: Integer;
        Acc: Code[20];
        SA: Record "Savings Accounts";
        SADepsits: Record "Savings Accounts";
        CurMonthDeposits: Record "Savings Accounts";
        DocNo: Text[20];
        RunBal: Decimal;
        CurrContrib: Decimal;
        ExpContrib: Decimal;
        SaccoSetup: Record "Sacco Setup";
        PSetup: Record "Product Setup";
        TTotalAmt: Decimal;
        Excise: Decimal;
        Legacy: Codeunit Legacy;
        Classes: Record "Member Class";
        Sledgers: Record "Savings Ledger Entry";
    begin
        //if Today = CalcDate('CM', Today) then begin
        SaccoSetup.get();
        SAactivities.GetPaymentJournalTemplate(template, Batch);

        SA.Get(AccNo);
        PSetup.Get(SA."Product Type");
        SA.CalcFields("Balance (LCY)");

        PSetup.TestField("Penalty Fee [G/L]");
        PSetup.TestField("Penalty Fee");

        //if (PSetup."Monthly Maintenance Fee" > Sa."Balance (LCY)") then begin
        DocNo := CopyStr('PENALTY FEE :' + FORMAT(PDate, 0, '<Month Text>'), 1, 20);

        Sledgers.Reset();
        Sledgers.SetRange("Account No.", SA."No.");
        Sledgers.SetRange(Reversed, false);
        Sledgers.SetRange("Document No.", DocNo);
        if not Sledgers.FindFirst() then begin

            CurrContrib := PSetup."Penalty Fee";
            if CurrContrib > 0 then begin

                if CurrContrib > Bal then
                    CurrContrib := Bal;

                If CurrContrib < 0 then
                    CurrContrib := 0;

                Excise := Round(CurrContrib * SaccoSetup."Excise Duty (%)" / 100, 0.01, '<');
                if Excise + CurrContrib > SA."Balance (LCY)" then begin
                    Excise := Round(SA."Balance (LCY)" * SaccoSetup."Excise Duty (%)" / (100 + SaccoSetup."Excise Duty (%)"), 0.01, '<');
                    CurrContrib := SA."Balance (LCY)" - Excise;
                end;



                SAactivities.InsertToMonthlyBuffer(Template, Batch, DocNo, PDate, AccTypes::Savings, SA."No.", PadStr(DocNo + ': ' + SA.Name, 50), BalAcctType::"G/L Account", PSetup."Maintenance Fee [G/L]", CurrContrib, '', '', TransType::" ", SA."Global Dimension 1 Code", SA."Global Dimension 2 Code", false, TChannel::" ", DimID);

                SAactivities.InsertToMonthlyBuffer(Template, Batch, DocNo, PDate, AccTypes::Savings, SA."No.", PadStr('Excise duty on ' + DocNo, 50), BalAcctType::"G/L Account", SaccoSetup."Excise Duty GL", Excise, '', '', TransType::" ", SA."Global Dimension 1 Code", SA."Global Dimension 2 Code", false, TChannel::" ", DimID);
            end;
        end;
    end;

    procedure InterestRecovery(var Loans: Record Loans; PDate: Date)
    var
        SAactivities: Codeunit "Sacco Activities";
        Template: Code[10];
        Batch: Code[10];
        OfficeTemp: Record "User Setup";
        ClaimLines: Record "BBF Entitlement Lines";
        GeneralSetUp: Record "Sacco SetUp";
        LineNo: Integer;
        MsgOnCompletePosting: Label 'Application No. -%1- successfully posted.';
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        AccType: Integer;
        BBFRequisationLines: Record "BBF Entitlement Header";
        Temp: Record "Banking User Setup";
        Jtemplate: Code[10];
        JBatch: Code[10];
        MsgOnConfirmDialog: Label 'Are you want to Post this Claim?';
        AccTypes: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        DimID: Integer;
        Acc: Code[20];
        SA: Record "Savings Accounts";
        SADepsits: Record "Savings Accounts";
        CurMonthDeposits: Record "Savings Accounts";
        DocNo: Text[20];
        RunBal: Decimal;
        CurrContrib: Decimal;
        ExpContrib: Decimal;
        PSetup: Record "Product Setup";
        TTotalAmt: Decimal;
    begin

        //if PDate = CalcDate('CM', PDate) then begin
        SADepsits.Reset();
        SADepsits.SetRange("Member No.", Loans."Member No.");
        SADepsits.SetRange("Product Category", SADepsits."Product Category"::"Deposit Contribution");
        SADepsits.SetFilter("Balance (LCY)", '>0');
        //SADepsits.SetFilter("Date Filter", '..%1', PDate);
        SADepsits.SetAutoCalcFields("Balance (LCY)");
        if SADepsits.FindFirst() then begin
            //repeat
            Loans.CalcFields("Total Arrears");

            ExpContrib := 0;
            CurrContrib := 0;
            RunBal := 0;

            CurMonthDeposits.Reset();
            CurMonthDeposits.SetRange("No.", SADepsits."No.");
            CurMonthDeposits.SetFilter("Date Filter", '%1..%2', CalcDate('-CM', Today), CalcDate('CM', Today));
            CurMonthDeposits.SetAutoCalcFields("Balance (LCY)");
            if CurMonthDeposits.FindFirst() then;

            RunBal := SADepsits."Balance (LCY)" - CurMonthDeposits."Balance (LCY)";

            if RunBal < 0 then
                RunBal := 0;


            if RunBal > 0 then begin

                PSetup.Get(SADepsits."Product Type");
                ExpContrib := SaccoActivities.GetInterestArrears(Loans."Loan No.", CalcDate('-1M+CM', Today));

                If ExpContrib > RunBal then
                    ExpContrib := RunBal;

                DocNo := 'Interest-R :' + Format(PDate);
                SAactivities.JournalInit(template, Batch);
                SAactivities.GetPaymentJournalTemplate(template, Batch);

                //SAactivities.JournalInit(Template, Batch);
                //Debit Bank
                SAactivities.JournalInsert(Template, Batch, DocNo, PDate, AccTypes::Savings, SADepsits."No.", PadStr('Interest Recov' + ':' + SADepsits."Member No." + ' Loan No :' + Loans."Loan No.", 50), BalAcctType::"G/L Account", '', ExpContrib, '', '', TransType::" ", SA."Global Dimension 1 Code", SADepsits."Global Dimension 2 Code", false, TChannel::" ", DimID);

                SAactivities.JournalInsert(Template, Batch, DocNo, PDate, AccTypes::Credit, Loans."Loan Account", PadStr('Interest Recov' + ':' + SADepsits."Member No." + ' Loan No :' + Loans."Loan No.", 50), BalAcctType::"G/L Account", '', -ExpContrib, '', Loans."Loan No.", TransType::"Interest Paid", SADepsits."Global Dimension 1 Code", SA."Global Dimension 2 Code", false, TChannel::" ", DimID);

                TTotalAmt += ExpContrib;

            end;
            //until SADepsits.Next() = 0;

            if TTotalAmt > 0 then
                SAactivities.JournalPost(Template, Batch);

        end;
        //end;
    end;

    procedure CalculateAvailableShares(Savings: Record "Savings Accounts"; var DepAmt: Decimal; var GuaranteedInApplication: Decimal; var Committed: Decimal; var Available: Decimal)
    var
        LRec: Record Loans;
        LoanTopUp: Record "Loan Top Up";
        LoanG: Record "Loan Security";
        ProductSetup: Record "Product Setup";
        SProduct: Record "Product Setup";
        SelfGuaranteedA: Decimal;
        Members: Record Members;
    begin

        Members.Get(Savings."Member No.");

        GenSetUp.Get;

        Savings.CalcFields(Savings."Balance (LCY)");
        DepAmt := Savings."Balance (LCY)";
        Members.CalcFields("Self Guaranteed Amount");

        SelfGuaranteedA := Members."Self Guaranteed Amount";


        if GenSetUp."Guarantors Multiplier" > 0 then
            DepAmt := (Savings."Balance (LCY)" - SelfGuaranteedA) * GenSetUp."Guarantors Multiplier";

        SProduct.Get(Savings."Product Type");

        GuaranteedInApplication := GetMemberCommittedDeposits(Savings."No.", FALSE);
        Committed := GuaranteedInApplication + GetMemberCommittedDeposits(Savings."No.", true);
        Available := DepAmt - Committed;

        //IF Available > DepAmt then
        //  Available := DepAmt;
    end;

    procedure GetFreeShares("AccountNo": Code[20]) FreeShares: Decimal
    var
        MemberAccounts: Record "Savings Accounts";
        LoanSecurity: Record "Loan Security";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Committed: Decimal;
        Available: Decimal;
        MemberActivities: Codeunit "Member Activities";
    begin
        FreeShares := 0;
        MemberAccounts.Reset;
        MemberAccounts.SetRange("Member No.", AccountNo);
        if MemberAccounts.FindFirst then begin
            MemberActivities.CalculateAvailableShares(MemberAccounts, DepAmt, GuaranteedInApplication, Committed, Available);
            FreeShares := Available;
        end;
    end;


    procedure UploadDocument(DocumentNo: Code[20]; SaccoDocTypes: enum "Attachment Document Type"; TableID: Integer)
    var
        DocumentAttachment: Record "Document Attachment";
        PurchasesPayableSetupRec: Record "Purchases & Payables Setup";
        FileManagement: Codeunit "File Management";
        InStream: InStream;
        FileName: Text;
        ExpiryDate: Date;
        MissingFormulaErr: Label 'Document expiry date formulas are not set in Purchases & Payables Setup. Please configure the settings.';
    begin

        if not UploadIntoStream('Select Document', '', '', FileName, InStream) then
            exit;


        DocumentAttachment.Init();
        DocumentAttachment.Validate("Table ID", TableID);
        DocumentAttachment.Validate("No.", DocumentNo);
        DocumentAttachment.Validate("Document Type", SaccoDocTypes);
        DocumentAttachment.Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, 250));
        DocumentAttachment.Validate("File Extension", CopyStr(FileManagement.GetExtension(FileName), 1, 30));
        DocumentAttachment."Document Reference ID".ImportStream(InStream, FileName);

        if DocumentAttachment.Insert(true) then
            Message('Document uploaded successfully.');
    end;

    procedure GetMemberFirstName(MemberName: Text) FirstName: Text
    var
        StrgPos: Integer;
    begin
        StrgPos := StrPos(MemberName, ' ');
        FirstName := CopyStr(MemberName, 1, StrgPos - 1);
    end;
}
