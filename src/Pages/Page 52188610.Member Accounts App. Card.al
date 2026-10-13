
Page 50273 "Member Accounts App. Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Accounts Application";
    PromotedActionCategories = 'New,Process,Report,Create Account,Picture,Approval Requests,,Reopen Document';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(MobilePhoneNo; Rec."Mobile Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollStaffNo; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field(GroupNo; Rec."Group No.")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        UpdateControl;
                    end;
                }
                field(ProductName; Rec."Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(ProductCategory; Rec."Product Category")
                {
                    ApplicationArea = Basic;
                }
                field("Repay Mode"; Rec."Repay Mode")
                {
                    ApplicationArea = Basic;
                }
                field(MonthlyContribution; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                }
                field(ReferenceCode; Rec."Reference Code")
                {
                    caption = 'Payment Reference code';
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Gender; Rec.Gender)
                {
                    Visible = false;
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }


                field("FOSA Signing Instruction"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;

                }
                field("FOSA Signing Instruction Narration"; Rec."Signing Instruction Narration")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Date of Registration"; Rec."Date of Registration")
                {
                    ApplicationArea = Basic;
                }
                group("Junior Account")
                {
                    Visible = JuniorBool;
                    field(ChildName; Rec."Child Name")
                    {
                        ApplicationArea = Basic;
                    }
                    field(ChildDateOfBirth; Rec."Child Date Of Birth")
                    {
                        ApplicationArea = Basic;
                        showMandatory = true;
                    }
                    field(ChildAge; Rec."Child Age")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Child Age (Years)';
                        Editable = false;
                    }
                    field(ChildBirthCertNo; Rec."Child Birth Cet. No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Child Birth Certificate No.';
                    }
                    field(ChildGender; Rec.Gender)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Child Gender';
                    }
                }
            }
            group("Other Information")
            {
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }

        }
        area(factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Member Accounts Application"),
                              "No." = field("No.");

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(All)
            {
                action("Picture & Signature")
                {
                    ApplicationArea = Basic;
                    Image = Picture;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Caption = 'Picture';
                    RunObject = Page "Pic & Sign Junior";
                    RunPageLink = "No." = field("No.");
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Image = NewSparkle;
                    Caption = 'Can Transact';
                    RunObject = Page "Account Signatories App.";
                    RunPageLink = Code = field("No.");
                    Promoted = true;
                    PromotedCategory = category5;
                }
                action("Nominee")
                {
                    ApplicationArea = Basic;
                    Image = NewLotProperties;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    PromotedCategory = category5;
                    RunObject = Page "Nominee Application";
                    RunPageLink = "No." = field("No.");
                }
                action("Create Account")
                {
                    ApplicationArea = Basic;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text002: label 'Are you sure you want to convert this application to membership?';
                    begin

                        Rec.TestField("Date of Registration");
                        Rec.TestField(Status, Rec.Status::Approved);

                        if Confirm('Are you sure you want to Create this Account?') then begin
                            MemberActivities.CreateMemberAccount(Rec);
                        end;
                    end;
                }
                action("Application Documents")
                {
                    ApplicationArea = Basic;
                    Image = Link;
                    Promoted = true;
                    visible = false;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;

                    RunObject = Page "Application Documents";
                    RunPageLink = "Reference No." = field("No.");
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
                    PromotedCategory = Category6;

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


                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Savings Application", '', Rec."Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
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
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Enum "Custom Document Type";//Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Savings Application";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
                        ApprovalTracker.SetRange("Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }

            }
            action("Reopen Document")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = category6;

                trigger OnAction()
                begin

                    case Rec.Status of
                        Rec.Status::Approved:
                            Error('This document is already approved.');
                        Rec.Status::Created:
                            Error('This document has already been created.');
                        Rec.Status::Rejected:
                            Error('This document has been rejected and cannot be processed.');
                    end;

                    if not Confirm('Are you sure you want to re-open document?') then exit;
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        UpdateControl;
    end;

    trigger OnAfterGetRecord()
    begin

        UpdateControl;
    end;

    trigger OnOpenPage()
    begin
        UpdateControl;
    end;

    var
        JuniorBool: Boolean;
        UserSetup: Record "User Setup";
        MemberActivities: Codeunit "Member Activities";

    local procedure UpdateControl()
    begin
        JuniorBool := false;

        if Rec."Product Category" = Rec."product category"::"Junior Savings" then begin
            JuniorBool := true;
        end;

        if Rec.Status = Rec.Status::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;
    end;

    local procedure CheckControls()
    var
        ProductSetup: Record "Product Setup";
        GenSetup: Record "Sacco Setup";
    begin
        ProductSetup.Get(Rec."Product Type");
        Rec."Application Date" := Today;
        Rec."Captured By" := UserId;
        Rec.Modify;
        //TestField("Child Birth Cet. No.");
        Rec.TestField("Product Type");
        Rec.TestField("Captured By");
        Rec.TestField("Application Date");
        if Rec."Product Category" = Rec."product category"::"Junior Savings" then begin
            Rec.TestField("Child Date Of Birth");

            GenSetup.Get;

            Rec.CalcFields(Picture, Signature);
            if GenSetup."Member Picture Mandatory" = GenSetup."member picture mandatory"::"Picture & Signature" then begin
                if (not Rec.Picture.Hasvalue) then
                    Error('This Application Does Not Contain a Picture.');
            end;
            if GenSetup."Member Picture Mandatory" = GenSetup."member picture mandatory"::Picture then begin
                if (not Rec.Picture.Hasvalue) then
                    Error('This Application Does Not Contain a Picture');
            end;
            if GenSetup."Member Picture Mandatory" = GenSetup."member picture mandatory"::Signature then begin
                if (not Rec.Signature.Hasvalue) then
                    Error('This Application Does Not Contain a Signature.');
            end;

        end;
        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 2 Code");

        if Rec."Global Dimension 2 Code" <> UserSetup."Global Dimension 2 Code" then begin
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec.Modify;
        end;
    end;
}

