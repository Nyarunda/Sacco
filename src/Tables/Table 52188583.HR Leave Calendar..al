
Table 50246 "HR Leave Calendar."
{

    fields
    {
        field(1; "Calendar Code"; Code[20])
        {

            trigger OnValidate()
            begin
                /*//Prevent Changing Calendar code once ledger entries have been posted into HR Leave Ledger
                TestNoEntriesExist_PrevRec(FIELDCAPTION("Calendar Code"));
                
                IF "Calendar Code" <> '' THEN
                HRCalendarList.RESET;
                HRCalendarList.SETRANGE(HRCalendarList.Code,xRec."Calendar Code");
                IF HRCalendarList.FIND('-') THEN HRCalendarList.DELETEALL;
                
                VALIDATE("Start Date");*/

            end;
        }
        field(2; "Created By"; Text[100])
        {
        }
        field(3; "Start Date"; Date)
        {

            trigger OnValidate()
            begin
                HRCalendarList.Reset;
                HRCalendarList.SetRange(HRCalendarList.Code, "Calendar Code");
                HRCalendarList.DeleteAll;
                if "End Date" <> 0D then Validate("End Date") else Message('Enter End Date');
            end;
        }
        field(4; "End Date"; Date)
        {

            trigger OnValidate()
            begin
                if "End Date" = 0D then begin
                    HRCalendarList.Reset;
                    HRCalendarList.SetRange(HRCalendarList.Code, "Calendar Code");
                    if HRCalendarList.Find then HRCalendarList.DeleteAll;
                end else begin
                    if "End Date" < "Start Date" then
                        Error('End Date cannot be [ %1 ] while Start Date is [ %2 ]'
                    , "End Date", "Start Date");
                    TestField("Calendar Code");
                    TestField("Start Date");

                    fnCreateLeaveCalendar;
                end;
                Message('Calendar List Updated. Please Refresh this Page (F5)');
            end;
        }
        field(5; "Current Leave Calendar"; Boolean)
        {

            trigger OnValidate()
            begin
                HRLeaveCal.Reset;
                HRLeaveCal.SetFilter(HRLeaveCal."Calendar Code", '<>%1', "Calendar Code");
                HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
                if HRLeaveCal.Find('-') then begin
                    repeat
                        HRLeaveCal."Current Leave Calendar" := false;
                        HRLeaveCal.Modify;
                    until HRLeaveCal.Next = 0;
                end;
                //to carry forward days
            end;
        }
        field(6; Description; Text[100])
        {
        }
        field(7; "Date Created"; Date)
        {
            Editable = false;
        }
        field(8; "Last Modified By"; Code[100])
        {
            Editable = false;
        }
        field(9; "Date Modified"; Date)
        {
            Editable = false;
        }
        field(10; "Monday Non Working"; Boolean)
        {
        }
        field(11; "Tuesday Non Working"; Boolean)
        {
        }
        field(12; "Wednesday Non Working"; Boolean)
        {
        }
        field(13; "Thursday Non Working"; Boolean)
        {
        }
        field(14; "Friday Non Working"; Boolean)
        {
        }
        field(15; "Saturday Non Working"; Boolean)
        {
        }
        field(16; "Sunday Non Working"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Calendar Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //IF "Current Leave Calendar" THEN ERROR('Cannot delete current leave calendar');

        //Prevent Changing Calendar code once ledger entries have been posted into HR Leave Ledger
        TestNoEntriesExist_CurrRec(FieldCaption("Calendar Code"));
    end;

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Date Created" := Today;
        "Sunday Non Working" := true;
    end;

    trigger OnModify()
    begin
        "Last Modified By" := UserId;
        "Date Modified" := Today;
    end;

    var
        HRLeaveCal: Record "HR Leave Calendar.";
        Day: Date;
        Date: Record Date;
        HRCalendarList: Record "HR Leave Calendar Lines.";
        HRLeaveLedger: Record "HR Leave Ledger Entries.";
        Text000: label 'You cannot change %1 because there are one or more ledger entries associated with this account.';

    local procedure fnCreateLeaveCalendar()
    begin
        TestField("Calendar Code");
        //TESTFIELD("Start Date");
        //TESTFIELD("End Date");

        Date.Reset;
        Date.SetRange(Date."Period Type", Date."period type"::Date);
        Date.SetRange(Date."Period Start", "Start Date", "End Date");
        if Date.Find('-') then begin
            HRCalendarList.Reset;
            HRCalendarList.SetRange(HRCalendarList.Code, "Calendar Code");
            if HRCalendarList.Find then HRCalendarList.DeleteAll;

            repeat
                HRCalendarList.Init;

                HRCalendarList.Code := "Calendar Code";
                HRCalendarList.Date := Date."Period Start";
                ;      // e.g 01-01-15
                HRCalendarList.Day := Date."Period Name";         // e.g Thursday
                HRCalendarList."Non Working" := fn_DetermineNonWorking(Date."Period Start");
                MarkWeeklyNonWorking(Date."Period Name");

                HRCalendarList.Insert;
            until Date.Next = 0;

        end else begin
            Error('Invalid Date format');
        end;
    end;

    local procedure fn_DetermineNonWorking(currDate: Date) isNonWorking: Boolean
    var
        HRNonWorkingDays: Record "HR Non Working Days & Dates.";
    begin
        isNonWorking := false;
        HRCalendarList.Reason := '';

        HRNonWorkingDays.Reset;
        if HRNonWorkingDays.Get(currDate) then begin
            isNonWorking := true;
            HRCalendarList.Reason := HRNonWorkingDays.Reason;
        end;
    end;


    local procedure MarkWeeklyNonWorking(PeriodName: Text)
    begin
        if HRCalendarList."Non Working" then
            exit;

        case PeriodName of
            'Monday':
                if "Monday Non Working" then begin
                    HRCalendarList."Non Working" := true;
                    HRCalendarList.Reason := PeriodName;
                end;
            'Tuesday':
                if "Tuesday Non Working" then begin
                    HRCalendarList."Non Working" := true;
                    HRCalendarList.Reason := PeriodName;
                end;
            'Wednesday':
                if "Wednesday Non Working" then begin
                    HRCalendarList."Non Working" := true;
                    HRCalendarList.Reason := PeriodName;
                end;
            'Thursday':
                if "Thursday Non Working" then begin
                    HRCalendarList."Non Working" := true;
                    HRCalendarList.Reason := PeriodName;
                end;
            'Friday':
                if "Friday Non Working" then begin
                    HRCalendarList."Non Working" := true;
                    HRCalendarList.Reason := PeriodName;
                end;
            'Saturday':
                if "Saturday Non Working" then begin
                    HRCalendarList."Non Working" := true;
                    HRCalendarList.Reason := PeriodName;
                end;
            'Sunday':
                if "Sunday Non Working" then begin
                    HRCalendarList."Non Working" := true;
                    HRCalendarList.Reason := PeriodName;
                end;
        end;
    end;

    procedure TestNoEntriesExist_PrevRec(CurrentFieldName: Text[100])
    var
        HRLeaveLedgerEntry: Record "HR Leave Ledger Entries.";
    begin
        //To prevent change of field once entries have been posted
        HRLeaveLedgerEntry.Reset;
        HRLeaveLedgerEntry.SetRange(HRLeaveLedgerEntry."Leave Calendar Code", xRec."Calendar Code"); //Previous Rec
        if HRLeaveLedgerEntry.Find('-') then
            Error(
              Text000,
              CurrentFieldName);
    end;


    procedure TestNoEntriesExist_CurrRec(CurrentFieldName: Text[100])
    var
        HRLeaveLedgerEntry: Record "HR Leave Ledger Entries.";
    begin
        //To prevent change of field once entries have been posted
        HRLeaveLedgerEntry.Reset;
        HRLeaveLedgerEntry.SetRange(HRLeaveLedgerEntry."Leave Calendar Code", "Calendar Code"); //Current Rec
        if HRLeaveLedgerEntry.Find('-') then
            Error(
              Text000,
              CurrentFieldName);
    end;
}

