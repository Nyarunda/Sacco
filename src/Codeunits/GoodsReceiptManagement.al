codeunit 50506 "Goods Receipt Management"
{
    procedure SyncLinesFromPurchaseOrder(var GoodsReceiptNoteHeader: Record "Goods Receipt Note Header")
    var
        GoodsReceiptNoteLine: Record "Goods Receipt Note Line";
        PurchaseLine: Record "Purchase Line";
        QtyToReceive: Decimal;
    begin
        GoodsReceiptNoteHeader.TestField(Status, GoodsReceiptNoteHeader.Status::Open);

        GoodsReceiptNoteLine.SetRange("GRN No.", GoodsReceiptNoteHeader."GRN No.");
        GoodsReceiptNoteLine.DeleteAll(true);

        if GoodsReceiptNoteHeader."LPO No." = '' then
            exit;

        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", GoodsReceiptNoteHeader."LPO No.");
        //PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
        PurchaseLine.SetFilter(Quantity, '<>0');

        if PurchaseLine.FindSet() then
            repeat
                QtyToReceive := PurchaseLine."Outstanding Quantity";
                if QtyToReceive < 0 then
                    QtyToReceive := 0;

                GoodsReceiptNoteLine.Init();
                GoodsReceiptNoteLine."GRN No." := GoodsReceiptNoteHeader."GRN No.";
                GoodsReceiptNoteLine."Line No." := PurchaseLine."Line No.";
                GoodsReceiptNoteLine."Item No." := PurchaseLine."No.";
                GoodsReceiptNoteLine.Description := PurchaseLine.Description;
                GoodsReceiptNoteLine."Quantity Ordered" := PurchaseLine.Quantity;
                GoodsReceiptNoteLine."LPO No." := GoodsReceiptNoteHeader."LPO No.";
                GoodsReceiptNoteLine."LPO Line No." := PurchaseLine."Line No.";
                GoodsReceiptNoteLine.Validate("Unit Price", PurchaseLine."Direct Unit Cost");
                GoodsReceiptNoteLine.Validate("Quantity Received", QtyToReceive);
                GoodsReceiptNoteLine.Validate("Quality Inspection Passed", true);
                GoodsReceiptNoteLine.Insert(true);
            until PurchaseLine.Next() = 0;
    end;

    procedure VerifyGRN(var GoodsReceiptNoteHeader: Record "Goods Receipt Note Header")
    var
        GoodsReceiptNoteLine: Record "Goods Receipt Note Line";
    begin
        GoodsReceiptNoteHeader.TestField(Status, GoodsReceiptNoteHeader.Status::Open);
        GoodsReceiptNoteHeader.TestField("LPO No.");

        GoodsReceiptNoteLine.SetRange("GRN No.", GoodsReceiptNoteHeader."GRN No.");
        if not GoodsReceiptNoteLine.FindSet(true) then
            Error('GRN %1 has no lines. Select an LPO No. to load lines first.', GoodsReceiptNoteHeader."GRN No.");

        repeat
            if GoodsReceiptNoteLine."Quantity Received" < 0 then
                Error('Quantity Received cannot be negative on line %1.', GoodsReceiptNoteLine."Line No.");
            if GoodsReceiptNoteLine."Quantity Received" > GoodsReceiptNoteLine."Quantity Ordered" then
                Error(
                    'Quantity Received (%1) cannot exceed Quantity Ordered (%2) on line %3.',
                    GoodsReceiptNoteLine."Quantity Received",
                    GoodsReceiptNoteLine."Quantity Ordered",
                    GoodsReceiptNoteLine."Line No.");

            if GoodsReceiptNoteLine."Quality Inspection Passed" then
                GoodsReceiptNoteLine."Quantity Accepted" := GoodsReceiptNoteLine."Quantity Received"
            else
                GoodsReceiptNoteLine."Quantity Accepted" := 0;
            GoodsReceiptNoteLine."Total Value" := GoodsReceiptNoteLine."Quantity Accepted" * GoodsReceiptNoteLine."Unit Price";
            GoodsReceiptNoteLine.Modify(true);
        until GoodsReceiptNoteLine.Next() = 0;

        GoodsReceiptNoteHeader.Status := GoodsReceiptNoteHeader.Status::Verified;
        GoodsReceiptNoteHeader."Verified By" := UserId;
        GoodsReceiptNoteHeader.Modify(true);

        Message('GRN %1 has been verified.', GoodsReceiptNoteHeader."GRN No.");
    end;

    procedure PostGRN(var GoodsReceiptNoteHeader: Record "Goods Receipt Note Header")
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        GoodsReceiptNoteLine: Record "Goods Receipt Note Line";
        PurchPost: Codeunit "Purch.-Post";
        HasAcceptedQty: Boolean;
    begin
        GoodsReceiptNoteHeader.TestField(Status, GoodsReceiptNoteHeader.Status::Verified);
        GoodsReceiptNoteHeader.TestField("LPO No.");

        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, GoodsReceiptNoteHeader."LPO No.");
        PurchaseHeader.Validate(Receive, true);
        PurchaseHeader.Validate(Invoice, false);
        PurchaseHeader.Modify(true);

        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", GoodsReceiptNoteHeader."LPO No.");
        //PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
        if PurchaseLine.FindSet(true) then
            repeat
                if PurchaseLine."Qty. to Receive" <> 0 then begin
                    PurchaseLine.Validate("Qty. to Receive", 0);
                    PurchaseLine.Modify(true);
                end;
            until PurchaseLine.Next() = 0;

        GoodsReceiptNoteLine.SetRange("GRN No.", GoodsReceiptNoteHeader."GRN No.");
        if not GoodsReceiptNoteLine.FindSet() then
            Error('GRN %1 has no lines to post.', GoodsReceiptNoteHeader."GRN No.");

        repeat
            if GoodsReceiptNoteLine."Quantity Accepted" <= 0 then
                continue;

            if not PurchaseLine.Get(
                PurchaseLine."Document Type"::Order,
                GoodsReceiptNoteHeader."LPO No.",
                GoodsReceiptNoteLine."LPO Line No.")
            then
                Error(
                    'Purchase Order %1 line %2 not found.',
                    GoodsReceiptNoteHeader."LPO No.",
                    GoodsReceiptNoteLine."LPO Line No.");

            //PurchaseLine.TestField(Type, PurchaseLine.Type::Item);
            PurchaseLine.Validate("Qty. to Receive", GoodsReceiptNoteLine."Quantity Accepted");
            PurchaseLine.Modify(true);
            HasAcceptedQty := true;
        until GoodsReceiptNoteLine.Next() = 0;

        if not HasAcceptedQty then
            Error('No accepted quantities found on GRN %1. Verify quality and received quantities before posting.', GoodsReceiptNoteHeader."GRN No.");

        PurchPost.Run(PurchaseHeader);

        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, GoodsReceiptNoteHeader."LPO No.");
        GoodsReceiptNoteHeader."Purchase Receipt No." := PurchaseHeader."Last Receiving No.";
        GoodsReceiptNoteHeader.Status := GoodsReceiptNoteHeader.Status::Posted;
        GoodsReceiptNoteHeader.Modify(true);

        Message(
            'GRN %1 posted successfully. Purchase Receipt No.: %2.',
            GoodsReceiptNoteHeader."GRN No.",
            GoodsReceiptNoteHeader."Purchase Receipt No.");
    end;
}
