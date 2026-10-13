Page 50124 "HR Leave Application Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals,Approvals,Post leave';
    SourceTable = "HR Leave Application.";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(ApplicationNo; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                    Editable = false;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(No; Rec."Applicant Staff No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'No.';
                    Editable = ApplicantStaffNoEditable;
                    Importance = Promoted;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                    Importance = Promoted;
                }
                field(JobTitle; Rec."Job Tittle")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
                field(ApplicantSupervisor; Rec."Applicant Supervisor")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SupervisorEmail; Rec."Supervisor Email")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                label("**")
                {
                    ApplicationArea = Basic;
                    Caption = '*';
                }
                field(LeaveType; Rec."Leave Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(DaysApplied; Rec."Days Applied")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        //Commented to favour CAPITAl sacco
                        //IF "Days Applied" > dLeft THEN ERROR('Days applied exceeds Leave balance');
                    end;
                }
                field(StartDate; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        //IF "Start Date"<>0D THEN
                        //BEGIN
                        //check for overlap


                        //END;
                    end;
                }
                field(EndDate; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(ReturnDate; Rec."Return Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Leave Purpose"; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                label("***")
                {
                    ApplicationArea = Basic;
                    Caption = '*';
                }
                field(AllocatedDays; Rec."Allocated Days")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EarnedDays; Rec."Earned Days")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ReImbursedDays; Rec."Re-Imbursed Days")
                {
                    ApplicationArea = Basic;
                }
                field(TotalLeaveDays; Rec."Total Leave Days")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(DaysTaken; Rec."Days Taken")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(LeaveBalance; Rec."Leave Balance")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                label("****")
                {
                    ApplicationArea = Basic;
                    Caption = '*';
                }
                field(Reliever; Rec.Reliever)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reliever Code';
                    ShowMandatory = false;
                }
                field(RelieverName; Rec."Reliever Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Request Leave Allowance"; Rec."Request Leave Allowance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                label("*****")
                {
                    ApplicationArea = Basic;
                    Caption = '*';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TimePosted; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
            group(MoreLeaveDetails)
            {
                Caption = 'More Leave Details';
                field(CellPhoneNumber; Rec."Cell Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field(AlternativeCellPhoneNo; Rec."Alternative CellPhone No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmailAddress; Rec."E-mail Address")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field(DetailsofExamination; Rec."Details of Examination")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(DateofExam; Rec."Date of Exam")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(NumberofPreviousAttempts; Rec."Number of Previous Attempts")
                {
                    ApplicationArea = Basic;
                }
            }
            group(LeaveAllowance)
            {
                Caption = 'Leave Allowance';
                visible = Rec."Request Leave Allowance";
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                }
                field("Salary Grade"; Rec."Salary Grade")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Allowance Amount"; Rec."Leave Allowance Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Paid; Rec.Paid)
                {
                    ApplicationArea = Basic;

                }



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
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin

                        UserSetup.Get(UserId);

                        HRSetup.Get;
                        HRSetup.TestField("Leave Administrator");

                        if Rec."Applicant Supervisor" <> UserSetup."User ID" then
                            if UserSetup."User ID" <> HRSetup."Leave Administrator" then
                                Error('You do not have permission to Approve this Leave');


                        if Confirm('Are you sure you want to Approve this Leave') then begin
                            Rec.Validate(Status, Rec.Status::Approved);
                            Rec.Modify;
                        end;
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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin

                        if Confirm('Are you sure you want to Reject this Leave') then begin
                            Rec.Validate(Status, Rec.Status::Rejected);
                            Rec.Modify;
                        end;
                    end;
                }
            }
            group(Reliver)
            {
                Caption = 'Reliver';
                action("Print Application Form")
                {
                    ApplicationArea = Basic;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        HRLeaveApp.Reset;
                        HRLeaveApp.SetRange(HRLeaveApp."Application Code", Rec."Application Code");
                        if HRLeaveApp.FindFirst then
                            Report.Run(50230, true, false, HRLeaveApp);
                    end;
                }
            }

            action("Post Leave")
            {
                ApplicationArea = Basic;
                Image = PostApplication;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::Approved;

                trigger OnAction()
                var
                    NetAmt: Decimal;
                    UserSetup: Record "User Setup";
                begin
                    Rec.TestField(Posted, false);
                    Rec.CreateLeaveLedgerEntries();
                    CurrPage.Close();
                end;
            }

            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Custom Document Type";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin
                        //TESTFIELD(e)
                        //TESTFIELD("Cell Phone Number");
                        //TESTFIELD(Address);
                        Rec.TestField("Start Date");
                        Rec.TestField("Job Tittle");
                        //TESTFIELD("Interest Due Date");}

                        TESTFIELDS;
                        //CheckControls;

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Application Code", 0, Documenttype::Leave, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    enabled = false;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        DocumentType: Enum "Custom Document Type";
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."Application Code");
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Collateral Return",CheckOff,"Bankers Cheque",Salary,Overdraft,Imprest,"Imprest Surrender",Teller,"Mbanking Application",Leave;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocType := Doctype::Leave;


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."Application Code");
                        ApprovalTracker.SetRange("Document Type", DocType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;
                    Enabled = false;

                    trigger OnAction()
                    begin

                        if (Rec.Status <> Rec.Status::New) and (Rec.Status <> Rec.Status::"Pending Approval") then begin

                            if not Confirm('Are you sure you want to re-open document?') then exit;
                            Rec.Status := Rec.Status::New;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Get Employee Details
        UpdateControls();


        //Get leave statistics

        //Approvals
        SetControlAppearance;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        //Get Employee Details
        UpdateControls();


        //Get leave statistics

        //Approvals
        SetControlAppearance;
    end;

    trigger OnOpenPage()
    begin
        //Get Employee Details
        UpdateControls();


        //Get leave statistics

        //Approvals
        SetControlAppearance;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        HRLeaveApp.RESET;
        HRLeaveApp.SETRANGE(HRLeaveApp.Status, HRLeaveApp.Status::New);
        HRLeaveApp.SETRANGE(HRLeaveApp."Applicant User ID", USERID);
        IF HRLeaveApp.FIND('-') THEN BEGIN
            IF HRLeaveApp.COUNT > 0 THEN BEGIN
                ERROR('There are still some untilized Leave Application Documents [ %1 ]. Please utilise them first'
                      , HRLeaveApp."Application Code");
            END;
        END;

    end;


    var
        VarVariant: Variant;
        HREmp: Record Employee;
        EmpJobDesc: Text[50];
        SupervisorName: Text[60];
        ////SMTP: Codeunit UnknownCodeunit400;
        URL: Text[500];
        dAlloc: Decimal;
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Decimal;
        HRSetup: Record "HR Setup.";
        EmpDimension_1: Text[60];
        EmpDimension_2: Text[60];
        HRLeaveApp: Record "HR Leave Application.";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries.";
        EmpName: Text[70];
        ApprovalComments: Page "Approval Comments";
        UserSetup: Record "User Setup";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types.";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        LeaveGjline: Record "HR Leave Journal Line.";
        "LineNo.": Integer;
        sDate: Record Date;
        Customized: Record "HR Leave Calendar Lines.";
        HRJournalBatch: Record "HR Leave Journal Batch.";
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        HRLeaveCal: Record "HR Leave Calendar.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        EarnedToDate: Decimal;
        m: Integer;
        HRDepartments: Record "HR Departments";
        ApplicantStaffNoEditable: Boolean;


    procedure UpdateControls()
    begin
        if Rec.Posted then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;

        ApplicantStaffNoEditable := IsHRUser() and (Rec.Status = Rec.Status::New) and (not Rec.Posted);
    end;

    local procedure IsHRUser(): Boolean
    begin
        if not UserSetup.Get(UserId) then
            exit(false);

        exit(UserSetup."Is HR");
    end;


    procedure TESTFIELDS()
    begin
        Rec.TestField("Leave Type");
        Rec.TestField("Days Applied");
        Rec.TestField("Start Date");
        //TestField(Reliever);
        Rec.TestField("Applicant Supervisor");
        Rec.TestField("Responsibility Center");
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin
        //JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        //HasIncomingDocument := "Incoming Document Entry No." <> 0;
        //SetExtDocNoMandatoryCondition;
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}
