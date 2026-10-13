page 50100 "Store Requisitions List"
{
    CardPageID = "Store Requisition Header";
    PageType = List;
    Editable = false;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Cancellation,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Store Requisition Header";
    SourceTableView = WHERE(Status = FILTER(Open | "Pending Approval"));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

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
                action("<Action1102755028>")
                {
                    Caption = 'Post Store Requisition';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        if not Rec.LinesExists then
                            Error('There are no Lines created for this Document');

                        if Rec.Status = Rec.Status::Posted then
                            Error('The Document Has Already been Posted');

                        if Rec.Status <> Rec.Status::Released then
                            Error('The Document Has not yet been Approved');


                        Rec.TestField("Issuing Store");
                        ReqLine.Reset;
                        ReqLine.SetRange(ReqLine."Requistion No", Rec."No.");
                        Rec.TestField("Issuing Store");
                        if ReqLine.Find('-') then begin
                            repeat
                            //Issue
                            /*IF InventorySetup.GET THEN BEGIN
                                   InventorySetup.TESTFIELD(InventorySetup."Item Jnl Template");
                                   InventorySetup.TESTFIELD(InventorySetup."Item Jnl Batch");
                                   GenJnline.RESET;
                                   GenJnline.SETRANGE(GenJnline."Journal Template Name",InventorySetup."Item Jnl Template");
                                   GenJnline.SETRANGE(GenJnline."Journal Batch Name",InventorySetup."Item Jnl Batch");
                                   IF GenJnline.FIND('-') THEN GenJnline.DELETEALL;
                                   LineNo:=LineNo+1000;
                                   GenJnline.INIT;
                                   GenJnline."Journal Template Name":=InventorySetup."Item Jnl Template";
                                   GenJnline."Journal Batch Name":=InventorySetup."Item Jnl Batch";
                                   GenJnline."Line No.":=LineNo;
                                   GenJnline."Entry Type":=GenJnline."Entry Type"::"Negative Adjmt.";
                                   GenJnline."Document No.":="No.";
                                   GenJnline."Item No.":=ReqLine."No.";
                                   GenJnline.VALIDATE("Item No.");
                                   GenJnline."Location Code":="Issuing Store";
                                   GenJnline.VALIDATE("Location Code");
                                   GenJnline."Posting Date":="Request date";
                                   GenJnline.Description:=ReqLine.Description;
                                   GenJnline.Quantity:=ReqLine.Quantity;
                                   GenJnline."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
                                   GenJnline.VALIDATE("Shortcut Dimension 1 Code");
                                   GenJnline."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                                   GenJnline.VALIDATE("Shortcut Dimension 2 Code");
                                   GenJnline.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                                   GenJnline.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                                   GenJnline.VALIDATE(Quantity);
                                   GenJnline.VALIDATE("Unit Amount");
                                   GenJnline."Reason Code":='221';
                                   GenJnline.VALIDATE("Reason Code");
                                   GenJnline.INSERT(TRUE);

                                   ReqLine."Request Status":=ReqLine."Request Status"::Closed;

                                END;*/
                            until ReqLine.Next = 0;
                            //Post Entries
                            GenJnline.Reset;
                            //            GenJnline.SETRANGE(GenJnline."Journal Template Name",InventorySetup."Item Jnl Template");
                            //            GenJnline.SETRANGE(GenJnline."Journal Batch Name",InventorySetup."Item Jnl Batch");
                            CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", GenJnline);
                            //End Post entries

                            //Modify All
                            // Post := false;
                            // Post := JournlPosted.PostedSuccessfully();
                            //  if Post then
                        end;

                    end;
                }
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
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
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
        }
    }

    trigger OnOpenPage()
    begin

        /*
        IF UserMgt.GetSetDimensions(USERID,2) <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Shortcut Dimension 2 Code",UserMgt.GetSetDimensions(USERID,2));
          FILTERGROUP(0);
        END;
        */
        Rec.SetFilter("User ID", UserId);

    end;

    var
        //UserMgt: Codeunit "User Setup Management BR";
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

    procedure PageLinesExists(): Boolean
    var
        PayLines: Record "Store Requisition Lines";
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines."Requistion No", Rec."No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
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
        /*  if BCsetup.Get() then begin
             if not BCsetup.Mandatory then begin
                 Exists := false;
                 exit;
             end;
         end else begin
             Exists := false;
             exit;
         end;Rec.*/
        Exists := false;
        PayLine.Reset;
        PayLine.SetRange(PayLine."No.", Rec."No.");
        PayLine.SetRange(PayLine.Committed, false);
        if PayLine.Find('-') then
            Exists := true;
    end;
}

