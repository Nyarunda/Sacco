codeunit 50114 "Calwide Approval Management"
{
    Permissions = TableData "Approval Entry" = rim;

    procedure MakeApprovalEntry(TableID: Integer; DocType: Enum "Custom Document Type"; DocNo: Code[20]; SalespersonPurchaser: Code[10]; ApprovalSetup: Record "Approval Setup"; ApproverId: Code[50]; ApprovalCode: Code[20]; UserSetup: Record "User Setup"; ApprovalAmount: Decimal; ApprovalAmountLCY: Decimal; CurrencyCode: Code[10]; ApprovalTemplates: Record "Approval Templates"; ExeedAmountLCY: Decimal)
    var
        ApprovalEntry: Record "Approval Entry";
        NewSequenceNo: Integer;
        Tracker: Record "Approval Tracker";
        LineNo: Integer;
    begin


        Tracker.Get(DocNo);
        DocNo := Tracker."Document No.";
        LineNo := 1;

        ApprovalEntry.Reset();
        if ApprovalEntry.FindLast then
            LineNo := ApprovalEntry."Entry No." + 1;

        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Table ID", TableID);
        ApprovalEntry.SetRange("Custom Document Type", Tracker."Custom Document Type");
        ApprovalEntry.SetRange("Document No.", DocNo);
        if ApprovalEntry.FindLast then
            NewSequenceNo := ApprovalEntry."Sequence No." + 1
        else
            NewSequenceNo := 1;

        ApprovalEntry.Init();

        ApprovalEntry."Entry No." := LineNo;
        ApprovalEntry."Table ID" := TableID;
        ApprovalEntry."Custom Document Type" := Tracker."Custom Document Type";

        ApprovalEntry."Document No." := DocNo;
        ApprovalEntry."Record ID to Approve" := Tracker."Record ID to Approve";
        ApprovalEntry."Tracker ID" := Tracker."Tracker ID";
        ApprovalEntry."Salespers./Purch. Code" := SalespersonPurchaser;
        ApprovalEntry."Sequence No." := NewSequenceNo;
        ApprovalEntry."Approval Code" := ApprovalTemplates."Approval Code";
        ApprovalEntry."Sender ID" := UserId;
        ApprovalEntry.Amount := ApprovalAmount;
        ApprovalEntry."Amount (LCY)" := ApprovalAmountLCY;
        ApprovalEntry."Currency Code" := CurrencyCode;
        ApprovalEntry."Document Table ID" := TableID;
        ApprovalEntry.Name := Tracker.Name;
        ApprovalEntry.Name2 := Tracker.Details;
        ApprovalEntry."Approver ID" := ApproverId;
        if ApproverId = UserId then
            ApprovalEntry.Status := ApprovalEntry.Status::Approved
        else
            ApprovalEntry.Status := ApprovalEntry.Status::Created;
        ApprovalEntry."Date-Time Sent for Approval" := CreateDatetime(Today, Time);
        ApprovalEntry."Last Date-Time Modified" := CreateDatetime(Today, Time);

        ApprovalEntry."Last Modified By User ID" := UserId;
        ApprovalEntry."Due Date" := CalcDate(ApprovalSetup."Due Date Formula", Today);
        ApprovalEntry."Approval Type" := ApprovalTemplates."Approval Type";
        ApprovalEntry."Limit Type" := ApprovalTemplates."Limit Type";
        ApprovalEntry."Available Credit Limit (LCY)" := ExeedAmountLCY;
        ApprovalEntry.Insert(true);


    end;


    procedure ApproveApprovalRequest(ApprovalEntry: Record "Approval Entry"): Boolean
    var
        Tracker: Record "Approval Tracker";
        PurchaseHeader: Record "Purchase Header";
        ApprovalSetup: Record "Approval Setup";
        SaccoSetup: Record "Sacco Setup";
        NextApprovalEntry: Record "Approval Entry";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        IntDocNo: Code[20];

    begin

        //Original - begin
        /*
        IF ApprovalEntry."Table ID" <> 0 THEN BEGIN
          ApprovalEntry.Status := ApprovalEntry.Status::Approved;
          ApprovalEntry."Last Date-Time Modified" := CREATEDATETIME(TODAY,TIME);
          ApprovalEntry."Last Modified By ID" := USERID;
          ApprovalEntry.MODIFY;
          NextApprovalEntry.SETCURRENTKEY("Table ID","Custom Document Type","Document No.");
          NextApprovalEntry.SETRANGE("Table ID",ApprovalEntry."Table ID");
          NextApprovalEntry.SETRANGE("Custom Document Type",ApprovalEntry."Document Type");
          NextApprovalEntry.SETRANGE("Document No.",ApprovalEntry."Document No.");
          NextApprovalEntry.SETFILTER(Status,'%1|%2',NextApprovalEntry.Status::Created,NextApprovalEntry.Status::Open);
          IF NextApprovalEntry.FINDFIRST THEN BEGIN
            IF NextApprovalEntry.Status = NextApprovalEntry.Status::Open THEN
              EXIT(FALSE);
        
            NextApprovalEntry.Status := NextApprovalEntry.Status::Open;
            NextApprovalEntry."Date-Time Sent for Approval" := CREATEDATETIME(TODAY,TIME);
            NextApprovalEntry."Last Date-Time Modified" := CREATEDATETIME(TODAY,TIME);
            NextApprovalEntry."Last Modified By ID" := USERID;
            NextApprovalEntry.MODIFY;
            IF ApprovalSetup.GET THEN
              IF ApprovalSetup.Approvals THEN BEGIN
                IF ApprovalEntry."Table ID" = DATABASE::"Sales Header" THEN BEGIN
                  IF SalesHeader.GET(NextApprovalEntry."Document Type",NextApprovalEntry."Document No.") THEN
                    ApprovalMgtNotification.SendSalesApprovalsMail(SalesHeader,NextApprovalEntry);
                END ELSE
                  IF PurchaseHeader.GET(NextApprovalEntry."Document Type",NextApprovalEntry."Document No.") THEN
                    ApprovalMgtNotification.SendPurchaseApprovalsMail(PurchaseHeader,NextApprovalEntry);
              END;
            EXIT(FALSE);
          END;
          IF ApprovalEntry."Table ID" = DATABASE::"Sales Header" THEN BEGIN
            IF SalesHeader.GET(ApprovalEntry."Document Type",ApprovalEntry."Document No.") THEN
              ReleaseSalesDoc.RUN(SalesHeader);
          END ELSE
            IF PurchaseHeader.GET(ApprovalEntry."Document Type",ApprovalEntry."Document No.") THEN
              ReleasePurchaseDoc.RUN(PurchaseHeader);
          EXIT(TRUE);
        END;
        
         */
        //Original - END
        if ApprovalEntry."Table ID" <> 0 then begin
            ApprovalEntry.Status := ApprovalEntry.Status::Approved;
            ApprovalEntry."Last Date-Time Modified" := CreateDatetime(Today, Time);
            ApprovalEntry."Last Modified By User ID" := UserId;
            ApprovalEntry.Modify;

            //NextApprovalEntry.SetCurrentkey("Table ID", "Custom Document Type", "Document No.");
            NextApprovalEntry.SetRange("Table ID", ApprovalEntry."Table ID");
            NextApprovalEntry.SetRange("Custom Document Type", ApprovalEntry."Custom Document Type");
            NextApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
            NextApprovalEntry.SetFilter(Status, '%1|%2', NextApprovalEntry.Status::Created, NextApprovalEntry.Status::Open);
            if NextApprovalEntry.Find('-') then begin
                if NextApprovalEntry.Status = NextApprovalEntry.Status::Open then
                    exit(false)
                else begin
                    NextApprovalEntry.Status := NextApprovalEntry.Status::Open;
                    NextApprovalEntry."Date-Time Sent for Approval" := CreateDatetime(Today, Time);
                    NextApprovalEntry."Last Date-Time Modified" := CreateDatetime(Today, Time);

                    NextApprovalEntry."Last Modified By User ID" := UserId;
                    NextApprovalEntry.Modify;

                    exit(false);
                end;
            end
            else begin

                SaccoSetup.get;
                if not SaccoSetup."Allow Self Approval" then
                    if ApprovalEntry."Sender ID" = UserId then
                        Error('You are not allowed to approve your own documents');

                if tracker.get(ApprovalEntry."tracker id") then begin
                    tracker.Status := tracker.Status::Approved;
                    tracker.Modify;
                    tracker.Validate(tracker.Status);

                    CalwideAprrovals.UpdateTrackerDocument(Tracker, Tracker.Status::Approved);
                end

            end;
            exit(true);
        end;
        //END;
        //END;

    end;


    procedure RejectApprovalRequest(ApprovalEntry: Record "Approval Entry")
    var
        ApprovalSetup: Record "Approval Setup";
        PurchaseHeader: Record "Purchase Header";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        SendMail: Boolean;
        GenJnlBatch: Record "Gen. Journal Batch";
        IntDocNo: Code[20];
        Tracker: Record "Approval Tracker";
    begin
        //Original code
        /*
        IF ApprovalEntry."Table ID" <> 0 THEN BEGIN
          ApprovalSetup.GET;
          ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
          ApprovalEntry."Last Date-Time Modified" := CREATEDATETIME(TODAY,TIME);
          ApprovalEntry."Last Modified By ID" := USERID;
          ApprovalEntry.MODIFY;
          IF ApprovalSetup.Rejections THEN
            SendRejectionMail(ApprovalEntry,AppManagement);
          ApprovalEntry.SETCURRENTKEY("Table ID","Document Type","Document No.","Sequence No.");
          ApprovalEntry.SETRANGE("Table ID",ApprovalEntry."Table ID");
          ApprovalEntry.SETRANGE("Document Type",ApprovalEntry."Document Type");
          ApprovalEntry.SETRANGE("Document No.",ApprovalEntry."Document No.");
          ApprovalEntry.SETFILTER(Status,'<>%1&<>%2',ApprovalEntry.Status::Canceled,ApprovalEntry.Status::Rejected);
          IF ApprovalEntry.FIND('-') THEN
            REPEAT
              SendMail := FALSE;
              IF (ApprovalEntry.Status = ApprovalEntry.Status::Open) OR
                 (ApprovalEntry.Status = ApprovalEntry.Status::Approved)
              THEN
                SendMail := TRUE;
        
              ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
              ApprovalEntry."Last Date-Time Modified" := CREATEDATETIME(TODAY,TIME);
              ApprovalEntry."Last Modified By ID" := USERID;
              ApprovalEntry.MODIFY;
              IF ApprovalSetup.Rejections AND SendMail THEN
                SendRejectionMail(ApprovalEntry,AppManagement);
            UNTIL ApprovalEntry.NEXT = 0;
          IF ApprovalSetup.Rejections THEN
            AppManagement.SendMail;
          IF ApprovalEntry."Table ID" = DATABASE::"Sales Header" THEN BEGIN
            SalesHeader.SETCURRENTKEY("Document Type","No.");
            SalesHeader.SETRANGE("Document Type",ApprovalEntry."Document Type");
            SalesHeader.SETRANGE("No.",ApprovalEntry."Document No.");
            IF SalesHeader.FINDFIRST THEN
              ReleaseSalesDoc.Reopen(SalesHeader);
          END ELSE BEGIN
            PurchaseHeader.SETCURRENTKEY("Document Type","No.");
            PurchaseHeader.SETRANGE("Document Type",ApprovalEntry."Document Type");
            PurchaseHeader.SETRANGE("No.",ApprovalEntry."Document No.");
            IF PurchaseHeader.FINDFIRST THEN
              ReleasePurchaseDoc.Reopen(PurchaseHeader);
          END;
        END;
        */
        //original code end




        if ApprovalEntry."Table ID" <> 0 then begin
            ApprovalSetup.Get;
            ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
            ApprovalEntry."Last Date-Time Modified" := CreateDatetime(Today, Time);
            ApprovalEntry."Last Modified By User ID" := UserId;
            ApprovalEntry.Modify;
            //if ApprovalSetup.Rejections then
            //  SendRejectionMail(ApprovalEntry, AppManagement);
            //ApprovalEntry.SetCurrentkey("Table ID", "Custom Document Type", "Document No.", "Sequence No.");
            ApprovalEntry.SetRange("Table ID", ApprovalEntry."Table ID");
            ApprovalEntry.SetRange("Custom Document Type", ApprovalEntry."Custom Document Type");
            ApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
            ApprovalEntry.SetFilter(Status, '<>%1&<>%2', ApprovalEntry.Status::Canceled, ApprovalEntry.Status::Rejected);
            if ApprovalEntry.Find('-') then
                repeat
                    SendMail := false;
                    if (ApprovalEntry.Status = ApprovalEntry.Status::Open) or
                       (ApprovalEntry.Status = ApprovalEntry.Status::Approved) then
                        SendMail := true;

                    ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
                    ApprovalEntry."Last Date-Time Modified" := CreateDatetime(Today, Time);
                    ApprovalEntry."Last Modified By User ID" := UserId;
                    ApprovalEntry.Modify;
                //if ApprovalSetup.Rejections and SendMail then
                //  SendRejectionMail(ApprovalEntry, AppManagement);
                until ApprovalEntry.Next = 0;
            //if ApprovalSetup.Rejections then
            //  AppManagement.SendMail;


            if tracker.get(ApprovalEntry."tracker id") then begin
                tracker.Status := tracker.Status::Rejected;
                tracker.Modify;
                tracker.Validate(tracker.Status);

                CalwideAprrovals.UpdateTrackerDocument(Tracker, Tracker.Status::"Rejected");
            end



        end;

    end;


    procedure DelegateApprovalRequest(ApprovalEntry: Record "Approval Entry")
    var
        UserSetup: Record "User Setup";
        ApprovalSetup: Record "Approval Setup";
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
        GenJnlBatch: Record "Gen. Journal Batch";
        IntDocNo: Code[20];

    begin
        UserSetup.SetRange("User ID", ApprovalEntry."Approver ID");
        if not UserSetup.FindFirst then
            Error(Text005, ApprovalEntry."Approver ID");

        if not ApprovalSetup.Get then
            Error(Text004);


        if UserSetup.Substitute <> '' then begin
            UserSetup.Reset;
            UserSetup.SetRange("User ID", UserSetup.Substitute);
            if UserSetup.FindFirst then begin
                ApprovalEntry."Last Modified By User ID" := UserId;
                ApprovalEntry."Last Date-Time Modified" := CreateDatetime(Today, Time);
                ApprovalEntry."Approver ID" := UserSetup."User ID";
                ApprovalEntry.Modify;


                case ApprovalEntry."Table ID" of
                    Database::"Sales Header":
                        begin
                            //if ApprovalSetup.Delegations then
                            //  if SalesHeader.Get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then
                            //    AppManagement.SendSalesDelegationsMail(SalesHeader, ApprovalEntry);
                        end;
                    Database::"Purchase Header":
                        begin
                            //if ApprovalSetup.Delegations then
                            //  if PurchaseHeader.Get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then
                            //    AppManagement.SendPurchaseDelegationsMail(PurchaseHeader, ApprovalEntry);
                        end;
                    232: //General Journal Batch
                        begin


                        end;

                end;
            end;
        end else
            Error(Text007, UserSetup.FieldCaption(Substitute), UserSetup."User ID");
    end;


    procedure MoveApprvalEntryToPosted(var ApprovalEntry: Record "Approval Entry"; ToTableId: Integer; ToNo: Code[20])
    var
        PostedApprvlEntry: Record "Posted Approval Entry";
        ApprovalCommentLine: Record "Approval Comment Line";
        PostedApprovalCommentLine: Record "Posted Approval Comment Line";
    begin
        if ApprovalEntry.Find('-') then
            repeat
                PostedApprvlEntry.Init;
                PostedApprvlEntry.TransferFields(ApprovalEntry);
                PostedApprvlEntry."Table ID" := ToTableId;
                PostedApprvlEntry."Document No." := ToNo;
                PostedApprvlEntry.Insert;
            until ApprovalEntry.Next = 0;

        ApprovalCommentLine.SetRange("Table ID", ApprovalEntry."Table ID");
        ApprovalCommentLine.SetRange("Document Type", ApprovalEntry."Document Type");
        ApprovalCommentLine.SetRange("Document No.", ApprovalEntry."Document No.");
        if ApprovalCommentLine.Find('-') then
            repeat
                PostedApprovalCommentLine.Init;
                PostedApprovalCommentLine.TransferFields(ApprovalCommentLine);
                PostedApprovalCommentLine."Entry No." := 0;
                PostedApprovalCommentLine."Table ID" := ToTableId;
                PostedApprovalCommentLine."Document No." := ToNo;
                PostedApprovalCommentLine.Insert(true);
            until ApprovalCommentLine.Next = 0;
    end;


    procedure DeleteApprovalEntry(TableId: Integer; DocumentType: Enum "Custom Document Type"; DocumentNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetRange("Table ID", TableId);
        ApprovalEntry.SetRange("Document Type", DocumentType);
        ApprovalEntry.SetRange("Document No.", DocumentNo);
        DeleteApprovalCommentLine(TableId, DocumentType, DocumentNo);
        if ApprovalEntry.FindFirst then
            ApprovalEntry.DeleteAll;
    end;


    procedure DeleteApprovalCommentLine(TableId: Integer; DocumentType: Enum "Custom Document Type"; DocumentNo: Code[20])
    var
        ApprovalCommentLine: Record "Approval Comment Line";
    begin
        ApprovalCommentLine.SetRange("Table ID", TableId);
        ApprovalCommentLine.SetRange("Document Type", DocumentType);
        ApprovalCommentLine.SetRange("Document No.", DocumentNo);
        if ApprovalCommentLine.FindFirst then
            ApprovalCommentLine.DeleteAll;
    end;


    procedure DeletePostedApprovalEntry(TableId: Integer; DocumentNo: Code[20])
    var
        PostedApprovalEntry: Record "Posted Approval Entry";
    begin
        PostedApprovalEntry.SetRange("Table ID", TableId);
        PostedApprovalEntry.SetRange("Document No.", DocumentNo);
        DeletePostedApprvlCommentLine(TableId, DocumentNo);
        if PostedApprovalEntry.FindFirst then
            PostedApprovalEntry.DeleteAll;
    end;


    procedure DeletePostedApprvlCommentLine(TableId: Integer; DocumentNo: Code[20])
    var
        PostedApprovalCommentLine: Record "Posted Approval Comment Line";
    begin
        PostedApprovalCommentLine.SetRange("Entry No.", TableId);
        PostedApprovalCommentLine.SetRange("Document No.", DocumentNo);
        if PostedApprovalCommentLine.FindFirst then
            PostedApprovalCommentLine.DeleteAll;
    end;


    procedure InsertAddApprovers(AppTemplate: Record "Approval Templates")
    var
        AddApprovers: Record "Additional Approvers";
    begin
        Clear(AddApproversTemp);
        //AddApprovers.SetCurrentkey("Sequence No.");
        AddApprovers.SetRange("Approval Code", AppTemplate."Approval Code");
        AddApprovers.SetRange("Approval Type", AppTemplate."Approval Type");
        AddApprovers.SetRange("Document Type", AppTemplate."Document Type");
        AddApprovers.SetRange("Custom Document Type", AppTemplate."Custom Document Type");
        AddApprovers.SetRange("Limit Type", AppTemplate."Limit Type");
        if AddApprovers.Find('-') then
            repeat
                AddApproversTemp := AddApprovers;
                AddApproversTemp.Insert;
            until AddApprovers.Next = 0;
    end;


    procedure CheckCreditLimit(SalesHeader: Record "Sales Header"): Decimal
    var
        Customer: Record Customer;
    begin
        if not Customer.Get(SalesHeader."Bill-to Customer No.") then
            exit(0);
        exit(Customer.CalcAvailableCredit);
    end;


    procedure CheckAddApprovers(AppTemplate: Record "Approval Templates")
    begin
        AppTemplate.CalcFields("Additional Approvers");
        if AppTemplate."Additional Approvers" then
            InsertAddApprovers(AppTemplate);
    end;


    procedure InsertDefaultApprovalCode(var ApprovalCodeRec: Record "Approval Code"; ApprovalCode: Code[20]; ApprovalName: Text[100]; TableId: Integer; Tablename: Text[50])
    begin
        ApprovalCodeRec.Init;
        ApprovalCodeRec.Code := ApprovalCode;
        ApprovalCodeRec.Description := ApprovalName;
        ApprovalCodeRec."Linked To Table Name" := Tablename;
        ApprovalCodeRec."Linked To Table No." := TableId;
        ApprovalCodeRec.Insert;
    end;


    procedure InsertDefaultApprovalTemplate(var ApprovalTemplate: Record "Approval Templates"; ApprovalCode: Record "Approval Code")
    begin
        case true of
            ApprovalCode.Code = Text100:
                begin
                    ApprovalTemplate.Init;
                    ApprovalTemplate."Approval Code" := ApprovalCode.Code;
                    ApprovalTemplate."Approval Type" := ApprovalTemplate."approval type"::"Sales Pers./Purchaser";
                    ApprovalTemplate."Document Type" := ApprovalTemplate."document type"::Quote;
                    ApprovalTemplate."Limit Type" := ApprovalTemplate."limit type"::"No Limits";
                    ApprovalTemplate."Table ID" := ApprovalCode."Linked To Table No.";
                    ApprovalTemplate.Insert;
                end;
            ApprovalCode.Code = Text102:
                begin
                    ApprovalTemplate.Init;
                    ApprovalTemplate."Approval Code" := ApprovalCode.Code;
                    ApprovalTemplate."Approval Type" := ApprovalTemplate."approval type"::"Sales Pers./Purchaser";
                    ApprovalTemplate."Document Type" := ApprovalTemplate."document type"::Order;
                    ApprovalTemplate."Limit Type" := ApprovalTemplate."limit type"::"Approval Limits";
                    ApprovalTemplate."Table ID" := ApprovalCode."Linked To Table No.";
                    ApprovalTemplate.Insert;
                end;
            ApprovalCode.Code = Text104:
                begin
                    ApprovalTemplate.Init;
                    ApprovalTemplate."Approval Code" := ApprovalCode.Code;
                    ApprovalTemplate."Approval Type" := ApprovalTemplate."approval type"::"Sales Pers./Purchaser";
                    ApprovalTemplate."Document Type" := ApprovalTemplate."document type"::Invoice;
                    ApprovalTemplate."Limit Type" := ApprovalTemplate."limit type"::"No Limits";
                    ApprovalTemplate."Table ID" := ApprovalCode."Linked To Table No.";
                    ApprovalTemplate.Insert;
                end;
            ApprovalCode.Code = Text106:
                begin
                    ApprovalTemplate.Init;
                    ApprovalTemplate."Approval Code" := ApprovalCode.Code;
                    ApprovalTemplate."Approval Type" := ApprovalTemplate."approval type"::"Sales Pers./Purchaser";
                    ApprovalTemplate."Document Type" := ApprovalTemplate."document type"::"Credit Memo";
                    ApprovalTemplate."Limit Type" := ApprovalTemplate."limit type"::"No Limits";
                    ApprovalTemplate."Table ID" := ApprovalCode."Linked To Table No.";
                    ApprovalTemplate.Insert;
                end;
            ApprovalCode.Code = Text108:
                begin
                    ApprovalTemplate.Init;
                    ApprovalTemplate."Approval Code" := ApprovalCode.Code;
                    ApprovalTemplate."Approval Type" := ApprovalTemplate."approval type"::"Sales Pers./Purchaser";
                    ApprovalTemplate."Document Type" := ApprovalTemplate."document type"::"Return Order";
                    ApprovalTemplate."Limit Type" := ApprovalTemplate."limit type"::"No Limits";
                    ApprovalTemplate."Table ID" := ApprovalCode."Linked To Table No.";
                    ApprovalTemplate.Insert;
                end;
            ApprovalCode.Code = Text112:
                begin
                    ApprovalTemplate.Init;
                    ApprovalTemplate."Approval Code" := ApprovalCode.Code;
                    ApprovalTemplate."Approval Type" := ApprovalTemplate."approval type"::Approver;
                    ApprovalTemplate."Document Type" := ApprovalTemplate."document type"::Quote;
                    ApprovalTemplate."Limit Type" := ApprovalTemplate."limit type"::"Request Limits";
                    ApprovalTemplate."Table ID" := ApprovalCode."Linked To Table No.";
                    ApprovalTemplate.Insert;
                end;
            ApprovalCode.Code = Text114:
                begin
                    ApprovalTemplate.Init;
                    ApprovalTemplate."Approval Code" := ApprovalCode.Code;
                    ApprovalTemplate."Approval Type" := ApprovalTemplate."approval type"::"Sales Pers./Purchaser";
                    ApprovalTemplate."Document Type" := ApprovalTemplate."document type"::Order;
                    ApprovalTemplate."Limit Type" := ApprovalTemplate."limit type"::"Approval Limits";
                    ApprovalTemplate."Table ID" := ApprovalCode."Linked To Table No.";
                    ApprovalTemplate.Insert;
                end;
            ApprovalCode.Code = Text116:
                begin
                    ApprovalTemplate.Init;
                    ApprovalTemplate."Approval Code" := ApprovalCode.Code;
                    ApprovalTemplate."Approval Type" := ApprovalTemplate."approval type"::"Sales Pers./Purchaser";
                    ApprovalTemplate."Document Type" := ApprovalTemplate."document type"::Invoice;
                    ApprovalTemplate."Limit Type" := ApprovalTemplate."limit type"::"No Limits";
                    ApprovalTemplate."Table ID" := ApprovalCode."Linked To Table No.";
                    ApprovalTemplate.Insert;
                end;
            ApprovalCode.Code = Text118:
                begin
                    ApprovalTemplate.Init;
                    ApprovalTemplate."Approval Code" := ApprovalCode.Code;
                    ApprovalTemplate."Approval Type" := ApprovalTemplate."approval type"::"Sales Pers./Purchaser";
                    ApprovalTemplate."Document Type" := ApprovalTemplate."document type"::"Credit Memo";
                    ApprovalTemplate."Limit Type" := ApprovalTemplate."limit type"::"No Limits";
                    ApprovalTemplate."Table ID" := ApprovalCode."Linked To Table No.";
                    ApprovalTemplate.Insert;
                end;
            ApprovalCode.Code = Text120:
                begin
                    ApprovalTemplate.Init;
                    ApprovalTemplate."Approval Code" := ApprovalCode.Code;
                    ApprovalTemplate."Approval Type" := ApprovalTemplate."approval type"::"Sales Pers./Purchaser";
                    ApprovalTemplate."Document Type" := ApprovalTemplate."document type"::"Return Order";
                    ApprovalTemplate."Limit Type" := ApprovalTemplate."limit type"::"No Limits";
                    ApprovalTemplate."Table ID" := ApprovalCode."Linked To Table No.";
                    ApprovalTemplate.Insert;
                end;

        end;
    end;


    procedure TestSalesPrepayment(SalesHeader: Record "Sales Header"): Boolean
    var
        SalesLines: Record "Sales Line";
    begin
        SalesLines.SetRange("Document Type", SalesHeader."Document Type");
        SalesLines.SetRange("Document No.", SalesHeader."No.");
        SalesLines.SetFilter("Prepmt. Line Amount", '<>%1', 0);
        if SalesLines.Find('-') then
            repeat
                if SalesLines."Prepmt. Amt. Inv." <> SalesLines."Prepmt. Line Amount" then
                    exit(true);
            until SalesLines.Next = 0;
    end;


    procedure TestPurchasePrepayment(PurchaseHeader: Record "Purchase Header"): Boolean
    var
        PurchaseLines: Record "Purchase Line";
    begin
        PurchaseLines.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLines.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLines.SetFilter("Prepmt. Line Amount", '<>%1', 0);
        if PurchaseLines.Find('-') then
            repeat
                if PurchaseLines."Prepmt. Amt. Inv." <> PurchaseLines."Prepmt. Line Amount" then
                    exit(true);
            until PurchaseLines.Next = 0;
    end;


    procedure TestSetup()
    var
        ApprovalSetup: Record "Approval Setup";
    begin
        if not ApprovalSetup.Get then
            Error(Text004);
    end;


    /*
    procedure TestSalesPayment(SalesHeader: Record "Sales Header"): Boolean
    var
        SalesSetup: Record "Sales & Receivables Setup";
        CustLedgerEntry: Record "Credit Ledger Entry";
        SalesInvHeader: Record "Sales Invoice Header";
        EntryFound: Boolean;
    begin
        EntryFound := false;
        SalesSetup.Get;
        if SalesSetup."Check Prepmt. when Posting" then begin
            SalesInvHeader.SetCurrentkey("Prepayment Order No.", "Prepayment Invoice");
            SalesInvHeader.SetRange("Prepayment Order No.", SalesHeader."No.");
            SalesInvHeader.SetRange("Prepayment Invoice", true);
            if SalesInvHeader.Find('-') then
                repeat
                    CustLedgerEntry.SetCurrentkey("Document No.");
                    CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."document type"::Invoice);
                    CustLedgerEntry.SetRange("Document No.", SalesInvHeader."No.");
                    CustLedgerEntry.SetFilter("Remaining Amt. (LCY)", '<>%1', 0);
                    if CustLedgerEntry.FindFirst then
                        EntryFound := true;
                until (SalesInvHeader.Next = 0) or EntryFound;
        end;
        if EntryFound then
            exit(true);

        exit(false);
    end;
    */

    procedure TestPurchasePayment(PurchaseHeader: Record "Purchase Header"): Boolean
    var
        PurchaseSetup: Record "Purchases & Payables Setup";
        VendLedgerEntry: Record "Savings Ledger Entry";
        PurchaseInvHeader: Record "Purch. Inv. Header";
        EntryFound: Boolean;
    begin
        EntryFound := false;
        PurchaseSetup.Get;
        if PurchaseSetup."Check Prepmt. when Posting" then begin
            PurchaseInvHeader.SetCurrentkey("Prepayment Order No.", "Prepayment Invoice");
            PurchaseInvHeader.SetRange("Prepayment Order No.", PurchaseHeader."No.");
            PurchaseInvHeader.SetRange("Prepayment Invoice", true);
            if PurchaseInvHeader.Find('-') then
                repeat
                /*
            VendLedgerEntry.SetCurrentkey("Document No.");
            VendLedgerEntry.SetRange("Document Type", VendLedgerEntry."document type"::Invoice);
            VendLedgerEntry.SetRange("Document No.", PurchaseInvHeader."No.");
            VendLedgerEntry.SetFilter("Remaining Amt. (LCY)", '<>%1', 0);
            if VendLedgerEntry.FindFirst then
                EntryFound := true;
                */
                until (PurchaseInvHeader.Next = 0) or EntryFound;
        end;
        if EntryFound then
            exit(true);

        exit(false);
    end;




    local procedure GetQuoteErrorText(ApprovalTemplates: Record "Approval Templates"; PurchaseHeader: Record "Purchase Header") ErrorText: Text
    begin
        ErrorText :=
          StrSubstNo(
            Text026,
            Format(ApprovalTemplates."Limit Type"),
            Format(PurchaseHeader."document type"::Quote));
    end;

    local procedure IsCreditLimits(ApprovalTemplates: Record "Approval Templates"): Boolean
    begin
        exit(ApprovalTemplates."Limit Type" = ApprovalTemplates."limit type"::"Credit Limits")
    end;


    procedure SendCustomTrackerApprovalRequest(var Tracker: Record "Approval Tracker"): Boolean
    var
        Cust: Record Members;
        TemplateRec: Record "Approval Templates";
        ApprovalSetup: Record "Approval Setup";
        MessageType: Option " ",AutomaticPrePayment,AutomaticRelease,RequiresApproval;
        DocType: Enum "Custom Document Type";
        Continue: Boolean;

    begin
        TestSetup;


        if tracker.Status <> tracker.Status::Open then    //Status should be Pending When Starting
            Error('Status Should Be Open');

        if not ApprovalSetup.Get then
            Error(Text004);


        DocType := tracker."Custom Document Type";

        //Message('SendCustom: \DocType %1\ Resp: %2', DocType, Tracker."Responsibility Center");
        //Message('DocType: %1', DocType);

        if FindApprovalTemplatesForTracker(TemplateRec, Tracker, DocType, true) then begin
            repeat
                if not FindApproverTracker(Tracker, ApprovalSetup, TemplateRec) then
                    Error(Text010);
            until TemplateRec.Next = 0;


            //Finish Approval Entries**
            FinishApprovalEntryTracker(Tracker, ApprovalSetup, MessageType);
            case MessageType of
                Messagetype::AutomaticPrePayment:
                    Message(Text128, DocType, Tracker."Document No.");
                Messagetype::AutomaticRelease:
                    Message(Text003, DocType, Tracker."Document No.");
                Messagetype::RequiresApproval:
                    Message(Text001, DocType, Tracker."Document No.");
            end;
        end else
            Error(StrSubstNo(Text129, DocType));

    end;


    procedure SendTrackerApprovalRequest(var Tracker: Record "Approval Tracker"): Boolean
    var
        Cust: Record Members;
        TemplateRec: Record "Approval Templates";
        ApprovalSetup: Record "Approval Setup";
        MessageType: Option " ",AutomaticPrePayment,AutomaticRelease,RequiresApproval;
        DocType: Enum "Custom Document Type";
        Continue: Boolean;

    begin
        TestSetup;

        if Tracker.Status <> Tracker.Status::Open then    //Status should be Pending When Starting
            Error('Status Should Be Open');

        if not ApprovalSetup.Get then
            Error(Text004);


        DocType := Tracker."Custom Document Type";

        if FindApprovalTemplatesForTracker(TemplateRec, Tracker, DocType, false) then begin
            repeat
                if not FindApproverTracker(Tracker, ApprovalSetup, TemplateRec) then
                    Error(Text010);
            until TemplateRec.Next = 0;


            //Finish Approval Entries**
            FinishApprovalEntryTracker(Tracker, ApprovalSetup, MessageType);
            case MessageType of
                Messagetype::AutomaticPrePayment:
                    Message(Text128, DocType, Tracker."Document No.");
                Messagetype::AutomaticRelease:
                    Message(Text003, DocType, Tracker."Document No.");
                Messagetype::RequiresApproval:
                    Message(Text001, DocType, Tracker."Document No.");
            end;
        end else
            Error(StrSubstNo(Text129, DocType));


    end;

    local procedure FindApprovalTemplatesForTracker(var TemplateRec: Record "Approval Templates"; Tracker: Record "Approval Tracker"; DocType: Enum "Custom Document Type"; FilterResponsibilityCenter: Boolean): Boolean
    var
        TemplateUserID: Code[50];
    begin
        TemplateUserID := Tracker."Sender ID";
        
        SetApprovalTemplateFilters(TemplateRec, Tracker, DocType, TemplateUserID, FilterResponsibilityCenter);
        if TemplateRec.Find('-') then
            exit(true);

        SetApprovalTemplateFilters(TemplateRec, Tracker, DocType, '', FilterResponsibilityCenter);
        exit(TemplateRec.Find('-'));
    end;

    local procedure SetApprovalTemplateFilters(var TemplateRec: Record "Approval Templates"; Tracker: Record "Approval Tracker"; DocType: Enum "Custom Document Type"; TemplateUserID: Code[50]; FilterResponsibilityCenter: Boolean)
    begin
        TemplateRec.Reset();
        TemplateRec.SetCurrentKey("Table ID", "Custom Document Type", "Responsibility Center", "User ID", Enabled);
        TemplateRec.SetRange("Table ID", Database::"Approval Tracker");
        TemplateRec.SetRange("Custom Document Type", DocType);
        TemplateRec.SetRange("User ID", TemplateUserID);
        TemplateRec.SetRange(Enabled, true);
        //if FilterResponsibilityCenter and (Tracker."Responsibility Center" <> '') then
        TemplateRec.SetRange("Responsibility Center", Tracker."Responsibility Center");
    end;

    procedure FindApproverTracker(Tracker: Record "Approval Tracker"; ApprovalSetup: Record "Approval Setup"; AppTemplate: Record "Approval Templates"): Boolean
    var
        Cust: Record Members;
        UserSetup: Record "User Setup";
        ApproverId: Code[50];
        ApprovalAmount: Decimal;
        ApprovalAmountLCY: Decimal;
        AboveCreditLimitAmountLCY: Decimal;
        InsertEntries: Boolean;
        CalwideApprovals: Codeunit "Calwide Approvals";
        DocType: Enum "Custom Document Type";
        Text001: label 'Maximum Amount Cannot be ZERO for Approver %1';
        SenderID: Code[50];
    begin

        AddApproversTemp.Reset;
        AddApproversTemp.DeleteAll;


        //Get the Approval Amount
        //CalcSalesDocAmount(SalesHeader,ApprovalAmount,ApprovalAmountLCY);
        ApprovalAmount := Tracker."Document Amount";
        ApprovalAmountLCY := Tracker."Document Amount";

        //Confirm what this is
        AboveCreditLimitAmountLCY := 0;
        DocType := Tracker."Custom Document Type";


        case AppTemplate."Approval Type" of

            AppTemplate."approval type"::Approver:
                begin
                    SenderID := UserId;
                    if CalwideApprovals.GetDocumentSender(Tracker) <> '' then
                        SenderID := CalwideApprovals.GetDocumentSender(Tracker);

                    UserSetup.SetRange("User ID", SenderID);

                    if not UserSetup.Find('-') then
                        Error(Text005, SenderID);

                    case AppTemplate."Limit Type" of
                        AppTemplate."limit type"::"Approval Limits":
                            begin
                                ApproverId := UserSetup."Approver ID";
                                if ApproverId = '' then
                                    ApproverId := UserSetup."User ID";

                                MakeApprovalEntry(
                                  Tracker."Table ID", DocType, Tracker."Tracker ID", '',
                                  ApprovalSetup, ApproverId, AppTemplate."Approval Code", UserSetup, ApprovalAmount, ApprovalAmountLCY,
                                  Tracker."Currency Code", AppTemplate, 0);


                                CheckAddApprovers(AppTemplate);
                                AddApproversTemp.SetCurrentkey("Sequence No.");
                                AddApproversTemp.SetFilter("Approver ID", '<>%1', ApproverId);
                                if AddApproversTemp.Find('-') then
                                    repeat
                                        ApproverId := AddApproversTemp."Approver ID";
                                        MakeApprovalEntry(
                                          Tracker."Table ID", DocType, Tracker."Tracker ID", '',
                                          ApprovalSetup, ApproverId, AppTemplate."Approval Code", UserSetup, ApprovalAmount, ApprovalAmountLCY,
                                          Tracker."Currency Code", AppTemplate, 0);
                                    until AddApproversTemp.Next = 0;
                            end;
                        //Request Limits
                        //Request limit
                        AppTemplate."limit type"::"No Limits":
                            begin
                                ApproverId := UserSetup."Approver ID";
                                if ApproverId = '' then
                                    ApproverId := UserSetup."User ID";
                                MakeApprovalEntry(
                                  Tracker."Table ID", DocType, Tracker."Tracker ID", '',
                                  ApprovalSetup, ApproverId, AppTemplate."Approval Code", UserSetup, ApprovalAmount, ApprovalAmountLCY,
                                  Tracker."Currency Code", AppTemplate, 0);

                                CheckAddApprovers(AppTemplate);
                                AddApproversTemp.SetCurrentkey("Sequence No.");
                                AddApproversTemp.SetFilter("Approver ID", '<>%1', ApproverId);
                                if AddApproversTemp.Find('-') then
                                    repeat
                                        ApproverId := AddApproversTemp."Approver ID";
                                        MakeApprovalEntry(
                                          Tracker."Table ID", DocType, Tracker."Tracker ID", '',
                                          ApprovalSetup, ApproverId, AppTemplate."Approval Code", UserSetup, ApprovalAmount, ApprovalAmountLCY,
                                          Tracker."Currency Code", AppTemplate, 0);
                                    until AddApproversTemp.Next = 0;
                            end;

                        //Tiered Approval Request
                        AppTemplate."limit type"::"Tiered Limits":
                            begin
                                ApproverId := UserSetup."Approver ID";
                                if ApproverId = '' then
                                    ApproverId := UserSetup."User ID";
                                MakeApprovalEntry(
                                  Tracker."Table ID", DocType, Tracker."Tracker ID", '',
                                  ApprovalSetup, ApproverId, AppTemplate."Approval Code", UserSetup, ApprovalAmount, ApprovalAmountLCY,
                                  Tracker."Currency Code", AppTemplate, 0);

                                CheckAddApprovers(AppTemplate);
                                AddApproversTemp.SetCurrentkey("Sequence No.");
                                AddApproversTemp.SetFilter("Approver ID", '<>%1', ApproverId);
                                if AddApproversTemp.Find('-') then
                                    repeat
                                        //Ensure no Maximum Amount is Zero;
                                        if AddApproversTemp."Maximum Amount" = 0 then
                                            Error(Text001, AddApproversTemp."Approver ID");


                                        ApproverId := AddApproversTemp."Approver ID";
                                        if ApprovalAmountLCY >= AddApproversTemp."Minimum Amount" then
                                            MakeApprovalEntry(
                                              Tracker."Table ID", DocType, Tracker."Tracker ID", '',
                                              ApprovalSetup, ApproverId, AppTemplate."Approval Code", UserSetup, ApprovalAmount, ApprovalAmountLCY,
                                              Tracker."Currency Code", AppTemplate, 0);
                                    until AddApproversTemp.Next = 0;
                            end;
                    //End Tiered Approval Request

                    end;
                end;

            //Group Approval
            AppTemplate."approval type"::"Workflow User Group":
                begin
                    CheckAddApprovers(AppTemplate);
                    AddApproversTemp.SetCurrentkey("Sequence No.");
                    if AddApproversTemp.Find('-') then
                        repeat//ez
                            ApproverId := AddApproversTemp."Approver ID";
                            MakeApprovalEntry(
                              Tracker."Table ID", DocType, Tracker."Tracker ID", '',
                              ApprovalSetup, ApproverId, AppTemplate."Approval Code", UserSetup, ApprovalAmount, ApprovalAmountLCY,
                              Tracker."Currency Code", AppTemplate, 0);
                        until AddApproversTemp.Next = 0
                    else
                        Error(Text027);
                end;
        //End Group Approval

        end;

        //Message('FindApprover: \DocType %1\ Resp: %2', DocType, Tracker."Responsibility Center");
        exit(true);
    end;


    procedure FinishApprovalEntryTracker(Tracker: Record "Approval Tracker"; ApprovalSetup: Record "Approval Setup"; var MessageID: Option " ",AutomaticPrePayment,AutomaticRelease,RequiresApproval)
    var
        DocReleased: Boolean;
        ApprovalEntry: Record "Approval Entry";
        DocType: enum "Custom Document Type";
    begin
        DocReleased := false;

        ApprovalEntry.Init;
        //Get Document Type
        DocType := Tracker."Custom Document Type";

        ApprovalEntry.SetRange("Table ID", Tracker."Table ID");
        //SetRange("Custom Document Type", "Custom Document Type");
        ApprovalEntry.SetRange("Document No.", Tracker."Document No.");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Created);
        if ApprovalEntry.FindSet(true) then
            repeat
                if ApprovalEntry."Sender ID" = ApprovalEntry."Approver ID" then begin
                    ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                    ApprovalEntry.Modify;
                end else
                    if not IsOpenStatusSet then begin
                        ApprovalEntry.Status := ApprovalEntry.Status::Open;
                        ApprovalEntry.Modify;
                        IsOpenStatusSet := true;
                        //if ApprovalSetup.Approvals then
                        //  ApprovalsMgtNotification.SendImprestApprovalsMail(Tracker, ApprovalEntry);
                    end;
            until ApprovalEntry.Next = 0;

        if not IsOpenStatusSet then begin
            ApprovalEntry.SetRange(Status);
            ApprovalEntry.FindLast;
            DocReleased := ApproveApprovalRequest(ApprovalEntry);
        end;

        if DocReleased then begin
            Tracker.Validate(Status, Tracker.Status::Approved);
            Tracker.Modify(true);
            CalwideAprrovals.UpdateTrackerDocument(Tracker, Tracker.Status::Approved);
            MessageID := Messageid::AutomaticRelease;
        end else begin
            Tracker.validate(Status, Tracker.Status::"Pending");
            Tracker.Modify(true);

            CalwideAprrovals.UpdateTrackerDocument(Tracker, Tracker.Status::"Pending");
            MessageID := Messageid::RequiresApproval;
        end;
    end;


    procedure FinishCustomApprovalEntryTracker(Tracker: Record "Approval Tracker"; ApprovalSetup: Record "Approval Setup"; var MessageID: Option " ",AutomaticPrePayment,AutomaticRelease,RequiresApproval)
    var
        DocReleased: Boolean;
        ApprovalEntry: Record "Approval Entry";
        DocType: enum "Custom Document Type";
    begin
        DocReleased := false;
        ApprovalEntry.Init;
        //Get Document Type
        DocType := Tracker."Custom Document Type";

        ApprovalEntry.SetRange("Table ID", Tracker."Table ID");
        ApprovalEntry.SetRange("Custom Document Type", DocType);
        ApprovalEntry.SetRange("Document No.", Tracker."Document No.");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Created);
        if ApprovalEntry.FindSet(true) then
            repeat
                if ApprovalEntry."Sender ID" = ApprovalEntry."Approver ID" then begin
                    ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                    ApprovalEntry.Modify;
                end else
                    if not IsOpenStatusSet then begin
                        ApprovalEntry.Status := ApprovalEntry.Status::Open;
                        ApprovalEntry.Modify;
                        IsOpenStatusSet := true;
                        //if ApprovalSetup.Approvals then
                        //  ApprovalsMgtNotification.SendImprestApprovalsMail(Tracker, ApprovalEntry);
                    end;
            until ApprovalEntry.Next = 0;

        if not IsOpenStatusSet then begin
            ApprovalEntry.SetRange(Status);
            ApprovalEntry.FindLast;
            DocReleased := ApproveApprovalRequest(ApprovalEntry);
        end;

        if DocReleased then begin
            Tracker.Validate(Status, Tracker.Status::Approved);
            Tracker.Modify(true);
            CalwideAprrovals.UpdateTrackerDocument(Tracker, Tracker.Status::Approved);
            MessageID := Messageid::AutomaticRelease;
        end else begin
            Tracker.validate(Status, Tracker.Status::"Pending");
            Tracker.Modify(true);

            CalwideAprrovals.UpdateTrackerDocument(Tracker, Tracker.Status::"Pending");
            MessageID := Messageid::RequiresApproval;
        end;
    end;

    procedure CancelTrackerApprovalRequest(var Tracker: Record "Approval Tracker"; ShowMessage: Boolean; ManualCancel: Boolean): Boolean
    var
        ApprovalEntry: Record "Approval Entry";
        ApprovalSetup: Record "Approval Setup";
        SendMail: Boolean;
        MailCreated: Boolean;
        DocType: Enum "Custom Document Type";
    begin
        TestSetup;

        //Get Document Type
        DocType := Tracker."Custom Document Type";

        if not ApprovalSetup.Get then
            Error(Text004);


        //ApprovalEntry.SetCurrentkey("Table ID", "Custom Document Type", "Document No.", "Sequence No.");
        ApprovalEntry.SetRange("Table ID", Tracker."Table ID");
        //ApprovalEntry.SetRange("Custom Document Type", "Custom Document Type");
        ApprovalEntry.SetRange("Document No.", Tracker."Document No.");
        ApprovalEntry.SetFilter(Status, '<>%1&<>%2', ApprovalEntry.Status::Rejected, ApprovalEntry.Status::Canceled);
        SendMail := false;
        if ApprovalEntry.Find('-') then begin
            repeat
                if (ApprovalEntry.Status = ApprovalEntry.Status::Open) or
                   (ApprovalEntry.Status = ApprovalEntry.Status::Approved) then
                    SendMail := true;
                ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                ApprovalEntry."Last Date-Time Modified" := CreateDatetime(Today, Time);
                ApprovalEntry."Last Modified By User ID" := UserId;
                ApprovalEntry.Modify;
                if ApprovalSetup.Cancellations and ShowMessage and SendMail then begin
                    //AppManagement.SendImprestCancellationsMail(Tracker, ApprovalEntry);
                    MailCreated := true;
                    SendMail := false;
                end;
            until ApprovalEntry.Next = 0;
            if MailCreated then begin
                //AppManagement.SendMail;
                MailCreated := false;
            end;
        end;

        if ManualCancel or (not ManualCancel and not (Tracker.Status = Tracker.Status::Approved)) then
            Tracker.Status := Tracker.Status::Open;


        CalwideAprrovals.UpdateTrackerDocument(Tracker, Tracker.Status::Open);
        Tracker.Modify(true);

        if ShowMessage then
            Message(Text002, DocType, Tracker."Tracker ID");

    end;



    procedure CancelCustomTrackerApprovalRequest(var Tracker: Record "Approval Tracker"; ShowMessage: Boolean; ManualCancel: Boolean): Boolean
    var
        ApprovalEntry: Record "Approval Entry";
        ApprovalSetup: Record "Approval Setup";
        SendMail: Boolean;
        MailCreated: Boolean;
        DocType: Enum "Custom Document Type";
    begin
        TestSetup;

        //Get Document Type
        DocType := Tracker."Custom Document Type";

        if not ApprovalSetup.Get then
            Error(Text004);

        //ApprovalEntry.SetCurrentkey("Table ID", "Custom Document Type", "Document No.", "Sequence No.");
        ApprovalEntry.SetRange("Table ID", Tracker."Table ID");
        //ApprovalEntry.SetRange("Custom Document Type", DocType);
        ApprovalEntry.SetRange("Document No.", Tracker."Document No.");
        ApprovalEntry.SetFilter(Status, '<>%1&<>%2', ApprovalEntry.Status::Rejected, ApprovalEntry.Status::Canceled);
        SendMail := false;
        if ApprovalEntry.Find('-') then begin
            repeat
                if (ApprovalEntry.Status = ApprovalEntry.Status::Open) or
                   (ApprovalEntry.Status = ApprovalEntry.Status::Approved) then
                    SendMail := true;
                ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                ApprovalEntry."Last Date-Time Modified" := CreateDatetime(Today, Time);
                ApprovalEntry."Last Modified By User ID" := UserId;
                ApprovalEntry.Modify;
                if ApprovalSetup.Cancellations and ShowMessage and SendMail then begin
                    //AppManagement.SendImprestCancellationsMail(Tracker, ApprovalEntry);
                    MailCreated := true;
                    SendMail := false;
                end;
            until ApprovalEntry.Next = 0;
            if MailCreated then begin
                //AppManagement.SendMail;
                MailCreated := false;
            end;
        end;

        if ManualCancel or (not ManualCancel and not (Tracker.Status = Tracker.Status::Approved)) then
            Tracker.Status := Tracker.Status::Open;


        CalwideAprrovals.UpdateTrackerDocument(Tracker, Tracker.Status::Open);
        Tracker.Modify(true);

        if ShowMessage then
            Message(Text002, DocType, Tracker."Tracker ID");

    end;

    var
        TRacker: Record "Approval Tracker";
        Text001: label '%1 %2 requires further approval.\\Approval request entries have been created.';
        Text002: label '%1 %2 approval request cancelled.';
        Text003: label '%1 %2 has been automatically approved and released.';
        Text004: label 'Approval Setup not found.';
        Text005: label 'User ID %1 does not exist in the User Setup table.';
        Text006: label 'Approver ID %1 does not exist in the User Setup table.';
        Text007: label '%1 for %2  does not exist in the User Setup table.';
        Text008: label 'User ID %1 does not exist in the User Setup table for %2 %3.';
        Text013: label '%1 %2 must be approved and released before you can perform this action.', Comment = '%1=document type, %2=document no., e.g. Order 321 must be approved...';
        Text010: label 'Approver not found.';
        Text014: label 'The %1 approval entries have now been cancelled.';
        Text015: label 'The %1 %2 does not have any Lines.';
        Text022: label 'There has to be a %1 on %2 %3.';
        AddApproversTemp: Record "Additional Approvers" temporary;
        Text023: label 'A template with a blank Approval Type or with Limit Type "Credit Limit", must have additional approvers. ';
        Text024: label '%1 are only for purchase request orders.';
        Text025: label '%1 is not a valid limit type for %2 %3.';
        Text026: label '%1 is only a valid limit type for %2.';
        Text027: label 'When Approval Type is blank, additional approvers must be added to the template.';
        Text028: label 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
        Text100: label 'S-QUOTE';
        Text101: label 'Sales Quote Approval';
        Text102: label 'S-ORDER';
        Text103: label 'Sales Order Approval';
        Text104: label 'S-INVOICE';
        Text105: label 'Sales Invoice Approval';
        Text106: label 'S-CREDIT MEMO';
        Text107: label 'Sales Credit Memo Approval';
        Text108: label 'S-RETURN ORDER';
        Text109: label 'Sales Return Order Approval';
        Text110: label 'S-BLANKET ORDER';
        Text111: label 'Sales Blanket Order Approval';
        Text112: label 'P-QUOTE';
        Text113: label 'Purchase Quote Approval';
        Text114: label 'P-ORDER';
        Text115: label 'Purchase Order Approval';
        Text116: label 'P-INVOICE';
        Text117: label 'Purchase Invoice Approval';
        Text118: label 'P-CREDIT MEMO';
        Text119: label 'Purchase Credit Memo Approval';
        Text120: label 'P-RETURN ORDER';
        Text121: label 'Purchase Return Order Approval';
        Text122: label 'P-BLANKET ORDER';
        Text123: label 'Purchase Blanket Order Approval';
        Text124: label 'S-O-CREDITLIMIT';
        Text125: label 'Sales Order Credit Limit Approval';
        Text126: label 'S-I-CREDITLIMIT';
        Text127: label 'Sales Invoice Credit Limit Approval';
        Text128: label '%1 %2 has been automatically approved. Status changed to Pending Prepayment.';
        Text129: label 'No Approval Templates are enabled for document type %1.';
        IsOpenStatusSet: Boolean;
        Text130: label 'The approval request cannot be canceled because the order has already been released. To modify this order, you must reopen it.';
        UnpostedPrepaymentExistsMsg: label '%1 There are unposted prepayment amounts on the document of type %2 with the number %3.';
        CalwideAprrovals: Codeunit "Calwide Approvals";



}
