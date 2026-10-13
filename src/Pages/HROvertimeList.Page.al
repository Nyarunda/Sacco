Page 51092 "HR Overtime List"
{
    ApplicationArea = All;
    CardPageID = "HR Overtime Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    DelayedInsert = false;
    Editable = false;
    PageType = List;
    SourceTable = "HR Overtime Header";
    SourceTableView = where(Converted = const(false));

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
            systempart(Control6; Outlook)
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
            UserSetup.Reset();
            if not UserSetup.Get(UserId) then
                Error('User setup is missing for %1.', UserId);

            UserSetup.TestField("Staff No");

            Rec.FilterGroup(50);
            Rec.SetRange("Staff No.", UserSetup."Staff No");
            Rec.FilterGroup(0);
        end;
    end;
}
