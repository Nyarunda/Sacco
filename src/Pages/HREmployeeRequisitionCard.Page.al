Page 50868 "HR Employee Requisition Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Requisition,Request Approval';
    SourceTable = "HR Employee Requisitions";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(RequisitionNo; Rec."Requisition No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(RequisitionDate; Rec."Requisition Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field(Requestor; Rec.Requestor)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(JobTitle; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Importance = Promoted;
                }
                field(JobGrade; Rec."Job Grade")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(ReasonForRequest; Rec."Reason For Request")
                {
                    ApplicationArea = Basic;
                }
                field(EmploymentType; Rec."Employment Type")
                {
                    ApplicationArea = Basic;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;
                }
                field(VacantPositions; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(RequiredPositions; Rec."Required Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(RequisitionType; Rec."Requisition Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(ApprovalStatus; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(CompletionStatus; Rec."Completion Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
            group(AdditionalInformation)
            {
                Caption = 'Additional Information';
                field(AnyAdditionalInformation; Rec."Any Additional Information")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(ReasonforRequestOther; Rec."Reason for Request(Other)")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                    ShowMandatory = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755020; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin
                        //TESTFIELD("No of Posts");
                        /*TESTFIELD("Document No.");
                        TESTFIELD(Description);
                        TESTFIELD("Interest Due Date");*/
                        Rec.testfield("Required Positions");
                        if Rec."Approval Status" = Rec."approval status"::Approved then begin
                            Error('You cannot approve an aready approved Requisition');
                        end;

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Requisition No.", 0, Documenttype::"HR Job Requisition", '', Rec."Global Dimension 2 Code", 0);
                    end;

                }

                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin

                        Rec.TestField("Approval Status", Rec."Approval Status"::"Pending Approval");

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."Requisition No.");
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"HR Job Requisition";

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."Requisition No.");
                        ApprovalTracker.SetRange("Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
            }
            group(Requisition)
            {
                Caption = 'Requisition';
                action(Requirements)
                {
                    ApplicationArea = Basic;
                    Caption = 'Requirements';
                    Image = JobListSetup;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines(RO)";
                    RunPageLink = "Job ID" = field("Job ID");
                }
                action(Responsibilities)
                {
                    ApplicationArea = Basic;
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Responsiblities Lines";
                    RunPageLink = "Job ID" = field("Job ID");
                }
                action("Advertise (Internal Staff)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Advertise (Internal Staff)';
                    Image = Salutation;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        HREmailParam: record "HR E-Mail Parameters";
                    begin

                        Rec.TestField("Approval Status", Rec."approval status"::Approved);

                        if Rec."Requisition Type" = Rec."requisition type"::External then Error('Requisition Type must be "Internal" or "Both"');

                        if Confirm(Text0001, false, Rec."Job ID", Rec."Job Description") = false then exit;

                        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                        if HREmp.Find('-') then begin
                            HREmp.TestField(HREmp."Company E-Mail");
                            //Check if SMTP mail setup is done
                            //SMTPMailSetup.Get;

                            //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS

                            HREmailParam.Reset;
                            HREmailParam.SetRange(HREmailParam."Associate With", HREmailParam."associate with"::"Vacancy Advertisements");
                            if HREmailParam.Find('-') then begin
                                HREmailParam.TestField(HREmailParam."Sender Name");
                                HREmailParam.TestField(HREmailParam."Sender Address");
                                HREmailParam.TestField(HREmailParam.Subject);
                                repeat
                                //SMTP.CreateMessage(HREmailParam."Sender Name", HREmailParam."Sender Address", HREmp."Company E-Mail",
                                //HREmailParam.Subject, 'Dear' + ' ' + HREmp."First Name" + '<br>' +
                                //Text0002 + ' ' + "Job Description" + ' ' + 'is open for application to all Internal Staff' + '<br><br>Regards', true);
                                //SMTP.Send();
                                until HREmp.Next = 0;
                                Message('[%1] Employees have been notified about this vacancy', HREmp.Count);
                            end else begin
                                Error('No E-Mail Parameters have been setup for Internal Vacany  notifications');
                            end;

                        end;
                    end;
                }
                action("Close Requisition")
                {
                    ApplicationArea = Basic;
                    Enabled = CloseReq;
                    Image = Close;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        Rec.Closed := true;
                        Rec."Completion Status" := Rec."completion status"::Closed;
                        Rec.Modify;
                    end;
                }
                action(JobInterviewdetails)
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Interview details';
                    Enabled = false;
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HR Job Interview";
                    RunPageLink = "Applicant No" = field("Job ID");
                }
            }
        }
    }

   

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        //ApprovalEntries: Page "Approval Entries";
        HREmpReq: Record "HR Employee Requisitions";
        ////SMTP: Codeunit UnknownCodeunit400;
        HRSetup: Record "HR Setup.";
        CTEXTURL: Text[30];
        HREmp: Record Employee;
        //HREmailParam: Record UnknownRecord39003942;
        ContractDesc: Text[30];
        HRLookupValues: Record "HR Lookup Values";
        DimValue: Record "Dimension Value";
        objEmp: Record Employee;
        Text0001: label 'Do you want to advertise Job Position [ %1  - %2 ] to Internal Staff ?';
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        //SMTPMailSetup: Record "SMTP Mail Setup";
        HRCodeunit: Codeunit "HR Codeunit.";
        Text0002: label 'Job position ';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        ////CustomApprovals: Codeunit UnknownCodeunit39004245;
        CloseReq: Boolean;

    local procedure UpdateControls()
    begin
        if Rec."Approval Status" = Rec."Approval Status"::Approved then
            CurrPage.Editable := false;

        //CurrPage.Editable := HRCodeunit.fn_UpdateControls(Format(Rec."Approval Status"));
    end;
}

