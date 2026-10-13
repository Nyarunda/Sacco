namespace UnitedWomen.UnitedWomen;

page 50836 "RFQ Scoring Criteria Setup"
{
    PageType = List;
    SourceTable = "RFQ Scoring Criteria Setup";
    Caption = 'RFQ Scoring Criteria Setup';
    UsageCategory = Administration;
    ApplicationArea = All;
    Editable = true;
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Criteria)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the scoring matrix document type.';
                }
                field("Criteria Type"; Rec."Criteria Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the criterion to score.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the criterion description.';
                }
                field("Min Threshold/Days"; Rec."Min Threshold/Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the lower threshold value for threshold-based criteria.';
                }
                field("Max Threshold/Days"; Rec."Max Threshold/Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the upper threshold value for threshold-based criteria.';
                }
                field("Points Awarded"; Rec."Points Awarded")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies points awarded for this threshold or minimum-rule value.';
                }
                field("Weight %"; Rec."Weight %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the weight cap used for the criterion.';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this line is active for scoring.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(InitializeDefaults)
            {
                ApplicationArea = All;
                Caption = 'Initialize Defaults';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Insert or refresh the default scoring criteria lines for RFQ and RFP.';

                trigger OnAction()
                begin
                    InitializeDefaultCriteria();
                end;
            }
        }
    }

    local procedure InitializeDefaultCriteria()
    var
        Criteria: Record "RFQ Scoring Criteria Setup";
    begin
        if Criteria.FindFirst() then
            if not Confirm('Scoring criteria already exist. Do you want to update the default lines?', false) then
                exit;

        // Goods (RFQ)
        InsertOrUpdateCriteria(Criteria."Document Type"::GoodsRFQ, Criteria."Criteria Type"::StatutoryCompliance, 10000, 'Statutory Compliance', 0, 0, 10, 10);
        InsertOrUpdateCriteria(Criteria."Document Type"::GoodsRFQ, Criteria."Criteria Type"::PriceComparison, 20000, 'Price Comparison', 0, 0, 0, 50);
        InsertOrUpdateCriteria(Criteria."Document Type"::GoodsRFQ, Criteria."Criteria Type"::Quality, 30000, 'Quality', 0, 0, 0, 35);
        InsertOrUpdateCriteria(Criteria."Document Type"::GoodsRFQ, Criteria."Criteria Type"::DeliveryTimeline, 40000, 'Delivery Timeline 0-7 Days', 0, 7, 5, 5);
        InsertOrUpdateCriteria(Criteria."Document Type"::GoodsRFQ, Criteria."Criteria Type"::DeliveryTimeline, 50000, 'Delivery Timeline 8-14 Days', 8, 14, 2.5, 5);
        InsertOrUpdateCriteria(Criteria."Document Type"::GoodsRFQ, Criteria."Criteria Type"::DeliveryTimeline, 60000, 'Delivery Timeline >14 Days', 15, 0, 0, 5);
        InsertOrUpdateCriteria(Criteria."Document Type"::GoodsRFQ, Criteria."Criteria Type"::MinimumTotal, 70000, 'Minimum Total Score', 0, 0, 60, 0);
        InsertOrUpdateCriteria(Criteria."Document Type"::GoodsRFQ, Criteria."Criteria Type"::MinimumStatutory, 80000, 'Minimum Statutory Score', 0, 0, 4, 0);

        // Services (RFP)
        InsertOrUpdateCriteria(Criteria."Document Type"::ServicesRFP, Criteria."Criteria Type"::TechnicalCapability, 10000, 'Technical Capability', 0, 0, 0, 50);
        InsertOrUpdateCriteria(Criteria."Document Type"::ServicesRFP, Criteria."Criteria Type"::VendorTrackRecord, 20000, 'Vendor Track Record', 0, 0, 0, 10);
        InsertOrUpdateCriteria(Criteria."Document Type"::ServicesRFP, Criteria."Criteria Type"::PriceComparison, 30000, 'Price Comparison', 0, 0, 0, 40);
        InsertOrUpdateCriteria(Criteria."Document Type"::ServicesRFP, Criteria."Criteria Type"::MinimumTotal, 40000, 'Minimum Total Score', 0, 0, 65, 0);
        InsertOrUpdateCriteria(Criteria."Document Type"::ServicesRFP, Criteria."Criteria Type"::MinimumTechnical, 50000, 'Minimum Technical Score', 0, 0, 25, 0);

        Message('Default scoring criteria have been initialized.');
    end;

    local procedure InsertOrUpdateCriteria(DocumentType: Option GoodsRFQ,ServicesRFP; CriteriaType: Option StatutoryCompliance,PriceComparison,Quality,DeliveryTimeline,TechnicalCapability,VendorTrackRecord,MinimumTotal,MinimumStatutory,MinimumTechnical; LineNo: Integer; DescriptionText: Text[100]; MinThreshold: Decimal; MaxThreshold: Decimal; PointsAwarded: Decimal; WeightPct: Decimal)
    var
        Criteria: Record "RFQ Scoring Criteria Setup";
    begin
        if Criteria.Get(DocumentType, CriteriaType, LineNo) then begin
            Criteria.Description := DescriptionText;
            Criteria."Min Threshold/Days" := MinThreshold;
            Criteria."Max Threshold/Days" := MaxThreshold;
            Criteria."Points Awarded" := PointsAwarded;
            Criteria."Weight %" := WeightPct;
            Criteria.Active := true;
            Criteria.Modify(true);
        end else begin
            Criteria.Init();
            Criteria."Document Type" := DocumentType;
            Criteria."Criteria Type" := CriteriaType;
            Criteria."Line No." := LineNo;
            Criteria.Description := DescriptionText;
            Criteria."Min Threshold/Days" := MinThreshold;
            Criteria."Max Threshold/Days" := MaxThreshold;
            Criteria."Points Awarded" := PointsAwarded;
            Criteria."Weight %" := WeightPct;
            Criteria.Active := true;
            Criteria.Insert(true);
        end;
    end;
}
