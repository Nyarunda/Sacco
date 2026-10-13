
Page 50134 "HR Leave Calendar"
{
    PageType = Card;
    SourceTable = "HR Leave Calendar.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(CalendarCode; Rec."Calendar Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(StartDate; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(CurrentLeaveCalendar; Rec."Current Leave Calendar")
                {
                    ApplicationArea = Basic;
                }
                field(DateCreated; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field(LastModifiedBy; Rec."Last Modified By")
                {
                    ApplicationArea = Basic;
                }
                field(DateModified; Rec."Date Modified")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Weekly Non Working Days")
            {
                field(MondayNonWorking; Rec."Monday Non Working")
                {
                    ApplicationArea = Basic;
                }
                field(TuesdayNonWorking; Rec."Tuesday Non Working")
                {
                    ApplicationArea = Basic;
                }
                field(WednesdayNonWorking; Rec."Wednesday Non Working")
                {
                    ApplicationArea = Basic;
                }
                field(ThursdayNonWorking; Rec."Thursday Non Working")
                {
                    ApplicationArea = Basic;
                }
                field(FridayNonWorking; Rec."Friday Non Working")
                {
                    ApplicationArea = Basic;
                }
                field(SaturdayNonWorking; Rec."Saturday Non Working")
                {
                    ApplicationArea = Basic;
                }
                field(SundayNonWorking; Rec."Sunday Non Working")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control2; "HR Non Working Days & Dates")
            {
                ApplicationArea = Basic;
                //SubPageLink = Code = field("Calendar Code");
            }
            part(Control3; "HR Leave Calendar Lines")
            {
                ApplicationArea = Basic;
                SubPageLink = Code = field("Calendar Code");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreateCalendar)
            {
                ApplicationArea = Basic;
                Caption = 'Create Calendar';
                Image = CalculateCalendar;
                Promoted = true;
                PromotedCategory = Category6;

                trigger OnAction()
                begin
                    Rec.TestField("Calendar Code");
                    Rec.TestField("Start Date");
                    Rec.TestField("End Date");

                    if Confirm('Generate Calendar [%1]', false, Rec."Calendar Code") = true then begin
                        Date.Reset;
                        Date.SetRange(Date."Period Type", Date."period type"::Date);
                        Date.SetRange(Date."Period Start", Rec."Start Date", Rec."End Date");
                        if Date.Find('-') then begin
                            HRCalendarList.Reset;
                            HRCalendarList.SetRange(Code, Rec."Calendar Code");
                            HRCalendarList.DeleteAll;

                            repeat
                                HRCalendarList.Init;

                                HRCalendarList.Code := Rec."Calendar Code";
                                HRCalendarList.Date := Date."Period Start";
                                // e.g 01-01-15
                                HRCalendarList.Day := Date."Period Name";
                                // e.g Thursday
                                HRCalendarList."Non Working" := fn_DetermineNonWorking(Date."Period Start");
                                MarkWeeklyNonWorking(Date."Period Name");

                                HRCalendarList.Insert;
                            until Date.Next = 0;
                            Message('Process complete');
                        end else begin
                            Error('Invalid Date format');
                        end;
                    end else begin
                        //Creation aborted
                        exit;
                    end;

                end;
            }
        }
    }

    var
        Day: Date;
        Date: Record Date;
        HRCalendarList: Record "HR Leave Calendar Lines.";

    local procedure MarkWeeklyNonWorking(PeriodName: Text)
    begin
        if HRCalendarList."Non Working" then
            exit;

        case PeriodName of
            'Monday':
                if Rec."Monday Non Working" then begin
                    HRCalendarList."Non Working" := true;
                    HRCalendarList.Reason := PeriodName;
                end;
            'Tuesday':
                if Rec."Tuesday Non Working" then begin
                    HRCalendarList."Non Working" := true;
                    HRCalendarList.Reason := PeriodName;
                end;
            'Wednesday':
                if Rec."Wednesday Non Working" then begin
                    HRCalendarList."Non Working" := true;
                    HRCalendarList.Reason := PeriodName;
                end;
            'Thursday':
                if Rec."Thursday Non Working" then begin
                    HRCalendarList."Non Working" := true;
                    HRCalendarList.Reason := PeriodName;
                end;
            'Friday':
                if Rec."Friday Non Working" then begin
                    HRCalendarList."Non Working" := true;
                    HRCalendarList.Reason := PeriodName;
                end;
            'Saturday':
                if Rec."Saturday Non Working" then begin
                    HRCalendarList."Non Working" := true;
                    HRCalendarList.Reason := PeriodName;
                end;
            'Sunday':
                if Rec."Sunday Non Working" then begin
                    HRCalendarList."Non Working" := true;
                    HRCalendarList.Reason := PeriodName;
                end;
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
}

