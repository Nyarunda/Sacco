Page 51114 "HR Shift Management Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "HR Shift Management";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
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
                field(AssignedEmployees; Rec."Assigned Employees")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
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

