Page 51111 "HR Emp. Login Management List"
{
    ApplicationArea = All;
    Caption = 'HR Employee Login Management List';
    CardPageID = "HR Emp. Login Management Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Employee Login Management";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(StaffNo; Rec."Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field(StaffName; Rec."Staff Name")
                {
                    ApplicationArea = Basic;
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Outlook)
            {
            }
            systempart(Control10; Notes)
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
                action(HRShiftAssignment)
                {
                    ApplicationArea = Basic;
                    Caption = 'HR Shift Assignment';
                    Image = ReopenPeriod;
                    RunObject = Page "HR Shift Assignment List";
                    RunPageLink = "Staff No." = field("Staff No.");
                }
            }
        }
    }
}

