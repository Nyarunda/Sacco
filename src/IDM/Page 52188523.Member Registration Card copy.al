
Page 50892 "Member IDM Registration Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Registration";
    SourceTableView = where(Type = const(Member));
    PromotedActionCategories = 'New,Process,Report,Account Signatories & NOK,Picture & Signature,Default Accounts,Approval Requests,Create,Other Options';


    layout
    {
        area(content)
        {

            group(General)
            {
                Caption = 'General';

                Editable = ApplicationDetailsEdit;
                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field("ID Type"; Rec."ID Type")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var

                    begin
                        UpdateFields();
                    end;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = IDNoBool;
                    Enabled = IDNoBool;

                    trigger OnValidate()
                    begin
                        Rec."ID No. IDM Verified" := false;
                        IDMAutoVerify("IDM Verification Type"::"National ID");
                    end;
                }

                field("ID Serial No."; Rec."ID Serial No.")
                {
                    ApplicationArea = All;
                    Caption = 'ID Serial No.';
                    Editable = false;
                    StyleExpr = IDNoVerifiedStyle;
                }
                field(IDNoVerified; Rec."ID No. IDM Verified")
                {
                    ApplicationArea = All;
                    Caption = 'ID Verified';
                    Editable = false;
                    StyleExpr = IDNoVerifiedStyle;
                }
                field(FirstName; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        UpdateName;
                    end;
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        UpdateName;
                    end;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        UpdateName;
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(SalutationCode; Rec."Salutation Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the salutation code that will be used when you interact with the contact. The salutation code is only used in Word documents. To see a list of the salutation codes already defined, click the field.';
                }
                field("From Another Sacco"; Rec."From Another Sacco")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application Date';
                    Editable = false;
                }
                field(OldMemberNo; Rec."Old Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Passport; Rec.Passport)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = PassBool;
                    Enabled = PassBool;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    caption = 'Alien / Passport Expiry Date';
                    ApplicationArea = Basic;
                    ShowMandatory = PassBool;
                    Enabled = PassBool;
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        MemberAge := 0;
                        if Rec."Date of Birth" <> 0D then
                            MemberAge := Date2DMY(Today, 3) - Date2DMY(Rec."Date of Birth", 3);
                    end;
                }
                field(Age; MemberAge)
                {
                    Editable = false;
                    ApplicationArea = Basic;
                }
                field(KRAPIN; Rec."KRA PIN")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."KRA PIN IDM Verified" := false;
                        IDMAutoVerify("IDM Verification Type"::"KRA PIN");
                    end;
                }

                field(KRAPINVerified; Rec."KRA PIN IDM Verified")
                {
                    ApplicationArea = All;
                    Caption = 'KRA Verified';
                    Editable = true;
                    StyleExpr = KRAPINVerifiedStyle;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(MaritalStatus; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field("Self Employed"; Rec."Self Employed")
                {
                    ApplicationArea = Basic;
                    trigger Onvalidate()
                    begin
                        if Rec."Self Employed" then begin
                            Rec."Terms of Employment" := Rec."Terms of Employment"::" ";
                            Rec."Employer Code" := '';
                            Rec."Checkoff Station" := '';
                            Rec."Checkoff Station Name" := '';
                            Rec.Validate("Employer Code");
                        end else begin
                            Rec."Employement Sector" := '';
                        end;
                        UpdateFields();
                    end;
                }

                field("Employement Sector"; Rec."Employement Sector")
                {
                    ApplicationArea = Basic;
                    Editable = EmpSectorBool;
                }

                field(EmployerCode; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = EmpBool;

                    trigger OnValidate()
                    begin
                        /*
                        //VALIDATE("Self Employed");
                        Customer.GET("Employer Code");
                        IF ((Customer."Self Employed"=TRUE) OR (Status<>Status::Open))THEN
                          Empstatus:=FALSE ELSE Empstatus:=TRUE;
                          "Payroll/Staff No.":='';
                        "Terms of Employment":="Terms of Employment"::" ";
                        "Appointment Date":=0D;
                        */

                    end;
                }
                field(EmployerName; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                /*
                field("Employment Section";Rec."Employment Section")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = SelfEmpBool;
                }*/
                field(TermsofEmployment; Rec."Terms of Employment")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = EmpBool;
                }
                field("Level of Employement"; Rec."Level of Employement")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Visible = false;
                    Editable = EmpBool;
                }
                field(PayrollStaffNo; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = EmpBool;

                    trigger OnValidate()
                    begin
                        if Rec."Payroll/Staff No." <> '' then
                            Rec.TESTFIELD("Employer Code");
                    end;
                }
                field("Checkoff Station"; Rec."Checkoff Station")
                {
                    ApplicationArea = Basic;
                    Editable = EmpBool;
                }
                field(MemberCategory; Rec."Member Category")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Member Class"; Rec."Member Class")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Cost Center"; Rec."Cost Center")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field(Locality; Rec.Locality)
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';

                Editable = ApplicationDetailsEdit;
                group(Address)
                {
                    Caption = 'Address';
                    field(PostCode; Rec."Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("P.O. Box"; Rec.Address)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'P.O. Box';
                        ToolTip = 'Specifies the contact''s address.';
                    }
                    field("Physical Address"; Rec."Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Physical Address';
                        ToolTip = 'Specifies additional address information.';
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the city where the contact is located.';
                    }
                    field(CountryRegionCode; Rec."Country/Region Code")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the country/region of the address.';
                    }
                    field("Phone Code"; Rec."Phone Code")
                    {
                        ApplicationArea = Basic, Suite;

                    }
                    field(County; Rec.County)
                    {
                        ApplicationArea = Basic, Suite;
                    }

                }
                group(Personal)
                {
                    field(Residential; Rec.Residential)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }
                group(Diaspora)
                {
                    Visible = Rec.Locality = Rec.Locality::Diaspora;
                    field(State; Rec.State)
                    {
                        ApplicationArea = Basic, Suite;
                        ShowMandatory = true;
                    }
                    field(Country; Rec.Country)
                    {
                        ApplicationArea = Basic, Suite;
                        ShowMandatory = true;
                    }
                    field("Power of attorney remark"; Rec."Power of attorney remark")
                    {
                        ApplicationArea = Basic, Suite;
                        ShowMandatory = true;
                    }
                }

                group(ContactDetails)
                {
                    Caption = 'Contact';
                    field(MobilePhoneNo; Rec."Mobile Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Style = Strong;
                        StyleExpr = true;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the contact''s mobile telephone number.';

                        trigger OnValidate()
                        begin
                            Rec."Phone IDM Verified" := false;
                            IDMAutoVerify("IDM Verification Type"::Phone);
                        end;
                    }

                    field(PhoneVerified; Rec."Phone IDM Verified")
                    {
                        ApplicationArea = All;
                        Caption = 'Phone Verified';
                        Editable = false;
                        StyleExpr = PhoneVerifiedStyle;
                    }
                    field(AlternativePhoneNo; Rec."Alternative Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s phone number.';
                    }
                    field(EMail; Rec."E-Mail")
                    {
                        ApplicationArea = Basic, Suite;
                        ExtendedDatatype = EMail;
                        Importance = Promoted;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the email address of the contact.';
                    }
                    field("Work E-Mail"; Rec."Work E-Mail")
                    {
                        ApplicationArea = Basic, Suite;
                        ExtendedDatatype = EMail;
                        Importance = Promoted;
                        ToolTip = 'Specifies the work email address of the contact.';
                    }
                }
            }
            group("Micro Credit")
            {

                Editable = ApplicationDetailsEdit;
                field(GroupNo; Rec."Group No.")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Group List";
                }
            }
            group("Other Information")
            {

                Editable = ApplicationDetailsEdit;
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field(RelationshipOfficer; Rec."Relationship Officer")
                {
                    ApplicationArea = Basic;
                }
                field(RelationshipOfficerName; Rec."Relationship Officer Name")
                {
                    ApplicationArea = Basic;
                }
                field(BranchManager; Rec."Branch Manager")
                {
                    ApplicationArea = Basic;
                }
                field(BranchManagerName; Rec."Branch Manager Name")
                {
                    ApplicationArea = Basic;
                }
                field(RecruitedbyType; Rec."Recruited by Type")
                {
                    ApplicationArea = Basic;
                    trigger Onvalidate()
                    begin
                        if Rec."Recruited by Type" = Rec."Recruited by Type"::"Walk In" then
                            WalkinBool := false
                        else
                            WalkinBool := true;
                    end;
                }
                field(RecruitedBy; Rec."Recruited By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recruited By';
                    Editable = true;
                    //  Editable = WalkinBool;
                    trigger OnDrillDown()
                    var
                        Member: Record Members;
                    begin
                        if Rec."Recruited by Type" in [Rec."Recruited by Type"::"Board Member", Rec."Recruited by Type"::Member] then begin
                            Member.Reset();
                            Member.SetRange("Member Category", Member."Member Category"::Member);
                            if Rec."Recruited by Type" = Rec."Recruited by Type"::"Board Member" then
                                Member.SetRange("Member Category", Member."Member Category"::"Board Members");
                            if Member.FindFirst() then
                                Page.Run(Page::"Member List", Member);
                        end;
                    end;
                }
                field(RecruitedByName; Rec."Recruited By Name")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Member Electoral Zone"; Rec."Member Electoral Zone")
                {
                    ApplicationArea = basic;
                }
            }
            group("Bank Details")
            {

                Editable = ApplicationDetailsEdit;
                field(BankCode; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(BankName; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field(BranchCode; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field(BranchName; Rec."Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field(BankAccountNo; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Swift Code"; Rec."Swift Code")
                {
                    ApplicationArea = Basic;
                }
                field("Previous Sacco No."; Rec."Previous Sacco No.")
                {
                    ApplicationArea = Basic;
                }
            }




        }


        area(factboxes)
        {
            part(IDMVerificationLogPart; "IDM Verification Log Part")
            {
                ApplicationArea = All;
                Caption = 'IDM Verification History';
                SubPageLink = "API Request ID" = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(All)
            {
                action("Attachment")
                {
                    ApplicationArea = Basic;
                    Image = Link;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        DMSint: Record "DMS Endpoints";
                    begin

                        DMSint.RESET;
                        DMSint.SETRANGE(DMSint."Link Type", DMSint."Link Type"::MemberApp);
                        IF DMSint.FIND('-') THEN BEGIN
                            HYPERLINK(DMSint."Path" + Rec."No.");
                        END;
                    end;
                }

                action("Portal Uploads")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PortalDocs: Record "Portal Uploads";
                    begin
                        PortalDocs.Reset();
                        PortalDocs.SetRange("Member No.", Rec."ID No.");
                        PortalDocs.SetRange("Loan Application No.", Rec."No.");
                        if PortalDocs.FindFirst() then begin
                            Page.Run(Page::"Portal Uploads", PortalDocs);
                        end;

                    end;
                }
                action("Application Documents")
                {
                    ApplicationArea = Basic;
                    Image = Link;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    RunObject = Page "Application Documents";
                    RunPageLink = "Reference No." = field("No.");
                }
                action("Registration Form")
                {
                    ApplicationArea = Basic;
                    Image = Link;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    Visible = false;
                    trigger OnAction()
                    begin
                        Rec.SetFilter("No.", Rec."No.");
                        Report.Run(Report::"Online Membership Application", false, true, rec);
                    end;
                }
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Image = Picture;
                    //Image = NewLotProperties;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Next of Kin App.";
                    RunPageLink = "No." = field("No.");
                }
                action("Nominee")
                {
                    ApplicationArea = Basic;
                    Image = NewLotProperties;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = category4;
                    RunObject = Page "Nominee Application";
                    RunPageLink = "No." = field("No.");
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    //Image = NewSparkle;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = category4;
                    RunObject = Page "Account Signatories App.";
                    RunPageLink = Code = field("No.");
                }
                action("Create Member")
                {
                    ApplicationArea = Basic;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Category8;

                    trigger OnAction()
                    var
                        Text002: label 'Are you sure you want to convert this application to membership?';
                    begin

                        Rec.TestField(Status, Rec.Status::Approved);

                        if Confirm('Are you sure you want to Create this Member?') then begin
                            MemberActivities.CreateMember(Rec);
                        end;
                    end;
                }
                action("Picture & Signature")
                {
                    ApplicationArea = Basic;
                    Image = Picture;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Picture & Signature App.";
                    RunPageLink = "No." = field("No.");
                }
                action("Default Accounts")
                {
                    ApplicationArea = Basic;
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Default Savings Products";
                    RunPageLink = Code = field("No.");
                }
                action("Reset Default Products")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Reset Default Products?') then begin
                            Rec.DefaultAccounts;
                            Message('Done');
                        end;
                    end;
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
                    PromotedCategory = Category7;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Custom Document Type";
                    begin

                        CheckControls;

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Member Application", '', Rec."Global Dimension 2 Code", 0);

                        CurrPage.close()
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Member Application";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
                        ApprovalTracker.SetRange("Custom Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(RecRef.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    begin

                        if not Confirm('Are you sure you want to re-open document?') then exit;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        UpdateFields;

        if Rec."Account Category" = Rec."account category"::Individual then
            JointBool := true
        else
            JointBool := false;
    end;

    trigger OnModifyRecord(): Boolean
    begin

        if Rec."Account Category" = Rec."account category"::Individual then
            JointBool := true
        else
            JointBool := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Member;
        Rec."Account Category" := Rec."Account Category"::Individual;
    end;

    trigger OnOpenPage()
    begin
        UpdateFields;

        if Rec."Account Category" = Rec."account category"::Individual then
            JointBool := true
        else
            JointBool := false;
    end;

    trigger OnAfterGetCurrRecord()
    begin

        UpdateFields;
    end;

    local procedure UpdateFields()
    begin
        if Rec.Status = Rec.Status::Open then begin
            ApplicationDetailsEdit := true;
        end
        else begin
            ApplicationDetailsEdit := false;
        end;

        if Rec."Recruited by Type" = Rec."Recruited by Type"::"Walk In" then
            WalkinBool := false
        else
            WalkinBool := true;

        MemberAge := 0;
        if Rec."Date of Birth" <> 0D then
            MemberAge := Date2DMY(Today, 3) - Date2DMY(Rec."Date of Birth", 3);


        if Rec."Self Employed" then begin
            SelfEmpBool := false;
            EmpSectorBool := true;
            SelfEmpBool := true;
            EmpBool := false;
        end
        else begin
            SelfEmpBool := true;
            EmpSectorBool := false;
            SelfEmpBool := false;
            EmpBool := true;
        end;

        PassBool := True;
        IDNoBool := true;
        DisporaBool := false;
        if (Rec."ID Type" = Rec."ID Type"::"Military ID") or (Rec."ID Type" = Rec."ID Type"::"Alien ID") or (Rec."ID Type" = Rec."ID Type"::"National ID") then begin
            PassBool := False;
            IDNoBool := true;
            DisporaBool := true;
        end else begin
            PassBool := True;
            IDNoBool := False;
            Rec."ID No." := '';
        end;

    end;

    var
        VarVariant: Variant;
        ApplicationDetailsEdit: Boolean;
        UserSetup: Record "User Setup";
        CalwideApprovals: Codeunit "Calwide Approvals";
        GenSetup: Record "Sacco Setup";
        ApprovalTracker: Record "Approval Tracker";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application";
        MemberActivities: Codeunit "Member Activities";
        NextofKin: Record "Next of Kin.";
        NOK: Record "Next of Kin.";
        Nominee: Record Nominee;
        DefaultSavingsProducts: Record "Default Savings Products.";
        JointBool: Boolean;
        PassBool: Boolean;
        IDNoBool: Boolean;
        EmpSectorBool: Boolean;
        SelfEmpBool: Boolean;
        EmpBool: Boolean;
        DisporaBool: Boolean;
    // Add this procedure inside the existing page code
    local procedure CheckIDNumberDuplicates()
    var
        Members: Record Members;
        MemberReg: Record "Member Registration";
        ErrorTxt: Label 'ID Number %1 is already registered to Member %2';
        ErrorTxt2: Label 'ID Number %1 has a pending application with No. %2';
    begin
        if Rec."ID No." <> '' then begin
            // Check Members table
            Members.Reset();
            Members.SetRange("ID No.", Rec."ID No.");
            if Members.FindFirst() then
                Error(ErrorTxt, Rec."ID No.", Members."No.");

            // Check other pending applications
            MemberReg.Reset();
            MemberReg.SetRange("ID No.", Rec."ID No.");
            MemberReg.SetRange(Status, MemberReg.Status::Pending);
            MemberReg.SetFilter("No.", '<>%1', Rec."No.");
            if MemberReg.FindFirst() then
                Error(ErrorTxt2, Rec."ID No.", MemberReg."No.");
        end;
    end;



    local procedure UpdateName()
    begin
        Rec.Name := '';

        // Clear Name before rebuilding
        Rec.Name := '';

        // Validate and append First Name
        if Rec."First Name" <> '' then begin
            if StrLen(Rec."First Name") < 3 then
                Error('First name must be at least 3 characters.');
            Rec.Name += Rec."First Name";
        end;

        // Validate and append Middle Name
        if Rec."Middle Name" <> '' then
            Rec.Name += ' ' + Rec."Middle Name";

        // Validate and append Surname
        if Rec.Surname <> '' then begin
            if StrLen(Rec.Surname) < 3 then
                Error('Surname must be at least 3 characters.');

            Rec.Name += ' ' + Rec.Surname;
        end;
    end;

    procedure CheckControls()
    var
        Allocation: Decimal;
        CountryRegion: Record "Country/Region";
        AccSign: Record "Account Signatories.";
        Default: Record "Default Savings Products.";
    begin
        Rec.TestField(Status, Rec.Status::Open);
        Rec.TestField("Member Class");
        //TESTFIELD("First Name");
        //TESTFIELD(Surname);


        Default.Reset();
        Default.SetRange(Code, Rec."No.");
        //Default.SetRange("Repay Mode", Default."Repay Mode"::" ");
        Default.SetFilter("Monthly Contribution", '>0');
        Default.SetFilter("Product Category", '%1|%2', Default."Product Category"::"Micro Member Deposit", Default."Product Category"::"Deposit Contribution");
        if Default.FindFirst() then
            repeat
                if (Format(Default."Repay Mode") = '0') or (Default."Repay Mode" = Default."Repay Mode"::" ") then
                    Error('No default configuration found for Code %1 with Repay Mode " " and Product Category %2.', Rec."No.", Default."Product Category");
            until Default.Next() = 0;


        if Rec."Account Category" = Rec."Account Category"::Individual then begin

            Rec.TESTFIELD("First Name");
            Rec.TESTFIELD(Surname);
            if Rec."ID Type" <> Rec."ID Type"::Passport then begin
                Rec.TestField("ID No.");
                Rec.TestField("KRA PIN");
            end;

            if Rec."ID Type" = Rec."ID Type"::Passport then
                Rec.TestField(Passport);

            Rec.TestField("Date of Birth");
            Rec.TestField("E-Mail");

            if not Rec."Self Employed" then begin


                //TestField("Employer Code");
                //TestField("Payroll/Staff No.");
                //TestField("Employment Section");
            end;
            // Add this line at the start of the procedure
            CheckIDNumberDuplicates();

            // ...existing code...
            Rec.TestField(Status, Rec.Status::Open);
            Rec.TestField("Member Class");
            // ...rest of existing validation code...

            if Rec.Gender = Rec.Gender::" " then
                Error('Gender must be specified. Please select a valid value.');

        end;

        //TestField("Post Code");
        //TestField(Address);
        Rec.TestField("Country/Region Code");
        CountryRegion.Get(Rec."Country/Region Code");
        Rec.TestField("Mobile Phone No.");
        if StrLen(Rec."Mobile Phone No.") < CountryRegion."Phone No. Length" then
            Error('Mobile Phone no. is required');

        if Rec."Country/Region Code" = 'KE' then
            if (StrLen(Rec."Mobile Phone No.") <> 13) or (CopyStr(Rec."Mobile Phone No.", 1, 4) <> '+254') then
                Error('Invalid MPESA Mobile No.');

        //TESTFIELD("E-Mail");
        Rec.TestField("Captured By");
        Rec.TestField("Application Date");

        UserSetup.Get(UserId);

        if Rec."Global Dimension 2 Code" <> UserSetup."Global Dimension 2 Code" then begin
            UserSetup.TestField("Global Dimension 2 Code");
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec.Modify;
        end;

        GenSetup.Get;

        Rec.CalcFields(Picture, Signature);
        if GenSetup."Member Picture Mandatory" = GenSetup."member picture mandatory"::"Picture & Signature" then begin
            if (not Rec.Picture.Hasvalue) or (not Rec.Signature.Hasvalue) then
                Error('This Application Does Not Contain a Picture or Signature.');
        end;
        if GenSetup."Member Picture Mandatory" = GenSetup."member picture mandatory"::Picture then begin
            if (not Rec.Picture.Hasvalue) then
                Error('This Application Does Not Contain a Picture');
        end;
        if GenSetup."Member Picture Mandatory" = GenSetup."member picture mandatory"::Signature then begin
            if (not Rec.Signature.Hasvalue) then
                Error('This Application Does Not Contain a Signature.');
        end;

        NextofKin.Reset();
        NextofKin.SetRange("No.", Rec."No.");
        NextofKin.Setfilter(Name, '<>%1', '');
        if NextofKin.FindSet() then
            repeat
                NextofKin.TestField("Date of Birth");
                NextofKin.TestField("ID No.");

                if Today < CalcDate(GenSetup."Membership Age", NextofKin."Date of Birth") then
                    Error(
                        'Next of Kin "%1" does not meet the minimum age requirement of %2 years.',
                        NextofKin.Name,
                        GenSetup."Membership Age"
                    );

            until NextofKin.Next() = 0;

        NextofKin.Reset();
        NextofKin.SetRange("No.", Rec."No.");
        NextofKin.SetFilter(Name, '<>%1', '');
        if not NextofKin.FindFirst() then
            if GenSetup."Next of Kin Mandatory" = GenSetup."Next of Kin Mandatory"::Yes then
                Error('Next of Kin information is required but not provided.');

        Nominee.Reset();
        Nominee.SetRange("No.", Rec."No.");
        Nominee.SetFilter(Name, '<>%1', '');
        if not Nominee.FindFirst() then
            if GenSetup."Nominee Mandatory" = GenSetup."Nominee Mandatory"::Yes then
                Error('Nominee information is required but not provided.');

        if Rec."Marital Status" = Rec."Marital Status"::Married then begin
            NOK.Reset();
            NOK.SetRange("No.", Rec."No.");
            NOK.SetRange(Spouse, true);
            if not NOK.FindFirst() then
                Error('Spouse details are required in Next of Kin for married members.');
        end;

        if GenSetup."Kin % Allocation Mandatory" = GenSetup."kin % allocation mandatory"::Yes then begin
            Allocation := 0;

            Nominee.Reset;
            Nominee.SetRange("No.", Rec."No.");
            Nominee.SetFilter(Name, '<>%1', '');
            if Nominee.FindFirst then begin
                Nominee.CalcSums("%Allocation");
                Allocation := Nominee."%Allocation";
            end;

            if Allocation <> 100 then
                Error('Nominee Allocation Must Sum Up to 100');
        end;

        if Rec."Group No." <> '' then begin
            DefaultSavingsProducts.Reset;
            DefaultSavingsProducts.SetRange(Code, Rec."No.");
            DefaultSavingsProducts.SetRange("Product Category", DefaultSavingsProducts."product category"::"Micro Member Deposit");
            if not DefaultSavingsProducts.FindFirst then
                Error('Kindly Add Micro Member Deposits Product if creating a Micro Member');
        end;

        if Rec."Post Code" = '' then
            Error('Post Code is required');

        if Rec.Status = Rec.Status::Created then
            CurrPage.Editable := false;
    end;




    local procedure IDMAutoVerify(VerificationType: Enum "IDM Verification Type")
    var
        IDMSetup: Record "IDM Setup";
    begin
        if not IDMSetup.Get('') then
            exit;
        if not IDMSetup.Enabled then
            exit;

        case VerificationType of
            "IDM Verification Type"::"National ID":
                if not IDMSetup."Auto Verify ID No." then
                    exit;
            "IDM Verification Type"::"KRA PIN":
                if not IDMSetup."Auto Verify KRA PIN" then
                    exit;
            "IDM Verification Type"::Phone:
                if not IDMSetup."Auto Verify Phone" then
                    exit;
        end;

        if VerificationType = "IDM Verification Type"::Phone then
            RunIDMVerify(VerificationType, Rec."ID No.", Rec."Mobile Phone No.")
        else if VerificationType = "IDM Verification Type"::"National ID" then
            RunIDMVerify(VerificationType, Rec."ID No.", '')
        else if VerificationType = "IDM Verification Type"::"KRA PIN" then
            RunIDMVerify(VerificationType, Rec."KRA PIN", '');
    end;

    local procedure RunIDMVerify(VerificationType: Enum "IDM Verification Type"; Identifier: Text; Secondary: Text)
    var
        IDMApi: Codeunit "IDM API Integration";
        IDMLog: Record "IDM Verification Log";
        EntryNo: Integer;
    begin
        case VerificationType of
            "IDM Verification Type"::"National ID":
                EntryNo := IDMApi.VerifyNationalID(Identifier, Rec."No.", Rec."No.");
            "IDM Verification Type"::"Alien ID":
                EntryNo := IDMApi.VerifyAlienID(Identifier, Rec."No.", Rec."No.");
            "IDM Verification Type"::"KRA PIN":
                EntryNo := IDMApi.VerifyKRAPin(Identifier, Rec."No.", Rec."No.");
            "IDM Verification Type"::Phone:
                EntryNo := IDMApi.VerifyPhone(Identifier, Secondary, Rec."No.", Rec."No.");
        end;

        if IDMLog.Get(EntryNo) then begin
            case VerificationType of
                "IDM Verification Type"::"National ID",
                "IDM Verification Type"::"Alien ID":
                    begin
                        Rec."ID No. IDM Verified" := IDMLog.Status = IDMLog.Status::Success;
                        Rec."First Name" := IDMLog."First Name";
                        Rec."Middle Name" := IDMLog."Middle Name";
                        Rec.Surname := IDMLog.Surname;
                        Rec.Name := IDMLog."Full Name";
                        Rec."ID Serial No." := IDMLog."ID Serial No.";
                        Rec."Date of Birth" := IDMLog."Date of Birth";
                        if IDMLog.Gender = 'M' then
                            Rec.Gender := Rec.Gender::Male;
                        if IDMLog.Gender = 'F' then
                            Rec.Gender := Rec.Gender::Female;



                        if IDMLog.Status = IDMLog.Status::Success then
                            Message('✓ ID Verified: %1', IDMLog."Full Name")
                        else
                            Message('Verification result: %1\%2', IDMLog."API Response Status", IDMLog."Error Message");
                    end;
                "IDM Verification Type"::"KRA PIN":
                    begin

                        if IDMLog.Status = IDMLog.Status::Success then
                            Message('✓ KRA PIN Verified: %1', IDMLog."Full Name")
                        else
                            Message('Verification result: %1\%2', IDMLog."API Response Status", IDMLog."Error Message");
                    end;
                "IDM Verification Type"::Phone:
                    begin
                        Rec."Phone IDM Verified" := IDMLog."Phone Matched";
                        if Rec."Phone IDM Verified" then
                            Message('✓ Phone Verified: %1', IDMLog."Additional Info")
                        else
                            Message('Error or Phone Number does not match: %1\%2', IDMLog."API Response Status", IDMLog."Error Message");
                    end;
            end;
            UpdateIDMStyles();
            CurrPage.IDMVerificationLogPart.Page.Update(false);
        end;
    end;

    local procedure UpdateIDMStyles()
    begin
        if Rec."ID No. IDM Verified" then
            IDNoVerifiedStyle := 'Favorable'
        else
            IDNoVerifiedStyle := 'Attention';

        if Rec."KRA PIN IDM Verified" then
            KRAPINVerifiedStyle := 'Favorable'
        else
            KRAPINVerifiedStyle := 'Attention';

        if Rec."Phone IDM Verified" then
            PhoneVerifiedStyle := 'Favorable'
        else
            PhoneVerifiedStyle := 'Attention';
    end;

    var
        MemberAge: Integer;
        IDNoVerifiedStyle: Text;
        KRAPINVerifiedStyle: Text;
        PhoneVerifiedStyle: Text;
        WalkinBool: Boolean;



}

