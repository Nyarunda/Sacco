table 50502 "Goods Receipt Note Header"
{
    Caption = 'Goods Receipt Note Header';
    DataClassification = CustomerContent;
    LookupPageId = "Goods Receipt Note List";
    DrillDownPageId = "Goods Receipt Note List";

    fields
    {
        field(1; "GRN No."; Code[20])
        {
            Caption = 'GRN No.';
            DataClassification = CustomerContent;
        }
        field(2; "LPO No."; Code[20])
        {
            Caption = 'LPO No.';
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));

            trigger OnValidate()
            begin
                if Status <> Status::Open then
                    Error('You can only change LPO No. when the GRN is Open.');

                PopulateFromPurchaseOrder();
            end;
        }
        field(3; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
            Editable = false;
        }
        field(4; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';
            DataClassification = CustomerContent;
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Verified,Posted;
            OptionCaption = 'Open,Verified,Posted';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Received By"; Code[50])
        {
            Caption = 'Received By';
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }
        field(8; "Verified By"; Code[50])
        {
            Caption = 'Verified By';
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }
        field(9; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = CustomerContent;
        }
        field(10; "Delivery Note No."; Code[20])
        {
            Caption = 'Delivery Note No.';
            DataClassification = CustomerContent;
        }
        field(11; "Purchase Receipt No."; Code[20])
        {
            Caption = 'Purchase Receipt No.';
            DataClassification = CustomerContent;
            TableRelation = "Purch. Rcpt. Header";
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "GRN No.")
        {
            Clustered = true;
        }
        key(Key2; Status, "Receipt Date")
        {
        }
        key(Key3; "LPO No.")
        {
        }
    }

    trigger OnInsert()
    var
        ProcurementSetup: Record "Procurement Setup";
        NoSeriesMgt: Codeunit "No. Series";
        LPOLSOHeader: Record "Purchase Header";
    begin
        if "GRN No." = '' then begin
            ProcurementSetup.Get();
            ProcurementSetup.TestField("GRN Nos.");
            "GRN No." := NoSeriesMgt.GetNextNo(ProcurementSetup."GRN Nos.", WorkDate(), true);
        end;
        if "Receipt Date" = 0D then
            "Receipt Date" := WorkDate();
        if "LPO No." <> '' then begin
            LPOLSOHeader.Get("LPO No.");
            "Vendor No." := LPOLSOHeader."Buy-from Vendor No.";
            "Vendor Name" := LPOLSOHeader."Buy-from Vendor Name";
        end;
        "Received By" := UserId;
    end;

    trigger OnDelete()
    var
        GoodsReceiptNoteLine: Record "Goods Receipt Note Line";
    begin
        if Status <> Status::Open then
            Error('You cannot delete a GRN that is not in Open status.');
        GoodsReceiptNoteLine.SetRange("GRN No.", "GRN No.");
        GoodsReceiptNoteLine.DeleteAll(true);
    end;

    local procedure PopulateFromPurchaseOrder()
    var
        PurchaseHeader: Record "Purchase Header";
        GoodsReceiptMgt: Codeunit "Goods Receipt Management";
    begin
        if "LPO No." = '' then begin
            Clear("Vendor No.");
            Clear("Vendor Name");
            exit;
        end;

        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, "LPO No.");
        "Vendor No." := PurchaseHeader."Buy-from Vendor No.";
        "Vendor Name" := PurchaseHeader."Buy-from Vendor Name";

        if "GRN No." <> '' then
            GoodsReceiptMgt.SyncLinesFromPurchaseOrder(Rec);
    end;
}
