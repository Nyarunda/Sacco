
Table 50232 "HR Leave Carry Allocation."
{

    fields
    {
        field(1; "Application Code"; Code[20])
        {

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if "Application Code" <> xRec."Application Code" then begin
                    HRSetup.Get;
                    NoSeries.TestManual(HRSetup."Leave Carry Over App Nos.");
                    Description := '';
                end;
            end;
        }
        field(2; "Application Date"; Date)
        {
        }
        field(3; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,HOD Approval,HR Approval,Final Approval,Rejected,Canceled,Approved,On leave,Resumed,Posted';
            OptionMembers = New,"Pending Approval","HOD Approval","HR Approval",MDApproval,Rejected,Canceled,Approved,"On leave",Resumed,Posted;
        }
        field(4; "Applicant Comments"; Text[250])
        {
        }
        field(5; "No series"; Code[30])
        {
        }
        field(6; Selected; Boolean)
        {
        }
        field(8; "Entry No"; Integer)
        {
        }
        field(9; "Start Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(10; Names; Text[100])
        {
        }
        field(11; Description; Text[30])
        {
        }
        field(12; "Job Tittle"; Text[50])
        {
        }
        field(13; "User ID"; Code[50])
        {
        }
        field(14; "Employee No"; Code[20])
        {

            trigger OnValidate()
            begin
                HREmp.Get("Employee No");
                Names := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name"
            end;
        }
        field(15; "Responsibility Center"; Code[20])
        {
            //TableRelation = Table39005523.Field1;
        }
        field(16; "Approved days"; Integer)
        {
        }
        field(17; Attachments; Integer)
        {
            //CalcFormula = count(Table39005630 where (Field1=field("Application Code")));
            Editable = false;
            //FieldClass = FlowField;
        }
        field(18; "Approval Status"; Option)
        {
            Editable = false;
            OptionMembers = Open,"Pending Approval",Approved;
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
    }

    trigger OnInsert()
    begin
        //---------GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Application Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Leave Carry Over App Nos.");
            "Application Code" := NoSeries.GetNextNo(HRSetup."Leave Carry Over App Nos.", WorkDate(), true);
        end;
        //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE LEAVE APPLICATION TABLE
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            "Employee No" := HREmp."No.";

            //---------New staff (Upon completing one year of employment)---------Changed to 3 months--------------------------

            if (HREmp."Employment Date" <> 0D) and (Today > HREmp."Employment Date") then begin
                Calendar.Reset;
                Calendar.SetRange("Period Type", Calendar."period type"::Month);
                Calendar.SetRange("Period Start", HREmp."Employment Date", Today);
                empMonths := Calendar.Count;
            end else
                empMonths := 0;

            if empMonths < 3 then Error('You cannot apply for leave carry over until your are over 3 months old in the company');
            //---------END New staff (Upon completing one year of employment)-----------------------------------

            empMonths := 0;

            HREmp.Get(HREmp."No.");
            //HREmp.CalcFields(HREmp.Picture);
            "User ID" := UserId;
        end else begin
            Error('User id' + ' ' + '[' + UserId + ']' + ' has not been assigned to any employee. Please consult the HR officer for assistance')
        end;
        //GET LEAVE APPROVER DETAILS FROM USER SETUP TABLE COPY THEM TO THE LEAVE APPLICATION TABLE
        UserSetup.Reset;
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Approver ID");
            "Application Date" := Today;
        end;
    end;

    var
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        HREmp: Record Employee;
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types.";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        LeaveGjline: Record "HR Leave Journal Batch.";
        "LineNo.": Integer;
        ApprovalComments: Record "Approval Comment Line";
        URL: Text[500];
        sDate: Record Date;
        Customized: Record "HR Leave Calendar Lines.";
        HRJournalBatch: Record "HR Leave Journal Batch.";
        TEXT001: label 'Days Approved cannot be more than applied days';
        HRLeaveEntries: Record "HR Leave Ledger Entries.";
        intEntryNo: Integer;
        Calendar: Record Date;
        empMonths: Integer;
        objLeaveApps: Record "HR Leave Application.";
        mWeekDay: Integer;
        empGender: Option Female;


    procedure NotifyApplicant()
    begin
        HREmp.Get("Employee No");

        /*
        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        HREmailParameters.RESET;
        HREmailParameters.SETRANGE(HREmailParameters."Associate With",HREmailParameters."Associate With"::"2");
        IF HREmailParameters.FIND('-') THEN
        BEGIN
        
        
             HREmp.TESTFIELD(HREmp."Company E-Mail");
             SMTP.CreateMessage(HREmailParameters."Sender Name",HREmailParameters."Sender Address",HREmp."Company E-Mail",
             HREmailParameters.Subject,'Dear'+' '+ HREmp."No." +' '+
             HREmailParameters.Body+' '+"Application Code"+' '+ HREmailParameters."Body 2",TRUE);
             SMTP.Send();
        
        
        MESSAGE('Leave applicant has been notified successfully');
        END;
        */

    end;
}

