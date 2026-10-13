
/// <summary>
/// Page Imprest Requisition Card (ID 50334).
/// </summary>
Page 50334 "Imprest Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Imprest Header";
    PromotedActionCategories = 'New,Process,Report,Check Budget,Request Approval,Post Payment';

    layout
    {
        area(content)
        {
            group(Control28)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Caption = 'Requisition Date';

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Requsition No."; Rec."Requsition No.")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec."Function Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(BudgetCenterName; Rec."Budget Center Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(BalAccountType; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic;
                    ValuesAllowed = "Bank Account", Savings;
                }
                field(BalAccountNo; Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic;


                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Members;
                        Accounts: Record "Savings Accounts";
                        Customer: Record Customer;
                        Vendor: Record "Savings Accounts";
                        GLAcc: Record "G/L Account";
                        Bank: Record "Bank Account";
                    begin
                        if Rec."Bal. Account Type" = Rec."Bal. Account Type"::"G/L Account" then begin
                            Rec."Bal. Account No." := '';
                            GLAcc.Reset();
                            if Page.RunModal(Page::"Chart of Accounts", GLAcc) = Action::LookupOK then
                                Rec."Bal. Account No." := GLAcc."No.";
                        end
                        else
                            if Rec."Bal. Account Type" = Rec."Bal. Account Type"::Customer then begin
                                Rec."Bal. Account No." := '';
                                Customer.Reset();
                                if Page.RunModal(Page::"Customer Listing", Customer) = Action::LookupOK then
                                    Rec."Bal. Account No." := Customer."No.";
                            end
                            else
                                if Rec."Bal. Account Type" = Rec."Bal. Account Type"::Vendor then begin
                                    Rec."Bal. Account No." := '';
                                    Vendor.Reset();
                                    if Page.RunModal(Page::"Vendor List", Vendor) = Action::LookupOK then
                                        Rec."Bal. Account No." := Vendor."No.";
                                end
                                else
                                    if Rec."Bal. Account Type" = Rec."Bal. Account Type"::"Bank Account" then begin
                                        REc."Bal. Account No." := '';
                                        Bank.Reset();
                                        if Page.RunModal(Page::"Bank Account List", Bank) = Action::LookupOK then
                                            REc."Bal. Account No." := Bank."No.";
                                    end

                                    else
                                        if Rec."Bal. Account Type" = Rec."Bal. Account Type"::Savings then begin

                                            Rec."Bal. Account No." := '';
                                            Accounts.Reset();
                                            if Rec."Member No." <> '' then
                                                Accounts.SetRange("Member No.", Rec."Member No.");
                                            if Page.RunModal(Page::"Member Accounts List", Accounts) = Action::LookupOK then
                                                Rec."Bal. Account No." := Accounts."No.";
                                        end
                                        else
                                            if Rec."Bal. Account Type" = Rec."Bal. Account Type"::Credit then begin
                                                Members.Reset();
                                                if Rec."Member No." <> '' then
                                                    Members.SetRange("No.", Rec."Member No.");
                                                if Page.RunModal(Page::"Member Listing", Members) = Action::LookupOK then
                                                    Rec."Bal. Account No." := Members."No.";
                                            end;

                        Rec.Validate("Account No.");
                    end;

                }
                field(BankName; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Caption = 'Requestor ID';
                    Editable = false;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TotalNetAmount; Rec."Total Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TotalNetAmountLCY; Rec."Total Net Amount LCY")
                {
                    ApplicationArea = Basic;
                }
                field(PostingDate; Rec."Payment Release Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
                field(PayMode; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                }

                field(ChequeEFTNo; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque/EFT No.';
                }
            }
            part(Control5; "Imprest Lines")
            {
                SubPageLink = No = field("No.");
            }
        }
    }



    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Post Payment';
                action("Post Payment")
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin


                        Rec.TestField(Status, Rec.Status::Approved);

                        CheckImprestRequiredItems;
                        PostImprest;
                    end;
                }
                separator(Action31)
                {
                }
                separator(Action4)
                {
                }
                action(PrintPreview)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print/Preview';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        /* if Rec.Status <> Rec.Status::Approved then
                            Error('You can only print after the document is Approved');Rec.*/
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        Report.Run(Report::"Travel Advance Report", true, true, Rec);
                        Rec.Reset;
                    end;
                }
                separator(Action2)
                {
                }
                action(CancelDocument)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: label 'Are you sure you want to Cancel this Document?';
                        Text001: label 'You have selected not to Cancel this Document';
                        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        if Confirm(Text000, true) then begin
                            //Post Committment Reversals
                            Doc_Type := Doc_type::Imprest;
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                        end
                        else
                            Error(Text001);
                    end;
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
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        Rec.TestField(Status, Rec.Status::Open);

                        CheckImprestRequiredItems;
                        VarVariant := Rec;
                        Rec.CalcFields("Total Net Amount");
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::Imprest, Rec."Global Dimension 1 Code", Rec."Shortcut Dimension 2 Code", Rec."Total Net Amount");
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

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
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Collateral Return",CheckOff,"Bankers Cheque",Salary,Overdraft,Imprest,"Imprest Surrender";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::Imprest;


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
            group(CheckBudget)
            {
                caption = 'Budget Checking';
                action("Check Budget")
                {

                    Caption = 'Check Budget';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category4;
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

                        CheckBudgetAvail.CheckImprest(Rec);
                    end;
                }

                action("Cancel Budget Commitment")
                {
                    Caption = 'Cancel Budget Commitment';
                    Image = CancelAllLines;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category4;
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

    var
        ImprestLines: Record "Imprest Lines";
        Commitments: Record Committment;
        CheckBudgetAvail: Codeunit "Budgetary Control";
        PayLine: Record "Document Line";

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec.Posted then
            CurrPage.Editable := false;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if Rec.Posted then
            CurrPage.Editable := false;
    end;

    procedure AllFieldsEntered() AllKeyFieldsEntered: Boolean
    var
        ImprestLines: Record "Imprest Lines";
    begin
        AllKeyFieldsEntered := true;
        ImprestLines.Reset;
        ImprestLines.SetRange(ImprestLines.No, Rec."No.");
        if ImprestLines.Find('-') then begin
            repeat

                if (ImprestLines."Account No:" = '') or (ImprestLines.Amount <= 0) then
                    AllKeyFieldsEntered := false;
            until ImprestLines.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;


    procedure PostImprest()
    var
        SaccoActivities: Codeunit "Sacco Activities";
        JTemplate: Code[10];
        JBatch: Code[10];
        AcctType: Enum "Gen. Journal Account Type";
        AcctNo: Code[20];
        BalAcctType: Enum "Gen. Journal Account Type";
        BalAcctNo: Code[20];
        TransType: Enum "Transaction Type Enum";
        DocType: Enum "Gen. Journal Document Type";
        AppliesToDocType: Enum "Gen. Journal Document Type";
    begin

        Rec.TestField(Status, Rec.Status::Approved);
        Rec.TestField(Posted, false);
        SaccoActivities.GetPaymentJournalTemplate(JTemplate, JBatch);

        SaccoActivities.JournalInit(JTemplate, JBatch);

        Rec.CalcFields("Total Net Amount");

        SaccoActivities.DetailedJournalInsert(JTemplate,
                        JBatch,
                        Rec."No.",
                        Rec."Payment Release Date",
                        Accttype::Customer,
                        Rec."Account No.",
                        'Imprest: ' + Rec."Account No." + ':' + Rec.Payee,
                        Balaccttype::"G/L Account",
                        '',
                        Rec."Total Net Amount",
                        Rec."Cheque No.",
                        '',
                        Transtype::" ",
                        Rec."Global Dimension 1 Code",
                        Rec."Shortcut Dimension 2 Code",
                        true,
                        Doctype::" ",
                        Rec."Payment Release Date",
                        Rec."Currency Code",
                        AppliesToDocType,
                        '',
                        '',
                        0);


        SaccoActivities.DetailedJournalInsert(JTemplate,
                        JBatch,
                        Rec."No.",
                        Rec."Payment Release Date",
                        Rec."Bal. Account Type",
                        Rec."Bal. Account No.",
                        'Imprest: ' + Rec."Account No." + ':' + Rec.Payee,
                        Balaccttype::"G/L Account",
                        '',
                        -Rec."Total Net Amount",
                        Rec."Cheque No.",
                        '',
                        Transtype::" ",
                        Rec."Global Dimension 1 Code",
                        Rec."Shortcut Dimension 2 Code",
                        true,
                        Doctype::" ",
                        Rec."Payment Release Date",
                        Rec."Currency Code",
                        AppliesToDocType,
                        '',
                        '',
                        0);


        Rec.Posted := true;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;
        Rec.Modify;

        SaccoActivities.JournalPost(JTemplate, JBatch);
    end;


    procedure LinesExists() HasLines: Boolean
    var
        ImprestLines: Record "Imprest Lines";
    begin
        HasLines := false;
        ImprestLines.Reset;
        ImprestLines.SetRange(ImprestLines.No, Rec."No.");
        if ImprestLines.Find('-') then begin
            HasLines := true;
        end;
    end;


    procedure CheckImprestRequiredItems()
    begin

        Rec.TestField("Payment Release Date");
        Rec.TestField("Account No.");
        Rec.TestField("Account Type", Rec."account type"::Customer);

        if Rec.Posted then begin
            Error('The Document has already been posted');
        end;

        if Rec."Requsition No." = '' then
            Error('Requisition No. is missing');

        if not LinesExists then
            Error('There are no Lines created for this Document');


    end;
}

