
Page 50136 "HR Leave Calendsr."
{
    ApplicationArea = Basic;
    CardPageID = "HR Leave Calendar";
    Editable = false;
    PageType = List;
    SourceTable = "HR Leave Calendar.";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
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
        }
    }

    actions
    {
    }
}

