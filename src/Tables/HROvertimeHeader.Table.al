Table 51123 "HR Overtime Header"
{
    DrillDownPageID = "HR Overtime List";
    LookupPageID = "HR Overtime List";

    fields
    {
        field(1; "Staff No."; Code[10])
        {
            Editable = true;
            TableRelation = Employee."No.";

            trigger OnValidate()
            var
            begin
                if "Staff No." <> xRec."Staff No." then begin
                    HREmp.Reset;
                    if HREmp.Get("Staff No.") then begin
                        "Staff Name" := HREmp.FullName;
                        "Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
                    end else begin
                        "Staff Name" := '';
                        "Global Dimension 1 Code" := '';
                        "Global Dimension 2 Code" := '';
                    end;
                    if StaffPayrollDtls.Get("Staff No.") then
                        "Basic Pay" := StaffPayrollDtls."Basic Pay";
                end;
            end;
        }
        field(2; "Staff Name"; Text[50])
        {
            Editable = false;
        }
        field(3; "Convert To?"; Option)
        {
            OptionCaption = ' ,Convert to Pay,Convert to Leave';
            OptionMembers = " ","Convert to Pay","Convert to Leave";

        }
        field(4; "Posted to Payroll"; Boolean)
        {
            Editable = false;
        }
        field(5; "Application Code"; Code[10])
        {
            Editable = false;
        }
        field(6; Status; Enum "Approval Status Enum")
        {

        }
        field(7; "No. series"; Code[10])
        {
        }
        field(8; "Weekend Hours 2"; Decimal)
        {
        }
        field(9; "Application Date"; Date)
        {
            Editable = false;
        }
        field(10; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(11; "Global Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,1,1';
            Editable = false;
        }
        field(12; "Global Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,1,2';
            Editable = false;
        }
        field(13; "WeekDay Hours"; Decimal)
        {
            CalcFormula = sum("HR Overtime Lines"."Overtime Hours" where("Application Code" = field("Application Code"),
                                                                          "Overtime Type" = filter(WeekDay)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Total Overtime Hours"; Decimal)
        {
            CalcFormula = sum("HR Overtime Lines"."Overtime Hours" where("Application Code" = field("Application Code"),
            "Overtime Type" = filter(<> " ")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; Converted; Boolean)
        {
            Editable = false;
        }
        field(16; "Date Posted"; Date)
        {
        }
        field(17; "Time Posted"; Time)
        {
        }
        field(18; "Posted By"; Code[10])
        {
        }
        field(19; "Sunday/Holiday Hours"; Decimal)
        {
            Caption = 'Holiday/Weekends Hours';
            CalcFormula = sum("HR Overtime Lines"."Overtime Hours" where("Application Code" = field("Application Code"),
                                                                          "Overtime Type" = const("Sunday/Holiday")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Extra Hours"; Decimal)
        {
            CalcFormula = sum("HR Overtime Lines"."Overtime Hours" where("Application Code" = field("Application Code"),
                                                                          "Overtime Type" = const(" ")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Basic Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "OverTime Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(24; "Approver ID"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()

            begin
                // InsertLines();
            end;
        }
        field(27; "Hours Earned"; Decimal)
        {
            Caption = 'Days Earned';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("HR Overtime Lines"."Overtime Days" where("Application Code" = field("Application Code")));
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
    var
        HROvertime: Record "HR Overtime Header";
    begin

        UserSetup.Get(UserId);
        if not UserSetup."Is HR" then begin
            HROvertime.Reset();
            HROvertime.SetRange("Created By", UserId);
            HROvertime.SetRange(Status, HROvertime.Status::Open);
            if HROvertime.FindFirst() then
                Error('Please Utilize overtime %1 before reopening another!', HROvertime."Application Code");
        end;

        if "Application Code" = '' then begin
            HRSetup.Get();
            HRSetup.TestField(HRSetup."Overtime Req Nos.");
            "Application Code" := NoSeries.GetNextNo(HRSetup."Overtime Req Nos.", WorkDate(), true);
        end;
        "Application Date" := Today;
        "Convert To?" := "Convert To?"::"Convert to Pay";
        "Created By" := UserId;
        "Responsibility Center" := UserSetup."Responsibility Center";

        HREmp.RESET;
        HREmp.SETRANGE(HREmp."User ID", USERID);
        IF HREmp.FIND('-') THEN BEGIN
            Validate("Staff No.", HREmp."No.");
        END;

        if UserSetup.Get(UserId) then
            "Responsibility Center" := UserSetup."Responsibility Center";

    end;

    local procedure InsertLines()
    var
        SystemCalendar: Record Date;
        HROvertimeLines: Record "HR Overtime Lines";
    begin
        HROvertimeLines.RESET;
        HROvertimeLines.SetRange("Application Code", "Application Code");
        if HROvertimeLines.Find() then HROvertimeLines.DELETEALL;

        SystemCalendar.RESET;
        SystemCalendar.SETRANGE("Period Type", SystemCalendar."Period Type"::Date);
        SystemCalendar.SETRANGE("Period Start", "Start Date", "End Date");
        IF NOT SystemCalendar.FINDFIRST THEN ERROR('Invalid Date format');
        REPEAT
            HROvertimeLines.INIT;
            HROvertimeLines."Line No." := 0;
            HROvertimeLines."Staff No." := "Staff No.";
            // HROvertimeLines.Day := SystemCalendar."Period Name";
            HROvertimeLines.Date := SystemCalendar."Period Start";
            HROvertimeLines.Validate(HROvertimeLines.Date);
            HROvertimeLines."Application Code" := Rec."Application Code";

            HROvertimeLines.INSERT;
        UNTIL SystemCalendar.NEXT = 0;
    end;


    var
        HREmp: Record Employee;
        StaffPayrollDtls: Record "Staff Payroll Details";
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
        OT: Record "HR Overtime Header";
        UserSetup: Record "User Setup";
        HrLeavePeriods: Record "HR Leave Periods.";
        LeaveGjline: Record "HR Leave Journal Line.";
        "LineNo.": Integer;
        "Days Applied": Decimal;
        "Amount Earned": Decimal;


    procedure "Convert Overtime"()
    begin
    end;

    procedure "Convert To Payroll"()
    begin
    end;

    procedure CalculateOverTime() OverTimeAmountEarned: Decimal;
    var
        HROvertimeLines: Record "HR Overtime Lines";
        FactorToUse: Decimal;
        HROvertimeRates: Record "HR Overtime Rates";
        LineAmt: Decimal;
        OvertimeHrs: Decimal;
        HoursEarned: Decimal;
    begin
        HRSetup.Get();

        HROvertimeRates.Reset();
        HROvertimeRates.SetRange("Conversion Type", Rec."Convert To?");
        if not HROvertimeRates.FindFirst() then
            Error('Overtime rates have not been set up for conversion type %1.', Format(Rec."Convert To?"));

        OverTimeAmountEarned := 0;
        "Hours Earned" := 0;

        HROvertimeLines.Reset();
        HROvertimeLines.SetRange("Application Code", Rec."Application Code");
        HROvertimeLines.SetFilter("Overtime Type", '<>%1', HROvertimeLines."Overtime Type"::" ");
        if HROvertimeLines.FindFirst() then
            repeat
                if Rec."Convert To?" = Rec."Convert To?"::"Convert to Leave" then begin

                    if HROvertimeLines."Overtime Type" = HROvertimeLines."Overtime Type"::"Sunday/Holiday" then
                        FactorToUse := HROvertimeRates."Holiday/Sunday Hours Rate" // 4.00
                    else
                        FactorToUse := HROvertimeRates."WeekDay Hours Rate"; // 5.00

                    if FactorToUse = 0 then
                        Error(
                            'Leave conversion factor cannot be zero for overtime type %1 and conversion type %2.',
                            Format(HROvertimeLines."Overtime Type"),
                            Format(Rec."Convert To?"));

                    HoursEarned := Round(HROvertimeLines."Overtime Hours" / FactorToUse, 1, '=');

                    Rec."Hours Earned" += HoursEarned;

                    HROvertimeLines."Overtime Days" += HoursEarned;
                    HROvertimeLines.Modify(true);
                end else begin

                    if HROvertimeLines."Overtime Type" = HROvertimeLines."Overtime Type"::"Sunday/Holiday" then
                        FactorToUse := HROvertimeRates."Holiday/Sunday Hours Rate" // 2.00
                    else
                        FactorToUse := HROvertimeRates."WeekDay Hours Rate"; // 1.50

                    if FactorToUse = 0 then
                        Error(
                            'Pay conversion rate cannot be zero for overtime type %1 and conversion type %2.',
                            Format(HROvertimeLines."Overtime Type"),
                            Format(Rec."Convert To?"));

                    if HROvertimeLines."Overtime Hours" >= 9 then
                        OvertimeHrs := Round(HROvertimeLines."Overtime Hours", 0.01, '=') - 1
                    else
                        OvertimeHrs := Round(HROvertimeLines."Overtime Hours", 0.01, '=');

                    LineAmt := OvertimeHrs * (("Basic Pay" / 22) / 8) * FactorToUse;

                    OverTimeAmountEarned += LineAmt;

                    HROvertimeLines."OverTime Amount" := LineAmt;
                    HROvertimeLines.Modify(true);
                end;
            until HROvertimeLines.next() = 0;

    end;

    procedure PostPayToLeave()
    var
        HRLeaveCal: Record "HR Leave Calendar.";
        HRJournalBatch: Record "HR Leave Journal Batch.";
        HRJournalLine: Record "HR Leave Journal Line.";
        LineNo: Integer;
        LeaveDaysEarned: Decimal;
    begin
        TestField("Application Code");
        TestField("Staff No.");
        TestField("Convert To?", "Convert To?"::"Convert to Leave");

        if Converted then
            Error('Overtime application %1 has already been converted/posted.', "Application Code");

        if Status <> Status::Approved then
            Error('Only approved overtime applications can be posted to leave.');

        HasValidLines();

        // Recalculate leave earned before posting.
        //CalculateOverTime();
        Rec.CalcFields("Hours Earned");

        LeaveDaysEarned := Rec."Hours Earned";

        if LeaveDaysEarned <= 0 then
            Error('There are no leave days/hours earned to post for overtime application %1.', "Application Code");

        // Get current leave calendar.
        HRLeaveCal.Reset();
        HRLeaveCal.SetRange("Current Leave Calendar", true);
        if not HRLeaveCal.FindFirst() then
            Error('No current leave calendar has been set up.');

        // Get leave posting setup.
        HRSetup.Get();
        HRSetup.TestField("Default Leave Posting Template");
        HRSetup.TestField("Negative Leave Posting Batch");

        HRJournalBatch.Get(
            HRSetup."Default Leave Posting Template",
            HRSetup."Negative Leave Posting Batch");

        // Clear existing journal lines in this batch.
        HRJournalLine.Reset();
        HRJournalLine.SetRange("Journal Template Name", HRSetup."Default Leave Posting Template");
        HRJournalLine.SetRange("Journal Batch Name", HRSetup."Negative Leave Posting Batch");
        if HRJournalLine.FindSet() then
            HRJournalLine.DeleteAll();

        LineNo := 1000;

        HRJournalLine.Init();
        HRJournalLine."Journal Template Name" := HRSetup."Default Leave Posting Template";
        HRJournalLine."Journal Batch Name" := HRSetup."Negative Leave Posting Batch";
        HRJournalLine."Line No." := LineNo;
        HRJournalLine."Leave Calendar Code" := HRLeaveCal."Calendar Code";
        HRJournalLine."Document No." := "Application Code";
        HRJournalLine."Staff No." := "Staff No.";
        HRJournalLine.Validate("Staff No.");
        HRJournalLine."Leave Type" := 'ANNUAL';
        HRJournalLine."Posting Date" := Today;

        // Positive entry because overtime converted to leave increases leave balance.
        HRJournalLine."Leave Entry Type" := HRJournalLine."Leave Entry Type"::Positive;

        HRJournalLine."Leave Approval Date" := Today;
        HRJournalLine.Description := CopyStr('Overtime converted to leave [' + "Application Code" + ']', 1, MaxStrLen(HRJournalLine.Description));

        // IMPORTANT:
        // Replace this with the correct leave type field/setup in your database if required.
        // Example if you have setup field:
        // HRSetup.TestField("Overtime Leave Type");
        // HRJournalLine."Leave Type" := HRSetup."Overtime Leave Type";

        HRJournalLine."Leave Period Start Date" := HRLeaveCal."Start Date";
        HRJournalLine."Leave Period End Date" := HRLeaveCal."End Date";
        HRJournalLine."No. of Days" := LeaveDaysEarned;
        HRJournalLine.Insert(true);

        HRJournalLine.Reset();
        HRJournalLine.SetRange("Journal Template Name", HRSetup."Default Leave Posting Template");
        HRJournalLine.SetRange("Journal Batch Name", HRSetup."Negative Leave Posting Batch");

        if HRJournalLine.FindFirst() then
            Codeunit.Run(Codeunit::"HR Leave Jnl.-Post", HRJournalLine);

        Converted := true;
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := CopyStr(UserId, 1, MaxStrLen("Posted By"));
        Modify(true);

        Message(
            'Overtime application %1 has been posted to leave successfully. Leave earned: %2.',
            "Application Code",
            LeaveDaysEarned);
    end;

    procedure HasValidLines()
    var
        HROvertimeLines: Record "HR Overtime Lines";
    begin
        HROvertimeLines.Reset();
        HROvertimeLines.SetRange("Application Code", Rec."Application Code");
        HROvertimeLines.SetFilter("Overtime Hours", '>0');
        HROvertimeLines.FindFirst();

        repeat
            HROvertimeLines.TestField("Overtime Type");
            HROvertimeLines.TestField("Start Time");
            HROvertimeLines.TestField("End Time");
            HROvertimeLines.TestField("Work Done");
        until HROvertimeLines.Next() = 0;
    end;
}
