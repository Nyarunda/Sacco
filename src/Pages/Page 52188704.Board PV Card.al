
Page 50367 "Board PV Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Payment Header";
    PromotedActionCategories = 'New,Process,Report,Approval Request,CheckBudget';

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

                    trigger OnValidate()
                    begin
                        CurrPage.Update
                    end;
                }
                field(PaymentReleaseDate; Rec."Payment Release Date")
                {
                    ApplicationArea = Basic;
                }
                field("Send SMS"; Rec."Send SMS")
                {
                    ApplicationArea = Basic;
                }
                field(PaymentType; Rec."Payment Type")
                {
                    ApplicationArea = Basic;
                    ValuesAllowed = Normal, "Petty Cash", Board, Staff;
                    Visible = False;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(PayMode; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec."Account No." := '';
                        if Rec."Pay Mode" = Rec."Pay Mode"::Cash then
                            Rec.Validate("Paying Account Type", Rec."Paying Account Type"::"Bank Account");
                        if Rec."Pay Mode" = Rec."Pay Mode"::"Fosa Account" then
                            Rec.Validate("Paying Account Type", Rec."Paying Account Type"::"G/L Account");
                    end;
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
                    // Editable = PayingBank;
                    ValuesAllowed = "Bank Account", "G/L Account";
                }
                field(PayingAccount; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic;
                    // Enabled = Rec."Paying Account Type" = Rec."Paying Account Type"::"Bank Account";
                    Caption = 'Paying Account';
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
                    Editable = true;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(OnBehalfOf; Rec."On Behalf Of")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(PaymentNarration; Rec."Payment Narration")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(ChequeType; Rec."Cheque Type")
                {
                    ApplicationArea = Basic;
                    Editable = StatusEditableapproved;

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
                }
                field(ChequeEFTNo; Rec."Cheque No.")
                {
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
                field("Invoice Number"; Rec."Invoice Number")
                {
                    ApplicationArea = basic;
                    Visible = false;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = basic;
                    Visible = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(TotalPaymentAmount; Rec."Total Payment Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TotalVATAmount; Rec."Total VAT Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TotalVATWithholdingAmount; Rec."Total VAT Withholding Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TotalWitholdingTaxAmount; Rec."Total Witholding Tax Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TotalNetAmount; Rec."Total Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document Attached"; Rec."Document Attached")
                {
                    ApplicationArea = Basic;
                }
                field("Document Attached By"; Rec."Document Attached By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(TimePosted; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
            }
            part(BoardPVLines; "Board PV Line")
            {
                ApplicationArea = all;
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
                begin
                    if Confirm('Are you sure you want to Post this PV?') then begin
                        Rec.TestField(Posted, false);
                        SaccoActivities.PostBoardPV(Rec."No.");

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
            action(Print)
            {
                ApplicationArea = Basic;
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //TestField(Status, Status::Approved);

                    PVHead.Reset;
                    PVHead.SetRange("No.", Rec."No.");
                    if PVHead.FindFirst then
                        Report.Run(Report::"Board Payment Voucher", true, false, PVHead);
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
                        //TestField("Document Attached");
                        Rec.Testfield(Posted, false);
                        Rec.Testfield("Payment Narration");
                        VarVariant := Rec;
                        Rec.CalcFields("Total Payment Amount");
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", Rec."Total Net Amount", Documenttype::PV, Rec."Global Dimension 1 Code", Rec."Shortcut Dimension 2 Code", 0);
                        CurrPage.Close();
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
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::PV;


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

                            CurrPage.Close();
                        end;
                    end;
                }
                action("Reset Release Date")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var

                    begin

                        if not Confirm('Are you sure you want to re-set release date for this document?') then
                            exit;

                        Rec."Payment Release Date" := Today();
                        Rec.Modify;
                    end;
                }
            }
            group(CheckBudget)
            {
                caption = 'Budget Checking';
                action("Check Budget")
                {

                    Caption = 'Check Budget';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        BCSetup: Record "Budgetary Control Setup";

                    begin
                        if not (Rec.Status = Rec.Status::Open) then begin
                            Error('Document must be Pending/Open');
                        end;

                        BCSetup.Get;
                        if not BCSetup.Mandatory then
                            exit;

                        //First Check whether other lines are already committed.
                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                        Commitments.SetRange(Commitments."Document No.", Rec."No.");
                        if Commitments.Find('-') then begin
                            if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                            Commitments.Reset;
                            Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                            Commitments.SetRange(Commitments."Document No.", Rec."No.");
                            Commitments.DeleteAll;
                        end;

                        CheckBudgetAvail.CheckPayments(Rec);
                    end;
                }

                action("Cancel Budget Commitment")
                {
                    Caption = 'Cancel Budget Commitment';
                    Image = CancelAllLines;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if not (Rec.Status = Rec.Status::Open) then begin
                            Error('Document must be Pending/Open');
                        end;

                        if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                        Commitments.SetRange(Commitments."Document No.", Rec."No.");
                        Commitments.DeleteAll;

                        PayLine.Reset;
                        PayLine.SetRange(PayLine."Header No.", Rec."No.");
                        if PayLine.Find('-') then begin
                            repeat
                                PayLine.Committed := false;
                                PayLine.Modify;
                            until PayLine.Next = 0;
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
        Rec."Payment Type" := Rec."Payment Type"::Board;
    end;

    trigger OnOpenPage()
    begin
        UpdateCard;
    end;

    var
        PayLine: Record "Document Line";
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
        PVHead: Record "Payment Header";
        BankAcc: Record "Bank Account";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,Loan,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","MSacco Applications","MSacco PinChange","MSacco PhoneChange","MSacco TransChange",BulkSMS,"Payment Voucher","Petty Cash",Imp,Requisition,ImpSurr,Interbank,Receipt,"Staff Claim","Staff Adv",AdvSurr,OT;
        DocPrint: Codeunit "Document-Print";
        CheckLedger: Record "Check Ledger Entry";
        CheckManagement: Codeunit CheckManagement;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";

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

        StatusEditableApproved: Boolean;
        PayingBank: Boolean;
        SaccoActivities: Codeunit "Sacco Activities";
        Commitments: Record Committment;
        CheckBudgetAvail: Codeunit "Budgetary Control";

    local procedure UpdateCard()
    begin
        // if Rec.Status = Rec.Status::Open then
        //     CurrPage.Editable := true
        // else
        //     CurrPage.Editable := false;
    end;
}

