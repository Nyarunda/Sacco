page 50101 "Store Requisition Header"
{
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Cancellation';
    SourceTable = "Store Requisition Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Request date"; Rec."Request date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Department Code';
                    Editable = statuseditable;
                    ApplicationArea = Basic, Suite;
                }
                field("Function Name"; Rec."Function Name")
                {
                    Caption = 'Description';
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Division Code';
                    Editable = statuseditable;
                    ApplicationArea = Basic, Suite;
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    Caption = 'Description';
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        Rec."Request Description" := Rec."No." + ' ' + Rec."Item Description";
                        Rec.Modify(true);
                    end;
                }
                field("Request Description"; Rec."Request Description")
                {
                    Editable = statuseditable;
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Required Date"; Rec."Required Date")
                {
                    Editable = statuseditable;
                    ApplicationArea = Basic, Suite;
                }
                field("Issuing Store"; Rec."Issuing Store")
                {
                    Editable = true;
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            part(Control1102755015; "Store Requisition Line")
            {
                Editable = true;
                ApplicationArea = Basic, Suite;
                SubPageLink = "Requistion No" = FIELD("No.");

            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Post Store Requisition")
                {
                    Caption = 'Post Store Requisition';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = true;
                    ApplicationArea = Basic, Suite;
                    trigger OnAction()
                    var
                        ItemLedger: Record "Item Ledger Entry";
                    begin
                        if Rec."Posting Date" <> Today then
                            Error('Posting Date must be today (%1).', Today);

                        Rec.PostStoreRequisition();
                    end;
                }
                separator(Separator1102755035)
                {
                }
                action("Print/Preview")
                {
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        REPORT.Run(Report::"Store Requisition", true, true, Rec);
                        Rec.Reset();
                    end;
                }
                action("Cancel Document")
                {
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

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
                    PromotedCategory = Category4;
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin
                        Rec.TestField("Item Description");
                        if not Rec.LinesExists then
                            Error('There are no Lines created for this Document');
                        /*
                        IF NOT AllFieldsEntered THEN
                           ERROR('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');
                           */
                        //Ensure No Items That should be committed that are not
                        if LinesCommitmentStatus then
                            Error('There are some lines that have not been committed');


                        VarVariant := Rec;

                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Store Requisition", Rec."Global Dimension 1 Code", Rec."Shortcut Dimension 2 Code", 0);

                        CurrPage.Close();


                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = Basic;

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
                    PromotedCategory = Category4;
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var

                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Comment)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    ApplicationArea = Basic;
                    RunPageLink = "Table ID" = CONST(39005478),
                                  "Document No." = FIELD("No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPageUpdate;
        SetControlAppearance;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPageUpdate;
        SetControlAppearance;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Reset;
        Rec.SetRange(Status, Rec.Status::Open);
        Rec.SetRange("User ID", UserId);
        if Rec.Find('-') then begin
            if Rec.Count > 0 then begin
                Error('There are still some untilized store requisition Documents [ %1 ]. Please utilise them first'
                      , Rec."No.");
            end;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /* "Responsibility Center" := UserMgt.GetPurchasesFilter();
        //Add dimensions if set by default here
        "Global Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
        Validate("Global Dimension 1 Code");
        "Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        Validate("Shortcut Dimension 2 Code");
        "Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        Validate("Shortcut Dimension 3 Code");
        "Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        Validate("Shortcut Dimension 4 Code");
 */
        UpdateControls;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::"Pending Approval" then
            CurrPage.Editable := false;

        if Rec.Status = Rec.Status::Open then begin
            PageActionsVisible := false;
        end else
            if Rec.Status <> Rec.Status::Open then begin
                PageActionsVisible := true;
            end;


        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;
        */

    end;

    var
        // UserMgt: Codeunit "User Setup Management BR";
        ReqLine: Record "Store Requisition Lines";
        InventorySetup: Record "Inventory Setup";
        ItemJnlLn: Record "Item Journal Line";
        LineNo: Integer;
        Post: Boolean;
        // JournlPosted: Codeunit "Journal Post Successful";
        DocumentType: Enum "Custom Document Type"; //Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,Loan,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","MSacco Applications","MSacco PinChange","MSacco PhoneChange","MSacco TransChange",BulkSMS,"Payment Voucher","Petty Cash",Imp,Requisition,ImpSurr,Interbank,Receipt,"Staff Claim","Staff Adv",AdvSurr,OT;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        ApprovalEntries: Page "Approval Entries";

        StatusEditable: Boolean;

        PageActionsVisible: Boolean;
        Text046: Label 'The %1 does not match the quantity defined in item tracking.';
        ResEntry: Record "Reservation Entry";
        LastResNo: Integer;
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Calwide Approvals";


    procedure UpdateControls()
    begin
        if Rec.Status = Rec.Status::Open then
            StatusEditable := true
        else begin
            StatusEditable := false;
            CurrPage.Editable := false;
        end;

    end;

    procedure CurrPageUpdate()
    begin
        //xRec:=Rec;
        UpdateControls;
        //CurrPage.UPDATE;
    end;

    local procedure CheckTrackingSpecification(var PurchLine: Record "Store Requisition Lines")
    var
        PurchLineToCheck: Record "Store Requisition Lines";
        ReservationEntry: Record "Reservation Entry";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ItemTrackingManagement: Codeunit "Item Tracking Management";
        ErrorFieldCaption: Text[250];
        SignFactor: Integer;
        PurchLineQtyHandled: Decimal;
        PurchLineQtyToHandle: Decimal;
        TrackingQtyHandled: Decimal;
        TrackingQtyToHandle: Decimal;
        Inbound: Boolean;
        SNRequired: Boolean;
        LotRequired: Boolean;
        SNInfoRequired: Boolean;
        LotInfoReguired: Boolean;
        CheckPurchLine: Boolean;
    begin
        // if a PurchaseLine is posted with ItemTracking then the whole quantity of
        // the regarding PurchaseLine has to be post with Item-Tracking

        TrackingQtyToHandle := 0;
        TrackingQtyHandled := 0;

        PurchLineToCheck.Copy(PurchLine);
        // PurchLineToCheck.SetRange(Type, PurchLineToCheck.Type::Item);
        //IF PurchHeader.Receive THEN BEGIN ---- Denno
        //  PurchLineToCheck.SETFILTER("Quantity Received",'<>%1',0);
        //  ErrorFieldCaption := PurchLineToCheck.FIELDCAPTION("Qty. to Receive");
        //END ELSE BEGIN
        //PurchLineToCheck.SetFilter(Quantity, '<>%1', 0);
        //ErrorFieldCaption := PurchLineToCheck.FieldCaption(Quantity);
        //END;

        if PurchLineToCheck.FindSet then begin
            ReservationEntry."Source Type" := DATABASE::"Store Requisition Lines";
            ReservationEntry."Source Subtype" := 0;//PurchHeader."Document Type";
            SignFactor := CreateReservEntry.SignFactor(ReservationEntry);
            repeat
                // Only Item where no SerialNo or LotNo is required
                Item.Get(PurchLineToCheck."No.");
                if Item."Item Tracking Code" <> '' then begin
                    Inbound := (PurchLineToCheck.Quantity * SignFactor) > 0;
                    ItemTrackingCode.Code := Item."Item Tracking Code";
                    /*  ItemTrackingManagement.GetItemTrackingSettings(ItemTrackingCode,
                       ItemJnlLn."Entry Type"::"Negative Adjmt.",
                       Inbound,
                       SNRequired,
                       LotRequired,
                       SNInfoRequired,
                       LotInfoReguired); */
                    CheckPurchLine := (SNRequired = false) and (LotRequired = false);
                    if CheckPurchLine then
                        CheckPurchLine := GetTrackingQuantities(PurchLineToCheck, 0, TrackingQtyToHandle, TrackingQtyHandled);
                end else
                    CheckPurchLine := false;

                TrackingQtyToHandle := 0;
                TrackingQtyHandled := 0;

                if CheckPurchLine then begin
                    GetTrackingQuantities(PurchLineToCheck, 1, TrackingQtyToHandle, TrackingQtyHandled);
                    TrackingQtyToHandle := TrackingQtyToHandle * SignFactor;
                    TrackingQtyHandled := TrackingQtyHandled * SignFactor;
                    /*      IF PurchHeader.Receive THEN BEGIN
                            PurchLineQtyToHandle := PurchLineToCheck."Qty. to Receive (Base)";
                            PurchLineQtyHandled := PurchLineToCheck."Qty. Received (Base)";
                          END ELSE */
                    begin
                        PurchLineQtyToHandle := PurchLineToCheck.Quantity;
                        PurchLineQtyHandled := PurchLineToCheck.Quantity;
                    end;
                    if ((TrackingQtyHandled + TrackingQtyToHandle) <> (PurchLineQtyHandled + PurchLineQtyToHandle)) or
                       (TrackingQtyToHandle <> PurchLineQtyToHandle)
                    then
                        Error(StrSubstNo(Text046, ErrorFieldCaption));
                end;
            until PurchLineToCheck.Next = 0;
        end;

    end;

    local procedure GetTrackingQuantities(PurchLine: Record "Store Requisition Lines"; FunctionType: Option CheckTrackingExists,GetQty; var TrackingQtyToHandle: Decimal; var TrackingQtyHandled: Decimal): Boolean
    var
        TrackingSpecification: Record "Tracking Specification";
        ReservEntry: Record "Reservation Entry";
    begin
        TrackingSpecification.SetCurrentKey("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
  "Source Prod. Order Line", "Source Ref. No.");
        TrackingSpecification.SetRange("Source Type", DATABASE::"Store Requisition Lines");
        TrackingSpecification.SetRange("Source Subtype", 0);
        TrackingSpecification.SetRange("Source ID", PurchLine."Requistion No");
        TrackingSpecification.SetRange("Source Batch Name", '');
        TrackingSpecification.SetRange("Source Prod. Order Line", 0);
        TrackingSpecification.SetRange("Source Ref. No.", PurchLine."Line No.");
        ReservEntry.SetCurrentKey(
  "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
  "Source Batch Name", "Source Prod. Order Line");
        ReservEntry.SetRange("Source ID", PurchLine."Requistion No");
        ReservEntry.SetRange("Source Ref. No.", PurchLine."Line No.");
        ReservEntry.SetRange("Source Type", DATABASE::"Store Requisition Lines");
        ReservEntry.SetRange("Source Subtype", 0);
        ReservEntry.SetRange("Source Batch Name", '');
        ReservEntry.SetRange("Source Prod. Order Line", 0);

        case FunctionType of
            FunctionType::CheckTrackingExists:
                begin
                    TrackingSpecification.SetRange(Correction, false);
                    if not TrackingSpecification.IsEmpty then
                        exit(true);
                    ReservEntry.SetFilter("Serial No.", '<>%1', '');
                    if not ReservEntry.IsEmpty then
                        exit(true);
                    ReservEntry.SetRange("Serial No.");
                    ReservEntry.SetFilter("Lot No.", '<>%1', '');
                    if not ReservEntry.IsEmpty then
                        exit(true);
                end;
            FunctionType::GetQty:
                begin
                    TrackingSpecification.CalcSums("Quantity Handled (Base)");
                    TrackingQtyHandled := TrackingSpecification."Quantity Handled (Base)";
                    if ReservEntry.FindSet then
                        repeat
                            if (ReservEntry."Lot No." <> '') or (ReservEntry."Serial No." <> '') then
                                TrackingQtyToHandle := TrackingQtyToHandle + ReservEntry."Qty. to Handle (Base)";
                        until ReservEntry.Next = 0;
                end;
        end;
    end;

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
        /* if BCsetup.Get() then begin
            if not BCsetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end else begin
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

    local procedure Testfi()
    begin
        ReqLine.Reset;
        ReqLine.SetRange("No.", ReqLine."Requistion No");
        if ReqLine.Find('-') then
            Error(ReqLine."Issuing Store");
    end;
}

