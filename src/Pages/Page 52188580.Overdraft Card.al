
Page 50243 "Overdraft Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Overdraft Header";
    PromotedActionCategories = 'New,Process,Report,Approval Request';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = ODFee;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Accounts List";
                    Editable = AccNo;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RequestedAmount; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Editable = ReqAmount;
                }
                field(ApprovedAmount; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Editable = AppAmount;
                }
                field(OverdraftInterest; Rec."Overdraft Interest %")
                {
                    ApplicationArea = Basic;
                    Editable = ODInt;
                }
                field(EffectiveStartDate; Rec."Effective/Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = EstartDate;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                    Editable = Durationn;
                }
                field(ExpiryDate; Rec."Expiry Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = Remmarks;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = GlobDim1;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = GlobDim2;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(CreatedBy; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field(Expired; Rec.Expired)
                {
                    ApplicationArea = Basic;
                }
                field(Liquidated; Rec.Liquidated)
                {
                    ApplicationArea = Basic;
                }
                field(DateLiquidated; Rec."Date Liquidated")
                {
                    ApplicationArea = Basic;
                }
                field(LiquidatedBy; Rec."Liquidated By")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = RespCenter;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
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
                action(Post)
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        SaccoActivities: Codeunit "Sacco Activities";
                    begin
                        SaccoActivities.PostOverDraft(Rec);
                    end;
                }
                action(Account)
                {
                    ApplicationArea = Basic;
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
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
                    PromotedCategory = category4;

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
                        ApprovalEntry: Record "Approval Entry";
                    begin

                        CheckControls;

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", Rec."Approved Amount", Documenttype::Overdraft, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
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
                    PromotedCategory = category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Enum "Custom Document Type";//Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Collateral Return",CheckOff,"Bankers Cheque",Salary,Overdraft;
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::Overdraft;

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
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
                            CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup."Overdraft Management" then
            Error('You do not have any permissions for Overdraft Processing. Contact the administrator!');
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    var
        AccNo: Boolean;
        ReqAmount: Boolean;
        AppAmount: Boolean;
        ODInt: Boolean;
        EstartDate: Boolean;
        Durationn: Boolean;
        ODFee: Boolean;
        Remmarks: Boolean;
        RespCenter: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        GlobDim1: Boolean;
        GlobDim2: Boolean;
        DocMustbeOpen: label 'This application request must be open';
        DocMustbePending: label 'This application request must be Pending';


    procedure UpdateControl()
    begin




        if Rec.Status = Rec.Status::Open then begin
            AccNo := true;
            ReqAmount := true;
            AppAmount := true;
            ODInt := true;
            EstartDate := true;
            Durationn := true;
            ODFee := true;
            Remmarks := true;
            RespCenter := true;
            GlobDim1 := true;
            GlobDim2 := true;

        end;


        if Rec.Status = Rec.Status::Pending then begin
            AccNo := false;
            ReqAmount := false;
            AppAmount := true;
            ODInt := true;
            EstartDate := true;
            Durationn := true;
            ODFee := true;
            Remmarks := true;
            RespCenter := false;
            GlobDim1 := false;
            GlobDim2 := false;

        end;


        if Rec.Status = Rec.Status::Rejected then begin
            AccNo := false;
            ReqAmount := false;
            AppAmount := false;
            ODInt := false;
            EstartDate := false;
            Durationn := false;
            ODFee := false;
            Remmarks := false;
            RespCenter := false;
            GlobDim1 := false;
            GlobDim2 := false;


        end;

        if Rec.Status = Rec.Status::Approved then begin
            AccNo := false;
            ReqAmount := false;
            AppAmount := false;
            ODInt := false;
            EstartDate := false;
            Durationn := false;
            ODFee := false;
            Remmarks := false;
            RespCenter := false;
            GlobDim1 := false;
            GlobDim2 := false;

        end;
    end;

    local procedure CheckControls()
    begin
        if Rec.Status <> Rec.Status::Open then
            Error(DocMustbeOpen);

        Rec.TestField("Transaction Type");
        Rec.TestField("Account No.");
        Rec.TestField("Effective/Start Date");
        Rec.TestField(Duration);
        Rec.TestField("Expiry Date");
        Rec.TestField("Requested Amount");
        Rec.TestField("Approved Amount");
    end;


}

