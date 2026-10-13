table 50503 "LPO/LSO Header"
{
    Caption = 'LPO/LSO Header';
    DataClassification = CustomerContent;
    LookupPageId = "LPO/LSO List";
    DrillDownPageId = "LPO/LSO List";

    fields
    {
        field(1; "LPO No."; Code[20])
        {
            Caption = 'LPO No.';
            DataClassification = CustomerContent;
        }
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
        field(3; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "LPO Date"; Date)
        {
            Caption = 'LPO Date';
            DataClassification = CustomerContent;
        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"Pending Approval",Approved,Posted,Cancelled,Closed;
            OptionCaption = 'Open,Pending Approval,Approved,Posted,Cancelled,Closed';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Editable = false;
        }
        field(7; "Vendor Quotation No."; Code[20])
        {
            Caption = 'Vendor Quotation No.';
            DataClassification = CustomerContent;
            TableRelation = "Vendor Quotation Header";
        }
        field(8; "RFQ No."; Code[20])
        {
            Caption = 'RFQ No.';
            DataClassification = CustomerContent;
            TableRelation = "RFQ Header";
        }
        field(9; "External Requisition No."; Code[20])
        {
            Caption = 'External Requisition No.';
            DataClassification = CustomerContent;
            TableRelation = "External Requisition Header";
        }
        field(10; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
            Editable = false;
        }
        field(11; "Approval Status"; Option)
        {
            Caption = 'Approval Status';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = LPO,LSO;
            OptionCaption = 'LPO (Local Purchase Order),LSO (Local Service Order)';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "LPO No.")
        {
            Clustered = true;
        }
        key(Key2; Status, "LPO Date")
        {
        }
        key(Key3; "Vendor No.", "LPO Date")
        {
        }
    }

    trigger OnInsert()
    var
        ProcurementSetup: Record "Procurement Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if "LPO No." = '' then begin
            ProcurementSetup.Get();
            ProcurementSetup.TestField("LPO Nos.");
            "LPO No." := NoSeriesMgt.GetNextNo(ProcurementSetup."LPO Nos.", WorkDate(), true);
        end;
        if "LPO Date" = 0D then
            "LPO Date" := WorkDate();
        if "Vendor No." <> '' then begin
            Vendor.Get("Vendor No.");
            "Vendor Name" := Vendor.Name;
        end;
    end;

    trigger OnModify()
    begin
        if "Vendor No." <> '' then begin
            Vendor.Get("Vendor No.");
            "Vendor Name" := Vendor.Name;
        end;
    end;

    trigger OnDelete()
    var
        LPOLSOLine: Record "LPO/LSO Line";
    begin
        if Status <> Status::Open then
            Error('You cannot delete an LPO that is not in Open status.');
        LPOLSOLine.SetRange("LPO No.", "LPO No.");
        LPOLSOLine.DeleteAll(true);
    end;

    var
        Vendor: Record Vendor;
}
