
Page 50179 "Cheque Receipts Header"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Cheque Receipts_";

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
                }
                field(ClearingBank; Rec."Clearing Bank")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(TransactionTime; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CreatedBy; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(UnpaidBy; Rec."Unpaid By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RefferenceDocument; Rec."Refference Document")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Unpaid; Rec.Unpaid)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control12; "Cheque Receipt Lines")
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Import)
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    RefNoRec.Reset;
                    RefNoRec.SetRange(RefNoRec.CurrUserID, UserId);
                    if RefNoRec.Find('-') then begin
                        RefNoRec."Reference No" := Rec."No.";
                        RefNoRec.Modify;
                    end
                    else begin
                        RefNoRec.Init;
                        RefNoRec.CurrUserID := UserId;
                        RefNoRec."Reference No" := Rec."No.";
                        RefNoRec.Insert;
                    end;


                    InwardFile.Reset;
                    //InwardFile.SETRANGE(InwardFile.CurrentUserID,USERID);
                    if InwardFile.Find('-') then
                        InwardFile.DeleteAll;


                    Commit;

                    Xmlport.Run(51532002, true);


                    Commit;

                    Report.Run(51532093, true);


                    Commit;

                    Report.Run(51532092, true);

                    Rec."Created By" := UserId;
                    Rec.Modify;
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //IF Status<>Status::Approved THEN
                    //   MESSAGE(DocMustbeApproved);

                    if Rec.Posted then
                        Error('Transaction already Posted');
                    //SaccoT.PostCheques(Rec);
                end;
            }
            action("Post Unpay Accounts")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Approved then
                        Message(DocMustbeApproved);

                    if Rec.Unpaid then
                        Error('Transaction already unpaid');

                    //SaccoT.GenerateDividendPostingBuffer(Rec);
                end;
            }
            action("Export Unpay Accounts")
            {
                ApplicationArea = Basic;
                Image = Export;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin


                    ChqRecLines.Reset;
                    ChqRecLines.SetRange(ChqRecLines."Chq Receipt No", Rec."No.");
                    Xmlport.Run(52018501, true, false, ChqRecLines);
                end;
            }
            group(Approval)
            {
                Caption = 'Approval';
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
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin

                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);

                        Rec.TestField("Transaction Type");
                        Rec.TestField("Clearing Bank");

                        VarVariant := Rec;
                        if CustomApprovals.CheckWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin

                        if Rec.Status <> Rec.Status::Pending then
                            Error(DocMustbePending);

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocForApproval(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin

                        approvalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        AccountType: Record "Product Setup";
        AvailableBal: Decimal;
        LineNo: Integer;
        Accounts: Record "Savings Accounts";
        TextGen: Text[250];
        ReffNo: Code[20];
        Account: Record "Savings Accounts";
        iEntryNo: Integer;
        Vend: Record "Savings Accounts";
        ChqRecLines: Record "Cheque Issue Lines_";
        AccountTypes: Record "Product Setup";
        CheqReg: Record "Cheques Register_";
        Charges: Record "Transaction Charges";
        GenSetup: Record "Sacco Setup";
        RefNoRec: Record "Refference Number_";
        AllAmount: Decimal;
        InwardFile: Record "Inward file Buffer_";
        SaccoT: Codeunit "Sacco Activities";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Calwide Approvals";
        DocMustbeOpen: label 'This application request must be open';
        DocMustbePending: label 'This application request must be Pending';
        DocMustbeApproved: label 'This application request must be Approved before proceeding';

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

