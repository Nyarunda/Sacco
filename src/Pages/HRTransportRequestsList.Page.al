Page 50951 "HR Transport Requests List"
{
    ApplicationArea = All;
    CardPageID = "HR Staff Transport Requisition";
    Editable = false;
    PageType = List;
    SourceTable = "HR Transport Requisition Head";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(TransportRequestNo; Rec."Transport Request No")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(JobTitle; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field(DaysApplied; Rec."Days Applied")
                {
                    ApplicationArea = Basic;
                }
                field(Supervisor; Rec.Supervisor)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755004; Outlook)
            {
            }
            systempart(Control1102755006; Notes)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(TransportRequests)
            {
                ApplicationArea = Basic;
                Caption = 'Transport Requests';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Transport Requisitions";
            }
        }
    }
}

