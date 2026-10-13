
Page 50305 "Bankers Cheq. Application Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Bankers Cheque Application";
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
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(BankersChequeType; Rec."Bankers Cheque Type")
                {
                    ApplicationArea = Basic;
                    Editable = NoOfLives;
                }
                field(BeginingChequeNo; Rec."Begining Cheque No.")
                {
                    ApplicationArea = Basic;
                    Editable = BeginCHNo;
                }
                field(NoofLeaves; Rec."No of Leaves")
                {
                    ApplicationArea = Basic;
                    Editable = NoOfLives;
                }
                field(LeafLimitAmount; Rec."Leaf Limit Amount")
                {
                    ApplicationArea = Basic;
                    Editable = LeafLimit;
                }
                field(BankAccount; Rec."Bank Account")
                {
                    ApplicationArea = Basic;
                    Editable = Bnk;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(ChequeRegisterGenerated; Rec."Cheque Register Generated")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate Cheque Register")
            {
                ApplicationArea = Basic;
                Image = Interaction;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec."Cheque Register Generated" = true then
                        Error('Register already generated');

                    if Rec.Status <> Rec.Status::Approved then
                        Error('The document must be fully approved before proceeding');

                    if Confirm('Are you sure you want to generate bankers cheque register ?', false) = false then
                        exit;

                    i := 0;

                    Bg := Rec."Begining Cheque No.";

                    repeat
                        i := i + 1;

                        BankerR.Init;
                        BankerR."Cheque No." := Bg;
                        BankerR."Application No." := Rec."No.";
                        BankerR."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                        BankerR."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                        BankerR."Bank Account" := Rec."Bank Account";
                        BankerR."Leaf Limit Amount" := Rec."Leaf Limit Amount";
                        BankerR."Bankers Cheque Type" := Rec."Bankers Cheque Type";
                        BankerR.Insert;

                        BankerR.Validate(BankerR."Bank Account");

                        Bg := IncStr(Bg);
                    until i = Rec."No of Leaves";

                    Rec."Cheque Register Generated" := true;
                    Rec.Modify;
                    Message('Register generated successfuly');
                end;
            }
            action("Cheque Register")
            {
                ApplicationArea = Basic;
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Bankers Cheque Register";
                RunPageLink = "Application No." = field("No.");
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

                        VarVariant := Rec;
                        DocumentType := Documenttype::"Bankers Cheque";
                        Message('Documenttype %1', DocumentType);

                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, DocumentType, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
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
                        DocumentType: Enum "Custom Document Type";//Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Collateral Return",CheckOff,"Bankers Cheque";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Bankers Cheque";


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

                        if Rec.Status = Rec.Status::"Pending Approval" then begin
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

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        UpdateControl;
    end;

    trigger OnInit()
    begin
        UpdateControl;
    end;

    var
        i: Integer;
        BankerR: Record "Bankers Cheque Register";
        BeginCHNo: Boolean;
        NoOfLives: Boolean;
        Bnk: Boolean;
        LeafLimit: Boolean;
        DocMustbeOpen: label 'This application request must be open';
        DocMustbePending: label 'This application request must be Pending';
        Bg: Code[10];

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin
    end;

    local procedure UpdateControl()
    begin


        if Rec.Status = Rec.Status::Open then begin
            BeginCHNo := true;
            NoOfLives := true;
            Bnk := true;
            LeafLimit := true;
        end;


        if Rec.Status = Rec.Status::"Pending Approval" then begin
            BeginCHNo := false;
            NoOfLives := false;
            Bnk := false;
            LeafLimit := false;
        end;


        if Rec.Status = Rec.Status::Rejected then begin
            BeginCHNo := false;
            NoOfLives := false;
            Bnk := false;
            LeafLimit := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            BeginCHNo := false;
            NoOfLives := false;
            Bnk := false;
            LeafLimit := false;
        end;
    end;
}

