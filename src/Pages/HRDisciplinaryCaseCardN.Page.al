Page 51077 "HR Disciplinary Case Card N"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Case Status,Show';
    SourceTable = "HR Disciplinary Cases NCA";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(CaseNumber; Rec."Case Number")
                {
                    ApplicationArea = Basic;
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateofComplaint; Rec."Date of Complaint")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccusedEmployee; Rec."Accused Employee")
                {
                    ApplicationArea = Basic;
                }
                field(AccusedEmployeeName; Rec."Accused Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(HeadofDepartment; Rec."Head of Department")
                {
                    ApplicationArea = Basic;
                }
                field(HeadofDepartmentName; Rec."Head of Department Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(TypeComplaint; Rec."Type Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(DescriptionofComplaint; Rec."Description of Complaint")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(SeverityOftheComplain; Rec."Severity Of the Complain")
                {
                    ApplicationArea = Basic;
                }
                field(DateofComplaintwasReported; Rec."Date of Complaint was Reported")
                {
                    ApplicationArea = Basic;
                }
                field(AccussedBy; Rec."Accussed By")
                {
                    ApplicationArea = Basic;
                }
                field(Reporter; Rec.Reporter)
                {
                    ApplicationArea = Basic;
                }
                field(ReporterName; Rec."Reporter Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(NonEmployeeReporter; Rec."Non Employee Reporter")
                {
                    ApplicationArea = Basic;
                }
                field(Witness1; Rec."Witness #1")
                {
                    ApplicationArea = Basic;
                }
                field(Witness1Name; Rec."Witness #1 Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Witness2; Rec."Witness #2")
                {
                    ApplicationArea = Basic;
                }
                field(Witness2Name; Rec."Witness #2  Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateToDiscussCase; Rec."Date To Discuss Case")
                {
                    ApplicationArea = Basic;
                }
                field(BodyHandlingTheComplaint; Rec."Body Handling The Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(BodyHandlingName; Rec."Body Handling Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ModeofLodgingtheComplaint; Rec."Mode of Lodging the Complaint")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(PolicyGuidlinesInEffect; Rec."Policy Guidlines In Effect")
                {
                    ApplicationArea = Basic;
                }
                field(PolicyDescription; Rec."Policy Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RecommendedAction; Rec."Recommended Action")
                {
                    ApplicationArea = Basic;
                    Editable = RecommendedActionEditable;
                }
                field(RecommendedActionDescription; Rec."Recommended Action Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(DisciplinaryStageStatus; Rec."Disciplinary Stage Status")
                {
                    ApplicationArea = Basic;
                }
            }
            group(ActionInformation)
            {
                Caption = 'Action Information';
                field(ActionTaken; Rec."Action Taken")
                {
                    ApplicationArea = Basic;
                }
                field(TakenActionDescription; Rec."Taken Action Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(DisciplinaryRemarks; Rec."Disciplinary Remarks")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    MultiLine = true;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(ReviewFindings; Rec."Review Findings")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(ActionDurationStartDate; Rec."Action Duration Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(ActionDurationEndDate; Rec."Action Duration End  Date")
                {
                    ApplicationArea = Basic;
                }
                field(InterdictEmployee; Rec."Interdict Employee")
                {
                    ApplicationArea = Basic;
                }
            }
            group(AppealInformation)
            {
                Caption = 'Appeal Information';
                field(Appealed; Rec.Appealed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AppealFinding; Rec."Appeal Finding")
                {
                    ApplicationArea = Basic;
                }
                field(AppealDate; Rec."Appeal Date")
                {
                    ApplicationArea = Basic;
                }
                field(AppealDecision; Rec."Appeal Decision")
                {
                    ApplicationArea = Basic;
                }
            }
            group(CourtInformation)
            {
                Caption = 'Court Information';
                field(CourtDecision; Rec."Court Decision")
                {
                    ApplicationArea = Basic;
                }
                field(CourtDecisionDate; Rec."Court Decision Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755038; "HR Disciplinary Cases Factbox")
            {
                Caption = 'HR Disciplinary Cases Factbox';
                SubPageLink = "Case Number" = field("Case Number");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Case Status")
            {
                action("Under Investigation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Under Investigation';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Disciplinary Stage Status", Rec."disciplinary stage status"::Reported);
                        Rec.TestField("Accused Employee");
                        Rec.TestField("Description of Complaint");
                        Rec.TestField("Date of Complaint was Reported");
                        Rec.TestField("Date To Discuss Case");
                        Rec.TestField("Witness #1");

                        if Confirm('Are you sure you want to mark this case as "Under Investigation"?') then begin
                            Rec."Disciplinary Stage Status" := Rec."disciplinary stage status"::"Under Investigation";
                            Rec.Modify;
                            Message('Case Number %1 has been marked as under "Investigation"', Rec."Case Number");
                        end;
                    end;
                }
                action("In Progress")
                {
                    ApplicationArea = Basic;
                    Caption = 'In Progress';
                    Image = CarryOutActionMessage;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        Rec.TestField("Disciplinary Stage Status", Rec."disciplinary stage status"::"Under Investigation");



                        if Confirm('Are you sure you want to mark this case as "In Progress"?') then begin
                            Rec."Disciplinary Stage Status" := Rec."disciplinary stage status"::"In progress";
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "In Progress"', Rec."Case Number");
                        end;
                    end;
                }
                action(Close)
                {
                    ApplicationArea = Basic;
                    Caption = ' Close';
                    Image = Closed;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Recommended Action");
                        Rec.TestField(Comments);
                        if (Rec."Disciplinary Stage Status" <> Rec."disciplinary stage status"::"In progress") and (Rec."Disciplinary Stage Status" <> Rec."disciplinary stage status"::"Under review") then
                            Error('You can only close a case that is in progress or under review');

                        if Confirm('Are you sure you want to mark this case as "Closed"?') then begin
                            Rec."Disciplinary Stage Status" := Rec."disciplinary stage status"::Closed;
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "Closed"', Rec."Case Number");
                        end;
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    /*trigger OnAction()
                    begin
                        DiscCase.Reset;
                        DiscCase.SetRange(DiscCase."Case Number", "Case Number");
                        if DiscCase.Find('-') then
                            Report.Run(Report::"HR Disciplinary Cases", true, true, DiscCase);
                    end;*/
                }
                action(Appeal)
                {
                    ApplicationArea = Basic;
                    Caption = ' Appeal';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        Rec.TestField(Status, Rec.Status::Approved);

                        if Rec.Appealed = true then begin
                            Error('A case can only be Appealed once');
                        end;

                        if Rec."Disciplinary Stage Status" = Rec."disciplinary stage status"::"Under Investigation" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."disciplinary stage status"::"In progress" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."disciplinary stage status"::"Under review" then exit;


                        if Confirm('Are you sure you want to mark this case as "Under Review?"') then begin
                            Rec."Disciplinary Stage Status" := Rec."disciplinary stage status"::"Under review";
                            Rec.Appealed := true;
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "Under Review"', Rec."Case Number");
                        end;
                    end;
                }
                action("Withdraw Case")
                {
                    ApplicationArea = Basic;
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec."Disciplinary Stage Status" := Rec."disciplinary stage status"::Withdrawn;
                        Rec.Modify
                    end;
                }
                action(SentCasetoCourt)
                {
                    ApplicationArea = Basic;
                    Caption = 'Sent Case to Court';
                    //Image = changestatus;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Disciplinary Stage Status", Rec."disciplinary stage status"::Closed);

                        if Rec.Appealed <> true then begin
                            Error('A case can only be sent to  court after one appeal');
                        end;

                        if Rec."Disciplinary Stage Status" = Rec."disciplinary stage status"::"Under Investigation" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."disciplinary stage status"::"In progress" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."disciplinary stage status"::"Under review" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."disciplinary stage status"::"court case" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."disciplinary stage status"::"closed by court" then exit;



                        if Confirm('Are you sure you want to sent this case to court?"') then begin
                            Rec."Disciplinary Stage Status" := Rec."disciplinary stage status"::"court case";
                            Rec.Modify;
                            Message('Case Number %1 has been marked as closed by court', Rec."Case Number");
                        end;
                    end;
                }
                action(CourtClose)
                {
                    ApplicationArea = Basic;
                    Caption = 'Court Close';
                    Image = Completed;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec."Disciplinary Stage Status" := Rec."disciplinary stage status"::"closed by court";
                        Rec.Modify;

                        if Rec."Court Decision" = '' then
                            Error(Text00001);
                        if Rec."Disciplinary Stage Status" = Rec."disciplinary stage status"::"Under Investigation" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."disciplinary stage status"::"In progress" then exit;
                        if Rec."Disciplinary Stage Status" = Rec."disciplinary stage status"::"Under review" then exit;


                        if Confirm(Text00003) then begin

                            Message('Case Number %1 has been marked as closed by court', Rec."Case Number");
                        end;
                    end;
                }
                action("Post to Payroll")
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = false;

                    trigger OnAction()
                    begin

                        /* //MESSAGE('yes');
                    IF Status=Status::Approved THEN BEGIN
                      IF ("Disciplinary Stage Status"="Disciplinary Stage Status"::Closed)
                        OR ("Disciplinary Stage Status"="Disciplinary Stage Status"::"closed by court") THEN
                        BEGIN
                          salCard.RESET;
                          salCard.SETRANGE(salCard."Employee Code", "Accused Employee");
                          IF salCard.FIND('-') THEN BEGIN
                            salCard."Suspend Pay":=TRUE;
                            salCard."Suspension Date":=TODAY;
                            salCard."Suspension Reasons":="Type Complaint";
                            salCard.MODIFY;
                            END;
                        END;
                    END;
                    */

                        if Rec."Interdict Employee" = true then
                            Question := 'Are you sure you want to post this to payroll?';
                        Answer := Dialog.Confirm(Question, false);
                        if Answer = true then begin
                            /*
                            salCard.Reset;
                            salCard.SetRange(salCard."Employee Code", "Accused Employee");
                            if salCard.Find('-') then begin
                                salCard."Basic Pay" := salCard."Basic Pay" / 2;
                                //ERROR(FORMAT(salCard."Basic Pay"));
                                salCard.Modify

                            end*/
                        end

                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin

                        VarVariant := Rec;
                        //if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        //CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        //CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin

                        approvalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        RecommendedActionEditable := true;
        ActionTakenEditable := true;
        DisciplinaryRemarksEditable := true;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        "Document Type": Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Leave Journal","Medical Claims","Activity Approval","Disciplinary Approvals";
        RecommendedActionEditable: Boolean;
        ActionTakenEditable: Boolean;
        DisciplinaryRemarksEditable: Boolean;
        //DiscCase: Record UnknownRecord52018696;
        Text00001: label 'Please specify the decision of the court before case  closure';
        Text00002: label 'A case can only be closed by court if its not in court';
        Text00003: label 'Are you sure you want to mark this case as closed by Court?';
        //salCard: Record UnknownRecord39004030;
        HREmp: Record Employee;
        Answer: Boolean;
        Question: Text[250];
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        ////CustomApprovals: Codeunit UnknownCodeunit39004245;
        VarVariant: Variant;


    procedure UpdateControls()
    begin
        /*
        IF DiscCase.Status=DiscCase.Status::New THEN
        BEGIN
          RecommendedActionEditable:=FALSE;
          ActionTakenEditable:=FALSE;
          DisciplinaryRemarksEditable:=FALSE;
        END;
        
        IF DiscCase.Status=DiscCase.Status::Approved  THEN
        BEGIN
          CurrPage.EDITABLE:=FALSE;
        END;
        
        IF DiscCase.Status=DiscCase.Status::"Pending Approval"  THEN
        BEGIN
          CurrPage.EDITABLE:=FALSE;
        END;
        */

    end;
}

