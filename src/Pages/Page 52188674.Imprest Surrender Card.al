
Page 50337 "Imprest Surrender Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Imprest Surrender Header";
    PromotedActionCategories = 'New,Process,Report,Post,Approval Request,Cancel Document';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(SurrenderDate; Rec."Surrender Date")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        AccountName := GetCustName(Rec."Account No.");
                    end;
                }
                field(AccountName; AccountName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Name';
                    Editable = false;
                }
                field(ImprestIssueNo; Rec."Imprest Issue No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ImprestIssueDate; Rec."Imprest Issue Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(ImprestLines; "Imprest Surrender Lines")
            {
                SubPageLink = "Surrender Doc No." = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Cancel Document")
                {
                    ApplicationArea = Basic;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Post Committment Reversals
                        Rec.TestField(Status, Rec.Status::Approved);
                        if Confirm(Text002, true) then begin
                            Doc_Type := Doc_type::Imprest;
                            //  BudgetControl.ReverseEntries(Doc_Type,"Imprest Issue No.");
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                        end;
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    var
                        Txt0001: label 'Actual Spent and the Cash Receipt Amount should be equal to the amount Issued';
                        AcctType: Enum "Gen. Journal Account Type";
                        AcctNo: Code[20];
                        BalAcctType: Enum "Gen. Journal Account Type";
                        BalAcctNo: Code[20];
                        TransType: Enum "Transaction Type Enum";
                        DocType: Enum "Gen. Journal Document Type";
                        AppliesToDocType: Enum "Gen. Journal Document Type";
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);

                        if Rec.Posted then
                            Error('The transaction has already been posted.');

                        Rec.CalcFields("Actual Spent");
                        if Rec."Actual Spent" = 0 then begin
                            if Confirm(Text000, true) then
                                UpdateforNoActualSpent
                            else
                                Error(Text001);
                        end;


                        SaccoActivities.GetPaymentJournalTemplate(JTemplate, JBatch);

                        SaccoActivities.JournalInit(JTemplate, JBatch);



                        ImprestSurrenderLines.Reset;
                        ImprestSurrenderLines.SetRange(ImprestSurrenderLines."Surrender Doc No.", Rec.No);
                        if ImprestSurrenderLines.Find('-') then begin
                            repeat


                                if (ImprestSurrenderLines."Cash Receipt Amount" + ImprestSurrenderLines."Actual Spent") <> ImprestSurrenderLines.Amount then
                                    Error(Txt0001);

                                Rec.TestField("Global Dimension 1 Code");


                                SaccoActivities.DetailedJournalInsert(JTemplate,
                                                JBatch,
                                                Rec.No,
                                                Rec."Surrender Date",
                                                Accttype::Customer,
                                                ImprestSurrenderLines."Imprest Holder",
                                                'Imprest Surrendered by staff',
                                                Balaccttype::"G/L Account",
                                                ImprestSurrenderLines."Account No:",
                                                -ImprestSurrenderLines."Actual Spent",
                                                Rec."Imprest Issue No.",
                                                '',
                                                Transtype::" ",
                                                Rec."Global Dimension 1 Code",
                                                Rec."Shortcut Dimension 2 Code",
                                                true,
                                                Doctype::" ",
                                                Rec."Surrender Date",
                                                Rec."Currency Code",
                                                Appliestodoctype::Invoice,
                                                '',
                                               Rec."Apply to ID",
                                                Rec."Dimension Set ID");



                                //Post Cash Surrender
                                if ImprestSurrenderLines."Cash Surrender Amt" > 0 then begin

                                    if ImprestSurrenderLines."Bank/Petty Cash" = '' then
                                        Error('Select a Bank Code where the Cash Surrender will be posted');


                                    SaccoActivities.DetailedJournalInsert(JTemplate,
                                                    JBatch,
                                                    Rec.No,
                                                    Rec."Surrender Date",
                                                    Accttype::Customer,
                                                    ImprestSurrenderLines."Imprest Holder",
                                                    'Imprest Surrendered by staff',
                                                    Balaccttype::"Bank Account",
                                                    ImprestSurrenderLines."Bank/Petty Cash",
                                                    -ImprestSurrenderLines."Cash Surrender Amt",
                                                   Rec."Imprest Issue No.",
                                                    '',
                                                    Transtype::" ",
                                                    Rec."Global Dimension 1 Code",
                                                    Rec."Shortcut Dimension 2 Code",
                                                    true,
                                                    Doctype::Invoice,
                                                    Rec."Surrender Date",
                                                    Rec."Currency Code",
                                                    Appliestodoctype::Invoice,
                                                    '',
                                                    Rec."Apply to ID",
                                                    Rec."Dimension Set ID");




                                end;

                            //End Post Surrender Journal
                            until ImprestSurrenderLines.Next = 0;
                        end;


                        Rec.Posted := true;
                        Rec."Date Posted" := Today;
                        Rec."Time Posted" := Time;
                        Rec."Posted By" := UserId;
                        Rec.Modify;
                        //Tag the Source Imprest Requisition as Surrendered
                        ImprestHeader.Reset;
                        ImprestHeader.SetRange(ImprestHeader."No.", Rec."Imprest Issue No.");
                        if ImprestHeader.Find('-') then begin
                            ImprestHeader."Surrender Status" := ImprestHeader."surrender status"::Full;
                            ImprestHeader.Modify;
                        end;

                        /*
                        //End Tag
                        //Post Committment Reversals
                        Doc_Type:=Doc_Type::Imprest;
                        BudgetControl.ReverseEntries(Doc_Type,"Imprest Issue No.");
                        */

                        SaccoActivities.JournalPost(JTemplate, JBatch);

                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.Reset;
                        Rec.SetFilter(No, Rec.No);
                        Report.Run(39005886, true, true, Rec);
                        Rec.Reset;
                    end;
                }
                action("Get Imprest Document")
                {
                    ApplicationArea = Basic;
                    Image = GetEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        IF "Imprest Issue Doc. No"='' THEN
                           ERROR('Please Select the Imprest Issue Document Number');
                        
                        PaymentLine.RESET;
                        PaymentLine.SETRANGE(PaymentLine.No,"Imprest Issue Doc. No");
                        PAGE.RUNMODAL(39006085,PaymentLine);
                        */

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
                    PromotedCategory = Category5;

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
                        VarVariant := Rec;

                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec.No, 0, Documenttype::"Imprest Surrender", Rec."Global Dimension 1 Code", Rec."Shortcut Dimension 2 Code", Rec.Amount);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec.No);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;

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
                        DocumentType := Documenttype::"Imprest Surrender";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec.No);
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
                            CalwideApprovals.CancelTracker(VarVariant, Rec.No);
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

    var
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        AccountName: Text;
        Text000: label 'You have not specified the Actual Amount Spent. This document will only reverse the committment and you will have to receipt the total amount returned.';
        Text001: label 'Document Not Posted';
        Text002: label 'Are you sure you want to Cancel this Document?';
        Text19053222: label 'Enter Advance Accounting Details below';
        ImprestHeader: Record "Imprest Header";
        JTemplate: Code[10];
        JBatch: Code[10];
        SaccoActivities: Codeunit "Sacco Activities";
        ImprestSurrenderLines: Record "Imprest Surrender Lines";


    procedure UpdateforNoActualSpent()
    begin
        Rec.Posted := true;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;
        Rec.Modify;

        //Tag the Source Imprest Requisition as Surrendered
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."No.", Rec."Imprest Issue No.");
        if ImprestHeader.Find('-') then begin
            ImprestHeader."Surrender Status" := ImprestHeader."surrender status"::Full;
            ImprestHeader.Modify;
        end;
        //End Tag
        //Post Committment Reversals
        Doc_Type := Doc_type::Imprest;
        //BudgetControl.ReverseEntries(Doc_Type,"Imprest Issue No.");
    end;


    procedure GetCustName(No: Code[20]) Name: Text[100]
    var
        Cust: Record Members;
    begin
        Name := '';
        if Cust.Get(No) then
            Name := Cust.Name;
        exit(Name);
    end;
}

