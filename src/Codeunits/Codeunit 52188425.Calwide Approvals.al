codeunit 50017 "Calwide Approvals"
{



    [IntegrationEvent(false, false)]
    procedure OnSendDocForApproval(var Variant: Variant)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelDocForApproval(var Variant: Variant)
    begin
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calwide Approvals", 'OnSendDocForApproval', '', false, false)]
    local procedure RunWorkflowOnSendApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Approval Tracker":
                WorkFlowManagement.HandleEvent(RunWorkflowonSendCustomDocForApprovalCode, Variant);
        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calwide Approvals", 'OnCancelDocForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Approval Tracker":
                WorkFlowManagement.HandleEvent(RunWorkflowonCancelCustomDocForApprovalCode, Variant);
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddWorkFlowEventsToLibrary()
    var
        WorkFlowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowonSendCustomDocForApprovalCode, Database::"Approval Tracker", OnSendCustomDocApproval, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowonCancelCustomDocForApprovalCode, Database::"Approval Tracker", OnCancelCustomDocApproval, 0, false);

    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddWorkFlowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkFlowEventHandling: Codeunit "Workflow Event Handling";
    begin
        case EventFunctionName of
            RunWorkflowonCancelCustomDocForApprovalCode:
                WorkFlowEventHandling.AddEventPredecessor(RunWorkflowonCancelCustomDocForApprovalCode, RunWorkflowonSendCustomDocForApprovalCode);
            WorkFlowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkFlowEventHandling.AddEventPredecessor(WorkFlowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowonSendCustomDocForApprovalCode);
        end;
    end;





    procedure CheckWorkflowEnabled(var variant: variant): Boolean
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(variant);
        case RecRef.Number of
            Database::"Approval Tracker":
                exit(CheckIfApprovalWorkflowCodeIsEnabled(variant, RunWorkflowonSendCustomDocForApprovalCode));
        end;
    end;

    procedure CheckIfApprovalWorkflowCodeIsEnabled(var Variant: Variant; Workflowtext: Text): Boolean
    var
        TheWorkflowIsNotEnabled: Label 'This record is not supported by the related aproval workflow';
    begin
        if not WorkFlowManagement.CanExecuteWorkflow(Variant, Workflowtext) then
            Error(TheWorkflowIsNotEnabled);
        exit(true);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var ApprovalEntryArgument: Record "Approval Entry"; var RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        ApprovalTracker: record "Approval Tracker";
    begin
        case RecRef.Number of
            Database::"Approval Tracker":
                begin
                    //RecRef.SetTable(ApprovalTracker);
                    //ApprovalEntryArgument."Document No." := ApprovalTracker."Tracker ID";
                    RecRef.SETTABLE(ApprovalTracker);
                    ApprovalEntryArgument."Document No." := ApprovalTracker."Document No.";
                    ApprovalEntryArgument."Tracker ID" := ApprovalTracker."Tracker ID";
                    ApprovalEntryArgument."Document Table ID" := ApprovalTracker."Table ID";
                    ApprovalEntryArgument."Document Rec ID to Approve" := ApprovalTracker."Record ID to Approve";
                    ApprovalEntryArgument."Document Type" := ApprovalTracker."Document Type";
                    ApprovalEntryArgument.Amount := ApprovalTracker."Document Amount";
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalTracker."Document Amount";
                    ApprovalEntryArgument.Name := ApprovalTracker.Name;
                    ApprovalEntryArgument.Name2 := ApprovalTracker.Details;
                    //ERROR('TEST: ' + ApprovalTracker."Document No.");
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnBeforeGetConditionalListPageID', '', false, false)]
    local procedure OnBeforeGetConditionalListPageID(RecRef: RecordRef; var PageID: Integer; var IsHandled: Boolean);
    begin

        PageID := 0;
        IsHandled := false;
        case RecRef.Number of
            DATABASE::"Approval Tracker":
                begin
                    PageID := GetApprovalTrackerDocumentPageID(RecRef);
                    if PageID <> 0 then
                        IsHandled := true;

                end;

        end;
    end;

    local procedure GetApprovalTrackerDocumentPageID(RecordRef: RecordRef) PageID: Integer
    var
        PageMan: Codeunit "Page Management";
    begin

        RecordRef.SETTABLE(ApprovalTracker);
        RecordRef.GET(ApprovalTracker."Record ID to Approve");
        PageID := 0;
        CASE ApprovalTracker."Document Type" OF
            ApprovalTracker."Document Type"::"Member Application":
                BEGIN
                    IF MemberApplication.GET(ApprovalTracker."Document No.") THEN BEGIN

                        IF MemberApplication.Type = MemberApplication.Type::Group THEN
                            PageID := (PAGE::"Group Registration Card");
                    END;
                END;
        END;

        // Choose default card only if record exists
        IF PageID = 0 THEN
            PageID := PageMan.GetDefaultCardPageID(ApprovalTracker."Table ID");


        IF PageID = 0 THEN
            PageID := PageMan.GetDefaultLookupPageID(ApprovalTracker."Table ID");

        //MESSAGE('PageID %1  ',PageID);




    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    //procedure ReOpen(Var Variant: Variant)
    procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ApprovalTracker: record "Approval Tracker";
    begin
        case RecRef.Number of
            Database::"Approval Tracker":
                begin
                    RecRef.SetTable(ApprovalTracker);
                    ApprovalTracker.Validate(Status, ApprovalTracker.Status::Open);
                    ApprovalTracker.Modify();
                    Handled := true;

                    UpdateTrackerDocument(ApprovalTracker, Status::Open);
                end;
        end
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    //procedure ReOpen(Var Variant: Variant)
    procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ApprovalTracker: record "Approval Tracker";
    begin
        case RecRef.Number of
            Database::"Approval Tracker":
                begin
                    RecRef.SetTable(ApprovalTracker);
                    ApprovalTracker.Validate(Status, ApprovalTracker.Status::Approved);
                    ApprovalTracker.Modify();
                    Handled := true;

                    UpdateTrackerDocument(ApprovalTracker, Status::Approved);
                end;
        end
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    //procedure ReOpen(Var Variant: Variant)
    procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var isHandled: Boolean)
    var
        ApprovalTracker: record "Approval Tracker";
    begin
        case RecRef.Number of
            Database::"Approval Tracker":
                begin
                    RecRef.SetTable(ApprovalTracker);
                    ApprovalTracker.Validate(Status, ApprovalTracker.Status::"Pending");
                    ApprovalTracker.Modify();
                    isHandled := true;

                    UpdateTrackerDocument(ApprovalTracker, Status::Pending);
                end;
        end
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    //procedure ReOpen(Var Variant: Variant)
    procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        ApprovalTracker: record "Approval Tracker";
    begin
        if ApprovalTracker.Get(ApprovalEntry."Tracker ID") then begin

            ApprovalTracker.Validate(Status, ApprovalTracker.Status::Rejected);
            ApprovalTracker.Modify();

            UpdateTrackerDocument(ApprovalTracker, Status::Rejected);
        end
    end;

    procedure CreateTracker(var Variant: Variant; DocumentNo: Code[20]; DocumentAmount: Decimal; DocumentType: Enum "Custom Document Type"; Dim1: Code[10];
                                                                                                                   Dim2: Code[10];
                                                                                                                   LoanSource: Option BOSA,FOSA,MICRO)
    var
        TrackerID: Code[20];
        PowerEvents: Codeunit "UW Power Automate Bus. Events";
    begin
        RecRef.GetTable(Variant);

        TrackerID := 'X';

        ApprovalTracker.Reset;
        ApprovalTracker.SetRange("Table ID", RecRef.Number);
        ApprovalTracker.SetRange("Document No.", DocumentNo);
        if ApprovalTracker.FindFirst then begin

            if ApprovalTracker.Status = ApprovalTracker.Status::"Pending" then begin

                ApprovalTracker.Status := ApprovalTracker.Status::Open;
                ApprovalTracker.Modify;
                TrackerVariant := ApprovalTracker;
                //if CheckWorkflowEnabled(TrackerVariant) then
                //  OnCancelDocForApproval(TrackerVariant);

            end;
            if ApprovalTracker.Status = ApprovalTracker.Status::Approved then begin
                ApprovalTracker.Status := ApprovalTracker.Status::Open;
                ApprovalTracker.Modify;
            end;
            if ApprovalTracker.Status = ApprovalTracker.Status::Rejected then begin
                ApprovalTracker.Status := ApprovalTracker.Status::Open;
                ApprovalTracker.Modify;
            end;
        end;


        ApprovalTracker.Reset;
        ApprovalTracker.SetRange("Table ID", RecRef.Number);
        ApprovalTracker.SetRange("Document No.", DocumentNo);
        if ApprovalTracker.FindFirst then begin

            Message('DocumentType-Old: %1', DocumentType);
            if ApprovalTracker.Status = ApprovalTracker.Status::Open then begin
                UserSetup.Get(UserId);
                ApprovalTracker."Document Type" := DocumentType;
                ApprovalTracker."Sender ID" := UserId;
                ApprovalTracker."Record ID to Approve" := RecRef.RecordId;
                ApprovalTracker."Document Amount" := DocumentAmount;
                ApprovalTracker."Loan Source" := LoanSource;
                ApprovalTracker."Global Dimension 1 Code" := Dim1;
                ApprovalTracker."Global Dimension 2 Code" := Dim2;
                if GetResponsibilityCenter(ApprovalTracker) <> '' then
                    ApprovalTracker."Responsibility Center" := GetResponsibilityCenter(ApprovalTracker)
                else
                    ApprovalTracker."Responsibility Center" := UserSetup."Responsibility Center";

                if ApprovalTracker.Name = '' then
                    ApprovalTracker.Name := UpdateTrackerName(ApprovalTracker);

                ApprovalTracker.Modify;

            end;
            if ApprovalTracker.Status = ApprovalTracker.Status::"Pending" then begin
                Error('Document Already Sent For Approval');
            end;
            if ApprovalTracker.Status = ApprovalTracker.Status::Approved then begin
                Error('Document Already Approved');
            end;
            if ApprovalTracker.Status = ApprovalTracker.Status::Rejected then begin
                Error('Document Already Rejected');
            end;

            TrackerID := ApprovalTracker."Tracker ID";

        end
        else begin

            //Message('DocumentType-New: %1', DocumentType);
            UserSetup.Get(UserId);
            ApprovalTracker.Init;
            ApprovalTracker."Tracker ID" := '';
            ApprovalTracker."Table ID" := RecRef.Number;
            ApprovalTracker."Document Type" := DocumentType;
            ApprovalTracker."Document No." := DocumentNo;
            ApprovalTracker."Sender ID" := UserId;
            ApprovalTracker."Loan Source" := LoanSource;
            ApprovalTracker."Record ID to Approve" := RecRef.RecordId;
            ApprovalTracker."Document Amount" := DocumentAmount;
            ApprovalTracker."Global Dimension 1 Code" := Dim1;
            ApprovalTracker."Global Dimension 2 Code" := Dim2;
            if GetResponsibilityCenter(ApprovalTracker) <> '' then
                ApprovalTracker."Responsibility Center" := GetResponsibilityCenter(ApprovalTracker)
            else
                ApprovalTracker."Responsibility Center" := UserSetup."Responsibility Center";
            ApprovalTracker.Status := ApprovalTracker.Status::Open;
            ApprovalTracker.Name := UpdateTrackerName(ApprovalTracker);

            ApprovalTracker.Insert(true);

            TrackerID := ApprovalTracker."Tracker ID";
        end;



        if ApprovalTracker.Get(TrackerID) then begin
            TrackerVariant := ApprovalTracker;

            //Message('DocType: %1', ApprovalTracker."Document Type");
            CalwideApprMgt.SendTrackerApprovalRequest(ApprovalTracker);
            PowerEvents.RaiseApprovalRequested(
                Format(ApprovalTracker."Document Type"),
                ApprovalTracker."Document No.",
                '',
                ApprovalTracker.Name,
                ApprovalTracker."Document Amount",
                ApprovalTracker."Sender ID",
                ApprovalTracker."Responsibility Center");


            //if CheckWorkflowEnabled(TrackerVariant) then
            //  OnSendDocForApproval(TrackerVariant);
        end;
    end;

    procedure CreateCustomTracker(var Variant: Variant; DocumentNo: Code[20]; DocumentAmount: Decimal; DocumentType: Enum "Custom Document Type"; Dim1: Code[10];
                                                                                                                   Dim2: Code[10];
                                                                                                                   LoanSource: Option BOSA,FOSA,MICRO)
    var
        TrackerID: Code[20];
        PowerEvents: Codeunit "UW Power Automate Bus. Events";
    begin
        RecRef.GetTable(Variant);

        TrackerID := 'X';

        ApprovalTracker.Reset;
        ApprovalTracker.SetRange("Table ID", RecRef.Number);
        ApprovalTracker.SetRange("Document No.", DocumentNo);
        if ApprovalTracker.FindFirst then begin

            if ApprovalTracker.Status = ApprovalTracker.Status::"Pending" then begin

                ApprovalTracker.Status := ApprovalTracker.Status::Open;
                ApprovalTracker.Modify;
                TrackerVariant := ApprovalTracker;

                //if CheckWorkflowEnabled(TrackerVariant) then
                //  OnCancelDocForApproval(TrackerVariant);

            end;
            if ApprovalTracker.Status = ApprovalTracker.Status::Approved then begin
                ApprovalTracker.Status := ApprovalTracker.Status::Open;
                ApprovalTracker.Modify;
            end;
            if ApprovalTracker.Status = ApprovalTracker.Status::Rejected then begin
                ApprovalTracker.Status := ApprovalTracker.Status::Open;
                ApprovalTracker.Modify;
            end;
        end;

        ApprovalTracker.Reset;
        ApprovalTracker.SetRange("Document No.", DocumentNo);
        if ApprovalTracker.FindFirst then begin
            ApprovalTracker.Delete();
        end;


        ApprovalTracker.Reset;
        ApprovalTracker.SetRange("Table ID", RecRef.Number);
        ApprovalTracker.SetRange("Document No.", DocumentNo);
        if ApprovalTracker.FindFirst then begin
            if ApprovalTracker.Status = ApprovalTracker.Status::Open then begin
                UserSetup.Get(UserId);
                ApprovalTracker."Document Type" := ApprovalTracker."Document Type"::" ";
                ApprovalTracker."Custom Document Type" := DocumentType;
                ApprovalTracker."Sender ID" := UserId;
                if GetDocumentSender(ApprovalTracker) <> '' then
                    ApprovalTracker."Sender ID" := GetDocumentSender(ApprovalTracker);
                ApprovalTracker."Record ID to Approve" := RecRef.RecordId;
                ApprovalTracker."Document Amount" := DocumentAmount;
                ApprovalTracker."Loan Source" := LoanSource;
                ApprovalTracker."Global Dimension 1 Code" := Dim1;
                ApprovalTracker."Global Dimension 2 Code" := Dim2;
                if GetResponsibilityCenter(ApprovalTracker) <> '' then
                    ApprovalTracker."Responsibility Center" := GetResponsibilityCenter(ApprovalTracker)
                else
                    ApprovalTracker."Responsibility Center" := UserSetup."Responsibility Center";
                if ApprovalTracker.Name = '' then
                    ApprovalTracker.Name := UpdateTrackerName(ApprovalTracker);

                ApprovalTracker.Modify;
                //Message('Rsp: %1', ApprovalTracker."Responsibility Center");

            end;
            if ApprovalTracker.Status = ApprovalTracker.Status::"Pending" then begin
                Error('Document Already Sent For Approval');
            end;
            if ApprovalTracker.Status = ApprovalTracker.Status::Approved then begin
                Error('Document Already Approved');
            end;
            if ApprovalTracker.Status = ApprovalTracker.Status::Rejected then begin
                Error('Document Already Rejected');
            end;

            TrackerID := ApprovalTracker."Tracker ID";

        end
        else begin

            UserSetup.Get(UserId);
            ApprovalTracker.Init;
            ApprovalTracker."Tracker ID" := '';
            ApprovalTracker."Table ID" := RecRef.Number;
            ApprovalTracker."Document Type" := ApprovalTracker."Document Type"::" ";
            ApprovalTracker."Custom Document Type" := DocumentType;
            ApprovalTracker."Document No." := DocumentNo;
            ApprovalTracker."Sender ID" := UserId;
            if GetDocumentSender(ApprovalTracker) <> '' then
                ApprovalTracker."Sender ID" := GetDocumentSender(ApprovalTracker);
            ApprovalTracker."Loan Source" := LoanSource;
            ApprovalTracker."Record ID to Approve" := RecRef.RecordId;
            ApprovalTracker."Document Amount" := DocumentAmount;
            ApprovalTracker."Global Dimension 1 Code" := Dim1;
            ApprovalTracker."Global Dimension 2 Code" := Dim2;
            if GetResponsibilityCenter(ApprovalTracker) <> '' then
                ApprovalTracker."Responsibility Center" := GetResponsibilityCenter(ApprovalTracker)
            else
                ApprovalTracker."Responsibility Center" := UserSetup."Responsibility Center";
            ApprovalTracker.Status := ApprovalTracker.Status::Open;
            ApprovalTracker.Name := UpdateTrackerName(ApprovalTracker);

            //Message('Rsp2: %1', ApprovalTracker."Responsibility Center");
            ApprovalTracker.Insert(true);

            TrackerID := ApprovalTracker."Tracker ID";
        end;



        if ApprovalTracker.Get(TrackerID) then begin
            TrackerVariant := ApprovalTracker;

            CalwideApprMgt.SendCustomTrackerApprovalRequest(ApprovalTracker);
            PowerEvents.RaiseApprovalRequested(
                Format(ApprovalTracker."Custom Document Type"),
                ApprovalTracker."Document No.",
                '',
                ApprovalTracker.Name,
                ApprovalTracker."Document Amount",
                ApprovalTracker."Sender ID",
                ApprovalTracker."Responsibility Center");

            //if CheckWorkflowEnabled(TrackerVariant) then
            //  OnSendDocForApproval(TrackerVariant);
        end;
    end;

    procedure CancelTracker(var Variant: Variant; DocumentNo: Code[20])
    var
        TrackerID: Code[20];
    begin
        RecRef.GetTable(Variant);

        TrackerID := 'X';
        ApprovalTracker.Reset;
        ApprovalTracker.SetRange("Table ID", RecRef.Number);
        ApprovalTracker.SetRange("Document No.", DocumentNo);
        if ApprovalTracker.FindFirst then begin

            if ApprovalTracker.Status = ApprovalTracker.Status::Open then begin

                CalwideApprMgt.CancelTrackerApprovalRequest(ApprovalTracker, true, true);

                TrackerVariant := ApprovalTracker;
                // if CheckWorkflowEnabled(TrackerVariant) then
                //   OnCancelDocForApproval(TrackerVariant);
            end;
            if ApprovalTracker.Status = ApprovalTracker.Status::"Pending" then begin

                //ApprovalTracker.Status := ApprovalTracker.Status::Open;
                //ApprovalTracker.Modify;

                //if ApprovalTracker."Document Type" = ApprovalTracker."Document Type"::" " then
                //  CalwideApprMgt.CancelTrackerApprovalRequest(ApprovalTracker, true, true)
                //else
                CalwideApprMgt.CancelCustomTrackerApprovalRequest(ApprovalTracker, true, true);

                TrackerVariant := ApprovalTracker;
                //if CheckWorkflowEnabled(TrackerVariant) then
                //  OnCancelDocForApproval(TrackerVariant);

            end;
            if ApprovalTracker.Status = ApprovalTracker.Status::Approved then begin
                Error('Document Already Approved');
            end;
            if ApprovalTracker.Status = ApprovalTracker.Status::Rejected then begin
                Error('Document Already Rejected');
            end;

            TrackerID := ApprovalTracker."Tracker ID";

        end
        else begin
            Error('Tracker not Found');
        end;
    end;


    procedure UpdateTrackerDocument(ApprovalTracker: Record "Approval Tracker"; Status: Enum "Approval Status Enum")
    var
        MemberActivities: Codeunit "Member Activities";
        PowerEvents: Codeunit "UW Power Automate Bus. Events";
        Employee: Record Employee;
        SkyNextOfKinApplication: Record "Sky Next Of Kin Application";
        Str1: Code[20];
        Str2: Code[20];
        pos: Integer;
        ForfeitApproved: Boolean;
    begin


        case ApprovalTracker."Table ID" of

            /*
                        Database::"Purchase Header":
                            begin
                                PurchHeader.Get(ApprovalTracker."Document No.");

                                if Status = Status::Open then
                                    PurchHeader.Validate("Status", PurchHeader."Status"::Open);
                                if Status = Status::Pending then
                                    PurchHeader.Validate("Status", PurchHeader."Status"::"Pending Approval");
                                if Status = Status::Approved then
                                    PurchHeader.Validate("Status", PurchHeader."Status"::Released);
                                if Status = Status::Rejected then
                                    PurchHeader.Validate("Status", PurchHeader."Status"::Open);

                                PurchHeader.Modify;


                            end;
                            */


            Database::"HR Leave Planner Header":
                begin
                    HRLeavePlanner.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        HRLeavePlanner.Validate("Status", HRLeavePlanner."Status"::Open);
                    if Status = Status::Pending then
                        HRLeavePlanner.Validate("Status", HRLeavePlanner."Status"::Pending);
                    if Status = Status::Approved then
                        HRLeavePlanner.Validate("Status", HRLeavePlanner."Status"::Approved);
                    if Status = Status::Rejected then
                        HRLeavePlanner.Validate("Status", HRLeavePlanner."Status"::Rejected);

                    HRLeavePlanner.Modify;

                end;
            Database::"HR Employee Requisitions":
                begin
                    HREmployeeRequi.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        HREmployeeRequi.Validate("Approval Status", HREmployeeRequi."Approval Status"::Open);
                    if Status = Status::Pending then
                        HREmployeeRequi.Validate("Approval Status", HREmployeeRequi."Approval Status"::"Pending Approval");
                    if Status = Status::Approved then
                        HREmployeeRequi.Validate("Approval Status", HREmployeeRequi."Approval Status"::Approved);
                    if Status = Status::Rejected then
                        HREmployeeRequi.Validate("Approval Status", HREmployeeRequi."Approval Status"::Rejected);

                    HREmployeeRequi.Modify;

                end;

            Database::"HR Employee Transfer Header":
                begin
                    HREmployeeTransfer.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        HREmployeeTransfer.Validate(Status, HREmployeeTransfer.Status::New);
                    if Status = Status::Pending then
                        HREmployeeTransfer.Validate(Status, HREmployeeTransfer.Status::"Pending Approval");
                    if Status = Status::Approved then
                        HREmployeeTransfer.Validate(Status, HREmployeeTransfer.Status::Approved);
                    if Status = Status::Rejected then
                        HREmployeeTransfer.Validate(Status, HREmployeeTransfer.Status::Rejected);

                    HREmployeeTransfer.Modify;
                end;


            Database::"Agent Applications":
                begin
                    AgentApp.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        AgentApp.Validate("Approval Status", AgentApp."Approval Status"::Open);
                    if Status = Status::Pending then
                        AgentApp.Validate("Approval Status", AgentApp."Approval Status"::Pending);
                    if Status = Status::Approved then
                        AgentApp.Validate("Approval Status", AgentApp."Approval Status"::Approved);
                    if Status = Status::Rejected then
                        AgentApp.Validate("Approval Status", AgentApp."Approval Status"::Rejected);

                    AgentApp.Modify;

                end;

            Database::"Gen. Journal Batch":

                begin

                    pos := StrPos(ApprovalTracker."Document No.", '|');
                    if pos > 5 then begin
                        Str1 := CopyStr(ApprovalTracker."Document No.", 1, pos - 1);
                        Str2 := CopyStr(ApprovalTracker."Document No.", pos + 1, StrLen(ApprovalTracker."Document No."));

                        //'GENERAL|DEFAULT'

                        JournalBatch.Get(str1, str2);

                        if Status = Status::Open then
                            JournalBatch.Validate("Status", JournalBatch."Status"::Open);
                        if Status = Status::Pending then
                            JournalBatch.Validate("Status", JournalBatch."Status"::Pending);
                        if Status = Status::Approved then
                            JournalBatch.Validate("Status", JournalBatch."Status"::Approved);
                        if Status = Status::Rejected then
                            JournalBatch.Validate("Status", JournalBatch."Status"::Rejected);

                        JournalBatch.Modify;
                    end
                    else
                        Error('Invalid Batch');

                end;

            Database::"Sacco Journal Header":
                begin
                    SaccoJournal.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        SaccoJournal.Validate("Status", SaccoJournal."Status"::Open);
                    if Status = Status::Pending then
                        SaccoJournal.Validate("Status", SaccoJournal."Status"::Pending);
                    if Status = Status::Approved then
                        SaccoJournal.Validate("Status", SaccoJournal."Status"::Approved);
                    if Status = Status::Rejected then
                        SaccoJournal.Validate("Status", SaccoJournal."Status"::Rejected);

                    SaccoJournal.Modify;

                end;
            Database::"IBT Header":
                begin
                    IBTHeader.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        IBTHeader.Validate("Status", IBTHeader."Status"::Open);
                    if Status = Status::Pending then
                        IBTHeader.Validate("Status", IBTHeader."Status"::Pending);
                    if Status = Status::Approved then
                        IBTHeader.Validate("Status", IBTHeader."Status"::Approved);
                    if Status = Status::Rejected then
                        IBTHeader.Validate("Status", IBTHeader."Status"::Rejected);

                    IBTHeader.Modify;

                end;

            Database::"Member Registration":
                begin
                    MemberApplication.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        MemberApplication.Validate("Status", MemberApplication."Status"::Open);
                    if Status = Status::Pending then
                        MemberApplication.Validate("Status", MemberApplication."Status"::Pending);
                    if Status = Status::Approved then
                        MemberApplication.Validate("Status", MemberApplication."Status"::Approved);
                    if Status = Status::Rejected then
                        MemberApplication.Validate("Status", MemberApplication."Status"::Rejected);

                    MemberApplication.Modify;

                    /* if MemberApplication.Status = MemberApplication.Status::Approved then
                        MemberActivities.CreateMember(MemberApplication); */

                end;


            Database::"Member Accounts Application":
                begin
                    SavingsApp.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        SavingsApp.Validate(Status, SavingsApp.Status::Open);
                    if Status = Status::Pending then
                        SavingsApp.Validate(Status, SavingsApp.Status::Pending);
                    if Status = Status::Approved then
                        SavingsApp.Validate(Status, SavingsApp.Status::Approved);
                    if Status = Status::Rejected then
                        SavingsApp.Validate(Status, SavingsApp.Status::Rejected);

                    SavingsApp.Modify;
                end;

            Database::"Sky Next Of Kin Application":
                begin
                    SkyNextOfKinApplication.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        SkyNextOfKinApplication.Validate(Status, SkyNextOfKinApplication.Status::Pending);
                    if Status = Status::Pending then
                        SkyNextOfKinApplication.Validate(Status, SkyNextOfKinApplication.Status::Pending);
                    if Status = Status::Approved then
                        SkyNextOfKinApplication.Validate(Status, SkyNextOfKinApplication.Status::Approved);
                    if Status = Status::Rejected then
                        SkyNextOfKinApplication.Validate(Status, SkyNextOfKinApplication.Status::Rejected);

                    SkyNextOfKinApplication.Modify;
                end;

            Database::"ATM Applications":
                begin
                    ATMApp.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        ATMApp.Validate(Status, ATMApp.Status::Open);
                    if Status = Status::Pending then
                        ATMApp.Validate(Status, ATMApp.Status::"Pending Approval");
                    if Status = Status::Approved then
                        ATMApp.Validate(Status, ATMApp.Status::Approved);
                    if Status = Status::Rejected then
                        ATMApp.Validate(Status, ATMApp.Status::Rejected);

                    ATMApp.Modify;
                end;


            Database::"Fixed Deposit Accounts":
                begin
                    FDR.Get(ApprovalTracker."Document No.");
                    ForfeitApproved := false;

                    if Status = Status::Open then
                        FDR.Validate("Approval Status", FDR."approval status"::Open);
                    if Status = Status::Pending then
                        if FDR."FD Status" <> FDR."fd status"::Forfeited then
                            FDR.Validate("Approval Status", FDR."approval status"::Pending);
                    if Status = Status::Approved then begin
                        FDR.Validate("Approval Status", FDR."approval status"::Approved);
                        if FDR."FD Status" = FDR."fd status"::"Forfeit Pending" then begin
                            FDR.Validate("FD Status", FDR."fd status"::Forfeited);
                            ForfeitApproved := true;
                        end;
                    end;
                    if Status = Status::Rejected then begin
                        FDR.Validate("Approval Status", FDR."approval status"::Rejected);
                        if FDR."FD Status" = FDR."fd status"::"Forfeit Pending" then
                            FDR.Validate("FD Status", FDR."fd status"::Active);
                    end;
                    FDR.Modify;

                    if ForfeitApproved then
                        PowerEvents.RaiseFixedDepositForfeitApproved(
                            FDR."No.",
                            FDR."Member No.",
                            FDR.Name,
                            FDR."FD Amount",
                            Today,
                            FDR."Global Dimension 1 Code");
                end;


            Database::"Defaulter Loan Recovery":
                begin
                    DefaulterLoanRecovery.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        DefaulterLoanRecovery.Validate(Status, DefaulterLoanRecovery.Status::Open);
                    if Status = Status::Pending then
                        DefaulterLoanRecovery.Validate(Status, DefaulterLoanRecovery.Status::Pending);
                    if Status = Status::Approved then
                        DefaulterLoanRecovery.Validate(Status, DefaulterLoanRecovery.Status::Approved);
                    if Status = Status::Rejected then
                        DefaulterLoanRecovery.Validate(Status, DefaulterLoanRecovery.Status::Rejected);

                    DefaulterLoanRecovery.Modify;
                end;

            Database::"Write offs":
                begin
                    WriteOffs.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        WriteOffs.Validate(Status, WriteOffs.Status::Open);
                    if Status = Status::Pending then
                        WriteOffs.Validate(Status, WriteOffs.Status::Pending);
                    if Status = Status::Approved then begin
                        WriteOffs.Validate(Status, WriteOffs.Status::Approved);

                    end;
                    if Status = Status::Rejected then
                        WriteOffs.Validate(Status, WriteOffs.Status::Rejected);

                    WriteOffs.Modify;
                end;

            Database::Loans:
                begin
                    Loans.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        Loans.Validate(Status, Loans.Status::Open);
                    if Status = Status::Pending then begin
                        Loans.Validate(Status, Loans.Status::Pending);
                        MemberActivities.SendAnSmsToTheGuarantor(Loans);
                    end;
                    if Status = Status::Approved then begin
                        if Loans."Require Committee Approval" then begin
                            Loans.Validate(Status, Loans.Status::"Pending Committee");
                            Loans.CreateCommitteeApprovalEntries();
                        end
                        else begin
                            Loans.Validate(Status, Loans.Status::Approved);
                            Loans."Approved By" := UserId;
                            Loans."Approved On" := Format(CurrentDateTime);
                        end;
                    end;
                    if Status = Status::Rejected then begin
                        Loans.Validate(Status, Loans.Status::Rejected);
                        MemberActivities.SendRejectSms(Loans);
                    end;

                    Loans.Modify;
                end;

            Database::"Member Salary Appraisal":
                begin
                    LoanAppraisal.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        LoanAppraisal.Validate(Status, Loans.Status::Open);
                    if Status = Status::Pending then begin
                        LoanAppraisal.Validate(Status, Loans.Status::Pending);
                        MemberActivities.SendAnSmsToTheGuarantor(Loans);
                    end;
                    if Status = Status::Approved then begin

                        LoanAppraisal.Validate(Status, LoanAppraisal.Status::Approved);
                        LoanAppraisal."Approved By" := UserId;
                        LoanAppraisal."Approved On" := Format(CurrentDateTime);


                    end;
                    if Status = Status::Rejected then begin
                        LoanAppraisal.Validate(Status, LoanAppraisal.Status::Rejected);
                        // MemberActivities.SendRejectSms(LoanAppraisal);
                    end;

                    LoanAppraisal.Modify;
                end;

            Database::"Loan Disbursement Header":
                begin
                    LoansBatch.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        LoansBatch.Validate(Status, LoansBatch.Status::Open);
                    if Status = Status::Pending then
                        LoansBatch.Validate(Status, LoansBatch.Status::Pending);
                    if Status = Status::Approved then
                        LoansBatch.Validate(Status, LoansBatch.Status::Approved);
                    if Status = Status::Rejected then
                        LoansBatch.Validate(Status, LoansBatch.Status::Rejected);

                    LoansBatch.Modify;
                end;
            Database::"Partial Loans Disb. Header":
                begin
                    Partial.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        Partial.Validate(Status, Partial.Status::Open);
                    if Status = Status::Pending then
                        Partial.Validate(Status, Partial.Status::Pending);
                    if Status = Status::Approved then
                        Partial.Validate(Status, Partial.Status::Approved);
                    if Status = Status::Rejected then
                        Partial.Validate(Status, Partial.Status::Rejected);

                    Partial.Modify;
                end;

            Database::"Loan Changes":
                begin
                    LoanChanges.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        LoanChanges.Validate(Status, LoanChanges.Status::Open);
                    if Status = Status::Pending then
                        LoanChanges.Validate(Status, LoanChanges.Status::Pending);
                    if Status = Status::Approved then
                        LoanChanges.Validate(Status, LoanChanges.Status::Approved);
                    if Status = Status::Rejected then
                        LoanChanges.Validate(Status, LoanChanges.Status::Rejected);
                    LoanChanges.Modify;
                end;

            Database::"Security Sub.":
                begin
                    SecuritySubstitution.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        SecuritySubstitution.Validate(Status, SecuritySubstitution.Status::Open);
                    if Status = Status::Pending then
                        SecuritySubstitution.Validate(Status, SecuritySubstitution.Status::Pending);
                    if Status = Status::Approved then
                        SecuritySubstitution.Validate(Status, SecuritySubstitution.Status::Approved);
                    if Status = Status::Rejected then
                        SecuritySubstitution.Validate(Status, SecuritySubstitution.Status::Rejected);
                    SecuritySubstitution.Modify;
                end;

            Database::"EFT Transfer":
                begin
                    EFT.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        EFT.Validate(Status, EFT.Status::Open);
                    if Status = Status::Pending then
                        EFT.Validate(Status, EFT.Status::Pending);
                    if Status = Status::Approved then
                        SecuritySubstitution.Validate(Status, EFT.Status::Approved);
                    if Status = Status::Rejected then
                        EFT.Validate(Status, EFT.Status::Rejected);
                    EFT.Modify;
                end;

            Database::"Member Exit":
                begin

                    MemberExit.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        MemberExit.Validate(Status, MemberExit.Status::Open);
                    if Status = Status::Pending then
                        MemberExit.Validate(Status, MemberExit.Status::Pending);
                    if Status = Status::Approved then
                        MemberExit.Validate(Status, MemberExit.Status::Approved);
                    if Status = Status::Rejected then
                        MemberExit.Validate(Status, MemberExit.Status::Rejected);
                    MemberExit.Modify;
                end;

            Database::"Member Exit Notice":
                begin

                    MemberExitNotice.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        MemberExitNotice.Validate(Status, MemberExitNotice.Status::Open);
                    if Status = Status::Pending then
                        MemberExitNotice.Validate(Status, MemberExitNotice.Status::Pending);
                    if Status = Status::Approved then
                        MemberExitNotice.Validate(Status, MemberExitNotice.Status::Approved);
                    if Status = Status::Rejected then
                        MemberExitNotice.Validate(Status, MemberExitNotice.Status::Rejected);

                    MemberExitNotice.Modify;
                end;

            Database::"Member Changes":
                begin

                    MemberChanges.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        MemberChanges.Validate("Approval Status", MemberChanges."approval status"::Open);
                    if Status = Status::Pending then
                        MemberChanges.Validate("Approval Status", MemberChanges."approval status"::Pending);
                    if Status = Status::Approved then
                        MemberChanges.Validate("Approval Status", MemberChanges."approval status"::Approved);
                    if Status = Status::Rejected then
                        MemberChanges.Validate("Approval Status", MemberChanges."approval status"::Rejected);
                    MemberChanges.Modify;
                end;

            Database::"Standing Order Header":
                begin

                    STO.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        STO.Validate(Status, STO.Status::Open);
                    if Status = Status::Pending then
                        STO.Validate(Status, STO.Status::Pending);
                    if Status = Status::Approved then
                        STO.Validate(Status, STO.Status::Approved);
                    if Status = Status::Rejected then
                        STO.Validate(Status, STO.Status::Rejected);
                    STO.Modify;
                end;

            Database::"Cheque Book Application":
                begin

                    ChequeBookApplication.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        ChequeBookApplication.Validate(Status, ChequeBookApplication.Status::Open);
                    if Status = Status::Pending then
                        ChequeBookApplication.Validate(Status, ChequeBookApplication.Status::"Pending Approval");
                    if Status = Status::Approved then
                        ChequeBookApplication.Validate(Status, ChequeBookApplication.Status::Approved);
                    if Status = Status::Rejected then
                        ChequeBookApplication.Validate(Status, ChequeBookApplication.Status::Rejected);
                    ChequeBookApplication.Modify;
                end;

            Database::"Teller Transaction":
                begin

                    TellerTransaction.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        TellerTransaction.Validate(Status, TellerTransaction.Status::Open);
                    if Status = Status::Pending then
                        TellerTransaction.Validate(Status, TellerTransaction.Status::"Pending Approval");
                    if Status = Status::Approved then
                        TellerTransaction.Validate(Status, TellerTransaction.Status::Approved);
                    if Status = Status::Rejected then
                        TellerTransaction.Validate(Status, TellerTransaction.Status::Rejected);
                    TellerTransaction.Modify;
                end;

            Database::"Treasury/Teller Transactions":
                begin

                    Treasury.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        Treasury.Validate(Status, Treasury.Status::Open);
                    if Status = Status::Pending then
                        Treasury.Validate(Status, Treasury.Status::Pending);
                    if Status = Status::Approved then
                        Treasury.Validate(Status, Treasury.Status::Approved);
                    if Status = Status::Rejected then
                        Treasury.Validate(Status, Treasury.Status::Rejected);
                    Treasury.Modify;
                end;

            Database::"Micro Credit Transactions":
                begin

                    MicroCreditTransactions.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        MicroCreditTransactions.Validate(Status, MicroCreditTransactions.Status::Open);
                    if Status = Status::Pending then
                        MicroCreditTransactions.Validate(Status, MicroCreditTransactions.Status::Pending);
                    if Status = Status::Approved then
                        MicroCreditTransactions.Validate(Status, MicroCreditTransactions.Status::Approved);
                    if Status = Status::Rejected then
                        MicroCreditTransactions.Validate(Status, MicroCreditTransactions.Status::Rejected);
                    MicroCreditTransactions.Modify;
                end;

            Database::"Account Transfers":
                begin

                    InterAccountTransfers.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        InterAccountTransfers.Validate(Status, InterAccountTransfers.Status::Open);
                    if Status = Status::Pending then
                        InterAccountTransfers.Validate(Status, InterAccountTransfers.Status::"Pending Approval");
                    if Status = Status::Approved then
                        InterAccountTransfers.Validate(Status, InterAccountTransfers.Status::Approved);
                    if Status = Status::Rejected then
                        InterAccountTransfers.Validate(Status, InterAccountTransfers.Status::Rejected);
                    InterAccountTransfers.Modify;
                end;

            Database::"Purchase Header":
                begin
                    PurchaseHeader.Reset();
                    PurchaseHeader.SetRange("No.", ApprovalTracker."Document No.");
                    if PurchaseHeader.FindFirst() then begin


                        if Status = Status::Open then
                            PurchaseHeader.Validate(Status, PurchaseHeader.Status::Open);
                        if Status = Status::Pending then
                            PurchaseHeader.Validate(Status, PurchaseHeader.Status::"Pending Approval");
                        if Status = Status::Approved then
                            PurchaseHeader.Validate(Status, PurchaseHeader.Status::Released);
                        if Status = Status::Rejected then
                            PurchaseHeader.Validate(Status, PurchaseHeader.Status::Open);
                        PurchaseHeader.Modify;

                    end
                    else
                        Error('Document No. Not Found');
                end;

            Database::"Payment Header":
                begin

                    PaymentHeader.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        PaymentHeader.Validate(Status, PaymentHeader.Status::Open);
                    if Status = Status::Pending then
                        PaymentHeader.Validate(Status, PaymentHeader.Status::Pending);
                    if Status = Status::Approved then
                        PaymentHeader.Validate(Status, PaymentHeader.Status::Approved);
                    if Status = Status::Rejected then
                        PaymentHeader.Validate(Status, PaymentHeader.Status::Rejected);
                    PaymentHeader.Modify;
                end;

            Database::"HR Training App Header":
                begin

                    HTrainingHeader.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        HTrainingHeader.Validate(Status, HTrainingHeader.Status::New);
                    if Status = Status::Pending then
                        HTrainingHeader.Validate(Status, HTrainingHeader.Status::"Pending Approval");
                    if Status = Status::Approved then
                        HTrainingHeader.Validate(Status, HTrainingHeader.Status::Approved);
                    if Status = Status::Rejected then
                        HTrainingHeader.Validate(Status, HTrainingHeader.Status::Rejected);
                    HTrainingHeader.Modify;
                end;

            Database::"HR Training Needs":
                begin

                    HRTrainingNeed.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        HRTrainingNeed.Validate(Status, HRTrainingNeed.Status::New);
                    if Status = Status::Pending then
                        HRTrainingNeed.Validate(Status, HRTrainingNeed.Status::"Pending Approval");
                    if Status = Status::Approved then
                        HRTrainingNeed.Validate(Status, HRTrainingNeed.Status::Approved);
                    if Status = Status::Rejected then
                        HRTrainingNeed.Validate(Status, HRTrainingNeed.Status::Rejected);
                    HRTrainingNeed.Modify;
                end;

            Database::"Loan Collateral Register":
                begin

                    LoanCollateralRegister.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        LoanCollateralRegister.Validate(Status, LoanCollateralRegister.Status::Open);
                    if Status = Status::Pending then
                        LoanCollateralRegister.Validate(Status, LoanCollateralRegister.Status::Pending);
                    if Status = Status::Approved then
                        LoanCollateralRegister.Validate(Status, LoanCollateralRegister.Status::Approved);
                    if Status = Status::Rejected then
                        LoanCollateralRegister.Validate(Status, LoanCollateralRegister.Status::Rejected);
                    LoanCollateralRegister.Modify;
                end;


            Database::"Collateral Collection":
                begin

                    CollateralCollection.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        CollateralCollection.Validate(Status, CollateralCollection.Status::Open);
                    if Status = Status::Pending then
                        CollateralCollection.Validate(Status, CollateralCollection.Status::Pending);
                    if Status = Status::Approved then
                        CollateralCollection.Validate(Status, CollateralCollection.Status::Approved);
                    if Status = Status::Rejected then
                        CollateralCollection.Validate(Status, CollateralCollection.Status::Rejected);
                    CollateralCollection.Modify;
                end;
            Database::"HR Transport Application":
                begin

                    HRTransportReq.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        HRTransportReq.Validate(Status, HRTransportReq.Status::New);
                    if Status = Status::Pending then
                        HRTransportReq.Validate(Status, HRTransportReq.Status::"Pending Approval");
                    if Status = Status::Approved then
                        HRTransportReq.Validate(Status, HRTransportReq.Status::Approved);
                    if Status = Status::Rejected then
                        HRTransportReq.Validate(Status, HRTransportReq.Status::Rejected);
                    HRTransportReq.Modify;
                end;

            Database::"Monthly Checkoff Header":
                begin

                    MonthlyCheckoffHeader.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        MonthlyCheckoffHeader.Validate(Status, MonthlyCheckoffHeader.Status::Open);
                    if Status = Status::Pending then
                        MonthlyCheckoffHeader.Validate(Status, MonthlyCheckoffHeader.Status::Pending);
                    if Status = Status::Approved then
                        MonthlyCheckoffHeader.Validate(Status, MonthlyCheckoffHeader.Status::Approved);
                    if Status = Status::Rejected then
                        MonthlyCheckoffHeader.Validate(Status, MonthlyCheckoffHeader.Status::Rejected);
                    MonthlyCheckoffHeader.Modify;
                end;

            Database::"Bankers Cheque Application":
                begin

                    BankersChequeApplication.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        BankersChequeApplication.Validate(Status, BankersChequeApplication.Status::Open);
                    if Status = Status::Pending then
                        BankersChequeApplication.Validate(Status, BankersChequeApplication.Status::"Pending Approval");
                    if Status = Status::Approved then
                        BankersChequeApplication.Validate(Status, BankersChequeApplication.Status::Approved);
                    if Status = Status::Rejected then
                        BankersChequeApplication.Validate(Status, BankersChequeApplication.Status::Rejected);
                    BankersChequeApplication.Modify;
                end;

            Database::"Salary Header":
                begin

                    SalaryHeader.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        SalaryHeader.Validate(Status, SalaryHeader.Status::Open);
                    if Status = Status::Pending then
                        SalaryHeader.Validate(Status, SalaryHeader.Status::Pending);
                    if Status = Status::Approved then
                        SalaryHeader.Validate(Status, SalaryHeader.Status::Approved);
                    if Status = Status::Rejected then
                        SalaryHeader.Validate(Status, SalaryHeader.Status::Rejected);
                    SalaryHeader.Modify;
                end;

            Database::"Overdraft Header":
                begin

                    OverdraftHeader.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        OverdraftHeader.Validate(Status, OverdraftHeader.Status::Open);
                    if Status = Status::Pending then
                        OverdraftHeader.Validate(Status, OverdraftHeader.Status::Pending);
                    if Status = Status::Approved then
                        OverdraftHeader.Validate(Status, OverdraftHeader.Status::Approved);
                    if Status = Status::Rejected then
                        OverdraftHeader.Validate(Status, OverdraftHeader.Status::Rejected);
                    OverdraftHeader.Modify;
                end;

            Database::"Imprest Header":
                begin

                    ImprestHeader.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        ImprestHeader.Validate(Status, ImprestHeader.Status::Open);
                    if Status = Status::Pending then
                        ImprestHeader.Validate(Status, ImprestHeader.Status::Pending);
                    if Status = Status::Approved then
                        ImprestHeader.Validate(Status, ImprestHeader.Status::Approved);
                    if Status = Status::Rejected then
                        ImprestHeader.Validate(Status, ImprestHeader.Status::Rejected);
                    ImprestHeader.Modify;
                end;
            Database::"Imprest Requisition":
                begin

                    ImprestRequisition.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        ImprestRequisition.Validate(Status, ImprestRequisition.Status::Open);
                    if Status = Status::Pending then
                        ImprestRequisition.Validate(Status, ImprestRequisition.Status::Pending);
                    if Status = Status::Approved then
                        ImprestRequisition.Validate(Status, ImprestRequisition.Status::Approved);
                    if Status = Status::Rejected then
                        ImprestRequisition.Validate(Status, ImprestRequisition.Status::Rejected);
                    ImprestRequisition.Modify;
                end;

            Database::"Imprest Surrender Header":
                begin

                    ImprestSurrenderHeader.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        ImprestSurrenderHeader.Validate(Status, ImprestSurrenderHeader.Status::Open);
                    if Status = Status::Pending then
                        ImprestSurrenderHeader.Validate(Status, ImprestSurrenderHeader.Status::Pending);
                    if Status = Status::Approved then
                        ImprestSurrenderHeader.Validate(Status, ImprestSurrenderHeader.Status::Approved);
                    if Status = Status::Rejected then
                        ImprestSurrenderHeader.Validate(Status, ImprestSurrenderHeader.Status::Rejected);
                    ImprestSurrenderHeader.Modify;
                end;

            Database::"MBanking Applications":
                begin

                    MBankingApplications.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        MBankingApplications.Validate(Status, MBankingApplications.Status::Open);
                    if Status = Status::Pending then
                        MBankingApplications.Validate(Status, MBankingApplications.Status::Pending);
                    if Status = Status::Approved then begin
                        MBankingApplications.Validate(Status, MBankingApplications.Status::Approved);
                        //CreateMBanking();
                    end;
                    if Status = Status::Rejected then
                        MBankingApplications.Validate(Status, MBankingApplications.Status::Rejected);
                    MBankingApplications.Modify;

                end;

            Database::"HR Leave Application.":
                begin

                    HRLeaveApplication.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        HRLeaveApplication.Validate(Status, HRLeaveApplication.Status::New);
                    if Status = Status::Pending then
                        HRLeaveApplication.Validate(Status, HRLeaveApplication.Status::"Pending Approval");
                    if Status = Status::Approved then
                        HRLeaveApplication.Validate(Status, HRLeaveApplication.Status::Approved);
                    if Status = Status::Rejected then
                        HRLeaveApplication.Validate(Status, HRLeaveApplication.Status::Rejected);
                    HRLeaveApplication.Modify;

                    if HRLeaveApplication.Status = HRLeaveApplication.Status::Approved then begin
                        HRLeaveApplication.CreateLeaveLedgerEntries();
                        HRLeaveApplication.NotifyApplicantSupervisor();
                    end;

                end;

            Database::"HR Overtime Header":
                begin

                    HROvertimeHdr.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        HROvertimeHdr.Validate(Status, HROvertimeHdr.Status::Open);
                    if Status = Status::Pending then
                        HROvertimeHdr.Validate(Status, HROvertimeHdr.Status::Pending);
                    if Status = Status::Approved then
                        HROvertimeHdr.Validate(Status, HROvertimeHdr.Status::Approved);
                    if Status = Status::Rejected then
                        HROvertimeHdr.Validate(Status, HROvertimeHdr.Status::Rejected);
                    HROvertimeHdr.Modify;
                    Commit();
                    //




                    if HROvertimeHdr.Status = HROvertimeHdr.status::Approved then begin
                        if HROvertimeHdr."Convert To?" = HROvertimeHdr."Convert To?"::"Convert to Pay" then begin
                            Employee.reset;
                            Employee.SetRange("No.", HROvertimeHdr."Staff No.");
                            if Employee.FindFirst() then
                                Report.Run(Report::"Convert Overtime To Payroll", false, false, Employee);

                        end;
                    end;


                end;
            Database::"PR Salary Advance":
                begin

                    PRSalaryAdv.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        PRSalaryAdv.Validate(Status, PRSalaryAdv.Status::Open);
                    if Status = Status::Pending then
                        PRSalaryAdv.Validate(Status, PRSalaryAdv.Status::Pending);
                    if Status = Status::Approved then
                        PRSalaryAdv.Validate(Status, PRSalaryAdv.Status::Approved);
                    if Status = Status::Rejected then
                        PRSalaryAdv.Validate(Status, PRSalaryAdv.Status::Rejected);
                    PRSalaryAdv.Modify;
                end;

            Database::"BBF Entitlement Header":
                begin


                    BBFHdr.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        BBFHdr.Validate(Status, BBFHdr.Status::Open);
                    if Status = Status::Pending then
                        BBFHdr.Validate(Status, BBFHdr.Status::Pending);
                    if Status = Status::Approved then
                        BBFHdr.Validate(Status, BBFHdr.Status::Approved);
                    if Status = Status::Rejected then
                        BBFHdr.Validate(Status, BBFHdr.Status::Rejected);
                    BBFHdr.Modify;
                end;

            Database::"Receipt Header":
                begin

                    RHeader.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        RHeader.Validate(Status, RHeader.Status::Open);
                    if Status = Status::Pending then
                        RHeader.Validate(Status, RHeader.Status::Pending);
                    if Status = Status::Approved then
                        RHeader.Validate(Status, RHeader.Status::Approved);
                    if Status = Status::Rejected then
                        RHeader.Validate(Status, RHeader.Status::Rejected);
                    RHeader.Modify;
                end;

            Database::"Reversal Header":
                begin

                    RevHeader.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        RevHeader.Validate(Status, RevHeader.Status::Open);
                    if Status = Status::Pending then
                        RevHeader.Validate(Status, RevHeader.Status::"Pending Approval");
                    if Status = Status::Approved then
                        RevHeader.Validate(Status, RevHeader.Status::Approved);
                    if Status = Status::Rejected then
                        RevHeader.Validate(Status, RevHeader.Status::Cancelled);
                    RevHeader.Modify;
                end;
            Database::"Share Transfer":
                begin

                    ShareTransfer.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        ShareTransfer.Validate(Status, ShareTransfer.Status::Open);
                    if Status = Status::Pending then
                        ShareTransfer.Validate(Status, ShareTransfer.Status::"Pending Approval");
                    if Status = Status::Approved then
                        ShareTransfer.Validate(Status, ShareTransfer.Status::Approved);
                    if Status = Status::Rejected then
                        ShareTransfer.Validate(Status, ShareTransfer.Status::Rejected);
                    ShareTransfer.Modify;
                end;

            Database::"HR Asset Transfer Header":
                begin

                    HRAssetTrans.Get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        RevHeader.Validate(Status, HRAssetTrans.Status::Open);
                    if Status = Status::Pending then
                        RevHeader.Validate(Status, HRAssetTrans.Status::Pending);
                    if Status = Status::Approved then
                        RevHeader.Validate(Status, HRAssetTrans.Status::Approved);
                    if Status = Status::Rejected then
                        RevHeader.Validate(Status, HRAssetTrans.Status::Rejected);
                    HRAssetTrans.Modify;
                end;
            Database::"Collateral Valuation History":
                begin

                    VHistory.SetRange("No.", ApprovalTracker."Document No.");
                    if VHistory.FindFirst() then begin

                        if Status = Status::Open then
                            VHistory.Validate(Status, VHistory.Status::Open);
                        if Status = Status::Pending then
                            VHistory.Validate(Status, VHistory.Status::Pending);
                        if Status = Status::Approved then
                            VHistory.Validate(Status, VHistory.Status::Approved);
                        if Status = Status::Rejected then
                            VHistory.Validate(Status, VHistory.Status::Rejected);
                        VHistory.Modify;
                    end;
                end;
            Database::"Loan Security Change":
                begin

                    SecurityChange.get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        SecurityChange.Validate(Status, SecurityChange.Status::Open);
                    if Status = Status::Pending then
                        SecurityChange.Validate(Status, SecurityChange.Status::Pending);
                    if Status = Status::Approved then
                        SecurityChange.Validate(Status, SecurityChange.Status::Approved);
                    if Status = Status::Rejected then
                        SecurityChange.Validate(Status, SecurityChange.Status::Rejected);
                    SecurityChange.Modify;
                end;
            Database::"Store Requisition Header":
                begin

                    StoreRequsition.get(ApprovalTracker."Document No.");

                    if Status = Status::Open then
                        StoreRequsition.Validate(Status, StoreRequsition.Status::Open);
                    if Status = Status::Pending then
                        StoreRequsition.Validate(Status, StoreRequsition.Status::"Pending Approval");
                    if Status = Status::Approved then
                        StoreRequsition.Validate(Status, StoreRequsition.Status::Released);
                    if Status = Status::Rejected then
                        StoreRequsition.Validate(Status, StoreRequsition.Status::Cancelled);
                    StoreRequsition.Modify;
                end;
        end;

        PowerEvents.RaiseApprovalCompleted(
            Format(ApprovalTracker."Custom Document Type"),
            ApprovalTracker."Document No.",
            '',
            ApprovalTracker.Name,
            ApprovalTracker."Document Amount",
            Format(Status),
            ApprovalTracker."Responsibility Center");
    end;

    procedure GetDocumentSender(ApprovalTracker: Record "Approval Tracker") SenderID: Code[50]
    var
        MemberActivities: Codeunit "Member Activities";
        Employee: Record Employee;

    begin


        case ApprovalTracker."Table ID" of

            Database::"HR Leave Planner Header":
                begin
                    HRLeavePlanner.Get(ApprovalTracker."Document No.");

                end;
            Database::"HR Employee Requisitions":
                begin
                    HREmployeeRequi.Get(ApprovalTracker."Document No.");


                end;


            Database::"Agent Applications":
                begin
                    AgentApp.Get(ApprovalTracker."Document No.");

                end;

            Database::"Sacco Journal Header":
                begin
                    SaccoJournal.Get(ApprovalTracker."Document No.");

                end;
            Database::"IBT Header":
                begin
                    IBTHeader.Get(ApprovalTracker."Document No.");

                end;

            Database::"Member Registration":
                begin
                    MemberApplication.Get(ApprovalTracker."Document No.");
                end;


            Database::"Member Accounts Application":
                begin
                    SavingsApp.Get(ApprovalTracker."Document No.");
                end;

            Database::"ATM Applications":
                begin
                    ATMApp.Get(ApprovalTracker."Document No.");
                end;


            Database::"Fixed Deposit Accounts":
                begin
                    FDR.Get(ApprovalTracker."Document No.");
                end;


            Database::"Defaulter Loan Recovery":
                begin
                    DefaulterLoanRecovery.Get(ApprovalTracker."Document No.");
                end;
            Database::"Write offs":
                begin
                    WriteOffs.Get(ApprovalTracker."Document No.");
                end;

            Database::Loans:
                begin
                    Loans.Get(ApprovalTracker."Document No.");
                end;
            Database::"Member Salary Appraisal":
                begin
                    LoanAppraisal.Get(ApprovalTracker."Document No.");
                end;

            Database::"Loan Disbursement Header":
                begin
                    LoansBatch.Get(ApprovalTracker."Document No.");
                end;
            Database::"Partial Loans Disb. Header":
                begin
                    Partial.Get(ApprovalTracker."Document No.");
                end;

            Database::"Loan Changes":
                begin
                    LoanChanges.Get(ApprovalTracker."Document No.");
                end;

            Database::"Security Sub.":
                begin
                    SecuritySubstitution.Get(ApprovalTracker."Document No.");
                end;

            Database::"EFT Transfer":
                begin
                    EFT.Get(ApprovalTracker."Document No.");
                end;

            Database::"Member Exit":
                begin

                    MemberExit.Get(ApprovalTracker."Document No.");
                end;

            Database::"Member Exit Notice":
                begin

                    MemberExitNotice.Get(ApprovalTracker."Document No.");
                end;

            Database::"Member Changes":
                begin

                    MemberChanges.Get(ApprovalTracker."Document No.");
                end;

            Database::"Standing Order Header":
                begin

                    STO.Get(ApprovalTracker."Document No.");
                end;

            Database::"Cheque Book Application":
                begin

                    ChequeBookApplication.Get(ApprovalTracker."Document No.");
                end;

            Database::"Teller Transaction":
                begin

                    TellerTransaction.Get(ApprovalTracker."Document No.");
                end;

            Database::"Treasury/Teller Transactions":
                begin

                    Treasury.Get(ApprovalTracker."Document No.");
                end;

            Database::"Micro Credit Transactions":
                begin

                    MicroCreditTransactions.Get(ApprovalTracker."Document No.");
                end;

            Database::"Account Transfers":
                begin

                    InterAccountTransfers.Get(ApprovalTracker."Document No.");
                end;

            Database::"Purchase Header":
                begin
                    PurchaseHeader.Reset();
                    PurchaseHeader.SetRange("No.", ApprovalTracker."Document No.");
                    if PurchaseHeader.FindFirst() then begin

                    end
                    else
                        Error('Document No. Not Found');
                end;

            Database::"Payment Header":
                begin

                    PaymentHeader.Get(ApprovalTracker."Document No.");
                end;

            Database::"HR Training App Header":
                begin

                    HTrainingHeader.Get(ApprovalTracker."Document No.");
                end;

            Database::"HR Training Needs":
                begin

                    HRTrainingNeed.Get(ApprovalTracker."Document No.");
                end;

            Database::"Loan Collateral Register":
                begin

                    LoanCollateralRegister.Get(ApprovalTracker."Document No.");
                end;


            Database::"Collateral Collection":
                begin

                    CollateralCollection.Get(ApprovalTracker."Document No.");
                end;
            Database::"HR Transport Application":
                begin

                    HRTransportReq.Get(ApprovalTracker."Document No.");
                end;

            Database::"Monthly Checkoff Header":
                begin

                    MonthlyCheckoffHeader.Get(ApprovalTracker."Document No.");
                end;

            Database::"Bankers Cheque Application":
                begin

                    BankersChequeApplication.Get(ApprovalTracker."Document No.");
                end;

            Database::"Salary Header":
                begin

                    SalaryHeader.Get(ApprovalTracker."Document No.");
                end;

            Database::"Overdraft Header":
                begin

                    OverdraftHeader.Get(ApprovalTracker."Document No.");
                end;

            Database::"Imprest Header":
                begin

                    ImprestHeader.Get(ApprovalTracker."Document No.");
                end;
            Database::"Imprest Requisition":
                begin

                    ImprestRequisition.Get(ApprovalTracker."Document No.");
                end;

            Database::"Imprest Surrender Header":
                begin

                    ImprestSurrenderHeader.Get(ApprovalTracker."Document No.");
                end;

            Database::"MBanking Applications":
                begin

                    MBankingApplications.Get(ApprovalTracker."Document No.");

                end;

            Database::"HR Leave Application.":
                begin

                    HRLeaveApplication.Get(ApprovalTracker."Document No.");
                    if HRLeaveApplication."Portal Application" then
                        exit(HRLeaveApplication."Applicant User ID");

                end;

            Database::"HR Overtime Header":
                begin

                    HROvertimeHdr.Get(ApprovalTracker."Document No.");


                end;
            Database::"PR Salary Advance":
                begin

                    PRSalaryAdv.Get(ApprovalTracker."Document No.");
                end;

            Database::"BBF Entitlement Header":
                begin


                    BBFHdr.Get(ApprovalTracker."Document No.");
                end;

            Database::"Receipt Header":
                begin

                    RHeader.Get(ApprovalTracker."Document No.");
                end;

            Database::"Reversal Header":
                begin

                    RevHeader.Get(ApprovalTracker."Document No.");
                end;
            Database::"Share Transfer":
                begin

                    ShareTransfer.Get(ApprovalTracker."Document No.");
                end;

            Database::"HR Asset Transfer Header":
                begin

                    HRAssetTrans.Get(ApprovalTracker."Document No.");
                end;
            Database::"Collateral Valuation History":
                begin

                    VHistory.SetRange("No.", ApprovalTracker."Document No.");
                end;
            Database::"Loan Security Change":
                begin

                    SecurityChange.get(ApprovalTracker."Document No.");
                end;
            Database::"Store Requisition Header":
                begin

                    StoreRequsition.get(ApprovalTracker."Document No.");
                end;
        end;
    end;

    local procedure GetResponsibilityCenter(var ApprovalTracker: Record "Approval Tracker") RespCenter: Text
    begin
        RespCenter := '';

        case ApprovalTracker."Table ID" of
            Database::"Account Transfers":
                begin
                    InterAccountTransfers.Get(ApprovalTracker."Document No.");
                    RespCenter := InterAccountTransfers."Responsibility Center";
                end;
            Database::"IBT Header":
                begin
                    IBTHeader.Get(ApprovalTracker."Document No.");
                    RespCenter := IBTHeader."Responsibility Center";
                    Message(RespCenter);
                end;
            Database::"Sacco Journal Header":
                begin
                    SaccoJournal.Get(ApprovalTracker."Document No.");
                    RespCenter := SaccoJournal."Responsibility Center";
                end;
            Database::"Standing Order Header":
                begin
                    STO.Get(ApprovalTracker."Document No.");
                    RespCenter := STO."Responsibility Center";
                end;
            Database::"HR Overtime Header":
                begin
                    HROvertimeHdr.Get(ApprovalTracker."Document No.");
                    RespCenter := HROvertimeHdr."Responsibility Center";
                end;
            Database::"PR Salary Advance":
                begin
                    PRSalaryAdv.Get(ApprovalTracker."Document No.");
                    RespCenter := PRSalaryAdv."Responsibility Center";
                end;
            Database::"HR Leave Planner Header":
                begin
                    HRLeavePlannerHdr.Get(ApprovalTracker."Document No.");
                    RespCenter := HRLeavePlannerHdr."Responsibility Center";
                end;
            Database::"HR Employee Requisitions":
                begin
                    HREmployeeRequi.Get(ApprovalTracker."Document No.");
                    RespCenter := HREmployeeRequi."Responsibility Center";
                end;
            Database::"HR Leave Application.":
                begin
                    HRLeaveApplication.Get(ApprovalTracker."Document No.");
                    RespCenter := HRLeaveApplication."Responsibility Center";
                end;
            Database::"BBF Entitlement Header":
                begin
                    BBFHdr.Get(ApprovalTracker."Document No.");
                    RespCenter := BBFHdr."Responsibility Center";
                end;
            Database::"Receipt Header":
                begin
                    RHeader.Get(ApprovalTracker."Document No.");
                    RespCenter := RHeader."Responsibility Center";
                end;
            Database::"Member Exit Notice":
                begin
                    MemberExitNotice.Get(ApprovalTracker."Document No.");
                    RespCenter := MemberExitNotice."Responsibility Center";
                end;
            Database::"Member Changes":
                begin
                    MemberChanges.Get(ApprovalTracker."Document No.");
                    RespCenter := MemberChanges."Responsibility Center";
                end;
            Database::"Teller Transaction":
                begin
                    TellerTransaction.Get(ApprovalTracker."Document No.");
                    RespCenter := TellerTransaction."Responsibility Center";
                end;
            Database::"Member Salary Appraisal":
                begin
                    LoanAppraisal.Get(ApprovalTracker."Document No.");
                    RespCenter := LoanAppraisal."Responsibility Center";
                end;
        end;


        exit(RespCenter);
    end;

    local procedure UpdateTrackerName(var ApprovalTracker: Record "Approval Tracker"): Text
    begin


        case ApprovalTracker."Table ID" of
            Database::"Member Registration":
                begin
                    MemberApplication.Get(ApprovalTracker."Document No.");
                    ApprovalTracker.Name := MemberApplication.Name;
                end;
            Database::"Sacco Journal Header":
                begin
                    SaccoJournal.Get(ApprovalTracker."Document No.");
                    ApprovalTracker.Name := CopyStr(
                        GetJournalApprovalMemberName(SaccoJournal."Custom Journal Template", SaccoJournal."Document No.", SaccoJournal."Document No."),
                        1,
                        MaxStrLen(ApprovalTracker.Name));
                end;
            Database::"Gen. Journal Batch":
                begin
                    ApprovalTracker.Name := CopyStr(
                        GetGeneralJournalBatchApprovalName(ApprovalTracker."Document No."),
                        1,
                        MaxStrLen(ApprovalTracker.Name));
                end;
            Database::"Agent Applications":
                begin

                    AgentApp.Get(ApprovalTracker."Document No.");
                    ApprovalTracker.Name := AgentApp.Name;
                end;

            Database::"IBT Header":
                begin
                    IBTHeader.Get(ApprovalTracker."Document No.");
                    ApprovalTracker.Name := IBTHeader."Paying Account Name";
                end;

            Database::"Member Accounts Application":
                begin
                    SavingsApp.Get(ApprovalTracker."Document No.");
                    SavingsApp.CalcFields(Name);
                    ApprovalTracker.Name := SavingsApp.Name + ':' + SavingsApp."Product Name";
                end;
            Database::"ATM Applications":
                begin
                    ATMApp.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := ATMApp."Account Name";
                end;
            Database::"Share Transfer":
                begin
                    ShareTransfer.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := ShareTransfer.Remarks;
                end;

            Database::"HR Transport Application":
                begin
                    HRTransportReq.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := HRTransportReq.Purpose;
                end;


            Database::"Fixed Deposit Accounts":
                begin
                    FDR.Get(ApprovalTracker."Document No.");
                    FDR.CalcFields(Name);
                    ApprovalTracker.Name := FDR.Name;
                end;


            Database::"Defaulter Loan Recovery":
                begin
                    DefaulterLoanRecovery.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := DefaulterLoanRecovery.Name;
                end;
            Database::"Write offs":
                begin
                    WriteOffs.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := WriteOffs."File Comments";
                end;
            Database::Loans:
                begin
                    Loans.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := Loans."Member Name";
                    ApprovalTracker.Details := Loans."Loan No." + ':' + Loans."Member Name" + ':' + Loans."Loan Product Type Name" + ': Approved Amt' + Format(Loans."Approved Amount");
                end;

            Database::"Member Salary Appraisal":
                begin
                    LoanAppraisal.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := LoanAppraisal.Name;
                    ApprovalTracker.Details := LoanAppraisal."Loan Product Type";
                end;

            Database::"Loan Disbursement Header":
                begin
                    LoansBatch.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := LoansBatch."Posting Remarks";
                end;

            Database::"Loan Changes":
                begin
                    LoanChanges.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := LoanChanges."Member Name"
                end;
            Database::"Loan Security Change":
                begin
                    SecurityChange.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := SecurityChange."Member Name"
                end;

            Database::"Security Sub.":
                begin
                    SecuritySubstitution.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := SecuritySubstitution.Name;
                end;

            Database::"Member Exit":
                begin

                    MemberExit.Get(ApprovalTracker."Document No.");


                    ApprovalTracker.Name := MemberExit."Member Name";
                end;

            Database::"Member Exit Notice":
                begin

                    MemberExitNotice.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := MemberExitNotice.Name;
                end;

            Database::"Member Changes":
                begin

                    MemberChanges.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := MemberChanges.Name;
                end;

            Database::"Standing Order Header":
                begin

                    STO.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := STO.Name;
                end;

            Database::"Cheque Book Application":
                begin

                    ChequeBookApplication.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := ChequeBookApplication.Name;
                end;

            Database::"Teller Transaction":
                begin

                    TellerTransaction.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := TellerTransaction."Account Name";
                end;

            Database::"Treasury/Teller Transactions":
                begin

                    Treasury.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := Format(Treasury."Transaction Type");
                end;

            Database::"Micro Credit Transactions":
                begin

                    MicroCreditTransactions.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := MicroCreditTransactions."Group Name";
                end;

            Database::"Account Transfers":
                begin

                    InterAccountTransfers.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := InterAccountTransfers."Member No";
                    if Members.Get(InterAccountTransfers."Member No") then
                        ApprovalTracker.Name := InterAccountTransfers."Member No" + ' : ' + Members.Name;
                end;

            Database::"Purchase Header":
                begin
                    PurchaseHeader.Reset();
                    PurchaseHeader.SetRange("No.", ApprovalTracker."Document No.");
                    if PurchaseHeader.FindFirst() then begin


                        ApprovalTracker.Name := PurchaseHeader."Buy-from Vendor Name";

                    end;
                end;

            Database::"Payment Header":
                begin

                    PaymentHeader.Get(ApprovalTracker."Document No.");
                    PaymentHeader.CalcFields("Total Payment Amount");

                    ApprovalTracker.Name := PaymentHeader.Name;
                    if ApprovalTracker.Name = '' then begin
                        DLines.Reset();
                        DLines.SetRange("Header No.", ApprovalTracker."Document No.");
                        if DLines.FindFirst() then begin
                            ApprovalTracker.Name := DLines.Description;
                            if members.get(DLines."Member No.") then
                                ApprovalTracker.Name := members.Name + ' ' + DLines.Description;
                        end;
                    end;
                    ApprovalTracker.Details := CopyStr(PaymentHeader.Payee + ': ' + Format(PaymentHeader."Total Payment Amount") + ': ' + PaymentHeader."Payment Narration", 1, 300);
                end;

            Database::"Loan Collateral Register":
                begin

                    LoanCollateralRegister.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := LoanCollateralRegister."Account Name";
                end;

            Database::"Collateral Collection":
                begin

                    CollateralCollection.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := CollateralCollection."Account Name";
                end;

            Database::"Monthly Checkoff Header":
                begin

                    MonthlyCheckoffHeader.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := MonthlyCheckoffHeader."Employer Name";
                end;

            Database::"Bankers Cheque Application":
                begin

                    BankersChequeApplication.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := BankersChequeApplication."No.";
                end;

            Database::"Salary Header":
                begin

                    SalaryHeader.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := SalaryHeader."Account Name";
                end;

            Database::"Overdraft Header":
                begin

                    OverdraftHeader.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := OverdraftHeader."Account Name";
                end;

            Database::"Imprest Header":
                begin

                    ImprestHeader.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := ImprestHeader."No.";
                end;
            Database::"Imprest Requisition":
                begin

                    ImprestRequisition.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := ImprestRequisition."No.";
                end;

            Database::"Imprest Surrender Header":
                begin

                    ImprestSurrenderHeader.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := ImprestSurrenderHeader.No;
                end;

            Database::"MBanking Applications":
                begin

                    MBankingApplications.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := MBankingApplications."Customer Name" + ': ' + MBankingApplications."Customer ID No" + ': ' + MBankingApplications."MPESA Mobile No";

                end;

            Database::"HR Leave Application.":
                begin

                    HRLeaveApplication.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := HRLeaveApplication.Names;

                end;
            Database::"HR Overtime Header":
                begin

                    HROvertimeHdr.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := HROvertimeHdr."Staff Name";

                end;
            Database::"PR Salary Advance":
                begin

                    PRSalaryAdv.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := PRSalaryAdv."Staff Name";

                end;

            Database::"HR Leave Planner Header":
                begin
                    HRLeavePlannerHdr.Get(ApprovalTracker."Document No.");
                    ApprovalTracker.Name := HRLeavePlannerHdr."Employee Name";

                end;

            Database::"BBF Entitlement Header":
                begin

                    BBFHdr.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := BBFHdr."Account Name";

                end;

            Database::"Receipt Header":
                begin

                    RHeader.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := RHeader."No.";

                end;
            Database::"Reversal Header":
                begin

                    RevHeader.Get(ApprovalTracker."Document No.");

                    ApprovalTracker.Name := RevHeader."Reversal No.";

                end;
            Database::"Collateral Valuation History":
                begin

                    VHistory.SetRange("No.", ApprovalTracker."Document No.");
                    if VHistory.FindFirst() then
                        ApprovalTracker.Name := VHistory.TableName;
                end;
            Database::"Partial Loans Disb. Header":
                begin

                    Partial.Get(ApprovalTracker."Document No.");
                    if Members.Get(Partial."Member No.") then
                        ApprovalTracker.Name := Members."Name" + ' ' + Partial.Reason;
                end;

        end;


        exit(ApprovalTracker.Name);
    end;

    local procedure GetGeneralJournalBatchApprovalName(DocumentNo: Code[20]): Text
    var
        TemplateName: Code[10];
        BatchName: Code[10];
        SeparatorPosition: Integer;
    begin
        SeparatorPosition := StrPos(DocumentNo, '|');
        if SeparatorPosition <= 1 then
            exit(DocumentNo);

        TemplateName := CopyStr(DocumentNo, 1, SeparatorPosition - 1);
        BatchName := CopyStr(DocumentNo, SeparatorPosition + 1);

        exit(GetJournalApprovalMemberName(TemplateName, BatchName, DocumentNo));
    end;

    local procedure GetJournalApprovalMemberName(TemplateName: Code[10]; BatchName: Code[10]; FallbackName: Text): Text
    var
        GenJournalLine: Record "Gen. Journal Line";
        FirstMemberNo: Code[20];
        FirstMemberName: Text[100];
        HasOtherMembers: Boolean;
        ResultName: Text;
    begin
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", TemplateName);
        GenJournalLine.SetRange("Journal Batch Name", BatchName);
        GenJournalLine.SetFilter("Member No.", '<>%1', '');

        if GenJournalLine.FindSet() then
            repeat
                if FirstMemberNo = '' then begin
                    FirstMemberNo := GenJournalLine."Member No.";
                    FirstMemberName := FirstMemberNo;
                    if Members.Get(FirstMemberNo) then
                        FirstMemberName := Members.Name;
                end else
                    if FirstMemberNo <> GenJournalLine."Member No." then
                        HasOtherMembers := true;
            until GenJournalLine.Next() = 0;

        if FirstMemberNo = '' then
            exit(FallbackName);

        ResultName := FirstMemberNo + ' : ' + FirstMemberName;
        if HasOtherMembers then
            ResultName := ResultName + ' + others';

        exit(ResultName);
    end;

    var
        SaccoAcivities: Codeunit "Sacco Activities";
        WorkFlowManagement: Codeunit "Workflow Management";
        WorkFlowResponseHandling: Codeunit "Workflow Response Handling";

        OnSendCustomDocApproval: Label 'Approval of a Custom Document is requested';
        RunWorkflowonSendCustomDocForApprovalCode: Label 'RUNWORKFLOWONSENDCUSTOMDOCFORAPPROVAL';
        OnCancelCustomDocApproval: Label 'Approval of a Custom Document is canceled';
        RunWorkflowonCancelCustomDocForApprovalCode: Label 'RUNWORKFLOWONCANCELCUSTOMDOCFORAPPROVAL';
        ApprovalTracker: Record "Approval Tracker";
        RecRef: RecordRef;
        TrackerVariant: Variant;
        status: Enum "Approval Status Enum";
        JournalBatch: Record "Gen. Journal Batch";
        SaccoJournal: Record "Sacco Journal Header";
        AgentApp: Record "Agent Applications";
        IBTHeader: Record "IBT Header";
        MemberApplication: Record "Member Registration";
        Partial: Record "Partial Loans Disb. Header";
        Loans: Record Loans;
        Members: Record Members;
        EFT: Record "EFT Transfer";
        DLines: Record "Document Line";
        LoansBatch: Record "Loan Disbursement Header";
        ShareTransfer: Record "Share Transfer";
        HRTransportReq: Record "HR Transport Application";
        SavingsApp: Record "Member Accounts Application";
        ATMApp: Record "ATM Applications";
        FDR: Record "Fixed Deposit Accounts";
        DefaulterLoanRecovery: Record "Defaulter Loan Recovery";
        LoanChanges: Record "Loan Changes";
        SecuritySubstitution: Record "Security Sub.";
        MemberExit: Record "Member Exit";
        MemberExitNotice: Record "Member Exit Notice";
        MemberChanges: Record "Member Changes";
        STO: Record "Standing Order Header";
        ChequeBookApplication: Record "Cheque Book Application";
        TellerTransaction: Record "Teller Transaction";
        Treasury: Record "Treasury/Teller Transactions";
        MicroCreditTransactions: Record "Micro Credit Transactions";
        InterAccountTransfers: Record "Account Transfers";
        PurchaseHeader: Record "Purchase Header";
        PaymentHeader: Record "Payment Header";
        LoanCollateralRegister: Record "Loan Collateral Register";
        CollateralCollection: Record "Collateral Collection";
        MonthlyCheckoffHeader: Record "Monthly Checkoff Header";
        BankersChequeApplication: Record "Bankers Cheque Application";
        SalaryHeader: Record "Salary Header";
        OverdraftHeader: Record "Overdraft Header";
        ImprestHeader: Record "Imprest Header";
        ImprestRequisition: Record "Imprest Requisition";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        MBankingApplications: Record "MBanking Applications";
        HRLeaveApplication: Record "HR Leave Application.";
        HRLeavePlanner: Record "HR Leave Planner Header";
        HREmployeeRequi: Record "HR Employee Requisitions";
        HREmployeeTransfer: Record "HR Employee Transfer Header";
        MicroCredit: Record "Micro Credit Transactions";
        CalwideApprMgt: Codeunit "Calwide Approval Management";
        PurchHeader: Record "Purchase Header";
        StoreRequsition: Record "Store Requisition Header";
        HROvertimeHdr: Record "HR Overtime Header";
        HRLeavePlannerHdr: Record "HR Leave Planner Header";
        PRSalaryAdv: Record "PR Salary Advance";
        RHeader: Record "Receipt Header";
        BBFHdr: Record "BBF Entitlement Header";
        RevHeader: Record "Reversal Header";
        HRAssetTrans: Record "HR Asset Transfer Header";
        VHistory: Record "Collateral Valuation History";
        HTrainingHeader: Record "HR Training App Header";
        HRTrainingNeed: Record "HR Training Needs";
        SecurityChange: Record "Loan Security Change";

        LoanAppraisal: Record "Member Salary Appraisal";

        UserSetup: Record "User Setup";
        WriteOffs: Record "Write offs";

}
