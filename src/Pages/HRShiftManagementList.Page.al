Page 51113 "HR Shift Management List"
{
    ApplicationArea = All;
    CardPageID = "HR Shift Management Card";
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Shift Management";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
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
                field(ShiftType; Rec."Shift Type")
                {
                    ApplicationArea = Basic;
                }
                field(ShiftPattern; Rec."Shift Pattern")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control12; Outlook)
            {
            }
            systempart(Control13; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

