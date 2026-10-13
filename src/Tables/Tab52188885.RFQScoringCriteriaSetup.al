table 50587 "RFQ Scoring Criteria Setup"
{
    Caption = 'RFQ Scoring Criteria';
    DataClassification = CustomerContent;
    LookupPageId = "RFQ Scoring Criteria Setup";
    DrillDownPageId = "RFQ Scoring Criteria Setup";

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = GoodsRFQ,ServicesRFP;
            OptionCaption = 'Goods (RFQ),Services (RFP)';
            DataClassification = CustomerContent;
        }
        field(2; "Criteria Type"; Option)
        {
            Caption = 'Criteria Type';
            OptionMembers = StatutoryCompliance,PriceComparison,Quality,DeliveryTimeline,TechnicalCapability,VendorTrackRecord,MinimumTotal,MinimumStatutory,MinimumTechnical;
            OptionCaption = 'Statutory Compliance,Price Comparison,Quality,Delivery Timeline,Technical Capability,Vendor Track Record,Minimum Total,Minimum Statutory,Minimum Technical';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "Min Threshold/Days"; Decimal)
        {
            Caption = 'Min Threshold/Days';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(6; "Max Threshold/Days"; Decimal)
        {
            Caption = 'Max Threshold/Days';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(7; "Points Awarded"; Decimal)
        {
            Caption = 'Points Awarded';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Points Awarded" < 0 then
                    Error('Points Awarded cannot be negative.');
            end;
        }
        field(8; "Weight %"; Decimal)
        {
            Caption = 'Weight %';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if ("Weight %" < 0) or ("Weight %" > 100) then
                    Error('Weight % must be between 0 and 100.');
            end;
        }
        field(9; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
            InitValue = true;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Criteria Type", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Criteria Type", Active)
        {
        }
    }

    trigger OnInsert()
    begin
        if Description = '' then
            Description := Format("Criteria Type");
    end;
}
