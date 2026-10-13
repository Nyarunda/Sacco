table 50511 "Vendor Quotation Header"
{
    Caption = 'Vendor Quotation Header';
    DataClassification = CustomerContent;
    LookupPageId = "Vendor Quotation List";
    DrillDownPageId = "Vendor Quotation List";

    fields
    {
        field(1; "Quotation No."; Code[20])
        {
            Caption = 'Quotation No.';
            DataClassification = CustomerContent;
            Editable = false;
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
        field(4; "RFQ No."; Code[20])
        {
            Caption = 'RFQ No.';
            DataClassification = CustomerContent;
            TableRelation = "RFQ Header"."No.";
        }
        field(5; "Submission Date"; Date)
        {
            Caption = 'Submission Date';
            DataClassification = CustomerContent;
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Submitted,"Under Evaluation",Awarded,Rejected;
            OptionCaption = 'Submitted,Under Evaluation,Awarded,Rejected';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Evaluation Score"; Decimal)
        {
            Caption = 'Evaluation Score';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(8; Ranking; Integer)
        {
            Caption = 'Ranking';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Editable = false;
        }
        field(10; "Delivery Timeframe"; Date)
        {
            Caption = 'Delivery Timeframe';
            DataClassification = CustomerContent;
        }
        field(11; "Award Letter Sent"; Boolean)
        {
            Caption = 'Award Letter Sent';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Regret Letter Sent"; Boolean)
        {
            Caption = 'Regret Letter Sent';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(13; "Statutory Score"; Decimal)
        {
            Caption = 'Statutory Score';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if ("Statutory Score" < 0) or ("Statutory Score" > 10) then
                    Error('Statutory Score must be between 0 and 10.');
            end;
        }
        field(14; "Quality Score"; Decimal)
        {
            Caption = 'Quality Score';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if ("Quality Score" < 0) or ("Quality Score" > 35) then
                    Error('Quality Score must be between 0 and 35.');
            end;
        }
        field(15; "Delivery Score"; Decimal)
        {
            Caption = 'Delivery Score';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(16; "Pricing Score"; Decimal)
        {
            Caption = 'Pricing Score';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(17; "Technical Capability Score"; Decimal)
        {
            Caption = 'Technical Capability Score';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if ("Technical Capability Score" < 0) or ("Technical Capability Score" > 50) then
                    Error('Technical Capability Score must be between 0 and 50.');
            end;
        }
        field(18; "Track Record Score"; Decimal)
        {
            Caption = 'Track Record Score';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if ("Track Record Score" < 0) or ("Track Record Score" > 10) then
                    Error('Track Record Score must be between 0 and 10.');
            end;
        }
        field(19; "RFP Price Score"; Decimal)
        {
            Caption = 'RFP Price Score';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(20; Disqualified; Boolean)
        {
            Caption = 'Disqualified';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; "Disqualification Reason"; Text[250])
        {
            Caption = 'Disqualification Reason';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(22; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Quotation No.")
        {
            Clustered = true;
        }
        key(Key2; "RFQ No.", Ranking)
        {
        }
        key(Key3; "Vendor No.", "RFQ No.")
        {
        }
    }

    trigger OnInsert()
    var
    NSetup: Record "Procurement Setup";
    NoSeries: Codeunit "No. Series";
    begin
        if "Quotation No." = '' then begin
            NSetup.Get;
            NSetup.TestField("VQ Nos.");
            "Quotation No." := NoSeries.GetNextNo(NSetup."VQ Nos.", WorkDate(), true);
        end;

        if "Submission Date" = 0D then
            "Submission Date" := WorkDate();
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
        VendorQuotationLine: Record "Vendor Quotation Line";
    begin
        VendorQuotationLine.SetRange("Quotation No.", "Quotation No.");
        VendorQuotationLine.DeleteAll(true);
    end;

    var
        Vendor: Record Vendor;
}
