table 50507 "Procurement Setup"
{
    Caption = 'Procurement Setup';
    DataClassification = CustomerContent;
    LookupPageId = "Procurement Setup";
    DrillDownPageId = "Procurement Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(10; "Finance Approval Threshold"; Decimal)
        {
            Caption = 'Finance Approval Threshold';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            InitValue = 50000;
        }
        field(11; "Proc Committee Threshold"; Decimal)
        {
            Caption = 'Procurement Committee Threshold';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            InitValue = 1000000;
        }
        field(12; "Board Approval Threshold"; Decimal)
        {
            Caption = 'Board Approval Threshold';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            InitValue = 1000000;
        }
        field(20; "RFQ Email Template"; Text[250])
        {
            Caption = 'RFQ Email Template';
            DataClassification = CustomerContent;
        }
        field(21; "Award Letter Template"; Text[250])
        {
            Caption = 'Award Letter Template';
            DataClassification = CustomerContent;
        }
        field(22; "Regret Letter Template"; Text[250])
        {
            Caption = 'Regret Letter Template';
            DataClassification = CustomerContent;
        }
        field(30; "Store Requisition Nos."; Code[20])
        {
            Caption = 'Store Requisition Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(31; "External Requisition Nos."; Code[20])
        {
            Caption = 'External Requisition Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(32; "RFQ Nos."; Code[20])
        {
            Caption = 'RFQ Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(33; "LPO Nos."; Code[20])
        {
            Caption = 'LPO Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(34; "GRN Nos."; Code[20])
        {
            Caption = 'GRN Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(35; "Store Transfer Nos."; Code[20])
        {
            Caption = 'Store Transfer Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(36; "Stock Take Nos."; Code[20])
        {
            Caption = 'Stock Take Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(37; "VQ Nos."; Code[20])
        {
            Caption = 'Vendor Quotation Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(40; "Enable Approval Workflow"; Boolean)
        {
            Caption = 'Enable Approval Workflow';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(50; "Default Store Location"; Code[10])
        {
            Caption = 'Default Store Location';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Primary Key" = '' then
            "Primary Key" := 'PROC';
    end;
}
