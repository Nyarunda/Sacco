
Page 50131 "HR Leave Reimbursment List"
{
    ApplicationArea = All;
    CardPageID = "HR Leave Reimbursment Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions,Comments';
    SourceTable = "HR Leave Reimbursement.";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field(ApplicationNo; REc."Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                    Editable = "Application CodeEditable";
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field(ApplicationDate; REc."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = true;
                }
                field(LeaveApplicationNo; REc."Leave Application No")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; REc."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = "Responsibility CenterEditable";
                }
                field(LeaveType; Rec."Leave Type")
                {
                    ApplicationArea = Basic;
                    Editable = "Leave TypeEditable";
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        //GetLeaveStats("Leave Type");
                        //                    CurrPage.UPDATE;
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "HR Leave Factbox")
            {
                SubPageLink = "No." = field("Employee No");
            }
            systempart(Control2; Outlook)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        EmpDept := '';
        //PASS VALUES TO VARIABLES ON THE FORM
        FillVariables;
        //GET LEAVE STATS FOR THIS EMPLOYEE FROM THE EMPLOYEE TABLE
        //GetLeaveStats("Leave Type");
        //TO PREVENT USER FROM SEEING OTHER PEOPLES LEAVE APPLICATIONS
        //SETFILTER("User ID",USERID);

        Updatecontrols;
    end;

    trigger OnInit()
    begin
        NumberofPreviousAttemptsEditab := true;
        "Date of ExamEditable" := true;
        "Details of ExaminationEditable" := true;
        "Cell Phone NumberEditable" := true;
        SupervisorEditable := true;
        RequestLeaveAllowanceEditable := true;
        RelieverEditable := true;
        "Leave Allowance AmountEditable" := true;
        "Start DateEditable" := true;
        "Responsibility CenterEditable" := true;
        "Days AppliedEditable" := true;
        "Leave TypeEditable" := true;
        "Application CodeEditable" := true;
    end;

    var
        HREmp: Record Employee;
        EmpJobDesc: Text[50];
        SupervisorName: Text[60];
        URL: Text[500];
        dAlloc: Decimal;
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Decimal;
        HRSetup: Record "HR Setup.";
        EmpDept: Text[30];
        HRLeaveApp: Record "HR Leave Application.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval";
        ApprovalEntries: Page "Approval Entries";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries.";
        EmpName: Text[70];
        ApprovalComments: Page "Approval Comments";

        "Application CodeEditable": Boolean;

        "Leave TypeEditable": Boolean;

        "Days AppliedEditable": Boolean;

        "Responsibility CenterEditable": Boolean;

        "Start DateEditable": Boolean;

        "Leave Allowance AmountEditable": Boolean;

        RelieverEditable: Boolean;

        RequestLeaveAllowanceEditable: Boolean;

        SupervisorEditable: Boolean;

        "Cell Phone NumberEditable": Boolean;

        "Details of ExaminationEditable": Boolean;

        "Date of ExamEditable": Boolean;

        NumberofPreviousAttemptsEditab: Boolean;
        Text19010232: label 'Leave Statistics';
        Text1: label 'Reliver Details';
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


    procedure FillVariables()
    begin
        //GET THE APPLICANT DETAILS

        HREmp.Reset;
        if HREmp.Get(Rec."Employee No") then begin
            EmpName := HREmp.FullName;
            EmpDept := HREmp.Department;
        end else begin
            EmpDept := '';
        end;

        /*
        //GET THE JOB DESCRIPTION FRON THE HR JOBS TABLE AND PASS IT TO THE VARIABLE
        HRJobs.RESET;
        IF HRJobs.GET("Job Tittle") THEN
        BEGIN
        EmpJobDesc:=HRJobs."Job Description";
        END ELSE BEGIN
        EmpJobDesc:='';
        END;
        */
        //GET THE APPROVER NAMES
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", Rec.Supervisor);
        if HREmp.Find('-') then begin
            SupervisorName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        end else begin
            SupervisorName := '';
        end;

    end;


    procedure TESTFIELDS()
    begin
        REc.TestField("Leave Type");
        REc.TestField("Days Applied");
        REc.TestField("Start Date");
        REc.TestField(Reliever);
        REc.TestField(Supervisor);
    end;


    procedure Updatecontrols()
    begin

        if Rec.Status = Rec.Status::New then begin
            "Application CodeEditable" := true;
            "Leave TypeEditable" := true;
            "Days AppliedEditable" := true;
            "Responsibility CenterEditable" := true;
            "Start DateEditable" := true;
            "Leave Allowance AmountEditable" := true;
            RelieverEditable := true;
            RequestLeaveAllowanceEditable := true;
            SupervisorEditable := true;
            "Cell Phone NumberEditable" := true;
            //CurrForm."E-mail Address".EDITABLE:=TRUE;
            "Details of ExaminationEditable" := true;
            "Date of ExamEditable" := true;
            NumberofPreviousAttemptsEditab := true;
        end else begin
            "Application CodeEditable" := false;
            "Leave TypeEditable" := false;
            "Days AppliedEditable" := false;
            "Responsibility CenterEditable" := false;
            "Start DateEditable" := false;
            "Leave Allowance AmountEditable" := false;
            RelieverEditable := false;
            RequestLeaveAllowanceEditable := false;
            SupervisorEditable := false;
            "Cell Phone NumberEditable" := false;
            //CurrForm."E-mail Address".EDITABLE:=FALSE;
            "Details of ExaminationEditable" := false;
            "Date of ExamEditable" := false;
            NumberofPreviousAttemptsEditab := false;
        end;
    end;


    procedure TestLeaveFamily()
    begin
        /*LeaveFamilyEmployees.SETRANGE(LeaveFamilyEmployees."Employee No","Employee No");
        IF LeaveFamilyEmployees.FINDSET THEN //find the leave family employee is associated with
        REPEAT
          LeaveFamily.SETRANGE(LeaveFamily.Code,LeaveFamilyEmployees.Family);
          LeaveFamily.SETFILTER(LeaveFamily."Max Employees On Leave",'>0');
          IF LeaveFamily.FINDSET THEN //find the status other employees on the same leave family
            BEGIN
              Employees.SETRANGE(Employees."No.",LeaveFamilyEmployees."Employee No");
              Employees.SETRANGE(Employees."Leave Status",Employees."Leave Status"::"0");
              IF Employees.COUNT>LeaveFamily."Max Employees On Leave" THEN
              ERROR('The Maximum number of employees on leave for this family has been exceeded, Contact th HR manager for more information');
            END
        UNTIL LeaveFamilyEmployees.NEXT = 0;
         */

    end;

    /*
    procedure DetermineLeaveReturnDate(var fBeginDate: Date;var fDays: Decimal) fReturnDate: Date
    begin
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        repeat
          if DetermineIfIncludesNonWorking("Leave Type") =false then begin
            fReturnDate := CalcDate('1D', fReturnDate);
            if DetermineIfIsNonWorking(fReturnDate) then
              varDaysApplied := varDaysApplied + 1
            else
              varDaysApplied := varDaysApplied;
            varDaysApplied := varDaysApplied - 1
          end
          else begin
            fReturnDate := CalcDate('1D', fReturnDate);
            varDaysApplied := varDaysApplied - 1;
          end;
        until varDaysApplied = 0;
        exit(fReturnDate);
    end;


    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[10]): Boolean
    begin
        if HRLeaveTypes.Get(fLeaveCode) then begin
        if HRLeaveTypes."Inclusive of Non Working Days" = true then
        exit(true);
        end;
    end;


    procedure DetermineIfIsNonWorking(var bcDate: Date) Isnonworking: Boolean
    begin
        
        HRSetup.Find('-');
        HRSetup.TestField(HRSetup."Base Calendar");
        BaseCalendarChange.SetFilter(BaseCalendarChange."Base Calendar Code",HRSetup."Base Calendar");
        BaseCalendarChange.SetRange(BaseCalendarChange.Date,bcDate);
        
        if BaseCalendarChange.Find('-') then begin
        if BaseCalendarChange.Nonworking = false then
        Error('Start date can only be a Working Day Date');
        exit(true);
        end;
        

    end;


    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    begin
        ReturnDateLoop := true;
        fEndDate := fDate;
        if fEndDate <> 0D then begin
          fEndDate := CalcDate('-1D', fEndDate);
          while (ReturnDateLoop) do begin
          if DetermineIfIsNonWorking(fEndDate) then
            fEndDate := CalcDate('-1D', fEndDate)
           else
            ReturnDateLoop := false;
          end
          end;
        exit(fEndDate);
    end;


    procedure CreateLeaveLedgerEntries()
    begin
        HRSetup.Reset;
        if HRSetup.Find('-') then begin
        
        LeaveGjline.Reset;
        LeaveGjline.SetRange("Journal Template Name",HRSetup."Leave Template");
        LeaveGjline.SetRange("Journal Batch Name",HRSetup."Leave Batch");
        LeaveGjline.DeleteAll;
          //Dave
        //HRSetup.TESTFIELD(HRSetup."Leave Template");
        //HRSetup.TESTFIELD(HRSetup."Leave Batch");
        
        HREmp.Get("Employee No");
        HREmp.TestField(HREmp."Company E-Mail");
        
        //POPULATE JOURNAL LINES
        
        "LineNo.":=10000;
        LeaveGjline.Init;
        LeaveGjline."Journal Template Name":=HRSetup."Leave Template";
        LeaveGjline."Journal Batch Name":=HRSetup."Leave Batch";
        LeaveGjline."Line No.":="LineNo.";
        LeaveGjline."Leave Calendar Code":='2013';
        LeaveGjline."Document No.":="Application Code";
        LeaveGjline."Staff No.":="Employee No";
        LeaveGjline.Validate(LeaveGjline."Staff No.");
        LeaveGjline."Posting Date":=Today;
        LeaveGjline."Leave Entry Type":=LeaveGjline."leave entry type"::Negative;
        LeaveGjline."Leave Approval Date":=Today;
        LeaveGjline.Description:='Leave Taken';
        LeaveGjline."Leave Type":="Leave Type";
        //------------------------------------------------------------
        //HRSetup.RESET;
        //HRSetup.FIND('-');
        //HRSetup.TESTFIELD(HRSetup."Leave Posting Period[FROM]");
        //HRSetup.TESTFIELD(HRSetup."Leave Posting Period[TO]");
        //------------------------------------------------------------
        //LeaveGjline."Leave Period Start Date":=HRSetup."Leave Posting Period[FROM]";
        //LeaveGjline."Leave Period End Date":=HRSetup."Leave Posting Period[TO]";
        //IF LeaveGjline."No. of Days"<>0 THEN
        LeaveGjline.Insert(true);
        
        
        //Post Journal
        LeaveGjline.Reset;
        LeaveGjline.SetRange("Journal Template Name",HRSetup."Leave Template");
        LeaveGjline.SetRange("Journal Batch Name",HRSetup."Leave Batch");
        if LeaveGjline.Find('-') then begin
        Codeunit.Run(Codeunit::Codeunit39005560,LeaveGjline);
        end;
        Status:=Status::"10";
        Modify;
        

        //NotifyApplicant;
        end;

    end;


    procedure NotifyApplicant()
    begin
        HREmp.Get("Employee No");
        HREmp.TestField(HREmp."Company E-Mail");
    

    end;
    */
}

