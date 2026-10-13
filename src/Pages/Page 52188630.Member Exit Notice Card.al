Page 50293 "Member Exit Notice Card"
{
    caption = 'Member Withdrawal Notice Card';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Exit Notice";

    layout
    {
        area(content)
        {
            //member forfeiting exit-mwende 092926
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(WithdrawaNoticelDate; Rec."Withdrawa Noticel Date")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Type"; Rec."Withdrawal Type")
                {
                    ApplicationArea = Basic;
                    trigger onvalidate()
                    begin
                        if Rec."Withdrawal Type" = Rec."Withdrawal Type"::"Account CLosure" then begin
                            AccClosureBool := true;
                            ExitGua := false;
                        end else begin
                            AccClosureBool := false;
                            ExitGua := true;
                        end;
                    end;
                }

                field("Closure Type"; Rec."Closure Type")
                {
                    ApplicationArea = Basic;
                    Enabled = ExitGua;
                    Caption = 'Closure Timeline';
                    trigger OnValidate()
                    begin

                        if Rec."Closure Type" = Rec."Closure Type"::"Withdrawal - Death" then
                            BeneficiaryBool := true
                        else
                            BeneficiaryBool := false;
                    end;
                }

                field(Reasonforwithdrawal; Rec."Reason for withdrawal")
                {
                    ApplicationArea = Basic;
                }
                field(MaturityDate; Rec."Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Notice Received From"; Rec."Notice Received From")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address Used"; Rec."Email Address Used")
                {
                    ApplicationArea = Basic;
                    Enabled = Rec."Notice Received From" = Rec."Notice Received From"::Email;
                }
                field("Occupation Status"; Rec."Occupation Status")
                {
                    ApplicationArea = Basic;
                }

                field("Recommendation Comments"; Rec."Recommendation Comments")
                {
                    ApplicationArea = Basic;
                }
                field("HOD Approver"; Rec."HOD Approver")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Credit Approver"; Rec."Credit Approver")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Letter of Withdrawal"; Rec."Letter of Withdrawal")
                {
                    ApplicationArea = Basic;
                }
                field("Deceased Exit"; Rec."Deceased Exit")
                {
                    ApplicationArea = Basic;
                }

                field("Loans Offset"; Rec."Loans Offset")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Notice Stage" = Rec."Notice Stage"::"Credit Department 1";
                    trigger OnValidate()
                    begin
                        if Rec."Loans Offset" then
                            Rec."Responsibility Center" := 'CREDIT'
                    end;
                }

                field("Guarantor Substituted"; Rec."Guarantor Substituted")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Notice Stage" = Rec."Notice Stage"::"Credit Department 1";
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Notice Stage"; Rec."Notice Stage")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Exit Stage"; Rec."Member Exit Stage")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(EnteredBy; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                }
                field(DateEntered; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field(TimeEntered; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                }
            }

            group("Acc Closure")
            {
                Visible = AccClosureBool;
                field("Account To Close"; Rec."Account To Close")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Accounts List";
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Transfer Account"; Rec."Transfer Account")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Accounts List";
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }

            }

            part(Control19; "Member Exit Loans")
            {
                Caption = 'Outstanding Loans';

                ApplicationArea = all;
                SubPageLink = "Member No." = field("Member No.");
            }

            part(Control17; "Exit Loan Guarantors")
            {

                Caption = 'Loans I have guaranteed';
                ApplicationArea = all;

                SubPageLink = "Member No" = field("Member No.");
            }

        }
        area(factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Member Exit Notice"),
                              "No." = field("No.");
                UpdatePropagation = Both;
            }
        }


    }

    actions
    {
        area(processing)
        {
            group(Process)
            {
                action(RequestForfeitNotice)
                {
                    ApplicationArea = Basic;
                    Caption = 'Forfeit Notice';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ForfeitRequest: Record "Forfeit Exit Request";
                        ReasonPage: Page "Forfeit Exit Reason";
                        Reason: Text[250];
                    begin
                        if ReasonPage.RunModal() <> Action::OK then
                            exit;
                        Reason := ReasonPage.GetForfeitReason();

                        ForfeitRequest.RequestForfeitNotice(Rec."Member No.", Rec."No.", Reason);
                        Message('Forfeit Notice request sent to the configured approver.');
                        CurrPage.Update(false);
                    end;
                }
                action(ApproveForfeitNotice)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve Forfeit Notice';
                    Image = Approve;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ForfeitRequest: Record "Forfeit Exit Request";
                    begin
                        if not ForfeitRequest.FindPendingForMember(Rec."Member No.", ForfeitRequest."Forfeit Type"::"Exit Notice") then
                            Error('There is no pending Forfeit Notice request for this member.');
                        if not Confirm('Approve Forfeit Notice? Reason: %1', false, ForfeitRequest.ForfeitReason) then
                            exit;

                        ForfeitRequest.ApproveForfeitNotice(Rec."Member No.");
                        Message('Forfeit Notice approved. The notice status is Forfeited.');
                        CurrPage.Update(false);
                    end;
                }
                action(RejectForfeitNotice)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject Forfeit Notice';
                    Image = Reject;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ForfeitRequest: Record "Forfeit Exit Request";
                        ReasonPage: Page "Forfeit Exit Reason";
                        RejectionReason: Text[250];
                    begin
                        if not ForfeitRequest.FindPendingForMember(Rec."Member No.", ForfeitRequest."Forfeit Type"::"Exit Notice") then
                            Error('There is no pending Forfeit Notice request for this member.');
                        if not Confirm('Reject Forfeit Notice? Request reason: %1', false, ForfeitRequest.ForfeitReason) then
                            exit;
                        if ReasonPage.RunModal() <> Action::OK then
                            exit;
                        RejectionReason := ReasonPage.GetForfeitReason();

                        ForfeitRequest.RejectForfeitNotice(Rec."Member No.", RejectionReason);
                        Message('Forfeit Notice request rejected. The notice status was not changed.');
                        CurrPage.Update(false);
                    end;
                }
                action(CreateMemberExit)
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Member Exit';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedOnly = true;
                    Visible = Rec."Notice Stage" = Rec."Notice Stage"::"Finance Notice";


                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        MemberExit: Record "Member Exit";
                        Mem: Record Members;
                    begin
                        TestForfeitNoticeCanContinue();
                        Rec.TestField(Status, Rec.Status::Approved);

                        if Rec."Exit No." = '' then
                            if Confirm('Are you sure you want to create this Exit Card?') then begin
                                MemberExit.Init();
                                MemberExit."No." := '';
                                MemberExit.Insert(true);
                                MemberExit.Validate("Member No.", Rec."Member No.");
                                MemberExit.Validate("Closing Date", today);
                                MemberExit.Validate("Notice No.", Rec."No.");
                                MemberExit.Validate("Closure Type", rec."Closure Type");
                                MemberExit.Modify();
                                Rec."Exit No." := MemberExit."No.";
                                Rec.Modify();
                            end;

                        Mem.Get(Rec."Member No.");
                        Mem."Member Status" := Mem."Member Status"::"Withdrawal Application";
                        Mem.Modify();

                        MemberExit.Reset();
                        MemberExit.SetRange("No.", Rec."Exit No.");
                        if MemberExit.FindFirst() then
                            Page.Run(50213, MemberExit);


                    end;
                }
                action(CloseAcc)
                {
                    ApplicationArea = Basic;
                    Caption = 'Close Acc';
                    Image = CloseDocument;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = Rec.Status = Rec.Status::Approved;

                    trigger OnAction()
                    var
                        MA: Codeunit "Member Activities";
                    begin
                        Rec.TestField("Withdrawal Type", Rec."Withdrawal Type"::"Account Closure");
                        if Rec."Withdrawal Type" = Rec."Withdrawal Type"::"Account Closure" then
                            MA.CloseAccs(Rec, 0);

                    end;
                }
                action("Summary Member Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Summary Statement';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Member: Record Members;
                    begin
                        Rec.TestField("Member No.");

                        Member.Reset();
                        Member.SetRange("No.", Rec."Member No.");
                        if Member.FindFirst() then
                            Report.Run(Report::"Summary Member Statement", true, false, Member);
                    end;
                }

            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendForApproval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send to HOD';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = Rec."Notice Stage" = Rec."Notice Stage"::"Customer Care";

                    trigger OnAction()
                    var
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                    begin
                        TestForfeitNoticeCanContinue();
                        Rec.TestField(Status, Rec.Status::Open);

                        if not Confirm('Are you sure you want to send this notice for approval to HOD?') then
                            exit;

                        Rec."Notice Stage" := Rec."Notice Stage"::"HOD";
                        Rec.Status := Rec.Status::Pending;
                        Rec.Modify(true);

                        VarVariant := Rec;

                        Message('Notice sent for HOD approval successfully.');
                    end;
                }
                action(SendBackToCustomerCare)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Back to Customer Care';
                    Image = Return;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = Rec."Notice Stage" = Rec."Notice Stage"::"HOD";

                    trigger OnAction()
                    var
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        TestForfeitNoticeCanContinue();
                        if not Confirm('Are you sure you want to send this notice back to Customer Care?') then
                            exit;

                        Rec."Notice Stage" := Rec."Notice Stage"::"Customer Care";
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                    end;
                }

                action(SendToCredit)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send to Credit';
                    Image = Return;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = Rec."Notice Stage" = Rec."Notice Stage"::"HOD";

                    trigger OnAction()
                    var
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        TestForfeitNoticeCanContinue();

                        if not Confirm('Are you sure you want to send this notice To Credit?') then
                            exit;

                        Rec."Notice Stage" := Rec."Notice Stage"::"Credit Department 1";
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                    end;
                }
                action(SendToHODCredit)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send to HOD Credit';
                    Image = Return;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = Rec."Notice Stage" = Rec."Notice Stage"::"Credit Department 1";

                    trigger OnAction()
                    var
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        TestForfeitNoticeCanContinue();
                        if not Confirm('Are you sure you want to send this notice for approval to HOD Credit?') then
                            exit;

                        Rec."Notice Stage" := Rec."Notice Stage"::"HOD Credit";
                        Rec.Status := Rec.Status::Pending;
                        Rec.Modify();
                    end;
                }

                action(SendBackToCredit)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Back to Credit';
                    Image = Return;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = (Rec."Notice Stage" = Rec."Notice Stage"::"HOD Credit") and CanManageHodCredit;

                    trigger OnAction()
                    begin
                        TestForfeitNoticeCanContinue();
                        if not Confirm('Are you sure you want to send this notice back to Credit?') then
                            exit;

                        Rec."Notice Stage" := Rec."Notice Stage"::"Credit Department 1";
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                    end;
                }

                action(SendToFinance)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send To Finance';
                    Image = Return;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = (Rec."Notice Stage" = Rec."Notice Stage"::"HOD Credit") and CanManageHodCredit;

                    trigger OnAction()
                    var
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        TestForfeitNoticeCanContinue();
                        CheckHodCreditAccess();

                        if not Confirm('Are you sure you want to send this notice for approval to Finance?') then
                            exit;

                        Rec."Notice Stage" := Rec."Notice Stage"::"Finance Notice";
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                    end;
                }

                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Enum "Custom Document Type";//Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Member Exit Notice";


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
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;


                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        TestForfeitNoticeCanContinue();

                        if Rec.Status = Rec.Status::Pending then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Rec.Status := Rec.Status::Open;
                            Rec."Notice Stage" := Rec."Notice Stage"::"Customer Care";
                            Rec.Modify;
                        end;
                    end;
                }
            }


        }
    }

    var
        BeneficiaryBool: Boolean;
        AccClosureBool: Boolean;
        ExitGua: Boolean;
        LoansBool: Boolean;
        CanManageHodCredit: Boolean;


    trigger OnOpenPage()
    begin
        UpdateControl();
        if Rec."Notice Stage" = Rec."Notice Stage"::"HOD Credit" then
            CheckHodCreditAccess();
    end;

    local procedure UpdateControl()
    var
        UserSetup: Record "User Setup";
    begin

        if Rec."Closure Type" = Rec."Closure Type"::"Withdrawal - Death" then
            BeneficiaryBool := true
        else
            BeneficiaryBool := false;

        if Rec."Withdrawal Type" = Rec."Withdrawal Type"::"Account CLosure" then
            AccClosureBool := true
        else
            AccClosureBool := false;

        if Rec."Withdrawal Type" = Rec."Withdrawal Type"::"Account CLosure" then
            ExitGua := false
        else
            ExitGua := true;

        CanManageHodCredit := false;
        if UserSetup.Get(UserId) then
            CanManageHodCredit := UserSetup."HOD Credit";

        CurrPage.Editable := (Rec."Notice Stage" = Rec."Notice Stage"::"Credit Department 1") or (Rec."Notice Stage" = Rec."Notice Stage"::"Customer Care");
    end;

    local procedure CheckHodCreditAccess()
    var
        UserSetup: Record "User Setup";
    begin
        if Rec."Notice Stage" <> Rec."Notice Stage"::"HOD Credit" then
            exit;

        if not UserSetup.Get(UserId) then
            exit;

        if not UserSetup."HOD Credit" then
            Error('You do not have permission to access HOD Credit approval.');
    end;

    local procedure CheckControls()
    var
        MemberNotice: Record "Member Exit Notice";
    begin
        TestForfeitNoticeCanContinue();

        // Prevent creating another notice for the same member while an Open or Pending notice exists
        if Rec."Member No." <> '' then begin
            MemberNotice.Reset();
            MemberNotice.SetRange("Member No.", Rec."Member No.");
            MemberNotice.SetFilter(Status, '%1|%2', MemberNotice.Status::Open, MemberNotice.Status::Pending);
            MemberNotice.SetFilter("No.", '<>%1', Rec."No.");
            if MemberNotice.FindFirst() then
                Error('An unposted exit open/pending notice (%1) already exists for this member. Please process it before creating another.', MemberNotice."No.");
        end;

        if Rec."Withdrawal Type" <> Rec."Withdrawal Type"::"Account Closure" then
            if Rec."Closure Type" = Rec."Closure Type"::" " then
                Error('Enter Closure Type');

        Rec.TestField("Member No.");
        //If Closure Type is Quick Withdrawal can be done within the same day
        // TestField("Withdrawa Noticel Date");
        Rec.TestField("Reason for withdrawal");
        Rec.CheckBalances();
    end;

    local procedure TestForfeitNoticeCanContinue()
    var
        ForfeitRequest: Record "Forfeit Exit Request";
    begin
        if Rec.Status = Rec.Status::Forfeited then
            Error('This notice has been forfeited and cannot be changed.');
        if ForfeitRequest.HasActiveForfeitForNotice(Rec."No.") then
            Error('A Forfeit Notice request is pending or approved for this notice.');
        if ForfeitRequest.FindPendingForMember(Rec."Member No.", ForfeitRequest."Forfeit Type"::"Exit Notice") then
            if ForfeitRequest."Notice No." = Rec."No." then
                Error('A Forfeit Notice request is pending for this notice.');
    end;
}

