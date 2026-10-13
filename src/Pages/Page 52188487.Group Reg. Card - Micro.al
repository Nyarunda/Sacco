
Page 50150 "Group Reg. Card - Micro"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Registration";
    SourceTableView = where(Type = filter(Group));
    PromotedActionCategories = 'New,Process,Report,Picture & Signature,Approval Requests,Others,Create Member,Default Accounts,Reopen Document,Account Signatories,Application Documents';

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


                field("Date of Group Reg."; Rec."Date of Bus. Reg.")
                {
                    ApplicationArea = Basic;
                }
                field("Group Physical Location"; Rec."Business/Group Location")
                {
                    ApplicationArea = Basic;
                }
                field("Group Plot/Bldg/Street/Road"; Rec."Plot/Bldg/Street/Road")
                {
                    ApplicationArea = Basic;
                }

                field(BusinessRegNo; Rec."Business Reg. No.")
                {
                    ApplicationArea = Basic;
                }

                field(KRAPIN; Rec."KRA PIN")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Day"; Rec."Meeting Day")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Location"; Rec."Meeting Location")
                {
                    ApplicationArea = Basic;
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

                field("FOSA Signing Instruction"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("FOSA Signing Instruction Narration"; Rec."Signing Instruction Narration")
                {
                    ApplicationArea = Basic;
                    Editable = true;
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
                    Editable = true;
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
                    //Editable = WalkinBool;
                }
                field(RecruitedByName; Rec."Recruited By Name")
                {
                    ApplicationArea = Basic;
                    Editable = true;
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
                    PromotedCategory = Category10;
                    RunObject = Page "Account Signatories App.";
                    RunPageLink = Code = field("No.");
                }

                action("Create Member")
                {
                    ApplicationArea = Basic;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = category7;

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
                action("Default Accounts")
                {
                    ApplicationArea = Basic;
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = category8;
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
                    PromotedCategory = Category5;

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
        Rec."Group Section" := Rec."group section"::"Micro Group";
        Rec."Account Category" := Rec."account category"::MicroGroup;
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
        WalkinBool: Boolean;
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
        Default: Record "Default Savings Products.";
    begin

        //if "Group Category" = "group category"::" " then
        //  Error('Group Category MUST be Captured');

        //if "Group Category" = "group category"::"Non-Incorporated" then begin
        //  if "Group Type" = "group type"::" " then
        //    Error('Group Category MUST be Captured');
        // TestField("Date of Bus. Reg.");

        //end;
        if (not Rec."Self Employed") and (Rec."Group Section" = Rec."Group Section"::"Micro Group") then begin
            Default.Reset();
            Default.SetRange(Code, Rec."No.");
            Default.SetRange("Repay Mode", Default."Repay Mode"::" ");
            Default.SetFilter("Product Category", '%1|%2', Default."Product Category"::"Micro Group Deposit", Default."Product Category"::"Deposit Contribution");
            if not Default.FindFirst() then
                Error('No default configuration found for Code %1 with Repay Mode " " and Product Category %2.', Rec."No.", Default."Product Category");
        end;

        if Rec."Group Category" = Rec."group category"::Incorporated then begin
            Rec.TestField("Date of Bus. Reg.");
            Rec.TestField("Business Reg. No.");
            Rec.TestField("Incorporation No.");

        end;
        Rec.TestField(Status, Rec.Status::Open);
        Rec.TestField(Name);
        ///TestField("KRA PIN");


        //TestField("Post Code");
        //TestField(Address);
        Rec.TestField("Mobile Phone No.");
        //TestField("E-Mail");
        Rec.TestField("Captured By");
        Rec.TestField("Application Date");
        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 2 Code");

        if Rec."Global Dimension 2 Code" <> UserSetup."Global Dimension 2 Code" then begin
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec.Modify;
        end;

        GenSetup.Get;

        Rec.CalcFields(Rec.Picture, Rec.Signature);


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

        if Rec.Status = Rec.Status::Created then
            CurrPage.Editable := false;
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

        if Rec.Status = Rec.Status::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;


        if Rec.Status = Rec.Status::Open then
            ApplicationDetailsEdit := true
        else
            ApplicationDetailsEdit := false;



    end;


}

