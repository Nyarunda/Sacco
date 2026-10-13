
Page 50368 "Petty Cash Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Payment Header";
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
                field(CurrencyCode; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = "Currency CodeEditable";
                    Visible = false;
                }
                field(PayingAccountType; Rec."Paying Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    ValuesAllowed = "Bank Account", "G/L Account";
                }
                field(PayingAccount; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Paying Account';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec."Pay Mode" := Rec."Pay Mode"::Cash;

                        BankAcc.Reset;
                        BankAcc.SetRange(BankAcc."No.", Rec."Paying Bank Account");
                        BankAcc.SetRange(BankAcc."Bank Type", BankAcc."bank type"::Cash);
                        if BankAcc.FindFirst then begin
                            BankAcc.CalcFields(BankAcc.Balance);
                            Rec."Current Source A/C Bal." := BankAcc.Balance;
                            if (Rec."Current Source A/C Bal." - Rec."Total Net Amount") < 0 then begin
                                Error('The transaction will result in a negative balance in the BANK ACCOUNT. %1:%2', BankAcc."No.", BankAcc.Name);
                            end;
                        end;
                    end;
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
                    // Editable = OnBehalfEditable;
                }
                field(PaymentNarration; Rec."Payment Narration")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
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
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                }
            }
            part(PettyCashLines; "Petty Cash Line")
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
                        Rec.TestField("Payment Release Date");
                        SaccoActivities.PostPV(Rec."No.");

                    end;
                end;
            }
            //ATTACHMENT CODE
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
                        Report.Run(Report::"Petty Cash", true, false, PVHead);
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
                        SaccoSet: Record "Sacco Setup";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin
                        // TestField("Document Attached");
                        Rec.TestField("Payment Release Date");
                        SaccoSet.Get();
                        SaccoSet.TestField("Max. Petty Cash Amount");
                        if Rec."Total Payment Amount" > SaccoSet."Max. Petty Cash Amount" then
                            error('You have exceeded maximum petty cash amount.');

                        VarVariant := Rec;
                        Rec.CalcFields("Total Payment Amount");
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Petty Cash", Rec."Global Dimension 1 Code", Rec."Shortcut Dimension 2 Code", Rec."Total Payment Amount");
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
                        DocumentType: Enum "Custom Document Type";//Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Petty Cash";




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
                action("Reset Payment Release Date")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin


                        if not Confirm('Are you sure you want to re-reset release date for this document?') then
                            exit;

                        Rec."Payment Release Date" := Today;
                        Rec.Modify;
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
        Rec."Payment Type" := Rec."payment type"::"Petty Cash";
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

    local procedure UpdateCard()
    begin
        if Rec.Status = Rec.Status::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;
    end;
}

