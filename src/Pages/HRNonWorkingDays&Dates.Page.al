Page 50925 "HR Non Working Days & Dates"
{
    Caption = 'HR Non Working Dates';
    PageType = ListPart;
    SourceTable = "HR Non Working Days & Dates";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = Basic;
                }
                field(Recurring; Rec.Recurring)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        DayOfWeek_Visible: Boolean;
        DateVisible: Boolean;
        HRCalendar: Record "HR Leave Calendar.";
        ReasonVisible: Boolean;
}

