Page 50973 "HR Training Needs Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Training Need';
    SourceTable = "HR Training Needs";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = FieldEditable;

                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field(TrainingCategory; Rec."Training Category")
                {
                    ApplicationArea = Basic;
                }
                field(TrainingType; Rec."Training Type")
                {
                    ApplicationArea = Basic;
                }
                field(TotalCosts; Rec."Total Costs")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(NeedSource; Rec."Need Source")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }

                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }

                field(StartDate; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(EndDate; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(ReAssessmentDate; Rec."Re-Assessment Date")
                {
                    ApplicationArea = Basic;
                }

                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                }
                field(Provider; Rec.Provider)
                {
                    ApplicationArea = Basic;
                }
                field(ProviderName; Rec."Provider Name")
                {
                    ApplicationArea = Basic;
                }
                field(OtherProvider; Rec."Other Provider")
                {
                    ApplicationArea = Basic;
                }

            }
            group(Bonding)
            {
                Caption = 'Bonding';
                Editable = FieldEditable;
                field(BondageRequired; Rec."Bondage Required?")
                {
                    ApplicationArea = Basic;
                }
                field(BondageStartDate; Rec."Bondage Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(BondageDuration; Rec."Bondage Duration")
                {
                    ApplicationArea = Basic;
                }
                field(BondageReleaseDate; Rec."Bondage Release Date")
                {
                    ApplicationArea = Basic;
                }
                field(AllowEarlyExitwithConditionsIfitsaBondedTraining; Rec."Allow Early Exit if Bonded?")
                {
                    ApplicationArea = Basic;
                    Caption = 'Allow Early Exit with Conditions? If its a Bonded Training';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control26; Outlook)
            {
            }
            systempart(Control25; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup23)
            {
                Caption = '&Functions';
                action(TrainingCosts)
                {
                    ApplicationArea = Basic;
                    Caption = 'Training Costs';
                    Image = TaskList;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Training Cost";
                    RunPageLink = "Training ID" = field(Code);
                }
                action(TrainingBondingConditions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Training Bonding Conditions';
                    Image = BOM;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Training Bonding Cond. List";
                    RunPageLink = "Training Bonding Code" = field(Code);
                }
            }
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
                        SaccoSet: Record "Sacco Setup";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin
                        // TestField("Document Attached");
                        VarVariant := Rec;

                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec.Code, 0, Documenttype::"HR Training Needs", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec.Code);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Enum "Custom Document Type";//Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Petty Cash";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec.Code);
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

                        if Rec.Status = Rec.Status::"Pending Approval" then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec.Code);
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Rec.Status := Rec.Status::New;
                            Rec.Modify;
                        end;
                    end;
                }
            }
            group(Functions)
            {
                Caption = 'Functions';
                action(Close)
                {
                    ApplicationArea = Basic;
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm(Txt001, true) = false then exit;
                        Rec.Closed := true;
                    end;
                }
                action("Re-Open")
                {
                    ApplicationArea = Basic;
                    Image = OpenJournal;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm(Txt002, true) = false then exit;
                        Rec.Closed := false;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnInit()
    begin
        UpdateControls;
    end;



    var
        HRTrainingBondingCond: Record "HR Training Bonding Conditions";
        FieldEditable: Boolean;
        Txt001: label 'Do you want to close this training need?';
        Txt002: label 'Do you want to reopen this training need?';
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        HRCodeunit: Codeunit "HR Codeunit.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
        //CustomApprovals: Codeunit UnknownCodeunit39004245;
        OpenApprovalEntriesExist: Boolean;

    local procedure UpdateControls()
    begin
        if Rec.Status = Rec.Status::Approved then begin
            CurrPage.Editable := false;
            FieldEditable := false; // lock fields too
        end else begin
            CurrPage.Editable := true;
            FieldEditable := not Rec.Closed;
        end;
    end;
}

