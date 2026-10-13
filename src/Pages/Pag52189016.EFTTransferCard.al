//namespace CentralDB.CentralDB;

page 50718 "EFT Transfer Card"
{
    ApplicationArea = All;
    Caption = 'EFT/RTGS Transfer Card';
    PageType = Card;
    SourceTable = "EFT Transfer";

    PromotedActionCategories = 'New,Process,Report,Approval Request,Budget';

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
                    Importance = Promoted;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = PostedEdit;

                    trigger OnValidate()
                    begin
                        CurrPage.Update
                    end;
                }
                field(PaymentReleaseDate; Rec."Payment Release Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(PaymentType; Rec."Payment Type")
                {
                    ApplicationArea = Basic;
                    ValuesAllowed = Normal, "Petty Cash", Board, Staff;
                    Visible = False;
                    Editable = PostedEdit;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = PostedEdit;
                }
                field(PayMode; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                    Editable = PostedEdit;
                    trigger OnValidate()
                    var

                    begin
                        TransTypeEditable := false;

                        if Rec."Pay Mode" = Rec."Pay Mode"::EFT then begin
                            TransTypeEditable := true;
                        end;

                        UpdateCard;
                    end;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Caption = 'Transaction Type Charges';
                    ApplicationArea = Basic;
                    Enabled = TransTypeEditable;
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = "Currency CodeEditable";
                    Visible = false;
                }
                field(PayingAccountType; Rec."Paying Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = PayingBank;
                    ValuesAllowed = "Bank Account", "G/L Account";
                }
                field(PayingAccount; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Paying Account';
                    Editable = PostedEdit;
                }
                field(AccountBalance; Rec."Account Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment to';
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = PostedEdit;
                }
                field(OnBehalfOf; Rec."On Behalf Of")
                {
                    ApplicationArea = Basic;
                    Editable = PostedEdit;
                }
                field(PaymentNarration; Rec."Payment Narration")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = PostedEdit;
                }
                field(ChequeType; Rec."Cheque Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    //Editable = StatusEditableapproved;
                    //Editable = ChequeEditable;

                    trigger OnValidate()
                    begin
                        if Rec."Cheque Type" = Rec."cheque type"::"Computer Check" then
                            "Cheque No.Editable" := false
                        else
                            "Cheque No.Editable" := true;
                    end;
                }
                field(TypeofCheque; Rec."Type of Cheque")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(ChequeEFTNo; Rec."Cheque No.")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                    Caption = 'Cheque/EFT No.';

                    trigger OnValidate()
                    begin
                        //check if the cheque has been inserted
                        Rec.TestField("Paying Bank Account");
                        PVHead.Reset;
                        PVHead.SetRange(PVHead."Paying Bank Account", Rec."Paying Bank Account");
                        PVHead.SetRange(PVHead."Pay Mode", PVHead."pay mode"::Cheque);
                        PVHead.SetFilter(PVHead.Status, '<>%1', PVHead.Status::Approved);
                        if PVHead.FindFirst then begin
                            repeat
                                if PVHead."Cheque No." = Rec."Cheque No." then begin
                                    if PVHead."No." <> Rec."No." then begin
                                        Error('The Cheque Number has already been utilised by %1', PVHead."No.");
                                    end;
                                end;
                            until PVHead.Next = 0;
                        end;
                    end;
                }
                /*
                field(Cashier;Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }*/

                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Charges"; Rec."Total Charges")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(TotalPaymentAmount; Rec."Total Payment Amount")
                {
                    ApplicationArea = Basic;
                    Editable = PostedEdit;
                }
                /*field(TotalVATAmount;Rec."Total VAT Amount")
                {
                    ApplicationArea = Basic;
                    Editable = PostedEdit;
                }
                field(TotalVATWithholdingAmount;Rec."Total VAT Withholding Amount")
                {
                    ApplicationArea = Basic;
                    Editable = PostedEdit;
                }
                field(TotalWitholdingTaxAmount;Rec."Total Witholding Tax Amount")
                {
                    ApplicationArea = Basic;
                    Editable = PostedEdit;
                }*/
                field(TotalNetAmount; Rec."Total Net Amount")
                {
                    ApplicationArea = Basic;
                    Editable = PostedEdit;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = PostedEdit;
                }
                field("Document Attached"; Rec."Document Attached")
                {
                    ApplicationArea = Basic;
                    Visible = False;
                }
                field("Document Attached By"; Rec."Document Attached By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                    Editable = PostedEdit;
                }
                field(TimePosted; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                    Editable = PostedEdit;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = PostedEdit;
                }
            }
            part(EFTLines; "EFT Transfer Lines")
            {
                SubPageLink = "Header No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Import Lines")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Import Lines?') then begin
                        Rec.ImportNormalPVLinesFromExcel();
                    end;
                end;
            }
            action("Post Payment")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var

                begin
                    Rec.CheckBalance();
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Confirm('Are you sure you want to Post this EFT?') then begin

                        SaccoActivities.PostEFT(Rec."No.");

                    end;
                    CurrPage.Close();
                end;

            }

            action("Attachment")
            {
                ApplicationArea = Basic;
                Image = Link;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    DMSint: Record "DMS Endpoints";
                begin

                    DMSint.RESET;
                    DMSint.SETRANGE(DMSint."Link Type", DMSint."Link Type"::pv);
                    IF DMSint.FIND('-') THEN BEGIN
                        HYPERLINK(DMSint."Path" + Rec."No.");
                    END;
                end;
            }
            action("Print Schedule")
            {
                ApplicationArea = Basic;
                Image = ElectronicBanking;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Enabled = Rec."Payment Type" = Rec."Payment Type"::Normal;

                trigger OnAction()
                begin
                    //TestField(Status, Status::Approved);

                    PVHead.Reset;
                    PVHead.SetRange("No.", Rec."No.");
                    if PVHead.FindFirst then
                        Report.Run(Report::"Electronic Fund Transfer", true, false, PVHead);

                end;
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
                    begin


                        Rec.TestField("Paying Bank Account");
                        VarVariant := Rec;
                        Rec.CalcFields("Total Payment Amount");

                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", Rec."Total Payment Amount", Documenttype::EFT, Rec."Global Dimension 1 Code", Rec."Shortcut Dimension 2 Code", 0);

                        CurrPage.close()
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
                    PromotedCategory = Category4;

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
                        DocumentType := Documenttype::"Member Changes";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
                        ApprovalTracker.SetRange("Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(RecRef.RecordId);
                    end;
                }
                action(ApproveBatch)
                {
                    ApplicationArea = Basic;
                    Caption = 'ApproveBatch';
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
                        DocumentType := Documenttype::PV;

                        Rec.CheckBalance();

                        If Confirm('Are you sure you want to approve this Batch') then begin
                            Rec.Status := Rec.Status::Approved;
                            Rec.Modify();
                            Message('Approved');

                        end;
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

    trigger OnAfterGetCurrRecord()
    begin
        UpdateCard;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateCard;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."payment type"::Normal
    end;

    trigger OnOpenPage()
    begin
        UpdateCard;
    end;

    var
        PayLine: Record "EFT Line";
        UserSetup: Record "User Setup";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        RecPayTypes: Record "Payment & Receipt Types";
        LineNo: Integer;
        JTemplate: Code[10];
        JBatch: Code[10];
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "EFT Transfer";
        BankAcc: Record "Bank Account";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Enum "Custom Document Type";// Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,Loan,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","MSacco Applications","MSacco PinChange","MSacco PhoneChange","MSacco TransChange",BulkSMS,"Payment Voucher","Petty Cash","Board PV",Imp,Requisition,ImpSurr,Interbank,Receipt,"Staff Claim","Staff Adv",AdvSurr,OT;
        DocPrint: Codeunit "Document-Print";
        CheckLedger: Record "Check Ledger Entry";
        CheckManagement: Codeunit CheckManagement;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        AdjustGenJnl: Codeunit Microsoft.Finance.GeneralLedger.Journal."Adjust Gen. Journal Balance";

        "Cheque No.Editable": Boolean;

        "Payment Release DateEditable": Boolean;

        "Cheque TypeEditable": Boolean;

        "Invoice Currency CodeEditable": Boolean;

        "Currency CodeEditable": Boolean;

        GlobalDimension1CodeEditable: Boolean;

        "Payment NarrationEditable": Boolean;

        ShortcutDimension2CodeEditable: Boolean;

        PayeeEditable: Boolean;

        ShortcutDimension3CodeEditable: Boolean;

        ShortcutDimension4CodeEditable: Boolean;

        DateEditable: Boolean;

        PVLinesEditable: Boolean;
        StatusEditablePending: Boolean;
        PaymodeEditable: Boolean;
        BankEditabl: Boolean;
        OnBehalfEditable: Boolean;
        RespEditabl: Boolean;
        Bank: Record "Bank Account";
        DocNoVisible: Boolean;
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        Commitments: Record Committment;
        StatusEditableApproved: Boolean;
        PayingBank: Boolean;
        SaccoActivities: Codeunit "Sacco Activities";
        TransTypeEditable: Boolean;
        ChequeEditable: Boolean;
        CheckBudgetAvail: Codeunit "Budgetary Control";

        PostedEdit: Boolean;

    local procedure UpdateCard()
    begin

        /* if Rec.Status = Rec.Status::Open then
             CurrPage.Editable := true
         else
             CurrPage.Editable := false;*/

        PostedEdit := true;
        if Rec.Status = Rec.Status::Approved then
            PostedEdit := false;
        if Rec.Posted then
            CurrPage.Editable := false;
    end;
}