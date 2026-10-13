Table 51124 "HR Overtime Lines"
{

    fields
    {
        field(1; "Staff No."; Code[10])
        {
        }
        field(2; Date; Date)
        {
            trigger OnValidate()
            var
                D: Record Date;
            begin
                "Overtime Type" := "Overtime Type"::WeekDay;
                // D.Reset();
                // D.SetRange("Period Start", Date);
                // D.SetRange("Period Type", D."Period Type"::Date);
                // if D.FindFirst() then
                //     if D."Period Name" = 'Sunday' then
                //         "Overtime Type" := "Overtime Type"::"Sunday/Holiday";


                //Non working day that are holidays
                if NonWorkingDay(Date) then "Overtime Type" := "Overtime Type"::"Sunday/Holiday";

            end;
        }
        field(3; "Start Time"; Time)
        {

            trigger OnValidate()
            var
                OvertimeLn: Record "HR Overtime Lines";
                HROvertimeHdr: Record "HR Overtime Header";
                errOvertime: Label 'You already have an overtime set for the specified time and date';
                HRSetup: Record "HR Setup.";
                ErrHours: Label 'Weekday overtime cannot start within normal working hours %1 to %2.';
            begin
                if "End Time" <> 0T then begin
                    fnCalculateEndTime;

                    OvertimeLn.Reset();
                    OvertimeLn.SetRange(Date, Date);
                    OvertimeLn.SetRange("Staff No.", "Staff No.");
                    OvertimeLn.SetRange("Start Time", "Start Time", "End Time");
                    if OvertimeLn.FindFirst() then begin
                        HROvertimeHdr.Reset();
                        HROvertimeHdr.SetRange("Application Code", OvertimeLn."Application Code");
                        HROvertimeHdr.SetFilter(Status, '<>%1', HROvertimeHdr.Status::Rejected);
                        if HROvertimeHdr.FindFirst() then
                            Error(errOvertime);
                    end;


                end;

                if "Overtime Type" = "Overtime Type"::WeekDay then begin
                    HRSetup.Get();
                    if (HRSetup."Opening Hours" <> 0T) and
                       (HRSetup."Closing Hours" <> 0T) and
                       ("Start Time" >= HRSetup."Opening Hours") and
                       ("Start Time" < HRSetup."Closing Hours")
                    then
                        Error(ErrHours, HRSetup."Opening Hours", HRSetup."Closing Hours");
                end;

            end;
        }
        field(4; "End Time"; Time)
        {

            trigger OnValidate()
            begin
                if "Start Time" <> 0T then begin
                    fnCalculateEndTime;
                end;
            end;
        }
        field(5; "Work Done"; Text[150])
        {
        }
        field(6; "Application Code"; Code[10])
        {
        }
        field(13; "Overtime Type"; Option)
        {
            OptionCaption = ' ,Holiday/Weekends,WeekDay';
            OptionMembers = " ","Sunday/Holiday","WeekDay";
            Editable = false;
        }
        field(14; "Overtime Hours"; Decimal)
        {
            Editable = false;
        }
        field(15; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(16; "OverTime Amount"; Decimal)
        {
            Editable = false;
        }
        field(17; Day; Text[30])
        {
            Editable = false;
        }
        field(18; "Overtime Days"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Line No.", "Application Code")
        {
            Clustered = true;
        }
        key(Key2; "Overtime Type", "Line No.")
        {
            SumIndexFields = "Overtime Hours";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()

    begin
        if HROvertime.Get("Application Code") then begin
            HROvertime.TestField("Staff No.");
            "Staff No." := HROvertime."Staff No.";
        end;

    end;

    var
        HROvertimeDetails: Record "HR Overtime Lines";
        HROvertime: Record "HR Overtime Header";
        Text0001: label '[End Time %1 ] CANNOT be less than the [Start Time %2]';

    local procedure fnCalculateEndTime()
    var
        HROvertimeHdr: Record "HR Overtime Header";
        HRSetup: Record "HR Setup.";
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        OvertimeDate: Date;
        EffectiveEndTime: Time;
        ErrOpeningHours: Label 'For weekday overnight overtime, End Time cannot be later than Opening Hours of %1.';
        ErrEndWithinWorkingHours: Label 'Weekday overtime cannot end within normal working hours %1 to %2.';
    begin

        OvertimeDate := Date;
        if OvertimeDate = 0D then
            OvertimeDate := WorkDate();

        EffectiveEndTime := "End Time";
        //if "Overtime Type" <> "Overtime Type"::"Sunday/Holiday" then begin
        HRSetup.Get();
        if ("End Time" < "Start Time") and (HRSetup."Opening Hours" <> 0T) and ("End Time" > HRSetup."Opening Hours") then
            Error(ErrOpeningHours, HRSetup."Opening Hours");
        if ("Overtime Type" = "Overtime Type"::WeekDay) and
           (HRSetup."Opening Hours" <> 0T) and
           (HRSetup."Closing Hours" <> 0T) and
           ("End Time" > HRSetup."Opening Hours") and
           ("End Time" <= HRSetup."Closing Hours")
        then
            Error(ErrEndWithinWorkingHours, HRSetup."Opening Hours", HRSetup."Closing Hours");
        //end;

        StartDateTime := CreateDateTime(OvertimeDate, "Start Time");
        if EffectiveEndTime < "Start Time" then
            EndDateTime := CreateDateTime(CalcDate('1D', OvertimeDate), EffectiveEndTime)
        else
            EndDateTime := CreateDateTime(OvertimeDate, EffectiveEndTime);

        "Overtime Hours" := (EndDateTime - StartDateTime) / 3600000;

        if ("Overtime Hours" < 1) then
            Error('You can only apply overtime, for at least an hour!')

    end;

    local procedure NonWorkingDay(Var TheDate: Date) isnonworking: Boolean
    var
        LeaveCalendarLines: Record "HR Leave Calendar Lines.";
    begin
        LeaveCalendarLines.RESET;
        LeaveCalendarLines.SETRANGE("Non Working", TRUE);
        LeaveCalendarLines.SETRANGE(LeaveCalendarLines.Date, TheDate);
        //LeaveCalendarLines.SetFilter(Day, '<>%1', 'Saturday');
        if LeaveCalendarLines.FindFirst() then
            exit(true);
    end;
}
