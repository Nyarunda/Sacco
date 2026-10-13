Table 51016 "HR Leave Planner Header"
{
    LookupPageId = "HR Leave Planner List";
    DrillDownPageId = "HR Leave Planner List";
    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;
            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if No <> xRec.No then begin
                    HRSetup.Get;
                    NoSeries.TestManual(HRSetup."Leave Planner Nos.");
                    "No series" := '';
                end;
            end;
        }
        field(2; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            editable = false;
            trigger OnValidate()
            begin
                HrEmp.Reset();
                HREmp.SetRange("No.", "Employee No");
                if HREmp.FindFirst() then begin
                    "Employee No" := HREmp."No.";
                    "Employee Name" := HREmp.FullName();
                    "Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
                    Supervisor := HREmp."Supervisor Code";
                    "Date of Employment" := HREmp."Employment Date";
                    "Employee User ID" := HREmp."User ID";
                end;
                GetLeaveBalance('ANNUAL');
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;


        }
        field(4; "Job ID"; Code[60])
        {
            Editable = true;
        }
        field(5; "Job Description"; Text[250])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("HR Jobs"."Job Description" where("Job ID" = field("Job ID")));
        }
        field(6; "Department"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Departments";
        }
        field(7; "Date of Employment"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; Status; Enum "Approval Status Enum")
        {
            Editable = false;
        }

        field(9; "No series"; Code[30])
        {
        }
        field(10; "Document Date"; Date)
        {
        }
        field(11; Supervisor; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }

        field(12; Year; Integer)
        {
        }
        field(13; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                /*
                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.",1);
                DimVal.SETRANGE(DimVal.Code,"Global Dimension 1 Code");
                 IF DimVal.FIND('-') THEN
                    "Function Name":=DimVal.Name;
                 UpdateLines;
                 */

            end;
        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin

                /*DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SETRANGE(DimVal.Code,"Shortcut Dimension 2 Code");
                 IF DimVal.FIND('-') THEN
                    "Budget Center Name":=DimVal.Name ;
                UpdateLines
                */

            end;
        }

        field(18; "Document Type"; Enum "Approval Document Type")
        {
        }
        field(19; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Leave Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Employee User ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Employee Name") { }
    }

    trigger OnInsert()
    begin

        //No. Series
        if No = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Leave Planner Nos.");
            HRSetup.TestField("Leave Plan Min Days Allowed");
            HRSetup.TestField("Leave Plan Application Month");
            No := NoSeries.GetNextNo(HRSetup."Leave Planner Nos.", WorkDate(), true);
        end;
        Year := Date2DMY(Today, 3);
        if Date2DMY(Today, 2) <> HRSetup."Leave Plan Application Month" then begin
            LeavePlannerMonthName := Format(DMY2Date(1, HRSetup."Leave Plan Application Month", Date2DMY(Today, 3)), 0, '<Month Text>');
            CurrentMonthName := Format(Today, 0, '<Month Text>');
            Error('You are only allowed to plan for your leave on %1.', LeavePlannerMonthName);
        end;



        "Created By" := UserId;
        HrEmp.Reset();
        HREmp.SetRange("User ID", UserId);
        if HREmp.FindFirst() then begin
            "Employee No" := HREmp."No.";
            "Employee Name" := HREmp.FullName();
            "Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
            "Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
            Supervisor := HREmp."Supervisor Code";
            "Job ID" := HREmp."Job ID";
            "Job Description" := HREmp."Job Description";
            Department := HREmp.Department;
        end;

        GetLeaveBalance('ANNUAL');

        if UserSetup.Get(UserId) then begin
            "Responsibility Center" := UserSetup."Responsibility Center";
        end;
    end;

    procedure GetLeaveBalance(LeaveType: Text[50])
    var
        "Allocated Days": Decimal;
        "Earned Days": Decimal;
        "Re-Imbursed Days": Decimal;
        "Total Leave Days": Decimal;
        "Total Taken": Decimal;
        "Days Taken": Decimal;
    begin
        LeaveStatsMgt.GetLeaveStatistics(
            "Employee No",
            LeaveType,
            "Allocated Days",
            "Earned Days",
            "Re-Imbursed Days",
            "Total Leave Days",
            "Total Taken",
            "Leave Balance",
            "Days Taken");
    end;


    procedure ValidateLeavePlanApplication()
    var
        HRLeavePlannerLines: Record "HR Leave Planner Lines";
    begin
        HRSetup.Get();
        HRSetup.TestField("Leave Plan Min Days Allowed");
        HRLeavePlannerLines.Reset();
        HRLeavePlannerLines.SetRange("Leave Planner No", Rec.No);
        HRLeavePlannerLines.SetFilter("No of Days", '>=%1', HRSetup."Leave Plan Min Days Allowed");
        if not HRLeavePlannerLines.FindFirst() then
            Error('At least one entry on your leave plan should contain a minimum of %1 days', HRSetup."Leave Plan Min Days Allowed");

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
        ////SMTP: Codeunit UnknownCodeunit400;
        LeaveGjline: Record "HR Leave Journal Line.";
        "LineNo.": Integer;
        ApprovalComments: Record "Approval Comment Line";
        URL: Text[500];
        sDate: Record Date;
        //Customized: Record UnknownRecord39003946;
        //HREmailParameters: Record UnknownRecord39003942;
        HRJournalBatch: Record "HR Leave Journal Batch.";
        DimVal: Record "Dimension Value";

        LeavePlannerMonthName: Text;
        CurrentMonthName: Text;
        LeaveStatsMgt: Codeunit "HR Leave Statistics Mgt.";
}

