
Page 50226 "Mobile Money Trans. Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Teller Transaction";
    SourceTableView = where(Mpesa = const(true));

    layout
    {
        area(content)
        {
            group(Transactions)
            {
                Caption = 'Transactions';
                field(TransactionNo; Rec."Transaction No.")
                {
                    ApplicationArea = Basic;
                }
                field(AgentTransaction; Rec."Agent Transaction")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        UpdateControl;
                    end;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MpesaAgentTransaction; Rec."Mpesa/Agent Transaction")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = Amont;
                }
                field("TillBalance"; Rec."M_Money Till Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(FloatBalance; Rec."Float Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("DocNo/Remarks"; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = Remarrrks;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(TillName; Rec."Till Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        Rec."Transaction Time" := Time;
                    end;
                }
                field(TransactionTime; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
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
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AttemptedSelfTransaction; Rec."Attempted Self Transaction")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control4; Links)
            {
                Visible = false;
            }
            systempart(Control3; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                action(Statement)
                {
                    ApplicationArea = Basic;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        Account.Reset;
                        Account.SetRange(Account."No.", Rec."Account No.");
                        if Account.Find('-') then
                            Report.Run(50242, true, false, Account)
                    end;
                }
                action("Account Page")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Page';
                    Image = Vendor;
                    Promoted = true;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = field("Account No.");
                }
            }
        }
        area(processing)
        {
            action("Post & Print")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    if Rec.Status = Rec.Status::"Pending Approval" then
                        Error('The transaction must be fully approved before proceeding');

                    if Confirm('Are you sure you want to post this ' + Format(Rec.Type)) then begin

                        BankingActivities.InitPost(Rec);

                        Commit;

                        Trans.Reset;
                        Trans.SetRange(Trans."Transaction No.", Rec."Transaction No.");
                        if Trans.Find('-') then begin
                            if Rec.Type = Rec.Type::"Cash Withdrawal" then
                                Report.Run(50308, false, true, Trans)
                            else
                                if Rec.Type = Rec.Type::"Cash Deposit" then
                                    Report.Run(50309, false, true, Trans)
                                else
                                    if Rec.Type = Rec.Type::"Credit Receipt" then
                                        Report.Run(50314, false, true, Trans)
                                    else
                                        if Rec.Type = Rec.Type::"Cheque Deposit" then
                                            Report.Run(50310, false, true, Trans)
                                        else
                                            if Rec.Type = Rec.Type::"Credit Cheque" then
                                                Report.Run(50314, false, true, Trans)
                                            else
                                                if Rec.Type = Rec.Type::"Bankers Cheque" then
                                                    Report.Run(50308, false, true, Trans)
                        end;

                        CurrPage.Close;

                    end;
                end;
            }
            action("Reset Transaction Date")
            {
                ApplicationArea = Basic;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;

                trigger OnAction()
                begin

                    //Trans.RESET;
                    //Trans.SETRANGE(Trans.Posted,FALSE);
                    //Trans.SETRANGE(Trans.No,No);
                    //IF Trans.FIND('-') THEN BEGIN
                    Rec.TestField(Posted, false);
                    Rec."Transaction Date" := Today;
                    Rec."Transaction Time" := Time;
                    Rec.Modify;

                    Message('Transaction date updated');

                    //END ELSE
                    //ERROR('Transaction already posted');
                end;
            }
            action("Reprint Slip")
            {
                ApplicationArea = Basic;
                Caption = 'Reprint Slip';
                Image = DepositSlip;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField(Posted);
                    Trans.Reset;
                    Trans.SetRange(Trans."Transaction No.", Rec."Transaction No.");
                    if Trans.Find('-') then begin
                        Trans.Dublicate := true;
                        Trans.Modify;
                        Commit;
                    end;

                    Trans.Reset;
                    Trans.SetRange(Trans."Transaction No.", Rec."Transaction No.");
                    if Trans.Find('-') then begin
                        if Rec.Type = Rec.Type::"Cash Withdrawal" then
                            Report.Run(50308, true, true, Trans)
                        else
                            if Rec.Type = Rec.Type::"Cash Deposit" then
                                Report.Run(50309, true, true, Trans)
                            else
                                if Rec.Type = Rec.Type::"Credit Receipt" then
                                    Report.Run(50314, true, true, Trans)
                                else
                                    if Rec.Type = Rec.Type::"Cheque Deposit" then
                                        Report.Run(50310, true, true, Trans)
                                    else
                                        if Rec.Type = Rec.Type::"Credit Cheque" then
                                            Report.Run(50314, true, true, Trans)
                                        else
                                            if Rec.Type = Rec.Type::"Bankers Cheque" then
                                                Report.Run(50308, true, true, Trans)
                    end;
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin
                    Rec.TestField(Remarks);

                    Rec.TestField(Amount);

                    if Rec.Status = Rec.Status::"Pending Approval" then
                        Error('The transaction must be fully approved before proceeding');


                    if Confirm('Are you sure you want to post this ' + Format(Rec.Type)) then begin

                        BankingActivities.InitPost(Rec);

                        CurrPage.Close;

                    end;
                end;
            }
            action("Till Balance")
            {
                ApplicationArea = Basic;
                Image = Balance;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin


                    BankAcc.Reset;
                    BankAcc.SetRange("No.", Rec."Till Code");

                    if BankAcc.FindFirst then
                        Page.Run(370, BankAcc);
                end;
            }
            group(Approval)
            {
                Caption = 'Approval';
                Visible = false;
                action(Reopen)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        //TESTFIELD(Status,Status::"Pending Approval");
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                Visible = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        FChequeVisible := false;
        BChequeVisible := false;
        BReceiptVisible := false;
        BOSAReceiptChequeVisible := false;
        AllAmount := false;
        DiscCH := false;
        FLien := false;

        if (Rec.Type = Rec.Type::"Cheque Deposit") or (Rec.Type = Rec.Type::"Cheque Withdrawal") then begin
            FChequeVisible := true;
            DiscCH := true;
        end;

        if Rec.Type = Rec.Type::"Bankers Cheque" then
            BChequeVisible := true;

        if Rec.Type = Rec.Type::"Credit Receipt" then begin
            BReceiptVisible := true;
            AllAmount := true;
        end;

        if Rec."Account Type" = Rec."account Type"::"G/L Account" then
            AllAmount := true;

        if Rec.Type = Rec.Type::"Credit Cheque" then begin
            FChequeVisible := true;
            BOSAReceiptChequeVisible := true;
            AllAmount := true;
        end;

        if Rec.Type = Rec.Type::Lien then begin
            FLien := true;
        end;

        SetControlAppearance;
        UpdateControl;
        if Rec."Account Type" = Rec."account Type"::Account then
            AccNo := true
        else
            AccNo := false;
    end;

    trigger OnInit()
    begin
        UpdateControl;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        if Rec."Account Type" = Rec."account Type"::Account then
            AccNo := true
        else
            AccNo := false;



        Rec.Mpesa := true;
        Rec.Modify;
    end;

    trigger OnOpenPage()
    begin

        if Rec.Posted = true then
            CurrPage.Editable := false;
        if Rec."Account Type" = Rec."account Type"::Account then
            AccNo := true
        else
            AccNo := false;
    end;

    var

        FChequeVisible: Boolean;

        BChequeVisible: Boolean;

        BReceiptVisible: Boolean;

        BOSAReceiptChequeVisible: Boolean;
        FLien: Boolean;
        Account: Record "Savings Accounts";
        UserSetup: Record "User Setup";
        DBranch: Code[20];
        DActivity: Code[20];
        Temp: Record "Banking User Setup";
        Jtemplate: Code[20];
        Jbatch: Code[20];
        TillNo: Code[20];
        MemberNo: Code[20];
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        AccNo: Boolean;
        TransType: Boolean;
        Amont: Boolean;
        Remarrrks: Boolean;
        AllAmount: Boolean;
        Trans: Record "Teller Transaction";
        Excess: Code[20];
        Shortage: Code[20];
        Currr: Boolean;
        ImageData: Record "Member Images";
        DiscCH: Boolean;
        NoEditTeller: Boolean;
        BankAcc: Record "Bank Account";
        LoansG: Record "Loan Security";
        Loans: Record Loans;
        Text0001: label 'Ensure the Cashier journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the MPesa Bank is set up in Banking User Setup';
        Text0004: label 'Ensure the Cashier Member no is set up in Banking User Setup';
        Text0005: label 'Ensure the Cashier Shortage Account is set up in Banking User Setup';
        Text0006: label 'Ensure the Cashier Excess Account iis set up in Banking User Setup';
        BankingActivities: Codeunit "Banking Activities";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;


    procedure UpdateControl()
    begin
        if Rec.Status = Rec.Status::Open then begin
            AccNo := true;
            TransType := true;
            Remarrrks := true;
            Amont := true;
            Currr := true;
        end;


        if Rec.Status = Rec.Status::"Pending Approval" then begin
            AccNo := false;
            TransType := false;
            Remarrrks := false;
            Amont := false;
            Currr := false;
        end;


        if Rec.Status = Rec.Status::Rejected then begin
            AccNo := false;
            TransType := false;
            Remarrrks := false;
            Amont := false;
            Currr := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            AccNo := false;
            TransType := false;
            Remarrrks := false;
            Amont := false;
            Currr := false;

        end;

        if Rec."Account Type" = Rec."account Type"::Account then
            AccNo := true
        else
            AccNo := false;
    end;
}

