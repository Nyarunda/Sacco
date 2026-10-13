Page 51112 "HR Emp. Login Management Card"
{
    ApplicationArea = All;
    Caption = 'HR Employee Login Management Card';
    PageType = Card;
    SourceTable = "HR Employee Login Management";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(StaffNo; Rec."Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field(StaffName; Rec."Staff Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(FingerprintID; Rec."Fingerprint ID")
                {
                    ApplicationArea = Basic;
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Username; Rec.Username)
                {
                    ApplicationArea = Basic;
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = Basic;
                }
                field(RatePerShift; Rec."Rate Per Shift")
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

