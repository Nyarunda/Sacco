Page 51115 "HR Shift Schedule Header List"
{
    ApplicationArea = All;
    CardPageID = "HR Shift Schedule Header Card";
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Shift Schedule Header";

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
                field(ShiftCode; Rec."Shift Code")
                {
                    ApplicationArea = Basic;
                }
                field(AssignedEmployees; Rec."Assigned Employees")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control7; Outlook)
            {
            }
            systempart(Control8; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

