codeunit 50503 "Procure Workflow Mgt"
{
    procedure ReleaseExternalRequisition(var ExternalRequisitionHeader: Record "External Requisition Header")
    var
        ProcurementSetup: Record "Procurement Setup";
    begin
        ExternalRequisitionHeader.TestField(Status, ExternalRequisitionHeader.Status::Open);

        ProcurementSetup.Get();
        if ProcurementSetup."Enable Approval Workflow" then begin
            ExternalRequisitionHeader.Status := ExternalRequisitionHeader.Status::"Pending Approval";
            ExternalRequisitionHeader."Approval Status" := ExternalRequisitionHeader."Approval Status"::"Pending Approval";
            InitiateApproval(ExternalRequisitionHeader."Requisition No.", ExternalRequisitionHeader."Total Amount", 2); // 2 = External Requisition
        end else begin
            ExternalRequisitionHeader.Status := ExternalRequisitionHeader.Status::Approved;
            ExternalRequisitionHeader."Approval Status" := ExternalRequisitionHeader."Approval Status"::Approved;
        end;

        ExternalRequisitionHeader.Modify(true);
    end;

    procedure InitiateLPOApproval(var LPOLSOHeader: Record "LPO/LSO Header")
    begin
        InitiateApproval(LPOLSOHeader."LPO No.", LPOLSOHeader."Total Amount", 3); 
    end;

    local procedure InitiateApproval(DocumentNo: Code[20]; DocumentAmount: Decimal; DocumentType: Integer)
    var
        ProcurementApprovalWorkflow: Record "Procurement Approval Workflow";
        ProcurementApprovalEntry: Record "Procurement Approval Entry";
        ApprovalLevel: Integer;
    begin
        // Determine approval level based on amount
        ApprovalLevel := GetApprovalLevel(DocumentAmount, DocumentType);

        // Create approval entries
        ProcurementApprovalWorkflow.SetRange("Workflow Type", DocumentType);
        ProcurementApprovalWorkflow.SetFilter("Approval Level", '<=%1', ApprovalLevel);
        if ProcurementApprovalWorkflow.FindSet() then begin
            repeat
                ProcurementApprovalEntry.Init();
                ProcurementApprovalEntry."Document Type" := DocumentType;
                ProcurementApprovalEntry."Document No." := DocumentNo;
                ProcurementApprovalEntry."Approval Level" := ProcurementApprovalWorkflow."Approval Level";
                ProcurementApprovalEntry."Approver User ID" := ProcurementApprovalWorkflow."Approver User ID";
                ProcurementApprovalEntry.Status := ProcurementApprovalEntry.Status::Open;
                ProcurementApprovalEntry.Insert(true);
            until ProcurementApprovalWorkflow.Next() = 0;
        end;
    end;

    local procedure GetApprovalLevel(DocumentAmount: Decimal; DocumentType: Integer): Integer
    var
        ProcurementSetup: Record "Procurement Setup";
    begin
        ProcurementSetup.Get();
        if DocumentAmount <= ProcurementSetup."Finance Approval Threshold" then
            exit(1)
        else
            if DocumentAmount <= ProcurementSetup."Proc Committee Threshold" then
                exit(2)
            else
                exit(3);
    end;

    procedure ApproveDocument(DocumentType: Integer; DocumentNo: Code[20]; ApprovalLevel: Integer)
    var
        ProcurementApprovalEntry: Record "Procurement Approval Entry";
        StoreRequisitionHeader: Record "Store Requisition Header";
        ExternalRequisitionHeader: Record "External Requisition Header";
        LPOLSOHeader: Record "LPO/LSO Header";
    begin
        ProcurementApprovalEntry.SetRange("Document Type", DocumentType);
        ProcurementApprovalEntry.SetRange("Document No.", DocumentNo);
        ProcurementApprovalEntry.SetRange("Approval Level", ApprovalLevel);
        ProcurementApprovalEntry.SetRange("Approver User ID", UserId);
        ProcurementApprovalEntry.SetRange(Status, ProcurementApprovalEntry.Status::Open);
        if ProcurementApprovalEntry.FindFirst() then begin
            ProcurementApprovalEntry.Status := ProcurementApprovalEntry.Status::Approved;
            ProcurementApprovalEntry."Approval Date" := CurrentDateTime;
            ProcurementApprovalEntry.Modify(true);

            // Check if all approvals are complete
            if AllApprovalsComplete(DocumentType, DocumentNo) then begin
                case DocumentType of
                    1: // Store Requisition
                        begin
                            StoreRequisitionHeader.Get(DocumentNo);
                            StoreRequisitionHeader.Status := StoreRequisitionHeader.Status::Released;
                            StoreRequisitionHeader.Status := StoreRequisitionHeader.Status::Released;
                            StoreRequisitionHeader.Modify(true);
                        end;
                    2: // External Requisition
                        begin
                            ExternalRequisitionHeader.Get(DocumentNo);
                            ExternalRequisitionHeader.Status := ExternalRequisitionHeader.Status::Approved;
                            ExternalRequisitionHeader."Approval Status" := ExternalRequisitionHeader."Approval Status"::Approved;
                            ExternalRequisitionHeader.Modify(true);
                        end;
                    3: // LPO/LSO
                        begin
                            LPOLSOHeader.Get(DocumentNo);
                            LPOLSOHeader.Status := LPOLSOHeader.Status::Approved;
                            LPOLSOHeader."Approval Status" := LPOLSOHeader."Approval Status"::Approved;
                            LPOLSOHeader.Modify(true);
                        end;
                end;
            end;
        end;
    end;

    local procedure AllApprovalsComplete(DocumentType: Integer; DocumentNo: Code[20]): Boolean
    var
        ProcurementApprovalEntry: Record "Procurement Approval Entry";
    begin
        ProcurementApprovalEntry.SetRange("Document Type", DocumentType);
        ProcurementApprovalEntry.SetRange("Document No.", DocumentNo);
        ProcurementApprovalEntry.SetRange(Status, ProcurementApprovalEntry.Status::Open);
        exit(ProcurementApprovalEntry.IsEmpty());
    end;
}
