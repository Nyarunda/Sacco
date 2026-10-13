Page 51117 "HR Shift Schedule Header Card"
{
    ApplicationArea = All;
    PageType = Document;
    SourceTable = "HR Shift Schedule Header";

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
                field(ShiftCode; Rec."Shift Code")
                {
                    ApplicationArea = Basic;
                }
                field(AssignedEmployees; Rec."Assigned Employees")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control6; "HR Shift Schedule Lines")
            {
                SubPageLink = Code = field(Code);
            }
        }
    }

    actions
    {
    }
}

