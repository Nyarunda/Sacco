page 50105 "Cancelled Store Requisitions"
{
    ApplicationArea = All;
    CardPageID = "Store Requisition Header";
    PageType = List;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Cancellation,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Store Requisition Header";
    SourceTableView = WHERE(Status = FILTER(Cancelled));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Request date"; Rec."Request date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Function Name"; Rec."Function Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Request Description"; Rec."Request Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requester ID"; Rec."Requester ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(TotalAmount; Rec.TotalAmount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Issuing Store"; Rec."Issuing Store")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755010; Notes)
            {
            }
            systempart(Control1102755011; MyNotes)
            {
            }
            systempart(Control1102755012; Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1102755026>")
            {
                Caption = '&Functions';
                separator(Separator1102755014)
                {
                }
                action("<Action1102755036>")
                {
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        if Rec.FindFirst() then
                        REPORT.Run(Report::"Store Requisition", true, true, Rec);
                        Rec.Reset;
                    end;
                }
                action("Cancel Document")
                {
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to cancel this document?';
                        Text001: Label 'You have Selected not to cancle this document';
                    begin
                        //TESTFIELD(Status,Status::Approved);
                        if Confirm(Text000, true) then begin
                            //Post Reversal Entries for Commitments
                            //Doc_Type:=Doc_Type::PettyCash;
                            //CheckBudgetAvail.ReverseEntries(Doc_Type,"No.");
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                        end else
                            Error(Text001);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        if not Rec.LinesExists then
                            Error('There are no Lines created for this Document');

                        if not AllFieldsEntered then
                            Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //Ensure No Items That should be committed that are not
                        if LinesCommitmentStatus then
                            Error('There are some lines that have not been committed');

                        VarVariant := Rec;
                        if CustomApprovals.CheckWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocForApproval(VarVariant);
                    end;
                }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        /*
                        DocumentType := DocumentType::"Payment Voucher";
                        ApprovalEntries.Setfilters(DATABASE::"Payments Header","Document Type","No.");
                        ApprovalEntries.RUN;
                        */
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);

                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        /*    if UserMgt.GetPurchasesFilter() <> '' then begin
               FilterGroup(2);
               SetRange("Responsibility Center", UserMgt.GetPurchasesFilter());
               FilterGroup(0);
           end; */
        /*
        IF UserMgt.GetSetDimensions(USERID,2) <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Shortcut Dimension 2 Code",UserMgt.GetSetDimensions(USERID,2));
          FILTERGROUP(0);
        END;
        */

    end;

    var
        // UserMgt: Codeunit "User Setup Management BR";
        ReqLine: Record "Store Requisition Lines";
        InventorySetup: Record "Inventory Setup";
        GenJnline: Record "Item Journal Line";
        LineNo: Integer;
        Post: Boolean;
        // JournlPosted: Codeunit "Journal Post Successful";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Calwide Approvals";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;



    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Store Requisition Lines";
    begin
        AllKeyFieldsEntered := true;
        PayLines.Reset;
        PayLines.SetRange(PayLines."No.", Rec."No.");
        if PayLines.Find('-') then begin
            repeat
                if (PayLines."No." = '') or (PayLines."Quantity Requested" <= 0) then
                    AllKeyFieldsEntered := false;
            until PayLines.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    procedure LinesCommitmentStatus() Exists: Boolean
    var
        // BCsetup: Record "Budgetary Control Setup";
        PayLine: Record "Store Requisition Lines";
    begin
        /*   if BCsetup.Get() then begin
              if not BCsetup.Mandatory then begin
                  Exists := false;
                  exit;
              end; */
        /*  end else begin
                 Exists := false;
                 exit;
             end; */
        Exists := false;
        PayLine.Reset;
        PayLine.SetRange(PayLine."No.", Rec."No.");
        PayLine.SetRange(PayLine.Committed, false);
        if PayLine.Find('-') then
            Exists := true;
    end;
}

