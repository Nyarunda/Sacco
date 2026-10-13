Page 50349 "Treasury/Teller Trans. Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Treasury/Teller Transactions";
    PromotedActionCategories = 'New,Process,Report,Re-Open,Reset Date,Request Approvals';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = TransType;
                }
                field(From; Rec."From Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'From';
                    Editable = FrAccount;
                }
                field(FromTill; Rec."From Till")
                {
                    ApplicationArea = Basic;
                }
                field(FromBalance; Rec."From Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field(FromBank; Rec."From Bank")
                {
                    ApplicationArea = Basic;
                }
                field("To"; Rec."To Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'To';
                    Editable = ToAccount;
                }
                field(ToTill; Rec."To Till")
                {
                    ApplicationArea = Basic;
                }
                field(ToBank; Rec."To Bank")
                {
                    ApplicationArea = Basic;
                }
                field(ToBalance; Rec."To Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = TreasuryEditable;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = Amnt;
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = Currr;
                    Visible = false;
                }
                field(ChequeDocumentNo; Rec."External Document No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque/Document No.';
                    Editable = ExternDoc;
                }
                field(Issued; Rec.Issued)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateIssued; Rec."Date Issued")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TimeIssued; Rec."Time Issued")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(IssuedBy; Rec."Issued By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Received; Rec.Received)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateReceived; Rec."Date Received")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TimeReceived; Rec."Time Received")
                {
                    ApplicationArea = Basic;
                }
                field(ReceivedBy; Rec."Received By")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TotalCashonTreasuryTellerCoinage; Rec."Total Cash on Treasury Coinage")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Cash on Treasury/Teller Coinage';
                }
                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = Typee;
                }
                field(ExcessShortageAmount; Rec."Excess/Shortage Amount")
                {
                    ApplicationArea = Basic;
                    Editable = Excess;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control34; Coinage)
            {
                SubPageLink = No = field(Code);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Validate Tills")
            {
                ApplicationArea = Basic;
                Image = Interaction;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                begin
                    Rec.Testfield(Posted, False);
                    Rec.Validate("From Account");
                    Rec.Validate("To Account");
                    Rec.Modify;


                end;
            }
            action("Issue/Return")
            {
                ApplicationArea = Basic;
                Caption = 'Issue/Return';
                Image = Interaction;
                Promoted = true;
                Enabled = Rec.Issued = Rec.Issued::No;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                begin
                    /*
                    IF "Transaction Type"="Transaction Type"::"Inter Teller Transfers" THEN BEGIN
                      IF Status<>Status::Approved THEN
                        ERROR('Transaction must be approved');
                    END;
                    */
                    IF Rec.Status <> Rec.Status::Approved THEN
                        ERROR('Transaction must be approved');

                    if Rec."Date Issued" <> 0D then
                        if Rec."Date Issued" <> Today then
                            Error('Date Issued must be TODAY!, Reset Dates.');

                    if Rec."External Document No." = '' then
                        Error(Error002);

                    SaccoActivities.PostTreasuryTellerIssue(Rec);

                    CurrPage.Close();

                end;
            }
            separator(Action31)
            {
            }
            action(Receive)
            {
                ApplicationArea = Basic;
                Caption = 'Receive';
                Image = ReceiveLoaner;
                Enabled = Rec.Received = Rec.Received::No;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                begin
                    IF Rec.Status <> Rec.Status::Approved THEN
                        ERROR('Transaction must be approved');

                    SaccoActivities.PostTreasuryTellerReceive(Rec);

                    CurrPage.Close();
                end;
            }
            action("Coinage Report")
            {
                ApplicationArea = Basic;
                Image = Report2;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TreasuryTellerTransactions.Reset;
                    TreasuryTellerTransactions.SetRange(Code, Rec.Code);
                    if TreasuryTellerTransactions.FindFirst then
                        Report.Run(Report::"End of Day Coinage Report", true, false, TreasuryTellerTransactions);
                end;
            }
            action("EOD Report")
            {
                ApplicationArea = Basic;
                Image = Report2;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TreasuryTellerTransactions.Reset;
                    TreasuryTellerTransactions.SetRange(Code, Rec.Code);
                    if TreasuryTellerTransactions.FindFirst then
                        Report.Run(Report::"EOD Report", true, false, TreasuryTellerTransactions);
                end;
            }
            action("Re-Open")
            {
                Caption = 'Re-Open';
                ApplicationArea = Basic;
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ReOpenRecord();
                end;
            }
            action("Reset Date")
            {
                Caption = 'Reset Date';
                ApplicationArea = Basic;
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ResetDate();
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
                    PromotedCategory = Category6;
                    Visible = SendBool;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Custom Document Type";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin
                        BUser.get(UserId);
                        if Rec.Amount > BUser."Max. Cashier Withholding" then
                            Error('You cannot request more than your maximum Cashier Withholding');
                        CheckControls();
                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec.Code, Rec.Amount, Documenttype::Treasury, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                        CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Visible = CancelBool;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Member Application","Loan Application";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec.Code);
                        CurrPage.Close();
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
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec.Code);
                        ApprovalTracker.SetRange("Custom Document Type", DocumentType::"Loan Application");
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(RecRef.RecordId);
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Visible = Rec.Status = Rec.Status::Pending;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        Rec.TestField(status, Rec.Status::Pending);
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        CurrPage.Close();
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;
                    Visible = Rec.Status = Rec.Status::Approved;
                    Promoted = true;

                    trigger OnAction()
                    begin

                        if (Rec.Status <> Rec.Status::Open) and (Rec.Status <> Rec.Status::Pending) then begin

                            if not Confirm('Are you sure you want to re-open document?') then exit;

                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;

                            CurrPage.Close();

                        end;
                    end;
                }
            }
        }

    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
        SetControlAppearance;
    end;

    trigger OnInit()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Posted = true then
            CurrPage.Editable := false;
    end;

    var
        TransType: Boolean;
        FrAccount: Boolean;
        ToAccount: Boolean;
        Amnt: Boolean;
        Currr: Boolean;
        ExternDoc: Boolean;
        Excess: Boolean;
        Cnage: Boolean;
        Typee: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        BUser: Record "Banking User Setup";
        TreasuryEditable: Boolean;
        ApplicationDetailsEdit: Boolean;
        SendBool: Boolean;
        CancelBool: Boolean;
        DocMustbeOpen: label 'This application request must be open';
        DocMustbePending: label 'This application request must be Pending';
        Error001: label 'Kindly ensure Amount is Equal to Coinage Amount';
        Error002: label 'Document No./Cheque No. Must have a value';
        TreasuryTellerTransactions: Record "Treasury/Teller Transactions";

    local procedure CheckControls()
    var
        BankingUser: Record "Banking User Setup";
        Banks: Record "Bank Account";
        BankBal: decimal;
        Text0005: label 'You do not have permission to transact on this teller till/Account.';

    begin
        BankingUser.Reset;
        BankingUser.SetRange(BankingUser."User Name", TreasuryTellerTransactions."From Account");
        if BankingUser.Find('-') then begin

            if UserId <> BankingUser."User Name" then begin

                Banks.Reset;
                Banks.SetRange(Banks."No.", TreasuryTellerTransactions."From Bank");
                Banks.SetFilter("Responsible User", UserId);
                if not Banks.Find('-') then begin
                    Error(Text0005);
                end

            end;
        end;
    end;

    local procedure UpdateControls()
    begin
        if (Rec.Issued = Rec.Issued::Yes) or (Rec.Received = Rec.Received::Yes) then begin
            TransType := false;
            FrAccount := false;
            ToAccount := false;
            Amnt := false;
            Excess := false;
            Currr := false;
            Cnage := false;
            ExternDoc := false;
            Typee := false;
        end else begin
            TransType := true;
            FrAccount := true;
            ToAccount := true;
            Amnt := true;
            Excess := true;
            Currr := true;
            Cnage := true;
            ExternDoc := true;
            Typee := true;

        end;

        TreasuryEditable := true;
        BUser.Reset;
        BUser.SetRange("User Name", UserId);
        BUser.SetRange(Type, BUser.Type::Cashier);
        if BUser.FindFirst then
            TreasuryEditable := false;

        if Rec.Status = Rec.Status::Open then begin
            ApplicationDetailsEdit := true;
            SendBool := true;
            CancelBool := false;

        end
        else begin
            ApplicationDetailsEdit := true;
            SendBool := false;
            CancelBool := false;
        end;

        if Rec.Status = Rec.Status::Pending then begin
            CancelBool := true;
        end;
    end;

    local procedure ReOpenRecord()
    var
        myInt: Integer;
    begin
        Rec.TestField(Issued, Rec.Issued::Yes);
        Rec.TestField(Received, Rec.Received::No);
        if Confirm('Are you sure you want to reopen this record?', false) then begin
            Rec.Issued := Rec.Issued::No;
            Rec.Modify();
        end;

    end;

    local procedure ResetDate()
    var
        myInt: Integer;
    begin
        if Confirm('Are you sure you want to reset date for this record?', false) then begin
            Rec."Transaction Date" := Today;
            Rec."Date Issued" := Today;
            Rec."Time Issued" := Time;
            Rec.Modify();
        end;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

