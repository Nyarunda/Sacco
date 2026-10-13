Page 50844 "HR Jobs Card"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Job,Job Succession,Approval Request';
    SourceTable = "HR Jobs";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(JobTitle; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Importance = Promoted;
                }
                field(PositionReportingto; Rec."Position Reporting to")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(PositionReportingName; Rec."Position Reporting Name")
                {
                    ApplicationArea = Basic;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                }
                field(NoofPosts; Rec."No of Posts")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(OccupiedPositions; Rec."Occupied Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(VacantPositions; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(EmployeeRequisitions; Rec."Employee Requisitions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateCreated; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                }
                field(MarkedforSuccession; Rec."Marked for Succession")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Dimensions)
            {
                Caption = 'Dimensions';

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }


            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Jobs Factbox")
            {
                SubPageLink = "Job Description" = field("Job ID");
            }
            systempart(Control1102755006; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
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
                Caption = 'Approve Job';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin

                        //TestField("Position Reporting to");
                        //TestField("Responsibility Center");
                        Rec.TestField("No of Posts");
                        Rec.TestField("Global Dimension 1 Code");
                        Rec.TestField("Global Dimension 2 Code");


                        Rec.CalcFields("No. of Requirements");
                        if Rec."No. of Requirements" = 0 then Error('Please Specify the Job Requirements');
                        Rec.CalcFields("No. of Responsibilities");

                        if Rec."No. of Responsibilities" = 0 then Error('Please Specify the Job Responsibilities');


                        VarVariant := Rec;
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                        //if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        //CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        //CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category7;
                    Visible = false;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin

                        //approvalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
            group(Job)
            {
                action(JobRequirements)
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Requirements';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines";
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
                action(Occupants)
                {
                    ApplicationArea = Basic;
                    Caption = 'Occupants';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Category5;
                    //RunObject = Page "HR Job Occupants";
                    //RunPageLink = "Job ID" = field("Job ID");
                }
                action(MarkforSuccession)
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark for Succession';
                    Image = Check;
                    Promoted = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Approved then begin
                            Rec."Marked for Succession" := true;
                            Rec.Modify;
                        end;
                    end;
                }
                action(ReopenJobCard)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reopen Job Card';
                    Image = OpenJournal;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        Message('Do you want to open the Document');
                        Rec.Status := Rec.Status::Open;
                        Rec."Date Modified" := Today;
                        Rec."Modified By UserID" := UserId;
                        Rec.Modify;
                    end;
                }
                action("Board Minutes[case 360 Docs]")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = New;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        DMS.Reset;
                        DMS.SetRange(DMS.Key, DMS.Key::"9");
                        if DMS.Find('-') then begin
                            Hyperlink(DMS."url path" + "Job ID");
                        end;
                        */
                    end;
                }

                action(AppraisalPillar)
                {
                    ApplicationArea = Basic;
                    Caption = 'Appraisal Objectives';
                    Image = Planning;
                    Promoted = true;
                    RunObject = page "HR Appraisal Pillar Objectives";
                    RunPageLink = "Job ID" = field("Job ID");
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        UpdateControls;
        ActivateFields;
        //OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        //OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    trigger OnAfterGetRecord()
    begin

        //OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        //OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        //VALIDATE("Vacant Positions");

        ActivateFields;
        SetControls;
    end;

    trigger OnOpenPage()
    begin

        UpdateControls;

        ActivateFields;
        SetControls;
    end;

    var
        HREmployees: Record Employee;
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        HRCodeunit: Codeunit "HR Codeunit.";

        PageEditable: Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
        //CustomApprovals: Codeunit UnknownCodeunit39004245;
        //DMS: Record UnknownRecord39004241;
        DetailsEditable: Boolean;
        ShowWorkflowStatus: Boolean;


    procedure RecordLinkCheck(job: Record "HR Jobs") RecordLnkExist: Boolean
    var
        objRecordLnk: Record "Record Link";
        TableCaption: RecordID;
        objRecord_Link: RecordRef;
    begin
        objRecord_Link.GetTable(job);
        TableCaption := objRecord_Link.RecordId;
        objRecordLnk.Reset;
        objRecordLnk.SetRange(objRecordLnk."Record ID", TableCaption);
        if objRecordLnk.Find('-') then exit(true) else exit(false);
    end;

    local procedure UpdateControls()
    begin
        //CurrPage.EDITABLE:=HRCodeunit.fn_UpdateControls(FORMAT(Status));
    end;

    local procedure ActivateFields()
    begin
    end;

    local procedure ContactOnAfterValidate()
    begin
        ActivateFields;
    end;


    procedure SetControls()
    begin
        if Rec.Status = Rec.Status::Approved then
            CurrPage.Editable := false;
    end;
}

