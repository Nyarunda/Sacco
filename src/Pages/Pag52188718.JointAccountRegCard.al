page 50381 "Joint Account Reg. Card"
{
    ApplicationArea = All;
    Caption = 'Joint Account Reg. Card';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Registration";
    SourceTableView = where(Type = const(Member));
    PromotedActionCategories = 'New,Process,Report,Picture & Signature,Approval Requests,Account Signatories & NOK, Default Accounts,Attachment,Reopen Document';


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
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("From Another Sacco"; Rec."From Another Sacco")
                {
                    ApplicationArea = Basic;
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
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Station"; Rec."Checkoff Station")
                {
                    ApplicationArea = Basic;
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
                    Editable = true;
                }
                field("FOSA Signing Instruction Narration"; Rec."Signing Instruction narration")
                {
                    Editable = true;
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
                    field("Member Electoral Zone"; Rec."Member Electoral Zone")
                    {
                        ApplicationArea = Basic;
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
                    Editable = true;
                    /* trigger Onvalidate()
                     begin
                         if "Recruited by Type" = "Recruited by Type"::"Walk In" then
                             WalkinBool := false
                         else
                             WalkinBool := true;
                     end;*/
                }
                field(RecruitedBy; Rec."Recruited By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recruited By';
                    Editable = true;
                    //  Editable = WalkinBool;
                }
                field(RecruitedByName; Rec."Recruited By Name")
                {
                    ApplicationArea = Basic;
                    Editable = true;
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
                    PromotedCategory = category8;
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
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    // Image = NewLotProperties;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = category6;
                    RunObject = Page "Next of Kin App.";
                    RunPageLink = "No." = field("No.");
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    // Image = NewSparkle;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = category6;
                    RunObject = Page "Account Signatories App.";
                    RunPageLink = Code = field("No.");
                }
                action("Create Member")
                {
                    ApplicationArea = Basic;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = New;

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
                    PromotedIsBig = true;
                    PromotedCategory = category7;
                    RunObject = Page "Default Savings Products";
                    RunPageLink = Code = field("No.");
                }
                action("Application Documents")
                {
                    ApplicationArea = Basic;
                    Image = Link;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    RunObject = Page "Application Documents";
                    RunPageLink = "Reference No." = field("No.");
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
                        ApprovalEntries: Page System.Automation."Approval Entries";
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
                    PromotedCategory = Category9;

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
        Rec."Account Category" := Rec."account category"::Joint;
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
        DefaultSavingsProducts: Record "Default Savings Products.";
        JointBool: Boolean;

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
    var
        Allocation: Decimal;
        AccountSign: Record "Account Signatories.";
    begin
        Rec.TestField(Status, Rec.Status::Open);
        Rec.TESTFIELD(Name);

        Rec.TestField("Post Code");
        // TestField(Address);
        Rec.TestField("Mobile Phone No.");
        //TESTFIELD("E-Mail");
        if StrLen(Rec."Mobile Phone No.") < 4 then
            Error('Mobile phone no. required');

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


        AccountSign.Reset;
        AccountSign.SetRange(code, Rec."No.");
        AccountSign.SetFilter(Name, '<>%1', '');
        if AccountSign.FindFirst then begin
            if AccountSign.Count < 2 then
                Error('Signatories MUST be More than 1');

            repeat
                AccountSign.TestField("ID No.");
                AccountSign.TestField(Name);
            until AccountSign.Next() = 0;
        end
        else begin
            Error('Account Signatories not Captured');
        end;


        if Rec."Group No." <> '' then begin
            DefaultSavingsProducts.Reset;
            DefaultSavingsProducts.SetRange(Code, Rec."No.");
            DefaultSavingsProducts.SetRange("Product Category", DefaultSavingsProducts."product category"::"Micro Member Deposit");
            if not DefaultSavingsProducts.FindFirst then
                Error('Kindly Add Micro Member Deposits Product if creating a Micro Member');
        end;
    end;



    var
        MemberAge: Integer;
        WalkinBool: Boolean;
}


