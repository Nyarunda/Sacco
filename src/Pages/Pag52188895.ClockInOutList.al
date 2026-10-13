page 50597 "Clock In/Out List"
{
    ApplicationArea = All;
    Caption = 'Clock In/Out List';
    PageType = List;
    SourceTable = "ClockIn Timesheet";
    UsageCategory = Lists;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
                field("Working Date"; Rec."Working Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Working Date field.';
                }
                field(clockIn; Rec."ClockIn")
                {
                    ApplicationArea = All;
                    Caption = 'Clock In';
                    ToolTip = 'Specifies the value of the clockIn field.';
                }

                field("ClockIn Time"; Rec."ClockIn Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the ClockIn Time field.';
                }
                field(ClockOut; Rec."Clock Out")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ClockOut field.';
                }
                field("ClockOut Time"; Rec."Clock Out Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the ClockOut Time field.';
                }
                field("Hours Worked"; Rec.Hours)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Entered By field.';
                }
                field(Week; Rec.Week)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("Timesheet")
            {
                ApplicationArea = Basic;
                Image = NewTimesheet;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                RunObject = Page "Timesheet Summary";

            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("Entered By", UserId);
        Rec.SetRange("Working Date", Today);


    end;
}
