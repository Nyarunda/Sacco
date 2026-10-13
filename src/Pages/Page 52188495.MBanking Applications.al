
Page 50158 "MBanking Applications"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Send Approval';
    SourceTable = "MBanking Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApplicationType; Rec."Application Type")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationNo; Rec."Application No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(DocumentDate; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Editable = DocDate;
                    Enabled = false;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Accounts List";
                }
                field(CustomerIDNo; Rec."Customer ID No")
                {
                    ApplicationArea = Basic;
                    Editable = True;
                }
                field(CustomerName; Rec."Customer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CountryRegionCode; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic;
                }
                field(PhoneCode; Rec."Phone Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MPESAMobileNo; Rec."MPESA Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        if SkyMbanking.CheckBlackList(Rec."MPESA Mobile No", '', '') then
                            Error('This Member has been blacklisted');
                    end;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                    Editable = Comms;
                }
                field(DateEntered; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TimeEntered; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EnteredBy; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1102755018; "MBanking Lines")
            {
                SubPageLink = "Application No" = field(No);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Activate Mbanking")
                {
                    ApplicationArea = Basic;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Value: Decimal;
                        TotalCharge: Decimal;
                        TotalDuty: Decimal;
                        BankingActivitie: Codeunit "Banking Activities";
                    begin
                        if Rec."App Status" = Rec."app status"::Approved then
                            Error('Application Already Processed');

                        if Rec.Status <> Rec.Status::Approved then
                            Error('This application has not yet been approved');


                        if Confirm('Are you sure you would like to Create the application?') = true then begin

                            ValidateInternationalPhoneNo(Rec."MPESA Mobile No", Rec."Country/Region Code", Rec."Phone Code");

                            /*Account.Reset;
                            Account.SetFilter("No.", '<>%1', "Account No");
                            Account.SetRange("Transactional Mobile No", "MPESA Mobile No");
                            if Account.Find('-') then begin
                                Error('Transactional Phone No. %1 already exists under Account No. %2', "MPESA Mobile No", Account."No.");
                            end;*/


                            MPESAAppDetails.Reset;
                            MPESAAppDetails.SetRange(MPESAAppDetails."Application No", Rec.No);
                            MPESAAppDetails.SetRange(MPESAAppDetails."Account Type", MPESAAppDetails."account type"::Creditor);
                            if MPESAAppDetails.Find('-') then begin
                                repeat
                                    Account.Reset;
                                    Account.SetRange(Account."No.", MPESAAppDetails."Account No.");
                                    if Account.Find('-') then begin


                                        if SkyMbanking.CheckBlackList(Rec."MPESA Mobile No", Account."No.", Account.Name) then
                                            Error('This Member has been blacklisted');


                                        if Rec."Application Type" = Rec."application type"::Initial then begin //Application Type Initial

                                            if Account."Transactional Mobile No" <> Rec."MPESA Mobile No" then begin

                                                if Account."Transactional Mobile No" <> '' then begin
                                                    Error('The FOSA Account No. ' + Account."No." + ' has already been registered for M-Banking.');

                                                end else begin
                                                    Account."Transactional Mobile No" := Rec."MPESA Mobile No";
                                                    Account.Modify;


                                                    Auth.Reset;
                                                    Auth.SetRange("Account No.", Account."No.");
                                                    Auth.SetRange("Mobile No.", Account."Transactional Mobile No");
                                                    if Auth.FindFirst then begin
                                                        SkyMbanking.GenerateNewPin(CopyStr(Account."Transactional Mobile No", 2, 12));
                                                    end
                                                    else begin
                                                        Auth.Init;
                                                        Auth."Mobile No." := Account."Transactional Mobile No";
                                                        Auth."Account No." := Account."No.";
                                                        Auth."User Status" := Auth."user status"::Active;
                                                        Auth.Insert;
                                                        SkyMbanking.GenerateNewPin(CopyStr(Account."Transactional Mobile No", 2, 12));
                                                    end;


                                                    Message('M-Banking activated for Customer ' + Account.Name + '. The Customer will receive a confirmation SMS shortly.');

                                                end;
                                            end
                                            else begin
                                                Error('This telephone no does not Match');
                                            end;

                                        end
                                        else begin // Application Type is change

                                            Account."Transactional Mobile No" := Rec."MPESA Mobile No";
                                            Account.Modify;

                                            Auth.Reset;
                                            Auth.SetRange("Account No.", Account."No.");
                                            Auth.SetRange("Mobile No.", Account."Transactional Mobile No");
                                            if Auth.FindFirst then begin
                                                SkyMbanking.GenerateNewPin(CopyStr(Account."Transactional Mobile No", 2, 12));
                                            end
                                            else begin


                                                Auth.Reset;
                                                Auth.SetRange("Account No.", Account."No.");
                                                if Auth.FindFirst then
                                                    Auth.DeleteAll();

                                                Auth.Init;
                                                Auth."Mobile No." := Account."Transactional Mobile No";
                                                Auth."Account No." := Account."No.";
                                                Auth."User Status" := Auth."user status"::Active;
                                                Auth.Insert;
                                                SkyMbanking.GenerateNewPin(CopyStr(Account."Transactional Mobile No", 2, 12));
                                            end;


                                            Message('M-Banking transactional Mobile No Updated for Customer ' + Account.Name + '.');

                                        end;
                                    end;
                                until MPESAAppDetails.Next = 0;
                            end;



                            Rec."App Status" := Rec."app status"::Approved;
                            Rec."Date Approved" := Today;
                            Rec."Time Approved" := Time;
                            Rec."Approved By" := UserId;
                            Rec.Modify;


                            BankingActivitie.PostMBankingApplicationCharges(Rec);

                            CurrPage.Close();
                        end;
                    end;
                }
                action("Stop Mbanking")
                {
                    ApplicationArea = Basic;
                    Image = VendorBill;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Rec."App Status" = Rec."app status"::Approved then
                            Error('Application Already Processed');

                        if Rec.Status <> Rec.Status::Approved then
                            Error('This application has not yet been approved');


                        if Confirm('Are you sure you would like to Stop the application?') = true then begin
                            Account.Reset;
                            Account.SetRange("No.", Rec."Account No");
                            if Account.Find('-') then begin
                                Account."Transactional Mobile No" := '';
                                Account.Modify();
                            end;


                            MPESAAppDetails.Reset;
                            MPESAAppDetails.SetRange(MPESAAppDetails."Application No", Rec.No);
                            MPESAAppDetails.SetRange(MPESAAppDetails."Account Type", MPESAAppDetails."account type"::Creditor);
                            if MPESAAppDetails.Find('-') then begin
                                repeat
                                    Account.Reset;
                                    Account.SetRange(Account."No.", MPESAAppDetails."Account No.");
                                    if Account.Find('-') then begin

                                        Auth.Reset;
                                        Auth.SetRange("Account No.", Account."No.");
                                        if Auth.FindFirst then begin
                                            Auth.DeleteAll();
                                        end;

                                    end;
                                until MPESAAppDetails.Next = 0;
                            end;


                            Message('Updated');
                            Rec."App Status" := Rec."app status"::Approved;
                            Rec."Date Approved" := Today;
                            Rec."Time Approved" := Time;
                            Rec."Approved By" := UserId;
                            Rec.Modify;

                            CurrPage.Close();
                        end;
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin


                        ValidateInternationalPhoneNo(Rec."MPESA Mobile No", Rec."Country/Region Code", Rec."Phone Code");

                        // Account.Reset;
                        // Account.SetFilter("No.", "Account No");
                        // Account.SetRange("Transactional Mobile No", "MPESA Mobile No");
                        // if Account.Find('-') then begin
                        //     Error('Transactional Phone No. %1 already exists under Account No. %2', "MPESA Mobile No", Account."No.");
                        // end;


                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
        }
        area(processing)
        {
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        CheckControls;
                        UserSetup.Get(UserId);

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec.No, 0, Documenttype::"Mbanking Application", UserSetup."Global Dimension 1 Code", UserSetup."Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec.No);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Collateral Return",CheckOff,"Bankers Cheque",Salary,Overdraft,Imprest,"Imprest Surrender",Teller,"Mbanking Application";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Mbanking Application";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec.No);
                        ApprovalTracker.SetRange("Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin

                        if Rec.Status = Rec.Status::Pending then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec.No);
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                }
                action("Resend Pin")
                {
                    ApplicationArea = Basic;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin


                        if Rec.Status <> Rec.Status::Approved then
                            Error('This application has not yet been approved');


                        if Confirm('Are you sure you would like to Create the application?') = true then begin

                            ValidateInternationalPhoneNo(Rec."MPESA Mobile No", Rec."Country/Region Code", Rec."Phone Code");



                            MPESAAppDetails.Reset;
                            MPESAAppDetails.SetRange(MPESAAppDetails."Application No", Rec.No);
                            MPESAAppDetails.SetRange(MPESAAppDetails."Account Type", MPESAAppDetails."account type"::Creditor);
                            if MPESAAppDetails.Find('-') then begin
                                repeat
                                    Account.Reset;
                                    Account.SetRange(Account."No.", MPESAAppDetails."Account No.");
                                    if Account.Find('-') then begin


                                        if SkyMbanking.CheckBlackList(Rec."MPESA Mobile No", Account."No.", Account.Name) then
                                            Error('This Member has been blacklisted');


                                        if Rec."Application Type" = Rec."application type"::Initial then begin //Application Type Initial

                                            if Account."Transactional Mobile No" = Rec."MPESA Mobile No" then begin

                                                begin
                                                    Account."Transactional Mobile No" := Rec."MPESA Mobile No";
                                                    Account.Modify;


                                                    Auth.Reset;
                                                    Auth.SetRange("Account No.", Account."No.");
                                                    Auth.SetRange("Mobile No.", Account."Transactional Mobile No");
                                                    if Auth.FindFirst then begin
                                                        SkyMbanking.GenerateNewPin(CopyStr(Account."Transactional Mobile No", 2, 12));
                                                    end
                                                    else begin
                                                        Auth.Init;
                                                        Auth."Mobile No." := Account."Transactional Mobile No";
                                                        Auth."Account No." := Account."No.";
                                                        Auth."User Status" := Auth."user status"::Active;
                                                        Auth.Insert;
                                                        SkyMbanking.GenerateNewPin(CopyStr(Account."Transactional Mobile No", 2, 12));
                                                    end;


                                                    Message('M-Banking activated for Customer ' + Account.Name + '. The Customer will receive a confirmation SMS shortly.');

                                                end;
                                            end
                                            else begin
                                                Error('This telephone no does not Match');
                                            end;

                                        end
                                        else begin // Application Type is change

                                            Account."Transactional Mobile No" := Rec."MPESA Mobile No";
                                            Account.Modify;

                                            Auth.Reset;
                                            Auth.SetRange("Account No.", Account."No.");
                                            Auth.SetRange("Mobile No.", Account."Transactional Mobile No");
                                            if Auth.FindFirst then begin
                                                SkyMbanking.GenerateNewPin(CopyStr(Account."Transactional Mobile No", 2, 12));
                                            end
                                            else begin
                                                Auth.Init;
                                                Auth."Mobile No." := Account."Transactional Mobile No";
                                                Auth."Account No." := Account."No.";
                                                Auth."User Status" := Auth."user status"::Active;
                                                Auth.Insert;
                                                SkyMbanking.GenerateNewPin(CopyStr(Account."Transactional Mobile No", 2, 12));
                                            end;


                                            Message('M-Banking transactional Mobile No changed for Customer ' + Account.Name + '.');

                                        end;
                                    end;
                                until MPESAAppDetails.Next = 0;
                            end;



                            Rec."App Status" := Rec."app status"::Approved;
                            Rec."Date Approved" := Today;
                            Rec."Time Approved" := Time;
                            Rec."Approved By" := UserId;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
        UpdateControl();
        Rec."Document Date" := Today;
        if Rec."App Status" = Rec."App Status"::Approved then CurrPage.Editable := false;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if UserId <> Rec."Entered By" then
            Error('You cannot modify document initiated by %1', Rec."Entered By");
    end;

    var
        StrTel: Text[30];
        DocMustbeOpen: label 'This application must be open';
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,ImprestSurrender,"MSacco Applications";
        Account: Record "Savings Accounts";
        Cust: Record Members;
        MPESAAppDetails: Record "MBanking Lines";
        LineNo: Integer;
        Acct: Record "Savings Accounts";
        ATMCharges: Decimal;
        BankCharges: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        BankCode: Code[20];
        PDate: Date;
        RevFromDate: Date;
        //GenLedgerSetup: Record "Sky Transactions";
        MPesaAccount: Code[50];
        MPesaCharges: Decimal;
        MPesaChargesAccount: Code[50];
        MPesaLiabilityAccount: Code[50];
        TotalCharges: Decimal;
        TariffCharges: Decimal;
        DocSNo: Boolean;
        DocDate: Boolean;
        CustID: Boolean;
        CustName: Boolean;
        MpesaNo: Boolean;
        Comms: Boolean;
        WithLimit: Boolean;
        MpesaPagePart: Boolean;
        DocMustbePending: label 'Application must be pending approval';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        Auth: Record "Sky USSD Auth";
        SkyMbanking: Codeunit "Sky Mbanking";
        UserSetup: Record "User Setup";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;


    procedure UpdateControl()
    begin


        if Rec.Status = Rec.Status::Open then begin

            DocSNo := true;
            DocDate := true;
            CustID := true;
            CustName := true;
            MpesaNo := true;
            Comms := true;
            WithLimit := true;

        end;


        if Rec.Status = Rec.Status::Pending then begin

            DocSNo := false;
            DocDate := false;
            CustID := false;
            CustName := false;
            MpesaNo := false;
            Comms := true;
            WithLimit := false;
        end;


        if Rec.Status = Rec.Status::Rejected then begin
            DocSNo := false;
            DocDate := false;
            CustID := false;
            CustName := false;
            MpesaNo := false;
            Comms := true;
            WithLimit := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            DocSNo := false;
            DocDate := false;
            CustID := false;
            CustName := false;
            MpesaNo := false;
            Comms := true;
            WithLimit := false;

        end;
    end;

    local procedure ValidateInternationalPhoneNo(PhoneNo: Text[50]; CountryRegionCode: Code[10]; PhoneCode: Code[20])
    var
        CountryRegion: Record "Country/Region";
        i: Integer;
        CodeLength: Integer;
        PhoneDigit: Text[1];
        TestPhone: Text[50];
    begin
        PhoneNo := DelChr(PhoneNo, '=', ' ');

        if PhoneNo = '' then
            exit;

        if CountryRegionCode = '' then
            Error('Country/Region Code must be selected before entering MPESA Mobile No.');

        CountryRegion.Get(CountryRegionCode);
        CountryRegion.TestField("Phone Code Format");
        CountryRegion.TestField("Mobile Phone. No. Length");
        CodeLength := StrLen(CountryRegion."Phone Code Format");

        if CopyStr(PhoneNo, 1, CodeLength) <> CountryRegion."Phone Code Format" then
            Error('Invalid MPESA Mobile No. Country phone code %1 is required.', CountryRegion."Phone Code Format");

        if (PhoneCode <> '') and (PhoneCode <> CountryRegion."Phone Code Format") then
            Error('Phone Code %1 does not match the selected Country/Region Code %2.', PhoneCode, CountryRegionCode);

        if StrLen(PhoneNo) <> CountryRegion."Mobile Phone. No. Length" then
            Error('Invalid MPESA Mobile No. Length should be %1.', CountryRegion."Mobile Phone. No. Length");

        if PhoneCode = '+254' then
            TestPhone := DelChr(UpperCase(PhoneNo), '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|-|_')
        else
            TestPhone := DelChr(UpperCase(PhoneNo), '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|_');

        if TestPhone <> PhoneNo then
            Error('Invalid MPESA Mobile No. Invalid character detected.');

        for i := 2 to StrLen(PhoneNo) do begin
            PhoneDigit := CopyStr(PhoneNo, i, 1);
            if not (PhoneDigit in ['0' .. '9']) then
                Error('Invalid MPESA Mobile No. Only digits are allowed after the + sign.');
        end;
    end;

    local procedure CheckControls()
    begin

        ValidateInternationalPhoneNo(Rec."MPESA Mobile No", Rec."Country/Region Code", Rec."Phone Code");

        Account.Reset;
        Account.SetFilter("No.", '<>%1', Rec."Account No");
        Account.SetRange("Transactional Mobile No", Rec."MPESA Mobile No");
        if Account.Find('-') then begin
            Error('Transactional Phone No. %1 already exists under Account No. %2', Rec."MPESA Mobile No", Account."No.");
        end;


        if Rec.Status <> Rec.Status::Open then
            Error(DocMustbeOpen);


        Rec.TestField("Customer ID No");
        Rec.TestField("Customer Name");


        if Rec."Application Type" = Rec."application type"::Initial then begin

            Rec.TestField("MPESA Mobile No");



            ValidateInternationalPhoneNo(Rec."MPESA Mobile No", Rec."Country/Region Code", Rec."Phone Code");

            MPESAAppDetails.Reset;
            MPESAAppDetails.SetRange(MPESAAppDetails."Application No", Rec.No);
            if MPESAAppDetails.Find('-') then begin
                Account.Reset;
                Account.SetRange(Account."ID No.", Rec."Customer ID No");
                Account.SetRange(Account."No.", MPESAAppDetails."Account No.");
                if Account.Find('-') then begin

                    Account.Reset;
                    Account.SetRange(Account."Transactional Mobile No", Rec."MPESA Mobile No");
                    Account.SetRange(Account."No.", MPESAAppDetails."Account No.");
                    if Account.Find('-') then begin
                        if Rec."Application Type" = Rec."Application Type"::Initial then
                            Error('Phone No ' + Rec."MPESA Mobile No" + ' already linked to account no ' + MPESAAppDetails."Account No.");
                    end;
                end
                else begin
                    Error('Id number ' + Rec."Customer ID No" + ' does not exist to account no ' + MPESAAppDetails."Account No.");
                end;

            end
            else begin
                Error('Please select the account to link with the telephone No.');
            end;
        end;
    end;


    procedure CreateMBanking(MBanking: Record "MBanking Applications")
    var
        StrTel: Text[30];
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,ImprestSurrender,"MSacco Applications";
        Account: Record "Savings Accounts";
        Cust: Record Members;
        MPESAAppDetails: Record "MBanking Lines";
        LineNo: Integer;
        Acct: Record "Savings Accounts";
        ATMCharges: Decimal;
        BankCharges: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        BankCode: Code[20];
        PDate: Date;
        RevFromDate: Date;
        //GenLedgerSetup: Record "Sky Transactions";
        MPesaAccount: Code[50];
        MPesaCharges: Decimal;
        MPesaChargesAccount: Code[50];
        MPesaLiabilityAccount: Code[50];
        TotalCharges: Decimal;
        TariffCharges: Decimal;
        DocSNo: Boolean;
        DocDate: Boolean;
        CustID: Boolean;
        CustName: Boolean;
        MpesaNo: Boolean;
        Comms: Boolean;
        WithLimit: Boolean;
        MpesaPagePart: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        Auth: Record "Sky USSD Auth";
        SkyMbanking: Codeunit "Sky Mbanking";
        UserSetup: Record "User Setup";
    begin
        if MBanking."App Status" = MBanking."app status"::Approved then
            Error('Application Already Processed');

        if Rec.Status <> Rec.Status::Approved then
            Error('This application has not yet been approved');


        if Confirm('Are you sure you would like to Create the application?') = true then begin

            ValidateInternationalPhoneNo(MBanking."MPESA Mobile No", MBanking."Country/Region Code", MBanking."Phone Code");

            Account.Reset;
            Account.SetRange("Transactional Mobile No", MBanking."MPESA Mobile No");
            if Account.Find('-') then begin
                Error('Transactional Phone No. %1 already exists under Account No. %2', MBanking."MPESA Mobile No", Account."No.");
            end;


            MPESAAppDetails.Reset;
            MPESAAppDetails.SetRange(MPESAAppDetails."Application No", MBanking.No);
            MPESAAppDetails.SetRange(MPESAAppDetails."Account Type", MPESAAppDetails."account type"::Creditor);
            if MPESAAppDetails.Find('-') then begin
                repeat
                    Account.Reset;
                    Account.SetRange(Account."No.", MPESAAppDetails."Account No.");
                    if Account.Find('-') then begin


                        if SkyMbanking.CheckBlackList(MBanking."MPESA Mobile No", Account."No.", Account.Name) then
                            Error('This Member has been blacklisted');


                        if MBanking."Application Type" = MBanking."application type"::Initial then begin //Application Type Initial

                            if Account."Transactional Mobile No" <> MBanking."MPESA Mobile No" then begin

                                if Account."Transactional Mobile No" <> '' then begin
                                    Error('The FOSA Account No. ' + Account."No." + ' has already been registered for M-Banking.');

                                end else begin
                                    Account."Transactional Mobile No" := MBanking."MPESA Mobile No";
                                    Account.Modify;


                                    Auth.Reset;
                                    Auth.SetRange("Account No.", Account."No.");
                                    Auth.SetRange("Mobile No.", Account."Transactional Mobile No");
                                    if Auth.FindFirst then begin
                                        SkyMbanking.GenerateNewPin(CopyStr(Account."Transactional Mobile No", 2, 12));
                                    end
                                    else begin
                                        Auth.Init;
                                        Auth."Mobile No." := Account."Transactional Mobile No";
                                        Auth."Account No." := Account."No.";
                                        Auth."User Status" := Auth."user status"::Active;
                                        Auth.Insert;
                                        SkyMbanking.GenerateNewPin(CopyStr(Account."Transactional Mobile No", 2, 12));
                                    end;


                                    Message('M-Banking activated for Customer ' + Account.Name + '. The Customer will receive a confirmation SMS shortly.');

                                end;
                            end
                            else begin
                                Error('This telephone no does not Match');
                            end;

                        end
                        else begin // Application Type is change

                            Account."Transactional Mobile No" := MBanking."MPESA Mobile No";
                            Account.Modify;

                            Auth.Reset;
                            Auth.SetRange("Account No.", Account."No.");
                            Auth.SetRange("Mobile No.", Account."Transactional Mobile No");
                            if Auth.FindFirst then begin
                                SkyMbanking.GenerateNewPin(CopyStr(Account."Transactional Mobile No", 2, 12));
                            end
                            else begin
                                Auth.Init;
                                Auth."Mobile No." := Account."Transactional Mobile No";
                                Auth."Account No." := Account."No.";
                                Auth."User Status" := Auth."user status"::Active;
                                Auth.Insert;
                                SkyMbanking.GenerateNewPin(CopyStr(Account."Transactional Mobile No", 2, 12));
                            end;


                            Message('M-Banking transactional Mobile No changed for Customer ' + Account.Name + '.');

                        end;
                    end;
                until MPESAAppDetails.Next = 0;
            end;



            MBanking."App Status" := MBanking."app status"::Approved;
            MBanking."Date Approved" := Today;
            MBanking."Time Approved" := Time;
            MBanking."Approved By" := UserId;
            MBanking.Modify;
        end;
    end;
}

