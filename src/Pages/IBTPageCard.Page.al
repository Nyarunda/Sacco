Page 50509 "IBT Page Card"
{
    PageType = Card;
    SourceTable = "IBT Header";
    DeleteAllowed = false;
    SourceTableView = where(Posted = const(false));
    PromotedActionCategories = 'New,Process,Report,Approval Request,Post,Attachment,Print';
    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        //Date:=TODAY;
                    end;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(PayMode; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                }
                field(PayingAccount; Rec."Paying Account")
                {
                    ApplicationArea = Basic;
                }
                field(PayingAccountName; Rec."Paying Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(PayingAccountCurrencyCode; Rec."Paying Account Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field(PayingAccountBalance; Rec."Paying Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field(PayingAccountBalanceLCY; Rec."Paying Account Balance (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(PayingAccountBankNo; Rec."Paying Account Bank No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(AmounttoTransfer; Rec."Amount to Transfer")
                {
                    ApplicationArea = Basic;
                }
                field(AmounttoTransferLCY; Rec."Amount to Transfer (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(ChequeDocNo; Rec."Cheque / Doc. No")
                {
                    ApplicationArea = Basic;
                }
                field(TransferReleaseDate; Rec."Transfer Release Date")
                {
                    ApplicationArea = Basic;
                }
                field(TotalLinesAmountLCY; Rec."Total Lines Amount (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    Caption = 'Description';
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(PayingAccountMaxCredit; Rec."Paying Account Max. Credit")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control24; "IBT Lines")
            {
                ApplicationArea = all;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                begin

                    //Check Required Fields
                    CheckRequiredFields;

                    Rec.TestField("Transfer Release Date");
                    Rec.TestField(Status, Rec.Status::Approved);
                    SaccoActivities.GetPaymentJournalTemplate("Inter Bank Template Name", "Inter Bank Journal Batch");


                    //Check whether the "Line Amounts" to be Transfered is the same as "Amount to Transfer" in the header
                    Rec.CalcFields("Total Lines Amount (LCY)");
                    if Rec."Total Lines Amount (LCY)" <> Rec."Amount to Transfer (LCY)" then begin
                        Error(Text001, Rec."Amount to Transfer (LCY)", Rec."Total Lines Amount (LCY)");
                    end;

                    //Check if the transaction will lead to a Negative Account Balance in the Paying Account Bank
                    BankAcc.Reset;
                    BankAcc.SetRange(BankAcc."No.", Rec."Paying Account");
                    if BankAcc.FindFirst then begin
                        BankAcc.CalcFields(BankAcc.Balance);

                        currBankBalance := BankAcc.Balance - Rec."Amount to Transfer";

                        //For normal banks with no Credit Agreement
                        if (currBankBalance < 0) then begin
                            Message(Text002, currBankBalance, Rec."Paying Account", Rec."Paying Account Name");
                        end;

                        //For banks with credit agreeement
                        if (currBankBalance < 0) then begin

                            NewBankBalanceAfterPost := BankAcc.Balance - Rec."Amount to Transfer";
                            if NewBankBalanceAfterPost < BankAcc."Maximum Credit Limit" then begin
                                Message(Text006, Rec."Paying Account", Rec."Paying Account Name");
                            end else begin
                                //Do Nothing
                            end;

                        end;

                    end;


                    //Clear Users Batch
                    GenJnlLine.Reset;
                    GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Inter Bank Template Name");
                    GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Inter Bank Journal Batch");
                    GenJnlLine.DeleteAll;

                    //Inserting Amounts of Accounts to be Debited into the Journal (+)
                    IBTLines.Reset;
                    IBTLines.SetRange(IBTLines."No.", Rec."No.");
                    if IBTLines.Find('-') then begin
                        repeat
                            IBTLines.TestField("External Doc No.");
                            Insert_IBTLines_to_Journal;
                        until IBTLines.Next = 0;
                    end;

                    //Insert Amounts of Accounts to "Credit" (-) into the Journal
                    Insert_IBTHead_to_Journal;


                    Rec.Posted := true;
                    Rec."Date Posted" := Today;
                    Rec."Time Posted" := Time;
                    Rec."Posted By" := UserId;
                    //"Posted On Computer Name":='';
                    Rec.Modify;

                    Message('The Journal Has Been Posted Successfully');

                    SaccoActivities.JournalPost("Inter Bank Template Name", "Inter Bank Journal Batch");

                    //MESSAGE('Lines transfered to Payments Journal and Batch Name %1 for posting',"Inter Bank Journal Batch");
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
                        DocumentType: Enum "Custom Document Type";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: variant;
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        VarVariant := Rec;
                        CheckRequiredFields;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Inter-Bank Transfers", '', '', 0);
                        CurrPage.Close();
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
                        VarVariant: variant;
                        DocumentType: Enum "Custom Document Type";
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
                        ApprovalEntries: Page System.Automation."Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocType: Enum "Custom Document Type";
                        ApprovalTracker: Record "Approval Tracker";
                        VarVariant: variant;
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocType := Doctype::"Inter-Bank Transfers";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
                        ApprovalTracker.SetRange("Document Type", DocType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        if (Rec.Status <> Rec.Status::Open) and (Rec.Status <> Rec.Status::Pending) then begin

                            if not Confirm('Are you sure you want to re-open document?') then exit;
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                }
            }
            action(Print)
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Category7;
                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetFilter("No.", Rec."No.");
                    Report.Run(Report::"Interbank List Report", true, true, Rec);
                    Rec.Reset;
                end;
            }
            action(ATTTACHMENT)
            {
                ApplicationArea = Basic;
                Caption = 'Attachment';
                Image = Attach;
                Promoted = true;
                PromotedCategory = category6;
                trigger OnAction()
                begin
                    DMSInt.Reset;
                    DMSInt.SetRange(DMSInt."Link Type", DMSInt."link type"::transfers);
                    if DMSInt.Find('-') then begin
                        Hyperlink(DMSInt."Path" + Rec."No.");
                    end;
                end;
            }
        }
    }

    var
        GenJnlLine: Record "Gen. Journal Line";
        JTemplate: Code[20];
        "Inter Bank Template Name": Code[50];
        "Inter Bank Journal Batch": Code[50];
        BankAcc: Record "Bank Account";
        LineNo: Integer;
        IBTLines: Record "IBT Lines";
        Post: Boolean;
        ApprovalEntries: Page System.Automation."Approval Entries";
        ApprovalEntry: Record "Approval Entry";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Payment Voucher","Petty Cash",Interbank,"None","IB Transfer";
        PBEditable: Boolean;
        currBankBalance: Decimal;
        NewBankBalanceAfterPost: Decimal;
        Text001: label 'The [Requested Amount to Transfer in LCY: %1] should be same as the [Total Line Amount in LCY: %2]';
        Text002: label 'The Transaction will result in a negative Balance of [%1] in Bank Account [%2 - %3]';
        Text003: label 'Sorry you are not authorised to Cancel Petty Cash Documents. Please liase with the Approver (%1)';
        Text004: label 'Document % 1 is already POSTED and cannot be reverted to Pending';
        Text006: label 'The Transaction will result in a negative Maximum Credit Limit Balance of in Bank Account [%1 - %2]';
        DMSInt: Record "DMS Endpoints";


    procedure CheckRequiredFields()
    begin
        Rec.TestField("Amount to Transfer");
        //Check Lines if Cheque No has been specified
        IBTLines.Reset;
        IBTLines.SetRange(IBTLines."No.", Rec."No.");
        if IBTLines.Find('-') then begin
            repeat
                IBTLines.TestField(IBTLines."Pay Mode");
                //if IBTLines."Pay Mode" = IBTLines."pay mode"::Cheque then begin
                IBTLines.TestField(IBTLines."External Doc No.");
            //end;
            until IBTLines.Next = 0;
        end;

        //Check whether the "Line Amounts" to be Transfered is the same as "Amount to Transfer" in the header
        Rec.CalcFields("Total Lines Amount (LCY)");
        if Rec."Total Lines Amount (LCY)" <> Rec."Amount to Transfer (LCY)" then begin
            Error(Text001, Rec."Amount to Transfer (LCY)", Rec."Total Lines Amount (LCY)");
        end;
    end;


    procedure Insert_IBTLines_to_Journal()
    begin
        //Get Last Line No in Journal
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Inter Bank Template Name");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Inter Bank Journal Batch");
        if GenJnlLine.Find('+') then begin
            LineNo := GenJnlLine."Line No." + 1;
        end else begin
            LineNo := 1000;
        end;

        //Insert Into Journal
        GenJnlLine.Init;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Journal Template Name" := "Inter Bank Template Name";
        GenJnlLine."Journal Batch Name" := "Inter Bank Journal Batch";
        GenJnlLine."Posting Date" := Rec."Transfer Release Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
        GenJnlLine."Account No." := IBTLines."Recieving Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Description := 'Inter-Bank Transfer Ref No: ' + Format(Rec."No.");
        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        //GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        //GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code1");
        //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code1");
        GenJnlLine."External Document No." := IBTLines."External Doc No.";
        if Rec.Remarks = '' then begin
            GenJnlLine.Description := 'Inter-Bank Transfer Ref No: ' + Format(Rec."No.");
        end else begin
            GenJnlLine.Description := Rec.Remarks;
        end;
        GenJnlLine."Currency Code" := IBTLines."Recievin Account Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");

        if IBTLines."Recievin Account Currency Code" <> '' then begin
            GenJnlLine."Currency Factor" := IBTLines."Amount to Receive (LCY)";
            GenJnlLine.Validate(GenJnlLine."Currency Factor");
        end;

        GenJnlLine.Amount := IBTLines."Amount to Receive";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine.Insert;
    end;


    procedure Insert_IBTHead_to_Journal()
    begin
        //Get Last Line No in Journal
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Inter Bank Template Name");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Inter Bank Journal Batch");
        if GenJnlLine.Find('+') then begin
            LineNo := GenJnlLine."Line No." + 1;
        end else begin
            LineNo := 1000;
        end;

        GenJnlLine.Init;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Journal Template Name" := "Inter Bank Template Name";
        GenJnlLine."Journal Batch Name" := "Inter Bank Journal Batch";
        GenJnlLine."Posting Date" := Rec."Transfer Release Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
        GenJnlLine."Account No." := Rec."Paying Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        //GenJnlLine."Shortcut Dimension 1 Code":="Source Depot Code";
        //GenJnlLine."Shortcut Dimension 2 Code":="Source Department Code";
        //GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        //GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
        //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
        GenJnlLine."External Document No." := Rec."Cheque / Doc. No";
        if Rec.Remarks = '' then begin
            GenJnlLine.Description := 'Inter-Bank Transfer Ref No:' + Format(Rec."No.");
        end else begin
            GenJnlLine.Description := Rec.Remarks;
        end;
        GenJnlLine."Currency Code" := Rec."Paying Account Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        if Rec."Paying Account Currency Code" <> '' then begin
            GenJnlLine."Currency Factor" := Rec."Exchange Rate";
            //Rec. //Exchange Rate of Paying Account
            GenJnlLine.Validate(GenJnlLine."Currency Factor");
        end;
        GenJnlLine.Amount := -Rec."Amount to Transfer";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine.Insert;
    end;


    procedure UpdateControl()
    begin
        /*
        IF Status=Status::Open THEN BEGIN
            Currpage."Paying Account".EDITABLE:=TRUE;
            Currpage.Remarks.EDITABLE:=TRUE;
            Currpage."Amount to Transfer".EDITABLE:=TRUE;
            Currpage.IBTLines.EDITABLE:=TRUE;
            //Currpage."Transfer Release Date".EDITABLE:=FALSE;
            Currpage.UPDATECONTROLS;
        END;
        */
        if Rec.Status <> Rec.Status::Open then begin
            CurrPage.Editable := false;
            //Currpage.UPDATECONTROLS
        end;
        /*
        IF Status=Status::Approved THEN
        BEGIN
            //message('');
            Currpage."Paying Account".EDITABLE:=FALSE;
            Currpage.Remarks.EDITABLE:=FALSE;
            //Currpage."Amount to Transfer".EDITABLE:=FALSE;
            Currpage.IBTLines.EDITABLE:=FALSE;
            Currpage.UPDATECONTROLS;
        END;
        //Currpage.UPDATE(FALSE);
         */

    end;
}

