codeunit 50504 "RFQ & Quotation Management"
{
    procedure CreateRFQFromRequisition(var ExternalRequisitionHeader: Record "External Requisition Header")
    var
        RFQHeader: Record "RFQ Header";
        RFQLine: Record "RFQ Line";
        ExternalRequisitionLine: Record "External Requisition Line";
    begin
        ExternalRequisitionHeader.TestField(Status, ExternalRequisitionHeader.Status::Approved);

        RFQHeader.Init();
        RFQHeader."External Requisition No." := ExternalRequisitionHeader."Requisition No.";
        RFQHeader.Insert(true);

        ExternalRequisitionLine.SetRange("Requisition No.", ExternalRequisitionHeader."Requisition No.");
        if ExternalRequisitionLine.FindSet() then begin
            repeat
                RFQLine.Init();
                RFQLine."RFQ No." := RFQHeader."No.";
                RFQLine."Line No." := ExternalRequisitionLine."Line No.";
                RFQLine."Description" := ExternalRequisitionLine."Item/Service Description";
                RFQLine."Item No." := ExternalRequisitionLine."Item No.";
                RFQLine.Quantity := ExternalRequisitionLine.Quantity;
                RFQLine."External Requisition No." := ExternalRequisitionHeader."Requisition No.";
                RFQLine."External Requisition Line No." := ExternalRequisitionLine."Line No.";
                RFQLine.Insert(true);
            until ExternalRequisitionLine.Next() = 0;
        end;

        ExternalRequisitionHeader.Status := ExternalRequisitionHeader.Status::"RFQ Created";
        ExternalRequisitionHeader."RFQ No." := RFQHeader."No.";
        ExternalRequisitionHeader.Modify(true);

        Message('RFQ %1 has been created.', RFQHeader."No.");
    end;

    procedure SendRFQToVendors(var RFQHeader: Record "RFQ Header")
    var
        // VendorPrequalification: Record "Vendor Prequalification";
        Vendor: Record Vendor;
        ProcurementSetup: Record "Procurement Setup";
    // Email functionality would be implemented here
    begin
        RFQHeader.TestField(Status, RFQHeader.Status::Open);

        ProcurementSetup.Get();
        // TODO: Implement email sending with Excel template
        // For now, just update status
        RFQHeader.Status := RFQHeader.Status::"Quotations Received";
        RFQHeader.Modify(true);

        Message('RFQ has been sent to prequalified vendors.');
    end;

    procedure UploadQuotation(var VendorQuotationHeader: Record "Vendor Quotation Header")
    var
        VendorQuotationLine: Record "Vendor Quotation Line";
        FileName: Text;
        ImportStream: InStream;
        ImportedLineCount: Integer;
    begin
        VendorQuotationHeader.TestField("Quotation No.");
        VendorQuotationHeader.TestField("Vendor No.");
        VendorQuotationHeader.TestField("RFQ No.");
        if VendorQuotationHeader.Status in [VendorQuotationHeader.Status::Awarded, VendorQuotationHeader.Status::Rejected] then
            Error('You cannot import lines for quotation %1 because it is in %2 status.', VendorQuotationHeader."Quotation No.", VendorQuotationHeader.Status);

        Message('Ensure your excel file follows this format: Vendor No., Document No., Type, Description, Quantity, Unit Cost, Amount.');

        VendorQuotationLine.SetRange("Quotation No.", VendorQuotationHeader."Quotation No.");
        if not VendorQuotationLine.IsEmpty() then
            if not Confirm(
                'Quotation %1 already has lines. Do you want to replace them with data from Excel?',
                false,
                VendorQuotationHeader."Quotation No.")
            then
                exit;

        if not UploadIntoStream(
            'Select vendor quotation Excel file',
            '',
            'Excel Files (*.xlsx)|*.xlsx',
            FileName,
            ImportStream)
        then
            exit;

        ImportedLineCount := ImportQuotationLinesFromExcel(VendorQuotationHeader, ImportStream);

        VendorQuotationLine.Reset();
        VendorQuotationLine.SetRange("Quotation No.", VendorQuotationHeader."Quotation No.");
        VendorQuotationLine.CalcSums("Total Price");
        VendorQuotationHeader."Total Amount" := VendorQuotationLine."Total Price";
        if VendorQuotationHeader.Status <> VendorQuotationHeader.Status::Submitted then
            VendorQuotationHeader.Status := VendorQuotationHeader.Status::Submitted;
        if VendorQuotationHeader."Submission Date" = 0D then
            VendorQuotationHeader."Submission Date" := WorkDate();
        VendorQuotationHeader.Modify(true);

        Message('%1 line(s) imported successfully for quotation %2.', ImportedLineCount, VendorQuotationHeader."Quotation No.");
    end;

    procedure BulkUploadQuotations(var RFQHeader: Record "RFQ Header")
    var
        FileName: Text;
        ImportStream: InStream;
        ImportedLineCount: Integer;
        ImportedQuotationCount: Integer;
        TempBlob: Codeunit System.Utilities."Temp Blob";
        TempBlobOutStream: OutStream;
    begin
        RFQHeader.TestField("No.");

        Message('Ensure your Excel file follows this format: Vendor No., Document No., Type, Description, Quantity, Unit Cost, Amount.');

        if not Confirm(
            'This will import quotations for multiple vendors into RFQ %1. Existing lines for matching quotation numbers will be replaced. Continue?',
            false,
            RFQHeader."No.")
        then
            exit;

        if not UploadIntoStream(
            StrSubstNo('Select bulk quotation Excel file for RFQ %1', RFQHeader."No."),
            '',
            'Excel Files (*.xlsx)|*.xlsx',
            FileName,
            ImportStream)
        then
            exit;

        // Convert InStream to TempBlob before passing
        TempBlob.CreateOutStream(TempBlobOutStream);
        CopyStream(TempBlobOutStream, ImportStream);

        ImportedLineCount := ImportBulkQuotationLinesFromExcel(RFQHeader, TempBlob, ImportedQuotationCount);

        Message(
            '%1 line(s) imported across %2 quotation(s) for RFQ %3.',
            ImportedLineCount,
            ImportedQuotationCount,
            RFQHeader."No.");
    end;

    procedure EvaluateQuotations(var RFQHeader: Record "RFQ Header")
    var
        VendorQuotationHeader: Record "Vendor Quotation Header";
        LowestQuotedAmount: Decimal;
        RFQVendor: Record "RFQ Vendors";
    begin
        // RFQHeader.TestField(Status, RFQHeader.Status::"Quotations Received");
        ValidateEvaluationSetup(RFQHeader);

        LowestQuotedAmount := GetLowestQuotedAmount(RFQHeader."No.");
        if LowestQuotedAmount <= 0 then
            Error('At least one submitted quotation must have a Total Amount greater than zero.');

        VendorQuotationHeader.SetRange("RFQ No.", RFQHeader."No.");
        VendorQuotationHeader.SetFilter(Status, '%1|%2', VendorQuotationHeader.Status::Submitted, VendorQuotationHeader.Status::"Under Evaluation");
        if not VendorQuotationHeader.FindSet(true) then
            Error('No submitted quotations found for RFQ %1.', RFQHeader."No.");

        repeat
            EvaluateSingleQuotation(RFQHeader, VendorQuotationHeader, LowestQuotedAmount);
        until VendorQuotationHeader.Next() = 0;

        VendorQuotationHeader.Reset();
        VendorQuotationHeader.SetRange("RFQ No.", RFQHeader."No.");
        VendorQuotationHeader.SetRange(Status, VendorQuotationHeader.Status::Submitted);
        VendorQuotationHeader.ModifyAll(Status, VendorQuotationHeader.Status::"Under Evaluation", true);

        AssignRankings(RFQHeader);

        RFQHeader.Status := RFQHeader.Status::"Under Evaluation";
        RFQHeader.Modify(true);

        //update scores on RFQ Vendor table
        RFQVendor.SetRange("Requisition Document No.", RFQHeader."No.");
        if RFQVendor.FindSet() then begin  
            repeat
                VendorQuotationHeader.Reset(); 
                VendorQuotationHeader.SetRange("Vendor No.", RFQVendor."Account No.");
                VendorQuotationHeader.SetRange("RFQ No.", RFQHeader."No.");
                if VendorQuotationHeader.FindFirst() then begin
                    RFQVendor.Score := VendorQuotationHeader."Evaluation Score";
                    RFQVendor.Modify();
                end;
            until RFQVendor.Next() = 0;
        end;

        Message('Quotations have been evaluated and ranked using the %1 matrix.', RFQHeader."Evaluation Matrix Type");
    end;

    procedure AwardVendor(var RFQHeader: Record "RFQ Header")
    var
        VendorQuotationHeader: Record "Vendor Quotation Header";
        RFQVendor: Record "RFQ Vendors";
    begin
        RFQHeader.TestField(Status, RFQHeader.Status::"Under Evaluation");

        // Find the top-ranked qualified quotation
        VendorQuotationHeader.SetRange("RFQ No.", RFQHeader."No.");
        VendorQuotationHeader.SetRange(Status, VendorQuotationHeader.Status::"Under Evaluation");
        VendorQuotationHeader.SetRange(Disqualified, false);
        VendorQuotationHeader.SetRange(Ranking, 1);
        if VendorQuotationHeader.FindFirst() then begin
            VendorQuotationHeader.Status := VendorQuotationHeader.Status::Awarded;
            VendorQuotationHeader.Modify(true);

            RFQHeader."Awarded Vendor No." := VendorQuotationHeader."Vendor No.";
            RFQHeader.Status := RFQHeader.Status::Awarded;
            RFQHeader.Awarded := true;
            RFQHeader."Awarded On" := CurrentDateTime;
            RFQHeader."Awarded By" := UserId;

            RFQHeader.Modify(true);

            //update RFQ Vendor Quotation line to reflect awarded status
            RFQVendor.SetRange("Requisition Document No.", RFQHeader."No.");
            RFQVendor.SetRange("Account No.", VendorQuotationHeader."Vendor No.");
            if RFQVendor.FindFirst() then begin
                RFQVendor.Awarded := true;
                RFQVendor."Awarded By" := UserId;
                RFQVendor."Awarded On" := CurrentDateTime;
                RFQVendor."Award Notification Sent" := true;
                RFQVendor."Award Notification Sent By" := UserId;

                RFQVendor.Modify();

                Commit();
            end;

            // Send award letter
            SendAwardLetter(VendorQuotationHeader);

            // Send regret letters to others
            SendRegretLettersToOthers(RFQHeader, VendorQuotationHeader."Quotation No.");

            Message('Vendor %1 has been awarded the RFQ.', VendorQuotationHeader."Vendor Name");
        end else
            Error('No qualified quotation found to award.');
    end;

    procedure SendAwardLetter(var VendorQuotationHeader: Record "Vendor Quotation Header")
    var
        ProcurementSetup: Record "Procurement Setup";
    begin
        ProcurementSetup.Get();
        // TODO: Implement email sending with award letter template
        VendorQuotationHeader."Award Letter Sent" := true;
        VendorQuotationHeader.Modify(true);
        Message('Award letter has been sent to vendor.');
    end;

    procedure SendRegretLetter(var VendorQuotationHeader: Record "Vendor Quotation Header")
    var
        ProcurementSetup: Record "Procurement Setup";
    begin
        ProcurementSetup.Get();
        // TODO: Implement email sending with regret letter template
        VendorQuotationHeader."Regret Letter Sent" := true;
        VendorQuotationHeader.Modify(true);
        Message('Regret letter has been sent to vendor.');
    end;

    local procedure SendRegretLettersToOthers(var RFQHeader: Record "RFQ Header"; AwardedQuotationNo: Code[20])
    var
        VendorQuotationHeader: Record "Vendor Quotation Header";
    begin
        VendorQuotationHeader.SetRange("RFQ No.", RFQHeader."No.");
        VendorQuotationHeader.SetFilter("Quotation No.", '<>%1', AwardedQuotationNo);
        VendorQuotationHeader.SetRange(Status, VendorQuotationHeader.Status::"Under Evaluation");
        if VendorQuotationHeader.FindSet(true) then begin
            repeat
                VendorQuotationHeader.Status := VendorQuotationHeader.Status::Rejected;
                SendRegretLetter(VendorQuotationHeader);
            until VendorQuotationHeader.Next() = 0;
        end;
    end;

    local procedure ValidateEvaluationSetup(var RFQHeader: Record "RFQ Header")
    begin
        if RFQHeader."Scoring Document Type" = RFQHeader."Scoring Document Type"::GoodsRFQ then
            if RFQHeader."Evaluation Matrix Type" <> RFQHeader."Evaluation Matrix Type"::RFQ then
                Error('Scoring Document Type %1 requires Evaluation Matrix Type RFQ.', RFQHeader."Scoring Document Type");

        if RFQHeader."Scoring Document Type" = RFQHeader."Scoring Document Type"::ServicesRFP then
            if RFQHeader."Evaluation Matrix Type" <> RFQHeader."Evaluation Matrix Type"::RFP then
                Error('Scoring Document Type %1 requires Evaluation Matrix Type RFP.', RFQHeader."Scoring Document Type");

        if not HasActiveCriteriaForDocumentType(RFQHeader."Scoring Document Type") then
            Error('No active scoring criteria found for Document Type %1. Maintain setup in RFQ Scoring Criteria Setup.', RFQHeader."Scoring Document Type");

        if RFQHeader."Evaluation Matrix Type" = RFQHeader."Evaluation Matrix Type"::RFP then
            RFQHeader.TestField("Budget/Base Amount");
    end;

    local procedure GetLowestQuotedAmount(RFQNo: Code[20]): Decimal
    var
        VendorQuotationHeader: Record "Vendor Quotation Header";
        LowestQuotedAmount: Decimal;
    begin
        LowestQuotedAmount := 0;
        VendorQuotationHeader.SetRange("RFQ No.", RFQNo);
        VendorQuotationHeader.SetFilter(Status, '%1|%2', VendorQuotationHeader.Status::"Under Evaluation", VendorQuotationHeader.Status::Submitted);
        if VendorQuotationHeader.FindSet() then
            repeat
                if VendorQuotationHeader."Total Amount" > 0 then
                    if (LowestQuotedAmount = 0) or (VendorQuotationHeader."Total Amount" < LowestQuotedAmount) then
                        LowestQuotedAmount := VendorQuotationHeader."Total Amount";
            until VendorQuotationHeader.Next() = 0;

        exit(LowestQuotedAmount);
    end;

    local procedure EvaluateSingleQuotation(var RFQHeader: Record "RFQ Header"; var VendorQuotationHeader: Record "Vendor Quotation Header"; LowestQuotedAmount: Decimal)
    var
        ScoringCriteria: Record "RFQ Scoring Criteria Setup";
        DocumentTypeValue: Integer;
        DeliveryScore: Decimal;
        PricingScore: Decimal;
        RFPPriceScore: Decimal;
        EvaluationScore: Decimal;
        StatutoryWeight: Decimal;
        QualityWeight: Decimal;
        TechnicalWeight: Decimal;
        TrackRecordWeight: Decimal;
    begin
        DocumentTypeValue := RFQHeader."Scoring Document Type";
        VendorQuotationHeader.Ranking := 0;
        VendorQuotationHeader.Disqualified := false;
        VendorQuotationHeader."Disqualification Reason" := '';

        if RFQHeader."Evaluation Matrix Type" = RFQHeader."Evaluation Matrix Type"::RFQ then begin
            StatutoryWeight := GetConfiguredWeight(DocumentTypeValue, ScoringCriteria."Criteria Type"::StatutoryCompliance, 10);
            QualityWeight := GetConfiguredWeight(DocumentTypeValue, ScoringCriteria."Criteria Type"::Quality, 35);

            EnsureScoreWithinConfiguredMaximum('Statutory', VendorQuotationHeader."Statutory Score", StatutoryWeight);
            EnsureScoreWithinConfiguredMaximum('Quality', VendorQuotationHeader."Quality Score", QualityWeight);

            DeliveryScore := CalculateDeliveryScore(RFQHeader, VendorQuotationHeader."Delivery Timeframe");
            PricingScore := CalculateRFQPricingScore(RFQHeader, LowestQuotedAmount, VendorQuotationHeader."Total Amount");
            EvaluationScore := VendorQuotationHeader."Statutory Score" + VendorQuotationHeader."Quality Score" + DeliveryScore + PricingScore;

            VendorQuotationHeader."Delivery Score" := DeliveryScore;
            VendorQuotationHeader."Pricing Score" := PricingScore;
            VendorQuotationHeader."RFP Price Score" := 0;
            VendorQuotationHeader."Evaluation Score" := Round(EvaluationScore, 0.00001, '=');

            ApplyRFQDisqualificationRules(RFQHeader, VendorQuotationHeader);
        end else begin
            TechnicalWeight := GetConfiguredWeight(DocumentTypeValue, ScoringCriteria."Criteria Type"::TechnicalCapability, 50);
            TrackRecordWeight := GetConfiguredWeight(DocumentTypeValue, ScoringCriteria."Criteria Type"::VendorTrackRecord, 10);

            EnsureScoreWithinConfiguredMaximum('Technical Capability', VendorQuotationHeader."Technical Capability Score", TechnicalWeight);
            EnsureScoreWithinConfiguredMaximum('Track Record', VendorQuotationHeader."Track Record Score", TrackRecordWeight);

            RFPPriceScore := CalculateRFPPriceScore(RFQHeader, VendorQuotationHeader."Total Amount");
            EvaluationScore := VendorQuotationHeader."Technical Capability Score" + VendorQuotationHeader."Track Record Score" + RFPPriceScore;

            VendorQuotationHeader."Delivery Score" := 0;
            VendorQuotationHeader."Pricing Score" := 0;
            VendorQuotationHeader."RFP Price Score" := RFPPriceScore;
            VendorQuotationHeader."Evaluation Score" := Round(EvaluationScore, 0.00001, '=');

            ApplyRFPDisqualificationRules(RFQHeader, VendorQuotationHeader);
        end;

        VendorQuotationHeader.Modify(true);
    end;

    local procedure ApplyRFQDisqualificationRules(var RFQHeader: Record "RFQ Header"; var VendorQuotationHeader: Record "Vendor Quotation Header")
    var
        ScoringCriteria: Record "RFQ Scoring Criteria Setup";
        MinimumStatutory: Decimal;
        MinimumTotal: Decimal;
    begin
        MinimumStatutory := GetConfiguredThreshold(RFQHeader."Scoring Document Type", ScoringCriteria."Criteria Type"::MinimumStatutory, 4);
        MinimumTotal := GetConfiguredThreshold(RFQHeader."Scoring Document Type", ScoringCriteria."Criteria Type"::MinimumTotal, 60);

        if VendorQuotationHeader."Statutory Score" < MinimumStatutory then
            AddDisqualificationReason(VendorQuotationHeader, StrSubstNo('Statutory score below %1.', MinimumStatutory));
        if VendorQuotationHeader."Evaluation Score" < MinimumTotal then
            AddDisqualificationReason(VendorQuotationHeader, StrSubstNo('Total score below minimum qualifying score of %1.', MinimumTotal));
    end;

    local procedure ApplyRFPDisqualificationRules(var RFQHeader: Record "RFQ Header"; var VendorQuotationHeader: Record "Vendor Quotation Header")
    var
        ScoringCriteria: Record "RFQ Scoring Criteria Setup";
        MinimumTechnical: Decimal;
        MinimumTotal: Decimal;
    begin
        MinimumTechnical := GetConfiguredThreshold(RFQHeader."Scoring Document Type", ScoringCriteria."Criteria Type"::MinimumTechnical, 25);
        MinimumTotal := GetConfiguredThreshold(RFQHeader."Scoring Document Type", ScoringCriteria."Criteria Type"::MinimumTotal, 65);

        if VendorQuotationHeader."Technical Capability Score" < MinimumTechnical then
            AddDisqualificationReason(VendorQuotationHeader, StrSubstNo('Technical score below %1.', MinimumTechnical));
        if VendorQuotationHeader."Evaluation Score" < MinimumTotal then
            AddDisqualificationReason(VendorQuotationHeader, StrSubstNo('Total score below minimum qualifying score of %1.', MinimumTotal));
    end;

    local procedure AddDisqualificationReason(var VendorQuotationHeader: Record "Vendor Quotation Header"; ReasonText: Text[250])
    begin
        VendorQuotationHeader.Disqualified := true;
        if VendorQuotationHeader."Disqualification Reason" = '' then
            VendorQuotationHeader."Disqualification Reason" := ReasonText
        else
            VendorQuotationHeader."Disqualification Reason" := CopyStr(VendorQuotationHeader."Disqualification Reason" + ' ' + ReasonText, 1, MaxStrLen(VendorQuotationHeader."Disqualification Reason"));
    end;

    local procedure CalculateDeliveryScore(var RFQHeader: Record "RFQ Header"; VendorDeliveryDate: Date): Decimal
    var
        DeliveryDays: Integer;
        DefaultScore: Decimal;
    begin
        if (RFQHeader."Document Date" = 0D) or (VendorDeliveryDate = 0D) then
            exit(0);

        DeliveryDays := VendorDeliveryDate - RFQHeader."Document Date";
        if DeliveryDays < 0 then
            exit(0);

        DefaultScore := GetDefaultDeliveryScore(DeliveryDays);
        exit(GetDeliveryScoreFromSetup(RFQHeader."Scoring Document Type", DeliveryDays, DefaultScore));
    end;

    local procedure CalculateRFQPricingScore(var RFQHeader: Record "RFQ Header"; LowestQuotedAmount: Decimal; VendorAmount: Decimal): Decimal
    var
        ScoringCriteria: Record "RFQ Scoring Criteria Setup";
        Score: Decimal;
        PriceWeight: Decimal;
    begin
        if (LowestQuotedAmount <= 0) or (VendorAmount <= 0) then
            exit(0);

        PriceWeight := GetConfiguredWeight(RFQHeader."Scoring Document Type", ScoringCriteria."Criteria Type"::PriceComparison, 50);
        Score := (LowestQuotedAmount / VendorAmount) * PriceWeight;
        if Score > PriceWeight then
            Score := PriceWeight;

        exit(Round(Score, 0.00001, '='));
    end;

    local procedure CalculateRFPPriceScore(var RFQHeader: Record "RFQ Header"; VendorAmount: Decimal): Decimal
    var
        ScoringCriteria: Record "RFQ Scoring Criteria Setup";
        Score: Decimal;
        PriceWeight: Decimal;
    begin
        if (RFQHeader."Budget/Base Amount" <= 0) or (VendorAmount <= 0) then
            exit(0);

        PriceWeight := GetConfiguredWeight(RFQHeader."Scoring Document Type", ScoringCriteria."Criteria Type"::PriceComparison, 40);
        Score := (RFQHeader."Budget/Base Amount" / VendorAmount) * PriceWeight;
        if Score > PriceWeight then
            Score := PriceWeight;
        if Score < 0 then
            Score := 0;

        exit(Round(Score, 0.00001, '='));
    end;

    local procedure EnsureScoreWithinConfiguredMaximum(CriterionName: Text[50]; Score: Decimal; MaximumAllowed: Decimal)
    begin
        if Score > MaximumAllowed then
            Error('%1 score %2 is above configured maximum %3.', CriterionName, Score, MaximumAllowed);
    end;

    local procedure HasActiveCriteriaForDocumentType(DocumentType: Integer): Boolean
    var
        ScoringCriteria: Record "RFQ Scoring Criteria Setup";
    begin
        ScoringCriteria.SetRange("Document Type", DocumentType);
        ScoringCriteria.SetRange(Active, true);
        exit(ScoringCriteria.FindFirst());
    end;

    local procedure GetConfiguredWeight(DocumentType: Integer; CriteriaType: Integer; DefaultWeight: Decimal): Decimal
    var
        ScoringCriteria: Record "RFQ Scoring Criteria Setup";
    begin
        ScoringCriteria.SetRange("Document Type", DocumentType);
        ScoringCriteria.SetRange("Criteria Type", CriteriaType);
        ScoringCriteria.SetRange(Active, true);
        if ScoringCriteria.FindFirst() then
            exit(ScoringCriteria."Weight %");

        exit(DefaultWeight);
    end;

    local procedure GetConfiguredThreshold(DocumentType: Integer; CriteriaType: Integer; DefaultValue: Decimal): Decimal
    var
        ScoringCriteria: Record "RFQ Scoring Criteria Setup";
    begin
        ScoringCriteria.SetRange("Document Type", DocumentType);
        ScoringCriteria.SetRange("Criteria Type", CriteriaType);
        ScoringCriteria.SetRange(Active, true);
        if ScoringCriteria.FindFirst() then
            exit(ScoringCriteria."Points Awarded");

        exit(DefaultValue);
    end;

    local procedure GetDefaultDeliveryScore(DeliveryDays: Integer): Decimal
    begin
        if DeliveryDays <= 7 then
            exit(5);
        if DeliveryDays <= 14 then
            exit(2.5);
        exit(0);
    end;

    local procedure GetDeliveryScoreFromSetup(DocumentType: Integer; DeliveryDays: Integer; DefaultScore: Decimal): Decimal
    var
        ScoringCriteria: Record "RFQ Scoring Criteria Setup";
        BestThreshold: Decimal;
        BestScore: Decimal;
        MatchFound: Boolean;
    begin
        ScoringCriteria.SetRange("Document Type", DocumentType);
        ScoringCriteria.SetRange("Criteria Type", ScoringCriteria."Criteria Type"::DeliveryTimeline);
        ScoringCriteria.SetRange(Active, true);
        if ScoringCriteria.FindSet() then
            repeat
                if (DeliveryDays >= ScoringCriteria."Min Threshold/Days") and
                   ((ScoringCriteria."Max Threshold/Days" = 0) or (DeliveryDays <= ScoringCriteria."Max Threshold/Days"))
                then begin
                    if (not MatchFound) or (ScoringCriteria."Min Threshold/Days" > BestThreshold) then begin
                        MatchFound := true;
                        BestThreshold := ScoringCriteria."Min Threshold/Days";
                        BestScore := ScoringCriteria."Points Awarded";
                    end;
                end;
            until ScoringCriteria.Next() = 0;

        if MatchFound then
            exit(BestScore);

        exit(DefaultScore);
    end;

    local procedure AssignRankings(var RFQHeader: Record "RFQ Header")
    var
        VendorQuotationHeader: Record "Vendor Quotation Header";
        CompetitorQuotation: Record "Vendor Quotation Header";
        Rank: Integer;
    begin
        VendorQuotationHeader.SetRange("RFQ No.", RFQHeader."No.");
        VendorQuotationHeader.SetRange(Status, VendorQuotationHeader.Status::"Under Evaluation");
        VendorQuotationHeader.SetRange(Disqualified, false);
        if VendorQuotationHeader.FindSet(true) then
            repeat
                Rank := 1;
                CompetitorQuotation.SetRange("RFQ No.", RFQHeader."No.");
                CompetitorQuotation.SetRange(Status, CompetitorQuotation.Status::"Under Evaluation");
                CompetitorQuotation.SetRange(Disqualified, false);
                if CompetitorQuotation.FindSet() then
                    repeat
                        if CompetitorQuotation."Quotation No." <> VendorQuotationHeader."Quotation No." then
                            if IsBetterQuotation(RFQHeader, CompetitorQuotation, VendorQuotationHeader) then
                                Rank += 1;
                    until CompetitorQuotation.Next() = 0;

                VendorQuotationHeader.Ranking := Rank;
                VendorQuotationHeader.Modify(true);
            until VendorQuotationHeader.Next() = 0;

        VendorQuotationHeader.SetRange("RFQ No.", RFQHeader."No.");
        VendorQuotationHeader.SetRange(Status, VendorQuotationHeader.Status::"Under Evaluation");
        VendorQuotationHeader.SetRange(Disqualified, true);
        if VendorQuotationHeader.FindSet(true) then
            repeat
                VendorQuotationHeader.Ranking := 0;
                VendorQuotationHeader.Modify(true);
            until VendorQuotationHeader.Next() = 0;
    end;

    local procedure IsBetterQuotation(var RFQHeader: Record "RFQ Header"; var LeftQuotation: Record "Vendor Quotation Header"; var RightQuotation: Record "Vendor Quotation Header"): Boolean
    begin
        if LeftQuotation."Evaluation Score" > RightQuotation."Evaluation Score" then
            exit(true);
        if LeftQuotation."Evaluation Score" < RightQuotation."Evaluation Score" then
            exit(false);

        if RFQHeader."Evaluation Matrix Type" = RFQHeader."Evaluation Matrix Type"::RFQ then begin
            if LeftQuotation."Pricing Score" > RightQuotation."Pricing Score" then
                exit(true);
            if LeftQuotation."Pricing Score" < RightQuotation."Pricing Score" then
                exit(false);

            if LeftQuotation."Quality Score" > RightQuotation."Quality Score" then
                exit(true);
            if LeftQuotation."Quality Score" < RightQuotation."Quality Score" then
                exit(false);

            if LeftQuotation."Statutory Score" > RightQuotation."Statutory Score" then
                exit(true);
            if LeftQuotation."Statutory Score" < RightQuotation."Statutory Score" then
                exit(false);

            if LeftQuotation."Delivery Score" > RightQuotation."Delivery Score" then
                exit(true);
            if LeftQuotation."Delivery Score" < RightQuotation."Delivery Score" then
                exit(false);
        end else begin
            if LeftQuotation."RFP Price Score" > RightQuotation."RFP Price Score" then
                exit(true);
            if LeftQuotation."RFP Price Score" < RightQuotation."RFP Price Score" then
                exit(false);

            if LeftQuotation."Technical Capability Score" > RightQuotation."Technical Capability Score" then
                exit(true);
            if LeftQuotation."Technical Capability Score" < RightQuotation."Technical Capability Score" then
                exit(false);

            if LeftQuotation."Track Record Score" > RightQuotation."Track Record Score" then
                exit(true);
            if LeftQuotation."Track Record Score" < RightQuotation."Track Record Score" then
                exit(false);
        end;

        if LeftQuotation."Total Amount" < RightQuotation."Total Amount" then
            exit(true);
        if LeftQuotation."Total Amount" > RightQuotation."Total Amount" then
            exit(false);

        exit(LeftQuotation."Quotation No." < RightQuotation."Quotation No.");
    end;

    local procedure ImportQuotationLinesFromExcel(var VendorQuotationHeader: Record "Vendor Quotation Header"; WorksheetStream: InStream): Integer
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        VendorQuotationLine: Record "Vendor Quotation Line";
        TempBlob: Codeunit System.Utilities."Temp Blob";
        TempBlobOutStream: OutStream;
        FreshStream: InStream;
        SheetName: Text;
        RowNo: Integer;
        LastRowNo: Integer;
        LineNo: Integer;
        ImportedLineCount: Integer;
        VendorNoText: Text;
        DocumentNoText: Text;
        TypeText: Text;
        DescriptionText: Text;
        Quantity: Decimal;
        UnitCost: Decimal;
        Amount: Decimal;
        QuotationLineType: Enum "Purchase Line Type";
    begin
        // Step 1: Copy InStream into TempBlob so we can read it multiple times
        TempBlob.CreateOutStream(TempBlobOutStream);
        CopyStream(TempBlobOutStream, WorksheetStream);

        // Step 2: Get sheet name first (consumes one stream read)
        SheetName := SelectWorksheetName(TempBlob);

        // Step 3: Create fresh stream and open book with actual sheet name
        TempBlob.CreateInStream(FreshStream);
        TempExcelBuffer.OpenBookStream(FreshStream, SheetName);
        TempExcelBuffer.ReadSheet();
        TempExcelBuffer.CloseBook();

        TempExcelBuffer.Reset();
        if not TempExcelBuffer.FindLast() then
            Error('The selected Excel file is empty.');
        LastRowNo := TempExcelBuffer."Row No.";

        VendorQuotationLine.SetRange("Quotation No.", VendorQuotationHeader."Quotation No.");
        VendorQuotationLine.DeleteAll(true);

        LineNo := 0;
        for RowNo := 2 to LastRowNo do begin
            VendorNoText := GetExcelCellText(TempExcelBuffer, RowNo, 1);
            DocumentNoText := GetExcelCellText(TempExcelBuffer, RowNo, 2);
            TypeText := GetExcelCellText(TempExcelBuffer, RowNo, 3);
            DescriptionText := GetExcelCellText(TempExcelBuffer, RowNo, 4);

            if (VendorNoText = '') and (DocumentNoText = '') and (TypeText = '') and (DescriptionText = '') then
                continue;

            // Validate before any record changes
            if DescriptionText = '' then
                Error('Description is required on row %1.', RowNo);

            ValidateImportRow(VendorQuotationHeader, RowNo, VendorNoText, DocumentNoText);
            QuotationLineType := ParsePurchaseLineType(TypeText, RowNo);
            Quantity := GetExcelDecimalValue(TempExcelBuffer, RowNo, 5, 'Quantity', true);
            UnitCost := GetExcelDecimalValue(TempExcelBuffer, RowNo, 6, 'Unit Cost', true);
            Amount := GetExcelDecimalValue(TempExcelBuffer, RowNo, 7, 'Amount', false);
            if Amount = 0 then
                Amount := Quantity * UnitCost;

            LineNo += 10000;
            VendorQuotationLine.Init();
            VendorQuotationLine."Quotation No." := VendorQuotationHeader."Quotation No.";
            VendorQuotationLine."Line No." := LineNo;
            VendorQuotationLine."RFQ No." := VendorQuotationHeader."RFQ No.";
            VendorQuotationLine.Type := QuotationLineType;
            VendorQuotationLine."Item/Service Description" := CopyStr(DescriptionText, 1, MaxStrLen(VendorQuotationLine."Item/Service Description"));
            VendorQuotationLine.Quantity := Quantity;
            VendorQuotationLine."Unit Price" := UnitCost;
            VendorQuotationLine."Total Price" := Amount;
            VendorQuotationLine.Insert(true);
            ImportedLineCount += 1;
        end;

        if ImportedLineCount = 0 then
            Error('No quotation lines were imported. Ensure the Excel file has data rows from row 2 onward.');

        exit(ImportedLineCount);
    end;

    local procedure ImportBulkQuotationLinesFromExcel(var RFQHeader: Record "RFQ Header"; var TempBlob: Codeunit System.Utilities."Temp Blob"; var ImportedQuotationCount: Integer): Integer
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        VendorQuotationHeader: Record "Vendor Quotation Header";
        VendorQuotationLine: Record "Vendor Quotation Line";
        WorksheetStream: InStream;
        RowNo: Integer;
        LastRowNo: Integer;
        ImportedLineCount: Integer;
        VendorNoText: Text;
        DocumentNoText: Text;
        TypeText: Text;
        DescriptionText: Text;
        Quantity: Decimal;
        UnitCost: Decimal;
        Amount: Decimal;
        QuotationLineType: Enum "Purchase Line Type";
        VendorNoCode: Code[20];
        QuotationNoCode: Code[20];
        NextLineNo: Integer;
        ProcessedQuotationMap: Dictionary of [Code[20], Boolean];
        QuotationNextLineNoMap: Dictionary of [Code[20], Integer];
    begin
        TempBlob.CreateInStream(WorksheetStream);
        TempExcelBuffer.OpenBookStream(WorksheetStream, SelectWorksheetName(TempBlob));
        TempExcelBuffer.ReadSheet();
        TempExcelBuffer.CloseBook();

        TempExcelBuffer.Reset();
        if not TempExcelBuffer.FindLast() then
            Error('The selected Excel file is empty.');
        LastRowNo := TempExcelBuffer."Row No.";

        for RowNo := 2 to LastRowNo do begin
            VendorNoText := GetExcelCellText(TempExcelBuffer, RowNo, 1);
            DocumentNoText := GetExcelCellText(TempExcelBuffer, RowNo, 2);
            TypeText := GetExcelCellText(TempExcelBuffer, RowNo, 3);
            DescriptionText := GetExcelCellText(TempExcelBuffer, RowNo, 4);

            // Skip fully empty rows
            if (VendorNoText = '') and (DocumentNoText = '') and (TypeText = '') and (DescriptionText = '') then
                continue;

            // Fix #3: Validate all required fields BEFORE modifying any records
            if VendorNoText = '' then
                Error('Vendor No. is required on row %1.', RowNo);
            if DocumentNoText = '' then
                Error('Document No. is required on row %1.', RowNo);
            if DescriptionText = '' then
                Error('Description is required on row %1.', RowNo);

            VendorNoCode := CopyStr(VendorNoText, 1, MaxStrLen(VendorNoCode));
            QuotationNoCode := CopyStr(DocumentNoText, 1, MaxStrLen(QuotationNoCode));

            // Header is only created/modified after all validations pass
            PrepareBulkImportHeader(
                RFQHeader,
                VendorNoCode,
                QuotationNoCode,
                ProcessedQuotationMap,
                QuotationNextLineNoMap,
                ImportedQuotationCount);

            QuotationLineType := ParsePurchaseLineType(TypeText, RowNo);
            Quantity := GetExcelDecimalValue(TempExcelBuffer, RowNo, 5, 'Quantity', true);
            UnitCost := GetExcelDecimalValue(TempExcelBuffer, RowNo, 6, 'Unit Cost', true);
            Amount := GetExcelDecimalValue(TempExcelBuffer, RowNo, 7, 'Amount', false);
            if Amount = 0 then
                Amount := Quantity * UnitCost;

            if not QuotationNextLineNoMap.Get(QuotationNoCode, NextLineNo) then
                Error('Internal mapping error while importing quotation %1.', QuotationNoCode);

            VendorQuotationLine.Init();
            VendorQuotationLine."Quotation No." := QuotationNoCode;
            VendorQuotationLine."Line No." := NextLineNo;
            VendorQuotationLine."RFQ No." := RFQHeader."No.";
            VendorQuotationLine.Type := QuotationLineType;
            VendorQuotationLine."Item/Service Description" := CopyStr(DescriptionText, 1, MaxStrLen(VendorQuotationLine."Item/Service Description"));
            VendorQuotationLine.Quantity := Quantity;
            VendorQuotationLine."Unit Price" := UnitCost;
            VendorQuotationLine."Total Price" := Amount;
            VendorQuotationLine.Insert(true);

            QuotationNextLineNoMap.Set(QuotationNoCode, NextLineNo + 10000);
            ImportedLineCount += 1;
        end;

        if ImportedLineCount = 0 then
            Error('No quotation lines were imported. Ensure the Excel file has data rows from row 2 onward.');

        foreach QuotationNoCode in ProcessedQuotationMap.Keys do begin
            VendorQuotationLine.Reset();
            VendorQuotationLine.SetRange("Quotation No.", QuotationNoCode);
            VendorQuotationLine.CalcSums("Total Price");

            VendorQuotationHeader.Get(QuotationNoCode);
            VendorQuotationHeader."Total Amount" := VendorQuotationLine."Total Price";
            VendorQuotationHeader.Status := VendorQuotationHeader.Status::Submitted;
            if VendorQuotationHeader."Submission Date" = 0D then
                VendorQuotationHeader."Submission Date" := WorkDate();
            VendorQuotationHeader.Modify(true);
        end;

        exit(ImportedLineCount);
    end;

    local procedure PrepareBulkImportHeader(var RFQHeader: Record "RFQ Header"; VendorNoCode: Code[20]; QuotationNoCode: Code[20]; var ProcessedQuotationMap: Dictionary of [Code[20], Boolean]; var QuotationNextLineNoMap: Dictionary of [Code[20], Integer]; var ImportedQuotationCount: Integer)
    var
        VendorQuotationHeader: Record "Vendor Quotation Header";
        VendorQuotationLine: Record "Vendor Quotation Line";
    begin
        if ProcessedQuotationMap.ContainsKey(QuotationNoCode) then
            exit;

        if VendorQuotationHeader.Get(QuotationNoCode) then begin
            if VendorQuotationHeader."RFQ No." <> RFQHeader."No." then
                Error(
                    'Quotation No. %1 belongs to RFQ %2, not RFQ %3.',
                    QuotationNoCode,
                    VendorQuotationHeader."RFQ No.",
                    RFQHeader."No.");

            if (VendorQuotationHeader."Vendor No." <> '') and
                (UpperCase(VendorQuotationHeader."Vendor No.") <> UpperCase(VendorNoCode)) then
                Error(
                    'Vendor No. mismatch for quotation %1. Existing vendor is %2, file has %3.',
                    QuotationNoCode,
                    VendorQuotationHeader."Vendor No.",
                    VendorNoCode);

            if VendorQuotationHeader."Vendor No." = '' then begin
                VendorQuotationHeader."Vendor No." := VendorNoCode;
                VendorQuotationHeader.Modify(true);
            end;

            if VendorQuotationHeader.Status in [VendorQuotationHeader.Status::Awarded, VendorQuotationHeader.Status::Rejected] then
                Error('Quotation %1 is in %2 status and cannot be replaced via bulk import.', QuotationNoCode, VendorQuotationHeader.Status);
        end else begin
            VendorQuotationHeader.Init();
            VendorQuotationHeader."Quotation No." := QuotationNoCode;
            VendorQuotationHeader."Vendor No." := VendorNoCode;
            VendorQuotationHeader."RFQ No." := RFQHeader."No.";
            VendorQuotationHeader.Insert(true);
        end;

        VendorQuotationLine.SetRange("Quotation No.", QuotationNoCode);
        VendorQuotationLine.DeleteAll(true);

        ProcessedQuotationMap.Add(QuotationNoCode, true);
        QuotationNextLineNoMap.Add(QuotationNoCode, 10000);
        ImportedQuotationCount += 1;
    end;

    local procedure SelectWorksheetName(var TempBlob: Codeunit "Temp Blob"): Text
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        WorksheetStream: InStream;
    begin
        TempBlob.CreateInStream(WorksheetStream);
        exit(TempExcelBuffer.SelectSheetsNameStream(WorksheetStream));
    end;

    local procedure GetExcelCellText(var TempExcelBuffer: Record "Excel Buffer" temporary; RowNo: Integer; ColumnNo: Integer): Text
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.SetRange("Row No.", RowNo);
        TempExcelBuffer.SetRange("Column No.", ColumnNo);
        if TempExcelBuffer.FindFirst() then
            exit(DelChr(TempExcelBuffer."Cell Value as Text", '<>', ' '));

        exit('');
    end;

    local procedure GetExcelDecimalValue(var TempExcelBuffer: Record "Excel Buffer" temporary; RowNo: Integer; ColumnNo: Integer; FieldName: Text[30]; Required: Boolean): Decimal
    var
        ParsedValue: Decimal;
        ValueText: Text;
        SanitizedValue: Text;
    begin
        ValueText := GetExcelCellText(TempExcelBuffer, RowNo, ColumnNo);
        if ValueText = '' then begin
            if Required then
                Error('%1 is required on row %2.', FieldName, RowNo);
            exit(0);
        end;

        if Evaluate(ParsedValue, ValueText) then
            exit(ParsedValue);

        SanitizedValue := DelChr(ValueText, '<>', ' ');
        if Evaluate(ParsedValue, SanitizedValue) then
            exit(ParsedValue);

        SanitizedValue := DelChr(SanitizedValue, '<>', ',');
        if Evaluate(ParsedValue, SanitizedValue) then
            exit(ParsedValue);

        Error('Invalid %1 "%2" on row %3.', FieldName, ValueText, RowNo);

        exit(ParsedValue);
    end;

    local procedure ValidateImportRow(var VendorQuotationHeader: Record "Vendor Quotation Header"; RowNo: Integer; VendorNoText: Text; DocumentNoText: Text)
    begin
        if UpperCase(VendorNoText) <> UpperCase(VendorQuotationHeader."Vendor No.") then
            Error(
                'Vendor No. mismatch on row %1. Expected %2, found %3.',
                RowNo,
                VendorQuotationHeader."Vendor No.",
                VendorNoText);

        if UpperCase(DocumentNoText) <> UpperCase(VendorQuotationHeader."Quotation No.") then
            Error(
                'Document No. mismatch on row %1. Expected %2, found %3. In this import, Document No. must equal Quotation No.',
                RowNo,
                VendorQuotationHeader."Quotation No.",
                DocumentNoText);
    end;

    local procedure ParsePurchaseLineType(TypeText: Text; RowNo: Integer): Enum "Purchase Line Type"
    var
        PurchaseLineType: Enum "Purchase Line Type";
        NormalizedType: Text;
    begin
        NormalizedType := UpperCase(DelChr(TypeText, '<>', ' '));
        if NormalizedType = '' then
            Error('Type is required on row %1. Valid examples: Item, G/L Account, Fixed Asset, Resource.', RowNo);

        case NormalizedType of
            'ITEM':
                exit(PurchaseLineType::Item);
            'G/LACCOUNT', 'GLACCOUNT', 'G/L', 'GL':
                exit(PurchaseLineType::"G/L Account");
            'FIXEDASSET', 'ASSET', 'FA':
                exit(PurchaseLineType::"Fixed Asset");
            'RESOURCE':
                exit(PurchaseLineType::Resource);
            'CHARGE(ITEM)', 'ITEMCHARGE', 'CHARGEITEM':
                exit(PurchaseLineType::"Charge (Item)");
            else begin
                if Evaluate(PurchaseLineType, TypeText) then
                    exit(PurchaseLineType);
                Error(
                    'Unsupported Type "%1" on row %2. Valid values include Item, G/L Account, Fixed Asset, Resource, Charge (Item).',
                    TypeText,
                    RowNo);
            end;
        end;
    end;

}
