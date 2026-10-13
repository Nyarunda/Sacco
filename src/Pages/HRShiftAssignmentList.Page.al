Page 51118 "HR Shift Assignment List"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    SourceTable = "HR Shift Assignment";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ShiftCode; Rec."Shift Code")
                {
                    ApplicationArea = Basic;
                }
                field(StartDateTime; Rec."Start Date/Time")
                {
                    ApplicationArea = Basic;
                }
                field(EndDateTime; Rec."End Date/Time")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
                field(StaffNo; Rec."Staff No.")
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
            }
        }
        area(factboxes)
        {
            systempart(Control11; Outlook)
            {
            }
            systempart(Control12; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
            }
            action(ClockIn)
            {
                ApplicationArea = Basic;
                Caption = 'Clock In';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //Get Open shifts
                    HRShiftManagement.Reset;
                    HRShiftManagement.SetRange(HRShiftManagement.Status, HRShiftManagement.Status::Open);
                    if HRShiftManagement.Find('-') then begin
                        repeat
                            HRShiftManagement.CalcFields(HRShiftManagement."Assigned Employees");
                            if HRShiftManagement."Assigned Employees" > 0 then begin
                                //If Staff has been assigned this Shift
                                HRShiftScheduleLines.Reset;
                                HRShiftScheduleLines.SetRange(HRShiftScheduleLines."Shift Code", HRShiftManagement.Code);
                                if HRShiftScheduleLines.Find('-') then begin
                                    HRShiftAssignment.Reset;
                                    HRShiftAssignment.Init;
                                    HRShiftAssignment."Line No." := fnEntryNo;
                                    HRShiftAssignment."Staff No." := HRShiftScheduleLines."Employee No.";
                                    HRShiftAssignment."Clock In Time" := CreateDatetime(Today, Time);
                                    HRShiftAssignment."Clock Out Time" := CreateDatetime(0D, 0T);
                                    HRShiftAssignment."Shift Code" := HRShiftManagement.Code;
                                    HRShiftAssignment."Start Date/Time" := HRShiftManagement."Start Date/Time";
                                    HRShiftAssignment."End Date/Time" := HRShiftManagement."End Date/Time";
                                    //HRShiftAssignment."Rate Per Shift":=
                                    HRShiftAssignment."Shift Status" := HRShiftManagement.Status;

                                    HRShiftAssignment_3.Reset;
                                    HRShiftAssignment_3.SetRange(HRShiftAssignment_3."Staff No.", HRShiftAssignment."Staff No.");
                                    HRShiftAssignment_3.SetRange(HRShiftAssignment_3."Shift Code", HRShiftAssignment."Shift Code");
                                    HRShiftAssignment_3.SetFilter(HRShiftAssignment_3."Clock Out Time", '%1', CreateDatetime(0D, 0T));//Not cloked out
                                    if HRShiftAssignment_3.Find('-') then begin
                                        Error('Shift Code [ %1 ] has been assigned to Staff No. [ %2 ] '
                                              , HRShiftAssignment."Shift Code", HRShiftAssignment."Staff No.");
                                    end else begin
                                        HRShiftAssignment.Insert;
                                    end;
                                end;
                            end;
                        until HRShiftManagement.Next = 0;

                        Message('Process Complete');
                    end else begin
                        Error('No Open shifts available');
                    end;
                end;
            }
            action(ClockOut)
            {
                ApplicationArea = Basic;
                Caption = 'Clock Out';
                Image = ReopenCancelled;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    Rec."Clock Out Time" := CreateDatetime(Today, Time);
                    Rec.Duration := Rec."Clock Out Time" - Rec."Clock In Time";

                    Rec.Modify;

                    Message('Process Complete')
                end;
            }
        }
    }

    var
        HRShiftScheduleHeader: Record "HR Shift Schedule Header";
        HRShiftScheduleLines: Record "HR Shift Schedule Lines";
        HRShiftManagement: Record "HR Shift Management";
        HRShiftAssignment: Record "HR Shift Assignment";
        HRShiftAssignment_3: Record "HR Shift Assignment";

    local procedure fnEntryNo() EntryNumber: Integer
    var
        HRShiftAssignment_2: Record "HR Shift Assignment";
    begin
        HRShiftAssignment_2.Reset;
        if HRShiftAssignment_2.Find('+') then begin
            EntryNumber := HRShiftAssignment_2."Line No." + 1;
        end else begin
            EntryNumber := 1000;
        end;
    end;
}

