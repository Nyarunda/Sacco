Page 51116 "HR Shift Schedule Lines"
{
    PageType = ListPart;
    SourceTable = "HR Shift Schedule Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EmployeeNo; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field(FullName; Rec."Full Name")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ClockInTime; Rec."Clock In Time")
                {
                    ApplicationArea = Basic;
                }
                field(ClockOutTime; Rec."Clock Out Time")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Line)
            {
                Caption = '&Line';
                Image = Line;
                action(SuggestParticipants)
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Participants';

                    trigger OnAction()
                    begin
                        HRShiftScheduleHeader.Reset;
                        HRShiftScheduleHeader.SetRange(HRShiftScheduleHeader.Code, Rec.Code);
                        if HRShiftScheduleHeader.Find('-') then begin
                            //HRShiftScheduleHeader.TESTFIELD(HRShiftScheduleHeader.Status,HRShiftScheduleHeader.Status::Approved);
                        end;



                        Rec.Reset;
                        Rec.SetFilter(Code, Rec.Code);
                        Report.Run(Report::"HR Suggest Participants", true, true, Rec);
                    end;
                }
            }
        }
    }

    var
        HRShiftScheduleHeader: Record "HR Shift Schedule Header";
        HRShiftScheduleLines: Record "HR Shift Schedule Lines";
}

