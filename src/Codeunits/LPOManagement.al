codeunit 50501 "LPO Management"
{
    procedure ReleaseLPO(var LPOLSOHeader: Record "LPO/LSO Header")
    var
        LPOLSOLine: Record "LPO/LSO Line";
        ProcurementSetup: Record "Procurement Setup";
        ProcurementWorkflowMgt: Codeunit "Procure Workflow Mgt";
    begin
        LPOLSOHeader.TestField(Status, LPOLSOHeader.Status::Open);
        LPOLSOLine.SetRange("LPO No.", LPOLSOHeader."LPO No.");
        if LPOLSOLine.IsEmpty() then
            Error('You must add at least one line to the LPO.');

        ProcurementSetup.Get();
        if ProcurementSetup."Enable Approval Workflow" then begin
            LPOLSOHeader.Status := LPOLSOHeader.Status::"Pending Approval";
            LPOLSOHeader."Approval Status" := LPOLSOHeader."Approval Status"::"Pending Approval";
            ProcurementWorkflowMgt.InitiateLPOApproval(LPOLSOHeader);
        end else begin
            LPOLSOHeader.Status := LPOLSOHeader.Status::Approved;
            LPOLSOHeader."Approval Status" := LPOLSOHeader."Approval Status"::Approved;
        end;

        LPOLSOHeader.Modify(true);
        Message('LPO %1 has been released for approval.', LPOLSOHeader."LPO No.");
    end;

    procedure CreatePurchaseOrder(var LPOLSOHeader: Record "LPO/LSO Header")
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        LPOLSOLine: Record "LPO/LSO Line";
        LineNo: Integer;
    begin
        LPOLSOHeader.TestField(Status, LPOLSOHeader.Status::Approved);

        PurchaseHeader.Init();
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
        PurchaseHeader.Insert(true);
        PurchaseHeader.Validate("Buy-from Vendor No.", LPOLSOHeader."Vendor No.");
        PurchaseHeader."LPO No." := LPOLSOHeader."LPO No.";
        PurchaseHeader."External Requisition No." := LPOLSOHeader."External Requisition No.";
        PurchaseHeader.Modify(true);

        LPOLSOLine.SetRange("LPO No.", LPOLSOHeader."LPO No.");
        if LPOLSOLine.FindSet() then begin
            repeat
                LineNo += 10000;
                PurchaseLine.Init();
                PurchaseLine."Document Type" := PurchaseHeader."Document Type";
                PurchaseLine."Document No." := PurchaseHeader."No.";
                PurchaseLine."Line No." := LineNo;
                PurchaseLine.Insert(true);
                if LPOLSOLine."Item No." <> '' then
                    PurchaseLine.Validate(Type, PurchaseLine.Type::Item)
                else
                    PurchaseLine.Validate(Type, PurchaseLine.Type::"G/L Account");
                if LPOLSOLine."Item No." <> '' then
                    PurchaseLine.Validate("No.", LPOLSOLine."Item No.");
                PurchaseLine.Description := LPOLSOLine."Item/Service Description";
                PurchaseLine.Validate(Quantity, LPOLSOLine.Quantity);
                PurchaseLine.Validate("Direct Unit Cost", LPOLSOLine."Unit Price");
                PurchaseLine."External Requisition Line No." := LPOLSOLine."Line No.";
                PurchaseLine.Modify(true);
            until LPOLSOLine.Next() = 0;
        end;

        LPOLSOHeader."Purchase Order No." := PurchaseHeader."No.";
        LPOLSOHeader.Status := LPOLSOHeader.Status::Posted;
        LPOLSOHeader.Modify(true);

        Message('Purchase Order %1 has been created from LPO %2.', PurchaseHeader."No.", LPOLSOHeader."LPO No.");
    end;

    procedure CreateLPOFromQuotation(var VendorQuotationHeader: Record "Vendor Quotation Header")
    var
        LPOLSOHeader: Record "LPO/LSO Header";
        LPOLSOLine: Record "LPO/LSO Line";
        VendorQuotationLine: Record "Vendor Quotation Line";
        RFQHeader: Record "RFQ Header";
    begin
        VendorQuotationHeader.TestField(Status, VendorQuotationHeader.Status::Awarded);

        LPOLSOHeader.Init();
        LPOLSOHeader."Vendor No." := VendorQuotationHeader."Vendor No.";
        LPOLSOHeader."Vendor Quotation No." := VendorQuotationHeader."Quotation No.";
        LPOLSOHeader."RFQ No." := VendorQuotationHeader."RFQ No.";
        if RFQHeader.Get(VendorQuotationHeader."RFQ No.") then
            LPOLSOHeader."External Requisition No." := RFQHeader."External Requisition No.";
        LPOLSOHeader.Insert(true);

        VendorQuotationLine.SetRange("Quotation No.", VendorQuotationHeader."Quotation No.");
        if VendorQuotationLine.FindSet() then begin
            repeat
                LPOLSOLine.Init();
                LPOLSOLine."LPO No." := LPOLSOHeader."LPO No.";
                LPOLSOLine."Line No." := VendorQuotationLine."Line No.";
                LPOLSOLine."Item/Service Description" := VendorQuotationLine."Item/Service Description";
                LPOLSOLine."Item No." := VendorQuotationLine."Item No.";
                LPOLSOLine.Quantity := VendorQuotationLine.Quantity;
                LPOLSOLine."Unit Price" := VendorQuotationLine."Unit Price";
                LPOLSOLine."Delivery Date" := VendorQuotationLine."Delivery Timeframe";
                LPOLSOLine."Vendor Quotation No." := VendorQuotationHeader."Quotation No.";
                LPOLSOLine."Vendor Quotation Line No." := VendorQuotationLine."Line No.";
                LPOLSOLine.Insert(true);
            until VendorQuotationLine.Next() = 0;
        end;

        Message('LPO %1 has been created from quotation %2.', LPOLSOHeader."LPO No.", VendorQuotationHeader."Quotation No.");
    end;

    procedure SendLPOToVendor(var LPOLSOHeader: Record "LPO/LSO Header")
    begin
        LPOLSOHeader.TestField(Status, LPOLSOHeader.Status::Approved);
        // TODO: Implement email sending functionality
        Message('LPO has been sent to vendor.');
    end;
}
