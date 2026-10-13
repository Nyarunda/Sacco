
Table 50234 "HR Leave Application."
{

    DrillDownPageID = "HR Leave Applications List";
    LookupPageID = "HR Leave Applications List";

    fields
    {
        field(1; "Application Code"; Code[20])
        {

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if "Application Code" <> xRec."Application Code" then begin
                    HRSetup.Get;
                    NoSeries.TestManual(HRSetup."Leave Application Nos.");
                    "No series" := '';
                end;
            end;
        }
        field(3; "Leave Type"; Code[30])
        {
            TableRelation = "HR Leave Types.";

            trigger OnValidate()
            begin
                HRLeaveTypes.Reset;
                HRLeaveTypes.SetRange(HRLeaveTypes.Code, "Leave Type");
                if HRLeaveTypes.Find('-') then begin

                    if HRLeaveTypes.Gender <> HRLeaveTypes.Gender::Both then begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", "Applicant Staff No.");
                        if HREmp.Find('-') then begin
                            if HRLeaveTypes."Is Annual Leave" then begin
                                if HRLeaveTypes."Employee Category" <> HREmp."Employee Category" then
                                    Error('You cannot choose Category %1 because you are in Category %2', HRLeaveTypes."Employee Category", HREmp."Employee Category");
                            end;

                            if HRLeaveTypes.Gender = HRLeaveTypes.Gender::Female then
                                if HREmp.Gender <> HREmp.Gender::Female then
                                    Error('This leave type is restricted to the ' + Format(HRLeaveTypes.Gender) + ' gender');

                            if HRLeaveTypes.Gender = HRLeaveTypes.Gender::Male then
                                if HREmp.Gender <> HREmp.Gender::Male then
                                    Error('This leave type is restricted to the ' + Format(HRLeaveTypes.Gender) + ' gender');

                        end;
                    end
                    else begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", "Applicant Staff No.");
                        if HREmp.Find('-') then begin
                            if HRLeaveTypes."Is Annual Leave" then begin
                                if HRLeaveTypes."Employee Category" <> HREmp."Employee Category" then
                                    Error('You cannot choose Category %1 because you are in Category %2', HRLeaveTypes."Employee Category", HREmp."Employee Category");
                            end;

                        end;
                    end;


                end;
                GetLeaveStatistics("Leave Type");
            end;
        }
        field(4; "Days Applied"; Decimal)
        {
            DecimalPlaces = 1 : 1;

            trigger OnValidate()
            var
                PrevLeave: Record "HR Leave Application.";
                Calender: Record "HR Leave Calendar.";
            begin


                TestField("Leave Type");


                if "Days Applied" > "Leave Balance" then
                    Error('Days Applied should not exceed %1', "Leave Balance");

                //Calc. Ret/End Dates
                if ("Days Applied" <> 0) and ("Start Date" <> 0D) then begin
                    "Return Date" := DetermineLeaveReturnDate("Start Date", "Days Applied");
                    "End Date" := DeterminethisLeaveEndDate("Return Date");
                    Modify;
                end;

                //For Saturdays
                Customized.Reset;
                Customized.SetRange(Customized.Date, "Start Date", "End Date");
                if Customized.Find('-') then begin
                    repeat
                    //    IF Customized.Day = 'Saturday' THEN
                    //      "Days Applied"-=0.5;
                    until Customized.Next = 0;
                end;

                if "Days Applied" >= 10 then
                    "Request Leave Allowance" := true;
                if "Days Applied" < 10 then
                    "Request Leave Allowance" := false;

                //check previous leave taken within the period
                Calender.Reset();
                Calender.SetRange("Current Leave Calendar", true);
                if Calender.FindFirst() then begin
                    PrevLeave.Reset();
                    PrevLeave.SetRange("Applicant Staff No.", Rec."Applicant Staff No.");
                    PrevLeave.setfilter("Start Date", '%1..%2', Calender."Start Date", Calender."End Date");
                    PrevLeave.Setfilter("Days Applied", '<=15');
                    PrevLeave.SetRange(Status, Status::Approved);
                    if PrevLeave.FindFirst() then PrevLeave.CalcSums("Days Applied");
                    if PrevLeave."Days Applied" + "Days Applied" >= 15 then
                        "Request Leave Allowance" := true;
                end;



                //check for overlap
                HRLeaveApp.Reset;
                HRLeaveApp.SetRange(HRLeaveApp."Applicant Staff No.", "Applicant Staff No.");
                HRLeaveApp.SetRange(HRLeaveApp.Status, HRLeaveApp.Status::Approved);
                if HRLeaveApp.Find('-') then begin
                    repeat
                    //IF "Start Date"<HRLeaveApp."Return Date" THEN
                    //ERROR('You already an active leave application!');
                    until HRLeaveApp.Next = 0;
                end;


                if "Days Applied" < 1 then
                    Error('Days applied cannot be less than 1')
            end;
        }
        field(5; "Start Date"; Date)
        {

            trigger OnValidate()
            begin


                if "Start Date" = 0D then begin
                    "Return Date" := 0D;
                    "End Date" := 0D;
                end
                else begin
                    if DetermineIfIsNonWorking("Start Date") = true then begin
                        Error('Start date must be a working day');
                    end;
                    Validate("Days Applied");
                end;
            end;
        }
        field(6; "Return Date"; Date)
        {
            Caption = 'Return Date';
            Editable = false;
        }
        field(7; "Application Date"; Date)
        {
        }
        field(12; Status; Option)
        {
            Editable = true;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;

            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    //CreateLeaveLedgerEntries;
                end;
            end;
        }
        field(15; "Applicant Comments"; Text[250])
        {
        }
        field(17; "No series"; Code[30])
        {
        }
        field(18; Gender; Option)
        {
            Editable = false;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(28; Selected; Boolean)
        {
        }
        field(31; "Current Balance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(32; Posted; Boolean)
        {
        }
        field(33; "Posted By"; Text[250])
        {
        }
        field(34; "Date Posted"; Date)
        {
        }
        field(35; "Time Posted"; Time)
        {
        }
        field(36; Reimbursed; Boolean)
        {
        }
        field(37; "Days Reimbursed"; Decimal)
        {
        }
        field(3900; "End Date"; Date)
        {
            Editable = true;
        }
        field(3901; "Total Taken"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(3921; "E-mail Address"; Text[60])
        {
            Editable = false;
            ExtendedDatatype = EMail;
        }
        field(3924; "Entry No"; Integer)
        {
        }
        field(3929; "Start Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(3936; "Cell Phone Number"; Code[20])
        {
            ExtendedDatatype = PhoneNo;
            NotBlank = true;
        }
        field(3937; "Request Leave Allowance"; Boolean)
        {
        }
        field(3939; Picture; Blob)
        {
        }
        field(3940; Names; Text[100])
        {
        }
        field(3942; "Leave Allowance Entittlement"; Boolean)
        {
            Editable = true;
        }
        field(3943; "Leave Allowance Amount"; Decimal)
        {
        }
        field(3945; "Details of Examination"; Text[200])
        {
        }
        field(3947; "Date of Exam"; Date)
        {
        }
        field(3949; Reliever; Code[50])
        {
            TableRelation = Employee where(Status = const(Active));

            trigger OnValidate()
            begin
                if Reliever = "Applicant Staff No." then
                    Error('Employee cannot relieve him/herself');

                if HREmp.Get(Reliever) then begin
                    "Reliever Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                end
                else begin
                    "Reliever Name" := '';
                end;
            end;
        }
        field(3950; "Reliever Name"; Text[100])
        {
        }
        field(3952; Description; Text[30])
        {
        }
        field(3955; "Supervisor Email"; Text[50])
        {
        }
        field(3956; "Number of Previous Attempts"; Text[200])
        {
        }
        field(3958; "Job Tittle"; Text[250])
        {
        }
        field(3959; "Applicant User ID"; Code[50])
        {
        }
        field(3961; "Applicant Staff No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin

                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Applicant Staff No.");
                if HREmp.Find('-') then begin
                    HREmp.TestField(HREmp."Employment Date");

                    Calendar.Reset;
                    Calendar.SetRange("Period Type", Calendar."period type"::Month);
                    Calendar.SetRange("Period Start", HREmp."Employment Date", Today);
                    empMonths := Calendar.Count;


                    //Populate fields
                    "Applicant Staff No." := HREmp."No.";
                    Names := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    //Gender:=HREmp.Gender;
                    "Application Date" := Today;
                    "Job Tittle" := HREmp."Job Description";
                    //HREmp.CalcFields(HREmp.Picture);
                    Grade := HREmp.Grade;
                    "Applicant Supervisor" := HREmp."Supervisor Code";
                    Employee.Reset();
                    Employee.SetRange("User ID", "Applicant Supervisor");
                    if Employee.FindFirst() then
                        "Supervisor Email" := Employee."Company E-Mail";
                    Designation := HREmp."Job Title";


                    //Picture:=HREmp.Picture;
                    //"Responsibility Center":=HREmp."Responsibility Center";
                    //Approver details
                    //GetApplicantSupervisor(USERID);

                end;
                "Leave Type" := '';
            end;
        }
        field(3962; "Applicant Supervisor"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(3969; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate("Applicant Staff No.");
            end;
        }
        field(3970; "Approved days"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Approved days" > "Days Applied" then
                    Error(TEXT001);
            end;
        }
        field(3971; Attachments; Integer)
        {
            Editable = false;
        }
        field(3972; Emergency; Boolean)
        {
            Description = 'This is used to ensure one can apply annual leave which is emergency';
        }
        field(3973; "Approver Comments"; Text[200])
        {
        }
        field(3974; "Employee Name"; Text[100])
        {
        }
        field(3975; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                "Global Dimension 1 Name" := '';
                DimValue.Reset;
                DimValue.SetRange(DimValue.Code, "Global Dimension 1 Code");
                if DimValue.Find('-') then begin
                    "Global Dimension 1 Name" := DimValue.Name;
                end;
            end;
        }
        field(3976; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                "Global Dimension 2 Name" := '';
                DimValue.Reset;
                DimValue.SetRange(DimValue.Code, "Global Dimension 2 Code");
                if DimValue.Find('-') then begin
                    "Global Dimension 2 Name" := DimValue.Name;
                end;
            end;
        }
        field(3977; "Global Dimension 1 Name"; Text[60])
        {
            Editable = false;
        }
        field(3978; "Global Dimension 2 Name"; Text[60])
        {
            Editable = false;
        }
        field(3979; Address; Code[50])
        {
        }
        field(3980; "Alternative CellPhone No."; Integer)
        {
        }
        field(3981; "Leave Code"; Code[20])
        {
        }
        field(3982; Designation; Code[50])
        {
        }
        field(3983; "Allocated Days"; Decimal)
        {
            Editable = true;
        }
        field(3984; "Earned Days"; Decimal)
        {
            Editable = true;
        }
        field(3985; "Re-Imbursed Days"; Decimal)
        {
            Editable = false;
        }
        field(3986; "Total Leave Days"; Decimal)
        {
            Editable = true;
        }
        field(3987; "Days Taken"; Decimal)
        {
            Editable = true;
        }
        field(3988; "Leave Balance"; Decimal)
        {
            Editable = true;
        }
        field(3989; "Salary Grade"; code[50])
        {
            TableRelation = "Salary Grades"."Salary Grade";
            trigger OnValidate()
            begin

                AllocateLeaveAllowance();
            end;
        }
        field(3990; Paid; Boolean)
        {

        }
        field(3991; Grade; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,ME1,MP1,MP2,MP3,MP4,MP5,MP6,MP7';
            OptionMembers = " ",ME1,MP1,MP2,MP3,MP4,MP5,MP6,MP7;


        }
        field(3992; Year; Integer)
        {

        }
        field(3993; "Portal Application"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Application Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Application Code", Names)
        {
        }
    }

    trigger OnDelete()
    begin
        //ERROR('Please edit document instead of deleting');
    end;

    trigger OnInsert()
    begin

        if "Applicant User ID" = '' then
            "Applicant User ID" := UserId;

        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", "Applicant User ID");
        HREmp.SetFilter(HREmp."Employee Type", '<>%1', HREmp."employee type"::Intern);
        if HREmp.Find('-') then begin


            if HREmp.Status <> HREmp.Status::Active then begin

                Error('You cannot apply Leave while inactive');
            end;
            if HREmp."Employee Type" = HREmp."employee type"::Intern then begin
                Error('Applicable to Permanent staff only');
            end;
        end
        else
            Error('User ID not linked to employee card or Staff is not Permanent');

        if "Applicant Staff No." = '' then
            "Applicant Staff No." := HREmp."No."
        else
            if ("Applicant Staff No." <> HREmp."No.") and (not CurrentUserIsHR()) then
                Error('Only HR users can apply leave on behalf of another staff member.');

        //No. Series
        if "Application Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Leave Application Nos.");
            "Application Code" := NoSeries.GetNextNo(HRSetup."Leave Application Nos.", WorkDate(), true);
        end;

        HREmp.Reset;
        HREmp.SetRange(HREmp."No.", "Applicant Staff No.");
        if HREmp.Find('-') then begin
            HREmp.TestField(HREmp."Employment Date");
            HREmp.TestField("Job ID");
            if HREmp.Status <> HREmp.Status::Active then
                Error('You cannot apply Leave for inactive staff %1.', HREmp."No.");
            if HREmp."Employee Type" = HREmp."employee type"::Intern then
                Error('Applicable to Permanent staff only');
            //HREmp.TESTFIELD(Department);
            Calendar.Reset;
            Calendar.SetRange("Period Type", Calendar."period type"::Month);
            Calendar.SetRange("Period Start", HREmp."Employment Date", Today);
            empMonths := Calendar.Count;


            //Populate fields
            "Applicant Staff No." := HREmp."No.";
            Names := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            //Gender := HREmp.Gender;
            "Application Date" := Today;
            if HREmp."User ID" <> '' then
                "Applicant User ID" := HREmp."User ID";
            "Job Tittle" := HREmp."Job Description";
            //HREmp.CalcFields(HREmp.Picture);
            "Applicant Supervisor" := HREmp."Supervisor Code";
            Year := DATE2DMY(TODAY, 3);

            if UserSetup.Get("Applicant User ID") then
                "Responsibility Center" := UserSetup."Responsibility Center";


            //Picture := HREmp.Picture;
            //"Responsibility Center":=HREmp."Responsibility Center";
            //Approver details
            //GetApplicantSupervisor("Applicant Supervisor");

        end else begin
            // ERROR('"Applicant User ID"'+' '+'['+"Applicant User ID"+']'+' has not been assigned to any employee. Please consult the HR officer for assistance')
        end;

        if UserSetup.Get("Applicant User ID") then
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";



        HRLeaveCal.Reset;
        HRLeaveCal.SetRange(HRLeaveCal."Calendar Code", HRLeaveCal."Calendar Code");
        HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
        if HRLeaveCal.Get then begin
            "Leave Code" := HRLeaveCal."Calendar Code";
        end;
    end;

    local procedure CurrentUserIsHR(): Boolean
    var
        CurrentUserSetup: Record "User Setup";
    begin
        if not CurrentUserSetup.Get(UserId) then
            exit(false);

        exit(CurrentUserSetup."Is HR");
    end;


    var
        Hrleavecalender: Record "HR Leave Calendar.";
        UserSetup: Record "User Setup";
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
        Emp: Record Employee;
        HREmp: Record Employee;
        varDaysApplied: Decimal;
        HRLeaveTypes: Record "HR Leave Types.";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        HRJournalLine: Record "HR Leave Journal Line.";
        "LineNo.": Integer;
        ApprovalComments: Record "Approval Comment Line";
        URL: Text[500];
        sDate: Record Date;
        HRLeaveCal: Record "HR Leave Calendar.";
        Customized: Record "HR Leave Calendar Lines.";
        HRJournalBatch: Record "HR Leave Journal Batch.";
        TEXT001: label 'Days Approved cannot be more than applied days';
        HRLeaveEntries: Record "HR Leave Ledger Entries.";
        intEntryNo: Integer;
        Calendar: Record Date;
        empMonths: Integer;
        HRLeaveApp: Record "HR Leave Application.";
        mWeekDay: Integer;
        empGender: Option Female;
        mMinDays: Integer;
        Text002: label 'You cannot apply for leave until your are over [%1] months old in the company';
        Text003: label 'UserID [%1] does not exist in [%2]';
        DimValue: Record "Dimension Value";
        LeaveEMail: Text[100];
        LeaveStatsMgt: Codeunit "HR Leave Statistics Mgt.";
        SourceType: Option "New Member","New Account","Loan Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit","Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued",Bonus,Dividend,Bulk,"Standing Order","Loan Bill Due","POS Deposit","Mini Bonus","Leave Application","Loan Witness";


    procedure DetermineLeaveReturnDate(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    begin
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        repeat
            if DetermineIfIncludesNonWorking("Leave Type") = false then begin
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

        while DetermineIfIsNonWorking(fReturnDate) do
            fReturnDate := CalcDate('1D', fReturnDate);

        exit(fReturnDate);
    end;


    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[35]): Boolean
    begin
        if HRLeaveTypes.Get(fLeaveCode) then begin
            if HRLeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
        end;
    end;


    procedure DetermineIfIsNonWorking(var bcDate: Date) Isnonworking: Boolean
    begin

        Customized.Reset;
        Customized.SetRange(Customized.Date, bcDate);
        if Customized.Find('-') then begin
            if Customized."Non Working" = true then
                exit(true)
            else
                exit(false);
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

    procedure AllocateLeaveAllowance()
    var
        LeaveApplication: Record "HR Leave Application.";
        CurrYear: Integer;
        SalaryGrades: record "Salary Grades";
    begin
        CurrYear := DATE2DMY("Application Date", 3);

        LeaveApplication.RESET;
        LeaveApplication.SETRANGE(Year, CurrYear);
        LeaveApplication.SETRANGE("Applicant Staff No.", Rec."Applicant Staff No.");
        LeaveApplication.SETRANGE(Paid, TRUE);
        IF NOT LeaveApplication.FINDFIRST THEN BEGIN

            SalaryGrades.GET("Salary Grade");
            "Leave Allowance Amount" := SalaryGrades."Leave Allowance";

        END;
    end;


    procedure CreateLeaveLedgerEntries()
    begin

        //GET OPEN LEAVE PERIOD
        HRLeaveCal.Reset;
        HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
        HRLeaveCal.Find('-');

        HRJournalBatch.Reset;
        HRSetup.Get;
        HRSetup.TestField(HRSetup."Default Leave Posting Template");
        HRSetup.TestField(HRSetup."Negative Leave Posting Batch");

        HRJournalBatch.Get(HRSetup."Default Leave Posting Template", HRSetup."Negative Leave Posting Batch");

        //POPULATE JOURNAL LINES
        HRJournalLine.Reset;
        HRJournalLine.SetRange(HRJournalLine."Journal Template Name", HRSetup."Default Leave Posting Template");
        HRJournalLine.SetRange(HRJournalLine."Journal Batch Name", HRSetup."Negative Leave Posting Batch");
        if not HRJournalLine.Find('-') then
            HRJournalLine."Line No." := 1000
        else
            HRJournalLine.DeleteAll;

        HRJournalLine."Line No." := HRJournalLine."Line No." + 1000;

        "LineNo." := HRJournalLine."Line No.";

        HRJournalLine.Init;
        HRJournalLine."Journal Template Name" := HRSetup."Default Leave Posting Template";
        HRJournalLine."Journal Batch Name" := HRSetup."Negative Leave Posting Batch";
        HRJournalLine."Line No." := "LineNo.";
        HRJournalLine."Leave Calendar Code" := HRLeaveCal."Calendar Code";
        HRJournalLine."Document No." := "Application Code";
        HRJournalLine."Staff No." := "Applicant Staff No.";
        HRJournalLine.Validate(HRJournalLine."Staff No.");
        HRJournalLine."Posting Date" := Today;
        HRJournalLine."Leave Entry Type" := HRJournalLine."leave entry type"::Negative;
        HRJournalLine."Leave Approval Date" := Today;
        HRJournalLine.Description := 'Leave Taken [' + "Application Code" + ']';
        HRJournalLine."Leave Type" := "Leave Type";
        HRJournalLine."Leave Period Start Date" := HRLeaveCal."Start Date";
        HRJournalLine."Leave Period End Date" := HRLeaveCal."End Date";
        HRJournalLine."No. of Days" := "Days Applied" * -1;
        HRJournalLine.Insert(true);


        //Mark document as posted
        Posted := true;
        "Posted By" := UserId;
        "Date Posted" := Today;
        "Time Posted" := Time;
        if "Leave Allowance Amount" > 0 then Paid := true;
        Modify;


        //Post Journal
        HRJournalLine.Reset;
        HRJournalLine.SetRange("Journal Template Name", HRSetup."Default Leave Posting Template");
        HRJournalLine.SetRange("Journal Batch Name", HRSetup."Negative Leave Posting Batch");
        if HRJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"HR Leave Jnl.-Post", HRJournalLine);
            //Notify Leave Applicant

            NotifyApplicant();
            NotifyReliever();

            Message('The leave has been posted successfully!');
        end;
    end;

    local procedure ProcessLeaveAllowance(Employee: Record Employee; PayrollCodes: Record "Payroll Codes")
    var
        PayrollPeriods: Record "Payroll Periods";
        PayrollEmployeeTransactions: Record "Payroll Employee Transactions";
        OpenPeriod: Date;
        LeaveAllowanceAmt: Decimal;
        strExtractedFrml: Text;
        Payprocess: Codeunit "Payroll Processing";
        intMonth: Integer;
        IntYear: Integer;
    begin
        if not "Request Leave Allowance" then
            exit;

        // Get open payroll period
        PayrollPeriods.Reset();
        PayrollPeriods.SetRange(Closed, false);
        if not PayrollPeriods.Find('-') then
            Error('No Payroll period found');

        OpenPeriod := PayrollPeriods."Date Opened";

        // Calculate leave allowance amount
        if PayrollCodes."Calculation Type" = PayrollCodes."Calculation Type"::Formula then begin
            strExtractedFrml := Payprocess.fnPureFormula(Employee."No.", intMonth, intYear, PayrollCodes.Formula);
            LeaveAllowanceAmt := Round(Payprocess.fnFormulaResult(strExtractedFrml), 0.01, '>');
        end;

        if LeaveAllowanceAmt <= 0 then
            exit;



        // Find or create transaction
        PayrollEmployeeTransactions.Reset();
        PayrollEmployeeTransactions.SetRange("Employee Code", Employee."No.");
        PayrollEmployeeTransactions.SetRange("Transaction Code", 'E004');
        PayrollEmployeeTransactions.SetRange("Payroll Period", OpenPeriod);

        if PayrollEmployeeTransactions.FindFirst() then begin
            PayrollEmployeeTransactions.Amount := LeaveAllowanceAmt;
            PayrollEmployeeTransactions.Modify();
        end else begin
            PayrollEmployeeTransactions.Init();
            PayrollEmployeeTransactions.EntryNo := 0;
            PayrollEmployeeTransactions."Employee Code" := Employee."No.";
            PayrollEmployeeTransactions."Transaction Code" := 'E004';
            PayrollEmployeeTransactions."Payroll Period" := OpenPeriod;
            PayrollEmployeeTransactions."Period Month" := PayrollPeriods."Period Month";
            PayrollEmployeeTransactions."Period Year" := PayrollPeriods."Period Year";

            PayrollEmployeeTransactions."Transaction Name" := 'Leave Allowance';
            PayrollEmployeeTransactions.Amount := LeaveAllowanceAmt;
            PayrollEmployeeTransactions."Member No." := Employee."Member No";
            PayrollEmployeeTransactions.Insert();
        end;
    end;


    procedure NotifyApplicant()
    var
        MemberActivities: Codeunit "Member Activities";
        SMSSrcEnum: Enum "SMS Source Enum";
        SaccoActivities: Codeunit "Sacco Activities";
        ApplicantMobileNo: Text[30];
        LeaveApprovedSms: Label 'Dear %1, your leave application %2 has been approved from %3 to %4. Return date: %5.';
        Salutation: Label 'Dear <b>%1</b>';
        LeaveApprovedEmail: Label '<p>Your leave application %1 has been approved as below.</p> <table border=1><tr><th>Start Date</th><th>No of Days</th><th>End Date</th><th>Return Date</th></tr><tr><td>%2</td><td>%3</td><td>%4</td><td>%5</td></tr></table><br><hr> Regards';
    begin
        Clear(HREmp);

        if HREmp.Get("Applicant Staff No.") then begin
            ApplicantMobileNo := GetApplicantMobileNo(HREmp);

            // Send SMS
            if ApplicantMobileNo <> '' then
                MemberActivities.SendSms(
                    SMSSrcEnum::"Leave Application",
                    ApplicantMobileNo,
                    StrSubstNo(LeaveApprovedSms, MemberActivities.FirstName(HREmp."First Name"), Rec."Application Code", Rec."Start Date", Rec."End Date", Rec."Return Date"),
                    Rec."Application Code",
                    Rec."Application Code",
                    false,
                    false
                );

            // Send Email
            HRSetup.Get();
            LeaveEMail := HRSetup."Leave Notification Email";
            SaccoActivities.SendHREmail(
                HREmp."Company E-Mail",
                LeaveEMail,
                "Supervisor Email",
                'Leave ' + Rec."Application Code" + ' Approved',
                StrSubstNo(Salutation, MemberActivities.FirstName(HREmp."First Name")),
                StrSubstNo(LeaveApprovedEmail, Rec."Application Code", Rec."Start Date", Rec."Days Applied", Rec."End Date", Rec."Return Date")
            );
        end;
    end;

    local procedure GetApplicantMobileNo(Employee: Record Employee): Text[30]
    var
        Member: Record Members;
    begin
        if Employee."Mobile Phone No." <> '' then
            exit(Employee."Mobile Phone No.");

        Member.Reset();
        Member.SetRange("Payroll/Staff No.", "Applicant Staff No.");
        if Member.FindFirst() then
            exit(CopyStr(Member."Mobile Phone No.", 1, 30));

        exit('');
    end;


    /*
            IF "Cell Phone Number"<>'' THEN BEGIN
              SendSMS.SendSms(SourceType::"Leave Application","Cell Phone Number",
              'Your leave Application No. '+"Application Code"+' of '+FORMAT("Days Applied")+' '+
              'has been Approved',"Application Code",'',FALSE,FALSE);
            END;

B
            LeaveEMail:=HRSetup."Leave Notification Email";
            HREmp.GET("Applicant Staff No.");
            IF HREmp."Company E-Mail"<>'' THEN BEGIN
            SMTP.CreateMessage(
                                LeaveEMail,
                                '',
                                HREmp."Company E-Mail",
                                'Leave Approval Notification',
                                'Dear' + '<br>' + HREmp."First Name"+
                                'Your leave application no.'+"Application Code"+ '  '+'has been fully approved:<br><br>'+
                                '<br>Employee No. ' + "Applicant Staff No." + ' - '+ UPPERCASE(Names) +
                                '<br>Application No - ' + "Application Code"+
                                '<br>Start Date - ' + FORMAT("Start Date") +
                                '<br>End Date - ' + FORMAT("End Date") +
                                '<br>Return Date - ' + FORMAT("Return Date") +
                                '<br>Days Applied - ' + FORMAT("Days Applied")+
                                '<br><br>Kind Regards',
                                TRUE
                              );

                             //SMTP.AddCC("Supervisor Email");
                             //SMTP.AddCC('fdgdgd');
                             //SMTP.AddAttachment('C:\Leave\'+"Application Code"+'.pdf',"Application Code");


            SMTP.TrySend();
            MESSAGE('Leave applicant has been notified successfully');

            END;
            */


    procedure NotifyApplicantSupervisor()
    var
        MemberActivities: Codeunit "Member Activities";
        SMSSrcEnum: Enum "SMS Source Enum";
        SaccoActivities: Codeunit "Sacco Activities";
        TheCc: Text;
        Msg: Text;
        DMsg: Text;
        DDay: Integer;
        StatementNo: Integer;
        Mail: Codeunit Mail;
        Heading: Text[100];
        SalutationTxt: Text[50];
        Receiver: List of [Text];
        RegardsTxt: Text[30];
        CCRecepients: List of [Text];
        BccRecepients: List of [Text];
        LeaveApprovedSms: Label 'Dear <b>%1</b>,<br> <p>Your leave application %2, has been approved.</p>';
        Salutation: Label 'Dear <b>%1</b>';
        LeaveApprovedEmail: Label '<p>%1, has requsted for leave as below.</p><table border=1><tr><th>Start Date</th><th>No of Days</th><th>End Date</th><th>Return Date</th></tr><tr><td>%2</td><td>%3</td><td>%4</td><td>%5</td></tr></table><br><hr> Regards';
    begin

        if HREmp.Get("Applicant Staff No.") then begin
            HRSetup.Get();

            Msg := '';
            DMsg := '';


            Receiver.Add(HREmp."Company E-Mail");
            CCRecepients.Add("Supervisor Email");
            CCRecepients.Add(HRSetup."Leave Notification Email");

            Heading := 'Leave Application -' + Rec.Names;
            SalutationTxt := StrSubstNo(Salutation, MemberActivities.FirstName(HREmp."First Name"));
            Msg := StrSubstNo(LeaveApprovedEmail, "Application Code", "Start Date", "Days Applied", "End Date", "Return Date");


            /*SaccoActivities.SendEmail(HREmp."Company E-Mail", "Supervisor Email", '', 'Leave ' + Rec.Names,
            StrSubstNo(Salutation, MemberActivities.FirstName(HREmp."First Name")),
            StrSubstNo(LeaveApprovedEmail, "Application Code", "Start Date", "Days Applied", "End Date", "Return Date"));*/
            if (StrLen(Format(CCRecepients)) > 4) then
                MemberActivities.SendHREmailCCNotification(Heading, SalutationTxt, Msg, RegardsTxt, Receiver, '', CCRecepients, BCCRecepients);
            Receiver.Add('');
            CCRecepients.Add('');
        end;

    end;

    local procedure GetApplicantSupervisor(EmpUserID: Code[50]) SupervisorID: Code[10]
    var
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        HREmp2: Record Employee;
    begin
        SupervisorID := '';

        UserSetup.Reset;
        if UserSetup.Get(EmpUserID) then begin
            UserSetup.TestField(UserSetup."Approver ID");

            //Get supervisor e-mail
            UserSetup2.Reset;
            if UserSetup2.Get(UserSetup."Approver ID") then begin
                //UserSetup2.TESTFIELD(UserSetup2."E-Mail");
                //"Applicant Supervisor":=UserSetup."Approver ID";
                //"Supervisor Email":=UserSetup2."E-Mail";
            end;

        end else begin
            Error(Text003, EmpUserID, UserSetup.TableCaption);
        end;
    end;


    procedure NotifyReliever()
    var
        SaccoActivities: Codeunit "Sacco Activities";
        HRSetup: Record "HR Setup.";
        MemberActivities: Codeunit "Member Activities";
        RelieverNotice: Label '<p>You are hereby notified that you have been selected as the Leave Reliever for %1 for a period of %2 days from %3 to %4.</p> <p>Please ensure that you understand the responsibilities given to you for that duration</p>';
    begin
        HREmp.Reset();
        HREmp.SetRange("No.", Rec.Reliever);
        if HREmp.FindFirst() then begin
            if HREmp."Company E-Mail" <> '' then begin

                SaccoActivities.SendHREmail(HREmp."Company E-Mail", HRSetup."Leave Notification Email", '', 'Leave Reliever Notice',
                'Dear ' + HREmp."First Name", StrSubstNo(RelieverNotice, MemberActivities.FirstName(Rec.Names), "Days Applied", "Start Date", "End Date"));

            end;
        end;

    end;


    procedure GetLeaveStatistics(LeaveType: Text[50])
    begin
        LeaveStatsMgt.GetLeaveStatistics(
            "Applicant Staff No.",
            LeaveType,
            "Allocated Days",
            "Earned Days",
            "Re-Imbursed Days",
            "Total Leave Days",
            "Total Taken",
            "Leave Balance",
            "Days Taken");
    end;
}
