Page 51088 "HR Overtime Lines"
{
    PageType = ListPart;
    SourceTable = "HR Overtime Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;

                }

                field(OvertimeType; Rec."Overtime Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Overtime Type (When Applying)';

                }
                field(StartTime; Rec."Start Time")
                {
                    ApplicationArea = Basic;
                }
                field(EndTime; Rec."End Time")
                {
                    ApplicationArea = Basic;
                }
                field(WorkDone; Rec."Work Done")
                {
                    ApplicationArea = Basic;
                }
                field(OvertimeHours; Rec."Overtime Hours")
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

