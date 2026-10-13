
Page 50152 "Business Registration Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Registration";
    PromotedActionCategories = 'New,Process,Report,Picture & Signature,Approval Requests,Others,Create Member,Default Accounts,Reopen Document,Account Signatories,Application Documents';
    SourceTableView = where(Type = filter(Group),
                            "Account Category" = const(Business));


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application Date';
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(TypeofBusiness; Rec."Type of Business")
                {
                    ApplicationArea = Basic;
                }
                field(OtherTypeOfBusiness; Rec."Other Type Of Business")
                {
                    ApplicationArea = Basic;
                }
                field("Group Category"; Rec."Group Category")
                {
                    ApplicationArea = Basic;
                }

                field(BusinessRegNo; Rec."Business Reg. No.")
                {
                    ApplicationArea = Basic;
                }
                field(DateofBusReg; Rec."Date of Bus. Reg.")
                {
                    ApplicationArea = Basic;
                }
                field("Business Physical Location"; Rec."Business/Group Location")
                {
                    ApplicationArea = Basic;
                }
                field("Business Plot/Bldg/Street/Road"; Rec."Plot/Bldg/Street/Road")
                {
                    ApplicationArea = Basic;
                }

                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(KRAPIN; Rec."KRA PIN")
                {
                    ApplicationArea = Basic;
                }
                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Trading As"; Rec."Trading As")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Station"; Rec."Checkoff Station")
                {
                    ApplicationArea = Basic;
                    //Editable = EmpBool;
                }
                field(EmployerCode; Rec."Employer Code")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                    end;
                }
                field(EmployerName; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("FOSA Signing Instruction"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;

                }
                field("FOSA Signing Instruction Narration"; Rec."Signing Instruction Narration")
                {
                    ApplicationArea = Basic;

                }

            }
            group(Communication)
            {
                Caption = 'Communication';
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
                    field(County; Rec.County)
                    {
                        ApplicationArea = Basic, Suite;

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
                        ToolTip = 'Specifies the contact''s mobile telephone number.';
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
                        ToolTip = 'Specifies the email address of the contact.';
                    }
                }
            }

            group("Other Information")
            {

                //Editable = ApplicationDetailsEdit;
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
                    Editable = true;
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
                    Editable = WalkinBool;
                }
                field(RecruitedByName; Rec."Recruited By Name")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bank Details")
            {
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
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(All)
            {
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Image = NewSparkle;
                    Promoted = true;
                    PromotedCategory = category10;
                    RunObject = Page "Account Signatories App.";
                    RunPageLink = Code = field("No.");
                }
                action("Application Documents")
                {
                    ApplicationArea = Basic;
                    Image = Link;
                    Promoted = true;
                    PromotedCategory = Category11;
                    PromotedIsBig = true;
                    RunObject = Page "Application Documents";
                    RunPageLink = "Reference No." = field("No.");
                }
                action("Create Member")
                {
                    ApplicationArea = Basic;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Category7;

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
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Picture & Signature App.";
                    RunPageLink = "No." = field("No.");
                }
                action("Default Accounts")
                {
                    ApplicationArea = Basic;
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedCategory = category8;
                    PromotedIsBig = true;
                    RunObject = Page "Default Savings Products";
                    RunPageLink = Code = field("No.");
                }
                action("Reset Default Products")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = category8;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Reset Default Products?') then begin
                            Rec.DefaultAccounts;
                            Message('Done');
                        end;
                    end;
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
                        //Rec.SetFilter("No.", Rec."No.");
                        Report.Run(Report::"Online Membership Application", false, true, rec);
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
                    PromotedCategory = category5;

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
                    PromotedCategory = category5;

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
                    PromotedCategory = category5;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocType := Doctype::"Member Application";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
                        ApprovalTracker.SetRange("Document Type", DocType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = category9;

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

    trigger OnAfterGetCurrRecord()
    begin

        UpdateControls;
    end;

    trigger OnAfterGetRecord()
    begin

        if Rec.Status = Rec.Status::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;


        UpdateControls;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Group;
        Rec."Group Account" := true;
        Rec."Group Section" := Rec."group section"::"Other Groups";
        Rec."Account Category" := Rec."account category"::Business;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;

        UpdateControls;
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
        IncorporatedEdit: Boolean;
        NonIncorporatedEdit: Boolean;
        WalkinBool: Boolean;
        CountryRegion: Record "Country/Region";
        AccSign: Record "Account Signatories.";


    local procedure UpdateName()
    begin
        Rec.Name := '';

        if (Rec."First Name" <> '') then
            Rec.Name += Rec."First Name";

        if (Rec."Middle Name" <> '') then
            Rec.Name += ' ' + Rec."Middle Name";

        if (Rec.Surname <> '') then
            Rec.Name += ' ' + Rec.Surname;
    end;


    procedure CheckControls()
    begin

        if Rec."Group Category" = Rec."group category"::" " then
            Error('Group Category MUST be Captured');

        Rec.TestField("Date of Bus. Reg.");
        Rec.TestField("Business Reg. No.");


        Rec.TestField(Status, Rec.Status::Open);
        Rec.TestField(Name);
        Rec.TestField("KRA PIN");
        Rec.TestField("Member Class");

        AccSign.Reset();
        AccSign.SetRange(Code, Rec."No.");
        if Not AccSign.FindFirst() then
            Error('Account signatory missing');

        //TestField("Post Code");
        //TestField(Address);
        CountryRegion.Get(Rec."Country/Region Code");
        CountryRegion.TestField("Phone Code Format");
        CountryRegion.TestField("Phone No. Length");
        if StrLen(Rec."Mobile Phone No.") < CountryRegion."Phone No. Length" then
            Error('Invalid Phone No. Length should be %1', CountryRegion."Phone No. Length");



        //TestField("Post Code");
        //TestField(Address);
        Rec.TestField("Mobile Phone No.");
        Rec.TestField("E-Mail");
        Rec.TestField("Captured By");
        Rec.TestField("Application Date");
        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 2 Code");

        if Rec."Global Dimension 2 Code" <> UserSetup."Global Dimension 2 Code" then begin
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec.Modify;
        end;

        GenSetup.Get;

        Rec.CalcFields(Picture, Signature);
        Rec.TestField("Group Category");


        if GenSetup."Group Picture Mandatory" = GenSetup."group picture mandatory"::"Picture & Signature" then begin
            if (not Rec.Picture.Hasvalue) or (not Rec.Signature.Hasvalue) then
                Error('This Application Does Not Contain a Picture or Signature.');
        end;
        if GenSetup."Group Picture Mandatory" = GenSetup."group picture mandatory"::Picture then begin
            if (not Rec.Picture.Hasvalue) then
                Error('This Application Does Not Contain a Picture');
        end;
        if GenSetup."Group Picture Mandatory" = GenSetup."group picture mandatory"::Signature then begin
            if (not Rec.Signature.Hasvalue) then
                Error('This Application Does Not Contain a Signature.');
        end;
    end;

    local procedure UpdateControls()
    begin
        NonIncorporatedEdit := false;
        IncorporatedEdit := false;

        if Rec."Group Category" = Rec."group category"::"Non-Incorporated" then begin
            NonIncorporatedEdit := true;
        end;
        if Rec."Group Category" = Rec."group category"::Incorporated then begin
            IncorporatedEdit := true;
        end;

        if Rec.Status = Rec.Status::Created then
            CurrPage.Editable := false;
    end;



}

