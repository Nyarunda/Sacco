Page 51091 "HR Overtime List - Converted"
{
    ApplicationArea = All;
    CardPageID = "HR Overtime Card - Approved";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Overtime Header";
    SourceTableView = where(Converted = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ApplicationCode; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(StaffName; Rec."Staff Name")
                {
                    ApplicationArea = Basic;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = Basic;
                }
                field(TotalOvertimeHours; Rec."Total Overtime Hours")
                {
                    ApplicationArea = Basic;
                }
                field(ConvertTo; Rec."Convert To?")
                {
                    ApplicationArea = Basic;
                }
                field(Converted; Rec.Converted)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1; Outlook)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        HRSetup: Record "HR Setup.";
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Is HR", true);
        if UserSetup.IsEmpty() then begin
            Rec.FilterGroup(50);
            Rec.SetFilter("Created By", UserId);
            Rec.FilterGroup(0);
        end;
    end;
}

